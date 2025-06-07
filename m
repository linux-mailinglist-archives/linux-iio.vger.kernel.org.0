Return-Path: <linux-iio+bounces-20303-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 703ECAD0E91
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 18:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2542216BA85
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 16:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D67A1EB1AF;
	Sat,  7 Jun 2025 16:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SY7GU4AJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D121A1F0E25;
	Sat,  7 Jun 2025 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749313803; cv=none; b=Pfb1dzRd3GMd+2A4Ndsekr7T+8UPTA0E23cZJQ0iD3Upxf45g6Wgsy001SWxJQTLu5hYYT33TUw8VMO00WYv1XBU6VUT6IsPPvG5jMSVTNq0tL4qi0Ekkgg5JDTIs8h+NRGgdPUStckUHGyNLshRqsG8VN9AFk9jlu5INyeK8Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749313803; c=relaxed/simple;
	bh=mdwuGqZdvgfHob0Ke5t0pInz+LjwXGrddpBQt7quttE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YHfJv8vjTEPVDajzxUbdzOb6bZ8ld9J6ykIgrq5TvrG/p3Gf/W3plt6OZkYt7iYkaCr2OlRj0alwVKaPxPPpx++twgFs1wmWG6YFWX3JFqQIWS+wJAowJavg/WNI0pMfpj0GvUQAPRoNfLocAMpf6cfML2vyrXyQKInuK+AwGlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SY7GU4AJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0E2C4CEE4;
	Sat,  7 Jun 2025 16:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749313803;
	bh=mdwuGqZdvgfHob0Ke5t0pInz+LjwXGrddpBQt7quttE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SY7GU4AJfvsK+1j8n/dGDKwvhcPHOxcBtGjpyj3sl+HTI92tPc6EntDJJryP1iMYI
	 lWKtAsrRUY2/FX4nlRwtWTBxwmhod2fp6iM5Pyv1+sbTcgh7Sv6q4jZ3b4sF/mQhvv
	 lbOxyN5rQbyec5RcrbHV0d0y085SFrfrWKuUhCxVRh4aFEIsDOTNTFZ1eeCGWVQ+EP
	 gN1pGaf0sbPeVkmFrnqcM7Im8vYLax4oyVOmZK0hMYyj4YJ1ageTcjZ1EFZzQtBAN+
	 N2Y+ocHHwT4T4xy82i+ARisGpcJChWYnLSLO5mhuRHCGJI9coCu1zKKsgDU7DlPA1j
	 s4lrTPaBAXr4A==
Date: Sat, 7 Jun 2025 17:29:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Gwendal Grignou <gwendal@chromium.org>, chrome-platform@lists.linux.dev,
 linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH v5] iio: cros_ec_sensors: add cros_ec_activity driver
Message-ID: <20250607172956.573b1ed4@jic23-huawei>
In-Reply-To: <aEE5K9DnEOcKZf8P@google.com>
References: <20250604053903.1376465-1-gwendal@google.com>
	<aEE5K9DnEOcKZf8P@google.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Jun 2025 06:28:59 +0000
Tzung-Bi Shih <tzungbi@kernel.org> wrote:

> On Tue, Jun 03, 2025 at 10:39:03PM -0700, Gwendal Grignou wrote:
> > ChromeOS EC can report activity information derived from the
> > accelerometer:
> > - Reports on-body/off-body as a proximity event.
> > - Reports significant motion as an activity event.
> > 
> > This new sensor is a virtual sensor, included only when the EC firmware
> > is compiled with the appropriate module.
> > 
> > Signed-off-by: Gwendal Grignou <gwendal@google.com>
> > Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
> > ---
> > [...]
> > Changes in v5:
> > - Use guard(mutex), simplify error path.
> > - Use driver name as function prefix.
> > - Remove cros_ec_sensors_remove function.
> > - Remove identation of structure field.
> > - Invert raw value to return 1m when far, 0m when close.  
> 
> As v5 changed a bit from v4, it'd be better to drop my R-b tag in v5.
> 
> Anyway, it overall looks good to me.  Only a few minor comments:
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
> 
> > +static int cros_ec_activity_read_event_config(struct iio_dev *indio_dev,
> > +					      const struct iio_chan_spec *chan,
> > +					      enum iio_event_type type,
> > +					      enum iio_event_direction dir)
> > +{
> > +	struct cros_ec_sensors_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	if (chan->type != IIO_ACTIVITY && chan->type != IIO_PROXIMITY)
> > +		return -EINVAL;
> > +
> > +	guard(mutex)(&st->core.cmd_lock);
> > +	st->core.param.cmd = MOTIONSENSE_CMD_LIST_ACTIVITIES;
> > +	ret = cros_ec_motion_send_host_cmd(&st->core, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	switch (chan->type) {
> > +	case IIO_PROXIMITY:
> > +		return !!(st->core.resp->list_activities.enabled &
> > +			 (1 << MOTIONSENSE_ACTIVITY_BODY_DETECTION));
> > +	case IIO_ACTIVITY:
> > +		if (chan->channel2 == IIO_MOD_STILL) {
> > +			return !!(st->core.resp->list_activities.enabled &
> > +				 (1 << MOTIONSENSE_ACTIVITY_SIG_MOTION));
> > +		} else {
> > +			dev_warn(&indio_dev->dev, "Unknown activity: %d\n",
> > +				 chan->channel2);
> > +			return -EINVAL;
> > +		}  
> 
> By referencing to cros_ec_activity_write_event_config(), maybe consider to
> drop the " else {" and "}".

Agreed. I tweaked this.

> 
> > +static int cros_ec_activity_write_event_config(struct iio_dev *indio_dev,
> > +					       const struct iio_chan_spec *chan,
> > +					       enum iio_event_type type,
> > +					       enum iio_event_direction dir,
> > +					       int state)
> > +{
> > +	struct cros_ec_sensors_state *st = iio_priv(indio_dev);
> > +  
> 
> By referencing to cros_ec_activity_read_event_config(), maybe consider to
> exit the function earlier:
> 	if (chan->type != IIO_ACTIVITY && chan->type != IIO_PROXIMITY)
In this case we aren't really doing anything before the switch statement, unlike
read where we read the data from the device.

So I left this one alone.

Needed another couple of tweaks.  Signature of this function now takes
a bool state and the { }, fix was already present upstream.
Also some mess in the Makefile due to tracing patch that it seems
you don't have on your tree.

Please check the result. Pushed out for now as testing but I'll rebase
on rc1 sometime soon.

Jonathan



