Return-Path: <linux-iio+bounces-15351-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771AAA3144F
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 19:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED003A2048
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 18:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C9725A323;
	Tue, 11 Feb 2025 18:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="siQpu+/a"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4300B1D7989;
	Tue, 11 Feb 2025 18:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739299533; cv=none; b=oP+ZQz7CEYgBwBjmOwLjq+7uSvzPMAydQta6wLb7n+mUYK2ScJOybs1KK6ogu2HHhFQZYCvS0TCxbtbCXGXe/bbVd49tns6nSCcRS0WN5OV8KBXoJQ4zwMKfFmSV7ecAO61y9zTiP1h21nC+qvX8ifICHKOO0Ok+m/gAdS6yWVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739299533; c=relaxed/simple;
	bh=Ot3q4DJ8uEejJPQTsE5rUONmeArjHgolfr2jP+6IfBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCnmAKtzKm5Apnbegr9WeiOmuuw6edWLbudcTThieXTWoW3ZmR+vRKmk9O5n0JmwmDvafLttBzCbXe4Y/jvhxiR6B1fZcYmMUPUH5oiKAbx90n4CMRj2s8DynwbbFd80WSJv/A5XoPwkuzGOreBNvg5GfPTFKc/3clkdnNxldQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=siQpu+/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D739C4CEDD;
	Tue, 11 Feb 2025 18:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739299532;
	bh=Ot3q4DJ8uEejJPQTsE5rUONmeArjHgolfr2jP+6IfBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=siQpu+/aAkPI2iJoqp8MrerfEOxOzgzV5IuyHswgFBN8NEzSGmYrLwq3vpGNUSOXd
	 m05DLN0F5egatclVsqDnQV6Lzr80y8NL9ry8ZHC7Y92MGfw2JOVGQbwNvz8pT+2sjs
	 IKHYG2fHnP/sewa0dRmYpkrNM4ci2lIf1ljFqs5u8Q3UbkvWORWJ6IqOlojtXJf1hR
	 Xgls7fvt753hX/ArOuschtcngHSONRlbZcZUwMqr1RW80oUYapoIPOajNvtUow/+xo
	 9f1KbTylkTsJ9Q6UzwIrllJsgU4GOSBNIngQoASNGBaLAJANr7JdXsD+FqnQjvpIP4
	 09G0R0bwllx4Q==
Date: Tue, 11 Feb 2025 19:45:30 +0100
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
Message-ID: <tnjsrq3trijh4agmbhrfnqeq4iojhwybtg45bwt5n7mg7qqgcx@s7gw7idjuxgd>
References: <20250207-dlech-mainline-spi-engine-offload-2-v8-1-e48a489be48c@baylibre.com>
 <Z6otFlsmEikIbI__@black.fi.intel.com>
 <27d2a88c-b44a-4712-b066-b999e41774f0@baylibre.com>
 <b1dcbb19-190a-45e7-8e94-cb5ef65f1f1b@sirena.org.uk>
 <Z6pim_nLct33LzfN@smile.fi.intel.com>
 <b000d3fd-754a-43e8-ab10-82677eeee1d2@sirena.org.uk>
 <Z6tcwg7QgQwytoSb@smile.fi.intel.com>
 <Z6tezVXVxVCwXuds@smile.fi.intel.com>
 <Z6tfUfHilO2KLmxv@smile.fi.intel.com>
 <Z6tgNjH6Qq5pe9Gt@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ucjpuma3q55sx3pj"
Content-Disposition: inline
In-Reply-To: <Z6tgNjH6Qq5pe9Gt@smile.fi.intel.com>


--ucjpuma3q55sx3pj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 01/17] spi: add basic support for SPI offloading
MIME-Version: 1.0

Hello Andy,

