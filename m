Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009133EC45A
	for <lists+linux-iio@lfdr.de>; Sat, 14 Aug 2021 20:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238918AbhHNSNy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Aug 2021 14:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238871AbhHNSNx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Aug 2021 14:13:53 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F0BC061764;
        Sat, 14 Aug 2021 11:13:24 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z20so26304431lfd.2;
        Sat, 14 Aug 2021 11:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Fr280+14Qksdr9bVHi5lpgCEVsgQK8GCDdNrcSUDUaM=;
        b=LlSeeiK7NbrcogoSlTzRe3hKc/MSAKtkznDjl5/wTnlPdhGIeKv7Zej9DzYYKJgP02
         cc+YdkNP0PuHLtihb+cvvnJjGJkxAI0VPh+x27jExD8bcgbioVq7xtW6SRNeeWSqauyn
         aRmdH1FD0Z0Q9YIBv1S7c80QCXBu9Wwd93CjuUISgmPViQRMDnPQpUWcqGcMMbhYv0Gy
         RtC8vArEFRDVW/i/97GJITXi70Nej5g6AHdlS4LLuFOJgbTbnxm6WdCETddoqkjqxeCv
         e42SpOCzqPekVrR5xfyGD0L94YxycIZPJ44rxzjdY4UQRGGwz2hO7F57zBLlvDRRPvnG
         0JiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Fr280+14Qksdr9bVHi5lpgCEVsgQK8GCDdNrcSUDUaM=;
        b=GTkHFhvvxY1BmrPINZUMm6YBDoGy/xEJf2Wx/PYwQ5HjK3CU++G3dqclscNB0mt4rA
         Kw/rfg5bwOv95yb+GjR3WPeFjKR3ismJ5+MIq5unbFmVxA0DE4hLOH/BDGqIwb08x7sH
         IYsJ7Fp52PlWLAEbe51wwzWCJWbi8/Fbq4yKKiKjCdbDKahy1T2F1TJc5cKdCyMA7LPj
         m0t9ofIaAwn4j9tmRdJdpgVLMQIgIJczhimMAEneoXGX0Mhaxbuk6mCOTw2KfDHG9FWB
         WU3tW6xcuGVxummi7st92lMQs0VW4XriWvH0ZlosWFYXcH7rA+HOVB0LipflqxTySljv
         m0MA==
X-Gm-Message-State: AOAM532Y/sDM9JffFVqRJt5tVlpXIBQkLA0EDmd8pQpZUUzZqc/DcjBP
        hEs0Uc9g/xUA5/euQ/4M++mmIi4mCPguYvuLm/4=
X-Google-Smtp-Source: ABdhPJy54Cd63VxN4BqT4/L5a6ogEuyBj3U9DKFv4wu9Fi+Ls6EIEkwiEpz0IkESb5BPgdtbW7yWgXSHIBvLG0j9fqg=
X-Received: by 2002:a05:6512:3d13:: with SMTP id d19mr5454662lfv.607.1628964803086;
 Sat, 14 Aug 2021 11:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210811073027.124619-1-puranjay12@gmail.com> <20210811073027.124619-2-puranjay12@gmail.com>
In-Reply-To: <20210811073027.124619-2-puranjay12@gmail.com>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Sat, 14 Aug 2021 23:43:11 +0530
Message-ID: <CANk7y0hhkDBmN3bJuhBpMUm2YLAvV-z6=A7zVrk-d86ZxmZ9bg@mail.gmail.com>
Subject: Re: [PATCH v12 1/2] dt-bindings: iio: accel: Add DT binding doc for ADXL355
To:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "Berghe, Darius" <Darius.Berghe@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

+cc Rob Herring <robh+dt@kernel.org>

On Wed, Aug 11, 2021 at 1:00 PM Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> Add devicetree binding document for ADXL355, a 3-Axis MEMS Accelerometer.
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  .../bindings/iio/accel/adi,adxl355.yaml       | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
>
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
> new file mode 100644
> index 000000000..ba54d6998
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accel/adi,adxl355.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADXL355 3-Axis, Low noise MEMS Accelerometer
> +
> +maintainers:
> +  - Puranjay Mohan <puranjay12@gmail.com>
> +
> +description: |
> +  Analog Devices ADXL355 3-Axis, Low noise MEMS Accelerometer that supports
> +  both I2C & SPI interfaces
> +    https://www.analog.com/en/products/adxl355.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adxl355
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 3
> +    description: |
> +      Type for DRDY should be IRQ_TYPE_EDGE_RISING.
> +      Three configurable interrupt lines exist.
> +
> +  interrupt-names:
> +    description: Specify which interrupt line is in use.
> +    items:
> +      enum:
> +        - INT1
> +        - INT2
> +        - DRDY
> +    minItems: 1
> +    maxItems: 3
> +
> +  vdd-supply:
> +    description: Regulator that provides power to the sensor
> +
> +  vddio-supply:
> +    description: Regulator that provides power to the bus
> +
> +  spi-max-frequency: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +        #include <dt-bindings/gpio/gpio.h>
> +        #include <dt-bindings/interrupt-controller/irq.h>
> +        i2c {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                /* Example for a I2C device node */
> +                accelerometer@1d {
> +                        compatible = "adi,adxl355";
> +                        reg = <0x1d>;
> +                        interrupt-parent = <&gpio>;
> +                        interrupts = <25 IRQ_TYPE_EDGE_RISING>;
> +                        interrupt-names = "DRDY";
> +                };
> +        };
> +  - |
> +        #include <dt-bindings/gpio/gpio.h>
> +        #include <dt-bindings/interrupt-controller/irq.h>
> +        spi {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                accelerometer@0 {
> +                        compatible = "adi,adxl355";
> +                        reg = <0>;
> +                        spi-max-frequency = <1000000>;
> +                        interrupt-parent = <&gpio>;
> +                        interrupts = <25 IRQ_TYPE_EDGE_RISING>;
> +                        interrupt-names = "DRDY";
> +                };
> +        };
> --
> 2.30.1
>


-- 
Thanks and Regards

Yours Truly,

Puranjay Mohan
