Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9F7288C5A
	for <lists+linux-iio@lfdr.de>; Fri,  9 Oct 2020 17:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389157AbgJIPPR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Oct 2020 11:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388745AbgJIPPQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Oct 2020 11:15:16 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F10C0613D2
        for <linux-iio@vger.kernel.org>; Fri,  9 Oct 2020 08:15:16 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id y16so8813441ljk.1
        for <linux-iio@vger.kernel.org>; Fri, 09 Oct 2020 08:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E6Nd8bFLpZfzhnJqMtPJPONxQyfB4cH/rdHKzqew4oo=;
        b=Qc/JMWf/ffAVqqTQcI9JG4TLUusWr4+kaYKzlWwyTDeUgS1j7voTIwEya6AAJzKkol
         faszaKpvwTwYMpoWr7PvAuqEVkrcOaLdwCa5Tio52Iv+xaVEkA13ERUSzISHWEgYMoRV
         +U1Lbz3GTYcKT2y466elZ15AG/H25fvV0Txp5RYLd3XvpwCxfUq9n/1y6uwF9Is2lEmE
         VqmRzDBVzXqskzg90Rt8TxLq9oiAWhQvvDZlkOMYX3wkoXcB6MRzFN2xKR9r2QPYuNdO
         d6WJ0xXYuicfxNruqVEMs37/qJRqVoy1OTUGKJSAjgNb1aYV1yhj7wex1NgN+Xk7JxlM
         dNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E6Nd8bFLpZfzhnJqMtPJPONxQyfB4cH/rdHKzqew4oo=;
        b=M32NuqYnoBVbOCUmsbB1ctOLhFyY+ykU+eLIgAEyPFIKdVoVis7Ev9e94hJHuhTVUl
         7EZZgqjR3oW+VtRDjrSH7+zN8tX7tcmNq0Nm8UjuN+nesIvBhJCcktMf7a/7dMOtJ9iC
         vLA7y28jmrsP+qPNE6diKeegITKOHwXU994J2r+QkmE3/DjMzrO0KQpppqyIF68bhoLA
         znCuoetgxWaie5b4W4h47wQDCIFvvaJ0dxZZ+ddYrnqt2Nn4k9CYJgyaphyMksU/FoD8
         8eBhkP3FEMnceixTD8kwUciGD5rImohaqk3iI/YUlOhfvl9IGDuo5QOTpq1usTBl8k3v
         p43A==
X-Gm-Message-State: AOAM532msUnaa+zo909O1eYAXel0EtHig+tOH1abMFRVs0C72EtcD2+0
        PdoCx1Jk0k2KipfxnKRj/NiXjg==
X-Google-Smtp-Source: ABdhPJyMApbqWWYKrRxdaZeohuRpwHPicgxI00Hs2697xZEQeG8le9Oh2C+OAPB+UP3mMy0RKFGWhg==
X-Received: by 2002:a2e:9d94:: with SMTP id c20mr5363714ljj.445.1602256513326;
        Fri, 09 Oct 2020 08:15:13 -0700 (PDT)
Received: from [192.168.1.211] ([188.162.65.231])
        by smtp.gmail.com with ESMTPSA id t17sm743958lff.147.2020.10.09.08.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 08:15:12 -0700 (PDT)
Subject: Re: [PATCH v7 07/10] thermal: qcom: add support for adc-tm5 PMIC
 thermal monitor
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jishnu Prakash <jprakash@qti.qualcomm.com>
References: <20201007135433.1041979-1-dmitry.baryshkov@linaro.org>
 <20201007135433.1041979-8-dmitry.baryshkov@linaro.org>
 <3d6bd019-1516-5307-ef49-b6279fbfbe82@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <642645af-19f1-7ac1-a10a-7f943c757c7f@linaro.org>
