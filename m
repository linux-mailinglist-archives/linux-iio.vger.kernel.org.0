Return-Path: <linux-iio+bounces-27199-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D345CD009C
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 14:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F3CD30852E5
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 13:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F3A305976;
	Fri, 19 Dec 2025 13:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lLpZAk70";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LWhvzCls"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4A42D3EC7
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 13:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766150191; cv=none; b=dJx6vkIkB+8OjnJRBx55O05rmzZMnyXJHaUbC1GsRgfWm47uVxqgoHqGYV3tfa9X7T1Ee1XuJyhArrA2wGSfKLOP44QdDGJOxK4jfepJ5cZrpfz+PUpQdb8FLRVBd0iBQVjX2hwil8UjhXEgL9NnP2+BPJihmUp4fJcL/+bN+Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766150191; c=relaxed/simple;
	bh=xMYkhdnS/TvFbvD6QwXhNpoUu4u5dDtCKTs0jT+n1vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHkNOuFcRJRegDxV1qLD7MSR8+53CSpPIoy65nxmg8T0Vd5iFOD1u5adYDyYUUC6GTnD3Y3NnbsP+hnO2oI2usbrC7iGMveDvSH5v+Tscxu82VGUmrQlixQHlKpwaxpOuKxKgOwduGAlqXl5tGUYoO8q1Vl69LnFUVa8Isn6F1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lLpZAk70; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LWhvzCls; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJBOBFk4101116
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 13:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v835eW97tWnZvqqqQckseRoL/dPYOC5J2/uWhsWU70U=; b=lLpZAk70qvgv0abG
	ap4HkKxk4RN6vaHHompmb3mshjihjL48PbhOxO3m40B3wG30s80tSIIp5Lkjz18q
	KFKCZKJsQQgeBJfuafOMjkEaBSvzA962K+5/sdMWWxm3udhpE7Hbe3UcdTqnO4Ry
	fiezCim5wILq/EVcSBgeasRNMB7t4CZ09tt6jeQIqxZceuvTirgsatxxtY46q8p4
	7MLt40KebgKC89rfRMN8TnL4F0p7Y2lxIqZPgzPDodzJil/Pc8MRpuQoiRobH06c
	yul6Iams4jAWTbSxlr9zpe3Zb1rDm3YyN6CiiAapUDT3pSnuTC3FdRIwvx0vRv0Y
	/2JFcw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2c2rc7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 13:16:29 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29e6b269686so34001055ad.1
        for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 05:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766150189; x=1766754989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v835eW97tWnZvqqqQckseRoL/dPYOC5J2/uWhsWU70U=;
        b=LWhvzClssu38+2CyyEjBtVfee4brW3AuUddxldUzOEUyv7IBCt1fWz8QMc1WDfL7iy
         vmwiTg9Pz8OYDHAFLKREeeMkx9XDGABzj7OLrMcCO+7VqTztFwtWnzFS2uWLO6R+NQpI
         P+qU9bJslXzQUbIGvuAHohd1rkFs8m9DarJhHR+0LACKHeYrfwI9M8IZ1EiHnLvH0DSs
         TuVI0lrLAvK6QIjQ769M5L6mUGKeteKm8nOa04ZHCKFGLwNoPakqROZ/Nm0Hoyna493w
         2txWxOgpR+aWd7e9txPlVnVBpNhTl03/T9DXIOtJvbVRtpppr/cQP+APMvAmB0mPktwj
         CcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766150189; x=1766754989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v835eW97tWnZvqqqQckseRoL/dPYOC5J2/uWhsWU70U=;
        b=iALlKyiwiWkQ3OU/gzKGs40zdNlitGy/+xSibNEE6Iov7iLnvsxWQyydg7uNbYPv6W
         EWZY49QNAgysqeSYIn6tgUAuznP9HG4DaW+MPEPfAnbNycWy86waKV83WgWyiGmOiBT1
         iO4X7M24dQ/YWHHZeHcvd1h8tg2OC4nuujIdffcn0qMfcPPIP4vIRTlURKPly0x/Z1L2
         oO+NqvGiXjggtijra97J48kr9bmk39zOfG+3WxESfR/+ek++BG+qOEaAVM/Of9AwpFpx
         kuS8cPPB0PF+7xU2zl6Vos2UNVDEIejcnCrmDutCGdXrxgxEQ/LlWC5eSnX3SDyG7c4n
         nMhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsOsiP1TWwi8hUjVPPsAoPWkvS4HP41IWqxuGkGL+YJRn7uxA5a4W7RpKyGXMf3LRmAxV4ws4i36I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuetmkzbPC0zms2PDtYWCFnHsukdKG7NjX453iRtBl8XlZefSb
	uwg4NNtxPc8qUcroJ+T4s6v/7lMe27scpViBp/TV7/M4Zd0CPJWapF0b1qKKz9N4nk1bRSlYLy0
	T8ZZFguYsV3mgBpAJ8LrFF8vzirAxCV7hACA0vOVuKQLHYi7p7wtbWWZPDff+H7Q=
