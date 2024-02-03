Return-Path: <linux-iio+bounces-2112-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A43E4848562
	for <lists+linux-iio@lfdr.de>; Sat,  3 Feb 2024 12:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7A3E1C215F3
	for <lists+linux-iio@lfdr.de>; Sat,  3 Feb 2024 11:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095465D737;
	Sat,  3 Feb 2024 11:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0n7obS9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B030C4F610;
	Sat,  3 Feb 2024 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706961589; cv=none; b=pcZB96OHyf5IhbCQeqe7WOJ4fn9pxsbODqmlAb2cIQhP4kaOfKARdJh9eT6b/ZlQoAb6kfJbR2eeqxguuwUFPMtx0AvD3wHqjZ57w5Dlew99Bdq9GsE7KzsFJZRUgy0PZXv28bCvExhnEdTgRr7x829kbzpe7tNxbr/DZ9+h5ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706961589; c=relaxed/simple;
	bh=OxA6S6WclVuoMy1OROr9Sblvm8p6FUS0Tg9+lExPXrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaQ5mEDR5klWEQI8AO00sVYxZVIjmqJJ4KHYY4nNadD/FFKUWxB0MlmsBc9NN0IVMZMesr/JtJMOe93XKlvatIp7JUa4kcdRrD0vJ6M1ApMHo3+u8bOHBciv/vrd/cD4acJ60QfCyNZ8tuO3A71OwxN/zElCbpzt4Q2hZdSCqXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0n7obS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C038EC433C7;
	Sat,  3 Feb 2024 11:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706961589;
	bh=OxA6S6WclVuoMy1OROr9Sblvm8p6FUS0Tg9+lExPXrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N0n7obS9dPo1pGEHApNT1Bi8RyUCHYf8phRlwW9nuwnoS77i6kod4SOMsHPBoMSVm
	 C6AiLFPsRN2hEqJYIIdqwZN+PSDbYQLPXbafWXzbutfoG5MaP9ePnu58jlMBYY/yW8
	 lUDXGTZ8+qBBlaPybbK4KREm/fUQaxj/CJpHAkdljGFlkX3CIfUNKzBsaqjW7pa4EI
	 ka7hh9C2p8K6sD4/6lVn+ovDoePEU4nrLVvL+IT5MR5KLpfz5sVF7hm9iEoftWhdiV
	 VQloa1LxyoxHZMTZiptvJA3m34ubKeR+uxGc/dKSEUGttl46J6X9OAwg+maAFIoG3L
	 2RKQR3OaDQZAw==
Date: Sat, 3 Feb 2024 12:59:45 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v3 3/3] dt-bindings: iio: imu: st_lsm6dsx: add
 asm330lhhxg1
Message-ID: <Zb4qsbvz-BREqayL@lore-desk>
References: <cover.1706692153.git.lorenzo@kernel.org>
 <93160585e69e4531a981064817ccbb143a6a1f70.1706692153.git.lorenzo@kernel.org>
 <20240202194308.GA806128-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z17nX3BzMYKP3zxm"
Content-Disposition: inline
In-Reply-To: <20240202194308.GA806128-robh@kernel.org>


--z17nX3BzMYKP3zxm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Jan 31, 2024 at 10:11:31AM +0100, Lorenzo Bianconi wrote:
> > Add device bindings for asm330lhhxg1 IMU sensor.
> > The asm330lhhx supports a subset of the features and functionality
> > provided by the lsm6dsr via identical interfaces and so is a
> > suitable fallback compatible.
>=20
> A subset cannot fallback to a superset.
>=20
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml =
b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > index 28b667a9cb76..316601b2da7a 100644
> > --- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > +++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > @@ -49,6 +49,9 @@ properties:
> >        - items:
> >            - const: st,asm330lhb
> >            - const: st,asm330lhh
> > +      - items:
> > +          - const: st,asm330lhhxg1
> > +          - const: st,lsm6dsr
>=20
> Assuming this is correct and the commit msg is wrong, can't this be=20
> added to the existing entry?:
>=20
> items:
>   - enum:
>       - st,asm330lhhx
>       - st,asm330lhhxg1
>   - const: st,lsm6dsr

ack, I will fix it in v4.

Regards,
Lorenzo

>=20
>=20
> > =20
> >    reg:
> >      maxItems: 1
> > --=20
> > 2.43.0
> >=20

--z17nX3BzMYKP3zxm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZb4qsQAKCRA6cBh0uS2t
rASsAQDkEexTPcDxOuQlX0hEXx5rWCsJW+oafotbi3lS9tFGigD/XkeUGrWuiuuj
5Pz8pvhhEzf7IrZdUe+oG/hVOCJ/wQY=
=2PAe
-----END PGP SIGNATURE-----

--z17nX3BzMYKP3zxm--

