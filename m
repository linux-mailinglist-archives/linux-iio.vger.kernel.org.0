Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0FDD1298FF
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 17:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfLWQ7q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 11:59:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:44618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfLWQ7p (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 11:59:45 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E334205C9;
        Mon, 23 Dec 2019 16:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577120385;
        bh=6PPQ8r1y2bbEj6jeblJG26OfZwp4KkHIC6CD/38p64E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lKJy2YKmoxYwjAo6uNilnWM3rtO6Zv6M6ArUeXsI6tmn1oRnyZLBPQW6x0mCvgH6h
         1Re7iesvoUFhvmYzjpFAgYkv6oe/clQ1Sn4Sct3I3RTST2A/bNMnhOAzhPMw8K5Dif
         McSQjm0cn2XcwlpDelGAoEPJQbI9suvvvSzk7Gd8=
Date:   Mon, 23 Dec 2019 16:59:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH 3/6] iio: imu: st_lsm6dsx: check if pull_up is located
 in primary page
Message-ID: <20191223165941.507f37b0@archlinux>
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
There was a bit of fuzz on this one given Andy's series merged
in the meantime.  Looks like it went on cleanly but please check.

This has happened in this order because I got a bit swamped so
it was easier to start at newest and go back in time (many
older versions are already superceded). Sorry about that!

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

