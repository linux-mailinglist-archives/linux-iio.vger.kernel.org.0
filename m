Return-Path: <linux-iio+bounces-18852-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79628AA10CF
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 17:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 683BF7A8A99
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 15:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7653622E3E2;
	Tue, 29 Apr 2025 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RL5tXUZe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E8222E3F0
	for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 15:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941524; cv=none; b=BDczgXZe8LK/8SBL4X+UZLwVB4qiDGApUEm5zMvuqIk69sCR0cgVtpIoMGnfv072aib8ur2mwmXPn0WphOU61ixZejmppkroAH7Jrd1Kb6ZdIBbXNgJuYDXHqC7qPf4iio3vVceLUXKymeLSBvAe0tWdBLgLnFD7FuPqzJ6D7bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941524; c=relaxed/simple;
	bh=NICjiPJUIs0TwUvIzdHa/agEllYI7LIs1dcUUmUkXOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WAzXLZYYoSO221PQSTgc7m3MLelUAo+FTLvqBuGeguvpKFaOJDaGCX8Ofm4bBrIQfPgU5mpJ6N+OTqVgg1QHE4dc5pUJO5eZenEk6tGblr043+iAB+NHQkA8j2dDIPnUTEX7GYVCPHF/4m8QLaBttlgoCrL/ocQyKKinFRL8pCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RL5tXUZe; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3fefbbc7dd4so3961839b6e.2
        for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 08:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745941521; x=1746546321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZVI4uRenWtRE9k6AMZ5CKSYUXQJsbDv7xP2rtKsYSZ0=;
        b=RL5tXUZeGh9ES4n3fIB1O92769n0Kdaio0fevNW1BHL/2tKu2PqF/iGbkmLFCr/2Rd
         0y+R+pHj01oBlnFKY0SZmsgqwZgB9NlvZDuZ4wuqR+tZHDopB2UyLUzf9OkWZE477mwc
         OYgjVEl44V9jfMmU0LuD1WmMF6LemJ1wwe12pXmtED87hbhlOO/axf4o+XEfH+UwPZ+I
         J4VLzFrcjVjzgQaFRysWltb1vzm5rGtgFWK/y83hIbNUREAE2AWF8Xdy1NTYbV0wyhN7
         NYxjPaz+uCcYN6vo9owE91WK2bq9GWkYLRBJFaGx6uIRXvcvvgE+WPfg2acg/0Wh6F3q
         Bx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745941521; x=1746546321;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVI4uRenWtRE9k6AMZ5CKSYUXQJsbDv7xP2rtKsYSZ0=;
        b=CULQ5NfFK5PyLgkiGWBR4yg+ZJsBzoOT2gT+tpcYF9k/2lvEoWKRfCESxfX2A3vaEq
         pMStjLwISgs8FeUWUdZ0lh7Tw6c19cQ20bniHncWWuVEXgOPSl1nzAmy9DGSFz6NEN1O
         7naeFCREMm9VkWyquiC2a2tqieCNhkb/DMeYKWwwT4Ry5IL17m5CpB9G0TTR8eCGMBUE
         9+toYh+jxGvJzoeQ1TfrLbHt2wtsfRhJjlQYFA688mif1HtUpOU7uaUB9dyjEmKsYV5U
         xtS5a7BCNW5AO9j0b5cLl5WTzJKeSzCzt2W0epsLETV95JIBjnc1J+hoS1ZPfP8RuGXg
         Hfzw==
X-Forwarded-Encrypted: i=1; AJvYcCXu14HrDmZKRFG3JgBQOGyn/bdI8FkgPjA70LYb1zxqHCeZgxNNUqmgHsZjJrcSs70u2q7KG2gP14U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY3sVH84NqCcv0xWruUHq+NtCuQGF989J9kZFJHZP1jEuq3CtR
	GLKt3so7gUK3MV/f3s1uwIo/FfN2Rw7JLedWOB2i8r2ntvKQTclfBbiM/jcRya8=
