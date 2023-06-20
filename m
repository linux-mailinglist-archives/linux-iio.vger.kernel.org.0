Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C149736D5E
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jun 2023 15:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjFTN36 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Jun 2023 09:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbjFTN3x (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Jun 2023 09:29:53 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5793C187
        for <linux-iio@vger.kernel.org>; Tue, 20 Jun 2023 06:29:52 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31122c346f4so5216085f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 20 Jun 2023 06:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687267791; x=1689859791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gWrMoQPOsfdbXahuo0wOAVZIQAu1IlrQkW9ZVz4aRA0=;
        b=glprJFDNQbXHT0agNC/POBD/5HM2VqnSceAfS7P3A+GNFxjOkUcs7S5r90SL+idNkq
         HoZJHsS4JP5YW674u0jp1idJ5SpXZI0GwD0EbFArunUFErYsO2k3JT91FaP04mhSUWMd
         ArOAFfVA7tX3Bq85ynqesYRH9Jc674CxRO6WxtF8r26Gkla+HyzbopzzhhnFqFg0tzqR
         W/wwCTYPsxfpgUC2lTJ48WHNnuO+g59oxKwf3yy37jx+BztGpdKaYtsX0gu9IlycgkUx
         X5nt1OOxJhI2wvXGjgtk5y6EwaMWRRw/hn8DZFytfvOSuds0POU6grHpjr8NiOSwA9nU
         b2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687267791; x=1689859791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gWrMoQPOsfdbXahuo0wOAVZIQAu1IlrQkW9ZVz4aRA0=;
        b=IVkRkiPb8+dwyKxuvOZgOmTcmPTY5U4B13fBkjN4+OTaiZV7nF5WBtcx4TKuVqX0aY
         EqgyhtDOmOYlBgMjtfI5mLdCJBuQf505JKhQAShWNrrO85BR4D6nr/EjV+KpE7VHyMvS
         YkMfCThtO49LNVbiO2Yc0qhxUOdBKtYcW8Wus4Hq/yV6yhoQ2OIm6gZDt80Nt2dk1fUC
         zqMhY7xxF9PTaeUHtwrkK22h8CaAo7C+2Lb1fdDaNPMcqdrwAZtzZKVQGcPtWdSRQZzk
         TPkq1BIF2xR47N73UL5RxAAKLsKT1EskaBuH0N7Dofd1p0dO6W1rmryW8W8yWad/GLFW
         Uz2Q==
X-Gm-Message-State: AC+VfDzNUDx3oPU1wYgXIcPnFc8jQ0I5/puVgzYjJ3JpEvKutdYDcYIB
        aiW7nRYXMQ7fNw2SnoLOCsMkpw==
X-Google-Smtp-Source: ACHHUZ5BrKxZy+zUHtFd9PrqBn9xqMrRAkTqMlRoZKdsCHfV0+f7w3W6uHfoVlYLQJoZrngZ+kXFRg==
X-Received: by 2002:a5d:4390:0:b0:311:1f6d:ddc5 with SMTP id i16-20020a5d4390000000b003111f6dddc5mr9727569wrq.24.1687267790790;
        Tue, 20 Jun 2023 06:29:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id z5-20020adfd0c5000000b0030796e103a1sm2068294wrh.5.2023.06.20.06.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 06:29:50 -0700 (PDT)
Message-ID: <027a0d86-704e-32e3-63eb-ee610daf194e@linaro.org>
Date:   Tue, 20 Jun 2023 15:29:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v7 1/2] dt-bindings: iio: adc: add max14001
Content-Language: en-US
To:     Kim Seer Paller <kimseer.paller@analog.com>
Cc:     jic23@kernel.org, lars@metafoo.de, lgirdwood@gmail.com,
        broonie@kernel.org, Michael.Hennerich@analog.com,
        andy.shevchenko@gmail.com, robh@kernel.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230620132641.256307-1-kimseer.paller@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230620132641.256307-1-kimseer.paller@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 20/06/2023 15:26, Kim Seer Paller wrote:
> The MAX14001 is a configurable, isolated 10-bit ADC for multi-range
> binary inputs.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
> V6 -> V7: No changes.

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However, there's no need to repost patches *only* to add the
tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.\


Best regards,
Krzysztof

