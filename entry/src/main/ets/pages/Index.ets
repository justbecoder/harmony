
import { RankData } from '../viewmodel/RankData'
import { RankViewModel } from  '../viewmodel/RankViewModel'
import { TitleComponent } from  '../view/TitleComponent'
import { ListHeaderComponent } from  '../view/ListHeaderComponent'
import { ListItemComponent } from '../view/ListItemComponent'
import prompt from '@ohos.promptAction'
import AppContext from '@ohos.app.ability.common'

import { APP_EXIT_INTERVAL, Style, TIME, TITLE, WEIGHT } from '../common/Constants'
import router from '@ohos.router'


let rankModel: RankViewModel = new RankViewModel();

@Entry
@Component
struct Index {
  @State dataSource1: RankData[] = [];
  @State dataSource2: RankData[] = [];

  @State isSwitchDataSource: boolean = true;
  @State clickBackTimeRecord: number = 0;

  aboutToAppear() {
    this.dataSource1 = rankModel.loadRankDataSource1();
    this.dataSource2 = rankModel.loadRankDataSource2();
  }

  onBackPress() {
    if (this.isShowToast()) {
      prompt.showToast({
        message: $r('app.string.prompt_text'),
        duration: TIME
      })

      this.clickBackTimeRecord = new Date().getTime()
      return true;
    }

    return false;
  }

  isShowToast(): boolean {
    return new Date().getTime() - this.clickBackTimeRecord > APP_EXIT_INTERVAL
  }

  build() {
    Column() {
      TitleComponent({
        isRefresh: $isSwitchDataSource,
        title: TITLE
      })
      ListHeaderComponent({
        paddingValue: {
          left: Style.RANK_PADDING,
          right: Style.RANK_PADDING
        },
        widthValue: Style.CONTENT_WIDTH
      })
        .margin({
          top: Style.HEADER_MARGIN_TOP,
          bottom: Style.HEADER_MARGIN_BOTTOM
        })
      this.RankList(Style.CONTENT_WIDTH)
      Button("Go Todo")
        .margin({
          top: 20
        })
        .fontSize(20)
        .onClick(() => {
          router.pushUrl({
            url: 'pages/Todo'
          })
        })
    }
    .backgroundColor($r('app.color.background'))
    .height(WEIGHT)
    .width(WEIGHT)
  }

  @Builder RankList (widthValue: Length) {
    Column() {
      List() {
        ForEach(this.isSwitchDataSource ? this.dataSource1 : this.dataSource2,
          (item: RankData, index?: number) => {
            ListItem() {
              ListItemComponent({
                index: (Number(index) + 1),
                isSwitchDataSource: this.isSwitchDataSource,
                name: item.name,
                vote: item.vote
              })
            }
          },
          (item: RankData) => JSON.stringify(item)
        )
      }
      .width(WEIGHT)
      .height(Style.LIST_HEIGHT)
      .divider({
        strokeWidth: Style.STROKE_WIDTH
      })
    }
    .padding({
      left: Style.RANK_PADDING,
      right: Style.RANK_PADDING
    })
    .width(widthValue)
    .borderRadius(Style.BORDER_RADIUS)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(Color.White)
  }
}