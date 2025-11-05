Return-Path: <linux-iio+bounces-25923-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 463BCC375C5
	for <lists+linux-iio@lfdr.de>; Wed, 05 Nov 2025 19:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6925B4E5603
	for <lists+linux-iio@lfdr.de>; Wed,  5 Nov 2025 18:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA97287247;
	Wed,  5 Nov 2025 18:40:58 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DED2475E3;
	Wed,  5 Nov 2025 18:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762368057; cv=none; b=djX5qrZMxrZOprWpHGZEXGqgTJdvrXE9szp83bsbSZduEBLbdtQXYxsPDzYhhf4TIGJKKwqsOMKcy08BVlycuLK3eN9mz5ZbvhEy9wWjyVfbi8WqdvPOdB/UiXPn9DEv/FyEHV4m2cZCNstWzOMLY2l1OuDoRtU0qL8UTxJOgW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762368057; c=relaxed/simple;
	bh=nBjAQk/r/QCsdzkfYv155Dqw/UgNpwwufGrLsdVHe/E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=diPJ6ktkU/iSCNHmRG75cVL6yBMZl74+7OfgDAGgDnbzDlk/nXiyuJ526rUxa1HKpnAWScSWFBF8j6mDgxg5qAttp9lLOzbtV1nLmBMNyBeo6qMSBIEhg7k1f7ztSdIzo8WUfVG3ndqkvH8YBEXd9VnfOlV1DmBTuD2sfGTR/M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d1vJt4YJ7zJ4683;
	Thu,  6 Nov 2025 02:40:30 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 2B8AB140370;
	Thu,  6 Nov 2025 02:40:52 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 5 Nov
 2025 18:40:51 +0000
Date: Wed, 5 Nov 2025 18:40:50 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
CC: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, Andy Shevchenko
	<andy.shevchenko@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH v1 1/2] bindings: iio: adc: Add bindings for TI
 ADS131M0x ADCs
Message-ID: <20251105184050.000016f0@huawei.com>
In-Reply-To: <20251105143814.1807444-2-o.rempel@pengutronix.de>
References: <20251105143814.1807444-1-o.rempel@pengutronix.de>
	<20251105143814.1807444-2-o.rempel@pengutronix.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 5 Nov 2025 15:38:13 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Add device tree bindings documentation for the Texas Instruments
> ADS131M0x analog-to-digital converters. This family includes the ADS131M02,
> ADS131M03, ADS131M04, ADS131M06, and ADS131M08 variants.
Hi Olkesij,

Add a clear statement of difference between them that means we can't
use a single fallback compatible. You kind of state it in the binding
(number of channels) but having it here explicitly makes for easier review.


> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../bindings/iio/adc/ti,ads131m08.yaml        | 162 ++++++++++++++++++
>  1 file changed, 162 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads131m08.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads131m08.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads131m08.yaml
> new file mode 100644
> index 000000000000..193ac84c41cd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads131m08.yaml
> @@ -0,0 +1,162 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads131m08.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments ADS131M0x 2-, 3-, 4-, 6- and 8-Channel ADCs
> +
> +maintainers:
> +  - Oleksij Rempel <o.rempel@pengutronix.de>
> +
> +description: |
> +  The ADS131M0x are a family of multichannel, simultaneous sampling,
> +  24-bit, delta-sigma, analog-to-digital converters (ADCs) with a
> +  built-in programmable gain amplifier (PGA) and internal reference.
> +  Communication with the ADC chip is via SPI.
> +
> +  Datasheets:
> +  - ADS131M08: https://www.ti.com/lit/ds/symlink/ads131m08.pdf
> +  - ADS131M06: https://www.ti.com/lit/ds/symlink/ads131m06.pdf
> +  - ADS131M04: https://www.ti.com/lit/ds/symlink/ads131m04.pdf
> +  - ADS131M03: https://www.ti.com/lit/ds/symlink/ads131m03.pdf
> +  - ADS131M02: https://www.ti.com/lit/ds/symlink/ads131m02.pdf
Trivial but seems a little odd to have these in reverse order of the compatibles.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,ads131m02
> +      - ti,ads131m03
> +      - ti,ads131m04
> +      - ti,ads131m06
> +      - ti,ads131m08
> +
> +  reg:
> +    description: SPI chip select number.
> +
> +  clocks:
> +    description:
> +      Phandle to the external clock source required by the ADC's CLKIN pin.
> +      The datasheet recommends specific frequencies based on the desired power
> +      mode (e.g., 8.192 MHz for High-Resolution mode).
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0

There should be some supplies here.
Looks like REFIN is optional but AVDD and DVDD are required.

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +patternProperties:
> +  "^channel@([0-7])$":
> +    type: object
> +    $ref: /schemas/iio/adc/adc.yaml#
> +    description: |

No need for | on this one as I don't think formatting needs to be controlled.

> +      Properties for a single ADC channel. The maximum valid channel number
> +      depends on the specific compatible string used (e.g., 0-1 for ads131m02,
> +      0-7 for ads131m08).
> +
> +    properties:
> +      reg:
> +        description: The channel index (0-7).
> +        minimum: 0
> +        maximum: 7 # Max channels on ADS131M08
> +
> +      label: true
> +
> +    required:
> +      - reg
> +
> +    unevaluatedProperties: false
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ti,ads131m02
> +    then:
> +      patternProperties:
> +        "^channel@[0-7]$":
> +          properties:
> +            reg:
> +              maximum: 1
> +        "^channel@([2-7])$": false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ti,ads131m03
> +    then:
> +      patternProperties:
> +        "^channel@[0-7]$":
> +          properties:
> +            reg:
> +              maximum: 2
> +        "^channel@([3-7])$": false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ti,ads131m04
> +    then:
> +      patternProperties:
> +        "^channel@[0-7]$":
> +          properties:
> +            reg:
> +              maximum: 3
> +        "^channel@([4-7])$": false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ti,ads131m06
> +    then:
> +      patternProperties:
> +        "^channel@[0-7]$":
> +          properties:
> +            reg:
> +              maximum: 5
> +        "^channel@([6-7])$": false
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/stm32mp1-clks.h>
> +
> +    spi1 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "ti,ads131m02";
> +            reg = <0>;
> +            spi-max-frequency = <8000000>;
> +
> +            clocks = <&rcc CK_MCO2>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            channel@0 {
> +                reg = <0>;
> +                label = "input_voltage";
> +            };
> +
> +            channel@1 {
> +                reg = <1>;
> +                label = "input_current";
> +            };
> +        };
> +    };


