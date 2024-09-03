Return-Path: <linux-iio+bounces-9095-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E4C96A783
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 21:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 049FF1F253D5
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 19:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429F91D0177;
	Tue,  3 Sep 2024 19:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhld5IVH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBE91CC142;
	Tue,  3 Sep 2024 19:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725392387; cv=none; b=bA69/NoQ24t6Hzmsr9XmmtGLP3DSd1En4sww7hA2xGIILHT8xa0woM+i38WDJBGvDGqxgouD8wEl5vBTffLiVxCrW41OenP/CTQ5gdTe6gHOJx0XAdn7LPynRdNoS1VOdcAONO2cA7l2+oLEtlX7prk4cZUIslJce6SrlgVS2yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725392387; c=relaxed/simple;
	bh=KJfRYfq4Tc1SuvTUdvxSfMAX5buQdAh38TAPXT/vBVs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kCFuLi017yc1BcrNFWJtw8LaLQXj+EVwXPaEIL9ZNzTCEUswMV8dqiU69ibHSEecLI6BEwlH1HKoO4r8vK5Lb0U5oLXinWUE6TiWxPzPteJML1qq0qLvNngyI3P79c6Lz1VG02O/4vhUc9T7K9FgwuZJU0kEamDYl2KxhPH2dW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhld5IVH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95E5C4CEC4;
	Tue,  3 Sep 2024 19:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725392385;
	bh=KJfRYfq4Tc1SuvTUdvxSfMAX5buQdAh38TAPXT/vBVs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rhld5IVHNx25ieavp3YU7t/3kGzijcsogzDqOeERd0s8TKDjb1hV1STFtjS34WPlY
	 uIcurcL/6uE15ycCN6ukZ7W5evneBItU9iCSgUGc36CPwX0CoIz71m482yb72BZfPZ
	 +ou8MjIwIsa/n8b+iYdv9voycYZFLD+QgZ+Zm+ME3xdhRgNdzdzsvy4X0b5XqLVShf
	 1nFrHzpTcjNbl9v50e+IGm9QjUVhXNyve/J7tb2QvpqA6Y2s3t9uwldNKutClomOI1
	 gfwhqO5mqbFyzBdTEL5C0Ffw9/0R1F4OKrYhCQwrkr6wIm2MTPriJ61czD77rkrffB
	 QcCZwWXSY3z0Q==
Date: Tue, 3 Sep 2024 20:39:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 0/8] iio: dac: introducing ad3552r-axi
Message-ID: <20240903203935.358a1423@jic23-huawei>
In-Reply-To: <4a62ea7b-a8af-49e0-9718-30d927a69038@baylibre.com>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
	<20240831123837.26a1070a@jic23-huawei>
	<74e0b200-d4c0-4aa3-9ee6-f49ac3f1467d@baylibre.com>
	<4a62ea7b-a8af-49e0-9718-30d927a69038@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Sep 2024 11:17:24 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 9/3/24 3:34 AM, Angelo Dureghello wrote:
