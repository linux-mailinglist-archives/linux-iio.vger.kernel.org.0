Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63951454E43
	for <lists+linux-iio@lfdr.de>; Wed, 17 Nov 2021 21:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbhKQUGg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Nov 2021 15:06:36 -0500
Received: from mga09.intel.com ([134.134.136.24]:8555 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231911AbhKQUGe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 17 Nov 2021 15:06:34 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="233878735"
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="233878735"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 12:03:21 -0800
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="672520728"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 12:03:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mnR98-007v6V-3b;
        Wed, 17 Nov 2021 22:03:06 +0200
Date:   Wed, 17 Nov 2021 22:03:05 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, git@xilinx.com, michal.simek@xilinx.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-acpi@vger.kernel.org, heikki.krogerus@linux.intel.com,
        Manish Narani <manish.narani@xilinx.com>
Subject: Re: [PATCH v10 3/5] iio: adc: Add Xilinx AMS driver
Message-ID: <YZVf+Y/KxASvT2MU@smile.fi.intel.com>
References: <20211117161028.11775-1-anand.ashok.dumbre@xilinx.com>
 <20211117161028.11775-4-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211117161028.11775-4-anand.ashok.dumbre@xilinx.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 17, 2021 at 04:10:26PM +0000, Anand Ashok Dumbre wrote:
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

Thanks for an update, my comments below.

...

Missed bitfields.h as kbuild bot noticed.

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

...

> +#define AMS_ALARM_THR_DIRECT_MASK	BIT(1)

> +#define AMS_ALARM_THR_MIN		~(BIT(16) - 1)

This is wrong. I already said it.

> +#define AMS_ALARM_THR_MAX		(BIT(16) - 1)

...

> +enum ams_alarm_bit {
> +	AMS_ALARM_BIT_TEMP,
> +	AMS_ALARM_BIT_SUPPLY1,
> +	AMS_ALARM_BIT_SUPPLY2,
> +	AMS_ALARM_BIT_SUPPLY3,
> +	AMS_ALARM_BIT_SUPPLY4,
> +	AMS_ALARM_BIT_SUPPLY5,
> +	AMS_ALARM_BIT_SUPPLY6,
> +	AMS_ALARM_BIT_RESERVED,
> +	AMS_ALARM_BIT_SUPPLY7,
> +	AMS_ALARM_BIT_SUPPLY8,
> +	AMS_ALARM_BIT_SUPPLY9,
> +	AMS_ALARM_BIT_SUPPLY10,
> +	AMS_ALARM_BIT_VCCAMS,
> +	AMS_ALARM_BIT_TEMP_REMOTE

+Comma, same to the rest where the last item is not a terminator one.

> +};
> +
> +enum ams_seq {
> +	AMS_SEQ_VCC_PSPLL,
> +	AMS_SEQ_VCC_PSBATT,
> +	AMS_SEQ_VCCINT,
> +	AMS_SEQ_VCCBRAM,
> +	AMS_SEQ_VCCAUX,
> +	AMS_SEQ_PSDDRPLL,
> +	AMS_SEQ_INTDDR

...like here.

> +};

> +enum ams_ps_pl_seq {
> +	AMS_SEQ_CALIB,
> +	AMS_SEQ_RSVD_1,
> +	AMS_SEQ_RSVD_2,
> +	AMS_SEQ_TEST,
> +	AMS_SEQ_RSVD_4,
> +	AMS_SEQ_SUPPLY4,
> +	AMS_SEQ_SUPPLY5,
> +	AMS_SEQ_SUPPLY6,
> +	AMS_SEQ_TEMP,
> +	AMS_SEQ_SUPPLY2,
> +	AMS_SEQ_SUPPLY1,
> +	AMS_SEQ_VP_VN,
> +	AMS_SEQ_VREFP,
> +	AMS_SEQ_VREFN,
> +	AMS_SEQ_SUPPLY3,
> +	AMS_SEQ_CURRENT_MON,
> +	AMS_SEQ_SUPPLY7,
> +	AMS_SEQ_SUPPLY8,
> +	AMS_SEQ_SUPPLY9,
> +	AMS_SEQ_SUPPLY10,
> +	AMS_SEQ_VCCAMS,
> +	AMS_SEQ_TEMP_REMOTE,
> +	AMS_SEQ_MAX

...but not here!

> +};

...

> +#define AMS_SEQ(x)		(AMS_SEQ_MAX + (x))
> +#define AMS_VAUX_SEQ(x)		(AMS_SEQ_MAX + (x))

What's the difference?

> +#define AMS_PS_SEQ_MAX		AMS_SEQ_MAX

Perhaps this should be above (for the sake of easier reading).

> +#define PS_SEQ(x)		(x)
> +#define PL_SEQ(x)		(AMS_PS_SEQ_MAX + (x))
> +#define AMS_CTRL_SEQ_BASE	(AMS_PS_SEQ_MAX * 3)

...

> +		ret = readl_poll_timeout(ams->base + AMS_PS_CSTS, reg,
> +					 (reg & expect), 0,

Parentheses are not needed.
WHy 0? Is it okay to load CPU like this?

> +					 AMS_INIT_TIMEOUT_US);
> +		if (ret)
> +			return ret;

...

> +	if (ams->pl_base) {
> +		reg = readl(ams->base + AMS_PL_CSTS);
> +		if (reg == 0)

> +			return (int) reg;

I already said that this is wrong.

> +		writel(AMS_PL_RESET_VALUE, ams->pl_base + AMS_VP_VN);
> +
> +		/* put sysmon in a default state */
> +		ams_pl_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
> +				  AMS_CONF1_SEQ_DEFAULT);
> +	}

