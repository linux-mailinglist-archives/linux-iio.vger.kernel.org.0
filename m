Return-Path: <linux-iio+bounces-21754-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A32B091A8
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 18:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 960EB7A30EB
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 16:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94792FCE01;
	Thu, 17 Jul 2025 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iHnxNFs+"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D442FCE00
	for <linux-iio@vger.kernel.org>; Thu, 17 Jul 2025 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752769447; cv=none; b=YKMzEvcABGp7CzR33aDTcYd/a++Y5u/0hN9w7D6Xn+HseNCMhPPul0k+Obeekc4WuVNhUyiTWoR0RN1ZB8+GlYAgCNWGSq47bUJOcvVpUqvRNu7kHfIW4V4dffmcX+fHvUdyxRRL5xA5BP78xVKw6AP6vpJEBqDCd9p01C0Q6bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752769447; c=relaxed/simple;
	bh=YHuSeGyuzFj9eRs/8QVHHlbOr1O51SW1Pl4XyCBBqt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KzfqfeRD7h9izsT5/xHoTcXkKwI3mNR/Lo4VI/zw93AKBLsgVMcHWfQiyxLUU32UgRyyJXcCkGKJx6cNgaCInLIkUul1J1OhsQ0XuTDf3L8D2e/xgCWqwQx6j7KMzbZEXFUb2rq9dLzgVRrXQneSR5PQpvLY+ZEcJmUyodA1ey4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iHnxNFs+; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e4894ab6-dd75-45d5-a49f-832c64b89eaf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752769443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n7vMLMzdSHL/tgeYa8YW+cdNWD5F1hvYoUcll8af0rA=;
	b=iHnxNFs+8qvF6hO4DdUrh0ge01fM5hEh1n5K2U1wXr+pU3ZlIW8XScPlK8vTGjNGuWk+5t
	xToIfuoSbl4ifZDfmb5xnnlVZJ2gRySLuqDdwrgSRZxY9MPG6llW6TDvsrOm6Qv1wCQ2M4
	N+JFY00fT1xqfPJQRu+XKX/anERv13M=
Date: Thu, 17 Jul 2025 12:23:58 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 7/7] hwmon: iio: Add alarm support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-kernel@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
 <20250715012023.2050178-8-sean.anderson@linux.dev>
 <aHYWQOjJEWdLjy7H@smile.fi.intel.com>
 <3b35b3a7-3f1a-4401-9b60-ba4afda5636e@linux.dev>
 <aHd6NEHcCa6aqJB5@smile.fi.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <aHd6NEHcCa6aqJB5@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/16/25 06:08, Andy Shevchenko wrote:
> On Tue, Jul 15, 2025 at 12:20:24PM -0400, Sean Anderson wrote:
>> On 7/15/25 04:50, Andy Shevchenko wrote:
>> > On Mon, Jul 14, 2025 at 09:20:23PM -0400, Sean Anderson wrote:
> 
> ...
> 
>> >>  #include <linux/hwmon-sysfs.h>
>> > 
>> > + blank line here..
>> 
>> why?
> 
> To group the subsystem related headers (which are more custom and less generic).
> This allows to follow what the subsystems are in use and what APIs / types are
> taken.

Then you should send a patch for coding-style.rst.

