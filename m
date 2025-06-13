Return-Path: <linux-iio+bounces-20612-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3115AD9363
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 19:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9FC16ED00
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 17:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705FC215179;
	Fri, 13 Jun 2025 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="J6jcsvJ+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bB+rfBnS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0952E11B3;
	Fri, 13 Jun 2025 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749834163; cv=none; b=tdkgZOoCl5Cl2jfozly7snOOpDRZG97dWK2F3GjFPG2M6eTWULVV6l99nlFKuGTqjRsYc+TkKkXNLQbnO1Wpo70FCYXF8/pg99rF0kMKrcNCXfPsXosrzN5MJ470Wv0MK94vgV//mRl093ocZlVPgA0FjdrUJMDaiPpxnkn4vrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749834163; c=relaxed/simple;
	bh=pQzWwNs1c1jnqfC8/YmCsQhipvx2mAuPU3qM0U9TB/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pXaKk9kZOveWspregyWxyLBfjorW2gERkc6vDLU5Gg/C5/3wQZiyHT+6rHmUhEirnwOLGE46JwF/tSCMVQab6nqA8TggrpfFn/ZuCvTTeaDVv2P3iDNV96d8YMmSFoWf90gXT3ZMdWa8OXSND3bUzAi66JFDzHFmjThXgdUqmUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=J6jcsvJ+; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=bB+rfBnS; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bJm0n1mzDz9t9X;
	Fri, 13 Jun 2025 19:02:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1749834153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fgy4RPImZQ6te0w0AD2byb84u39inJxHlG6DKwtCVbE=;
	b=J6jcsvJ+3VTTQWzi3RGjS+qno7Hkm57HIIa+gOmEl5kILqr8xh5Lgt1S3Pl016EED5Ybh9
	YPfJIiUhfccamBWFCAs5xK34p90cPauRZHHR8CUNAlLlJY6EKUBGWh7g9dQRGQlm6uWQYR
	Mko+gyVPbWA7Wbp4apF/PV6K8Vy3G5CcKO/3AbbPfPXjvcthoL9V7/qZseSTMaaWqIKmWT
	PblSH5iJ1a14UE1ALRcBG7xM7w8jf2/WubAlQdyQYLsvLbL7O2QWi4DaUFaiawNtZVz/ch
	oJjEScNtgL2CXN11not50dqjPjTXrouAxtn4HjFOC+WitjtBhvUr+l9GsY2gmw==
Message-ID: <8605141c-b615-4e84-9574-81e24590df48@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1749834151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fgy4RPImZQ6te0w0AD2byb84u39inJxHlG6DKwtCVbE=;
	b=bB+rfBnSKNSslyEXRXA0cFPfuj+d1ZmwxNgUxxx6oVuCc5vWrVtrYmRtTHak1JdVMFTllq
	kHgGEJRuf/JjfmjsQ19M9ONgDDYP8KcOxzlK2l6Z1gHb183yMplrnCmMV/Hv/jGO3SLPy2
	6c7uhZS7/uX5hhnQwDxmHKzRsjj55yN8XbDAqIvJTpOKT3cLVqdY3xOU5EJeDAHZ92Ovdx
	47WgVr4IQoj7BRK6oG3AcOsYRKEeK762dH81NXnIRJYclgvwpc1VMcm2JfVg+LPNbWQJKS
	hx4wmwQwiC1GanzPex3+p91n3/QJ/BhqytyEFaSnquBWYZN75g2Ahsk/VXdpCA==
Date: Fri, 13 Jun 2025 19:02:28 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] iio: accel: bmc150: Do not configure IRQ registers if no
 IRQ connected
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Marek Vasut <marek.vasut+bmc150@mailbox.org>,
 Hans de Goede <hansg@kernel.org>
Cc: linux-iio@vger.kernel.org, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, Julien Stephan <jstephan@baylibre.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Salvatore Bonaccorso <carnil@debian.org>, linux-kernel@vger.kernel.org
References: <20250613124648.14141-1-marek.vasut+bmc150@mailbox.org>
 <aEw_DcqpCpcsBGd0@smile.fi.intel.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aEw_DcqpCpcsBGd0@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 2380e27ffcba99d8a1d
