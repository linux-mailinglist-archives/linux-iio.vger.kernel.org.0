Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA863E40E6
	for <lists+linux-iio@lfdr.de>; Mon,  9 Aug 2021 09:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbhHIHh4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Aug 2021 03:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbhHIHhx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Aug 2021 03:37:53 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E476EC0613CF;
        Mon,  9 Aug 2021 00:37:31 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id y7so11348205ljp.3;
        Mon, 09 Aug 2021 00:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tOfwbYzSxTz3/qcaHpP5xq44HlT8+4ETE/kx1iWOW9k=;
        b=Hd8h+zSTKqqrKx2DoCL857vPml6dHMgVL3E5Uhyq7UVegef+fv2BUbz5fcNkmw8J3Y
         1bMtRV+3ezRgV/cpVgVVNz0w2KGXor/42dxrqAVmNddMUCAbxL6hT95LyMFAy5ydccQJ
         O3bGeier+ZUnYLraMSCieUx8d1Pk9sUBMBm2flgkz1sq8Qz3JLwVfCFNZYi164a1pVdc
         BXTAsluL2A1VGSOIleP3zWLUOHZvYPiHYLr5Q0JXgTznIK0IOHoSi/N769oQN6uZio4u
         fwNpUItdL4RxwIwDfbxttvFs9yieG6lFlIWGjzTfihbixwIu7p8o1nUtTcuKzRIJwP0k
         RiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tOfwbYzSxTz3/qcaHpP5xq44HlT8+4ETE/kx1iWOW9k=;
        b=tGC4L8sLqpG24z/jJHMYpqSSjYArtF6z/X6xoHf+oQOxQY6Sc4KCDjsPBD9yHnTSuq
         RA9hhFGKYAmVvvjOgpArxmqVESKvfM/7LgyPd0Crbm8ZW4SA3qnkvtFtVl8lXBAiGTnu
         70kuNRTaTLLfZcy+DdEwwJQUs5PqUp1MRM5pPBX2RH7J24xfQNNqxy+rzeqbmt7cftVC
         VnO9XjRP3xWZSzlcv7HDBtraepAZOk9uOFw+MbgPAoDB6ObxwQYIT8WSewlN2uUJR6Yd
         ZrNZuxh6aeIX8PTkrX8/8AqvM2ghDuYgHm7PM3dZJlv++2YQ7V7ki2UEAmmFKXd+tJT0
         GKcg==
X-Gm-Message-State: AOAM531uWstpLpnyIvSP5sRN1LnwxdRRq9/oKu+NJ0nUWBWhE3xo3Uv4
        SPwDn+Fw1AQfjtER/m0mmNfetafYp00HVmbXmNE=
X-Google-Smtp-Source: ABdhPJxCTMdNR4nhdx+ITQyYxOPPVNGZiM7D3EUtxmzvbpMraOfsVBSAOpA86otXJM39RLOEZ1uhZ1qXuutIAvJb1j8=
X-Received: by 2002:a2e:944a:: with SMTP id o10mr14770206ljh.119.1628494650167;
 Mon, 09 Aug 2021 00:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210804140309.31468-1-puranjay12@gmail.com> <20210804140309.31468-2-puranjay12@gmail.com>
 <20210808160628.7b031948@jic23-huawei> <20210808164345.799b8568@jic23-huawei>