>> >>  #include <linux/iio/consumer.h>
>> >> +#include <linux/iio/events.h>
>> >> +#include <linux/iio/iio.h>
>> >>  #include <linux/iio/types.h>
>> > 
>> > ...and here?
>> 
>> OK
>> 
>> >> +#include <uapi/linux/iio/events.h>
> 
> As similar here, to visually split uAPI and the rest. This increases
> readability and maintenance.
> 
> ...
> 
>> >> +static ssize_t iio_hwmon_lookup_alarm(struct iio_hwmon_listener *listener,
>> >> +				      u64 id)
>> >> +{
>> >> +	ssize_t i;
>> >> +
>> >> +	for (i = 0; i < listener->num_alarms; i++)
>> >> +		if (listener->ids[i] == id)
>> >> +			return i;
>> > 
>> >> +	return -1;
>> > 
>> > -ENOENT ?
>> > This will allow to propagate an error code to the upper layer(s).
>> 
>> I suppose. But I think
>> 
>> alarm = iio_hwmon_lookup_alarm(...);
>> if (alarm < 0)
>> 	return -ENOENT;
>> 
>> is clearer than
> 
> I disagree. This makes it worth as it shadows other possible code(s), if any,
> and makes harder to follow as reader has to check the callee implementation.
> 
> The shadow error codes need a justification.

OK, I will return a bool next time to avoid any misconceptions that the return
code means anything other than "found" or "not found"

>> alarm = iio_hwmon_lookup_alarm(...);
>> if (alarm < 0)
>> 	return alarm;
>> 
>> because you don't have to read the definition of iio_hwmon_lookup_alarm
>> to determine what the return value is.
> 
> Exactly my point!

your point is that you want readers to have to read the definition of
iio_hwmon_lookup_alarm in order to determine that ENOENT is a possible
error from add_alarm_attr? I don't follow.

>> >> +}
> 
> ...
> 
>> >> +err_alarms:
>> >> +	kfree(listener->alarms);
>> >> +	kfree(listener->ids);
>> >> +err_listener:
>> >> +	kfree(listener);
>> >> +err_unlock:
>> >> +	mutex_unlock(&iio_hwmon_listener_lock);
>> >> +	return ERR_PTR(err);
>> > 
>> > What about using __free()?
>> 
>> That works for listener, but not for alarms or ids.
> 
> Why not?
> 
> ...
> 
>> >> +static void iio_hwmon_listener_put(void *data)
>> >> +{
>> >> +	struct iio_hwmon_listener *listener = data;
>> >> +
>> >> +	scoped_guard(mutex, &iio_hwmon_listener_lock) {
>> >> +		if (unlikely(listener->refcnt == UINT_MAX))
>> >> +			return;
>> >> +
>> >> +		if (--listener->refcnt)
>> >> +			return;
>> > 
>> > Can the refcount_t be used with the respective APIs? Or even kref?
>> 
>> Why? We do all the manipulation under a mutex, so there is no point in
>> atomic access. Instead of the games refcnt_t has to play to try and
>> prevent overflow we can just check for it directly.
> 
> refcount_t provides a facility of overflow/underflow.

refcount_t can't prevent underflow because it's atomic. All it can do is
warn after the fact. And of course overflow is handled properly here.
But it can't occur in practice unless you specifically load multiple
devicetrees at runtime. So we don't need it anyway.

> Also it gives better
> understanding from the data type to see which value and how does that.

That's why I named the variable "refcnt".

>> >> +		list_del(&listener->list);
>> >> +		iio_event_unregister(listener->indio_dev, &listener->block);
>> >> +	}
>> >> +
>> >> +	kfree(listener->alarms);
>> >> +	kfree(listener->ids);
>> >> +	kfree(listener);
>> >> +}
> 
> ...
> 
>> >> +	if (test_and_clear_bit(sattr->alarm, sattr->listener->alarms)) {
>> >> +		u64 id = sattr->listener->ids[sattr->alarm];
>> >> +		enum iio_event_direction dir = IIO_EVENT_CODE_EXTRACT_DIR(id);
>> >> +
>> >> +		WARN_ON(iio_hwmon_alarm_toggle(chan, dir));
>> > 
>> >> +		strcpy(buf, "1\n");
>> >> +		return 2;
>> > 
>> >> +	}
>> >> +
>> >> +	strcpy(buf, "0\n");
>> >> +	return 2;
>> > 
>> > Better to assign the value and
>> >
>> > 	return sysfs_emit(...);
>> > 
>> > which will make even easier to recognize that this is supplied to user via
>> > sysfs.
>> 
>> :l
>> 
>> the things we do to avoid memcpy...
> 
> ...for the cost of readability. Also this is a slow path.




