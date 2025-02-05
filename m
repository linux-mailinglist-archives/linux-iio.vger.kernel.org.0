Return-Path: <linux-iio+bounces-15043-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EC6A28D40
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 14:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FAE818817B6
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 13:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6202155725;
	Wed,  5 Feb 2025 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPq5ypkO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9603C1527B4;
	Wed,  5 Feb 2025 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763904; cv=none; b=Foc5gLIZ4FQ1o+ur4OFQzwYjraDgn/lG3t76BUU6Y6/xXE99wsgexq/XEy7XumIPXDv1vmgI7Dy/59pO1lZiSvN1X9BfCGb2hL779LYYq3O21djLubqs9JMsCT9+rDgL2pGq56jcw7S9yt9UeCxw/d49/J03euMpFSLTBkEzM74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763904; c=relaxed/simple;
	bh=ROO/Xyq7zGw20kDjrzJCf2zSIBVZG52NjTL0INzaWrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mqymAchvlR20EMxEdCgZmnRBGLZlcNPHIRiP7PBNe1yKnuIOg3UuBFUHyjY89XzwVD5yQdB+kN/5IXIsL3acS2FBgsbEYSpCkezFOpLE1HtAIsyw31yWXNaqb1liI3/xd4ykT4R1zECeZ7iGhxlcuhdBxKeXPyxcJJZWLArB8vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPq5ypkO; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5426fcb3c69so6126526e87.3;
        Wed, 05 Feb 2025 05:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738763900; x=1739368700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ar1iEi8LuD+VTnNSkZdX82pmybq0djpG13KHykZ13Zk=;
        b=MPq5ypkOiN4yK2Z63k+EsC9dSv5kCjN90ZFEIK03ukvLt/6wRiBZCyjJVTSlCg9m+g
         u+znto8LdB+etiAQie+n5BPvt1BrHK9papyxSVCluPvWWo0hMt/tlNao2tx/KDxJqvVg
         c1crBeKYaN2Lo6wcYavW3VlPAH56xnLjtlJ/A/X+9OiSqSnsfJ8kEbIK8YVMn8bWnBO4
         xnkyjCdt0lfoiNKiuJ0MYV+YomzvR322QI9Ne0hT/QfyX2uNlt1eNsi6IywMuYPZ+Tqy
         dxOncvgN1D/USiOGNXtpE8HuWHUoKDcUPZUJ89NhMydAFeXSWYbeick2uGNp0lPPkzQm
         XxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738763900; x=1739368700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ar1iEi8LuD+VTnNSkZdX82pmybq0djpG13KHykZ13Zk=;
        b=ajvYAHvB0nurQaDfWQvt8VTPdA0uBH5Q8IUXhtoac5odlhYLOGUbd72+9slRY/TthP
         gKpmZrIwE42dG66+hfUaCsRDF5pT2d43IMUW7jyDR3bl3vai1SYp9XJrdEB6RWV8nWdr
         ITba11fUmNS+q0AWk+fXHJFw+S3FkxJ1rvA5hUYIAiK+dv/4qLkXPfuVWTR4zSvNpFIs
         LFW6IfpEwKkCFi5P5tM6xLA24g93GJK8Tgb5NEjmngJTiuku5p1ipvM/lIO7ajQv3KmD
         RSF9+3iLJAtErFaCpy+/JpvU3chEClbApez72j0ONqTgtAQkQKZKxS6pGNy6jarY+vqK
         BAOA==
X-Forwarded-Encrypted: i=1; AJvYcCUSJxSB07UcBw9wXloJquPLe2VpVLGeWkpAkX+O2SZPpDhZUIoaAr/2/5c1ucO4R6FDDRMPzqkaoA4Nuwmf@vger.kernel.org, AJvYcCUpJIvaQXyx8lwzTi3v5kl4i8vcDnEXwdf6BwMjcv0Sbxxqa0egj4gZOYU7TJ8aaXfyRvyB5ux6nNabcQ==@vger.kernel.org, AJvYcCVFnTPhy0IH+h2sRTo2DG6NMTDavS+Sa9c2NbxyRgNbqmwPJxQKgUdf8WwLbPVt/kFVBox7/vqh3vLO@vger.kernel.org, AJvYcCXxVtT2bj6sEpdNZ0F+OM5oR6XP76ptn0KTlajm/2c9rx3EabsbfDMRjIc1wLvlwRJTHNo/kRHHxGM1@vger.kernel.org
X-Gm-Message-State: AOJu0Yws5BoH5vCdukFjhgE/cOV8xsUL8cV4gvep1WTQzdoKtdBjxEfv
	XSvFtYPtBRK3BY2PpSZn9PoaSXZ5ALq4WP1jFOoNMDLN/Yq0tGFh
X-Gm-Gg: ASbGncvIKJHGJe3N+4sAbhPkaD53Bh0M5rEf2NwlYVdtGCy2h+QSoadl+9zGOr5QzZF
	V86JbBmLsnb5VpcMHsQE3rlyA/SceUjnmyxOqQ6gxWsQkRoTPl+0EuwCgNcbHWJeEv/vYeEjaXu
	xJcjX0TL1l2+Yz1G7jURam0U0SRVSnUcqk4nxiQgqVl9yGFmgvS8ujJZfjC4LCOU4lEoGts2wY8
	UY2TAnI5yq4FDteC9Qp7fQlsdQsJwMEbE/aRlE07gFhPCR5WCa2RenzhZa9ORwtI4i+MLNeLQWJ
	+LSXVkDepiY12lLCusgZr5PrQ15b
