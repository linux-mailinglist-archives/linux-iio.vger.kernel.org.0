Return-Path: <linux-iio+bounces-24341-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36874B8E88C
	for <lists+linux-iio@lfdr.de>; Mon, 22 Sep 2025 00:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D834E3B2C4B
	for <lists+linux-iio@lfdr.de>; Sun, 21 Sep 2025 22:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1799C25A642;
	Sun, 21 Sep 2025 22:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klkS5BiK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ABF245005;
	Sun, 21 Sep 2025 22:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758493207; cv=none; b=WFrjYfmcEVm21toD7uZf31l5EddlrSG5ZLNS0RKI5+iCiZsVTQfueaaE5Ta5QpsZfmcHdesFVbWQjJI+lgo/FGCtj4KswC8GZq1U3tVCebJny2ltESehaOJC21NhhRFQ9bdUuCjdlEFGj6qH4y2xlkbPbi/OTrvsvNxvV61dIoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758493207; c=relaxed/simple;
	bh=ohrGSsoJD2pXLw3dHvbPso3wSwhHsr1KLrjzFnujEyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JK4Ai/pr+sB3GWD9pxJMSDVfYfdPyS4voencULoTwJfBx2LZjBPFzS+xOVQnlcVpjbRhXxFwv4MYAh3y43kJPQlbzuhtd+llwxvHR9MRdzhRZH9IomEe/v3FRtaVER7EDjVk/9ii4G8bgIVnBfDzjNACZF74AvN4yvWZUyEK4AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klkS5BiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190E5C4CEE7;
	Sun, 21 Sep 2025 22:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758493207;
	bh=ohrGSsoJD2pXLw3dHvbPso3wSwhHsr1KLrjzFnujEyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=klkS5BiKXKehUPAXHeNrKpPJlS/IB4rQx1BTBWBONOiRMFFI1Vm0f4YzHVejMpcUt
	 4/WnwO3dLNHFn9lzlnfrdfhu8zoJxi/Y+6NnAGazIG264d7hpcwE3A10A34FnuIbsI
	 hzpKmiLv49J6iuelBxgFI/9JVHjPMtUmgIfvKYUgbnJP1txRQb01+L51sSUoxrp9s3
	 4BQwfUGFyYSedhEItnb5RMVRrxTQXxk7KQelzCKJGg2lhCf6SxPGFv8xotL8R4nUmp
	 xSdYilPcaQIykVRjtl/0fYETGqz15Sa1psHYzbf38ftcLjoPt8oH0Uvmz2dbrOswoJ
	 dlKflNlBdaVNg==
Date: Sun, 21 Sep 2025 23:20:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net
Subject: Re: [PATCH v2 7/8] dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216
 and ADAQ4224
Message-ID: <20250921-unadvised-uninjured-cdd7a6e6f326@spud>
References: <cover.1758214628.git.marcelo.schmitt@analog.com>
 <2d6bca62056e1254f91b45f70f4ba4614e659c1c.1758214628.git.marcelo.schmitt@analog.com>
 <20250919-unsure-mounted-0fc49ce72216@spud>
 <aM3HJY0GWJmP8-do@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hSQNaCplevA2/Gki"
Content-Disposition: inline
In-Reply-To: <aM3HJY0GWJmP8-do@debian-BULLSEYE-live-builder-AMD64>


--hSQNaCplevA2/Gki
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 06:12:05PM -0300, Marcelo Schmitt wrote:
> On 09/19, Conor Dooley wrote:
> > On Thu, Sep 18, 2025 at 02:39:29PM -0300, Marcelo Schmitt wrote:
> > > ADAQ4216 and ADAQ4224 are similar to AD4030 except that ADAQ devices =
have a
> > > PGA (programmable gain amplifier) that scales the input signal prior =
to it
> > > reaching the ADC inputs. The PGA is controlled through a couple of pi=
ns (A0
> > > and A1) that set one of four possible signal gain configurations.
> > >=20
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > ---
> > > Change log v1 -> v2
> > > - Use pattern to specify devices that require gain related properties.
> > > - Disallow gain related properties for devices that don't come with e=
mbedded PGA.
> > > - Documented VDDH and VDD_FDA supplies for ADAQ4216 and ADAQ4224.
> > > - Updated PGA gain constants.
> > >=20
> > >  .../bindings/iio/adc/adi,ad4030.yaml          | 65 +++++++++++++++++=
--
> > >  1 file changed, 60 insertions(+), 5 deletions(-)
> > >=20
> ...
> > > =20
> > > +  pga-gpios:
> > > +    description:
> > > +      A0 and A1 pins for gain selection. For devices that have PGA c=
onfiguration
> > > +      input pins, pga-gpios should be defined if adi,gain-milli is a=
bsent.
> > > +    minItems: 2
> > > +    maxItems: 2
> > > +
> > > +  adi,pga-value:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> >=20
> > How come this is "value" rather than "gain"?
>=20
> Because, for this one, I drew inspiration from ad7191 bindings [1] in the=
 hopes
