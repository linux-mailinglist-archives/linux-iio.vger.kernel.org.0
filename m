Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E07B62326B
	for <lists+linux-iio@lfdr.de>; Mon, 20 May 2019 13:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732848AbfETLam (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 May 2019 07:30:42 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41222 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732850AbfETLam (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 May 2019 07:30:42 -0400
Received: by mail-oi1-f194.google.com with SMTP id y10so9674480oia.8;
        Mon, 20 May 2019 04:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nyKZfAuaROY2BjFNib6WMeJ7XG4lSb4BAQnu9LjW4yQ=;
        b=JFaGZzNiBg1xlxHlRz6WI7/41fnkwKy6Cd5nvHzSSi8pSDhT2V7TYwPRt4qou/23tB
         ZS1byABLyJ2BkGDZ/1FCYzEHCIL+CV80MqN9gEGFPl5PKPI4kgJh4kVYuteGz74evnvD
         S6Rs6CDMFSB1EtBq1U6mewSejwQhsiD0/XPcwmGDJHRPU0vFjHJo07VR0d8zuUgdhhDv
         s16Z9keGM1fm8BZTq2M6FtdIgzzFbcu6gOa/B759dhzJPl2ipgAAXIo58iYQycT9s3hS
         dTPwImjjCCTyo/vgf+c1yJvILO7gaDFt9ABAPzFj+UyOjw+yNzU8/XrDsi9PG0FaxAJF
         4G6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nyKZfAuaROY2BjFNib6WMeJ7XG4lSb4BAQnu9LjW4yQ=;
        b=lig8YaYpBByhCR21T0kGmZB797Cz/78S/EFXk/M+je63Ks78vFPMCqEG11GbaKOrOx
         bceFQVVFYwDrQlAue8A5np2+m9h7M5ftt0FRZIUih1dQF9rQXoK50chknAMI3hQP1BIE
         sZGtDFdDUlUQdu84OBf8oqTaYAateP8WLsHCIO4ut1llwQh5Sb6Br3i5r60KdwaObOh7
         bBJBbyY9mj3fDzsCgLX+D7cQbtFUNN1SBCirZ2JoVwEIcSVz4c+k6yAPBieQSq9z7bpQ
         GrOHGEU8Fwzo2alTzHcRJNzyasZSG6yaqLczxj1ns7F5c6NpiNUq8EL/NQ17q3tpCZQm
         cNDQ==
X-Gm-Message-State: APjAAAXDLeaxmKzkG272rfU6cLHtU59TWQrGUQlEl55i5+w9JeXQd9dY
        nszmisza+IDO46028r8GIatzHAT57GOAtIVzEt4=
X-Google-Smtp-Source: APXvYqy+hBIDWN7ld5J5EKHCPKrNI1j9comLjyZhCaZbYTVL4OGVddZSvMuPc1sNUxi24GFPtT/cwcMQhqJLamDnLdk=
X-Received: by 2002:aca:6208:: with SMTP id w8mr22583932oib.128.1558351841160;
 Mon, 20 May 2019 04:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190518224036.29596-1-joao.marques.oliveira@usp.br> <20190519122944.3326e803@archlinux>
In-Reply-To: <20190519122944.3326e803@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 20 May 2019 14:30:29 +0300
Message-ID: <CA+U=DsrqzW6c1dR68PztzrQ9S7mYD0tZ50GdEdboN0pocVw5SQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: iio: ad7949: switch binding to yaml
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     =?UTF-8?Q?Jo=C3=A3o_Victor_Marques_de_Oliveira?= 
        <joao.marques.oliveira@usp.br>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-usp@googlegroups.com,
        "Thiago L . A . Miller" <tmiller@mochsl.org.br>,
        "Osvaldo M . Yasuda" <omyasuda@yahoo.com.br>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 19, 2019 at 8:29 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 18 May 2019 19:40:36 -0300
> Jo=C3=A3o Victor Marques de Oliveira         <joao.marques.oliveira@usp.b=
r> wrote:
>
> > Changes switches from old text bindings, to YAML bindings, and also
> > include adi,reference-select property to specify the source for the
> > reference voltage signal.
> >
> > Signed-off-by: Jo=C3=A3o Victor Marques de Oliveira <joao.marques.olive=
ira@usp.br>
> > Signed-off-by: Thiago L. A. Miller <tmiller@mochsl.org.br>
> > Co-developed-by: Thiago L. A. Miller <tmiller@mochsl.org.br>
> > Signed-off-by: Osvaldo M. Yasuda <omyasuda@yahoo.com.br>
> > Co-developed-by: Osvaldo M. Yasuda <omyasuda@yahoo.com.br>
> > ---
> > We're adding Charles-Antoine Couret as main dt maintainer since we have
> > just switched documentation to yaml format.
>
> Hmm. I'm not sure it makes sense to list you all as maintainers
> of this rather simple binding.
>
> We also just went through some changes on the reference handling so
> I think you are based on stale information here.
>
> Thanks,
>
> Jonathan
>
> >
> >  .../devicetree/bindings/iio/adc/ad7949.txt    | 16 -----
> >  .../devicetree/bindings/iio/adc/ad7949.yaml   | 71 +++++++++++++++++++
> >  2 files changed, 71 insertions(+), 16 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/adc/ad7949.tx=
t
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/ad7949.ya=
ml

Maybe also update the MAINTAINERS file with this.

> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/ad7949.txt b/Doc=
umentation/devicetree/bindings/iio/adc/ad7949.txt
> > deleted file mode 100644
> > index c7f5057356b1..000000000000
> > --- a/Documentation/devicetree/bindings/iio/adc/ad7949.txt
> > +++ /dev/null
> > @@ -1,16 +0,0 @@
> > -* Analog Devices AD7949/AD7682/AD7689
> > -
> > -Required properties:
> > - - compatible: Should be one of
> > -     * "adi,ad7949"
> > -     * "adi,ad7682"
> > -     * "adi,ad7689"
> > - - reg: spi chip select number for the device
> > - - vref-supply: The regulator supply for ADC reference voltage
> > -
> > -Example:
> > -adc@0 {
> > -     compatible =3D "adi,ad7949";
> > -     reg =3D <0>;
> > -     vref-supply =3D <&vdd_supply>;
> > -};
> > diff --git a/Documentation/devicetree/bindings/iio/adc/ad7949.yaml b/Do=
cumentation/devicetree/bindings/iio/adc/ad7949.yaml
> > new file mode 100644
> > index 000000000000..111c9e26f8e7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/ad7949.yaml
> > @@ -0,0 +1,71 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/ad7949.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +

nitpick: extra line

> > +title: Analog Devices AD7949/AD7682/AD7689
> > +
> > +maintainers:
> > +  - Charles-Antoine Couret <charles-antoine.couret@essensium.com>
> > +  - Jo=C3=A3o Victor Marques de Oliveira <joao.marques.oliveira@usp.br=
>
> > +  - Thiago L. A. Miller <tmiller@mochsl.org.br>
> > +  - Osvaldo M. Yasuda <omyasuda@yahoo.com.br>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ad7949
> > +      - adi,ad7682
> > +      - adi,ad7689
> > +
> > +  reg:
> > +    description:
> > +      spi chip select number for the device

this doesn't need a description
it's a standard property

> > +    maxItems: 1
> > +
> > +  vref-supply:
> > +    description:
> > +      The regulator supply for ADC reference voltage
> > +    maxItems: 1
> > +
> > +  adi,reference-select:
> > +    enum: [0, 1, 2, 3, 6, 7]
> > +    description:
> > +        Select the reference voltage source to use when converting the=
 input voltages.
> > +            0 - Internal 2.5V reference; temperature sensor enabled
> > +            1 - Internal 4.096V reference; temperature sensor enabled
> > +            2 - External reference, temperature sensor enabled, no buf=
fer
> > +            3 - External reference, temperature sensor enabled, buffer=
 enabled
> > +            6 - External reference, temperature sensor disabled, no bu=
ffer
> > +            7 - External reference, temperature sensor disabled, buffe=
r enabled
> This is changing...
>
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vref-supply
> > +
> > +examples:
> > +  - |
> > +    spi0 {
> > +        #address-cells =3D <0x1>;
> > +        #size-cells =3D <0x0>;
> > +        adc@0 {
> > +            compatible =3D "adi,ad7949";
> > +            reg =3D <0>;
> > +            adi,reference-select =3D <0>;
> > +            vref-supply =3D <&vdd_supply>;
> > +        };
> > +    };

One example is enough in this case.
They don't differ much.

> > +  - |
> > +    spi0 {
> > +        #address-cells =3D <0x1>;
> > +        #size-cells =3D <0x0>;
> > +        adc@0 {
> > +            compatible =3D "adi,ad7949";
> > +            reg =3D <0>;
> > +            adi,reference-select =3D <0>;
> > +        };
> > +    };
>
