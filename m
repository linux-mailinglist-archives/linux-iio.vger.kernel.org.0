Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6EE2D8EEF
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 18:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390355AbgLMRDN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 12:03:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:60502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732030AbgLMRDN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 12:03:13 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D051023121;
        Sun, 13 Dec 2020 17:02:31 +0000 (UTC)
Date:   Sun, 13 Dec 2020 17:02:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     lars@metafoo.de, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: hrtimer: Allow sub Hz granularity
Message-ID: <20201213170228.745bcd48@archlinux>
In-Reply-To: <20201209224644.185134-1-gwendal@chromium.org>
References: <20201209224644.185134-1-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  9 Dec 2020 14:46:44 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

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
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Just to note as Andy raised the ABI docs question. 
The attribute this is providing is more generic than just for the hrtimer
trigger and as such is in the main ABI docs.  The reason is that
samping_frequency is able to occur in various different places depending
on where it has side effects.  In particular a dataready trigger for
a device with variable sampling frequency will usually be in the
iio:\deviceX directory because it will have affects on anti aliasing filters
so has an impact even if you are just reading from sysfs.
We could add specific docs for this case (though because all ABI docs
for a given named attribute need to be in one file, it would be rather
messy).

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to see if we missed anything.

Thanks,

Jonathan


> ---
> Changes since v1:
> - Added documentation.
> 
>  Documentation/iio/iio_configfs.rst     |  1 +
>  drivers/iio/trigger/iio-trig-hrtimer.c | 25 +++++++++++++++----------
>  2 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/iio/iio_configfs.rst b/Documentation/iio/iio_configfs.rst
> index ecbfdb3afef7e..428419f8732c4 100644
> --- a/Documentation/iio/iio_configfs.rst
> +++ b/Documentation/iio/iio_configfs.rst
> @@ -99,3 +99,4 @@ Each trigger can have one or more attributes specific to the trigger type.
>  
>  "hrtimer" trigger type doesn't have any configurable attribute from /config dir.
>  It does introduce the sampling_frequency attribute to trigger directory.
> +That attribute sets the polling frequency in Hz, with mHz precision.
> diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
> index a5e670726717f..06acd6dc79a8c 100644
> --- a/drivers/iio/trigger/iio-trig-hrtimer.c
> +++ b/drivers/iio/trigger/iio-trig-hrtimer.c
> @@ -22,7 +22,7 @@
>  struct iio_hrtimer_info {
>  	struct iio_sw_trigger swt;
>  	struct hrtimer timer;
> -	unsigned long sampling_frequency;
> +	int sampling_frequency[2];
>  	ktime_t period;
>  };
>  
> @@ -38,7 +38,9 @@ ssize_t iio_hrtimer_show_sampling_frequency(struct device *dev,
>  	struct iio_trigger *trig = to_iio_trigger(dev);
>  	struct iio_hrtimer_info *info = iio_trigger_get_drvdata(trig);
>  
> -	return snprintf(buf, PAGE_SIZE, "%lu\n", info->sampling_frequency);
> +	return iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO,
> +			ARRAY_SIZE(info->sampling_frequency),
> +			info->sampling_frequency);
>  }
>  
>  static
> @@ -48,18 +50,21 @@ ssize_t iio_hrtimer_store_sampling_frequency(struct device *dev,
>  {
>  	struct iio_trigger *trig = to_iio_trigger(dev);
>  	struct iio_hrtimer_info *info = iio_trigger_get_drvdata(trig);
> -	unsigned long val;
> -	int ret;
> +	unsigned long long val;
> +	int integer, fract, ret;
>  
> -	ret = kstrtoul(buf, 10, &val);
> +	ret = iio_str_to_fixpoint(buf, 100, &integer, &fract);
>  	if (ret)
>  		return ret;
>  
> -	if (!val || val > NSEC_PER_SEC)
> +	val = fract + 1000 * integer;
> +
> +	if (!val || val > NSEC_PER_SEC * 1000)
>  		return -EINVAL;
>  
> -	info->sampling_frequency = val;
> -	info->period = NSEC_PER_SEC / val;
> +	info->sampling_frequency[0] = integer;
> +	info->sampling_frequency[1] = fract * 1000;
> +	info->period = NSEC_PER_SEC * 1000 / val;
>  
>  	return len;
>  }
> @@ -135,8 +140,8 @@ static struct iio_sw_trigger *iio_trig_hrtimer_probe(const char *name)
>  	hrtimer_init(&trig_info->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>  	trig_info->timer.function = iio_hrtimer_trig_handler;
>  
> -	trig_info->sampling_frequency = HRTIMER_DEFAULT_SAMPLING_FREQUENCY;
> -	trig_info->period = NSEC_PER_SEC / trig_info->sampling_frequency;
> +	trig_info->sampling_frequency[0] = HRTIMER_DEFAULT_SAMPLING_FREQUENCY;
> +	trig_info->period = NSEC_PER_SEC / trig_info->sampling_frequency[0];
>  
>  	ret = iio_trigger_register(trig_info->swt.trigger);
>  	if (ret)