> of avoiding creating new properties or using discontinued/deprecated
> nomenclature [2].
>=20
> The thing is, we now have ADC chips coming with PGA circuitry in front of=
 ADC
> inputs. Those PGAs are usually set/configured through hardware connections
> (e.g. dedicated GPIOs or pin-strapped) and have been described in dt-bind=
ings.
> Though, since these added PGAs don't follow a pattern with respect to the
> provided gain, different properties began to appear. ad7380 and ad4000 use
> adi,gain-milli to describe PGA gain [3, 4], ad7191 uses adi,pga-value and,
> more recently, adaq7768-1 has been proposed with adi,aaf-gain-bp [5].
> adaq7768-1 is arguably a slightly different case since the signal gain st=
ems
> from an anti-aliasing filter, but it nevertheless results in signal atten=
uation
> much like some PGAs.
>=20
> I personally like the -milli (or even -permille) nomenclature because 4 d=
igits
> have been more than enough to describe the gains (at least so far). Thoug=
h, I
> acknowledge the base points suffix (-bp) which is documented in
> property-units.yaml [6]. The only thing I don't like much about -bp for
> describing PGA gain is that PGA gains are often described in terms of uni=
tless
> scale factors, while bp implies the value to be described as a percent.
>=20
> Anyways, whatever property name is chosen, it will probably be better set=
tle to
> something rather than arguing about property names each time a new ADC co=
mes
> with an integrated PGA.

If PGA gains are common, then ye it would make sense to have a standard
property. I guess one of the problems with doing so is that there isn't
a standard/common binding for adcs themselves, so without making one
it'd involve reviewers pushing people to the standard one. I suppose the
current adc.yaml could be made into adc-channel.yaml and adc.yaml
repurposed. I bet there are more properties than just PGA gain that
could go there.

My personal objection to "pga-value" is that it doesn't communicate by
itself what aspect of the pga it actually controls. I don't really care
what "unit" qualifier is used that much or if one is used at all. That's
more of a thing for yourself and other IIO developers to handle.

Part of me is bothered though that all these gains are not in dB! But
I'd imagine there are not really any ADCs where the registers don't
deal in unitless gain and using dB would be nothing more than an
additional headache for software developers.

> [1] Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml
> [2] https://lore.kernel.org/linux-iio/510f6efb-ada3-4848-ac8e-16fa5d1b528=
4@kernel.org/
> [3] Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> [4] Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> [5] https://lore.kernel.org/linux-iio/46842d4cf2c1149bd64188f94c60ce5e4f3=
b2beb.1757001160.git.Jonathan.Santos@analog.com/
> [6] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schema=
s/property-units.yaml
>=20
> >=20
> > > +    description: |
> > > +      Should be present if PGA control inputs are pin-strapped. The =
values
> > > +      specify the gain per mille. For example, 333 means the input s=
ignal is
> > > +      scaled by a 0.333 factor (i.e. attenuated to one third of it's=
 original
> > > +      magnitude). Possible values:
> > > +      Gain 333 (A1=3D0, A0=3D0)
> > > +      Gain 555 (A1=3D0, A0=3D1)
> > > +      Gain 2222 (A1=3D1, A0=3D0)
> > > +      Gain 6666 (A1=3D1, A0=3D1)
> > > +      If defined, pga-gpios must be absent.
> > > +    enum: [333, 555, 2222, 6666]
> > > +
>=20
> Thanks,
> Marcelo

--hSQNaCplevA2/Gki
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNB6EQAKCRB4tDGHoIJi
0ilzAQD2Iqg4901qxI3yFrx6NIi8tPC9QjJO/FSlcqncYqajAAEAqXP3Wvz61V3F
20RIlKmMYE8C2BfOaHUS1GlFKGmwAQc=
=IipO
-----END PGP SIGNATURE-----

--hSQNaCplevA2/Gki--

