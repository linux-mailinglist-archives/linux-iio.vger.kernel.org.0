Return-Path: <linux-iio+bounces-24870-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6B8BC8987
	for <lists+linux-iio@lfdr.de>; Thu, 09 Oct 2025 12:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8569B3E5A63
	for <lists+linux-iio@lfdr.de>; Thu,  9 Oct 2025 10:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296FF2DEA72;
	Thu,  9 Oct 2025 10:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZjSHQY9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088F62DD5E2
	for <linux-iio@vger.kernel.org>; Thu,  9 Oct 2025 10:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760007120; cv=none; b=ILxkkriYg+rC2KbN4G6/lGfsmNL2cTxZkn47EUGWwRy+ndevwZ5OM14Nk0giVMBTVMmSYSm+Av/0GU5++A3IpzCKH5OsvPLhqBwmLibCnwOFHXceFbdaIVFBRJ4bO8bgvl2KJJW3Qr0QaDbu7fiESWAEBFMKNfLaqTY6TYAZR4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760007120; c=relaxed/simple;
	bh=vfknTMDXgVpWBYHpareEzORxzMTr1/Dv4VPydOkKGcM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n9xbyxQE9Dt8DVV/RgD/hXHPUYuOkq8XxVpXb3QEZ2MbqteoPuuQC0mhNpD4h+DgeYGykchLAvCvfOoAJxcLH8cfJkKIaimeM3aArQPLeWU94x56FnT5QXH4QyWEuCYzTyjsh0DfwPRGElVYG67zWI1+25vOJ6on1v9WU6fN3Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZjSHQY9; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso589964f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 09 Oct 2025 03:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760007117; x=1760611917; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fzhwfPr8IH3JAjYGlg1q+Z5q36R6fc69tfxSvq2iyoY=;
        b=nZjSHQY9hw4cV8ZE4k2BgKy1tQ2VR9TBCRq53ZTvYoCgDUgCUB6GFg2dWUBJ8tsXwu
         XcJTWE5y94gHQVTygb9dWll004ENny1nCBmjYi6xaQi042yl05pBXc0fwdPvuxMwvP/1
         8+Y9879lH75bsxuRNZW7mDmOHX2mA7tmlQf9PTFufoU7mf0cpcS53TW0G/VeBlYB1ZKo
         zdaSR09/6hzMf0C6Jz+ttBO2cVyPU0OvSX9qRnYOTuEFqnw3e3hdd2O+4E3p1ULHvMnC
         Es/DxQMgxnLwu9sKfiZzQVVH+PlxvtT+GFjtOxEvnNP2WzR2GNNT5EZquJWP3OA8/pYJ
         nKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760007117; x=1760611917;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fzhwfPr8IH3JAjYGlg1q+Z5q36R6fc69tfxSvq2iyoY=;
        b=eB/5oPkJzoS5VG7ad6bmb2IjvI/dV7jId2dwvAdcGraUrIIfw515Osdkl8R2y3bljt
         aLF5yVRyfOCuNbjfXAGHxALL+Imlz5rkdnczAEFPi/gcyMmrTElnWJ5XFh5rLoxg7lMP
         eECshIyYSK3rBrvrxDALJoXacLzVpdQpkDfTQbkTOrx2IfISStj6BekZi/CMreYkhgQe
         jF65KXxvN+AwIgsGB9wBemiVcGhqn48S7EB19SUlpMkaj3FiMbPkyafhccwjDtRlX8Co
         oNK8xIhxSQZgjwFj4bKyclNd8esQjC6VZvmluijD3f3PN+cowUxkMiaWF73o+bNn5iho
         NKNw==
X-Forwarded-Encrypted: i=1; AJvYcCUY7N460Fpfh1NUjpvioaoaFfFslH1zwflWmjte3liiiNyq6DU3469tmosKuGnSRGl44KghZgvuVc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE29C4GophM8AqdUsnISC6o8vKvWlo1HIvn/KmIjvLBTZL0ssL
	LxOwaIaaNMfZEqBBeMOtc2D1RuAzv2mkpSPOi1JnZ2gSBcw1TLd3obJe
X-Gm-Gg: ASbGncvawqdx4DSsKsVMru6u9r23g/JkEiWvnZ4mePP8exSyeKpx/HwRZArDAue9zmw
	WfWLCRv35UIJQfTMeGe0v5kY6quInayi3fXrvvuQCpP6sCdoYoNNPnF9+6p7rudv7kW1P5kOUAn
	F8gkeLNwfS/46QxsLJ8q6PCnlpYOmIdUkuAeJhAuGUXW0RyGdre7XFnBSppqGPsmGmXbvoiOJH+
	zB9DNNuQEA07ydK0QHQmA38FbI9SCYXTHDajO9nuZbSMJuCghxLWmOBK5+VD/7rn7WiVLW+teNd
	jENlAQF7s+aslqv7noeaGKOnqrZTDbcpd0B++wxblJYLE8FIH9lnUoEK4cPdI364VJ7UmobCi5D
	bybOwPerHNWmCqWN592rAWxon3tJN3N8UTEHy0LwAOWkigUJ1NYtNZM4=
X-Google-Smtp-Source: AGHT+IFzo7Sy12QkhXdgDWpNXBsNgGTKCuQI7YZ48lLxGyCuAG1LTD4EclMK4BhgA0Ku8PyppBB1Qw==
X-Received: by 2002:a05:6000:2303:b0:425:72f2:f872 with SMTP id ffacd0b85a97d-4266e7dfe00mr4736180f8f.31.1760007117032;
        Thu, 09 Oct 2025 03:51:57 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f083asm34377348f8f.43.2025.10.09.03.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 03:51:56 -0700 (PDT)
