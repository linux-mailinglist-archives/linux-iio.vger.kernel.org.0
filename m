Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27411DF728
	for <lists+linux-iio@lfdr.de>; Sat, 23 May 2020 14:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387770AbgEWMUL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 May 2020 08:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbgEWMUK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 23 May 2020 08:20:10 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AD4C061A0E;
        Sat, 23 May 2020 05:20:10 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l5so11373142edn.7;
        Sat, 23 May 2020 05:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0eDh4QSckHASr5gJNa93QIawwkukXovHo+mlHmY4Lhs=;
        b=abXODuSDPU+tSd/aKAtdwD4ZmcwhOK6kZpXLE+1Mt/0RNH7RLOueH2k+wCQRqgCtT6
         YfKQDXCg07z+3VvEoz2zDnJnqF8w5WVgb6Lg32BuTYrgqjSlxQWab/q2OZ8lvyN0hs7G
         HixW5Lu0fGx9fL39/3dDxIUlu+rdiw8LWY4Q91wN/6cxtfgV1zvR/YpySJeQutRwWUue
         5A+a8Z/BPcebwaO6RDIcYHasM8pU/9k7F+t5dIAJGlxzqusMn4qxnaRTNbCT1y/+X6fY
         8aMfms1rfJ3NNr2wde8rPzS1o6TtajZvnkxVPcK14+2OfA9aM7fOqJBvJqdo1kJSedos
         bApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0eDh4QSckHASr5gJNa93QIawwkukXovHo+mlHmY4Lhs=;
        b=SG9DgMlDKwz32k12Rt44EcUAaAvyK6879Tf5h2Ud2jlJt3GVdxm+NsUlY5Al2WkV9i
         0agLNwpxToNP7OtFeVpvpDLWuEqXiBZcsNPxH+Nk337WIhVNs6YJS+z7l7/wK7SjAw5F
         vWZGJuNT0wX5ub3iHB1I7w6mbfcWQgegbRszO/070j4jpRfo/jgvZar5JSFKVUJmUkZ2
         r0LdkMgnI5uqXfBi9GBp9t/z5NYbvR6YUr1zwRLorxj6VD73TGw3ve6a8x6S5ljvSRIj
         o92s7tZzyu5u0kyaRD/7qlD44dyh7q6Rx1hmZtOA1i0rar1YoNXh6MgpGfv1rKSU1JlW
         9QtA==
X-Gm-Message-State: AOAM531cfnyAu2Eqxgky0WHhMHgt53203nQuFD6vgnEdA5IAFDk/R61h
        rhnvXyybfAiqRVcCyYUaTFVMQqA1220=
X-Google-Smtp-Source: ABdhPJw0WWrU6MYwaQyjtRK0gQ22IEoCRNxXM7wU4niVLiDiVFKlpp+B5SscpiO/jz0dd9+0GzUcQw==
X-Received: by 2002:a50:f086:: with SMTP id v6mr7192187edl.140.1590236408350;
        Sat, 23 May 2020 05:20:08 -0700 (PDT)
Received: from [192.168.0.104] (p5dcfec14.dip0.t-ipconnect.de. [93.207.236.20])
        by smtp.gmail.com with ESMTPSA id h12sm10038898ejk.103.2020.05.23.05.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2020 05:20:07 -0700 (PDT)
Subject: Re: [PATCH v11 2/6] mfd: mp2629: Add support for mps battery charger
To:     Lee Jones <lee.jones@linaro.org>
Cc:     andy.shevchenko@gmail.com, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20200430155810.21383-1-sravanhome@gmail.com>
 <20200430155810.21383-3-sravanhome@gmail.com> <20200519103741.GW271301@dell>
From:   saravanan sekar <sravanhome@gmail.com>
Message-ID: <75b6a2ee-2d90-17c2-4b2b-0ef6238e903e@gmail.com>
Date:   Sat, 23 May 2020 14:20:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200519103741.GW271301@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lee,

On 19/05/20 12:37 pm, Lee Jones wrote:
> On Thu, 30 Apr 2020, Saravanan Sekar wrote:
>
>> mp2629 is a highly-integrated switching-mode battery charge management
>> device for single-cell Li-ion or Li-polymer battery.
>>
>> Add MFD core enables chip access for ADC driver for battery readings,
>> and a power supply battery-charger driver
>>
>> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/mfd/Kconfig        |  9 +++++
>>   drivers/mfd/Makefile       |  2 +
>>   drivers/mfd/mp2629.c       | 79 ++++++++++++++++++++++++++++++++++++++
>>   include/linux/mfd/mp2629.h | 17 ++++++++
>>   4 files changed, 107 insertions(+)
>>   create mode 100644 drivers/mfd/mp2629.c
>>   create mode 100644 include/linux/mfd/mp2629.h
> For my own reference (apply this as-is to your sign-off block):
>
>    Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
>
Do I have to resend with above sign-off in all the patch?

Thanks,
Saravanan

