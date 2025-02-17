Return-Path: <linux-iio+bounces-15635-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E76EA380FC
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 11:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BE48189512C
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 10:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7257217715;
	Mon, 17 Feb 2025 10:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9JjDDiC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB24217713
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789803; cv=none; b=pg5hhMxWws97z+yTKdJEs9PEn1w7axAwjUjSzqNer10VSMrc0dyNPpPowiCVlty+vi8s3Tw0EgB1PjKzqqDyZZo02wINUDNxueWhFhxrhER9yH1lMZju1vTVEVa9u5P029WHfIQnAL2GxIK8UAdD+C7vgh9f6AQKYXPnsevm+pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789803; c=relaxed/simple;
	bh=pJQjebJNNItkGEOSG2TchOOfNCIlTQWwij1Ff8EQBJ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WjtX5euV2bEE6i5H1soLvBazDTLT4uIe1CHi5+tmfaqSRYUBCXgrWBP5rnIVSlCcPnwAy4RnMt6Mdm3t2q5dtgvEsYPhAtA0GuDVbkgGoS/Squ1/CxdkuhCjO95F6n4rZS+TUSAopyByZXigflkmWcfvQ8qO2KY/8IJC2Of71mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9JjDDiC; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e0573a84fcso1579068a12.2
        for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 02:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739789800; x=1740394600; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uQp9++3+WYggydaTrgzSV0zCFne1e/uKCBOGfXdVawE=;
        b=I9JjDDiChKfrNAHgd3L7Qkzh97ZINhE2v+U458lji/ouqF7kpV8OXR29mUB+RGq78/
         g8nEMCijjA0sV/H1BSXQtrHlSyu5tgjZE0/iqMHjuqYOwtKHcvERDatgwLtmZ9XvBUiu
         zmXk0K2ASc4AaiyubzPy12yQnyuLvg7qSfk7mAnZp+hi1clwKNChbzZxS9aa7uLdKAPz
         9tCz0YSN+1mQOg4990dXDNpY95Qb4VZdCqmry6M5+UpIyrFxd/16otfZ2Gw2bhddFCDO
         tfkn9xtCMgBdmgAtOyu0TnGp8tXvmnV4aAg2dOfuTxiNiBlzrc8XtvQR20hgXlH/d4/t
         72ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739789800; x=1740394600;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uQp9++3+WYggydaTrgzSV0zCFne1e/uKCBOGfXdVawE=;
        b=kzf2RPbSXK1QuIc28Rp7du/ovBorBAAYM+7P+UoaAxSwKigF5lpSQJVZ/mQxBT3XHV
         y43uTRfMZyIhGGAX1Zs2bwh19uORmuYu7KKi6UmpDl9zoBu/w34bZoByrdGKM+nxRkFI
         TKL08BaULk0+wHGmYZmlnB6zBhWfz6whD/CVtEMHV4qMgggOfqQXmQkGCTmS24jAFY38
         4Ys7Q7F1Z2KQlodoZlriBin7gH901pJDTe5gV3wnPM8Udi9JbFjvEmu1okf58RPwZ0yf
         JLNsZbtS1GNSdl2soQW2Z+bqv0SJVgfjFLPNFqJtiG8cmurIhZ1q+EV4ps8LOjmAI0Vf
         J6Gw==
X-Forwarded-Encrypted: i=1; AJvYcCWfU88ft0Jzls04fA+KnX+A8OXLlOSSPdEf43KG0yKy4Wlhu6Pq0xoQG6b34p62M+eeoRS9qj91i2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwVD9Qz696rQsQTZvYkVBLa+GEJRYvp8MFT7oTR3bPIVxjDBr8
	b2Srgk2xVAbwj1xZ2QJRNd7moKH9KVhOrI0ZcUWvahjOihPrFhYbpo/3N+dg+EI=
X-Gm-Gg: ASbGnctoGWC3rT/Kaeo8lEmxUSkFPwqKjsRKzzcgwcZq1GA5KMGtnurmBvqKz9ISOnH
	PCOpbGURxMU9S6qUGFm3DQ+UVyPDYgy/dy5FV3TARjzke1HeVIySomiD4e3PouC1cEnNES/5DCz
	2+MVAEJ5cP3w8DT4Wn6kRYcFC2TuouYYfEnf7lPpuNrc5aHLTUYQp8r9quOP3jBOpuX65CVfQYa
	/UTtam0PtIS3pLRHj+SnjqRDiK1ZSxCdOU/7HONp3XvNha+2AQdftaprzP/1/vMn4VSMLXa93En
	IXBzm7ilxjlE3qBuGmA5+q00xP7RTtR8Pie575gtAKGqPz1KzvwDb9eNudry2DE=
