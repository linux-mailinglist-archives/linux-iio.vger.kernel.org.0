Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220251E9748
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 13:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgEaLen (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 07:34:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbgEaLem (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 07:34:42 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 968FC206F1;
        Sun, 31 May 2020 11:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590924882;
        bh=dPuBXXaCmn2eZU1EusuJUsYMIvzA740nALAGYHJCIio=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OrKYpw8jcmTq8KRB127KUb/NLeQgccxfNQlYP5qAsrZhn7CmTC0ua3WqfBY7rHIyR
         kJ/FVHwy7cyQ3t7YOWvAnMm+IqbRanRE3RZKOoVYRXtwbHDnvEfqSPobPALbjjhJgW
         +qVDgaVLE1M4v1gb3GEAYMFE9o1BIPRs5qjTyoig=
Date:   Sun, 31 May 2020 12:34:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     robh+dt@kernel.org, robh@kernel.org, mchehab+huawei@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/12] iio: imu: inv_icm42600: add core of new
 inv_icm42600 driver
Message-ID: <20200531123437.05b3df36@archlinux>
In-Reply-To: <20200527185711.21331-2-jmaneyrol@invensense.com>
References: <20200527185711.21331-1-jmaneyrol@invensense.com>
        <20200527185711.21331-2-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 27 May 2020 20:57:00 +0200
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> Core component of a new driver for InvenSense ICM-426xx devices.
> It includes registers definition, main probe/setup, and device
> utility functions.
> 
> ICM-426xx devices are latest generation of 6-axis IMU,
> gyroscope+accelerometer and temperature sensor. This device
> includes a 2K FIFO, supports I2C/I3C/SPI, and provides
> intelligent motion features like pedometer, tilt detection,
> and tap detection.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>

A few things inline.

Either I'm missing something or I'm guessing vddio is not controllable
on your test board.

> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h   | 372 ++++++++++
>  .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 635 ++++++++++++++++++
>  2 files changed, 1007 insertions(+)
>  create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600.h
>  create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> 

...

> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> new file mode 100644
> index 000000000000..81b171d6782c
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c

> +const struct iio_mount_matrix *
> +inv_icm42600_get_mount_matrix(const struct iio_dev *indio_dev,
> +			      const struct iio_chan_spec *chan)
> +{
> +	const struct inv_icm42600_state *st =
> +			iio_device_get_drvdata((struct iio_dev *)indio_dev);

If you review my patch to the core, I can get that applied and we can drop
the ugly cast from here!

Just waiting for someone to sanity check it.
> +
> +	return &st->orientation;
> +}
...

> +/* Runtime suspend will turn off sensors that are enabled by iio devices. */
> +static int __maybe_unused inv_icm42600_runtime_suspend(struct device *dev)
> +{
> +	struct inv_icm42600_state *st = dev_get_drvdata(dev);
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +
> +	/* disable all sensors */
> +	ret = inv_icm42600_set_pwr_mgmt0(st, INV_ICM42600_SENSOR_MODE_OFF,
> +					 INV_ICM42600_SENSOR_MODE_OFF, false,
> +					 NULL);
> +	if (ret)
> +		goto error_unlock;
> +
> +	regulator_disable(st->vddio_supply);

Don't seem to turn this on again in runtime_resume..
Why?  Definitely needs at least a comment.

> +
> +error_unlock:
> +	mutex_unlock(&st->lock);
> +	return ret;
> +}
> +
> +/* Sensors are enabled by iio devices, no need to turn them back on here. */
> +static int __maybe_unused inv_icm42600_runtime_resume(struct device *dev)
> +{
> +	struct inv_icm42600_state *st = dev_get_drvdata(dev);
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +
> +	ret = inv_icm42600_enable_regulator_vddio(st);
> +
> +	mutex_unlock(&st->lock);
> +	return ret;
> +}
> +
> +const struct dev_pm_ops inv_icm42600_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(inv_icm42600_suspend, inv_icm42600_resume)
> +	SET_RUNTIME_PM_OPS(inv_icm42600_runtime_suspend,
> +			   inv_icm42600_runtime_resume, NULL)
> +};
> +EXPORT_SYMBOL_GPL(inv_icm42600_pm_ops);
> +
> +MODULE_AUTHOR("InvenSense, Inc.");
> +MODULE_DESCRIPTION("InvenSense ICM-426xx device driver");
> +MODULE_LICENSE("GPL");

