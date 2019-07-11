Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD78655C8
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2019 13:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfGKLeE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Jul 2019 07:34:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42580 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbfGKLeE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Jul 2019 07:34:04 -0400
Received: by mail-pg1-f194.google.com with SMTP id t132so2798766pgb.9;
        Thu, 11 Jul 2019 04:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PrHYFoGNkqmIBES6VjNIm8meeYGsDrmQkyT4aQ80neI=;
        b=ZdUE6YqdlnUv0xml3DdoLfiwYTtNnr+BEr0PryuTrs5ySjCxv2wKBxFybcN+Y1loCO
         R7MKFHADYAUtuSoDkHB/CZWWQDfGtRVMs35mQXC93lQmnlT61qyyIWokhIYm7/LLi6In
         aQbQ1Rw67YthvoJcBDfPIBHIWSKJ+36q2alnU1LrXPuvxBknpAdmIJZoApvZjid59IHy
         994eQKQrYYAnjBQgbqSG372zR79vqcci2SifiCckdD3rtbAgc2ctlO/ofxyL7t9/V2l3
         gCOZNTxCLue9Biw4zEsXx4ShEDcrpuFtOhUzsUldjPFZ3at2VdNUEwd4XxwaCreDqw9K
         YmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PrHYFoGNkqmIBES6VjNIm8meeYGsDrmQkyT4aQ80neI=;
        b=kG11H0+8vvFoOrbhAXKWyowLkVVooeXtGcpSySg4ArrOBvJojZv1TzGHasEIaqzkHd
         +K3V5Z7XamXD9b4somyn/DXhx0c6ZNjYQaC2/hMtPdNUd4nzbqRG9XlgankFU5gO+AIg
         2O++HLq7A0QjCGkBNYnH9k8Tz4iVPhnguMl/eKUjB4/m7lhBYN7umJdtW80cfgLCt9+L
         PzEunUcfXEkgp5n/V8hgy7pNa1GQrhQMHgg4ayzOo1x1mVxEqVQQnw8G9OaDd3tK38Hg
         lhOe3o1HKPq1D9XnaSp+8jOGrZtaEHRmGo0/TlW4DHhYU+SjR8gN/yTUuZxKWlLS11Fw
         WpPw==
X-Gm-Message-State: APjAAAVM509YDWrjc+uEKcHFtwlaFufIs4iX9ZgowlELud3Lximi1u+w
        XFxkdu/+xt5sMZ5vHjC1SKQ=
X-Google-Smtp-Source: APXvYqxe7gVh4kpuC2XUvkajAXwDVtpKkxJJrngRQmAuDILadw2e5MedtSEMsa9+f7dO5FzDwEdKmQ==
X-Received: by 2002:a17:90a:270f:: with SMTP id o15mr4359681pje.56.1562844843301;
        Thu, 11 Jul 2019 04:34:03 -0700 (PDT)
Received: from icarus ([2001:268:c144:cf11:d03e:81be:e250:5da0])
        by smtp.gmail.com with ESMTPSA id j1sm14047932pgl.12.2019.07.11.04.33.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Jul 2019 04:34:01 -0700 (PDT)
Date:   Thu, 11 Jul 2019 20:33:41 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     kernel@collabora.com, Gwendal Grignou <gwendal@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>,
        Nick Vaccaro <nvaccaro@chromium.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/1] counter: cros_ec: Add synchronization sensor
Message-ID: <20190711113341.GA5866@icarus>
References: <cover.1562676020.git.fabien.lahoudere@collabora.com>
 <2f7d1c7582ad4005b16e5c8273bcd0100431ff1d.1562676020.git.fabien.lahoudere@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f7d1c7582ad4005b16e5c8273bcd0100431ff1d.1562676020.git.fabien.lahoudere@collabora.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 09, 2019 at 02:59:42PM +0200, Fabien Lahoudere wrote:
> From: Gwendal Grignou <gwendal@chromium.org>
> 
> EC returns a counter when there is an event on camera vsync.
> This patch comes from chromeos kernel 4.4
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
> 
> CROS EC sync sensor was originally designed as an IIO device.
> Now that the counter subsystem will replace IIO_COUNTER, we
> have to implement a new way to get sync count.
> 
> Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>

