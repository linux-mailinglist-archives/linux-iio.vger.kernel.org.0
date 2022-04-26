Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA015105A0
	for <lists+linux-iio@lfdr.de>; Tue, 26 Apr 2022 19:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347849AbiDZRpI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Apr 2022 13:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353124AbiDZRpH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Apr 2022 13:45:07 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDA71B78D
        for <linux-iio@vger.kernel.org>; Tue, 26 Apr 2022 10:41:57 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e24so6612586wrc.9
        for <linux-iio@vger.kernel.org>; Tue, 26 Apr 2022 10:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QQA23ghBxeAWrg+1pTuG+EIpzKydBoAGm6JxIISmz68=;
        b=k3ePSYdc/oMFI8zzl1Ck2yhC1E/Jbn9NSPODTh/jCaB75hYUB4RUnVAylJ32pERmyW
         zShZu08Cwn8JV+Mr2IuxMH0jNdh9h/ipjh+GGkF8fVSgj0uxKNB7RP8vbQkSxIBtDaLs
         2YC5xTY1klMyg6x7J01UZFwkT5O/nTYpwZlz9vCY0wRiFg3EhQZ/H506Rl9Kbag0m5hy
         QULhN8LIr98ALYBHOFJCqr1qaEVSUFWD663pBj4/pnIgGtp6s8HJZFPeBHde2RNXeeo7
         Z/wR/ct1JvIkj592CtgaVlnj4MDQT/+D2coCXcSzuqqWfh0E39OQvlb4sVOBvacmv6GA
         mNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QQA23ghBxeAWrg+1pTuG+EIpzKydBoAGm6JxIISmz68=;
        b=o7NtzLIFByf1NETajMxb/I8M/zGrkvy+K9WbfMy9Pw5XC3lvaq5dVJcg8uxllR9ybQ
         sQ7YF0ZP5zcxEh7MldfoWM6i6IV9JWZaQSPgCgc3DTcF6giu5kb9BO8STgDzDYz8d5cQ
         +vaad2tNuVCnUCgCU17H5tKj7eiKykcghjrykVK7ksXptoqYmvbs0GOwJU+BtsJY0Ydk
         TQQML3fM4hWqT5WsIUE9mDUZIXvNABt+b4M4Fr1v9sENrsev90UuLk/7XbqeKSx6v1jR
         sfyR+enysYyHYsZq9YYYFWrXnGx4prc3CCoJ1rAb/rkFlK7DaEOcPdqe+RKAGnO/M6FE
         XETQ==
X-Gm-Message-State: AOAM533Bcp3xqcF09J9qzi/WCtRy6K7H7jY9kSQeuheYoTACs9cL/2o2
        62vJT/Q9tEogsfJ4TDC2K4ZR4UX3PTGdqQ==
X-Google-Smtp-Source: ABdhPJwt90fodsf0OiUB4eqoLjLOvhGcW/S/Y1bclGSbPT/V6AE1gAQWmdiwV/0T4GMToMHwE2gluA==
X-Received: by 2002:a05:6000:1547:b0:20a:79dd:28bf with SMTP id 7-20020a056000154700b0020a79dd28bfmr18728266wry.505.1650994916368;
        Tue, 26 Apr 2022 10:41:56 -0700 (PDT)
Received: from [192.168.0.33] (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id s30-20020adf979e000000b0020adfb1292fsm4374036wrb.16.2022.04.26.10.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 10:41:55 -0700 (PDT)
Message-ID: <10f7cb8e-4c2a-0bba-df55-16b56d429147@linaro.org>
Date:   Tue, 26 Apr 2022 18:41:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v13 3/9] mfd: qcom-spmi-pmic: read fab id on supported
 PMICs
Content-Language: en-US
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sumit.semwal@linaro.org, amit.pundir@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20220323162820.110806-1-caleb@connolly.tech>
 <20220323162820.110806-4-caleb@connolly.tech> <Yma4tXvPQ+U89Whr@google.com>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <Yma4tXvPQ+U89Whr@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 25/04/2022 16:05, Lee Jones wrote:
> On Wed, 23 Mar 2022, Caleb Connolly wrote:
> 
>> From: Caleb Connolly <caleb.connolly@linaro.org>
>>
>> The PMI8998 and PM660 expose the fab_id, this is needed by drivers like
>> the RRADC to calibrate ADC values.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   drivers/mfd/qcom-spmi-pmic.c      | 7 +++++++
>>   include/soc/qcom/qcom-spmi-pmic.h | 1 +
>>   2 files changed, 8 insertions(+)
> 
> Please change the Subject line to match the style of the sub-system?
Hi, sorry if this is a silly question, I don't quite understand what you want me 
to change here, the subject line is in the same "mfd: driver:" format as other 
patches in the subsystem?
> 
> Once changed:
> 
>    Acked-by: Lee Jones <lee.jones@linaro.org>
> 

-- 
Kind Regards,
Caleb (they/he)