X-Google-Smtp-Source: AGHT+IENDWLAzcMNZ5CNVSmtQwtYWIw4aqDsfO8N7Dmk/GjER6uGLxsDU7vFXjlHFmWgwQgfW17LXg==
X-Received: by 2002:a05:6402:3488:b0:5dc:d8e6:62a7 with SMTP id 4fb4d7f45d1cf-5e03606d67fmr9164593a12.14.1739789799904;
        Mon, 17 Feb 2025 02:56:39 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1d367dsm7208350a12.44.2025.02.17.02.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:56:39 -0800 (PST)
Message-ID: <f8515673459bfd10e482571f00a2e56c2adc22fa.camel@gmail.com>
Subject: Re: [PATCH v2 02/27] iio: chemical: scd30: Use guard(mutex) to
 allow early returns
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>, Julien Stephan	
 <jstephan@baylibre.com>, Mariel Tinaco <Mariel.Tinaco@analog.com>, Angelo
 Dureghello <adureghello@baylibre.com>, Gustavo Silva
 <gustavograzs@gmail.com>, Nuno Sa	 <nuno.sa@analog.com>,
 =?ISO-8859-1?Q?Jo=E3o?= Paulo =?ISO-8859-1?Q?Gon=E7alves?=	
 <joao.goncalves@toradex.com>, ChiYuan Huang <cy_huang@richtek.com>, Ramona
 Alexandra Nechita <ramona.nechita@analog.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Guillaume Stols	 <gstols@baylibre.com>, David
 Lechner <dlechner@baylibre.com>, Cosmin Tanislav	 <demonsingur@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,  Gwendal Grignou
 <gwendal@chromium.org>, Antoni Pokusinski <apokusinski01@gmail.com>, Tomasz
 Duszynski	 <tomasz.duszynski@octakon.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Date: Mon, 17 Feb 2025 10:56:42 +0000
In-Reply-To: <20250209180624.701140-3-jic23@kernel.org>
References: <20250209180624.701140-1-jic23@kernel.org>
	 <20250209180624.701140-3-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-02-09 at 18:05 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Auto cleanup based release of the lock allows for simpler code flow in a
