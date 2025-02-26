Return-Path: <linux-iio+bounces-16082-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB00A458F1
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 09:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D26D16EFA3
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 08:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FA4226CE7;
	Wed, 26 Feb 2025 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="erPRtJ2j"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C211E22423C
	for <linux-iio@vger.kernel.org>; Wed, 26 Feb 2025 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559939; cv=none; b=ewxrZepVgzXzb96ft+MTPFPHF984Ep2uuTZ7YoUZsJfHmacM2GNgrkpvGhtM1a5C9lXthIaamymt//5Gu+1fPkSSjYdLHi411A03T+t5aUiPIPMuTtoCL0xpNDXJ6n8+FbJCxaqZi6KIvTeVYp+1CU0zKZjzD/I34x5M/1ocZnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559939; c=relaxed/simple;
	bh=SHqHPxYWSkL8Zv/j4bl0sxphQp/51KTNnqIURfoGHjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cijeSrXpcjRi+DrvuWw4PkZJppbhWzjZJ1fWPq8qQ1cxB4DTvnTqXXyuzw+pxbYT6Volk2vXgyqrdDVSsZremHgwdU32gLVhIQY8dVNaMTekAKtxG5PuOjbLNZOaNYUxpVHIBH+YZP89z+6lmPbe0j6tbvHar7FY+GF55eQzLds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=erPRtJ2j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PMWs5s021575
	for <linux-iio@vger.kernel.org>; Wed, 26 Feb 2025 08:52:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kNUK72sZs9KWjCoZr7DQrMgl5cnpWYtFImxz0nk1e54=; b=erPRtJ2jeq2t9/o1
	dInKZshmt8zS3LwzMk4DDZrULW+H8dp89UTtbFsuziFXNPXLLNTw7RrltYNxUlV+
	sN099Sfz+tLKnkHkEa2w7rG5MYneV5CuzIyn3h9Z8a1s50zzCgMzcu5CPDiYe8p6
	mokdW00RnAXBorotBdYL3knryw1/1IpR9zb9xKS2+lEYcSyr2FITg9ABKApgszZz
	lprmCTkklZz2xNPpprdF/4vAWLGlC3+s0RGw0EauEQodKqmv83G6ArppJC1L05hs
	j9SoT9l6vXAgsgo08q4udTJN2GcKU9vFYd/kTBFVyYdlpQw8hCP+x+vLPJrignJO
	NIZWRg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prkha7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Wed, 26 Feb 2025 08:52:14 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fc2fee4425so21909939a91.0
        for <linux-iio@vger.kernel.org>; Wed, 26 Feb 2025 00:52:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740559934; x=1741164734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kNUK72sZs9KWjCoZr7DQrMgl5cnpWYtFImxz0nk1e54=;
        b=rVy+RmGvBuKxViSlqHTbOgh8/tj/+D96n3DC6tMq1JwZvEBJPzWrO/UMkMG8SP0A5M
         3Ek8sfQcAI8AAkF21pbzQNLqWEmZsWm7WeOUzWvo3k9raiyL9GR+kDGk10VeOOBUtAmX
         d2/zwquYCDhxp1Vya9H9gvj4T4rwBB6jiY458Som1qyopm7MJNkCJKmxTNyUnsmxgYYt
         erd6+QDnyiYaNnxunQb628QW0/cK2lEuCQ8uMa97K5MSkmUau9u4BIlVPZ55gA+CdeJC
         44pt+MEinqBLau0s7b1asiX4Ie5mSr2XJo5Yt6dPXIm7Mflm2EXgSdfqvkriWLo92G4L
         17Dw==
X-Forwarded-Encrypted: i=1; AJvYcCW6ZtdWpBE1v5v5wu13sccjhpFRdr9SKwBMb+Ge+wK1iNxg3b2GhjyOGbT0i3+XwZ90ij/mJ2TeCxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyUbSKSDbtIfim5hlm7Cr15weSNrO4CvwwkzFiTs42eJ1yDGCS
	FUZtE4shTD7chrt+4+D+s4rfCbA8Xv/mdAxgiSiG1kBDX0WvEmP6mdX00fUJUmPfxE91+XygYQQ
	tMXKnU/aNlZiQxI7++DGVxtaDvS5zmhVLNcIa2eSW9/4ESHajc7TbIhWwB9w=
