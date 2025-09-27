<script lang="ts">
  import VisibilityProvider from './providers/VisibilityProvider.svelte';
  import CreateStash from './components/CreateStash.svelte';
  import { initDevEnvironment } from './utils/mockData';
  import './styles/global.css';

  initDevEnvironment();
</script>

<main>
  <VisibilityProvider>
    <CreateStash />
  </VisibilityProvider>
</main>