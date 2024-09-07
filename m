Return-Path: <linux-iio+bounces-9279-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 649AF9702A1
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 16:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F77B28458F
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 14:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064E915D5C3;
	Sat,  7 Sep 2024 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tggMVg0y"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE04615C149;
	Sat,  7 Sep 2024 14:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725718345; cv=none; b=PCfVzty6rGdyzEXgRih3Sf9U3ikKjB4TmrW0rBp/tyOT3CMus8wFYro6SWOpIz7ZvPFcs4jjdnc17fNS5l+l6978SJk/z7/U3w3ekC9Rmdb0l1X45mohkwPmUlZD9XViFZqaVV98sXuZlXqHiaKS5p9yLV+bFLSJFQVgsZLZ1ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725718345; c=relaxed/simple;
	bh=yCmFsqiyDxCFANDBHRAgeG9l8Ixj8AVG+HUqIL7RNS4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mby8erMJ6/UXPJn1VHlFKn7d5F4I44j7K3/lKbGSi2NTdZY5ZIf60nVnmoArldlFCacDv095Ph6EGAuAUEdtYN0onDB7mlpZTnSi7mcM/AdULMuKeWHiXSeM6ZfWpa2AYrQHWLU7pCpRwJMPqNHRC5EILnx+qC4SzpS3AtmjtAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tggMVg0y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C1EC4CEC2;
	Sat,  7 Sep 2024 14:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725718345;
	bh=yCmFsqiyDxCFANDBHRAgeG9l8Ixj8AVG+HUqIL7RNS4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tggMVg0yXCp9G9d5MdeE8/y2CP8wvtVZ0dubePvUP00SbiQZah0l08R9g+e5PXSq+
	 NaJ4C0Lqh3eQyUDsfDdGPldOxskv2ets9fT0ozxX9InhZUChlCM9xNXxL9LCYQcIoM
	 GzR3BeCXrMb85LwvRSPv9EGOAF5VGSPN8LkCEuQr6eLfh8Xjmom/qcmm8IvlRhZ48D
	 JndcpVekd+X9iIZHPcn9UHqT0ND2fFrsWkxMs0mLZMEMR2QSkbp/r2SXXyLZgH7Fe9
	 k2yzdX4zVQ7G66qIaKK+eiYMI4zf2iq2CVFghf+Ojtvsl2KlIt5Zjc7w7CdMkh8ubk
	 +KYsrvPtTddFA==
Date: Sat, 7 Sep 2024 15:12:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Lars-Peter Clausen  <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= 
 <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski 
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier Moysan 
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown 
 <broonie@kernel.org>
Subject: Re: [RFC PATCH 0/8] iio: dac: introducing ad3552r-axi
Message-ID: <20240907151215.6f4c829c@jic23-huawei>
In-Reply-To: <4bb5722003936371a661938d7238db195d2c0ad3.camel@gmail.com>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
	<20240831123837.26a1070a@jic23-huawei>
	<74e0b200-d4c0-4aa3-9ee6-f49ac3f1467d@baylibre.com>
	<4a62ea7b-a8af-49e0-9718-30d927a69038@baylibre.com>
	<20240903203935.358a1423@jic23-huawei>
	<4bb5722003936371a661938d7238db195d2c0ad3.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 05 Sep 2024 11:16:03 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2024-09-03 at 20:39 +0100, Jonathan Cameron wrote:
