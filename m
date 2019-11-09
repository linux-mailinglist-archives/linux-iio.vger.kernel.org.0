Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1EBF5F59
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2019 14:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfKINLh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Nov 2019 08:11:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:48508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbfKINLh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Nov 2019 08:11:37 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4604D2077C;
        Sat,  9 Nov 2019 13:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573305096;
        bh=SwwfcQySER+eMgzjeUhtaeoZCSiwy1dhpUGOOmzkUpc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0/QdESNRFBk3AE6JMPXyvFtV9TlCFY4FBuAuURnORBrhMCgF9gedn/i2aMy4JZwEu
         IShK7bHIQY22leg1UB7IzO8lZabHzxeIvZ5V+50XE0jxgnj5a/FJ7cCQcJxoeKu8cX
         ZsLbAKuaO8xzIVSAYlHpmRQL35E1CR/HDWujOj6M=
Date:   Sat, 9 Nov 2019 13:11:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, mario.tesi@st.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: imu: st_lsm6dsx: explicitly define odr
 table size
Message-ID: <20191109131132.09dbcf46@archlinux>
In-Reply-To: <e0fa435a4aca723e320357fc8be8ac27627a8880.1572810064.git.lorenzo@kernel.org>
References: <cover.1572810064.git.lorenzo@kernel.org>
        <e0fa435a4aca723e320357fc8be8ac27627a8880.1572810064.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  3 Nov 2019 20:47:17 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Introduce odr_len in st_lsm6dsx_odr_table_entry data structure in order