Thank you for submitting this for inclusion in the mainline kernel. It's
nice to see drivers merged in as well as updated to use the latest
subsystems and improvements. :-)

The Counter subsystem has been introduced, so use of IIO_COUNT is now
deprecated. However, The IIO_COUNT interface will remain for existing
drivers in the mainline kernel (e.g. 104-QUAD-8), but new uses will not
be accepted.

I see that you're still using IIO_COUNT in this driver. Since that
interface is now deprecated, you should convert that code to the Counter
subsystem equivalents. See inline comments for suggestions.

> ---
>  drivers/counter/Kconfig                       |   9 +
>  drivers/counter/Makefile                      |   1 +
>  drivers/counter/cros_ec_sensors_sync.c        | 200 ++++++++++++++++++
>  .../cros_ec_sensors/cros_ec_sensors_core.c    |   1 +
>  drivers/mfd/cros_ec_dev.c                     |   3 +
>  5 files changed, 214 insertions(+)
>  create mode 100644 drivers/counter/cros_ec_sensors_sync.c
> 
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index 2967d0a9ff91..22287f5715e5 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -59,4 +59,13 @@ config FTM_QUADDEC
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ftm-quaddec.
>  
> +config IIO_CROS_EC_SENSORS_SYNC
> +	tristate "ChromeOS EC Counter Sensors"
> +	depends on IIO_CROS_EC_SENSORS_CORE && IIO
> +	help
> +	  Module to handle synchronisation sensors presented by the ChromeOS EC
> +	  Sensor hub.
> +	  Synchronisation sensors are counter sensors triggered when events
> +	  occurs from other subsystems.
> +
>  endif # COUNTER
> diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
> index 40d35522937d..6fe4c98a446f 100644
> --- a/drivers/counter/Makefile
> +++ b/drivers/counter/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
>  obj-$(CONFIG_STM32_TIMER_CNT)	+= stm32-timer-cnt.o
>  obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
>  obj-$(CONFIG_FTM_QUADDEC)	+= ftm-quaddec.o
> +obj-$(CONFIG_IIO_CROS_EC_SENSORS_SYNC) += cros_ec_sensors_sync.o
> diff --git a/drivers/counter/cros_ec_sensors_sync.c b/drivers/counter/cros_ec_sensors_sync.c
> new file mode 100644
> index 000000000000..715a4860cade
> --- /dev/null
> +++ b/drivers/counter/cros_ec_sensors_sync.c
> @@ -0,0 +1,200 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver of counter increaseded after events on interrupt line in EC.

Do you mean "incremented" instead of "increaseded"?

> + *
> + * Copyright 2018 Google, Inc
> + */
> +
> +#include <linux/device.h>
> +#include <linux/counter.h>
> +#include <linux/iio/common/cros_ec_sensors_core.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/cros_ec.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#define DRV_NAME "cros-ec-sync"
> +
> +/*
> + * One channel for counter, the other for timestamp.
> + */
> +#define MAX_CHANNELS (1 + 1)

Since we'll be getting rid of the IIO_COUNT channel, this can simply be
1 for the timestamp channel.

> +
> +/* State data for ec_sensors iio driver. */
> +struct cros_ec_sensors_sync_state {
> +	/* Shared by all sensors */
> +	struct cros_ec_sensors_core_state core;
> +	struct counter_device counter;
> +	struct iio_chan_spec channels[MAX_CHANNELS];
> +};
> +
> +static int cros_ec_sensors_sync_read(struct iio_dev *indio_dev,
> +				     struct iio_chan_spec const *chan,
> +				     int *val, int *val2, long mask)
> +{
> +	struct cros_ec_sensors_sync_state *st = iio_priv(indio_dev);
> +	u16 data;
> +	int ret;
> +	int idx = chan->scan_index;
> +
> +	mutex_lock(&st->core.cmd_lock);
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = cros_ec_sensors_read_cmd(indio_dev, BIT(idx), &data);
> +		if (ret < 0)
> +			break;
> +		ret = IIO_VAL_INT;
> +		*val = data;
> +		break;
> +	default:
> +		ret = cros_ec_sensors_core_read(&st->core, chan, val, val2,
> +						mask);
> +		break;
> +	}
> +	mutex_unlock(&st->core.cmd_lock);
> +	return ret;
> +}

