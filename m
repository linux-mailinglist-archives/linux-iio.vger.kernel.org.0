Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF8B639A9D
	for <lists+linux-iio@lfdr.de>; Sun, 27 Nov 2022 13:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiK0MvZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Nov 2022 07:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiK0MvZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Nov 2022 07:51:25 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855B4B1DA
        for <linux-iio@vger.kernel.org>; Sun, 27 Nov 2022 04:51:22 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id d6so13512468lfs.10
        for <linux-iio@vger.kernel.org>; Sun, 27 Nov 2022 04:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=42d1uIdwpyKuYTq13kmw7mH6z8HdgyJFRMpcVjIqtRg=;
        b=vdXR+OpCUsjgc3lkwZPgirtYD5MufsANbJ8oEJPmf+6kN4QfiXWwqsdN7vs0HA1J0H
         sNxsYLm1GFb9tMbqQ1/F2g9muhvNUBCqfBI6dbujPUs2eUF6Ah/pAT39G63izyn8C8WW
         yD+Mjt6d/1jjAP1K+ROVEjFWt9vFh9F9KViV9TjmL7G3L6XupNzkjL8NgHmxv3Nea31j
         QaYRhXpHIEwZVMLEBZYsczWsTh5Za8VdvWLvxu1ybu4cKA466HOGaxvkq5xiOzklgeUG
         LC0SRWOXe9lHsRNBONwXppPhtJAEk+KVubg1tfpvvEiHDf7skS4HySQpONWd+mEQs2pV
         DIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=42d1uIdwpyKuYTq13kmw7mH6z8HdgyJFRMpcVjIqtRg=;
        b=sRqPGH/ALT5VsHyW5xFXwzl7i8yGBqXrpDxheEqbi3lN3F/rvJUEuu/jaPAg82x3Ly
         oGdADUYSA0rq51U+as0ORHbm8lo3TpzvvxgYxsg3OZoIa6dRpUZGwi2O2kGevDz/6+yn
         GW2Bz9DzWWtDJ/vIHdOP2lP/WL7MoPASBhncEVRnxse9oA7lGuKxT8xoK8tK21V5rtsY
         n8JbAacYIJN/utX2uBPldZfD4g2txcRYKGZshXSYl5VcuW8VduXXV+YA4+MHURs2jxEs
         uOBkpGOsD0aI+Gvp7eVdMs/p6ua/A9ePnkGZLtnDZAJQ9E6hmd+Dl4e9LjT0ZsDja6WO
         X2SQ==
X-Gm-Message-State: ANoB5plrujQz5ekvDUoeK0xzsz5/Nr5VTsKyIkk5+RtlCDVeW94KDH2Q
        MX2uMTYcVXsBvvt8IWHDxtWICg==
X-Google-Smtp-Source: AA0mqf6P7yDoGSrnTqjkCSz89GYycciOApljdH30M+ggbtc5LKgfW/rM+t6eKcq8WJGuNVib6SPRLw==
X-Received: by 2002:a05:6512:20c1:b0:4a6:396d:a06a with SMTP id u1-20020a05651220c100b004a6396da06amr16473344lfr.514.1669553480829;
        Sun, 27 Nov 2022 04:51:20 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bf31-20020a2eaa1f000000b00279a25c2427sm111423ljb.139.2022.11.27.04.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 04:51:20 -0800 (PST)
Message-ID: <e4be94a3-cdfc-cdf8-5d69-0eef480033f9@linaro.org>
Date:   Sun, 27 Nov 2022 13:51:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] dt-bindings: iio: adc: ti,adc081c: Document the binding
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221125220903.8632-1-samuel@sholland.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221125220903.8632-1-samuel@sholland.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 25/11/2022 23:09, Samuel Holland wrote:
> Linux has a driver for these ADCs at drivers/iio/adc/ti-adc081c.c, but
> the compatible strings were undocumented. Add a binding for them. The
> hardware has an alert interrupt output, but existing ti,adc081c users
> do not provide the 'interrupts' property, so leave it as optional.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  .../bindings/iio/adc/ti,adc081c.yaml          | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,adc081c.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,adc081c.yaml b/Documentation/devicetree/bindings/iio/adc/ti,adc081c.yaml
> new file mode 100644
> index 000000000000..caaad777580c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,adc081c.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,adc081c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI Single-channel I2C ADCs
> +
> +maintainers:
> +  - Jonathan Cameron <jic23@kernel.org>
> +  - Lars-Peter Clausen <lars@metafoo.de>
> +
> +description: |
> +  Single-channel ADC supporting 8, 10, or 12-bit samples and high/low alerts.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,adc081c
> +      - ti,adc101c
> +      - ti,adc121c
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vref-supply:
> +    description:
> +      Regulator for the combined power supply and voltage reference
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg

Why not requiring io-channel-cells? If it is an IIO ADC provider, you
need the cells, right?

Best regards,
Krzysztof

