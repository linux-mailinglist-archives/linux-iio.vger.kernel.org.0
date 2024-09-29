Return-Path: <linux-iio+bounces-9873-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A66AC989546
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 14:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95B01C2134F
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 12:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB83516C854;
	Sun, 29 Sep 2024 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5DaVPvm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FD713AA47;
	Sun, 29 Sep 2024 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727612255; cv=none; b=ny5E1Fx1jjVLUL1MpLGaCkfg0u05bUDo3+eGiBpAb+xnshAVFLWl7merwoiARiupe2PHcR6cUykrN2xOiL75HQlNlP9Fr0U64qrDAzS6fSrYFBXCuUZm31Tf5wUg0WJ6jbI8ZPtQeXyrUmB8LPQpfpTARX4vkOWqlS6e8ievE80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727612255; c=relaxed/simple;
	bh=/VERLBemMuFqRHjJ+EfZI1VF21ECNH48RJVG/sRCKjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uqa37AE3AQzBYa84ZHDogGIlo2fvTz6nEPyW74GHpZMGMAudqb3FNJKr6/PHnRH7PdXSQiMSg03vYTmLRk6XGg6g7V22CEFQMvDnRtXBDwDk1DGBk5ZNaeXbgeQ6jw78u7xFNfY1z1gNDFQ9phe/fHqx7ZEhbTFWQbJHYcjwSSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5DaVPvm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E346C4CEC5;
	Sun, 29 Sep 2024 12:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727612254;
	bh=/VERLBemMuFqRHjJ+EfZI1VF21ECNH48RJVG/sRCKjg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B5DaVPvmdlmqbIjQbSmtJVJJh9oN+ReqVPRXHNd6aeEvwKLsb4K8URP0kL/x8yvbk
	 3+uc7lkPYJnNVS3I8L11rXwZLCBdQcDVlmmaVjPyZGeuNgwl2cObz46JswXrtQB1xF
	 WpvxOOA9EFrt/dYF3cRia5wogTA5vF4DBgX3eKBnwyAHulKdJ1WiL0IvZtlPz+9dnS
	 9QaUsoowTvA3usZtZKxxG2N3VWBfmvV3pGoKtBNb7aNUasik3jFz29hC6TobidHAbh
	 G1hX8sct6VQBJVKTfCW1U9j2+lOuFHCrKrTI2QFTK8trHbLr+4750rkYsTmmxycZhY
	 I/JFEI4PVO0vA==
Date: Sun, 29 Sep 2024 13:17:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH v3 09/10] iio: dac: ad3552r: add axi platform driver
Message-ID: <20240929131727.0bb8176c@jic23-huawei>
In-Reply-To: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-9-a17b9b3d05d9@baylibre.com>
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
	<20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-9-a17b9b3d05d9@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Sep 2024 11:20:05 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add support for ad3552r-axi, where ad3552r has to be controlled

Give more on what you mean by controlled. This driver is controlling it...

> by the custom (fpga-based) ad3552r AXI DAC IP.

or similar IIO backend.

> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  drivers/iio/dac/Kconfig                   |  11 +
>  drivers/iio/dac/Makefile                  |   1 +
>  drivers/iio/dac/ad3552r-axi.c             | 567 ++++++++++++++++++++++++++++++
>  drivers/iio/dac/ad3552r.h                 |   9 +
>  include/linux/platform_data/ad3552r-axi.h |  18 +
>  5 files changed, 606 insertions(+)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 1cfd7e2a622f..030af7702a3c 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -16,6 +16,17 @@ config AD3552R
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad3552r.
>  
> +config AD3552R_AXI
> +	tristate "Analog Devices AD3552R DAC driver, AXI version"
> +	select IIO_BACKEND
> +	help
> +	  Say yes here to build support for Analog Devices AD3552R
> +	  Digital to Analog Converter, connected through the Xilinx
> +	  fpga AXI interface.

This is stronger than it needs to be.  It's a driver for the DAC
when using a suitable IIO backend that does  DDR QSPI and offloading
of the main data acquisition.  May not be AXI related or Xilinx
related even though that is what you happen to be using today.

> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ad3552r-axi.
I also wonder if this is appropriate. This driver uses a backend.
It doesn't strictly speaking have to be AXI based (which is the bus
off the back of the IP block, not this side).  Maybe
ad3552r-qspi-backend or something more generic like that?

