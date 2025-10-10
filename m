Return-Path: <linux-iio+bounces-24913-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 116CCBCDF09
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 18:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFC6D4E790D
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 16:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B30E2FBE0F;
	Fri, 10 Oct 2025 16:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k7VErcXi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067EA2F90F0
	for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760113108; cv=none; b=uZqPJqd6cp5W1FvOjD1xyN0ETw5WTq66lVkMGbFvMhhl9DizYCxErZCF1QeMcPHtGjbuP4dgTJyXLd4eadk7wWlTsM+k79PaCMzjzIKEdFiqzDXWFfWlU86W6EC77MpzyIyq/788tVMQljbEOpcAn4sJlFwZCo/d9yG1x7IpIHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760113108; c=relaxed/simple;
	bh=FdYPXGm9deiD/Trs9cMfHlp7XbwPhfQIT9v/Wdt5nis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GlNF2Q+Hi404quq0lMHe9pzty+MZ0Q1g+aOZ5t7LDUcc63vEqgejNJPeGagfqkS6XiG55cbBzuW0ohBnWIGhjzL8A0QJFKlyc28ECvLLNnUjg858H/3g7oexGVadUUUeXx7+2a9sQWJNKRpk26hKudCDTmhhtf/B+YBhN3PAtLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=k7VErcXi; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-30cce892b7dso1189487fac.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 09:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760113105; x=1760717905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9w68CQXC1xPR3gkxyDZirmm/itUJmtRYjrTWc5to35A=;
        b=k7VErcXiTSdSzA6bGBoScVNFENhUJPpJdaonLVk1Ps7NKthqAs3DTmZDCzckX/9dZ9
         gSHcKUynJ/G9OXQmWDE7pyKmvpPSJqihJsM6bEWkHAV3hCWq9kDE0ZuEWrjRK+PvEDxo
         zRqc/M/biXlD9FKLj2nHqIbxYAq7pjIt+AmLyk9U/hpPxKB2QyoD1Qfni+cmwNTd7KJe
         BiCdQ1DXKh6/smn0eWVowYxolCtYC6ZNHRL6nPWLp9dwWO6/6U+inw2iO7WuG7zmKhsP
         2x5ohFXFx53uczpwjTAXhfKiNfhC0atvYktW4UhPheAvh8cNVv9RG/7PmtMvsdncyTi7
         ZvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760113105; x=1760717905;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9w68CQXC1xPR3gkxyDZirmm/itUJmtRYjrTWc5to35A=;
        b=Mqxgp9JzuOc9xlWp9LVOFaCCWNFkfdgjHCntuPL77R1MOHV5wdnkysCJesYH8kvI/1
         yZXHT9FBqxqV+1K5uSg+GzPw6NTm35YSQBjanBJhRDK00e8EN5UH6+kM6zu/XgaapkpF
         YlaUVAaQducVle+/HlXc77Y2LrjR9kzOKQ4crgwZTxhWI/GthsbgEjnuACNfC4D3jIwI
         sw7XgFtiLqAcnBzLXOoiV5cTv0BJhaN6DmcpLvyAdlRTYXtnRl/uoEFmKrb3XezcUeDK
         m6C90OYdVmfqegeKq6+BQGXOcLuDSFT3S/UkFRQdNvP2fzomHt9MiL+zzlnqRucueMi1
         6vKA==
X-Forwarded-Encrypted: i=1; AJvYcCVS8isQYH9JDbB1m7rh8MDOUHvszhutTThHWsHvlTa31JgKA8VZwiilThyF89Em5E+8uRsDRi/pPwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj7Vn3tIujgHkPmunoSW/SFdYMXnhL21t9jlnH+P5YnW6/6wUu
	vVbFS/hzNlrcsyy0FAL6072PrvU9KIdwpAc0NWf+IfhujAahATx+6OUHIVrs/YsQ6Is=
