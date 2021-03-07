Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569D73300A8
	for <lists+linux-iio@lfdr.de>; Sun,  7 Mar 2021 13:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhCGMAS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Mar 2021 07:00:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:36854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229662AbhCGL7r (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Mar 2021 06:59:47 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C0A96501D;
        Sun,  7 Mar 2021 11:59:45 +0000 (UTC)
Date:   Sun, 7 Mar 2021 11:59:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        bleung@chromium.org, groeck@chromium.org, gwendal@chromium.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: Re: [PATCH 1/2] iio: cros_ec: do an early exit if not
 physical_device case
Message-ID: <20210307115941.18badb2e@archlinux>
In-Reply-To: <408e9b87-0528-141a-1fa6-ca8c2a0b1c69@collabora.com>
References: <20201123144017.18311-1-alexandru.ardelean@analog.com>
        <20210221162905.65be88d0@archlinux>
        <408e9b87-0528-141a-1fa6-ca8c2a0b1c69@collabora.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2 Mar 2021 11:46:06 +0100
Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:

> Hi all,
> 
> On 21/2/21 17:29, Jonathan Cameron wrote:
> > On Mon, 23 Nov 2020 16:40:16 +0200
> > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> >   
> >> This whole code-block was put under one big if() condition/block.
> >> This change does an early return if the 'physical_device' boolean is false,
> >> thus unindenting the block by one level.
> >>
> >> No other functional change has been done.
> >>
> >> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>  
> > @Gwendal, others  This series from Alex has been outstanding for a while
> > but may well still apply.
> > Ideally looking for an ack.
> >   
> 
> This looks good to me.
> 
> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Hi Enric, Ack or both patches or just this one?

@Alex, series needs a rebase.  I'm not totally sure what's changed.
If you don't get to it I'll do it at somepoint but unlikely to
be terribly soon!

Jonathan

> 
> Thanks,
>  Enric
> 
> > Thanks,
> > 
> > Jonathan
> >    
> >> ---
> >>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 161 +++++++++---------
> >>  1 file changed, 81 insertions(+), 80 deletions(-)
> >>
> >> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> >> index 5c6c4e6fec9b..9470014936f2 100644
> >> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> >> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> >> @@ -287,89 +287,90 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
> >>  
> >>  	indio_dev->name = pdev->name;
> >>  
> >> -	if (physical_device) {
> >> -		state->param.cmd = MOTIONSENSE_CMD_INFO;
> >> -		state->param.info.sensor_num = sensor_platform->sensor_num;
> >> -		ret = cros_ec_motion_send_host_cmd(state, 0);
> >> -		if (ret) {
> >> -			dev_warn(dev, "Can not access sensor info\n");
> >> +	if (!physical_device)
> >> +		return 0;
> >> +
> >> +	state->param.cmd = MOTIONSENSE_CMD_INFO;
> >> +	state->param.info.sensor_num = sensor_platform->sensor_num;
> >> +	ret = cros_ec_motion_send_host_cmd(state, 0);
> >> +	if (ret) {
> >> +		dev_warn(dev, "Can not access sensor info\n");
> >> +		return ret;
> >> +	}
> >> +	state->type = state->resp->info.type;
> >> +	state->loc = state->resp->info.location;
> >> +
> >> +	/* Set sign vector, only used for backward compatibility. */
> >> +	memset(state->sign, 1, CROS_EC_SENSOR_MAX_AXIS);
> >> +
> >> +	for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++)
> >> +		state->calib[i].scale = MOTION_SENSE_DEFAULT_SCALE;
> >> +
> >> +	/* 0 is a correct value used to stop the device */
> >> +	if (state->msg->version < 3) {
> >> +		get_default_min_max_freq(state->resp->info.type,
> >> +					 &frequencies[1],
> >> +					 &frequencies[2],
> >> +					 &state->fifo_max_event_count);
> >> +	} else {
> >> +		frequencies[1] = state->resp->info_3.min_frequency;
> >> +		frequencies[2] = state->resp->info_3.max_frequency;
> >> +		state->fifo_max_event_count =
> >> +		    state->resp->info_3.fifo_max_event_count;
> >> +	}
> >> +	for (i = 0; i < ARRAY_SIZE(frequencies); i++) {
> >> +		state->frequencies[2 * i] = frequencies[i] / 1000;
> >> +		state->frequencies[2 * i + 1] =
> >> +			(frequencies[i] % 1000) * 1000;
> >> +	}
> >> +
> >> +	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
> >> +		/*
> >> +		 * Create a software buffer, feed by the EC FIFO.
> >> +		 * We can not use trigger here, as events are generated
> >> +		 * as soon as sample_frequency is set.
> >> +		 */
> >> +		struct iio_buffer *buffer;
> >> +
> >> +		buffer = devm_iio_kfifo_allocate(dev);
> >> +		if (!buffer)
> >> +			return -ENOMEM;
> >> +
> >> +		iio_device_attach_buffer(indio_dev, buffer);
> >> +		indio_dev->modes = INDIO_BUFFER_SOFTWARE;
> >> +
> >> +		ret = cros_ec_sensorhub_register_push_data(
> >> +				sensor_hub, sensor_platform->sensor_num,
> >> +				indio_dev, push_data);
> >> +		if (ret)
> >>  			return ret;
> >> -		}
> >> -		state->type = state->resp->info.type;
> >> -		state->loc = state->resp->info.location;
> >>  
> >> -		/* Set sign vector, only used for backward compatibility. */
> >> -		memset(state->sign, 1, CROS_EC_SENSOR_MAX_AXIS);
> >> +		ret = devm_add_action_or_reset(
> >> +				dev, cros_ec_sensors_core_clean, pdev);
> >> +		if (ret)
> >> +			return ret;
> >>  
> >> -		for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++)
> >> -			state->calib[i].scale = MOTION_SENSE_DEFAULT_SCALE;
> >> -
> >> -		/* 0 is a correct value used to stop the device */
> >> -		if (state->msg->version < 3) {
> >> -			get_default_min_max_freq(state->resp->info.type,
> >> -						 &frequencies[1],
> >> -						 &frequencies[2],
> >> -						 &state->fifo_max_event_count);
> >> -		} else {
> >> -			frequencies[1] = state->resp->info_3.min_frequency;
> >> -			frequencies[2] = state->resp->info_3.max_frequency;
> >> -			state->fifo_max_event_count =
> >> -			    state->resp->info_3.fifo_max_event_count;
> >> -		}
> >> -		for (i = 0; i < ARRAY_SIZE(frequencies); i++) {
> >> -			state->frequencies[2 * i] = frequencies[i] / 1000;
> >> -			state->frequencies[2 * i + 1] =
> >> -				(frequencies[i] % 1000) * 1000;
> >> -		}
> >> -
> >> -		if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
> >> -			/*
> >> -			 * Create a software buffer, feed by the EC FIFO.
> >> -			 * We can not use trigger here, as events are generated
> >> -			 * as soon as sample_frequency is set.
> >> -			 */
> >> -			struct iio_buffer *buffer;
> >> -
> >> -			buffer = devm_iio_kfifo_allocate(dev);
> >> -			if (!buffer)
> >> -				return -ENOMEM;
> >> -
> >> -			iio_device_attach_buffer(indio_dev, buffer);
> >> -			indio_dev->modes = INDIO_BUFFER_SOFTWARE;
> >> -
> >> -			ret = cros_ec_sensorhub_register_push_data(
> >> -					sensor_hub, sensor_platform->sensor_num,
> >> -					indio_dev, push_data);
> >> -			if (ret)
> >> -				return ret;
> >> -
> >> -			ret = devm_add_action_or_reset(
> >> -					dev, cros_ec_sensors_core_clean, pdev);
> >> -			if (ret)
> >> -				return ret;
> >> -
> >> -			/* Timestamp coming from FIFO are in ns since boot. */
> >> -			ret = iio_device_set_clock(indio_dev, CLOCK_BOOTTIME);
> >> -			if (ret)
> >> -				return ret;
> >> -		} else {
> >> -			const struct attribute **fifo_attrs;
> >> -
> >> -			if (has_hw_fifo)
> >> -				fifo_attrs = cros_ec_sensor_fifo_attributes;
> >> -			else
> >> -				fifo_attrs = NULL;
> >> -
> >> -			/*
> >> -			 * The only way to get samples in buffer is to set a
> >> -			 * software trigger (systrig, hrtimer).
> >> -			 */
> >> -			ret = devm_iio_triggered_buffer_setup_ext(
> >> -					dev, indio_dev, NULL, trigger_capture,
> >> -					NULL, fifo_attrs);
> >> -			if (ret)
> >> -				return ret;
> >> -		}
> >> +		/* Timestamp coming from FIFO are in ns since boot. */
> >> +		ret = iio_device_set_clock(indio_dev, CLOCK_BOOTTIME);
> >> +		if (ret)
> >> +			return ret;
> >> +	} else {
> >> +		const struct attribute **fifo_attrs;
> >> +
> >> +		if (has_hw_fifo)
> >> +			fifo_attrs = cros_ec_sensor_fifo_attributes;
> >> +		else
> >> +			fifo_attrs = NULL;
> >> +
> >> +		/*
> >> +		 * The only way to get samples in buffer is to set a
> >> +		 * software trigger (systrig, hrtimer).
> >> +		 */
> >> +		ret = devm_iio_triggered_buffer_setup_ext(
> >> +				dev, indio_dev, NULL, trigger_capture,
> >> +				NULL, fifo_attrs);
> >> +		if (ret)
> >> +			return ret;
> >>  	}
> >>  
> >>  	return 0;  
> >   

