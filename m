Return-Path: <linux-iio+bounces-18717-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2DBA9DD98
	for <lists+linux-iio@lfdr.de>; Sun, 27 Apr 2025 00:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B605217E079
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 22:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA5F1BEF7E;
	Sat, 26 Apr 2025 22:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wcEQW+X0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5A6200127
	for <linux-iio@vger.kernel.org>; Sat, 26 Apr 2025 22:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745707508; cv=none; b=eSMedYo45M+WVD5uUABrptjfRlF5c6vfwX3ZZhAFae7fAjSz8h9VOEorWllnShQU5D7ims9RRENLJSXL7BuVzFY9wFx+rn/YV8LfTVhLR27OGxfHKF0dSQV14XE5UBSCZb52QKvVJvpELrZvV6pX5BO6IE1nLg7xN5A/viJw3Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745707508; c=relaxed/simple;
	bh=HclsCHX3HZsdp7zwi/DFMXgxd59RhS+xuS2yD/7/K7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qqc3L6n9NAc89epjObo1X2VH8dpDte4zhBQQKXJdHqL0R/reRUogKPgIyms/HN7mLaqwbhyAXNivwVIN1sYahX7AlS4Kt6s75cBd/40dIC79i4nMO42PNIvun2d5dhQCfEgwz2deFvftCGm87GGFOPqlngZiJtVbni1Sj9dsa6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wcEQW+X0; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6066c02cd92so1439eaf.2
        for <linux-iio@vger.kernel.org>; Sat, 26 Apr 2025 15:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745707505; x=1746312305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qwcUemuBqfTlPEEr1NWNN3RuE7oJcYf6SWcx828cxO8=;
        b=wcEQW+X09pwfiDxaDCnktFvGz6sHyWMKEVDhWhbmIi6P071t+gNgKWLM1HfyHdGvbR
         AxQZexwcwZu74emSx2be+DLH+fLnvnIfo2Rg0Eb8FqPnSAkdjo4/9RSpyfNgyjIV+7rJ
         guzO0MYQR3F5viEhISkrT15hOAq3rZ3ZLGi7tI4k0n6ObYYPL+63EUpBcivtOmXRHv3Y
         EHje7aiL4UbC1pz19/Oqxi4BMtYrkV01EEhMN52HJXIdWTELnKoseyy8BNDBLcud3LnW
         nYuLBAgNJvhr9XuDUxithQ5qXihvt2QW9sn1B8oqsRiKTEskGTy9S54L4fkVfuyyZttY
         liiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745707505; x=1746312305;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qwcUemuBqfTlPEEr1NWNN3RuE7oJcYf6SWcx828cxO8=;
        b=G9NS6XgeKLn6y5n39TB2VkVzwiLWM/vUKleyZoA7pMWkWQpq2yO0VY/14zX2tksCi4
         xOv3fbimoKiE4st+lNLVM2QqOSdO8q8pSd2wZ3OCanma/ncTuxG6OMpHaTubqU2cRGiT
         FO0Vc5KLCPI6LTp4/f5AzXFyMlZgY8I9si6m4Tdu6Id0X13e90dbm1F3bGJrM+oBJroy
         w3iK6h/CPFJkq392v92StJwcDBZouzL2UKVTD4iK0ces56xuwy85cQRrce+wXU6Rc39K
         ZHzsaNM5vcNi+VDyAWloujeGbqd7nRkyFDpCfXivFIzEQ1h2GvMIvAwSEEhFzh9ad401
         p2Yw==
X-Forwarded-Encrypted: i=1; AJvYcCXmSEaEl4QNwMaFM/Hrz+bBpYwLY2WMw7kGQVRQBQlGo8i+l0tyV07JD8QXRhtThLPzz4/A2dewFS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6aq8L76+10iGVpdhRQ7Cdjgyt7pUBeA9APAdDLM5EvNGVZJCM
	EzATSqLb9vKJeUs5DN3TQw0TDmkSZIydHXWQBWrdzmkNPHO1WV+vn5y0UMmaExOhWJp22rXfuX/
	W
