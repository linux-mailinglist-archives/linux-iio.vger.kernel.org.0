Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6887170006B
	for <lists+linux-iio@lfdr.de>; Fri, 12 May 2023 08:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239980AbjELG3T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 May 2023 02:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239976AbjELG3P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 May 2023 02:29:15 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D92859D0
        for <linux-iio@vger.kernel.org>; Thu, 11 May 2023 23:28:51 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bc570b4a3so17195876a12.1
        for <linux-iio@vger.kernel.org>; Thu, 11 May 2023 23:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683872911; x=1686464911;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qCw15SfYMK2B6owlUD8kxxoz9ExQiSv5RRYqltzPr4g=;
        b=dI539FzGixTzW5ymZ3qLWPWh6IrFwVqFA46o4Sr5mT4Ee/rexUM9QVQogWTzgdPvzV
         EOiNj0Ard/Bx0c1fJrZ2zCdXwYDn3L/T9WO16QRB9H0AjMRdJJ/gPLWeEmYRa7UUlqft
         V/AYkl+XWx69xo+8hzmAaSNDvEfG4A4WxCBK6mVF2GHK5RGInzudH0Lbs9xL8XSmr52F
         sERqE3g24+vBDhNh2Qa4ClqjmRcMJhkVhNtlq/r7OOi22F9Dr2mcQjt9nyhWyXQy/oBU
         xKAk/VlfKgwRfqoxFxBHcGs4OKLnIaOzab2rIsh2DyrptGX53ZjA/SsxAq1iW93s62d9
         RFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683872911; x=1686464911;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qCw15SfYMK2B6owlUD8kxxoz9ExQiSv5RRYqltzPr4g=;
        b=QG1KYJ/KNR8R+dmh3pU3rGksIJgqMSlOZdqiPJ7CnkR5K5F9KDEzhpdY404TADMzQ6
         wRAqPIlrynVubZBJcfrV6rn3glsd4W+179by0Pf2JohueACzTUli0Kmj+COH5FhUqYzY
         BH+iS/agtHq7ycRuf2gkepJEQA+BZ48D9t8MTakO9wa1OwSsuQWlQJBJ69Tc+K43q8J6
         RMdS+NJ5mgfJ7hR7ZyZaBm9Is4ptxdzGLipT7S5y8aKx5S9zK4kYL+LiQvETxLXzrIB+
         1P1blfpvtD1sgaybPOxe/Q64+3Tj0MBEpsNarwgZtEjkxv2OB3ADRy0WFzX+3DECu5+d
         geAA==
X-Gm-Message-State: AC+VfDyaXY3MfXVOy/LlMg2ZG/cRqQIjXSnZDYzocygZXE2W2zRRl3L0
        sf22cVIUm/U3irlGMg/wFb+zY/PFmMkJvaiN0nw=
X-Google-Smtp-Source: ACHHUZ6rMumRQiudxsHtEc4TaOEwlKOYxPgYOeRKFTkuhqtDE0NvrtkgljDUlatBGvXrPI1NjJ6HLQ==
X-Received: by 2002:a17:906:eec5:b0:965:bdd1:1d22 with SMTP id wu5-20020a170906eec500b00965bdd11d22mr20510547ejb.68.1683872911361;
        Thu, 11 May 2023 23:28:31 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7ede:fc7b:2328:3883? ([2a02:810d:15c0:828:7ede:fc7b:2328:3883])
        by smtp.gmail.com with ESMTPSA id f7-20020a170906494700b00965bf86c00asm5066016ejt.143.2023.05.11.23.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 23:28:30 -0700 (PDT)
Message-ID: <4d18eb55-a44c-4033-93cd-35c02cb179b3@linaro.org>
Date:   Fri, 12 May 2023 08:28:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dt-bindings: iio: temperature: Add DT bindings for TMP006
Content-Language: en-US
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>, broonie@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <ZFvo2TIiPiMFlbXC@yoga>
 <fc104fdd-3894-aa94-12dc-4c73b26d4159@linaro.org> <ZF08pzGPyReL1uAf@yoga>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZF08pzGPyReL1uAf@yoga>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/05/2023 21:06, Anup Sharma wrote:
> On Thu, May 11, 2023 at 11:28:50AM +0200, Krzysztof Kozlowski wrote:
>> On 10/05/2023 20:56, Anup Sharma wrote:
>>> Add devicetree binding document for TMP006, IR thermopile sensor.
>>
>> Why? Where is any user of this? DTS? Driver?
>>
> 
> The support for TMP006 is available at driver/iio/temperature

There is no such compatible in the kernel. If you add OF support, you
should change the driver.


Best regards,
Krzysztof

