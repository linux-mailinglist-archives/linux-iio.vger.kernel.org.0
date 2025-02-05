Return-Path: <linux-iio+bounces-15028-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598F5A2868D
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 10:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833041614C8
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 09:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C147F22A7E4;
	Wed,  5 Feb 2025 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="EhFjjncC"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3A11D7985;
	Wed,  5 Feb 2025 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738747832; cv=none; b=u/SuqrBX7nUJjJvOSX/j2lhWBB75AeC1h1qjkZIoi2opP9ewhjGqFLeyfKas+wlAAobxHuKSwGEdzsGoKgTvTDJb3jFigI2fYLEF/5tYv2zQvkeY/PbxiX4/MZ56WBnXTqsX2jvGJL3+o3BdG3zTaMjl0OdO1uP8AryY6+JUINA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738747832; c=relaxed/simple;
	bh=yiaG+bx3BDH8rNjqFqrNt10N9XG3vWEYJp26aaimBPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Pryxo4EwK1W6ixEU0UWKemvdRKiSHFIfRY8Owg0QPoFr6TYA86CYDEczbSS+6XVpYm7y7JaZssccvb2gqINWDWvNEKamhE/l0rcXHNaiTNEbWstIQ6ZNE4P8FqpckQ5NLAzIkQVGWZ+awz3oEUS4YuuvUHr03E031KXI7akPScs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=EhFjjncC; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 24CD3A079A;
	Wed,  5 Feb 2025 10:30:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=oZmcIW5wOrNb8xct7xRf
	me9B6Vb+WCUzLGVoJLibljY=; b=EhFjjncCvOyxRr8VieGK1+kFktivOwz8u+3q
	+FlGiNfj+SU8TbQS8e5aRgqwmoR0Nj6iKvYlAXDYnAySvxYK+Q/Y/HTVdpiaE47H
	ZRT4AGBaLWXqVeAEgVPqHooEbc8feSQJiO1RNDXs3e2JyvdVxw5FNOet4giM7gM+
	PcxADs4jI3JNGaSdKcQW96oDSOiVcKnnWmdUXKoSUYZAdjsO7zYM96aYBTOeufyA
	EiGlh5vbvE6+O6TujJne2lqg4uqiBh7rdofFgubgOeIXCgEJzN0oWCDimvpVHAQN
	/VFBVBNWLrAhUBCPEkDdb0d2jeZoZu6+fZrkPENuwfLSSNCAfQY2eE/TPrFCyZuz
	djJZflYO0r45jae56N/llfuXU6btwzGMvHBAH3aPi9a6aFK7LpWQzgNESstcV7FX
	fDZ3gw+wMW3oCi7BF6hMRGFSHW0VQ2O2RDPToUbYdDDC4BhwSlPqCFTv/w0LFUbF
	K7SSeQwHQRZt+xWBOaMQ9GGiamSH8nqRTB05unapxxjvYwiM2PbZ6jAYWTk1uyZD
	Zg1bRnM8RafdjIOuuRrfuGWqDWvoqNU4CMt75teS4FLPrUJgJ9c+UVvYcf960jdd
	eSTzoBgV1JxD+l9EOtChY/oTjUnxw/PuTBBF7gb7wBSUOuEGVeGOLNJVM4Jq0fH+
	ztqSwOI=
Message-ID: <0c74dd96-2978-46ab-a399-9c94c9529b2e@prolan.hu>
Date: Wed, 5 Feb 2025 10:30:26 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Q] Frequency & duty cycle measurement?
To: William Breathitt Gray <wbg@kernel.org>
CC: <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<timestamp@lists.linux.dev>, Jonathan Cameron <jic23@kernel.org>, "Lars-Peter
 Clausen" <lars@metafoo.de>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Thomas Gleixner" <tglx@linutronix.de>, Dipen Patel <dipenp@nvidia.com>,
	<dlechner@baylibre.com>
References: <f2ec8a55-42ad-498a-b793-072444dcb92e@prolan.hu>
 <Z5efcokgHix-k3lW@ishi> <dffc0f18-799a-4fc7-a6b5-2fa270e1fc58@prolan.hu>
 <Z6KkusvLFPcNvEfl@ishi>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <Z6KkusvLFPcNvEfl@ishi>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852667264

Hi,

On 2025. 02. 05. 0:37, William Breathitt Gray wrote:
> Are you still having trouble with this? Is "X" the
> capture{0,1}_component_id value?

X is 0/1 from `/sys/bus/counter/devices/counter0/count0/capture{0,1}`, 
which is also equal to the respective `capture{0,1}_component_id`, since 
I don't have any other counters. I checked that beforehand.

> I apologize, the Generic Counter character device interface is
> underdocumented so it can be a bit confusing at first; I'll submit a
> patch improving the documentation later this cycle when I get a chance.
> For now, let's walk through how to create an appropriate Counter watch
> for the capture extension components you have.

After much tinkering and reading of the `counter-chrdev.c` code, I now 
see *something*, although it's much slower to make a measurement than 
the sysfs `reopen()` hack.

> The first step is to decide which event we'll monitor and on which
> channel: we want to monitor Capture events so that's
> COUNTER_EVENT_CAPTURE, and we want event channel 0 (n.b. 0 because
> that's the channel parameter value passed to counter_push_event() in the
> driver).
> 
> The next step is to choose the components you wish to watch: Count 0's
> capture0 and capture1 extensions. So type is COUNTER_COMPONENT_EXTENSION
> because we want to watch extensions, scope is COUNTER_SCOPE_COUNT
> because we want Count extensions, and parent is 0 because we want
> Count 0's Count extensions.
> 
> Finally, we need to set the component id for each extension. You get a
> particular component's id by reading the respective *_component_id sysfs
> attribute: so for capture{0,1} you would read capture{0,1}_component_id
> respectively. These component id values potentially can change with
> future driver updates, so for robustness your userspace application
> should read the respective *_component_id sysfs attribute itself rather
> than hardcoding the component id in the Counter watch.
> 
> However, for the sake of simplicity in this example, I'll assume the
> component ids are 42 and 43 respectively for capture0 and capture1. That
> gives us the following two watches:
> 
>          {
>                  .component.type = COUNTER_COMPONENT_EXTENSION,
>                  .component.scope = COUNTER_SCOPE_COUNT,
>                  .component.parent = 0,
>                  .component.id = 42,
>                  .event = COUNTER_EVENT_CAPTURE,
>                  .channel = 0,
>          },
>          {
>                  .component.type = COUNTER_COMPONENT_EXTENSION,
>                  .component.scope = COUNTER_SCOPE_COUNT,
>                  .component.parent = 0,
>                  .component.id = 43,
>                  .event = COUNTER_EVENT_CAPTURE,
>                  .channel = 0,
>          },
> 
> Does this resolve your chardev read issue? If you're still having
> troubling, just let me know and we can troubleshoot further to figure
> out what's going on.

I had no success using `channel = 0`, only data from `capture0` comes 
back. If I set both `channel` AND `component.id` to X, then I start to 
see similar values than what I get from reading sysfs. (For now I 
hard-coded all values; I agree that the correct way would be to read 
component IDs from sysfs, but this is still a PoC...)

Did I do something wrong in implementing the driver maybe? (See the 
submitted patches.) And any idea as to why I might be seeing the slowdown?

Bence


