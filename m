Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6974F3DC714
	for <lists+linux-iio@lfdr.de>; Sat, 31 Jul 2021 19:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhGaRJQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Jul 2021 13:09:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhGaRJP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Jul 2021 13:09:15 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E07BC60F3A;
        Sat, 31 Jul 2021 17:09:03 +0000 (UTC)
Date:   Sat, 31 Jul 2021 18:11:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v3 2/3] iio: adc: Add driver for Renesas RZ/G2L A/D
 converter
Message-ID: <20210731181142.430c50f8@jic23-huawei>
In-Reply-To: <20210726182850.14328-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210726182850.14328-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
        <20210726182850.14328-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 26 Jul 2021 19:28:49 +0100
Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:

> Add ADC driver support for Renesas RZ/G2L A/D converter in SW
> trigger mode.
> 
> A/D Converter block is a successive approximation analog-to-digital
> converter with a 12-bit accuracy and supports a maximum of 8 input
> channels.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Hi Lad,

A few additional comments inline,

Thanks,

Jonathan

> ---
>  MAINTAINERS                 |   8 +
>  drivers/iio/adc/Kconfig     |  10 +
>  drivers/iio/adc/Makefile    |   1 +
>  drivers/iio/adc/rzg2l_adc.c | 595 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 614 insertions(+)
>  create mode 100644 drivers/iio/adc/rzg2l_adc.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6c8be735cc91..6a52f9f4604c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15839,6 +15839,14 @@ L:	linux-renesas-soc@vger.kernel.org
>  S:	Maintained
>  F:	drivers/phy/renesas/phy-rcar-gen3-usb*.c
>  
> +RENESAS RZ/G2L A/D DRIVER
> +M:	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> +L:	linux-iio@vger.kernel.org
> +L:	linux-renesas-soc@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> +F:	drivers/iio/adc/rzg2l_adc.c
> +
>  RESET CONTROLLER FRAMEWORK
>  M:	Philipp Zabel <p.zabel@pengutronix.de>
>  S:	Maintained
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index db0c8fb60515..af168e1c9fdb 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -887,6 +887,16 @@ config ROCKCHIP_SARADC
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called rockchip_saradc.
>  
> +config RZG2L_ADC
> +	tristate "Renesas RZ/G2L ADC driver"
> +	depends on ARCH_R9A07G044 || COMPILE_TEST
> +	help
> +	  Say yes here to build support for the ADC found in Renesas
> +	  RZ/G2L family.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called rzg2l_adc.
> +
>  config SC27XX_ADC
>  	tristate "Spreadtrum SC27xx series PMICs ADC"
>  	depends on MFD_SC27XX_PMIC || COMPILE_TEST
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index f70d877c555a..d68550f493e3 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -82,6 +82,7 @@ obj-$(CONFIG_QCOM_PM8XXX_XOADC) += qcom-pm8xxx-xoadc.o
>  obj-$(CONFIG_RCAR_GYRO_ADC) += rcar-gyroadc.o
>  obj-$(CONFIG_RN5T618_ADC) += rn5t618-adc.o
>  obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
> +obj-$(CONFIG_RZG2L_ADC) += rzg2l_adc.o
>  obj-$(CONFIG_SC27XX_ADC) += sc27xx_adc.o
>  obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
>  obj-$(CONFIG_STX104) += stx104.o
> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> new file mode 100644
> index 000000000000..d05a3208ff9d
> --- /dev/null
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -0,0 +1,595 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * RZ/G2L A/D Converter driver
> + *
> + *  Copyright (c) 2021 Renesas Electronics Europe GmbH
> + *
> + * Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/iio/iio.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/reset.h>
> +
> +#define DRIVER_NAME		"rzg2l-adc"

As only used in one place, just put it inline there so we don't need
to go find if we want to know the value - I'm lazy.

