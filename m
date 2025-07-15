Return-Path: <linux-iio+bounces-21697-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E461B064CA
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 19:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7542567205
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 17:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCA41FE474;
	Tue, 15 Jul 2025 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UvgoAZbi"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BF41E5B82
	for <linux-iio@vger.kernel.org>; Tue, 15 Jul 2025 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752598935; cv=none; b=XDVosQuvI19M+tmS8v7OdsJtegmCFbT5emXcCUfMmFtcq4Xsus7xJi9j4GnxlyAN5v6YwSo4Mve72kz7tQwMF0/+01rgc3DHuC66zxxEArBuoohHNlYqapUZi/2w2+TV9Gs0OmsyaZvD86mZXc/QeGCnqc5ZBo7vSBmPZEn1BQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752598935; c=relaxed/simple;
	bh=juPMDbPzPzq+N8m+R/hscSm2a3xLX5ObQ3CHvo3jhGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHvcmWMRziJpTNUYz7Kw0htuhIg3r4Kcud/kqLWMKOcPPMMl4B+BHmO7wBDiuGdnTedL2KZSbnmB2jwE9iAkTF8p8BUP0YkeJddHmM0WA6gnZrsKdsk78F46TnQZFRkK8pSoy2XpDmwWx+li+Xe9s4rivj41ls+mxKkRstoToNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UvgoAZbi; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6455be16-d287-4d5e-9556-e1789d43708c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752598931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8OBz0kBj7lrfF3Hap6Knk6848hg6oJPqqR/raEkYrZ4=;
	b=UvgoAZbi0FF8vExrGAI1VXbDXKQ11P8uxPk1ozCViGKkEbnJc6VlXFvqY3463uabXwJIPX
	e/8X81IARCz0amFndxBWVdFQAEKk122EbaRh9XpD/kNmt3JdiQmUa81A0hDOOCp3QO5+Ab
	mh/frEmR4p3tCh/rtkd4j7SRIIB1UH0=
