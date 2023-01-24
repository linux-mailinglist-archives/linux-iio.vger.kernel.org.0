Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E083679341
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jan 2023 09:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbjAXIjT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Jan 2023 03:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjAXIjS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Jan 2023 03:39:18 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FB33A864
        for <linux-iio@vger.kernel.org>; Tue, 24 Jan 2023 00:39:16 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so10327370wmc.1
        for <linux-iio@vger.kernel.org>; Tue, 24 Jan 2023 00:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jC8u09KVIYtGZaoQ2r32KroNFKnC3uPw8Fq2mJfgGM4=;
        b=oBkW63HdzaVrqHGY/bOlHlUxwT7nnWwUIlEzGV77+CyI4bFvV1mDZoBnyJ8sfithA3
         g4X8L/7XC6af1Orb+qKlYYnCEPvvCkEdOJlkekTgXO3RealtkP+fFF7gM94F4dybN/+w
         ZyWarYuACLEgR7RU/OspYViNGyo/cVGDbcuWreKW/M5tadKOed56JwCgKvsTM7zzkKqH
         mu0LQW1PvlwdtrPkPdpl1bF7UQTt1jJmwU/2Te+Uy4ozznKfZRDsHHKLj9BRDuUrWeFG
         AtiMKn4yDvnihghWXAn2/NaLfCq0CSOL1SBjKYIvs0ZOIDiEMRdmH9SeUyiN1r8dc/bT
         /jSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jC8u09KVIYtGZaoQ2r32KroNFKnC3uPw8Fq2mJfgGM4=;
        b=PXdLaIMymsg0sxBB9OIyNmVjGvWL8+hM6LxfpDO8n9l8jN4ZnHgOw89tFCerSA+MJj
         T9Y1J7TjbGQ4B3MXI3DtYVoAKFHCJjKsqAn6jM5gy2BQJ4/jkxP3i6tECX+lWEdaYNdO
         YVJJUHzcdY2On0qiFZ5doiCHv6Sn8jBMYNVczIXZ1gIpAeCWlPcx2qmAQ4N2m1dheG8n
         m3JyNeyBXGYwe2T79K8ftG3/0SLM6DgKis0nW9jmcmcFqbtE5ob4VCAeP3p/KcApfUjb
         Z3Lym3alAT8wxN3o5S4P5pi6s7zFyoNGkDzqau64kBleozdCttzbtqHJewxVxqJ973wX
         n9Og==
X-Gm-Message-State: AFqh2kp6WXEZdQDfCbmuIwErE5eog+I72nutgJUdJyCZMuMlu2Mlgfm7
        mJ/eZKApE5aY8oz1dq7LoTrv/Q==
X-Google-Smtp-Source: AMrXdXufp48kEceydwMciETTRdgGdjkWekSy7PYkJC1lT0Y9uFBmq5Ow/biKLLOKxuG3HKY6+Zji5g==
X-Received: by 2002:a05:600c:601c:b0:3d3:4f56:62e1 with SMTP id az28-20020a05600c601c00b003d34f5662e1mr26894618wmb.27.1674549555178;
        Tue, 24 Jan 2023 00:39:15 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k16-20020a7bc410000000b003d99469ece1sm12667052wmi.24.2023.01.24.00.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 00:39:13 -0800 (PST)
Message-ID: <6abc3265-75a2-1fa6-803e-6066a81b8ec5@linaro.org>
Date:   Tue, 24 Jan 2023 09:39:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 12/12] dt-bindings: iio: accel: Add ADIS16203 Inclinometer
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Barry Song <baohua@kernel.org>
References: <20230123211758.563383-1-jic23@kernel.org>
 <20230123211758.563383-13-jic23@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230123211758.563383-13-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 23/01/2023 22:17, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> There has been a driver in staging for quite a while.
> Given we are now moving it to the main tree, time to make sure it
> has binding documentation.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  .../bindings/iio/accel/adi,adis16203.yaml     | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml
> new file mode 100644
> index 000000000000..05c095247e10
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accel/adi,adis16203.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADIS16203 Programmable 360 degree inclinometer
> +
> +maintainers:
> +  - Jonathan Cameron <Jonathan.Cameron@huawei.com>
> +
> +properties:
> +  compatible:
> +    const: adi,adis16203
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 2
> +
> +  interrupt-names:

maxItems (and probably minItems)

> +    description:
> +      Device has two configurable outputs, both of which may be used
> +      as interrupt sources.
> +    enum:

This won't work. It's an list. You need:
items:
  enum:
     .....

> +      - dio0
> +      - dio1
> +
> +  reset-gpios: true

maxItems: 1


> +
> +  vdd-supply: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        accelerometer@0 {
> +            compatible = "adi,adis16201";
> +            reg = <0>;
> +            spi-max-frequency = <2500000>;
> +            interrupt-parent = <&gpio0>;
> +            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "dio0";

You require here two items, according to interrupts. Don't you miss
minItems?

Also... if you tested the binding it would complain here.

> +        };
> +    };
> +...
> +

Best regards,
Krzysztof

