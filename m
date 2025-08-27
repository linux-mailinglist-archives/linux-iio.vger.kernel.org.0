Return-Path: <linux-iio+bounces-23324-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A731B37752
	for <lists+linux-iio@lfdr.de>; Wed, 27 Aug 2025 03:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB0A361298
	for <lists+linux-iio@lfdr.de>; Wed, 27 Aug 2025 01:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276931E00B4;
	Wed, 27 Aug 2025 01:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hm+mkatJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFA14438B
	for <linux-iio@vger.kernel.org>; Wed, 27 Aug 2025 01:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756259059; cv=none; b=BN/pGTVz/1U7CCObBfOJOqk3V68WY5YHWUyM8lCY4D1cSwnOu7zz2J0+CpWdiu0kn1PRxKMx526LHnjkI1sU3cKdzbR79t+giQiPBcHeNuOLRSJLnAIJXr1X7P4i8HHqA/az0I4hcTLClptjTgCOeFCfHT1Z0AKxnM75QRE+AC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756259059; c=relaxed/simple;
	bh=dKjs2983ZxyVi0mEiN1NtRF9/2WZAZcDaqQfPZaWiC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HaEEs0ivOq9NNShIkLAyEfmGUulKsTaqELsY4BTwmORcpe1VE+jQUmw85AIxgOk8Z3boPJUFREZioVC1Fw8r0K7LK1j6SXYi1iVlY1T+jIf0NY+qI+nkzo4QMw6K7qJ34r+JpN6kLzXiVPsvW2wys1LnX9Kja6tyCz1XxS2BTkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hm+mkatJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QJIO8k026983
	for <linux-iio@vger.kernel.org>; Wed, 27 Aug 2025 01:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=cPTYAG/452O6PAkt5PfXPTLy
	0Tfh5zuhGY6djk+Zmuo=; b=Hm+mkatJEGKX88QQPWtBHeNgAIlxClrMtqyEchAX
	1havqueViTtMnVyclWUbR1NLtD3MUPP7SX2fKMEhFqtHsi0S5GTdEd++9IPo+6m8
	1myehzeDaSrZrwbVqaWYGbxETR3967FTV387xNLlhrGihebE+wC0F7Bf7DlJBoxu
	4mANop2w/g5zgyK0VhBD03Tz1QVlsPup3r8Eosq7qX77iodPHXgZOWHfn7VIxepo
	dgGsNMJ1vKV0zsGsWLBc8O1N855tf4j+X+rolUKJ2hNuh2t4+3QFLXf692hpi3be
	nFE/E57LGm6tSNee5NUyp2Xgvi7OmNyB1gdilfHSt9ig+Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6x8b0ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Wed, 27 Aug 2025 01:44:13 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b1098f6142so121251601cf.0
        for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 18:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756259053; x=1756863853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPTYAG/452O6PAkt5PfXPTLy0Tfh5zuhGY6djk+Zmuo=;
        b=np28TMym4GrRRRg6+LNb/eDA3kIS66c40SVWHnyQWTQ4PpFrlv/0PtJKWUmTvhjSf1
         5C4u3h3EMDOwFZi2A72/caNNKouv8rMwvVDvkHtQyuglyZCkwVm+UDkaAJam1D9Cgutw
         3mtLcabQnBakhmpRE6EEDYfvaz6aikIfTz5X+d/CJgJVQ53LWI8SbVYjB8ohvZ4OOuZg
         9RA6r50yFIYYwf8fUyg8H1OANpPgzFRyejUDViqsK7yW11M39jt7fPdUbcEWkb4VRIYD
         mvwidTsL3KqPrsDW0ODSpgHMsdqP8PV0fFmvRhB9+uETXtKKieoAhSYCTit3SuN+A2z/
         FBHA==
X-Forwarded-Encrypted: i=1; AJvYcCV02r+BMAiOqgvV689g4mvGXwkWI6fLpWlTOzN7a5KFORDAloDCUATwjDyMFC0avNRJXdW4Cj6fcH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhs2w+bj8OgFo6HnIr84clDEe/zPjP3eJxnO0mbSSWWwDTkw5j
	DUizYTPn2LzVRPRMP/mxNkXnp0bCr7ManD4m4DNFQrCK20a+Xbh4ij9TIbnbMHKYU7nevic2QLq
	oNN5nTKP7+ehnEMmL5z8w6Xaa6GS8mB8T0XndkrbDb/EHrRxB79jGda9vd3p8cUQ=
