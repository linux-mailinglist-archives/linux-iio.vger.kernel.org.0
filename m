Return-Path: <linux-iio+bounces-16246-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 803B5A4B1C0
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 14:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97401892956
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 13:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB8B1E51F2;
	Sun,  2 Mar 2025 13:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHiX9w3b"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8607A1BD00C;
	Sun,  2 Mar 2025 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740921018; cv=none; b=HcbU5c0z8x5pap4H5G/lBrZYwlryouA76A3v1Outu/t70R/szQLR1MQZeziNQ/oKH4vREaw++dsQUMMT0gV2I4wRsEtX8rmQRottbLMC5IddNQrDpLS5Mf/DH987zf/uKWcZRTqE2Xb8BN9CI2hqbH9AczcEINSLj8ikKC4OhE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740921018; c=relaxed/simple;
	bh=3ueYCQOJuTgMaM0PoECxWpAIMs+UVlEi7x0gp9ylX2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDKvNdJtF2VJwqFdz8i7WLl4lvBNr0GL0WCG1aUyrJEWofH1JMv2DQ+F/qIfUmr24rOv1PFIA4eDUlMvIqGxyQuoF27GDfORbsAokOy5kqQp1R+2XIs1JitlklwZSH8ruxFuhkrv/7KSfjB3+jOgL7Yamy8SI/54bTIAiXxDrQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHiX9w3b; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5495c1e1b63so1029848e87.0;
        Sun, 02 Mar 2025 05:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740921014; x=1741525814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jG5tOje/zlA/EkhYa4q9r5CoNV0SFPoKRvJ7r+JyzFY=;
        b=cHiX9w3b9efIV8HSghS/sUuw5GfjZG7dYGs+z5wj5ejaNYb0a6lxRKrSvWDLfpQE8b
         N8tUWnYHF8jly1EZhKWVT/2P2HIRuTCukXTLZ9V4O9Ry9bnySpfX/4dt6Rz34Rbyuzhm
         cjh67Bew7e391EXIX0/HbrpbAN+9gEFdxfSrvz4kbiYf08/EdR/+gcvt7IPKuyl64X5Q
         6LhfTvvIutDj52IV/+XX9xu3ta7oQS7SR7RRDSxn2uFRtLBM6IUl4BhHy6vqQo43F7cL
         XorHZ2DtKP0V5yyE00pp9UOwGhM788BQT8KUJzOxDwuF9dgySuIrLE5khv+yT7R3WEzS
         ZDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740921014; x=1741525814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jG5tOje/zlA/EkhYa4q9r5CoNV0SFPoKRvJ7r+JyzFY=;
        b=CHst+iljeikhbHIzMhB3tTatJqF+ZIc36/3z64KCKHalS4t6LAU3CsCz1d3esA1EhH
         Q3nd89VgIE+B2UNjUqPoIJxWwGTtGA1S0Cq7qUHev60zyB6OyqY4twCKkb1ncaXzLfZH
         KkE0nxC9WlzMl8qyhDRV5ud30ZdJOe2SjMIIIRpbBZK3PVrRDf5JBazcGcVDzun2O0Az
         7AjjbhuauU6DJL+vB0j/iLyyiJ60VIqWnaBxQLNjQWzfdFhQwnW/3In7K7LSU+xe6Ye4
         V6gVkh/Lk6Sckdta/n8yrt6pXx7td/YiVVEDXOyx3OlItoBeUDl/c5jdg6QjXgrU6o5J
         WFEw==
X-Forwarded-Encrypted: i=1; AJvYcCVLm8VpN78i9gN3F6JqHS17HZpiMccf19Vv0DiCQGS4EhZqxzS9c9aDZ+/0ZcOPM3jOWtg2z4xIJP2XWA==@vger.kernel.org, AJvYcCWaPFd59iBbbhsNdIoNYj6UqAtpO5DZt4vqyuB7YFxDK1wQOX1uZqDBqOAOdvJuK0KZ8PThuKNyEfzFDcJlO7yQH3o=@vger.kernel.org, AJvYcCX9BhoA4tPILsxJswPE0WlRSnVwdr7a1TfNBdgk1aa7X4/2PaBWKg4AKdMXVcmgAZ+wMH18HaV+Qy0Z@vger.kernel.org, AJvYcCXFKCl6QHYYEjOPKdi8/Kx73OY7cWNgwFug8Th6uBausG4ZCvS4tHNmsJuiOmoRwoxes+1sVC69VaxhKP6F@vger.kernel.org, AJvYcCXdVYigKinTVlVDkk9++HS+fkwrxYvPMlX0qg75DOH2j+8fpn03XaN0mOtfnTUrZ7puoTingIEaQ3Tk@vger.kernel.org
X-Gm-Message-State: AOJu0YwUIbsm/ZpLKDv7XePG7mCWUJ91H/JCO4PERe6ceKBh3jWyU0fn
	baEkL5FOCjJt2wpg+oHyenQEX4c7CxOppKTJhLzP13g1flC+zsxk
