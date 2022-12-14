Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7DF64C663
	for <lists+linux-iio@lfdr.de>; Wed, 14 Dec 2022 10:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238006AbiLNJyq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Dec 2022 04:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237995AbiLNJyp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Dec 2022 04:54:45 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748A91C4
        for <linux-iio@vger.kernel.org>; Wed, 14 Dec 2022 01:54:44 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bp15so9486575lfb.13
        for <linux-iio@vger.kernel.org>; Wed, 14 Dec 2022 01:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DJHzz7Cr6mZdLR560syNh/uSUGyL1AkyOrCtyL2Bvwc=;
        b=BZ8KWJbhZI9j9mmLKk5E0+GIQCI5UAqUlqbIyZY21NQCbE8ZAWeM/JQrKgwesdRT3P
         3akYY+u69yNw6ES0KS9n0rRG0nKkyV1fTai1qJYAQAG+wwOwBSlpz2xXYuj6P9O6s1uX
         MyE8snUQvLBh2d+v2QVBORATzoRtvTQJN0s9BMr3yWdXH5ymDN5TWzNHFQU6UOkVgH3D
         lxk+HxEEFrZgdnalGqbO4u5xjtWKiJMM0muohPvg0PxDxv3ZZuJIEit+Yt0i330mnH9X
         77mb0rCgxwcR0OvixPmnt79xXE5faLsBohdBmoX/+WG34TPVUovrlz2DoBYSGImvs6Ub
         fWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJHzz7Cr6mZdLR560syNh/uSUGyL1AkyOrCtyL2Bvwc=;
        b=4iDo6Nh/YzCFO+h9yq5MEV5j6uVgIIpmnI21txz00XdPIcZPq21IK9bgL4aCOl3kmI
         PHj+m5ohD/rTuAGRnm3Bjcm+lpk8BwO/cXHdZ4qRZIN7iG/Sed9CgE5eKOWy2xQEF8FD
         gTi2klyOpaym5X7/VGLa+QsSX7iVS5fLym+f0xVHXkqp7bo/PfOf9yDuYGwj4M5mitTu
         2w9+AYrtWpj60Lw5Ng51tlCuw+4z1LpKDefgJa1QjC/NLvAS9toWTF4pb2Ed8/L6Biyo
         eHiG8jpaNr9YlpGeWYUykmgWnM1VgpzvUmz3+H2bb1byN4cuVYN18pC1fyyXolT/6Lpo
         CGYg==
X-Gm-Message-State: ANoB5pmbpDhQafS8/YrVGqHXzfSjPuGpS8slzI5nGXM+KxXRgFZhDV/I
        /AunG1N1KQbrtF3UbZas6P0X7g==
X-Google-Smtp-Source: AA0mqf5+dPoClAGr/fcvhHv5/BoMUrcqY4rn7Vn3amkoNIZ0rTphTBFbZ5NlYEfynFQHbtVFlqIfOw==
X-Received: by 2002:a05:6512:2110:b0:4b5:649a:9105 with SMTP id q16-20020a056512211000b004b5649a9105mr5804481lfr.65.1671011682872;
        Wed, 14 Dec 2022 01:54:42 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c36-20020a05651223a400b004b55da14ba8sm734743lfv.291.2022.12.14.01.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 01:54:42 -0800 (PST)
Message-ID: <2e9e84ce-97c6-77de-6fb2-40c91fa81e51@linaro.org>
Date:   Wed, 14 Dec 2022 10:54:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 4/4] dt-bindings: iio: accel: fxls8974cf: add new
 compatible string
Content-Language: en-US
To:     Han Xu <han.xu@nxp.com>, Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Sean Nyekjaer <sean@geanix.com>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Clark Wang <xiaoning.wang@nxp.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, imx@lists.linux.dev
References: <20221213171536.1880089-1-han.xu@nxp.com>
 <20221213171536.1880089-6-han.xu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221213171536.1880089-6-han.xu@nxp.com>
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

On 13/12/2022 18:15, Han Xu wrote:
> Add new compatible string for the NXP FXLS8974CF accelerometer sensor.
> 
> Signed-off-by: Han Xu <han.xu@nxp.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

