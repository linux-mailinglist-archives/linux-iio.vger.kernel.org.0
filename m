Return-Path: <linux-iio+bounces-21877-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B586EB0DF99
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 16:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495781C81707
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 14:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D839F2EACFE;
	Tue, 22 Jul 2025 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RtutDM9Z";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vb56Rq85"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89FF2ECD16
	for <linux-iio@vger.kernel.org>; Tue, 22 Jul 2025 14:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195733; cv=none; b=i5QCPgP3AdVrJCIFAKHY5F6o6pqxEKFwjh1ioFAy4qIPmOGFeIuyNP/BJtTB4cB23xrrdko+Hr3crvTIzgm/mHwDBTjyCKgm4+7hBA3H0AkP/0WPP2sv60VJYz35kb4U3JAjIbN/kUypm17kjE8YsDvpJ9lAtXrKjXOf9FCuvsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195733; c=relaxed/simple;
	bh=3ASwCYkymg6Z/5bNoQoIxZLkcXfX3OFJR9fmQYcH5dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D62ayMgncjtRMOlN5z4it7tb7G7Sc4miswA+6kiVg8S6j+jD6jIkujpTDNpuuRB5OHT3iHUhrl7UF//rAuQFYo3gnLF5KEEizw1FATnRp6M+WOtF200HSuD6zLo+nFhBx7O2Nbn37XUCRI8zcMhJYP2QYpVF+/CGos4HhVcaJwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=RtutDM9Z; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=vb56Rq85; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bmgBT6sKfz9tsC;
	Tue, 22 Jul 2025 16:48:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1753195730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EqKg3f3ZhjNyx+0T00BZdLGzIFAq+nsOeVdo+tAN/SQ=;
	b=RtutDM9ZTO9W6HyxVDzamOv9WENPf99L8N+XpiyUabWYSf5R+bU6b3pWA1NsqJYpPNIdmW
	QZ0A8E5/Z7wyJQ1YZ6U6YoAUv1AjuFGyru00tkInGe4PHrGhDjLwEB0Qhi3qtIVmzY8mvZ
	hPVZvu7wYhXBVTJorqUK8Xm6kCoEI6uST0tfFmZUhd4W3Ht8D+BcRl5N8XHWuFBgxW8xps
	lTZPjIaG69KCGgoMRb96zNQixfdnRFe4nF/QyDFRowvO565AuTN2HF5mfrJ4R+mPFvFKkh
	o9Ylv6VnhoTFtYwquHvDku5Cq2H96+0Y3801Oh91VGe34ItRlkaQWIgLeACjdg==
Message-ID: <30fb5c19-d4e5-4740-afc4-c15b256a99e0@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1753195727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EqKg3f3ZhjNyx+0T00BZdLGzIFAq+nsOeVdo+tAN/SQ=;
	b=vb56Rq85ZNFhiUenTJJyzbdgUNOu6ox8vHAwu8tR1AQSajb4hatnu1eWDiAFDzGeA+rP2r
	QRgIrMsQ+cVI6KoZIdq6fXG23jhVCGPaGKtC+sG4l71TAkuagbJR0Ie0rcEJ3MMgMmxrgc
	WUjUoYLro7JeSdos3uwm/OKLV4CiVo+6i7nmdaETWF0h54SNGqFwFIIyxWsUDn9imziwkY
	IGWWaAqfTylupivg5t+P0Xb90dQL2GHtvU1fnixw4pAf2sFuHpS/A7MgjgV5lH5vlaQnO2
	UsLYRUdV7LyHmEFIValBEwXE82kfOYAN+TyTMBQf4hulZeQ/8M/rNUraxSulYg==
Date: Tue, 22 Jul 2025 16:48:45 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] iio: accel: bmc150: Do not configure IRQ registers if no
 IRQ connected
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Hans de Goede <hansg@kernel.org>
Cc: Marek Vasut <marek.vasut+bmc150@mailbox.org>, linux-iio@vger.kernel.org,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, Julien Stephan <jstephan@baylibre.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Salvatore Bonaccorso <carnil@debian.org>
References: <20250613124648.14141-1-marek.vasut+bmc150@mailbox.org>
 <79946c40-e2ce-4fbc-a6b2-b37f6fd69d1d@kernel.org>
 <6oyvsvp2erynwu3evulbg6gtdryabeuoo46qzku2grxg3jxptf@jszhnvmj2ffc>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <6oyvsvp2erynwu3evulbg6gtdryabeuoo46qzku2grxg3jxptf@jszhnvmj2ffc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: hzeqbtdoxhz3jh3t4sbm4qjdhdm3dbeo
X-MBO-RS-ID: 0f5a8678f1f89f417f7

On 7/22/25 10:55 AM, Uwe Kleine-König wrote:
> Hello,

Hi,

> On Mon, Jun 16, 2025 at 02:42:54PM +0200, Hans de Goede wrote:
>>> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
>>> index 744a034bb8b5..1c3583ade2b4 100644
>>> --- a/drivers/iio/accel/bmc150-accel-core.c
>>> +++ b/drivers/iio/accel/bmc150-accel-core.c
>>> @@ -550,6 +550,9 @@ static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data, int i,
>>>   	if (ret < 0)
>>>   		return ret;
>>>   
>>> +	if (!info)
>>> +		return 0;
>>> +
>>>   	/* map the interrupt to the appropriate pins */
>>>   	ret = regmap_update_bits(data->regmap, info->map_reg, info->map_bitmask,
>>>   				 (state ? info->map_bitmask : 0));
>>
>> AFAIK the proper fix would be to not register any IIO-triggers. This fix will
>> avoid the problem, but userspace might still try to use non-working triggers
>> which will now silently fail.
> 
> I don't have a system that triggers the problem, but there is
> https://bugs.debian.org/1106411 which I guess is the same problem.

I think the debian person is on CC here already.

> I think the suggestion to not register the triggers in the absence of an
> irq would be implemented by
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index be5fbb0c5d29..8d90802e65fd 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -1687,18 +1687,18 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
>   		fifo_attrs = NULL;
>   	}
>   
> -	ret = iio_triggered_buffer_setup_ext(indio_dev,
> -					     &iio_pollfunc_store_time,
> -					     bmc150_accel_trigger_handler,
> -					     IIO_BUFFER_DIRECTION_IN,
> -					     &bmc150_accel_buffer_ops,
> -					     fifo_attrs);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed: iio triggered buffer setup\n");
> -		goto err_disable_regulators;
> -	}
> -
>   	if (irq > 0) {
> +		ret = iio_triggered_buffer_setup_ext(indio_dev,
> +						     &iio_pollfunc_store_time,
> +						     bmc150_accel_trigger_handler,
> +						     IIO_BUFFER_DIRECTION_IN,
> +						     &bmc150_accel_buffer_ops,
> +						     fifo_attrs);
> +		if (ret < 0) {
> +			dev_err(dev, "Failed: iio triggered buffer setup\n");
> +			goto err_disable_regulators;
> +		}
> +
>   		ret = devm_request_threaded_irq(dev, irq,
>   						bmc150_accel_irq_handler,
>   						bmc150_accel_irq_thread_handler,
> 
> 
> But given that bmc150_accel_write_event_config() also calls
> bmc150_accel_set_interrupt() this might not be a complete fix.
I haven't had time to get back to this, so if you want to take over, I'm 
happy to hand it over.

I'm sorry for the slow response.

