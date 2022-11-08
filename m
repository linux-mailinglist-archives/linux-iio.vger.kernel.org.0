Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7965B621B78
	for <lists+linux-iio@lfdr.de>; Tue,  8 Nov 2022 19:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbiKHSJy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Nov 2022 13:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbiKHSJt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Nov 2022 13:09:49 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320AF54B3C
        for <linux-iio@vger.kernel.org>; Tue,  8 Nov 2022 10:09:48 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id b9so22313265ljr.5
        for <linux-iio@vger.kernel.org>; Tue, 08 Nov 2022 10:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+x1FdVd4adc3EY13/UzrLzs2WTM948TTM95bI0vEfoo=;
        b=Fk6AECuBA4Om35QqLARiCBedezNZr8K0aaCXsDjAyLu2Vtf9nDBsQfSUDJZO0qdL7U
         +TXpoDd5j+jJE1O2rJK1c161vN9JXaMD1fFDu4GYYqWJKGxHJHE0uP5OpQSV/9J5uy0t
         z0KP8JGiTaRTrgwzDr+QEjd3SVydSMTDWszZijQEmTXazyk/Ud/qoUj8KOjdcDFY8nXT
         BPodWiqmBjGSh59w/jfqMmxIfATD/XOdAsWmmM7t7EIXpTBvQ56eyr4KTozo3CUko47R
         0ZIumYndDm5ua1LBA2CqjVjI7NsT7l5pXypp/4fgfrWBV9UZ1m4Ui96EfKesqBLxp03F
         ngMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+x1FdVd4adc3EY13/UzrLzs2WTM948TTM95bI0vEfoo=;
        b=qgb1hXYGPxksHgVISzJznoFgJ2a5UTInyaVLcspWjI1m/zKZtiIctuaO65JD/ml7iV
         wHMzAumcvQYtDK1LhsVI8pdJsQ2DPHg8+Cm42Md/845AUPKpPWe7fwbIfy/Pb6ySswVq
         FdhUEUVbNJKohfGABJadEdnvtWlSQjgtYBas9cYWILhwN8QtCFvmY9ArkHnSTqGdvieR
         xJ3UchiXdRbqFxEVTGvSL8QqILdF/TnjhPca27vAu88XGzRF4cYGPOotSXbnF3WNJ/KN
         GdbdEOSyKH5fVHQQeq3z/mN718iYMhYwEy/wAmbUiurW7ZFtdZhMEYdGhSojAKWWH+Lk
         WgjA==
X-Gm-Message-State: ACrzQf2CmTgkFwO/yJvqhX7jmtqDmOWNFYDWSH4YbDpsRmDqgWJM+q1a
        qy7unJjBCxFiNxBJHE7wLioQsA==
X-Google-Smtp-Source: AMsMyM5EqvvKEDSenVf4Y1ruiX0sj1E9hzX6W6GUwN1OuqwyLvUuaaTpQdEFLiM4c91kLf7eAUGSQg==
X-Received: by 2002:a05:651c:551:b0:277:8a70:62d2 with SMTP id q17-20020a05651c055100b002778a7062d2mr8107319ljp.407.1667930986575;
        Tue, 08 Nov 2022 10:09:46 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id b6-20020a056512070600b00492ceda336fsm1881922lfs.278.2022.11.08.10.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 10:09:46 -0800 (PST)
Message-ID: <58ee258e-8708-abcc-077b-c6b4a1a4185a@linaro.org>
Date:   Tue, 8 Nov 2022 19:09:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 03/10] dt-bindings: iio: adc: rockchip-saradc: Add
 saradc for rv1126
Content-Language: en-US
To:     Jagan Teki <jagan@edgeble.ai>, Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Johan Jonker <jbx6244@gmail.com>, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
References: <20221108041400.157052-1-jagan@edgeble.ai>
 <20221108041400.157052-4-jagan@edgeble.ai>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221108041400.157052-4-jagan@edgeble.ai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 08/11/2022 05:13, Jagan Teki wrote:
> Add saradc compatible string for rockchip rv1126.
> 
> Cc: linux-iio@vger.kernel.org


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

