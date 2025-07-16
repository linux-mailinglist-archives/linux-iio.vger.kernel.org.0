Return-Path: <linux-iio+bounces-21722-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A84B072B4
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 12:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9B401888462
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 10:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F602F237C;
	Wed, 16 Jul 2025 10:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IXmlqVJX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1012EA158;
	Wed, 16 Jul 2025 10:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752660544; cv=none; b=W22mIa5w+/U+8Nq5YrvU1eVpxr0ishTCRBaKWigzg46R/kcIka86+jWwvQqDFRkYnAhR//94BHzXe+ywJzuTocCQM+HgJvfHblkbzfT7KbTFum+SP9wURRbu9rx7trcK8kHH/diDoyy1dbAnwLPbYk5KixrCFCBGFS/NR6geSY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752660544; c=relaxed/simple;
	bh=jjfiSEBD6Be1rNTg7zIFXMEUwaoclF9nvMC4ZmIPho4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBpfrKYja2tz5sk3B1eVBnBsiFCdld6SK83d+rNVUWNR3bl/8cYHcyJI24JcOHevzo72ERCrUdnpEQ9/HcQzkgW+xCPCArZBFoTWHnA2uNHmYHUEHY55tbglzdbt25CUdYoW7lUWHjNH2vslrWuEvVqF9SEt8UxBjpCDlJ+ngtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IXmlqVJX; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752660540; x=1784196540;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jjfiSEBD6Be1rNTg7zIFXMEUwaoclF9nvMC4ZmIPho4=;
  b=IXmlqVJXWlBPtJ9LurHa5PdfB+2fg9HGa0XiQoHUz5IoCNxEy9TBcTG9
   AWyBMNqN9LJO6Qmm+MXHZlZ4SHVgXm4RfV0XVGtZXV2T8OTfEG8pPLc6G
   Qv7B6s63YUR6UZxDbrKVjADQ7OGyiSqwThcL5HcXWANU3A6NkPEszBr+h
   lz6FuIN9jhITKWnhDRSuHzd6yMP/4BPJ7UFtrc9dcIVg3nC+holPY1LLA
   QjG3XJWxfjbLoScHXXfxPj0m6yOk/V7oDVPIs0dyggslbJItlB/nEf0ew
   wRuyV7OMrffIP5/eqkJcnI6kHTmEdGfEnrTXM+O13X4jacKtv6P2sgFKW
   A==;
X-CSE-ConnectionGUID: n7ICpMLGQHiN8RfypzTiog==
X-CSE-MsgGUID: GFmKW0f0TIKZKIWe47A99g==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="42530301"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="42530301"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 03:08:59 -0700
X-CSE-ConnectionGUID: Yi46FFWKTeevyCcjoU7exw==
X-CSE-MsgGUID: ERKRPph5SLqKuRw+jeU1vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="188426279"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 03:08:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ubz4H-0000000FuMD-0YSb;
	Wed, 16 Jul 2025 13:08:53 +0300
Date: Wed, 16 Jul 2025 13:08:52 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Jonathan Cameron <jic23@kernel.org>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 7/7] hwmon: iio: Add alarm support
Message-ID: <aHd6NEHcCa6aqJB5@smile.fi.intel.com>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
 <20250715012023.2050178-8-sean.anderson@linux.dev>
 <aHYWQOjJEWdLjy7H@smile.fi.intel.com>
 <3b35b3a7-3f1a-4401-9b60-ba4afda5636e@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b35b3a7-3f1a-4401-9b60-ba4afda5636e@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 15, 2025 at 12:20:24PM -0400, Sean Anderson wrote:
> On 7/15/25 04:50, Andy Shevchenko wrote:
> > On Mon, Jul 14, 2025 at 09:20:23PM -0400, Sean Anderson wrote:

...

> >>  #include <linux/hwmon-sysfs.h>
> > 
> > + blank line here..
> 
> why?

