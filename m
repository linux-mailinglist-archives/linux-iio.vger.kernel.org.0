Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8E74F559
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 12:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbfFVKsD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 06:48:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfFVKsC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 06:48:02 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19E1B206BA;
        Sat, 22 Jun 2019 10:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561200478;
        bh=8mEpMBa+pV0sFQtsqnGLx8FXXCXFD6jylmjOa0jJGSo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DqNkXLfWA79A2rWJpEYTO5qYNhHct8Xd6H5DMGNB5Sx+f903zTaKuijI1/4Sa6xQi
         1/u4Lvi5SH3VvhB0bcwlMYXXgoRb80EGh5qSzu2ofhhA6oJTxv2QZGimJ9V1SZlm6x
         alI9ZfHk8XHvvuvCxYlBsmSU+M3EUZL5n6g91PD4=
Date:   Sat, 22 Jun 2019 11:47:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Denis Ciocca <denis.ciocca@st.com>
Cc:     <linux-iio@vger.kernel.org>, <lorenzo@kernel.org>
Subject: Re: [PATCH 6/7] iio: make st_sensors driver use regmap
Message-ID: <20190622114754.1ef64c64@archlinux>
In-Reply-To: <20190617234943.10669-7-denis.ciocca@st.com>
References: <20190617234943.10669-1-denis.ciocca@st.com>
        <20190617234943.10669-7-denis.ciocca@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 Jun 2019 16:49:42 -0700
Denis Ciocca <denis.ciocca@st.com> wrote:

> This patch remove the transfer functions of the driver and make use of
> regmap. Multi-read bit is checked during probe at first in order to
> configure the regmap and not copied anymore.
> The multi-read bit can be set also for a single read.
> 
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
A few things inline.

There is an existing oddity around when the spi modes are set
that I would suggest cleaning up in a precursor patch to this one.

Jonathan

