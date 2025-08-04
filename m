Return-Path: <linux-iio+bounces-22248-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 862F7B19B32
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 07:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956201767F5
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 05:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6DC221703;
	Mon,  4 Aug 2025 05:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxDSAr5M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C05417555;
	Mon,  4 Aug 2025 05:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754287065; cv=none; b=LAyKU0A4XJG9KiUrP/GOjy03wVvLezFZIiJiUc29tvv38Vh0FAbbvcoyxgF+kS6rlItCsnpXcqbfr1ZCQy1b4ykRvIEuXm/dBwlCewSCyEnHmadkNMz7bTH5fW6ykEKOW4ZoLq6mHPahgDuN3Gi79oE/yGNf45cd7bL+hXStOHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754287065; c=relaxed/simple;
	bh=r9HxNTjuW+NwRa/vmUebhaKdeexaUpFJ21+bMvxLq5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JuusTwTRgNFH0Qbp2YK88Ux37Ewt6/Rm04laqbkD+YUTf9cIbGJC/6ZBem2T6ij6JWs9CbXojZO6A/yqSvgOXd4VbPjwO2D+2mPfYA3AdIGdbnM5UrLlP5grjedajHwg8+rIWvVjbYnEW2fl+vlROjCfpEgoFnJQjcs9SkJExXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxDSAr5M; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-332631e47afso11199191fa.0;
        Sun, 03 Aug 2025 22:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754287061; x=1754891861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DNeycstk/waeBDX6yIxRG1Q6VAGIwGEN5pZfK8U34gk=;
        b=RxDSAr5M2erU3l7PORRIkF5CEwprVTT7bgGlxE5oG36YX/a05BOg4r6a4wtj+l8hx4
         dTngQybVgAfonSLhsAiUdy4A75Xa31fz7Ts4yUG3YDyHBQ7lPn4RgoiSWQefq8RUbyAs
         5gqMvW4Ex1Y/FqpVwZLn9v1THfwWWAcxFLyuA2k+hj9ShHeiwJYofrFV5SiGf/QCW5mu
         QsvcpzQIMVmS3FBT4nnhb86wBd0hAM/hWp68QJO0pHjliIQwvwLXHHIFuQR1hspNumBu
         +O8eqe0JJQB8o2PS7r2vtoZ4ZXL67pIzqI8i1IvRLnOt4soXdMokbkFSoYB6KTZSQ487
         S+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754287061; x=1754891861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DNeycstk/waeBDX6yIxRG1Q6VAGIwGEN5pZfK8U34gk=;
        b=W3k7eksRfI6xWc61CMYEXWZcFTHZnAAxGflL1vtLwl/pysLvaUWfdhl4PtkLEJHyiZ
         eWV9nLbbPWh5ymf8hTVWtg5L0pPXTPYAnk/vjfY9Q+uxeZrRwvjFkg4rtwputIpy4Unu
         t2kFU0AvHSAuVjwwQEBtUd+g3NmRnikBjovqRJoXIaklWxaPRB6i0F6BZyl/VEW2J3py
         8YaU687aqqMTPYTSdCYEXcc9pEj16qkNJ7HuFAZeK9O07Yh+WsCqN+0qO9Q26TCb6een
         E1oAKgF6fQYUDp596gRZzM+C1ky6zAr3/NEOPAucaY6w4zZ5s5QvWOil1UTEffoBelhx
         QaMA==
X-Forwarded-Encrypted: i=1; AJvYcCVh8x60tb0jwVem9tOGcJI6W8SstGM7UUJCFBYM4X9uxcqDTN5EVafvrOw96oN2TWNS+NHxXPcl3GY=@vger.kernel.org, AJvYcCXfumJhttfq0gEBAzOYw8rcT0McolwRnAY3HGYlNP5u9uxZXYNFy5GTNgjQmVNiL1f52wPnr1et5tqnJTJZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yydj0Uoqv7LETWSlkaMYKAtKFq2CXa5zvGqdkZG3c7SQvj54zdJ
	vQ50/tMWhF1pp08kvhhgQ2Frs9vKkf7o0RSGzsFTBWVqlJhv9lhRgNDA
