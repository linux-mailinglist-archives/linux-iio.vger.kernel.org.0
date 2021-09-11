Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF1040790B
	for <lists+linux-iio@lfdr.de>; Sat, 11 Sep 2021 17:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbhIKP1o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Sep 2021 11:27:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230472AbhIKP1n (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 Sep 2021 11:27:43 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0A85611F0;
        Sat, 11 Sep 2021 15:26:28 +0000 (UTC)
Date:   Sat, 11 Sep 2021 16:29:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
        Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH v5 3/4] iio: chemical: Add Senseair Sunrise 006-0-007
 driver
Message-ID: <20210911162959.1018316c@jic23-huawei>
In-Reply-To: <20210909094537.218064-4-jacopo@jmondi.org>
References: <20210909094537.218064-1-jacopo@jmondi.org>
        <20210909094537.218064-4-jacopo@jmondi.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  9 Sep 2021 11:45:36 +0200
Jacopo Mondi <jacopo@jmondi.org> wrote:

> Add support for the Senseair Sunrise 006-0-0007 driver through the
> IIO subsystem.
> 
> Datasheet: https://rmtplusstoragesenseair.blob.core.windows.net/docs/Dev/publicerat/TDE5531.pdf
> Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
Given you will be doing a v6 anyway, I noticed one small place inline where you can reduce
the scope of the lock and hence simplify error paths a bit (it occurs a few times in similar functions).

Regmap stuff looks acceptable to me, though if a better way comes from Peter's comments even
better!

Thanks,

Jonathan

> +
> +/* Custom regmap read/write operations: perform unlocked access to the i2c bus. */
> +
> +static int sunrise_regmap_read(void *context, const void *reg_buf,
> +			       size_t reg_size, void *val_buf, size_t val_size)
> +{
> +	struct i2c_client *client = context;
> +	union i2c_smbus_data data;
> +	int ret;
> +
> +	memset(&data, 0, sizeof(data));
> +	data.block[0] = val_size;
> +
> +	/*
> +	 * Wake up sensor by sending sensor address: START, sensor address,
> +	 * STOP. Sensor will not ACK this byte.
> +	 *
> +	 * The chip enters a low power state after 15msec without
> +	 * communications or after a complete read/write sequence.
> +	 */
> +	__i2c_smbus_xfer(client->adapter, client->addr, I2C_M_IGNORE_NAK,
> +			 I2C_SMBUS_WRITE, 0, I2C_SMBUS_QUICK, NULL);
> +
> +	ret = __i2c_smbus_xfer(client->adapter, client->addr, client->flags,
> +			       I2C_SMBUS_READ, ((u8 *)reg_buf)[0],
> +			       I2C_SMBUS_I2C_BLOCK_DATA, &data);
> +	if (ret < 0)
> +		return ret;
> +
> +	memcpy(val_buf, &data.block[1], data.block[0]);
> +
> +	return 0;
> +}
> +
> +static int sunrise_regmap_write(void *context, const void *val_buf, size_t count)
> +{
> +	struct i2c_client *client = context;
> +	union i2c_smbus_data data;
> +
> +	/* Discard reg address from values count. */
> +	if (count < 1)
> +		return -EINVAL;
> +	count--;
> +
> +	memset(&data, 0, sizeof(data));
> +	data.block[0] = count;
> +	memcpy(&data.block[1], (u8 *)val_buf + 1, count);
> +
> +	__i2c_smbus_xfer(client->adapter, client->addr, I2C_M_IGNORE_NAK,
> +			 I2C_SMBUS_WRITE, 0, I2C_SMBUS_QUICK, NULL);
> +
> +	return __i2c_smbus_xfer(client->adapter, client->addr, client->flags,
> +				I2C_SMBUS_WRITE, ((u8 *)val_buf)[0],
> +				I2C_SMBUS_I2C_BLOCK_DATA, &data);
> +}

This didn't end up looking too bad :)


...

> +
> +static ssize_t sunrise_cal_background_write(struct iio_dev *iiodev,
> +					    uintptr_t private,
> +					    const struct iio_chan_spec *chan,
> +					    const char *buf, size_t len)
> +{
> +	struct sunrise_dev *sunrise = iio_priv(iiodev);
> +	bool enable;
> +	int ret;
> +
> +	mutex_lock(&sunrise->lock);
> +	ret = kstrtobool(buf, &enable);
> +	if (ret)
> +		goto out_unlock;
> +
> +	if (!enable)
> +		goto out_unlock;

Trivial: Move these outside the lock (as only use local variables) and
then return directly from them.  That gets rid of the need for the label as well.

Same for other cases that look like this...

> +
> +	ret = sunrise_calibrate(sunrise, &calib_data[SUNRISE_CALIBRATION_BACKGROUND]);
> +
> +out_unlock:
> +	mutex_unlock(&sunrise->lock);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +

Thanks,

Jonathan
