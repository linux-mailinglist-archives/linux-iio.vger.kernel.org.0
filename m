Return-Path: <linux-iio+bounces-27642-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F94D1441B
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 18:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCC9B300646E
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 17:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4ED36B047;
	Mon, 12 Jan 2026 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yLFHmJ63"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5049917B505
	for <linux-iio@vger.kernel.org>; Mon, 12 Jan 2026 17:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768237827; cv=none; b=EQnQ8pAp0tJfnyUmwIedPjDsH81mNXejPOTelDXKCUm38vygS1aPIgcaNpCNpvpwsoNd354IuqnCYNYoPrevZ/1yOLFkmvtaGo0CzlfBGJB+WrWp2Z2APAwvP07nbPTu+IKx1NngNGpwSgek2XSA3g8i1CoIAm1R2HYr6/kyRkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768237827; c=relaxed/simple;
	bh=OAH5naFNjOllYduWvwQD0Wi97hw4lHAw0rHxC1KY20c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=id7huNQA9reVoL5vrO8mDgNriKN32HvGttjUqAkMyU69dlcpXT7BvoFFwwAVHlrD/AaNRzhcCOvcY/LwXHZA+8+WoG3J2Tlqak6+AK7qggXCjCLgniRy3B95STz4QO8mJM4VemJnspXuPdzgJVEDQIQgNMQxD12d/7nIwYJ3kHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yLFHmJ63; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7c7533dbd87so5165970a34.2
        for <linux-iio@vger.kernel.org>; Mon, 12 Jan 2026 09:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768237824; x=1768842624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m9/AFf01u7lcoTbEksrXqqgn2N/dpSWjRoYjLFZ9u+U=;
        b=yLFHmJ63uszX4HY8EJJL5iMkcJKuunD1+Sw63Ku0zRMWJD6Lo7EY32lab6N/jZBOK9
         dSEcwZrEU3Q5nAxlgdCbmojByYanaHjqFoDyNXywxXYEzZhm2KGz41ztfyIOygcXirwe
         H0IqrjAFF5RRA6oP5nDIKzewNkZvWvjiySUX1VYibq6DerUgOZmNz+R6x8cvUcZrk33d
         ACzPHN61jigcXLIzD4X08FR0pw3AwzaJpL/zF8WhIuXcIPlSSPZGYKmiC+nhhg+BXEDG
         Zc6YAms/yOzmBhkyCCce4/UO8/eCvEsxfv7hHJ0BM0kzCIp79S5qBovShXGSJfvtW2X2
         akFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768237824; x=1768842624;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m9/AFf01u7lcoTbEksrXqqgn2N/dpSWjRoYjLFZ9u+U=;
        b=fCGlNW94eitpfyccEQyvxbORI7jOkziSdfN94wPWtMRHDBk+hx57EPeJRGe16l2giy
         xRg2ohdCyq41BMufiVPg7XkLOX4NutlNlP5FYeUOE1M9RXaDfay8lwSlc+AS2tssxFdF
         zonbwYMxkfaPCV5zQ3GdrYe2J/9eAoMkWBc8yR3daVlYIikBdGY/kSTEsB0e+umcE0sB
         t8ZXCFffP/dfAPr2xW3T+alNpf09x10RmBhJxOftrsRZeo1yoM87/HkcesZNon+171i3
         mn4Pbq+YR5HHGE69qZqVOJ7mKrYF4KcBdnYXwu48f8Bao7K6oI0hyo4gHEViW80qN+vs
         MILA==
X-Forwarded-Encrypted: i=1; AJvYcCU7hR3L1kHE0ZPxCx0TzCa1C9D3/A6LoBXfZO04R91qYdwCal1TxDID3GDlpf04AvpuwwuSvBre5Ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPZp/9lrZV6CTLiFPA0dD1OpNnVlsMOilUdkU4FaywL4ao+glN
	M9nWgLTH35fAkIQkK67i44GCXAa40KlIPQnJXEReyp2VHXpgPb2pmvMYd3oVEtXsnW0=
