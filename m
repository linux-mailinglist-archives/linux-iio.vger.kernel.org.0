Return-Path: <linux-iio+bounces-26815-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C1ECA9A7C
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 00:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13BFC301294F
	for <lists+linux-iio@lfdr.de>; Fri,  5 Dec 2025 23:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27C42F0678;
	Fri,  5 Dec 2025 23:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MrOnSxTi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0DD296BC9
	for <linux-iio@vger.kernel.org>; Fri,  5 Dec 2025 23:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764978219; cv=none; b=aYmBhFlodIB5fqRGycyMTe7WlCjJ0Mb3FT/0/mUyvw2U4H9uHwen4lLTTwFb5Y8aBoIB35mwsv4wj44ul1OyGXGbr+ZTL6WoDGfFuW8DL6CU6LYric9xxe6F8Oc7Y2i8MZpEJg8cSybvpsPlRBZR5y07aSpZY14YUWICHLkZQxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764978219; c=relaxed/simple;
	bh=ymmoMmY+M7v3E6X4qH+gCcBdlU/gh+Nshf57K3Y1Zp0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Dm1Wom1lFOb40EEWYpJfGERGrTdUesLfnCTvenGynmTNIoT4RMYWCTA5ksJ+S+mh8mtgE96kXsEkf7pRewoY41qr9VD6qYL4P/H83pj1ffgFcmGSA2ghB42Gq+gptdYEqRg18/3+I7nYXlXMMC38xjxSxOjbI2DAL8aXvaiwYHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MrOnSxTi; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7c75fc222c3so1347305a34.0
        for <linux-iio@vger.kernel.org>; Fri, 05 Dec 2025 15:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764978215; x=1765583015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eKfSkEPDwGAdvZ6q/5g13vGrLD2gNvPK5mOSub797OA=;
        b=MrOnSxTit98g/SlWGwi7bR59k+mr0b2z5grw/CFB0U62zBd3kT8fz/megWaCFcGviS
         nBOcvZq32S64yc0ZkF4/65PYJ+dLti7v9VPb34D1yP+gMfCHY8dhBoLxpTei06nSPBXa
         0dvu6IwxZ+u9TzL30PlvcUUofQcLT/e3dlNuEyOSmX4ttWxlJwgkz0g2ElNgxkJjLG4M
         yosrK5CdZgr7yPsGeb2c6SEO+YqpNKdYjfXphKYL/c8cYG3K0q1SmEGbXqhd5WX1pBrA
         kiw/zlfnqu8/XVamLk7PE1T+qqUxfpiJ+NWBuRNZbCBS4CxVibBZM9H/ZKF/4GomVFd7
         1/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764978215; x=1765583015;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eKfSkEPDwGAdvZ6q/5g13vGrLD2gNvPK5mOSub797OA=;
        b=af0nVcRrJOcr8JnCmodLfCJvfKUDqCSbiYCjcCq2GP7Udk+ALvQf3Ktwxo44DHFwKw
         NJk5rHASe0VYF8cPqshot+xD2AGwHvGhLZsNufIsmUs1C/+qR1/xIxS0wWwoo6IRRdTy
         yRbLR9RS8j9LBdufLHNRf+pChddplaKZs1y9fBd5pJ5eTw3nkTS8hR8QUoaiDEKySP6w
         Yvy3mfCmZbQU+SBh24Jg/V0RCqGT9mH2BCCLdb58qW8nn3iL5zJ8AVtWuMwE8+ZECRVO
         RVaPv5/FB7EP3CHq8nWavqUZizdCdOjk//pnS3lMkyMgdlKfLFRcIs0z5Ryt4M8OEBNp
         8cKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX81qyNobIr4q9gW0VBzia3UZK/zHkJFxaX/h4fQBwQmI9JOO/6qZFaRQ7i+Tt85Ke6NbAEdga/Ie0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5uYooKj5UcBmWPNf76lkvbaBTDbIFUfIvQJZFeaxVF/1uKQUf
	cjJLHo6SF+BSf4bV8ctbPJolDEwuPUWzhMM5KnUklwQBAPZgtxJ/Q0f4K07P+hNByeY=