> +
>  config AD5064
>  	tristate "Analog Devices AD5064 and similar multi-channel DAC driver"
>  	depends on (SPI_MASTER && I2C!=m) || I2C
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 56a125f56284..cc2af3aa3f52 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -5,6 +5,7 @@
>  
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AD3552R) += ad3552r.o ad3552r-common.o
> +obj-$(CONFIG_AD3552R_AXI) += ad3552r-axi.o ad3552r-common.o
>  obj-$(CONFIG_AD5360) += ad5360.o
>  obj-$(CONFIG_AD5380) += ad5380.o
>  obj-$(CONFIG_AD5421) += ad5421.o
> diff --git a/drivers/iio/dac/ad3552r-axi.c b/drivers/iio/dac/ad3552r-axi.c
> new file mode 100644
> index 000000000000..85c594e149fa
> --- /dev/null
> +++ b/drivers/iio/dac/ad3552r-axi.c
> @@ -0,0 +1,567 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices AD3552R
> + * Digital to Analog converter driver, AXI DAC backend version
> + *
> + * Copyright 2024 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/backend.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_data/ad3552r-axi.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/units.h>
> +
> +#include "ad3552r.h"
> +
> +#define AD3552R_QSPI_LANES	4
Would be odd if it were anything else with a name like QUAD SPI.
Maybe this is obvious enough to just use the value 4 inline?
Particularly as you have a comment where it is used anyway.


> +static int ad3552r_axi_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	struct ad3552r_axi_state *st = iio_priv(indio_dev);
> +	int ch = chan->channel;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		int sclk;
> +
> +		ret = iio_backend_read_raw(st->back, chan, &sclk, 0,
> +					   IIO_CHAN_INFO_FREQUENCY);
> +		if (ret != IIO_VAL_INT)
> +			return -EINVAL;
> +
> +		/* Using 4 lanes (QSPI) */
> +		*val = DIV_ROUND_CLOSEST(sclk * AD3552R_QSPI_LANES *
> +					 (1 + st->ddr_mode),
> +					 chan->scan_type.storagebits);
> +
> +		return IIO_VAL_INT;
> +	}
> +	case IIO_CHAN_INFO_RAW:
> +		ret = st->data->bus_reg_read(st->back,
> +					     AD3552R_REG_ADDR_CH_DAC_16B(ch),

As below, I'd put chan->channel inline here and drop the local variable.

> +					     val, 2);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad3552r_axi_write_raw(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan,
> +				 int val, int val2, long mask)
> +{
> +	struct ad3552r_axi_state *st = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +			int ch = chan->channel;

Just put chan->channel inline.  Not worth the local variable to save
going slightly over 80 chars.  This is one where I think readability
is slightly hurt by keeping to 80.

> +
> +			return st->data->bus_reg_write(st->back,
> +				    AD3552R_REG_ADDR_CH_DAC_16B(ch), val, 2);
> +		}
> +		unreachable();
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad3552r_axi_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad3552r_axi_state *st = iio_priv(indio_dev);
> +	struct iio_backend_data_fmt fmt = {
> +		.type = IIO_BACKEND_DATA_UNSIGNED
> +	};
> +	int loop_len, val, err;
> +
> +	/* Inform DAC chip to switch into DDR mode */
> +	err = ad3552r_qspi_update_reg_bits(st,
> +					   AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> +					   AD3552R_MASK_SPI_CONFIG_DDR,
> +					   AD3552R_MASK_SPI_CONFIG_DDR, 1);
> +	if (err)
> +		return err;
> +
> +	/* Inform DAC IP to go for DDR mode from now on */
> +	err = iio_backend_ddr_enable(st->back);
> +	if (err) {
> +		dev_warn(st->dev, "could not set DDR mode, not streaming");
> +		goto exit_err;
> +	}
> +
> +	st->ddr_mode = true;
> +
> +	switch (*indio_dev->active_scan_mask) {
> +	case AD3552R_CH0_ACTIVE:
> +		st->single_channel = true;
> +		loop_len = AD3552R_STREAM_2BYTE_LOOP;

As below, = 2 is probably clearer.


> +		val = AD3552R_REG_ADDR_CH_DAC_16B(0);
> +		break;
> +	case AD3552R_CH1_ACTIVE:
> +		st->single_channel = true;
> +		loop_len = AD3552R_STREAM_2BYTE_LOOP;
> +		val = AD3552R_REG_ADDR_CH_DAC_16B(1);
> +		break;
> +	case AD3552R_CH0_CH1_ACTIVE:
> +		st->single_channel = false;
> +		loop_len = AD3552R_STREAM_4BYTE_LOOP;
> +		val = AD3552R_REG_ADDR_CH_DAC_16B(1);
> +		break;
> +	default:
> +		err = -EINVAL;
> +		goto exit_err_ddr;
> +	}
> +
> +	err = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_STREAM_MODE,
> +				      loop_len, 1);
> +	if (err)
> +		goto exit_err_ddr;
> +
> +	err = iio_backend_data_transfer_addr(st->back, val);
> +	if (err)
> +		goto exit_err_ddr;
> +
> +	/*
> +	 * The EXT_SYNC is mandatory in the CN0585 project where 2 instances
> +	 * of the IP are in the design and they need to generate the signals
> +	 * synchronized.
> +	 *
> +	 * Note: in first IP implementations CONFIG EXT_SYNC (RO) can be 0,
> +	 * but EXT_SYNC (ext synch ability) is enabled anyway.
> +	 */
> +	if (st->synchronouos_mode)
> +		err = iio_backend_ext_sync_enable(st->back);
> +	else
> +		err = iio_backend_ext_sync_disable(st->back);
> +	if (err)
> +		goto exit_err_ddr;
> +
> +	err = iio_backend_data_format_set(st->back, 0, &fmt);
> +	if (err)
> +		goto exit_err_sync;
> +
> +	err = iio_backend_buffer_enable(st->back);
> +	if (err)
> +		goto exit_err_sync;
> +
> +	return 0;
> +
> +exit_err_sync:
> +	iio_backend_ext_sync_disable(st->back);
> +
> +exit_err_ddr:
> +	iio_backend_ddr_disable(st->back);
> +
> +exit_err:
> +	ad3552r_qspi_update_reg_bits(st,
> +				     AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> +				     AD3552R_MASK_SPI_CONFIG_DDR,
> +				     0, 1);
> +
> +	iio_backend_ddr_disable(st->back);
> +
> +	st->ddr_mode = false;
> +
> +	return err;
> +}


