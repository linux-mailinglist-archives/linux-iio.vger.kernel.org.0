Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D545820BD
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 17:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfHEPvM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 11:51:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728801AbfHEPvL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Aug 2019 11:51:11 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 073852086D;
        Mon,  5 Aug 2019 15:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565020269;
        bh=jXnudvm7tWMcjft4YiTz1/7BK4nyZFstuavEmzw62sI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J0zn8+E32Huun+p5yGSQs/XU2QXgXPBlBnHvCKq7VODmW086G0xNso9BvfOuSd7gV
         VCwzHaGFiGooFB5CXPNEbtRJWV6WjQOVgIiX7gLzMSviupUBtFaVjm3YtHiNA84bdX
         Q7Tc+j2tfAOrjGiGV7t9FuqhzXz/q48tzE54KPms=
Date:   Mon, 5 Aug 2019 16:51:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Denis Ciocca <denis.ciocca@st.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: remove get_irq_data_ready() function pointer and
 use IRQ number directly
Message-ID: <20190805165105.1e2f2094@archlinux>
In-Reply-To: <20190802175913.12653-1-denis.ciocca@st.com>
References: <20190802175913.12653-1-denis.ciocca@st.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2 Aug 2019 10:59:13 -0700
Denis Ciocca <denis.ciocca@st.com> wrote:

> Not even sure why it was there since the beginning. Just use IRQ
> number in the sensor_data struct.
> 
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>

