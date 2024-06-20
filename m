Return-Path: <linux-iio+bounces-6626-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 757F49107D7
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 16:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261222810E9
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 14:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0271AD499;
	Thu, 20 Jun 2024 14:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ZzU7SFwk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39851AE090;
	Thu, 20 Jun 2024 14:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893003; cv=none; b=JEFlsxujzdmVqkafFUZ+CRm/kvy8riYiTN1hZ5QmzRs4M5TBryJJHXmzio/cZ0JE09Bu8JJB2m4nwXldFVIrX24bCTey0QaeYENC1FXmMbaljOGic2Yd4fTh1kInkYxS7tuQZ53d78XYArWnU6RUeISmVXuf+3ZtVsZYhtVKtJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893003; c=relaxed/simple;
	bh=bKIDo9qWEqirGZIQBwhIvV8VCPzoUKRRp+y97nCr4+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JiB1hiI9S3mYm+LTbTJc1nnKoT9yPa6bakhNkRBpEWlRAjzlAcUPhdkYhpZADanG3nzlDu8xBrF+vczUG2rOyyv+kRvenxriS0XhERPSdHFD4kca2kRoSFsGxgVnZRetW5YSzbaxvI4gsxgNZ2PtSjCnE4xiHkNr259qUAJdOG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ZzU7SFwk; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KB2MX4007685;
	Thu, 20 Jun 2024 16:16:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	clsnqnGYNspuhGDr2c/1UM7m1dcz+B0wDouX15lm4dw=; b=ZzU7SFwk5jdALuKv
	zDbV1WdSUaQgi96MDPRyN6p0RWUahORQ5s9dIgJO8pY85h6CpZzn0ecw/q1mUKRS
	u9J46JOMTjTughtFje6bRUkKf2Ibuf1shI/5MKJTpueS1NH5b6OeLDZHikJtq2aK
	lJMJrJkf/N1vVzjKVLercEB4OLYuKAO30IQmDeodGUuoXCkgXYvlI3Ia25reI+Ic
	FrqnwPLJsdaYNL7ig1xdigb815ewoc3fR+RS1ExfI3lw2FDOq//UQ31SSv+U8hcZ
	04HPNLrkT+dbv/BRgZ3/psXCk2h/FBWASoEdK8pmDTuDKbiIfsSpp1PVLlk3BkvY
	Nsj9QQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yuj9t8qpj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 16:16:12 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D555240046;
	Thu, 20 Jun 2024 16:16:06 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 39DA720E034;
	Thu, 20 Jun 2024 16:15:32 +0200 (CEST)
Received: from [10.48.86.132] (10.48.86.132) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 20 Jun
 2024 16:15:31 +0200
Message-ID: <a76e16bc-bcb6-48eb-b6f7-2e4e68ded32b@foss.st.com>
Date: Thu, 20 Jun 2024 16:15:30 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] iio: adc: stm32-dfsdm: add scaling support to dfsdm
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20240618160836.945242-1-olivier.moysan@foss.st.com>
 <20240618160836.945242-9-olivier.moysan@foss.st.com>
 <a0bd26a9e159e54f1b6effcdd45756ecfddf973f.camel@gmail.com>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <a0bd26a9e159e54f1b6effcdd45756ecfddf973f.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-20_04,2024-05-17_01

Hi Nuno,

