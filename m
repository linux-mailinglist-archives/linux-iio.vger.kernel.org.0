Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52B31B4F72
	for <lists+linux-iio@lfdr.de>; Tue, 17 Sep 2019 15:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfIQNiV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Sep 2019 09:38:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2668 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725917AbfIQNiU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Sep 2019 09:38:20 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 458D148C23094D2852CD;
        Tue, 17 Sep 2019 21:38:16 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Tue, 17 Sep 2019
 21:38:10 +0800
Date:   Tue, 17 Sep 2019 14:38:00 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: add support for Intel ADC
Message-ID: <20190917143800.000046c1@huawei.com>
In-Reply-To: <20190916103400.321981-1-felipe.balbi@linux.intel.com>
References: <20190916103400.321981-1-felipe.balbi@linux.intel.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Sep 2019 13:34:00 +0300
Felipe Balbi <felipe.balbi@linux.intel.com> wrote:

> Recent Intel SoCs have an integrated 14-bit, 4 MS/sec ADC. This patch
> adds support for that controller.
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>

Hi Felipe,

Mostly fine, but a few bits to clean up.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/Kconfig     |   9 +
>  drivers/iio/adc/Makefile    |   1 +
>  drivers/iio/adc/intel-adc.c | 482 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 492 insertions(+)
>  create mode 100644 drivers/iio/adc/intel-adc.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 7e3286265a38..e4810a38b25f 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -432,6 +432,15 @@ config INGENIC_ADC
>  	  This driver can also be built as a module. If so, the module will be
>  	  called ingenic_adc.
>  
> +config INTEL_ADC
> +	tristate "Intel ADC IIO driver"
> +	depends on PCI
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say yes here to build support for Intel ADC available on
> +	  recent SoCs.
> +
>  config IMX7D_ADC
>  	tristate "Freescale IMX7D ADC driver"
>  	depends on ARCH_MXC || COMPILE_TEST
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index ef9cc485fb67..f04e1bf89826 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -42,6 +42,7 @@ obj-$(CONFIG_HX711) += hx711.o
>  obj-$(CONFIG_IMX7D_ADC) += imx7d_adc.o
>  obj-$(CONFIG_INA2XX_ADC) += ina2xx-adc.o
>  obj-$(CONFIG_INGENIC_ADC) += ingenic-adc.o
> +obj-$(CONFIG_INTEL_ADC) += intel-adc.o
>  obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
>  obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
>  obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
> diff --git a/drivers/iio/adc/intel-adc.c b/drivers/iio/adc/intel-adc.c
> new file mode 100644
> index 000000000000..381958668563
> --- /dev/null
> +++ b/drivers/iio/adc/intel-adc.c
> @@ -0,0 +1,482 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * intel-adc.c - Intel ADC Driver
> + *
> + * Copyright (C) 2018 Intel Corporation
> + *
> + * Author: Felipe Balbi <felipe.balbi@linux.intel.com>
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/iio/buffer.h>

You aren't currently supporting the buffered interface
or triggers so a few headers to clean out.

> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +
> +#define PCI_DEVICE_ID_INTEL_EHLLP	0x4bb8

Perhaps just put this inline as it's obvious what it is from
context so doesn't really need a 'name'.