X-Gm-Gg: AY/fxX4DWjVS6CERT1kKPtMrQi2bjQB5VCp98/sGgwfl6vP5fJPbr7ax16THmr3V+w4
	97C43kN72Ajy3MHzauBJ7ieX7ZYvBj/MGpcz2kbwqSJpljcys0XMeucqMzcqlBLh0aQacuEEfwd
	VJbx1ySZNKseHZknApQj3GrwxbONufYnOQMBnNkPgsazMrfxH8wz6yy1uGCAR8fiEOoNu5N+Ik7
	489tuxIyliEwxZt5F0X6n4DGaFw1BZIesZdIpJk3eh8ZjdduVcxscIu77tNBy+V+uA+BS+fYdhT
	9eqmciYoXk0EPb3fUmFRorrqAmmTUeslqGBlbaCXsH2vZvAqehN/P1J4MRq4tuBGdRufd7bY3d0
	Bp9DaBaDlh3hnydjHkjL+VVDwgFiY0tb8SistpJqfuaxBp+03TASfBultjI8gfv+2y4LSdmvwNK
	+yqSy+vSWnghYyj1ZXoUVkbejlazlRqGaUjmT6mcxPGvOkFaUVItT/y5+wtYI0BL6rUyW5gv0=
X-Google-Smtp-Source: AGHT+IERGDoUKExncVjlW46GPrn6YhEvSLbilPx7CfLMbFAf04otsZ0YAgDPpRk+Jn6HZpG/4t2pKg==
X-Received: by 2002:a05:6808:3507:b0:450:cc23:98c6 with SMTP id 5614622812f47-45a6bedeee2mr9476465b6e.56.1768237824219;
        Mon, 12 Jan 2026 09:10:24 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:6b4b:49b3:cce5:b58f? ([2600:8803:e7e4:500:6b4b:49b3:cce5:b58f])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e183cd4sm8162627b6e.1.2026.01.12.09.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 09:10:23 -0800 (PST)
Message-ID: <19e3980b-043a-40bc-9944-3ff2ef389ab7@baylibre.com>
Date: Mon, 12 Jan 2026 11:10:22 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] spi: add multi_lane_mode field to struct
 spi_transfer
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
 <20251219-spi-add-multi-bus-support-v4-4-145dc5204cd8@baylibre.com>
 <aU_3v5smP1AnsHCG@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aU_3v5smP1AnsHCG@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/27/25 9:14 AM, Andy Shevchenko wrote:
> On Fri, Dec 19, 2025 at 03:32:12PM -0600, David Lechner wrote:
>> Add a new multi_lane_mode field to struct spi_transfer to allow
>> peripherals that support multiple SPI lanes to be used with a single
>> SPI controller.
>>
>> This requires both the peripheral and the controller to have multiple
>> serializers connected to separate data lanes. It could also be used with
>> a single controller and multiple peripherals that are functioning as a
>> single logical device (similar to parallel memories).
> 
> ...
> 
>>  	unsigned	cs_change:1;
>>  	unsigned	tx_nbits:4;
>>  	unsigned	rx_nbits:4;
>> +
>> +#define SPI_MULTI_LANE_MODE_SINGLE	0 /* only use single lane */
>> +#define SPI_MULTI_LANE_MODE_STRIPE	1 /* one data word per lane */
>> +#define SPI_MULTI_LANE_MODE_MIRROR	2 /* same word sent on all lanes */
>> +	unsigned	multi_lane_mode: 2;
>> +
>>  	unsigned	timestamped:1;
> 
> Btw, have you checked the layout of these bitfields? Are they all in one 32-bit
> word or split? Dunno if `pahole` handles them, never actually paid attention
> before.
> 

There are only 14 bits used so far.


