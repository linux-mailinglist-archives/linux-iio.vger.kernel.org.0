Return-Path: <linux-iio+bounces-21752-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69996B09136
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 18:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1F261C4728B
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 16:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD4C2FA63A;
	Thu, 17 Jul 2025 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QRZiaPOP"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43456248F7F
	for <linux-iio@vger.kernel.org>; Thu, 17 Jul 2025 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752768041; cv=none; b=DS7eBPDpjcpa2rCKaLV/PYDTRy2OpyNYrgKII/TiUYXckhAhLHEXee/Oe2FvD2WpDMX2w1ZmU4ZIzsGa+DF9fCCzJeTsPrt5TFdDsSjCdWJoVLBbdU5s+tWnodYdDgX8RC0QtouibIAUYGbkfavd6fNZ+lNnV/SI+hresdT9eVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752768041; c=relaxed/simple;
	bh=tdMnZDV0ZUzpuqi/2w8metSuOM7yP30flpfjeQHKPH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ovDNqVmF71gUABy93DA9EthW7lqL7ilxgRQHBdWIrXAjCGANdytdJASmM9OVHc0BlVlMA4/BVGXsEbZbInn974ObFqil9Jzwi2OEYS6+/W/pE3lKaVS/AxUP+Sa+CdLOpWrhcWbvuScp0Zb3ZPmIppDmE9psCRbkuL7XMc0UOQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QRZiaPOP; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <11735f77-25cc-4220-b7be-e6fda8f72161@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752768036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BkfJI7cpXj5VUYoq0tgOuznhgFvkJXnYXizplgvtnLg=;
	b=QRZiaPOPI2oFCm3y1XvKEslN/kfEtJa+BEIHas8L+A0pjwN9DRbHj6OhPS96Juru/Aob/c
	FqqqyWYCDSXtfnzcTlgxcN8FPK526PEbhWkT7jBP99EKvs67P4EGDoB//Ot9w/WcKpCwM3
	FaJh/qPOsWK2Wu5NFYrXKl8c4+Nl3L0=
Date: Thu, 17 Jul 2025 12:00:13 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 7/7] hwmon: iio: Add alarm support
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
 linux-hwmon@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, linux-kernel@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
 <20250715012023.2050178-8-sean.anderson@linux.dev>
 <afc6aa6ad4b633f9d834acf933734985f14c5563.camel@gmail.com>
 <6455be16-d287-4d5e-9556-e1789d43708c@linux.dev>
 <9c6f99e022270b1b9c2f178f8f415270f11e59df.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <9c6f99e022270b1b9c2f178f8f415270f11e59df.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/16/25 02:37, Nuno Sá wrote:
