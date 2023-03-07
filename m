Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220756AD936
	for <lists+linux-iio@lfdr.de>; Tue,  7 Mar 2023 09:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjCGIY6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Mar 2023 03:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjCGIYv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Mar 2023 03:24:51 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A8D367E2
        for <linux-iio@vger.kernel.org>; Tue,  7 Mar 2023 00:24:49 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id k10so25143828edk.13
        for <linux-iio@vger.kernel.org>; Tue, 07 Mar 2023 00:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678177488;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rL7uQh2yYt9Beo5cGiECsHdkiRYSMQ01ywXozqX7Dqs=;
        b=iSg4FJf2gXdHTbpFn98438u4qqSm0mboGo665MRpl39yJF39kN/7SKnjjTTD1FCsNj
         KEjGEr9YbybDgbimeWQcy2nGBQmSFFPFvcfoQ9OQmIAZ2toHZeDifV+5+zPgavTeZsp9
         k+rJGH+MUWjve3QJL9E/lo8QLmQLt11recRIQcsUNEk6qZK9hu2Ajhk6uCNI5f5WkyVY
         4hxMY0rpfU2Q2TwWNkrgCEIZ4zKsKs7bLc6q8mNoLayo/NvUV0O65KLWzX34f1+FaGLf
         6CLOd1TI4UdZJ2zJQiV/U9E8O6wcf4QoGOmciYvbWp5GmuJ75TcyZPgFEkWFUO+aSqQ2
         adQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678177488;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rL7uQh2yYt9Beo5cGiECsHdkiRYSMQ01ywXozqX7Dqs=;
        b=fsa1n8z+b8oDiu0frLLzwyh6AH04W34M9cNwcSRsNlrPpGz4GGV5Sha0HQ92mUUWFL
         KF29yXUQV/QNLUqvSo6+/VRj2kezLS6+x7dZzHQIbwX2bY66NNZbjC4uxJ8Re7OYdQ6v
         NKfOPTQAnmHEd93RgtrWkgoaPLAFFYlun1iJzfMCyyWszE/r0DraRnilFQ/CC7OSzOv/
         61N+27h8xy88hc6GuqJFVcuPpHjCL0WXO8MdsAmexFl5jYxrcFxwPSpeJVeuS/aHdaKR
         xYvD9BSUhbVOObUdcUc4g4JpkAxsggHP4ZGUt6K7YlBTIboaAvuoeJU4qkx2AxunfoOX
         dJMw==
X-Gm-Message-State: AO0yUKVmqDQJ8OFlHaEaiobEdDHfLjWL9UJC47q/Bv65afR0S/d4jRJ4
        aLT2B5BLsfyftItJC7ahW0Gh7g==
X-Google-Smtp-Source: AK7set/gOUURaBdlvFm53mkoLZVFYbdfFPlBwgfsbmlF+/S/jSajVUJQFygY5FWaSivS0HSwK5ZRaw==
X-Received: by 2002:aa7:cf04:0:b0:4ac:bb85:c895 with SMTP id a4-20020aa7cf04000000b004acbb85c895mr12580363edy.1.1678177488199;
        Tue, 07 Mar 2023 00:24:48 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:5310:35c7:6f9e:2cd3? ([2a02:810d:15c0:828:5310:35c7:6f9e:2cd3])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090643c700b008caaae1f1e1sm5666593ejn.110.2023.03.07.00.24.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 00:24:47 -0800 (PST)
Message-ID: <a38cb5d4-91d3-0d9a-41d3-44fed9d39512@linaro.org>
Date:   Tue, 7 Mar 2023 09:24:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 6/8] dt-bindings: ARM: fsl: Add chargebyte Tarragon
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
 <20230306172249.74003-7-stefan.wahren@i2se.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230306172249.74003-7-stefan.wahren@i2se.com>
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
> This adds the compatibles for the chargebyte Tarragon boards.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@chargebyte.com>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index dece3e9ba7fd..2b430e20a7a6 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -781,6 +781,15 @@ properties:
>            - const: tq,imx6ull-tqma6ull2l      # MCIMX6Y2, LGA SoM variant
>            - const: fsl,imx6ull
>  
> +      - description: chargebyte Tarragon Boards
> +        items:
> +          - enum:
> +              - chargebyte,imx6ull-tarragon-master
> +              - chargebyte,imx6ull-tarragon-micro
> +              - chargebyte,imx6ull-tarragon-slave
> +              - chargebyte,imx6ull-tarragon-slavext
> +          - const: fsl,imx6ull

I don't think you put it in correct place. Didn't you just stuff it at
the end?

Best regards,
Krzysztof