> +
> +#define ADC_DMA_CTRL			0x0000
> +#define ADC_FIFO_STTS			0x0004
> +#define ADC_DMA_DEBUG			0x0008
> +#define ADC_PWR_STAT			0x000c
> +
> +#define ADC_CTRL			0x0400
> +#define ADC_LOOP_CTRL			0x0404
> +#define ADC_LOOP_SEQ			0x0408
> +#define ADC_LOOP_DELAY_0		0x040c
> +#define ADC_LOOP_DELAY_1		0x0410
> +#define ADC_LOOP_DELAY_2		0x0414
> +#define ADC_LOOP_DELAY_3		0x0418
> +#define ADC_LOOP_DELAY_4		0x041c
> +#define ADC_LOOP_DELAY_5		0x0420
> +#define ADC_LOOP_DELAY_6		0x0424
> +#define ADC_LOOP_DELAY_7		0x0428
> +#define ADC_CAL_CTRL			0x042c
> +#define ADC_CONV_CTRL			0x0430
> +#define ADC_CONV_DELAY			0x0434
> +#define ADC_CONFIG1			0x0438
> +#define ADC_CONFIG2			0x043c
> +#define ADC_FIFO_CTRL			0x0440
> +#define ADC_STAT			0x0444
> +#define ADC_FIFO_RD_POINTER		0x0448
> +#define ADC_RAW_DATA			0x044c
> +#define ADC_DATA_THRESHOLD_0		0x0450
> +#define ADC_DATA_THRESHOLD_1		0x0454
> +#define ADC_DATA_THRESHOLD_2		0x0458
> +#define ADC_DATA_THRESHOLD_3		0x045c
> +#define ADC_DATA_THRESHOLD_4		0x0460
> +#define ADC_DATA_THRESHOLD_5		0x0464
> +#define ADC_DATA_THRESHOLD_6		0x0468
> +#define ADC_DATA_THRESHOLD_7		0x046c
> +#define ADC_THRESHOLD_CONFIG		0x0470
> +#define ADC_RIS				0x0474
> +#define ADC_IMSC			0x0478
> +#define ADC_MIS				0x047c
> +#define ADC_LOOP_CFG_0			0x0480
> +#define ADC_LOOP_CFG_1			0x0484
> +#define ADC_LOOP_CFG_2			0x0488
> +#define ADC_LOOP_CFG_3			0x048c
> +#define ADC_LOOP_CFG_4			0x0490
> +#define ADC_LOOP_CFG_5			0x0494
> +#define ADC_LOOP_CFG_6			0x0498
> +#define ADC_LOOP_CFG_7			0x049c
> +#define ADC_FIFO_DATA			0x0800
> +
> +#define ADC_BITS			14
> +
> +/* ADC DMA Ctrl */
> +#define ADC_DMA_CTRL_EN			BIT(0)
> +#define ADC_DMA_CTRL_BRST_THRSLD	GENMASK(10, 1)
> +
> +/* ADC FIFO Status */
> +#define ADC_FIFO_STTS_COUNT		GENMASK(9, 0)
> +
> +/* ADC Ctrl */
> +#define ADC_CTRL_EN			BIT(0)
> +#define ADC_CTRL_DATA_THRSHLD_MODE(r)	(((r) >> 1) & 3)
> +
> +/* ADC Conversion Ctrl */
> +#define ADC_CONV_CTRL_NUM_SMPL_MASK	GENMASK(17, 8)
> +#define ADC_CONV_CTRL_NUM_SMPL(n)	(((n) - 1) << 8)
> +#define ADC_CONV_CTRL_CONV_MODE		BIT(4)
> +#define ADC_CONV_CTRL_REQ		BIT(0)
> +
> +/* ADC Config1 */
> +#define ADC_CONFIG1_ATTEN_TRIM		GENMASK(31, 30)
> +#define ADC_CONFIG1_INBUF_CUR		GENMASK(29, 28)
> +#define ADC_CONFIG1_BG_BYPASS		BIT(24)
> +#define ADC_CONFIG1_BG_TRIM		GENMASK(23, 19)
> +#define ADC_CONFIG1_BG_CTRIM		GENMASK(18, 16)
> +#define ADC_CONFIG1_REF_TRIM		GENMASK(15, 8)
> +#define ADC_CONFIG1_ADC_RESET		BIT(6)
> +#define ADC_CONFIG1_REF_BYPASS_EN	BIT(5)
> +#define ADC_CONFIG1_REF_EN		BIT(4)
> +#define ADC_CONFIG1_CNL_SEL_MASK	GENMASK(3, 1)
> +#define ADC_CONFIG1_CNL_SEL(ch)		((ch) << 1)
> +#define ADC_CONFIG1_DIFF_SE_SEL		BIT(0)
> +
> +/* ADC Interrupt Mask Register */
> +#define ADC_INTR_LOOP_DONE_INTR		BIT(22)
> +#define ADC_INTR_FIFO_EMPTY_INTR	BIT(21)
> +#define ADC_INTR_DMA_DONE_INTR		BIT(20)
> +#define ADC_INTR_DATA_THRSHLD_LOW_INTR_7 BIT(19)
> +#define ADC_INTR_DATA_THRSHLD_HIGH_INTR_7 BIT(18)
> +#define ADC_INTR_DATA_THRSHLD_LOW_INTR_6 BIT(17)
> +#define ADC_INTR_DATA_THRSHLD_HIGH_INTR_6 BIT(16)
> +#define ADC_INTR_DATA_THRSHLD_LOW_INTR_5 BIT(15)
> +#define ADC_INTR_DATA_THRSHLD_HIGH_INTR_5 BIT(14)
> +#define ADC_INTR_DATA_THRSHLD_LOW_INTR_4 BIT(13)
> +#define ADC_INTR_DATA_THRSHLD_HIGH_INTR_4 BIT(12)
> +#define ADC_INTR_DATA_THRSHLD_LOW_INTR_3 BIT(11)
> +#define ADC_INTR_DATA_THRSHLD_HIGH_INTR_3 BIT(10)
> +#define ADC_INTR_DATA_THRSHLD_LOW_INTR_2 BIT(9)
> +#define ADC_INTR_DATA_THRSHLD_HIGH_INTR_2 BIT(8)
> +#define ADC_INTR_DATA_THRSHLD_LOW_INTR_1 BIT(7)
> +#define ADC_INTR_DATA_THRSHLD_HIGH_INTR_1 BIT(6)
> +#define ADC_INTR_DATA_THRSHLD_LOW_INTR_0 BIT(5)
> +#define ADC_INTR_DATA_THRSHLD_HIGH_INTR_0 BIT(4)
> +#define ADC_INTR_PWR_DWN_EXIT_INTR	BIT(3)
> +#define ADC_INTR_FIFO_FULL_INTR		BIT(2)
> +#define ADC_INTR_SMPL_DONE_INTR		BIT(0)