X-Gm-Gg: ASbGnctihgI0D0WmUQJDpyOtM9ucRM4oSGXXq9IdAl25UvAqUhY97A6SzjZw38CLc+4
	BYW6RSUMoDQ3x+nXUyKtebVLy7l+Nss9lHiYtULm6jFwxrMg5hdO7mBaFtaKl850Prs9DR8l6nA
	gP077/JRtRoZvWoJDFHtpxCdfpjZ7bu1qJvV+VtfUdnH/F3QC8opeS4DmHFvbb8Xm82eKXRuRdP
	23RJ5LZjv3b9yChXxUH3jJbcqlF/Ig9P43plJSROcAVIY+6QHedCR/T9hFxJc4EqG+qtsIltyU6
	Q8K1K4ne88I/w+yywxszY6TCgFk0NDGKYuE8+Qt0Txk1
X-Received: by 2002:a05:6a20:2589:b0:1ee:cf13:d4b5 with SMTP id adf61e73a8af0-1f10aecf31cmr4186105637.39.1740559933954;
        Wed, 26 Feb 2025 00:52:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEG4nP4qu9DW+6KNhRhO/rxs8jQZAT1wSZE3rc4OgTu5fEFsJjsU7+OetJq1IernkppMo1+xQ==
X-Received: by 2002:a05:6a20:2589:b0:1ee:cf13:d4b5 with SMTP id adf61e73a8af0-1f10aecf31cmr4186065637.39.1740559933436;
        Wed, 26 Feb 2025 00:52:13 -0800 (PST)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aedaab30076sm2669598a12.66.2025.02.26.00.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 00:52:13 -0800 (PST)
Message-ID: <9e14f58f-e345-4bae-b14e-de25fc28d9a8@oss.qualcomm.com>
Date: Wed, 26 Feb 2025 14:22:05 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 4/5] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, dmitry.baryshkov@linaro.org,
        konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
        amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org,
        rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        quic_kamalw@quicinc.com, rui.zhang@intel.com, lukasz.luba@arm.com,
        lars@metafoo.de, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, quic_skakitap@quicinc.com,
        neil.armstrong@linaro.org
References: <20250131183242.3653595-1-jishnu.prakash@oss.qualcomm.com>
 <20250131183242.3653595-5-jishnu.prakash@oss.qualcomm.com>
 <20250201121134.53040aae@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20250201121134.53040aae@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: MeEw7iBR-4RRAc_zEF6DD2hhnzeKDW1A
X-Proofpoint-ORIG-GUID: MeEw7iBR-4RRAc_zEF6DD2hhnzeKDW1A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_01,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260070

Hi Jonathan,

On 2/1/2025 5:41 PM, Jonathan Cameron wrote:
> On Sat,  1 Feb 2025 00:02:41 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
>> The ADC architecture on PMIC5 Gen3 is similar to that on PMIC5 Gen2,
>> with all SW communication to ADC going through PMK8550 which
>> communicates with other PMICs through PBS.
>>
>> One major difference is that the register interface used here is that
>> of an SDAM (Shared Direct Access Memory) peripheral present on PMK8550.
>> There may be more than one SDAM used for ADC5 Gen3 and each has eight
>> channels, which may be used for either immediate reads (same functionality
>> as previous PMIC5 and PMIC5 Gen2 ADC peripherals) or recurring measurements
>> (same as ADC_TM functionality).
>>
>> By convention, we reserve the first channel of the first SDAM for all
>> immediate reads and use the remaining channels across all SDAMs for
>> ADC_TM monitoring functionality.
>>
>> Add support for PMIC5 Gen3 ADC driver for immediate read functionality.
>> ADC_TM is implemented as an auxiliary thermal driver under this ADC
>> driver.
>>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> Hi,
> 
> A few minor things inline.  One general one is keep to under 80 chars
> for line wrap unless going over that makes a significant improvement
> to readability.
> 
> Jonathan
> 
>> ---
>> Changes since v4:
>> - Moved out common funtions from newly added .h file into a separate .c
>>   file to avoid duplicating them. Updated interrupt name as suggested
>>   by reviewer. Updated namespace export symbol statement to have a string
>>   as second argument to follow framework change.
>>

...

