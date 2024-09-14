Return-Path: <linux-iio+bounces-9597-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D309793AB
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2024 00:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE741F22222
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 22:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C4B143759;
	Sat, 14 Sep 2024 22:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ba9nx66o"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13C780C13;
	Sat, 14 Sep 2024 22:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726352661; cv=none; b=bYd6YTixyqfYcSlZUjGDWIQnPj4FHDMlblAk8I+PjGW8U8KAH2n9gTs/bdbZTTHE3zC7vgdT25wIzWDWgfI6spqD+/nMMGiFCT1XT+wNsM2u5BI5uEjxfO8pGR230dSKglXKx5m6Uqk0nIVfq8kVtGT95ZvI/a1QBQUdnna9qFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726352661; c=relaxed/simple;
	bh=HGwwPMmqMBSDYeEkYE1BCnI05Mzjva6YsHPY4Xz4v6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r26c7QWum+f4z0T5/RzGZzpVoir/f6vuP6qnrlBXrbKNnfm2BAu/zeZyRW2CY6OgmgQFcKS4L/fAwYJPDeTHbmMHu+irUWBX0rP/mtrTKbh8q3Mjscdkfl+vmheRHNdrchDYLUrkVZPTwuuW4fhXHPcN60xt7b4J6KzfH1n7pEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ba9nx66o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AA0C4CEC0;
	Sat, 14 Sep 2024 22:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726352661;
	bh=HGwwPMmqMBSDYeEkYE1BCnI05Mzjva6YsHPY4Xz4v6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ba9nx66o/8afcKeqfrtVbHtMP+bUFvuxgHOmBnq6H/f3tPUiVg+SR2mzmmSNNO//e
	 vNe9C63lcwQlqUcda6uYl60dXWoFJY2/MuPLepNFmaIQcqLE+KRoHB7fmjtK+t4jy0
	 B1mNP1YrfjZve0/ECAAJTe6TbB+N9r+15zQZLvoHU7NX1T1768ju1BrydoR6r5U9lP
	 ZK1Ikh2wufgf63hN/xlLbI4gz4u/Jdp3kR/8beWex/3CEg2PpkYgEuoaMpkLd1VbPQ
	 j3lUt40DsSX+OCl1sF/q3dGyHGWOp/YaPol8uXxJLLn43zH/80oQagpU+9CbdzkxIR
	 TdMD7n1ADqarg==
Date: Sat, 14 Sep 2024 23:24:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
	biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
	semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v6 2/4] dt-bindings: iio: pressure: bmp085: Add
 interrupts for BMP3xx and BMP5xx devices
Message-ID: <20240914-residence-buckwheat-26f10932ed6e@spud>
References: <20240912233234.45519-1-vassilisamir@gmail.com>
 <20240912233234.45519-3-vassilisamir@gmail.com>
 <20240913-overarch-preplan-c899f16a90c8@spud>
 <20240913235949.GC33362@vamoiridPC>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q/25bUSr4mv0LHTJ"
Content-Disposition: inline
In-Reply-To: <20240913235949.GC33362@vamoiridPC>


--Q/25bUSr4mv0LHTJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 14, 2024 at 01:59:49AM +0200, Vasileios Amoiridis wrote:
> On Fri, Sep 13, 2024 at 07:27:29PM +0100, Conor Dooley wrote:
> > On Fri, Sep 13, 2024 at 01:32:32AM +0200, Vasileios Amoiridis wrote:
> > > Add interrupt options for BMP3xx and BMP5xx devices as well.
> > >=20
> > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > > ---
> > >  .../bindings/iio/pressure/bmp085.yaml         | 22 +++++++++++++++++=
+-
> > >  1 file changed, 21 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.ya=
ml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> > > index 6fda887ee9d4..7c9d85be9008 100644
> > > --- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> > > @@ -48,14 +48,34 @@ properties:
> > > =20
> > >    interrupts:
> > >      description:
> > > -      interrupt mapping for IRQ (BMP085 only)
> > > +      interrupt mapping for IRQ. Supported in BMP085, BMP3xx, BMP5xx
> >=20
> > If you respin, you can drop the description entirely, since you've added
> > proper enforcement below.
> >=20
> > Otherwise,
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Thanks for the time to review this, I will try to see if I can do it
> tonight, thanks!

I think I am "too late" in saying this, but I was not expecting a respin
for this change, but only for the change to be made if you were
respinning for another reason.

Thanks,
Conor.

--Q/25bUSr4mv0LHTJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuYNDwAKCRB4tDGHoIJi
0hTrAP9sc8Ch9eKYZ0ia7n4ZfHFVs1PxbPH2DFfLgGZcvdCZIQEAlHlgHF/EShIU
GwEiMnaqy5+M/tmxsC80BB75PwLPmgQ=
=ipnj
-----END PGP SIGNATURE-----

--Q/25bUSr4mv0LHTJ--

