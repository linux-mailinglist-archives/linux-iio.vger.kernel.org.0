Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A17345835D
	for <lists+linux-iio@lfdr.de>; Sun, 21 Nov 2021 13:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238055AbhKUMeQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Nov 2021 07:34:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:43708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237951AbhKUMeP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Nov 2021 07:34:15 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9A7060E54;
        Sun, 21 Nov 2021 12:31:09 +0000 (UTC)
Date:   Sun, 21 Nov 2021 12:36:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings:iio:amplifiers: add ad7293 doc
Message-ID: <20211121123603.3d683f96@jic23-huawei>
In-Reply-To: <20211115102340.164547-2-antoniu.miclaus@analog.com>
References: <20211115102340.164547-1-antoniu.miclaus@analog.com>
        <20211115102340.164547-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 15 Nov 2021 12:23:40 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add device tree bindings for the AD7293 Power Amplifier.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Hi Antoniu,

A few trivial things inline that I'd missed before.

Jonathan

> ---
> no changes in v3
>  .../bindings/iio/amplifiers/adi,ad7293.yaml   | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,ad7293.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,ad7293.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,ad7293.yaml
> new file mode 100644
> index 000000000000..9f1b2eb78af3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,ad7293.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/amplifiers/adi,ad7293.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AD7293 12-Bit Power Amplifier Current Controller with ADC,
> +       DACs, Temperature and Current Sensors
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +   Power Amplifier drain current controller containing functionality
> +   for general-purpose monitoring and control of current, voltage,
> +   and temperature, integrated into a single chip solution with an
> +   SPI-compatible interface.
> +
> +   https://www.analog.com/en/products/ad7293.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7293
> +
> +  avdd-supply:
> +    description:
> +      AVDD voltage regulator.

Not sure these descriptions add anything. 
avdd-supply: true 
is fine. 

> +
> +  vdrive-supply:
> +    description:
> +      VDRIVE voltage regulator.
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 1000000
> +
> +  reset-gpios: true

Specify how many?
maxItems: 1

> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +  - vdrive-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      ad7293@0 {
> +        compatible = "adi,ad7293";
> +        reg = <0>;
> +        spi-max-frequency = <1000000>;
> +        avdd-supply = <&avdd>;
> +        vdrive-supply = <&vdrive>;
> +        reset-gpios = <&gpio 10 0>;
> +      };
> +    };
> +...