X-Gm-Gg: ASbGncuhnxv1AeNQhUfdrkOwiH0A3r/4TxVCOVVK4TK8i/KI3rF/M+VxjnIVQKcLPbd
	/Fehn1Yep50H0IErl/SsbhDf6edxVJcKytRhFszZaEMCvQB3tUETEzh8hkSK1LVRXzDqpVo6nkW
	vUETSHmijvL/WPcBuQgA2VWu7JTMp1LEVla9+CGyhqevv80XGoOtrhEbxxUbsuahL/Y42HFqibr
	0axk2P8GZFuIWrwCbEcm7HFJ1OXqsyyRo2zZo/lZf1mikE+Zmbw4FEOLQt+9/AwwADkt5SciAD/
	P12CgMgz2UmAeG2Kq7qmruMfQp5kQY/fPl7NHDsaEbvr3qUG2zzEGydeo91YNdde7l6DpRe8Om3
	ycE5tr9CosOF2UIcz4zdcheEq5ejsqoe1soXOt8HBpuX/+S8zMJ5X
X-Received: by 2002:a05:622a:189c:b0:4aa:9393:7b5b with SMTP id d75a77b69052e-4b2aab040a2mr220484741cf.41.1756259052287;
        Tue, 26 Aug 2025 18:44:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2/MolgY3oV20U/gqZfCcmkVsOze4HT6JXxNL47pPZRzMziJ73YvCGpQjDcDh6EYfh86/kVA==
X-Received: by 2002:a05:622a:189c:b0:4aa:9393:7b5b with SMTP id d75a77b69052e-4b2aab040a2mr220484291cf.41.1756259051577;
        Tue, 26 Aug 2025 18:44:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35cb32fesm2568426e87.155.2025.08.26.18.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 18:44:09 -0700 (PDT)
Date: Wed, 27 Aug 2025 04:44:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: jic23@kernel.org, robh@kernel.org, krzysztof.kozlowski@linaro.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, agross@kernel.org,
        andersson@kernel.org, lumag@kernel.org, konradybcio@kernel.org,
        daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
        thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
        subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com,
        lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
        neil.armstrong@linaro.org, stephan.gerhold@linaro.org
Subject: Re: [PATCH V7 5/5] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
Message-ID: <drcxf6a37lgco6bmuuotdnbvsqjnmtlesxvacntcwuhu5cfa7v@nceiiyjeb4kp>
References: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
 <20250826083657.4005727-6-jishnu.prakash@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826083657.4005727-6-jishnu.prakash@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: z6Ue5RJ2ijfHGUj0A8zdasaNq_DvU11h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0NCBTYWx0ZWRfX/OzitmqIWEU6
 V5RD/XT2Z+/68XNMGS+Va3OLeAYysdddZMDeWu8TvjT8x3MDOg9AZjJZgh65LD3uHIBZA0wHygX
 VbE/Vz21x+V+WMa6PuQq/N5shMyvaYoXyoYNUOfGBqcwOvYy/dad0wfgdgL4CJHM/gSPQro1x/v
 cQq8EPYFTI1FKjtrNkamRyhCyeXJwaENuFC3aORNYHwVCA6sLvCto2KyRMGa3NuvAk2T+oKW5dq
 V3WHyQhaAGmwpSoQ1XsTgtRwfz7Z42iaja9+Jy1LnDh7NnSPUrEctbhrnR7rUIX+EAPpRxhCm22
 vG1pYW7n91jMj7jI2fR9QaaaVxgbaD1ZssLLe55Uego43da2ZrVGrlg/FpCViBryJZCeGtU8DMa
 icR5y6is
X-Proofpoint-GUID: z6Ue5RJ2ijfHGUj0A8zdasaNq_DvU11h
X-Authority-Analysis: v=2.4 cv=Ep/SrTcA c=1 sm=1 tr=0 ts=68ae62ee cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=XKre6dBN9omjd05BpDwA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230044

