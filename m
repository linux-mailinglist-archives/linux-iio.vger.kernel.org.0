Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2755E21B4C1
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jul 2020 14:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGJMKX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jul 2020 08:10:23 -0400
Received: from first.geanix.com ([116.203.34.67]:57342 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbgGJMKW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 10 Jul 2020 08:10:22 -0400
Received: from [192.168.100.99] (xb90f4a16.cust.hiper.dk [185.15.74.22])
        by first.geanix.com (Postfix) with ESMTPSA id A5E6B20248C4;
        Fri, 10 Jul 2020 12:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1594383018; bh=2/2cqHl7yLOMjm8sKNdyYDG0GgOpmM4Z+cE8d8LFtNc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Aewor/G0eOHNtzWzt+R96uxeHN2am0+T2JqjIQZ3eo0aLuX+Fg1ge0tstZ5XiBHgJ
         mez7G3vsVHhPtyoaJTHacAYrqA839TajgZOJKihdfSFlqeVC3Bn2QCuf5+74x+XzRc
         0R3mdVT3LbQGQ+o93hS163fFTK2wl0tftgK0e2YYy3CwtpG327M1u94pGMncU0mrAR
         IcNoLu2TQxoRsAAuvTxMjAljGs6xR+VV577YGB8CDq1QF53N1sDmdCgfz4WaN3ZIRX
         U9S+qyAOw1Y+qmH3fSunzCVz2vVgfWlDno7X+garKulynHIo/9fR/kfwjDF35ULpcf
         ZkV9oMWIi23xQ==
Subject: Re: IIO timestamp get skewed when suspending (st_lsm6dsx)
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <54cb146d-e54e-acae-e89c-075521b8e7dc@geanix.com>
 <20200528210711.GD5419@localhost.localdomain>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <c4272c37-edf3-edf6-f826-87ab86f40f62@geanix.com>
Date:   Fri, 10 Jul 2020 14:10:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200528210711.GD5419@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on ff3d05386fc5
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


>  From f4ea9019d3b6fb1ad80747cf378bf1fbdebd3dd8 Mon Sep 17 00:00:00 2001
> Message-Id: <f4ea9019d3b6fb1ad80747cf378bf1fbdebd3dd8.1590699935.git.lorenzo@kernel.org>
> From: Lorenzo Bianconi <lorenzo@kernel.org>
> Date: Thu, 28 May 2020 23:05:16 +0200
> Subject: [PATCH] iio: imu: st_lsm6dsx: reset hw ts after resume
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  3 +--
>   .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 23 ++++++++++++-------
>   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  2 +-
>   3 files changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index b56df409ed0f..529970195b39 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -436,8 +436,7 @@ int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor,
>   				u16 watermark);
>   int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable);
>   int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw);
> -int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
> -			     enum st_lsm6dsx_fifo_mode fifo_mode);
> +int st_lsm6dsx_resume_fifo(struct st_lsm6dsx_hw *hw);
>   int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw);
>   int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw);
>   int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u32 odr, u8 *val);
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index afd00daeefb2..7de10bd636ea 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -184,8 +184,8 @@ static int st_lsm6dsx_update_decimators(struct st_lsm6dsx_hw *hw)
>   	return err;
>   }
>   
> -int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
> -			     enum st_lsm6dsx_fifo_mode fifo_mode)
> +static int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
> +				    enum st_lsm6dsx_fifo_mode fifo_mode)
>   {
>   	unsigned int data;
>   
> @@ -302,6 +302,18 @@ static int st_lsm6dsx_reset_hw_ts(struct st_lsm6dsx_hw *hw)
>   	return 0;
>   }
>   
> +int st_lsm6dsx_resume_fifo(struct st_lsm6dsx_hw *hw)
> +{
> +	int err;
> +
> +	/* reset hw ts counter */
> +	err = st_lsm6dsx_reset_hw_ts(hw);
> +	if (err < 0)
> +		return err;
> +
> +	return st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
> +}
> +
>   /*
>    * Set max bulk read to ST_LSM6DSX_MAX_WORD_LEN/ST_LSM6DSX_MAX_TAGGED_WORD_LEN
>    * in order to avoid a kmalloc for each bus access
> @@ -675,12 +687,7 @@ int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable)
>   		goto out;
>   
>   	if (fifo_mask) {
> -		/* reset hw ts counter */
> -		err = st_lsm6dsx_reset_hw_ts(hw);
> -		if (err < 0)
> -			goto out;
> -
> -		err = st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
> +		err = st_lsm6dsx_resume_fifo(hw);
>   		if (err < 0)
>   			goto out;
>   	}
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 0b776cb91928..b3a08e3e2359 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -2458,7 +2458,7 @@ static int __maybe_unused st_lsm6dsx_resume(struct device *dev)
>   	}
>   
>   	if (hw->fifo_mask)
> -		err = st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
> +		err = st_lsm6dsx_resume_fifo(hw);
>   
>   	return err;
>   }
Hi Lorenzo,

Will you sent this as a real patch?

/Sean
