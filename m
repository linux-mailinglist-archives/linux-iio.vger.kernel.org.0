Return-Path: <linux-iio+bounces-19889-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFEAAC34FD
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 15:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0A351891A09
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 13:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E6E1F4617;
	Sun, 25 May 2025 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIOso+kY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEABBA2D;
	Sun, 25 May 2025 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748180562; cv=none; b=tgQpgAofHpPd7olQ6c6jDdBV+Z0zC1FTRLInSfdFegSmABGy9lQL+zbYhjrdVBkx+3JV///mKK4HBear8pdmuXd5ecaZhPWTwZhDCuySPIyNelpTXRaEvvCtva6YICAdgoH4MGudddb4PRpRyQHnAnyoSEoGnMGD/N9rKZ9bzks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748180562; c=relaxed/simple;
	bh=fC2AuJ2mMCicCWk4dfrONl9WpP0zGTF3e72sBZJLkqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GZMRCmaxxQTiPpwMqpBCwJYoe+A9Vqeo4Ckd5QaMfiCf3HSBnjKwnLHByjB43r02f9+cFmUpTklTfHJXVQeSDVwN5ZVTSobNpIS3uoEttXzl0rWiZpnqQ48VMBaJWSEVqr9Tqr3o38Q7XUw4hTUVdWOfhQH4XRumKkOXqmb9Mtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIOso+kY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52590C4CEEA;
	Sun, 25 May 2025 13:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748180561;
	bh=fC2AuJ2mMCicCWk4dfrONl9WpP0zGTF3e72sBZJLkqs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CIOso+kYg1qqqPOawLOPz3dnUJeDt32MOLt8He030loejeBzx+dM33JOuKknY0xr7
	 0fXNPRXiCNXJFJfCWxMKgGd32Wl11HIwjxVLi9ZH5KyZh3wQNvdeY1tYPhhWLvALQi
	 PKIjyCZuEJ10iqdQBSn4sRbwNBR3a5ap2L0ok8/4wxvRITUOu+1hY+z+155+bYDBcq
	 t0ztV/qN0MDqk6RuXx+HJd8ge+6MfJYdchkEznXxMLwwCK02oq5peIiv9eh87JUGY8
	 y/LUukkT2eQgxhKEl7AEk7zYAVqtoWsE+q/hPrvhAssz8uMz4AHku1GGBPbFtcU84k
	 Ymw5mNzlMMx2Q==
Date: Sun, 25 May 2025 14:42:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: tzungbi@kernel.org, chrome-platform@lists.linux.dev,
 linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH v4] iio: cros_ec_sensors: add cros_ec_activity driver
Message-ID: <20250525144233.13df701f@jic23-huawei>
In-Reply-To: <20250523172727.2654957-1-gwendal@google.com>
References: <20250523172727.2654957-1-gwendal@google.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 10:27:27 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

Hi Gwendal,

> ChromeOS EC can report activity information derived from the
> accelerometer:
> - Reports on-body/off-body as a proximity event.

How do you do proximity from an accelerometer?

> - Reports significant motion as an activity event.

This one might be from an accelerometer. In which case is there
any information on the algorithm?

> 
> This new sensor is a virtual sensor, included only when the EC firmware
> is compiled with the appropriate module.
> 
> Signed-off-by: Gwendal Grignou <gwendal@google.com>
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>


Various comments inline.

Biggest question I have is what the significant motion detector
is based on. Do we know more about that as I'd prefer it associated
with an actual channel if possible?

Also does it only surface as an event?  Is there an underlying
value to read.


> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_activity.c b/drivers/iio/common/cros_ec_sensors/cros_ec_activity.c
> new file mode 100644
> index 000000000000..620203f7aa63
> --- /dev/null
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_activity.c
> @@ -0,0 +1,322 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * cros_ec_activity - Driver for activities/gesture recognition.
> + *
> + * Copyright 2025 Google, Inc
> + *
> + * This driver uses the cros-ec interface to communicate with the ChromeOS
> + * EC about activity data. Accelerometer access is presented through iio sysfs.

Maybe update as this isn't returning accelerometer data .

> + */

> +
> +static int ec_sensors_read(struct iio_dev *indio_dev,

Given this only applies to this sensor, maybe needs a more specific name?

> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct cros_ec_sensors_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&st->core.cmd_lock);
Include cleanup.h and use

	guard(mutex)(&st->core.cmd_lock);
to simpilfy this.

