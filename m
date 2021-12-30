Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D4D48203E
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 21:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242069AbhL3UVp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 15:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240824AbhL3UVp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 15:21:45 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91371C061574
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 12:21:44 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id p13so20277200lfh.13
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 12:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1M8/pTBgCNgjw7luW/ryskM/W2c2sEhJd4G0NuDPzic=;
        b=uEWW7EVWI310VES8xhKfslDh5Cp3e8UmjZaE4B4JX1PlZQxbbh2WKTiuK+R4hVf9lq
         ZAJZ60ki/0unTuVTuV0SgraOfDuL17Kk/WZ4U6I7vJGrPtw0f2aff3NK6YaBYfA/MKUp
         78tlfZQJqWA2HKp5fw5iF1A0Qx3Z1tl9x+MoJrlPxUWnGeA+2bBdRWv530c3kiWZTkLA
         3dB9CvbQw87bDwUTzBRnFWrI6u+LoihHWpldM0QU89gVXMKNhJcLb54qHAKMwU/koCB9
         lR+wm8O32VOdpo4zZFqF0osyYiZFU5metIpcCcQkNuGZYSAR8NdF7nXF7FHt0E4ChgWi
         mayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1M8/pTBgCNgjw7luW/ryskM/W2c2sEhJd4G0NuDPzic=;
        b=D4G/UZMRfhiqVf9YKmAQpOuh96QlilkEH7OhVqmcRsQ7cHNoOnRNTEzq6YiS0rJ5Qh
         JXSfB4C2y6G46oWxv71JMunbGkKL+aDOqFP92BTBmefonclKrT6fUusfvILSP0rEYRQs
         4UnEHrdrS+cCY9SLjIz68cZvJSGj0T4qy6E7IhhjIGD8CVidGW/DCiive8sPg5AUKijs
         cKl4GZf3J2fOOWGecZfdvtzrV47u8NinnUzpS/pooehEcmv7EUUIwx/9b8jEsUAMRERi
         LzUXbexkCkuo/WYVaTa36wv5rSv8ORgX/PUvF4ow8Ipqb/3pNPwnDW6dRJbI+SP52ICC
         w2GQ==
X-Gm-Message-State: AOAM533OEphMznCzgU45N/iyWkfeIy94a8oeD3pMjYtGC3Bwyf78p63S
        yQNOtyTtm3N+ryYsc9DKFzjmSzYiO7sbf9ssHDw=
X-Google-Smtp-Source: ABdhPJzENm5qQ8Ns7IwaTB5kH4JuYy5gGwHSWr9o0LIB82dnjwMsqW87ieTydkDAPvVCk6bHVFU04g==
X-Received: by 2002:ac2:490f:: with SMTP id n15mr12551770lfi.141.1640895702792;
        Thu, 30 Dec 2021 12:21:42 -0800 (PST)
Received: from [192.168.112.17] (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id p27sm2566749lfa.295.2021.12.30.12.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 12:21:42 -0800 (PST)
Subject: Re: [PATCH] iio: stm: don't always auto-enable I2C and SPI interface
 drivers
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Cai Huoqing <caihuoqing@baidu.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20211229072916.2567155-1-nikita.yoush@cogentembedded.com>
 <CAHp75VfKcKyc8fdu0XnaYYnY2UP+27=8hKJMtzwH5755Cw=sww@mail.gmail.com>
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Message-ID: <4d8e2b87-3196-0cf4-6096-885b446b3aa7@cogentembedded.com>
Date:   Thu, 30 Dec 2021 23:21:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfKcKyc8fdu0XnaYYnY2UP+27=8hKJMtzwH5755Cw=sww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

      This patch makes I2C and SPI interface drivers for STMicroelectronics
>     sensor chips individually selectable via Kconfig.
> 
>     The default is kept unchanged - I2C and SPI interface drivers are still
>     selected by default if the corresponding bus support is available.
> 
>     However, the patch makes it is possible to explicitly disable drivers
>     that are not needed for particular 
> 
> NAK if users need now manually update their .config / defconfigs.

No they don't need to update anything.
And 'make oldconfig' will be old.

The config will only change after a manual action.
