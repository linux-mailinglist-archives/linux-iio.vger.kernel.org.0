Return-Path: <linux-iio+bounces-13856-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D60049FE502
	for <lists+linux-iio@lfdr.de>; Mon, 30 Dec 2024 10:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87ADB162514
	for <lists+linux-iio@lfdr.de>; Mon, 30 Dec 2024 09:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D053B1A2860;
	Mon, 30 Dec 2024 09:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UBmWNUWa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087241D540;
	Mon, 30 Dec 2024 09:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735551968; cv=none; b=e6Kjib+t3kobLmQsYcZF+s66/s8rM3b9Ux1lTRCtlOXAFfZsUPuggP0kYyLwoXSKj1GIMahoH4pYcVuX4kdj106qxB+xJu2O4qxt4emJy+o/rNoBn7Ny+f9OhVMw4Ta25tY9VprsRFlqmAvW6xcuTs2OTEvMWvu5N3o44TtaL08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735551968; c=relaxed/simple;
	bh=9vD9MtuX5fTs/84zjWforym1XDL1NOxumqnACS8YaNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f4LXeQY2iAOfalFAqY94YJSNkpnuEjkjASlt6CUon4KOLR6aitlqJNxiW09W/EoITpa3IQcSpMQHLpLCJ8usZqIYvywKRv+pEgmMXNolCYD4tBHCU+LQqwtvxBKpLppTvmIEqDcce6u2Mupr/a9pUI3wNaV96grSInpMiJYLU7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UBmWNUWa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BU7Fwnu027219;
	Mon, 30 Dec 2024 09:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nE7Pl8ty/cDHDnKCID6Uh3U9BiIrHhReoZ30nnIVRcs=; b=UBmWNUWa3KL4xlMO
	JkIDRaLVtu5PUdX+Ae3+cJSZvZ7wSvHWOVmaW8nNOKYoAUXAdDn/vG5wwC20+ES4
	jzUhANdfxUBhGHoojQCBTEXFWTMtlzt94KoeMYkY2I7ZU+IZmSPOtX/7cdoVUaVV
	ud8Gsotp8rQpv/hASM3Cq8xGymYKbGTIuAzn6/2LfzKkONTPWO6P3q7G1fUoLTeR
	FC6wZx/qVtLUhWcS+MCjC4aJ9y54GjobvwDQHPQhhFsF2bPeK3jU/f0CJMJ6QY3/
	WMyLQWfB5gQcZ+fsIoM9fu3LRic2EBdchVfCaYcgtDBkEeelN4nRCEv7sIF1dOpN
	VTHXEg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43upyr89a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Dec 2024 09:45:45 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BU9ji0T013191
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Dec 2024 09:45:44 GMT
Received: from [10.218.23.250] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 30 Dec
 2024 01:45:35 -0800
Message-ID: <c5079172-e127-4dfc-826a-b32489d852f8@quicinc.com>
Date: Mon, 30 Dec 2024 15:15:32 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 3/5] thermal: qcom: Add support for MBG thermal
 monitoring
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui
	<rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Lars-Peter
 Clausen" <lars@metafoo.de>, Lee Jones <lee@kernel.org>,
        Stephen Boyd
	<sboyd@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath
	<thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad
 Dybcio" <konradybcio@kernel.org>
CC: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        "Jagadeesh
 Kona" <quic_jkona@quicinc.com>, <quic_kamalw@quicinc.com>,
        <quic_jprakash@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
References: <20241212-mbg-v2-support-v2-0-3249a4339b6e@quicinc.com>
 <20241212-mbg-v2-support-v2-3-3249a4339b6e@quicinc.com>
 <cf2f2510-9d27-4473-bf50-45b14725f4c5@oss.qualcomm.com>
Content-Language: en-US
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
In-Reply-To: <cf2f2510-9d27-4473-bf50-45b14725f4c5@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oUaXNI0tYN-jc47S-txQVBDRdvOyUM29
X-Proofpoint-ORIG-GUID: oUaXNI0tYN-jc47S-txQVBDRdvOyUM29
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412300083


