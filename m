Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB63517CED9
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 15:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgCGOyR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 09:54:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:43100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbgCGOyQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Mar 2020 09:54:16 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F5B520674;
        Sat,  7 Mar 2020 14:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583592855;
        bh=HhjdJeevQ/ebVUd+oSbTgyeyANhCSB+tDXlBFcLoZBA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=holQFPQHpsiE+siSZN7Mhn435CBOPaT/czPSuOxQMKbEuCV55CHCPYEhQAmVB4Arq
         W7+ahPlfeQmEGQBqHCXvzdZNy3kglFz+tPPIDiOqHaHhmjZUMuNZscI0r2BUhrKPVO
         k7DYqYoqbSzMHD7qwt6QINY42oemmOW+NVuLH4mY=
Date:   Sat, 7 Mar 2020 14:54:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v8 5/8] iio: adc: adi-axi-adc: add support for AXI ADC
 IP core
Message-ID: <20200307145411.720a680d@archlinux>
In-Reply-To: <20200306110100.22092-6-alexandru.ardelean@analog.com>
References: <20200306110100.22092-1-alexandru.ardelean@analog.com>
        <20200306110100.22092-6-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 6 Mar 2020 13:00:57 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> This change adds support for the Analog Devices Generic AXI ADC IP core.
> The IP core is used for interfacing with analog-to-digital (ADC) converters
> that require either a high-speed serial interface (JESD204B/C) or a source
> synchronous parallel interface (LVDS/CMOS).
> 
> Usually, some other interface type (i.e SPI) is used as a control interface
> for the actual ADC, while the IP core (controlled via this driver), will
> interface to the data-lines of the ADC and handle  the streaming of data
> into memory via DMA.
> 
> Because of this, the AXI ADC driver needs the other SPI-ADC driver to
> register with it. The SPI-ADC needs to be register via the SPI framework,
> while the AXI ADC registers as a platform driver. The two cannot be ordered
> in a hierarchy as both drivers have their own registers, and trying to
> organize this [in a hierarchy becomes] problematic when trying to map
> memory/registers.
> 
> There are some modes where the AXI ADC can operate as standalone ADC, but
> those will be implemented at a later point in time.
> 
> Link: https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Mostly looks fine, but a few nitpicks from rereading it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/Kconfig             |  20 +
>  drivers/iio/adc/Makefile            |   1 +
>  drivers/iio/adc/adi-axi-adc.c       | 618 ++++++++++++++++++++++++++++
>  include/linux/iio/adc/adi-axi-adc.h |  63 +++
>  4 files changed, 702 insertions(+)
>  create mode 100644 drivers/iio/adc/adi-axi-adc.c
>  create mode 100644 include/linux/iio/adc/adi-axi-adc.h
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index f4da821c4022..445070abf376 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -246,6 +246,26 @@ config AD799X
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad799x.
>  
> +config ADI_AXI_ADC
> +	tristate "Analog Devices Generic AXI ADC IP core driver"
> +	select IIO_BUFFER
> +	select IIO_BUFFER_HW_CONSUMER
> +	select IIO_BUFFER_DMAENGINE
> +	help
> +	  Say yes here to build support for Analog Devices Generic
> +	  AXI ADC IP core. The IP core is used for interfacing with
> +	  analog-to-digital (ADC) converters that require either a high-speed
> +	  serial interface (JESD204B/C) or a source synchronous parallel
> +	  interface (LVDS/CMOS).
> +	  Typically (for such devices) SPI will be used for configuration only,
> +	  while this IP core handles the streaming of data into memory via DMA.
> +
> +	  Link: https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
> +	  If unsure, say N (but it's safe to say "Y").
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called adi-axi-adc.
> +
>  config ASPEED_ADC
>  	tristate "Aspeed ADC"
>  	depends on ARCH_ASPEED || COMPILE_TEST
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 8462455b4228..7c6594d049f9 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_AD7793) += ad7793.o
>  obj-$(CONFIG_AD7887) += ad7887.o
>  obj-$(CONFIG_AD7949) += ad7949.o
>  obj-$(CONFIG_AD799X) += ad799x.o
> +obj-$(CONFIG_ADI_AXI_ADC) += adi-axi-adc.o
>  obj-$(CONFIG_ASPEED_ADC) += aspeed_adc.o
>  obj-$(CONFIG_AT91_ADC) += at91_adc.o
>  obj-$(CONFIG_AT91_SAMA5D2_ADC) += at91-sama5d2_adc.o
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> new file mode 100644
> index 000000000000..17ee20015d71
> --- /dev/null
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -0,0 +1,618 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices Generic AXI ADC IP core
> + * Link: https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
> + *
> + * Copyright 2012-2020 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/buffer-dmaengine.h>
> +
> +#include <linux/fpga/adi-axi-common.h>
> +#include <linux/iio/adc/adi-axi-adc.h>
> +
> +/**
> + * Register definitions:
> + *   https://wiki.analog.com/resources/fpga/docs/axi_adc_ip#register_map
> + */
> +
> +#define LOWER5_MSK			GENMASK(4, 0)
> +#define LOWER5_SET(x)			FIELD_PREP(LOWER5_MSK, x)
> +#define LOWER5_GET(x)			FIELD_GET(LOWER5_MSK, x)

