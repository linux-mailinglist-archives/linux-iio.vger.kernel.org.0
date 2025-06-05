Return-Path: <linux-iio+bounces-20237-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBBEACEA28
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 08:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA323ABE3E
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 06:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307111F2C44;
	Thu,  5 Jun 2025 06:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FV47raOS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB6E1EF0B0;
	Thu,  5 Jun 2025 06:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749104943; cv=none; b=hxoMDqG0qfL/BbOf081PqwPRNf3JOXWtVzOd5zYa0S1HzZMo6F1z/PGRy31B/eLxrtoIvBaDqV5cKaDF+u9bgsxX9mkE1NCdYaqVmlO5SwsEGA/H1ViJ5fOfbLoBHuG7QpPp436blsO4OP9hW7Nwev1Lvotbyw8Xk031/fXtdHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749104943; c=relaxed/simple;
	bh=KPgkw+cpE46n9HeAcGs5W4JrfY8T0PV4/F8fPzC/J5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buKLrfqC7L6bXTThSjXSWwIwDKEd1TI8ntdhVsf3VkyT72vuxn0rHpg1B1TFf82A0pyH5fEPhz3f++qHuNoN4GsDUAFF+k4vEUTn9uf6APEQ0RGScU1E/hmxGlTCpEnKWiumotC2BgpLMfxPqBRAsGs2Brk3zoyZmoTEq/aPEPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FV47raOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690FDC4CEE7;
	Thu,  5 Jun 2025 06:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749104942;
	bh=KPgkw+cpE46n9HeAcGs5W4JrfY8T0PV4/F8fPzC/J5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FV47raOSYYWCH92aLN5czYRrLWcoFWQ9NtupSlh1FmNz/mcdx8qJPWOdrsR34Z/RZ
	 A8syKdJ5aEwfDNMqum/XHMICjB5pt9uP6cUoP9tAN2JYg4wOk8MMHA1MMf6DcpJizG
	 FhRKuxkGu5a+KNwHtx0n+EckhlyNQQHnM3jADMDLNr1r8A6rDBnV2gghS2tzBLKVt5
	 7zrbxxcq9lXfJHz+IF0l+oZgF97GAks/hY7FoSPlUX7CM0o55JrrXWwgawA8XDqekF
	 stiVh3oqgnghnTvnhD6JYlqUQo1VHt1PqfYLq9xV3VogwD46uojrdrkBRcJHYQhYRF
	 wfWOQH2PTEjDA==
Date: Thu, 5 Jun 2025 06:28:59 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: jic23@kernel.org, chrome-platform@lists.linux.dev,
	linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH v5] iio: cros_ec_sensors: add cros_ec_activity driver
Message-ID: <aEE5K9DnEOcKZf8P@google.com>
References: <20250604053903.1376465-1-gwendal@google.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604053903.1376465-1-gwendal@google.com>

On Tue, Jun 03, 2025 at 10:39:03PM -0700, Gwendal Grignou wrote:
> ChromeOS EC can report activity information derived from the
> accelerometer:
> - Reports on-body/off-body as a proximity event.
> - Reports significant motion as an activity event.
> 
> This new sensor is a virtual sensor, included only when the EC firmware
> is compiled with the appropriate module.
> 
> Signed-off-by: Gwendal Grignou <gwendal@google.com>
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
> [...]
> Changes in v5:
> - Use guard(mutex), simplify error path.
> - Use driver name as function prefix.
> - Remove cros_ec_sensors_remove function.
> - Remove identation of structure field.
> - Invert raw value to return 1m when far, 0m when close.

As v5 changed a bit from v4, it'd be better to drop my R-b tag in v5.

Anyway, it overall looks good to me.  Only a few minor comments:
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

> +static int cros_ec_activity_read_event_config(struct iio_dev *indio_dev,
> +					      const struct iio_chan_spec *chan,
> +					      enum iio_event_type type,
> +					      enum iio_event_direction dir)
> +{
> +	struct cros_ec_sensors_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (chan->type != IIO_ACTIVITY && chan->type != IIO_PROXIMITY)
> +		return -EINVAL;
> +
> +	guard(mutex)(&st->core.cmd_lock);
> +	st->core.param.cmd = MOTIONSENSE_CMD_LIST_ACTIVITIES;
> +	ret = cros_ec_motion_send_host_cmd(&st->core, 0);
> +	if (ret)
> +		return ret;
> +
> +	switch (chan->type) {
> +	case IIO_PROXIMITY:
> +		return !!(st->core.resp->list_activities.enabled &
> +			 (1 << MOTIONSENSE_ACTIVITY_BODY_DETECTION));
> +	case IIO_ACTIVITY:
> +		if (chan->channel2 == IIO_MOD_STILL) {
> +			return !!(st->core.resp->list_activities.enabled &
> +				 (1 << MOTIONSENSE_ACTIVITY_SIG_MOTION));
> +		} else {
> +			dev_warn(&indio_dev->dev, "Unknown activity: %d\n",
> +				 chan->channel2);
> +			return -EINVAL;
> +		}

By referencing to cros_ec_activity_write_event_config(), maybe consider to
drop the " else {" and "}".

> +static int cros_ec_activity_write_event_config(struct iio_dev *indio_dev,
> +					       const struct iio_chan_spec *chan,
> +					       enum iio_event_type type,
> +					       enum iio_event_direction dir,
> +					       int state)
> +{
> +	struct cros_ec_sensors_state *st = iio_priv(indio_dev);
> +

By referencing to cros_ec_activity_read_event_config(), maybe consider to
exit the function earlier:
	if (chan->type != IIO_ACTIVITY && chan->type != IIO_PROXIMITY)

