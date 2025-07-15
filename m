Return-Path: <linux-iio+bounces-21700-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC46B066C3
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 21:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C01D3B9244
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 19:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4C8298984;
	Tue, 15 Jul 2025 19:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TI6kB94R"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC19F15E5BB;
	Tue, 15 Jul 2025 19:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752607586; cv=none; b=XiJcXU89JYiQk/b72Wa2VMdqD3GNbLC3QrNPFyqPnKGurAmwN55UOMoVRRplJ9+PZMGYAu0W1ieQs2VSo2q4mlAgsGuuKfL4Ht+OTxyhY+CLfv+eYoaM5s4z8/scmpiq7jwsmxJgTBHoo7zSChKx+tSFN5FSiIJti5AI4Hnc6Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752607586; c=relaxed/simple;
	bh=wT/Fhi+ym+HXx2S7FKEScQlUAvOb9WvpfXv0bbf9vIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cj1aA0Sa9BjvfQf+e8eyYMtFBTH18z5yTVOLKBYJRWxTVC/Wr8azBXHbx8DYURvoohsAjC3Ejc4QVq2frbKtguSM8fKz6VLcdhyfrfc8EpX3RJ88MPWbOq7BWQmBpmlk2k/RC/+8KvCI6TDGpXnoAJdIRyYG8de8KoSbAShXlac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TI6kB94R; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-311e2cc157bso4993748a91.2;
        Tue, 15 Jul 2025 12:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752607584; x=1753212384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=BWQ2RBHNtHKJE2BWuvIB0wzlCpMkv7aGAQWg/7WIA9g=;
        b=TI6kB94Rjb76GdUn7Qo1Fq2hpQTegkUa/5jY9b4IAa1uzS/ELbxK9ydSD5T41l4RKa
         r/FAgRjFuMWFgnzmEARNQnzbxc8r+O+3twmiw6LJrkq29vjHLFdwK4QA2z1STyWJFnvc
         tCeZILn223bXC5hx1fkuaQ5JvjY6kZFQl+Msk0iyRT4CYaR4/ZFjSzJzxk1Pe3CKba4I
         t2X6JexbOR0mSKH1uRVpA8iBLalxnAiFS58/GkaZVUA7ckqKSIWM5oB0LFfKhbDDAUe0
         ylLXwRM7R8mKFltw19SwqpCOuN2b56S9884cmN9yyslWql7YqPJXOVoohpBkGgDj/Q8F
         fqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752607584; x=1753212384;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWQ2RBHNtHKJE2BWuvIB0wzlCpMkv7aGAQWg/7WIA9g=;
        b=nf9teloHOT7SXXhcMq8LJdiKC490D/aOtZ1XlYR3oWY1QYDO5oa5lIuBSSuKjzkpVX
         Cx/vos5FIvKjGb+jirGTmBlA8vIqURbdUPgqj8rjmthLcyOR4e3IqH6eXuhxxT2NfG/V
         OZO5mMOUphXXDUYFGaYrYINNZiuupMDU8ylXx1T7U6gZyI1VdI0craGwgbv092ANMsvj
         8mLMAMLH0/b8ijMpZabt/rjDqmYPyCGU38YlEy5syKkBYxPYk5G4GsUKgOf0sSL5hB2u
         Ax4irYzfxvSxIIpnyHMKsV0LfIEMM+fu6TpaMAlnjxdszhQSSIRK2E3qfnm3kLFTODft
         RuCw==
X-Forwarded-Encrypted: i=1; AJvYcCVAyf87hBibqDkN7U/fPre0bue8lNMKeFMw30S6PvDgUwWP5XTWRtPxbRsxJho7L/pe0joaR0skDJkpLA==@vger.kernel.org, AJvYcCW9JHdfLr0ijA82nLxNYuzTCMr6P5v+ZmXqidtw0rLgzkjd81l9CI1KXvrU/HfEjL48LZ+Z1TAY4ucNi+KG@vger.kernel.org, AJvYcCXcUgHhCcPSr5Jpypo44+heY+UKzHLdZp161CgH86rqktt8IVa+FR1hAhQtBy5iAckiFcmRNLy5C5Xt@vger.kernel.org
X-Gm-Message-State: AOJu0YxytXz5fANZoL4TBSX+0N0IwCSTpWq22pPsKcWYWu+d37L0jxiH
	aoZFslQRCl1/Juz1ElxJf0Upe2pqPsAA7wfZAeO4WPmf8kkwSZEub0h0bTCAQQ==
