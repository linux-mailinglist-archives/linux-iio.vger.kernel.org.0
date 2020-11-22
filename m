Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908B82BC725
	for <lists+linux-iio@lfdr.de>; Sun, 22 Nov 2020 17:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgKVQfF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Nov 2020 11:35:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:53770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727956AbgKVQfF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Nov 2020 11:35:05 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA08220781;
        Sun, 22 Nov 2020 16:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606062904;
        bh=80thntpECFCP6s5qq7E3FGWGUjwzkuuisXkpDW/pYL4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I7G99ElT+YcnS/kemhG8zMxr/tStMzQTQ6Qs1/HiY6gn/qqU9sljZA/qRE+VxLeXX
         dNkuq8+5Lpt/v+ysC4cJdmGbYwfDfNKT6m7R28JTZPD7IrlJjt75GRYrHIC4GJfoYp
         ESZqSm03/QplXtH4ujrhZTrmJRteowQvVTJEwz3Y=
Date:   Sun, 22 Nov 2020 16:35:00 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Phil Reid <preid@electromag.com.au>
Cc:     Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 02/46] dt-bindings:iio:potentiometer:adi,ad5272 yaml
 conversion
Message-ID: <20201122163500.4c699fcc@archlinux>
In-Reply-To: <66e8db5d-cc37-dde9-7d55-770d54506e3d@electromag.com.au>
References: <20201031184854.745828-1-jic23@kernel.org>
        <20201031184854.745828-3-jic23@kernel.org>
        <20201103161039.GA1754553@bogus>
        <20201103172834.00007040@Huawei.com>
        <bc4219af-d77b-0f39-025d-d8905f35b574@electromag.com.au>
        <CAL_JsqLAtMQhsUDG=amAG7i9mMzYq9UTDLMFRrGKOHr5rb3L+A@mail.gmail.com>
        <a6685d81-d09a-1372-cc17-96f66c87ffbe@electromag.com.au>
        <66e8db5d-cc37-dde9-7d55-770d54506e3d@electromag.com.au>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 9 Nov 2020 10:56:47 +0800
Phil Reid <preid@electromag.com.au> wrote:

> On 4/11/2020 12:53, Phil Reid wrote:
> > On 4/11/2020 11:12, Rob Herring wrote: =20
> >> On Tue, Nov 3, 2020 at 6:39 PM Phil Reid <preid@electromag.com.au> wro=
te: =20
> >>>
> >>> On 4/11/2020 01:28, Jonathan Cameron wrote: =20
> >>>> On Tue, 3 Nov 2020 10:10:39 -0600
> >>>> Rob Herring <robh@kernel.org> wrote:
> >>>> =20
> >>>>> On Sat, Oct 31, 2020 at 06:48:10PM +0000, Jonathan Cameron wrote: =
=20
> >>>>>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>>>>>
> >>>>>> Simple direct conversion from txt to yaml as part of a general aim=
 of
