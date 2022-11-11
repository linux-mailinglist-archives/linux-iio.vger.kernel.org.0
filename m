Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10A6625DA4
	for <lists+linux-iio@lfdr.de>; Fri, 11 Nov 2022 15:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbiKKO6w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Nov 2022 09:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234690AbiKKO6u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Nov 2022 09:58:50 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210F95D6A1
        for <linux-iio@vger.kernel.org>; Fri, 11 Nov 2022 06:58:49 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id a29so8658565lfj.9
        for <linux-iio@vger.kernel.org>; Fri, 11 Nov 2022 06:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QNkICjAX/32HDUAnigk/Y3GhfMVj+8qDhAA1PBpiwXw=;
        b=rT+lqCxNWeviS/47HFIGPY4gZr2+WoaowMZ8pM6NJhIfrKvcw5UwbSJFv8CnZoAlVK
         21AF4/pxXG1EYtd8Z0nysXFcCNaIvyTIx+/yFJ5t6Tb/8IoufqmdEgquJ7EeuZbkByrd
         XmFIrac0vIP2u3zsdNrCniJ8XJ7mNHhHViYTGu/2lIaDqQ3zEXrItI88J2yHlIuo97+H
         x9zcahJjf6NNs3SHdVAH6OpEiwrTO6Cm7t7hB0pAZYHJHeWzgPxlby6jeA4XK+JdrttX
         mrIej0MkVRZeWKM6WqKcVlj6L3xULTIwadQVNCflWrBE3yTHEOPgQVKH4iBb3taom0XH
         50wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QNkICjAX/32HDUAnigk/Y3GhfMVj+8qDhAA1PBpiwXw=;
        b=tO/x74DjJwgxRuQA/oa9sCqF45LVIcqOvH6yNJnKkc4zeAv47flJO/GLQih1tDT+Pw
         RQZPHTaEqGjMLzqjYnnm5ndVxBpIxMhokX1kISUwANfn6YqSVUtN1OSdtllBMvIzGCOE
         0OK45eDxGhLr0LvjobzclZmuqSZZ4jEdTGFboOglr+cQjzpP6vKWjU45YSyw0EY7hOOb
         xglsNjsPCsE3c7I7U2Ot7wA+eRyn86P0EQ7O63sO14BVkYNODeJEg4cT/lvBQ9piQC9K
         f8jEYp09g+4Rl2XksV/NqewQx/nHot4W7ceJe2YEK/UWv7aKDIC5/0qBnqIRyAngtJyJ
         QUDA==
X-Gm-Message-State: ANoB5pm3COj6voFZERkMNTeJ7pFkrOgTJ2SJMLWVbQ+rJsI131U1O2Ns
        A8XuACPguRNDCYnyweq7w7t2TQ==
X-Google-Smtp-Source: AA0mqf5/MA9nEf5sB+ConmwwW7f+KrhhyigZ1kpFOLVhRUWRfSycQqiUyqszyE11K8DdS+o7tyHirA==
X-Received: by 2002:a05:6512:3f28:b0:4a2:2aab:5460 with SMTP id y40-20020a0565123f2800b004a22aab5460mr796585lfa.62.1668178727520;
        Fri, 11 Nov 2022 06:58:47 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id o13-20020a05651205cd00b004aa427febe5sm367813lfo.64.2022.11.11.06.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 06:58:46 -0800 (PST)
Message-ID: <62ba3d0d-d29e-d735-4814-0f9f2d9da9ab@linaro.org>
Date:   Fri, 11 Nov 2022 15:58:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: imu: Add inv_icm42600
 documentation
Content-Language: en-US
To:     Jay Greco <grecojay@amazon.com>, linux-iio@vger.kernel.org
Cc:     jorcrous@amazon.com,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221110192933.13616-1-grecojay@amazon.com>
 <20221110192933.13616-3-grecojay@amazon.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221110192933.13616-3-grecojay@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/11/2022 20:29, Jay Greco wrote:
> Update the required documentation for the icm42631.
> 
> Signed-off-by: Jay Greco <grecojay@amazon.com>
> ---
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