X-Gm-Gg: ASbGncu9749bwzJN/y9WsD6xA/ViT1yybRIaIdFK7oMzwhCKI66vSyV0CL/edV9LzGo
	cWDWIR7IONKOQDWJqn0LHAWvRckbRy+O7c9ts8XoIH7w9gixCOzYsOcvaKkUxH57OHFW2/pLKp7
	tddNHvE8d9mEUn9uqIIuGlSRcb03A7sV4gpGKT32CsuWjOw+kKriDyUFfCCyuZEI7Ytk0xT9uxT
	cke+OimNcFBmvzE0gQo1rC23GnTwq55FBBp1WTZqVE6KahO0sk+2lnAt6M4Of4zOlWg/GAQEEdX
	zCsVZEetGw2G3rGbbWSdRM6HrzFI3t6U5JTocoLs0VT7ImwadcYFqGIrbEMqClHd0q4yaOoqHOs
	ZNEG97sSLy8rLhUehYCp0/W50zIAqyZG7C69Sopt02Dj5T9c79AG0uqEQwkcNBa8xbwAZRD4=
X-Google-Smtp-Source: AGHT+IHZiBjIQ/xv/I49UZD6Wx3aJWmouC/jvCsEziKQfmgnScYXTUqTJAFU/JrAgCTLNeyvLFqh8A==
X-Received: by 2002:a17:90b:5281:b0:310:8d4a:a246 with SMTP id 98e67ed59e1d1-31c9e6e515cmr437572a91.1.1752607583571;
        Tue, 15 Jul 2025 12:26:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c368240ccsm14743769a91.30.2025.07.15.12.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 12:26:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9faeea8d-98b7-476e-9b4c-ed5be0a48913@roeck-us.net>
Date: Tue, 15 Jul 2025 12:26:21 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] hwmon: iio: Add alarm support
To: Sean Anderson <sean.anderson@linux.dev>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Jean Delvare <jdelvare@suse.com>, linux-iio@vger.kernel.org,
 linux-hwmon@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, linux-kernel@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
 <20250715012023.2050178-8-sean.anderson@linux.dev>
 <afc6aa6ad4b633f9d834acf933734985f14c5563.camel@gmail.com>
 <6455be16-d287-4d5e-9556-e1789d43708c@linux.dev>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <6455be16-d287-4d5e-9556-e1789d43708c@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/15/25 10:02, Sean Anderson wrote:
