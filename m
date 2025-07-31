Return-Path: <linux-iio+bounces-22164-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47133B16FDB
	for <lists+linux-iio@lfdr.de>; Thu, 31 Jul 2025 12:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DB8C582A16
	for <lists+linux-iio@lfdr.de>; Thu, 31 Jul 2025 10:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347DD2BD5A3;
	Thu, 31 Jul 2025 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8YHkASB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63282F4FA;
	Thu, 31 Jul 2025 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959126; cv=none; b=YU+HKrQSZpGHU5taGQbGfA1avBhGZ/ByMVE0+794OaQierh8O2ovHEeh/K2s6jBtfjqLqHLNpb2lmrvJOjC+vwkUbU0ghZeStheCLk/q2fpHa3ZdNdVOTKyfNJrLXroZMS/1Lr8RO871jtt2NqrKQwSLeTzzpVe/2IJ3ZXPU7iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959126; c=relaxed/simple;
	bh=09eUtxy7BEVelvmPkGEU/1pIx6WqhhrhifwI4fNz/5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I37lqUrRhK+o1KzYIMApHjzbQDn95XLXndHVdVKNOIBsCuIyQDBP4HgjoapHTm145qSSWx4HL2o53BuaOTppDsJlusa6am8DG999Sj+wk9QU5FD7EA0NLNm391e0TM2i9p9nB8qnY1k/3HP/nCrTgbsI9ubaBmvWEK6LtJR4Fd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8YHkASB; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76bd041c431so325056b3a.2;
        Thu, 31 Jul 2025 03:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753959123; x=1754563923; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6BNm2GTevFRvXJYfacbCY9tU3bk2KY3Lo3LH5vZNBH4=;
        b=d8YHkASBecPls/MrQyu9w2eSwyMYebviY2YfjOhTnlApVFCV2ElfFbyupobcbEgUNY
         Y0zb2YZhFQjIku9JtJAlkpJ3V0kfqZjGvPOOzY+v4Aj+pkbaH9pT5MVQmPK/4PU59ZPU
         IbdMr49uydy+T1tljIoUS1XnF8v4AbLkVVFk3wKIaRLFvo9t/npA//NaukMvAGfa//zk
         ZzfeWHORNnp8YrMwcI9jbNYYBAf+kaGRv/1bbk2kOrwNqd55OYy+OJnkQM3rbBFMVywa
         Gml4d3yioJL7AtH0Qrq61hi8cxWNZWOGvq4SPBOsOxK8VWsW/KecG0/3PzR4of9dwF9T
         ootA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753959123; x=1754563923;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6BNm2GTevFRvXJYfacbCY9tU3bk2KY3Lo3LH5vZNBH4=;
        b=FXSKIWwwXsZhayZfIGcrzKyHMHhR+MBV53B5BIFeQ0KvX4q1mOwBFP4zGor2oq3h6w
         KQ1QqcW3eu8cpvYoh38wv8WPKSj5H10SQ9I+mtbxdHKArXladuzkBZv+WIF708tvX2JF
         HGTvOHC4QXtyW4sC9H5rbfkDebF6sOmzM/TLqy9gdIBIOrzpdG1j7jBiogK+nr9ZZPY1
         eqsVDrhl1+S3xbiEotCJQc/y55iSatoPIFpBCwjUmDNM1moXk7qkHK1JR0fyPLi3tQW2
         W9oel1SQ5leP7WCRFf9d2OZa48xxpdjk+GO1bb7O69m0b6Xko96udN5atD96OT+PyDCP
         e7mg==