X-Gm-Gg: ASbGncuvn5a3QMXM66EIdjXGZXMZNdMm0lxBLNH/6G6z3tS25tWKqCJwE91MAnqGiog
	zOlAdqCJJHlXAQxC1PgAb6nUN3JTiXj41yqnsAFDmjZi7NUgmZ2UlwA2qKY8T6ZCRED7eqBM7Xo
	BFAEfKdVG9xZLWkBLKdE+Z4jdxzMExSe8xMM20TEdKuEhHrFWXtw2hy5Kr6UAzoOqCSes84R7Dq
	OpnuiY2z1YMC9XVFPJiCr0R/DRU8mGOfTMwwYPOxJE88dYAYDndzr427J4ogr9reYmI3QupCR2o
	Umbpoo4EuiX7eRZOeGhWHqlQZHNxH+OpWviK/eIomXWsx10ZuInsxF50snd9eS1TvQOEcvNKKF8
	Y4qLErsycF4XMHmF4Qg==
X-Google-Smtp-Source: AGHT+IFMpqMDcXejTTk+tlxMwyA7VG93Vje/R8vi0xdzIwwdgKGdmtlFvNJLYgocXCOKMvE6S+lSSQ==
X-Received: by 2002:a4a:e84c:0:b0:604:5e57:80ab with SMTP id 006d021491bc7-606527b299cmr3850433eaf.0.1745707505264;
        Sat, 26 Apr 2025 15:45:05 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:96ff:7f79:37f3:5c67? ([2600:8803:e7e4:1d00:96ff:7f79:37f3:5c67])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-606468a16a7sm1303347eaf.22.2025.04.26.15.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Apr 2025 15:45:03 -0700 (PDT)
Message-ID: <f5de85b7-489c-4a81-a111-fbe7a893694c@baylibre.com>
Date: Sat, 26 Apr 2025 17:45:02 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad7173: fix compiling without gpiolib
To: Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Guillaume Ranquet <granquet@baylibre.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20250422-iio-adc-ad7173-fix-compile-without-gpiolib-v1-1-295f2c990754@baylibre.com>
 <CAHp75VfHkKC81EinO+oN1b0=NRkwmNBLPky=HkrvPJCmt4njDQ@mail.gmail.com>
 <20250426161814.1bbf7f82@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250426161814.1bbf7f82@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/26/25 10:18 AM, Jonathan Cameron wrote:
> On Wed, 23 Apr 2025 00:03:38 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
>> On Tue, Apr 22, 2025 at 11:12 PM David Lechner <dlechner@baylibre.com> wrote:
>>>

...

>>> Not related to the fix, but I also question the use of the regmap here.
>>> This is one of the ad_sigma_delta drivers that does funny things with
>>> the SPI bus, like keeping it locked during the entire time a buffer is
>>> enabled. So, if someone tried to use a GPIO during a buffered read, the
>>> GPIO call could block (waiting for the SPI bus mutex) until the buffer
>>> is disabled, which could be an indefinitely long time. And to make it
>>> even worse, this is not an interruptible wait, so the GPIO consumer
>>> would effectively be deadlocked.  
>>
>> I would say either the entire buffer mode is broken (in software), or
>> hardware is broken and GPIO shouldn't be supported at all if the
>> buffer mode is enabled. I think the best solution here is to remove
>> the GPIO chip before enabling buffered mode. If GPIO is in use, fail
>> the buffer mode.
> I'd kind of assume that anyone using these GPIOs is doing it in a fashion
> related closely to the ADC itself.
> 
> Can we make any other use fail more cleanly? 
> 
> J
>>
> 

My inclination would be to implement it like [1] where we use iio_claim_direct()
to return -EBUSY during buffered reads to avoid the deadlock-like possibility
instead of using the gpio regmap.

[1]: https://lore.kernel.org/linux-iio/2a789531fda5031c135fc207a547f2c3f00a13ea.1744325346.git.Jonathan.Santos@analog.com/

