Return-Path: <linux-iio+bounces-22159-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE432B16AAA
	for <lists+linux-iio@lfdr.de>; Thu, 31 Jul 2025 05:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB333AAAE3
	for <lists+linux-iio@lfdr.de>; Thu, 31 Jul 2025 03:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6CA23ABAC;
	Thu, 31 Jul 2025 03:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="QpXmZXmm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9584B19F101;
	Thu, 31 Jul 2025 03:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753931224; cv=none; b=bxOgaunTxDZGZOnAP6T4UT0tsOqicz6VEdJlQ+XlfQoTT5zZFlw75xI+rzz24GxrzOUcodgogKPoZL92Pn7/wNFstlKjADT7LzqIQocnk2eWIVamxCzt7jIv4b+g9SF9m3dt+gVd3bB9AHU5KLVzlQSA/ciuD4TNJE85FVA8asc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753931224; c=relaxed/simple;
	bh=14qxhzw+Tj7K+vUArLn/OHHypiZhci1uCf/09CN5zsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MdtcORH5Pw40H+0gql5v7IO0P2AKqJ/rQM/ZCoMHI6jCOWnUKCaP7lJYE8HwPVZGFMzZ3lePt0tkiSNWBGA9GZPme+x5HuZzAIQ1LcQTOnDPJ9dmb5kD6X9fJbq+/1m1e/ERTZcFGx+CGymQt9Ie4iXHaqz3uBhXdZXoplHHhg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=QpXmZXmm; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1753931131;
	bh=a9ucKx9IvRh9aqxJC8OiAB/VcwuKjCvIpVNT0ZYtewM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=QpXmZXmmCDVLZHinPic01Im8JazSBzY3ak5N8W40gbW+xjzg0dhmXutYOqyzWCl/h
	 IufyMgRlbRLIULewgZQaOgboAuYfN2eX54WwLUFVfoIAuis7F5JZp80W6pPRAd6bho
	 KS14run0ivEpS4U0LAxsj0lvBYJG653wGYHOYmmQ=
X-QQ-mid: zesmtpsz4t1753931123t57ac76c2
X-QQ-Originating-IP: UY//SYI0w2+/KZaYFYM7ig1bR3YjCAZjgRVLYqx062I=
Received: from [198.18.0.1] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 31 Jul 2025 11:05:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16923455272017176677
EX-QQ-RecipientCnt: 12
Message-ID: <8C57A7CCEBFAEA59+b36cfd0d-2cd9-413e-b658-e82938f9d947@uniontech.com>
Date: Thu, 31 Jul 2025 11:05:21 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: imu: bmi270: Match ACPI ID found on newer GPD
 firmware
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yao Zi <ziyao@disroot.org>, WangYuli <wangyuli@uniontech.com>,
 Jun Zhan <zhanjun@uniontech.com>
References: <20250730-bmi270-gpd-acpi-v1-1-1ffc85b17266@uniontech.com>
 <CAHp75Vc2K3AmPhwme3+7cCGwDTA6V+4Ug8f++iFr8gCThCOnQw@mail.gmail.com>
Content-Language: en-US
From: Cryolitia PukNgae <liziyao@uniontech.com>
In-Reply-To: <CAHp75Vc2K3AmPhwme3+7cCGwDTA6V+4Ug8f++iFr8gCThCOnQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NSl7+7iyUzmQJWoCXasJofXsPKFT1SG/MjojYKOsM1VsgrXvpdOGlGwa
	d6EPHPMGuLmeAS1RXaEURvN24+I42jhXStjA1jMyF5x7F6QeZJpc/iK9MGss99Bh/K02GAz
	zyiwviPW6eZUL+/FPgDvI4EHWpXHdeN50A48tRbu6oBOWkwbu8iEQxjvaMEFw2VnjCBWZc2
	B6OhRjyp9g/bMACn4jqHYROM8Z4chGB+PZtB+FNRjyZQIz7QSzUez+JsZc9YIoQPQ6O/HxZ
	MYjvfBkUIu9daKj8ul0KwXwjp6Lck5Hh9O9Wm/kjt3X/wxMsUiUeaU+u9ezypOdcAp9EXP9
	aRWpjWlGMWKle1GrevDiBiBC9JX365yTyd9HKeLIlA/JztDFRLCZuWKZ+7f3Y0flZxrJ3ID
	TaZ65mPAzan5PADs4tz1KrFZHGIjdYkYGzA+ohJrEpbNz748HFVBikTz/XqBho6DEB8XWp4
	FElrAG1NYsoFVShorodiYGGZyPhQ0nsWRltfPk6lcgUfwU4CPXGnVRQ9RGhORm/qmPnd+lD
	S3nNR0+gPFL4VHouLFmUZVawXDKo6874fyx2LhNKyjrXOC1BRFn4V0d3ZixO2bL2r0vtdmR
	yHy5kuczdcOBHKIn4sx7IVdvD0ZyIPwK3oxScrdBAaRYiIFHqgKVDzxrjZI9ng4B/sfPuBD
	Z3TJqWjpybMtZsBikfiIZF8Xl4Dg1e/BJqJx3tTKzKdKsVCygG76aMkIkXz5oO0zxOWGyJA
	6LqLub5OXT0Mcb3MuK9qCa8XnFJr98wdIbBYAZIBy8ZOwVZ2rP5vgmHTVG0JmdKDCB9vvRY
	9/HvQMANp7HHzrHiKn2t+Gm76cGAVnUuwtNRCSFGMXxeWyqmIjCe5pzBzlcb+78VdrzFveV
	WuO3JbQw0A5apks/yPHHTNARgifi8pinL0N5WLgD6JLvUKeySy37uJaOPOCjwLCWQjhO/sr
	G6n/aak4wNu863goxPH+m7qP/JIyIpFtJG1v9O8qyoUgYK9QNk1/qZRVVBdMMrwHZDTfqLc
	p9ITOEhre2tuwaCAIwSVva23txv7Nhq7dtju9Qsw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Dear Maintainer,

