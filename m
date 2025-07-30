Return-Path: <linux-iio+bounces-22143-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117BAB15DF6
	for <lists+linux-iio@lfdr.de>; Wed, 30 Jul 2025 12:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D71677AFB81
	for <lists+linux-iio@lfdr.de>; Wed, 30 Jul 2025 10:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917B71F8725;
	Wed, 30 Jul 2025 10:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="R7Eq/ZzL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A152737E7;
	Wed, 30 Jul 2025 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753870710; cv=none; b=s8/EFnR46N2tYnLnKITCl/fKJ+URh35EXzoZgtHSldV0poq2JJJ6DTDrkFk+C6xkZgVjSy5R+NFKuVnSqxRj66U1znvTcnDGJFjuWofn0qDyFKnHL6JmTFID5zKEzG1kolOOgcI11pRrxMPJErbgP4EGIN8xV84sg+2HSgrk+BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753870710; c=relaxed/simple;
	bh=fpbj0lBhPBvjvkKZsk62S9T45g2Ta9NMn1noy9EkyH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VySOknkQJAUbQkb7f2wmsZ/x1Z8yPhto6FRFGkf7mSSeKIsdG3CSq0n1y3WvQ7E6p8w52ugVqVAWazSaR25ViC6NabSY0Np0Vp5qnKe+HhNl3iUZIrGfHRy+hFnQToGFjsbTXtQWov9IrM+HHIaLly1e6CMj3WQuToT9lRJjBWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=R7Eq/ZzL; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1753870614;
	bh=LJR5sxZt3LIDBiAw+pIR8jpCnGi/0zDHHt8IPm3eDBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=R7Eq/ZzL8xdbVlENcGxZib+OV1jPIP3rhNBwbLxYAVb3daj9N9PCOFEMbYm2Nqyna
	 34AOtDMNh7cJ4O+i4w5ztAmlUzc+F6Q2XOZR0h/WsDbfxrQAHTB3v3tNiPc0QLtay8
	 KKD3Rkqv1d6riNLEYF/yXzI18v2KJvSS7aeJj8/4=
X-QQ-mid: esmtpgz16t1753870611te9d255f5
X-QQ-Originating-IP: Y8ja1njFcv+jRKP9+zxx9Sxp0Vg6mANsb8jUFpgRmLQ=
Received: from [198.18.0.1] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 30 Jul 2025 18:16:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1006663088709518859
Message-ID: <E393808AF517D1DB+79b6f35f-cce0-461b-94ee-67854e763646@uniontech.com>
Date: Wed, 30 Jul 2025 18:16:48 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: imu: bmi270: Match ACPI ID found on newer GPD
 firmware
To: Jonathan Cameron <jic23@kernel.org>,
 Cryolitia PukNgae via B4 Relay <devnull+Cryolitia.gmail.com@kernel.org>
Cc: Cryolitia@gmail.com, Alex Lanzano <lanzano.alex@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yao Zi <ziyao@disroot.org>
References: <20250206-bmi270-gpd-acpi-v1-1-db638cfb9a3c@gmail.com>
 <20250208133058.3e5cb597@jic23-huawei>
Content-Language: en-US
From: Cryolitia PukNgae <liziyao@uniontech.com>
In-Reply-To: <20250208133058.3e5cb597@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: N3CDQOaw7dgOp/OXGG98F6ZJqVDaBFlMkIYaCCgFXn9emh3Fb3t00VuF
	TM9UUmE+nEf8l52wCKU16BeQi3IK2EdmkWH7eI0punBZXzXgITvDJ/gpmrfwk9jTIXkXZtn
	yMQ4jPFRH1ua64FpPSG/t+WCJ9ZlrDrKmaQa7cL0xdSzwIWnqFxw3kfhfM5rgI3NV/w0Q7m
	PY1eZDhY8rIhx1j30gQNcOPcr+pVy2yQKPq/WPSSrtGRROSfRd4IEQohyBnuiz1xsDjjG58
	vJOKCXogsdTgquACY4h/fXiBLQoVOIEqIvobAsF/qg/8QkcgWtJg1p8SGDvpf7iA8J4GfHI
	73KONk2DPk6VTqsTw/z5ycS0lwLTnHifF3pC2gXhY7MMoKYzjdb2f6FQZ8TY6b4MU1JFmGj
	iTGPexco+Ol2KX6MoB3TK5YIOJPeATezMQpxBuICgppC7XO6FlUai3tn3queJFDYzKKQubT
	wDXqVmDOhbMcFzarzWy6UVObY8Qqqv9pr+uN4jBeRFXxaQ8k7LfaqQnZwRXNv5HvypxSuu+
	I1IJMxNIoMW/ox+B6aeyCbI84v4ZMe2FdAHW1NtmZBjznLlt1UuUVhQwcom0nz7McKtpDQ0
	N01N4nABWUopd0rMeHmaHi68iI1qy+GCNt9xi5m7B7t3k8ooevyy2WbPZE4djXUvd5Fnr28
	xeOz+IPn9Ajk7E/vNmEJx4moU7q2WZwhYngUJMrQcTbSeij1Me6oMWYhb40LyfgSTQRZS04
	k72LnvRYuH+K7q/lI0Em9JpI+74GnXUNjZPhZpLabvBgpC4+ASlyNn9Yd2ypCZK6iMgtctN
	TOOV7WDPgPKMQyvGwCYQYiAPxt8zQ2UFtyocX5g4AiAdWmmCS7A57TfpxctkmPUtLsrS45R
	7DadTuNbJ9pNsWv/RA0h7KI/u40DUeeUtfpFBdw7koHGA7Xm90HI+/DM46pHI7KSMMD0901
	k4cuKjKGy1csIT8Jkbon/W3dXFMZ1CK2AmqIoM8Rb/6MmbCKHla8oQV+umTHg2dFV1EN91S
	dSxwWivMVenyaKZinjx6i8+jVUVWs=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0



