Return-Path: <linux-iio+bounces-24641-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C486BB1851
	for <lists+linux-iio@lfdr.de>; Wed, 01 Oct 2025 20:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3233B327E
	for <lists+linux-iio@lfdr.de>; Wed,  1 Oct 2025 18:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547A32D5A01;
	Wed,  1 Oct 2025 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKaR9bBz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A235253F03;
	Wed,  1 Oct 2025 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759344027; cv=none; b=QnCQDNEvMplZOVsYUaG0AFHHZiX9LC5FMyOKdg+cltpOGEqZQbAxnKA1GqmhZdTCpEAsJAGVIRTG8vgmlGMOG6kx+GeMM2huEtmwRprpjDOSx6qj5D4Glfh4atjoAJjZOnIjsCnahad2IhxY8agrAGLz48yoN3UfjBrs9cONgII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759344027; c=relaxed/simple;
	bh=Zvia04J9o7jWgxHG1OQx00r4MlbA4yAGZGqEcbUw7mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqynXcZE4C0WqWpmrxzPzC+cg40hQGMmHA+/T17IX3uBmA+Ihw2DobruI2OA3V6gPadQIK3c6nyO2FKc/zk9z81Y3Tl0PGSVAyatQZT+Xx40jvF9j67PmqPVUqn0VSHNbjUH6Qw0Dh32I3kCWMFU5vJI2Us5whV5tJfLwbeO124=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKaR9bBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFAAC4CEF1;
	Wed,  1 Oct 2025 18:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759344026;
	bh=Zvia04J9o7jWgxHG1OQx00r4MlbA4yAGZGqEcbUw7mE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PKaR9bBzMerwiLC0K1jOIDU1nypit4mR2Jiso5nk7bcAlUfRJoZvfUKC3yqyW8ZS+
	 HiSFGR2A2SXiohlwbSuAeuuquzVXBhBVxl77AXt+UN4bsJuVL1dCXs6cmUE2n2txBH
	 XwZvTORr+66vmwprYD2lmzYT1x/xRMArAHzXj7gaEHUH49XCCZCWdHtXUTCrH1RjmP
	 VmedGQiJXbPVCnPOLVbuU/QLKAQX1IgJjZE2bEymJVzHTk7h5xRIOOA8uGW6jrlq5W
	 F8XAaWpMgA63Ni8iKBTheBIv6AsNACVxf67w2PPIfkaekH6xFhc3cSmxTvBck7PeZR
	 pqUg6ial7WtcQ==
Date: Wed, 1 Oct 2025 19:40:21 +0100
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Romain Gantois <romain.gantois@bootlin.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/5] regulator: dt-bindings: Add Linear Technology
 LTM8054 regulator
Message-ID: <20251001-glacial-synthetic-6faa84d6d047@spud>
References: <20250925-ltm8054-driver-v2-0-bb61a401a0dc@bootlin.com>
 <5331035.LvFx2qVVIh@fw-rgant>
 <20250927-spoon-yearning-c1a8df796173@spud>
 <5926760.DvuYhMxLoT@fw-rgant>
 <CAMknhBGOpODxmzU9J9nqGDKGzn6KKFV5Ed3okLvecKtHhNRB9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="awo5i5GvxHVK+9Fg"
Content-Disposition: inline
In-Reply-To: <CAMknhBGOpODxmzU9J9nqGDKGzn6KKFV5Ed3okLvecKtHhNRB9A@mail.gmail.com>


--awo5i5GvxHVK+9Fg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2025 at 01:18:51PM +0200, David Lechner wrote:
> On Wed, Oct 1, 2025 at 9:12=E2=80=AFAM Romain Gantois
> <romain.gantois@bootlin.com> wrote:
> >
> > On Sunday, 28 September 2025 00:31:05 CEST Conor Dooley wrote:
> > ...
> > > > >
> > > > > > +  lltc,fb-voltage-divider:
> > > > > Why does this property have a ?linear? vendor prefix?
> > > > > Shouldn't it be adi to match the other property and compatible?
> > > >
> > > > This component was originally from Linear Technology, before it was
> > > > acquired by Analog Devices. The new properties and compatibles have=
 the
> > > > Analog Devices prefix, but the "fb-voltage-divider" property is alr=
eady
> > > > used by the LTC3676 and LTC3589 regulators, so I left the Linear
> > > > Technology prefix for this one to avoid introducing a new property =
just
> > > > to specify a vendor prefix change.
> > > >
> > > > I don't have a strong opinion about this though.
> > >
> > > Do they share the same driver?
> >
> > They do not. However, they use it in the exact same way, and I would've
> > liked to factor out the handling of this property in a future patch. Th=
is
> > would also make it easier to handle other types of feedback pin circuits
> > and have a generic binding for "regulators using a feedback pin connect=
ed
> > to some kind of analog circuit".
> >
> > For example:
> >
> > Vout----+
> >         |
> >         |
> >        +++
> >        | |
> >        | | Rtop
> >        | |
> >        +++
> >         |
> >         |
> >  FB ----+
> >         |
> >      +--+--+
> >      |  |  |
> >      |  |  |CCS
> >      +--v--+
> >         |
> >         |
> >        -+-
> >         -
> >
> > This is all speculation at this point though, so I don't mind changing =
the
> > property to "adi,fb-voltage-divider" and handling the different compati=
bles
> > when it comes to it.
> >
>=20
> Could we just make it `fb-voltage-divider-ohms`? The -ohms suffix
> makes it match the standard property-units suffix which already has
> the uint32-array type. There are a couple of bindings that have
> `vout-voltage-divider` without a vendor prefix, so it sounds like this
> pattern is considered somewhat of a standard property already. But I
> think it would be better with the -ohms suffix. For example, there is
> already `gw,voltage-divider-ohms` as well. But there are so many
> similar properties without the suffix, it is kind of the defacto
> standard already, so might be better to stick with that rather than
> making it even more different variants than there already are.

Ye, by all means standardise it. I suppose that means insertion into
regulator.yaml, which usually also means a regulator- prefix - unless
you're eyeing something wider than that?

--awo5i5GvxHVK+9Fg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaN11lQAKCRB4tDGHoIJi
0tYpAP9FY+HpyoPKgEW68hevYOBRqe7TxW8twZPmPJyCHwP9wwEAoZTLPs9Tbt7J
dAt9TII1TqGXkk23tg08ARjPQaCVIQU=
=Wv5y
-----END PGP SIGNATURE-----

--awo5i5GvxHVK+9Fg--

