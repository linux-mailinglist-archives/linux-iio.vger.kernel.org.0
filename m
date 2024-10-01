Return-Path: <linux-iio+bounces-9969-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9623E98C559
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 20:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AC311F245B2
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 18:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38311CCEF7;
	Tue,  1 Oct 2024 18:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEebGQXU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C651CCEE0;
	Tue,  1 Oct 2024 18:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807363; cv=none; b=IQlCHhDCZRbhs0uk1zcZP9D59XSFm80TDlbk61QEvfpqF+7XM2Tn/q1VFIRvBXnlKd3FBA5TPBqgjg0GuYau9ZNnff5Kc+hbLez2w6ID7vLRzWAxM0ahlK8hcu785ylxJoSUSWF5BLf05HhNwRcwQeFGGRud5iiVgbcgg9voA3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807363; c=relaxed/simple;
	bh=KARCicZZFTRtFNo2aBcQJTnCExQNXjt1GZEnTdfDsyg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uvllHoPHTgiE4NQDVgYwgohBSRKHdMBItWXDF+E7Xiv698/KQJllfALOWxSdg/ez+ovsMuLO9y7AgH47aORjK7ACFs8umyWb4Z6ncmQHNK1dsY9ZYHgKcguDj28MyY01NBdNCfp3hWCA4O+33Id5EgfxRj1R8sg2xVnmAzk+a44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEebGQXU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EA1C4CEC6;
	Tue,  1 Oct 2024 18:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727807363;
	bh=KARCicZZFTRtFNo2aBcQJTnCExQNXjt1GZEnTdfDsyg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZEebGQXUVhwatPtuszAnghhsu1UrZ0VS+vy0P37IHP8yIBem+CkzLE98D+9GUqFbX
	 1FL6lq8A+p8RWBEcD0bSj62I6CMDFu79402a1yFVwiQCyHyXFVMqO8Kud6P4K1AJWf
	 yzQEOv3naSt3VWG/0JmPH2g5JBUIsgQbDb0OU5wPiS01Tw/5VUkbY6b94Si/vrix4U
	 dcY3oRHb/CIetu00Vx1+6IYD6vdAHbHgEmbBF12eV86uY3l6f+cdikTrnNJl0XQcPE
	 OM5rbmyIFPQZchu9x0DRtjXOBM2p0lJ+1DEue7oJ7nkvUXqCmdCfGTxh0vDJVt7OZO
	 NRfgHvQK2E4hw==
Date: Tue, 1 Oct 2024 19:29:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Angelo Dureghello 
 <adureghello@baylibre.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Lars-Peter Clausen	 <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa	 <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan	 <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH v3 04/10] dt-bindings: iio: dac: ad3552r: add io-backend
 support
Message-ID: <20241001192913.5b848dfc@jic23-huawei>
In-Reply-To: <80eb0949508d31a55f2b8ab999210a7c7cd5cbe2.camel@gmail.com>
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-4-a17b9b3d05d9@baylibre.com>
	<gojq6ardhvt6vcs2kawdhdn2cj6qbpzp4p5mjjgwsypuatm5eo@3u6k4q7le46s>
	<418a8a9b-3bcf-4b8f-92a0-619a3bf26ab5@baylibre.com>
	<e8af0f3f-a09c-42d7-b8ca-dd633539af73@kernel.org>
	<0279203b6cd9f1312d9c03654c262c04ac12fbd9.camel@gmail.com>
	<fa27dc74-7b1f-4ef5-81dc-cc434da4ff89@kernel.org>
	<c721861809c17776c0fe89ead331b6e2e6b9d4b4.camel@gmail.com>
	<28834db1-3e9e-47f4-b00e-a548589d77e9@kernel.org>
	<20240929115919.0318034c@jic23-huawei>
	<ae4cfdfb9880e0a833c105fcb9e9442ef04f461b.camel@gmail.com>
	<h7ajn5c7f4d7xtjd6jwayen2v5go2vyciwfebikoxlnksodvd2@4dph5nxigi56>
	<20240930160947.00007c8a@Huawei.com>
	<80eb0949508d31a55f2b8ab999210a7c7cd5cbe2.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 01 Oct 2024 10:23:45 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2024-09-30 at 16:09 +0100, Jonathan Cameron wrote:
