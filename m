Return-Path: <linux-iio+bounces-5637-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9208D76D9
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 17:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7401C20CC3
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 15:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E819C42040;
	Sun,  2 Jun 2024 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gW8RrUQJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FD3482DE;
	Sun,  2 Jun 2024 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717343279; cv=none; b=cue6P9ffHCQ3Iup/T2v9MdYKfkVt4nLPEbTw4F9jrJnwlshyPhrBT3x7xn4IAvxkJ9ejGu+5CsdteiGXXEZU4dLvtWlwpuGeRd1grmVAom5yAkGQZrpkwB7X1wf60HaiPVHzBoZv6/lt3QIVFceB+8OQgzsqwGYmasAkajctkGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717343279; c=relaxed/simple;
	bh=CbNVb56+m+eYYQ9I9qraw3IWiMGdNwmgBoRMRnNq6uw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t1PwdzNhHUSEOkdLWTLz5q6vEcM1CKQDIjr4xG5Vp2CBDzzeN9a4SAbObOyNTE6WAZq4NmyuLHT/nUZYPaaqSSLduxJJPNTH1ifiWZI344FuLxAGpymRpDodj3p/IL9h3N1Sn+pZNy7DHAIK3U0EGO2BG4zaCTvaJVa9Aa6sZlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gW8RrUQJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F177CC32781;
	Sun,  2 Jun 2024 15:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717343279;
	bh=CbNVb56+m+eYYQ9I9qraw3IWiMGdNwmgBoRMRnNq6uw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gW8RrUQJlVY9jBhL+VlIj3Uu7jZLxonQmZS53By2EB/dxYcaLR2aS+YQk1cS6WukY
	 nDCiwaVqUTbQN3tX0aXzLnnhBIEQghooHovnJz/+/Zd0tSs8fngni44/gJgCD7frLz
	 evsddKFGiXULmGSF40fBM3EI9VDfI6naloq0ErZxVGsYWaStLDmawXNm7UV0VmtUlz
	 +VLGUqrjuDujmbcYM47pL419lhkaK3P+IHtTAI0Wmeo1wYo+a98ralZXWFQAfbA4Xo
	 dydVTadZXN25Vs8UU8j6ICoDE89H8aPYL64K7O75DJ1RN8+8E/uRDEHSc2EXFIJqlJ
	 vUFxycyhLCqIA==
Date: Sun, 2 Jun 2024 16:47:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Andrew Hepp
 <andrew.hepp@ahepp.dev>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: temperature: mcp9600: add threshold events
 support
Message-ID: <20240602164747.355772f7@jic23-huawei>
In-Reply-To: <20240526055234.736862-1-dima.fedrau@gmail.com>
References: <20240526055234.736862-1-dima.fedrau@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 May 2024 07:52:34 +0200
Dimitri Fedrau <dima.fedrau@gmail.com> wrote:

> The device has four programmable temperature alert outputs which can be
> used to monitor hot or cold-junction temperatures and detect falling and
> rising temperatures. It supports up to 255 degree celsius programmable
> hysteresis. Each alert can be individually configured by setting following
> options in the associated alert configuration register:
> - monitor hot or cold junction temperature
> - monitor rising or falling temperature
> - set comparator or interrupt mode
> - set output polarity
> - enable alert
> 
> This patch binds alert outputs to iio events:
> - alert1: hot junction, rising temperature
> - alert2: hot junction, falling temperature
> - alert3: cold junction, rising temperature
> - alert4: cold junction, falling temperature
> 
> All outputs are set in comparator mode and polarity depends on interrupt
> configuration.
> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
Hi Dimitri

I'm afraid I forgot to check you were handling the case of missing
interrupts in previous reviews.  The handling doesn't need to be
comprehensive but given the driver previously didn't support events
it seems likely people might not have wired them.

I think you should definitely handle 'no interrupts'
but it is probably fine to not bother with complexity of only some
of them wired unless a user actually shows up who cares about that.

See below for more on this.

Jonathan


