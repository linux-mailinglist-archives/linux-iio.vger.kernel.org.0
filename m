Return-Path: <linux-iio+bounces-24019-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4E0B5526A
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 16:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06CA916DFC6
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 14:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDB330F552;
	Fri, 12 Sep 2025 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="hlu++fed"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2E730E82A;
	Fri, 12 Sep 2025 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688884; cv=none; b=XziNcRk9vpPLm2RQjUn/W2IYH+b2tw0hPduPqYNdYmMBTiR0taIPnp8QAc1xOX4Yj6QtsMZgwOtTrHMBfFdjfH2a1Y4r1F8o2DMOnaJa9YsbGhtBf1dH4pFyfDjwLmH1PUlLSLz0R5W7Pq8VbhJcWJfJFeRbr9V8NzcKyLRvGck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688884; c=relaxed/simple;
	bh=43sPUIgTO6HCq68p3GwkIDQs2j/M/eP1MQVzYdXQs1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiyBsVqUSQvU0C1E3k+GgRxrB98frRrwQrp2eomGjvqj5mY9jwR88BPNQGY064GadSD561bK3ko1mmNUDbknG2czQrXHOEPZUG5hOO+UybRTet19780OfuijXpEIH/PGeiI0aYWUL7J+dRXTKOKa3d9cA6q/5q5xR/IaKg+JMiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=hlu++fed; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 299A9173BE2;
	Fri, 12 Sep 2025 17:54:33 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757688873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i997PEp8x53EPLAbOD12VVrJVmzE6zksSkU3oGO8N+w=;
	b=hlu++fedvor4dY1h06Pq3CkiFuI36x6mz8GbfjrYBukc5Y8ijbiZqI8jwyWOpd4VenDeA0
	3JsU8jkti8RKYlj4cm9iMKHczsmd9gqDhlGkcVXH6WW/n8Lavop0vDmfiNX1cc6eP8g2dk
	fkCk5/xBaiwicKcLvYMH6KPQunEW91ROJeDg/XkWoD6Si1sr0RhpG4DqsCgQIt3fmUk4MV
	qYP38U1RqlEDsLl6UmubjfA0mfGAfygjrSUBcgSSuU8nYbTwqFch5/T7/4r4xW8+lJmIGu
	5uzlDP4cPb5lZ+491FptjHIJqiVj2qnk8wP0jBxXi9rGnJf16+rzEJXF1B0oXA==
Date: Fri, 12 Sep 2025 17:54:30 +0300
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno S?? <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/14] iio: accel: bma220: migrate to regmap API
Message-ID: <aMQ0JlbqIuMwDBpQ@sunspire>
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
 <20250910-bma220_improvements-v2-8-e23f4f2b9745@subdimension.ro>
 <20250910191225.43a89a1f@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MLiN7/ynhD7kwmi9"
Content-Disposition: inline
In-Reply-To: <20250910191225.43a89a1f@jic23-huawei>


--MLiN7/ynhD7kwmi9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi Jonathan,

On Wed, Sep 10, 2025 at 07:12:25PM +0100, Jonathan Cameron wrote:
> On Wed, 10 Sep 2025 10:57:13 +0300
> Petre Rodan <petre.rodan@subdimension.ro> wrote:
>=20
> > Switch to regmap API.
> >=20
> There are a few things in here that seem unrelated to the regmap change
> and should be in separate patches where we can review and discuss them mo=
re easily.
>=20
> Thanks,
> Jonathan
>=20
> > diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220=
_core.c
> >>  static irqreturn_t bma220_trigger_handler(int irq, void *p)
> >  {
[..]
> >  	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan=
),
> > -				    pf->timestamp);
>=20
> Why the move to grabbing timestamps in the thread rather than the top hal=
f?
>=20
> I don't necessarily mind that change but doesn't feel appropriate to have
> it in the same patch as the regmap change.

one of my unit tests [1] fails when using the original code (all timestamps=
 are
0 when reading the IIO buffer with iio_generic_buffer)

would be easier to just split modification into new patch instead of debugg=
ing
the old code :)

[1]: https://codeberg.org/subDIMENSION/lkm_sandbox/src/branch/main/bosch_bm=
a220/unit-tests/permanent_latch/test.sh

best regards,
peter

--MLiN7/ynhD7kwmi9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2Ap/wXYVGTXsPl+pzyaZmYROfzAFAmjENCYACgkQzyaZmYRO
fzBeSBAA2OHqPgDvP5X/Om+rSzgoHF94mT9ZjPme8t4Pe0fjOLKAMDvyy33pRLu2
ycDyu58tbwHC/fLfm8SzEP6EgKldtYpFd3VdmDu7/uwzg1ZccG6sPQRV0Tr+gbV6
yal3gOcHYuDLtU5ImPeh2FMZQzFyopHpJb62UvdQ6KdKg+RwrWvsrCz+fZ6MiEkc
7xPQDf2qi1tS38umKumRW6nCO35/fNk97zGf1qdBhCv3m7XNIn3ko8WBHqdg6TAd
GnxYYDPmUTQoTcYhet/UEIKokBVvKXdAhpXsELz2ztk/hQm6CgArpbpa7LLuabcE
i7ON4EEl8geX6ZS4ZFsSz+tYDFSPocFPkcKahiXYKnX8PwKnYzJIo71rfF+IHELa
939fF18DvIO4dfWLXkPTSekhpnIsWMEHACEECp7pwr37sIL7xiq4qEGLRq7EkghE
evHVVjyca8dgdYCquC+Ic8QL5hn+hzsBzfHvmb+FhRQNSkQ6nv72VuHDO3kWfQCV
TO5VoMgKB4MBNT8h1snxtuLj+KXQSxMRn6tvUTdS/YKL+mXok6uwpEpT9zdyH6aJ
0RMZ2vfTftk0D95d0uV2uKYN9VrMBwq8hrcLB0mBdiGMBhlU0cfkdhw+hKTY+xnC
Fqxl/sQ5fTGXDelp1bwkjp7/iA6slXhBWw5WT+YRwogRCSfQoaQ=
=CIgw
-----END PGP SIGNATURE-----

--MLiN7/ynhD7kwmi9--

