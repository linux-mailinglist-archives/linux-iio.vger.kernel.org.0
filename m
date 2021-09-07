Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E8C402D0B
	for <lists+linux-iio@lfdr.de>; Tue,  7 Sep 2021 18:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344708AbhIGQrO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Sep 2021 12:47:14 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:40888 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343837AbhIGQrN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Sep 2021 12:47:13 -0400
Received: by mail-oi1-f175.google.com with SMTP id h133so13539848oib.7;
        Tue, 07 Sep 2021 09:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DCZNN4p5E8kdrXSmi6bXMnp7xKFnaiWBCB0tHa5A5OA=;
        b=Bw64cYmMn9sgJZ61c+4aG+oIce/PCjfOlP1xG0sMycZ8w1S6J7nrkLrJh0shO9bKV9
         GEr2nuWhIRm+hXAGgsaLvna0O1IXnI4jSzCoxSPyjeKAWAiAHt+5lz9gOUWCU/c8JgBp
         oewVTeXdPIw3bJCcg0ol8+f5qNNyMp3awS5Jjn+9vezZNZVABx/Ti1WrSBMpv0M20et4
         Ji49zKjNPRpelTvNgB4hI1DMouZfxWKIH7gtkTrJCp616yW1E4wbKNqrnkMbQZS+vWTT
         gZT6/3RcGCpC51gLlouPRIpvrJe+IDIcg84nZraCi3mICvKQMlPFZi/+SVSh2Dsu2+Kl
         Wt/g==
X-Gm-Message-State: AOAM5317kU9r9LPZnrNfJJL5107Gm5MwBghd33+XKeAXIo5hgUXP1D40
        wMiDTNYPQCYdff+iW2tW+A==
X-Google-Smtp-Source: ABdhPJyEWZxNDh9WKG25RoeCwev0Ca107OKI1Rf+mUhA3Dl4aN8TzcDh+oMu6TG6+aso5kQpCnX2YA==
X-Received: by 2002:a05:6808:13d3:: with SMTP id d19mr3506601oiw.178.1631033166614;
        Tue, 07 Sep 2021 09:46:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x4sm2327260ood.2.2021.09.07.09.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 09:46:05 -0700 (PDT)
Received: (nullmailer pid 4134391 invoked by uid 1000);
        Tue, 07 Sep 2021 16:46:04 -0000
Date:   Tue, 7 Sep 2021 11:46:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: adc: Add the binding
 documentation for NXP IMX8QXP ADC
Message-ID: <YTeXTLX05lvmwWvo@robh.at.kernel.org>
References: <20210907015724.1377-1-caihuoqing@baidu.com>
 <20210907015724.1377-3-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907015724.1377-3-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 07, 2021 at 09:57:22AM +0800, Cai Huoqing wrote:
> The NXP i.MX 8QuadXPlus SOC has a new ADC IP, so add the binding
> documentation for NXP IMX8QXP ADC.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
> v1->v2: *Fix some indentation issues.
>         *Mark status as okay.
>         *Change clock2 source.
> v1 link:
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210830172140.414-5-caihuoqing@baidu.com/
> 
>  .../bindings/iio/adc/nxp,imx8qxp-adc.yaml     | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> new file mode 100644
> index 000000000000..77501898a563
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

???

You don't need 'status' in bindings. Plus this would cause 'status = 
"okay"' to cause an error in your dts files.

> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupts-parent

It is valid for interrupt-parent to be in a parent node, so it is never 
required.

> +  - clocks
> +  - clock-names
> +  - assigned-clocks
> +  - assigned-clock-rates
> +  - power-domains
> +  - state

Not documented.

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
> +        adc@5a880000 {
> +            compatible = "nxp,imx8qxp-adc";
> +            reg = <0x0 0x5a880000 0x0 0x10000>;
> +            interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&clk IMX_SC_R_ADC_0>,
> +                     <&clk IMX_SC_R_ADC_0>;
> +            clock-names = "per", "ipg";
> +            assigned-clocks = <&clk IMX_SC_R_ADC_0>;
> +            assigned-clock-rates = <24000000>;
> +            power-domains = <&pd IMX_SC_R_ADC_0>;
> +            status = "okay";

Remove status from examples.

> +            #io-channel-cells = <1>;
> +        };
> +    };
> +...
> -- 
> 2.25.1
> 
> 
