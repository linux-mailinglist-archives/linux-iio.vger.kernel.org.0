Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9EC6191A0
	for <lists+linux-iio@lfdr.de>; Fri,  4 Nov 2022 08:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiKDHOC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Nov 2022 03:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKDHOB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Nov 2022 03:14:01 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C039C28E;
        Fri,  4 Nov 2022 00:14:00 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id i5-20020a1c3b05000000b003cf47dcd316so4811233wma.4;
        Fri, 04 Nov 2022 00:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=71JDLSPDuOSbvW6+01TP0a2cLDg8k4YK3ZQF2CPNVmw=;
        b=ECMGKlpSiSmSjUeCpDQL2qatv/Hg3mMkzAERCgFbCAh3HAekaZFIBticVVVsOUv0rR
         8c/qwD8iir6CSLOSg7m8PF07nWsDEah6bvY36i6YFPKfv+Ji7SEK+wSBBlZALtkVNfsF
         J5VA4jW+n/LKdMuUlWy3qC/5DWzyHKAMdlChjoNjJD8T8SHiaF/DVEDijz15xUbEHYPW
         yHXjDC/0fZi1X+aB2bc5j8KJdQ9JTipdhmDVpLM8BhJWY/SU6/B/SmdzPwj+lvD3eGEe
         TWNxrsY3DPVBiEZg6VwKcfK4Q422ovM+2+dSo7vp9zCBUdL8Pakntxhowo44pcGPXcq2
         cfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=71JDLSPDuOSbvW6+01TP0a2cLDg8k4YK3ZQF2CPNVmw=;
        b=gyWdi0RJ0eXiHf+WVq/ac4lttZVwb79d1i319SJ7mtZOknpe9Fn9U0q6+NiRRflvJQ
         9+TlS9qOCRZs16s8EcXoTqJUL1vFRSwG5AOJEuZeQFYawyylUeNxuaEWqPLP7u91kdWs
         0STJ+ltzawxxflZqw3UlBklRZtnD6tZBO5QwNaxvZa4QZSnvCgoM/wqAUaQAbp/FQ9jh
         Q+7lT776YDQ/fmjZtAOgzYKPHf4yTEe2coaM3tKlVND9PTckWgV6LePTm9Pom+Hm7FnQ
         QigW8IqReLbGIUNcZV50nmq2TyPCcsLbOt1/I7I3KN6d5jq137cSuTs0s5XGhiuXN219
         OOCA==
X-Gm-Message-State: ACrzQf0yGhsPQt99Y5jPBw5hpin7eTKyqo+WYjH4xINThOFZv3B3UGwf
        krfMmsyr8u37v1/DQ3K0ffLtvNYexuI=
X-Google-Smtp-Source: AMsMyM5552JHK7ePe0KMS/Ml1NhsaEsl83t1vO1WMqhdROt7orCJp32OTE5eReE/Dp7REC477+zJiQ==
X-Received: by 2002:a7b:c30a:0:b0:3c1:bf95:e17b with SMTP id k10-20020a7bc30a000000b003c1bf95e17bmr23281588wmj.31.1667546039161;
        Fri, 04 Nov 2022 00:13:59 -0700 (PDT)
Received: from [192.168.0.104] (p5dcfe5c1.dip0.t-ipconnect.de. [93.207.229.193])
        by smtp.gmail.com with ESMTPSA id l21-20020a05600c4f1500b003b4fdbb6319sm2122672wmq.21.2022.11.04.00.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 00:13:58 -0700 (PDT)
Message-ID: <3e1b8549-0961-697b-63b8-db6b37d53c6b@gmail.com>
Date:   Fri, 4 Nov 2022 08:13:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v5 0/8] Add support for mp2733 battery charger
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        lee.jones@linaro.org, linux-iio@vger.kernel.org, jic23@kernel.org,
        sre@kernel.org, andy.shevchenko@gmail.com, lars@metafoo.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
References: <20221029093000.45451-1-sravanhome@gmail.com>
 <8ba915b1-be77-f78e-87b0-9a00c8387084@linaro.org>
Content-Language: en-US
From:   saravanan sekar <sravanhome@gmail.com>
In-Reply-To: <8ba915b1-be77-f78e-87b0-9a00c8387084@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 04/11/22 02:54, Krzysztof Kozlowski wrote:
> On 29/10/2022 05:29, Saravanan Sekar wrote:
>> changes in v5:
>>    - fixed commit message on v5-0002 and v5-0004
>>
>> changes in v4:
>>    - fixed attributes groups review comments in v3
>>    - added new bug fix patches v4-0007 and v4-0008
>>
>> changes in v3:
>>    - fixed dt_binding_check error
>>    - fixed spelling usb->USB
>>
>> changes in v2:
>>    - fixed spelling
>>    - revert back probe to probe_new in mfd driver
>>
>> I do not see a cover letter, but FWIW,
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> This does not belong to the cover letter. Please add respective tags to
> patches, where applicable. If Andy gave Rb tag for entire patchset, add
> it to the patches.
>

Hello Krzysztof,

These are v1 comments from Andy to me, all of them are addressed and I 
kept in cover letter for history

>> for all patches except DT binding
>> Note, some of the comments regarding spelling were given, I believe
>> you are going to address them in v3.
> 
> ...and this comment is from who? Andy?
> 
>>
>>
>> add support for mp2733 Battery charger control driver for Monolithic
>> Power System's MP2733 chipset
>>
>> Saravanan Sekar (8):
>>    iio: adc: mp2629: fix wrong comparison of channel
>>    mfd: mp2629: fix failed to get iio channel by device name
>>    iio: adc: mp2629: fix potential array out of bound access
>>    power: supply: fix wrong interpretation of register value
>>    mfd: mp2629: Add support for mps mp2733 battery charger
>>    iio: adc: mp2629: restrict input voltage mask for mp2629
>>    power: supply: Add support for mp2733 battery charger
>>    power: supply: mp2629: Add USB fast charge settings
>>
>>   .../ABI/testing/sysfs-class-power-mp2629      |  16 ++
>>   drivers/iio/adc/mp2629_adc.c                  |   8 +-
>>   drivers/mfd/mp2629.c                          |   7 +-
>>   drivers/power/supply/mp2629_charger.c         | 229 +++++++++++++++---
>>   include/linux/mfd/mp2629.h                    |   6 +
> 
> Why do you Cc DT maintainers?
>

This patch series includes DT bindings documentation which has already 
merged by 15Jun2022.

https://lore.kernel.org/all/20220615145357.2370044-3-sravanhome@gmail.com/

>>   5 files changed, 228 insertions(+), 38 deletions(-)
>>
> 
> Best regards,
> Krzysztof
> 

Thanks,
Saravanan