X-Gm-Gg: ASbGncv39vIrBFB4Sxu5xXUbiwszXMdKhFraKjCVQL+Uqp0b7O3n9DX6ziN8c37P/Gn
	daq43fEV+213yYFIfl0vAIke4MLdt9kLe40UOCT6qU1zS4+fqc2BnU6V+FUSM3gUpBAmVkRvCxa
	hnx6Qx1Lk7ku9z60Jtoq4BSHbxaxT4AuVQdH21rh8HHQoVVptP9ji6t6B886NTUnlVobP0GUH2d
	J/7RT/fmRYDTkxSgNf0q59zGVMWZ8PvL0el5NEwGPz0T2f9aW4QXwbRSNbFmBil0iRpWfou9qfZ
	IzT246W/iJ0R4ow7YfM2p9aibJ/VZC/PJjX0K9aNPGQisxF1Tal0GEvb4WDgpYMK0xELMbiKoa6
	7JOxZMGW7tPjnmJmxVDso+71VaqHjpNiOxBnddJCkMDYaKruZA1mlw1Leorp3nwn/ul+qLsLDzn
	arrdyVBravI5eRQg==
X-Google-Smtp-Source: AGHT+IFxrk3BlNSuDxrWs6tGLoW5EHUdQrcAffwvT6H3BlNChFGUTcRjdDb5+EvPrI0YePg2tmtXHA==
X-Received: by 2002:a2e:bc23:0:b0:30b:ab00:846a with SMTP id 38308e7fff4ca-33255833cb2mr22606461fa.3.1754287061155;
        Sun, 03 Aug 2025 22:57:41 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332385b247csm16393251fa.39.2025.08.03.22.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Aug 2025 22:57:39 -0700 (PDT)
Message-ID: <e91711f6-c943-402a-8502-52d8ed4c05a9@gmail.com>
Date: Mon, 4 Aug 2025 08:57:37 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] iio: adc: ad7476: Simplify chip type detection
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1754041258.git.mazziesaccount@gmail.com>
 <0ed3a1e9346d84d20838e89a531e8d99f95bcb97.1754041258.git.mazziesaccount@gmail.com>
 <20250801120901.00004a67@huawei.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250801120901.00004a67@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/08/2025 14:09, Jonathan Cameron wrote:
> On Fri, 1 Aug 2025 13:07:13 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The ad7476 driver uses a table of structures for defining the IC variant
>> specific data. Table is indexed using enum values, which are picked by
>> SPI ID.
>>
>> Having the table and an enum adds extra complexity. It is potentially
>> unsafe if someone alters the enumeration values, or size of the IC data
>> table.
>>
>> Simplify this by dropping the table and using individual structures for
>> the IC specific data, and storing the IC specific structure's address
>> directly in the SPI ID data.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
>> 100% Untested.
>> No functional changes intended
> 
> One tiny thing inline, otherwise looks good to me.  This aligns with
> how we prefer to do things these days.  Tends to end up easier to read
> than the enum array thing and best of all removes any temptation to use
> the enum for anything else.
> 
>>   
>>   static const struct iio_info ad7476_info = {
>> @@ -312,7 +306,7 @@ static int ad7476_probe(struct spi_device *spi)
>>   
>>   	st = iio_priv(indio_dev);
>>   	st->chip_info =
>> -		&ad7476_chip_info_tbl[spi_get_device_id(spi)->driver_data];
>> +		(struct ad7476_chip_info *)spi_get_device_id(spi)->driver_data;
> 
> Switch to spi_get_device_match_data()
> which checks via generic firmware paths first (so DT here) and then the
> old school tables.  Also returns a void * so gets rid of need to cast.

Ah. Right! Thanks!

> Only works with all pointers (or a lot of care) because a value 0 is a
> fail to match.  So kind of enabled by your patch.

Yours,
	-- Matti

