Return-Path: <linux-iio+bounces-15625-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AF9A380AD
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 11:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689443A9DD3
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 10:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37835215F5B;
	Mon, 17 Feb 2025 10:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLwYRj8o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7B61A5B8C
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 10:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789323; cv=none; b=RwG/tfRtPPTM9hEzZJPwlRCgLLJhmYYjb57M+ErS67eHKLRW16lRZkzx8dPD1v7bLguhCl4sTMhRLp7tOHBEIRTuzWYViNWcW32Nj5/ndrvIPna7UYfzqw8awOSZBgTnudzQ9wUhUSnWwgzqmpwocZvMV0MndVKuqXhbQ5zJI94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789323; c=relaxed/simple;
	bh=SkHlyf1pBOkHmIJ+9t2aYzqwiy3X3G6YkVlw9nmvJjg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dyaq7vTtgHyBESkx4Z8ta3MjGmFlY1CgtzvTLyiTLetcC8uJsepVfnw22cItNOUd3d+U3FXQEd3v+Jley8fyi6UklXjUqglNDsJmGK0JEQeOHZvORovxJ+QPBwov1dD4Kb/C3BdP8rTkKuMY2t3O42ZdVs5uW4PXJ0hv3D8cT38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLwYRj8o; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abb90f68f8cso207270866b.3
        for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 02:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739789319; x=1740394119; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UVGwpxlhJk+i2/rzp914JzVVpeF5Zq4tHtwFvWrCoh8=;
        b=YLwYRj8oR32BEkyujVNkVPaRwcyhbSXhCzQoXIcW5OuhKNVSZN5WlexgT9vZNqPN6e
         WdAVwaMtJ/MitHO9oWcI9G64NABlXw5YW3yNCGp/m/80k2lMcrOYYfUjg+EJD8dv+OAh
         KR9VAViByQRljh7JGbIxsMrPQx5EbxJDYxcYzAAInwWj63iFtjPiZu4rfyxOfQqIUdVy
         B60I82DS/kQ1GAR2Lnc7RTGAmxUQVKY1KCCpO3sfdDXH9DbdhTMIt8qrcow9iuIB/ElQ
         tLReDSWB+VVD7gnbmWstw8lOo2WhcBq96VnrKcemP/z3trNpE6wmEUU/3ttV+FLs4mGI
         8mBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739789319; x=1740394119;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UVGwpxlhJk+i2/rzp914JzVVpeF5Zq4tHtwFvWrCoh8=;
        b=Kk/OST4QKiUFJpobb2lQP7Xk33vtUQjdQwgZx7AbkAaHJj7bRLKf0avakuTESl7XZ2
         5oHqKZfcxP0nvF19X3Yd65Y5B56lKvbPzo09dZn9c7neZ5ZU4quBzPBEuymM6353P2L1
         6siZ3y1OR71xzBBdtziB1mg0jzzp9JkKJOSJ5Ha2ADLhFc63bIENZqxV/2jzXayDa6Nf
         YUzn9uKyggS30dhQJ8eh0WFQJ3Ti364l9/PCxg+/GCZN0S2I+QFr4DkNmFMc3ljjEg/e
         H27kj2fPrIDQKoDWCQaf7J06RKd9sMkr2zEAbK0DWany/I5JZ4vxmAtJICg8Wsh9Kh5x
         1YZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvnHFTotP/urQ3pN63Zug9YfrSAoaesTwgFlQYiw2e9AMy1nbKckPi4r1P30NcC4kVDlhO8TXF2YI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqL9SltjjU1uu8dfaPW9leff0I16JF17K19BPHwBlvao8Fxaaf
	MHzzF7PLK6X1MDWU7aERExgxbe/z4YXzcQ9vXpicYEZq07R1KDk7GNtcVpKgIsQ=
X-Gm-Gg: ASbGncuaco2RjAfZ3NfglInmadE812kkEPG1ZiIUjVgcPdvHtLew1o5NWsxXFNYajMm
	7gqV+7cBiFjZ+6k2ns04Qh4YGfUwFuoaX2a/9KEJMqN83SIH1p7rt4aL6MGeWcYKFtkFSl99zMo
	J+5eh7x2jb3H649eahbKxrfqrCs3/0RGWFcz6XwTN4r5pe5f9cDFboSdCjxz+/f9O27d0Z5HctI
	oWZNr3h1PAdNpKgbv6+B+rePbnWEd2C/BO7Y9QlyU2Hv8nGHbyWigo8bvxouY9nL/X7c/Efo1nc
	IoZHAHt+czUGHoZlvP8+PC24ZNQBDi2pSirZk4JFquHWzrC8TKz4U9NdveYO/zo=
