Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8CD1ACEC3
	for <lists+linux-iio@lfdr.de>; Thu, 16 Apr 2020 19:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgDPRgD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Apr 2020 13:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726207AbgDPRgA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Apr 2020 13:36:00 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B24C061A0C;
        Thu, 16 Apr 2020 10:35:59 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v9so8674820ljk.12;
        Thu, 16 Apr 2020 10:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s5+mQ8PRD4Xuh/sg6Yq5khXNgkKUys7E4hCzlBLjTQ4=;
        b=MZtUi+fNkH6D8qF/APDSAPqjrQD5Q3rwdqHhtK6UiLVLOEcYhUUuan6dsWuZ6rkUtK
         YwlGKT9q7CFwMlad4ryoE0Yh3q5GeTxcBknKFHIdOI3reFSGjq7mIpSX73nGcUSM8N3Q
         pJ9DtysQtqI8g2g/z7uUaVvlNwtY3Vd13+itMgctgGdDfW97qKv8WtKGjYPXYxCQyD8i
         CvtNLWkrZ9J1wr+eJFvU4Y7OmNZSnS/Pppyi212qPmn+dMaaB2E22cXDcC4G/q7HWSjf
         dSOsSaQpPuMHYo2OtnmkKejXQx2u5BC9JI4auG8JyVavXfJCWN4x+3+nmAb2PvGArcbT
         RbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s5+mQ8PRD4Xuh/sg6Yq5khXNgkKUys7E4hCzlBLjTQ4=;
        b=dMirb9JYOowU/q0Uz5uAxdWmQGuEM1dRvhUA5KJ5wmI2ZTY1m75lfdfheY0xelTR54
         L9V0SXy8OqcBDBgIZ/1BL5JvMdeQAVZe3Sy/NHFT/O6LSBD1gvKKy49wfYjbAeJHKmO0
         jpLOVSN0yrcMcg3HD1XlVflG5HVlV+rneUkGJ3hrqTjbzmKWDdZgiGMIoqO9eAmZJBse
         F+7MUzWCVpVy47aN9VbUw9rInm9wX8osEfOM4ZgJTvtjazsZfpeBvxA93hpZpsMkNuxg
         +7tV5FDtz802rQrQk6ZjZ3HGQwIKilzs4csXsnkSTjcG2tva/hnsUTJA/TnqZNI7FMrJ
         jxLw==
X-Gm-Message-State: AGi0PuYya3ECujMIJje38kLjw9Uu5/boWX+WOxjt0ml50vgJfcEgdPF7
        0I4VCn5MeNZBVU7M/gnfk/ilAjRp
X-Google-Smtp-Source: APiQypIkRdoN44kuZTN0QuMzpjRy7U9QjmgPMuUdmo/n4IU91fZxPIFuKTphq0yY1ZeSyM0CyI672Q==
X-Received: by 2002:a2e:a30c:: with SMTP id l12mr4700236lje.174.1587058558252;
        Thu, 16 Apr 2020 10:35:58 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id v26sm5005803lji.43.2020.04.16.10.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 10:35:57 -0700 (PDT)
Subject: Re: [PATCH v1] iio: magnetometer: ak8974: Silence deferred-probe
 error
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <26f96265-c699-66aa-ec70-becd868bb795@gmail.com>
Date:   Thu, 16 Apr 2020 20:35:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdbMF4=-g2ic_SKgOkd6kfgKJqZ2UxCRaoXJjq0EiEn+pw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

16.04.2020 19:51, Linus Walleij пишет:
> On Thu, Apr 16, 2020 at 4:45 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>> 16.04.2020 14:33, Linus Walleij пишет:
> 
>>> This misses some important aspects of dev_dbg(), notably this:
>>>
>>> #if defined(CONFIG_DYNAMIC_DEBUG)
>>> #define dev_dbg(dev, fmt, ...)                                          \
>>>         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
>>> #elif defined(DEBUG)
>>> #define dev_dbg(dev, fmt, ...)                                          \
>>>         dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
>>> #else
>>> #define dev_dbg(dev, fmt, ...)                                          \
>>> ({                                                                      \
>>>         if (0)                                                          \
>>>                 dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
>>> })
>>> #endif
>>>
>>> If DEBUG is not defined the entire dev_dbg() message is enclodes in if (0)
>>> and compiled out of the kernel, saving space. The above does not
>>> fulfil that.
>>
>> Hello Linus,
>>
>> After some recent discussions in regards to the EPROBE_DEFER handling,
>> Thierry Reding suggested the form which is used in my patch and we
>> started to use it recently in the Tegra DRM driver [1]. The reason is
>> that we don't want to miss any deferred-probe messages under any
>> circumstances, for example like in a case of a disabled DYNAMIC_DEBUG.
> 
> I have a hard time to accept this reasoning.
> 
> Who doesn't feel that way about their subsystem? If you don't want
> to miss the message under any circumstances then use dev_info().
> Don't override the default behaviour of dev_dbg().
> 
>> The debug messages are usually disabled in a release-build and when not
>> a very experienced person hands you KMSG for diagnosing a problem, the
>> KMSG is pretty much useless if error is hidden silently.
> 
> So use dev_info().
> 
>> By moving the message to a debug level, we reduce the noise in the KMSG
>> because usually people look for a bold-red error messages. Secondly, we
>> don't introduce an additional overhead to the kernel size since the same
>> text is reused for all error conditions.
> 
> dev_info() is not supposed to be an error message, it is supposed to
> be information, so use that.

Okay, I'll make a v2. Thank you for the review.