X-Gm-Gg: AY/fxX71jDdgCGMj6WqAtz26y2jnIdeY3bqt+SU82gDae6Dv6VukFD5oL0OoHOBzCkF
	p38xogBDrrKHTVI25GDiBtrhJnNTvuUb25S7FzC+XYjC3bxOIp9LJAlYh2zPfVtbEx3o6oBztDT
	hVskti9SqOJ9nc1E/RlUAUKh2wc4Nteje89IDIuCS9uQneFUGNa+lAIW/0TuJZ9ld4vtnkqbzHB
	D0imISOUMKYSXXPo4DRNdua9EZm8FsrK8ip1cHY3exM+n4nWs4z7vNcMeHOog1URHIWdinC+Irr
	kwpGF2byg2LZEMYTub1e9WJJCwgGl88NHU8OM/lMTYVURW15ASV8i1lmDMsDoRkqKGNAzY6IzbK
	8d2qV08G46kvOeDemBWaJNFbzX/FbjnwNMuOTtyTXjg==
X-Received: by 2002:a17:903:2b0c:b0:298:4718:909f with SMTP id d9443c01a7336-2a2f2a3c12fmr21977545ad.51.1766150188825;
        Fri, 19 Dec 2025 05:16:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoI0126nI02HWdOYrK7HmwSJwQglIvs3CVhlzhFNNwJeELwYLlPmot25vjNg43QVJ7InExPQ==
X-Received: by 2002:a17:903:2b0c:b0:298:4718:909f with SMTP id d9443c01a7336-2a2f2a3c12fmr21977325ad.51.1766150188281;
        Fri, 19 Dec 2025 05:16:28 -0800 (PST)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e588a30sm2440572b3a.55.2025.12.19.05.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 05:16:27 -0800 (PST)
Message-ID: <bb1035cf-f025-4ac8-b22f-ad5a08ac1bfb@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 18:46:19 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 4/4] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, lumag@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
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
References: <20251127134036.209905-1-jishnu.prakash@oss.qualcomm.com>
 <20251127134036.209905-5-jishnu.prakash@oss.qualcomm.com>
 <20251207170401.1143fc22@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20251207170401.1143fc22@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDExMCBTYWx0ZWRfX0+7aP23Xog9t
 k2oMzN5H9Vw4IkXjEON2R4EXcj1H4AfeCpr6NJdIX2GBhoAEkn6Bb5qcvtgRd4Yi60OMkk+ExLk
 hrDd5ojaZzGuIIPB9GR+uPrPeLURWxzr1h9SC5jZN3dEu49kNQt0MwXcQJFjFt7QwJ2SEO7PSwH
 HdPKfjwlbemIZCOn323Evbd8ET6I2M75YdJgW3Ev0IiL4Rra+DFNFHmNAb/ceCuj3B0TeIQsaIC
 GRo0UnWaUK1+YuJU6Sp+XTht1M8NcZbHPuvwRhFGIDzTppXGNv99pTvS7lC2k4kh5eNsNPRmRSi
 1S34R45vxH4PRt7tk1CmcprLjUaIIGHEnqBeJtK5AdixLX0n78BrunVY4wV9kQaR4xSzaiYOOxK
 /0bdDZO5m+RaAVzxPskvFngWjY4HXYXb4XaItuI17dKju9MtUCfps2/i8lhDwn60DuGfOzjgIZu
 Z9cX2Baos1N/IDRgvbQ==
X-Authority-Analysis: v=2.4 cv=dOmrWeZb c=1 sm=1 tr=0 ts=6945502d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=wdI2RCEqRplqVT_zBhgA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: qvY07iiKab3M7c_S6zMua7z6NVzICUyY
X-Proofpoint-GUID: qvY07iiKab3M7c_S6zMua7z6NVzICUyY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_04,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512190110

Hi Jonathan,

