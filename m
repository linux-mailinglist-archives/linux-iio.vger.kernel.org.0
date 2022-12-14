Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F24664CCCB
	for <lists+linux-iio@lfdr.de>; Wed, 14 Dec 2022 16:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238214AbiLNPBE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Dec 2022 10:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237778AbiLNPBD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Dec 2022 10:01:03 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E357A448;
        Wed, 14 Dec 2022 07:01:02 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id r11so2763415oie.13;
        Wed, 14 Dec 2022 07:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoL6i5vxN2VIXQtBU1jlFS6aLxm/by40lLf1WEubCJM=;
        b=YAn2vt0QCMuGgtdhz8VIWebgpRvAAEsaexZgw6JAZTmwBkFd1aa++vrPjEvVNNamDR
         HPfaF390V3LwLCP+TeFKIG9E7JUj4pQUHclwWDFWZ7wTty2tnOYt7ipVd3+wveWqFmZr
         LWJkFK1Fvd4XNaPyRZvCaoda/ycPTRinf1UDDgCnIXCye/tbg0oSEKs+QLP3SUK67M7u
         mQ7uKR6WDH9L01pb0my6lDjM7AVpSaUVgeGfb627YEUGEIfkvGCnoeoNgAL41jVCG0bP
         lyfGL5Sk/OuP0DC1VjA3NrBPzE181NrVbxHgJE0stiwL3PfvJqjt30QN2GtIdA72NeQj
         ZStg==
X-Gm-Message-State: ANoB5pnHDYnM9RfxPDvUQapEtIQUCp+wqxE3FFD0S0D3ZI7CiTlpRirr
        zqW9eMibUzJ/iJP6vg9Ffg==
X-Google-Smtp-Source: AA0mqf4Zq4Y3dyfuRV9T0xjJ2mBVMDxAkFSCmf2WHI3fZ9GiRxZuMNNXsgjrwZwDyjE+hBDymPLfoA==
X-Received: by 2002:a54:4516:0:b0:355:1de9:392a with SMTP id l22-20020a544516000000b003551de9392amr11491624oil.48.1671030061718;
        Wed, 14 Dec 2022 07:01:01 -0800 (PST)
Received: from robh_at_kernel.org (rrcs-98-6-157-194.sw.biz.rr.com. [98.6.157.194])
        by smtp.gmail.com with ESMTPSA id r141-20020acaa893000000b003539686cb7bsm5681085oie.53.2022.12.14.07.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 07:01:00 -0800 (PST)
Received: (nullmailer pid 1050655 invoked by uid 1000);
        Wed, 14 Dec 2022 15:00:59 -0000
Date:   Wed, 14 Dec 2022 09:00:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     haibo.chen@nxp.com
Cc:     jic23@kernel.org, lars@metafoo.de,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: adc: Add binding documentation
 for NXP IMX93 ADC
Message-ID: <20221214150059.GA1048042-robh@kernel.org>
References: <1671024939-29322-1-git-send-email-haibo.chen@nxp.com>
 <1671024939-29322-2-git-send-email-haibo.chen@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1671024939-29322-2-git-send-email-haibo.chen@nxp.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 14, 2022 at 09:35:38PM +0800, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> The IMX93 SoC has a new ADC IP, so add binding documentation
> for NXP IMX93 ADC.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  .../bindings/iio/adc/nxp,imx93-adc.yaml       | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> new file mode 100644
> index 000000000000..229bb79e255c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/nxp,imx93-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP iMX93 ADC bindings
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
> +    description:
> +      line 0 for WDGnL (watchdog threshold) interrupt requests.
> +      line 1 for WDGnH (watchdog threshold) interrupt requests.
> +      line 2 for normal conversion, include EOC (End of Conversion)
> +      interrupt request, ECH (End of Chain) interrupt request,
> +      JEOC (End of Injected Conversion mode) interrupt request
> +      and JECH (End of injected Chain) interrupt request.
> +      line 3 for Self-testing Interrupts.
> +    maxItems: 4

Split the descriptions:

items:
  - description: WDGnL ...
  - description: ...

And then drop maxItems

> +
> +  clocks:
> +    maxItems: 1
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
> +        };
> +    };
> +...
> -- 
> 2.34.1
> 
> 
