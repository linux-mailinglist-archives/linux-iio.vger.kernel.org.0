Return-Path: <linux-iio+bounces-14517-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364C8A180FD
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jan 2025 16:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28CCF3A14D7
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jan 2025 15:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C1214EC5B;
	Tue, 21 Jan 2025 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="EDYM4KaC"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA1127702;
	Tue, 21 Jan 2025 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737472774; cv=none; b=nDPMKV8WFhpa3VqFe34LQAOUfAqa4Ht1m3Ww+tHkwDphlr6rUFtJDCnTHwrseLvAkLfVOupnU04c0w97CxuxJ5lPC7sMjW202Di0fzfKxy7B8DD5RwfuqBWAAud7OZhrXRxnVmkYGrrhx0rwVtGkUIbegXUADJisazA3ROnD37o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737472774; c=relaxed/simple;
	bh=J9Pxde6A+iw7H1/Rk922hQRKg2/vxGfLY5TxwEmXAbY=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=LqfbQgCHQhziO/nl4W8tqK+txPduXTGzI4tsTZCA/gZmHqoJOyXyOH6sBvOgtRLIFeNYDJxma3cTW3rP7DV1vA1OOBFNgltxNCyGOlH2wRG/AWwoql+9X4xDtOpmCLBpLUrfm224XVk0UtwH6+nVav6O4PXYBN29C6LdckUGhIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=EDYM4KaC; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 341A5A1398;
	Tue, 21 Jan 2025 16:19:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=YvSKUk5v6EFDKQLEGztTw1EfOLgqPgtPZVAGwGdWSV8=; b=
	EDYM4KaCJlzn5nU9DaE4/F2L53G9QcUJe5kNRIsYjfViLqTIbit6OzIbFGniH+LF
	Djy9tgYfH5znDGs/uz68zNkaNbcP1FHKRRnc/DYOzr7ajZWphvK+vZ3Mik3DDhFg
	iCxjDhcmC0tL4y7QtgcuKydotWHPllcnh7IdbPDzgr3ki7tPuvBgpF3jWcC42IBe
	UqaVatbPIVtT3pJIhlxDeXqew2mas2O4YHMpo4ahVaeOnzFJuVjlx8SINHN3aDG5
	fIC1tOzBpkAv87Dj6C2pQzPxExAyWbppKWZRsMDBG7ZzaNu027OwXqU3885gpcuA
	9VIE7NXepx/qdYuTRxOedmGVbfQMhllfsZcBVEl0ovkzCUU9dSytbiAGJNFO7IU7
	QA8zbjBWySvbXhPI2cleKV7Wz3YIpEBH5N2pmmjdqLcXitjWLkeDKOuMLU6kds9l
	Gc+DUI77fjTqcfNZBIvC3Iy6U8Gbgg0ZW1qadfMlC+aANiYqfOWiP4+lbAlPQx9e
	cOL2rlSfNV+0BdfylzzCn9sqbpXRQHJDsVoDMyEPCxfAA68fIzxvar7LIyVnyypj
	t8uzptbHQIjMBmFVhGHDgYet6xErA53fcjR3hj0kLs0AHBvQh//J3H7/YtqPgaSR
	GD21DQqFvLw2T3IsR5esHk7KEEz3aGciGpU0dvRMJMc=
Message-ID: <f2ec8a55-42ad-498a-b793-072444dcb92e@prolan.hu>
Date: Tue, 21 Jan 2025 16:19:27 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<timestamp@lists.linux.dev>
CC: William Breathitt Gray <wbg@kernel.org>, Jonathan Cameron
	<jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Dipen
 Patel" <dipenp@nvidia.com>
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
Subject: [Q] Frequency & duty cycle measurement?
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D9485267746B

Hi all,

we want to measure the frequency and duty cycle of a signal (relating to 
power consumption) using a hardware timer in our SoC (Microchip 
SAMA5D2). The hardware is capable of taking a snapshot of the timer 
value into another dedicated register pair (RA, RB) on the 
rising/falling edges, and a small `devmem`-based userspace utility was 
created as a working PoC. Now we want to move to a "proper" kernelspace 
solution.

However, none of the existing drivers seem to be able to do this; the 
closest was `drivers/counter/microchip-tcb-capture.c`, but that only 
seems to count one type of edge (rising/falling), and cannot give us the 
time between them, which would be needed for duty cycle calculation. The 
only other driver I could find was 
`drivers/clocksource/timer-atmel-tcb.c`, which again seems incapable of 
such measurements. Therefore, a new module will probably be needed; the 
question then becomes: which API to implement.

As `microchip-tcb-capture.c` uses the Generic Counter Interface, that 
was obviously a first stop. However, from what I could see, you can only 
represent (1) the number of times an edge has been encountered, and (2) 
rotary encodings (quadrature and direction-step decoders); and not the 
time between edges.

IIO_ALTVOLTAGE and IIO_CHAN_INFO_FREQUENCY/_PHASE also seemed promising 
(although the lack of IIO_CHAN_INFO_DUTY_CYCLE already posed a problem), 
until I saw that all current drivers are frequency *generators*, and not 
measurers, the latter seems to be completely unimplemented.

The only other contender I could find was the Hardware Timestamping 
Engine (HTE), but again, it's not clear whether (1) the API is even 
capable of relaying duty cycle information to userspace and (2) if it 
is, how would one go about implementing it.

It is also entirely possible I missed a driver or API that could handle 
this better, if so, please don't keep it to yourselves.

So, how could one go about implementing such a driver?

Bence


