Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8E349F37E
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2019 21:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbfH0Tvq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Aug 2019 15:51:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbfH0Tvq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 27 Aug 2019 15:51:46 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CDB32184D;
        Tue, 27 Aug 2019 19:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566935505;
        bh=mZWdBn80vDAA7EgVKfQbHhOcALq9Nj/AoyXJHUkpyx8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VjH+NdR8Cw0izCRb+FrEY9UaFb0DwdBgweOI5EHVPzJO+ZS9CyGJ/vbeGHo032UdO
         cDQhp1GYWExDoQ2HHgqIJC+gPHSfbZYct9dkH3aoR4oCFz4K78qhJe1fGJ3APZL564
         Zu21bq1CCl5MroTw3iciVPdiWZwYLCQc4JERZHuE=
Date:   Mon, 26 Aug 2019 09:11:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     lorenzo.bianconi83@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v5 2/4] iio: imu: st_lsm6sdx: move register definitions
 to sensor_settings struct
Message-ID: <20190826091127.14090812@archlinux>
In-Reply-To: <20190821132520.28225-3-martin.kepplinger@puri.sm>
References: <20190821132520.28225-1-martin.kepplinger@puri.sm>
        <20190821132520.28225-3-martin.kepplinger@puri.sm>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 21 Aug 2019 15:25:18 +0200
Martin Kepplinger <martin.kepplinger@puri.sm> wrote:

> Move some register definitions to the per-device array of struct
> st_lsm6dsx_sensor_settings in order to simplify adding new sensor
> devices to the driver.
> 
> Also, remove completely unused register definitions.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it,

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  6 ++++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 31 ++++++++++++++------
>  2 files changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 055e52dec36a..090b7bd3c5b0 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -203,6 +203,9 @@ struct st_lsm6dsx_ext_dev_settings {
>  /**
>   * struct st_lsm6dsx_settings - ST IMU sensor settings
>   * @wai: Sensor WhoAmI default value.
> + * @int1_addr: Control Register address for INT1
> + * @int2_addr: Control Register address for INT2
> + * @reset_addr: register address for reset/reboot
>   * @max_fifo_size: Sensor max fifo length in FIFO words.
>   * @id: List of hw id/device name supported by the driver configuration.
>   * @channels: IIO channels supported by the device.
> @@ -216,6 +219,9 @@ struct st_lsm6dsx_ext_dev_settings {
>   */
>  struct st_lsm6dsx_settings {
>  	u8 wai;
> +	u8 int1_addr;
> +	u8 int2_addr;
> +	u8 reset_addr;
>  	u16 max_fifo_size;
>  	struct {
>  		enum st_lsm6dsx_hw_id hw_id;
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 0aa93b45d772..1b46d9dc2089 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -49,17 +49,12 @@
>  
>  #include "st_lsm6dsx.h"
>  
> -#define ST_LSM6DSX_REG_INT1_ADDR		0x0d
> -#define ST_LSM6DSX_REG_INT2_ADDR		0x0e
>  #define ST_LSM6DSX_REG_FIFO_FTH_IRQ_MASK	BIT(3)
>  #define ST_LSM6DSX_REG_WHOAMI_ADDR		0x0f
> -#define ST_LSM6DSX_REG_RESET_ADDR		0x12
>  #define ST_LSM6DSX_REG_RESET_MASK		BIT(0)
>  #define ST_LSM6DSX_REG_BOOT_MASK		BIT(7)
>  #define ST_LSM6DSX_REG_BDU_ADDR			0x12
>  #define ST_LSM6DSX_REG_BDU_MASK			BIT(6)
> -#define ST_LSM6DSX_REG_INT2_ON_INT1_ADDR	0x13
> -#define ST_LSM6DSX_REG_INT2_ON_INT1_MASK	BIT(5)
>  
>  static const struct iio_chan_spec st_lsm6dsx_acc_channels[] = {
>  	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x28, IIO_MOD_X, 0),
> @@ -78,6 +73,9 @@ static const struct iio_chan_spec st_lsm6dsx_gyro_channels[] = {
>  static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  	{
>  		.wai = 0x69,
> +		.int1_addr = 0x0d,
> +		.int2_addr = 0x0e,
> +		.reset_addr = 0x12,
>  		.max_fifo_size = 1365,
>  		.id = {
>  			{
> @@ -187,6 +185,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  	},
>  	{
>  		.wai = 0x69,
> +		.int1_addr = 0x0d,
> +		.int2_addr = 0x0e,
> +		.reset_addr = 0x12,
>  		.max_fifo_size = 682,
>  		.id = {
>  			{
> @@ -296,6 +297,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  	},
>  	{
>  		.wai = 0x6a,
> +		.int1_addr = 0x0d,
> +		.int2_addr = 0x0e,
> +		.reset_addr = 0x12,
>  		.max_fifo_size = 682,
>  		.id = {
>  			{
> @@ -414,6 +418,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  	},
>  	{
>  		.wai = 0x6c,
> +		.int1_addr = 0x0d,
> +		.int2_addr = 0x0e,
> +		.reset_addr = 0x12,
>  		.max_fifo_size = 512,
>  		.id = {
>  			{
> @@ -544,6 +551,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  	},
>  	{
>  		.wai = 0x6b,
> +		.int1_addr = 0x0d,
> +		.int2_addr = 0x0e,
> +		.reset_addr = 0x12,
>  		.max_fifo_size = 512,
>  		.id = {
>  			{
> @@ -645,6 +655,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  	},
>  	{
>  		.wai = 0x6b,
> +		.int1_addr = 0x0d,
> +		.int2_addr = 0x0e,
> +		.reset_addr = 0x12,
>  		.max_fifo_size = 512,
>  		.id = {
>  			{
> @@ -1172,10 +1185,10 @@ static int st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw, u8 *drdy_reg)
>  
>  	switch (drdy_pin) {
>  	case 1:
> -		*drdy_reg = ST_LSM6DSX_REG_INT1_ADDR;
> +		*drdy_reg = hw->settings->int1_addr;
>  		break;
>  	case 2:
> -		*drdy_reg = ST_LSM6DSX_REG_INT2_ADDR;
> +		*drdy_reg = hw->settings->int2_addr;
>  		break;
>  	default:
>  		dev_err(hw->dev, "unsupported data ready pin\n");
> @@ -1275,7 +1288,7 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
>  	int err;
>  
>  	/* device sw reset */
> -	err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_RESET_ADDR,
> +	err = regmap_update_bits(hw->regmap, hw->settings->reset_addr,
>  				 ST_LSM6DSX_REG_RESET_MASK,
>  				 FIELD_PREP(ST_LSM6DSX_REG_RESET_MASK, 1));
>  	if (err < 0)
> @@ -1284,7 +1297,7 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
>  	msleep(50);
>  
>  	/* reload trimming parameter */
> -	err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_RESET_ADDR,
> +	err = regmap_update_bits(hw->regmap, hw->settings->reset_addr,
>  				 ST_LSM6DSX_REG_BOOT_MASK,
>  				 FIELD_PREP(ST_LSM6DSX_REG_BOOT_MASK, 1));
>  	if (err < 0)

