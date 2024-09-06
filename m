Return-Path: <linux-iio+bounces-9233-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8252296EE8E
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 10:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5AB1C214E2
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 08:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2745D158D94;
	Fri,  6 Sep 2024 08:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uO525Ib8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D193F5FB9C;
	Fri,  6 Sep 2024 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725612632; cv=none; b=grcSTsFjUamdOj4JAQCsEnLTgcDo0ujy4KvkTIuRp2d7BisZoZpcS7rulejcjEoVHdkl2F4yRbvib+PnbHOhmGI2XrLTQcvyUHJ7Pdgw/8CZtDVSdb/O92ETZeHXsSm2xBCYOV+qpi0sUo9fTykopcXKmigcRs/tGmjNl5V/kJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725612632; c=relaxed/simple;
	bh=JWXFx5VRbW/KBM3lxo8DVgjO4VJXvSno2pfwGYCkMd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOv41SmOXAGyt8VNUbWOU9EcnLqan4Vhxumw0ea5AWPIUbeU4w/+2rq7M3wNWPSjvmA6RONe1vmeT/1Rd5Obs8sajQ0A3m6EUPoNeykxYN2y/4zTBOoncPoQsmaRjeITKcDcXEc9B6i+b5kfR6ViEtfjet8ANG0NW7khYvUjETc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uO525Ib8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2DBAC4CEC9;
	Fri,  6 Sep 2024 08:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725612630;
	bh=JWXFx5VRbW/KBM3lxo8DVgjO4VJXvSno2pfwGYCkMd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uO525Ib8IMoHfHxsBhj++TX+af61kmAVuWf8SO8/2uVdcbOAkgRayp7ylG7/Abz2f
	 hlMCaRBJcU/YoBPzKp8mkWkZCFFd7KP08r/hCXGmOyERELE6mBSRMm3xuzWQ4EY3de
	 hkDVkhO8g2A9YKJXNNxABn1J6fVGDBlo7dW0UBMix4dWZRKyaixXzkSYVlg7dIy28y
	 +LtiJJbOsL7Bb4mxxiwaTRCYdwmeZSKJSJE4ZGKiBkxUwVux3Ri67FSF410SRumo9S
	 jkwMTbse24sO9f3NoYfuIGLvZKYSjq8g7sAkl2ug6YN7YI0UDJKbSLbcs0/rsbUIZ6
	 9HGCSvBSiSHrA==
Date: Fri, 6 Sep 2024 09:50:30 +0100
From: Conor Dooley <conor@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
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
Message-ID: <20240906-reveler-waggle-8a7043690633@squawk>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
 <20240829-wip-bl-ad3552r-axi-v0-v1-4-b6da6015327a@baylibre.com>
 <20240829-stopwatch-morality-a933abb4d688@spud>
 <d4eddc24-9192-4a4a-ac67-4cfbd429a6a9@baylibre.com>
 <20240830-quilt-appointee-4a7947e84988@spud>
 <642d61b23c58d9b846e42badb2f2d97691c92144.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bvsL+yo0Y6UEogH8"
Content-Disposition: inline
In-Reply-To: <642d61b23c58d9b846e42badb2f2d97691c92144.camel@gmail.com>


--bvsL+yo0Y6UEogH8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2024 at 11:50:45AM +0200, Nuno S=E1 wrote:
> On Fri, 2024-08-30 at 16:33 +0100, Conor Dooley wrote:
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
> > >=20
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
> > > > > =A0 Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml | 9
> > > > > +++++++++
> > > > > =A0 1 file changed, 9 insertions(+)
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-da=
c.yaml
> > > > > b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > > > > index a55e9bfc66d7..a7ce72e1cd81 100644
> > > > > --- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > > > > +++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > > > > @@ -38,6 +38,15 @@ properties:
> > > > > =A0=A0=A0 clocks:
> > > > > =A0=A0=A0=A0=A0 maxItems: 1
> > > > You mentioned about new compatible strings, does the one currently
> > > > listed in this binding support both bus types?
> >=20
> > You didn't answer this, and there's insufficient explanation of the
> > "hardware" in this RFC, but I found this which is supposedly the
> > backend:
> > https://github.com/analogdevicesinc/hdl/tree/main/library/axi_ad3552r
> > adi,axi-dac.yaml has a single compatible, and that compatible has
> > nothing to do with "axi_ad3552r" as it is "adi,axi-dac-9.1.b". I would
> > expect either justification for reuse of the compatible, or a brand new
> > compatible for this backend, even if the driver can mostly be reused.
> >=20
>=20
> Hi Conor,
>=20
> So most of these designs have some changes (even if minimal) in the regis=
ter map
> and the idea (mine actually) with this backend stuff was to keep the back=
end
> driver (axi-dac/adc) with the generic compatible since all the (different)
> functionality is basically defined by the frontend they connect too and t=
hat
> functionality is modeled by IIO backend ops. For some more
> significant/fundamental differences in the IP like this bus controller ki=
nd of
> thing, we would add have proper FW properties. The main idea was kind of =
using
> the frontend + generic backend combo so no need for new compatibles for e=
very
> new design.
>=20
> It's still early days (at least upstream) for these IP cores and the back=
end
> code so if you say that we should have new compatibles for every new desi=
gn that
> has some differences in the register map (even if minimal), I'm of course=
 fine
