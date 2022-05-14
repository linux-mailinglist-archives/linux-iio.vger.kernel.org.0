Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926BC527401
	for <lists+linux-iio@lfdr.de>; Sat, 14 May 2022 22:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbiENUfr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 May 2022 16:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbiENUfq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 May 2022 16:35:46 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D674B48
        for <linux-iio@vger.kernel.org>; Sat, 14 May 2022 13:35:44 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id u23so19879061lfc.1
        for <linux-iio@vger.kernel.org>; Sat, 14 May 2022 13:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=e3G8IpqywDEQjEr7fmlZZGPKai6zzPVpDCaOqxUYl4o=;
        b=jEK2JlILacvWZfOhR+2DWw03FiULAN4nWySfk/IrAeRpT14JXfDBPRJBpUoMdnRanN
         8ugH35mztPZY18+7cQVNRCaVhptMQby2AbOl/9pzrz8TiyhxH59hotuxtFSYz/1qh2cB
         O0yqMboPEUAYkJPSNXNSBzvhw0Q8Y0ceQkhp6P9Xf3QY3PHx6BJiBqNeLcLnDWQ/Qkkd
         gc30kUJTi6HUMcfb/qcxYKd6/PtmmfCwA2cJ7TwljUyEn1SLmcsEt1n6UzTr+6whqv17
         zg4bsx9yVCe7F17woEvlYqhvGUsQ2US9UYdmcfaJ/LvEYwkE2WucOcJozzCeNYLUYKWZ
         OXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=e3G8IpqywDEQjEr7fmlZZGPKai6zzPVpDCaOqxUYl4o=;
        b=5TsG0IVhqnuZu88mvPJTWPM4YKibzFAy0EdHpPSkvHi3KWz0nRRxU7b/BY5mZHpjQE
         MZOnpPOwcf9CY4/fVlqBB2gsZs7K+6RavjbuTJ/g9O0KP3z9qXkxVptU7f4FM+hXDsEy
         /nlmNWrOn7C1zFJ0hr6wgKVVw5nJsLJ+NWUKeXNze3I4Bwa8SxacHLUHIjLU9v9iFw+D
         OsPGl5F0ZsmtRSe13nOMHqj1YrReG/E6B1dwWMqOyF1rX57s1MeqsxHI/FKrfyYn1aBz
         SZbet+l9EuBe1vHw7ZMbRdu3g1CoJ8ZsKgyuoEFbp49GI0txKK/1phSE8m3ve5jUG8xK
         gNKw==
X-Gm-Message-State: AOAM531MSDAsEkqtSUk8qISGZic7X5t7gjC1W/6vUIpiZEStEpp74Ag5
        hJLkICUiqMaGhu7iL+FKxsniDu/oGWArsY6E
X-Google-Smtp-Source: ABdhPJwex93OlPwmCPUB5CECyMFJc82mJEGHOYURcMK+oK4G1BeIA9Na0fcC5JYFA12N1ZiGHSaN6w==
X-Received: by 2002:ac2:4646:0:b0:472:108e:51af with SMTP id s6-20020ac24646000000b00472108e51afmr7998828lfo.184.1652560542320;
        Sat, 14 May 2022 13:35:42 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id x2-20020a056512078200b0047255d21166sm805217lfr.149.2022.05.14.13.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 May 2022 13:35:41 -0700 (PDT)
Message-ID: <39a41150-6ac8-e158-f21d-15884b34a6e5@linaro.org>
Date:   Sat, 14 May 2022 22:35:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2UL
 ADC
Content-Language: en-US
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
References: <20220511082325.36185-1-biju.das.jz@bp.renesas.com>
 <20220511082325.36185-2-biju.das.jz@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220511082325.36185-2-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/05/2022 10:23, Biju Das wrote:
> Document Renesas RZ/G2UL ADC bindings. RZ/G2UL ADC is almost identical
> to RZ/G2L, but it has 2 analog input channels compared to 8 channels
> on the RZ/G2L.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v3->v4:
>  * Removed unnecessary SoC specific reg description as it is
>    equivalent to the logic used in reg.
>  * Removed Items from reg.
> v2->v3:
>  * Added generic description for reg.
>  * Improved schema validation by restricting both channel and reg to [0-1].
> v1->v2:
>  * Started using generic compatible for RZ/G2UL and added SoC specific validation
>    for channels.
> ---
>  .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 30 ++++++++++++++++---
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> index d66c24cae1e1..ae6226c1044e 100644
> --- a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> @@ -19,6 +19,7 @@ properties:
>    compatible:
>      items:
>        - enum:
> +          - renesas,r9a07g043-adc   # RZ/G2UL
>            - renesas,r9a07g044-adc   # RZ/G2L
>            - renesas,r9a07g054-adc   # RZ/V2L
>        - const: renesas,rzg2l-adc
> @@ -76,16 +77,37 @@ patternProperties:
>      properties:
>        reg:
>          description: |
> -          The channel number. It can have up to 8 channels numbered from 0 to 7.
> -        items:
> -          - minimum: 0
> -            maximum: 7
> +          The channel number.
>  
>      required:
>        - reg
>  
>      additionalProperties: false
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a07g043-adc
> +    then:
> +      patternProperties:
> +        "^channel@[2-7]$": false
> +        "^channel@[0-1]$":
> +          type: object

The actual type was defined earlier - in your first "patternProperties"
- so this "type:object" should not be needed.

> +          properties:
> +            reg:
> +              minimum: 0
> +              maximum: 1
> +    else:
> +      patternProperties:
> +        "^channel@[0-7]$":
> +          type: object

Ditto.

With both removed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
