Return-Path: <linux-iio+bounces-16657-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4C3A58E50
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 09:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C6503AD615
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 08:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CE7223336;
	Mon, 10 Mar 2025 08:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="UhrfUTVC"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4328422371F;
	Mon, 10 Mar 2025 08:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741595905; cv=none; b=BLhaNPquVao+xRuPltOwvI2IeCC6Ld9P/IJIbjprtzKAFAihCSjf0CFjOiFrQ3FIiMefdaSNlkx39s717cqJWD3L9Sr+zIN/0SAczAAqGDj89VGeSwajvwvA86ika1RUivQVQ4kYGfcSVoqwYaavMqGZy0gAywhRWn6WOQQn0IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741595905; c=relaxed/simple;
	bh=akipc65XKCiwxOWNfRRDN4qDO2IUHQ6d7ElCj/ism0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hIvLyRXq1EMnuVXbZ++VbmKXBipOlaD/ZJou9xduKA4Tp0LVmzjFyq9UnmY9x1IoMriYRxHiIctBeXhjZkjNJvKxfQnyr2LzuX7D5zNVQwJ3bmtmjMP3HcrkMty44aFYPhng0jBbxLs5U3YBY4PNCt3DWaFiZC6W6EPWjup95rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=UhrfUTVC; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 39688A0397;
	Mon, 10 Mar 2025 09:38:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=1RPvwC+SFy2YIdkjWwuN
	aPaUWekWLQniVxE5EnDG1B8=; b=UhrfUTVC37v4qZRwCV/aThUVI46V6B18Qc05
	HuvcPrcXOvM5V/kF/pSa8HquCMmbLJXOqvXQgCDEv5HxpejqO7RlzrgKwT4SAh0i
	A9LbLotIB8uhz2hh9p8KUL67lePVISnoQjdU5usVzMuROcw2mdLrUj5OzUwGQmGc
	GfPY8zU7uWFUmG+3QenSdOUDQogd36Q/pVmvMj1IxKj4fdNbyFsJuKmYilrZfo1X
	p8PFgc8GM6K4jPA6l8i6mFvQrCqyElufwhj6zmBIW5+zPt6rwIFnQQCkTy0kwdQx
	AxPwylG0A8/1MBtwlIzblNxX4HKd58lH04iGLS3bEU1f//amdmAIV8+2atP0zZBb
	Ooh3hHwz+0g/wFBI2f2fJGKeEqkx3RMdFjHlBKmU604my3jT6bQ4rGHWsyo2t76A
	YQxPG8Ghy1o2YRu6gSTcEZuUtUUj7WD/LGhWTG/MWCuPnPeLJqCH6RG3jZd0iGZ9
	TxjKf7Io/crgBcwyUT5pCNV5aPR8zU1vTgnOl64VV8ApF2CL6WF7vc4C7OBsJdQf
	SLJAN8pJIE6jHnaEfqIVFPINs0g3CHkBhjhVGWtQGVICgHbkoUdy7YpYodv9JLr8
	SAUvm1N1FPWxBYcdZA4NCUP1CxAkwcS9Q/0GliG63eZVgpXrtRDwRlehuSeYWbc1
	qzO47dk=
Message-ID: <790f00da-d66e-42bc-bae2-339144fbec95@prolan.hu>
Date: Mon, 10 Mar 2025 09:38:13 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] counter: microchip-tcb-capture: Add support for RC
 Compare
To: William Breathitt Gray <wbg@kernel.org>, Kamel Bouhara
	<kamel.bouhara@bootlin.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20250306-introduce-compare-component-v1-0-93993b3dca9c@kernel.org>
 <20250306-introduce-compare-component-v1-2-93993b3dca9c@kernel.org>
Content-Language: en-US, hu-HU
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20250306-introduce-compare-component-v1-2-93993b3dca9c@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852627664

Hi,

On 2025. 03. 06. 8:05, William Breathitt Gray wrote:
> In Capture mode, the RC register serves as a compare register for the
> Timer Counter Channel. When a the Counter Value reaches the RC value, a
> RC Compare event occurs (COUNTER_EVENT_THRESHOLD). This patch exposes
> the RC register to userspace as the 'compare' Count extension, thus
> allowing users to configure the threshold condition for these events.
> 
> Signed-off-by: William Breathitt Gray <wbg@kernel.org>

I'm assuming you'll merge it with my capture extensions patch. Will this 
`compare` extension be carried over to 104-quad-8 as well? Otherwise:

Acked-by: Bence Csókás <csokas.bence@prolan.hu>

Bence


