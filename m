Return-Path: <linux-iio+bounces-12393-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786B99D211E
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 09:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4496B21579
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 08:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28F6157469;
	Tue, 19 Nov 2024 08:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FFz5h779"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56F3136345;
	Tue, 19 Nov 2024 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732003284; cv=none; b=DBZVdDs+UQJL0/K7dJtaWtkh/D6JSmu+E4s+Fup5g6S+Aho6PZOFHjIFQmJnuuXdnn0zVDxNfG7GQW2pDPTLzjrrel1u+tNTHdjtvqjbf0N4n2NmdzeS6xs/FNf3GHPLhY4GWOX2558mSC31DbHX8T3ZUIb4g32W3FqU7nQGLhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732003284; c=relaxed/simple;
	bh=Hi+z2o6j/wuWKRNgqhDMjQIXwLZahPiJONd31wDIljc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NPzNRce5lxEcNv80OPZGbDXeHhmTMGpuq2kyVjQJ4iZEcu+4BlEWSWvqZLvmtmNzIr0Xz2K5EsKPDpvq6Igcq0ZBzzZ1+OlmiBa3oJylQkU07KBSL8r8vWqa1/Tt5ZzkZNzJnmfnuf61A2PfXceaVf8aRwdWZ4F3BTg+DAJErNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FFz5h779; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ7Xlb6010734;
	Tue, 19 Nov 2024 08:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0TgR5bIUZVt3DM/CqTENzDHuXiMoOEcVymkRF2ByHdQ=; b=FFz5h779OSZQkkg5
	YHNmx95cZKLAVXT9q/PkaskQ9akthF80IQNoFssl01ByJQjt9j6k6U8POFPCWQ0Q
	XzCbEQsSlCoYS6FvuEL8+TMgmaC63KxvNF85NHiYDEseSVF2otiaMIoHb9Dj9P9R
	3Dw9UjEmu6/X0RQ34QHGDbzv/7B3LEayYSDoAd7O05GNTfB2ffU5cCFn+cIUpMGh
	jR5Sh6Fo1fKNYoVQLv92IT8Y9SyxWE4DGBElbgVhM3C+0GSpo1lcZ6KPa10nv6sC
	3OE6PcUqV9mbLRwoQwggJhCuYW5mXWxnq/H+UA5fZeIWqmBizg6/vI/ibX6Ww5bm
	qs0Yeg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43091m9u8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 08:00:56 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJ80sLJ027813
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 08:00:54 GMT
Received: from [10.110.70.207] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 19 Nov
 2024 00:00:46 -0800
Message-ID: <e1ab8bf0-f3ea-496f-bc83-6496e60adcdb@quicinc.com>
Date: Tue, 19 Nov 2024 13:30:42 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] thermal: qcom: Add support for MBG Temp monitor
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano
	<daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath
	<thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad
 Dybcio" <konrad.dybcio@linaro.org>,
        Kamal Wadhwa <quic_kamalw@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Jishnu Prakash
	<quic_jprakash@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Jagadeesh Kona" <quic_jkona@quicinc.com>
References: <20240712-mbg-tm-support-v1-0-7d78bec920ca@quicinc.com>
 <20240712-mbg-tm-support-v1-3-7d78bec920ca@quicinc.com>
 <20240713125945.2acac680@jic23-huawei>
Content-Language: en-US
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
In-Reply-To: <20240713125945.2acac680@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GhmvNMB6rR9jG--Pjr8AaZaCyXCImM1u
X-Proofpoint-GUID: GhmvNMB6rR9jG--Pjr8AaZaCyXCImM1u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190055


On 7/13/2024 5:29 PM, Jonathan Cameron wrote:
> On Fri, 12 Jul 2024 18:13:30 +0530
> Satya Priya Kakitapalli <quic_skakitap@quicinc.com> wrote:
>
>> Add driver for the MBG thermal monitoring device. It monitors
>> the die temperature, and when there is a level 1 upper threshold
>> violation, it receives an interrupt over spmi. The driver reads
>> the fault status register and notifies thermal accordingly.
>>
>> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> Hi Satya,
>
> Some comments inline.


Thanks for review, I'll address the comments in my V2 patches.


