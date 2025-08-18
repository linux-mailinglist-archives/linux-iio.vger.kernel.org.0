Return-Path: <linux-iio+bounces-22901-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C331AB29A2C
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 08:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27CE917EEFD
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 06:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17FD278157;
	Mon, 18 Aug 2025 06:53:18 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D78214228;
	Mon, 18 Aug 2025 06:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755499998; cv=none; b=T9HQBM3mrpresGNZWK8qzeeJHnLAHIyV4d60ffb8Yb4D3KUS/kcGVgz094YZjxyK9VgrWGsZBbCNdIBgQ8yF5TPgp9wCUFGcQFwbM1TbWBeTj5A9Ud1bJ2412rvGQ0LkjhciR0TONUgaDSseSf/1eKzLok6AUWdnyYe3+p3G8IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755499998; c=relaxed/simple;
	bh=u9pSuqLG11ff8tf01lL8pPWzMjaXryve9DurJw0P8ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKO0jqyWWeoLBVfLukZuKKb1z4gwFAHlYy7+ZCt6o7S9OXdeTnqITujMpZNorlijlJQhwQSuxgkbI94bbjY7jACAv9qH3XPudmI2AlSXdIR2nWy1zl7I7nXwzgSQ+V4lHLxXhcx2LXm3PFWqQQKZQYU2W3w+SJXy9wt+g+ye0eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 18 Aug 2025 02:52:59 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Hepp <andrew.hepp@ahepp.dev>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] dt-bindings: iio: mcp9600: Add microchip,mcp9601
 and add constraints
Message-ID: <2025081802-courageous-chital-ec8896@boujee-and-buff>
Mail-Followup-To: Krzysztof Kozlowski <krzk@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Hepp <andrew.hepp@ahepp.dev>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
References: <20250818035953.35216-1-bcollins@kernel.org>
 <20250818035953.35216-2-bcollins@kernel.org>
 <062512ca-7069-4fc5-bcbf-a076203399f0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uy6n32mymkh4twkm"
Content-Disposition: inline
In-Reply-To: <062512ca-7069-4fc5-bcbf-a076203399f0@kernel.org>
X-Migadu-Flow: FLOW_OUT


--uy6n32mymkh4twkm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 1/5] dt-bindings: iio: mcp9600: Add microchip,mcp9601
 and add constraints
MIME-Version: 1.0

On Mon, Aug 18, 2025 at 08:40:26AM -0500, Krzysztof Kozlowski wrote:
> On 18/08/2025 05:59, Ben Collins wrote:
> > From: Ben Collins <bcollins@watter.com>
> >=20
> > The mcp9600 driver supports the mcp9601 chip, but complains about not
> > recognizing the device id on probe. A separate patch...
> >=20
> > 	iio: mcp9600: Recognize chip id for mcp9601
> >=20
> > ...addresses this. This patch updates the dt-bindings for this chip to
> > reflect the change to allow explicitly setting microchip,mcp9601 as
> > the expected chip type.
> >=20
> > The mcp9601 also supports features not found on the mcp9600, so this
> > will also allow the driver to differentiate the support of these
> > features.
> >=20
> > In addition, the thermocouple-type needs a default of 3 (k-type). The
> > driver doesn't support this, yet. A later patch in this series adds it:
> >=20
> > 	iio: mcp9600: Add support for thermocouple-type
> >=20
> > Lastly, the open/short circuit functionality is dependent on mcp9601
> > chipsset. Add constraints for this and a new property, microchip,vsense,
> > enables this feature since it depends on the chip being wired
> > properly.
> >=20
> > Passed dt_binding_check.
>=20
> Yeah...
>=20
> ...
>=20
>=20
> > -            interrupts =3D <25 IRQ_TYPE_EDGE_RISING>;
> > -            interrupt-names =3D "open-circuit";
> > +            interrupts =3D <25 IRQ_TYPE_EDGE_RISIN>;
>=20
> Except that it wasn't it. You need to test your final code, after you
> commit. Mentioning that you tested it and then actually do not test and
> send something which does not build, heh...

I actually did, and fixed it, but it didn't make it into the commit when
I emailed.

--=20
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

--uy6n32mymkh4twkm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEPsl1mBZylhoRORc6XVpXxyQrIs8FAmiizcsACgkQXVpXxyQr
Is+aUg/+Pnmh/68PO36tHheJkkhHTczGBJku8jji55EIo3CVfLntYiHlM6ZvKy6I
Oepb96oF0TovJZ7uhkHVmk4h+YjEt/qr2nlNcC3UIms+0ak7kB/xZ8iQs+oPGjnh
CXqvnDR1uGVEV+kLcvpqfyxu8ZNyVnWsvUiF1HCEw7AqZz7hmgKaq5foOcCdjrQv
1sMejsC+1dkzGsLNyB3kgGtKUpuoi7eAktP8pN4hTx2CjbVqBbNGfYcKeFH9aAGI
b88Ct5m64fRQbb7uxQLEkN7T/uc6u7hgWUSrCIokJKI+bMeih5FICwUsGRFqAYmr
/OsDQE/wAE7jjut4SNJdE8aeZrzMvUY2xmwUo8N81SCQvn5TkROe3+hiRYuBD83L
X1+iZ+BEvF7xJg9+dZo3EWjvX/g2FOTh0bK1/HXPEn1xBlVSD/qa5LVZC/BlsOYN
qkWmCJIieBO8bB8xRk+Rsrhm6MR2klKQ4gp/5x0EpInLpMM7mghpL1Qv3HQFA/3R
djz7vdNFGAEwZNzFL6bA+kljSjmTLWh4pUZsihjH6tXi6P64I+93aUXAmkaewIlI
NU/XerzP5620+aUXx+To6ZiJjhYCZjasygVis2JVmDBw5+WG0Zxj/3qOKz5w2PDZ
H2KDaeM35IpBWSeb8QdS7C1fNS05pGSOipDVrwYeVuZLSXfun+Q=
=DBi5
-----END PGP SIGNATURE-----

--uy6n32mymkh4twkm--