Whilst it may cause more repetition, I'd rather just see these used where
relevant inline.  That will be slightly easier to review.

> +
> +#define LOWER8_MSK			GENMASK(7, 0)
> +#define LOWER8_SET(x)			FIELD_PREP(LOWER8_MSK, x)
> +#define LOWER8_GET(x)			FIELD_GET(LOWER8_MSK, x)
> +
> +#define UPPER16_MSK			GENMASK(31, 16)
> +#define UPPER16_SET(x)			FIELD_PREP(UPPER16_MSK, x)
> +#define UPPER16_GET(x)			FIELD_GET(UPPER16_MSK, x)
> +
> +#define LOWER16_MSK			GENMASK(15, 0)
> +#define LOWER16_SET(x)			FIELD_PREP(LOWER16_MSK, x)
> +#define LOWER16_GET(x)			FIELD_GET(LOWER16_MSK, x)
> +
> +/* ADC controls */
> +
> +#define REG_RSTN				0x0040

Usual stuff: These should be prefixed with driver relevant prefix
maybe ADI_AXI_

> +#define   REG_RSTN_CE_N				BIT(2)
> +#define   REG_RSTN_MMCM_RSTN			BIT(1)
> +#define   REG_RSTN_RSTN				BIT(0)
> +
> +#define REG_CNTRL				0x0044
> +#define   REG_CNTRL_SYNC			BIT(3)
> +#define   REG_CNTRL_R1_MODE			BIT(2)
> +#define   REG_CNTRL_DDR_EDGESEL			BIT(1)
> +#define   REG_CNTRL_PIN_MODE			BIT(0)
> +
> +#define REG_CLK_FREQ				0x0054
> +#define REG_CLK_RATIO				0x0058
> +
> +#define REG_STATUS				0x005C
> +#define   REG_STATUS_PN_ERR			BIT(3)
> +#define   REG_STATUS_PN_OOS			BIT(2)
> +#define   REG_STATUS_OVER_RANGE			BIT(1)
> +#define   REG_STATUS_STATUS			BIT(0)
> +
> +#define REG_SYNC_STATUS				0x0068
> +#define   REG_SYNC_STATUS_SYNC			BIT(0)
> +
> +#define REG_DRP_CNTRL				0x0070
> +#define   REG_DRP_CNTRL_DRP_RWN			BIT(28)
> +#define   REG_DRP_CNTRL_DRP_ADDRESS_MSK		GENMASK(27, 16)
> +#define   REG_DRP_CNTRL_DRP_ADDRESS_SET(x)	\
> +		FIELD_PREP(REG_DRP_CNTRL_DRP_ADDRESS_MSK, x)
> +#define   REG_DRP_CNTRL_DRP_ADDRESS_GET(x)	\
> +		FIELD_GET(REG_DRP_CNTRL_DRP_ADDRESS_MSK, x)
> +
> +#define REG_DRP_STATUS				0x0074
> +#define   REG_DRP_STATUS_DRP_LOCKED		BIT(17)
> +#define   REG_DRP_STATUS_DRP_STATUS		BIT(16)
> +
> +#define REG_DRP_WDATA				0x0078
> +#define   REG_DRP_WDATA_SET			LOWER16_SET
> +#define   REG_DRP_WDATA_GET			LOWER16_GET

As mentioned above, I'd rather see the mask here.  Unless used
an awful lot, I'd rather just see the FIELD_PREP and FIELD_GET
used inline rather than defining a bunch of _SET/_GET only some
of which seem to be used so far.

