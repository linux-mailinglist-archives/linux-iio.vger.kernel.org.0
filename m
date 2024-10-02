Return-Path: <linux-iio+bounces-10008-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7983898DE0A
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 16:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E71228414A
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 14:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2481D0B93;
	Wed,  2 Oct 2024 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+Aruj1H"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDFB1EA80;
	Wed,  2 Oct 2024 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880836; cv=none; b=TN6c8mX1cXoCoRC6QqqHyesAduFMYRnb+c7RkooTHlLvjMYBuyxnF8oCtx8DzGIrmKxEKBvqI06QInxYRbOm4TVpRbabNS4a8oNvZDLWwgrI7atBWtF+b69/r5yZD6FHxXSsm5VBWohm/D+YDEAfXYsWM1UjvHILa7j5PsykOgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880836; c=relaxed/simple;
	bh=zOrO15nPsDNtmS7WaLdFBXVhXqwv2yitdNorrs4Lc00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSjne94ShpbDUO57mq1o6Hpm7fXatNivJqvcaQ8sS3BFwdZiFovwGLkD+MxM8tkjLe4Txmp1oTATth9UqQobem9O97yHAKrTi85W0iHA7mrZTnK0TbgV02P3Df7fDROT7o/Knb+nJZqMQztjupjd4op3ViQI+uBulF02A/HKGUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+Aruj1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC203C4CECD;
	Wed,  2 Oct 2024 14:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727880836;
	bh=zOrO15nPsDNtmS7WaLdFBXVhXqwv2yitdNorrs4Lc00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U+Aruj1HX54XsERA6G4lHVm0y0j6uu34Gmcb3tjgTlGghtpMBjpeH5hFfKtjseNwo
	 0DrJj8WNgIi/Vb6G8SpxH0oGL+Jt+SqGel4k4j+zOVbGlRgRjZUvvh0I1zYfBj6EOY
	 nPgLZJE50vZVpJ52yoMDYhdhaC8oW5AxF7oZxuE+bzTn50OB4EsD8wAwLUyxG1fcAA
	 09m/qcXz/gDOQpbJ0wDAtHySG7fENzJ1keIBA6TWgb1Yggs+1S5mYlVCjrOiyFY72S
	 fdRYzBeUelJPZ3VpnAMxLIayywdTd+ynL55kGFchK/vjbwAChpFbDmyd0YJ7DgALpr
	 R6frGPcWWNI0A==
Date: Wed, 2 Oct 2024 15:53:51 +0100
From: Conor Dooley <conor@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Ian Ray <ian.ray@gehealthcare.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/4] dt-bindings: iio: adc: Add the GE HealthCare PMC ADC
Message-ID: <20241002-doorstop-given-0987c28090ed@spud>
References: <20241001074618.350785-1-herve.codina@bootlin.com>
 <20241001074618.350785-3-herve.codina@bootlin.com>
 <20241001-corrode-preteen-546c98d45976@spud>
 <20241001184602.7912c10d@bootlin.com>
 <20241001-gruffly-cruelness-b8aed444c36e@spud>
 <20241002090453.0849b668@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2QdSbbXRzGQcgwo5"
Content-Disposition: inline
In-Reply-To: <20241002090453.0849b668@bootlin.com>


--2QdSbbXRzGQcgwo5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2024 at 09:04:53AM +0200, Herve Codina wrote:
> Hi Conor,
>=20
> On Tue, 1 Oct 2024 18:03:37 +0100
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Tue, Oct 01, 2024 at 06:46:02PM +0200, Herve Codina wrote:
> > > On Tue, 1 Oct 2024 17:18:30 +0100
> > > Conor Dooley <conor@kernel.org> wrote:
> > >  =20
> > > > On Tue, Oct 01, 2024 at 09:46:16AM +0200, Herve Codina wrote: =20
> > > > > The GE HealthCare PMC Analog to Digital Converter (ADC) is a 16-C=
hannel
> > > > > (voltage and current), 16-Bit ADC with an I2C Interface.
> > > > >=20
> > > > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > > > > ---
> > > > >  .../bindings/iio/adc/gehc,pmc-adc.yaml        | 82 +++++++++++++=
++++++
> > > > >  include/dt-bindings/iio/adc/gehc,pmc-adc.h    | 10 +++ =20
> > > ... =20
> > > > > +  clocks:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  clock-names:
> > > > > +    items:
> > > > > +      - const: osc   =20
> > > >=20
> > > > Since there's no datasheet for me to look up, why is the clock opti=
onal? =20
> > >=20
> > > The component uses an external oscillator (osc) if an external oscill=
ator is
> > > connected to its clock pins. Otherwise, it uses an internal reference=
 clock. =20
> >=20
> > Could you please add a description of the clock with this statement,
> > given there's no datasheet or w/e linked here?
>=20
> Sure, I will add a description in the next iteration.
>=20
> There is no datasheet or any similar document available for this componen=
t.
> This is reason why I cannot add a link to this kind of dos.

Yeah, I had taken a look last night and couldn't find one, so I figured
that this was the case.

--2QdSbbXRzGQcgwo5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZv1eawAKCRB4tDGHoIJi
0jCRAQCPb7iI1ukVK9/aZyxiYlyQZeIg5oY3W+eyU84zXDwxtwEAl+KLvPQkPwut
+6h4c6YDavBZk/d+1+H73Ch6wdMvkgA=
=Pt72
-----END PGP SIGNATURE-----

--2QdSbbXRzGQcgwo5--

