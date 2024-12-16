Return-Path: <linux-iio+bounces-13535-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC3E9F2BA7
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 09:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310551885C4E
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 08:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AD91FF7C1;
	Mon, 16 Dec 2024 08:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOhHFJma"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7248D1D318F;
	Mon, 16 Dec 2024 08:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734337135; cv=none; b=joqj1dyTKrqPvFUkDIbdjbprFoMVgQrJpbRCyLrUmlDMW7TEUjfUvzWjtReCcyjrEyYj/4nfakvN+BJ/VcT/rfa7MCSwsCG22j56k/mQf64FQ23zVB53855n9rSo8eToc09Blxe8WC93yqWvQMJjwW33EnWwyc/0QmvEdoHuAtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734337135; c=relaxed/simple;
	bh=VLDBFoXfvZEXFdP5zRERbJJkMvmfC2f5jtSS0Y1Afdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJmUyEdyPaT7n5np3Cwp+ZfgElD3NhiL0cecRGuBnSiZOo3dI5LBv6M9LZZS0c7shcbKW6ybnpqSF4+WrAh5tW5urHlCKeLsfHanPAIsJu6GM7PM2u7EfKKaIAkFSKlRYU2NXGNpx6hFsLmW8RN1eJ2BDCw0b+gqLas7ODLxf8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOhHFJma; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21564262babso4861095ad.3;
        Mon, 16 Dec 2024 00:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734337133; x=1734941933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=86o4ynhOavyPlFdh+OIw8szkaSSkef/OgqQcYpbsDjU=;
        b=bOhHFJmaxdAGHLN6monfEA5LuBA76cCvqNfDsOMebQEoaLttB6c7NBbi6Xz2gZgGtq
         1iw+9kRpC0D2w741F939qFfccbh/1rcC9enT5+hyRGsOT9ru37oNooo8+xhIciCJW0Sg
         F55xO9Ztzfutz9mS2s0RKaNRm1of+ooCXbe7m5td2f2EQ6pVEEaHCI4FlUGgrT9pdjzy
         IAhkxUEBVA0zNRrkrpCkRlBiut3eVHNrHgCzkA7Q08O0CLkYOMYMECLZNB+8tAOKuCmM
         IhwnaLSGi2KB66lz5wWLD2xO31A6WOcg1MHUjCgz6Cvf6TzxQ9E2tjSBxeKKL4SPF+Be
         kpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734337133; x=1734941933;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=86o4ynhOavyPlFdh+OIw8szkaSSkef/OgqQcYpbsDjU=;
        b=uCgcIvEcXlc2wf/yFVu2GSOfXTzjaz4vauVSOzqLpQU7QRw30ukERvwhkLhMhtcxPY
         vcL3X4UB/6bSE5cyY5thj9lY7cYgFbxMXoH2t/ajtyxHeFIy1cD+0Ow5hI54rcdfzOSr
         2jwTc9o0odn0LRs7wW1o9NFWmeAErPryh2XCEw1CRqc1jmwxr07dXNm5rZyVnQafUKpb
         Vbtf5A4my7wPviWA3S+okb8nhLx6hz7ZY0NC6j4Cl4Bb2NUfC7NJ5h+w6oysl3CSsAbY
         BKuMglN9Hbxhra63JhelTtuMpHNrKZbn9jhb08nVXGB4yowEiW4EBhrjDRwlO2NSc0Ez
         f6jw==
X-Forwarded-Encrypted: i=1; AJvYcCU/cExnjkc2nJfZri2+NhbxtazRFbmQo6WwNuevNyIoqedT7yAGGvOG1wrkeDxoWbrfQ5A/0dpLlWwH@vger.kernel.org, AJvYcCVSiNUEDCmFUc2kgaCdJQ7Zu0YzpeQDwRHRbCrIbb/dAY5tim+47KKBVjEUqefDC/ft7D5iRJZdnPMGLBbV@vger.kernel.org, AJvYcCWso0nvcAQl1mL2lsZP4V6fGTxu+aDQI3SxCZwSJWplBO6/ogiem/eDVxcPWGR0NFgsE0+foDmVbZvBy6Wnx3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YycZqwsnNzFSrXd6Pt6ciQfCCgY2GDEm0CC2iOWMvVXROhE/kkD
	3rNnpGWSMKz2ciYpG9cVNzfds3cMD/gFUHKBGc9JOY43f61ckCOk
