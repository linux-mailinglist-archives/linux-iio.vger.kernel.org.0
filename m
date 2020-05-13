Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392281D0BDD
	for <lists+linux-iio@lfdr.de>; Wed, 13 May 2020 11:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgEMJU4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 May 2020 05:20:56 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:60849 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728264AbgEMJUz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 May 2020 05:20:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589361653; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=TrO8O3VXvftsLC2EqZdcLvOQtCzAvipZRYMt6I3Pp6U=; b=jqdhRmw2EDHFs5QF9NuI3kKsM92R70l6bCbgpP862Tu/ZJ4vHWzHqqACGlIQkDkWB1hRHtSW
 51i9TeRG4HfAP8D/7xOZQNbgBVaKQYfMaQnBd1ftF0/Swynk1T6wWDPCQ7PGyFkQEYn+31ty
 M9DeaFBl+X+9qG241kgI5ZX5l1s=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3Mzk1NyIsICJsaW51eC1paW9Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebbbbee.7f7d5f2c0500-smtp-out-n01;
 Wed, 13 May 2020 09:20:46 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BA140C44792; Wed, 13 May 2020 09:20:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.101] (unknown [157.48.3.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E1FE3C44788;
        Wed, 13 May 2020 09:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E1FE3C44788
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jprakash@codeaurora.org
Subject: Re: [PATCH V3 3/4] iio: adc: Add support for PMIC7 ADC
To:     Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan.Cameron@huawei.com, smohanad@codeaurora.org,
        kgunda@codeaurora.org, aghayal@codeaurora.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-iio@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
References: <1587993846-30773-1-git-send-email-jprakash@codeaurora.org>
 <1587993846-30773-4-git-send-email-jprakash@codeaurora.org>
 <CAHLCerPrZNBt+J_yZom1dtJ20r-H2_dAmHWFf9_bs3QV823Lgw@mail.gmail.com>
From:   Jishnu Prakash <jprakash@codeaurora.org>
Message-ID: <2e3be28e-617d-69bd-4ad5-4c9053cd70b4@codeaurora.org>
Date:   Wed, 13 May 2020 14:50:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHLCerPrZNBt+J_yZom1dtJ20r-H2_dAmHWFf9_bs3QV823Lgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Amit,

On 5/5/2020 3:33 PM, Amit Kucheria wrote:
> Hi Jishnu,
>
> It is nice to cc a reviewer from a previous version. Just saw this.
>
> On Mon, Apr 27, 2020 at 6:55 PM Jishnu Prakash <jprakash@codeaurora.org> wrote:
>> The ADC architecture on PMIC7 is changed as compared to PMIC5. The
>> major change from PMIC5 is that all SW communication to ADC goes through
>> PMK8350, which communicates with other PMICs through PBS when the ADC
>> on PMK8350 works in master mode. The SID register is used to identify the
>> PMICs with which the PBS needs to communicate. Add support for the same.
>>
>> Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
>> ---
>>   drivers/iio/adc/qcom-spmi-adc5.c   | 239 +++++++++++++++++++++++++++++++++-
>>   drivers/iio/adc/qcom-vadc-common.c | 260 +++++++++++++++++++++++++++++++++++++
>>   drivers/iio/adc/qcom-vadc-common.h |  15 +++
>>   3 files changed, 510 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
>> index 21fdcde..a66eeb7 100644
>> --- a/drivers/iio/adc/qcom-spmi-adc5.c
>> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
>> @@ -1,6 +1,6 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   /*
>> - * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2018, 2020, The Linux Foundation. All rights reserved.
>>    */
>>
>>   #include <linux/bitops.h>
>> @@ -23,6 +23,7 @@
>>
>>   #define ADC5_USR_REVISION1                     0x0
>>   #define ADC5_USR_STATUS1                       0x8
>> +#define ADC5_USR_STATUS1_CONV_FAULT            BIT(7)
>>   #define ADC5_USR_STATUS1_REQ_STS               BIT(1)
>>   #define ADC5_USR_STATUS1_EOC                   BIT(0)
>>   #define ADC5_USR_STATUS1_REQ_STS_EOC_MASK      0x3
>> @@ -65,6 +66,9 @@
>>
>>   #define ADC5_USR_IBAT_DATA1                    0x53
>>
>> +#define ADC_CHANNEL_OFFSET                     0x8
>> +#define ADC_CHANNEL_MASK                       GENMASK(7, 0)
>> +
>>   /*
>>    * Conversion time varies based on the decimation, clock rate, fast average
>>    * samples and measurements queued across different VADC peripherals.
>> @@ -79,6 +83,11 @@
>>   #define ADC5_HW_SETTLE_DIFF_MINOR              3
>>   #define ADC5_HW_SETTLE_DIFF_MAJOR              5
>>
>> +/* For PMIC7 */
>> +#define ADC_APP_SID                            0x40
>> +#define ADC_APP_SID_MASK                       GENMASK(3, 0)
>> +#define ADC7_CONV_TIMEOUT                      msecs_to_jiffies(10)
>> +
>>   enum adc5_cal_method {
>>          ADC5_NO_CAL = 0,
>>          ADC5_RATIOMETRIC_CAL,
>> @@ -96,6 +105,7 @@ enum adc5_cal_val {
>>    * @cal_method: calibration method.
>>    * @cal_val: calibration value
>>    * @decimation: sampling rate supported for the channel.
>> + * @sid: slave id of PMIC owning the channel, for PMIC7.
>>    * @prescale: channel scaling performed on the input signal.
>>    * @hw_settle_time: the time between AMUX being configured and the
>>    *     start of conversion.
>> @@ -110,6 +120,7 @@ struct adc5_channel_prop {
>>          enum adc5_cal_method    cal_method;
>>          enum adc5_cal_val       cal_val;
>>          unsigned int            decimation;
>> +       unsigned int            sid;
>>          unsigned int            prescale;
>>          unsigned int            hw_settle_time;
>>          unsigned int            avg_samples;
>> @@ -140,6 +151,7 @@ struct adc5_chip {
>>          bool                    poll_eoc;
>>          struct completion       complete;
>>          struct mutex            lock;
>> +       int                     irq_eoc;
>>          const struct adc5_data  *data;
>>   };
>>
>> @@ -155,6 +167,8 @@ static const struct vadc_prescale_ratio adc5_prescale_ratios[] = {
>>          {.num =  1, .den = 16}
>>   };
>>
>> +static const struct adc5_data adc7_data_pmic;
>> +
>>   static int adc5_read(struct adc5_chip *adc, u16 offset, u8 *data, int len)
>>   {
>>          return regmap_bulk_read(adc->regmap, adc->base + offset, data, len);
>> @@ -165,6 +179,11 @@ static int adc5_write(struct adc5_chip *adc, u16 offset, u8 *data, int len)
>>          return regmap_bulk_write(adc->regmap, adc->base + offset, data, len);
>>   }
>>
>> +static int adc5_masked_write(struct adc5_chip *adc, u16 offset, u8 mask, u8 val)
>> +{
>> +       return regmap_update_bits(adc->regmap, adc->base + offset, mask, val);
>> +}
>> +
>>   static int adc5_prescaling_from_dt(u32 num, u32 den)
>>   {
>>          unsigned int pre;
>> @@ -314,6 +333,47 @@ static int adc5_configure(struct adc5_chip *adc,
>>          return adc5_write(adc, ADC5_USR_DIG_PARAM, buf, sizeof(buf));
>>   }
>>
>> +static int adc7_configure(struct adc5_chip *adc,
>> +                       struct adc5_channel_prop *prop)
>> +{
>> +       int ret;
>> +       u8 conv_req = 0, buf[4];
>> +
>> +       ret = adc5_masked_write(adc, ADC_APP_SID, ADC_APP_SID_MASK, prop->sid);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = adc5_read(adc, ADC5_USR_DIG_PARAM, buf, sizeof(buf));
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       /* Digital param selection */
>> +       adc5_update_dig_param(adc, prop, &buf[0]);
>> +
>> +       /* Update fast average sample value */
>> +       buf[1] &= 0xff & ~ADC5_USR_FAST_AVG_CTL_SAMPLES_MASK;
> Did you answer Andy's query about this in v2? I couldn't find it.
I missed it at earlier, I have replied now and will make the change in 
my latest post.
>
>> +       buf[1] |= prop->avg_samples;
>> +
>> +       /* Select ADC channel */
>> +       buf[2] = prop->channel;
>> +
>> +       /* Select HW settle delay for channel */
>> +       buf[3] &= 0xff & ~ADC5_USR_HW_SETTLE_DELAY_MASK;
> Same here.
I missed it at earlier, I have replied now and will make the change in 
my latest post.
>
>> +       buf[3] |= prop->hw_settle_time;
>> +
>> +       /* Select CONV request */
>> +       conv_req = ADC5_USR_CONV_REQ_REQ;
>> +
>> +       if (!adc->poll_eoc)
>> +               reinit_completion(&adc->complete);
>> +
>> +       ret = adc5_write(adc, ADC5_USR_DIG_PARAM, buf, sizeof(buf));
>> +       if (ret)
>> +               return ret;
>> +
>> +       return adc5_write(adc, ADC5_USR_CONV_REQ, &conv_req, 1);
> Is it required to call adc5_write() twice here in sequence on the
> adc7? adc5_configure() above manages just fine by having an extra
> element in buf and one call.
In PMIC5, that write is used to write to registers 0x42-0x47. Register 
0x46 has been removed for PMIC7 ADC, so we use two writes, for 0x42-0x45 
and for 0x47 alone.
>
>> +}
>> +
>>   static int adc5_do_conversion(struct adc5_chip *adc,
>>                          struct adc5_channel_prop *prop,
>>                          struct iio_chan_spec const *chan,
>> @@ -355,6 +415,43 @@ static int adc5_do_conversion(struct adc5_chip *adc,
>>          return ret;
>>   }
>>
>> +static int adc7_do_conversion(struct adc5_chip *adc,
>> +                       struct adc5_channel_prop *prop,
>> +                       struct iio_chan_spec const *chan,
>> +                       u16 *data_volt, u16 *data_cur)
>> +{
>> +       int ret;
>> +       u8 status;
>> +
>> +       mutex_lock(&adc->lock);
>> +
>> +       ret = adc7_configure(adc, prop);
>> +       if (ret) {
>> +               dev_err(adc->dev, "ADC configure failed with %d\n", ret);
>> +               goto unlock;
>> +       }
>> +
>> +       /* No support for polling mode at present */
>> +       wait_for_completion_timeout(&adc->complete, ADC7_CONV_TIMEOUT);
>> +
>> +       ret = adc5_read(adc, ADC5_USR_STATUS1, &status, 1);
>> +       if (ret < 0)
>> +               goto unlock;
>> +
>> +       if (status & ADC5_USR_STATUS1_CONV_FAULT) {
>> +               dev_err(adc->dev, "Unexpected conversion fault\n");
>> +               ret = -EIO;
>> +               goto unlock;
>> +       }
>> +
>> +       ret = adc5_read_voltage_data(adc, data_volt);
>> +
>> +unlock:
>> +       mutex_unlock(&adc->lock);
>> +
>> +       return ret;
>> +}
>> +
>>   static irqreturn_t adc5_isr(int irq, void *dev_id)
>>   {
>>          struct adc5_chip *adc = dev_id;
>> @@ -377,6 +474,56 @@ static int adc5_of_xlate(struct iio_dev *indio_dev,
>>          return -EINVAL;
>>   }
>>
>> +static int adc7_of_xlate(struct iio_dev *indio_dev,
>> +                               const struct of_phandle_args *iiospec)
>> +{
>> +       struct adc5_chip *adc = iio_priv(indio_dev);
>> +       int i, v_channel;
>> +
>> +       for (i = 0; i < adc->nchannels; i++) {
>> +               v_channel = (adc->chan_props[i].sid << ADC_CHANNEL_OFFSET |
>> +                       adc->chan_props[i].channel);
>> +               if (v_channel == iiospec->args[0])
>> +                       return i;
>> +       }
>> +
>> +       return -EINVAL;
>> +}
>> +
>> +static int adc7_read_raw(struct iio_dev *indio_dev,
>> +                        struct iio_chan_spec const *chan, int *val, int *val2,
>> +                        long mask)
> Just a nit. Since all your adc7 functions follow your adc5 functions,
> please move this below adc5_read_raw for consistency.
I'll do it in the next post.
>
>> +{
>> +       struct adc5_chip *adc = iio_priv(indio_dev);
>> +       struct adc5_channel_prop *prop;
>> +       u16 adc_code_volt, adc_code_cur;
>> +       int ret;
>> +
>> +       prop = &adc->chan_props[chan->address];
>> +
>> +       switch (mask) {
>> +       case IIO_CHAN_INFO_PROCESSED:
>> +               ret = adc7_do_conversion(adc, prop, chan,
> Except for this bit (call to adc7_do_conversion instead of
> adc5_do_conversion), this function is identical to adc5_read_raw.
>
> How about making adc5_read_raw and adc7_read_raw a shim around a
> function adc_read_raw_common() that takes a function pointer?
I'll do this in the next post.
>
>> +                                       &adc_code_volt, &adc_code_cur);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               ret = qcom_adc5_hw_scale(prop->scale_fn_type,
>> +                       &adc5_prescale_ratios[prop->prescale],
>> +                       adc->data,
>> +                       adc_code_volt, val);
>> +
>> +               if (ret)
>> +                       return ret;
>> +
>> +               return IIO_VAL_INT;
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>   static int adc5_read_raw(struct iio_dev *indio_dev,
>>                           struct iio_chan_spec const *chan, int *val, int *val2,
>>                           long mask)
>> @@ -415,6 +562,11 @@ static const struct iio_info adc5_info = {
>>          .of_xlate = adc5_of_xlate,
>>   };
>>
>> +static const struct iio_info adc7_info = {
>> +       .read_raw = adc7_read_raw,
>> +       .of_xlate = adc7_of_xlate,
>> +};
>> +
>>   struct adc5_channels {
>>          const char *datasheet_name;
>>          unsigned int prescale_index;
>> @@ -477,6 +629,39 @@ static const struct adc5_channels adc5_chans_pmic[ADC5_MAX_CHANNEL] = {
>>                                          SCALE_HW_CALIB_PM5_SMB_TEMP)
>>   };
>>
>> +static const struct adc5_channels adc7_chans_pmic[ADC5_MAX_CHANNEL] = {
>> +       [ADC7_REF_GND]          = ADC5_CHAN_VOLT("ref_gnd", 0,
>> +                                       SCALE_HW_CALIB_DEFAULT)
>> +       [ADC7_1P25VREF]         = ADC5_CHAN_VOLT("vref_1p25", 0,
>> +                                       SCALE_HW_CALIB_DEFAULT)
>> +       [ADC7_VPH_PWR]          = ADC5_CHAN_VOLT("vph_pwr", 1,
>> +                                       SCALE_HW_CALIB_DEFAULT)
>> +       [ADC7_VBAT_SNS]         = ADC5_CHAN_VOLT("vbat_sns", 3,
>> +                                       SCALE_HW_CALIB_DEFAULT)
>> +       [ADC7_DIE_TEMP]         = ADC5_CHAN_TEMP("die_temp", 0,
>> +                                       SCALE_HW_CALIB_PMIC_THERM_PM7)
>> +       [ADC7_AMUX_THM1_100K_PU]        = ADC5_CHAN_TEMP("amux_thm1_pu2", 0,
>> +                                       SCALE_HW_CALIB_THERM_100K_PU_PM7)
>> +       [ADC7_AMUX_THM2_100K_PU]        = ADC5_CHAN_TEMP("amux_thm2_pu2", 0,
>> +                                       SCALE_HW_CALIB_THERM_100K_PU_PM7)
>> +       [ADC7_AMUX_THM3_100K_PU]        = ADC5_CHAN_TEMP("amux_thm3_pu2", 0,
>> +                                       SCALE_HW_CALIB_THERM_100K_PU_PM7)
>> +       [ADC7_AMUX_THM4_100K_PU]        = ADC5_CHAN_TEMP("amux_thm4_pu2", 0,
>> +                                       SCALE_HW_CALIB_THERM_100K_PU_PM7)
>> +       [ADC7_AMUX_THM5_100K_PU]        = ADC5_CHAN_TEMP("amux_thm5_pu2", 0,
>> +                                       SCALE_HW_CALIB_THERM_100K_PU_PM7)
>> +       [ADC7_AMUX_THM6_100K_PU]        = ADC5_CHAN_TEMP("amux_thm6_pu2", 0,
> Use space instead of tab for indentation in all the THMx channels to
> make it look more in line.
I'll do this in the next post.
>
>> +                                       SCALE_HW_CALIB_THERM_100K_PU_PM7)
>> +       [ADC7_GPIO1_100K_PU]    = ADC5_CHAN_TEMP("gpio1_pu2", 0,
>> +                                       SCALE_HW_CALIB_THERM_100K_PU_PM7)
>> +       [ADC7_GPIO2_100K_PU]    = ADC5_CHAN_TEMP("gpio2_pu2", 0,
>> +                                       SCALE_HW_CALIB_THERM_100K_PU_PM7)
>> +       [ADC7_GPIO3_100K_PU]    = ADC5_CHAN_TEMP("gpio3_pu2", 0,
>> +                                       SCALE_HW_CALIB_THERM_100K_PU_PM7)
>> +       [ADC7_GPIO4_100K_PU]    = ADC5_CHAN_TEMP("gpio4_pu2", 0,
>> +                                       SCALE_HW_CALIB_THERM_100K_PU_PM7)
>> +};
>> +
>>   static const struct adc5_channels adc5_chans_rev2[ADC5_MAX_CHANNEL] = {
>>          [ADC5_REF_GND]          = ADC5_CHAN_VOLT("ref_gnd", 0,
>>                                          SCALE_HW_CALIB_DEFAULT)
>> @@ -511,6 +696,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
>>   {
>>          const char *name = node->name, *channel_name;
>>          u32 chan, value, varr[2];
>> +       u32 sid = 0;
>>          int ret;
>>          struct device *dev = adc->dev;
>>
>> @@ -520,6 +706,15 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
>>                  return ret;
>>          }
>>
>> +       /* Value read from "reg" is virtual channel number */
>> +
>> +       /* virtual channel number = sid << 8 | channel number */
>> +
>> +       if (adc->data == &adc7_data_pmic) {
>> +               sid = chan >> ADC_CHANNEL_OFFSET;
>> +               chan = chan & ADC_CHANNEL_MASK;
>> +       }
>> +
>>          if (chan > ADC5_PARALLEL_ISENSE_VBAT_IDATA ||
>>              !data->adc_chans[chan].datasheet_name) {
>>                  dev_err(dev, "%s invalid channel number %d\n", name, chan);
>> @@ -528,6 +723,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
>>
>>          /* the channel has DT description */
>>          prop->channel = chan;
>> +       prop->sid = sid;
>>
>>          channel_name = of_get_property(node,
>>                                  "label", NULL) ? : node->name;
>> @@ -578,8 +774,9 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
>>                  pr_debug("dig_ver:minor:%d, major:%d\n", dig_version[0],
>>                                                  dig_version[1]);
>>                  /* Digital controller >= 5.3 have hw_settle_2 option */
>> -               if (dig_version[0] >= ADC5_HW_SETTLE_DIFF_MINOR &&
>> -                       dig_version[1] >= ADC5_HW_SETTLE_DIFF_MAJOR)
>> +               if ((dig_version[0] >= ADC5_HW_SETTLE_DIFF_MINOR &&
>> +                       dig_version[1] >= ADC5_HW_SETTLE_DIFF_MAJOR) ||
>> +                       adc->data == &adc7_data_pmic)
>>                          ret = adc5_hw_settle_time_from_dt(value,
>>                                                          data->hw_settle_2);
>>                  else
>> @@ -629,6 +826,7 @@ static const struct adc5_data adc5_data_pmic = {
>>          .full_scale_code_volt = 0x70e4,
>>          .full_scale_code_cur = 0x2710,
>>          .adc_chans = adc5_chans_pmic,
>> +       .info = &adc5_info,
> This belongs in a separate patch along with the change in
> adc5_data_pmic_rev2 below
I'll add a separate patch for this in the next post.
>
>>          .decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
>>                                  {250, 420, 840},
>>          .hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
>> @@ -639,10 +837,23 @@ static const struct adc5_data adc5_data_pmic = {
>>                                  1, 2, 4, 8, 16, 32, 64, 128},
>>   };
>>
>> +static const struct adc5_data adc7_data_pmic = {
>> +       .full_scale_code_volt = 0x70e4,
>> +       .adc_chans = adc7_chans_pmic,
>> +       .info = &adc7_info,
>> +       .decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
>> +                               {85, 340, 1360},
>> +       .hw_settle_2 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
>> +                               {15, 100, 200, 300, 400, 500, 600, 700,
>> +                               1000, 2000, 4000, 8000, 16000, 32000,
>> +                               64000, 128000},
>> +};
>> +
>>   static const struct adc5_data adc5_data_pmic_rev2 = {
>>          .full_scale_code_volt = 0x4000,
>>          .full_scale_code_cur = 0x1800,
>>          .adc_chans = adc5_chans_rev2,
>> +       .info = &adc5_info,
> Separate patch.
I'll add a separate patch for this in the next post.
>
>>          .decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
>>                                  {256, 512, 1024},
>>          .hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
>> @@ -659,6 +870,10 @@ static const struct of_device_id adc5_match_table[] = {
>>                  .data = &adc5_data_pmic,
>>          },
>>          {
>> +               .compatible = "qcom,spmi-adc7",
>> +               .data = &adc7_data_pmic,
>> +       },
>> +       {
>>                  .compatible = "qcom,spmi-adc-rev2",
>>                  .data = &adc5_data_pmic_rev2,
>>          },
>> @@ -752,6 +967,9 @@ static int adc5_probe(struct platform_device *pdev)
>>          adc->regmap = regmap;
>>          adc->dev = dev;
>>          adc->base = reg;
>> +
>> +       platform_set_drvdata(pdev, adc);
>> +
>>          init_completion(&adc->complete);
>>          mutex_init(&adc->lock);
>>
>> @@ -761,6 +979,8 @@ static int adc5_probe(struct platform_device *pdev)
>>                  return ret;
>>          }
>>
>> +       indio_dev->info = adc->data->info;
>> +
>>          irq_eoc = platform_get_irq(pdev, 0);
>>          if (irq_eoc < 0) {
>>                  if (irq_eoc == -EPROBE_DEFER || irq_eoc == -EINVAL)
>> @@ -773,23 +993,34 @@ static int adc5_probe(struct platform_device *pdev)
>>                          return ret;
>>          }
>>
>> +       adc->irq_eoc = irq_eoc;
>> +
> I think this belongs in a separate patch along with the adc5_exit
> function below.
I'll add a separate patch for this in the next post.
>
>>          indio_dev->dev.parent = dev;
>>          indio_dev->dev.of_node = node;
>>          indio_dev->name = pdev->name;
>>          indio_dev->modes = INDIO_DIRECT_MODE;
>> -       indio_dev->info = &adc5_info;
>>          indio_dev->channels = adc->iio_chans;
>>          indio_dev->num_channels = adc->nchannels;
>>
>>          return devm_iio_device_register(dev, indio_dev);
>>   }
>>
>> +static int adc5_exit(struct platform_device *pdev)
>> +{
>> +       struct adc5_chip *adc = platform_get_drvdata(pdev);
>> +
>> +       if (adc->irq_eoc >= 0)
>> +               disable_irq(adc->irq_eoc);
>> +       return 0;
>> +}
>> +
>>   static struct platform_driver adc5_driver = {
>>          .driver = {
>>                  .name = "qcom-spmi-adc5.c",
>>                  .of_match_table = adc5_match_table,
>>          },
>>          .probe = adc5_probe,
>> +       .remove = adc5_exit,
> This really belongs in a separate patch
I'll add a separate patch for this and the above changes mentioned in 
the next post.
>
>>   };
>>   module_platform_driver(adc5_driver);
>>
>>
