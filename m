Return-Path: <linux-iio+bounces-5817-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0B58FC7B1
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 11:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE761C21144
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 09:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711D7190046;
	Wed,  5 Jun 2024 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGVgWQRw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A784190042;
	Wed,  5 Jun 2024 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717579347; cv=none; b=PXOfXimfQNqQxmGYg1gYF4hVE8WSRuWgAzlE+T9ORMUECOi1CiR16zJ4X3b9Zq1+LCg8PU7W7vyZn++toz/pyvEEFyr3hZlT0+Pj5s6fo67/3acfwf+KC+2gJXbdomit8XRbZJ62S0yxu+MuARCMiHN+YejK4FbqrbAJI6lMICQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717579347; c=relaxed/simple;
	bh=7s6t1Mnf8SbzZuVJD1mxOTK+vEECHY45ZPjTcNlLR8o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ASsX+7zbAiYxm9rZc7tflTk7odvria6ElkwL7hEyNC3QYHVnm2xfoQmZw4ZBCSeGmgdTjsY5/Ep9KI4COp2iqMDhnWg8FJVx9iZVeZpbZXMam9Pk2hlanY2C2zv2N067p8MK/NtcJNRpLXtdd4/SyT9DB/HdimqRzKJ86++sySg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGVgWQRw; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52b94ad88cbso5593343e87.0;
        Wed, 05 Jun 2024 02:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717579344; x=1718184144; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=twGgOCLKhNQgk0EX+r3D2ZUgLeCpTZK046ZKeffQQRs=;
        b=BGVgWQRw3EoUxdzEC80/jZeuLQnIi+FwwTbW3Rk6G0Zngb3/KhkYjJuTI4BDNvONP5
         SA/5o9QmQRgGffcbJykkXS5TW2CTLrcEVYsIQc02YpWUm+rcuucZXH5J68xZZnWuuMCn
         zNPCxe77RmvBTChypbbJB0HKN8bVs58lRHV7S7e7inE0UmYebL7q1uruJFxXtxfdQEc9
         pDcP6lcG/6UNo0xjCSR26fdA2euMX5lmpPxnJVoUaqeOTCA65HHkIEav6+UHQ2z+26ox
         +6MWdCvfHUiQRQG/kx57Z4J/KtoKiNpx1p34gvbR8TqEfGHjR3jTrVISGi28OzWMPexD
         tRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717579344; x=1718184144;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=twGgOCLKhNQgk0EX+r3D2ZUgLeCpTZK046ZKeffQQRs=;
        b=L3qZxxQb6ZTAMCJIqY8kAB3Gpuz+m4v2xsCrDb0zbhDs+koJVmYMZWkwoToIXCHiSE
         poJ8YM9fD9lW6mUeqnYJ0XtiLvpPljYJtMFxCDWe57xBZRjT0O7oFsk5O4trjNgDGcSX
         CcEyDvCh1QylOg22K3V02Cq6aLYJtqFoeFvRYaRPwzmhdtbt+RkJeshRyflGX/yGWSMq
         8FSX/eSH4FMgv73N/G2rDR0DXKGlq9+z4fb5lUZZ+BBqBdJj55Soq7lmlwqhbr4MsSGY
         ISOVg6kvIxV2lG1YjcG//cXKYFm43v8IKypLzyGswWdG6aAYIrkc/ZACXS41kMBuxLzA
         46XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg/6pGRP3yQyNABnN9CVvyLGg1zOi38KcdhzEa/GYo9WEbsgk2iRSXggfejN//ow3KpUNAQT9KkGFzI6vnzXcp2WLZVvYo9qhrBPa7wV4jkzelqQEtGmxe8+q/BbRBbNA23OTMqhlTPUZ8fX7p6szXraf3Q7Su0ntPJr/Aw2kCBj+0ZA==
X-Gm-Message-State: AOJu0YxfsaJzhfcZOc4XtVaxE4rnpAEgNReUv3qEwDsFpHSAFAphAH6d
	nW7Gd3zn1/Nvv6mPPL/cn4S45kHh3aKwUu1YcEX08NVXDGq9kZbJ
