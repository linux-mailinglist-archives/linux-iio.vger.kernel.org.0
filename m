Return-Path: <linux-iio+bounces-16729-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CEDA5BC46
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 10:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13CE51636B7
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 09:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111EE2236E9;
	Tue, 11 Mar 2025 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApVTdjAj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2721F22576C;
	Tue, 11 Mar 2025 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741685367; cv=none; b=ADBSRJ9Cwx9pHvJPda3DnFfeAXEADhg/btENR41xn7B3DKLpXHdDXeH4txs7Bsl6QEBFcTr6EY6f/laU9L7+CiUbIRtBwf/t8zmJ4TGXmpNvrLnUD3HFBvwmoePjWYEP2leuiGd5KMY2nm/JKTKVKEEoVnfngcaXVgL8kmDldLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741685367; c=relaxed/simple;
	bh=0vnGQoA0W5dpocZ5fbQvZBJu7I//R06QOGpv6v0Jpc0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZMIBS4QNeVEnlXj1NrxC7N/tvil1Tp4S+lm5ArhbgZ1C8vf91sbSVeCbMwg1lyHVSxgxnjp64I4oafy4NsQMVFtG3wiOOOUieC31C76of3ef79VpOp5KoPtFsqMcyXsKkoYhMHv3+Yt7hnMid084dEU7TbXEAlYUvQ/Ncr/Akj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApVTdjAj; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4394a823036so44176385e9.0;
        Tue, 11 Mar 2025 02:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741685364; x=1742290164; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uB7rjc8kr3dVtcK1m1BTEiCqLunEyyqIIweBswB2gdI=;
        b=ApVTdjAjPn/U0aN7NTGYRANBe/nM2fvtdFLnvcr7NbTiphFrS49EAiEm1BAtSSH8NU
         lEFpP1GwTrwVgBbFfXIfS9HIOix36hhAJ6m1cjfvbr/sDVU450FQDKvoAYKXif1EA3Tk
         1fma2cwUECKkZWCZz4OXQaCYVnw8mRR8px70uHWIWWMiRus7dCAMFJJWOKm1BTUC8etQ
         xEFaroQ24fD29Ikgcm1HHL78aNUVzSCf/bjZoD/rxwKIl7VP570RnV+tsyj8AXiZKN/c
         K07/68hNV2ddP3ifsvPrJyH6+gChjc1idH+dh+ptczSKmL1Ho6vUTwasK56lzZldbBHo
         9L6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741685364; x=1742290164;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uB7rjc8kr3dVtcK1m1BTEiCqLunEyyqIIweBswB2gdI=;
        b=fuGVYUAGaZB+ZtcmJNZh/VrT5S2IYlRaKc1EAkqhuluTuwqPRFwdcmbXq9nBPZ7JnP
         Qu5ia4XDqW8giEsKUGWKkagctjPEp96DZG5SRVw1c8PNV26gSMeOxswTbmU1O5QEHd9s
         3rNNaZRBtqdyAkmT+8pTJagBzd3IR+XoiULUtDaAfdtnSDZqXr2NpdXXIwiLvToyTU0d
         P918JOcZPJVIQZMCc2QgONfen3MNXBUhgZbHEtNvou5eRyzdov0ybN5Un6N7dT0YnRUE
         X7YsSRCU5rBrO/+40KWx/65dfo6qNchIKBPsIt9nIU983O2mM6yhHaz3boYsJAMuMeVH
         OclA==
X-Forwarded-Encrypted: i=1; AJvYcCXXt0hJJeTW3GQBUcaL/0HrJHBIrEUsVRGV51YC+KXn9WEF6DNwQxbm0DDuUavcuto0M+tChuDp+SLh2tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya3QUl01hYPU6xqwqOzWtgDC84nXCFx7/AXRZ1Io/+SMSW9j63
	3uW5arNC16TUf6ZUsKl4M4MDiP/+9XYXa6hgAwBwbWcEM5MYDdt2
X-Gm-Gg: ASbGncu8pu0xqVU96y/qmfgoV2M825nvae5edDtZtVPU6cEsU2O04nQZMw5As4WIDMZ
	kSSF/O9vwTrrCkGSNHPvWhNLADfkVlH49mODCrWUpyTKuwDjVdF5ftluvkY2jStMU1KDRspDapk
	tMDPD8ZMKyKZeNRwt+lwpmvaRlkNCkZqHPgefPRo5xVhlI3T0y9jyBtU+b/lT1umxH8OZHPtkSL
	gCdqT5Zmm1uLHBcO3ZTlFcA5dzutfFuIBP6MKi3BmuFgzSwGbgLOvw5jUjycGcVyMp2fm4of/Yr
	ZD6fcldXV320pZTHAJPsnkrb+AOI5AOOM8iwpcRtAoh+ROro7uxmQv1pFl7rM5vOJNycKf5V4+S
	uaHVYUTvuSWFADwYB
X-Google-Smtp-Source: AGHT+IE9Z6uGhjR2urOAWdPdVPaYy81S4mFCEWaNq1PZu/wfXCxtgJgOyvrt57ik5Yhz0AIOjxZ3EA==
X-Received: by 2002:a05:6000:2703:b0:390:f9d0:5df with SMTP id ffacd0b85a97d-3926c5a5670mr2158802f8f.52.1741685364232;
        Tue, 11 Mar 2025 02:29:24 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba8b6sm17838985f8f.11.2025.03.11.02.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 02:29:23 -0700 (PDT)
