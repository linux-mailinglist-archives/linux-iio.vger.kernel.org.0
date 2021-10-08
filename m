Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1DE426FC7
	for <lists+linux-iio@lfdr.de>; Fri,  8 Oct 2021 19:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhJHR6E convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 8 Oct 2021 13:58:04 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3952 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbhJHR6D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Oct 2021 13:58:03 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HQwld540Cz67NKb;
        Sat,  9 Oct 2021 01:53:17 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 8 Oct 2021 19:56:05 +0200
Received: from localhost (10.52.124.14) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 18:56:03 +0100
Date:   Fri, 8 Oct 2021 18:55:43 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <andrei.drimbarean@analog.com>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <fazilyildiran@gmail.com>,
        <robh+dt@kernel.org>, <jic23@kernel.org>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>
Subject: Re: [PATCH 2/2] drivers:iio:light: add ADPD188 driver support
Message-ID: <20211008185543.00007ab2@Huawei.com>
In-Reply-To: <20211008112747.79969-3-andrei.drimbarean@analog.com>
References: <20211008112747.79969-1-andrei.drimbarean@analog.com>
        <20211008112747.79969-3-andrei.drimbarean@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.124.14]
X-ClientProxiedBy: lhreml707-chm.china.huawei.com (10.201.108.56) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 8 Oct 2021 14:27:47 +0300
<andrei.drimbarean@analog.com> wrote:

> From: Andrei Drimbarean <andrei.drimbarean@analog.com>
> 
> Add IIO driver support for the ADPD188 device.
Give a brief version of what you have in the cover letter here.
Cover letters don't end up in the git log, so you need to make
sure all important info is in comments or the patch descriptions themselves.

> 
> More information about the device at:
> https://www.analog.com/media/en/technical-documentation/data-sheets/adpd188bi.pdf
> 

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adpd188bi.pdf
or
Datasheet: https://www.analog.com/adpd188bi
is shorter and lands you at a link to the datasheet.
> Signed-off-by: Andrei Drimbarean <andrei.drimbarean@analog.com>

So, the biggest issue in her is the fact you have callbacks for the two busses
and yet still the core code needs to contain so many if / else pairs
that you might as well not bother with the callbacks.

Tidy that up. I think you can have just one read and one write
callback that takes the device index and then does the address calculations
needed.  That will get rid of a huge amount of complexity in the core driver.

Also, this makes in appropriate use of masked write functions leading to much
more traffic over the bus than needed.  i2c is slow, don't waste it!

I haven't yet worked out how the fifo handling is done, so that'll be something
I'll look closely at in v2.

Thanks,

Jonathan



> ---
>  drivers/iio/light/Kconfig       |   30 +
>  drivers/iio/light/Makefile      |    3 +
>  drivers/iio/light/adpd188.c     | 1389 +++++++++++++++++++++++++++++++
>  drivers/iio/light/adpd188.h     |   64 ++
>  drivers/iio/light/adpd188_i2c.c |  243 ++++++
>  drivers/iio/light/adpd188_spi.c |   97 +++
>  6 files changed, 1826 insertions(+)
>  create mode 100644 drivers/iio/light/adpd188.c
>  create mode 100644 drivers/iio/light/adpd188.h
>  create mode 100644 drivers/iio/light/adpd188_i2c.c
>  create mode 100644 drivers/iio/light/adpd188_spi.c
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 33ad4dd0b5c7..dba2c398e3ef 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -597,4 +597,34 @@ config ZOPT2201
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called zopt2201.
>  
> +config ADPD188
> +	select REGMAP
you aren't using regmap...

> +	bool
> +
> +config ADPD188_SPI
> +	tristate "Analog Devices ADPD188 Integrated Optical Module for Smoke Detection SPI Driver"
> +	depends on SPI
> +	select ADPD188
> +	select REGMAP_SPI
> +	help
> +	  Say yes here if you want to build a driver for the Analog Devices
> +	  Integrated Optical Module for Smoke Detection.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called adpd188_spi and you will also get adpd188
> +	  for the core module.
> +
> +config ADPD188_I2C
> +	tristate "Analog Devices ADPD188 Integrated Optical Module for Smoke Detection I2C Driver"
> +	depends on I2C
> +	select ADPD188
> +	select REGMAP_I2C
> +	help
> +	  Say yes here if you want to build a driver for the Analog Devices
> +	  Integrated Optical Module for Smoke Detection.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called adpd188_i2c and you will also get adpd188
> +	  for the core module.
> +
>  endmenu
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index ea376deaca54..c52d334d0a06 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -57,3 +57,6 @@ obj-$(CONFIG_VEML6030)		+= veml6030.o
>  obj-$(CONFIG_VEML6070)		+= veml6070.o
>  obj-$(CONFIG_VL6180)		+= vl6180.o
>  obj-$(CONFIG_ZOPT2201)		+= zopt2201.o
> +obj-$(CONFIG_ADPD188)		+= adpd188.o
> +obj-$(CONFIG_ADPD188_I2C)	+= adpd188_i2c.o
> +obj-$(CONFIG_ADPD188_SPI)	+= adpd188_spi.o
> diff --git a/drivers/iio/light/adpd188.c b/drivers/iio/light/adpd188.c
> new file mode 100644
> index 000000000000..8988eafeed92
> --- /dev/null
> +++ b/drivers/iio/light/adpd188.c
> @@ -0,0 +1,1389 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * ADPD188 driver
> + *
> + * Copyright 2021 Analog Devices Inc.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqdesc.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>

check headers. 

