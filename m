Return-Path: <linux-iio+bounces-8698-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8700195BF12
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2024 21:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38DFA284F9A
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2024 19:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6161D04A4;
	Thu, 22 Aug 2024 19:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ugkuuewD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8888913B586
	for <linux-iio@vger.kernel.org>; Thu, 22 Aug 2024 19:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724355824; cv=none; b=sXjJzra06ZdGX7ve4f/Lquis5sS7Tv0nK8wmHEtk4bH9nq7t9UYOLU/hGIZHKmBRsfYMAUNQ44n9T0Iy/KfPujz8URXeFien0HR2mGDxyaWt/HzO5K7XllY/J4BuBFvSz0I0QlD8ZNXjOgJ5NoXdRTpWx4sjgnoxg+8VjfcFv5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724355824; c=relaxed/simple;
	bh=RP4y+/7MM9jSz5HZCZkGA8wnBwm/mXV7qSW3J20gAiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=piXXSvR6OCPnCl5whWgW3UtWFRQillcvKS+8eAU8asvNYMnEQ3M6oDp8+J8xy14ujaaaNWVWzIRgs5U+ELz1OKPsx4YF+vAuZF6k4yzfDNnighyQhPFwCfh7Kx9uIZ4jgODor48uNCoeZyjVH8xoYGoqfHzaCxtaxLEghcVXBW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ugkuuewD; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-270596dbf59so853330fac.3
        for <linux-iio@vger.kernel.org>; Thu, 22 Aug 2024 12:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724355821; x=1724960621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zrphh2W/kycmfZ/8VneCtdGx+CrSEXJ4tVn5Mz1GwDo=;
        b=ugkuuewDBWHFuKLobPJ5q8tDJYA+DDHH3sjpjho/bF1Z1KPnpYa7feaPYu/oBxupQ+
         rKyA493K7AH2nWcg1xh2HvXfwNlgHaVJAQrhqT7JUruWKlsS9LLKSCiGlYwSY5m6NsIF
         WYVeG1lwoJZQWKuSvKn4A2ML1/pmGACE7lUe5M7DTKf2+cgX5yx78cp3kHSaqUkqFwf2
         lzzLl3n3jvse/uuFThRqFCGIzP1GqoneGPNaooaYqo5fa3FW1g/JkECDhgV29qsqIF0T
         nYTj0jP79sqCszhLk6aA0arGXUfxQyqGD/jgS3Vzr2wFeAr+kkhLokG8htkX8EfSbOeD
         hAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724355821; x=1724960621;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zrphh2W/kycmfZ/8VneCtdGx+CrSEXJ4tVn5Mz1GwDo=;
        b=npntCrEnetjoVdrsu26rWepHb0XGtPJCZ0vwlwmb9c0MVS5VWnkjF1McboTct4dkuf
         2Q57Eh2YY/9qINLkwU2g3oGzYDYl3/Ywa2KoztixBhGql/4CO06VM+h3jmvOY51FXoH8
         qlZD9NKrFb7P+rNUXZse0fXKgTz+0s1YvokHNUTtny/x03UTpm9RXLa5r+kzuuxm20xp
         Csv3piDYSMmGV8h7nr7Upzrgk0NgAAfEt58FVjQRaRlkuY200dggDzEP3f4e4Thsj0yB
         h7egD5QoCladmpwFPLK9S4tJ3mWR/bf7GJzcUWUS3mvkpEJs28EriJey2vh1/XgFlGPd
         FUPg==
X-Gm-Message-State: AOJu0YzCVf11x/Uj9VvpSrtp0BG0IjgYwpMl/w8R/DVjLoeGL0BO8pYu
	/cP0tAFMLpA5cgTWhjpjxGjFCQL4ay5Yan18/VYcX5ZH5rJH84djmhCgZoZqN6k=
X-Google-Smtp-Source: AGHT+IGe2irDfM2bs6E4ggVjVcIPPoXUbqTchSMChCsaSe9hLazbwWqlCJ5t9m9HeiEyM6ANkykcRQ==
X-Received: by 2002:a05:6870:1614:b0:25c:b3c9:ecda with SMTP id 586e51a60fabf-2738be3ae43mr7375252fac.38.1724355821576;
        Thu, 22 Aug 2024 12:43:41 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-273cebc59a3sm510786fac.55.2024.08.22.12.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 12:43:41 -0700 (PDT)
Message-ID: <98c34122-6077-4d2c-835c-12e479d90730@baylibre.com>
Date: Thu, 22 Aug 2024 14:43:40 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] docs: iio: ad4030: add documentation
To: Esteban Blanc <eblanc@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
 <20240822-eblanc-ad4630_v1-v1-6-5c68f3327fdd@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240822-eblanc-ad4630_v1-v1-6-5c68f3327fdd@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/24 7:45 AM, Esteban Blanc wrote:
