Return-Path: <linux-iio+bounces-9384-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A210971924
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 14:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5E51F23734
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 12:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6EB1B78F4;
	Mon,  9 Sep 2024 12:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OCO4iSyF"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E621B5EC7;
	Mon,  9 Sep 2024 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725884316; cv=none; b=QFn6Zq/BCh4Gs6oxOBq3F3+507M5eOmUkh5EbLRav8RJ2RV9CHF4V8MNGPW37k3CuV9vHgGhZnF6CLACtt4KB/64AIx+Y3AiaBMfcnu3h4oZpsEWLaaIaa+6CmuLzS8szykaYDsD94OCZhq8ZHuFG9wUmxkofexhHvVbHH4CW8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725884316; c=relaxed/simple;
	bh=9lHlopNyUBYE5/RRriLjsiAwSzIU1+qthOZCQLrQenM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvnu+sEjuXl8lKHPAJCEoc/p2RAp8ewR0G9shxcLOYeWzW1QOxgMiPYMPbz0QcoEjFJ7zBsNOp/l4XCcdzOPsQ2kOmZ53vAbJRha25yReamiL/fWOGGsNmVn8bE191EVjLjFN45awUAzhIUU+xSVVuXsJDxJSHSeJ16dPuJEcDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OCO4iSyF; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725884314; x=1757420314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9lHlopNyUBYE5/RRriLjsiAwSzIU1+qthOZCQLrQenM=;
  b=OCO4iSyFpVg9inrYuogMDb0hBrR9somI4BtKH+yNKrw8cAdSRs2W/9e7
   drBArAffJYU9HPpwm3Jk2JGiwU9Ww0VkHNrvMx0CcpxAj/bGVZcvjnbnC
   6ih42CHmFzkcB06nzeEHOlYNk3C19m9TrQno2W8OENN6m1L3+7WBAkqWa
   7MXOSVV79Q9PvPXa2Xn1tQrO3myplItZ/GApNBg+mpuntEjJsYR48WBTc
   iin/SM67HtTo2HXY0rJxPqBOcs8kpUE4Hzx0pVBnI81TF+ZgNO9w0PcjD
   OldhFD0A1pOajIGSycBZAJmjnvqbSEkob+PPrZM8o+hzjgeenko/EH+k8
   A==;
X-CSE-ConnectionGUID: g7KiyjGIR6GFWp74rkJR0A==
X-CSE-MsgGUID: wdZkLXUTT62i3I3tX5YKGw==
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="asc'?scan'208";a="198947431"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2024 05:18:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Sep 2024 05:18:08 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 9 Sep 2024 05:18:05 -0700
Date: Mon, 9 Sep 2024 13:17:33 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Angelo Dureghello <adureghello@baylibre.com>
CC: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>, Conor Dooley
	<conor@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Nuno =?iso-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dlechner@baylibre.com>
Subject: Re: [PATCH RFC 4/8] dt-bindings: iio: dac: add adi axi-dac bus
 property
Message-ID: <20240909-humiliate-gravel-adf4966538e0@wendy>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
 <20240829-wip-bl-ad3552r-axi-v0-v1-4-b6da6015327a@baylibre.com>
 <20240829-stopwatch-morality-a933abb4d688@spud>
 <d4eddc24-9192-4a4a-ac67-4cfbd429a6a9@baylibre.com>
 <20240830-quilt-appointee-4a7947e84988@spud>
 <9015bc26-1a3a-49df-8728-12ceb8993035@baylibre.com>
 <20240906-venomous-candle-8348b00640ca@squawk>
 <5fd8374285d7dadd68777efabad753b981d29f40.camel@gmail.com>
 <f60ea1cd-ac24-4640-86be-71d636c1818e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WHCfdZomYcGBQi5w"
Content-Disposition: inline
In-Reply-To: <f60ea1cd-ac24-4640-86be-71d636c1818e@baylibre.com>

