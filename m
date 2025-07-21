Return-Path: <linux-iio+bounces-21793-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4708CB0BDF2
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 09:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCBD51892D42
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 07:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132F928468D;
	Mon, 21 Jul 2025 07:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GIVJ3VQ8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F98284685;
	Mon, 21 Jul 2025 07:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753083771; cv=none; b=eiTwGrF2uwrwdgdRk3tJSg0XKgpBjNQUd14CoJhQjGBhhRa/RfQHmchoqyNUMhyrwzP2aegzOwGcAqKFjeLl/n8CUATYvcD9aGhk24HjBreo2s6b/N8/F0U2Q855Ey75WaIfx+ygSx6AhkYzUNc8I2isO1TIAvyboPlA7gMZDeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753083771; c=relaxed/simple;
	bh=Q4RBacuprSEIc9pez5OZQhXVT32g2ZtOfNSxEYIpOio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xno+K6+SCHLwvkcq6vC62BmNHz2WkCuF0mO5dQJmagghNLYuwaDKyz0tV308XixzeXHxzTvX/4J9WZObWxHAxBXP5GT+KXMY/3iuX9v/FFu6J32gvdx308aqcjgKZ2/w9xc+a1yowTv8iKMhnGS7HnWSGCpsG09mybvJJ3lqy7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GIVJ3VQ8; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753083770; x=1784619770;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q4RBacuprSEIc9pez5OZQhXVT32g2ZtOfNSxEYIpOio=;
  b=GIVJ3VQ8RDUfJzvYVZs6KkV47FlFyjRztWZfSFkwfIczBrPOdYIT50tg
   QuP+7WcVPwJlQyLRAP8nJnxEsjCPqTT1LMn0/9+sDSlV6yOtrSDa1zDyF
   rNRFtMW0xCLnWsAlnMvlx/xQb9UxYwDoHRbhUhWQ9s2W7C4uyKn9XET2z
   H75IFBnskQypK1rHpVRQihme4Mp6ejqFp6jnHby5pPESXt/XG1Cd72fBH
   vWvUwOmFtwI15/rLE/wntsVLDWh6FvHqJM3iQpxdg9K61vJpjWGuQpfau
   v3DoCkzlMYYP1o+mAnqRVyKJVHHX43amsURkz4v0lO8f3WJdlrWkhIQyY
   w==;
X-CSE-ConnectionGUID: geES7QqTR9ij1zXr7lk8pg==
X-CSE-MsgGUID: pr3SWbTpQ/yDNKEFeEF4ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="55444609"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="55444609"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 00:42:49 -0700
X-CSE-ConnectionGUID: rc6vbhyTSyqvAelJSe+wOw==
X-CSE-MsgGUID: Kp+L3q7rRMOBCfw6bfXsqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="158885160"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 00:42:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1udlAZ-0000000HHbP-37cp;
	Mon, 21 Jul 2025 10:42:43 +0300
Date: Mon, 21 Jul 2025 10:42:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Jonathan Cameron <jic23@kernel.org>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 7/7] hwmon: iio: Add alarm support
Message-ID: <aH3vcye29TrG8s2Z@smile.fi.intel.com>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
 <20250715012023.2050178-8-sean.anderson@linux.dev>
 <aHYWQOjJEWdLjy7H@smile.fi.intel.com>
 <3b35b3a7-3f1a-4401-9b60-ba4afda5636e@linux.dev>
 <aHd6NEHcCa6aqJB5@smile.fi.intel.com>
 <e4894ab6-dd75-45d5-a49f-832c64b89eaf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4894ab6-dd75-45d5-a49f-832c64b89eaf@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 17, 2025 at 12:23:58PM -0400, Sean Anderson wrote:
> On 7/16/25 06:08, Andy Shevchenko wrote:
> > On Tue, Jul 15, 2025 at 12:20:24PM -0400, Sean Anderson wrote:
> >> On 7/15/25 04:50, Andy Shevchenko wrote:
> >> > On Mon, Jul 14, 2025 at 09:20:23PM -0400, Sean Anderson wrote:

...

> >> >>  #include <linux/hwmon-sysfs.h>
> >> > 
> >> > + blank line here..
> >> 
> >> why?
> > 
> > To group the subsystem related headers (which are more custom and less generic).
> > This allows to follow what the subsystems are in use and what APIs / types are
> > taken.
> 
> Then you should send a patch for coding-style.rst.

Does any of the common sense approach need to be written in the documentation?

