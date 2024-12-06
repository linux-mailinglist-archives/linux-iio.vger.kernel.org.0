Return-Path: <linux-iio+bounces-13163-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FE39E7537
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 17:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D403828B5FF
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 16:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9812A20DD47;
	Fri,  6 Dec 2024 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xVmocDZ0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3303820D4F1
	for <linux-iio@vger.kernel.org>; Fri,  6 Dec 2024 16:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501511; cv=none; b=nVohnDF8foXVQFxK8JV5m4lOgvJbhOkNNJ7ZJM8Q/o+HxeMqvGfVe3VsvyXkbOZ7XIBYMBkha3ksF0MoajWOxBX6RFj9uatpy53zWeD7dr2oQKqFJ0zuod49z7M8skX6I/kXED6eVWXXCIUKsEx6cm5VGOn/7f63HBaW4u7TOxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501511; c=relaxed/simple;
	bh=4eGgtxw8sd5EqOnZy7TFmnGi9n+uxRuuItBO/b7qhEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmgIfb5dvfpwvfAPRBVN3pPYLjhQTypk9bzw1zHuvsgiC7s0CrQRWsXcWRJfL6G0gCI5UAwsuKYgxhAA6pR7BD9dfTPsp9iwzHDWpEYFVMdHXlm6ZcyDpXAagirbx2SR0yXw1ySJtpRK78ypk7nZBI350brTM+4oO/c+20yHhyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xVmocDZ0; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-385ef8b64b3so1824898f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 06 Dec 2024 08:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733501506; x=1734106306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i/xiAS5UyfNRFlQZkgCdUkuF7g+yia9KjQjcPH1rjlc=;
        b=xVmocDZ0Wh/5FjCXMuiBI5DI9Il+4lvRB75PyIgnHxFuewSCkbVFmG+dlp3+w/o26V
         NjWMLRLlll4i8xbBUuUOIcJ4TQq90rqKttsscwpekPPeqYgX3m9vF4DbKUShYdQ+i6nk
         +0YyJ8DV6zCnR4p0C03iFTd4TQSfGrgK5MNDB/mhz815mQl8eInn+/iq/ud0aa5AGpWD
         /U/VZMaWGFZ5dv5SfA0A6DIP6kjPFxiT16OU3Z+zt8xi5X2mN7et21O9YbuYT57upmqC
         5QIG836I5cp+DsaeKpFPLdmU9RkJssfmFfLZfu3VXLfYiwrlNv0GM6waDXnknLqrHZcF
         jxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733501506; x=1734106306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/xiAS5UyfNRFlQZkgCdUkuF7g+yia9KjQjcPH1rjlc=;
        b=NQAaBoeIER05QsKL1toideFEnwEySatqa4Ql7tPEDIU8U6gbstag4/EZSaGSLnoFtn
         6t/6ZeiA7I51GyzCbvqpRUjT2m6tR+Chde7b7wcFkp5dmbGd+2WTnpAl+NXuW7iLLb7F
         x6g5Faat66rpZlOC+dNtLbIVO2b+pgYwYfMgLOVs7RczT2eRDVvB7dP5Z/EtQlz65qwF
         sVjq6+yj7QS73WWT2epTEGTxiXzZAhleUwdRvLqpBgk4GeIdFqYAM3nZ2+Ifb2wcFQNj
         pVJUxN/xxqcr8I0Ty5mTy3OVH4v1+OJvlM2LzsyadC60BLqwPmOCbNDMPMjf7wa17yjH
         vNqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9y+ORLunrCyGKYjvSHJm3n3Q30804jv+uxnonwrHAdOfSYwDKTX9vRXwPd6Yu6l+bhAIb4jS4B9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBKJbi9ZZauVBF91Tm0iJ46HIUrvcZytXgzmhLK/AReokd35Cj
	9ZQz+JKa3zs3BKDzK0RWOnjLPOx+E7ASMjsKDYHouT53wsPgrz2GzMUuJoNkMaQ=
X-Gm-Gg: ASbGncskwC/w4ONrU3mxwsQfrhWndBZxUeRTc0N73OGvLVRc7mtiFgPdm/f2DzfdVc3
	uX2evxlwToNFucPUm7wzbLPAsGw7qLDSWB5Ws0/ek/65p8crpVZOLzFKoain/xWFMQH/Aex+Fok
	fvm/6NC9Ef16DRF5W36sy9NTI5sKZuzjNOTvTtTzJT8zBjKFg5aXfKOMJzLUSyUKMen01hqym1Y
	J6AroTTNsuaeYefxfi+Dy1TswIx4CVF7tZpbzkpsXuqfF2v0j9JYwWEyetbzT04KI8Y4bojU2Ej
	nbwd
