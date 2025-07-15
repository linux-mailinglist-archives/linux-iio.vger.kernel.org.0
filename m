Return-Path: <linux-iio+bounces-21670-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF055B05562
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 10:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0F0B4A31C2
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 08:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB3E274672;
	Tue, 15 Jul 2025 08:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TG+qkn+G"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634CD275851;
	Tue, 15 Jul 2025 08:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752569417; cv=none; b=ngyCGvNzMkYtx5L7gslpgNnr+NicbaTWvlJODYYCuxTR8V3S1uKtAiM/Wa8h03DKdZHQHoWy3dGxkk8Sq7SMwhEAkirJRXQX+i7lNIQGT8r0CCNzC+azz9NneCx92cm67tKVjfYkD1cTUYZWDFLYkph9q2z9FHnOW9yytWGKXy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752569417; c=relaxed/simple;
	bh=K0DvSk4svt0sUfo87/h4UlF6aaEVaGHYSOZP6a/6be4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcOROSPrqZaYhm7FK0ZNm88O2q9DN5vXPUpJCOY7k06FGlLdscoUm5flmdiMCW/StzyckPRiChfFqspuL+XJ6qC9smSWrZ/7WtJZp95L5xNMVUJ1n950Cvhf+9yVRhhebBwgFQJKFxcU8HPIDbcETrMWsrw2NHaZbwNHnCrptiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TG+qkn+G; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752569416; x=1784105416;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K0DvSk4svt0sUfo87/h4UlF6aaEVaGHYSOZP6a/6be4=;
  b=TG+qkn+G0qySdgl4INz//NDOM/6A+IQbaPuIy1EUnJbuFdOj2jOgkjYE
   V36QhhA/7bqQBJxT7ez0jp0ucGJlcrofAVLxZc7NlINHPus7Eipuq108L
   YF4aetXGj1ISRpvhV7PEL98JAMhjD4ycLXSLCtsAGtOrlQ+BkYgPhpbfT
   4MJVld3/OYnYv6nB3DuY3KHjk7yIL5R8cKuH7UQVfgaZLNAWhtxu4ca/E
   JgRYBOo6U+5TX0TUVTQSmmlvHa55sf03zBG1PJliKbCkNnLfxV04ixj0i
   Ved7bPtHEw844AQXEOh5PVFRzcAXLpPs4s/kUYtafi9SOxRh0aoNZiwhy
   Q==;
X-CSE-ConnectionGUID: HNcibtzpTWCKYujhDzuXDg==
X-CSE-MsgGUID: ziEj+AYMQ8i40SyNjISXHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65476180"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="65476180"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 01:50:15 -0700
X-CSE-ConnectionGUID: UigDI2sfQDqoyUgBZqUZXA==
X-CSE-MsgGUID: lzDOLTpsQUuX9UMunoCZaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="188155520"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 01:50:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ubbMW-0000000FbP9-3zae;
	Tue, 15 Jul 2025 11:50:08 +0300
Date: Tue, 15 Jul 2025 11:50:08 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Jonathan Cameron <jic23@kernel.org>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 7/7] hwmon: iio: Add alarm support
Message-ID: <aHYWQOjJEWdLjy7H@smile.fi.intel.com>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
 <20250715012023.2050178-8-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715012023.2050178-8-sean.anderson@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 14, 2025 at 09:20:23PM -0400, Sean Anderson wrote:
> Add alarm support based on IIO threshold events. The alarm is cleared on
> read, but will be set again if the condition is still present. This is
> detected by disabling and re-enabling the event. The same trick is done
> when creating the attribute to detect already-triggered events.
> 
> The alarms are updated by an event listener. To keep the notifier call
> chain short, we create one listener per iio device, shared across all
> hwmon devices.
> 
> To avoid dynamic creation of alarms, alarms for all possible events are
> allocated at creation. Lookup is done by a linear scan, as I expect
> events to occur rarely. If performance becomes an issue, a binary search
> could be done instead (or some kind of hash lookup).

...

>  #include <linux/hwmon-sysfs.h>

+ blank line here..

>  #include <linux/iio/consumer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
>  #include <linux/iio/types.h>

...and here?

> +#include <uapi/linux/iio/events.h>

...

> +static ssize_t iio_hwmon_lookup_alarm(struct iio_hwmon_listener *listener,
> +				      u64 id)
> +{
> +	ssize_t i;
> +
> +	for (i = 0; i < listener->num_alarms; i++)
> +		if (listener->ids[i] == id)
> +			return i;

> +	return -1;

-ENOENT ?
This will allow to propagate an error code to the upper layer(s).

> +}

...