X-Forwarded-Encrypted: i=1; AJvYcCVVqfNi0cmBiUxVs4KAxUMVBEAmKmgciEFMNk5MSK5EpKw5YmxEgu1mzLTOpcuAjA9zPFSGSLz+/Neq@vger.kernel.org, AJvYcCWV3LfCTh95OrxEi2JKoTKpcBNa35A+SvnECdQj3sZd9O6YxT9iMGmmBYbSsiSZbykJidD/pV8MYsR0ZQ==@vger.kernel.org, AJvYcCXApArLqWsWao9rlkZQriODxXiHaE0rJeAcDR/D0wD2MDcCxzDiFzimmGkoemmhO2doIsyFmqEsPbI1H/lQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwxdiGm93WaGm5U5dEx33vVBj+3+0HleRwUatkNjbZKeJYI2NFW
	C3t+aobAcb394Ie4jLkzXO4BUCCc8+Yb68DSdVuYXVdaZVgthuEsSZiN
X-Gm-Gg: ASbGncvQqsQopd6lmLtna3rGY8+DySv9IxWVZQapV3fxc9m4Z7OqFuDWFZ+JIxoQPyJ
	OGP3eCjcUOJ26xcbELsSctPae/CMBmuHHi3voBoF8dAy7/ADirFjFBLlh66dW05Ro7O8xiB8BDy
	bemgOq1fYQrB9pt/bMRDbkfNoAZ9I5YjIu2eaGYnXtNrmIEDk3pG+c/mKMfxHuFXBeqBSlomtvh
	28mPT+5K2mNnLU7FYZ91VNMN7LgAkUbCpDTJeevQnj5VhaG8uYHAZ5I/HeOlFpuPK6bP9Abqse+
	xT+xjxSO4CYnosi4ElEDS2shaMPKcsFAkI+KE1JWZNAi1/WkIyU+HMEOu5rpuqsOH39LOUz5DKz
	zmlzmVHnkWZ6v
X-Google-Smtp-Source: AGHT+IEpUbFQBDbBzG/lmEXfkVk7OLRqFxEmhc33scO+8gpDjGb2RBZveXq6rfWnEpiuwIUpv5arlg==
X-Received: by 2002:a05:6a00:ad6:b0:742:3fe0:8289 with SMTP id d2e1a72fcca58-76ab2b566b7mr10264426b3a.20.1753959123515;
        Thu, 31 Jul 2025 03:52:03 -0700 (PDT)