> +	if (chan->type == IIO_PROXIMITY && mask == IIO_CHAN_INFO_RAW) {
> +		st->core.param.cmd = MOTIONSENSE_CMD_GET_ACTIVITY;
> +		st->core.param.get_activity.activity =
> +			MOTIONSENSE_ACTIVITY_BODY_DETECTION;
> +		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
> +		if (ret == 0) {
> +			*val = st->core.resp->get_activity.state;
> +			ret = IIO_VAL_INT;
With guard magic, can handle error out path and return directly in good path.
		if (ret)
			return ret;

		*val = ..

		return IIO_VAL_INT;

> +		}
> +	} else {
> +		ret = -EINVAL;

With guard() magic can just return here.

> +	}
> +	mutex_unlock(&st->core.cmd_lock);
> +	return ret;
> +}
> +
> +static int cros_ec_read_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir)
> +{
> +	struct cros_ec_sensors_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (chan->type != IIO_ACTIVITY && chan->type != IIO_PROXIMITY)
> +		return -EINVAL;
> +
> +	mutex_lock(&st->core.cmd_lock);

Similar to below. guard() will simplify this quite a bit.

> +	st->core.param.cmd = MOTIONSENSE_CMD_LIST_ACTIVITIES;
> +	ret = cros_ec_motion_send_host_cmd(&st->core, 0);
> +	if (ret)
> +		goto done;

Blank line here.

> +	switch (chan->type) {
> +	case IIO_PROXIMITY:
> +		ret = !!(st->core.resp->list_activities.enabled &
> +			 (1 << MOTIONSENSE_ACTIVITY_BODY_DETECTION));
> +		break;
> +	case IIO_ACTIVITY:
> +		if (chan->channel2 == IIO_MOD_STILL) {
> +			ret = !!(st->core.resp->list_activities.enabled &
> +				 (1 << MOTIONSENSE_ACTIVITY_SIG_MOTION));
> +		} else {
> +			dev_warn(&indio_dev->dev, "Unknown activity: %d\n",
> +				 chan->channel2);
> +			ret = -EINVAL;

Flip logic and direct returns etc.

> +		}
> +		break;
> +	default:
> +		dev_warn(&indio_dev->dev, "Unknown channel type: %d\n",
> +			 chan->type);
> +		ret = -EINVAL;
> +	}
> +done:
> +	mutex_unlock(&st->core.cmd_lock);
> +	return ret;
> +}
> +
> +static int cros_ec_write_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir, int state)
> +{
> +	struct cros_ec_sensors_state *st = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	mutex_lock(&st->core.cmd_lock);

Guard and direct returns. (See below for more on this)

> +	st->core.param.cmd = MOTIONSENSE_CMD_SET_ACTIVITY;
> +	switch (chan->type) {
> +	case IIO_PROXIMITY:
> +		st->core.param.set_activity.activity =
> +			MOTIONSENSE_ACTIVITY_BODY_DETECTION;
> +		break;
> +	case IIO_ACTIVITY:
> +		if (chan->channel2 == IIO_MOD_STILL) {
> +			st->core.param.set_activity.activity =
> +				MOTIONSENSE_ACTIVITY_SIG_MOTION;
> +		} else {
flip logic so error is out of line and good path inline.  Then with
guard you an directly return for error path.

> +			dev_warn(&indio_dev->dev, "Unknown activity: %d\n",
> +				 chan->channel2);
> +			ret = -EINVAL;
> +		}
> +		break;
> +	default:
> +		dev_warn(&indio_dev->dev, "Unknown channel type: %d\n",
> +			 chan->type);
> +		ret = -EINVAL;
		return -EINVAL; when using guard()
> +	}
> +	if (ret == 0) {

Then we only get here if ret == 0 so condition can go away.

> +		st->core.param.set_activity.enable = state;
> +		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
> +	}
> +
> +	mutex_unlock(&st->core.cmd_lock);
> +	return ret;
> +}
> +
> +static int cros_ec_activity_push_data(struct iio_dev *indio_dev,
> +				      s16 *data,
> +				      s64 timestamp)

Can reduce wrap and have a parameters share a line.  Nice to stay under 80
but this is well below that.

