Return-Path: <linux-iio+bounces-21418-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FC1AFB181
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 12:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702B33AD465
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 10:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20698288C36;
	Mon,  7 Jul 2025 10:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MLpkOaTA"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070C826059D;
	Mon,  7 Jul 2025 10:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751885049; cv=none; b=Uxs6et6vJ5pFsi0l/QQsxm4N8LavTcsdGFn7WEpSmG4fVL1Any7MS5EGbK/L59zo+or4UkRnQfUujeQiCzJQ2P0q7Eh46JpSKV+Q8pLclzbGyzv8iRKb7D64ctTsHq5z4RqjYwY0AxFcD3al1Vm5LVCQ8gcL98pBqm0R/cCnD+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751885049; c=relaxed/simple;
	bh=SjYXX7ZDI39EwB3CpttIlw1Vl4E8XtC1XpyQv46bDcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KjyJOC/MoPOKPnHyOFeE5CkLhCW3q23LfD4fQo+ERWqd3SZRnRZQOeSnja5tgyJmC1Hhsri9Q6SNnjFuFJ4o49+3r3573IPUD7Nu+rgh1SiQbaLBn4pZCJ5d0Ox712WANBun3e9QqHUka/hFz01rbuICeH+SbKpspVPKj0ZRsWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MLpkOaTA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751885046;
	bh=SjYXX7ZDI39EwB3CpttIlw1Vl4E8XtC1XpyQv46bDcs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MLpkOaTAJLq4MlrgIGANDFNa+JH58OcI6UYNWz/PJEFtQcnmTL/RIx8x27u3R/myf
	 jZMJyaM26Ev9l5IitO46i1LH/ENLfRMgk9batqZ8+o/RlOqpnl4t+a522dY6kyY1ZS
	 tI4r0mziRd2JgKo/oZIP1/oLouUSQeWebAMEVYdxNT3Kf80lzK+HLofHTgTGKdIn1l
	 slcINFRYB82/9SfjGD3s9Nxs2pDgs2XHC0R5dBhjVMiXKEwZtjvl+H4T1JAwvRLieK
	 cNKSbM+nzmOYeTEyE7vv9qBtcud49x8Wvv/atmaSumhHGWzR2RP1XLvaZh1sRjvkMf
	 9xMdydt8MqLDQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6ABA517E06BF;
	Mon,  7 Jul 2025 12:44:05 +0200 (CEST)
Message-ID: <5a196563-9589-4d00-a042-1dbb0295b0a5@collabora.com>
Date: Mon, 7 Jul 2025 12:44:04 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] iio: Add support for MT6363/6373 Auxiliary ADC
To: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com
References: <20250703141146.171431-1-angelogioacchino.delregno@collabora.com>
 <ab0a407412c705e409d9d26591543713a092c13f.camel@gmail.com>
 <20250706114455.26748e20@jic23-huawei>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250706114455.26748e20@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 06/07/25 12:44, Jonathan Cameron ha scritto:
> On Fri, 04 Jul 2025 13:39:56 +0100
> Nuno Sá <noname.nuno@gmail.com> wrote:
> 
>> On Thu, 2025-07-03 at 16:11 +0200, AngeloGioacchino Del Regno wrote:
>>> Changes in v2:
>>>   - Added error checks to all regmap r/w operations
>>>   - Moved adc_vref addition to different commit
>>>   - Various other fixes
>>>
>>> This series adds support for the Auxiliary ADC IP found on the new
>>> MediaTek MT6363 and MT6373 PMICs, found on board designs featuring
>>> the MT8196 Chromebook SoC or the MT6991 Dimensity 9400 Smartphone SoC.
>>>
>>> AngeloGioacchino Del Regno (6):
>>>    dt-bindings: iio: adc: mt6359: Add MT6363 PMIC AuxADC
>>>    dt-bindings: iio: adc: mt6359: Add MT6373 PMIC AuxADC
>>>    iio: adc: mt6359: Add ready register index and mask to channel data
>>>    iio: adc: mt6359: Move reference voltage to platform data
>>>    iio: adc: mt6359: Add support for MediaTek MT6363 PMIC AUXADC
>>>    iio: adc: mt6359: Add support for MediaTek MT6373 PMIC AUXADC
>>>
>>>   .../iio/adc/mediatek,mt6359-auxadc.yaml       |   2 +
>>>   drivers/iio/adc/mt6359-auxadc.c               | 440 +++++++++++++++---
>>>   .../iio/adc/mediatek,mt6363-auxadc.h          |  24 +
>>>   .../iio/adc/mediatek,mt6373-auxadc.h          |  19 +
>>>   4 files changed, 416 insertions(+), 69 deletions(-)
>>>   create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6363-auxadc.h
>>>   create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6373-auxadc.h
>>
>>
>> LGTM,
>>
>> Reviewed-by: Nuno Sá <nuno.sa@analog.com>
>>
> Applied to the togreg branch of iio.git.  Initially pushed out as testing
> for 0-day to take a first look and see if we missed anything.
> Jonathan
> 

Thanks for that!

Cheers,
Angelo

