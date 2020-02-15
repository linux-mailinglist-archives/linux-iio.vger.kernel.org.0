Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 490C615FFA5
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2020 19:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgBOSXV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Feb 2020 13:23:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:57184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbgBOSXV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Feb 2020 13:23:21 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EA312083B;
        Sat, 15 Feb 2020 18:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581791000;
        bh=oLBrNIOpkMeBqCLr91MQiC6YsStXYnFuTyRY0JN/57g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MF3JJ81FYIY2a5Dl1XGhRUOIckbHXoo4LF9U5F1HsnZ+lXsWBBnc5NY1cfY6CJyBA
         1Kk8qTS7nfNPsMn+6N7w8rzlDns5rfvc3iI7CHhsS7UrLEMbT7gDFjBmn73qQIXbLA
         JkU7TWpWIF2gd8//HgtOuAJRR7xdOAsl1YQPwhCY=
Date:   Sat, 15 Feb 2020 18:23:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH 13/13] iio: imu: inv_mpu6050: temperature only work with
 accel/gyro
Message-ID: <20200215182316.1aecb37e@archlinux>
In-Reply-To: <20200212174048.1034-14-jmaneyrol@invensense.com>
References: <20200212174048.1034-1-jmaneyrol@invensense.com>
        <20200212174048.1034-14-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 Feb 2020 18:40:48 +0100
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> Temperature sensor works correctly only when accel and/or gyro
> is turned on. Prevent polling value if they are not running.
> Anyway it doesn't make sense to use it without sensor engines
> on.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index f698d2aa61f4..3212030cc083 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -597,6 +597,11 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
>  					      chan->channel2, val);
>  		break;
>  	case IIO_TEMP:
> +		/* temperature sensor work only with accel and/or gyro */
> +		if (!st->chip_config.accl_en && !st->chip_config.gyro_en) {
> +			result = -ENOTSUPP;

I'd suggest -EBUSY to indicate that it might work sometime in the future.

> +			goto error_power_off;
> +		}
>  		if (!st->chip_config.temp_en) {
>  			result = inv_mpu6050_switch_engine(st, true,
>  					INV_MPU6050_SENSOR_TEMP);

