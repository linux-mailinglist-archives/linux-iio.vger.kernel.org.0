Return-Path: <linux-iio+bounces-6685-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8659129AB
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 17:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23DD1F2221B
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 15:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A745974402;
	Fri, 21 Jun 2024 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lpTs2kTj"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47A5DDC4
	for <linux-iio@vger.kernel.org>; Fri, 21 Jun 2024 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718983874; cv=none; b=ngqOGuyc7JVtQU27AJJq6DkdimQRM0eoPMq2EB27HjACtkQR7W4VvpGS9rG94JxvyGws2cLVDRKwzUJ4i3aKB5a5PeRNzYE0PbohSwbsitVm7sz8Z+oUHr1ES/+sTp01q0wfIytrNOQ/mFPyBMG8+L89Vl7onC4jYCOQRAN9hxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718983874; c=relaxed/simple;
	bh=6Sxj7NyGK3NnaTBQtDuoPz7xSdV7SeSV4ZOOalbUogk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eQk5FXqnQrMSO4HHpJ5YlvBZ1+SZWqp2BRjeYF/B33q0kV+sgck9bslarjGRgcAA1ZfG4j1EVN/6QDbRdpV0/tqzYwoC4D5GRRYk/E45iZ0cTVECVXCG8aolT5D27lvcd5a0Y189m+GeDU40oeo6DAg90++vpb0/2Zn4K7QRcnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lpTs2kTj; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux@roeck-us.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718983870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=84714MseuJ5eYmHrBF1FkNC7jf6Ok3uWsdaXqPdl7zU=;
	b=lpTs2kTjM0gFPDUpXxvFlPnH3hc0GMHF7MQxeJ/gCwUETTINTn4hsa8ytX7UszhAQVYsFK
	Cuufi4+rIPUMJZlMqm826Vbx5XeXr0vCftNKIlYfCm9rq+yrjc8+Whs2kdnD4Ftw8jbksk
	ySwchPAzQAYCouDK2VXqoxRSrSSH6HQ=
X-Envelope-To: jic23@kernel.org
X-Envelope-To: jdelvare@suse.com
X-Envelope-To: linux-iio@vger.kernel.org
X-Envelope-To: linux-hwmon@vger.kernel.org
X-Envelope-To: lars@metafoo.de
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <1439bdda-0e01-42da-a8ec-7a51ee3a5a08@linux.dev>
Date: Fri, 21 Jun 2024 11:31:06 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] hwmon: iio: Add labels from IIO channels
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Guenter Roeck <linux@roeck-us.net>, Jonathan Cameron <jic23@kernel.org>,
 Jean Delvare <jdelvare@suse.com>, linux-iio@vger.kernel.org,
 linux-hwmon@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org
References: <20240620211310.820579-1-sean.anderson@linux.dev>
 <20240620211310.820579-3-sean.anderson@linux.dev>
 <0c74406c-291d-4b0f-935e-989fb2f870ce@roeck-us.net>
 <55dbe61b-c2df-4eeb-80ac-cc2c83e9cdd3@linux.dev>
Content-Language: en-US
In-Reply-To: <55dbe61b-c2df-4eeb-80ac-cc2c83e9cdd3@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/21/24 11:22, Sean Anderson wrote:
> On 6/21/24 11:08, Guenter Roeck wrote:
>> On 6/20/24 14:13, Sean Anderson wrote:
>>> Add labels from IIO channels to our channels. This allows userspace to
>>> display more meaningful names instead of "in0" or "temp5".
>>>
>>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>>> ---
>>>
>>>   drivers/hwmon/iio_hwmon.c | 33 ++++++++++++++++++++++++++++++---
>>>   1 file changed, 30 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
>>> index 4c8a80847891..588b64c18e63 100644
>>> --- a/drivers/hwmon/iio_hwmon.c
>>> +++ b/drivers/hwmon/iio_hwmon.c
>>> @@ -33,6 +33,17 @@ struct iio_hwmon_state {
>>>       struct attribute **attrs;
>>>   };
>>>   +static ssize_t iio_hwmon_read_label(struct device *dev,
>>> +                  struct device_attribute *attr,
>>> +                  char *buf)
>>> +{
>>> +    struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
>>> +    struct iio_hwmon_state *state = dev_get_drvdata(dev);
>>> +    struct iio_channel *chan = &state->channels[sattr->index];
>>> +
>>> +    return iio_read_channel_label(chan, buf);
>> 
>> This can return -EINVAL if there is no label. Since the label attribute
>> is created unconditionally, every affected system would end up with
>> lots of error messages when running the "sensors" command.
>> This is not acceptable.
> 
> The sensors command gracefully handles this. There are no errors, and the label is unused.

For example, without IIO labels I get:

$ sensors hwmon_ams_ps-isa-0000
hwmon_ams_ps-isa-0000
Adapter: ISA adapter
in1:         825.00 mV 
in2:         826.00 mV 
in3:           1.81 V  
in4:           1.18 V  
in5:           1.80 V  
in6:           1.80 V  
in7:           3.27 V  
in8:           1.81 V  
in9:         825.00 mV 
in10:          1.81 V  
in11:          1.80 V  
temp1:        +79.8 C  
temp2:        +80.9 C  

and with labels I get

$ sensors hwmon_ams_ps-isa-0000
hwmon_ams_ps-isa-0000
Adapter: ISA adapter
VCC_PSINTLP: 824.00 mV 
VCC_PSINTFP: 822.00 mV 
VCC_PSAUX:     1.81 V  
VCC_PSDDR:     1.18 V  
VCC_PSIO3:     1.80 V  
VCC_PSIO0:     1.80 V  
VCC_PSIO1:     3.27 V  
VCC_PSIO2:     1.80 V  
PS_MGTRAVCC: 822.00 mV 
PS_MGTRAVTT:   1.81 V  
VCC_PSADC:     1.80 V  
Temp_LPD:     +79.5 C  
Temp_FPD:     +80.2 C  

I also was concerned about the same thing, but lm-sensors handles things
gracefully, allowing us to simplify the implementation.

--Sean

