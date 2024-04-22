Return-Path: <linux-iio+bounces-4438-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1138AD126
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 17:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C56281BFB
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 15:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A47E153514;
	Mon, 22 Apr 2024 15:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+ipiaTV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3121534F1;
	Mon, 22 Apr 2024 15:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713800766; cv=none; b=GkLhnmhVznMAnge1LayWvexkRq31xJ6VR/jWYwPYzwlnLW7n9a+yUVrFCMwIz65yztog61JUyiQN3M/fgnLoib3WP6AKNCWFi4wWtI9g9cxtsDPFwiCfWZ4tEA+wb7pBRrZe3heLiJgrCt08tON7FYBIv9259I9cbJGcQwxZBQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713800766; c=relaxed/simple;
	bh=Yd+sKUoe/VBq+F1xL0KTN9Kwwi2P9W1Sqc1cjYgaA5s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O3S2SAhoQaAZI8LHjWHvwlY6pUkRU0jkCaOsl2jyBU1jEc45RUFkD8/MZw7tvZIjndnlfifswMagC/3S1okAQdQLcge83mjUfqJckpbTBM0nWqtb3IIPFYsI/C6l0lF8BSHWepnCQRLSTEgQts80WPLPvBaeCDCYRz1QnQGZkyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+ipiaTV; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a51addddbd4so450260566b.0;
        Mon, 22 Apr 2024 08:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713800764; x=1714405564; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GOjfFx22HpKnDqQf8onlhVi0bz7IC6k9X1OqPubXYbQ=;
        b=I+ipiaTVIwTPW2HWm2w6K4lK2tpFPtbawJYHtaYYmxpVRsj9h7l96Zbn/m1DoxtCdG
         MTteAAjL+BxIogLUbLg7Jx57aeULk2mMbnd9HIixSyWx2q16qrpWDRFMjdWkZD2aKYlP
         I0/9qA4r8/LO1PNjTZ43gTgGY+8oTSmjrf4YT7v6KscZhLoQZ4HgQjOjQNPNo8jy87pP
         +Intpx31cyuAQNFk2B9twAEwcfnYzjA7FYzjd27QUj+Bd/lkSoy9v2xROxi2pesasStj
         uzw7sN4dwRH6MXWrPMdjpWroeZsm19D6gwC9lAudOMaFkWsAWK3UYveSbpghQ6aLrUdP
         sAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713800764; x=1714405564;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GOjfFx22HpKnDqQf8onlhVi0bz7IC6k9X1OqPubXYbQ=;
        b=V62arLTWMF4SFsmchwc1cpG1HzuZAKzDurREkIyYUi3Z9VAofGVRv6DC/75AjXEkWr
         6O5tIEP+uSfDzppiwXe2rlzMpnomt1tYb4cB7aJgdBb8jgLnoNldfRGoS9rvSl0xl4gl
         EpGwLlRU0G1AUne14alrQ5F7p7c8ANMQIPe9dM5HJneH0DDJFiMqHU5lOYd79EkCLjo2
         0sVge8RRTeRVpw2JMRGJ5z6DAaxgPgpTjvFVBnNXVWng8YSNzeTpm8VCXWu+QPxdeBBJ
         mRWbg4cCd2NuaX5sEfS2Ydk2AEXoDZUhW/+VJMqy4LG8Vllzz0bifrMliaY/NT+vm55m
         x3yA==
X-Forwarded-Encrypted: i=1; AJvYcCVb41luPuD9/3h+rvPHlj/93Z5Lo2exMqu+Cuf0bUyg6dKhyqo6Lbx+dPnRVg6n4Ua5ySwzSHpQTBrnbywgZe5hWncfKCaU+6cuyIGu5o+9O9sg0+oE3+tEG3cqjtGfFuD5FhjBAw==
X-Gm-Message-State: AOJu0YxvRmNNYAzBVAvXkYH+ZhiI+qeNE8QHznmgXOZ6XdTskBAvs7Xf
	ehf14DejxRq3XZmD9qQCuhR26YlRcLwls0N4Fi/fV0LZ6gTCt66i
X-Google-Smtp-Source: AGHT+IF8Rhw9snRvO9uPSEP4cXrZ+890aRkomrwgK1yD9RF9RJiz9m0C35p3tUMIsxImHEngOrAneA==
X-Received: by 2002:a17:907:94c5:b0:a55:9e3d:5606 with SMTP id dn5-20020a17090794c500b00a559e3d5606mr4935581ejc.12.1713800763399;
        Mon, 22 Apr 2024 08:46:03 -0700 (PDT)
Received: from ?IPv6:2001:a61:3481:2201:6106:96db:d27b:d2c2? ([2001:a61:3481:2201:6106:96db:d27b:d2c2])
        by smtp.gmail.com with ESMTPSA id jg36-20020a170907972400b00a526aa9e75asm5936896ejc.77.2024.04.22.08.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 08:46:03 -0700 (PDT)
