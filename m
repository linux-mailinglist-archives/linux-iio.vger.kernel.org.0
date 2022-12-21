Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F54652ED7
	for <lists+linux-iio@lfdr.de>; Wed, 21 Dec 2022 10:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbiLUJrz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Dec 2022 04:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbiLUJr0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Dec 2022 04:47:26 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486CE22518
        for <linux-iio@vger.kernel.org>; Wed, 21 Dec 2022 01:46:56 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id b3so22720029lfv.2
        for <linux-iio@vger.kernel.org>; Wed, 21 Dec 2022 01:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FFV3SKcbbwVG4mPQ3fgSQpa4lfCIdOajdldFkfKKxvE=;
        b=eqxMFHrS6LydI8S170d4OfsDfT7Xi7t+Ofn63H4O52XqmDBx4386+y5JlIks+sq4FK
         xrnslmdj49+JK5cqC9F4cUa+VPee+AJ7aSMgPolMuPC/ZNvJG3OUtBcJH+yzu6dick2N
         YH7wjvqTmggKky9K0+fQSaLu4HwTofa+RvtOOmNGF0Y+gxQ/+RL4kf5nzL4sdomFNowJ
         48BcxPGPHhNJX599TyTWaLApflxivQAJm3OnvZ3CASwqp0gIylzDETxgEqBRtI3ZWO7q
         O9oGAxBmiHXKD2IBXl78IiFIPLugpYtKqbUUvN273RKZMbBj0Rc+/jWEmvSioSMJQE5j
         JiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FFV3SKcbbwVG4mPQ3fgSQpa4lfCIdOajdldFkfKKxvE=;
        b=UlG/7Nug0sm/wSAk/UAH+GU5CPOzuYcmD6K6dyV/J+0HXf6UarTdp4DA65pyE2VinT
         lCv/SQZQL62/3vBvERsm0cKyOUcrjfFvkLbdlP0USJf/y608xWhGRy59JOAP82WDNvOi
         vjVUwZ3wfqSWaVzGrDeo93Enp01mE0X3IwK/X3O5Aq6TJZEKWThsbx3A7ipx48k+xRr7
         laxzgBkttD+0PQe6jr2OsLh1IogVFaxmyV/nlUB5n+I+XjMp/Bqu9A0JtW+I4DB3Hgal
         brM9FyiP1I1e2aGr6MTvXFE/nVcwRqVFdE9jyAaWFsVbzvJj3qloN4lFI9dMGzr5GK/B
         K88A==
X-Gm-Message-State: AFqh2kqyr0SefmYCdyHEE0qd6S0PDuO/gA3uMwPIaVLb5lOy68KsnpcP
        ZTDQuXrgC09doG8zi4xODG5rVw==
X-Google-Smtp-Source: AMrXdXtse5N2LNV/JcAoNtwtclDMV2Fxkph9Blpd214jwmBmHoNAWJsqt5JG7fZfyxDO5vnF5OMa5A==
X-Received: by 2002:ac2:4c8e:0:b0:4b6:ee97:36d2 with SMTP id d14-20020ac24c8e000000b004b6ee9736d2mr1404649lfl.40.1671616014617;
        Wed, 21 Dec 2022 01:46:54 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id x14-20020ac259ce000000b004a9b9ccfbe6sm1797989lfn.51.2022.12.21.01.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 01:46:54 -0800 (PST)
Message-ID: <2296ffe2-2e10-eb35-1ff9-d07dbfbe8cf8@linaro.org>
Date:   Wed, 21 Dec 2022 10:46:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: ti,tmp117: add binding for the
 TMP116
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>, puranjay12@gmail.com,
        jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de
References: <20221221092801.1977499-1-m.felsch@pengutronix.de>
 <20221221092801.1977499-3-m.felsch@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221221092801.1977499-3-m.felsch@pengutronix.de>
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

On 21/12/2022 10:27, Marco Felsch wrote:
> The TMP116 is the predecessor of the TMP117.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
> v2:
> - drop items from single enum


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

