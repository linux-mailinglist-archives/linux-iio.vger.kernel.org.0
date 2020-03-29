Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78782196C31
	for <lists+linux-iio@lfdr.de>; Sun, 29 Mar 2020 11:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgC2Jmo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Mar 2020 05:42:44 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:50880 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbgC2Jmo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Mar 2020 05:42:44 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 65A2B9E747D;
        Sun, 29 Mar 2020 10:42:43 +0100 (BST)
Date:   Sun, 29 Mar 2020 10:42:40 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Jimmy Assarsson <jimmyassarsson@gmail.com>
Cc:     linux-iio@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: imu: st_lsm6dsx: Add sensor hub device
 LIS3MDL
Message-ID: <20200329104240.230b05a9@archlinux>
In-Reply-To: <20200328184519.2302703-1-jimmyassarsson@gmail.com>
References: <20200328184519.2302703-1-jimmyassarsson@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 28 Mar 2020 19:45:19 +0100
Jimmy Assarsson <jimmyassarsson@gmail.com> wrote:

> Add LIS3MDL register map to sensor hub device table.
> Tested with LSM6DSM.
> 
> Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>

Please always repost the entire series.  On this occasion I can find
patch 1 but sometimes it's not so easy :)

Looks fine to me, but lets' leave it on list for a while longer to
see if others wish to comment.

> ---
> Changes in v2:
>   - Use ST_SENSORS_DEFAULT_WAI_ADDRESS
> 
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 64 ++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> index 95ddd19d1aa7..3b983e0cc5ce 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> @@ -28,6 +28,7 @@
>  #include <linux/iio/sysfs.h>
>  #include <linux/bitfield.h>
>  
> +#include <linux/iio/common/st_sensors.h>
>  #include "st_lsm6dsx.h"
>  
>  #define ST_LSM6DSX_SLV_ADDR(n, base)		((base) + (n) * 3)
> @@ -88,6 +89,69 @@ static const struct st_lsm6dsx_ext_dev_settings st_lsm6dsx_ext_dev_table[] = {
>  			.len = 6,
>  		},
>  	},
> +	/* LIS3MDL */
> +	{
> +		.i2c_addr = { 0x1e },
> +		.wai = {
> +			.addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
> +			.val = 0x3d,
> +		},
> +		.id = ST_LSM6DSX_ID_MAGN,
> +		.odr_table = {
> +			.reg = {
> +				.addr = 0x20,
> +				.mask = GENMASK(4, 2),
> +			},
> +			.odr_avl[0] = {  1000, 0x0 },
> +			.odr_avl[1] = {  2000, 0x1 },
> +			.odr_avl[2] = {  3000, 0x2 },
> +			.odr_avl[3] = {  5000, 0x3 },
> +			.odr_avl[4] = { 10000, 0x4 },
> +			.odr_avl[5] = { 20000, 0x5 },
> +			.odr_avl[6] = { 40000, 0x6 },
> +			.odr_avl[7] = { 80000, 0x7 },
> +			.odr_len = 8,
> +		},
> +		.fs_table = {
> +			.reg = {
> +				.addr = 0x21,
> +				.mask = GENMASK(6, 5),
> +			},
> +			.fs_avl[0] = {
> +				.gain = 146,
> +				.val = 0x00,
> +			}, /* 4000 uG/LSB */
> +			.fs_avl[1] = {
> +				.gain = 292,
> +				.val = 0x01,
> +			}, /* 8000 uG/LSB */
> +			.fs_avl[2] = {
> +				.gain = 438,
> +				.val = 0x02,
> +			}, /* 12000 uG/LSB */
> +			.fs_avl[3] = {
> +				.gain = 584,
> +				.val = 0x03,
> +			}, /* 16000 uG/LSB */
> +			.fs_len = 4,
> +		},
> +		.pwr_table = {
> +			.reg = {
> +				.addr = 0x22,
> +				.mask = GENMASK(1, 0),
> +			},
> +			.off_val = 0x2,
> +			.on_val = 0x0,
> +		},
> +		.bdu = {
> +			.addr = 0x24,
> +			.mask = BIT(6),
> +		},
> +		.out = {
> +			.addr = 0x28,
> +			.len = 6,
> +		},
> +	},
>  };
>  
>  static void st_lsm6dsx_shub_wait_complete(struct st_lsm6dsx_hw *hw)

