<script lang="ts">
  import { config, language } from '../store/stores';
  import { fetchNui } from '../utils/fetchNui';
  import { firstMenu } from '../store/stores';
  import { ChevronDown } from 'lucide-svelte';

  let selectedOption = '';
  let selectedObject = '';
  
  function handleSubmit() {
    let data;
    if (selectedOption === 'coords') {
      data = { type: 'coords', object: false };
    } else if (selectedOption === 'object') {
      data = { type: 'object', object: selectedObject };
    }
    if (data) {
      fetchNui('submitSelection', data);
      firstMenu.set(false);
      fetchNui('hideUI');
    }
  }
  function handleCancel() {
    selectedOption = '';
    selectedObject = '';
  }
</script>

<div class="menu-container">
  <div class="menu-header">
    <h2 class="menu-title">{ $language.Ui.select.header }</h2>
  </div>
  
  <div class="form-container">
    <div class="form-group">
      <label for="main-option" class="form-label">Select Creation Type</label>
      <select
        id="main-option"
        bind:value={selectedOption}
        class="form-select"
      >
        <option value="" disabled selected>{ $language.Ui.select.option1head }</option>
        <option value="coords">{ $language.Ui.select.option1coords }</option>
        <option value="object">{ $language.Ui.select.option1object }</option>
      </select>
      <ChevronDown class="chevron-icon" size={16} />
    </div>

    {#if selectedOption === 'object'}
      <div class="form-group">
        <label for="object-option" class="form-label">{ $language.Ui.select.objHead }</label>
        <select
          id="object-option"
          bind:value={selectedObject}
          class="form-select"
        >
          <option value="" disabled selected>{ $language.Ui.select.objDesc }</option>
          {#each $config as item}
            <option value={item.value}>{item.label}</option>
          {/each}
        </select>
        <ChevronDown class="chevron-icon" size={16} />
      </div>
    {/if}
  </div>

  {#if selectedOption}
    <div class="button-group">
      <button on:click={handleCancel} class="btn decline">{ $language.Ui.select.cancel }</button>
      <button
        on:click={handleSubmit}
        class="btn confirm"
        disabled={selectedOption === 'object' && !selectedObject}
      >
        { $language.Ui.select.submit }
      </button>
    </div>
  {/if}
</div>

<style>
  .menu-container {
    min-width: 400px;
    width: max-content;
  }

  .form-select {
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    padding-right: 40px;
  }

  .form-group {
    position: relative;
  }

  :global(.chevron-icon) {
    position: absolute;
    right: 12px;
    top: 70%;
    transform: translateY(-50%);
    color: #666;
    pointer-events: none;
  }
</style>