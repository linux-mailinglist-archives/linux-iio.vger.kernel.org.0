Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA56326015
	for <lists+linux-iio@lfdr.de>; Fri, 26 Feb 2021 10:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhBZJbQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Feb 2021 04:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbhBZJ3P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Feb 2021 04:29:15 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E100AC061788
        for <linux-iio@vger.kernel.org>; Fri, 26 Feb 2021 01:28:34 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id p5so5005916plo.4
        for <linux-iio@vger.kernel.org>; Fri, 26 Feb 2021 01:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5u4YKPBAMtwMYHsw3slqbdyQwDDpDL+s5kZkqX7YhP0=;
        b=hi/+ytI6KV7i4dTdDjvTL+ml0iJBLK0a/JVc73dzTpymfVJPgR78m1zlnYK0vpwYNk
         CxkybW0VrvzQVmkiDBIfiOvALgDl5uQpRUtSRsjrQNFfSRgpHXRxBHxGj6uPvnV8DNYG
         m3OoenFXsWtaRU/IiRmW6zbwEOAXjU7lsX8hbKtKjiTMCNc49/USBJ2D2ZhJ91jvp9ai
         5lWLHZNI3k2/Iy63MTJV18NP/rLqPM5UNYxmvrXbPBFXyIMn8cY8C5PBsdVjJD+voWaM
         OHlKbDPWZr9L/kuVm7kL9Nioa+9ddm0mfKn8/0ovY6UhGwgGoa0kXhR2IHvSeMPiWcVF
         bUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5u4YKPBAMtwMYHsw3slqbdyQwDDpDL+s5kZkqX7YhP0=;
        b=PMylINuL3aUVTHMe2M5OEIrcmvj2w/dycKzkac0WZwBy+8DDMwtXpob7b203LxHt6f
         XRKs9CGm8Z33JxM9Z/KOawIPftxA0+2Xl2EkMOteut2jdE3aV7B+MHxHCb7JQCNQC2vG
         ymO9/+FPjMIEwMESFD5gaMfKbaBj5r1LYIoYHcn44qZsd9dVyuvsJ8CkX6yLyvRirUy4
         Txg2kAgTYJJFAfcHeKR+Oz7kC+oKAUD9XpMpWYLiBHK3HVe2KFIirePRLSVrfF7R2G50
         fIuJ8+GX3hApRmWR3DSQhVq09Mmvj+G+kJiAk0bWmshEJQqQoi0raxlNwRWYQyTOf+pO
         f8uQ==
X-Gm-Message-State: AOAM532mMn8FAwUFLnwEMEnA4YV997+iQ8gSdFbKddIFjq6er1YLF4kh
        /PiLrX1y2hTqkeeg4A+RiUfcMzNFTz8ndf+bep7CqytUihd+YQ==
X-Google-Smtp-Source: ABdhPJyxNvsa2gTVJHWmmvcqRZGAq/fnAhqZt7xslfVfMGCBVKdqNStRB3tEmF/GVcRThLCKCWKmMq4PCu6lPzS/wic=
X-Received: by 2002:a17:902:7b96:b029:de:7ae6:b8db with SMTP id
 w22-20020a1709027b96b02900de7ae6b8dbmr2287242pll.0.1614331712737; Fri, 26 Feb
 2021 01:28:32 -0800 (PST)
MIME-Version: 1.0
References: <20210226014733.2108544-1-gwendal@chromium.org>
In-Reply-To: <20210226014733.2108544-1-gwendal@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Feb 2021 11:28:16 +0200
Message-ID: <CAHp75Ve+AAoxLhXUKL95PX1-ZuVphUWO6Xjr4bYe4TSNEhdNyQ@mail.gmail.com>
Subject: Re: [PATCH v9] iio: hrtimer: Allow sub Hz granularity
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, groeck@chromium.org,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Feb 26, 2021 at 3:47 AM Gwendal Grignou <gwendal@chromium.org> wrote:
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

Thanks!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> Changes since v8:
> - Define PSEC_PER_SEC locally to avoid dependency
> - Add units of expressions in comment.
>
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
>  drivers/iio/trigger/iio-trig-hrtimer.c | 33 ++++++++++++++++++--------
>  2 files changed, 24 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/iio/iio_configfs.rst b/Documentation/iio/iio_configfs.rst
> index 3a5d76f9e2b97..09845fe525e84 100644
> --- a/Documentation/iio/iio_configfs.rst
> +++ b/Documentation/iio/iio_configfs.rst
> @@ -99,3 +99,4 @@ Each trigger can have one or more attributes specific to the trigger type.
>
>  "hrtimer" trigger type doesn't have any configurable attribute from /config dir.
>  It does introduce the sampling_frequency attribute to trigger directory.
> +That attribute sets the polling frequency in Hz, with mHz precision.
> diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
> index 410de837d0417..aa8cc7391a60d 100644
> --- a/drivers/iio/trigger/iio-trig-hrtimer.c
> +++ b/drivers/iio/trigger/iio-trig-hrtimer.c
> @@ -16,13 +16,16 @@
>  #include <linux/iio/trigger.h>
>  #include <linux/iio/sw_trigger.h>
>
> +/* Defined locally, not in time64.h yet. */
> +#define PSEC_PER_SEC   1000000000000LL
> +
>  /* default sampling frequency - 100Hz */
>  #define HRTIMER_DEFAULT_SAMPLING_FREQUENCY 100
>
>  struct iio_hrtimer_info {
>         struct iio_sw_trigger swt;
>         struct hrtimer timer;
> -       unsigned long sampling_frequency;
> +       int sampling_frequency[2];
>         ktime_t period;
>  };
>
> @@ -38,7 +41,9 @@ ssize_t iio_hrtimer_show_sampling_frequency(struct device *dev,
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
> @@ -48,18 +53,26 @@ ssize_t iio_hrtimer_store_sampling_frequency(struct device *dev,
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
> +       val = fract + 1000 * integer;  /* mHz */
>
> -       if (!val || val > NSEC_PER_SEC)
> +       if (!val || val > UINT_MAX)
>                 return -EINVAL;
>
> -       info->sampling_frequency = val;
> -       info->period = NSEC_PER_SEC / val;
> +       info->sampling_frequency[0] = integer;  /* Hz */
> +       info->sampling_frequency[1] = fract * 1000;  /* uHz */
> +       period = PSEC_PER_SEC;
> +       do_div(period, val);
> +       info->period = period;  /* nS */
>
>         return len;
>  }
> @@ -135,8 +148,8 @@ static struct iio_sw_trigger *iio_trig_hrtimer_probe(const char *name)
>         hrtimer_init(&trig_info->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
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
> 2.30.1.766.gb4fecdf3b7-goog
>


-- 
With Best Regards,
Andy Shevchenko
