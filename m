Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17813E325C
	for <lists+linux-iio@lfdr.de>; Sat,  7 Aug 2021 02:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhHGAei (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Aug 2021 20:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhHGAeh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 Aug 2021 20:34:37 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE0AC0613CF;
        Fri,  6 Aug 2021 17:34:20 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id c2-20020a0568303482b029048bcf4c6bd9so10852760otu.8;
        Fri, 06 Aug 2021 17:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VTNtwAA6+fkrShAVi/ylsugSqwM1XL4+R4zdkmKyVg8=;
        b=tWhSMQsZdYTm2PfTbCPXFLTXFEOxVhlQ92aCucWcfRandPJ7sgmgkjiHuCsz+GXA8W
         RdqyBJA8+XWmtm7gnJcic50gqS4ngChxcsWDDhW1nuHWIOerrCrnduzF0CPrSmYhKZaF
         gKQAsdAPC+G+4SLkyMHKQqpAVLcTUWJtOc/eongz5xRcrjcGsC3mhjzO8gwUiTtSKyQk
         ozDlP+vx4kRPGwZrE3KQEpYCwsL9NwuYE9EuKRFL2GX9cBY4IXX01+ewAjlRle90R2Np
         foFx8HnuJKgcSh+OUaOa6ukg9YELQ8PgY2BdAA+b/XGPGozTXqJbd34J4I8K9kyevGK8
         rS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VTNtwAA6+fkrShAVi/ylsugSqwM1XL4+R4zdkmKyVg8=;
        b=ZXtnb9esHLus+41twMIem+vRDY/W3nLGWTk+YkdazJj0rMCp5WcwnfIkdPsnjtaPb/
         f9eiQi3zXT8pR7pnKtjOvE8dDptFcm96mo9e+o7wksn1JW0tCecHC+p5CidsIFM8sfL3
         hcNtCRNNY+F0G4uVof5uCi9r20rH/p34pJWWMApByswV5ZbpppxzMDmhMcodf+IEaMJh
         xRHX2xYnaY7j+WCmpNa2rBZFtEG+VkrDiUx2WxAcAoAPbc5yV3w4FW1bpAW4hLHh0k4/
         inYf3lHcvPOhQC3mnCYAdYHYUBY95Lll37oHuPwmNf1ZIsnHnk1PvXDQHIVJdqL6pG7f
         PB7w==
X-Gm-Message-State: AOAM530bMUic+dg0v241lfq/iF1PoxuUhgszHins0OdKfsrHg81ZXA0O
        mdzPII7YZpXeIAHRQSuu0y7AnTPt+SG+Om5yb6I=
X-Google-Smtp-Source: ABdhPJzO2Poi2/dML/V8DOWGa8plOomc5Zv2o+Z5+jp/cX3s2X/Doeh8SenOsgpqoqv/6j/WTPGOACJXMqFN4Xth/To=
X-Received: by 2002:a9d:d86:: with SMTP id 6mr9519349ots.362.1628296459950;
 Fri, 06 Aug 2021 17:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628143857.git.lucas.p.stankus@gmail.com>
 <ad64c93df8c43c66dcb64fe8ec0c0f6b91b3c697.1628143857.git.lucas.p.stankus@gmail.com>
 <YQ16+AlpmxhVIBhE@robh.at.kernel.org>
In-Reply-To: <YQ16+AlpmxhVIBhE@robh.at.kernel.org>
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
Date:   Fri, 6 Aug 2021 21:33:44 -0300
Message-ID: <CACKVXZB-XVYA8FSEucwktH88PBUUBXXjuARWOC02r8TzCzU8Mw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: accel: Add binding documentation
 for ADXL313
To:     Rob Herring <robh@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "Berghe, Darius" <Darius.Berghe@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Aug 6, 2021 at 3:10 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Aug 05, 2021 at 03:29:37AM -0300, Lucas Stankus wrote:
> > Add device tree binding documentation for ADXL313 3-axis accelerometer.
> >
> > Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
> > ---
> >  .../bindings/iio/accel/adi,adxl313.yaml       | 90 +++++++++++++++++++
> >  1 file changed, 90 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
> > new file mode 100644
> > index 000000000000..fea03b6790f3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
> > @@ -0,0 +1,90 @@
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
>
> These 3 generally shouldn't be needed, but can be set from the driver.
> If they are valid, is any combination of them really valid?
>

Only the 3wire is optional, both cpha and cpol are required for proper
spi connection.

> > +
> > +  spi-max-frequency: true
> > +
> > +  vs-supply:
> > +    description: Regulator that supplies power to the accelerometer
> > +
> > +  vdd-supply:
> > +    description: Regulator that supplies the digital interface supply voltage
> > +
> > +  interrupts:
> > +    maxItems: 2
>
> This means there must be 2 entries. If 1 is valid, you need 'minItems'.
>

I'll add 'minItems' for the v3 then, thanks!

> > +
> > +  interrupt-names:
> > +    maxItems: 2
>
> You need 'minItems' too to fix the error.
>

Thank you again and sorry for not catching that error before submitting.

> > +    items:
> > +      enum:
> > +        - INT1
> > +        - INT2
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
> > +            interrupt-names = "INT1";
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
> > +            interrupt-names = "INT1";
> > +        };
> > +    };
> > --
> > 2.32.0
> >
> >
