Return-Path: <linux-iio+bounces-6837-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73365915719
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 21:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212681F2575B
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 19:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDDE1A00EF;
	Mon, 24 Jun 2024 19:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cp4l7Pav"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1373C3A1A8;
	Mon, 24 Jun 2024 19:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719257081; cv=none; b=Bftdi/MqQWosOO5a3BCEq+dtQmeLhVpvhh40xcs+giwPzCmGmXMrzAjyIlizF+Z7W3RtPc2d7Pxd3G61+FuQg2ynbh09HMagM3oYEP6xWKB/j5AMhGfNthjy++Fp117ik3zLoeaKBZpM6TrZwGbb7XKETCojUaaKgLXtwV/l86s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719257081; c=relaxed/simple;
	bh=THHerX9VKK9eiYYoRM4Rium1mANrF3Sydv039s+f3XA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chFgIV88ellmIeQEsiCbtV/fM7XvXoiZgjaQy5s49xClhD/gb1kBJ70hl0Yn/AUXpkyzGK3hKMp+R0PS8aNUZKSFzxr5wURuQ+Lu8mQJDusLnSCimkONN2KhtOYlfeX/KSmrjjvC8UQygHS9L7d2hfuuoPVXQ0PwMhhr5dBj5FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cp4l7Pav; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E32C2BBFC;
	Mon, 24 Jun 2024 19:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719257080;
	bh=THHerX9VKK9eiYYoRM4Rium1mANrF3Sydv039s+f3XA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cp4l7PaviaEy6YJPLRoWd+76FRUoGC1HAlupSulljKPu14wZxdTYrJ+CLydYeftHg
	 Oqnc/uKpENqHgGeLwOypGoM/m+/9zIWvAITTgGp2uQMeZkg2mWWaE+ayc6GUsevy/W
	 sAhb41HSRaB2Pibt7aH4EA3KP1nwV1pkkIbz7/DKNaLxDv2S7BT1HBOcntqXsS+Mro
	 Q0f+guqPApf7spEONbHsOd++m3Znsdu/YOQVi+bNKYgdQaCfH7Xow4m+PHLHM9R3Ff
	 bm0j7chYYY/U07skWCIw43VrWEJliK//SB5Lzawwx0uVJfML3pzVtKlRkhgIMlix/G
	 /ILrWfZrh2/Qw==
Date: Mon, 24 Jun 2024 20:24:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Sean Anderson <sean.anderson@linux.dev>, Jean Delvare
 <jdelvare@suse.com>, linux-iio@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 2/2] hwmon: iio: Add labels from IIO channels
Message-ID: <20240624202433.29564802@jic23-huawei>
In-Reply-To: <ff43e01e-5a26-4b75-bfaa-ed3ad4395e7c@roeck-us.net>
References: <20240624174601.1527244-1-sean.anderson@linux.dev>
	<20240624174601.1527244-3-sean.anderson@linux.dev>
	<ff43e01e-5a26-4b75-bfaa-ed3ad4395e7c@roeck-us.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 11:47:39 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 6/24/24 10:46, Sean Anderson wrote:
> > Add labels from IIO channels to our channels. This allows userspace to
> > display more meaningful names instead of "in0" or "temp5".
> > 
> > Although lm-sensors gracefully handles errors when reading channel
> > labels, the ABI says the label attribute
> >   
> >> Should only be created if the driver has hints about what this voltage
> >> channel is being used for, and user-space doesn't.  
> > 
> > Therefore, we test to see if the channel has a label before
> > creating the attribute.
> >   
> 
> FWIW, complaining about an ABI really does not belong into a commit
> message. Maybe you and lm-sensors don't care about error returns when
> reading a label, but there are other userspace applications which may
> expect drivers to follow the ABI. Last time I checked, the basic rule
> was still "Don't break userspace", and that doesn't mean "it's ok to
> violate / break an ABI as long as no one notices".
> 
> > Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> > ---
> > 
> > Changes in v2:
> > - Check if the label exists before creating the attribute
> > 
> >   drivers/hwmon/iio_hwmon.c | 45 ++++++++++++++++++++++++++++++++++-----
> >   1 file changed, 40 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
> > index 4c8a80847891..5722cb9d81f9 100644
> > --- a/drivers/hwmon/iio_hwmon.c
> > +++ b/drivers/hwmon/iio_hwmon.c
> > @@ -33,6 +33,17 @@ struct iio_hwmon_state {
> >   	struct attribute **attrs;
> >   };
> >   
> > +static ssize_t iio_hwmon_read_label(struct device *dev,
> > +				  struct device_attribute *attr,
> > +				  char *buf)
> > +{
> > +	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
> > +	struct iio_hwmon_state *state = dev_get_drvdata(dev);
> > +	struct iio_channel *chan = &state->channels[sattr->index];
> > +
> > +	return iio_read_channel_label(chan, buf);
> > +}
> > +  
> 
> I personally find it a bit kludgy that an in-kernel API would do a
> sysfs write like this and expect a page-aligned buffer as parameter,
> but since Jonathan is fine with it:

That's a good point that I'd not picked up on and it probably makes sense
to address that before it bites us on some other subsystem.

It was more reasonable when the only path was to a light wrapper that went
directly around the sysfs callback. Now we are wrapping these up for more
general use we should avoid that restriction.

Two approaches to that occur to me.
1) Fix up read_label() everywhere to not use sysfs_emit and take a size
   of the buffer to print into. There are only 11 implementations so
   far so this should be straight forward.

2) Add a bounce buffer so we emit into a suitable size for sysfs_emit()
  then reprint from there into a buffer provided via this interface with
  the appropriate size provided.  This one is clunky and given the relatively
  few call sits I think fixing it via option 1 is the better route forwards.
 
Jonathan


> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> 
> Jonathan, please apply through your tree.
> 
> Thanks,
> Guenter
> 