To group the subsystem related headers (which are more custom and less generic).
This allows to follow what the subsystems are in use and what APIs / types are
taken.

> >>  #include <linux/iio/consumer.h>
> >> +#include <linux/iio/events.h>
> >> +#include <linux/iio/iio.h>
> >>  #include <linux/iio/types.h>
> > 
> > ...and here?
> 
> OK
> 
> >> +#include <uapi/linux/iio/events.h>

As similar here, to visually split uAPI and the rest. This increases
readability and maintenance.

...

> >> +static ssize_t iio_hwmon_lookup_alarm(struct iio_hwmon_listener *listener,
> >> +				      u64 id)
> >> +{
> >> +	ssize_t i;
> >> +
> >> +	for (i = 0; i < listener->num_alarms; i++)
> >> +		if (listener->ids[i] == id)
> >> +			return i;
> > 
> >> +	return -1;
> > 
> > -ENOENT ?
> > This will allow to propagate an error code to the upper layer(s).
> 
> I suppose. But I think
> 
> alarm = iio_hwmon_lookup_alarm(...);
> if (alarm < 0)
> 	return -ENOENT;
> 
> is clearer than

I disagree. This makes it worth as it shadows other possible code(s), if any,
and makes harder to follow as reader has to check the callee implementation.

The shadow error codes need a justification.

> alarm = iio_hwmon_lookup_alarm(...);
> if (alarm < 0)
> 	return alarm;
> 
> because you don't have to read the definition of iio_hwmon_lookup_alarm
> to determine what the return value is.

Exactly my point!

> >> +}

...

> >> +err_alarms:
> >> +	kfree(listener->alarms);
> >> +	kfree(listener->ids);
> >> +err_listener:
> >> +	kfree(listener);
> >> +err_unlock:
> >> +	mutex_unlock(&iio_hwmon_listener_lock);
> >> +	return ERR_PTR(err);
> > 
> > What about using __free()?
> 
> That works for listener, but not for alarms or ids.

Why not?

...

> >> +static void iio_hwmon_listener_put(void *data)
> >> +{
> >> +	struct iio_hwmon_listener *listener = data;
> >> +
> >> +	scoped_guard(mutex, &iio_hwmon_listener_lock) {
> >> +		if (unlikely(listener->refcnt == UINT_MAX))
> >> +			return;
> >> +
> >> +		if (--listener->refcnt)
> >> +			return;
> > 
> > Can the refcount_t be used with the respective APIs? Or even kref?
> 
> Why? We do all the manipulation under a mutex, so there is no point in
> atomic access. Instead of the games refcnt_t has to play to try and
> prevent overflow we can just check for it directly.

refcount_t provides a facility of overflow/underflow. Also it gives better
understanding from the data type to see which value and how does that.

> >> +		list_del(&listener->list);
> >> +		iio_event_unregister(listener->indio_dev, &listener->block);
> >> +	}
> >> +
> >> +	kfree(listener->alarms);
> >> +	kfree(listener->ids);
> >> +	kfree(listener);
> >> +}

...

> >> +	if (test_and_clear_bit(sattr->alarm, sattr->listener->alarms)) {
> >> +		u64 id = sattr->listener->ids[sattr->alarm];
> >> +		enum iio_event_direction dir = IIO_EVENT_CODE_EXTRACT_DIR(id);
> >> +
> >> +		WARN_ON(iio_hwmon_alarm_toggle(chan, dir));
> > 
> >> +		strcpy(buf, "1\n");
> >> +		return 2;
> > 
> >> +	}
> >> +
> >> +	strcpy(buf, "0\n");
> >> +	return 2;
> > 
> > Better to assign the value and
> >
> > 	return sysfs_emit(...);
> > 
> > which will make even easier to recognize that this is supplied to user via
> > sysfs.
> 
> :l
> 
> the things we do to avoid memcpy...

...for the cost of readability. Also this is a slow path.

-- 
With Best Regards,
Andy Shevchenko



