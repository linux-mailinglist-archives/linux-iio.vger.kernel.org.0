Return-Path: <linux-iio+bounces-20704-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCA1ADADF7
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 13:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BDBD3A529A
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 11:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E2529B8D9;
	Mon, 16 Jun 2025 11:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="T7zp98lz";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EqbDo9Jb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199BF298998;
	Mon, 16 Jun 2025 11:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750071808; cv=none; b=TwECSr+1YUASKu+FnOPEAKBZb9HlBX5nmkXmJZjMOUAFL5fWHpN/Z1W8kE5MMc0g3hODJrjlHwDCGLfjVi5X9kXLWIswI9XpiWrHwi1g+Ywocr4VyoXXhKYtOgurdTGhHQS9bXXNRhi4wsm4LTU+9cKQnrzgHe67dxEyz0rBwmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750071808; c=relaxed/simple;
	bh=Q2nz0LgS7aKDrvHOh/ID/OK4/kAnT426iqByTBIMF7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H8R19VlJairMG6/1BfIielssWcJgo7QqiEe37xCoYikw1U+ypKbtkbKwmMcWS6movQqOpckmSx4z6afaONHPt7TCNtAJIOodUKrlXYv+zlCwPCSoBJI54wHzDEjQODu2ieEsHbyzMrJ+jjFiGypHErVvdbRMIie6ss11T7ZG36M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=T7zp98lz; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=EqbDo9Jb; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bLRv11NgFz9tGT;
	Mon, 16 Jun 2025 13:03:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750071805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GCkIT9Bmo2LyS7jzFRkKLIYyEqPPLaYeVM6P5aSr1IA=;
	b=T7zp98lznQIYSFT62HieidYZqCJLtIk80oVAGBB5vYnoUuYQx2pXjRH7YE6M2MgFQm/A5z
	vI+vRhySCbd4rwsxYOBkB67A0tVXV2FQ8FuotHBM379ESLxMzw4h2zpnu8Qtp4AaWu+zxL
	F4r4wocxYw39jXUNiHY1P3dRSMvxDjA929Fz0fiDhdOEIhrsPvzXekRYRlDWf0Kn2NJrIQ
	6LlCLEYEvA0dB4OLFx7AB96spl7Z5ro4r2qCYq76lVdyu0Sr6tFuAUXKNpVegYWKVzPxPI
	u8t9QTlI1F1HaHokMt8Y6EYT+Xstvf2S1IFADi9Q3YmVqkFLFaQJT2LE6iNgmg==
Message-ID: <db14331e-193a-4915-990e-7657b5ca0c5b@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750071803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GCkIT9Bmo2LyS7jzFRkKLIYyEqPPLaYeVM6P5aSr1IA=;
	b=EqbDo9JbtidayMwEz56W5wvKzvXhQdAQticLQV1x8iqmn9XyjsL6GmGpwL0O1/kmAT+YiG
	62AyP1/hrgtZRJu4KTlCBoswjsHqBF8hEyuTgL7X6Y2ZdULZG0zREhQSzqwIBkIH+hRz/g
	NIV1Zqjl74Gm+FYDX+0NiuieXsVqKUuknqqpuOYPAmNAC3OKZ7kjHusXT2fgdZbvnNcdI0
	D98eROJAomMUTguDIf9gq0VFzVRV2/YfCYHyWxF2sYkljJxdXki8HcsAD4MN+dVkJ4YeRM
	XgbCvIHNpF+rXcmZBe7bZN43cHKH66feeqITPSVPFdasal/PQ2ceFxwBFR7SiQ==
Date: Mon, 16 Jun 2025 13:03:20 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] iio: accel: bmc150: Do not configure IRQ registers if no
 IRQ connected
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Marek Vasut <marek.vasut+bmc150@mailbox.org>,
 Hans de Goede <hansg@kernel.org>, linux-iio@vger.kernel.org,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, Julien Stephan <jstephan@baylibre.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Salvatore Bonaccorso <carnil@debian.org>, linux-kernel@vger.kernel.org
References: <20250613124648.14141-1-marek.vasut+bmc150@mailbox.org>
 <aEw_DcqpCpcsBGd0@smile.fi.intel.com>
 <8605141c-b615-4e84-9574-81e24590df48@mailbox.org>
 <aE_aL5dGKZeKBu50@smile.fi.intel.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aE_aL5dGKZeKBu50@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: g1x4qyqwgt4bzrtwse6e68z7ewxubgnr
X-MBO-RS-ID: 54396ab99c5020fce69
X-Rspamd-Queue-Id: 4bLRv11NgFz9tGT

On 6/16/25 10:47 AM, Andy Shevchenko wrote:
> On Fri, Jun 13, 2025 at 07:02:28PM +0200, Marek Vasut wrote:
>> On 6/13/25 5:09 PM, Andy Shevchenko wrote:
>>> On Fri, Jun 13, 2025 at 02:45:22PM +0200, Marek Vasut wrote:
> 
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
>>>>
>>>> ACPI table dump:
>>>
>>>>           Device (BMA2)
>>>>           {
>>>>               Name (_ADR, Zero)  // _ADR: Address
>>>>               Name (_HID, "BOSC0200")  // _HID: Hardware ID
>>>>               Name (_CID, "BOSC0200")  // _CID: Compatible ID
>>>>               Name (_DDN, "Accelerometer")  // _DDN: DOS Device Name
>>>>               Name (_UID, One)  // _UID: Unique ID
>>>>               Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>>>>               {
>>>>                   Name (RBUF, ResourceTemplate ()
>>>>                   {
>>>>                       I2cSerialBusV2 (0x0019, ControllerInitiated, 0x00061A80,
>>>>                           AddressingMode7Bit, "\\_SB.PCI0.I2C0",
>>>>                           0x00, ResourceConsumer, , Exclusive,
>>>>                           )
>>>>                   })
>>>>                   Return (RBUF) /* \_SB_.PCI0.I2C0.BMA2._CRS.RBUF */
>>>>               }
> 
>>>>           }
> 
> ...
> 
>>> As for the solution, are you sure the line is not wired at all?
>>
>> No . It is some cheap mini-laptop , I have no schematics or any other info
>> really .
> 
>> Note that I am not really familiar with x86 and ACPI, so there is that.
> 
> Yes, I understand that.
> 
> You can try to monitor the /sys/kernel/debug/pinctrl/*/pins files for any
> changes that might happen on the sensor events. It might (help to) reveal
> the IRQ line.
Sooo ... if the IRQ line is not described in ACPI, it could still be 
connected ? Hum, I'll try to shake the laptop next time I power it up.

