Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC001496CDD
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jan 2022 17:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbiAVQ0j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jan 2022 11:26:39 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52778 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbiAVQ0j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Jan 2022 11:26:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FE50B8091A
        for <linux-iio@vger.kernel.org>; Sat, 22 Jan 2022 16:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907E1C004E1;
        Sat, 22 Jan 2022 16:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642868796;
        bh=yt+dovMTsEG72bQpt7wbnIT+uWnYGHgJDAVEQGsQckg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nXx6Quyo+omVn8iNeCaH/CUNnUY8lis14A2B5xhJg0t5B9et0fJNQZl/uCCMrzx1S
         HYyojKiWk1V0sUUqMVP+hX+/HgKLE7E3htleEYIlHHObFvttYHjj4ltqSVQwzHslwp
         OH3zXXlkWfVMdaOkrB2AAwRORG4FwZr5xU4zrEXW2S6rZNEf5YYompcNwr94Et+XSA
         9A06nrJOCmU7jNzb1+5CC02DMsxFyTslqtHsbp+ri1qkaaJeiWJeIEy0z22D/AHBLn
         s6AZgpAdwZBiD4mypgy9WfwC2FXY+xhbRAtP1DeUr8Kf1ThymrYeSoOfj2LTHFyp25
         kL0fUBFb8yTbA==
Date:   Sat, 22 Jan 2022 16:32:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v2 3/3] iio: adis: stylistic changes
Message-ID: <20220122163246.6feeb233@jic23-huawei>
In-Reply-To: <20220122130905.99-3-nuno.sa@analog.com>
References: <20220122130905.99-1-nuno.sa@analog.com>
        <20220122130905.99-3-nuno.sa@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 22 Jan 2022 14:09:05 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> Minor stylistic changes to address checkptach complains when called with
> '--strict'.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
All look good to me.

Series applied to the togreg branch of iio.git and pushed out as testing for
0-day to poke at it and see if it can find anything we missed.

Thanks,

