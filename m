Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAFE1DFEB2
	for <lists+linux-iio@lfdr.de>; Sun, 24 May 2020 13:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgEXLlU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 May 2020 07:41:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbgEXLlU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 May 2020 07:41:20 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D103B2075F;
        Sun, 24 May 2020 11:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590320479;
        bh=8ZAPT2spP3nkobeWSQ+7g6/OU1ai1KDStJyS50keCKs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DPC+Obpx7Oe8ECa/1kOLIOeOrM86DUyuz5pePhMZY9FTz0odbwNGvVztbXgR8oTa0
         pxozpwFI5iPnOaXB/axSpJzq4uUon2qjEz1Kp7a/GoGNrWEPXycIvm1XTTXyZlNxic
         Tzg7E2ROzj5fC2fLI1e/ISgHo5l+IR6ULWzRQnNs=
Date:   Sun, 24 May 2020 12:41:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, daniel.baluta@nxp.com,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED 
        DEVICE TREE BINDINGS), Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/5] dt-bindings: iio: imu: bmi160: convert txt
 format to yaml
Message-ID: <20200524124114.7f4e785d@archlinux>
In-Reply-To: <20200520194656.16218-2-jonathan.albrieux@gmail.com>
References: <20200520194656.16218-1-jonathan.albrieux@gmail.com>
        <20200520194656.16218-2-jonathan.albrieux@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 May 2020 21:46:40 +0200
Jonathan Albrieux <jonathan.albrieux@gmail.com> wrote:

> Converts documentation from txt format to yaml.
> 
> Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>

A reminder on the maintainer bit as that thread crossed with
this one.  Also, drop the spi-max-frequency as we don't need
to mention it explicitly for this device.

Thanks,

Jonathan


> ---
>  .../devicetree/bindings/iio/imu/bmi160.txt    | 37 ---------
>  .../bindings/iio/imu/bosch,bmi160.yaml        | 76 +++++++++++++++++++
>  2 files changed, 76 insertions(+), 37 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
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
> diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
> new file mode 100644
> index 000000000000..46cb4fde1165
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/bosch,bmi160.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bosch BMI160
> +
> +maintainers:
> +  - Daniel Baluta <daniel.baluta@nxp.com> (?)

Daniel's reply crossed with this.  Given he's moved on to other things
he's not happy to be listed as maintainer here.

Given other threads, either put yourself here if you are happy to maintain
the binding, or fall back to me but use my kernel.org address.

Jonathan Cameron <jic23@kernel.org>

I don't mind either way.


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
> +
> +  spi-max-frequency:
> +    maxItems: 1

spi-max-frequency doesn't need to be here at all.   We aren't trying to list
all of the properties that might be present - but rather those that
are either required or that are part of the description of the device.
This one is a generic spi binding that may or may not be present.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    enum:
> +      - INT1
> +      - INT2
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
> +    i2c {
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
> +    };
> +  - |
> +    // Example for SPI
> +    spi {
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