> +{
> +	struct ec_response_activity_data *activity_data =
> +			(struct ec_response_activity_data *)data;
> +	enum motionsensor_activity activity = activity_data->activity;
> +	u8 state = activity_data->state;
> +	const struct cros_ec_sensors_state *st = iio_priv(indio_dev);
> +	const struct iio_chan_spec *chan;
> +	const struct iio_event_spec *event;
> +	enum iio_event_direction dir;
> +	int index;
> +	u64 ev;
> +
> +	switch (activity) {
> +	case MOTIONSENSE_ACTIVITY_BODY_DETECTION:
> +		index = st->body_detection_channel_index;
> +		dir = state ? IIO_EV_DIR_FALLING : IIO_EV_DIR_RISING;
> +		break;
> +	case MOTIONSENSE_ACTIVITY_SIG_MOTION:
> +		index = st->sig_motion_channel_index;
> +		dir = IIO_EV_DIR_FALLING;

Falling stillness is I guess a detection of activity... As below though I'd
like to know if we have any more info on what this is actually measuring?

> +		break;
> +	default:
> +		dev_warn(&indio_dev->dev, "Unknown activity: %d\n", activity);
> +		return 0;
> +	}
> +	chan = &st->channels[index];
> +	event = &chan->event_spec[0];

I'd not have so many local variables. Pick some to put inline. Either
these two or ev.  Just in the interests of shorter code and little
cost to readability.

> +
> +	ev = IIO_UNMOD_EVENT_CODE(chan->type, index, event->type, dir);
> +	iio_push_event(indio_dev, ev, timestamp);

Blank line here.
> +	return 0;
> +}
> +
> +static irqreturn_t cros_ec_activity_capture(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +
> +	dev_warn(&indio_dev->dev, "%s: Not Expected\n", __func__);

Add a comment on why.

> +	return IRQ_NONE;
> +}

> +static int cros_ec_sensors_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cros_ec_device *ec_device = dev_get_drvdata(dev->parent);
> +	struct iio_dev *indio_dev;
> +	struct cros_ec_sensors_state *st;
> +	struct iio_chan_spec *channel;
> +	unsigned long activities;
> +	int i, index, ret, nb_activities;
> +
> +	if (!ec_device) {
> +		dev_warn(dev, "No CROS EC device found.\n");
> +		return -EINVAL;
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
> +					cros_ec_activity_capture);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->info = &ec_sensors_info;
> +	st = iio_priv(indio_dev);
> +	st->core.type = st->core.resp->info.type;
> +	st->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
> +
> +	/*
> +	 * List all available activities

Single line comment.  also, it's kind of obvious given the name
of the command so maybe don't bother with the comment at all?


> +	 */
> +	st->core.param.cmd = MOTIONSENSE_CMD_LIST_ACTIVITIES;
> +	ret = cros_ec_motion_send_host_cmd(&st->core, 0);
> +	if (ret)
> +		return ret;

I'd put a blank line here to separate the error path out
from where we carry on to in the good case.

> +	activities = st->core.resp->list_activities.enabled |
> +		     st->core.resp->list_activities.disabled;
> +	if (!activities)
> +		return -ENODEV;
> +
> +	/* Allocate a channel per activity and one for timestamp */
> +	nb_activities = hweight_long(activities) + 1;
> +	st->channels = devm_kcalloc(dev, nb_activities,
> +				    sizeof(*st->channels), GFP_KERNEL);
> +	if (!st->channels)
> +		return -ENOMEM;
> +
> +	channel = &st->channels[0];
> +	index = 0;
> +	for_each_set_bit(i, &activities, BITS_PER_LONG) {
> +		/* List all available triggers */
> +		if (i == MOTIONSENSE_ACTIVITY_BODY_DETECTION) {
> +			channel->type = IIO_PROXIMITY;
> +			channel->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +			channel->modified = 0;

Not modified is the 'obvious' default so can probably drop that one.

> +			channel->event_spec = cros_ec_body_detect_events;
> +			channel->num_event_specs =
> +				ARRAY_SIZE(cros_ec_body_detect_events);
> +			st->body_detection_channel_index = index;
> +		} else {
> +			channel->type = IIO_ACTIVITY;

This is getting a little creative.  Do we know anything about what the
underlying detection actually is?  Activity sensor are often some form
of magnitude sensor on a specific type of data.  I guess if we have no
idea what this then activity detection makes some sense.

Is it only ever an event?

> +			channel->modified = 1;
> +			channel->event_spec = cros_ec_activity_single_shot;
> +			channel->num_event_specs =
> +				ARRAY_SIZE(cros_ec_activity_single_shot);
> +			if (i == MOTIONSENSE_ACTIVITY_SIG_MOTION) {
> +				channel->channel2 = IIO_MOD_STILL;
> +				st->sig_motion_channel_index = index;
> +			} else {
> +				dev_warn(dev, "Unknown activity: %d\n", i);
> +				continue;
> +			}
> +		}
> +		channel->ext_info = cros_ec_sensors_limited_info;
> +		channel->scan_index = index++;
> +		channel++;
> +	}
> +
> +	/* Timestamp */
> +	channel->scan_index = index;
> +	channel->type = IIO_TIMESTAMP;
> +	channel->channel = -1;
> +	channel->scan_type.sign = 's';
> +	channel->scan_type.realbits = 64;
> +	channel->scan_type.storagebits = 64;
> +
> +	indio_dev->channels = st->channels;
> +	indio_dev->num_channels = index + 1;
> +
> +	return cros_ec_sensors_core_register(dev, indio_dev,
> +					     cros_ec_activity_push_data);
> +}
> +
> +static void cros_ec_sensors_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +
> +	iio_device_unregister(indio_dev);

