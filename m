Return-Path: <linux-iio+bounces-25234-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBD8BED408
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 18:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5783319A6898
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 16:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036A6248166;
	Sat, 18 Oct 2025 16:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8fhWr2m"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92A323BD06;
	Sat, 18 Oct 2025 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760806075; cv=none; b=L4GWE2+fPN5dymwP+v3ci1IAaNGN2MyLtnYSKYaosBNyOjiF7nzm1ER/cx1FqcyCk1EkNxmMItQDO/2UVNv7/0BHZKAA40LITHs6CkdhDiAYE2wjVqS/Cm85ZEVG1kvpzDFnb9OgAfgHTjNdLLuWG/lfyjQrerZ7jtbvzrVqcrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760806075; c=relaxed/simple;
	bh=/OfKplk/YJMdO1k7++AFVXGanGrA383wjf6lPLlTvV0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DOE+4sR8uAEMUEqesGZEmfjngVPrAed3rysuq62vvAnF9EFMNrcXSlVRI1etqCEykF/NkGGIlEIs86MB4p4TOpsOtR7TxaleaJkZanT7EU/YcI7X9poFWLeu5Rm1cyHVZVtpD7OP7TFdSzHKT4wE4X0m2SAR+gZcLuXrd66cCW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8fhWr2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D008C4CEF8;
	Sat, 18 Oct 2025 16:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760806075;
	bh=/OfKplk/YJMdO1k7++AFVXGanGrA383wjf6lPLlTvV0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T8fhWr2mwWc9N7W2L+iwIhU/rRaz4SBMY6214Er8WUtLMsGqtIlVhIcNv84i0TQhJ
	 sIk9oSk2s4Lz8mg8TPdq0AoyJz11y2prkgLSclTCHgObLauBuV4A8ZzFk9mmhebkKI
	 NS65PmjdRQak+pgm5ubyD/fX6qXjDlVn2YccDWvq5IHdUSc50z3LJF816ivBzBo091
	 aVgJGj/hGIwBnlcCoCMEeLADdMp66hbtnizl0rSJNme53igCLSKU/hZiG/d1vVHA4Q
	 nEX496HpWaDU7TpYqqmvvsQ3w5Xm8Hbr9Sr5sXy0rZVpsnxZ1y5uoqY9pk02zNz0SQ
	 fYGiHTkctho4Q==
Date: Sat, 18 Oct 2025 17:47:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: dlechner@baylibre.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 marcelo.schmitt1@gmail.com, vassilisamir@gmail.com, salah.triki@gmail.com,
 skhan@linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 akhileshpatilvnit@gmail.com
Subject: Re: [PATCH v2 2/2] iio: pressure: adp810: Add driver for adp810
 sensor
Message-ID: <20251018174746.4a76af1d@jic23-huawei>
In-Reply-To: <0b72866f4e5ac28c78f6d683a1ca659a4239b68e.1760374257.git.akhilesh@ee.iitb.ac.in>
References: <cover.1760374257.git.akhilesh@ee.iitb.ac.in>
	<0b72866f4e5ac28c78f6d683a1ca659a4239b68e.1760374257.git.akhilesh@ee.iitb.ac.in>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Oct 2025 22:32:35 +0530
Akhilesh Patil <akhilesh@ee.iitb.ac.in> wrote:

> Add driver for Aosong adp810 differential pressure and temperature sensor.
> This sensor provides an I2C interface for reading data.
> Calculate CRC of the data received using standard crc8 library to verify
> data integrity.
> 
> Tested on TI am62x sk board with sensor connected at i2c-2.
> 
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>

A few comments inline and it seems your rebase when wrong and you've
picked up unrelated build file changes.

Thanks

Jonathan

> diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
> index 6482288e07ee..a21443e992b9 100644
> --- a/drivers/iio/pressure/Makefile
> +++ b/drivers/iio/pressure/Makefile
> @@ -5,6 +5,7 @@
>  
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_ABP060MG) += abp060mg.o
> +obj-$(CONFIG_ADP810) += adp810.o
>  obj-$(CONFIG_ROHM_BM1390) += rohm-bm1390.o
>  obj-$(CONFIG_BMP280) += bmp280.o
>  bmp280-objs := bmp280-core.o bmp280-regmap.o
> @@ -15,6 +16,7 @@ obj-$(CONFIG_DPS310) += dps310.o
>  obj-$(CONFIG_IIO_CROS_EC_BARO) += cros_ec_baro.o
>  obj-$(CONFIG_HID_SENSOR_PRESS)   += hid-sensor-press.o
>  obj-$(CONFIG_HP03) += hp03.o
> +obj-$(CONFIG_HP206C) += hp206c.o
>  obj-$(CONFIG_HSC030PA) += hsc030pa.o
>  obj-$(CONFIG_HSC030PA_I2C) += hsc030pa_i2c.o
>  obj-$(CONFIG_HSC030PA_SPI) += hsc030pa_spi.o
> @@ -34,11 +36,9 @@ obj-$(CONFIG_SDP500) += sdp500.o
>  obj-$(CONFIG_IIO_ST_PRESS) += st_pressure.o
>  st_pressure-y := st_pressure_core.o
>  st_pressure-$(CONFIG_IIO_BUFFER) += st_pressure_buffer.o
> +obj-$(CONFIG_IIO_ST_PRESS_I2C) += st_pressure_i2c.o
> +obj-$(CONFIG_IIO_ST_PRESS_SPI) += st_pressure_spi.o
>  obj-$(CONFIG_T5403) += t5403.o
> -obj-$(CONFIG_HP206C) += hp206c.o

