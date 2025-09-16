Return-Path: <linux-iio+bounces-24135-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A76CB59023
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 10:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C45D3BD634
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 08:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0662E613B;
	Tue, 16 Sep 2025 08:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjNyl9ex"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A552E3B11
	for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 08:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758010450; cv=none; b=i27t8/ouWCyjVq0ssgHjwXCOUqmNUOskw2Ct9OabXWsGCkMZCF3i2xfie9cjvapvnwJCYFdttfoXnCtLg/n2WYI3F1ChSaq+H59O4pZ/nVgWmxTeX3gfXe8gJewILY6H+YAvIMFgZTLsTYWA4D1COw5eD8P7QznUuNvPHSxbsK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758010450; c=relaxed/simple;
	bh=OkRn3wi3vVLwlm/wDKzvfBew8i5CbraIcmJaOETj/3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PCp9AWoFge+feH02dSOfH2vTqaw4HPiEXzMQaZon/4qQ4XV60qs8pjYCrpfDyLA6ffp8UbwSdhgEYLIGuJtsESjPfH9o/nbBKDnfUF61ee7Gl0dqTsIlT/4XRUxW+EFX1YftdcDy3cUzIsgQYErdcjYqmaaeW52tsax4fhRPUqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjNyl9ex; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-352e19bd72fso26696101fa.3
        for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 01:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758010447; x=1758615247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jM7l65ARIgofwE06qZfm8EVMSCpb/5Bo5xaYN803ql8=;
        b=QjNyl9exinOXW2DeNKK2qEYSQo658maKc2gFnzV5hAynCMuw//y5r1Yp2TBHvlxmwn
         V1znYPL5cITxV1yJFBq5G8ZyVgKgXk5AI8JgYjCcdpyH2YinFjDx2XI+/W7ise6W6BOx
         KWz/+MevUNH02LbBC2mM5dXIM+C9eAIbh+Hg7rScT6z31a2vWgZLSvo6Eip2hO4Nwdux
         TE68w30keWAB2cFkrAjUkf2CRmPZJJ+FUDbHhCryO3OZn+0Kq7Ompg07WC3I3Br2oLPT
         fmyOY5Og15HbYur3DirQsNhvYRovbPj1YVAHUF5qEGU79+3C9yG/eixc0pWANoLJRNrY
         7hUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758010447; x=1758615247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jM7l65ARIgofwE06qZfm8EVMSCpb/5Bo5xaYN803ql8=;
        b=istsxC8om7a0qtkv08BckFx3Ah6uZCpNcL4/eCdvhJuQwTavBtQwQDnWISF2timx6Y
         GcKna3DLJnaGHhJ1iArdwsGqTVRRJHG3fegTtBpg/P9p1hfu22rl11noE4D3SD/xxMjO
         XHt4wwwN4Fj9ACofCDaoeJ9EHq8s5GJfdsxfqyF/yttdh6zPRDECosmGLUZBUDjs7OCg
         /8jboA0U/6Hg7uEKZEsjity3YMTul/JkDLPT+mKEalQbbSj0JNf6MpnZq01fmiaMSmST
         Y1MLaSWJtS2qNcLw0/PR63g726CL21pel5vUWD8SVM1ARYFLh+F1fDRgmljdnkHltmgb
         gDWw==
X-Forwarded-Encrypted: i=1; AJvYcCUmwIFTP7cFJUT2fy8b7JF9D1GMDsecHimCkAFRUIbGhmmgE/LLA2TT8s+ZGP0lMuYtNh0+XoVd6Ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsRZ+OewTr68aoEYbP3LlDwgz+59ZO8vlA/Y1x7ap961AJ1jvy
	tTqG7coWCa80wOzFnj8eZYpUs8RiVnzBdiuNoRvGHUnVpfNnoqWc+trl
