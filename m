Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30E53676A9
	for <lists+linux-iio@lfdr.de>; Thu, 22 Apr 2021 03:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbhDVBLD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Apr 2021 21:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhDVBLC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Apr 2021 21:11:02 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FFEC06174A;
        Wed, 21 Apr 2021 18:10:28 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u4so49861451ljo.6;
        Wed, 21 Apr 2021 18:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DtDSM+InO8y+0n4wXRxoNAhlr6JlrgOufIbdfvVI4hA=;
        b=RPzEDyZF9w3qzHgpxlLVjvtPeCMwj4iOkrtJbOH9nmZOcLY/NiPR3U9cyd7o7+FQ/f
         rFdYZZR3NiNzI2U+oEQM4d3RK3iJ7z+vu3HP5YoIrTPOq+/iI+6ThyJqKMJeQgdgBi8A
         oKOb43HAdrCuwKt/MC9mZg3hXRDmKNVQyDL92/97mMWOVtguPaR6ZGkGYiKxGJQl1qSU
         XfwR4NjXm7rQw3o36ihkVwbnc+qhw7pfGjCvSzdvAMJtW8LymBF+Sm3esH6j88PQ3MpH
         d6UJJzY6zM9Xcoos9zz82GNZ135hE5/9YKqorxq3d01hRfu5GgXV3+HguCQ8wDblg+gH
         Qm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DtDSM+InO8y+0n4wXRxoNAhlr6JlrgOufIbdfvVI4hA=;
        b=jUaLuiu4hojuITe4Ki+EonQFUZoY3625KAAPsjNRfWjKIdH8ovTPAz8XspwcHNrCwN
         MODsNm5o5yVOey3PLUx90FhUojgvoQsnSS3J0WyqdKv/jXWAULXIeB7ozCoZt71p62QC
         N4B8OmK8N/VyKWS37QJT9LeS506uD7Ir6cu0B+Jjo7kdHHLi6OseAY5eXxgvPZ60buq2
         u7JJKWsVhKUgC/ALoY+GRRQFsiZ94hjQkkLuMPY0+czqM7rqueS36qRpRtHazDBzUAQE
         EDlNUYXRlciYxdiIlBxazHoZ9EqZep4SHH9xiUoS+s3y2lH5wheF04Vqxq1vzfxUckOy
         SbBQ==
X-Gm-Message-State: AOAM531G8ilyiHtgCHyjj/d5AwdJlBdDRBOPpkNhsY4321eoOHPU61ZJ
        ApPHUYbrYELbOlq+Rgd8RrxaXu1ablo=
X-Google-Smtp-Source: ABdhPJw/x3Gwo+fDSJdBxAOpNlLX/3nfYp9wUCxv4GmrMVMq+XNwVk7io1G16fQJ7XfY+AeA+D+8yA==
X-Received: by 2002:a05:651c:1052:: with SMTP id x18mr687257ljm.17.1619053826804;
        Wed, 21 Apr 2021 18:10:26 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-103.dynamic.spd-mgts.ru. [109.252.193.103])
        by smtp.googlemail.com with ESMTPSA id y16sm123356ljh.13.2021.04.21.18.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 18:10:26 -0700 (PDT)
Subject: Re: [PATCH v1] iio: gyro: mpu3050: Fix reported temperature value
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210421234820.32211-1-digetx@gmail.com>
 <CACRpkda_tfuXH=kE+SbY1BC1rXsYUkQigtkWQ8Dz29JX-SaemA@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f53a52a0-787a-7b67-3e28-1d14147f5a18@gmail.com>
Date:   Thu, 22 Apr 2021 04:10:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CACRpkda_tfuXH=kE+SbY1BC1rXsYUkQigtkWQ8Dz29JX-SaemA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

22.04.2021 03:38, Linus Walleij пишет:
> On Thu, Apr 22, 2021 at 1:49 AM Dmitry Osipenko <digetx@gmail.com> wrote:
> 
>> The raw temperature value is a signed 16bit integer. The sign casting
>> is missed in the code, which results in a wrong temperature reported by
>> userspace tools, fix it.
>>
>> Cc: stable@vger.kernel.org
>> Link: https://www.cdiweb.com/datasheets/invensense/mpu-3000a.pdf
>> Tested-by: Maxim Schwalm <maxim.schwalm@gmail.com> # Asus TF700T
>> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Asus TF201
>> Reported-by: Svyatoslav Ryhel <clamor95@gmail.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> 
> +/- Andy's comments:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I never thought this driver would have so many users (3 people signed
> testing it!) but I realize it is more widely deployed than I thought.
> 
> I have totally ignored the MPU3050's ability to act as a "sensor hub"
> and talk to accelerometers and magnetometers directly. I always
> thought it would be better to just route the I2C right through it and
> put Linux in direct control, but I realize this was not Invensese's
> intention. I don't know if it can be actually utilized in some generic
> way, all kernels using that have separate hacky drivers for all the
> sub-sensors duplicating the kernel drivers we already have ...

I don't think that MPU3050 could talk to the sensors behind it directly.
It's has "I2C gate" which allows to route the I2C communication to the
chained sensors, which is done in order to reduce noise on the I2C bus
such that only one sensor is active at a time. Those chained sensors are
working good using upstream kernel drivers, the accelerometer is
particularly useful for display autorotation. Modern DEs like Gnome and
KDE are using iio-sensor-proxy library that knows how to work with the
mainline sensor drivers.

Thank you and Andy for the review, I'll prepare v2.
