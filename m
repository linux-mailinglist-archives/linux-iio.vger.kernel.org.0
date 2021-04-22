Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFEC7368626
	for <lists+linux-iio@lfdr.de>; Thu, 22 Apr 2021 19:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbhDVRnb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Apr 2021 13:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236681AbhDVRn2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Apr 2021 13:43:28 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5417C06174A;
        Thu, 22 Apr 2021 10:42:51 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id a5so15842043ljk.0;
        Thu, 22 Apr 2021 10:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ki9ZtYZhSV3LWMVCxjRqnj9/0Swj62JIuDbFJTiqNqI=;
        b=gK+jtnb9yrizbBOVUv561qvf6W9S3E65goj1NKrx2JI2F2fF+USZI+jexn4Teec+Ey
         cx0ETik3wyCJz0IdiM+SFp3Y8Ay6hKUHrgap9W3TC24yMe2LlfQJEjFlqWtu6XA8mlHt
         EcMdZA9dnEdXHrwpu4EBbFLT7I54W/78buf5ck2uSst1wZKUi0sg8sRhiCFgLl+aB2v7
         VQfjdSRcPhwVqQ+jvB6T6Qm7cgtEoWD31DXewp8dcsifstXSIveq+VjzKqjB00y8UGoB
         cpntiIr0lPqbF6PfV/C/JdpSOiJNbRBiqvGp5JH4mFMFyWySCIyl90QiqINdDfT9spqb
         nuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ki9ZtYZhSV3LWMVCxjRqnj9/0Swj62JIuDbFJTiqNqI=;
        b=Hl14vJcNW1CdpuGsnBMVH1RMAg/eFLrXyqaJeOL6ltu4e3Ci3xNwZsUAjSRgXAQyZF
         Kf0aMQk7xBwsQnxcTqmaTbKkkeun/eg7lq50v7DzQaSk3Xp4rKPNgqOO4nrDMKaJatPn
         QOtPr9P7C1+LRK5Qh0AxDoLLtcY4bNZwr94usVXBwnxbY1I4+iLNTja7i5u/ot75v279
         MHdeuq1Y6zqh9c4LwPyI1P8dSK/+TjWkCpvoT7/GgRTY19v4JjDSf1/x5OeFcibwpmIQ
         c18384a6mTVmzz7duGAvDM7Gd8TG//TTWsXRNuJF3F+Ex5yhpjkHZ1Wn8SvgkVBC9r2c
         2o2Q==
X-Gm-Message-State: AOAM532zyvrjuCoomDRYprHZ1izs0eJptLxM+WoOx3V1dy9+a3GT4+B+
        zkANnL0W+RxzUOu6NltF/X5IgyqaLWw=
X-Google-Smtp-Source: ABdhPJzDQeP4P29DGurtjAOnQSudfJL4xZlJsYM/IqhQN7jgUY27qnGN3k5uHcJ3BSZK97Ze22cuug==
X-Received: by 2002:a05:651c:44f:: with SMTP id g15mr2559ljg.48.1619113369902;
        Thu, 22 Apr 2021 10:42:49 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-103.dynamic.spd-mgts.ru. [109.252.193.103])
        by smtp.googlemail.com with ESMTPSA id m28sm317818lfo.278.2021.04.22.10.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 10:42:49 -0700 (PDT)
Subject: Re: [PATCH v1] iio: gyro: mpu3050: Fix reported temperature value
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210422033841.22211-1-digetx@gmail.com>
 <CAHp75VdkpTqGyHSdYYwYQ-PY2c=pDWeB_-gYKsrA2iX7POPWmQ@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <18507b2d-0133-190d-724a-4cf038016c17@gmail.com>
Date:   Thu, 22 Apr 2021 20:42:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VdkpTqGyHSdYYwYQ-PY2c=pDWeB_-gYKsrA2iX7POPWmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

22.04.2021 09:46, Andy Shevchenko пишет:
>                     case IIO_TEMP:
>     -                       /* The temperature scaling is (x+23000)/280
>     Celsius */
>     +                       /*
>     +                        * The temperature scaling is (x+23000)/280
>     Celsius,
>     +                        * where 23000 includes room temperature
>     offset of
>     +                        * +35C, 280 is the precision scale and x is
>     the 16-bit
>     +                        * signed integer which corresponds to the
>     temperature
>     +                        * range of -40C..85C.
> 
> 
> 
> Datasheet says typical -30°... also think about the other comment you
> gave, I.e. about temperature of the die itself. Are you suggesting that
> at -40° the die T is also -40°?  Does it have perpetuum mobile ? ;) it
> might dissipate not to much energy, but we don’t know the linearity of
> the curve there.

My understanding that -40C is the minimum temperature which sensor may
report.

Alright, I think the comment could be improved a tad anyways. I'll
prepare v3, thanks.