> +#include <linux/spi/spi.h>
> +#include <linux/string.h>
> +#include <linux/timekeeping.h>
> +
> +#include "adpd188.h"
> +
> +#define ADPD188_REG_STATUS			0x00
> +#define ADPD188_REG_INT_MASK			0x01
> +#define ADPD188_REG_FIFO_THRESH			0x06
> +#define ADPD188_REG_SW_RESET			0x0F
> +#define ADPD188_REG_MODE			0x10
> +#define ADPD188_REG_SLOT_EN			0x11
> +#define ADPD188_REG_FSAMPLE			0x12
> +#define ADPD188_REG_PD_LED_SELECT		0x14
> +#define ADPD188_REG_NUM_AVG			0x15
> +#define ADPD188_REG_INT_SEQ_A			0x17
> +#define ADPD188_REG_SLOTA_CH1_OFFSET		0x18
> +#define ADPD188_REG_SLOTA_CH2_OFFSET		0x19
> +#define ADPD188_REG_SLOTA_CH3_OFFSET		0x1A
> +#define ADPD188_REG_SLOTA_CH4_OFFSET		0x1B
> +#define ADPD188_REG_INT_SEQ_B			0x1D
> +#define ADPD188_REG_SLOTB_CH1_OFFSET		0x1E
> +#define ADPD188_REG_SLOTB_CH2_OFFSET		0x1F
> +#define ADPD188_REG_SLOTB_CH3_OFFSET		0x20
> +#define ADPD188_REG_SLOTB_CH4_OFFSET		0x21
> +
> +enum adpd188_iled_coarse_index {
> +	LED3,
> +	LED1,
> +	LED2
> +};
> +#define ADPD188_REG_ILEDx_COARSE(x)		(0x22 + (x))
> +
> +enum adpd188_slots {
> +	ADPD188_SLOTA,
> +	ADPD188_SLOTB
> +};
> +#define ADPD188_REG_SLOTx_NUMPULSES(x)		(0x31 + (x) * 5)
> +#define ADPD188_REG_SLOTx_AFE_WINDOW(x)		(0x39 + (x) * 2)
> +
> +#define ADPD188_REG_MATH			0x58
> +#define ADPD188_REG_AFE_PWR_CFG1		0x3C
> +#define ADPD188_REG_SAMPLE_CLK			0x4B
> +#define ADPD188_REG_FIFO_DATA			0x60
> +#define ADPD188_REG_16BIT_DATA_BASE		0x64
> +#define ADPD188_REG_32BIT_DATA_LOW_BASE		0x70
> +#define ADPD188_REG_32BIT_DATA_HIGH_BASE	0x74
> +#define ADPD188_REG_16BIT_DATA(_slot, _ch)	\
> +	(ADPD188_REG_16BIT_DATA_BASE + (_ch) + (_slot) * 4)
> +#define ADPD188_REG_32BIT_DATA_LOW(_slot, _ch)	\
> +	(ADPD188_REG_32BIT_DATA_LOW_BASE + (_ch) + (_slot) * 8)
> +#define ADPD188_REG_32BIT_DATA_HIGH(_slot, _ch)	\
> +	(ADPD188_REG_32BIT_DATA_HIGH_BASE + (_ch) + (_slot) * 8)
> +
> +/** ADPD188_REG_STATUS */
> +#define ADPD188_FIFO_CLEAR			BIT(15)
> +#define ADPD188_FIFO_SAMPLES			GENMASK(15, 8)
> +#define ADPD188_SLOTB_INT			BIT(6)
> +#define ADPD188_SLOTA_INT			BIT(5)
> +
> +/** ADPD188_REG_INT_MASK */
> +#define ADPD188_FIFO_INT_MASK			BIT(8)
> +#define ADPD188_SLOTB_INT_MASK			BIT(6)
> +#define ADPD188_SLOTA_INT_MASK			BIT(5)
> +
> +/** ADPD188_REG_FIFO_THRESH */
> +#define ADPD188_FIFO_THRESH			GENMASK(13, 8)
> +
> +/** ADPD188_REG_MODE */
> +#define ADPD188_MODE_MASK			GENMASK(1, 0)
> +
> +/** ADPD188_REG_SLOT_EN */
> +#define ADPD188_RDOUT_MODE_MASK			BIT(13)
> +#define ADPD188_FIFO_OVRN_PREVENT_MASK		BIT(12)
> +#define ADPD188_SLOTB_FIFO_MODE_MASK		GENMASK(8, 6)
> +#define ADPD188_SLOTB_EN_MASK			BIT(5)
> +#define ADPD188_SLOTA_FIFO_MODE_MASK		GENMASK(4, 2)
> +#define ADPD188_SLOTA_EN_MASK			BIT(0)
> +
> +/** ADPD188_REG_SAMPLE_CLK */
> +#define ADPD188_CLK32K_BYP			BIT(8)
> +#define ADPD188_CLK32K_EN			BIT(7)
> +#define ADPD188_CLK32K_ADJUST			GENMASK(5, 0)
> +
> +/** ADPD188_REG_PD_LED_SELECT */
> +#define ADPD188_SLOTB_PD_SEL_MASK		GENMASK(11, 8)
> +#define ADPD188_SLOTA_PD_SEL_MASK		GENMASK(7, 4)
> +#define ADPD188_SLOTB_LED_SEL_MASK		GENMASK(3, 2)
> +#define ADPD188_SLOTA_LED_SEL_MASK		GENMASK(1, 0)
> +
> +/** ADPD188_REG_NUM_AVG */
> +#define ADPD188_SLOTB_NUM_AVG_MASK		GENMASK(10, 8)
> +#define ADPD188_SLOTA_NUM_AVG_MASK		GENMASK(6, 4)
> +
> +/** ADPD188_REG_INT_SEQ_A */
> +#define ADPD188_INTEG_ORDER_A_MASK		GENMASK(3, 0)
> +
> +/* ADPD188_REG_INT_SEQ_B */
> +#define ADPD188_INTEG_ORDER_B_MASK		GENMASK(3, 0)
> +
> +/** ADPD188_REG_ILEDx_COARSE */
> +#define ADPD188_ILEDx_SCALE_MASK		BIT(13)
> +#define ADPD188_ILEDx_SLEW_MASK			GENMASK(6, 4)
> +#define ADPD188_ILEDx_COARSE_MASK		GENMASK(3, 0)
> +
> +/** ADPD188_REG_SLOTx_NUMPULSES */
> +#define ADPD188_SLOTx_PULSES_MASK		GENMASK(15, 8)
> +#define ADPD188_SLOTx_PERIOD_MASK		GENMASK(7, 0)
> +
> +/** ADPD188_REG_SLOTx_AFE_WINDOW */
> +#define ADPD188_SLOTx_AFE_WIDTH_MASK		GENMASK(15, 11)
> +#define ADPD188_SLOTx_AFE_OFFSET_MASK		GENMASK(10, 0)
> +
> +/** ADPD188_REG_AFE_PWR_CFG1 */
> +#define ADPD188_V_CATHODE_MASK			BIT(9)
> +#define ADPD188_AFE_POWERDOWN_MASK		GENMASK(8, 3)
> +
> +/** ADPD188_REG_MATH */
> +#define ADPD188_FLT_MATH34_B_MASK		GENMASK(11, 10)
> +#define ADPD188_FLT_MATH34_A_MASK		GENMASK(9, 8)
> +#define ADPD188_ENA_INT_AS_BUF_MASK		BIT(7)
> +#define ADPD188_FLT_MATH12_B_MASK		GENMASK(6, 5)
> +#define ADPD188_FLT_MATH12_A_MASK		GENMASK(2, 1)
> +
> +#define ADPD188_DEVID		0x16
> +#define ADPD188_MAX_FSAMPLE	2000
> +
> +#define DEFAULT_SAMPLE_FREQUENCY	16
> +
> +enum adpd188_modes {
> +	STANDBY,
> +	PROGRAM,
> +	NORMAL
> +};
> +
> +enum adpd188_slot_fifo_mode {
> +	ADPD188_NO_FIFO,
> +	ADPD188_16BIT_SUM,
> +	ADPD188_32BIT_SUM,
> +	ADPD188_16BIT_4CHAN = 0x4,
> +	ADPD188_32BIT_4CHAN = 0x6
> +};
> +
> +struct adpd188_slot_config {
> +	enum adpd188_slots slot_id;
> +	bool slot_en;
> +	enum adpd188_slot_fifo_mode slot_fifo_mode;
> +};
> +
> +static int adpd188_reg_access(struct iio_dev *indio_dev,
> +			      unsigned int reg,
> +			      unsigned int tx_val,
> +			      unsigned int *rx_val)
> +{
> +	struct adpd188 *dev = iio_priv(indio_dev);
> +	struct adpd188_ops *ops = dev->ops;
> +	struct i2c_client *i2c = dev->bus;
> +	int dev_id = (reg & 0xF00) >> 8;
> +	int ret;
> +
> +	if ((dev->phy_opt != ADPD188_I2C) || (dev_id == 0)) {
> +		if (rx_val)
> +			ret = ops->reg_read(dev->bus, reg, rx_val);
> +		else
> +			ret = ops->reg_write(dev->bus, reg, tx_val);
> +	} else {
> +		if (rx_val)
> +			ret = ops->i2c_sub_read(dev->bus,
> +						 (i2c->addr + dev_id),
> +						 reg, rx_val);
> +		else
> +			ret = ops->i2c_sub_write(dev->bus,
> +						  (i2c->addr + dev_id),
> +						  reg, tx_val);
> +	}
> +
> +	return (ret < 0) ? ret : 0;
> +}
> +
> +static int adpd188_i2c_reg_write_mask(struct adpd188 *dev_data,
> +				      int dev_id, int addr,
> +				      int value, int mask)
> +{
> +	int temp_val;
> +	int ret;
> +	struct adpd188_ops *ops = dev_data->ops;
> +
> +	ret = ops->i2c_sub_read(dev_data->bus, dev_id, addr, &temp_val);
> +	if (ret < 0)
> +		return ret;
> +	temp_val &= ~mask;
> +	temp_val |= (value << (ffs(mask) - 1)) & mask;
> +
> +	return ops->i2c_sub_write(dev_data->bus, dev_id, addr, temp_val);
> +}
> +
> +static int adpd188_spi_reg_write_mask(struct adpd188 *dev_data, int addr,
> +				  int value, int mask)
> +{
> +	int temp_val;
> +	int ret;
> +	struct adpd188_ops *ops = dev_data->ops;
> +
> +	ret = ops->reg_read(dev_data->bus, addr, &temp_val);
> +	if (ret < 0)
> +		return ret;
> +	temp_val &= ~mask;
> +	temp_val |= (value << (ffs(mask) - 1)) & mask;
> +
> +	return ops->reg_write(dev_data->bus, addr, temp_val);
> +}
> +
> +static int adpd188_reg_write_mask(struct adpd188 *dev_data, int addr,
> +				  int value, int mask)
> +{
> +	struct i2c_client *i2c = dev_data->bus;
> +
> +	if (dev_data->phy_opt == ADPD188_SPI)
> +		return adpd188_spi_reg_write_mask(dev_data, addr, value, mask);
> +	else
> +		return adpd188_i2c_reg_write_mask(dev_data, i2c->addr,
> +						  addr, value, mask);
> +}
> +
> +static int adpd188_set_device_mode(struct adpd188 *dev_data, int new_mode)
> +{
> +	int regval, ret;
> +	struct adpd188_ops *ops = dev_data->ops;
> +
> +	regval = new_mode & ADPD188_MODE_MASK;
> +
> +	ret = ops->reg_write(dev_data->bus, ADPD188_REG_MODE, regval);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int adpd188_sub_set_device_mode(struct adpd188 *dev_data, int new_mode,
> +				       int dev_id)
> +{
> +	int regval, ret;
> +	struct adpd188_ops *ops = dev_data->ops;
> +	struct i2c_client *i2c = dev_data->bus;
> +
> +	regval = new_mode & ADPD188_MODE_MASK;
> +
> +	ret = ops->i2c_sub_write(dev_data->bus, (i2c->addr + dev_id),
> +				  ADPD188_REG_MODE, regval);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int adpd188_all_set_device_mode(struct adpd188 *dev_data, int new_mode)
> +{
> +	int regval, ret, i;
> +	struct adpd188_ops *ops = dev_data->ops;
> +	struct i2c_client *i2c = dev_data->bus;
> +
> +	regval = new_mode & ADPD188_MODE_MASK;
> +
> +	ret = ops->reg_write(dev_data->bus, ADPD188_REG_MODE, regval);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i = 1; i < dev_data->no_devices; i++) {
> +		ret = ops->i2c_sub_write(dev_data->bus, (i2c->addr + i),
> +					  ADPD188_REG_MODE, regval);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int adpd188_clear_fifos(struct adpd188 *dev_data)
> +{
> +	int ret, i;
> +	struct i2c_client *i2c = dev_data->bus;
> +
> +	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_STATUS,
> +				  1, ADPD188_FIFO_CLEAR);
> +	if (ret < 0)
> +		return ret;
> +	for (i = 1; i < dev_data->no_devices; i++) {
> +		ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + i,
> +						 ADPD188_REG_STATUS,
> +						 1, ADPD188_FIFO_CLEAR);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int adpd188_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct adpd188 *data = iio_priv(indio_dev);
> +	struct adpd188_ops *ops = data->ops;
> +	int ret, i;
> +	int regval, regaddr;
> +	int data_buf[4];
> +	struct i2c_client *i2c = data->bus;
> +	unsigned long j0, j1, delay;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = ops->reg_read(data->bus, ADPD188_REG_FSAMPLE, &regval);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = 32000000 / (regval * 4);
> +		*val2 = 1000;
> +
> +		return IIO_VAL_FRACTIONAL;
As it's fractional, maintain precision by setting
*val = 8000;
*val2 = regval;
  Perhaps with a comment to relate this to the datasheet which I'm guessing
expresses it like you did it.

> +	case IIO_CHAN_INFO_OFFSET:
> +		if ((chan->scan_index % 2) == 0)

Might be cleaner to use the color?

> +			regaddr = ADPD188_REG_SLOTA_CH1_OFFSET;
> +		else
> +			regaddr = ADPD188_REG_SLOTB_CH1_OFFSET;
> +
> +		if (data->phy_opt == ADPD188_I2C)
> +			ret = ops->i2c_sub_read(data->bus,
> +						(i2c->addr + (chan->channel / 2)),
> +						regaddr, &regval);
> +		else
> +			ret = ops->reg_read(data->bus, regaddr, &regval);
> +		if (ret < 0)
> +			return ret;
> +		*val = regval;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_RAW:
> +		ret = adpd188_all_set_device_mode(data, PROGRAM);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = adpd188_all_set_device_mode(data, NORMAL);
> +		if (ret < 0)
> +			return ret;
> +
> +		delay = msecs_to_jiffies(1000); /* 1 sec delay */
> +		j0 = jiffies;
> +		j1 = j0 + delay;
> +		while (time_before(jiffies, j1)) {
> +			if (data->phy_opt == ADPD188_I2C)
> +				ret = ops->i2c_sub_read(data->bus,
> +							(i2c->addr + chan->scan_index / 2),
> +							ADPD188_REG_STATUS, &regval);
> +			else
> +				ret = ops->reg_read(data->bus, ADPD188_REG_STATUS, &regval);
> +			if (ret < 0)
> +				return ret;
> +			regval &= ADPD188_FIFO_SAMPLES;
> +			regval >>= ffs(ADPD188_FIFO_SAMPLES) - 1;
> +			if (regval >= (4 * 2))
> +				break;
> +		}
> +		if (time_after(jiffies, j1))
> +			return -ETIME;
> +
> +		for (i = 0; i < 4; i++) {
> +			if (data->phy_opt == ADPD188_I2C)
> +				ret = ops->i2c_sub_read(data->bus,
> +							(i2c->addr + chan->scan_index / 2),
> +							ADPD188_REG_FIFO_DATA,
> +							data_buf + i);
> +			else
> +				ret = ops->reg_read(data->bus, ADPD188_REG_FIFO_DATA, data_buf + i);
> +			if (ret < 0)
> +				return ret;
> +		}
> +
> +		if ((chan->scan_index % 2) == 0)
> +			*val = data_buf[0] | (data_buf[1] << 16);

From this I'd guess data_buf used here should be a u16 array?

> +		else
> +			*val = data_buf[2] | (data_buf[3] << 16);
> +
> +		ret = adpd188_all_set_device_mode(data, PROGRAM);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = adpd188_clear_fifos(data);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = adpd188_all_set_device_mode(data, STANDBY);
> +		if (ret < 0)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EINVAL;

Move this into a default so the compiler knows we only handled the cases we did
intentionally rather than missing some.

> +}
> +
> +static int adpd188_set_sample_freq(struct adpd188 *dev_data, int new_freq_int, int new_freq_frac)
> +{
> +	int regval;
> +	struct adpd188_ops *ops = dev_data->ops;
> +	int new_freq = new_freq_int * 1000 + new_freq_frac / 1000;
> +
> +	regval = 32000000 / (new_freq * 4);
> +
> +	return ops->reg_write(dev_data->bus, ADPD188_REG_FSAMPLE, regval);
> +}
> +
> +static int adpd188_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct adpd188 *data = iio_priv(indio_dev);
> +	struct adpd188_ops *ops = data->ops;
> +	int regaddr;
> +	int ret, ret2;
> +	struct i2c_client *i2c = data->bus;
> +
> +	ret = adpd188_all_set_device_mode(data, PROGRAM);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if ((val > ADPD188_MAX_FSAMPLE) || (val < 0)) {
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		ret = adpd188_set_sample_freq(data, val, val2);
> +		break;
> +	case IIO_CHAN_INFO_OFFSET:
> +		if ((chan->scan_index % 2) == 0)
> +			regaddr = ADPD188_REG_SLOTA_CH1_OFFSET;
> +		else
> +			regaddr = ADPD188_REG_SLOTB_CH1_OFFSET;
> +
> +		if (data->phy_opt == ADPD188_I2C)
> +			ret = ops->i2c_sub_write(data->bus,
> +						 (i2c->addr + chan->channel / 2),

Given you have an index value that I think corresponds to channel / 2, use that instead.

> +						 regaddr, val);
> +		else
> +			ret = ops->reg_write(data->bus, regaddr, val);
> +		break;
> +	}
> +
> +	ret2 = adpd188_all_set_device_mode(data, STANDBY);
> +	if (ret2 < 0)
> +		return ret2;
> +
> +	return (ret < 0) ? ret : 0;
> +}
> +
> +static int adpd188_mode_get(struct iio_dev *indio_dev,
> +			const struct iio_chan_spec *chan)
> +{
> +	struct adpd188 *data = iio_priv(indio_dev);
> +	struct adpd188_ops *ops = data->ops;
> +	int regval;
> +	int ret;
> +
> +	ret = ops->reg_read(data->bus, ADPD188_REG_MODE, &regval);
> +	if (ret < 0)
> +		return ret;
> +
> +	return regval & ADPD188_MODE_MASK;
> +}
> +
> +static int adpd188_mode_set(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
> +			unsigned int mode)
> +{
> +	struct adpd188 *data = iio_priv(indio_dev);
> +
> +	return adpd188_all_set_device_mode(data, mode);
> +}
> +
> +static const char * const adpd188_modes_ascii[] = {"STANDBY", "PROGRAM", "NORMAL"};
> +
> +static const struct iio_enum adpd188_mode_iio_enum = {
> +	.items = adpd188_modes_ascii,
> +	.num_items = ARRAY_SIZE(adpd188_modes_ascii),
> +	.get = adpd188_mode_get,
> +	.set = adpd188_mode_set,
> +
> +};
> +
> +static struct iio_chan_spec_ext_info adpd188_ext_info[] = {
> +	IIO_ENUM_AVAILABLE("mode", &adpd188_mode_iio_enum),
> +	IIO_ENUM("mode", IIO_SHARED_BY_ALL, &adpd188_mode_iio_enum)

Why does this need to be exposed to userspace?  It looks very much like something that
should be automatically managed by the driver.

> +};
> +
> +#define ADPD188_32BIT_CHANNEL(index, scan, color) {					\
> +	.type = IIO_LIGHT,								\
> +	.modified = 1,									\
> +	.channel2 = IIO_MOD_LIGHT_##color,						\
> +	.indexed = 1,									\
> +	.channel = index,								\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_OFFSET),	\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
> +	.ext_info = adpd188_ext_info,							\
> +	.scan_index = scan,								\
> +	.scan_type = {									\
> +		.sign = 'u',								\
> +		.realbits = 32,								\
> +		.storagebits = 32,							\
> +		.endianness = IIO_LE,							\
> +	},										\
> +}
> +
> +static const struct iio_chan_spec adpd188_channels[] = {
> +	IIO_CHAN_SOFT_TIMESTAMP(16),
> +	ADPD188_32BIT_CHANNEL(0, 0, BLUE),
> +	ADPD188_32BIT_CHANNEL(0, 1, IR),
> +	ADPD188_32BIT_CHANNEL(1, 2, BLUE),
> +	ADPD188_32BIT_CHANNEL(1, 3, IR),
> +	ADPD188_32BIT_CHANNEL(2, 4, BLUE),
> +	ADPD188_32BIT_CHANNEL(2, 5, IR),
> +	ADPD188_32BIT_CHANNEL(3, 6, BLUE),
> +	ADPD188_32BIT_CHANNEL(3, 7, IR),
> +	ADPD188_32BIT_CHANNEL(4, 8, BLUE),
> +	ADPD188_32BIT_CHANNEL(4, 9, IR),
> +	ADPD188_32BIT_CHANNEL(5, 10, BLUE),
> +	ADPD188_32BIT_CHANNEL(5, 11, IR),
> +	ADPD188_32BIT_CHANNEL(6, 12, BLUE),
> +	ADPD188_32BIT_CHANNEL(6, 13, IR),
> +	ADPD188_32BIT_CHANNEL(7, 14, BLUE),
> +	ADPD188_32BIT_CHANNEL(7, 15, IR)
> +};
> +
> +static const struct iio_info adpd188_info = {
> +	.read_raw       = adpd188_read_raw,
> +	.write_raw      = adpd188_write_raw,
> +	.debugfs_reg_access = &adpd188_reg_access,
> +};
> +
> +static int adpd188_slot_setup(struct adpd188 *dev_data, struct adpd188_slot_config config)
> +{

For all these, you need to find a clean way to avoid the repetition of code
for the 1st and later devices.

> +	int ret;
> +
> +	if (config.slot_id == ADPD188_SLOTA) {
> +		ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_SLOT_EN,
> +					     config.slot_en,
> +					     ADPD188_SLOTA_EN_MASK);
> +		if (ret < 0)
> +			return ret;
> +		ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_SLOT_EN,
> +					     config.slot_fifo_mode,
> +					     ADPD188_SLOTA_FIFO_MODE_MASK);
> +	} else if (config.slot_id == ADPD188_SLOTB) {
> +		ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_SLOT_EN,
> +					     config.slot_en,
> +					     ADPD188_SLOTB_EN_MASK);
> +		if (ret < 0)
> +			return ret;
> +		ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_SLOT_EN,
> +					     config.slot_fifo_mode,
> +					     ADPD188_SLOTB_FIFO_MODE_MASK);
> +	}
> +
> +	return ret;
> +}
> +
> +static int adpd188_sub_slot_setup(struct adpd188 *dev_data, struct adpd188_slot_config config,
> +				  int dev_id)
> +{
> +	int ret = 0;
> +	struct i2c_client *i2c = dev_data->bus;
> +
> +	if (config.slot_id == ADPD188_SLOTA) {
> +		ret = adpd188_i2c_reg_write_mask(dev_data, (i2c->addr + dev_id),
> +						ADPD188_REG_SLOT_EN,
> +					     config.slot_en,
> +					     ADPD188_SLOTA_EN_MASK);
> +		if (ret < 0)
> +			return ret;
blank line
> +		ret = adpd188_i2c_reg_write_mask(dev_data, (i2c->addr + dev_id),
> +						ADPD188_REG_SLOT_EN,
> +					     config.slot_fifo_mode,
> +					     ADPD188_SLOTA_FIFO_MODE_MASK);

		return adpd18...*

> +	} else if (config.slot_id == ADPD188_SLOTB) {
> +		ret = adpd188_i2c_reg_write_mask(dev_data, (i2c->addr + dev_id),
> +						ADPD188_REG_SLOT_EN,
> +					     config.slot_en,
> +					     ADPD188_SLOTB_EN_MASK);
> +		if (ret < 0)
> +			return ret;
> +		ret = adpd188_i2c_reg_write_mask(dev_data, (i2c->addr + dev_id),
> +						ADPD188_REG_SLOT_EN,
> +					     config.slot_fifo_mode,
> +					     ADPD188_SLOTB_FIFO_MODE_MASK);
> +	}
> +
> +	return ret;
> +}
> +
> +static int adpd188_core_smoke_setup(struct adpd188 *dev_data)
> +{
> +	int ret;
> +	struct adpd188_slot_config ts_config;
> +	struct adpd188_ops *ops = dev_data->ops;
> +
> +	ret = adpd188_set_device_mode(dev_data, PROGRAM);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_SLOT_EN, 1,
> +				     ADPD188_RDOUT_MODE_MASK);
> +	if (ret < 0)
> +		return ret;
> +	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_SLOT_EN, 1,
> +				     ADPD188_FIFO_OVRN_PREVENT_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ts_config.slot_id = ADPD188_SLOTA;
> +	ts_config.slot_en = true;
> +	ts_config.slot_fifo_mode = ADPD188_32BIT_SUM;
> +	ret = adpd188_slot_setup(dev_data, ts_config);
> +	if (ret < 0)
> +		return ret;
> +
> +	ts_config.slot_id = ADPD188_SLOTB;
> +	ret = adpd188_slot_setup(dev_data, ts_config);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_set_sample_freq(dev_data, DEFAULT_SAMPLE_FREQUENCY, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_PD_LED_SELECT,
> +				     1, ADPD188_SLOTA_LED_SEL_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_PD_LED_SELECT,
> +				     3, ADPD188_SLOTB_LED_SEL_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_PD_LED_SELECT,
> +				     1, ADPD188_SLOTA_PD_SEL_MASK);
> +	if (ret < 0)
> +		return ret;