On 12/7/2025 10:34 PM, Jonathan Cameron wrote:
> On Thu, 27 Nov 2025 19:10:36 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
>> Add support for ADC_TM part of PMIC5 Gen3.
>>
>> This is an auxiliary driver under the Gen3 ADC driver, which implements the
>> threshold setting and interrupt generating functionalities of QCOM ADC_TM
>> drivers, used to support thermal trip points.
>>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
>> ---
> Hi Jishnu
> 
> Fresh read threw up a few more comments from me.
> 
> See inline
> 
> Thanks,
> 
> Jonathan
> 
>> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
>> new file mode 100644
>> index 000000000000..c6cc8ef76f7e
>> --- /dev/null
>> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
> 
>> +
>> +static void tm_handler_work(struct work_struct *work)
>> +{
>> +	struct adc_tm5_gen3_chip *adc_tm5 = container_of(work, struct adc_tm5_gen3_chip,
>> +							 tm_handler_work);
>> +	struct adc_tm5_gen3_channel_props *chan_prop;
> 
> Why not declare in the reduced scope below?  Then could probably combine
> declaration and assignment for this, and offset.

OK, I'll just keep the following lines here:

    struct adc_tm5_gen3_chip *adc_tm5 = container_of(work, struct adc_tm5_gen3_chip, tm_handler_work);
    int sdam_index = -1;

and declare the remaining variables in the loop.


> 
> 
>> +	u8 tm_status[2] = { };
>> +	u8 buf[16] = { };
>> +	int sdam_index = -1;
>> +	int i, ret;
>> +
>> +	for (i = 0; i < adc_tm5->nchannels; i++) {
> It's considered fine in new kernel code to declare the loop variable
> as
> 	for (int i = 0;
> 
>> +		bool upper_set, lower_set;
>> +		int temp, offset;
>> +		u16 code = 0;
>> +
>> +		chan_prop = &adc_tm5->chan_props[i];
>> +		offset = chan_prop->tm_chan_index;
>> +
>> +		adc5_gen3_mutex_lock(adc_tm5->dev);
>> +		if (chan_prop->sdam_index != sdam_index) {
>> +			sdam_index = chan_prop->sdam_index;
>> +			ret = adc5_gen3_tm_status_check(adc_tm5, sdam_index,
>> +							tm_status, buf);
>> +			if (ret) {
>> +				adc5_gen3_mutex_unlock(adc_tm5->dev);
> 
> If you had the guard() below, could perhaps use scoped_guard() here
> to avoid need for unlocking in error paths.
> That would be at the cost of increased indent however, so may not be worth it
> or that may suggest factoring out some of this code as a helper.

The mutex is meant to guard register writes, so it might be sufficient to
have it around adc5_gen3_tm_status_check() alone. I'll make this change.

> 
>> +				break;
>> +			}
>> +		}
>> +
>> +		upper_set = ((tm_status[0] & BIT(offset)) && chan_prop->high_thr_en);
>> +		lower_set = ((tm_status[1] & BIT(offset)) && chan_prop->low_thr_en);
>> +		adc5_gen3_mutex_unlock(adc_tm5->dev);
>> +
>> +		if (!(upper_set || lower_set))
>> +			continue;
>> +
>> +		code = get_unaligned_le16(&buf[2 * offset]);
>> +		pr_debug("ADC_TM threshold code:%#x\n", code);
>> +
>> +		ret = adc5_gen3_therm_code_to_temp(adc_tm5->dev,
>> +						   &chan_prop->common_props,
>> +						   code, &temp);
>> +		if (ret) {
>> +			dev_err(adc_tm5->dev,
>> +				"Invalid temperature reading, ret = %d, code=%#x\n",
>> +				ret, code);
>> +			continue;
>> +		}
>> +
>> +		chan_prop->last_temp = temp;
>> +		chan_prop->last_temp_set = true;
>> +		thermal_zone_device_update(chan_prop->tzd, THERMAL_TRIP_VIOLATED);
>> +	}
>> +}
> 
>> +static int adc_tm5_gen3_set_trip_temp(struct thermal_zone_device *tz,
>> +				      int low_temp, int high_temp)
>> +{
>> +	struct adc_tm5_gen3_channel_props *prop = thermal_zone_device_priv(tz);
>> +	struct adc_tm5_gen3_chip *adc_tm5;
>> +	int ret;
>> +
>> +	if (!prop || !prop->chip)
>> +		return -EINVAL;
>> +
>> +	adc_tm5 = prop->chip;
>> +
>> +	dev_dbg(adc_tm5->dev, "channel:%s, low_temp(mdegC):%d, high_temp(mdegC):%d\n",
>> +		prop->common_props.label, low_temp, high_temp);
>> +
>> +	adc5_gen3_mutex_lock(adc_tm5->dev);
>> +	if (high_temp == INT_MAX && low_temp <= -INT_MAX)
> 
> How is low temp lower than the min value that fits in an integer?

Yes, that check should be (low_temp == -INT_MAX), I'll fix it.

> 
>> +		ret = adc_tm5_gen3_disable_channel(prop);
>> +	else
>> +		ret = adc_tm5_gen3_configure(prop, low_temp, high_temp);
>> +	adc5_gen3_mutex_unlock(adc_tm5->dev);
> Might be worth a DEFINE_GUARD() so you can do
> 	guard(adc5_gen3)(adc_tm5->dev);
> 	if (high_temp = INT_MAX && low_temp <= -INT_MAX)
> 		return adc_tm5_gen3_disable_channel(prop);
> 	
> 	return adc_tm5...
> 
> I haven't looked to see if this is useful elsewhere in these drivers.
> 

I'll add this and address your other comments.

Thanks,
Jishnu


>> +
>> +	return ret;
>> +}


