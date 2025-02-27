Return-Path: <linux-iio+bounces-16120-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE36EA48126
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 15:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9173118999C9
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 14:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C1123373D;
	Thu, 27 Feb 2025 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="GhrulTfS"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F9A233159;
	Thu, 27 Feb 2025 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665889; cv=none; b=KPhQBhGXmcjrx80nIUnXV6qy0FJULYCUO3Y6bxJzJLHZ4eN9yVxe6rAP3C85JZDW9jz9UhoXCC+Vn4Aqg+ULhpCFmM/HTYT3bABOAJ71+q4fxsY1VVOU2ZerdIQMqKFR5XF1Sz2ON+y0Tie9CRymPRjWOispqlwGnbxrd4IC13Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665889; c=relaxed/simple;
	bh=I4D5T4gbh/d8tIv78snRkNTZnaNgFmKWHJjAxj3TY6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KREO59mvGa3/+f+GBLKLTINz/jCmv2YRKtu/bJRvwyl+xxeziVigKi7aG9PyRUur5j62RAzduUskOnpcvcjdL3LCa+BV2ZjL01hy+Obd6CxkUwj27xBy51jpzShOt3ajCZubThXQb+t9fnohSdnxiiKiHFjaS5ihWsKnS7vF9Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=GhrulTfS; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 4FFBBA0A38;
	Thu, 27 Feb 2025 15:17:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=Gve341c4MtwAxnVIeHWR
	vtQwTa8aD0Q7X4a/H6VslyI=; b=GhrulTfSFfOwpfdYBS/q4qhnm70YikZAXxys
	mcGK3sg7vs2kBi7gIzBBJi+a/rmZmtbeWrFm1HAxwIokNzWnp9C9u8rzplSd2mg2
	j4gQi9vdBqyHn5c9wyj2Rlliekk72u+uGYNUN2iRzieJAMa159KTN0fh0kqabDdR
	+TXs61WD5OpDxyfKrol9VWcFcVHETK87mfOI1ZawEePHuBtBMujOUX82AdNs09CR
	c7J/YzQsJ+LPIwEJ8nqOPxZ531hH/9yeSJXgHXVr7znsIuKuGwMItcZQsFs7uS9Z
	0hqbbY8cUlA4O9p9lYh3DFwVArtrO09BSfz7C+72JADErBOHKSv4aB7DbAwmu/g/
	BdV395GLBlcirSuswvXvHp3VSXbq62wzW2CVThH18+oYBEo9wwJrVqHZoIVye9CU
	BPjjFt+sxEG9ZMcQq8Wq7Bo01Ha6qtTJZLueT4K55NiT/1Gglf9S9jpXKGKihQT+
	gAIH3i5sa7Jfs3rzA/aK48Nxe50741WxLZCn+PXO9NQ6Ao3eOZ7HdJcmDYeBpA40
	+QZDPUMn17ED7Vsr1Z+DDs3R+JYkZQmZgtgOnqqZoKgMCgtsqxZVUwkJgeZPbgPP
	rIsXME3O2XnY6bWpuCLYAKrFBCYgDMy80WctMJbA0+1YptGDDoNmWEhbLfGkSCaB
	uvy7dAk=
Message-ID: <7c9941e0-1169-46cd-95b0-785e8f72eb34@prolan.hu>
Date: Thu, 27 Feb 2025 15:17:55 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] microchip-tcb-capture: Add Capture, Compare,
 Overflow etc. events
To: William Breathitt Gray <wbg@kernel.org>, Kamel Bouhara
	<kamel.bouhara@bootlin.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Dharma.B@microchip.com>, Ludovic Desroches
	<ludovic.desroches@microchip.com>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Jonathan Cameron <jic23@kernel.org>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
References: <20250211151914.313585-3-csokas.bence@prolan.hu>
 <Z7h0AXV1zlgp9Nw-@ishi> <8fb9f188-3065-4fdc-a9f1-152cc5959186@prolan.hu>
 <Z7vihBqOgP3fBUVq@ishi> <bfa70e78-3cc3-4295-820b-3925c26135cb@prolan.hu>
 <Z7_xTQeTzD-RH3nH@ishi>
Content-Language: en-US, hu-HU
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <Z7_xTQeTzD-RH3nH@ishi>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852637760

Hi,

On 2025. 02. 27. 5:59, William Breathitt Gray wrote:
>> Isn't it better to keep API header changes in the same commit as the
>> implementation using them? That way if someone bisects/blames the API
>> header, they get the respective implementation as well.
> 
> Fair enough, we'll keep the header together with the implementation.