> > On Mon, 30 Sep 2024 15:22:01 +0200
> > Angelo Dureghello <adureghello@baylibre.com> wrote:
> >  =20
> > > On 30.09.2024 09:20, Nuno S=C3=A1 wrote: =20
> > > > On Sun, 2024-09-29 at 11:59 +0100, Jonathan Cameron wrote:=C2=A0  =
=20
> > > > > On Sat, 28 Sep 2024 14:20:29 +0200
> > > > > Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > > > =C2=A0  =20
> > > > > > On 25/09/2024 13:55, Nuno S=C3=A1 wrote:=C2=A0  =20
> > > > > > > On Wed, 2024-09-25 at 09:22 +0200, Krzysztof Kozlowski wrote:=
=C2=A0=C2=A0=C2=A0  =20
> > > > > > > > On 24/09/2024 14:27, Nuno S=C3=A1 wrote:=C2=A0=C2=A0=C2=A0 =
 =20
> > > > > > > > > On Tue, 2024-09-24 at 10:02 +0200, Krzysztof Kozlowski wr=
ote:=C2=A0=C2=A0=C2=A0 =20
> > > > > > > > > > On 23/09/2024 17:50, Angelo Dureghello wrote:=C2=A0=C2=
=A0=C2=A0  =20
> > > > > > > > > > > Hi Krzysztof,
> > > > > > > > > > >=20
> > > > > > > > > > > On 22/09/24 23:02, Krzysztof Kozlowski wrote:=C2=A0=
=C2=A0=C2=A0  =20
> > > > > > > > > > > > On Thu, Sep 19, 2024 at 11:20:00AM +0200, Angelo
> > > > > > > > > > > > Dureghello
> > > > > > > > > > > > wrote:=C2=A0=C2=A0=C2=A0  =20
> > > > > > > > > > > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > There is a version AXI DAC IP block (for FPGAs) t=
hat
> > > > > > > > > > > > > provides
> > > > > > > > > > > > > a physical bus for AD3552R and similar chips, and=
 acts
> > > > > > > > > > > > > as
> > > > > > > > > > > > > an SPI controller.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > For this case, the binding is modified to include=
 some
