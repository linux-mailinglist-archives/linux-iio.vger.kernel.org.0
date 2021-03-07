Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2D63300CD
	for <lists+linux-iio@lfdr.de>; Sun,  7 Mar 2021 13:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhCGMZ0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Mar 2021 07:25:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:39780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230039AbhCGMZH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Mar 2021 07:25:07 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D055650F7;
        Sun,  7 Mar 2021 12:25:06 +0000 (UTC)
Date:   Sun, 7 Mar 2021 12:24:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>, groeck@chromium.org,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v9] iio: hrtimer: Allow sub Hz granularity
Message-ID: <20210307122458.125ed054@archlinux>
In-Reply-To: <CAHp75Ve+AAoxLhXUKL95PX1-ZuVphUWO6Xjr4bYe4TSNEhdNyQ@mail.gmail.com>
References: <20210226014733.2108544-1-gwendal@chromium.org>
        <CAHp75Ve+AAoxLhXUKL95PX1-ZuVphUWO6Xjr4bYe4TSNEhdNyQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 26 Feb 2021 11:28:16 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Feb 26, 2021 at 3:47 AM Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > Allow setting frequency below 1Hz or sub 1Hz precision.
> > Useful for slow sensors like ALS.
> >
> > Test frequency is set properly:
> > modprobe iio-trig-hrtimer && \
> > mkdir /sys/kernel/config/iio/triggers/hrtimer/t1 && \
> > cd /sys/bus/iio/devices/triggerX ;
> > for i in 1 .1 .01 .001 ; do
> >   echo $i > sampling_frequency
> >   cat sampling_frequency
> > done  
> 
> Thanks!
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it.

thanks,


Jonathan

> > ---
> > Changes since v8:
> > - Define PSEC_PER_SEC locally to avoid dependency
> > - Add units of expressions in comment.
> >
> > Changes since v7:
> > - Check for sign properly, only allow positive frequencies.
> > - Return proper error code when input frequency is negative.
> >
> > Changes since v6:
> > - Check for sign, only allow positive frequencies.
> >
> > Changes since v5:
> > - Properly support do_div on 32bit architecture: quotient must be u64, dividend
> >   u32.
> > - Use PSEC_PER_SEC from
> >   https://patchwork.kernel.org/project/linux-iio/patch/20210112153709.1074-1-andriy.shevchenko@linux.intel.com/
> >
> > Changes since v4:
> > - Use do_div() properly.
> >
> > Changes since v3:
> > - Fix rebasing issue.
> >
> > Changes since v2:
> > - Add do_div to allow divide by a u64 on 32bit machines.
> >
> > Changes since v1:
> > - Added documentation.
> >
> >  Documentation/iio/iio_configfs.rst     |  1 +
> >  drivers/iio/trigger/iio-trig-hrtimer.c | 33 ++++++++++++++++++--------
> >  2 files changed, 24 insertions(+), 10 deletions(-)
> >
> > diff --git a/Documentation/iio/iio_configfs.rst b/Documentation/iio/iio_configfs.rst
> > index 3a5d76f9e2b97..09845fe525e84 100644
> > --- a/Documentation/iio/iio_configfs.rst
> > +++ b/Documentation/iio/iio_configfs.rst
> > @@ -99,3 +99,4 @@ Each trigger can have one or more attributes specific to the trigger type.
> >
> >  "hrtimer" trigger type doesn't have any configurable attribute from /config dir.
> >  It does introduce the sampling_frequency attribute to trigger directory.
> > +That attribute sets the polling frequency in Hz, with mHz precision.
> > diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
> > index 410de837d0417..aa8cc7391a60d 100644
> > --- a/drivers/iio/trigger/iio-trig-hrtimer.c
> > +++ b/drivers/iio/trigger/iio-trig-hrtimer.c
> > @@ -16,13 +16,16 @@
> >  #include <linux/iio/trigger.h>
> >  #include <linux/iio/sw_trigger.h>
> >
> > +/* Defined locally, not in time64.h yet. */
> > +#define PSEC_PER_SEC   1000000000000LL
> > +
> >  /* default sampling frequency - 100Hz */
> >  #define HRTIMER_DEFAULT_SAMPLING_FREQUENCY 100
> >
> >  struct iio_hrtimer_info {
> >         struct iio_sw_trigger swt;
> >         struct hrtimer timer;
> > -       unsigned long sampling_frequency;
> > +       int sampling_frequency[2];
> >         ktime_t period;
> >  };
> >
> > @@ -38,7 +41,9 @@ ssize_t iio_hrtimer_show_sampling_frequency(struct device *dev,
> >         struct iio_trigger *trig = to_iio_trigger(dev);
> >         struct iio_hrtimer_info *info = iio_trigger_get_drvdata(trig);
> >
> > -       return snprintf(buf, PAGE_SIZE, "%lu\n", info->sampling_frequency);
> > +       return iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO,
> > +                       ARRAY_SIZE(info->sampling_frequency),
> > +                       info->sampling_frequency);
> >  }
> >
> >  static
> > @@ -48,18 +53,26 @@ ssize_t iio_hrtimer_store_sampling_frequency(struct device *dev,
> >  {
> >         struct iio_trigger *trig = to_iio_trigger(dev);
> >         struct iio_hrtimer_info *info = iio_trigger_get_drvdata(trig);
> > -       unsigned long val;
> > -       int ret;
> > +       unsigned long long val;
> > +       u64 period;
> > +       int integer, fract, ret;
> >
> > -       ret = kstrtoul(buf, 10, &val);
> > +       ret = iio_str_to_fixpoint(buf, 100, &integer, &fract);
> >         if (ret)
> >                 return ret;
> > +       if (integer < 0 || fract < 0)
> > +               return -ERANGE;
> > +
> > +       val = fract + 1000 * integer;  /* mHz */
> >
> > -       if (!val || val > NSEC_PER_SEC)
> > +       if (!val || val > UINT_MAX)
> >                 return -EINVAL;
> >
> > -       info->sampling_frequency = val;
> > -       info->period = NSEC_PER_SEC / val;
> > +       info->sampling_frequency[0] = integer;  /* Hz */
> > +       info->sampling_frequency[1] = fract * 1000;  /* uHz */
> > +       period = PSEC_PER_SEC;
> > +       do_div(period, val);
> > +       info->period = period;  /* nS */
> >
> >         return len;
> >  }
> > @@ -135,8 +148,8 @@ static struct iio_sw_trigger *iio_trig_hrtimer_probe(const char *name)
> >         hrtimer_init(&trig_info->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
> >         trig_info->timer.function = iio_hrtimer_trig_handler;
> >
> > -       trig_info->sampling_frequency = HRTIMER_DEFAULT_SAMPLING_FREQUENCY;
> > -       trig_info->period = NSEC_PER_SEC / trig_info->sampling_frequency;
> > +       trig_info->sampling_frequency[0] = HRTIMER_DEFAULT_SAMPLING_FREQUENCY;
> > +       trig_info->period = NSEC_PER_SEC / trig_info->sampling_frequency[0];
> >
> >         ret = iio_trigger_register(trig_info->swt.trigger);
> >         if (ret)
> > --
> > 2.30.1.766.gb4fecdf3b7-goog
> >  
> 
> 

