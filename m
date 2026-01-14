Return-Path: <linux-iio+bounces-27710-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2C0D1D59D
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A8413091BD4
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 09:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5025537F102;
	Wed, 14 Jan 2026 08:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lAqkVuls"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673DB37FF70;
	Wed, 14 Jan 2026 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768381191; cv=none; b=UzagTAhicCddprblMTltVqHTsDEHX4lLNp8TSXuwdm6ocRisufLtz2SHsrWedpbL0aSXQF3wpa4QdDopPU4O8oQRaAbNs1Ms7/HXv0LUzZFPbXrehGc1qZ08k6DHBiuD2fdJuxnl7HZbOFILVEIKu48mSPTxxDayYYUzDTFhH3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768381191; c=relaxed/simple;
	bh=8hZT4zra/v0163hZ69ozogA/KUazMXg9TgoP6Ded9M0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AqkgqwKcYTzVsddu2xwalhr5zfElYJvx57ejLaxGaHPhSUgdZiX6GyRl73xhAlJ4msibqAhZjMfBf63VY4AshY/gYlG3wG3UkhmauoJLUY6pHDPEgxCDcOxKrZMdyiRR9MTntczxCEvyj/RQk51jv7I9peu96w0m2Rs+k7Kpfao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lAqkVuls; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768381182;
	bh=8hZT4zra/v0163hZ69ozogA/KUazMXg9TgoP6Ded9M0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lAqkVuls+rU3h7w+XRLmkzVTJ4PfIEHQ0cf+BP8u8Es599RGdgXhjRS7YT4NGD5HG
	 d3y6Egd9MHe67Zhc+Q3f0kz1O3t3l9cEtaLhOfH0W7RYW6LPJKhbe25tWGafnNHnbP
	 4D6Z3JFAR3Vp47EY19uZPhg/Q9StxkLlxto3SYzY63hIMiBowuh0Aav6HkIsDrGyVS
	 i73E2OJ3pY04eXmWY/k1uJ6GkdMEzyQ6+TH9xbuKbvy3d3VV79MUAl0HNTZhWlCVA1
	 ow0fqwv2EhQhC+3h24NX7na8zcdyR+v/FQKQ6Dol8u0kKQ20UvaiuKeSDHp919MD96
	 qCYJNOOackq6Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 79CFF17E1416;
	Wed, 14 Jan 2026 09:59:41 +0100 (CET)
Message-ID: <8bf79979-0946-4ed9-b8d4-c442a6e54833@collabora.com>
Date: Wed, 14 Jan 2026 09:59:40 +0100
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
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <aWdaWY2tWUMllOHH@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 14/01/26 09:56, Andy Shevchenko ha scritto:
> On Wed, Jan 14, 2026 at 09:39:52AM +0100, AngeloGioacchino Del Regno wrote:
>> Some Qualcomm PMICs integrate a SDAM device, internally located in
>> a specific address range reachable through SPMI communication.
>>
>> Instead of using the parent SPMI device (the main PMIC) as a kind
>> of syscon in this driver, register a new SPMI sub-device for SDAM
>> and initialize its own regmap with this sub-device's specific base
>> address, retrieved from the devicetree.
>>
>> This allows to stop manually adding the register base address to
>> every R/W call in this driver, as this can be, and is now, handled
>> by the regmap API instead.
> 
> ...
> 
>> +	struct regmap_config sdam_regmap_config = {
>> +		.reg_bits = 16,
>> +		.val_bits = 8,
> 
>> +		.max_register = 0x100,
> 
> Are you sure? This might be a bad naming, but here max == the last accessible.
> I bet it has to be 0xff (but since the address is 16-bit it might be actually
> 257 registers, but sounds very weird).
> 

Yes, I'm sure.

>> +		.fast_io = true,
>> +	};
> 
> ...
> 
>> +	rc = of_property_read_u32(dev->of_node, "reg", &sdam_regmap_config.reg_base);
> 
> Why not device_property_read_u32(dev, ...) ?
> 
> ...
> 
>> +	sdam->regmap = devm_regmap_init_spmi_ext(&sub_sdev->sdev, &sdam_regmap_config);
>> +	if (IS_ERR(sdam->regmap))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(sdam->regmap),
> 
> You have "dev".
> 
>> +				     "Failed to get regmap handle\n");
> 

For the other comments: Done in v8.

Cheers,
Angelo

