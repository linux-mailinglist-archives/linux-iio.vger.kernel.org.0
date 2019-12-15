Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8534311F998
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2019 18:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfLORQP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Dec 2019 12:16:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:60900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfLORQO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Dec 2019 12:16:14 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D39D24654;
        Sun, 15 Dec 2019 17:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576430173;
        bh=atnktRRpqVKJjBv9WG4R0E+PMiRizzDqMT6NyW6rvlQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M6/oCcoLSsDDYKl2qx+dqRPgdzx6EAMBtWocVN95ygwXsItD+FgfUX/gn4gyg4yfE
         fLSyKTwC396u6kXEUfo82z8R7IeHkWK3gwQ5mxnUp4hbgUIBoCGCSP2jiJyJ7AbIIN
         3gaNO5mKLMWaD//wLrmBjgDcNSeIhnIQ8qSPK+Xs=
Date:   Sun, 15 Dec 2019 17:16:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     ruantu <mtwget@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: chemical: add support for Dynament Premier
 series single gas sensor
Message-ID: <20191215171609.1a288b2c@archlinux>
In-Reply-To: <20191210053721.731859-1-mtwget@gmail.com>
References: <20191210053721.731859-1-mtwget@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 10 Dec 2019 13:37:21 +0800
ruantu <mtwget@gmail.com> wrote:

> Add support for Dynament Premier series single gas sensor.
> 
> Signed-off-by: ruantu <mtwget@gmail.com>

Hi ruantu,

Welcome to IIO.

Just to check, could you confirm your signed-off-by meets
the requirements of Documentation/process/submitting-patches.rst
wrt to use your full name?  If it does, then my apologies!

Looks pretty good.  A few minor cleanups needed though. See inline.

Thanks,

Jonathan

> ---
>  MAINTAINERS                    |   5 +
>  drivers/iio/chemical/Kconfig   |  11 ++
>  drivers/iio/chemical/Makefile  |   1 +
>  drivers/iio/chemical/premier.c | 349 +++++++++++++++++++++++++++++++++
>  4 files changed, 366 insertions(+)
>  create mode 100644 drivers/iio/chemical/premier.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 02d5278a4c9a..18c26558ddfe 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13133,6 +13133,11 @@ F:	drivers/i2c/busses/i2c-puv3.c
>  F:	drivers/video/fbdev/fb-puv3.c
>  F:	drivers/rtc/rtc-puv3.c
>  
> +DYNAMENT PREMIER SERIES SINGLE GAS SENSOR DRIVER
> +M:	ruantu <mtwget@gmail.com>
> +S:	Maintained
> +F:	drivers/iio/chemical/premier.c

MAINTAINERS is in alphabetical order, not grouped by location.

> +
>  PLANTOWER PMS7003 AIR POLLUTION SENSOR DRIVER
>  M:	Tomasz Duszynski <tduszyns@gmail.com>
>  S:	Maintained
> diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> index fa4586037bb8..b75903a5a15c 100644
> --- a/drivers/iio/chemical/Kconfig
> +++ b/drivers/iio/chemical/Kconfig
> @@ -62,6 +62,17 @@ config IAQCORE
>  	  iAQ-Core Continuous/Pulsed VOC (Volatile Organic Compounds)
>  	  sensors
>  
> +config PREMIER
> +	tristate "Dynament Premier series sensor"
> +	depends on SERIAL_DEV_BUS
> +	select IIO_TRIGGERED_BUFFER
It looks to me like you started adding triggered buffer support here
but haven't finished.  For this patch, make sure you clean out any
initial support.  That can all come in a follow up patch.

