Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A28B730627
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jun 2023 19:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237642AbjFNRi4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jun 2023 13:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237494AbjFNRiz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jun 2023 13:38:55 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344C01BCE
        for <linux-iio@vger.kernel.org>; Wed, 14 Jun 2023 10:38:52 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5169f614977so11746810a12.3
        for <linux-iio@vger.kernel.org>; Wed, 14 Jun 2023 10:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686764330; x=1689356330;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1RYu2iCbQcXep64qKrAtV4kz0X66L7+L4NssZgaqsN8=;
        b=rA0UWiUR/msjCVz6PB3wcJPHClCmuEi7z67ygf5j/FdKbMIEasIoj3zuMQMUeJOcNT
         XeBsp55cxo2mGRucHvDFaV648MbIJBwduKd98KFFBBxYpMatu9NpMAXD2K0QGknmGXvU
         rBAra9u5CzGUsPSpfrL59dz0LrvcY0NL1DI6c80ylI2Nv1ZipG6s1IRYLQl7YrF0psjZ
         BMMOSr4Eyc7E+jdEz7AHxAP8r9bvQxsdWdL2ECgloaeBeRK8QEtBoRQhDPIVDVqCllnn
         gjIFE+6KtuuB3ODtxMw/NWjDZ0v3gKAoU0tWJ/+9d0poayvmKzoFGLxNjGCqwg/Ue52O
         EyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686764330; x=1689356330;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1RYu2iCbQcXep64qKrAtV4kz0X66L7+L4NssZgaqsN8=;
        b=AXJ062OOFjyvcimbXzRKPlC8ckkbgoSouDBYs051VIPlGJCfd3xovHeYdWqOeL00ty
         zm3e+4zYKQ8d+/nnrQZbQknbD8+VrkvBjmZgLz5ArkCliZMiuYm5vunFkkBpJjUjux/E
         hUqHSu0E6RYoqq5IUpdX1B6/5BO1Jj+6bFG6QQsJUu0DeJhjFCg4YVSeNkS1OBc+bsQw
         3y8cTikAu0wePUQkEQnTIbU8K808gNMYF+gIuolBNnqvmQOOMMPzCXXeuOrdVm23qZmn
         B4ImZld+prPZTGVOjaiygMC1xe4ZeeNTdSE/lL52Js66cuvzw6gZ10Q5LppNW+qFmjHa
         JpbQ==
X-Gm-Message-State: AC+VfDwiVmOsARMuMcd5GJoTR4O1tSKP57S2O8gIs5nGOgLf3zwTtPoB
        H55Rr6YVlnICDxOZ29p9c5lNlCDc3OrFJyjpyok=
X-Google-Smtp-Source: ACHHUZ6P00V2TK9K/5IeFykjHz275i2jIyxJNsA7hSD7TGWTC7AGSpaWyQa+rkL2Ep9UzXTrz87o+Q==
X-Received: by 2002:aa7:d756:0:b0:51a:1ff9:750 with SMTP id a22-20020aa7d756000000b0051a1ff90750mr392972eds.1.1686764330729;
        Wed, 14 Jun 2023 10:38:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id c7-20020a056402120700b00514b99afa57sm7938813edw.44.2023.06.14.10.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 10:38:50 -0700 (PDT)
Message-ID: <695204de-601b-8e3f-d7f3-ac3bcd09e6e3@linaro.org>
Date:   Wed, 14 Jun 2023 19:38:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 2/3] dt-bindings: iio: adc: Add Allwinner
 D1/T113s/R329/T507 SoCs GPADC
Content-Language: en-US
To:     Maksim Kiselev <bigunclemax@gmail.com>, linux-iio@vger.kernel.org
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230614132644.699425-3-bigunclemax@gmail.com>
 <20230614145826.777870-1-bigunclemax@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230614145826.777870-1-bigunclemax@gmail.com>
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

On 14/06/2023 16:58, Maksim Kiselev wrote:
> Allwinner's D1/T113s/R329/T507 SoCs have a new general purpose ADC.
> This ADC is the same for all of this SoCs. The only difference is
> the number of available channels.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>

Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets.

Don't send the same patches twice. This is v6 or was v6 or is what?

Wait for feedback and send corrected patchset next day. If you tested
your patches before sending, which actually *is a requirement*, all mess
could be avoided. Sending same version twice is not a solution for
missing testing.

Best regards,
Krzysztof

