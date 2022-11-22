Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C1F63406D
	for <lists+linux-iio@lfdr.de>; Tue, 22 Nov 2022 16:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbiKVPjl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Nov 2022 10:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKVPjj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Nov 2022 10:39:39 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49362706
        for <linux-iio@vger.kernel.org>; Tue, 22 Nov 2022 07:39:38 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id x21so18337176ljg.10
        for <linux-iio@vger.kernel.org>; Tue, 22 Nov 2022 07:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ds8Sy9Qo0VlxaGfYZfQDdKcBEoXNjqFnH02Jzco/bEA=;
        b=lk1QsjWdooS9s/Fhmb9/UR2iEAgaGSjYskun7Wnkf/gMr57Ths5J3/laG66JVjx0s7
         r6SPRs/z6fKrAtfGZOu+Lrg8JyO7a9VdoZF8FXMhujUwbioAGHZCjp24aokB6xo4Mim2
         PfAIUfSGsVn+NHg1Q+R0PiWmZhS5Y8w/a7OJF5r1WSM5uhPuw511WBMoZ0wpvLDBl6FE
         BOBW+eShfw/V+dMLlSGDW3fJWoNzZYdX8pNMnPW2Myk3OizgIgayS+cPqogQchx8AFwL
         tCn5Ejgh7kWV8J+ZxdiyzddH9iyRR4iaWAPSPp6X5qyPrVgkfNEblOI/z1THa46PFv/G
         Ub2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ds8Sy9Qo0VlxaGfYZfQDdKcBEoXNjqFnH02Jzco/bEA=;
        b=AjOA8f7FrIyVuLnAOxcQxQJVNcvdyxc7Hdz1hnAE4VY/60g6KbhInsuOZADeoc4SEg
         qak9ZdNFGt9pPKZVqkihfRVYvbSm+Rt02xUTnthFr3543kIDeayufu2vMpnpPSQQwoRj
         GhojEfskfuVi0FNfRo2oTxgkSjPFInOSD5F6x0hWLRFI9GTxXG/DGRfZg1f8+v7LjF5b
         KUmxPmfyb3orC0T36MyPI+D6PNvfjui+KJwDAEccDz84LLKdix0RwsGv6CzUKXtElrtU
         cC+nZbc/s6Jvdz4jpuoDTTb1VGNDYVyHy9dffPD8agjQWoKlEi3c5uJ54R+3p7dIPNJq
         q5xg==
X-Gm-Message-State: ANoB5pnKx/ssz4ZLyhDz/Ie01ZO40qr764+4nJZFKgn7viOiWM2tOVvy
        on9FB+jdeJVnv9s7uHrLNa4+gw==
X-Google-Smtp-Source: AA0mqf5pPAK3W4v8an/eR+cieEGeNBfDtiHWiAnML0e5MFDjyCE5sQTecKnWv5WEaFVv9FlPUuqd/A==
X-Received: by 2002:a05:651c:10a1:b0:26e:a:b5c9 with SMTP id k1-20020a05651c10a100b0026e000ab5c9mr2069061ljn.481.1669131576967;
        Tue, 22 Nov 2022 07:39:36 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c4-20020ac25304000000b0049fff3f645esm2507227lfh.70.2022.11.22.07.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 07:39:36 -0800 (PST)
Message-ID: <17b4eb3a-97ab-905d-f8f2-eb5669e4854f@linaro.org>
Date:   Tue, 22 Nov 2022 16:39:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4] dt-bindings: iio: adc: ad7923: adjust documentation
To:     Edmund Berenson <edmund.berenson@emlix.com>
Cc:     Lukasz Zemla <Lukasz.Zemla@woodward.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221122140543.11230-1-edmund.berenson@emlix.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221122140543.11230-1-edmund.berenson@emlix.com>
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

On 22/11/2022 15:05, Edmund Berenson wrote:
> - The ad7927 is fully compatible with ad7928 driver, add
> documentation for device.
> - ad7923 and ad7924 are treated the same in the driver, show
> the relationship in the documentation.
> 
> Suggested-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
> Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>
> ---
>  .../bindings/iio/adc/adi,ad7923.yaml          | 25 ++++++++++++-------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> index 07f9d1c09c7d..b6e2f1b41739 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> @@ -11,7 +11,7 @@ maintainers:
>  
>  description: |
>    Analog Devices AD7904, AD7914, AD7923, AD7924 4 Channel ADCs, and AD7908,
> -   AD7918, AD7928 8 Channels ADCs.
> +   AD7918, AD7927, AD7928 8 Channels ADCs.
>  
>    Specifications about the part can be found at:
>      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7923.pdf
> @@ -20,14 +20,21 @@ description: |
>  
>  properties:
>    compatible:
> -    enum:
> -      - adi,ad7904
> -      - adi,ad7914
> -      - adi,ad7923
> -      - adi,ad7924
> -      - adi,ad7908
> -      - adi,ad7918
> -      - adi,ad7928
> +    oneOf:
> +      - const: adi,ad7904
> +      - const: adi,ad7908
> +      - const: adi,ad7914
> +      - const: adi,ad7918
> +      - const: adi,ad7923

Keep all others as enum.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

