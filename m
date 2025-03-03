Return-Path: <linux-iio+bounces-16250-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B490A4B85F
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 08:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65EB73AFACF
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 07:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629591E98F4;
	Mon,  3 Mar 2025 07:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ho51QRC6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1B81EA7C0;
	Mon,  3 Mar 2025 07:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740987193; cv=none; b=WD841827eWgK7swmCiLcvSn0slQRx8OOJULEZWHja5/9NtojBShyA/o6w1rwzK2xOy0ZLOPd2LhDXKDuXKzXqlVgByVqjnvZrAGiMRGfNH0wvrGlFiEOaGYwPbCMzgwykLRtx5mcgCjbUdccjfJJESp6O7XgB40Y2OGcwSC28ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740987193; c=relaxed/simple;
	bh=5eF7GEXxzpWu4yOg9pvtBatpJVXLkGtCFTy/RS33fx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cX2ah5eks7PZ+DUXY9m4htQOmUtGrUTiFyJqf1VviWTkpFBVBPwi4qPVtK0v5lpQpGArHQuWxF5H6mBztw1b5DveQqWt9zUKjBm2+oYTX8VGGri0Ig5D5YaFn7b0xDKMbOWTYm/kUiRhLqrRvCyAWzYRFak6F0eFCz48P6YLJmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ho51QRC6; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30930b0b420so34255601fa.2;
        Sun, 02 Mar 2025 23:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740987189; x=1741591989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZrfT43/ChI686f8asUl/9QZweWrcr9+CbhtUfhxyfBk=;
        b=ho51QRC6OPKJ9x64toi81G2RUATlCM936OnIsg6d90HVpztMxGripzSodRgLYBfpfe
         4VFvqxGWn1KNeGxE18c6FL4QNUiIUqSkaCe2I6j5mniOab/FsSn2bJLwyyNzSF++NhB2
         GAeriIojcgYWidiVaqpdlRQdSJOcJ5MbSUR/swPTZOJhUiyBuUzloxH/ZeLfr1P4kn8o
         xmbzVW52NlqJXDh/ny2Mvm+fZP9rVK8ZX1wm5M3V7sc2k++5GF2Vr8RXG9wcA2N1uEWh
         XbHBZhn5mljV4Rt4NbqWlPyCVEBcNgo5pePSGSy3bPxL5VNw2VS/OhRE2AXMeWwJBveO
         zGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740987189; x=1741591989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrfT43/ChI686f8asUl/9QZweWrcr9+CbhtUfhxyfBk=;
        b=VkCBPu6qDp8pK5yjTRuqyKTA4xOycQKoIUC8+P6GQqfxE38+S2Nnfmh+r+91wwTH3u
         IT7IK/W6OodZAlttN+Dv/XEdTDdXefwJVlPKWUrHMwNfJTtAs3X4IbvbDlHQBSj04VJk
         dQsy6qf1xYb2vXAxAProGYZjGRs0v8EOXdRUGC5X36K4t+nEH2VoPgZjBm+hYFmVtpM0
         rDO4+mocapIjuTvX0PlQ2hE8rLabzhOx7TZMosDsaNnjYDSt2WVtnaW2rUqSR6kCQZ72
         /V21K0YZBrQSnGAW2ulTm1g6XXD1S7l+3t7s7aUKNBUaMNCjmrvA+FF/gVWxuZrBOu0z
         GX/g==
X-Forwarded-Encrypted: i=1; AJvYcCWdVjxCWTKrXcajx+ZnsG7UFKTwpBCqg5cpezOXjwX7x9YaULlQo6C5D29pLZIWyXOURooOtpt+dqb5Sp5L@vger.kernel.org, AJvYcCWfg8mea8W93IQkkYdu/kEOhRSMeW5CIp7yqpZRfO/VUMmktYxbEKKm/Wmyzdfvkcyfnj3onzvRjN1vPbko3XgHMAw=@vger.kernel.org, AJvYcCX2ezrCP4wPBgo16Zy1AYuXHiyJIEjX4pQQvT5yKKRslanNgFnNFosy5SvgVaZBg/kWIESuJffhFku4jQ==@vger.kernel.org, AJvYcCXi0dgqld08r9XeYzRgThyn1jWnCB3mtFO8IWq7ReSzkULwvoAqhCcMMBZHvHrg0O6uRW1Zy60XfObg@vger.kernel.org, AJvYcCXyE4bbDAsyK/qphGvzJmG8olFZyperlypvGf1ZpeNnf0uigvd2YLwxBygNf53uwr7uTFPsns/F60xi@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7ZDNMM92kKzSamDJAyNjvLulNnoIslp1fsEEI6s1hUClZ4Hdx
	dD+fGTDxCQrlpVxT9qeX/nah48tZLJ1p/OoACBpwBiBiTBB+YujP
