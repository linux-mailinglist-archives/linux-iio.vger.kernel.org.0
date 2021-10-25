Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5813643959C
	for <lists+linux-iio@lfdr.de>; Mon, 25 Oct 2021 14:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhJYMK2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Oct 2021 08:10:28 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:7286 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbhJYMK2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Oct 2021 08:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635163687; x=1666699687;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=3Czd8Il2z0Nrgd4/ahkVxYHkanAIVTxbnZroNdcd5FE=;
  b=UitVdVPrWac9H+IVxe7zDIcr/ihxLB5XaZA/55GvtWY0K7yrDsKA502t
   deLCXry+86xgFfJeIBAQQ7ofP0jNkZQOk9+TC6pBl+pUCt5QNXZbqZCqj
   MQ9J6DzhrK26x6TMBukarM2D88P2NL6ssbLSTN2/neZf5DYKDZUGTcTal
   4=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 25 Oct 2021 05:08:06 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 05:08:05 -0700
Received: from [10.216.54.178] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7; Mon, 25 Oct 2021
 05:07:55 -0700
Subject: Re: [PATCH 2/2] thermal: qcom: add support for PMIC5 Gen2 ADCTM
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Matthias Kaehlcke <mka@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        <quic_kgunda@quicinc.com>, <quic_aghayal@quicinc.com>,
        <quic_subbaram@quicinc.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>
References: <1634541429-3215-1-git-send-email-quic_jprakash@quicinc.com>
 <1634541429-3215-3-git-send-email-quic_jprakash@quicinc.com>
 <CAA8EJpo9Zu=JJehYg9gdsc0U88pEBGe-x5v=ZbcV5dWCOJTyKA@mail.gmail.com>
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
Message-ID: <111fcc56-6441-3300-8d96-029ef8600702@quicinc.com>
Date:   Mon, 25 Oct 2021 17:37:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAA8EJpo9Zu=JJehYg9gdsc0U88pEBGe-x5v=ZbcV5dWCOJTyKA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Dmitry,

On 10/18/2021 5:16 PM, Dmitry Baryshkov wrote:
> On Mon, 18 Oct 2021 at 10:18, Jishnu Prakash <quic_jprakash@quicinc.com> wrote:
>> Add support for PMIC5 Gen2 ADC_TM, used on PMIC7 chips. It is a
> It looks to me like the Gen2 suffix is a bit misleading. I haven't
> checked the docs, but following the ADC example, I think we should
> name it ADC_TM7.
> Or maybe my original naming was wrong and we should use ADC5_TM and ADC7_TM.

The name used for this ADC version was amended internally, it should be 
called PMIC5 Gen2 ADC.

Keeping future ADC versions in mind, it would be better to call this 
peripheral PMIC5 Gen2 ADC_TM.

