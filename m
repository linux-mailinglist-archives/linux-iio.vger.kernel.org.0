Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3763C6923
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jul 2021 06:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbhGMEXu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Jul 2021 00:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhGMEXt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Jul 2021 00:23:49 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11C8C0613DD;
        Mon, 12 Jul 2021 21:21:00 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id q190so20353004qkd.2;
        Mon, 12 Jul 2021 21:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:from:to:cc
         :subject:references:in-reply-to;
        bh=8NA/aiB+EPeP5agFXPDEWwbuZmONbn8hs65mOdjo90E=;
        b=u2ZZ/wddx4jiSxD+EsMWy/YdYWsP5gJA2u8vA7b4HUutkMaY4jEuRuuIsVNLH37RKs
         wsEsPU6a8kAH0ZHXClKZFb+ihojE3s54kH1H61RrhQTagTbsgLusrGgPI9CMb6r3Vlm1
         mpuPggKGhymrEP8CHsfy1dE9h48i3SMFxfu8RIbnINz9R8gdqe8NzX2o97bAaq17jIlm
         EOC0ewFhHbX2vf2QC1Or60awM+sKG9u9yL0wSQZI1A0Ztr96fKsQwpM5bv7f4ee59B3B
         dVhVQTkWk9CJG7yz94tXByZKWE12rgazwjuOg68/T1VolPiNDEVZ65ofmP6c0uZs24Rf
         +MNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:from:to:cc:subject:references:in-reply-to;
        bh=8NA/aiB+EPeP5agFXPDEWwbuZmONbn8hs65mOdjo90E=;
        b=r+BNFQnrAmku+ftDKHer0blm4IX71pkwvKl9sXDB0eBqzG0TrcV38o+9XtzoKKE/PH
         4+q8ZKn/h8/IW+52fJ6cKzGcCIjv2WM9GS6ObKwE1LWrhs16oaM8awwChLXQJh985M8/
         enFxc96WQUE/ShZTQmXwO5Jgi8jzePK44sO7X9WIFUMyrNUGMBtaUX2H5ChfPgKeE/zF
         wPpmtEb7EAjTAUOu6VRPNV/Vc65yWjA2w/f4+6VZP8E2tyMhwB5VbHPoeWWmv+P2zcJn
         P3HyYwB2kLNGNQe3NrGBVR8+0JWoyXqPZbj9lKqx3fysVpjqQEDhJAQIJGloTrHs9rkb
         udYw==
X-Gm-Message-State: AOAM532cJP4yz0UHI+EzB234HN2I8DuTWAsNSyDo+meSwacWgbQBcnZG
        /VSXspnvcfuIb+Tcw0hrLUA=
X-Google-Smtp-Source: ABdhPJzGNriWBi2sW60H9zEhh/xjic7z/9LY0JmnqxQ5ohSy4+gi4yc7IWaSYzqt8ivS+6MnGhy0gQ==
X-Received: by 2002:ae9:ed03:: with SMTP id c3mr2156146qkg.418.1626150059668;
        Mon, 12 Jul 2021 21:20:59 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id x15sm7379996qkm.66.2021.07.12.21.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 21:20:59 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 13 Jul 2021 00:20:57 -0400
Message-Id: <CCRQ33B4B96F.3IX5IUAK24F49@shaak>
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Rob Herring" <robh@kernel.org>
Cc:     <peda@axentia.se>, <jic23@kernel.org>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 10/10] dt-bindings: iio: afe: add bindings for
 temperature transducers
References: <20210706160942.3181474-1-liambeguin@gmail.com>
 <20210706160942.3181474-11-liambeguin@gmail.com>
 <20210712161156.GA2029104@robh.at.kernel.org>
In-Reply-To: <20210712161156.GA2029104@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon Jul 12, 2021 at 12:11 PM EDT, Rob Herring wrote:
> On Tue, Jul 06, 2021 at 12:09:42PM -0400, Liam Beguin wrote:
> > From: Liam Beguin <lvb@xiphos.com>
> >=20
> > An ADC is often used to measure other quantities indirectly.
> > This binding describe one case, the measurement of a temperature
> > through a temperature transducer (either voltage or current).
> >=20
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > ---
> >  .../iio/afe/temperature-transducer.yaml       | 111 ++++++++++++++++++
> >  1 file changed, 111 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/afe/temperatu=
re-transducer.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/afe/temperature-tran=
sducer.yaml b/Documentation/devicetree/bindings/iio/afe/temperature-transdu=
cer.yaml
> > new file mode 100644
> > index 000000000000..b5a4fbfe75e4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/afe/temperature-transducer.=
yaml
> > @@ -0,0 +1,111 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/afe/temperature-transducer.yaml=
#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Temperature Transducer
> > +
> > +maintainers:
> > +  - Liam Beguin <lvb@xiphos.com>
> > +
> > +description: |
> > +  A temperature transducer is a device that converts a thermal quantit=
y
> > +  into any other physical quantity. This binding applies to temperatur=
e to
> > +  voltage (like the LTC2997), and temperature to current (like the AD5=
90)
> > +  linear transducers.
> > +  In both cases these are assumed to be connected to a voltage ADC.
> > +
> > +  When an io-channel measures the output voltage of a temperature anal=
og front
> > +  end such as a temperature transducer, the interesting measurement is=
 almost