One weird bit of history cleaned up :)

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to poke at it more than I do.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/st_accel_core.c             |  7 +++----
>  .../iio/common/st_sensors/st_sensors_i2c.c    |  9 +-------
>  .../iio/common/st_sensors/st_sensors_spi.c    |  9 +-------
>  .../common/st_sensors/st_sensors_trigger.c    | 21 +++++++++----------
>  drivers/iio/gyro/st_gyro_core.c               |  7 +++----
>  drivers/iio/magnetometer/st_magn_core.c       |  7 +++----
>  drivers/iio/pressure/st_pressure_core.c       |  7 +++----
>  include/linux/iio/common/st_sensors.h         |  5 ++---
>  8 files changed, 26 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 0b17004cb12e..2e37f8a6d8cf 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -1169,7 +1169,6 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
>  	struct st_sensor_data *adata = iio_priv(indio_dev);
>  	struct st_sensors_platform_data *pdata =
>  		(struct st_sensors_platform_data *)adata->dev->platform_data;
> -	int irq = adata->get_irq_data_ready(indio_dev);
>  	struct iio_chan_spec *channels;
>  	size_t channels_size;
>  	int err;
> @@ -1217,7 +1216,7 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
>  	if (err < 0)
>  		goto st_accel_power_off;
>  
> -	if (irq > 0) {
> +	if (adata->irq > 0) {
>  		err = st_sensors_allocate_trigger(indio_dev,
>  						 ST_ACCEL_TRIGGER_OPS);
>  		if (err < 0)
> @@ -1234,7 +1233,7 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
>  	return 0;
>  
>  st_accel_device_register_error:
> -	if (irq > 0)
> +	if (adata->irq > 0)
>  		st_sensors_deallocate_trigger(indio_dev);
>  st_accel_probe_trigger_error:
>  	st_accel_deallocate_ring(indio_dev);
> @@ -1252,7 +1251,7 @@ void st_accel_common_remove(struct iio_dev *indio_dev)
>  	st_sensors_power_disable(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> -	if (adata->get_irq_data_ready(indio_dev) > 0)
> +	if (adata->irq > 0)
>  		st_sensors_deallocate_trigger(indio_dev);
>  
>  	st_accel_deallocate_ring(indio_dev);
> diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
> index 9240625534df..aa89d54a7c59 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
> @@ -20,13 +20,6 @@
>  
>  #define ST_SENSORS_I2C_MULTIREAD	0x80
>  
> -static unsigned int st_sensors_i2c_get_irq(struct iio_dev *indio_dev)
> -{
> -	struct st_sensor_data *sdata = iio_priv(indio_dev);
> -
> -	return to_i2c_client(sdata->dev)->irq;
> -}
> -
>  static const struct regmap_config st_sensors_i2c_regmap_config = {
>  	.reg_bits = 8,
>  	.val_bits = 8,
> @@ -69,7 +62,7 @@ int st_sensors_i2c_configure(struct iio_dev *indio_dev,
>  	indio_dev->name = client->name;
>  
>  	sdata->dev = &client->dev;
> -	sdata->get_irq_data_ready = st_sensors_i2c_get_irq;
> +	sdata->irq = client->irq;
>  
>  	return 0;
>  }
> diff --git a/drivers/iio/common/st_sensors/st_sensors_spi.c b/drivers/iio/common/st_sensors/st_sensors_spi.c
> index 9c0661a283d0..2262f81b07c2 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_spi.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
> @@ -18,13 +18,6 @@
>  
>  #define ST_SENSORS_SPI_MULTIREAD	0xc0
>  
> -static unsigned int st_sensors_spi_get_irq(struct iio_dev *indio_dev)
> -{
> -	struct st_sensor_data *sdata = iio_priv(indio_dev);
> -
> -	return to_spi_device(sdata->dev)->irq;
> -}
> -
>  static const struct regmap_config st_sensors_spi_regmap_config = {
>  	.reg_bits = 8,
>  	.val_bits = 8,
> @@ -117,7 +110,7 @@ int st_sensors_spi_configure(struct iio_dev *indio_dev,
>  	indio_dev->name = spi->modalias;
>  
>  	sdata->dev = &spi->dev;
> -	sdata->get_irq_data_ready = st_sensors_spi_get_irq;
> +	sdata->irq = spi->irq;
>  
>  	return 0;
>  }
> diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> index bed7b8682b17..4a2efa00f7f2 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> @@ -121,9 +121,9 @@ static irqreturn_t st_sensors_irq_thread(int irq, void *p)
>  int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  				const struct iio_trigger_ops *trigger_ops)
>  {
> -	int err, irq;
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>  	unsigned long irq_trig;
> +	int err;
>  
>  	sdata->trig = iio_trigger_alloc("%s-trigger", indio_dev->name);
>  	if (sdata->trig == NULL) {
> @@ -135,8 +135,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  	sdata->trig->ops = trigger_ops;
>  	sdata->trig->dev.parent = sdata->dev;
>  
> -	irq = sdata->get_irq_data_ready(indio_dev);
> -	irq_trig = irqd_get_trigger_type(irq_get_irq_data(irq));
> +	irq_trig = irqd_get_trigger_type(irq_get_irq_data(sdata->irq));
>  	/*
>  	 * If the IRQ is triggered on falling edge, we need to mark the
>  	 * interrupt as active low, if the hardware supports this.
> @@ -206,12 +205,12 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  	    sdata->sensor_settings->drdy_irq.stat_drdy.addr)
>  		irq_trig |= IRQF_SHARED;
>  
> -	err = request_threaded_irq(sdata->get_irq_data_ready(indio_dev),
> -			st_sensors_irq_handler,
> -			st_sensors_irq_thread,
> -			irq_trig,
> -			sdata->trig->name,
> -			sdata->trig);
> +	err = request_threaded_irq(sdata->irq,
> +				   st_sensors_irq_handler,
> +				   st_sensors_irq_thread,
> +				   irq_trig,
> +				   sdata->trig->name,
> +				   sdata->trig);
>  	if (err) {
>  		dev_err(&indio_dev->dev, "failed to request trigger IRQ.\n");
>  		goto iio_trigger_free;
> @@ -227,7 +226,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  	return 0;
>  
>  iio_trigger_register_error:
> -	free_irq(sdata->get_irq_data_ready(indio_dev), sdata->trig);
> +	free_irq(sdata->irq, sdata->trig);
>  iio_trigger_free:
>  	iio_trigger_free(sdata->trig);
>  	return err;
> @@ -239,7 +238,7 @@ void st_sensors_deallocate_trigger(struct iio_dev *indio_dev)
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>  
>  	iio_trigger_unregister(sdata->trig);
> -	free_irq(sdata->get_irq_data_ready(indio_dev), sdata->trig);
> +	free_irq(sdata->irq, sdata->trig);
>  	iio_trigger_free(sdata->trig);
>  }
>  EXPORT_SYMBOL(st_sensors_deallocate_trigger);
> diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
> index 02e42c945181..c0acbb5d2ffb 100644
> --- a/drivers/iio/gyro/st_gyro_core.c
> +++ b/drivers/iio/gyro/st_gyro_core.c
> @@ -388,7 +388,6 @@ EXPORT_SYMBOL(st_gyro_get_settings);
>  int st_gyro_common_probe(struct iio_dev *indio_dev)
>  {
>  	struct st_sensor_data *gdata = iio_priv(indio_dev);
> -	int irq = gdata->get_irq_data_ready(indio_dev);
>  	int err;
>  
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> @@ -419,7 +418,7 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
>  	if (err < 0)
>  		goto st_gyro_power_off;
>  
> -	if (irq > 0) {
> +	if (gdata->irq > 0) {
>  		err = st_sensors_allocate_trigger(indio_dev,
>  						  ST_GYRO_TRIGGER_OPS);
>  		if (err < 0)
> @@ -436,7 +435,7 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
>  	return 0;
>  
>  st_gyro_device_register_error:
> -	if (irq > 0)
> +	if (gdata->irq > 0)
>  		st_sensors_deallocate_trigger(indio_dev);
>  st_gyro_probe_trigger_error:
>  	st_gyro_deallocate_ring(indio_dev);
> @@ -454,7 +453,7 @@ void st_gyro_common_remove(struct iio_dev *indio_dev)
>  	st_sensors_power_disable(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> -	if (gdata->get_irq_data_ready(indio_dev) > 0)
> +	if (gdata->irq > 0)
>  		st_sensors_deallocate_trigger(indio_dev);
>  
>  	st_gyro_deallocate_ring(indio_dev);
> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> index 804353a483c7..a3a268ee2896 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -490,7 +490,6 @@ EXPORT_SYMBOL(st_magn_get_settings);
>  int st_magn_common_probe(struct iio_dev *indio_dev)
>  {
>  	struct st_sensor_data *mdata = iio_priv(indio_dev);
> -	int irq = mdata->get_irq_data_ready(indio_dev);
>  	int err;
>  
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> @@ -520,7 +519,7 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
>  	if (err < 0)
>  		goto st_magn_power_off;
>  
> -	if (irq > 0) {
> +	if (mdata->irq > 0) {
>  		err = st_sensors_allocate_trigger(indio_dev,
>  						ST_MAGN_TRIGGER_OPS);
>  		if (err < 0)
> @@ -537,7 +536,7 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
>  	return 0;
>  
>  st_magn_device_register_error:
> -	if (irq > 0)
> +	if (mdata->irq > 0)
>  		st_sensors_deallocate_trigger(indio_dev);
>  st_magn_probe_trigger_error:
>  	st_magn_deallocate_ring(indio_dev);
> @@ -555,7 +554,7 @@ void st_magn_common_remove(struct iio_dev *indio_dev)
>  	st_sensors_power_disable(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> -	if (mdata->get_irq_data_ready(indio_dev) > 0)
> +	if (mdata->irq > 0)
>  		st_sensors_deallocate_trigger(indio_dev);
>  
>  	st_magn_deallocate_ring(indio_dev);
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index 9ef92a501286..ca6863b32a5f 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -686,7 +686,6 @@ int st_press_common_probe(struct iio_dev *indio_dev)
>  	struct st_sensor_data *press_data = iio_priv(indio_dev);
>  	struct st_sensors_platform_data *pdata =
>  		(struct st_sensors_platform_data *)press_data->dev->platform_data;
> -	int irq = press_data->get_irq_data_ready(indio_dev);
>  	int err;
>  
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> @@ -729,7 +728,7 @@ int st_press_common_probe(struct iio_dev *indio_dev)
>  	if (err < 0)
>  		goto st_press_power_off;
>  
> -	if (irq > 0) {
> +	if (press_data->irq > 0) {
>  		err = st_sensors_allocate_trigger(indio_dev,
>  						  ST_PRESS_TRIGGER_OPS);
>  		if (err < 0)
> @@ -746,7 +745,7 @@ int st_press_common_probe(struct iio_dev *indio_dev)
>  	return err;
>  
>  st_press_device_register_error:
> -	if (irq > 0)
> +	if (press_data->irq > 0)
>  		st_sensors_deallocate_trigger(indio_dev);
>  st_press_probe_trigger_error:
>  	st_press_deallocate_ring(indio_dev);
> @@ -764,7 +763,7 @@ void st_press_common_remove(struct iio_dev *indio_dev)
>  	st_sensors_power_disable(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> -	if (press_data->get_irq_data_ready(indio_dev) > 0)
> +	if (press_data->irq > 0)
>  		st_sensors_deallocate_trigger(indio_dev);
>  
>  	st_press_deallocate_ring(indio_dev);
> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
> index c66ebb236a15..db17726a6c8c 100644
> --- a/include/linux/iio/common/st_sensors.h
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -220,7 +220,7 @@ struct st_sensor_settings {
>   * num_data_channels: Number of data channels used in buffer.
>   * @drdy_int_pin: Redirect DRDY on pin 1 (1) or pin 2 (2).
>   * @int_pin_open_drain: Set the interrupt/DRDY to open drain.
> - * @get_irq_data_ready: Function to get the IRQ used for data ready signal.
> + * @irq: the IRQ number.
>   * @edge_irq: the IRQ triggers on edges and need special handling.
>   * @hw_irq_trigger: if we're using the hardware interrupt on the sensor.
>   * @hw_timestamp: Latest timestamp from the interrupt handler, when in use.
> @@ -244,8 +244,7 @@ struct st_sensor_data {
>  
>  	u8 drdy_int_pin;
>  	bool int_pin_open_drain;
> -
> -	unsigned int (*get_irq_data_ready) (struct iio_dev *indio_dev);
> +	int irq;
>  
>  	bool edge_irq;
>  	bool hw_irq_trigger;

