Return-Path: <linux-iio+bounces-15789-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D127A3C01D
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 14:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C27F3A699A
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 13:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAAF1E5732;
	Wed, 19 Feb 2025 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHph9ofT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACB01E5718;
	Wed, 19 Feb 2025 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739972183; cv=none; b=VJwwMY6iJrOKP99qj6QqthQbtI7AGHyGpU834S8dNgyHYa4/hqm43eEEEuSMfZ+3uEXE5AfgzPtYRpI0lLhGh0ca0gVNV0uMzvYfDDJmYr7fpn1kLsQNPBrujoz6v/5bsS6fTAmR1jK9orvV60X+NIDP/HMwACHNaEhIJBWbMik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739972183; c=relaxed/simple;
	bh=7ihWjXMDbjH1f4hkfj9yu5zjMSN4SJcUGVD62F9f64Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6P3613P6eq+5a2tpssHQKIS3befUcA6LUF1rQIAphQ4IHBWYaRs3vU7bYArqsti07r5Y/mAP8Yvx2eZh2q0TcA434/Gu85+BHAz7179Orq6R9Z6KU5EZOucccKVheyd8S5LNRbkzVtro9vwB4bnKPEEZa2aS54N+HJTvXT4pcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHph9ofT; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30737db1aa9so63425071fa.1;
        Wed, 19 Feb 2025 05:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739972179; x=1740576979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HSsnV19R3euCe7A+mmLLwP9bRWysONanwRs/f83625E=;
        b=EHph9ofTvDHNDUiWoC5q9QoZazOKIE+mXp9G1Q9LoaK7hTUOsGe1QfgVmaB6QaQ156
         ZccPgs6KyZBUT1o59d0GhKl7DgNP/4YlkN/FnhSe8eAq01AWKyP/rHsSNTmazugBg0K7
         PBRJfTN/vvaISoQeKAuH7pXHMc3KwH1+rc111zvK4ftR+FhGR5DSGlO7l8JTvwgU/xKC
         5EJFxhxzvXVp7MkQLmOvbRrdaXaboGsYfP7/Itbtc5gLFRn5xTCY/O8ZAvdXmm1QtIap
         W6wO/7JcHTvRKu9rDQMkrvxlB4R2dhgCifcMTkonhn4kHw+c94PWLCEX5IGpSsR2jBc/
         FJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739972179; x=1740576979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HSsnV19R3euCe7A+mmLLwP9bRWysONanwRs/f83625E=;
        b=RflRrUdlzLEAYFjHlbQHGnVdSE79TAPWd4CUhuUCivBPVkNwtBnamio48f0UG4h9Na
         WkGRbFjQuG3czAItUlgpLHCpJ+8FWe4N1WMrYGSrDYjSMP5obmyiz78nBW3l5oH+zp8B
         cA7bojwC5YiysS46aaOnELX1tsWZV9ozzeFEPQzs1499Ndg8wujoWJ4ZQIkHZ4ADVEZ8
         D+NERPB9/MLcF/lGsQoJf2QJbflQ1FMpj6fgmxg4V3GwkP5nQ6Ti7qT7wl3B0zwuM+uD
         GznHG4fA5kBeaD9NUGehhOJKAYTHO4IOz/IgEmRyUAXjdL1hYE+qjy270jITIq9zsNmQ
         h86g==
X-Forwarded-Encrypted: i=1; AJvYcCVlAafVaG1XGUPmAWa6lJ3ra7QzrZF2OhXG0F+GAxMEZwcHmadcKY3GEbTh9ZTtLGZHpCNqKDG6Cx96@vger.kernel.org, AJvYcCX1gtrW92ZbAYc5xAOA9FG0Fj+TCoa9D91VdsKk0Tow036k0HEzWKVJlQ2Oiv7KUjTk0HF/O7NkozRj6APy@vger.kernel.org, AJvYcCX6AR8svjcZ73abSVUYw/2fs+9Y2EpfGIA0AIBmFaxw0pv04L+5Ifb2D+2fgM9NI6E58ehKted8QPoi@vger.kernel.org, AJvYcCXnBJrzY47FM7s6JYFUyqDenI8UGvf3udMzLOUiu9dKX4vcGyxLISy97iFjj2badw1J2llMdvy61qToygH2MiH+jA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztFpwL6O4+LO3DopVY7a0X3YusvLDS923Jxs6SwGGwrAznEbw+
	x8WOlSDzdyHl6hrAMfOhpERB44e514dpagreT3i2hLUvglClSlH8MlEzhg==
