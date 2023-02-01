Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E236868D1
	for <lists+linux-iio@lfdr.de>; Wed,  1 Feb 2023 15:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjBAOrn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Feb 2023 09:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjBAOrl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Feb 2023 09:47:41 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C3C65ED9
        for <linux-iio@vger.kernel.org>; Wed,  1 Feb 2023 06:47:35 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id o18so8071885wrj.3
        for <linux-iio@vger.kernel.org>; Wed, 01 Feb 2023 06:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gbzDe1CVFI/sHQ7+2cszd0vIViQ+1JPEbVO06F5pZLY=;
        b=bA8CgGSqBSfZLQ58lZzv/caQkzVjyU3xNOQiF6myk1/Hnx5FRIga1OevgGqRlIpuQU
         swYFyef3fsEQ7cbfDkq9AQlMJFQ25sc3u5MQxVkH85BH5uYdOvkkIHf5l4pPkXxuPdgy
         9kSiXFej+uvgXPKfOJZy1YA9Fx8VgrIkyjn1qB6lyqgPHCPfOFM7G5s2LTvzOeVcT3h1
         fviEt/36iBmEdDJJnFAibUHXCIhjBeqCmSq50aboHubvKZi9HgqN5PB8GvG4Edl2n+Gp
         /vHjj7Ew0mKVMv42G4FJJvhMffBXEgq4rDwkVBuMkzmslYOqgjOvUyKkmzZ4X/tqW3n1
         ikiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gbzDe1CVFI/sHQ7+2cszd0vIViQ+1JPEbVO06F5pZLY=;
        b=RRLWuMQI0/4Of7w3GzDRAjjsef8qWW+TwtySK2U/FFvPx/rLYn5scXHYMhQpFDRfZv
         fLswI+eyd65wyW4iYXE/yiSDpcXlHmRgApaFL3gabdbTfca6cLmJKxBwazDVW/qFaVeH
         JVSR03yy6h2OUBtLym46eCa3OzEi0L8PMd2i8n3iYPmJnXQOZ9snKWnacB4TDH8jP1Wo
         T6yEz7qGrWSmT9ZenU3sMx2jGb3OE/q+jNVRViH8XvYaybJnYg3P8w9vLIUl76sA+6Vx
         0uyTQhzfdbsfXdFgJnMTjcp4JH4nlJMU/T2QoNRh1i+ELkG15TBJRth55Mq4E80Mg8+Y
         LdUg==
X-Gm-Message-State: AO0yUKVzD3KU1p9owUUMRsDzitiFTWqbJSTxjOXI1GrDz7BDAQqZnz+r
        y6bs4nmWLNoOh8doy+BN0XR7PQ==
X-Google-Smtp-Source: AK7set/7vKlmlNv50Dhu7GRyZM9T0/MfLpj/KdB24M8edxDojZW4kkb/0F9Qt5Gvpip3epkXPGkZGA==
X-Received: by 2002:a05:6000:15cd:b0:2bf:d8ed:ba46 with SMTP id y13-20020a05600015cd00b002bfd8edba46mr3149734wry.47.1675262853842;
        Wed, 01 Feb 2023 06:47:33 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id z18-20020a1c4c12000000b003dc48a2f997sm1781113wmf.17.2023.02.01.06.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 06:47:33 -0800 (PST)
Message-ID: <813bd536-083d-1af4-90f2-059485aec8c1@linaro.org>
Date:   Wed, 1 Feb 2023 15:47:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 4/5] dt-bindings: mfd: Add ADI MAX77541/MAX77540
Content-Language: en-US
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20230201103534.108136-1-okan.sahin@analog.com>
 <20230201103534.108136-5-okan.sahin@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230201103534.108136-5-okan.sahin@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 01/02/2023 11:35, Okan Sahin wrote:
> Add ADI MAX77541/MAX77540 devicetree document.
> 
> Signed-off-by: Okan Sahin <okan.sahin@analog.com>
> ---
>  .../devicetree/bindings/mfd/adi,max77541.yaml | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/adi,max77541.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/adi,max77541.yaml b/Documentation/devicetree/bindings/mfd/adi,max77541.yaml
> new file mode 100644
> index 000000000000..91d15e9ca2e3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/adi,max77541.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/adi,max77541.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MAX77540/MAX77541 PMIC from ADI
> +
> +maintainers:
> +  - Okan Sahin <okan.sahin@analog.com>
> +
> +description: |
> +  MAX77540 is a Power Management IC with 2 buck regulators.
> +
> +  MAX77541 is a Power Management IC with 2 buck regulators and 1 ADC.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,max77540
> +      - adi,max77541
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  regulators:
> +    $ref: /schemas/regulator/adi,max77541-regulator.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,max77540
> +    then:
> +      properties:
> +        regulator:
> +          properties:
> +            compatible:
> +              const: adi,max77540-regulator
> +    else:
> +      properties:
> +        regulator:
> +          properties:
> +            compatible:
> +              const: adi,max77541-regulator

You do not use these compatibles and they do not bring the benefit.
Probably this should be all dropped.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pmic@69 {
> +            compatible = "adi,max77541";
> +            reg = <0x69>;
> +            interrupt-parent = <&gpio>;
> +            interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
> +
> +            regulators {

So no compatible?

Best regards,
Krzysztof

