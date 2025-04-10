Return-Path: <linux-iio+bounces-17905-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E884EA83F6F
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 11:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4230448198
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 09:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6EA268684;
	Thu, 10 Apr 2025 09:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azKE0pTe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43860269D0C;
	Thu, 10 Apr 2025 09:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744278798; cv=none; b=BPHMXTh98YDMC+i/O1ilid2nMrscPSbxEUinumurOH6nJ5vn2VtQ2opE+ap4CNsHZDWtj66MVLgySExGuskiZN+rcBPQxIUJWuko/ZUKUMIWe0OL9Y23wwtQMwor8zkldyF4Hb8aoaTmPb4bgAmu/m1HYbe3ZguAEo93sN6SJEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744278798; c=relaxed/simple;
	bh=jfdZoHdvb1PYe6Xj1zXtn7WtPaT6dulwA78Y/DWrCWs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VpTcOW/GuBsRcSvyrxUEj+lvoX8ipfd7BQ0/xHOzKINb28iBWX14WFDfYG5HZvtcIr5BHFgrPakKDMFlgqjXFYmLtgZOeYxxUk+JPMJUTySFc5x2i6Gw7gXEM4g0iLHTTflYNUB+KdeTJOXOipIj5jRWL4Tkfw49ZHod7V+gZ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azKE0pTe; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so11832225e9.1;
        Thu, 10 Apr 2025 02:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744278793; x=1744883593; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LPGXt0g52MME06VHiwLRnezmorxd1sA0KqT649GrFg4=;
        b=azKE0pTeXGd35ChbsYK+kDnerAL012us9Tntft+919ik903Qi1e3+gqQDw0b0CdnEr
         vpxiTrkO8hidg7UcLfgwow7omIf1aZDhIw0+KkJvPSfILsRGZcNakLmd1ZWoidW5vpYO
         5SY75auBDAedmrBgiM9DR0lG56HB2jVUond2qfmw4ujeewXMzoT/JieQvodqVhh+nk4o
         Ga4G5khxGdFn7B3oMKx8jr2wyUz2/P8eTcG8pr94fUKA3FsxTF+cITxSBEqKi9JmLftj
         JhgTqmg303jJ/cPgolfIYE4X5gJ/nQX2un0yRvUFOi8KRjRe7jmGjYc0i2KRXES9NR2b
         ke+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744278793; x=1744883593;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LPGXt0g52MME06VHiwLRnezmorxd1sA0KqT649GrFg4=;
        b=pjPI52gUiKBf3y0MYnle64n7WWadjzRhnxm31AtlZ8FHgoMibK+mH5IJH9mhaZFmQc
         Z7Z7VB83diCN+5NnRO+4ce0/w6FamMSoX2xPuuvl+q1nvqmWCbOhWUPelZk06yzazgnn
         WW7cyob/OtBBGCoJS8gOPKbNilQ4VFZQbt0pdAzM6JRD/uHIYNQe9O+yR4GMKUL3YC1X
         NGXg1+Q8n/0FiTpIoTQ/4LD/R4aKHWQ+M25svKZxiqAhuvM5qYvsVHSHdjqx5pp+j/fL
         CJhl4+aSucmqNFHm9wszJZP6rYhFmRqO6HmmMPJhRiiqxdhJRr5x/k+TEg7+6zu2lkbx
         VsFg==
X-Forwarded-Encrypted: i=1; AJvYcCU97jabuUFws/C9mf4t+4tZol4qrRQXdmacrhqkDCSksTngn5oCkclMkk8j0s8ddJlwZrD71eDch903dDk4@vger.kernel.org, AJvYcCU9LSCoW7k2Dgl/F8jEXsWyYz0NLoz6wCxdqnvUrJXiPJGOjrG4CmvXTFwPtOwWqcsRMebFBQ2coQzC@vger.kernel.org, AJvYcCWMNHMvKiiaJthXKqdct4sDsKC3Exj5QGOog13oJna38Px1nfZ0pO0vsNiQeeV/I2xXwLSfRBmpvOpZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxELaR38jWTdJoI9pXPPVNwZBaoQIE3c3Q5GsugcRdMeimujRwG
	+xrBKXViTeafcqBdSVu7yx+jVtpi+hFePWltVtrsqbCXw0P6RaAL
