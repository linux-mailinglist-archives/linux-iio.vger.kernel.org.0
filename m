Return-Path: <linux-iio+bounces-14409-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE367A14CAA
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2025 10:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1771883D01
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2025 09:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A8B1FBEB9;
	Fri, 17 Jan 2025 09:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="M9pvO2T0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADA91FBCBC
	for <linux-iio@vger.kernel.org>; Fri, 17 Jan 2025 09:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737107950; cv=none; b=I6nZWytwuUm1noIHXQkx1UtQ2pq4HgoIWP4M/1bwwwgza5hiaZ2Vt4WY7TAbn8mnO6wOD3fFGUDv3OdZE237Oyfg/rSA8ePrVG4HMBoy7xgSZ8RzV5zDP82hEzQdve0iKQ/XoaXfm2vRBI+WRAvGMVivbVXY4bX7uACxj9nqdz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737107950; c=relaxed/simple;
	bh=ndF2H4ww8cd7NpbZXbox544Y/CoXx8ZUTUoQ2asQg80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZ12VxyySckcHXTzJFwvlTYNsS2dc9u7hiFTqRFSPNLTD2kKfVoPen5KoPkXjVv/XHYLZNC8uqWTqxXJp0TVZjLg2jTfJr+acswWb5+fbxf0Uv8a0wsW5WR3QEbLyxtKAeckS4zUyBC6jc6ydupbMdKYIY7zH40sckt4GTDFZNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=M9pvO2T0; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38a8b35e168so1280129f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 17 Jan 2025 01:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737107946; x=1737712746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cH3UIuN+JljFJZ5b+G4kQN8IQuOY1u/LydwoVXBQ10U=;
        b=M9pvO2T0WcI0EuWyOF1EGDUeq51OrmYiy6epfYp6p1Xx3r1lOqIMcpAAHivdvRfxXo
         mqiMxUDkSyzhr1cCC6uC6cCodkXAXwiHoWCyvUkZSI5qP6XdVoT95kV81rMSOeD4SzBa
         IF2aFAEZpZPdf0REByFS6E+BjYhou5msLWfFVhDv4hVwd6Ubhg1xTAev309S/eZNQcIv
         3Gm70B3SmzxcLdvwqbQt6y9jje1RXxO+hozNL1vKKgFl0/7gYZgyvOZZxADjqFJO7fNm
         GiqlDKu9K2CG7Tcsydwf48UrqXQmPGqc3XCwHsdpR3eiDaSbVtAc+Kp6z3LALK94zJ/W
         6JXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737107946; x=1737712746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cH3UIuN+JljFJZ5b+G4kQN8IQuOY1u/LydwoVXBQ10U=;
        b=ryrK3tl0d9c4Ty0S41snGmrwRtZfyiHKaOyk/6ZKq11NMm6D4F/4P9cOdu9KUwWadt
         uKqlXVUvOFJTH9GBSBM2uJ/e3d91XirryqRpTqkqNmlKUnGZNSEMtm0i4mX/frcd4T4H
         Csr9zL05sK6T2PwrreRS84F52795uMzlKG1KUUmYw7bfHItXpGCmKA/vEYrkH/0+k1Cr
         EcrxW7MkQCg4KvVYO6xUXtxxUf0MVVpMwCbAHy0njNfFlfOHzcjonCnzvKQ/LNFAl/Wp
         n2jjkXj7pOnk4A+Iti8Mxrrgs89QNvLLnSkq//xGOmghxRtndR8TU135Ra9Ys71hSkUx
         yVoA==
X-Forwarded-Encrypted: i=1; AJvYcCV/71kEc1MoCppPoUvnG/rPxDmQW30Pj7kuL9Jfa+DBuyTTSXkMapDwXbqs5ZNB0Ldy9koBu+6s3/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywht+12mn1VU6vCbXBI+QSFDtbnoNDldfyCyj9Q6VQVdHdMVDXs
	jqbnYp7hamjmnaPqmjpVYG6tt5FX9J+NEBoWF2D9/GgZ8BcoBPINpzaYlbPZZ1E=
X-Gm-Gg: ASbGncu7y4QkcvgmuozmAoWU7KtW8cO9YHuQi3MgBFJrb4yjLxFMTnQPuBrfQbBW98Z
	Ci5aXJ4ZhaKUr0eOnvR6MARyb1S+qHJYf2Qj6zfufvwkR4A9mrtT+YuJYBdvmWi3pc30C6TzTTX
	S2/iuSROpwMs5NDgX8S5suS/gGD0sf1gFMuW4JE0mHWdPRDH/Vd9HGPtLSkXJGZw4VyNpxOYP9l
	E9ckePjB+w9nzj2lI6Vd+pH9YNmzM2AgWTv6mU5e4SnEYY19PP96glW2SOMsY9d5LlnJjnVRMGV
	UAuQT0bWLfZLV1KbzaOnVg0=
