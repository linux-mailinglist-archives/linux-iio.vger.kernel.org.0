Return-Path: <linux-iio+bounces-9967-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E2598C420
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 19:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93891C21D02
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 17:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE541CB50B;
	Tue,  1 Oct 2024 17:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aqp3533y"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753D918CC0B;
	Tue,  1 Oct 2024 17:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727802222; cv=none; b=jFYVthO+BT4LG9Sl/41uqFFDbEa6HeDax/wpJSejJNaY8i2fz7p/UxtvRAldJQvcVEH3ld2WR+6lNJ2Ka94FpXUAPu5u2oyK1zIMp4EdlXFilyQ9QSXjzTTvXlwqh4jnfuIOomD1QGD5yddEYRIpzNmnHMCvntR7F7e5godwfeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727802222; c=relaxed/simple;
	bh=hnn5WdFdaL/r/Ov+Ij5CkcGOq9lssl98OITB727oJFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsaRGAXgfBgVqqeVu2qpbs4eR7W8/MLi/w1UMuZ6jwAS4ELlm0MtrFHxFWfDB1U86bNMK7D0Bdf5ksSFnIhJcPQ9QUdemHMrR0b+PUuW26kcF/PxR/ojvTTXFuBC/1BA46JwQccGwHfg+TXXmN0xZCTtdbetkz63bfyf5MFlJwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aqp3533y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE796C4CEC6;
	Tue,  1 Oct 2024 17:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727802222;
	bh=hnn5WdFdaL/r/Ov+Ij5CkcGOq9lssl98OITB727oJFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Aqp3533y5OhntZwtscBg8hUJ9jG+Vmw/EWEYFQdUJ+yx18HL/8pUKwu4YHUKB1vlJ
	 Z/R81OTuQyQGRKR8FZ/6RH/bYQat9tKj0it/xarZnDUf3cz+nCCbKzfzjJIxkXRB8T
	 3fbliccwXCZ6Ii9YYTDaVsJ+RkCTvMcgPiIE/MFJuWgolkG/f0iJszdLcoa8gZsXfB
	 NS85shgLxvST6SkWIw2MogAvWtm5cBS/6j+fI9XlTrWLW7ZojPujL86E1hxhqmZwHH
	 aBIEsnGHzTVe5d623RGRD8aC71zvx/yr6SlyZR4JKAu46xlwwl2xdMup6v7KZ6dfHY
	 uoVw5RnrxzCtg==
Date: Tue, 1 Oct 2024 18:03:37 +0100
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
Message-ID: <20241001-gruffly-cruelness-b8aed444c36e@spud>
References: <20241001074618.350785-1-herve.codina@bootlin.com>
 <20241001074618.350785-3-herve.codina@bootlin.com>
 <20241001-corrode-preteen-546c98d45976@spud>
 <20241001184602.7912c10d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9/5yh5OItDzzKctE"
Content-Disposition: inline
In-Reply-To: <20241001184602.7912c10d@bootlin.com>


--9/5yh5OItDzzKctE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2024 at 06:46:02PM +0200, Herve Codina wrote:
> On Tue, 1 Oct 2024 17:18:30 +0100
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Tue, Oct 01, 2024 at 09:46:16AM +0200, Herve Codina wrote:
> > > The GE HealthCare PMC Analog to Digital Converter (ADC) is a 16-Chann=
el
> > > (voltage and current), 16-Bit ADC with an I2C Interface.
> > >=20
> > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > > ---
> > >  .../bindings/iio/adc/gehc,pmc-adc.yaml        | 82 +++++++++++++++++=
++
> > >  include/dt-bindings/iio/adc/gehc,pmc-adc.h    | 10 +++
> ...
> > > +  clocks:
> > > +    maxItems: 1
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: osc =20
> >=20
> > Since there's no datasheet for me to look up, why is the clock optional?
>=20
> The component uses an external oscillator (osc) if an external oscillator=
 is
> connected to its clock pins. Otherwise, it uses an internal reference clo=
ck.

Could you please add a description of the clock with this statement,
given there's no datasheet or w/e linked here?

--9/5yh5OItDzzKctE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvwraQAKCRB4tDGHoIJi
0jiEAQCIFKW6x2+sDK+BFhwbrK0gODnmXjzYu44uTi5oDyy90AD/VTOCvsw73qU0
Z3x1CBC+A/ZBuPg+6t0fnQQ2cdUeigc=
=iE84
-----END PGP SIGNATURE-----

--9/5yh5OItDzzKctE--

