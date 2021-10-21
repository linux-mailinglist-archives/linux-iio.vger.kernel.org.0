Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACF4435FD7
	for <lists+linux-iio@lfdr.de>; Thu, 21 Oct 2021 13:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhJULEc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Oct 2021 07:04:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhJULE0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 21 Oct 2021 07:04:26 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D27C60FF2;
        Thu, 21 Oct 2021 11:02:08 +0000 (UTC)
Date:   Thu, 21 Oct 2021 12:06:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Cc:     <linux-kernel@vger.kernel.org>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michal.simek@xilinx.com>, <pmeerw@pmeerw.net>,
        <devicetree@vger.kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Subject: Re: [PATCH v7 2/4] iio: adc: Add Xilinx AMS driver
Message-ID: <20211021120626.56cf1b8d@jic23-huawei>
In-Reply-To: <20211019152048.28983-3-anand.ashok.dumbre@xilinx.com>
References: <20211019152048.28983-1-anand.ashok.dumbre@xilinx.com>
        <20211019152048.28983-3-anand.ashok.dumbre@xilinx.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 19 Oct 2021 16:20:46 +0100
Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com> wrote:

> The AMS includes an ADC as well as on-chip sensors that can be used to
> sample external voltages and monitor on-die operating conditions, such
> as temperature and supply voltage levels. The AMS has two SYSMON blocks.
> PL-SYSMON block is capable of monitoring off chip voltage and
> temperature.
> PL-SYSMON block has DRP, JTAG and I2C interface to enable monitoring
> from external master. Out of these interface currently only DRP is
> supported.
> Other block PS-SYSMON is memory mapped to PS.
> The AMS can use internal channels to monitor voltage and temperature as
> well as one primary and up to 16 auxiliary channels for measuring
> external voltages.
> The voltage and temperature monitoring channels also have event
> capability which allows to generate an interrupt when their value falls
> below or raises above a set threshold.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>

It would be good at some point to move away from of specific firmware property
reading, but on a platform like this I guess you can be fairly sure no one will
be using ACPI or other firmware description options so I'm not going to insist
on it for an initial merge.

Other comment I have are fairly minor but we need to leave some time
for other reviews and in particular DT binding review.

> ---
>  drivers/iio/adc/Kconfig      |   13 +
>  drivers/iio/adc/Makefile     |    1 +
>  drivers/iio/adc/xilinx-ams.c | 1341 ++++++++++++++++++++++++++++++++++
>  3 files changed, 1355 insertions(+)
>  create mode 100644 drivers/iio/adc/xilinx-ams.c

...

> diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> new file mode 100644
> index 000000000000..597cdda8a618
> --- /dev/null
> +++ b/drivers/iio/adc/xilinx-ams.c
> @@ -0,0 +1,1341 @@
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
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
#include <linux/mod_devicetable.h> for the of_device_id structure defintion.

> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
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
> + * @masked_alarm: currently masked due to alarm
> + * @alarm_mask: alarm configuration
> + * @interrupt_mask: interrupt configuration
> + * @irq: interrupt number of the sysmon
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
> +	/* check kernel doc above */
> +	struct mutex lock;
> +	/* check kernel doc above */
> +	spinlock_t intr_lock;
> +	unsigned int alarm_mask;
Docs should be same order as the fields.
> +	unsigned int masked_alarm;
> +	u64 intr_mask;

That's not the name in the docs.  Run kernel-doc script over this and
fix all the errors / warnings.

> +	int irq;
> +	struct delayed_work ams_unmask_work;
> +};
> +

...

> +
> +static irqreturn_t ams_irq(int irq, void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +	struct ams *ams = iio_priv(indio_dev);
> +	u32 isr0;
> +
> +	spin_lock(&ams->intr_lock);
> +
> +	isr0 = readl(ams->base + AMS_ISR_0);
> +
> +	/* only process alarms that are not masked */
> +	isr0 &= ~((ams->intr_mask & AMS_ISR0_ALARM_MASK) | ams->masked_alarm);
> +
> +	if (!isr0)

lock held.

> +		return IRQ_NONE;
> +
> +	/* clear interrupt */
> +	writel(isr0, ams->base + AMS_ISR_0);
> +
> +	/* Mask the alarm interrupts until cleared */
> +	ams->masked_alarm |= isr0;
> +	ams_update_intrmask(ams, 0, 0);
> +
> +	ams_handle_events(indio_dev, isr0);
> +
> +	schedule_delayed_work(&ams->ams_unmask_work,
> +			      msecs_to_jiffies(AMS_UNMASK_TIMEOUT_MS));
> +
> +	spin_unlock(&ams->intr_lock);
> +
> +	return IRQ_HANDLED;
> +}
> +