Message-ID: <824d8db92adcd1effd9020e4add873b108f087b4.camel@gmail.com>
Subject: Re: [PATCH 7/8] iio: adc: ad9467: cache the sample rate
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa via B4 Relay
	 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Alexandru Ardelean
 <alexandru.ardelean@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
  Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Date: Mon, 22 Apr 2024 17:46:02 +0200
In-Reply-To: <20240420161941.212e92c5@jic23-huawei>
References: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
	 <20240419-ad9467-new-features-v1-7-3e7628ff6d5e@analog.com>
	 <20240420161941.212e92c5@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-04-20 at 16:19 +0100, Jonathan Cameron wrote:
> On Fri, 19 Apr 2024 17:36:50 +0200
> Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > Since we allow to change the sampling frequency and do it with
> > clk_round_rate(), we can cache it and use on the read_raw() interface.
> > This will also be useful in a following patch supporting interface
> > calibration.
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
>=20
> The clk subsystem caches the clock rate in most cases anyway, so
> I'm not sure why we need this.=C2=A0 Or it the point that you are going
> to temporarily change it in the next patch?
>=20

The idea is that in the next patch I want to bail out early if we're not ch=
anging the
rate (after clk_round_rate()) because I also don't want to re-run tuning in=
 that
case. Since the rate is not guaranteed to be cached (even though I think mo=
st clock
providers don't set the NO_CACHE flag), I went this way. Anyways, this is m=
inor so I
can stick to clk_get_rate() if you prefer.

> Patch looks fine, but I think a clearer requirements statement is
> needed.
>=20
> Jonathan
>=20
>=20
> > ---
> > =C2=A0drivers/iio/adc/ad9467.c | 13 +++++++++++--
> > =C2=A01 file changed, 11 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> > index 7475ec2a56c72..7db87ccc1ea4b 100644
> > --- a/drivers/iio/adc/ad9467.c
> > +++ b/drivers/iio/adc/ad9467.c
> > @@ -117,6 +117,7 @@ struct ad9467_state {
> > =C2=A0	struct iio_backend		*back;
> > =C2=A0	struct spi_device		*spi;
> > =C2=A0	struct clk			*clk;
> > +	unsigned long			sample_rate;
> > =C2=A0	unsigned int			output_mode;
> > =C2=A0	unsigned int=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (*scales)[2=
];
> > =C2=A0
> > @@ -331,7 +332,7 @@ static int ad9467_read_raw(struct iio_dev *indio_de=
v,
> > =C2=A0	case IIO_CHAN_INFO_SCALE:
> > =C2=A0		return ad9467_get_scale(st, val, val2);
> > =C2=A0	case IIO_CHAN_INFO_SAMP_FREQ:
> > -		*val =3D clk_get_rate(st->clk);
> > +		*val =3D st->sample_rate;
> > =C2=A0
> > =C2=A0		return IIO_VAL_INT;
> > =C2=A0	default:
> > @@ -346,6 +347,7 @@ static int ad9467_write_raw(struct iio_dev *indio_d=
ev,
> > =C2=A0	struct ad9467_state *st =3D iio_priv(indio_dev);
> > =C2=A0	const struct ad9467_chip_info *info =3D st->info;
> > =C2=A0	long r_clk;
> > +	int ret;
> > =C2=A0
> > =C2=A0	switch (mask) {
> > =C2=A0	case IIO_CHAN_INFO_SCALE:
> > @@ -358,7 +360,12 @@ static int ad9467_write_raw(struct iio_dev *indio_=
dev,
> > =C2=A0			return -EINVAL;
> > =C2=A0		}
> > =C2=A0
> > -		return clk_set_rate(st->clk, r_clk);
> > +		ret =3D clk_set_rate(st->clk, r_clk);
> > +		if (ret)
> > +			return ret;
> > +
> > +		st->sample_rate =3D r_clk;
> > +		return 0;
> > =C2=A0	default:
> > =C2=A0		return -EINVAL;
> > =C2=A0	}
> > @@ -543,6 +550,8 @@ static int ad9467_probe(struct spi_device *spi)
> > =C2=A0	if (IS_ERR(st->clk))
> > =C2=A0		return PTR_ERR(st->clk);
> > =C2=A0
> > +	st->sample_rate =3D clk_get_rate(st->clk);
> > +
> > =C2=A0	st->pwrdown_gpio =3D devm_gpiod_get_optional(&spi->dev, "powerdo=
wn",
> > =C2=A0						=C2=A0=C2=A0 GPIOD_OUT_LOW);
> > =C2=A0	if (IS_ERR(st->pwrdown_gpio))
> >=20
>=20