X-Google-Smtp-Source: AGHT+IHrPWFfESDy3MF+EVv4iQLpEI4ETPkzkJJamYZ4dmEkxgNT17VUpb3qygUijPvGYprd3/Y31A==
X-Received: by 2002:a05:6512:1598:b0:540:1b2d:8ef3 with SMTP id 2adb3069b0e04-54405a68f77mr925982e87.52.1738763900285;
        Wed, 05 Feb 2025 05:58:20 -0800 (PST)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543ebe0fe60sm1934030e87.82.2025.02.05.05.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 05:58:19 -0800 (PST)
Message-ID: <8353a96d-fe39-45c2-b6da-e8083a6bdcd8@gmail.com>
Date: Wed, 5 Feb 2025 15:58:18 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/5] iio: adc: Support ROHM BD79124 ADC
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Linus Walleij <linus.walleij@linaro.org>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org
References: <cover.1738328714.git.mazziesaccount@gmail.com>
 <e44851669ce7e91d1295ab7352535c93b89d35bf.1738328714.git.mazziesaccount@gmail.com>
 <20250131174118.0000209a@huawei.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250131174118.0000209a@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/01/2025 19:41, Jonathan Cameron wrote:
> On Fri, 31 Jan 2025 15:37:48 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The ADC supports
>> an automatic measurement mode, with an alarm interrupt for out-of-window
>> measurements. The window is configurable for each channel.
>>

Hi Jonathan,

I just sent the v2, where I (think I) addressed all comments except ones 
below. Just wanted to point out what was not changed and why :)

...

> 
>> +struct bd79124_raw {
>> +	u8 bit0_3; /* Is set in high bits of the byte */
>> +	u8 bit4_11;
>> +};
>> +#define BD79124_RAW_TO_INT(r) ((r.bit4_11 << 4) | (r.bit0_3 >> 4))
> You could do this as an endian conversion and a single shift I think.
> Might be slightly simpler.

I kept this struct with bytes matching the register spec. Doing the 
endian conversion and then shifting would probably have worked, but my 
head hurts when I try thinking how the bits settle there. Especially if 
this is done on a big-endian machine. I can rework this for v3 if you 
feel very strongly about this.

...

> 
>> +static irqreturn_t bd79124_event_handler(int irq, void *priv)
>> +{
>> +	int ret, i_hi, i_lo, i;
>> +	struct iio_dev *idev = priv;
>> +	struct bd79124_data *d = iio_priv(idev);
>> +
>> +	/*
>> +	 * Return IRQ_NONE if bailing-out without acking. This allows the IRQ
>> +	 * subsystem to disable the offending IRQ line if we get a hardware
>> +	 * problem. This behaviour has saved my poor bottom a few times in the
>> +	 * past as, instead of getting unusably unresponsive, the system has
>> +	 * spilled out the magic words "...nobody cared".
> *laughs*.  Maybe the comment isn't strictly necessary but it cheered
> up my Friday.
>> +	 */
>> +	ret = regmap_read(d->map, BD79124_REG_EVENT_FLAG_HI, &i_hi);
>> +	if (ret)
>> +		return IRQ_NONE;
>> +
>> +	ret = regmap_read(d->map, BD79124_REG_EVENT_FLAG_LO, &i_lo);
>> +	if (ret)
>> +		return IRQ_NONE;
>> +
>> +	if (!i_lo && !i_hi)
>> +		return IRQ_NONE;
>> +
>> +	for (i = 0; i < BD79124_MAX_NUM_CHANNELS; i++) {
>> +		u64 ecode;
>> +
>> +		if (BIT(i) & i_hi) {
> Maybe cleaner as a pair of
> 
> for_each_set_bit() loops.
> 

I kept the original for 2 reasons.

1. the main reason is that the for_each_set_bit() would want the value 
read from a register to be in long. Regmap wants to use int. Solving 
this produced (in my 'humblish' opinion) less readable code.

2. The current implementation has only one loop, which should perhaps be 
a tiny bit more efficient.

>> +			ecode = IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
>> +					IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING);
>> +
>> +			iio_push_event(idev, ecode, d->timestamp);
>> +			/*
>> +			 * The BD79124 keeps the IRQ asserted for as long as
>> +			 * the voltage exceeds the threshold. It may not serve
>> +			 * the purpose to keep the IRQ firing and events
>> +			 * generated in a loop because it may yield the
>> +			 * userspace to have some problems when event handling
>> +			 * there is slow.
>> +			 *
>> +			 * Thus, we disable the event for the channel. Userspace
>> +			 * needs to re-enable the event.
> 
> That's not pretty. So I'd prefer a timeout and autoreenable if we can.

And I did this, but with constant 1 sec 'grace time' instead of 
modifiable time-out. I believe this suffices and keeps it simpler.


Yours,
	-- Matti

