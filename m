Return-Path: <linux-iio+bounces-22375-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC5DB1D35C
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 09:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8776170626
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 07:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF79723CF12;
	Thu,  7 Aug 2025 07:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CS+qtON/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0EF1E51F6;
	Thu,  7 Aug 2025 07:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754551862; cv=none; b=lL0YpuJSjulWdeQLsPT+YASKh6f6lzq7ZDH/iej6YhqEVzVaXDY5fv0/Vffc4SpsrXGvizDLi/cVjBSQ4n6E+aVrELvtw+9Box04oZuv98cjZf6yUuHSVhDbXSVwnd0ZtcWskJ5mm/CvIn+jvi2LJrQm/mRqQZVDUrfTTZ4KvdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754551862; c=relaxed/simple;
	bh=8bhVfP3E01JnBHl5Sjv9LXWWpcCpjniUzDypYvqNQSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXZ8AC+SvM091cvxawciLZTLyM/o+KlBhRVxiO3DDzJPiMIaC1ShPxA1pXo2n7YT/ElIbHxTMoNxqdlvonwZZ4uvjMSfX4xF5m5MLxjtQcPgcYcRr3/8OM8yD5/w7IuNVJXs9yTryfxxodl/1oDBUeS+f/ikWmaQG+hvh9EJlcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CS+qtON/; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32f1df58f21so6459871fa.3;
        Thu, 07 Aug 2025 00:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754551859; x=1755156659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DH0v59CTieRTn3xq/H8g9PIVvtqXLyj735PEGTi5s/M=;
        b=CS+qtON/dv5+QRV4HV17D4rw0dGQQpnuarDtrk3Tj0M8LBU6RVxc0iJ6CmYprzC7CN
         JbY6FwUv8NllWyjGYjVw9c+7CCziZIq9DN2GFVxMikS4L7eR0AnWDIZW/xRBCuZymrbk
         xQ5LXh17/W+ftoXZIAgifP2RZJcCKNrQyt6FuIam/XXPdA58pyzBKf6W9dasZ0D/cxP2
         eQaaLRMyQd0K2nGWTwqZOWXlZuislofrDNCTZwhqhv70sHk2FmCeOk3vNBbPCxq05jOu
         e98Wplekn7d0cgNdrDyHLLJ8Ol5OdFvFRW5ZygnX1pqCTdZZoe0UFukdX/+HN/3JlVGa
         GHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754551859; x=1755156659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DH0v59CTieRTn3xq/H8g9PIVvtqXLyj735PEGTi5s/M=;
        b=N89V0Ayi88LaFEZth/AMkR6qFPHV2rfLIblWEmFThrpuJKGvbBG8uvc+7mOzthgV6w
         sUrYCsKmxjadJdLvPVlbLEDBrO6Ryy2KX1MhkDbgv5iUd6CUlRfdnwdK9WnY+tnn8R0D
         XWOvl7Ox1K6r4fpMfYvbyabn/2LHb5MDLBqogxNSL7htnMJSkcm3beKn+rOeJti2igP9
         9sNSfJKqErJcLx81F7wHF6gZArk8h9wxNOS6bj5G6a6iDjL47TvuLJnInTXBpTf6qQ4I
         hO7WCK29kRkWw5e3sPpN/SX4wiLfgSJyaIUog2R85FGpu9aKJmWc9bFbfRxyiRbfk12/
         HKaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEAhLQgLcH5J3MS6MZFgycV3ZqnAlok/2KBQnjWZpi+W2mXziwA/kZZmzzsaV+nn39jzCPzRzvIGT5@vger.kernel.org, AJvYcCUGs6+OLlr7QErcrDsPlr5Wsk5ppl7XFujtQw41nuToq9bx8YbyTSqs1Yx7eVJik/yd567AcCsuiijz@vger.kernel.org, AJvYcCXif7pTNVFYWrW7qWj2bWQnIw5onZhFlGqfC7cbHp2dRCzYVzdFfmyknjrPUlp/+bgwljUe7rmdMy9ML/UL@vger.kernel.org
