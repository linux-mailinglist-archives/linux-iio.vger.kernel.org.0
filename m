Return-Path: <linux-iio+bounces-21014-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655BDAEC305
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 01:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96B314A6A12
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 23:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B083291157;
	Fri, 27 Jun 2025 23:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hYANnAIu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25147202C50
	for <linux-iio@vger.kernel.org>; Fri, 27 Jun 2025 23:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751067387; cv=none; b=IZE5VphgSev5+C3/7MHT8Wpz5NqUPUksvuKDQdYbv7ccKedpwGPiefXuB4b0h1Q+JJ5TwSsdNnl6N3yIhhGHNv/od8VVknWqKmTN2bu8gW7LA4u8HxjEIm+LyR69L0/5Zr/mlFE985KoVuaNHN03lWKxITJDrccRKMM9p+mg5ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751067387; c=relaxed/simple;
	bh=ecxNgGLJ0ceg2mw32I8PwtVd+Bs6zCvgfvPYi442IWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QrOpuiqg+fFCUrAjdRZymF88/ewRCOuoRqRfQkZ8SwMUbOEMn6yQ0JdzkUe/CwgjABzsU79titcKnW5IVtHkCuVpRqA5eI458u+OWxJDJheCfOqRmBDusf3nSypolCj/6wrbo2878i5kHzKMeiXjgIeoudPrhpA9VgLomd4xzbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hYANnAIu; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2db2f23f174so1765621fac.2
        for <linux-iio@vger.kernel.org>; Fri, 27 Jun 2025 16:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751067384; x=1751672184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KS5+5awS+3+wXbArsBYmZlO0Z0GYxJERA5jSGiTS01k=;
        b=hYANnAIu/ShF1cngobKyZ3e/Ql0pBBO2g6du8ulNviUq/sgS+uDkdRDYNiYj8IqZes
         mkvOtUXrfVKtd1o+PqTHdkAKy2HNz0JHWqezB7qmDiwFCK7Sg6ypcirW1DJVUz3envoM
         jLcIgqcPrIih6rbSmkQg/5jWGus1J6Ak2f2s3mC6YS5trLBhrccSCB9z2k/YKmut3kia
         Hr/oTsEXBS2Gouz2/g+yGlafrE/hAgRhNDqMeJiUPVxTieYb1j/7XLnMiA0lpmpSnflB
         5UUuijkv1Zr8GMVKw8WecsdvkrGtIh0LbioLkJnlgupqPPt/2+xf+gG8bSGzvoju93en
         ax+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751067384; x=1751672184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KS5+5awS+3+wXbArsBYmZlO0Z0GYxJERA5jSGiTS01k=;
        b=F9NVkCa7Otq2x+gnShZ04ocCgAfvYT2nn4Q7Mofr+DTWpn2A7tdJT8n6DUYWmsbc76
         +MgrjVm8NutypBb8VW+0n6apEKYctpRxITwGH64oBSjOCARQzn6PhDolCO9BELvZZysU
         9bG8qj5tIEyEQXmWiW3UfmlzxQcY8Cw9lOAgxR+9nVkWwO8aQkAH//AxTuicvuSjpxPn
         X77KmkDK+RP9TyEu7gcyo+BmjA+S4M1K9mXhtlYulW13TvZYW+6hum/XqSIUuezWui75
         RAP99AI/ZK209usFjm7V5etm0/7scdMhH6yFHQJzOQw0tIvlp/Vp1osfMY8TY0L4U4Mg
         BNPA==
X-Forwarded-Encrypted: i=1; AJvYcCVT7j5fFYGEqkqUoXZJqOOlp47GqiA3GBPsRbTQjb2Jtb5yoXwcd0Cfj3GBYN7qDejLkm3RvZ2M5jc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW2utB6Vx8rjD7btdUSWK8sNHlLTcHmVMzIrPuzrMY/YaUxH4v
	vB46zivUfBc8y7PixmyHVlNG2SAMS0j1YamqC7ORanpPb0ZZDBuht4xuojdOYT+jfts=
X-Gm-Gg: ASbGncuuvFYhDEeEC/LnXmCm1UZOmQXVmwi3aslurIvIngtLcZHxfeRo7t9sR9jXE9n
	hpiCmaGjTquX11uTBrnrXzZBZWr1XpKuOemhVlXK0mdWpCuL4ZEl+wZJYoM0OFGzuouWxT5ted3
	o8/iNjNPRiVlisIiRh9RDF5cBBFIKYJGLh9Z4taXPk3cJ348yqFVeVU4dAoLrWzAnV06XffLZtm
	85bgrY41bvM6KG0Xxl18T/Yll05NXjPikxNZkYHV1u2gvKGwMNXQRP+gQtQ9/IWy15K5dg01Gwu
	M+eOLYtGsmql+9oC5zOR40ht7TjkmzZAY/gTawuDkZMwI04VrcVRxGwdOo8D+5SMSTHriH0BIwK
	d3boEXBltE2aval2Mlw4EHUB2Ja+d1l3nY7lO
X-Google-Smtp-Source: AGHT+IEssFT0wZJYugWiw6Jgk1s5LByepHYNeiyjZJg6Qq+SSxEoPL/QLwyMcPPeh+MamQqKsKqBzg==
X-Received: by 2002:a05:6870:7905:b0:2ea:841f:773c with SMTP id 586e51a60fabf-2efed759ab7mr3742580fac.35.1751067384200;
        Fri, 27 Jun 2025 16:36:24 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:1715:453e:e133:7d6? ([2600:8803:e7e4:1d00:1715:453e:e133:7d6])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2efd4ef29absm1128704fac.14.2025.06.27.16.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 16:36:23 -0700 (PDT)
Message-ID: <c1ea7287-a1a8-4d77-97fd-f341d2412005@baylibre.com>
Date: Fri, 27 Jun 2025 18:36:21 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] iio: adc: ad_sigma_delta: use BITS_TO_BYTES() macro
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org
References: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com>
 <20250620-iio-adc-ad7173-add-spi-offload-support-v1-3-0766f6297430@baylibre.com>
 <aFj6Dv1kKFe9ijvr@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aFj6Dv1kKFe9ijvr@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/25 1:54 AM, Andy Shevchenko wrote:
> On Fri, Jun 20, 2025 at 05:20:09PM -0500, David Lechner wrote:
>> Use the BITS_TO_BYTES() macro instead of dividing by 8 to convert bits
>> to bytes.
>>
>> This makes it more obvious what unit conversion is taking place.
>>
>> In once instance, we also avoid the temporary assignment to a variable
>> as it was confusing that reg_size was being used with two different
>> units (bits and bytes).
> 
> ...
> 
>> -	size = DIV_ROUND_UP(reset_length, 8);
>> +	size = BITS_TO_BYTES(reset_length);
>>  	buf = kcalloc(size, sizeof(*buf), GFP_KERNEL);
>>  	if (!buf)
>>  		return -ENOMEM;
> 
> Hmm... On the rough glance this sounds like some kind of bitmap
> and hence bitmap_zalloc() (and other bitmap APIs), but I am not
> sure.
> 

I looked at it, but I don't think it is worth changing. It is
really counting clock cycles, not bits.

