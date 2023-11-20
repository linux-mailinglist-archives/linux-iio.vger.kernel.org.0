Return-Path: <linux-iio+bounces-191-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FB77F17EF
	for <lists+linux-iio@lfdr.de>; Mon, 20 Nov 2023 16:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534A51F22B38
	for <lists+linux-iio@lfdr.de>; Mon, 20 Nov 2023 15:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1741DDC0;
	Mon, 20 Nov 2023 15:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ispji2Yt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889D7E3;
	Mon, 20 Nov 2023 07:55:17 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507a0907896so6400834e87.2;
        Mon, 20 Nov 2023 07:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700495716; x=1701100516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bmiqxT90YVFrOlPlqhujIZF2WAbgKxIymaxdbEcrsTk=;
        b=Ispji2YtUWGY0fMQjhsXzUezOL18fprLv3zds3N0sqq53L6PV001ePiNvPozuMbWNv
         +kpun5IkFDW4zQwGcGGsxKayWxyVEAau4rlo1reA0SKk2zBSxwzxT0yNvIrfOBZxLtMg
         3ynH8IMVxJN/PRDBJgjfJlTHic1aUfbo7vHMP17vzxiDPM2tJngkCGUbDhbigJJvgkjT
         Iy9/PHdbotLEa8imkZhho3OAqorzMZqYYhE57/mea/FS4rTo426S0aP6Ts54yfrboNFg
         wrcMmZHQj9/BvCzrF9LviVHAxqX/4o6ha3kAR9ZCl5H/92pwi4J3a9/pETk6sxM75nWy
         oYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700495716; x=1701100516;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bmiqxT90YVFrOlPlqhujIZF2WAbgKxIymaxdbEcrsTk=;
        b=Chez6Byj8/5ido35unxZqxugWotLRkI0rBwmeg3pNBLjWu78BRmLihckSrFoRyGoAx
         UJWMi0AUOQS5iEDKGm8KPu70Itq8BJCiTH5ElBqYzWKXvz7uDa6T0p0SWO8K7rYgXUNX
         /q7H2b6ruWulNzx3rfCSor2RaU+CTiblFtv34MnOLgGjX5OrZXEqQBfdT+3LU2THNXnO
         /PDeJDmqrPPhV7M9SUyOQhWL9fcoHe75HP/FKm6SwHfxS8LqZJyK54Qxh2ezDFPUBBlk
         D7Ks/Y8DWjTfhcNm3evYBZ4gJY8zhdnjaSsCYjfAIwQvfFNhAOVZ8yIZxo8DxMJfui7Z
         +jtw==
X-Gm-Message-State: AOJu0YybfyPdaz5rp6rTlXrs195BfTGvWaMLaoUulIyVyEy1m+yPLxDO
	ZWrsioGud9QjCNpu78t6fiwZua28kn8qfu0xiwY=
X-Google-Smtp-Source: AGHT+IEGvqQr6cTOB2FCQA0WzT+rjb0MBN6QsjipE6JCfOsNlEFDX+m//iKUwZnUmucKMpMXjJ3kug==
X-Received: by 2002:a19:5514:0:b0:509:4c8a:525d with SMTP id n20-20020a195514000000b005094c8a525dmr5251624lfe.35.1700495715385;
        Mon, 20 Nov 2023 07:55:15 -0800 (PST)
Received: from [172.25.98.130] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id a2-20020adffb82000000b0032dba85ea1bsm11629737wrr.75.2023.11.20.07.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 07:55:14 -0800 (PST)
Message-ID: <5cf3824f-6375-4c76-86ff-c5389ddf4196@gmail.com>
Date: Mon, 20 Nov 2023 17:55:12 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] iio: adc: ad7173: add AD7173 driver
Content-Language: en-US
To: Andy Shevchenko <andy@kernel.org>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Walle <michael@walle.cc>,
 Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu <chiaen_wu@richtek.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
 Mike Looijmans <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231116134655.21052-1-user@HYB-hhAwRlzzMZb>
 <20231116134655.21052-2-user@HYB-hhAwRlzzMZb>
 <ZVtYeWZmcDZ_SMPo@smile.fi.intel.com>
From: Ceclan Dumitru <mitrutzceclan@gmail.com>
In-Reply-To: <ZVtYeWZmcDZ_SMPo@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/20/23 15:00, Andy Shevchenko wrote:
> On Thu, Nov 16, 2023 at 03:46:55PM +0200, mitrutzceclan wrote:
>> +struct ad7173_channel_config {
>> +	bool live;
>> +	u8 cfg_slot;
>> +	/* Following fields are used to compare equality. Bipolar must be first */
>> +	bool bipolar;
>> +	bool input_buf;
>> +	u8 odr;
>> +	u8 ref_sel;
> 
> If you group better by types, it might save a few bytes on the architectures /
> compilers where bool != byte.
>
Grouping by type will result in not being able to use memcmp() for
comparing configs. But then there is the issue that I was under the
assumption that bool=byte. If that is not the case, the config equality
check might be comparing padding bytes.

In this case what do you suggest:
- using the packed attribute
- using only u8
- drop memcmp, manually compare fields

...

>> +	cmp_size = sizeof(*cfg) - offset;
> 
> sizeof_field() from the above mentioned header?

This computes the size of multiple fields, following cfg_slot. Better to
group the fields that need to be compared into another struct then use
sizeof_field()?

...

> 
>> +	return vref / (MICRO/MILLI);
> 
> What does the denominator mean and why you can't simply use MILL?
>

Original vref values are in micro, I considered that it was adequate to
represent the conversion from MICRO to MILLI as a fraction.

>> +		*val = st->info->sinc5_data_rates[reg] / (MICRO/MILLI);
>> +		*val2 = (st->info->sinc5_data_rates[reg] % MILLI) * (MICRO/MILLI);
> 
> Same Q about denominator.
> 
Here, a misunderstanding on my part of a suggestion from Jonathan in V2,
will be removed.

