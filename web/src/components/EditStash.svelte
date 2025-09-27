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
      <button class="btn" on:click={deleteStash}>{$language.Ui.edit.del}</button>
      <button class="btn" on:click={gotoLoc}>{$language.Ui.edit.go2}</button>
      <button class="btn" on:click={changeLocation} disabled={selectedIndex < 0}>
        {$language.Ui.edit.changeLoc}
      </button>
      <button class="btn primary" on:click={handleSubmit} disabled={selectedIndex < 0}>
        {$language.Ui.edit.edit}
      </button>
    </div>
  </div>
{/if}
