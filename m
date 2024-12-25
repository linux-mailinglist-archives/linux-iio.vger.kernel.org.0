Return-Path: <linux-iio+bounces-13793-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFD39FC5C8
	for <lists+linux-iio@lfdr.de>; Wed, 25 Dec 2024 15:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B6AB18838AC
	for <lists+linux-iio@lfdr.de>; Wed, 25 Dec 2024 14:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7871B87D6;
	Wed, 25 Dec 2024 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFqfFsll"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DFC1804E;
	Wed, 25 Dec 2024 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735136507; cv=none; b=MgnR4L5DWBS6SiSiPO0KHKcyxcRlbRiA/ERy3sT8/MUFZ5vLDpyXnUh9gJiqPKPmOjFvqICev5+NlPcnU6M+iYGMP6rgT0cAprBNgcu/ZfDWuNdI6t09eCDk4nUD/JzQjoc0MtqgLoS4PJ8SAXI3Xwuhibuo2oFCSRMum8cQXQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735136507; c=relaxed/simple;
	bh=qCcmI3q+0S9tj51fossMewftYTjNeMxg7jHEAyyPOaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZIatz9qvEpYYX7at4r27l8TfFDfJhhtdeIglWur4r1y9+LJaJ9lzJCNofSvfaNeYurlhs17ww2yh7n6b0Yt7sT+pkiS2M0HXuKtLHzhvtHquIYg//Gs6DJC0As1d1fj7V+8k9wXQKLnsOOwjbJb+iRxbU9ZaGr6+dZAcUSFrso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFqfFsll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1465DC4CECD;
	Wed, 25 Dec 2024 14:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735136507;
	bh=qCcmI3q+0S9tj51fossMewftYTjNeMxg7jHEAyyPOaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nFqfFsllaYKqkh8+d8RC14bDgj0D7/2fYmdeGpQsXSq4BO5S2ZwFWVeXEeAWMoa6M
	 5rkBOmdgkje4R1g64MTylnxZXPm8z1XSMnbH6P3qqDfdVsJO5ckP6/4y9cb3tcLMby
	 WqgP4gh//ERjAR+y9PtZcQAbFrt7ywvdRJi6tEzcjqtSUP0U34UmgyZmdbeWhb8cME
	 MNzbWt/8hXJ9ppefpzuLh3ciwjG4AzK2lS5BpPHJZ7r6BqYyzQ2AbwMGDpBzDEHk0a
	 hGoVN8D5LYpcNl0VHUM1hd4bBI1yl+6k5ldTGFG4Cdo635OJE/2PmX3OFZ1IUbRl8M
	 pwapyqaK9MtIg==
Date: Wed, 25 Dec 2024 14:21:42 +0000
From: Conor Dooley <conor@kernel.org>
To: Alex Lanzano <lanzano.alex@gmail.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, jagathjog1996@gmail.com, trabarni@gmail.com,
	danila@jiaxyga.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] dt-bindings: iio: imu: bmi270: add boolean type
 for drive-open-drain
Message-ID: <20241225-spew-cosmos-12da85771c8c@spud>
References: <20241219234745.58723-1-vassilisamir@gmail.com>
 <20241219234745.58723-3-vassilisamir@gmail.com>
 <uqn4jpowzqhchthn3i2fpg7j52c7y67gawg5ausrt5j3cemq52@c3l54jktq2wv>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/NfoEx/EiMkQPMdd"
Content-Disposition: inline
In-Reply-To: <uqn4jpowzqhchthn3i2fpg7j52c7y67gawg5ausrt5j3cemq52@c3l54jktq2wv>


--/NfoEx/EiMkQPMdd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 23, 2024 at 02:50:53PM -0500, Alex Lanzano wrote:
> On Fri, Dec 20, 2024 at 12:47:44AM +0100, Vasileios Amoiridis wrote:
> > Add missing type description "boolean" for the drive-open-drain propert=
y.
> >=20
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yam=
l b/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
> > index 7b0cde1c9b0a..860a6c1fea3c 100644
> > --- a/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
> > +++ b/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
> > @@ -41,6 +41,7 @@ properties:
> >          - INT2
> > =20
> >    drive-open-drain:
> > +    type: boolean
> >      description:
> >        set if the specified interrupt pins should be configured as
> >        open drain. If not set, defaults to push-pull.
>=20
> Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>

What do you mean with this tag? A sign-off means you're part of the
chain of custody of the patch, but you're neither author nor submitter.
Did you mean Reviewed-by or Acked-by?

--/NfoEx/EiMkQPMdd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ2wU9gAKCRB4tDGHoIJi
0pKFAP9WuwpTxb++QRcbLJHn7u1vQCwOsSAe7Sx2w4Jr3WMtyQEAwH6NgHS4nSE8
t7RlNO9w3PrDr7BVtWGFaCje6lgwbwA=
=0CkZ
-----END PGP SIGNATURE-----

--/NfoEx/EiMkQPMdd--

