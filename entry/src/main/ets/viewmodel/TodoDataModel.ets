import CommonConstants  from '../common/TodoConstants'

export class TodoDataModel {
  private tasks: Array<string> = CommonConstants.TODO_DATA

  getData(): Array<string>{
    return this.tasks
  }
}

export default new TodoDataModel()