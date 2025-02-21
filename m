Return-Path: <linux-iio+bounces-15912-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15923A3F71E
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2025 15:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06D117C8BF
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2025 14:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424FC20F08F;
	Fri, 21 Feb 2025 14:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="h4+stQVC"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1107620F07C;
	Fri, 21 Feb 2025 14:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740147875; cv=none; b=r0xKiU56H/k/DP/ut0xJ1mtQSEvTf0xULk5L3Alyws1TvQnhbuI6/0+3GcgTqZxRmLNo4KbbPJ1qoKrra4JluWQxuVu22ZIJ7oorbnFox3ksjqMTIwVs0mf9fkfOrOY46LMoAPmKUcdXWhH3AWeWjjN2H7Ogj3Wc27SntTw/v3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740147875; c=relaxed/simple;
	bh=YKUTgm4oy5vwxcdkG9sPJgJIWxtlrqVDzzsGd4m4+bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=janZE8jHBXTSkiXg/pGXL+EQysghzIzlWC6eGfUoHGpNJALg6QrTaxIQ6sWQg2uF+vRz+CQmuCWjPbftO8Xb/PANiEiXTuiIsJb+77iLGmibU8xDTKWZNjmsJkZDGLtgwmKGyH5l7+MlsZFqalS4wqPciVR7Ij3sh9KKzF9BebA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=h4+stQVC; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 418FEA0AAA;
	Fri, 21 Feb 2025 15:14:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=WRlNS+d53iQwEF0PVQZc
	s6ddeNbr3K+AJbfAJwaHGV8=; b=h4+stQVCGI40++peP5PLy4/+eHfGdXT1hufQ
	R3BV2RbEHbXIKEtSxxBPlEChGvka+CjLG644oHmGtJZlIXFRzFl4FaZ1Q6h8dWjA
	igOvY55lsLE0IXPdIdVtHVo32KkxGcAbIfq2NIHPZh5xh24r/PiRVXupv3lLigtB
	iXd+3PtTxRXOxJ3HLpPheJZst80Pxn2R0oUUpu63t+BuF6C1NEJxiUQNSjL7lKG1
	lbN+II+20eyN3s4SG9R3BHGYbN7yvxWZPWO2EpZqRuSlvTsI5QuNnifhdl2HdykO
	MgrdyAJ/0TsHToEBIjguj0DTyEhNsJ1pjs1w+RGDT4hnI7lM79vppgSYYvJemKFc
	L1s271ynXsNE9TgWU1cq40CnsIK2FctOc6Xpte97YGW1Lg4vLtEOEz3J1z911OI8
	Aqj9+MbLSxvATy0eWPriJX97D0SK9Hg+j+kuXTRNQTt/rrpVVx6gMqqaZUyhpFIi
	PSRkEK96EcwZyEtQyP2X73kq9QzdKDVI33W6gUCIZ74O1149NmA2GHf0Fbbi3Aem
	ONNw+A6Cfv+rIQEq3ux3KcILFkxok3J3MEEXRCApTQU+bFeSDbfT8cyyJssl/Arv
	4qKhYNw4dQzyAs4eBKfxPuVEYhrvds0+mKUAIB5jCwc1pczg34zEvDqYFas4zIr1
	57r1Lg0=
Message-ID: <8fb9f188-3065-4fdc-a9f1-152cc5959186@prolan.hu>
Date: Fri, 21 Feb 2025 15:14:44 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] microchip-tcb-capture: Add Capture, Compare,
 Overflow etc. events
To: William Breathitt Gray <wbg@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Kamel Bouhara <kamel.bouhara@bootlin.com>,
	<Dharma.B@microchip.com>
References: <20250211151914.313585-3-csokas.bence@prolan.hu>
 <Z7h0AXV1zlgp9Nw-@ishi>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <Z7h0AXV1zlgp9Nw-@ishi>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D9485260706A

Hi William,

