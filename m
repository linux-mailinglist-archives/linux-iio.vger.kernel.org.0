Return-Path: <linux-iio+bounces-8111-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAF5943267
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 16:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E527A1F26E2E
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 14:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156911B3745;
	Wed, 31 Jul 2024 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ctjUUWua"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0EB186E4F;
	Wed, 31 Jul 2024 14:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722437293; cv=none; b=uRE2r7TfBRO1RB3FALPdR1x+fLRh9Zf9yjC8wPugLeRZp6S2Pfm4cFWnIqlX1gGtzuZVKRL41vNNXh4MYYudA+tQ/z5oUrIadzd4pCOI5RsAKtV6L1vm6QWQg4O/DObWTDM3IwNxkCKKV8vtHcondY4Kv+1FELSKBpkwozouUEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722437293; c=relaxed/simple;
	bh=bij9ygVrhf3Ik+xAO+cYZBmvHCL5kJCkWDxB4IsZekY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dxfX0HdC23P2bp/nxhtKfCBmEpFpshdT8wjAqiFwA0R3VkAvMGmcrTeZjDsgpraJ0mW94zVtD/9EgjG4g/VtjgQyVO7kniVgqyHSvTr0pSK0aEmJnMD8e8oUDDbcdwKdVu/1bcJ64vkSS/GLPvjXObYBi3zEmQrTkHKSf0sxD18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ctjUUWua; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C6188C0002;
	Wed, 31 Jul 2024 14:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722437286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BYb96CYTFrtvLLMBBd+KpMxW0vaxTI7+SnwCTQcAYKc=;
	b=ctjUUWua/Ob720TUPNUK6WWBEHCjArvTvAM0iWtrtiP/zZHCB/DIJDRi12amGQeHWeNVUc
	jBfQ/7DmDV8/ZXfUaxPWVULUSyRHEhfoEHe2loWHUR+3G+QchUW2+e8pZEOqXmX7AbGIdr
	5SBwwgJl4oOTfOttvu0fh9HOPyTTuT0/wt5k8sjdxMAwt8iGsoOs0FbmSca1Cm0ZeEivkC
	iYuIRYSI/xUqtvtzPC0ELxN6kbAkrFQ6jw2qbK51lW+ie6z5+wQHunbCWbM0BQPJPWjaEH
	5AcdDpNGM+BCLh+ighoRwk05mHSsQgjPMcu4q/xn9dwlnyADgQMmTxKPZKQkWQ==
Message-ID: <184916b4-8e7b-4ed1-913e-dc03e5f61364@bootlin.com>
Date: Wed, 31 Jul 2024 16:48:01 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: sophgo,cv18xx-saradc.yaml:
 Add Sophgo SARADC binding documentation
To: Inochi Amaoto <inochiama@outlook.com>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20240731-sg2002-adc-v3-0-5ac40a518c0a@bootlin.com>
 <20240731-sg2002-adc-v3-1-5ac40a518c0a@bootlin.com>
 <IA1PR20MB495346557FA84CC694D184A0BBB12@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Language: en-US
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
In-Reply-To: <IA1PR20MB495346557FA84CC694D184A0BBB12@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.bonnefille@bootlin.com



On 7/31/24 2:41 PM, Inochi Amaoto wrote:
> On Wed, Jul 31, 2024 at 02:24:14PM GMT, Thomas Bonnefille wrote:
>> The Sophgo SARADC is a Successive Approximation ADC that can be found in
>> the Sophgo SoC.
>>
>> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
>> ---
>>   .../bindings/iio/adc/sophgo,cv18xx-saradc.yaml     | 48 ++++++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml
>> new file mode 100644
>> index 000000000000..79d8cb52279f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml
>> @@ -0,0 +1,48 @@
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
>> +          - const: sophgo,cv1800b-saradc
> 
> There is no need to use "oneOF" and "items"
> 

Thank you very much, I'll do that.

> Suggestions: add a compatible like "cv1800-saradc" as fallback
> and add use "sophgo,cv1800b-saradc" as specific compatible.
> Use the "cv1800-saradc" in the cv18xx.dtsi and override the
> compatible with specific one if necessary.
> 

If I understand correctly, maintainers doesn't want the use of wildcards 
as generic compatibles [1]. They prefer to use the most basic SoC as the 
generic compatible.
Is the CV1800 a real SoC or is it just a kind of wildcard to say CV18* ?

> For example:
> - items:
>      - enum:
>          - sophgo,cv1800b-saradc
>      - const: sophgo,cv1800-saradc
> - const: sophgo,cv1800b-saradc
> 

To avoid the issue of falling back on a wildcard I planned to do this 
instead:
properties:
   compatible:
     const: sophgo,cv1800b-saradc



> Regards,
> Inochi

[1] : https://lore.kernel.org/all/20240708165719.000021b9@Huawei.com/

Thank you for your comments :)
Thomas

