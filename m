Return-Path: <linux-iio+bounces-15245-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49C8A2E85E
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 10:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B7F216766F
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 09:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191D11C5D4A;
	Mon, 10 Feb 2025 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="hRAudKGe"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766291C5D5B;
	Mon, 10 Feb 2025 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739181402; cv=none; b=tkKxoIBTV47UJUNbrCdRk4JKY5qGK3SbY17ulrOXXGiiKsiQ5nsZSLsMk/+oYHM2ET6GVfedecic81/nnP3CBDfbNkCuK8FCZkV+icjsYLywXPnJDnn+/5TFoKF6X7PwTod5whfxMK+ZuC9LOuYYqcH9PoK7yWWJQN3vjAzYFTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739181402; c=relaxed/simple;
	bh=LE/yuK4WFKe2B+rhYa4Jh8rrgBO2L53TsJK3jDfjoEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hmZNlfFthw6i9SOK+AAgsTmLalMoVyWPh5TLFrctjg3lJJWGywBZ/zdqDF02QdF78odgysJcGzOnLSqM7tTkz/DQDnGvXYcLi7apP/htQBthqAvRmkjM6l3tAkL0Qqng7N0M5VPS4wmQEfJ9IZol20IYzE0+hXkFm92W/4B72DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=hRAudKGe; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 45ED0A0ACA;
	Mon, 10 Feb 2025 10:56:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=tw4BfBkwY6f1HptDNeIv
	DAsYszDKfqvDXkBqqINUxlM=; b=hRAudKGelQQFHre0UjsRkMQGqidGMWp8U0gp
	ngrD0r6MPpPADTnuB10DYMqgqavqQMlMTbYdbc0q3KLL8kFDWZ3tz7auFC6Si0U9
	NtUHUtr5IXnDWt3iGPh0Q07bPRjTxk+nQlB30wtoSrweqqgWy7Tp35d8XBBjlxO5
	UamZs+9nYsFnDL1CVZ2Q8RMwwyD37QPnFD3gf/sjieDHd0oJMUNhcJhtFBHK/y5L
	0cawL1vyTTN4y+rJxI3fEcKz0xNs5Tbxr865hD/FLl0uketDEqs6a81AxotE7Zaf
	aRkNHd0tLUCms3lLpoR5X1Uunop25oC1hsTxEV45NjP4mbDsWg6nuubivZYaAdQj
	Qfxt84Ihj2wpIzF042vYRzzmxvDidwbGG0uxjiferJU/tj0Ef6/UwcdVC3Za3afk
	2T8ScnvMhpdLHsGF5llRGertsUgdCCIxjHRwssAYh/xSKUQxXtnXIU/lXKe0nIRx
	oxALyHmIguq0oPR90lHHiH+VJkCyIE2sebDArG2jEuS7rjeLzqcAbR0q+po9ChiH
	tl/ypUcxVktdZmpqLiQe3KIxjI5FoDV5UOyIxeMpbSm/LIg3/Dq9a1S4TzF18V+p
	BWLDIqlb5sxXnir4On5OA/IEdFwIAveMe1wBtP25RXZLm8woup2dlLjowWGblF/C
	tunTwj0=
Message-ID: <4c8a847d-b506-4235-9941-06e0d403cb62@prolan.hu>
Date: Mon, 10 Feb 2025 10:56:34 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] counter: microchip-tcb-capture: Add capture
 extensions for registers RA-RC
To: <Dharma.B@microchip.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kamel.bouhara@bootlin.com>, <wbg@kernel.org>
References: <20250205104957.95236-1-csokas.bence@prolan.hu>
 <20250205104957.95236-3-csokas.bence@prolan.hu>
 <37bf1294-a9c4-4a6b-9e5a-b8bc54ed87e9@microchip.com>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <37bf1294-a9c4-4a6b-9e5a-b8bc54ed87e9@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D9485261776A

Hi,

On 2025. 02. 07. 9:19, Dharma.B@microchip.com wrote:
> The registers RA/B/C are 32 bit registers, hence use of u64 is unnecessary.

Correct, but the definition of COUNTER_COMP_ARRAY_CAPTURE 
(include/linux/counter.h:623) is:

	#define COUNTER_COMP_ARRAY_CAPTURE(_read, _write, _array) \
		COUNTER_COMP_COUNT_ARRAY_U64("capture", _read, _write, _array)

> The regmap_read() returns an error code, which is currently ignored. If
> regmap_read() fails, cnt remains uninitialized, potentially returning
> garbage data.

Will fix.

Thanks,
Bence