> > On Tue, 3 Sep 2024 11:17:24 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >  =20
> > > On 9/3/24 3:34 AM, Angelo Dureghello wrote: =20
> > > > Hi Jonathan and all,
> > > >=20
> > > >=20
> > > > On 31/08/24 1:38 PM, Jonathan Cameron wrote:=C2=A0  =20
> > > > > On Thu, 29 Aug 2024 14:31:58 +0200
> > > > > Angelo Dureghello <adureghello@baylibre.com> wrote:
> > > > > =C2=A0 =20
> > > > > > Hi, asking for comments for this patchset, that is mostly
> > > > > > ready, at least feature-complete and functionally tested.
> > > > > >=20
> > > > > > I am introducing ad3552r-axi variant, controlled from a fpga-ba=
sed
> > > > > > AXI IP, as a platform driver, using the DAC backend. The patchs=
et is
> > > > > > actually based on linux-iio, since some needed DAC backend feat=
ures
> > > > > > was already there on that repo only, still to be merged in main=
line.
> > > > > >=20
> > > > > > Comments i would like to ask are:
> > > > > >=20
> > > > > > - i added some devicetree bindings inside current ad3552r yaml,
> > > > > > =C2=A0=C2=A0 device is the same, so i wouldn't create a differe=
nt yaml file.=C2=A0  =20
> > > > > Agreed. If same device, it's usually better to keep it in one fil=
e.
> > > > > =C2=A0 =20
> > > > > > - if it's ok adding the bus-type property in the DAC backend:
> > > > > > =C2=A0=C2=A0 actually, this platform driver uses a 4 lanes para=
llel bus, plus
> > > > > > =C2=A0=C2=A0 a clock line, similar to a qspi. This to read an w=
rite registers
> > > > > > =C2=A0=C2=A0 and as well to send samples at double data rate. O=
ther DAC may
> > > > > > =C2=A0=C2=A0 need "parallel" or "lvds" in the future.=C2=A0  =20
> > > > > If it is for register read + write as well, sounds to me like you=
 need
