Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3B83E2F26
	for <lists+linux-iio@lfdr.de>; Fri,  6 Aug 2021 20:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242680AbhHFSKV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Aug 2021 14:10:21 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:41595 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242669AbhHFSKV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 Aug 2021 14:10:21 -0400
Received: by mail-io1-f47.google.com with SMTP id 188so11238417ioa.8;
        Fri, 06 Aug 2021 11:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o/8DRycRobICyqdVPBp3gqhmLeKbJ8RCg30DsK2AwgU=;
        b=OPvhr43OHLfdnuirwEFV1ZOhh/0meQWttEuWpuHUZAkx+wFu/OkWBgH3IIsECn1wyf
         DJticm2m4cekiX3FjGyBvAJDoJSL26PB5Zck+UOqNETNlD37qW7bstARhLhvN5zQbgni
         BPVy4ikRp6VwcaBrfrDEoJ2XFI0FfrDpROv82GYKtjn4uFoAIC/O6KCihbrBxElqKZjV
         0bSYz/BAw369KRo6BOZOeTPZcVPEMK1ZV/ngGp66IzpdFCA/XkyhglsJNeg10GibFH+p
         vYU2rYuv162bhZ3xeZO3RZc8rPL3CXGLT7gNN33zsxOVtUCBzasTlgYlPc2ECiPfbbKS
         HxLw==
X-Gm-Message-State: AOAM533Rg+7GzxG0/Y0I0en+aOM3mr+ADLIfKM9kaveWCA40DQbtfIMx
        wqAYJnlesDa9P/Jd11THXg==
X-Google-Smtp-Source: ABdhPJweqBQ0MpjChKWGENKXYts+lCl0cKtq//sqSkoef9cKusimZTfHxztqZjfbeTHS0bgpMz2qRw==
X-Received: by 2002:a5e:a908:: with SMTP id c8mr450324iod.116.1628273403783;
        Fri, 06 Aug 2021 11:10:03 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id l5sm5760438ion.44.2021.08.06.11.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 11:10:03 -0700 (PDT)
Received: (nullmailer pid 1526278 invoked by uid 1000);
        Fri, 06 Aug 2021 18:10:00 -0000
Date:   Fri, 6 Aug 2021 12:10:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lucas Stankus <lucas.p.stankus@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        Dragos.Bogdan@analog.com, Darius.Berghe@analog.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: accel: Add binding
 documentation for ADXL313
Message-ID: <YQ16+AlpmxhVIBhE@robh.at.kernel.org>
References: <cover.1628143857.git.lucas.p.stankus@gmail.com>
 <ad64c93df8c43c66dcb64fe8ec0c0f6b91b3c697.1628143857.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad64c93df8c43c66dcb64fe8ec0c0f6b91b3c697.1628143857.git.lucas.p.stankus@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 05, 2021 at 03:29:37AM -0300, Lucas Stankus wrote:
> Add device tree binding documentation for ADXL313 3-axis accelerometer.
> 
> Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
> ---
>  .../bindings/iio/accel/adi,adxl313.yaml       | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
> new file mode 100644
> index 000000000000..fea03b6790f3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accel/adi,adxl313.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADXL313 3-Axis Digital Accelerometer
> +
> +maintainers:
> +  - Lucas Stankus <lucas.p.stankus@gmail.com>
> +
> +description: |
> +  Analog Devices ADXL313 3-Axis Digital Accelerometer that supports
> +  both I2C & SPI interfaces.
> +    https://www.analog.com/en/products/adxl313.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adxl313
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-3wire: true
> +
> +  spi-cpha: true
> +
> +  spi-cpol: true

These 3 generally shouldn't be needed, but can be set from the driver. 
If they are valid, is any combination of them really valid?

> +
> +  spi-max-frequency: true
> +
> +  vs-supply:
> +    description: Regulator that supplies power to the accelerometer
> +
> +  vdd-supply:
> +    description: Regulator that supplies the digital interface supply voltage
> +
> +  interrupts:
> +    maxItems: 2

This means there must be 2 entries. If 1 is valid, you need 'minItems'.

> +
> +  interrupt-names:
> +    maxItems: 2

You need 'minItems' too to fix the error.

> +    items:
> +      enum:
> +        - INT1
> +        - INT2
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        /* Example for a I2C device node */
> +        accelerometer@53 {
> +            compatible = "adi,adxl313";
> +            reg = <0x53>;
> +            interrupt-parent = <&gpio0>;
> +            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "INT1";
> +        };
> +    };
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        /* Example for a SPI device node */
> +        accelerometer@0 {
> +            compatible = "adi,adxl313";
> +            reg = <0>;
> +            spi-max-frequency = <5000000>;
> +            spi-cpol;
> +            spi-cpha;
> +            interrupt-parent = <&gpio0>;
> +            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "INT1";
> +        };
> +    };
> -- 
> 2.32.0
> 
> 
