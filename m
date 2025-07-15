Return-Path: <linux-iio+bounces-21696-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE48B064A3
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 18:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ABD7566EAA
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 16:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DCB26E6F1;
	Tue, 15 Jul 2025 16:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cE6kgVqM"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691A0F50F
	for <linux-iio@vger.kernel.org>; Tue, 15 Jul 2025 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752598350; cv=none; b=OIIonRHNyeiZL2TnQwnC3+fTggudwYM7AkY9J/5E+DP8K9ol0tQkvmawp+fF+sAwZm4TbYdb9ejt4a3H8A2LL7lZhYSw//fnEg43g4nrUOxDpl7LGnQriGauqEtpF0/y5kJqpkwdMagjKMqX3cMpJzov6t92/R5E+50sDwNP954=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752598350; c=relaxed/simple;
	bh=l2q0cNcmaBiUPTwW4hVxutVcZbj6qnkal5ois0b5IzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YpLRElccAAbcf9fAxngEbPzbUT7OSYoiuuhpEbFAYHqxdT1dklw8JhUc4hTpfO7N2h4CdDE11jqxTCtVp2EJSPU2Lo2NPchL4mCpP8dlYWclsJOK9ecXVTjaNa93BJdZ/AfVMqM3gQGXtg3V3q8MCxxPOgC9hkvYuEQndi4hIXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cE6kgVqM; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9b187e7f-a116-4aea-a9a6-b9222562868d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752598343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PSDwHOwwirTu+5GG5v8MghYDm/bHlnyZneE8eaAnzRo=;
	b=cE6kgVqMqkYNmdqNY7FAcyrYM4YPAbu6khOmp9RxfojkKLRD4vi7QcIbQtTp4SJkNypQZk
	5fCWyX3cxZHrzLVFoAiakRNx6ealXhLA6q3JQcTpVdKYUK+G4vpnDzOWs+vv85a1baus+5
	+iQ+t0NMZWA5ATN1j7kcXbrpUoJDMao=
Date: Tue, 15 Jul 2025 12:52:19 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/7] iio: Add in-kernel API for events
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
 linux-hwmon@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, linux-kernel@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
 <20250715012023.2050178-4-sean.anderson@linux.dev>
 <d8e5c8fbeaee42e9e0708460c47bd68053cd8710.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <d8e5c8fbeaee42e9e0708460c47bd68053cd8710.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/15/25 07:09, Nuno Sá wrote:
> On Mon, 2025-07-14 at 21:20 -0400, Sean Anderson wrote:
>> Add an API to notify consumers about events. Events still need to be
>> enabled using the iio_read_event/iio_write_event functions. Of course,
>> userspace can also manipulate the enabled events. I don't think this is
>> too much of an issue, since userspace can also manipulate the event
>> thresholds. But enabling events may cause existing programs to be
>> surprised when they get something unexpected. Maybe we should set the
>> interface as busy when there are any in-kernel listeners?
>> 
> 
> Sensible question. I'm not that familiar with events but I suspect is not
> trivial (if doable) to do a similar approach as with buffers? With buffers, an
> inkernal consumer get's it's own buffer object (that goes into a list of active
> buffers in the iio device) with all channels enabled and then we demux the
> appropriate channels for each consumer.

For in-kernel consumers I think it's reasonable to expect them to handle
events they didn't explicitly enable. I'm not sure about userspace
consumers.

> Independent of the above, we can argue that having both inkernel and userspace
> changing thresholds is ok (I mean, there's nothing stopping two userspace apps
> doing that) but we should likely be careful with enabling/disabling. If multiple
> consumers enable the same event, one of them disabling it should not disable it
> for all the consumers, right?

Right now the HWMON consumer never permanently disable events to avoid this
issue. It does toggle the enable to determine if an alarm should stay
enabled:
             ________
condition __/        \________
          _____    ____    ___
enable         \__/    \__/

event       |     |
             __    ____
alarm     __/  \__/    \_____

read           1       1    0

I suppose this could also be done by comparing the raw threshold to the
channel.

--Sean

