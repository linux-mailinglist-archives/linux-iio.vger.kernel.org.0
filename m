Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD672457F9A
	for <lists+linux-iio@lfdr.de>; Sat, 20 Nov 2021 17:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhKTQwT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Nov 2021 11:52:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:35982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230507AbhKTQwT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Nov 2021 11:52:19 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C48CF600D4;
        Sat, 20 Nov 2021 16:49:12 +0000 (UTC)
Date:   Sat, 20 Nov 2021 16:54:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Cc:     <linux-kernel@vger.kernel.org>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michal.simek@xilinx.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>,
        <heikki.krogerus@linux.intel.com>,
        Manish Narani <manish.narani@xilinx.com>
Subject: Re: [PATCH v10 3/5] iio: adc: Add Xilinx AMS driver
Message-ID: <20211120165345.53de0d51@jic23-huawei>
In-Reply-To: <20211117161028.11775-4-anand.ashok.dumbre@xilinx.com>
References: <20211117161028.11775-1-anand.ashok.dumbre@xilinx.com>
        <20211117161028.11775-4-anand.ashok.dumbre@xilinx.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 17 Nov 2021 16:10:26 +0000
Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com> wrote:

> The AMS includes an ADC as well as on-chip sensors that can be used to
> sample external voltages and monitor on-die operating conditions, such
> as temperature and supply voltage levels. The AMS has two SYSMON blocks.
> PL-SYSMON block is capable of monitoring off chip voltage and
> temperature.
> 
> PL-SYSMON block has DRP, JTAG and I2C interface to enable monitoring
> from an external master. Out of these interfaces currently only DRP is
> supported. Other block PS-SYSMON is memory mapped to PS.
> 
> The AMS can use internal channels to monitor voltage and temperature as
> well as one primary and up to 16 auxiliary channels for measuring
> external voltages.
> 
> The voltage and temperature monitoring channels also have event capability
> which allows to generate an interrupt when their value falls below or
> raises above a set threshold.
> 
> Co-developed-by: Manish Narani <manish.narani@xilinx.com>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>

A few minor additions from me to what Andy has noted.

Thanks,

Jonathan

> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index d3f53549720c..4a8f1833993b 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -115,4 +115,5 @@ obj-$(CONFIG_VF610_ADC) += vf610_adc.o
>  obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
>  xilinx-xadc-y := xilinx-xadc-core.o xilinx-xadc-events.o
>  obj-$(CONFIG_XILINX_XADC) += xilinx-xadc.o
> +obj-$(CONFIG_XILINX_AMS) += xilinx-ams.o
>  obj-$(CONFIG_SD_ADC_MODULATOR) += sd_adc_modulator.o
> diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> new file mode 100644
> index 000000000000..bb3876b51e3e
> --- /dev/null
> +++ b/drivers/iio/adc/xilinx-ams.c
> @@ -0,0 +1,1447 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx AMS driver
> + *
> + *  Copyright (C) 2021 Xilinx, Inc.
> + *
> + *  Manish Narani <mnarani@xilinx.com>
> + *  Rajnikant Bhojani <rajnikant.bhojani@xilinx.com>
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/overflow.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/slab.h>
> +
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
Used?
> +

...

> +/**
> + * struct ams - Driver data for xilinx-ams
> + * @base: physical base address of device
> + * @ps_base: physical base address of PS device
> + * @pl_base: physical base address of PL device
> + * @clk: clocks associated with the device
> + * @dev: pointer to device struct
> + * @lock: to handle multiple user interaction
> + * @intr_lock: to protect interrupt mask values
> + * @alarm_mask: alarm configuration
> + * @masked_alarm: currently masked due to alarm
> + * @intr_mask: interrupt configuration
> + * @ams_unmask_work: re-enables event once the event condition disappears
> + *
> + * This structure contains necessary state for Sysmon driver to operate
> + */
> +struct ams {
> +	void __iomem *base;
> +	void __iomem *ps_base;
> +	void __iomem *pl_base;
> +	struct clk *clk;
> +	struct device *dev;
> +	struct mutex lock;
> +	spinlock_t intr_lock;
> +	unsigned int alarm_mask;
> +	unsigned int masked_alarm;

Hmm. maybe a rename to make these two less confusing?
Perhaps
current_masked_alarm?

> +	u64 intr_mask;
> +	struct delayed_work ams_unmask_work;
> +};
> +


...