X-Google-Smtp-Source: AGHT+IGSbILvBO7ITTfo7167M1IyTZHJ9g9nnuyhfkGbV3jB+Wi4ZH+q1bt537O93Kd9bGzuPJ1kXw==
X-Received: by 2002:a5d:64ad:0:b0:38a:5dc4:6dcd with SMTP id ffacd0b85a97d-38bf5b02b35mr1806688f8f.22.1737107946515;
        Fri, 17 Jan 2025 01:59:06 -0800 (PST)
Received: from localhost (p200300f65f0afb0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f0a:fb04::1b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3275622sm2100877f8f.69.2025.01.17.01.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 01:59:06 -0800 (PST)
Date: Fri, 17 Jan 2025 10:59:04 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: jic23@kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v9 8/8] iio: adc: ad4851: add ad485x driver
Message-ID: <d4ur7trhknm7jtjvsyms4aewypl75uuvgtccgwc7dfycheh4qo@jqmpv5t3lip6>
References: <20241220120134.42760-1-antoniu.miclaus@analog.com>
 <20241220120134.42760-8-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k325ldattcvx2xxc"
Content-Disposition: inline
In-Reply-To: <20241220120134.42760-8-antoniu.miclaus@analog.com>


--k325ldattcvx2xxc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 8/8] iio: adc: ad4851: add ad485x driver
MIME-Version: 1.0

Hello,

On Fri, Dec 20, 2024 at 02:01:34PM +0200, Antoniu Miclaus wrote:
> +static const int ad4851_oversampling_ratios[] =3D {
> +	1, 2, 4, 8, 16,	32, 64, 128,
> +	256, 512, 1024, 2048, 4096, 8192, 16384, 32768,
> +	65536,
> +};
> +
> +static int ad4851_osr_to_regval(unsigned int ratio)
> +{
> +	int i;
> +
> +	for (i =3D 1; i < ARRAY_SIZE(ad4851_oversampling_ratios); i++)
> +		if (ratio =3D=3D ad4851_oversampling_ratios[i])
> +			return i - 1;
> +
> +	return -EINVAL;
> +}

This can be simplified (I guess) using something like:

	if (ratio >=3D 2 && ratio <=3D 65536 && is_power_of_2(ratio))
		return ilog2(ratio) - 1;

	return -EINVAL;

> +static void __ad4851_get_scale(struct iio_dev *indio_dev, int scale_tbl,
> +			       unsigned int *val, unsigned int *val2)
> +{
> [...]
> +}
> +
> +static int ad4851_scale_fill(struct iio_dev *indio_dev)
> +{
> [...]
> +}
> +
> +static int ad4851_set_oversampling_ratio(struct iio_dev *indio_dev,
> +					 const struct iio_chan_spec *chan,
> +					 unsigned int osr)
> +{
> [...]
> +}
> +
> +static int ad4851_get_oversampling_ratio(struct ad4851_state *st, unsign=
ed int *val)
> +{
> +	unsigned int osr;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret =3D regmap_read(st->regmap, AD4851_REG_OVERSAMPLE, &osr);
> +	if (ret)
> +		return ret;
> +
> +	if (!FIELD_GET(AD4851_OS_EN_MSK, osr))
> +		*val =3D 1;
> +	else
> +		*val =3D ad4851_oversampling_ratios[FIELD_GET(AD4851_OS_RATIO_MSK, osr=
) + 1];

With the suggestion above this gets:

	*val =3D 2 << FIELD_GET(AD4851_OS_RATIO_MSK, osr);

(or=20
	*val =3D 1 << (FIELD_GET(AD4851_OS_RATIO_MSK, osr) + 1);

). Then you can drop ad4851_oversampling_ratios[].

> +
> +	st->osr =3D *val;
> +
> +	return IIO_VAL_INT;
> +}

Best regards
Uwe

--k325ldattcvx2xxc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmeKKeYACgkQj4D7WH0S
/k6qUggAs9bg07mM09Hc7D/AmR9e556OWsgikgHT4fyeZUcszp//GsK1dGk1V7RI
qRj8he+vk9BuB7GGNR5dic69otw8xstgcLLvIER/EaNf/PoZXURGNoKEXzb5kRiN
A1jTN5ESjLQOrCyQd26olCEsoCe8dhNbdPXWRTrN1Cu6aiMdhMuw3sa+RPBqUoFd
HoDXblF6vQeWvtCo2NCAmM/02ccgnq2fKi6W8HgTNuraN+4NXHtMOVNG35rU82hD
R/QiHmkRH6j9/lvbSTga5qxLjV8Hi6L0kHAwRvW/UZE8+J8s9zcOGNFkpSAXKGHn
BvTkcGvL13VffFU45WjKl8D/l4Za4w==
=IltP
-----END PGP SIGNATURE-----

--k325ldattcvx2xxc--