> 
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>> 
>>  drivers/iio/industrialio-event.c | 34 +++++++++++++++++++++++++++-----
>>  include/linux/iio/consumer.h     | 30 ++++++++++++++++++++++++++++
>>  2 files changed, 59 insertions(+), 5 deletions(-)
>> 
>> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-
>> event.c
>> index 06295cfc2da8..b9e3ff1cd5c9 100644
>> --- a/drivers/iio/industrialio-event.c
>> +++ b/drivers/iio/industrialio-event.c
>> @@ -12,11 +12,13 @@
>>  #include <linux/kernel.h>
>>  #include <linux/kfifo.h>
>>  #include <linux/module.h>
>> +#include <linux/notifier.h>
>>  #include <linux/poll.h>
>>  #include <linux/sched.h>
>>  #include <linux/slab.h>
>>  #include <linux/uaccess.h>
>>  #include <linux/wait.h>
>> +#include <linux/iio/consumer.h>
>>  #include <linux/iio/iio.h>
>>  #include <linux/iio/iio-opaque.h>
>>  #include "iio_core.h"
>> @@ -26,6 +28,7 @@
>>  /**
>>   * struct iio_event_interface - chrdev interface for an event line
>>   * @wait:		wait queue to allow blocking reads of events
>> + * @notifier:		notifier head for in-kernel event listeners
>>   * @det_events:		list of detected events
>>   * @dev_attr_list:	list of event interface sysfs attribute
>>   * @flags:		file operations related flags including busy flag.
>> @@ -35,6 +38,7 @@
>>   */
>>  struct iio_event_interface {
>>  	wait_queue_head_t	wait;
>> +	struct atomic_notifier_head notifier;
>>  	DECLARE_KFIFO(det_events, struct iio_event_data, 16);
>>  
>>  	struct list_head	dev_attr_list;
>> @@ -67,18 +71,19 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code,
>> s64 timestamp)
>>  {
>>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>>  	struct iio_event_interface *ev_int = iio_dev_opaque->event_interface;
>> -	struct iio_event_data ev;
>> +	struct iio_event_data ev = {
>> +		.id = ev_code,
>> +		.timestamp = timestamp,
>> +	};
>>  	int copied;
>>  
>>  	if (!ev_int)
>>  		return 0;
>>  
>> +	atomic_notifier_call_chain(&ev_int->notifier, IIO_NOTIFY_EVENT, &ev);
>> +
>>  	/* Does anyone care? */
>>  	if (iio_event_enabled(ev_int)) {
>> -
>> -		ev.id = ev_code;
>> -		ev.timestamp = timestamp;
>> -
>>  		copied = kfifo_put(&ev_int->det_events, ev);
>>  		if (copied != 0)
>>  			wake_up_poll(&ev_int->wait, EPOLLIN);
>> @@ -223,6 +228,25 @@ static int iio_event_getfd(struct iio_dev *indio_dev)
>>  	return fd;
>>  }
>>  
>> +int iio_event_register(struct iio_dev *indio_dev, struct notifier_block
>> *block)
>> +{
>> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>> +	struct iio_event_interface *ev_int = iio_dev_opaque->event_interface;
>> +
>> +	return atomic_notifier_chain_register(&ev_int->notifier, block);
>> +}
>> +EXPORT_SYMBOL_GPL(iio_event_register);
>> +
>> +void iio_event_unregister(struct iio_dev *indio_dev,
>> +			  struct notifier_block *block)
>> +{
>> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>> +	struct iio_event_interface *ev_int = iio_dev_opaque->event_interface;
>> +
>> +	WARN_ON(atomic_notifier_chain_unregister(&ev_int->notifier, block));
>> +}
>> +EXPORT_SYMBOL_GPL(iio_event_unregister);
>> +
>>  static const char * const iio_ev_type_text[] = {
>>  	[IIO_EV_TYPE_THRESH] = "thresh",
>>  	[IIO_EV_TYPE_MAG] = "mag",
>> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
>> index 16e7682474f3..9918e3f7af3d 100644
>> --- a/include/linux/iio/consumer.h
>> +++ b/include/linux/iio/consumer.h
>> @@ -507,4 +507,34 @@ int iio_write_event_processed_scale(struct iio_channel
>> *chan,
>>  				    enum iio_event_info info, int processed,
>>  				    unsigned int scale);
>>  
>> +struct notifier_block;
>> +enum iio_notifier_val {
>> +	/** IIO_NOTIFY_EVENT: v is a pointer to &struct iio_event_data */
>> +	IIO_NOTIFY_EVENT,
>> +};
>> +
>> +/**
>> + * iio_event_register() - Register a notifier for events
>> + * @indio_dev: Device to be notified of events on
>> + * @block: Notifier block to register
>> + *
>> + * Register a notifier for events on @indio_dev. @v will be a member of &enum
>> + * iio_notifier_val. Notifiers will be called in atomic context. @indio_dev
>> + * must stay valid until you call iio_event_unregister().
>> + *
>> + * Return: 0 on success, or -EEXIST if @block has already been registered
>> + */
>> +int iio_event_register(struct iio_dev *indio_dev,
>> +		       struct notifier_block *block);
>> +
>> +/**
>> + * iio_event_unregister() - Remove a previously-added notifier
>> + * @indio_dev: Device to be notified of events on
>> + * @block: Notifier previously-registered with iio_event_register()
>> + *
>> + * Remove a previously-added notifier.
>> + */
>> +void iio_event_unregister(struct iio_dev *indio_dev,
>> +			  struct notifier_block *block);
>> +
>>  #endif

