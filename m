Return-Path: <linux-iio+bounces-21692-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DCFB0638F
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 17:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF5C41AA3696
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 15:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D93524677B;
	Tue, 15 Jul 2025 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n9xok8/7"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0605A1F30CC
	for <linux-iio@vger.kernel.org>; Tue, 15 Jul 2025 15:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594927; cv=none; b=ruTOpwIYqFaAA1CQSvEn6ktSM4cbk0e55jL4O9tW4+OGUHMafMRnla1KQlXuI254BAOfBHAArCmJcJ6F/cNOzahwdOOvXO3AvbSjS3No4ObyDq+wdKOG8SMBv2Mr9QLi4SdLXVuEKIqB+ndRFo4MWGA+vqMCrESmAkr2iIuadOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594927; c=relaxed/simple;
	bh=s18xb8DQGCbajb+5p3Kxf67e/xbfuvlEuY28MZpByFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l3ZKITP1kQMTsiK3+gd6MypOrpy2eqL4F8cdsVoCU+fg/qm3uRTBzbi03Ip36xUauDihrYn2U4Dln2wCAGU7NIJFHiHZJOsDdO7nX0dq/GwD/meZ+GAX/GG12OIs/biaJODnr6nrO54yWVaHpU7mfv6rHbkPE7dCL2sdq4o9TT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n9xok8/7; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b72d009a-9d7d-42cd-af2e-80584bba788d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752594912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7GFZev2aQajHr2SbEEhI2ptvWhufMKyrQIwoam3qrpo=;
	b=n9xok8/71t3B2Pwx6bL6+uLvBHixfQXmdSH4hJIo3cKD5GrVy+KzMD3xyLH32V6zErHX08
	CxdmWjjXJ9cTC70TGBDPSQt5NnoNu6IIP0vLLqXklU1tJsXm/lVf8J6lZFLhVmpcmlsnb5
	ihnwn0+qmf3L+rptnLN5b2N95nAbrAg=
Date: Tue, 15 Jul 2025 11:55:08 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 5/7] hwmon: iio: Add helper function for creating
 attributes
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-kernel@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
 <20250715012023.2050178-6-sean.anderson@linux.dev>
 <aHYTcAO7sHsyevDH@smile.fi.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <aHYTcAO7sHsyevDH@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/15/25 04:38, Andy Shevchenko wrote:
> On Mon, Jul 14, 2025 at 09:20:21PM -0400, Sean Anderson wrote:
>> Add a helper function to create attributes and initialize their fields.
>> This reduces repetition when creating several attributes per channel.
> 
> ...
> 
>> + * @num_attrs:          length of @attrs
> 
> Other lines use TABs.
> 
> ...

OK

>> +static int add_device_attr(struct device *dev, struct iio_hwmon_state *st,
> 
> This should hint that this is managed:
> 
> add_device_managed_attr()

That just makes it more difficult to format the calling code within 80 columns...

> 
>> +			   ssize_t (*show)(struct device *dev,
>> +					   struct device_attribute *attr,
>> +					   char *buf),
>> +			   int i, const char *fmt, ...)
> 
> __printf() attribute is missing.

It's static, so I thought the compiler could infer it but I guess not.

>> +{
>> +	struct sensor_device_attribute *a;
>> +	va_list ap;
>> +
>> +	a = devm_kzalloc(dev, sizeof(*a), GFP_KERNEL);
>> +	if (!a)
>> +		return -ENOMEM;
>> +
>> +	sysfs_attr_init(&a->dev_attr.attr);
>> +	va_start(ap, fmt);
>> +	a->dev_attr.attr.name = devm_kvasprintf(dev, GFP_KERNEL, fmt, ap);
>> +	va_end(ap);
>> +	if (!a->dev_attr.attr.name)
>> +		return -ENOMEM;
>> +
>> +	a->dev_attr.show = show;
>> +	a->dev_attr.attr.mode = 0444;
>> +	a->index = i;
>> +
>> +	st->attrs[st->num_attrs++] = &a->dev_attr.attr;
>> +	return 0;
>> +}
> 
> ...
> 
>>  	struct device *dev = &pdev->dev;
>>  	struct iio_hwmon_state *st;
>> -	struct sensor_device_attribute *a;
>> -	int ret, i, attr = 0;
>> +	int ret, i;
> 
> Also move it a bit to make it more of a reversed xmas tree ordering?

It's not ordered as-is, and I don't think this subsystem requires it.

>>  	int in_i = 1, temp_i = 1, curr_i = 1, humidity_i = 1, power_i = 1;
>>  	enum iio_chan_type type;
>>  	struct iio_channel *channels;
> 

--Sean