X-Gm-Gg: ASbGncsI5xSajZG3rzQAenGokAJI4Iz8Hbxsqeg7kaIMJx7Q9VZVBwj0L1NRraWzsed
	foc5PU2QRiksnUvf7YjrazQrdLrM9BhjaEDxVtYlr65fjc1Mc7Hc5/p1ljMZIXR151aIOMZjpeK
	MuWaXK/sY2+29VFIx8tgJz8Z98aliEhGe3K/sjKSik2joX/nRClQ0WmwDK1xB4f6VgLOMGt/STP
	hHQT9qTlnNVNK308+mNZ3SWZsSaKI6HPeg5MR6mVkC3B80QnazABxvMB/8UhOvSYctoFtK87etF
	m8oaNqC1EwjaCNwPBpw77bS04rtLJV1VRrH81U4DPgOurYWIwXTjze0H5X1KnAxpXKDyayZEmTF
	LmR/jlaXbK8TVyoK8FAnp2GQ=
X-Google-Smtp-Source: AGHT+IHDmjbsYU+B1fjfn/G/QUfgle5G1tQDw1CIm/Z+8igoCnblxyBawgAULO7NrWNfMep+0ARwaQ==
X-Received: by 2002:a05:600c:a012:b0:43c:f3e1:a729 with SMTP id 5b1f17b1804b1-43f2eb50f83mr19991235e9.12.1744278793256;
        Thu, 10 Apr 2025 02:53:13 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f20a303absm34971915e9.1.2025.04.10.02.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 02:53:12 -0700 (PDT)
Message-ID: <6669da27c78714d76ff21f810cd57045e90d701a.camel@gmail.com>
Subject: Re: [PATCH v1 5/7] iio: adc: ad4170: Add GPIO controller support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, 	krzk+dt@kernel.org, conor+dt@kernel.org,
 marcelo.schmitt1@gmail.com
Date: Thu, 10 Apr 2025 10:53:14 +0100
In-Reply-To: <247566f848cdf2a245a8b6da6a84c22e155beeb7.1744200264.git.marcelo.schmitt@analog.com>
References: <cover.1744200264.git.marcelo.schmitt@analog.com>
	 <247566f848cdf2a245a8b6da6a84c22e155beeb7.1744200264.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-04-09 at 09:25 -0300, Marcelo Schmitt wrote:
> The AD4170 has four multifunctional pins that can be used as GPIOs. The
> GPIO functionality can be accessed when the AD4170 chip is not busy
> performing continuous data capture or handling any other register
> read/write request. Also, the AD4170 does not provide any interrupt based
> on GPIO pin states so AD4170 GPIOs can't be used as interrupt sources.
>=20
> Implement gpio_chip callbacks so to make AD4170 GPIO pins controllable
> through the gpiochip interface.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

Just some doubts, see below...

