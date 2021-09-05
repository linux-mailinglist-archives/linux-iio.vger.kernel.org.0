Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDF0400F5C
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 13:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbhIELxM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Sep 2021 07:53:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232168AbhIELxL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 07:53:11 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A52D60FBF;
        Sun,  5 Sep 2021 11:52:04 +0000 (UTC)
Date:   Sun, 5 Sep 2021 12:55:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     <lars@metafoo.de>, <robh+dt@kernel.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <festevam@gmail.com>, <linux-imx@nxp.com>,
        <alex.dewar90@gmail.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] dt-bindings: iio: adc: Add the binding
 documentation for NXP IMX8QXP ADC
Message-ID: <20210905125527.1782ba86@jic23-huawei>
In-Reply-To: <20210830172140.414-5-caihuoqing@baidu.com>
References: <20210830172140.414-1-caihuoqing@baidu.com>
        <20210830172140.414-5-caihuoqing@baidu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 31 Aug 2021 01:21:38 +0800
Cai Huoqing <caihuoqing@baidu.com> wrote:

> The NXP i.MX 8QuadXPlus SOC has a new ADC IP, so add the binding
> documentation for NXP IMX8QXP ADC
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  .../bindings/iio/adc/nxp,imx8qxp-adc.yaml     | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> new file mode 100644
> index 000000000000..542329e6a785
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> @@ -0,0 +1,85 @@
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
> +  assigned-clocks-rate:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  status:
> +    const: disable
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupts-parent
> +  - clocks
> +  - clock-names
> +  - assigned-clocks
> +  - assigned-clock-rates
> +  - power-domains
> +  - state
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/firmware/imx/rsrc.h>
> +    soc {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +	 adc@5a880000 {
Clearly some indentation issues here.
> +            compatible = "nxp,imx8qxp-adc";
> +            reg = <0x0 0x5a880000 0x0 0x10000>;
> +            interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&clk IMX_SC_R_ADC_0>,
> +                     <&clk IMX_ADMA_LPCG_ADC_0_IPG_CLK>;
> +            clock-names = "per", "ipg";
> +            assigned-clocks = <&clk IMX_SC_R_ADC_0>;
> +            assigned-clock-rates = <24000000>;
> +            power-domains = <&pm, IMX_SC_R_ADC_0>;
> +            status = "disabled";

Don't mark the example disabled.

> +            #io-channel-cells = <1>
> +	 };
> +    };
> +...

