Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022A51B8829
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 19:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgDYRel (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 13:34:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgDYRek (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 13:34:40 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1020420704;
        Sat, 25 Apr 2020 17:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587836080;
        bh=n/c6G2+pz7iSd0hluR8q+ZQxALEQt3pvWT6Lzkx/HZc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gEtD0dS9tKbwL2+xWiTPKjw+xgmDKDM4DOGN0YzGiRk0f18odhsap1Yp/PCpxhnXQ
         OZT7+4DrLUU580m3qoY7erW6HOoIDdqZR3pCmEQZQ9/5eSvZugzKB7AZdT4t9YoAyS
         4Fu/iATZWKpP4ho4YJ3Za3Pp1qQX1EMZ4IYRNBUQ=
Date:   Sat, 25 Apr 2020 18:34:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: unlock on error in
 st_lsm6dsx_shub_write_raw()
Message-ID: <20200425183436.2d22db77@archlinux>
In-Reply-To: <20200422093811.GA196034@mwanda>
References: <20200422093811.GA196034@mwanda>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Apr 2020 12:38:11 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> We need to release a lock if st_lsm6dsx_check_odr() fails, we can't
> return directly.
> 
> Fixes: 76551a3c3df1 ("iio: imu: st_lsm6dsx: specify slave odr in slv_odr")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Good find.

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> index 64ef07a30726..1cf98195f84d 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> @@ -544,8 +544,10 @@ st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
>  
>  			ref_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
>  			odr = st_lsm6dsx_check_odr(ref_sensor, val, &odr_val);
> -			if (odr < 0)
> -				return odr;
> +			if (odr < 0) {
> +				err = odr;
> +				goto release;
> +			}
>  
>  			sensor->ext_info.slv_odr = val;
>  			sensor->odr = odr;
> @@ -557,6 +559,7 @@ st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
>  		break;
>  	}
>  
> +release:
>  	iio_device_release_direct_mode(iio_dev);
>  
>  	return err;

