Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2FBAC634
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2019 13:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbfIGLIe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Sep 2019 07:08:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:32868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfIGLIe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Sep 2019 07:08:34 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23A902178F;
        Sat,  7 Sep 2019 11:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567854512;
        bh=13IkZAD3ztk2id+Bm17NkFpIXukI8LTYSjQzMuQRoGE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nj2SE9bJ5cHKmk/DQuCcKVHcZqnqeir8Q2SPXcKZA5ExiE4823hi9WS6ir+w4kI3G
         gLAHqVNQv93nr9q0u8NH9cstz05hk6jlcyFmhH2qHJD6osIllsoKl6iTWyX0ggSPIF
         mnOFC4NyGq8MEEKZLLYscDIGnuXcxBwhag0mgTFw=
Date:   Sat, 7 Sep 2019 12:08:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi83@gmail.com,
        denis.ciocca@st.com, mario.tesi@st.com, armando.visconti@st.com,
        martin@geanix.com
Subject: Re: [PATCH v4 5/6] iio: imu: st_lsm6dsx: add motion report function
 and call from interrupt
Message-ID: <20190907120828.51834b73@archlinux>
In-Reply-To: <20190906121716.66194-5-sean@geanix.com>
References: <20190906121716.66194-1-sean@geanix.com>
        <20190906121716.66194-5-sean@geanix.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  6 Sep 2019 14:17:15 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> Report iio motion events to iio subsystem
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

I'm confused by a disagreement between the bit mask you have here
and what I'm understanding from the datasheets..

> ---
> Changes since v3:
>  * added wakeup_src_reg and masks to device settings
> 
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  5 ++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 51 ++++++++++++++++++++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index d04473861fba..015b837f366f 100644
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
> index ce467308eadd..470821b54933 100644
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
> @@ -520,6 +521,11 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.addr = 0x5B,
>  				.mask = GENMASK(5, 0),
>  			},
> +			.wakeup_src_reg = 0x1b,
> +			.wakeup_src_status_mask = BIT(4),

Bit 4?  I just checked the LSM6DS3 data sheet and the
Wakeup Event Detection status is bit 3.
Bit 4 is the sleep event status...
Also checked the LSM6DSL.

> +			.wakeup_src_z_mask = BIT(0),
> +			.wakeup_src_y_mask = BIT(1),
> +			.wakeup_src_x_mask = BIT(2),
>  		},
>  	},
>  	{
> @@ -1612,6 +1618,40 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
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
> +
> +	return;
> +}
> +
>  static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
>  {
>  	return IRQ_WAKE_THREAD;
> @@ -1621,6 +1661,17 @@ static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
>  {
>  	struct st_lsm6dsx_hw *hw = private;
>  	int count;
> +	int data, err;
> +
> +	if (hw->enable_event) {
> +		err = regmap_read(hw->regmap,
> +				  hw->settings->event_settings.wakeup_src_reg, &data);
> +		if (err < 0)
> +			return IRQ_NONE;
> +
> +		if (data & hw->settings->event_settings.wakeup_src_status_mask)
> +			st_lsm6dsx_report_motion_event(hw, data);
> +	}
>  
>  	mutex_lock(&hw->fifo_lock);
>  	count = hw->settings->fifo_ops.read_fifo(hw);

