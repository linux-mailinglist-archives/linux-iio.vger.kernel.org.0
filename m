Return-Path: <linux-iio+bounces-16326-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0AAA4D968
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 10:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53741188BAAA
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 09:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427D61FCFD2;
	Tue,  4 Mar 2025 09:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="gXmHO5nR"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADB242077;
	Tue,  4 Mar 2025 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741082237; cv=none; b=kzr+s40nSdKzvRe6xUNLHGiLdIvO/Bk8cwwFjukbI9qzyduJ+euEQVq7i+8rnQFyGm6q4OaKu9qCh/8h07i15iBNaMSPfSuGJqr1GHQqoEX/q54leuz0RF9XYHV8vRy0g6HYihvivZwC8ecQIOwOb87V+z2+0et85z4ARjAZzW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741082237; c=relaxed/simple;
	bh=PaNTGi8a1kzuyCrlfcyODv4zfwA4Iq2DyYt1R4ODsq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YZfpT3uqMq9l0v3mSMQuNkA+jCZtAZj0u4i1rJEK5CpBWHBlvwbfCf18DIeKvd9XNWBxmWo+gQ4tGTMQXInmUiOes9E3+JRKMnsgeBCehcy+nR7TFEOIBLmORr86bqNv38atF6NOh5FkcH+UaZJl18R9KGT3Amx/CqFp07sUzuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=gXmHO5nR; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 9F867A0391;
	Tue,  4 Mar 2025 10:57:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=O7eD0wrs+km6lrs+4i3I
	I34UDaTR3ANIVNOTTBmkqxM=; b=gXmHO5nR2oYypWDnMoZKH4nKOSeHA36L1egR
	4SdB5UtMA8/0L+c05ZMZL29MmIuG5kP51lVcgLVcELGIDwhBowTs9g8Ns2sxS9O1
	fulfKvQHC+mFwI2zQy9ri0A7kQpKy+0PJ1/82Csb44K5VkV80pb34avi686oXReT
	z1rkeTzjmetXB1veEGDkSuFkspqFGluWWNgvSLsgtNP2d5b7lzQ24CWvlj1mhP6h
	+OClikhWU5QzDbr8bj5xNRv2yMCO1lXgt+fXwGOxMo+NL1fJ4o3F53iyCOXaYvcz
	uVg529HwBL01D/XuK0yA0uD6jyF3z2w16Jr0PXO+3NEAGKn84RYoqKjkXAdYkymp
	NJTnq1udc2M4KHPKdI4EpnOXhNi5B6MuiOU8xoaKv+bcejHdWWuMklw1PDujlYpo
	FQjs82lWj/bF4uG2cUpLQntjuTshSmDYOpjlz9wKjG1I8vk/pIAatMf02/PkE9OZ
	ty0vqHXfcVyTUTNrapoVdGZ3Ja++KvuuLRDrFj5KeeC6OA0N2O3f7AN+6CuA+QWJ
	g8jHhkHJHfsBeD4uP9Ct77MqargS6eEt58bq2zu0Fxh5ipsMKNKsKem6TYhgL0XI
	Yfw6WWTAFyPpQVebPxcaenimSGSkAFJTUKjCTkwjcVR95SjNdFcWhffaBGXecMY+
	x2QsKTQ=
Message-ID: <9fcf9cf4-ba02-4583-9e14-bd650dbe32ee@prolan.hu>
Date: Tue, 4 Mar 2025 10:57:05 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] counter: microchip-tcb-capture: Add IRQ handling
To: William Breathitt Gray <wbg@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Kamel Bouhara <kamel.bouhara@bootlin.com>
References: <20250227144023.64530-1-csokas.bence@prolan.hu>
 <20250227144023.64530-3-csokas.bence@prolan.hu> <Z8alaOTjZeRuXnUI@ishi>
Content-Language: en-US, hu-HU
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <Z8alaOTjZeRuXnUI@ishi>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852637260

Hi,

On 2025. 03. 04. 8:02, William Breathitt Gray wrote:
> In theory, the error code could be something else if of_irq_get() failed
> for any other reason. Handle all those error cases at once by checking
> IS_ERR(priv->irq) rather than just -EPROBE_DEFER. Then you can just
> return dev_err_probe() with priv->irq for the error code.

Yes, `of_irq_get()` can return an error, for example if the IRQ is not 
defined in the DT. In these cases, we just don't do IRQ, but still allow 
the device to probe. -EPROBE_DEFER is special in this case, because it 
signifies that there *is* an IRQ to set up, just not now.

>> +enum counter_mchp_event_channels {
>> +	COUNTER_MCHP_EVCHN_CV = 0,
>> +	COUNTER_MCHP_EVCHN_RA = 0,
>> +	COUNTER_MCHP_EVCHN_RB,
>> +	COUNTER_MCHP_EVCHN_RC,
>> +};
> 
> These would be better as preprocessor defines in case we need to
> introduce new events to channel 1 or 2 in the future. That would allow
> us to insert new events easily to existing channels without having to
> worry about its actual position in an enum list.

Okay. I personally like the enum interface more, as it is much cleaner, 
but if there's a good reason to use #define's, then so be it.

> One additional benefit is if we do end up introducing more Counts for
> the module. In that situation we would have multiple CV and RA/RB/RC per
> Counter device, but we can easily define a preprocessor macro to
> calculate the channel offset given the Count index. However, with enum
> structure we would have to manually add and maintain redundant defines
> for each Count, which is far less ideal.
> 
> William Breathitt Gray

Bence


