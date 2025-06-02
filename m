Return-Path: <linux-iio+bounces-20156-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBA7ACB845
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 17:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56B854C47C9
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 15:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC25226863;
	Mon,  2 Jun 2025 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uQqnRoC8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB91226556
	for <linux-iio@vger.kernel.org>; Mon,  2 Jun 2025 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748877443; cv=none; b=L5+gdqKYhw7545/y9P6zfiVJ8aGOhSNCXrIPkgspZT95M90r/bWP7c33TFDwRSldqp887WilYBVprRVte+5F3RWZYoNo/ZZzWog97r3bl3EIHiNeQn9HIGCpI0Wc5WsNs4zx7RzzkMHSpe5nrcPuzpzBQWruOeo8eQbBZewfLfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748877443; c=relaxed/simple;
	bh=6PeBJSTna6lX3rGrf4lCGvp5OKDfktdRcJOfJVLf5WA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lcQb7byc9UCI7Am8drUrFoe7+tHDkvZV7VDSO1R5aHQ2u/EJDK/I8HOOacsnEINQTm6P2FyKkBTe3hID031UDeot2Twqt6nnV5PCAKqLAF/iBSkhu+4pgwe054+1eGNeoz9jP+WDCfvPeYVUlPxzz8S7W+QY6PifmbnL292vCFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uQqnRoC8; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2d0920ce388so2440648fac.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Jun 2025 08:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748877440; x=1749482240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/FLsGzoXOAagEvr3iBgspYfHnJfzfNsAWbJHVPi43wg=;
        b=uQqnRoC8bVrAJ7GFrYX0xzTIwaXDpPLPMjgilPOwjvArRDhEbMTgS1k4xHvtQ7SSMd
         G9qoY5vjSo3/Gxq81aBGy+Xk1TWeaenwWzArmqCTl79zmPpzFWgPgY8wywSOUqqGBf3l
         lqSEFYtXKeE/4IKWuMfjlcvRqgdJ4dHT3915o0KvFTno0SnYWPl6ekdBn4ZuoWPF9wpZ
         U2Dji7zezOajUxoct4hiSze9Titte6XhsSSQf2U8f71uGPjuhgQxu5FVSRnZXpvV5y3n
         FuADPKRHrzhvwqO00MQE0sF+wGUUvxNTiPXn2BTKapnFVA5L4m98/c4RH12SXJV/iDR8
         sRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748877440; x=1749482240;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/FLsGzoXOAagEvr3iBgspYfHnJfzfNsAWbJHVPi43wg=;
        b=UoaSm/IpI/WJNTlu7ww735ikKOPnsroVg2i6Kz97i9AIEoVdmKkE42C84VpJ0Aljji
         POCT+9T7qdhW6Y9rNhXCh6K/RSfAFfy/ZbMiKKRBLgvLhaLf49N3Hihn80PhRYtTDCPO
         r9p22GhRcN9vfueiS1CAI4I8FTzaERDW7Nk9RgB5LpeD0xy1wa8jpYssAek7xdTxGkmZ
         TqdJ3ITczxT58qlzVOROkm6a9j+zqoGiPptYwp76hQA1qceUPNAiPrXr3qQ/ZRRNWJ1d
         iNyiStxzwVErCj83W7NYOe154OTnp6RQSbo1WAG+KF+oyIpEe+LoMk+sGH2sltFpSWN/
         kFdA==
X-Forwarded-Encrypted: i=1; AJvYcCXajPkSu1e4Dt23u5OiJDk9JEWEW+ni8Vz/P1zhddbmSK+zs9VvJshIU8P62wHQaiLsIYOFdIEDizc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9x0jT27+UQaoIGj/UI/jFVQTN5FniWRXG+RTOVix7IhcqjmnC
	GAGE9rkzzwPqChHse2wF8V8+iBmv1O+gGbvhbywV0uBa0rwBH33jD7k6zZ8T32kp7CM=