> few functions with large multiplexing style switch statements and no
> common operations following the switch.
>=20
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> ---
> v2: Fix include ordering (David)
> ---
> =C2=A0drivers/iio/chemical/scd30_core.c | 63 ++++++++++++++--------------=
---
> =C2=A0include/linux/iio/iio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A02 files changed, 29 insertions(+), 35 deletions(-)
>=20
> diff --git a/drivers/iio/chemical/scd30_core.c
> b/drivers/iio/chemical/scd30_core.c
> index d613c54cb28d..23ba46f7ca32 100644
> --- a/drivers/iio/chemical/scd30_core.c
> +++ b/drivers/iio/chemical/scd30_core.c
> @@ -5,6 +5,7 @@
> =C2=A0 * Copyright (c) 2020 Tomasz Duszynski <tomasz.duszynski@octakon.co=
m>
> =C2=A0 */
> =C2=A0#include <linux/bits.h>
> +#include <linux/cleanup.h>
> =C2=A0#include <linux/completion.h>
> =C2=A0#include <linux/delay.h>
> =C2=A0#include <linux/device.h>
> @@ -198,112 +199,104 @@ static int scd30_read_raw(struct iio_dev *indio_d=
ev,
> struct iio_chan_spec const
> =C2=A0			=C2=A0 int *val, int *val2, long mask)
> =C2=A0{
> =C2=A0	struct scd30_state *state =3D iio_priv(indio_dev);
> -	int ret =3D -EINVAL;
> +	int ret;
> =C2=A0	u16 tmp;
> =C2=A0
> -	mutex_lock(&state->lock);
> +	guard(mutex)(&state->lock);
> =C2=A0	switch (mask) {
> =C2=A0	case IIO_CHAN_INFO_RAW:
> =C2=A0	case IIO_CHAN_INFO_PROCESSED:
> =C2=A0		if (chan->output) {
> =C2=A0			*val =3D state->pressure_comp;
> -			ret =3D IIO_VAL_INT;
> -			break;
> +			return IIO_VAL_INT;
> =C2=A0		}
> =C2=A0
> =C2=A0		ret =3D iio_device_claim_direct_mode(indio_dev);
> =C2=A0		if (ret)
> -			break;
> +			return ret;
> =C2=A0
> =C2=A0		ret =3D scd30_read(state);
> =C2=A0		if (ret) {
> =C2=A0			iio_device_release_direct_mode(indio_dev);
> -			break;
> +			return ret;
> =C2=A0		}
> =C2=A0
> =C2=A0		*val =3D state->meas[chan->address];
> =C2=A0		iio_device_release_direct_mode(indio_dev);
> -		ret =3D IIO_VAL_INT;
> -		break;
> +		return IIO_VAL_INT;
> =C2=A0	case IIO_CHAN_INFO_SCALE:
> =C2=A0		*val =3D 0;
> =C2=A0		*val2 =3D 1;
> -		ret =3D IIO_VAL_INT_PLUS_MICRO;
> -		break;
> +		return IIO_VAL_INT_PLUS_MICRO;
> =C2=A0	case IIO_CHAN_INFO_SAMP_FREQ:
> =C2=A0		ret =3D scd30_command_read(state, CMD_MEAS_INTERVAL, &tmp);
> =C2=A0		if (ret)
> -			break;
> +			return ret;
> =C2=A0
> =C2=A0		*val =3D 0;
> =C2=A0		*val2 =3D 1000000000 / tmp;
> -		ret =3D IIO_VAL_INT_PLUS_NANO;
> -		break;
> +		return IIO_VAL_INT_PLUS_NANO;
> =C2=A0	case IIO_CHAN_INFO_CALIBBIAS:
> =C2=A0		ret =3D scd30_command_read(state, CMD_TEMP_OFFSET, &tmp);
> =C2=A0		if (ret)
> -			break;
> +			return ret;
> =C2=A0
> =C2=A0		*val =3D tmp;
> -		ret =3D IIO_VAL_INT;
> -		break;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> =C2=A0	}
> -	mutex_unlock(&state->lock);
> -
> -	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0static int scd30_write_raw(struct iio_dev *indio_dev, struct iio_ch=
an_spec
> const *chan,
> =C2=A0			=C2=A0=C2=A0 int val, int val2, long mask)
> =C2=A0{
> =C2=A0	struct scd30_state *state =3D iio_priv(indio_dev);
> -	int ret =3D -EINVAL;
> +	int ret;
> =C2=A0
> -	mutex_lock(&state->lock);
> +	guard(mutex)(&state->lock);
> =C2=A0	switch (mask) {
> =C2=A0	case IIO_CHAN_INFO_SAMP_FREQ:
> =C2=A0		if (val)
> -			break;
> +			return -EINVAL;
> =C2=A0
> =C2=A0		val =3D 1000000000 / val2;
> =C2=A0		if (val < SCD30_MEAS_INTERVAL_MIN_S || val >
> SCD30_MEAS_INTERVAL_MAX_S)
> -			break;
> +			return -EINVAL;
> =C2=A0
> =C2=A0		ret =3D scd30_command_write(state, CMD_MEAS_INTERVAL, val);
> =C2=A0		if (ret)
> -			break;
> +			return ret;
> =C2=A0
> =C2=A0		state->meas_interval =3D val;
> -		break;
> +		return 0;
> =C2=A0	case IIO_CHAN_INFO_RAW:
> =C2=A0		switch (chan->type) {
> =C2=A0		case IIO_PRESSURE:
> =C2=A0			if (val < SCD30_PRESSURE_COMP_MIN_MBAR ||
> =C2=A0			=C2=A0=C2=A0=C2=A0 val > SCD30_PRESSURE_COMP_MAX_MBAR)
> -				break;
> +				return -EINVAL;
> =C2=A0
> =C2=A0			ret =3D scd30_command_write(state, CMD_START_MEAS,
> val);
> =C2=A0			if (ret)
> -				break;
> +				return ret;
> =C2=A0
> =C2=A0			state->pressure_comp =3D val;
> -			break;
> +			return 0;
> =C2=A0		default:
> -			break;
> +			return -EINVAL;
> =C2=A0		}
> -		break;
> =C2=A0	case IIO_CHAN_INFO_CALIBBIAS:
> =C2=A0		if (val < 0 || val > SCD30_TEMP_OFFSET_MAX)
> -			break;
> +			return -EINVAL;
> =C2=A0		/*
> =C2=A0		 * Manufacturer does not explicitly specify min/max sensible
> =C2=A0		 * values hence check is omitted for simplicity.
> =C2=A0		 */
> -		ret =3D scd30_command_write(state, CMD_TEMP_OFFSET / 10, val);
> +		return scd30_command_write(state, CMD_TEMP_OFFSET / 10, val);
> +	default:
> +		return -EINVAL;
> =C2=A0	}
> -	mutex_unlock(&state->lock);
> -
> -	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0static int scd30_write_raw_get_fmt(struct iio_dev *indio_dev, struc=
t
> iio_chan_spec const *chan,
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index fe33835b19cf..5ed03e36178f 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -10,6 +10,7 @@
> =C2=A0#include <linux/device.h>
> =C2=A0#include <linux/cdev.h>
> =C2=A0#include <linux/cleanup.h>
> +#include <linux/compiler_types.h>

Hmm, here it is... I guess some messed rebase and squash :)

- Nuno S=C3=A1