> > Hi Jonathan and all,
> >=20
> >=20
> > On 31/08/24 1:38 PM, Jonathan Cameron wrote: =20
> >> On Thu, 29 Aug 2024 14:31:58 +0200
> >> Angelo Dureghello <adureghello@baylibre.com> wrote:
> >> =20
> >>> Hi, asking for comments for this patchset, that is mostly
> >>> ready, at least feature-complete and functionally tested.
> >>>
> >>> I am introducing ad3552r-axi variant, controlled from a fpga-based
> >>> AXI IP, as a platform driver, using the DAC backend. The patchset is
> >>> actually based on linux-iio, since some needed DAC backend features
> >>> was already there on that repo only, still to be merged in mainline.
> >>>
> >>> Comments i would like to ask are:
> >>>
> >>> - i added some devicetree bindings inside current ad3552r yaml,
> >>> =C2=A0=C2=A0 device is the same, so i wouldn't create a different yam=
l file. =20
> >> Agreed. If same device, it's usually better to keep it in one file.
> >> =20
> >>> - if it's ok adding the bus-type property in the DAC backend:
> >>> =C2=A0=C2=A0 actually, this platform driver uses a 4 lanes parallel b=
us, plus
> >>> =C2=A0=C2=A0 a clock line, similar to a qspi. This to read an write r=
egisters
> >>> =C2=A0=C2=A0 and as well to send samples at double data rate. Other D=
AC may
> >>> =C2=A0=C2=A0 need "parallel" or "lvds" in the future. =20
> >> If it is for register read + write as well, sounds to me like you need
> >> to treat this as a new bus type, possibly then combined with a
> >> backend, or something similar to spi offload?
> >>
> >> What bus does this currently sit on in your DT bindings?
> >> (add an example) =20
> >=20
> >=20
> > &amba {
> >=20
> > =C2=A0=C2=A0 =C2=A0ref_clk: clk@44B00000 {
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adi,axi-clkgen-2.=
00.a";
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x44B00000 0x10000>;
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 #clock-cells =3D <0>;
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&clkc 15>, <&clkc 15>;
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 clock-names =3D "s_axi_aclk", "cl=
kin1";
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 clock-output-names =3D "ref_clk";
> > =C2=A0=C2=A0 =C2=A0};
> >=20
> > =C2=A0=C2=A0 =C2=A0dac_tx_dma: dma-controller@0x44a30000 {
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adi,axi-dmac-1.00=
.a";
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x44a30000 0x10000>;
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 #dma-cells =3D <1>;
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 interrupt-parent =3D <&intc>;
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 interrupts =3D <0 57 IRQ_TYPE_LEV=
EL_HIGH>;
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&clkc 15>;
> >=20
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 adi,channels {
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 #size-cells =
=3D <0>;
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 #address-cells=
 =3D <1>;
> >=20
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 dma-channel@0 {
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 reg =3D <0>;
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 adi,source-bus-width =3D <32>;
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 adi,source-bus-type =3D <0>;
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 adi,destination-bus-width =3D <32>;
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 adi,destination-bus-type =3D <1>;
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 };
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 };
> > =C2=A0=C2=A0 =C2=A0};
> >=20
> > =C2=A0=C2=A0 =C2=A0backend: controller@44a70000 {
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adi,axi-dac-9.1.b=
";
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x44a70000 0x1000>;
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 dmas =3D <&dac_tx_dma 0>;
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 dma-names =3D "tx";
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 #io-backend-cells =3D <0>;
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&ref_clk>;
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 bus-type =3D <1>;=C2=A0 /* IIO QS=
PI */
> > =C2=A0=C2=A0 =C2=A0};
> >=20
> > =C2=A0=C2=A0 =C2=A0axi-ad3552r {
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adi,ad3552r";
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 reset-gpios =3D <&gpio0 92 GPIO_A=
CTIVE_LOW>;
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 io-backends =3D <&backend>;
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <1>;
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <0>;
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 channel@0 {
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 reg =3D <0>;
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 adi,output-ran=
ge-microvolt =3D <(-10000000) (10000000)>;
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 };
> > =C2=A0=C2=A0 =C2=A0}; =20
>=20
> Shouldn't the axi-ad3552r node be one level higher since it isn't
> a memory-mapped device, but rather an external chip?
Definitely not where it currently is..
>=20
> But based on the other feedback we got in this series and some
> #devicetree IRC chat here is an alternate binding suggestion we
> could consider.
>=20
> First, even though the FPGA IP block for use with AD3225R uses
> the same register map as the AXI DAC IP block, some of the
> registers behave differently, so it makes sense to have a
> different compatible string rather than using the bus-type
> property to tell the difference between the two IP blocks.
> There are likely more differences than just the bus type.

I'd be amazed if they managed to keep things that similar
given totally different buses.

>=20
> Second, technically, the AXI DAC IP block can't be used as
> a generic SPI controller, so it wouldn't make sense to put
> it in drivers/spi.

I wonder if there is any precedence of restricted controllers
for SPI?  (For i2c we have the smbus ones as a vaguely similar
example). +CC Mark.

>  But, from wiring point of view, it could
> still make sense to use SPI DT bindings since we have SPI
> wiring. At the same time, the AXI DAC IP block is also
> providing extra functionality in addition to the SPI bus
> so it makes sense to keep the io-backend bindings for those
> extra bits.
>=20
>     backend: spi@44a70000 {
>         compatible =3D "adi,axi-dac-ad3225r";
>         reg =3D <0x44a70000 0x1000>;
>         dmas =3D <&dac_tx_dma 0>;
>         dma-names =3D "tx";
>         #io-backend-cells =3D <0>;
>         clocks =3D <&ref_clk>;
>=20
>         #address-cells =3D <1>;
>         #size-cells =3D <0>;
>=20
>         dac@0 {
>             compatible =3D "adi,ad3552r";
>             reg =3D <0>;
>=20
>             /*=20
>              * Not sure how right this is - attempting to say that
>              * the QSPI select pin is hardwired high, so the 4 SPI I/O
>              * pins on the DAC are always functioning as SDIO0/1/2/3
>              * as opposed to the usual 2 SDI/SDO pins and 2 unused.
>              */
>             spi-3-wire;
>             spi-tx-bus-width =3D <4>;
>             spi-rx-bus-width =3D <4>;
>=20
>             reset-gpios =3D <&gpio0 92 GPIO_ACTIVE_LOW>;
>             io-backends =3D <&backend>;
>=20
>             #address-cells =3D <1>;
>             #size-cells =3D <0>;
>=20
>             channel@0 {
>                 reg =3D <0>;
>                 adi,output-range-microvolt =3D <(-10000000) (10000000)>;
>             };
>         };
>     };

That's definitely an improvement.  It's a little strange to have
a reference back to the parent but I'm fine with that.

Jonathan

>=20
>=20


