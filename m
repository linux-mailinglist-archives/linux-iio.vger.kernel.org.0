Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704226AD92B
	for <lists+linux-iio@lfdr.de>; Tue,  7 Mar 2023 09:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjCGIWP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Mar 2023 03:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjCGIWB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Mar 2023 03:22:01 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198E6E041
        for <linux-iio@vger.kernel.org>; Tue,  7 Mar 2023 00:21:51 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id k10so25118241edk.13
        for <linux-iio@vger.kernel.org>; Tue, 07 Mar 2023 00:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678177309;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=51J152pj392A2NnLtlE2jtA0bt6EHZvfk9Vi21ByDWk=;
        b=jlCbbh/RfcHZ5kCuqH8fEEas8BEwpuAbS6yIKE0tgoJzqe7C0mmGtMVqBatBxhLw4h
         LF8tRQ+YvtszCLJA8q1AXT6q5Zr1GAJntyb6zHR4JPBgXnTgdLFgDGVia7Xu7dNOj9tG
         kuIsQw+qdXujiISN0h8F6onN0JdUzuhYNpeq+YXg8G6L4Ek/wxFumAeviuf/iefia+kL
         NlVlWxDbLkFWhZcw3SSa4gi5FAzw7qbjP3g7a3CBC5wPuAIab2KyejJSqUzDOcNuhO2F
         DHI6GkUuKtFNKiwaI5UvW+VJprdw4E2RhLAELlRhWLjIybosQnHgDD5GzV1CX8/1HF5z
         uJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678177309;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=51J152pj392A2NnLtlE2jtA0bt6EHZvfk9Vi21ByDWk=;
        b=J6ktbVwni3sldh86WTXtcHWAgc3ncApz99ENbbENnm2T+wRL3PS7hr/8Au2WvbUPor
         qoiwgtZzu/miXNeSsWZw6RQQ4jUxz0q8yTc7txHItGucgRhN9Hr8FMSo4PXK/habHDPu
         8/XzKypRvzIKOGXJUSUuiKEFAjvaKsUFXHh0G6/x4snae85edgqdv1MA70rvTkWLhV86
         0B+7HjiA7QgnGHrq2hpg+AOpFzX6lOEdVR5+xFl30fvVWX6vHWm7em7iMiirdXpzHeYu
         4o7CXW7vXRgR4VMGu3oniR3eE7e2xpdUmZYLizci2rbck9U3qE7Rnd9FlsTXUWhYu07k
         +oEw==
X-Gm-Message-State: AO0yUKVQ6CSdrNbIkl27Rbjm0g6omBAxJA/Lhe1oLVl0xo6uroO5leuV
        g6aF0ckSzNyrZtN2FyWfmUC2PA==
X-Google-Smtp-Source: AK7set/wYEgj+FKri+Qrl5oXX8zSnSlYPjM7x3/Bnf8PhufCbetefH+6e/OMuUMBHks246EiNyvDmQ==
X-Received: by 2002:a17:906:4783:b0:8af:2107:6ce5 with SMTP id cw3-20020a170906478300b008af21076ce5mr18042086ejc.35.1678177309629;
        Tue, 07 Mar 2023 00:21:49 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:5310:35c7:6f9e:2cd3? ([2a02:810d:15c0:828:5310:35c7:6f9e:2cd3])
        by smtp.gmail.com with ESMTPSA id 20-20020a170906301400b008cf1b61a73esm5708654ejz.41.2023.03.07.00.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 00:21:49 -0800 (PST)
Message-ID: <6567c9ac-7208-9262-39c4-2e728207b34c@linaro.org>
Date:   Tue, 7 Mar 2023 09:21:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/8] dt-bindings: Add DS2482/DS2484 as trivial device
Content-Language: en-US
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     linux-imx@nxp.com, Li Yang <leoyang.li@nxp.com>,
        Denis Ciocca <denis.ciocca@st.com>, soc@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>
References: <20230306172249.74003-1-stefan.wahren@i2se.com>
 <20230306172249.74003-3-stefan.wahren@i2se.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230306172249.74003-3-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 06/03/2023 18:22, Stefan Wahren wrote:
> From: Stefan Wahren <stefan.wahren@chargebyte.com>
> 
> Both chips are I2C to 1-wire bridges.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@chargebyte.com>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