...

> +	ret = readl_poll_timeout(ams->base + AMS_ISR_1, reg,
> +				 (reg & expect), 0, AMS_INIT_TIMEOUT_US);
> +	if (ret)
> +		return ret;

Same two comments as per above readl_poll_timeout() usage.

...

> +			ret = ams_read_vcc_reg(ams, chan->address, val);
> +			if (ret) {
> +				mutex_unlock(&ams->lock);
> +				return -EINVAL;

Shadowed error code.

> +			}

...

> +	case IIO_CHAN_INFO_OFFSET:
> +		/* Only the temperature channel has an offset */
> +		*val = AMS_TEMP_OFFSET;
> +		return IIO_VAL_INT;
> +	}

> +	return -EINVAL;

Why not keep it in the default case?

…

> +	switch (event) {
> +	case AMS_ALARM_BIT_TEMP:
> +		scan_index += AMS_SEQ_TEMP;
> +		break;
> +	case AMS_ALARM_BIT_SUPPLY1:
> +		scan_index += AMS_SEQ_SUPPLY1;
> +		break;
> +	case AMS_ALARM_BIT_SUPPLY2:
> +		scan_index += AMS_SEQ_SUPPLY2;
> +		break;
> +	case AMS_ALARM_BIT_SUPPLY3:
> +		scan_index += AMS_SEQ_SUPPLY3;
> +		break;
> +	case AMS_ALARM_BIT_SUPPLY4:
> +		scan_index += AMS_SEQ_SUPPLY4;
> +		break;
> +	case AMS_ALARM_BIT_SUPPLY5:
> +		scan_index += AMS_SEQ_SUPPLY5;
> +		break;
> +	case AMS_ALARM_BIT_SUPPLY6:
> +		scan_index += AMS_SEQ_SUPPLY6;
> +		break;
> +	case AMS_ALARM_BIT_SUPPLY7:
> +		scan_index += AMS_SEQ_SUPPLY7;
> +		break;
> +	case AMS_ALARM_BIT_SUPPLY8:
> +		scan_index += AMS_SEQ_SUPPLY8;
> +		break;
> +	case AMS_ALARM_BIT_SUPPLY9:
> +		scan_index += AMS_SEQ_SUPPLY9;
> +		break;
> +	case AMS_ALARM_BIT_SUPPLY10:
> +		scan_index += AMS_SEQ_SUPPLY10;
> +		break;
> +	case AMS_ALARM_BIT_VCCAMS:
> +		scan_index += AMS_SEQ_VCCAMS;
> +		break;
> +	case AMS_ALARM_BIT_TEMP_REMOTE:
> +		scan_index += AMS_SEQ_TEMP_REMOTE;
> +		break;

default: ?

> +	}

...

> +	if (chan->type == IIO_TEMP) {
> +		offset = ams_get_alarm_offset(chan->scan_index,
> +					      IIO_EV_DIR_FALLING);

One line?

> +	}

...

> +	const struct iio_chan_spec *chan;
> +
> +	chan = ams_event_to_channel(indio_dev, event);

Can be done in one line.


> +	/* Only process alarms that are not masked */
> +	isr0 &= ~((ams->intr_mask & AMS_ISR0_ALARM_MASK) | ams->masked_alarm);

> +

Redundant blank line.

> +	if (!isr0) {
> +		spin_unlock(&ams->intr_lock);
> +		return IRQ_NONE;
> +	}