> >>>>>> converting all IIO bindings to this machine readable format.
> >>>>>>
> >>>>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>>>>> Cc: Phil Reid <preid@electromag.com.au>
> >>>>>> ---
> >>>>>> =C2=A0=C2=A0 .../bindings/iio/potentiometer/ad5272.txt=C2=A0=C2=A0=
=C2=A0=C2=A0 | 27 ----------
> >>>>>> =C2=A0=C2=A0 .../iio/potentiometer/adi,ad5272.yaml=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 50 +++++++++++++++++++
> >>>>>> =C2=A0=C2=A0 2 files changed, 50 insertions(+), 27 deletions(-)
> >>>>>>
> >>>>>> diff --git a/Documentation/devicetree/bindings/iio/potentiometer/a=
d5272.txt b/Documentation/devicetree/bindings/iio/potentiometer/ad5272.txt
> >>>>>> deleted file mode 100644
> >>>>>> index f9b2eef946aa..000000000000
> >>>>>> --- a/Documentation/devicetree/bindings/iio/potentiometer/ad5272.t=
xt
> >>>>>> +++ /dev/null
> >>>>>> @@ -1,27 +0,0 @@
> >>>>>> -* Analog Devices AD5272 digital potentiometer
> >>>>>> -
> >>>>>> -The node for this device must be a child node of a I2C controller=
, hence
> >>>>>> -all mandatory properties for your controller must be specified. S=
ee directory:
> >>>>>> -
> >>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Documentation/devicetr=
ee/bindings/i2c
> >>>>>> -
> >>>>>> -for more details.
> >>>>>> -
> >>>>>> -Required properties:
> >>>>>> -=C2=A0=C2=A0 - compatible:=C2=A0=C2=A0 Must be one of the followi=
ng, depending on the model:
> >>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adi,ad5272-020
> >>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adi,ad5272-050
> >>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adi,ad5272-100
> >>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adi,ad5274-020
> >>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adi,ad5274-100
> >>>>>> -
> >>>>>> -Optional properties:
> >>>>>> - - reset-gpios: GPIO specification for the RESET input. This is an
> >>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acti=
ve low signal to the AD5272.
> >>>>>> -
> >>>>>> -Example:
> >>>>>> -ad5272: potentiometer@2f {
> >>>>>> -=C2=A0=C2=A0 reg =3D <0x2F>;
> >>>>>> -=C2=A0=C2=A0 compatible =3D "adi,ad5272-020";
> >>>>>> -=C2=A0=C2=A0 reset-gpios =3D <&gpio3 6 GPIO_ACTIVE_HIGH>;
> >>>>>> -};
> >>>>>> diff --git a/Documentation/devicetree/bindings/iio/potentiometer/a=
di,ad5272.yaml b/Documentation/devicetree/bindings/iio/potentiometer/adi,ad=
5272.yaml
> >>>>>> new file mode 100644
> >>>>>> index 000000000000..b9b7d383bff1
> >>>>>> --- /dev/null
> >>>>>> +++ b/Documentation/devicetree/bindings/iio/potentiometer/adi,ad52=
72.yaml
> >>>>>> @@ -0,0 +1,50 @@
> >>>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >>>>>> +%YAML 1.2
> >>>>>> +---
> >>>>>> +$id: http://devicetree.org/schemas/iio/potentiometer/adi,ad5272.y=
aml#
> >>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>>>> +
> >>>>>> +title: Analog Devices AD5272 digital potentiometer
> >>>>>> +
> >>>>>> +maintainers:
> >>>>>> +=C2=A0 - Phil Reid <preid@electromag.com.au>
> >>>>>> +
> >>>>>> +description: |
> >>>>>> +=C2=A0 Datasheet: https://www.analog.com/en/products/ad5272.html
> >>>>>> +
> >>>>>> +properties:
> >>>>>> +=C2=A0 compatible:
> >>>>>> +=C2=A0=C2=A0=C2=A0 enum:
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,ad5272-020
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,ad5272-050
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,ad5272-100
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,ad5274-020
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,ad5274-100
> >>>>>> +
> >>>>>> +=C2=A0 reg:
> >>>>>> +=C2=A0=C2=A0=C2=A0 maxItems: 1
> >>>>>> +
> >>>>>> +=C2=A0 reset-gpios:
> >>>>>> +=C2=A0=C2=A0=C2=A0 description:
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Active low signal to the AD5272 RE=
SET input. =20
> >>>>>
> >>>>> Not a new problem, but active low or...
> >>>>> =20
> >>>>>> +
> >>>>>> +additionalProperties: false
> >>>>>> +
> >>>>>> +required:
> >>>>>> +=C2=A0 - compatible
> >>>>>> +=C2=A0 - reg
> >>>>>> +
> >>>>>> +examples:
> >>>>>> +=C2=A0 - |
> >>>>>> +=C2=A0=C2=A0=C2=A0 #include <dt-bindings/gpio/gpio.h>
> >>>>>> +=C2=A0=C2=A0=C2=A0 i2c {
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <1>;
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <0>;
> >>>>>> +
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 potentiometer@2f {
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 compatible =3D "adi,ad5272-020";
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 reg =3D <0x2F>;
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 reset-gpios =3D <&gpio3 6 GPIO_ACTIVE_HIGH>; =20
> >>>>>
> >>>>> active high? =20
> >>>>
> >>>> Good spot!=C2=A0 @Phil.=C2=A0 Looks like the driver is setting the r=
eset line to
> >>>> 0 and then to 1 to come out of reset.=C2=A0=C2=A0 So effectively inv=
erting the logic.
> >>>> I'm tempted to be cynical and suggest we just drop the comment above=
 and leave
> >>>> it vague but is there a better way we can clarify this? =20
> >>>
> >>> Had a look at a few other iio drivers in regards how they handle the =
same thing.
> >>> A few do the same thing, ie: the drivers are written to set gpio low =
to assert reset.
> >>> So they need the device tree gpio config to be active high to work co=
rrectly.
> >>> Not sure if this prevents users setting things up as open collector. =
=20
> >>
> >> The driver is wrong. 'gpiod_set_value(reset_gpio, 1);' should assert
> >> reset as '1' here is set to (reset) active state as defined in the DT.
> >>
> >> Given no upstream users, maybe it can be fixed...
> >>
> >> We need to make 'reset-gpios' implemented by a reset controller and
> >> stop letting drivers get it wrong.
> >> =20
> >=20
> > Yes I agree, the driver is wrong, think I just copied one of the other =
drivers for the pattern.
> > I'd be happy to change it, there's probably few (if any) users.
> >=20
> > Having a software interface to assert the reset would be nice.
> >=20
> >  =20
>=20
> If there's no comments against the change, I'll submit a patch in the nex=
t day or so.
Hi Phil,=20

So I've fixed the binding example up to have the sense as ACTIVE_LOW as dis=
cussed.
If you have time to flip the sense round in the driver to match that it
would be great and I'd propose we then mark that as suitable for stable
so that we get it backported into existing trees.  We could also spin
a patch to the txt binding but perhaps that is more effort than is needed
here.  If I get time before you do I might send a proposed fix patch.

Hopefully anyone then using it will get the sense right and we won't
accidentally break anyone.

At some point soon I'll also try and audit similar cases and hopefully we
will get those fixed up as well.  Obviously if anyone else wants to take
a look at that it would be much appreciated!

Thanks,

Jonathan


>=20
>=20

