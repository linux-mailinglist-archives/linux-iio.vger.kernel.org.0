Return-Path: <linux-iio+bounces-15029-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 865FEA28734
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 10:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761781889559
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 09:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1352C22A80B;
	Wed,  5 Feb 2025 09:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="bDsV/kSU"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30041D7985;
	Wed,  5 Feb 2025 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738749531; cv=none; b=uJJHwwFdi+3Da+BId1QG+Qs+u3Xynu0qFVl1VgmzlI6mtNfMqRcrCWoSz22K+yL1ChRDN/D5cu0PSNqmsmeJOELy0agj7eyieUKtYVnqOGa33thu4ZHNpAGqU8u71NWFQOAfNniTWxAqFNWHJdDkP8o2BPg2QQRalJJgPuIhy2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738749531; c=relaxed/simple;
	bh=5d6O2XSHf7Maij7yhtfHG81LuwNDfgfbLLGP85GgPxA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=T20eizwd6fzWpsRhUGFL7N9+e9e0vKH3K9b1bL5AZyigFCLO1MMhycOce/sEFTC3FXTzNyPN3oZi6rp7jXmJ+QuTojo1oUrNnwYJYbp56wSjEa8h9uwtcXLEUn6noz1jqQd1UYTz08inTB7E6hDU3jSiqDX7inWFjVdECUA9VLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=bDsV/kSU; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id C6C4CA0397;
	Wed,  5 Feb 2025 10:58:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=oHiAWliwlYMMYJzF/p+i
	3JygK75ijJmhUfA6PxHfmuw=; b=bDsV/kSUooCJDi7x0+tzEr1+x5Prt7w9wBB7
	oxqawTSx7ETk4wisyrF6lG8UdUYipBl2l2RiEr1+NoZvkOdGZbMeTNK6ojK2CfeT
	Fir34+J6ihhekb4aOjZRlVuUPCLi0JKCMm05O8kQXAWXeb712De9AtXjRRBOq/mV
	mX8nZBlNIdQoqB/zvry7WkIBuXQM81wmz86LlVsVn+Wc7guPeUi3ilF2ThsgwT07
	zTXd0RU/PiFftsBL2+g6tW9vTgeD69peTpPsEjiqLgdWpJ3I4rYIIFK6b6f3DdkI
	IDTxpPRq23+/yysFc86/3YXxlLCLevIvZ/qJQWuUKfRWcZSqiRGaDZ1SPcXrtXAe
	c9eRvRQWRc8SbC5uUoMTpe3eSxPGkrHt5CiCSy5Tq563ioA1jjZxy0BwT9lT+/xr
	dcGEkSj1RnE+Vg5HNHjX4hUyI329+E4W2mQEybFelNiuOgMlrdxkjVDQEpn48LBw
	dLz/j20fE0ZbRwLTOKUnm9i1b0MjGu9Vhh1/lFIMpI9pjrHDnyvkfnNKXN2nNqyh
	Q18gYC+isS6tOdfKwyU3Qy/FTvN9sCd+Ih1kPxZJV79rXwwj/GO0sNHgl84SjOEz
	sQ6mTYLrxgAEp5+88+KJ66oHPxDdYZrdY9HHwHDrAtqG+Qf1byG9RgVmIyEpFaMc
	6dFa2oY=
Message-ID: <c68777f2-b053-4320-aabe-f95a9796b016@prolan.hu>
Date: Wed, 5 Feb 2025 10:58:45 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Q] Frequency & duty cycle measurement?
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
To: William Breathitt Gray <wbg@kernel.org>
CC: <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<timestamp@lists.linux.dev>, Jonathan Cameron <jic23@kernel.org>, "Lars-Peter
 Clausen" <lars@metafoo.de>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Thomas Gleixner" <tglx@linutronix.de>, Dipen Patel <dipenp@nvidia.com>,
	<dlechner@baylibre.com>
References: <f2ec8a55-42ad-498a-b793-072444dcb92e@prolan.hu>
 <Z5efcokgHix-k3lW@ishi> <dffc0f18-799a-4fc7-a6b5-2fa270e1fc58@prolan.hu>
 <Z6KkusvLFPcNvEfl@ishi> <0c74dd96-2978-46ab-a399-9c94c9529b2e@prolan.hu>
Content-Language: en-US
In-Reply-To: <0c74dd96-2978-46ab-a399-9c94c9529b2e@prolan.hu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852667264

Hi,

On 2025. 02. 05. 10:30, Csókás Bence wrote:
> Hi,
> 
> On 2025. 02. 05. 0:37, William Breathitt Gray wrote:
>> The first step is to decide which event we'll monitor and on which
>> channel: we want to monitor Capture events so that's
>> COUNTER_EVENT_CAPTURE, and we want event channel 0 (n.b. 0 because
>> that's the channel parameter value passed to counter_push_event() in the
>> driver).

Ah, I push 0 and 1 for the two interrupts... So that's why `channel` has 
to be 0 and 1 as well. Does it make sense to do it this way, or should I 
push on event channel 0 always?

> I had no success using `channel = 0`, only data from `capture0` comes 
> back. If I set both `channel` AND `component.id` to X, then I start to 
> see similar values than what I get from reading sysfs. (For now I 
> hard-coded all values; I agree that the correct way would be to read 
> component IDs from sysfs, but this is still a PoC...)
> 
> Did I do something wrong in implementing the driver maybe? (See the 
> submitted patches.) And any idea as to why I might be seeing the slowdown?

The slowdown is still a mystery though...

Bence


