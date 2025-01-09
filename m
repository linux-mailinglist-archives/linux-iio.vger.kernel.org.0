Return-Path: <linux-iio+bounces-14061-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E391A07F33
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2025 18:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71AC160A95
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2025 17:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD3A18F2D8;
	Thu,  9 Jan 2025 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWGWZGiD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F34C2B9BF;
	Thu,  9 Jan 2025 17:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444771; cv=none; b=gBAaesV6Pnru2+EjaqNn/LnbqHAjvXePiH/JaIaWFJ/6SdCCDmDdSkesQC0NT6xQft5VmYGBbyxUjFXi2/XUlngwMpnNutRAObMh20JAwzACQGadjFI31M1fWCAhMBUM2SGhLTHBLP4xjTNKD64Emoq/P7hj8vwmAVkqcLawv/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444771; c=relaxed/simple;
	bh=ZndwmafwOMF5to92SA7j465cHU0STURJmQfFDkKpSf8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=UDKe8dxdF0cjF/HHlMZ+jr3bFVcqUhiUbpnQDG+6ENSJNN5Ny0tmoZ9wKcNfXpjRZmv5XQALL+HEo28G1XwmJU4VEnFCk6Q49T52FU8gbmmgect0lxgya01IxzsV0HiDzlOFfa7b4YXZ+pvOTm7XG8a8AefN0UQNUxDaqgyd3B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWGWZGiD; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa679ad4265so425773166b.0;
        Thu, 09 Jan 2025 09:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736444768; x=1737049568; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/VRFUEeTV05SgIJ94Suveg0Jh5bt0tpTPkvmu/VFZA=;
        b=LWGWZGiDrOENzjYr46+nTkLTpP+3a+Z+/UABTNSZbgiCAEY/KLNsnYtGEKcXbqX0hy
         1AHq53Fu+fhf1pjVqbZAvYCYTgBl1dFW0+dSoMyxXaq4TYqDuRRRvofpRaD+5TkzuHzC
         k9OXcpONRRLsD3pQ+ydIq10pC1qUCDzJw8VsosppTe+YOl/bH590APsi8xkoARMw5izT
         rcqeiAJLyiNG2flCWoaA6psPJxTsQbmF+mtyZprlzRDETfBYuYKYHVhcc7jAKyFH9d+N
         oKExoY14bVInF+H4ySxfUe6vYaE336xu8su0JiEumLCLgR8Lgh8AR50VciEhHQsnvh2H
         XANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736444768; x=1737049568;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1/VRFUEeTV05SgIJ94Suveg0Jh5bt0tpTPkvmu/VFZA=;
        b=nO3k6MEYqA21TSqk35E850ntgJRBUu3TDEiE1dvGXF7MuPt/HAThP3zEWH3J8WcVJE
         B7zxqIWThdrggaz6q7+ryEBPps75HIh4FNnXy6elKdy+2+w+QQJd8HyyCyBBTZRCgC4s
         JWEoxuCqyHbFAh9krUpt3FEHX2xPaDY//oY/UGst/NMXnoBiNQDWdJ0ILJcIf5cEXgHg
         cErrF811JT86DfOPU3/LPF/kxCsZwldvnIiHC1UWnkl+bAfJaJMs40b/4cdAaJ88lPw3
         Ip+fDoJZnImPlWKzGwCo4NQy436NCNNJE7jr3VBo60FWCXD1nY2rnis5YnykUoswzAxE
         gL7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXoGaJuf+L7lIRGFhmpciZq90e88sT+dtiT6L+4P2U/FbXTfd8XZZJxgKcWD76z/3OfA6UlMiCRO92n1/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Eo936dT0XMeFciDwg8fFPNghrGpCcrpTOff9aHSjQ4r8nXn2
	KC+yVz45CYioYuuk3fssqhgjZXoOLjIfb8rf3XzUMlnr0BnsGQWl
