Return-Path: <linux-iio+bounces-18345-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C07A944F9
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 20:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40DE53BDABA
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 18:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5421C1DC994;
	Sat, 19 Apr 2025 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZgcrQhGi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FA813D8B1
	for <linux-iio@vger.kernel.org>; Sat, 19 Apr 2025 18:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745086051; cv=none; b=OHyiTfnmGzyFc0/w/HfYAzRiL5YElWekkUQtUlUIFyhxqmujGEb3P+SF9pylFHnVNZcsrG8wjNrrByKP4DKwdgHxNVRpPbzBRfW+pSVqx0GifoP5DYndQVrqyu8//fp8Xdg61XzQBmeotIwHwaoaB3YdGeO7WalG4pmRvmKP3g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745086051; c=relaxed/simple;
	bh=mP5+rKQ//YiqEGI4ZVevEA6QIHwTTRq4AkSxn4CvI/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p7jU2J/xgYPF/0HfSYjJ9BkKrE79bJSQYmq65q5X6WTWDfpaeRuVz1iOxut0IkPuXaeAOnE6Pfy0L5dpRFlUzRwWrptg9hUhwIHRE5VPqEvQA1qYwzLrUePjTnJZN131id/XvC+bjQv0vwPy3p47tA6NUMfl8r/LfWbYzBiptVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZgcrQhGi; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2c77a5747e0so1513374fac.2
        for <linux-iio@vger.kernel.org>; Sat, 19 Apr 2025 11:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745086048; x=1745690848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mOy/RgKZeiDJr92IQwJqEIiI04eWEFdwqapntf9V/54=;
        b=ZgcrQhGi9wen0Tn8Tu7dzpwWrkYnG6Q1khmpz0RQOS35pFwhOdMwhEVfENTrCCSbpb
         1kYYH1dXV90odOhGMJSdNT1aqzOUYlKvqo29Nq9uhkrC4Ppw5uVLfPR/ZcxsD/Bg9JVV
         1IVa3DIJCXLcmoVjqOszdLh2Md+cAftu7n5XKXayhJHcABtpoYbLDNLVCiIUUVGh3+4I
         07Oqhrf1/maITrSkdNfH/CtWSe+atphykpPgx53jf1SvoNh6VeX1uLR5g9vYDfAoR51C
         P0cFYGP1G+jn6xkCjXbqHrIqhoxdQzZQW5VU2LPNeRuFrqHv9uiz/HRW6CEUwG8S+jss
         Zikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745086048; x=1745690848;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mOy/RgKZeiDJr92IQwJqEIiI04eWEFdwqapntf9V/54=;
        b=P0xThJWP9hAfwQQLesy9fAv7LhRy9y+m05QQQ5gZJRpNj2zlQ5cr2kdItOSnuEQcz3
         yiAUt7Zhi8Szc6sxJy7bDf39pflQcjbpDRblL8Eegx/hau5hj8AQQBCicoq+n9LNmppA
         YDbzR/uIGXy/HclW7rMe1/FPzovbo5G1xaquXljJlAV4VtAgmwGLlCHsHWDYnGYqHai4
         bP/c766V0RjFGwBxToH0uh7hZYH9cZM6Y6jEb/EfITrlXQ+v9WDwt4cugzlR0OpLbwRu
         7b4k3ErRs/9aGbf3Ew/dc4hkwIPtlS6P56xjScqtk5gnyWYhEiUQ/o7/s986ZwYE9h5H
         1trw==
X-Forwarded-Encrypted: i=1; AJvYcCXbQwWbx5dpnvMMFsr+WFa47MzE4Pgrd1Ha9O++ojP8SEtb+xHBOrJRVQEPudw+gvX3FZYH6VXXKLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHprqlby3A24KhTkjEFmJznzjXxNODkktfa05IRsriwbUVpIkx
	Z6jhs+Sy6Cqhfjtzl9neT/NbfaOuL7JtNUYXc2wYw8stfi9u0xnUE1qgXKZhZ4E=
X-Gm-Gg: ASbGnctxsV+BAwAYllbBBMRfg3T5hblHmXBJkIKbxTLRJeb2F4Qso7ZDZ4mlgEm/ZSX
	zvZMUkVqOv8NPiMYcTigqUdxwiPAGVgfFsDkKonTTKCuI2PTPvwE2xAcS9+ryajcLrQozTKws9g
	vaShaxAmJI8HvQR2aGMo+V0Eajhj2URBcu45yXJ2cu+Ea1HGc3x5K45wtmHcajJ7NpF6OVtU3z7
	mm4XTihn0wI4pIi4KEfNv9SZXJEUsNJrcnvyKqPC/guTo7TmouLLsRly5GKF30TpwpgUTWFofdZ
	iYxLzN1D6tQeKe04D/bS0ld4CYN5Th1/4JJrsZHkdgACBYpAUueZHhXCRVJTqzqVkqvRA1YcgdQ
	a+h1erZRAKkJq
X-Google-Smtp-Source: AGHT+IHYpbS/V3qjLpxNNZPZ2TVAz88J/SkYj+47cWck9twaFcMzBjcrKwck6VsnVU/ew4dc1f/dnA==
X-Received: by 2002:a05:6871:bd07:b0:2d5:750f:2f52 with SMTP id 586e51a60fabf-2d5750fce4dmr244370fac.7.1745086048086;
        Sat, 19 Apr 2025 11:07:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:79a:b8ae:edee:ec5? ([2600:8803:e7e4:1d00:79a:b8ae:edee:ec5])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d5212c95ebsm1040778fac.5.2025.04.19.11.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Apr 2025 11:07:26 -0700 (PDT)
Message-ID: <9cdc7053-ae22-4ad5-801c-46df7398ebf9@baylibre.com>
Date: Sat, 19 Apr 2025 13:07:25 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: amplifiers: ada4250: use DMA-safe memory for
 regmap_bulk_read()
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250418-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v1-1-7e7bd6dad423@baylibre.com>
 <CAHp75Vdxdbqu6qkbuo5y4jADOH_h9Re6m8icSj3Je4hnVsha0g@mail.gmail.com>
 <ed5c4b46-0b3f-4278-ba8e-6f6977f18429@baylibre.com>
 <aAO7Lw13xrEGmZLL@smile.fi.intel.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <aAO7Lw13xrEGmZLL@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/19/25 10:03 AM, Andy Shevchenko wrote:
> On Fri, Apr 18, 2025 at 02:09:04PM -0500, David Lechner wrote:
>> On 4/18/25 1:58 PM, Andy Shevchenko wrote:
>>> пʼятниця, 18 квітня 2025 р. David Lechner <dlechner@baylibre.com <mailto:dlechner@baylibre.com>> пише:
>>>
>>>     Use DMA-safe memory instead of stack-allocated memory for the call to
>>>     regmap_bulk_read() in the ada4250_init() function as this could be used
>>>     directly by a SPI controller.
>>>
>>> Sorry, but can you elaborate more on this? If driver doesn’t override the
>>> callbacks the regmap SPI uses spi_write_then_read() which is supposed to be
>>> dma safe. 
>>
>> Ah, I didn't dig that far down. Will send a new patch that just cleans up the
>> unnecessary alignment and unaligned call.
> 
> But do you have a real life issue with that? Coincidentally we discussed
> similar case in another driver with colleague of mine, and he insists that it
> might be still broken (somewhere).
> 

Some drivers that use regmap with SPI implement their own read and write
callbacks if the default one doesn't work, so maybe something like that?

