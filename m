Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9D86B3CB1
	for <lists+linux-iio@lfdr.de>; Fri, 10 Mar 2023 11:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjCJKq4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Mar 2023 05:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjCJKqz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Mar 2023 05:46:55 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA63F82A3
        for <linux-iio@vger.kernel.org>; Fri, 10 Mar 2023 02:46:48 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id a25so18892176edb.0
        for <linux-iio@vger.kernel.org>; Fri, 10 Mar 2023 02:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678445207;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KQkIKHTqSRFxycgFJncBZ6qruloLEWGLx4Mzr1FPwK0=;
        b=YWeVjmN27CXtE27JtCd+rfW6I6wbiQ86OTH9owamL/1fTkN8J6ROvEMPH4Gv3PG94r
         XpeYP+Ld0iolsjgDCQZ//bHrSC67FlDCTewAypQb9HiivrdoASTiPBbF4Qgg4IkaGM+l
         cDBy3ZQoDFGXpAaJVg4G5AcanRxOjzDv47xe31DW0snxDleOsvufHpIVkzC1V06Osz0C
         yq+tBY3xfVML+VgDgJbaL4FPmp9GKdHP8tYwogOvB/7eTY3YFL6pmtc0P5O1Q3oYL9rQ
         A1ZamJhpjtiFp80mQgFOCY2UY5DOQQ7xzP1tV3DgLR/cjsUy1OlydZ84bWPNvPsb3l8z
         YHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678445207;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KQkIKHTqSRFxycgFJncBZ6qruloLEWGLx4Mzr1FPwK0=;
        b=xjE1yYXcyGkTYQnHmY7dXaciLYGjBugj484SJ4SiA+HlvlFTbu7U57jk5fJUpzd/WH
         aTNMuUZDQ+0MWZeG5V01CDZaijgsStdM6fD2bUX9g5TNf8133fjV+he3GXZIdupGD8EY
         BTmqDWXnBvO5iEiUlRlGQNzc6CbQMwOCpRSxaFXujWsaIbkKky68h2wKLjaGcBDv6LtJ
         gxYJHPs9wLznyqMLkcAFvde9286Z9canYSO+rLofW2puWmICpC9KsnZYfXzWYIOD+5oi
         Y+oNQf+QsxLqQnE2/i6tTBMSc/9YH5gUzN2oXJfFEmn7d/e1Op3sUVZieUE/5i6C7iSD
         BtmQ==
X-Gm-Message-State: AO0yUKVWMlVMdob1bOYIHf2e+JPyS+HGyOTJtAa7ELGHv3vnvXmlCdNc
        yFZPceTkT3Nk6S1mqPw2lzc5bw==
X-Google-Smtp-Source: AK7set/JBfPGNe1lUH3w56wy9WPO/I94QYC3k3KIoV1A+ZXOpZ+UJYaPgCXK1zDRpsXttpBn+GE71w==
X-Received: by 2002:a17:906:2201:b0:8b1:347c:85c8 with SMTP id s1-20020a170906220100b008b1347c85c8mr25143448ejs.17.1678445207261;
        Fri, 10 Mar 2023 02:46:47 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:2a59:841a:ebc:7974? ([2a02:810d:15c0:828:2a59:841a:ebc:7974])
        by smtp.gmail.com with ESMTPSA id mf5-20020a170906cb8500b008de50990fa7sm806352ejb.21.2023.03.10.02.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 02:46:46 -0800 (PST)
Message-ID: <16bf991e-6b8a-2657-dedc-222ca6a7fd87@linaro.org>
Date:   Fri, 10 Mar 2023 11:46:45 +0100
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
 <a38cb5d4-91d3-0d9a-41d3-44fed9d39512@linaro.org>
 <3c5992f3-269f-8af5-0062-7653c53feffb@i2se.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3c5992f3-269f-8af5-0062-7653c53feffb@i2se.com>
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

On 10/03/2023 11:08, Stefan Wahren wrote:
> Hi Krzysztof,
> 
> Am 07.03.23 um 09:24 schrieb Krzysztof Kozlowski:
>> On 06/03/2023 18:22, Stefan Wahren wrote:
>>> From: Stefan Wahren <stefan.wahren@chargebyte.com>
>>>
>>> This adds the compatibles for the chargebyte Tarragon boards.
>>>
>>> Signed-off-by: Stefan Wahren <stefan.wahren@chargebyte.com>
>>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>>> ---
>>>   Documentation/devicetree/bindings/arm/fsl.yaml | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
>>> index dece3e9ba7fd..2b430e20a7a6 100644
>>> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
>>> @@ -781,6 +781,15 @@ properties:
>>>             - const: tq,imx6ull-tqma6ull2l      # MCIMX6Y2, LGA SoM variant
>>>             - const: fsl,imx6ull
>>>   
>>> +      - description: chargebyte Tarragon Boards
>>> +        items:
>>> +          - enum:
>>> +              - chargebyte,imx6ull-tarragon-master
>>> +              - chargebyte,imx6ull-tarragon-micro
>>> +              - chargebyte,imx6ull-tarragon-slave
>>> +              - chargebyte,imx6ull-tarragon-slavext
>>> +          - const: fsl,imx6ull
>> I don't think you put it in correct place. Didn't you just stuff it at
>> the end?
> 
> Yes, i just put it at the end. But to be honest, i'm not sure about the 
> order:
> 
> armadeus,imx6ull-opos6uldev
> ..
> dh,imx6ull-dhcom-drc02
> ..
> phytec,imx6ull-pbacd10-emmc
> ..
> toradex,colibri-imx6ull-aster
> ..
> kontron,bl-imx6ull
> ..
> tq,imx6ull-tqma6ull2-mba6ulx
> 
> Does the order depend on the compatibles and vendor is relevant?
> 
> So your expectation was between armadeus and dh?

This I don't know :). I think order was by description (name of board)
but maybe by compatibles.

Best regards,
Krzysztof