...

> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
> +				BIT(IIO_EV_INFO_VALUE),

One line?

...

> +	fwnode_for_each_child_node(chan_node, child) {
> +		ret = fwnode_property_read_u32(child, "reg", &reg);

> +		if (ret || reg > (AMS_PL_MAX_EXT_CHANNEL + 30))

Too many parentheses.

> +			continue;

> +		memcpy(&channels[num_channels], &ams_pl_channels[reg +
> +		       AMS_PL_MAX_FIXED_CHANNEL - 30], sizeof(*channels));
> +
> +		if (fwnode_property_read_bool(child, "xlnx,bipolar"))
> +			channels[num_channels].scan_type.sign =	's';

Use temporary variable for &channels[num_channels] in both cases.

> +		num_channels++;
> +	}

...

> +		memcpy(channels + num_channels, ams_ps_channels,
> +		       sizeof(ams_ps_channels));

Ditto.

...

> +		memcpy(channels + num_channels, ams_pl_channels,
> +		       AMS_PL_MAX_FIXED_CHANNEL * sizeof(*channels));

Ditto.

...

> +		memcpy(channels + num_channels, ams_ctrl_channels,
> +		       sizeof(ams_ctrl_channels));

Ditto.

...

> +static int ams_parse_firmware(struct iio_dev *indio_dev,
> +			      struct platform_device *pdev)

Why do you need second parameter? Doesn't indio_dev already have it?

> +{
> +	struct ams *ams = iio_priv(indio_dev);
> +	struct iio_chan_spec *ams_channels, *dev_channels;
> +	struct fwnode_handle *child = NULL, *fwnode = dev_fwnode(&pdev->dev);
> +	size_t dev_chan_size, ams_chan_size, num_chan;
> +	int ret, ch_cnt = 0, i, rising_off, falling_off;
> +	unsigned int num_channels = 0;
> +
> +

One blank line is enough.

> +	num_chan = ARRAY_SIZE(ams_ps_channels) + ARRAY_SIZE(ams_pl_channels) +
> +		ARRAY_SIZE(ams_ctrl_channels);

> +	ams_chan_size = array_size(num_chan, sizeof(struct iio_chan_spec));
> +	if (ams_chan_size == SIZE_MAX)
> +		return -EINVAL;

Why is this needed now since you are using kcalloc()?

> +	/* Initialize buffer for channel specification */
> +	ams_channels = kcalloc(num_chan, sizeof(struct iio_chan_spec), GFP_KERNEL);

sizeof(*ams_channels)

> +	if (!ams_channels)
> +		return -ENOMEM;

...

> +			ret = ams_init_module(indio_dev, child,
> +					      ams_channels + num_channels);

One line?

...

> +				writel(AMS_ALARM_THR_MIN,
> +				       ams->pl_base + falling_off);
> +				writel(AMS_ALARM_THR_MAX,
> +				       ams->pl_base + rising_off);

Ditto.

...

> +				writel(AMS_ALARM_THR_MIN,
> +				       ams->ps_base + falling_off);
> +				writel(AMS_ALARM_THR_MAX,
> +				       ams->ps_base + rising_off);

Ditto.

> +	dev_chan_size = array_size((size_t)num_channels, sizeof(struct iio_chan_spec));
> +	if (dev_chan_size == SIZE_MAX)
> +		return -EINVAL;

Why is it needed now?

> +	dev_channels = devm_kcalloc(&pdev->dev, (size_t)num_channels,

Why casting?

> +				    sizeof(struct iio_chan_spec), GFP_KERNEL);

sizeof(*dev_channels)

> +	if (!dev_channels) {
> +		ret = -ENOMEM;
> +		goto free_mem;
> +	}

> +	memcpy(dev_channels, ams_channels,
> +	       sizeof(*ams_channels) * num_channels);

Hmm... according to the code the num_channels can be less than or equal to
num_chan. Hence, what you should use is the devm_krealloc_array().

static inline void *devm_krealloc_aray(...)
{
	...see how krealloc_array() is defined...
}

No need to copy memory again.

...

> +	ret = 0;
> +
> +free_mem:
> +	kfree(ams_channels);
> +
> +	return ret;

This will go away after switching to devm_kmalloc_array() +
devm_krealloc_array().

...

> +	ret = ams_parse_firmware(indio_dev, pdev);
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret, "failure in parsing DT\n");
> +		return ret;

	return dev_err_probe(...);

Ditto for the rest similar cases.

> +	}

-- 
With Best Regards,
Andy Shevchenko