>
> Jonathan
>
>> diff --git a/drivers/thermal/qcom/qcom-spmi-mbg-tm.c b/drivers/thermal/qcom/qcom-spmi-mbg-tm.c
>> new file mode 100644
>> index 000000000000..70964ea5a48d
>> --- /dev/null
>> +++ b/drivers/thermal/qcom/qcom-spmi-mbg-tm.c
>> @@ -0,0 +1,269 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +//Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/irq.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/thermal.h>
>> +#include <linux/iio/consumer.h>
>> +
>> +#include "../thermal_core.h"
>> +
>> +#define MBG_TEMP_MON_MM_MON2_FAULT_STATUS	0x50
>> +
>> +#define MON_FAULT_STATUS_MASK			GENMASK(7, 6)
>> +#define MON_FAULT_STATUS_SHIFT			6
> Use FIELD_GET() and FIELD_PREP() then no need to have shift defined.
>
>> +#define MON2_LVL1_ERR				0x1
>> +
>> +#define MON2_LVL1_UP_THRESH			0x59
>> +
>> +#define MBG_TEMP_MON_MM_MON2_MISC_CFG		0x5f
>> +#define UP_THRESH_EN				BIT(1)
>> +
>> +#define STEP_MV					8
>> +#define MBG_DEFAULT_TEMP_MV			600
>> +#define MBG_TEMP_CONSTANT			1000
>> +#define MIN_TRIP_TEMP				25000
>> +#define MAX_SUPPORTED_TEMP			160000
> these are all device specific but don't sound it. I'd prefix them with MBG_TEMP
>
>
>> +
>> +static int mbg_tm_set_trip_temp(struct thermal_zone_device *tz, int low_temp,
>> +						int temp)
>> +{
>> +	struct mbg_tm_chip *chip = thermal_zone_device_priv(tz);
>> +	int ret = 0, vtemp = 0;
>> +
>> +	mutex_lock(&chip->lock);
> 	guard(mutex)(&chip->lock);
>
>
> As then you don't need to carefully unlock as it will be done at exit of scope.
>
>> +
>> +	/* The HW has a limitation that the trip set must be above 25C */
>> +	if (temp > MIN_TRIP_TEMP && temp < INT_MAX) {
> 		int vtemp;
>
> reduce the scope and it becomes clear no need to init.
>
>> +		mbg_tm_reg_update(chip, MBG_TEMP_MON_MM_MON2_MISC_CFG,
>> +					 UP_THRESH_EN, UP_THRESH_EN);
>> +		vtemp = temp_to_vtemp(temp);
>> +		ret = mbg_tm_write(chip, MON2_LVL1_UP_THRESH, vtemp);
>> +		if (ret < 0) {
>> +			mutex_unlock(&chip->lock);
>> +			return ret;
>> +		}
>> +	} else {
>> +		dev_dbg(chip->dev, "Setting %d failed, set trip between 25C and INT_MAX\n", temp);
>> +		mbg_tm_reg_update(chip, MBG_TEMP_MON_MM_MON2_MISC_CFG,
>> +					UP_THRESH_EN, 0);
>> +	}
>> +
>> +	mutex_unlock(&chip->lock);
>> +
>> +	/*
>> +	 * Configure the last_temp one degree higher, to ensure the
>> +	 * violated temp is returned to thermal framework when it reads
>> +	 * temperature for the first time after the violation happens.
>> +	 * This is needed to account for the inaccuracy in the conversion
>> +	 * formula used which leads to the thermal framework setting back
>> +	 * the same thresholds in case the temperature it reads does not
>> +	 * show violation.
>> +	 */
>> +	chip->last_temp = temp + MBG_TEMP_CONSTANT;
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct thermal_zone_device_ops mbg_tm_ops = {
>> +	.get_temp = mbg_tm_get_temp,
>> +	.set_trips = mbg_tm_set_trip_temp,
>> +};
>> +
>> +static irqreturn_t mbg_tm_isr(int irq, void *data)
>> +{
>> +	struct mbg_tm_chip *chip = data;
>> +	int ret;
>> +	int val = 0;
>> +
>> +	mutex_lock(&chip->lock);
>> +
>> +	ret = mbg_tm_read(chip, MBG_TEMP_MON_MM_MON2_FAULT_STATUS, &val);
>> +
>> +	mutex_unlock(&chip->lock);
> 	scoped_guard(mutex, &chip->lock) {
> 		ret = mbg...
> 		if (ret < 0)
> 			return IRQ_HANDLED;
> 	}
> avoids need to unlock before return and to me at least gives slightly more
> readable code.
>
>> +
>> +	if (ret < 0)
>> +		return IRQ_HANDLED;
>> +
>> +	val &= MON_FAULT_STATUS_MASK;
>> +	if ((val >> MON_FAULT_STATUS_SHIFT) & MON2_LVL1_ERR) {
> as above use FIELD_GET() with the mask - it is more readable and
> does the mask and shift in one call.
>
>
>
>> +		chip->last_temp_set = true;
>> +		thermal_zone_device_update(chip->tz_dev,
>> +					THERMAL_TRIP_VIOLATED);
> I think the above is 80 chars on one line so no need to wrap.
>
>> +		dev_dbg(chip->dev, "Notifying Thermal, fault status=%d\n", val);
>> +	} else {
>> +		dev_dbg(chip->dev, "Lvl 1 upper threshold not violated, ignoring interrupt\n");
>> +	}
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int mbg_tm_probe(struct platform_device *pdev)
>> +{
>> +	struct mbg_tm_chip *chip;
>> +	struct device_node *node = pdev->dev.of_node;
>> +	u32 res;
>> +	int ret = 0;
> It's always set, so don't intiialize here.
>
>> +
>> +	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
>> +	if (!chip)
>> +		return -ENOMEM;
>> +
>> +	chip->dev = &pdev->dev;
>> +
>> +	mutex_init(&chip->lock);
>> +
>> +	chip->map = dev_get_regmap(pdev->dev.parent, NULL);
>> +	if (!chip->map)
>> +		return -ENXIO;
>> +
>> +	ret = of_property_read_u32(node, "reg", &res);
> I'm not sure on thermal subsystem opinion on this but I'd use
> the property.h generic firmware property reading stuff rather than of
> specific.
> device_property_read_u32()
>
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	chip->base = res;
>> +
>> +	chip->irq = platform_get_irq(pdev, 0);
>> +	if (chip->irq < 0)
>> +		return chip->irq;
>> +
>> +	chip->adc = devm_iio_channel_get(&pdev->dev, "thermal");
>> +	if (IS_ERR(chip->adc))
>> +		return PTR_ERR(chip->adc);
>> +
>> +	chip->tz_dev = devm_thermal_of_zone_register(&pdev->dev,
>> +				 0, chip, &mbg_tm_ops);
>> +	if (IS_ERR(chip->tz_dev)) {
>> +		dev_err(&pdev->dev, "failed to register sensor\n");
>> +		return PTR_ERR(chip->tz_dev);
> 		return dev_err_probe(...)
>
>> +	}
>> +
>> +	ret = devm_request_threaded_irq(&pdev->dev, chip->irq, NULL,
>> +			mbg_tm_isr, IRQF_ONESHOT, node->name, chip);
>> +
>> +	return ret;
> 	return devm_request...
>
>> +}

