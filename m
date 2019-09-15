Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB1FB3040
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 15:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731486AbfIONfy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 09:35:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfIONfy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Sep 2019 09:35:54 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ED44214AF;
        Sun, 15 Sep 2019 13:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568554553;
        bh=seJejuqCoVFluIlHfFOQY1wiPXsTev962AOY5Osb9bE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gPavOKQc5hdCI1RtEzl6L8vRZuhHUUROy1HY9D/5irW3/LPy2zn8hmBfgxcjCtv0a
         lJUwOVaiaohBxrRMx80peTqPROQB9ubdP5zwKTtlXWP42gQCjiYDWdc5lRgMWhVxIT
         1Bl5jgAT3qSBn2/g2BRI+UHkPaQuP3mrwXWD9jcg=
Date:   Sun, 15 Sep 2019 14:35:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: Re: [PATCH v8 5/5] iio: imu: st_lsm6dsx: add motion report function
 and call from interrupt
Message-ID: <20190915143548.25383eb4@archlinux>
In-Reply-To: <85c144b0-1e73-9fcf-853a-820a71d86b1a@geanix.com>
References: <20190913090708.1442057-1-sean@geanix.com>
        <20190913090708.1442057-6-sean@geanix.com>
        <20190915133040.0953ef1a@archlinux>
        <20190915130508.GB15634@lore-desk-wlan.lan>
        <20190915141808.6ca04f0f@archlinux>
        <85c144b0-1e73-9fcf-853a-820a71d86b1a@geanix.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 Sep 2019 15:22:44 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> On 15/09/2019 15.18, Jonathan Cameron wrote:
> > On Sun, 15 Sep 2019 15:05:08 +0200
> > Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> >   
> >>> On Fri, 13 Sep 2019 11:07:08 +0200
> >>> Sean Nyekjaer <sean@geanix.com> wrote:
> >>>      
> >>>> Report iio motion events to iio subsystem
> >>>>
> >>>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>  
> >>> I got to the earlier thread rather late so hadn't replied to your
> >>> question on filtering events that haven't been enabled.  
> >>
> >> IIUC, how is possible to filter events? it seems not currently supported in
> >> hw, right?  
> > Filter them in software on their way to userspace.  So you'll get an interrupt
> > either way, but no need to tell userspace about event's it's not interested
> > in.  
> 
> Fine by me, will submit a V9.
> 
> Which one is preferred:
> in_accel_thresh_(x,y,z)_en -> in_accel_thresh_both_en
> or keep in_accel_thresh_(x,y,z)_en and filter them in the driver?
> 
> We would wake on all events either way

I think I slightly prefer filtering in the driver.  Wakeup will
just have to be a bit strange if someone actually doesn't want to wake
based on all axis.

Thanks,

Jonathan

