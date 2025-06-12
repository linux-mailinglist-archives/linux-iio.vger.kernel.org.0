Return-Path: <linux-iio+bounces-20525-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E59AD6900
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 09:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7219A1888393
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 07:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EF21F8908;
	Thu, 12 Jun 2025 07:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSv5Szs+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95C079E1;
	Thu, 12 Jun 2025 07:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749713347; cv=none; b=XdnOFnpjsWA3c+h6yO3W6chm2R2J9U9hkisFWDIJJFvu04teqPiZOvYSWqwzX6/e+QEtzlAsqWbLPlE9s2R2THEkkwQZH8++LjdFhNKXCGFye6ETVLpjcauM6VYOurmeIO4awUA/3wNIbr9almUxlnPIjDy1GqB56gxJNlR1PD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749713347; c=relaxed/simple;
	bh=X0FTrp/R/lIegGoDUVzTjr6HANWCJx4bamhehvKO4eU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ND0+rCYSE8wa/4uddmaRfS47HYyFzt2qJi5iK7Rf0N4dvVKb0oZyI2DO19y/vw9woxoAaSEBI1Aolr6MPWn/twBkWVOBy21EG2/kN31R6FJj9EVUM/HRDq3cTKaqPTHoSSc7f3noevLcLf3Ad1d6wzrszWs9raILzfcUiJ9peZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSv5Szs+; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-450cf214200so5140035e9.1;
        Thu, 12 Jun 2025 00:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749713344; x=1750318144; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k5rsRc3oaJQ0aUQI/xHoM1EtK1DWZnKKYa3+PrwYcGA=;
        b=aSv5Szs+ceRAQ0/Z867Yameq+S1edvF4FJsM0emjQLLnujCtVZn8iMjOsCn/U0rbXB
         WDMS/FEB0toOxHJGcwnmk75WtbMD3rkUIMfVhneJHRK3L3eIUh73pjXHQc5cDooMi1I9
         fs1HNLBjIj6CqWkcEzATVhyH1AOSZjPDoewsZ8i0pU4Vrygq8Rf+gM4eL9vO7juDZi1D
         fBj6xt0Qw/l9gnvyJ6QQtc8AN3Rq9fpKqfI/qdnTiYrz7w5rxo/LjN0vWj8LzhjeIUAM
         9FIF1sMYAV2W1Coc4VqFYmPw7ZLjVvK1M17dRtURuhljhFJK0YT0eS9meHGnVhJq/BKS
         RbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749713344; x=1750318144;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k5rsRc3oaJQ0aUQI/xHoM1EtK1DWZnKKYa3+PrwYcGA=;
        b=Q8LkX4rf30mNH8oJbgKkyVI+XROVYBVEwtKPBaY1db0qw25cWYft+CoRY4MQyVSikG
         Oba/9Le30aoRhaqIfEotBgjnLPgYJTPL0GwujK6Qg5HRzJm1i29/DjiPeFVHxBQFFJ5z
         32hfehbPbSlK8Umhg0FVx5zME5jujEfJ/gxcVlafngfbvx4gaZTHG1k1aAYiVfMANIK/
         4f6S3Wejw1KEV/OUFYwQ6EDyG0jyzA4Hi8qQ7EQ12Y9hnNeNvC6PV5+lFbOatEy0lUvQ
         emVYT/YCGjZMLiBrQ42uGv/TDlUEB2mbxibiLCCkOlk8O4WQNrZ01HpliNdGxAUUyYg8
         xNKg==
X-Forwarded-Encrypted: i=1; AJvYcCUIX3uIfTGQUQ0DbQf5gPHshUfwXGPwYzgAYy6pouVQN5nS3yu//sxbsWUBd3zuqSori1XcoHJCDlX1QU4w@vger.kernel.org, AJvYcCXaCAdL/KXZfirKeGAetDZ4wl7l5GXWxnftmth1zoJn03F5xIofDbBREvqk7YKMrchT2sqgxKInVWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7WIJuGd/Mh9gfnblyiYn4/XuecqGD2dFk74EkqHUu4jyyxI4c
	b9JEToT9xEgj2UpF2M1cKgVs2uMfNX0pbzgvlTnPXMaIXi2EylWq7MtC
