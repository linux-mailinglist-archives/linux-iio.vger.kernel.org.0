Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15A32B2FE0
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 14:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbfIOMar (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 08:30:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730448AbfIOMaq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Sep 2019 08:30:46 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 391D42077C;
        Sun, 15 Sep 2019 12:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568550645;
        bh=MgE4lqC/UsmAjY7rXzkP2gCD/7xeoUhH3UW9Vpb2tTQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RNEqCJBXK1JikxgcEpSdLrz6V1b7ERaY1NFiKkPJA2uasnttZOFYBWpy4xuwnpXac
         zdvpy7f8/dstm4N/3LTmEje+g/hiNUYuLk0B/Y4LsrZ+OjVAuFCfJiYZI/kS6iX9ha
         B/d/0v9iqYJ2a0si2w5AyXM4T1zISS3sCFUGV5ew=
Date:   Sun, 15 Sep 2019 13:30:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi83@gmail.com,
        denis.ciocca@st.com, mario.tesi@st.com, armando.visconti@st.com,
        martin@geanix.com
Subject: Re: [PATCH v8 5/5] iio: imu: st_lsm6dsx: add motion report function
 and call from interrupt
Message-ID: <20190915133040.0953ef1a@archlinux>
In-Reply-To: <20190913090708.1442057-6-sean@geanix.com>
References: <20190913090708.1442057-1-sean@geanix.com>
        <20190913090708.1442057-6-sean@geanix.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Sep 2019 11:07:08 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> Report iio motion events to iio subsystem
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
I got to the earlier thread rather late so hadn't replied to your
question on filtering events that haven't been enabled.

Hence I think it's just that change outstanding
+ I want to give Lorenzo time for a final look.

Thanks,

Jonathan

> ---
> Changes since v4:
>  * Updated bitmask as pr Jonathans comments
> 
> Changes since v5:
>  * None
> 
> Changes since v6:
>  * None
> 
> Changes since v7:
>  * None
> 
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  5 ++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 70 ++++++++++++++++++++
>  2 files changed, 75 insertions(+)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 449c2798f7ed..7c50fac7b85c 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -186,6 +186,11 @@ struct st_lsm6dsx_shub_settings {
>  struct st_lsm6dsx_event_settings {
>  	struct st_lsm6dsx_reg enable_reg;
>  	struct st_lsm6dsx_reg wakeup_reg;
> +	u8 wakeup_src_reg;
> +	u8 wakeup_src_status_mask;
> +	u8 wakeup_src_z_mask;
> +	u8 wakeup_src_y_mask;
> +	u8 wakeup_src_x_mask;
>  };
>  
>  enum st_lsm6dsx_ext_sensor_id {
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 80a94335175f..66700c20920d 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -48,6 +48,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/delay.h>
> +#include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/interrupt.h>
> @@ -287,6 +288,11 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.addr = 0x5B,
>  				.mask = GENMASK(5, 0),
>  			},
> +			.wakeup_src_reg = 0x1b,
> +			.wakeup_src_status_mask = BIT(3),
> +			.wakeup_src_z_mask = BIT(0),
> +			.wakeup_src_y_mask = BIT(1),
> +			.wakeup_src_x_mask = BIT(2),
>  		},
>  	},
>  	{
> @@ -412,6 +418,11 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.addr = 0x5B,
>  				.mask = GENMASK(5, 0),
>  			},
> +			.wakeup_src_reg = 0x1b,
> +			.wakeup_src_status_mask = BIT(3),
> +			.wakeup_src_z_mask = BIT(0),
> +			.wakeup_src_y_mask = BIT(1),
> +			.wakeup_src_x_mask = BIT(2),
>  		},
>  	},
>  	{
> @@ -550,6 +561,11 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.addr = 0x5B,
>  				.mask = GENMASK(5, 0),
>  			},
> +			.wakeup_src_reg = 0x1b,
> +			.wakeup_src_status_mask = BIT(3),
> +			.wakeup_src_z_mask = BIT(0),
> +			.wakeup_src_y_mask = BIT(1),
> +			.wakeup_src_x_mask = BIT(2),
>  		},
>  	},
>  	{
> @@ -816,6 +832,11 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.addr = 0x5B,
>  				.mask = GENMASK(5, 0),
>  			},
> +			.wakeup_src_reg = 0x1b,
> +			.wakeup_src_status_mask = BIT(3),
> +			.wakeup_src_z_mask = BIT(0),
> +			.wakeup_src_y_mask = BIT(1),
> +			.wakeup_src_x_mask = BIT(2),
>  		},
>  	},
>  	{
> @@ -970,6 +991,11 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.addr = 0x5B,
>  				.mask = GENMASK(5, 0),
>  			},
> +			.wakeup_src_reg = 0x1b,
> +			.wakeup_src_status_mask = BIT(3),
> +			.wakeup_src_z_mask = BIT(0),
> +			.wakeup_src_y_mask = BIT(1),
> +			.wakeup_src_x_mask = BIT(2),
>  		}
>  	},
>  };
> @@ -1715,6 +1741,38 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
>  	return iio_dev;
>  }
>  
> +void st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw, int data)
> +{
> +	s64 timestamp = iio_get_time_ns(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> +
> +	if (data & hw->settings->event_settings.wakeup_src_z_mask)
> +		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +						  0,
> +						  IIO_MOD_Z,
> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_EITHER),
> +						  timestamp);
> +
> +	if (data & hw->settings->event_settings.wakeup_src_x_mask)
> +		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +						  0,
> +						  IIO_MOD_Y,
> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_EITHER),
> +						  timestamp);
> +
> +	if (data & hw->settings->event_settings.wakeup_src_x_mask)
> +		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +						  0,
> +						  IIO_MOD_X,
> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_EITHER),
> +						  timestamp);
> +}
> +
>  static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
>  {
>  	return IRQ_WAKE_THREAD;
> @@ -1724,6 +1782,18 @@ static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
>  {
>  	struct st_lsm6dsx_hw *hw = private;
>  	int count;
> +	int data, err;
> +
> +	if (hw->enable_event) {
> +		err = regmap_read(hw->regmap,
> +				  hw->settings->event_settings.wakeup_src_reg,
> +				  &data);
> +		if (err < 0)
> +			return IRQ_NONE;
> +
> +		if (data & hw->settings->event_settings.wakeup_src_status_mask)
> +			st_lsm6dsx_report_motion_event(hw, data);
> +	}
>  
>  	mutex_lock(&hw->fifo_lock);
>  	count = hw->settings->fifo_ops.read_fifo(hw);

