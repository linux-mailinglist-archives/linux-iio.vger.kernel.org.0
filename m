Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2EDECF9E
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2019 16:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfKBP6Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 Nov 2019 11:58:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbfKBP6Z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 Nov 2019 11:58:25 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17D1C217D9;
        Sat,  2 Nov 2019 15:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572710304;
        bh=T6m1UkajXitnwCXENVIC9e6Xgw0SuI7lqN1Ew+w8kV4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tGX14JAkjfRQ3aQlh/eDZDewPG7T9R3IL3MzWycM9IQ5fxo6duIi6NSpygJm++ZKz
         SpblczQTHX+rrybyc35bpLnay5lxgMOsaZzStN/mkyNtI4JWZtshL/daI21KkcOk1n
         ycxRHiUm7te7fyH74m6OFGsa0XrFtI09wHmkyrfw=
Date:   Sat, 2 Nov 2019 15:58:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fix ODR check in
 st_lsm6dsx_write_raw
Message-ID: <20191102155820.7186f1f6@archlinux>
In-Reply-To: <eda7fb795fb47c41b6c6d617255cb8eec486c355.1572199100.git.lorenzo@kernel.org>
References: <eda7fb795fb47c41b6c6d617255cb8eec486c355.1572199100.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 27 Oct 2019 19:02:30 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Since st_lsm6dsx i2c master controller relies on accel device as trigger
> and slave devices can run at different ODRs we must select an accel_odr >=
> slave_odr. Report real accel ODR in st_lsm6dsx_check_odr() in order to
> properly set sensor frequency in st_lsm6dsx_write_raw and avoid to
> report unsupported frequency
> 
> Fixes: 6ffb55e5009ff ("iio: imu: st_lsm6dsx: introduce ST_LSM6DSX_ID_EXT sensor ids")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Applied to the fixes-togreg branch of iio.git and marked for stable.
Given time in cycle I 'might' shift this into togreg to go in during the
merge window. 

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 1f28a7733fc0..c53c03ec2423 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1362,8 +1362,7 @@ int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u16 odr, u8 *val)
>  		return -EINVAL;
>  
>  	*val = odr_table->odr_avl[i].val;
> -
> -	return 0;
> +	return odr_table->odr_avl[i].hz;
>  }
>  
>  static u16 st_lsm6dsx_check_odr_dependency(struct st_lsm6dsx_hw *hw, u16 odr,
> @@ -1527,8 +1526,10 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
>  	case IIO_CHAN_INFO_SAMP_FREQ: {
>  		u8 data;
>  
> -		err = st_lsm6dsx_check_odr(sensor, val, &data);
> -		if (!err)
> +		val = st_lsm6dsx_check_odr(sensor, val, &data);
> +		if (val < 0)
> +			err = val;
> +		else
>  			sensor->odr = val;
>  		break;
>  	}

