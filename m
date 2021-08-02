Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE803DDDF4
	for <lists+linux-iio@lfdr.de>; Mon,  2 Aug 2021 18:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhHBQuI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Aug 2021 12:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhHBQuI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Aug 2021 12:50:08 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94418C06175F;
        Mon,  2 Aug 2021 09:49:57 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id a19so24853640oiw.6;
        Mon, 02 Aug 2021 09:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GJ/wB5SaZNzipWzV3cX8x7hHQDMnNXMgy0/0mwF3c/c=;
        b=c/WdP0XbjY5Obu7GQps6Gyr4MVEfRvQUrAKedEOu6g6uu0PqglzkzCHtGJHf6nQu7F
         HYKTahBkB8pPc6aHO9l1OwVWVAyhLai6im+cfV4E53zGI5pVf3QmdSjmp1zdRKPvHi40
         f+mwRZHh7w0p9xZVI5MzZFLFwv4tCLMY6O7Ym7SAu47MA/9PKVeYULlifp31FgRXBoUc
         I2cE2LmL/pc9r4mfGOT+k/pDpiWIYXE/Yc+yAyH87TAmYktX/3sEqrlcvheNiDeNYcZg
         gD6qhtRx2NRRB1AGD0fTX0iP41Mgt3BEfZKp/6iu0RxyCQSQFwMkOzsFaXDtOTijnKop
         UF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GJ/wB5SaZNzipWzV3cX8x7hHQDMnNXMgy0/0mwF3c/c=;
        b=lzCqFWnCy32eIBKtQuITpLcPAAVNY7b6agbjQzZ5bu9fJhXif6pNf+W3r1sCK0GsEW
         PLR0Dk8rdCh7pJ4XD2n3/WLUUE9y4g0kVKuuUCyZmqX4vJDCbrJmYsK/yF/fGy8KqDXa
         9QiDv3K54ebXfgDsFh679CPVpyXxTlMdutkRThC66kuuvcKm6U4b6ZPflGN7cDuWpGwc
         aBzgdHXyEGEOPOl67JvPvr+0yZfu5F5C0pclcQwHapfIXjehrqI8yAXLgw/cL4lCXyI/
         MQ3vWLewRGyc9JyT2OQElsf2c1ystxUzzrLFuQiwt+iSgmoNtJddxG04pbHM3KQk0tE7
         iBuQ==
X-Gm-Message-State: AOAM5302QsD/OKpKXzd3z03n4P1y7jrV/322qZQsIBx62kzCNZrRZrNt
        yFwPEdwRYzLIZFEfQ7R2MmGUtxUA932xJVQkCRo=
X-Google-Smtp-Source: ABdhPJySjm9Fxl4xbbdV7e8Jqk9rZK0+R9OyCWTRZegqL6TBuGgx25YjNsIHRXxGHb0O3JTVf2N/XSr8e9sQaGYZ/mA=
X-Received: by 2002:aca:3644:: with SMTP id d65mr11317889oia.88.1627922997057;
 Mon, 02 Aug 2021 09:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1627709571.git.lucas.p.stankus@gmail.com>
 <1e652b88a367824e58fb71896b4a660204bd7a88.1627709571.git.lucas.p.stankus@gmail.com>
 <20210801190422.28fd5334@jic23-huawei>
In-Reply-To: <20210801190422.28fd5334@jic23-huawei>
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
Date:   Mon, 2 Aug 2021 13:49:21 -0300
Message-ID: <CACKVXZBH7M2qNSyCSPwe+M7n-n9jj4Ki5xc9aq0A5HTPB4FTeg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: accel: Add binding documentation
 for ADXL313
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        robh+dt@kernel.org, "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "Berghe, Darius" <Darius.Berghe@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Aug 1, 2021 at 3:01 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 31 Jul 2021 17:36:31 -0300
> Lucas Stankus <lucas.p.stankus@gmail.com> wrote:
>
> > Add device tree binding documentation for ADXL313 3-axis accelerometer.
> >
> > Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
>
> Hi Lucas,
>
> A few minor requests for additions inline, so we include everything
> that is likely to be used by the driver in the longer term.
>
> > ---
> >  .../bindings/iio/accel/adi,adxl313.yaml       | 75 +++++++++++++++++++
> >  1 file changed, 75 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
> > new file mode 100644
> > index 000000000000..31f11d7eaaae
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
> > @@ -0,0 +1,75 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/accel/adi,adxl313.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices ADXL313 3-Axis Digital Accelerometer
> > +
> > +maintainers:
> > +  - Lucas Stankus <lucas.p.stankus@gmail.com>
> > +
> > +description: |
> > +  Analog Devices ADXL313 3-Axis Digital Accelerometer that supports
> > +  both I2C & SPI interfaces.
> > +    https://www.analog.com/en/products/adxl313.html
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,adxl313
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-3wire: true
> > +
> > +  spi-cpha: true
> > +
> > +  spi-cpol: true
> > +
> > +  spi-max-frequency: true
> > +
> > +  interrupts:
> > +    maxItems: 2
>
> As board designers have an annoying habit of wiring up the second
> interrupt only, please also provide interrupt-names so we can
> know which one is connected if it's only one.
>
> From a quick glance at the datasheet, I see this also has two powersupplies.
> Please include
> vddio-supply
> vs-supply - annoyingly the s just stands for supply, but v-supply seems a bit to minimal.
>

Thanks for the feedback, I'll change it for the v2!

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    i2c0 {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        /* Example for a I2C device node */
> > +        accelerometer@53 {
> > +            compatible = "adi,adxl313";
> > +            reg = <0x53>;
> > +            interrupt-parent = <&gpio0>;
> > +            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> > +        };
> > +    };
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        /* Example for a SPI device node */
> > +        accelerometer@0 {
> > +            compatible = "adi,adxl313";
> > +            reg = <0>;
> > +            spi-max-frequency = <5000000>;
> > +            spi-cpol;
> > +            spi-cpha;
> > +            interrupt-parent = <&gpio0>;
> > +            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> > +        };
> > +    };
>