> +
> +#define REG_DRP_RDATA				0x007C
> +#define   REG_DRP_RDATA_SET			LOWER16_SET
> +#define   REG_DRP_RDATA_GET			LOWER16_GET
> +
> +#define REG_UI_STATUS				0x0088
> +#define   REG_UI_STATUS_OVF			BIT(2)
> +#define   REG_UI_STATUS_UNF			BIT(1)
> +
> +#define REG_USR_CNTRL_1				0x00A0
> +#define   REG_USR_CNTRL_1_USR_CHANMAX_MSK	LOWER8_MSK
> +#define   REG_USR_CNTRL_1_USR_CHANMAX_SET	LOWER8_SET
> +#define   REG_USR_CNTRL_1_USR_CHANMAX_GET	LOWER8_GET
> +
> +#define REG_ADC_START_CODE			0x00A4
> +#define REG_ADC_GPIO_IN				0x00B8
> +#define REG_ADC_GPIO_OUT			0x00BC
> +
> +#define REG_PPS_COUNTER				0x00C0
> +
> +#define REG_PPS_STATUS				0x00C4
> +#define   REG_PPS_STATUS_PPS_STATUS		BIT(0)
> +
> +/* ADC Channel controls */
> +
> +#define REG_CHAN_CNTRL(c)			(0x0400 + (c) * 0x40)
> +#define   REG_CHAN_CNTRL_LB_OWR			BIT(11)
> +#define   REG_CHAN_CNTRL_PN_SEL_OWR		BIT(10)
> +#define   REG_CHAN_CNTRL_IQCOR_ENB		BIT(9)
> +#define   REG_CHAN_CNTRL_DCFILT_ENB		BIT(8)
> +#define   REG_CHAN_CNTRL_FORMAT_SIGNEXT		BIT(6)
> +#define   REG_CHAN_CNTRL_FORMAT_TYPE		BIT(5)
> +#define   REG_CHAN_CNTRL_FORMAT_ENABLE		BIT(4)
> +#define   REG_CHAN_CNTRL_ADC_PN_TYPE_OWR	BIT(1)
> +#define   REG_CHAN_CNTRL_ENABLE			BIT(0)
> +
> +#define REG_CHAN_CNTRL_DEFAULTS		\
> +	(REG_CHAN_CNTRL_FORMAT_SIGNEXT | REG_CHAN_CNTRL_FORMAT_ENABLE |	\
> +	 REG_CHAN_CNTRL_IQCOR_ENB | REG_CHAN_CNTRL_ENABLE)
> +
> +#define REG_CHAN_STATUS(c)			(0x0404 + (c) * 0x40)
> +#define   REG_CHAN_STATUS_PN_ERR		BIT(2)
> +#define   REG_CHAN_STATUS_PN_OOS		BIT(1)
> +#define   REG_CHAN_STATUS_OVER_RANGE		BIT(0)
> +
> +#define REG_CHAN_CNTRL_1(c)			(0x0410 + (c) * 0x40)
> +#define   REG_CHAN_CNTRL_1_DCFILT_OFFSET_MSK	UPPER16_MSK
> +#define   REG_CHAN_CNTRL_1_DCFILT_OFFSET_SET	UPPER16_SET
> +#define   REG_CHAN_CNTRL_1_DCFILT_OFFSET_GET	UPPER16_GET
> +#define   REG_CHAN_CNTRL_1_DCFILT_COEFF_MSK	LOWER16_MSK
> +#define   REG_CHAN_CNTRL_1_DCFILT_COEFF_SET	LOWER16_SET
> +#define   REG_CHAN_CNTRL_1_DCFILT_COEFF_GET	LOWER16_GET
> +
> +#define REG_CHAN_CNTRL_2(c)			(0x0414 + (c) * 0x40)
> +#define   REG_CHAN_CNTRL_2_IQCOR_COEFF_1_MSK	UPPER16_MSK
> +#define   REG_CHAN_CNTRL_2_IQCOR_COEFF_1_SET	UPPER16_SET
> +#define   REG_CHAN_CNTRL_2_IQCOR_COEFF_1_GET	UPPER16_GET
> +#define   REG_CHAN_CNTRL_2_IQCOR_COEFF_2_MSK	LOWER16_MSK
> +#define   REG_CHAN_CNTRL_2_IQCOR_COEFF_2_SET	LOWER16_SET
> +#define   REG_CHAN_CNTRL_2_IQCOR_COEFF_2_GET	LOWER16_GET
> +
> +/*  format is 1.1.14 (sign, integer and fractional bits) */
> +#define IQCOR_INT_1				0x4000UL
> +#define IQCOR_SIGN_BIT				BIT(15)
> +
> +#define REG_CHAN_CNTRL_3(c)			(0x0418 + (c) * 0x40)
> +#define   REG_CHAN_CNTRL_3_ADC_PN_SEL_MSK	UPPER16_MSK
> +#define   REG_CHAN_CNTRL_3_ADC_PN_SEL_SET	UPPER16_SET
> +#define   REG_CHAN_CNTRL_3_ADC_PN_SEL_GET	UPPER16_GET
> +#define   REG_CHAN_CNTRL_3_ADC_DATA_SEL_MSK	LOWER16_MSK
> +#define   REG_CHAN_CNTRL_3_ADC_DATA_SEL_SET	LOWER16_SET
> +#define   REG_CHAN_CNTRL_3_ADC_DATA_SEL_GET	LOWER16_GET
> +
> +#define REG_CHAN_USR_CNTRL_1(c)					(0x0420 + (c) * 0x40)
> +#define   REG_CHAN_USR_CNTRL_1_USR_DATATYPE_BE			BIT(25)
> +#define   REG_CHAN_USR_CNTRL_1_USR_DATATYPE_SIGNED		BIT(24)
> +#define   REG_CHAN_USR_CNTRL_1_USR_DATATYPE_SHIFT_MSK		GENMASK(23, 16)
> +#define   REG_CHAN_USR_CNTRL_1_USR_DATATYPE_SHIFT_SET(x)	\
> +		FIELD_PREP(REG_CHAN_USR_CNTRL_1_USR_DATATYPE_SHIFT_MSK, x)
> +#define   REG_CHAN_USR_CNTRL_1_USR_DATATYPE_SHIFT_GET		\
> +		FIELD_GET(REG_CHAN_USR_CNTRL_1_USR_DATATYPE_SHIFT_MSK, x)
> +#define   REG_CHAN_USR_CNTRL_1_USR_DATATYPE_TOTAL_BITS_MSK	GENMASK(15, 8)
> +#define   REG_CHAN_USR_CNTRL_1_USR_DATATYPE_TOTAL_BITS_SET(x)	\
> +		FIELD_PREP(REG_CHAN_USR_CNTRL_1_USR_DATATYPE_TOTAL_BITS_MSK, x)
> +#define   REG_CHAN_USR_CNTRL_1_USR_DATATYPE_TOTAL_BITS_GET(x)	\
> +		FIELD_GET(REG_CHAN_USR_CNTRL_1_USR_DATATYPE_TOTAL_BITS_MSK, x)
> +#define   REG_CHAN_USR_CNTRL_1_USR_DATATYPE_BITS_MSK		LOWER8_MSK
> +#define   REG_CHAN_USR_CNTRL_1_USR_DATATYPE_BITS_SET		LOWER8_SET
> +#define   REG_CHAN_USR_CNTRL_1_USR_DATATYPE_BITS_GET		LOWER8_GET
> +
> +#define REG_CHAN_USR_CNTRL_2(c)				(0x0424 + (c) * 0x40)
> +#define   REG_CHAN_USR_CNTRL_2_USR_DECIMATION_M_MSK	UPPER16_MSK
> +#define   REG_CHAN_USR_CNTRL_2_USR_DECIMATION_M_SET	UPPER16_SET
> +#define   REG_CHAN_USR_CNTRL_2_USR_DECIMATION_M_GET	UPPER16_GET
> +#define   REG_CHAN_USR_CNTRL_2_USR_DECIMATION_N_MSK	LOWER16_MSK
> +#define   REG_CHAN_USR_CNTRL_2_USR_DECIMATION_N_SET	LOWER16_SET
> +#define   REG_CHAN_USR_CNTRL_2_USR_DECIMATION_N_GET	LOWER16_GET
> +
> +/* IO Delay controls */
> +#define __REG_DELAY_CONTROL(base, lane)		((base) + ((lane) * 0x04))
> +
> +#define REG_DELAY_CONTROL(lane)			\
> +			__REG_DELAY_CONTROL(0x0800, lane)
> +#define    REG_DELAY_CONTROL_MSK		LOWER5_MSK
> +#define    REG_DELAY_CONTROL_SET		LOWER5_SET
> +#define    REG_DELAY_CONTROL_GET		LOWER5_GET
> +
> +struct adi_axi_adc_core_info {
> +	unsigned int				version;
> +};
> +
> +struct adi_axi_adc_state {
> +	struct mutex				lock;
> +
> +	struct adi_axi_adc_client		*client;
> +	void __iomem				*regs;
> +};
> +
> +struct adi_axi_adc_client {
> +	struct list_head			entry;
> +	struct adi_axi_adc_conv			conv;
> +	struct adi_axi_adc_state		*state;
> +	struct device				*dev;
> +	const struct adi_axi_adc_core_info	*info;
> +};
> +
> +static LIST_HEAD(registered_clients);
> +static DEFINE_MUTEX(registered_clients_lock);
> +
> +static struct adi_axi_adc_client *conv_to_client(struct adi_axi_adc_conv *conv)
> +{
> +	if (!conv)
> +		return NULL;
> +	return container_of(conv, struct adi_axi_adc_client, conv);
> +}
> +
> +void *adi_axi_adc_conv_priv(struct adi_axi_adc_conv *conv)
> +{
> +	struct adi_axi_adc_client *cl = conv_to_client(conv);
> +
> +	if (!cl)
> +		return NULL;
> +
> +	return (char *)cl + ALIGN(sizeof(struct adi_axi_adc_client), IIO_ALIGN);
> +}
> +EXPORT_SYMBOL_GPL(adi_axi_adc_conv_priv);
> +
> +static void adi_axi_adc_write(struct adi_axi_adc_state *st,
> +			      unsigned int reg,
> +			      unsigned int val)
> +{
> +	iowrite32(val, st->regs + reg);
> +}
> +
> +static unsigned int adi_axi_adc_read(struct adi_axi_adc_state *st,
> +				     unsigned int reg)
> +{
> +	return ioread32(st->regs + reg);
> +}
> +
> +static int adi_axi_adc_config_dma_buffer(struct device *dev,
> +					 struct iio_dev *indio_dev)
> +{
> +	struct iio_buffer *buffer;
> +	const char *dma_name;
> +
> +	if (!device_property_present(dev, "dmas"))
> +		return 0;
> +
> +	if (device_property_read_string(dev, "dma-names", &dma_name))
> +		dma_name = "rx";
> +
> +	buffer = devm_iio_dmaengine_buffer_alloc(indio_dev->dev.parent,
> +						 dma_name);
> +	if (IS_ERR(buffer))
> +		return PTR_ERR(buffer);
> +
> +	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
> +	iio_device_attach_buffer(indio_dev, buffer);
> +
> +	return 0;
> +}
> +
> +static int adi_axi_adc_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	struct adi_axi_adc_state *st = iio_priv(indio_dev);
> +	struct adi_axi_adc_conv *conv = &st->client->conv;
> +
> +	if (!conv->read_raw)
> +		return -EOPNOTSUPP;
> +
> +	return conv->read_raw(conv, chan, val, val2, mask);
> +}
> +
> +static int adi_axi_adc_write_raw(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan,
> +				 int val, int val2, long mask)
> +{
> +	struct adi_axi_adc_state *st = iio_priv(indio_dev);
> +	struct adi_axi_adc_conv *conv = &st->client->conv;
> +
> +	if (!conv->write_raw)
> +		return -EOPNOTSUPP;
> +
> +	return conv->write_raw(conv, chan, val, val2, mask);
> +}
> +
> +static int adi_axi_adc_update_scan_mode(struct iio_dev *indio_dev,
> +					const unsigned long *scan_mask)
> +{
> +	struct adi_axi_adc_state *st = iio_priv(indio_dev);
> +	struct adi_axi_adc_conv *conv = &st->client->conv;
> +	unsigned int i, ctrl;
> +
> +	for (i = 0; i < conv->chip_info->num_channels; i++) {
> +		ctrl = adi_axi_adc_read(st, REG_CHAN_CNTRL(i));
> +
> +		if (test_bit(i, scan_mask))
> +			ctrl |= REG_CHAN_CNTRL_ENABLE;
> +		else
> +			ctrl &= ~REG_CHAN_CNTRL_ENABLE;
> +
> +		adi_axi_adc_write(st, REG_CHAN_CNTRL(i), ctrl);
> +	}
> +
> +	return 0;
> +}
> +
> +static struct adi_axi_adc_conv *adi_axi_adc_conv_register(struct device *dev,
> +							  int sizeof_priv)
> +{
> +	struct adi_axi_adc_client *cl;
> +	size_t alloc_size;
> +
> +	alloc_size = sizeof(struct adi_axi_adc_client);
> +	if (sizeof_priv) {
> +		alloc_size = ALIGN(alloc_size, IIO_ALIGN);
> +		alloc_size += sizeof_priv;
> +	}
> +	alloc_size += IIO_ALIGN - 1;
> +
> +	cl = kzalloc(alloc_size, GFP_KERNEL);
> +	if (!cl)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mutex_lock(&registered_clients_lock);
> +
> +	get_device(dev);
> +	cl->dev = dev;
> +
> +	list_add_tail(&cl->entry, &registered_clients);
> +
> +	mutex_unlock(&registered_clients_lock);
> +
> +	return &cl->conv;
> +}
> +
> +static void adi_axi_adc_conv_unregister(struct adi_axi_adc_conv *conv)
> +{
> +	struct adi_axi_adc_client *cl = conv_to_client(conv);
> +
> +	if (!cl)
> +		return;
> +
> +	mutex_lock(&registered_clients_lock);
> +
> +	put_device(cl->dev);
> +	list_del(&cl->entry);
This isn't reverse of register.  Why?
Should be list_del then put_device.

> +	kfree(cl);

To reverse the register precisely the kfree(cl) should be outside
the lock...

> +
> +	mutex_unlock(&registered_clients_lock);
> +}
> +
> +static void devm_adi_axi_adc_conv_release(struct device *dev, void *res)
> +{
> +	adi_axi_adc_conv_unregister(*(struct adi_axi_adc_conv **)res);
> +}
> +
> +struct adi_axi_adc_conv *devm_adi_axi_adc_conv_register(struct device *dev,
> +							int sizeof_priv)
> +{
> +	struct adi_axi_adc_conv **ptr, *conv;
> +
> +	ptr = devres_alloc(devm_adi_axi_adc_conv_release, sizeof(*ptr),
> +			   GFP_KERNEL);
> +	if (!ptr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	conv = adi_axi_adc_conv_register(dev, sizeof_priv);
> +	if (IS_ERR(conv)) {
> +		devres_free(ptr);
> +		return ERR_CAST(conv);
> +	}
> +
> +	*ptr = conv;
> +	devres_add(dev, ptr);
> +
> +	return conv;
> +}
> +EXPORT_SYMBOL_GPL(devm_adi_axi_adc_conv_register);
> +
> +static ssize_t in_voltage_scale_available_show(struct device *dev,
> +					       struct device_attribute *attr,
> +					       char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct adi_axi_adc_state *st = iio_priv(indio_dev);
> +	struct adi_axi_adc_conv *conv = &st->client->conv;
> +	size_t len = 0;
> +	int i;
> +
> +	if (!conv->chip_info->num_scales) {
> +		buf[0] = '\n';
> +		return 1;

I'd prefer to see this done using the core available handling.
That way drivers that don't provide this would just not register
it in the first place. It will be a characteristic of the channels.

> +	}
> +
> +	for (i = 0; i < conv->chip_info->num_scales; i++) {
> +		const unsigned int *s = conv->chip_info->scale_table[i];
> +
> +		len += scnprintf(buf + len, PAGE_SIZE - len,
> +				 "%u.%06u ", s[0], s[1]);
> +	}
> +	buf[len - 1] = '\n';
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR_RO(in_voltage_scale_available, 0);
> +
> +static struct attribute *adi_axi_adc_attributes[] = {
> +	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group adi_axi_adc_attribute_group = {
> +	.attrs = adi_axi_adc_attributes,
> +};
> +
> +static const struct iio_info adi_axi_adc_info = {
> +	.read_raw = &adi_axi_adc_read_raw,
> +	.write_raw = &adi_axi_adc_write_raw,
> +	.attrs = &adi_axi_adc_attribute_group,
> +	.update_scan_mode = &adi_axi_adc_update_scan_mode,
> +};
> +
> +static const struct adi_axi_adc_core_info adi_axi_adc_10_0_a_info = {
> +	.version = ADI_AXI_PCORE_VER(10, 0, 'a'),
> +};
> +
> +/* Match table for of_platform binding */
> +static const struct of_device_id adi_axi_adc_of_match[] = {
> +	{ .compatible = "adi,axi-adc-10.0.a", .data = &adi_axi_adc_10_0_a_info },
> +	{ /* end of list */ },
> +};
> +MODULE_DEVICE_TABLE(of, adi_axi_adc_of_match);
> +
> +struct adi_axi_adc_client *adi_axi_adc_attach_client(struct device *dev)
> +{
> +	const struct of_device_id *id;
> +	struct adi_axi_adc_client *cl;
> +	struct device_node *cln;
> +
> +	if (!dev->of_node) {
> +		dev_err(dev, "DT node is null\n");
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	id = of_match_node(adi_axi_adc_of_match, dev->of_node);
> +	if (!id)
> +		return ERR_PTR(-ENODEV);
> +
> +	cln = of_parse_phandle(dev->of_node, "adi,adc-dev", 0);
> +	if (!cln) {
> +		dev_err(dev, "No 'adi,adc-dev' node defined\n");
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	mutex_lock(&registered_clients_lock);
> +
> +	list_for_each_entry(cl, &registered_clients, entry) {
> +		if (!cl->dev)
> +			continue;
> +		if (cl->dev->of_node == cln) {
> +			if (!try_module_get(dev->driver->owner)) {
> +				mutex_unlock(&registered_clients_lock);
> +				return ERR_PTR(-ENODEV);
> +			}
> +			get_device(dev);
> +			cl->info = id->data;
> +			mutex_unlock(&registered_clients_lock);
> +			return cl;
> +		}
> +	}
> +
> +	mutex_unlock(&registered_clients_lock);
> +
> +	return ERR_PTR(-EPROBE_DEFER);
> +}
> +
> +static int adi_axi_adc_setup_channels(struct device *dev,
> +				      struct adi_axi_adc_state *st)
> +{
> +	struct adi_axi_adc_conv *conv = conv = &st->client->conv;
> +	unsigned int val;
> +	int i, ret;
> +
> +	if (conv->preenable_setup) {
> +		ret = conv->preenable_setup(conv);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (i = 0; i < conv->chip_info->num_channels; i++) {
> +		if (i & 1)
> +			val = REG_CHAN_CNTRL_2_IQCOR_COEFF_2_SET(IQCOR_INT_1);
> +		else
> +			val = REG_CHAN_CNTRL_2_IQCOR_COEFF_1_SET(IQCOR_INT_1);
> +		adi_axi_adc_write(st, REG_CHAN_CNTRL_2(i), val);
> +
> +		adi_axi_adc_write(st, REG_CHAN_CNTRL(i),
> +			REG_CHAN_CNTRL_DEFAULTS);
> +	}
> +
> +	return 0;
> +}
> +
> +static void axi_adc_reset(struct adi_axi_adc_state *st)
> +{
> +	adi_axi_adc_write(st, REG_RSTN, 0);
> +	mdelay(10);
> +	adi_axi_adc_write(st, REG_RSTN, REG_RSTN_MMCM_RSTN);
> +	mdelay(10);
> +	adi_axi_adc_write(st, REG_RSTN,
> +			  REG_RSTN_RSTN | REG_RSTN_MMCM_RSTN);
> +}
> +
> +static void adi_axi_adc_cleanup(void *data)
> +{
> +	struct adi_axi_adc_client *cl = data;
> +
> +	put_device(cl->dev);
> +	module_put(cl->dev->driver->owner);
> +}
> +
> +static int adi_axi_adc_probe(struct platform_device *pdev)
> +{
> +	struct adi_axi_adc_conv *conv;
> +	struct iio_dev *indio_dev;
> +	struct adi_axi_adc_client *cl;
> +	struct adi_axi_adc_state *st;
> +	unsigned int ver;
> +	int ret;
> +
> +	cl = adi_axi_adc_attach_client(&pdev->dev);
> +	if (IS_ERR(cl))
> +		return PTR_ERR(cl);
> +
> +	ret = devm_add_action_or_reset(&pdev->dev, adi_axi_adc_cleanup, cl);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*st));
> +	if (indio_dev == NULL)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->client = cl;
> +	cl->state = st;
> +	mutex_init(&st->lock);
> +
> +	st->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(st->regs))
> +		return PTR_ERR(st->regs);
> +
> +	conv = &st->client->conv;
> +
> +	axi_adc_reset(st);
> +
> +	ver = adi_axi_adc_read(st, ADI_AXI_REG_VERSION);
> +
> +	if (cl->info->version > ver) {
> +		dev_err(&pdev->dev,
> +			"IP core version is too old. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n",
> +			ADI_AXI_PCORE_VER_MAJOR(cl->info->version),
> +			ADI_AXI_PCORE_VER_MINOR(cl->info->version),
> +			ADI_AXI_PCORE_VER_PATCH(cl->info->version),
> +			ADI_AXI_PCORE_VER_MAJOR(ver),
> +			ADI_AXI_PCORE_VER_MINOR(ver),
> +			ADI_AXI_PCORE_VER_PATCH(ver));
> +		return -ENODEV;
> +	}
> +
> +	indio_dev->info = &adi_axi_adc_info;
> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->name = dev_name(&pdev->dev);

What does this result in?  Given this is supposed to be a part number
I kind of expected this to be hardcoded to "adi-axi-adc" or similar.

> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->num_channels = conv->chip_info->num_channels;
> +	indio_dev->channels = conv->chip_info->channels;
> +
> +	ret = adi_axi_adc_config_dma_buffer(&pdev->dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = adi_axi_adc_setup_channels(&pdev->dev, st);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_device_register(&pdev->dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	dev_info(&pdev->dev, "AXI ADC IP core (%d.%.2d.%c) probed\n",
> +		ADI_AXI_PCORE_VER_MAJOR(ver),
> +		ADI_AXI_PCORE_VER_MINOR(ver),
> +		ADI_AXI_PCORE_VER_PATCH(ver));
> +
> +	return 0;
> +}
> +
> +static struct platform_driver adi_axi_adc_driver = {
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +		.of_match_table = adi_axi_adc_of_match,
> +	},
> +	.probe = adi_axi_adc_probe,
> +};
> +module_platform_driver(adi_axi_adc_driver);
> +
> +MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices Generic AXI ADC IP core driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/iio/adc/adi-axi-adc.h b/include/linux/iio/adc/adi-axi-adc.h
> new file mode 100644
> index 000000000000..57974944b30b
> --- /dev/null
> +++ b/include/linux/iio/adc/adi-axi-adc.h
> @@ -0,0 +1,63 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Analog Devices Generic AXI ADC IP core driver/library
> + * Link: https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
> + *
> + * Copyright 2012-2020 Analog Devices Inc.
> + */
> +#ifndef __ADI_AXI_ADC_H__
> +#define __ADI_AXI_ADC_H__
> +
> +struct device;
> +struct iio_chan_spec;
> +
> +/**
> + * struct adi_axi_adc_chip_info - Chip specific information
> + * @name		Chip name
> + * @id			Chip ID (usually product ID)
> + * @channels		Channel specifications of type @struct axi_adc_chan_spec
> + * @num_channels	Number of @channels
> + * @scale_table		Supported scales by the chip; tuples of 2 ints
> + * @num_scales		Number of scales in the table
> + * @max_rate		Maximum sampling rate supported by the device
> + */
> +struct adi_axi_adc_chip_info {
> +	const char			*name;
> +	unsigned int			id;
> +
> +	const struct iio_chan_spec	*channels;
> +	unsigned int			num_channels;
> +
> +	const unsigned int		(*scale_table)[2];
> +	int				num_scales;
> +
> +	unsigned long			max_rate;
> +};
> +
> +/**
> + * struct adi_axi_adc_conv - data of the ADC attached to the AXI ADC
> + * @chip_info		chip info details for the client ADC
> + * @preenable_setup	op to run in the client before enabling the AXI ADC

Run the kernel doc script over this and it would have moaned...

No reg_access.

> + * @read_raw		IIO read_raw hook for the client ADC
> + * @write_raw		IIO write_raw hook for the client ADC
> + */
> +struct adi_axi_adc_conv {
> +	const struct adi_axi_adc_chip_info		*chip_info;
> +
> +	int (*preenable_setup)(struct adi_axi_adc_conv *conv);
> +	int (*reg_access)(struct adi_axi_adc_conv *conv, unsigned int reg,
> +			  unsigned int writeval, unsigned int *readval);
> +	int (*read_raw)(struct adi_axi_adc_conv *conv,
> +			struct iio_chan_spec const *chan,
> +			int *val, int *val2, long mask);
> +	int (*write_raw)(struct adi_axi_adc_conv *conv,
> +			 struct iio_chan_spec const *chan,
> +			 int val, int val2, long mask);
> +};
> +
> +struct adi_axi_adc_conv *devm_adi_axi_adc_conv_register(struct device *dev,
> +							int sizeof_priv);
> +
> +void *adi_axi_adc_conv_priv(struct adi_axi_adc_conv *conv);
> +
> +#endif