> with it. I've done it like this because I was (am) kind of afraid for thi=
ngs to
> get complicated fairly quickly both in the bindings and driver (well mayb=
e not
> in the driver). OTOH, it can simplify things a lot as it's way easier to
> identify different implementations of the IP directly in the driver so we=
 have
> way more flexibility.

Most of my opinion on this from a usability perspective for your
customers, rather than how the kernel is going to handle it. If a user
is inserting a preconfigured instance of the IP, for a specific ADC or
DAC, into their design I think it makes more sense to have a compatible,
rather than expect the user to reverse engineer how the IP has been
configured and which properties they should select. My own policy for
Microchip's stuff is that if something has a name or entry in the IP
catalogue then it should have a dedicated compatible, even if it is just a
preconfigured version of some other IP block and I guess what I am
saying here is an extension of that.

I suspect that in many cases the specific compatible won't be required,
and a fallback to the generic one will suffice for the driver, and it
would only be for cases like this, that have "significant/fundamental
differences" that the driver would need the specific one.

>=20
> > Could you please link to whatever ADI wiki has detailed information on
> > how this stuff works so that I can look at it to better understand the
> > axes of configuration here?
> >=20
> > > >=20
> > > > Making the bus type decision based on compatible only really makes =
sense
> > > > if they're different versions of the IP, but not if they're differe=
nt
> > > > configuration options for a given version.
> > > >=20
> > > > > +=A0 bus-type:
> > >=20
> > > DAC IP on fpga actually respects same structure and register set, exc=
ept
> > > for a named "custom" register that may use specific bitfields dependi=
ng
> > > on the application of the IP.
> >=20
> > To paraphrase:
> > "The register map is the same, except for the bit that is different".
> > If ADI is shipping several different configurations of this IP for
> > different DACs, I'd be expecting different compatibles for each backend
> > to be honest.
>=20
> Yes, pretty much we have a generic core with most of the designs being ba=
sed on
> it but with some slight differences. At least for the new ones, almost al=
l of
> them have slight deviations from the generic/base core.
>=20
> > If each DAC specific backend was to have a unique compatible, would the
> > type of bus used be determinable from it? Doesn't have to work for all
> > devices from now until the heath death of the universe, but at least for
> > the devices that you're currently aware of?
> >=20
>=20
> My original idea was to have a bus controller boolean for this core at le=
ast for
> now that we only have one bus type (so we could assume qspi in the driver=
). If
> the time comes we need to add support for something else, then we would n=
eed
> another property to identify the type.

With a specific compatible, you can "easily" add different defaults. So
the other devices could default to no bus when a bus related property is
required and this one could default to qspi. But unless there are
ADCs/DACs that have a backend that can be configured with different
types of bus, a property for this wouldn't be needed - the compatible
and match data would suffice.

>=20
> > > > If, as you mentioned, there are multiple bus types, a non-flag prop=
erty
> > > > does make sense. However, I am really not keen on these "forced" nu=
merical
> > > > properties at all, I'd much rather see strings used here.
> >=20
> > > > > +=A0=A0=A0 maxItems: 1
> > > > > +=A0=A0=A0 description: |
> > > > > +=A0=A0=A0=A0=A0 Configure bus type:
> > > > > +=A0=A0=A0=A0=A0=A0=A0 - 0: none
> > > > > +=A0=A0=A0=A0=A0=A0=A0 - 1: qspi
> >=20
> > Also, re-reading the cover letter, it says "this platform driver uses a=
 4
> > lanes parallel bus, plus a clock line, similar to a qspi."
> > I don't think we should call this "qspi" if it is not actually qspi,
> > that's just confusing.
> >=20
>=20
> Just by looking at the datasheet it feels like typical qspi to be honest.=
 And,
> fwiw, even if not really qspi, this is how the datasheet names the interf=
ace.

Right, just a phrasing issue in the cover letter I guess :)

--bvsL+yo0Y6UEogH8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZtrCUwAKCRB4tDGHoIJi
0vz+AP0b2cfD1DZnTMm1X8AbalLhwaQFevPvYyUSbcojoR92RgD/XUSer25k5nMb
X2KA0wly+kXHCDd0G51AGxqZT/GdUgw=
=zYvA
-----END PGP SIGNATURE-----

--bvsL+yo0Y6UEogH8--

