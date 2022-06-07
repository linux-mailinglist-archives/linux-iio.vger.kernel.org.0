Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451F2539E79
	for <lists+linux-iio@lfdr.de>; Wed,  1 Jun 2022 09:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242802AbiFAHhM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Jun 2022 03:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343859AbiFAHhK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Jun 2022 03:37:10 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919466418
        for <linux-iio@vger.kernel.org>; Wed,  1 Jun 2022 00:37:07 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h19so1017914edj.0
        for <linux-iio@vger.kernel.org>; Wed, 01 Jun 2022 00:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VGujkgTLGJjJ+UW8ObqRqsyAB4WEAUQn5faiR07jbVk=;
        b=eyS+I6FEnnSZ8vn2minglzX0RsZyoF9Qj5V8Mh43eR015TdUWXV4qkKWOZX2lZeySE
         t7BZBTp+ir4baIug9pll2zWzvszfRqc0r5vLzK1maxAcIdwZ/iaA1Isq4KwlmslVPRYh
         MIoVcBzLyZGyCFwXmKgLxcLRCyyiq88Xgxjiq3FFvEx5MmyZx+OASqZcPLHCKnw0JUjU
         7A2ayEZqWCb7MgWHsnp8p8rpoMQoKD4IyvQ73+Lcsl9Mj4iotCbbp0u3KSqjjZacai+Q
         /bXpn9G0c8CDLyqR79vDzIVBrNyJ35XAvFM05cJlklgGTzza55YihjFCrxtX/6ii/mNt
         whSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VGujkgTLGJjJ+UW8ObqRqsyAB4WEAUQn5faiR07jbVk=;
        b=zh57+us28XqLdYTAZisgW46/e3vSF4eOrZ67WnN5MfxaGgwQh6IOOsjO8K6yBTO8CB
         gzuy5xYNt+vviTnOLjw5IlD+DemMUk7UDKvncnoDGEk//oryt0xSiiFvX48sUTWZWIMO
         VyIsJ6cBDmRHiQ4e2qtyXPkCk3PnYlGuCshbp3McBdvpyxlAHVeuKIQw/Am5aqgd5MYT
         VFkcdyWZJUGWRVI6DjTmyWuXh5uT8Id/Rk+ePHM6xnizL8ojDND081fcfyDU9o7Wd7QL
         6hv3xcJNq3ca6ObSgdZKFH40HmtF0V61ZGzH5ROQwMgat3o22j54qcptgjxgDGxuRLed
         w+bw==
X-Gm-Message-State: AOAM531rztlwvFuV/RJ8gry68ynNE8SW2dGjV1PTMaofUfr79NcW7HcW
        GVe3rI55Pnvxfq9YCEOKnv+rWA==
X-Google-Smtp-Source: ABdhPJxcXWYO+A4vQR4Q7Xl2APBu8dwgsKRiYU4keddDiGzFAh3Q4PYTBvmzIZbnnxHwvAbJiIod1w==
X-Received: by 2002:a05:6402:48c:b0:42a:e585:103 with SMTP id k12-20020a056402048c00b0042ae5850103mr68634819edv.375.1654069026243;
        Wed, 01 Jun 2022 00:37:06 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id a22-20020aa7d916000000b0042dd4f9c464sm495356edr.84.2022.06.01.00.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 00:37:05 -0700 (PDT)
Message-ID: <dcb8c59e-243f-11c8-f10f-e037f9bd2e8f@linaro.org>
Date:   Wed, 1 Jun 2022 09:37:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RESEND 05/14] dt-bindings: backlight: Add Mediatek MT6370
 backlight binding
Content-Language: en-US
To:     ChiaEn Wu <peterwu.pub@gmail.com>, lee.jones@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de
Cc:     cy_huang@richtek.com, alice_chen@richtek.com,
        chiaen_wu@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
References: <20220531111900.19422-1-peterwu.pub@gmail.com>
 <20220531111900.19422-6-peterwu.pub@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531111900.19422-6-peterwu.pub@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 31/05/2022 13:18, ChiaEn Wu wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add mt6370 backlight binding documentation.

Please apply my previous comments.


Best regards,
Krzysztof
