Return-Path: <linux-iio+bounces-7299-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35699927217
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 10:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648411C23E3B
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 08:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2ACE1A4F1D;
	Thu,  4 Jul 2024 08:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QvbeuyiH"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106F51370;
	Thu,  4 Jul 2024 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083137; cv=none; b=CoM7eeHaeviPkf/KLjsZRxalVvftg454v+MFZGwZ2LRvWZZZ88p3XXVP41ErZKIP2kxXyPi0r4MjfDddJ1mES6emJueAdlw6/FJZ2yZE6ztJiH9Q6zC4UHG62D56jKcfn1kYPBRZFJ/3RImz5XkPIdfGPA2IMGOEb4w7K2uSmoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083137; c=relaxed/simple;
	bh=cgfOYOmbTPyQRvkyPgg9BCON57/Yve9lHmySYjtZ0gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UKA8O8Pg2oECIWOeDXOKWWdLhaQKODeKOS48wJN2MguoEYIn4QVgZRlsgwBfvCmKbRVDFqNu+YhwHdFYA6ykgHFBuMY5XLFdx38ac3XD9Upehngba+WSVwiXJbsUJtWRd/cEP7LpnTc15nrrap4f5kMq6MzGZwmzoyjKXFVe3ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QvbeuyiH; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9E3BF60014;
	Thu,  4 Jul 2024 08:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720083127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IDKEjeOdgfEzXewLaWpZ2kvSxdcVTfMIj4W1FAZEaKo=;
	b=QvbeuyiHV0xdNYQtUPU5sR8XmOZ4dwHKnjvtXtTTlYa4aTJuaZvsZXv5tV8mVUsn7E+PM9
	yOvzG3rLiaOvFXIxA6qeyO/gBdOnhxLhe2Y3Irv8/dm2aL25YSxD+xaQuO7ml2C37ot5pC
	5ez3laFbifKSS35JPIhrioDcGeMiih1M4zJ26WldmiczpHxGQskCWubzfX7Ry+GCby4qmh
	DPRo4tk419q5PaxSDcFWOh8o1yWsNjzTJtcrNCur1x9JjFTusyYdMG/dIphN+TPur/DHo3
	EdowHlLe0K7KraEFSfWvc0ZgBVWX4vq3GqgM2BdacqnZ5u7IB46ImBqDgSfDEA==
Message-ID: <0d50df10-4b4e-47c4-930f-cd8f645a7e2d@bootlin.com>
Date: Thu, 4 Jul 2024 10:52:05 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: sophgo,cv18xx-saradc.yaml: Add
 Sophgo SARADC binding documentation
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Inochi Amaoto <inochiama@outlook.com>, Chen Wang <unicorn_wang@outlook.com>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20240702-sg2002-adc-v1-0-ac66e076a756@bootlin.com>
 <20240702-sg2002-adc-v1-1-ac66e076a756@bootlin.com>
 <b7913f90-7405-4a77-9c57-97ef124de6e1@kernel.org>
 <8d368347-7cee-41af-a033-c495eeb62e2a@bootlin.com>
 <577a5623-6dd8-4229-9c07-61e131a01aa8@kernel.org>
Content-Language: en-US
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
In-Reply-To: <577a5623-6dd8-4229-9c07-61e131a01aa8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.bonnefille@bootlin.com



On 7/4/24 10:39 AM, Krzysztof Kozlowski wrote:
> On 04/07/2024 10:35, Thomas Bonnefille wrote:
>> Hello Krzysztof,
>> Thank you for your feedback
>>
>> On 7/3/24 7:08 AM, Krzysztof Kozlowski wrote:
>>> On 02/07/2024 13:52, Thomas Bonnefille wrote:
>>>> The Sophgo SARADC is a Successive Approximation ADC that can be found in
>>>> the Sophgo SoC.
>>>>
>>>> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
>>>> ---
>>>>    .../bindings/iio/adc/sophgo,cv18xx-saradc.yaml     | 51 ++++++++++++++++++++++
>>>>    MAINTAINERS                                        |  5 +++
>>>>    2 files changed, 56 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml
>>>> new file mode 100644
>>>> index 000000000000..21fd5dc8e24e
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml
>>>> @@ -0,0 +1,51 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/iio/adc/sophgo,cv18xx-adc.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Sophgo 3 channels Successive Approximation Analog to Digital Converters
>>>> +
>>>> +maintainers:
>>>> +  - Thomas Bonnefille <thomas.bonnefille@bootlin.com>
>>>> +
>>>> +description:
>>>> +  Datasheet at https://github.com/sophgo/sophgo-doc/releases
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: sophgo,cv18xx-saradc
>>>
>>> Except that this was never tested... wild-cards are generally not allowed.
>>>
>>
>> I realized I made a mistake when using the "make dt_binding_check"
>> command, which led to some errors in this dt_binding. I have now
>> addressed all of them, but I'm not sure I understand your comment.
>>
>> I don't see any wildcards in the YAML file. Could you please provide
>> more details on what you expect?
> 
> What is "xx"? Sounds like wildcard. I do not see such SoC compatible.
> 

The point of cv18xx is to have a single compatible for all SoCs of the 
cv18xx series from Sophgo (cv1800b, cv1812h but also sg2000 and sg2002). 
I used that as a reflection of the cv18xx.dtsi used for all those SoCs.

Should I create multiple compatible for all the SoCs of a same brand ?

> Best regards,
> Krzysztof
> 

