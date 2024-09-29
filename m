Return-Path: <linux-iio+bounces-9866-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA569894F1
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 12:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83B481F21001
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 10:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7B41607A4;
	Sun, 29 Sep 2024 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgCMFkUI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A256157488;
	Sun, 29 Sep 2024 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727607569; cv=none; b=Gvmak30YZdD/ojF8uqdf6UCdKew5nWO45Gwnu7gELQT3VW0ND96eOkXPDs/xSZ+wM/KoBt6Hvo7bcdTGmetW9QWLY4Mx3E7y7qesTsmPUX9pwo1Z6lxyJGo4GmCgXDpUCpWIN+UVQN2s70CYUUGksgoeW6xiq2ZCNLstvhHbI70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727607569; c=relaxed/simple;
	bh=8PxiiVHFr6alTnXpOXhsL8EY8MJiUBtIx6q20tJt3bI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rx1w/BU7cuvPyMO9awe0QSmzjHqd28kulvW9ccjZU4Z+fFC7RA+n8AhjK22ILK70SGzFSNxbVGyqWuQmHtfB9FgSfWvEcOxaPzjIe5Sknf1KN4pDQWuZX7oSPtlf2DNHjE2pfeU4bGYM3iBwwxwHPTjvGAuOqPGYa/i16Jl2IFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgCMFkUI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC78C4CEC5;
	Sun, 29 Sep 2024 10:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727607569;
	bh=8PxiiVHFr6alTnXpOXhsL8EY8MJiUBtIx6q20tJt3bI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kgCMFkUIqAB1yKGI3XgPNKPQbxPDm1a26rR74pzkU/Bd/XzNcAjnsj+JstLNbgZUj
	 U8WdxCQkF5m/yDIPgSUf0Y+Dh/Hy++joZv9Ttf0QGjvA0mg8KTqelnRvxqiQdQiqAc
	 gfV6yfIyqhbhkCnQz9dD+o072PGlx3I1btUtoiI+NsNg2WsWgfndOY2gaNf/sDSydM
	 3Vb4fXhgvG+Z5BwDfA2vHtsd/9/f5JpauMpidKhJqgpj1FKdW1aMa0rMqOup2Rli0z
	 zSBBS9taF5/COVd1v320xxiYe5qoDhwOHZNxvOtaTXjcatgNDWnoiV10rSKp139LNd
	 cAqB9HVn7FsZA==
Date: Sun, 29 Sep 2024 11:59:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH v3 04/10] dt-bindings: iio: dac: ad3552r: add io-backend
 support
Message-ID: <20240929115919.0318034c@jic23-huawei>
In-Reply-To: <28834db1-3e9e-47f4-b00e-a548589d77e9@kernel.org>
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
	<20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-4-a17b9b3d05d9@baylibre.com>
	<gojq6ardhvt6vcs2kawdhdn2cj6qbpzp4p5mjjgwsypuatm5eo@3u6k4q7le46s>
	<418a8a9b-3bcf-4b8f-92a0-619a3bf26ab5@baylibre.com>
	<e8af0f3f-a09c-42d7-b8ca-dd633539af73@kernel.org>
	<0279203b6cd9f1312d9c03654c262c04ac12fbd9.camel@gmail.com>
	<fa27dc74-7b1f-4ef5-81dc-cc434da4ff89@kernel.org>
	<c721861809c17776c0fe89ead331b6e2e6b9d4b4.camel@gmail.com>
	<28834db1-3e9e-47f4-b00e-a548589d77e9@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 28 Sep 2024 14:20:29 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 25/09/2024 13:55, Nuno S=C3=A1 wrote:
> > On Wed, 2024-09-25 at 09:22 +0200, Krzysztof Kozlowski wrote: =20
> >> On 24/09/2024 14:27, Nuno S=C3=A1 wrote: =20
> >>> On Tue, 2024-09-24 at 10:02 +0200, Krzysztof Kozlowski wrote: =20
> >>>> On 23/09/2024 17:50, Angelo Dureghello wrote: =20
> >>>>> Hi Krzysztof,
> >>>>>
> >>>>> On 22/09/24 23:02, Krzysztof Kozlowski wrote: =20
> >>>>>> On Thu, Sep 19, 2024 at 11:20:00AM +0200, Angelo Dureghello wrote:=
 =20