X-Gm-Gg: ASbGncu6vCMR+H76aHwMUKhevVkpcSkX5K1/MQ3uiGNDIXtnUzuxiXoT95Gy7KJvBCH
	SSd5Ndj8Ij+fIvO94BHbInLmZZHeKf2yjrkK6Xa4CD65zlyDnWHoDHG1+GtywiESb4CnTywnhDe
	WUTwcBSAkoDMFt1/Jle3qeS3mhZWEudK3mL40ZXrmIxo0zUdw2EhISeJVOGwsZb0SyZgPHpSMqv
	oDN5HaWGrL3PnulfItDCd9r1aIo/y2p/7/Q/YzMxThLwc+Tbe65sS1gXtDCZ2tR
X-Google-Smtp-Source: AGHT+IELD3cahoTCtVuK1cg9LyRlcUjavMn8fnBjdQ8mMrTC8rsrYcEADOBuwBW96o4BdVpruWV8KA==
X-Received: by 2002:a17:902:f54c:b0:215:5f17:4296 with SMTP id d9443c01a7336-21892a3fb95mr58866385ad.8.1734337132661;
        Mon, 16 Dec 2024 00:18:52 -0800 (PST)
Received: from [100.116.227.126] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e6d0fesm37335225ad.256.2024.12.16.00.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 00:18:51 -0800 (PST)
Message-ID: <aee7f90e-a4af-4cc8-b2e7-c895a8aa6db2@gmail.com>
Date: Mon, 16 Dec 2024 16:18:45 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: proximity: hx9023s: Added firmware file parsing
 functionality
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, yasin.lee.x@outlook.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20241210-hx9023s-firmware-20241209-v1-1-8a736691b106@gmail.com>
 <20241215122553.60c2caba@jic23-huawei>
Content-Language: en-US
From: Yasin Lee <yasin.lee.x@gmail.com>
In-Reply-To: <20241215122553.60c2caba@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/15/24 20:25, Jonathan Cameron wrote:
> On Tue, 10 Dec 2024 12:24:03 +0800
> Yasin Lee <yasin.lee.x@gmail.com> wrote:
>
>> Configuration information is now prioritized from the firmware file.
>> If the firmware file is missing or fails to parse, the driver falls
>> back to using the default configuration list for writing the settings.
>>
>> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
> Ok.  I guess just reading a load of register values isn't hugely different
> to more complex firmware loads.
>
> Comments inline - in particular please take the time to tidy up
> formatting of your code before posting.
>
> Also why is this +CC linux-hardening, Kees and Gustavo?
>
> They have enough stuff to do without getting patches that seem to have nothing
> to do with hardening!
>
> Jonathan
>
Hi Jonathan,

Thank you for your detailed feedback on my patch. I’ve carefully 
reviewed and addressed all the issues you highlighted:
1. Simplified the return value handling in hx9023s_bin_load to directly 
return 0 where applicable.
2. Corrected all indentation and alignment issues to conform to the 
Linux kernel coding standards.
3. Improved log messages to clearly inform users of specific reasons for 
firmware load failure.
4. Removed irrelevant recipients, such as linux-hardening, from the CC list.

Best regards,
Yasin Lee