X-Gm-Gg: ASbGncudtBOJBp2trSBJEuov+nfvj4aia5bna39zbBJw0LUSp6XNVBC3HWd3UgZCh5M
	U7w54soHvwqtex+FzvfFDjAjr05KWbIl+HXRVTB6AvQUjPaKxa6cuWlc2u05dspC0In5ZdcTesT
	F0Cdbf4nmvmK32ql4zzixMFn56iOoVCYct/uXogSk43IoDdo6eD1NtHeCRWUlZb+E/zHRNfCqZb
	mzSBRSczSduaxuUiq07ZUwd0Q0JIU6ab92FocXMLMBF7+aYqHYx2e4Gcr1iMNvjLrD/j1DQeLVH
	N1Eebdaa76Vn2q+t1YE9NXxL1QzDK28tyqWNpN9+6LFCIND7+khKPGpQZVzUc0GooiNZsW1vaR4
	GClDJiJWGMq2Wy2HEW+YTEbErtQx3
X-Google-Smtp-Source: AGHT+IGXSHw2bSB9WA8P9Abnr/+5jrvPGzvFtKJFd69HO6Pyrm2MursqlV+n9MiODBPVv86NHerUoA==
X-Received: by 2002:a05:6808:10f:b0:3f9:43dd:a054 with SMTP id 5614622812f47-401fd8159d1mr6756006b6e.34.1745941521257;
        Tue, 29 Apr 2025 08:45:21 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:dc17:157d:e8b2:3ad6? ([2600:8803:e7e4:1d00:dc17:157d:e8b2:3ad6])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-60687013faesm276388eaf.39.2025.04.29.08.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 08:45:20 -0700 (PDT)
Message-ID: <1b0e9003-7322-46fa-b2ba-518a142616dc@baylibre.com>
Date: Tue, 29 Apr 2025 10:45:20 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] dt-bindings: iio: adc: Add adi,ad4052
To: Jorge Marques <gastmaier@gmail.com>
Cc: Jorge Marques <jorge.marques@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
 <20250422-iio-driver-ad4052-v2-3-638af47e9eb3@analog.com>
 <88a326e7-3910-4e02-b4ba-7afe06402871@baylibre.com>
 <hvexchm2ozsto5s2o6n5j2z3odrkbcamgmg67umd4aehwzmgie@dvtx6anioasq>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <hvexchm2ozsto5s2o6n5j2z3odrkbcamgmg67umd4aehwzmgie@dvtx6anioasq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/29/25 8:48 AM, Jorge Marques wrote:
> Hi David, 
> 
> I didn't went through your's and Jonathan's ad4052.c review yet,
> but for the trigger-source-cells I need to dig deeper and make
> considerable changes to the driver, as well as hardware tests.
> My idea was to have a less customizable driver, but I get that it is
> more interesting to make it user-definable.

We don't need to make the driver support all possibilities, but the devicetree
needs to be as complete as possible since it can't be as easily changed in the
future.

...

>>
>> Assuming the diagram at [1] is correct, for SPI offload use, we are missing:
>>
>>   #trigger-source-cells:
>>     const: 2
>>     description: |
>>       Output pins used as trigger source.
>>
>>       Cell 0 defines which pin:
>>       * 0 = GP0
>>       * 1 = GP1
>>
>>       Cell 1 defines the event:
>>       * 0 = Data ready
>>       * 1 = Min threshold
>>       * 2 = Max threshold
>>       * 3 = Either threshold
>>       * 4 = Device ready
>>       * 5 = Device enable
>>       * 6 = Chop control
>>
>> Bonus points for adding a header with macros for the arbitrary event values.
> 
> In the sense of describing the device and not what the driver does, I
> believe the proper mapping would be:
> 
>   Cell 1 defines the event:
>   * 0 = Disabled
>   * 1 = Data ready
>   * 2 = Min threshold
>   * 3 = Max threshold
>   * 4 = Either threshold
>   * 5 = CHOP control
>   * 6 = Device enable
>   * 7 = Device ready (only GP1)
> 
> I will investigate further this.
> 
>>

0 = Disabled doesn't make sense to me. One would just not wire up a
trigger-source in that case.