> +static int ad3552r_axi_setup(struct ad3552r_axi_state *st)
> +{
> +	struct fwnode_handle *child __free(fwnode_handle) = NULL;
Read the docs on how to use cleanup.h fun (should have merged this
cycle as they got stuck in review and everyone forgot about them :()

This should be inline where the constructor is not at the top of
the file.  That both helps readability and avoid unexpected reordering
of cleanup if multiple cleanup uses occur in one file.


> +	u8 gs_p, gs_n;
> +	s16 goffs;
> +	u16 id, rfb;
> +	u16 gain = 0, offset = 0;
> +	u32 val, range;
> +	int err;
> +
> +	err = ad3552r_axi_reset(st);
> +	if (err)
> +		return err;
> +
> +	err = iio_backend_ddr_disable(st->back);
> +	if (err)
> +		return err;
> +
> +	err = ad3552r_axi_scratch_pad_test(st);
> +	if (err)
> +		return err;
> +
> +	err = st->data->bus_reg_read(st->back, AD3552R_REG_ADDR_PRODUCT_ID_L,
> +				     &val, 1);
> +	if (err)
> +		return err;
> +
> +	id = val;
> +
> +	err = st->data->bus_reg_read(st->back, AD3552R_REG_ADDR_PRODUCT_ID_H,
> +				     &val, 1);
> +	if (err)
> +		return err;
> +
> +	id |= val << 8;
> +	if (id != st->model_data->chip_id)
> +		dev_info(st->dev, "Chip ID error. Expected 0x%x, Read 0x%x\n",
> +			 AD3552R_ID, id);
> +
> +	err = st->data->bus_reg_write(st->back,
> +				      AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
> +				      0, 1);
> +	if (err)
> +		return err;
> +
> +	err = st->data->bus_reg_write(st->back,
> +				      AD3552R_REG_ADDR_TRANSFER_REGISTER,
> +				      AD3552R_MASK_QUAD_SPI |
> +				      AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE, 1);
> +	if (err)
> +		return err;
> +
> +	err = iio_backend_data_source_set(st->back, 0, IIO_BACKEND_EXTERNAL);
> +	if (err)
> +		return err;
> +
> +	err = iio_backend_data_source_set(st->back, 1, IIO_BACKEND_EXTERNAL);
> +	if (err)
> +		return err;
> +
> +	err = ad3552r_get_ref_voltage(st->dev);
> +	if (err < 0)
> +		return err;
> +
> +	val = err;
> +
> +	err = ad3552r_qspi_update_reg_bits(st,
> +				AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
> +				AD3552R_MASK_REFERENCE_VOLTAGE_SEL,
> +				val, 1);
> +	if (err)
> +		return err;
> +
> +	err = ad3552r_get_drive_strength(st->dev, &val);
> +	if (!err) {
> +		err = ad3552r_qspi_update_reg_bits(st,
> +					AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> +					AD3552R_MASK_SDO_DRIVE_STRENGTH,
> +					val, 1);
> +		if (err)
> +			return err;
> +	}
> +
> +	st->synchronouos_mode =
> +			fwnode_property_read_bool(dev_fwnode(st->dev),

device_property_read_bool()?


If doing this sort of wrapping, indent the line by only one tab more
than the line above.  This combination gives about the worst
of all the readabilty options as still requires lots of wrapping.

> +						  "adi,synchronous-mode");
> +
> +	child = device_get_named_child_node(st->dev, "channel");
> +	if (!child)
> +		return -EINVAL;
> +
> +	/*
> +	 * One of "adi,output-range-microvolt" or "custom-output-range-config"
> +	 * must be available in fdt.
> +	 */
> +	err = ad3552r_get_output_range(st->dev, st->model_data->chip_id,
As per the normal spi driver, embed the range data in your model_data structure.
If that requires you to export the structure contain that info then do so.



> +				       child, &range);
> +	if (!err)
> +		return ad3552r_axi_set_output_range(st, range);
> +	if (err != -ENOENT)
> +		return err;
> +
> +	err = ad3552r_get_custom_gain(st->dev, child, &gs_p, &gs_n, &rfb,
> +				      &goffs);
> +	if (err)
> +		return err;
> +
> +	gain = ad3552r_calc_custom_gain(gs_p, gs_n, goffs);
> +	offset = abs((s32)goffs);
> +
> +	return ad3552r_axi_setup_custom_gain(st, gain, offset);
> +}


> +
> +static const struct ad3552r_axi_model_data ad3552r_model_data = {
> +	.model_name = "ad3552r",
> +	.chip_id = AD3552R_ID,
> +	.num_hw_channels = 2,
> +};

why not reuse the existing ax3552r_model_data?
If conveys more information than you have here but includes everything here.
That data is about the ADC, not how it is wired up, so should be consistent
independent of the interface.

> +MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/dac/ad3552r.h b/drivers/iio/dac/ad3552r.h
> index b1caa3c3e807..02805eec69a5 100644
> --- a/drivers/iio/dac/ad3552r.h
> +++ b/drivers/iio/dac/ad3552r.h
> @@ -38,6 +38,8 @@
>  #define AD3552R_REG_ADDR_TRANSFER_REGISTER		0x0F
>  #define   AD3552R_MASK_MULTI_IO_MODE			GENMASK(7, 6)
>  #define   AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE		BIT(2)
> +#define   AD3552R_MASK_DUAL_SPI				BIT(6)
> +#define   AD3552R_MASK_QUAD_SPI				BIT(7)
>  #define AD3552R_REG_ADDR_INTERFACE_CONFIG_C		0x10
>  #define   AD3552R_MASK_CRC_ENABLE			(GENMASK(7, 6) |\
>  							 GENMASK(1, 0))
> @@ -129,6 +131,13 @@
>  #define AD3552R_GAIN_SCALE				1000
>  #define AD3552R_LDAC_PULSE_US				100
>  
> +#define AD3552R_STREAM_2BYTE_LOOP			0x02
> +#define AD3552R_STREAM_4BYTE_LOOP			0x04

I think these two should just use the numbers given 2byte == 2 and
4byte == 4.  Defines seem to me to just add possible confusion!

Jonathan

