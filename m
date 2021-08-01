Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050E23DCCDE
	for <lists+linux-iio@lfdr.de>; Sun,  1 Aug 2021 19:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhHARQt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Aug 2021 13:16:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229520AbhHARQs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Aug 2021 13:16:48 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5389F60EEA;
        Sun,  1 Aug 2021 17:16:38 +0000 (UTC)
Date:   Sun, 1 Aug 2021 18:19:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Navin Sankar Velliangiri <navin@linumiz.com>
Cc:     lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: temperature: add MAXIM
 max31865 support
Message-ID: <20210801181917.425f0939@jic23-huawei>
In-Reply-To: <20210801034341.67953-2-navin@linumiz.com>
References: <20210801034341.67953-1-navin@linumiz.com>
        <20210801034341.67953-2-navin@linumiz.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  1 Aug 2021 09:13:41 +0530
Navin Sankar Velliangiri <navin@linumiz.com> wrote:

> Add DT bindings for MAXIM max31865 RTD sensor.
> 
> Signed-off-by: Navin Sankar Velliangiri <navin@linumiz.com>
> 
> Note: Changes in v2:
> 	-> Changed the name RTD to Resistance Temperature Detector
> 	-> renamed maxim,no-of-wires to 3-wire
> 	-> fixed code alignment for the example  
As in previous, move changelog below the ---
One request for more detail inline.

Thanks,

J
> ---
>  .../iio/temperature/maxim,max31865.yaml       | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml b/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml
> new file mode 100644
> index 000000000000..13d288311cc6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/temperature/maxim,max31865.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX31865 Resistance Temperature Detector.
> +
> +maintainers:
> +  - Navin Sankar Velliangiri <navin@linumiz.com>
> +
> +description: |
> +  https://datasheets.maximintegrated.com/en/ds/MAX31865.pdf
> +
> +properties:
> +  compatible:
> +    const: maxim,max31865
> +
> +  reg:
> +    maxItems: 1
> +
> +  maxim,3-wire:
> +    description:
> +      Setting this property enables 3-wire config. Else
> +      2-wire or 4-wire.

Oddly short wrapping on line.  Keep to 80 chars.
Please add add a little more info here about this.
Right now a reader might think this was some sort of odd spi
bus related control (particularly as there are common 3 and 4
wire versions of SPI)

> +    type: boolean
> +
> +  spi-max-frequency: true
> +  spi-cpha: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-cpha
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +
> +       temp_sensor@0 {
> +         compatible = "maxim,max31865";
> +         reg = <0>;
> +         spi-max-frequency = <400000>;
> +         spi-cpha;
> +         maxim,3-wire;
> +       };
> +    };
> +...