> >> >>  #include <linux/iio/consumer.h>
> >> >> +#include <linux/iio/events.h>
> >> >> +#include <linux/iio/iio.h>
> >> >>  #include <linux/iio/types.h>
> >> > 
> >> > ...and here?
> >> 
> >> OK
> >> 
> >> >> +#include <uapi/linux/iio/events.h>
> > 
> > As similar here, to visually split uAPI and the rest. This increases
> > readability and maintenance.

...

> >> >> +static ssize_t iio_hwmon_lookup_alarm(struct iio_hwmon_listener *listener,
> >> >> +				      u64 id)
> >> >> +{
> >> >> +	ssize_t i;
> >> >> +
> >> >> +	for (i = 0; i < listener->num_alarms; i++)
> >> >> +		if (listener->ids[i] == id)
> >> >> +			return i;
> >> > 
> >> >> +	return -1;
> >> > 
> >> > -ENOENT ?
> >> > This will allow to propagate an error code to the upper layer(s).
> >> 
> >> I suppose. But I think
> >> 
> >> alarm = iio_hwmon_lookup_alarm(...);
> >> if (alarm < 0)
> >> 	return -ENOENT;
> >> 
> >> is clearer than
> > 
> > I disagree. This makes it worth as it shadows other possible code(s), if any,
> > and makes harder to follow as reader has to check the callee implementation.
> > 
> > The shadow error codes need a justification.
> 
> OK, I will return a bool next time to avoid any misconceptions that the return
> code means anything other than "found" or "not found"

This makes sense. And IIRC it's even documented.

> >> alarm = iio_hwmon_lookup_alarm(...);
> >> if (alarm < 0)
> >> 	return alarm;
> >> 
> >> because you don't have to read the definition of iio_hwmon_lookup_alarm
> >> to determine what the return value is.
> > 
> > Exactly my point!
> 
> your point is that you want readers to have to read the definition of
> iio_hwmon_lookup_alarm in order to determine that ENOENT is a possible
> error from add_alarm_attr? I don't follow.

No, my point is that readers should not care about error code. If it's
propagated to the upper layer, the upper layer will decide on how to proceed.
And -ENOENT is de facto standard for "entity not found".

> >> >> +}

...

> >> >> +err_alarms:
> >> >> +	kfree(listener->alarms);
> >> >> +	kfree(listener->ids);
> >> >> +err_listener:
> >> >> +	kfree(listener);
> >> >> +err_unlock:
> >> >> +	mutex_unlock(&iio_hwmon_listener_lock);
> >> >> +	return ERR_PTR(err);
> >> > 
> >> > What about using __free()?
> >> 
> >> That works for listener, but not for alarms or ids.
> > 
> > Why not?

No answer? Have you checked how cleanup.h suggests to avoid cleaning the memory
when it's supposed to be used later on?

...

> >> >> +static void iio_hwmon_listener_put(void *data)
> >> >> +{
> >> >> +	struct iio_hwmon_listener *listener = data;
> >> >> +
> >> >> +	scoped_guard(mutex, &iio_hwmon_listener_lock) {
> >> >> +		if (unlikely(listener->refcnt == UINT_MAX))
> >> >> +			return;
> >> >> +
> >> >> +		if (--listener->refcnt)
> >> >> +			return;
> >> > 
> >> > Can the refcount_t be used with the respective APIs? Or even kref?
> >> 
> >> Why? We do all the manipulation under a mutex, so there is no point in
> >> atomic access. Instead of the games refcnt_t has to play to try and
> >> prevent overflow we can just check for it directly.
> > 
> > refcount_t provides a facility of overflow/underflow.
> 
> refcount_t can't prevent underflow because it's atomic. All it can do is
> warn after the fact. And of course overflow is handled properly here.
> But it can't occur in practice unless you specifically load multiple
> devicetrees at runtime. So we don't need it anyway.

It will warn the user in such cases. Your code won't do it, even if it's not a
big deal or never happens situation, it's still better to use in-kernel
standard ways of handling these things.

> > Also it gives better
> > understanding from the data type to see which value and how does that.
> 
> That's why I named the variable "refcnt".

Yes, and that's why I asked about existing interface / API / type to use.

> >> >> +		list_del(&listener->list);
> >> >> +		iio_event_unregister(listener->indio_dev, &listener->block);
> >> >> +	}
> >> >> +
> >> >> +	kfree(listener->alarms);
> >> >> +	kfree(listener->ids);
> >> >> +	kfree(listener);
> >> >> +}

-- 
With Best Regards,
Andy Shevchenko