X-Gm-Gg: ASbGncsngPi8n1llmhiKboOQJCLVVxczXYDit96MqpBVGrcnnveqIU4B+m22le7xzej
	TOQoepo+OWXKXeynEwWAlMlHWi9U5Gm/BxKktu8MZjAVl4XqTzSjGs0vYHoeSeqPiVZAOYISBaV
	vcHzqJtL/6yPQcBj36SdbUcn2M8ns+hNPrBkKGd+9WJeXhQXnrEfnu26R5yiXIeHiWSeJDLMeqB
	2FBRcZTkuxRZdHfwK7X0Hu6IUlWj4eWCr6IasHP+8gdQNUqJYb11OG4JWZpv57Tp7JDY0BDmDY2
	7B4Mnci58LO3GLT6gPpOTHc6KK2U9W3rpgxHsp+Se9/zfMoYYghLyS5wGlB5FsIVvKrJxEzjDEz
	XYf04WJ3O4xNbZOSbN9Z3nhTc7L0DaGib6cdg7aY2PI4QmHEJ1Xqtr+lu3WeBDnK6g98cp7sFbV
	xaDPMqDf2BpMoQ2ZnsmNKHgAbL7iwHL4IhlSk9uicwRdekxtGl3IaYkRHSjJgi
X-Google-Smtp-Source: AGHT+IE48+ggp5bjLDJBiBGemBDHRXrklsIKBMD6YY+3ejE8zM3+hfCR8kARCmKGp6SGYHbbJYcheg==
X-Received: by 2002:a05:6808:c1aa:b0:450:1b83:a092 with SMTP id 5614622812f47-4539e0c6b69mr248647b6e.63.1764978214893;
        Fri, 05 Dec 2025 15:43:34 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:d73b:96e3:ec16:ea39? ([2600:8803:e7e4:500:d73b:96e3:ec16:ea39])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-453801386eesm3005267b6e.17.2025.12.05.15.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 15:43:33 -0800 (PST)
Message-ID: <221d5ed6-51da-4dce-b8a7-58b4d2423101@baylibre.com>
Date: Fri, 5 Dec 2025 17:43:31 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] dt-bindings: iio: adc: adi,ad4030: add data-lanes
 property
From: David Lechner <dlechner@baylibre.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Rob Herring <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20251201-spi-add-multi-bus-support-v3-0-34e05791de83@baylibre.com>
 <20251201-spi-add-multi-bus-support-v3-7-34e05791de83@baylibre.com>
 <20251204213348.GA2198382-robh@kernel.org>
 <aTNKyaWAEjVJixMI@debian-BULLSEYE-live-builder-AMD64>
 <0cf78f84-01e7-4507-abf9-2f82f98206b2@baylibre.com>
