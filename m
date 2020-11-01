Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163C72A21A3
	for <lists+linux-iio@lfdr.de>; Sun,  1 Nov 2020 21:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgKAU4p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Nov 2020 15:56:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:38544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726848AbgKAU4o (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Nov 2020 15:56:44 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B09A21556;
        Sun,  1 Nov 2020 20:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604264204;
        bh=dsMa3TCXszWbvbRQc/KWBwFjksO2n2oX+X3UrQ9io1U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KJsZBsocwXu53N4e5mNzaArw8JTfUvh7dgrhY4Q+U5K4grQ/wAQ2W3cflw9SLhjtx
         oMynnfwTUmWkUfjcQ8r/kir7DCYFC6hjDT1jrOuXeAJGQ3UNoi93+PCGc+n7RFuePi
         tGprF6eSVR+VOO0mUZnLnKDyH+ljFw4EopjKIksY=
Date:   Sun, 1 Nov 2020 20:56:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: st_lsm6dsx: set 10ms as min shub slave
 timeout
Message-ID: <20201101205640.1fbbceaa@archlinux>
In-Reply-To: <a69c8236bf16a1569966815ed71710af2722ed7d.1604247274.git.lorenzo@kernel.org>
References: <a69c8236bf16a1569966815ed71710af2722ed7d.1604247274.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  1 Nov 2020 17:21:18 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Set 10ms as minimum i2c slave configuration timeout since st_lsm6dsx
> relies on accel ODR for i2c master clock and at high sample rates
> (e.g. 833Hz or 416Hz) the slave sensor occasionally may need more cycles
> than i2c master timeout (2s/833Hz + 1 ~ 3ms) to apply the configuration
> resulting in an uncomplete slave configuration and a constant reading
> from the i2c slave connected to st_lsm6dsx i2c master.
> 
> Fixes: 8f9a5249e3d9 ("iio: imu: st_lsm6dsx: enable 833Hz sample frequency for tagged sensors")
> Fixes: c91c1c844ebd ("iio: imu: st_lsm6dsx: add i2c embedded controller support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied and marked for stable.

Thanks,

Jonathan

> ---
> Changes since v1:
> - improve commit log
> - add missing Fixes tags
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> index 8c8d8870ca07..99562ba85ee4 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> @@ -156,11 +156,13 @@ static const struct st_lsm6dsx_ext_dev_settings st_lsm6dsx_ext_dev_table[] = {
>  static void st_lsm6dsx_shub_wait_complete(struct st_lsm6dsx_hw *hw)
>  {
>  	struct st_lsm6dsx_sensor *sensor;
> -	u32 odr;
> +	u32 odr, timeout;
>  
>  	sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
>  	odr = (hw->enable_mask & BIT(ST_LSM6DSX_ID_ACC)) ? sensor->odr : 12500;
> -	msleep((2000000U / odr) + 1);
> +	/* set 10ms as minimum timeout for i2c slave configuration */
> +	timeout = max_t(u32, 2000000U / odr + 1, 10);
> +	msleep(timeout);
>  }
>  
>  /*

