Return-Path: <linux-iio+bounces-19762-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94028ABECE3
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 09:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC8A3A18B6
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 07:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0143922D783;
	Wed, 21 May 2025 07:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hp9xdowd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AD5199EAF;
	Wed, 21 May 2025 07:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747811781; cv=none; b=sIV2IJB31+jL9z3lQPC0pzElDXVDAQr0Mrl5IGrRhSvRnWl33MTSGlJ8Eb40n+CXSEyMqZ6PL3XycehPDvK6D/NikW+eHidMWILnyoVXuGyN0kf+gzPFdFQA+S+iP8rGkri41LQwpGSQvR7Z5+cpogcQwdBRBDUTfUvvpoOnqQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747811781; c=relaxed/simple;
	bh=8imMHFUmM7MTaB83XAfNCalYk3NPAFCHsOUX4BjSl2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNHpVNk+mz8vgVR1jl6tXlunRTdELDlvtkgBJ0AXwtatVA3APDAWE+pdyz1Z0prtF9oZ99ajR7C0VGO9JQenKet0mZpfxUT10VydyhCj6jqdsilW7uPCumITt5gPbE3iidOtfiChy3Zt+iFzrwH8DzTnBMG+Gv8zpNSI09q91vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hp9xdowd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4D9C4CEE4;
	Wed, 21 May 2025 07:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747811781;
	bh=8imMHFUmM7MTaB83XAfNCalYk3NPAFCHsOUX4BjSl2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hp9xdowdHe1yR83P+GClxvwUSGsHwn+xrvcFGcpP7zaBEM438LhPSeB4QHSho2dfM
	 Y5c3qbUFWrPc+W3f7cjBZfKXgynLSn8EPzu2+kWgZd8w+J/p1/w7SnbiIBSgiz0yT+
	 3UIEDVHxNmUB9t7yqhM3I+Ds+jNweDYRyYzS6NKXjP7Fn+HcZYFsz9RO4Cum2HUT/1
	 CuVySPoaUbEs9/lpFF15zpMCkGO5w+4bi1wHWyEJyVvCLjsAh8lF5h7vaLx8eRmNm4
	 PRMy4zOju78Dv74bMG/NZFoKCj5aBz5nQQpel7lrdbm6MW9PLqcZtnXAUtC9f+9Fup
	 lw+8xsGWagBHA==
Date: Wed, 21 May 2025 07:16:18 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: jic23@kernel.org, chrome-platform@lists.linux.dev,
	linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH] iio: cros_ec_sensors: add cros_ec_activity driver
Message-ID: <aC19wpJg1KAwv3Lo@google.com>
References: <20250520040101.3950845-1-gwendal@google.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520040101.3950845-1-gwendal@google.com>

On Mon, May 19, 2025 at 09:01:00PM -0700, Gwendal Grignou wrote:
> ChromeOS EC can report activity information derived from the
> accelerometer:
> - reports on-body/off-body as a proximity event.
> - reports significant motion as an activity event.

s/^r/R/.

> diff --git a/drivers/iio/common/cros_ec_sensors/Kconfig b/drivers/iio/common/cros_ec_sensors/Kconfig
> [...]
> +config IIO_CROS_EC_ACTIVITY
> +	tristate "ChromeOS EC Activity Sensors"
> +	depends on IIO_CROS_EC_SENSORS_CORE
> +	help
> +	  Module to handle activity events detections presented by the ChromeOS
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^
I'm confused and wondering if there is a typo.  Which one:
- activity event detections
- activity events
- activity detections

> +	  EC Sensor hub.

s/S/s/?

> +	  Activities can be a proximity detector (on body/off body detection)
> +	  or an activity to trigger an event on significant motion.

s/an activity to trigger //?

> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_activity.c b/drivers/iio/common/cros_ec_sensors/cros_ec_activity.c
> [...]
> +// SPDX-License-Identifier: GPL-2.0
> +//

Drop the empty comment line.

> +/*
> + * cros_ec_sensors_activity - Driver for activities/gesture recognition.
> + *
> + * Copyright 2025 Google, Inc
> + *
> + * This driver uses the cros-ec interface to communicate with the Chrome OS

s/Chrome OS/ChromeOS/.

> +#include <linux/delay.h>

Drop it.  The driver doesn't use anything from the header.

> +#include <linux/device.h>
> +#include <linux/iio/common/cros_ec_sensors_core.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_data/cros_ec_commands.h>
> +#include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/platform_device.h>

I guess the list may be copied from somewhere drivers.  Could you review
again to make sure the driver needs to include them?

> +#include <linux/slab.h>

Drop it.  The driver doesn't use anything from the header.

> +static const struct iio_event_spec cros_ec_activity_single_shot[] = {
> +	{
> +		.type = IIO_EV_TYPE_CHANGE,
> +		/* significant motion trigger when we get out of still. */
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +	 },

