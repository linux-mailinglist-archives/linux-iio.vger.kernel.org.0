Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03EFE44F411
	for <lists+linux-iio@lfdr.de>; Sat, 13 Nov 2021 17:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbhKMQPc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Nov 2021 11:15:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:48204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231912AbhKMQPc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 13 Nov 2021 11:15:32 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A12160F6E;
        Sat, 13 Nov 2021 16:12:37 +0000 (UTC)
Date:   Sat, 13 Nov 2021 16:17:24 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Cc:     <linux-kernel@vger.kernel.org>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michal.simek@xilinx.com>, <pmeerw@pmeerw.net>,
        <devicetree@vger.kernel.org>,
        Manish Narani <manish.narani@xilinx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v8 2/4] iio: adc: Add Xilinx AMS driver
Message-ID: <20211113161724.371e4bcf@jic23-huawei>
In-Reply-To: <20211108210509.29870-3-anand.ashok.dumbre@xilinx.com>
References: <20211108210509.29870-1-anand.ashok.dumbre@xilinx.com>
        <20211108210509.29870-3-anand.ashok.dumbre@xilinx.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 8 Nov 2021 21:05:07 +0000
Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com> wrote:

> The AMS includes an ADC as well as on-chip sensors that can be used to
> sample external voltages and monitor on-die operating conditions, such
> as temperature and supply voltage levels. The AMS has two SYSMON blocks.
> PL-SYSMON block is capable of monitoring off chip voltage and
> temperature.
> PL-SYSMON block has DRP, JTAG and I2C interface to enable monitoring
> from an external master. Out of these interfaces currently only DRP is
> supported.
> Other block PS-SYSMON is memory mapped to PS.
> The AMS can use internal channels to monitor voltage and temperature as
> well as one primary and up to 16 auxiliary channels for measuring
> external voltages.
> The voltage and temperature monitoring channels also have event
> capability which allows to generate an interrupt when their value falls
> below or raises above a set threshold.
> 
> Co-developed-by: Manish Narani <manish.narani@xilinx.com>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Hi Anand,

+Cc Andy for a question on of_iomap() and whether we should add something similar
to the generic firmware handling.  Personally I'd be happy with leaving it for
now on basis of it being something to come back and tidy up later, but would
like your opinion as you are more familiar with that stuff.

Given you are going around again, I've picked out a few minor things on a final
read through to clean up but subject to the above and review from others I'm happy
with this now and hopefully can pick up v9.

Thanks,

Jonathan


> ---
>  drivers/iio/adc/Kconfig      |   15 +
>  drivers/iio/adc/Makefile     |    1 +
>  drivers/iio/adc/xilinx-ams.c | 1452 ++++++++++++++++++++++++++++++++++
>  3 files changed, 1468 insertions(+)
>  create mode 100644 drivers/iio/adc/xilinx-ams.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index af168e1c9fdb..6d711f401326 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1278,4 +1278,19 @@ config XILINX_XADC
>  	  The driver can also be build as a module. If so, the module will be called
>  	  xilinx-xadc.
>  
> +config XILINX_AMS
> +	tristate "Xilinx AMS driver"
> +	depends on ARCH_ZYNQMP || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  Say yes here to have support for the Xilinx AMS for Ultrascale/Ultrascale+
> +	  System Monitor. With this you can measure and monitor the Voltages and
> +          Temperature values on the SOC.

Already noted in other review thread

> +
> +	  The driver supports Voltage and Temperature monitoring on Xilinx Ultrascale
> +	  devices.
> +
> +	  The driver can also be built as a module. If so, the module will be called
> +	  xilinx-ams.
> +
>  endmenu
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index d68550f493e3..8ced2a3a153f 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -114,4 +114,5 @@ obj-$(CONFIG_VF610_ADC) += vf610_adc.o
>  obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
>  xilinx-xadc-y := xilinx-xadc-core.o xilinx-xadc-events.o
>  obj-$(CONFIG_XILINX_XADC) += xilinx-xadc.o
> +obj-$(CONFIG_XILINX_AMS) += xilinx-ams.o
>  obj-$(CONFIG_SD_ADC_MODULATOR) += sd_adc_modulator.o
> diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> new file mode 100644
> index 000000000000..6e325c4f0a5d
> --- /dev/null
> +++ b/drivers/iio/adc/xilinx-ams.c
> @@ -0,0 +1,1452 @@
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
> +#include <linux/of_address.h>

So this is the last of specific header needed for of_iomap() and
similar.

> +#include <linux/overflow.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/slab.h>
> +
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
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
> + * @irq: interrupt number of the sysmon

Run kernel-doc script over the file and fix the warnings.  Here you
dropped the field in this version but missed the docs.

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
> +	u64 intr_mask;
> +	struct delayed_work ams_unmask_work;
> +};
> +

...


