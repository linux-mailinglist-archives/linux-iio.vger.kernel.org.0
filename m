Return-Path: <linux-iio+bounces-18946-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 534A5AA62BA
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 20:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A4E19A78C9
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 18:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5B421FF46;
	Thu,  1 May 2025 18:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C8tLBCjX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEFB212B18
	for <linux-iio@vger.kernel.org>; Thu,  1 May 2025 18:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746123655; cv=none; b=qwbf20ubIcrEaGkMUZnp1A7wfs5PUjTRavTtqTQA92PmM/Mjw6hXtgyUiO6KQhoPMerguqugRq2fYMZwkYjzZiXkrkTuyBeYDKH1veSfhMpU3065Ejtg445hDv4kZRpfY+1diAL7iMqSDJp9OwG1Mps0Uxr8i8FKdFAIJL2ZDSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746123655; c=relaxed/simple;
	bh=ee/zaevnqUwSkoSunNrHFLnAVIAFt7231LYdnizFQ7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJtdeAWtWlFDWacVG+RXR/pYl5n4jtwMFFFuDRYILbUxnoADBbssTVxO+XjTC8ynpG2L6UlZ8SBKxc8vxQjd1xxIyNbkSK1z4ApOAcIj9uyq18lNTu3j4Vy4ZdzID5vJ4O8DSHZcb3aEc1lZZxw4WjA5rqoI/pEMADQhTlEcaZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=C8tLBCjX; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3fbaa18b810so340016b6e.2
        for <linux-iio@vger.kernel.org>; Thu, 01 May 2025 11:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746123652; x=1746728452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VYGJo3Dn7n60bY4TCOgRqk3w0LgzaCpNfAMFO24z3ig=;
        b=C8tLBCjXDJZvIXp1KMIA0mVT/oDU+czsQmMyfGRJxGrfnriQPAcWuJtegeZqAE8EP3
         LrlRjv08z7sYQwGPiELY4hJV9UqvIud21WxKsgegu2rIEw+hUAMEzUcTcKB9/FFuiyj/
         DA8OCWDV6CSd78uaPIwrywVfBBUDMNpUg96sjZOZg7cm2aApoMzDYsiyUfI4IauJ7B4b
         NrjpQirekXtlaB+vgjzHxO6kM+p2Woo2Orpu/AQhsjULHthMubZFzR/vz//yOZ3oXVnt
         v+upuHjoALAAxCfmX4Edk1C0dU3YapunEu31raEv+76oSogpvxa0f76FE5xDe2GBgwip
         1o5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746123652; x=1746728452;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VYGJo3Dn7n60bY4TCOgRqk3w0LgzaCpNfAMFO24z3ig=;
        b=kOWQWjrJ5AuUxn912qOi+2BtEX8TFbfPoaaH2ahwvZR/VVBwQy0c/xB8/WJjlUPdY0
         CxjQnO/02B1fr+5Mf0iJ2qqG3v1iz6865GPwnG9tP6gVZvfXBIUvBJb9BgWXSIoRNLqc
         25Dxny8tVWWrxRkS+wAhe5Vk9AuaTsa4EX4Nt2si7WtqTBnXVYirw+AT3L0zfJ1OVKVi
         +jWQPh4V7xpLfKT3fx56Hd+Oocb0O4wMKYJue0Jjp5yjM4vvO6qqT2yFMVE6Ecjq5agT
         dqFyleTtRbLg5Sp1UiYzTqMMD/titkSXDYyj2Nk4903nX7KqYy1/13kBEq372fwnpbWO
         pwVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2UacUqcCmkkb9shVyWfVepRQhlCGNWxMJFPVaZC9AyxX6If3I7xIfbBDd6hSUFaVI+OZSp6vaHLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCs9gCylk8L+W5yaxXcHSeJBZ6Wdqd4rkpCyuvv0GLpKthrhwz
	pBsMxYF35TdY/QRmJfRKrlMH0HoNp9FixkFwMkkUdsUfQJrMusUAPSaHKlfm8Fg=
X-Gm-Gg: ASbGncuLBlSS2Hnjy5hK94rqQWMUBxmPzE6fPDbK6fvHcRntzcMMEqf+KRPhDcdakzD
	H4j57ZclbMOgILsaKhSkMeTH7MrJTZnbCsxNTjW7E3ClhzMZhi2nQ8R4q6cxXBX1etcNBZ3xE5u
	l1/GvUPS5fBLaY+R7HxGCCHtDXt+Opt5AmmIWexfZPbwBxI+KRBqLpWlAQcvwWgnffUp2zBQhAn
	JH8PqN27ElUgvebjKgkhx2wqeWpzo9qLqmJnN8D97MZU91Z8p3/gGLOs8ZrNqtn5mpRxFc72gGC
	45jSKaPQiczGRxFzxQ4jK+IAx4MOq6LE78FEmK5j7Vj/7feYCKdJZtRdh29f7l9PzZxy+bOmv+7
	fNkp9PSK6nnNDMTRZlg==