X-Gm-Gg: ASbGncsO6K2qJDrehMdtA0NrLqG3dKi/1YdFIaxFyTVEuGu7wZiTiVJ5C53xeGZbmHs
	CQLA4ewPlU8j9jcvNeoQ/pDt3P4qpU7R3RaPbeLoNj3cgQrBiH8bBEtJpa4vi0kegROv8fJEcUl
	fqXzpbwTZ14a8m39bsfBJFQnV6/vAHW6DpmF7G/VjRnR2IBhWg0zZeUUIC2XiNhZ5uAjMkHEfQ6
	S2qsWfL3MoRLGxQBpswV7UP43470yy/9VFC4xuPVOReRGzLaS3LltFsSc24ErdUzt678IH5NO9f
	xTNPPt9Y7l96T30CPt8JJ1YagBJwrfe44k0NSFHiIQDv8DDNBH0Tan6snL3j1FviVVl+8Myi3LS
	VPmnNwc57QgiSR5hSuUFn/mIapnyHfuqPnnhvmYv4vmkiQgbcuQ==
X-Google-Smtp-Source: AGHT+IFJw1a45g7SyLmMPrQb2Epc56Sa07pw4E8vlKLf+JG+t/AybNRoowveYczNrGBWjBjxY3fQ3g==
X-Received: by 2002:a05:6870:5493:b0:2d6:af0:8d8e with SMTP id 586e51a60fabf-2e92115fb6fmr8227470fac.2.1748877440482;
        Mon, 02 Jun 2025 08:17:20 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:74f4:5886:86e1:3bcf? ([2600:8803:e7e4:1d00:74f4:5886:86e1:3bcf])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2e90681c6ffsm1783595fac.29.2025.06.02.08.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 08:17:20 -0700 (PDT)
Message-ID: <a6f62963-5776-47e4-bdac-78e921a6e476@baylibre.com>
Date: Mon, 2 Jun 2025 10:17:18 -0500
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
 <1b0e9003-7322-46fa-b2ba-518a142616dc@baylibre.com>
 <vchomz3iazgdmotcs3jskrugi2qmdxyo74t4ruo2fsc7cjwtqb@7rtdmdkxobvg>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <vchomz3iazgdmotcs3jskrugi2qmdxyo74t4ruo2fsc7cjwtqb@7rtdmdkxobvg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/25 4:17 AM, Jorge Marques wrote:
> On Tue, Apr 29, 2025 at 10:45:20AM -0500, David Lechner wrote:
>> On 4/29/25 8:48 AM, Jorge Marques wrote:
>>> Hi David, 
>>>
>>> I didn't went through your's and Jonathan's ad4052.c review yet,
>>> but for the trigger-source-cells I need to dig deeper and make
>>> considerable changes to the driver, as well as hardware tests.
>>> My idea was to have a less customizable driver, but I get that it is
>>> more interesting to make it user-definable.
>>
>> We don't need to make the driver support all possibilities, but the devicetree
>> needs to be as complete as possible since it can't be as easily changed in the
>> future.
>>
> 
> Ack.
> 
> I see that the node goes in the spi controller (the parent). To use the
> same information in the driver I need to look-up the parent node, then
> the node. I don't plan to do that in the version of the driver, just an
> observation.
> 
> There is something else I want to discuss on the dt-bindings actually.
> According to the schema, the spi-max-frequency is:
> 
>   > Maximum SPI clocking speed of the device in Hz.
> 
> The ad4052 has 2 maximum speeds: Configuration mode (lower) and ADC Mode
> (higher, depends on VIO). The solution I came up, to not require a
> custom regmap spi bus, is to have spi-max-frequency bound the
> Configuration mode speed,

The purpose of spi-max-frequency in the devicetree is that sometimes
the wiring of a complete system makes the effective max frequency
lower than what is allowed by the datasheet. So this really needs
to be the absolute highest frequency allowed.

> and have ADC Mode set by VIO regulator
> voltage, through spi_transfer.speed_hz. At the end of the day, both are
> bounded by the spi controller maximum speed.

If spi_transfer.speed_hz > spi-max-frequency, then the core SPI code
uses spi-max-frequency. So I don't think this would actually work.

> 
> My concern is that having ADC mode speed higher than spi-max-frequency
> may be counter-intuitive, still, it allows to achieve the max data sheet
> speed considering VIO voltage with the lowest code boilerplate.
> 
> Let me know if I can proceed this way before submitting V3.


