Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D912618DD1
	for <lists+linux-iio@lfdr.de>; Fri,  4 Nov 2022 02:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiKDByu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Nov 2022 21:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiKDByt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Nov 2022 21:54:49 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F91623BC1
        for <linux-iio@vger.kernel.org>; Thu,  3 Nov 2022 18:54:48 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id l9so2310740qkk.11
        for <linux-iio@vger.kernel.org>; Thu, 03 Nov 2022 18:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CpQRyt8GRENl7jaeL0O4GGJhTNn+SQKLLiVgAveef7I=;
        b=Gwqb90AaQPYreptA6yTj60W19Ra5ot0OVoD4ya55AZzhLKcKjA735OsZhNwjUTXkLD
         fY/07k0mUNv88fCbe3S178vC7UfN72uy82jNxXTJJyds/Q3Iwjqs+I95nXOnFgVm/vOf
         spQ7DfLWjs9YPJq/wdv5oCquy+1bEk7VQk3+7YYE1hTToeUFo1DVx5ziKszoB8XeZsYR
         HaxBqgkSszsMM82gXZyBVZtv5lHzZoPP0WR9niQnOyUjMCsJLfTEnUrnLJXyfkWkhJmp
         mN16eK2I2vdBK297IXM7qfXpG1b7AwvvuZXB3hOsAkmU4/nnRG7O/gSU/9KuK9zmjACx
         Y6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CpQRyt8GRENl7jaeL0O4GGJhTNn+SQKLLiVgAveef7I=;
        b=a2CI6j9Vj2iwJ0PDE6SFggHohZ8MMaNaoHAoNobgXU8130Eh+rcXgoGhLm4KK9cZhl
         2bdhWCxm4xVSf6/pBhoUwiraMF36I/U9QQUhnyrHFjHXL+bWHSKlfhTHtsuTILAdgcv1
         Y7tOPd2+ExBR2DZoHZAwoFUbBYT8YoDIBdK+0pG1fYoLqw/9H83lhEHt3JSZG9JDNWg8
         1aAlklrfrcXagkPGiNBvD/jUBjzu1p5ZGll/syTjtfIsDaxdC8sKtpS/yIAk6dLuIsHz
         fsKAmKoeH1dA10NGS3QgscmGc97bIfvjzOzSCzr4lM3LOA+/K58cywhE/0lOC3f44gEX
         WbfA==
X-Gm-Message-State: ACrzQf2gnNbgmAQLeO+oQCxDRgmiN+e/aA9BsuurhPTvaoyF1A6eS2wP
        Rgzr5Qx+Tg/cgukMHk07+e4HPw==
X-Google-Smtp-Source: AMsMyM6V5SIrE7g6V+q7s37+2/77Q9qXgfIom8+gzk14wCaEDiQzqDI2OJ+5xVj34r4QCTPSOXX/wA==
X-Received: by 2002:ae9:ebce:0:b0:6f9:ff07:7295 with SMTP id b197-20020ae9ebce000000b006f9ff077295mr24885670qkg.655.1667526887546;
        Thu, 03 Nov 2022 18:54:47 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:da2a:9e7e:ddb5:dfa1? ([2601:586:5000:570:da2a:9e7e:ddb5:dfa1])
        by smtp.gmail.com with ESMTPSA id s9-20020a05620a29c900b006f1187ca494sm2024602qkp.28.2022.11.03.18.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 18:54:47 -0700 (PDT)
Message-ID: <8ba915b1-be77-f78e-87b0-9a00c8387084@linaro.org>
Date:   Thu, 3 Nov 2022 21:54:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5 0/8] Add support for mp2733 battery charger
Content-Language: en-US
To:     Saravanan Sekar <sravanhome@gmail.com>, sre@kernel.org,
        lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20221029093000.45451-1-sravanhome@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221029093000.45451-1-sravanhome@gmail.com>
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

On 29/10/2022 05:29, Saravanan Sekar wrote:
> changes in v5:
>   - fixed commit message on v5-0002 and v5-0004
> 
> changes in v4:
>   - fixed attributes groups review comments in v3
>   - added new bug fix patches v4-0007 and v4-0008 
> 
> changes in v3:
>   - fixed dt_binding_check error
>   - fixed spelling usb->USB
> 
> changes in v2:
>   - fixed spelling
>   - revert back probe to probe_new in mfd driver
> 
> I do not see a cover letter, but FWIW,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

This does not belong to the cover letter. Please add respective tags to
patches, where applicable. If Andy gave Rb tag for entire patchset, add
it to the patches.

> for all patches except DT binding
> Note, some of the comments regarding spelling were given, I believe
> you are going to address them in v3.

...and this comment is from who? Andy?

> 
> 
> add support for mp2733 Battery charger control driver for Monolithic
> Power System's MP2733 chipset 
> 
> Saravanan Sekar (8):
>   iio: adc: mp2629: fix wrong comparison of channel
>   mfd: mp2629: fix failed to get iio channel by device name
>   iio: adc: mp2629: fix potential array out of bound access
>   power: supply: fix wrong interpretation of register value
>   mfd: mp2629: Add support for mps mp2733 battery charger
>   iio: adc: mp2629: restrict input voltage mask for mp2629
>   power: supply: Add support for mp2733 battery charger
>   power: supply: mp2629: Add USB fast charge settings
> 
>  .../ABI/testing/sysfs-class-power-mp2629      |  16 ++
>  drivers/iio/adc/mp2629_adc.c                  |   8 +-
>  drivers/mfd/mp2629.c                          |   7 +-
>  drivers/power/supply/mp2629_charger.c         | 229 +++++++++++++++---
>  include/linux/mfd/mp2629.h                    |   6 +

Why do you Cc DT maintainers?

>  5 files changed, 228 insertions(+), 38 deletions(-)
> 

Best regards,
Krzysztof

