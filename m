Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE836448DD
	for <lists+linux-iio@lfdr.de>; Tue,  6 Dec 2022 17:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbiLFQLW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Dec 2022 11:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbiLFQKy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Dec 2022 11:10:54 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1072FA76;
        Tue,  6 Dec 2022 08:05:34 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 140so14926201pfz.6;
        Tue, 06 Dec 2022 08:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FAF09lvySfCr9oD5/MSAZ2ZKkui8tlf346USIK81Ewg=;
        b=ET5bu7KZ+b3PLr23c6ZY7TBKqH7J9r4p8fSs1kGwnwlQGvKSbAvNJJE7i/QvzQC/G3
         JZQGJvQDRICcIgcSqJhTmDmY6VotE1BdjT8gYmGeSH7QlBvLbs/Xl6MAxE8FKwsjvByZ
         AlhoWt9neFd7dtZZLa3ymAd7QuD6cM2H/huRRs8c90W0CsFRVeEhkoeJqZ285BbAQ+R2
         kDMLp9L0Lw1PxHurTRb1C/4WaSs6iAnhw+y1AmgKZxqd2bWrUN8haRVaoQu5/idvan36
         FdZZn+iS877KAniIZ7ri6s0sy0aAzbrse3o82vEC+r8vGg5F2HYH+kIIa5Ao15QDQX8A
         b8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FAF09lvySfCr9oD5/MSAZ2ZKkui8tlf346USIK81Ewg=;
        b=UagJYEqWM4GXLO+HXaWl+zNiJZxcujFyxN/QKplYbg1ICtqi4KNQFAcWMvClZQXkDE
         dJ1rGqUUKOpP0vprmuc54J2iS4+PCUysoFbqpplcgRdIq3JTvZD4RtlF41oIxZfRyRwv
         U3fYS8xKcWZKocDWwfP+Va+Y0Ri10fOAegE13nQL/l4LxucM7X2DPg+akoy6RBuLXPwN
         vLWwWnPKkL9Go2Of8YVry+et7PdA3TFHjHQ6vtphhUszCHqklWbxdDDpFLRtls2k/BlJ
         oHPQgtlaTC1rcCiu88wp9bvhghERLituwncCa08KUr/vL27pUIM87JYac7+SNiD38DFW
         im2g==
X-Gm-Message-State: ANoB5pmZ1bUb/5eRoJ8zpsOt+Jq+CSAwoVocUMCP9Fbnuu6bwsqO4oqb
        ncuqupy9Xu0pPxjkZBTRm8k=
X-Google-Smtp-Source: AA0mqf5E975rSJhCjVpoOsl9BLBfA8yf9jvyon7FW9ThXld/B7d+h1fP54pcGkdHIbs346+qxeGVfQ==
X-Received: by 2002:a62:5f81:0:b0:56b:bb06:7dd5 with SMTP id t123-20020a625f81000000b0056bbb067dd5mr70943644pfb.3.1670342733634;
        Tue, 06 Dec 2022 08:05:33 -0800 (PST)
Received: from ?IPV6:2401:4900:25ca:bfbf:ce0f:fb63:adb8:7efe? ([2401:4900:25ca:bfbf:ce0f:fb63:adb8:7efe])
        by smtp.gmail.com with ESMTPSA id x9-20020aa79a49000000b0056b9df2a15esm6280264pfj.62.2022.12.06.08.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 08:05:33 -0800 (PST)
Message-ID: <eedcf790-5447-d988-f9cb-9103f34f27ae@gmail.com>
Date:   Tue, 6 Dec 2022 17:05:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 0/7] Add support for mp2733 battery charger
To:     sre@kernel.org, lee@kernel.org, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-iio@vger.kernel.org
References: <20221123175425.564042-1-sravanhome@gmail.com>
Content-Language: en-US
From:   saravanan sekar <sravanhome@gmail.com>
In-Reply-To: <20221123175425.564042-1-sravanhome@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 23/11/22 18:54, Saravanan Sekar wrote:
> changes in v6:
>    - splitted chip id to v6-0003 and support of mp2733 to v6-0004 patch
>    - fixed commit message English grammar
> 
> changes in v5:
>    - fixed commit message on v5-0002 and v5-0004
> 
> changes in v4:
>    - fixed attributes groups review comments in v3
>    - added new bug fix patches v4-0007 and v4-0008
> 
> changes in v3:
>    - fixed dt_binding_check error
>    - fixed spelling usb->USB
> 
> changes in v2:
>    - fixed spelling
>    - revert back probe to probe_new in mfd driver
> 
> add support for mp2733 Battery charger control driver for Monolithic
> Power System's MP2733 chipset
> 
> Saravanan Sekar (7):
>    mfd: mp2629: fix failed to get iio channel by device name
>    power: supply: fix wrong interpretation of register value
>    mfd: mp2629: introduce chip id machanism to distinguish chip
>    mfd: mp2629: Add support for mps mp2733 battery charger
>    iio: adc: mp2629: restrict input voltage mask for mp2629
>    power: supply: Add support for mp2733 battery charger
>    power: supply: mp2629: Add USB fast charge settings
> 
>   .../ABI/testing/sysfs-class-power-mp2629      |  16 ++
>   drivers/iio/adc/mp2629_adc.c                  |   5 +-
>   drivers/mfd/mp2629.c                          |   7 +-
>   drivers/power/supply/mp2629_charger.c         | 229 +++++++++++++++---
>   include/linux/mfd/mp2629.h                    |   6 +
>   5 files changed, 226 insertions(+), 37 deletions(-)
> 

Hi,

Can someone give me share the plan for this series?

Thanks,
Saravanan