X-Gm-Gg: ASbGnct9JZj1gcspvn009+izO+oHIQVK5x1LQ1tkkw5VV3c2kMpOgwIDtwNN88Ex5b/
	3HTEGqrjiov4/KSOgA3Mban4+mZDpGAWFwH3aIILr1bqW5E0+yH1lCN0sXSy8BDB/Bbca/8qEM4
	XXjDOMo92+MJE085JSyIJTXsBHQIcSoTqQ0P2De4nCTaMOilv95ct3Yy7ZoThDCrAhdSxcExGCa
	DVN7ZSRloJOnMz1IRtzf7SyTgMHSsMnm2vsgp1Gvl++MuXhdT3kQCRM45mcNWwsRTcgu6MTy1Gc
	2pfDKZYo7RpC+9ffdBJZqmisvsG/gXGh8h4o885O25Tgzw5JZNsRdaJey78NnqlPQrEq/z7EBxv
	OsatlN1DkBq6Hpa6phH8nxOyVYg==
X-Google-Smtp-Source: AGHT+IFYoPik8tqIuOOXAJZxxEM4FjnMpyrSDbqpvuiBUw+N4rWidoyXw4/acgqr1fgBuicookECFg==
X-Received: by 2002:a05:6512:693:b0:545:b28:2fa9 with SMTP id 2adb3069b0e04-5494c122af7mr5686831e87.16.1740987189050;
        Sun, 02 Mar 2025 23:33:09 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5495a7d6a2csm602975e87.227.2025.03.02.23.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 23:33:07 -0800 (PST)
Message-ID: <ce2c1a21-f418-4ed9-9cd3-fe2a68f08c31@gmail.com>
Date: Mon, 3 Mar 2025 09:33:05 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/10] iio: adc: ti-ads7924 Drop unnecessary function
 parameters
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
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
 David Lechner <dlechner@baylibre.com>,
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
 <38d39befcca110132fd4349c87fcb5d7ff51a2c8.1740421248.git.mazziesaccount@gmail.com>
 <20250302034649.2d9ec2a4@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250302034649.2d9ec2a4@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi dee Ho again Jonathan (and all),

On 02/03/2025 05:46, Jonathan Cameron wrote:
> On Mon, 24 Feb 2025 20:34:01 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Device pointer is the only variable which is used by the
>> ads7924_get_channels_config() and which is declared outside this
>> function. Still, the function gets the iio_device and i2c_client as
>> parameters. The sole caller of this function (probe) already has the
>> device pointer which it can directly pass to the function.
>>
>> Simplify code by passing the device pointer directly as a parameter
>> instead of digging it from the iio_device's private data.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Looking again at this function it doesn't seem to be doing anything
> useful at all.  It checks the channel nodes are in range, but
> does nothing with that data. I'd just drop it entirely.
> 
> Ah. I see David suggested the same.
> 
> We can't really 'fix' what this was perhaps intended to do now
> as what it does has become ABI :(


I took another look at this.
The logic in the ads7924 driver (without this patch) is actually:

ads7924_get_channels_config(...)
{
	device_for_each_child_node(dev, node) {
		if (fwnode_property_read_u32(node, "reg", &pval)) ..
			continue;

		if (channel >= ADS7924_CHANNELS)
			continue;

		num_channels++;
	}

if (!num_channels)
	return -EINVAL;
}

...

ads7924_probe()
{
	ret = ads7924_get_channels_config(...);
	if (ret < 0)
		return dev_err_probe(...);
}

So, it still returns an error, if no channels with valid 'reg' property 
were found from the DT. It will also fail the probe().

Thus, this change is not quite as likely to cause things to break as it 
seemed. Still, for now anything with even single valid 'channel' has 
been Ok, even if all the rest were garbage. This new variant would fail 
if any of the 'channel' nodes contained no or bad 'reg'. Thus this can 
still break things.

Anyways, I'll follow your suggestion and drop this patch (unless you 
have second thoughts) - but I will keep the function so it still 
requires at least 1 valid channel node to be found.

Yours,
	-- Matti


