Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E3D459BD6
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 06:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhKWFou (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 00:44:50 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:13087 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbhKWFot (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Nov 2021 00:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637646102; x=1669182102;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=do2mX1IYLdhTF85SRnI3fSCwd5EsDMDOd+Ow9oL3y1k=;
  b=twXjnC5IHFM6hf5YItopIbbFoQFfHTuBebdD1oIrdfibzfiJ+SOjKIW+
   dr1G9MvF4Dsrhk9WxV89vSD2jMm/nz5poUJH9yue89K2sfKW+5mIUS3x0
   XrN8TSQognQJhZezGlpgeGHIrYu2uty7Dj1J7MYf3UJoYmdQeDwUx/P7f
   g=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 22 Nov 2021 21:41:41 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 21:41:40 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 22 Nov 2021 21:41:39 -0800
Received: from [10.216.52.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 22 Nov
 2021 21:41:30 -0800
Subject: Re: [PATCH V2 3/3] thermal: qcom: add support for PMIC5 Gen2 ADCTM
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>, <mka@chromium.org>,
        <robh+dt@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <manivannan.sadhasivam@linaro.org>,
        <linus.walleij@linaro.org>, <quic_kgunda@quicinc.com>,
        <quic_aghayal@quicinc.com>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <quic_subbaram@quicinc.com>,
        <jic23@kernel.org>, <Jonathan.Cameron@huawei.com>,
        <amitk@kernel.org>, Thara Gopinath <thara.gopinath@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-arm-msm-owner@vger.kernel.org>, <linux-iio@vger.kernel.org>
References: <1635264275-12530-1-git-send-email-quic_jprakash@quicinc.com>
 <1635264275-12530-4-git-send-email-quic_jprakash@quicinc.com>
 <e4099135-d453-3f16-5330-1925d38617aa@linaro.org>
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
Message-ID: <67505d1d-7058-820b-d08e-48795306e044@quicinc.com>
Date:   Tue, 23 Nov 2021 11:11:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <e4099135-d453-3f16-5330-1925d38617aa@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Dmitry,

On 10/27/2021 8:04 AM, Dmitry Baryshkov wrote:
> On 26/10/2021 19:04, Jishnu Prakash wrote:
>> Add support for PMIC5 Gen2 ADC_TM, used on PMIC7 chips. It is a
>> close counterpart of PMIC7 ADC and has the same functionality as
>> PMIC5 ADC_TM, for threshold monitoring and interrupt generation.
>> It is present on PMK8350 alone, like PMIC7 ADC and can be used
>> to monitor up to 8 ADC channels, from any of the PMIC7 PMICs
>> having ADC on a target, through PBS(Programmable Boot Sequence).
>>
>> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
>> ---
>>   drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 418 
>> +++++++++++++++++++++++++++++--
>>   1 file changed, 399 insertions(+), 19 deletions(-)
>>
>>       unsigned int        hw_settle_time;
>> +    unsigned int        decimation;    /* For Gen2 ADC_TM */
>> +    unsigned int        avg_samples;    /* For Gen2 ADC_TM */
>> +    bool            high_thr_en;        /* For Gen2 ADC_TM */
>> +    bool            low_thr_en;        /* For Gen2 ADC_TM */
>> +    bool            meas_en;        /* For Gen2 ADC_TM */
>>       struct iio_channel    *iio;
>>       struct adc_tm5_chip    *chip;
>>       struct thermal_zone_device *tzd;
>> @@ -123,9 +201,12 @@ struct adc_tm5_channel {
>>    * @channels: array of ADC TM channel data.
>>    * @nchannels: amount of channels defined/allocated
>>    * @decimation: sampling rate supported for the channel.
>> + *      Applies to all channels, used only on Gen1 ADC_TM.
>>    * @avg_samples: ability to provide single result from the ADC
>> - *    that is an average of multiple measurements.
>> + *      that is an average of multiple measurements. Applies to all
>> + *      channels, used only on Gen1 ADC_TM.
>>    * @base: base address of TM registers.
>> + * @adc_mutex_lock: ADC_TM mutex lock.
>
> Please specify that it is used only for gen2 and that it keeps written 
> and cached channel setup in sync (feel free to correct this 
> description according to your understanding, I might be wrong here).


I'll add to the description in the next post.


>>    */
>>   struct adc_tm5_chip {
>>       struct regmap        *regmap;
>> @@ -136,14 +217,15 @@ struct adc_tm5_chip {
>>       unsigned int        decimation;
>>       unsigned int        avg_samples;
>>       u16            base;
>> +    struct mutex        adc_mutex_lock;
>>   };
>>   -static const struct adc_tm5_data adc_tm5_data_pmic = {
>> -    .full_scale_code_volt = 0x70e4,
>> -    .decimation = (unsigned int []) { 250, 420, 840 },
>> -    .hw_settle = (unsigned int []) { 15, 100, 200, 300, 400, 500, 
>> 600, 700,
>> -                     1000, 2000, 4000, 8000, 16000, 32000,
>> -                     64000, 128000 },
>> +enum adc_tm_gen2_time_select {
>> +    MEAS_INT_50MS = 0,
>> +    MEAS_INT_100MS,
>> +    MEAS_INT_1S,
>> +    MEAS_INT_SET,
>> +    MEAS_INT_NONE,
>>   };
>
> Move this enum to the top, closer to the rest of definitions.


Will move it in the next post


>
>>     static int adc_tm5_read(struct adc_tm5_chip *adc_tm, u16 offset, 
>> u8 *data, int len)
>> @@ -210,6 +292,61 @@ static irqreturn_t adc_tm5_isr(int irq, void *data)
>>       return IRQ_HANDLED;
>>   }
>>   +static irqreturn_t adc_tm5_gen2_isr(int irq, void *data)
>> +{
>>           tzd = devm_thermal_zone_of_sensor_register(adc_tm->dev,
>>                                  adc_tm->channels[i].channel,
>>                                  &adc_tm->channels[i],
>> -                               &adc_tm5_ops);
>> +                               &adc_tm5_thermal_ops);
>>           if (IS_ERR(tzd)) {
>>               if (PTR_ERR(tzd) == -ENODEV) {
>>                   dev_warn(adc_tm->dev, "thermal sensor on channel %d 
>> is not used\n",
>> @@ -395,6 +710,11 @@ static int adc_tm5_init(struct adc_tm5_chip *chip)
>>           }
>>       }
>>   +    if (chip-->data->gen == ADC_TM5_GEN2) {
>> +        mutex_init(&chip->adc_mutex_lock);
>> +        return ret;
>> +    }
>> +
>
> Just init the mutex always, there is no need to be so picky in the 
> init code.
Will fix it in the next post.
>
>>       buf[0] = chip->decimation;
>>       buf[1] = chip->avg_samples | ADC_TM5_FAST_AVG_EN;
>>       buf[2] = ADC_TM5_TIMER1;
>> @@ -415,7 +735,7 @@ static int adc_tm5_get_dt_channel_data(struct 
>> adc_tm5_chip *adc_tm,
>>                          struct device_node *node)
>>       { }
>>   };
>>   MODULE_DEVICE_TABLE(of, adc_tm5_match_table);
>>
Thanks,
Jishnu
