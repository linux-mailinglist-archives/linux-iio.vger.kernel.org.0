Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA1B588A46
	for <lists+linux-iio@lfdr.de>; Wed,  3 Aug 2022 12:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbiHCKUM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Aug 2022 06:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiHCKUK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Aug 2022 06:20:10 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213B92635
        for <linux-iio@vger.kernel.org>; Wed,  3 Aug 2022 03:20:09 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id e15so15694054lfs.0
        for <linux-iio@vger.kernel.org>; Wed, 03 Aug 2022 03:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=T7u/vSnLYBLG2/cqPGx4+nzYlaGJoQWkAhUede1qgbE=;
        b=dyZajjqvKdmd4vUZeecNmiaub4K5+6UqV+OCAP4uQKCkTqRR1VK5YgTlJQssOj68Nb
         SEKK/+JG9y8NLJ0mXRBTBz2DNuJU4HdZ3szvsDW9LlKirGe1PBkbVJdDlehUiPrAOVAY
         1wf82YnarJCnhUscFC5dkXVeUwFWoc3GCPqCJHfaoafrYhhTSvMNDcgArzmF9kmPaMgs
         KO6+gf+thBG1PoC50WvR+7C/LLMcXEhU+Y6qprjK/kYmgYXpdcRK+vaiw6Dfw9AjRw/g
         7GO51Dk14Mp+5OmIHT7iHQiuzzhZ9u7HJuT+SEZiJP5zClYVkc2ndYC6GOf8I5AjBtOI
         lZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T7u/vSnLYBLG2/cqPGx4+nzYlaGJoQWkAhUede1qgbE=;
        b=JJJMn6OMxJtLa5hWME7SNfhTYBP40MhMJf7fc7c6thy410lgtlYx0XBDlwR/v0taDg
         Dd4GsFsqNfiQ+qamncJUmbPzGs3HfP57R4ylOUrYBNTVJJLgU9qAYnX+gCx5LlGFOZtH
         8WWLA+ufbTa76ootU9gIMRhqTOI3dlTFfLWwG+5unf7y4H4yKnIJje3MGs7P8ZiCGL9s
         xk9ovQOoHM417TuTgR5MlMBbPQQYJOOs8XCPzggVxX2xPZTi74nzhhQ/9ynS7pUQ/3Uu
         Kx/8GsGZLukk2pbXOBM4EMIMBBBPAt81F1iv98quHVsw2v+lRzSzFlMqStfX9cjF81kQ
         m1vw==
X-Gm-Message-State: ACgBeo1DKAVnMd2nh3E8ZVfEr06w1NVxRa9d2UAR2k684gQXGwjnt568
        5mZ2ntS96JgoK7JnyUP21CsiMQ==
X-Google-Smtp-Source: AA6agR4+HTMc8onRirUA2Gvtf1run7QOLGwV+NRTf5J0dedKuHUNzmeyA9s6VpR+vuMrnzGH8UbMzw==
X-Received: by 2002:ac2:44d2:0:b0:48b:18ae:7cde with SMTP id d18-20020ac244d2000000b0048b18ae7cdemr1627845lfm.193.1659522007423;
        Wed, 03 Aug 2022 03:20:07 -0700 (PDT)
Received: from [192.168.1.6] ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id i15-20020a2ea36f000000b0025e6a0a504bsm216479ljn.25.2022.08.03.03.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 03:20:06 -0700 (PDT)
Message-ID: <8afe7812-7dbd-7257-2a55-b4ae49f47381@linaro.org>
Date:   Wed, 3 Aug 2022 12:20:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/3] dt-bindings: iio: adc: Add binding documentation for
 NXP IMX93 ADC
Content-Language: en-US
To:     haibo.chen@nxp.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <1659517947-11207-1-git-send-email-haibo.chen@nxp.com>
 <1659517947-11207-2-git-send-email-haibo.chen@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1659517947-11207-2-git-send-email-haibo.chen@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 03/08/2022 11:12, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> The IMX93 SoC has a new ADC IP, so add binding documentation
> for NXP IMX93 ADC.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  .../bindings/iio/adc/nxp,imx93-adc.yaml       | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> new file mode 100644
> index 000000000000..e0eac5aa81d7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/nxp,imx93-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP ADC found on the imx93 SoC

How different it is from ADC in imx8qxp?

> +
> +maintainers:
> +  - Haibo Chen <haibo.chen@nxp.com>
> +
> +properties:
> +  compatible:
> +    const: nxp,imx93-adc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 4

You need to describe items.

> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: ipg

No need for clock-names in such case.

> +
> +  vref-supply: true

Missing description.

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
> +            status = "disabled";

No status in the example.



Best regards,
Krzysztof
