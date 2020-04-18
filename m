Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5D71AF044
	for <lists+linux-iio@lfdr.de>; Sat, 18 Apr 2020 16:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgDROtK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Apr 2020 10:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728806AbgDROtJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Apr 2020 10:49:09 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64D3C061A0C;
        Sat, 18 Apr 2020 07:49:08 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id r7so5038701ljg.13;
        Sat, 18 Apr 2020 07:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ImPNJwime7TJeT3XgQ4z2h1a6tJfIAzafk9Ipn78EOg=;
        b=eg/8RqtP8hp6m7VDX1kTRMtrNrn1z70pYwGd/UzVfwFqeb4xmdgkKUk1xpuk91Lf4v
         8sLczYmjJMBMdQfuCSRQ1NPTFndUB9MT/fIJRjS8RwF72o1bZ1/U7uFSCKWuayGh1sJ+
         xItBrIIuO6Dr2oVbiwDdhZnKfIatfhVvYYln03eijheBTYM9aA+MTUHZYCUQSJ+/l+pb
         1ErXV7tP12Jqyf/WFPY72xJCGfosXqRuZf9Ho5k4NXRWe6Zy7neH9L5E0IuXZNahTWim
         napSNjb85uraVBazBeWYw82J8AeZOBIbTKcA/9k8r5SpNW4KlJFEwwufFmcgO674zVMj
         l6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ImPNJwime7TJeT3XgQ4z2h1a6tJfIAzafk9Ipn78EOg=;
        b=kHlcy0f2SmlqdcFWjvQ8B+X9FL+MfbB6r9qtaSHeZOivhhockh5MANE3YUgDjdKXah
         a2ggfleFxKrtxPXytq8YTCEds28jQBsY8LUKtTc5NXWEcsSbB1Zw9sJhKGi/bvEsiJhl
         jMuLaEG5EY0gI13aEir7t260Ck/gYk3LKGLLNSzJQryirG7TzaX7DHnm/ONpbAt7N4Bv
         TAcqE+EIaROrxf2SYGF1g2BdRu3Aod/GqFPqUnQ+7JOTQf4Lo3ItWQLgUuQPDPhSHio4
         ztRZOhdDKsgDPNBVe091fxJamnqgZkK+LdBl2YyuIPtf/vjI22U3NwX2OO6jAEMd97+f
         i4jQ==
X-Gm-Message-State: AGi0PuajBJDMZaRuODHfJFt+5b78VQZy6rIdcQ2vxXUs/+D2KAuIGQ/k
        5C7mWi8X3W6s5B+Zlemgz6NgfsCs
X-Google-Smtp-Source: APiQypLwEs7WDsF7ida5jFoiQ53ASvaaT79S8m1jg1ou7DTPKRtgoHuDnQ7nNbKv+K/Kg83foi15lg==
X-Received: by 2002:a2e:2a85:: with SMTP id q127mr4925603ljq.273.1587221347209;
        Sat, 18 Apr 2020 07:49:07 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id q6sm12647849ljg.67.2020.04.18.07.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 07:49:06 -0700 (PDT)
Subject: Re: [PATCH v1] iio: magnetometer: ak8974: Silence deferred-probe
 error
To:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
References: <20200414222713.32660-1-digetx@gmail.com>
 <CACRpkdY_J8e127etFFYkoxLDDkc334Xgg8ZbapdU36oGsaZ08g@mail.gmail.com>
 <e08c487c-5c2a-3172-7c9c-0e7d2cd51769@gmail.com>
 <CACRpkdbMF4=-g2ic_SKgOkd6kfgKJqZ2UxCRaoXJjq0EiEn+pw@mail.gmail.com>
 <26f96265-c699-66aa-ec70-becd868bb795@gmail.com>
 <20200418153730.1e1d01ef@archlinux>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <33f96a81-dc45-6eb0-5f88-317a421c04b2@gmail.com>
Date:   Sat, 18 Apr 2020 17:49:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200418153730.1e1d01ef@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

18.04.2020 17:37, Jonathan Cameron пишет:
> On Thu, 16 Apr 2020 20:35:56 +0300
> Dmitry Osipenko <digetx@gmail.com> wrote:
> 
>> 16.04.2020 19:51, Linus Walleij пишет:
>>> On Thu, Apr 16, 2020 at 4:45 PM Dmitry Osipenko <digetx@gmail.com> wrote:  
>>>> 16.04.2020 14:33, Linus Walleij пишет:  
>>>   
>>>>> This misses some important aspects of dev_dbg(), notably this:
>>>>>
>>>>> #if defined(CONFIG_DYNAMIC_DEBUG)
>>>>> #define dev_dbg(dev, fmt, ...)                                          \
>>>>>         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
>>>>> #elif defined(DEBUG)
>>>>> #define dev_dbg(dev, fmt, ...)                                          \
>>>>>         dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
>>>>> #else
>>>>> #define dev_dbg(dev, fmt, ...)                                          \
>>>>> ({                                                                      \
>>>>>         if (0)                                                          \
>>>>>                 dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
>>>>> })
>>>>> #endif
>>>>>
>>>>> If DEBUG is not defined the entire dev_dbg() message is enclodes in if (0)
>>>>> and compiled out of the kernel, saving space. The above does not
>>>>> fulfil that.  
>>>>
>>>> Hello Linus,
>>>>
>>>> After some recent discussions in regards to the EPROBE_DEFER handling,
>>>> Thierry Reding suggested the form which is used in my patch and we
>>>> started to use it recently in the Tegra DRM driver [1]. The reason is
>>>> that we don't want to miss any deferred-probe messages under any
>>>> circumstances, for example like in a case of a disabled DYNAMIC_DEBUG.  
>>>
>>> I have a hard time to accept this reasoning.
>>>
>>> Who doesn't feel that way about their subsystem? If you don't want
>>> to miss the message under any circumstances then use dev_info().
>>> Don't override the default behaviour of dev_dbg().
>>>   
>>>> The debug messages are usually disabled in a release-build and when not
>>>> a very experienced person hands you KMSG for diagnosing a problem, the
>>>> KMSG is pretty much useless if error is hidden silently.  
>>>
>>> So use dev_info().
>>>   
>>>> By moving the message to a debug level, we reduce the noise in the KMSG
>>>> because usually people look for a bold-red error messages. Secondly, we
>>>> don't introduce an additional overhead to the kernel size since the same
>>>> text is reused for all error conditions.  
>>>
>>> dev_info() is not supposed to be an error message, it is supposed to
>>> be information, so use that.  
>>
>> Okay, I'll make a v2. Thank you for the review.
> 
> Ah I commented on this in v2 - now I see why you did it :)
> Nope to dev_info. That will often spam normal logs and as Andy pointed
> out for v2 that can be dozens of entries on a sophisticated board.  Much
> better to stick to dev_dbg but I'd like to see it done explicitly in the
> form you mention with the if / else

Alright, I'll make a v3.

