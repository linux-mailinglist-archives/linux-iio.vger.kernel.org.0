Return-Path: <linux-iio+bounces-5635-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7A28D7676
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 16:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31741C2155C
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 14:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11F74205D;
	Sun,  2 Jun 2024 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLRxmIH9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DB4B64B;
	Sun,  2 Jun 2024 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717340087; cv=none; b=hpD6JRMka//uMThKp3/8O0BvaudMJzK1jpvQG8Mb8MxpmLSytwpx9uhw8Z/by5BN/JqME6mTcQq33jNLVJ8m9Iw8ivwlre2pdHoJjuN9km9qVIejJsduRrs4C7MAYhh3NA2BFyzbTqy2mBuowlGaNuiRvafaMiTajjl7HDTJ2Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717340087; c=relaxed/simple;
	bh=4U4YmaXrfCSnRq6hU0SodnHHoTrXCl2DLZ6mtKKZuSA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=olLQo6m1N0PIeTnzZSRVkikBAzGbpmUtcxU7vZoCovN88kaVA38Wc5FyF1VpfQiM99IebK3CmRTR7Rkolxu+/lrw20sQNjYyEJ6S207VbkxJwaV88wg+YPWyf9l2+Dz+VPk6Uo1f5Ju1g1M5fZLZmJvzqHhefKOVD2/G5IGuzzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLRxmIH9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DCCC2BBFC;
	Sun,  2 Jun 2024 14:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717340086;
	bh=4U4YmaXrfCSnRq6hU0SodnHHoTrXCl2DLZ6mtKKZuSA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cLRxmIH9m1BuW/csKx8DXPRM7Q8FsPiXMfdtWBJDpP3kl1hpQm8ZPmSAgxE1iVosF
	 wD7bL469WfRv+0shSH9nE5Robm0HYM5wyM/VUslwJL5CN8SHu6Igo2eCb7gBe78aIx
	 giNTZejRLrGhRPCoAD2pVmVNWHkg3vD9WqQcJg1TxgCUWQ9f/lIDLUKG92h3tZUU6M
	 c6UyPNAUzpmTAcSNWLalBI6bTeA6etInr0qP1nsRmPRjYVFm6swx5qxwGKHUOTy68T
	 ivszjb0cEEzPuPmJxP1XjILczklJRbaHclX1tP6aav9JTW0YklQseCWdat9F6Q90Un
	 e9HG3QYaI99dA==
Date: Sun, 2 Jun 2024 15:54:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, =?UTF-8?B?Sm/Do28=?= Paulo
 =?UTF-8?B?R29uw6dhbHZlcw==?= <jpaulo.silvagoncalves@gmail.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <joao.goncalves@toradex.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Francesco Dolcini
 <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: add ti,ads1119
Message-ID: <20240602155433.621837ec@jic23-huawei>
In-Reply-To: <20240528-engaging-plop-e5d20a1a3fd1@spud>
References: <20240527154050.24975-1-francesco@dolcini.it>
	<20240527154050.24975-2-francesco@dolcini.it>
	<20240527-ecosystem-mountable-d9a6eebc7607@spud>
	<20240528150440.GA15947@francesco-nb>
	<20240528-engaging-plop-e5d20a1a3fd1@spud>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 May 2024 17:14:38 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Tue, May 28, 2024 at 05:04:40PM +0200, Francesco Dolcini wrote:
> > On Mon, May 27, 2024 at 05:29:37PM +0100, Conor Dooley wrote: =20
> > > On Mon, May 27, 2024 at 05:40:49PM +0200, Francesco Dolcini wrote: =20
> > > > From: Jo=C3=A3o Paulo Gon=C3=A7alves <joao.goncalves@toradex.com>
> > > >=20
> > > > Add devicetree bindings for Texas Instruments ADS1119 16-bit ADC
> > > > with I2C interface.
> > > >=20
> > > > Datasheet: https://www.ti.com/lit/gpn/ads1119
> > > > Signed-off-by: Jo=C3=A3o Paulo Gon=C3=A7alves <joao.goncalves@torad=
ex.com>
> > > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > ---
> > > >  .../bindings/iio/adc/ti,ads1119.yaml          | 122 ++++++++++++++=
++++
> > > >  MAINTAINERS                                   |   7 +
> > > >  2 files changed, 129 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ad=
s1119.yaml
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1119.y=
aml b/Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
> > > > new file mode 100644
> > > > index 000000000000..ab4f01199dbe
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
> > > > @@ -0,0 +1,122 @@ =20
> >=20
> > ...
> >  =20
> > > > +patternProperties:
> > > > +  "^channel@([0-6])$":
> > > > +    $ref: adc.yaml
> > > > +    type: object
> > > > +    description: |
> > > > +      ADC channels.
> > > > +
> > > > +    properties:
> > > > +      reg:
> > > > +        description: |
> > > > +          0: Voltage over AIN0 and AIN1.
> > > > +          1: Voltage over AIN2 and AIN3.
> > > > +          2: Voltage over AIN1 and AIN2.
> > > > +          3: Voltage over AIN0 and GND.
> > > > +          4: Voltage over AIN1 and GND.
> > > > +          5: Voltage over AIN2 and GND.
> > > > +          6: Voltage over AIN3 and GND. =20
> > >=20
> > > Take a look at diff-channels. =20
> >=20
> > Yes, we looked at this and at the beginning we did not think this was a
> > right idea. This is pretty much copying what is done in
> > Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml.
That's a very old binding :(  We are stuck with a bunch of legacy unfortuna=
tely.

