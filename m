Return-Path: <linux-iio+bounces-27723-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F8DD1D88D
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 135B8307D812
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 09:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AC8381711;
	Wed, 14 Jan 2026 09:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jcbOyowt"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3921218AAD;
	Wed, 14 Jan 2026 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768382807; cv=none; b=R4oIu2mQCwRwB1tOBhIQR4rX3ua4AL3X+aH0XR9/pV0Q44XtVZp9bWh4dmj0osRDfgJgPEa1AMm7lHWq8p4mgKw5JAIHPgnVmqZQz+DStYgtML7QdX/WRhBDxUDhmHfye6vKtU3PDyNOI6hPk+T64hrBKfQ1kRDgtKf8U1NcdkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768382807; c=relaxed/simple;
	bh=7KqqY0DcTQx2Y9pyI1O7EpopUM96HNm4UmxlbgqHu4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=So1ybRhVd+OtTn20ui8HdlrjjDqKBOjXG6hv4Pe6JOEEbldEQPcttFJO5uKQbZKLce0JRtuJrRJtrouyb3nf5Lqr1gQevmogvn+fY65XdYVJkZYz4RSI9nM1do/9DgX41tZfZoIPV8sMXbqY3iouYW2zcGIzT4beeXkwzBUH2Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jcbOyowt; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768382804;
	bh=7KqqY0DcTQx2Y9pyI1O7EpopUM96HNm4UmxlbgqHu4U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jcbOyowt+fl649l9QQhwf3ZG+vjJgky2cuVsOexGOWmqwzSd3QikSmwPf6ZZwouQZ
	 mGfcFK5dIie5qMs8E3SOEnt4Mi5tZY272eZf5fAKQMMlYFKpKfyXAARfITzxFnY7TV
	 I76qHBgnKR3uxPUKB/kZy2GvPOkTREXYa5Uny9YQJEIwH5osSRWx2cBBj6HnaeHnau
	 JcH5VuDYiTK293jRyF3G2F31mdrA4y3xcZ259rv6oTlopJpyq73lV0++qpoHYBit8q
	 p9GoJqmaCE+zHsZyjrEUGlhnc3Dw/FwsxGsPYVIMsn8+gx/aSmm5pUcYbdCqx0LBfa
	 zYc2GYOuM/qQw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2B31F17E1406;
	Wed, 14 Jan 2026 10:26:43 +0100 (CET)
Message-ID: <8f5c79e0-5f7e-4fe4-b9d7-60375e779892@collabora.com>
Date: Wed, 14 Jan 2026 10:26:42 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/10] phy: qualcomm: eusb2-repeater: Migrate to
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
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
 kernel@collabora.com, Abel Vesa <abel.vesa@linaro.org>
References: <20260114083957.9945-1-angelogioacchino.delregno@collabora.com>
 <20260114083957.9945-8-angelogioacchino.delregno@collabora.com>
 <aWdbB4vJ6Z8k0g4s@smile.fi.intel.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <aWdbB4vJ6Z8k0g4s@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 14/01/26 09:59, Andy Shevchenko ha scritto:
> On Wed, Jan 14, 2026 at 09:39:54AM +0100, AngeloGioacchino Del Regno wrote:
>> Some Qualcomm PMICs integrate an USB Repeater device, used to
>> convert between eUSB2 and USB 2.0 signaling levels, reachable
>> in a specific address range over SPMI.
>>
>> Instead of using the parent SPMI device (the main PMIC) as a kind
>> of syscon in this driver, register a new SPMI sub-device for EUSB2
>> and initialize its own regmap with this sub-device's specific base
>> address, retrieved from the devicetree.
>>
>> This allows to stop manually adding the register base address to
>> every R/W call in this driver, as this can be, and is now, handled
>> by the regmap API instead.
> 
> Same comments and actually one more.
> 
> ...
> 
>> +	struct regmap_config eusb2_regmap_config = {
>> +		.reg_bits = 16,
>> +		.val_bits = 8,
>> +		.max_register = 0x100,
>> +		.fast_io = true,
>> +	};
> 
> This is third time of the same. Make it part of SPMI core and export to
> the users. Or are they semantically different like different slices?
> In that case you can export it under generic name like
> 
> 	spmi_default_slice_regmap_config
> 

There are more complicated devices around that I didn't port to the new
spmi subdevices, and I really don't want to make a default for now.

At least some of those need different params (including some MediaTek ones
that are not upstream yet).

Can we please let this in and *then* see how much can be commonized after
the majority of more complicated drivers are migrated in the future?

Regards,
Angelo