> > > > > > > > > > > > > additional properties.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Signed-off-by: Angelo Dureghello
> > > > > > > > > > > > > <adureghello@baylibre.com>
> > > > > > > > > > > > > ---
> > > > > > > > > > > > > =C2=A0 .../devicetree/bindings/iio/dac/adi,ad3552=
r.yaml=C2=A0=C2=A0 |
> > > > > > > > > > > > > 42
> > > > > > > > > > > > > ++++++++++++++++++++++
> > > > > > > > > > > > > =C2=A0 1 file changed, 42 insertions(+)
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > diff --git
> > > > > > > > > > > > > a/Documentation/devicetree/bindings/iio/dac/adi,a=
d3552r.
> > > > > > > > > > > > > yaml
> > > > > > > > > > > > > b/Documentation/devicetree/bindings/iio/dac/adi,a=
d3552r.
> > > > > > > > > > > > > yaml
> > > > > > > > > > > > > index 41fe00034742..aca4a41c2633 100644
> > > > > > > > > > > > > ---
> > > > > > > > > > > > > a/Documentation/devicetree/bindings/iio/dac/adi,a=
d3552r.
> > > > > > > > > > > > > yaml
> > > > > > > > > > > > > +++
> > > > > > > > > > > > > b/Documentation/devicetree/bindings/iio/dac/adi,a=
d3552r.
> > > > > > > > > > > > > yaml
> > > > > > > > > > > > > @@ -60,6 +60,18 @@ properties:
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ref: /schemas/typ=
es.yaml#/definitions/uint32
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum: [0, 1, 2, 3]
> > > > > > > > > > > > > =C2=A0=20
> > > > > > > > > > > > > +=C2=A0 io-backends:
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0 description: The iio backend =
reference.
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 An example backen=
d can be found at
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > > > > > > > > https://analogdevicesinc.github.io/hdl/library/ax=
i_ad3552r/index.html
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +=C2=A0 adi,synchronous-mode:
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0 description: Enable waiting f=
or external
> > > > > > > > > > > > > synchronization
> > > > > > > > > > > > > signal.
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Some AXI IP confi=
guration can implement a dual-IP
> > > > > > > > > > > > > layout,
> > > > > > > > > > > > > with
> > > > > > > > > > > > > internal
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wirings for strea=
ming synchronization.
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0 type: boolean
> > > > > > > > > > > > > +
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 '#address-cells':
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const: 1
> > > > > > > > > > > > > =C2=A0=20
> > > > > > > > > > > > > @@ -128,6 +140,7 @@ patternProperties:
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 - custom-output-range-config
> > > > > > > > > > > > > =C2=A0=20
> > > > > > > > > > > > > =C2=A0 allOf:
> > > > > > > > > > > > > +=C2=A0 - $ref: /schemas/spi/spi-peripheral-props=
.yaml#
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 - if:
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 proper=
ties:
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 compatible:
> > > > > > > > > > > > > @@ -238,4 +251,33 @@ examples:
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 };
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +=C2=A0 - |
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0 axi_dac: spi@44a70000 {
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compa=
tible =3D "adi,axi-ad3552r";=C2=A0=C2=A0=C2=A0  =20
> > > > > > > > > > > > That is either redundant or entire example should g=
o to
> > > > > > > > > > > > the
> > > > > > > > > > > > parent
> > > > > > > > > > > > node,
> > > > > > > > > > > > if this device is fixed child of complex device (IO=
W,
> > > > > > > > > > > > adi,ad3552r
> > > > > > > > > > > > cannot
> > > > > > > > > > > > be used outside of adi,axi-ad3552r).=C2=A0=C2=A0=C2=
=A0  =20
> > > > > > > > > > >=20
> > > > > > > > > > > ad3552r can still be used by a generic "classic" spi
> > > > > > > > > > > controller (SCLK/CS/MISO) but at a slower samplerate,=
 fpga
> > > > > > > > > > > controller only (axi-ad3552r) can reach 33MUPS.=C2=A0=
=C2=A0=C2=A0  =20
> > > > > > > > > >=20
> > > > > > > > > > OK, then this is just redundant. Drop the node. Parent =
example
> > > > > > > > > > should
> > > > > > > > > > contain the children, though.=C2=A0=C2=A0=C2=A0  =20
> > > > > > > > > > > =C2=A0=C2=A0  =20
> > > > > > > > > > > > =C2=A0=C2=A0  =20
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =
=3D <0x44a70000 0x1000>;
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dmas =
=3D <&dac_tx_dma 0>;
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma-n=
ames =3D "tx";
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #io-b=
ackend-cells =3D <0>;
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock=
s =3D <&ref_clk>;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #addr=
ess-cells =3D <1>;
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size=
-cells =3D <0>;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dac@0=
 {
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 compatible =3D "adi,ad3552r";
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 reg =3D <0>;
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 reset-gpios =3D <&gpio0 92 0>;=C2=A0=C2=A0=C2=A0  =20
> > > > > > > > > > > > Use standard defines for GPIO flags.=C2=A0=C2=A0=C2=
=A0  =20
> > > > > > > > > > >=20
> > > > > > > > > > > fixed, thanks
> > > > > > > > > > > =C2=A0=C2=A0  =20
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 io-backends =3D <&axi_dac>;=C2=A0=C2=A0=C2=A0  =20
> > > > > > > > > > > > Why do you need to point to the parent? How much co=
upled
> > > > > > > > > > > > are
> > > > > > > > > > > > these
> > > > > > > > > > > > devices? Child pointing to parent is not usually ex=
pected,
> > > > > > > > > > > > because
> > > > > > > > > > > > that's obvious.=C2=A0=C2=A0=C2=A0  =20
> > > > > > > > > > >=20
> > > > > > > > > > >=20
> > > > > > > > > > > "io-backends" is actually the way to refer to the bac=
kend
> > > > > > > > > > > module,
> > > > > > > > > > > (used already for i.e. ad9739a),
> > > > > > > > > > > it is needed because the backend is not only acting a=
s spi-
> > > > > > > > > > > controller,
> > > > > > > > > > > but is also providing some APIs for synchronization a=
nd bus
> > > > > > > > > > > setup
> > > > > > > > > > > support.=C2=A0=C2=A0=C2=A0  =20
> > > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > But if backend is the parent, then this is redundant. Y=
ou can
> > > > > > > > > > take
> > > > > > > > > > it
> > > > > > > > > > from the child-parent relationship. Is this pointing to=
 other
> > > > > > > > > > devices
> > > > > > > > > > (non-parent) in other ad3552r configurations?
> > > > > > > > > > =C2=A0=C2=A0  =20
> > > > > > > > >=20
> > > > > > > > > The backend is a provider-consumer type of API. On the co=
nsumer
> > > > > > > > > side
> > > > > > > > > (which
> > > > > > > > > is the
> > > > > > > > > driver the child node will probe on), we need to call
> > > > > > > > > devm_iio_backend_get()
> > > > > > > > > to get
> > > > > > > > > the backend object (which obviously is the parent). For t=
hat,
> > > > > > > > > 'io-
> > > > > > > > > backends'
> > > > > > > > > is being=C2=A0=C2=A0=C2=A0  =20
> > > > > > > >=20
> > > > > > > > You described the driver, so how does it matter? Driver can=
 call
> > > > > > > > get_backend_from_parent(), right? Or
> > > > > > > > get_backend_from_fwnode(parent)?=C2=A0=C2=A0=C2=A0  =20
> > > > > > >=20
> > > > > > > Well yes, just stating what the framework (also in terms of
> > > > > > > bindings) is
> > > > > > > expecting. Of course that on the driver side we can paper aro=
und it
> > > > > > > the
> > > > > > > way we
> > > > > > > want. But my main point was that we can only paper around it =
if we
> > > > > > > use
> > > > > > > code that
> > > > > > > is meant not to be used.
> > > > > > >=20
> > > > > > > And, FWIW, I was (trying) replying to your comment
> > > > > > >=20
> > > > > > > "You can take it from the child-parent relationship"
> > > > > > >=20
> > > > > > > Again, we can only do that by introducing new code or use code
> > > > > > > that's not
> > > > > > > meant
> > > > > > > to be used. The way we're supposed to reference backends is by
> > > > > > > explicitly
> > > > > > > using
> > > > > > > the proper FW property.
> > > > > > >=20
> > > > > > > Put it in another way and a completely hypothetical case. If =
we have
> > > > > > > a spi
> > > > > > > controller which happens to export some clock and one of it's
> > > > > > > peripherals
> > > > > > > ends
> > > > > > > up using that clock, wouldn't we still use 'clocks' to refere=
nce
> > > > > > > that
> > > > > > > clock?=C2=A0=C2=A0=C2=A0  =20
> > > > > >=20
> > > > > > I asked how coupled are these devices. Never got the answer and=
 you
> > > > > > are
> > > > > > reflecting with question. Depends. Please do not create hypothe=
tical,
> > > > > > generic scenarios and then apply them to your one particular op=
posite
> > > > > > case.=C2=A0  =20
> > > > >=20
> > > > > I'll throw a possible clarifying question in here.=C2=A0 Could we=
 use this
> > > > > device with a multimaster SPI setup such that the control is on a
> > > > > conventional
> > > > > SPI controller (maybe a qspi capable one), and the data plane onl=
y goes
> > > > > through
> > > > > a specific purpose backend?=C2=A0 If so, then they are not tightl=
y coupled
> > > > > and
> > > > > the reference makes sense.=C2=A0 Putting it another way, the diff=
erence
> > > > > between
> > > > > this case and all the prior iio-backend bindings is the control a=
nd
> > > > > dataplanes
> > > > > use the same pins.=C2=A0 Does that have to be the case at the hos=
t end?=C2=A0 If
> > > > > it
> > > > > does,
> > > > > then the reference isn't strictly needed and this becomes a bit l=
ike
> > > > > registering a single device on an spi bus or an i2c bus depending=
 on who
> > > > > does the registering (which is down to the parent in DT).
> > > > > =C2=A0  =20
> > > >=20
> > > > So, we currently have two drivers (with a new one being added in th=
is
> > > > series)
> > > > for the same device:
> > > >=20
> > > > 1) A SPI one tied to a typical spi controller. This is the "low spe=
ed"
> > > > implementation and does not use backends;
> > > > 2) The new platform device that is connected like this to the backe=
nd.
> > > >=20
> > > > So yes, my understanding (but Angelo should know better :)) is that=
 they
