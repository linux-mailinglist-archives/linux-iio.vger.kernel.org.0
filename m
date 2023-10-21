Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162DF7D19FA
	for <lists+linux-iio@lfdr.de>; Sat, 21 Oct 2023 02:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbjJUAjE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Oct 2023 20:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbjJUAjD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Oct 2023 20:39:03 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1409CD6F
        for <linux-iio@vger.kernel.org>; Fri, 20 Oct 2023 17:38:57 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6cd09f51fe0so878648a34.1
        for <linux-iio@vger.kernel.org>; Fri, 20 Oct 2023 17:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1697848736; x=1698453536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sSq0LiQ9DQKIgfiPKxfox3yrdlP/6a1Wky/bubnJNtk=;
        b=SCeLXvxHn0BCXH+fUhPrq1qZ+Sc4igPf4/jnNbvV8IU1zEke/EPqd4ZwVgewUx5nSB
         tLVNfRueIvrBeNGdYrvk1QxOVaXv5NAUqBo2G4bvHcwCLUdE3AikZ+iPH1OaQU5wnBZT
         t5dVDcU52XbZYLhoAx7Ku8JsjjarXjhtso8sMRwIcYwhF33fgycSXPLT1OqnohvBg4YZ
         zYVdJRMhRmrukmmBSt/FWTtnyknSEHio2wJggoXsfXXyOQpmvwMQEwXBHvhTtE+OhLzT
         DYeOLHBOfUNOgkwFt0RiblcRnTodRXednti72xrFyJbaRW0YtEumlQi1qml+eaMqOsG3
         MzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697848736; x=1698453536;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sSq0LiQ9DQKIgfiPKxfox3yrdlP/6a1Wky/bubnJNtk=;
        b=hOLWKbuYeRAL9Jqv9q8s5ADj4MHbYHk6UkPie6wlXMHnzRxsSf6gG9fTnc4TvttHyL
         URAi45676YlfzPVOTqi60G8lcpvTuHIavM6nlx97XctYvJYfcQP5lmBeyReI8OBp9P8D
         1gk2HIf7Jagw1PKjMAnxcwffftSJJg58NvClcuOPa4ISmlZAdrggfZPIR5OquJNKoclZ
         uqP5cG0frUa+/w1op7Oeycd4QH7mGebHaLduptBOqJl7LjTvoHOIlemLSD+mRo/Y0QaL
         mO+kjHlKZti7NSP6/qDr8fFPGiQMt5uiPYST0BPKSe+qyxlw+U1sKyw0m6BuvqHRDWJl
         QbQw==
X-Gm-Message-State: AOJu0YxK05E+1YIKDefD6x35Q1qaqtlrC6BPCJ6Jc+RX6y3Ond1tuD0+
        KMxPM1AqqFF7DNN5KluVqBBpbw==
X-Google-Smtp-Source: AGHT+IGDsFGs9Jk018Kwmxob0O23QAjKaUSRVq/R/vkP5Pxc/Mm7q+JwePrfACOZ5D53ZrLy4UpBjg==
X-Received: by 2002:a05:6870:4949:b0:1ea:8b10:247e with SMTP id fl9-20020a056870494900b001ea8b10247emr4638798oab.27.1697848736400;
        Fri, 20 Oct 2023 17:38:56 -0700 (PDT)
Received: from ?IPV6:2403:580d:82f4:0:9012:790b:50f:4eda? (2403-580d-82f4-0-9012-790b-50f-4eda.ip6.aussiebb.net. [2403:580d:82f4:0:9012:790b:50f:4eda])
        by smtp.gmail.com with ESMTPSA id k194-20020a6284cb000000b006926e3dc2besm2226644pfd.108.2023.10.20.17.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 17:38:56 -0700 (PDT)
Message-ID: <35d74411-9b67-4c41-ae68-6042519a17b3@tweaklogic.com>
Date:   Sat, 21 Oct 2023 11:08:50 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: iio: light: Squash APDS9300 and APDS9960
 schemas
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, matt@ranostay.org
References: <20231019080437.94849-1-subhajit.ghosh@tweaklogic.com>
 <472aa31d-7d6c-41df-86e6-d17f05998256@linaro.org>
 <6b721019-c98e-d926-04a9-e71f9ea20762@tweaklogic.com>
 <eedc5ebf-f8e5-4cbf-b394-c260d2fc53c8@linaro.org>
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <eedc5ebf-f8e5-4cbf-b394-c260d2fc53c8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

>> of apds9300 handles both situations whether interrupt bindings are provided or not, whereas,
>> apds9960 requires an interrupt binding for probe() to be successful. I thought it would
>> be appropriate to add that in the schema.
> 
> Not explained in commit msg.
> 
> Best regards,
> Krzysztof
> 
Yes, I will add all these point in my next commit message in apds9306 patch series rather than
a separate patch as suggested by Conor.

Regards,
Subhajit Ghosh
