<script lang="ts">
  import { fetchNui } from '../utils/fetchNui';
  import { visibility, language, editMenu, editable, defaults } from '../store/stores';
  import { Plus, ChevronUp, ChevronDown } from 'lucide-svelte';

  interface StashField {
    handle: string;
    label: string;
    array: boolean;
    default: any;
    type?: string;
    value?: any;
    arrayValues?: string[];
    icon?: string;
  }

  let header = $language.Ui.create.header;
  let isSubmitting = false;

  let stashData: StashField[] = [
    { handle: 'name',       label: $language.Ui.create.name,      array: false, default: 'my_stash', value: ''},
    { handle: 'job',        label: $language.Ui.create.job,       array: true,  default: false, value: '', arrayValues: []},
    { handle: 'jobRank',    label: $language.Ui.create.jobRank,   array: false, type: 'number', default: 0, value: ''},
    { handle: 'gang',       label: $language.Ui.create.gang,      array: true, default: false, value: '', arrayValues: []},
    { handle: 'gangRank',   label: $language.Ui.create.gangRank,  array: false, type: 'number', default: 0, value: ''},
    { handle: 'item',       label: $language.Ui.create.item,      array: true, default: false, value: '', arrayValues: []},
    { handle: 'identifier', label: $language.Ui.create.identifier,array: true, default: false, value: '', arrayValues: []},
    { handle: 'maxWeight',  label: $language.Ui.create.weight,    array: false, type: 'number', default: $defaults.maxWeight, value: ''},
    { handle: 'slots',      label: $language.Ui.create.slots,     array: false, type: 'number', default: $defaults.slots, value: ''},
    { handle: 'password',   label: $language.Ui.create.password,  array: false, default: false, value: ''},
  ];

  function addToArray(item: StashField) {
    if (item.value && item.value.trim() !== '') {
      if (!item.arrayValues) {
        item.arrayValues = [];
      }
      item.arrayValues.push(item.value.trim());
      item.value = '';
      stashData = [...stashData];
    }
  }

  function removeFromArray(item: StashField, index: number) {
    if (item.arrayValues) {
      item.arrayValues.splice(index, 1);
      stashData = [...stashData];
    }
  }

  function incrementValue(item: StashField) {
    const currentValue = parseInt(item.value) || 0;
    item.value = (currentValue + 1).toString();
    stashData = [...stashData];
  }

  function decrementValue(item: StashField) {
    const currentValue = parseInt(item.value) || 0;
    if (currentValue > 0) {
      item.value = (currentValue - 1).toString();
      stashData = [...stashData];
    }
  }

  function handleKeyPress(event: KeyboardEvent, item: StashField) {
    if (event.key === 'Enter') {
      addToArray(item);
    }
  }

  async function handleSubmit() {
    isSubmitting = true;
    const formData: any = {};
    stashData.forEach(field => {
      if (field.array) {
        if (!field.arrayValues || field.arrayValues.length === 0) {
          formData[field.handle] = false;
        } else {
          formData[field.handle] = field.arrayValues;
        }
      } else {
        if (field.type === 'number') {
          formData[field.handle] = field.value ? Number(field.value) : Number(field.default);
        } else {
          formData[field.handle] = field.value || field.default;
        }
      }
    });
    if ($editable) {
      await fetchNui('saveEdit', {form: formData, id: $editable});
      resetForm();
      editMenu.set(false);
      visibility.set(false);
      editable.set(null);
    } else {
      await fetchNui('createStash', formData);
    }
    visibility.set(false);
    isSubmitting = false;
  }

  function resetForm() {
    stashData.forEach(field => {
      field.value = '';
      field.arrayValues = [];
    });
    stashData = [...stashData];
  }

  function getJobArray() {
    return stashData.find(item => item.handle === 'job');
  }

  function getGangArray() {
    return stashData.find(item => item.handle === 'gang');
  }

  $: if ($editable) {
    loadEditData($editable);
  }
  function loadEditData(editableData: any) {
  try {
    const stashConfig = typeof editableData.data === 'string'
      ? JSON.parse(editableData.data)
      : editableData.data || {};

    const loc = typeof editableData.loc === 'string'
      ? JSON.parse(editableData.loc)
      : editableData.loc || {};

    stashData.forEach(field => {
      if (field.handle === 'name') {
        field.value = editableData.name || field.default;
        return;
      }
      if (field.handle === 'maxWeight' && stashConfig.weight !== undefined) {
        field.value = stashConfig.weight;
        return;
      }
      if (field.handle === 'slots' && stashConfig.slots !== undefined) {
        field.value = stashConfig.slots;
        return;
      }
      if (field.handle === 'password') {
        field.value = stashConfig.password === false ? '' : stashConfig.password;
        return;
      }
      if (field.array && stashConfig[field.handle] !== undefined) {
        if (Array.isArray(stashConfig[field.handle])) {
          field.arrayValues = [...stashConfig[field.handle]];
        } else if (stashConfig[field.handle] === false) {
          field.arrayValues = [];
        }
        return;
      }
      if (!field.array && stashConfig[field.handle] !== undefined) {
        field.value = stashConfig[field.handle];
        return;
      }
      field.value = field.default;
      if (field.array) field.arrayValues = [];
    });
    stashData = [...stashData];
  } catch (e) {
    console.error('Failed to parse editable data:', e);
  }
}
</script>


  <div class="menu-container">
    <div class="menu-header">
      <h2 class="menu-title">{header}</h2>
    </div>
    <div class="form-content">
      {#each stashData as item (item.handle)}
        {#if (item.handle === 'jobRank' && (!getJobArray()?.arrayValues || getJobArray()?.arrayValues?.length === 0)) || (item.handle === 'gangRank' && (!getGangArray()?.arrayValues || getGangArray()?.arrayValues?.length === 0))}
        {:else}
          <div class="field-container">
            <label class="field-label">
              {item.label}
            </label>
          
            {#if item.array}
              <div class="array-input-container">
                <input 
                  type="text" 
                  bind:value={item.value} 
                  placeholder={item.default || `Add ${item.label.toLowerCase()}`}
                  on:keypress={(e) => handleKeyPress(e, item)}
                  class="form-input array-input"
                />
                <button 
                  type="button" 
                  class="add-btn" 
                  on:click={() => addToArray(item)}
                  disabled={!item.value || item.value.trim() === ''}
                  title="Add item"
                >
                  <Plus size={18} />
                </button>
              </div>

              {#if item.arrayValues && item.arrayValues.length > 0}
                <div class="array-values">
                  {#each item.arrayValues as value, index}
                    <div class="array-item" on:click={() => removeFromArray(item, index)} title="Click to remove">
                      <span class="array-text">{value}</span>
                      <span class="delete-icon">×</span>
                    </div>
                  {/each}
                </div>
              {/if}
            {:else if item.type === 'number'}
              <div class="number-input-container">
                <input 
                  type="number" 
                  bind:value={item.value} 
                  placeholder={item.default}
                  class="form-input number-input"
                  min="0"
                />
                <div class="number-controls">
                  <button type="button" class="number-btn" on:click={() => incrementValue(item)}>
                    <ChevronUp size={14} />
                  </button>
                  <button type="button" class="number-btn" on:click={() => decrementValue(item)}>
                    <ChevronDown size={14} />
                  </button>
                </div>
              </div>
            {:else}
              <input 
                type="text" 
                bind:value={item.value} 
                placeholder={item.default || `Enter ${item.label.toLowerCase()}`}
                class="form-input"
              />
            {/if}
          </div>
        {/if}
      {/each}
    </div>

    <div class="button-group">
      <button type="button" class="btn decline" on:click={resetForm} disabled={isSubmitting}>{$language.Ui.create.reset}</button>
      <button type="button" class="btn confirm" on:click={handleSubmit} disabled={isSubmitting}>{$language.Ui.create.submit}</button>
    </div>
  </div>

<style>
  .menu-container {
    max-width: 800px;
    width: 400px;
  }

  .form-content {
    max-height: 700px;
    overflow-y: auto;
    padding: 0;
  }

  .form-content::-webkit-scrollbar {
    width: 6px;
  }

  .form-content::-webkit-scrollbar-track {
    background: #1a1a1a;
  }

  .form-content::-webkit-scrollbar-thumb {
    background: #444;
    border-radius: 3px;
  }

  .form-content::-webkit-scrollbar-thumb:hover {
    background: #555;
  }

  .field-container {
    padding: 16px 20px;
    border-bottom: 1px solid #2a2a2a;
  }

  .field-container:last-child {
    border-bottom: none;
  }

  .field-label {
    display: block;
    margin-bottom: 8px;
    font-size: 14px;
    font-weight: 500;
    color: #fff;
  }

  .array-input-container {
    display: flex;
    gap: 8px;
    align-items: stretch;
    margin-bottom: 12px;
  }

  .array-input {
    flex: 1;
  }

  .add-btn {
    background: #2a2a2a;
    color: #ccc;
    border: 1px solid #444;
    border-radius: 4px;
    width: 44px;
    height: 44px;
    cursor: pointer;
    font-size: 18px;
    font-weight: bold;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.15s ease;
  }

  .add-btn:hover:not(:disabled) {
    background: #333;
    border-color: #555;
    color: #fff;
  }

  .add-btn:disabled {
    opacity: 0.5;
    cursor: not-allowed;
  }

  .array-values {
    display: flex;
    flex-wrap: wrap;
    gap: 6px;
    margin-top: 8px;
  }

  .array-item {
    background: #2a2a2a;
    border: 1px solid #444;
    border-radius: 4px;
    padding: 4px 8px;
    display: flex;
    align-items: center;
    gap: 6px;
    cursor: pointer;
    transition: all 0.15s ease;
    font-size: 12px;
    color: #ccc;
  }

  .array-item:hover {
    background: #333;
    border-color: #555;
    color: #fff;
  }

  .array-text {
    font-weight: 400;
  }

  .delete-icon {
    font-size: 14px;
    font-weight: bold;
    opacity: 0.7;
  }

  .array-item:hover .delete-icon {
    opacity: 1;
  }

  .number-input-container {
    position: relative;
    display: flex;
    align-items: center;
  }

  .number-input {
    appearance: none;
    -webkit-appearance: none;
    -moz-appearance: textfield;
    padding-right: 32px;
    position: relative;
    z-index: 1;
  }

  .number-input::-webkit-outer-spin-button,
  .number-input::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
  }

  .number-controls {
    position: absolute;
    right: 1px;
    top: 1px;
    bottom: 1px;
    display: flex;
    flex-direction: column;
    gap: 1px;
    border-left: 1px solid #444;
    align-items: center;
    justify-content: center;
    background: inherit;
    z-index: 2;
  }

  .number-btn {
    background: transparent;
    border: none;
    border-radius: 3px;
    width: 24px;
    height: 20px;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #ccc;
    transition: all 0.15s ease;
  }

  .number-btn:hover {
    background: #333;
    color: #fff;
  }

  .number-btn:active {
    background: #1a1a1a;
  }
</style>