...

> +
> +static int ams_parse_dt(struct iio_dev *indio_dev, struct platform_device *pdev)
> +{
> +	struct ams *ams = iio_priv(indio_dev);
> +	struct iio_chan_spec *ams_channels, *dev_channels;
> +	struct device_node *child_node = NULL, *np = pdev->dev.of_node;
> +	int ret, vol_ch_cnt = 0, temp_ch_cnt = 0, i, rising_off, falling_off;
> +	unsigned int num_channels = 0;
> +
> +	/* Initialize buffer for channel specification */
> +	ams_channels = kzalloc(sizeof(ams_ps_channels) +
> +			       sizeof(ams_pl_channels) +
> +			       sizeof(ams_ctrl_channels), GFP_KERNEL);
> +	if (!ams_channels)
> +		return -ENOMEM;
> +
> +	if (of_device_is_available(np)) {
> +		ret = ams_init_module(indio_dev, np, ams_channels);
> +		if (ret < 0)
> +			goto err;
> +
> +		num_channels += ret;
> +	}
> +
> +	for_each_child_of_node(np, child_node) {
> +		if (of_device_is_available(child_node)) {
> +			ret = ams_init_module(indio_dev, child_node,
> +					      ams_channels + num_channels);
> +			if (ret < 0)
> +				goto err;

for_each_child_of_node() holds a reference if we jump out of the loop
before it terminates.
https://elixir.bootlin.com/linux/latest/source/drivers/of/base.c#L715
is where it ultimately releases that reference when the loop is terminating.
Her you need to do it manually with an of_node_put() call

> +
> +			num_channels += ret;
> +		}
> +	}
> +
> +	for (i = 0; i < num_channels; i++) {
> +		if (ams_channels[i].type == IIO_VOLTAGE)
> +			ams_channels[i].channel = vol_ch_cnt++;
> +		else
> +			ams_channels[i].channel = temp_ch_cnt++;
> +
> +		if (ams_channels[i].scan_index < (AMS_PS_SEQ_MAX * 3)) {
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

We now have the option of devm_krealloc()   If you used that in conjunction
with devm_kzalloc to replace the kzalloc above, you could avoid this need to
copy.  Not important though if you prefer doing this manual version.

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

...

> +static int ams_probe(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ams *ams;
> +	int ret;
> +
> +	if (!pdev->dev.of_node)
> +		return -ENODEV;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*ams));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	ams = iio_priv(indio_dev);
> +	mutex_init(&ams->lock);
> +	spin_lock_init(&ams->intr_lock);
> +
> +	indio_dev->name = "xilinx-ams";
> +
> +	indio_dev->info = &iio_ams_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ams->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(ams->base))
> +		return PTR_ERR(ams->base);
> +
> +	ams->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(ams->clk))
> +		return PTR_ERR(ams->clk);
> +	clk_prepare_enable(ams->clk);
> +	devm_add_action_or_reset(&pdev->dev, ams_clk_disable_unprepare,
> +				 ams->clk);
> +
> +	INIT_DELAYED_WORK(&ams->ams_unmask_work, ams_unmask_worker);
> +	devm_add_action_or_reset(&pdev->dev, ams_cancel_delayed_work,
> +				 &ams->ams_unmask_work);
> +
> +	ret = ams_init_device(ams);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to initialize AMS\n");
> +		return ret;
> +	}
> +
> +	ret = ams_parse_dt(indio_dev, pdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failure in parsing DT\n");
> +		return ret;
> +	}
> +
> +	ams_enable_channel_sequence(indio_dev);
> +
> +	ams->irq = platform_get_irq(pdev, 0);
> +	if (ams->irq == -EPROBE_DEFER) {
> +		ret = -EPROBE_DEFER;
> +		return ret;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, ams->irq, &ams_irq, 0, "ams-irq",
> +			       indio_dev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to register interrupt\n");
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	ret = devm_iio_device_register(&pdev->dev, indio_dev);
> +

return devm_...

> +	return ret;
> +}
> +


