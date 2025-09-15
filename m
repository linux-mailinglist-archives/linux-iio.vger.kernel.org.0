Return-Path: <linux-iio+bounces-24098-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C439CB56F9A
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 07:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D39A189AB19
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 05:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D534264A83;
	Mon, 15 Sep 2025 05:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="fsJyzRbp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F261E1F09AD;
	Mon, 15 Sep 2025 05:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757912737; cv=none; b=fK/oOIZFG8QiWG3O2PWPox1I1Cs2aVlEXWrDW+U+OjkZS6q/xBuQtc8+eRUmmhpoHntgP+yUOk7hhS7x0u+VI64tgPxyM9i2k8zLjlO+1kSXg1BiRKCsoLIgMCbJOOshwVnXKbUCjtJnBO97EgGURmyjTDqJ77LuxqjA6PfFrYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757912737; c=relaxed/simple;
	bh=DWWpw+cg6mg2cz5gFU9WV515EsQKDAs2Xzllkbaeojw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=catO1CRu/AwO/CeQZX40DZj41TP1gkrviYSCwGr90DRdnrosUQoOESfeN4Hw69zwXpTXIROY+sKX01uoxOyDyZvJ2tfIZKJtikUFSKGFQnjyWEBb8lXKeGyNjbjacz1d0i/uNIxPft8O6iZiwmWqmYCEmTiJch0wcnj/Pr3hv50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=fsJyzRbp; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from lipo (unknown [IPv6:2a02:2f0e:3e0c:5b00:f1e0:3f4b:286c:9ddb])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 28E10173BE2;
	Mon, 15 Sep 2025 08:05:25 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757912725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jmzzVjzWeJgCqh72+oLEB1rChBlbvqZeGde6QApGq7A=;
	b=fsJyzRbpENi2ZRtC6ZhAah1td0vXzm01VG4yMzxseMfb0ZNMheOL2ylXOomPUqy5iQEuaB
	fgL5RqFvhY82FVkLyFgSvEce3EL1Vya2MiyVEPGM2nq+9EwaVyNGU/2njxd7ZlPpcLh/hE
	vQ92IPjlKZbZUhvsjeQ6k+PKdSHwO4KusVwa6bAtD8B0eZ3c3v4Xhp60c8g8w59fG+nWza
	D6V5wnomlRIvXOzWMmi5O7oTcBUN9WdrAKxgTL6rDKFY5J7Eka9tuHhQUDwJphsADqkDg/
	QbrcbPXgMbD66adeBvWazcu/KJshKaCH2RvuP50HHbnVzKn11PYd4e/SzaP4sg==
Date: Mon, 15 Sep 2025 08:05:22 +0300
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno S?? <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/18] iio: accel: bma220: split original driver
Message-ID: <aMeeku8OseSrTqW1@lipo>
References: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
 <20250913-b4-bma220_improvements-v3-4-0b97279b4e45@subdimension.ro>
 <CAHp75VdWQojOj2MLS4dOvMKjSGcAunc4ND9SPsGrZBBctPdQgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n8fC/aannE58fX1E"
Content-Disposition: inline
In-Reply-To: <CAHp75VdWQojOj2MLS4dOvMKjSGcAunc4ND9SPsGrZBBctPdQgQ@mail.gmail.com>


--n8fC/aannE58fX1E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


hi Andy,

On Sun, Sep 14, 2025 at 03:45:07PM +0300, Andy Shevchenko wrote:
> >           To compile this driver as a module, choose M here: the
> > -         module will be called bma220_spi.
> > +         module will be called bma220_core and you will also get
> > +         bma220_spi if SPI is enabled.
>=20
> I'm not sure the last part is practical, as one needs to list all
> buses next time a new one will be added.

it's just a friendly note to the user of how the modules are called.
the sensor supports only spi and i2c, so the list is short.

> > +++ b/drivers/iio/accel/bma220.h
>=20
> > +#ifndef _BMA220_H
> > +#define _BMA220_H
> > +
> > +#include <linux/pm.h>
> > +
> > +extern const struct dev_pm_ops bma220_pm_ops;
>=20
> > +struct spi_device;
>=20
> Besides the location of this (I would expect it to follow up include
> linux/*) convert the existing driver to regmap first and remove this
> unneeded churn.

[..]

> I haven't reviewed the rest as I believe it's just ~1:1 copy of the
> existing code, but I still think that the result will be better if
> this series starts from small fixes, like kernel doc, and other
> things, followed by the regmap conversion and only _after_ the split
> is made.

either way you look at it it can be seen as churn.

scenario 1
    split is done early: ~300 lines from _spi.c have to move to _core.c.
    I tried to do a 1:1 copy so it can be easily diffed, but small tweaks a=
re needed here and there.

scenario 2
   split is done after regmap: much more than 300 lines need to be moved AN=
D the code would diverge way too much from my target.

as I see it scenario 2 is worse from a reviewer's perspective and a nightma=
re from my pov.

I prefer to stick with scenario 1, adding a few prerequisite patches if you=
 so prefer.
It's much easier for me to cherry pick modifications and copy them from my =
target code once the file structure in the patches have a _core.c, _spi.c, =
etc.

this is what I had in mind for v4:
split prerequisites (2-4p) -> split -> regmap prerequisites (4p) -> regmap =
-> regmap cleanup (2p) -> i2c -> features (5p).

best regards,
petre rodan

--n8fC/aannE58fX1E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2Ap/wXYVGTXsPl+pzyaZmYROfzAFAmjHnpIACgkQzyaZmYRO
fzCKmxAA0LLGgo96dzWN1yesI0dIDmPCtvwGCxqRhmWGylwUEmxJaS43cLBL5qb7
ZZUUREp1G1j4D9NIplVhRJyW8uWG3DdxIt/D5lXOypMTzQc5sYMJQWNGtEhGGh3Q
4guCywJ5qzQ/CI0onPcH+w8kLTI9O9hBb4pJ6OiXwaL1tUjY3marh05VoLD0Xl9r
KaAOIplrtjmmzte4+r5NS64z+5mFifE/WtySoB6/LrdMSHjPvpXPsSqKDFL4nrj+
Tm2AuXQGFaeEfJI3WJWJWjcvDkvbVdIjhaImM970/1mQy5Dp/aI1xFkalJUQPFUy
AQ03TzGlRANlfDs0hZ3GZOPMGAba+aIx1+Q6PHqX8fYfOXoA2W5iYToo1Wyp+YVe
1ris5cBHkfacowRvK6tzPFfhsi8XMdOZcd1ATTeQa/AQ2JZRSG/xrvPOLE7wj13V
9kW+vlYcyUorodUrWXBzfHel0aE/pU9JBk4DwULDez0WI3jSQUY5MMl0GaGNXmzw
1UOvDnGZf0nlpeqW6xKckshEyTY21+F4WxDIUeomCatL+UvwhIjfKtmNMpuyc0pn
JyidyoEUyMhPmr0VhBXZNgO9DWj/sjaMscaWIE5s7/+if756Y9TBUE8OBmBlZgHJ
X71Kd7Ni6JAnVIsNHX7g/ZjwKimOCeu/epWkQraAvLKEix2PzlE=
=s737
-----END PGP SIGNATURE-----

--n8fC/aannE58fX1E--

