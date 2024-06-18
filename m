Return-Path: <linux-iio+bounces-6527-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0FE90DAB6
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 19:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77425283294
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 17:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34CE14A636;
	Tue, 18 Jun 2024 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PW/TGhSb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9629B143876;
	Tue, 18 Jun 2024 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718731946; cv=none; b=YxfT6KpdlEwqEb3/sFfLA/hIYshF0SQDwsANMSsBezzGxCi10Gdu/MKI6eyv69ftxOvUCwVPNL6HgDx7u1rlq6/YovIc0ygDwuZGC8Qp9R69vY6S8mA/owWbMTOf0lZLY49jft8cna7FggyFXbZLfXU+rGx7n83NTgxz99ZUsTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718731946; c=relaxed/simple;
	bh=moYpzgOv86jL7O4pe/gOny+AWerIhWKLnhzue3FlQqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHQAtqtBDNgr2EHWKgb3iEmDGxI1zEo2I3ARtDUsWSa08yzNLTzRosd+Iz6i6bMiPh4H6Q/6J0FEXa4D1s3DnNW9UIBVpAN/rs09fFIOXeod/uWSkQnogvLryGTnZX5FOkV22LOs7zKp4czOAAj06aOMURHcRwIutoCnI7Lcj04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PW/TGhSb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFC9C4AF1C;
	Tue, 18 Jun 2024 17:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718731946;
	bh=moYpzgOv86jL7O4pe/gOny+AWerIhWKLnhzue3FlQqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PW/TGhSb8n59f4qO3mFtFphe/RhTTsjEKGlLZ8H1XwBm1VGWAbM/h8Kk+KeQGMKMS
	 sbdqBoMnthy5NGkxgyI2XgHJF3UpgR20d5KgeO6/DkJpPtM4gdp6TMjuvWluESdOmR
	 4Q8bI5rfSIoYNWo5Ilt+4lO6jA8MZEUgevp1pFAIQB7Y0VSBxeHRsEtByJKrbUxnWV
	 L3CrfYhvi3Dzp9jlw8GOFYObmz+B4ZQ1i/j1nu0807Gb8aCnvNwpwRy64Tqqek+d5C
	 jkhqvpvSGDYvkY4PkzunGxhvv+4MJs846GhPYxez95ktwaDMt/AS9PmgFIaiOlLXHm
	 STyUtWbS0lvEQ==
Date: Tue, 18 Jun 2024 18:32:20 +0100
From: Conor Dooley <conor@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Beniamin Bia <beniamin.bia@analog.com>,
	Stefan Popa <stefan.popa@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	jstephan@baylibre.com, dlechner@baylibre.com
Subject: Re: [PATCH 4/9] dt-bindings: iio: adc: adi,ad7606: add supply
 properties
Message-ID: <20240618-spearfish-swear-213166c7224f@spud>
References: <20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com>
 <20240618-cleanup-ad7606-v1-4-f1854d5c779d@baylibre.com>
 <20240618-eggnog-cusp-8b5a17313367@spud>
 <12e5c4b4-e51d-4e69-8c63-3f6aefb574d9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="A638O3OKT34HUQsZ"
Content-Disposition: inline
In-Reply-To: <12e5c4b4-e51d-4e69-8c63-3f6aefb574d9@baylibre.com>


--A638O3OKT34HUQsZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 05:33:16PM +0200, Guillaume Stols wrote:
>=20
> On 6/18/24 17:12, Conor Dooley wrote:
> > On Tue, Jun 18, 2024 at 02:02:36PM +0000, Guillaume Stols wrote:
> > > Add voltage supplies
> > Are these available on all devices?
>=20
> Yes all chips from=A0 AD7606 series (including AD7606B, AD7606C(-16,-18),
> AD7605-4, AD7606 (-4,-8,-6), AD7607, AD7608, AD7609), as well as AD7616
> have a VDrive pin, as well as a RefSelect + RefIn/RefOut pin that takes
> an input voltage in case RefSelect is high, or outputs the internal
> reference voltage if RefSelect is low.

Okay,
Acked-by: Conor Dooley <conor.dooley@microchip.com>
provided that...

>=20
> >=20
> > > Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> > > ---
> > >   Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 9 +++++=
++++
> > >   1 file changed, 9 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yam=
l b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> > > index 80866940123c..e480c9a7c7ca 100644
> > > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> > > @@ -35,6 +35,15 @@ properties:
> > >     avcc-supply: true
> > > +  vdrive-supply:

The lack of a blank line here is an artifact of the reply

> > > +    description:
> > > +      Determines the voltage level at which the interface logic pins=
 will
> > > +      operate.
> > > +
> > > +  refin-supply:
> > > +    description:
> > > +      The voltage supply for optional external reference voltage.
> > > +
> > >     interrupts:
> > >       description:
> > >         The BUSY pin falling edge indicates that the conversion is ov=
er, and thus
> > >=20
> > > --=20
> > > 2.34.1
> > >=20

--A638O3OKT34HUQsZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnHEpAAKCRB4tDGHoIJi
0rziAQDPS/km2fEpMhBkBlqyzyviUjxt6FLMjHF/egx/Oh52SQD/XDwK89t4bBn5
Cym3bpe9cK0h3A0QTSXy3b8kVdjieQY=
=Q6k9
-----END PGP SIGNATURE-----

--A638O3OKT34HUQsZ--