> +
> +static void ams_handle_event(struct iio_dev *indio_dev, u32 event)
> +{
> +	const struct iio_chan_spec *chan;
> +
> +	chan = ams_event_to_channel(indio_dev, event);
> +
> +	if (chan->type == IIO_TEMP) {
> +		/*
> +		 * The temperature channel only supports over-temperature
> +		 * events.
> +		 */
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_RISING),
> +			iio_get_time_ns(indio_dev));
> +	} else {
> +		/*
> +		 * For other channels we don't know whether it is a upper or
> +		 * lower threshold event. Userspace will have to check the
> +		 * channel value if it wants to know.
> +		 */
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_EITHER),
> +			iio_get_time_ns(indio_dev));

I think alignment is wrong here. iio_get_time_ns() should align with opening bracket as well.

> +	}
> +}
> +

...

> +
> +static int ams_parse_firmware(struct iio_dev *indio_dev,
> +			      struct platform_device *pdev)
> +{
> +	struct ams *ams = iio_priv(indio_dev);
> +	struct iio_chan_spec *ams_channels, *dev_channels;
> +	struct fwnode_handle *child = NULL, *fwnode = dev_fwnode(&pdev->dev);

Where you have values being set, I'd prefer separate line per variable.
Tends to be a little more readable and we need all the help we can get :)

> +	size_t dev_chan_size, ams_chan_size, num_chan;
> +	int ret, ch_cnt = 0, i, rising_off, falling_off;
> +	unsigned int num_channels = 0;
> +

One blank line is almost always enough. Definitely is here.

> +
> +	num_chan = ARRAY_SIZE(ams_ps_channels) + ARRAY_SIZE(ams_pl_channels) +
> +		ARRAY_SIZE(ams_ctrl_channels);
> +
> +	ams_chan_size = array_size(num_chan, sizeof(struct iio_chan_spec));
> +	if (ams_chan_size == SIZE_MAX)
> +		return -EINVAL;
> +
> +	/* Initialize buffer for channel specification */
> +	ams_channels = kcalloc(num_chan, sizeof(struct iio_chan_spec), GFP_KERNEL);
> +	if (!ams_channels)
> +		return -ENOMEM;
> +
> +	if (fwnode_device_is_available(fwnode)) {
> +		ret = ams_init_module(indio_dev, fwnode, ams_channels);
> +		if (ret < 0)
> +			goto free_mem;
> +
> +		num_channels += ret;
> +	}
> +
> +	fwnode_for_each_child_node(fwnode, child) {
> +		if (fwnode_device_is_available(child)) {
> +			ret = ams_init_module(indio_dev, child,
> +					      ams_channels + num_channels);
> +			if (ret < 0) {
> +				fwnode_handle_put(child);
> +				goto free_mem;
> +			}
> +
> +			num_channels += ret;
> +		}
> +	}
> +
> +	for (i = 0; i < num_channels; i++) {
> +		ams_channels[i].channel = ch_cnt++;
> +
> +		if (ams_channels[i].scan_index < AMS_CTRL_SEQ_BASE) {
> +			/* set threshold to max and min for each channel */
> +			falling_off =
> +				ams_get_alarm_offset(ams_channels[i].scan_index,
> +						     IIO_EV_DIR_FALLING);
> +			rising_off =
> +				ams_get_alarm_offset(ams_channels[i].scan_index,
> +						     IIO_EV_DIR_RISING);
> +			if (ams_channels[i].scan_index >= AMS_PS_SEQ_MAX) {
> +				writel(AMS_ALARM_THR_MIN,
> +				       ams->pl_base + falling_off);
> +				writel(AMS_ALARM_THR_MAX,
> +				       ams->pl_base + rising_off);
> +			} else {
> +				writel(AMS_ALARM_THR_MIN,
> +				       ams->ps_base + falling_off);
> +				writel(AMS_ALARM_THR_MAX,
> +				       ams->ps_base + rising_off);
> +			}
> +		}
> +	}
> +
> +	dev_chan_size = array_size((size_t)num_channels, sizeof(struct iio_chan_spec));
> +	if (dev_chan_size == SIZE_MAX)

Why not goto free_mem for this error case?
Obviously should never happen, but should handle the error anyway.

> +		return -EINVAL;
> +
> +	dev_channels = devm_kcalloc(&pdev->dev, (size_t)num_channels,
> +				    sizeof(struct iio_chan_spec), GFP_KERNEL);
> +	if (!dev_channels) {
> +		ret = -ENOMEM;
> +		goto free_mem;
> +	}
> +
> +	memcpy(dev_channels, ams_channels,
> +	       sizeof(*ams_channels) * num_channels);
> +	indio_dev->channels = dev_channels;
> +	indio_dev->num_channels = num_channels;
> +
> +	ret = 0;
> +
> +free_mem:
> +	kfree(ams_channels);
> +
> +	return ret;
> +}


