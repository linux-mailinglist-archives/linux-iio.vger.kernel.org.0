Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94C2C129905
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 18:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfLWRBM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 12:01:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:45090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfLWRBM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 12:01:12 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA1CF20709;
        Mon, 23 Dec 2019 17:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577120471;
        bh=Ex9uMdXNDVD8eqL/YdsF8Mg8ptZTPOrSYHUTAwRbfIg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eMtDUzUedLu2GRmKHWrmXaxdNcsEOoX9kJZSrwncO0fR1qZxelG/5M+70Em4vUF1A
         K7jj88MRdKHRlsXoklduV/bRfmyHWw6BTFqNv3mL+xFLKs15R+iZTxWOCqxlLy4aGB
         6iltg4Z1e1emaXESA2eyynDWHRivFt3r2cmoBs7A=
Date:   Mon, 23 Dec 2019 17:00:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH 4/6] iio: imu: st_lsm6dsx: check if shub_output reg is
 located in primary page
Message-ID: <20191223170013.0da75bd1@archlinux>
In-Reply-To: <55683f1c690d0d750526eeb10e72abecf452401c.1576341963.git.lorenzo@kernel.org>
References: <cover.1576341963.git.lorenzo@kernel.org>
        <55683f1c690d0d750526eeb10e72abecf452401c.1576341963.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 14 Dec 2019 17:52:57 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Check if the sensor hub output register is located in the primary or in the
> secondary memory page. This is a preliminary patch to support i2c master
> controller on lsm6dsm devices
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  5 +++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 10 +++++--
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 28 +++++++++++---------
>  3 files changed, 28 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index b4bd02df2900..c2d00c3dd044 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -197,7 +197,10 @@ struct st_lsm6dsx_shub_settings {
>  	struct st_lsm6dsx_reg aux_sens;
>  	struct st_lsm6dsx_reg wr_once;
>  	u8 num_ext_dev;
> -	u8 shub_out;
> +	struct {
> +		bool sec_page;
> +		u8 addr;
> +	} shub_out;
>  	u8 slv0_addr;
>  	u8 dw_slv0_addr;
>  	u8 batch_en;
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 6adfc53ef8d0..679831d84d78 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -885,7 +885,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.mask = BIT(6),
>  			},
>  			.num_ext_dev = 3,
> -			.shub_out = 0x02,
> +			.shub_out = {
> +				.sec_page = true,
> +				.addr = 0x02,
> +			},
>  			.slv0_addr = 0x15,
>  			.dw_slv0_addr = 0x21,
>  			.batch_en = BIT(3),
> @@ -1262,7 +1265,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.mask = BIT(6),
>  			},
>  			.num_ext_dev = 3,
> -			.shub_out = 0x02,
> +			.shub_out = {
> +				.sec_page = true,
> +				.addr = 0x02,
> +			},
>  			.slv0_addr = 0x15,
>  			.dw_slv0_addr = 0x21,
>  			.batch_en = BIT(3),
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> index 767482e61a1e..ccc59682cb66 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> @@ -105,20 +105,27 @@ static void st_lsm6dsx_shub_wait_complete(struct st_lsm6dsx_hw *hw)
>   *
>   * Read st_lsm6dsx i2c controller register
>   */
> -static int st_lsm6dsx_shub_read_reg(struct st_lsm6dsx_hw *hw, u8 addr,
> -				    u8 *data, int len)
> +static int
> +st_lsm6dsx_shub_read_reg(struct st_lsm6dsx_hw *hw, u8 *data,
> +			 int len)
>  {
> +	const struct st_lsm6dsx_shub_settings *hub_settings;
>  	int err;
>  
>  	mutex_lock(&hw->page_lock);
>  
> -	err = st_lsm6dsx_set_page(hw, true);
> -	if (err < 0)
> -		goto out;
> +	hub_settings = &hw->settings->shub_settings;
> +	if (hub_settings->shub_out.sec_page) {
> +		err = st_lsm6dsx_set_page(hw, true);
> +		if (err < 0)
> +			goto out;
> +	}
>  
> -	err = regmap_bulk_read(hw->regmap, addr, data, len);
> +	err = regmap_bulk_read(hw->regmap, hub_settings->shub_out.addr,
> +			       data, len);
>  
> -	st_lsm6dsx_set_page(hw, false);
> +	if (hub_settings->shub_out.sec_page)
> +		st_lsm6dsx_set_page(hw, false);
>  out:
>  	mutex_unlock(&hw->page_lock);
>  
> @@ -236,8 +243,7 @@ st_lsm6dsx_shub_read(struct st_lsm6dsx_sensor *sensor, u8 addr,
>  
>  	st_lsm6dsx_shub_wait_complete(hw);
>  
> -	err = st_lsm6dsx_shub_read_reg(hw, hub_settings->shub_out, data,
> -				       len & ST_LS6DSX_READ_OP_MASK);
> +	err = st_lsm6dsx_shub_read_reg(hw, data, len & ST_LS6DSX_READ_OP_MASK);
>  
>  	st_lsm6dsx_shub_master_enable(sensor, false);
>  
> @@ -719,9 +725,7 @@ st_lsm6dsx_shub_check_wai(struct st_lsm6dsx_hw *hw, u8 *i2c_addr,
>  
>  		st_lsm6dsx_shub_wait_complete(hw);
>  
> -		err = st_lsm6dsx_shub_read_reg(hw,
> -					       hub_settings->shub_out,
> -					       &data, sizeof(data));
> +		err = st_lsm6dsx_shub_read_reg(hw, &data, sizeof(data));
>  
>  		st_lsm6dsx_shub_master_enable(sensor, false);
>  

