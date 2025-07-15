Return-Path: <linux-iio+bounces-21703-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06013B06784
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 22:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BFA63BD444
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 20:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE6E28C864;
	Tue, 15 Jul 2025 20:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WNcbD5IY"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31DB286D75;
	Tue, 15 Jul 2025 20:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752610112; cv=none; b=QNbVSb1JkQfN44CC/FBxDB4rQYze6yOBcpJ41kogOFgKcl6DKMDNFR9KVGjx7y2DPMimDntxsiOLx7hhGeZRidMEEoLT6WRlPlP38OdqxrRZZ/keMW8lRqxDFfg+d5KLdF05FKTd/gWRr9jISWCZqeDKIAfeAAIL4J+Pte0pz/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752610112; c=relaxed/simple;
	bh=TFPHAYC2KV+LZgs6UfGifLqRkJfkyNBs/xIs9+BnA4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BCUvIEIm5iJJ2Fr5jumR4Ebe+F0CCk2Zr9kArxt6bM0/O2paQWoSe8KtfAVKGEHd1Q3lTMQSbEhFIBYIZD5W6nA/5PgOTQwt4dKU7iyajYziRpIYjC3/HjszAve8oLtdfeZ2410uPWwpaHk04bACyhZgO+QismRj3644vk1DHQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WNcbD5IY; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <52340e28-0ad4-4e67-adee-3c08b1c98b10@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752610097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tJEb6T0GNLELePzDF5Y/eNum6e1uiWl2oXlgfzcvKLw=;
	b=WNcbD5IYRyL4NEn6TGgmNVxwWUmOVOzcNtV/2F3GcH2vzOyCNn1dhXQE8crOwhySKn4Cil
	j6ebEc2ISiDSJI1cxvpjtGiNQjBRxgCvs4TnvC3VZgX5R10Ec3aapxHkzvaCjS+dnhIIhh
	2h0YpApYnqogIdTlzpKbPTD9EhfAIlA=
Date: Tue, 15 Jul 2025 16:08:13 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 7/7] hwmon: iio: Add alarm support
To: Guenter Roeck <linux@roeck-us.net>, Jonathan Cameron <jic23@kernel.org>,
 Jean Delvare <jdelvare@suse.com>, linux-iio@vger.kernel.org,
 linux-hwmon@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, linux-kernel@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
 <20250715012023.2050178-8-sean.anderson@linux.dev>
 <759e8070-de3e-41fd-8e81-05e22c32209e@roeck-us.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <759e8070-de3e-41fd-8e81-05e22c32209e@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/15/25 15:34, Guenter Roeck wrote:
> On 7/14/25 18:20, Sean Anderson wrote:
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
> 
> I am very concerned about this. The context suggests that the iio events
> are just that - events without specific association to hardware or system
> limits. Hardware monitoring limits are system specific limits, which are not
> supposed to change at runtime. A high voltage or temperature warning is
> just that - it is not supposed to trigger a change in the event limit.
> If anything, it is supposed to trigger some action to bring the observed
> value back to normal.

If the system integrator has instantiated this driver, then the associated
IIO channels correspond to physical values related to the health of the
system. Other IIO channels should not be attached to the iio-hwmon driver.

For example, in my use case the Xilinx AMS was implemented as an IIO
device because it's a generic ADC, and several of the channels can
monitor arbitrary analog voltages. However, many channels are
permanently connected to the SoC's power rails and to internal
temperature probes. These channels are best exposed as an hwmon device
to take advantage of existing userspace tooling (e.g. lm-sensors).

The above paragraph in the commit message specifically refers to the
approach taken to handle IIO events for a given device. As we process
the hwmon's IIO channels, we create alarm attributes for the
corresponding events. Because we don't know which IIO events we are
interested in when we create the IIO listener, there are two general
approaches:

- We could allocate some memory for the alarm and then add it to a list
  or hash table in the listener. When the listener gets an event it
  would then search the list or hash table for the appropriate alarm.
- We can allocate memory for all possible events up front. When we want
  to create an alarm we look up the appropriate event.

I chose the latter approach because I believe that there are typically
not too many events on a given IIO device (i.e. dozens) and it makes the
lookup simpler, since we can just iterate through an array (or do a
binary search).

> For this series to move forward, there needs to be some guarantee that
> the limits are used and usable only as intended, and can not be used for
> random thresholds. The idea of "if a temperature alarm is triggered, do
> something and change the threshold temperature" is not an acceptable use
> for hardware monitoring alarms.

What userspace sets the limits to or does in response to an alarm is not
the kernel's concern. That said, I suspect the most-likely userspace response
is to log the alarm, possibly to some remote system.

--Sean

