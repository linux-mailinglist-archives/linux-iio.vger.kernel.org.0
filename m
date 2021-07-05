Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4C23BB660
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jul 2021 06:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhGEEe3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Jul 2021 00:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhGEEe2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Jul 2021 00:34:28 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99763C061574;
        Sun,  4 Jul 2021 21:31:51 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id n9so11446074qtk.7;
        Sun, 04 Jul 2021 21:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=GlYcJPEoHWUHQ7cx8FUdsWiY0c6tz5TYpEX2amx01CE=;
        b=UJfAEhpbYg/lhNpSlEHMXn6YYZm/9AqVnI1A89T5O0qu7F7eR0h+Wa83yJS8fdVzkf
         U5FSV+1T+6a05ZdsXwQZHqJBQHbOK33OgEySrikcSdb4NRbChXZEmdxJUQTRnzBV4enz
         pyXqtl1X6NonF26LUypIppNOoLtjpX1Mn0hJ6WkMwwN6ebX7kJih+816pO+XdUSWMfpK
         PCES9yBvlynBzk3yrx6uvT7zpJebZcIjss6v8epEvptvY44b7xDptplTJwWmPfO/eIXL
         aToMWpIzWV9C9p9TYw1cK70xzKdAteQN3PLlq95+IhWXzN4ekK2zZV2vYT78gfU8vl5C
         iyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=GlYcJPEoHWUHQ7cx8FUdsWiY0c6tz5TYpEX2amx01CE=;
        b=bm3C+V8sEP+gfZ+ixJfbihpGhXy/AsNFGnCSdJwMxGCD1YfAysUNVxKh9zEiEDLKso
         duIEJuDmguvsaFo2TGL9ouU57s+I9QQtqT/smpNNk5XXdeWcERlkVxtSpPdfggb9CSc2
         qHmE2CEaY25Tt2Mh/Nv+fDgJomrPb0cwmcJty7sGW0wJAqB7iQeHJ3Of3oo+GRoYZ26n
         JbQ/aLcz2ut5EbntxVaMr9fKZX8wM1nuQaLsEQr6XQuU0Xi20tV1oXP10DCwfoh3XmbO
         p5MHSgIpBBFvTafva5dLKUdNKDvJz5C3qoPHt9TAQWJ+ku8vhwnF66OpKkwjkvOHF8Ip
         6M1g==
X-Gm-Message-State: AOAM531yAlhXlb4T7L+eGz4Kbf2eR+zIa+gVnwqoB/t1HS3z/UxvhypH
        RRPDW/NkOy7H33H7EtBZE5w=
X-Google-Smtp-Source: ABdhPJx6cfQqc61XC/zyXiNWPOvfB7wknYYj9fsUZlhO5Sivt9q0n8Yqw8kSGTJd02804z/5h222CA==
X-Received: by 2002:ac8:67d9:: with SMTP id r25mr10922563qtp.111.1625459510618;
        Sun, 04 Jul 2021 21:31:50 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id q184sm4945265qkd.35.2021.07.04.21.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 21:31:50 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 05 Jul 2021 00:31:49 -0400
Message-Id: <CCKXB1Z0D45K.323FW46EK6841@shaak>
Cc:     <peda@axentia.se>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v3 09/10] dt-bindings: iio: afe: add bindings for
 temperature-sense-rtd
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Jonathan Cameron" <jic23@kernel.org>
References: <20210701010034.303088-1-liambeguin@gmail.com>
 <20210701010034.303088-10-liambeguin@gmail.com>
 <20210704180259.7cba5831@jic23-huawei>
In-Reply-To: <20210704180259.7cba5831@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun Jul 4, 2021 at 1:02 PM EDT, Jonathan Cameron wrote:
> On Wed, 30 Jun 2021 21:00:33 -0400
> Liam Beguin <liambeguin@gmail.com> wrote:
>
> > From: Liam Beguin <lvb@xiphos.com>
> >=20
> > An ADC is often used to measure other quantities indirectly. This
> > binding describe one case, the measurement of a temperature through the
> > voltage across an RTD resistor such as a PT1000.
> >=20
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > ---
> >  .../iio/afe/temperature-sense-rtd.yaml        | 101 ++++++++++++++++++
> >  MAINTAINERS                                   |   7 ++
> >  2 files changed, 108 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/afe/temperatu=
re-sense-rtd.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/afe/temperature-sens=
e-rtd.yaml b/Documentation/devicetree/bindings/iio/afe/temperature-sense-rt=
d.yaml
> > new file mode 100644
> > index 000000000000..e23e74e63ec5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.y=
aml
> > @@ -0,0 +1,101 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/afe/temperature-sense-rtd.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Temperature Sense RTD
> > +
> > +maintainers:
> > +  - Liam Beguin <lvb@xiphos.com>
> > +
> > +description: |
> > +  RTDs (Resistance Temperature Detectors) are a kind of temperature se=
nsors
> > +  used to get a linear voltage to temperature reading within a give ra=
nge
> > +  (usually 0 to 100 degrees Celsius).
> > +
> > +  When an io-channel measures the output voltage across an RTD such as=
 a