> =C2=A0drivers/iio/adc/ad4170.c | 167 ++++++++++++++++++++++++++++++++++++=
++-
> =C2=A01 file changed, 166 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
> index 97cf4465038f..b382e7f3dbe0 100644
> --- a/drivers/iio/adc/ad4170.c
> +++ b/drivers/iio/adc/ad4170.c
> @@ -12,6 +12,7 @@
> =C2=A0#include <linux/delay.h>
> =C2=A0#include <linux/device.h>
> =C2=A0#include <linux/err.h>
> +#include <linux/gpio/driver.h>
> =C2=A0#include <linux/iio/buffer.h>
> =C2=A0#include <linux/iio/iio.h>
> =C2=A0#include <linux/iio/sysfs.h>
> @@ -79,6 +80,7 @@
> =C2=A0#define AD4170_FIR_CTRL					0x141
> =C2=A0#define AD4170_COEFF_DATA_REG				0x14A
> =C2=A0#define AD4170_COEFF_ADDR_REG				0x14C
> +#define AD4170_GPIO_MODE_REG				0x191
> =C2=A0#define AD4170_GPIO_OUTPUT_REG				0x193
> =C2=A0#define AD4170_GPIO_INPUT_REG				0x195
> =C2=A0
> @@ -189,6 +191,7 @@
> =C2=A0/* Device properties and auxiliary constants */
> =C2=A0
> =C2=A0#define AD4170_NUM_ANALOG_PINS				9
> +#define AD4170_NUM_GPIO_PINS				4
> =C2=A0#define AD4170_MAX_CHANNELS				16
> =C2=A0#define AD4170_MAX_ANALOG_PINS				8
> =C2=A0#define AD4170_MAX_SETUPS				8
> @@ -340,6 +343,7 @@ struct ad4170_state {
> =C2=A0	struct clk *ext_clk;
> =C2=A0	struct clk_hw int_clk_hw;
> =C2=A0	int pins_fn[AD4170_NUM_ANALOG_PINS];
> +	struct gpio_chip gpiochip;
> =C2=A0	u32 int_pin_sel;
> =C2=A0	int
> sps_tbl[ARRAY_SIZE(ad4170_filt_names)][AD4170_MAX_FS_TBL_SIZE][2];
> =C2=A0	struct completion completion;
> @@ -1553,6 +1557,156 @@ static int ad4170_soft_reset(struct ad4170_state =
*st)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static int ad4170_gpio_get(struct gpio_chip *gc, unsigned int offset)
> +{
> +	struct iio_dev *indio_dev =3D gpiochip_get_data(gc);
> +	struct ad4170_state *st =3D iio_priv(indio_dev);
> +	unsigned int val;
> +	int ret;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +
> +	ret =3D regmap_read(st->regmap16, AD4170_GPIO_MODE_REG, &val);
> +	if (ret)
> +		goto err_release;
> +
> +	/*
> +	 * If the GPIO is configured as an input, read the current value from
> +	 * AD4170_GPIO_INPUT_REG. Otherwise, read the input value from
> +	 * AD4170_GPIO_OUTPUT_REG.
> +	 */
> +	if (val & BIT(offset * 2))
> +		ret =3D regmap_read(st->regmap16, AD4170_GPIO_INPUT_REG, &val);
> +	else
> +		ret =3D regmap_read(st->regmap16, AD4170_GPIO_OUTPUT_REG,
> &val);
> +	if (ret)
> +		goto err_release;
> +
> +	ret =3D !!(val & BIT(offset));
> +err_release:
> +	iio_device_release_direct(indio_dev);
> +
> +	return ret;
> +}
> +
> +static int ad4170_gpio_set(struct gpio_chip *gc, unsigned int offset, in=
t
> value)
> +{
> +	struct iio_dev *indio_dev =3D gpiochip_get_data(gc);
> +	struct ad4170_state *st =3D iio_priv(indio_dev);
> +	unsigned int val;
> +	int ret;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +
> +	ret =3D regmap_read(st->regmap16, AD4170_GPIO_MODE_REG, &val);
> +	if (ret)
> +		goto err_release;
> +
> +	if (val & BIT(offset * 2 + 1))

Why do we need this? Are we checking if it's a GPO? If so, we should return
-EPERM in case we have a GPI?
=20
> +		ret =3D regmap_update_bits(st->regmap16,
> AD4170_GPIO_OUTPUT_REG,
> +					 BIT(offset), value << offset);
> +
> +err_release:
> +	iio_device_release_direct(indio_dev);
> +	return ret;
> +}
> +
> +static int ad4170_gpio_get_direction(struct gpio_chip *gc, unsigned int
> offset)
> +{
> +	struct iio_dev *indio_dev =3D gpiochip_get_data(gc);
> +	struct ad4170_state *st =3D iio_priv(indio_dev);
> +	unsigned int val;
> +	int ret;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +

This claim_direct() makes me wonder if there's any overlap between the GPIO=
 func
and normal readings? Like, imagine a consumer requests a gpio and no buffer=
ing
is happening so all is good. However, there's nothing stopping us for enabl=
ing
buffering afterwards, right? Wouldn't that be an issue? If there are shared
pins, I can see this also being an issue even for single shot reading...
Otherwise, I wonder why we have this iio_device_claim_direct() calls? Is it=
 just
for using the internal IIO lock?

At this point, I did not checked the datasheet so I can be completely
misunderstanding things...

- Nuno S=C3=A1