Seems to be a mixture of aligned spacing and non aligned.
I don't mind which, but consistency is good.

> +
> +#define ADC_INTR_ALL_MASK	(ADC_INTR_LOOP_DONE_INTR |		\
> +				ADC_INTR_FIFO_EMPTY_INTR |		\
> +				ADC_INTR_DMA_DONE_INTR |		\
> +				ADC_INTR_DATA_THRSHLD_LOW_INTR_7 |	\
> +				ADC_INTR_DATA_THRSHLD_HIGH_INTR_7 |	\
> +				ADC_INTR_DATA_THRSHLD_LOW_INTR_6 |	\
> +				ADC_INTR_DATA_THRSHLD_HIGH_INTR_6 |	\
> +				ADC_INTR_DATA_THRSHLD_LOW_INTR_5 |	\
> +				ADC_INTR_DATA_THRSHLD_HIGH_INTR_5 |	\
> +				ADC_INTR_DATA_THRSHLD_LOW_INTR_4 |	\
> +				ADC_INTR_DATA_THRSHLD_HIGH_INTR_4 |	\
> +				ADC_INTR_DATA_THRSHLD_LOW_INTR_3 |	\
> +				ADC_INTR_DATA_THRSHLD_HIGH_INTR_3 |	\
> +				ADC_INTR_DATA_THRSHLD_LOW_INTR_2 |	\
> +				ADC_INTR_DATA_THRSHLD_HIGH_INTR_2 |	\
> +				ADC_INTR_DATA_THRSHLD_LOW_INTR_1 |	\
> +				ADC_INTR_DATA_THRSHLD_HIGH_INTR_1 |	\
> +				ADC_INTR_DATA_THRSHLD_LOW_INTR_0 |	\
> +				ADC_INTR_DATA_THRSHLD_HIGH_INTR_0 |	\
> +				ADC_INTR_PWR_DWN_EXIT_INTR |		\
> +				ADC_INTR_FIFO_FULL_INTR |		\
> +				ADC_INTR_SMPL_DONE_INTR)
> +
> +#define ADC_VREF_UV		1600000 /* uV */

Units are in the define name (which is nice btw) so probably no need for
the comment.

> +#define ADC_DEFAULT_CONVERSION_TIMEOUT 5000 /* ms */

