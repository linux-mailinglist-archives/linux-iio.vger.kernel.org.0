Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509F73CC446
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jul 2021 17:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbhGQPu4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Jul 2021 11:50:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234432AbhGQPu4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Jul 2021 11:50:56 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD88E61106;
        Sat, 17 Jul 2021 15:47:56 +0000 (UTC)
Date:   Sat, 17 Jul 2021 16:50:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     lars@metafoo.de, robh+dt@kernel.org, matt.ranostay@konsulko.com,
        andriy.shevchenko@linux.intel.com, vlad.dogaru@intel.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Andrea Merello <andrea.merello@iit.it>
Subject: Re: [PATCH 4/4] iio: imu: add BNO055 serdev driver
Message-ID: <20210717165018.50a26629@jic23-huawei>
In-Reply-To: <20210715141742.15072-5-andrea.merello@gmail.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
        <20210715141742.15072-5-andrea.merello@gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 15 Jul 2021 16:17:42 +0200
Andrea Merello <andrea.merello@gmail.com> wrote:

> This path adds a serdev driver for communicating to a BNO055 IMU
> via serial bus, and enables the BNO055 core driver to work in this
> scenario.
> 
> Signed-off-by: Andrea Merello <andrea.merello@iit.it>
> Cc: Andrea Merello <andrea.merello@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Vlad Dogaru <vlad.dogaru@intel.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-iio@vger.kernel.org

Hi Andrea,

A few comments inline.

Jonathan

