Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE231AC6DF
	for <lists+linux-iio@lfdr.de>; Thu, 16 Apr 2020 16:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394512AbgDPOpy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Apr 2020 10:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730029AbgDPOpv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Apr 2020 10:45:51 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E92C061A0C;
        Thu, 16 Apr 2020 07:45:50 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id l11so5809166lfc.5;
        Thu, 16 Apr 2020 07:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EMXgclwzvBeN8dhyuWXSHFYbEOy8aRgDPr8zMlH4fbc=;
        b=XS2nQNy3i+gGy5SS5kmxTV/WpxQEDjrNebcEqBhzthvjDKS9q4IHMCI9uVlzrec0IE
         b072PDOKJDTfifT+DIFCkBf0WBZ+nsJoByvKxQ1M7SpUtSA4GJFlpeKlXv+h2idlnFYr
         p2kI2aZ2XfUqUGlZ31ItLVm+nHVHLmq/38SsddPbEgSNn7uvmC6Ajg8LekSvZcW1JNY4
         3A5vm2Jjtos9u+GUe1rDNKYzNcGTePbdodc4zrDARSNifOQL2fGEuVhy7o++zWgk72uk
         h+5FTH1zk2yGNptF82sqj2+RVQEBMUIIbri1Nu43kuTlAmJ2Vog7dXuz30w/Gcbq9qzA
         Re5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EMXgclwzvBeN8dhyuWXSHFYbEOy8aRgDPr8zMlH4fbc=;
        b=RPFgvpvtWvVOFJ4QsiaMjD0loGpk62GjdQWWieUiv7ucKJ/kqhR61q8yglOtrcD0vO
         23xZ1U7hbUlwLTZk++ZZrhBSeC+PkzjbGf1Hy0ja9pqtFATPGpTR6xhCh7Wqp82Bo2k3
         DTqM9SN+OR14DXHTYetd6fETnbwlo1+/WSwV2u56/pzmD4CwUbozcnHh/Cv52Z1+/qs+
         pu2g6Ni+E6gKOsOCYUlX8JbKDBLijdwX27aW83bGN8z+j5RKELIZVN2przHAFq+7uGuZ
         MV/yGrVePZ+/N4JZsMytrDqJ1vRpmNH013N1SIz33zDPYWfFPYPiTgO8blb4CcTY6AdM
         58Eg==
X-Gm-Message-State: AGi0PuZTtdpRELH8ppIntzGCDQYHPxZaBCDl7HmKf+Zu4z19ssFWi+Uj
        nbo0VbJFOU/KjqKY32l8hOQ=
X-Google-Smtp-Source: APiQypJ4Zcs8Bc0WXCZK+8tUqDvHcTuohVcFAV10Xg+moiS6oM46PjWRSTc6DbByzXv+HFfOi6VamA==
X-Received: by 2002:ac2:4d12:: with SMTP id r18mr6258629lfi.181.1587048348555;
        Thu, 16 Apr 2020 07:45:48 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id x24sm15308428lfc.6.2020.04.16.07.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 07:45:47 -0700 (PDT)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e08c487c-5c2a-3172-7c9c-0e7d2cd51769@gmail.com>
Date:   Thu, 16 Apr 2020 17:45:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdY_J8e127etFFYkoxLDDkc334Xgg8ZbapdU36oGsaZ08g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

16.04.2020 14:33, Linus Walleij пишет:
> Hi Dmitry,
> 
> thanks for your patch!
> 
> On Wed, Apr 15, 2020 at 12:27 AM Dmitry Osipenko <digetx@gmail.com> wrote:
> 
>> It's not uncommon that voltage regulator becomes available later during
>> kernel's boot process, in this case there is no need to print a noisy
>> error message. This patch moves the message about unavailable regulator
>> to the debug level in a case of the deferred-probe error and also amends
>> the message with error code.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/iio/magnetometer/ak8974.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
>> index d32996702110..cc3861f97d42 100644
>> --- a/drivers/iio/magnetometer/ak8974.c
>> +++ b/drivers/iio/magnetometer/ak8974.c
>> @@ -718,6 +718,7 @@ static const struct regmap_config ak8974_regmap_config = {
>>  static int ak8974_probe(struct i2c_client *i2c,
>>                         const struct i2c_device_id *id)
>>  {
>> +       const char *level = KERN_ERR;
>>         struct iio_dev *indio_dev;
>>         struct ak8974 *ak8974;
>>         unsigned long irq_trig;
>> @@ -746,7 +747,11 @@ static int ak8974_probe(struct i2c_client *i2c,
>>                                       ARRAY_SIZE(ak8974->regs),
>>                                       ak8974->regs);
>>         if (ret < 0) {
>> -               dev_err(&i2c->dev, "cannot get regulators\n");
>> +               if (ret == -EPROBE_DEFER)
>> +                       level = KERN_DEBUG;
>> +
>> +               dev_printk(level, &i2c->dev, "cannot get regulators: %d\n",
> 
> This misses some important aspects of dev_dbg(), notably this:
> 
> #if defined(CONFIG_DYNAMIC_DEBUG)
> #define dev_dbg(dev, fmt, ...)                                          \
>         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
> #elif defined(DEBUG)
> #define dev_dbg(dev, fmt, ...)                                          \
>         dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
> #else
> #define dev_dbg(dev, fmt, ...)                                          \
> ({                                                                      \
>         if (0)                                                          \
>                 dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
> })
> #endif
> 
> If DEBUG is not defined the entire dev_dbg() message is enclodes in if (0)
> and compiled out of the kernel, saving space. The above does not
> fulfil that.

Hello Linus,

After some recent discussions in regards to the EPROBE_DEFER handling,
Thierry Reding suggested the form which is used in my patch and we
started to use it recently in the Tegra DRM driver [1]. The reason is
that we don't want to miss any deferred-probe messages under any
circumstances, for example like in a case of a disabled DYNAMIC_DEBUG.
The debug messages are usually disabled in a release-build and when not
a very experienced person hands you KMSG for diagnosing a problem, the
KMSG is pretty much useless if error is hidden silently.

By moving the message to a debug level, we reduce the noise in the KMSG
because usually people look for a bold-red error messages. Secondly, we
don't introduce an additional overhead to the kernel size since the same
text is reused for all error conditions.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e32c8c2a5fbe1514e4ae9063a49e76ecf486ffb8

I can change this patch to something like this:

if (ret == -EPROBE_DEFER)
	dev_dbg("deferring probe\n");
else
	dev_err("cannot...");

but in general this should be a less useful variant, don't you agree?
