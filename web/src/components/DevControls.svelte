<script lang="ts">
  import { debugData } from '../utils/debugData';
  import { mockStashData } from '../utils/mockData';

  function showSelectMenu() {
    debugData([
      { action: 'setVisible', data: true },
      { action: 'firstMenu', data: true }
    ], 100);
  }
  
  function showEditMenu() {
    debugData([
      { action: 'setVisible', data: true },
      { action: 'editMenu', data: mockStashData }
    ], 100);
  }
  
  function showCreateStash() {
    debugData([
      { action: 'firstMenu', data: false },
      { action: 'editMenu', data: false }
    ], 50);
    
    setTimeout(() => {
      debugData([{ action: 'setVisible', data: true }], 10);
    }, 150);
  }
  
  function hideAll() {
    debugData([
      { action: 'setVisible', data: false },
      { action: 'firstMenu', data: false },
      { action: 'editMenu', data: false }
    ], 100);
  }
</script>

<div class="dev-controls">
  <h4>Dev Controls</h4>
  <button class="btn confirm" on:click={showCreateStash}>Create Stash</button>
  <button class="btn confirm" on:click={showSelectMenu}>Select Stash Type</button>
  <button class="btn confirm" on:click={showEditMenu}>Edit Stash</button>
  <button class="btn decline" on:click={hideAll}>Hide All</button>
</div>

<style>
  .dev-controls {
    position: fixed;
    top: 10px;
    right: 10px;
    background: #1a1a1a;
    border-radius: 16px;
    border: 1px solid #ccc;
    padding: 15px;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    color: white;
  }

  .dev-controls h4 {
    margin: 0 0 10px 0;
    text-align: center;
  }

  .dev-controls .btn {
    display: block;
    width: 100%;
    margin-bottom: 5px;
  }
</style>