> 
> /Sean
> 
> >>  
> >>>
> >>> Hence I think it's just that change outstanding
> >>> + I want to give Lorenzo time for a final look.  
> >>
> >> Jonathan the series seems fine to me now, there are some leftover nitpicks we can
> >> cover with some follow-up patches.  
> > 
> > Acks/Reviewed-bys?  Let's do this formally!
> > 
> > Jonathan
> >   
> >>
> >> Regards,
> >> Lorenzo
> >>  
> >>>
> >>> Thanks,
> >>>
> >>> Jonathan
> >>>      
> >>>> ---
> >>>> Changes since v4:
> >>>>   * Updated bitmask as pr Jonathans comments
> >>>>
> >>>> Changes since v5:
> >>>>   * None
> >>>>
> >>>> Changes since v6:
> >>>>   * None
> >>>>
> >>>> Changes since v7:
> >>>>   * None
> >>>>
> >>>>   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  5 ++
> >>>>   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 70 ++++++++++++++++++++
> >>>>   2 files changed, 75 insertions(+)
> >>>>
> >>>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> >>>> index 449c2798f7ed..7c50fac7b85c 100644
> >>>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> >>>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> >>>> @@ -186,6 +186,11 @@ struct st_lsm6dsx_shub_settings {
> >>>>   struct st_lsm6dsx_event_settings {
> >>>>   	struct st_lsm6dsx_reg enable_reg;
> >>>>   	struct st_lsm6dsx_reg wakeup_reg;
> >>>> +	u8 wakeup_src_reg;
> >>>> +	u8 wakeup_src_status_mask;
> >>>> +	u8 wakeup_src_z_mask;
> >>>> +	u8 wakeup_src_y_mask;
> >>>> +	u8 wakeup_src_x_mask;
> >>>>   };
> >>>>   
> >>>>   enum st_lsm6dsx_ext_sensor_id {
> >>>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> >>>> index 80a94335175f..66700c20920d 100644
> >>>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> >>>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> >>>> @@ -48,6 +48,7 @@
> >>>>   #include <linux/kernel.h>
> >>>>   #include <linux/module.h>
> >>>>   #include <linux/delay.h>
> >>>> +#include <linux/iio/events.h>
> >>>>   #include <linux/iio/iio.h>
> >>>>   #include <linux/iio/sysfs.h>
> >>>>   #include <linux/interrupt.h>
> >>>> @@ -287,6 +288,11 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
> >>>>   				.addr = 0x5B,
> >>>>   				.mask = GENMASK(5, 0),
> >>>>   			},
> >>>> +			.wakeup_src_reg = 0x1b,
> >>>> +			.wakeup_src_status_mask = BIT(3),
> >>>> +			.wakeup_src_z_mask = BIT(0),
> >>>> +			.wakeup_src_y_mask = BIT(1),
> >>>> +			.wakeup_src_x_mask = BIT(2),
> >>>>   		},
> >>>>   	},
> >>>>   	{
> >>>> @@ -412,6 +418,11 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
> >>>>   				.addr = 0x5B,
> >>>>   				.mask = GENMASK(5, 0),
> >>>>   			},
> >>>> +			.wakeup_src_reg = 0x1b,
> >>>> +			.wakeup_src_status_mask = BIT(3),
> >>>> +			.wakeup_src_z_mask = BIT(0),
> >>>> +			.wakeup_src_y_mask = BIT(1),
> >>>> +			.wakeup_src_x_mask = BIT(2),
> >>>>   		},
> >>>>   	},
> >>>>   	{
> >>>> @@ -550,6 +561,11 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
> >>>>   				.addr = 0x5B,
> >>>>   				.mask = GENMASK(5, 0),
> >>>>   			},
> >>>> +			.wakeup_src_reg = 0x1b,
> >>>> +			.wakeup_src_status_mask = BIT(3),
> >>>> +			.wakeup_src_z_mask = BIT(0),
> >>>> +			.wakeup_src_y_mask = BIT(1),
> >>>> +			.wakeup_src_x_mask = BIT(2),
> >>>>   		},
> >>>>   	},
> >>>>   	{
> >>>> @@ -816,6 +832,11 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
> >>>>   				.addr = 0x5B,
> >>>>   				.mask = GENMASK(5, 0),
> >>>>   			},
> >>>> +			.wakeup_src_reg = 0x1b,
> >>>> +			.wakeup_src_status_mask = BIT(3),
> >>>> +			.wakeup_src_z_mask = BIT(0),
> >>>> +			.wakeup_src_y_mask = BIT(1),
> >>>> +			.wakeup_src_x_mask = BIT(2),
> >>>>   		},
> >>>>   	},
> >>>>   	{
> >>>> @@ -970,6 +991,11 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
> >>>>   				.addr = 0x5B,
> >>>>   				.mask = GENMASK(5, 0),
> >>>>   			},
> >>>> +			.wakeup_src_reg = 0x1b,
> >>>> +			.wakeup_src_status_mask = BIT(3),
> >>>> +			.wakeup_src_z_mask = BIT(0),
> >>>> +			.wakeup_src_y_mask = BIT(1),
> >>>> +			.wakeup_src_x_mask = BIT(2),
> >>>>   		}
> >>>>   	},
> >>>>   };
> >>>> @@ -1715,6 +1741,38 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
> >>>>   	return iio_dev;
> >>>>   }
> >>>>   
> >>>> +void st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw, int data)
> >>>> +{
> >>>> +	s64 timestamp = iio_get_time_ns(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> >>>> +
> >>>> +	if (data & hw->settings->event_settings.wakeup_src_z_mask)
> >>>> +		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
> >>>> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> >>>> +						  0,
> >>>> +						  IIO_MOD_Z,
> >>>> +						  IIO_EV_TYPE_THRESH,
> >>>> +						  IIO_EV_DIR_EITHER),
> >>>> +						  timestamp);
> >>>> +
> >>>> +	if (data & hw->settings->event_settings.wakeup_src_x_mask)
> >>>> +		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
> >>>> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> >>>> +						  0,
> >>>> +						  IIO_MOD_Y,
> >>>> +						  IIO_EV_TYPE_THRESH,
> >>>> +						  IIO_EV_DIR_EITHER),
> >>>> +						  timestamp);
> >>>> +
> >>>> +	if (data & hw->settings->event_settings.wakeup_src_x_mask)
> >>>> +		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
> >>>> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> >>>> +						  0,
> >>>> +						  IIO_MOD_X,
> >>>> +						  IIO_EV_TYPE_THRESH,
> >>>> +						  IIO_EV_DIR_EITHER),
> >>>> +						  timestamp);
> >>>> +}
> >>>> +
> >>>>   static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
> >>>>   {
> >>>>   	return IRQ_WAKE_THREAD;
> >>>> @@ -1724,6 +1782,18 @@ static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
> >>>>   {
> >>>>   	struct st_lsm6dsx_hw *hw = private;
> >>>>   	int count;
> >>>> +	int data, err;
> >>>> +
> >>>> +	if (hw->enable_event) {
> >>>> +		err = regmap_read(hw->regmap,
> >>>> +				  hw->settings->event_settings.wakeup_src_reg,
> >>>> +				  &data);
> >>>> +		if (err < 0)
> >>>> +			return IRQ_NONE;
> >>>> +
> >>>> +		if (data & hw->settings->event_settings.wakeup_src_status_mask)
> >>>> +			st_lsm6dsx_report_motion_event(hw, data);
> >>>> +	}
> >>>>   
> >>>>   	mutex_lock(&hw->fifo_lock);
> >>>>   	count = hw->settings->fifo_ops.read_fifo(hw);  
> >>>      
> >   

