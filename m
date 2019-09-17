Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDA77B4526
	for <lists+linux-iio@lfdr.de>; Tue, 17 Sep 2019 03:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732696AbfIQBJd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 21:09:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728842AbfIQBJc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Sep 2019 21:09:32 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C24021670;
        Tue, 17 Sep 2019 01:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568682571;
        bh=fy/Yj7D0JMYGgR/5cOxmQk+QBj3CjG0LhWKNnbzh91I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nGEk+HgKy6+/Xv8qVVw1/uT+4PxoGaT/eWOL/yu/jVbR46o6ovQJH0uPGxm9riV3b
         gnRe9xfl1WmyEIpNAsK5/zCdVELUc/lxknpkqnXOh7c2Ji3anN7e7frT+ASPsXTXV4
         SVd8XVhEd9X9djp5aDh5qxLHbva43Z42U0zvcnLA=
Received: by mail-qk1-f171.google.com with SMTP id 201so2023411qkd.13;
        Mon, 16 Sep 2019 18:09:31 -0700 (PDT)
X-Gm-Message-State: APjAAAVuTbvhV84Jjy6BlH+NNlZq9FK1qt+VI88dfTGyCeWR5QGNlHaB
        3F9V+N8b9aXh2Sf0afy4xZQ234sUrYubstCwBg==
X-Google-Smtp-Source: APXvYqzBG8t7y7qlLXYIic/a+/x0kVPFJtCRfGBx9Q/SE/qWJeH0V5NGhGa1Vw8JScX43jaJsHA28bIUCqQzSih2acU=
X-Received: by 2002:a37:682:: with SMTP id 124mr1168784qkg.393.1568682570392;
 Mon, 16 Sep 2019 18:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190909144550.164488-1-nuno.sa@analog.com> <20190909144550.164488-2-nuno.sa@analog.com>
 <20190912173046.GA22533@bogus> <20190915120750.7a4d3bcd@archlinux> <1835e5760ad916b44dca9107c7f6f9b33b605769.camel@analog.com>
In-Reply-To: <1835e5760ad916b44dca9107c7f6f9b33b605769.camel@analog.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 16 Sep 2019 20:09:18 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJK0UvCsCxxknLRUsx39d_iwGThK9M7ji4a9wvWk_QJiQ@mail.gmail.com>
Message-ID: <CAL_JsqJK0UvCsCxxknLRUsx39d_iwGThK9M7ji4a9wvWk_QJiQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: iio: Add ltc2983 documentation
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "jic23@kernel.org" <jic23@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lars@metafoo.de" <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Sep 16, 2019 at 10:20 AM Sa, Nuno <Nuno.Sa@analog.com> wrote:
>
> Hi Rob and Jonathan,
>
> Some comments/questions inline.
>
> Nuno S=C3=A1
>
> On Sun, 2019-09-15 at 12:07 +0100, Jonathan Cameron wrote:
> >
> > On Fri, 13 Sep 2019 15:36:21 +0100
> > Rob Herring <robh@kernel.org> wrote:
> >
> > > On Mon, Sep 09, 2019 at 04:45:50PM +0200, Nuno S=C3=A1 wrote:
> > > > Document the LTC2983 temperature sensor devicetree bindings.
> > > >
> > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > > ---
> > > >  .../bindings/iio/temperature/adi,ltc2983.yaml | 442
> > > > ++++++++++++++++++
> > > >  MAINTAINERS                                   |   1 +
> > > >  2 files changed, 443 insertions(+)
> > > >  create mode 100644
> > > > Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yam
> > > > l
> > > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.y
> > > > aml
> > > > b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.y
> > > > aml
> > > > new file mode 100644
> > > > index 000000000000..2b468b3ed177
> > > > --- /dev/null
> > > > +++
> > > > b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.y
> > > > aml
> > > > @@ -0,0 +1,442 @@
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +%YAML 1.2
> > > > +---
> > > > +$id:
> > > > http://devicetree.org/schemas/iio/temperature/adi,ltc2983.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Analog Devices LTC2983 Multi-sensor Temperature system
> > > > +
> > > > +maintainers:
> > > > +  - Nuno S=C3=A1 <nuno.sa@analog.com>
> > > > +
> > > > +description: |
> > > > +  Analog Devices LTC2983 Multi-Sensor Digital Temperature
> > > > Measurement System
> > > > +
> > > > https://www.analog.com/media/en/technical-documentation/data-sheets=
/2983fc.pdf
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - adi,ltc2983
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  interrupts:
> > > > +    maxItems: 1
> > > > +
> > > > +  adi,temperature-celcius:
> > > > +    description:
> > > > +      If this property is present, the temperature is reported
> > > > in Celsius.
> > > > +    type: boolean
> > > > +    maxItems: 1
> > >
> > > It's a boolean, not an array so 'maxItems' doesn't make sense.
> > >
> > > Running 'make dt_binding_check' should tell you this. You may need
> > > to
> > > update dt-schema install though.
>
> Rob, I'm having some issues with `make dt_binding_check`. I updated dt-
> schema and I get this when run it:
>
> ...
> "ruamel.yaml.constructor.DuplicateKeyError: while constructing a
> mapping
>   in "<unicode string>", line 4, column 1
> found duplicate key "patternProperties" with value "{}" (original
> value: "{}")
>   in "<unicode string>", line 113, column 1"