X-Gm-Gg: ASbGncuQfXkqKY6hrBYxtgfbWwdDkVOZAMNz4Ljl6Kzou9QkYnwGbyr4fJbgPeFpqXk
	3f50TPiCEiLeOWwyxikqr4cRU6bZTYSr5+8v5F2RoAlRalzXyTTho/rL0BJKQV2WVQVWqwS0fqJ
	DWfmuFQcbD6+MbM/RMQvpGXEQXm3vB0tbLkDJhsfoslcIEH/kQPzDcDXvwfXTbRXR4QM2DjDEVY
	UEa/Nsmjg62oKpp2OLnpoIUZgXwNaOlHFj9eO05X9kyFt67a/ky28NWZL0WSwY9EjqMkDdT4Ntb
	z+TDS2mr/uw42EuxQpLYF1SE4rJtNVf1E9pcz3K4LA8XlQvhhFaCjbpvcK89jNxZo80Txltt2vd
	HuJfxZc5iLwMrGX/tdE4e0ANCKw==
X-Google-Smtp-Source: AGHT+IEGL2GOx+6uK3ORwgW8vnlHYwV9+sg7r6kI4MAFfSmBYTvXGphMqMVaTf+mMGOgpFgDCZ0DhQ==
X-Received: by 2002:a05:6512:3b83:b0:545:ae6:d740 with SMTP id 2adb3069b0e04-5494c350911mr3777634e87.41.1740921014388;
        Sun, 02 Mar 2025 05:10:14 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5495fbe4daesm229117e87.100.2025.03.02.05.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 05:10:13 -0800 (PST)
Message-ID: <7c79ce3a-0dc4-4aa4-941a-e05be9a34fb8@gmail.com>
Date: Sun, 2 Mar 2025 15:10:12 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/10] iio: adc: ti-ads7924: Respect device tree config
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
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
 Samuel Holland <samuel@sholland.org>, Nuno Sa <nuno.sa@analog.com>,
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
 <d391b012-0a8e-40ca-af56-ca73b3fd853b@gmail.com>
 <20250302032713.1c834448@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250302032713.1c834448@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/03/2025 05:27, Jonathan Cameron wrote:
> On Wed, 26 Feb 2025 08:39:11 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> On 26/02/2025 02:09, David Lechner wrote:
>>> On 2/24/25 12:34 PM, Matti Vaittinen wrote:
>>>> The ti-ads7924 driver ignores the device-tree ADC channel specification
>>>> and always exposes all 4 channels to users whether they are present in
>>>> the device-tree or not. Additionally, the "reg" values in the channel
>>>> nodes are ignored, although an error is printed if they are out of range.
>>>>
>>>> Register only the channels described in the device-tree, and use the reg
>>>> property as a channel ID.
>>>>
>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>>
>>>> ---
>>>> Revision history:
>>>> v3 => v4:
>>>>    - Adapt to 'drop diff-channel support' changes to ADC-helpers
>>>>    - select ADC helpers in the Kconfig
>>>> v2 => v3: New patch
>>>>
>>>> Please note that this is potentially breaking existing users if they
>>>> have wrong values in the device-tree. I believe the device-tree should
>>>> ideally be respected, and if it says device X has only one channel, then
>>>> we should believe it and not register 4. Well, we don't live in the
>>>> ideal world, so even though I believe this is TheRightThingToDo - it may
>>>> cause havoc because correct device-tree has not been required from the
>>>> day 1. So, please review and test and apply at your own risk :)
>>>
>>> The DT bindings on this one are a little weird. Usually, if we don't
>>> use any extra properties from adc.yaml, we leave out the channels. In
>>> this case it does seem kind of like the original intention was to work
>>> like you are suggesting, but hard to say since the driver wasn't actually
>>> implemented that way. I would be more inclined to actually not make the
>>> breaking change here and instead relax the bindings to make channel nodes
>>> optional and just have the driver ignore the channel nodes by dropping
>>> the ads7924_get_channels_config() function completely. This would make
>>> the driver simpler instead of more complex like this patch does.
>>
>> I have no strong opinion on this. I see this driver says 'Supported' in
>> MAINTAINERS. Maybe Hugo is able to provide some insight?
>>
> This seems to be ABI breakage.  Never something we can take if there is
> a significant chance of anyone noticing.  Here it looks like risk
> is too high.

Ok. I'll just drop this patch then. Thanks David & Jonathan :)

Yours,
	-- Matti