I ended up splitting the actual creation of the file (the change to 
MAINTAINERS, along with the new header file containing the include guard 
and the doc-comment) to a new commit, and added the `enum 
counter_mchp_event_channels` to it in the commit containing the IRQ 
handler. I'll send that shortly.

>>> and it looks like this chip has
>>> three timer counter channels described in section 54. Currently, the
>>> microchip-tcb-capture module is exposing only one timer counter channel
>>> (as Count0), correct? Should this driver expose all three channels (as
>>> Count0, Count1, and Count2)?
>>
>> No, as this device is actually instantiated per-channel, i.e. in the DT,
>> there are two TCB nodes (as the SoC has two peripherals, each with 3
>> channels), and then the counter is a sub-node with `reg = <0/1/2>`,
>> specifying which timer channel to use. Or, in quadrature decode mode, you'd
>> have two elements in `reg`, i.e. `reg = <0>, <1>`.
> 
> So right now each timer counter channel is exposed as an independent
> Counter device? That means we're exposing the timer counter blocks
> incorrectly.
> 
> You're not at fault Bence, so you don't need to address this problem
> with your current patchset, but I do want to discuss it briefly here so
> we can come up with a plan for how to resolve it for the future. The
> Generic Counter Interface was nascent at the time, so we likely
> overlooked this problem at the time. I'm CCing some of those present
> during the original introduction of the microchip-tcb-capture driver so
> they are aware of this discussion.
> 
> Let me make sure I understand the situation correctly. This SoC has two
> Timer Counter Blocks (TCB) and each TCB has three Timer Counter Channels
> (TCC); each TCC has a Counter Value (CV) and three general registers
> (RA, RB, RC); RA and RB can store Captures, and RC can be used for
> Compare operations.

That seems to be an accurate description.

> If that is true, then the correct way for this hardware to be exposed is
> to have each TCB be a Counter device where each TCC is exposed as a
> Count. So for this SoC: two Counter devices as counter0 and counter1;
> count0, count1, and count2 as the three TCC; i.e. counter0/count{0,1,2}
> and counter1/count{0,1,2}.

And how would the extensions fit into this? 
`capture{0..6}`/`compare{0..3}? For me, the status quo fits better.

> With that setup, configurations that affect the entire TCB (e.g. Block
> Mode Register) can be exposed as Counter device components. Furthermore,
> this would allow users to set Counter watches to collect component
> values for the other two Counts while triggering off of the events of
> any particular one, which wouldn't be possible if each TCC is isolated
> to its own Counter device as is the case right now.

TCCs are pretty self-contained though. BMR only seems to be used

> Regardless, the three TCC of each TCB should be grouped together
> logically as they can represent related values. For example,  when using
> the quadrature decoder TTC0 CV can represent Speed/Position while TTC1
> CV represents rotation, thus giving a high level of precision on motion
> system position as the datasheet points out.

 From what I gathered from looking at the code, the quadrature mode uses 
a hardware decoder that gives us processed values already. Though I 
don't use it, so I don't know any specifics.

One more thing, as Kamel pointed it out, the current implementation 
allows channels of a TCB to perform different functions, e.g. one used 
for PWM, one for clocksource and a third for counter capture. Whether 
that works in practice, I cannot tell either, we only use TCB0 channel 0 
for clocksource and TCB1 channel 1 for the counter.

>>>> The `mchp_tc_count_function_write()` function already disables PWM mode by
>>>> clearing the `ATMEL_TC_WAVE` bit from the Channel Mode Register (CMR).
>>>
>>> So capture mode is unconditionally set by mchp_tc_count_function_write()
>>> which means the first time the user sets the Count function then PWM
>>> mode will be disabled. However, what happens if the user does not set
>>> the Count function? Should PWM mode be disabled by default in
>>> mchp_tc_probe(), or does that already happen?
>>
>> You're right, and it is a problem I encounter regularly: almost all HW
>> initialization happens in `mchp_tc_count_function_write()`, the probe()
>> function mostly just allocates stuff. Meaning, if you want to do anything
>> with the counter, you have to set the "increase" function first (even
>> though, if you `cat function`, it will seem like it's already in "increase"
>> mode). I don't know if it was deliberate, or what, but again, that would be
>> a separate bugfix patch.
> 
> That does seem like an oversight that goes back to the original commit
> 106b104137fd ("counter: Add microchip TCB capture counter"). I'll submit
> a bug fix patch later separately to address this and we can continue
> discussions about the issue there.

Thank you, squashing this annoyance would be appreciated.

> William Breathitt Gray

Bence


