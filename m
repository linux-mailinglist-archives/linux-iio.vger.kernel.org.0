Return-Path: <linux-iio+bounces-8327-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C99B94BC8B
	for <lists+linux-iio@lfdr.de>; Thu,  8 Aug 2024 13:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40D1D1C21303
	for <lists+linux-iio@lfdr.de>; Thu,  8 Aug 2024 11:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B7F18C321;
	Thu,  8 Aug 2024 11:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Af1WgwJe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1622E18A6A1;
	Thu,  8 Aug 2024 11:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723117977; cv=none; b=TNR9quSs5PTyH7d61fkkFcwl0L/PVwUqhjkTsuGjLdfGHXJlim8UCXmcKf2cysHDAe/XGEOvEMKW17AA1LwF2e5h9kgvpX867IWGm/6I4gw7acaWL5JgQcgedRPHJ0JIPSxlnaO9OdbYe6wlKKfojfWhPP2Hfpmj471lLL25U0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723117977; c=relaxed/simple;
	bh=m51EJno8UBesKyQqHvQkOWFtrrSX/ZqToULucSY/DtU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rpli6dnv2drX3Z2nZ18r5NApcvJFwpcqp5OiodKQsFuq3fkuDXbf433GRbtpJdPQkputgFRD3bNiTWmu9FxsOV+3VqnjX4eZm2ollPOuY4pDq58tTsk6P3PbjBd1waB9kc00IoTCf7Wf2e95GB98Tr5IlIydx7YeaZW1uV5awsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Af1WgwJe; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7ab76558a9so129874866b.1;
        Thu, 08 Aug 2024 04:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723117974; x=1723722774; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ac6ETZLxcTe0WIzDXjp8tedta06jKXN2670wajcTqnw=;
        b=Af1WgwJev2JTBMP9KCg/hQ7aEYYRVcE+4E5hoAC6wBt29mjSr3yKYjfbBBxf7opDi0
         njd9nRnAbv/jogpXJIzNrKQ9D+KT+9OKVDkeZl1ew83QkLl3nhznuHD/r2CTtmK6RrVb
         Inozmbt3vLfJUUkh95xkvJXmJv2bOwJDzurv8Hq49Kc0cGaj/dBmWxJCHUZmoRrggZWl
         64hDTpRlWL1SFBEiF2HnT37I6uhTuHAU8l727MhEw0siAKMYjfjyWTgkKhhyJ3Z2NB7t
         jt126A2n6UCarljPAZXSNVoiklt0KIR1VBr/4ZIdhEvGqyPoF1sgIFadRzPuO1ewqKWf
         e99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723117974; x=1723722774;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ac6ETZLxcTe0WIzDXjp8tedta06jKXN2670wajcTqnw=;
        b=JQU8ZvjNE/gz2wEGuGBelUFe0JpvxFiV3Anq+/8olnmRc8/A2Cc7xy1j9e+KMBnI9N
         sPHrEdTFR7C/uYpXpXGW1jGh9oIMBSqePEYx4XUWs46qhXH2ptDPW6MMlwPrYgIUyP6J
         pw0QBY0HH3N2oryC6PGEvy+QrIoQFByS/MKXp908DUzBmGIfVkhWih4ek/clDK6ODCLb
         dYK1TjWqpstvk6gvo3k9+AV9ZLPDW7fuehPrAscvBP+mcsG1YDMPHNHv+uibDSZrw3E3
         l/9Amda9N8EX7oHXYKq3XQ9DYcQmuWkqkKzSv4jE9/nagFlpzRoe81I9MuGNEuMKbaxl
         uWFA==
X-Forwarded-Encrypted: i=1; AJvYcCWnFopM2UPrK5KewdfcFPUa92onnOYmXzwNAopFVK4/sMIpdogK6C3bejbCyZowm3Bv22B+H1q85zmSU5O6qgwkXIhppmocwmJovjxyZkx19xjY7aiC/kyg437sVWeYByUmnnuNwUZ/SvfRP7hq/3+eSSZGUNlJKG8q0+BtjadpnLrgTw==
X-Gm-Message-State: AOJu0YyDu30PTNsG/7/26oIiurx2TEl/vf1k2KMCROYhwnW8cJLtSKpi
	GgrYyPFy59brXM/OotMW73xV+2+AlNOOD7C5mhJ/pU+7VBiDIgOH
X-Google-Smtp-Source: AGHT+IElNtpEkOLei43eBl/uqdJ/2dt8nMmdkf6rNaOiRkgI2oVq7w4E9I17vKegv8fEuyucEa947w==
X-Received: by 2002:a17:907:a0c8:b0:a77:ab9e:9202 with SMTP id a640c23a62f3a-a8091ec7f63mr124650066b.4.1723117974020;
        Thu, 08 Aug 2024 04:52:54 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e80e49sm731594666b.180.2024.08.08.04.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 04:52:53 -0700 (PDT)
