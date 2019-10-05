Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C78BCC9AA
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 13:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfJELl1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 07:41:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbfJELl1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 07:41:27 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFE602133F;
        Sat,  5 Oct 2019 11:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570275686;
        bh=kWBfZiAOvnZwaC+Eb0oiBPfmmdqAVIP/RJh7Z5bi+Nw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=joV0pyC4J49EKpcMuSZhh69LzPQYzCWIFlJiogVeEizrjVVb3MKj67KJqWrS89X6B
         A4Jz9w2IY6H1jIA/nqLDTWB5SdCYsyIBp0YQeW3sZk1AQxuPnwTRONboDFXqgkwqq9
         MlCcqh5hY+xdBqQ8qev5rSY9lszxKxJxOJJJF8xQ=
Date:   Sat, 5 Oct 2019 12:41:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi83@gmail.com,
        denis.ciocca@st.com, mario.tesi@st.com, armando.visconti@st.com,
        martin@geanix.com
Subject: Re: [PATCH v10 5/5] iio: imu: st_lsm6dsx: add motion report
 function and call from interrupt
Message-ID: <20191005124121.2f3181a5@archlinux>
In-Reply-To: <20190916135630.2211714-5-sean@geanix.com>
References: <20190916135630.2211714-1-sean@geanix.com>
        <20190916135630.2211714-5-sean@geanix.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Sep 2019 15:56:30 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> Report iio motion events to iio subsystem and filter motion events.
> Wakeup will still be on all channels as it's not possible to do the filtering
> in hw.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
*report_motion_event not declared.  I've added the missing static.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

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
> Changes since v8:
>  * None
> 
> Changes since v9:
>  * Merged with "iio: imu: st_lsm6dsx: filter motion events in driver"
> 
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  5 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 97 +++++++++++++++++++-
>  2 files changed, 98 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 6b0ba48394eb..fd02d0e184f3 100644
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
> index 6b03c50f4732..f4f71cf4187a 100644
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
> @@ -1334,7 +1360,7 @@ static int st_lsm6dsx_read_event_config(struct iio_dev *iio_dev,
>  	if (type != IIO_EV_TYPE_THRESH)
>  		return -EINVAL;
>  
> -	return hw->enable_event;
> +	return !!(hw->enable_event & BIT(chan->channel2));
>  }
>  
>  static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
> @@ -1345,13 +1371,28 @@ static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
>  {
>  	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
>  	struct st_lsm6dsx_hw *hw = sensor->hw;
> +	u8 enable_event;
>  	int err = 0;
>  
>  	if (type != IIO_EV_TYPE_THRESH)
>  		return -EINVAL;
>  
> -	/* do not enable events if they are already enabled */
> -	if (state && hw->enable_event)
> +	if (state) {
> +		enable_event = hw->enable_event | BIT(chan->channel2);
> +
> +		/* do not enable events if they are already enabled */
> +		if (hw->enable_event)
> +			goto out;
> +	} else {
> +		enable_event = hw->enable_event & ~BIT(chan->channel2);
> +
> +		/* only turn off sensor if no events is enabled */
> +		if (enable_event)
> +			goto out;
> +	}
> +
> +	/* stop here if no changes have been made */
> +	if (hw->enable_event == enable_event)
>  		return 0;
>  
>  	err = st_lsm6dsx_event_setup(hw, state);
> @@ -1362,7 +1403,8 @@ static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
>  	if (err < 0)
>  		return err;
>  
> -	hw->enable_event = state;
> +out:
> +	hw->enable_event = enable_event;
>  
>  	return 0;
>  }
> @@ -1715,10 +1757,57 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
>  	return iio_dev;
>  }
>  
> +void st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw, int data)
> +{
> +	s64 timestamp = iio_get_time_ns(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> +
> +	if ((data & hw->settings->event_settings.wakeup_src_z_mask) &&
> +	    (hw->enable_event & BIT(IIO_MOD_Z)))
> +		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +						  0,
> +						  IIO_MOD_Z,
> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_EITHER),
> +						  timestamp);
> +
> +	if ((data & hw->settings->event_settings.wakeup_src_y_mask) &&
> +	    (hw->enable_event & BIT(IIO_MOD_Y)))
> +		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +						  0,
> +						  IIO_MOD_Y,
> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_EITHER),
> +						  timestamp);
> +
> +	if ((data & hw->settings->event_settings.wakeup_src_x_mask) &&
> +	    (hw->enable_event & BIT(IIO_MOD_X)))
> +		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +						  0,
> +						  IIO_MOD_X,
> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_EITHER),
> +						  timestamp);
> +}
> +
>  static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
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

