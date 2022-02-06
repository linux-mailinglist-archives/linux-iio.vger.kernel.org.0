Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0244AB129
	for <lists+linux-iio@lfdr.de>; Sun,  6 Feb 2022 19:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345432AbiBFSH3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Feb 2022 13:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiBFSH3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Feb 2022 13:07:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFFDC06173B
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 10:07:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A63F2B80E29
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 18:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B34C340E9;
        Sun,  6 Feb 2022 18:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644170845;
        bh=qJwqX7WE5FCJ+SglaaTAMDtDUBmbc+83f92x7aT1UXg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dzsrx2w+ulkN4GMPg32TzppNfhTxwMYjPpXPM85sqOsCojKUJGIOjamUyYOTomYZY
         g+BLN2/rcfR42KIwNweg2q1HQNHYf6rSoetzeJw3udr3LmJwxRe+xphTmPiIqgftkx
         9+na27fDSnHw6J/xqzoUiMBHQkwqT10TlmcxJZqmE2auFHSkmjZ3s3ffk3EVLubOeZ
         d9wIA9IrjraJPckAHL5jaaWT494Or0Wn0xqtxw2sl48afWvqDvhXILkYwbqNbNWJ5c
         X6TTRvjgN3+MZp8MSUftvc6UYNy1Xm9zbBwlhjRoUU8miq7WgiKNfLZkaaFBlU3hum
         h/9H9i5XHEqgQ==
Date:   Sun, 6 Feb 2022 18:13:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        lars@metafoo.de, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 15/17] dt-bindings:iio:adc:ad7280a: Add binding
Message-ID: <20220206181357.62b871a4@jic23-huawei>
In-Reply-To: <Yf8y+U0BVK/WOTl/@marsc.168.1.7>
References: <20211205202710.2847005-1-jic23@kernel.org>
        <20211205202710.2847005-16-jic23@kernel.org>
        <Yb5QFJmFoc8EM5Zd@marsc.168.1.7>
        <20220130202914.53a02f26@jic23-huawei>
        <Yf8y+U0BVK/WOTl/@marsc.168.1.7>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 5 Feb 2022 23:31:21 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 01/30, Jonathan Cameron wrote:
> > On Sat, 18 Dec 2021 18:18:12 -0300
> > Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> >  =20
> > > Think it would be more intuitive to use the number of active channels=
 as enum
> > > elements for adi,temp-alert-last-chan and adi,voltage-alert-last-chan=
. =20
> >=20
> > Just to check I understand correctly, you mean active number of channels
> > across all devices, or just in the last device? =20
>=20
> I was thinking about the number of channels enabled for alert detection o=
nly in
> the last device.
> For voltage inputs, we would have 6, 5, or 4 channels enabled. So the pos=
sible
> values for adi,voltage-alert-last-chan would be [4, 5, 6], default: 6.
> For temperature inputs, things get a bit hairy.
> * We may have all 6 AUX enabled.
> * We may have 3 AUX enabled if D15:D14 =3D 01 in the control register. If=
 so, we still may:
>   + disable AUX5, or
>   + disable AUX5 and AUX3
> So the possibilities for adi,temp-alert-last-chan would be 1, 2, 3, or 6 =
AUX
> channels enabled for alert detection.

Glad I just dropped support for that ;)

For the voltage one I'm going to leave it as adi,voltage-alert-last-chan
because I'm not sure what naming would work if we changed it to number supp=
orted
because it feels like adi,voltage-alert-last-num-chan is weird and I don't =
want
complexity of adi,voltage-alert-num-chans as that would have to include the
channels on previous devices and if we ever support the 1,3,5 mode the two =
will couple
in a horrible fashion.

=46rom a lazy point of view, if I don't touch this I can avoid bothering Rob =
again
as I feel like I can drop the temperature one without removing his RB, but
would have to ask him to take another look if we change the way the other o=
ne works.

So all in all, lets go with good enough for this one rather than looping ar=
ound
trying to find perfect.

Thanks,

Jonathan

