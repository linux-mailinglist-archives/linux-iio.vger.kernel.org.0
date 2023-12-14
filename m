Return-Path: <linux-iio+bounces-916-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE36E812E38
	for <lists+linux-iio@lfdr.de>; Thu, 14 Dec 2023 12:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ADCC1C214F1
	for <lists+linux-iio@lfdr.de>; Thu, 14 Dec 2023 11:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACC73F8CE;
	Thu, 14 Dec 2023 11:11:15 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E168E;
	Thu, 14 Dec 2023 03:11:11 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SrV4b1xwtz6J9y3;
	Thu, 14 Dec 2023 19:10:07 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 81C4A1400CA;
	Thu, 14 Dec 2023 19:11:09 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Dec
 2023 11:11:09 +0000
Date: Thu, 14 Dec 2023 11:11:07 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mike Looijmans <mike.looijmans@topic.nl>
CC: <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, Lars-Peter Clausen
	<lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: ti-ads1298: Add driver
Message-ID: <20231214111107.00002fd8@Huawei.com>
In-Reply-To: <20231213094722.31547-1-mike.looijmans@topic.nl>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.618139b3-8cb2-4e4c-9283-9e3787c70105@emailsignatures365.codetwo.com>
	<20231213094722.31547-1-mike.looijmans@topic.nl>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 13 Dec 2023 10:47:21 +0100
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> Skeleton driver for the TI ADS1298 medical ADC. This device is
> typically used for ECG and similar measurements. Supports data
> acquisition at configurable scale and sampling frequency.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> ---
> 
>  .../bindings/iio/adc/ti,ads1298.yaml          | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
> new file mode 100644
> index 000000000000..7a160ba721eb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads1298.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments' ads1298 medical ADC chips
> +
> +maintainers:
> +  - Mike Looijmans <mike.looijmans@topic.nl>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,ads1298
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cpha: true
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  avdd-supply:
> +    description:
> +      Analog power supply, voltage between AVDD and AVSS. When providing a
> +      symmetric +/- 2.5V, the regulator should report 5V.
Commented on in other thread.
> +
> +  vref-supply:
> +    description:
> +      Optional reference voltage. If omitted, internal reference is used,
> +      depending on analog supply this is 2.4 or 4V.
> +
There is a dvdd-supply as well.  Might be others. Makes sure to document them all.

Should probably also document the gpios as the binding should attempt to be as complete
as possible independent of what the driver currently supports.

Lots of complex options for this device and the use of those pins, so maybe something
that can be left for now - but the patch description should then mention that is intentional.

Jonathan

> +  clocks:
> +    description: Optional 2.048 MHz external source clock on CLK pin
> +    maxItems: 1
> +
> +  clock-names:
> +    const: clk
> +
> +  interrupts:
> +    description: Interrupt on DRDY pin, triggers on falling edge
> +    maxItems: 1
> +
> +  label: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +  - interrupts
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@1 {
> +          reg = <1>;
> +          compatible = "ti,ads1298";
> +          label = "ads1298-1-ecg";
> +          avdd-supply = <&reg_iso_5v_a>;
> +          clock-names = "clk";
> +          clocks = <&clk_ads1298>;
> +          interrupt-parent = <&gpio0>;
> +          interrupts = <78 IRQ_TYPE_EDGE_FALLING>;
> +          spi-max-frequency = <20000000>;
> +          spi-cpha;
> +        };
> +    };
> +...