Why?  The cros_ec_sensors_core_register() uses devm internally
to clean this up so I'd not expect to see a remove function at all
for one of these drivers

> +}
> +
> +static struct platform_driver cros_ec_sensors_platform_driver = {
> +	.driver = {
> +		.name	= DRV_NAME,
> +	},
> +	.probe		= cros_ec_sensors_probe,
> +	.remove		= cros_ec_sensors_remove,
> +};
> +module_platform_driver(cros_ec_sensors_platform_driver);
> +
> +MODULE_DESCRIPTION("ChromeOS EC activity sensors driver");
> +MODULE_ALIAS("platform:" DRV_NAME);
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 64bada1e8678..1bd07ca3abfe 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -489,6 +489,16 @@ const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[] = {
>  };
>  EXPORT_SYMBOL_GPL(cros_ec_sensors_ext_info);
>  
> +const struct iio_chan_spec_ext_info cros_ec_sensors_limited_info[] = {
> +	{
> +		.name = "id",
> +		.shared = IIO_SHARED_BY_ALL,
> +		.read = cros_ec_sensors_id
> +	},
> +	{ },

No comma on terminating entries / sentinels like this.  We don't want
it to be easy to add things after them as that should never happen.

> +};
> +EXPORT_SYMBOL_GPL(cros_ec_sensors_limited_info);
> +
>  /**
>   * cros_ec_sensors_idx_to_reg - convert index into offset in shared memory
>   * @st:		pointer to state information for device

> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
> index ecf290a0c98f..0f6d53e7cb97 100644
> --- a/include/linux/platform_data/cros_ec_commands.h
> +++ b/include/linux/platform_data/cros_ec_commands.h


>  struct ec_response_motion_sensor_data {
>  	/* Flags for each sensor. */
>  	uint8_t flags;
> @@ -2454,15 +2465,14 @@ struct ec_response_motion_sensor_data {
>  	uint8_t sensor_num;
>  	/* Each sensor is up to 3-axis. */
>  	union {
> -		int16_t             data[3];
> +		int16_t                                  data[3];

I dislike careful alignment like this because of the noise
it tends to add - this being a classic example. 
I'd just not update the existing field and let one through that isn't
aligned.

>  		struct __ec_todo_packed {
> -			uint16_t    reserved;
> -			uint32_t    timestamp;
> +			uint16_t                         reserved;
> +			uint32_t                         timestamp;
>  		};
>  		struct __ec_todo_unpacked {
> -			uint8_t     activity; /* motionsensor_activity */
> -			uint8_t     state;
> -			int16_t     add_info[2];
> +			struct ec_response_activity_data activity_data;
> +			int16_t                          add_info[2];
>  		};
>  	};
>  } __ec_todo_packed;

>  
>  struct ec_motion_sense_activity {
> @@ -2671,6 +2682,7 @@ struct ec_params_motion_sense {
>  			uint32_t max_data_vector;
>  		} fifo_read;
>  
> +		/* Used for MOTIONSENSE_CMD_SET_ACTIVITY */
>  		struct ec_motion_sense_activity set_activity;
>  
>  		/* Used for MOTIONSENSE_CMD_LID_ANGLE */
> @@ -2716,6 +2728,14 @@ struct ec_params_motion_sense {
>  			 */
>  			int16_t hys_degree;
>  		} tablet_mode_threshold;
> +
> +		/*
> +		 * Used for MOTIONSENSE_CMD_GET_ACTIVITY.

Single line comment works fine here and fits with local style.
		/* Used for MOTIONSENSE_CMD_GET_ACTIVITY */

> +		 */
> +		struct __ec_todo_unpacked {
> +			uint8_t sensor_num;
> +			uint8_t activity;  /* enum motionsensor_activity */
> +		} get_activity;
>  	};
>  } __ec_todo_packed;
>  
> @@ -2833,6 +2853,10 @@ struct ec_response_motion_sense {
>  			uint16_t hys_degree;
>  		} tablet_mode_threshold;
>  
> +		/* USED for MOTIONSENSE_CMD_GET_ACTIVITY. */

Maybe no fullstop is more consistent with local style? Only a bit visible
in this patch and I'm lazy  :)

> +		struct __ec_todo_unpacked {
> +			uint8_t     state;
> +		} get_activity;
>  	};
>  } __ec_todo_packed;
>  


