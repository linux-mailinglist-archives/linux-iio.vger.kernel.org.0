Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F9E53A088
	for <lists+linux-iio@lfdr.de>; Wed,  1 Jun 2022 11:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351138AbiFAJeX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Jun 2022 05:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346321AbiFAJeW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Jun 2022 05:34:22 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC448AE75
        for <linux-iio@vger.kernel.org>; Wed,  1 Jun 2022 02:34:20 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 25so1094385edw.8
        for <linux-iio@vger.kernel.org>; Wed, 01 Jun 2022 02:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=roNxqKUu0+AV4DeO1JbEmmYOyNX8wIcqoT9AzN3Cm2M=;
        b=bRYOQ9fGbJR0V+y0wEZKLfg/TqqyZIxzKGA17cV2dYd4XNtRdHyH4/yeq/LxJn/NsU
         j6OqB6oDPLhE4+MsUHuxGDg87PixqxiwzQaEWzu7LQlfhqmrcWF4UkzqEBolU2arg+t6
         ZEwzrsNkZLoDZczkN8gxN3A8zioU+OYUAKXz6M2fKE+P44DYTD4hjyLrpXG1BBn8GjtJ
         Zwt1N2HkZX6pvO+XccPH+zn+GyEdE+57hkLjfHZB8pbh1tqGeuiAAR6NSEznBiagvjAc
         M1xkmzTZ28Y8eJe5MQO0kbBJUDQjPWxbeeOzk7JlypHCfAslHnHPBBQFMRZo+sI+F7y6
         ilhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=roNxqKUu0+AV4DeO1JbEmmYOyNX8wIcqoT9AzN3Cm2M=;
        b=w7MTA2abfShb46/6N2bZAU8d+hJZvMIErLSeUkUsuwgQgsLtN3GVVC29ZwonzqOSUK
         osOKDMrIP1cFYKmF9B/5vaZSmHe0n0SBu+FNDVG1zeOEELyQmswj39HYhzgKlhld1hoz
         +VeYphU7n0GyyS4nfr0cMZ4QUN6WSBObd3HrzLlQljZ46cDekuILTttCq/hiajk6HIYR
         pIlNd6c0OUNap2pjyvrIOMSjxpvdhJDNgCisjneXCg0kIOxE4a4PRWLArnoBc77Szsyc
         vrRNzqIdohwnx8+LlwI160V4IRgx7afvlneYe+eR+Puu5TmLWWRcukBQLDa7cRZtMzEq
         PY8g==
X-Gm-Message-State: AOAM5332t7FHloaJM6pKC195s8wDS+Y7Li9vvGE8PjElV4f6VmSJHzVr
        g2PeEtBOYJYxUO2eRNtM6yrypA==
X-Google-Smtp-Source: ABdhPJzh9Lf8L/NKchmFQc388SPcHvGUJvGg8NbDDJ7Sxuy5dahguWAyQXRYAWLbvqWHCJKhyvlBgQ==
X-Received: by 2002:a05:6402:42c1:b0:42d:fba6:d5c5 with SMTP id i1-20020a05640242c100b0042dfba6d5c5mr1180660edc.295.1654076059375;
        Wed, 01 Jun 2022 02:34:19 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b8-20020aa7c6c8000000b0042617ba637bsm710427eds.5.2022.06.01.02.34.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 02:34:18 -0700 (PDT)
Message-ID: <c510cf8e-4111-8886-99e0-8ad35b3086a8@linaro.org>
Date:   Wed, 1 Jun 2022 11:34:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 02/17] dt-bindings: memory: add mt8365 SoC binding
 documentation
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        qii.wang@mediatek.com, matthias.bgg@gmail.com, jic23@kernel.org,
        chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, chunfeng.yun@mediatek.com,
        broonie@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net,
        Yong Wu <yong.wu@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20220531135026.238475-1-fparent@baylibre.com>
 <20220531135026.238475-3-fparent@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531135026.238475-3-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 31/05/2022 15:50, Fabien Parent wrote:
> Add MediaTek SMI bindings for MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  .../bindings/memory-controllers/mediatek,smi-common.yaml    | 6 ++++++
>  .../bindings/memory-controllers/mediatek,smi-larb.yaml      | 6 ++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> index a98b359bf909..e1029ac99ab4 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> @@ -46,6 +46,11 @@ properties:
>            - const: mediatek,mt7623-smi-common
>            - const: mediatek,mt2701-smi-common
>  
> +      - description: for mt8365

Skip description and:

> +        items:
> +          - const: mediatek,mt8365-smi-common

This should be rather enum. I see existing code did that way, but this
way makes it bloated. If new device compatible with mt8186 comes, should
be added to this enum, not to new items.

> +          - const: mediatek,mt8186-smi-common
> +
>    reg:
>      maxItems: 1
>  
> @@ -130,6 +135,7 @@ allOf:
>              - mediatek,mt8192-smi-common
>              - mediatek,mt8195-smi-common-vdo
>              - mediatek,mt8195-smi-common-vpp
> +            - mediatek,mt8365-smi-common
>  
>      then:
>        properties:
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> index c886681f62a7..815d87fc64a0 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> @@ -32,6 +32,11 @@ properties:
>            - const: mediatek,mt7623-smi-larb
>            - const: mediatek,mt2701-smi-larb
>  
> +      - description: for mt8365
> +        items:
> +          - const: mediatek,mt8365-smi-larb
> +          - const: mediatek,mt8186-smi-larb

Ditto.

> +
>    reg:
>      maxItems: 1
>  
> @@ -78,6 +83,7 @@ allOf:
>              - mediatek,mt8183-smi-larb
>              - mediatek,mt8186-smi-larb
>              - mediatek,mt8195-smi-larb
> +            - mediatek,mt8365-smi-larb
>  
>      then:
>        properties:


Best regards,
Krzysztof