> +
> +static int ams_init_module(struct iio_dev *indio_dev, struct fwnode_handle *np,
> +			   struct iio_chan_spec *channels)
> +{
> +	struct ams *ams = iio_priv(indio_dev);
> +	struct device *dev = indio_dev->dev.parent;
> +	struct device_node *node;
> +	int num_channels = 0;
> +	int ret;
> +
> +	node = to_of_node(np);
> +	if (fwnode_property_match_string(np, "compatible",
> +					 "xlnx,zynqmp-ams-ps") == 0) {
> +		ams->ps_base = of_iomap(node, 0);
> +		if (!ams->ps_base)
> +			return -ENXIO;
> +		ret = devm_add_action_or_reset(dev, ams_iounmap, ams->ps_base);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* add PS channels to iio device channels */
> +		memcpy(channels + num_channels, ams_ps_channels,
> +		       sizeof(ams_ps_channels));
> +		num_channels += ARRAY_SIZE(ams_ps_channels);
> +	} else if (fwnode_property_match_string(np, "compatible",
> +						"xlnx,zynqmp-ams-pl") == 0) {
> +		ams->pl_base = of_iomap(node, 0);

Hmm. So of_iomap() leaves us dependent on dt specific calls. Whilst it doesn't
exactly look hard to create a generic version covering at least dt and acpi
I don' think there is an equivalent acpi function currently defined.

Andy, do you think this is a good thing to add to the generic firmware node
handling?  It's a bit specialist as most of the time this will be wrapped up
in the platform device handling or similar rather than being in a child node like this.


> +		if (!ams->pl_base)
> +			return -ENXIO;
> +
> +		ret = devm_add_action_or_reset(dev, ams_iounmap, ams->pl_base);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* Copy only first 10 fix channels */
> +		memcpy(channels + num_channels, ams_pl_channels,
> +		       AMS_PL_MAX_FIXED_CHANNEL * sizeof(*channels));
> +		num_channels += AMS_PL_MAX_FIXED_CHANNEL;
> +
> +		num_channels = ams_get_ext_chan(np, channels,
> +						num_channels);
> +	} else if (fwnode_property_match_string(np, "compatible",
> +						"xlnx,zynqmp-ams") == 0) {
> +		/* add AMS channels to iio device channels */
> +		memcpy(channels + num_channels, ams_ctrl_channels,
> +		       sizeof(ams_ctrl_channels));
> +		num_channels += ARRAY_SIZE(ams_ctrl_channels);
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	return num_channels;
> +}
> +
> +static int ams_parse_dt(struct iio_dev *indio_dev, struct platform_device *pdev)

Almost nothing in here is dt specific now, so you could rename it ams_parse_firmware()

> +{
> +	struct ams *ams = iio_priv(indio_dev);
> +	struct iio_chan_spec *ams_channels, *dev_channels;
> +	struct fwnode_handle *child_node = NULL, *fwnode = dev_fwnode(&pdev->dev);
> +	int ret, ch_cnt = 0, i, rising_off, falling_off;
> +	unsigned int num_channels = 0;
> +
> +	/* Initialize buffer for channel specification */
> +	ams_channels = kzalloc(sizeof(ams_ps_channels) +
> +			       sizeof(ams_pl_channels) +
> +			       sizeof(ams_ctrl_channels), GFP_KERNEL);
> +	if (!ams_channels)
> +		return -ENOMEM;
> +
> +	if (fwnode_device_is_available(fwnode)) {
> +		ret = ams_init_module(indio_dev, fwnode, ams_channels);
> +		if (ret < 0)
> +			goto err;
> +
> +		num_channels += ret;
> +	}
> +
> +	fwnode_for_each_child_node(fwnode, child_node) {
> +		if (fwnode_device_is_available(child_node)) {
> +			ret = ams_init_module(indio_dev, child_node,
> +					      ams_channels + num_channels);
> +			if (ret < 0) {
> +				fwnode_handle_put(child_node);
> +				goto err;
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
> +	dev_channels = devm_kzalloc(&pdev->dev, sizeof(*dev_channels) *
> +				    num_channels, GFP_KERNEL);
> +	if (!dev_channels) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	memcpy(dev_channels, ams_channels,
> +	       sizeof(*ams_channels) * num_channels);
> +	indio_dev->channels = dev_channels;
> +	indio_dev->num_channels = num_channels;
> +
> +	ret = 0;
> +err:
> +	kfree(ams_channels);
> +
> +	return ret;
> +}
> +
> +static const struct iio_info iio_ams_info = {
> +	.read_raw = &ams_read_raw,
> +	.read_event_config = &ams_read_event_config,
> +	.write_event_config = &ams_write_event_config,
> +	.read_event_value = &ams_read_event_value,
> +	.write_event_value = &ams_write_event_value,
> +};
> +

...

> +static int __maybe_unused ams_resume(struct device *dev)
> +{
> +	struct ams *ams = iio_priv(dev_get_drvdata(dev));
> +	int ret;
> +
> +	ret = clk_prepare_enable(ams->clk);

Given clk_prepare_enable() uses if (ret) to check in all paths we
it will not ever return a positive value so you can shorten this to

	return clk_prepare_enable(ams->clk);

and drop the local variable ret.

> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
...

Jonathan