>> +
>> +			if (!conv_req)
>> +				return 0;
>> +		}
>> +
>> +		usleep_range(ADC5_GEN3_HS_DELAY_MIN_US, ADC5_GEN3_HS_DELAY_MAX_US);
> fsleep() perhaps as I doubt the extra tolerance that will give will matter
> much.
>> +	}
>> +
>> +	pr_err("Setting HS ready bit timed out, sdam_index:%d, status:%#x\n", sdam_index, status);
>> +	return -ETIMEDOUT;
>> +}
>> +EXPORT_SYMBOL(adc5_gen3_poll_wait_hs);
> 
> At some point may be worth namespacing all these exports.
> Probably not in this series though!

In the main driver file (qcom-spmi-adc5-gen3.c), I have already exported some functions to a namespace ("QCOM_SPMI_ADC5_GEN3"),
which is imported in the auxiliary driver file (qcom-spmi-adc-tm5-gen3.c).

Do you think I should export these functions to the same or a different namespace? Or should we check this later?


> 
>> diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
>> new file mode 100644
>> index 000000000000..9cdc2d5d2671
>> --- /dev/null
>> +++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
>> @@ -0,0 +1,724 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/bitops.h>
>> +#include <linux/completion.h>
>> +#include <linux/err.h>
>> +#include <linux/iio/adc/qcom-adc5-gen3-common.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/log2.h>
>> +#include <linux/math64.h>
>> +#include <linux/module.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/property.h>
>> +#include <linux/slab.h>
>> +#include <linux/thermal.h>
>> +#include <linux/unaligned.h>
>> +
>> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>> +
>> +#define ADC5_GEN3_VADC_SDAM			0x0
>> +
>> +struct adc5_chip;
>> +
>> +/*
>> + * @adc_tm: indicates TM type if the channel is used for TM measurements.
> 
> Add docs for common_props as well and might as well make this
> full kernel-doc.
> 
>> + * @chip: pointer to top-level ADC device structure.
>> + */
>> +
>> +struct adc5_channel_prop {
>> +	struct adc5_channel_common_prop common_props;
>> +	int				adc_tm;
>> +	struct adc5_chip		*chip;
>> +};
> 
> 
>> +
>> +static int adc5_gen3_read_raw(struct iio_dev *indio_dev,
>> +			      struct iio_chan_spec const *chan, int *val, int *val2,
>> +			      long mask)
>> +{
>> +	struct adc5_chip *adc = iio_priv(indio_dev);
>> +	struct adc5_channel_common_prop *prop;
>> +	u16 adc_code_volt;
>> +	int ret;
>> +
>> +	prop = &adc->chan_props[chan->address].common_props;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_PROCESSED:
>> +		ret = adc5_gen3_do_conversion(adc, prop, &adc_code_volt);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret = qcom_adc5_hw_scale(prop->scale_fn_type, prop->prescale,
>> +					 adc->data, adc_code_volt, val);
>> +		if (ret)
>> +			return ret;
>> +
>> +		return IIO_VAL_INT;
>> +	case IIO_CHAN_INFO_RAW:
>> +		ret = adc5_gen3_do_conversion(adc, prop, &adc_code_volt);
>> +		if (ret)
>> +			return ret;
>> +		*val = (int)adc_code_volt;
> 
> Why is the cast needed?

I think it's not needed, but this IIO_CHAN_INFO_RAW case itself may not be needed...I'll remove it.

> 
>> +		return IIO_VAL_INT;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
> 
>> +static const struct adc5_data adc5_gen3_data_pmic = {
>> +	.full_scale_code_volt = 0x70e4,
>> +	.adc_chans = adc5_gen3_chans_pmic,
>> +	.info = &adc5_gen3_info,
>> +	.decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
>> +				{85, 340, 1360},
>> +	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
>> +				{15, 100, 200, 300, 400, 500, 600, 700,
>> +				1000, 2000, 4000, 8000, 16000, 32000,
>> +				64000, 128000},
> 
> Trivial but I'm trying to slowly standardize formatting of this stuff
> in IIO.  So please add space after { and before }
> Also align the the first digit of first number in each row.
> 
> 
>> +};
> 
> 
>> +static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc)
>> +{
>> +	struct tm5_aux_dev_wrapper *aux_device;
>> +	int i, ret, i_tm = 0;
>> +
>> +	aux_device = devm_kzalloc(adc->dev, sizeof(*aux_device), GFP_KERNEL);
>> +	if (!aux_device)
>> +		return -ENOMEM;
>> +
>> +	aux_device->aux_dev.name = "adc5_tm_gen3";
>> +	aux_device->aux_dev.dev.parent = adc->dev;
>> +	aux_device->aux_dev.dev.release = adc5_gen3_aux_device_release;
>> +
>> +	aux_device->tm_props = devm_kcalloc(adc->dev, adc->n_tm_channels,
>> +					    sizeof(*aux_device->tm_props), GFP_KERNEL);
>> +	if (!aux_device->tm_props)
>> +		return -ENOMEM;
>> +
>> +	aux_device->dev_data = &adc->dev_data;
>> +
>> +	for (i = 0; i < adc->nchannels; i++) {
>> +		if (!adc->chan_props[i].adc_tm)
>> +			continue;
>> +		aux_device->tm_props[i_tm] = adc->chan_props[i].common_props;
>> +		i_tm++;
>> +	}
>> +
>> +	device_set_of_node_from_dev(&aux_device->aux_dev.dev, adc->dev);
>> +
>> +	aux_device->n_tm_channels = adc->n_tm_channels;
>> +
>> +	ret = auxiliary_device_init(&aux_device->aux_dev);
>> +	if (ret) {
>> +		kfree(&aux_device->aux_dev);
>> +		return ret;
>> +	}
>> +	ret = devm_add_action_or_reset(adc->dev, adc5_gen3_uninit_aux, &aux_device->aux_dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = auxiliary_device_add(&aux_device->aux_dev);
>> +	if (ret)
>> +		return ret;
>> +	ret = devm_add_action_or_reset(adc->dev, adc5_gen3_delete_aux, &aux_device->aux_dev);
>> +	if (!ret)
>> +		adc->tm_aux = &aux_device->aux_dev;
> Keep to errors out of line, even if it costs a line or two exta
> 	if (ret)
> 		return ret;
> 
> 	adc->tm_aux = &aux_device->aux_dev;
> 
> r	return 0;
>> +
>> +	return ret;
>> +}
>> +
>> +void adc5_take_mutex_lock(struct device *dev, bool lock)
>> +{
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
>> +	struct adc5_chip *adc = iio_priv(indio_dev);
>> +
>> +	if (lock)
>> +		mutex_lock(&adc->lock);
>> +	else
>> +		mutex_unlock(&adc->lock);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(adc5_take_mutex_lock, "QCOM_SPMI_ADC5_GEN3");
> 
> This is potentially going to make a mess for sparse.  Might be better to split
> it in two so you can had __acquires and __releases markings.
> 
> If you don't get any warnings with sparse then I guess we are fine.
> 

I had tried building with sparse in my local workspace and I did not get any errors in this file. Do you think I can keep this unchanged?
Also, would any kernel bots run sparse later on this patch, if it's not already done?


>> +
>> +int adc5_gen3_get_scaled_reading(struct device *dev, struct adc5_channel_common_prop *common_props,
>> +				 int *val)
>> +{
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
>> +	struct adc5_chip *adc = iio_priv(indio_dev);
>> +	u16 adc_code_volt;
>> +	int ret;
>> +
>> +	ret = adc5_gen3_do_conversion(adc, common_props, &adc_code_volt);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return qcom_adc5_hw_scale(common_props->scale_fn_type, common_props->prescale,
>> +		adc->data, adc_code_volt, val);
> 
> Whilst it feels like this could all have been done with generic in kernel consumer
> interfaces, I suppose that in this case the coupling is tight enough between
> the devices that there is no real purpose in doing so.
> 
>> +}
>> +EXPORT_SYMBOL_NS_GPL(adc5_gen3_get_scaled_reading, "QCOM_SPMI_ADC5_GEN3");
>> +
>> +int adc5_gen3_therm_code_to_temp(struct device *dev, struct adc5_channel_common_prop *common_props,
>> +				 u16 code, int *val)
>> +{
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
>> +	struct adc5_chip *adc = iio_priv(indio_dev);
>> +
>> +	return qcom_adc5_hw_scale(common_props->scale_fn_type, common_props->prescale,
>> +		adc->data, code, val);
> 
> Where it doesn't make much difference to readablity wrap to 80 chars and align parameters after (
> 
>> +}
>> +EXPORT_SYMBOL_NS_GPL(adc5_gen3_therm_code_to_temp, "QCOM_SPMI_ADC5_GEN3");
>> +
>> +static int adc5_gen3_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct iio_dev *indio_dev;
>> +	struct adc5_chip *adc;
>> +	struct regmap *regmap;
>> +	int ret, i;
>> +	u32 *reg;
>> +
>> +	regmap = dev_get_regmap(dev->parent, NULL);
>> +	if (!regmap)
>> +		return -ENODEV;
>> +
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	adc = iio_priv(indio_dev);
>> +	adc->dev_data.regmap = regmap;
>> +	adc->dev = dev;
>> +
>> +	ret = device_property_count_u32(dev, "reg");
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	adc->num_sdams = ret;
>> +	adc->dev_data.num_sdams = adc->num_sdams;
> 
> why do we need two copies?

You're right, adc->num_sdams is not needed, I'll remove it.

> 
>> +
>> +	reg = devm_kcalloc(dev, adc->num_sdams, sizeof(u32), GFP_KERNEL);
>> +	if (!reg)
>> +		return -ENOMEM;
>> +
>> +	ret = device_property_read_u32_array(dev, "reg", reg, adc->num_sdams);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to read reg property, ret = %d\n", ret);
> 
> Look at how dev_err_probe works. You should not be explicitly printing ret.
> Fix all instances of this (and if copied from another driver, feel free to fix that too!)
> 
>> +
>> +	adc->dev_data.base = devm_kcalloc(dev, adc->num_sdams, sizeof(*adc->dev_data.base),
>> +					  GFP_KERNEL);
>> +	if (!adc->dev_data.base)
>> +		return -ENOMEM;
>> +
>> +	platform_set_drvdata(pdev, indio_dev);
>> +	init_completion(&adc->complete);
>> +	mutex_init(&adc->lock);
>> +
>> +	for (i = 0; i < adc->num_sdams; i++) {
>> +		adc->dev_data.base[i].base_addr = reg[i];
>> +
>> +		adc->dev_data.base[i].irq_name = devm_kasprintf(dev, GFP_KERNEL, "sdam%d", i);
>> +		if (!adc->dev_data.base[i].irq_name)
>> +			return -ENOMEM;
>> +
>> +		ret = platform_get_irq_byname(pdev, adc->dev_data.base[i].irq_name);
>> +		if (ret < 0)
>> +			return dev_err_probe(dev, ret, "Getting IRQ %d by name failed, ret = %d\n",
>> +					adc->dev_data.base[i].irq, ret);
>> +		adc->dev_data.base[i].irq = ret;
>> +	}
>> +
>> +	ret = devm_request_irq(dev, adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq, adc5_gen3_isr,
>> +			       0, adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq_name, adc);
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret, "Failed to request SDAM%d irq, ret = %d\n",
>> +				ADC5_GEN3_VADC_SDAM, ret);
>> +
>> +	ret = adc5_get_fw_data(adc);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if (adc->n_tm_channels > 0)
>> +		adc5_gen3_add_aux_tm_device(adc);
>> +
>> +	indio_dev->name = pdev->name;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->info = &adc5_gen3_info;
>> +	indio_dev->channels = adc->iio_chans;
>> +	indio_dev->num_channels = adc->nchannels;
>> +
>> +	return devm_iio_device_register(dev, indio_dev);
>> +}
> 
>> diff --git a/include/linux/iio/adc/qcom-adc5-gen3-common.h b/include/linux/iio/adc/qcom-adc5-gen3-common.h
>> new file mode 100644
>> index 000000000000..66edbf0ae137
>> --- /dev/null
>> +++ b/include/linux/iio/adc/qcom-adc5-gen3-common.h
>> @@ -0,0 +1,164 @@
> ...
> 
> 
>> +#define ADC5_GEN3_VIRTUAL_SID_MASK			GENMASK(15, 8)
>> +#define ADC5_GEN3_CHANNEL_MASK			GENMASK(7, 0)
>> +#define V_CHAN(x)		\
>> +	(FIELD_PREP(ADC5_GEN3_VIRTUAL_SID_MASK, (x).sid) | (x).channel)	\
> 
> That trailing \ makes little sense and will be fragile to white space
> changes.
> 
>> +
>> +enum adc5_cal_method {
>> +	ADC5_NO_CAL = 0,
>> +	ADC5_RATIOMETRIC_CAL,
>> +	ADC5_ABSOLUTE_CAL
> 
> Add a comma on trailing item.  Not immediately obvious we will never
> get anything after this so convention is to have that comma.
> That doesn't apply for terminating entries that we must not add
> antyhing after.
> 
>> +};
> ...
>> +/*
> 
> Looks like valid kernel doc, so /** and check it builds fine
> with the kernel-doc script.
> 
>> + * struct adc5_channel_prop - ADC channel property.
>> + * @channel: channel number, refer to the channel list.
>> + * @cal_method: calibration method.
>> + * @decimation: sampling rate supported for the channel.
>> + * @sid: slave id of PMIC owning the channel.
> 
> In common with most of the kernel, if there is another name that
> can be used, I'd prefer avoiding that term.
> ID probably fine for example or leave it ambiguous as SID
> 

Just to be sure, does this look fine?

@sid: ID of PMIC owning the channel.

I'll address all your other comments in the next patch series.

Thanks,
Jishnu


>> + * @label: Channel name used in device tree.
>> + * @prescale: channel scaling performed on the input signal.
>> + * @hw_settle_time: the time between AMUX being configured and the
>> + *	start of conversion.
> 
> Good to include units in the docs and maybe the field name.
> 
>> + * @avg_samples: ability to provide single result from the ADC
>> + *	that is an average of multiple measurements.
>> + * @scale_fn_type: Represents the scaling function to convert voltage
>> + *	physical units desired by the client for the channel.
>> + */
>> +struct adc5_channel_common_prop {
>> +	unsigned int			channel;
>> +	enum adc5_cal_method		cal_method;
>> +	unsigned int			decimation;
>> +	unsigned int			sid;
>> +	const char			*label;
>> +	unsigned int			prescale;
>> +	unsigned int			hw_settle_time;
>> +	unsigned int			avg_samples;
>> +	enum vadc_scale_fn_type		scale_fn_type;
>> +};
>> +
>> +struct tm5_aux_dev_wrapper {
>> +	struct auxiliary_device aux_dev;
>> +	struct adc5_device_data *dev_data;
>> +	struct adc5_channel_common_prop *tm_props;
>> +	unsigned int			n_tm_channels;
> 
> Odd indent on that last item.  Just stick to one space.
> I'd do that for all structures as trying to align has a nasty habit of
> needing noisy changes as a driver evolves in a desperate attempt to keep
> things looking pretty.
> 
>> +};
>> +
>> +struct adc_tm5_auxiliary_drv {
>> +	struct auxiliary_driver adrv;
>> +	void (*tm_event_notify)(struct auxiliary_device *adev);
>> +};
>> +
>> +int adc5_gen3_read(struct adc5_device_data *adc, unsigned int sdam_index,
>> +		   u16 offset, u8 *data, int len);
>> +
>> +int adc5_gen3_write(struct adc5_device_data *adc, unsigned int sdam_index,
>> +		    u16 offset, u8 *data, int len);
>> +
>> +int adc5_gen3_poll_wait_hs(struct adc5_device_data *adc, unsigned int sdam_index);
>> +
>> +void adc5_gen3_update_dig_param(struct adc5_channel_common_prop *prop, u8 *data);
>> +
>> +int adc5_gen3_status_clear(struct adc5_device_data *adc,
>> +			   int sdam_index, u16 offset, u8 *val, int len);
>> +
>> +void adc5_take_mutex_lock(struct device *dev, bool lock);
>> +int adc5_gen3_get_scaled_reading(struct device *dev, struct adc5_channel_common_prop *common_props,
> 
> Very long lines. Please add a break after dev,
> 
> Generally I prefer that we still aim for 80 chars in IIO, but a bit
> over is fine if useful for readability.
> 
>> +				 int *val);
>> +int adc5_gen3_therm_code_to_temp(struct device *dev, struct adc5_channel_common_prop *common_props,
>> +				 u16 code, int *val);
>> +
>> +#endif /* QCOM_ADC5_GEN3_COMMON_H */
> 