X-Gm-Gg: ASbGncu23bYzWvfbsix5qmpG3BRDm3TOkYHGuna6Iy152FuHi1YEbH1cWnUn+9EMBcY
	ghwxyRp7LLhYDd9CUoDERm5Krf0vVja4gxlq0iKjLGpmLObYNIHZ+hOWiuTUSiuOzPqA2YlOtki
	Tn007YAEO1qNh9aeJU0xOC848unpYlOhZiUevC47gveRTKsh2yxDoFdz/XHMkg8Fnd2C4711ATP
	Sknbv22tEJ9pcYKKXeQkRRaxmOMWZkUzbyx7zjQdN2Zu7XXr/GQteYdpLF7uAiB940RMCimWVCF
	YfQaB8qfVhyoDtVuPwuKCxuYnIdT1Otw9dAqcclGzUGbQAaE3yuRrrQaPSVN76uaunE8DPcPStn
	MQyH4hks7ozputkma2f86tlBx1Wf+OA9Aitqn
X-Google-Smtp-Source: AGHT+IEh8KrU6+FfhTEntGxofDae6xv4P3kTFmAzBGjC94QSPtuH4F1ePSrPaFbPyNtsQ5r0arMXSA==
X-Received: by 2002:a05:6000:2086:b0:3a4:e6c6:b8bf with SMTP id ffacd0b85a97d-3a56080ac65mr1853632f8f.52.1749713343769;
        Thu, 12 Jun 2025 00:29:03 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a561b510dfsm1091528f8f.82.2025.06.12.00.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 00:29:03 -0700 (PDT)
Message-ID: <84643f3fc87425e8c5019eede275791a20872b6b.camel@gmail.com>
Subject: Re: [PATCH v5 2/3] iio: accel: sca3000: replace usages of internal
 read data helpers by spi helpers
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andrew Ijano <andrew.ijano@gmail.com>, jic23@kernel.org
Cc: andrew.lopes@alumni.usp.br, gustavobastos@usp.br, dlechner@baylibre.com,
  nuno.sa@analog.com, andy@kernel.org, jstephan@baylibre.com, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 12 Jun 2025 07:29:35 +0100
In-Reply-To: <20250611194648.18133-3-andrew.lopes@alumni.usp.br>
References: <20250611194648.18133-1-andrew.lopes@alumni.usp.br>
	 <20250611194648.18133-3-andrew.lopes@alumni.usp.br>
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
> Remove usages of sca3000_read_data() and sca3000_read_data_short()
> functions, replacing it by spi_w8r8() and spi_w8r16be() helpers. Just
> one case that reads large buffers is left using an internal helper.
>=20
> This is an old driver that was not making full use of the newer
> infrastructure.
>=20
> Signed-off-by: Andrew Ijano <andrew.lopes@alumni.usp.br>
> Co-developed-by: Gustavo Bastos <gustavobastos@usp.br>
> Signed-off-by: Gustavo Bastos <gustavobastos@usp.br>
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> ---

Looks good. Just one comment from me...

> =C2=A0drivers/iio/accel/sca3000.c | 166 +++++++++++++++------------------=
---
> =C2=A01 file changed, 68 insertions(+), 98 deletions(-)
>=20
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index bfa8a3f5a92f..d41759c68fb4 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -281,24 +281,6 @@ static int sca3000_write_reg(struct sca3000_state *s=
t, u8
> address, u8 val)
> =C2=A0	return spi_write(st->us, st->tx, 2);
> =C2=A0}
> =C2=A0

...

