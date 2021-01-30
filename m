Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0406B309828
	for <lists+linux-iio@lfdr.de>; Sat, 30 Jan 2021 21:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhA3UGa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Jan 2021 15:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhA3UG3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jan 2021 15:06:29 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33ECFC061573
        for <linux-iio@vger.kernel.org>; Sat, 30 Jan 2021 12:05:49 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id n10so9179510pgl.10
        for <linux-iio@vger.kernel.org>; Sat, 30 Jan 2021 12:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5qB9/MD2RFJmtiHJaSjinLoRU95peZ5SQ2HlzrzF59w=;
        b=vFzY3axCQJ8MOhIoPhQHeMonUrVJArW2Z+CHtMQEYDoPHxjoUcqID30GUBtHUIhWXS
         aliXyt4SYEMCArbEQpHyJKmh8y2C/f0Aq6vn5uSigomgul0utN/GGvgNtQ1dCsf8y/kt
         po6+xrROxZ9vcDQPr7D207tTVD6bM8klSY/XAtkC1W0md4ZYcKHYMjyZ7ZClpugEJdAk
         GoP0Bmkzb/ipwvZR2T06tEzMfIU5KI7st3eUrRpdW0a/LUhqRz2sUjxCDUWbZSgYfMQi
         GVitCaWjp/MFbLVPvKKzkod65v2RtpvFfSfcGL/agVe9JhmEkX1Yh0EN9pqSOksRy4je
         bxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5qB9/MD2RFJmtiHJaSjinLoRU95peZ5SQ2HlzrzF59w=;
        b=iXl5UzcmZ8rq0qzwpOq1NtkYz6Kwz86/R/Bfe6j6xruA642W/JSnR/m/lk7SwnNtGS
         wYtlXQWNRVbNfa+0HfmM/A5xiUs8vW9sUrY2LyjQnvGNbFVuEFmMrbIkE1Y3CbSBvX/Q
         v7nEpx7ScXmDIAk7g0pmuOyhu0S2Q2qkPuZ9HzXzQe0yRNpHKbat0HfeYSURiyxSJlcx
         s8V2zde+8Pry6i+sdN1B4nJ0HHhkULOwQWQNfcKYr9eNPJzfh38g/ivvXz92Mvyccb21
         TFVeDff4CKZ0MAuhr5RxfeJeUmht4GGcV78dyHElw6ckc8HpXuy3Mi5ijiqayc2JuqO+
         DWJQ==
X-Gm-Message-State: AOAM533tJnEB362545HNtYs/v9ekzYjCPZGzoSF3TimgoHe2MVhlKW4C
        qUDkOJnCSonA3hM0JqoAlKjOyqwUFaMH1CA36oeEU9vpFCQEcj13
X-Google-Smtp-Source: ABdhPJw92B5dlS+onLhaoAZNtWmyADlfvsNyvdT6s9s2JSA8PXovWn02ZaiKjoHGjKrwVPFDh3+4Pkj5cKOZ/NtU29A=
X-Received: by 2002:a63:e50:: with SMTP id 16mr9941008pgo.74.1612037148565;
 Sat, 30 Jan 2021 12:05:48 -0800 (PST)
MIME-Version: 1.0
References: <20210129230249.816268-1-gwendal@chromium.org>
In-Reply-To: <20210129230249.816268-1-gwendal@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 30 Jan 2021 22:05:32 +0200
Message-ID: <CAHp75VfqPyJpBnwbrnc2Uu_WiJzBjba4UPYMPnKxYx1pXb0i8g@mail.gmail.com>
Subject: Re: [PATCH v8] iio: hrtimer: Allow sub Hz granularity
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jan 30, 2021 at 1:02 AM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> Allow setting frequency below 1Hz or sub 1Hz precision.
> Useful for slow sensors like ALS.
>
> Test frequency is set properly:
> modprobe iio-trig-hrtimer && \
> mkdir /sys/kernel/config/iio/triggers/hrtimer/t1 && \
> cd /sys/bus/iio/devices/triggerX ;
> for i in 1 .1 .01 .001 ; do
>   echo $i > sampling_frequency
>   cat sampling_frequency
> done

