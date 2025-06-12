Return-Path: <linux-iio+bounces-20561-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 981A2AD7682
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 17:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F160188444A
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 15:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BFC299AB4;
	Thu, 12 Jun 2025 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="o1LMGC+1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B07C299A9A
	for <linux-iio@vger.kernel.org>; Thu, 12 Jun 2025 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742402; cv=none; b=ky/2vQ83kvVNqYxUUIc419cp3BopIh6dgZ08RFU1BpCtfFk87ohA8CYxavY5QPxFAYIMawZfpNhrjhssM3k3rR38ME6/3UnfBYa0d1Ml3KHaoP0O1G3i+EtCIeBTawq+3ywKjcjit2TBd2i3gyoK2c2cJILdEyOR2JsXluvRqmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742402; c=relaxed/simple;
	bh=KSDbdk9DePrgVQr7SrVRa+XwJpeTep3QaQZxdE4b/Sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZCNaR15Opgr0ufpXJXw3aY2rESw1ZPL8SET0zTDxuJV8pnz77ok+ulpf3D2HLii+XGytYZfPLXazCVPIzz1I2EVl//B97hvUt3iUs5RLHe74Yf7imDGlSfpeUllQOI79F+uLxTJd34l7Ed6bUT7jOAciDiIP44d2Xs3kJ8T9XLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=o1LMGC+1; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-60634f82c77so338214eaf.1
        for <linux-iio@vger.kernel.org>; Thu, 12 Jun 2025 08:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749742400; x=1750347200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=occ8UAPK7Y3/XcZHfeUG+9OKXI0GcqA1Hf8ywNuCjso=;
        b=o1LMGC+17cYneAw3/CZqU7ilTUtiP6lObIv0LwdP/YcWyioDtkNGyiz9yRhXiOIWB1
         ShBs2bT/UwptK/yGMmVZmB94rOlwNIrRl8pnXNA6HScSbUGh3wMScXQRD4fT829jSJsH
         8U+/VVUCLQG3NzuzxVDaYzxSHTLBeaw70k1VShr9XuLCh4GL8+RCNw/Ol7qG3Z4MDQKp
         fBBDe++2zgf4I4mdXRI/iKDq7q4x/Ju9CJS0XzUv5qcCbV/L0H1C8ycPU0I+WU2oeIT7
         x4VxyvCb9egbjoO7uOmnulc3GC/ZotZz7kSpTGV0Cc5cvd/eFMVRvDhTcL9FGADoU1TC
         2yQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749742400; x=1750347200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=occ8UAPK7Y3/XcZHfeUG+9OKXI0GcqA1Hf8ywNuCjso=;
        b=mX81GAqFOOs2Y1w6WUYvLp9zlF6gL5wsVR/H8rI/nkgjpZSWxpgnLwLBC6l1QvNICQ
         vhMDnedKpZ7uDLClkl69sLGySHeaCczyeOzgT8LMpMAWpbKWu5Se09220kdjCIR80GYC
         2XwNZlhQ5qinF0D6Hgj35gyH0S0j43KKZOUdPqJcyHjilN+5Vu9C6MEZvVctNkJuFzuP
         BxDjBThs0zMTUJmAzdZ3l1Jln0BB4xXj4vlsOZrwmXOdLcu9UXBGg36U54aUeflEZoE4
         8xW5OpOqprPgH3jsxhKC2tnJsACp9WWh7reZQT07hLGmJgeqm5LQLEfCE4bjv7/Si0Qw
         OH9A==
X-Forwarded-Encrypted: i=1; AJvYcCXzXHWijXlD2r1aA+kqdEvN2UPvyIN/m2Zl7Pdah4dsmJn5fPUlr1napwVba3skOidAchLaWtoHaxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfX/jXgGXa2Ojlpu182Y17lJnKO4004QrnQfhhgY8ghVVV5Ht8
	YNEsY1WE5UQERShrl2mXJJ8Y/qSg7tyB5SqZW5+V7ikLBD1JF9XYBIMM4N0NMND+WJ4=
X-Gm-Gg: ASbGncsyRhyUbJsKYTFrdwO94r5jy2tMHyWj+nmOxf7ppwYUihaKslz7k0BdaYJNWtI
	730+s3wmXKdJo47EXQCSeEKl9E3/6DM5ANNyGuPi3jIum9F1Qizt/bVdTB+P6ospN7zndVDsmgq
	8ZR9UgIDJRKz47ARo4i3QfHXPgwBgt1AO6Dp9s/2lLQBtR0ixW9eDvtOzr2Fb8JFHJPrpl7Rdcd
	PCsgFuivc0hGHYnNgjvV8OzjMnMNVJ6YLI1Jdq0LdpsPj6g+MDGpC7byrlPFd4e42GhMwIGx7Ps
	pNtGe2wN6zkjY/r5Lui5vDSnawmqyZJS9EoKtMivrEeqB/yMIgLiN98Lu0CayeG9Ln+FGCOqd4Z
	wtxiz7nvjmzjidA18kBukw4rMzcsaoncOTTysKdI=
X-Google-Smtp-Source: AGHT+IEFXx/HRFaoYx3mDaAcYVHQpIxU0X9BzHa2+b5gg1r4MtPFkD976gxUBECCS4LDkC/56qstdw==
X-Received: by 2002:a05:6871:7bc3:b0:2bd:456c:92a with SMTP id 586e51a60fabf-2eab40ab59emr2388538fac.10.1749742399978;
        Thu, 12 Jun 2025 08:33:19 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4753:719f:673f:547c? ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2eab891b264sm328859fac.20.2025.06.12.08.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 08:33:19 -0700 (PDT)
Message-ID: <5dd8d6ec-8c16-4c7d-aa47-b66d076a83e6@baylibre.com>
Date: Thu, 12 Jun 2025 10:33:17 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] iio: amplifiers: ada4250: use dev_err_probe()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250611-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v3-0-bf85ddea79f2@baylibre.com>
 <20250611-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v3-5-bf85ddea79f2@baylibre.com>
 <aErQojKzbI6al1vn@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aErQojKzbI6al1vn@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/25 8:05 AM, Andy Shevchenko wrote:
> On Wed, Jun 11, 2025 at 04:33:05PM -0500, David Lechner wrote:
>> Use dev_err_probe() when returning an error in the probe function.
> 
> ...
> 
>>  	mutex_init(&st->lock);
> 
> Side note. Switch to devm?

Yup, missed that.

> 
> ...
> 
>>  	ret = ada4250_init(st);
> 
> Is this used only in ->probe() stage? If so, please also move to
> dev_err_probe() there.

After all of the other changes, there was nothing left to convert
to dev_err_probe() there.

> 
>> -	if (ret) {
>> -		dev_err(&spi->dev, "ADA4250 init failed\n");
>> -		return ret;
>> -	}
>> +	if (ret)
>> +		return dev_err_probe(&spi->dev, ret, "ADA4250 init failed\n");
>>  
>>  	return devm_iio_device_register(&spi->dev, indio_dev);
> 