> On Tue, 2025-07-15 at 13:02 -0400, Sean Anderson wrote:
>> On 7/15/25 07:28, Nuno Sá wrote:
>> > On Mon, 2025-07-14 at 21:20 -0400, Sean Anderson wrote:
>> > > Add alarm support based on IIO threshold events. The alarm is cleared on
>> > > read, but will be set again if the condition is still present. This is
>> > > detected by disabling and re-enabling the event. The same trick is done
>> > > when creating the attribute to detect already-triggered events.
>> > > 
>> > > The alarms are updated by an event listener. To keep the notifier call
>> > > chain short, we create one listener per iio device, shared across all
>> > > hwmon devices.
>> > > 
>> > > To avoid dynamic creation of alarms, alarms for all possible events are
>> > > allocated at creation. Lookup is done by a linear scan, as I expect
>> > > events to occur rarely. If performance becomes an issue, a binary search
>> > > could be done instead (or some kind of hash lookup).
>> > > 
>> > > Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> > > ---
>> > > 
>> > >  drivers/hwmon/iio_hwmon.c | 322 +++++++++++++++++++++++++++++++++++++-
>> > >  1 file changed, 321 insertions(+), 1 deletion(-)
>> > > 
>> > > diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
>> > > index 3db4d4b30022..c963bc5452ba 100644
>> > > --- a/drivers/hwmon/iio_hwmon.c
>> > > +++ b/drivers/hwmon/iio_hwmon.c
>> > > @@ -8,6 +8,7 @@
>> > >  #include <linux/slab.h>
>> > >  #include <linux/mod_devicetable.h>
>> > >  #include <linux/module.h>
>> > > +#include <linux/notifier.h>
>> > >  #include <linux/err.h>
>> > >  #include <linux/platform_device.h>
>> > >  #include <linux/property.h>
>> > > @@ -15,7 +16,192 @@
>> > >  #include <linux/hwmon.h>
>> > >  #include <linux/hwmon-sysfs.h>
>> > >  #include <linux/iio/consumer.h>
>> > > +#include <linux/iio/events.h>
>> > > +#include <linux/iio/iio.h>
>> > >  #include <linux/iio/types.h>
>> > > +#include <uapi/linux/iio/events.h>
>> > > +
>> > > +/* Protects iio_hwmon_listeners and listeners' refcnt */
>> > > +DEFINE_MUTEX(iio_hwmon_listener_lock);
>> > > +LIST_HEAD(iio_hwmon_listeners);
>> > > +
>> > > +/**
>> > > + * struct iio_hwmon_listener - Listener for IIO events
>> > > + * @block: Notifier for events
>> > > + * @ids: Array of IIO event ids, one per alarm
>> > > + * @alarms: Bitmap of alarms
>> > > + * @num_alarms: Length of @ids and @alarms
>> > > + * @indio_dev: Device we are listening to
>> > > + * @list: List of all listeners
>> > > + * @refcnt: Reference count
>> > > + */
>> > > +struct iio_hwmon_listener {
>> > > +	struct notifier_block block;
>> > > +	u64 *ids;
>> > > +	unsigned long *alarms;
>> > > +	size_t num_alarms;
>> > > +
>> > > +	struct iio_dev *indio_dev;
>> > > +	struct list_head list;
>> > > +	unsigned int refcnt;
>> > > +};
>> > > +
>> > > +/**
>> > > + * iio_hwmon_lookup_alarm() - Find an alarm by id
>> > > + * @listener: Event listener
>> > > + * @id: IIO event id
>> > > + *
>> > > + * Return: index of @id in @listener->ids, or -1 if not found
>> > > + */
>> > > +static ssize_t iio_hwmon_lookup_alarm(struct iio_hwmon_listener *listener,
>> > > +				      u64 id)
>> > > +{
>> > > +	ssize_t i;
>> > > +
>> > > +	for (i = 0; i < listener->num_alarms; i++)
>> > > +		if (listener->ids[i] == id)
>> > > +			return i;
>> > > +
>> > > +	return -1;
>> > > +}
>> > > +
>> > > +static int iio_hwmon_listener_callback(struct notifier_block *block,
>> > > +				       unsigned long action, void *data)
>> > > +{
>> > > +	struct iio_hwmon_listener *listener =
>> > > +		container_of(block, struct iio_hwmon_listener, block);
>> > > +	struct iio_event_data *ev = data;
>> > > +	ssize_t i;
>> > > +
>> > > +	if (action != IIO_NOTIFY_EVENT)
>> > > +		return NOTIFY_DONE;
>> > > +
>> > > +	i = iio_hwmon_lookup_alarm(listener, ev->id);
>> > > +	if (i >= 0)
>> > > +		set_bit(i, listener->alarms);
>> > > +	else
>> > > +		dev_warn_once(&listener->indio_dev->dev,
>> > > +			      "unknown event %016llx\n", ev->id);
>> > > +
>> > > +	return NOTIFY_DONE;
>> > > +}
>> > > +
>> > > +/**
>> > > + * iio_event_id() - Calculate an IIO event id
>> > > + * @channel: IIO channel for this event
>> > > + * @type: Event type (theshold, rate-of-change, etc.)
>> > > + * @dir: Event direction (rising, falling, etc.)
>> > > + *
>> > > + * Return: IIO event id corresponding to this event's IIO id
>> > > + */
>> > > +static u64 iio_event_id(struct iio_chan_spec const *chan,
>> > > +			enum iio_event_type type,
>> > > +			enum iio_event_direction dir)
>> > > +{
>> > > +	if (chan->differential)
>> > > +		return IIO_DIFF_EVENT_CODE(chan->type, chan->channel,
>> > > +					   chan->channel2, type, dir);
>> > > +	if (chan->modified)
>> > > +		return IIO_MOD_EVENT_CODE(chan->type, chan->channel,
>> > > +					  chan->channel2, type, dir);
>> > > +	return IIO_UNMOD_EVENT_CODE(chan->type, chan->channel, type, dir);
>> > > +}
>> > > +
>> > > +/**
>> > > + * iio_hwmon_listener_get() - Get a listener for an IIO device
>> > > + * @indio_dev: IIO device to listen to
>> > > + *
>> > > + * Look up or create a new listener for @indio_dev. The returned listener is
>> > > + * registered with @indio_dev, but events still need to be manually enabled.
>> > > + * You must call iio_hwmon_listener_put() when you are done.
>> > > + *
>> > > + * Return: Listener for @indio_dev, or an error pointer
>> > > + */
>> > > +static struct iio_hwmon_listener *iio_hwmon_listener_get(struct iio_dev
>> > > *indio_dev)
>> > > +{
>> > > +	struct iio_hwmon_listener *listener;
>> > > +	int err = -ENOMEM;
>> > > +	size_t i, j;
>> > > +
>> > > +	guard(mutex)(&iio_hwmon_listener_lock);
>> > > +	list_for_each_entry(listener, &iio_hwmon_listeners, list) {
>> > > +		if (listener->indio_dev == indio_dev) {
>> > > +			if (likely(listener->refcnt != UINT_MAX))
>> > > +				listener->refcnt++;
>> > 
>> > I dunno for the above to ever happen :).
>> 
>> Well, I can remove it if you like.
>> 
>> > And as Andy stated, let's just use proper refcount APIs.
>> 
>> No point in using atomic ops if they are only accessed under a mutex.
> 
> Not the point... If there are proper APIs for handling things like this, not sure why
> not using and then coming up with things like the above? And the same goes to the
> release path.

The API is for doing reference counts *atomically*. If you do not need
atomic reference counting, then it is the *wrong* API. I suggest reading
the block comment at the beginning of refcnt.h to see the sorts of
contortions it has to go through because it is an atomic API. Since we
hold a mutex, we can just increment/decrement. I will remove the
saturation check to avoid confusion.

--Sean

