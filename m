Return-Path: <linux-iio+bounces-16090-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F64DA45FE1
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 13:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C8BE1682B0
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 12:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC44021772D;
	Wed, 26 Feb 2025 12:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="DO4flGv8"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC04258CD1;
	Wed, 26 Feb 2025 12:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740574730; cv=none; b=sB5haWBDq2UwSHffa87niV4kbIA8b9d0y4582cnfByQASpaY2c3sbZkyUTIoC7VPvV+DXBs0UfdR0nYQD2Olgc+c14Ole6jF0CAj6AAPTkAT/dZ9hFiyy3BTjBlD49XArlrnSIcTt+dDhRXqNKyc42Ynng3MGUysQYRFXDQan1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740574730; c=relaxed/simple;
	bh=HDCN4uVUjS0xENetlgqiVHPi1gq1mvwLDjy8MPoLjnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TTjYOmqMa0Tsf2weyS5fv+kU6hJ62tPPfBYuaggqfgwLjBQYqlyhPaxXc8rkUU+1rOdLbENBumra6AgvW2vPTx++eB5Dw+o1la94HBehbenpfK6WJVigVrz0iqu0Ez8pJmT7TDdgxLWVcggLjr5lQD4m3Sq7YkmdJEuWTK/e6xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=DO4flGv8; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id EFEB7A06EC;
	Wed, 26 Feb 2025 13:58:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=SqkoWXbsWJ3TtBafR8Ti
	a4GlzkSHB+ZScgAIY2UWgSU=; b=DO4flGv8ww+GtffaBTTW4fHhgOjCoxRaLfvj
	k/Ki7UOty6fXtLvzOR/huL8ROrxkP334Z+QoVaQ0UtvrPGBTV1vN7/nIC+rnpF3J
	o7TN6+n9qfuaXDwZZnadSRnk4o+H3qYF3/C78ZjNcaNLg44T+t4ErH/VCuQF4LvT
	IZxrXMhn+Rw/IBdx18p12TT/Nfh53sxW6Qq1IYbtd7Mwktr/caI9G/YbQmvrzRVV
	n96nuTVt4kwezKeDnJ8OvRgLqGR+neeQimsQN6w2lulj03LKY53o5phJt9wv9yqH
	6sjEPrR1kC0P9DuCM6/vUqVQKnPlyDNe05xxVMudMBRrA89H1+aT7Y2RYBO4MOda
	s5pTHMTT2CgswubeFuQVm31+B5IFLzsBBnoNfPklLHUb+OJbjM+AFlj3CrzJrHP0
	YTqU8467fg+WoaJPqplmEYej56ofoZFXELhl8zBiwaWD1+3BbgTxbKlhxsBlTe+2
	LMoyjJZqvDjx9kEVkt8BrZoPjkeILeKN03HilYYM+Dfpk4QyOmsAFoqycuA1xbRm
	Sdq6WwUC2MYTQfCks4tmmHL/AgBPIaVk102/jgiGw5p5NyjEYMRS6EbHby/gXiXW
	VxYeyJaUWGyd6ufbE+f4PruDPLPQPeoBcC3aHkFr8LXc0lkDs9D8wyYQYRTJR8mN
	Q46VajQ=
Message-ID: <bfa70e78-3cc3-4295-820b-3925c26135cb@prolan.hu>
Date: Wed, 26 Feb 2025 13:58:37 +0100
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
 <Z7h0AXV1zlgp9Nw-@ishi> <8fb9f188-3065-4fdc-a9f1-152cc5959186@prolan.hu>
 <Z7vihBqOgP3fBUVq@ishi>
Content-Language: en-US, hu-HU
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <Z7vihBqOgP3fBUVq@ishi>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D9485263756A

Hi,

On 2025. 02. 24. 4:07, William Breathitt Gray wrote:
> On Fri, Feb 21, 2025 at 03:14:44PM +0100, Csókás Bence wrote:
>> On 2025. 02. 21. 13:39, William Breathitt Gray wrote:
>>> First, register RC seems to serve only as a threshold value for a
>>> compare operation. So it shouldn't be exposed as "capture2", but rather
>>> as its own dedicated threshold component. I think the 104-quad-8 module
>>> is the only other driver supporting THRESHOLD events; it exposes the
>>> threshold value configuration via the "preset" component, but perhaps we
>>> should introduce a proper "threshold" component instead so counter
>>> drivers have a standard way to expose this functionality. What do you
>>> think?
>>
>> Possibly. What's the semantics of the `preset` component BTW? If we can
>> re-use that here as well, that could work too.
> 
> You can find the semantics of each attribute under the sysfs ABI doc
> file located at Documentation/ABI/testing/sysfs-bus-counter. For the
> `preset` component, its essential purpose is to configure a value to
> preset register to reload the Count when some condition is met (e.g.
> when an external INDEX/SYNC trigger line goes high).

Hmm, that doesn't really match this use case. All right, then, for now, 
I'll skip the RC part, and then we can add it in a later patch when the 
"threshold" component is in place and used by the 104-quad-8 module.

> In the same vein, move the uapi header introduction to its own patch.
> That will separate the userspace-exposed changes and make things easier
> for future users when bisecting the linux kernel history when tracking
> down possible bugs.

Isn't it better to keep API header changes in the same commit as the 
implementation using them? That way if someone bisects/blames the API 
header, they get the respective implementation as well.

> Regarding future additions, I took a look at the Microchip SAMA5D2
> datasheet[^1] (is the right document?)

There are many versions, but yes, it is one of them, and is usable.

> and it looks like this chip has
> three timer counter channels described in section 54. Currently, the
> microchip-tcb-capture module is exposing only one timer counter channel
> (as Count0), correct? Should this driver expose all three channels (as
> Count0, Count1, and Count2)?

No, as this device is actually instantiated per-channel, i.e. in the DT, 
there are two TCB nodes (as the SoC has two peripherals, each with 3 
channels), and then the counter is a sub-node with `reg = <0/1/2>`, 
specifying which timer channel to use. Or, in quadrature decode mode, 
you'd have two elements in `reg`, i.e. `reg = <0>, <1>`.

>> The `mchp_tc_count_function_write()` function already disables PWM mode by
>> clearing the `ATMEL_TC_WAVE` bit from the Channel Mode Register (CMR).
> 
> So capture mode is unconditionally set by mchp_tc_count_function_write()
> which means the first time the user sets the Count function then PWM
> mode will be disabled. However, what happens if the user does not set
> the Count function? Should PWM mode be disabled by default in
> mchp_tc_probe(), or does that already happen?

You're right, and it is a problem I encounter regularly: almost all HW 
initialization happens in `mchp_tc_count_function_write()`, the probe() 
function mostly just allocates stuff. Meaning, if you want to do 
anything with the counter, you have to set the "increase" function first 
(even though, if you `cat function`, it will seem like it's already in 
"increase" mode). I don't know if it was deliberate, or what, but again, 
that would be a separate bugfix patch.

Bence