Date: Tue, 15 Jul 2025 13:02:07 -0400
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <afc6aa6ad4b633f9d834acf933734985f14c5563.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/15/25 07:28, Nuno Sá wrote:
> On Mon, 2025-07-14 at 21:20 -0400, Sean Anderson wrote:
>> Add alarm support based on IIO threshold events. The alarm is cleared on
>> read, but will be set again if the condition is still present. This is
>> detected by disabling and re-enabling the event. The same trick is done
>> when creating the attribute to detect already-triggered events.
>> 
>> The alarms are updated by an event listener. To keep the notifier call
>> chain short, we create one listener per iio device, shared across all
>> hwmon devices.
>> 
>> To avoid dynamic creation of alarms, alarms for all possible events are
>> allocated at creation. Lookup is done by a linear scan, as I expect
>> events to occur rarely. If performance becomes an issue, a binary search
>> could be done instead (or some kind of hash lookup).
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>> 
>>  drivers/hwmon/iio_hwmon.c | 322 +++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 321 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
>> index 3db4d4b30022..c963bc5452ba 100644
>> --- a/drivers/hwmon/iio_hwmon.c
>> +++ b/drivers/hwmon/iio_hwmon.c
>> @@ -8,6 +8,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/mod_devicetable.h>
>>  #include <linux/module.h>
>> +#include <linux/notifier.h>
>>  #include <linux/err.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/property.h>
>> @@ -15,7 +16,192 @@
>>  #include <linux/hwmon.h>
>>  #include <linux/hwmon-sysfs.h>
>>  #include <linux/iio/consumer.h>
>> +#include <linux/iio/events.h>
>> +#include <linux/iio/iio.h>
>>  #include <linux/iio/types.h>
>> +#include <uapi/linux/iio/events.h>
>> +
>> +/* Protects iio_hwmon_listeners and listeners' refcnt */
>> +DEFINE_MUTEX(iio_hwmon_listener_lock);
>> +LIST_HEAD(iio_hwmon_listeners);
>> +
>> +/**
>> + * struct iio_hwmon_listener - Listener for IIO events
>> + * @block: Notifier for events
>> + * @ids: Array of IIO event ids, one per alarm
>> + * @alarms: Bitmap of alarms
>> + * @num_alarms: Length of @ids and @alarms
>> + * @indio_dev: Device we are listening to
>> + * @list: List of all listeners
>> + * @refcnt: Reference count
>> + */
>> +struct iio_hwmon_listener {
>> +	struct notifier_block block;
>> +	u64 *ids;
>> +	unsigned long *alarms;
>> +	size_t num_alarms;
>> +
>> +	struct iio_dev *indio_dev;
>> +	struct list_head list;
>> +	unsigned int refcnt;
>> +};
>> +
>> +/**
>> + * iio_hwmon_lookup_alarm() - Find an alarm by id
>> + * @listener: Event listener
>> + * @id: IIO event id
>> + *
>> + * Return: index of @id in @listener->ids, or -1 if not found
>> + */
>> +static ssize_t iio_hwmon_lookup_alarm(struct iio_hwmon_listener *listener,
>> +				      u64 id)
>> +{
>> +	ssize_t i;
>> +
>> +	for (i = 0; i < listener->num_alarms; i++)
>> +		if (listener->ids[i] == id)
>> +			return i;
>> +
>> +	return -1;
>> +}
>> +
>> +static int iio_hwmon_listener_callback(struct notifier_block *block,
>> +				       unsigned long action, void *data)
>> +{
>> +	struct iio_hwmon_listener *listener =
>> +		container_of(block, struct iio_hwmon_listener, block);
>> +	struct iio_event_data *ev = data;
>> +	ssize_t i;
>> +
>> +	if (action != IIO_NOTIFY_EVENT)
>> +		return NOTIFY_DONE;
>> +
>> +	i = iio_hwmon_lookup_alarm(listener, ev->id);
>> +	if (i >= 0)
>> +		set_bit(i, listener->alarms);
>> +	else
>> +		dev_warn_once(&listener->indio_dev->dev,
>> +			      "unknown event %016llx\n", ev->id);
>> +
>> +	return NOTIFY_DONE;
>> +}
>> +
>> +/**
>> + * iio_event_id() - Calculate an IIO event id
>> + * @channel: IIO channel for this event
>> + * @type: Event type (theshold, rate-of-change, etc.)
>> + * @dir: Event direction (rising, falling, etc.)
>> + *
>> + * Return: IIO event id corresponding to this event's IIO id
>> + */
>> +static u64 iio_event_id(struct iio_chan_spec const *chan,
>> +			enum iio_event_type type,
>> +			enum iio_event_direction dir)
>> +{
>> +	if (chan->differential)
>> +		return IIO_DIFF_EVENT_CODE(chan->type, chan->channel,
>> +					   chan->channel2, type, dir);
>> +	if (chan->modified)
>> +		return IIO_MOD_EVENT_CODE(chan->type, chan->channel,
>> +					  chan->channel2, type, dir);
>> +	return IIO_UNMOD_EVENT_CODE(chan->type, chan->channel, type, dir);
>> +}
>> +
>> +/**
>> + * iio_hwmon_listener_get() - Get a listener for an IIO device
>> + * @indio_dev: IIO device to listen to
>> + *
>> + * Look up or create a new listener for @indio_dev. The returned listener is
>> + * registered with @indio_dev, but events still need to be manually enabled.
>> + * You must call iio_hwmon_listener_put() when you are done.
>> + *
>> + * Return: Listener for @indio_dev, or an error pointer
>> + */
>> +static struct iio_hwmon_listener *iio_hwmon_listener_get(struct iio_dev
>> *indio_dev)
>> +{
>> +	struct iio_hwmon_listener *listener;
>> +	int err = -ENOMEM;
>> +	size_t i, j;
>> +
>> +	guard(mutex)(&iio_hwmon_listener_lock);
>> +	list_for_each_entry(listener, &iio_hwmon_listeners, list) {
>> +		if (listener->indio_dev == indio_dev) {
>> +			if (likely(listener->refcnt != UINT_MAX))
>> +				listener->refcnt++;
> 
> I dunno for the above to ever happen :).

Well, I can remove it if you like.

> And as Andy stated, let's just use proper refcount APIs.

No point in using atomic ops if they are only accessed under a mutex.

>> +			return listener;
>> +		}
>> +	}
>> +
>> +	listener = kzalloc(sizeof(*listener), GFP_KERNEL);
>> +	if (!listener)
>> +		goto err_unlock;
>> +
>> +	listener->refcnt = 1;
>> +	listener->indio_dev = indio_dev;
>> +	listener->block.notifier_call = iio_hwmon_listener_callback;
>> +	for (i = 0; i < indio_dev->num_channels; i++)
>> +		listener->num_alarms += indio_dev-
>> >channels[i].num_event_specs;
>> +
>> +	listener->ids = kcalloc(listener->num_alarms, sizeof(*listener->ids),
>> +				GFP_KERNEL);
>> +	listener->alarms = bitmap_zalloc(listener->num_alarms, GFP_KERNEL);
>> +	if (!listener->ids || !listener->alarms)
>> +		goto err_listener;
>> +
>> +	i = 0;
>> +	for (j = 0; j < indio_dev->num_channels; j++) {
>> +		struct iio_chan_spec const *chan = &indio_dev->channels[j];
>> +		size_t k;
>> +
>> +		for (k = 0; k < chan->num_event_specs; k++)
>> +			listener->ids[i++] =
>> +				iio_event_id(chan, chan->event_spec[k].type,
>> +					     chan->event_spec[k].dir);
>> +	}
>> +
>> +	err = iio_event_register(indio_dev, &listener->block);
>> +	if (err)
>> +		goto err_alarms;
>> +
>> +	list_add(&listener->list, &iio_hwmon_listeners);
>> +	mutex_unlock(&iio_hwmon_listener_lock);
>> +	return listener;
>> +
>> +err_alarms:
>> +	kfree(listener->alarms);
>> +	kfree(listener->ids);
>> +err_listener:
>> +	kfree(listener);
>> +err_unlock:
>> +	mutex_unlock(&iio_hwmon_listener_lock);
>> +	return ERR_PTR(err);
>> +}
>> +
>> +/**
>> + * iio_hwmon_listener_put() - Release a listener
>> + * @data: &struct iio_hwmon_listener to release
>> + *
>> + * For convenience, @data is void.
>> + */
>> +static void iio_hwmon_listener_put(void *data)
>> +{
>> +	struct iio_hwmon_listener *listener = data;
>> +
>> +	scoped_guard(mutex, &iio_hwmon_listener_lock) {
>> +		if (unlikely(listener->refcnt == UINT_MAX))
>> +			return;
>> +
>> +		if (--listener->refcnt)
>> +			return;
>> +
>> +		list_del(&listener->list);
>> +		iio_event_unregister(listener->indio_dev, &listener->block);
>> +	}
>> +
>> +	kfree(listener->alarms);
>> +	kfree(listener->ids);
>> +	kfree(listener);
>> +}
>>  
>>  /**
>>   * struct iio_hwmon_state - device instance state
>> @@ -143,6 +329,68 @@ static ssize_t iio_hwmon_write_event(struct device *dev,
>>  	return count;
>>  }
>>  
>> +/**
>> + * struct iio_hwmon_alarm_attribute - IIO HWMON alarm attribute
>> + * @dev_attr: Base device attribute
>> + * @listener: Listener for this alarm
>> + * @index: Index of the channel in the IIO HWMON
>> + * @alarm: Index of the alarm within @listener
>> + */
>> +struct iio_hwmon_alarm_attribute {
>> +	struct device_attribute dev_attr;
>> +	struct iio_hwmon_listener *listener;
>> +	size_t index;
>> +	size_t alarm;
>> +};
>> +#define to_alarm_attr(_dev_attr) \
>> +	container_of(_dev_attr, struct iio_hwmon_alarm_attribute, dev_attr)
>> +
>> +/**
>> + * iio_hwmon_alarm_toggle() - Turn an event off and back on again
>> + * @chan: Channel of the event
>> + * @dir: Event direction (rising, falling, etc.)
>> + *
>> + * Toggle an event's enable so we get notified if the alarm is already
>> + * triggered. We use this to convert IIO's event-triggered events into
>> + * level-triggered alarms.
>> + *
>> + * Return: 0 on success or negative error on failure
>> + */
>> +static int iio_hwmon_alarm_toggle(struct iio_channel *chan,
>> +				  enum iio_event_direction dir)
>> +{
>> +	int ret;
>> +
>> +	ret = iio_write_event_processed_scale(chan, IIO_EV_TYPE_THRESH, dir,
>> +					      IIO_EV_INFO_ENABLE, 0, 1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return iio_write_event_processed_scale(chan, IIO_EV_TYPE_THRESH, dir,
>> +					       IIO_EV_INFO_ENABLE, 1, 1);
>> +}
>> +
>> +static ssize_t iio_hwmon_read_alarm(struct device *dev,
>> +				    struct device_attribute *attr,
>> +				    char *buf)
>> +{
>> +	struct iio_hwmon_alarm_attribute *sattr = to_alarm_attr(attr);
>> +	struct iio_hwmon_state *state = dev_get_drvdata(dev);
>> +	struct iio_channel *chan = &state->channels[sattr->index];
>> +
>> +	if (test_and_clear_bit(sattr->alarm, sattr->listener->alarms)) {
>> +		u64 id = sattr->listener->ids[sattr->alarm];
>> +		enum iio_event_direction dir =
>> IIO_EVENT_CODE_EXTRACT_DIR(id);
>> +
>> +		WARN_ON(iio_hwmon_alarm_toggle(chan, dir));
> 
> WARN_ON() is highly discouraged... Also do we really need a "scary" splat in
> this case?

OK, maybe dev_warn then. I don't want to propagate the error because I think
it's more important to tell userspace that the alarm went off than if there
was a problem determining if the alarm is still active.

>> +		strcpy(buf, "1\n");
>> +		return 2;
>> +	}
>> +
>> +	strcpy(buf, "0\n");
>> +	return 2;
> 
> As stated, sysfs_emit()
> 
>> +}
>> +
>>  static int add_device_attr(struct device *dev, struct iio_hwmon_state *st,
>>  			   ssize_t (*show)(struct device *dev,
>>  					   struct device_attribute *attr,
>> @@ -205,6 +453,63 @@ static int add_event_attr(struct device *dev, struct
>> iio_hwmon_state *st,
>>  	return 0;
>>  }
>>  
>> +static int add_alarm_attr(struct device *dev, struct iio_hwmon_state *st,
>> +			  int i, enum iio_event_direction dir,
>> +			  const char *fmt, ...)
>> +{
>> +	struct iio_hwmon_alarm_attribute *a;
>> +	struct iio_hwmon_listener *listener;
>> +	ssize_t alarm;
>> +	umode_t mode;
>> +	va_list ap;
>> +	int ret;
>> +
>> +	mode = iio_event_mode(&st->channels[i], IIO_EV_TYPE_THRESH, dir,
>> +			      IIO_EV_INFO_ENABLE);
>> +	if (!(mode & 0200))
>> +		return 0;
>> +
>> +	listener = iio_hwmon_listener_get(st->channels[i].indio_dev);
>> +	if (listener == ERR_PTR(-EBUSY))
>> +		return 0;
> 
> Maybe I missed something, where can we get -EBUSY? And should we ignore it?

Oh, this was from before I refactored the notification API to allow kernel
consumers to co-exist with userspace ones. So this can't occur.

>> +	if (IS_ERR(listener))
>> +		return PTR_ERR(listener);
>> +
>> +	ret = devm_add_action_or_reset(dev, iio_hwmon_listener_put,
>> listener);
>> +	if (ret)
>> +		return ret;
>> +
>> +	alarm = iio_hwmon_lookup_alarm(listener,
>> +				       iio_event_id(st->channels[i].channel,
>> +						    IIO_EV_TYPE_THRESH,
>> dir));
>> +	if (WARN_ON_ONCE(alarm < 0))
>> +		return -ENOENT;
>> +
> 
> Again, I would drop WARN_ON_ONCE()

This can only occur if there is a bug in the kernel. We should have returned
0 from iio_event_mode() before we get to this point.

--Sean