On 6/19/24 07:47, Nuno Sá wrote:
> On Tue, 2024-06-18 at 18:08 +0200, Olivier Moysan wrote:
>> Add scaling support to STM32 DFSDM.
>>
>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
>> ---
> 
> Just some general comments...
> 
> Acked-by: Nuno Sa <nuno.sa@analog.com>
> 
>>   drivers/iio/adc/Kconfig           |  1 +
>>   drivers/iio/adc/stm32-dfsdm-adc.c | 94 ++++++++++++++++++++++++++++++-
>>   2 files changed, 92 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index f3dfdaa80678..858ae8161fa4 100644
>>
> 
> ...
> 
>> @@ -1301,6 +1339,8 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
>>   		ret = stm32_dfsdm_single_conv(indio_dev, chan, val);
>>   		if (adc->hwc)
>>   			iio_hw_consumer_disable(adc->hwc);
>> +		if (adc->backend[idx])
>> +			iio_backend_disable(&indio_dev->dev, adc->backend[idx]);
>>   		if (ret < 0) {
>>   			dev_err(&indio_dev->dev,
>>   				"%s: Conversion failed (channel %d)\n",
>> @@ -1320,6 +1360,45 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
>>   		*val = adc->sample_freq;
>>   
>>   		return IIO_VAL_INT;
>> +
>> +	case IIO_CHAN_INFO_SCALE:
>> +		/*
>> +		 * Scale is expressed in mV.
>> +		 * When fast mode is disabled, actual resolution may be lower
>> +		 * than 2^n, where n=realbits-1.
>> +		 * This leads to underestimating input voltage. To
>> +		 * compensate this deviation, the voltage reference can be
>> +		 * corrected with a factor = realbits resolution / actual max
>> +		 */
>> +		if (adc->backend[idx]) {
>> +			iio_backend_read_raw(adc->backend[idx], val, val2, mask);
>> +
> 
> This is something that I've been thinking about since the beginning of backends
> support. Basically having the "catch all" read_raw()/write_raw() or more dedicated
> interfaces. For example, in your usecase I think it would make more sense to have
> dedicated API's like iio_backend_read_scale() and iio_backend_read_offset() as you're
> extending that functionality. Calling iio_backend_read_raw() seems a bit weird to me.
> 
> OTOH, iio_backend_read_raw() could be useful in cases where frontends call
> iio_backend_extend_chan_spec() and may get some functionality they are not aware of.
> And so, in the default: statement this "catch all" API could be used.
> 
> Anyways, this are really minor (likely pedantic) details and you kind of came first
> and made the decision for me. As I don't really have strong feelings about it, I'm
> fine with it as-is.
> 

My first idea was to stick to IIO read_raw API ('struct iio_chan_spec 
const *chan' should at least be added to prototype as you pointed it 
out). But I agree that iio_backend_read_raw() is not explicit regarding 
the requested info.
I consider using the existing API iio_backend_ext_info_get() for v2, as 
you suggested.

BRs
Olivier

>> +			*val = div_u64((u64)*val * (u64)BIT(DFSDM_DATA_RES - 1),
>> max);
>> +			*val2 = chan->scan_type.realbits;
>> +			if (chan->differential)
>> +				*val *= 2;
>> +		}
>> +		return IIO_VAL_FRACTIONAL_LOG2;
>> +
>> +	case IIO_CHAN_INFO_OFFSET:
>> +		/*
>> +		 * DFSDM output data are in the range [-2^n,2^n],
>> +		 * with n=realbits-1.
>> +		 * - Differential modulator:
>> +		 * Offset correspond to SD modulator offset.
>> +		 * - Single ended modulator:
>> +		 * Input is in [0V,Vref] range, where 0V corresponds to -2^n, and
>> Vref to 2^n.
>> +		 * Add 2^n to offset. (i.e. middle of input range)
>> +		 * offset = offset(sd) * vref / res(sd) * max / vref.
>> +		 */
>> +		if (adc->backend[idx]) {
>> +			iio_backend_read_raw(adc->backend[idx], val, val2, mask);
>> +
>> +			*val = div_u64((u64)max * *val, BIT(*val2 - 1));
>> +			if (!chan->differential)
>> +				*val += max;
>> +		}
>> +		return IIO_VAL_INT;
>>   	}
>>   
>>   	return -EINVAL;
>> @@ -1449,7 +1528,15 @@ static int stm32_dfsdm_adc_chan_init_one(struct iio_dev
>> *indio_dev, struct iio_c
>>   	 * IIO_CHAN_INFO_RAW: used to compute regular conversion
>>   	 * IIO_CHAN_INFO_OVERSAMPLING_RATIO: used to set oversampling
>>   	 */
>> -	ch->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
>> +	if (child) {
>> +		ch->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +					BIT(IIO_CHAN_INFO_SCALE) |
>> +					BIT(IIO_CHAN_INFO_OFFSET);
> 
> Not sure if the above SCALE and OFFSET are solely properties if the backend. If so,
> you could maybe use iio_backend_extend_chan_spec().
> 
> - Nuno Sá
> 

