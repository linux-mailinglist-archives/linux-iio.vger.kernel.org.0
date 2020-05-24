Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69A81DFF87
	for <lists+linux-iio@lfdr.de>; Sun, 24 May 2020 16:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgEXO5y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 May 2020 10:57:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728875AbgEXO5w (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 May 2020 10:57:52 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62835207DA;
        Sun, 24 May 2020 14:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590332271;
        bh=Ir8+//YCW7/EMwn4xgZG5V3ZxTNEqlIR9sSF+xwW0Mg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aW0qrc2ozRETKJW3qbc7PtQ7Mt5gHD5ABHMn+Wc4O0Sx+aaP1ESsQOoGtKoXd+mli
         xmEBZVmafyJ3EyepZ6dBbdTx52zE4DtQPTrnuEjYfT1HyWFNgik18mfFndZ2+oaSa+
         Zw21c8PGis+bLD++n4Hgul5mXkEFxxXJq7ic1uuQ=
Date:   Sun, 24 May 2020 15:57:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED 
        DEVICE TREE BINDINGS),
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 1/4] dt-bindings: iio: magnetometer: ak8975: convert
 format to yaml, add maintainer
Message-ID: <20200524155745.3b9320db@archlinux>
In-Reply-To: <20200520163417.27805-2-jonathan.albrieux@gmail.com>
References: <20200520163417.27805-1-jonathan.albrieux@gmail.com>
        <20200520163417.27805-2-jonathan.albrieux@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 May 2020 18:34:06 +0200
Jonathan Albrieux <jonathan.albrieux@gmail.com> wrote:

> Converts documentation from txt format to yaml.
> 
> Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>

An additional request inline.  Doesn't effect this patch 'as such'.

Also the file name thing just below here.

> ---
>  .../bindings/iio/magnetometer/ak8975.txt      | 30 --------
>  .../bindings/iio/magnetometer/ak8975.yaml     | 71 +++++++++++++++++++
File naming should match the compatible.

ashahi-kasei,ak8975.yaml

>  2 files changed, 71 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
> deleted file mode 100644
> index aa67ceb0d4e0..000000000000
> --- a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -* AsahiKASEI AK8975 magnetometer sensor
> -
> -Required properties:
> -
> -  - compatible : should be "asahi-kasei,ak8975"
> -  - reg : the I2C address of the magnetometer
> -
> -Optional properties:
> -
> -  - gpios : should be device tree identifier of the magnetometer DRDY pin
> -  - vdd-supply: an optional regulator that needs to be on to provide VDD
> -  - mount-matrix: an optional 3x3 mounting rotation matrix
> -
> -Example:
> -
> -ak8975@c {
> -        compatible = "asahi-kasei,ak8975";
> -        reg = <0x0c>;
> -        gpios = <&gpj0 7 0>;
> -        vdd-supply = <&ldo_3v3_gnss>;
> -        mount-matrix = "-0.984807753012208",  /* x0 */
> -                       "0",                   /* y0 */
> -                       "-0.173648177666930",  /* z0 */
> -                       "0",                   /* x1 */
> -                       "-1",                  /* y1 */
> -                       "0",                   /* z1 */
> -                       "-0.173648177666930",  /* x2 */
> -                       "0",                   /* y2 */
> -                       "0.984807753012208";   /* z2 */
> -};
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml
> new file mode 100644
> index 000000000000..8bde423a2ffa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/magnetometer/ak8975.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AsahiKASEI AK8975 magnetometer sensor
> +
> +maintainers:
> +  - Jonathan Albrieux <jonathan.albrieux@gmail.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: asahi-kasei,ak8975
> +      - const: asahi-kasei,ak8963
> +      - const: asahi-kasei,ak09911
> +      - const: asahi-kasei,ak09912
> +      - const: ak8975
> +        deprecated: true
> +      - const: ak8963
> +        deprecated: true
> +      - const: ak09911
> +        deprecated: true
> +      - const: ak09912
> +        deprecated: true
> +
> +  reg:
> +    maxItems: 1
> +    description: the I2C address of the magnetometer
> +
> +  gpios:
> +    description: should be device tree identifier of the magnetometer DRDY pin

Nothing to do with your patch obviously but this is horrible...
+ the driver will quite happily take an interrupt instead.

Do you mind documenting the interrupt here as well?

Should be a separate patch though.  So a follow up one to
this one.  The 
arch/arm/boot/dts/motorola-mapphone-common.dtsi
does it that way, unlike the samsung s3 which uses the gpio
binding (I think it's the only one against quite a few
using interrupts).

Also switch the example to an interrupts one so we don't
encourage anyone to go the gpios route.

Note can be a follow up if this series is otherwise ready to go.


> +
> +  vdd-supply:
> +    maxItems: 1
> +    description: |
> +      an optional regulator that needs to be on to provide VDD power to
> +      the sensor.
> +
> +  mount-matrix:
> +    description: an optional 3x3 mounting rotation matrix
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    i2c@78b7000 {
> +        reg = <0x78b6000 0x600>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        magnetometer@c {
> +            compatible = "asahi-kasei,ak8975";
> +            reg = <0x0c>;
> +            gpios = <&gpj0 7 GPIO_ACTIVE_HIGH>;
> +            vdd-supply = <&ldo_3v3_gnss>;
> +            mount-matrix = "-0.984807753012208",  /* x0 */
> +                           "0",                   /* y0 */
> +                           "-0.173648177666930",  /* z0 */
> +                           "0",                   /* x1 */
> +                           "-1",                  /* y1 */
> +                           "0",                   /* z1 */
> +                           "-0.173648177666930",  /* x2 */
> +                           "0",                   /* y2 */
> +                           "0.984807753012208";   /* z2 */
> +        };
> +    };

