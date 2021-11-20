Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51685457FB0
	for <lists+linux-iio@lfdr.de>; Sat, 20 Nov 2021 17:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhKTQ7O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Nov 2021 11:59:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:38474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230248AbhKTQ7O (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Nov 2021 11:59:14 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85FCC60ED5;
        Sat, 20 Nov 2021 16:56:08 +0000 (UTC)
Date:   Sat, 20 Nov 2021 17:01:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Iain Hunter <drhunter95@gmail.com>
Cc:     iain@hunterembedded.co.uk, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Add binding for IIO ADS1018
Message-ID: <20211120170101.68d3fd08@jic23-huawei>
In-Reply-To: <20211117094109.402397-1-drhunter95@gmail.com>
References: <20211117094109.402397-1-drhunter95@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 17 Nov 2021 09:40:48 +0000
Iain Hunter <drhunter95@gmail.com> wrote:

> v3 has me as suggested maintainer per Daniel's feedback and corrected id
> 
> Signed-off-by: Iain Hunter <drhunter95@gmail.com>
Hi Iain,

Please resend whole series and not just a single patch.
This had me confused when I saw a binding without a driver.

Also, I'm guessing you missed my email that asked you to do quite
a bit of this differently...

https://lore.kernel.org/all/20211113180916.66b6864b@jic23-huawei/

Please address those comments in v4.

Thanks

Jonathan

> ---
>  .../bindings/iio/adc/ti,ads1018.yaml          | 109 ++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
> new file mode 100644
> index 000000000000..14345bfb71dc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
> @@ -0,0 +1,109 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads1018.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI ADS1018 4 channel I2C analog to digital converter
> +
> +maintainers:
> +  - Iain Hunter <iain@hunterembedded.co.uk>
> +
> +description: |
> +  Datasheet at: https://www.ti.com/lit/gpn/ads1018
> +  Supports both single ended and differential channels.
> +
> +properties:
> +  compatible:
> +    const: ti,ads1018
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties: false
> +
> +patternProperties:
> +  "^channel@[0-7]+$":
> +    type: object
> +    description:
> +      Child nodes needed for each channel that the platform uses.
> +
> +    properties:
> +      reg:
> +        description: |
> +          0: Voltage over AIN0 and AIN1.
> +          1: Voltage over AIN0 and AIN3.
> +          2: Voltage over AIN1 and AIN3.
> +          3: Voltage over AIN2 and AIN3.
> +          4: Voltage over AIN0 and GND.
> +          5: Voltage over AIN1 and GND.
> +          6: Voltage over AIN2 and GND.
> +          7: Voltage over AIN3 and GND.
> +        items:
> +          - minimum: 0
> +            maximum: 7
> +
> +      ti,gain:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 5
> +        description: |
> +          pga is the programmable gain amplifier (values are full scale)
> +          0: +/- 6.144 V
> +          1: +/- 4.096 V
> +          2: +/- 2.048 V (default)
> +          3: +/- 1.024 V
> +          4: +/- 0.512 V
> +          5: +/- 0.256 V
> +
> +      ti,datarate:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 6
> +        description: |
> +          Data acquisition rate in samples per second
> +          0: 128
> +          1: 250
> +          2: 490
> +          3: 920
> +          4: 1600 (default)
> +          5: 2400
> +          6: 3300
> +
> +    required:
> +      - reg
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@1 {
> +            compatible = "ti,ads1018";
> +            reg = <0x1>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            channel@4 {
> +              reg = <4>;
> +              ti,gain = <3>;
> +              ti,datarate = <5>;
> +            };
> +        };
> +    };
> +...