This is a good example of why masked write functions are often a bad idea.
Build the value and write it one go (assuming the hardware doesn't have some
odd limitation around this).

> +
> +	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_PD_LED_SELECT,
> +				     1, ADPD188_SLOTB_PD_SEL_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ops->reg_write(dev_data->bus, ADPD188_REG_NUM_AVG, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Slot A chan chop mode and chan offset */
> +	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_INT_SEQ_A,
> +				     9, ADPD188_INTEG_ORDER_A_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ops->reg_write(dev_data->bus,
> +			ADPD188_REG_SLOTA_CH1_OFFSET, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ops->reg_write(dev_data->bus,
> +			ADPD188_REG_SLOTA_CH2_OFFSET, 0x3FFF);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ops->reg_write(dev_data->bus,
> +			ADPD188_REG_SLOTA_CH3_OFFSET, 0x3FFF);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ops->reg_write(dev_data->bus,
> +			ADPD188_REG_SLOTA_CH4_OFFSET, 0x3FFF);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Slot B chan chop mode and chan offset */
> +	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_INT_SEQ_B,
> +				     9, ADPD188_INTEG_ORDER_B_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ops->reg_write(dev_data->bus,
> +			ADPD188_REG_SLOTB_CH1_OFFSET, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ops->reg_write(dev_data->bus,
> +			ADPD188_REG_SLOTB_CH2_OFFSET, 0x3FFF);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ops->reg_write(dev_data->bus,
> +			ADPD188_REG_SLOTB_CH3_OFFSET, 0x3FFF);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ops->reg_write(dev_data->bus,
> +			ADPD188_REG_SLOTB_CH4_OFFSET, 0x3FFF);
> +	if (ret < 0)
> +		return ret;
> +
> +	/** Set IR LED 3 power */
> +	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_ILEDx_COARSE(LED3),
> +				     9, ADPD188_ILEDx_COARSE_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_ILEDx_COARSE(LED3),
> +				     3, ADPD188_ILEDx_SLEW_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_ILEDx_COARSE(LED3),
> +				     1, ADPD188_ILEDx_SCALE_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	/** Set blue LED 1 power */
> +	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_ILEDx_COARSE(LED1),
> +				     6, ADPD188_ILEDx_COARSE_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_ILEDx_COARSE(LED1),
> +				     3, ADPD188_ILEDx_SLEW_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_ILEDx_COARSE(LED1),
> +				     1, ADPD188_ILEDx_SCALE_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Slot A 4 LED pulses with 15us period */
> +	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_SLOTx_NUMPULSES(ADPD188_SLOTA),
> +				     4, ADPD188_SLOTx_PULSES_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_SLOTx_NUMPULSES(ADPD188_SLOTA),
> +				     0xE, ADPD188_SLOTx_PERIOD_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Slot B 4 LED pulses with 15us period */
> +	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_SLOTx_NUMPULSES(ADPD188_SLOTB),
> +				     4, ADPD188_SLOTx_PULSES_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_SLOTx_NUMPULSES(ADPD188_SLOTB),
> +				     0xE, ADPD188_SLOTx_PERIOD_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Slot A integrator window */
> +	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_SLOTx_AFE_WINDOW(ADPD188_SLOTA),
> +				     4, ADPD188_SLOTx_AFE_WIDTH_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_SLOTx_AFE_WINDOW(ADPD188_SLOTA),
> +				     0x2F0, ADPD188_SLOTx_AFE_OFFSET_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Slot B integrator window */
> +	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_SLOTx_AFE_WINDOW(ADPD188_SLOTB),
> +				     4, ADPD188_SLOTx_AFE_WIDTH_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_SLOTx_AFE_WINDOW(ADPD188_SLOTB),
> +				     0x2F0, ADPD188_SLOTx_AFE_OFFSET_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Power down channels 2, 3 and 4 */
> +	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_AFE_PWR_CFG1,
> +				     0x38, ADPD188_AFE_POWERDOWN_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Math for chop mode is inverted, non-inverted, non-inverted, inverted */
> +	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_MATH,
> +				     1, ADPD188_FLT_MATH34_B_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_MATH,
> +				     1, ADPD188_FLT_MATH34_A_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_MATH,
> +				     2, ADPD188_FLT_MATH12_B_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_MATH,
> +				     2, ADPD188_FLT_MATH12_A_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_FIFO_THRESH,
> +					SAMPLE_WORDS, ADPD188_FIFO_THRESH);
> +	if (ret < 0)
> +		return ret;
> +
> +	return adpd188_set_device_mode(dev_data, STANDBY);
> +}
> +
> +static int adpd188_sub_core_smoke_setup(struct adpd188 *dev_data, int dev_id)
> +{
> +	int ret;
> +	struct adpd188_slot_config ts_config;
> +	struct adpd188_ops *ops = dev_data->ops;
> +	struct i2c_client *i2c = dev_data->bus;
> +
> +	ret = adpd188_sub_set_device_mode(dev_data, PROGRAM, dev_id);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
> +				     ADPD188_REG_SLOT_EN, 1,
> +				     ADPD188_RDOUT_MODE_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
> +					 ADPD188_REG_SLOT_EN, 1,
> +				     ADPD188_FIFO_OVRN_PREVENT_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ts_config.slot_id = ADPD188_SLOTA;
> +	ts_config.slot_en = true;
> +	ts_config.slot_fifo_mode = ADPD188_32BIT_SUM;
> +	ret = adpd188_sub_slot_setup(dev_data, ts_config, dev_id);
> +	if (ret < 0)
> +		return ret;
> +
> +	ts_config.slot_id = ADPD188_SLOTB;
> +	ret = adpd188_sub_slot_setup(dev_data, ts_config, dev_id);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ops->i2c_sub_write(dev_data->bus, i2c->addr + dev_id, 0x4F, 0x20B8);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
> +					ADPD188_REG_PD_LED_SELECT,
> +				     1, ADPD188_SLOTA_LED_SEL_MASK);

It looks to be worth an array of [register, value, msk] so that you can do
all this stuff with a loop over that array.

> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
> +					ADPD188_REG_PD_LED_SELECT,
> +				     3, ADPD188_SLOTB_LED_SEL_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
> +					ADPD188_REG_PD_LED_SELECT,
> +				     1, ADPD188_SLOTA_PD_SEL_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
> +					ADPD188_REG_PD_LED_SELECT,
> +				     1, ADPD188_SLOTB_PD_SEL_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ops->i2c_sub_write(dev_data->bus, i2c->addr + dev_id, ADPD188_REG_NUM_AVG, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Slot A chan chop mode and chan offset */
> +	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
> +					ADPD188_REG_INT_SEQ_A,
> +				     9, ADPD188_INTEG_ORDER_A_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ops->i2c_sub_write(dev_data->bus, i2c->addr + dev_id,
> +			ADPD188_REG_SLOTA_CH1_OFFSET, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ops->i2c_sub_write(dev_data->bus, i2c->addr + dev_id,
> +			ADPD188_REG_SLOTA_CH2_OFFSET, 0x3FFF);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ops->i2c_sub_write(dev_data->bus, i2c->addr + dev_id,
> +			ADPD188_REG_SLOTA_CH3_OFFSET, 0x3FFF);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ops->i2c_sub_write(dev_data->bus, i2c->addr + dev_id,
> +			ADPD188_REG_SLOTA_CH4_OFFSET, 0x3FFF);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Slot B chan chop mode and chan offset */
> +	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
> +					ADPD188_REG_INT_SEQ_B,
> +				     9, ADPD188_INTEG_ORDER_B_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ops->i2c_sub_write(dev_data->bus, i2c->addr + dev_id,
> +			ADPD188_REG_SLOTB_CH1_OFFSET, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ops->i2c_sub_write(dev_data->bus, i2c->addr + dev_id,
> +			ADPD188_REG_SLOTB_CH2_OFFSET, 0x3FFF);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ops->i2c_sub_write(dev_data->bus, i2c->addr + dev_id,
> +			ADPD188_REG_SLOTB_CH3_OFFSET, 0x3FFF);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ops->i2c_sub_write(dev_data->bus, i2c->addr + dev_id,
> +			ADPD188_REG_SLOTB_CH4_OFFSET, 0x3FFF);
> +	if (ret < 0)
> +		return ret;
> +
> +	/** Set IR LED 3 power */
> +	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
> +					ADPD188_REG_ILEDx_COARSE(LED3),
> +				     9, ADPD188_ILEDx_COARSE_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
> +					ADPD188_REG_ILEDx_COARSE(LED3),
> +				     3, ADPD188_ILEDx_SLEW_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
> +					ADPD188_REG_ILEDx_COARSE(LED3),
> +				     1, ADPD188_ILEDx_SCALE_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	/** Set blue LED 1 power */
> +	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
> +					ADPD188_REG_ILEDx_COARSE(LED1),
> +				     6, ADPD188_ILEDx_COARSE_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
> +					ADPD188_REG_ILEDx_COARSE(LED1),
> +				     3, ADPD188_ILEDx_SLEW_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
> +					ADPD188_REG_ILEDx_COARSE(LED1),
> +				     1, ADPD188_ILEDx_SCALE_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Slot A 4 LED pulses with 15us period */
> +	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
> +					ADPD188_REG_SLOTx_NUMPULSES(ADPD188_SLOTA),
> +				     4, ADPD188_SLOTx_PULSES_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
> +					ADPD188_REG_SLOTx_NUMPULSES(ADPD188_SLOTA),
> +				     0xE, ADPD188_SLOTx_PERIOD_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Slot B 4 LED pulses with 15us period */
> +	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
> +					ADPD188_REG_SLOTx_NUMPULSES(ADPD188_SLOTB),
> +				     4, ADPD188_SLOTx_PULSES_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
> +					ADPD188_REG_SLOTx_NUMPULSES(ADPD188_SLOTB),
> +				     0xE, ADPD188_SLOTx_PERIOD_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Slot A integrator window */
> +	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
> +					ADPD188_REG_SLOTx_AFE_WINDOW(ADPD188_SLOTA),
> +				     4, ADPD188_SLOTx_AFE_WIDTH_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
> +					ADPD188_REG_SLOTx_AFE_WINDOW(ADPD188_SLOTA),
> +				     0x2F0, ADPD188_SLOTx_AFE_OFFSET_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Slot B integrator window */
> +	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
> +					ADPD188_REG_SLOTx_AFE_WINDOW(ADPD188_SLOTB),
> +				     4, ADPD188_SLOTx_AFE_WIDTH_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
> +					ADPD188_REG_SLOTx_AFE_WINDOW(ADPD188_SLOTB),
> +				     0x2F0, ADPD188_SLOTx_AFE_OFFSET_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Power down channels 2, 3 and 4 */
> +	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
> +					ADPD188_REG_AFE_PWR_CFG1,
> +				     0x38, ADPD188_AFE_POWERDOWN_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Math for chop mode is inverted, non-inverted, non-inverted, inverted */
> +	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
> +					ADPD188_REG_MATH,
> +				     1, ADPD188_FLT_MATH34_B_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
> +					ADPD188_REG_MATH,
> +				     1, ADPD188_FLT_MATH34_A_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
> +					ADPD188_REG_MATH,
> +				     2, ADPD188_FLT_MATH12_B_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
> +					ADPD188_REG_MATH,
> +				     2, ADPD188_FLT_MATH12_A_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_FIFO_THRESH,
> +					SAMPLE_WORDS, ADPD188_FIFO_THRESH);
> +	if (ret < 0)
> +		return ret;
> +
> +
> +	return adpd188_sub_set_device_mode(dev_data, STANDBY, dev_id);
> +}
> +
> +static int adpd188_data_rdy_trigger_set_state(struct iio_trigger *trig,
> +					      bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct adpd188 *data = iio_priv(indio_dev);
> +	struct i2c_client *i2c = data->bus;
> +	int reg, ret;
> +
> +	ret = adpd188_all_set_device_mode(data, PROGRAM);
> +	if (ret < 0)
> +		return ret;
> +
> +	reg = !state;
> +
> +	if (data->phy_opt == ADPD188_SPI)
> +		ret = adpd188_spi_reg_write_mask(data, ADPD188_REG_INT_MASK,
> +					  reg, ADPD188_FIFO_INT_MASK);
> +	else
> +		ret = adpd188_i2c_reg_write_mask(data, (i2c->addr + (data->no_devices - 1)),
> +						 ADPD188_REG_INT_MASK,
> +						 reg, ADPD188_FIFO_INT_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	reg = state ? NORMAL : STANDBY;

> +
> +	ret = adpd188_all_set_device_mode(data, reg);

Make sure that function returns <= 0 and then just
return adp188_*();

> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static const struct iio_trigger_ops adpd188_trigger_ops = {
> +	.set_trigger_state = adpd188_data_rdy_trigger_set_state,
> +	.validate_device = iio_trigger_validate_own_device,
> +};
> +
> +static irqreturn_t adpd188_interrupt(int irq, void *dev_id)
> +{
> +	struct iio_dev *indio_dev = dev_id;
> +
> +	iio_trigger_poll(indio_dev->trig);
> +
> +	return IRQ_WAKE_THREAD;
> +};
> +
> +static irqreturn_t adpd188_oneshot_apply(int irq, void *dev_id)
> +{
> +	int ret;
> +	struct iio_dev *indio_dev = dev_id;
> +	struct adpd188 *dev_data = iio_priv(indio_dev);
> +
> +	ret = wait_for_completion_interruptible_timeout(&dev_data->value_ok,
> +			msecs_to_jiffies(5000));
> +	if (ret == 0) {
> +		pr_err("adpd188: Data handle timeout.\n");
> +		ret = IRQ_NONE;
> +	} else {
> +		ret = IRQ_HANDLED;
> +	}
> +	reinit_completion(&dev_data->value_ok);

I don't understand the intent of this function.  It is papering over
something, but I'm not sure what. 
Is idea to prevent the interrupt reenabling? If so use explcit
irq_disable() as appropriate and provide a reenable() callback that
will get called only when the pollfunctions have all completed.


> +
> +	return ret;
> +}
> +
> +static irqreturn_t adpd188_trigger_handler(int irq, void  *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct adpd188 *dev_data = iio_priv(indio_dev);
> +	int i, j, no_dev = dev_data->no_devices, ret;

Don't mix uninitialized and initialized variable declarations in one line.
It is too easy to miss it when reading.

> +	struct adpd188_ops *ops = dev_data->ops;
> +	struct i2c_client *i2c = dev_data->bus;
> +
> +	for (i = 0; i < no_dev; i++) {
> +		for (j = 0; j < 4; j++) {
> +			if (dev_data->phy_opt == ADPD188_I2C)
> +				ret = ops->i2c_sub_read(i2c, (i2c->addr + i),

you should work out how to make this a single call.  Teh only thing that is i2c specific
in this callback is the i2c address.   Pass i instead and work out that address in the i2c
specific driver.

> +							ADPD188_REG_FIFO_DATA,
> +							(int *)&dev_data->data.reg_data[(i*4+j)]);

spaces around * and +

> +			else
> +				ret = ops->reg_read(dev_data->bus, ADPD188_REG_FIFO_DATA,
> +							(int *)&dev_data->data.reg_data[(i*4+j)]);
> +			if (ret < 0)
> +				goto irq_handled;
> +		}
> +	}
> +
> +	ret = iio_push_to_buffers_with_timestamp(indio_dev, dev_data->data.word,

See the c specification. It is not valid to assume that data written via one element of a union will
be visible on a read to another (even when they are definitely at the same memory address).

You probably want to drop the union and use a few type casts where needed.

> +		pf->timestamp);
> +	if (ret < 0)
> +		pr_err("adpd188: IIO buffer push error.\n");
> +
> +irq_handled:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	complete(&dev_data->value_ok);

That's unusual.  There should be no need to synchronize anything with this.
If there is, please add comments so we can see why.

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int adpd188_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct adpd188 *dev_data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = adpd188_all_set_device_mode(dev_data, PROGRAM);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_clear_fifos(dev_data);
> +	if (ret < 0)
> +		return ret;
> +
> +	return adpd188_all_set_device_mode(dev_data, STANDBY);
> +}
> +
> +static const struct iio_buffer_setup_ops adpd188_buffer_setup_ops = {
> +	.postdisable = &adpd188_buffer_postdisable
> +};
> +
> +static int adpd188_core_sub_setup(struct iio_dev *indio_dev, struct device *dev,
> +				  int dev_no)
> +{
> +	int i;

Reverse xmas preferred where possible.

> +	int ret;
> +	int regval;
> +	struct adpd188 *dev_data = iio_priv(indio_dev);
> +	struct adpd188_ops *ops = dev_data->ops;
> +	struct i2c_client *i2c = dev_data->bus;
> +
> +	for (i = 1; i < dev_no; i++) {
> +		ret = ops->i2c_sub_read(dev_data->bus, (i2c->addr + i),

excess brackets. Please tidy those up throughout.  As you care going to
use this a lot, maybe just have a
u8 i2c_addr = i2c->addr + 1 inside this loop?



> +					ADPD188_REG_DEVID, &regval);
> +		if (ret < 0)
> +			return ret;
> +		if ((regval & ADPD188_DEVID_MASK) != ADPD188_DEVID) {

FIELD_GET() - see below.


> +			dev_err(dev, "Error wrong device ID: %d\n", ret);
> +			return -ENODEV;
> +		}
> +
> +		ret = adpd188_i2c_reg_write_mask(dev_data, (i2c->addr + i),
> +						 ADPD188_REG_SAMPLE_CLK, 1,
> +						 ADPD188_CLK32K_EN);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = adpd188_sub_core_smoke_setup(dev_data, i);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = adpd188_i2c_reg_write_mask(dev_data, (i2c->addr + i),
> +						 ADPD188_REG_GPIO_CTRL,
> +						 0xD, ADPD188_GPIO0_ALT_CONFIG);
> +		if (ret < 0)
> +			return ret;
blank line

> +		if (i == (dev_no - 1)) {

Non obvious enough this warrants a comment.

Having i2c or spi specific functions in here rather implies the callback model is
not appropriate btw.

> +			ret = adpd188_i2c_reg_write_mask(dev_data, (i2c->addr + i),
> +							 ADPD188_REG_FIFO_THRESH,
> +							 SAMPLE_WORDS, ADPD188_FIFO_THRESH);
> +			if (ret < 0)
> +				return ret;
> +
> +			ret = adpd188_i2c_reg_write_mask(dev_data, (i2c->addr + i),
> +							 ADPD188_REG_GPIO_CTRL,
> +							 0x0, ADPD188_GPIO0_ALT_CONFIG);
> +			if (ret < 0)
> +				return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int adpd188_core_setup(struct iio_dev *indio_dev, struct device *dev,
> +			      int irq)
> +{
> +	int ret;
> +	int regval;

Where possible, nice to have reverse xmas tree ordering of local variable definitions.
So move these two down 3 lines and swapt hem.

> +	struct adpd188 *dev_data = iio_priv(indio_dev);
> +	struct adpd188_ops *ops = dev_data->ops;
> +	struct iio_trigger *trig;
> +
> +	ret = ops->reg_read(dev_data->bus, ADPD188_REG_DEVID, &regval);
> +	if (ret < 0)
> +		return ret;
> +	if ((regval & ADPD188_DEVID_MASK) != ADPD188_DEVID) {

if (FIELD_GET(ADPD118_DEVID_MASK, regval) != ADPD118_DEVID)
rather than handling the masks by hand where we have to go check if this
happens to be start at bit 0

> +		dev_err(dev, "Error wrong device ID: %d\n", regval);
> +		return -ENODEV;
> +	}
> +
> +	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_SAMPLE_CLK, 1, ADPD188_CLK32K_EN);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_core_smoke_setup(dev_data);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_GPIO_DRV, 1, ADPD188_GPIO0_ENA);
> +	if (ret < 0)
> +		return ret;
> +	if (dev_data->no_devices > 1)
> +		regval = 0xD;
> +	else
> +		regval = 0x0;
> +	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_GPIO_CTRL,
> +				     regval, ADPD188_GPIO0_ALT_CONFIG);
> +	if (ret < 0)
> +		return ret;
> +
> +	trig = devm_iio_trigger_alloc(indio_dev->dev.parent, "%s-dev%d",
> +				      indio_dev->name,
> +				      indio_dev->id);
> +	if (!trig)
> +		return -ENOMEM;
> +
> +	trig->dev.parent = indio_dev->dev.parent;

That's set by the IIO core in devm_iio_trigger_alloc()

> +	trig->ops = &adpd188_trigger_ops;
> +	iio_trigger_set_drvdata(trig, indio_dev);
> +
> +	ret = devm_iio_trigger_register(dev, trig);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->trig = iio_trigger_get(trig);
> +
> +	init_completion(&dev_data->value_ok);

Do this stuff earlier. The trigger is exposed and manybe enabled after
you call devm_iio_trigger_register() so all setup should occur before then.

> +
> +	ret = devm_request_threaded_irq(indio_dev->dev.parent, irq,
> +			       &adpd188_interrupt, &adpd188_oneshot_apply,
> +			       IRQF_TRIGGER_HIGH | IRQF_ONESHOT,

Why do we need to specify the polarity?  There might be an inverter in the path
so we avoid doing this (in new drivers) unless there is a reason it can't be inverted.

> +			       indio_dev->name, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_triggered_buffer_setup(indio_dev->dev.parent, indio_dev,
> +					       &iio_pollfunc_store_time,
> +					       &adpd188_trigger_handler,
> +					       &adpd188_buffer_setup_ops);
> +}
> +
> +int adpd188_core_probe(void *bus, struct adpd188_ops *phy,
> +		       enum adpd188_phy_opt opt,
> +		       int dev_no,
> +		       const char *name, int irq)
> +{
> +	struct iio_dev *indio_dev;
> +	int ret;
> +	struct i2c_client *i2c;
> +	struct spi_device *spi;
> +	struct adpd188 *dev_data;
> +	struct device *dev;
> +
> +	if (opt == ADPD188_I2C) {
> +		i2c = (struct i2c_client *)bus;
> +		dev = &i2c->dev;

Just pass the struct device *dev in to start with?
As mentioned below that is a more sensible pointer to use for the callbacks
as well.

> +	} else {
> +		spi = (struct spi_device *)bus;
> +		dev = &spi->dev;
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*dev_data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	dev_data = iio_priv(indio_dev);
> +	dev_data->ops = phy;
> +	dev_data->phy_opt = opt;
> +	dev_data->no_devices = dev_no;
> +	dev_data->bus = bus;
> +
> +	indio_dev->dev.parent = dev;

no longer any need to set this - it's done by the core for you.

> +	indio_dev->info = &adpd188_info;
> +	indio_dev->name = name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = adpd188_channels;
> +	indio_dev->num_channels = 2 * dev_no + 1;
> +
> +	ret = adpd188_core_setup(indio_dev, dev, irq);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (dev_no > 1) {
> +		ret = adpd188_core_sub_setup(indio_dev, dev, dev_no);
> +		if (ret < 0)
I'd prefer if these functions never returned > 0 as it makes for more
readable error handling.

> +			return ret;
> +	}
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +EXPORT_SYMBOL_GPL(adpd188_core_probe);
> +
> +MODULE_AUTHOR("Andrei Drimbarean <andrei.drimbarean@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices ADPD188core driver");
> +MODULE_LICENSE("GPL v2");
> +
> diff --git a/drivers/iio/light/adpd188.h b/drivers/iio/light/adpd188.h
> new file mode 100644
> index 000000000000..7daa36444527
> --- /dev/null
> +++ b/drivers/iio/light/adpd188.h
> @@ -0,0 +1,64 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * ADPD188 Integrated Optical Module for Smoke Detection
> + *
> + * Copyright 2021 Analog Devices Inc.
> + */
> +
> +#ifndef _ADPD188_H_
> +#define _ADPD188_H_
> +
> +#define ADPD188_REG_GPIO_DRV			0x02
> +#define ADPD188_REG_DEVID			0x08
> +#define ADPD188_REG_GPIO_CTRL			0x0B
> +
> +/** ADPD188_REG_GPIO_DRV */

As below. and run kernel-doc over these files as that /** means
the docs are in kernel doc format and these are not.

> +#define ADPD188_GPIO1_DRV			BIT(9)
> +#define ADPD188_GPIO1_POL			BIT(8)
> +#define ADPD188_GPIO0_ENA			BIT(2)
> +#define ADPD188_GPIO0_DRV			BIT(1)
> +#define ADPD188_GPIO0_POL			BIT(0)
> +
> +/** ADPD188_REG_DEVID */
> +#define ADPD188_DEVID_MASK				GENMASK(7, 0)
> +
> +/** ADPD188_REG_GPIO_CTRL */
> +#define ADPD188_GPIO1_ALT_CONFIG		GENMASK(12, 8)
> +#define ADPD188_GPIO0_ALT_CONFIG		GENMASK(4, 0)
> +
> +struct adpd188_ops {
> +	int (*reg_write)(void *bus, int reg_addr, int val);
> +	int (*reg_read)(void *bus, int reg_addr, int *val);
> +	int (*i2c_sub_write)(void *bus, int sub_addr, int reg_addr, int val);
> +	int (*i2c_sub_read)(void *bus, int sub_addr, int reg_addr, int *val);

As mentioned below, I don't like the void * in these. Please refactor so that it
is a specific type.

Some documentation somewhere here on why we have sub_write / sub_read would
also be good to have.

> +};
> +
> +enum adpd188_phy_opt {
> +	ADPD188_I2C,
> +	ADPD188_SPI

It's a little odd to have an ops structure and still need to separately identify the
type to know what to call.  You should be able to avoid that by either
checking if the callback is set, or providing a generic solution for the spi
driver so that you can make the same call in both cases.


> +};
> +
> +#define SAMPLE_WORDS	18
> +struct adpd188 {
> +	struct adpd188_ops *ops;
> +	enum adpd188_phy_opt phy_opt;
> +	void *bus;

I'm thinking struct device *dev is probably right for this and then
you can use relevant cast functions to get to the actual bus type specific
type.

> +	int no_devices;
> +	union {
> +		u32 word[SAMPLE_WORDS];
> +		u16 reg_data[SAMPLE_WORDS * 2];
> +	} data ____cacheline_aligned;

That needs to be at the end, or you defeated the whole point.
You've guaranteed these start in a new cacheline, but that doesn't stop the
value_ok field ending up later in that cacheline.

> +	struct completion value_ok;
> +};
> +
> +enum supported_parts {
Prefix everything in headers with the part name.  Otherwise we are very likely
to get a naming clash at some stage.

Normally we'd only introduce this in the patch supporting a second part.
Until then it's just noise.  Only exception is if you are going to post that
additional support very soon in which case you can keep it.

> +	ADPD188
> +};
> +
> +int adpd188_core_probe(void *bus, struct adpd188_ops *phy,
> +		       enum adpd188_phy_opt opt,
> +		       int dev_no,
> +		       const char *name, int irq);
> +
> +#endif /* _ADPD188_H_ */
> +
> diff --git a/drivers/iio/light/adpd188_i2c.c b/drivers/iio/light/adpd188_i2c.c
> new file mode 100644
> index 000000000000..644c8a41461a
> --- /dev/null
> +++ b/drivers/iio/light/adpd188_i2c.c
> @@ -0,0 +1,243 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ADPD188 I2C driver
> + *
> + * Copyright 2021 Analog Devices Inc.
> + *
> + * 7-bit I2C slave address: 0x64
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +
> +#include "adpd188.h"
> +
> +#define ADPD188_REG_I2CS_ID			0x09
> +#define ADPD188_REG_SLAVE_ADDR_KEY		0x0D
> +#define ADPD188_REG_EXT_SYNC_SEL		0x4F
> +
> +/** ADPD188_REG_I2CS_ID */
Rename them so it's obvious which reg they are in from their names and
move them to under that definition.

#define ADPD188_I2CS_ID_REG			0x09
#define   ADPD118_I2CS_ID_ADDR_WRITE_KEY_MSK	GENMASK()

etc.  Indenting makes it easy to see what is the register and what the fields.


> +#define ADPD188_ADDRESS_WRITE_KEY_MASK		GENMASK(15, 8)
> +#define ADPD188_SLAVE_ADDRESS_MASK		GENMASK(7, 1)
> +
> +/** ADPD188_REG_SLAVE_ADDR_KEY */
> +#define EN_I2C_ADDR_CHANGE_ALWAYS		0x04AD
> +#define EN_I2C_ADDR_CHANGE_IF_GPIO0_HIGH	0x44AD
> +#define EN_I2C_ADDR_CHANGE_IF_GPIO1_HIGH	0x84AD
> +
> +/** ADPD188_REG_EXT_SYNC_SEL */
> +#define ADPD188_GPIO1_OE			BIT(6)
> +#define ADPD188_GPIO1_IE			BIT(5)
> +#define ADPD188_EXT_SYNC_SEL			GENMASK(3, 2)
> +#define ADPD188_GPIO0_IE			BIT(1)
> +
> +struct adpd188_i2c_buff {
> +	u8 addr;
> +	__be16 val;
> +} __packed;
> +
> +static int adpd188_sub_reg_write(void *bus, int i2c_addr,
> +			   int reg_addr, int value)
> +{
> +	struct i2c_msg msg;
> +	struct adpd188_i2c_buff buf;
> +	struct i2c_client *i2c = (struct i2c_client *)bus;
> +
> +	buf.addr = reg_addr;
> +	buf.val = cpu_to_be16(value);
> +	msg.addr = i2c_addr;
> +	msg.flags = 0;
> +	msg.len = 3;
> +	msg.buf = (u8 *)&buf;
> +
> +	return i2c_transfer(i2c->adapter, &msg, 1);

I suggest for all these read and write functions you check
for the correct length in the function and return 0 for success or
negative error as appropriate. That normally simplifies error throughout the
driver.

This looks like smbus_read_word() and you should use those functions if you
can.

> +}
> +
> +static int adpd188_sub_reg_read(void *bus, int i2c_addr, int reg_addr,

Why int for the various address that we know are smaller?

> +			  int *value)
> +{
> +	int ret;
> +	struct i2c_msg msg[2];
> +	struct adpd188_i2c_buff buf;
> +	struct i2c_client *i2c = (struct i2c_client *)bus;
> +
> +	msg[0].addr = i2c_addr;
> +	msg[0].flags = 0;
> +	msg[0].len = 1;
> +	buf.addr = reg_addr;
> +	msg[0].buf = &buf.addr;
> +	msg[1].addr = i2c_addr;
> +	msg[1].flags = I2C_M_RD;
> +	msg[1].len = 2;
> +	msg[1].buf = (u8 *)&buf.val;
document why this can't be a standard smbus command.
My guess is we need a NACK in an unusual position
However, that's not what the datasheet suggests so please
provide more info here.

> +
> +	ret = i2c_transfer(i2c->adapter, msg, 2);
> +	if (ret < 0)
> +		return ret;
> +
> +	*value = be16_to_cpu(buf.val);
> +
> +	return 0;
> +}
> +
> +static int adpd188_sub_reg_write_mask(void *bus, int i2c_addr,
> +				int reg_addr, int value, int mask)
> +{
> +	int ret;
> +	u16 reg_val;
> +	struct i2c_client *i2c = (struct i2c_client *)bus;

No need for explicit casts from void * to anything (c spec doesn't require them).
However, given this is just used locally why pass it in a void *?

> +
> +	ret = adpd188_sub_reg_read(i2c, i2c_addr, reg_addr, (int *)&reg_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	reg_val &= ~mask;
> +	reg_val |= (value << (ffs(mask) - 1)) & mask;
> +
> +	return adpd188_sub_reg_write(i2c, i2c_addr, reg_addr, reg_val);
> +}
> +
> +static int adpd188_prime_reg_write_mask(void *bus, int addr,
> +				  int value, int mask)
> +{
> +	struct i2c_client *i2c = (struct i2c_client *)bus;
As above, why all the void * mess?

> +
> +	return adpd188_sub_reg_write_mask(bus, i2c->addr, addr, value, mask);
> +}
> +
> +static int adpd188_prime_reg_read(void *bus, int addr, int *value)
> +{
> +	struct i2c_client *i2c = (struct i2c_client *)bus;
> +
> +	return adpd188_sub_reg_read(bus, i2c->addr, addr, value);
> +}
> +
> +static int adpd188_prime_reg_write(void *bus, int addr, int value)
> +{
> +	struct i2c_client *i2c = (struct i2c_client *)bus;
> +
> +	return adpd188_sub_reg_write(bus, i2c->addr, addr, value);
> +}
> +
> +static int adpd188_i2c_addr_change(struct i2c_client *i2c, int no_devices)
> +{
> +	int ret;
> +	int val;
> +	int i;
> +
> +	ret = adpd188_prime_reg_read(i2c, ADPD188_REG_DEVID, &val);
> +	if (ret < 0) {
> +		dev_err(&i2c->dev, "i2c read failed. ret=%d\n", ret);
> +		return ret;
> +	}
> +	if ((val & 0xFF) != 0x16) {
> +		dev_err(&i2c->dev, "i2c read failed. ret=%d val=%x\n", ret, val);

In a comparison like this with a known value it's useful to give a more explicit
error message, perhaps indicating what register was read so we have some way 
to know why val wasn't a good value.

> +		return ret;
> +	}
> +
> +	ret = adpd188_prime_reg_write_mask(i2c, ADPD188_REG_GPIO_DRV,
> +				  1, ADPD188_GPIO0_ENA);
> +	if (ret < 0)  {
> +		dev_err(&i2c->dev, "Error GPIO 0 enable: %d\n", ret);
> +		return ret;
> +	}

blank line after each command / error handling block

> +	ret = adpd188_prime_reg_write_mask(i2c, ADPD188_REG_GPIO_CTRL,
> +				  0x11, ADPD188_GPIO0_ALT_CONFIG);
> +	if (ret < 0)  {
> +		dev_err(&i2c->dev, "Error GPIO 0 state to high: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = adpd188_prime_reg_write_mask(i2c, ADPD188_REG_EXT_SYNC_SEL,
> +				1, ADPD188_GPIO1_IE);
> +	if (ret < 0)  {
> +		dev_err(&i2c->dev, "Error 0x4F not accessible: %d\n", ret);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < (no_devices - 1); i++) {
> +		val = (0xAD << (ffs(ADPD188_ADDRESS_WRITE_KEY_MASK) - 1)) |
> +			((i2c->addr + i + 1) << (ffs(ADPD188_SLAVE_ADDRESS_MASK) - 1));

Given there is 'magic' going on here. Add some comments on why this particular maths.

> +		ret = adpd188_sub_reg_write(i2c, (i2c->addr + i), ADPD188_REG_SLAVE_ADDR_KEY,
> +					EN_I2C_ADDR_CHANGE_IF_GPIO1_HIGH);
> +		if (ret < 0)  {
> +			dev_err(&i2c->dev, "Error changing slave address key: %d\n", ret);
> +			return ret;
> +		}

blank line.

> +		ret = adpd188_sub_reg_write(i2c, (i2c->addr + i), ADPD188_REG_I2CS_ID, val);
Excess brackets.

> +		if (ret < 0)  {
> +			dev_err(&i2c->dev, "Error changing slave address: %d\n", i);
> +			return ret;
> +		}
blank line.
> +		ret = adpd188_sub_reg_read(i2c, (i2c->addr + i + 1), ADPD188_REG_DEVID, &val);
> +		if ((ret < 0) || ((val & 0xFF) != 0x16)) {
> +			dev_err(&i2c->dev, "Failed to access device after reg change.\n");
> +			return ret;
> +		}
> +		ret = adpd188_sub_reg_write_mask(i2c, (i2c->addr + i), ADPD188_REG_GPIO_CTRL,
> +						0x10, ADPD188_GPIO0_ALT_CONFIG);
> +		if (ret < 0) {
> +			dev_err(&i2c->dev, "Error changing GPIO 0 to low: %d\n", i);
> +			return ret;
> +		}
> +	}
> +
> +	dev_info(&i2c->dev, "adpd188 IDs changed.\n");

That's noise in the log.  dev_dbg() if you keep it at all.

> +
> +	return 0;
> +}
> +
> +static int adpd188_i2c_probe(struct i2c_client *i2c)
> +{
> +	int ret;
> +	u32 no_devices;
> +	struct adpd188_ops *phy;
> +
> +	ret = of_property_read_u32(i2c->dev.of_node,
> +				   "adi,no-of-devices", &no_devices);

Use generic firmware property reads instead of the of specific ones.
See linux/property.h
This makes it possible to probe this driver from an ACPI binding using
PRP0001.

> +	if (ret)
> +		return ret;
You aren't requiring this property in the binding, which is probably reasonable
as there is a fairly obvious default.  However, this code requires that it
be provided.

> +
> +	if (no_devices > 1) {
> +		ret = adpd188_i2c_addr_change(i2c, no_devices);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	phy = devm_kzalloc(&i2c->dev, sizeof(*phy), GFP_KERNEL);
> +	if (!phy)
> +		return -ENOMEM;
> +	phy->reg_write = adpd188_prime_reg_write;
> +	phy->reg_read = adpd188_prime_reg_read;
> +	phy->i2c_sub_write = adpd188_sub_reg_write;
> +	phy->i2c_sub_read = adpd188_sub_reg_read;
> +
> +	return adpd188_core_probe(i2c, phy, ADPD188_I2C, no_devices, i2c->name, i2c->irq);
> +}
> +
> +static const struct i2c_device_id adpd188_i2c_id[] = {
> +	{ "adpd188", ADPD188 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, adpd188_i2c_id);
> +
> +static const struct of_device_id adpd188_of_match[] = {
> +	{ .compatible = "adi,adpd188" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, adpd188_of_match);
> +
> +static struct i2c_driver adpd188_i2c_driver = {
> +	.driver = {
> +			.name = "adpd188_i2c",
> +			.of_match_table = adpd188_of_match,
> +		},
> +	.probe_new = adpd188_i2c_probe,
> +	.id_table = adpd188_i2c_id,
> +};
> +module_i2c_driver(adpd188_i2c_driver);
> +
> +MODULE_AUTHOR("Andrei Drimbarean <andrei.drimbarean@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices ADPD188 I2C driver");
> +MODULE_LICENSE("GPL v2");
> +
> diff --git a/drivers/iio/light/adpd188_spi.c b/drivers/iio/light/adpd188_spi.c
> new file mode 100644
> index 000000000000..ba93750bf1b5
> --- /dev/null
> +++ b/drivers/iio/light/adpd188_spi.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ADPD188 SPI driver
> + *
> + * Copyright 2021 Analog Devices Inc.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of.h>

#include <linux/mod_devicetable.h> instead as I assume this
is here for the device id table.

> +#include <linux/spi/spi.h>
> +
> +#include "adpd188.h"
> +
> +static int adpd188_reg_write(void *bus, int addr, int value)
> +{
> +	struct spi_device *spi = bus;
> +	u8 buff[3];
> +	struct spi_message m;
> +	struct spi_transfer t = {0};
> +
> +	buff[0] = (addr << 1) | 1;
> +	buff[1] = value >> 8;
> +	buff[2] = value & 0xff;
> +
> +	t.tx_buf = buff;
> +	t.len = 3;
> +
> +	spi_message_init_with_transfers(&m, &t, 1);
> +
> +	return spi_sync(spi, &m);
> +}
> +
> +static int adpd188_reg_read(void *bus, int addr, int *value)
> +{
> +	struct spi_device *spi = bus;

Try to avoid passing a bare void * pointer.
Probably a case of passing one of iio_dev, iio_priv(), a struct device...
I haven't looked that closely to figure out which would be easiest at your
call sites.

> +	uint8_t buff[3];

Spi buffers should be dma safe and variables on the stack are not.
Various ways around this.
1) allocate it on the heap as that will guarantee alignment
2) look at how we use __cacheline_aligned in other IIO drivers to
embed this in the iio_priv structure.

alternatively it looks tome like
spi_write_then_read() could be used here and that uses bounce buffers
to avoid this complexity.


> +	struct spi_message m;
> +	struct spi_transfer t = {0};
> +	int ret;
> +
> +	buff[0] = addr << 1;
> +
> +	t.rx_buf = buff;
> +	t.tx_buf = buff;
> +	t.len = 3;
> +
> +	spi_message_init_with_transfers(&m, &t, 1);
> +
> +	ret = spi_sync(spi, &m);
> +	if (ret < 0)
> +		return ret;
> +
> +	*value = (buff[1] << 8) | buff[2];

get_unaligned_be16() as expresses the meaning of what is happening
and there might be a more optimal definition on some architectures.

> +
> +	return ret;

return 0;  I'm fairly sure it can't be anything else, but best to be
explicit if you can.

> +}
> +
> +static int adpd188_spi_probe(struct spi_device *spi)
> +{
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +	struct adpd188_ops *phy;

Why phy as the name?

> +
> +	phy = devm_kzalloc(&spi->dev, sizeof(*phy), GFP_KERNEL);
> +	if (!phy)
> +		return -ENOMEM;

Blank line preferred after error handling statements like this (makes the code a little tiny
bit easier to read).

> +	phy->reg_write = adpd188_reg_write;
> +	phy->reg_read = adpd188_reg_read;
> +
> +	return adpd188_core_probe(spi, phy, ADPD188_SPI, 1, id->name, spi->irq);
> +}
> +
> +static const struct spi_device_id adpd188_spi_id[] = {
> +	{ "adpd188", ADPD188 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, adpd188_spi_id);
> +
> +static const struct of_device_id adpd188_of_match[] = {
> +	{ .compatible = "adi,adpd188" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, adpd188_of_match);
> +
> +static struct spi_driver adpd188_spi_driver = {
> +	.driver = {
> +			.name = "adpd188_spi",
> +			.of_match_table = adpd188_of_match,
> +		},
> +	.probe = adpd188_spi_probe,
> +	.id_table = adpd188_spi_id,
> +};
> +module_spi_driver(adpd188_spi_driver);
> +
> +MODULE_AUTHOR("Andrei Drimbarean <andrei.drimbarean@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices ADPD188 SPI driver");
> +MODULE_LICENSE("GPL v2");
> +

