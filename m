Return-Path: <linux-iio+bounces-21823-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183F2B0C4A4
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 15:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B13B1790EA
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 13:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66662D77F9;
	Mon, 21 Jul 2025 13:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YfBd131R"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A529158535;
	Mon, 21 Jul 2025 13:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102821; cv=none; b=WnbV+ob28yVNJYiFyYo3+nxykYJ/Kzgkqs3daKRVqmGNeiGky/KmUYa3SxvWXj5o2ISanBEesrbAC9d3aAap7XFe6Sz3v1ZG7KyWoGtpsXtiMYg1ThjA9AdsLc8z5GDIGe8CrrH++75vfCEuj2G5w2kHag40lqmefDokkuwijkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102821; c=relaxed/simple;
	bh=onM7/yXXPy0rj+kktsvtqW+dskVE/IL1W226F8FF398=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ldjio7PCMP2XpOjFa/msgxgaGucaf0PmPZqBojYGe/tcJCCchx5tY/ef0nEcY6ONJGM9LMY8nQDQCv2QZf+wqNPkcgcakeWidI1jQxS8B3TC0pL8ItLil1Ufw7FbFjgkc774hZ4IG5V8NEW718SgwFPUfCBbPeU0VVFjzrgQmmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YfBd131R; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753102815;
	bh=onM7/yXXPy0rj+kktsvtqW+dskVE/IL1W226F8FF398=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YfBd131RRhLqcHMO/9DBRhnsopOkDpwTVB8S0Lr0U/Ix7wq16RlG2EcpqKPNRnGX9
	 dvGGkzmOcl5DJYdiGk2aTJ60HVxgH4FLoisShh9SbofSB1IxXzGJy+2JKGwesarirp
	 VAgtFpXecyC6q8W8JUTCbfuINLHeCkhkJo2pNPAwLBA3dKePdMDNliDzMNKF0K67T2
	 pkp++VhOPaHmVN600g2Bmyw9pRGB2e6N0SCW4sC/LKZAVrEgzfGQIQ/DPAcp0jF86z
	 3y/C17t2npUbHF19zBvO9crGDXcXIhs2NKye3hUNc/W62M2B2smXPId/s4u4xO0vat
	 XGCXq/JVGT7LQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 940C517E0FA8;
	Mon, 21 Jul 2025 15:00:14 +0200 (CEST)
Message-ID: <cb34fd4e-d87a-4a98-b27e-93ecb851e85e@collabora.com>
Date: Mon, 21 Jul 2025 15:00:13 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/7] spmi: Implement spmi_subdevice_alloc_and_add() and
 devm variant
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: sboyd@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, srini@kernel.org, vkoul@kernel.org,
 kishon@kernel.org, sre@kernel.org, krzysztof.kozlowski@linaro.org,
 u.kleine-koenig@baylibre.com, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
 kernel@collabora.com, wenst@chromium.org
References: <20250721075525.29636-1-angelogioacchino.delregno@collabora.com>
 <20250721075525.29636-2-angelogioacchino.delregno@collabora.com>
 <aH4lwVpaiau1Ick3@smile.fi.intel.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <aH4lwVpaiau1Ick3@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/07/25 13:34, Andy Shevchenko ha scritto:
> On Mon, Jul 21, 2025 at 09:55:19AM +0200, AngeloGioacchino Del Regno wrote:
>> Some devices connected over the SPMI bus may be big, in the sense
>> that those may be a complex of devices managed by a single chip
>> over the SPMI bus, reachable through a single SID.
>>
>> Add new functions aimed at managing sub-devices of a SPMI device
>> spmi_subdevice_alloc_and_add() and a spmi_subdevice_put_and_remove()
>> for adding a new subdevice and removing it respectively, and also
>> add their devm_* variants.
>>
>> The need for such functions comes from the existance of	those
>> complex Power Management ICs (PMICs), which feature one or many
>> sub-devices, in some cases with these being even addressable on
>> the chip in form of SPMI register ranges.
>>
>> Examples of those devices can be found in both Qualcomm platforms
>> with their PMICs having PON, RTC, SDAM, GPIO controller, and other
>> sub-devices, and in newer MediaTek platforms showing similar HW
>> features and a similar layout with those also having many subdevs.
> 
> ...
> 
>>   EXPORT_SYMBOL_GPL(devm_spmi_controller_add);
> 
>> +EXPORT_SYMBOL_GPL(devm_spmi_subdevice_alloc_and_add);
> 
> I am wondering how hard to move these to a dedicated namespace.
> Basically you can define a default namespace, and at the same time
> add import to all (current) users.
> 

I can check if this can be done "relatively easily" (as in, if I can do that
without requiring "a hundred" immutable branches for every subsystem using
SPMI).

If turns out being feasible - I do actually like the idea so yes I'd be pleased
to do that... even though honestly it's completely out of scope for this series.

In case I can't - it's still something that can be done later.

> ...
> 
>> +	dev_set_name(&sdev->dev,
>> +		     "%d-%02x.%d.auto", sdev->ctrl->nr, sdev->usid, sub_sdev->devid);
> 
> No error check?
> 

Heh, whoops, forgot about it :-)

Thanks for catching that - adding the check for v2.

Cheers,
Angelo

