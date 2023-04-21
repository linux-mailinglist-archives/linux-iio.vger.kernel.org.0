Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B746EA59F
	for <lists+linux-iio@lfdr.de>; Fri, 21 Apr 2023 10:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjDUIM6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Apr 2023 04:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjDUIMv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Apr 2023 04:12:51 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD509EEE
        for <linux-iio@vger.kernel.org>; Fri, 21 Apr 2023 01:12:42 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-504eac2f0b2so2284436a12.3
        for <linux-iio@vger.kernel.org>; Fri, 21 Apr 2023 01:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682064761; x=1684656761;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LhAi/47bzb0+GcN3Ihgi11hk+T47ybnfllhUZZil3DE=;
        b=XcFnwctyvPrt7z1gsc1Yr8KjxYRC+k4/8LDW+wnpSet6BiiYdgHODrbYzJ1gMCh6LI
         3qWc0njbSExbb226yVodjEyirsBJ64/W70Wp3aa5bWU4M7nMgTIwXYGevGdUAay9CUMW
         2nVCpc0+tJyGKW8g1MQj0n31+cWNVsnUqV7zTHiQk2KBjvkCECWrO3NYju08cozCZeR1
         hrFvcNv4EsAAEscHYAh7mIRkgkqT83IJvSQVyBaVyGypoyD0wjACLnIuVgMRZT3e1pb/
         xUTp3Kr3YBqa+r82F5MFmR9b8CCsnHeAGpkx0wbCxPrn7lVS1gWftH2+bCdZ7I6xNq4P
         aneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682064761; x=1684656761;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LhAi/47bzb0+GcN3Ihgi11hk+T47ybnfllhUZZil3DE=;
        b=k5H9LGSCSQTnj3sunDaYmjSHNzJzGbSVBvN1rMaBYHDtdtWEAB89y5jzenrcu/6al0
         OkwOKj/h01Vpb4F0TIiBKXAfJ+cHLjykKbQKvVfX3y4b+E+XjkS5X7Q7Ot4UPZLsFc/U
         9wuhKzQ1rd/1btyXnMcpeAn75bmLGx6dcfflsY2ixmGZqtn4g7bohiWsbSCpfe56m+L7
         00wAIU6djxDR2izOv7zCnco/ftZFbKx93ZpWnG6iHeN3ov4U3bK4ux8rdCRMO6+hx8W6
         sq/YHgUWlaBgjXGzPJPZe+UeZ1vGPQ3pHAEWRBc5q1ytDhZ2lYTT93h0FT+sFre4eP8k
         Hzrw==
X-Gm-Message-State: AAQBX9fP7yr9NUnsZCU2ok9ow4LfxbdKi2XdmW6GX8xidVd5nF9FgQ6k
        wGGoW/Kv17t7umMAI7scOK8muA==
X-Google-Smtp-Source: AKy350ZDr7Zj23PxXXhTtWiqUYtFwMD3BgjxFbrktnrH98srejm9XriG7QsxJHbmnhdTC82RWZLISA==
X-Received: by 2002:a50:e70f:0:b0:505:513f:3d2d with SMTP id a15-20020a50e70f000000b00505513f3d2dmr4428507edn.40.1682064761028;
        Fri, 21 Apr 2023 01:12:41 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:668b:1e57:3caa:4d06? ([2a02:810d:15c0:828:668b:1e57:3caa:4d06])
        by smtp.gmail.com with ESMTPSA id be9-20020a0564021a2900b00506a2e645f6sm1592565edb.71.2023.04.21.01.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 01:12:40 -0700 (PDT)
Message-ID: <40163a89-0a78-f4b9-8379-6bae9b0f0b63@linaro.org>
Date:   Fri, 21 Apr 2023 10:12:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/5] dt-bindings: iio: Add KX132-1211 accelerometer
Content-Language: en-US
To:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org,
        mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1682019544.git.mehdi.djait.k@gmail.com>
 <68466b01b967efbdd1bf2de0747d35f28f94fddb.1682019544.git.mehdi.djait.k@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <68466b01b967efbdd1bf2de0747d35f28f94fddb.1682019544.git.mehdi.djait.k@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 20/04/2023 22:22, Mehdi Djait wrote:
> Extend the kionix,kx022a.yaml file to support the kx132-1211 device
> 
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> ---
> v2:
> - made the device name more specific from "kx132" to "kx132-1211"
> - removed the output data-rates mentioned and replaced them with "variable 
> output data-rates"

You missed Rob (and maybe other maintainers). I think he does not care,
but anyway - why not using just get_maintainers.pl? It does entire job
for you, no need to figure out any addresses.



Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

