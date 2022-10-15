Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E045FFB15
	for <lists+linux-iio@lfdr.de>; Sat, 15 Oct 2022 17:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiJOPqk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Oct 2022 11:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJOPqj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Oct 2022 11:46:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7363922BFD
        for <linux-iio@vger.kernel.org>; Sat, 15 Oct 2022 08:46:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A9A060DE8
        for <linux-iio@vger.kernel.org>; Sat, 15 Oct 2022 15:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C66C433C1;
        Sat, 15 Oct 2022 15:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665848797;
        bh=9XmXs3V1vP07yD0XegpKU0nzTYiYdz/L3alBOn22oPY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pmXsqL1q5klqOUh9EQlGLBGqEXvKuHAhC1eJQURXLuXyfSspJLz/Q1ROfahevR7Ti
         o9q7MJ6fFIUin9JCk8YJEO6HNVC/bXzUjmMdgrpsRlKiueHzL8lVniagmQlV6eg6ZQ
         HYoLEasIOIgBWC8eqKauJzLnlilRN3cZw9XF62uTnigOFnS9AwweByNen8/CIUGHg4
         WLnYOvEcssz1/m3cgjT0GaZHnxEvfzD43BcpBx7LsaQbPOHfPL5Vg3GTKjYUPs8SMp
         n7/mf4SEvTxVI/mUeTE+Wq/3ThWmy9JNjVtaLDwssDBDBW4Gj4ygFNjv1TxOQWIHm5
         xFmR1Rd5cE6HA==
Date:   Sat, 15 Oct 2022 16:47:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: introduce
 st_lsm6dsx_device_set_enable routine
Message-ID: <20221015164703.11ea5783@jic23-huawei>
In-Reply-To: <e3fbe5d4a3bed41130908669f745f78c8505cf47.1665399959.git.lorenzo@kernel.org>
References: <e3fbe5d4a3bed41130908669f745f78c8505cf47.1665399959.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 10 Oct 2022 13:07:26 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Introduce st_lsm6dsx_device_set_enable utility routine and remove
> duplicated code used to enable/disable sensors
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied, thanks,


> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        | 11 +++++++++++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 14 +++-----------
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 14 ++------------
>  3 files changed, 16 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 6b57d47be69e..d3a4e21bc114 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -509,6 +509,17 @@ st_lsm6dsx_get_mount_matrix(const struct iio_dev *iio_dev,
>  	return &hw->orientation;
>  }
>  
> +static inline int
> +st_lsm6dsx_device_set_enable(struct st_lsm6dsx_sensor *sensor, bool enable)
> +{
> +	if (sensor->id == ST_LSM6DSX_ID_EXT0 ||
> +	    sensor->id == ST_LSM6DSX_ID_EXT1 ||
> +	    sensor->id == ST_LSM6DSX_ID_EXT2)
> +		return st_lsm6dsx_shub_set_enable(sensor, enable);
> +
> +	return st_lsm6dsx_sensor_set_enable(sensor, enable);
> +}
> +
>  static const
>  struct iio_chan_spec_ext_info __maybe_unused st_lsm6dsx_accel_ext_info[] = {
>  	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, st_lsm6dsx_get_mount_matrix),
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index e49f2d120ed3..48fe6a45671b 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -673,17 +673,9 @@ int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable)
>  			goto out;
>  	}
>  
> -	if (sensor->id == ST_LSM6DSX_ID_EXT0 ||
> -	    sensor->id == ST_LSM6DSX_ID_EXT1 ||
> -	    sensor->id == ST_LSM6DSX_ID_EXT2) {
> -		err = st_lsm6dsx_shub_set_enable(sensor, enable);
> -		if (err < 0)
> -			goto out;
> -	} else {
> -		err = st_lsm6dsx_sensor_set_enable(sensor, enable);
> -		if (err < 0)
> -			goto out;
> -	}
> +	err = st_lsm6dsx_device_set_enable(sensor, enable);
> +	if (err < 0)
> +		goto out;
>  
>  	err = st_lsm6dsx_set_fifo_odr(sensor, enable);
>  	if (err < 0)
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index f8bbb005718e..6af2e905c161 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -2317,12 +2317,7 @@ static int st_lsm6dsx_suspend(struct device *dev)
>  			continue;
>  		}
>  
> -		if (sensor->id == ST_LSM6DSX_ID_EXT0 ||
> -		    sensor->id == ST_LSM6DSX_ID_EXT1 ||
> -		    sensor->id == ST_LSM6DSX_ID_EXT2)
> -			err = st_lsm6dsx_shub_set_enable(sensor, false);
> -		else
> -			err = st_lsm6dsx_sensor_set_enable(sensor, false);
> +		err = st_lsm6dsx_device_set_enable(sensor, false);
>  		if (err < 0)
>  			return err;
>  
> @@ -2353,12 +2348,7 @@ static int st_lsm6dsx_resume(struct device *dev)
>  		if (!(hw->suspend_mask & BIT(sensor->id)))
>  			continue;
>  
> -		if (sensor->id == ST_LSM6DSX_ID_EXT0 ||
> -		    sensor->id == ST_LSM6DSX_ID_EXT1 ||
> -		    sensor->id == ST_LSM6DSX_ID_EXT2)
> -			err = st_lsm6dsx_shub_set_enable(sensor, true);
> -		else
> -			err = st_lsm6dsx_sensor_set_enable(sensor, true);
> +		err = st_lsm6dsx_device_set_enable(sensor, true);
>  		if (err < 0)
>  			return err;
>  

