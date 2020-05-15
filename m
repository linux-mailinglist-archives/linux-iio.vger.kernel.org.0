Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792FD1D43D1
	for <lists+linux-iio@lfdr.de>; Fri, 15 May 2020 05:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgEODAH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 May 2020 23:00:07 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43265 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgEODAG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 May 2020 23:00:06 -0400
Received: by mail-oi1-f196.google.com with SMTP id i22so960722oik.10;
        Thu, 14 May 2020 20:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bjc9M+ltvOohtg90sCLNJrRki6/Nirbm2vS+XeCl5Xk=;
        b=CBr/WwpyQHhBZ4RZa/piW2/x1Cjxykvc2dcSFgZSeCr7HDTeIA+0LM4PhnaerdlTG2
         dxLXHuzmKsReAqCEqCIIPF5bWBMrCq+d+OlFrm+FIqRzG/UkAQnsOpWC+hHO5nM/FrgF
         Kfya+nuqVK6Qtgk6vJnUuKTBgP4/SV3GV9OXhVZjQQ3AzqpmdPYjSLmhslhRS1bBmckD
         C2RL0HIO41Zcq4X59LtaYgoe+ET3umI1SvTAjqcdR8zUPBovw7qFkmIxnqDFjaWudL7r
         qsq/DIrDM02ckpoAM6ah4/gSKP0cD8VfGWb5tuZ00i/5jG49w0vvAbPE5bvkHxqN7gcx
         dalw==
X-Gm-Message-State: AOAM531XwSw/7seKwKOGHy3tUABHpcrcWb0Ts0geRy/ngbiq8ALW3+PN
        kbczIQAcBmoayeRfY9nXDQ==
X-Google-Smtp-Source: ABdhPJw2JGnI3HK1STO/gY+vd05hdLxQM19boTQeYNYuxp5F6jLUKLnTu0URfOrtg50l2/MqoT/tcw==
X-Received: by 2002:aca:d50f:: with SMTP id m15mr713670oig.54.1589511603885;
        Thu, 14 May 2020 20:00:03 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e4sm256580oou.33.2020.05.14.20.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 20:00:03 -0700 (PDT)
Received: (nullmailer pid 11296 invoked by uid 1000);
        Fri, 15 May 2020 03:00:02 -0000
Date:   Thu, 14 May 2020 22:00:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     jic23@kernel.org, mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] dt-bindings: iio: imu: Add inv_icm42600
 documentation
Message-ID: <20200515030002.GA6242@bogus>
References: <20200507144222.20989-1-jmaneyrol@invensense.com>
 <20200507144222.20989-12-jmaneyrol@invensense.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507144222.20989-12-jmaneyrol@invensense.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, May 07, 2020 at 04:42:21PM +0200, Jean-Baptiste Maneyrol wrote:
> Document the ICM-426xxx devices devicetree bindings.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> ---
>  .../bindings/iio/imu/invensense,icm42600.yaml | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> new file mode 100644
> index 000000000000..a7175f6543fa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> @@ -0,0 +1,90 @@
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
> +  spi-cpha: true
> +
> +  spi-cpol: true

It doesn't make much sense to specify these and not make them required. 
I guess you could have a device with multiple modes, but generally 
there's only one right combination of these properties. Also, this could 
just be implied by the compatible.

> +
> +  spi-max-frequency:
> +    maxItems: 1

Not an array. Either give a frequency range (minimum/maximum) or just 
'true'.

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