I think it's good enough, though one hint below.
After taking it into account
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> Changes since v7:
> - Check for sign properly, only allow positive frequencies.
> - Return proper error code when input frequency is negative.
>
> Changes since v6:
> - Check for sign, only allow positive frequencies.
>
> Changes since v5:
> - Properly support do_div on 32bit architecture: quotient must be u64, dividend
>   u32.
> - Use PSEC_PER_SEC from
>   https://patchwork.kernel.org/project/linux-iio/patch/20210112153709.1074-1-andriy.shevchenko@linux.intel.com/
>
> Changes since v4:
> - Use do_div() properly.
>
> Changes since v3:
> - Fix rebasing issue.
>
> Changes since v2:
> - Add do_div to allow divide by a u64 on 32bit machines.
>
> Changes since v1:
> - Added documentation.
>
>  Documentation/iio/iio_configfs.rst     |  1 +
>  drivers/iio/trigger/iio-trig-hrtimer.c | 30 +++++++++++++++++---------
>  2 files changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/iio/iio_configfs.rst b/Documentation/iio/iio_configfs.rst
> index ecbfdb3afef7e..807589ef2bea0 100644
> --- a/Documentation/iio/iio_configfs.rst
> +++ b/Documentation/iio/iio_configfs.rst
> @@ -99,3 +99,4 @@ Each trigger can have one or more attributes specific to the trigger type.
>
>  "hrtimer" trigger type doesn't have any configurable attribute from /config dir.
>  It does introduce the sampling_frequency attribute to trigger directory.
> +That attribute sets the polling frequency in Hz, with mHz precision.
> diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
> index f59bf8d585866..69c2943583b36 100644
> --- a/drivers/iio/trigger/iio-trig-hrtimer.c
> +++ b/drivers/iio/trigger/iio-trig-hrtimer.c
> @@ -22,7 +22,7 @@
>  struct iio_hrtimer_info {
>         struct iio_sw_trigger swt;
>         struct hrtimer timer;
> -       unsigned long sampling_frequency;
> +       int sampling_frequency[2];
>         ktime_t period;
>  };
>
> @@ -38,7 +38,9 @@ ssize_t iio_hrtimer_show_sampling_frequency(struct device *dev,
>         struct iio_trigger *trig = to_iio_trigger(dev);
>         struct iio_hrtimer_info *info = iio_trigger_get_drvdata(trig);
>
> -       return snprintf(buf, PAGE_SIZE, "%lu\n", info->sampling_frequency);
> +       return iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO,
> +                       ARRAY_SIZE(info->sampling_frequency),
> +                       info->sampling_frequency);
>  }
>
>  static
> @@ -48,18 +50,26 @@ ssize_t iio_hrtimer_store_sampling_frequency(struct device *dev,
>  {
>         struct iio_trigger *trig = to_iio_trigger(dev);
>         struct iio_hrtimer_info *info = iio_trigger_get_drvdata(trig);
> -       unsigned long val;
> -       int ret;
> +       unsigned long long val;
> +       u64 period;
> +       int integer, fract, ret;
>
> -       ret = kstrtoul(buf, 10, &val);
> +       ret = iio_str_to_fixpoint(buf, 100, &integer, &fract);
>         if (ret)
>                 return ret;
> +       if (integer < 0 || fract < 0)
> +               return -ERANGE;
> +
> +       val = fract + 1000 * integer;

To avoid dependencies right now, define at the top of this file

#define PSEC_PER_SEC 1000000000000LL
#define NSEC_PER_PSEC 1000L

And use them here and there.

       val = fract + PSEC_PER_NSEC * integer;

> -       if (!val || val > NSEC_PER_SEC)
> +       if (!val || val > UINT_MAX)
>                 return -EINVAL;
>
> -       info->sampling_frequency = val;
> -       info->period = NSEC_PER_SEC / val;
> +       info->sampling_frequency[0] = integer;

> +       info->sampling_frequency[1] = fract * 1000;

Likewise.

> +       period = PSEC_PER_SEC;
> +       do_div(period, val);
> +       info->period = period;
>
>         return len;
>  }
> @@ -135,8 +145,8 @@ static struct iio_sw_trigger *iio_trig_hrtimer_probe(const char *name)
>         hrtimer_init(&trig_info->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>         trig_info->timer.function = iio_hrtimer_trig_handler;
>
> -       trig_info->sampling_frequency = HRTIMER_DEFAULT_SAMPLING_FREQUENCY;
> -       trig_info->period = NSEC_PER_SEC / trig_info->sampling_frequency;
> +       trig_info->sampling_frequency[0] = HRTIMER_DEFAULT_SAMPLING_FREQUENCY;
> +       trig_info->period = NSEC_PER_SEC / trig_info->sampling_frequency[0];
>
>         ret = iio_trigger_register(trig_info->swt.trigger);
>         if (ret)
> --
> 2.30.0.365.g02bc693789-goog
>


-- 
With Best Regards,
Andy Shevchenko