>=20
> =C2=A0static int sca3000_read_data(struct sca3000_state *st,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 u8 reg_address_high,
> -			=C2=A0=C2=A0=C2=A0=C2=A0 u8 *rx,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 int len)
> =C2=A0{
> =C2=A0	int ret;
> @@ -974,18 +948,15 @@ static int sca3000_read_data(struct sca3000_state *=
st,
> =C2=A0			.tx_buf =3D st->tx,
> =C2=A0		}, {
> =C2=A0			.len =3D len,
> -			.rx_buf =3D rx,
> +			.rx_buf =3D st->rx,
> =C2=A0		}
> =C2=A0	};
> -
> =C2=A0	st->tx[0] =3D SCA3000_READ_REG(reg_address_high);
> +
> =C2=A0	ret =3D spi_sync_transfer(st->us, xfer, ARRAY_SIZE(xfer));
> -	if (ret) {
> +	if (ret)
> =C2=A0		dev_err(&st->us->dev, "problem reading register\n");
> -		return ret;
> -	}
> -
> -	return 0;
> +	return ret;

Unless I'm missing something, the above seems unrelated to the rest of the =
patch.

- Nuno S=C3=A1

> =C2=A0}
> =C2=A0
> =C2=A0/**
> @@ -1001,16 +972,15 @@ static void sca3000_ring_int_process(u8 val, struc=
t iio_dev
> *indio_dev)
> =C2=A0	mutex_lock(&st->lock);
> =C2=A0
> =C2=A0	if (val & SCA3000_REG_INT_STATUS_HALF) {
> -		ret =3D sca3000_read_data_short(st, SCA3000_REG_BUF_COUNT_ADDR,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1);
> +		ret =3D spi_w8r8(st->us,
> SCA3000_READ_REG(SCA3000_REG_BUF_COUNT_ADDR));
> =C2=A0		if (ret)
> =C2=A0			goto error_ret;
> -		num_available =3D st->rx[0];
> +		num_available =3D ret;
> =C2=A0		/*
> =C2=A0		 * num_available is the total number of samples available
> =C2=A0		 * i.e. number of time points * number of channels.
> =C2=A0		 */
> -		ret =3D sca3000_read_data(st, SCA3000_REG_RING_OUT_ADDR, st->rx,
> +		ret =3D sca3000_read_data(st, SCA3000_REG_RING_OUT_ADDR,
> =C2=A0					num_available * 2);
> =C2=A0		if (ret)
> =C2=A0			goto error_ret;
> @@ -1045,7 +1015,7 @@ static irqreturn_t sca3000_event_handler(int irq, v=
oid
> *private)
> =C2=A0{
> =C2=A0	struct iio_dev *indio_dev =3D private;
> =C2=A0	struct sca3000_state *st =3D iio_priv(indio_dev);
> -	int ret, val;
> +	int ret;
> =C2=A0	s64 last_timestamp =3D iio_get_time_ns(indio_dev);
> =C2=A0
> =C2=A0	/*
> @@ -1053,15 +1023,14 @@ static irqreturn_t sca3000_event_handler(int irq,=
 void
> *private)
> =C2=A0	 * but ensures no interrupt is missed.
> =C2=A0	 */
> =C2=A0	mutex_lock(&st->lock);
> -	ret =3D sca3000_read_data_short(st, SCA3000_REG_INT_STATUS_ADDR, 1);
> -	val =3D st->rx[0];
> +	ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_STATUS_ADDR))=
;
> =C2=A0	mutex_unlock(&st->lock);
> =C2=A0	if (ret)
> =C2=A0		goto done;
> =C2=A0
> -	sca3000_ring_int_process(val, indio_dev);
> +	sca3000_ring_int_process(ret, indio_dev);
> =C2=A0
> -	if (val & SCA3000_INT_STATUS_FREE_FALL)
> +	if (ret & SCA3000_INT_STATUS_FREE_FALL)
> =C2=A0		iio_push_event(indio_dev,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_MOD_EVENT_CODE(IIO_ACCE=
L,
> =C2=A0						=C2=A0 0,
> @@ -1070,7 +1039,7 @@ static irqreturn_t sca3000_event_handler(int irq, v=
oid
> *private)
> =C2=A0						=C2=A0 IIO_EV_DIR_FALLING),
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last_timestamp);
> =C2=A0
> -	if (val & SCA3000_INT_STATUS_Y_TRIGGER)
> +	if (ret & SCA3000_INT_STATUS_Y_TRIGGER)
> =C2=A0		iio_push_event(indio_dev,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_MOD_EVENT_CODE(IIO_ACCE=
L,
> =C2=A0						=C2=A0 0,
> @@ -1079,7 +1048,7 @@ static irqreturn_t sca3000_event_handler(int irq, v=
oid
> *private)
> =C2=A0						=C2=A0 IIO_EV_DIR_RISING),
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last_timestamp);
> =C2=A0
> -	if (val & SCA3000_INT_STATUS_X_TRIGGER)
> +	if (ret & SCA3000_INT_STATUS_X_TRIGGER)
> =C2=A0		iio_push_event(indio_dev,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_MOD_EVENT_CODE(IIO_ACCE=
L,
> =C2=A0						=C2=A0 0,
> @@ -1088,7 +1057,7 @@ static irqreturn_t sca3000_event_handler(int irq, v=
oid
> *private)
> =C2=A0						=C2=A0 IIO_EV_DIR_RISING),
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last_timestamp);
> =C2=A0
> -	if (val & SCA3000_INT_STATUS_Z_TRIGGER)
> +	if (ret & SCA3000_INT_STATUS_Z_TRIGGER)
> =C2=A0		iio_push_event(indio_dev,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_MOD_EVENT_CODE(IIO_ACCE=
L,
> =C2=A0						=C2=A0 0,
> @@ -1114,13 +1083,13 @@ static int sca3000_read_event_config(struct iio_d=
ev
> *indio_dev,
> =C2=A0	/* read current value of mode register */
> =C2=A0	mutex_lock(&st->lock);
> =C2=A0
> -	ret =3D sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
> +	ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
> =C2=A0	if (ret)
> =C2=A0		goto error_ret;
> =C2=A0
> =C2=A0	switch (chan->channel2) {
> =C2=A0	case IIO_MOD_X_AND_Y_AND_Z:
> -		ret =3D !!(st->rx[0] & SCA3000_REG_MODE_FREE_FALL_DETECT);
> +		ret =3D !!(ret & SCA3000_REG_MODE_FREE_FALL_DETECT);
> =C2=A0		break;
> =C2=A0	case IIO_MOD_X:
> =C2=A0	case IIO_MOD_Y:
> @@ -1129,7 +1098,7 @@ static int sca3000_read_event_config(struct iio_dev
> *indio_dev,
> =C2=A0		 * Motion detection mode cannot run at the same time as
> =C2=A0		 * acceleration data being read.
> =C2=A0		 */
> -		if ((st->rx[0] & SCA3000_REG_MODE_MODE_MASK)
> +		if ((ret & SCA3000_REG_MODE_MODE_MASK)
> =C2=A0		=C2=A0=C2=A0=C2=A0 !=3D SCA3000_REG_MODE_MEAS_MODE_MOT_DET) {
> =C2=A0			ret =3D 0;
> =C2=A0		} else {
> @@ -1157,20 +1126,20 @@ static int sca3000_freefall_set_state(struct iio_=
dev
> *indio_dev, bool state)
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	/* read current value of mode register */
> -	ret =3D sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
> +	ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> =C2=A0	/* if off and should be on */
> -	if (state && !(st->rx[0] & SCA3000_REG_MODE_FREE_FALL_DETECT))
> +	if (state && !(ret & SCA3000_REG_MODE_FREE_FALL_DETECT))
> =C2=A0		return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
> -					 st->rx[0] |
> SCA3000_REG_MODE_FREE_FALL_DETECT);
> +					 ret | SCA3000_REG_MODE_FREE_FALL_DETECT);
> =C2=A0	/* if on and should be off */
> -	else if (!state && (st->rx[0] & SCA3000_REG_MODE_FREE_FALL_DETECT))
> +	if (!state && (ret & SCA3000_REG_MODE_FREE_FALL_DETECT))
> =C2=A0		return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
> -					 st->rx[0] &
> ~SCA3000_REG_MODE_FREE_FALL_DETECT);
> -	else
> -		return 0;
> +					 ret &
> ~SCA3000_REG_MODE_FREE_FALL_DETECT);
> +
> +	return 0;
> =C2=A0}
> =C2=A0
> =C2=A0static int sca3000_motion_detect_set_state(struct iio_dev *indio_de=
v, int axis,
> @@ -1207,22 +1176,22 @@ static int sca3000_motion_detect_set_state(struct=
 iio_dev
> *indio_dev, int axis,
> =C2=A0	}
> =C2=A0
> =C2=A0	/* read current value of mode register */
> -	ret =3D sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
> +	ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0	/* if off and should be on */
> =C2=A0	if ((st->mo_det_use_count) &&
> -	=C2=A0=C2=A0=C2=A0 ((st->rx[0] & SCA3000_REG_MODE_MODE_MASK)
> +	=C2=A0=C2=A0=C2=A0 ((ret & SCA3000_REG_MODE_MODE_MASK)
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0 !=3D SCA3000_REG_MODE_MEAS_MODE_MOT_DET))
> =C2=A0		return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
> -			(st->rx[0] & ~SCA3000_REG_MODE_MODE_MASK)
> +			(ret & ~SCA3000_REG_MODE_MODE_MASK)
> =C2=A0			| SCA3000_REG_MODE_MEAS_MODE_MOT_DET);
> =C2=A0	/* if on and should be off */
> =C2=A0	else if (!(st->mo_det_use_count) &&
> -		 ((st->rx[0] & SCA3000_REG_MODE_MODE_MASK)
> +		 ((ret & SCA3000_REG_MODE_MODE_MASK)
> =C2=A0		=C2=A0 =3D=3D SCA3000_REG_MODE_MEAS_MODE_MOT_DET))
> =C2=A0		return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
> -			st->rx[0] & SCA3000_REG_MODE_MODE_MASK);
> +			ret & SCA3000_REG_MODE_MODE_MASK);
> =C2=A0	else
> =C2=A0		return 0;
> =C2=A0}
> @@ -1280,18 +1249,18 @@ int __sca3000_hw_ring_state_set(struct iio_dev *i=
ndio_dev,
> bool state)
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	mutex_lock(&st->lock);
> -	ret =3D sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
> +	ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
> =C2=A0	if (ret)
> =C2=A0		goto error_ret;
> =C2=A0	if (state) {
> =C2=A0		dev_info(&indio_dev->dev, "supposedly enabling ring buffer\n");
> =C2=A0		ret =3D sca3000_write_reg(st,
> =C2=A0			SCA3000_REG_MODE_ADDR,
> -			(st->rx[0] | SCA3000_REG_MODE_RING_BUF_ENABLE));
> +			(ret | SCA3000_REG_MODE_RING_BUF_ENABLE));
> =C2=A0	} else
> =C2=A0		ret =3D sca3000_write_reg(st,
> =C2=A0			SCA3000_REG_MODE_ADDR,
> -			(st->rx[0] & ~SCA3000_REG_MODE_RING_BUF_ENABLE));
> +			(ret & ~SCA3000_REG_MODE_RING_BUF_ENABLE));
> =C2=A0error_ret:
> =C2=A0	mutex_unlock(&st->lock);
> =C2=A0
> @@ -1315,12 +1284,12 @@ static int sca3000_hw_ring_preenable(struct iio_d=
ev
> *indio_dev)
> =C2=A0	mutex_lock(&st->lock);
> =C2=A0
> =C2=A0	/* Enable the 50% full interrupt */
> -	ret =3D sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
> +	ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_ADDR));
> =C2=A0	if (ret)
> =C2=A0		goto error_unlock;
> =C2=A0	ret =3D sca3000_write_reg(st,
> =C2=A0				SCA3000_REG_INT_MASK_ADDR,
> -				st->rx[0] | SCA3000_REG_INT_MASK_RING_HALF);
> +				ret | SCA3000_REG_INT_MASK_RING_HALF);
> =C2=A0	if (ret)
> =C2=A0		goto error_unlock;
> =C2=A0
> @@ -1346,12 +1315,12 @@ static int sca3000_hw_ring_postdisable(struct iio=
_dev
> *indio_dev)
> =C2=A0	/* Disable the 50% full interrupt */
> =C2=A0	mutex_lock(&st->lock);
> =C2=A0
> -	ret =3D sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
> +	ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_ADDR));
> =C2=A0	if (ret)
> =C2=A0		goto unlock;
> =C2=A0	ret =3D sca3000_write_reg(st,
> =C2=A0				SCA3000_REG_INT_MASK_ADDR,
> -				st->rx[0] & ~SCA3000_REG_INT_MASK_RING_HALF);
> +				ret & ~SCA3000_REG_INT_MASK_RING_HALF);
> =C2=A0unlock:
> =C2=A0	mutex_unlock(&st->lock);
> =C2=A0	return ret;
> @@ -1376,7 +1345,7 @@ static int sca3000_clean_setup(struct sca3000_state=
 *st)
