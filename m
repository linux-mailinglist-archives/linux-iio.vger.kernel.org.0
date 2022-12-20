Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF4B652390
	for <lists+linux-iio@lfdr.de>; Tue, 20 Dec 2022 16:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbiLTPRe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Dec 2022 10:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiLTPRc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Dec 2022 10:17:32 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1677B8FC5
        for <linux-iio@vger.kernel.org>; Tue, 20 Dec 2022 07:17:31 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id z26so19060056lfu.8
        for <linux-iio@vger.kernel.org>; Tue, 20 Dec 2022 07:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Bfb8g7BISwrdhOoNZNt+w+JRL3WwwI3bJtKpWDxGKM=;
        b=kcFL/RK2WZYqpHLbm/bt3kS9cdDxYa7okQILTC7UpvlKAmsh9WWzz9YnTzJjbSQMyh
         54eP6Y5qPcq2Fl89TjKCKAyZQCOIEW9KT7Wnwdi1HBeCjqU8jDY+aY/IMiLvImEDrNL5
         Wl6NGpty6FSpCrbNNpNtxIh/4VAx3Qq5NUb5Q4S+4GD1UaVyk9VmmXc/HZTo/pU6m2E6
         ikFoWI3eEdfbv3m7xpw/WOTtceI6auErxjFtwI/UlIcP3TQ3gEnSdIpemEx0y8O77eFz
         elaWy/zUyTn3kUD8FKlb5repS8s7M6RS3z00mPCTnR7aSbcqp0QPiDQWRIemVVpjMMUn
         ODSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Bfb8g7BISwrdhOoNZNt+w+JRL3WwwI3bJtKpWDxGKM=;
        b=DY2kJFldt1AEj5ReDz/sW4rOiIC0bfE41VqSRKcd/+yxs/ia+0fPk5s3745ivQyiF6
         noa6S6UvKC509Wvl777kCnfJ5Sh/FV+8t64kN9ezJKyBNrYLQHmBmbmGGoZliw7x/lFV
         3UUKZ3fsOcXnAB/qlB9Pb3QF4zfq/Mr0XOsN6Pf2ZcsY3qZHlAga8pzMh0BPim4vmeQz
         gy/z6RoJfLHRlOlEMe7uvQjpzuOcSO4MKCwyM98Dyoe6SDpA3Di42kQaqmtnnpoqa6g1
         AxKiQL4pElg8+dOzYO5ROn6d1kzUq8vEf5xQOkQMnWKhljS5pfGptJ68uembXZ1ShOoY
         P7eA==
X-Gm-Message-State: AFqh2kpXzBNvzNciL97la4SqTPWs07onrP+qaT4OIGNCcYBi+SaPCZ4B
        qhx7uQUU7NY72M6qjATS3ndx/Q==
X-Google-Smtp-Source: AMrXdXu1A5cm3pHjIM2BbKrs/QmYAb6n/EqXxE24R628tyktySt61YmJu/82aiqbwMW4tr3GXW/Kvg==
X-Received: by 2002:a05:6512:2987:b0:4ca:877d:a546 with SMTP id du7-20020a056512298700b004ca877da546mr836680lfb.12.1671549449468;
        Tue, 20 Dec 2022 07:17:29 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v20-20020a05651203b400b00494a2a0f6cfsm1492580lfp.183.2022.12.20.07.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 07:17:28 -0800 (PST)
Message-ID: <45224908-0776-625b-e0ec-d03c6dfad5c4@linaro.org>
Date:   Tue, 20 Dec 2022 16:17:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/4] dt-bindings: iio: ti,tmp117: add binding for the
 TMP116
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>, puranjay12@gmail.com,
        jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de
References: <20221220150222.1813729-1-m.felsch@pengutronix.de>
 <20221220150222.1813729-3-m.felsch@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221220150222.1813729-3-m.felsch@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 20/12/2022 16:02, Marco Felsch wrote:
> The TMP116 is the predecessor of the TMP117.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  .../bindings/iio/temperature/ti,tmp117.yaml       | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> index 8d1ec4d39b28..d56fbf11edaf 100644
> --- a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> +++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> @@ -7,8 +7,9 @@ $schema: "http://devicetree.org/meta-schemas/core.yaml#"
>  title: "TI TMP117 - Digital temperature sensor with integrated NV memory"
>  
>  description: |
> -    TI TMP117 - Digital temperature sensor with integrated NV memory that supports
> -    I2C interface.
> +    TI TMP116/117 - Digital temperature sensor with integrated NV memory that
> +    supports I2C interface.
> +      https://www.ti.com/lit/gpn/tmp116
>        https://www.ti.com/lit/gpn/tmp117
>  
>  maintainers:
> @@ -16,8 +17,14 @@ maintainers:
>  
>  properties:
>    compatible:
> -    enum:
> -      - ti,tmp117
> +    oneOf:
> +      - items:

These are not items. Just enum.

> +          - enum:
> +              - ti,tmp117

Best regards,
Krzysztof

