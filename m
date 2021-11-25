Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E05745D9E8
	for <lists+linux-iio@lfdr.de>; Thu, 25 Nov 2021 13:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240193AbhKYMXM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Nov 2021 07:23:12 -0500
Received: from mga14.intel.com ([192.55.52.115]:21817 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241277AbhKYMVL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 25 Nov 2021 07:21:11 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="235746964"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="235746964"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 04:14:29 -0800
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="457387129"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 04:14:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mqDdv-00AQZq-Ow;
        Thu, 25 Nov 2021 14:14:23 +0200
Date:   Thu, 25 Nov 2021 14:14:23 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, git@xilinx.com, michal.simek@xilinx.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-acpi@vger.kernel.org, heikki.krogerus@linux.intel.com,
        Manish Narani <manish.narani@xilinx.com>
Subject: Re: [PATCH v11 3/5] iio: adc: Add Xilinx AMS driver
Message-ID: <YZ9+HxSRmT1XHld2@smile.fi.intel.com>
References: <20211124225407.17793-1-anand.ashok.dumbre@xilinx.com>
 <20211124225407.17793-4-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124225407.17793-4-anand.ashok.dumbre@xilinx.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 24, 2021 at 10:54:05PM +0000, Anand Ashok Dumbre wrote:
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

...

> +#define AMS_IDR_1			0x02c
...
> +#define AMS_VCC_PSPLL3			0x06C
...
> +#define AMS_VCCBRAM			0x07C
...
> +#define AMS_PSINTFPDDR			0x09C
...and so on

Be consistent with the capitalization in the hex values.

...

> +#define AMS_INIT_POLL_TIME		200

Does it need unit?

> +#define AMS_SUPPLY_SCALE_1VOLT		1000
> +#define AMS_SUPPLY_SCALE_3VOLT		3000
> +#define AMS_SUPPLY_SCALE_6VOLT		6000

I would rather make units with these:

#define AMS_SUPPLY_SCALE_1VOLT_mV		1000
#define AMS_SUPPLY_SCALE_3VOLT_mV		3000
#define AMS_SUPPLY_SCALE_6VOLT_mV		6000

...

> +#define AMS_PL_AUX_CHAN_VOLTAGE(_auxno) \

> +	AMS_CHAN_VOLTAGE(PL_SEQ(AMS_SEQ(_auxno)), \
> +			AMS_REG_VAUX(_auxno), false)

One line?

> +#define AMS_CTRL_CHAN_VOLTAGE(_scan_index, _addr) \

> +	AMS_CHAN_VOLTAGE(PL_SEQ(AMS_SEQ(AMS_SEQ(_scan_index))), \
> +			_addr, false)

Ditto.

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
> + * @current_masked_alarm: currently masked due to alarm
> + * @intr_mask: interrupt configuration
> + * @ams_unmask_work: re-enables event once the event condition disappears

> + * This structure contains necessary state for Sysmon driver to operate

Shouldn't be this "state for Sysmon driver to operate" a summary above?

> + */

...

> +	u32 reg, value;
> +	u32 expect = AMS_PS_CSTS_PS_READY;
> +	int ret;

	u32 expect = AMS_PS_CSTS_PS_READY;
	u32 reg, value;
	int ret;

...

> +	u32 reg;
> +	u32 expect = AMS_ISR1_EOC_MASK;
> +	int ret;

Ditto.

...

> +	ret = readl_poll_timeout(ams->base + AMS_ISR_1, reg,
> +				 (reg & expect), AMS_INIT_POLL_TIME, AMS_INIT_TIMEOUT_US);

Something wrong with line lengths... There is enough space on previous line for
one parameter.

> +	if (ret)
> +		return ret;

...

> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&ams->lock);
> +		if (chan->scan_index >= AMS_CTRL_SEQ_BASE) {
> +			ret = ams_read_vcc_reg(ams, chan->address, val);
> +			if (ret) {

> +				mutex_unlock(&ams->lock);
> +				return ret;

Can it be
				goto out_unlock;

> +			}
> +			ams_enable_channel_sequence(indio_dev);
> +		} else if (chan->scan_index >= AMS_PS_SEQ_MAX)
> +			*val = readl(ams->pl_base + chan->address);
> +		else
> +			*val = readl(ams->ps_base + chan->address);

		ret = IIO_VAL_INT;
out_unlock:

> +		mutex_unlock(&ams->lock);
> +
> +		return IIO_VAL_INT;

		mutex_unlock(&ams->lock);
		return ret;

?

Also the question, why mutex only against INFO_RAW case?

...

> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			if (chan->scan_index < AMS_PS_SEQ_MAX) {
> +				switch (chan->address) {
> +				case AMS_SUPPLY1:
> +				case AMS_SUPPLY2:
> +				case AMS_SUPPLY3:
> +				case AMS_SUPPLY4:
> +				case AMS_SUPPLY9:
> +				case AMS_SUPPLY10:
> +				case AMS_VCCAMS:
> +					*val = AMS_SUPPLY_SCALE_3VOLT;
> +					break;
> +				case AMS_SUPPLY5:
> +				case AMS_SUPPLY6:
> +				case AMS_SUPPLY7:
> +				case AMS_SUPPLY8:
> +					*val = AMS_SUPPLY_SCALE_6VOLT;
> +					break;
> +				default:
> +					*val = AMS_SUPPLY_SCALE_1VOLT;
> +					break;
> +				}
> +			} else if (chan->scan_index >= AMS_PS_SEQ_MAX &&
> +				   chan->scan_index < AMS_CTRL_SEQ_BASE) {
> +				switch (chan->address) {
> +				case AMS_SUPPLY1:
> +				case AMS_SUPPLY2:
> +				case AMS_SUPPLY3:
> +				case AMS_SUPPLY4:
> +				case AMS_SUPPLY5:
> +				case AMS_SUPPLY6:
> +				case AMS_VCCAMS:
> +				case AMS_VREFP:
> +				case AMS_VREFN:
> +					*val = AMS_SUPPLY_SCALE_3VOLT;
> +					break;
> +				case AMS_SUPPLY7:
> +					regval = readl(ams->pl_base + AMS_REG_CONFIG4);
> +					if (FIELD_GET(AMS_VUSER0_MASK, regval))
> +						*val = AMS_SUPPLY_SCALE_6VOLT;
> +					else
> +						*val = AMS_SUPPLY_SCALE_3VOLT;
> +					break;
> +				case AMS_SUPPLY8:
> +					regval = readl(ams->pl_base + AMS_REG_CONFIG4);
> +					if (FIELD_GET(AMS_VUSER1_MASK, regval))
> +						*val = AMS_SUPPLY_SCALE_6VOLT;
> +					else
> +						*val = AMS_SUPPLY_SCALE_3VOLT;
> +					break;
> +				case AMS_SUPPLY9:
> +					regval = readl(ams->pl_base + AMS_REG_CONFIG4);
> +					if (FIELD_GET(AMS_VUSER2_MASK, regval))
> +						*val = AMS_SUPPLY_SCALE_6VOLT;
> +					else
> +						*val = AMS_SUPPLY_SCALE_3VOLT;
> +					break;
> +				case AMS_SUPPLY10:
> +					regval = readl(ams->pl_base + AMS_REG_CONFIG4);
> +					if (FIELD_GET(AMS_VUSER3_MASK, regval))
> +						*val = AMS_SUPPLY_SCALE_6VOLT;
> +					else
> +						*val = AMS_SUPPLY_SCALE_3VOLT;
> +					break;
> +				case AMS_VP_VN:
> +				case AMS_REG_VAUX(0) ... AMS_REG_VAUX(15):
> +					*val = AMS_SUPPLY_SCALE_1VOLT;
> +					break;
> +				default:
> +					*val = AMS_SUPPLY_SCALE_1VOLT;
> +					break;
> +				}
> +			} else {
> +				switch (chan->address) {
> +				case AMS_VCC_PSPLL0:
> +				case AMS_VCC_PSPLL3:
> +				case AMS_VCCINT:
> +				case AMS_VCCBRAM:
> +				case AMS_VCCAUX:
> +				case AMS_PSDDRPLL:
> +				case AMS_PSINTFPDDR:
> +					*val = AMS_SUPPLY_SCALE_3VOLT;
> +					break;
> +				default:
> +					*val = AMS_SUPPLY_SCALE_1VOLT;
> +					break;
> +				}
> +			}
> +			*val2 = AMS_SUPPLY_SCALE_DIV_BIT;
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		case IIO_TEMP:
> +			*val = AMS_TEMP_SCALE;
> +			*val2 = AMS_TEMP_SCALE_DIV_BIT;
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		default:
> +			return -EINVAL;
> +		}

Isn't it a bit too looong for a single switch case?

...

> +/**
> + * ams_unmask_worker - ams alarm interrupt unmask worker

> + * @work :		work to be done

Be consistent with a style on how you describe parameters in the kernel doc.

> + * The ZynqMP threshold interrupts are level sensitive. Since we can't make the
> + * threshold condition go way from within the interrupt handler, this means as
> + * soon as a threshold condition is present we would enter the interrupt handler
> + * again and again. To work around this we mask all active threshold interrupts
> + * in the interrupt handler and start a timer. In this timer we poll the
> + * interrupt status and only if the interrupt is inactive we unmask it again.
> + */

...

> +	fwnode_for_each_child_node(chan_node, child) {
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret || reg > AMS_PL_MAX_EXT_CHANNEL + 30)
> +			continue;
> +
> +		chan = &channels[num_channels];
> +		ext_chan = reg + AMS_PL_MAX_FIXED_CHANNEL - 30;
> +		memcpy(chan, &ams_pl_channels[ext_chan], sizeof(*channels));
> +
> +		if (fwnode_property_read_bool(child, "xlnx,bipolar"))
> +			chan->scan_type.sign =	's';

Needless double spacing.

> +		num_channels++;
> +	}

...

> +		/* add PS channels to iio device channels */
> +		memcpy(channels, ams_ps_channels,
> +		       sizeof(ams_ps_channels));

One line.

...

> +		/* Copy only first 10 fix channels */

Be consistent with one line comments (pay attention to the capitalization,
compare to the above).

> +		memcpy(channels, ams_pl_channels,
> +		       AMS_PL_MAX_FIXED_CHANNEL * sizeof(*channels));

One line?

...

> +		/* add AMS channels to iio device channels */
> +		memcpy(channels, ams_ctrl_channels,
> +		       sizeof(ams_ctrl_channels));

One line.

...

> +	fwnode_for_each_child_node(fwnode, child) {
> +		if (fwnode_device_is_available(child)) {

> +			ret = ams_init_module(indio_dev, child,
> +					      ams_channels + num_channels);

One line?

> +			if (ret < 0) {
> +				fwnode_handle_put(child);
> +				return ret;
> +			}
> +
> +			num_channels += ret;
> +		}
> +	}

...

> +	dev_size = sizeof(*dev_channels) * num_channels;

Here you need to have an array_size(). Or introduce a devm_krealloc_array().

> +	dev_channels = devm_krealloc(dev, ams_channels, dev_size, GFP_KERNEL);
> +	if (!dev_channels)
> +		ret = -ENOMEM;


-- 
With Best Regards,
Andy Shevchenko