> >=20
> > We could describe this using the diff-channels, however the MUX in the
> > ADS1119 cannot do any combination, but only a subset (AIN0-AIN1,
> > AIN2-AIN3 and AIN1-AIN2).

That's fairly common. So far it's been restricted by documentation
rather than the binding enforcing it.

> >=20
> > Are you aware of a way to validate this in the DT? =20
>=20
> I'm not sure of a neat way to restrict the options like that, no.
Hmm. It's not super tidy but I think it can be done.

Firstly 3-6 are single-channel anyway. There are some ways of ensuring
we have only single-channel or differential-channels in a given channel nod=
e.
I took a quick look and the one binding I have that does both today doesn't
actually restrict that :(=20
This one that we have under review does though:=20
https://lore.kernel.org/all/20240531-ad4111-v4-1-64607301c057@analog.com/
(in that case the mux is fully flexible so it doesn't have this next bit)


    diff-channels:
      oneOf:
        - items:
            const: 0
            const: 1
        - items
            const: 2
            const: 3
        - items
            const: 1
            const: 2

>=20
> > Would something like that work? =20
>=20
> This looks fine to me, but a look from Jonathan would be good.
>=20
> >=20
> > adc@40 {
> >     compatible =3D "ti,ads1119";
> >     reg =3D <0x40>;
> >     #address-cells =3D <1>;
> >     #size-cells =3D <0>;
> >     #io-channel-cells =3D <1>;
> >    =20
> >     channel@0 {
> >         reg =3D <0>;
> >         diff-channels =3D <3 4>;
> > 	label =3D "AIN0_AIN1"
> >     };
> >    =20
> >     channel@1 {
> >         reg =3D <1>;
> >         diff-channels =3D <5 6>;
> > 	label =3D "AIN2_AIN3"
> >     };
> >    =20
> >     channel@2 {
> >         reg =3D <2>;
> >         diff-channels =3D <4 5>;
> > 	label =3D "AIN1_AIN2"
> >     };
> >    =20
> >     channel@3 {
> >         reg =3D <3>;
> > 	label =3D "AIN0"

Use the new single-channel so that 'reg' isn't a weird
magic value. In combined cases with single ended and differential
channels, it's better to just use reg as an index rather than assign
it any real meaning.

> >     };
> >    =20
> >     channel@4 {
> >         reg =3D <4>;
> > 	label =3D "AIN1"
> >     };
> >    =20
> >     channel@5 {
> >         reg =3D <5>;
> > 	label =3D "AIN2"
> >     };
> >    =20
> >     channel@6 {
> >         reg =3D <6>;
> > 	label =3D "AIN3"
> >     };
> > };
> >=20
> >  =20
> > > > +        items:
> > > > +          - minimum: 0
> > > > +            maximum: 6
> > > > +
> > > > +      ti,gain: =20
> > >=20
> > > What makes this a property of the hardware?
> > > Also, missing unit. =20
> >=20
> > This is a hardware gain from the ADC and it is dimensionless. =20
>=20
> Maybe I phrased my question incorrectly. I'll try again:
> What makes the gain a fixed property of the hardware?
>=20
> I guess I was expecting to see a gain in decibels, but w/e.
> What do 1 and 4 represent here?

Agreed - this is normally userspace controlled not dt.
>=20
> > > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > > +        description:
> > > > +          PGA gain value.
> > > > +        enum: [1, 4]
> > > > +        default: 1
> > > > +
> > > > +      ti,datarate: =20
> > >=20
> > > Ditto here, why's this a property of the hardware? Usually this gets =
set
> > > from sysfs.. =20
> >=20
> > The sample rate is a hardware property, you can configure the ADC device
> > to do the acquisition at a specific rate. =20
>=20
> Same thing here, poorly phrased question from me I think. Why is this is
> a fixed property of the hardware, rather than something that a user may
> want to control? Last time I saw one of these kind of properties,
> Jonathan commented:
> | It's unusual for sampling rate to be a property of the hardware and hen=
ce
> | suitable for DT binding. Normally we make this a userspace control inst=
ead.
> | If there is a reason for doing it from DT, that wants to be mentioned h=
ere.
>=20
> > Both these properties are inspired from
> > Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml.
> >=20
> > We could do what you are suggesting here. I am just a concerned on how
> > this interacts with the iio/afe/ bindings. Specifically, how could I
> > configure the gain or the data rate when this ADC is used by a
> > voltage-divider? Maybe iio-rescale driver needs to be extended for such
> > use case? =20
>=20
> For configuring the gain in that scenario, you probably need Jonathan or
> Peter to comment on, I'm not sure how the sysfs controls work for that.
> I'm not sure what a voltage divider would have to do with the data rate,
> so I guess this is something related to how the sysfs files are
> structured?

So this is a question of providing services.  The ADC is servicing the
measurement of the analog front end.  So the analog front end can control
the features of how it is serviced byt the ADC.  Those are just pass
through controls to the underlying device (with some corner cases
where the AFE is part of the parameter dealt with)

If the AFE driver doesn't yet support this, then fine to extend it.
Mostly they pass through standard ABI but so far read only.
For simple cases like this should be fine to add the write path.
Gain control will be a little fiddly as you'll need to remove the AFE compo=
nent
to work out what to write to the ADC + figure out how to provide
_available info so that userspace can understand that it can control this.

If you care about the voltage-divider and buffered capture there will
be more to do as that path isn't wired up yet I think.

Jonathan

> Again, it'll probably be Jonathan or one of the guys that
> actually deals with the userspace side of things (I haven't beyond a
> trivial application) that'll have to answer that.
>=20
> Thanks,
> Conor.


