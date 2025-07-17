Return-Path: <linux-iio+bounces-21755-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F899B0921C
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 18:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00A54A6304
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 16:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39992FBFE9;
	Thu, 17 Jul 2025 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m8fg2IKA"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A558145348;
	Thu, 17 Jul 2025 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752770546; cv=none; b=oppIK/s0sGOO5daOEJBAAnsOemWq8whRQA/fahgglgK/WGFD70dh27IQyzgNOA8E1yILTLEKXu0g2F0eq66m+OU+IFZtJ4eM9jw4QRiwSheyKn7E7UadVdZwG2b0zVOoEYltewydvVwNQ0KNeSHbdVaoaxO29t+kjPnr3MutX8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752770546; c=relaxed/simple;
	bh=pwzmXDwJ4zUMLHJozgllRu/mzzAcAPdj9GK36HNatug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YEkXf7V9UV+onMPrb/7C18BjGPzaSnPbeZnZhQIA4MN+9PlJ240xUNh5F1yBvIoo2Ea1YfwwXqbu5EYaYCPg80YJNyK6CHtbJchuyBmIoe23EKLPzEVTf4FDinXw/A6/JyY2b/oDrx7kcZGNE+FE4hkyTu1NXxDMqGVy6VSmSzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m8fg2IKA; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f180b5ac-131f-474a-be5e-70787972a772@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752770541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I57bGWW9HkB2BD1T3Qt5kgqxhjLDrfo2Pvi/xORSNyE=;
	b=m8fg2IKADa4qU9gIaAHsRTO2qJ11Wiblg7fZdxmnZZ4N9E9weBx+d5aaL/MFgkSieN0onb
	yceX37QtsrrwWTo4DeQQ97vjAE35CGMvLn16a+4kdvA4SmG7GHO/jiR72M+xcEGi/Aees7
	qyybYucPF9Oo9NtlJ47+98oKRR3xKGs=
Date: Thu, 17 Jul 2025 12:42:13 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/7] iio: inkern: Add API for reading/writing events
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-kernel@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
 <20250715012023.2050178-3-sean.anderson@linux.dev>
 <aHYOuzdQ_jSKA898@smile.fi.intel.com>
 <8bb7d291-f94a-4e96-b3ec-93fbe06c8407@linux.dev>
 <aHdwzFk-688ASRx2@smile.fi.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <aHdwzFk-688ASRx2@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/16/25 05:28, Andy Shevchenko wrote:
> On Tue, Jul 15, 2025 at 11:42:05AM -0400, Sean Anderson wrote:
>> On 7/15/25 04:18, Andy Shevchenko wrote:
>> > On Mon, Jul 14, 2025 at 09:20:18PM -0400, Sean Anderson wrote:
> 
> ...
> 
>> >> +EXPORT_SYMBOL_GPL(iio_event_mode);
>> > 
>> > Can we move this to namespace? Otherwise it will be never ending story...
>> > Ditto for other new APIs.
>> 
>> Never ending story of what?
> 
> Of converting IIO core to use exported namespaces.

What's the purpose?

>> >> +			if (scale64 <= INT_MAX && scale64 >= INT_MIN)
>> >> +				raw64 = processed / (int)scale64;
>> > 
>> > Do you need the casting? (I mean if the compiler is dumb enough to not see this)
>> 
>> AIUI 64-bit division is not available on 32-bit platforms. The cast
>> ensures we get 32-bit division.
> 
> I put specifically a remark in the parentheses. So, the Q is if the compiler
> doesn't recognize that. Can you confirm that 32-bit compilation without cast
> is broken?

inkern.c:(.text.iio_write_event_processed_scale+0x14c): undefined reference to `__aeabi_ldivmod'

>> >> +	*raw = clamp(raw64, (s64)INT_MIN, (s64)INT_MAX);
>> > 
>> > You already have similar approach here...
>> 
>> Well, I can spell it 0x7fffffffLL if you'd like...
> 
> Nope, I like to have named constants instead of magics, but actually are those
> castings needed for the clamp()?

Apparently not. The checks in __clamp_once are only for matching signedness. And
the ints are promoted to s64s when the comparison is made.

--Sean

