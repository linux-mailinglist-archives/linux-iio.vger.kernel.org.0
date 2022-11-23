Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AC8635AAF
	for <lists+linux-iio@lfdr.de>; Wed, 23 Nov 2022 11:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbiKWKyj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Nov 2022 05:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236786AbiKWKyN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Nov 2022 05:54:13 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39912A1A9
        for <linux-iio@vger.kernel.org>; Wed, 23 Nov 2022 02:42:43 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id a15so20896817ljb.7
        for <linux-iio@vger.kernel.org>; Wed, 23 Nov 2022 02:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SFhD7QC44SxOlkV79GY7+KSSqImgOzRfkuug/txS8GU=;
        b=Um3cKNCLliSNFFOp/SCkJ2A2/AP0+U7KDXN4dOTM7cZbX+WKqoazt4ocGIYEkxplHe
         DraDsAT50Ss/8kmq6fgkt8DaqkdDB7xwSReS2azwBUos6r6i/tK3pdGs/pPJioE8qi18
         S/NjFYyRWc4g6+3Y44CBf+VTlT7Ru91C/gUHVPMcTEx+BQFXfZJQbgwe5Q2rZ2ccaUoW
         0jpLqea+BI/TJuwP/mCADlmMQhBFmZIk+AMCjKy2ZRqTBkUdn/Cfh8XQ9Z7MjSNXAsFg
         hDAY16nx16c+x4zx7kMWwLjoJou3WXTUdj5c2dBS5hBDLJE9004q+rw9hLY7Efz8wPCb
         0kvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFhD7QC44SxOlkV79GY7+KSSqImgOzRfkuug/txS8GU=;
        b=PEAc0Cy86QchEx2Dn+IESf7FqBGtCW5oTiJGxsIahl8Tzj4NyjY6/GlABzR0CKpubD
         fObOaACQcTk+mAo3XEXpth/HB03x2KjNCyADc57jzwXxJXBmW6X5MORZbpFJp82DXei+
         mOs0xuSZbEKYa+rawyc6t0kn4qRwu2cDv6nwIR+3wg6OycNnphPVpFAPvF7/hsMtHu/k
         2LcZnuosueirLuAnmFqBx5a0ggN+D2MwJKPkBJAEnkMy92Lf9zr3dXRAa1zO+UGeP8ku
         RDV7ppH9ZiAcz1VMKfQx34/SMa3p2Y12ja8g9ySOV2HpZvbTyG1RHI36GxMMPbrnV6ae
         CjCg==
X-Gm-Message-State: ANoB5pm2dwAIR0mBO5L9IWIEx5K8zu0cb9OjhhaRQzE2U1/eHHleeh4X
        urynr2MO/9pW0ib4RIBZNWax4A==
X-Google-Smtp-Source: AA0mqf6OwBtKnetF7rPsU+gfC7YfZB+DUwA9k6T7BmGVAqWuNL1Nrfu+r+fTHCNn2zyoKX9H0WMWfA==
X-Received: by 2002:a2e:a544:0:b0:278:f5b8:82c8 with SMTP id e4-20020a2ea544000000b00278f5b882c8mr5227138ljn.228.1669200161613;
        Wed, 23 Nov 2022 02:42:41 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k2-20020a2eb742000000b002770fb5722fsm2164729ljo.123.2022.11.23.02.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 02:42:41 -0800 (PST)
Message-ID: <c96d84e9-44d0-a389-429d-91d8a7d747b5@linaro.org>
Date:   Wed, 23 Nov 2022 11:42:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5] dt-bindings: iio: adc: ad7923: adjust documentation
Content-Language: en-US
To:     Edmund Berenson <edmund.berenson@emlix.com>
Cc:     Lukasz Zemla <Lukasz.Zemla@woodward.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221122161437.18937-1-edmund.berenson@emlix.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221122161437.18937-1-edmund.berenson@emlix.com>
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

On 22/11/2022 17:14, Edmund Berenson wrote:
> - The ad7927 is fully compatible with ad7928 driver, add
> documentation for device.
> - ad7923 and ad7924 are treated the same in the driver, show
> the relationship in the documentation.
> 
> Suggested-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
> Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>
> ---
>  .../bindings/iio/adc/adi,ad7923.yaml          | 26 ++++++++++++-------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>

1. This is a v5, what are the changes?

2.
This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However, there's no need to repost patches *only* to add the
tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.



> ---
>  .../bindings/iio/adc/adi,ad7923.yaml          | 26 ++++++++++++-------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 


Best regards,
Krzysztof

