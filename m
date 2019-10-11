Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE4DCD4B00
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 01:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfJKXdn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Oct 2019 19:33:43 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38159 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbfJKXdm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Oct 2019 19:33:42 -0400
Received: by mail-io1-f68.google.com with SMTP id u8so24950769iom.5
        for <linux-iio@vger.kernel.org>; Fri, 11 Oct 2019 16:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DhU8DoXtvT6nY6FZrwH3JiEC75JYN6COLoYwLtTluLM=;
        b=aaqNIwa2wGY1EAmYaZGEK5+bBWU+p7RokpN7Vx7xVDmPhXie4/4Wp0GqYHK02GcUZ/
         92v7PnnbqvMPyf2dFQ3IF8fuFP/CpjGgzlo3D3hZSlnFGxmSpcy7h73yLbnJ13kHfQTO
         +Z1MCeEcsFcM8uGtlvpASDW3YnBJosUZyZWV2vuzKgu2cmNt5tn1/ERApMgD+lc/kleL
         UwwXPK3DxtVKlmzSFFqWZ8BmglvOaqaOHuRt5zGmyYwOIVlYPmQTlqXsMCpmbsTDW13E
         f6UN0eAn2e4PANpEzA4KshefB99HU6KF8ZqO6SIPJPV34Ibhg4WiRHGNJsQlBdDkkL26
         ZvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DhU8DoXtvT6nY6FZrwH3JiEC75JYN6COLoYwLtTluLM=;
        b=XE5Qd8qQaELoXvJdemxwWHBHyrucoKuWrRdHfleFJf0T7+UcuX6FxodLj7J8nBFB+h
         sNwS3pM0pb/DCYv+kJo0iojJaFEzhgDn91c+8xW17EiJL/XZm6SEvhIz6sHZyM23o3OB
         ZY7moQv64jpblfCkIRQZB4OGmjw6+sNvW0TonqfW4UOIAE5eh82HlPTZRejknJ0XcdLF
         LpzD39OX9VA7mbIU4oTRM/5vQ0OfkOMcMegfkGL2kCVkLicJvuI9y1mCsYfR5yuUDk0j
         t6WW3G7O14C2RBjAN7VsKa6WgHDh9o791bf1MU0MtCSauDu8L564kFPJd9XeGtAFs0dX
         D4Kg==
X-Gm-Message-State: APjAAAUPWdeJ/GHaG6cLFDB8YcCZBEMqghsCFSrAQXovlzytDhJno5DB
        pYpfxyZhRwMaZm85M2jlJ14SVDEHQcvdEQRZGRj5FA==
X-Google-Smtp-Source: APXvYqzW44dX95eCnEg2VO7DD/v5I6ZMqvXUqkxHcehC3uRrsssurGlQ19W/1llqjn1erhUcV0lTP4iDdXET9SSTeHE=
X-Received: by 2002:a02:52c4:: with SMTP id d187mr21531168jab.127.1570836820066;
 Fri, 11 Oct 2019 16:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <20191010012523.14426-1-rjones@gateworks.com> <20191010175648.10830-1-rjones@gateworks.com>
 <20191010175648.10830-2-rjones@gateworks.com> <20191011135811.GA23962@bogus>
In-Reply-To: <20191011135811.GA23962@bogus>
From:   Bobby Jones <rjones@gateworks.com>
Date:   Fri, 11 Oct 2019 16:33:29 -0700
Message-ID: <CALAE=UCcEd_pyjG+80EDBgGKsJfaCM0fvHAwEdnhf5G9-Ns+ig@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: imu: add fxos8700 imu binding
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Oct 11, 2019 at 6:58 AM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Oct 10, 2019 at 10:56:47AM -0700, Robert Jones wrote:
> > This adds documentation for the Freescale FXOS8700 Inertial Measurement Unit
> > device-tree bindings.
> >
> > Signed-off-by: Robert Jones <rjones@gateworks.com>
> > ---
> >  .../devicetree/bindings/iio/imu/nxp,fxos8700.yaml  | 69 ++++++++++++++++++++++
> >  1 file changed, 69 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml b/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
> > new file mode 100644
> > index 0000000..d33a1cc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
> > @@ -0,0 +1,69 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/imu/fxos8700.yaml#
>
> Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml: $id:
> path/filename 'iio/imu/fxos8700.yaml' doesn't match actual filename
>
> Test your binding with 'make dt_binding_check'.

Sorry about that, I had tried running that check previously but was
struggling through some python environment/set-up problems.
Additionally I did not realize that my path was incomplete until I
read your github's readme line "Ensure ~/.local/bin is in the PATH". I
don't utilize the python install on my machine frequently so I'm not
sure if that should be obvious. It might be helpful to have that line
in the Documentation/devicetree/writing-schema.md as well.
Anyways I've got it running now.

>
>
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Freescale FXOS8700 Inertial Measurement Unit
> > +
> > +maintainers:
> > +  - Robert Jones <rjones@gateworks.com>
> > +
> > +description: |
> > +  Accelerometer and magnetometer combo device with an i2c and SPI interface.
> > +  https://www.nxp.com/products/sensors/motion-sensors/6-axis/digital-motion-sensor-3d-accelerometer-2g-4g-8g-plus-3d-magnetometer:FXOS8700CQ
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - nxp,fxos8700
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 2
> > +
> > +  interrupt-names:
> > +    maxItems: 2
> > +    items:
> > +      - const: INT1
> > +      - const: INT2
>
> This doesn't match the example now. You need 'minItems: 1' if you need
> to support 1 or 2 interrupts. If it can be either one, then you need:
>
> items:
>   enum: [ INT1, INT2 ]
I'm trying to compare against other .yaml examples in the tree but
without scouring datasheets to find a device with similar interrupt
capabilities I'm just guessing at how this should be defined.
The device has 2 interrupt pins as you've read (INT1 and INT2), and
0-2 of them can be used depending on what's been configured. Given
what you've explained so far would this be the proper definition?:

  interrupts:
    minItems: 1
    maxItems: 2

  interrupt-names:
    minItems: 1
    maxItems: 2
    items:
      enum:
        - INT1
        - INT2

Thanks

>
> > +
> > +  drive-open-drain:
> > +    type: boolean
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        fxos8700@1e {
> > +          compatible = "nxp,fxos8700";
> > +          reg = <0x1e>;
> > +
> > +          interrupt-parent = <&gpio2>;
> > +          interrupts = <7 IRQ_TYPE_EDGE_RISING>;
> > +          interrupt-names = "INT1";
> > +        };
> > +    };
> > +  - |
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        fxos8700@1e {
> > +          compatible = "nxp,fxos8700";
> > +          reg = <0x1e>;
>
> I guess you could have SPI chip select # 30...

Absolutely, and definitely not a hasty copy and paste error :)



>
> > +
> > +          interrupt-parent = <&gpio2>;
> > +          spi-max-frequency = <1000000>
> > +          interrupts = <7 IRQ_TYPE_EDGE_RISING>;
> > +          interrupt-names = "INT1";
> > +        };
> > +    };
> > --
> > 2.9.2
> >