--WHCfdZomYcGBQi5w
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 07, 2024 at 10:53:07AM +0200, Angelo Dureghello wrote:
>=20
> On 06/09/24 1:32 PM, Nuno S=E1 wrote:
> > On Fri, 2024-09-06 at 10:04 +0100, Conor Dooley wrote:
> > > On Mon, Sep 02, 2024 at 11:32:37AM +0200, Angelo Dureghello wrote:
> > > > Hi Conor,
> > > >=20
> > > >=20
> > > > On 30/08/24 5:33 PM, Conor Dooley wrote:
> > > > > On Fri, Aug 30, 2024 at 10:19:49AM +0200, Angelo Dureghello wrote:
> > > > > > Hi Conor,
> > > > > >=20
> > > > > > On 29/08/24 5:46 PM, Conor Dooley wrote:
> > > > > > > On Thu, Aug 29, 2024 at 02:32:02PM +0200, Angelo Dureghello w=
rote:
> > > > > > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > > > > > >=20
> > > > > > > > Add bus property.
> > > > > > > RFC it may be, but you do need to explain what this bus-type =
actually
> > > > > > > describes for commenting on the suitability of the method to =
be
> > > > > > > meaningful.
> > > > > > thanks for the feedbacks,
> > > > > >=20
> > > > > > a "bus" is intended as a generic interface connected to the tar=
get,
> > > > > > may be used from a custom IP (fpga) to communicate with the tar=
get
> > > > > > device (by read/write(reg and value)) using a special custom in=
terface.
> > > > > >=20
> > > > > > The bus could also be physically the same of some well-known ex=
isting
> > > > > > interfaces (as parallel, lvds or other uncommon interfaces), bu=
t using
> > > > > > an uncommon/custom protocol over it.
> > > > > >=20
> > > > > > In concrete, actually bus-type is added to the backend since the
> > > > > > ad3552r DAC chip can be connected (for maximum speed) by a 5 la=
nes DDR
> > > > > > parallel bus (interface that i named QSPI, but it's not exactly=
 a QSPI
> > > > > > as a protocol), so it's a device-specific interface.
> > > > > >=20
> > > > > > With additions in this patchset, other frontends, of course not=
 only
> > > > > > DACs, will be able to add specific busses and read/wrtie to the=
 bus
> > > > > > as needed.
> > > > > >=20
> > > > > > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > > > > > > ---
> > > > > > > >  =A0=A0 Documentation/devicetree/bindings/iio/dac/adi,axi-d=
ac.yaml | 9
> > > > > > > > +++++++++
> > > > > > > >  =A0=A0 1 file changed, 9 insertions(+)
> > > > > > > >=20
> > > > > > > > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,=
axi-dac.yaml
> > > > > > > > b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > > > > > > > index a55e9bfc66d7..a7ce72e1cd81 100644
> > > > > > > > --- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac=
=2Eyaml
> > > > > > > > +++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac=
=2Eyaml
> > > > > > > > @@ -38,6 +38,15 @@ properties:
> > > > > > > >  =A0=A0=A0=A0 clocks:
> > > > > > > >  =A0=A0=A0=A0=A0=A0 maxItems: 1
> > > > > > > You mentioned about new compatible strings, does the one curr=
ently
> > > > > > > listed in this binding support both bus types?
> > > > > You didn't answer this, and there's insufficient explanation of t=
he
> > > > > "hardware" in this RFC, but I found this which is supposedly the
> > > > > backend:
> > > > > https://github.com/analogdevicesinc/hdl/tree/main/library/axi_ad3=
552r
> > > > > adi,axi-dac.yaml has a single compatible, and that compatible has
> > > > > nothing to do with "axi_ad3552r" as it is "adi,axi-dac-9.1.b". I =
would
> > > > > expect either justification for reuse of the compatible, or a bra=
nd new
> > > > > compatible for this backend, even if the driver can mostly be reu=
sed.
> > > > >=20
> > > > > Could you please link to whatever ADI wiki has detailed informati=
on on
> > > > > how this stuff works so that I can look at it to better understan=
d the
> > > > > axes of configuration here?
> > > > https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.ht=
ml
> > > >=20
> > > > that has same structure and register set of the generic ADI AXI-DAC=
 IP:
