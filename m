Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D8E3BAE4C
	for <lists+linux-iio@lfdr.de>; Sun,  4 Jul 2021 20:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhGDSbX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Jul 2021 14:31:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229724AbhGDSbX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Jul 2021 14:31:23 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D527613A9;
        Sun,  4 Jul 2021 18:28:43 +0000 (UTC)
Date:   Sun, 4 Jul 2021 19:31:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Cc:     <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <git-dev@xilinx.com>, <michal.simek@xilinx.com>,
        <pmeerw@pmeerw.net>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Subject: Re: [PATCH v6 2/4] iio: adc: Add Xilinx AMS driver
Message-ID: <20210704193108.20e19692@jic23-huawei>
In-Reply-To: <20210624182939.12881-3-anand.ashok.dumbre@xilinx.com>
References: <20210624182939.12881-1-anand.ashok.dumbre@xilinx.com>
        <20210624182939.12881-3-anand.ashok.dumbre@xilinx.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 24 Jun 2021 19:29:37 +0100
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

Hi Anand,

A few comments inline from a fresh read.
Only significant one is that the use of separate masks and shifts
differs from how they are normally done in the kernel these days.
FIELD_PREP() and FIELD_GET() allow a single mask definition to be
cleanly used for both the shift and masking in a nice clean way.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/Kconfig      |   13 +
>  drivers/iio/adc/Makefile     |    1 +
>  drivers/iio/adc/xilinx-ams.c | 1342 ++++++++++++++++++++++++++++++++++
>  3 files changed, 1356 insertions(+)
>  create mode 100644 drivers/iio/adc/xilinx-ams.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index c7946c439612..c011ab30ec9a 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1256,4 +1256,17 @@ config XILINX_XADC
>  	  The driver can also be build as a module. If so, the module will be called
>  	  xilinx-xadc.
>  
> +config XILINX_AMS
> +	tristate "Xilinx AMS driver"
> +	depends on ARCH_ZYNQMP || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  Say yes here to have support for the Xilinx AMS.
> +
> +	  The driver supports Voltage and Temperature monitoring on Xilinx Ultrascale
> +	  devices.
> +
> +	  The driver can also be built as a module. If so, the module will be called
> +	  xilinx-ams.
> +
>  endmenu
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index a226657d19c0..99e031f44479 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -112,4 +112,5 @@ obj-$(CONFIG_VF610_ADC) += vf610_adc.o
>  obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
>  xilinx-xadc-y := xilinx-xadc-core.o xilinx-xadc-events.o
>  obj-$(CONFIG_XILINX_XADC) += xilinx-xadc.o
> +obj-$(CONFIG_XILINX_AMS) += xilinx-ams.o
>  obj-$(CONFIG_SD_ADC_MODULATOR) += sd_adc_modulator.o
> diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> new file mode 100644
> index 000000000000..463e3162726c
> --- /dev/null
> +++ b/drivers/iio/adc/xilinx-ams.c
> @@ -0,0 +1,1342 @@
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
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +static const unsigned int AMS_UNMASK_TIMEOUT_MS = 500;
> +
> +/* AMS registers definitions */
> +#define AMS_ISR_0			0x010
> +#define AMS_ISR_1			0x014
> +#define AMS_IER_0			0x020
> +#define AMS_IER_1			0x024
> +#define AMS_IDR_0			0x028
> +#define AMS_IDR_1			0x02c
> +#define AMS_PS_CSTS			0x040
> +#define AMS_PL_CSTS			0x044
> +
> +#define AMS_VCC_PSPLL0			0x060
> +#define AMS_VCC_PSPLL3			0x06C
> +#define AMS_VCCINT			0x078
> +#define AMS_VCCBRAM			0x07C
> +#define AMS_VCCAUX			0x080
> +#define AMS_PSDDRPLL			0x084
> +#define AMS_PSINTFPDDR			0x09C
> +
> +#define AMS_VCC_PSPLL0_CH		48
> +#define AMS_VCC_PSPLL3_CH		51
> +#define AMS_VCCINT_CH			54
> +#define AMS_VCCBRAM_CH			55
> +#define AMS_VCCAUX_CH			56
> +#define AMS_PSDDRPLL_CH			57
> +#define AMS_PSINTFPDDR_CH		63
> +
> +#define AMS_REG_CONFIG0			0x100
> +#define AMS_REG_CONFIG1			0x104
> +#define AMS_REG_CONFIG3			0x10C
> +#define AMS_REG_SEQ_CH0			0x120
> +#define AMS_REG_SEQ_CH1			0x124
> +#define AMS_REG_SEQ_CH2			0x118
> +
> +#define AMS_TEMP			0x000
> +#define AMS_SUPPLY1			0x004
> +#define AMS_SUPPLY2			0x008
> +#define AMS_VP_VN			0x00c
> +#define AMS_VREFP			0x010
> +#define AMS_VREFN			0x014
> +#define AMS_SUPPLY3			0x018
> +#define AMS_SUPPLY4			0x034
> +#define AMS_SUPPLY5			0x038
> +#define AMS_SUPPLY6			0x03c
> +#define AMS_SUPPLY7			0x200
> +#define AMS_SUPPLY8			0x204
> +#define AMS_SUPPLY9			0x208
> +#define AMS_SUPPLY10			0x20c
> +#define AMS_VCCAMS			0x210
> +#define AMS_TEMP_REMOTE			0x214
> +
> +#define AMS_REG_VAUX(x)			(0x40 + 4 * (x))
> +
> +#define AMS_PS_RESET_VALUE		0xFFFF
> +#define AMS_PL_RESET_VALUE		0xFFFF
> +
> +#define AMS_CONF0_CHANNEL_NUM_MASK	GENMASK(6, 0)
> +
> +#define AMS_CONF1_SEQ_MASK		GENMASK(15, 12)
> +#define AMS_CONF1_SEQ_DEFAULT		(0 << 12)
> +#define AMS_CONF1_SEQ_CONTINUOUS	(2 << 12)
> +#define AMS_CONF1_SEQ_SINGLE_CHANNEL	(3 << 12)