Received: from nsa ([45.248.78.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce89104sm1324539b3a.35.2025.07.31.03.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:52:02 -0700 (PDT)
Date: Thu, 31 Jul 2025 11:52:10 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Jonathan Cameron <jic23@kernel.org>, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 7/7] hwmon: iio: Add alarm support
Message-ID: <pblyblite64vy5ghk77crga5y6f2a6bmngtxu6rlqmq3p7rzxt@srquqhwt43nr>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
 <20250715012023.2050178-8-sean.anderson@linux.dev>
 <afc6aa6ad4b633f9d834acf933734985f14c5563.camel@gmail.com>
 <6455be16-d287-4d5e-9556-e1789d43708c@linux.dev>
 <9c6f99e022270b1b9c2f178f8f415270f11e59df.camel@gmail.com>
 <11735f77-25cc-4220-b7be-e6fda8f72161@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11735f77-25cc-4220-b7be-e6fda8f72161@linux.dev>

On Thu, Jul 17, 2025 at 12:00:13PM -0400, Sean Anderson wrote:
> On 7/16/25 02:37, Nuno Sá wrote:
> > On Tue, 2025-07-15 at 13:02 -0400, Sean Anderson wrote:
> >> On 7/15/25 07:28, Nuno Sá wrote:
> >> > On Mon, 2025-07-14 at 21:20 -0400, Sean Anderson wrote:
> >> > > Add alarm support based on IIO threshold events. The alarm is cleared on
> >> > > read, but will be set again if the condition is still present. This is
> >> > > detected by disabling and re-enabling the event. The same trick is done
> >> > > when creating the attribute to detect already-triggered events.
> >> > > 
> >> > > The alarms are updated by an event listener. To keep the notifier call
> >> > > chain short, we create one listener per iio device, shared across all
> >> > > hwmon devices.
> >> > > 
> >> > > To avoid dynamic creation of alarms, alarms for all possible events are
> >> > > allocated at creation. Lookup is done by a linear scan, as I expect
> >> > > events to occur rarely. If performance becomes an issue, a binary search
> >> > > could be done instead (or some kind of hash lookup).
> >> > > 
> >> > > Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> >> > > ---
> >> > > 
> >> > >  drivers/hwmon/iio_hwmon.c | 322 +++++++++++++++++++++++++++++++++++++-
> >> > >  1 file changed, 321 insertions(+), 1 deletion(-)
> >> > > 
> >> > > diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
> >> > > index 3db4d4b30022..c963bc5452ba 100644
> >> > > --- a/drivers/hwmon/iio_hwmon.c
> >> > > +++ b/drivers/hwmon/iio_hwmon.c
> >> > > @@ -8,6 +8,7 @@
> >> > >  #include <linux/slab.h>
> >> > >  #include <linux/mod_devicetable.h>
> >> > >  #include <linux/module.h>
> >> > > +#include <linux/notifier.h>
> >> > >  #include <linux/err.h>
> >> > >  #include <linux/platform_device.h>
> >> > >  #include <linux/property.h>
> >> > > @@ -15,7 +16,192 @@
> >> > >  #include <linux/hwmon.h>
> >> > >  #include <linux/hwmon-sysfs.h>
> >> > >  #include <linux/iio/consumer.h>
> >> > > +#include <linux/iio/events.h>
> >> > > +#include <linux/iio/iio.h>
> >> > >  #include <linux/iio/types.h>
> >> > > +#include <uapi/linux/iio/events.h>
> >> > > +
> >> > > +/* Protects iio_hwmon_listeners and listeners' refcnt */
> >> > > +DEFINE_MUTEX(iio_hwmon_listener_lock);
> >> > > +LIST_HEAD(iio_hwmon_listeners);
> >> > > +
> >> > > +/**
> >> > > + * struct iio_hwmon_listener - Listener for IIO events
> >> > > + * @block: Notifier for events
> >> > > + * @ids: Array of IIO event ids, one per alarm
> >> > > + * @alarms: Bitmap of alarms
> >> > > + * @num_alarms: Length of @ids and @alarms
> >> > > + * @indio_dev: Device we are listening to
> >> > > + * @list: List of all listeners
> >> > > + * @refcnt: Reference count
> >> > > + */
> >> > > +struct iio_hwmon_listener {
> >> > > +	struct notifier_block block;
> >> > > +	u64 *ids;
> >> > > +	unsigned long *alarms;
> >> > > +	size_t num_alarms;
> >> > > +
> >> > > +	struct iio_dev *indio_dev;
> >> > > +	struct list_head list;
> >> > > +	unsigned int refcnt;
> >> > > +};
> >> > > +
> >> > > +/**
> >> > > + * iio_hwmon_lookup_alarm() - Find an alarm by id
> >> > > + * @listener: Event listener
> >> > > + * @id: IIO event id
> >> > > + *
> >> > > + * Return: index of @id in @listener->ids, or -1 if not found
> >> > > + */
> >> > > +static ssize_t iio_hwmon_lookup_alarm(struct iio_hwmon_listener *listener,
> >> > > +				      u64 id)
> >> > > +{
> >> > > +	ssize_t i;
> >> > > +
> >> > > +	for (i = 0; i < listener->num_alarms; i++)
> >> > > +		if (listener->ids[i] == id)
> >> > > +			return i;
> >> > > +
> >> > > +	return -1;
> >> > > +}
> >> > > +
> >> > > +static int iio_hwmon_listener_callback(struct notifier_block *block,
> >> > > +				       unsigned long action, void *data)
> >> > > +{
> >> > > +	struct iio_hwmon_listener *listener =
> >> > > +		container_of(block, struct iio_hwmon_listener, block);
> >> > > +	struct iio_event_data *ev = data;
> >> > > +	ssize_t i;
> >> > > +
> >> > > +	if (action != IIO_NOTIFY_EVENT)
> >> > > +		return NOTIFY_DONE;
> >> > > +
> >> > > +	i = iio_hwmon_lookup_alarm(listener, ev->id);
> >> > > +	if (i >= 0)
> >> > > +		set_bit(i, listener->alarms);
> >> > > +	else
> >> > > +		dev_warn_once(&listener->indio_dev->dev,
> >> > > +			      "unknown event %016llx\n", ev->id);
> >> > > +
> >> > > +	return NOTIFY_DONE;
> >> > > +}
> >> > > +
> >> > > +/**
> >> > > + * iio_event_id() - Calculate an IIO event id
> >> > > + * @channel: IIO channel for this event
> >> > > + * @type: Event type (theshold, rate-of-change, etc.)
> >> > > + * @dir: Event direction (rising, falling, etc.)
> >> > > + *
> >> > > + * Return: IIO event id corresponding to this event's IIO id
> >> > > + */
> >> > > +static u64 iio_event_id(struct iio_chan_spec const *chan,
> >> > > +			enum iio_event_type type,
> >> > > +			enum iio_event_direction dir)
> >> > > +{
> >> > > +	if (chan->differential)
> >> > > +		return IIO_DIFF_EVENT_CODE(chan->type, chan->channel,
> >> > > +					   chan->channel2, type, dir);
> >> > > +	if (chan->modified)
> >> > > +		return IIO_MOD_EVENT_CODE(chan->type, chan->channel,
> >> > > +					  chan->channel2, type, dir);
> >> > > +	return IIO_UNMOD_EVENT_CODE(chan->type, chan->channel, type, dir);
> >> > > +}
> >> > > +
> >> > > +/**
> >> > > + * iio_hwmon_listener_get() - Get a listener for an IIO device
> >> > > + * @indio_dev: IIO device to listen to
> >> > > + *
> >> > > + * Look up or create a new listener for @indio_dev. The returned listener is
> >> > > + * registered with @indio_dev, but events still need to be manually enabled.
> >> > > + * You must call iio_hwmon_listener_put() when you are done.
> >> > > + *
> >> > > + * Return: Listener for @indio_dev, or an error pointer
> >> > > + */
> >> > > +static struct iio_hwmon_listener *iio_hwmon_listener_get(struct iio_dev
> >> > > *indio_dev)
> >> > > +{
> >> > > +	struct iio_hwmon_listener *listener;
> >> > > +	int err = -ENOMEM;
> >> > > +	size_t i, j;
> >> > > +
> >> > > +	guard(mutex)(&iio_hwmon_listener_lock);
> >> > > +	list_for_each_entry(listener, &iio_hwmon_listeners, list) {
> >> > > +		if (listener->indio_dev == indio_dev) {
> >> > > +			if (likely(listener->refcnt != UINT_MAX))
> >> > > +				listener->refcnt++;
> >> > 
> >> > I dunno for the above to ever happen :).
> >> 
> >> Well, I can remove it if you like.
> >> 
> >> > And as Andy stated, let's just use proper refcount APIs.
> >> 
> >> No point in using atomic ops if they are only accessed under a mutex.
> > 
> > Not the point... If there are proper APIs for handling things like this, not sure why
> > not using and then coming up with things like the above? And the same goes to the
> > release path.
> 
> The API is for doing reference counts *atomically*. If you do not need
> atomic reference counting, then it is the *wrong* API. I suggest reading

Well, It won't make your code wrong. It's just about re-using what we have already.
But my main complain was about having your own saturation checks in here.
I also dislike the release path where you do have to explicitly check for 0 to
call the cleanup API. That is all handled already. Not to mention that it is a fairly
common pattern to use these APIs even if you don't really __need__ it's atomicity. 

> the block comment at the beginning of refcnt.h to see the sorts of
> contortions it has to go through because it is an atomic API. Since we

And? It's very well hidden in the API... This is also not a fastpath at
all so performance is also not a concern AFAICT.

Up to the maintainers anyways but I cannot say I agree with it. So, I
guess we can agree in disagreeing :)

- Nuno Sá

