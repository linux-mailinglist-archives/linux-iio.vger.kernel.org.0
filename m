Return-Path: <linux-iio+bounces-20526-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65460AD693E
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 09:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C811719DD
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 07:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B0B20E70B;
	Thu, 12 Jun 2025 07:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElvSBGH0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC481E51EB;
	Thu, 12 Jun 2025 07:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749713871; cv=none; b=iTp07QYrawpwCn9lKnyzCCHskqH2FU58V2Y4+8Tv0t22OK9Y1I7ua6L09vHpZepD8esKete9wmdrpfQSAvurkGPkzqY7lUsoS0jSoiquHKXoTgeB75RgXiLUFGTy+sG40v3gHZg/uxSqQkqzUT4FIM3iR+DwW79J9S2cn3q52IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749713871; c=relaxed/simple;
	bh=X1xQm5L4ZOCoUnWaJLSbiEqfCpD15FXo7BwvXN6XHJM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EqUFvmZ5FywVQ38iEUiiQ8rlspNIkP72fqTwZb6DIKd7gh2gk0RmjY9wsNg8lImDYTcJ1BHP2/uT9LR65G61wUCtquhj+3W5GNny5o78lUX67BtNUlplNItBgYkjAYtdd7Rl1ke8tS6ap2lexNY/0JDtFDK+gUsmLtXpYunuIM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElvSBGH0; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a361b8a664so569651f8f.3;
        Thu, 12 Jun 2025 00:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749713868; x=1750318668; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m5GIspDP7X6wWgI2A2h0itSqo2tyEX++DMvUNjb6jiM=;
        b=ElvSBGH0ZwMZ0QPuZ8D63539B/n+4tXCIVoMFA1FprPMg5W4yNcV5ugHnpJ2zVf37i
         yOyn88lNBPQSbaHq4YV6XgBPJJEr8iFtOTYsV1tkigYJMKvdNqV3Qe/G/HUgeaNQG+n3
         dvUaIpqI30QmWcSQIYo2iRkPFgdGfsQZiYMXZqBUn8deZjRKasYvkBQ83ZaY5ascbtRv
         izvgj5nDIi9lrNDz5enh8Wh8tz6Ja+xRzo9wgy9q71SVQVMqG9mNKtg1DSm9tI/Mw3+G
         AWsnWmbOdW9XhGoymxu+S6ufWhaAQWBKBnTHNODiLbTkri9dxRo1B7o4ebY32fx5aUUO
         wUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749713868; x=1750318668;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m5GIspDP7X6wWgI2A2h0itSqo2tyEX++DMvUNjb6jiM=;
        b=fNds+TxCg03pMdXU/tLLg2IRBrVnNCWzu1US9VwHJ8R96SsO2w2bLn7tRMMmUysB18
         CisOWLHDd6F65iBxfTkAs9GETRJX417nICx4KfdxyyRAxJSRJmn3/z6INCArwsU1p1uU
         cGad5EcF+T8xtHMmtyX1LegJu33Et0KmsbLiqxbQ8TTKtjy3uHKrjY0RXo/zRSl5FIDu
         +0oW6gbK00vVmiparkzkQB3MGn9lbSaNFuwcJC0KkPxNCUhiNnx5OM4Jg9oF96geMYTY
         NyEfCGj9LyEMyflGNqEchS3n1htm6beNNvb+gJcfiJfcardL3HwsQU/pusV0TRsw976d
         qpEw==
X-Forwarded-Encrypted: i=1; AJvYcCX96O+J3afi4194d6KxAq5wC2Hx/2PQPgQd3OTk9SfZe3j59FXHf8EIYQ394iLwq5chx9J5nTGreGM=@vger.kernel.org, AJvYcCXWvLxCZEiztBcLLMEUqwfFOY7tPIIBkZHPG2umoiZ0DM7z+DEbpZ4onzNjXhnD4YaxEuwcGQqSmMZK53fI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4YmiHowcYDKiwMAYfROIdo1yAiEY/4iR3GB0pQqv9iw2IdXYg
	pL7/QYcxeGLIQvGeL7yKXc32+QSJ3iKjosKMO4Rj6ohHyLd7HAUeuRvA
