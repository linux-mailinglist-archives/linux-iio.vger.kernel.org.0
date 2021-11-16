Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2107D4538E1
	for <lists+linux-iio@lfdr.de>; Tue, 16 Nov 2021 18:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239138AbhKPR4l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Nov 2021 12:56:41 -0500
Received: from mga14.intel.com ([192.55.52.115]:25856 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239135AbhKPR4k (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Nov 2021 12:56:40 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="234007662"
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="234007662"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 09:38:56 -0800
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="592845938"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 09:38:53 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mn2Pt-007VK9-Uf;
        Tue, 16 Nov 2021 19:38:45 +0200
Date:   Tue, 16 Nov 2021 19:38:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, git@xilinx.com, michal.simek@xilinx.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-acpi@vger.kernel.org, heikki.krogerus@linux.intel.com,
        Manish Narani <manish.narani@xilinx.com>
Subject: Re: [PATCH v9 3/5] iio: adc: Add Xilinx AMS driver
Message-ID: <YZPspfolQkDrz22s@smile.fi.intel.com>
References: <20211116150842.1051-1-anand.ashok.dumbre@xilinx.com>
 <20211116150842.1051-4-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116150842.1051-4-anand.ashok.dumbre@xilinx.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Nov 16, 2021 at 03:08:40PM +0000, Anand Ashok Dumbre wrote:
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

Something with indentation / paragraph splitting went wrong.

...

> +#define AMS_ALARM_THR_MIN		0x0000
> +#define AMS_ALARM_THR_MAX		0xFFFF

If this is limited by hardware register, I would rather use (BIT(16) - 1)
notation. It will give immediately amount of bits used for the value.

...

> +#define AMS_REGCFG1_ALARM_MASK		(AMS_CONF1_ALARM_2_TO_0_MASK |	\
> +					AMS_CONF1_ALARM_6_TO_3_MASK | BIT(0))

Better to write as

#define AMS_REGCFG1_ALARM_MASK \
	(AMS_CONF1_ALARM_2_TO_0_MASK | AMS_CONF1_ALARM_6_TO_3_MASK | BIT(0))

...

> +#define AMS_PL_CSTS_ACCESS_MASK		0x00000001U

BIT()

...

> +	u32 reg;
> +	int ret;

	u32 expect = AMS_PS_CSTS_PS_READY;

(Use similar approach for other readX_poll_timeout() cases)

> +		ret = readl_poll_timeout(ams->base + AMS_PS_CSTS, reg,
> +					 (reg & AMS_PS_CSTS_PS_READY) ==
> +					 AMS_PS_CSTS_PS_READY, 0,
> +					 AMS_INIT_TIMEOUT_US);

		ret = readl_poll_timeout(ams->base + AMS_PS_CSTS, reg,
					 (reg & expect) == expect,
					 0, AMS_INIT_TIMEOUT_US);

0?!


> +		if (ret)
> +			return ret;

...

> +		ret = readl(ams->base + AMS_PL_CSTS);
> +		if (ret == 0)
> +			return ret;

Assigning u32 to int seems wrong.

...

> +static int ams_enable_single_channel(struct ams *ams, unsigned int offset)
> +{
> +	u8 channel_num = 0;

Assignment does not bring any value.

> +	switch (offset) {
> +	case AMS_VCC_PSPLL0:
> +		channel_num = AMS_VCC_PSPLL0_CH;
> +		break;
> +	case AMS_VCC_PSPLL3:
> +		channel_num = AMS_VCC_PSPLL3_CH;
> +		break;
> +	case AMS_VCCINT:
> +		channel_num = AMS_VCCINT_CH;
> +		break;
> +	case AMS_VCCBRAM:
> +		channel_num = AMS_VCCBRAM_CH;
> +		break;
> +	case AMS_VCCAUX:
> +		channel_num = AMS_VCCAUX_CH;
> +		break;
> +	case AMS_PSDDRPLL:
> +		channel_num = AMS_PSDDRPLL_CH;
> +		break;
> +	case AMS_PSINTFPDDR:
> +		channel_num = AMS_PSINTFPDDR_CH;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* set single channel, sequencer off mode */
> +	ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
> +			  AMS_CONF1_SEQ_SINGLE_CHANNEL);
> +
> +	/* write the channel number */
> +	ams_ps_update_reg(ams, AMS_REG_CONFIG0, AMS_CONF0_CHANNEL_NUM_MASK,
> +			  channel_num);
> +
> +	return 0;
> +}

...

> +					regval = readl(ams->pl_base +
> +						       AMS_REG_CONFIG4);

One line?

> +					regval = readl(ams->pl_base +
> +						       AMS_REG_CONFIG4);

Ditto and so on...

...

> +static int ams_get_alarm_mask(int scan_index)
> +{
> +	int bit = 0;
> +
> +	if (scan_index >= AMS_PS_SEQ_MAX) {
> +		bit = AMS_PL_ALARM_START;
> +		scan_index -= AMS_PS_SEQ_MAX;
> +	}
> +
> +	switch (scan_index) {
> +	case AMS_SEQ_TEMP:
> +		return BIT(AMS_ALARM_BIT_TEMP + bit);
> +	case AMS_SEQ_SUPPLY1:
> +		return BIT(AMS_ALARM_BIT_SUPPLY1 + bit);
> +	case AMS_SEQ_SUPPLY2:
> +		return BIT(AMS_ALARM_BIT_SUPPLY2 + bit);
> +	case AMS_SEQ_SUPPLY3:
> +		return BIT(AMS_ALARM_BIT_SUPPLY3 + bit);
> +	case AMS_SEQ_SUPPLY4:
> +		return BIT(AMS_ALARM_BIT_SUPPLY4 + bit);
> +	case AMS_SEQ_SUPPLY5:
> +		return BIT(AMS_ALARM_BIT_SUPPLY5 + bit);
> +	case AMS_SEQ_SUPPLY6:
> +		return BIT(AMS_ALARM_BIT_SUPPLY6 + bit);
> +	case AMS_SEQ_SUPPLY7:
> +		return BIT(AMS_ALARM_BIT_SUPPLY7 + bit);
> +	case AMS_SEQ_SUPPLY8:
> +		return BIT(AMS_ALARM_BIT_SUPPLY8 + bit);
> +	case AMS_SEQ_SUPPLY9:
> +		return BIT(AMS_ALARM_BIT_SUPPLY9 + bit);
> +	case AMS_SEQ_SUPPLY10:
> +		return BIT(AMS_ALARM_BIT_SUPPLY10 + bit);
> +	case AMS_SEQ_VCCAMS:
> +		return BIT(AMS_ALARM_BIT_VCCAMS + bit);
> +	case AMS_SEQ_TEMP_REMOTE:
> +		return BIT(AMS_ALARM_BIT_TEMP_REMOTE + bit);
> +	default:
> +		return 0;
> +	}

> +	return 0;

Dead code.

> +}

...

> +	return (ams->alarm_mask & ams_get_alarm_mask(chan->scan_index)) ? 1 : 0;

	return !!(...);

simply shorter.

...

> +	schedule_delayed_work(&ams->ams_unmask_work,
> +			      msecs_to_jiffies(AMS_UNMASK_TIMEOUT_MS));

Can be one line.

...

> +	struct fwnode_handle *child_node = NULL,

You may drop _node from the name.

> +			     *fwnode = dev_fwnode(&pdev->dev);

...

> +	if (check_mul_overflow(num_chan, sizeof(struct iio_chan_spec),
> +			       &ams_chan_size))
> +		return -EINVAL;
> +
> +	/* Initialize buffer for channel specification */
> +	ams_channels = kzalloc(ams_chan_size, GFP_KERNEL);

Simply use array_size(). Or why not kcalloc()?

> +	if (!ams_channels)
> +		return -ENOMEM;

...

> +	if (check_mul_overflow((size_t)num_channels, sizeof(struct iio_chan_spec),
> +			       &dev_chan_size))
> +		return -EINVAL;
> +
> +	dev_channels = devm_kzalloc(&pdev->dev, dev_chan_size, GFP_KERNEL);

Why not devm_kcalloc()?

> +	if (!dev_channels) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}

...

> +	ret = 0;
> +err:

Use better naming, you should describe what is going to be after goto.

> +	kfree(ams_channels);
> +
> +	return ret;

...

> +	ret = devm_add_action_or_reset(&pdev->dev, ams_clk_disable_unprepare,
> +				       ams->clk);

One line?

> +	if (ret < 0)
> +		return ret;

...

> +	ret = ams_init_device(ams);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to initialize AMS\n");
> +		return ret;

It's fine to use dev_err_probe() for known error codes.

> +	}

...

> +	ret = devm_request_irq(&pdev->dev, irq, &ams_irq, 0, "ams-irq",
> +			       indio_dev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to register interrupt\n");
> +		return ret;

Ditto.

> +	}

-- 
With Best Regards,
Andy Shevchenko