In-Reply-To: <20210808164345.799b8568@jic23-huawei>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Mon, 9 Aug 2021 13:07:18 +0530
Message-ID: <CANk7y0idV-EtDG0BuVjF7L4NU_8sgGv3wNZWLoHWksRbcLEgZQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] dt-bindings: iio: accel: Add DT binding doc for ADXL355
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "Berghe, Darius" <Darius.Berghe@analog.com>, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Aug 8, 2021 at 9:10 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun, 8 Aug 2021 16:06:28 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>
> > On Wed,  4 Aug 2021 19:33:07 +0530
> > Puranjay Mohan <puranjay12@gmail.com> wrote:
> >
> > > Add devicetree binding document for ADXL355, a 3-Axis MEMS Accelerometer.
> > >
> > > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> >
> > Looks good to me. I'll pick this up once Rob and anyone else interested
> > has had time to take a look assuming they don't ask for any changes.
> >
> > Thanks,
> >
> > Jonathan
> >
> >
> > > ---
> > >  .../bindings/iio/accel/adi,adxl355.yaml       | 88 +++++++++++++++++++
> > >  1 file changed, 88 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
> > > new file mode 100644
> > > index 000000000..5da3fd5ad
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
> > > @@ -0,0 +1,88 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/accel/adi,adxl355.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Analog Devices ADXL355 3-Axis, Low noise MEMS Accelerometer
> > > +
> > > +maintainers:
> > > +  - Puranjay Mohan <puranjay12@gmail.com>
> > > +
> > > +description: |
> > > +  Analog Devices ADXL355 3-Axis, Low noise MEMS Accelerometer that supports
> > > +  both I2C & SPI interfaces
> > > +    https://www.analog.com/en/products/adxl355.html
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - adi,adxl355
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    minItems: 1
> > > +    maxItems: 3
> > > +    description: |
> > > +      Type should be IRQ_TYPE_LEVEL_HIGH.
> > > +      Three configurable interrupt lines exist.
>
> I just noticed from the datasheet, that INT1 and INT2 have controllable
> polarity on the device.  We should look to support that rather than
> stating all 3 interrupts are LEVEL_HIGH.  For now, I'd just not
> state the type here, or make that statement only for the dataready pin.
>

Hi Jonathan,
I will be sending v9 of this series where I will state this only for
the DRDY pin. I will also make the scale defines inline for the other
patch.
Also, I will not send the third patch: trigger support in v9 because
it needs a lot of work.
It would be great if the base driver gets accepted and I will keep
working on the trigger support separately and not as a part of this
patch series.
I am also interested in looking into fwnode_get_irq_byname() for the
trigger patch.

> Once you enable these interrupts, you will want to handle the polarity setting
> in a similar fashion to the bmi160.
>
> It is a bit messy to combine the interrupt polarity at the interrupt controller
> with that at the device, but that is how we've handled these in the past.
>
> Jonathan
>
> > > +
> > > +  interrupt-names:
> > > +    description: Specify which interrupt line is in use.
> > > +    items:
> > > +      enum:
> > > +        - INT1
> > > +        - INT2
> > > +        - DRDY
> > > +    minItems: 1
> > > +    maxItems: 3
> > > +
> > > +  vdd-supply:
> > > +    description: Regulator that provides power to the sensor
> > > +
> > > +  vddio-supply:
> > > +    description: Regulator that provides power to the bus
> > > +
> > > +  spi-max-frequency: true
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +        #include <dt-bindings/gpio/gpio.h>
> > > +        #include <dt-bindings/interrupt-controller/irq.h>
> > > +        i2c {
> > > +                #address-cells = <1>;
> > > +                #size-cells = <0>;
> > > +
> > > +                /* Example for a I2C device node */
> > > +                accelerometer@1d {
> > > +                        compatible = "adi,adxl355";
> > > +                        reg = <0x1d>;
> > > +                        interrupt-parent = <&gpio>;
> > > +                        interrupts = <25 IRQ_TYPE_EDGE_RISING>;
> > > +                        interrupt-names = "DRDY";
> > > +                };
> > > +        };
> > > +  - |
> > > +        #include <dt-bindings/gpio/gpio.h>
> > > +        #include <dt-bindings/interrupt-controller/irq.h>
> > > +        spi {
> > > +                #address-cells = <1>;
> > > +                #size-cells = <0>;
> > > +
> > > +                accelerometer@0 {
> > > +                        compatible = "adi,adxl355";
> > > +                        reg = <0>;
> > > +                        spi-max-frequency = <1000000>;
> > > +                        interrupt-parent = <&gpio>;
> > > +                        interrupts = <25 IRQ_TYPE_EDGE_RISING>;
> > > +                        interrupt-names = "DRDY";
> > > +                };
> > > +        };
> >
>


-- 
Thanks and Regards

Yours Truly,

Puranjay Mohan
