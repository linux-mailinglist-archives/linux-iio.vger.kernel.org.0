Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470ED3BA90F
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jul 2021 16:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhGCO4Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Jul 2021 10:56:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229562AbhGCO4X (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jul 2021 10:56:23 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8035161930;
        Sat,  3 Jul 2021 14:53:48 +0000 (UTC)
Date:   Sat, 3 Jul 2021 15:56:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Navin Sankar Velliangiri <navin@linumiz.com>
Cc:     lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: temperature: add MAXIM max31865
 support
Message-ID: <20210703155611.2971eea8@jic23-huawei>
In-Reply-To: <20210703095954.221281-1-navin@linumiz.com>
References: <20210703095954.221281-1-navin@linumiz.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  3 Jul 2021 15:29:54 +0530
Navin Sankar Velliangiri <navin@linumiz.com> wrote:

> Add DT bindings for MAXIM max31865 RTD sensor.
> 
> Signed-off-by: Navin Sankar Velliangiri <navin@linumiz.com>

Hi Navin,

Welcome to IIO!

A few comments inline.

Thanks,

Jonathan

> ---
>  .../iio/temperature/maxim,max31865.yaml       | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml b/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml
> new file mode 100644
> index 000000000000..9efadea514e1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/temperature/maxim,max31865.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX31865 RTD-to-Digital Converter.

Good to spell out RTD: Restance temperature detector

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
> +  maxim,no-of-wires:
> +    description:
> +      Setting this property enables 3-wire config. Else
> +      2-wire or 4-wire.
> +    type: boolean

Either make this take a the value 2, 3 or 4 (my preference)
or potentially rename it as maxim,3-wire.

Whilst we can expect people to look at the binding docs if they need details, we
still want someone glancing at a dts file to know what the binding means and
that isn't true for this parameter as current defined.

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
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	temp_sensor@0 {
> +		compatible = "maxim,max31865";
> +		reg = <0>;
> +		spi-max-frequency = <400000>;
> +		spi-cpha;
> +		maxim,no-of-wires;
> +	};

Some tabs in here, which means that a dt-schema check would have failed I think.
Please make sure you fix those up and run the tests as described in
Documentation/devicetree/bindings/writing-schema.rst
before sending v2.

> +    };
> +...

