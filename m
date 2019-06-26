Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F02F0571DF
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2019 21:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfFZTgs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Jun 2019 15:36:48 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:36164 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZTgs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Jun 2019 15:36:48 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 2CBCE9E752A;
        Wed, 26 Jun 2019 20:36:45 +0100 (BST)
Date:   Wed, 26 Jun 2019 20:36:44 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: mpu6050: add available scan masks
Message-ID: <20190626203644.43a100c3@archlinux>
In-Reply-To: <20190624145651.24320-1-jmaneyrol@invensense.com>
References: <20190624145651.24320-1-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 24 Jun 2019 14:57:24 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Only allow 3-axis gyro and/or 3-axis accel.
> For icm20602, temp data is mandatory for all conf.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Hi Jean-Baptiste,

Is this policy or a hardware requirement, and hence a fix for
the driver?  If it's a fix, please make that clearer and add
a fixes tag.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 385f14a4d5a7..bfd6d093e54d 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -851,6 +851,13 @@ static const struct iio_chan_spec inv_mpu_channels[] = {
>  	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU6050_SCAN_ACCL_Z),
>  };
>  
> +static const unsigned long inv_mpu_scan_masks[] = {
> +	0x07,	/* 3-axis accel */
> +	0x38,	/* 3-axis gyro */
> +	0x3F,	/* 6-axis accel + gyro */
> +	0,
> +};
> +
>  static const struct iio_chan_spec inv_icm20602_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(INV_ICM20602_SCAN_TIMESTAMP),
>  	{
> @@ -877,6 +884,13 @@ static const struct iio_chan_spec inv_icm20602_channels[] = {
>  	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_ICM20602_SCAN_ACCL_Z),
>  };
>  
> +static const unsigned long inv_icm20602_scan_masks[] = {
> +	0x0F,	/* 3-axis accel + temp (mandatory) */
> +	0x78,	/* 3-axis gyro + temp (mandatory) */
> +	0x7F,	/* 6-axis accel + gyro + temp (mandatory) */
> +	0,
> +};
> +
>  /*
>   * The user can choose any frequency between INV_MPU6050_MIN_FIFO_RATE and
>   * INV_MPU6050_MAX_FIFO_RATE, but only these frequencies are matched by the
> @@ -1136,9 +1150,11 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  	if (chip_type == INV_ICM20602) {
>  		indio_dev->channels = inv_icm20602_channels;
>  		indio_dev->num_channels = ARRAY_SIZE(inv_icm20602_channels);
> +		indio_dev->available_scan_masks = inv_icm20602_scan_masks;
>  	} else {
>  		indio_dev->channels = inv_mpu_channels;
>  		indio_dev->num_channels = ARRAY_SIZE(inv_mpu_channels);
> +		indio_dev->available_scan_masks = inv_mpu_scan_masks;
>  	}
>  
>  	indio_dev->info = &mpu_info;

