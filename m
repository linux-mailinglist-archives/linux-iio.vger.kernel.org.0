Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8952A64D7EF
	for <lists+linux-iio@lfdr.de>; Thu, 15 Dec 2022 09:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiLOImr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Dec 2022 03:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiLOImi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Dec 2022 03:42:38 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9243B9D6
        for <linux-iio@vger.kernel.org>; Thu, 15 Dec 2022 00:42:36 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id q6so14522591lfm.10
        for <linux-iio@vger.kernel.org>; Thu, 15 Dec 2022 00:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ghZrTLqof/7uXaABRC9VXiX8vno10E0SDlDFHThQ0JQ=;
        b=IvbGhfYRcE9Ej4dgWstBSKGExQ0XadtXWMI/RukqZQSVvCNvQTzZB9WsYKHbgr6rmf
         W5wfv5GxT5Z/KczEmWarounmcphhsdE0qSZs15jchtAHKFeqsMnia64ej1m42NH2Cjwd
         ZU+qIS4F+YUrYdpDPhk0kLvSwp3ofkm32rnfEGxE7I+q7ULnNCPv/d3fWpfam/vVowg4
         EMwEYC9fAz+NZLFlvoICOn9QMOG5dYnLsw0zyCCUEKTsGwatsG9X13jCM8ZdnJGtTv7C
         GWUoq3UUqF6P6TE1VldZCZs4Fw6r+bhfsUB7G04qIWM2Fi3Oll5AhYBKfT+rnQPVkZnr
         1rfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ghZrTLqof/7uXaABRC9VXiX8vno10E0SDlDFHThQ0JQ=;
        b=SOmfPAmdap3CFlQVnjwE/o2p+4EkECDZxYvUfQjYiHPyE9lrLdUTfYIQ+SlcmrNRGa
         0ML6QCVvBEksd5mmEpTLdELoQ/QIXmh5Fv5tr7GIAwo039Cde06xfrWyQSz7aeMLtDFV
         myDWIKj6tA2vjrA4oZcp06lhPT0YjNgcXihTiOnMgKyLIQe4G9irNSOJqGxIgHdBUyhr
         ob+WnU4Vx/EbOFzUtke2zw/raGlelwGlAsq6OqI1TNf4tn1vRbxk6aX+NnOcCTerXnM7
         GW11xTbMoqwAo6wlnkZMZ2AADOYYE+gKYYQszBgHs3ARQFLfei/DXFU+QKFyMnuIYhLa
         kGsA==
X-Gm-Message-State: ANoB5pmUfrn2pbc8tmNaPtyWxhg/ojs65I0HcwFcroUmrklnkTAnobJT
        wJg1vnx7dvAUdunYsTVVBKPMow==
X-Google-Smtp-Source: AA0mqf6XangecSmY0mz5fiU3fBRv5zdhvdBpprxnLqLecZduE7R5QbWLtR7/ZzJ6CDB+ScTNFb4vkA==
X-Received: by 2002:a05:6512:6d1:b0:4a4:7cab:3bad with SMTP id u17-20020a05651206d100b004a47cab3badmr9144434lff.28.1671093755306;
        Thu, 15 Dec 2022 00:42:35 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id j1-20020a056512344100b004b48cc444ccsm1114148lfr.100.2022.12.15.00.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 00:42:34 -0800 (PST)
Message-ID: <8bb988fc-54d2-2528-e34f-0097c0654b7d@linaro.org>
Date:   Thu, 15 Dec 2022 09:42:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: ep93xx: Add cirrus,ep9301-adc
 description
Content-Language: en-US
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        linux-iio@vger.kernel.org
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221214222024.951984-1-alexander.sverdlin@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221214222024.951984-1-alexander.sverdlin@gmail.com>
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

On 14/12/2022 23:20, Alexander Sverdlin wrote:
> Add device tree bindings for Cirrus Logic EP9301/EP9302 internal SoCs' ADC
> block.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> ---
>  .../bindings/iio/adc/cirrus,ep9301-adc.yaml   | 58 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +
>  2 files changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml b/Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml
> new file mode 100644
> index 000000000000..d0fd24d1be04
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/cirrus,ep9301-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic EP930x internal ADC
> +
> +description: |
> +  Cirrus Logic EP9301/EP9302 SoCs' internal ADC block.
> +
> +  User's manual:
> +  https://cdn.embeddedts.com/resource-attachments/ts-7000_ep9301-ug.pdf
> +
> +maintainers:
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: cirrus,ep9301-adc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: ep93xx-adc

One entry with same name as device is not really useful, so maybe just
drop it?

> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/cirrus,ep93xx-clock.h>
> +    soc {
> +        #address-cells = <1>;
> +        #size-cells = <1>;

I think you do not need the soc node as examples are built with
address/size-cells=1

Best regards,
Krzysztof

