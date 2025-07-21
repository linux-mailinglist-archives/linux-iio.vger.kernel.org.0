Return-Path: <linux-iio+bounces-21826-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3BFB0C5A1
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 15:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F111F541944
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 13:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA4F2D9EDF;
	Mon, 21 Jul 2025 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WhYyygO8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739622D97AC
	for <linux-iio@vger.kernel.org>; Mon, 21 Jul 2025 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106219; cv=none; b=GiKY27XX7TBZurWXYhsSE949W2c1g255bIIiWikhjj5rElktiZGA5J1frMMMAMWCpgf4AmWIe7G7wbjuBPuErL1DrrppoWWq8/okR3d1vowQ1u0IpeNaS94LOHYgPDQSMmZro7km/KEI57jexFWflvDoFMeKzxYta5eqM2c9NIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106219; c=relaxed/simple;
	bh=rHLuKPZS15Ci3FRNHUt3wjlIpfOccnEveLsn8wj5Hzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iYmZfVoFlbFEnDIkHAql6Zk5pGfo9H7Lebu4YBDOKrxWygBtpENL6O4z9UOsuJXsyFiSR6RqD6DOkQx65xThfvKYE9yVjnvbL0w3duc1OhMKhhVsEdSDc6+UAYvzPAj2XGsHdqGHBdgRNA4pizprOXvLBoDFUb+M70UZxAXituk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WhYyygO8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45555e3317aso25567295e9.3
        for <linux-iio@vger.kernel.org>; Mon, 21 Jul 2025 06:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753106216; x=1753711016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JHT+Ky9a2/UvB6vMaIGkjzmNbUyHiZwcZw1UdHqqBQM=;
        b=WhYyygO8jgGzYI+zkSc+DW7KHpdJolupUWNMnoXZO9w4t/kEKBLwxtsEYKC918bc9W
         yOtksjzd+qwKmn2sVZ+nvf2nHjSGq4459z6ls0xJ3XIuHTFUPESfb1Ac3gRVmEA1WRiT
         q5Mvj5yyFsY3d/8cCcukAD7Yzg/SPYsnWK8rwyCzICQilZMpc7uFnicEXh0vdAoVJ3VJ
         kFNFiRvuHR3oGrn8RQtJokNY+7/QkAurx5uB3nFqUYf7T0/MYolXouQCUt/nJgc+dBKT
         Nqib2YMojLqI2lRu3MjuKC3dZvWlroLH32cAWKLZZmIAphW5A89lJmJdR4m2n0D/KFNM
         xaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753106216; x=1753711016;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JHT+Ky9a2/UvB6vMaIGkjzmNbUyHiZwcZw1UdHqqBQM=;
        b=UH3dRYe5pyvwivjVHd/3saCtYDLs+LsmCA5glvoMOuD77vXYtBvZHwcdSeZDiemx1R
         FxyIOrPghqnJ/0T1cOrDLnc8hM0CcCU+PoSYPJi4R9ZVPkxHXz6H0ElSPXLZuzhB2EQV
         I73dmEQlNCoqa+pajumf+GD2kHQO39uiqpHtf41bEV4znw952KeW4ol83HXdg5E+jReC
         JkXpq56yyQgkXmdQI3gjdnNgLBhBAHxh9GVfN7iEEDd1EA957ZrCvJsPWL/zF9EPDtuL
         O9h+8Jym3vp1hgFT/DYY8kz6ocNkumYS9dE+CpEiwD+JFD0cvv7wBWYMxcbuLw5M6w5c
         X1NA==
X-Forwarded-Encrypted: i=1; AJvYcCVvEf5fF7soEzbYoEfymJIRUO12hnKKg/hqOKZYz0Vh6ZN7ne5XothKlaELUM41XsUBtSdGEBXtBdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDJ5yrRtWoO7GdBgKooylGE21Rgfak1RSbL7ce9iSGUvb7Vs1w
	M7Xp9lIHKYh7zOtC+5sCz6tx+KhBtopy3DdVfcOrqYCFU4wLz6SUuShx0e3MQPGfiGc=
X-Gm-Gg: ASbGncvMR9Y/2Od1A1OLeIVttbaWNrj0lxU7JfJ6ycCO5Z6FkKDXJCb1iNnL8kNB0H3
	ViznubZrp8TCw5iNIOPFqL42DJ0BANdrwxizNLybxUi+wZqQt8I0cBgKMSDatCZpQ6VPDditajS
	WkEHvRpEsbHLCglBlbk3Kw5opvxksLogwvvhdiOEnlalNf3RDqXMpvRk7aCb6iVx12da0JyxB1W
	iSGnJyee8OZluPbsIg37KKqVIvJ5HpND3+B7DuCTJ0MF1oRuIPr04jK9x18JpppcITF3TgxPlIV
	XwI3x3slijCF07ywH7vjBgW002cVi7XldLC+Nat8izIM6GIW6/YzrRVMMlv5Rahnvlm4iARvCOu
	vdrR/hr4nr9+gQyyLa9cRpPMWSZzgfCNgW5FVtMSbI3EDSYdrOinbPF1vGi0/imY=
X-Google-Smtp-Source: AGHT+IEnENRwxRTagl2ObT85GvHrjPuSySOktSH3L1SkrP+cMadSvWvWuVZBD4+Hw6mPbY0X9wHrDg==
X-Received: by 2002:a05:600c:4706:b0:456:19eb:2e09 with SMTP id 5b1f17b1804b1-4562edaa08cmr189313405e9.8.1753106215717;
        Mon, 21 Jul 2025 06:56:55 -0700 (PDT)
