Return-Path: <linux-iio+bounces-16137-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF51A48404
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 17:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 467D93A29A8
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 16:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76801BD007;
	Thu, 27 Feb 2025 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Oo9w98fR"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0F31A8F71;
	Thu, 27 Feb 2025 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671785; cv=none; b=toRdI9yYrOahygwKLXiXxd3JS67NvnUgCnJNTIvQaFoGDkHZcp0nNGKFvn0qnPxQ7ZqTu3Vwjod88jhN4DXKesp8hJ86KtowRCmdbRAKqwWd+XexgXbYFZTBBq4AOioc71dJyKkrAImRDkWtayT019wxio9XdMCKpAw7VxwwCSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671785; c=relaxed/simple;
	bh=2pSnNrN09Rs2zrWH8JjOUOcDIapOgrLstDzhoRnrrA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uL5r/AZc/1UkjpI/ZUH4gkcW5x90gUgkkxusyhNum20/5crtCLNHa8wVIQtlG+pF29IK/9lPsbbr++FriBYmegD6CjD2NHB5FI4iHDmoaIKVvpHR4kl/9ByKMLyUs8s4imZcbI9ir4PIH0XzjWwgMo+d+FzFyxqgNoU8OZxldEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Oo9w98fR; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 69D45A1B66;
	Thu, 27 Feb 2025 16:56:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=UUqUozeRUbn4nbrTWMJQ
	lf6Jo77GV6T+nGHxfg9jgGE=; b=Oo9w98fRv+aKEJIHDPo3VPKA/ET9wpJTZce1
	Cx4ygAyZrV9UN67wIN0w64ESKqoHTC4VNIUK90yTwJtt+nX4sn78J+c3iZVCngfY
	VvO0IbnWz+omdAWXRy53lKUVJXRaazsqlsGZz2Js3isGNuf1iayMxobZr/olXBzs
	LbV0GQ5ChYuOmidh+1HHoXC4MIlHtg/9FqO3L2ejIW8NdA/lQ/7dcboXLHYypuy0
	OINcAKjJLDQUtbrSTgQti3MnaISSfv9nDkPgln6d+JqmONBr4lq64mwfYDt3kYZZ
	HrBPQwbvAomqpV/iPHO5ijQaWtfNqZxYh6sTZW1qUceCsAJFrjTt0MU0Xdq1IO9+
	AjrW5+Ulrb6vWrF2VOCslJt63xG7ZsdUIF/9PUkJxnjJ1h5s/aAmCIVym3xnrjSe
	kZ4xhFipH/+CzIdQFpkrhfrkiiZrO8hIeOS6K2SiuRQebNpEHPFcdw3zmzbvNiWK
	Mi1GQSvvUdRqHeF5H6QA48jdrUbbEXbl2ktFj0mMcwB1J2vjlRIovcSYrXswMfw7
	azPlssEGN8L3JC1hHgGHu3spJP0BfnioPmIdIFbf/LgN8OCygGBbM04EQafhupY6
	vqdDOyND5XN4ShcjVuUNt/bgvS0hwDanT844Bm9FUVWfKCgnI8FldfdOMoEm0vHC
	xeQFLPU=
Message-ID: <077f23f1-3e5f-423c-aa97-ee7fcdf1475d@prolan.hu>
Date: Thu, 27 Feb 2025 16:56:17 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] microchip-tcb-capture: Add Capture, Compare,
 Overflow etc. events
To: William Breathitt Gray <wbg@kernel.org>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Kamel Bouhara <kamel.bouhara@bootlin.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Dharma.B@microchip.com>, Ludovic Desroches
	<ludovic.desroches@microchip.com>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Jonathan Cameron <jic23@kernel.org>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
References: <20250211151914.313585-3-csokas.bence@prolan.hu>
 <Z7h0AXV1zlgp9Nw-@ishi> <8fb9f188-3065-4fdc-a9f1-152cc5959186@prolan.hu>
 <Z7vihBqOgP3fBUVq@ishi> <bfa70e78-3cc3-4295-820b-3925c26135cb@prolan.hu>
 <Z7_xTQeTzD-RH3nH@ishi> <20250227135330.GC182392@tpx1.home>
 <Z8B1LDT-n2XTTp8q@ishi> <202502271437280a6701d8@mail.local>
 <Z8CA9RTZWChh9cJW@ishi> <Z8CKQvRjqH9lwzgO@ishi>
Content-Language: en-US, hu-HU
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <Z8CKQvRjqH9lwzgO@ishi>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852637760

Hi,

On 2025. 02. 27. 16:52, William Breathitt Gray wrote:
> Sorry, let me step back for a moment because maybe I'm trying to solve
> a problem that might not actually be a problem.
> 
> I see functionality settings available in the TC Block Mode Register
> (BMR) that can affect multiple TCCs at a time. Are these BMR settings
> exposed already to users in someway? If not, do we have a way to
> introduce these settings if someone wants them; e.g. would the
> AutoCorrection function enable bit be exposed as a sysfs attribute, or
> configured in the devicetree?
> 
> Finally, if there's not much interest in general for exposing these BMR
> settings, then I suppose there is no need to change how things are right
> now with the microchip-tcb-capture module and we can just keep it the
> way it is. That's my only concern, whether there are users that want to
> control these settings but don't have a way right now.

My knee-jerk answer to this is that if they do, they will bring it up by 
submitting a patch or bug request. But I'll let others chime in, we only 
use an extremely small subset of the features of the TCBs.

Bence


