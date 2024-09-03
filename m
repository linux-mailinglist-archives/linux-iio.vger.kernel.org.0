Return-Path: <linux-iio+bounces-9092-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7621396A739
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 21:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B03ADB23216
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 19:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9258618E047;
	Tue,  3 Sep 2024 19:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gt2/n5c1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445F439ADD;
	Tue,  3 Sep 2024 19:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725391114; cv=none; b=h25jteEskSk5pqf9QE0M5qx3xop12KdATqzplh0SsT/RC4m2kC5u5Cd7mma2z0I++4BOlhJSVs306e284Mqls0SD0VAd/wb80vcXThEnzrEvhWsYexq4rRSpbnVaw1gqUaHfBDAn1q2ck2y8cZAauM88KjZDQdFAHKZtybhXyjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725391114; c=relaxed/simple;
	bh=qt4EOPW/lqip3xdDfje7Z4y7q0ilGDkEl6R8V2x0rIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FhaX6OH4Rn5oGbCuUNmRHg1gn4mrgQcxB1qJHtrpcrz27PR0ZGcOUlEfAnQMBOyw8ll+fWAOCT7Dg0THFIc5PWsCWW/v1bSlIhEpHTy5Z6fJVnxMFAlkfEssR4+V/Jt5CY+68CvGUN5suoVDzTm+CgfwXQywXIwRFjaXDoExJic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gt2/n5c1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307D5C4CEC4;
	Tue,  3 Sep 2024 19:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725391114;
	bh=qt4EOPW/lqip3xdDfje7Z4y7q0ilGDkEl6R8V2x0rIQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gt2/n5c17LRJlvVNRzEsiBy6eaTgTKKgocqtzMaQViNSaw6c0gFV5Up0MqYCXu6iK
	 ErT9+ENetaZZEd8dh4F66AIWgGln5RsMkuCUGPrVEz/lAjo0RGp3hd1X3c4R0krm9Z
	 +MQYZJ/jA/nTAZB10oTxnJ85CqLieObxKMptn5f3Gzg3BqHcPUBTrg0fadNdAxwGEx
	 KhiunGPY2TV2iaYtGlZgwt50Bq4J3dvMMs6cfIT84VH4QVQ8Z+foC1u7e4LD9DOyZ2
	 /J8gDvvSk9SOjvEuC22FsVxBDxyPYvU1WUqbKTpd1sas5/K1cSrTonrOCmRQPzy7eT
	 GtAKM3egmNkJw==
Date: Tue, 3 Sep 2024 20:18:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Conor Dooley <conor@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com
Subject: Re: [PATCH RFC 4/8] dt-bindings: iio: dac: add adi axi-dac bus
 property
Message-ID: <20240903201825.442502bb@jic23-huawei>
In-Reply-To: <9015bc26-1a3a-49df-8728-12ceb8993035@baylibre.com>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
	<20240829-wip-bl-ad3552r-axi-v0-v1-4-b6da6015327a@baylibre.com>
	<20240829-stopwatch-morality-a933abb4d688@spud>
	<d4eddc24-9192-4a4a-ac67-4cfbd429a6a9@baylibre.com>
	<20240830-quilt-appointee-4a7947e84988@spud>
	<9015bc26-1a3a-49df-8728-12ceb8993035@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Sep 2024 11:32:37 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> Hi Conor,
