Return-Path: <linux-iio+bounces-9235-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FB996EEC9
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 11:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557131C23DD7
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 09:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5321C7B8B;
	Fri,  6 Sep 2024 09:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5OBxIfz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C802D1C7B82;
	Fri,  6 Sep 2024 09:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725613479; cv=none; b=E6XGJQc7L+FUVjKgO8G+X9yAj+/hmMBrsJEwZFjN7DCcZotk7al9MBy0R1w8UR2udpYdwt/N3ZEvVZJQgXTUPfCTJmF5QtbtyHgazxadEAbT1H79Q6fpYGYhqQHmgF/H6XNBmw/IlhtYaMgpzLjHaVVyDi7kpI6gDCd7hR6vPgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725613479; c=relaxed/simple;
	bh=Le2oIPvtlq+pLBLTecCbgOVdJnpt21aAFe8k39P1tc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbPSZ5AKJrERYQx2KTdCPj3LFm2fCQ7wJ7xu8xc7I6cnxMAKEfDAQ5N2058M0JHZ28YIl1EqAnoQ4ElqnHcFMOcNnO7RiWJgoTnmsyGVGAUzHYwc78SmT9MesDahq7xnWJ+Heogm0kLDycJjjTCCYWXss0Aa84b5WxaeEgAs+Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5OBxIfz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79EDC4CEC4;
	Fri,  6 Sep 2024 09:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725613479;
	bh=Le2oIPvtlq+pLBLTecCbgOVdJnpt21aAFe8k39P1tc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C5OBxIfz/6c5TB3tGWtwoH+VeiWRNd0r4qJanosGCuY1lv+l3+2TgEob6PtDTt+iw
	 tum4dc2Snsv8jyw2jn2vCSZdK3sMWB1XhdvKFfYvtih1fn4/LifCpHVVfXWYtrV6c6
	 ytOh2jrCekCiQ43UPUtUFLLe0/TSI12YMBpCEqjbUcrRurSUoZUW3br1j3ultELUeg
	 1T1KDMxhOJVxJFkYNSbr7d9Po6hx9jt4T9aNUuDzBDaQH/jYo6ba/LrdfnsPNhTVIX
	 GT51OJAROxTjkBJOEHfVdXEGXrVp6OPE/QUXofVEB/fCSqmAnPdpxvDU+JXUkyQE1O
	 ZGZ7C63A+UuSg==
Date: Fri, 6 Sep 2024 10:04:40 +0100
From: Conor Dooley <conor@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH RFC 4/8] dt-bindings: iio: dac: add adi axi-dac bus
 property
Message-ID: <20240906-venomous-candle-8348b00640ca@squawk>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
 <20240829-wip-bl-ad3552r-axi-v0-v1-4-b6da6015327a@baylibre.com>
 <20240829-stopwatch-morality-a933abb4d688@spud>
 <d4eddc24-9192-4a4a-ac67-4cfbd429a6a9@baylibre.com>
 <20240830-quilt-appointee-4a7947e84988@spud>
 <9015bc26-1a3a-49df-8728-12ceb8993035@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ERt/zHyxT7r5QZIw"
Content-Disposition: inline
In-Reply-To: <9015bc26-1a3a-49df-8728-12ceb8993035@baylibre.com>


--ERt/zHyxT7r5QZIw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 02, 2024 at 11:32:37AM +0200, Angelo Dureghello wrote:
> Hi Conor,
>=20
>=20
> On 30/08/24 5:33 PM, Conor Dooley wrote:
> > On Fri, Aug 30, 2024 at 10:19:49AM +0200, Angelo Dureghello wrote:
> > > Hi Conor,
> > >=20
> > > On 29/08/24 5:46 PM, Conor Dooley wrote:
> > > > On Thu, Aug 29, 2024 at 02:32:02PM +0200, Angelo Dureghello wrote:
> > > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > > >=20
> > > > > Add bus property.
> > > > RFC it may be, but you do need to explain what this bus-type actual=
ly
> > > > describes for commenting on the suitability of the method to be
> > > > meaningful.
> > > thanks for the feedbacks,
> > >=20
> > > a "bus" is intended as a generic interface connected to the target,
> > > may be used from a custom IP (fpga) to communicate with the target
> > > device (by read/write(reg and value)) using a special custom interfac=
e.
> > >=20
> > > The bus could also be physically the same of some well-known existing
> > > interfaces (as parallel, lvds or other uncommon interfaces), but using
> > > an uncommon/custom protocol over it.
> > >=20
> > > In concrete, actually bus-type is added to the backend since the
> > > ad3552r DAC chip can be connected (for maximum speed) by a 5 lanes DDR
> > > parallel bus (interface that i named QSPI, but it's not exactly a QSPI
> > > as a protocol), so it's a device-specific interface.
> > >=20
> > > With additions in this patchset, other frontends, of course not only
> > > DACs, will be able to add specific busses and read/wrtie to the bus
> > > as needed.
> > >=20
> > > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > > > ---
> > > > >    Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml | 9=
 +++++++++
