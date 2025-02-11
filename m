Return-Path: <linux-iio+bounces-15352-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E1BA31474
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 19:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C20497A1A90
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 18:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CED226216B;
	Tue, 11 Feb 2025 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZYKwDpG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFDF25A2DB;
	Tue, 11 Feb 2025 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739300004; cv=none; b=S/8vqU37CslYo3Ec6jcrgJjUHdcND1B0amdgExeoXvUeMaZvz/QPzEkM31cRLo+IE+VjztjUbqntq2s43tKGjIUpaBm+uHv+rpqeLFtknHNDITQ1Sy/0fvyD07hwFPrdfJCJDjDEEeMXeC6xX6btTiMoXiMeZPq0kujLJX/uui0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739300004; c=relaxed/simple;
	bh=zx+mq+gVP1WF5okPzWakDErC34wKoMoME9IDfsfi93Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwCEeYY0kUoNV0L7zxxm+MAhOJOSxIddOJ7p6Wl9NRBd94bCuJF/SssgrPpSww7hdcdrxyPB+lBRkYf07AzBp0T2x/OYeyLEceQkILVgaOlgFR+JiGt/78p6+9P6uuwzLVT96nrv8TDojVDgR0lXKkDQ3k6S/wk3ENHmVT4u3pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZYKwDpG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34661C4CEDD;
	Tue, 11 Feb 2025 18:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739300003;
	bh=zx+mq+gVP1WF5okPzWakDErC34wKoMoME9IDfsfi93Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qZYKwDpGHCa6m2Qod0KOc6E8lLYCFHvspX9+CuIgvCF8ILv1Mqg9jqR+Ib7D9nwwX
	 YsQ1oarEWWd8RloAJg9ezbrtu66Xb3tOq1s67O1Mx19qqOA8OYtDvJhOZp2Apyz4zi
	 7elTz8QzkUxneevUqRBSa/vdyxS5SrMhAPNNY6MK0jUZw0kwp9Pkz7u+R/iLlhk58R
	 BP8RhRJYDqsUnZjtECldbgQSWBL4RcWom4DovKv4guZJlbZveWap2tyfKMOotXr8Kf
	 jaXzDWR9RIfKL0iBgLLJYERtMMwdWq3Sn1UJfg5crWf7qQHgbw0vaHsMCzkOvSmD/u
	 oRKlw7jQgSXPQ==
Date: Tue, 11 Feb 2025 18:53:17 +0000
From: Mark Brown <broonie@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v8 01/17] spi: add basic support for SPI offloading
Message-ID: <094f00bc-1001-425f-87ca-84646b68bd70@sirena.org.uk>
References: <Z6otFlsmEikIbI__@black.fi.intel.com>
 <27d2a88c-b44a-4712-b066-b999e41774f0@baylibre.com>
 <b1dcbb19-190a-45e7-8e94-cb5ef65f1f1b@sirena.org.uk>
 <Z6pim_nLct33LzfN@smile.fi.intel.com>
 <b000d3fd-754a-43e8-ab10-82677eeee1d2@sirena.org.uk>
 <Z6tcwg7QgQwytoSb@smile.fi.intel.com>
 <Z6tezVXVxVCwXuds@smile.fi.intel.com>
 <Z6tfUfHilO2KLmxv@smile.fi.intel.com>
 <Z6tgNjH6Qq5pe9Gt@smile.fi.intel.com>
 <tnjsrq3trijh4agmbhrfnqeq4iojhwybtg45bwt5n7mg7qqgcx@s7gw7idjuxgd>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UVnWZBsUYOnPBs3q"
Content-Disposition: inline
In-Reply-To: <tnjsrq3trijh4agmbhrfnqeq4iojhwybtg45bwt5n7mg7qqgcx@s7gw7idjuxgd>
X-Cookie: Printed on recycled paper.


--UVnWZBsUYOnPBs3q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 07:45:30PM +0100, Uwe Kleine-K=F6nig wrote:

> There was a similar discussion some time ago about the lpss pwm driver
> (https://lore.kernel.org/linux-pwm/Z09YJGifvpENYNPy@smile.fi.intel.com/).
> The arguments that you didn't accept back then already are similar to
> the ones that were brought forward here.
> The TL;DR; is: Adding MODULE_IMPORT_NS() to a header makes it easier for
> code to use the exported symbols. Yes, that includes abusers of the
> code.

> But if you mostly care about the regular users of an API/ABI, making
> things easy for those is the thing that matters. Agreed, if you think
> that module namespaces are primarily a line of defence against abusers,
> adding the import to the header weakens that defence (a bit). However a
> typical header includes function prototypes and macros. Those also make
> it easier for abusers. With your argumentation we better don't create
> headers at all?

> There are other benefits of module namespaces like reducing the set of
> globally available symbols which speeds up module loading or the
> ability to see in the module meta data that a namespace is used.

FWIW I fully endorse what Uwe is saying here, forcing every user of the
API to separately import the symbols seems more likely to create
busywork than to avoid problems.

--UVnWZBsUYOnPBs3q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmernJwACgkQJNaLcl1U
h9ByhAf/fckjqFNct4SZp/CU5FQltdeSJfJEoKDht7PifSmQ7Toy768CqAlb8t/m
OWP8BQ0Y2N3EM2M/Myoat+PjbGSFQNgR8jiwSv5sQR3e2YlIoKw84jOgjbVdtDrP
GBo4Z9D+s1+qzphUu+qijAjy5ZKb1FT6bdexXJQFIHG9Y2Wjn00T5LiaTORW1q7z
Nbk0HgaBV07H/qkL/KV9IegbwI+NQ8aVxioFH5ciAa3Dvb+tjlZuh8eLrnnYNLAm
yQdE4OJ/60QR5cQNWn7fdoodbCxOm5m1OXbgPyUuykV5e38FIvb9l2JwxC/4IuVe
ctROaAu0kN4p09y2O6wHf1FsRcBVKQ==
=dReo
-----END PGP SIGNATURE-----

--UVnWZBsUYOnPBs3q--

