Return-Path: <linux-iio+bounces-5267-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C038CE49D
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 13:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9330A1F2271B
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 11:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557418612C;
	Fri, 24 May 2024 10:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6ehBgYs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E718595A;
	Fri, 24 May 2024 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716548386; cv=none; b=B5stetz5uN7XoW2blyS+j+JnX9S3B1mQPD2mbl9ZWXAiRJV8/Fes23RKq5uSQh5LyvpNz6UXZas2fnB8zuWQe/gSV2ok7mgEocWPQ47R59nGMaQrTPlAohiSP0uNardQGxyjUwpwnphPdkt3RI57Vwo34HijKFlyHnMFwSYJeRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716548386; c=relaxed/simple;
	bh=8WARoMiN5gvNbhNYNg8ZT+NtTT3kbcfIeRCUpMSzQtA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G96KamMGxeZMFtFDjl+3tl7xgchhjvofcQ9Psew/8RR0Jzo0zG+lF1YawQIat4jSAnX+oSJQzP8zt2jxjsfEju0d0hqN/wU3kaBsvHQPs34oMpwjSuaES+AMt0AFSYT9u4zozgFX5T2MOzaXl310pBZsY6u3PGoeYYrRex3taCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6ehBgYs; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e716e302bdso68302251fa.1;
        Fri, 24 May 2024 03:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716548382; x=1717153182; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpCMbWnqmKAOYNqlTbEA9t54S+SeAQuvY5ndecyDVJk=;
        b=i6ehBgYslxnZICln9Lg5WzVRLHhEk4ghRU4oXFj6Vno5PrV8BIXb/obJQlmLpBR1pz
         CpqtxXTSVUopPXAhES4iVcv6Q+eHOz5YpB8xsTcf+aTsxUnqMZlnODyxw6TdXNeLRtJ9
         0uWJyncwkDh2KLZBQMvOQbux3xvuYQ6WlFRclPbMGF6dIaln5okjk8YppclH50cd3HuL
         miTcYdoWE8G7XRO8tfc1xuLdoyFlJUmNFHqOAPl3xKR5aAc0/65Cs9SKN27woTQlplrR
         IfxIvgbLlEW5ycqXuQJ492ubQY2avj5e4TBwdW23bStaDXknh1F28xZLw5xeGGgPQch9
         3m+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716548382; x=1717153182;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xpCMbWnqmKAOYNqlTbEA9t54S+SeAQuvY5ndecyDVJk=;
        b=RsHzI7Ov7RRRYUjySKH4vCZZusqEQ9RsnV4ZGuc8S7vU4nXMGFx2yvM6cliWFLKzX5
         eR0vdy/nboE4psLmwuOhOnBs+5b4SiWSw8Q4ZA9EsV+kCjpq48SX2GPQDAJV9srBIVMC
         j4+jA1aFzttRQD9cK5t8JW1HIiCfviXyuniEwnjdfMoOQeKqsD9oxd5+CTf+3Rp43a8X
         8W3Ct7TSoJC7J/CGdXjOQGgD9MnQeWojphzMIIs161oeVTJJoPId3XQQsm/19S6zCivv
         ZXoeCmIw9qTM51P9gczEPxiZwA5TazwHECkEnt+wINdzEzZXJVv8Co1l1L0gmY/PMNjk
         WwYw==
X-Forwarded-Encrypted: i=1; AJvYcCWfJczTGUv3XxSf+RGAFFisqcb28AYnZkXLgMlLr+LXkznwLeK6lw/WlZJdVdchnqwGZZu1OrXZrdMyPuiNr8uQj8PV9SZVzTZV5BPRJoSDSk51xMPdeDwCg0o7rOuOz7wFwcHcBq8yekohH/Cg359NqdZI8SfOCib0mRwZ/jVXc7YMbA==
X-Gm-Message-State: AOJu0Yw9NyaIKTzUabCP/BT/5y0TfDywVAEIa0mpKHx5Buxgh3vr/prg
	2DXdqJb1XopBfcxavHmxcZXG6uJS6XywbO18a92VQwxx6iXclHT5
X-Google-Smtp-Source: AGHT+IHDtdJ2tpQNnCJQFGEpZ3DhWTWB6o5uQmXxMxNik4X/LGB53ftEhUArWeu5IjfBhjFEGal8bQ==
X-Received: by 2002:a2e:a54d:0:b0:2e9:4b33:dcff with SMTP id 38308e7fff4ca-2e95b0c23acmr11654251fa.29.1716548382297;
        Fri, 24 May 2024 03:59:42 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a1c931csm1323388f8f.79.2024.05.24.03.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 03:59:42 -0700 (PDT)
Message-ID: <18dcd73685535685034346ca1d88fe0f36358dc5.camel@gmail.com>
Subject: Re: [PATCH v4 07/10] iio: imu: adis_trigger: Allow level interrupts
 for FIFO readings
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>, 
	linux-kernel@vger.kernel.org, jic23@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, conor+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, robh@kernel.org, nuno.sa@analog.com