> > > > https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
> > > >=20
> > > >=20
> > > > > > > Making the bus type decision based on compatible only really =
makes sense
> > > > > > > if they're different versions of the IP, but not if they're d=
ifferent
> > > > > > > configuration options for a given version.
> > > > > > >=20
> > > > > > > > +=A0 bus-type:
> > > > > > DAC IP on fpga actually respects same structure and register se=
t, except
> > > > > > for a named "custom" register that may use specific bitfields d=
epending
> > > > > > on the application of the IP.
> > > > > To paraphrase:
> > > > > "The register map is the same, except for the bit that is differe=
nt".
> > > > > If ADI is shipping several different configurations of this IP for
> > > > > different DACs, I'd be expecting different compatibles for each b=
ackend
> > > > > to be honest
> > > > i am still quite new to this fpga-based implementations, at least f=
or how
> > > > such IPs are actually interfacing to the linux subsystem, so i may =
miss
> > > > some point.
> > > >=20
> > > > About the "adi,axi-dac-9.1.b" compatible, the generic DAC IP regist=
er set
> > > > is mostly the same structure of this ad3552r IP (links above), exce=
pt for
> > > > bitfields in the=A0DAC_CUSTOM_CTRL register.
> > > >=20
> > > > My choice for now was to add a bus-type property.
> > > >=20
> > > > Not an HDL expert, but i think a different bus means, from an hardw=
are point
> > > > of
> > > > view, a different IP in terms of internal fpga circuitry, even if n=
ot as a
> > > > register-set.
> > >=20
> > > Depending on whether or not the unmodified driver can be used with th=
is
> > > IP (so the QSPI bus stuff would need to be optional) then a fallback
> > > should be used given the degree of similarity. It, however, seems lik=
ely
> > > that is not the case, and without the QSPI bus there'd be no way to
> > > communicate with the device. Is there any reason to use this IP as a
> > > backend, without connecting the QSPI bus at all, leaving the ADC/DAC =
on
> > > a regular SPI bus?
> > >=20
> > Somewhere in my replies, I'm doing the exact same question to myself. W=
e probably
> > need to speak with the FPGA folks but I guess (hope) they had a good re=
ason for this.
>=20
> to clarify a bit the custom (fpga-based) QSPI need, i did some checks in =
the
> datasheets:
>=20
> 1. ADI is actually supporting ad3552r by eval-ad3552r-fmcx eval boards,
> with specific fmc connector for the ZedBoard (zynq7000). This is the
> current focused hardware for this job.

"currently focused" being the key words! Since it is FPGA IP, you've got
no control over where it is being used, so the particular use case you're
developing for is not really that important.

> 2. Zynq7000 std non-fpga controller is designed to control flash memories,
> but can operate in "raw I/O" mode, so it may work with ad3552r, but is not
> supporting DDR, even if it may reach 100Mhz clock.
>=20
> 3. ad3552r accepts a maximum clock of 66Mhz. So for ZedBoard maximum speed
> of 33MUPS cannot be reached without DDR.
>=20
> 4. ad3552r requires DDR only in the data part, and in DDR mode we
> may also send some "non-loop" reg read/write, so requiring also the
> address to be sent in SDR. Not sure how many QSPI controllers in the mark=
et
> are
> working this way, even if it seems quite standard, looks like not many are
> actually
> supporting DDR. There may be, but not actually in the priority of my
> customer
> right now. And in that case, we could extend the generic spi ad3552r.c.

I think you need to ignore your use case here, and just consider whether or
not this IP can be used as a backend without the QSPI feature. That's
probably an easier thing to determine than whether or not there's another
controller out there that can satisfy the constraints. The docs say it
"interfaces", but that's such a generic word that it ultimately means
close to nothing.. There's the sync ability, but from my reading of the
github.io page, it doesn't do anything when the axi-dac is not actually
in the data path.

Cheers,
Conor.


--WHCfdZomYcGBQi5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZt7nXQAKCRB4tDGHoIJi
0rZ3AP9KgkjSVLU4/Cy0wspT2P3QWzIeygrFTMcuCVz/UBOrVgEAjyhnxFBtOZUZ
l9a17ScSFRjsbstzNtgZ7l7OH3BrWw8=
=08y7
-----END PGP SIGNATURE-----

--WHCfdZomYcGBQi5w--