This function can be dedicated to your timestamp channel. Since this
will only support one channel, you should be able to simplify the code
in this function by hardcoding values like 'idx' since it will always be
the same.

> +
> +static int cros_ec_sensors_write(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan,
> +				 int val, int val2, long mask)
> +{
> +	struct cros_ec_sensors_sync_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&st->core.cmd_lock);
> +
> +	ret = cros_ec_sensors_core_write(&st->core, chan, val, val2, mask);
> +
> +	mutex_unlock(&st->core.cmd_lock);
> +	return ret;
> +}
> +
> +static struct iio_info cros_ec_sensors_sync_info = {
> +	.read_raw = &cros_ec_sensors_sync_read,
> +	.write_raw = &cros_ec_sensors_write,
> +	.read_avail = &cros_ec_sensors_core_read_avail,
> +};
> +
> +static struct counter_count cros_ec_sync_counts = {
> +	.id = 0,
> +	.name = "Cros EC sync counter",
> +};
> +
> +static int cros_ec_sync_cnt_read(struct counter_device *counter,
> +				struct counter_count *count,
> +				struct counter_count_read_value *val)
> +{
> +	s16 cnt;
> +	int ret;
> +	struct iio_dev * indio_dev = counter->priv;
> +	struct cros_ec_sensors_sync_state *const st = iio_priv(indio_dev);
> +	unsigned long data;
> +
> +	mutex_lock(&st->core.cmd_lock);
> +	ret = cros_ec_sensors_read_cmd(indio_dev, BIT(0), &cnt);
> +	mutex_unlock(&st->core.cmd_lock);
> +	if (ret != 0) {
> +		dev_warn(&indio_dev->dev, "Unable to read sensor data\n");
> +		return ret;
> +	}
> +
> +	data = (unsigned long) cnt;

This cast is not necessary since data is already unsigned long so the
conversion can occur implicitly.

> +	counter_count_read_value_set(val, COUNTER_COUNT_POSITION, &data);

COUNTER_COUNT_POSITION is used to represent tracking of spatial
positions, but this counter is instead used to count the number of
camera vsync events. You will need to introduce a new count value type
to represent this type of data.

In particular, what are you doing with this data; is this just an always
increasing value that you check as a log? If this is just tallying,
perhaps COUNTER_COUNT_TALLY would be a good name.

In order to introduce this new type, you will need to update a few
files:

* drivers/counter/counter.c:
  Update counter_count_read_value_set and counter_count_write_value_get
  to handle the COUNTER_COUNT_TALLY case; since it matches the interface
  for COUNTER_COUNT_POSITION just fall-through to the
  COUNTER_COUNT_POSITION case code in the switch statements.
* include/linux/counter.h:
  Add COUNTER_COUNT_TALLY to the enum counter_count_value_type
  structure.
* Documentation/driver-api/generic-counter.rst:
  Update the documentation underneath the COUNTER_POSITION reference to
  include COUNT_TALLY with a description describing it as "Unsigned
  integer value representing a tally"

> +
> +	return 0;
> +}
> +
> +static const struct counter_ops cros_ec_sync_cnt_ops = {
> +	.count_read = cros_ec_sync_cnt_read,
> +};

Does the hardware allow the counter to be reset back to zero, or is it
purely read-only?

