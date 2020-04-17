Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F181AE033
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 16:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgDQOv4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 10:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbgDQOv4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 10:51:56 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C204EC061A0C;
        Fri, 17 Apr 2020 07:51:55 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id v8so5123620wma.0;
        Fri, 17 Apr 2020 07:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=YW/m6LvUDm14fECG63jq0+bjFbSb+5TTFXaHDDYWM/I=;
        b=oO/L3FvsHa0vf+P7DWAUzHQ73QNVuxOPnvkTd4rT9phupOkapPvk070rBoZgW+xy0D
         bBraLamFCmnbcrAlrsiYyoRk5rmJWIOv+h2e2oMorq7g6AIw0S54ZrFGYkzkW/8ysGCR
         467XRqy/nIN30SDMW5CFaebYQ3CZW3aFWT4U3yXgvtvF9ZAiMHwDHSfBNAKbHdwPfqKn
         mYQxjNxlIlIg8bZGI9+qDFgv4TImLGRZ01pkiG82Jzd6zxQwXlAiiGvMNmmoyHe1kIQx
         yY7bBcV1S6viIAdabkna4ltna5nQvqL/lIm9z6oh4V9h4TR1oxJV2GRNcwIWeT1yYWXo
         Jl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YW/m6LvUDm14fECG63jq0+bjFbSb+5TTFXaHDDYWM/I=;
        b=U6zANE1LVAItm4jndZPzbd9JlqfTiPmzJCDS2jNNjfRtEfe3EoSgUz5EFYtIoYRy7m
         PPJMPjxvBZdVg2TEbkZdQgM9/phVbZG+OL7N7nAQhFfkaAUIVBr4eA/u9gLAMugQSdMw
         jIxgOL+MRyH6XsmeT9h7OCEjb2NRP57PA9TSvWY79JezZY9qBbyMgtzrV4MpcAVC8HIE
         RwO0DQqLbd51dEvrB/I0+r1eOUmUjUbSzVETvJ/a+a1pzsDLkSlGwqKDBC4++lmplzpb
         hjP0kOaO9bZqzPN4Dua7E7AK0IlJNWJmNd3u3RkES2pyhrmxW3+A/hdr8RgrnirYhrcY
         nEHQ==
X-Gm-Message-State: AGi0PuYXEIk1XCNSwvqenP9yOPrCTItRb9TYpX3y+M9iSyDRnjqOVuMk
        kfQQIlCCZ4gGZy9kcAYPzxoJ8yhx
X-Google-Smtp-Source: APiQypKAbsG2v1WQaLKRNFkDILulw/SdGDc5V6hyWNsZ+JF7kgVocqLc55OPtZ0/P5FUUcIX5qPzzg==
X-Received: by 2002:a7b:cb59:: with SMTP id v25mr3769643wmj.139.1587135114085;
        Fri, 17 Apr 2020 07:51:54 -0700 (PDT)
Received: from [192.168.0.104] (p5B3F7443.dip0.t-ipconnect.de. [91.63.116.67])
        by smtp.gmail.com with ESMTPSA id i25sm8298407wml.43.2020.04.17.07.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2020 07:51:53 -0700 (PDT)
Subject: Re: [PATCH v10 3/6] iio: adc: mp2629: Add support for mp2629 ADC
 driver
To:     Randy Dunlap <rdunlap@infradead.org>, lee.jones@linaro.org,
        andy.shevchenko@gmail.com, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
References: <20200417085003.6124-1-sravanhome@gmail.com>
 <20200417085003.6124-4-sravanhome@gmail.com>
 <a8da9a3d-93a5-b926-b8c0-84138b59ad4f@infradead.org>
From:   saravanan sekar <sravanhome@gmail.com>
Message-ID: <2b4c7de2-aa85-65aa-be5e-3daed689c44d@gmail.com>
Date:   Fri, 17 Apr 2020 16:51:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a8da9a3d-93a5-b926-b8c0-84138b59ad4f@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Randy,

On 17/04/20 4:35 pm, Randy Dunlap wrote:
> Hi--
>
> On 4/17/20 1:50 AM, Saravanan Sekar wrote:
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 82e33082958c..ef0c0cd31855 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -680,6 +680,16 @@ config MESON_SARADC
>>   	  To compile this driver as a module, choose M here: the
>>   	  module will be called meson_saradc.
>>   
>> +config MP2629_ADC
>> +	tristate "Monolithic MP2629 ADC driver"
>> +	depends on MFD_MP2629
> 	depends on I2C
> ?

Made "depends on I2C" in MFD_MP2629, hope not needed becomes redundant here

Thanks,
Saravanan

>> +	help
>> +	  Say yes to have support for battery charger IC MP2629 ADC device
>> +	  accessed over I2C.
>> +
>> +	  This driver provides ADC conversion of system, input power supply
>> +	  and battery voltage & current information.
>> +
>>   config NAU7802
>>   	tristate "Nuvoton NAU7802 ADC driver"
>>   	depends on I2C
> thanks.
