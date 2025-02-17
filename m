Return-Path: <linux-iio+bounces-15628-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EC5A380B1
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 11:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B9C3A9B02
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 10:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877681DE3B6;
	Mon, 17 Feb 2025 10:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msXiKIei"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9F515C0
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789411; cv=none; b=KfqK4od1zaX2RRt/0fa2ntmS6vn0CD9wBq3blUVGtaadnDdgcnDWSgWSdunTg0dmo8sJ5AkJjuMOY6vNvdV9SSZp1ATkDKqeNpYxZxA7EHwLWt7peygRjBtmeLRgoMOHFrLt5AZSTOWLytPI2C1yRskyDetRuVG9H/40qc47JQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789411; c=relaxed/simple;
	bh=wOx9JGRqm+LOaLmNHM+whYR3RHYkMaojKjJ01mQbaGU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cQnvQsmavAEwkTrwCx0UlF1Q9Nhlyx1AtnGBCIwmVgxxuq7GkdKLRLsEqq+ANZGrxnT4zqc2OHytYSGLcawPWFAqcf6uO62NW/MOi0HvL1SpT0IGsuEq/c/4lSXkbN+J74R5OSw+7c6j/EgsXxwa79CCwy6VWfjfZSP6iwrHLjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msXiKIei; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4395dddb07dso43833235e9.2
        for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 02:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739789408; x=1740394208; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QAJHF4xeS9SIyGdd3KTIo400gFLBRiJ4i9J1vfN+iL4=;
        b=msXiKIeiXZvEsyjjPkq8TPNaLeajJ0JW0hmhiEC5fgCmHN2OSyrEcDzgAyfW4hOX+x
         0zbQ36K4qCbPWIniAsp9502xhMeQkIvZ9+VBQZRPAUtnLzUgjOdatBCpjmU9h3lHl0LP
         9aPJ8jyLTHFl0Me+RfUEOOcuzE/J+BCHTmNfmNw+ZzPY7YVUSCFka2wQkJjc0uWA99qU
         Wx29KrLqzHhXbbmEbUN+viCK8q8J/O9ZPZ0548RbhvOoeEdKFRS0OuuH01MenIhoUMuF
         eYDC9Xo5SLByIu44c2BEGR2WFpizbfW0vsq9s2AA+B/y8q2qcD4VDutKB5rhYcIacw6Q
         2lIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739789408; x=1740394208;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QAJHF4xeS9SIyGdd3KTIo400gFLBRiJ4i9J1vfN+iL4=;
        b=I73GS+RJHhr66vwK0Rml6LmkQG9GwgP/YySfFvygoek3ZDwBH3cu7S7prbRFTWMisG
         Zj4i+mUgIyYjQ2oS2RrkqiQkUTx/jjinnlTvCYmXT7kPmUHtDscKoYlsYqTB5/IbPzWA
         YNY1XgLmkNZ57pzR8LKDV+zYrgkruE3zIrjYha5X7faLFNcXepaat4AwLCA+4M9BFls0
         3YoXn02F8tPwmtDv5q0WQKakoBRAaCiPiXsk+cYucocb8vvYqnd/HqKDrXDwIPfcMoJO
         gYnQk4U7wSvzjhgW+ya1R5VyNV/sh245T/MTXgGgLe6ttx2J+3Vv9x0C5vPuD2EKMF2U
         19kA==
X-Forwarded-Encrypted: i=1; AJvYcCXjYgYxTHTZ6LEIJGvrOOBI9rH7y39vhuUYBO8jfRX/sVgZoweKK/dEP4fYaFfd3T2epeLMkant2ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YztTMb79blQyOcmK2xMf77yeDQTHu95ypi09MSVdl1LrWAcunES
	aFrNL8gE5/QOIR7HLyNCBeMfjHDFefyik8W5aONEH+6uyuol2VRG
X-Gm-Gg: ASbGnctyyZmra4laYtHDt21tKepkGQUoQ/T2GplxEvVD80VWh8sHHOhWnziaFcAulwU
	3gWfpeMKIFAi6e/bvefwUWD9SdvI4fJyNnRKU25Cnlbobptbo1jwLOqRifv+pvVQ4akse7LnqdX
	uci09kNJ+FcxKB9RvKNEuqhivWjGJzqJEeIDS+2fQlh3r+6Hp4ngYYHadsHh9htb+pz1+Hefdax
	jgXI4qqXaG/GhWOY7WBJO8P4f+rzu5cMezw/WbGIRtI2DrHZWPEt3oWFJpLfrXQwnc34VddxhjX
	obRdYBrW2aor8Aj8vF2k5l+6KKySe6bgJ1MQ+PxCgxzxSc3HhqE2YmYlXvtH5dk=
X-Google-Smtp-Source: AGHT+IH15vD3j9nEbA1hBSbcjDH0gSVSvnq5+0Q1RzWvFcZgbleYdRRf0yEZ2/A9fpGoNzsfiNzcBw==
X-Received: by 2002:a05:600c:3b8c:b0:439:3e46:4b1c with SMTP id 5b1f17b1804b1-4396e6d7c2amr68944815e9.2.1739789407533;
        Mon, 17 Feb 2025 02:50:07 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43986320899sm20322695e9.38.2025.02.17.02.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:50:07 -0800 (PST)
