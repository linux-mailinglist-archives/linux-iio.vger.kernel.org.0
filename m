Return-Path: <linux-iio+bounces-21822-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A8AB0C455
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 14:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68D8B7ACC88
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 12:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74832BFC65;
	Mon, 21 Jul 2025 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kSPo9cv7"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1DE4502F;
	Mon, 21 Jul 2025 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753101968; cv=none; b=J7UQQbdoKY26z0zTOSKv2BG/3RT3DajMqj5cOO4DxN1ojgVHugr6NslpgizKW0QEE6tH8ml/HBndHLOoTqC2g561+g9h6YKTj0XoVD5sbbrg1Wd0zxohZJMDyzwJqbiWXuw/mp4LPN1re+45QW4FSgpV9spJiF5EC2DzM5P/HjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753101968; c=relaxed/simple;
	bh=WGUQgDlE1s2YTapj41wUMa0BgEKsNgWIMJNz10NotwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOpX2dO0Im+6qwpknhtgLJX2nygwMqgzmEEY2dS+s44YpRLx5T6WxCfeF/OlaFZKZnOTbzUaZSCCgWPAu9sDXV12aCLT38RxNopGq+MRRU1n+6pH1EV8SLjeYII13O1GwG1GIkfydu8GjS4a063SpNBN+crwPaBENz61ShKb/50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kSPo9cv7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753101960;
	bh=WGUQgDlE1s2YTapj41wUMa0BgEKsNgWIMJNz10NotwM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kSPo9cv75vw9UZ0CR4OLbjZU8t3subAZ5maiKshA0TNSuGgefVTXxIYzo/HTqAlgl
	 LIyQd3zMu9eP/O31LM7EpmNAo7PT495/rRzlRj82cqeKI/VrrXYPFmxeiLrX6PuuIP
	 FCR9FhRLbhFcUXn4dj+LLZYLFUw9GKsIwj9PUOM2iGTpKqPdSIXa/f18ZCZA86UKME
	 +Z9Ijtncdp/ontJplBRxZ1+jGDXvsgzV1EH1u0r6UTWn6d68hOKx4jkrUJoRPRYeOd
	 GyogLDsta52fywRoObfEo9lSGMyOW6s0xxYE1qPFDVgWDaYnWQfFay4V3JnABrkBmc
	 u7FkwJT88NMNw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 53ADF17E0CA1;
	Mon, 21 Jul 2025 14:45:59 +0200 (CEST)
Message-ID: <b06969d2-0c35-44c7-bb2c-162942186c53@collabora.com>
Date: Mon, 21 Jul 2025 14:45:58 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/7] nvmem: qcom-spmi-sdam: Migrate to
 devm_spmi_subdevice_alloc_and_add()
To: Casey Connolly <casey.connolly@linaro.org>, sboyd@kernel.org
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 srini@kernel.org, vkoul@kernel.org, kishon@kernel.org, sre@kernel.org,
 krzysztof.kozlowski@linaro.org, u.kleine-koenig@baylibre.com,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-pm@vger.kernel.org, kernel@collabora.com, wenst@chromium.org
References: <20250721075525.29636-1-angelogioacchino.delregno@collabora.com>
 <20250721075525.29636-3-angelogioacchino.delregno@collabora.com>
 <e724e6a2-21a8-436a-8809-ce73c0afa433@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <e724e6a2-21a8-436a-8809-ce73c0afa433@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/07/25 12:44, Casey Connolly ha scritto:
> Hi Angelo,
> 
> On 21/07/2025 09:55, AngeloGioacchino Del Regno wrote:
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
> This is honestly a really nice improvement :D>

Thanks! :-D

>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/nvmem/qcom-spmi-sdam.c | 41 +++++++++++++++++++++++++---------
>>   1 file changed, 30 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/nvmem/qcom-spmi-sdam.c b/drivers/nvmem/qcom-spmi-sdam.c
>> index 4f1cca6eab71..1b80e8563a33 100644
>> --- a/drivers/nvmem/qcom-spmi-sdam.c
>> +++ b/drivers/nvmem/qcom-spmi-sdam.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/nvmem-provider.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/regmap.h>
>> +#include <linux/spmi.h>
>>   
>>   #define SDAM_MEM_START			0x40
>>   #define REGISTER_MAP_ID			0x40
>> @@ -20,7 +21,6 @@
>>   struct sdam_chip {
>>   	struct regmap			*regmap;
>>   	struct nvmem_config		sdam_config;
>> -	unsigned int			base;
>>   	unsigned int			size;
>>   };
>>   
>> @@ -73,7 +73,7 @@ static int sdam_read(void *priv, unsigned int offset, void *val,
>>   		return -EINVAL;
>>   	}
>>   
>> -	rc = regmap_bulk_read(sdam->regmap, sdam->base + offset, val, bytes);
>> +	rc = regmap_bulk_read(sdam->regmap, offset, val, bytes);
>>   	if (rc < 0)
>>   		dev_err(dev, "Failed to read SDAM offset %#x len=%zd, rc=%d\n",
>>   						offset, bytes, rc);
>> @@ -100,7 +100,7 @@ static int sdam_write(void *priv, unsigned int offset, void *val,
>>   		return -EINVAL;
>>   	}
>>   
>> -	rc = regmap_bulk_write(sdam->regmap, sdam->base + offset, val, bytes);
>> +	rc = regmap_bulk_write(sdam->regmap, offset, val, bytes);
>>   	if (rc < 0)
>>   		dev_err(dev, "Failed to write SDAM offset %#x len=%zd, rc=%d\n",
>>   						offset, bytes, rc);
>> @@ -110,28 +110,47 @@ static int sdam_write(void *priv, unsigned int offset, void *val,
>>   
>>   static int sdam_probe(struct platform_device *pdev)
>>   {
>> +	struct regmap_config sdam_regmap_config = {
>> +		.reg_bits = 16,
>> +		.val_bits = 16,
> 
> I believe registers are 8 bits wide, at least on Qualcomm platforms.
> 

I used 16 because usually that's the usual default for SPMI - but if you're sure
about Qualcomm platforms having 8-bits wide registers and you can confirm that,
I can change both of those to 8 in a jiffy.

I anyway have to send a v2 because I forgot an error check - so changing this is
not a problem at all for me.

But.

Before me changing - can you please please please double check and confirm?

If you can also check the register width of the others that I converted, I'd really
appreciate that (I have no datasheets for qcom so it's a bit of a guessing game for
me here... :-P), just so that we get everything right from the get-go ... even if
a mismatch wouldn't really cause issues in the current state of things.

That's because - I just noticed - in qcom-spmi-pmic.c, reg_bits is 16, but val_bits
is 8 (which basically means "the registers are 16-bits wide, but we always only
care about the lower 8 bits).

Thanks again!

Cheers,
Angelo