Message-ID: <cea14e0a676de59b403185710782a50b1caf6616.camel@gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ad7173: add support for ad4113
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron
	 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: mitrutz_ceclan@gmail.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Dumitru Ceclan
	 <dumitru.ceclan@analog.com>
Date: Thu, 08 Aug 2024 13:56:53 +0200
In-Reply-To: <20240807-ad4113-v1-2-2d338f702c7b@analog.com>
References: <20240807-ad4113-v1-0-2d338f702c7b@analog.com>
	 <20240807-ad4113-v1-2-2d338f702c7b@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-07 at 17:58 +0300, Dumitru Ceclan wrote:
> This commit adds support for the AD4113 ADC.
> The AD4113 is a low power, low noise, 16-bit, =CE=A3-=CE=94 analog-to-dig=
ital
> converter (ADC) that integrates an analog front end (AFE) for four
> fully differential or eight single-ended inputs.
>=20
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7173.c | 22 +++++++++++++++++++++-
> =C2=A01 file changed, 21 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index a854f2d30174..82b63f9705b3 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -3,7 +3,7 @@
> =C2=A0 * AD717x and AD411x family SPI ADC driver
> =C2=A0 *
> =C2=A0 * Supported devices:
> - *=C2=A0 AD4111/AD4112/AD4114/AD4115/AD4116
> + *=C2=A0 AD4111/AD4112/AD4113/AD4114/AD4115/AD4116
> =C2=A0 *=C2=A0 AD7172-2/AD7172-4/AD7173-8/AD7175-2
> =C2=A0 *=C2=A0 AD7175-8/AD7176-2/AD7177-2
> =C2=A0 *
> @@ -84,6 +84,7 @@
> =C2=A0#define AD4111_ID			AD7173_ID
> =C2=A0#define AD4112_ID			AD7173_ID
> =C2=A0#define AD4114_ID			AD7173_ID
> +#define AD4113_ID			0x31D0
> =C2=A0#define AD4116_ID			0x34d0
> =C2=A0#define AD4115_ID			0x38d0
> =C2=A0#define AD7175_8_ID			0x3cd0
> @@ -294,6 +295,23 @@ static const struct ad7173_device_info ad4112_device=
_info
> =3D {
> =C2=A0	.num_sinc5_data_rates =3D ARRAY_SIZE(ad7173_sinc5_data_rates),
> =C2=A0};
> =C2=A0
> +static const struct ad7173_device_info ad4113_device_info =3D {
> +	.name =3D "ad4113",
> +	.id =3D AD4113_ID,
> +	.num_voltage_in_div =3D 8,
> +	.num_channels =3D 16,
> +	.num_configs =3D 8,
> +	.num_voltage_in =3D 8,
> +	.num_gpios =3D 2,
> +	.higher_gpio_bits =3D true,
> +	.has_vincom_input =3D true,
> +	.has_input_buf =3D true,
> +	.has_int_ref =3D true,
> +	.clock =3D 2 * HZ_PER_MHZ,
> +	.sinc5_data_rates =3D ad7173_sinc5_data_rates,
> +	.num_sinc5_data_rates =3D ARRAY_SIZE(ad7173_sinc5_data_rates),
> +};
> +
> =C2=A0static const struct ad7173_device_info ad4114_device_info =3D {
> =C2=A0	.name =3D "ad4114",
> =C2=A0	.id =3D AD4114_ID,
> @@ -1437,6 +1455,7 @@ static int ad7173_probe(struct spi_device *spi)
> =C2=A0static const struct of_device_id ad7173_of_match[] =3D {
> =C2=A0	{ .compatible =3D "adi,ad4111",	.data =3D &ad4111_device_info },
> =C2=A0	{ .compatible =3D "adi,ad4112",	.data =3D &ad4112_device_info },
> +	{ .compatible =3D "adi,ad4113",	.data =3D &ad4113_device_info },
> =C2=A0	{ .compatible =3D "adi,ad4114",	.data =3D &ad4114_device_info },
> =C2=A0	{ .compatible =3D "adi,ad4115",	.data =3D &ad4115_device_info },
> =C2=A0	{ .compatible =3D "adi,ad4116",	.data =3D &ad4116_device_info },
> @@ -1454,6 +1473,7 @@ MODULE_DEVICE_TABLE(of, ad7173_of_match);
> =C2=A0static const struct spi_device_id ad7173_id_table[] =3D {
> =C2=A0	{ "ad4111",=C2=A0=C2=A0 (kernel_ulong_t)&ad4111_device_info },
> =C2=A0	{ "ad4112",=C2=A0=C2=A0 (kernel_ulong_t)&ad4112_device_info },
> +	{ "ad4113",=C2=A0=C2=A0 (kernel_ulong_t)&ad4113_device_info },
> =C2=A0	{ "ad4114",=C2=A0=C2=A0 (kernel_ulong_t)&ad4114_device_info },
> =C2=A0	{ "ad4115",=C2=A0=C2=A0 (kernel_ulong_t)&ad4115_device_info },
> =C2=A0	{ "ad4116",=C2=A0=C2=A0 (kernel_ulong_t)&ad4116_device_info },
>=20


