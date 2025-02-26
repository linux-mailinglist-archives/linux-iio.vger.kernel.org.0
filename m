Return-Path: <linux-iio+bounces-16074-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4ECA455E2
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 07:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73ADC1894E73
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 06:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BAA26D5AA;
	Wed, 26 Feb 2025 06:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADAq23Qv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF1C26B098;
	Wed, 26 Feb 2025 06:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740551958; cv=none; b=FQAJdsVB3h0ZnQAudeZb+eLRgmtbZ8YZ3+pKpGb98Ep0TGcPSpYpa+bMMBgSv/4txtGFVgCWqzEMold37MaVPjOmTM8l1dlVsNF9YE0z0sbYbcV1FTLD1doeyQDBBgFWBidB5SO2QmI3DMM0stG0eQ1IvOaGZq4sLjNNwXx4+CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740551958; c=relaxed/simple;
	bh=g5vd5KaFOaIGh4dgJu04AUD2p2OpmMkuWZMXJcPEHu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FHr+P7GSUlL2sV1BCtAx2tQ8524/hENC2L6vAS4v9k5YEHDi01aq+FGHdQ6EYb4E/HDp7PAnc8JWi/pByeOZpV9Qi28dZok6+uX7B7qn0kbYETssSpJioxnH2OcEagnquVaUBFPYuIrkE2XSQHamkM7D4/u0cQBlxwyXK9+N3aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADAq23Qv; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-307bc125e2eso59847691fa.3;
        Tue, 25 Feb 2025 22:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740551955; x=1741156755; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IstkuYPp0cvmrCBS1AO74kpqX9/bPmaEIwBW2fMXgJ4=;
        b=ADAq23Qv4UOH449WSdWfy7QHQLcPAKLL2g/7uypWvvn1Bj1YjDHexc9Wf80vJNAuMM
         +O6lKwyVEGdH99GhpEE2+71oQb5M+C5lxiTyZZtBDHCkF++NaLEwvgu7wwUZmxszqSWL
         G6qbfEQMeNqECHnBa30ByO1NqS2y1yg6WyV7sznesLEOKMRBu1YaHDqU15Rf1UwiF1dS
         lv54yBRVM0Ic/ifQhj4u2+91kewMaB5Q3nRTfMjDWLVdGLf0FtFSPwywwdW7lk13LNam
         sM2wWsMvi6HkxDOHXmewww8Q1p4C3M2Z5PrV6C2nNtq7daWxfXIp8OxKaBjC+tmnXgX8
         S9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740551955; x=1741156755;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IstkuYPp0cvmrCBS1AO74kpqX9/bPmaEIwBW2fMXgJ4=;
        b=YKzDsE1/Ps17bu76qQo3ZgbtabS/2JUNjHlxDhNMy0VO+Drmdh6KNN1hM1QOMCr7Zd
         NqhF9IVXEY+AUe7h6j9h5tqS+vLzWQAjllEbNZRbr3fNrOTZuqz4Y4wa//DEpH5orcwf
         7J8pDw+cUOUW6rWeDMo61bv6R4JvEMIJ4av/M9QXkmGPM1NEkTCUWpFviyqWdLXIAaqZ
         W70/lCIVctzEWJq//qQxQVDbzv0DMAL0tUpcTlbHGXmdU0HdSDPHP9EaBDMi/joAhJ/t
         hPLaRsI3F9pGUv7diR39B3KCw2AOfOhTufMupmdIpJpEKjjk6Lh+LCusifFQTxYWrYGY
         zHjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+CMYhvmpE3f/vLNv7ebGrV5DWB1TUQBOi/Vkmi4Y4U/gdAtoabI2iYaPjtpWa4H5sD2z67GCmyzKyxx7Sp5yRlJU=@vger.kernel.org, AJvYcCUIWGd4HMD8ekC73PGAjhA7vQf9oCBdRjqmPiaF4NIVUBLW7PJKJytWftU2vFQAQV1wUBeRD7V1Eam05IkZ@vger.kernel.org, AJvYcCVJj+amQcLYLcFtmJ76xYAQ/vsfAWz0kYkDvyVoGwTfb17BPtarLehchtH0GIDKvtfD7k6x5PQjfmHDZw==@vger.kernel.org, AJvYcCWAW4eSzEDUs98oORuoiC60jtP/BH3RtEi6nAg3gmoh4qTJvyJslvFsVhhlqc834LWCp+KyGei+wHys@vger.kernel.org, AJvYcCWyZVql9MFLrmTX1SU1YFKboS69mxHUICGYiPpBKekydqJpe/JBjErtuVyrshMhOgpBx/Sc6F1saGHW@vger.kernel.org
X-Gm-Message-State: AOJu0YyR0OdIMEeP0MQ1wRm343mxY/FeFTTR+50TZo2oPCeJp6V6Yj0S
	ql3lopaE9i0u8BC1xC7ycVrfx85Pk1uODIQDZDNOq9tISx0bdGLT
