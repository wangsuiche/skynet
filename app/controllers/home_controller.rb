# coding: utf-8
class HomeController < ApplicationController
  #before_filter :auth_user!

  @@api_port     = "api_index.cgi"
  def getVoc(act, params=nil)
    return get_voc(@@api_port, act, params)['arts']
  end

  def weiboList
    #get weibo_list
    @weibo_list = getVoc('get_wb_list')
    puts_to_yaml(@weibo_list, "weibo_list")
    
    respond_to do |format|
      format.json { render json: @weibo_list }
    end
  end

  #舆情
  def weibo_yq
    act         = 'get_yq_list'
    @weibo_yq   = getVoc(act)
    puts_to_yaml(@weibo_yq, "weibo_yq")

    respond_to do |format|
      format.json { render json: @weibo_yq}
    end
  end

  #预警
  def weibo_yj
    
    act         = 'get_yj_list'
    @weibo_yj   = getVoc(act)
    puts_to_yaml(@weibo_yj, "weibo_yj")

    respond_to do |format|
      format.json { render json: @weibo_yj}
    end
  end

  def weiboTable
    #微博舆情
    #0为正面微博，1为负面微博，2为最热传播，3为最热评论，缺省为0
    act         = 'get_wb_yq'
    @weiboTable = []
    @weiboTable[0] = getVoc(act, "index=0")
    @weiboTable[1] = getVoc(act, "index=1")
    @weiboTable[2] = getVoc(act, "index=2")
    @weiboTable[3] = getVoc(act, "index=3")
    puts_to_yaml(@weiboTable, "weiboTable")  

    respond_to do |format|
      format.json { render json: @weiboTable}
    end  
  end

  def realTimeChart
    #图表部分
    #[动态趋势图]
    act = 'get_dtqs_list'
    @realTimeChart =  getVoc(act)
    puts_to_yaml(@realTimeChart, "realTimeChartBlock")

    respond_to do |format|
      format.json { render json: @realTimeChart}
    end  
  end

  def realTimeChartTitle
    #动态趋势图，title部分
    act = 'get_tit_num'
    @realTimeChartTitle = getVoc(api_port, act)
    puts_to_yaml(@realTimeChartTitle, "realTimeChartTitle")
    
    respond_to do |format|
      format.json { render json: @realTimeChartTitle}
    end
  end

  def qbdx_today
    #[全部调性]
    #date 整型，值为 1：当天，2：昨天，15：15天，缺省为1。
    act = 'get_dx'
    @qbdx_today      = getVoc(act, "date=1")
    puts_to_yaml(@qbdx_today, "qbdx_today")
    respond_to do |format|
      format.json { render json: @qbdx_today}
    end
  end

  def qbdx_yesterday
    act = 'get_dx'
    @qbdx_yesterday  = getVoc(act, "date=2")
    puts_to_yaml(@qbdx_yesterday, "qbdx_yesterday")
    
    respond_to do |format|
      format.json { render json: @qbdx_yesterday}
    end
  end

  def qbdx_15days
    act = 'get_dx'
    @qbdx_15days     = getVoc(act, "date=15")
    puts_to_yaml(@qbdx_15days, "qbdx_15days")
    respond_to do |format|
      format.json { render json: @qbdx_15days}
    end
  end

  def media_today
    act = 'get_media_kind'
    @media_kind_today      = getVoc(act, "date=1")
    puts_to_yaml(@media_kind_today, "media_kind_today")
    respond_to do |format|
      format.json { render json: @media_kind_today}
    end
  end

  def media_yesterday
    act = 'get_media_kind'
    @media_kind_today      = getVoc(act, "date=2")
    puts_to_yaml(@media_kind_today, "media_kind_yesterday")
    respond_to do |format|
      format.json { render json: @media_kind_today}
    end
  end

  def media_15days
    act = 'get_media_kind'
    @media_kind_today      = getVoc(act, "date=15")
    puts_to_yaml(@media_kind_today, "media_kind_15days")
    respond_to do |format|
      format.json { render json: @media_kind_today}
    end
  end

  def top10_today
    act = 'get_web_top10'
    @top10_today     = getVoc(act, "date=1")
    puts_to_yaml(@top10_today, "top10_today")
    respond_to do |format|
      format.json { render json: @top10_today}
    end    
  end

  def top10_yesterday
    act = 'get_web_top10'
    @top10_today     = getVoc(act, "date=1")
    puts_to_yaml(@top10_today, "top10_today")
    respond_to do |format|
      format.json { render json: @top10_today}
    end    
  end

  def top10_15days
    act = 'get_web_top10'
    @top10_today     = getVoc(act, "date=1")
    puts_to_yaml(@top10_today, "top10_today")
    respond_to do |format|
      format.json { render json: @top10_today}
    end    
  end

  def index
    if !session[:current_user]

    else
      @weibo_list = get_yaml("weibo_list")
      
      @weibo_yq   = get_yaml("weibo_yq")
      
      @weibo_yj   = get_yaml("weibo_yj")
      
      @weiboTable = get_yaml("weiboTable")
      
      gon.realTimeChartBlock = get_yaml("realTimeChartBlock")     
      gon.realTimeChartTitle = get_yaml("realTimeChartTitle")
     
      gon.qbdx_today = get_yaml("qbdx_today")
      gon.qbdx_yesterday = get_yaml("qbdx_yesterday")
      gon.qbdx_15days = get_yaml("qbdx_15days")

      gon.media_kind_today = get_yaml("media_kind_today")
      gon.media_kind_yesterday = get_yaml("media_kind_yesterday")
      gon.media_kind_15days = get_yaml("media_kind_15days")

      gon.top10_today = get_yaml("top10_today")
      gon.top10_yesterday = get_yaml("top10_yesterday")
      gon.top10_15days = get_yaml("top10_15days")
    end
  end

  

  private

end
