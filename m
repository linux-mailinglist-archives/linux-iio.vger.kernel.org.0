Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588522A2189
	for <lists+linux-iio@lfdr.de>; Sun,  1 Nov 2020 21:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgKAUdK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Nov 2020 15:33:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726848AbgKAUdK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Nov 2020 15:33:10 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F65E2074B;
        Sun,  1 Nov 2020 20:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604262789;
        bh=Rsye7QUjvJS3aX3U+FuexfQNr/bhORV1HStpYysAvTU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Veip5ugdGBH3SRl+LoFmohyCG85pzO0U2tpj97XnExe4YGlFy4Gi5HNF3+qfs1neg
         uayODmVQkxpMloMF5cAthCWZiTY3wBgTZ/l+PhYUvKFNngcgVvqpqBOXuPhuZVou5w
         ZzVsdUVDU6nrJo9ALmsCAobTv3JVm2xDoLaaWFtA=
Date:   Sun, 1 Nov 2020 20:33:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Philippe Reynes <tremyfr@yahoo.fr>
Subject: Re: [PATCH 07/10] dt-bindings:iio:adc:maxim,max1027: Pull out to
 separate binding doc.
Message-ID: <20201101203304.1abf4a77@archlinux>
In-Reply-To: <20201101142557.153c7b97@xps13>
References: <20201031181242.742301-1-jic23@kernel.org>
        <20201031181242.742301-8-jic23@kernel.org>
        <20201101142557.153c7b97@xps13>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 1 Nov 2020 14:25:57 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Jonathan,
>=20
> Jonathan Cameron <jic23@kernel.org> wrote on Sat, 31 Oct 2020 18:12:39
> +0000:
>=20
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > The afe/voltage-divider.yaml example uses this device with 2 properties
> > not provided by trivial-devices.yaml (spi-max-frequency and #io-channel=
-cells)
> >=20
> > Solve that by creating a more specific binding doc. =20
>=20
> I don't know #io-channel-cells but spi-max-frequency is very common and
> is related to the fact that this device is a SPI device (hence, a SPI
> subnode), IMHO it has nothing to do with trivial-devices.yaml
> description.

There may be some logic to adding spi-max-frequency to the allowed properti=
es
of devices listed in trivial-devices.  Right now it's not there so you will
get warnings if you check a dts file that has it in for bindings described
by that file.  I've been lazy here, but ideally we also want to document
a maximum for this property.  In this case, it should be 10000000 (10MHz).
I'll add that to this binding either in v2, or whilst applying.

The io-channel-cells, is specific to devices proving analog channel measure=
ment
services that other bindings can make use of.  (typically ADCs and DACs).
Currently only applies to IIO bindings for ADCs and DACs.
It specifies how many parameters are needed as part of the phandle to ident=
ify
a channel.

Given most of trivial devices don't fall into that category, we need to do
a separate binding where it's known to be used anyway.

As a side note.. I just noticed these devices have reference voltage pins.
At somepoint (not necessarily now) we should look at adding appropriate reg=
ulator
bindings.

Jonathan

>=20
> >=20
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> > Cc: Philippe Reynes <tremyfr@yahoo.fr>
> > ---
> >  .../bindings/iio/adc/maxim,max1027.yaml       | 64 +++++++++++++++++++
> >  .../devicetree/bindings/trivial-devices.yaml  | 12 ----
> >  2 files changed, 64 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1027.ya=
ml b/Documentation/devicetree/bindings/iio/adc/maxim,max1027.yaml
> > new file mode 100644
> > index 000000000000..09e853c50c76
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1027.yaml
> > @@ -0,0 +1,64 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/maxim,max1027.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Maxim MAX1027 and similar ADCs
> > +
> > +maintainers:
> > +  - Miquel Raynal <miquel.raynal@bootlin.com>
> > +  - Philippe Reynes <tremyfr@yahoo.fr>
> > +
> > +description: |
> > +  300ks/s SPI ADCs with temperature sensors.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +        # 10-bit 8 channels
> > +      - maxim,max1027
> > +        # 10-bit 12 channels
> > +      - maxim,max1029
> > +        # 10-bit 16 channels
> > +      - maxim,max1031
> > +         # 12-bit 8 channels
> > +      - maxim,max1227
> > +         # 12-bit 12 channels
> > +      - maxim,max1229
> > +         # 12-bit 16 channels
> > +      - maxim,max1231
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency: true
> > +
> > +  "#io-channel-cells":
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    spi {
> > +       #address-cells =3D <1>;
> > +       #size-cells =3D <0>;
> > +        maxadc: adc@0 {
> > +            compatible =3D "maxim,max1027";
> > +            reg =3D <0>;
> > +            #io-channel-cells =3D <1>;
> > +            interrupt-parent =3D <&gpio5>;
> > +            interrupts =3D <15 IRQ_TYPE_EDGE_RISING>;
> > +            spi-max-frequency =3D <1000000>;
> > +        };
> > +    };
> > +...
> > diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/D=
ocumentation/devicetree/bindings/trivial-devices.yaml
> > index d154ea97e30d..185e09e61e16 100644
> > --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> > +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> > @@ -108,18 +108,6 @@ properties:
> >            - isil,isl68137
> >              # 5 Bit Programmable, Pulse-Width Modulator
> >            - maxim,ds1050
> > -            # 10-bit 8 channels 300ks/s SPI ADC with temperature sensor
> > -          - maxim,max1027
> > -            # 10-bit 12 channels 300ks/s SPI ADC with temperature sens=
or
> > -          - maxim,max1029
> > -            # 10-bit 16 channels 300ks/s SPI ADC with temperature sens=
or
> > -          - maxim,max1031
> > -            # 12-bit 8 channels 300ks/s SPI ADC with temperature sensor
> > -          - maxim,max1227
> > -            # 12-bit 12 channels 300ks/s SPI ADC with temperature sens=
or
> > -          - maxim,max1229
> > -            # 12-bit 16 channels 300ks/s SPI ADC with temperature sens=
or
> > -          - maxim,max1231
> >              # Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
> >            - maxim,max1237
> >              # PECI-to-I2C translator for PECI-to-SMBus/I2C protocol co=
nversion =20
>=20
> Thanks,
> Miqu=C3=A8l

