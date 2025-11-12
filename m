Return-Path: <linux-iio+bounces-26185-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 298B1C53B19
	for <lists+linux-iio@lfdr.de>; Wed, 12 Nov 2025 18:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 579B0560B48
	for <lists+linux-iio@lfdr.de>; Wed, 12 Nov 2025 17:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF65F3451D5;
	Wed, 12 Nov 2025 17:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dwz9Ugmd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBD833C535
	for <linux-iio@vger.kernel.org>; Wed, 12 Nov 2025 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762966801; cv=none; b=nIden+nGISJxODEQu3ZIgeuOov1ARLV+oXcJBxr18l7rhETz37yZ3nKm/XdO+LH2rH/zpR/TLqHaGnmMXiiBx1DpIW9hB9/GrY0yvRqTBa+0AjOW4nsxwwxbBYXz/bkOrJwMTzYQqOs0ZGQvruLWgqQUN7o/lQjF5edWgYG4NtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762966801; c=relaxed/simple;
	bh=8wx44lorjmXobYAPjgirMKLJlUNzSsr5s3gulPDv6j0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qmoox9wKFnT9rws3fTajvtrH64g6Eb8EX/AfLGiSa+Xi7zc9UlgRZk2lGulr6jQ9dA6A45Fc8NZpniSSmu+66c6RgzCw0FiozbUHL31oi4gW0Rcsh83xUED/G0YiCOQVGfdJx2JtxQGbiwG3WVUW7at2c1jropOebeuIg6g8G1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dwz9Ugmd; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-44fa4808c15so203393b6e.3
        for <linux-iio@vger.kernel.org>; Wed, 12 Nov 2025 08:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762966798; x=1763571598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9UBroaIpNSaiJuWFrz+qWW2HM0uYdQr3mWyR9bfJIIM=;
        b=dwz9Ugmdt4tA8qi6929B5cM2xqwjHCY2sziOHziktlu15hr+e6pR0ZO6X9I4LWCo6i
         mI8gpfA9IzRCnS7rfun2r6dZtrZdkBwT4g6ro1VOCO10ky1BJ2DqXicY2taSkHWzhEYc
         tXYftMocbYP7EN2QB+FBfdNziCXNimUIUI8zYIX/9TL5pvjN4FkcNxCQgnlGz6FCMv66
         D2BibSGCafSfGj4yYb0tODuc3lWYsiZjfj7RLcNm4VGVLWYaLgRcTTCxh5pr6S4FL+4m
         TbUZZuDqUralxivWZydq+2Knhoj/520cHrH63BIAkwdunauvfFOtlaDM3nKPFycaS+TE
         jtgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762966798; x=1763571598;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9UBroaIpNSaiJuWFrz+qWW2HM0uYdQr3mWyR9bfJIIM=;
        b=gwpvnG2YU30LvS4P3UZJgc4hf4pNHOEd+yvJT+o96bd7hvk8zxsrILSKQrCSZTmetl
         sdZvX6eiL4wiz6lomHCoScvOVMeABC+obnWHmh2w5bvGsuO+OpwH2YQ3ATCj+h//WRyn
         gHYYscsubp7ryfNGLZWrSg314QCVPklMklBCgmsrImxUkdNLaa3LWFhomqcJbHtzx46E
         HqwxsYgI8AP2cwRUomfgnjGJcI8qYAvF/ntbkftpXn0q3DlqVXrtwIG/eA25QHDVyMj5
         hzS1DPEByQa911zeon/kyqwolfVL+sahTZZ0Q34k/KqKYfYaXnwRTT4Nv7sNqgCi4en2
         OCQw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ2OQMXGpYOY07FdjcEvNgtZWJQa5s+GwF+wwMM/IHwd7Qg5BaJo7m+kw98xHI0Ch8da5hG0y5OxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo6V25w87Dm9FtdFH59fsVaxABOJkUaBfxVxGHvUehk0bQVZHn
	qydJKSGg/DWDmxKs7YlLMiQAgn58aefPjOX3cgPDzkgp0stZ4HmwS9kAnPGS+PEFz3c=