> +static int iio_hwmon_listener_callback(struct notifier_block *block,
> +				       unsigned long action, void *data)
> +{
> +	struct iio_hwmon_listener *listener =
> +		container_of(block, struct iio_hwmon_listener, block);
> +	struct iio_event_data *ev = data;
> +	ssize_t i;
> +
> +	if (action != IIO_NOTIFY_EVENT)
> +		return NOTIFY_DONE;
> +
> +	i = iio_hwmon_lookup_alarm(listener, ev->id);
> +	if (i >= 0)
> +		set_bit(i, listener->alarms);

Do you need an atomic set?

> +	else
> +		dev_warn_once(&listener->indio_dev->dev,
> +			      "unknown event %016llx\n", ev->id);
> +
> +	return NOTIFY_DONE;
> +}

...

> +static struct iio_hwmon_listener *iio_hwmon_listener_get(struct iio_dev *indio_dev)
> +{
> +	struct iio_hwmon_listener *listener;
> +	int err = -ENOMEM;
> +	size_t i, j;
> +
> +	guard(mutex)(&iio_hwmon_listener_lock);
> +	list_for_each_entry(listener, &iio_hwmon_listeners, list) {
> +		if (listener->indio_dev == indio_dev) {
> +			if (likely(listener->refcnt != UINT_MAX))
> +				listener->refcnt++;
> +			return listener;
> +		}
> +	}
> +
> +	listener = kzalloc(sizeof(*listener), GFP_KERNEL);
> +	if (!listener)
> +		goto err_unlock;
> +
> +	listener->refcnt = 1;
> +	listener->indio_dev = indio_dev;
> +	listener->block.notifier_call = iio_hwmon_listener_callback;
> +	for (i = 0; i < indio_dev->num_channels; i++)
> +		listener->num_alarms += indio_dev->channels[i].num_event_specs;
> +
> +	listener->ids = kcalloc(listener->num_alarms, sizeof(*listener->ids),
> +				GFP_KERNEL);
> +	listener->alarms = bitmap_zalloc(listener->num_alarms, GFP_KERNEL);
> +	if (!listener->ids || !listener->alarms)
> +		goto err_listener;
> +
> +	i = 0;
> +	for (j = 0; j < indio_dev->num_channels; j++) {
> +		struct iio_chan_spec const *chan = &indio_dev->channels[j];
> +		size_t k;
> +
> +		for (k = 0; k < chan->num_event_specs; k++)
> +			listener->ids[i++] =
> +				iio_event_id(chan, chan->event_spec[k].type,
> +					     chan->event_spec[k].dir);
> +	}
> +
> +	err = iio_event_register(indio_dev, &listener->block);
> +	if (err)
> +		goto err_alarms;
> +
> +	list_add(&listener->list, &iio_hwmon_listeners);

> +	mutex_unlock(&iio_hwmon_listener_lock);

With guard() ???

> +	return listener;
> +
> +err_alarms:
> +	kfree(listener->alarms);
> +	kfree(listener->ids);
> +err_listener:
> +	kfree(listener);
> +err_unlock:
> +	mutex_unlock(&iio_hwmon_listener_lock);
> +	return ERR_PTR(err);

What about using __free()?

> +}

...

> +static void iio_hwmon_listener_put(void *data)
> +{
> +	struct iio_hwmon_listener *listener = data;
> +
> +	scoped_guard(mutex, &iio_hwmon_listener_lock) {
> +		if (unlikely(listener->refcnt == UINT_MAX))
> +			return;
> +
> +		if (--listener->refcnt)
> +			return;

Can the refcount_t be used with the respective APIs? Or even kref?

> +		list_del(&listener->list);
> +		iio_event_unregister(listener->indio_dev, &listener->block);
> +	}
> +
> +	kfree(listener->alarms);
> +	kfree(listener->ids);
> +	kfree(listener);
> +}

...

> +static ssize_t iio_hwmon_read_alarm(struct device *dev,
> +				    struct device_attribute *attr,
> +				    char *buf)
> +{
> +	struct iio_hwmon_alarm_attribute *sattr = to_alarm_attr(attr);
> +	struct iio_hwmon_state *state = dev_get_drvdata(dev);
> +	struct iio_channel *chan = &state->channels[sattr->index];
> +
> +	if (test_and_clear_bit(sattr->alarm, sattr->listener->alarms)) {
> +		u64 id = sattr->listener->ids[sattr->alarm];
> +		enum iio_event_direction dir = IIO_EVENT_CODE_EXTRACT_DIR(id);
> +
> +		WARN_ON(iio_hwmon_alarm_toggle(chan, dir));

> +		strcpy(buf, "1\n");
> +		return 2;

> +	}
> +
> +	strcpy(buf, "0\n");
> +	return 2;

Better to assign the value and

	return sysfs_emit(...);

which will make even easier to recognize that this is supplied to user via
sysfs.

> +}

...

> +static int add_alarm_attr(struct device *dev, struct iio_hwmon_state *st,
> +			  int i, enum iio_event_direction dir,
> +			  const char *fmt, ...)

Same comments as per previous patches.

-- 
With Best Regards,
Andy Shevchenko