X-Google-Smtp-Source: AGHT+IH95yusdxRir/cXJT3ckHlcNRsZkDgwRAlLqFb4K6kB/7aHv+SLzJSxmOI7WMpz+iOmfZknvg==
X-Received: by 2002:a05:6808:1b8a:b0:403:323d:3038 with SMTP id 5614622812f47-4034147925bmr147308b6e.28.1746123652592;
        Thu, 01 May 2025 11:20:52 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:b1ed:e5d7:8ea6:40e0? ([2600:8803:e7e4:1d00:b1ed:e5d7:8ea6:40e0])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4033dc83d9csm207984b6e.48.2025.05.01.11.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 May 2025 11:20:52 -0700 (PDT)
Message-ID: <46659705-0384-4497-9f5d-cae4a8290093@baylibre.com>
Date: Thu, 1 May 2025 13:20:51 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] iio: adc: Add initial support for TI ADS1262
To: Sayyad Abid <sayyad.abid16@gmail.com>, linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nuno.sa@analog.com, javier.carrasco.cruz@gmail.com,
 olivier.moysan@foss.st.com, gstols@baylibre.com, tgamblin@baylibre.com,
 alisadariana@gmail.com, eblanc@baylibre.com, antoniu.miclaus@analog.com,
 andriy.shevchenko@linux.intel.com, stefan.popa@analog.com,
 ramona.gradinariu@analog.com, herve.codina@bootlin.com,
 tobias.sperling@softing.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250501100043.325423-1-sayyad.abid16@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250501100043.325423-1-sayyad.abid16@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/1/25 5:00 AM, Sayyad Abid wrote:
> The ADS1262 is a 32-bit, high-resolution delta-sigma ADC communicating
> over SPI. It's designed for precision measurements.
> 
> This initial driver provides the basic functionality needed to:
>  - Probe and register the device via SPI.
>  - Expose standard IIO channels for reading raw voltage samples.
> 
> Basic testing was performed on a Raspberry Pi Zero 2W using the hardware
> SPI0 interface. The connections used were:
> 
> +-----------------+            +-----------------+
> | RPi Zero 2W     |            | TI ADS1262      |
> | (SPI0 Pins)     |            |                 |
> |-----------------|            |-----------------|
> | MOSI            |----------->| DIN             |
> | MISO            |<-----------| DOUT/DRDY       |
> | SCLK            |----------->| SCLK            |
> | CE0             |----------->| /CS             |
> | 5V              |----------->| DVDD, AVDD      |
> | GND             |----------->| DGND, AGND      |
> +-----------------+            +-----------------+
> 
> I would greatly appreciate any feedback on the driver structure,
> IIO integration, SPI communication handling, or any potential issues
> or areas for improvement you might spot.
> 
> This series is broken down as follows:
>  Patch 1: Adds the core driver code (ti-ads1262.c).
>  Patch 2: Adds the Kconfig option.
>  Patch 3: Adds the Makefile entry for compilation.
>  Patch 4: Adds the MAINTAINERS entry.
> 
> Thanks for your time and consideration.
> 
> Sayyad Abid (5):
>   iio: adc: ti-ads1262.c: add initial driver for TI ADS1262 ADC
>   iio: adc: Kconfig: add Kconfig entry for TI ADS1262 driver
>   iio: adc: Makefile: add compile support for TI ADS1262 driver
>   MAINTAINERS: add entry for TI ADS1262 ADC driver
>   dt-bindings: iio: adc: add bindings for TI ADS1262
> 
>  .../bindings/iio/adc/ti,ads1262.yaml          | 189 ++++++++
>  MAINTAINERS                                   |   7 +
>  drivers/iio/adc/Kconfig                       |  12 +
>  drivers/iio/adc/Makefile                      |   1 +
>  drivers/iio/adc/ti-ads1262.c                  | 438 ++++++++++++++++++
>  5 files changed, 647 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
>  create mode 100644 drivers/iio/adc/ti-ads1262.c
> 
> --
> 2.39.5
> 

It looks like you managed to CC everyone who ever touched the IIO ADC makefile.
On v2, you don't need to include quite so many. :-) Just the people listed in
MAINTAINERS.

And you can drop the RFC on v2, there doesn't seem to be anything unusual that
needs more than regular review. v1 didn't really need the RFC either and is
quite good for a first IIO driver. ;-)