> +
> +#define RZG2L_ADM(n)			((n) * 0x4)
> +#define RZG2L_ADM0_ADCE			BIT(0)
> +#define RZG2L_ADM0_ADBSY		BIT(1)
> +#define RZG2L_ADM0_PWDWNB		BIT(2)
> +#define RZG2L_ADM0_SRESB		BIT(15)
> +#define RZG2L_ADM1_TRG			BIT(0)
> +#define RZG2L_ADM1_MS			BIT(2)
> +#define RZG2L_ADM1_BS			BIT(4)
> +#define RZG2L_ADM1_EGA_MASK		GENMASK(13, 12)
> +#define RZG2L_ADM2_CHSEL_MASK		GENMASK(7, 0)
> +#define RZG2L_ADM3_ADIL_MASK		GENMASK(31, 24)
> +#define RZG2L_ADM3_ADCMP_MASK		GENMASK(23, 16)
> +#define RZG2L_ADM3_ADCMP_E		FIELD_PREP(RZG2L_ADM3_ADCMP_MASK, 0xe)
> +#define RZG2L_ADM3_ADSMP_MASK		GENMASK(15, 0)
> +
> +#define RZG2L_ADINT			0x20
> +#define RZG2L_ADINT_INTEN_MASK		GENMASK(7, 0)
> +#define RZG2L_ADINT_CSEEN		BIT(16)
> +#define RZG2L_ADINT_INTS		BIT(31)
> +
> +#define RZG2L_ADSTS			0x24
> +#define RZG2L_ADSTS_CSEST		BIT(16)
> +#define RZG2L_ADSTS_INTST_MASK		GENMASK(7, 0)
> +
> +#define RZG2L_ADIVC			0x28
> +#define RZG2L_ADIVC_DIVADC_MASK		GENMASK(8, 0)
> +#define RZG2L_ADIVC_DIVADC_4		FIELD_PREP(RZG2L_ADIVC_DIVADC_MASK, 0x4)
> +
> +#define RZG2L_ADFIL			0x2c
> +
> +#define RZG2L_ADCR(n)			(0x30 + ((n) * 0x4))
> +#define RZG2L_ADCR_AD_MASK		GENMASK(11, 0)
> +
> +#define RZG2L_ADSMP_DEFUALT_SAMPLING	0x578
> +
> +#define RZG2L_ADC_MAX_CHANNELS		8
> +#define RZG2L_ADC_CHN_MASK		0x7
> +#define RZG2L_ADC_TIMEOUT		usecs_to_jiffies(1 * 4)
> +
> +struct rzg2l_adc_data {
> +	const struct iio_chan_spec *channels;
> +	u8 num_channels;
> +};
> +
> +struct rzg2l_adc {
> +	void __iomem *base;
> +	struct clk *pclk;
> +	struct clk *adclk;
> +	struct reset_control *presetn;
> +	struct reset_control *adrstn;
> +	struct completion completion;
> +	const struct rzg2l_adc_data *data;
> +	u16 last_val[RZG2L_ADC_MAX_CHANNELS];
> +};
> +
> +static const char * const rzg2l_adc_channel_name[] = {
> +	"adc0",
> +	"adc1",
> +	"adc2",
> +	"adc3",
> +	"adc4",
> +	"adc5",
> +	"adc6",
> +	"adc7",
> +};
> +
> +static unsigned int rzg2l_adc_readl(struct rzg2l_adc *adc, u32 reg)
> +{
> +	return readl(adc->base + reg);
> +}
> +
> +static void rzg2l_adc_writel(struct rzg2l_adc *adc, unsigned int reg, u32 val)
> +{
> +	writel(val, adc->base + reg);
> +}
> +
> +static void rzg2l_adc_pwr(struct rzg2l_adc *adc, bool on)
> +{
> +	u32 reg;
> +
> +	reg = rzg2l_adc_readl(adc, RZG2L_ADM(0));
> +	if (on)
> +		reg |= RZG2L_ADM0_PWDWNB;
> +	else
> +		reg &= ~RZG2L_ADM0_PWDWNB;
> +	rzg2l_adc_writel(adc, RZG2L_ADM(0), reg);
> +	udelay(2);
> +}
> +
> +static void rzg2l_adc_start_stop(struct rzg2l_adc *adc, bool start)
> +{
> +	int timeout = 5;
> +	u32 reg;
> +
> +	/* stop A/D conversion */

This comment seems odd.  If it is stopping conversion, how is this function
used to start conversion?  Perhaps some more details.

> +	reg = rzg2l_adc_readl(adc, RZG2L_ADM(0));
> +	if (start)
> +		reg |= RZG2L_ADM0_ADCE;
> +	else
> +		reg &= ~RZG2L_ADM0_ADCE;
> +	rzg2l_adc_writel(adc, RZG2L_ADM(0), reg);
> +
> +	if (start)
> +		return;
> +
> +	do {
> +		usleep_range(100, 200);
> +		reg = rzg2l_adc_readl(adc, RZG2L_ADM(0));
> +		timeout--;
> +		if (!timeout) {
> +			pr_err("%s stopping ADC timed out\n", __func__);
> +			break;
> +		}
> +	} while (((reg & RZG2L_ADM0_ADBSY) || (reg & RZG2L_ADM0_ADCE)));
> +}
> +
> +static void rzg2l_set_trigger(struct rzg2l_adc *adc)
> +{
> +	u32 reg;
> +
> +	/*
> +	 * Setup ADM1 for SW trigger
> +	 * EGA[13:12] - Set 00 to indicate hardware trigger is invalid
> +	 * BS[4] - Enable 1-buffer mode
> +	 * MS[1] - Enable Select mode
> +	 * TRG[0] - Enable software trigger mode
> +	 */
> +	reg = rzg2l_adc_readl(adc, RZG2L_ADM(1));
> +	reg &= ~RZG2L_ADM1_EGA_MASK;
> +	reg &= ~RZG2L_ADM1_BS;
> +	reg &= ~RZG2L_ADM1_TRG;
> +	reg |= RZG2L_ADM1_MS;
> +	rzg2l_adc_writel(adc, RZG2L_ADM(1), reg);
> +}
> +
> +static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch)
> +{
> +	u32 reg;
> +
> +	if (rzg2l_adc_readl(adc, RZG2L_ADM(0)) & RZG2L_ADM0_ADBSY)
> +		return -EBUSY;
> +
> +	rzg2l_set_trigger(adc);
> +
> +	/* Select analog input channel subjected to conversion. */
> +	reg = rzg2l_adc_readl(adc, RZG2L_ADM(2));
> +	reg &= ~RZG2L_ADM2_CHSEL_MASK;
> +	reg |= BIT(ch);
> +	rzg2l_adc_writel(adc, RZG2L_ADM(2), reg);
> +
> +	/*
> +	 * Setup ADINT
> +	 * INTS[31] - Select pulse signal
> +	 * CSEEN[16] - Enable channel select error interrupt
> +	 * INTEN[7:0] - Select channel interrupt
> +	 */
> +	reg = rzg2l_adc_readl(adc, RZG2L_ADINT);
> +	reg &= ~RZG2L_ADINT_INTS;
> +	reg &= ~RZG2L_ADINT_INTEN_MASK;
> +	reg |= (RZG2L_ADINT_CSEEN | BIT(ch));
> +	rzg2l_adc_writel(adc, RZG2L_ADINT, reg);
> +
> +	return 0;
> +}
> +
> +static int rzg2l_adc_set_power(struct iio_dev *indio_dev, bool on)
> +{
> +	struct device *dev = indio_dev->dev.parent;
> +
> +	if (on)
> +		return pm_runtime_resume_and_get(dev);
> +
> +	return pm_runtime_put_sync(dev);
> +}
> +
> +static int rzg2l_adc_conversion(struct iio_dev *indio_dev, struct rzg2l_adc *adc, u8 ch)
> +{
> +	int ret;
> +
> +	ret = rzg2l_adc_set_power(indio_dev, true);
> +	if (ret)
> +		return ret;
> +
> +	ret = rzg2l_adc_conversion_setup(adc, ch);
> +	if (ret) {
> +		rzg2l_adc_set_power(indio_dev, false);
> +		return ret;
> +	}
> +
> +	reinit_completion(&adc->completion);
> +
> +	rzg2l_adc_start_stop(adc, true);
> +
> +	if (!wait_for_completion_timeout(&adc->completion, RZG2L_ADC_TIMEOUT)) {
> +		rzg2l_adc_writel(adc, RZG2L_ADINT,
> +				 rzg2l_adc_readl(adc, RZG2L_ADINT) & ~RZG2L_ADINT_INTEN_MASK);
> +		rzg2l_adc_start_stop(adc, false);
> +		rzg2l_adc_set_power(indio_dev, false);
> +		return -ETIMEDOUT;
> +	}
> +
> +	return rzg2l_adc_set_power(indio_dev, false);
> +}
> +
> +static int rzg2l_adc_read_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int *val, int *val2, long mask)
> +{
> +	struct rzg2l_adc *adc = iio_priv(indio_dev);
> +	int ret;
> +	u8 ch;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->type != IIO_VOLTAGE)
> +			return -EINVAL;
> +
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		ch = chan->channel & RZG2L_ADC_CHN_MASK;
> +		ret = rzg2l_adc_conversion(indio_dev, adc, ch);
> +		if (ret) {
> +			iio_device_release_direct_mode(indio_dev);
> +			return ret;
> +		}
> +		*val = adc->last_val[ch];

