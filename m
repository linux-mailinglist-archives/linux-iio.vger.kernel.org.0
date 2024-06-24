Return-Path: <linux-iio+bounces-6840-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AD991573E
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 21:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AB34280A67
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 19:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF38F1A01D0;
	Mon, 24 Jun 2024 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xgH3D7Fr"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019A11A01B7
	for <linux-iio@vger.kernel.org>; Mon, 24 Jun 2024 19:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719257694; cv=none; b=D7W1g+DBO2l7MfLx5j/e09bRwWlrivlQVrmlMFZDB5sBpXWSLgltl25pMGV3Gtg8PXTN2gcwE4ncMcH265MTnJKVp8OwPrNH3h2scUi/jRpNuTdkvfEbjBE1g9ylXO+RbfQPiRrSn9SN4SoDfDqEiYoOKQsxWhp+mU1TLYy2acs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719257694; c=relaxed/simple;
	bh=QTn1WRuA4hsCw/k8adDN6Jh64KjHr3yyO5fpW6vGjHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=htgYewvVWbSyk1n/Won8Xp+LgZYl4o6VUdgc3EmT1noI/7jIam/jhUHvBnPfiTxVy3KPMOc1bxADvqqNrmzpW9G2CJJ8Z+5kcbyA/v6yDe98FkwVTjInvjkQdBbwQJ/fWKr5sxKa5iO8GaAnZ+T6AWUZwTPm5MyUV4t2z9i5uxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xgH3D7Fr; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux@roeck-us.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719257691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Gm2PDGMMowWzUmm56U0hh5D/fJqNhmzLuHu2GZApjI=;
	b=xgH3D7FrktYrIkdGVYTAYPboDDd8QmQu52MF5MVVEc7wPvjFMAsusnlG26IB6k9NmqGUgq
	D2K8edbAy8hKIczFb1hPujNTQaaBenZuoE3drW9gaweZyP0nsWo7cIn8hFYFc+3kHgirnm
	/77XfMiFjxeIUOykPJK6lFBo1MoIjDQ=
X-Envelope-To: jic23@kernel.org
X-Envelope-To: jdelvare@suse.com
X-Envelope-To: linux-iio@vger.kernel.org
X-Envelope-To: linux-hwmon@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: lars@metafoo.de
Message-ID: <63046df2-e1fb-442b-a55f-2a9847c6c59e@linux.dev>
Date: Mon, 24 Jun 2024 15:34:46 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] hwmon: iio: Add labels from IIO channels
To: Guenter Roeck <linux@roeck-us.net>, Jonathan Cameron <jic23@kernel.org>,
 Jean Delvare <jdelvare@suse.com>, linux-iio@vger.kernel.org,
 linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
References: <20240624174601.1527244-1-sean.anderson@linux.dev>
 <20240624174601.1527244-3-sean.anderson@linux.dev>
 <ff43e01e-5a26-4b75-bfaa-ed3ad4395e7c@roeck-us.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <ff43e01e-5a26-4b75-bfaa-ed3ad4395e7c@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/24/24 14:47, Guenter Roeck wrote:
> On 6/24/24 10:46, Sean Anderson wrote:
>> Add labels from IIO channels to our channels. This allows userspace to
>> display more meaningful names instead of "in0" or "temp5".
>>
>> Although lm-sensors gracefully handles errors when reading channel
>> labels, the ABI says the label attribute
>>
>>> Should only be created if the driver has hints about what this voltage
>>> channel is being used for, and user-space doesn't.
>>
>> Therefore, we test to see if the channel has a label before
>> creating the attribute.
>>
> 
> FWIW, complaining about an ABI really does not belong into a commit
> message. Maybe you and lm-sensors don't care about error returns when
> reading a label, but there are other userspace applications which may
> expect drivers to follow the ABI. Last time I checked, the basic rule
> was still "Don't break userspace", and that doesn't mean "it's ok to
> violate / break an ABI as long as no one notices".

This isn't complaining about the ABI, just documenting the reason it was
done this way...

>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>>
>> Changes in v2:
>> - Check if the label exists before creating the attribute
>>
>>   drivers/hwmon/iio_hwmon.c | 45 ++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 40 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
>> index 4c8a80847891..5722cb9d81f9 100644
>> --- a/drivers/hwmon/iio_hwmon.c
>> +++ b/drivers/hwmon/iio_hwmon.c
>> @@ -33,6 +33,17 @@ struct iio_hwmon_state {
>>       struct attribute **attrs;
>>   };
>>   +static ssize_t iio_hwmon_read_label(struct device *dev,
>> +                  struct device_attribute *attr,
>> +                  char *buf)
>> +{
>> +    struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
>> +    struct iio_hwmon_state *state = dev_get_drvdata(dev);
>> +    struct iio_channel *chan = &state->channels[sattr->index];
>> +
>> +    return iio_read_channel_label(chan, buf);
>> +}
>> +
> 
> I personally find it a bit kludgy that an in-kernel API would do a
> sysfs write like this and expect a page-aligned buffer as parameter,
> but since Jonathan is fine with it:

This is also how the in-kernel iio_read_channel_ext_info API works.
I agree that it is a strange API, but I do not want to rewrite all
the implementing drivers.

--Sean

> Acked-by: Guenter Roeck <linux@roeck-us.net>
> 
> Jonathan, please apply through your tree.
> 
> Thanks,
> Guenter
> 


