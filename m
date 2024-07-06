Return-Path: <linux-iio+bounces-7387-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 787C79293A0
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 14:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB907B21D2F
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 12:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05176BFC0;
	Sat,  6 Jul 2024 12:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoLWMmPc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C5217FE;
	Sat,  6 Jul 2024 12:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720269756; cv=none; b=V5XZq3abQEU8PXhLUibQUW9QYAtcJwTxYLEjJcb3YMo0g1qLJfZkw5Oa+Fz6EbmGfDUBTj7MhXjg2WOVJssoVL3xVbeMcTRR2dlb5A/XqSSCiHSCWZvkvVWeinvP+XY2SyJqDjurFjHFTUUicxvlW8y39IvoPS0VgzlGm9tOXf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720269756; c=relaxed/simple;
	bh=5ENXDBMXjmBF8k+3fFYXj93fQplVf1tf/1nvD0CaQKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oI1aeUR3SEPBv3Gkucm/HRKGhJfuQdnKTx0UvBL+EeSZiP5mQ5fwWbCB3AuOCvV1VcN8+DJm6mWtxv7glpWVrWI4mXVdA3X7yUjPnYvhGppGMQ846DN2JaZNi+a+Mhco+HJvRiZQNJUf7Qp0PA1tbv1fUH5fCMHvSpDVNGEHOx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoLWMmPc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3FBC2BD10;
	Sat,  6 Jul 2024 12:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720269755;
	bh=5ENXDBMXjmBF8k+3fFYXj93fQplVf1tf/1nvD0CaQKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BoLWMmPcnjpFf8esl6hgCqhPDj5PqyEsrTzO55nalHLxCPaeZFXfSVSj8yK67wH/G
	 3uODPanPgVwiAtGQEoikDTOqQji5SZij2Gqua89zyBIrKL24W0Lx0CFjy7vA6QFEeW
	 XYXW+44HhK5U2uvLj/xKpWbusoyYvc6iJaJWFaYrK+++2prj4yjkQzn3r+j5cbIZ/d
	 1dEM+qzGBLuOO7Sugn19QX/u2trEToCEYrjbE7aWXH/VJer7XCW0FZo5WznS6z/EPb
	 2cXYpb+NzaMqvz+H/j7e05o+vM2PrgJofxT0vj/ifXDQA1fklOXROxaOt/4yKBiQlr
	 rOcyUtJWVtpZQ==
Date: Sat, 6 Jul 2024 13:42:30 +0100
From: Conor Dooley <conor@kernel.org>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: adc: sophgo,cv18xx-saradc.yaml:
 Add Sophgo SARADC binding documentation
Message-ID: <20240706-remote-undergo-3b9dfe44d16f@spud>
References: <20240705-sg2002-adc-v2-0-83428c20a9b2@bootlin.com>
 <20240705-sg2002-adc-v2-1-83428c20a9b2@bootlin.com>
 <20240705-unaired-pesticide-4135eaa04212@spud>
 <6b5459fd-2873-4c26-b986-882413b8d95b@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aooyyyTiQwVeE6tX"
Content-Disposition: inline
In-Reply-To: <6b5459fd-2873-4c26-b986-882413b8d95b@bootlin.com>


--aooyyyTiQwVeE6tX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2024 at 05:24:19PM +0200, Thomas Bonnefille wrote:
>=20
>=20
> On 7/5/24 5:01 PM, Conor Dooley wrote:
> > On Fri, Jul 05, 2024 at 03:42:23PM +0200, Thomas Bonnefille wrote:
> > > The Sophgo SARADC is a Successive Approximation ADC that can be found=
 in
> > > the Sophgo SoC.
> > >=20
> > > Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> > > ---
> > >   .../bindings/iio/adc/sophgo,cv18xx-saradc.yaml     | 63 +++++++++++=
+++++++++++
> > >   1 file changed, 63 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-=
saradc.yaml b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-sarad=
c.yaml
> > > new file mode 100644
> > > index 000000000000..31bd8ac6dfa5
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.=
yaml
> > > @@ -0,0 +1,63 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/adc/sophgo,cv18xx-saradc.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title:
> > > +  Sophgo CV18XX SoC series 3 channels Successive Approximation Analo=
g to
> > > +  Digital Converters
> > > +
> > > +maintainers:
> > > +  - Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> > > +
> > > +description:
> > > +  Datasheet at https://github.com/sophgo/sophgo-doc/releases
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - items:
> > > +          - enum:
> > > +              - sophgo,cv1800b-saradc
> > > +          - const: sophgo,cv18xx-saradc
> >=20
> > I don't think the fallback here makes sense. If there's other devices
> > with a compatible programming model added later, we can fall back to the
> > cv1800b.
> >=20
>=20
> Ok I'll do that, I wasn't sure if it was a good practice to fallback on
> another SoC specific compatible.
>=20
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    description:
> > > +      SARADC will use the presence of this clock to determine if the=
 controller
> > > +      needs to be explicitly clocked by it (Active domain) or if it =
is part of
> > > +      the No-Die Domain, along with the RTC, which does not require =
explicit
> > > +      clocking.
> >=20
> > What does "explicit clocking" mean? Is it clocked directly (or via
> > dividers) by a clock on the board or another source?
> >=20
>=20
> It means that, if a clock is provided, the driver will work in "Active
> Domain" and will use the clock generator of the SoC to get the right clock
> signal.
>=20
> However if no clock is provided, the controller will work in "No-Die" dom=
ain
> (Always On) and use the RTCSYS subsystem to get its clock signal.

So it does have a clock, but provided by a different provider. I don't
really understand why that would "excuse" it from having a clocks
property, with the RTCSYS as the provider.

>=20
> Indeed "explicitly clocked" may not be the right word to describe that,
> maybe some thing like that is better :
>=20
> "SARADC will use the presence of this clock to determine if the controller
> needs to use the clock generator to get its clock signal (Active domain) =
or
> if it is part of the No-Die Domain, along with the RTC, and does not requ=
ire
> the clock generator."



--aooyyyTiQwVeE6tX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZok7sgAKCRB4tDGHoIJi
0lbpAQDwZEbhHg3rnEogG8hOoesPmLsMyjpyNzblwX9hRpY4cAEAhWAWi099oKNO
nEQMmNkQKNvn/HlxM66JXbe1kmIIMAQ=
=RK8u
-----END PGP SIGNATURE-----

--aooyyyTiQwVeE6tX--

