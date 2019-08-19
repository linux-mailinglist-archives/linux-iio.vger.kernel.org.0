Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2022921AD
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2019 12:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfHSKvn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Aug 2019 06:51:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5155 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726477AbfHSKvn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 19 Aug 2019 06:51:43 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AA3AA5210CE4990B0764;
        Mon, 19 Aug 2019 18:51:40 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 19 Aug 2019
 18:51:35 +0800
Date:   Mon, 19 Aug 2019 11:51:26 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
CC:     <jic23@kernel.org>, <lorenzo.bianconi@redhat.com>,
        <linux-iio@vger.kernel.org>, <martin.kepplinger@puri.sm>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: introduce update_fifo function
 pointer
Message-ID: <20190819115126.0000185d@huawei.com>
In-Reply-To: <0f40946687ebed533028e2a8eb2bf6756e49b6e1.1566208999.git.lorenzo@kernel.org>
References: <0f40946687ebed533028e2a8eb2bf6756e49b6e1.1566208999.git.lorenzo@kernel.org>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 19 Aug 2019 12:06:05 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Introduce update_fifo routine pointer in st_lsm6dsx_fifo_ops data
> structure since we will need a different update FIFO configuration
> callback adding support for lsm6ds0/lsm9ds1 imu device
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

I'm fine with the patch itself, but would much rather pick this up as a first
patch in the series that makes use of it.  Right now it is an unjustified bit
of refactoring..

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  4 ++++
>  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 19 +++++++++++++++----
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  6 ++++++
>  3 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 4e8e67ae1632..055e52dec36a 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -75,6 +75,7 @@ struct st_lsm6dsx_reg {
>  	u8 mask;
>  };
>  
> +struct st_lsm6dsx_sensor;
>  struct st_lsm6dsx_hw;
>  
>  struct st_lsm6dsx_odr {
> @@ -101,12 +102,14 @@ struct st_lsm6dsx_fs_table_entry {
>  
>  /**
>   * struct st_lsm6dsx_fifo_ops - ST IMU FIFO settings
> + * @update_fifo: Update FIFO configuration callback.
>   * @read_fifo: Read FIFO callback.
>   * @fifo_th: FIFO threshold register info (addr + mask).
>   * @fifo_diff: FIFO diff status register info (addr + mask).
>   * @th_wl: FIFO threshold word length.
>   */
>  struct st_lsm6dsx_fifo_ops {
> +	int (*update_fifo)(struct st_lsm6dsx_sensor *sensor, bool enable);
>  	int (*read_fifo)(struct st_lsm6dsx_hw *hw);
>  	struct {
>  		u8 addr;
> @@ -327,6 +330,7 @@ int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw);
>  int st_lsm6dsx_set_watermark(struct iio_dev *iio_dev, unsigned int val);
>  int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor,
>  				u16 watermark);
> +int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable);
>  int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw);
>  int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
>  			     enum st_lsm6dsx_fifo_mode fifo_mode);
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 2c03a5b80f80..b0f3da1976e4 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -602,9 +602,8 @@ int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw)
>  	return err;
>  }
>  
> -static int st_lsm6dsx_update_fifo(struct iio_dev *iio_dev, bool enable)
> +int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable)
>  {
> -	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
>  	struct st_lsm6dsx_hw *hw = sensor->hw;
>  	int err;
>  
> @@ -676,12 +675,24 @@ static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
>  
>  static int st_lsm6dsx_buffer_preenable(struct iio_dev *iio_dev)
>  {
> -	return st_lsm6dsx_update_fifo(iio_dev, true);
> +	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
> +	struct st_lsm6dsx_hw *hw = sensor->hw;
> +
> +	if (!hw->settings->fifo_ops.update_fifo)
> +		return -ENOTSUPP;
> +
> +	return hw->settings->fifo_ops.update_fifo(sensor, true);
>  }
>  
>  static int st_lsm6dsx_buffer_postdisable(struct iio_dev *iio_dev)
>  {
> -	return st_lsm6dsx_update_fifo(iio_dev, false);
> +	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
> +	struct st_lsm6dsx_hw *hw = sensor->hw;
> +
> +	if (!hw->settings->fifo_ops.update_fifo)
> +		return -ENOTSUPP;
> +
> +	return hw->settings->fifo_ops.update_fifo(sensor, false);
>  }
>  
>  static const struct iio_buffer_setup_ops st_lsm6dsx_buffer_ops = {
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 85824d6739ee..0aa93b45d772 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -154,6 +154,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			},
>  		},
>  		.fifo_ops = {
> +			.update_fifo = st_lsm6dsx_update_fifo,
>  			.read_fifo = st_lsm6dsx_read_fifo,
>  			.fifo_th = {
>  				.addr = 0x06,
> @@ -262,6 +263,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			},
>  		},
>  		.fifo_ops = {
> +			.update_fifo = st_lsm6dsx_update_fifo,
>  			.read_fifo = st_lsm6dsx_read_fifo,
>  			.fifo_th = {
>  				.addr = 0x06,
> @@ -379,6 +381,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			},
>  		},
>  		.fifo_ops = {
> +			.update_fifo = st_lsm6dsx_update_fifo,
>  			.read_fifo = st_lsm6dsx_read_fifo,
>  			.fifo_th = {
>  				.addr = 0x06,
> @@ -490,6 +493,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			},
>  		},
>  		.fifo_ops = {
> +			.update_fifo = st_lsm6dsx_update_fifo,
>  			.read_fifo = st_lsm6dsx_read_tagged_fifo,
>  			.fifo_th = {
>  				.addr = 0x07,
> @@ -616,6 +620,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			},
>  		},
>  		.fifo_ops = {
> +			.update_fifo = st_lsm6dsx_update_fifo,
>  			.read_fifo = st_lsm6dsx_read_tagged_fifo,
>  			.fifo_th = {
>  				.addr = 0x07,
> @@ -719,6 +724,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			},
>  		},
>  		.fifo_ops = {
> +			.update_fifo = st_lsm6dsx_update_fifo,
>  			.read_fifo = st_lsm6dsx_read_tagged_fifo,
>  			.fifo_th = {
>  				.addr = 0x07,