在 2025/2/8 21:30, Jonathan Cameron 写道:
> On Thu, 06 Feb 2025 15:09:42 +0800
> Cryolitia PukNgae via B4 Relay <devnull+Cryolitia.gmail.com@kernel.org> wrote:
> 
>> From: Cryolitia PukNgae <Cryolitia@gmail.com>
>>
>> Some GPD devices ship a buggy firmware that describes on-device BMI260 with ACPI ID "BMI0160". Since this is fixed in BIOS update v0.40[1], let's match the correct ID to detect the device. The buggy ID "BMI0160" is kept as well to maintain compatibility with older firmwares.
>>
>> ---
> 
> This --- will break git picking up this patch as the
> sign off etc will be misgin.
> 


Sorry for that, Reported to 
https://bugzilla.kernel.org/show_bug.cgi?id=219412

>> Some GPD devices ship a buggy firmware that describes on-device BMI260 with ACPI ID "BMI0160". Since this is fixed in BIOS update v0.40[1], let's match the correct ID to detect the device. The buggy ID "BMI0160" is kept as well to maintain compatibility with older firmwares.
> Please wrap commit message at 75 chars
>>
>> Link: http://download.softwincn.com/WIN%20Max%202024/Max2-7840-BIOS-V0.41.zip
> Link is an official tag so move down to the line above (no blank line) the
> Sign off and if you want to refer to it use
> Link: http://download.softwincn.com/WIN%20Max%202024/Max2-7840-BIOS-V0.41.zip # [1]
> or similar (so a comment after the tag).
> 
> 
> If you have any means to tell the manufacturer that this is not a complaint ID
> please do. They need to allocate them from their own ID space.
> They are unlikely to be the Benson Medical Instruments company.
> https://uefi.org/PNP_ID_List?pnp_search=BMI
> 
> So either GPD need to get their on PNP ID  (or ACPI ID) or they need
> to ask Bosch (BSG) to issue an ID for this sensor.
> 
> It would really help if Windows stopped accepting drivers that made up these
> IDs, but I guess that ship long sailed.
> 
> Jonathan
> 

The Windows driver for Bosch's gravity sensor BMI 260 is developed and 
signed by Bosch, and uses the ID BMI0260[1]. All devices using this 
hardware use the same driver, including GPD Win Max 2023 and newer 
devices, and OrangePi NEO. The ID of BMI0260 is assigned by Bosch 
itself, and GPD simply follows Bosch's driver rather than assigning it 
itself. From the name, using this ACPI ID is also the most intuitive.

Some projects such as Handheld Daemon[2] and distributions such as 
Manjaro[3] have already adopted the patch that includes the ACPI ID BMI0260.

I will send a new patch later that fixes the above issues.

1. 
https://treexy.com/products/driver-fusion/database/sensors/bosch/accelerometer/
2. https://github.com/hhd-dev/bmi260/blob/main/bmi260_i2c.c
3. 
https://gitlab.manjaro.org/packages/core/linux612-rt/-/blob/master/0001-iio_imu_Add_driver_for_Bosch_BMI260_IMU.patch

------
I am Cryolitia <cryolitia@gmail.com> that previously sending the patch.
Due to work, I changed my email address. GPG can verify it's the same
person:
https://keyserver.ubuntu.com/pks/lookup?op=vindex&search=0x84dd0c0130a54df7
------


Best wishes,
Cryolitia PukNgae

>>
>> [1]. See the update nodes in the archive file above
>>
>> Signed-off-by: Cryolitia PukNgae <Cryolitia@gmail.com>
>> ---
>>   drivers/iio/imu/bmi270/bmi270_i2c.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
>> index 44699ab589097eaa0eec5f2172245496ed031185..f66ae01e301df24f1e563e059da8cc531fc173eb 100644
>> --- a/drivers/iio/imu/bmi270/bmi270_i2c.c
>> +++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
>> @@ -40,6 +40,8 @@ static const struct i2c_device_id bmi270_i2c_id[] = {
>>   static const struct acpi_device_id bmi270_acpi_match[] = {
>>   	/* GPD Win Mini, Aya Neo AIR Pro, OXP Mini Pro, etc. */
>>   	{ "BMI0160",  (kernel_ulong_t)&bmi260_chip_info },
>> +	/* GPD Win Max 2 2023(sincice BIOS v0.40), etc. */
> 
> since
> 
>> +	{ "BMI0260",  (kernel_ulong_t)&bmi260_chip_info },
>>   	{ }
>>   };
>>   
>>
>> ---
>> base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
>> change-id: 20250206-bmi270-gpd-acpi-de4d12bce567
>>
>> Best regards,
> 


