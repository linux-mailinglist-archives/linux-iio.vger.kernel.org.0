Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A78E23536B
	for <lists+linux-iio@lfdr.de>; Sat,  1 Aug 2020 18:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgHAQfn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Aug 2020 12:35:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbgHAQfn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Aug 2020 12:35:43 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F8D62076B;
        Sat,  1 Aug 2020 16:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596299742;
        bh=mslJL+QZ9w3cgAbtxFNEcDATC0aP9GWwaBPrIDRGBFE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P6NKBUMqG/QieprKQIwJVyq+mfEyJ2y/waL7pbOsSDAQukwqPzyakQ2EL2GBw7M1u
         OwrGOGiSqwLtWInZXGy51hC7Uf9oli5APvRfNb5We8o3BLvDvUDphyoYI2nVPkning
         QzwmU4HdXhjSqHZen8k44FcZA4aPVGjrUawSg0eE=
Date:   Sat, 1 Aug 2020 17:35:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     robh+dt@kernel.org, dragos.bogdan@analog.com,
        darius.berghe@analog.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [v4 2/2] dt-bindings: iio: gyro: Add DT binding doc for
 ADXRS290
Message-ID: <20200801173538.381f6463@archlinux>
In-Reply-To: <20200726141026.2888-1-nish.malpani25@gmail.com>
References: <20200726141026.2888-1-nish.malpani25@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 26 Jul 2020 19:40:26 +0530
Nishant Malpani <nish.malpani25@gmail.com> wrote:

> Add devicetree binding document for ADXRS290, a dual-axis MEMS gyroscope.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with them.

Note this won't make the coming merge window, so will go in next cycle.

Thanks,

Jonathan

> ---
> 
> No changes in v4.
> 
> No changes in v3.
> 
> Changes in v2:
>   - use 'const' instead of 'enum' while setting the compatible string
>     since only a single item is expected
>   - add 'additionalProperties: false'
> ---
>  .../bindings/iio/gyroscope/adi,adxrs290.yaml  | 53 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml b/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
> new file mode 100644
> index 000000000000..61adb2c2454b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2020 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/gyroscope/adi,adxrs290.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADXRS290 Dual-Axis MEMS Gyroscope
> +
> +maintainers:
> +  - Nishant Malpani <nish.malpani25@gmail.com>
> +
> +description: |
> +  Bindings for the Analog Devices ADXRS290 dual-axis MEMS gyroscope device.
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADXRS290.pdf
> +
> +properties:
> +  compatible:
> +    const: adi,adxrs290
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 5000000
> +
> +  spi-cpol: true
> +
> +  spi-cpha: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +  - spi-cpol
> +  - spi-cpha
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        gyro@0 {
> +                   compatible = "adi,adxrs290";
> +                   reg = <0>;
> +                   spi-max-frequency = <5000000>;
> +                   spi-cpol;
> +                   spi-cpha;
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 71ae9b184179..bb2cd4ee140c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1103,6 +1103,7 @@ M:	Nishant Malpani <nish.malpani25@gmail.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
>  F:	drivers/iio/gyro/adxrs290.c
> +F:	Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
>  
>  ANALOG DEVICES INC ASOC CODEC DRIVERS
>  M:	Lars-Peter Clausen <lars@metafoo.de>

