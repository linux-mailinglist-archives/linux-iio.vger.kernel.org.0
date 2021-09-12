Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E84407EB1
	for <lists+linux-iio@lfdr.de>; Sun, 12 Sep 2021 18:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhILQna (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Sep 2021 12:43:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229643AbhILQn3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Sep 2021 12:43:29 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FB986108E;
        Sun, 12 Sep 2021 16:42:12 +0000 (UTC)
Date:   Sun, 12 Sep 2021 17:45:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     <lars@metafoo.de>, <robh+dt@kernel.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <festevam@gmail.com>, <linux-imx@nxp.com>, <aardelean@deviqon.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: iio: adc: Add binding documentation
 for NXP IMX8QXP ADC
Message-ID: <20210912174544.285b40bd@jic23-huawei>
In-Reply-To: <20210912071334.1745-3-caihuoqing@baidu.com>
References: <20210912071334.1745-1-caihuoqing@baidu.com>
        <20210912071334.1745-3-caihuoqing@baidu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 12 Sep 2021 15:13:33 +0800
Cai Huoqing <caihuoqing@baidu.com> wrote:

> The NXP i.MX 8QuadXPlus SOC a new ADC IP, so add
> binding documentation for NXP IMX8QXP ADC
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
> v1->v2: *Fix some indentation issues.
>         *Mark status as okay.
>         *Change clock2 source.
> v3->v4: *Remove 'status' from examples.
>         *Remove unused 'state'.
>         *Remove interrupts-parent.
>         *Change num of address/size-cells from 1 to 2.
> v1 link:
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210830172140.414-5-caihuoqing@baidu.com/
> v3 link:
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210907015724.1377-3-caihuoqing@baidu.com/
> 
>  .../bindings/iio/adc/nxp,imx8qxp-adc.yaml     | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> new file mode 100644
> index 000000000000..8e16adf9a28a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/nxp,imx8qxp-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP IMX8QXP ADC bindings
> +
> +maintainers:
> +  - Cai Huoqing <caihuoqing@baidu.com>
> +
> +description:
> +  Supports the ADC found on the IMX8QXP SoC.
> +
> +properties:
> +  compatible:
> +    const: nxp,imx8qxp-adc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: per
> +      - const: ipg
> +
> +  assigned-clocks:
> +    maxItems: 1
> +
> +  assigned-clock-rates:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 2
> +
> +  '#size-cells':
> +    const: 2
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - assigned-clocks
> +  - assigned-clock-rates
> +  - power-domains
> +  - '#address-cells'
> +  - '#size-cells'
> +  - "#io-channel-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/firmware/imx/rsrc.h>
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
These indeed need to be here so we know what form reg for child
nodes takes, but...
> +        adc@5a880000 {
> +            #address-cells = <2>;
> +            #size-cells = <2>;

Why are these required properties?  There aren't any child nodes
defined in this binding so I don't think they are used.

> +            compatible = "nxp,imx8qxp-adc";
> +            reg = <0x0 0x5a880000 0x0 0x10000>;
> +            interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&clk IMX_SC_R_ADC_0>,
> +                     <&clk IMX_SC_R_ADC_0>;
> +            clock-names = "per", "ipg";
> +            assigned-clocks = <&clk IMX_SC_R_ADC_0>;
> +            assigned-clock-rates = <24000000>;
> +            power-domains = <&pd IMX_SC_R_ADC_0>;
> +            #io-channel-cells = <1>;
> +        };
> +    };
> +...