X-Gm-Gg: ASbGncufVmjPG+hcRW/+DQ1vPe9F8CZ6l8oeokF+KrBIzvEp4MCyIGRu0/Nnpi9cjZX
	sFEiBCBqrWkQNxebSFqaQMDrk71ELHvB2SDsKyqEbMnAxHWN7fVTpxidqhJ4rJ9PXcP3hVndMrw
	bYbbdk697y/L3YYVoGLh4OmOhDk8d23N0hzp+DS7VvTJdKZtHXICzxVWeRg7T/AnltC1IMq1z1T
	VIOdJvn+JMRj8BTZlddihjD84TnGJK36ERzktDFECV+JCB/EX6mi98usfxCuZrXAD6lnLSLaUAl
	x8r1UjPSk220EUUWQ+AyTGsaZ8BPflGzCi+jyWjTK1bvQq/B9xwpr/EvRdASu1VlUoGUE0WNxg8
	esQheWTmDmKDqEoY3hY6OF2YFUyNfE0t0M0nI
X-Google-Smtp-Source: AGHT+IGWw5COUvVIf0mONy/K+/WhsCZ8yXo0GpkrgMXzoz6Y5BeD/coH/o7Nh9eYh9MhRjcqKG49Ow==
X-Received: by 2002:a05:6000:2002:b0:3a5:39a8:199c with SMTP id ffacd0b85a97d-3a558a436e7mr5890506f8f.53.1749713867530;
        Thu, 12 Jun 2025 00:37:47 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a561b510ebsm1115416f8f.83.2025.06.12.00.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 00:37:47 -0700 (PDT)
Message-ID: <c707bb2ad7334736c56687f20824be4b3ef71d74.camel@gmail.com>
Subject: Re: [PATCH v5 3/3] iio: accel: sca3000: use guard(mutex)() for
 handling mutex lock
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andrew Ijano <andrew.ijano@gmail.com>, jic23@kernel.org
Cc: andrew.lopes@alumni.usp.br, gustavobastos@usp.br, dlechner@baylibre.com,
  nuno.sa@analog.com, andy@kernel.org, jstephan@baylibre.com, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 12 Jun 2025 07:38:18 +0100
In-Reply-To: <20250611194648.18133-4-andrew.lopes@alumni.usp.br>
References: <20250611194648.18133-1-andrew.lopes@alumni.usp.br>
	 <20250611194648.18133-4-andrew.lopes@alumni.usp.br>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-06-11 at 16:39 -0300, Andrew Ijano wrote:
> Use guard(mutex)(&st->lock) for handling mutex lock instead of
> manually locking and unlocking the mutex. This prevents forgotten
> locks due to early exits and remove the need of gotos.
>=20
> Signed-off-by: Andrew Ijano <andrew.lopes@alumni.usp.br>
> Co-developed-by: Gustavo Bastos <gustavobastos@usp.br>
> Signed-off-by: Gustavo Bastos <gustavobastos@usp.br>
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> ---
> For this one, there are two cases where the previous implementation
> was a smalllocking portion of the code and now it's locking the whole
> function. I don't know if this is a desired behavior.
>=20

In theory, it should not break anything. But you can always refactor things=
 (like
small helpers) to lock only the code you want. There's also scoped_guard().=
 I would
say, up to you for re-spinning a new version because of the above :).=C2=A0

Just have something that I'm not totatlly sure... Did you made sure to comp=
ile?
AFAIR, guard() had some complains when used in switch() case statements. Ma=
ybe that
got improved.