> > +  always the corresponding temperature, not the voltage output. This b=
inding
> > +  describes such a circuit.
> > +
> > +  The general transfer function here is (using SI units)
> > +    V(T) =3D Rsense * Isense(T)
> > +    T =3D (Isense(T) / alpha) + offset
> > +    T =3D 1 / (Rsense * alpha) * (V + offset * Rsense * alpha)
> > +
> > +  When using a temperature to voltage transducer, Rsense is set to 1.
> > +
> > +  The following circuits show a temperature to current and a temperatu=
re to
> > +  voltage transducer that can be used with this binding.
> > +
> > +           VCC
> > +          -----
> > +            |
> > +        +---+---+
> > +        | AD590 |                               VCC
> > +        +---+---+                              -----
> > +            |                                    |
> > +            V proportional to T             +----+----+
> > +            |                          D+ --+         |
> > +            +---- Vout                      | LTC2997 +--- Vout
> > +            |                          D- --+         |
> > +        +---+----+                          +---------+
> > +        | Rsense |                               |
> > +        +---+----+                             -----
> > +            |                                   GND
> > +          -----
> > +           GND
> > +
> > +properties:
> > +  compatible:
> > +    const: temperature-transducer
> > +
> > +  io-channels:
> > +    maxItems: 1
> > +    description: |
> > +      Channel node of a voltage io-channel.
> > +
> > +  '#io-channel-cells':
> > +    const: 0

Hi Rob,

>
> This is a io-channel consumer and producer?
>

Yes, this is a consumer and a producer.
It consumes a single ADC channel and can be fed to something like hwmon.

> > +
> > +  sense-offset-millicelsius:
> > +    description: |
> > +      Temperature offset. The default is <0>.
> > +      This offset is commonly used to convert from Kelvins to degrees =
Celsius.
> > +      In that case, sense-offset-millicelsius would be set to <(-27315=
0)>.
>
> default: 0
>
> > +
> > +  sense-resistor-ohms:
> > +    description: |
> > +      The sense resistor. Defaults to <1>.
> > +      Set sense-resistor-ohms to <1> when using a temperature to volta=
ge
> > +      transducer.
>
> default: 1
>
> Though why would we set the value to 1 if the default is 1?
>

I can rephrase this. I meant to say that the default will make this
behave like a temperature to voltage transducer.

Liam

> > +
> > +  alpha-ppm-per-celsius:
> > +    description: |
> > +      Sometimes referred to as output gain, slope, or temperature coef=
ficient.
> > +
> > +      alpha is expressed in parts per million which can be micro-amps =
per
> > +      degrees Celsius or micro-volts per degrees Celsius. The is the m=
ain
> > +      characteristic of a temperature transducer and should be stated =
in the
> > +      datasheet.
> > +
> > +additionalProperties: false
>
> Blank line here.
>
> > +required:
> > +  - compatible
> > +  - io-channels
> > +  - alpha-ppm-per-celsius
> > +
> > +examples:
> > +  - |
> > +    ad950: temperature-sensor-0 {
> > +        compatible =3D "temperature-transducer";
> > +        #io-channel-cells =3D <0>;
> > +        io-channels =3D <&temp_adc 3>;
> > +
> > +        sense-offset-millicelsius =3D <(-273150)>; /* Kelvin to degree=
s Celsius */
> > +        sense-resistor-ohms =3D <8060>;
> > +        alpha-ppm-per-celsius =3D <1>; /* 1 uA/K */
> > +    };
> > +  - |
> > +    znq_tmp: temperature-sensor-1 {
> > +        compatible =3D "temperature-transducer";
> > +        #io-channel-cells =3D <0>;
> > +        io-channels =3D <&temp_adc 2>;
> > +
> > +        sense-offset-millicelsius =3D <(-273150)>; /* Kelvin to degree=
s Celsius */
> > +        alpha-ppm-per-celsius =3D <4000>; /* 4 mV/K */
> > +    };
> > +...
> > --=20
> > 2.30.1.489.g328c10930387
> >=20
> >=20