X-MBO-RS-META: nai8ozn4c3ho5f1z9wc3yxbpafzgip16
X-Rspamd-Queue-Id: 4bJm0n1mzDz9t9X

On 6/13/25 5:09 PM, Andy Shevchenko wrote:
> Strange I don't see Hans in the Cc list, so added.
> Thanks for the report and patch, my comments below.
> 
> On Fri, Jun 13, 2025 at 02:45:22PM +0200, Marek Vasut wrote:
>> The BMC150 on Onemix 2S does not have IRQ line described in ACPI tables,
>> which leads to bmc150_accel_core_probe() being called with irq=0, which
>> leads to bmc150_accel_interrupts_setup() never being called, which leads
>> to struct bmc150_accel_data *data ->interrupts[i].info being left unset
>> to NULL. Later, userspace can indirectly trigger bmc150_accel_set_interrupt()
>> which depends on struct bmc150_accel_data *data ->interrupts[i].info being
>> non-NULL, and which triggers NULL pointer dereference. This is triggered
>> e.g. from iio-sensor-proxy.
>>
>> Fix this by skipping the IRQ register configuration in case there is no
>> IRQ connected in hardware, in a manner similar to what the driver did in
>> the very first commit which added the driver.
>>
>> ACPI table dump:
> 
>>          Device (BMA2)
>>          {
>>              Name (_ADR, Zero)  // _ADR: Address
>>              Name (_HID, "BOSC0200")  // _HID: Hardware ID
>>              Name (_CID, "BOSC0200")  // _CID: Compatible ID
>>              Name (_DDN, "Accelerometer")  // _DDN: DOS Device Name
>>              Name (_UID, One)  // _UID: Unique ID
>>              Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>>              {
>>                  Name (RBUF, ResourceTemplate ()
>>                  {
>>                      I2cSerialBusV2 (0x0019, ControllerInitiated, 0x00061A80,
>>                          AddressingMode7Bit, "\\_SB.PCI0.I2C0",
>>                          0x00, ResourceConsumer, , Exclusive,
>>                          )
>>                  })
>>                  Return (RBUF) /* \_SB_.PCI0.I2C0.BMA2._CRS.RBUF */
>>              }
> 
> These lines...
> 
>>              Method (ROTM, 0, NotSerialized)
>>              {
>>                  Name (SBUF, Package (0x03)
>>                  {
>>                      "0 1 0",
>>                      "1 0 0 ",
>>                      "0 0 1"
>>                  })
>>                  Return (SBUF) /* \_SB_.PCI0.I2C0.BMA2.ROTM.SBUF */
>>              }
>>
>>              Method (_STA, 0, NotSerialized)  // _STA: Status
>>              {
>>                  Return (0x0F)
>>              }
> 
> ...are irrelevant.
> 
>>          }
>> "
>>
>> Splat, collected from debian unstable, probably not very useful:
> 
> Oh my gosh, please leave only ~3-5 *important* lines out of this, or move it
> completely to the comment block (after '---' cutter line).
> 
> This is requirement written in Submitting Patches.
> 
> ...
> 
> As for the solution, are you sure the line is not wired at all?

No . It is some cheap mini-laptop , I have no schematics or any other 
info really .

Note that I am not really familiar with x86 and ACPI, so there is that.

> IIRC Hans had a broken tales where it was simply forgotten, meaning
> the Android / Windows driver simply hardcoded needed info.
> 
> If it's the case, it should be solved differently around PDx86 special quirk
> driver for the cases like this.
There are likely two issues.

First, this driver needs to handle i2c_client->irq == 0 correctly if it 
should work without IRQ line, which the driver seems to indicate that it 
does. The current crashing the kernel is not the correct way of handling 
that. That's this patch, in some form.

Second, if this laptop has some IRQ line for this chip hidden somewhere, 
then it might need a quirk of sorts, sure. Is there some way to find 
out, without taking the thing apart and poking around with a scope ?

