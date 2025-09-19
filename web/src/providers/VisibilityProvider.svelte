<script lang="ts">
  import { useNuiEvent } from '../utils/useNuiEvent';
  import { fetchNui } from '../utils/fetchNui';
  import { onMount } from 'svelte';
  import { visibility, config, language,firstMenu, editMenu, editable, defaults } from '../store/stores';
  import SelectMenu from '../components/SelectMenu.svelte';
  import EditStash from '../components/EditStash.svelte';
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
    editMenu.set(true);
    editable.set(data);
  });
  useNuiEvent<any>('setEditable', (data) => {
    visibility.set(true);
  });
  
  onMount(async () => {
    let data = await fetchNui('initUi');
    config.set(data.Config);
    language.set(data.lang);
    defaults.set(data.defaults);
    const keyHandler = (e: KeyboardEvent) => {
      if (['Escape'].includes(e.code)) {
        fetchNui('hideUI');
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
  {#if isVisible}
    <slot />
  {/if}
  {#if $firstMenu}
    <SelectMenu />
  {/if}
  {#if $editMenu}
    <EditStash />
  {/if}
</main>