Content-Language: en-US
In-Reply-To: <0cf78f84-01e7-4507-abf9-2f82f98206b2@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/25 3:33 PM, David Lechner wrote:
> On 12/5/25 3:12 PM, Marcelo Schmitt wrote:
>> On 12/04, Rob Herring wrote:
>>> On Mon, Dec 01, 2025 at 08:20:45PM -0600, David Lechner wrote:
>>>> Add data-lanes property to specify the number of data lanes used on the
>>>> ad463x chips that support reading two samples at the same time using
>>>> two data lanes with a capable SPI controller.
>>>>
>>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>>> ---
>>>> v3 changes: new patch
>>>>
>>>> I added this one to give a real-world use case where spi-rx-bus-width
>>>> was not sufficient to fully describe the hardware configuration.
>>>>
>>>> spi-rx-bus-width = <4>; alone could be be interpreted as either:
>>>>
>>>> +--------------+    +----------+
>>>> | SPI          |    | AD4630   |
>>>> | Controller   |    | ADC      |
>>>> |              |    |          |
>>>> |        SDIA0 |<---| SDOA0    |
>>>> |        SDIA1 |<---| SDOA1    |
>>>> |        SDIA2 |<---| SDOA2    |
>>>> |        SDIA3 |<---| SDOA3    |
>>>> |              |    |          |
>>>> |        SDIB0 |x   | SDOB0    |
>>>> |        SDIB1 |x   | SDOB1    |
>>>> |        SDIB2 |x   | SDOB2    |
>>>> |        SDIB3 |x   | SDOB3    |
>>>> |              |    |          |
>>>> +--------------+     +---------+
>>>>
>>>> or
>>>>
>>>> +--------------+    +----------+
>>>> | SPI          |    | AD4630   |
>>>> | Controller   |    | ADC      |
>>>> |              |    |          |
>>>> |        SDIA0 |<---| SDOA0    |
>>>> |        SDIA1 |<---| SDOA1    |
>>>> |        SDIA2 |x   | SDOA2    |
>>>> |        SDIA3 |x   | SDOA3    |
>>>> |              |    |          |
>>>> |        SDIB0 |<---| SDOB0    |
>>>> |        SDIB1 |<---| SDOB1    |
>>>> |        SDIB2 |x   | SDOB2    |
>>>> |        SDIB3 |x   | SDOB3    |
>>>> |              |    |          |
>>>> +--------------+     +---------+
>>>>
>>>> Now, with data-lanes having a default value of [0] (inherited from
>>>> spi-peripheral-props.yaml), specifying:
>>>>
>>>>     spi-rx-bus-width = <4>;
>>>>
>>>> is unambiguously the first case and the example given in the binding
>>>> documentation is the second case:
>>>>
>>>>     spi-rx-bus-width = <2>;
>>>>     data-lanes = <0>, <1>;
>>>
>>> I just reviewed this and all, but what if you just did:
>>>
>>> spi-rx-bus-width = <2>, <2>;
>>>
>>> So *-bus-width becomes equal to the number of serializers/channels.
>>
>> Unless I'm missing something, I think that would also describe the currently
>> possible use cases as well. To me, it actually seems even more accurate than
>> data-lanes. The data-lanes property only describes the SPI controller input
>> lines/lanes, no info is given about the output lanes.
> 
> It describes both directions.
> 
>> Well yeah, that would only> be a problem for a device with multiple input serializers and multiple output
>> serializers. Still, the *-bus-width = <N>, <N>, ... <N>; notation looks clearer,
>> IMHO.
>>
>>>
>>> Rob
>>>
> 
> It think it complicates Sean's use case though where such
> a controller is being used as basically two separate SPI
> buses.
> 
> For that case, we want to be able to do:
> 
> spi {
> 	...
> 
> 	thing@0 {
> 		compatible = ...;
> 		reg = <0>;
> 		/* (implicit) data-lanes = <0>; */
> 	};
> 
> 	thing@1 {
> 		compatible = ...;
> 		reg = <1>;
> 		data-lanes = <1>;
> 	};
> };
> 
> Meaning:
> 
> +--------------+    +----------+
> | SPI          |    | Thing 1  |
> | Controller   |    |          |
> |              |    |          |
> |          CS0 |--->| CS       |
> |         SDI0 |<---| SDO      |
> |         SDO0 |--->| SDI      |
> |        SCLK0 |--->| SCLK     |
> |              |    |          |
> |              |    +----------+
> |              |                
> |              |    +----------+
> |              |    | Thing 2  |
> |              |    |          |
> |          CS1 |--->| CS       |
> |         SDI1 |<---| SDO      |
> |         SDO1 |--->| SDI      |
> |        SCLK1 |--->| SCLK     |
> |              |    |          |
> +--------------+    +----------+
> 
> (I don't remember if SCLKs are shared or separate, but I don't
> think that is relevant anyway).
> 
> 
> I guess we could write it like this?
> 
> spi {
> 	...
> 
> 	thing@0 {
> 		compatible = ...;
> 		reg = <0>;
> 	};
> 
> 	thing@1 {
> 		compatible = ...;
> 		reg = <1>;
> 		spi-tx-bus-width = <0>, <1>;
> 		spi-rx-bus-width = <0>, <1>;
> 	};
> };
> 
> 

I started down this road. Before I do the working of changing the
whole series, this is what it will probably look like. Is this really
what we want?

There is one issue I see with this. If we allow <0> to mean that a lane
isn't wired up on the controller, then we can't constrain the length of
the array in peripheral bindings. For example, the ad403x chips can only
have one lane and the ad463x chips can have one or two lanes. But I
don't see a way to express that in the binding if <0> at any index
doesn't count towards the number of lanes that are actually wired up.

This is e.g. why the binding in sitronix,st7789v.yaml is

	items:
	  enum: [0, 1]

rather than

	items:
	  - enum: [0, 1]

---
commit 049b9508b1b0190f87a4b35fe3ed8a9f3d0d3c50
Author: David Lechner <dlechner@baylibre.com>
Date:   Fri Dec 5 16:09:08 2025 -0600

    spi: dt-bindings: change spi-{rx,tx}-bus-width to arrays
    
    Change spi-rx-bus-width and spi-tx-bus-width properties from single
    uint32 values to arrays of uint32 values. This allows describing SPI
    peripherals connected to controllers that have multiple data lanes for
    receiving or transmitting two or more words at the same time.
    
    Bindings that make use of this property are updated in the same commit
    to avoid validation errors. Bindings that used minimum/maximum are
    changed to use enum instead to be consistent with the base property
    definition.
    
    The adi,ad4030 binding has an example added now that we can fully
    describe the peripheral's capabilities.
    
    Converting from single uint32 to array of uint32 does not break .dts/
    .dtb files since there is no difference between specifying a single
    uint32 value and an array with a single uint32 value in devicetree.
    
    Signed-off-by: David Lechner <dlechner@baylibre.com>
