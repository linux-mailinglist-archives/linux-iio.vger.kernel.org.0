Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227DD5B701A
	for <lists+linux-iio@lfdr.de>; Tue, 13 Sep 2022 16:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbiIMOUL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Sep 2022 10:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbiIMOSr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Sep 2022 10:18:47 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6058858532
        for <linux-iio@vger.kernel.org>; Tue, 13 Sep 2022 07:13:19 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id cc5so11174932wrb.6
        for <linux-iio@vger.kernel.org>; Tue, 13 Sep 2022 07:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=f8mVUn2wwNCGPRMZ2XsvYI4BbV6MhvOhbxNGkhdi3go=;
        b=QkzPoDiabtql8w6yf7MIc+Tgvnel8YtL3RRru1HbHPEshfyg2bxczuX6I8/MwhxD8z
         p4Hbtju3t2VPBq9aGB7uLUs7MwTqrF8yhmv/Ka6hpOPmt1cngUAUa7qzFrF4smjsv1KP
         XJi8AOB8eaVOo4uwc1VGXmA0/2w9Ri9MgxIyziivytGT/TX/8rqbjjUSS0jvqF5RPVON
         kydSWLts7rFgNlfK+gZE4QT5HFnHdtw1aA2MWaJWGW5TS8P0p/wHZjkDWFJGvCHQDWOs
         XGkYJbVELmahb4v4SzRb0BEEK+VPIIHmF8xmZTu4gwZbSoJy4nlO8MEd+ylO158wnefw
         FZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=f8mVUn2wwNCGPRMZ2XsvYI4BbV6MhvOhbxNGkhdi3go=;
        b=orYA+WgzcnA4c1HiCGQok6MTa/Vcu5m6zWFBCdfkodMRW/Fbr4ScPHS7jRfKgo4VNM
         xZoqPpI5q0y9MB7S6+j/ASf5kE0DrpogXoHdt6Ooau7QcU49eO6/z6tMMb2/cYafj78d
         Tz31upLVk3WBTY81YTBw5MCp8CkjF/nciOKUESF8ZBvwURenDLbGjBeZRdBcf4zV/sz5
         qEYi6GMUUjkbkGs5adqThkj5CB+sCxIKRV6gmexfFxZ28EH7XjP8LJpfy43xRkVJFiFI
         vQracMmvpR0ji9ukui+0fs10phuBOD2OnT+drI1edbA5wP5iScLctVlWMO7X2YrtCoRm
         biSA==
X-Gm-Message-State: ACgBeo1vYRqpHpdDo3x85680lssB3J7EIiy4KXnrNwf7UWkVsDElIV79
        oxShDkG4UJEtr9ofPB8mqrj1rg==
X-Google-Smtp-Source: AA6agR4BMuYOdCxjf5vGV2V6DVRRukCSfLoJIqJ+7a5ibjgKP/rLyiA04B0nG1C26VVkJlgYPiEMJA==
X-Received: by 2002:a5d:65ce:0:b0:228:d8b6:d1 with SMTP id e14-20020a5d65ce000000b00228d8b600d1mr18294086wrw.486.1663078324009;
        Tue, 13 Sep 2022 07:12:04 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.67])
        by smtp.gmail.com with ESMTPSA id l7-20020a05600c4f0700b003a845fa1edfsm2950760wmq.3.2022.09.13.07.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 07:12:03 -0700 (PDT)
Message-ID: <bb42680b-ce02-bfd3-1d47-2264a142bd11@linaro.org>
Date:   Tue, 13 Sep 2022 16:12:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: adi,ad7923: add adi,range-double
 property
Content-Language: en-US
To:     =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
References: <20220912081223.173584-1-nuno.sa@analog.com>
 <20220912081223.173584-4-nuno.sa@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220912081223.173584-4-nuno.sa@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/09/2022 10:12, Nuno Sá wrote:
> Document the new property to enable doubling the analog input range.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