> =C2=A0
> =C2=A0	mutex_lock(&st->lock);
> =C2=A0	/* Ensure all interrupts have been acknowledged */
> -	ret =3D sca3000_read_data_short(st, SCA3000_REG_INT_STATUS_ADDR, 1);
> +	ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_ADDR));
> =C2=A0	if (ret)
> =C2=A0		goto error_ret;
> =C2=A0
> @@ -1402,7 +1371,7 @@ static int sca3000_clean_setup(struct sca3000_state=
 *st)
> =C2=A0	if (ret)
> =C2=A0		goto error_ret;
> =C2=A0	/* Enable interrupts, relevant to mode and set up as active low */
> -	ret =3D sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
> +	ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_ADDR));
> =C2=A0	if (ret)
> =C2=A0		goto error_ret;
> =C2=A0	ret =3D sca3000_write_reg(st,
> @@ -1416,11 +1385,11 @@ static int sca3000_clean_setup(struct sca3000_sta=
te *st)
> =C2=A0	 * Ring in 12 bit mode - it is fine to overwrite reserved bits 3,5
> =C2=A0	 * as that occurs in one of the example on the datasheet
> =C2=A0	 */
> -	ret =3D sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
> +	ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
> =C2=A0	if (ret)
> =C2=A0		goto error_ret;
> =C2=A0	ret =3D sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
> -				(st->rx[0] & SCA3000_MODE_PROT_MASK));
> +				ret & SCA3000_MODE_PROT_MASK);
> =C2=A0
> =C2=A0error_ret:
> =C2=A0	mutex_unlock(&st->lock);
> @@ -1503,14 +1472,15 @@ static int sca3000_stop_all_interrupts(struct sca=
3000_state
> *st)
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	mutex_lock(&st->lock);
> -	ret =3D sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
> +	ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_ADDR));
> =C2=A0	if (ret)
> =C2=A0		goto error_ret;
> +
> =C2=A0	ret =3D sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
> -				(st->rx[0] &
> -				 ~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
> -				=C2=A0=C2=A0 SCA3000_REG_INT_MASK_RING_HALF |
> -				=C2=A0=C2=A0 SCA3000_REG_INT_MASK_ALL_INTS)));
> +				ret &
> +				~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
> +				=C2=A0 SCA3000_REG_INT_MASK_RING_HALF |
> +				=C2=A0 SCA3000_REG_INT_MASK_ALL_INTS));
> =C2=A0error_ret:
> =C2=A0	mutex_unlock(&st->lock);
> =C2=A0	return ret;


