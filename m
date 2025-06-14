Return-Path: <linux-iio+bounces-20638-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AA5AD9C9C
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 13:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C7277A93F3
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 11:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AA92980AC;
	Sat, 14 Jun 2025 11:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edgSZhN3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA981C5D4E;
	Sat, 14 Jun 2025 11:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749902060; cv=none; b=BKWQ2z9ZepRtylGnDfth3ZFO/DIt4/rThZSev7Sl7lGzUp5BDDWmYc5j/+Yz4GRe2OvDuB/OShj31aR/XdrIouQtT46SH9fnBJ2+lh8CEBAPPhKR8ef73pVVYcSpUUy+K6T6keuU4yZ2epdRm65VsKyM3yKOVldZ4OxrBEkd0KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749902060; c=relaxed/simple;
	bh=WabN4dwTKAs8OzxvGHu0kL3loBySzbmbEPMJzk0Yu/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EuA0m6l38Z0mcpxVQcSZRpszjBWKyv5XMQxu7EJjHElyqUsT1e1tSPGvnWLu+Cnd/ut1aE7aD3g4ykRBvT0s1QUJ7fJwzd2djUehkWEilAtZoPrjnBd0n6nT5cbCPoRZIgRmatib73tkzJCpS8KJ2k6q7SsQ9of8iAGz8uPZyEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edgSZhN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1BEC4CEEB;
	Sat, 14 Jun 2025 11:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749902060;
	bh=WabN4dwTKAs8OzxvGHu0kL3loBySzbmbEPMJzk0Yu/Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=edgSZhN3IR6PmO5zw9Ci5TX6qWj9zA4anY8Avqh8KjvnWTwiUcG8AviJn+XC9LxUf
	 5iSRB5bHAxQVtcuRBiH3U4oSDwBaGjd02obTKgCD5YOlcPfecCLnhJZ8eD5eOvkZw6
	 DPSpWT+ehFBsyv0vHpAsXapElAQtgUXWWnRkQc9+jEaVkUU37hp3u4nqbf1EO6aemp
	 TIePk2WVLS3B1ok9OGjoCnoW6OB7MDIz3N1MTIueTPUFLJqYMrKjmiftcOyRkAW1vX
	 mi38cDSj+IdIDUCzqeZww6s72w28qF3bx8KXyPPK98ZR+kxsbYZMkEzGns0mEGlsJc
	 VZbcXKoRMIoaw==
Date: Sat, 14 Jun 2025 12:54:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Andrew Ijano <andrew.ijano@gmail.com>, andrew.lopes@alumni.usp.br,
 gustavobastos@usp.br, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, jstephan@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] iio: accel: sca3000: use guard(mutex)() for
 handling mutex lock
Message-ID: <20250614125412.678d3fa4@jic23-huawei>
In-Reply-To: <c707bb2ad7334736c56687f20824be4b3ef71d74.camel@gmail.com>
References: <20250611194648.18133-1-andrew.lopes@alumni.usp.br>
	<20250611194648.18133-4-andrew.lopes@alumni.usp.br>
	<c707bb2ad7334736c56687f20824be4b3ef71d74.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Jun 2025 07:38:18 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2025-06-11 at 16:39 -0300, Andrew Ijano wrote:
> > Use guard(mutex)(&st->lock) for handling mutex lock instead of
> > manually locking and unlocking the mutex. This prevents forgotten
> > locks due to early exits and remove the need of gotos.
> >=20
> > Signed-off-by: Andrew Ijano <andrew.lopes@alumni.usp.br>
> > Co-developed-by: Gustavo Bastos <gustavobastos@usp.br>
> > Signed-off-by: Gustavo Bastos <gustavobastos@usp.br>
> > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > ---
> > For this one, there are two cases where the previous implementation
> > was a smalllocking portion of the code and now it's locking the whole
> > function. I don't know if this is a desired behavior.
> >  =20
>=20
> In theory, it should not break anything. But you can always refactor thin=
gs (like
> small helpers) to lock only the code you want. There's also scoped_guard(=
). I would
> say, up to you for re-spinning a new version because of the above :).=C2=
=A0
>=20
> Just have something that I'm not totatlly sure... Did you made sure to co=
mpile?
> AFAIR, guard() had some complains when used in switch() case statements. =
Maybe that
> got improved.
yes, - Needs scope {} to be defined to limit it to the case.


