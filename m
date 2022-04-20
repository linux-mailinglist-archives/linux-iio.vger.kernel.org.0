Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BFB50819A
	for <lists+linux-iio@lfdr.de>; Wed, 20 Apr 2022 09:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359565AbiDTHEm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Apr 2022 03:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359558AbiDTHEl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Apr 2022 03:04:41 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80973393ED
        for <linux-iio@vger.kernel.org>; Wed, 20 Apr 2022 00:01:54 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 11so1093876edw.0
        for <linux-iio@vger.kernel.org>; Wed, 20 Apr 2022 00:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vInl9004STM9Qc4GuUVzX4qiXWW3h7h2HnUzvjdfxGo=;
        b=Cx7H0w1rHIVWWV87FpjZIBC7zWWFfWL5ayzosxmUORzUYEsKs2HyjLZpAwHpxXbPVt
         1k+ezKRF8LMhPErYYct0eS5Q+lMTpuh+ij/Ph8NwMjWn0nDiM1HNJC2d6H7bo8g3EtoH
         0pqD/f34MRM/KXK26IAkFnK5gnd9Uev2jqqYZDUD7c/N4m5r39n9HFZDbzEGOTedYaGO
         7tmXw4IZSjv61qEG2uZRtCVOKkRBxT77sJnAdezFe4+x/fXqec2PZPcQneW5yh65POQF
         JogLaLCddcs9QWeOwzu/FOaTms3Y2PnFw3AhVE/pMlRlOHkkcyq1Q6PWfAs8iSUpf+8H
         tBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vInl9004STM9Qc4GuUVzX4qiXWW3h7h2HnUzvjdfxGo=;
        b=BEsAts+Y+A6/9J0S4TiYFqZ4apjg9seDk9ZtCfzqUv/6MNxiAceQAv46Rg1lyLfHTN
         5eGa5pmGwmFVtxC8h4fqhQnImro8xHXPKTGOGD45I8+nJNMxxz/LG6ihCGW9z8FrmZs4
         f6qcRE/KADcDMC8ECW8lvXcBXecildiLCxJqiZ+KEnvFm6/4t2ty1wdv2Syp09bpcuXH
         122zGaGZwAoRGCdCbZUNbyOXrRvu1TbDuMZjf4fyH2NNKHLxSgMia5y/90jiTeyaGoVI
         f2JTg/46X6W3ITZHAWMjNUmPim+UVzwNYS3m8lUDTY9aQtU88YnMp3v2uUSTe8ruc+92
         O4vg==
X-Gm-Message-State: AOAM532YDMIQ+khvGr5AAEBWKcmxfN0Hdu+vAU62vpK9js8seLXQj+WF
        uqMtbJ4t/BNCTsyDxRkEO0qDeA==
X-Google-Smtp-Source: ABdhPJwSR/mPuUew41KvfvuBvQbHplgf8CToiutxAC1Tj31EbhLeKK9y5rGPRgxlD9EMLyMQRpIVTg==
X-Received: by 2002:a50:d78e:0:b0:416:2cd7:7ac5 with SMTP id w14-20020a50d78e000000b004162cd77ac5mr21424773edi.320.1650438113049;
        Wed, 20 Apr 2022 00:01:53 -0700 (PDT)
Received: from [192.168.0.222] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i41-20020a0564020f2900b004204c9911a6sm9495302eda.10.2022.04.20.00.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 00:01:52 -0700 (PDT)
Message-ID: <2bcf42e0-c58e-99f7-b667-8c212022ff19@linaro.org>
Date:   Wed, 20 Apr 2022 09:01:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V4 1/7] dt-bindings:iio:adc: add sprd,ump9620-adc
 dt-binding
Content-Language: en-US
To:     Cixi Geng <gengcixi@gmail.com>, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        yuming.zhu1@unisoc.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220419142458.884933-1-gengcixi@gmail.com>
 <20220419142458.884933-2-gengcixi@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220419142458.884933-2-gengcixi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 19/04/2022 16:24, Cixi Geng wrote:
> -  nvmem-cell-names:
> -    items:
> -      - const: big_scale_calib
> -      - const: small_scale_calib
> +  nvmem-cell-names: true
> +> +if:

Better to include it under "allOf:" so next time you need more of such
if-then, you do not need to change indentation. But anyway looks good:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

> +  not:
> +    properties:
> +      compatible:



Best regards,
Krzysztof