> > > > > to treat this as a new bus type, possibly then combined with a
> > > > > backend, or something similar to spi offload?
> > > > >=20
> > > > > What bus does this currently sit on in your DT bindings?
> > > > > (add an example)=C2=A0  =20
> > > >=20
> > > >=20
> > > > &amba {
> > > >=20
> > > > =C2=A0=C2=A0 =C2=A0ref_clk: clk@44B00000 {
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adi,axi-clkge=
n-2.00.a";
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x44B00000 0x10000>;
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 #clock-cells =3D <0>;
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&clkc 15>, <&clkc=
 15>;
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 clock-names =3D "s_axi_aclk",=
 "clkin1";
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 clock-output-names =3D "ref_c=
lk";
> > > > =C2=A0=C2=A0 =C2=A0};
> > > >=20
> > > > =C2=A0=C2=A0 =C2=A0dac_tx_dma: dma-controller@0x44a30000 {
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adi,axi-dmac-=
1.00.a";
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x44a30000 0x10000>;
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 #dma-cells =3D <1>;
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 interrupt-parent =3D <&intc>;
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 interrupts =3D <0 57 IRQ_TYPE=
_LEVEL_HIGH>;
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&clkc 15>;
> > > >=20
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 adi,channels {
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 #size-cell=
s =3D <0>;
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 #address-c=
ells =3D <1>;
> > > >=20
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 dma-channe=
l@0 {
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 reg =3D <0>;
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 adi,source-bus-width =3D <32>;
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 adi,source-bus-type =3D <0>;
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 adi,destination-bus-width =3D <32>;
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 adi,destination-bus-type =3D <1>;
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 };
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 };
> > > > =C2=A0=C2=A0 =C2=A0};
> > > >=20
> > > > =C2=A0=C2=A0 =C2=A0backend: controller@44a70000 {
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adi,axi-dac-9=
.1.b";
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x44a70000 0x1000>;
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 dmas =3D <&dac_tx_dma 0>;
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 dma-names =3D "tx";
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 #io-backend-cells =3D <0>;
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&ref_clk>;
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 bus-type =3D <1>;=C2=A0 /* II=
O QSPI */
> > > > =C2=A0=C2=A0 =C2=A0};
> > > >=20
> > > > =C2=A0=C2=A0 =C2=A0axi-ad3552r {
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adi,ad3552r";
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 reset-gpios =3D <&gpio0 92 GP=
IO_ACTIVE_LOW>;
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 io-backends =3D <&backend>;
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <1>;
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <0>;
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 channel@0 {
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 reg =3D <0=
>;
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 adi,output=
-range-microvolt =3D <(-10000000) (10000000)>;
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 };
> > > > =C2=A0=C2=A0 =C2=A0};=C2=A0  =20
> > >=20
> > > Shouldn't the axi-ad3552r node be one level higher since it isn't
> > > a memory-mapped device, but rather an external chip? =20
> > Definitely not where it currently is.. =20
> > >=20
> > > But based on the other feedback we got in this series and some
> > > #devicetree IRC chat here is an alternate binding suggestion we
> > > could consider.
> > >=20
> > > First, even though the FPGA IP block for use with AD3225R uses
> > > the same register map as the AXI DAC IP block, some of the
> > > registers behave differently, so it makes sense to have a
> > > different compatible string rather than using the bus-type
> > > property to tell the difference between the two IP blocks.
> > > There are likely more differences than just the bus type. =20
> >=20
> > I'd be amazed if they managed to keep things that similar
> > given totally different buses.
> >  =20
>=20
> Yeah, I was trying to avoid new compatibles as much as I can because thin=
gs can
> get pretty confusing (with lots of new compatibles and quirks) pretty qui=
ckly.
> Typically yes, most designs have slight differences between them (with new
> features and so on) but so far I was trying (thinking) to have those as a
> generic new backend op (plus a matching binding property if needed). For =
this
> particular case, I'm fairly sure we could get away with the bus controller
> property and having different implementations depending on the bus being
> implemented. For the other bits that might differ between designs (eg: DDR
> support) is up to frontends to call it or not (depending on they having t=
hat
> feature or not).=20

That breaks down if the backend you happen to be using (maybe a new
one hasn't been written yet) is missing the DDR feature but the front end
device can run with or without it.
Unless the hardware makes this discoverable you'll have the backend driver
writing some enable bit that does nothing.

Maybe it's a case of using fallback compatibles - so define more specific
ones but with a fallback to one that doesn't provide the fancy features
and only covers thins all IPs support.

> Naturally we need that the IPs having DDR support to not have
> the same thing supported in different registers but we do control that si=
nce
> these are FPGA cores.
>=20
> All the above said, I'm fine with new compatibles but we need to draw a l=
ine
> when we add new ones. If the reasoning is the IP has some new bits or new
> registers, then things can get very confusing (even more if we think about
> fallback compatibles) as most of the new designs have some quirks (even if
> minimal). So I would say to add new compatibles when things get different=
 enough
> that a sane/generic API is not doable.

If you can influence the IP designers, the usual solution to this is
discoverability of features. So standard register that all IP carries that
has flags for each feature that has ever been implemented.

If not, best option is each IP gets a compatible but we assume fallbacks
are fine until they aren't.

Jonathan

>=20
> > >=20
> > > Second, technically, the AXI DAC IP block can't be used as
> > > a generic SPI controller, so it wouldn't make sense to put
> > > it in drivers/spi. =20
> >=20
> > I wonder if there is any precedence of restricted controllers
> > for SPI?=C2=A0 (For i2c we have the smbus ones as a vaguely similar
> > example). +CC Mark.
> >  =20
> > > =C2=A0But, from wiring point of view, it could
> > > still make sense to use SPI DT bindings since we have SPI
> > > wiring. At the same time, the AXI DAC IP block is also
> > > providing extra functionality in addition to the SPI bus
> > > so it makes sense to keep the io-backend bindings for those
> > > extra bits.
> > >=20
> > > =C2=A0=C2=A0=C2=A0 backend: spi@44a70000 {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adi,axi-da=
c-ad3225r";
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x44a70000 0x1000=
>;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dmas =3D <&dac_tx_dma 0>;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma-names =3D "tx";
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #io-backend-cells =3D <0>;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&ref_clk>;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <1>;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <0>;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dac@0 {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
mpatible =3D "adi,ad3552r";
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
g =3D <0>;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * Not sure how right this is - attempting to say that
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * the QSPI select pin is hardwired high, so the 4 SPI I/O
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * pins on the DAC are always functioning as SDIO0/1/2/3
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * as opposed to the usual 2 SDI/SDO pins and 2 unused.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sp=
i-3-wire;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sp=
i-tx-bus-width =3D <4>;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sp=
i-rx-bus-width =3D <4>;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
set-gpios =3D <&gpio0 92 GPIO_ACTIVE_LOW>;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 io=
-backends =3D <&backend>;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #a=
ddress-cells =3D <1>;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #s=
ize-cells =3D <0>;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ch=
annel@0 {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 reg =3D <0>;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 adi,output-range-microvolt =3D <(-10000000) (10000000=
)>;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > =C2=A0=C2=A0=C2=A0 }; =20
> >=20
> > That's definitely an improvement.=C2=A0 It's a little strange to have
> > a reference back to the parent but I'm fine with that.
> >  =20
>=20
> Agreed...
>=20
> - Nuno S=C3=A1
>=20


