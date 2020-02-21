Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59DE0167CD5
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 12:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgBUL4O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 06:56:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:47706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbgBUL4O (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Feb 2020 06:56:14 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4ED72071E;
        Fri, 21 Feb 2020 11:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582286174;
        bh=qG3OqD3qv8toKVrDPTNtTUNP+Bbl9goIhLF0tm5mY08=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fmdZnukweBvzwHhGbnApot6bEtIb0a7o33AXD56Xlz74ooTxCVVKHCsC/5nmLYnCi
         24l6af2mArSkAe64Bb4mdvRZOt2FcaU8Du1fh6aTOyOXH8123dzHXOlrP9ErjOvI1M
         Cc7UODxSQh0iatVSjZE0IN0QnW/IHeiuSpb8XKlI=
Date:   Fri, 21 Feb 2020 11:56:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 13/13] iio: imu: inv_mpu6050: temperature only work
 with accel/gyro
Message-ID: <20200221115610.30c55af4@archlinux>
In-Reply-To: <20200219143958.3548-14-jmaneyrol@invensense.com>
References: <20200219143958.3548-1-jmaneyrol@invensense.com>
        <20200219143958.3548-14-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 19 Feb 2020 15:39:58 +0100
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> Temperature sensor works correctly only when accel and/or gyro
> is turned on. Prevent polling value if they are not running.
> Anyway it doesn't make sense to use it without sensor engines
> on.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Applied.

Thanks

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 750fbc2614f0..94a989368b94 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -597,6 +597,11 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
>  					      chan->channel2, val);
>  		break;
>  	case IIO_TEMP:
> +		/* temperature sensor work only with accel and/or gyro */
> +		if (!st->chip_config.accl_en && !st->chip_config.gyro_en) {
> +			result = -EBUSY;
> +			goto error_power_off;
> +		}
>  		if (!st->chip_config.temp_en) {
>  			result = inv_mpu6050_switch_engine(st, true,
>  					INV_MPU6050_SENSOR_TEMP);

