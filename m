Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA5450CD11
	for <lists+linux-iio@lfdr.de>; Sat, 23 Apr 2022 20:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236820AbiDWTA2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Apr 2022 15:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236807AbiDWTA0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 23 Apr 2022 15:00:26 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DED2C113
        for <linux-iio@vger.kernel.org>; Sat, 23 Apr 2022 11:57:29 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id k23so22285987ejd.3
        for <linux-iio@vger.kernel.org>; Sat, 23 Apr 2022 11:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0/I1Lqd6FAD3duZ+xmmPKJycik6MTwR4HUFPeaOkIwM=;
        b=QshAl1jLuzly+O5WdWGcR6Djz8uNukbP8CvWoJ1UxBL7toCaSYk0xjT2Ud9s75+5DG
         7P6s9BkMLHlTFRPHXBulJHi4AdSLusk8bDg9kZzrCOuzZuwbrN+Mjm3W7GH3u4qK3bMV
         l9OJ0kQeDuyMFzEtY68sgmTFMKCFzGJSprN7j7UZ3i++gxxgPkbGhuXTS9RxZ7ib2dQp
         6w5J98a2xXAjheiwqD0tZvyNflOZ7YCX/zHuGNlATwhpfGukPHC4vZ2DgXlVVGIIMqUE
         wlNvKEvKe7GahYnij7PALc0D69eIgWPog/5TcmDM1A2FFaJ2hX8XsKSNhKtGHfGJ8BEp
         pUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0/I1Lqd6FAD3duZ+xmmPKJycik6MTwR4HUFPeaOkIwM=;
        b=zQnkNWAdTNfZpYE2dCnVe4mltzxVZt2wB+drqFTM8/eARJmJ0q3UpTRuUgc5XnrPtW
         aPQL+IWu/98zgHN6pg9W9bMZOJ+hgMJ488tbdKtbUfbQYV+nNC8epzlkij6H9HjNaJwY
         /6xVQZGnbD9nuQr9CCJWyVbJpPGPGoxdKPGa4k/HLSP3R6G4w9PrzGNs7/0IWz7U+ECw
         PhgbeqtkvKmulkndMu4gJvnP0U84NV+TXmDM/BajncK6fPbJOy7tgpG58YvPxcp+Ujju
         Bw5gwQLH6WFfV4BP6rkpvH2YKGgJObguNBBzKe5C48gvWKkKQoRxEBOpstcFop5PPkvt
         fknA==
X-Gm-Message-State: AOAM532NrIZc7K8QPfguMAUXLtDtNn+5D7YIRlhswaTcoCMDCdgs4+wD
        VFT0Xc1vNZobiC+Y1Bb3uHjjfw==
X-Google-Smtp-Source: ABdhPJxv2VSufWS3KnWj8fOA1UatMkaO4h6P6PeGuzoylZ/Rnpo+u6tOONQ76ewNinXUigLhzSODiQ==
X-Received: by 2002:a17:907:1b09:b0:6d8:faa8:4a06 with SMTP id mp9-20020a1709071b0900b006d8faa84a06mr9303922ejc.701.1650740247702;
        Sat, 23 Apr 2022 11:57:27 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l6-20020aa7d946000000b00420bd71e06bsm2481959eds.79.2022.04.23.11.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 11:57:27 -0700 (PDT)
Message-ID: <164bbdf7-e74d-7f30-6657-6c80d2f91a97@linaro.org>
Date:   Sat, 23 Apr 2022 20:57:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: iio: adc: Document Renesas RZ/V2L ADC
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
References: <20220423131654.131390-1-biju.das.jz@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220423131654.131390-1-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 23/04/2022 15:16, Biju Das wrote:
> Document renesas RZ/V2L ADC bindings. RZ/V2L ADC is identical to RZ/G2L
> with same number of channels.
> 
> While at it remove RZ/G2LC SoC from binding documentation as it does not
> support ADC.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