>=20
>=20
> On 30/08/24 5:33 PM, Conor Dooley wrote:
> > On Fri, Aug 30, 2024 at 10:19:49AM +0200, Angelo Dureghello wrote: =20
> >> Hi Conor,
> >>
> >> On 29/08/24 5:46 PM, Conor Dooley wrote: =20
> >>> On Thu, Aug 29, 2024 at 02:32:02PM +0200, Angelo Dureghello wrote: =20
> >>>> From: Angelo Dureghello <adureghello@baylibre.com>
> >>>>
> >>>> Add bus property. =20
> >>> RFC it may be, but you do need to explain what this bus-type actually
> >>> describes for commenting on the suitability of the method to be
> >>> meaningful. =20
> >> thanks for the feedbacks,
> >>
> >> a "bus" is intended as a generic interface connected to the target,
> >> may be used from a custom IP (fpga) to communicate with the target
> >> device (by read/write(reg and value)) using a special custom interface.
> >>
> >> The bus could also be physically the same of some well-known existing
> >> interfaces (as parallel, lvds or other uncommon interfaces), but using
> >> an uncommon/custom protocol over it.
> >>
> >> In concrete, actually bus-type is added to the backend since the
> >> ad3552r DAC chip can be connected (for maximum speed) by a 5 lanes DDR
> >> parallel bus (interface that i named QSPI, but it's not exactly a QSPI
> >> as a protocol), so it's a device-specific interface.
> >>
> >> With additions in this patchset, other frontends, of course not only
> >> DACs, will be able to add specific busses and read/wrtie to the bus
> >> as needed.
> >> =20
> >>>> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> >>>> ---
> >>>>    Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml | 9 ++=
+++++++
> >>>>    1 file changed, 9 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.y=
aml b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> >>>> index a55e9bfc66d7..a7ce72e1cd81 100644
> >>>> --- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> >>>> +++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> >>>> @@ -38,6 +38,15 @@ properties:
> >>>>      clocks:
> >>>>        maxItems: 1 =20
> >>> You mentioned about new compatible strings, does the one currently
> >>> listed in this binding support both bus types? =20
> > You didn't answer this, and there's insufficient explanation of the
> > "hardware" in this RFC, but I found this which is supposedly the
> > backend:
> > https://github.com/analogdevicesinc/hdl/tree/main/library/axi_ad3552r
> > adi,axi-dac.yaml has a single compatible, and that compatible has
> > nothing to do with "axi_ad3552r" as it is "adi,axi-dac-9.1.b". I would
> > expect either justification for reuse of the compatible, or a brand new
> > compatible for this backend, even if the driver can mostly be reused.
> >
> > Could you please link to whatever ADI wiki has detailed information on
> > how this stuff works so that I can look at it to better understand the
> > axes of configuration here? =20
>=20
> https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html
>=20
> that has same structure and register set of the generic ADI AXI-DAC IP:
> https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
>=20
>=20
> >>> Making the bus type decision based on compatible only really makes se=
nse
> >>> if they're different versions of the IP, but not if they're different
> >>> configuration options for a given version.
> >>> =20
> >>>> +  bus-type: =20
> >> DAC IP on fpga actually respects same structure and register set, exce=
pt
> >> for a named "custom" register that may use specific bitfields depending
> >> on the application of the IP. =20
> > To paraphrase:
> > "The register map is the same, except for the bit that is different".
> > If ADI is shipping several different configurations of this IP for
> > different DACs, I'd be expecting different compatibles for each backend
> > to be honest =20
>=20
> i am still quite new to this fpga-based implementations, at least for how
> such IPs are actually interfacing to the linux subsystem, so i may miss
> some point.
>=20
> About the "adi,axi-dac-9.1.b" compatible, the generic DAC IP register set
> is mostly the same structure of this ad3552r IP (links above), except for
> bitfields in the=C2=A0DAC_CUSTOM_CTRL register.
>=20
> My choice for now was to add a bus-type property.
>=20
> Not an HDL expert, but i think a different bus means, from an hardware=20
> point of
> view, a different IP in terms of internal fpga circuitry, even if not as a
> register-set.

Whilst I'm not sure we should be hiding the bus element away (rather than
doing something closer to an spi bus + offloads) if we do end up like this
maybe encode the bus type in the compatible. It's definitely the
adi,axi-dac-qspi* specific variant if there isn't an explicit register to
program to tell it not use a parallel bus or similar.

Jonathan


>=20
>=20
> > .
> > If each DAC specific backend was to have a unique compatible, would the
> > type of bus used be determinable from it? Doesn't have to work for all
> > devices from now until the heath death of the universe, but at least for
> > the devices that you're currently aware of?
> > =20
> >>> If, as you mentioned, there are multiple bus types, a non-flag proper=
ty
> >>> does make sense. However, I am really not keen on these "forced" nume=
rical
> >>> properties at all, I'd much rather see strings used here. =20
> >>>> +    maxItems: 1
> >>>> +    description: |
> >>>> +      Configure bus type:
> >>>> +        - 0: none
> >>>> +        - 1: qspi =20
> > Also, re-reading the cover letter, it says "this platform driver uses a=
 4
> > lanes parallel bus, plus a clock line, similar to a qspi."
> > I don't think we should call this "qspi" if it is not actually qspi,
> > that's just confusing. =20
>=20
> Agree, name should be something different.
>=20
>=20
> > Cheers,
> > Conor. =20
>=20
> Thanks,
> regards,
>=20
> Angelo
>=20
>=20
> >>>> +    enum: [0, 1]
> >>>> +    default: 0
> >>>> +
> >>>>      '#io-backend-cells':
> >>>>        const: 0
> >>>>
> >>>> --=20
> >>>> 2.45.0.rc1
> >>>> =20
> >> --=20
> >>   ,,,      Angelo Dureghello
> >> :: :.     BayLibre -runtime team- Developer
> >> :`___:
> >>   `____:
> >> =20


