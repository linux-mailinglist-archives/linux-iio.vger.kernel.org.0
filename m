Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16FB12F32D7
	for <lists+linux-iio@lfdr.de>; Tue, 12 Jan 2021 15:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbhALOX3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Jan 2021 09:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729135AbhALOX2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Jan 2021 09:23:28 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9659FC061575
        for <linux-iio@vger.kernel.org>; Tue, 12 Jan 2021 06:22:48 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 11so1480143pfu.4
        for <linux-iio@vger.kernel.org>; Tue, 12 Jan 2021 06:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uj8zT21uSAWUvP3lhSdmNGJeRz6Jkb9gQ1zEcpHqE/U=;
        b=A9ZxMS9Q5XST6HDZikYtqUlDMl9HgJmGt3a5uZazv6fkIQjM1wDGEJXu6Rfd4XL7pA
         948shuJ0qNFLtUERquVyWM5nODQGSjyuRF+KyOfd8e9/kJBybwdjyl44YVPTs1dLHjPy
         s77exbt1Dtz8VH66QVGL8w40EVvfxMdx9Le1m0RkHpHxUOCtxlDVIXjpNX6Udq6ryNVe
         8bdRur5v0BTz8dB8eCUnjbGjJlodiVX5uXqrdZrqdC4em9IDu7O9wfewvKgWYgVfJK9Z
         AajnRxbOF6coIqIeILOINduNEWGVilOsL+gyWGYC/pRo+UDvvKIUfT4mYFMt6vKHc4eo
         Y7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uj8zT21uSAWUvP3lhSdmNGJeRz6Jkb9gQ1zEcpHqE/U=;
        b=K5rBc9/YgL5n05lJIWCVzk2ye5vrDiMXuO1PPP9p55+k94EYOrN8+O+3yF4bbSXTjb
         4pMDT0ou1EkUzUTS/9wRjTsA58Cbeb0EADO1Nn9hEA7+gl4mQGBaVXP/WuALKlzYsGJu
         cjNzGqy9jeKQEPfIdcyncLIzE5IkYTuITXHmOQFlB9ZvCDPPqhFin76VGOjjjSk/Zbtr
         DU0y/o8SAal3Negw3gqXBGm1HyGMyz/mZXhe1xpBTKP2ZhsxK2L/ZzZ+4uFrOkYRUaC/
         EiybRNmUhcYBYxXxbYoq3CAYdWBMsJsvSlQ16PQQx5OPy/mITlMUSs5Jjij+DvNek3d6
         jHMw==
X-Gm-Message-State: AOAM531G+5lbvwXryH1yfk3D5cx57rKLoO7DZ7hJ257Ibx+KOj4Hmm+Y
        NMFu/6nR7t4RLEj6KgrNxkViPW0Ekxj2XGtebe4=
X-Google-Smtp-Source: ABdhPJwRhD7kLw4VYEALsuUL1zOO49XKYXL3kERLfgGv7iDqFUYImfrDr6gYFKOqh4k+rywXFELSDy7gh4MdveZJObI=
X-Received: by 2002:a63:4b16:: with SMTP id y22mr5008396pga.203.1610461368071;
 Tue, 12 Jan 2021 06:22:48 -0800 (PST)
MIME-Version: 1.0
References: <20210112040923.2613711-1-gwendal@chromium.org>
In-Reply-To: <20210112040923.2613711-1-gwendal@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Jan 2021 16:23:36 +0200
Message-ID: <CAHp75Vda3htVLApWwqoKb8uyoJaQWdOL2JK4kzMn_OH4OHa4Lg@mail.gmail.com>
Subject: Re: [PATCH v5] iio: hrtimer: Allow sub Hz granularity
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 12, 2021 at 6:09 AM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> Allow setting frequency below 1Hz or sub 1Hz precision.
> Useful for slow sensors like ALS.
>
> Test frequency is set properly:
> modprobe iio-trig-hrtimer && \
> mkdir /sys/kernel/config/iio/triggers/hrtimer/t1 && \

This && seems strange...

> cd /sys/bus/iio/devices/triggerX ;

...because if the above fails, the below becomes a total train wreck.

> for i in 1 .1 .01 .001 ; do
>   echo $i > sampling_frequency
>   cat sampling_frequency
> done

Something like this perhaps (note {} and also I dropped unneeded ; and
whitespace)
  modprobe iio-trig-hrtimer && \
  mkdir /sys/kernel/config/iio/triggers/hrtimer/t1 && { \
    cd /sys/bus/iio/devices/triggerX
    for i in 1 .1 .01 .001; do
      echo $i > sampling_frequency
      cat sampling_frequency
    done
  }

...

> +       if (!val || val > NSEC_PER_SEC * 1000)
>                 return -EINVAL;

> +       info->period = NSEC_PER_SEC * 1000;

I didn't get these * 1000 parts, why not define and use PSEC_PER_SEC?

I'll send a patch soon. You may include it in your series as prerequisite.

-- 
With Best Regards,
Andy Shevchenko
