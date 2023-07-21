Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A963375C163
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jul 2023 10:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjGUIVi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Jul 2023 04:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjGUIVh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Jul 2023 04:21:37 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA66F0
        for <linux-iio@vger.kernel.org>; Fri, 21 Jul 2023 01:21:34 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-992dcae74e0so265302166b.3
        for <linux-iio@vger.kernel.org>; Fri, 21 Jul 2023 01:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689927693; x=1690532493;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2G6l6gKvH0sa4hNHPgXKsD2m/QNfPKfzJ+aXhMoacwY=;
        b=nY+d6NkYZWqfsWbKcQP2JItNGldjB+vS+aTA9gDjwywj8jOND6gbyJQa633dXIG2ij
         fEARasMhaLw8eyiSLJhXkA6Ca0w/lvA4AliC55HVsioCKsCH4FQQwSIZW+UC82sls7sx
         uBmohcVCtoK/iPE5tSRTaFAmvTaBZ7WLZeYcKLpho0qzmBd4xqSBbJaoXR1arw21Afa7
         SL/4swyWEfeTZrq4Vd/T2+gF8J+agb19CQT1vx+Pbd0xuR0d3BEjTEu/3cYNA5Cvmaxd
         BXV+K684CTT0V7nC549MirV7SXaHaB2t5gCAekPXSFfpTZOaRcwy91nFhWqCdSmb4rZ4
         N5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689927693; x=1690532493;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2G6l6gKvH0sa4hNHPgXKsD2m/QNfPKfzJ+aXhMoacwY=;
        b=K9Tnr/ff5OKBOxNEm3iOMIvb7mA04qHaaUQqD5IuZA62I1zhxLiivKtzbhivGkdb3Z
         SrnPoycysYNy7Qzz7Z3BSQEqmLOjTngB7YJcye2Y1eubXguM7bfE6dP9MuPRU7dTk1Lh
         FCJC+kVzKMBkUa242MzUOVA4X+0ps9DBtPvuS2i32IAipwhRK/BAyRMfsQ6WGYuR5M0Q
         7InDQx5NfaigLKnRFcUaydrnKmxMlZRNKYY6AQcQeQCiILUqKq2O04XYs6UKNLxuG5Xb
         BC8M9vyYBY+zE7tPcipLShrGAKNHVp4vy5rrz/ChSZP8NqZb7hUMEhn0UpKUFBa6gw0v
         N/mQ==
X-Gm-Message-State: ABy/qLYog2UmlJvzF630B1MVVdDCtak3aQHyZjZo/5Izy4J1F3TbyWuc
        FN401aX5bsN1xI/Vn/0S/gMHfA==
X-Google-Smtp-Source: APBJJlHuviIxegy2LkmpS24DUOOsZ8Etr/86fy83Sp1xWzooLRPFrqeypmf+dHWOFlFSSGMt1f+AJw==
X-Received: by 2002:a17:906:5a4e:b0:982:30e3:ddcb with SMTP id my14-20020a1709065a4e00b0098230e3ddcbmr1193586ejc.65.1689927693044;
        Fri, 21 Jul 2023 01:21:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id p24-20020a170906a01800b00992f2befcbcsm1818243ejy.180.2023.07.21.01.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 01:21:32 -0700 (PDT)
Message-ID: <4898bc33-5245-8fb2-e5e6-8ea1a8f32e1e@linaro.org>
Date:   Fri, 21 Jul 2023 10:21:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: add mcp4728.yaml
Content-Language: en-US
To:     Andrea Collamati <andrea.collamati@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1689857295.git.andrea.collamati@gmail.com>
 <9816cd272d19802ec6eeff0c7c29e85d4a0ade88.1689857295.git.andrea.collamati@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9816cd272d19802ec6eeff0c7c29e85d4a0ade88.1689857295.git.andrea.collamati@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 20/07/2023 17:40, Andrea Collamati wrote:
> Add documentation for MCP4728
> 
> Signed-off-by: Andrea Collamati <andrea.collamati@gmail.com>
> ---
>  .../bindings/iio/dac/microchip,mcp4728.yaml   | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml
> new file mode 100644
> index 000000000000..6fd9be076245
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/microchip,mcp4728.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip MCP4728 DAC
> +
> +description:
> +  MCP4728 is a quad channel, 12-bit voltage output
> +  Digital-to-Analog Converter with non-volatile
> +  memory and I2C compatible Serial Interface.
> +  https://www.microchip.com/en-us/product/mcp4728
> +
> +maintainers:
> +  - Andrea Collamati <andrea.collamati@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,mcp4728

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: |
> +      Provides both power and acts as the reference supply on the MCP4728
> +      when Internal Vref is not selected.
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        mcp4728@60 {

The same... Probably more comments were ignored, so:

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.


Best regards,
Krzysztof

