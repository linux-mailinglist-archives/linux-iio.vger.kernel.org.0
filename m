Return-Path: <linux-iio+bounces-17151-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F4CA6A895
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 15:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 652C07A3398
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 14:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8D71C460A;
	Thu, 20 Mar 2025 14:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b="YkfP0Q2A"
X-Original-To: linux-iio@vger.kernel.org
Received: from qs51p00im-qukt01080101.me.com (qs51p00im-qukt01080101.me.com [17.57.155.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEA42628C
	for <linux-iio@vger.kernel.org>; Thu, 20 Mar 2025 14:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481168; cv=none; b=dCImZhtOQ5VFLSbUYjpGIg2oKVUoxs0tyoorVlchH2qu7a1FxZy9ro8u+g6dJfN1+B8TSZw43Sc8y0HKWVSCunrcxzvCHyPII/tJ7G7HTbcSilxm/B2iCbnBR84Ho8BYWgtIOy5wiW3KOXAi5hh2xPhHCjHX9bQK64P83LGYdQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481168; c=relaxed/simple;
	bh=/9PO0KVicUb4c/uSrH9bAZzM+bvLXVvZ4LNQPyX2jGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gG+/5cCcEknUlPDRSC9XdpimkiOKgT/xu6ib1mtdIJ2NTME2QkMLmv4eB/KOt79sgsyCCErfUR4wgJ0s1sluyhr2c/onQXyxArIwdaZTlnEr4MU0gnsVY3/faCnXxSp15C3c76DniCtTQSSiea7Y9A5qVHL1yEs5AjWzMmsAgMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es; spf=pass smtp.mailfrom=pereznus.es; dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b=YkfP0Q2A; arc=none smtp.client-ip=17.57.155.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pereznus.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pereznus.es; s=sig1;
	bh=nGUX0MpUVvt5yohMwXUeAAwAn74x53CTWP5lCpgmFes=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=YkfP0Q2AYB9Abz3BktYyD3R58Yls+QMMx7QBHOr/xxk0L/xt9kSsy0YYmeRibMA56
	 8mEbIp5gw3dNd03gNdvSwSRygrr4O0MKzS2fst1nQtbZdr0Lqw11/wCt5bxyYALqua
	 qfi66Ulh/w4DNyDX7dTzT2y6KluecBz49k8lkKwbhdsE8ajJpqWBZSavMh+Ka0PZ/6
	 /kHG5GsAE1Mrremmp9vJiS4sXK92lEYRBqhEUm13MGAr5rNh3J7a7FrVnzF4m0NHY+
	 a2PJtMlQxjWfXrUv6A+V5ePH+5JkU3nXgtohCT6V6O4Y+Sx+65y/wrdGWmiQgoxlOx
	 bN+chtbNyxktQ==
Received: from [192.168.1.28] (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01080101.me.com (Postfix) with ESMTPSA id 5C1A1618048B;
	Thu, 20 Mar 2025 14:32:43 +0000 (UTC)
Message-ID: <40c9c996-94a2-4c1b-ac18-c75bebd1b3f2@pereznus.es>
Date: Thu, 20 Mar 2025 15:32:40 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: light: bh1750: Add reset-gpios
 property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tomasz Duszynski <tduszyns@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250319161117.1780-1-sergio@pereznus.es>
 <61d55149-1955-4d5c-84de-d8644727b87f@kernel.org>
 <96c44905-0725-4c68-91a5-1c6cea6a7f4a@pereznus.es>
 <20250320-shaggy-heavy-camel-9d0eed@krzk-bin>
Content-Language: es-ES, en-US, ca
From: =?UTF-8?Q?Sergio_P=C3=A9rez?= <sergio@pereznus.es>
In-Reply-To: <20250320-shaggy-heavy-camel-9d0eed@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Peb6mpGc9Ghze1TrpixTk1gjCSPADTGo
X-Proofpoint-ORIG-GUID: Peb6mpGc9Ghze1TrpixTk1gjCSPADTGo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1030
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2503200090


El 20/03/2025 a las 9:52, Krzysztof Kozlowski escribió:
> On Wed, Mar 19, 2025 at 11:38:09PM +0100, Sergio Pérez wrote:
>> El 19/03/2025 a las 20:12, Krzysztof Kozlowski escribió:
>>> On 19/03/2025 17:11, Sergio Perez wrote:
>>>> Some BH1750 sensors require a hardware reset via GPIO before they can
>>>> be properly detected on the I2C bus. Add a new reset-gpios property
>>>> to the binding to support this functionality.
>>>>
>>>> The reset-gpios property allows specifying a GPIO that will be toggled
>>>> during driver initialization to reset the sensor.
>>>>
>>>> Signed-off-by: Sergio Perez <sergio@pereznus.es>
>>>> ---
>>>>    Documentation/devicetree/bindings/iio/light/bh1750.yaml | 5 +++++
>>>>    1 file changed, 5 insertions(+)
>>> You just sent v3, while v4 was already on the lists, without improving
>>> and without responding to review.
>>>
>>> NAK.
>>>
>>> You keep repeating the same mistakes: not reading and responding
>>> feedback and it is getting tiresome.
>> I apologize for the confusion with patch versions. You're right that I sent
>> v3
>> after v4 was already on the list. I was trying to follow your exact
>> instructions from:
>> "git add ...
>> git commit --signed-off
>> git format-patch -v3 -2
>> scripts/chekpatch.pl v3*
>> scripts/get_maintainers.pl --no-git-fallback v3*
>> git send-email *"
> v3 stands for version of the patch, so my instruction shuld be here
> adjusted.
>
>> Regarding the binding I've modified for next v5 the YAML description to
>> remove "active low" to avoid confusion and modified the example to:
> So the signal is not active low? Are you really sure?
>
> Looking at BH1750FVI there is no reset signal in the first place...
> unless you mean this is DVI, but the description should then mention it.
>
> If this is DVI, then it is active low.

I apologize for the confusion. You're completely right, and I 
misunderstood how the GPIO flags work in the kernel. I've now corrected 
my implementation to properly handle the active-low reset pin.

Changes for v5:

1. In the binding YAML:
    - Updated description: "GPIO connected to the DVI reset pin (active 
low)"
    - Changed example to use GPIO_ACTIVE_LOW flag:
      reset-gpios = <&gpio2 17 GPIO_ACTIVE_LOW>;

2. In the driver code:
    - Corrected the reset sequence to properly handle active-low:
      ```
      /* Perform reset sequence: active-deactive */
      gpiod_set_value_cansleep(data->reset_gpio, 1); // Active reset 
(pin low)
      fsleep(BH1750_RESET_DELAY_US);
      gpiod_set_value_cansleep(data->reset_gpio, 0); // Deactivate reset 
(pin high)
      fsleep(BH1750_RESET_DELAY_US);
      ```
    - Fixed indentation issues

With these changes, the reset sequence correctly follows the datasheet 
requirements: pull the DVI pin low to reset, wait, then pull it high to 
resume normal operation.

Thank you for your patience and guidance on this.

> Best regards,
> Krzysztof
>