Date: Fri, 24 May 2024 12:59:41 +0200
In-Reply-To: <20240524090030.336427-8-ramona.bolboaca13@gmail.com>
References: <20240524090030.336427-1-ramona.bolboaca13@gmail.com>
	 <20240524090030.336427-8-ramona.bolboaca13@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-24 at 12:00 +0300, Ramona Gradinariu wrote:
> Currently, adis library allows configuration only for edge interrupts,
> needed for data ready sampling.
> This patch removes the restriction for level interrupts for devices
> which have FIFO support.
> Furthermore, in case of devices which have FIFO support,
> devm_request_threaded_irq is used for interrupt allocation, to avoid
> flooding the processor with the FIFO watermark level interrupt, which
> is active until enough data has been read from the FIFO.
>=20
> Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
(much better, IMO, commit message :))

> =C2=A0drivers/iio/imu/adis_trigger.c | 37 ++++++++++++++++++++++++-------=
---
> =C2=A0include/linux/iio/imu/adis.h=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A02 files changed, 27 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigge=
r.c
> index f890bf842db8..a8740b043cfe 100644
> --- a/drivers/iio/imu/adis_trigger.c
> +++ b/drivers/iio/imu/adis_trigger.c
> @@ -34,17 +34,24 @@ static int adis_validate_irq_flag(struct adis *adis)
> =C2=A0	if (adis->data->unmasked_drdy)
> =C2=A0		adis->irq_flag |=3D IRQF_NO_AUTOEN;
> =C2=A0	/*
> -	 * Typically this devices have data ready either on the rising edge or
> -	 * on the falling edge of the data ready pin. This checks enforces that
> -	 * one of those is set in the drivers... It defaults to
> -	 * IRQF_TRIGGER_RISING for backward compatibility with devices that
> -	 * don't support changing the pin polarity.
> +	 * Typically adis devices without FIFO have data ready either on the
> +	 * rising edge or on the falling edge of the data ready pin.
> +	 * IMU devices with FIFO support have the watermark pin level driven
> +	 * either high or low when the FIFO is filled with the desired number
> +	 * of samples.
> +	 * It defaults to IRQF_TRIGGER_RISING for backward compatibility with
> +	 * devices that don't support changing the pin polarity.
> =C2=A0	 */
> =C2=A0	if (direction =3D=3D IRQF_TRIGGER_NONE) {
> =C2=A0		adis->irq_flag |=3D IRQF_TRIGGER_RISING;
> =C2=A0		return 0;
> =C2=A0	} else if (direction !=3D IRQF_TRIGGER_RISING &&
> -		=C2=A0=C2=A0 direction !=3D IRQF_TRIGGER_FALLING) {
> +		=C2=A0=C2=A0 direction !=3D IRQF_TRIGGER_FALLING && !adis->data->has_f=
ifo) {
> +		dev_err(&adis->spi->dev, "Invalid IRQ mask: %08lx\n",
> +			adis->irq_flag);
> +		return -EINVAL;
> +	} else if (direction !=3D IRQF_TRIGGER_HIGH &&
> +		=C2=A0=C2=A0 direction !=3D IRQF_TRIGGER_LOW && adis->data->has_fifo) =
{
> =C2=A0		dev_err(&adis->spi->dev, "Invalid IRQ mask: %08lx\n",
> =C2=A0			adis->irq_flag);
> =C2=A0		return -EINVAL;
> @@ -77,11 +84,19 @@ int devm_adis_probe_trigger(struct adis *adis, struct=
 iio_dev
> *indio_dev)
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	ret =3D devm_request_irq(&adis->spi->dev, adis->spi->irq,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &iio_trigger_generic_data_rdy_po=
ll,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adis->irq_flag,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->name,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adis->trig);
> +	if (adis->data->has_fifo)
> +		ret =3D devm_request_threaded_irq(&adis->spi->dev, adis->spi->irq,
> +						NULL,
> +						&iio_trigger_generic_data_rdy_poll
> ,
> +						adis->irq_flag | IRQF_ONESHOT,
> +						indio_dev->name,
> +						adis->trig);
> +	else
> +		ret =3D devm_request_irq(&adis->spi->dev, adis->spi->irq,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &iio_trigger_generic_data_rdy_p=
oll,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adis->irq_flag,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->name,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adis->trig);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index 8dda3cfa5773..4d4cdbe155b2 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -85,6 +85,7 @@ struct adis_data {
> =C2=A0	bool unmasked_drdy;
> =C2=A0
> =C2=A0	bool has_paging;
> +	bool has_fifo;
> =C2=A0
> =C2=A0	unsigned int burst_reg_cmd;
> =C2=A0	unsigned int burst_len;


