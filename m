Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858DD1B6EF0
	for <lists+linux-iio@lfdr.de>; Fri, 24 Apr 2020 09:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgDXH01 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Apr 2020 03:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgDXH00 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Apr 2020 03:26:26 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2CEC09B045;
        Fri, 24 Apr 2020 00:26:26 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k1so9525274wrx.4;
        Fri, 24 Apr 2020 00:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=NFJ2CjEKQhv/0TAR3pwLkZY2gsYQyKKKyfkiPlPvBQQ=;
        b=ukNGwQa97mmtXUf3Wvw2qYiO6+TBGZ73gyg/gi7m58B12GeeNTbj3jmRS1ymjb2UiP
         mBGNP+4yD9T1/CZkJNNnVLGhKcM3OweiL3yM8nSQnk8dmbfaUajP6ZsSgbbK0HPHu9Et
         cv5qMv77i/spYo6wj/qDJsRr7EGhcKerSh6Y7liN1Za4u3WGejHlzfTfUvVkd4eaZBY7
         lNxwl/p6cp7u3LfzXkBG/fYu/8jgRB2Vf/SWVLU6S6zsWWD3Mbcw1aI7rcxfh+aRThjd
         CL/drU+FLR21edCRRB4Mg9QQmDZ7ks5XyLnRJbkGFX67L2WmEkeE+c0mhfK9TONA4NZv
         9CVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NFJ2CjEKQhv/0TAR3pwLkZY2gsYQyKKKyfkiPlPvBQQ=;
        b=ZPjIC82mEnDVXmYzsuklqSa0j2d2JspNYv8gfr8M1XLlUvHMJEfXYqCVNhYYfTN/9m
         bfixHJpGYF6aPNRQrqAQD/kOhNnIzgH0lA5CZnjuLMGd4Uu70Mpu3MiIHb6LwF1Pt2KE
         DdXYQ3LifSSYjk7Kmn7+zSis3JsEm5bFsh2SLeBSAbjtfQsqbGFIFcIca+KacWwo3u3D
         yh7FMv1l4u6Xc05JzqghBoCfhV43T1xYSnGYPzdC4+nDAGnANSnNmAw/ZP7sY0XmQtBj
         H/hZQ12Ew+L9ybNGhpeRSDfZoKExGti/VzA0qxqXMaPudI3pGLax4OZotEpDG40yPI4t
         2LmA==
X-Gm-Message-State: AGi0PuZPseqtxSTqFneqDhU741Lzwajs1/enEYaR8YvEgu7PtoV67BLc
        OZ1KYnk/nrtcuSI2RW2LYjUe0ffM
X-Google-Smtp-Source: APiQypJ2HKrH2hUpNGGovVNqAa1SM56E4hlnQbhhU4EhvitWGHwyrESvDLe7yoT+QHqmjNIb3SWLrQ==
X-Received: by 2002:a5d:490f:: with SMTP id x15mr8998036wrq.37.1587713184651;
        Fri, 24 Apr 2020 00:26:24 -0700 (PDT)
Received: from [192.168.0.104] (p5B3F694A.dip0.t-ipconnect.de. [91.63.105.74])
        by smtp.gmail.com with ESMTPSA id u3sm6902341wrt.93.2020.04.24.00.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 00:26:23 -0700 (PDT)
Subject: Re: [PATCH v9 2/6] mfd: mp2629: Add support for mps battery charger
To:     Lee Jones <lee.jones@linaro.org>
Cc:     andy.shevchenko@gmail.com, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20200415162030.16414-1-sravanhome@gmail.com>
 <20200415162030.16414-3-sravanhome@gmail.com> <20200424071822.GM3612@dell>
From:   saravanan sekar <sravanhome@gmail.com>
Message-ID: <8ff17d07-8030-fcfe-8d8a-3011e4077778@gmail.com>
Date:   Fri, 24 Apr 2020 09:26:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424071822.GM3612@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lee,

On 24/04/20 9:18 am, Lee Jones wrote:
> On Wed, 15 Apr 2020, Saravanan Sekar wrote:
>
>> mp2629 is a highly-integrated switching-mode battery charge management
>> device for single-cell Li-ion or Li-polymer battery.
>>
>> Add MFD core enables chip access for ADC driver for battery readings,
>> and a power supply battery-charger driver
>>
>> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
>> ---
>>   drivers/mfd/Kconfig        |  9 ++++
>>   drivers/mfd/Makefile       |  2 +
>>   drivers/mfd/mp2629.c       | 86 ++++++++++++++++++++++++++++++++++++++
>>   include/linux/mfd/mp2629.h | 19 +++++++++
>>   4 files changed, 116 insertions(+)
>>   create mode 100644 drivers/mfd/mp2629.c
>>   create mode 100644 include/linux/mfd/mp2629.h
> How is this driver registered?
>
> Looks like it has device tree support.  Is there another way?
Yes, only using device tree
>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index 3c547ed575e6..85be799795aa 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -434,6 +434,15 @@ config MFD_MC13XXX_I2C
>>   	help
>>   	  Select this if your MC13xxx is connected via an I2C bus.
>>   
>> +config MFD_MP2629
>> +	tristate "Monolithic power system MP2629 ADC and Battery charger"
>> +	depends on I2C
>> +	select REGMAP_I2C
>> +	help
>> +	  Select this option to enable support for monolithic power system
>> +	  battery charger. This provides ADC, thermal, battery charger power
>> +	  management functions on the systems.