>=20
> If the above is not an issue:
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> > =C2=A0drivers/iio/accel/sca3000.c | 177 ++++++++++++-------------------=
-----
> > =C2=A01 file changed, 57 insertions(+), 120 deletions(-)
> >=20
> > diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> > index d41759c68fb4..098d45bad389 100644
> > --- a/drivers/iio/accel/sca3000.c
> > +++ b/drivers/iio/accel/sca3000.c
> > @@ -405,17 +405,14 @@ static int sca3000_print_rev(struct iio_dev *indi=
o_dev)
> > =C2=A0	int ret;
> > =C2=A0	struct sca3000_state *st =3D iio_priv(indio_dev);
> > =C2=A0
> > -	mutex_lock(&st->lock);
> > +	guard(mutex)(&st->lock);
> > =C2=A0	ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_REVID_ADDR=
));
> > =C2=A0	if (ret < 0)
> > -		goto error_ret;
> > +		return ret;
> > =C2=A0	dev_info(&indio_dev->dev,
> > =C2=A0		 "sca3000 revision major=3D%lu, minor=3D%lu\n",
> > =C2=A0		 ret & SCA3000_REG_REVID_MAJOR_MASK,
> > =C2=A0		 ret & SCA3000_REG_REVID_MINOR_MASK);
> > -error_ret:
> > -	mutex_unlock(&st->lock);
> > -
> > =C2=A0	return ret;
> > =C2=A0}
> > =C2=A0
> > @@ -699,32 +696,25 @@ static int sca3000_read_raw(struct iio_dev *indio=
_dev,
> > =C2=A0
> > =C2=A0	switch (mask) {
> > =C2=A0	case IIO_CHAN_INFO_RAW:
> > -		mutex_lock(&st->lock);
> > +		guard(mutex)(&st->lock);
> > =C2=A0		if (chan->type =3D=3D IIO_ACCEL) {
> > -			if (st->mo_det_use_count) {
> > -				mutex_unlock(&st->lock);
> > +			if (st->mo_det_use_count)
> > =C2=A0				return -EBUSY;
> > -			}
> > =C2=A0			address =3D sca3000_addresses[chan->address][0];
> > =C2=A0			ret =3D spi_w8r16be(st->us, SCA3000_READ_REG(address));
> > -			if (ret < 0) {
> > -				mutex_unlock(&st->lock);
> > +			if (ret < 0)
> > =C2=A0				return ret;
> > -			}
> > =C2=A0			*val =3D sign_extend32(ret >> chan->scan_type.shift,
> > =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 chan->scan_type.realbits - 1);
> > =C2=A0		} else {
> > =C2=A0			/* get the temperature when available */
> > =C2=A0			ret =3D spi_w8r16be(st->us,
> > =C2=A0						SCA3000_READ_REG(SCA3000_REG_TEMP_
> > MSB_ADDR));
> > -			if (ret < 0) {
> > -				mutex_unlock(&st->lock);
> > +			if (ret < 0)
> > =C2=A0				return ret;
> > -			}
> > =C2=A0			*val =3D (ret >> chan->scan_type.shift) &
> > =C2=A0				GENMASK(chan->scan_type.realbits - 1, 0);
> > =C2=A0		}
> > -		mutex_unlock(&st->lock);
> > =C2=A0		return IIO_VAL_INT;
> > =C2=A0	case IIO_CHAN_INFO_SCALE:
> > =C2=A0		*val =3D 0;
> > @@ -738,14 +728,12 @@ static int sca3000_read_raw(struct iio_dev *indio=
_dev,
> > =C2=A0		*val2 =3D 600000;
> > =C2=A0		return IIO_VAL_INT_PLUS_MICRO;
> > =C2=A0	case IIO_CHAN_INFO_SAMP_FREQ:
> > -		mutex_lock(&st->lock);
> > +		guard(mutex)(&st->lock);
> > =C2=A0		ret =3D sca3000_read_raw_samp_freq(st, val);
> > -		mutex_unlock(&st->lock);
> > =C2=A0		return ret ? ret : IIO_VAL_INT;
> > =C2=A0	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> > -		mutex_lock(&st->lock);
> > +		guard(mutex)(&st->lock);
> > =C2=A0		ret =3D sca3000_read_3db_freq(st, val);
> > -		mutex_unlock(&st->lock);
> > =C2=A0		return ret;
> > =C2=A0	default:
> > =C2=A0		return -EINVAL;
> > @@ -763,22 +751,16 @@ static int sca3000_write_raw(struct iio_dev *indi=
o_dev,
> > =C2=A0	case IIO_CHAN_INFO_SAMP_FREQ:
> > =C2=A0		if (val2)
> > =C2=A0			return -EINVAL;
> > -		mutex_lock(&st->lock);
> > -		ret =3D sca3000_write_raw_samp_freq(st, val);
> > -		mutex_unlock(&st->lock);
> > -		return ret;
> > +		guard(mutex)(&st->lock);
> > +		return sca3000_write_raw_samp_freq(st, val);
> > =C2=A0	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> > =C2=A0		if (val2)
> > =C2=A0			return -EINVAL;
> > -		mutex_lock(&st->lock);
> > -		ret =3D sca3000_write_3db_freq(st, val);
> > -		mutex_unlock(&st->lock);
> > -		return ret;
> > +		guard(mutex)(&st->lock);
> > +		return sca3000_write_3db_freq(st, val);
> > =C2=A0	default:
> > =C2=A0		return -EINVAL;
> > =C2=A0	}
> > -
> > -	return ret;
> > =C2=A0}
> > =C2=A0
> > =C2=A0/**
> > @@ -800,9 +782,8 @@ static ssize_t sca3000_read_av_freq(struct device *=
dev,
> > =C2=A0	struct sca3000_state *st =3D iio_priv(indio_dev);
> > =C2=A0	int len =3D 0, ret;
> > =C2=A0
> > -	mutex_lock(&st->lock);
> > +	guard(mutex)(&st->lock);
> > =C2=A0	ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR)=
);
> > -	mutex_unlock(&st->lock);
> > =C2=A0	if (ret)
> > =C2=A0		return ret;
> > =C2=A0
> > @@ -851,10 +832,9 @@ static int sca3000_read_event_value(struct iio_dev=
 *indio_dev,
> > =C2=A0
> > =C2=A0	switch (info) {
> > =C2=A0	case IIO_EV_INFO_VALUE:
> > -		mutex_lock(&st->lock);
> > +		guard(mutex)(&st->lock);
> > =C2=A0		ret =3D sca3000_read_ctrl_reg(st,
> > =C2=A0					=C2=A0=C2=A0=C2=A0 sca3000_addresses[chan->address][1]);
> > -		mutex_unlock(&st->lock);
> > =C2=A0		if (ret < 0)
> > =C2=A0			return ret;
> > =C2=A0		*val =3D 0;
> > @@ -918,13 +898,10 @@ static int sca3000_write_event_value(struct iio_d=
ev
> > *indio_dev,
> > =C2=A0			}
> > =C2=A0	}
> > =C2=A0
> > -	mutex_lock(&st->lock);
> > -	ret =3D sca3000_write_ctrl_reg(st,
> > +	guard(mutex)(&st->lock);
> > +	return sca3000_write_ctrl_reg(st,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 sca3000_addresses[chan->address][1],
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 nonlinear);
> > -	mutex_unlock(&st->lock);
> > -
> > -	return ret;
> > =C2=A0}
> > =C2=A0
> > =C2=A0static struct attribute *sca3000_attributes[] =3D {
> > @@ -969,12 +946,12 @@ static void sca3000_ring_int_process(u8 val, stru=
ct iio_dev
> > *indio_dev)
> > =C2=A0	struct sca3000_state *st =3D iio_priv(indio_dev);
> > =C2=A0	int ret, i, num_available;
> > =C2=A0
> > -	mutex_lock(&st->lock);
> > +	guard(mutex)(&st->lock);
> > =C2=A0
> > =C2=A0	if (val & SCA3000_REG_INT_STATUS_HALF) {
> > =C2=A0		ret =3D spi_w8r8(st->us,
> > SCA3000_READ_REG(SCA3000_REG_BUF_COUNT_ADDR));
> > =C2=A0		if (ret)
> > -			goto error_ret;
> > +			return;
> > =C2=A0		num_available =3D ret;
> > =C2=A0		/*
> > =C2=A0		 * num_available is the total number of samples available
> > @@ -983,7 +960,7 @@ static void sca3000_ring_int_process(u8 val, struct=
 iio_dev
> > *indio_dev)
> > =C2=A0		ret =3D sca3000_read_data(st, SCA3000_REG_RING_OUT_ADDR,
> > =C2=A0					num_available * 2);
> > =C2=A0		if (ret)
> > -			goto error_ret;
> > +			return;
> > =C2=A0		for (i =3D 0; i < num_available / 3; i++) {
> > =C2=A0			/*
> > =C2=A0			 * Dirty hack to cover for 11 bit in fifo, 13 bit
> > @@ -995,8 +972,6 @@ static void sca3000_ring_int_process(u8 val, struct=
 iio_dev
> > *indio_dev)
> > =C2=A0			iio_push_to_buffers(indio_dev, st->rx + i * 3 * 2);
> > =C2=A0		}
> > =C2=A0	}
> > -error_ret:
> > -	mutex_unlock(&st->lock);
> > =C2=A0}
> > =C2=A0
> > =C2=A0/**
> > @@ -1022,9 +997,8 @@ static irqreturn_t sca3000_event_handler(int irq, =
void
> > *private)
> > =C2=A0	 * Could lead if badly timed to an extra read of status reg,
> > =C2=A0	 * but ensures no interrupt is missed.
> > =C2=A0	 */
> > -	mutex_lock(&st->lock);
> > +	guard(mutex)(&st->lock);
> > =C2=A0	ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_STATUS=
_ADDR));
> > -	mutex_unlock(&st->lock);
> > =C2=A0	if (ret)
> > =C2=A0		goto done;
> > =C2=A0
> > @@ -1081,16 +1055,15 @@ static int sca3000_read_event_config(struct iio=
_dev
> > *indio_dev,
> > =C2=A0	struct sca3000_state *st =3D iio_priv(indio_dev);
> > =C2=A0	int ret;
> > =C2=A0	/* read current value of mode register */
> > -	mutex_lock(&st->lock);
> > +	guard(mutex)(&st->lock);
> > =C2=A0
> > =C2=A0	ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR)=
);
> > =C2=A0	if (ret)
> > -		goto error_ret;
> > +		return ret;
> > =C2=A0
> > =C2=A0	switch (chan->channel2) {
> > =C2=A0	case IIO_MOD_X_AND_Y_AND_Z:
> > -		ret =3D !!(ret & SCA3000_REG_MODE_FREE_FALL_DETECT);
> > -		break;
> > +		return !!(ret & SCA3000_REG_MODE_FREE_FALL_DETECT);
> > =C2=A0	case IIO_MOD_X:
> > =C2=A0	case IIO_MOD_Y:
> > =C2=A0	case IIO_MOD_Z:
> > @@ -1100,24 +1073,18 @@ static int sca3000_read_event_config(struct iio=
_dev
> > *indio_dev,
> > =C2=A0		 */
> > =C2=A0		if ((ret & SCA3000_REG_MODE_MODE_MASK)
> > =C2=A0		=C2=A0=C2=A0=C2=A0 !=3D SCA3000_REG_MODE_MEAS_MODE_MOT_DET) {
> > -			ret =3D 0;
> > +			return 0;
> > =C2=A0		} else {
> > =C2=A0			ret =3D sca3000_read_ctrl_reg(st,
> > =C2=A0						SCA3000_REG_CTRL_SEL_MD_CTRL);
> > =C2=A0			if (ret < 0)
> > -				goto error_ret;
> > +				return ret;
> > =C2=A0			/* only supporting logical or's for now */
> > -			ret =3D !!(ret & sca3000_addresses[chan->address][2]);
> > +			return !!(ret & sca3000_addresses[chan->address][2]);
> > =C2=A0		}
> > -		break;
> > =C2=A0	default:
> > -		ret =3D -EINVAL;
> > +		return -EINVAL;
> > =C2=A0	}
> > -
> > -error_ret:
> > -	mutex_unlock(&st->lock);
> > -
> > -	return ret;
> > =C2=A0}
> > =C2=A0
> > =C2=A0static int sca3000_freefall_set_state(struct iio_dev *indio_dev, =
bool state)
> > @@ -1220,26 +1187,19 @@ static int sca3000_write_event_config(struct ii=
o_dev
> > *indio_dev,
> > =C2=A0	struct sca3000_state *st =3D iio_priv(indio_dev);
> > =C2=A0	int ret;
> > =C2=A0
> > -	mutex_lock(&st->lock);
> > +	guard(mutex)(&st->lock);
> > =C2=A0	switch (chan->channel2) {
> > =C2=A0	case IIO_MOD_X_AND_Y_AND_Z:
> > -		ret =3D sca3000_freefall_set_state(indio_dev, state);
> > -		break;
> > -
> > +		return sca3000_freefall_set_state(indio_dev, state);
> > =C2=A0	case IIO_MOD_X:
> > =C2=A0	case IIO_MOD_Y:
> > =C2=A0	case IIO_MOD_Z:
> > -		ret =3D sca3000_motion_detect_set_state(indio_dev,
> > +		return sca3000_motion_detect_set_state(indio_dev,
> > =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chan->address,
> > =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state);
> > -		break;
> > =C2=A0	default:
> > -		ret =3D -EINVAL;
> > -		break;
> > +		return -EINVAL;
> > =C2=A0	}
> > -	mutex_unlock(&st->lock);
> > -
> > -	return ret;
> > =C2=A0}
> > =C2=A0
> > =C2=A0static inline
> > @@ -1248,23 +1208,19 @@ int __sca3000_hw_ring_state_set(struct iio_dev =
*indio_dev,
> > bool state)
> > =C2=A0	struct sca3000_state *st =3D iio_priv(indio_dev);
> > =C2=A0	int ret;
> > =C2=A0
> > -	mutex_lock(&st->lock);
> > =C2=A0	ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR)=
);
> > =C2=A0	if (ret)
> > -		goto error_ret;
> > +		return ret;
> > +
> > =C2=A0	if (state) {
> > =C2=A0		dev_info(&indio_dev->dev, "supposedly enabling ring buffer\n");
> > -		ret =3D sca3000_write_reg(st,
> > +		return sca3000_write_reg(st,
> > =C2=A0			SCA3000_REG_MODE_ADDR,
> > =C2=A0			(ret | SCA3000_REG_MODE_RING_BUF_ENABLE));
> > -	} else
> > -		ret =3D sca3000_write_reg(st,
> > -			SCA3000_REG_MODE_ADDR,
> > -			(ret & ~SCA3000_REG_MODE_RING_BUF_ENABLE));
> > -error_ret:
> > -	mutex_unlock(&st->lock);
> > -
> > -	return ret;
> > +	}
> > +	return sca3000_write_reg(st,
> > +		SCA3000_REG_MODE_ADDR,
> > +		(ret & ~SCA3000_REG_MODE_RING_BUF_ENABLE));
> > =C2=A0}
> > =C2=A0
> > =C2=A0/**
> > @@ -1281,26 +1237,18 @@ static int sca3000_hw_ring_preenable(struct iio=
_dev
> > *indio_dev)
> > =C2=A0	int ret;
> > =C2=A0	struct sca3000_state *st =3D iio_priv(indio_dev);
> > =C2=A0
> > -	mutex_lock(&st->lock);
> > -
> > +	guard(mutex)(&st->lock);
> > =C2=A0	/* Enable the 50% full interrupt */
> > =C2=A0	ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_A=
DDR));
> > =C2=A0	if (ret)
> > -		goto error_unlock;
> > +		return ret;
> > =C2=A0	ret =3D sca3000_write_reg(st,
> > =C2=A0				SCA3000_REG_INT_MASK_ADDR,
> > =C2=A0				ret | SCA3000_REG_INT_MASK_RING_HALF);
> > =C2=A0	if (ret)
> > -		goto error_unlock;
> > -
> > -	mutex_unlock(&st->lock);
> > +		return ret;
> > =C2=A0
> > =C2=A0	return __sca3000_hw_ring_state_set(indio_dev, 1);
> > -
> > -error_unlock:
> > -	mutex_unlock(&st->lock);
> > -
> > -	return ret;
> > =C2=A0}
> > =C2=A0
> > =C2=A0static int sca3000_hw_ring_postdisable(struct iio_dev *indio_dev)
> > @@ -1308,22 +1256,18 @@ static int sca3000_hw_ring_postdisable(struct i=
io_dev
> > *indio_dev)
> > =C2=A0	int ret;
> > =C2=A0	struct sca3000_state *st =3D iio_priv(indio_dev);
> > =C2=A0
> > +	guard(mutex)(&st->lock);
> > =C2=A0	ret =3D __sca3000_hw_ring_state_set(indio_dev, 0);
> > =C2=A0	if (ret)
> > =C2=A0		return ret;
> > =C2=A0
> > =C2=A0	/* Disable the 50% full interrupt */
> > -	mutex_lock(&st->lock);
> > -
> > =C2=A0	ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_A=
DDR));
> > =C2=A0	if (ret)
> > -		goto unlock;
> > -	ret =3D sca3000_write_reg(st,
> > +		return ret;
> > +	return sca3000_write_reg(st,
> > =C2=A0				SCA3000_REG_INT_MASK_ADDR,
> > =C2=A0				ret & ~SCA3000_REG_INT_MASK_RING_HALF);
> > -unlock:
> > -	mutex_unlock(&st->lock);
> > -	return ret;
> > =C2=A0}
> > =C2=A0
> > =C2=A0static const struct iio_buffer_setup_ops sca3000_ring_setup_ops =
=3D {
> > @@ -1343,25 +1287,25 @@ static int sca3000_clean_setup(struct sca3000_s=
tate *st)
> > =C2=A0{
> > =C2=A0	int ret;
> > =C2=A0
> > -	mutex_lock(&st->lock);
> > +	guard(mutex)(&st->lock);
> > =C2=A0	/* Ensure all interrupts have been acknowledged */
> > =C2=A0	ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_A=
DDR));
> > =C2=A0	if (ret)
> > -		goto error_ret;
> > +		return ret;
> > =C2=A0
> > =C2=A0	/* Turn off all motion detection channels */
> > =C2=A0	ret =3D sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_MD_CTRL);
> > =C2=A0	if (ret < 0)
> > -		goto error_ret;
> > +		return ret;
> > =C2=A0	ret =3D sca3000_write_ctrl_reg(st, SCA3000_REG_CTRL_SEL_MD_CTRL,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 ret & SCA3000_MD_CTRL_PROT_MASK);
> > =C2=A0	if (ret)
> > -		goto error_ret;
> > +		return ret;
> > =C2=A0
> > =C2=A0	/* Disable ring buffer */
> > =C2=A0	ret =3D sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL);
> > =C2=A0	if (ret < 0)
> > -		goto error_ret;
> > +		return ret;
> > =C2=A0	ret =3D sca3000_write_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 (ret & SCA3000_REG_OUT_CTRL_PROT_MAS=
K)
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 | SCA3000_REG_OUT_CTRL_BUF_X_EN
> > @@ -1369,17 +1313,17 @@ static int sca3000_clean_setup(struct sca3000_s=
tate *st)
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 | SCA3000_REG_OUT_CTRL_BUF_Z_EN
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 | SCA3000_REG_OUT_CTRL_BUF_DIV_4);
> > =C2=A0	if (ret)
> > -		goto error_ret;
> > +		return ret;
> > =C2=A0	/* Enable interrupts, relevant to mode and set up as active low =
*/
> > =C2=A0	ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_A=
DDR));
> > =C2=A0	if (ret)
> > -		goto error_ret;
> > +		return ret;
> > =C2=A0	ret =3D sca3000_write_reg(st,
> > =C2=A0				SCA3000_REG_INT_MASK_ADDR,
> > =C2=A0				(ret & SCA3000_REG_INT_MASK_PROT_MASK)
> > =C2=A0				| SCA3000_REG_INT_MASK_ACTIVE_LOW);
> > =C2=A0	if (ret)
> > -		goto error_ret;
> > +		return ret;
> > =C2=A0	/*
> > =C2=A0	 * Select normal measurement mode, free fall off, ring off
> > =C2=A0	 * Ring in 12 bit mode - it is fine to overwrite reserved bits 3=
,5
> > @@ -1387,13 +1331,9 @@ static int sca3000_clean_setup(struct sca3000_st=
ate *st)
> > =C2=A0	 */
> > =C2=A0	ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR)=
);
> > =C2=A0	if (ret)
> > -		goto error_ret;
> > -	ret =3D sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
> > +		return ret;
> > +	return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
> > =C2=A0				ret & SCA3000_MODE_PROT_MASK);
> > -
> > -error_ret:
> > -	mutex_unlock(&st->lock);
> > -	return ret;
> > =C2=A0}
> > =C2=A0
> > =C2=A0static const struct iio_info sca3000_info =3D {
> > @@ -1471,19 +1411,16 @@ static int sca3000_stop_all_interrupts(struct s=
ca3000_state
> > *st)
> > =C2=A0{
> > =C2=A0	int ret;
> > =C2=A0
> > -	mutex_lock(&st->lock);
> > +	guard(mutex)(&st->lock);
> > =C2=A0	ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_A=
DDR));
> > =C2=A0	if (ret)
> > -		goto error_ret;
> > +		return ret;
> > =C2=A0
> > -	ret =3D sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
> > +	return sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
> > =C2=A0				ret &
> > =C2=A0				~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
> > =C2=A0				=C2=A0 SCA3000_REG_INT_MASK_RING_HALF |
> > =C2=A0				=C2=A0 SCA3000_REG_INT_MASK_ALL_INTS));
> > -error_ret:
> > -	mutex_unlock(&st->lock);
> > -	return ret;
> > =C2=A0}
> > =C2=A0
> > =C2=A0static void sca3000_remove(struct spi_device *spi) =20
>=20


