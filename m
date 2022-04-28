Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E995139DE
	for <lists+linux-iio@lfdr.de>; Thu, 28 Apr 2022 18:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240124AbiD1QeJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Apr 2022 12:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350064AbiD1QeB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Apr 2022 12:34:01 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884806C96C
        for <linux-iio@vger.kernel.org>; Thu, 28 Apr 2022 09:30:45 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x18so7544846wrc.0
        for <linux-iio@vger.kernel.org>; Thu, 28 Apr 2022 09:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KMHd5fXULhcXyAiUwOACLIbDiIltwFbphMx0p6+Bqpc=;
        b=IlMhCUquK3302JRV+dnW8sisiWrBYKgke8Vcsjpan61x4HXqOUeMXJ1EvR38Yurf10
         sH3zd7/SGwTh0oXmjtJex2nOM8ORWfbnqgOSuVpx+RfGFgl9ajfo7Zrnr/NS+iE85rdo
         AbZw0oGHEj2zHmOx7VKJx+LiLoDE7DFsRbYmqhdp+PT29syjqX0ZbzDuSsUv9VnWlArf
         yiLwTvcPA5Hrutqj/A4K+ZtU5FhV0nLSS2WWveJk6G/qWEyyMG5f0MI1fIjHglb+ABZW
         aQYKaBd4jpDBZdZo+V7TTkDfL3hvrfgyidtMIZwDA96hZwWamWbxuLfBUmhDzf6YDSF8
         SIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KMHd5fXULhcXyAiUwOACLIbDiIltwFbphMx0p6+Bqpc=;
        b=PgwmIcT9FpPUx4xfKFjm0sUuhm/0FHzFBVBrmT5zizZ7k+NCBh1JL9p8VZvFeW1Djr
         sv+WnCcW23+SEXaqtTs4hDFaf7pamWrQ66SkhRY6ZAbZDkayL8G3HJQ1IpP1nCMF0sDY
         s4v+LybG0tjYcHvbtX1NXYD2ti5cyvFda/VNUEDNququptrS3WcF6JbuZWKTOPDmwsQD
         SlfvX3hrGF8Viwdn8UQr2x7IgYhnhGOGjAfoOuymlNoHnzeuS0sbR7LYYznXdugQv/Q6
         GOhNTF3cxle15Gg5d0Ts/ecJtvaWU/Rg7vlruS/z7GGYclQBmfsQHvzt7gGoizE+Ar/7
         MrwQ==
X-Gm-Message-State: AOAM531lG1bp3PbLAoiQ9DOEbH3hPo+RWqHWTwgCgZskiCBmg/9Tda4z
        ryEtOZeaREkLR9ui58O4UWotFA==
X-Google-Smtp-Source: ABdhPJyzdHvOPdycnfJ7BtT6tZsr29Nxggep8lbk5N3X/jFsaHxwjv7admh0kbjGdsP4qIdOkB5Ihg==
X-Received: by 2002:a5d:6551:0:b0:20a:e23c:a7fa with SMTP id z17-20020a5d6551000000b0020ae23ca7famr12917464wrv.535.1651163444078;
        Thu, 28 Apr 2022 09:30:44 -0700 (PDT)
Received: from [192.168.0.33] (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id j12-20020a5d564c000000b0020af46b0ff4sm247406wrw.37.2022.04.28.09.30.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 09:30:43 -0700 (PDT)
Message-ID: <cce2f4b7-3620-7a33-ef21-579eff9a7dac@linaro.org>
Date:   Thu, 28 Apr 2022 17:30:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v13 2/9] mfd: qcom-spmi-pmic: expose the PMIC revid
 information to clients
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
        john.stultz@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20220323162820.110806-1-caleb@connolly.tech>
 <20220323162820.110806-3-caleb@connolly.tech> <Yma4T1+AglaISe2l@google.com>
 <2763f103-6947-e431-cef5-e202c324d678@linaro.org>
 <Ymq9Su3UE5IYiHnI@google.com>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <Ymq9Su3UE5IYiHnI@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 28/04/2022 17:14, Lee Jones wrote:
> On Wed, 27 Apr 2022, Caleb Connolly wrote:
>> On 25/04/2022 16:03, Lee Jones wrote:
>>>
>>> On Wed, 23 Mar 2022, Caleb Connolly wrote:
>>>> From: Caleb Connolly <caleb.connolly@linaro.org>
>>>>
>>>> Some PMIC functions such as the RRADC need to be aware of the PMIC
>>>> chip revision information to implement errata or otherwise adjust
>>>> behaviour, export the PMIC information to enable this.
>>>>
>>>> This is specifically required to enable the RRADC to adjust
>>>> coefficients based on which chip fab the PMIC was produced in,
>>>> this can vary per unique device and therefore has to be read at
>>>> runtime.
>>>>
>>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>> Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>> ---
>>>>    drivers/mfd/qcom-spmi-pmic.c      | 261 +++++++++++++++++++-----------
>>>>    include/soc/qcom/qcom-spmi-pmic.h |  60 +++++++
>>>>    2 files changed, 231 insertions(+), 90 deletions(-)
>>>>    create mode 100644 include/soc/qcom/qcom-spmi-pmic.h
> 
> [...]
> 
>>>> +			/*
>>>> +			 * If the base USID for this PMIC hasn't probed yet
>>>> +			 * but the secondary USID has, then we need to defer
>>>> +			 * the function driver so that it will attempt to
>>>> +			 * probe again when the base USID is ready.
>>>> +			 */
>>>> +			if (pmic_addr == function_parent_usid  - (ctx->num_usids - 1))
>>>
>>> Double "  ".
>> Ack
>>>
>>> Over-bracketing of statements with matching operands.
>> I don't think x - (y - 1) is equal to x - y - 1? Or am I misunderstanding you here?
> 
> Can you give me an example when this would be the case?
According to the Python interpreter:
 >>> x=7
 >>> y=4
 >>> x - y - 1
2
 >>> x - (y - 1)
4

C does also respect the first rule of BODMAS - parenthesis are always evaluated 
first.
> 

-- 
Kind Regards,
Caleb (they/he)
