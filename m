Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFBDD17CE43
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 14:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgCGNCg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 08:02:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:39566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgCGNCg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Mar 2020 08:02:36 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 135B52073C;
        Sat,  7 Mar 2020 13:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583586155;
        bh=WRkLS1JpGafDBF8ElTetOqejbdjYC+1RowszJglB9Y4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mZos1OR/awAfEPwwkFQnU+4jzM+N4AxGZ+C71ggyUSl2dbG7qSujW8RbrzpJE9fI1
         XVGs6mXYMKRfs2aX2e9HKsXST15Fq5RQhTi5nl3j8pn3R8yzIFBM5RWDoQ2Pl+AowR
         ivSLv+aGrWKX0AdH5WipuE84FuCnv2osOdt93xv4=
Date:   Sat, 7 Mar 2020 13:02:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com,
        mario.tesi@st.com, vitor.soares@synopsys.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: disable I3C support during device
 reset
Message-ID: <20200307130232.3baf4c89@archlinux>
In-Reply-To: <7444ee821dd9b1210ce126c317edc3b0c36f9f84.1583090369.git.lorenzo@kernel.org>
References: <7444ee821dd9b1210ce126c317edc3b0c36f9f84.1583090369.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  1 Mar 2020 20:28:03 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Disable MIPI I3C during device reset in order to avoid
> possible races on interrupt line 1. If the first interrupt
> line is asserted during hw reset the device will work in
> I3C-only mode
> 
> Reported-by: Mario Tesi <mario.tesi@st.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Fixes tag?

One trivial thing inline.

Is this something we should be looking to have applied to stable?

Jonathan

> ---
> I have not been able to test this patch on a I3C device, just SPI/I2C
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 ++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 30 ++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index f2113a63721a..dfcbe7c42493 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -266,6 +266,7 @@ struct st_lsm6dsx_ext_dev_settings {
>   * @wai: Sensor WhoAmI default value.
>   * @reset: register address for reset.
>   * @boot: register address for boot.
> + * @i3c_disable:  register address for enabling/disabling I3C (addr + mask).
>   * @bdu: register address for Block Data Update.
>   * @max_fifo_size: Sensor max fifo length in FIFO words.
>   * @id: List of hw id/device name supported by the driver configuration.
> @@ -284,6 +285,7 @@ struct st_lsm6dsx_settings {
>  	u8 wai;
>  	struct st_lsm6dsx_reg reset;
>  	struct st_lsm6dsx_reg boot;
> +	struct st_lsm6dsx_reg i3c_disable;
>  	struct st_lsm6dsx_reg bdu;
>  	u16 max_fifo_size;
>  	struct {
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 84d219ae6aee..b1435c5d2d6d 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -751,6 +751,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			.addr = 0x12,
>  			.mask = BIT(7),
>  		},
> +		.i3c_disable = {
> +			.addr = 0x18,
> +			.mask = BIT(1),
> +		},
>  		.bdu = {
>  			.addr = 0x12,
>  			.mask = BIT(6),
> @@ -1128,6 +1132,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			.addr = 0x12,
>  			.mask = BIT(7),
>  		},
> +		.i3c_disable = {
> +			.addr = 0x18,
> +			.mask = BIT(1),
> +		},
>  		.bdu = {
>  			.addr = 0x12,
>  			.mask = BIT(6),
> @@ -2041,6 +2049,19 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
>  	const struct st_lsm6dsx_reg *reg;
>  	int err;
>  
> +	/* disable MIPI I3C during device reset in order to avoid

comment syntax
/*
 * disable...

> +	 * possible races on interrupt line 1. If the first interrupt
> +	 * line is asserted during hw reset the device will work in
> +	 * I3C-only mode
> +	 */
> +	if (hw->settings->i3c_disable.addr) {
> +		reg = &hw->settings->i3c_disable;
> +		err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> +					 ST_LSM6DSX_SHIFT_VAL(1, reg->mask));
> +		if (err < 0)
> +			return err;
> +	}
> +
>  	/* device sw reset */
>  	reg = &hw->settings->reset;
>  	err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> @@ -2059,6 +2080,15 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
>  
>  	msleep(50);
>  
> +	/* enable MIPI I3C */
> +	if (hw->settings->i3c_disable.addr) {
> +		reg = &hw->settings->i3c_disable;
> +		err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> +					 ST_LSM6DSX_SHIFT_VAL(0, reg->mask));
> +		if (err < 0)
> +			return err;
> +	}
> +
>  	/* enable Block Data Update */
>  	reg = &hw->settings->bdu;
>  	err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,