X-Gm-Gg: ASbGncufJubpayca6RI1inx4sG+ntZfjBOC5ukgxjMDailxSPjHbZ73/cJZKkBiOTyd
	I0duMeSNLUigcZWcwJ/lTqt4/jpMj8hAlrccnp4IPw1vpcKEYIPbHg5FB0oRIGgX9IF04QfcyC2
	wFdLx6zgcOA/sQ+c5QWZeFSiq2cjwtRst+kYna75RRMt4usz43tD70uFk3z/OIdkCKgSkZsYyIP
	Dz3/2hX48ZmNYspsBV/VmVyjh9JKi7kQrx1NWSBX+q3KJocMzKcmfDpcbMP76VNUGil
X-Google-Smtp-Source: AGHT+IFIb7g3R+aPaZbENmuy0CajDrapfuU2aNjb1LWaHhcsXC/3wZ9G6Z1mPyX+R6/CUf2f8hL8Jg==
X-Received: by 2002:a17:907:7b86:b0:aa6:8dcb:365b with SMTP id a640c23a62f3a-ab2c3c5c979mr327770966b.5.1736444767935;
        Thu, 09 Jan 2025 09:46:07 -0800 (PST)
Received: from localhost ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c90da0fcsm91734366b.75.2025.01.09.09.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 09:46:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Jan 2025 18:46:04 +0100
Message-Id: <D6XQAOD82DOG.2089OLZ6S12LT@gmail.com>
Subject: Re: [PATCH 2/2] iio: light: veml6030: fix scale to conform to ABI
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
To: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "Lars-Peter Clausen" <lars@metafoo.de>, "Rishi Gupta"
 <gupt21@gmail.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.18.2
References: <20250107-veml6030-scale-v1-0-1281e3ad012c@gmail.com>
 <20250107-veml6030-scale-v1-2-1281e3ad012c@gmail.com>
In-Reply-To: <20250107-veml6030-scale-v1-2-1281e3ad012c@gmail.com>