X-Gm-Gg: ASbGncvfQgiwtSOC/4Kky3ZrclPnKthqynyhvuabkZv0FAS040NDGpEBusZX+z3fWyU
	676gPCfKXYYVaAlKqCSEqEjbMYxWrg9BL8KJT3i/mfdjTpzLhOzcR+elqoLwtZAl9pBcI2eXK4A
	Wv8ztZaxFIFj3TBM/0ew6q2B+ltqfA72GwnzLhy2Ksiy9cp3F4ao2zcUFr49POwFG8aAGg5splI
	bPkzzplmuWr7/11gfMLC5Klb3dLhyFo6sv7MPFRxT7NVCVlY0gd3JF5JOjRu3MqVGwKXagUZvoz
	bMWN5Q5c7f+w2xwr/hIHdSvyFRsp434uCxWSlkbOwVwY4tbTrp13o+XLhxxHvewUQ/LH+a3UOfX
	oOtwTZijbRnG6VzDp3iL8Uwsddt9q3TB0ExMmJrkQaNr+Ipx75uFi8a/wICEY5ujEGggm83dKDU
	hUCDif
X-Google-Smtp-Source: AGHT+IEJVE0MZfILx6PWce4nwraMO2Nm8lxid/SAnbgN3RqRMuFMYn2p9OaYKJPnb6fEuEss67LUxw==
X-Received: by 2002:a2e:a016:0:20b0:336:7e31:6708 with SMTP id 38308e7fff4ca-351403eccb1mr36499181fa.37.1758010446711;
        Tue, 16 Sep 2025 01:14:06 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f163f495esm31002351fa.24.2025.09.16.01.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 01:14:06 -0700 (PDT)
Message-ID: <14d3dc56-c6cf-464a-9a57-2a7a6afe8af9@gmail.com>
Date: Tue, 16 Sep 2025 11:14:05 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20250915-bd79112-v5-0-a74e011a0560@gmail.com>
 <20250915-bd79112-v5-2-a74e011a0560@gmail.com>
 <aMge0jYwYCiY72Yb@smile.fi.intel.com> <20250915211321.47865d3d@jic23-huawei>
 <c1d21e3c-b0a3-40a5-b693-a38673f8bf53@gmail.com>
 <20250916090206.02f601be@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250916090206.02f601be@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/09/2025 11:02, Jonathan Cameron wrote:
> On Tue, 16 Sep 2025 07:52:07 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> On 15/09/2025 23:13, Jonathan Cameron wrote:
>>> On Mon, 15 Sep 2025 17:12:34 +0300
>>> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>>>    
>>>> On Mon, Sep 15, 2025 at 10:12:43AM +0300, Matti Vaittinen wrote:

>>> --- a/drivers/iio/adc/rohm-bd79112.c
>>> +++ b/drivers/iio/adc/rohm-bd79112.c
>>> @@ -454,12 +454,18 @@ static int bd79112_probe(struct spi_device *spi)
>>>           data->read_xfer[1].rx_buf = &data->read_rx;
>>>           data->read_xfer[1].len = sizeof(data->read_rx);
>>>           spi_message_init_with_transfers(&data->read_msg, data->read_xfer, 2);
>>> -       devm_spi_optimize_message(dev, spi, &data->read_msg);
>>> +       ret = devm_spi_optimize_message(dev, spi, &data->read_msg);
>>> +       if (ret < 0)
>>> +               return dev_err_probe(dev, ret,
>>> +                                    "Failed to optimize SPI read message\n");
>>>      
>>
>> I am not really sure under what conditions the
>> devm_spi_optimize_message() could fail. It might be enough to print a
>> warning and proceed, but I don't think returning is a problem either.
> 
> No. Don't proceed on an unexpected failure whatever it is.  That's
> storing up problems that may surface in a weird way later that is much
> harder to debug.

Just a generic note, not disagreeing in this case.

I have had similar discussions before - and I have been on the both 
sides of the table. Hence, I don't have as strong stance on this as you. 
On some situations it is better to just try proceeding as aborting the 
operation brings no sane corrective actions but just reduces a device 
unusable.

On the other hand, as you say, usually bailing out loud and early is the 
best way to pinpoint the problem and get things fixed.

I still think that logging a warning should be a decent hint for someone 
doing the debugging.

Well, as I said, returning here is Ok for me - thanks for taking care of 
it! :)

Yours,
	-- Matti