You should not rely on implementation details of iio_device_claim_direct_mode()
to protect your driver specific data structures. Use your own lock.
Those calls are intended for safe operation when buffered mode in IIO is supported
and currently your driver doesn't support that at all so please remove them.

> +		iio_device_release_direct_mode(indio_dev);
> +
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int rzg2l_adc_read_label(struct iio_dev *iio_dev,
> +				const struct iio_chan_spec *chan,
> +				char *label)
> +{
> +	if (chan->channel >= RZG2L_ADC_MAX_CHANNELS)
> +		return -EINVAL;
> +
> +	return sysfs_emit(label, "%s\n", rzg2l_adc_channel_name[chan->channel]);
> +}
> +
> +static const struct iio_info rzg2l_adc_iio_info = {
> +	.read_raw = rzg2l_adc_read_raw,
> +	.read_label = rzg2l_adc_read_label,
> +};
> +
> +static irqreturn_t rzg2l_adc_isr(int irq, void *dev_id)
> +{
> +	struct rzg2l_adc *adc = (struct rzg2l_adc *)dev_id;

No need for explicit cast from void * to another pointer type.
This is always valid without in C.

> +	unsigned long intst;
> +	u32 reg;
> +	int ch;
> +
> +	reg = rzg2l_adc_readl(adc, RZG2L_ADSTS);
> +
> +	/* A/D conversion channel select error interrupt */
> +	if (reg & RZG2L_ADSTS_CSEST) {
> +		rzg2l_adc_writel(adc, RZG2L_ADSTS, reg);
> +		return IRQ_HANDLED;
> +	}
> +
> +	intst = reg & RZG2L_ADSTS_INTST_MASK;
> +	if (!intst)
> +		return IRQ_NONE;
> +
> +	for_each_set_bit(ch, &intst, RZG2L_ADC_MAX_CHANNELS) {
> +		if (intst & BIT(ch))

I'm missing how this if can fail given we only end up in here when the bit is
set.

> +			adc->last_val[ch] = rzg2l_adc_readl(adc, RZG2L_ADCR(ch)) &
> +					    RZG2L_ADCR_AD_MASK;
> +	}
> +
> +	/* clear the channel interrupt */
> +	rzg2l_adc_writel(adc, RZG2L_ADSTS, reg);
> +
> +	complete(&adc->completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l_adc *adc)
> +{
> +	struct iio_chan_spec *chan_array;
> +	struct fwnode_handle *fwnode;
> +	struct rzg2l_adc_data *data;
> +	unsigned int channel;
> +	int num_channels;
> +	int ret;
> +	u8 i;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	num_channels = device_get_child_node_count(&pdev->dev);
> +	if (!num_channels) {
> +		dev_err(&pdev->dev, "no channel children\n");
> +		return -ENODEV;
> +	}
> +
> +	if (num_channels > RZG2L_ADC_MAX_CHANNELS) {
> +		dev_err(&pdev->dev, "num of channel children out of range\n");
> +		return -EINVAL;
> +	}
> +
> +	chan_array = devm_kcalloc(&pdev->dev, num_channels, sizeof(*chan_array),
> +				  GFP_KERNEL);
> +	if (!chan_array)
> +		return -ENOMEM;
> +
> +	i = 0;
> +	device_for_each_child_node(&pdev->dev, fwnode) {
> +		ret = fwnode_property_read_u32(fwnode, "reg", &channel);
> +		if (ret)
> +			return ret;
> +
> +		if (channel >= RZG2L_ADC_MAX_CHANNELS)
> +			return -EINVAL;
> +
> +		chan_array[i].type = IIO_VOLTAGE;
> +		chan_array[i].indexed = 1;
> +		chan_array[i].channel = channel;
> +		chan_array[i].info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +		chan_array[i].datasheet_name = rzg2l_adc_channel_name[channel];
> +		i++;
> +	}
> +
> +	data->num_channels = num_channels;
> +	data->channels = chan_array;
> +	adc->data = data;
> +
> +	return 0;
> +}
> +
> +static int rzg2l_adc_hw_init(struct rzg2l_adc *adc)
> +{
> +	int timeout = 5;
> +	u32 reg;
> +	int ret;
> +
> +	ret = clk_prepare_enable(adc->pclk);
> +	if (ret)
> +		return ret;
> +
> +	/* SW reset */
> +	reg = rzg2l_adc_readl(adc, RZG2L_ADM(0));
> +	reg |= RZG2L_ADM0_SRESB;
> +	rzg2l_adc_writel(adc, RZG2L_ADM(0), reg);
> +
> +	while (!(rzg2l_adc_readl(adc, RZG2L_ADM(0)) & RZG2L_ADM0_SRESB)) {
> +		if (!timeout) {
> +			ret = -EBUSY;
> +			goto exit_hw_init;
> +		}
> +		timeout--;
> +		usleep_range(100, 200);
> +	}
> +
> +	/* Only division by 4 can be set */
> +	reg = rzg2l_adc_readl(adc, RZG2L_ADIVC);
> +	reg &= ~RZG2L_ADIVC_DIVADC_MASK;
> +	reg |= RZG2L_ADIVC_DIVADC_4;
> +	rzg2l_adc_writel(adc, RZG2L_ADIVC, reg);
> +
> +	/*
> +	 * Setup AMD3
> +	 * ADIL[31:24] - Should be always set to 0
> +	 * ADCMP[23:16] - Should be always set to 0xe
> +	 * ADSMP[15:0] - Set default (0x578) sampling period
> +	 */
> +	reg = rzg2l_adc_readl(adc, RZG2L_ADM(3));
> +	reg &= ~RZG2L_ADM3_ADIL_MASK;
> +	reg &= ~RZG2L_ADM3_ADCMP_MASK;
> +	reg &= ~RZG2L_ADM3_ADSMP_MASK;
> +	reg |= (RZG2L_ADM3_ADCMP_E | RZG2L_ADSMP_DEFUALT_SAMPLING);
> +	rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
> +
> +exit_hw_init:
> +	clk_disable_unprepare(adc->pclk);
> +
> +	return 0;
> +}
> +
> +static void rzg2l_adc_pm_runtime_disable(void *data)
> +{
> +	struct iio_dev *indio_dev = data;

Register the devm call with the dev instead of the iio_dev.
As this should be right next to the enable, it will be obvious
what it should be.

> +
> +	pm_runtime_disable(indio_dev->dev.parent);
> +}
> +
> +static void rzg2l_adc_reset_assert(void *data)
> +{
> +	struct reset_control *reset = data;
Why do we need the local variable?

	reset_control_assert(data);

is fine.

> +
> +	reset_control_assert(reset);
> +}
> +
> +static int rzg2l_adc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct rzg2l_adc *adc;
> +	int ret;
> +	int irq;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	adc = iio_priv(indio_dev);
> +
> +	ret = rzg2l_adc_parse_properties(pdev, adc);
> +	if (ret)
> +		return ret;
> +
> +	adc->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(adc->base))
> +		return PTR_ERR(adc->base);
> +
> +	irq = platform_get_irq(pdev, 0);

