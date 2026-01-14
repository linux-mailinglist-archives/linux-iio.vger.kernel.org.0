Return-Path: <linux-iio+bounces-27719-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCBBD1D740
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B6E43014608
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 09:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0985F3816E0;
	Wed, 14 Jan 2026 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mAi6pcvA"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8595636D4FB;
	Wed, 14 Jan 2026 09:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768381789; cv=none; b=qMrDAqqFwi0gx14Wx95C+pdvZQ6qW35IrkJ18QE+0kWYe4PHXyrqyoA8U6wCiYZiW2EkiWnDEs+3fTy2sh97JBUSXvkohWwoE3kaRmNMgX+o5nW6754OIDu6HWQikhFQXULZDASjM6OKee7K111N6Hifg3GjSc0XOmhAru2faHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768381789; c=relaxed/simple;
	bh=S696D/o/SmDuyHHVUz/db4ZX1yDLl8DiEZX+ZVrJT8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dVJEhD1wghAMMKVp3y3zDkB2pTD+hKbfecYzXTRpcqKQW41F1O6ltie5UnslVteQeNLFAn8Dp4RmzNd8XHbbbHGNJY1SpRhxpnR6quJXGjYGpYPbwAdyR5Prcu9mrcxMuKyzXsEDsHXIUwdc5GYln3OnXpMTuDajK4HAjFO2I7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mAi6pcvA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768381787;
	bh=S696D/o/SmDuyHHVUz/db4ZX1yDLl8DiEZX+ZVrJT8A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mAi6pcvA+pcWkAnf8KWCQzsHZ/kxE90P+qmo/GY3FotQTzx/2NFnieaDFkPSBSIm3
	 Bme93Ye4yrwZh73GV33CWAMgulP2daIjLMo1fOY2XdktNYhp0VkaJev1vy/E285X6w
	 N2Q+OrR/jUhUSUl9WdSUM2apDpwVIxuLqE6tNRUdt5U5RcaYXoBV2bBm7LXARHt5fb
	 gZvAetbLPlm+x8wcTb8DvjmrcW7wQy9DDY42H6M/h9BWr/Ge3dv/ntjUqy1el1Dm+L
	 GFEP3U3I6IQnKY8944gzImaGwYFNXI/y++qhq41IVerqRXZVcLGB/jpIdW17vZ47J5
	 zULJiOvR66Ylw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F1DD917E13C3;
	Wed, 14 Jan 2026 10:09:45 +0100 (CET)
Message-ID: <647b4acc-3310-4329-ac7a-77e86bab74a3@collabora.com>
Date: Wed, 14 Jan 2026 10:09:45 +0100
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
 <401c5e7b-ff33-44e8-98a5-8cc6af4f2a87@collabora.com>
 <aWdcy2ouQHtkPd6q@smile.fi.intel.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <aWdcy2ouQHtkPd6q@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 14/01/26 10:07, Andy Shevchenko ha scritto:
> On Wed, Jan 14, 2026 at 10:03:57AM +0100, AngeloGioacchino Del Regno wrote:
>> Il 14/01/26 10:00, Andy Shevchenko ha scritto:
>>> On Wed, Jan 14, 2026 at 09:59:40AM +0100, AngeloGioacchino Del Regno wrote:
>>>> Il 14/01/26 09:56, Andy Shevchenko ha scritto:
>>>>> On Wed, Jan 14, 2026 at 09:39:52AM +0100, AngeloGioacchino Del Regno wrote:
> 
> ...
> 
>>>>>> +	struct regmap_config sdam_regmap_config = {
>>>>>> +		.reg_bits = 16,
>>>>>> +		.val_bits = 8,
>>>>>
>>>>>> +		.max_register = 0x100,
>>>>>
>>>>> Are you sure? This might be a bad naming, but here max == the last accessible.
>>>>> I bet it has to be 0xff (but since the address is 16-bit it might be actually
>>>>> 257 registers, but sounds very weird).
>>>>
>>>> Yes, I'm sure.
>>>
>>> So, what is resided on address 0x100 ?
>>
>> I don't remember, this is research from around 5 months ago, when I've sent
>> the v1 of this.
>>
>> If you really want though, I can incorrectly set max_register to 0xff.
> 
> Why incorrectly? Can you dig into the datasheet and check, please? We don't
> know what is the 0x100 address means.
> 

I don't have any datasheets for Qualcomm IPs.

Cheers,
Angelo

>>>>>> +		.fast_io = true,
>>>>>> +	};
> 


