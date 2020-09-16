Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0659E26C2D0
	for <lists+linux-iio@lfdr.de>; Wed, 16 Sep 2020 14:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgIPMgi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Sep 2020 08:36:38 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2828 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726837AbgIPKae (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Sep 2020 06:30:34 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 0FC22CE8F96C5FA8946F;
        Wed, 16 Sep 2020 11:28:59 +0100 (IST)
Received: from localhost (10.52.126.84) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Wed, 16 Sep
 2020 11:28:58 +0100
Date:   Wed, 16 Sep 2020 11:27:21 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        <devicetree@vger.kernel.org>, Haibo Chen <haibo.chen@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 19/20] dt-bindings:iio:adc:fsl,imx7d-adc yaml
 conversion
Message-ID: <20200916112721.00003803@Huawei.com>
In-Reply-To: <20200909175946.395313-20-jic23@kernel.org>
References: <20200909175946.395313-1-jic23@kernel.org>
        <20200909175946.395313-20-jic23@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.126.84]
X-ClientProxiedBy: lhreml707-chm.china.huawei.com (10.201.108.56) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 9 Sep 2020 18:59:45 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> A nice simple binding.  Only real different from txt is that I dropped
> some descriptions where the naming of the parameter was self explanatory
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Haibo Chen <haibo.chen@freescale.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
Update Haibo Chen's email address. I'll also fix it whilst applying the
patch if this version goes in!

Thanks,

Jonathan

> ---
>  .../bindings/iio/adc/fsl,imx7d-adc.yaml       | 62 +++++++++++++++++++
>  .../devicetree/bindings/iio/adc/imx7d-adc.txt | 24 -------
>  2 files changed, 62 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/fsl,imx7d-adc.yaml b/Documentation/devicetree/bindings/iio/adc/fsl,imx7d-adc.yaml
> new file mode 100644
> index 000000000000..dc5eacb38046
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/fsl,imx7d-adc.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/fsl,imx7d-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale ADC found on the imx7d SoC
> +
> +maintainers:
> +  - Haibo Chen <haibo.chen@freescale.com>
> +
> +properties:
> +  compatible:
> +    const: fsl,imx7d-adc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: adc
> +
> +  vref-supply: true
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
> +  - vref-supply
> +  - "#io-channel-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/imx7d-clock.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    soc {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        adc@30610000 {
> +            compatible = "fsl,imx7d-adc";
> +            reg = <0x30610000 0x10000>;
> +            interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&clks IMX7D_ADC_ROOT_CLK>;
> +            clock-names = "adc";
> +            vref-supply = <&reg_vcc_3v3_mcu>;
> +            #io-channel-cells = <1>;
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt b/Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt
> deleted file mode 100644
> index f1f3a552459b..000000000000
> --- a/Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -Freescale imx7d ADC bindings
> -
> -The devicetree bindings are for the ADC driver written for
> -imx7d SoC.
> -
> -Required properties:
> -- compatible: Should be "fsl,imx7d-adc"
> -- reg: Offset and length of the register set for the ADC device
> -- interrupts: The interrupt number for the ADC device
> -- clocks: The root clock of the ADC controller
> -- clock-names: Must contain "adc", matching entry in the clocks property
> -- vref-supply: The regulator supply ADC reference voltage
> -- #io-channel-cells: Must be 1 as per ../iio-bindings.txt
> -
> -Example:
> -adc1: adc@30610000 {
> -	compatible = "fsl,imx7d-adc";
> -	reg = <0x30610000 0x10000>;
> -	interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> -	clocks = <&clks IMX7D_ADC_ROOT_CLK>;
> -	clock-names = "adc";
> -	vref-supply = <&reg_vcc_3v3_mcu>;
> -	#io-channel-cells = <1>;
> -};


