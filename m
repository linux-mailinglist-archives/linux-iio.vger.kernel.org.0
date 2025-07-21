Return-Path: <linux-iio+bounces-21824-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4C8B0C4DC
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 15:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EEDF4E6E07
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 13:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449162D94B9;
	Mon, 21 Jul 2025 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="W8OHWg4f"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E115A2D8796;
	Mon, 21 Jul 2025 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753103152; cv=none; b=odfHVWegDN4nVz4R2NeGSb6qutuRUVdEgtQUBKfqUuE0odKLlo6m3DDpcYdIY5bXgL+LJwmul3KoE5p2bU61U9mFgAgHzpStrTtNNU/gA30FZ0coYW89HBvLnWmXKFvZ/Qu3muvT3InpwcunbpOsiv2K4g5WG8r7gBYQYhPgxgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753103152; c=relaxed/simple;
	bh=OIlx9pKjKSDXW0QMzNXy7DSCUmg3OANoDgc+VuAixnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U8Kuec0aN2NmxPLC3JoN9yuzwQlUt+/gL90WKOv4dXCKTpg9Kv039aIwnQAXeuP9C8m1toD93uJ5gXxXiZtFxUWhiRBao/m5k0McJfSQroI6fNxSoHenryx+ZtlXxh4FTntZjo15/wv5VAIdGQZlZuF5M1OcksHhd4HQ6furBzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=W8OHWg4f; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753103148;
	bh=OIlx9pKjKSDXW0QMzNXy7DSCUmg3OANoDgc+VuAixnk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W8OHWg4falXTWpT++f8ykVlCntZC6vbmYqgYY/tiGhDXWIFu05ZFdblOvZXrJJdru
	 4/zESCMEgCOINCgKuSwEykOIwYwox/q5nuGJX3Yxu8+h45DeY3nnMKteyVksSV0cFE
	 5FOF/u+abbESbi1+tGCXP/MOxdMA6RPvs+6prk9XLLq0bAhfpp0aqXz+xh85s7lxdI
	 XPvnkINMSVf5XAwqqpJprwP16xVrIrrjXw3m2KVx55NOd+iYv+ffyYsIb5NXL2y/1o
	 I3o14c/lHrwGjkV7xiiF+s24rQm8s7s1LguP6vVjsGHOs1zaE7MRmTIz1OvC/WzbJ4
	 OqF5IJBTbQDiw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0E25E17E0CA1;
	Mon, 21 Jul 2025 15:05:47 +0200 (CEST)
Message-ID: <f5d529c3-b898-48ac-8e5a-f587db72dc82@collabora.com>
Date: Mon, 21 Jul 2025 15:05:46 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/7] power: reset: qcom-pon: Migrate to
 devm_spmi_subdevice_alloc_and_add()
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
 <20250721075525.29636-4-angelogioacchino.delregno@collabora.com>
 <aH4mWfgQt_Q0O-7S@smile.fi.intel.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <aH4mWfgQt_Q0O-7S@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/07/25 13:36, Andy Shevchenko ha scritto:
> On Mon, Jul 21, 2025 at 09:55:21AM +0200, AngeloGioacchino Del Regno wrote:
>> Some Qualcomm PMICs integrates a Power On device supporting pwrkey
>> and resin along with the Android reboot reason action identifier.
>>
>> Instead of using the parent SPMI device (the main PMIC) as a kind
>> of syscon in this driver, register a new SPMI sub-device for PON
>> and initialize its own regmap with this sub-device's specific base
>> address, retrieved from the devicetree.
>>
>> This allows to stop manually adding the register base address to
>> every R/W call in this driver, as this can be, and is now, handled
>> by the regmap API instead.
> 
> ...
> 
>> +	struct regmap_config qcom_pon_regmap_config = {
>> +		.reg_bits = 16,
>> +		.val_bits = 16,
>> +		.max_register = 0x100,
>> +		.fast_io = true
> 
> Please, leave trailing comma in this and other similar cases.
> 

Oki, will do!

>> +	};
> 
> 
>>   	struct qcom_pon *pon;
>>   	long reason_shift;
>>   	int error;
> 
>> +	if (!pdev->dev.parent)
>> +		return -ENODEV;
> 
> You can start using
> 
> 	struct device *dev = &pdev->dev;
> 
> here and perhaps one may convert the rest to it...
> 
> ...
> 
>>   	error = of_property_read_u32(pdev->dev.of_node, "reg",
> 
> ...including, but not limited to, use of device_property_read_u32(dev, ...) here.
> 

I didn't do that for one single reason: I did not want to add noise to the commits
and wanted those to exclusively migrate the drivers to the new API, literally
without doing *anything* else unnecessary, even if I have located some almost
effortless improvements that I could've done to those drivers.

Please - I prefer to keep it this way: these are the first commits that add the
usage of the new functions and of the concept of SPMI subdevices, and I really
want those to contain just that and nothing else - because I suspect that these
will be taken as example and will be read by the next person that is implementing
a new SPMI (sub)driver or converting any remaining ones to subdevice.

Cheers,
Angelo

