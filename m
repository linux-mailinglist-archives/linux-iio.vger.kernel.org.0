Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B31D7167BE7
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 12:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgBULTt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 06:19:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:36090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgBULTs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Feb 2020 06:19:48 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5D5924656;
        Fri, 21 Feb 2020 11:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582283988;
        bh=cw9e2i1oq9esg/Fhj9BxsXYPufoRyCUMHajPESvIULU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DmS3Mflpn6newQL1Y9L6zcjPg39oF7CoNiH5zWf6lqpvxuOP7EOxkCEp99X+6hW9i
         h32de39PoM94dlK2rQtWHKtLaBm/9ONHNY3nu439zXppHZ4PKkZ7ewbHl0/U8iZ5qr
         l06++sluFVpCPjZKNCp1s1QanIEd5qZp9Li0mTlo=
Date:   Fri, 21 Feb 2020 11:19:44 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 02/13] iio: imu: inv_mpu6050: delete useless check
Message-ID: <20200221111944.15246e38@archlinux>
In-Reply-To: <20200219143958.3548-3-jmaneyrol@invensense.com>
References: <20200219143958.3548-1-jmaneyrol@invensense.com>
        <20200219143958.3548-3-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 19 Feb 2020 15:39:47 +0100
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> If we are here it means we have fifo enabled for 1 sensor
> at least. And interrupt is always required for using trigger.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index f9fdf4302a91..d7397705974e 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -123,14 +123,11 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
>  		goto reset_fifo_fail;
>  
>  	/* enable interrupt */
> -	if (st->chip_config.accl_fifo_enable ||
> -	    st->chip_config.gyro_fifo_enable ||
> -	    st->chip_config.magn_fifo_enable) {
> -		result = regmap_write(st->map, st->reg->int_enable,
> -				      INV_MPU6050_BIT_DATA_RDY_EN);
> -		if (result)
> -			return result;
> -	}
> +	result = regmap_write(st->map, st->reg->int_enable,
> +			      INV_MPU6050_BIT_DATA_RDY_EN);
> +	if (result)
> +		return result;
> +
>  	/* enable FIFO reading */
>  	d = st->chip_config.user_ctrl | INV_MPU6050_BIT_FIFO_EN;
>  	result = regmap_write(st->map, st->reg->user_ctrl, d);

