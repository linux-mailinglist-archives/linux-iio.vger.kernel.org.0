Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07CA301673
	for <lists+linux-iio@lfdr.de>; Sat, 23 Jan 2021 16:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbhAWPjM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Jan 2021 10:39:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:46130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbhAWPjM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Jan 2021 10:39:12 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30B88230FC;
        Sat, 23 Jan 2021 15:38:30 +0000 (UTC)
Date:   Sat, 23 Jan 2021 15:38:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] dt-bindings: iio: accel: Add bmi088
 accelerometer bindings
Message-ID: <20210123153826.0368bf61@archlinux>
In-Reply-To: <20210121155700.9267-1-mike.looijmans@topic.nl>
References: <20210121155700.9267-1-mike.looijmans@topic.nl>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 21 Jan 2021 16:56:58 +0100
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> This adds the device-tree bindings for the Bosch Sensortec BMI088 IMU,
> the accelerometer part.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
Just the issue the build bot found.  Otherwise looks good to me.

Jonathan

> 
> ---
> 
> Changes in v7:
> Add additionalProperties
> Change bmi088_accel to bmi088-accel
> Add interrupt-names and adjust description
> 
> Changes in v6:
> I't been almost a year since the last commit, sorry...
> Fixed the yaml errors
> Add interrupt, vdd and vddio properties
> 
> Changes in v5:
> submit together with driver code as patch series
> 
> Changes in v2:
> convert to yaml format
> 
>  .../bindings/iio/accel/bosch,bmi088.yaml      | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
> new file mode 100644
> index 000000000000..db5dbaf80fa2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accel/bosch,bmi088.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bosch BMI088 IMU accelerometer part
> +
> +maintainers:
> +  - Mike Looijmans <mike.looijmans@topic.nl>
> +
> +description: |
> +  Acceleration part of the IMU sensor with an SPI interface
> +  Specifications about the sensor can be found at:
> +    https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi088-ds001.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - bosch,bmi088-accel
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  vddio-supply: true
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +    description: |
> +      Type should be either IRQ_TYPE_LEVEL_HIGH or IRQ_TYPE_LEVEL_LOW.
> +      Two configurable interrupt lines exist.
> +
> +  interrupt-names:
> +    description: Specify which interrupt line is in use.
> +    items:
> +      enum:
> +        - INT1
> +        - INT2
> +    minItems: 1
> +    maxItems: 2

As per Rob's build bot you need.

spi-max-frequency: true

If that's all that comes up and Rob is happy with this I can fix that up whilst
applying.  Please try to run the checks suggested in Rob's build bot message
before submitting binding patches though.


> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      bmi088-accel@1 {
> +        compatible = "bosch,bmi088-accel";
> +        reg = <1>;
> +        spi-max-frequency = <10000000>;
> +        interrupt-parent = <&gpio6>;
> +        interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
> +        interrupt-names = "INT2";
> +      };
> +    };
> +...

