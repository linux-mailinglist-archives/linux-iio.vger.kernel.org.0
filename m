Return-Path: <linux-iio+bounces-6992-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C3291AF28
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2024 20:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BCB028771F
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2024 18:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4192019AA7D;
	Thu, 27 Jun 2024 18:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W1534gzr"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ED5195B18
	for <linux-iio@vger.kernel.org>; Thu, 27 Jun 2024 18:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719513435; cv=none; b=XTF/cu61XBNr9rldRsayIYvVbjhJyauzkvAe1GVEBPYMjBhOSWuOzN9Y4k+jlzsYNKwuAwwl8UIxZXb2Rnv5HQSGZC/jJlPEgx7j5Sj6Nk3+skRy/PtyMvnTgywhA6zs20aAq+9i6h0+OoJsRwF+AtLIB4mMIKuClPEACPgkf6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719513435; c=relaxed/simple;
	bh=kMf/jTaHv8Pibllz765oLhr56R7Vnv74xKa/hCJTaII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TVlnVEDIsX/1frlcMFjixmsvEyccvSxq2l+8k4YdcHksgj1ULhKDGL3FmfpFXyzIpXxlPHSwsOi4wISH+B5pY++X6KKAH0cjIGBGkX/AVvfY7XpRRsSpY1LMkWRgeLaDoZWqg493KaZPKvCu9yJ8eWLNd3vWlbmAh57jTT6pgH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W1534gzr; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: jic23@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719513429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LcX+DNUAOkuuXE8/JmszLDMKosfH1JHvU1xDYWp+oWM=;
	b=W1534gzrjEl4P8g5y/J0X5tfxFPrE1J+gIoykAKtFAUDacat2D3PUXImDN83E0bM/P+BpT
	K7ISNAsIhoBPqPifciJwK9EXKDrrvbGq+eKB6x1s5dPhSqU39VJu3aKZ/qnhjExFyVhT6C
	SSZPLqZK48b82/3359XmIQkrvpwND4Y=
X-Envelope-To: linux@roeck-us.net
X-Envelope-To: jdelvare@suse.com
X-Envelope-To: linux-iio@vger.kernel.org
X-Envelope-To: linux-hwmon@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: lars@metafoo.de
Message-ID: <f6ee3049-47a0-4c84-ab90-2321bf6970d0@linux.dev>
Date: Thu, 27 Jun 2024 14:37:01 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] hwmon: iio: Add labels from IIO channels
To: Jonathan Cameron <jic23@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-iio@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>
References: <20240624174601.1527244-1-sean.anderson@linux.dev>
 <20240624174601.1527244-3-sean.anderson@linux.dev>
 <ff43e01e-5a26-4b75-bfaa-ed3ad4395e7c@roeck-us.net>
 <20240624202433.29564802@jic23-huawei>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240624202433.29564802@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/24/24 15:24, Jonathan Cameron wrote:
> On Mon, 24 Jun 2024 11:47:39 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> On 6/24/24 10:46, Sean Anderson wrote:
>> > Add labels from IIO channels to our channels. This allows userspace to
>> > display more meaningful names instead of "in0" or "temp5".
>> > 
>> > Although lm-sensors gracefully handles errors when reading channel
>> > labels, the ABI says the label attribute
>> >   
>> >> Should only be created if the driver has hints about what this voltage
>> >> channel is being used for, and user-space doesn't.  
>> > 
>> > Therefore, we test to see if the channel has a label before
>> > creating the attribute.
>> >   
>> 
>> FWIW, complaining about an ABI really does not belong into a commit
>> message. Maybe you and lm-sensors don't care about error returns when
>> reading a label, but there are other userspace applications which may
>> expect drivers to follow the ABI. Last time I checked, the basic rule
>> was still "Don't break userspace", and that doesn't mean "it's ok to
>> violate / break an ABI as long as no one notices".
>> 
>> > Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> > ---
>> > 
>> > Changes in v2:
>> > - Check if the label exists before creating the attribute
>> > 
>> >   drivers/hwmon/iio_hwmon.c | 45 ++++++++++++++++++++++++++++++++++-----
>> >   1 file changed, 40 insertions(+), 5 deletions(-)
>> > 
>> > diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
>> > index 4c8a80847891..5722cb9d81f9 100644
>> > --- a/drivers/hwmon/iio_hwmon.c
>> > +++ b/drivers/hwmon/iio_hwmon.c
>> > @@ -33,6 +33,17 @@ struct iio_hwmon_state {
>> >   	struct attribute **attrs;
>> >   };
>> >   
>> > +static ssize_t iio_hwmon_read_label(struct device *dev,
>> > +				  struct device_attribute *attr,
>> > +				  char *buf)
>> > +{
>> > +	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
>> > +	struct iio_hwmon_state *state = dev_get_drvdata(dev);
>> > +	struct iio_channel *chan = &state->channels[sattr->index];
>> > +
>> > +	return iio_read_channel_label(chan, buf);
>> > +}
>> > +  
>> 
>> I personally find it a bit kludgy that an in-kernel API would do a
>> sysfs write like this and expect a page-aligned buffer as parameter,
>> but since Jonathan is fine with it:
> 
> That's a good point that I'd not picked up on and it probably makes sense
> to address that before it bites us on some other subsystem.
> 
> It was more reasonable when the only path was to a light wrapper that went
> directly around the sysfs callback. Now we are wrapping these up for more
> general use we should avoid that restriction.
> 
> Two approaches to that occur to me.
> 1) Fix up read_label() everywhere to not use sysfs_emit and take a size
>    of the buffer to print into. There are only 11 implementations so
>    far so this should be straight forward.

This API is the same as the existing iio_read_channel_ext_info. It is
used for the same purpose: forwarding sysfs reads/writes from one
device to another (see e.g. iio-mux and iio-rescale). ext_info is used
by around 85 drivers, so it is not so trivial to change the API. While I
agree that the current API is unusual, it's not too bad given that we
get the same guarantees from device_attribute.show.

--Sean

> 2) Add a bounce buffer so we emit into a suitable size for sysfs_emit()
>   then reprint from there into a buffer provided via this interface with
>   the appropriate size provided.  This one is clunky and given the relatively
>   few call sits I think fixing it via option 1 is the better route forwards.