X-Gm-Gg: ASbGnctPuU2PwPSv8sOFDKJFROVkM5l5iY8DpsH43qROk9bSVaXFvVQ7cz9+HxRxqKo
	3Cxebg2rrMdPjwdWKZvgEVSWEHCJCUqT7/CD2nHEgHpZXbDmZEHO/CaP2Nk2AtB3gMYwKZUwjDw
	x2e1DSGOyv7G+QB35HrZvAV8BblgUtcx+bSiJHc3P1spIPWVuxx31R30PjvqzxFeX2bkuTipZCy
	uYjamiD4uJR85x0tH8oXYHO0geDDQiTV5TIHgQreV18Xf5RXTavkE8HLqkimJLokVf0071RB9Xs
	G3lQ1OegUg5HwU7vkz9qkbA+Q3TMKgC/KoFqJQuqb0nxTf1PQXYPArCFwsiZi0OYrCZuCnqZ9Ip
	m50R/Aeb9fxA+zsr9rH/AZQSesvXOmfJSJFlmIdXvgD+ZQEX5tY20IVTNFJnAkne9ovZn38nuQG
	HG1YWKh9YrOOKQ38w=
X-Google-Smtp-Source: AGHT+IHd0omg/rlvWPFBEqlcSVQAWZIDB8yoaKyD9jCTVYWmDrXVdGmrtHcE+pAoTAHuCLm4ZKiTag==
X-Received: by 2002:a05:6871:6d12:b0:31d:7326:c3a7 with SMTP id 586e51a60fabf-3c0f9e6cf08mr5691630fac.41.1760113104781;
        Fri, 10 Oct 2025 09:18:24 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6d3b:e3bd:4210:32e2? ([2600:8803:e7e4:500:6d3b:e3bd:4210:32e2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3c8c8ae1de8sm1007500fac.4.2025.10.10.09.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 09:18:24 -0700 (PDT)
Message-ID: <576b582e-7388-4ee4-9a4c-4f7e04fc3fda@baylibre.com>
Date: Fri, 10 Oct 2025 11:18:22 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] iio: adc: ad4030: Add SPI offload support
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, ukleinek@kernel.org, michael.hennerich@analog.com,
 nuno.sa@analog.com, eblanc@baylibre.com, andy@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
 marcelo.schmitt1@gmail.com, Trevor Gamblin <tgamblin@baylibre.com>,
 Axel Haslam <ahaslam@baylibre.com>
References: <cover.1759929814.git.marcelo.schmitt@analog.com>
 <2bde211f1bc730ee147c9540b88339a93b2983e6.1759929814.git.marcelo.schmitt@analog.com>
 <a86007ab148f9556af032f5ba61991a74a5641c0.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <a86007ab148f9556af032f5ba61991a74a5641c0.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/10/25 6:19 AM, Nuno Sá wrote:
> On Wed, 2025-10-08 at 10:51 -0300, Marcelo Schmitt wrote:
>> AD4030 and similar ADCs can capture data at sample rates up to 2 mega
>> samples per second (MSPS). Not all SPI controllers are able to achieve such
>> high throughputs and even when the controller is fast enough to run
>> transfers at the required speed, it may be costly to the CPU to handle
>> transfer data at such high sample rates. Add SPI offload support for AD4030
>> and similar ADCs to enable data capture at maximum sample rates.
>>
>> Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
>> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
>> Co-developed-by: Axel Haslam <ahaslam@baylibre.com>
>> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
>> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
>> ---
>> Change log v3 -> v4
>> - Applied code adjustments suggested to SPI offload patch.
>> - Only select SPI_OFFLOAD_TRIGGER_PWM if (SPI_OFFLOAD && PWM).
>>
>>  drivers/iio/adc/Kconfig  |   3 +
>>  drivers/iio/adc/ad4030.c | 504 +++++++++++++++++++++++++++++++++++----
>>  2 files changed, 465 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 58a14e6833f6..1ed091b6731a 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -62,7 +62,10 @@ config AD4030
>>  	depends on GPIOLIB
>>  	select REGMAP
>>  	select IIO_BUFFER
>> +	select IIO_BUFFER_DMA
>> +	select IIO_BUFFER_DMAENGINE
>>  	select IIO_TRIGGERED_BUFFER
>> +	select SPI_OFFLOAD_TRIGGER_PWM if (SPI_OFFLOAD && PWM)
> 
> Two things as I mentioned in [1]:
> 
> 1) Wouldn't 'imply SPI_OFFLOAD_TRIGGER_PWM' accomplish the same?
> 2) Don't we also need stubs for spi/offload/consumer.h?

It doesn't hurt to enable SPI offload support even if no controller
supports it, so I would prefer that drivers that use it just select
SPI_OFFLOAD.

> 
> [1]: https://lore.kernel.org/linux-pwm/2e82eaf275b5c8df768c8b842167c3562991e50c.camel@gmail.com/T/#t
> - Nuno Sá
>  