> This adds a new page to document how to use the ad4030 ADC driver
> 
> Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
> ---
>  Documentation/iio/ad4030.rst | 129 +++++++++++++++++++++++++++++++++++++++++++
>  Documentation/iio/index.rst  |   1 +
>  MAINTAINERS                  |   1 +
>  3 files changed, 131 insertions(+)
> 
> diff --git a/Documentation/iio/ad4030.rst b/Documentation/iio/ad4030.rst
> new file mode 100644
> index 000000000000..56e0ba58b127
> --- /dev/null
> +++ b/Documentation/iio/ad4030.rst
> @@ -0,0 +1,129 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +=============
> +AD4030 driver
> +=============
> +
> +ADC driver for Analog Devices Inc. AD4030 and similar devices. The module name
> +is ``ad4030``.
> +
> +
> +Supported devices
> +=================
> +
> +The following chips are supported by this driver:
> +
> +* `AD4030-24 <https://www.analog.com/AD4030-24>`_
> +* `AD4630-16 <https://www.analog.com/AD4630-16>`_
> +* `AD4630-24 <https://www.analog.com/AD4630-24>`_
> +* `AD4632-16 <https://www.analog.com/AD4632-16>`_
> +* `AD4632-24 <https://www.analog.com/AD4632-24>`_
> +
> +IIO channels
> +============
> +
> +Each "device" channel as described in the datasheet is split in 2 IIO channels,
> +in the following order:
> +
> +- One channel for the differential data
> +- One channel for the common byte.
> +
> +Supported features
> +==================
> +
> +SPI wiring modes
> +----------------
> +
> +The driver currently supports the following SPI wiring configurations:
> +
> +One lane mode
> +^^^^^^^^^^^^^
> +
> +In this mode, each channel has its own SDO line to send the conversion results.
> +At the moment this mode can only be used on AD4030 which has one channel so only
> +one SDO line is used.
> +
> +.. code-block::
> +
> +    +-------------+         +-------------+
> +    |     ADC     |         |     HOST    |
> +    |             |         |             |
> +    |         CNV |<--------| CNV         |
> +    |          CS |<--------| CS          |
> +    |         SDI |<--------| SDO         |
> +    |        SDO0 |-------->| SDI         |
> +    |        SCLK |<--------| SCLK        |
> +    +-------------+         +-------------+
> +
> +Interleaved mode
> +^^^^^^^^^^^^^^^^
> +
> +In this mode, both channels conversion results are bit interleaved one SDO line.
> +As such the wiring is the same as `One lane mode`.
> +
> +SPI Clock mode
> +--------------
> +
> +Only the SPI clocking mode is supported.
> +
> +Output modes
> +------------
> +
> +There is more exposed IIO channels than channels as describe in the devices
> +datasheet. This is due to the `Differential data + 8-bit common-mode` encoding
> +2 types of information in one conversion result. As such a "device" channel
> +provides 2 IIO channels, one for the differential data and one for the common
> +byte.
> +
> +Differential data
> +^^^^^^^^^^^^^^^^^
> +
> +This mode is selected when:
> +
> +- Only differential channels are selected
> +- Oversampling attribute is set to 1
> +
> +Differential data + common-mode
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +This mode is selected when:
> +
> +- Differential and common-mode channels are selected
> +- Oversampling attribute is set to 1
> +
> +For the 24-bits chips, this mode is also available with 16-bits differential
> +data but is not selectable yet.
> +
> +Averaged differential data
> +^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +This mode is selected when:
> +
> +- Only differential channels are selected
> +- Oversampling attribute is greater than 1
> +

Worth mentioning calibration (gain/offset) feature?

> +Reference voltage
> +-----------------
> +
> +The chip supports an external reference voltage via the ``REF`` input or an
> +internal buffered reference voltage via the ``REFIN`` input. The driver looks
> +at the device tree to determine which is being used. If ``ref-supply`` is
> +present, then the external reference voltage is used and the internal buffer is
> +disabled. If ``refin-supply`` is present, then the internal buffered reference
> +voltage is used.
> +
> +Reset
> +-----
> +
> +Both hardware and software reset are supported. The driver looks first at the
> +device tree to see if the `reset-gpio` is populated. If not present, the driver
> +will fallback to a software reset by wiring to the device's registers.
> +
> +Unimplemented features
> +----------------------
> +
> +- ``BUSY`` indication
> +- Additional wiring modes
> +- Additional clock modes
> +- Differential data 16-bits + common-mode for 24-bits chips

- overrange event
- test patterns

> +
> diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
> index dfcf9618568a..61faf3a60da6 100644
> --- a/Documentation/iio/index.rst
> +++ b/Documentation/iio/index.rst
> @@ -19,6 +19,7 @@ Industrial I/O Kernel Drivers
>     :maxdepth: 1
>  
>     ad4000
> +   ad4030
>     ad4695
>     ad7380
>     ad7944
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6a5a0e7b7a51..4a076a48648a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -420,6 +420,7 @@ R:	Esteban Blanc <eblanc@baylibre.com>
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> +F:	Documentation/iio/ad4030.c
>  F:	drivers/iio/adc/ad4030.c
>  
>  AD5110 ANALOG DEVICES DIGITAL POTENTIOMETERS DRIVER
> 


