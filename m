Return-Path: <linux-iio+bounces-2915-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A86D860023
	for <lists+linux-iio@lfdr.de>; Thu, 22 Feb 2024 18:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2871C2355F
	for <lists+linux-iio@lfdr.de>; Thu, 22 Feb 2024 17:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A05156962;
	Thu, 22 Feb 2024 17:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uyum0d1U"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F33F154BE3;
	Thu, 22 Feb 2024 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624473; cv=none; b=FkDlF6tqKk2HtpRhf3VsgRAcpKUZX8WGZYZQNbk8Fl6KYz7PF7cCFAO45DeiAme8zxYbtwz+xszaC0GSfsFNE6K3JGoNHnffqxYgpGgKeC1IUzyV7MNXjik/5kQ3yakfOApqdDvmY+17dOwbUmBoSRRxRfeUU+uLkMq+A6oiYEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624473; c=relaxed/simple;
	bh=IY1ePbLAyPh7qCMtDQVfjh9zA9mYaliEiYn0nbCobz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8wot0MLrsfAtcP2ySNkznH4dAR1R4xO9LUUuzWcjDHXpC8Ml9/Wd0a2NKCEA817CmHV6H+wlnepoGWSiQtxKxasQZK9CGM/pOU4cLO8ds0h+WHvG0Hvqn7nV5EAxuBUcUob+S1hyxBTv0UQJFheT5cTGOUlE+dkR7drwkztb60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uyum0d1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9186C433F1;
	Thu, 22 Feb 2024 17:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708624472;
	bh=IY1ePbLAyPh7qCMtDQVfjh9zA9mYaliEiYn0nbCobz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uyum0d1UsBa+HVz7gGlNIwgpHmzHPV6iJ0xVbNsuOanZMV4SXDhofdf0E26BZlmy6
	 BZsBWWZOBFn2CDuqGS1XzU3iCeDCdDsWuDeKWl/W28AqUax0++fGVFSt2YD6rl5x1y
	 1KAY+ui16OQSUmzTbB/lV0EFAIDNnRsUo2bVWAk6T94z0KQ5hltzAcLVkWwI1WbwNt
	 0i45uF7eSytSBdK/paWRMBIguhuFGjtBepE74oDbWxn1dxlm0whbxucbmHnPZPMcwH
	 Y6H98442+Fb825YZwSY3ZZtcKQEwNk+FB+JYAdkfcQXLTeglhtAY3d7OJAtzxd70/T
	 ikCVmSC5aIQMQ==
Date: Thu, 22 Feb 2024 17:54:28 +0000
From: Conor Dooley <conor@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 5/6] dt-bindings: iio: temperature: ltc2983: document
 power supply
Message-ID: <20240222-lance-sprinkled-04a7650ca316@spud>
References: <20240222-ltc2983-misc-improv-v1-0-cf7d4457e98c@analog.com>
 <20240222-ltc2983-misc-improv-v1-5-cf7d4457e98c@analog.com>
 <20240222-component-stiffen-d046386433b3@spud>
 <f31abc7140dfa8477623d4fca8abece03d37926e.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="X4sZeGhzNO6ZrYPs"
Content-Disposition: inline
In-Reply-To: <f31abc7140dfa8477623d4fca8abece03d37926e.camel@gmail.com>


--X4sZeGhzNO6ZrYPs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 05:41:03PM +0100, Nuno S=E1 wrote:
> On Thu, 2024-02-22 at 15:40 +0000, Conor Dooley wrote:
> > On Thu, Feb 22, 2024 at 01:55:56PM +0100, Nuno Sa wrote:
> > > Add a property for the VDD power supply regulator.
> > >=20
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > ---
> > > =A0Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml=
 | 2 ++
> > > =A01 file changed, 2 insertions(+)
> > >=20
> > > diff --git
> > > a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> > > b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> > > index dbb85135fd66..8aae867a770a 100644
> > > --- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.y=
aml
> > > +++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.y=
aml
> > > @@ -57,6 +57,8 @@ properties:
> > > =A0=A0 interrupts:
> > > =A0=A0=A0=A0 maxItems: 1
> > > =A0
> > > +=A0 vdd-supply: true
> >=20
> > Although technically an ABI break, should we make this supply required?
> > It is, at the end of the day, required by the hardware for operation.
> >=20
>=20
> I thought about it but then realized it could break some existing users w=
hich is
> never a nice thing.

Could you explain what scenario it actually breaks a system (not
produces warnings with dtbs_check)?

If anything actually broke something, it would be the driver change that
actually assumed that the regulator was present and refused to probe
otherwise, right? In Linux at least, the regulator core will provide a
dummy regulator if one doesn't exist - otherwise patch 6/6 would
actually contain a DT ABI breakage, since it does:

	ret =3D devm_regulator_get_enable(&spi->dev, "vdd");
	if (ret)
		return ret;

IMO making a new property required is only a meaningful break of the ABI
when drivers reject probe when it is missing, but I must admit I don't
know if other operating systems handle missing regulators as nicely as
Linux does.

> I recently (in another series - the IIO backend) went through some troubl=
e to
> actually not break ABI. Meaning, I had to do some not so neat hacking in =
the
> driver because Rob was more comfortable with not breaking ABI in DT. So, I
> assumed he would not like for me to break it in here.


--X4sZeGhzNO6ZrYPs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdeKVAAKCRB4tDGHoIJi
0pdYAQCmfw0Pf378aK2iFdC1BlE5wzRJlZkxDKeAZHPXMw6e5AD+O/O6a7y+ok8N
6juyCLp/ZHhKv5jwLJBYtorw7SEd5Qs=
=Dqii
-----END PGP SIGNATURE-----

--X4sZeGhzNO6ZrYPs--

