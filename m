Return-Path: <linux-iio+bounces-21693-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21ADDB063E5
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 18:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC3F1885E3F
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 16:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681132459E5;
	Tue, 15 Jul 2025 16:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rc627kVf"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752CE1E5B7B
	for <linux-iio@vger.kernel.org>; Tue, 15 Jul 2025 16:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752595536; cv=none; b=WZp7sWQLQLYVAEzLNLNwaLrPdKTCFJ3sc54Lcwh0LOoDEGPOW+1UfJJC+hvlh/Yr/vbIGk1hFLVU74NFced+cDYNpo7Kmg2ruGCVmed5J02TYssCmq3dBUfKuqblf2ioH1nm+eZijJHs01W5quKDAKR1EVrRBJszUUuIhtjdPaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752595536; c=relaxed/simple;
	bh=elWPERJBP7Dd0ZYWPeNsuYcRk6fN+jzg/1I1N4YhEwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gQS7bgglbctA113cgDgZdf6uoMXvOCq/dgeCWg4Wr2nR6qy6PdQIqlbwfcMr1BglJ/b1cEfP/Yhrp1OCn5E/IoDPx+Ji4gy+P2GkYECMkr9WhE+pGl24/E9Y6fa6OWhtQSCz9vw7bszCcO2zr5w/MFiwRChRpNfyFxSJc5PcEhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rc627kVf; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <05fbc6c9-0b6a-42bd-8940-242c80a79b7f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752595522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C+/yErmoTaVejIXZ1BXsmn+Nk/38zoOjGEq2ycIUpeo=;
	b=rc627kVfNITbROKT8QDNmkAcTugwYaNglCjmJnbz6cnxMm69Wi2nr1zeqOkyfF8rS5sxUE
	dCvtuYRczkSDEfegBzsbQCBgiX5Ekn1V41exOsUFNeM6KqbmvbcNvaNFlAJAgIbgN3Ky0b
	ln/YpQTxEVY7z0LLvmX5F2vf66GVeGg=
Date: Tue, 15 Jul 2025 12:05:15 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6/7] hwmon: iio: Add min/max support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-kernel@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
 <20250715012023.2050178-7-sean.anderson@linux.dev>
 <aHYUOs25SrUb4BtD@smile.fi.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <aHYUOs25SrUb4BtD@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/15/25 04:41, Andy Shevchenko wrote:
> On Mon, Jul 14, 2025 at 09:20:22PM -0400, Sean Anderson wrote:
>> Add support for minimum/maximum attributes. Like the _input attribute,
>> we just need to call into the IIO API.
> 
> ...
> 
>> +static ssize_t iio_hwmon_read_event(struct device *dev,
>> +				    struct device_attribute *attr,
>> +				    char *buf)
>> +{
>> +	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
>> +	struct iio_hwmon_state *state = dev_get_drvdata(dev);
>> +	struct iio_channel *chan = &state->channels[sattr->index];
>> +	int ret, result, scale;
>> +
>> +	scale = iio_hwmon_scale(chan);
> 
>> +	if (scale < 0)
> 
> This part is definitely missed in the respective description.

OK

>> +		return scale;
>> +
>> +	ret = iio_read_event_processed_scale(chan, IIO_EV_TYPE_THRESH,
>> +					     sattr->nr, IIO_EV_INFO_VALUE,
>> +					     &result, scale);
>> +	if (ret < 0)
> 
> Why ' < 0' here?

This originally returned IIO_VAL_INT on success.

>> +		return ret;
>> +
>> +	return sprintf(buf, "%d\n", result);
> 
> Mustn't be sysfs_emit() ?

It doesn't matter in this case (as %d can never emit more
than 20ish characters), but that works too.

>> +}
> 
> ...
> 
>> +	ret = iio_write_event_processed_scale(chan, IIO_EV_TYPE_THRESH,
>> +					      sattr->nr, IIO_EV_INFO_VALUE,
>> +					      val, scale);
>> +	if (ret < 0)
> 
> < 0 ?
> 
>> +		return ret;
> 
> ...
> 
>> +static int add_event_attr(struct device *dev, struct iio_hwmon_state *st,
>> +			  int i, enum iio_event_direction dir,
>> +			  const char *fmt, ...)
> 
> Same comments as per previous patch adding another attribute API.
> 
> ...
> 
>> +	va_start(ap, fmt);
>> +	a->dev_attr.attr.name = devm_kvasprintf(dev, GFP_KERNEL, fmt, ap);
>> +	va_end(ap);
> 
> Can't %pV be used?

%pV is for when we have additional info to add. e.g. if we were doing

devm_kasprintf(dev, GFP_KERNEL, "my_extra_info_%d_%pV", i, &vaf);

but we aren't so there's no point adding a level of indirection.

--Sean