X-Gm-Gg: ASbGncvI10lddu6egYTdZJBK7aideVykkyh1U5YIEAeJpIWUfx84LRzl7NjeEPX+e5M
	TxCdkH+ILU5N1whDfCZVmWf8+ehEORSAD++AmMCglemYT0wJeU+RhqWg6A78DjWtql3uPDfreEv
	uFIIpOPJ9ZlMPYruum4ThRMgrk4IQwBV55qWpbmZu1UBO4fZ1Vkw8AsV0b0e6TSERsG7gYSiTo/
	oZ3Pyh/j/lHaoCLv2AvU4wD18NZ9GX20+0ZbwhJgWlOpm7OGqls6Nw2NC21tNqYJZtkLzuyi6Md
	V48qT4cqVP8NxA0PCviZPb5lDnJnUULyCqVEAiLIG+AyMeCun1bTKPLvtp1xmNY20vqZpIKT
X-Google-Smtp-Source: AGHT+IECONOuwKIydK//bT3AGqnTWMmCdF2rv/KJJHD8I1175BIY8l67zp+r+qNFr42gMLhOkEmBmA==
X-Received: by 2002:a05:651c:2222:b0:308:f4cc:951b with SMTP id 38308e7fff4ca-30a45035a2fmr14037951fa.23.1739972178597;
        Wed, 19 Feb 2025 05:36:18 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a258703c9sm13795701fa.7.2025.02.19.05.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 05:36:16 -0800 (PST)
Message-ID: <f1c6078e-39bf-499f-b7ab-17526b3e60a9@gmail.com>
Date: Wed, 19 Feb 2025 15:36:14 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] iio: adc: rzg2l_adc: Use adc-helpers
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <cover.1739967040.git.mazziesaccount@gmail.com>
 <25c5d22f6f0cbd1355eee2e9d9103c3ee71cebdc.1739967040.git.mazziesaccount@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <25c5d22f6f0cbd1355eee2e9d9103c3ee71cebdc.1739967040.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/02/2025 14:31, Matti Vaittinen wrote:
> The new devm_iio_adc_device_alloc_chaninfo() -helper is intended to help
> drivers avoid open-coding the for_each_node -loop for getting the
> channel IDs. The helper provides standard way to detect the ADC channel
> nodes (by the node name), and a standard way to convert the "reg",
> "diff-channels", "single-channel" and the "common-mode-channel" to
> channel identification numbers used in the struct iio_chan_spec.
> Furthermore, the helper checks the ID is in range of 0 ... num-channels.
> 
> The original driver treated all found child nodes as channel nodes. The
> new helper requires channel nodes to be named channel[@N]. This should
> help avoid problems with devices which may contain also other but ADC
> child nodes. Quick grep from arch/* with the rzg2l_adc's compatible
> string didn't reveal any in-tree .dts with channel nodes named
> othervice. Also, same grep shows all the .dts seem to have channel IDs
> between 0..num of channels.
> 
> Use the new helper.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> Revision history:
> v2 => v3:
>   - New patch
> 
> I picked the rzg2l_adc in this series because it has a straightforward
> approach for populating the struct iio_chan_spec. Only other member
> in the stuct besides the .channel, which can't use a 'template' -data,
> is the .datasheet_name. This makes the rzg2l_adc well suited for example
> user of this new helper. I hope this patch helps to evaluate whether these
> helpers are worth the hassle.
> 
> The change is compile tested only!! Testing before applying is highly
> appreciated (as always!).
> ---
>   drivers/iio/adc/rzg2l_adc.c | 41 ++++++++++++++++++-------------------
>   1 file changed, 20 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index cd3a7e46ea53..3e1c74019785 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -11,6 +11,7 @@

...

>   
> +static const struct iio_chan_spec rzg2l_adc_chan_template = {
> +	.type = IIO_VOLTAGE,

I just rebased this to v6.14-rc3 and noticed the channel type can no 
longer come from the template. There are also some other minor changes. 
I'll fix this in v4 if this same approach is kept.

> +	.indexed = 1,
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +};
> +

Yours,
	-- Matti

