Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF5F518E35C
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 18:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgCUReS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 13:34:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbgCUReR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Mar 2020 13:34:17 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5463720732;
        Sat, 21 Mar 2020 17:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584812056;
        bh=+8IuH4N8gU6bDTiLZrb/LI70N52Wo6+hfsxdmBqHfsA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=snttKF8uQwkVxVaOsxU3M5e/WiIo9HY2SdbOJT4XO5ccLj4Dg+EEasOkSIpbNRCSQ
         GeFGstryolTiyGQVYL47Eh6Lb0eV4ATEji996AoQY07AvmpNFsigJMklAamNRgQ7Cy
         4aB1Q9KciHdzY0y1MTZOvXSuwDddS3x8qrBTQWrg=
Date:   Sat, 21 Mar 2020 17:34:12 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Lazar <alazar@startmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: Add MAX1241 device tree
 bindings in documentation
Message-ID: <20200321173412.52548ef1@archlinux>
In-Reply-To: <20200320150114.9297-2-alazar@startmail.com>
References: <20200320150114.9297-1-alazar@startmail.com>
        <20200320150114.9297-2-alazar@startmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 20 Mar 2020 17:01:14 +0200
Alexandru Lazar <alazar@startmail.com> wrote:

> Add device-tree bindings documentation for the MAX1241 device driver.
> 
> Signed-off-by: Alexandru Lazar <alazar@startmail.com>

Please consider also adding the vdd-supply.
It's not really required, but if you don't add it from the start
chances are high that at some point someone else will need to
add it.

One trivial thing inline.  Otherwise looks good to me.

> ---
>  .../bindings/iio/adc/maxim,max1241.yaml       | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
> new file mode 100644
> index 000000000000..de41d422ce3b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright 2020 Ioan-Alexandru Lazar
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/maxim,max1241.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX1241 12-bit, single-channel analog to digital converter
> +
> +maintainers:
> +  - Ioan-Alexandru Lazar <alazar@startmail.com>
> +
> +description: |
> +  Bindings for the max1241 12-bit, single-channel ADC device. This
> +  driver supports voltage reading and can optionally be configured for

Driver shouldn't be mentioned in the binding. It's a description of the
hardware only.

> +  power-down mode operation. The datasheet can be found at:
> +    https://datasheets.maximintegrated.com/en/ds/MAX1240-MAX1241.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max1241
> +
> +  reg:
> +    maxItems: 1
> +
> +  vref-supply:
> +    description:
> +      Device tree identifier of the regulator that provides the external
> +      reference voltage.
> +    maxItems: 1
> +
> +  shdn-gpios:
> +    description:
> +      GPIO spec for the GPIO pin connected to the ADC's /SHDN pin. If
> +      specified, the /SHDN pin will be asserted between conversions,
> +      thus enabling power-down mode.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vref-supply
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi0 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "maxim,max1241";
> +            reg = <0>;
> +            vref-supply = <&vdd_3v3_reg>;
> +            spi-max-frequency = <1000000>;
> +            shdn-gpios = <&gpio 26 1>;
> +        };
> +    };
> +
> +

