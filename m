Return-Path: <linux-iio+bounces-20823-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FE1AE2ACC
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 19:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97BD57A6092
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 17:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D8A24C068;
	Sat, 21 Jun 2025 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BZXVOmdc";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="GUqLV1hf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99C1246769;
	Sat, 21 Jun 2025 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750526670; cv=none; b=gtGZdSHL9kolGwHGbg4iN1RrRWx5Jtn6KUtyh77CnMw4+vFrjSEPH+PCz6xE01Ul32QAJt0ex4kTEq04hBRhfP3/P1495h1zYoYx4DweXOAR0GmFayrRCkOfuOzbovV/74vdQ4auKdururL7vuRsMLWVZ9mRgXoBCN+DCf5gIuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750526670; c=relaxed/simple;
	bh=/dvkpugllr2kB/Z4YTxbkwU2tzsLEtBNrbNIU9jQNsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n9jfFQxq18Ywc/d4RH5I/wLY7YzcNbq0TsYOk/wghRo2gdAEMaRjvuwxD2IIVbkDj4Y1VSst77iqDbUNGIUC7pbsu2h6NXczosGM+7hvg51abaijaXZY6na1CwLwqrLfqZnNQk35qv/5nN8MfUPMCfTPH2NBc5KtUKeq4T85a0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=BZXVOmdc; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=GUqLV1hf; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bPh6L5kL4z9t7l;
	Sat, 21 Jun 2025 19:24:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750526666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LxQLxg1SC5GL/sLkLv30CRCGpGY4vKeQ9jJV108hObw=;
	b=BZXVOmdcVtRCR1N3rVLRLKtGwYKmVeGBABsQkuybwYaSD+QmJ/20/+EdoaR/HFxy+GJ3lK
	EuEVaSbs544aYJ2QYOJ2jAwvTUuNN0Xfgy6EYcSY5LjqpH+6BRKRs64KOdnSIov/0myZr7
	fjtoph+/Tkhul2sakdhN4UAsuUAM2D7nS+P95AjAF6DdIN3yNeyDB7Ufa5phuCgEyPEnoL
	i8G55tC+PCmZk3ytFEfzAOUJh5NxcIp6SE/4cMRlewf3fHXUJlJGNDMOu+KF5KHflJ+fr+
	IManHCwiPlhyl7/qoiogKjb8fjtyt0LJl95c8XJOyCQDlIMSnXCRcBReb+QBPg==
Message-ID: <07d91b36-dbeb-42b3-8dd7-b0771df9b306@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750526664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LxQLxg1SC5GL/sLkLv30CRCGpGY4vKeQ9jJV108hObw=;
	b=GUqLV1hfZo7rzb3uxA3jnBhUHDmc/9d+PACgXKbd/qmyCj6J10KqHzOak68SpJsFb9Eyz5
	YUWTXiEm/Ipk9ru3hIL1xY6NKFdHf/L54CplFZGP37admrJolmzonFLQZKjMp+U9HRX8Fz
	A1lsavfQIQIJiO1oOIqfqxsQ8iogaOnhQQffzvDj9tBT3a0RKOOQ/JnVV4yHDGhQYSVhhg
	izut2EIkVqovBFCnt7OMGymgJmwI7HEakHpvzwmHMkgd2q3+9o8SXUrlRW8VBLqZGrqYcb
	t1ENPzE4EYJYx4+X4wQclRekGFxCITx6j+NdBScLdJAPFg0PsFnc/wv03ehKdg==
Date: Sat, 21 Jun 2025 19:24:22 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] iio: accel: bmc150: Do not configure IRQ registers if no
 IRQ connected
To: Jonathan Cameron <jic23@kernel.org>, Hans de Goede <hansg@kernel.org>
Cc: Marek Vasut <marek.vasut+bmc150@mailbox.org>, linux-iio@vger.kernel.org,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>, Peter Zijlstra
 <peterz@infradead.org>, Salvatore Bonaccorso <carnil@debian.org>,
 linux-kernel@vger.kernel.org
References: <20250613124648.14141-1-marek.vasut+bmc150@mailbox.org>
 <79946c40-e2ce-4fbc-a6b2-b37f6fd69d1d@kernel.org>
 <20250621181733.3cb6111e@jic23-huawei>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250621181733.3cb6111e@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: f3isaeah9xzascc7uifdkj8gu7qanwcu
X-MBO-RS-ID: 360c4c3517a10077c8a
X-Rspamd-Queue-Id: 4bPh6L5kL4z9t7l

On 6/21/25 7:17 PM, Jonathan Cameron wrote:
> On Mon, 16 Jun 2025 14:42:54 +0200
> Hans de Goede <hansg@kernel.org> wrote:
> 
>> Hi,
>>
>> On 13-Jun-25 14:45, Marek Vasut wrote:
>>> The BMC150 on Onemix 2S does not have IRQ line described in ACPI tables,
>>> which leads to bmc150_accel_core_probe() being called with irq=0, which
>>> leads to bmc150_accel_interrupts_setup() never being called, which leads
>>> to struct bmc150_accel_data *data ->interrupts[i].info being left unset
>>> to NULL. Later, userspace can indirectly trigger bmc150_accel_set_interrupt()
>>> which depends on struct bmc150_accel_data *data ->interrupts[i].info being
>>> non-NULL, and which triggers NULL pointer dereference. This is triggered
>>> e.g. from iio-sensor-proxy.
>>>
>>> Fix this by skipping the IRQ register configuration in case there is no
>>> IRQ connected in hardware, in a manner similar to what the driver did in
>>> the very first commit which added the driver.
>>
>> ...
>>
>>> Fixes: 8e22f477e143 ("iio: bmc150: refactor interrupt enabling")
>>> Signed-off-by: Marek Vasut <marek.vasut+bmc150@mailbox.org>
>>> ---
>>> Cc: "Nuno Sá" <nuno.sa@analog.com>
>>> Cc: Andy Shevchenko <andy@kernel.org>
>>> Cc: David Lechner <dlechner@baylibre.com>
>>> Cc: Jonathan Cameron <jic23@kernel.org>
>>> Cc: Julien Stephan <jstephan@baylibre.com>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Salvatore Bonaccorso <carnil@debian.org>
>>> Cc: linux-iio@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>> ---
>>>   drivers/iio/accel/bmc150-accel-core.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
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
>>
>> I'm not an IIO expert, but IIRC other drivers simply skip registering their triggers
>> when there is no interrupt support.
> 
> Absolutely. It is annoyingly common for devices to have some or none of the interrupt
> lines actually wired so drivers should not present the interfaces if they aren't.
> It is acceptable for a new driver to just fail to probe if handling the device with no
> interrupts is particularly complex but in general at least some functionality tends
> to be easy to implement so we prefer that.
I haven't gotten to this again ... yet ... I can try and add some sort 
of polling fallback maybe ?