> ---
>  drivers/iio/accel/st_accel_core.c             |   3 -
>  drivers/iio/accel/st_accel_i2c.c              |   7 +-
>  drivers/iio/accel/st_accel_spi.c              |   6 +-
>  .../iio/common/st_sensors/st_sensors_buffer.c |  10 +-
>  .../iio/common/st_sensors/st_sensors_core.c   |  47 +++-----
>  .../iio/common/st_sensors/st_sensors_i2c.c    |  65 +++++------
>  .../iio/common/st_sensors/st_sensors_spi.c    | 103 +++++-------------
>  .../common/st_sensors/st_sensors_trigger.c    |  10 +-
>  drivers/iio/gyro/st_gyro_core.c               |   3 -
>  drivers/iio/gyro/st_gyro_i2c.c                |   5 +-
>  drivers/iio/gyro/st_gyro_spi.c                |   6 +-
>  drivers/iio/magnetometer/st_magn_core.c       |   3 -
>  drivers/iio/magnetometer/st_magn_i2c.c        |   5 +-
>  drivers/iio/magnetometer/st_magn_spi.c        |   6 +-
>  drivers/iio/pressure/st_pressure_core.c       |   3 -
>  drivers/iio/pressure/st_pressure_i2c.c        |   5 +-
>  drivers/iio/pressure/st_pressure_spi.c        |   6 +-
>  include/linux/iio/common/st_sensors.h         |  37 +------
>  include/linux/iio/common/st_sensors_i2c.h     |   5 +-
>  include/linux/iio/common/st_sensors_spi.h     |   5 +-
>  20 files changed, 126 insertions(+), 214 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 5029b399efa8..5b8c1ef43ff8 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -13,7 +13,6 @@
>  #include <linux/acpi.h>
>  #include <linux/errno.h>
>  #include <linux/types.h>
> -#include <linux/mutex.h>
>  #include <linux/interrupt.h>
>  #include <linux/i2c.h>
>  #include <linux/gpio.h>
> @@ -1175,7 +1174,6 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
>  
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &accel_info;
> -	mutex_init(&adata->tb.buf_lock);
>  
>  	err = st_sensors_power_enable(indio_dev);
>  	if (err)
> @@ -1188,7 +1186,6 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
>  		goto st_accel_power_off;
>  
>  	adata->num_data_channels = ST_ACCEL_NUMBER_DATA_CHANNELS;
> -	adata->multiread_bit = adata->sensor_settings->multi_read_bit;
>  	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
>  
>  	channels_size = indio_dev->num_channels * sizeof(struct iio_chan_spec);
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index c3c8f2e73c2a..f2162f8cf2ac 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -150,8 +150,8 @@ MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
>  
>  static int st_accel_i2c_probe(struct i2c_client *client)
>  {
> -	struct iio_dev *indio_dev;
>  	struct st_sensor_data *adata;
> +	struct iio_dev *indio_dev;
>  	const char *match;
>  	int ret;
>  
> @@ -165,7 +165,10 @@ static int st_accel_i2c_probe(struct i2c_client *client)
>  	if (match)
>  		strlcpy(client->name, match, sizeof(client->name));
>  
> -	st_sensors_i2c_configure(indio_dev, client, adata);
> +	ret = st_sensors_i2c_configure(indio_dev, client,
> +				       st_accel_multiread_bit(client->name));
> +	if (ret < 0)
> +		return ret;
>  
>  	ret = st_accel_common_probe(indio_dev);
>  	if (ret < 0)
> diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
> index 474742e35d92..a121755d6d8c 100644
> --- a/drivers/iio/accel/st_accel_spi.c
> +++ b/drivers/iio/accel/st_accel_spi.c
> @@ -114,7 +114,11 @@ static int st_accel_spi_probe(struct spi_device *spi)
>  
>  	st_sensors_of_name_probe(&spi->dev, st_accel_of_match,
>  				 spi->modalias, sizeof(spi->modalias));
> -	st_sensors_spi_configure(indio_dev, spi, adata);
> +
> +	err = st_sensors_spi_configure(indio_dev, spi,
> +				       st_accel_multiread_bit(spi->modalias));
> +	if (err < 0)
> +		return err;
>  
>  	err = st_accel_common_probe(indio_dev);
>  	if (err < 0)
> diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> index 4a68669dc555..eee30130ae23 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> @@ -17,15 +17,16 @@
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/irqreturn.h>
> +#include <linux/regmap.h>
>  
>  #include <linux/iio/common/st_sensors.h>
>  
>  
>  static int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
>  {
> -	int i;
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>  	unsigned int num_data_channels = sdata->num_data_channels;
> +	int i;
>  
>  	for_each_set_bit(i, indio_dev->active_scan_mask, num_data_channels) {
>  		const struct iio_chan_spec *channel = &indio_dev->channels[i];
> @@ -36,11 +37,8 @@ static int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
>  			channel->scan_type.storagebits >> 3;
>  
>  		buf = PTR_ALIGN(buf, storage_bytes);
> -		if (sdata->tf->read_multiple_byte(&sdata->tb, sdata->dev,
> -						  channel->address,
> -						  bytes_to_read, buf,
> -						  sdata->multiread_bit) <
> -		    bytes_to_read)
> +		if (regmap_bulk_read(sdata->regmap, channel->address,
> +				     buf, bytes_to_read) < 0)
>  			return -EIO;
>  
>  		/* Advance the buffer pointer */
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index 243b2097c57e..3ddab3ca0a4b 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -15,6 +15,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/regmap.h>
>  #include <asm/unaligned.h>
>  #include <linux/iio/common/st_sensors.h>
>  
> @@ -28,19 +29,10 @@ static inline u32 st_sensors_get_unaligned_le24(const u8 *p)
>  int st_sensors_write_data_with_mask(struct iio_dev *indio_dev,
>  				    u8 reg_addr, u8 mask, u8 data)
>  {
> -	int err;
> -	u8 new_data;
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>  
> -	err = sdata->tf->read_byte(&sdata->tb, sdata->dev, reg_addr, &new_data);
> -	if (err < 0)
> -		goto st_sensors_write_data_with_mask_error;
> -
> -	new_data = ((new_data & (~mask)) | ((data << __ffs(mask)) & mask));
> -	err = sdata->tf->write_byte(&sdata->tb, sdata->dev, reg_addr, new_data);
> -
> -st_sensors_write_data_with_mask_error:
> -	return err;
> +	return regmap_update_bits(sdata->regmap,
> +				  reg_addr, mask, data << __ffs(mask));
>  }
>  
>  int st_sensors_debugfs_reg_access(struct iio_dev *indio_dev,
> @@ -48,19 +40,15 @@ int st_sensors_debugfs_reg_access(struct iio_dev *indio_dev,
>  				  unsigned *readval)
>  {
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
> -	u8 readdata;
>  	int err;
>  
>  	if (!readval)
> -		return sdata->tf->write_byte(&sdata->tb, sdata->dev,
> -					     (u8)reg, (u8)writeval);
> +		return regmap_write(sdata->regmap, reg, writeval);
>  
> -	err = sdata->tf->read_byte(&sdata->tb, sdata->dev, (u8)reg, &readdata);
> +	err = regmap_read(sdata->regmap, reg, readval);
>  	if (err < 0)
>  		return err;
>  
> -	*readval = (unsigned)readdata;
> -
>  	return 0;
>  }
>  EXPORT_SYMBOL(st_sensors_debugfs_reg_access);
> @@ -545,7 +533,7 @@ int st_sensors_set_fullscale_by_gain(struct iio_dev *indio_dev, int scale)
>  EXPORT_SYMBOL(st_sensors_set_fullscale_by_gain);
>  
>  static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
> -				struct iio_chan_spec const *ch, int *data)
> +				     struct iio_chan_spec const *ch, int *data)
>  {
>  	int err;
>  	u8 *outdata;
> @@ -558,9 +546,8 @@ static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
>  	if (!outdata)
>  		return -ENOMEM;
>  
> -	err = sdata->tf->read_multiple_byte(&sdata->tb, sdata->dev,
> -				ch->address, byte_for_channel,
> -				outdata, sdata->multiread_bit);
> +	err = regmap_bulk_read(sdata->regmap, ch->address,
> +			       outdata, byte_for_channel);
>  	if (err < 0)
>  		goto st_sensors_free_memory;
>  
> @@ -608,8 +595,9 @@ int st_sensors_read_info_raw(struct iio_dev *indio_dev,
>  }
>  EXPORT_SYMBOL(st_sensors_read_info_raw);
>  
> -static int st_sensors_init_interface_mode(struct iio_dev *indio_dev,
> -			const struct st_sensor_settings *sensor_settings)
> +static int
> +st_sensors_init_interface_mode(struct iio_dev *indio_dev,
> +			       const struct st_sensor_settings *sensor_settings)
>  {
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>  	struct device_node *np = sdata->dev->of_node;
> @@ -620,9 +608,9 @@ static int st_sensors_init_interface_mode(struct iio_dev *indio_dev,
>  	     (pdata && pdata->spi_3wire)) && sensor_settings->sim.addr) {
>  		int err;
>  
> -		err = sdata->tf->write_byte(&sdata->tb, sdata->dev,
> -					    sensor_settings->sim.addr,
> -					    sensor_settings->sim.value);
> +		err = regmap_bulk_write(sdata->regmap,

As mentioned below, I'm fairly sure bulk_read/write require dma safe buffers.
Though why are you using bulk_write for length 1?

Even more interesting this is spi specific. I would move it to before the
spi regmap stuff is setup at all then just do a normal spi_write.

> +					sensor_settings->sim.addr,
> +					&sensor_settings->sim.value, 1);
>  		if (err < 0) {
>  			dev_err(&indio_dev->dev,
>  				"failed to init interface mode\n");
> @@ -667,8 +655,7 @@ int st_sensors_check_device_support(struct iio_dev *indio_dev,
>  			const struct st_sensor_settings *sensor_settings)
>  {
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
> -	int i, err = 0;
> -	u8 wai;
> +	int i, wai, err = 0;
>  
>  	i = st_sensors_get_settings_index(indio_dev->name,
>  					  sensor_settings, num_sensors_list);
> @@ -683,8 +670,8 @@ int st_sensors_check_device_support(struct iio_dev *indio_dev,
>  		return err;
>  
>  	if (sensor_settings[i].wai_addr) {
> -		err = sdata->tf->read_byte(&sdata->tb, sdata->dev,
> -					   sensor_settings[i].wai_addr, &wai);
> +		err = regmap_read(sdata->regmap,
> +				  sensor_settings[i].wai_addr, &wai);
>  		if (err < 0) {
>  			dev_err(&indio_dev->dev,
>  				"failed to read Who-Am-I register.\n");
> diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
> index b1c9812407e7..c8e03a63b17b 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
> @@ -13,6 +13,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/of_device.h>
>  #include <linux/acpi.h>
> +#include <linux/regmap.h>
>  
>  #include <linux/iio/common/st_sensors_i2c.h>
>  
> @@ -26,55 +27,45 @@ static unsigned int st_sensors_i2c_get_irq(struct iio_dev *indio_dev)
>  	return to_i2c_client(sdata->dev)->irq;
>  }
>  
> -static int st_sensors_i2c_read_byte(struct st_sensor_transfer_buffer *tb,
> -				struct device *dev, u8 reg_addr, u8 *res_byte)
> -{
> -	int err;
> -
> -	err = i2c_smbus_read_byte_data(to_i2c_client(dev), reg_addr);
> -	if (err < 0)
> -		goto st_accel_i2c_read_byte_error;
> -
> -	*res_byte = err & 0xff;
> -
> -st_accel_i2c_read_byte_error:
> -	return err < 0 ? err : 0;
> -}
> -
> -static int st_sensors_i2c_read_multiple_byte(
> -		struct st_sensor_transfer_buffer *tb, struct device *dev,
> -			u8 reg_addr, int len, u8 *data, bool multiread_bit)
> -{
> -	if (multiread_bit)
> -		reg_addr |= ST_SENSORS_I2C_MULTIREAD;
> +static const struct regmap_config st_sensors_i2c_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};
>  
> -	return i2c_smbus_read_i2c_block_data_or_emulated(to_i2c_client(dev),
> -							 reg_addr, len, data);
> -}
> +static const struct regmap_config st_sensors_i2c_regmap_multiread_bit_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.read_flag_mask = ST_SENSORS_I2C_MULTIREAD,
> +};
>  
> -static int st_sensors_i2c_write_byte(struct st_sensor_transfer_buffer *tb,
> -				struct device *dev, u8 reg_addr, u8 data)
> +int st_sensors_i2c_configure(struct iio_dev *indio_dev,
> +			     struct i2c_client *client,
> +			     bool multiread_bit)
>  {
> -	return i2c_smbus_write_byte_data(to_i2c_client(dev), reg_addr, data);
> -}
> +	struct st_sensor_data *sdata = iio_priv(indio_dev);
> +	const struct regmap_config *config;
>  
> -static const struct st_sensor_transfer_function st_sensors_tf_i2c = {
> -	.read_byte = st_sensors_i2c_read_byte,
> -	.write_byte = st_sensors_i2c_write_byte,
> -	.read_multiple_byte = st_sensors_i2c_read_multiple_byte,
> -};
> +	if (multiread_bit)
> +		config = &st_sensors_i2c_regmap_multiread_bit_config;
> +	else
> +		config = &st_sensors_i2c_regmap_config;
> +
> +	sdata->regmap = devm_regmap_init_i2c(client, config);
> +	if (IS_ERR(sdata->regmap)) {
> +		dev_err(&client->dev, "Failed to register i2c regmap (%d)\n",
> +			(int)PTR_ERR(sdata->regmap));
> +		return PTR_ERR(sdata->regmap);
> +	}
>  
> -void st_sensors_i2c_configure(struct iio_dev *indio_dev,
> -		struct i2c_client *client, struct st_sensor_data *sdata)
> -{
>  	i2c_set_clientdata(client, indio_dev);
>  
>  	indio_dev->dev.parent = &client->dev;
>  	indio_dev->name = client->name;
>  
>  	sdata->dev = &client->dev;
> -	sdata->tf = &st_sensors_tf_i2c;
>  	sdata->get_irq_data_ready = st_sensors_i2c_get_irq;
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL(st_sensors_i2c_configure);
>  
> diff --git a/drivers/iio/common/st_sensors/st_sensors_spi.c b/drivers/iio/common/st_sensors/st_sensors_spi.c
> index 2213843f02cb..bf3627be4b8a 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_spi.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
> @@ -11,12 +11,12 @@
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/iio/iio.h>
> +#include <linux/regmap.h>
>  
>  #include <linux/iio/common/st_sensors_spi.h>
>  
>  
>  #define ST_SENSORS_SPI_MULTIREAD	0xc0
> -#define ST_SENSORS_SPI_READ		0x80
>  
>  static unsigned int st_sensors_spi_get_irq(struct iio_dev *indio_dev)
>  {
> @@ -25,94 +25,45 @@ static unsigned int st_sensors_spi_get_irq(struct iio_dev *indio_dev)
>  	return to_spi_device(sdata->dev)->irq;
>  }
>  
> -static int st_sensors_spi_read(struct st_sensor_transfer_buffer *tb,
> -	struct device *dev, u8 reg_addr, int len, u8 *data, bool multiread_bit)
> -{
> -	int err;
> -
> -	struct spi_transfer xfers[] = {
> -		{
> -			.tx_buf = tb->tx_buf,
> -			.bits_per_word = 8,
> -			.len = 1,
> -		},
> -		{
> -			.rx_buf = tb->rx_buf,
> -			.bits_per_word = 8,
> -			.len = len,
> -		}
> -	};
> -
> -	mutex_lock(&tb->buf_lock);
> -	if ((multiread_bit) && (len > 1))
> -		tb->tx_buf[0] = reg_addr | ST_SENSORS_SPI_MULTIREAD;
> -	else
> -		tb->tx_buf[0] = reg_addr | ST_SENSORS_SPI_READ;
> -
> -	err = spi_sync_transfer(to_spi_device(dev), xfers, ARRAY_SIZE(xfers));
> -	if (err)
> -		goto acc_spi_read_error;
> -
> -	memcpy(data, tb->rx_buf, len);
> -	mutex_unlock(&tb->buf_lock);
> -	return len;
> -
> -acc_spi_read_error:
> -	mutex_unlock(&tb->buf_lock);
> -	return err;
> -}
> -
> -static int st_sensors_spi_read_byte(struct st_sensor_transfer_buffer *tb,
> -				struct device *dev, u8 reg_addr, u8 *res_byte)
> -{
> -	return st_sensors_spi_read(tb, dev, reg_addr, 1, res_byte, false);
> -}
> +static const struct regmap_config st_sensors_spi_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};
>  
> -static int st_sensors_spi_read_multiple_byte(
> -	struct st_sensor_transfer_buffer *tb, struct device *dev,
> -			u8 reg_addr, int len, u8 *data, bool multiread_bit)
> -{
> -	return st_sensors_spi_read(tb, dev, reg_addr, len, data, multiread_bit);
> -}
> +static const struct regmap_config st_sensors_spi_regmap_multiread_bit_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.read_flag_mask = ST_SENSORS_SPI_MULTIREAD,
> +};
>  
> -static int st_sensors_spi_write_byte(struct st_sensor_transfer_buffer *tb,
> -				struct device *dev, u8 reg_addr, u8 data)
> +int st_sensors_spi_configure(struct iio_dev *indio_dev,
> +			     struct spi_device *spi,
> +			     bool multiread_bit)
>  {
> -	int err;
> -
> -	struct spi_transfer xfers = {
> -		.tx_buf = tb->tx_buf,
> -		.bits_per_word = 8,
> -		.len = 2,
> -	};
> -
> -	mutex_lock(&tb->buf_lock);
> -	tb->tx_buf[0] = reg_addr;
> -	tb->tx_buf[1] = data;
> -
> -	err = spi_sync_transfer(to_spi_device(dev), &xfers, 1);
> -	mutex_unlock(&tb->buf_lock);
> +	struct st_sensor_data *sdata = iio_priv(indio_dev);
> +	const struct regmap_config *config;
>  
> -	return err;
> -}
> +	if (multiread_bit)
> +		config = &st_sensors_spi_regmap_multiread_bit_config;
> +	else
> +		config = &st_sensors_spi_regmap_config;
>  
> -static const struct st_sensor_transfer_function st_sensors_tf_spi = {
> -	.read_byte = st_sensors_spi_read_byte,
> -	.write_byte = st_sensors_spi_write_byte,
> -	.read_multiple_byte = st_sensors_spi_read_multiple_byte,
> -};
> +	sdata->regmap = devm_regmap_init_spi(spi, config);
> +	if (IS_ERR(sdata->regmap)) {
> +		dev_err(&spi->dev, "Failed to register spi regmap (%d)\n",
> +			(int)PTR_ERR(sdata->regmap));
> +		return PTR_ERR(sdata->regmap);
> +	}
>  
> -void st_sensors_spi_configure(struct iio_dev *indio_dev,
> -			struct spi_device *spi, struct st_sensor_data *sdata)
> -{
>  	spi_set_drvdata(spi, indio_dev);
>  
>  	indio_dev->dev.parent = &spi->dev;
>  	indio_dev->name = spi->modalias;
>  
>  	sdata->dev = &spi->dev;
> -	sdata->tf = &st_sensors_tf_spi;
>  	sdata->get_irq_data_ready = st_sensors_spi_get_irq;
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL(st_sensors_spi_configure);
>  
> diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> index 630c8cb35e8b..bed7b8682b17 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> @@ -13,6 +13,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/trigger.h>
>  #include <linux/interrupt.h>
> +#include <linux/regmap.h>
>  #include <linux/iio/common/st_sensors.h>
>  #include "st_sensors_core.h"
>  
> @@ -26,8 +27,7 @@
>  static int st_sensors_new_samples_available(struct iio_dev *indio_dev,
>  					    struct st_sensor_data *sdata)
>  {
> -	u8 status;
> -	int ret;
> +	int ret, status;
>  
>  	/* How would I know if I can't check it? */
>  	if (!sdata->sensor_settings->drdy_irq.stat_drdy.addr)
> @@ -37,9 +37,9 @@ static int st_sensors_new_samples_available(struct iio_dev *indio_dev,
>  	if (!indio_dev->active_scan_mask)
>  		return 0;
>  
> -	ret = sdata->tf->read_byte(&sdata->tb, sdata->dev,
> -			sdata->sensor_settings->drdy_irq.stat_drdy.addr,
> -			&status);
> +	ret = regmap_read(sdata->regmap,
> +			  sdata->sensor_settings->drdy_irq.stat_drdy.addr,
> +			  &status);
>  	if (ret < 0) {
>  		dev_err(sdata->dev,
>  			"error checking samples available\n");
> diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
> index 84a014fdcad2..5223b3118221 100644
> --- a/drivers/iio/gyro/st_gyro_core.c
> +++ b/drivers/iio/gyro/st_gyro_core.c
> @@ -12,7 +12,6 @@
>  #include <linux/slab.h>
>  #include <linux/errno.h>
>  #include <linux/types.h>
> -#include <linux/mutex.h>
>  #include <linux/interrupt.h>
>  #include <linux/i2c.h>
>  #include <linux/gpio.h>
> @@ -392,7 +391,6 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
>  
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &gyro_info;
> -	mutex_init(&gdata->tb.buf_lock);
>  
>  	err = st_sensors_power_enable(indio_dev);
>  	if (err)
> @@ -405,7 +403,6 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
>  		goto st_gyro_power_off;
>  
>  	gdata->num_data_channels = ST_GYRO_NUMBER_DATA_CHANNELS;
> -	gdata->multiread_bit = gdata->sensor_settings->multi_read_bit;
>  	indio_dev->channels = gdata->sensor_settings->ch;
>  	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
>  
> diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
> index f2a8683db7d9..fa560f68e022 100644
> --- a/drivers/iio/gyro/st_gyro_i2c.c
> +++ b/drivers/iio/gyro/st_gyro_i2c.c
> @@ -77,7 +77,10 @@ static int st_gyro_i2c_probe(struct i2c_client *client,
>  	st_sensors_of_name_probe(&client->dev, st_gyro_of_match,
>  				 client->name, sizeof(client->name));
>  
> -	st_sensors_i2c_configure(indio_dev, client, gdata);
> +	err = st_sensors_i2c_configure(indio_dev, client,
> +				       st_gyro_multiread_bit(client->name));
> +	if (err < 0)
> +		return err;
>  
>  	err = st_gyro_common_probe(indio_dev);
>  	if (err < 0)
> diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
> index 93c48248bea6..9bb58d2d72ed 100644
> --- a/drivers/iio/gyro/st_gyro_spi.c
> +++ b/drivers/iio/gyro/st_gyro_spi.c
> @@ -81,7 +81,11 @@ static int st_gyro_spi_probe(struct spi_device *spi)
>  
>  	st_sensors_of_name_probe(&spi->dev, st_gyro_of_match,
>  				 spi->modalias, sizeof(spi->modalias));
> -	st_sensors_spi_configure(indio_dev, spi, gdata);
> +
> +	err = st_sensors_spi_configure(indio_dev, spi,
> +				       st_gyro_multiread_bit(spi->modalias));
> +	if (err < 0)
> +		return err;
>  
>  	err = st_gyro_common_probe(indio_dev);
>  	if (err < 0)
> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> index 2d8919eb5ada..4aa118e72ef6 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -12,7 +12,6 @@
>  #include <linux/slab.h>
>  #include <linux/errno.h>
>  #include <linux/types.h>
> -#include <linux/mutex.h>
>  #include <linux/interrupt.h>
>  #include <linux/i2c.h>
>  #include <linux/gpio.h>
> @@ -494,7 +493,6 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
>  
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &magn_info;
> -	mutex_init(&mdata->tb.buf_lock);
>  
>  	err = st_sensors_power_enable(indio_dev);
>  	if (err)
> @@ -507,7 +505,6 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
>  		goto st_magn_power_off;
>  
>  	mdata->num_data_channels = ST_MAGN_NUMBER_DATA_CHANNELS;
> -	mdata->multiread_bit = mdata->sensor_settings->multi_read_bit;
>  	indio_dev->channels = mdata->sensor_settings->ch;
>  	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
>  
> diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
> index 4d014fd1aeb0..52e9be5088be 100644
> --- a/drivers/iio/magnetometer/st_magn_i2c.c
> +++ b/drivers/iio/magnetometer/st_magn_i2c.c
> @@ -69,7 +69,10 @@ static int st_magn_i2c_probe(struct i2c_client *client,
>  	st_sensors_of_name_probe(&client->dev, st_magn_of_match,
>  				 client->name, sizeof(client->name));
>  
> -	st_sensors_i2c_configure(indio_dev, client, mdata);
> +	err = st_sensors_i2c_configure(indio_dev, client,
> +				       st_magn_multiread_bit(client->name));
> +	if (err < 0)
> +		return err;
>  
>  	err = st_magn_common_probe(indio_dev);
>  	if (err < 0)
> diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
> index 0d47070611b1..80c32a1720cd 100644
> --- a/drivers/iio/magnetometer/st_magn_spi.c
> +++ b/drivers/iio/magnetometer/st_magn_spi.c
> @@ -63,7 +63,11 @@ static int st_magn_spi_probe(struct spi_device *spi)
>  
>  	st_sensors_of_name_probe(&spi->dev, st_magn_of_match,
>  				 spi->modalias, sizeof(spi->modalias));
> -	st_sensors_spi_configure(indio_dev, spi, mdata);
> +
> +	err = st_sensors_spi_configure(indio_dev, spi,
> +				       st_magn_multiread_bit(spi->modalias));
> +	if (err < 0)
> +		return err;
>  
>  	err = st_magn_common_probe(indio_dev);
>  	if (err < 0)
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index fb3bfaa00e85..9160ccfbef59 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -12,7 +12,6 @@
>  #include <linux/slab.h>
>  #include <linux/errno.h>
>  #include <linux/types.h>
> -#include <linux/mutex.h>
>  #include <linux/interrupt.h>
>  #include <linux/i2c.h>
>  #include <linux/gpio.h>
> @@ -690,7 +689,6 @@ int st_press_common_probe(struct iio_dev *indio_dev)
>  
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &press_info;
> -	mutex_init(&press_data->tb.buf_lock);
>  
>  	err = st_sensors_power_enable(indio_dev);
>  	if (err)
> @@ -709,7 +707,6 @@ int st_press_common_probe(struct iio_dev *indio_dev)
>  	 * element.
>  	 */
>  	press_data->num_data_channels = press_data->sensor_settings->num_ch - 1;
> -	press_data->multiread_bit = press_data->sensor_settings->multi_read_bit;
>  	indio_dev->channels = press_data->sensor_settings->ch;
>  	indio_dev->num_channels = press_data->sensor_settings->num_ch;
>  
> diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
> index b7d9ba706abc..97468ca16dd5 100644
> --- a/drivers/iio/pressure/st_pressure_i2c.c
> +++ b/drivers/iio/pressure/st_pressure_i2c.c
> @@ -103,7 +103,10 @@ static int st_press_i2c_probe(struct i2c_client *client,
>  	} else if (!id)
>  		return -ENODEV;
>  
> -	st_sensors_i2c_configure(indio_dev, client, press_data);
> +	ret = st_sensors_i2c_configure(indio_dev, client,
> +				       st_press_multiread_bit(client->name));
> +	if (ret < 0)
> +		return ret;
>  
>  	ret = st_press_common_probe(indio_dev);
>  	if (ret < 0)
> diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
> index ef61401c41d3..ae2fbcb2169e 100644
> --- a/drivers/iio/pressure/st_pressure_spi.c
> +++ b/drivers/iio/pressure/st_pressure_spi.c
> @@ -73,7 +73,11 @@ static int st_press_spi_probe(struct spi_device *spi)
>  
>  	st_sensors_of_name_probe(&spi->dev, st_press_of_match,
>  				 spi->modalias, sizeof(spi->modalias));
> -	st_sensors_spi_configure(indio_dev, spi, press_data);
> +
> +	err = st_sensors_spi_configure(indio_dev, spi,
> +				       st_press_multiread_bit(spi->modalias));
> +	if (err < 0)
> +		return err;
>  
>  	err = st_press_common_probe(indio_dev);
>  	if (err < 0)
> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
> index 17fbf3e9b013..edd7a538f58c 100644
> --- a/include/linux/iio/common/st_sensors.h
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -16,6 +16,7 @@
>  #include <linux/iio/trigger.h>
>  #include <linux/bitops.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/regmap.h>
>  
>  #include <linux/platform_data/st_sensors_pdata.h>
>  
> @@ -169,36 +170,6 @@ struct st_sensor_data_ready_irq {
>  	} ig1;
>  };
>  
> -/**
> - * struct st_sensor_transfer_buffer - ST sensor device I/O buffer
> - * @buf_lock: Mutex to protect rx and tx buffers.
> - * @tx_buf: Buffer used by SPI transfer function to send data to the sensors.
> - *	This buffer is used to avoid DMA not-aligned issue.
> - * @rx_buf: Buffer used by SPI transfer to receive data from sensors.
> - *	This buffer is used to avoid DMA not-aligned issue.
> - */
> -struct st_sensor_transfer_buffer {
> -	struct mutex buf_lock;
> -	u8 rx_buf[ST_SENSORS_RX_MAX_LENGTH];
> -	u8 tx_buf[ST_SENSORS_TX_MAX_LENGTH] ____cacheline_aligned;

I'm slightly interested to see this go.  Note that the bulk reads
in regmap still need dma aligned buffers I believe.
Looking above it seems like there may be one problem case.

> -};
> -
> -/**
> - * struct st_sensor_transfer_function - ST sensor device I/O function
> - * @read_byte: Function used to read one byte.
> - * @write_byte: Function used to write one byte.
> - * @read_multiple_byte: Function used to read multiple byte.
> - */
> -struct st_sensor_transfer_function {
> -	int (*read_byte) (struct st_sensor_transfer_buffer *tb,
> -				struct device *dev, u8 reg_addr, u8 *res_byte);
> -	int (*write_byte) (struct st_sensor_transfer_buffer *tb,
> -				struct device *dev, u8 reg_addr, u8 data);
> -	int (*read_multiple_byte) (struct st_sensor_transfer_buffer *tb,
> -		struct device *dev, u8 reg_addr, int len, u8 *data,
> -							bool multiread_bit);
> -};
> -
>  /**
>   * struct st_sensor_settings - ST specific sensor settings
>   * @wai: Contents of WhoAmI register.
> @@ -243,7 +214,6 @@ struct st_sensor_settings {
>   * @vdd: Pointer to sensor's Vdd power supply
>   * @vdd_io: Pointer to sensor's Vdd-IO power supply
>   * @enabled: Status of the sensor (false->off, true->on).
> - * @multiread_bit: Use or not particular bit for [I2C/SPI] multiread.
>   * @buffer_data: Data used by buffer part.
>   * @odr: Output data rate of the sensor [Hz].
>   * num_data_channels: Number of data channels used in buffer.
> @@ -264,9 +234,9 @@ struct st_sensor_data {
>  	struct st_sensor_fullscale_avl *current_fullscale;
>  	struct regulator *vdd;
>  	struct regulator *vdd_io;
> +	struct regmap *regmap;

I'm guessing this should be in the docs?

>  
>  	bool enabled;
> -	bool multiread_bit;
>  
>  	char *buffer_data;
>  
> @@ -278,9 +248,6 @@ struct st_sensor_data {
>  
>  	unsigned int (*get_irq_data_ready) (struct iio_dev *indio_dev);
>  
> -	const struct st_sensor_transfer_function *tf;
> -	struct st_sensor_transfer_buffer tb;
> -

And these have docs entries that should go.

>  	bool edge_irq;
>  	bool hw_irq_trigger;
>  	s64 hw_timestamp;
> diff --git a/include/linux/iio/common/st_sensors_i2c.h b/include/linux/iio/common/st_sensors_i2c.h
> index 5ada89944698..4d8f44d32ce9 100644
> --- a/include/linux/iio/common/st_sensors_i2c.h
> +++ b/include/linux/iio/common/st_sensors_i2c.h
> @@ -14,8 +14,9 @@
>  #include <linux/iio/common/st_sensors.h>
>  #include <linux/of.h>
>  
> -void st_sensors_i2c_configure(struct iio_dev *indio_dev,
> -		struct i2c_client *client, struct st_sensor_data *sdata);
> +int st_sensors_i2c_configure(struct iio_dev *indio_dev,
> +			     struct i2c_client *client,
> +			     bool multiread_bit);
>  
>  #ifdef CONFIG_ACPI
>  int st_sensors_match_acpi_device(struct device *dev);
> diff --git a/include/linux/iio/common/st_sensors_spi.h b/include/linux/iio/common/st_sensors_spi.h
> index 6020f7167859..77c5f4d18cc6 100644
> --- a/include/linux/iio/common/st_sensors_spi.h
> +++ b/include/linux/iio/common/st_sensors_spi.h
> @@ -13,7 +13,8 @@
>  #include <linux/spi/spi.h>
>  #include <linux/iio/common/st_sensors.h>
>  
> -void st_sensors_spi_configure(struct iio_dev *indio_dev,
> -			struct spi_device *spi, struct st_sensor_data *sdata);
> +int st_sensors_spi_configure(struct iio_dev *indio_dev,
> +			     struct spi_device *spi,
> +			     bool multiread_bit);
>  
>  #endif /* ST_SENSORS_SPI_H */

