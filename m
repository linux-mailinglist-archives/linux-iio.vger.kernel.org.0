Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56821D6430
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2019 15:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731737AbfJNNhm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Oct 2019 09:37:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730922AbfJNNhm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 Oct 2019 09:37:42 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABBBB21721;
        Mon, 14 Oct 2019 13:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571060260;
        bh=MW3Nl5vBGYEP1r6pB6vRm4kt3sl+T74xXBxnQcnxDJg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2sXMPsUme561CeAMCgWM/oIn3ONLM16BXu712sOBkRiFSP7Q5C1T3nxOSvvhYH/Na
         ukNTVuStrnmrJDOjJStTKxCJ6vVZfMwSR/VmUJ148mc6xAqYi9BtHgDUX06XlL+dai
         b4kFaH5VeadhseiphEg6MvdBAlF9dJqAQEp/6dAI=
Received: by mail-qt1-f175.google.com with SMTP id 3so25514336qta.1;
        Mon, 14 Oct 2019 06:37:40 -0700 (PDT)
X-Gm-Message-State: APjAAAW4NwxjNsz6y300aspgq2YmgEPDY22CWZmsY3R57t4MJK+I/qar
        kC5R50rreQib1zaqzcqgeBl3JJfUAv78JRu6ug==
X-Google-Smtp-Source: APXvYqyHFikaVR1Zfh90uFQZ9+z/7Kmft2jWrHcMSksG+OdljBmXXe7LqVnEZ1a4Pk6UQblcYb5b+jQDp2XvV1p3oNo=
X-Received: by 2002:a0c:e606:: with SMTP id z6mr29909915qvm.135.1571060259750;
 Mon, 14 Oct 2019 06:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20191010012523.14426-1-rjones@gateworks.com> <20191010175648.10830-1-rjones@gateworks.com>
 <20191010175648.10830-2-rjones@gateworks.com> <20191011135811.GA23962@bogus> <CALAE=UCcEd_pyjG+80EDBgGKsJfaCM0fvHAwEdnhf5G9-Ns+ig@mail.gmail.com>
In-Reply-To: <CALAE=UCcEd_pyjG+80EDBgGKsJfaCM0fvHAwEdnhf5G9-Ns+ig@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 14 Oct 2019 08:37:28 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+_XXKJkHGB1vD=qM418NL-6MP7Qyx7cWDeM_wt5H-Lfg@mail.gmail.com>
Message-ID: <CAL_Jsq+_XXKJkHGB1vD=qM418NL-6MP7Qyx7cWDeM_wt5H-Lfg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: imu: add fxos8700 imu binding
To:     Bobby Jones <rjones@gateworks.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Oct 11, 2019 at 6:33 PM Bobby Jones <rjones@gateworks.com> wrote:
>
> On Fri, Oct 11, 2019 at 6:58 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Oct 10, 2019 at 10:56:47AM -0700, Robert Jones wrote:
> > > This adds documentation for the Freescale FXOS8700 Inertial Measurement Unit
> > > device-tree bindings.
> > >
> > > Signed-off-by: Robert Jones <rjones@gateworks.com>
> > > ---
> > >  .../devicetree/bindings/iio/imu/nxp,fxos8700.yaml  | 69 ++++++++++++++++++++++
> > >  1 file changed, 69 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml b/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
> > > new file mode 100644
> > > index 0000000..d33a1cc
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
> > > @@ -0,0 +1,69 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/imu/fxos8700.yaml#
> >
> > Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml: $id:
> > path/filename 'iio/imu/fxos8700.yaml' doesn't match actual filename
> >
> > Test your binding with 'make dt_binding_check'.
>
> Sorry about that, I had tried running that check previously but was
> struggling through some python environment/set-up problems.
> Additionally I did not realize that my path was incomplete until I
> read your github's readme line "Ensure ~/.local/bin is in the PATH". I
> don't utilize the python install on my machine frequently so I'm not
> sure if that should be obvious. It might be helpful to have that line
> in the Documentation/devicetree/writing-schema.md as well.
> Anyways I've got it running now.

Thanks for the input, will add something.

> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Freescale FXOS8700 Inertial Measurement Unit
> > > +
> > > +maintainers:
> > > +  - Robert Jones <rjones@gateworks.com>
> > > +
> > > +description: |
> > > +  Accelerometer and magnetometer combo device with an i2c and SPI interface.
> > > +  https://www.nxp.com/products/sensors/motion-sensors/6-axis/digital-motion-sensor-3d-accelerometer-2g-4g-8g-plus-3d-magnetometer:FXOS8700CQ
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - nxp,fxos8700
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 2
> > > +
> > > +  interrupt-names:
> > > +    maxItems: 2
> > > +    items:
> > > +      - const: INT1
> > > +      - const: INT2
> >
> > This doesn't match the example now. You need 'minItems: 1' if you need
> > to support 1 or 2 interrupts. If it can be either one, then you need:
> >
> > items:
> >   enum: [ INT1, INT2 ]
> I'm trying to compare against other .yaml examples in the tree but
> without scouring datasheets to find a device with similar interrupt
> capabilities I'm just guessing at how this should be defined.
> The device has 2 interrupt pins as you've read (INT1 and INT2), and
> 0-2 of them can be used depending on what's been configured. Given
> what you've explained so far would this be the proper definition?:
>
>   interrupts:
>     minItems: 1
>     maxItems: 2
>
>   interrupt-names:
>     minItems: 1
>     maxItems: 2
>     items:
>       enum:
>         - INT1
>         - INT2

Yes, that's good.

Rob