X-Gm-Message-State: AOJu0YxLJI1FDUH5ZTmcPl5ESDGmIEcMeoiM388JkX/jNsc1h5XGNeSq
	oD3Vq8H/w0UnYiGlx+QYxNsTZBwuAB7mdaBG0GSUbAVQPX3cOyM5kd8/
X-Gm-Gg: ASbGncu7WNHUbSbwDABlouP4JrNcSKaxTKLwsHw7AwFUI49hqEd50QqQKAYwDYzP3n/
	bvx82IysYK51rPYs19je/uEuBoAX+zboxJzqIoMS43/PlKJJ82j7yAwIGev5FEAjBfe0S2pCK40
	UA53GuDBV9rXWklmaSSqy1r3h9hGLgVNYkvnpXd/ffFGAjCYFCciyPV1POvi1Jthc4QOuHaVjUL
	1ILwFWD9eyVQtqLi0D59BIeVTgedIAZzdYkJk/LO91YJs3RdJO+TcnDK5PtDUghDfxj3T2HoKVE
	DQQ6WE0+x7Jg8z2DX+rD50LYNFYvBUvIBAYhRWp/4mq4lYp0YsFmpAWibX8VsihGpvpJfDtYDgt
	JWezK9YlVfqm+hu6AV5J3bKcBE5SgUmHzn4TDbG7N66fD6x+meteMhN8jA2F3Q/KD0ckna0ogOk
	ZhqcU=
X-Google-Smtp-Source: AGHT+IGdbHSIFcQGIfnqAUowNVGDgy1tLuxa8roYI1ir8BJfTt9tS4PxpKjxMqu/cldNvoJKQViGtA==
X-Received: by 2002:a2e:a548:0:b0:32a:885b:d0f with SMTP id 38308e7fff4ca-333813bd630mr14814291fa.24.1754551858718;
        Thu, 07 Aug 2025 00:30:58 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c9908esm2543273e87.76.2025.08.07.00.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 00:30:58 -0700 (PDT)
Message-ID: <f738f3fb-2ce8-4699-bb13-3778ed1c6606@gmail.com>
Date: Thu, 7 Aug 2025 10:30:57 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] iio: adc: ad7476: Support ROHM BD79105
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1754463393.git.mazziesaccount@gmail.com>
 <c7f94cdf9bdc6882953f6a074db3fd87570fa98b.1754463393.git.mazziesaccount@gmail.com>
 <aJO6jVcITlOXp0YB@smile.fi.intel.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <aJO6jVcITlOXp0YB@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/08/2025 23:26, Andy Shevchenko wrote:
> On Wed, Aug 06, 2025 at 10:04:43AM +0300, Matti Vaittinen wrote:
>> The ROHM BD79105 is a simple 16-bit ADC accessible via SPI*.
>>
>> The BD79105 has a CONVSTART pin, which must be set high to start the ADC
>> conversion. Unlike with the ad7091 and ad7091r which also have a
>> CONVSTART pin, the BD79105 requires that the pin must remain high also
>> for the duration of the SPI access.
>>
>> (*) Couple of words about the SPI. The BD79105 has pins named as
>> CONVSTART, SCLK, DIN and DOUT. For the curious reader, DIN is not SPI
>> ISO.
>>
>> DIN is a signal which can be used as a chip-select. When DIN is pulled
>> low, the ADC will output the completed measurement via DOUT as SCLK is
>> clocked. According to the data-sheet, the DIN can also be used for
>> daisy-chaining multiple ADCs. Also, DOUT can be used also for a
>> 'data-ready' -IRQ. These modes aren't supported by this driver.
>>
>> Support reading ADC scale and data from the BD79105 using SPI, when DIN
>> is used as a chip-select.
> 
> ...
> 
>> +
>> +static void bd79105_convst_enable(struct ad7476_state *st)
>> +{
> 
>> +	if (!st->convst_gpio)
>> +		return;
> 
> With 10ns sleep in mind this is also unneeded check.
> 
>> +	gpiod_set_value(st->convst_gpio, 1);
> 
>> +	udelay(1); /* 10ns required for conversion */
> 
> We have ndelay(). But I believe toggling GPIO is much longer operation.

Thanks for the review Andy.

As I replied to David, this 10nS is rubbish. I need to clarify the right 
value.


Yours,
	-- Matti

