Return-Path: <linux-iio+bounces-17152-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DBCA6A900
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 15:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24809188E42E
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 14:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8C21C3BE0;
	Thu, 20 Mar 2025 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b="hqV+ZMNy"
X-Original-To: linux-iio@vger.kernel.org
Received: from qs51p00im-qukt01080101.me.com (qs51p00im-qukt01080101.me.com [17.57.155.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024731B81DC
	for <linux-iio@vger.kernel.org>; Thu, 20 Mar 2025 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481594; cv=none; b=f+EnAQvzm/heSw4kQj5ZW/GmcM8luFQeXdfIu98omVJs6yh4sSlfPCOzyYkRrBKf24Q9hSjNfVS97+wtyAKmW8fqCL0QYZobLnDVdaCIzhTeIObO5HfGdagwbNTyzXWd6WzoYlyeZTdThaHwSURAMPqYF8akywL9VqT8WeXtMjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481594; c=relaxed/simple;
	bh=7oAH1bOsgoIi98RXQHGEr/+09jwhM6I8AKgpNWQafUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rLQJU0Rt5IekR0HZaz3zuGTAc15evcyjtnwPFo4AQQhJX+bO8agoya3qoMG6k3+QZhqEU1oxEn85ne7oHulpygCjcwU5zxDEKkx/8BObpqb2NnBNrPmLCDvNix6RIcIP+bt2VhvkU24c/JGyCuLpN7u7UDjxlDYgqOnkoK8Yj1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es; spf=pass smtp.mailfrom=pereznus.es; dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b=hqV+ZMNy; arc=none smtp.client-ip=17.57.155.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pereznus.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pereznus.es; s=sig1;
	bh=RqiuEAwCwLH3NboCehFK4KKArDEXwOGpNfXaktXIr04=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=hqV+ZMNyCmVoyUNIGtVpKPM5FZ3mgbK1xFdczt2z+NFp/Jd3i0rKOGNr+oiQJr2h3
	 CIUZ31Me37NHiYkRlHYDGE2EGjeS6deKqW3b06bftFXfiUCs3xE17nYpw2G33Is2Ad
	 FVhrKFLx4YDiR1bQPJhWjW4RpF7gKFGwh9vUvOH7rzDLxdZ//JM0Cg5O5JM7O+B6Zx
	 Q99/jDPfifovIluRp0PPlj1yR/tfC01MdqPC0cK/VylRtbBmCZ6aoyrBIk8++A4N79
	 JtfR8tFCnRP0krGRt2jjodoH/apPMR3BAKM0f0Iy5UmCCAmtQUcAZHm5BBiC0Mus6m
	 HJMeYmb6yK9FQ==
Received: from [192.168.1.28] (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01080101.me.com (Postfix) with ESMTPSA id 3D7BD6180491;
	Thu, 20 Mar 2025 14:39:46 +0000 (UTC)
Message-ID: <4899e69d-5de0-45a9-896d-2cb43ca78937@pereznus.es>
Date: Thu, 20 Mar 2025 15:38:55 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] iio: light: bh1750: Add hardware reset support via
 GPIO
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tomasz Duszynski <tduszyns@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250319161117.1780-1-sergio@pereznus.es>
 <20250319161117.1780-2-sergio@pereznus.es>
 <9b8b74d5-ac63-4990-acc9-dbc3bd2f89f6@kernel.org>
 <e4ffd13f-1452-4f18-8d80-f63b391f2545@pereznus.es>
 <20250320-banana-chowchow-of-acceptance-62685c@krzk-bin>
Content-Language: es-ES, en-US, ca
From: =?UTF-8?Q?Sergio_P=C3=A9rez?= <sergio@pereznus.es>
In-Reply-To: <20250320-banana-chowchow-of-acceptance-62685c@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: BUpDw5mZkDOw2GEGGX-O5r03EFtm3Lf8
X-Proofpoint-GUID: BUpDw5mZkDOw2GEGGX-O5r03EFtm3Lf8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1030 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2503200091


El 20/03/2025 a las 9:55, Krzysztof Kozlowski escribió:
> On Wed, Mar 19, 2025 at 11:40:27PM +0100, Sergio Pérez wrote:
>> El 19/03/2025 a las 20:15, Krzysztof Kozlowski escribió:
>>> On 19/03/2025 17:11, Sergio Perez wrote:
>>>>    struct bh1750_chip_info {
>>>> @@ -248,6 +253,24 @@ static int bh1750_probe(struct i2c_client *client)
>>>>    	data->client = client;
>>>>    	data->chip_info = &bh1750_chip_info_tbl[id->driver_data];
>>>> +	/* Get reset GPIO from device tree */
>>>> +	data->reset_gpio = devm_gpiod_get_optional(&client->dev,
>>>> +									"reset", GPIOD_OUT_HIGH);
>>> Mess indentation.
>> Regarding indentation, I'll fix it in the next version to ensure consistency
>> with kernel style guidelines.
>>>> +	if (IS_ERR(data->reset_gpio))
>>>> +		return dev_err_probe(&client->dev, PTR_ERR(data->reset_gpio),
>>>> +							"Failed to get reset GPIO\n");
>>>> +
>>>> +	/* Perform hardware reset if GPIO is provided */
>>>> +	if (data->reset_gpio) {
>>>> +		/* Perform reset sequence: low-high */
>>>> +		gpiod_set_value_cansleep(data->reset_gpio, 0);
>>>> +		fsleep(BH1750_RESET_DELAY_US);
>>>> +		gpiod_set_value_cansleep(data->reset_gpio, 1);
>>> So you keep device at reset state. This wasn't tested or your DTS is wrong.
>> The BH1750 reset pin (DVI) is "active low", meaning the device is in reset
>> state when the pin is at 0V. When the pin is at high level, the device exits
>> reset and operates normally.
> I read this after responding to your binding change, so this confirms
> what I saw in datasheet and is contradictory to your response to the
> binding.
>
> First,  your binding should say which pin it is in the description.
>
> Second, it is active low...
That's right, it's commented on in the binding patch.
>> According to the datasheet (can provide upon request), the reset sequence
>> should:
>> 1. Pull the reset pin low to enter reset state
>> 2. Wait (minimum 1µs, I use 10ms to be safe)
>> 3. Pull the reset pin high to exit reset state
>> 4. Leave the pin high for normal operation
>>
>> My implementation follows this exact sequence, so the device is NOT left in
>> reset state. The initialization code:
>> 1. Sets the pin to 0 (device enters reset)
> I don't think you get how GPIOs work. 0 means logical zero, so GPIO is
> not active, not the actual signal level.
True, it's commented on in the binding patch.
>
>> 2. Waits
>> 3. Sets the pin to 1 (device exits reset)
>> 4. Leaves it at 1, which is the normal operating state
>>
>> I've modified the YAML description to remove "active low" to avoid
>> confusion, as the implementation is correct for this hardware.
> You have wrong implementation.
>
> Best regards,
> Krzysztof
>

