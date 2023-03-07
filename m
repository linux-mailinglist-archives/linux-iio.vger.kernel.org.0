Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0400D6AD92A
	for <lists+linux-iio@lfdr.de>; Tue,  7 Mar 2023 09:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjCGIWN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Mar 2023 03:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjCGIVv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Mar 2023 03:21:51 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C3852F5A
        for <linux-iio@vger.kernel.org>; Tue,  7 Mar 2023 00:21:34 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id da10so49098401edb.3
        for <linux-iio@vger.kernel.org>; Tue, 07 Mar 2023 00:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678177293;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wYZSGOL1Ow+nU2BHp0S6DvwtM6Br5RJflXI+aGJp8DI=;
        b=nIpfykpjdzp7eHd3xcBCadvRWTdNewlsBPqYaR1gE/qXErxk3gTT+7db6GyL+OZ1tX
         VZy7pTReKEbW516DviDgp/3ai4rCkzWK2b5RpvslsvLJ3jbIsNsk2tHDxU4NNyCeng9M
         yp+bXl0amE1joK1vkbEAp1/63ALBN8eZ60DueSLhz4QamOe0NWczEZplLtFbNzqgEEqs
         ObqGf78xb3cVAkAwLeCP8HJ7qzfFfF4WkvXeRG5g9RlJj63ick/EV/whvuxH7QU/tZTT
         G1wWWZLv8+B/sCMYYltmvIs3g6Gfu7wZoGOuJLfDiIq/u1fCZNYob4L1TOl/iLcIEQaZ
         QbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678177293;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wYZSGOL1Ow+nU2BHp0S6DvwtM6Br5RJflXI+aGJp8DI=;
        b=tHzCm70fVMO6VV0iREIEKWwAZ2xdR1svw+6RTi1Qjf564+Y5U9uSr3Gv08L4Z1mm1E
         Vh0+VHdsIvNonr2Aqu01Ri4hRZoktlj7A2awg5bkrHsAPPDy69tnprLrurRjZze4iIXv
         wJSXTfR4WdLeJc2Yn7mNADIO3CBaAQbPgBQhrw+Agh7a/RMgsbkwKcZl5jMSyaNKYl8Q
         qP7dlh2wjZIF9QYiFa5z7V5FKPeAd8PRL+aJgibFuWX0JAzy71f7ajC6sMFbyHKm7zt1
         7EL7dGGAG7v51Vv1uzsBG0pLrXPxheCNS5F2Aoqft3F00rkvxFOuHiquMOWmnkorZD4V
         iobA==
X-Gm-Message-State: AO0yUKUTGfhuwN/vZ8RZrHvuEsAru8gsLlRbNecAC7phbVF5hb3ZP1+u
        VqWLZNPIVNT0+9wWyEzKGMT3ng==
X-Google-Smtp-Source: AK7set/RllsDUnQJiE9pBV+kNYTNsrpeLeY7SGr0sAut9Djjfj0rOuaN+/iBn/YZCJAGCsThxCxhTQ==
X-Received: by 2002:a17:906:794e:b0:8df:e176:4837 with SMTP id l14-20020a170906794e00b008dfe1764837mr16460726ejo.19.1678177292824;
        Tue, 07 Mar 2023 00:21:32 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:5310:35c7:6f9e:2cd3? ([2a02:810d:15c0:828:5310:35c7:6f9e:2cd3])
        by smtp.gmail.com with ESMTPSA id de19-20020a1709069bd300b008ec4333fd65sm5697210ejc.188.2023.03.07.00.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 00:21:32 -0800 (PST)
Message-ID: <88761a86-a115-c676-bb32-f76cdd61f9f3@linaro.org>
Date:   Tue, 7 Mar 2023 09:21:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/8] dt-bindings: vendor-prefixes: add chargebyte
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
        Stefan Wahren <stefan.wahren@chargebyte.com>
References: <20230306172249.74003-1-stefan.wahren@i2se.com>
 <20230306172249.74003-2-stefan.wahren@i2se.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230306172249.74003-2-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 06/03/2023 18:22, Stefan Wahren wrote:
> From: Stefan Wahren <stefan.wahren@chargebyte.com>
> 
> chargebyte supplies hardware and software products for all
> aspects of charging communication.
> https://chargebyte.com/
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@chargebyte.com>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