>=20
> >=20
> > If all devices it would get tricky to handle because if set to a value
> > before the last device I'm not sure how we'd handle it.
> >=20
> > Or do you mean just index in that device form 1, so when we disable
> > VIN5 we still have VIN0,1,2,3,4 so 5 devices? =20
>=20
> You mean the index of the last channel (of the last device) enabled to ge=
nerate alerts?
> For voltage inputs, I guess that would end up almost the same as for the =
number
> of active channels. For temperature inputs, AUX6, AUX5, AUX3, or AUX1 wou=
ld be
> the last channels enabled to generate alerts in each of the above cases.
> Taking just the indexes: 1, 3, 5, 6.
> This seems harder to explain, though.
>=20
> >=20
> > The AUX version as per earlier patch is a real pain to describe. If
> > we do support it we'll probably just have to fall back to strings
> > or similar which isn't nice.
> >=20
> > Jonathan
> >  =20
> > > This, though, is just my personal opinion so=20
> > > Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > >=20
> > > On 12/05, Jonathan Cameron wrote: =20
> > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > >=20
> > > > Add a binding for this Lithium Ion Battery monitoring chip/chain of=
 chips
> > > > as it is now clean and ready to move out of staging.
> > > >=20
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > >  .../bindings/iio/adc/adi,ad7280a.yaml         | 87 +++++++++++++++=
++++
> > > >  1 file changed, 87 insertions(+)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7280a.=
yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7280a.yaml
> > > > new file mode 100644
> > > > index 000000000000..77b8f67fe446
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7280a.yaml
> > > > @@ -0,0 +1,87 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/iio/adc/adi,ad7280a.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Analog Devices AD7280a Lithium Ion Battery Monitoring System
> > > > +
> > > > +maintainers:
> > > > +  - Michael Hennerich <michael.hennerich@analog.com>
> > > > +  - Jonathan Cameron <jic23@kernel.org>
> > > > +
> > > > +description: |
> > > > +  Bindings for the Analog Devices AD7280a Battery Monitoring Syste=
m.
> > > > +  Used in devices such as hybrid electric cars, battery backup and=
 power tools.
> > > > +  Multiple chips can be daisy chained and accessed via a single SP=
I interface.
> > > > +  Data sheet found here:
> > > > +    https://www.analog.com/media/en/technical-documentation/data-s=
heets/AD7280A.pdf
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: adi,ad7280a
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  interrupts:
> > > > +    description: IRQ line for the ADC
> > > > +    maxItems: 1
> > > > +
> > > > +  spi-max-frequency: true
> > > > +
> > > > +  adi,temp-alert-last-chan:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    description:
> > > > +      Allows limiting of scope of which channels are considered fo=
r temperature
> > > > +      alerts, typically because not all are wired to anything. Onl=
y applies to
> > > > +      last device in the daisy chain.
> > > > +    default: 5
> > > > +    enum: [3, 4, 5]
> > > > +
> > > > +  adi,voltage-alert-last-chan:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    description:
> > > > +      Allows limiting of scope of which channels are considered fo=
r voltage
> > > > +      alerts, typically because not all are wired to anything. Onl=
y applies to
> > > > +      last device in the daisy chain.
> > > > +    default: 5
> > > > +    enum: [3, 4, 5]
> > > > +
> > > > +  adi,acquisition-time-ns:
> > > > +    description:
> > > > +      Additional time may be needed to charge the sampling capacit=
ors depending
> > > > +      on external writing.
> > > > +    default: 400
> > > > +    enum: [400, 800, 1200, 1600]
> > > > +
> > > > +  adi,thermistor-termination:
> > > > +    type: boolean
> > > > +    description:
> > > > +      Enable the thermistor termination function.
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    spi {
> > > > +      #address-cells =3D <1>;
> > > > +      #size-cells =3D <0>;
> > > > +
> > > > +      adc@0 {
> > > > +        compatible =3D "adi,ad7280a";
> > > > +        reg =3D <0>;
> > > > +        spi-max-frequency =3D <700000>;
> > > > +        interrupt-parent =3D <&gpio>;
> > > > +        interrupts =3D <25 2>;
> > > > +        adi,thermistor-termination;
> > > > +        adi,acquisition-time-ns =3D <800>;
> > > > +        adi,voltage-alert-last-chan =3D <5>;
> > > > +        adi,temp-alert-last-chan =3D <5>;
> > > > +      };
> > > > +    };
> > > > +...
> > > > --=20
> > > > 2.34.1
> > > >    =20
> >  =20