X-Google-Smtp-Source: AGHT+IHFzVf6B1/XFDuO0uMrnrWIJeyVeadzmhUupDtD7FntfnNf4o7Jwhors7K5T9A4w2ffHn5BDQ==
X-Received: by 2002:a17:906:7312:b0:ab7:ed56:a780 with SMTP id a640c23a62f3a-abb70bbe11cmr837133866b.27.1739789319060;
        Mon, 17 Feb 2025 02:48:39 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abba4542e7fsm100319566b.139.2025.02.17.02.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:48:38 -0800 (PST)
Message-ID: <67d51ac153518ac115416b47cb46cb4e58e1c0d1.camel@gmail.com>
Subject: Re: [PATCH v2 11/27] iio: adc: ad4695: Stop using
 iio_device_claim_direct_scoped()
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
Date: Mon, 17 Feb 2025 10:48:41 +0000
In-Reply-To: <20250209180624.701140-12-jic23@kernel.org>
References: <20250209180624.701140-1-jic23@kernel.org>
	 <20250209180624.701140-12-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-02-09 at 18:06 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> This complex cleanup.h use case of conditional guards has proved
> to be more trouble that it is worth in terms of false positive compiler
> warnings and hard to read code.
>=20
> Move directly to the new claim/release_direct() that allow sparse
> to check for unbalanced context.=C2=A0 In some cases code is factored
> out to utility functions that can do a direct return with the
> claim and release around the call.
>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v2: Typo in commit description (David).
> Note there are several sets current in flight that touch this driver.
> I'll rebase as necessary depending on what order the dependencies resolve=
.
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad4695.c | 240 ++++++++++++++++++++++--------------=
---
> =C2=A01 file changed, 133 insertions(+), 107 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
> index 13cf01d35301..4bb22f4d739b 100644
> --- a/drivers/iio/adc/ad4695.c
> +++ b/drivers/iio/adc/ad4695.c
> @@ -738,6 +738,25 @@ static int ad4695_read_one_sample(struct ad4695_stat=
e
> *st, unsigned int address)
> =C2=A0	return spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> =C2=A0}
> =C2=A0
> +static int __ad4695_read_info_raw(struct ad4695_state *st,
> +				=C2=A0 struct iio_chan_spec const *chan,
> +				=C2=A0 int *val)
> +{
> +	u8 realbits =3D chan->scan_type.realbits;
> +	int ret;
> +
> +	ret =3D ad4695_read_one_sample(st, chan->address);
> +	if (ret)
> +		return ret;
> +
> +	if (chan->scan_type.sign =3D=3D 's')
> +		*val =3D sign_extend32(st->raw_data, realbits - 1);
> +	else
> +		*val =3D st->raw_data;
> +
> +	return IIO_VAL_INT;
> +}
> +
> =C2=A0static int ad4695_read_raw(struct iio_dev *indio_dev,
> =C2=A0			=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> =C2=A0			=C2=A0=C2=A0 int *val, int *val2, long mask)
> @@ -750,19 +769,12 @@ static int ad4695_read_raw(struct iio_dev *indio_de=
v,
> =C2=A0
> =C2=A0	switch (mask) {
> =C2=A0	case IIO_CHAN_INFO_RAW:
> -		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> -			ret =3D ad4695_read_one_sample(st, chan->address);
> -			if (ret)
> -				return ret;
> -
> -			if (chan->scan_type.sign =3D=3D 's')
> -				*val =3D sign_extend32(st->raw_data, realbits -
> 1);
> -			else
> -				*val =3D st->raw_data;
> =C2=A0
> -			return IIO_VAL_INT;
> -		}
> -		unreachable();
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +		ret =3D __ad4695_read_info_raw(st, chan, val);
> +		iio_device_release_direct(indio_dev);
> +		return ret;
> =C2=A0	case IIO_CHAN_INFO_SCALE:
> =C2=A0		switch (chan->type) {
> =C2=A0		case IIO_VOLTAGE:
> @@ -800,45 +812,45 @@ static int ad4695_read_raw(struct iio_dev *indio_de=
v,
> =C2=A0	case IIO_CHAN_INFO_CALIBSCALE:
> =C2=A0		switch (chan->type) {
> =C2=A0		case IIO_VOLTAGE:
> -			iio_device_claim_direct_scoped(return -EBUSY,
> indio_dev) {
> -				ret =3D regmap_read(st->regmap16,
> -					AD4695_REG_GAIN_IN(chan->scan_index),
> -					&reg_val);
> -				if (ret)
> -					return ret;
> +			if (!iio_device_claim_direct(indio_dev))
> +				return -EBUSY;
> +			ret =3D regmap_read(st->regmap16,
> +					=C2=A0 AD4695_REG_GAIN_IN(chan-
> >scan_index),
> +					=C2=A0 &reg_val);
> +			iio_device_release_direct(indio_dev);
> +			if (ret)
> +				return ret;
> =C2=A0
> -				*val =3D reg_val;
> -				*val2 =3D 15;
> +			*val =3D reg_val;
> +			*val2 =3D 15;
> =C2=A0
> -				return IIO_VAL_FRACTIONAL_LOG2;
> -			}
> -			unreachable();
> +			return IIO_VAL_FRACTIONAL_LOG2;
> =C2=A0		default:
> =C2=A0			return -EINVAL;
> =C2=A0		}
> =C2=A0	case IIO_CHAN_INFO_CALIBBIAS:
> =C2=A0		switch (chan->type) {
> =C2=A0		case IIO_VOLTAGE:
> -			iio_device_claim_direct_scoped(return -EBUSY,
> indio_dev) {
> -				ret =3D regmap_read(st->regmap16,
> -					AD4695_REG_OFFSET_IN(chan-
> >scan_index),
> -					&reg_val);
> -				if (ret)
> -					return ret;
> -
> -				tmp =3D sign_extend32(reg_val, 15);
> +			if (!iio_device_claim_direct(indio_dev))
> +				return -EBUSY;
> +			ret =3D regmap_read(st->regmap16,
> +					=C2=A0 AD4695_REG_OFFSET_IN(chan-
> >scan_index),
> +					=C2=A0 &reg_val);
> +			iio_device_release_direct(indio_dev);
> +			if (ret)
> +				return ret;
> =C2=A0
> -				*val =3D tmp / 4;
> -				*val2 =3D abs(tmp) % 4 * MICRO / 4;
> +			tmp =3D sign_extend32(reg_val, 15);
> =C2=A0
> -				if (tmp < 0 && *val2) {
> -					*val *=3D -1;
> -					*val2 *=3D -1;
> -				}
> +			*val =3D tmp / 4;
> +			*val2 =3D abs(tmp) % 4 * MICRO / 4;
> =C2=A0
> -				return IIO_VAL_INT_PLUS_MICRO;
> +			if (tmp < 0 && *val2) {
> +				*val *=3D -1;
> +				*val2 *=3D -1;
> =C2=A0			}
> -			unreachable();
> +
> +			return IIO_VAL_INT_PLUS_MICRO;
> =C2=A0		default:
> =C2=A0			return -EINVAL;
> =C2=A0		}
> @@ -847,64 +859,75 @@ static int ad4695_read_raw(struct iio_dev *indio_de=
v,
> =C2=A0	}
> =C2=A0}
> =C2=A0
> -static int ad4695_write_raw(struct iio_dev *indio_dev,
> -			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> -			=C2=A0=C2=A0=C2=A0 int val, int val2, long mask)
> +static int __ad4695_write_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int val, int val2, long mask)
> =C2=A0{
> =C2=A0	struct ad4695_state *st =3D iio_priv(indio_dev);
> =C2=A0	unsigned int reg_val;
> =C2=A0
> -	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> -		switch (mask) {
> -		case IIO_CHAN_INFO_CALIBSCALE:
> -			switch (chan->type) {
> -			case IIO_VOLTAGE:
> -				if (val < 0 || val2 < 0)
> -					reg_val =3D 0;
> -				else if (val > 1)
> -					reg_val =3D U16_MAX;
> -				else
> -					reg_val =3D (val * (1 << 16) +
> -						=C2=A0=C2=A0 mul_u64_u32_div(val2, 1 <<
> 16,
> -								=C2=A0=C2=A0 MICRO)) /
> 2;
> -
> -				return regmap_write(st->regmap16,
> -					AD4695_REG_GAIN_IN(chan->scan_index),
> -					reg_val);
> -			default:
> -				return -EINVAL;
> -			}
> -		case IIO_CHAN_INFO_CALIBBIAS:
> -			switch (chan->type) {
> -			case IIO_VOLTAGE:
> -				if (val2 >=3D 0 && val > S16_MAX / 4)
> -					reg_val =3D S16_MAX;
> -				else if ((val2 < 0 ? -val : val) < S16_MIN /
> 4)
> -					reg_val =3D S16_MIN;
> -				else if (val2 < 0)
> -					reg_val =3D clamp_t(int,
> -						-(val * 4 + -val2 * 4 /
> MICRO),
> -						S16_MIN, S16_MAX);
> -				else if (val < 0)
> -					reg_val =3D clamp_t(int,
> -						val * 4 - val2 * 4 / MICRO,
> -						S16_MIN, S16_MAX);
> -				else
> -					reg_val =3D clamp_t(int,
> -						val * 4 + val2 * 4 / MICRO,
> -						S16_MIN, S16_MAX);
> -
> -				return regmap_write(st->regmap16,
> -					AD4695_REG_OFFSET_IN(chan-
> >scan_index),
> -					reg_val);
> -			default:
> -				return -EINVAL;
> -			}
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			if (val < 0 || val2 < 0)
> +				reg_val =3D 0;
> +			else if (val > 1)
> +				reg_val =3D U16_MAX;
> +			else
> +				reg_val =3D (val * (1 << 16) +
> +					=C2=A0=C2=A0 mul_u64_u32_div(val2, 1 << 16,
> +							=C2=A0=C2=A0 MICRO)) / 2;
> +
> +			return regmap_write(st->regmap16,
> +					=C2=A0=C2=A0=C2=A0 AD4695_REG_GAIN_IN(chan-
> >scan_index),
> +					=C2=A0=C2=A0=C2=A0 reg_val);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			if (val2 >=3D 0 && val > S16_MAX / 4)
> +				reg_val =3D S16_MAX;
> +			else if ((val2 < 0 ? -val : val) < S16_MIN / 4)
> +				reg_val =3D S16_MIN;
> +			else if (val2 < 0)
> +				reg_val =3D clamp_t(int,
> +						=C2=A0 -(val * 4 + -val2 * 4 /
> MICRO),
> +						=C2=A0 S16_MIN, S16_MAX);
> +			else if (val < 0)
> +				reg_val =3D clamp_t(int,
> +						=C2=A0 val * 4 - val2 * 4 / MICRO,
> +						=C2=A0 S16_MIN, S16_MAX);
> +			else
> +				reg_val =3D clamp_t(int,
> +						=C2=A0 val * 4 + val2 * 4 / MICRO,
> +						=C2=A0 S16_MIN, S16_MAX);
> +
> +			return regmap_write(st->regmap16,
> +					=C2=A0=C2=A0=C2=A0 AD4695_REG_OFFSET_IN(chan-
> >scan_index),
> +					=C2=A0=C2=A0=C2=A0 reg_val);
> =C2=A0		default:
> =C2=A0			return -EINVAL;
> =C2=A0		}
> +	default:
> +		return -EINVAL;
> =C2=A0	}
> -	unreachable();
> +}
> +
> +static int ad4695_write_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0 int val, int val2, long mask)
> +{
> +	int ret;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +	ret =3D __ad4695_write_raw(indio_dev, chan, val, val2, mask);
> +	iio_device_release_direct(indio_dev);
> +
> +	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0static int ad4695_read_avail(struct iio_dev *indio_dev,
> @@ -954,26 +977,29 @@ static int ad4695_debugfs_reg_access(struct iio_dev
> *indio_dev,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int *readval)
> =C2=A0{
> =C2=A0	struct ad4695_state *st =3D iio_priv(indio_dev);
> -
> -	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> -		if (readval) {
> -			if (regmap_check_range_table(st->regmap, reg,
> -						=C2=A0=C2=A0=C2=A0=C2=A0
> &ad4695_regmap_rd_table))
> -				return regmap_read(st->regmap, reg, readval);
> -			if (regmap_check_range_table(st->regmap16, reg,
> -						=C2=A0=C2=A0=C2=A0=C2=A0
> &ad4695_regmap16_rd_table))
> -				return regmap_read(st->regmap16, reg,
> readval);
> -		} else {
> -			if (regmap_check_range_table(st->regmap, reg,
> -						=C2=A0=C2=A0=C2=A0=C2=A0
> &ad4695_regmap_wr_table))
> -				return regmap_write(st->regmap, reg,
> writeval);
> -			if (regmap_check_range_table(st->regmap16, reg,
> -						=C2=A0=C2=A0=C2=A0=C2=A0
> &ad4695_regmap16_wr_table))
> -				return regmap_write(st->regmap16, reg,
> writeval);
> -		}
> +	int ret =3D -EINVAL;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +
> +	if (readval) {
> +		if (regmap_check_range_table(st->regmap, reg,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 &ad4695_regmap_rd_table))
> +			ret =3D regmap_read(st->regmap, reg, readval);
> +		if (regmap_check_range_table(st->regmap16, reg,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 &ad4695_regmap16_rd_table))
> +			ret =3D regmap_read(st->regmap16, reg, readval);
> +	} else {
> +		if (regmap_check_range_table(st->regmap, reg,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 &ad4695_regmap_wr_table))
> +			ret =3D regmap_write(st->regmap, reg, writeval);
> +		if (regmap_check_range_table(st->regmap16, reg,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 &ad4695_regmap16_wr_table))
> +			ret =3D regmap_write(st->regmap16, reg, writeval);
> =C2=A0	}
> +	iio_device_release_direct(indio_dev);
> =C2=A0
> -	return -EINVAL;
> +	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0static const struct iio_info ad4695_info =3D {