If the above is not an issue:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/accel/sca3000.c | 177 ++++++++++++---------------------=
---
> =C2=A01 file changed, 57 insertions(+), 120 deletions(-)
>=20
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index d41759c68fb4..098d45bad389 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -405,17 +405,14 @@ static int sca3000_print_rev(struct iio_dev *indio_=
dev)
> =C2=A0	int ret;
> =C2=A0	struct sca3000_state *st =3D iio_priv(indio_dev);
> =C2=A0
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
> =C2=A0	ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_REVID_ADDR))=
;
> =C2=A0	if (ret < 0)
> -		goto error_ret;
> +		return ret;
> =C2=A0	dev_info(&indio_dev->dev,
> =C2=A0		 "sca3000 revision major=3D%lu, minor=3D%lu\n",
> =C2=A0		 ret & SCA3000_REG_REVID_MAJOR_MASK,
> =C2=A0		 ret & SCA3000_REG_REVID_MINOR_MASK);
> -error_ret:
> -	mutex_unlock(&st->lock);
> -
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> @@ -699,32 +696,25 @@ static int sca3000_read_raw(struct iio_dev *indio_d=
ev,
> =C2=A0
> =C2=A0	switch (mask) {
> =C2=A0	case IIO_CHAN_INFO_RAW:
> -		mutex_lock(&st->lock);
> +		guard(mutex)(&st->lock);
> =C2=A0		if (chan->type =3D=3D IIO_ACCEL) {
> -			if (st->mo_det_use_count) {
> -				mutex_unlock(&st->lock);
> +			if (st->mo_det_use_count)
> =C2=A0				return -EBUSY;
> -			}
> =C2=A0			address =3D sca3000_addresses[chan->address][0];
> =C2=A0			ret =3D spi_w8r16be(st->us, SCA3000_READ_REG(address));
> -			if (ret < 0) {
> -				mutex_unlock(&st->lock);
> +			if (ret < 0)
> =C2=A0				return ret;
> -			}
> =C2=A0			*val =3D sign_extend32(ret >> chan->scan_type.shift,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 chan->scan_type.realbits - 1);
> =C2=A0		} else {
> =C2=A0			/* get the temperature when available */
> =C2=A0			ret =3D spi_w8r16be(st->us,
> =C2=A0						SCA3000_READ_REG(SCA3000_REG_TEMP_
> MSB_ADDR));
> -			if (ret < 0) {
> -				mutex_unlock(&st->lock);
> +			if (ret < 0)
> =C2=A0				return ret;
> -			}
> =C2=A0			*val =3D (ret >> chan->scan_type.shift) &
> =C2=A0				GENMASK(chan->scan_type.realbits - 1, 0);
> =C2=A0		}
> -		mutex_unlock(&st->lock);
> =C2=A0		return IIO_VAL_INT;
> =C2=A0	case IIO_CHAN_INFO_SCALE:
> =C2=A0		*val =3D 0;
> @@ -738,14 +728,12 @@ static int sca3000_read_raw(struct iio_dev *indio_d=
ev,
> =C2=A0		*val2 =3D 600000;
> =C2=A0		return IIO_VAL_INT_PLUS_MICRO;
> =C2=A0	case IIO_CHAN_INFO_SAMP_FREQ:
> -		mutex_lock(&st->lock);
> +		guard(mutex)(&st->lock);
> =C2=A0		ret =3D sca3000_read_raw_samp_freq(st, val);
> -		mutex_unlock(&st->lock);
> =C2=A0		return ret ? ret : IIO_VAL_INT;
> =C2=A0	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> -		mutex_lock(&st->lock);
> +		guard(mutex)(&st->lock);
> =C2=A0		ret =3D sca3000_read_3db_freq(st, val);
> -		mutex_unlock(&st->lock);
> =C2=A0		return ret;
> =C2=A0	default:
> =C2=A0		return -EINVAL;
> @@ -763,22 +751,16 @@ static int sca3000_write_raw(struct iio_dev *indio_=
dev,
> =C2=A0	case IIO_CHAN_INFO_SAMP_FREQ:
> =C2=A0		if (val2)
> =C2=A0			return -EINVAL;
> -		mutex_lock(&st->lock);
> -		ret =3D sca3000_write_raw_samp_freq(st, val);
> -		mutex_unlock(&st->lock);
> -		return ret;
> +		guard(mutex)(&st->lock);
> +		return sca3000_write_raw_samp_freq(st, val);
> =C2=A0	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> =C2=A0		if (val2)
> =C2=A0			return -EINVAL;
> -		mutex_lock(&st->lock);
> -		ret =3D sca3000_write_3db_freq(st, val);
> -		mutex_unlock(&st->lock);
> -		return ret;
> +		guard(mutex)(&st->lock);
> +		return sca3000_write_3db_freq(st, val);
> =C2=A0	default:
> =C2=A0		return -EINVAL;
> =C2=A0	}
> -
> -	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0/**
> @@ -800,9 +782,8 @@ static ssize_t sca3000_read_av_freq(struct device *de=
v,
> =C2=A0	struct sca3000_state *st =3D iio_priv(indio_dev);
> =C2=A0	int len =3D 0, ret;
> =C2=A0
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
> =C2=A0	ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
> -	mutex_unlock(&st->lock);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> @@ -851,10 +832,9 @@ static int sca3000_read_event_value(struct iio_dev *=
indio_dev,
> =C2=A0
> =C2=A0	switch (info) {
> =C2=A0	case IIO_EV_INFO_VALUE:
> -		mutex_lock(&st->lock);
> +		guard(mutex)(&st->lock);
> =C2=A0		ret =3D sca3000_read_ctrl_reg(st,
> =C2=A0					=C2=A0=C2=A0=C2=A0 sca3000_addresses[chan->address][1]);
> -		mutex_unlock(&st->lock);
> =C2=A0		if (ret < 0)
> =C2=A0			return ret;
> =C2=A0		*val =3D 0;
> @@ -918,13 +898,10 @@ static int sca3000_write_event_value(struct iio_dev
> *indio_dev,
> =C2=A0			}
> =C2=A0	}
> =C2=A0
> -	mutex_lock(&st->lock);
> -	ret =3D sca3000_write_ctrl_reg(st,
> +	guard(mutex)(&st->lock);
> +	return sca3000_write_ctrl_reg(st,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 sca3000_addresses[chan->address][1],
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 nonlinear);
> -	mutex_unlock(&st->lock);
> -
> -	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0static struct attribute *sca3000_attributes[] =3D {
> @@ -969,12 +946,12 @@ static void sca3000_ring_int_process(u8 val, struct=
 iio_dev
> *indio_dev)
> =C2=A0	struct sca3000_state *st =3D iio_priv(indio_dev);
> =C2=A0	int ret, i, num_available;
> =C2=A0
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
> =C2=A0
> =C2=A0	if (val & SCA3000_REG_INT_STATUS_HALF) {
> =C2=A0		ret =3D spi_w8r8(st->us,
> SCA3000_READ_REG(SCA3000_REG_BUF_COUNT_ADDR));
> =C2=A0		if (ret)
> -			goto error_ret;
> +			return;
> =C2=A0		num_available =3D ret;
> =C2=A0		/*
> =C2=A0		 * num_available is the total number of samples available
> @@ -983,7 +960,7 @@ static void sca3000_ring_int_process(u8 val, struct i=
io_dev
> *indio_dev)
> =C2=A0		ret =3D sca3000_read_data(st, SCA3000_REG_RING_OUT_ADDR,
> =C2=A0					num_available * 2);
> =C2=A0		if (ret)
> -			goto error_ret;
> +			return;
> =C2=A0		for (i =3D 0; i < num_available / 3; i++) {
> =C2=A0			/*
> =C2=A0			 * Dirty hack to cover for 11 bit in fifo, 13 bit
> @@ -995,8 +972,6 @@ static void sca3000_ring_int_process(u8 val, struct i=
io_dev
> *indio_dev)
> =C2=A0			iio_push_to_buffers(indio_dev, st->rx + i * 3 * 2);
> =C2=A0		}
> =C2=A0	}
> -error_ret:
> -	mutex_unlock(&st->lock);
> =C2=A0}
> =C2=A0
> =C2=A0/**
> @@ -1022,9 +997,8 @@ static irqreturn_t sca3000_event_handler(int irq, vo=
id
> *private)
> =C2=A0	 * Could lead if badly timed to an extra read of status reg,
> =C2=A0	 * but ensures no interrupt is missed.
> =C2=A0	 */
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
> =C2=A0	ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_STATUS_A=
DDR));
> -	mutex_unlock(&st->lock);
> =C2=A0	if (ret)
> =C2=A0		goto done;
> =C2=A0
> @@ -1081,16 +1055,15 @@ static int sca3000_read_event_config(struct iio_d=
ev
> *indio_dev,
> =C2=A0	struct sca3000_state *st =3D iio_priv(indio_dev);
> =C2=A0	int ret;
> =C2=A0	/* read current value of mode register */
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
> =C2=A0
> =C2=A0	ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
> =C2=A0	if (ret)
> -		goto error_ret;
> +		return ret;
> =C2=A0
> =C2=A0	switch (chan->channel2) {
> =C2=A0	case IIO_MOD_X_AND_Y_AND_Z:
> -		ret =3D !!(ret & SCA3000_REG_MODE_FREE_FALL_DETECT);
> -		break;
> +		return !!(ret & SCA3000_REG_MODE_FREE_FALL_DETECT);
> =C2=A0	case IIO_MOD_X:
> =C2=A0	case IIO_MOD_Y:
> =C2=A0	case IIO_MOD_Z:
> @@ -1100,24 +1073,18 @@ static int sca3000_read_event_config(struct iio_d=
ev
> *indio_dev,
> =C2=A0		 */
> =C2=A0		if ((ret & SCA3000_REG_MODE_MODE_MASK)
> =C2=A0		=C2=A0=C2=A0=C2=A0 !=3D SCA3000_REG_MODE_MEAS_MODE_MOT_DET) {
> -			ret =3D 0;
> +			return 0;
> =C2=A0		} else {
> =C2=A0			ret =3D sca3000_read_ctrl_reg(st,
> =C2=A0						SCA3000_REG_CTRL_SEL_MD_CTRL);
> =C2=A0			if (ret < 0)
> -				goto error_ret;
> +				return ret;
> =C2=A0			/* only supporting logical or's for now */
> -			ret =3D !!(ret & sca3000_addresses[chan->address][2]);
> +			return !!(ret & sca3000_addresses[chan->address][2]);
> =C2=A0		}
> -		break;
> =C2=A0	default:
> -		ret =3D -EINVAL;
> +		return -EINVAL;
> =C2=A0	}
> -
> -error_ret:
> -	mutex_unlock(&st->lock);
> -
> -	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0static int sca3000_freefall_set_state(struct iio_dev *indio_dev, bo=
ol state)
> @@ -1220,26 +1187,19 @@ static int sca3000_write_event_config(struct iio_=
dev
> *indio_dev,
> =C2=A0	struct sca3000_state *st =3D iio_priv(indio_dev);
> =C2=A0	int ret;
> =C2=A0
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
> =C2=A0	switch (chan->channel2) {
> =C2=A0	case IIO_MOD_X_AND_Y_AND_Z:
> -		ret =3D sca3000_freefall_set_state(indio_dev, state);
> -		break;
> -
> +		return sca3000_freefall_set_state(indio_dev, state);
> =C2=A0	case IIO_MOD_X:
> =C2=A0	case IIO_MOD_Y:
> =C2=A0	case IIO_MOD_Z:
> -		ret =3D sca3000_motion_detect_set_state(indio_dev,
> +		return sca3000_motion_detect_set_state(indio_dev,
> =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chan->address,
> =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state);
> -		break;
> =C2=A0	default:
> -		ret =3D -EINVAL;
> -		break;
> +		return -EINVAL;
> =C2=A0	}
> -	mutex_unlock(&st->lock);
> -
> -	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0static inline
> @@ -1248,23 +1208,19 @@ int __sca3000_hw_ring_state_set(struct iio_dev *i=
ndio_dev,
> bool state)
> =C2=A0	struct sca3000_state *st =3D iio_priv(indio_dev);
> =C2=A0	int ret;
> =C2=A0
> -	mutex_lock(&st->lock);
> =C2=A0	ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
> =C2=A0	if (ret)
> -		goto error_ret;
> +		return ret;
> +
> =C2=A0	if (state) {
> =C2=A0		dev_info(&indio_dev->dev, "supposedly enabling ring buffer\n");
> -		ret =3D sca3000_write_reg(st,
> +		return sca3000_write_reg(st,
> =C2=A0			SCA3000_REG_MODE_ADDR,
> =C2=A0			(ret | SCA3000_REG_MODE_RING_BUF_ENABLE));
> -	} else
> -		ret =3D sca3000_write_reg(st,
> -			SCA3000_REG_MODE_ADDR,
> -			(ret & ~SCA3000_REG_MODE_RING_BUF_ENABLE));
> -error_ret:
> -	mutex_unlock(&st->lock);
> -
> -	return ret;
> +	}
> +	return sca3000_write_reg(st,
> +		SCA3000_REG_MODE_ADDR,
> +		(ret & ~SCA3000_REG_MODE_RING_BUF_ENABLE));
> =C2=A0}
> =C2=A0
> =C2=A0/**
> @@ -1281,26 +1237,18 @@ static int sca3000_hw_ring_preenable(struct iio_d=
ev
> *indio_dev)
> =C2=A0	int ret;
> =C2=A0	struct sca3000_state *st =3D iio_priv(indio_dev);
> =C2=A0
> -	mutex_lock(&st->lock);
> -
> +	guard(mutex)(&st->lock);
> =C2=A0	/* Enable the 50% full interrupt */
> =C2=A0	ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_ADD=
R));
> =C2=A0	if (ret)
> -		goto error_unlock;
> +		return ret;
> =C2=A0	ret =3D sca3000_write_reg(st,
> =C2=A0				SCA3000_REG_INT_MASK_ADDR,
> =C2=A0				ret | SCA3000_REG_INT_MASK_RING_HALF);
> =C2=A0	if (ret)
> -		goto error_unlock;
> -
> -	mutex_unlock(&st->lock);
> +		return ret;
> =C2=A0
> =C2=A0	return __sca3000_hw_ring_state_set(indio_dev, 1);
> -
> -error_unlock:
> -	mutex_unlock(&st->lock);
> -
> -	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0static int sca3000_hw_ring_postdisable(struct iio_dev *indio_dev)
> @@ -1308,22 +1256,18 @@ static int sca3000_hw_ring_postdisable(struct iio=
_dev
> *indio_dev)
> =C2=A0	int ret;
> =C2=A0	struct sca3000_state *st =3D iio_priv(indio_dev);
> =C2=A0
> +	guard(mutex)(&st->lock);
> =C2=A0	ret =3D __sca3000_hw_ring_state_set(indio_dev, 0);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> =C2=A0	/* Disable the 50% full interrupt */
> -	mutex_lock(&st->lock);
> -
> =C2=A0	ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_ADD=
R));
> =C2=A0	if (ret)
> -		goto unlock;
> -	ret =3D sca3000_write_reg(st,
> +		return ret;
> +	return sca3000_write_reg(st,
> =C2=A0				SCA3000_REG_INT_MASK_ADDR,
> =C2=A0				ret & ~SCA3000_REG_INT_MASK_RING_HALF);
> -unlock:
> -	mutex_unlock(&st->lock);
> -	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0static const struct iio_buffer_setup_ops sca3000_ring_setup_ops =3D=
 {
> @@ -1343,25 +1287,25 @@ static int sca3000_clean_setup(struct sca3000_sta=
te *st)
> =C2=A0{
> =C2=A0	int ret;
> =C2=A0
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
> =C2=A0	/* Ensure all interrupts have been acknowledged */
> =C2=A0	ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_ADD=
R));
> =C2=A0	if (ret)
> -		goto error_ret;
> +		return ret;
> =C2=A0
> =C2=A0	/* Turn off all motion detection channels */
> =C2=A0	ret =3D sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_MD_CTRL);
> =C2=A0	if (ret < 0)
> -		goto error_ret;
> +		return ret;
> =C2=A0	ret =3D sca3000_write_ctrl_reg(st, SCA3000_REG_CTRL_SEL_MD_CTRL,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 ret & SCA3000_MD_CTRL_PROT_MASK);
> =C2=A0	if (ret)
> -		goto error_ret;
> +		return ret;
> =C2=A0
> =C2=A0	/* Disable ring buffer */
> =C2=A0	ret =3D sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL);
> =C2=A0	if (ret < 0)
> -		goto error_ret;
> +		return ret;
> =C2=A0	ret =3D sca3000_write_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 (ret & SCA3000_REG_OUT_CTRL_PROT_MASK)
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 | SCA3000_REG_OUT_CTRL_BUF_X_EN
> @@ -1369,17 +1313,17 @@ static int sca3000_clean_setup(struct sca3000_sta=
te *st)
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 | SCA3000_REG_OUT_CTRL_BUF_Z_EN
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 | SCA3000_REG_OUT_CTRL_BUF_DIV_4);
> =C2=A0	if (ret)
> -		goto error_ret;
> +		return ret;
> =C2=A0	/* Enable interrupts, relevant to mode and set up as active low */
> =C2=A0	ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_ADD=
R));
> =C2=A0	if (ret)
> -		goto error_ret;
> +		return ret;
> =C2=A0	ret =3D sca3000_write_reg(st,
> =C2=A0				SCA3000_REG_INT_MASK_ADDR,
> =C2=A0				(ret & SCA3000_REG_INT_MASK_PROT_MASK)
> =C2=A0				| SCA3000_REG_INT_MASK_ACTIVE_LOW);
> =C2=A0	if (ret)
> -		goto error_ret;
> +		return ret;
> =C2=A0	/*
> =C2=A0	 * Select normal measurement mode, free fall off, ring off
> =C2=A0	 * Ring in 12 bit mode - it is fine to overwrite reserved bits 3,5
> @@ -1387,13 +1331,9 @@ static int sca3000_clean_setup(struct sca3000_stat=
e *st)
> =C2=A0	 */
> =C2=A0	ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
> =C2=A0	if (ret)
> -		goto error_ret;
> -	ret =3D sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
> +		return ret;
> +	return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
> =C2=A0				ret & SCA3000_MODE_PROT_MASK);
> -
> -error_ret:
> -	mutex_unlock(&st->lock);
> -	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0static const struct iio_info sca3000_info =3D {
> @@ -1471,19 +1411,16 @@ static int sca3000_stop_all_interrupts(struct sca=
3000_state
> *st)
> =C2=A0{
> =C2=A0	int ret;
> =C2=A0
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
> =C2=A0	ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_ADD=
R));
> =C2=A0	if (ret)
> -		goto error_ret;
> +		return ret;
> =C2=A0
> -	ret =3D sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
> +	return sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
> =C2=A0				ret &
> =C2=A0				~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
> =C2=A0				=C2=A0 SCA3000_REG_INT_MASK_RING_HALF |
> =C2=A0				=C2=A0 SCA3000_REG_INT_MASK_ALL_INTS));
> -error_ret:
> -	mutex_unlock(&st->lock);
> -	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0static void sca3000_remove(struct spi_device *spi)


