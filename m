Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A045F542E44
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jun 2022 12:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237522AbiFHKtA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Jun 2022 06:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236716AbiFHKs7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jun 2022 06:48:59 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29D11C4B2C
        for <linux-iio@vger.kernel.org>; Wed,  8 Jun 2022 03:48:57 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x5so21419846edi.2
        for <linux-iio@vger.kernel.org>; Wed, 08 Jun 2022 03:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aUu+de0g86KF16rpJt3I15wAYwxHXppsK/rhqPeo1Q0=;
        b=uaTceCdNGPnJo2LlPeOrg/JbnK2kXDBdeVy/uvKMknDrnjVMO3m0sBeb9QgQSPsifq
         admE8n+5uE5XIPOj0tDvoPDYR1a2GScJDDB9zoRJCsaNSrP3FZRePa7ubOxMNHw0szsi
         7nNeAj4lOtMWJWKk3yYoAY4ghC/a70g07XuBWRTwdKRHXWeLBA3mJFziYPudahTsgvXM
         Z7/X/4e9osmX6nDOTRL9EyPRHVa9owJuioFihlIH7Qi11osxtgtXnYf/R1eSfDIYVyWS
         OiqCUXpuUvpo9O6b5IJSgP2/LXp3WP3a2aJYCzPY0mLChsAKuxZc7pe/8pJZ9K9tc0XF
         0taw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aUu+de0g86KF16rpJt3I15wAYwxHXppsK/rhqPeo1Q0=;
        b=0hd5DKEcir/tLLEuj0jTDCbP4qJqMmKHoC0GBb7fRjbxmgVdoepCLsvPIfBIdZ8CXn
         20IATWE00nnCNkPv3/yzY3JsSV7diuc61fK6pj8YfNok2Lp9M8hLsxbBx3jhnULJQd7I
         c01vaDEs4YRNAeZ9NYuWnw4lCR/6PPCY8JWLxjqEWi3s5irZ562Kf1qg+O8VvbBeOwD6
         CyLPGGkRhkPTRpCuuOHbVjINyD1cJ0J0e2i72e65bU4A7S0xxrjxFb89bip+Q9Np4KsI
         RwanvbubST3li7EDeBs2TEY48ZO2lh6sNCrRpC1RtVh+g62ZdYQyd5BgzXi1DpBQy+PA
         +m5Q==
X-Gm-Message-State: AOAM530t0XtLwqVqs4XBBwRLCMTbR3IeCi+XosUCge5Tifp5KizOoSHe
        hqisqReiFUxZJXRglMjhpxvGMw==
X-Google-Smtp-Source: ABdhPJwdqTV1pWBZhjN2YI/U/7nc8D2TetBbktJD9lEYEYnMLwMaBrM2nINP/KaaH/nRoR6xz3acOg==
X-Received: by 2002:a05:6402:1713:b0:42d:cb5e:d799 with SMTP id y19-20020a056402171300b0042dcb5ed799mr38264426edu.34.1654685336296;
        Wed, 08 Jun 2022 03:48:56 -0700 (PDT)
Received: from [192.168.0.191] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id rn13-20020a170906d92d00b006f3ef214df2sm8860508ejb.88.2022.06.08.03.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 03:48:55 -0700 (PDT)
Message-ID: <d5465a36-f18a-ff48-b13e-e5f9c48a398a@linaro.org>
Date:   Wed, 8 Jun 2022 12:48:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 03/17] dt-bindings: mfd: add bindings for AXP192 MFD
 device
Content-Language: en-US
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, quic_gurus@quicinc.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
 <20220607155324.118102-4-aidanmacdonald.0x0@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220607155324.118102-4-aidanmacdonald.0x0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 07/06/2022 17:53, Aidan MacDonald wrote:
> The AXP192 is another X-Powers PMIC similar to the existing ones.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 1 +

You got here ack, didn't you? Why sending without it?

https://elixir.bootlin.com/linux/v5.19-rc1/source/Documentation/process/submitting-patches.rst#L536


Best regards,
Krzysztof
