Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAE61AAEDD
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 18:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410566AbgDOQxg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Apr 2020 12:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410562AbgDOQxe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Apr 2020 12:53:34 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138FEC061A0C;
        Wed, 15 Apr 2020 09:53:34 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k1so715036wrx.4;
        Wed, 15 Apr 2020 09:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=qSFqdR3FlK/8YD5+KmU963ChViLz5asYpHXALyUz8zg=;
        b=lh/qkSRR2q0rz21SvhbeddtEnTG1gL1C7Gj5sszZ4sH8jTdjW3VlqYEi+vIv32XaU2
         jWyKcqYVvB3SvWmPyxiBg9Sm6pH/Bx3aeVyu53sEilxvdom7MHjt33q2OVQuXwyNyFIT
         2gFKs/oggqM8xv2RjYn5jzXMYUAP2kcXGn1nYAZHib/mNxFgdUVNs+GOPQ8JLmwNdeWt
         p8nzcbH59ineFrIxCWxQP3Z33Tv4HxErZhllM+QrPa2f1I6BpjLJ4m/Qz5oks4wB+0hp
         RhcrCKE8mtBtQNUgCf3x24cNlcSfzm3AdsKKzEFACAugcwNPVvp/kFI4o7hVIALhSJv/
         gocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qSFqdR3FlK/8YD5+KmU963ChViLz5asYpHXALyUz8zg=;
        b=X7abJsYx5qQJ7lpUbXeDQGCN0f63LVLi04MZkeiXSHVK446JBTewiciX8idP7e0Yxr
         nGeK1y1oN4isoRJCOwGPagWEJJ82j6NBITa4vbrMQF/8sRRhGMqHdTqnp6Vg2MHPA6vj
         YbIUumKaCMO1sEa9JghtEN40PxJHUh1PQVD8UJ9yX0BYQvJsYSFkVGTZ3xPIdVWssPcL
         9550R6188CBjYZrCibN+m3PDX9N+S5TzQ38iAnP9G1tk9R/VtO5t7htcSfsX1/0+LDo9
         PAI4cUPz/gJ5mkFe/uQT4qV7lk6VYzFgMagmWReArDGu1BZN1M8Q3tLxT+SLK8kyQj4F
         bcqg==
X-Gm-Message-State: AGi0PubSFQJBSoA5ofwzuIwOofc8oXy5BTAX1p9kmtxrfCxqX2gZcpD/
        Bf5NAIMP6RjFp/u2yq6sC1IDDmaJCJ8=
X-Google-Smtp-Source: APiQypJiIITjjK6VWhGWP47Ot8DOs4nOVL2YTiDNOOs0rPCSib2Bz7Qd+lEzdaR51D9N5nxP+ZySiw==
X-Received: by 2002:a5d:5304:: with SMTP id e4mr16191827wrv.87.1586969612335;
        Wed, 15 Apr 2020 09:53:32 -0700 (PDT)
Received: from [192.168.0.104] (p5B3F6CCC.dip0.t-ipconnect.de. [91.63.108.204])
        by smtp.gmail.com with ESMTPSA id 132sm131870wmc.47.2020.04.15.09.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 09:53:31 -0700 (PDT)
Subject: Re: [PATCH v9 0/6] Add battery charger driver support for MP2629
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20200415162030.16414-1-sravanhome@gmail.com>
 <CAHp75VerGG0_J+fHrZfwJRa3EHtGuz-pJbD7zwoXN2jfO7dszA@mail.gmail.com>
From:   saravanan sekar <sravanhome@gmail.com>
Message-ID: <dea1d71e-af5d-356a-79c0-38f343f54dfd@gmail.com>
Date:   Wed, 15 Apr 2020 18:53:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VerGG0_J+fHrZfwJRa3EHtGuz-pJbD7zwoXN2jfO7dszA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On 15/04/20 6:40 pm, Andy Shevchenko wrote:
> On Wed, Apr 15, 2020 at 7:20 PM Saravanan Sekar <sravanhome@gmail.com> wrote:
>> changes in v9:
>>   - fixed review comments in mp2629 power supply such as resource based
>>     iio channel, replace workqueue by threaded irq, irq get with "_optional"
>>
> May I ask you why you are ignoring my tag?
> If you don't want to have your patches reviewed / applied, just don't send them.


Sorry last time it was by mistake. But now I have added in below, if 
suppose to added in top its my ignorance

>
>> changes in v8:
>>   - fixed order of call in probe/remove in iio adc
>>   - add ABI documentation for mp2629 power supply
>>
>> changes in v7:
>>   - fixed probe/remove order, managed and unmanaged call mix use in adc.
>>   - Documentation dual license, i2c node with controller address
>>
>> Overall looks good to me, FWIW,
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>
>> One question though in reply to patch 4.


Please see here, this is first experience of tag in cover letter so just 
kept here as you gave against v7

>>
>> changes in v6:
>>   - removed includes types.h in mfd, of_device.h in adc.
>>   - fixed review comments parentheses, err check, kstrtouint
>>
>> changes in v5:
>>   - removed platfrom data stored in mfd and directly accessed mfd struct in child
>>   - fixed spell check and capitalization in mfd and documentation
>>
>> changes in v4:
>>   - fixed capitalization in mfg Kconfig and documentation
>>
>> changes in v3:
>>   - regmap for children passed using platform data and remove mfd driver info
>>     access directly from children
>>
>> changes in v2:
>>   - removed EXPORT_SYMBOL of register set/get helper
>>   - regmap bit filed used, fixed other review comments
>>
>> This patch series add support for Battery charger control driver for Monolithic
>> Power System's MP2629 chipset, includes MFD driver for ADC battery & input
>> power supply measurement and battery charger control driver.
>>
>> Thanks,
>> Saravanan
>>
>> Saravanan Sekar (6):
>>    dt-bindings: mfd: add document bindings for mp2629
>>    mfd: mp2629: Add support for mps battery charger
>>    iio: adc: mp2629: Add support for mp2629 ADC driver
>>    power: supply: Add support for mps mp2629 battery charger
>>    power: supply: mp2629: Add impedance compenstation config
>>    MAINTAINERS: Add entry for mp2629 Battery Charger driver
>>
>>   .../ABI/testing/sysfs-class-power-mp2629      |   8 +
>>   .../devicetree/bindings/mfd/mps,mp2629.yaml   |  60 ++
>>   MAINTAINERS                                   |   5 +
>>   drivers/iio/adc/Kconfig                       |  10 +
>>   drivers/iio/adc/Makefile                      |   1 +
>>   drivers/iio/adc/mp2629_adc.c                  | 208 ++++++
>>   drivers/mfd/Kconfig                           |   9 +
>>   drivers/mfd/Makefile                          |   2 +
>>   drivers/mfd/mp2629.c                          |  86 +++
>>   drivers/power/supply/Kconfig                  |  10 +
>>   drivers/power/supply/Makefile                 |   1 +
>>   drivers/power/supply/mp2629_charger.c         | 667 ++++++++++++++++++
>>   include/linux/mfd/mp2629.h                    |  28 +
>>   13 files changed, 1095 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-class-power-mp2629
>>   create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
>>   create mode 100644 drivers/iio/adc/mp2629_adc.c
>>   create mode 100644 drivers/mfd/mp2629.c
>>   create mode 100644 drivers/power/supply/mp2629_charger.c
>>   create mode 100644 include/linux/mfd/mp2629.h
>>
>> --
>> 2.17.1
>>
>