Thank you for your reply. I apologize for the confusion regarding the 
PNP VID assignment - you are absolutely correct that "BMI0260" is not an 
official Bosch PNP ID. Let me provide a more detailed context.

GPD devices originally used BMI160 sensors with the "BMI0160" PNP ID. 
When they switched to BMI260 sensors in newer hardware, they reused the 
existing Windows driver which accepts both "BMI0160" and "BMI0260" IDs. 
Consequently, they kept "BMI0160" in DSDT tables for new BMI260 devices, 
causing driver mismatches in Linux.

Current Situation:
   1. GPD updated BIOS v0.40+ for newer devices to report "BMI0260" for 
BMI260 sensors to avoid loading bmi160 driver on Linux. While this isn't 
Bosch's VID:
   2. Bosch's official Windows driver uses "BMI0260" as a compatible ID
   3. The ID "BMI0160" already exists in mainline (drivers/iio/imu/bmi160)
   4. We're seeing real devices shipping with "BMI0260" in DSDT

Given the challenges we've faced in communicating with GPD regarding 
Linux support, it seems unlikely that we can push for another change; 
they are solely focused on ensuring compatibility with Bosch's official 
Windows driver. Unfortunately, I do not have the means to contact Bosch 
and urge them to abandon the use of these non-standard IDs.

Given existing devices use "BMI0260" and Windows drivers validate this 
ID pattern, I propose temporarily adding it to bmi270_acpi_match as a 
compatibility measure. This would immediately benefit already existing 
users.

I'm happy to provide DSDT excerpts from GPD Win Max 2 2023 devices 
showing the "BMI0260" declaration if needed.

Thank you for your time and guidance.

Best regards,
Cryolitia PukNgae

在 2025/7/31 04:57, Andy Shevchenko 写道:
> On Wed, Jul 30, 2025 at 2:56 PM Cryolitia PukNgae via B4 Relay
> <devnull+liziyao.uniontech.com@kernel.org> wrote:
>>
>> From: Cryolitia PukNgae <liziyao@uniontech.com>
>>
>> Some GPD devices ship a buggy firmware that describes on-device BMI260
>> with ACPI ID "BMI0160". Since this is fixed in BIOS update v0.40,
>> let's match the correct ID to detect the device. The buggy ID "BMI0160"
>> is kept as well to maintain compatibility with older firmwares.
> 
> No, it's not true. See below why,
> 
>> ---
>> Some GPD devices ship a buggy firmware that describes on-device BMI260
>> with ACPI ID "BMI0160". Since this is fixed in BIOS update v0.40[1],
>> let's match the correct ID to detect the device. The buggy ID "BMI0160"
>> is kept as well to maintain compatibility with older firmwares.
>>
>> Link: http://download.softwincn.com/WIN%20Max%202024/Max2-7840-BIOS-V0.41.zip
>>
>> [1]. See the update nodes in the archive file above
> 
> Yeah... I think you need one more attempt to fix it right.
> 
> ...
> 
>>   static const struct acpi_device_id bmi270_acpi_match[] = {
>>          /* GPD Win Mini, Aya Neo AIR Pro, OXP Mini Pro, etc. */
>>          { "BMI0160",  (kernel_ulong_t)&bmi260_chip_info },
> 
> Unbelievable! How is the above supposed to work? Do we have DMI quirks
> in both drivers (bmi160 and bmi270)?
> 
>> +       /* GPD Win Max 2 2023(sincice BIOS v0.40), etc. */
>> +       { "BMI0260",  (kernel_ulong_t)&bmi260_chip_info },
> 
> For the record this is incorrect ACPI ID, nor PNP ID for Bosh, unless
> I missed that https://www.bensonmedical.com/ is bought by Bosh or part
> of the groups of the companies.,
> 
>>          { }
>>   };
> 
> Can you work with Bosh to resolve this as soon as possible and use a
> real Bosh ACPI ID (BOSCxxxx) or PNP ID (BSGxxxx)?
> Also, each ACPI ID adding patch (when it's incorrect) must provide a
> DSDT excerpt in the commit message to show this. Ideally this also
> should be confirmed by the vendor of the device (GPD) that the ID is
> incorrect and a correct one needs to be used.
> 