Message-ID: <187e480d5732818bfd97c54820b0ae0aa2d53b1d.camel@gmail.com>
Subject: Re: [PATCH 4/5] iio: adc: ad4030: don't store scan_type in state
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Esteban Blanc	
 <eblanc@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 11 Mar 2025 09:29:30 +0000
In-Reply-To: <20250310-iio-adc-ad4030-check-scan-type-err-v1-4-589e4ebd9711@baylibre.com>
References: 
	<20250310-iio-adc-ad4030-check-scan-type-err-v1-0-589e4ebd9711@baylibre.com>
	 <20250310-iio-adc-ad4030-check-scan-type-err-v1-4-589e4ebd9711@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-03-10 at 15:43 -0500, David Lechner wrote:
> Move getting the scan_type to ad4030_conversion(). Previously, we were
> getting the scan_type in two other places, then storing it in the
> state struct before using it in ad4030_conversion(). This was a bit
> fragile against potential future changes since it isn't obvious that
> anything that could potentially change the scan_type would need to
> also update the state struct. Also, the non-obviousness of this led to
> a redundant call to iio_get_current_scan_type() in
> ad4030_single_conversion() since it also calls ad4030_set_mode() which
> in turn calls ad4030_conversion().
>=20
> To simplify things, just call iio_get_current_scan_type() in
> ad4030_conversion() where the returned struct is actually used and
> don't bother storing it in the state struct.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad4030.c | 24 +++++++++---------------
> =C2=A01 file changed, 9 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> index
> c2117c7a296f22aeeec6911c8a8c74ed576296a0..54ad74b96c9f256a67848330f875379=
edc82
> 8b0b 100644
> --- a/drivers/iio/adc/ad4030.c
> +++ b/drivers/iio/adc/ad4030.c
> @@ -147,7 +147,6 @@ struct ad4030_state {
> =C2=A0	struct spi_device *spi;
> =C2=A0	struct regmap *regmap;
> =C2=A0	const struct ad4030_chip_info *chip;
> -	const struct iio_scan_type *current_scan_type;
> =C2=A0	struct gpio_desc *cnv_gpio;
> =C2=A0	int vref_uv;
> =C2=A0	int vio_uv;
> @@ -562,11 +561,6 @@ static int ad4030_set_mode(struct iio_dev *indio_dev=
,
> unsigned long mask)
> =C2=A0		st->mode =3D AD4030_OUT_DATA_MD_DIFF;
> =C2=A0	}
> =C2=A0
> -	st->current_scan_type =3D iio_get_current_scan_type(indio_dev,
> -							=C2=A0 st->chip-
> >channels);
> -	if (IS_ERR(st->current_scan_type))
> -		return PTR_ERR(st->current_scan_type);
> -
> =C2=A0	return regmap_update_bits(st->regmap, AD4030_REG_MODES,
> =C2=A0				=C2=A0 AD4030_REG_MODES_MASK_OUT_DATA_MODE,
> =C2=A0				=C2=A0 st->mode);
> @@ -614,15 +608,20 @@ static void ad4030_extract_interleaved(u8 *src, u32
> *ch0, u32 *ch1)
> =C2=A0static int ad4030_conversion(struct iio_dev *indio_dev)
> =C2=A0{
> =C2=A0	struct ad4030_state *st =3D iio_priv(indio_dev);
> -	unsigned char diff_realbytes =3D
> -		BITS_TO_BYTES(st->current_scan_type->realbits);
> -	unsigned char diff_storagebytes =3D
> -		BITS_TO_BYTES(st->current_scan_type->storagebits);
> +	const struct iio_scan_type *scan_type;
> +	unsigned char diff_realbytes, diff_storagebytes;
> =C2=A0	unsigned int bytes_to_read;
> =C2=A0	unsigned long cnv_nb =3D BIT(st->avg_log2);
> =C2=A0	unsigned int i;
> =C2=A0	int ret;
> =C2=A0
> +	scan_type =3D iio_get_current_scan_type(indio_dev, st->chip->channels);
> +	if (IS_ERR(scan_type))
> +		return PTR_ERR(scan_type);
> +
> +	diff_realbytes =3D BITS_TO_BYTES(scan_type->realbits);
> +	diff_storagebytes =3D BITS_TO_BYTES(scan_type->storagebits);
> +
> =C2=A0	/* Number of bytes for one differential channel */
> =C2=A0	bytes_to_read =3D diff_realbytes;
> =C2=A0	/* Add one byte if we are using a differential + common byte mode =
*/
> @@ -673,11 +672,6 @@ static int ad4030_single_conversion(struct iio_dev
> *indio_dev,
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	st->current_scan_type =3D iio_get_current_scan_type(indio_dev,
> -							=C2=A0 st->chip-
> >channels);
> -	if (IS_ERR(st->current_scan_type))
> -		return PTR_ERR(st->current_scan_type);
> -
> =C2=A0	ret =3D ad4030_conversion(indio_dev);
> =C2=A0	if (ret)
> =C2=A0		return ret;
>=20


