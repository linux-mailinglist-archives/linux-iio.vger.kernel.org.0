Return-Path: <linux-iio+bounces-15350-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9294BA31449
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 19:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4138616731F
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 18:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B050253B5D;
	Tue, 11 Feb 2025 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z38cMeTI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B5F26158B;
	Tue, 11 Feb 2025 18:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739299491; cv=none; b=rgVq4wB53HwIMFAueZCE3J0rWpE8tXhHYpmY8tQfu0goxDamrde2p2K4l1B8f3/A79p39v5FJ6NUOiFQqcHpaYq7z065QK/bscEkZkFghzVugZy51NCg5FFahVO/CnaOE3Sg5YFJDLrCBc2ksUM4ZsVEVTyvq18MuveyN91K1Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739299491; c=relaxed/simple;
	bh=ghRP+gbuDImmJVKfK6iB47GOeRo/vdl5Vcb10WIKFQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5qg1kPLXi40MF37vmtyg34itDDVSllnIVkLua1MBCJOFxaUKvf+++jQHDCftObYuvWdJgIja+PSamT3fa+LU3pTB3icE0ZSUQVHFNSZ06ok4lJ4OyKvds6wh5RhUal0navaNjcbv7Ro08/IlsP7A/JWyYjv7UGVUDiAkK6ml24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z38cMeTI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32128C4CEDD;
	Tue, 11 Feb 2025 18:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739299490;
	bh=ghRP+gbuDImmJVKfK6iB47GOeRo/vdl5Vcb10WIKFQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z38cMeTIrsRh5tu+xqU2wkig5A7UiGan1ekOmWhmPUsiFDONHpIrL8wkko8rcztF/
	 qLkFw5NqoH4FfQvINlZc7mF6MUx4PyVLsrRrzGnziSglK9FRgqW2iav61WHcGdqETF
	 McEYisAtrC9xaGTRYAG0Htt6JPP9D7ZDwhV0zlGEOK/qYz/9JhT40FEtu31Ghfl8Se
	 HSTaJzIgoh8758KSVNgX0Nuc1xqxbkarsUzS1RRASPDXjOrFlUpZERpwZmCl2FHjYt
	 fVXA+uxCfgTLTGb3AZhcEaUFhsOn+FfikIYWSuERqCd29EFZzqZMDbPjQQeiLSL1+l
	 48f1mnJiAl2Xg==
Date: Tue, 11 Feb 2025 18:44:46 +0000
From: Conor Dooley <conor@kernel.org>
To: Hermes Zhang <chenhuiz@axis.com>
Cc: Hermes Zhang <Hermes.Zhang@axis.com>, jic23@kernel.org, robh@kernel.org,
	lars@metafoo.de, krzk+dt@kernel.org,
	Conor Dooley <conor+dt@kernel.org>, kernel@axis.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: chemical: sensirion,senxx: Add
 yaml description
Message-ID: <20250211-whiff-handsfree-a21486cf67c7@spud>
References: <20250206061521.2546108-1-Hermes.Zhang@axis.com>
 <20250206061521.2546108-3-Hermes.Zhang@axis.com>
 <20250206-italics-reproduce-35d554c38751@spud>
 <21dd4902-7d24-6d1a-1144-2dfd7cabe9e2@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="phNxZwqCbmj0chLs"
Content-Disposition: inline
In-Reply-To: <21dd4902-7d24-6d1a-1144-2dfd7cabe9e2@axis.com>


--phNxZwqCbmj0chLs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 08, 2025 at 03:07:08PM +0800, Hermes Zhang wrote:
> Hi,
>=20
> On 2025/2/7 2:20, Conor Dooley wrote:
> > diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,s=
enxx.yaml b/Documentation/devicetree/bindings/iio/chemical/sensirion,senxx.=
yaml
> > new file mode 100644
> > index 000000000000..4d998eabe441
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,senxx.ya=
ml
> > filename matching a compatible please.
> So sensirion,sen66.yaml?
> > +  https://sensirion.com/media/documents/6791EFA0/62A1F68F/Sensirion_Da=
tasheet_Environmental_Node_SEN5x.pdf
> > +  https://sensirion.com/media/documents/FAFC548D/6731FFFA/Sensirion_Da=
tasheet_SEN6x.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - sensirion,sen50
> > +      - sensirion,sen54
> > +      - sensirion,sen55
> > +      - sensirion,sen60
> > +      - sensirion,sen65
> > +      - sensirion,sen66
> > I'd like a note in the commit message as to how all of these devices are
> > different please.
> Sure, will fix in v2.
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > No supplies needed for this device? Seems like you would need at least
> > one, no?
>=20
> You mean the vdd-supply? The chip require a e.g. 3.3v VDD, but in our HW,=
 we
> have no gpio/regulator to control it, connect directly by the HW, should I
> still need to have one vdd-supply here?

Might not be controllable in your case, but if the device needs power
=66rom somewhere it should have one in the binding.

--phNxZwqCbmj0chLs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ6uangAKCRB4tDGHoIJi
0v+LAQDUHgR6IiHcxmIJj3tANEKTn/Kdnt0M3QU7xolt80zJ0AEA8P4k1xW4qYIm
1PfYq9yqfP2LSUqg4Q2S4XiTG8/klQ8=
=FNxR
-----END PGP SIGNATURE-----

--phNxZwqCbmj0chLs--