X-Gm-Gg: ASbGncsqOec4NVb9mXOrfY0/VHVjpTtUuQmDppbHqTdLaaWOeSZc8kuAPET/o9C2UGw
	FAubTUNfzWLuLp9n/diH7HyZlLRJL0RMoxnqv1eyMicgZ/CjEKYw0Xy0Rmu3OGtb2mu8rgWZT7+
	RWY+4QNZEmqzAqnAepkVp7cyTLeMWxdBOQwLuwYq7bnGIcSI0FA4KAMjjUsntnppTv8FvSBSEm1
	U9yVYQBNprA2B/wN3UgegbgubHs5RaRwI23ObulrrraSK7Vx4CnDm1s/JufT21nmMavPZ+DSHs1
	rmF7Y1uwb1J/Z76IFxGrj0mRx/ZcgdpFIWMGGKGHwf58CbjMfhQnBrqiTEJUuTzdihD/q5wBgvo
	yl2hQ0dJ1ucdyVohzT0psTVGcUifnQHCN84wuvNg4A5okd97PO6/CWmXRK1/gkUDjWYSrx/TvLl
	V8J8NdDDXfjaI0Yxxbb4PEUNQEj6wnqLXigMyorMhzEVNdKDLwpA==
X-Google-Smtp-Source: AGHT+IGjGiA68SQxE2DOheehH23MBaQy65p8WqlrKArkfS9SuLVcwJ48eTHV9RHhY2eyZHq3Z4deyQ==
X-Received: by 2002:a05:6808:3198:b0:442:2ce:46cf with SMTP id 5614622812f47-4507456e715mr1828413b6e.34.1762966797983;
        Wed, 12 Nov 2025 08:59:57 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:d404:301b:b985:c499? ([2600:8803:e7e4:500:d404:301b:b985:c499])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3e41f2583casm10124611fac.23.2025.11.12.08.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 08:59:57 -0800 (PST)
Message-ID: <0e59d92f-7b3c-4ff6-b3ad-7fae2ded9b77@baylibre.com>
Date: Wed, 12 Nov 2025 10:59:56 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] spi: axi-spi-engine: support
 SPI_MULTI_BUS_MODE_STRIPE
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20251107-spi-add-multi-bus-support-v2-0-8a92693314d9@baylibre.com>
 <20251107-spi-add-multi-bus-support-v2-4-8a92693314d9@baylibre.com>
 <aRNSc1GEz0UNx17i@debian-BULLSEYE-live-builder-AMD64>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aRNSc1GEz0UNx17i@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/25 9:12 AM, Marcelo Schmitt wrote:
> Hi David,
> 
> The updates to spi-engine driver look good.
> Only one comment about what happens if we have conflicting bus modes for the
> offload case. Just to check I'm getting how this is working.
> 

...

>> @@ -284,6 +316,24 @@ static int spi_engine_precompile_message(struct spi_message *msg)
>>  			min_bits_per_word = min(min_bits_per_word, xfer->bits_per_word);
>>  			max_bits_per_word = max(max_bits_per_word, xfer->bits_per_word);
>>  		}
>> +
>> +		if (xfer->rx_buf || xfer->offload_flags & SPI_OFFLOAD_XFER_RX_STREAM ||
>> +		    xfer->tx_buf || xfer->offload_flags & SPI_OFFLOAD_XFER_TX_STREAM) {
>> +			switch (xfer->multi_bus_mode) {
>> +			case SPI_MULTI_BUS_MODE_SINGLE:
>> +			case SPI_MULTI_BUS_MODE_STRIPE:
>> +				break;
>> +			default:
>> +				/* Other modes, like mirror not supported */
>> +				return -EINVAL;
>> +			}
>> +
>> +			/* If all xfers have the same multi-bus mode, we can optimize. */
>> +			if (multi_bus_mode == SPI_ENGINE_MULTI_BUS_MODE_UNKNOWN)
>> +				multi_bus_mode = xfer->multi_bus_mode;
>> +			else if (multi_bus_mode != xfer->multi_bus_mode)
>> +				multi_bus_mode = SPI_ENGINE_MULTI_BUS_MODE_CONFLICTING;
> 
> Here we check all xfers have the same multi-bus mode and keep the mode that has
> been set. Otherwise, we set this conflicting mode and the intent is to generate
> SDI and SDO mask commands on demand on spi_engine_precompile_message(). OTOH,

s/spi_engine_precompile_message/spi_engine_compile_message/

Probably just a typo, but just to be clear, the "on demand" bit happens in the
compile function rather than precompile.

> if all xfers have the same multi-bus mode, we can add just one pair of SDI/SDO
> mask commands in spi_engine_trigger_enable() and one pair latter in
> spi_engine_trigger_disable(). I guess this is the optimization mentioned in the
> comment.
> 
Your understanding is correct.

