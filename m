Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E211E872C
	for <lists+linux-iio@lfdr.de>; Fri, 29 May 2020 21:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgE2TFS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 May 2020 15:05:18 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33081 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgE2TFR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 May 2020 15:05:17 -0400
Received: by mail-io1-f68.google.com with SMTP id k18so530109ion.0;
        Fri, 29 May 2020 12:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R6IrcuOr+xIS8qM+15+nWNZbx9UeVZbBHOW4JGpwUA4=;
        b=gFRmFUW/LKZVV+Rtuk6z0WF7AUVNxzDBxsuxxg0rip2v3IIOY4dbVDA09eENntwyng
         qe6MyXOMoE7eEm5pPgu7fuMXSMr8lzxU2Znm+FqFry6rvTwPn4VhwAalUyEzBnJdi483
         SrkWqJnCRUzu9uDEcLPMB07MKh8AXrl/vBbkFBkLFQ96/pCp4WuX/w04aBqz6JC45vMR
         2tJXoVjN4XIo/Qvcz+DLdKxv5bmOqrq55INkouJ4EtN3UNiFokft5iFGCfbR8vpHLroC
         nWx2YKCTeHOY69dt/haboURzjrHBJnCHGcMNjwMPvhrJoZ03DYOgEjjZGPPALoV7Vnxa
         kGpw==
X-Gm-Message-State: AOAM5328ySabu/c/08RVDu9T4kCROnffQz4SvLjkgk/TuOzboOlqg+vm
        SX6n9TWlT/YgrRgwGMWdQQ==
X-Google-Smtp-Source: ABdhPJxK4CUOLJI4c7oAaSrxd+y6Vq4RO6Io6d0HZCn/kLF7GEt2cvB9wNbMRyulFYammxECOCcayA==
X-Received: by 2002:a02:a805:: with SMTP id f5mr9006426jaj.130.1590779116574;
        Fri, 29 May 2020 12:05:16 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id u21sm4128479iot.5.2020.05.29.12.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 12:05:15 -0700 (PDT)
Received: (nullmailer pid 2764174 invoked by uid 1000);
        Fri, 29 May 2020 19:05:14 -0000
Date:   Fri, 29 May 2020 13:05:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     jic23@kernel.org, mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/12] dt-bindings: iio: imu: Add inv_icm42600
 documentation
Message-ID: <20200529190514.GA2762360@bogus>
References: <20200527185711.21331-1-jmaneyrol@invensense.com>
 <20200527185711.21331-12-jmaneyrol@invensense.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527185711.21331-12-jmaneyrol@invensense.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, May 27, 2020 at 08:57:10PM +0200, Jean-Baptiste Maneyrol wrote:
> Document the ICM-426xxx devices devicetree bindings.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> ---
>  .../bindings/iio/imu/invensense,icm42600.yaml | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> new file mode 100644
> index 000000000000..c5b046e0ce36
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/invensense,icm42600.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: InvenSense ICM-426xx Inertial Measurement Unit
> +
> +maintainers:
> +  - Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> +
> +description: |
> +  6-axis MotionTracking device that combines a 3-axis gyroscope and a 3-axis accelerometer.
> +
> +  It has a configurable host interface that supports I3C, I2C and SPI serial communication, features a 2kB FIFO and
> +  2 programmable interrupts with ultra-low-power wake-on-motion support to minimize system power consumption.
> +
> +  Other industry-leading features include InvenSense on-chip APEX Motion Processing engine for gesture recognition,
> +  activity classification, and pedometer, along with programmable digital filters, and an embedded temperature sensor.

Wrap lines at <80 chars.

> +
> +  https://invensense.tdk.com/wp-content/uploads/2020/03/DS-000292-ICM-42605-v1.4.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - invensense,icm42600
> +      - invensense,icm42602
> +      - invensense,icm42605
> +      - invensense,icm42622
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  drive-open-drain:
> +    type: boolean
> +
> +  vdd-supply:
> +    description: Regulator that provides power to the sensor
> +
> +  vddio-supply:
> +    description: Regulator that provides power to the bus
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        icm42605@68 {
> +          compatible = "invensense,icm42605";
> +          reg = <0x68>;
> +          interrupt-parent = <&gpio2>;
> +          interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
> +          vdd-supply = <&vdd>;
> +          vddio-supply = <&vddio>;
> +        };
> +    };
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        icm42602@0 {
> +          compatible = "invensense,icm42602";
> +          reg = <0>;
> +          spi-max-frequency = <24000000>;
> +          spi-cpha;
> +          spi-cpol;
> +          interrupt-parent = <&gpio1>;
> +          interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
> +          vdd-supply = <&vdd>;
> +          vddio-supply = <&vddio>;
> +        };
> +    };
> -- 
> 2.17.1
> 