On Tue, Aug 26, 2025 at 02:06:57PM +0530, Jishnu Prakash wrote:
> Add support for ADC_TM part of PMIC5 Gen3.
> 
> This is an auxiliary driver under the Gen3 ADC driver, which implements the
> threshold setting and interrupt generating functionalities of QCOM ADC_TM
> drivers, used to support thermal trip points.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> ---
> Changes since v6:
> - Addressed minor reviewer comments.

This changelog is useless, it doesn't tell me, what has actually
changed.

> 
> Changes since v5:
> - Addressed reviewer comments related to kernel-doc formatting and other changes.
> 
> Changes since v4:
> - Fixed a compilation error and updated dependencies in config as suggested
>   by reviewer.
> 
>  drivers/thermal/qcom/Kconfig                  |   9 +
>  drivers/thermal/qcom/Makefile                 |   1 +
>  drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 535 ++++++++++++++++++
>  3 files changed, 545 insertions(+)
>  create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
> 
> diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
> index 2c7f3f9a26eb..f9baadbbf598 100644
> --- a/drivers/thermal/qcom/Kconfig
> +++ b/drivers/thermal/qcom/Kconfig
> @@ -21,6 +21,15 @@ config QCOM_SPMI_ADC_TM5
>  	  Thermal client sets threshold temperature for both warm and cool and
>  	  gets updated when a threshold is reached.
>  
> +config QCOM_SPMI_ADC_TM5_GEN3
> +	tristate "Qualcomm SPMI PMIC Thermal Monitor ADC5 Gen3"
> +	depends on QCOM_SPMI_ADC5_GEN3
> +	help
> +	  This enables the auxiliary thermal driver for the ADC5 Gen3 thermal
> +	  monitoring device. It shows up as a thermal zone with multiple trip points.
> +	  Thermal client sets threshold temperature for both warm and cool and
> +	  gets updated when a threshold is reached.
> +
>  config QCOM_SPMI_TEMP_ALARM
>  	tristate "Qualcomm SPMI PMIC Temperature Alarm"
>  	depends on OF && SPMI && IIO
> diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
> index 0fa2512042e7..828d9e7bc797 100644
> --- a/drivers/thermal/qcom/Makefile
> +++ b/drivers/thermal/qcom/Makefile
> @@ -4,5 +4,6 @@ obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
>  qcom_tsens-y			+= tsens.o tsens-v2.o tsens-v1.o tsens-v0_1.o \
>  				   tsens-8960.o
>  obj-$(CONFIG_QCOM_SPMI_ADC_TM5)	+= qcom-spmi-adc-tm5.o
> +obj-$(CONFIG_QCOM_SPMI_ADC_TM5_GEN3)	+= qcom-spmi-adc-tm5-gen3.o
>  obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
>  obj-$(CONFIG_QCOM_LMH)		+= lmh.o
> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
> new file mode 100644
> index 000000000000..9ec0d4e058b8
> --- /dev/null
> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
> @@ -0,0 +1,535 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/iio/adc/qcom-adc5-gen3-common.h>
> +#include <linux/iio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/thermal.h>
> +#include <linux/unaligned.h>
> +
> +#include "../thermal_hwmon.h"
> +
> +struct adc_tm5_gen3_chip;
> +
> +/**
> + * struct adc_tm5_gen3_channel_props - ADC_TM channel structure
> + * @timer: time period of recurring TM measurement.
> + * @tm_chan_index: TM channel number used (ranging from 1-7).
> + * @sdam_index: SDAM on which this TM channel lies.
> + * @common_props: structure withcommon  ADC channel properties.
> + * @high_thr_en: TM high threshold crossing detection enabled.
> + * @low_thr_en: TM low threshold crossing detection enabled.
> + * @chip: ADC TM device.
> + * @tzd: pointer to thermal device corresponding to TM channel.
> + * @last_temp: last temperature that caused threshold violation,
> + *	or a thermal TM channel.
> + * @last_temp_set: indicates if last_temp is stored.
> + */
> +struct adc_tm5_gen3_channel_props {
> +	unsigned int timer;
> +	unsigned int tm_chan_index;
> +	unsigned int sdam_index;
> +	struct adc5_channel_common_prop common_props;
> +	bool high_thr_en;
> +	bool low_thr_en;
> +	struct adc_tm5_gen3_chip *chip;
> +	struct thermal_zone_device *tzd;
> +	int last_temp;
> +	bool last_temp_set;
> +};
> +
> +/**
> + * struct adc_tm5_gen3_chip - ADC Thermal Monitoring device structure
> + * @dev_data: Top-level ADC device data.
> + * @chan_props: Array of ADC_TM channel structures.
> + * @nchannels: number of TM channels allocated
> + * @dev: SPMI ADC5 Gen3 device.
> + * @tm_handler_work: handler for TM interrupt for threshold violation.
> + */
> +struct adc_tm5_gen3_chip {
> +	struct adc5_device_data *dev_data;
> +	struct adc_tm5_gen3_channel_props *chan_props;
> +	unsigned int nchannels;
> +	struct device *dev;
> +	struct work_struct tm_handler_work;
> +};
> +
> +static int get_sdam_from_irq(struct adc_tm5_gen3_chip *adc_tm5, int irq)
> +{
> +	int i;
> +
> +	for (i = 0; i < adc_tm5->dev_data->num_sdams; i++) {
> +		if (adc_tm5->dev_data->base[i].irq == irq)
> +			return i;
> +	}
> +	return -ENOENT;
> +}
> +
> +static irqreturn_t adctm5_gen3_isr(int irq, void *dev_id)
> +{
> +	struct adc_tm5_gen3_chip *adc_tm5 = dev_id;
> +	u8 status, tm_status[2], val;
> +	int ret, sdam_num;
> +
> +	sdam_num = get_sdam_from_irq(adc_tm5, irq);
> +	if (sdam_num < 0) {
> +		dev_err(adc_tm5->dev, "adc irq %d not associated with an sdam\n",
> +			irq);
> +		return IRQ_HANDLED;
> +	}
> +
> +	ret = adc5_gen3_read(adc_tm5->dev_data, sdam_num, ADC5_GEN3_STATUS1,
> +			     &status, sizeof(status));
> +	if (ret) {
> +		dev_err(adc_tm5->dev, "adc read status1 failed with %d\n", ret);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (status & ADC5_GEN3_STATUS1_CONV_FAULT) {
> +		dev_err_ratelimited(adc_tm5->dev,
> +				    "Unexpected conversion fault, status:%#x\n",
> +				    status);
> +		val = ADC5_GEN3_CONV_ERR_CLR_REQ;
> +		adc5_gen3_status_clear(adc_tm5->dev_data, sdam_num,
> +				       ADC5_GEN3_CONV_ERR_CLR, &val, 1);
> +		return IRQ_HANDLED;
> +	}
> +
> +	ret = adc5_gen3_read(adc_tm5->dev_data, sdam_num, ADC5_GEN3_TM_HIGH_STS,
> +			     tm_status, sizeof(tm_status));
> +	if (ret) {
> +		dev_err(adc_tm5->dev, "adc read TM status failed with %d\n", ret);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (tm_status[0] || tm_status[1])
> +		schedule_work(&adc_tm5->tm_handler_work);
> +
> +	dev_dbg(adc_tm5->dev, "Interrupt status:%#x, high:%#x, low:%#x\n",
> +		status, tm_status[0], tm_status[1]);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int adc5_gen3_tm_status_check(struct adc_tm5_gen3_chip *adc_tm5,
> +				     int sdam_index, u8 *tm_status, u8 *buf)
> +{
> +	int ret;
> +
> +	ret = adc5_gen3_read(adc_tm5->dev_data, sdam_index, ADC5_GEN3_TM_HIGH_STS,
> +			     tm_status, 2);
> +	if (ret) {
> +		dev_err(adc_tm5->dev, "adc read TM status failed with %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = adc5_gen3_status_clear(adc_tm5->dev_data, sdam_index, ADC5_GEN3_TM_HIGH_STS_CLR,
> +				     tm_status, 2);
> +	if (ret) {
> +		dev_err(adc_tm5->dev, "adc status clear conv_req failed with %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ret = adc5_gen3_read(adc_tm5->dev_data, sdam_index, ADC5_GEN3_CH_DATA0(0),
> +			     buf, 16);
> +	if (ret)
> +		dev_err(adc_tm5->dev, "adc read data failed with %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static void tm_handler_work(struct work_struct *work)
> +{
> +	struct adc_tm5_gen3_chip *adc_tm5 = container_of(work, struct adc_tm5_gen3_chip,
> +							 tm_handler_work);
> +	struct adc_tm5_gen3_channel_props *chan_prop;
> +	u8 tm_status[2] = {0};
> +	u8 buf[16] = {0};
> +	int i, ret = 0, sdam_index = -1;
> +
> +	for (i = 0; i < adc_tm5->nchannels; i++) {
> +		bool upper_set = false, lower_set = false;
> +		int temp, offset;
> +		u16 code = 0;
> +
> +		chan_prop = &adc_tm5->chan_props[i];
> +		offset = chan_prop->tm_chan_index;
> +
> +		adc5_gen3_mutex_lock(adc_tm5->dev);
> +		if (chan_prop->sdam_index != sdam_index) {
> +			sdam_index = chan_prop->sdam_index;
> +			ret = adc5_gen3_tm_status_check(adc_tm5, sdam_index,
> +							tm_status, buf);
> +			if (ret) {
> +				adc5_gen3_mutex_unlock(adc_tm5->dev);
> +				break;
> +			}
> +		}
> +
> +		if ((tm_status[0] & BIT(offset)) && chan_prop->high_thr_en)
> +			upper_set = true;
> +
> +		if ((tm_status[1] & BIT(offset)) && chan_prop->low_thr_en)
> +			lower_set = true;
> +		adc5_gen3_mutex_unlock(adc_tm5->dev);
> +
> +		if (!(upper_set || lower_set))
> +			continue;
> +
> +		code = get_unaligned_le16(&buf[2 * offset]);
> +		pr_debug("ADC_TM threshold code:%#x\n", code);
> +
> +		ret = adc5_gen3_therm_code_to_temp(adc_tm5->dev,
> +						   &chan_prop->common_props,
> +						   code, &temp);
> +		if (ret) {
> +			dev_err(adc_tm5->dev,
> +				"Invalid temperature reading, ret = %d, code=%#x\n",
> +				ret, code);
> +			continue;
> +		}
> +
> +		chan_prop->last_temp = temp;
> +		chan_prop->last_temp_set = true;
> +		thermal_zone_device_update(chan_prop->tzd, THERMAL_TRIP_VIOLATED);
> +	}
> +}
> +
> +static int adc_tm5_gen3_get_temp(struct thermal_zone_device *tz, int *temp)
> +{
> +	struct adc_tm5_gen3_channel_props *prop = thermal_zone_device_priv(tz);
> +	struct adc_tm5_gen3_chip *adc_tm5;
> +
> +	if (!prop || !prop->chip)
> +		return -EINVAL;
> +
> +	adc_tm5 = prop->chip;
> +
> +	if (prop->last_temp_set) {
> +		pr_debug("last_temp: %d\n", prop->last_temp);
> +		prop->last_temp_set = false;
> +		*temp = prop->last_temp;
> +		return 0;
> +	}
> +
> +	return adc5_gen3_get_scaled_reading(adc_tm5->dev, &prop->common_props,
> +					    temp);
> +}
> +
> +static int _adc_tm5_gen3_disable_channel(struct adc_tm5_gen3_channel_props *prop)
> +{
> +	struct adc_tm5_gen3_chip *adc_tm5 = prop->chip;
> +	int ret;
> +	u8 val;
> +
> +	prop->high_thr_en = false;
> +	prop->low_thr_en = false;
> +
> +	ret = adc5_gen3_poll_wait_hs(adc_tm5->dev_data, prop->sdam_index);
> +	if (ret)
> +		return ret;
> +
> +	val = BIT(prop->tm_chan_index);
> +	ret = adc5_gen3_write(adc_tm5->dev_data, prop->sdam_index,
> +			      ADC5_GEN3_TM_HIGH_STS_CLR, &val, sizeof(val));
> +	if (ret)
> +		return ret;
> +
> +	val = MEAS_INT_DISABLE;
> +	ret = adc5_gen3_write(adc_tm5->dev_data, prop->sdam_index,
> +			      ADC5_GEN3_TIMER_SEL, &val, sizeof(val));
> +	if (ret)
> +		return ret;
> +
> +	/* To indicate there is an actual conversion request */
> +	val = ADC5_GEN3_CHAN_CONV_REQ | prop->tm_chan_index;
> +	ret = adc5_gen3_write(adc_tm5->dev_data, prop->sdam_index,
> +			      ADC5_GEN3_PERPH_CH, &val, sizeof(val));
> +	if (ret)
> +		return ret;
> +
> +	val = ADC5_GEN3_CONV_REQ_REQ;
> +	return adc5_gen3_write(adc_tm5->dev_data, prop->sdam_index,
> +			       ADC5_GEN3_CONV_REQ, &val, sizeof(val));
> +}
> +
> +static int adc_tm5_gen3_disable_channel(struct adc_tm5_gen3_channel_props *prop)
> +{
> +	return _adc_tm5_gen3_disable_channel(prop);
> +}
> +
> +# define ADC_TM5_GEN3_CONFIG_REGS 12
> +
> +static int adc_tm5_gen3_configure(struct adc_tm5_gen3_channel_props *prop,
> +				  int low_temp, int high_temp)
> +{
> +	struct adc_tm5_gen3_chip *adc_tm5 = prop->chip;
> +	u8 conv_req = 0, buf[ADC_TM5_GEN3_CONFIG_REGS];
> +	u16 adc_code;
> +	int ret;
> +
> +	ret = adc5_gen3_poll_wait_hs(adc_tm5->dev_data, prop->sdam_index);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adc5_gen3_read(adc_tm5->dev_data, prop->sdam_index,
> +			     ADC5_GEN3_SID, buf, sizeof(buf));
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Write SID */
> +	buf[0] = FIELD_PREP(ADC5_GEN3_SID_MASK, prop->common_props.sid);
> +
> +	/*
> +	 * Select TM channel and indicate there is an actual
> +	 * conversion request
> +	 */
> +	buf[1] = ADC5_GEN3_CHAN_CONV_REQ | prop->tm_chan_index;
> +
> +	buf[2] = prop->timer;
> +
> +	/* Digital param selection */
> +	adc5_gen3_update_dig_param(&prop->common_props, &buf[3]);
> +
> +	/* Update fast average sample value */
> +	buf[4] &= ~ADC5_GEN3_FAST_AVG_CTL_SAMPLES_MASK;
> +	buf[4] |= prop->common_props.avg_samples | ADC5_GEN3_FAST_AVG_CTL_EN;
> +
> +	/* Select ADC channel */
> +	buf[5] = prop->common_props.channel;
> +
> +	/* Select HW settle delay for channel */
> +	buf[6] = FIELD_PREP(ADC5_GEN3_HW_SETTLE_DELAY_MASK,
> +			    prop->common_props.hw_settle_time_us);
> +
> +	/* High temperature corresponds to low voltage threshold */
> +	if (high_temp != INT_MAX) {
> +		prop->low_thr_en = true;
> +		adc_code = qcom_adc_tm5_gen2_temp_res_scale(high_temp);
> +		put_unaligned_le16(adc_code, &buf[8]);
> +	} else {
> +		prop->low_thr_en = false;
> +	}
> +
> +	/* Low temperature corresponds to high voltage threshold */
> +	if (low_temp != -INT_MAX) {
> +		prop->high_thr_en = true;
> +		adc_code = qcom_adc_tm5_gen2_temp_res_scale(low_temp);
> +		put_unaligned_le16(adc_code, &buf[10]);
> +	} else {
> +		prop->high_thr_en = false;
> +	}
> +
> +	buf[7] = 0;
> +	if (prop->high_thr_en)
> +		buf[7] |= ADC5_GEN3_HIGH_THR_INT_EN;
> +	if (prop->low_thr_en)
> +		buf[7] |= ADC5_GEN3_LOW_THR_INT_EN;
> +
> +	ret = adc5_gen3_write(adc_tm5->dev_data, prop->sdam_index, ADC5_GEN3_SID,
> +			      buf, sizeof(buf));
> +	if (ret < 0)
> +		return ret;
> +
> +	conv_req = ADC5_GEN3_CONV_REQ_REQ;
> +	return adc5_gen3_write(adc_tm5->dev_data, prop->sdam_index,
> +			       ADC5_GEN3_CONV_REQ, &conv_req, sizeof(conv_req));
> +}
> +
> +static int adc_tm5_gen3_set_trip_temp(struct thermal_zone_device *tz,
> +				      int low_temp, int high_temp)
> +{
> +	struct adc_tm5_gen3_channel_props *prop = thermal_zone_device_priv(tz);
> +	struct adc_tm5_gen3_chip *adc_tm5;
> +	int ret;
> +
> +	if (!prop || !prop->chip)
> +		return -EINVAL;
> +
> +	adc_tm5 = prop->chip;
> +
> +	dev_dbg(adc_tm5->dev, "channel:%s, low_temp(mdegC):%d, high_temp(mdegC):%d\n",
> +		prop->common_props.label, low_temp, high_temp);
> +
> +	adc5_gen3_mutex_lock(adc_tm5->dev);
> +	if (high_temp == INT_MAX && low_temp <= -INT_MAX)
> +		ret = adc_tm5_gen3_disable_channel(prop);
> +	else
> +		ret = adc_tm5_gen3_configure(prop, low_temp, high_temp);
> +	adc5_gen3_mutex_unlock(adc_tm5->dev);
> +
> +	return ret;
> +}
> +
> +static const struct thermal_zone_device_ops adc_tm_ops = {
> +	.get_temp = adc_tm5_gen3_get_temp,
> +	.set_trips = adc_tm5_gen3_set_trip_temp,
> +};
> +
> +static int adc_tm5_register_tzd(struct adc_tm5_gen3_chip *adc_tm5)
> +{
> +	unsigned int i, channel;
> +	struct thermal_zone_device *tzd;
> +	int ret;
> +
> +	for (i = 0; i < adc_tm5->nchannels; i++) {
> +		channel = ADC5_GEN3_V_CHAN(adc_tm5->chan_props[i].common_props);
> +		tzd = devm_thermal_of_zone_register(adc_tm5->dev, channel,
> +						    &adc_tm5->chan_props[i],
> +						    &adc_tm_ops);
> +
> +		if (IS_ERR(tzd)) {
> +			if (PTR_ERR(tzd) == -ENODEV) {
> +				dev_warn(adc_tm5->dev,
> +					 "thermal sensor on channel %d is not used\n",
> +					 channel);
> +				continue;
> +			}
> +			return dev_err_probe(adc_tm5->dev, PTR_ERR(tzd),
> +					     "Error registering TZ zone:%ld for channel:%d\n",
> +					     PTR_ERR(tzd), channel);
> +		}
> +		adc_tm5->chan_props[i].tzd = tzd;
> +		ret = devm_thermal_add_hwmon_sysfs(adc_tm5->dev, tzd);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
> +static void adc5_gen3_clear_work(void *data)
> +{
> +	struct adc_tm5_gen3_chip *adc_tm5 = data;
> +
> +	cancel_work_sync(&adc_tm5->tm_handler_work);
> +}
> +
> +static void adc5_gen3_disable(void *data)
> +{
> +	struct adc_tm5_gen3_chip *adc_tm5 = data;
> +	int i;
> +
> +	adc5_gen3_mutex_lock(adc_tm5->dev);
> +	/* Disable all available TM channels */
> +	for (i = 0; i < adc_tm5->nchannels; i++)
> +		_adc_tm5_gen3_disable_channel(&adc_tm5->chan_props[i]);
> +
> +	adc5_gen3_mutex_unlock(adc_tm5->dev);
> +}
> +
> +static void adctm_event_handler(struct auxiliary_device *adev)
> +{
> +	struct adc_tm5_gen3_chip *adc_tm5 = auxiliary_get_drvdata(adev);
> +
> +	schedule_work(&adc_tm5->tm_handler_work);
> +}
> +
> +static int adc_tm5_probe(struct auxiliary_device *aux_dev,
> +			 const struct auxiliary_device_id *id)
> +{
> +	struct adc_tm5_gen3_chip *adc_tm5;
> +	struct tm5_aux_dev_wrapper *aux_dev_wrapper;
> +	struct device *dev = &aux_dev->dev;
> +	int i, ret;
> +
> +	adc_tm5 = devm_kzalloc(dev, sizeof(*adc_tm5), GFP_KERNEL);
> +	if (!adc_tm5)
> +		return -ENOMEM;
> +
> +	aux_dev_wrapper = container_of(aux_dev, struct tm5_aux_dev_wrapper,
> +				       aux_dev);
> +
> +	adc_tm5->dev = dev;
> +	adc_tm5->dev_data = aux_dev_wrapper->dev_data;
> +	adc_tm5->nchannels = aux_dev_wrapper->n_tm_channels;
> +	adc_tm5->chan_props = devm_kcalloc(dev, aux_dev_wrapper->n_tm_channels,
> +					   sizeof(*adc_tm5->chan_props), GFP_KERNEL);
> +	if (!adc_tm5->chan_props)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < adc_tm5->nchannels; i++) {
> +		adc_tm5->chan_props[i].common_props = aux_dev_wrapper->tm_props[i];
> +		adc_tm5->chan_props[i].timer = MEAS_INT_1S;
> +		adc_tm5->chan_props[i].sdam_index = (i + 1) / 8;
> +		adc_tm5->chan_props[i].tm_chan_index = (i + 1) % 8;
> +		adc_tm5->chan_props[i].chip = adc_tm5;
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, adc5_gen3_disable, adc_tm5);
> +	if (ret)
> +		return ret;
> +
> +	INIT_WORK(&adc_tm5->tm_handler_work, tm_handler_work);
> +
> +	/*
> +	 * Skipping first SDAM IRQ as it is requested in parent driver.
> +	 * If there is a TM violation on that IRQ, the parent driver calls
> +	 * the notifier (tm_event_notify) exposed from this driver to handle it.
> +	 */
> +	for (i = 1; i < adc_tm5->dev_data->num_sdams; i++) {
> +		ret = devm_request_threaded_irq(dev,
> +						adc_tm5->dev_data->base[i].irq,
> +						NULL, adctm5_gen3_isr, IRQF_ONESHOT,
> +						adc_tm5->dev_data->base[i].irq_name,
> +						adc_tm5);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	/*
> +	 * This drvdata is only used in the function (adctm_event_handler)
> +	 * called by parent ADC driver in case of TM violation on the first SDAM.
> +	 */
> +	auxiliary_set_drvdata(aux_dev, adc_tm5);
> +
> +	/*
> +	 * This is to cancel any instances of tm_handler_work scheduled by
> +	 * TM interrupt, at the time of module removal.
> +	 */
> +
> +	ret = devm_add_action(dev, adc5_gen3_clear_work, adc_tm5);
> +	if (ret)
> +		return ret;
> +
> +	return adc_tm5_register_tzd(adc_tm5);
> +}
> +
> +static const struct auxiliary_device_id adctm5_auxiliary_id_table[] = {
> +	{ .name = "qcom_spmi_adc5_gen3.adc5_tm_gen3", },
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(auxiliary, adctm5_auxiliary_id_table);
> +
> +static struct adc_tm5_auxiliary_drv adctm5gen3_auxiliary_drv = {
> +	.adrv = {
> +		.id_table = adctm5_auxiliary_id_table,
> +		.probe = adc_tm5_probe,
> +	},
> +	.tm_event_notify = adctm_event_handler,
> +};
> +
> +static int __init adctm5_init_module(void)
> +{
> +	return auxiliary_driver_register(&adctm5gen3_auxiliary_drv.adrv);
> +}
> +
> +static void __exit adctm5_exit_module(void)
> +{
> +	auxiliary_driver_unregister(&adctm5gen3_auxiliary_drv.adrv);
> +}
> +
> +module_init(adctm5_init_module);
> +module_exit(adctm5_exit_module);
> +
> +MODULE_DESCRIPTION("SPMI PMIC Thermal Monitor ADC driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("QCOM_SPMI_ADC5_GEN3");
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