X-Gm-Gg: ASbGncugYevPCY6EYt7ld4vXBGMvEiuSEnjauHk86V+oYmpMlRPUQIANT4TYFmsrEAW
	SZ1zOwuts4qCdRCAuwLuuLMvmtQ6wU8gRfb9vp/EAsk8CQreAur07nW/93ZPaNZBbVdjrRrzugn
	HBhOmetz/xU69BcQg4QdGQumMQ8vwdm0axWrp8x/yA2GFCqIcB8IWFcS9bENrSuedGgRLjSGYme
	XHujAK4QM3zovWCzHgbOfeHnYAY+XMrew3FYOhXUOpdZf5JR4rtUwdCi7MRdeX8zaMEPBXNdO0+
	blqTD4YEvK+B7RkVAQWsf4ZAx974z22Y5DDSgTm2tuk5wNzJbfcGG0jPRFYeRM/0LCos8FBdEyy
	suaHEJjg=
X-Google-Smtp-Source: AGHT+IFhddv2BVjLa64XQJMIkv5m8GKYZ1reuiVfZ9tztojl8c9MwGp7Re17nRul5qHTHrRj15T3+g==
X-Received: by 2002:a2e:968c:0:b0:308:eb34:103a with SMTP id 38308e7fff4ca-30a80c97fdfmr38366891fa.28.1740551954311;
        Tue, 25 Feb 2025 22:39:14 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a81ac4873sm4197931fa.79.2025.02.25.22.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 22:39:13 -0800 (PST)
Message-ID: <d391b012-0a8e-40ca-af56-ca73b3fd853b@gmail.com>
Date: Wed, 26 Feb 2025 08:39:11 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/10] iio: adc: ti-ads7924: Respect device tree config
To: David Lechner <dlechner@baylibre.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Nuno Sa <nuno.sa@analog.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Guillaume Stols <gstols@baylibre.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
References: <cover.1740421248.git.mazziesaccount@gmail.com>
 <20dd0e4ea72fe39b90b611f9c08dbd4bc1d5217f.1740421248.git.mazziesaccount@gmail.com>
 <f0d0f114-3953-46b5-b9f6-9b35537e6f8e@baylibre.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <f0d0f114-3953-46b5-b9f6-9b35537e6f8e@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/02/2025 02:09, David Lechner wrote:
> On 2/24/25 12:34 PM, Matti Vaittinen wrote:
>> The ti-ads7924 driver ignores the device-tree ADC channel specification
>> and always exposes all 4 channels to users whether they are present in
>> the device-tree or not. Additionally, the "reg" values in the channel
>> nodes are ignored, although an error is printed if they are out of range.
>>
>> Register only the channels described in the device-tree, and use the reg
>> property as a channel ID.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
>> Revision history:
>> v3 => v4:
>>   - Adapt to 'drop diff-channel support' changes to ADC-helpers
>>   - select ADC helpers in the Kconfig
>> v2 => v3: New patch
>>
>> Please note that this is potentially breaking existing users if they
>> have wrong values in the device-tree. I believe the device-tree should
>> ideally be respected, and if it says device X has only one channel, then
>> we should believe it and not register 4. Well, we don't live in the
>> ideal world, so even though I believe this is TheRightThingToDo - it may
>> cause havoc because correct device-tree has not been required from the
>> day 1. So, please review and test and apply at your own risk :)
> 
> The DT bindings on this one are a little weird. Usually, if we don't
> use any extra properties from adc.yaml, we leave out the channels. In
> this case it does seem kind of like the original intention was to work
> like you are suggesting, but hard to say since the driver wasn't actually
> implemented that way. I would be more inclined to actually not make the
> breaking change here and instead relax the bindings to make channel nodes
> optional and just have the driver ignore the channel nodes by dropping
> the ads7924_get_channels_config() function completely. This would make
> the driver simpler instead of more complex like this patch does.

I have no strong opinion on this. I see this driver says 'Supported' in 
MAINTAINERS. Maybe Hugo is able to provide some insight?

>> As a side note, this might warrant a fixes tag but the adc-helper -stuff
>> is hardly worth to be backported... (And I've already exceeded my time
>> budget with this series - hence I'll leave crafting backportable fix to
>> TI people ;) )
>>
>> This has only been compile tested! All testing is highly appreciated.
>> ---
> 
> ...
> 
>> -static int ads7924_get_channels_config(struct device *dev)
>> +static int ads7924_get_channels_config(struct iio_dev *indio_dev,
>> +				       struct device *dev)
> 
> Could get dev from indio_dev->dev.parent and keep only one parameter
> to this function.
> 
>>   {
>> -	struct fwnode_handle *node;
>> -	int num_channels = 0;
>> +	struct iio_chan_spec *chan_array;
>> +	int num_channels = 0, i;
> 
> Don't need initialization here.
> 
>> +	static const char * const datasheet_names[] = {
>> +		"AIN0", "AIN1", "AIN2", "AIN3"
>> +	};

Thanks for the review David! I do agree with the comments to the code.

Yours,
	-- Matti



