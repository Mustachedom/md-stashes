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
    <div class="menu-header">
      <h2 class="menu-title">{ $language.Ui.edit.header }</h2>
    </div>

    <div class="item-list">
      {#each $editable as item, index}
        <div 
          class="list-item" 
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

    <div class="button-group">
      <button class="btn decline" on:click={deleteStash}>{$language.Ui.edit.del}</button>
      <button class="btn confirm" on:click={gotoLoc}>{$language.Ui.edit.go2}</button>
      <button class="btn confirm" on:click={changeLocation} disabled={selectedIndex < 0}>
        {$language.Ui.edit.changeLoc}
      </button>
      <button class="btn confirm" on:click={handleSubmit} disabled={selectedIndex < 0}>
        {$language.Ui.edit.edit}
      </button>
    </div>
  </div>
{/if}

<style>
  .item-list {
    max-height: 400px;
    overflow-y: auto;
  }

  .item-list::-webkit-scrollbar {
    width: 6px;
  }

  .item-list::-webkit-scrollbar-track {
    background: #1a1a1a;
  }

  .item-list::-webkit-scrollbar-thumb {
    background: #444;
    border-radius: 3px;
  }

  .item-list::-webkit-scrollbar-thumb:hover {
    background: #555;
  }

  .list-item {
    padding: 16px 20px;
    cursor: pointer;
    transition: background-color 0.15s ease;
    border-bottom: 1px solid #2a2a2a;
  }

  .list-item:hover {
    background: #222;
  }

  .list-item.selected {
    background: #2a2a2a;
    border-left: 3px solid #fff;
  }

  .list-item:last-child {
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

  .item-id, .item-type {
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
</style>