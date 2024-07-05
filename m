Return-Path: <linux-iio+bounces-7366-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E26928B9A
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 17:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 921D3B20F3A
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 15:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94E816B75F;
	Fri,  5 Jul 2024 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OL7Nxx1z"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D44C16C685;
	Fri,  5 Jul 2024 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720193065; cv=none; b=RqOBTlLnvP7JP8diuatmb9wmTNeh7/X4nw4Jdh29Qi6jAyiPEn6fbB2PvhiQxPKLG7kKV/wMaZHssojjoZZuK8LnoHExmMemZiHKDekGSRZ9yTb2cHfg///7XwyLZnBfTt651u7COQ90ESXRbF3+pBlgEO1k23pN+k9lUjg/OQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720193065; c=relaxed/simple;
	bh=6msf+6zQ7jQp5WB6fG+2Y/R5/2ibEiQRwNrsG6fD0tM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YHKkLJATEXi/KyhkWp5VRZR/wR58TBGC/iYxcWs/Wy41iAIJuHQnCZ0NgzxLXcYztkceyYTeq2cclEjBfhprab0WEqzyDjy3g8fthyr3kYv6BGOx4jZJxogUUUg6sI3GpJKmqZxmQJxMWBdNCyA3v4XfMoTkEDD4d2cDyJLHfYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OL7Nxx1z; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8AFA7C0002;
	Fri,  5 Jul 2024 15:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720193061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VMVflziC1aehBJf4VTjlbQPH2LpM9ezvmYf2pbzh65s=;
	b=OL7Nxx1zP1SzNXRZ9t2/CTWdNHOcU2FY1TxN46d4gqsX3w73Cd6cmMb8QZ9kQruPrACgHW
	s9gwRa5IuDYTAOrumyqOY3AcvyGVad0Dxsx3rYgNxEfCcFuoM3kwiGgZlfmMR5PKfzkWYc
	M033MIo+s/dr582KlrKDvYVlivF+SAw65HQrwnMD7gjLXsBv9xfjTpm04G2UfuruASPNOI
	3iUSH8jkQGlgWIuUrBgAPn8B46zsKeKQFt+Ca6EcIlaXJ8zA1MFNmesoO0579VO5dOyRFc
	+disElGQ8OvsMMuepTrwgL1AVoRMj0hh8BRY8MtKORL6TrjS1pMYhoznZ3W5DA==
Message-ID: <6b5459fd-2873-4c26-b986-882413b8d95b@bootlin.com>
Date: Fri, 5 Jul 2024 17:24:19 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: adc: sophgo,cv18xx-saradc.yaml:
 Add Sophgo SARADC binding documentation
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
 Inochi Amaoto <inochiama@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20240705-sg2002-adc-v2-0-83428c20a9b2@bootlin.com>
 <20240705-sg2002-adc-v2-1-83428c20a9b2@bootlin.com>
 <20240705-unaired-pesticide-4135eaa04212@spud>
Content-Language: en-US
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
In-Reply-To: <20240705-unaired-pesticide-4135eaa04212@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.bonnefille@bootlin.com



On 7/5/24 5:01 PM, Conor Dooley wrote:
> On Fri, Jul 05, 2024 at 03:42:23PM +0200, Thomas Bonnefille wrote:
>> The Sophgo SARADC is a Successive Approximation ADC that can be found in
>> the Sophgo SoC.
>>
>> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
>> ---
>>   .../bindings/iio/adc/sophgo,cv18xx-saradc.yaml     | 63 ++++++++++++++++++++++
>>   1 file changed, 63 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml
>> new file mode 100644
>> index 000000000000..31bd8ac6dfa5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml
>> @@ -0,0 +1,63 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/adc/sophgo,cv18xx-saradc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title:
>> +  Sophgo CV18XX SoC series 3 channels Successive Approximation Analog to
>> +  Digital Converters
>> +
>> +maintainers:
>> +  - Thomas Bonnefille <thomas.bonnefille@bootlin.com>
>> +
>> +description:
>> +  Datasheet at https://github.com/sophgo/sophgo-doc/releases
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +          - enum:
>> +              - sophgo,cv1800b-saradc
>> +          - const: sophgo,cv18xx-saradc
> 
> I don't think the fallback here makes sense. If there's other devices
> with a compatible programming model added later, we can fall back to the
> cv1800b.
> 

Ok I'll do that, I wasn't sure if it was a good practice to fallback on 
another SoC specific compatible.

>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    description:
>> +      SARADC will use the presence of this clock to determine if the controller
>> +      needs to be explicitly clocked by it (Active domain) or if it is part of
>> +      the No-Die Domain, along with the RTC, which does not require explicit
>> +      clocking.
> 
> What does "explicit clocking" mean? Is it clocked directly (or via
> dividers) by a clock on the board or another source?
> 

It means that, if a clock is provided, the driver will work in "Active 
Domain" and will use the clock generator of the SoC to get the right 
clock signal.

However if no clock is provided, the controller will work in "No-Die" 
domain (Always On) and use the RTCSYS subsystem to get its clock signal.

Indeed "explicitly clocked" may not be the right word to describe that, 
maybe some thing like that is better :

"SARADC will use the presence of this clock to determine if the 
controller needs to use the clock generator to get its clock signal 
(Active domain) or if it is part of the No-Die Domain, along with the 
RTC, and does not require the clock generator."

Regards,
Thomas