Received: from [192.168.1.36] (p549d4bd0.dip0.t-ipconnect.de. [84.157.75.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b74f9c0sm102889435e9.28.2025.07.21.06.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 06:56:54 -0700 (PDT)
Message-ID: <c21ff3ce-c81a-4419-84fd-d394d0a06af6@linaro.org>
Date: Mon, 21 Jul 2025 15:56:53 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/7] nvmem: qcom-spmi-sdam: Migrate to
 devm_spmi_subdevice_alloc_and_add()
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 sboyd@kernel.org
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
 <b06969d2-0c35-44c7-bb2c-162942186c53@collabora.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <b06969d2-0c35-44c7-bb2c-162942186c53@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 21/07/2025 14:45, AngeloGioacchino Del Regno wrote:
> Il 21/07/25 12:44, Casey Connolly ha scritto:
>> Hi Angelo,
>>
>> On 21/07/2025 09:55, AngeloGioacchino Del Regno wrote:
>>> Some Qualcomm PMICs integrate a SDAM device, internally located in
>>> a specific address range reachable through SPMI communication.
>>>
>>> Instead of using the parent SPMI device (the main PMIC) as a kind
>>> of syscon in this driver, register a new SPMI sub-device for SDAM
>>> and initialize its own regmap with this sub-device's specific base
>>> address, retrieved from the devicetree.
>>>
>>> This allows to stop manually adding the register base address to
>>> every R/W call in this driver, as this can be, and is now, handled
>>> by the regmap API instead.
>>
>> This is honestly a really nice improvement :D>
> 
> Thanks! :-D
> 
>>> Signed-off-by: AngeloGioacchino Del Regno
>>> <angelogioacchino.delregno@collabora.com>
>>> ---
>>>   drivers/nvmem/qcom-spmi-sdam.c | 41 +++++++++++++++++++++++++---------
>>>   1 file changed, 30 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/nvmem/qcom-spmi-sdam.c b/drivers/nvmem/qcom-
>>> spmi-sdam.c
>>> index 4f1cca6eab71..1b80e8563a33 100644
>>> --- a/drivers/nvmem/qcom-spmi-sdam.c
>>> +++ b/drivers/nvmem/qcom-spmi-sdam.c
>>> @@ -9,6 +9,7 @@
>>>   #include <linux/nvmem-provider.h>
>>>   #include <linux/platform_device.h>
>>>   #include <linux/regmap.h>
>>> +#include <linux/spmi.h>
>>>     #define SDAM_MEM_START            0x40
>>>   #define REGISTER_MAP_ID            0x40
>>> @@ -20,7 +21,6 @@
>>>   struct sdam_chip {
>>>       struct regmap            *regmap;
>>>       struct nvmem_config        sdam_config;
>>> -    unsigned int            base;
>>>       unsigned int            size;
>>>   };
>>>   @@ -73,7 +73,7 @@ static int sdam_read(void *priv, unsigned int
>>> offset, void *val,
>>>           return -EINVAL;
>>>       }
>>>   -    rc = regmap_bulk_read(sdam->regmap, sdam->base + offset, val,
>>> bytes);
>>> +    rc = regmap_bulk_read(sdam->regmap, offset, val, bytes);
>>>       if (rc < 0)
>>>           dev_err(dev, "Failed to read SDAM offset %#x len=%zd,
>>> rc=%d\n",
>>>                           offset, bytes, rc);
>>> @@ -100,7 +100,7 @@ static int sdam_write(void *priv, unsigned int
>>> offset, void *val,
>>>           return -EINVAL;
>>>       }
>>>   -    rc = regmap_bulk_write(sdam->regmap, sdam->base + offset, val,
>>> bytes);
>>> +    rc = regmap_bulk_write(sdam->regmap, offset, val, bytes);
>>>       if (rc < 0)
>>>           dev_err(dev, "Failed to write SDAM offset %#x len=%zd,
>>> rc=%d\n",
>>>                           offset, bytes, rc);
>>> @@ -110,28 +110,47 @@ static int sdam_write(void *priv, unsigned int
>>> offset, void *val,
>>>     static int sdam_probe(struct platform_device *pdev)
>>>   {
>>> +    struct regmap_config sdam_regmap_config = {
>>> +        .reg_bits = 16,
>>> +        .val_bits = 16,
>>
>> I believe registers are 8 bits wide, at least on Qualcomm platforms.
>>
> 
> I used 16 because usually that's the usual default for SPMI - but if
> you're sure
> about Qualcomm platforms having 8-bits wide registers and you can
> confirm that,
> I can change both of those to 8 in a jiffy.

reg_bits should be 16, only val_bits needs changing.

> 
> I anyway have to send a v2 because I forgot an error check - so changing
> this is
> not a problem at all for me.
> 
> But.
> 
> Before me changing - can you please please please double check and confirm?
> 
> If you can also check the register width of the others that I converted,
> I'd really
> appreciate that (I have no datasheets for qcom so it's a bit of a
> guessing game for
> me here... :-P), just so that we get everything right from the get-
> go ... even if
> a mismatch wouldn't really cause issues in the current state of things.
> 
> That's because - I just noticed - in qcom-spmi-pmic.c, reg_bits is 16,
> but val_bits
> is 8 (which basically means "the registers are 16-bits wide, but we
> always only
> care about the lower 8 bits).

yeah that's right, so as of today where we don't have the subdevices we
always get 8 bit values from the registers.

I don't have so much access to docs anymore but I only ever remember
seeing 8 bit wide registers on Qualcomm PMICs, I've never seen anything
wider, I can think of a few drivers where changing this to 16 would for
sure cause havoc.

Kind regards,

> 
> Thanks again!
> 
> Cheers,
> Angelo
-- 
// Casey (she/her)


