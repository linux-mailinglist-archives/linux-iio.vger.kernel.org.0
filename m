Return-Path: <linux-iio+bounces-12698-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2259D9D27
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 19:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A603CB223BF
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 18:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2AA1DD543;
	Tue, 26 Nov 2024 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFnY6pgS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D655C11187;
	Tue, 26 Nov 2024 18:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732644755; cv=none; b=n6qKhM/9E6xJXuqKC9xGBl7fBXKkjzziz1ScBFAjnWvlxSPGX1myPxFRs5CjftMHdYLT0sri0+IvPVM6ecBT+OEGNv71luI5HJD8900ZklXgZp7rfJFC7l3nDGgkf5rcBauzVRCs7i8NGP4RFP70gsaRFc739H7XE7Kb6L+3uFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732644755; c=relaxed/simple;
	bh=JpFz0akJMPNHum+sk0nTfJd76Mo2Hn9b+Le2jMIwLko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4Fmj1z8Bgm4wOrkoOcFRq5ghDiu2sYo375iMTc7YVINzR1PFS7DCAvMgeSDpC+kJe3HJmEkksBewwM2ZMEjkgAB8OjXXAudnAzWgQw8LVV5a1AyE7wiqJ54fhM0t3VX5z/d21g9oGY3p4EKFYd0dqeqRo0rZz/UzDWxGqZJ4Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFnY6pgS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96788C4CECF;
	Tue, 26 Nov 2024 18:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732644754;
	bh=JpFz0akJMPNHum+sk0nTfJd76Mo2Hn9b+Le2jMIwLko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YFnY6pgSUcJClHffVaQg1C0FaOeog58eqj37DHSrJBrnNYrBVqi5fkErlh5avzuA0
	 +ZS6hmzWcQ4i1IvhJTmnpeN1iSX/8cQquSnMj6nyb4OI60XusHiJ4/Wirruyp+obPW
	 tPRQYrNbxL53BOqIBJ1e+L77DYCyr9Gs0elrlweMQQn3wRq8VMyQOdNtq667+/HP+M
	 Embx/xJQnznlpb9ne391nh+c80e7HyJLJiaETuXO7G8ddvmsZYKs15WthzbXTO1UuR
	 jN+sT/oFoR3C3EWTVrUZwASpLSpyuHU1xkCLhbGTpCl+6F3NhfF0S5BJ8iB4CEJBb5
	 UnPxKXOfDibIw==
Date: Tue, 26 Nov 2024 18:12:29 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, jstephan@baylibre.com,
	aardelean@baylibre.com, adureghello@baylibre.com
Subject: Re: [PATCH 2/9] dt-bindings: iio: dac: adi-axi-adc: Add ad7606
 variant
Message-ID: <20241126-tiptoeing-humiliate-8c88f185942f@spud>
References: <20241121-ad7606_add_iio_backend_software_mode-v1-0-8a693a5e3fa9@baylibre.com>
 <20241121-ad7606_add_iio_backend_software_mode-v1-2-8a693a5e3fa9@baylibre.com>
 <49bc9ec4-f252-4903-b5be-1d35ee8d48be@baylibre.com>
 <20241121-wackiness-threaten-b53d2a27fbd9@spud>
 <20241126175931.4645dbe3@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mtIRv2w5CtHuPvfM"
Content-Disposition: inline
In-Reply-To: <20241126175931.4645dbe3@jic23-huawei>


--mtIRv2w5CtHuPvfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 05:59:31PM +0000, Jonathan Cameron wrote:
> On Thu, 21 Nov 2024 19:53:53 +0000
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Thu, Nov 21, 2024 at 10:57:44AM -0600, David Lechner wrote:
> > > On 11/21/24 4:18 AM, Guillaume Stols wrote: =20
> > > > A new compatible is added to reflect the specialized version of the=
 HDL
> > > > that is not covered by the IIO backend paradigm: We use the paralle=
l =20
> > >=20
> > > It still is being used as an IIO backend, so I would leave out the
> > > phrase "that is not covered by the IIO backend paradigm".
> > >  =20
> > > > interface to write the ADC's registers, and accessing this interface
> > > > requires to use ADI_AXI_REG_CONFIG_RD,ADI_AXI_REG_CONFIG_WR and
> > > > ADI_AXI_REG_CONFIG_CTRL in a custom fashion.
> > > >=20
> > > > Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 7 +++=
++++
> > > >  1 file changed, 7 insertions(+)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.=
yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> > > > index e1f450b80db2..43bc0440c678 100644
> > > > --- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> > > > @@ -17,13 +17,20 @@ description: |
> > > >    interface for the actual ADC, while this IP core will interface
> > > >    to the data-lines of the ADC and handle the streaming of data in=
to
> > > >    memory via DMA.
> > > > +  In some cases, the AXI ADC interface is used to perform speciali=
zed
> > > > +  operation to a particular ADC, e.g access the physical bus throu=
gh
> > > > +  some special register to write ADC registers.
> > > > +  In this case, a different compatible is used, and the driver beh=
aves =20
> > >=20
> > > Quick, delete the word "driver" before Krzysztof sees it. :-p =20
> >=20
> > And also perhaps worth mentioning under the --- line that the x in the
> > compatible is not a wildcard, for similar reasons ;)
>=20
> Well it is, just one that is used for the IP naming to cover all
> the different ADCs it works with.

In "our" terms, when talking about bindings, is not a wildcard.
As you say below, the x refers to a specific IP that works with several
different ADCs, rather than attempting to use a single compatible for
multiple different IPs.

> "The AXI AD7606x IP core can be used to interface the AD7606B, AD7606C-16,
> AD7606C-18, AD7605-4, AD7606, AD7606-6, AD7606-4, AD7607, AD7608 and AD76=
09 devices using an FPGA."
>=20
> Given that's what ADI calls the IP though we are stuck with it - however
> 'wrong' they may be :)
>=20
> But agreed, something to call out to keep me away from the x as well!
>=20
> Jonathan
>=20

--mtIRv2w5CtHuPvfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0YPjQAKCRB4tDGHoIJi
0o0mAP9eMQn+s7a+nwThGQcGXUZk3MxtSyhd97ETN+/FCdpAnwD/TjydttMpZlx7
H0cHGADUZ/iWOgOCSL15f0/lAuASKQE=
=+O5v
-----END PGP SIGNATURE-----

--mtIRv2w5CtHuPvfM--

