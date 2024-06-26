Return-Path: <linux-iio+bounces-6971-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7F591872B
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 18:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37A6DB23BF5
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 16:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FA118EFCA;
	Wed, 26 Jun 2024 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="EyU3L10n"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFD26E611;
	Wed, 26 Jun 2024 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719418599; cv=none; b=hCs6bvH8q+axphrBBXkaH18u8U9695i/TYHVsL7p4N1eseBgCyVKYA3Gl8hdzJGy8FK1AoboXYW3hxI4d7LV6pgVg5beLGHAGN1/01Eu+gx5jLL5r+Zgbj3zJov+zHKXoKrQIPDyfmyJFM2o1fPsmvg/yNZ8GSdazZAp9TE0wIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719418599; c=relaxed/simple;
	bh=1mqK9G/ZFh6zwovAXJD+vTuqi1iQEJ8sHB9zoLajBS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Yv0UAjAdgZBqRDhelUMl84O4QZTFPnzzSxMoOsSp58FlONU+TomZ3QG+sMH9d1dxixkzOwqwrVxcBbWRjHXVkfrpVIoWdCuysdOvTKDrkntsm6J5fOjQc5OPWaOYWHCTwOQe9EGnYwYxqg72bujD/QKnr1PrFAioOG1tqPlwBzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=EyU3L10n; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QBLI8W023451;
	Wed, 26 Jun 2024 18:16:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	0K6g4n5PAuZsVsxr2X9hg3rFa4+lIJuxNGEgIloS7DY=; b=EyU3L10newAuzHTN
	t+Bk/jwsZdFiq35Ki6JMbOWT/srmka8vs5v3dGLrPN1f2vgDh4bARIsJwKAPl1gD
	+byra0tGSKKY0YEIASQBi+4YhVB9fmx/YkP8zE+xfV7M8Z5bcfVz5uhbydJKwNO0
	rbJ1sc5LkcLyXL+c3laPCTd6jAS3TriBJPUqCt8U7llRbUxwJ71BQEXE9F1zLV3b
	EQ9IToEVMJJZjz25/NPeAq6ipKdJnU28mUh+eX8EORs/xWvYhPBYPm7fBxhpCI1p
	2gr1f701xzjpdKcazRMsEoUX/RcHq6s35/AB543kKUFoZsUxQ7nkCLe6VSvxfyM/
	myhAmw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yx9jjest7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 18:16:03 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 633E340044;
	Wed, 26 Jun 2024 18:15:54 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C59B62291CA;
	Wed, 26 Jun 2024 18:15:16 +0200 (CEST)
Received: from [10.252.26.2] (10.252.26.2) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 26 Jun
 2024 18:15:16 +0200
Message-ID: <7125491f-880c-486e-b417-8fc1e0c20c88@foss.st.com>
Date: Wed, 26 Jun 2024 18:15:15 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] iio: adc: stm32-dfsdm: add scaling support to
 dfsdm
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
        <fabrice.gasnier@foss.st.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: Nuno Sa <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20240625150717.1038212-1-olivier.moysan@foss.st.com>
 <20240625150717.1038212-9-olivier.moysan@foss.st.com>
 <c2d746c73f7450dd10c0a0b229b3672e44fe583a.camel@gmail.com>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <c2d746c73f7450dd10c0a0b229b3672e44fe583a.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_07,2024-06-25_01,2024-05-17_01

Hi Nuno,

On 6/26/24 10:59, Nuno Sá wrote:
> Hi Olivier,
> 
> One thing that I just noticed...
> 
> On Tue, 2024-06-25 at 17:07 +0200, Olivier Moysan wrote:
>> Add scaling support to STM32 DFSDM.
>>
>> When used in an analog context, a DFSDM filter typically converts the data
>> from a sigma delta modulator. The IIO device associated to the DFSDM
>> filter provides these data as raw data.
>> The IIO device can provide scaling information (voltage and offset) to
>> allow conversion of raw data into physical values.
>>
>> With the new binding based on IIO backend framework, the sigma delta
>> modulators are defined as backends providing scaling information.
>>
>> The scaling is not supported with legacy binding.
>>
>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
>> Acked-by: Nuno Sa <nuno.sa@analog.com>
>> ---
>>
> 
> ...
> 
>> +
>> +	case IIO_CHAN_INFO_SCALE:
>> +		/*
>> +		 * Scale is expressed in mV.
>> +		 * When fast mode is disabled, actual resolution may be lower
>> +		 * than 2^n, where n = realbits - 1.
>> +		 * This leads to underestimating the input voltage.
>> +		 * To compensate this deviation, the voltage reference can be
>> +		 * corrected with a factor = realbits resolution / actual max
>> +		 */
>> +		if (adc->backend[idx]) {
>> +			iio_backend_read_raw(adc->backend[idx], chan, val,
>> val2, mask);
> 
> Eve if it does not matter for your usecase, you should still do error handling
> as iio_backend_read_raw() can return an error.
> 

Ack. On the same occasion, I will switch to a dedicated API.

Olivier

>> +			*val = div_u64((u64)*val * (u64)BIT(DFSDM_DATA_RES -
>> 1), max);
>> +			*val2 = chan->scan_type.realbits;
>> +			if (chan->differential)
>> +				*val *= 2;
>> +		}
>> +		return IIO_VAL_FRACTIONAL_LOG2;
>> +
>> +	case IIO_CHAN_INFO_OFFSET:
>> +		/*
>> +		 * DFSDM output data are in the range [-2^n, 2^n],
>> +		 * with n = realbits - 1.
>> +		 * - Differential modulator:
>> +		 * Offset correspond to SD modulator offset.
>> +		 * - Single ended modulator:
>> +		 * Input is in [0V, Vref] range,
>> +		 * where 0V corresponds to -2^n, and Vref to 2^n.
>> +		 * Add 2^n to offset. (i.e. middle of input range)
>> +		 * offset = offset(sd) * vref / res(sd) * max / vref.
>> +		 */
>> +		if (adc->backend[idx]) {
>> +			iio_backend_read_raw(adc->backend[idx], chan, val,
>> val2, mask);
> 
> Same...
> 
> - Nuno Sá