> > > > >    1 file changed, 9 insertions(+)
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-da=
c.yaml b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > > > > index a55e9bfc66d7..a7ce72e1cd81 100644
> > > > > --- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > > > > +++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > > > > @@ -38,6 +38,15 @@ properties:
> > > > >      clocks:
> > > > >        maxItems: 1
> > > > You mentioned about new compatible strings, does the one currently
> > > > listed in this binding support both bus types?
> > You didn't answer this, and there's insufficient explanation of the
> > "hardware" in this RFC, but I found this which is supposedly the
> > backend:
> > https://github.com/analogdevicesinc/hdl/tree/main/library/axi_ad3552r
> > adi,axi-dac.yaml has a single compatible, and that compatible has
> > nothing to do with "axi_ad3552r" as it is "adi,axi-dac-9.1.b". I would
> > expect either justification for reuse of the compatible, or a brand new
> > compatible for this backend, even if the driver can mostly be reused.
> >=20
> > Could you please link to whatever ADI wiki has detailed information on
> > how this stuff works so that I can look at it to better understand the
> > axes of configuration here?
>=20
> https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html
>=20
> that has same structure and register set of the generic ADI AXI-DAC IP:
> https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
>=20
>=20
> > > > Making the bus type decision based on compatible only really makes =
sense
> > > > if they're different versions of the IP, but not if they're differe=
nt
> > > > configuration options for a given version.
> > > >=20
> > > > > +  bus-type:
> > > DAC IP on fpga actually respects same structure and register set, exc=
ept
> > > for a named "custom" register that may use specific bitfields dependi=
ng
> > > on the application of the IP.
> > To paraphrase:
> > "The register map is the same, except for the bit that is different".
> > If ADI is shipping several different configurations of this IP for
> > different DACs, I'd be expecting different compatibles for each backend
> > to be honest
>=20
> i am still quite new to this fpga-based implementations, at least for how
> such IPs are actually interfacing to the linux subsystem, so i may miss
> some point.
>=20
> About the "adi,axi-dac-9.1.b" compatible, the generic DAC IP register set
> is mostly the same structure of this ad3552r IP (links above), except for
> bitfields in the=A0DAC_CUSTOM_CTRL register.
>=20
> My choice for now was to add a bus-type property.
>=20
> Not an HDL expert, but i think a different bus means, from an hardware po=
int
> of
> view, a different IP in terms of internal fpga circuitry, even if not as a
> register-set.

Depending on whether or not the unmodified driver can be used with this
IP (so the QSPI bus stuff would need to be optional) then a fallback
should be used given the degree of similarity. It, however, seems likely
that is not the case, and without the QSPI bus there'd be no way to
communicate with the device. Is there any reason to use this IP as a
backend, without connecting the QSPI bus at all, leaving the ADC/DAC on
a regular SPI bus?

>=20
>=20
> > .
> > If each DAC specific backend was to have a unique compatible, would the
> > type of bus used be determinable from it? Doesn't have to work for all
> > devices from now until the heath death of the universe, but at least for
> > the devices that you're currently aware of?
> >=20
> > > > If, as you mentioned, there are multiple bus types, a non-flag prop=
erty
> > > > does make sense. However, I am really not keen on these "forced" nu=
merical
> > > > properties at all, I'd much rather see strings used here.
> > > > > +    maxItems: 1
> > > > > +    description: |
> > > > > +      Configure bus type:
> > > > > +        - 0: none
> > > > > +        - 1: qspi
> > Also, re-reading the cover letter, it says "this platform driver uses a=
 4
> > lanes parallel bus, plus a clock line, similar to a qspi."
> > I don't think we should call this "qspi" if it is not actually qspi,
> > that's just confusing.
>=20
> Agree, name should be something different.

Nuno's comment appears to disagree, and that is /is/ actually a qspi
controller. Please see my comments to him about parentage.

--ERt/zHyxT7r5QZIw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZtrFpAAKCRB4tDGHoIJi
0g3wAP9s/XejcMpB6KWLTrimG/V79jhB5R7aZ0Bhehsa5VCuvwD/fMyuRfcymdHv
lFTOFyh8Poe07NdTLRgBoj3gFZpd7Qs=
=uDft
-----END PGP SIGNATURE-----

--ERt/zHyxT7r5QZIw--

