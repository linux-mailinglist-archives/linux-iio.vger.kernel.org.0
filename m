Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0316A1AE0D3
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 17:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgDQPOv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 11:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728272AbgDQPOu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 11:14:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E655FC061A0C;
        Fri, 17 Apr 2020 08:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=YfcdpQWtKsaw+yPCSMjyubrORmj0oCIV+0oQZL7RWS0=; b=XASgXQK5pLpEHZkviFU71mEj+0
        yWwsFWDyefLn55gU9UbpLBPsyW8Ga+ODuvzm67RJRnuJeBJWZ6BOJG+XY28jwGaWYaSSRdysqksNm
        CQisXfnjZsko3uHUDiHf89Cq6+IFII07ctHPYxMGo6/g/4wsHNmPnqMAj0idTtunEMmeUegwel1pf
        NWZ66er5+AXg1u1yPuWfuTW28JZUAthvPg31VhS95B4j/szxhSNeEn914yeLudR3FISpqCOvWPXfo
        aB/D7f6MQv2ooen6IA56FniP1G0WLD2NAKAI91alpDt6PK7IbxQ3bllskHnmtpPiz1hcLxBSvot1h
        IylDvzeQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPShe-0006IA-Mv; Fri, 17 Apr 2020 15:14:50 +0000
Subject: Re: [PATCH v10 3/6] iio: adc: mp2629: Add support for mp2629 ADC
 driver
To:     saravanan sekar <sravanhome@gmail.com>, lee.jones@linaro.org,
        andy.shevchenko@gmail.com, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
References: <20200417085003.6124-1-sravanhome@gmail.com>
 <20200417085003.6124-4-sravanhome@gmail.com>
 <a8da9a3d-93a5-b926-b8c0-84138b59ad4f@infradead.org>
 <2b4c7de2-aa85-65aa-be5e-3daed689c44d@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f1e85fcd-e5e5-798c-6093-a195c5cbc08a@infradead.org>
Date:   Fri, 17 Apr 2020 08:14:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2b4c7de2-aa85-65aa-be5e-3daed689c44d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/17/20 7:51 AM, saravanan sekar wrote:
> Hi Randy,
> 
> On 17/04/20 4:35 pm, Randy Dunlap wrote:
>> Hi--
>>
>> On 4/17/20 1:50 AM, Saravanan Sekar wrote:
>>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>>> index 82e33082958c..ef0c0cd31855 100644
>>> --- a/drivers/iio/adc/Kconfig
>>> +++ b/drivers/iio/adc/Kconfig
>>> @@ -680,6 +680,16 @@ config MESON_SARADC
>>>         To compile this driver as a module, choose M here: the
>>>         module will be called meson_saradc.
>>>   +config MP2629_ADC
>>> +    tristate "Monolithic MP2629 ADC driver"
>>> +    depends on MFD_MP2629
>>     depends on I2C
>> ?
> 
> Made "depends on I2C" in MFD_MP2629, hope not needed becomes redundant here
> 
> Thanks,
> Saravanan

I see. Thanks for explaining.

>>> +    help
>>> +      Say yes to have support for battery charger IC MP2629 ADC device
>>> +      accessed over I2C.
>>> +
>>> +      This driver provides ADC conversion of system, input power supply
>>> +      and battery voltage & current information.
>>> +
>>>   config NAU7802
>>>       tristate "Nuvoton NAU7802 ADC driver"
>>>       depends on I2C
>> thanks.


-- 
~Randy