---   

diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
index 0ce2ea13583d..23b33dcd5ed4 100644
--- a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
@@ -34,8 +34,8 @@ properties:
   spi-cpol: true
 
   spi-rx-bus-width:
-    minimum: 0
-    maximum: 1
+    items:
+      enum: [0, 1]
 
   dc-gpios:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
index 54e7349317b7..6052a44b04de 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
@@ -37,7 +37,8 @@ properties:
     maximum: 102040816
 
   spi-rx-bus-width:
-    enum: [1, 2, 4]
+    items:
+      enum: [1, 2, 4]
 
   vdd-5v-supply: true
   vdd-1v8-supply: true
@@ -108,3 +109,23 @@ examples:
             reset-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
         };
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad4630-24";
+            reg = <0>;
+            spi-max-frequency = <80000000>;
+            spi-rx-bus-width = <4>, <4>;
+            vdd-5v-supply = <&supply_5V>;
+            vdd-1v8-supply = <&supply_1_8V>;
+            vio-supply = <&supply_1_8V>;
+            ref-supply = <&supply_5V>;
+            cnv-gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
index cbde7a0505d2..e15d985e8c59 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
@@ -38,8 +38,8 @@ properties:
   spi-cpha: true
 
   spi-rx-bus-width:
-    minimum: 1
-    maximum: 4
+    items:
+      enum: [1, 2, 4]
 
   avdd-supply:
     description: Analog power supply.
diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml
index e1ab3f523ad6..a34e6471dbe8 100644
--- a/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml
@@ -55,10 +55,12 @@ patternProperties:
           maximum: 4
 
       spi-rx-bus-width:
-        const: 1
+        items:
+          - const: 1
 
       spi-tx-bus-width:
-        const: 1
+        items:
+          - const: 1
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
index 3b47b68b92cb..414f5bc36304 100644
--- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
@@ -77,10 +77,12 @@ patternProperties:
           maximum: 4
 
       spi-rx-bus-width:
-        const: 1
+        items:
+          - const: 1
 
       spi-tx-bus-width:
-        const: 1
+        items:
+          - const: 1
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
index 8b3640280559..909c204b8adf 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
@@ -54,10 +54,12 @@ patternProperties:
 
     properties:
       spi-rx-bus-width:
-        enum: [1, 2, 4]
+        items:
+          - enum: [1, 2, 4]
 
       spi-tx-bus-width:
-        enum: [1, 2, 4]
+        items:
+          - enum: [1, 2, 4]
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 8b6e8fc009db..6288740d8af3 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -64,9 +64,17 @@ properties:
     description:
       Bus width to the SPI bus used for read transfers.
       If 0 is provided, then no RX will be possible on this device.
-    $ref: /schemas/types.yaml#/definitions/uint32
-    enum: [0, 1, 2, 4, 8]
-    default: 1
+
+      Some SPI peripherals and controllers may have multiple data lanes for
+      receiving two or more words at the same time. If this is the case, each
+      index in the array represents the lane of the SPI controller. Lanes of
+      the peripheral are assumed to be connected in a logical order for each
+      non-zero entry in the array. Indexes where both spi-rx-bus-width and
+      spi-tx-bus-width are 0 are interpreted as not connected.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      enum: [0, 1, 2, 4, 8]
+    default: [1]
 
   spi-rx-delay-us:
     description:
@@ -81,9 +89,17 @@ properties:
     description:
       Bus width to the SPI bus used for write transfers.
       If 0 is provided, then no TX will be possible on this device.
-    $ref: /schemas/types.yaml#/definitions/uint32
-    enum: [0, 1, 2, 4, 8]
-    default: 1
+
+      Some SPI peripherals and controllers may have multiple data lanes for
+      transmitting two or more words at the same time. If this is the case, each
+      index in the array represents the lane of the SPI controller. Lanes of
+      the peripheral are assumed to be connected in a logical order for each
+      non-zero entry in the array. Indexes where both spi-rx-bus-width and
+      spi-tx-bus-width are 0 are interpreted as not connected.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      enum: [0, 1, 2, 4, 8]
+    default: [1]
 
   spi-tx-delay-us:
     description:


