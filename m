Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17D472F4DE
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jun 2023 08:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243201AbjFNGbv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jun 2023 02:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243215AbjFNGbP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jun 2023 02:31:15 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9632B1BF5
        for <linux-iio@vger.kernel.org>; Tue, 13 Jun 2023 23:30:40 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5186c90e3bbso3228145a12.3
        for <linux-iio@vger.kernel.org>; Tue, 13 Jun 2023 23:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686724239; x=1689316239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cc+dxPpu8lXsZsADd1XaSw2JFjXzN4blFEsEKZHFTD8=;
        b=qfeOtFUYHy+0ttTJcytVR9sVTi76yBJKYGUruFsPsclOXYncFnmR2a+KZ5QFJ7u0MG
         O+uPjlQFFZud5PzW7DMkZD8zUwzmgzz1afhTunc8ERcoyzy82KvTJnaPoKv/t39Cn2Rs
         glUcWe5jY/Obo8sSaRX0dFxf09OWOpAnfK/9IJUDHA2huuaScEpevMSQ5WMoNpPMu9kw
         fHd1LXYv434YjhEjoVwvB+j1PKds323PDP+4w1Wj/uFSEFGBpPgXie/pYfKEhPNr3DtK
         AUgbArtKo7c9bt9bHk7ac+OsRv2KV1qPKY/UuJ2UCg1MiqEVxRAPeLkypVQvJzTc8eZF
         tdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686724239; x=1689316239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cc+dxPpu8lXsZsADd1XaSw2JFjXzN4blFEsEKZHFTD8=;
        b=CSs8pT/wG8FFKRB7PTns0G/nCXqNjQBDJCORm5daziQVyH2xp+3G3n3QN/3/0IS6pF
         T9HQtb6cgs/6bXa1/mnU2phssYNW01gLSG1Wu/YmOvT7etODJ/go+ZvmJb2UTarI9RGj
         VA81cBSO2S1g/UJDaaRJmxqKZF3ZATetks4ch47uMt2gZU2QxK38CMlt/Ks0EmfvmNDf
         vfnhevvlOumCnNq1zln6Y7gV6IJlXQCr5tHikdVDqwIZxJUqVuNC55WlbPlA/LUm/+Y+
         IfG5Jv4IzhMrff/0bOEVmk82MhU6caJX7PD/WwQQUoxiZ7zq2eGbFJ8zMigk0yjQqt+7
         DKVw==
X-Gm-Message-State: AC+VfDwxy7E748UQEhjNfVQ6V+7TFbbkqNbU5PCUKlcZ6P/8Md5pX445
        Yph1vKUKj43jYqTMg4sNs5P7EQ==
X-Google-Smtp-Source: ACHHUZ5abd/2cZWoy7USVlJWZb32cnqcjXZa76XE9hHfo1LyM0+k06asglp308N0ZQs34+NNItEODA==
X-Received: by 2002:a50:fb94:0:b0:509:c6e6:c002 with SMTP id e20-20020a50fb94000000b00509c6e6c002mr7851333edq.39.1686724239059;
        Tue, 13 Jun 2023 23:30:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id n12-20020a05640204cc00b0051631518aabsm7211825edw.93.2023.06.13.23.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 23:30:38 -0700 (PDT)
Message-ID: <46458a14-28f3-5279-f5ad-302e6edebaa5@linaro.org>
Date:   Wed, 14 Jun 2023 08:30:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: adc: add max14001
To:     Kim Seer Paller <kimseer.paller@analog.com>
Cc:     jic23@kernel.org, lars@metafoo.de, lgirdwood@gmail.com,
        broonie@kernel.org, Michael.Hennerich@analog.com,
        andy.shevchenko@gmail.com, robh@kernel.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230614004857.134980-1-kimseer.paller@analog.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230614004857.134980-1-kimseer.paller@analog.com>
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

On 14/06/2023 02:48, Kim Seer Paller wrote:
> The MAX14001 is a configurable, isolated 10-bit ADC for multi-range
> binary inputs.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
> V5 -> V6: Removed tags.

Not the review one tag! Drop the fake reports because there was not
report and nothing to close.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

