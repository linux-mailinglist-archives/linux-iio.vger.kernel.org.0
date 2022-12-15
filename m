Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F2D64D94A
	for <lists+linux-iio@lfdr.de>; Thu, 15 Dec 2022 11:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiLOKLo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Dec 2022 05:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiLOKLn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Dec 2022 05:11:43 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C8112E
        for <linux-iio@vger.kernel.org>; Thu, 15 Dec 2022 02:11:41 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id p8so14855586lfu.11
        for <linux-iio@vger.kernel.org>; Thu, 15 Dec 2022 02:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=soCAHOaIsFy+d6hQmUNMl70DZLfVjiL+F7Thug8JERc=;
        b=WLlx94ZIFqE7ErOp6ArpMlmvX9WlLRuT8CuhA8kI1wGvJMLK1t/7+nQl5wCHBhResK
         KYLiljRyPTP0OG819MCnBnVNHzQBUkVuuPWeJnNw/nciYAILFiW0ZeIYeVCf+Zu1JMW2
         oThUf4I66GpOkbJn7ReS+fsOWKLF4tkCZlldCa5PIF7VcxEnV02IF76uHogBnSf8uGVt
         qcSkENtzcgzmAO1sGTrK9MESRX/MnJjSCNTEs8AfM/zlfJvitYFYRaWV1hAbGUE29M3W
         hyDOIrHEsLXYvvQo8mYbBjB6ci5yV9aztsz6LoLL+QK6KMg9EH6V+vpKpQV8vAjgnEQz
         JypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=soCAHOaIsFy+d6hQmUNMl70DZLfVjiL+F7Thug8JERc=;
        b=CzJjr4pUxn0d3xTSNxjnsxkMtny5kGp2yGNle/iF2mkc7/3xVqDYg3WHS7mw33bGZt
         T5+N1Y6fgOBKoL9QIp9C6AuW/yXNddkM2erDAru36QayvDeM+td2bcVOhX+isn4oQqz0
         /rz8b9XsiTrjj3pC9OfRCQ0dolcBL2IV/DWrePvno6r3w7hc1YMMR0CtSEWkWZYmgRUt
         BcHYAY90WIEIRyY3TpekFH5p83k2EZPFnQnMG2Tr4qurxsqRD11/OYf448K41Zd1/Rgj
         rrMnbXXae9FOZIUvnIO3713n11JsvGOrNP/YWB92I6AExNyFBxv47YKjfjshDFIY2IH8
         g4CA==
X-Gm-Message-State: ANoB5pmVZ7iHi4oPB/7Xf1ozpu0q6jfkNq1WAqjXB6V3jjxZxLN8Qc89
        modLt0Ok139vfvMdLgE03i6oIzPfD4HdFPnT
X-Google-Smtp-Source: AA0mqf7GQAtfRyU1SdpttGv7QxRUHm95kCZgGqdLa5Y6dlcxpEnrG9ccqnnutlyyKlfe4U1/iQNJtw==
X-Received: by 2002:a19:e007:0:b0:4b5:b937:7896 with SMTP id x7-20020a19e007000000b004b5b9377896mr5767717lfg.46.1671099100109;
        Thu, 15 Dec 2022 02:11:40 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z15-20020a195e4f000000b004b57162edfasm1120536lfi.117.2022.12.15.02.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 02:11:39 -0800 (PST)
Message-ID: <559fe1ef-cd12-851c-0cfd-282c4cec10ac@linaro.org>
Date:   Thu, 15 Dec 2022 11:11:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: adc: Add binding documentation
 for NXP IMX93 ADC
Content-Language: en-US
To:     haibo.chen@nxp.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1671024939-29322-1-git-send-email-haibo.chen@nxp.com>
 <1671024939-29322-2-git-send-email-haibo.chen@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1671024939-29322-2-git-send-email-haibo.chen@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 14/12/2022 14:35, haibo.chen@nxp.com wrote:
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

This was already sent, so I am surprised to see this in worse or the
same state. Don't force us to repeat review, it's a waste of time.

> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/nxp,imx93-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP iMX93 ADC bindings

Drop bindings. How did it appear here? It wasn't in v1.

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

Best regards,
Krzysztof

