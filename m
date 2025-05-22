Return-Path: <linux-iio+bounces-19782-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 925B4AC0319
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 05:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A051E165425
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 03:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9C2145A18;
	Thu, 22 May 2025 03:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTLsfFFh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B5213D8A0;
	Thu, 22 May 2025 03:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747885360; cv=none; b=Yd2dZdmJnmNbE/FJn0+PHeIrutZ/lUXVyJIGSbNb9IgqIbgtdfhi0icSOQL2pIv4j2obF6E41XVdIV4b82RI4bF71O7i1fuPFeSh1j0MVukiwb9Wz2wBeXyEPTsUqUnDeg4TW7KFD02u2NG7Y9+DseDJALcIfjkg8I+T/C1MWWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747885360; c=relaxed/simple;
	bh=r+F3JZYaPAeDy2pSzWDrKT2OEuI2qrkC0/cJTDNtW/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjHS/JAx3yarPSZ8a7U+hL9ASNYtYozd7JSF9+1KwsuO7adp14cANS+01NgVrT7Tv2hdj7Gh7IBXRi7yNrlrdsXYkCK81qOnGs48R8BD6dBvjco9LCoIg/uUaYwP3KUaz1FAkbQytwRZ/xDC+anxf/+LkbLNbkf7e6lDrGvBwN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTLsfFFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F68C4CEE4;
	Thu, 22 May 2025 03:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747885359;
	bh=r+F3JZYaPAeDy2pSzWDrKT2OEuI2qrkC0/cJTDNtW/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dTLsfFFhAOYvffhIucIcG/MxU8ERdGhCiTMkl3vl0rDFeci7n+8eeMNbBrD8OlIEp
	 vnuClC+UrfKi/Hk9HFhuAYnBU67zGBQ+HkI/lmM0riJps5NaCehXPi1O1JzOmOhFhx
	 0+4JdFRtT+l/8jWqZ0sx7cxBbldytzrr37NfJbpSFoNCwNDCgx0nGc2VnpjbOh0GcN
	 +a6WNHOHvKOviXh2NbGmDauSX6YvJvej9YXnA/EJS2slaChF5h36U3VfdmQaYTX4gB
	 2gHBDl4gGGmFLt/t3G6GZstc8dXhxItFsjRpp1BYgWo19ytK6jWUmhKrsjQObS4EXw
	 jN0UXm5nc1ROw==
Date: Thu, 22 May 2025 03:42:36 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: jic23@kernel.org, chrome-platform@lists.linux.dev,
	linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH v2] iio: cros_ec_sensors: add cros_ec_activity driver
Message-ID: <aC6dLPFopj8lL_kE@google.com>
References: <20250521235108.2088274-1-gwendal@google.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521235108.2088274-1-gwendal@google.com>

On Wed, May 21, 2025 at 04:51:08PM -0700, Gwendal Grignou wrote:
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_activity.c b/drivers/iio/common/cros_ec_sensors/cros_ec_activity.c
> [...]
> +/*
> + * cros_ec_sensors_activity - Driver for activities/gesture recognition.

s/sensors//.

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
> +	}
> +	st->core.param.set_activity.enable = state;
> +
> +	ret = cros_ec_motion_send_host_cmd(&st->core, 0);
> +
> +	mutex_unlock(&st->core.cmd_lock);
> +	return ret;

If either activity or channel type is unknown, does it still need to send
the host command for writing the config?

> +static int cros_ec_sensors_probe(struct platform_device *pdev)
> [...]
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

See review comments for v1 too.  Moving the line just right before the
following devm_kcalloc() for `st->channels` makes more sense.

> +
> +	if (!activities)
> +		return -ENODEV;
> +
> +	/* Allocate a channel per activity and one for timestamp */
> +	st->channels = devm_kcalloc(dev, nb_activities,
> +				    sizeof(*st->channels), GFP_KERNEL);
> +	if (!st->channels)
> +		return -ENOMEM;
> +
> +	channel = &st->channels[0];
> +	index = 0;
> +	for_each_set_bit(i, &activities, BITS_PER_LONG) {
> +		channel->scan_index = index++;

This doesn't look correct.  It generates some unused `index` if the activity
is unknown.

Moving the statement to the end of loop?  See review comments for v1 too.