X-Google-Smtp-Source: AGHT+IGkCkYOoMM7XFFXDF5B43FQA9JNOmeVeDh71DwPZFTmZAwrKvFV+4nJ0p3LDeWlzuKKvaJJNw==
X-Received: by 2002:a05:6000:18a7:b0:385:f7d9:99f5 with SMTP id ffacd0b85a97d-3862b3cefbbmr2965189f8f.51.1733501506405;
        Fri, 06 Dec 2024 08:11:46 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861fc51451sm4940030f8f.47.2024.12.06.08.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 08:11:45 -0800 (PST)
Date: Fri, 6 Dec 2024 17:11:44 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Dumitru Ceclan <dumitru.ceclan@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
	Guillaume Ranquet <granquet@baylibre.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Masahiro Yamada <masahiroy@kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] iio: adc: ad7124: Disable all channels at probe time
Message-ID: <rl5h6oearvxy4dxtqd5kvcoktsyqyhvhw2qccjcbp3gbsxose2@hpuf3xacndyl>
References: <20241104101905.845737-2-u.kleine-koenig@baylibre.com>
 <20241109152438.0135f0c2@jic23-huawei>
 <7did4jkzbsvovlinkjimbn3zdqrwi2mrs2onukfonjeexnumvh@xbzcdad4v7kd>
 <276fcd4d-5066-46b8-8468-f63d35b74894@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qbo3l4jyla3udbsp"
Content-Disposition: inline
In-Reply-To: <276fcd4d-5066-46b8-8468-f63d35b74894@baylibre.com>


--qbo3l4jyla3udbsp
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] iio: adc: ad7124: Disable all channels at probe time
MIME-Version: 1.0

On Fri, Dec 06, 2024 at 09:35:15AM -0600, David Lechner wrote:
> On 12/6/24 5:04 AM, Uwe Kleine-K=F6nig wrote:
> > Hello Jonathan,
> >=20
> > On Sat, Nov 09, 2024 at 03:24:38PM +0000, Jonathan Cameron wrote:
> >> Sadly this has probably missed 6.12, but I have queued it up as a fix
> >> for early next cycle and marked it for stable.
> >=20
> > I interpreted "early next cycle" as "This will go into v6.13-rc1.". But
> > that didn't work and didn't hit the mainline yet (as of cdd30ebb1b9f).
> >=20
> > This patch was included in next as
> > 64612ec9b909b699293b7220c634f67a9fc12e06 between next-20241111 and
> > next-20241128 and then disappeared from there.
> >=20
> > What is wrong here?
> >=20
> > Best regards
> > Uwe
>=20
> FYI, the iio tree is currently missing from linux-next due to [1].
>=20
> [1]: https://lore.kernel.org/all/d707cb3b-1569-45d9-bdc3-dcc98eb88bc4@sir=
ena.org.uk/

I first thought that couldn't be the explanation because that conflict
happened to late, but indeed next-20241203 is the first next tag after
next-20241128 and

	git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git fixes-togreg

still contains my patch. Thanks for that hint.

Masahiro pointed out a merge fix in the linked thread, but I think it's
incomplete/wrong.

When merging the above branch (currently at
1694dea95b02eff1a64c893ffee4626df533b2ab) into ceb8bf2ceaa7 ("module:
Convert default symbol namespace to string literal") I'd do:

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio=
/imu/inv_icm42600/inv_icm42600_core.c
index 215731bd3c7d..ef9875d3b79d 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -100,7 +100,7 @@ const struct regmap_config inv_icm42600_spi_regmap_conf=
ig =3D {
 	.cache_type =3D REGCACHE_RBTREE,
 	.use_single_write =3D true,
 };
-EXPORT_SYMBOL_NS_GPL(inv_icm42600_spi_regmap_config, IIO_ICM42600);
+EXPORT_SYMBOL_NS_GPL(inv_icm42600_spi_regmap_config, "IIO_ICM42600");
=20
 struct inv_icm42600_hw {
 	uint8_t whoami;

The MODULE_IMPORT_NS line for
drivers/iio/imu/inv_icm42600/inv_icm42600_core.c was already fixed in=20
commit cdd30ebb1b9f ("module: Convert symbol namespace to string
literal").

Best regards
Uwe

--qbo3l4jyla3udbsp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdTIj0ACgkQj4D7WH0S
/k7gRgf/T6zD77gJR5j47uvhom63da9TRFQwJ0iuuvXIXZ4+yP3G42Mo52gTJebU
N13zYGXH0tvd3gsPGrDvGZod8h4vkFzwW7nrfUJ8v0QqNy9zwuQrB1jmaQ36Oaw6
fo92OXzrQcc3B6hvaxn7I0DORaRnAF1xndCY9KCyWY/F1z04uEyqQTZPzR5Sk/GA
ootm/2zpwVqdk6lEkbS6QaCyIYsa5AhCf8Y95wK9pJMwkz29Aea39hpvLN+T8tuF
srrO2b/dyRaeQjD9ICYgwiatWbLMTB8wbDIvB46IWF2WH+sAF1YJkUL3aHK0/jF0
L0XrMGZHTRN3pmf9L4NeoPFRh3S3SQ==
=mQKO
-----END PGP SIGNATURE-----

--qbo3l4jyla3udbsp--

