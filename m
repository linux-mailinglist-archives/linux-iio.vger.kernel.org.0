Return-Path: <linux-iio+bounces-17996-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ABBA86C95
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 12:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B51A17751A
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 10:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35B01BD9E3;
	Sat, 12 Apr 2025 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMEfyRDF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F2F194AD5;
	Sat, 12 Apr 2025 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744454583; cv=none; b=JpCcVG9wFfefO5EBAKZ5P7LrZMgbZafTAH1z4Ox+481AFEIIEYVA2rXA9pqL+lIQlrsv91Ya8R28glckaZ4E2X46JyLZd1DWSRRvivXS3VMDmIgtlwTlLrInmWF9KchUHqn6UKl1aY91bYGkf5Q5loZQbiVVE6vQAemdjsTB4js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744454583; c=relaxed/simple;
	bh=OVYXXaVo+7EApCnWszZxt8gK0Gni9T29JmvAc0v2vJg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cmE0xUEMxTdTK8rHwyfYAzvOQ5kbUA0MG7WkETjKKELkf4mizcI5FXWtjKvdPXoqY/n+WZD2aWahqs34rJnkS9b3q1x1rDQ8VatbRG6ZHM1KO7HgafnW2wQmGOjl2wriyu3GuYDepgXmj0SE7N6LfRQSXdn6PXwiBadxQHPTLLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMEfyRDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C24C4CEE3;
	Sat, 12 Apr 2025 10:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744454583;
	bh=OVYXXaVo+7EApCnWszZxt8gK0Gni9T29JmvAc0v2vJg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gMEfyRDFWZwqYcjln67BRrmwiNxLDQDSyKYmh1KAp7TtJsScPyisImBRx6yza5qsY
	 mjIP3KfmTZTht50hpGzjryeyQlt+ezLTgqjhgfKevjeZzEb0ZYCtBARINEdtMcMx11
	 NFogcTPOO74u9vNuopp95gXx8Kbpj4JajWK3p5W07GHw6ACLY8A/EKYVp6kCtMCEKU
	 xu32245N8KC+aeYRG9yIPiO6FUHE/DC7L7uo5CdUv2eHQBudZTfafZChgAsrjTVD3a
	 uX+D3Xtc9yOp4Eu9r/pnAz185Mic4wQqM/xOnTFjuDaNS5BZ1S+Oe9nLEJY4ecYn3p
	 Ox4StUh5lKEKw==
Date: Sat, 12 Apr 2025 11:42:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: tzungbi@kernel.org, linux-iio@vger.kernel.org,
 chrome-platform@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v3] iio: cros_ec_sensors: Flush when changing the FIFO
 timeout
Message-ID: <20250412114256.41602d67@jic23-huawei>
In-Reply-To: <20250408155619.2169189-1-gwendal@chromium.org>
References: <CAPUE2uuY=BaPFro5cQSmQg4JS1Z5J5aBL7XvqqAo-X=LR4be3Q@mail.gmail.com>
	<20250408155619.2169189-1-gwendal@chromium.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Apr 2025 08:56:19 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> |hwfifo_timeout| is used by the EC firmware only when new samples are
> available.
> When the timeout changes, espcially when the new timeout is shorter than
> the current one, send the samples waiting in the FIFO to the host.
> Inline the call to transmit |hwfifo_timeout| value to the firmware.
> 
> Now flush when a sensor is suspended (ODR set to 0) as well.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Firstly.  Don't send a new version in reply to an old one.
In general the reasons for this are:
1 - it can get very confusing if a thread gets deeply nested.
2 - at least some well known kernel folk start at their most recent emails
    and work backwards when looking for what to review.  They will probably
    never get to your thread!

There may be other parts of the kernel that prefer this style, but most
do not and I've never had anyone 'ask' for it (as opposed to not object).

Various minor comments inline.

Thanks,
Jonathan

> ---
> Changes in v3:
> - Fix error detection when setting the sensor frequency
> 
> Changes in v2:
> - Fix sysfs attribute in commit message
> - Indicated the function to send the content of the attribute is now
>   inline.
> - Improve error detection when setting the sensor frequency and flusing
>   the FIFO.
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 50 ++++++++++++-------
>  1 file changed, 33 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index b1abd6e16c4ba..67ffe88df7b23 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -103,22 +103,6 @@ static void get_default_min_max_freq(enum motionsensor_type type,
>  	}
>  }
>  
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
Maybe use cleanup.h and
	guard(mutex)(&st->cmd_lock);
mostly because it simplifies code and...
> +	st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
> +	st->param.ec_rate.data = min(U16_MAX, latency);
> +	ret = cros_ec_motion_send_host_cmd(st, 0);
> +	mutex_unlock(&st->cmd_lock);

I'm not sure why you unlock briefly here?

> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Flush samples currently in the FIFO, especially when the new latency
> +	 * is shorter than the old one: new timeout value is only considered when
> +	 * there is a new sample available. It can take a while for a slow
> +	 * sensor.
> +	 */
> +	mutex_lock(&st->cmd_lock);
> +	st->param.cmd = MOTIONSENSE_CMD_FIFO_FLUSH;
> +	ret = cros_ec_motion_send_host_cmd(st, 0);
> +	mutex_unlock(&st->cmd_lock);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -764,6 +766,8 @@ EXPORT_SYMBOL_GPL(cros_ec_sensors_capture);
>   * @mask:	specifies which values to be requested
>   *
>   * Return:	the type of value returned by the device
> + *
> + * cmd_lock mutex held.

Maybe true, but has that changed in a fashion that means this should
be in this fix patch rather than a follow up improving documentation?

>   */
>  int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
>  			  struct iio_chan_spec const *chan,
> @@ -836,6 +840,8 @@ EXPORT_SYMBOL_GPL(cros_ec_sensors_core_read_avail);
>   * @mask:	specifies which values to write
>   *
>   * Return:	the type of value returned by the device
> + *
> + * cmd_lock mutex held.
As above.

>   */
>  int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
>  			       struct iio_chan_spec const *chan,
> @@ -853,6 +859,16 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
>  		st->param.sensor_odr.roundup = 1;
>  
>  		ret = cros_ec_motion_send_host_cmd(st, 0);
I'd rather see
		if (ret)
			break;
given local style.

Ideal would actually be to make this whole function do direct returns on error
as that is easier to follow in cases like this where there is no cleanup.
However that change doesn't belong in a fix. Something for another day!

> +
> +		/* Flush the FIFO in case we are stopping a sensor.
Comment syntax slightly wrong.

		/*
		 * Flush the FIFO

> +		 * If the FIFO has just been emptied, pending samples will be
> +		 * stuck until new samples are available. It will not happen
> +		 * when all the sensors are stopped.
> +		 */
> +		if (ret == 0 && frequency == 0) {

With the break above, only need to check frequency here.

> +			st->param.cmd = MOTIONSENSE_CMD_FIFO_FLUSH;
> +			ret = cros_ec_motion_send_host_cmd(st, 0);
> +		}
>  		break;
>  	default:
>  		ret = -EINVAL;


