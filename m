Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300E7565029
	for <lists+linux-iio@lfdr.de>; Mon,  4 Jul 2022 11:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbiGDI7C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Jul 2022 04:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbiGDI7B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jul 2022 04:59:01 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000FA187
        for <linux-iio@vger.kernel.org>; Mon,  4 Jul 2022 01:58:59 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id c15so10311801ljr.0
        for <linux-iio@vger.kernel.org>; Mon, 04 Jul 2022 01:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=j25hUoGlKImkgG1pgAGAMILlS6va55fg2hr2/pxdDwU=;
        b=AWFR3QEUKpqEqy+KF2TsijHEbF07IfYxf1ZcKiu+Jv5zs6YLZtDmME1H0kE+SqTqPX
         N1rRSE0Nj/49RYRdslvtGl2Khx9gvH87hphlo2n2LjhHYKJvpKfosqoCXIKQGZv37wx9
         sT/9z8L2vo7E5505ZP0DQwC5dQWdHw4Aw6GC4ThnLRqxtyb1oj91MK35lHURPToqXoj4
         HvpgKc5sYYTNh3S8ds2Vm4+JRA2rbeWXqMo7fn7a9OW8Zu9hxRqHVngTfXXdSrmLmjET
         1vPWlBJiWtYGcUkwFZKTBW2yu1eAXr3rb91mgI6915sZ+KzdDaQERTvtey7pnL8IVbnW
         V1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j25hUoGlKImkgG1pgAGAMILlS6va55fg2hr2/pxdDwU=;
        b=F/McwJvlUfZqo/aZJFE4YjTvq+XDkKBLuhRJQuSKtv9WTSWEm858AcfEuOyTnSUp3M
         Y6JkwDRcjLa++CYGPFy/CEzSecEoy3eC2ys90X249Q+Fp+xhvQVQtwcBTt09m4/tnyjd
         /fFfiNtbo41aRfQ8msu0BwDMi7bbtR8dwcrRua1YLrWbX7DNniyenCikJghwYnS1bcPV
         gz3FynDRNnzqJE+RFPo3v6J8xKHAouCynoCHR4zll+/37mu38qe2gxkC0vodQTLZYR4a
         CGabMNG/Z5c8EOiDjZPrmjm77fQ2ZBN3uhA2Pm7DyT042i11vjVB/ZhgVZqUMXhemujF
         /lgg==
X-Gm-Message-State: AJIora/OSQnVEDdr4N198Vt2MC/nkfgRrpqPYMSeZydks987YBS+f21h
        Ewd/7y5prmxOT0iqaBzBfhJwaSZV2YYRRAzs
X-Google-Smtp-Source: AGRyM1tNdsatrSvvCBBMDRcuI/6xFeiYLpGQohB6hPhiptm/KCXN+H1+I9r9wPODJj75y4wTW9ciZA==
X-Received: by 2002:a05:651c:198d:b0:25b:c829:8b4d with SMTP id bx13-20020a05651c198d00b0025bc8298b4dmr15036326ljb.309.1656925138297;
        Mon, 04 Jul 2022 01:58:58 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id d6-20020a2e96c6000000b0025bdd6af056sm3231255ljj.45.2022.07.04.01.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 01:58:57 -0700 (PDT)
Message-ID: <ad00b52e-cead-920a-9b99-db4032cb6d0c@linaro.org>
Date:   Mon, 4 Jul 2022 10:58:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/5] dt-bindings: iio: pressure: bmp085: Add BMP380
 compatible string
Content-Language: en-US
To:     Angel Iglesias <ang.iglesiasg@gmail.com>, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220704002641.207169-1-ang.iglesiasg@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220704002641.207169-1-ang.iglesiasg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 04/07/2022 02:26, Angel Iglesias wrote:
> Add bosch,bmp380 compatible string for the new family of sensors.
> This family includes the BMP380, BMP384 and BMP388. The register map
> in this family changes substantially and introduces new features
> but core concepts and operations carryover from the previous iterations
> 
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