Message-ID: <621f7ab9033e537f9ab48fac8e9847c8b256bdf1.camel@gmail.com>
Subject: Re: [PATCH v2 14/27] iio: adc: ad7779: Stop using
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
Date: Mon, 17 Feb 2025 10:50:10 +0000
In-Reply-To: <20250209180624.701140-15-jic23@kernel.org>
References: <20250209180624.701140-1-jic23@kernel.org>
	 <20250209180624.701140-15-jic23@kernel.org>
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
> to check for unbalanced context.
>=20
> Cc: Ramona Alexandra Nechita <ramona.nechita@analog.com>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7779.c | 101 ++++++++++++++++++++++++------------=
---
> =C2=A01 file changed, 62 insertions(+), 39 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
> index 2537dab69a35..a5d87faa5e12 100644
> --- a/drivers/iio/adc/ad7779.c
> +++ b/drivers/iio/adc/ad7779.c
> @@ -467,59 +467,82 @@ static int ad7779_set_calibbias(struct ad7779_state=
 *st,
> int channel, int val)
> =C2=A0				calibbias[2]);
> =C2=A0}
> =C2=A0
> +static int __ad7779_read_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan, int *val,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 int *val2, long mask)
> +{
> +	struct ad7779_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		ret =3D ad7779_get_calibscale(st, chan->channel);
> +		if (ret < 0)
> +			return ret;
> +		*val =3D ret;
> +		*val2 =3D GAIN_REL;
> +		return IIO_VAL_FRACTIONAL;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		ret =3D ad7779_get_calibbias(st, chan->channel);
> +		if (ret < 0)
> +			return ret;
> +		*val =3D ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val =3D st->sampling_freq;
> +		if (*val < 0)
> +			return -EINVAL;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> =C2=A0static int ad7779_read_raw(struct iio_dev *indio_dev,
> =C2=A0			=C2=A0=C2=A0 struct iio_chan_spec const *chan, int *val,
> =C2=A0			=C2=A0=C2=A0 int *val2, long mask)
> =C2=A0{
> -	struct ad7779_state *st =3D iio_priv(indio_dev);
> =C2=A0	int ret;
> =C2=A0
> -	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> -		switch (mask) {
> -		case IIO_CHAN_INFO_CALIBSCALE:
> -			ret =3D ad7779_get_calibscale(st, chan->channel);
> -			if (ret < 0)
> -				return ret;
> -			*val =3D ret;
> -			*val2 =3D GAIN_REL;
> -			return IIO_VAL_FRACTIONAL;
> -		case IIO_CHAN_INFO_CALIBBIAS:
> -			ret =3D ad7779_get_calibbias(st, chan->channel);
> -			if (ret < 0)
> -				return ret;
> -			*val =3D ret;
> -			return IIO_VAL_INT;
> -		case IIO_CHAN_INFO_SAMP_FREQ:
> -			*val =3D st->sampling_freq;
> -			if (*val < 0)
> -				return -EINVAL;
> -			return IIO_VAL_INT;
> -		default:
> -			return -EINVAL;
> -		}
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +
> +	ret =3D __ad7779_read_raw(indio_dev, chan, val, val2, mask);
> +	iio_device_release_direct(indio_dev);
> +	return ret;
> +}
> +
> +static int __ad7779_write_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int val, int val2,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 long mask)
> +{
> +	struct ad7779_state *st =3D iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		return ad7779_set_calibscale(st, chan->channel, val2);
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		return ad7779_set_calibbias(st, chan->channel, val);
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return ad7779_set_sampling_frequency(st, val);
> +	default:
> +		return -EINVAL;
> =C2=A0	}
> -	unreachable();
> =C2=A0}
> =C2=A0
> =C2=A0static int ad7779_write_raw(struct iio_dev *indio_dev,
> =C2=A0			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan, int val, in=
t
> val2,
> =C2=A0			=C2=A0=C2=A0=C2=A0 long mask)
> =C2=A0{
> -	struct ad7779_state *st =3D iio_priv(indio_dev);
> +	int ret;
> =C2=A0
> -	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> -		switch (mask) {
> -		case IIO_CHAN_INFO_CALIBSCALE:
> -			return ad7779_set_calibscale(st, chan->channel,
> val2);
> -		case IIO_CHAN_INFO_CALIBBIAS:
> -			return ad7779_set_calibbias(st, chan->channel, val);
> -		case IIO_CHAN_INFO_SAMP_FREQ:
> -			return ad7779_set_sampling_frequency(st, val);
> -		default:
> -			return -EINVAL;
> -		}
> -	}
> -	unreachable();
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +
> +	ret =3D __ad7779_write_raw(indio_dev, chan, val, val2, mask);
> +	iio_device_release_direct(indio_dev);
> +	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0static int ad7779_buffer_preenable(struct iio_dev *indio_dev)


