Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BECB3A4632
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 18:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhFKQOT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 12:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhFKQOS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Jun 2021 12:14:18 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037ADC061574;
        Fri, 11 Jun 2021 09:12:20 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id w4so9361687qvr.11;
        Fri, 11 Jun 2021 09:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=GvuoX69Nuq63veUJF4SqwgyIUp4P98m0NbOWsJhG3Ko=;
        b=lM4eXdBve8GlhbQchMynOELGgrMDJbGYWsqv2ujumpv2QxsiqTTn0F78L9Z0X66eTj
         60ZsWeHJrIF8vkw1y1U+rO215qPfeoPfns3U+iX9GTmP6FKTRYuoVzB8L5RDA4H8bAo/
         k5ly9ISWH/ORP8FP72YJxKmu7HvOQQk6qqgU6Lidt5zttOO2q5Mnf67mOUlJs93XnvU5
         h9iht2sHHOXeoeblBbw15P2AJHAdjbITOD8VbcQOEls4ORTLIrOUaB/U2oalayzHU2xT
         RWhvzwbCrCO1yZZwAu/9b+YBG3FHqQAEIXF/L+Ar9rJQEXs4sPI9dicpqlTM//HchJTG
         305Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=GvuoX69Nuq63veUJF4SqwgyIUp4P98m0NbOWsJhG3Ko=;
        b=H+iuucqxh0S8iOYRFWdss6kC+hENcG1vF66plNOaB1Dt9xzf0+NmkL4GFbIXyhGboe
         rDBt5x6dZWo7sJDmuaY2yeEDBqt1V76IuncB6aqPFibCHKwN1iMFl6uYO4lfqv8Zn1J5
         BBUCray0iAFnoQHlChQ+CMv95ZiyGFW9DH0N1DKTyYHvsWRXvSmASmpzvwz/PAiqhRlv
         ZTNa2QVRzwXmmRGwBC5nAVoInKogTQLz1HnGP4mfeGS5Xdy+G8CcQCAg1SXCfJcg3/HJ
         LbIFl067gxjNTp3K1w1IJnqHNa0ugKqhAawMvE4O+SxS+6LGxU+CxqyLxfiFlYmvj+4m
         IvPw==
X-Gm-Message-State: AOAM532TpELtbyIukKVkEkuFvAd/AMbgjtf0JAHNDD49TILADw8Tpp1D
        LM67ZMh61XyHDxu6hyDv1LH3E+mwJVANig==
X-Google-Smtp-Source: ABdhPJxmsQxanEOeyNMKzQ9JtbT2y9KCQ8G2YXSxGqCrkuR75Jxon1jqjf8NFX4b1AYVE34FNfdetA==
X-Received: by 2002:ad4:5569:: with SMTP id w9mr5565650qvy.59.1623427939087;
        Fri, 11 Jun 2021 09:12:19 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id u123sm4653079qkh.83.2021.06.11.09.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 09:12:18 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Jun 2021 12:12:17 -0400
Message-Id: <CC0X6APQPBSY.1NUHSF8F0HWE1@shaak>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v2 8/8] dt-bindings: iio: afe: add binding for
 temperature-sense-amplifier
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Peter Rosin" <peda@axentia.se>, <jic23@kernel.org>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
References: <20210607144718.1724413-1-liambeguin@gmail.com>
 <20210607144718.1724413-9-liambeguin@gmail.com>
 <6973b6b1-eb49-24f5-d9fb-053cb4744196@axentia.se>
In-Reply-To: <6973b6b1-eb49-24f5-d9fb-053cb4744196@axentia.se>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Peter,

On Fri Jun 11, 2021 at 3:37 AM EDT, Peter Rosin wrote:
> Hi!
>
> Should "amplifier" really be part of the name for this binding when it's
> now
> just a generic voltage-to-temperature rescale binding? Or, perhaps a
> better
> description is THE generic voltage-to-temperature rescale binding?

I went with temperature-sense-amplifier because it resembled what you
had for the current sense binding, and because of the generic scaling
factor in v2.

>
> But that's not a strong opinion, I know next to nothing about these
> things
> and it might be that an amplifier is involved in the vast majority of
> cases?
> Maybe it's enough to be more explicit in the describing text that the
> binding
> is intended for analog front ends lacking an amplifier as well? I just
> find
> it a bit confusing since there are actual HW that calls itself
> "temperature
> sence amplifiers" that I think this binding targets but then isn't
> exemplified anywhere.
>
> Also, it disturbs my sense of symmetry if volt->temp gets a generic
> binding like this, when volt->current and volt->volt have bindings for
> specific front ends. Again, it's not a strong opinion, I'm just pointing
> it
> out. For the record, I started out with a generic volt->current binding
> similar to this volt->temp binding, but got push-back so that we now
> have
> two specific volt->current bindings. Again, I'm just pointing this out,
> and
> I'm perfectly aware that "rules" and opinions change over time.

I agree with you that it can be confusing given that some temperature
sensors call themselves "temperature sense amplifiers".

In v1, temperature-sense-amplifier was used for that kind of device.

