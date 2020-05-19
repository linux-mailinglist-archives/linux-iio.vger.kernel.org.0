Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1261D9F0C
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 20:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgESSUd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 14:20:33 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:32857 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESSUc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2020 14:20:32 -0400
Received: by mail-io1-f65.google.com with SMTP id k18so233767ion.0;
        Tue, 19 May 2020 11:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C/+WbZpW6fzoYD8VkS+1aw3FrtrjaYr1YvJ99Voi0R4=;
        b=kO8SdHtPYtx4WlNekh///W47p5bLJ3HKmJnWO+tJLCb2e8IemaCxZIUTU0AgS80aFH
         fzLJ2z2YhyeUchBnZVu7KdTC0eUgBGTYZ3Umt3dfU6yTORf6xKHCl6mIlKicXsA9fQbG
         dx+N2pUM81o2XnPF7khQPlp7KZJ7TWLyEhF8GxRGR/zeXtp5peuFqLQACjDJzHn3VsPX
         C/YvdGRX8AEwlTBYT1VkxZrzkhAD5rdV/J7JDfdfg2DJes/A+F9XL3rcMKbDu+FMoNNl
         IGRIiaxjWsqPz6uNn5kLWT5eAqQZ8xO+xBWuOEmRnKX6DZbmEG7twp4KKnkKZyUM1jgA
         zxyw==
X-Gm-Message-State: AOAM531fA22VaGrZ6elvjc01gS+9XcjLleJRmoQAnVRCXaKHU2yeL2qb
        tln5M1Ktts/gkW7f29+C+g==
X-Google-Smtp-Source: ABdhPJy915OuehRkdPhEfoQo98D64T4fLNa9nG2JB08WidQt3qwfV8ozXd5uAN5DAlsvXCG3xjpzPg==
X-Received: by 2002:a6b:b685:: with SMTP id g127mr214847iof.192.1589912431059;
        Tue, 19 May 2020 11:20:31 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id j15sm101169ilk.0.2020.05.19.11.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 11:20:29 -0700 (PDT)
Received: (nullmailer pid 409338 invoked by uid 1000);
        Tue, 19 May 2020 18:20:28 -0000
Date:   Tue, 19 May 2020 12:20:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: imu: bmi160: convert txt format
 to yaml
Message-ID: <20200519182028.GB342367@bogus>
References: <20200519075111.6356-1-jonathan.albrieux@gmail.com>
 <20200519075111.6356-2-jonathan.albrieux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519075111.6356-2-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 19, 2020 at 09:50:57AM +0200, Jonathan Albrieux wrote:
> Converts documentation from txt format to yaml 
> 
> Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> ---
>  .../devicetree/bindings/iio/imu/bmi160.txt    | 37 --------
>  .../devicetree/bindings/iio/imu/bmi160.yaml   | 84 +++++++++++++++++++
>  2 files changed, 84 insertions(+), 37 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.yaml

Use compatible string for filename: bosch,bmi160.yaml

> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/bmi160.txt b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
> deleted file mode 100644
> index 900c169de00f..000000000000
> --- a/Documentation/devicetree/bindings/iio/imu/bmi160.txt
> +++ /dev/null
> @@ -1,37 +0,0 @@
> -Bosch BMI160 - Inertial Measurement Unit with Accelerometer, Gyroscope
> -and externally connectable Magnetometer
> -
> -https://www.bosch-sensortec.com/bst/products/all_products/bmi160
> -
> -Required properties:
> - - compatible : should be "bosch,bmi160"
> - - reg : the I2C address or SPI chip select number of the sensor
> - - spi-max-frequency : set maximum clock frequency (only for SPI)
> -
> -Optional properties:
> - - interrupts : interrupt mapping for IRQ
> - - interrupt-names : set to "INT1" if INT1 pin should be used as interrupt
> -   input, set to "INT2" if INT2 pin should be used instead
> - - drive-open-drain : set if the specified interrupt pin should be configured as
> -   open drain. If not set, defaults to push-pull.
> -
> -Examples:
> -
> -bmi160@68 {
> -	compatible = "bosch,bmi160";
> -	reg = <0x68>;
> -
> -	interrupt-parent = <&gpio4>;
> -	interrupts = <12 IRQ_TYPE_EDGE_RISING>;
> -	interrupt-names = "INT1";
> -};
> -
> -bmi160@0 {
> -	compatible = "bosch,bmi160";
> -	reg = <0>;
> -	spi-max-frequency = <10000000>;
> -
> -	interrupt-parent = <&gpio2>;
> -	interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
> -	interrupt-names = "INT2";
> -};
> diff --git a/Documentation/devicetree/bindings/iio/imu/bmi160.yaml b/Documentation/devicetree/bindings/iio/imu/bmi160.yaml
> new file mode 100644
> index 000000000000..6b464ce5ed0b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/bmi160.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/bmi160.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bosch BMI160
> +
> +maintainers:
> +  - can't find a mantainer, author is Daniel Baluta <daniel.baluta@intel.com>

Would help to Cc him perhaps.

> +
> +description: |
> +  Inertial Measurement Unit with Accelerometer, Gyroscope and externally
> +  connectable Magnetometer
> +  https://www.bosch-sensortec.com/bst/products/all_products/bmi160
> +
> +properties:
> +  compatible:
> +    const: bosch,bmi160
> +
> +  reg:
> +    maxItems: 1
> +    description: the I2C address or SPI chip select number of the sensor
> +
> +  spi-max-frequency:
> +    maxItems: 1
> +    description: set maximum clock frequency (required only for SPI)
> +
> +  interrupts:
> +    maxItems: 1
> +    description: interrupt mapping for IRQ

No need for description if not adding anything unique for this device.

> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 1
> +    items:
> +      enum:
> +        - INT1
> +        - INT2

Just the enum is enough.

> +    description: |
> +      set to "INT1" if INT1 pin should be used as interrupt input, set
> +      to "INT2" if INT2 pin should be used instead
> +
> +  drive-open-drain:
> +    description: |
> +      set if the specified interrupt pin should be configured as
> +      open drain. If not set, defaults to push-pull.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    // Example for I2C
> +    i2c@78b7000 {
> +        reg = <0x78b6000 0x600>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        bmi160@68 {
> +                compatible = "bosch,bmi160";
> +                reg = <0x68>;
> +                interrupt-parent = <&gpio4>;
> +                interrupts = <12 1>;
> +                interrupt-names = "INT1";
> +        };
> +  - |
> +    // Example for SPI
> +    spi@78b7000 {
> +        reg = <0x78b7000 0x600>,
> +              <0x7884000 0x23000>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        bmi160@0 {
> +                compatible = "bosch,bmi160";
> +                reg = <0>;
> +                spi-max-frequency = <10000000>;
> +                interrupt-parent = <&gpio2>;
> +                interrupts = <12 1>;
> +                interrupt-names = "INT2";
> +        };
> +    };
> -- 
> 2.17.1
> 
