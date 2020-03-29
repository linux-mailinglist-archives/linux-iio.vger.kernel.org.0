Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60390196C8A
	for <lists+linux-iio@lfdr.de>; Sun, 29 Mar 2020 12:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgC2Kh6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Mar 2020 06:37:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52314 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgC2Kh6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Mar 2020 06:37:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id z18so16534300wmk.2;
        Sun, 29 Mar 2020 03:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=71RlhCSY8oNNUxnE6bOWCXws7Gp/rPuisSxtRcSLemY=;
        b=YZtvYKa698h+YWJETGtThKPWyClMiN3dTJaekhReiBHmyxVGVuu9cA+QnomoZFeRJC
         AgocSSl59oiolVhdq5Y4jf8X9+Fazyy54pafM/roUfKuSD9k2NjL067ZKwNESP82WBwC
         NLphcV1Hr3ETawfKgOGgv8HrKjzGMlVXZtWUvyApPf8mm+x1cTXR3ZYAVtyD83aaN8Yc
         97RcdB1QEnincTtBPv+OE9rFfFjVs+Ap5z169xTIUKlIyBQ6pmBzzgRXVt0rpxK24NvA
         9Htk6d/NBwCUNyAMnauO1MksLAyIRNtNmP5dCKBOr9TOmmzszwgzNKcUcFvY/FH1sTNQ
         OaGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=71RlhCSY8oNNUxnE6bOWCXws7Gp/rPuisSxtRcSLemY=;
        b=tsuYU8Gz7sOaD0Uj9i63ozjlrayQNYS3YMOoJeKZdDdxuhN5AwIM9MXNk7w0TASYsd
         /j9xSipPwZ5bR39nIMHSzHfhasya8wZYkQ8e4zVDru5TwJaCUxw6VOZG+booOlBY8lza
         eaIIdPNxSAf3yl5wJ2Xce1GOvBitZTX9iSkPRCn2gFxVouRmLSNxVlk89JZqaCNww64e
         ubLEmhg5+iIQ3D2JQ5efJkXnLnPM0AWTqMr3RMsBe507q3+IlEzn80aG8ekaPjPyDgUA
         GJTpBDTOiW61j0LM//IH0Z1IkuqGKHI8U7d7AJMuCDfAQEC44VurNN2At8r9A5KvWlkb
         DESA==
X-Gm-Message-State: ANhLgQ0wmG7vekIxcuIGNEXkg7LPyZ9GMGhjPWL7FVyC1MHKwMfzCvTj
        po5B7YGkuCErQdhutFff5ievzYoY
X-Google-Smtp-Source: ADFU+vuSdRNxHZDjZD9gGezVPtBI3guMBw8gt4hGVsgmP/7sbPLnEBYFnRwcxUI5IBtFdsedAafigw==
X-Received: by 2002:a1c:68d5:: with SMTP id d204mr7904068wmc.15.1585478275203;
        Sun, 29 Mar 2020 03:37:55 -0700 (PDT)
Received: from [192.168.0.104] (p5B3F6BD9.dip0.t-ipconnect.de. [91.63.107.217])
        by smtp.gmail.com with ESMTPSA id l17sm17383372wrm.57.2020.03.29.03.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2020 03:37:54 -0700 (PDT)
Subject: Re: [PATCH v4 3/5] iio: adc: mp2629: Add support for mp2629 ADC
 driver
To:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20200322224626.13160-1-sravanhome@gmail.com>
 <20200322224626.13160-4-sravanhome@gmail.com>
 <CAHp75VfauHuAv1Wr=7ga=G+6JOYXuop_oyXiwmQgKeB2e_z=tQ@mail.gmail.com>
 <20200328144234.081b964f@archlinux>
From:   saravanan sekar <sravanhome@gmail.com>
Message-ID: <d6852a20-157b-ea51-7def-f11b5d1c81fe@gmail.com>
Date:   Sun, 29 Mar 2020 12:37:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200328144234.081b964f@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On 28/03/20 3:42 pm, Jonathan Cameron wrote:
> On Mon, 23 Mar 2020 01:32:34 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
>> On Mon, Mar 23, 2020 at 12:47 AM Saravanan Sekar <sravanhome@gmail.com> wrote:
>>> Add support for 8-bit resolution ADC readings for input power
>>> supply and battery charging measurement. Provides voltage, current
>>> readings to mp2629 power supply driver.
>> ...
>>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/of_device.h>
>> Don't see users of it.
Forgot to reply, its needed since I used struct of_device
"error: field name not in record or union initializer
   { .compatible = "mps,mp2629_charger"},"
>>> +#include <linux/module.h>
>>> +#include <linux/mutex.h>
>>> +#include <linux/regulator/consumer.h>
>>> +#include <linux/sysfs.h>
>> Any users?
>>
>>> +#include <linux/regmap.h>
>> Perhaps ordered?
>>
>>> +#include <linux/iio/iio.h>
>>> +#include <linux/iio/machine.h>
>>> +#include <linux/iio/driver.h>
>> + blank line?
>>
>>> +#include <linux/mfd/mp2629.h>
>> ...
>>
>>> +static int mp2629_read_raw(struct iio_dev *indio_dev,
>>> +                       struct iio_chan_spec const *chan,
>>> +                       int *val, int *val2, long mask)
>>> +{
>>> +       struct mp2629_adc *info = iio_priv(indio_dev);
>>> +       unsigned int rval;
>>> +       int ret;
>>> +
>>> +       switch (mask) {
>>> +       case IIO_CHAN_INFO_RAW:
>>> +               ret = regmap_read(info->regmap, chan->address, &rval);
>>> +               if (ret < 0)
>>> +                       return ret;
>>> +
>>> +               if (chan->address == MP2629_INPUT_VOLT)
>>> +                       rval &= 0x7f;
>> GENMASK() ?
>>
>>> +               *val = rval;
>>> +               return IIO_VAL_INT;
>>> +       return 0;
>>> +}
>> ...
>>
>>> +       void **pdata = pdev->dev.platform_data;
>> Same Qs as per other patch.
>>
>> ...
>>
>>> +       indio_dev->dev.of_node = pdev->dev.of_node;
>> Jonathan, doesn't IIO core do this for all?
>>
> Nope.  I'm not totally sure it's always safe to do so
> as we have some weird parent structures in some cases.
> A quick grep suggests that we may be fine though, or
> alternatively be able to get away with a set it if not
> already set approach.
>
> I'll take a look when I get some time. It would be nice
> to clean this up.
>
> Jonathan
>
>
>
>
