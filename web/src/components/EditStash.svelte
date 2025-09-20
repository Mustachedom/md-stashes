<script lang="ts">
   import { fetchNui } from '../utils/fetchNui';
   import { visibility, editMenu, editable, language } from '../store/stores';
  let selectedIndex = -1;

  function selectItem(index) {
    selectedIndex = index;
  }

  function handleSubmit() {
    if (selectedIndex >= 0) {
      visibility.set(true);
      editMenu.set(false);
      editable.set($editable[selectedIndex]);
      fetchNui('editStash', $editable[selectedIndex]);
    }
  }

  function changeLocation() {
    if (selectedIndex >= 0) {
      fetchNui('changeLocation', $editable[selectedIndex]);
      visibility.set(false);
      editMenu.set(false);
    }
  }

  function parse(data) {
     try {
      return data ? JSON.parse(data) : null;
    } catch (e) {
      console.warn("Failed to parse JSON:", data, e);
      return null;
    }
  }

  function deleteStash() {
    if (selectedIndex >= 0) {
      fetchNui('deleteStash', $editable[selectedIndex]);
      visibility.set(false);
      editMenu.set(false);
    }
  }
  function gotoLoc() {
    if (selectedIndex >= 0) {
      fetchNui('gotoLoc', $editable[selectedIndex]);
      visibility.set(false);
      editMenu.set(false);
    }
  }
</script>


{#if $editMenu}
  <div class="menu-container">
    <div class="header">
      <h2 class="title">{ $language.Ui.edit.header }</h2>
    </div>

    <div class="object-list">
      {#each $editable as item, index}
        <div 
          class="object-item" 
          class:selected={selectedIndex === index}
          on:click={() => selectItem(index)}
          role="button"
          tabindex="0"
          on:keydown={(e) => (e.key === 'Enter' || e.key === ' ') && selectItem(index)}
        >
          <div class="item-header">
            <span class="item-name">{item.name}</span>
            <span class="item-id">{ $language.Ui.edit.id }: {item.id}</span>
            <span class="item-type">
              {#if parse(item.data).object !== false || parse(item.data).object === null}
                {$language.Ui.edit.obj}
              {:else}
                {$language.Ui.edit.coords}
              {/if}
            </span>
          </div>
          <div class="item-location">
            vector3({parse(item.loc).x}, {parse(item.loc).y}, {parse(item.loc).z})
          </div>
        </div>
      {/each}
    </div>

    <div class="action-buttons">
      <button class="action-btn" on:click={deleteStash}>{$language.Ui.edit.del}</button>
      <button class="action-btn" on:click={gotoLoc}>{$language.Ui.edit.go2}</button>
      <button class="action-btn" on:click={changeLocation} disabled={selectedIndex < 0}>
        {$language.Ui.edit.changeLoc}
      </button>
      <button class="action-btn primary" on:click={handleSubmit} disabled={selectedIndex < 0}>
        {$language.Ui.edit.edit}
      </button>
    </div>
  </div>
{/if}

<style>
  .menu-container {
    max-width: 480px;
    background: #1a1a1a;
    border-radius: 6px;
    border: 1px solid #333;
    color: #fff;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
    overflow: hidden;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
  }

  .header {
    padding: 20px;
    border-bottom: 1px solid #333;
  }

  .title {
    margin: 0;
    font-size: 18px;
    font-weight: 600;
    color: #fff;
  }

  .object-list {
    max-height: 400px;
    overflow-y: auto;
  }

  .object-item {
    padding: 16px 20px;
    cursor: pointer;
    transition: background-color 0.15s ease;
    border-bottom: 1px solid #2a2a2a;
  }

  .object-item:hover {
    background: #222;
  }

  .object-item.selected {
    background: #2a2a2a;
    border-left: 3px solid #fff;
  }

  .object-item:last-child {
    border-bottom: none;
  }

  .item-header {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 8px;
    flex-wrap: wrap;
  }

  .item-name {
    font-weight: 500;
    color: #fff;
  }

  .item-id,
  .item-type {
    font-size: 12px;
    color: #ffffff;
    background: #2a2a2a;
    padding: 2px 8px;
    border-radius: 4px;
  }

  .item-location {
    font-size: 13px;
    color: #ffffff;
  }

  .action-buttons {
    padding: 20px;
    display: flex;
    gap: 8px;
    flex-wrap: wrap;
  }

  .action-btn {
    padding: 10px 16px;
    border: 1px solid #444;
    border-radius: 4px;
    background: #2a2a2a;
    color: #ccc;
    font-size: 14px;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.15s ease;
  }

  .action-btn:hover:not(:disabled) {
    background: #333;
    border-color: #555;
    color: #fff;
  }

  .action-btn.primary {
    background: #333;
    border-color: #555;
  }

  .action-btn.primary:hover:not(:disabled) {
    background: #333;
    border-color: #555;
    color: #fff;
  }

  .action-btn:disabled {
    opacity: 0.5;
    cursor: not-allowed;
  }

  .object-list::-webkit-scrollbar {
    width: 6px;
  }

  .object-list::-webkit-scrollbar-track {
    background: #1a1a1a;
  }

  .object-list::-webkit-scrollbar-thumb {
    background: #444;
    border-radius: 3px;
  }

  .object-list::-webkit-scrollbar-thumb:hover {
    background: #555;
  }
</style>