> On 7/15/25 07:28, Nuno Sá wrote:
>> On Mon, 2025-07-14 at 21:20 -0400, Sean Anderson wrote:
>>> Add alarm support based on IIO threshold events. The alarm is cleared on
>>> read, but will be set again if the condition is still present. This is
>>> detected by disabling and re-enabling the event. The same trick is done
>>> when creating the attribute to detect already-triggered events.
>>>
>>> The alarms are updated by an event listener. To keep the notifier call
>>> chain short, we create one listener per iio device, shared across all
>>> hwmon devices.
>>>
>>> To avoid dynamic creation of alarms, alarms for all possible events are
>>> allocated at creation. Lookup is done by a linear scan, as I expect
>>> events to occur rarely. If performance becomes an issue, a binary search
>>> could be done instead (or some kind of hash lookup).
>>>
>>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>>> ---
>>>
>>>   drivers/hwmon/iio_hwmon.c | 322 +++++++++++++++++++++++++++++++++++++-
>>>   1 file changed, 321 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
>>> index 3db4d4b30022..c963bc5452ba 100644
>>> --- a/drivers/hwmon/iio_hwmon.c
>>> +++ b/drivers/hwmon/iio_hwmon.c
>>> @@ -8,6 +8,7 @@
>>>   #include <linux/slab.h>
>>>   #include <linux/mod_devicetable.h>
>>>   #include <linux/module.h>
>>> +#include <linux/notifier.h>
>>>   #include <linux/err.h>
>>>   #include <linux/platform_device.h>
>>>   #include <linux/property.h>
>>> @@ -15,7 +16,192 @@
>>>   #include <linux/hwmon.h>
>>>   #include <linux/hwmon-sysfs.h>
>>>   #include <linux/iio/consumer.h>
>>> +#include <linux/iio/events.h>
>>> +#include <linux/iio/iio.h>
>>>   #include <linux/iio/types.h>
>>> +#include <uapi/linux/iio/events.h>
>>> +
>>> +/* Protects iio_hwmon_listeners and listeners' refcnt */
>>> +DEFINE_MUTEX(iio_hwmon_listener_lock);
>>> +LIST_HEAD(iio_hwmon_listeners);
>>> +
>>> +/**
>>> + * struct iio_hwmon_listener - Listener for IIO events
>>> + * @block: Notifier for events
>>> + * @ids: Array of IIO event ids, one per alarm
>>> + * @alarms: Bitmap of alarms
>>> + * @num_alarms: Length of @ids and @alarms
>>> + * @indio_dev: Device we are listening to
>>> + * @list: List of all listeners
>>> + * @refcnt: Reference count
>>> + */
>>> +struct iio_hwmon_listener {
>>> +	struct notifier_block block;
>>> +	u64 *ids;
>>> +	unsigned long *alarms;
>>> +	size_t num_alarms;
>>> +
>>> +	struct iio_dev *indio_dev;
>>> +	struct list_head list;
>>> +	unsigned int refcnt;
>>> +};
>>> +
>>> +/**
>>> + * iio_hwmon_lookup_alarm() - Find an alarm by id
>>> + * @listener: Event listener
>>> + * @id: IIO event id
>>> + *
>>> + * Return: index of @id in @listener->ids, or -1 if not found
>>> + */
>>> +static ssize_t iio_hwmon_lookup_alarm(struct iio_hwmon_listener *listener,
>>> +				      u64 id)
>>> +{
>>> +	ssize_t i;
>>> +
>>> +	for (i = 0; i < listener->num_alarms; i++)
>>> +		if (listener->ids[i] == id)
>>> +			return i;
>>> +
>>> +	return -1;
>>> +}
>>> +
>>> +static int iio_hwmon_listener_callback(struct notifier_block *block,
>>> +				       unsigned long action, void *data)
>>> +{
>>> +	struct iio_hwmon_listener *listener =
>>> +		container_of(block, struct iio_hwmon_listener, block);
>>> +	struct iio_event_data *ev = data;
>>> +	ssize_t i;
>>> +
>>> +	if (action != IIO_NOTIFY_EVENT)
>>> +		return NOTIFY_DONE;
>>> +
>>> +	i = iio_hwmon_lookup_alarm(listener, ev->id);
>>> +	if (i >= 0)
>>> +		set_bit(i, listener->alarms);
>>> +	else
>>> +		dev_warn_once(&listener->indio_dev->dev,
>>> +			      "unknown event %016llx\n", ev->id);
>>> +
>>> +	return NOTIFY_DONE;
>>> +}
>>> +
>>> +/**
>>> + * iio_event_id() - Calculate an IIO event id
>>> + * @channel: IIO channel for this event
>>> + * @type: Event type (theshold, rate-of-change, etc.)
>>> + * @dir: Event direction (rising, falling, etc.)
>>> + *
>>> + * Return: IIO event id corresponding to this event's IIO id
>>> + */
>>> +static u64 iio_event_id(struct iio_chan_spec const *chan,
>>> +			enum iio_event_type type,
>>> +			enum iio_event_direction dir)
>>> +{
>>> +	if (chan->differential)
>>> +		return IIO_DIFF_EVENT_CODE(chan->type, chan->channel,
>>> +					   chan->channel2, type, dir);
>>> +	if (chan->modified)
>>> +		return IIO_MOD_EVENT_CODE(chan->type, chan->channel,
>>> +					  chan->channel2, type, dir);
>>> +	return IIO_UNMOD_EVENT_CODE(chan->type, chan->channel, type, dir);
>>> +}
>>> +
>>> +/**
>>> + * iio_hwmon_listener_get() - Get a listener for an IIO device
>>> + * @indio_dev: IIO device to listen to
>>> + *
>>> + * Look up or create a new listener for @indio_dev. The returned listener is
>>> + * registered with @indio_dev, but events still need to be manually enabled.
>>> + * You must call iio_hwmon_listener_put() when you are done.
>>> + *
>>> + * Return: Listener for @indio_dev, or an error pointer
>>> + */
>>> +static struct iio_hwmon_listener *iio_hwmon_listener_get(struct iio_dev
>>> *indio_dev)
>>> +{
>>> +	struct iio_hwmon_listener *listener;
>>> +	int err = -ENOMEM;
>>> +	size_t i, j;
>>> +
>>> +	guard(mutex)(&iio_hwmon_listener_lock);
>>> +	list_for_each_entry(listener, &iio_hwmon_listeners, list) {
>>> +		if (listener->indio_dev == indio_dev) {
>>> +			if (likely(listener->refcnt != UINT_MAX))
>>> +				listener->refcnt++;
>>
>> I dunno for the above to ever happen :).
> 
> Well, I can remove it if you like.
> 
>> And as Andy stated, let's just use proper refcount APIs.
> 
> No point in using atomic ops if they are only accessed under a mutex.
> 
>>> +			return listener;
>>> +		}
>>> +	}
>>> +
>>> +	listener = kzalloc(sizeof(*listener), GFP_KERNEL);
>>> +	if (!listener)
>>> +		goto err_unlock;
>>> +
>>> +	listener->refcnt = 1;
>>> +	listener->indio_dev = indio_dev;
>>> +	listener->block.notifier_call = iio_hwmon_listener_callback;
>>> +	for (i = 0; i < indio_dev->num_channels; i++)
>>> +		listener->num_alarms += indio_dev-
>>>> channels[i].num_event_specs;
>>> +
>>> +	listener->ids = kcalloc(listener->num_alarms, sizeof(*listener->ids),
>>> +				GFP_KERNEL);
>>> +	listener->alarms = bitmap_zalloc(listener->num_alarms, GFP_KERNEL);
>>> +	if (!listener->ids || !listener->alarms)
>>> +		goto err_listener;
>>> +
>>> +	i = 0;
>>> +	for (j = 0; j < indio_dev->num_channels; j++) {
>>> +		struct iio_chan_spec const *chan = &indio_dev->channels[j];
>>> +		size_t k;
>>> +
>>> +		for (k = 0; k < chan->num_event_specs; k++)
>>> +			listener->ids[i++] =
>>> +				iio_event_id(chan, chan->event_spec[k].type,
>>> +					     chan->event_spec[k].dir);
>>> +	}
>>> +
>>> +	err = iio_event_register(indio_dev, &listener->block);
>>> +	if (err)
>>> +		goto err_alarms;
>>> +
>>> +	list_add(&listener->list, &iio_hwmon_listeners);
>>> +	mutex_unlock(&iio_hwmon_listener_lock);
>>> +	return listener;
>>> +
>>> +err_alarms:
>>> +	kfree(listener->alarms);
>>> +	kfree(listener->ids);
>>> +err_listener:
>>> +	kfree(listener);
>>> +err_unlock:
>>> +	mutex_unlock(&iio_hwmon_listener_lock);
>>> +	return ERR_PTR(err);
>>> +}
>>> +
>>> +/**
>>> + * iio_hwmon_listener_put() - Release a listener
>>> + * @data: &struct iio_hwmon_listener to release
>>> + *
>>> + * For convenience, @data is void.
>>> + */
>>> +static void iio_hwmon_listener_put(void *data)
>>> +{
>>> +	struct iio_hwmon_listener *listener = data;
>>> +
>>> +	scoped_guard(mutex, &iio_hwmon_listener_lock) {
>>> +		if (unlikely(listener->refcnt == UINT_MAX))
>>> +			return;
>>> +
>>> +		if (--listener->refcnt)
>>> +			return;
>>> +
>>> +		list_del(&listener->list);
>>> +		iio_event_unregister(listener->indio_dev, &listener->block);
>>> +	}
>>> +
>>> +	kfree(listener->alarms);
>>> +	kfree(listener->ids);
>>> +	kfree(listener);
>>> +}
>>>   
>>>   /**
>>>    * struct iio_hwmon_state - device instance state
>>> @@ -143,6 +329,68 @@ static ssize_t iio_hwmon_write_event(struct device *dev,
>>>   	return count;
>>>   }
>>>   
>>> +/**
>>> + * struct iio_hwmon_alarm_attribute - IIO HWMON alarm attribute
>>> + * @dev_attr: Base device attribute
>>> + * @listener: Listener for this alarm
>>> + * @index: Index of the channel in the IIO HWMON
>>> + * @alarm: Index of the alarm within @listener
>>> + */
>>> +struct iio_hwmon_alarm_attribute {
>>> +	struct device_attribute dev_attr;
>>> +	struct iio_hwmon_listener *listener;
>>> +	size_t index;
>>> +	size_t alarm;
>>> +};
>>> +#define to_alarm_attr(_dev_attr) \
>>> +	container_of(_dev_attr, struct iio_hwmon_alarm_attribute, dev_attr)
>>> +
>>> +/**
>>> + * iio_hwmon_alarm_toggle() - Turn an event off and back on again
>>> + * @chan: Channel of the event
>>> + * @dir: Event direction (rising, falling, etc.)
>>> + *
>>> + * Toggle an event's enable so we get notified if the alarm is already
>>> + * triggered. We use this to convert IIO's event-triggered events into
>>> + * level-triggered alarms.
>>> + *
>>> + * Return: 0 on success or negative error on failure
>>> + */
>>> +static int iio_hwmon_alarm_toggle(struct iio_channel *chan,
>>> +				  enum iio_event_direction dir)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = iio_write_event_processed_scale(chan, IIO_EV_TYPE_THRESH, dir,
>>> +					      IIO_EV_INFO_ENABLE, 0, 1);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	return iio_write_event_processed_scale(chan, IIO_EV_TYPE_THRESH, dir,
>>> +					       IIO_EV_INFO_ENABLE, 1, 1);
>>> +}
>>> +
>>> +static ssize_t iio_hwmon_read_alarm(struct device *dev,
>>> +				    struct device_attribute *attr,
>>> +				    char *buf)
>>> +{
>>> +	struct iio_hwmon_alarm_attribute *sattr = to_alarm_attr(attr);
>>> +	struct iio_hwmon_state *state = dev_get_drvdata(dev);
>>> +	struct iio_channel *chan = &state->channels[sattr->index];
>>> +
>>> +	if (test_and_clear_bit(sattr->alarm, sattr->listener->alarms)) {
>>> +		u64 id = sattr->listener->ids[sattr->alarm];
>>> +		enum iio_event_direction dir =
>>> IIO_EVENT_CODE_EXTRACT_DIR(id);
>>> +
>>> +		WARN_ON(iio_hwmon_alarm_toggle(chan, dir));
>>
>> WARN_ON() is highly discouraged... Also do we really need a "scary" splat in
>> this case?
> 
> OK, maybe dev_warn then. I don't want to propagate the error because I think
> it's more important to tell userspace that the alarm went off than if there
> was a problem determining if the alarm is still active.
> 

Sorry, I will neither accept backtraces not warning messages in hwmon code.
That risks polluting the kernel log. Propagate the error. I fail to see
the problem with that.

>>> +		strcpy(buf, "1\n");
>>> +		return 2;
>>> +	}
>>> +
>>> +	strcpy(buf, "0\n");
>>> +	return 2;
>>
>> As stated, sysfs_emit()
>>
>>> +}
>>> +
>>>   static int add_device_attr(struct device *dev, struct iio_hwmon_state *st,
>>>   			   ssize_t (*show)(struct device *dev,
>>>   					   struct device_attribute *attr,
>>> @@ -205,6 +453,63 @@ static int add_event_attr(struct device *dev, struct
>>> iio_hwmon_state *st,
>>>   	return 0;
>>>   }
>>>   
>>> +static int add_alarm_attr(struct device *dev, struct iio_hwmon_state *st,
>>> +			  int i, enum iio_event_direction dir,
>>> +			  const char *fmt, ...)
>>> +{
>>> +	struct iio_hwmon_alarm_attribute *a;
>>> +	struct iio_hwmon_listener *listener;
>>> +	ssize_t alarm;
>>> +	umode_t mode;
>>> +	va_list ap;
>>> +	int ret;
>>> +
>>> +	mode = iio_event_mode(&st->channels[i], IIO_EV_TYPE_THRESH, dir,
>>> +			      IIO_EV_INFO_ENABLE);
>>> +	if (!(mode & 0200))
>>> +		return 0;
>>> +
>>> +	listener = iio_hwmon_listener_get(st->channels[i].indio_dev);
>>> +	if (listener == ERR_PTR(-EBUSY))
>>> +		return 0;
>>
>> Maybe I missed something, where can we get -EBUSY? And should we ignore it?
> 
> Oh, this was from before I refactored the notification API to allow kernel
> consumers to co-exist with userspace ones. So this can't occur.
> 
>>> +	if (IS_ERR(listener))
>>> +		return PTR_ERR(listener);
>>> +
>>> +	ret = devm_add_action_or_reset(dev, iio_hwmon_listener_put,
>>> listener);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	alarm = iio_hwmon_lookup_alarm(listener,
>>> +				       iio_event_id(st->channels[i].channel,
>>> +						    IIO_EV_TYPE_THRESH,
>>> dir));
>>> +	if (WARN_ON_ONCE(alarm < 0))
>>> +		return -ENOENT;
>>> +
>>
>> Again, I would drop WARN_ON_ONCE()
> 
> This can only occur if there is a bug in the kernel. We should have returned
> 0 from iio_event_mode() before we get to this point.
> 

Just return the error to the caller (without replacing the error).

Guenter


