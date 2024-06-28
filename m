Return-Path: <linux-iio+bounces-7032-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F8991C662
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 21:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F3C1281A42
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 19:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A663873466;
	Fri, 28 Jun 2024 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qknRx32z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F04E6EB56;
	Fri, 28 Jun 2024 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719601722; cv=none; b=iq6qjFRu5PeFaxjkXnqhWp/nKORmN43xsfRdCSR6yC+18mF0PplorJOesrU6kwAiPOi+chSebYkZ9DNbyMIXQ/8UWfLx3+3nQ/Niopgos8n3adMNY9aFYYZ9AFgdwiJ350Z4BkRhefECb7iEmR9Gj6n82qOsTc9ZzCgy57ZUcq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719601722; c=relaxed/simple;
	bh=e9grNQ3HIDWrOxb68W815q7PLDeOfmbqGLJtbuYESHM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ux5SICgBpWphvr7dTEMdVDLwN5EoyneATboZzkKVCrCEqv2xv4FFT2RNgHPZCwBn1iuabWlDV39AAKikw4ijBthlPriMIV4NYrtFFbKdJD0xS/p4OJsjZwV73Cq3+SK8GQblDp055kpFwpOQ+83xyX/xlnVc0ayj8LfnLQlgwt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qknRx32z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31B3C116B1;
	Fri, 28 Jun 2024 19:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719601721;
	bh=e9grNQ3HIDWrOxb68W815q7PLDeOfmbqGLJtbuYESHM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qknRx32z/f0BEsD7wRERvSvK05nFQ9raDozdkbS08y2foJ+3Nbpi0j5nQytQB90D/
	 0VF+J9qYuM/29Hee7ASc9PtH4oZAPRq+nyHhIuHu+jaYxApdgJiCRKQXL63lqVqTK3
	 K8X1XKq3QUFmhfNbLCaPnqqB6YwuwDHkT5uF6DAK8/tzM4kP5Yp2mQPf7nR2SJ5Dr2
	 S8DKosUq6f5yW1UfLT5JXynB0VEAgLWnxDDrh1tq4oA+jiuO3suHgbf2dJYjajrrA4
	 LcAPvQkVJJSOli2Mp6wDpSUG/5IdzR0I0pCcRDCExWUSl9i56uG5diY6+IgXovZwNN
	 g45LJagz6AboQ==
Date: Fri, 28 Jun 2024 20:08:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
 linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 2/2] hwmon: iio: Add labels from IIO channels
Message-ID: <20240628200834.44c6453a@jic23-huawei>
In-Reply-To: <f6ee3049-47a0-4c84-ab90-2321bf6970d0@linux.dev>
References: <20240624174601.1527244-1-sean.anderson@linux.dev>
	<20240624174601.1527244-3-sean.anderson@linux.dev>
	<ff43e01e-5a26-4b75-bfaa-ed3ad4395e7c@roeck-us.net>
	<20240624202433.29564802@jic23-huawei>
	<f6ee3049-47a0-4c84-ab90-2321bf6970d0@linux.dev>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 14:37:01 -0400
Sean Anderson <sean.anderson@linux.dev> wrote:

> On 6/24/24 15:24, Jonathan Cameron wrote:
> > On Mon, 24 Jun 2024 11:47:39 -0700
> > Guenter Roeck <linux@roeck-us.net> wrote:
> >   
> >> On 6/24/24 10:46, Sean Anderson wrote:  
> >> > Add labels from IIO channels to our channels. This allows userspace to
> >> > display more meaningful names instead of "in0" or "temp5".
> >> > 
> >> > Although lm-sensors gracefully handles errors when reading channel
> >> > labels, the ABI says the label attribute
> >> >     
> >> >> Should only be created if the driver has hints about what this voltage
> >> >> channel is being used for, and user-space doesn't.    
> >> > 
> >> > Therefore, we test to see if the channel has a label before
> >> > creating the attribute.
> >> >     
> >> 
> >> FWIW, complaining about an ABI really does not belong into a commit
> >> message. Maybe you and lm-sensors don't care about error returns when
> >> reading a label, but there are other userspace applications which may
> >> expect drivers to follow the ABI. Last time I checked, the basic rule
> >> was still "Don't break userspace", and that doesn't mean "it's ok to
> >> violate / break an ABI as long as no one notices".
> >>   
> >> > Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> >> > ---
> >> > 
> >> > Changes in v2:
> >> > - Check if the label exists before creating the attribute
> >> > 
> >> >   drivers/hwmon/iio_hwmon.c | 45 ++++++++++++++++++++++++++++++++++-----
> >> >   1 file changed, 40 insertions(+), 5 deletions(-)
> >> > 
> >> > diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
> >> > index 4c8a80847891..5722cb9d81f9 100644
> >> > --- a/drivers/hwmon/iio_hwmon.c
> >> > +++ b/drivers/hwmon/iio_hwmon.c
> >> > @@ -33,6 +33,17 @@ struct iio_hwmon_state {
> >> >   	struct attribute **attrs;
> >> >   };
> >> >   
> >> > +static ssize_t iio_hwmon_read_label(struct device *dev,
> >> > +				  struct device_attribute *attr,
> >> > +				  char *buf)
> >> > +{
> >> > +	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
> >> > +	struct iio_hwmon_state *state = dev_get_drvdata(dev);
> >> > +	struct iio_channel *chan = &state->channels[sattr->index];
> >> > +
> >> > +	return iio_read_channel_label(chan, buf);
> >> > +}
> >> > +    
> >> 
> >> I personally find it a bit kludgy that an in-kernel API would do a
> >> sysfs write like this and expect a page-aligned buffer as parameter,
> >> but since Jonathan is fine with it:  
> > 
> > That's a good point that I'd not picked up on and it probably makes sense
> > to address that before it bites us on some other subsystem.
> > 
> > It was more reasonable when the only path was to a light wrapper that went
> > directly around the sysfs callback. Now we are wrapping these up for more
> > general use we should avoid that restriction.
> > 
> > Two approaches to that occur to me.
> > 1) Fix up read_label() everywhere to not use sysfs_emit and take a size
> >    of the buffer to print into. There are only 11 implementations so
> >    far so this should be straight forward.  
> 
> This API is the same as the existing iio_read_channel_ext_info. It is
> used for the same purpose: forwarding sysfs reads/writes from one
> device to another (see e.g. iio-mux and iio-rescale). ext_info is used
> by around 85 drivers, so it is not so trivial to change the API. While I
> agree that the current API is unusual, it's not too bad given that we
> get the same guarantees from device_attribute.show.

Fair enough.  Maybe we can clean this up at somepoint but let's not do 
it today. Applied to the togreg branch of iio.git and pushed out as testing for
0-day to poke at it and maybe find something we missed.

Jonathan

> 
> --Sean
> 
> > 2) Add a bounce buffer so we emit into a suitable size for sysfs_emit()
> >   then reprint from there into a buffer provided via this interface with
> >   the appropriate size provided.  This one is clunky and given the relatively
> >   few call sits I think fixing it via option 1 is the better route forwards.  
> 
> 


