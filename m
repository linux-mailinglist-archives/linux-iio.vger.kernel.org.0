Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EE75F28D5
	for <lists+linux-iio@lfdr.de>; Mon,  3 Oct 2022 08:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJCGzg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Oct 2022 02:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiJCGzP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Oct 2022 02:55:15 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97CA3FEE7
        for <linux-iio@vger.kernel.org>; Sun,  2 Oct 2022 23:54:08 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id x40so54475ljq.9
        for <linux-iio@vger.kernel.org>; Sun, 02 Oct 2022 23:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=JZCN+l1Bd5s8HEXunwhs1Z1CSkyF5LvZixdlYY+BVRM=;
        b=H8MJiZaBTfvFz3G/GO7dRGmQqLSkUhpThJ0amF8l12XCTerd78eIhuKw+8hGQygCpd
         Ve7M97N1yD6er5wBx/GTtSho+kyxAgkLPUpHlcNiIFnfMLpliZ3wibx142fKGtFbfZ+Z
         zBWq+u4vLXa467/Lels3bDM3D292bvJZHcIKOOyGHWBXa5HGdHgzU3anevgDouD11wBc
         oOS5oDieQ4i0sXhnTMteQGdNhuaNBgvPV5HumA5vLpNfdcaxd6HsM5fyJe4Oqcsl89Ie
         vEmNG1bFgZnOWzlQ7staLjr2q2RSBUlDY8BZ9fmb4e5FuIyNoGDiho+D0KoRUfipbUOt
         S+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JZCN+l1Bd5s8HEXunwhs1Z1CSkyF5LvZixdlYY+BVRM=;
        b=dR+l+4nz0oyS2nuf7nz+6f2AT/W85jqlcD3VNuzYc5pUI9j5ZR5ZmXs26TRl3o9aDw
         uqNcSOiWg216cBzvPLy++hr4H32t6HGWfTXwITk4HAQGTkIY5CWoF65Y1Qi/gPsrKpcg
         4FpR+Ono6IJ46hwPDTyIbY6F6ZEZ+en5eyT4jVAHdoMdOUVzLib7mSEX3lvYfjUOjGsQ
         4gSQ7L7/OLOoGeIUhw1ulKCJ5k8PpKPM51C6EiddhkOJuGmWhsxVNit3AIDjO/Ms2e9P
         ipDfAsp0Ts5vxCLjVS/PcrObltEI19Tl9NhRHziONVpiFJ6yEy51ZFK/8lm9gP6TwYwS
         VKaw==
X-Gm-Message-State: ACrzQf3aW8eqXhxamTWMp9s9g1G7w7QlzYsjPj5QgbDLNQobPPDt0Hwm
        q725XtTz6Om4K/HwbAds7LnEghE/Tc9A7Q==
X-Google-Smtp-Source: AMsMyM4IISlFe9Oma+rXrr12b9BcHoIMxzicn/sSfS2AC1GurL6/AxvK3Gj9DeIDPLZ7ByJgV5H4JQ==
X-Received: by 2002:a2e:9b90:0:b0:26d:d55f:f1d1 with SMTP id z16-20020a2e9b90000000b0026dd55ff1d1mr1358224lji.465.1664780038334;
        Sun, 02 Oct 2022 23:53:58 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id k21-20020a05651210d500b00494618889c0sm1343325lfg.42.2022.10.02.23.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 23:53:58 -0700 (PDT)
Message-ID: <5c4016f8-f915-a5ce-6213-d50f69699b79@linaro.org>
Date:   Mon, 3 Oct 2022 08:53:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v6 2/3] dt-bindings: iio: adc: add adi,max11410.yaml
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>, Nuno.Sa@analog.com,
        Nurettin.Bolucu@analog.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220927141851.279-1-Ibrahim.Tilki@analog.com>
 <20220927141851.279-3-Ibrahim.Tilki@analog.com>
 <a382fdee-3672-50b8-cd58-85563b9d9079@linaro.org>
 <20221002140652.1d51109a@jic23-huawei>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221002140652.1d51109a@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 02/10/2022 15:06, Jonathan Cameron wrote:
>>> +  interrupts:
>>> +    minItems: 1
>>> +    maxItems: 2
>>> +
>>> +  interrupt-names:
>>> +    description: Name of the gpio pin of max11410 used for IRQ
>>> +    items:
>>> +      - enum:
>>> +          - gpio0
>>> +          - gpio1  
>>
>> This is wrong. You said in interrupts you can have two items, but here
>> you list only one. I don't know what do you want to achieve here.
> 
> Aim is 0, 1 or 2 interrupts + knowing which ones they are.
> Device has two pins that have very similar functionality and board
> designers are likely to pick one or the two more or less at random depending
> on which trace is easier to route.
> 
> So my guess is this needs minItems, maxItems.

The current choice allows 0 or 1 interrupt. If you want 0-2 then it
should be:

minItems: 1
items:
  - enum: [gpio0, gpio1]
  - const: gpio1

This one would also work:

minItems: 1
maxItems: 2
items:
  enum: [gpio0, gpio1]

but the order of interrupts should be rather defined, so I would prefer
first.


Best regards,
Krzysztof

