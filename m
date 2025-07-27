Return-Path: <linux-iio+bounces-22064-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B933BB131A3
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 21:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77C491885D9F
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 19:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A36522B8CB;
	Sun, 27 Jul 2025 19:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdXLXIha"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7A4221737
	for <linux-iio@vger.kernel.org>; Sun, 27 Jul 2025 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753646322; cv=none; b=qg+5UmQCLkn2A2pSietzXQvuKhwEZpzGtCUZuigd146SYdvP3U0vXWm9DmPJsMs6TFdRnT/Hiq4MNrjFr1Tio3HoYBPlsqheUH5aG37ryUAFrWOuaKJ8d26AH6n5rx4PHpZj+oXns5jZaj2UpHnbxADfy0m67CPAFmnqWqttlx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753646322; c=relaxed/simple;
	bh=+2PpqvxJDjlRw2Q/mrSyG+2S0Khau2+UKH/iO9zHlbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cMb2BVX9K8aoBRpBV8inPhNCHwbtFz6YmDRSwKexTagsZwTIg8QHzxLFs/i1adex+0cxD233e+vq9PmDrsSU1qCO59yPG4yvIsGkPsCgJGKZRCghUNk0HNV9q2kTR2wZfq1m9gvX3rH5qlRZ1NoWinG3/RGJCGo77EbzXYhFIYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdXLXIha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29770C4CEEB;
	Sun, 27 Jul 2025 19:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753646321;
	bh=+2PpqvxJDjlRw2Q/mrSyG+2S0Khau2+UKH/iO9zHlbc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mdXLXIha0cClryd2oX9J6LJdfvz/7/5vm7mHv3ADXVI6MXQEOOXzbtLAyVIgbQoOr
	 EpsoBn1MqBRYa7/RQLbJWt6A01Z67buF2kqMEeYNO1XxK/FTqQJafQnUgqTYKQBP8c
	 10SXwvMsBj+FFnQOQYlcAquaJlQ5IV3xvMUqTyaZDuvazjScrKiTiVhJiM9LCqQXcu
	 pqgHocE0Rt9Sj9Ls29CN74TlHLFgMGD+pY7/7YKHCx2J/N95bGJpg4Jjrz8siK/yXW
	 iF+2+RjgnDvPOxGrtt8yHqFCvMoY8lK1ExlfOYko4bMYWtAGL+82tjYh+f/ZeoklWT
	 zh33poV+Xk7aw==
Message-ID: <b40b5435-f920-4b95-a90a-e40d1388c8fc@kernel.org>
Date: Sun, 27 Jul 2025 21:58:38 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: Add Intel Dollar Cove TI PMIC ADC driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>
References: <20250721150614.51918-1-hansg@kernel.org>
 <20250721150614.51918-3-hansg@kernel.org>
 <7e3cc17a-1ceb-40ac-bc4c-31487cd0deea@baylibre.com>
 <47bc1555-0855-4dca-a189-ce84e14d9e41@kernel.org>
 <aID-xkMl1kp8GMiw@smile.fi.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <aID-xkMl1kp8GMiw@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andy,

On 23-Jul-25 5:24 PM, Andy Shevchenko wrote:
> On Mon, Jul 21, 2025 at 09:02:10PM +0200, Hans de Goede wrote:
>> On 21-Jul-25 8:43 PM, David Lechner wrote:
>>> On 7/21/25 10:06 AM, Hans de Goede wrote:
> 
> ...
> 
>>>> +#define DC_TI_ADC_CH3_DATAH_REG			0x5A
>>>> +#define DC_TI_ADC_CH3_DATAL_REG			0x5B
>>>
>>> Could be less verbose with just:
>>>
>>> #define DC_TI_ADC_CHX_DATAH_REG(x)			(0x54 + 2 * (x))
>>
>> Ack, will fix.
> 
> And drop H, it is not needed either if we properly use endianess wise types and
> conversions.

Ack

...

>>> Is the raw value already in millidegrees C or do we need
>>> IIO_CHAN_INFO_SCALE here?
>>
>> The scale is unknown (I guess this depends on the thermistor
>> connected), which is why there is no IIO_CHAN_INFO_SCALE
>> here.
>>
>> Note I have no datasheet, this is all based on the Android
>> kernel sourcecode dump mentioned in the commit message.
> 
> I think I have access to it. What should I look for specifically?
> 
> (list all your questions here, please, without spreading over the code and mails)
> 
> But note, I will be on vacation for 4 more weeks (and I think it's not an issue
> as this is material for the next v6.18 cycle anyway).

Thank you for offering to look up the datasheet.

I don't really have any specific questions, I just mentioned this
because this is part of the reason why the scale for the temperature
channels is unknown.

But just the datasheet will not be enough since the scale also depends
on the thermistor / ntc / other-type-temp-sensor the channel is
connected to.

Regards,

Hans