On Tue Jan 7, 2025 at 9:50 PM CET, Javier Carrasco wrote:
> The current scale is not ABI-compliant as it is just the sensor gain
> instead of the value that acts as a multiplier to be applied to the raw
> value (there is no offset).
>
> Use the iio-gts helpers to obtain the proper scale values according to
> the gain and integration time to match the resolution tables from the
> datasheet and drop dedicated variables to store the current values of
> the integration time, gain and resolution. When at it, use 'scale'
> instead of 'gain' consistently for the get/set functions to avoid
> misunderstandings.
>
> Fixes: 7b779f573c48 ("iio: light: add driver for veml6030 ambient light s=
ensor")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/iio/light/Kconfig    |   1 +
>  drivers/iio/light/veml6030.c | 499 ++++++++++++++++---------------------=
------
>  2 files changed, 189 insertions(+), 311 deletions(-)
>
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index e34e551eef3e8db006de56724ce3873c07b3360a..eb7f56eaeae07c8b021dc7c0d=
b87f46b44ed44d7 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -683,6 +683,7 @@ config VEML6030
>  	select REGMAP_I2C
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
> +	select IIO_GTS_HELPER
>  	depends on I2C
>  	help
>  	  Say Y here if you want to build a driver for the Vishay VEML6030
> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
> index a6385c6d3fba59a6b22845a3c5e252b619faed65..99c7e073ea664f815a7b1c1bc=
829a8eff66fd323 100644
> --- a/drivers/iio/light/veml6030.c
> +++ b/drivers/iio/light/veml6030.c
> @@ -24,10 +24,12 @@
>  #include <linux/regmap.h>
>  #include <linux/interrupt.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/units.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/events.h>
> +#include <linux/iio/iio-gts-helper.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
>
> @@ -72,14 +74,10 @@ struct veml6030_rf {
>
>  struct veml603x_chip {
>  	const char *name;
> -	const int(*scale_vals)[][2];
> -	const int num_scale_vals;
>  	const struct iio_chan_spec *channels;
>  	const int num_channels;
>  	int (*hw_init)(struct iio_dev *indio_dev, struct device *dev);
>  	int (*set_info)(struct iio_dev *indio_dev);
> -	int (*set_als_gain)(struct iio_dev *indio_dev, int val, int val2);
> -	int (*get_als_gain)(struct iio_dev *indio_dev, int *val, int *val2);
>  	int (*regfield_init)(struct iio_dev *indio_dev);
>  };
>
> @@ -98,40 +96,55 @@ struct veml6030_data {
>  	struct i2c_client *client;
>  	struct regmap *regmap;
>  	struct veml6030_rf rf;
> -	int cur_resolution;
> -	int cur_gain;
> -	int cur_integration_time;
>  	const struct veml603x_chip *chip;
> +	struct iio_gts gts;
> +
>  };
>
> -static const int veml6030_it_times[][2] =3D {
> -	{ 0, 25000 },
> -	{ 0, 50000 },
> -	{ 0, 100000 },
> -	{ 0, 200000 },
> -	{ 0, 400000 },
> -	{ 0, 800000 },
> +#define VEML6030_SEL_IT_25MS  0x0C
> +#define VEML6030_SEL_IT_50MS  0x08
> +#define VEML6030_SEL_IT_100MS 0x00
> +#define VEML6030_SEL_IT_200MS 0x01
> +#define VEML6030_SEL_IT_400MS 0x02
> +#define VEML6030_SEL_IT_800MS 0x03
> +static const struct iio_itime_sel_mul veml6030_it_sel[] =3D {
> +	GAIN_SCALE_ITIME_US(25000, VEML6030_SEL_IT_25MS, 1),
> +	GAIN_SCALE_ITIME_US(50000, VEML6030_SEL_IT_50MS, 2),
> +	GAIN_SCALE_ITIME_US(100000, VEML6030_SEL_IT_100MS, 4),
> +	GAIN_SCALE_ITIME_US(200000, VEML6030_SEL_IT_200MS, 8),
> +	GAIN_SCALE_ITIME_US(400000, VEML6030_SEL_IT_400MS, 16),
> +	GAIN_SCALE_ITIME_US(800000, VEML6030_SEL_IT_800MS, 32),
>  };
>
> -/*
> - * Scale is 1/gain. Value 0.125 is ALS gain x (1/8), 0.25 is
> - * ALS gain x (1/4), 0.5 is ALS gain x (1/2), 1.0 is ALS gain x 1,
> - * 2.0 is ALS gain x2, and 4.0 is ALS gain x 4.
> +/* Gains are multiplied by 8 to work with integers. The values in the
> + * iio-gts tables don't need corrections because the maximum value of
> + * the scale refers to GAIN =3D x1, and the rest of the values are
> + * obtained from the resulting linear function.
>   */
> -static const int veml6030_scale_vals[][2] =3D {
> -	{ 0, 125000 },
> -	{ 0, 250000 },
> -	{ 1, 0 },
> -	{ 2, 0 },
> +#define VEML6030_SEL_GAIN_X125  2
> +#define VEML6030_SEL_GAIN_X250  3
> +#define VEML6030_SEL_GAIN_X1000 0
> +#define VEML6030_SEL_GAIN_X2000 1
> +static const struct iio_gain_sel_pair veml6030_gain_sel[] =3D {
> +	GAIN_SCALE_GAIN(1, VEML6030_SEL_GAIN_X125),
> +	GAIN_SCALE_GAIN(2, VEML6030_SEL_GAIN_X250),
> +	GAIN_SCALE_GAIN(8, VEML6030_SEL_GAIN_X1000),
> +	GAIN_SCALE_GAIN(16, VEML6030_SEL_GAIN_X2000),
>  };

While working on a driver with a similar approach, I noticed that the
names don't reflect the fact that those values are in MILLI. I will
change them to VEML6030_SEL_MILLI_GAIN_* for v2 alongside any other
issues that might have been found during the review.

Best regards,
Javier Carrasco