>
>> close counterpart of PMIC7 ADC and has the same functionality as
>> PMIC5 ADC_TM, for threshold monitoring and interrupt generation.
>> It is present on PMK8350 alone, like PMIC7 ADC and can be used
>> to monitor up to 8 ADC channels, from any of the PMIC7 PMICs
>> having ADC on a target, through PBS(Programmable Boot Sequence).
>>
>> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
>> ---
>>   drivers/iio/adc/qcom-vadc-common.c       | 187 ++++++++++++++
>>   drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 431 ++++++++++++++++++++++++++++++-
>>   include/linux/iio/adc/qcom-vadc-common.h |   2 +
> Please split iio changes to the separate patch.
I'll split them in the next post.
>
>>   3 files changed, 611 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
>> index 1472389..e192736 100644
>> --- a/drivers/iio/adc/qcom-vadc-common.c
>> +++ b/drivers/iio/adc/qcom-vadc-common.c
>> @@ -100,6 +100,182 @@ static const struct vadc_map_pt adcmap_100k_104ef_104fb_1875_vref[] = {
>>          { 46,   125000 },
>>   };
>>
>> +/*
>> + * Resistance to temperature table for NTCG104EF104 thermistor with
>> + * 100k pull-up.
>> + */
>> +static const struct vadc_map_pt adcmap_100k_adc7[] = {
> There is the adcmap7_100k table, which looks identical. Do you need
> this extra table?

You're right, I'll remove it in the next post.

>
>> +       { 4250657, -40960 },
>> +       { 3962085, -39936 },
>> +       { 3694875, -38912 },
>> +       { 3447322, -37888 },
>> +       { 3217867, -36864 },
>> +       { 3005082, -35840 },

>> +       { 2633, 126976 },
>> +       { 2560, 128000 },
>> +       { 2489, 129024 },
>> +       { 2420, 130048 }
>> +};
>> +
>> +
> Extra newline
Will remove this.
>
>>   static const struct vadc_map_pt adcmap7_die_temp[] = {
>>          { 857300, 160000 },
>>          { 820100, 140000 },
>> @@ -677,6 +853,17 @@ u16 qcom_adc_tm5_temp_volt_scale(unsigned int prescale_ratio,
>>   }
>>   EXPORT_SYMBOL(qcom_adc_tm5_temp_volt_scale);
>>
>> +u16 qcom_adc_tm5_temp_res_scale(int temp)
> This is definitely not an qcom_adc_tm5-kind of function. What about
> qcom_adc_tm7_temp_res_scale() ?


I'll rename it using adc_tm5_gen2 in the next post.

>> +{
>> +       int64_t resistance;
>> +
>> +       resistance = qcom_vadc_map_temp_voltage(adcmap_100k_adc7,
>> +               ARRAY_SIZE(adcmap_100k_adc7), temp);
>> +
>> +       return div64_s64((resistance * RATIO_MAX_ADC7), (resistance + R_PU_100K));
> Internal brackets are not needed.
Will fix it in the next post.
>
>>   struct adc_tm5_data {
>> +       const struct    adc_tm_ops *ops;
>>          const u32       full_scale_code_volt;
>>          unsigned int    *decimation;
>>          unsigned int    *hw_settle;
>> @@ -100,6 +155,12 @@ struct adc_tm5_chip;
>>    * @prescale: channel scaling performed on the input signal.
>>    * @hw_settle_time: the time between AMUX being configured and the
>>    *     start of conversion.
>> + * @decimation: sampling rate supported for the channel.
>> + * @avg_samples: ability to provide single result from the ADC
>> + *     that is an average of multiple measurements.
>> + * @high_thr_en: channel upper voltage threshold enable state.
>> + * @low_thr_en: channel lower voltage threshold enable state.
>> + * @meas_en: recurring measurement enable state
>>    * @iio: IIO channel instance used by this channel.
>>    * @chip: ADC TM chip instance.
>>    * @tzd: thermal zone device used by this channel.
>> @@ -110,6 +171,11 @@ struct adc_tm5_channel {
>>          enum adc_tm5_cal_method cal_method;
>>          unsigned int            prescale;
>>          unsigned int            hw_settle_time;
>> +       unsigned int            decimation;     /* For Gen2 ADC_TM */
>> +       unsigned int            avg_samples;    /* For Gen2 ADC_TM */
>> +       bool                    high_thr_en;
>> +       bool                    low_thr_en;
>> +       bool                    meas_en;
> Is there any reason for using the data here rather than reading it
> back from the register?
> And if there is one, adc_tm5 code should be converted to use them too.
That is one major difference between PMIC5 and PMIC5 Gen2 ADC_TM. In 
PMIC5, there was a separate set of
configuration registers for each ADC_TM channel, but in Gen2 ADC_TM, 
there is only one common set of
registers which can be used to configure any one of the 8 channels at a 
time. Reading back these
values for any one of the channels is not possible, the registers can 
only be used to write a
configuration which is read and applied by PBS on the actual ADC HW to 
monitor the channel,
as ADC_TM functionality is implemented completely within PBS. Therefore 
the channel data has to be
stored in SW.
>>          struct iio_channel      *iio;
>>          struct adc_tm5_chip     *chip;
>>          struct thermal_zone_device *tzd;
>> @@ -123,9 +189,12 @@ struct adc_tm5_channel {
>>    * @channels: array of ADC TM channel data.
>>    * @nchannels: amount of channels defined/allocated
>>    * @decimation: sampling rate supported for the channel.

>>
>> +enum adc_tm_index {
>> +       ADC_TM5,
>> +       ADC_TM5_GEN2,
>> +       ADC_TM5_MAX
>> +};
>> +
>> +static const struct adc_tm_ops ops_adc_tm5[ADC_TM5_MAX];
> There is no need for this extra array, please use ops directly. And if
> you introduce flags into the data, you won't have to forward declare
> the ops here.
Yes, I'll use the existing adc_tm5_data directly for these in the next 
post.
>> +static irqreturn_t adc_tm5_gen2_isr(int irq, void *data)
>> +{
>> +       struct adc_tm5_chip *chip = data;
>> +       u8 status_low, status_high;
>> +       int ret, i;
>> +
>> +       ret = adc_tm5_read(chip, ADC_TM_GEN2_STATUS_LOW_CLR, &status_low, sizeof(status_low));
>> +       if (ret) {
>> +               dev_err(chip->dev, "read status_low failed: %d\n", ret);
>> +               return IRQ_HANDLED;
>> +       }
>> +
>> +       ret = adc_tm5_read(chip, ADC_TM_GEN2_STATUS_HIGH_CLR, &status_high, sizeof(status_high));
>> +       if (ret) {
>> +               dev_err(chip->dev, "read status_high failed: %d\n", ret);
>> +               return IRQ_HANDLED;
>> +       }
>> +
>> +       ret = adc_tm5_write(chip, ADC_TM_GEN2_STATUS_LOW_CLR, &status_low, sizeof(status_low));
>> +       if (ret < 0) {
>> +               dev_err(chip->dev, "clear status low failed with %d\n", ret);
>> +               return IRQ_HANDLED;
>> +       }
>> +
>> +       ret = adc_tm5_write(chip, ADC_TM_GEN2_STATUS_HIGH_CLR, &status_high, sizeof(status_high));
>> +       if (ret < 0) {
>> +               dev_err(chip->dev, "clear status high failed with %d\n", ret);
>> +               return IRQ_HANDLED;
>> +       }
>> +
>> +       for (i = 0; i < chip->nchannels; i++) {
>> +               bool upper_set = false, lower_set = false;
>> +               unsigned int ch = chip->channels[i].channel;
>> +
>> +               /* No TZD, we warned at the boot time */
>> +               if (!chip->channels[i].tzd)
>> +                       continue;
>> +
>> +               if (!chip->channels[i].meas_en)
>> +                       continue;
> Any reason for having the meas_en here rather than reading the MEAS_EN
> bit like the ADC_TM5 code does?


As mentioned in the earlier comment above, the channel status cannot be 
read back from

registers for Gen2 ADC_TM, it needs to be stored in SW.

>
>> +
>> +               lower_set = (status_low & BIT(ch)) &&
>> +                       (chip->channels[i].low_thr_en);
>> +
>> +               upper_set = (status_high & BIT(ch)) &&
>> +                       (chip->channels[i].high_thr_en);
> And the high_thr_en/low_thr_en too.
Same as above comment.
>
>> +
>> +               if (upper_set || lower_set)
>> +                       thermal_zone_device_update(chip->channels[i].tzd,
>> +                                                  THERMAL_EVENT_UNSPECIFIED);
>> +       }
>> +
>> +       return IRQ_HANDLED;
>> +}
>> +
>>   static int adc_tm5_get_temp(void *data, int *temp)
>>   {
>>          struct adc_tm5_channel *channel = data;
>> @@ -240,6 +398,104 @@ static int adc_tm5_disable_channel(struct adc_tm5_channel *channel)
>>                                    0);
>>   }
>>
>> +#define ADC_TM_GEN2_POLL_DELAY_MIN_US          100
>> +#define ADC_TM_GEN2_POLL_DELAY_MAX_US          110
>> +#define ADC_TM_GEN2_POLL_RETRY_COUNT                   3
>> +
>> +static int32_t adc_tm5_gen2_conv_req(struct adc_tm5_chip *chip)
>> +{
>> +       int ret = 0;
>> +       u8 data = 0;
>> +       unsigned int count;
>> +
>> +       data = ADC_TM_GEN2_EN;
>> +       ret = adc_tm5_write(chip, ADC_TM_GEN2_EN_CTL1, &data, 1);
>> +       if (ret < 0) {
>> +               pr_err("adc-tm enable failed with %d\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       data = ADC_TM_GEN2_CFG_HS_FLAG;
>> +       ret = adc_tm5_write(chip, ADC_TM_GEN2_CFG_HS_SET, &data, 1);
>> +       if (ret < 0) {
>> +               pr_err("adc-tm handshake failed with %d\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       data = ADC_TM_GEN2_CONV_REQ_EN;
>> +       ret = adc_tm5_write(chip, ADC_TM_GEN2_CONV_REQ, &data, 1);
>> +       if (ret < 0) {
>> +               pr_err("adc-tm request conversion failed with %d\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       /*
>> +        * SW sets a handshake bit and waits for PBS to clear it
>> +        * before the next conversion request can be queued.
>> +        */
> Should this section be protected by the mutex then, so that any other
> possible user won't queue the conversion?


This API is only called within the mutex-protected region, in two other 
places in this file.

>
>> +
>> +       for (count = 0; count < ADC_TM_GEN2_POLL_RETRY_COUNT; count++) {
>> +               ret = adc_tm5_read(chip, ADC_TM_GEN2_CFG_HS_SET, &data, sizeof(data));
>> +               if (ret < 0) {
>> +                       pr_err("adc-tm read failed with %d\n", ret);
>> +                       return ret;
>> +               }
>> +
>> +               if (!(data & ADC_TM_GEN2_CFG_HS_FLAG))
>> +                       return ret;
>> +               usleep_range(ADC_TM_GEN2_POLL_DELAY_MIN_US,
>> +                       ADC_TM_GEN2_POLL_DELAY_MAX_US);
>> +       }
>> +
>> +       pr_err("adc-tm conversion request handshake timed out\n");
>> +
>> +       return -ETIMEDOUT;
>> +}
>> +

>>   static int adc_tm5_enable(struct adc_tm5_chip *chip)
>>   {
>>          int ret;
>> @@ -320,6 +576,86 @@ static int adc_tm5_configure(struct adc_tm5_channel *channel, int low, int high)
>>          return adc_tm5_enable(chip);
>>   }
>>
>> +static int adc_tm5_gen2_configure(struct adc_tm5_channel *channel, int low, int high)
>> +{
>> +       struct adc_tm5_chip *chip = channel->chip;
>> +       int ret;
>> +       u8 buf[14];
>> +       u16 adc_code;
>> +
>> +       mutex_lock(&chip->adc_mutex_lock);
> Either introduce mutex into the adc_tm5 code too, or drop it here.
I believe the mutex lock is not really needed for PMIC5 ADC_TM 
configuration because there we have one separate set of registers per TM 
channel, so only
one channel (and its set of registers) would be configured at a time. It 
could be a problem here if there are multiple thermal zones mapped to same
ADC_TM channel, but I understand the thermal framework supports only one 
thermal zone for one registered sensor, so this should not be not a problem.
For PMIC5 Gen2 ADC_TM, we need a mutex, as it is a common set of 
registers shared between all TM channels, which could be a problem if 
two different
ADC_TM thermal zones are configured simultaneously.

Considering the above points, which do you think is better, to add the 
mutex for ADC_TM5 too or not ?

>
>> +
>> +       channel->meas_en = true;
>> +
>> +       ret = adc_tm5_read(chip, ADC_TM_GEN2_SID, buf, sizeof(buf));
>> +       if (ret < 0) {
>> +               pr_err("adc-tm block read failed with %d\n", ret);
>> +               goto config_fail;
>> +       }
>> +
>> +       /* Set SID from virtual channel number */
>> +       buf[0] = channel->adc_channel >> 8;
>> +
>> +       /* Set TM channel number used and measurment interval */
> measurement
Will fix it in the next post.

> +static int adc_tm5_gen2_init(struct adc_tm5_chip *chip)
> +{
> +       u8 channels_available;
> +       int ret;
> +       unsigned int i;
> +
> +       ret = adc_tm5_read(chip, ADC_TM5_NUM_BTM,
> +                          &channels_available, sizeof(channels_available));
> +       if (ret) {
> +               dev_err(chip->dev, "read failed for BTM channels\n");
> +               return ret;
> +       }
> +
> +       mutex_init(&chip->adc_mutex_lock);
> +
> +       for (i = 0; i < chip->nchannels; i++) {
> +               if (chip->channels[i].channel >= channels_available) {
> +                       dev_err(chip->dev, "Invalid channel %d\n", chip->channels[i].channel);
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       return ret;
> This is the adc_tm5_init(), but with the ADC_DIG_PARAM bits left off.
> So it might be better to split the adc_tm5_init() rather than
> introducing the duplicate.
Will do it in the next post.
>
>> +}
>> +
>>   static int adc_tm5_get_dt_channel_data(struct adc_tm5_chip *adc_tm,
>>                                         struct adc_tm5_channel *channel,
>>                                         struct device_node *node)
>>   {
>>          const char *name = node->name;
>> -       u32 chan, value, varr[2];
>> +       u32 chan, value, adc_channel, varr[2];
>>          int ret;
>>          struct device *dev = adc_tm->dev;
>>          struct of_phandle_args args;
>> @@ -445,7 +806,11 @@ static int adc_tm5_get_dt_channel_data(struct adc_tm5_chip *adc_tm,
>>          }
>>          of_node_put(args.np);
>>
>> -       if (args.args_count != 1 || args.args[0] >= ADC5_MAX_CHANNEL) {
> This does not apply either against current linux master or against
> linux-next master.
I'm not sure what you mean here, can you please explain some more? Which 
part exactly needs to change?
>
>> +       adc_channel = args.args[0];
>> +       if (adc_tm->data->ops == &ops_adc_tm5[ADC_TM5_GEN2])
> Please replace ops comparison with flags.
Will do it in the next post.
>
>> +               adc_channel &= 0xff;
>> +
>> +       if (args.args_count != 1 || adc_channel >= ADC5_MAX_CHANNEL) {
>>                  dev_err(dev, "%s: invalid ADC channel number %d\n", name, chan);
>>                  return -EINVAL;
>>          }
>> @@ -491,6 +856,32 @@ static int adc_tm5_get_dt_channel_data(struct adc_tm5_chip *adc_tm,
>>          else
>>                  channel->cal_method = ADC_TM5_ABSOLUTE_CAL;
>>
>> +       if (adc_tm->data->ops == &ops_adc_tm5[ADC_TM5_GEN2]) {
> And here too, please replace it with flags.
Will do it in the next post.
>
>

>> @@ -591,7 +982,7 @@ static int adc_tm5_probe(struct platform_device *pdev)
>>                  return ret;
>>          }
>>
>> -       ret = adc_tm5_init(adc_tm);
>> +       ret = adc_tm->data->ops->init(adc_tm);
>>          if (ret) {
>>                  dev_err(dev, "adc-tm init failed\n");
>>                  return ret;
>> @@ -603,15 +994,37 @@ static int adc_tm5_probe(struct platform_device *pdev)
>>                  return ret;
>>          }
>>
>> +       if (adc_tm->data->ops == &ops_adc_tm5[ADC_TM5_GEN2])
>> +               return devm_request_threaded_irq(dev, irq, NULL, adc_tm5_gen2_isr,
>> +                               IRQF_ONESHOT, "pm-adc-tm5-gen2", adc_tm);
>> +
>>          return devm_request_threaded_irq(dev, irq, NULL, adc_tm5_isr,
>> -                                        IRQF_ONESHOT, "pm-adc-tm5", adc_tm);
>> +                               IRQF_ONESHOT, "pm-adc-tm5", adc_tm);
> Push ISR into TM data.
Will do it in the next post.
>
>>   }
>>
Thanks,

Jishnu