FIELD_PREP(AMS_CONFG1_SEQ_MASK, 0) or even better, define
the values as not shifted and have

FIELD_PREP(AMS_CONFIG1_SEQ_MASK, AMS_CONF1_SEQ_DEFAULT)
etc in the relevant places inline.


> +
> +#define AMS_REG_SEQ0_MASK		0xFFFF
> +#define AMS_REG_SEQ2_MASK		0x003F
> +#define AMS_REG_SEQ1_MASK		0xFFFF
> +#define AMS_REG_SEQ2_MASK_SHIFT		16
> +#define AMS_REG_SEQ1_MASK_SHIFT		22

As below, combine mask and shift into a shifted mask
then you can use FIELD_PREP() to do the magic for you.

> +
> +#define AMS_REGCFG1_ALARM_MASK		0xF0F
> +#define AMS_REGCFG3_ALARM_MASK		0x3F
> +
> +#define AMS_ALARM_TEMP			0x140
> +#define AMS_ALARM_SUPPLY1		0x144
> +#define AMS_ALARM_SUPPLY2		0x148
> +#define AMS_ALARM_SUPPLY3		0x160
> +#define AMS_ALARM_SUPPLY4		0x164
> +#define AMS_ALARM_SUPPLY5		0x168
> +#define AMS_ALARM_SUPPLY6		0x16c
> +#define AMS_ALARM_SUPPLY7		0x180
> +#define AMS_ALARM_SUPPLY8		0x184
> +#define AMS_ALARM_SUPPLY9		0x188
> +#define AMS_ALARM_SUPPLY10		0x18c
> +#define AMS_ALARM_VCCAMS		0x190
> +#define AMS_ALARM_TEMP_REMOTE		0x194
> +#define AMS_ALARM_THRESHOLD_OFF_10	0x10
> +#define AMS_ALARM_THRESHOLD_OFF_20	0x20
> +
> +#define AMS_ALARM_THR_DIRECT_MASK	0x01
> +#define AMS_ALARM_THR_MIN		0x0000
> +#define AMS_ALARM_THR_MAX		0xffff
> +
> +#define AMS_NO_OF_ALARMS		32
> +#define AMS_PL_ALARM_START		16
> +#define AMS_ISR0_ALARM_MASK		0xFFFFFFFFU
> +#define AMS_ISR1_ALARM_MASK		0xE000001FU
> +#define AMS_ISR1_EOC_MASK		0x00000008U
> +#define AMS_ISR1_INTR_MASK_SHIFT	32
> +#define AMS_ISR0_ALARM_2_TO_0_MASK	0x07
> +#define AMS_ISR0_ALARM_6_TO_3_MASK	0x78
> +#define AMS_ISR0_ALARM_12_TO_7_MASK	0x3F
> +#define AMS_CONF1_ALARM_2_TO_0_SHIFT	1

Can we handle these via a single mask that includes the shift
and FIELD_PREP() etc?  That tends to make it easier to
review by ensuring we don't have multiple defines to deal with.

> +#define AMS_CONF1_ALARM_6_TO_3_SHIFT	5
> +#define AMS_CONF3_ALARM_12_TO_7_SHIFT	8