Remove the extra space before "}".

> +static const struct iio_event_spec cros_ec_body_detect_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_CHANGE,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +	 },

Remove the extra space before "}".

> +static int ec_sensors_read(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct cros_ec_sensors_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&st->core.cmd_lock);
> +	if (chan->type == IIO_PROXIMITY &&
> +	    mask == IIO_CHAN_INFO_RAW) {
> +		st->core.param.cmd = MOTIONSENSE_CMD_GET_ACTIVITY;
> +		st->core.param.get_activity.activity =
> +			MOTIONSENSE_ACTIVITY_BODY_DETECTION;
> +		if (cros_ec_motion_send_host_cmd(&st->core, 0) !=
> +				EC_RES_SUCCESS) {

cros_ec_motion_send_host_cmd() returns 0 or negative errno like most other
kernel APIs.  Even though EC_RES_SUCCESS is also 0, however, they aren't
the same domain space (see also cros_ec_map_error()).  Don't use it.

		if (cros_ec_motion_send_host_cmd(&st->core, 0))

> +static int cros_ec_read_event_config(struct iio_dev *indio_dev,
> [...]
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
> +		}
> +		break;
> +	default:
> +		dev_warn(&indio_dev->dev, "Unknown channel type: %d\n",
> +			 chan->type);
> +		ret = -EINVAL;

Curious about: wouldn't compiler or some checkers emit warnings about it
lacks a `break`?

> +static int cros_ec_write_event_config(struct iio_dev *indio_dev,
> [...]
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
> +			dev_warn(&indio_dev->dev, "Unknown activity: %d\n",
> +				 chan->channel2);
> +		}
> +		break;
> +	default:
> +		dev_warn(&indio_dev->dev, "Unknown channel type: %d\n",
> +			 chan->type);

Same here.

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
> +		dev_warn(&pdev->dev, "No CROS EC device found.\n");

The function already has a local variable `dev` for `&pdev->dev`.  Use it.

> +		return -EINVAL;
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*st));

`dev`.

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
> +
> +	/*
> +	 * List all available activities
> +	 */
> +	st->core.param.cmd = MOTIONSENSE_CMD_LIST_ACTIVITIES;
> +	ret = cros_ec_motion_send_host_cmd(&st->core, 0);
> +	if (ret)
> +		return ret;
> +	activities = st->core.resp->list_activities.enabled |
> +		     st->core.resp->list_activities.disabled;
> +	nb_activities = hweight_long(activities) + 1;

Moving the line just right before the following devm_kcalloc() for
`st->channels` makes more sense.

> +
> +	if (!activities)
> +		return -ENODEV;
> +
> +	/* Allocate a channel per activity and one for timestamp */
> +	st->channels = devm_kcalloc(&pdev->dev, nb_activities,
> +				    sizeof(*st->channels), GFP_KERNEL);
> +	if (!st->channels)
> +		return -ENOMEM;
> +
> +	channel = &st->channels[0];
> +	index = 0;
> +	for_each_set_bit(i, &activities, BITS_PER_LONG) {
> +		channel->scan_index = index;

It seems the loop body doesn't use the `channel->scan_index`.  Move the
assignment to the end of loop body when it's sure to occupy the index?

		channel->scan_index = index++;

> +
> +		/* List all available activities */

Drop the comment as it doesn't reflect what the following code does?

> +		if (i == MOTIONSENSE_ACTIVITY_BODY_DETECTION) {
> +			channel->type = IIO_PROXIMITY;
> +			channel->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +			channel->modified = 0;
> +			channel->event_spec = cros_ec_body_detect_events;
> +			channel->num_event_specs =
> +				ARRAY_SIZE(cros_ec_body_detect_events);
> +			st->body_detection_channel_index = index;
> +		} else {
> +			channel->type = IIO_ACTIVITY;
> +			channel->modified = 1;
> +			channel->event_spec = cros_ec_activity_single_shot;
> +			channel->num_event_specs =
> +				ARRAY_SIZE(cros_ec_activity_single_shot);
> +			if (i == MOTIONSENSE_ACTIVITY_SIG_MOTION) {
> +				channel->channel2 = IIO_MOD_STILL;
> +				st->sig_motion_channel_index = index;
> +			} else {
> +				dev_warn(&pdev->dev,

`dev`.

> +					 "Unknown activity: %d\n", i);
> +				continue;
> +			}
> +		}
> +		channel->ext_info = cros_ec_sensors_limited_info;
> +		channel++;
> +		index++;
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
> +	st->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;

The statement here isn't intuitive.  Can it move somewhere above when setting
the `st->core`?  E.g. right after the assignment for `st->core.type`.