> to explicitly define odr table size and support devices with different
> odr table map
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 ++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 27 +++++++++++++++-----
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 12 ++++-----
>  3 files changed, 29 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 37e499fe6bcf..9ffc8e06f73d 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -113,7 +113,9 @@ struct st_lsm6dsx_odr {
>  #define ST_LSM6DSX_ODR_LIST_SIZE	6
>  struct st_lsm6dsx_odr_table_entry {
>  	struct st_lsm6dsx_reg reg;
> +
>  	struct st_lsm6dsx_odr odr_avl[ST_LSM6DSX_ODR_LIST_SIZE];
> +	int odr_len;
>  };
>  
>  struct st_lsm6dsx_fs {
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index c53c03ec2423..2f9396745bc8 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -133,6 +133,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.odr_avl[3] = { 238, 0x04 },
>  				.odr_avl[4] = { 476, 0x05 },
>  				.odr_avl[5] = { 952, 0x06 },
> +				.odr_len = 6,
>  			},
>  			[ST_LSM6DSX_ID_GYRO] = {
>  				.reg = {
> @@ -145,6 +146,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.odr_avl[3] = { 238, 0x04 },
>  				.odr_avl[4] = { 476, 0x05 },
>  				.odr_avl[5] = { 952, 0x06 },
> +				.odr_len = 6,
>  			},
>  		},
>  		.fs_table = {
> @@ -233,6 +235,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.odr_avl[3] = { 104, 0x04 },
>  				.odr_avl[4] = { 208, 0x05 },
>  				.odr_avl[5] = { 416, 0x06 },
> +				.odr_len = 6,
>  			},
>  			[ST_LSM6DSX_ID_GYRO] = {
>  				.reg = {
> @@ -245,6 +248,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.odr_avl[3] = { 104, 0x04 },
>  				.odr_avl[4] = { 208, 0x05 },
>  				.odr_avl[5] = { 416, 0x06 },
> +				.odr_len = 6,
>  			},
>  		},
>  		.fs_table = {
> @@ -397,6 +401,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.odr_avl[3] = { 104, 0x04 },
>  				.odr_avl[4] = { 208, 0x05 },
>  				.odr_avl[5] = { 416, 0x06 },
> +				.odr_len = 6,
>  			},
>  			[ST_LSM6DSX_ID_GYRO] = {
>  				.reg = {
> @@ -409,6 +414,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.odr_avl[3] = { 104, 0x04 },
>  				.odr_avl[4] = { 208, 0x05 },
>  				.odr_avl[5] = { 416, 0x06 },
> +				.odr_len = 6,
>  			},
>  		},
>  		.fs_table = {
> @@ -570,6 +576,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.odr_avl[3] = { 104, 0x04 },
>  				.odr_avl[4] = { 208, 0x05 },
>  				.odr_avl[5] = { 416, 0x06 },
> +				.odr_len = 6,
>  			},
>  			[ST_LSM6DSX_ID_GYRO] = {
>  				.reg = {
> @@ -582,6 +589,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.odr_avl[3] = { 104, 0x04 },
>  				.odr_avl[4] = { 208, 0x05 },
>  				.odr_avl[5] = { 416, 0x06 },
> +				.odr_len = 6,
>  			},
>  		},
>  		.fs_table = {
> @@ -745,6 +753,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.odr_avl[3] = { 104, 0x04 },
>  				.odr_avl[4] = { 208, 0x05 },
>  				.odr_avl[5] = { 416, 0x06 },
> +				.odr_len = 6,
>  			},
>  			[ST_LSM6DSX_ID_GYRO] = {
>  				.reg = {
> @@ -757,6 +766,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.odr_avl[3] = { 104, 0x04 },
>  				.odr_avl[4] = { 208, 0x05 },
>  				.odr_avl[5] = { 416, 0x06 },
> +				.odr_len = 6,
>  			},
>  		},
>  		.fs_table = {
> @@ -940,6 +950,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.odr_avl[3] = { 104, 0x04 },
>  				.odr_avl[4] = { 208, 0x05 },
>  				.odr_avl[5] = { 416, 0x06 },
> +				.odr_len = 6,
>  			},
>  			[ST_LSM6DSX_ID_GYRO] = {
>  				.reg = {
> @@ -952,6 +963,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.odr_avl[3] = { 104, 0x04 },
>  				.odr_avl[4] = { 208, 0x05 },
>  				.odr_avl[5] = { 416, 0x06 },
> +				.odr_len = 6,
>  			},
>  		},
>  		.fs_table = {
> @@ -1115,6 +1127,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.odr_avl[3] = { 104, 0x04 },
>  				.odr_avl[4] = { 208, 0x05 },
>  				.odr_avl[5] = { 416, 0x06 },
> +				.odr_len = 6,
>  			},
>  			[ST_LSM6DSX_ID_GYRO] = {
>  				.reg = {
> @@ -1127,6 +1140,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.odr_avl[3] = { 104, 0x04 },
>  				.odr_avl[4] = { 208, 0x05 },
>  				.odr_avl[5] = { 416, 0x06 },
> +				.odr_len = 6,
>  			},
>  		},
>  		.fs_table = {
> @@ -1350,15 +1364,16 @@ int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u16 odr, u8 *val)
>  	int i;
>  
>  	odr_table = &sensor->hw->settings->odr_table[sensor->id];
> -	for (i = 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++)
> +	for (i = 0; i < odr_table->odr_len; i++) {
>  		/*
>  		 * ext devices can run at different odr respect to
>  		 * accel sensor
>  		 */
>  		if (odr_table->odr_avl[i].hz >= odr)
>  			break;
> +	}
>  
> -	if (i == ST_LSM6DSX_ODR_LIST_SIZE)
> +	if (i == odr_table->odr_len)
>  		return -EINVAL;
>  
>  	*val = odr_table->odr_avl[i].val;
> @@ -1710,13 +1725,13 @@ st_lsm6dsx_sysfs_sampling_frequency_avail(struct device *dev,
>  					  char *buf)
>  {
>  	struct st_lsm6dsx_sensor *sensor = iio_priv(dev_get_drvdata(dev));
> -	enum st_lsm6dsx_sensor_id id = sensor->id;
> -	struct st_lsm6dsx_hw *hw = sensor->hw;
> +	const struct st_lsm6dsx_odr_table_entry *odr_table;
>  	int i, len = 0;
>  
> -	for (i = 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++)
> +	odr_table = &sensor->hw->settings->odr_table[sensor->id];
> +	for (i = 0; i < odr_table->odr_len; i++)
>  		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
> -				 hw->settings->odr_table[id].odr_avl[i].hz);
> +				 odr_table->odr_avl[i].hz);
>  	buf[len - 1] = '\n';
>  
>  	return len;
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> index ea472cf6db7b..e029cc05a17f 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> @@ -55,6 +55,7 @@ static const struct st_lsm6dsx_ext_dev_settings st_lsm6dsx_ext_dev_table[] = {
>  			.odr_avl[1] = {  20, 0x1 },
>  			.odr_avl[2] = {  50, 0x2 },
>  			.odr_avl[3] = { 100, 0x3 },
> +			.odr_len = 4,
>  		},
>  		.fs_table = {
>  			.fs_avl[0] = {
> @@ -323,11 +324,12 @@ st_lsm6dsx_shub_get_odr_val(struct st_lsm6dsx_sensor *sensor,
>  	int i;
>  
>  	settings = sensor->ext_info.settings;
> -	for (i = 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++)
> +	for (i = 0; i < settings->odr_table.odr_len; i++) {
>  		if (settings->odr_table.odr_avl[i].hz == odr)
>  			break;
> +	}
>  
> -	if (i == ST_LSM6DSX_ODR_LIST_SIZE)
> +	if (i == settings->odr_table.odr_len)
>  		return -EINVAL;
>  
>  	*val = settings->odr_table.odr_avl[i].val;
> @@ -537,12 +539,10 @@ st_lsm6dsx_shub_sampling_freq_avail(struct device *dev,
>  	int i, len = 0;
>  
>  	settings = sensor->ext_info.settings;
> -	for (i = 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++) {
> +	for (i = 0; i < settings->odr_table.odr_len; i++) {
>  		u16 val = settings->odr_table.odr_avl[i].hz;
>  
> -		if (val > 0)
> -			len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
> -					 val);
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ", val);
>  	}
>  	buf[len - 1] = '\n';
>  