> ---
> 
> Changes in V2:
>   - Remove pretty printing patches from series
>   - Add patch for providing index for both channels(ABI change)!
>     Suggested by Jonathan, hope this okay.
>   - Remove formatting in a precursor patch
>   - Add lock documentation
>   - Add define MCP9600_TEMP_SCALE_NUM and use it instead of MICRO. MICRO is
>     type unsigned long which we have to cast to int when using
>     multiplication or division, because we are handling negative values.
>   - Use switch statement in mcp9600_write_thresh
>   - Replaced generic interrupt handler with four separate interrupt handler
>   - Use one lock instead of four
>   - Added error check for mcp9600_probe_alerts
> 
> Changes in V3:
>   - Remove patch for providing index for both channels(ABI change)!
>   - Treat hysteresis as offset and remove the lock, since dependency
>     between hysteresis and threshold doesn't exist anymore.
>   - Use helper function for handling alerts to avoid code duplication
>   - Scale max,min defines for hot and cold junction temperature to micro
> 
> Changes in V4:
>   - Added version number of patch
> 
> ---
>  drivers/iio/temperature/mcp9600.c | 319 ++++++++++++++++++++++++++++++
>  1 file changed, 319 insertions(+)
> 
> diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
> index 46845804292b..1f34f0bab22f 100644
> --- a/drivers/iio/temperature/mcp9600.c
> +++ b/drivers/iio/temperature/mcp9600.c
> @@ -6,28 +6,90 @@
>   * Author: <andrew.hepp@ahepp.dev>
>   */
>  
>
> +
>  static const struct iio_chan_spec mcp9600_channels[] = {
>  	{
>  		.type = IIO_TEMP,
>  		.address = MCP9600_HOT_JUNCTION,
>  		.info_mask_separate =
>  			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +		.event_spec = mcp9600_events,
> +		.num_event_specs = ARRAY_SIZE(mcp9600_events),
>  	},
>  	{
>  		.type = IIO_TEMP,
> @@ -36,6 +98,8 @@ static const struct iio_chan_spec mcp9600_channels[] = {
>  		.modified = 1,
>  		.info_mask_separate =
>  			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +		.event_spec = mcp9600_events,
> +		.num_event_specs = ARRAY_SIZE(mcp9600_events),
>  	},
>  };

What if the irq isn't wired?  We still get all the interfaces but
I assume the don't do anything.

Usual trick is to pick between two sets of channels depending on whether
the interrupts are present.

Here is is fiddly because of the 4 separate alert lines.
I think a compromise would be to have the driver only use interrupts
if all 4 are present.  If less than that are present don't register
channels with the event_spec etc.

That will require you to check for all the interrupts before starting
to register any of them which is a little messy but not too bad.



>  
> @@ -79,10 +143,260 @@ static int mcp9600_read_raw(struct iio_dev *indio_dev,
>  	}
>  }

>
> +
> +static irqreturn_t mcp9600_alert1_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
Trivial: Shouldn't need the local variable. Just pass private in directly
to your mcp9600_alert_handler() 

> +
> +	return mcp9600_alert_handler(indio_dev, MCP9600_ALERT1, IIO_NO_MOD,
> +				     IIO_EV_DIR_RISING);
> +}
> +
> +static irqreturn_t mcp9600_alert2_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +
> +	return mcp9600_alert_handler(indio_dev, MCP9600_ALERT2, IIO_NO_MOD,
> +				     IIO_EV_DIR_FALLING);
> +}
> +
> +static irqreturn_t mcp9600_alert3_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +
> +	return mcp9600_alert_handler(indio_dev, MCP9600_ALERT3,
> +				     IIO_MOD_TEMP_AMBIENT, IIO_EV_DIR_RISING);
> +}
> +
> +static irqreturn_t mcp9600_alert4_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +
> +	return mcp9600_alert_handler(indio_dev, MCP9600_ALERT4,
> +				     IIO_MOD_TEMP_AMBIENT, IIO_EV_DIR_FALLING);
> +}