Rebase gone wrong I assume.  

>  obj-$(CONFIG_ZPA2326) += zpa2326.o
>  obj-$(CONFIG_ZPA2326_I2C) += zpa2326_i2c.o
>  obj-$(CONFIG_ZPA2326_SPI) += zpa2326_spi.o
> -
> -obj-$(CONFIG_IIO_ST_PRESS_I2C) += st_pressure_i2c.o
> -obj-$(CONFIG_IIO_ST_PRESS_SPI) += st_pressure_spi.o
> diff --git a/drivers/iio/pressure/adp810.c b/drivers/iio/pressure/adp810.c
> new file mode 100644
> index 000000000000..c2f3b5f7a1f9
> --- /dev/null
> +++ b/drivers/iio/pressure/adp810.c
> @@ -0,0 +1,212 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2025 Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> + *
> + * Driver for adp810 pressure and temperature sensor
> + * Datasheet:
> + *   https://aosong.com/userfiles/files/media/Datasheet%20ADP810-Digital.pdf
> + */
> +
> +#include <linux/crc8.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/unaligned.h>
This is a very small set of includes.  Please follow include what you use (IWYU)
principles (loosely - there are a few headers that never make sense to include
directly).  So I'd definitely expect things like mutex.h here.
dev_printk.h etc.

> +
> +#include <linux/iio/iio.h>

> +
> +static int adp810_measure(struct adp810_data *data, struct adp810_read_buf *buf)
> +{
> +	struct i2c_client *client = data->client;
> +	struct device *dev = &client->dev;
> +	int ret;
> +	u16 trig_cmd = ADP810_TRIGGER_COMMAND;
> +
> +	/* Send trigger to the sensor for measurement */
> +	ret = i2c_master_send(client, (char *)&trig_cmd, sizeof(u16));

sizeof(trig_cmd)

I think it is vanishingly unlikely to matter but in theory i2c_master_send()
could return 1 and only one byte made it to device.
So it's common to have 
	if (ret < 0)...
		....
	if (ret != sizeof(trig_cmd))
		....

> +	if (ret < 0) {
> +		dev_err(dev, "Error sending trigger command\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * Wait for the sensor to acquire data. As per datasheet section 5.3.1,
> +	 * wait for at least 10ms before reading measurements from the sensor.
> +	 */
> +	msleep(ADP810_MEASURE_LATENCY_MS);
> +
> +	/* Read sensor values */
> +	ret = i2c_master_recv(client, (char *)buf, sizeof(*buf));
> +	if (ret < 0) {

Same potential issue for short reads as for the write above.

I don't recall seeing anything to say we either got full length or
error code but maybe that changed at somepoint to make this interface easier to use.


> +		dev_err(dev, "Error reading from sensor\n");
> +		return ret;
> +	}
> +
> +	/* CRC checks */
> +	crc8_populate_msb(crc_table, ADP810_CRC8_POLYNOMIAL);
> +	if (buf->dp_crc != crc8(crc_table, (u8 *)&buf->dp, 0x2, CRC8_INIT_VALUE)) {
> +		dev_err(dev, "CRC error for pressure\n");
> +		return -EIO;
> +	}
> +
> +	if (buf->tmp_crc != crc8(crc_table, (u8 *)&buf->tmp, 0x2, CRC8_INIT_VALUE)) {
> +		dev_err(dev, "CRC error for temperature\n");
> +		return -EIO;
> +	}
> +
> +	if (buf->sf_crc != crc8(crc_table, (u8 *)&buf->sf, 0x2, CRC8_INIT_VALUE)) {
> +		dev_err(dev, "CRC error for scale\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int adp810_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct adp810_data *data = iio_priv(indio_dev);
> +	struct device *dev = &data->client->dev;
> +	struct adp810_read_buf buf = {0};

Not a big thing but slight preference for { }.
It's a messy thing wrt to the c spec which never talked about holes
and this construct until recently.  However the kernel has build tests
that verify that all compilers will zero the holes with the { }
syntax and that is what the C standards folk have put in the spec now
as meaning whole structure including holes.

> +	int ret;
> +
> +	scoped_guard(mutex, &data->lock) {
> +		ret = adp810_measure(data, &buf);
> +		if (ret) {
> +			dev_err(dev, "Failed to read from device\n");
> +			return ret;
> +		}
> +	}
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_PRESSURE:
> +			*val = get_unaligned_be16(&buf.dp);
> +			return IIO_VAL_INT;
> +		case IIO_TEMP:
> +			*val = get_unaligned_be16(&buf.tmp);
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_PRESSURE:
> +			*val = get_unaligned_be16(&buf.sf);
> +			return IIO_VAL_INT;
> +		case IIO_TEMP:
> +			*val = 200;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}