>> ---
>>   drivers/iio/proximity/hx9023s.c | 96 ++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 89 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
>> index 4021feb7a7ac..6cb1b688bfa9 100644
>> --- a/drivers/iio/proximity/hx9023s.c
>> +++ b/drivers/iio/proximity/hx9023s.c
>> @@ -14,6 +14,7 @@
>>   #include <linux/cleanup.h>
>>   #include <linux/device.h>
>>   #include <linux/errno.h>
>> +#include <linux/firmware.h>
>>   #include <linux/i2c.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/irqreturn.h>
>> @@ -100,6 +101,17 @@
>>   #define HX9023S_INTERRUPT_MASK GENMASK(9, 0)
>>   #define HX9023S_PROX_DEBOUNCE_MASK GENMASK(3, 0)
>>   
>> +#define FW_VER_OFFSET 2
>> +#define FW_REG_CNT_OFFSET 3
>> +#define FW_DATA_OFFSET 16
>> +
>> +struct hx9023s_bin {
>> +	u16 reg_count;
>> +	u16 fw_size;
>> +	u8 fw_ver;
>> +	u8 data[] __counted_by(fw_size);
>> +};
>> +
>>   struct hx9023s_ch_data {
>>   	s16 raw; /* Raw Data*/
>>   	s16 lp; /* Low Pass Filter Data*/
>> @@ -998,6 +1010,80 @@ static int hx9023s_id_check(struct iio_dev *indio_dev)
>>   	return 0;
>>   }
>>   
>> +static int hx9023s_bin_load(struct hx9023s_data *data,
>> +								struct hx9023s_bin *bin)
>> +{
>> +	u8 *cfg_start = bin->data + FW_DATA_OFFSET;
>> +	u8 addr, val;
>> +	u16 i;
>> +	int ret;
>> +
>> +	for (i = 0; i < bin->reg_count; i++) {
>> +		addr = cfg_start[i * 2];
>> +		val = cfg_start[i * 2 + 1];
>> +		ret = regmap_write(data->regmap, addr, val);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
>> +
>> +	return ret;
> return 0;
> Can't get here with anything else.
>
>> +}
>> +
>> +static int hx9023s_send_cfg(const struct firmware *fw,
>> +								struct hx9023s_data *data)
>
> Fix all your indenting to match kernel style.
>
>> +{
>> +	if (!fw)
> You can't get to this call below with out fw so drop this check.
>
>> +		return -EINVAL;
>> +
>> +	struct hx9023s_bin *bin __free(kfree) =
>> +		kzalloc(fw->size + sizeof(*bin), GFP_KERNEL);
>> +	if (!bin)
>> +		return -ENOMEM;
>> +
>> +	memcpy(bin->data, fw->data, fw->size);
>> +	release_firmware(fw);
>> +
>> +	bin->fw_size = fw->size;
>> +	bin->fw_ver = bin->data[FW_VER_OFFSET];
>> +	bin->reg_count = get_unaligned_le16(bin->data + FW_REG_CNT_OFFSET);
>> +
>> +	return hx9023s_bin_load(data, bin);
>> +}
>> +
>> +static void hx9023s_cfg_update(const struct firmware *fw, void *context)
>> +{
>> +	struct hx9023s_data *data = context;
>> +	struct device *dev = regmap_get_device(data->regmap);
>> +	int ret;
>> +
>> +	if (!fw || !fw->data) {
>> +		dev_warn(dev, "No firmware\n");
>> +		goto no_fw;
>> +	}
>> +
>> +	ret = hx9023s_send_cfg(fw, data);
>> +	if (ret)
> If this fails, we want to notify the user.  The firmware loaded
> but we were unable to use it for some reasons.
>
>> +		goto no_fw;
>> +
>> +	ret = regcache_sync(data->regmap);
>> +	if (ret)
>> +		dev_err(dev, "regcache sync failed\n");
>> +
>> +	return;
>> +
>> +no_fw:
>> +	ret = regmap_multi_reg_write(data->regmap, hx9023s_reg_init_list,
>> +								ARRAY_SIZE(hx9023s_reg_init_list));
>> +	if (ret) {
>> +		dev_err(dev, "Error loading default configuration\n");
>> +		return;
>> +	}
>> +
>> +	ret = regcache_sync(data->regmap);
>> +	if (ret)
>> +		dev_err(dev, "regcache sync failed\n");
>> +}
>> +
>>   static int hx9023s_probe(struct i2c_client *client)
>>   {
>>   	struct device *dev = &client->dev;
>> @@ -1036,18 +1122,14 @@ static int hx9023s_probe(struct i2c_client *client)
>>   	indio_dev->modes = INDIO_DIRECT_MODE;
>>   	i2c_set_clientdata(client, indio_dev);
>>   
>> -	ret = regmap_multi_reg_write(data->regmap, hx9023s_reg_init_list,
>> -				     ARRAY_SIZE(hx9023s_reg_init_list));
>> -	if (ret)
>> -		return dev_err_probe(dev, ret, "device init failed\n");
>> -
>>   	ret = hx9023s_ch_cfg(data);
>>   	if (ret)
>>   		return dev_err_probe(dev, ret, "channel config failed\n");
>>   
>> -	ret = regcache_sync(data->regmap);
>> +	ret = request_firmware_nowait(THIS_MODULE, true, "hx9023s.bin",
>> +						dev, GFP_KERNEL, data, hx9023s_cfg_update);
> Indent dev under T of the THIS_MODULE
>
>
>>   	if (ret)
>> -		return dev_err_probe(dev, ret, "regcache sync failed\n");
>> +		return dev_err_probe(dev, ret, "reg config failed\n");
>>   
>>   	if (client->irq) {
>>   		ret = devm_request_threaded_irq(dev, client->irq,
>>
>> ---
>> base-commit: 8d4d26450d71289a35ff9e847675fd9c718798b8
>> change-id: 20241209-hx9023s-firmware-20241209-47411e8cda0b
>>
>> Best regards,

