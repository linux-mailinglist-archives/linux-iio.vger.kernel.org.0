Return-Path: <linux-iio+bounces-12119-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C5F9C3E0D
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 13:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B011C219A3
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 12:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E02819C55E;
	Mon, 11 Nov 2024 12:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2V1xs4YS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383CB55C29
	for <linux-iio@vger.kernel.org>; Mon, 11 Nov 2024 12:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731327143; cv=none; b=mnbU8Ig258UJtetXIWAzhp8OZCaBblnRAF4MPVd6sYfSDy8QsjwZLnUAplzFJOrM6EzO+qCpfM0vK7LZMS1int0gg6uhwebWrSRERe/Pr1YkPdd0l2cY+z/ATKVtZzbAtvtpn5nlFpsVetIjqTnvq2WPdFzOkS91oCNlQRb4Gfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731327143; c=relaxed/simple;
	bh=MYPFJ/QHuhRFvZR1gxMo8eXaZCjaRP6tLWd2q3gcNcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqK3gvXWe4BpzFF7meJ6wM4nVMzh1FoR3WVdqcLfFgiYQp2flZh3Ry4GaOUlhDiPBY+z6XrTGdHtMlSyUUkueG+mAcWthDjO0J7y0b9ddn55NRem0Y5Gopshq/PaEo+eAz2T7skra59JBYhfcJbr1Nc/kzLs4iraYczzarbQQ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2V1xs4YS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so37262585e9.3
        for <linux-iio@vger.kernel.org>; Mon, 11 Nov 2024 04:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731327139; x=1731931939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xs+3Bmk7/ET8ZIXxUWywxy47jkhQeABRqUPAmW38Cw0=;
        b=2V1xs4YSfvzgAHTu3ddY7aQXSHINjseTy6sppFujC1yV7TgLUcOG7MybzZkXCItt4E
         Gfn7bxr1wm9dsHuRJzwXHQ6Wy9z00AzfZufLUUlcOg0X4Ah2J2wWCMUv5UAF9Xu344tU
         16OfxyzABgAM0zLlqui5OPtHK4B/9vqkCFiEuYDAFM/3qVnUxxw0eLmNsFjvv47xrNzs
         Dbtl/+vaHbCRRrIGV18ehAG5r7jCttQmozPggvfs0cxqnseFFqt0UMtw+IA+PbuQ+hCh
         B8femclRdXtoSk6Gvn1LK5rRySN3wGtVNLjhJLsIgJEmZO3aQiPfVsDkOULWofhE+dPf
         yKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731327139; x=1731931939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xs+3Bmk7/ET8ZIXxUWywxy47jkhQeABRqUPAmW38Cw0=;
        b=pNJBnLo1adWemb330324CRNfyPTsw0nD6CZ/H0pS92NgrhoREOFEpZtW24djdIhdpG
         Pn7P+iw6gCVRFEIlsBffoBmhHfJ80KZbFtRqPvBEdbYsjmIeEWu6S1NVl81iP5vDtUTQ
         /8yI60RLH1K648nXBnEJ81P3JRkjUEWwPQD5bkYGdW08X6p3aCBgl27qpXbaJIioaxRN
         Bxs5YaDneFRcHHI1QNPY+KsjE+1mdnSp+5qdlUmt67BVSacVYKBI/IOSMwvQ/00Ji5Ia
         AZgz/CihuUMNfMCx0cHte8K6MqwkvJsiWIQ4KY7WaV2bMcqegWI9m/0vtvcfH1VRlPCy
         YhiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSFAd1vd7icGgO9NKphO/SM24FpgwtL879GPi+q3/FQhe7p3h6/+rBMFPvnspZrrKsFMnTq4JEnmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaU6T3r7ysM9XoLYKdANEA0qqWDO3tHdMN2fbLt4J/Hk72h9AX
	OcUcFk09O3YydWpiqVe8eL5pvqQl+Dl0hDAn8xoyy1l/s3f8fIh69HBHgFyKOcw=
