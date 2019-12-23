Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB10129904
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 18:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfLWRBK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 12:01:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:45076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfLWRBK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 12:01:10 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 590D720715;
        Mon, 23 Dec 2019 17:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577120470;
        bh=x770dpESEPwRzkbZv3BEF4PpGW3zH/7vwBlJKAdIn+Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZP9m6Jetd7OFoRKwAc3tK9ohw8KavBZ3bIWYKtSl/lTieMesmf+0tBO1QK3a5sR51
         zK9KfNwk5hBSfTKh9UpALcnixzXGsVaX3sXkjobim1dijV9WqaK0n70GRkkEQW+Efh
         /BVAku5/vkNofJa2tICjEL7HJaSBPDvKoSOUmXXg=
Date:   Mon, 23 Dec 2019 16:51:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH 3/6] iio: imu: st_lsm6dsx: check if pull_up is located
 in primary page
Message-ID: <20191223165155.7179f4cd@archlinux>
In-Reply-To: <7fbb267c585384fd39c2abe7e6250fd1c207bdd3.1576341963.git.lorenzo@kernel.org>
References: <cover.1576341963.git.lorenzo@kernel.org>
        <7fbb267c585384fd39c2abe7e6250fd1c207bdd3.1576341963.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 14 Dec 2019 17:52:56 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Check if the pull up register is located in the primary or in the
> secondary memory page. This is a preliminary patch to support i2c master
> controller on lsm6dsm devices
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  6 +++++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 13 +++++++++----
>  2 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 0f8f3fbde67a..b4bd02df2900 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -189,7 +189,11 @@ struct st_lsm6dsx_shub_settings {
>  		u8 addr;
>  		u8 mask;
>  	} master_en;
> -	struct st_lsm6dsx_reg pullup_en;
> +	struct {
> +		bool sec_page;
> +		u8 addr;
> +		u8 mask;
> +	} pullup_en;
>  	struct st_lsm6dsx_reg aux_sens;
>  	struct st_lsm6dsx_reg wr_once;
>  	u8 num_ext_dev;
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index fe1aaaf68a9b..6adfc53ef8d0 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -872,6 +872,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.mask = BIT(2),
>  			},
>  			.pullup_en = {
> +				.sec_page = true,
>  				.addr = 0x14,
>  				.mask = BIT(3),
>  			},
> @@ -1248,6 +1249,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.mask = BIT(2),
>  			},
>  			.pullup_en = {
> +				.sec_page = true,
>  				.addr = 0x14,
>  				.mask = BIT(3),
>  			},
> @@ -1863,16 +1865,19 @@ static int st_lsm6dsx_init_shub(struct st_lsm6dsx_hw *hw)
>  	pdata = (struct st_sensors_platform_data *)hw->dev->platform_data;
>  	if ((np && of_property_read_bool(np, "st,pullups")) ||
>  	    (pdata && pdata->pullups)) {
> -		err = st_lsm6dsx_set_page(hw, true);
> -		if (err < 0)
> -			return err;
> +		if (hub_settings->pullup_en.sec_page) {
> +			err = st_lsm6dsx_set_page(hw, true);
> +			if (err < 0)
> +				return err;
> +		}
>  
>  		data = ST_LSM6DSX_SHIFT_VAL(1, hub_settings->pullup_en.mask);
>  		err = regmap_update_bits(hw->regmap,
>  					 hub_settings->pullup_en.addr,
>  					 hub_settings->pullup_en.mask, data);
>  
> -		st_lsm6dsx_set_page(hw, false);
> +		if (hub_settings->pullup_en.sec_page)
> +			st_lsm6dsx_set_page(hw, false);
>  
>  		if (err < 0)
>  			return err;

