Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6E86770DD
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jan 2023 18:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjAVRES (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Jan 2023 12:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjAVRER (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Jan 2023 12:04:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97256193E9;
        Sun, 22 Jan 2023 09:04:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47264B80973;
        Sun, 22 Jan 2023 17:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4440DC433D2;
        Sun, 22 Jan 2023 17:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674407053;
        bh=Mf8+nEfDKINkdcBw9BzOV7P06ItxNI829BzlDTuL374=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qrg5Phdk6N8gotVPed9oOqXjXj9dtW9rw0mwPvWbQawGXO2D0cQR6m/CNqsT+t8Gm
         3gLa/0ZNnzrta0EMQu2iqB7oIJA52MYU90y5lokwpAL5AHmHR9OG54u7GBFfEPeAHL
         kRg7qOk+GIXe9VWij0XdUgmb+ow9zUYJ6qdKEvH9X/kKhXsfF4lN+hVgLAkW67esNq
         6MMKorF7es8kYlVa1hhPajxZFbPMuJqj91NpAjjTCuqdzgFffJQbwhVxFmipXwal9X
         vSHIW14WVRXX4oDmaLd7izfZ6bDK8vO7UVFNXKS3t+rk1LYgb1c8xEeUYIMiB9JLy8
         ICcYMstRolXTg==
Date:   Sun, 22 Jan 2023 17:17:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     haibo.chen@nxp.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 2/3] dt-bindings: iio: adc: Add NXP IMX93 ADC
Message-ID: <20230122171758.6752c208@jic23-huawei>
In-Reply-To: <20230117135137.1735536-3-haibo.chen@nxp.com>
References: <20230117135137.1735536-1-haibo.chen@nxp.com>
        <20230117135137.1735536-3-haibo.chen@nxp.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Jan 2023 21:51:36 +0800
haibo.chen@nxp.com wrote:

> From: Haibo Chen <haibo.chen@nxp.com>
> 
> The IMX93 SoC has a new ADC IP, so add binding documentation
> for NXP IMX93 ADC.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Applied,

Thanks,

Jonathan

> ---
>  .../bindings/iio/adc/nxp,imx93-adc.yaml       | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> new file mode 100644
> index 000000000000..dacc526dc695
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/nxp,imx93-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP iMX93 ADC
> +
> +maintainers:
> +  - Haibo Chen <haibo.chen@nxp.com>
> +
> +description:
> +  The ADC on iMX93 is a 8-channel 12-bit 1MS/s ADC with 4 channels
> +  connected to pins. it support normal and inject mode, include
> +  One-Shot and Scan (continuous) conversions. Programmable DMA
> +  enables for each channel  Also this ADC contain alternate analog
> +  watchdog thresholds, select threshold through input ports. And
> +  also has Self-test logic and Software-initiated calibration.
> +
> +properties:
> +  compatible:
> +    const: nxp,imx93-adc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: WDGnL, watchdog threshold interrupt requests.
> +      - description: WDGnH, watchdog threshold interrupt requests.
> +      - description: normal conversion, include EOC (End of Conversion),
> +          ECH (End of Chain), JEOC (End of Injected Conversion) and
> +          JECH (End of injected Chain).
> +      - description: Self-testing Interrupts.
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: ipg
> +
> +  vref-supply:
> +    description:
> +      The reference voltage which used to establish channel scaling.
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
> +    #include <dt-bindings/clock/imx93-clock.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    soc {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        adc@44530000 {
> +            compatible = "nxp,imx93-adc";
> +            reg = <0x44530000 0x10000>;
> +            interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&clk IMX93_CLK_ADC1_GATE>;
> +            clock-names = "ipg";
> +            vref-supply = <&reg_vref_1v8>;
> +            #io-channel-cells = <1>;
> +        };
> +    };
> +...

