Return-Path: <linux-iio+bounces-20837-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE29AE2C28
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 22:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326E818957A7
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 20:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90977267B00;
	Sat, 21 Jun 2025 20:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zh5mjLSA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427EF254B1B;
	Sat, 21 Jun 2025 20:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750536883; cv=none; b=fzh79smARhTClwI7CqKQoMR3RXNMikQjxg29vnRcBT9yj9ZZUEy/gndLNuBKJVRq6escFw3Ii0E5MXUwkr7OGUXH+02JUDGX9yB8BCy1FRZNPRCnOFUhs7boNlVK6z2clQmc4OVcfvluZh/ZVejrGkdyDRfR0DL2DQhqRgdrg2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750536883; c=relaxed/simple;
	bh=zZzvv7syD7RJHM6RRPrJTTpfCXEIXDOxqqgFV+x/N0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JnP3bwPLH8ExTnhP1DiDTMEStjMJ0hMIh6K6lieOGSbk7R2h2ix9XkCMKJ4XVEb8Zs6jZDIrGmyhu+NUeFrjxC6/wF1uM1fmAkllYeQs9vFJiC7+k/HJ+Q6Z0Bx4bXF7cnK8rxcWGhY6TU3zwWRSPkM6fG8PZHHhBgfgjsfbABk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zh5mjLSA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E314C4CEE7;
	Sat, 21 Jun 2025 20:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750536881;
	bh=zZzvv7syD7RJHM6RRPrJTTpfCXEIXDOxqqgFV+x/N0A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zh5mjLSAWCcoW06+um80+Gp9E62vt5YLpPKiE3xuZe1dcHQn9TfQrTt3GkaYlLbro
	 tA8b5OHhkXlwEypJ/GgYrjyVcP97AbOtv0Qd9+fxHoyswb3uLhuas2/wHDFzm6YN+/
	 Mm9F0ZlmgTreFQPco5iJPhCVMQsjYdFTRkv8oBeK+HTISd11d2fFfQfyGIwwrGBBXm
	 w/rfrgAlFxBzNgN3hYTW6YqtbGlH2LqiOFdUNuYk9WptSsXUkfAZlavzCJGkXSQC7W
	 0Hqnhhe1vKNpKxodcKtlPICPUnneiwkOfOpQYFFH4SNe0QkA+qCkBPCqcndTChXFP4
	 gdwYqnNa4qZgQ==
Message-ID: <c42243fd-ffd2-4144-875e-b156133eb031@kernel.org>
Date: Sat, 21 Jun 2025 22:14:37 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: accel: bmc150: Do not configure IRQ registers if no
 IRQ connected
To: Marek Vasut <marek.vasut@mailbox.org>, Jonathan Cameron <jic23@kernel.org>
Cc: Marek Vasut <marek.vasut+bmc150@mailbox.org>, linux-iio@vger.kernel.org,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>, Peter Zijlstra
 <peterz@infradead.org>, Salvatore Bonaccorso <carnil@debian.org>,
 linux-kernel@vger.kernel.org
References: <20250613124648.14141-1-marek.vasut+bmc150@mailbox.org>
 <79946c40-e2ce-4fbc-a6b2-b37f6fd69d1d@kernel.org>
 <20250621181733.3cb6111e@jic23-huawei>
 <07d91b36-dbeb-42b3-8dd7-b0771df9b306@mailbox.org>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <07d91b36-dbeb-42b3-8dd7-b0771df9b306@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Marek,

On 21-Jun-25 7:24 PM, Marek Vasut wrote:
> On 6/21/25 7:17 PM, Jonathan Cameron wrote:
>> On Mon, 16 Jun 2025 14:42:54 +0200
>> Hans de Goede <hansg@kernel.org> wrote:
>>
>>> Hi,
>>>
>>> On 13-Jun-25 14:45, Marek Vasut wrote:
>>>> The BMC150 on Onemix 2S does not have IRQ line described in ACPI tables,
>>>> which leads to bmc150_accel_core_probe() being called with irq=0, which
>>>> leads to bmc150_accel_interrupts_setup() never being called, which leads
>>>> to struct bmc150_accel_data *data ->interrupts[i].info being left unset
>>>> to NULL. Later, userspace can indirectly trigger bmc150_accel_set_interrupt()
>>>> which depends on struct bmc150_accel_data *data ->interrupts[i].info being
>>>> non-NULL, and which triggers NULL pointer dereference. This is triggered
>>>> e.g. from iio-sensor-proxy.
>>>>
>>>> Fix this by skipping the IRQ register configuration in case there is no
>>>> IRQ connected in hardware, in a manner similar to what the driver did in
>>>> the very first commit which added the driver.
>>>
>>> ...
>>>
>>>> Fixes: 8e22f477e143 ("iio: bmc150: refactor interrupt enabling")
>>>> Signed-off-by: Marek Vasut <marek.vasut+bmc150@mailbox.org>
>>>> ---
>>>> Cc: "Nuno Sá" <nuno.sa@analog.com>
>>>> Cc: Andy Shevchenko <andy@kernel.org>
>>>> Cc: David Lechner <dlechner@baylibre.com>
>>>> Cc: Jonathan Cameron <jic23@kernel.org>
>>>> Cc: Julien Stephan <jstephan@baylibre.com>
>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>> Cc: Salvatore Bonaccorso <carnil@debian.org>
>>>> Cc: linux-iio@vger.kernel.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> ---
>>>>   drivers/iio/accel/bmc150-accel-core.c | 3 +++
>>>>   1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
>>>> index 744a034bb8b5..1c3583ade2b4 100644
>>>> --- a/drivers/iio/accel/bmc150-accel-core.c
>>>> +++ b/drivers/iio/accel/bmc150-accel-core.c
>>>> @@ -550,6 +550,9 @@ static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data, int i,
>>>>       if (ret < 0)
>>>>           return ret;
>>>>   +    if (!info)
>>>> +        return 0;
>>>> +
>>>>       /* map the interrupt to the appropriate pins */
>>>>       ret = regmap_update_bits(data->regmap, info->map_reg, info->map_bitmask,
>>>>                    (state ? info->map_bitmask : 0));
>>>
>>> AFAIK the proper fix would be to not register any IIO-triggers. This fix will
>>> avoid the problem, but userspace might still try to use non-working triggers
>>> which will now silently fail.
>>>
>>> I'm not an IIO expert, but IIRC other drivers simply skip registering their triggers
>>> when there is no interrupt support.
>>
>> Absolutely. It is annoyingly common for devices to have some or none of the interrupt
>> lines actually wired so drivers should not present the interfaces if they aren't.
>> It is acceptable for a new driver to just fail to probe if handling the device with no
>> interrupts is particularly complex but in general at least some functionality tends
>> to be easy to implement so we prefer that.
> I haven't gotten to this again ... yet ... I can try and add some sort of polling fallback maybe ?

IIO has separate interfaces for exporting channels which can be polled by
userspace and for triggers which is a more event driven interface.

It should be possible to modify the driver to skip the trigger registration,
while keeping the channels. E.g. iio-sensor-proxy will then automaticallt
switch to polling in userspace.

Regards,

Hans




