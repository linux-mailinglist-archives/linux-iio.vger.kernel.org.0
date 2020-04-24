Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D21B1B71E1
	for <lists+linux-iio@lfdr.de>; Fri, 24 Apr 2020 12:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgDXKYE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Apr 2020 06:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgDXKYE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Apr 2020 06:24:04 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF76CC09B045;
        Fri, 24 Apr 2020 03:24:03 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k13so10127538wrw.7;
        Fri, 24 Apr 2020 03:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=bQcbk8WYbUCXM8knUlOISeoGEbWqFrfG0URxAnWtDsk=;
        b=XoXClpEkuyudeUYr11NBZJIDel5oAqmbmXwO22lDlR4ljNBMJ5bf9ZtmMOwat81W9+
         qzhm9UCn6F6ZwHy0BQ8lHBEnc6kj+oB/7FhZ4aiP34YtfOSbVdtuDyCDh4D7zY1iAyln
         kz2EGoWsZbwP37W0p4DlM6rTX3VJYhXHkCZM+IVOWEyTPpvkasxNol4hMfVEJDg6IwhM
         bmUzcbcLw5RAw/sFUHmGx+iHKB8CB4sx+88YCo5Ao6dglq9FCF4wxEf7GnV+DFS0Lrkr
         o4Ik6kbrxsTNAhHZlGi8Z/aZ3ocUvVGDy85E3U2ClyfDoNEg+ausvZWWsabhbL4g078s
         OE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bQcbk8WYbUCXM8knUlOISeoGEbWqFrfG0URxAnWtDsk=;
        b=GKOUhvBz+Vk+dyfhYANn8C7SIyOHaRkzHx2xVzNWGa33VPDz1hAaTz7TlWcrSX09qB
         TcB56vw9TsB59o1521Oz1ZoiMIUIeS8uMNfpaF4VcSz1oN4DXEC9LrtefBZCW5VGO3Uo
         bMepzHzQ3e4wvZEuHqI7Bc/zkRoagUCaog/HG/UsKX9YxL0Z5OWlW0IQKLk+Ui/PU8g8
         1lR2FhrxmSpu5++9VU1vwdzE27FolPd6rO5wwZVktO1cSZYDW84D16DE0G970D1opgSr
         X9fMOww+xVG/K8lNdnO1tlsn+wm6JL36C/AZKXyid5fP6bVWIcuJfJm7F7jFn18ECfjD
         G/hQ==
X-Gm-Message-State: AGi0PuaoJ/EK2QVh5UkjNiCzIZCrjX9DfhDhQIB12j2KMazoYmMqlmxV
        LbSQDNUchI5pcZXo0+cVxVXwQCbR
X-Google-Smtp-Source: APiQypJF/eHZfdI5emJWdfXC7ZAywuX3+XbLBgAOS+KEOq0ctGTCHfHIFlT+Ij8KwsgHO9EDrEcDHw==
X-Received: by 2002:adf:cd04:: with SMTP id w4mr10785370wrm.357.1587723842138;
        Fri, 24 Apr 2020 03:24:02 -0700 (PDT)
Received: from [192.168.0.104] (p5B3F694A.dip0.t-ipconnect.de. [91.63.105.74])
        by smtp.gmail.com with ESMTPSA id s30sm7473775wrb.67.2020.04.24.03.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 03:24:00 -0700 (PDT)
Subject: Re: [PATCH v9 2/6] mfd: mp2629: Add support for mps battery charger
To:     Lee Jones <lee.jones@linaro.org>
Cc:     andy.shevchenko@gmail.com, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20200415162030.16414-1-sravanhome@gmail.com>
 <20200415162030.16414-3-sravanhome@gmail.com> <20200424071822.GM3612@dell>
 <8ff17d07-8030-fcfe-8d8a-3011e4077778@gmail.com> <20200424093720.GA3542@dell>
From:   saravanan sekar <sravanhome@gmail.com>
Message-ID: <864eb6ad-a605-c0a0-c3e7-23c0c70f5ede@gmail.com>
Date:   Fri, 24 Apr 2020 12:23:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424093720.GA3542@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lee,

On 24/04/20 11:37 am, Lee Jones wrote:
> On Fri, 24 Apr 2020, saravanan sekar wrote:
>
>> Hi Lee,
>>
>> On 24/04/20 9:18 am, Lee Jones wrote:
>>> On Wed, 15 Apr 2020, Saravanan Sekar wrote:
>>>
>>>> mp2629 is a highly-integrated switching-mode battery charge management
>>>> device for single-cell Li-ion or Li-polymer battery.
>>>>
>>>> Add MFD core enables chip access for ADC driver for battery readings,
>>>> and a power supply battery-charger driver
>>>>
>>>> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
>>>> ---
>>>>    drivers/mfd/Kconfig        |  9 ++++
>>>>    drivers/mfd/Makefile       |  2 +
>>>>    drivers/mfd/mp2629.c       | 86 ++++++++++++++++++++++++++++++++++++++
>>>>    include/linux/mfd/mp2629.h | 19 +++++++++
>>>>    4 files changed, 116 insertions(+)
>>>>    create mode 100644 drivers/mfd/mp2629.c
>>>>    create mode 100644 include/linux/mfd/mp2629.h
>>> How is this driver registered?
>>>
>>> Looks like it has device tree support.  Is there another way?
>> Yes, only using device tree
> Then how about using 'simple-mfd' and 'syscon'?
>
> Then you can omit this driver completely.
The exception is to support for non device tree platform as well, but I 
have tested only for ARM device tree platform.
>
>>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>>>> index 3c547ed575e6..85be799795aa 100644
>>>> --- a/drivers/mfd/Kconfig
>>>> +++ b/drivers/mfd/Kconfig
>>>> @@ -434,6 +434,15 @@ config MFD_MC13XXX_I2C
>>>>    	help
>>>>    	  Select this if your MC13xxx is connected via an I2C bus.
>>>> +config MFD_MP2629
>>>> +	tristate "Monolithic power system MP2629 ADC and Battery charger"
>>>> +	depends on I2C
>>>> +	select REGMAP_I2C
>>>> +	help
>>>> +	  Select this option to enable support for monolithic power system
>>>> +	  battery charger. This provides ADC, thermal, battery charger power
>>>> +	  management functions on the systems.
