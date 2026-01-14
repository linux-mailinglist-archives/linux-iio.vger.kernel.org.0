Return-Path: <linux-iio+bounces-27714-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 190C9D1D6F7
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FE5A3080A9E
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 09:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17A737F8D7;
	Wed, 14 Jan 2026 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="X/u2b6SJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565D0199D8;
	Wed, 14 Jan 2026 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768381441; cv=none; b=amgUZBhAzkGw6hv6aiI5UaOqPjYh9yWl7a2XIIvF9Uo+JT+a0PXayH1D3LiHmmhFQuiyJYKM/fGWZqnQFR8m6u0BR8NzziUXAyDtZ22kvYgsoXUJ3TogHGeKBYdqTh49p2zvpJehppKT6aQOrnSzy7dxlEyRF02WywC17H/dWSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768381441; c=relaxed/simple;
	bh=Bmm0bfKxZ+xyalDgjLpooMd2+oroWes+csIA7YD0GgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YK39lVc7KJE2Mhmxq9yAp7E7Ythb3lmzI9TFLUpNQ2jQaIOL+HFeQUvcvN1mnV/crOLFEftNKzfQ2eX6ESoOOEV4qLNTRUIxrhho2W9wf+DZXbjiNb7ewgbjbm3txRuGR3R4pAcvHmbXNM3qNEx7GtoRdSzsURfRYNglao8+8q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=X/u2b6SJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768381438;
	bh=Bmm0bfKxZ+xyalDgjLpooMd2+oroWes+csIA7YD0GgI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X/u2b6SJCtcwt9Bho1PZTO40juQP1tyyx1u38RDQ7fr6ngfDMuar6iImWPTI/oN6j
	 xzTvyj/yGiMtvpRMUcQLHQvyMdud06q2FEBWS6ij055CR/AA1YFcAZ7qTgw6SHD5eh
	 R2DbDxDytSJK6rKK/FSI8O+EFI392WyPQ7/28wHwbbDSDccYA5xYu1TcBoYRqhMD8N
	 N8HYGLbav2Kx+1mVIWh+Ra0T0CMqpAuSYGMP9kcJotJn0imGx0pTmJFkSPcthwuCNd
	 KNkjBohB4PL2HgZNpQ0SqAWj4QNvRNEgeRHU8/0jFgDN3+HL2HNAmMlfDN4V80ae8z
	 1bADCDusEVD0w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 86CFF17E13C3;
	Wed, 14 Jan 2026 10:03:57 +0100 (CET)
Message-ID: <401c5e7b-ff33-44e8-98a5-8cc6af4f2a87@collabora.com>
Date: Wed, 14 Jan 2026 10:03:57 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/10] nvmem: qcom-spmi-sdam: Migrate to
 devm_spmi_subdevice_alloc_and_add()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 srini@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org,
 sre@kernel.org, sboyd@kernel.org, krzk@kernel.org,
 dmitry.baryshkov@oss.qualcomm.com, quic_wcheng@quicinc.com,
 melody.olvera@oss.qualcomm.com, quic_nsekar@quicinc.com,
 ivo.ivanov.ivanov1@gmail.com, abelvesa@kernel.org, luca.weiss@fairphone.com,
 konrad.dybcio@oss.qualcomm.com, mitltlatltl@gmail.com,
 krishna.kurapati@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, kernel@collabora.com
References: <20260114083957.9945-1-angelogioacchino.delregno@collabora.com>
 <20260114083957.9945-6-angelogioacchino.delregno@collabora.com>
 <aWdaWY2tWUMllOHH@smile.fi.intel.com>
 <8bf79979-0946-4ed9-b8d4-c442a6e54833@collabora.com>
 <aWdbPze-f_2_5EbL@smile.fi.intel.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <aWdbPze-f_2_5EbL@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 14/01/26 10:00, Andy Shevchenko ha scritto:
> On Wed, Jan 14, 2026 at 09:59:40AM +0100, AngeloGioacchino Del Regno wrote:
>> Il 14/01/26 09:56, Andy Shevchenko ha scritto:
>>> On Wed, Jan 14, 2026 at 09:39:52AM +0100, AngeloGioacchino Del Regno wrote:
>>>> Some Qualcomm PMICs integrate a SDAM device, internally located in
>>>> a specific address range reachable through SPMI communication.
>>>>
>>>> Instead of using the parent SPMI device (the main PMIC) as a kind
>>>> of syscon in this driver, register a new SPMI sub-device for SDAM
>>>> and initialize its own regmap with this sub-device's specific base
>>>> address, retrieved from the devicetree.
>>>>
>>>> This allows to stop manually adding the register base address to
>>>> every R/W call in this driver, as this can be, and is now, handled
>>>> by the regmap API instead.
> 
> ...
> 
>>>> +	struct regmap_config sdam_regmap_config = {
>>>> +		.reg_bits = 16,
>>>> +		.val_bits = 8,
>>>
>>>> +		.max_register = 0x100,
>>>
>>> Are you sure? This might be a bad naming, but here max == the last accessible.
>>> I bet it has to be 0xff (but since the address is 16-bit it might be actually
>>> 257 registers, but sounds very weird).
>>
>> Yes, I'm sure.
> 
> So, what is resided on address 0x100 ?
> 

I don't remember, this is research from around 5 months ago, when I've sent
the v1 of this.

If you really want though, I can incorrectly set max_register to 0xff.

Cheers,
Angelo

>>>> +		.fast_io = true,
>>>> +	};
> 
> 


