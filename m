Return-Path: <linux-iio+bounces-24360-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0146AB9370F
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 00:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E618E1906775
	for <lists+linux-iio@lfdr.de>; Mon, 22 Sep 2025 22:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10688275AF0;
	Mon, 22 Sep 2025 22:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="by9vcJQe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1814F2C187
	for <linux-iio@vger.kernel.org>; Mon, 22 Sep 2025 22:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758579333; cv=none; b=PZa441CNWrC295/gpCfB2n/Uw9OmeV33zMpeZf7r84b8oaPmmVss9izT4BbN6Y+T+P4O7fdF2/8NJ2tKa+75glWwDNcBnpeDIeVaLH6bz5njEGH5ug9eY3r6XXSD7jqVrq5PHfRhs/YyM2rJqYejdHLU6gu9BgMDqMnPrA1KSoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758579333; c=relaxed/simple;
	bh=RzkyAiWGPIV6p+AvKmAXHMrRF6qrXdOWtTLyoFs77fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C1S/6ImTKMujGJ774sBoujVhDBN3acIyM394DbTktUOFQI+EiSn1fHsIpMcpwiMI7sTUKaNJdoy68xdac/D6Sz9BWsxES6u7QFHIJ3Q4heOchkoF40/Otfi0lwh5TjOVfOFGE+pnUZMOrv5LRrAchtQnMActxcW+KFzo8mLYcRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=by9vcJQe; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-30cce8c3afaso4563527fac.1
        for <linux-iio@vger.kernel.org>; Mon, 22 Sep 2025 15:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758579331; x=1759184131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3df8lNuWhvDC2rJQvD/ziJ2M1JBls7/FB1ABGRRG/BM=;
        b=by9vcJQeD6EPColGhUSB5oVuNQ6LxvyKFIFOtCrXS3hghVNVGMZBje/BSgC0SoCcdv
         2vEziLwRBaH99SuIKVGaSoSJC1LfTmGFleUKMidl2UjmhoXPspUkdhY97XBhskUpuv6X
         Wta1/0yOHyC9RIjbcYqTsXayHdelEWOObqGeVEfuIvD5/INnUe9KdHL88n3RHyfXolmJ
         /hRzd7C1MZTTuyWdkXhZBcZt1rmp0bo/g7PhIu2CC1EA+6PL3O/D1T3Ch4gYFUqlbql4
         5/GVHDUBgUMToILGL6tulvnJ08Tlah6No47KoR0SNlGFOKNV891wkX3XuX8tpyXjRXfY
         7zPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758579331; x=1759184131;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3df8lNuWhvDC2rJQvD/ziJ2M1JBls7/FB1ABGRRG/BM=;
        b=aq+qkew7ehUqHjs0nV4gfAeypuSZM5elQJZzPRM8OyO3/SOUf5XsUJlADDXzEHIX2k
         p20EtGKJXuOO0HJwnkI/c0mFLGVEjahzOyySJnBHxKesGPceT6iGQODAnEJrkx4Z433a
         HWJb2c+XyTiAW3EWXh3uEdD4Xwru5KzXX5I5oOJidiyk1x1f3ICFb6TWSqG9Hc9NNlGP
         nmmqFmPJ6MHRxHQEWEJY26XJnaajhQ/Ov95JxSpK+LlDAsnpE7jWk8gjdTDmtPI9+NzB
         LKHQohKjHo0lYB2sQ2j0LuK4F364SY1NuPVMM6BvQHl1EGxkR7HKm9vx6ObZn2FgSwBO
         Nd4A==
X-Gm-Message-State: AOJu0Yy+3zyn3k6kMFAw2pily/O5RKgjr9iFDe8oAEfjAJSGIepEbyqo
	Y3iRPLdj9b3d1OZ44aWa15eXeK3VZHI+5CCltvRhkAJ7bIEE5ttPVDrg79M5bPfd/es=
X-Gm-Gg: ASbGncvAZN6Dpe5DVm17DXakMUPVqmFK9V97jnSbilUncrhrOAFrPkrhddSGVkHd9Ck
	UiRkh4Pu9SNmzY7qirSiT5UW8trtCMJsIM6R2CzmF4Jp5oeYLX9aWX6vWf3PkCha17hgIMPLlG8
	nzPepWradAxf4OU8kGBVJcbgt4NY9chirMjPSMhxGPmrFTgbJWARBI45piKLCottbO5whKbi3k6
	l5PnyPTd/IqH/fBJzNEqjomYqbE1ERSqlDgtzvUFxGu9sTkEdpk7iJD1ulN4Ln5bQaFTiBVFHGf
	p1QL8/HmeMmJbjAvSzz5W99sfzyVTPfVD+iXes43PCkXblvjkL2/FmUcfSzH58SY1Y8GKh3tITE
	vVpniQqPaJWFP4Y+pGRyxO3X+Yke7LbWqlwaElSbDUpor1F3YzjlTwo4ECaNTsmkIGDtDXQG2aM
	s=
X-Google-Smtp-Source: AGHT+IFTQfgxCGrhqdxhdussfgDYYkEXHNBEZrXgWgIug9QWcQ3pADFUjI5JaX+cZ8bP6//iw+MOdg==
X-Received: by 2002:a05:6871:4b13:b0:319:625d:319f with SMTP id 586e51a60fabf-34c83b0869bmr247841fac.39.1758579331095;
        Mon, 22 Sep 2025 15:15:31 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:505f:96cd:1359:fff4? ([2600:8803:e7e4:1d00:505f:96cd:1359:fff4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-336e0fbe706sm8402073fac.0.2025.09.22.15.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 15:15:30 -0700 (PDT)
Message-ID: <3457c119-2f49-43a3-b96b-736b8f5de99b@baylibre.com>
Date: Mon, 22 Sep 2025 17:15:29 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: dac: adding support for Microchip MCP47FEB02
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Ariana Lazar <ariana.lazar@microchip.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250922-mcp47feb02-v1-0-06cb4acaa347@microchip.com>
 <20250922-mcp47feb02-v1-2-06cb4acaa347@microchip.com>
 <859d8472a8f9e8d28b890ad565f9d3ce11e162d5.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <859d8472a8f9e8d28b890ad565f9d3ce11e162d5.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/22/25 3:10 PM, Nuno Sá wrote:
> Hi Ariana,
> 
> Thanks for your patches. Some initial comments from me...
> 
> On Mon, 2025-09-22 at 14:30 +0300, Ariana Lazar wrote:

...

>> +static IIO_DEVICE_ATTR(store_eeprom, 0200, NULL, mcp47feb02_store_eeprom, 0);
>> +static struct attribute *mcp47feb02_attributes[] = {
>> +	&iio_dev_attr_store_eeprom.dev_attr.attr,
>> +	NULL,
>> +};
>> +
> 
> Not going to argue about the ABI for now but I don't think this is a standard one? So
> if acceptable you need an ABI doc.
> 
Here's a random idea. (I would wait for Jonathan to weigh in first before
assuming it is an acceptable idea though :-p)

The config registers are pretty much going to be a one-time deal. So those
could be written to only if they need it during probe.

For the voltage output registers, we could add extra out_voltageY channels
that are the power-on output state channels. So writing to out_voltageY_raw
wouldn't change any real output but would just be written to EEPROM. This
way these voltages could be controlled independently from the real outputs
and it uses existing ABI.

In any case, it would be interesting to hear more about how this chips are
actually used to better understand this EEPROM feature.


