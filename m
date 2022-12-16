Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE9C64EA74
	for <lists+linux-iio@lfdr.de>; Fri, 16 Dec 2022 12:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiLPLbH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Dec 2022 06:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiLPLau (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Dec 2022 06:30:50 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19F01C12F
        for <linux-iio@vger.kernel.org>; Fri, 16 Dec 2022 03:30:45 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id v11so1800452ljk.12
        for <linux-iio@vger.kernel.org>; Fri, 16 Dec 2022 03:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=05rB3U3b128McDFXG+s8KkNAz+6RDwWkT+PP9f8F8g0=;
        b=CYF7wwDduN06j7EB8tWkH8cas//i9408CEC94xDtMIUSVVjWMvzOR625N8hH0EGvqG
         Ep0ZAb6GP0omDHpJPWGfLOyHjvw/ZFf0xPwMuRrNlCuXFkNFfAdTaI2BqtRWMfQLJbpP
         oKscIgxdH33uKinTOOv/C5yLi8JY83w4zgFZwTHAIGJeEM69GiI4dcTIsy4lo5rYB6iR
         8f4CuG3INKmY800QFaUh9ri4EUXVc2L3EmxivEffUe2ZQW+k9O+zIAptAVV+RbfzAV1U
         J5kwkazGf6Dac46EAR4BqE1ynBWAAGcAzwrAAwD6YG9H4ErYZ4YwMVPKcm5DvHYUh0DD
         6k0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=05rB3U3b128McDFXG+s8KkNAz+6RDwWkT+PP9f8F8g0=;
        b=KfHVJoqSqqHLFdInzMFjRVuAjuQBwCtVf9ZkpMI5RxFmdHnoU7uP1+37JNkHe6LWYK
         5gIez9VdKDRlhR2ihtplE/iXhLmh1+SClieI17/QIsGBtOs5KRFjIVMKGP14ITIZienP
         tDU4o+IVcs6LGiK+HGitN9Q6TfCYqGuOTXShD68wOtdpunAx5/8/HuUhA6AfZC+kCmuP
         ts5UjuJ6eaMqJMntinlTPcZilpcnFJx7savZ8SQ1jo54dBc0UpE/0Tjxt0KH+O+awED2
         ceI3TlNMdnfJHqY2JeiFfo5bEsIPGtoRnQrpAvO1lItEgtwP87CbjU9b7E3cSPB5+1fC
         +V9A==
X-Gm-Message-State: ANoB5pnHoPrZQuC/hdY9clutysMV6VtjpR80fLkP/N1lw7XJdmbxCgXc
        EDSTEbKe5lfs/oD8q1GBGqOJLGlY9L0YGupK
X-Google-Smtp-Source: AA0mqf5pFuvT/S4FjixUoT6vGlM3G/op9kapqcPJ8/DLnGwyFrfT5P+FnPPT4w1U+a9+HK4JUtFF2Q==
X-Received: by 2002:a2e:b544:0:b0:276:b5ec:d4db with SMTP id a4-20020a2eb544000000b00276b5ecd4dbmr7170297ljn.23.1671190243715;
        Fri, 16 Dec 2022 03:30:43 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q9-20020a2eb4a9000000b00279f3c58278sm130903ljm.51.2022.12.16.03.30.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 03:30:43 -0800 (PST)
Message-ID: <e7b95521-9a2d-7c0f-a379-b32d4aaf1031@linaro.org>
Date:   Fri, 16 Dec 2022 12:30:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] dt-bindings: iio: adc: max1238: Fix a typo in the
 description
Content-Language: en-US
To:     Fabio Estevam <festevam@denx.de>, jic23@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20221216004015.2902966-1-festevam@denx.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221216004015.2902966-1-festevam@denx.de>
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

On 16/12/2022 01:40, Fabio Estevam wrote:
> Fix a typo in the description, where "interface" is spelled incorrectly.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>  Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml
> index 50bcd72ac9d6..60d7b34e3286 100644
> --- a/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml

While fixing such, fix also max1363 in the same patch. Or maybe even
more files (but then usually split per maintainer).

Best regards,
Krzysztof