> +
> +#define AMS_PS_CSTS_PS_READY		0x08010000U
> +#define AMS_PL_CSTS_ACCESS_MASK		0x00000001U
> +
> +#define AMS_PL_MAX_FIXED_CHANNEL	10
> +#define AMS_PL_MAX_EXT_CHANNEL		20
> +
> +#define AMS_INIT_TIMEOUT_US		10000
> +
> +/*
> + * Following scale and offset value is derived from
> + * UG580 (v1.7) December 20, 2016
> + */
> +#define AMS_SUPPLY_SCALE_1VOLT		1000
> +#define AMS_SUPPLY_SCALE_3VOLT		3000
> +#define AMS_SUPPLY_SCALE_6VOLT		6000
> +#define AMS_SUPPLY_SCALE_DIV_BIT	16
> +
> +#define AMS_TEMP_SCALE			509314
> +#define AMS_TEMP_SCALE_DIV_BIT		16
> +#define AMS_TEMP_OFFSET			-((280230L << 16) / 509314)
> +
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
> +};
> +
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
> +};
> +
> +#define AMS_SEQ(x)		(AMS_SEQ_MAX + (x))
> +#define AMS_VAUX_SEQ(x)		(AMS_SEQ_MAX + (x))
> +
> +#define AMS_PS_SEQ_MAX		AMS_SEQ_MAX
> +#define PS_SEQ(x)		(x)
> +#define PL_SEQ(x)		(AMS_PS_SEQ_MAX + (x))
> +
> +#define AMS_CHAN_TEMP(_scan_index, _addr) { \
> +	.type = IIO_TEMP, \
> +	.indexed = 1, \
> +	.address = (_addr), \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> +		BIT(IIO_CHAN_INFO_SCALE) | \
> +		BIT(IIO_CHAN_INFO_OFFSET), \
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +	.event_spec = ams_temp_events, \
> +	.num_event_specs = ARRAY_SIZE(ams_temp_events), \
> +	.scan_index = (_scan_index), \
> +	.scan_type = { \
> +		.sign = 'u', \
> +		.realbits = 12, \
> +		.storagebits = 16, \
> +		.shift = 4, \
> +		.endianness = IIO_CPU, \

Currently these are only documentation i think as no support for using them
in this driver (buffered modes).  You could drop them until you need them
in some future patch.

> +	}, \
> +}
> +

...

> +static int ams_enable_single_channel(struct ams *ams, unsigned int offset)
> +{
> +	u8 channel_num = 0;
> +
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

nitpick: Blank line here.

> +	return 0;
> +}
> +

...

> +static int ams_get_ext_chan(struct device_node *chan_node,
> +			    struct iio_chan_spec *channels, int num_channels)
> +{
> +	struct device_node *child;
> +	unsigned int reg;
> +	int ret;
> +
> +	for_each_child_of_node(chan_node, child) {
> +		ret = of_property_read_u32(child, "reg", &reg);
> +		if (ret || reg > (AMS_PL_MAX_EXT_CHANNEL + 30))
> +			continue;
> +
> +		memcpy(&channels[num_channels], &ams_pl_channels[reg +
> +		       AMS_PL_MAX_FIXED_CHANNEL - 30], sizeof(*channels));
> +
> +		if (of_property_read_bool(child,
> +					  "xlnx,bipolar"))

Above fits on one line easily.

> +			channels[num_channels].scan_type.sign =	's';
> +
> +		num_channels++;
> +	}
> +
> +	return num_channels;
> +}
> +

...

> +
> +static int ams_probe(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ams *ams;
> +	struct resource *res;
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
> +
> +	indio_dev->name = "xilinx-ams";
> +
> +	indio_dev->info = &iio_ams_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	ams->base = devm_ioremap_resource(&pdev->dev, res);

devm_platform_ioremap_resource()
Slight reduction in boilerplate.

> +	if (IS_ERR(ams->base))
> +		return PTR_ERR(ams->base);
> +
> +	ams->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(ams->clk))
> +		return PTR_ERR(ams->clk);
> +	clk_prepare_enable(ams->clk);
> +	devm_add_action_or_reset(&pdev->dev, (void *)clk_disable_unprepare,
> +				 ams->clk);
> +
> +	INIT_DELAYED_WORK(&ams->ams_unmask_work, ams_unmask_worker);
> +	devm_add_action_or_reset(&pdev->dev, (void *)cancel_delayed_work,

I'm not keen on casting away the function pointer type.  Normally we'd
just wrap it in a local function, to make it clear it was deliberate and avoid
potential nasty problems if the signature of the function ever changes.

It's 3 lines of boilerplate, but will give me warm fuzzy feelings!
Same for the other case above.  The fact this isn't done in exising kernel
code make this particularly risky.

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

platform_get_irq () can return errors, in particular -EPROBE_DEFER so I'd check
that and return before you call devm_request_irq()
I'm not sure devm_request_irq() will not eat that error code.


> +	ret = devm_request_irq(&pdev->dev, ams->irq, &ams_irq, 0, "ams-irq",
> +			       indio_dev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to register interrupt\n");
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	return iio_device_register(indio_dev);
> +}
> +
> +static int ams_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +
> +	iio_device_unregister(indio_dev);

If this is all you have in remove, then you can use devm_iio_device_register() 
in probe() and not need an remove() callback at all.

> +
> +	return 0;
> +}
> +

...