Please group things together, so we 'get' whatever it is next to where
we use it.  It might make the error handling a tiny bit more complex, but
it makes the code easier to review as we don't have to jump backwards and forwards
all the time. With devm_ in heavy use as you have here, that's all magic
in the error paths anyway :)

> +	if (irq < 0) {
> +		dev_err(dev, "no irq resource\n");
> +		return irq;
> +	}
> +
> +	adc->pclk = devm_clk_get(dev, "pclk");
> +	if (IS_ERR(adc->pclk)) {
> +		dev_err(dev, "Failed to get pclk");
> +		return PTR_ERR(adc->pclk);
> +	}
> +
> +	adc->adclk = devm_clk_get(dev, "adclk");
> +	if (IS_ERR(adc->adclk)) {
> +		dev_err(dev, "Failed to get adclk");
> +		return PTR_ERR(adc->adclk);
> +	}
> +
> +	adc->adrstn = devm_reset_control_get_exclusive(dev, "adrst-n");
> +	if (IS_ERR(adc->adrstn)) {
> +		dev_err(dev, "failed to get adrstn\n");
> +		return PTR_ERR(adc->adrstn);
> +	}
> +
> +	ret = devm_add_action_or_reset(&pdev->dev,
> +				       rzg2l_adc_reset_assert, adc->adrstn);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register adrstn assert devm action, %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	adc->presetn = devm_reset_control_get_exclusive(dev, "presetn");
> +	if (IS_ERR(adc->presetn)) {
> +		dev_err(dev, "failed to get presetn\n");
> +		return PTR_ERR(adc->presetn);
> +	}
> +
> +	ret = devm_add_action_or_reset(&pdev->dev,
> +				       rzg2l_adc_reset_assert, adc->presetn);

As already raised, wrong place.

> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register presetn assert devm action, %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ret = reset_control_deassert(adc->adrstn);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to deassert adrstn pin, %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = reset_control_deassert(adc->presetn);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to deassert presetn pin, %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = rzg2l_adc_hw_init(adc);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to initialize ADC HW, %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = devm_request_irq(dev, irq, rzg2l_adc_isr,
> +			       0, dev_name(dev), adc);
> +	if (ret < 0)
> +		return ret;
> +
> +	init_completion(&adc->completion);
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	indio_dev->name = DRIVER_NAME;
> +	indio_dev->info = &rzg2l_adc_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = adc->data->channels;
> +	indio_dev->num_channels = adc->data->num_channels;
> +
> +	pm_runtime_enable(dev);

I think you also want to set the state to suspended to ensure the resume is
called on get.

> +	ret = devm_add_action_or_reset(&pdev->dev,
> +				       rzg2l_adc_pm_runtime_disable, indio_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register pm_runtime_disable devm action, %d\n",
> +			ret);

This is vanishingly unlikely as it's a tiny memory allocation.  So I would dropt he error
print in the interests of simplicity.  Some of the other items above we don't print
on are more likely to fail.

> +		return ret;
> +	}
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