> >>>>>>> From: Angelo Dureghello <adureghello@baylibre.com>
> >>>>>>>
> >>>>>>> There is a version AXI DAC IP block (for FPGAs) that provides
> >>>>>>> a physical bus for AD3552R and similar chips, and acts as
> >>>>>>> an SPI controller.
> >>>>>>>
> >>>>>>> For this case, the binding is modified to include some
> >>>>>>> additional properties.
> >>>>>>>
> >>>>>>> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> >>>>>>> ---
> >>>>>>> =C2=A0 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml=C2=A0=C2=
=A0 | 42
> >>>>>>> ++++++++++++++++++++++
> >>>>>>> =C2=A0 1 file changed, 42 insertions(+)
> >>>>>>>
> >>>>>>> diff --git
> >>>>>>> a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> >>>>>>> b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> >>>>>>> index 41fe00034742..aca4a41c2633 100644
> >>>>>>> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> >>>>>>> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> >>>>>>> @@ -60,6 +60,18 @@ properties:
> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/definit=
ions/uint32
> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum: [0, 1, 2, 3]
> >>>>>>> =C2=A0=20
> >>>>>>> +=C2=A0 io-backends:
> >>>>>>> +=C2=A0=C2=A0=C2=A0 description: The iio backend reference.
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 An example backend can be found at
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> >>>>>>> https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.=
html
> >>>>>>> +=C2=A0=C2=A0=C2=A0 maxItems: 1
> >>>>>>> +
> >>>>>>> +=C2=A0 adi,synchronous-mode:
> >>>>>>> +=C2=A0=C2=A0=C2=A0 description: Enable waiting for external sync=
hronization
> >>>>>>> signal.
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Some AXI IP configuration can imp=
lement a dual-IP layout,
> >>>>>>> with
> >>>>>>> internal
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wirings for streaming synchroniza=
tion.
> >>>>>>> +=C2=A0=C2=A0=C2=A0 type: boolean
> >>>>>>> +
> >>>>>>> =C2=A0=C2=A0=C2=A0 '#address-cells':
> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const: 1
> >>>>>>> =C2=A0=20
> >>>>>>> @@ -128,6 +140,7 @@ patternProperties:
> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 - custom-output-range-config
> >>>>>>> =C2=A0=20
> >>>>>>> =C2=A0 allOf:
> >>>>>>> +=C2=A0 - $ref: /schemas/spi/spi-peripheral-props.yaml#
> >>>>>>> =C2=A0=C2=A0=C2=A0 - if:
> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible:
> >>>>>>> @@ -238,4 +251,33 @@ examples:
> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 };
> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> >>>>>>> +
> >>>>>>> +=C2=A0 - |
> >>>>>>> +=C2=A0=C2=A0=C2=A0 axi_dac: spi@44a70000 {
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adi,a=
xi-ad3552r"; =20
> >>>>>> That is either redundant or entire example should go to the parent
> >>>>>> node,
> >>>>>> if this device is fixed child of complex device (IOW, adi,ad3552r
> >>>>>> cannot
> >>>>>> be used outside of adi,axi-ad3552r). =20
> >>>>>
> >>>>> ad3552r can still be used by a generic "classic" spi
> >>>>> controller (SCLK/CS/MISO) but at a slower samplerate, fpga
> >>>>> controller only (axi-ad3552r) can reach 33MUPS. =20
> >>>>
> >>>> OK, then this is just redundant. Drop the node. Parent example should
> >>>> contain the children, though. =20
> >>>>> =20
> >>>>>> =20
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x44a70000 0=
x1000>;
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dmas =3D <&dac_tx_dma=
 0>;
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma-names =3D "tx";
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #io-backend-cells =3D=
 <0>;
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&ref_clk>;
> >>>>>>> +
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <1=
>;
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <0>;
> >>>>>>> +
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dac@0 {
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 compatible =3D "adi,ad3552r";
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 reg =3D <0>;
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 reset-gpios =3D <&gpio0 92 0>; =20
> >>>>>> Use standard defines for GPIO flags. =20
> >>>>>
> >>>>> fixed, thanks
> >>>>> =20
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 io-backends =3D <&axi_dac>; =20
> >>>>>> Why do you need to point to the parent? How much coupled are these
> >>>>>> devices? Child pointing to parent is not usually expected, because
> >>>>>> that's obvious. =20
> >>>>>
> >>>>>
> >>>>> "io-backends" is actually the way to refer to the backend module,
> >>>>> (used already for i.e. ad9739a),
> >>>>> it is needed because the backend is not only acting as spi-controll=
er,
> >>>>> but is also providing some APIs for synchronization and bus setup
> >>>>> support. =20
> >>>>
> >>>>
> >>>> But if backend is the parent, then this is redundant. You can take it
> >>>> from the child-parent relationship. Is this pointing to other devices
> >>>> (non-parent) in other ad3552r configurations?
> >>>> =20
> >>>
> >>> The backend is a provider-consumer type of API. On the consumer side =
(which
> >>> is the
> >>> driver the child node will probe on), we need to call devm_iio_backen=
d_get()
> >>> to get
> >>> the backend object (which obviously is the parent). For that, 'io-bac=
kends'
> >>> is being =20
> >>
> >> You described the driver, so how does it matter? Driver can call
> >> get_backend_from_parent(), right? Or get_backend_from_fwnode(parent)? =
=20
> >=20
> > Well yes, just stating what the framework (also in terms of bindings) is
> > expecting. Of course that on the driver side we can paper around it the=
 way we
> > want. But my main point was that we can only paper around it if we use =
code that
> > is meant not to be used.
> >=20
> > And, FWIW, I was (trying) replying to your comment
> >=20
> > "You can take it from the child-parent relationship"
> >=20
> > Again, we can only do that by introducing new code or use code that's n=
ot meant
> > to be used. The way we're supposed to reference backends is by explicit=
ly using
> > the proper FW property.
> >=20
> > Put it in another way and a completely hypothetical case. If we have a =
spi
> > controller which happens to export some clock and one of it's periphera=
ls ends
> > up using that clock, wouldn't we still use 'clocks' to reference that c=
lock? =20
>=20
> I asked how coupled are these devices. Never got the answer and you are
> reflecting with question. Depends. Please do not create hypothetical,
> generic scenarios and then apply them to your one particular opposite cas=
e.

I'll throw a possible clarifying question in here.  Could we use this
device with a multimaster SPI setup such that the control is on a conventio=
nal
SPI controller (maybe a qspi capable one), and the data plane only goes thr=
ough
a specific purpose backend?  If so, then they are not tightly coupled and
the reference makes sense.  Putting it another way, the difference between
this case and all the prior iio-backend bindings is the control and datapla=
nes
use the same pins.  Does that have to be the case at the host end?  If it d=
oes,
then the reference isn't strictly needed and this becomes a bit like
registering a single device on an spi bus or an i2c bus depending on who
does the registering (which is down to the parent in DT).

Jonathan


>=20
> Best regards,
> Krzysztof
>=20


