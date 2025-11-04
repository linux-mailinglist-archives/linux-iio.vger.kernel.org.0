Return-Path: <linux-iio+bounces-25893-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9D6C32601
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 18:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B61E188A269
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 17:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D281D33A02D;
	Tue,  4 Nov 2025 17:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laFqB7+/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8191E32D0F6;
	Tue,  4 Nov 2025 17:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277828; cv=none; b=jhYxb57wKJrPLyW/ZFqv1sq4e5Gp632mR8v3Ps8ZlCZ1WPWN8mQFrzCYuUJc+RfNq2f/Z4sZoeWjxKZl99Rdbxp4HAj3XCaSMJcSH1/9AH6bpg6bSSmFDFYeOYhrbqCjzolnX8uDklw7CEa5MeCkFZCp7gP5pvjLKizX/Rqxc5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277828; c=relaxed/simple;
	bh=EwYoHCVdLQynM3Er3DB1bUxVXUHIRBiZ9S5eBVcQTPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyjBHsAowbPfuITIDtagpyamNnOUzCnVd1g2DxTexp23+L1suoKvmulO063FTMjK33IEQ+2IZUM5o6loAIDEr2mrykK5josc2jR/WWT1cU9ybscyugVuTH67zF+8r+HQity0upaP7tSkuRUbehHu7u8PhPyYU1iaoYGQUVQCX4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laFqB7+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0537C4CEF8;
	Tue,  4 Nov 2025 17:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762277828;
	bh=EwYoHCVdLQynM3Er3DB1bUxVXUHIRBiZ9S5eBVcQTPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=laFqB7+/VvNWPUenn91cowiXpQmY3lDvHixx/SsFxok9gYj2f576iSkdBnWj+8drv
	 MdR3cxPsF7Dwtu90PVrrMtaKNTdxEuWChNDVRJEG6LWpW7twPCFTBNNRQWuvxHn2+9
	 rG3K5qRlwX8TBSri2O9YS3k0gSFx36G/mLSSCgdFCN7uCKMoPYnbQ/DLIFVWCNKqJ0
	 BCKrkoxxxamjbLlwokzJz10Ld+SDCd8P52Upw0frWGJIWGWIDboWgaho6h1S1dFkZz
	 rvi9s2KDIirNfypis3TZBDCQf+jUNYcjHFSU9sy9vM4mxpfpv+F1FWYNb0GzKuacjr
	 /WsgvOKdFaUVA==
Date: Tue, 4 Nov 2025 17:37:04 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, robh@kernel.org,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: amplifiers: add adl8113
Message-ID: <20251104-ongoing-impotent-d6acbb44cb8b@spud>
References: <20251031160405.13286-1-antoniu.miclaus@analog.com>
 <20251031160405.13286-2-antoniu.miclaus@analog.com>
 <20251102105653.09941b27@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Hu8xN2ibT+TVvVwm"
Content-Disposition: inline
In-Reply-To: <20251102105653.09941b27@jic23-huawei>


--Hu8xN2ibT+TVvVwm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 02, 2025 at 10:57:11AM +0000, Jonathan Cameron wrote:
> On Fri, 31 Oct 2025 16:04:03 +0000
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
>=20
> > Add devicetree bindings for adl8113.
> >=20
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> >  .../bindings/iio/amplifiers/adi,adl8113.yaml  | 76 +++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/ad=
i,adl8113.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,adl81=
13.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
> > new file mode 100644
> > index 000000000000..4cc21c93233c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
> > @@ -0,0 +1,76 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/amplifiers/adi,adl8113.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices ADL8113 Low Noise Amplifier with integrated bypa=
ss switches
> > +
> > +maintainers:
> > +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> > +
> > +description: |
> > +  The ADL8113 is a 10MHz to 12GHz Low Noise Amplifier with integrated =
bypass
> > +  switches controlled by two GPIO pins (VA and VB). The device support=
s four
> > +  operation modes:
> > +    - Internal Amplifier: VA=3D0, VB=3D0 - Signal passes through the i=
nternal LNA
> > +    - Internal Bypass: VA=3D1, VB=3D1 - Signal bypasses through intern=
al path
> > +    - External Bypass A: VA=3D0, VB=3D1 - Signal routes through extern=
al bypass path A
> > +    - External Bypass B: VA=3D1, VB=3D0 - Signal routes through extern=
al bypass path B
>=20
> These two external paths are a problem for description because there coul=
d be
> literally anything between those OUT_A and IN_A etc.  To be useful it mig=
ht be necessary
> to describe that circuitry.=20
>=20
> > +
> > +    https://www.analog.com/en/products/adl8113.html
> > +
> > +properties:
> > +  compatible:
> > +    const: adi,adl8113
> > +
> > +  vdd1-supply: true
> > +
> > +  vdd2-supply: true
> > +
> > +  vss2-supply: true
> > +
> > +  va-gpios:
> > +    description:
> > +      GPIO connected to the VA control pin. Must be specified as GPIO_=
ACTIVE_HIGH.
> > +    maxItems: 1
> > +
> > +  vb-gpios:
> > +    description:
> > +      GPIO connected to the VB control pin. Must be specified as GPIO_=
ACTIVE_HIGH.
> > +    maxItems: 1
> > +
> > +  adi,initial-mode:
> > +    description: |
> > +      Initial operation mode after device initialization
> > +        0 - Internal Amplifier (default)
> > +        1 - Internal Bypass
> > +        2 - External Bypass A
> > +        3 - External Bypass B
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1, 2, 3]
> > +    default: 0
>=20
> Given this only takes affect when the driver loads anyway, why have
> an initial mode in DT?

And if it is to be kept, I would like the modes to become strings, not
"random" integers. Although, as you say, feels like something software
could just control

--Hu8xN2ibT+TVvVwm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQo5wAAKCRB4tDGHoIJi
0o0FAQDw1gJB3mHV/0jYAUyQByq1KAbDoWouNO0BJdYSb0I0+gEAuhl3Vjk4oykd
8Nx7HHNHElE4ZTGgguSEr1+4w4fxGQc=
=Ec9F
-----END PGP SIGNATURE-----

--Hu8xN2ibT+TVvVwm--

