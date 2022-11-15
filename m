Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60213629D3A
	for <lists+linux-iio@lfdr.de>; Tue, 15 Nov 2022 16:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbiKOPVS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Nov 2022 10:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiKOPVR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Nov 2022 10:21:17 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8512D76B
        for <linux-iio@vger.kernel.org>; Tue, 15 Nov 2022 07:21:16 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b3so24937822lfv.2
        for <linux-iio@vger.kernel.org>; Tue, 15 Nov 2022 07:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S4Kyix6VzkFvRyIQCFUwtQHCaGHyEVeO8PCpC08GuJA=;
        b=AvNzkC6pcowZYTqPeIFqzSyaBCfPTLfgOa9RVXUL9cRwKaATrLI5puoSaPedPvXAxU
         nvJv8GTNtLix5522lh14uBbWcOSg1HfGMvYLs2tGpe5ixhbrsbPM3EtR0p8Vx24bdoxt
         gGA3au0mVQTsqxa5Yif5M57CJ+XaN92MnCW9spqQ0sZQ6P6fdofnZYgEH0+frMO3RG5W
         4Z4t7tTjuDyy/uTBIjKFyWwZYc/C4nDxbKcky0M1cPUcjqw6/pICIdKqZ+lJfRkoBNIu
         9/Hdi7I5C7/0iRkZRMOMvwVemlXThJgqeAK4U2E0Y1SjZJFIxyacljKMIj3gK4igJJbN
         8kLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S4Kyix6VzkFvRyIQCFUwtQHCaGHyEVeO8PCpC08GuJA=;
        b=jZyR1MKb1P6YCtdt+4zCxsXVrHBrfsNjGMq2xO77h5HuVO9+L3vQJKaGCD4JUyiCCW
         7P1osNNyzQtpg1Y2zG3k/IwhwZyqxXj3zQT882yual5A4+Pb/59n4TxMQpFKqN8UNo8G
         AseyuR3fZue1qeIDxcDP/hGho4iCQWbS7C44PAhL9/uA2WUTvNZGveo7rsQzLgNriois
         IgWKMqO8HEbT6IJ1y22acbOHomTvrxixIhfUfV23zEwuLezqAx6FLDGnJ7Ud7HeeJoEd
         zl9qZ7cTkgXxx2s850H9zuFC1ygJCqfSBujvTHLb5R8WSfnFiEtNDI6AmdnRPvkbsBls
         RYew==
X-Gm-Message-State: ANoB5pm7MZoHFLoRO1Ji6Red72ompHEQhl6CqOFHtbwNgO/ZvwK6MMxz
        FizAI5mnmnHkYin6S6Lez4KC+w==
X-Google-Smtp-Source: AA0mqf42oblNogUnnigwUBoyTotPMjLxWgkATJpyJ9QCvMBQTWRtQytsXmOLJFeAljZYuggyOKYv/w==
X-Received: by 2002:ac2:5314:0:b0:4b1:8fbb:d3f4 with SMTP id c20-20020ac25314000000b004b18fbbd3f4mr6151298lfh.70.1668525674880;
        Tue, 15 Nov 2022 07:21:14 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id l16-20020ac24310000000b004947f8b6266sm2239867lfh.203.2022.11.15.07.21.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 07:21:14 -0800 (PST)
Message-ID: <20aab566-081f-962f-2966-1011b337edf6@linaro.org>
Date:   Tue, 15 Nov 2022 16:21:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: iio: temperature: ltc2983: drop $ref for
 -nanoamp properties
Content-Language: en-US
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
References: <20221115151653.393559-1-cosmin.tanislav@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221115151653.393559-1-cosmin.tanislav@analog.com>
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

On 15/11/2022 16:16, Cosmin Tanislav wrote:
> Currently there are -nanoamp properties both with and without a $ref.
> dt-schema has been modified to handle it as a standard unit, but the
> change has been reverted since there were still occurrences of
> -nanoamp properties with a $ref.
> Remove this since it's the only occurrence left.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

