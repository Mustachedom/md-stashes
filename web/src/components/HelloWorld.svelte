<script lang="ts">
  import { fetchNui } from '../utils/fetchNui';
  import { visibility, language, editMenu, editable, defaults } from '../store/stores';
   import { useNuiEvent } from '../utils/useNuiEvent';

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


  <div class="container">
    <div class="header">
      <h1>{header}</h1>
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
                  class="array-input"
                />
                <button 
                  type="button" 
                  class="add-btn" 
                  on:click={() => addToArray(item)}
                  disabled={!item.value || item.value.trim() === ''}
                  title="Add item"
                >
                  <span>+</span>
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
              <input 
                type="number" 
                bind:value={item.value} 
                placeholder={item.default}
                class="number-input"
                min="0"
              />
            {:else}
              <input 
                type="text" 
                bind:value={item.value} 
                placeholder={item.default || `Enter ${item.label.toLowerCase()}`}
                class="text-input"
              />
            {/if}
          </div>
        {/if}
      {/each}
    </div>

    <div class="button-container">
      <button type="button" class="reset-btn" on:click={resetForm} disabled={isSubmitting}>{$language.Ui.create.reset}</button>
      <button type="button" class="submit-btn" on:click={handleSubmit} disabled={isSubmitting}>{$language.Ui.create.submit}</button>
    </div>
  </div>

<style>
  .container {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    position: absolute;
    color: white;
    width: 420px;
    max-height: 90vh;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: #121212;
    border-radius: 16px;
    padding: 0;
    box-sizing: border-box;
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3), 0 0 0 1px rgba(255, 255, 255, 0.1);

    overflow: hidden;
  }

  .header {
    background: #121212;
    padding: 24px;
    text-align: center;
    position: relative;
  }

  .header h1 {
    margin: 0;
    font-size: 24px;
    font-weight: 700;
    text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
  }

  .form-content {
    padding: 24px;
    max-height: calc(90vh - 200px);
    overflow-y: auto;
  }

  .field-container {
    margin-bottom: 24px;
  }

  .field-label {
    display: flex;
    align-items: center;
    margin-bottom: 8px;
    font-weight: 600;
    font-size: 14px;
    color: #e2e8f0;
  }

  .array-input-container {
    display: flex;
    gap: 8px;
    align-items: stretch;
    margin-bottom: 12px;
  }

  input {
    padding: 12px 16px;
    background: rgba(255, 255, 255, 0.1);
    border: 2px solid rgba(255, 255, 255, 0.15);
    color: white;
    border-radius: 8px;
    font-size: 14px;
    transition: all 0.3s ease;
    outline: none;
  }

  input:focus {
    border-color: #ffffff;
    background: #494949;
    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.2);
  }

  input::placeholder {
    color: rgb(255, 254, 254);
  }

  .array-input {
    flex: 1;
  }

  .text-input,
  .number-input {
    width: 100%;
    box-sizing: border-box;
  }

  .add-btn {
    background: #494949;
    color: white;
    border: none;
    border-radius: 8px;
    width: 44px;
    height: 44px;
    cursor: pointer;
    font-size: 20px;
    font-weight: bold;
    display: flex;
    align-items: center;
    justify-content: center;
  }


  .array-values {
    display: flex;
    flex-wrap: wrap;
    gap: 8px;
    margin-top: 8px;
  }

  .array-item {
    background: linear-gradient(135deg, #2a2a3a, #3a3a4a);
    border: 1px solid rgba(255, 255, 255, 0.2);
    border-radius: 20px;
    padding: 8px 14px;
    display: flex;
    align-items: center;
    gap: 8px;
    cursor: pointer;
    transition: all 0.3s ease;
    user-select: none;
    font-size: 13px;
  }
  .array-text {
    font-weight: 500;
  }

  .delete-icon {
    font-size: 18px;
    font-weight: bold;
    opacity: 0.7;
    transition: opacity 0.2s;
  }

  .array-item:hover .delete-icon {
    opacity: 1;
  }

  .button-container {
    padding: 12px;
    background: rgba(0, 0, 0, 0.2);
    display: flex;
    gap: 12px;
    border-top: 1px solid rgba(255, 255, 255, 0.1);
  }

  .reset-btn {
    flex: 1;
    padding: 12px 24px;
    background: rgba(255, 255, 255, 0.1);
    border: 2px solid rgba(255, 255, 255, 0.2);
    color: white;
    border-radius: 8px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
  }

  .submit-btn {
    flex: 2;
    padding: 12px 24px;
    background: rgba(255, 255, 255, 0.1);
    border: 2px solid rgba(255, 255, 255, 0.2);
    color: white;
    border-radius: 8px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
  }


  .spinner {
    width: 16px;
    height: 16px;
    border: 2px solid rgba(255, 255, 255, 0.3);
    border-top: 2px solid white;
    border-radius: 50%;
    animation: spin 1s linear infinite;
  }

  .form-content::-webkit-scrollbar {
    display: none;
  }
</style>