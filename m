Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE5F3D68F7
	for <lists+linux-iio@lfdr.de>; Mon, 26 Jul 2021 23:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbhGZVKq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Jul 2021 17:10:46 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:35581 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbhGZVKo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Jul 2021 17:10:44 -0400
Received: by mail-io1-f48.google.com with SMTP id y9so13765404iox.2;
        Mon, 26 Jul 2021 14:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EucOrNEax0yc+wNW+WGv1rmiqY2SuufXjZhn/+o2D9w=;
        b=AfAcihn9XMFAy5YV1jCnDqzPE/91RazyTcFKDBt9uuYFIX6Qkk+s1C7hhdve0DPITE
         4iVOZZVvh22J1GZr5p+50YL17pGxZuNPJmj5+tXFO5ku3ORnJRkz9L9GMw14LhA1XEJw
         VMRwiZrmjwdYkFx2ArA4CX4/xFXhtm94A0sdgLc7OEjyhROYZnRYD/zzhLP513jWOnCj
         vVX6THQepW75HXjMwAr1vKPrjovO+l+d/e7fpAyXeiWzPKZCSLImuamhPr1BT5qeTzK5
         /XxdqMH9Xy45g9Xbo3SZc37CZQE1LWAQQt0O3xBAC6lzfp/GaCBx0MzEABNnz17yIfOM
         jLXQ==
X-Gm-Message-State: AOAM531xkdIoykuDNgSEHYhnb5Frfwzm+ZYee8aGdUC41Br1EAhIxHBA
        QafzVgxZ0MXaC6yzoT3g5Q==
X-Google-Smtp-Source: ABdhPJxjQmNcsiQ+vbyzjT7CNQ3QbQcK8wgqmem+laWCgmu/NxrKtst14fw9izfWNfxHe2X63O8plA==
X-Received: by 2002:a5d:84d2:: with SMTP id z18mr16613279ior.130.1627336272466;
        Mon, 26 Jul 2021 14:51:12 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id v14sm643591ioh.11.2021.07.26.14.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 14:51:11 -0700 (PDT)
Received: (nullmailer pid 927730 invoked by uid 1000);
        Mon, 26 Jul 2021 21:51:08 -0000
Date:   Mon, 26 Jul 2021 15:51:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Michael.Hennerich@analog.com, alexandru.ardelean@analog.com,
        jic23@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Dragos.Bogdan@analog.com, Darius.Berghe@analog.com
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: accel: Add DT binding doc for
 ADXL355
Message-ID: <20210726215108.GA925542@robh.at.kernel.org>
References: <20210726184917.301070-1-puranjay12@gmail.com>
 <20210726184917.301070-2-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726184917.301070-2-puranjay12@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 27, 2021 at 12:19:16AM +0530, Puranjay Mohan wrote:
> Add devicetree binding document for ADXL355, a 3-Axis MEMS Accelerometer.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  .../bindings/iio/accel/adi,adxl355.yaml       | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
> new file mode 100644
> index 000000000..e40899fe8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: GPL-2.0

For new bindings:

GPL-2.0-only OR BSD-2-Clause

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
> +    items:
> +      - description: DRDY PIN
> +      - description: INT1 PIN
> +      - description: INT2 PIN
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
> +        i2c0 {

i2c {

> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                /* Example for a I2C device node */
> +                accelerometer@1D {

lowercase hex.

> +                        compatible = "adi,adxl355";
> +                        reg = <0x1D>;
> +                        interrupt-parent = <&gpio>;
> +                        interrupts = <25 IRQ_TYPE_EDGE_RISING>;
> +                };
> +        };
> +  - |
> +        #include <dt-bindings/gpio/gpio.h>
> +        #include <dt-bindings/interrupt-controller/irq.h>
> +        spi0 {

spi {

> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                accelerometer@0 {
> +                        compatible = "adi,adxl355";
> +                        reg = <0>;
> +                        spi-max-frequency = <1000000>;
> +                        interrupt-parent = <&gpio>;
> +                        interrupts = <25 IRQ_TYPE_EDGE_RISING>;
> +                };
> +        };
> -- 
> 2.30.1
> 
> 
