<script lang="ts">
  import { useNuiEvent } from '../utils/useNuiEvent';
  import { fetchNui } from '../utils/fetchNui';
  import { onMount } from 'svelte';
  import { visibility, config, language,firstMenu, editMenu, editable, defaults } from '../store/stores';
  import SelectMenu from '../components/SelectMenu.svelte';
  import EditStash from '../components/EditStash.svelte';
  import { isEnvBrowser } from '../utils/misc';
  import CreateStash from '../components/CreateStash.svelte';
  let isVisible: boolean;

  visibility.subscribe((visible) => {
    isVisible = visible;
  });

  useNuiEvent<boolean>('setVisible', (visible) => {
    visibility.set(visible);
  });

  useNuiEvent<any>('firstMenu', () => {
    firstMenu.set(true);
  });

  useNuiEvent<any>('editMenu', (data) => {
    if (data === false) {
      editMenu.set(false);
      editable.set(null);
    } else {
      editMenu.set(true);
      editable.set(data);
    }
  });

  useNuiEvent<any>('setEditable', (data) => {
    visibility.set(true);
  });
  
  onMount(async () => {
    if (!isEnvBrowser()) {
      try {
        let data = await fetchNui('initUi');
        config.set(data.Config);
        language.set(data.lang);
        defaults.set(data.defaults);
      } catch (error) {
        console.warn('Failed to fetch UI data from NUI (expected in browser mode):', error);
      }
    }
    
    const keyHandler = (e: KeyboardEvent) => {
      if (['Escape'].includes(e.code)) {
        if (!isEnvBrowser()) {
          fetchNui('hideUI');
        }
        visibility.set(false);
        firstMenu.set(false);
        editMenu.set(false);
        editable.set(null);
      }
    };

    window.addEventListener('keydown', keyHandler);

    return () => window.removeEventListener('keydown', keyHandler);
  });
</script>

<main>
  {#if $visibility}
    <CreateStash />
  {/if}
  {#if $firstMenu}
    <SelectMenu />
  {/if}
  {#if $editMenu}
    <EditStash />
  {/if}
</main>