X-Google-Smtp-Source: AGHT+IFTrCeJsG4pTRHfhvy6GFhZe1enatnsIdLOV+d/7VyKJJXALSMPOSSGn3f7bQZGCXpBbPrFsQ==
X-Received: by 2002:a05:600c:3b8f:b0:431:5f1b:a7c6 with SMTP id 5b1f17b1804b1-432b751f5edmr101593285e9.30.1731327139457;
        Mon, 11 Nov 2024 04:12:19 -0800 (PST)
Received: from localhost (p200300f65f28bb0063ffae39110fa2df.dip0.t-ipconnect.de. [2003:f6:5f28:bb00:63ff:ae39:110f:a2df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97cfefsm12671139f8f.26.2024.11.11.04.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 04:12:18 -0800 (PST)
Date: Mon, 11 Nov 2024 13:12:17 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, lkp@intel.com, 
	oe-kbuild-all@lists.linux.dev, Mircea Caprioru <mircea.caprioru@analog.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibe.com>
Subject: Re: [PATCH 2/2] iio: adc: ad7124: Refuse invalid input specifiers
Message-ID: <v5ytfwjmimsbfgdq3sb2xg6d2dkllvnv2a7wltwtzt62oqikge@574uazpvjd67>
References: <20241108181813.272593-6-u.kleine-koenig@baylibre.com>
 <bb25249b-62b8-4d7f-9ef3-cb5e1f8674ba@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fouxnykmbwuimmjy"
Content-Disposition: inline
In-Reply-To: <bb25249b-62b8-4d7f-9ef3-cb5e1f8674ba@stanley.mountain>


--fouxnykmbwuimmjy
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] iio: adc: ad7124: Refuse invalid input specifiers
MIME-Version: 1.0

[Dropped Mircea Caprioru from Cc: as the analog.com MTA doesn't know
their address]

Hello Dan,

On Mon, Nov 11, 2024 at 12:15:45PM +0300, Dan Carpenter wrote:
> 4112b30ba58b5c Uwe Kleine-K=F6nig  2024-11-08  871  		if (!ad7124_valid_i=
nput_select(ain[0], st->chip_info) ||
> 4112b30ba58b5c Uwe Kleine-K=F6nig  2024-11-08  872  		    !ad7124_valid_i=
nput_select(ain[1], st->chip_info))
> 4112b30ba58b5c Uwe Kleine-K=F6nig  2024-11-08  873  			return dev_err_pro=
be(dev, ret,
>=20
> s/ret/-EINVAL/?
>=20
> 4112b30ba58b5c Uwe Kleine-K=F6nig  2024-11-08 @874  					     "diff-chann=
els property of %pfwP contains invalid data\n", child);

Indeed. I adapted that in my tree, so will be fixed in v2.

Thanks
Uwe

--fouxnykmbwuimmjy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcx9J4ACgkQj4D7WH0S
/k4nJQgAlTnkDayqlntyEewP3+b8xai6S8tWGg4oVXcZG2VRF9hJmUZYIislQRT8
RqFv8/YpMKLVUWklIvFWyCHXhouEd4dwSuJnflIwgTRii4S9yNhhv2l1INDzQqWz
zNKRfRAeJS/FC8Ju9yICppslJNCUnZiAuD1BiknH4u2aiM0M3TDHwDjS3NY08VFI
fX5JmGG/UGw7PFOLc+aiTzkOrhpK0Zevx9k4WDPBP7iUZi9Py/bBYYNW+qPLkTn/
h22Z8nzfFNPrvMlorIh9ETD+ON2GlO/qBmH94/DyLVzcLSnsxNMbxt1RUYXNAavR
CtGw1AmZTRW6Ldpvo/vDMsAwnU7Sfg==
=fCAt
-----END PGP SIGNATURE-----

--fouxnykmbwuimmjy--