Jonathan
> ---
> changes in v2:
>  * none.
>=20
>  drivers/iio/imu/adis.c         | 47 +++++++++++++++++----------------
>  drivers/iio/imu/adis_buffer.c  |  6 ++---
>  drivers/iio/imu/adis_trigger.c |  3 +--
>  include/linux/iio/imu/adis.h   | 48 ++++++++++++++++++----------------
>  4 files changed, 54 insertions(+), 50 deletions(-)
>=20
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index cb0d66bf6561..638957001653 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -30,8 +30,8 @@
>   * @value: The value to write to device (up to 4 bytes)
>   * @size: The size of the @value (in bytes)
>   */
> -int __adis_write_reg(struct adis *adis, unsigned int reg,
> -	unsigned int value, unsigned int size)
> +int __adis_write_reg(struct adis *adis, unsigned int reg, unsigned int v=
alue,
> +		     unsigned int size)
>  {
>  	unsigned int page =3D reg / ADIS_PAGE_SIZE;
>  	int ret, i;
> @@ -114,7 +114,7 @@ int __adis_write_reg(struct adis *adis, unsigned int =
reg,
>  	ret =3D spi_sync(adis->spi, &msg);
>  	if (ret) {
>  		dev_err(&adis->spi->dev, "Failed to write register 0x%02X: %d\n",
> -				reg, ret);
> +			reg, ret);
>  	} else {
>  		adis->current_page =3D page;
>  	}
> @@ -130,8 +130,8 @@ EXPORT_SYMBOL_GPL(__adis_write_reg);
>   * @val: The value read back from the device
>   * @size: The size of the @val buffer
>   */
> -int __adis_read_reg(struct adis *adis, unsigned int reg,
> -	unsigned int *val, unsigned int size)
> +int __adis_read_reg(struct adis *adis, unsigned int reg, unsigned int *v=
al,
> +		    unsigned int size)
>  {
>  	unsigned int page =3D reg / ADIS_PAGE_SIZE;
>  	struct spi_message msg;
> @@ -201,12 +201,12 @@ int __adis_read_reg(struct adis *adis, unsigned int=
 reg,
>  	ret =3D spi_sync(adis->spi, &msg);
>  	if (ret) {
>  		dev_err(&adis->spi->dev, "Failed to read register 0x%02X: %d\n",
> -				reg, ret);
> +			reg, ret);
>  		return ret;
> -	} else {
> -		adis->current_page =3D page;
>  	}
> =20
> +	adis->current_page =3D page;
> +
>  	switch (size) {
>  	case 4:
>  		*val =3D get_unaligned_be32(adis->rx);
> @@ -247,13 +247,13 @@ EXPORT_SYMBOL_GPL(__adis_update_bits_base);
> =20
>  #ifdef CONFIG_DEBUG_FS
> =20
> -int adis_debugfs_reg_access(struct iio_dev *indio_dev,
> -	unsigned int reg, unsigned int writeval, unsigned int *readval)
> +int adis_debugfs_reg_access(struct iio_dev *indio_dev, unsigned int reg,
> +			    unsigned int writeval, unsigned int *readval)
>  {
>  	struct adis *adis =3D iio_device_get_drvdata(indio_dev);
> =20
>  	if (readval) {
> -		uint16_t val16;
> +		u16 val16;
>  		int ret;
> =20
>  		ret =3D adis_read_reg_16(adis, reg, &val16);
> @@ -261,9 +261,9 @@ int adis_debugfs_reg_access(struct iio_dev *indio_dev,
>  			*readval =3D val16;
> =20
>  		return ret;
> -	} else {
> -		return adis_write_reg_16(adis, reg, writeval);
>  	}
> +
> +	return adis_write_reg_16(adis, reg, writeval);
>  }
>  EXPORT_SYMBOL(adis_debugfs_reg_access);
> =20
> @@ -279,14 +279,16 @@ EXPORT_SYMBOL(adis_debugfs_reg_access);
>  int adis_enable_irq(struct adis *adis, bool enable)
>  {
>  	int ret =3D 0;
> -	uint16_t msc;
> +	u16 msc;
> =20
>  	mutex_lock(&adis->state_lock);
> =20
>  	if (adis->data->enable_irq) {
>  		ret =3D adis->data->enable_irq(adis, enable);
>  		goto out_unlock;
> -	} else if (adis->data->unmasked_drdy) {
> +	}
> +
> +	if (adis->data->unmasked_drdy) {
>  		if (enable)
>  			enable_irq(adis->spi->irq);
>  		else
> @@ -322,7 +324,7 @@ EXPORT_SYMBOL(adis_enable_irq);
>   */
>  int __adis_check_status(struct adis *adis)
>  {
> -	uint16_t status;
> +	u16 status;
>  	int ret;
>  	int i;
> =20
> @@ -358,7 +360,7 @@ int __adis_reset(struct adis *adis)
>  	const struct adis_timeout *timeouts =3D adis->data->timeouts;
> =20
>  	ret =3D __adis_write_reg_8(adis, adis->data->glob_cmd_reg,
> -			ADIS_GLOB_CMD_SW_RESET);
> +				 ADIS_GLOB_CMD_SW_RESET);
>  	if (ret) {
>  		dev_err(&adis->spi->dev, "Failed to reset device: %d\n", ret);
>  		return ret;
> @@ -414,7 +416,7 @@ int __adis_initial_startup(struct adis *adis)
>  {
>  	const struct adis_timeout *timeouts =3D adis->data->timeouts;
>  	struct gpio_desc *gpio;
> -	uint16_t prod_id;
> +	u16 prod_id;
>  	int ret;
> =20
>  	/* check if the device has rst pin low */
> @@ -423,7 +425,7 @@ int __adis_initial_startup(struct adis *adis)
>  		return PTR_ERR(gpio);
> =20
>  	if (gpio) {
> -		msleep(10);
> +		usleep_range(10, 12);
>  		/* bring device out of reset */
>  		gpiod_set_value_cansleep(gpio, 0);
>  		msleep(timeouts->reset_ms);
> @@ -477,7 +479,8 @@ EXPORT_SYMBOL_GPL(__adis_initial_startup);
>   * a error bit in the channels raw value set error_mask to 0.
>   */
>  int adis_single_conversion(struct iio_dev *indio_dev,
> -	const struct iio_chan_spec *chan, unsigned int error_mask, int *val)
> +			   const struct iio_chan_spec *chan,
> +			   unsigned int error_mask, int *val)
>  {
>  	struct adis *adis =3D iio_device_get_drvdata(indio_dev);
>  	unsigned int uval;
> @@ -486,7 +489,7 @@ int adis_single_conversion(struct iio_dev *indio_dev,
>  	mutex_lock(&adis->state_lock);
> =20
>  	ret =3D __adis_read_reg(adis, chan->address, &uval,
> -			chan->scan_type.storagebits / 8);
> +			      chan->scan_type.storagebits / 8);
>  	if (ret)
>  		goto err_unlock;
> =20
> @@ -521,7 +524,7 @@ EXPORT_SYMBOL_GPL(adis_single_conversion);
>   * called.
>   */
>  int adis_init(struct adis *adis, struct iio_dev *indio_dev,
> -	struct spi_device *spi, const struct adis_data *data)
> +	      struct spi_device *spi, const struct adis_data *data)
>  {
>  	if (!data || !data->timeouts) {
>  		dev_err(&spi->dev, "No config data or timeouts not defined!\n");
> diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
> index 351c303c8a8c..d3527cf5ed37 100644
> --- a/drivers/iio/imu/adis_buffer.c
> +++ b/drivers/iio/imu/adis_buffer.c
> @@ -20,7 +20,7 @@
>  #include <linux/iio/imu/adis.h>
> =20
>  static int adis_update_scan_mode_burst(struct iio_dev *indio_dev,
> -	const unsigned long *scan_mask)
> +				       const unsigned long *scan_mask)
>  {
>  	struct adis *adis =3D iio_device_get_drvdata(indio_dev);
>  	unsigned int burst_length, burst_max_length;
> @@ -67,7 +67,7 @@ static int adis_update_scan_mode_burst(struct iio_dev *=
indio_dev,
>  }
> =20
>  int adis_update_scan_mode(struct iio_dev *indio_dev,
> -	const unsigned long *scan_mask)
> +			  const unsigned long *scan_mask)
>  {
>  	struct adis *adis =3D iio_device_get_drvdata(indio_dev);
>  	const struct iio_chan_spec *chan;
> @@ -158,7 +158,7 @@ static irqreturn_t adis_trigger_handler(int irq, void=
 *p)
>  	}
> =20
>  	iio_push_to_buffers_with_timestamp(indio_dev, adis->buffer,
> -		pf->timestamp);
> +					   pf->timestamp);
> =20
>  irq_done:
>  	iio_trigger_notify_done(indio_dev->trig);
> diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigge=
r.c
> index c461bd1e8e69..0e7fb00ba241 100644
> --- a/drivers/iio/imu/adis_trigger.c
> +++ b/drivers/iio/imu/adis_trigger.c
> @@ -15,8 +15,7 @@
>  #include <linux/iio/trigger.h>
>  #include <linux/iio/imu/adis.h>
> =20
> -static int adis_data_rdy_trigger_set_state(struct iio_trigger *trig,
> -						bool state)
> +static int adis_data_rdy_trigger_set_state(struct iio_trigger *trig, boo=
l state)
>  {
>  	struct adis *adis =3D iio_trigger_get_drvdata(trig);
> =20
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index 11754f97d8bb..515ca09764fe 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -32,6 +32,7 @@ struct adis_timeout {
>  	u16 sw_reset_ms;
>  	u16 self_test_ms;
>  };
> +
>  /**
>   * struct adis_data - ADIS chip variant specific data
>   * @read_delay: SPI delay for read operations in us
> @@ -45,7 +46,7 @@ struct adis_timeout {
>   * @self_test_mask: Bitmask of supported self-test operations
>   * @self_test_reg: Register address to request self test command
>   * @self_test_no_autoclear: True if device's self-test needs clear of ct=
rl reg
> - * @status_error_msgs: Array of error messgaes
> + * @status_error_msgs: Array of error messages
>   * @status_error_mask: Bitmask of errors supported by the device
>   * @timeouts: Chip specific delays
>   * @enable_irq: Hook for ADIS devices that have a special IRQ enable/dis=
able
> @@ -130,12 +131,12 @@ struct adis {
>  	unsigned long		irq_flag;
>  	void			*buffer;
> =20
> -	uint8_t			tx[10] ____cacheline_aligned;
> -	uint8_t			rx[4];
> +	u8			tx[10] ____cacheline_aligned;
> +	u8			rx[4];
>  };
> =20
>  int adis_init(struct adis *adis, struct iio_dev *indio_dev,
> -	struct spi_device *spi, const struct adis_data *data);
> +	      struct spi_device *spi, const struct adis_data *data);
>  int __adis_reset(struct adis *adis);
> =20
>  /**
> @@ -156,9 +157,9 @@ static inline int adis_reset(struct adis *adis)
>  }
> =20
>  int __adis_write_reg(struct adis *adis, unsigned int reg,
> -	unsigned int val, unsigned int size);
> +		     unsigned int val, unsigned int size);
>  int __adis_read_reg(struct adis *adis, unsigned int reg,
> -	unsigned int *val, unsigned int size);
> +		    unsigned int *val, unsigned int size);
> =20
>  /**
>   * __adis_write_reg_8() - Write single byte to a register (unlocked)
> @@ -167,7 +168,7 @@ int __adis_read_reg(struct adis *adis, unsigned int r=
eg,
>   * @value: The value to write
>   */
>  static inline int __adis_write_reg_8(struct adis *adis, unsigned int reg,
> -	uint8_t val)
> +				     u8 val)
>  {
>  	return __adis_write_reg(adis, reg, val, 1);
>  }
> @@ -179,7 +180,7 @@ static inline int __adis_write_reg_8(struct adis *adi=
s, unsigned int reg,
>   * @value: Value to be written
>   */
>  static inline int __adis_write_reg_16(struct adis *adis, unsigned int re=
g,
> -	uint16_t val)
> +				      u16 val)
>  {
>  	return __adis_write_reg(adis, reg, val, 2);
>  }
> @@ -191,7 +192,7 @@ static inline int __adis_write_reg_16(struct adis *ad=
is, unsigned int reg,
>   * @value: Value to be written
>   */
>  static inline int __adis_write_reg_32(struct adis *adis, unsigned int re=
g,
> -	uint32_t val)
> +				      u32 val)
>  {
>  	return __adis_write_reg(adis, reg, val, 4);
>  }
> @@ -203,7 +204,7 @@ static inline int __adis_write_reg_32(struct adis *ad=
is, unsigned int reg,
>   * @val: The value read back from the device
>   */
>  static inline int __adis_read_reg_16(struct adis *adis, unsigned int reg,
> -	uint16_t *val)
> +				     u16 *val)
>  {
>  	unsigned int tmp;
>  	int ret;
> @@ -222,7 +223,7 @@ static inline int __adis_read_reg_16(struct adis *adi=
s, unsigned int reg,
>   * @val: The value read back from the device
>   */
>  static inline int __adis_read_reg_32(struct adis *adis, unsigned int reg,
> -	uint32_t *val)
> +				     u32 *val)
>  {
>  	unsigned int tmp;
>  	int ret;
> @@ -242,7 +243,7 @@ static inline int __adis_read_reg_32(struct adis *adi=
s, unsigned int reg,
>   * @size: The size of the @value (in bytes)
>   */
>  static inline int adis_write_reg(struct adis *adis, unsigned int reg,
> -	unsigned int val, unsigned int size)
> +				 unsigned int val, unsigned int size)
>  {
>  	int ret;
> =20
> @@ -261,7 +262,7 @@ static inline int adis_write_reg(struct adis *adis, u=
nsigned int reg,
>   * @size: The size of the @val buffer
>   */
>  static int adis_read_reg(struct adis *adis, unsigned int reg,
> -	unsigned int *val, unsigned int size)
> +			 unsigned int *val, unsigned int size)
>  {
>  	int ret;
> =20
> @@ -279,7 +280,7 @@ static int adis_read_reg(struct adis *adis, unsigned =
int reg,
>   * @value: The value to write
>   */
>  static inline int adis_write_reg_8(struct adis *adis, unsigned int reg,
> -	uint8_t val)
> +				   u8 val)
>  {
>  	return adis_write_reg(adis, reg, val, 1);
>  }
> @@ -291,7 +292,7 @@ static inline int adis_write_reg_8(struct adis *adis,=
 unsigned int reg,
>   * @value: Value to be written
>   */
>  static inline int adis_write_reg_16(struct adis *adis, unsigned int reg,
> -	uint16_t val)
> +				    u16 val)
>  {
>  	return adis_write_reg(adis, reg, val, 2);
>  }
> @@ -303,7 +304,7 @@ static inline int adis_write_reg_16(struct adis *adis=
, unsigned int reg,
>   * @value: Value to be written
>   */
>  static inline int adis_write_reg_32(struct adis *adis, unsigned int reg,
> -	uint32_t val)
> +				    u32 val)
>  {
>  	return adis_write_reg(adis, reg, val, 4);
>  }
> @@ -315,7 +316,7 @@ static inline int adis_write_reg_32(struct adis *adis=
, unsigned int reg,
>   * @val: The value read back from the device
>   */
>  static inline int adis_read_reg_16(struct adis *adis, unsigned int reg,
> -	uint16_t *val)
> +				   u16 *val)
>  {
>  	unsigned int tmp;
>  	int ret;
> @@ -334,7 +335,7 @@ static inline int adis_read_reg_16(struct adis *adis,=
 unsigned int reg,
>   * @val: The value read back from the device
>   */
>  static inline int adis_read_reg_32(struct adis *adis, unsigned int reg,
> -	uint32_t *val)
> +				   u32 *val)
>  {
>  	unsigned int tmp;
>  	int ret;
> @@ -439,8 +440,8 @@ static inline void adis_dev_unlock(struct adis *adis)
>  }
> =20
>  int adis_single_conversion(struct iio_dev *indio_dev,
> -	const struct iio_chan_spec *chan, unsigned int error_mask,
> -	int *val);
> +			   const struct iio_chan_spec *chan,
> +			   unsigned int error_mask, int *val);
> =20
>  #define ADIS_VOLTAGE_CHAN(addr, si, chan, name, info_all, bits) { \
>  	.type =3D IIO_VOLTAGE, \
> @@ -489,7 +490,7 @@ int adis_single_conversion(struct iio_dev *indio_dev,
>  	.modified =3D 1, \
>  	.channel2 =3D IIO_MOD_ ## mod, \
>  	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) | \
> -		 info_sep, \
> +		 (info_sep), \
>  	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE), \
>  	.info_mask_shared_by_all =3D info_all, \
>  	.address =3D (addr), \
> @@ -523,7 +524,7 @@ devm_adis_setup_buffer_and_trigger(struct adis *adis,=
 struct iio_dev *indio_dev,
>  int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev=
);
> =20
>  int adis_update_scan_mode(struct iio_dev *indio_dev,
> -	const unsigned long *scan_mask);
> +			  const unsigned long *scan_mask);
> =20
>  #else /* CONFIG_IIO_BUFFER */
> =20
> @@ -547,7 +548,8 @@ static inline int devm_adis_probe_trigger(struct adis=
 *adis,
>  #ifdef CONFIG_DEBUG_FS
> =20
>  int adis_debugfs_reg_access(struct iio_dev *indio_dev,
> -	unsigned int reg, unsigned int writeval, unsigned int *readval);
> +			    unsigned int reg, unsigned int writeval,
> +			    unsigned int *readval);
> =20
>  #else
> =20

