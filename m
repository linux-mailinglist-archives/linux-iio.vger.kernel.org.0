Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 297A419652A
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 11:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgC1Kvw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 06:51:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37142 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgC1Kvw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2020 06:51:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id d1so15469796wmb.2;
        Sat, 28 Mar 2020 03:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=CrB7hChct8YLBNmo5avC5w/PuNzmnd//1glq7fHk6TM=;
        b=CovJ+3Tpjf8ERpUVrsYMJKptI0wC9hKOLPxZworOvWdw0kyGNqaLgDFFkm6ryda6OT
         NLOijCVlpv9NEOzwr2dXJV6BNyPOAdJgWywVvSNkcfJ0S+ACd8R2It43UAgi/DVJJGZb
         WtkK5erM1gX35Xt2GAKTECkCa2giPd8r7SYjMgEk5zsml0+GCxS8ClxV8xShP8BP/wLo
         6JcorhalEQr3ZRQIQ3N5QQwMva2/qbzkjI4BkOQj7sRJog/tSeovdh6GtitWq7C84itb
         Ob5PGN8gBKjhDDjO47PajBjZqmtL7YSJng/pa+6CxENA/ZlMRJFJJbgtEt+2lJNlCdIr
         Fg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=CrB7hChct8YLBNmo5avC5w/PuNzmnd//1glq7fHk6TM=;
        b=Thlut5/Ik8I1UQ/Nna+i1YEMI+tkp7He4iNoRtgWjljhKNospFTvO77zyA1YdzVhii
         8XqEP0yEQS+0JgpM5T3YTZTm8TrRnaHScWsev039HNSKujMng0i2uZ//O2f3aI2gV0Pz
         QtCWqxzGKvejYy7JQJFpPJI0CCEMTPEbUEx3DXafcuZJ/JZb7t28gOnMbxRZaQs6oTbR
         Lpmt8W9MUb8KShCJzoG4SKOEmWL5uaPYVNh0+YEwi7gRphDNNFy51fePh7cP7m0TIb9g
         oNqZoDdyAOR5TExDlKgEVBtazMqXaGZCVBKnaBU1ZEzp6Q+GdS/rcPeRywYwmm7zzBvE
         ugZg==
X-Gm-Message-State: ANhLgQ2KOPTIwgUgY+osIC/HmW/GH+KDAJRQ4WkjOU5181hXdTbM1KY4
        5TAGVXg6Q2sBYW+DvSGi3BrKGpJYWt0=
X-Google-Smtp-Source: ADFU+vuyKNobJYIfD7PFdo9VloJ7brt6x2RpOInkZIt+QFAqK8FrNaldzhW7FQwhGJl80goM4vCk9Q==
X-Received: by 2002:a1c:8090:: with SMTP id b138mr3491996wmd.55.1585392709492;
        Sat, 28 Mar 2020 03:51:49 -0700 (PDT)
Received: from [192.168.0.104] (p5DCFFF1C.dip0.t-ipconnect.de. [93.207.255.28])
        by smtp.gmail.com with ESMTPSA id r3sm12374398wrm.35.2020.03.28.03.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2020 03:51:48 -0700 (PDT)
Subject: Re: [PATCH v5 2/5] mfd: mp2629: Add support for mps battery charger
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
References: <20200328001154.17313-1-sravanhome@gmail.com>
 <20200328001154.17313-3-sravanhome@gmail.com>
 <CAHp75Vdc4MxMnmd_h6eFfZAji=4fir7x7bq2MX1q50nAQ1eJ=Q@mail.gmail.com>
From:   saravanan sekar <sravanhome@gmail.com>
Message-ID: <23c39834-c2d9-5634-b9d7-8f9e16194752@gmail.com>
Date:   Sat, 28 Mar 2020 11:51:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vdc4MxMnmd_h6eFfZAji=4fir7x7bq2MX1q50nAQ1eJ=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On 28/03/20 11:45 am, Andy Shevchenko wrote:
> On Sat, Mar 28, 2020 at 2:12 AM Saravanan Sekar <sravanhome@gmail.com> wrote:
>> mp2629 is a highly-integrated switching-mode battery charge management
>> device for single-cell Li-ion or Li-polymer battery.
>>
>> Add MFD core enables chip access for ADC driver for battery readings,
>> and a power supply battery-charger driver
> ...
>
>> +#ifndef __MP2629_H__
>> +#define __MP2629_H__
>> +#include <linux/device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/types.h>
> None of these header is in use here.
>
> struct device;
> struct regmap;
>
> would be enough.

Yesterday I conveyed to you that Lee is not recommended to use forward 
declaration and asked me

to use includes, then you agreed with the same. Again same comments !! 
sorry I am lost.

>> +struct mp2629_info {
>> +       struct device *dev;
>> +       struct regmap *regmap;
>> +};
>> +
>> +#endif
