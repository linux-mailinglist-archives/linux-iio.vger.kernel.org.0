Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680DA2B2E77
	for <lists+linux-iio@lfdr.de>; Sat, 14 Nov 2020 17:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgKNQgC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Nov 2020 11:36:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:57274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgKNQgC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Nov 2020 11:36:02 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EFCE206E3;
        Sat, 14 Nov 2020 16:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605371761;
        bh=WkHWgBBPxf1+qo5Z6uRo4fvwix8WXj08XCmlNflxXhE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tIItlQCDc1XPJebLjUxoeplcK4LT7J8rgx9i/5JGTP1NXtGzCGlnEjdtWzCQJj8Qe
         X0dOxM5EIwo7smKGaw83FxWpbiGAR/Z+KuZ3EFFGM+WU8f9AGS69y/8cVw2Yww2r5t
         6hx0o6hdM14eUcsMPDosvsYzD5qprnVojz1J+c4c=
Date:   Sat, 14 Nov 2020 16:35:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3 v2] iio: accel: bmc150-accel: Add DT bindings
Message-ID: <20201114163557.036363de@archlinux>
In-Reply-To: <20201112215451.2606136-1-linus.walleij@linaro.org>
References: <20201112215451.2606136-1-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 12 Nov 2020 22:54:49 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> These accelerometers have bindings used in the kernel and
> several device trees but no proper bindings documentation.
> Add it.
> 
> Also add a compatible for the BMA222 that I am right now
> adding support for in the driver.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

One little note inline on consistency.

Jonathan

> ---
> ChangeLog v1->v2:
> - Rename to simply bosch,bma255.yaml after one of the
>   common accelerometers.
> - Specify that the SPI uses a 4-wire interface.
> - Specify maximum SPI clock frequency to 10MHz. (Checked
>   all the datasheets.)
> ---
>  .../bindings/iio/accel/bosch,bma255.yaml      | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> new file mode 100644
> index 000000000000..5f48bdcf382c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accel/bosch,bma255.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bosch BMA255 and Similar Accelerometers
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +description:
> +  3 axis accelerometers with varying range and I2C or SPI
> +  4-wire interface.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - bosch,bmc150
> +      - bosch,bmi055
> +      - bosch,bma255
> +      - bosch,bma250e
> +      - bosch,bma222
> +      - bosch,bma222e
> +      - bosch,bma280
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +  vddio-supply: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  mount-matrix:
> +    description: an optional 3x3 mounting rotation matrix.
> +
> +  spi-max-frequency:
> +    maximum: 10000000
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #include <dt-bindings/interrupt-controller/irq.h>
Off the top of my head I'm not sure it matters, but this placement of the
include is inconsistent with the spi case below.  Move it outside the i2c {

If that's all that comes up in this round I'll do it whilst applying.

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        accelerometer@8 {
> +            compatible = "bosch,bma222";
> +            reg = <0x08>;
> +            vddio-supply = <&vddio>;
> +            vdd-supply = <&vdd>;
> +            interrupts = <57 IRQ_TYPE_EDGE_FALLING>;
> +        };
> +    };
> +  - |
> +    # include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        accel@0 {
> +            compatible = "bosch,bma222";
> +            reg = <0>;
> +            spi-max-frequency = <10000000>;
> +        };
> +    };
> +...