> +	help
> +	  Say Y here to build support for the Dynament Premier
> +	  series sensor.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called premier.
> +
>  config PMS7003
>  	tristate "Plantower PMS7003 particulate matter sensor"
>  	depends on SERIAL_DEV_BUS
> diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
> index f97270bc4034..c8e779d7cf4a 100644
> --- a/drivers/iio/chemical/Makefile
> +++ b/drivers/iio/chemical/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_BME680_I2C) += bme680_i2c.o
>  obj-$(CONFIG_BME680_SPI) += bme680_spi.o
>  obj-$(CONFIG_CCS811)		+= ccs811.o
>  obj-$(CONFIG_IAQCORE)		+= ams-iaq-core.o
> +obj-$(CONFIG_PREMIER)		+= premier.o
>  obj-$(CONFIG_PMS7003) += pms7003.o
>  obj-$(CONFIG_SENSIRION_SGP30)	+= sgp30.o
>  obj-$(CONFIG_SPS30) += sps30.o
> diff --git a/drivers/iio/chemical/premier.c b/drivers/iio/chemical/premier.c
> new file mode 100644
> index 000000000000..5681e2caa03b
> --- /dev/null
> +++ b/drivers/iio/chemical/premier.c
> @@ -0,0 +1,349 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Dynament Premier series single gas sensor driver
> + *
> + * Copyright (c) ruantu <mtwget@gmail.com>
> + */
> +
> +#include <asm/unaligned.h>
> +#include <linux/completion.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/serdev.h>
> +
> +#define PREMIER_DRIVER_NAME "premier"

This is a bit of a generic name, perhaps
dynament-premier?

> +
> +#define DLE (0x10)
Please prefix these defines.  The chance of them clashing with something
in a generic header sometime in the future is too high.

PREMIER_CMD_RD etc.

