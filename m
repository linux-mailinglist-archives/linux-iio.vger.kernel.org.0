Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230A96EA4DB
	for <lists+linux-iio@lfdr.de>; Fri, 21 Apr 2023 09:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjDUHdS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Apr 2023 03:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjDUHdN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Apr 2023 03:33:13 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C191FEA
        for <linux-iio@vger.kernel.org>; Fri, 21 Apr 2023 00:33:01 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5069097bac7so2245587a12.0
        for <linux-iio@vger.kernel.org>; Fri, 21 Apr 2023 00:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682062379; x=1684654379;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vQvSNekuA+xVkE6LzCJUvTt84uwzbVdRtArlra4/NAE=;
        b=Ljf3ZDbvRgdJ6JcznQJ75U2uZwxUvQUikAQ70VIb9G+LZ23XFhrK7O5nrdiSyH87Ol
         Vvtr5vhlMgKh/r74pD/Ucq5hnxi8iGfIbQCV+jqPrLcB4pdf/U7iebAcqxSC/KmMZ1ke
         XAxNTEH+ApcRO65R7r+o0VMDUl3arjUlYHfb+6tIbcuTShuw544n0wyaWXtEPa1dMS00
         KaVbRP0TY15Vyw7wjp27neuwp1BWNlVHU1wyQA/lwEVGzvbsGQd565Ii1u+IIxsnI+Mx
         PMBuCYf0Bq3JIKAiWC5iNgJP5fEuurZxAJZYbIvaaWxeuqEABTcv/hdQkGMVFiWuaDBX
         U2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682062379; x=1684654379;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vQvSNekuA+xVkE6LzCJUvTt84uwzbVdRtArlra4/NAE=;
        b=eTpnP6wEldg5w3J4sQJ9dfpAAARHrfkl88r9MKG8z8p8zc+xSthFMvgGZ7jw5ZPCDL
         w4lT37GdiIA8UkdOge2X+iPoZgr3+lrHAH5kh8ZPCuaY57EXt6/9cecvRJqfVyyBM0jO
         WZ3Eym3jAGHVKkDPrW0nigDLW/5RWeQSOk5t6+RPNmR/7h1K5etDdBwsYZqE7Duq7ppu
         0fORNyn3fE03nBK/QKXdwBlHZxNqdJu6XbdCVrcFNym09Y5MxMlpEqxzNEEJRTiwbhgj
         AsE+bbyryCDPRdv8fKdGrF6DHwLR66YJJ9SdSidZldAPPVI5PipE7Fh/J7zu9d72TXsu
         mUrg==
X-Gm-Message-State: AAQBX9dAHfGYwaI4N1ph5NLvD1sE4K3xfvw9kuanDe92oAbdwtdsqzPv
        ByfVEZ1SRiTjVzA9l46/tWLMaw==
X-Google-Smtp-Source: AKy350YuwSWU0zYYPJ6XKDHEgyOhUdwxSW1wUc+No4b/btQ4LYih3U7vbYDCAzVzftXQU4aL59+vJg==
X-Received: by 2002:a05:6402:4c6:b0:4ac:b687:f57e with SMTP id n6-20020a05640204c600b004acb687f57emr3993389edw.1.1682062378752;
        Fri, 21 Apr 2023 00:32:58 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:668b:1e57:3caa:4d06? ([2a02:810d:15c0:828:668b:1e57:3caa:4d06])
        by smtp.gmail.com with ESMTPSA id d21-20020aa7c1d5000000b005027d31615dsm1537217edp.62.2023.04.21.00.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 00:32:58 -0700 (PDT)
Message-ID: <7d3d614f-b0e8-5d65-da9d-4ed7a7ba5e35@linaro.org>
Date:   Fri, 21 Apr 2023 09:32:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] dt-bindings: iio: potentiometer: Add the Renesas
 X9250 potentiometers
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230420121320.252884-1-herve.codina@bootlin.com>
 <20230420121320.252884-2-herve.codina@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230420121320.252884-2-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 20/04/2023 14:13, Herve Codina wrote:
> The Renesas X9250 is a quad digitally controlled potentiometers.
> 

Thank you for your patch. There is something to discuss/improve.

> +maintainers:
> +  - Herve Codina <herve.codina@bootlin.com>
> +
> +description:
> +  The Renesas X9250 integrates four digitally controlled potentiometers.
> +  On each potentiometer, the X9250T has a 100 kOhms total resistance and the
> +  X9250U has a 50 kOhms total resistance.
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml
> +  - $ref: /schemas/iio/iio.yaml
> +
> +properties:
> +  compatible:
> +    enum:
> +      - renesas,x9250t
> +      - renesas,x9250u
> +
> +  reg:
> +    description:
> +      SPI device address.

SPI bus does not have device addresses, AFAIR. Drop description.

> +    maxItems: 1
> +
> +  '#io-channel-cells':
> +    const: 1
> +
> +  spi-max-frequency:
> +    maximum: 2000000
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#io-channel-cells'
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        x9250@0 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +            compatible = "renesas,x9250t";
> +            reg = <0>;
> +            spi-max-frequency = <2000000>;
> +            #io-channel-cells = <1>;
> +        };
> +    };

Best regards,
Krzysztof