Simply drop all but the first 'patternProperties'. You can have
multiple patterns under one.

>
> If you want, I can paste the complete traceback in a following email.
> However I could use `dt-doc-validate
> Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml`
> directly by doing a manual change in `dt-doc-validate `. I changed the
> call `testtree =3D dtschema.load(filename, line_number=3Dline_number,
> duplicate_keys=3DFalse)` to `testtree =3D dtschema.load(filename,
> line_number=3Dline_number, duplicate_keys=3DTrue)`. Is this something
> already known? I would not be surprised if it is some problem in my
> environment. However, I even tried this in a clean docker container
> based on ubuntu 18.04 and got the same behavior.

[...]

> > > > +patternProperties:
> > > > +  "^rtd@([2-9]|1[0-9]|20)$":
> > > > +    type: object
> > > > +    description: Represents a rtd sensor which is connected to
> > > > one of the device channels.
> > > > +
> > > > +    properties:
> > > > +      reg:
> > > > +        description: |
> > > > +          The channel number. It can be connected to one of the
> > > > 20 channels of the device.
> > > > +        minimum: 2
> > > > +        maximum: 20
> > > > +        maxItems: 1
> > >
> > > As this is pretty much the same for all child nodes, make a pattern
> > > that
> > > matches all child nodes and put this there rather than duplicating
> > > it.
> > > Then you only need 'minimum: 2' in the cases needing that.
>
> I'm not sure I'm following your point here. So it's better to clarify
> it before sending a v2. Do you mean to add something like:
>
> patternProperties:
>   "^(thermocouple|diode|rtd|thermistor|adc|rsense)@([1-9]|1[0-9]|20)$"

Just ".*@([1-9]|1[0-9]|20)$" is fine.

>     type: object
>
>     properties:
>       reg:
>        description: |
>          The channel number. It can be connected to one of the 20
> channels of the device.
>        minimum: 1
>        maximum: 20
>
> And then, for instance, for a RTD I would have:
>
> patternProperties:
>   "^rtd@([2-9]|1[0-9]|20)$"

You've already defined the unit-address format above, so '^rtd@.*'
would be sufficient here.

>
>     ...
>
>     properties:
>       reg:
>        minimum: 2
>
>     ...
>
> Would this also make sense, or it's not really necessary?

Yes, makes sense.

>
> patternProperties:
>   "^thermocouple@([1-9]|1[0-9]|20)$"
>     type: object
>
>     ...
>
>     properties:
>       reg:
>        description: For differential thermocouples, the minimum is 2.

Why do you have a constraint in free form text here?

>
>     ...
>
> Am I understanding it correctly?
> > > > +thermistor
> > > > +      adi,sensor-type:
> > > > +        description: |
> > > > +          Identifies the type of RTD connected to the device.
> > > > +        allOf:
> > > > +          - $ref: /schemas/types.yaml#/definitions/uint32
> > > > +          - enum: [10 11 12 13 14 15 16 17]
> > > > +        maxItems: 1
> > > > +
> > > > +      adi,rsense-handle:
> > > > +        description: |
> > > > +          Phandle pointing to a rsense object associated with
> > > > this RTD.
> > > > +        $ref: "/schemas/types.yaml#/definitions/phandle"
> > > > +        maxItems: 1
> > > > +
> > > > +      adi,sensor-config:
> > > > +        description: |
> > > > +          Raw value which set's the sensor configuration. Look
> > > > at table 28 of the
> > > > +          datasheet for how to set this value for RTD's.
> > > > +        allOf:
> > > > +          - $ref: /schemas/types.yaml#/definitions/uint32
> > > > +          - enum: [0 1 4 5 8 9 10 12 13 14]
> > > > +        maxItems: 1
> > > > +
> > > > +      adi,excitation-current:
> > > > +        description: |
> > > > +          This property controls the magnitude of the excitation
> > > > current applied
> > > > +          to the RTD. Look at table 29 of the datasheet for more
> > > > info.
> >
> > Any way we can make this real units?  Can list valid value here.
>
> For RTD's and diodes, it is possible to have it with real units.
> However, for thermistors it's not really doable since, for instance,
> for them we have an "Auto Range" setting. So, I just wanted to be
> consistent through all sensors having excitation-current configuration.
> Do you prefer to have it in real units where possible?

That's the preference if it makes sense. I have no idea what an RTD is
to comment further.

Rob
