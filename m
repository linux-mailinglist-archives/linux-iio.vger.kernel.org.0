Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3AE4B0181
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2019 18:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfIKQVw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Sep 2019 12:21:52 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39203 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728878AbfIKQVv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Sep 2019 12:21:51 -0400
Received: by mail-qt1-f195.google.com with SMTP id n7so25976790qtb.6;
        Wed, 11 Sep 2019 09:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JcZbgDNJKwCwHsBDRhP3QKGes3mgqqZKrMVOxPvswps=;
        b=o0YuCD7suiIEWQOjij3YtZKXbdvA60SXFyba4j/1/SL7uBkbxOLL4V35YTffO2iEtr
         BVOPJdE4ImI4z0Er3ZeWwm+FNt3mO8ArvoHj0S0rYFklVmrn1R4vEx8VoRSLqCk7DuQc
         YVFqByIZw8xI8g0F8Ge7gmCz2lqiGOawtYtmE+JKsRaMyjJx3pashyK/mgttgQ7Gdl5h
         cJZfJsV/XjC/9WqcgjtSF8W4veL/9MWMPjO0UwWP8SVoRAnVcVc6XKE8dCzDqw89SHBf
         a3mg6ZTOfol1Bqj471XyiKSleTOQhAdQRn7xeZ9FSPqp0XNGBabDF75XDI16gNi4Vi1G
         mXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JcZbgDNJKwCwHsBDRhP3QKGes3mgqqZKrMVOxPvswps=;
        b=bk2Gd64BAlDjg2Ber39W+UT/FWYSEiAKkruc9AT+WKeiVQm5x1M7LhJuKrL2aW/ZoV
         Qj6GiB9SLJowE6bq5wn3RRNkh2mUi3xmLq+k8Ur8/d3ytuWWOVVPNSpgFlELPTSaWVxn
         fcbde8SM2qAFBjMWr6OISsb195iW4tVoI76KeTJBGpkecs+K9rwgHWYc6/e0ZXQ5z+Np
         ki5sBZuf5OT1LbZbTmG29x7AXJjyM6AbVwYkMEME5M2LU2FLeKF/+DWKVItAr4QOQFcD
         GICOGkh0PYWsByrYop3ZKUy/zg/SnjaOzoBLuM8Ksa3RKTjb4gGHuQXu4CarYHh9906K
         MPrw==
X-Gm-Message-State: APjAAAVy+0ARn0X2MXd2GoKp12GPSzUj+KsydrHkjTAQ42Q3sJFeoWKc
        Pr/H3p3tEKpGVG3pvlA4utb5aRCCAHlCrBpkAfs=
X-Google-Smtp-Source: APXvYqxbV+Cod+KBMeeG3G4TkNWpy0azEMoi/IQlC861WbSBmrxogwmVpwaVck5fDx/QJSsquwwfMbAZ3fN00+wPYzM=
X-Received: by 2002:ac8:7089:: with SMTP id y9mr36687897qto.363.1568218910200;
 Wed, 11 Sep 2019 09:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190902005938.7734-1-rodrigorsdc@gmail.com> <20190902171417.qbj7rwi43tr77mr5@smtp.gmail.com>
 <20190908115227.65046733@archlinux>
In-Reply-To: <20190908115227.65046733@archlinux>
From:   Rodrigo Carvalho <rodrigorsdc@gmail.com>
Date:   Wed, 11 Sep 2019 13:21:38 -0300
Message-ID: <CAOeBkLr1=muqefrLU+HjauX_7pF+x90yew4wQ9j-L3hCDkcKQg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: accel: add binding documentation
 for ADIS16240
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        alexandru.ardelean@analog.com, linux-iio@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

Thanks for comments. I will send a v2.

Em dom, 8 de set de 2019 =C3=A0s 07:52, Jonathan Cameron <jic23@kernel.org>=
 escreveu:
>
> On Mon, 2 Sep 2019 14:14:18 -0300
> Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
>
> > Hi Rodrigo,
> >
> > This dt doc looks overal fine IMHO.
> > I would just add some inline comments about the cpha and cpol
> > properties.
> >
> > On 09/01, Rodrigo Carvalho wrote:
> > > This patch add device tree binding documentation for ADIS16240.
> > >
> > > Signed-off-by: Rodrigo Ribeiro Carvalho <rodrigorsdc@gmail.com>
> > > ---
> > > I have doubt about what maintainer I may to put in that documentation=
. I
> > > put Alexandru as maintainer because he reviewed my last patch on this
> > > driver, so I think that he is a good candidate.
> > >  .../bindings/iio/accel/adi,adis16240.yaml     | 55 +++++++++++++++++=
++
> > >  1 file changed, 55 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,a=
dis16240.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis1624=
0.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> > > new file mode 100644
> > > index 000000000000..08019b51611c
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> > > @@ -0,0 +1,55 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/accel/adi,adis16240.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: ADIS16240 Programmable Impact Sensor and Recorder driver
> > > +
> > > +maintainers:
> > > +  - Alexandru Ardelean <alexandru.ardelean@analog.com>
> > > +
> > > +description: |
> > > +  ADIS16240 Programmable Impact Sensor and Recorder driver that supp=
orts
> > > +  SPI interface.
> > > +    https://www.analog.com/en/products/adis16240.html
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - adi,adis16240
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  spi-cpha: true
> > > +
> > > +  spi-cpol: true
> > Boolean properties don't require to be explicitly set. It would also be
> > nice to add a description pointing to the spi-bus documentation. Like
> > this:
> >
> >   spi-cpha:
> >     description: |
> >       See Documentation/devicetree/bindings/spi/spi-bus.txt
> >     maxItems: 1
> >
> >   spi-cpol:
> >     description: |
> >       See Documentation/devicetree/bindings/spi/spi-bus.txt
> >     maxItems: 1
> >
> > As far as I know, spi-cpol and spi-cpha stand for SPI chip polarity and
> > SPI chip phase respectively. By default, it is assumed that SPI
> > input/output data is available at uprising clock edges, however, some
> > chips may work with different configuration (taking input data and/or
> > push it out in falling edges). I'm not 100% sure but, from what I've
> > seen on IIO, cpol is set to invert the input/output logic (making IO be
> > taken on falling edges) while cpha is usually set when MISO valid out
> > data is available on SCLK falling edge. If anyone has more comments
> > about this please, add them here, I'm curious about it. :)
> >
>
> They may well be constant for a given device (some will cope with
> several combinations).  So the binding should reflect if they 'must'
> be set.
>
> Adding the cross reference is indeed nice.
>
> Jonathan
>
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - interrupts
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/gpio/gpio.h>
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +    spi0 {
> > > +        #address-cells =3D <1>;
> > > +        #size-cells =3D <0>;
> > > +
> > > +        /* Example for a SPI device node */
> > > +        accelerometer@0 {
> > > +            compatible =3D "adi,adis16240";
> > > +            reg =3D <0>;
> > > +            spi-max-frequency =3D <2500000>;
> > > +            spi-cpol;
> > > +            spi-cpha;
> > > +            interrupt-parent =3D <&gpio0>;
> > > +            interrupts =3D <0 IRQ_TYPE_LEVEL_HIGH>;
> > > +        };
> > > +    };
> > > --
> > > 2.23.0.rc1
> > >
> > > --
> > > You received this message because you are subscribed to the Google Gr=
oups "Kernel USP" group.
> > > To unsubscribe from this group and stop receiving emails from it, sen=
d an email to kernel-usp+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/=
msgid/kernel-usp/20190902005938.7734-1-rodrigorsdc%40gmail.com.
>