> +#define CMD_RD (0x13)
> +#define CMD_NAK (0x19)
> +#define CMD_DAT (0x1a)
> +#define EOFF (0x1f)
> +
> +#define PREMIER_TIMEOUT msecs_to_jiffies(6000)
> +
> +/*
> + * commands have following format:
> + *
> + * +-----+-----+---------+-----+-----+-----------+-----------+
> + * | DLE | CMD | PAYLOAD | DLE | EOF | CKSUM MSB | CKSUM LSB |
> + * +-----+-----+---------+-----+-----+-----------+-----------+
> + */
> +static const u8 premier_cmd_read_live_data_simple[] = {
> +	0x10, 0x13, 0x06, 0x10, 0x1F, 0x00, 0x58
> +};
> +
> +struct premier_frame {
> +	u8 state;
> +	u8 is_dat;
> +	u8 is_nak;
> +	u8 data_len;
> +	u8 vi, si, gi, gj;
> +	u8 gas[4];
> +	u8 byte_stuffing;
> +	u8 checksum_received[2];
> +	u16 checksum_calculated;
> +};
> +
> +struct premier_state {
> +	struct serdev_device *serdev;
> +	struct premier_frame frame;
> +	struct completion frame_ready;
> +	struct mutex lock;	/* must be held whenever state gets touched */
> +};
> +
> +static int premier_do_cmd_read_live_data(struct premier_state *state)
> +{
> +	int ret;
> +
> +	ret =
> +	    serdev_device_write(state->serdev,
> +				premier_cmd_read_live_data_simple,
> +				sizeof(premier_cmd_read_live_data_simple),
> +				PREMIER_TIMEOUT);
> +	if (ret < sizeof(premier_cmd_read_live_data_simple))
> +		return ret < 0 ? ret : -EIO;
> +
> +	ret = wait_for_completion_interruptible_timeout(&state->frame_ready,
> +							PREMIER_TIMEOUT);
> +
> +	if (!ret)
> +		ret = -ETIMEDOUT;
> +
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static s32 premier_float_to_int_clamped(const u8 *fp)
> +{
> +	int val = get_unaligned_le32(fp);
> +	int mantissa = val & GENMASK(22, 0);
> +	/* this is fine since passed float is always non-negative */
> +	int exp = val >> 23;
> +	int fraction, shift;
> +
> +	/* special case 0 */
> +	if (!exp && !mantissa)
> +		return 0;
> +
> +	exp -= 127;
> +	if (exp < 0) {
> +		/* return values ranging from 1 to 99 */
> +		return ((((1 << 23) + mantissa) * 100) >> 23) >> (-exp);
> +	}
> +
> +	/* return values ranging from 100 to int_max */
> +	shift = 23 - exp;
> +	val = (1 << exp) + (mantissa >> shift);
> +
> +	fraction = mantissa & GENMASK(shift - 1, 0);
> +
> +	return val * 100 + ((fraction * 100) >> shift);
> +}
> +
> +static int premier_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct premier_state *state = iio_priv(indio_dev);
> +	struct premier_frame *frame = &state->frame;
> +	int ret;
> +	s32 val_tmp;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +
> +		mutex_lock(&state->lock);
> +		ret = premier_do_cmd_read_live_data(state);
> +		if (ret) {
> +			mutex_unlock(&state->lock);
> +			return ret;
> +		}
> +		val_tmp = premier_float_to_int_clamped(frame->gas);
> +		mutex_unlock(&state->lock);
> +
> +		*val = val_tmp / 100;
> +		*val2 = (val_tmp % 100) * 10000;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info premier_info = {
> +	.read_raw = premier_read_raw,
> +};
> +
> +static const struct iio_chan_spec premier_channels[] = {
> +	{
> +	 .type = IIO_CONCENTRATION,
> +	 .channel = 1,
> +	 .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),

The indentation in here needs fixing up.

Also, could you confirm what the units of this reading are and compare
with the Documented IIO base units in Documentation/ABI/testings/sysfs-bus-iio-*

We have a nasty habit of getting inconsistent ones in new drivers so good
to check!

> +	 .scan_index = -1,
> +	  },
> +	IIO_CHAN_SOFT_TIMESTAMP(0),
> +};
> +
> +static int premier_receive_buf(struct serdev_device *serdev,
> +			       const unsigned char *buf, size_t size)
> +{
> +	struct iio_dev *indio_dev = serdev_device_get_drvdata(serdev);
> +	struct premier_state *state = iio_priv(indio_dev);
> +	struct premier_frame *frame = &state->frame;
> +	int i;
> +
> +	for (i = 0; i < size; i++) {
> +
> +		if (frame->state > 0 && frame->state <= 7)
> +			frame->checksum_calculated += buf[i];
> +
> +		switch (frame->state) {
> +		case 0:
> +			if (buf[i] == DLE) {
> +				frame->is_dat = 0;
> +				frame->is_nak = 0;
> +				frame->checksum_calculated = buf[i];
> +				/* we don't initialize checksum_calculated in
Multiline comment syntax in most of the kernel (including IIO) is
				/*
				 * We don't...
> +				 * the last state in case we didn't go
> +				 * there because of noise
> +				 */
> +				frame->state++;
> +			}
> +			break;
> +		case 1:
> +			/*
> +			 * if noise corrupts a byte in the FSM sequence,
> +			 * we loop between state 0 and 1,
> +			 * until we have a valid sequence of DLE&DAT or DLE&NAK
> +			 */
> +			if (buf[i] == CMD_DAT) {
> +				frame->is_dat = 1;
> +				frame->state++;
> +			} else if (buf[i] == CMD_NAK) {
> +				frame->is_nak = 1;
> +				frame->state++;
> +			} else
> +				frame->state = 0;
> +			break;
> +		case 2:
> +			if (frame->is_nak)
> +				frame->state = 0;
> +			else if (frame->is_dat) {
> +				frame->data_len = buf[i] - 4;
> +				/* remove version and status bytes from count */
> +				if (frame->data_len < 4)
> +					frame->state = 0;
> +				/* we check for the upper limit in state 5 */
> +				else
> +					frame->state++;
> +			} else
> +				frame->state = 0;
> +			break;
> +		case 3:
> +			/* just do nothing for 2 rounds to bypass
> +			 * the 2 version bytes
> +			 */
> +			if (frame->vi < 2 - 1)
> +				frame->vi++;
> +			else {
> +				frame->vi = 0;
> +				frame->state++;
> +			}
> +			break;
> +		case 4:
> +			if (frame->si < 2 - 1)
> +				frame->si++;
> +			else {
> +				frame->si = 0;
> +				frame->state++;
> +			}
> +			break;
> +		case 5:
> +			if (frame->gi < frame->data_len - 1) {
> +				if (buf[i] != 0x10 || frame->byte_stuffing) {
> +					frame->gas[frame->gj] = buf[i];
> +					frame->byte_stuffing = 0;
> +					frame->gj++;
> +					if (frame->gj >= 4)
> +						frame->state = 0;
> +					/* don't violate array limits
> +					 * if data_len corrupt
> +					 */
> +				} else
> +					frame->byte_stuffing = 1;
> +				frame->gi++;
> +			} else {
> +				frame->gas[frame->gj] = buf[i];
> +				frame->byte_stuffing = 0;
> +				frame->gi = 0;
> +				frame->gj = 0;
> +				frame->state++;
> +			}
> +			break;
> +		case 6:
> +			if (buf[i] == DLE)
> +				frame->state++;
> +			else
> +				frame->state = 0;
> +			break;
> +		case 7:
> +			if (buf[i] == EOFF)
> +				frame->state++;
> +			else
> +				frame->state = 0;
> +			break;
> +		case 8:
> +			frame->checksum_received[1] = buf[i];
> +
> +			frame->state++;
> +			break;
> +		case 9:
> +			frame->checksum_received[0] = buf[i];
> +
> +			if (frame->checksum_calculated ==
> +			    get_unaligned_le16(frame->checksum_received))
> +				complete(&state->frame_ready);
> +
> +			frame->state = 0;
> +			break;
> +		}
> +	}
> +
> +	return size;
> +}
> +
> +static const struct serdev_device_ops premier_serdev_ops = {
> +	.receive_buf = premier_receive_buf,
> +	.write_wakeup = serdev_device_write_wakeup,
> +};
> +
> +static const unsigned long premier_scan_masks[] = { 0x07, 0x00 };
> +
> +static int premier_probe(struct serdev_device *serdev)
> +{
> +	struct premier_state *state;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&serdev->dev, sizeof(*state));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	state = iio_priv(indio_dev);
> +	serdev_device_set_drvdata(serdev, indio_dev);
> +	state->serdev = serdev;
> +	indio_dev->dev.parent = &serdev->dev;
> +	indio_dev->info = &premier_info;
> +	indio_dev->name = PREMIER_DRIVER_NAME;
> +	indio_dev->channels = premier_channels,