On 2025. 02. 21. 13:39, William Breathitt Gray wrote:
> On Tue, Feb 11, 2025 at 04:19:11PM +0100, Bence Csókás wrote:
>> The TCB has three R/W-able "general purpose" hardware registers:
>> RA, RB and RC. The hardware is capable of:
>> * sampling Counter Value Register (CV) to RA/RB on a trigger edge
>> * sending an interrupt of this change
>> * sending an interrupt on CV change due to trigger
>> * triggering an interrupt on CV compare to RC
>> * stop counting after sampling to RB
>>
>> To enable using these features in user-space, an interrupt handler
>> was added, generating the necessary counter events. On top, RA/B/C
>> registers are added as Count Extensions. To aid interoperation, a
>> uapi header was also added, containing the various numeral IDs of
>> the Extensions, Event channels etc.
>>
>> Bence Csókás (2):
>>    counter: microchip-tcb-capture: Add IRQ handling
>>    counter: microchip-tcb-capture: Add capture extensions for registers
>>      RA-RC
>>
>>   MAINTAINERS                                   |   1 +
>>   drivers/counter/microchip-tcb-capture.c       | 137 ++++++++++++++++++
>>   .../linux/counter/microchip-tcb-capture.h     |  49 +++++++
>>   3 files changed, 187 insertions(+)
>>   create mode 100644 include/uapi/linux/counter/microchip-tcb-capture.h
> 
> Hi Bence,
> 
> I had some time to read over your description of the three hardware
> registers (RA, RB, and RC)[^1] and I have some suggestions.
> 
> First, register RC seems to serve only as a threshold value for a
> compare operation. So it shouldn't be exposed as "capture2", but rather
> as its own dedicated threshold component. I think the 104-quad-8 module
> is the only other driver supporting THRESHOLD events; it exposes the
> threshold value configuration via the "preset" component, but perhaps we
> should introduce a proper "threshold" component instead so counter
> drivers have a standard way to expose this functionality. What do you
> think?

Possibly. What's the semantics of the `preset` component BTW? If we can 
re-use that here as well, that could work too.

> Regarding registers RA and RB, these do hold historic captures of count
> data so it does seem appropriate to expose these as "capture0" and
> "capture1". However, I'm still somewhat confused about why there are two
> registers holding the same sampled CV (or do RA and RB hold different
> values from each other?). Does a single external line trigger the sample
> of CV to both RA and RB, or are there two separate external lines
> triggering the samples independently; or is this a situation where it's
> a single external line where rising edge triggers a sample to RA while
> falling edge triggers a sample to RB?

It is exactly the latter. And you can configure which edge should sample 
which register; you can also set them to the same edge in which case 
they would (presumably) hold the same value, but as you said, it 
wouldn't be practical.

> Next, the driver right now has three separate event channels, but I
> believe you only need two. The purpose of counter event channels is to
> provide a way for users to differentiate between the same type of event
> being issued from different sources. An example might clarify what I
> mean.

Yeah true, I could shove the RC compare event to event channel 0. It 
just made more sense to have event channels 0, 1, 2 correspond to RA, RB 
and RC. And it's not like we're short on channels, it's a u8, and we 
have 5 events; if we wanted to, we could give each a channel and still 
have plenty left over. I also thought about separating RA capture from 
channel 0, but I figured it would be fine, as you said, the event type 
would differentiate among them.

The reason I did not put the RC compare event to channel 0 as well is 
that I only have the SAMA5D2, and I don't know whether other parts are 
capable of generating other events related to RC, potentially clashing 
with other channel 0 use, if we later decide to support them. One 
channel per event-sourcing register seems like a safe bet; having CV and 
RA on the same channel still seems to be an acceptable compromise (but 
again, I don't know about the other parts' capabilities, so it _might_ 
still lead to clashes).

> Suppose a hypothetical counter device has two independent timers. When
> either timer overflows, the device fires off a single interrupt. We can
> consider this interrupt a counter OVERFLOW event. As users we can watch
> for COUNTER_EVENT_OVERFLOW to collect these events. However, a problem
> arises: we know an OVERFLOW event occurred, but we don't know which
> particular timer is the source of the overflow. The solution is to
> dedicate each source to its own event channel so that users can
> differentiate between them (e.g. channel 0 are events sourced from the
> first timer whereas channel 1 are events sourced from the second timer).
> 
> Going back to your driver, there seems to be no ambiguity about the
> source of the CHANGE-OF-STATE, THRESHOLD, and OVERFLOW events, so these
> events can all coexist in the same event channel. The only possible
> ambiguity I see is regarding the CAPTURE events, which could be sourced
> by either a sample to RA or RB. Given this, I believe all your events
> could go in channel 0, with channel 1 serving to simply differentiate
> CAPTURE events that are sourced by samples to RB.
> 
> Finally, you mentioned that this device supports a PWM mode that also
> makes use of the RA, RB, and RC registers. To prevent globbering the
> registers when in the wrong mode, you should verify the device is in the
> counter capture mode before handling the capture components (or return
> an appropriate "Operation not support" error code when in PWM mode). You
> don't need to worry about adding these checks for now because it looks
> like this driver does not support PWM mode yet, but it's something to
> keep in mind if you do add support for it in the future.

The `mchp_tc_count_function_write()` function already disables PWM mode 
by clearing the `ATMEL_TC_WAVE` bit from the Channel Mode Register (CMR).

> William Breathitt Gray
> 
> [^1] https://lore.kernel.org/all/7b581014-a351-4077-8832-d3d347b4fdb5@prolan.hu/

Bence