Message-ID: <8d4fc754903c206ff989fc92cde2625b93b1586b.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: health: max30100: Add pulse-width
 configuration via DT
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Shrikant Raskar <raskar.shree97@gmail.com>, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 matt@ranostay.sg, 	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Date: Thu, 09 Oct 2025 11:52:27 +0100
In-Reply-To: <20251008031737.7321-3-raskar.shree97@gmail.com>
References: <20251008031737.7321-1-raskar.shree97@gmail.com>
	 <20251008031737.7321-3-raskar.shree97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Shrikant,

Thanks for your patch.

On Wed, 2025-10-08 at 08:47 +0530, Shrikant Raskar wrote:
> The MAX30100 driver previously hardcoded the SPO2 pulse width to
> 1600us. This patch adds support for reading the pulse width from
> device tree (`maxim,pulse-width-us`) and programming it into the SPO2
> configuration register.
>=20
> If no property is provided, the driver falls back to 1600us to
> preserve existing behavior.
>=20
> Testing:
> Hardware: Raspberry Pi 3B + MAX30100 breakout
> Verified DT property read in probe()
> Confirmed SPO2_CONFIG register written correctly using regmap_read()
>=20
> Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
>=20
> Changes since v1:
> Use FIELD_PREP() and define a pulse width bit mask.
> Initialize default pulse_us before property read.
> Use dev_err_probe() for error reporting.
> Make pulse_width signed to handle negative return values.
>=20
> Link to v1:
> https://lore.kernel.org/all/20251004015623.7019-3-raskar.shree97@gmail.co=
m/

As mentioned in the bindings patch, this is not place for changelog. With t=
hat
fixed:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> ---
> =C2=A0drivers/iio/health/max30100.c | 35 ++++++++++++++++++++++++++++++++=
+--
> =C2=A01 file changed, 33 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.=
c
> index 814f521e47ae..50cd4fd13849 100644
> --- a/drivers/iio/health/max30100.c
> +++ b/drivers/iio/health/max30100.c
> @@ -5,7 +5,6 @@
> =C2=A0 * Copyright (C) 2015, 2018
> =C2=A0 * Author: Matt Ranostay <matt.ranostay@konsulko.com>
> =C2=A0 *
> - * TODO: enable pulse length controls via device tree properties
> =C2=A0 */
> =C2=A0
> =C2=A0#include <linux/module.h>
> @@ -54,6 +53,10 @@
> =C2=A0#define MAX30100_REG_SPO2_CONFIG		0x07
> =C2=A0#define MAX30100_REG_SPO2_CONFIG_100HZ		BIT(2)
> =C2=A0#define MAX30100_REG_SPO2_CONFIG_HI_RES_EN	BIT(6)
> +#define MAX30100_REG_SPO2_CONFIG_PW_MASK	GENMASK(1, 0)
> +#define MAX30100_REG_SPO2_CONFIG_200US		0x0
> +#define MAX30100_REG_SPO2_CONFIG_400US		0x1
> +#define MAX30100_REG_SPO2_CONFIG_800US		0x2
> =C2=A0#define MAX30100_REG_SPO2_CONFIG_1600US		0x3
> =C2=A0
> =C2=A0#define MAX30100_REG_LED_CONFIG			0x09
> @@ -306,19 +309,47 @@ static int max30100_led_init(struct max30100_data *=
data)
> =C2=A0		MAX30100_REG_LED_CONFIG_LED_MASK, reg);
> =C2=A0}
> =C2=A0
> +static int max30100_get_pulse_width(unsigned int pwidth_us)
> +{
> +	switch (pwidth_us) {
> +	case 200:
> +		return MAX30100_REG_SPO2_CONFIG_200US;
> +	case 400:
> +		return MAX30100_REG_SPO2_CONFIG_400US;
> +	case 800:
> +		return MAX30100_REG_SPO2_CONFIG_800US;
> +	case 1600:
> +		return MAX30100_REG_SPO2_CONFIG_1600US;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> =C2=A0static int max30100_chip_init(struct max30100_data *data)
> =C2=A0{
> =C2=A0	int ret;
> +	int pulse_width;
> +	/* set default pulse-width-us to 1600us */
> +	unsigned int pulse_us =3D 1600;
> +	struct device *dev =3D &data->client->dev;
> =C2=A0
> =C2=A0	/* setup LED current settings */
> =C2=A0	ret =3D max30100_led_init(data);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> +	/* Read pulse-width-us from DT */
> +	device_property_read_u32(dev, "maxim,pulse-width-us", &pulse_us);
> +
> +	pulse_width =3D max30100_get_pulse_width(pulse_us);
> +	if (pulse_width < 0)
> +		return dev_err_probe(dev, pulse_width, "invalid pulse-width
> %uus\n", pulse_us);
> +
> =C2=A0	/* enable hi-res SPO2 readings at 100Hz */
> =C2=A0	ret =3D regmap_write(data->regmap, MAX30100_REG_SPO2_CONFIG,
> =C2=A0				 MAX30100_REG_SPO2_CONFIG_HI_RES_EN |
> -				 MAX30100_REG_SPO2_CONFIG_100HZ);
> +				 MAX30100_REG_SPO2_CONFIG_100HZ |
> +				 FIELD_PREP(MAX30100_REG_SPO2_CONFIG_PW_MASK,
> pulse_width));
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0