> > +  PT1000, the interesting measurement is almost always the correspondi=
ng
> > +  temperature, not the voltage output. This binding describes such a c=
ircuit.
> > +
> > +  The general transfer function here is (using SI units)
> > +
> > +    V =3D R(T) * iexc
> > +    R(T) =3D r0 * (1 + alpha * T)
> > +    T =3D 1 / (alpha * r0 * iexc) * (V - r0 * iexc)
> > +
> > +  The following circuit matches what's in the examples section.
> > +
> > +           5V0
> > +          -----
> > +            |
> > +        +---+----+
> > +        |  R 5k  |
> > +        +---+----+
> > +            |
> > +            V 1mA
> > +            |
> > +            +---- Vout
> > +            |
> > +        +---+----+
> > +        | PT1000 |
> > +        +---+----+
> > +            |
> > +          -----
> > +           GND
> > +
> > +properties:
> > +  compatible:
> > +    const: temperature-sense-rtd
> > +
> > +  io-channels:
> > +    maxItems: 1
> > +    description: |
> > +      Channel node of a voltage io-channel.
> > +
> > +  '#io-channel-cells':
> > +    const: 1
>
> Only 1 channel, so this should be 0. For consumers of this driver
> they only need to identify the device, not the device + channel.
>
> https://github.com/devicetree-org/dt-schema/blob/master/schemas/iio/iio.y=
aml
>

Thanks for pointing that out. will fix.

> > +
> > +  excitation-current-microamp:
> > +    description: The current fed through the RTD sensor.
> > +
> > +  alpha-ppm-per-celsius:
> > +    description: |
> > +      alpha can also be expressed in micro-ohms per ohm Celsius. It's =
a linear
> > +      approximation of the resistance versus temperature relationship
> > +      between 0 and 100 degrees Celsius.
> > +
> > +      alpha =3D (R_100 - R_0) / (100 * R_0)
> > +
> > +      Where, R_100 is the resistance of the sensor at 100 degrees Cels=
ius, and
> > +      R_0 (or r-naught-ohms) is the resistance of the sensor at 0 degr=
ees
> > +      Celsius.
> > +
> > +      Pure platinum has an alpha of 3925. Industry standards such as I=
EC60751
> > +      and ASTM E-1137 specify an alpha of 3850.
> > +
> > +  r-naught-ohms:
> > +    description: |
> > +      Resistance of the sensor at 0 degrees Celsius.
> > +      Common values are 100 for PT100, 500 for PT500, and 1000 for PT1=
000
> > +
> > +additionalProperties: false
> > +required:
> > +  - compatible
> > +  - io-channels
> > +  - excitation-current-microamp
> > +  - alpha-ppm-per-celsius
> > +  - r-naught-ohms
> > +
> > +examples:
> > +  - |
> > +    pt1000_1: temperature-sensor0 {
> > +        compatible =3D "temperature-sense-rtd";
> > +        #io-channel-cells =3D <1>;
> > +        io-channels =3D <&temp_adc1 0>;
> > +
> > +        excitation-current-microamp =3D <1000>; /* i =3D U/R =3D 5 / 5=
000 */
> > +        alpha-ppm-per-celsius =3D <3908>;
> > +        r-naught-ohms =3D <1000>;
> > +    };
> > +...
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9bf553e53f0f..ed80e671a16a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8897,6 +8897,13 @@ F:	Documentation/devicetree/bindings/iio/afe/cur=
rent-sense-shunt.yaml
> >  F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> >  F:	drivers/iio/afe/iio-rescale.c
> > =20
> > +IIO UNIT CONVERTER (TEMPERATURE)
> > +M:	Liam Beguin <liambeguin@gmail.com>
> > +R:	Peter Rosin <peda@axentia.se>
> > +L:	linux-iio@vger.kernel.org
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yam=
l
>
> I'm not sure we'd normally bother with a MAINTAINERS entry when it is
> just the binding doc
> (as rest is in the driver). The binding doc itself has it's own local
> maintainers entry
> which is the more useful one.
>

You're right, it makes sense to drop the changes to MAINTAINERS as the
information is already contained it the bindings.
I added this after briefly talking about it with Peter.

Thanks again for reviewing these changes,
Liam

> > +
> >  IKANOS/ADI EAGLE ADSL USB DRIVER
> >  M:	Matthieu Castet <castet.matthieu@free.fr>
> >  M:	Stanislaw Gruszka <stf_xl@wp.pl>