Give this one explicit units in it's naming as well.

The ADC prefix is a bit generic, but I suppose it's unlikely to get
used in standard headers etc...

> +
> +struct intel_adc {
> +	struct completion completion;
> +	struct pci_dev *pci;
> +	struct iio_dev *iio;

As noted below, this pointer appears unused. I'm not sure the
pci one is used either...

> +
> +	void __iomem *regs;
> +
> +	u32 value;
> +};
> +
> +static inline void intel_adc_writel(void __iomem *base, u32 offset, u32 value)
> +{
> +	writel(value, base + offset);
> +}
> +
> +static inline u32 intel_adc_readl(void __iomem *base, u32 offset)
> +{
> +	return readl(base + offset);
> +}
> +
> +static void intel_adc_enable(struct intel_adc *adc)
> +{
> +	u32 ctrl;
> +	u32 cfg1;
> +
> +	cfg1 = intel_adc_readl(adc->regs, ADC_CONFIG1);
> +	cfg1 &= ~ADC_CONFIG1_ADC_RESET;
> +	intel_adc_writel(adc->regs, ADC_CONFIG1, cfg1);
> +
> +	ctrl = intel_adc_readl(adc->regs, ADC_CTRL);
> +	ctrl |= ADC_CTRL_EN;
> +	intel_adc_writel(adc->regs, ADC_CTRL, ctrl);
> +
> +	cfg1 |= ADC_CONFIG1_REF_EN;
> +	intel_adc_writel(adc->regs, ADC_CONFIG1, cfg1);
> +
> +	/* must wait 1ms before allowing any further accesses */
> +	usleep_range(1000, 1500);
> +}
> +
> +static void intel_adc_disable(struct intel_adc *adc)
> +{
> +	u32 ctrl;
> +
> +	ctrl = intel_adc_readl(adc->regs, ADC_CTRL);
> +	ctrl &= ~ADC_CTRL_EN;
> +	intel_adc_writel(adc->regs, ADC_CTRL, ctrl);
> +}
> +
> +static int intel_adc_single_channel_conversion(struct intel_adc *adc,
> +		struct iio_chan_spec const *channel, int *val)
> +{
> +	u32 ctrl;
> +	u32 reg;
> +
> +	ctrl = intel_adc_readl(adc->regs, ADC_CONV_CTRL);
> +	ctrl |= ADC_CONV_CTRL_CONV_MODE;
> +	ctrl &= ~ADC_CONV_CTRL_NUM_SMPL_MASK;
> +	ctrl |= ADC_CONV_CTRL_NUM_SMPL(1);
> +	intel_adc_writel(adc->regs, ADC_CONV_CTRL, ctrl);
> +
> +	reg = intel_adc_readl(adc->regs, ADC_CONFIG1);
> +	reg &= ~ADC_CONFIG1_CNL_SEL_MASK;
> +	reg |= ADC_CONFIG1_CNL_SEL(channel->scan_index);
> +
> +	if (channel->differential)
> +		reg &= ~ADC_CONFIG1_DIFF_SE_SEL;
> +	else
> +		reg |= ADC_CONFIG1_DIFF_SE_SEL;
> +
> +	intel_adc_writel(adc->regs, ADC_CONFIG1, reg);
> +
> +	ctrl |= ADC_CONV_CTRL_REQ;
> +	intel_adc_writel(adc->regs, ADC_CONV_CTRL, ctrl);
> +
> +	/* enable sample done IRQ event */
> +	reg = intel_adc_readl(adc->regs, ADC_IMSC);
> +	reg &= ~ADC_INTR_SMPL_DONE_INTR;
> +	intel_adc_writel(adc->regs, ADC_IMSC, reg);
> +
> +	usleep_range(1000, 5000);
> +	adc->value = intel_adc_readl(adc->regs, ADC_FIFO_DATA);
> +
> +	return 0;
> +}
> +
> +static int intel_adc_read_raw(struct iio_dev *iio,
> +		struct iio_chan_spec const *channel, int *val, int *val2,
> +		long mask)
> +{
> +	struct intel_adc *adc = iio_priv(iio);
> +	int shift;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		shift = channel->scan_type.shift;
> +
> +		ret = iio_device_claim_direct_mode(iio);
> +		if (ret)
> +			break;
> +
> +		intel_adc_enable(adc);
> +
> +		ret = intel_adc_single_channel_conversion(adc, channel, val);
> +		if (ret) {
> +			intel_adc_disable(adc);
> +			iio_device_release_direct_mode(iio);
> +			break;

nitpick (feel free to ignore).
It might be nice to pull this case block as a separate function, then you
could cleanly use goto to do the unwinding.

> +		}
> +		intel_adc_disable(adc);
> +		ret = IIO_VAL_INT;
> +		iio_device_release_direct_mode(iio);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct iio_info intel_adc_info = {
> +	.read_raw = intel_adc_read_raw,
> +};
> +
> +static const struct iio_event_spec intel_adc_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +			BIT(IIO_EV_INFO_ENABLE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
> +			BIT(IIO_EV_INFO_PERIOD),
> +	},
> +};
> +
> +#define INTEL_ADC_DIFF_CHAN(c1, c2)			\
> +{							\
> +	.type = IIO_VOLTAGE,				\
> +	.differential = true,				\
> +	.indexed = 1,					\
> +	.channel = (c1),				\
> +	.channel2 = (c2),				\
> +	.scan_index = (c1),				\

I think we get overlapping index values between these and
the SINGLE_CHAN ones. These should be unique.

Also, without buffered interface support they don't actually
do anything so drop them for now.  Same with scan_type.

> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> +	.scan_type = {					\
> +		.sign = 's',				\
> +		.realbits = 14,				\
> +		.storagebits = 32,			\
> +		.endianness = IIO_CPU,			\
> +	},						\
> +	.event_spec = intel_adc_events,			\
> +	.num_event_specs = ARRAY_SIZE(intel_adc_events),\
> +	.datasheet_name = "ain"#c1"-ain"#c2,		\
> +}
> +
> +#define INTEL_ADC_SINGLE_CHAN(c)			\
> +{							\
> +	.type = IIO_VOLTAGE,				\
> +	.indexed = 1,					\
> +	.channel = (c),					\
> +	.scan_index = (c),				\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> +	.scan_type = {					\
> +		.sign = 's',				\
> +		.realbits = 14,				\
> +		.storagebits = 32,			\
> +		.shift = 0,				\

No need to specify shift of 0 as that's the 'obviousish' default.

> +		.endianness = IIO_CPU,			\
> +	},						\
> +	.event_spec = intel_adc_events,			\
> +	.num_event_specs = ARRAY_SIZE(intel_adc_events),\
> +	.datasheet_name = "ain"#c,			\
> +}
> +
> +static struct iio_chan_spec const intel_adc_channels[] = {
> +	INTEL_ADC_DIFF_CHAN(0, 1),
> +	INTEL_ADC_DIFF_CHAN(2, 3),
> +	INTEL_ADC_DIFF_CHAN(4, 5),
> +	INTEL_ADC_DIFF_CHAN(6, 7),
> +	INTEL_ADC_SINGLE_CHAN(0),
> +	INTEL_ADC_SINGLE_CHAN(1),
> +	INTEL_ADC_SINGLE_CHAN(2),
> +	INTEL_ADC_SINGLE_CHAN(3),
> +	INTEL_ADC_SINGLE_CHAN(4),
> +	INTEL_ADC_SINGLE_CHAN(5),
> +	INTEL_ADC_SINGLE_CHAN(6),
> +	INTEL_ADC_SINGLE_CHAN(7),
> +};
> +
> +static irqreturn_t intel_adc_irq(int irq, void *_adc)
> +{
> +	struct intel_adc *adc = _adc;
> +	u32 status;
> +
> +	status = intel_adc_readl(adc->regs, ADC_MIS);
> +
> +	if (!status)
> +		return IRQ_NONE;
> +
> +	intel_adc_writel(adc->regs, ADC_IMSC, ADC_INTR_ALL_MASK);
> +	adc->value = intel_adc_readl(adc->regs, ADC_FIFO_DATA);
> +	complete(&adc->completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int intel_adc_probe(struct pci_dev *pci, const struct pci_device_id *id)
> +{
> +	struct intel_adc *adc;
> +	struct iio_dev *iio;
> +	int ret;
> +	int irq;
> +
> +	iio = devm_iio_device_alloc(&pci->dev, sizeof(*adc));
> +	if (!iio)
> +		return -ENOMEM;
> +
> +	adc = iio_priv(iio);
> +	adc->pci = pci;
> +	adc->iio = iio;

This pointer look usually means that the driver could be slightly
adjusted to remove the need to go from iio_dev -> private
and private-> iio_dev.

In this case I can't find a user of adc->iio so get rid of it.

> +
> +	ret = pcim_enable_device(pci);
> +	if (ret)
> +		return ret;
> +
> +	pci_set_master(pci);
> +
> +	ret = pcim_iomap_regions(pci, BIT(0), pci_name(pci));
> +	if (ret)
> +		return ret;
> +
> +	adc->regs = pcim_iomap_table(pci)[0];
> +	if (!adc->regs) {
> +		ret = -EFAULT;
> +		return ret;
> +	}
> +
> +	pci_set_drvdata(pci, adc);
> +	init_completion(&adc->completion);
> +	iio->dev.parent = &pci->dev;
> +	iio->name = dev_name(&pci->dev);
> +	iio->modes = INDIO_DIRECT_MODE;
> +	iio->info = &intel_adc_info;
> +	iio->channels = intel_adc_channels;
> +	iio->num_channels = ARRAY_SIZE(intel_adc_channels);
> +
> +	ret = devm_iio_device_register(&pci->dev, iio);
> +	if (ret)
> +		return ret;
> +
> +	ret = pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_ALL_TYPES);
> +	if (ret < 0)
> +		return ret;
> +
> +	irq = pci_irq_vector(pci, 0);
> +	ret = devm_request_irq(&pci->dev, irq, intel_adc_irq,
> +			IRQF_ONESHOT | IRQF_SHARED | IRQF_TRIGGER_RISING,
> +			"intel-adc", adc);

Requesting the interrupt only after exposing userspace and in kernel
interfaces seems liable to cause problem.

> +	if (ret)
> +		goto err;
> +
> +	pm_runtime_set_autosuspend_delay(&pci->dev, 1000);
> +	pm_runtime_use_autosuspend(&pci->dev);
> +	pm_runtime_put_autosuspend(&pci->dev);
> +	pm_runtime_allow(&pci->dev);
> +
> +	return 0;
> +
> +err:
> +	pci_free_irq_vectors(pci);
> +	return ret;
> +}
> +
> +static void intel_adc_remove(struct pci_dev *pci)
> +{
> +	pm_runtime_forbid(&pci->dev);
> +	pm_runtime_get_noresume(&pci->dev);
> +
> +	pci_free_irq_vectors(pci);

There is a theoretical race here.  We have freed the irq vectors
before removing the userspace and in kernel interfaces.

> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int intel_adc_suspend(struct device *dev)
> +{

Why provide empty sleep and resume functions?

> +	return 0;
> +}
> +
> +static int intel_adc_resume(struct device *dev)
> +{
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(intel_adc_pm_ops, intel_adc_suspend, intel_adc_resume);
> +
> +static const struct pci_device_id intel_adc_id_table[] = {
> +	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_EHLLP), },
> +	{  } /* Terminating Entry */
> +};
> +MODULE_DEVICE_TABLE(pci, intel_adc_id_table);
> +
> +static struct pci_driver intel_adc_driver = {
> +	.name		= "intel-adc",
> +	.probe		= intel_adc_probe,
> +	.remove		= intel_adc_remove,
> +	.id_table	= intel_adc_id_table,
> +	.driver = {
> +	.pm = &intel_adc_pm_ops,

.pm should be indented one more level.

> +	}
> +};
> +module_pci_driver(intel_adc_driver);
> +
> +MODULE_AUTHOR("Felipe Balbi <felipe.balbi@linux.intel.com>");
> +MODULE_DESCRIPTION("Intel ADC");
> +MODULE_LICENSE("GPL v2");