> +
> +static int cros_ec_sensors_sync_probe(struct platform_device *pdev)
> +{
> +	struct cros_ec_sensors_sync_state *state;
> +	struct device *dev = &pdev->dev;
> +	struct iio_chan_spec *channel;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	ret = cros_ec_sensors_core_init(pdev, indio_dev, true);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->info = &cros_ec_sensors_sync_info;
> +	state = iio_priv(indio_dev);
> +
> +	if (state->core.type != MOTIONSENSE_TYPE_SYNC)
> +		return -EINVAL;
> +
> +	/* Initialize IIO device */
> +	channel = state->channels;
> +	channel->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +	channel->info_mask_shared_by_all = BIT(IIO_CHAN_INFO_FREQUENCY);
> +	channel->scan_type.realbits = CROS_EC_SENSOR_BITS;
> +	channel->scan_type.storagebits = CROS_EC_SENSOR_BITS;
> +	channel->scan_type.shift = 0;
> +	channel->scan_index = 0;
> +	channel->ext_info = cros_ec_sensors_ext_info;
> +	channel->scan_type.sign = 'u';
> +	channel->type = IIO_COUNT;
> +	state->core.calib[0] = 0;

So with cros_ec_sensors_ext_info and the IIO_CHAN_INFO_FREQUENCY
included above, that should result in three auxiliary attributes for
your counter that are global for your device: frequency, calibrate,
location. Did I understand that correctly?

If these attributes are relevant for the counter (is "calibrate"
relevant to the sensor, or just the camera?), you should include
them in the new counter interface as well. You can implement them using
struct counter_device_ext -- look at stm32_count_ext as a reference in
drivers/counter/stm32-timer-cnt.c (although it uses the
counter_count_ext structure, the idea is the same: set "ext" in your
counter_device structure).

Make sure to create a
Documentation/ABI/testing/sysfs-bus-counter-cros-ec file similar to how
you have a Documentation/ABI/testing/sysfs-bus-iio-cros-ec file.

> +
> +	/* Timestamp */
> +	channel++;
> +	channel->type = IIO_TIMESTAMP;
> +	channel->channel = -1;
> +	channel->scan_index = 1;
> +	channel->scan_type.sign = 's';
> +	channel->scan_type.realbits = 64;
> +	channel->scan_type.storagebits = 64;

As stated above, this timestamp channel is the only one needed here, so
you can remove the other channel above.

> +
> +	indio_dev->channels = state->channels;
> +	indio_dev->num_channels = MAX_CHANNELS;
> +
> +	state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> +					      cros_ec_sensors_capture, NULL);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	/* Initialize counter device */
> +	state->counter.name = dev_name(&pdev->dev);
> +	state->counter.parent = &pdev->dev;
> +	state->counter.counts = &cros_ec_sync_counts;
> +	state->counter.num_counts = 1;
> +	state->counter.priv = indio_dev;
> +	state->counter.ops = &cros_ec_sync_cnt_ops;
> +
> +	return devm_counter_register(&pdev->dev, &state->counter);
> +}
> +
> +static const struct platform_device_id cros_ec_sensors_sync_ids[] = {
> +	{ .name = DRV_NAME, },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(platform, cros_ec_sensors_sync_ids);
> +
> +static struct platform_driver cros_ec_sensors_sync_platform_driver = {
> +	.driver = {
> +		.name	= DRV_NAME,
> +		.pm	= &cros_ec_sensors_pm_ops,
> +	},
> +	.probe		= cros_ec_sensors_sync_probe,
> +	.id_table	= cros_ec_sensors_sync_ids,
> +};
> +module_platform_driver(cros_ec_sensors_sync_platform_driver);
> +
> +MODULE_DESCRIPTION("ChromeOS EC synchronisation sensor driver");
> +MODULE_ALIAS("platform:" DRV_NAME);
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 805652250960..2bf183425eaf 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -22,6 +22,7 @@
>  static char *cros_ec_loc[] = {
>  	[MOTIONSENSE_LOC_BASE] = "base",
>  	[MOTIONSENSE_LOC_LID] = "lid",
> +	[MOTIONSENSE_LOC_CAMERA] = "camera",
>  	[MOTIONSENSE_LOC_MAX] = "unknown",
>  };
>  
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 41dccced5026..1c5c2c38af88 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -332,6 +332,9 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
>  		case MOTIONSENSE_TYPE_ACTIVITY:
>  			sensor_cells[id].name = "cros-ec-activity";
>  			break;
> +		case MOTIONSENSE_TYPE_SYNC:
> +			sensor_cells[id].name = "cros-ec-sync";
> +			break;
>  		default:
>  			dev_warn(ec->dev, "unknown type %d\n", resp->info.type);
>  			continue;
> -- 
> 2.19.2

Since this will be a new file, please also add it to the MAINTAINERS
file so we can have a record of the maintainer for this driver.

If you have any troubles or need help understanding the Counter
interface, just let me know and I'll be happy to assist; this subsystem
is new so it'll be good to get all the kinks out that you may find.

Thanks,

William Breathitt Gray