> ---
>  drivers/iio/imu/bno055/Kconfig     |   5 +
>  drivers/iio/imu/bno055/Makefile    |   1 +
>  drivers/iio/imu/bno055/bno055_sl.c | 576 +++++++++++++++++++++++++++++
>  3 files changed, 582 insertions(+)
>  create mode 100644 drivers/iio/imu/bno055/bno055_sl.c
> 
> diff --git a/drivers/iio/imu/bno055/Kconfig b/drivers/iio/imu/bno055/Kconfig
> index 2bfed8df4554..6d2e8c9f85b7 100644
> --- a/drivers/iio/imu/bno055/Kconfig
> +++ b/drivers/iio/imu/bno055/Kconfig
> @@ -5,3 +5,8 @@
>  
>  config BOSH_BNO055_IIO
>  	tristate
> +
> +config BOSH_BNO055_SERIAL
> +	tristate "Bosh BNO055 attached via serial bus"
> +	depends on SERIAL_DEV_BUS
> +	select BOSH_BNO055_IIO
> diff --git a/drivers/iio/imu/bno055/Makefile b/drivers/iio/imu/bno055/Makefile
> index 15c5ddf8d648..b704b10b6bd1 100644
> --- a/drivers/iio/imu/bno055/Makefile
> +++ b/drivers/iio/imu/bno055/Makefile
> @@ -4,3 +4,4 @@
>  #
>  
>  obj-$(CONFIG_BOSH_BNO055_IIO) += bno055.o
> +obj-$(CONFIG_BOSH_BNO055_SERIAL) += bno055_sl.o
> diff --git a/drivers/iio/imu/bno055/bno055_sl.c b/drivers/iio/imu/bno055/bno055_sl.c
> new file mode 100644
> index 000000000000..9604d73d126c
> --- /dev/null
> +++ b/drivers/iio/imu/bno055/bno055_sl.c
> @@ -0,0 +1,576 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Serial line interface for Bosh BNO055 IMU (via serdev).
> + * This file implements serial communication up to the register read/write
> + * level.
> + *
> + * Copyright (C) 2021 Istituto Italiano di Tecnologia
> + * Electronic Design Laboratory
> + * Written by Andrea Merello <andrea.merello@iit.it>
> + *
> + * This driver is besed on
> + *	Plantower PMS7003 particulate matter sensor driver
> + *	Which is
> + *	Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of_irq.h>
> +#include <linux/regmap.h>
> +#include <linux/serdev.h>
> +
> +#include "bno055.h"
> +
> +#define BNO055_SL_DRIVER_NAME "bno055-sl"
> +
> +/*
> + * Register writes cmd have the following format
> + * +------+------+-----+-----+----- ... ----+
> + * | 0xAA | 0xOO | REG | LEN | payload[LEN] |
> + * +------+------+-----+-----+----- ... ----+
> + *
> + * Register write responses have the following format
> + * +------+----------+
> + * | 0xEE | ERROCODE |
> + * +------+----------+
> + *
> + * Register read have the following format
> + * +------+------+-----+-----+
> + * | 0xAA | 0xO1 | REG | LEN |
> + * +------+------+-----+-----+
> + *
> + * Successful register read response have the following format
> + * +------+-----+----- ... ----+
> + * | 0xBB | LEN | payload[LEN] |
> + * +------+-----+----- ... ----+
> + *
> + * Failed register read response have the following format
> + * +------+--------+
> + * | 0xEE | ERRCODE|  (ERRCODE always > 1)
> + * +------+--------+
> + *
> + * Error codes are
> + * 01: OK
> + * 02: read/write FAIL
> + * 04: invalid address
> + * 05: write on RO
> + * 06: wrong start byte
> + * 07: bus overrun
> + * 08: len too high
> + * 09: len too low
> + * 10: bus RX byte timeout (timeout is 30mS)
> + *
> + *
> + * **WORKAROUND ALERT**
> + *
> + * Serial communication seems very fragile: the BNO055 buffer seems to overflow
> + * very easy; BNO055 seems able to sink few bytes, then it needs a brief pause.
> + * On the other hand, it is also picky on timeout: if there is a pause > 30mS in
> + * between two bytes then the transaction fails (IMU internal RX FSM resets).
> + *
> + * BMU055 has been seen also failing to process commands in case we send them
> + * too close each other (or if it is somehow busy?)
> + *
> + * One idea would be to split data in chunks, and then wait 1-2mS between
> + * chunks (we hope not to exceed 30mS delay for any reason - which should
> + * be pretty a lot of time for us), and eventually retry in case the BNO055
> + * gets upset for any reason. This seems to work in avoiding the overflow
> + * errors, but indeed it seems slower than just perform a retry when an overflow
> + * error occur.
> + * In particular I saw these scenarios:
> + * 1) If we send 2 bytes per time, then the IMU never(?) overflows.
> + * 2) If we send 4 bytes per time (i.e. the full header), then the IMU could
> + *    overflow, but it seem to sink all 4 bytes, then it returns error.
> + * 3) If we send more than 4 bytes, the IMU could overflow, and I saw it sending
> + *    error after 4 bytes are sent; we have troubles in synchronizing again,
> + *    because we are still sending data, and the IMU interprets it as the 1st
> + *    byte of a new command.
> + *
> + * So, we workaround all this in the following way:
> + * In case of read we don't split the header but we rely on retries; This seems
> + * convenient for data read (where we TX only the hdr).
> + * For TX we split the transmission in 2-bytes chunks so that, we should not
> + * only avoid case 2 (which is still manageable), but we also hopefully avoid
> + * case 3, that would be by far worse.

Nice docs and this sounds terrible!

> + */
> +
> +/* Read operation overhead:
> + * 4 bytes req + 2byte resp hdr
> + * 6 bytes = 60 bit (considering 1start + 1stop bits).
> + * 60/115200 = ~520uS
> + * In 520uS we could read back about 34 bytes that means 3 samples, this means
> + * that in case of scattered read in which the gap is 3 samples or less it is
> + * still convenient to go for a burst.
> + * We have to take into account also IMU response time - IMU seems to be often
> + * reasonably quick to respond, but sometimes it seems to be in some "critical
> + * section" in which it delays handling of serial protocol.
> + * By experiment, it seems convenient to burst up to about 5/6-samples-long gap
> + */
> +
> +#define BNO055_SL_XFER_BURST_BREAK_THRESHOLD 6
> +
> +struct bno055_sl_priv {
> +	struct serdev_device *serdev;
> +	struct completion cmd_complete;
> +	enum {
> +		CMD_NONE,
> +		CMD_READ,
> +		CMD_WRITE,
> +	} expect_response;
> +	int expected_data_len;
> +	u8 *response_buf;
> +	enum {
> +		STATUS_OK = 0,  /* command OK */
> +		STATUS_FAIL = 1,/* IMU communicated an error */
> +		STATUS_CRIT = -1/* serial communication with IMU failed */
> +	} cmd_status;
> +	struct mutex lock;
> +
> +	/* Only accessed in behalf of RX callback context. No lock needed. */
> +	struct {
> +		enum {
> +			RX_IDLE,
> +			RX_START,
> +			RX_DATA
> +		} state;
> +		int databuf_count;
> +		int expected_len;
> +		int type;
> +	} rx;
> +
> +	/* Never accessed in behalf of RX callback context. No lock needed */
> +	bool cmd_stale;
> +};
> +
> +static int bno055_sl_send_chunk(struct bno055_sl_priv *priv, u8 *data, int len)
> +{
> +	int ret;
> +
> +	dev_dbg(&priv->serdev->dev, "send (len: %d): %*ph", len, len, data);
> +	ret = serdev_device_write(priv->serdev, data, len,
> +				  msecs_to_jiffies(25));
> +	if (ret < len)
> +		return ret < 0 ? ret : -EIO;

Break this up perhaps as will be easier to read.

	if (ret < 0)
		return ret;

	if (ret < len)
		return -EIO;

	return 0;

> +	return 0;
> +}
> +
> +/*
> + * Sends a read or write command.
> + * 'data' can be NULL (used in read case). 'len' parameter is always valid; in
> + * case 'data' is non-NULL then it must match 'data' size.
> + */
> +static int bno055_sl_do_send_cmd(struct bno055_sl_priv *priv,
> +				 int read, int addr, int len, u8 *data)
> +{
> +	int ret;
> +	int chunk_len;
> +	u8 hdr[] = {0xAA, !!read, addr, len};
> +
> +	if (read) {
> +		ret = bno055_sl_send_chunk(priv, hdr, 4);
> +	} else {
> +		ret = bno055_sl_send_chunk(priv, hdr, 2);
> +		if (ret)
> +			goto fail;
> +
> +		usleep_range(2000, 3000);
> +		ret = bno055_sl_send_chunk(priv, hdr + 2, 2);
> +	}
> +	if (ret)
> +		goto fail;
> +
> +	if (data) {
> +		while (len) {
> +			chunk_len = min(len, 2);
> +			usleep_range(2000, 3000);
> +			ret = bno055_sl_send_chunk(priv, data, chunk_len);
> +			if (ret)
> +				goto fail;
> +			data += chunk_len;
> +			len -= chunk_len;
> +		}
> +	}
> +
> +	return 0;
> +fail:
> +	/* waiting more than 30mS should clear the BNO055 internal state */
> +	usleep_range(40000, 50000);
> +	return ret;
> +}
> +
> +static int bno_sl_send_cmd(struct bno055_sl_priv *priv,
> +			   int read, int addr, int len, u8 *data)
> +{
> +	const int retry_max = 5;
> +	int retry = retry_max;
> +	int ret = 0;
> +
> +	/*
> +	 * In case previous command was interrupted we still neet to wait it to
> +	 * complete before we can issue new commands
> +	 */
> +	if (priv->cmd_stale) {
> +		ret = wait_for_completion_interruptible_timeout(&priv->cmd_complete,
> +								msecs_to_jiffies(100));
> +		if (ret == -ERESTARTSYS)
> +			return -ERESTARTSYS;
> +
> +		priv->cmd_stale = false;
> +		/* if serial protocol broke, bail out */
> +		if (priv->cmd_status == STATUS_CRIT)
> +			goto exit;
> +	}
> +
> +	/*
> +	 * Try to convince the IMU to cooperate.. as explained in the comments
> +	 * at the top of this file, the IMU could also refuse the command (i.e.
> +	 * it is not ready yet); retry in this case.
> +	 */
> +	while (retry--) {
> +		mutex_lock(&priv->lock);
> +		priv->expect_response = read ? CMD_READ : CMD_WRITE;
> +		reinit_completion(&priv->cmd_complete);
> +		mutex_unlock(&priv->lock);
> +
> +		if (retry != (retry_max - 1))
> +			dev_dbg(&priv->serdev->dev, "cmd retry: %d",
> +				retry_max - retry);
> +		ret = bno055_sl_do_send_cmd(priv, read, addr, len, data);
> +		if (ret)
> +			continue;
> +
> +		ret = wait_for_completion_interruptible_timeout(&priv->cmd_complete,
> +								msecs_to_jiffies(100));
> +		if (ret == -ERESTARTSYS) {
> +			priv->cmd_stale = true;
> +			return -ERESTARTSYS;
> +		} else if (!ret) {
> +			ret = -ETIMEDOUT;
> +			break;
> +		}
> +		ret = 0;
> +
> +		/*
> +		 * Poll if the IMU returns error (i.e busy), break if the IMU
> +		 * returns OK or if the serial communication broke
> +		 */
> +		if (priv->cmd_status <= 0)
> +			break;
> +	}
> +
> +exit:
> +	if (ret)
> +		return ret;
> +	if (priv->cmd_status == STATUS_CRIT)
> +		return -EIO;
> +	if (priv->cmd_status == STATUS_FAIL)
> +		return -EINVAL;
> +	return 0;
> +}
> +
> +static int bno055_sl_write_reg(void *context, const void *data, size_t count)
> +{
> +	int ret;
> +	int reg;
> +	u8 *write_data = (u8 *)data + 1;
> +	struct bno055_sl_priv *priv = context;
> +
> +	if (count < 2) {
> +		dev_err(&priv->serdev->dev, "Invalid write count %d", count);
> +		return -EINVAL;
> +	}
> +
> +	reg = ((u8 *)data)[0];
> +	dev_dbg(&priv->serdev->dev, "wr reg 0x%x = 0x%x", reg, ((u8 *)data)[1]);
> +	ret = bno_sl_send_cmd(priv, 0, reg, count - 1, write_data);
> +
> +	return ret;
> +}
> +
> +static int bno055_sl_read_reg(void *context,
> +			      const void *reg, size_t reg_size,
> +			      void *val, size_t val_size)
> +{
> +	int ret;
> +	int reg_addr;
> +	struct bno055_sl_priv *priv = context;
> +
> +	if (reg_size != 1) {

Can we plausibly hit this?  I would have though the regmap controls it
and is set appropriately.  Hence safe to drop this check.

> +		dev_err(&priv->serdev->dev, "Invalid read regsize %d",
> +			reg_size);
> +		return -EINVAL;
> +	}
> +
> +	if (val_size > 128) {
> +		dev_err(&priv->serdev->dev, "Invalid read valsize %d",
> +			val_size);
> +		return -EINVAL;
> +	}
> +
> +	reg_addr = ((u8 *)reg)[0];
> +	dev_dbg(&priv->serdev->dev, "rd reg 0x%x (len %d)", reg_addr, val_size);
> +	mutex_lock(&priv->lock);
> +	priv->expected_data_len = val_size;
> +	priv->response_buf = val;
> +	mutex_unlock(&priv->lock);
> +
> +	ret = bno_sl_send_cmd(priv, 1, reg_addr, val_size, NULL);
> +
> +	mutex_lock(&priv->lock);
> +	priv->response_buf = NULL;
> +	mutex_unlock(&priv->lock);
> +
> +	return ret;
> +}
> +
> +/*
> + * Handler for received data; this is called from the reicever callback whenever
> + * it got some packet from the serial bus. The status tell us whether the
> + * packet is valid (i.e. header ok && received payload len consistent wrt the
> + * header). It's now our responsability to check whether this is what we
> + * expected, of whether we got some unexpected, yet valid, packet.
> + */
> +static void bno055_sl_handle_rx(struct bno055_sl_priv *priv, int status)
> +{
> +	mutex_lock(&priv->lock);
> +	switch (priv->expect_response) {
> +	case CMD_NONE:
> +		dev_warn(&priv->serdev->dev, "received unexpected, yet valid, data from sensor");
> +		mutex_unlock(&priv->lock);
> +		return;
> +
> +	case CMD_READ:
> +		priv->cmd_status = status;
> +		if (status == STATUS_OK &&
> +		    priv->rx.databuf_count != priv->expected_data_len) {
> +			/*
> +			 * If we got here, then the lower layer serial protocol
> +			 * seems consistent with itself; if we got an unexpected
> +			 * amount of data then signal it as a non critical error
> +			 */
> +			priv->cmd_status = STATUS_FAIL;
> +			dev_warn(&priv->serdev->dev, "received an unexpected amount of, yet valid, data from sensor");
> +		}
> +		break;
> +
> +	case CMD_WRITE:
> +		priv->cmd_status = status;
> +		break;
> +	}
> +
> +	priv->expect_response = CMD_NONE;
> +	complete(&priv->cmd_complete);
> +	mutex_unlock(&priv->lock);
> +}
> +
> +/*
> + * Serdev receiver FSM. This tracks the serial communication and parse the
> + * header. It pushes packets to bno055_sl_handle_rx(), eventually communicating
> + * failures (i.e. malformed packets).
> + * Idellay it doesn't know anything about upper layer (i.e. if this is the

Ideally

> + * packet we were really expecting), but since we copies the payload into the
> + * receiver buffer (that is not valid when i.e. we don't expect data), we
> + * snoop a bit in the upper layer..
> + * Also, we assume to RX one pkt per time (i.e. the HW doesn't send anything
> + * unless we require to AND we don't queue more than one request per time).
> + */
> +static int bno055_sl_receive_buf(struct serdev_device *serdev,
> +				 const unsigned char *buf, size_t size)
> +{
> +	int status;
> +	struct bno055_sl_priv *priv = serdev_device_get_drvdata(serdev);
> +	int _size = size;
> +
> +	if (size == 0)
> +		return 0;
> +
> +	dev_dbg(&priv->serdev->dev, "recv (len %d): %*ph ", size, size, buf);
> +	switch (priv->rx.state) {
> +	case RX_IDLE:
> +		/*
> +		 * New packet.
> +		 * Check for its 1st byte, that identifies the pkt type.
> +		 */
> +		if (buf[0] != 0xEE && buf[0] != 0xBB) {
> +			dev_err(&priv->serdev->dev,
> +				"Invalid packet start %x", buf[0]);
> +			bno055_sl_handle_rx(priv, STATUS_CRIT);
> +			break;
> +		}
> +		priv->rx.type = buf[0];
> +		priv->rx.state = RX_START;
> +		size--;
> +		buf++;
> +		priv->rx.databuf_count = 0;
> +		fallthrough;
> +
> +	case RX_START:
> +		/*
> +		 * Packet RX in progress, we expect either 1-byte len or 1-byte
> +		 * status depending by the packet type.
> +		 */
> +		if (size == 0)
> +			break;
> +
> +		if (priv->rx.type == 0xEE) {
> +			if (size > 1) {
> +				dev_err(&priv->serdev->dev, "EE pkt. Extra data received");
> +				status = STATUS_CRIT;
> +
> +			} else {
> +				status = (buf[0] == 1) ? STATUS_OK : STATUS_FAIL;
> +			}
> +			bno055_sl_handle_rx(priv, status);
> +			priv->rx.state = RX_IDLE;
> +			break;
> +
> +		} else {
> +			/*priv->rx.type == 0xBB */
> +			priv->rx.state = RX_DATA;
> +			priv->rx.expected_len = buf[0];
> +			size--;
> +			buf++;
> +		}
> +		fallthrough;
> +
> +	case RX_DATA:
> +		/* Header parsed; now receiving packet data payload */
> +		if (size == 0)
> +			break;
> +
> +		if (priv->rx.databuf_count + size > priv->rx.expected_len) {
> +			/*
> +			 * This is a inconsistency in serial protocol, we lost
> +			 * sync and we don't know how to handle further data
> +			 */
> +			dev_err(&priv->serdev->dev, "BB pkt. Extra data received");
> +			bno055_sl_handle_rx(priv, STATUS_CRIT);
> +			priv->rx.state = RX_IDLE;
> +			break;
> +		}
> +
> +		mutex_lock(&priv->lock);
> +		/*
> +		 * NULL e.g. when read cmd is stale or when no read cmd is
> +		 * actually pending.
> +		 */
> +		if (priv->response_buf &&
> +		    /*
> +		     * Snoop on the upper layer protocol stuff to make sure not
> +		     * to write to an invalid memory. Apart for this, let's the
> +		     * upper layer manage any inconsistency wrt expected data
> +		     * len (as long as the serial protocol is consistent wrt
> +		     * itself (i.e. response header is consistent with received
> +		     * response len.
> +		     */
> +		    (priv->rx.databuf_count + size <= priv->expected_data_len))
> +			memcpy(priv->response_buf + priv->rx.databuf_count,
> +			       buf, size);
> +		mutex_unlock(&priv->lock);
> +
> +		priv->rx.databuf_count += size;
> +
> +		/*
> +		 * Reached expected len advertised by the IMU for the current
> +		 * packet. Pass it to the upper layer (for us it is just valid).
> +		 */
> +		if (priv->rx.databuf_count == priv->rx.expected_len) {
> +			bno055_sl_handle_rx(priv, STATUS_OK);
> +			priv->rx.state = RX_IDLE;
> +		}
> +		break;
> +	}
> +
> +	return _size;
> +}
> +
> +static const struct serdev_device_ops bno055_sl_serdev_ops = {
> +	.receive_buf = bno055_sl_receive_buf,
> +	.write_wakeup = serdev_device_write_wakeup,
> +};
> +
> +static struct regmap_bus bno055_sl_regmap_bus = {
> +	.write = bno055_sl_write_reg,
> +	.read = bno055_sl_read_reg,
> +};
> +
> +static int bno055_sl_probe(struct serdev_device *serdev)
> +{
> +	struct bno055_sl_priv *priv;
> +	struct regmap *regmap;
> +	int ret;
> +	int irq = 0;
> +
> +	priv = devm_kzalloc(&serdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	serdev_device_set_drvdata(serdev, priv);
> +	priv->serdev = serdev;
> +	mutex_init(&priv->lock);
> +	init_completion(&priv->cmd_complete);
> +
> +	serdev_device_set_client_ops(serdev, &bno055_sl_serdev_ops);
> +	ret = devm_serdev_device_open(&serdev->dev, serdev);
> +	if (ret)
> +		return ret;
> +
> +	if (serdev_device_set_baudrate(serdev, 115200) != 115200) {
> +		dev_err(&serdev->dev, "Cannot set required baud rate");
> +		return -EIO;
> +	}
> +
> +	ret = serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
> +	if (ret) {
> +		dev_err(&serdev->dev, "Cannot set required parity setting");
> +		return ret;
> +	}
> +	serdev_device_set_flow_control(serdev, false);
> +
> +	regmap = devm_regmap_init(&serdev->dev, &bno055_sl_regmap_bus,
> +				  priv, &bno055_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&serdev->dev, "Unable to init register map");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	if (serdev->dev.of_node) {
If possible, use generic fw node functions from
linux/property.h rather than of specific ones. It 'might' be possible
to instantiate this from ACPI using the magic of PRP0001
(which uses the dt bindings from an entry in the DSDT table in ACPI
firmware).

> +		irq = of_irq_get(serdev->dev.of_node, 0);
> +		if (irq == -EPROBE_DEFER)
> +			return irq;
> +		if (irq <= 0) {
> +			dev_info(&serdev->dev,
> +				 "Can't get IRQ resource (err %d)", irq);
Isn't there an explicit errno for when it fails to get it because it
isn't specified?  We want to catch that and error out on anything else.

Afterall if someone specified an IRQ that doesn't work, then they don't
want us to hid that fact.

> +			irq = 0;
> +		}
> +	}
> +
> +	return bno055_probe(&serdev->dev, regmap, irq,
> +			    BNO055_SL_XFER_BURST_BREAK_THRESHOLD);
> +}
> +
> +static const struct of_device_id bno055_sl_of_match[] = {
> +	{ .compatible = "bosch,bno055-serial" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, bno055_sl_of_match);
> +
> +static struct serdev_device_driver bno055_sl_driver = {
> +	.driver = {
> +		.name = BNO055_SL_DRIVER_NAME,
> +		.of_match_table = bno055_sl_of_match,
> +	},
> +	.probe = bno055_sl_probe,
> +};
> +module_serdev_device_driver(bno055_sl_driver);
> +
> +MODULE_AUTHOR("Andrea Merello <andrea.merello@iit.it>");
> +MODULE_DESCRIPTION("Bosch BNO055 serdev interface");
> +MODULE_LICENSE("GPL v2");

