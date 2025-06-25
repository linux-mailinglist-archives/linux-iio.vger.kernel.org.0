Return-Path: <linux-iio+bounces-20958-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA527AE84CC
	for <lists+linux-iio@lfdr.de>; Wed, 25 Jun 2025 15:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25431896731
	for <lists+linux-iio@lfdr.de>; Wed, 25 Jun 2025 13:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FF7262FC8;
	Wed, 25 Jun 2025 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ay5NlWkn"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B706D25D1ED;
	Wed, 25 Jun 2025 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750858192; cv=none; b=tJzglMGzi3gm5OzqE+MCvt4oWJMQKa6VEyd8TzPysNHA0xjfELiKLfnNGx/sju7YnqO+3DCjevEoqSI/vmQTRCiYlW0r1IHvDkJbJwy8bbAbp/l+TB3w1ElkeslMyMqjSMXUZ4+GX77mvrcX3+VV3HNe7X8u6Wk+hUjgV7nbAJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750858192; c=relaxed/simple;
	bh=VfXy1sSzFunuddiHtM+uLU9xQdYDLn8lHfOI5lG9CX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QnUMfyzsl9HReKsKyQSLAPjXdnwP8fuWNClE5keMUURrx8YeYnJMvsxWAIY2GxBJSwCvENEP/8VJW04b8+0PqGWv8AODktXuTY1Uqy00Hz0jM3ZF/p0Vz3TMliziy5gkoR5k1BZtDfJH5zfe4kJ+CBPPB8P/bdD8k3vChsLGDM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ay5NlWkn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750858188;
	bh=VfXy1sSzFunuddiHtM+uLU9xQdYDLn8lHfOI5lG9CX8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ay5NlWknYmbxfUNMTCn2HwLL3f2bys3CsMz/fE6gTs4BL02RAjzY1dc+wa8Zlv8tN
	 rmAn9zLzGZHzpdmK+IPMgiJAdU8IFvV1sgTtNaexjHB9VyTqjtAvJNyGw1q9L0PLhw
	 +JI3qniO5tV6R/2VfDvXxK5rJNgbbSMqq6om7XiCXw4uogKZSrW3sHQAU9GLAYOyKd
	 iLeQDZpXQ3zBTo5iLBCM3zgzHSmRc/WFcy8dVvXWrqSbMFaduwebS84xoMSalyfpEM
	 aHglPIB0GyhRFbBBVly56RfEh1q3qqsUY91pA38V2/swHnoWhxf6bOj9YDdWCL7ZNv
	 QPr36ygolnnGg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EE09A17E1465;
	Wed, 25 Jun 2025 15:29:47 +0200 (CEST)
Message-ID: <1b173e16-f681-4256-8dd2-92db2e90ca73@collabora.com>
Date: Wed, 25 Jun 2025 15:29:47 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/5] iio: adc: mt6359: Add support for MediaTek MT6363
 PMIC AUXADC
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com
References: <20250623120028.108809-1-angelogioacchino.delregno@collabora.com>
 <20250623120028.108809-5-angelogioacchino.delregno@collabora.com>
 <aFlk-l5LhgO8dnXK@smile.fi.intel.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <aFlk-l5LhgO8dnXK@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/06/25 16:30, Andy Shevchenko ha scritto:
> On Mon, Jun 23, 2025 at 02:00:27PM +0200, AngeloGioacchino Del Regno wrote:
>> MediaTek MT6363 is a PMIC found on MT8196/MT6991 board designs
>> and communicates with the SoC over SPMI.
>>
>> This PMIC integrates an Auxiliary ADC (AUXADC) which has a grand
>> total of 54 ADC channels: 49 PMIC-internal channels, 2 external
>> NTC thermistor channels and 2 generic ADC channels (mapped to 7
>> PMIC ADC external inputs).
>>
>> To use a generic ADC channel it is necessary to enable one of
>> the PMIC ADC inputs at a time and only then start the reading,
>> so in this case it is possible to read only one external input
>> for each generic ADC channel.
>>
>> Due to the lack of documentation, this implementation supports
>> using only one generic ADC channel, hence supports reading only
>> one external input at a time.
> 
>> +#define MT6363_EXT_CHAN_MASK		GENMASK(2, 0)
>> +#define MT6363_EXT_PURES_MASK		GENMASK(4, 3)
>> + #define MT6363_PULLUP_RES_100K		0
>> + #define MT6363_PULLUP_RES_OPEN		3
> 
> I would rather expect the two spaces after #define. This most likely will break
> syntax highlighting in (some of) the editors.
> 

I can change that no problem (or if this can be changed while applying, that'd
buy me some time and I'd appreciate that a lot)

> ...
> 
>> +#define MTK_PMIC_ADC_EXT_CHAN(_ch_idx, _req_idx, _req_bit, _rdy_idx, _rdy_bit,	\
>> +			      _ext_sel_idx, _ext_sel_ch, _ext_sel_pu,		\
>> +			      _samples, _rnum, _rdiv)				\
> 
> Wondering, and it's out of scope here, if we can go to use a macro for
> initialization of struct *_fract.
> 
>>   	[PMIC_AUXADC_CHAN_##_ch_idx] = {					\
>>   		.req_idx = _req_idx,						\
>>   		.req_mask = BIT(_req_bit),					\
>>   		.rdy_idx = _rdy_idx,						\
>>   		.rdy_mask = BIT(_rdy_bit),					\
>> +		.ext_sel_idx = _ext_sel_idx,					\
>> +		.ext_sel_ch = _ext_sel_ch,					\
>> +		.ext_sel_pu = _ext_sel_pu,					\
>>   		.num_samples = _samples,					\
>>   		.r_ratio = { _rnum, _rdiv }					\
>>   	}
> 
> Perhaps something in math.h as
> 
> #define INIT_STRUCT_FRACT_UXX(n, d) ...

Not sure... honestly, at a first glance it looks like a macro would only make
a longer line and nothing else...

...but - effectively - I can see a benefit for a INIT_CONST_STRUCT_FRACT_Uxx(n, d)
where we could perform a build-time check for division by zero.

I'm not sure how many users would there be of such a macro, ideas?

> 
> ...
> 
>> +	if (MTK_AUXADC_HAS_FLAG(cinfo, IS_SPMI)) {
>> +		/* If the previous read succeeded, this can't fail */
>> +		regmap_read(regmap, reg - 1, &lval);
> 
> No error check? lval may contain garbage here, right?
> 

No, because if the previous read succeeded, this can't fail, and also cannot ever
possibly contain garbage (and if it does, - but again, that can't happen - there is
no way to validate that because valid values are [0x00..0xff] anyway).

>> +		val = (val << 8) | lval;
> 
> Is it guaranteed that lval is always less than 256 (if unsigned)?
> 

Yes, with SPMI that is guaranteed.

>> +	}
> 
> ...
> 
>> +		regmap_update_bits(regmap, cinfo->regs[desc->ext_sel_idx],
>> +				   MT6363_EXT_PURES_MASK, ext_sel);
> 
> No  error check?
> 

No, because if the previous reads and/or writes succeeded, it is impossible for
this to fail :-)

Cheers,
Angelo


