Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA68765238C
	for <lists+linux-iio@lfdr.de>; Tue, 20 Dec 2022 16:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiLTPRY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Dec 2022 10:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiLTPRX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Dec 2022 10:17:23 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9A68FC5
        for <linux-iio@vger.kernel.org>; Tue, 20 Dec 2022 07:17:22 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bp15so19038155lfb.13
        for <linux-iio@vger.kernel.org>; Tue, 20 Dec 2022 07:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+H9EGmXw+7p/o37E2+xtxCls8Ta6DtrNGIT/Sjxf5dU=;
        b=pXGAhqmLn4YyRCKIuhHSLsyjrxFBJq8O1Q9myUlpliDJjie07iC91K81iCumjCL6hV
         DSJdC7dYwgqxI5MaJgTW5KsQc7A//ngtsqmM82u22YU6YckBgq8b1c/1rPBpfDoega7K
         AuF29A1aOnaAzHb1KvxxdfuKeylguU1uGuej8AiQEXP/2ToQVWx3YSqxpW8qaKBBcnW+
         Mwf3DXe/9vWSIzL7MfDThKC3CTASolB2xENR3DvK8PSUVLx+17Wk5TzmrElxJ8wntW7b
         BaSClFB0OvZeVYPK3wxhGhhwIGUFCpdjhG+LO06g7SFEv5iEiAUqhoWSpuWKIlPnXDSv
         GIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+H9EGmXw+7p/o37E2+xtxCls8Ta6DtrNGIT/Sjxf5dU=;
        b=uFEyeT2La/rSZSz9Z+CT+4NRsrSN8MHzrrGVvU4LzniFbdqCYI5vw0pFGDv1X0e5Xf
         pcHT8O/dyAFjUUpBs008Lvo9Xb5PCR/6JtUPZUYZ3AD7wxJ9RaAnKBYCd4kpNob+XiwG
         UWCKgAAoMoTWC6XjXyyHW7o22bisWmLYyyQhW9Zot6lA9kUvKkxYVbF0RdAxN0LPLxCB
         GX5LRhx9Ra9+HfrUGFS/LN6MImfVEGQ+I90heFZAMOkFdP85UdK0uEeHB7WgWYBObrb9
         iH13tD98uTxR+lLfzMzyNqhE/pwNWBlbbmNNSWz/gJGyeTkx0ROxV13/8x3DfQ3zoRyA
         oRsA==
X-Gm-Message-State: ANoB5pmbAd1dhhBx7nylVh/XtXnuQfojEnpJkdexfqF5cPvcQemez/Tk
        X+c1PSnWTvGZCS9Pa0Eaoxy9aw==
X-Google-Smtp-Source: AA0mqf4bhcY/6FCHnttO38gFt8LfSbkE8avI1VyQYTyZbYkDH86jXdlGmdpBdKzoWUO0kq3oPYpr7w==
X-Received: by 2002:ac2:4bd5:0:b0:4a4:68b7:e74b with SMTP id o21-20020ac24bd5000000b004a468b7e74bmr13319170lfq.53.1671549440588;
        Tue, 20 Dec 2022 07:17:20 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p18-20020ac24ed2000000b004a46f92a15bsm1490405lfr.41.2022.12.20.07.17.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 07:17:19 -0800 (PST)
Message-ID: <b20239e0-8d92-1697-1267-4b35a3ffd86f@linaro.org>
Date:   Tue, 20 Dec 2022 16:17:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/4] dt-bindings: iio: ti,tmp117: fix documentation link
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>, puranjay12@gmail.com,
        jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de
References: <20221220150222.1813729-1-m.felsch@pengutronix.de>
 <20221220150222.1813729-2-m.felsch@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221220150222.1813729-2-m.felsch@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 20/12/2022 16:02, Marco Felsch wrote:
> Fix the broken link to point to the correct homepage.
> 
> Fixes: 5e713b25d137 ("dt-bindings: iio: temperature: Add DT bindings for TMP117")
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

