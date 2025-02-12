Return-Path: <linux-iio+bounces-15425-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F42A3218B
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 09:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85EF91888EB3
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 08:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2280205ADB;
	Wed, 12 Feb 2025 08:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="So5F81QA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955D3205AA6;
	Wed, 12 Feb 2025 08:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739350361; cv=none; b=CSSKxPIgsGbN2Re7bE3fTcg9WeW798QZasq23dxIt0LMAl/BNWYFMwTsW45fLaS7LX0UMa3iP8J3ol7CWLiY6TupmvSImBjybuR20us3JrB+u2f3TseO+obd9SEdLvfoVIUqAEy9dPJuanHJqxrr/qoNFlpvNNppb9vud56yGYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739350361; c=relaxed/simple;
	bh=bdK+VxiVV4KOUJRWDrAuxeH6gy5pVd6hYgPsv08gCJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AReMbIIRfhKyeON8boIX5yU0bXIbl7PpwwKnQk0NHL+Fkax7QWLIHS4RTx659udszn9JVlJhhsETxRrf5o7GrQa3HHKa+JhAfjR6sS41kqVQZjXNMxEAAXorSrrflZOZkgMDHNjSiv5D6ayUTWoRWWTktt14bzVEDn71gcR6hYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=So5F81QA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612E6C4CEE6;
	Wed, 12 Feb 2025 08:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739350359;
	bh=bdK+VxiVV4KOUJRWDrAuxeH6gy5pVd6hYgPsv08gCJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=So5F81QAuwJ+1qRMtQ9WFciFLq9qfBrsXjuU+FwMIF/BMpbj4afsLcc5FeEIDgwA+
	 j11Qsh+ENXn6+UWmBmVbGL6olFhQCS0zMmpgryrDMC5PlGFNOm8LSJc2r5sbU/EHer
	 3pKOhgb+fygeaDpGivfoinzbivP8U2SqqvoonL0qxYe3ddiCXf5cd0c2mgxMRpRkw0
	 jqDFmgKfNNHTqKgpbzojSGEgeivLKBGyy0s8gdq4HIc83Q/zoNLDwhDLHaFhmggUhs
	 B5dkfCd8LvmR5EUaI2sfpB6qoDODu3NK2EMtrKMWkSPw9zgFaXzr0e/9K6D9V93YgE
	 ySk+CO0MCAZ/g==
Date: Wed, 12 Feb 2025 09:52:37 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Mark Brown <broonie@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
	Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v8 01/17] spi: add basic support for SPI offloading
Message-ID: <57swm23ik5kyzcjvnhkizctnemtlqf3duhrd5u3n6yelxkerxt@6akfoqmyqsup>
References: <27d2a88c-b44a-4712-b066-b999e41774f0@baylibre.com>
 <b1dcbb19-190a-45e7-8e94-cb5ef65f1f1b@sirena.org.uk>
 <Z6pim_nLct33LzfN@smile.fi.intel.com>
 <b000d3fd-754a-43e8-ab10-82677eeee1d2@sirena.org.uk>
 <Z6tcwg7QgQwytoSb@smile.fi.intel.com>
 <Z6tezVXVxVCwXuds@smile.fi.intel.com>
 <Z6tfUfHilO2KLmxv@smile.fi.intel.com>
 <Z6tgNjH6Qq5pe9Gt@smile.fi.intel.com>
 <tnjsrq3trijh4agmbhrfnqeq4iojhwybtg45bwt5n7mg7qqgcx@s7gw7idjuxgd>
 <Z6uhHssgIvI2DJ4c@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xdcwwos2kopmxeag"
Content-Disposition: inline
In-Reply-To: <Z6uhHssgIvI2DJ4c@smile.fi.intel.com>


--xdcwwos2kopmxeag
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 01/17] spi: add basic support for SPI offloading
MIME-Version: 1.0

Hello Andy,

On Tue, Feb 11, 2025 at 09:12:30PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 11, 2025 at 07:45:30PM +0100, Uwe Kleine-K=F6nig wrote:
> > I have no problem here. If the header becomes stale we will most
> > probably notice that eventually and remove it.
>=20
> Lol. Look at the header hell we have now. 98% code in the drivers/ just s=
how
> that the developers either don't care or do not understand C (in terms of
> what headers are for and why it's important to follow IWYU principle).

Yeah, there is a problem. The source is that we have a metric ton of
recursive includes (i.e. headers that include other headers that include
still more headers). Even if you care, its sometimes hard to know which
headers you actually need. One idea on my long-term list is to add a
machine-parsable info to header files about the list of symbols that the
given file is responsible for. With that in place we could create a
linter that tells you that this source file doesn't use any symbols from
<linux/of_irq.h> and it should #include <linux/of.h> directly instead to
make use of symbols defined there.

> > Maybe the unused namespace even makes it easier to spot that issue.
>=20
> Do we have an existing tools for that?

There is https://lore.kernel.org/all/20250123110951.370759-2-u.kleine-koeni=
g@baylibre.com/

Best regards
Uwe

--xdcwwos2kopmxeag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmesYVIACgkQj4D7WH0S
/k7IZwf/c6sadrN59CUeFwhx+1Vi2lm0uGLDw8ig3j9mjaUBxGEW+wvDO30U1Ft8
fn2S/+cnpAbM2TEwvJD80kIky8yfXsR48Ui2StGSkBx/CYodyTmMMpNP/UO8lIpK
ZYk7Stg/AfTXce6zpAE8zY/EuhrogJUftvIQQ+sFMW7CSB4H2znNyF75toykH2yy
b0jkB16S8qUWsBpHLC9kJAC25e79lh04pwIoPcuZh6fVUrJSZtzEnF7i5D6vOROO
MIZ+AWx9uNC7YsP3Fn+iIC22Kb86ee3ulW8P4q1IOyqMKwMnnTcZksEJJjKJsmsc
P7uBKCJdzIdzWBneEgXT4JxfJexMLg==
=nkBh
-----END PGP SIGNATURE-----

--xdcwwos2kopmxeag--

