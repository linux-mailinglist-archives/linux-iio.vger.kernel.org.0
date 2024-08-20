Return-Path: <linux-iio+bounces-8637-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244B3958C1E
	for <lists+linux-iio@lfdr.de>; Tue, 20 Aug 2024 18:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41BA51C20E90
	for <lists+linux-iio@lfdr.de>; Tue, 20 Aug 2024 16:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B141AB52A;
	Tue, 20 Aug 2024 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Izyxd3Jl"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3D8194145;
	Tue, 20 Aug 2024 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724170880; cv=none; b=d5kIId9HnCf2B0fKadUJdSQUEhhUvGCC0NtsVE+b7EyEhs95HdsFhtX0CKYFE1fg8wAlAzbRuUSsIQs0sxKGp+o+vxqdNnPxCBmzYd9/HXAd5QCCPce7HiB2mVujFzdRzkOglCzI6lvofwtCLeHZ1n+EO1SOerfKuKawSYB8B6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724170880; c=relaxed/simple;
	bh=xNL5RGtLNIhabs4Hd3NAa0FXp9Ud+N33ySeuzPmNO/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LokMgbVrqiRtz2o7jPa+DCtDmRAHYUfyehUzqFRgF87MKeBAIK0fCaCDZqWN+12tdBgMfGa2eWdHY6CHzADx8MEBKZfiw4dSx/jWhrJ0jwtbCn9skFwrKG3/oQisTHsLejQR8LXXd7zcgdeqNfuSTjepmNLX1YIUs3xoc/aid+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Izyxd3Jl; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B0F0FC0009;
	Tue, 20 Aug 2024 16:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724170869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uKCyGXB2y2Cdc43x8y99O9EX9a/Mff/KPXgIgmFwkX4=;
	b=Izyxd3JlQY3bI7qjYRGGRzXKzEjqIXWUTA8SwOGLeXBsWJ9bflw1XafR+AC3k8ODhhiI1O
	ZagoBAbsc0ixWaEUayWT4rJJrL0oHuggwExnbhpVXF5mVtampLNhrjhGX2SZTj59cz+GUa
	I87ta0Cp5NVMQrmcKglNF2zoyzlwITAyYkrDMlO4V6CD/d0nMFbKGtLklNrgYwZqxud+gJ
	zJTHLC2mVHl7iV4sKUHjsSSAGbrpSfcvDeKxK1FVkCJa6HcseWP5cRvbzM+Du+JqiGCjQg
	aBm/VIg+Fu89whSIm4a3whCGPxh4nszuZamznzowxyQefb+pDGOEtvBDjkGZrw==
Message-ID: <89aabfbe-79bf-4da7-be44-b6cbd92b72a9@bootlin.com>
Date: Tue, 20 Aug 2024 18:21:07 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: adc: sophgo,cv18xx-saradc.yaml:
 Add Sophgo CV18XX SARADC binding
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
References: <20240812-sg2002-adc-v4-0-599bdb67592f@bootlin.com>
 <20240812-sg2002-adc-v4-1-599bdb67592f@bootlin.com>
 <20240812-unwary-mongrel-9f6758bf624c@spud>
Content-Language: en-US
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
In-Reply-To: <20240812-unwary-mongrel-9f6758bf624c@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.bonnefille@bootlin.com

Hello Conor,

On 8/12/24 5:53 PM, Conor Dooley wrote:
> On Mon, Aug 12, 2024 at 05:00:55PM +0200, Thomas Bonnefille wrote:
>> The Sophgo SARADC is a Successive Approximation ADC that can be found in
>> the Sophgo SoC.
>>
>> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
>> ---
>>   .../bindings/iio/adc/sophgo,cv18xx-saradc.yaml     | 85 ++++++++++++++++++++++
>>   1 file changed, 85 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml
>> new file mode 100644
>> index 000000000000..846590808e5f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml
>> @@ -0,0 +1,85 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/adc/sophgo,cv18xx-saradc.yaml#
> 
> Filename matching the compatible please.
> 
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
>> +    const: sophgo,cv1800b-saradc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 0
>> +
>> +patternProperties:
>> +  "^channel@[0-3]+$":
>> +    $ref: adc.yaml
>> +
>> +    description: |
> 
> This | is not required.
> 
>> +      Represents the channels of the ADC.
>> +
>> +    properties:
>> +      reg:
>> +        description: |
>> +          The channel number. It can have up to 3 channels numbered from 0 to 2.
>> +        items:
>> +          - minimum: 0
>> +            maximum: 2
> 
> Is this sufficient to limit the number of channels to 3? Aren't you relying
> on the unique unit addresses warning in dtc to limit it, rather than
> actually limiting with min/maxItems?
> 
It seems like I can't use min/maxItems on this property. I think that it 
is using size-cells + address-cells to deduce that the number of items 
should be equal to 1.
Looking at the dtschema repository it seems to be the case in reg.yaml 
with address-cells/size-cells = 2/2, 1/1 and 2/1.
If I try to use maxItems here :

     properties:
       reg:
         maxItems: 1
         items:
           - minimum: 0
             maximum: 2

I get this strange error message from `make dt_binding_check`:

DTEX 
Documentation/devicetree/bindings/iio/adc/sophgo,cv1800b-saradc.example.dts
/home/thomas/linux/Documentation/devicetree/bindings/iio/adc/sophgo,cv1800b-saradc.yaml: 
patternProperties:^channel@[0-2]+$:properties:reg: {'maxItems': 1, 
'items': [{'minimum': 0, 'maximum': 2}]} should not be valid under 
{'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/home/thomas/linux/Documentation/devicetree/bindings/iio/adc/sophgo,cv1800b-saradc.yaml: 
patternProperties:^channel@[0-2]+$:properties:reg: 'anyOf' conditional 
failed, one must be fixed:
	'items' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no 
constraints defined for the values.
	'maxItems' is not one of ['description', 'deprecated', 'const', 'enum', 
'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	'items' is not one of ['description', 'deprecated', 'const', 'enum', 
'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	1 is less than the minimum of 2
		hint: Arrays must be described with a combination of 
minItems/maxItems/items
	hint: cell array properties must define how many entries and what the 
entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

Isn't it okay to just use minimum and maximum and rely on 
address-cells/size-cells for the number of items allowed ?

