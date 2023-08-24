Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419C1787755
	for <lists+linux-iio@lfdr.de>; Thu, 24 Aug 2023 19:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242905AbjHXR4q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Aug 2023 13:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242920AbjHXR4f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Aug 2023 13:56:35 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CD01BD9
        for <linux-iio@vger.kernel.org>; Thu, 24 Aug 2023 10:56:32 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-991c786369cso4302366b.1
        for <linux-iio@vger.kernel.org>; Thu, 24 Aug 2023 10:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692899791; x=1693504591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SeIgpg7tqDJqBOc+expoJZjjqwMIao0DSZsNACjkV2c=;
        b=L+Vfes/QxwQJk6tqzaN7PYVP7w4ICiwynn1QH0Hig4CtFnDHleAS/SmiW9dRj4I0/r
         WwuoJPA5mHJCLeu95b6ReNuGoSIZFEEsxCLuRX2PE3P4o4O9JT6qO8/+EZ5mGe+r1y+h
         YLvRezK6dIiBiklZDNU0V32AlbFBtavduWzUl0zSbE1dlgYjM3k8YLhEGIwEvPd8eteC
         MIAuAFwPULq2PGsg4etbsMyVG7HeyxVBLRkYxLpCJp6IyxZIm4ybOKzPoKfOGsR39Kxe
         QO0WUYDDIOaz+RzFU4wXQMKMcsdyv7a5bS+55f8+uO1sM1beyq1nDBnrCQ+t5s2WVefb
         xT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692899791; x=1693504591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SeIgpg7tqDJqBOc+expoJZjjqwMIao0DSZsNACjkV2c=;
        b=dM4f589Pcuza7EegRHEXLiD2QR64Lpv79JCHUkFikV6mvLxYmtydPNtN1aF6oByW+/
         7UmY921Fl3NHzH25VVJ8+zSsMTNsuxFoLkLcqZLoYWnDWqnAZd+vWL+mno83e/l67RYv
         B0LA/KV9FKZXQbasm2M6sHNdNxTB4B7FeX8K/R9RaQfeUsQ3jiML56HNJ3y7+3o3J9X2
         MVfE25a0nxlREkRmhimtjV1yL6KYCeowNckB0iyjolLNPxXjSuAslEYTWhj796i6bbfF
         YQw6oG+w8CZWfNoQLOr2SGTRPxkkGk2oIF0mg9i9hnPxoQnYWY2Rt8NrKOF7LzL8XhXU
         zFFQ==
X-Gm-Message-State: AOJu0YwEOANDY1G8rFqx8ma/md7ihu4UXhltE9R5HO1DyLWc5C1qclBD
        RDy0meAWYKU1jSqM2nV8ckhH/A==
X-Google-Smtp-Source: AGHT+IGy1QVnvIcc8n9xLBEYihQVUWgrW17xm3/XEuV2xRk0cRnqNo6UrdD6MfIy30Llypv2gQ2/Kw==
X-Received: by 2002:a17:906:10dc:b0:9a1:bf00:ae53 with SMTP id v28-20020a17090610dc00b009a1bf00ae53mr6579043ejv.69.1692899791218;
        Thu, 24 Aug 2023 10:56:31 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id o15-20020a1709061b0f00b00985ed2f1584sm11239555ejg.187.2023.08.24.10.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 10:56:30 -0700 (PDT)
Message-ID: <e54273c7-4728-7577-f053-b15307d3a083@linaro.org>
Date:   Thu, 24 Aug 2023 19:56:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 3/3] dt-bindings: iio: adc: add lltc,ltc2309 bindings
Content-Language: en-US
To:     Liam Beguin <liambeguin@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230824-ltc2309-v1-0-b87b4eb8030c@gmail.com>
 <20230824-ltc2309-v1-3-b87b4eb8030c@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230824-ltc2309-v1-3-b87b4eb8030c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 24/08/2023 18:55, Liam Beguin wrote:
> Add devicetree bindings for the Linear Technology LTC2309 ADC driver.
> 
> Signed-off-by: Liam Beguin <liambeguin@gmail.com>

Thank you for your patch. There is something to discuss/improve.


> +++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2309.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: GPL-2.0

Wrong license. Run checkpatch before sending patches.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/lltc,ltc2309.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Linear Technology / Analog Devices LTC2309 ADC
> +
> +maintainers:
> +  - Liam Beguin <liambeguin@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - lltc,ltc2309
> +
> +  refcomp-supply:
> +    description: Power supply for the reference voltage

refcomp is not a supply. It is called "Reference Buffer Output.". You
probably wanted vref-supply, which suggests you should just add it to
ltc2497 bindings. I don't see any differences.

> +
> +  reg:
> +    enum:
> +      - 0x08
> +      - 0x09
> +      - 0x0a
> +      - 0x0b
> +      - 0x18
> +      - 0x19
> +      - 0x1a
> +      - 0x1b
> +      - 0x28
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@28 {
> +            #io-channel-cells = <1>;
> +            compatible = "lltc,ltc2309";
> +            reg = <0x28>;

If the example stays, then order is compatible first, then reg, then the
rest. Also add the supply to make example complete.

But I think this should be squashed with other binding so no need for
the example.

Best regards,
Krzysztof

