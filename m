Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6D5530DAC
	for <lists+linux-iio@lfdr.de>; Mon, 23 May 2022 12:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbiEWKQo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 May 2022 06:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbiEWKQn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 May 2022 06:16:43 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE2113D6D
        for <linux-iio@vger.kernel.org>; Mon, 23 May 2022 03:16:42 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bq30so24760719lfb.3
        for <linux-iio@vger.kernel.org>; Mon, 23 May 2022 03:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=j8uqO6uQ4ZVj6x5j3Kl+olRHxX/AM+5LdyICh38VHXE=;
        b=fC9+RpjMk78CzVqFkNwOUai6bcQM0Tesa/wSc2z0nc1VHyYbtwAA/YK9QMSEOKDPgH
         kdXs5N30fwwWeaLGky3V1M3nn9x2Ews948w5x3UcGetJJiK8MivYnNKOx4gk/7k24//X
         GVYiJOhGnGqQqp07xLC1ZIU8lJ43U5kGttsu8NMt9uY7gxl0MR+zTmdNtkIsb4Z53WtN
         Wvykrz9XD+zOTuuMVsayJ5j/mLr+hjNXLik8B+6POPxntfLso+wNK4aqEb47lbQmtCOx
         Z+nGxbcapTHTjd0+MWxZ4k12vkIV56W2+Ir0XckPrFqWDstrJE52AZZbXUWaN8KEPrvK
         lfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j8uqO6uQ4ZVj6x5j3Kl+olRHxX/AM+5LdyICh38VHXE=;
        b=39QTfsaKTCrLumR8Gt9jK4dwc/l/U7q7NTxBADSF26DfLpYjvy0POkI0JVT2ETCoyo
         mpDhjzG6aPWc7B3yVLrFBXCQOoNOHxVjuUHOemxLY43I5CY0LqDG9E0lQhYEkDIWkzW5
         mHTDSejc8X9+3pgrswUJ+yAShX7Pgn4Ec6l1mZLPqZpz+SjMNog9bpiC/ZRcUlyagcQS
         IZIDNokBoLbCljAHcT1mxlAL9sWpcBKnTkoCdZGlW9JzG0AUPzK1UBgIv/mbI4EmWtTi
         +WEH3rDeo5ExoqQgn2cmvCkqoFsxWLgZW4cDeVv7+tImrr+2mvhJrg+WrgXAgjtmNQM3
         Ut4g==
X-Gm-Message-State: AOAM5318T5tQZpwk9Dg55QYOCcgx5YPS2L7iWRxbSFosmy3dxX+lnPm1
        Cbuk2XdRce1lrzdY7Q7hbMiIEA==
X-Google-Smtp-Source: ABdhPJxv2fNPrFHFEbYevTCh7ab2jEDuHx62613siI3C1Md983g45XmCnzx8iSep9cpN92v3xEeFzw==
X-Received: by 2002:a05:6512:6cc:b0:478:6e03:964b with SMTP id u12-20020a05651206cc00b004786e03964bmr3550540lff.283.1653301000478;
        Mon, 23 May 2022 03:16:40 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id n3-20020ac242c3000000b0047255d211e8sm1898666lfl.279.2022.05.23.03.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 03:16:40 -0700 (PDT)
Message-ID: <4cbbd4c2-6d39-da8e-d0fc-c49ba9b8ae7d@linaro.org>
Date:   Mon, 23 May 2022 12:16:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: adc: Add FSD-HW variant
Content-Language: en-US
To:     Tamseel Shams <m.shams@samsung.com>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     geert@linux-m68k.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, alim.akhtar@samsung.com,
        paul@crapouillou.net, linux-fsd@tesla.com
References: <20220520145820.67667-1-m.shams@samsung.com>
 <CGME20220520145759epcas5p240de0ce6d1a1bfea6c8a6bfb61c5d27d@epcas5p2.samsung.com>
 <20220520145820.67667-2-m.shams@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220520145820.67667-2-m.shams@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 20/05/2022 16:58, Tamseel Shams wrote:
> From: Alim Akhtar <alim.akhtar@samsung.com>
> 
> This patch adds a new compatible string for FSD-HW's
> ADC variant
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> Signed-off-by: Tamseel Shams <m.shams@samsung.com>
> ---
> - Changes since v1
> * Addressed Krzysztof's comment to use soc-specific compatible
> 
>  .../devicetree/bindings/iio/adc/samsung,exynos-adc.yaml          | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> index 81c87295912c..ded0e3f85991 100644
> --- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> @@ -14,6 +14,7 @@ properties:
>      enum:
>        - samsung,exynos-adc-v1                 # Exynos5250
>        - samsung,exynos-adc-v2
> +      - samsung,exynos-adc-fsd-hw

The soc is fsd, so compatible should rather be:
tesla,fsd-adc

What does the "HW" mean?

>        - samsung,exynos3250-adc
>        - samsung,exynos4212-adc                # Exynos4212 and Exynos4412
>        - samsung,exynos7-adc


Best regards,
Krzysztof