I liked having one binding per front end type like we had in v1 because
the devicetree ends up listing hardware parameters which I find is more
explicit.

I went with a generic one for v2 because I thought it would make it
applicable to other use-cases and simplify implementation.

I don't have strong feelings about keeping v2 over v1 bindings, and
given what we talked about v1 might be better here.

Do you have a preference?

>
> On 2021-06-07 16:47, Liam Beguin wrote:
> > From: Liam Beguin <lvb@xiphos.com>
> >=20
> > An ADC is often used to measure other quantities indirectly. This
> > binding describe such a use case, the measurement of a temperature
> > through an analog front end connected to a voltage channel.
> >=20
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > ---
> >  .../iio/afe/temperature-sense-amplifier.yaml  | 57 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  2 files changed, 58 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/afe/temperatu=
re-sense-amplifier.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/afe/temperature-sens=
e-amplifier.yaml b/Documentation/devicetree/bindings/iio/afe/temperature-se=
nse-amplifier.yaml
> > new file mode 100644
> > index 000000000000..08f97f052a91
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/afe/temperature-sense-ampli=
fier.yaml
> > @@ -0,0 +1,57 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/afe/temperature-sense-amplifier=
.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Temperature Sense Amplifier
> > +
> > +maintainers:
> > +  - Liam Beguin <lvb@xiphos.com>
>
> Here, you claim maintainership...
>
> > +
> > +description: |
> > +  When an io-channel measures the output voltage of a temperature anal=
og front
> > +  end such as an RTD (resistance thermometer) or a temperature to curr=
ent
> > +  sensor, the interesting measurement is almost always the correspondi=
ng
> > +  temperature, not the voltage output. This binding describes such a c=
ircuit.
>
> Why would you convert from a voltage if you have a "temperature to
> current
> sensor"? Such a sensor should give you a current. Yeah yeah, I get it,
> you
> bake some resistance into the "gain" and you are done. But I think these
> things should be explicitly mentioned with examples. I think it would be
> a
> lot less terse if you spell out a couple of common ways to connect one
> of
> these linear temperature sensors and how that then maps to the gain that
> the
> consumer of the binding needs to use.
>
> It would also be a good thing to mention sensors by name, so that
> someone
> grepping for them finds this binding. It's a djungle out there.
>

You're right adding sensors names here would be very useful.

I'll rework the description with your suggestions and add specific
examples with maybe schematic drawings like in voltage-divider.yaml.

> > +
> > +properties:
> > +  compatible:
> > +    const: temperature-sense-amplifier
> > +
> > +  io-channels:
> > +    maxItems: 1
> > +    description: |
> > +      Channel node of a voltage io-channel.
> > +
> > +  '#io-channel-cells':
> > +    const: 1
> > +
> > +  sense-gain-mult:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: Amplifier gain multiplier. The default is <1>.
> > +
> > +  sense-gain-div:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: Amplifier gain divider. The default is <1>.
> > +
> > +  sense-offset-millicelsius:
> > +    description: Amplifier offset. The default is <0>.
> > +
> > +additionalProperties: false
> > +required:
> > +  - compatible
> > +  - io-channels
> > +
> > +examples:
> > +  - |
> > +    pt1000_1: temperature-sensor {
> > +        compatible =3D "temperature-sense-amplifier";
> > +        #io-channel-cells =3D <1>;
> > +        io-channels =3D <&temp_adc 3>;
> > +
> > +        sense-gain-mult =3D <1000000>;
> > +        sense-gain-div =3D <3908>;
> > +        sense-offset-millicelsius =3D <(-255885)>;
> > +    };
> > +...
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e679d422b472..4f7b4ee9f19b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8887,6 +8887,7 @@ L:	linux-iio@vger.kernel.org
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.y=
aml
> >  F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
> > +F:	Documentation/devicetree/bindings/iio/afe/temperature-sense-amplifi=
er.yaml
>
> ...and here, you give maintenance to me. I didn't want all afe bindings
> so I
> didn't put an asterisk there for a reason :-)

Sorry about that :-)

I don't really know what the convention is here. I put myself as a
maintainer on the yaml file since I created it.

For the MAINTAINERS patch, would something like this be better?

IIO UNIT CONVERTER (TEMPERATURE)
M:	Liam Beguin <liambeguin@gmail.com>
R:	Peter Rosin <peda@axentia.se>
F:	Documentation/devicetree/bindings/iio/afe/temperature-sense-amplifier.ya=
ml

Should I also add myself as a reviewer to the iio-rescaler driver for
the temperature related changes?

Also, I noticed an issue with the offset. When we're not using a
processed channel, the upstream channel scale has to be applied to the
offset which I forgot to do. I'm working on this for v3.

Thanks for your time,
Liam

> This binding is backed by the iio-rescale driver, so it's not totally
> alien
> for me to maintain it, but I'd be more happy if you listed yourself as I
> think
> you intended to?
>
> Cheers,
> Peter
>
> >  F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> >  F:	drivers/iio/afe/iio-rescale.c
> > =20
> >=20

