Return-Path: <linux-iio+bounces-17544-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 097D0A78B16
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 11:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBE077A469E
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 09:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E002356CE;
	Wed,  2 Apr 2025 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkRUVanp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EFB233727;
	Wed,  2 Apr 2025 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743586200; cv=none; b=rwE5ggqUxNzl4NCHYDUB8xeL4X/TuCbaqucwLFlqsxiSouJsPlYBdMfhhjuDc4vV5ynj1cJ3qwpDhsptR7AJsBLC/yUGC1y0d8VbgY2fkuMRKxVLgIvXIUaq65m0rNNvQBSi6R3gAS7J9b70v/vzMHZ4sebRJEvMpSVevXQT7Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743586200; c=relaxed/simple;
	bh=8AFyzMkukXlIorZLfhC8lT6o/ZfWhcX4UZ5ou9xw/mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYZeccgcJrsKmg3yV/Zv7GeAkhh9SQG2Wi1fRwEMGSoVy3OUBFlXD7hQKwA8YY/ADaHtV8kC2scpId6VSZZtLty7JhuW/ubPvOOxlMoHUS2SF/pUEYSd6efTvXvqvU05l1nWStkD02StLpY76C9qvO5etBokUL6v4RTZH/R61O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkRUVanp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A2AC4CEDD;
	Wed,  2 Apr 2025 09:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743586200;
	bh=8AFyzMkukXlIorZLfhC8lT6o/ZfWhcX4UZ5ou9xw/mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EkRUVanppkTZ67CfJ+qYTGPjXlJ6n1t58y4XgG6vF7KApERFXt7jVlZnDUJ+TlRvh
	 9nxJTJZJBURBdMk+GG0U+2p6d9Iwo+eZk/h3nEZj81UPC6ptweNJJzj0Sz9Yp3seAe
	 WOgDnRckZ1nimORHbzA9zMRDz//pyd34CRpo4zTZ35ItUrIj4G7FvxikHSW1SvGJbD
	 GXvBg6gRlMUAXblE5PZyJ3dz7N7CCDb2Qk0ahi78lxi3SGrxH82/FbDIV3Mm9hByK4
	 1WOzFsbHx5GXaK6M2sMJS3imZG0cAUIsBdVq8Xl9MK7As0wnGXMPR5ejiE9bKRgWkE
	 0p2aHk0uKnBqQ==
Date: Wed, 2 Apr 2025 09:29:57 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH] drivers: iio: cros_ec_sensors: Flush changing the FIFO
 timeout
Message-ID: <Z-0DleD6CRIsz3mY@google.com>
References: <20250331164832.4039379-1-gwendal@chromium.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331164832.4039379-1-gwendal@chromium.org>

On Mon, Mar 31, 2025 at 09:48:32AM -0700, Gwendal Grignou wrote:
> fifo_timeout is used by the EC firmware only when a new sample is
> available.

I guess you mean: "FIFO timeout".  There is no specific symbol called
`fifo_timeout`.

> ---

"drivers: " in the patch's title prefix can be dropped.

> -static int cros_ec_sensor_set_ec_rate(struct cros_ec_sensors_core_state *st,
> -				      int rate)
> -{
> -	int ret;
> -
> -	if (rate > U16_MAX)
> -		rate = U16_MAX;
> -
> -	mutex_lock(&st->cmd_lock);
> -	st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
> -	st->param.ec_rate.data = rate;
> -	ret = cros_ec_motion_send_host_cmd(st, 0);
> -	mutex_unlock(&st->cmd_lock);
> -	return ret;
> -}
> -
>  static ssize_t cros_ec_sensor_set_report_latency(struct device *dev,
>  						 struct device_attribute *attr,
>  						 const char *buf, size_t len)
> @@ -134,7 +118,25 @@ static ssize_t cros_ec_sensor_set_report_latency(struct device *dev,
>  
>  	/* EC rate is in ms. */
>  	latency = integer * 1000 + fract / 1000;
> -	ret = cros_ec_sensor_set_ec_rate(st, latency);
> +
> +	mutex_lock(&st->cmd_lock);
> +	st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
> +	st->param.ec_rate.data = min(U16_MAX, latency);
> +	ret = cros_ec_motion_send_host_cmd(st, 0);
> +	mutex_unlock(&st->cmd_lock);
> +	if (ret < 0)
> +		return ret;

It isn't obvious (at least irrelevant to the commit message) that
cros_ec_sensor_set_ec_rate() becomes inline here.

> @@ -152,7 +154,6 @@ static ssize_t cros_ec_sensor_get_report_latency(struct device *dev,
>  	mutex_lock(&st->cmd_lock);
>  	st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
>  	st->param.ec_rate.data = EC_MOTION_SENSE_NO_VALUE;
> -
>  	ret = cros_ec_motion_send_host_cmd(st, 0);
>  	latency = st->resp->ec_rate.ret;
>  	mutex_unlock(&st->cmd_lock);

Unwanted change.

> @@ -853,6 +858,16 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
>  		st->param.sensor_odr.roundup = 1;
>  
>  		ret = cros_ec_motion_send_host_cmd(st, 0);
> +
> +		/* Flush the FIFO in case we are stopping a sensor.
> +		 * If the FIFO has just been emptied, pending samples will be
> +		 * stuck until new samples are available. It will not happen
> +		 * when all the sensors are stopped.
> +		 */
> +		if (frequency == 0) {
> +			st->param.cmd = MOTIONSENSE_CMD_FIFO_FLUSH;
> +			cros_ec_motion_send_host_cmd(st, 0);

Wouldn't it want to check `ret` from previous cros_ec_motion_send_host_cmd()
and override `ret` by the latest call?

