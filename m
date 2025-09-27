Return-Path: <linux-iio+bounces-24489-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB278BA60AF
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 16:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1833D189E11E
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 14:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE53E2E36EC;
	Sat, 27 Sep 2025 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLNGZyvz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F1683CC7;
	Sat, 27 Sep 2025 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758984278; cv=none; b=skXxU8URf/UxMEegfDJP2pbuP62xgZx+HuBcF3UvtaOzyTDJEUqEQxDMeAvYP//hUp0r+n8mXfCYyl1ogjVvnWFmb2CLXxuyuzG//zdlOuD0vXe4F45b7thzKphd5dw9sz62aBtwLsoN5j0iNz/SyV1lPgdRS4vNDu2ymQN8tO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758984278; c=relaxed/simple;
	bh=UfAyved8ZP+UUnl8b5uzwH4uH5DnqHMQiODvQlmvz9g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J04h3JZAhftwTiV7V6rc1VoIHjy1MjjUC8T4dnnCJFvtb3OwWS2rTeEgB+ub6Y2Cn4lI8SGktq6FXrxdagMz0xfS/o1ytlBTdgsCJGWfuPp/YnXnXWs9VB0zSuXagCTboUKNo4bAu3O4sOTXMLjZseru5e+TI3cdGttSx+xCxRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLNGZyvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71162C4CEE7;
	Sat, 27 Sep 2025 14:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758984277;
	bh=UfAyved8ZP+UUnl8b5uzwH4uH5DnqHMQiODvQlmvz9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZLNGZyvzewH7M4D9YW9UWPP0hWV1Qnf1w0Z6mdlb7HqWbZdqqjbgFfULcEvm/w7dl
	 zYvDDgKif2Ar8SVlS2lvo5/X1mo2eTANPiK0kxHlbT8mX/l/cfa1FNPXWUvAiAfwM/
	 b0vNnlfET8W3qmWzLDm2py0ntnC7BAiNON4b5ZVmfVUfmGBKTGHPFK8Ds40vKCm/R9
	 4bmy4746a52GVxthnvov5a5SKMynXX9Vp+Q4J7UD1Y5GyJ3dFtL1uT9ZWWPDlVoUmy
	 CfQHOKaF3oNt0Ux1/lplTD8CzXtNkYOuRncKE+RfmJ5NFvq37zAS6C2n7w6UI6QyYS
	 wWOVxgTdslg1Q==
Date: Sat, 27 Sep 2025 15:44:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <Jianping.Shen@de.bosch.com>
Cc: <lars@metafoo.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
 <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <Christian.Lorenz3@de.bosch.com>, <Ulrike.Frauendorf@de.bosch.com>,
 <Kai.Dolde@de.bosch.com>
Subject: Re: [PATCH v4 2/2] iio: imu: smi330: Add driver
Message-ID: <20250927154428.381df54e@jic23-huawei>
In-Reply-To: <20250915160934.89208-3-Jianping.Shen@de.bosch.com>
References: <20250915160934.89208-1-Jianping.Shen@de.bosch.com>
	<20250915160934.89208-3-Jianping.Shen@de.bosch.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 18:09:34 +0200
<Jianping.Shen@de.bosch.com> wrote:

> From: Jianping Shen <Jianping.Shen@de.bosch.com>
> 
> Add the iio driver for bosch imu smi330. The smi330 is a combined
> three axis angular rate and three axis acceleration sensor.
> 
> Signed-off-by: Jianping Shen <Jianping.Shen@de.bosch.com>

Applied to the testing branch of iio.git (which will be rebased on rc1)
with following diff;

diff --git a/drivers/iio/imu/smi330/Kconfig b/drivers/iio/imu/smi330/Kconfig
index 95b06f2317e8..915a5b6fb974 100644
--- a/drivers/iio/imu/smi330/Kconfig
+++ b/drivers/iio/imu/smi330/Kconfig
@@ -7,6 +7,7 @@ config SMI330
        tristate "Bosch Sensor SMI330 Inertial Measurement Unit"
        select IIO_BUFFER
        select IIO_TRIGGERED_BUFFER
+       depends on I2C || SPI
        help
          Enable support for the Bosch SMI330 IMU.
 
diff --git a/drivers/iio/imu/smi330/smi330_core.c b/drivers/iio/imu/smi330/smi330_core.c
index fdbc251d1f60..8571414d2a55 100644
--- a/drivers/iio/imu/smi330/smi330_core.c
+++ b/drivers/iio/imu/smi330/smi330_core.c
@@ -491,8 +491,6 @@ static int smi330_read_avail(struct iio_dev *indio_dev,
        default:
                return -EINVAL;
        }
