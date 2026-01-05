Return-Path: <linux-iio+bounces-27481-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 70900CF2B00
	for <lists+linux-iio@lfdr.de>; Mon, 05 Jan 2026 10:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8BAF43002842
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jan 2026 09:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCF332FA32;
	Mon,  5 Jan 2026 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ig2D00nS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B4F32FA2D;
	Mon,  5 Jan 2026 09:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767604727; cv=none; b=DYRW/nLv9ScTDwJKw5LP9FrXpuG284aRYXc32LDFT86Y4Vfu3y0cjlYqijVJtmfHmKKks2YE9PI4U+0fOlVGapi+PDhy8gsUq7Opj/h3gcnR+WjWmCwfqkqGzllDbUqIcA0wElUE9Wir+q0J3xBtnOVDoFXWtTwLT6WJseehFow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767604727; c=relaxed/simple;
	bh=vNkwR1Ju/CZyGHDrg1qDw3LgoH8NLYBIB7LXXhcsPPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tTW8AmnRMAmP6PT9Zj+CYLwc2urSW23P/UjW2eGbjCNYoLGushFSvDQsMMK5HvP3+p8mu+gGigXzsRNxD9gVfwF3+3tMZ6kHUEeGXHVNwo4iY3r87vGBArmyc7k6Whi6tuC0xQxya+R/rETqna/CL70Nb25H3oXSKovbvZcvhkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ig2D00nS; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 53E6C1A264A;
	Mon,  5 Jan 2026 09:18:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2961060726;
	Mon,  5 Jan 2026 09:18:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 66EE3103C84B1;
	Mon,  5 Jan 2026 10:18:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767604723; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=r127s6dl25GpRpIM7mZ/xamTGfKd8WdDgfo8ge//VIc=;
	b=ig2D00nSs+yf3M5Oqeox7dRpTCLX3YJydya//pUM9jWE6heJhPdVmEQ3MsCij1Mn7yDlWw
	UYkj4bp+k6iOUeFsJ0IDZZzHP9i9ADPOSD33IMN462BWpEZnlGfBsrXAVWa58Y4CvFucSB
	sGX3qFEBQpMBCwuKtXfIARTe2gyJcrKYZ8eXeKNTBeItOqk2IEFDM2NIhq2SEcV1yB0jCT
	Ld2Yy6kFoN7BCUFejF7MMkq+/WwCtitKXe0/cX1k+5SA3rdUCXYItmIXRotxFwgDgEVBV7
	I6yfQCJ2SQ5UZOQL1Nvwo3IEvaXHfpnCzNmw0RQurQXVBVPRzAilbe1ivCFQNQ==
Message-ID: <a8cd864e-76af-4d81-b5a3-6ad6d88e0b26@bootlin.com>
Date: Mon, 5 Jan 2026 10:18:40 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: add Texas Instruments TLA 2528
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, nuno.sa@analog.com, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Angelo Dureghello <adureghello@baylibre.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Eason Yang <j2anfernee@gmail.com>,
 Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
 Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
 duje@dujemihanovic.xyz, herve.codina@bootlin.com,
 Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
References: <20251223155534.220504-1-maxime.chevallier@bootlin.com>
 <20251223155534.220504-2-maxime.chevallier@bootlin.com>
 <56c03c7f-1e5b-4586-beb0-47a1fa3bc86c@baylibre.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <56c03c7f-1e5b-4586-beb0-47a1fa3bc86c@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 23/12/2025 19:26, David Lechner wrote:
> On 12/23/25 9:55 AM, Maxime Chevallier wrote:
>> The TI TLA 2528 is a simple 8 channel, 12-bit ADC? Add a binding
> 
> TLA2528 (no space). Also, why the "?"?

that's a typo :) thanks for spotting

> 
>> documentation for it.
>>
>> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
>> ---
>>  .../bindings/iio/adc/ti,tla2528.yaml          | 48 +++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,tla2528.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,tla2528.yaml b/Documentation/devicetree/bindings/iio/adc/ti,tla2528.yaml
>> new file mode 100644
>> index 000000000000..0ee326d77014
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/ti,tla2528.yaml
>> @@ -0,0 +1,48 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/adc/ti,tla2528.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Texas Instruments TLA2528 8-channel 12bit I2C ADC
> 
> 12-bit
> 
>> +
>> +maintainers:
>> +  - Maxime Chevallier <maxime.chevallier@bootlin.com>
>> +
>> +description: |
>> +  12bit 8-channel I2C ADC.
> 
> The title already says this. Either drop it or add new info.
> 
> Also, don't need the |.
> 
>> +
>> +properties:
>> +  compatible:
>> +    const: ti,tla2528
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  vref-supply:
>> +    description: Supply for 2.35V to 5.5V reference voltage
> 
> According the the datasheet, there are AVDD and DVDD supplies.
> Nothing named VREF or REF.
> 
> So instead:
> 
> avdd-supply: true
> dvdd-supply: true

Sure thing, I'll add both instead

> 
> 
> It looks like inputs can also be used as GPIOs, so
> 
> gpio-controller: true
> #gpio-cells:
>   const: 2
> 
> would be appropriate (it doesn't matter if the driver doesn't
> implement it, we know what the correct bindings are).

Ack, makes a lot of sense

> 
>> +
>> +  "#io-channel-cells":
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - vref-supply
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        adc@17 {
>> +            compatible = "ti,tla2528";
>> +            reg = <0x17>;
>> +            vref-supply = <&reg_adc_supply>;
>> +            #io-channel-cells = <1>;
>> +        };
>> +    };
>> +...
> 

Thank you for reviewing,

Maxime