The line above should end in a semicolon and next one not be indented.
Although they are related, kernel code conventions don't allow for
multiple assignment in one line.

> +	    indio_dev->num_channels = ARRAY_SIZE(premier_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->available_scan_masks = premier_scan_masks;

available_scan_masks is only used if you have buffered support which you
don't seem to offer in this patch.

> +
> +	mutex_init(&state->lock);
> +	init_completion(&state->frame_ready);
> +
> +	serdev_device_set_client_ops(serdev, &premier_serdev_ops);
> +	ret = devm_serdev_device_open(&serdev->dev, serdev);
> +	if (ret)
> +		return ret;
> +
> +	serdev_device_set_baudrate(serdev, 9600);
> +	serdev_device_set_flow_control(serdev, false);
> +
> +	ret = serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(&serdev->dev, indio_dev);
> +}
> +
> +static const struct of_device_id premier_of_match[] = {
> +	{.compatible = "dynament,premier" },

Space needed before .compatible

> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, premier_of_match);
> +
> +static struct serdev_device_driver premier_driver = {
> +	.driver = {
> +		   .name = PREMIER_DRIVER_NAME,
> +		   .of_match_table = premier_of_match,
Something strange with indenting here.  Normally structure
members are indented a full extra tab from the structure.
Here we seem to have som spaces. 
> +		    },
> +	.probe = premier_probe,
> +};
> +
> +module_serdev_device_driver(premier_driver);
> +
> +MODULE_AUTHOR("ruantu <mtwget@gmail.com>");
> +MODULE_DESCRIPTION("Dynament Premier series single gas sensor driver");
> +MODULE_LICENSE("GPL v2");