On Tue, Feb 11, 2025 at 04:35:34PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 11, 2025 at 04:31:45PM +0200, Andy Shevchenko wrote:
> > On Tue, Feb 11, 2025 at 04:29:33PM +0200, Andy Shevchenko wrote:
> > > On Tue, Feb 11, 2025 at 04:20:50PM +0200, Andy Shevchenko wrote:
> > > > On Tue, Feb 11, 2025 at 01:00:08PM +0000, Mark Brown wrote:
> > > > > On Mon, Feb 10, 2025 at 10:33:31PM +0200, Andy Shevchenko wrote:
> > > > > > On Mon, Feb 10, 2025 at 05:48:00PM +0000, Mark Brown wrote:
> > > > > > > On Mon, Feb 10, 2025 at 11:11:23AM -0600, David Lechner wrote:
> > > > >=20
> > > > > > > > In this case, we specifically split up the headers so that =
the only time you
> > > > > > > > would ever include this header is if you need to call funct=
ions in this
> > > > > > > > namespace (i.e. struct definitions are in linux/spi/offload=
/types.h which
> > > > > > > > doesn't import the namespace). So this doesn't actually see=
m like a problem
> > > > > > > > to me.
> > > > >=20
> > > > > > > Indeed - I can't see any case where a user would need the hea=
der without
> > > > > > > needing the namespace.
> > > > >=20
> > > > > > You are looking from the other end. What I'm telling is that an=
yone who adds
> > > > > > a header, automatically gets a namespace. What's the point to h=
ave namespace
> > > > > > if it won't easily prevent from (ab)using it in the code. I con=
sider putting
> > > > > > MODULE_IMPORT_NS() in the headers a bit weird.

There was a similar discussion some time ago about the lpss pwm driver
(https://lore.kernel.org/linux-pwm/Z09YJGifvpENYNPy@smile.fi.intel.com/).
The arguments that you didn't accept back then already are similar to
the ones that were brought forward here.
The TL;DR; is: Adding MODULE_IMPORT_NS() to a header makes it easier for
code to use the exported symbols. Yes, that includes abusers of the
code.

But if you mostly care about the regular users of an API/ABI, making
things easy for those is the thing that matters. Agreed, if you think
that module namespaces are primarily a line of defence against abusers,
adding the import to the header weakens that defence (a bit). However a
typical header includes function prototypes and macros. Those also make
it easier for abusers. With your argumentation we better don't create
headers at all?

There are other benefits of module namespaces like reducing the set of
globally available symbols which speeds up module loading or the
ability to see in the module meta data that a namespace is used.

> > > > > Sure, but there's no case where anyone should ever be adding the =
header
> > > > > without adding the namespace which does rather sound like the sor=
t of
> > > > > thing where you should just move the namespace addition to the he=
ader.
> > > >=20
> > > > $ git grep -lw MODULE_IMPORT_NS | wc -l
> > > > 651
> > > >=20
> > > > $ git grep -lw MODULE_IMPORT_NS | grep '\.h$'
> > > >=20
> > > > drivers/base/firmware_loader/sysfs.h
> > > > drivers/iio/adc/ltc2497.h
> > > > drivers/pwm/pwm-dwc.h
> > > > ^^^ These ones are probably fine as they are not in include/
> > > >=20
> > > > include/kunit/visibility.h
> > > > include/linux/module.h
> > > > include/linux/pwm.h
> > > >=20
> > > > I believe these three are misuses of MODULE_IMPORT_NS(). Because on=
e may add
> > >=20
> > > _Two_, of course, module.h provides the macro :-)
> >=20
> > And after looking into include/kunit/visibility.h it becomes only a sin=
gle one.
> > So, PWM is abuser of MODULE_IMPORT_NS() and this series added one more.
>=20
> > > > a header just as a "proxy" one (copy'n'paste, for example) and we k=
now that is
> > > > real as we saw a lot of code that has semi-random header inclusion =
blocks.
>=20
> And thinking of more realistic example when we want header and do *not* w=
ant a
> namespace is the simple use of the macro / or data type from it without
> actually relying on the APIs.

The problem of your more realistic example is that it doesn't apply
here. A user of include/linux/pwm.h (or the header under discussion
here) won't only use a macro or two and so not benefit from the imported
module namespace.

Nobody intends to import all possible namespaces in <linux/kernel.h>.

> So, in case of the header structure like
>=20
> foo_constants.h
> foo_types.h
> foo_api.h
> foo_uplevel_something.h
>=20
> The MODULE_IMPORT_NS() would make sense only to foo_api.h. And I still wo=
uld
> question that. As I explained that header may simply become a stale one or
> being used by a mistake.

I have no problem here. If the header becomes stale we will most
probably notice that eventually and remove it. Maybe the unused
namespace even makes it easier to spot that issue.
See
https://lore.kernel.org/r/20250123103939.357160-2-u.kleine-koenig@baylibre.=
com
for an example which I found exactly like that.

Best regards
Uwe

--ucjpuma3q55sx3pj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmermscACgkQj4D7WH0S
/k5cbQf/Y0rEHcrUWPs20/8TMFgwjQKsPeqg/d5NK0O/w4mPi/8Xq4Q2wFLy/5eP
4kASX/32H04Cx5TPsgnJUGED0npOXwGgjTyQCR8GrgV3aWq54cyIIWdFHi5XAI1o
UpcVAZsoDewW8aRaWQocXt2u/AMFdC+CWh39/NIKXtPTxGK9dduIp2Of+Gak7c4v
HfwwPW3HOmkDyQT/fTt/O4fPuvKueHxyDwvpcZbA7WYm7YBvA6Om0uCDma6DkJ5j
VHOgiTQmKRRTOUNYRnAhe6E5oUGqayeTeeQaBOvZ3DUhOXwQ0LqCWbFDJZgkngTL
7V8LC5iUbSV8aRrwtRwlxngUNiUpqQ==
=r6VY
-----END PGP SIGNATURE-----

--ucjpuma3q55sx3pj--

