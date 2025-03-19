Return-Path: <linux-iio+bounces-17131-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0347A69C32
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 23:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 542807AB122
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 22:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AD421CC44;
	Wed, 19 Mar 2025 22:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b="Efj4LCPS"
X-Original-To: linux-iio@vger.kernel.org
Received: from p00-icloudmta-asmtp-us-central-1k-20-percent-2.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-central-1k.k8s.cloud.apple.com (p-east1-cluster7-host7-snip4-4.eps.apple.com [57.103.88.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021BB21A43C
	for <linux-iio@vger.kernel.org>; Wed, 19 Mar 2025 22:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.88.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742424036; cv=none; b=U0X9TRapzb/dONhEd62a3QiLQuxM7JaZ9+vCAOSKnPotuujz+pB+CNgI+hx8h96G4XJZNMSfmN5Alz2SYIASDg8eXFdgfuDCsjHZzOMo7znKHkivllgSGCt5pFbub6Tyn3mGWlZ83O+lGAUswx+ddWZ200JLyWBwgSk4WjgrWfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742424036; c=relaxed/simple;
	bh=LDdW63KkXdtMGsjIdm0QO2sTUdRfEA1gvEz9HleYuDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RA2+WddoXUEuznuGZPPx4GAPkVhDSSqV+d+mf/p5oG7RbunzPU9fafudMns6zk1+eMfjxjJE/xJoD1fw16XN20Njhj/Mtlvgg5lSAYktfovTwHC8WlvVY9OQ1rzAaTviWp1Sso/CbOP/HyafubbIu26dcDccZTqs95efLdDD8Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es; spf=pass smtp.mailfrom=pereznus.es; dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b=Efj4LCPS; arc=none smtp.client-ip=57.103.88.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pereznus.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pereznus.es; s=sig1;
	bh=CScgqRa+/ruu15qM/hSXzeb0IDHE4KwO5tkzzugGe8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=Efj4LCPSRFYqUA1aDsCEtZmfbUgJpDdbxVQOHkKej7DLnpXxOnT/bmTF1hjJSCoqE
	 zQsnBVfijfeTLzYvoK2oS7B3hzQYJhZtqU3doc7yjqDl+opABsFtMkIYXpBZHRsWQc
	 tmVR5bEwrhb45vy/P5tXN0yMMD50Z6AJd1c/e/xk7vgcrRmChc4jwr1lZcIQQcyjXP
	 5gSpgFwYtUnuKSe/18L7C4kjDn8TeBlYJLgUuq4frq5F8zJXtiSSIFHIUIDhCyOnyU
	 sXETByIhE/bT+/j2zkw+mdyYBJ0JPeoMpkGQMCuf6qnKpfS43irzV8m9ZiqA2YTd8x
	 ynaEf+rfk7biQ==
Received: from [192.168.1.28] (ci-asmtp-me-k8s.p00.prod.me.com [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-20-percent-2.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-central-1k.k8s.cloud.apple.com (Postfix) with ESMTPSA id 477BF1800090;
	Wed, 19 Mar 2025 22:40:29 +0000 (UTC)
Message-ID: <e4ffd13f-1452-4f18-8d80-f63b391f2545@pereznus.es>
Date: Wed, 19 Mar 2025 23:40:27 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] iio: light: bh1750: Add hardware reset support via
 GPIO
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Tomasz Duszynski <tduszyns@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250319161117.1780-1-sergio@pereznus.es>
 <20250319161117.1780-2-sergio@pereznus.es>
 <9b8b74d5-ac63-4990-acc9-dbc3bd2f89f6@kernel.org>
Content-Language: es-ES, en-US, ca
From: =?UTF-8?Q?Sergio_P=C3=A9rez?= <sergio@pereznus.es>
In-Reply-To: <9b8b74d5-ac63-4990-acc9-dbc3bd2f89f6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1qsE21s7QuIZJzwe5vw5cCq7G8pqWtZW
X-Proofpoint-ORIG-GUID: 1qsE21s7QuIZJzwe5vw5cCq7G8pqWtZW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_08,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 clxscore=1030 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2503190152


El 19/03/2025 a las 20:15, Krzysztof Kozlowski escribió:
> On 19/03/2025 17:11, Sergio Perez wrote:
>>   struct bh1750_chip_info {
>> @@ -248,6 +253,24 @@ static int bh1750_probe(struct i2c_client *client)
>>   	data->client = client;
>>   	data->chip_info = &bh1750_chip_info_tbl[id->driver_data];
>>   
>> +	/* Get reset GPIO from device tree */
>> +	data->reset_gpio = devm_gpiod_get_optional(&client->dev,
>> +									"reset", GPIOD_OUT_HIGH);
>
> Mess indentation.
Regarding indentation, I'll fix it in the next version to ensure 
consistency with kernel style guidelines.
>
>> +	if (IS_ERR(data->reset_gpio))
>> +		return dev_err_probe(&client->dev, PTR_ERR(data->reset_gpio),
>> +							"Failed to get reset GPIO\n");
>> +
>> +	/* Perform hardware reset if GPIO is provided */
>> +	if (data->reset_gpio) {
>> +		/* Perform reset sequence: low-high */
>> +		gpiod_set_value_cansleep(data->reset_gpio, 0);
>> +		fsleep(BH1750_RESET_DELAY_US);
>> +		gpiod_set_value_cansleep(data->reset_gpio, 1);
>
> So you keep device at reset state. This wasn't tested or your DTS is wrong.
The BH1750 reset pin (DVI) is "active low", meaning the device is in 
reset state when the pin is at 0V. When the pin is at high level, the 
device exits reset and operates normally.

According to the datasheet (can provide upon request), the reset 
sequence should:
1. Pull the reset pin low to enter reset state
2. Wait (minimum 1µs, I use 10ms to be safe)
3. Pull the reset pin high to exit reset state
4. Leave the pin high for normal operation

My implementation follows this exact sequence, so the device is NOT left 
in reset state. The initialization code:
1. Sets the pin to 0 (device enters reset)
2. Waits
3. Sets the pin to 1 (device exits reset)
4. Leaves it at 1, which is the normal operating state

I've modified the YAML description to remove "active low" to avoid 
confusion, as the implementation is correct for this hardware.
>
> I expect to acknowledge/respond to each of this comments above. Next
> version, which is supposed to be v5, should fix them.
>
> Best regards,
> Krzysztof