X-Google-Smtp-Source: AGHT+IEOSN3eOE6QTScDMEugLdJr/Qsk0h/HBGjFFfNTZIUO5vTuVaWsW0uqFg0hkRGfKw62h3H/WQ==
X-Received: by 2002:a05:6512:3194:b0:52b:9964:9dae with SMTP id 2adb3069b0e04-52bab50b1abmr1657988e87.57.1717579343365;
        Wed, 05 Jun 2024 02:22:23 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a685b935b5csm709003866b.206.2024.06.05.02.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 02:22:23 -0700 (PDT)
Message-ID: <996a88c057dd2b6b4d960fbe9f8e35bd69270e86.camel@gmail.com>
Subject: Re: [PATCH v3 3/6] spi: spi-gpio: Add support for MOSI idle state
 configuration
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org, 
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
  nuno.sa@analog.com, dlechner@baylibre.com, marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 05 Jun 2024 11:26:09 +0200
In-Reply-To: <8dcce41a69a89cb8ace2587ca7ddb1c665f2d1cb.1717539384.git.marcelo.schmitt@analog.com>
References: <cover.1717539384.git.marcelo.schmitt@analog.com>
	 <8dcce41a69a89cb8ace2587ca7ddb1c665f2d1cb.1717539384.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-04 at 19:42 -0300, Marcelo Schmitt wrote:
> Implement MOSI idle low and MOSI idle high to better support peripherals
> that request specific MOSI behavior.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

Acked-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/spi/spi-gpio.c | 12 +++++++++++-
> =C2=A01 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
> index 909cce109bba..d3b8c99f0cb4 100644
> --- a/drivers/spi/spi-gpio.c
> +++ b/drivers/spi/spi-gpio.c
> @@ -236,6 +236,14 @@ static void spi_gpio_chipselect(struct spi_device *s=
pi,
> int is_active)
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +static void spi_gpio_set_mosi_idle(struct spi_device *spi)
> +{
> +	struct spi_gpio *spi_gpio =3D spi_to_spi_gpio(spi);
> +
> +	gpiod_set_value_cansleep(spi_gpio->mosi,
> +				 !!(spi->mode & SPI_MOSI_IDLE_HIGH));
> +}
> +
> =C2=A0static int spi_gpio_setup(struct spi_device *spi)
> =C2=A0{
> =C2=A0	struct gpio_desc	*cs;
> @@ -411,7 +419,8 @@ static int spi_gpio_probe(struct platform_device *pde=
v)
> =C2=A0
> =C2=A0	host->bits_per_word_mask =3D SPI_BPW_RANGE_MASK(1, 32);
> =C2=A0	host->mode_bits =3D SPI_3WIRE | SPI_3WIRE_HIZ | SPI_CPHA | SPI_CPO=
L |
> -			=C2=A0=C2=A0=C2=A0 SPI_CS_HIGH | SPI_LSB_FIRST;
> +			=C2=A0 SPI_CS_HIGH | SPI_LSB_FIRST | SPI_MOSI_IDLE_LOW |
> +			=C2=A0 SPI_MOSI_IDLE_HIGH;
> =C2=A0	if (!spi_gpio->mosi) {
> =C2=A0		/* HW configuration without MOSI pin
> =C2=A0		 *
> @@ -436,6 +445,7 @@ static int spi_gpio_probe(struct platform_device *pde=
v)
> =C2=A0	host->flags |=3D SPI_CONTROLLER_GPIO_SS;
> =C2=A0	bb->chipselect =3D spi_gpio_chipselect;
> =C2=A0	bb->set_line_direction =3D spi_gpio_set_direction;
> +	bb->set_mosi_idle =3D spi_gpio_set_mosi_idle;
> =C2=A0
> =C2=A0	if (host->flags & SPI_CONTROLLER_NO_TX) {
> =C2=A0		bb->txrx_word[SPI_MODE_0] =3D spi_gpio_spec_txrx_word_mode0;