On 12/13/2024 9:18 PM, Konrad Dybcio wrote:
> On 12.12.2024 5:11 PM, Satya Priya Kakitapalli wrote:
>> Add driver for the MBG thermal monitoring device. It monitors
>> the die temperature, and when there is a level 1 upper threshold
>> violation, it receives an interrupt over spmi. The driver reads
>> the fault status register and notifies thermal accordingly.
>>
>> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>> ---
> [...]
>
>> +static const struct mbg_map_table map_table[] = {
> Is this peripheral/pmic-specific?


Yes, peripheral specific.


>> +	/* minT	vtemp0	tc */
>> +	{ -60000, 4337, 1967 },
>> +	{ -40000, 4731, 1964 },
>> +	{ -20000, 5124, 1957  },
>> +	{ 0,      5515, 1949 },
>> +	{ 20000,  5905, 1940 },
>> +	{ 40000,  6293, 1930 },
>> +	{ 60000,  6679, 1921 },
>> +	{ 80000,  7064, 1910 },
>> +	{ 100000, 7446, 1896 },
>> +	{ 120000, 7825, 1878 },
>> +	{ 140000, 8201, 1859 },
>> +};
>> +
>> +static int mbg_tm_get_temp(struct thermal_zone_device *tz, int *temp)
>> +{
>> +	struct mbg_tm_chip *chip = thermal_zone_device_priv(tz);
>> +	int ret, milli_celsius;
>> +
>> +	if (!temp)
>> +		return -EINVAL;
>> +
>> +	if (chip->last_thres_crossed) {
>> +		pr_debug("last_temp: %d\n", chip->last_temp);
> Use dev_dbg for consistency with the other debug prints


Okay.


>> +		chip->last_thres_crossed = false;
>> +		*temp = chip->last_temp;
>> +		return 0;
>> +	}
>> +
>> +	ret = iio_read_channel_processed(chip->adc, &milli_celsius);
>> +	if (ret < 0) {
>> +		dev_err(chip->dev, "failed to read iio channel %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	*temp = milli_celsius;
>> +
>> +	return 0;
>> +}
>> +
>> +static int temp_to_vtemp(int temp)
>> +{
>> +
>> +	int idx, vtemp, tc = 0, t0 = 0, vtemp0 = 0;
>> +
>> +	for (idx = 0; idx < ARRAY_SIZE(map_table); idx++)
>> +		if (temp >= map_table[idx].min_temp &&
>> +				temp < (map_table[idx].min_temp + 20000)) {
> Please align the two lines, tab width is 8 for kernel code


Okay.


>> +			tc = map_table[idx].tc;
>> +			t0 = map_table[idx].min_temp;
>> +			vtemp0 = map_table[idx].vtemp0;
>> +			break;
>> +		}
>> +
>> +	/*
>> +	 * Formula to calculate vtemp(mV) from a given temp
>> +	 * vtemp = (temp - minT) * tc + vtemp0
>> +	 * tc, t0 and vtemp0 values are mentioned in the map_table array.
>> +	 */
>> +	vtemp = ((temp - t0) * tc + vtemp0 * 100000) / 1000000;
> So you say vtemp = ... and the func is called temp_to_vtemp
>
>> +	return abs(vtemp - MBG_TEMP_DEFAULT_TEMP_MV) / MBG_TEMP_STEP_MV;
> But you end up returning a scaled version of it..
> Please clarify that in the code


Sure, I'll update the function name to temp_to_vtemp_mv and probably add 
a comment in the code.


>
>> +}
>> +
>> +static int mbg_tm_set_trip_temp(struct thermal_zone_device *tz, int low_temp,
>> +						int temp)
>> +{
>> +	struct mbg_tm_chip *chip = thermal_zone_device_priv(tz);
>> +	int ret = 0;
>> +
>> +	guard(mutex)(&chip->lock);
>> +
>> +	/* The HW has a limitation that the trip set must be above 25C */
>> +	if (temp > MBG_MIN_TRIP_TEMP && temp < MBG_MAX_SUPPORTED_TEMP) {
>> +		regmap_set_bits(chip->map,
>> +			chip->base + MBG_TEMP_MON2_MISC_CFG, MON2_UP_THRESH_EN);
>> +		ret = regmap_write(chip->map, chip->base + MON2_LVL1_UP_THRESH,
>> +						temp_to_vtemp(temp));
>> +		if (ret < 0)
>> +			return ret;
>> +	} else {
>> +		dev_dbg(chip->dev, "Set trip b/w 25C and 160C\n");
>> +		regmap_clear_bits(chip->map,
>> +			chip->base + MBG_TEMP_MON2_MISC_CFG, MON2_UP_THRESH_EN);
>> +	}
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
>> +	int ret, val;
>> +
>> +	scoped_guard(mutex, &chip->lock) {
>> +		ret = regmap_read(chip->map,
>> +			chip->base + MBG_TEMP_MON2_FAULT_STATUS, &val);
>> +		if (ret < 0)
>> +			return IRQ_HANDLED;
>> +	}
>> +
>> +	if ((val & MON_FAULT_STATUS_MASK) & MON_FAULT_STATUS_LVL1) {
>> +		if ((val & MON_POLARITY_STATUS_MASK) & MON_POLARITY_STATUS_UPR) {
> Just checking the last argument to AND in both lines is enough, as
> they're both parts of the bitfield


Both the bits of each mask need to be checked in order to proceed 
accordingly, I will update with proper logic in next version.


>
> [...]
>
>> +	ret = device_property_read_u32(chip->dev, "reg", &res);
>> +	if (ret < 0)
>> +		return ret;
> return dev_err_probe(dev, ret, "Couldn't read reg property"\n);
>
>> +
>> +	chip->base = res;
>> +
>> +	chip->irq = platform_get_irq(pdev, 0);
>> +	if (chip->irq < 0)
>> +		return chip->irq;
> Similarly here
>
>> +
>> +	chip->adc = devm_iio_channel_get(&pdev->dev, "thermal");
>> +	if (IS_ERR(chip->adc))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(chip->adc),
>> +			       "failed to get adc channel\n");
>> +
>> +	chip->tz_dev = devm_thermal_of_zone_register(&pdev->dev, 0,
>> +						chip, &mbg_tm_ops);
>> +	if (IS_ERR(chip->tz_dev))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(chip->tz_dev),
>> +			       "failed to register sensor\n");
> Please also make the error messages start with an uppercase letter
>
>> +
>> +	return devm_request_threaded_irq(&pdev->dev, chip->irq, NULL,
>> +			mbg_tm_isr, IRQF_ONESHOT, node->name, chip);
>> +}
>> +
>> +static const struct of_device_id mbg_tm_match_table[] = {
>> +	{ .compatible = "qcom,spmi-pm8775-mbg-tm" },
> I don't think the 'spmi' bit belongs here


Okay, will update it.


> Konrad