> > > > are
> > > > tightly coupled. Putting it in another way, the new platform device=
 is
> > > > very much
> > > > specific to this parent (and yeah, this is a very special usecase w=
here
> > > > control
> > > > and data planes are controlled by the IIO backend) and should not e=
xist
> > > > with it.=C2=A0  =20
> > >=20
> > > ad3552r device can be coupled to the axi-ad3552r controller or to a g=
eneric=20
> > > spi controler.
> > >=20
> > > We have actually 2 drivers, SPI and platform (for AXI controller, in =
this
> > > patch).
> > >=20
> > > Scenario 1 (SPI):
> > > ad3522r can hypotetically work with whatever simple spi controller th=
at can
> > > read/write registers in raw mode. On simple SPI (CS, SCLK, MOSI), due=
 to
> > > ad3552r
> > > chip limitation of 66Mhz clock, the maximum 33MUPS (16 bit samples) c=
annot
> > > be
> > > reached. Some QSPI DDR controller seems to be around, in that case, a=
d3552r
> > > may work extending the SPI driver.=20
> > >=20
> > > Scenario 2 (AXI):
> > > From an hardware-only point ov view axi-ad3552r IP acts as QSPI+DDR
> > > controller
> > > plus some additional features for stream synchronization.
> > > From a sowftware point of view, really different from a spi controller
> > > driver.
> > > It's just a backend with APIes that can be called from the child driv=
er. =20
> >=20
> > Potential? scenario 3 is the one that interested me.
> >=20
> > ad3552 double wired to a normal SPI controller (so like option 1) and
> > to a an offload engine (so like option 2).=C2=A0 With a few pull up res=
istors
> > (cs and clk?) and some care it should electrically work I think.
> > In that case we'd need the io-backend reference because the parent
> > would be the option 1 like SPI bus and the io-backend would not be
> > the parent.
> >=20
> > _______________________
> > Host=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SPI MOSI=C2=A0=C2=A0=C2=A0 |--=
-----------------\
> > hard=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SPI MISO 0-3|----------------\=
=C2=A0 |
> > QSPI=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SPI CLK=C2=A0=C2=A0=C2=A0=C2=
=A0 |--------------\=C2=A0 | |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SPI CS=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |----------\=C2=A0=C2=A0=C2=A0 | | |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 | | |
> > FPGA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 | | |=C2=A0=C2=A0 |
> > Soft=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SPI MOSI=C2=A0=C2=A0=C2=A0 |--=
---------|---|-|-x---|
> > QSPI=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SPI MISO 0-3|-----------|---|-=
x-----|=C2=A0 DAC
> > Offload=C2=A0=C2=A0=C2=A0 SPI CLK=C2=A0=C2=A0=C2=A0=C2=A0 |-----------|=
---x-------|
> > with DDR=C2=A0=C2=A0 SPI CS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |-----------x=
-----------|
> > _______________________|
> >=20
> > Makes all sorts of assumptions about the SPI controllers being designed
> > for multi controllers on the same SPI buses but I'm not aware of a reas=
on
> > you can't do that.
> >=20
> > As the only control message that would need to go over the offload engi=
ne
> > would be the exit DDR (I think) that might be hard coded into a slightly
> > simpler soft IP along with the bulk data transfer stuff.
> >  =20
>=20
> Not even sure if DDR would be a problem. Right now, I __think__ we need to
> enable DDR both the peripheral and on the backend. On the peripheral we c=
ould
> use the control link on the non offload controller. On the offload contro=
ller,
> we would set it through IIO backend and that would be a backend config an=
d not
> go over the bus.

It's the path back to SDR that I wasn't sure about as it might need a
DDR register write?

>=20
> To make a correction on my previous reply to Krzysztof, the HW folks made=
 some
> experiments with the SPI ENIGINE IP (with the offload engine) but without=
 the
> AXI DAC IP. So, effectively only one controller in place. That said, I'm =
also
> not seeing any reason why something like the above would not be possible.

Conclusion / summary for Krzystoff and other DT binding
folk. It's possible to use this with another backend (which no one has
written the IP for yet) so I (at least) think the reference is needed
even though the only one we have right now is also the parent.

Driver wise, we could in theory poke the parent if the property isn't there
on the off chance it is a suitable backend, but we can't assume that's
the one in use even if it has some suitable support.  Maybe there
is a more capable one double wired?

So I'd like to keep the io-backend phandle there.

Jonathan


>=20
> - Nuno S=C3=A1
>=20