Date:   Fri, 9 Oct 2020 18:15:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <3d6bd019-1516-5307-ef49-b6279fbfbe82@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 08/10/2020 19:22, Daniel Lezcano wrote:
> On 07/10/2020 15:54, Dmitry Baryshkov wrote:
>> Add support for Thermal Monitoring part of PMIC5. This part is closely
>> coupled with ADC, using it's channels directly. ADC-TM support
>> generating interrupts on ADC value crossing low or high voltage bounds,
>> which is used to support thermal trip points.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   drivers/iio/adc/qcom-vadc-common.c       |  62 +++
>>   drivers/iio/adc/qcom-vadc-common.h       |   3 +
>>   drivers/thermal/qcom/Kconfig             |  11 +
>>   drivers/thermal/qcom/Makefile            |   1 +
>>   drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 622 +++++++++++++++++++++++
>>   5 files changed, 699 insertions(+)
>>   create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5.c
>>
>> diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
>> index 40d77b3af1bb..e58e393b8713 100644
>> --- a/drivers/iio/adc/qcom-vadc-common.c
>> +++ b/drivers/iio/adc/qcom-vadc-common.c
>> @@ -377,6 +377,42 @@ static int qcom_vadc_map_voltage_temp(const struct vadc_map_pt *pts,
>>   	return 0;
>>   }
>>   
>> +static s32 qcom_vadc_map_temp_voltage(const struct vadc_map_pt *pts,
>> +				      u32 tablesize, int input)
>> +{
>> +	bool descending = 1;
>> +	u32 i = 0;
>> +
> 
> The code seems like a bit

Could you please clarify, what do you mean?

> 
>> +	/* Check if table is descending or ascending */
>> +	if (tablesize > 1) {
>> +		if (pts[0].y < pts[1].y)
>> +			descending = 0;
>> +	}
>> +
>> +	while (i < tablesize) {
>> +		if (descending && pts[i].y < input) {
>> +			/* table entry is less than measured*/
>> +			 /* value and table is descending, stop */
>> +			break;
>> +		} else if ((!descending) && pts[i].y > input) {
>> +			/* table entry is greater than measured*/
>> +			/*value and table is ascending, stop */
>> +			break;
>> +		}
>> +		i++;
>> +	}
>> +
>> +	if (i == 0)
>> +		return pts[0].x;
>> +	if (i == tablesize)
>> +		return pts[tablesize - 1].x;
>> +
>> +	/* result is between search_index and search_index-1 */
>> +	/* interpolate linearly */
>> +	return fixp_linear_interpolate(pts[i - 1].y, pts[i - 1].x,
>> +			pts[i].y, pts[i].x, input);
>> +}
>> +
>>   static void qcom_vadc_scale_calib(const struct vadc_linear_graph *calib_graph,
>>   				  u16 adc_code,
>>   				  bool absolute,

[....]

>> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
>> new file mode 100644
>> index 000000000000..c09a50f59053
>> --- /dev/null
>> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
>> @@ -0,0 +1,622 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2012-2020, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2020 Linaro Limited
>> + */
> 
> If it is possible, please give a description of this sensor, the
> different register mapping, etc ... So it will be easier to review and
> debug in the future.

In which form? I don't often see such descriptions in the code.

> 
> 
>> +#include <linux/bitfield.h>
>> +#include <linux/iio/consumer.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/thermal.h>
>> +
>> +#include "../../iio/adc/qcom-vadc-common.h"
> 
> Do not use this form of inclusion.

Fixed.


[...]

> 
>> +	if (ret) {
>> +		dev_err(chip->dev, "read status low failed with %d\n", ret);
>> +		return IRQ_HANDLED;
>> +	}
> 
> Can you identify the reasons those reads can fail? If it is not supposed
> to happen it is fine but otherwise we don't want to be flooded with
> error messages on the console.

Changed to use unlikely(ret) as way to show that this is not supposed to 
happen.


>> +		lower_set = (status_low & BIT(ch)) &&
>> +			(ctl & ADC_TM5_M_MEAS_EN) &&
>> +			(ctl & ADC_TM5_M_LOW_THR_INT_EN);
>> +
>> +		upper_set = (status_high & BIT(ch)) &&
>> +			(ctl & ADC_TM5_M_MEAS_EN) &&
>> +			(ctl & ADC_TM5_M_HIGH_THR_INT_EN);
> 
> Is the check (ctl & ADC_TM5_M_[HIGH|LOW]_THR_INT_EN) necessary if
> status_high or status_low is true ?
> 
> Isn't possible to simplify that with:
> 
> eg.
> 
> 		if (!(ctl & ADC_TM5_M_MEAS_EN)
> 			continue;
> 
> 		if (!(status_high & BIT(ch)) && !(status_low & BIT(ch))
> 			continue;
> 
> 		thermal_zone_device_update(chip->channels[i].tzd,
> 					THERMAL_EVENT_UNSPECIFIED);
> 
> ??

I'd prefer to leave the check as is, having no information if status bit 
can be updated without actually triggering IRQ.

I've moved ADC_TM5_MEAS_EN check upwards to simplify this.

>> +static int adc_tm5_configure(struct adc_tm5_channel *channel, int low_temp, int high_temp)
>> +{
>> +	struct adc_tm5_chip *chip = channel->chip;
>> +	u8 buf[8];
>> +	u16 reg = ADC_TM5_M_ADC_CH_SEL_CTL(channel->channel);
>> +	int ret = 0;
>> +
>> +	ret = adc_tm5_read(chip, reg, buf, sizeof(buf));
>> +	if (ret) {
>> +		dev_err(chip->dev, "block read failed with %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Update ADC channel select */
>> +	buf[0] = channel->adc_channel;
>> +
>> +	/* Warm temperature corresponds to low voltage threshold */
>> +	if (high_temp != INT_MAX) {
>> +		u16 adc_code = qcom_adc_tm5_temp_volt_scale(channel->prescale,
>> +				chip->data->full_scale_code_volt, high_temp);
>> +
>> +		buf[1] = adc_code & 0xff;
>> +		buf[2] = adc_code >> 8;
>> +		buf[7] |= ADC_TM5_M_LOW_THR_INT_EN;
>> +	} else {
>> +		buf[7] &= ~ADC_TM5_M_LOW_THR_INT_EN;
>> +	}
>> +
>> +	/* Cool temperature corresponds to high voltage threshold */
>> +	if (low_temp != -INT_MAX) {
> 
> Is it really -INT_MAX ? or INT_MIN
> 
> -2147483647 vs -2147483648 ?

It is really -INT_MAX, see thermal_zone_set_trips().

[...]

>> +
>> +	for (i = 0; i < chip->nchannels; i++) {
>> +		if (chip->channels[i].channel >= channels_available) {
>> +			dev_err(chip->dev, "Invalid channel %d\n", chip->channels[i].channel);
>> +			return -EINVAL;
>> +		}
> 
> Is it a sanity check to make sure the hardware and the DT are compatible ?

Yes.


-- 
With best wishes
Dmitry