-
-       return -EINVAL;
 }
 
 static int smi330_read_raw(struct iio_dev *indio_dev,

> diff --git a/drivers/iio/imu/smi330/Kconfig b/drivers/iio/imu/smi330/Kconfig
> new file mode 100644
> index 00000000000..95b06f2317e
> --- /dev/null
> +++ b/drivers/iio/imu/smi330/Kconfig
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# SMI330 IMU driver
> +#
> +
> +config SMI330
> +	tristate "Bosch Sensor SMI330 Inertial Measurement Unit"
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
Why expose this as an option, whether or not either bus is supported?
At minimum this should be 
	depends on I2C || SPI

Often we just don't make this a selectable symbol though that
complicates the select statements here hence I've just made this tweak.

> +	help
> +	  Enable support for the Bosch SMI330 IMU.
> +
> +	  The driver supports different operation modes like polling,
> +	  data ready or fifo mode and advanced features like no-motion,
> +	  no-motion, any-motion or tilt detection.
> +
> +config SMI330_I2C
> +	tristate "Bosch SMI330 I2C driver"
> +	depends on I2C
> +	select SMI330
> +	select REGMAP_I2C
> +	help
> +	  Enable support for the Bosch SMI330 6-Axis IMU connected to I2C
> +	  interface.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called smi330_i2c.
> +
> +config SMI330_SPI
> +	tristate "Bosch SMI330 SPI driver"
> +	depends on SPI
> +	select SMI330
> +	select REGMAP_SPI
> +	help
> +	  Enable support for the Bosch SMI330 6-Axis IMU connected to SPI
> +	  interface.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called smi330_spi.


> diff --git a/drivers/iio/imu/smi330/smi330_core.c b/drivers/iio/imu/smi330/smi330_core.c
> new file mode 100644
> index 00000000000..fdbc251d1f6
> --- /dev/null
> +++ b/drivers/iio/imu/smi330/smi330_core.c

> +/* Register mask */
> +#define SMI330_CHIP_ID_MASK GENMASK(7, 0)
> +#define SMI330_ERR_FATAL_MASK BIT(0)
> +#define SMI330_ERR_ACC_CONF_MASK BIT(5)
> +#define SMI330_ERR_GYR_CONF_MASK BIT(6)
> +#define SMI330_STATUS_POR_MASK BIT(0)
> +#define SMI330_INT_STATUS_ACC_GYR_DRDY_MASK GENMASK(13, 12)
> +#define SMI330_CFG_ODR_MASK GENMASK(3, 0)
> +#define SMI330_CFG_RANGE_MASK GENMASK(6, 4)
> +#define SMI330_CFG_BW_MASK BIT(7)
> +#define SMI330_CFG_AVG_NUM_MASK GENMASK(10, 8)
> +#define SMI330_CFG_MODE_MASK GENMASK(14, 12)
> +#define SMI330_IO_INT_CTRL_INT1_MASK GENMASK(2, 0)
> +#define SMI330_IO_INT_CTRL_INT2_MASK GENMASK(10, 8)
> +#define SMI330_INT_CONF_LATCH_MASK BIT(0)
> +#define SMI330_INT_MAP2_ACC_DRDY_MASK GENMASK(11, 10)
> +#define SMI330_INT_MAP2_GYR_DRDY_MASK GENMASK(9, 8)
> +#define SMI330_INT_MAP2_DRDY_MASK \
> +	(SMI330_INT_MAP2_ACC_DRDY_MASK | SMI330_INT_MAP2_GYR_DRDY_MASK)

Trivial but I'm not sure this composite mask is useful. I would just
have used the two masks inline. I didn't bother modifying this though.



> +
> +static int smi330_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, const int **vals,
> +			     int *type, int *length, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_ACCEL) {
> +			*vals = smi330_accel_scale_attr.vals;
> +			*length = smi330_accel_scale_attr.len;
> +			*type = smi330_accel_scale_attr.type;
> +		} else {
> +			*vals = smi330_gyro_scale_attr.vals;
> +			*length = smi330_gyro_scale_attr.len;
> +			*type = smi330_gyro_scale_attr.type;
> +		}
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*vals = smi330_average_attr.vals;
> +		*length = smi330_average_attr.len;
> +		*type = smi330_average_attr.type;
> +		*type = IIO_VAL_INT;
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		*vals = smi330_bandwidth_attr.vals;
> +		*length = smi330_bandwidth_attr.len;
> +		*type = smi330_bandwidth_attr.type;
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals = smi330_odr_attr.vals;
> +		*length = smi330_odr_attr.len;
> +		*type = smi330_odr_attr.type;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +
Unreachable code. I'm a bit surprised the compiler didn't moan about this.

> +	return -EINVAL;
> +}

