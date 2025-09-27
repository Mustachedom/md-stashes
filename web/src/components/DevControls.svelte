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
  <button on:click={showCreateStash} style="background: #0c336d;">Create Stash</button>
  <button on:click={showSelectMenu} style="background: #0c336d;">Select Menu</button>
  <button on:click={showEditMenu} style="background: #0c336d">Edit Stash</button>
  <button on:click={hideAll} style="background: #0c336d">Hide All</button>
</div>

<style>
  .dev-controls {
    position: fixed;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    color: white;
    top: 10px;
    right: 10px;
    background: #121212;
    border-radius: 16px;
    border: 1px solid #ccc;
    padding: 10px;
  }

  .dev-controls h4 {
    margin: 0 0 10px 0;
    text-align: center;
  }

  .dev-controls button {
    display: block;
    width: 100%;
    color: white;
    background: rgba(255, 255, 255, 0.1);
    border: 2px solid rgba(255, 255, 255, 0.2);
    border-radius: 8px;
    margin-bottom: 5px;
    padding: 12px 24px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
  }
</style>