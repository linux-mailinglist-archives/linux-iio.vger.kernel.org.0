Return-Path: <linux-iio+bounces-26371-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A8DC7BB0E
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 21:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 701AD4E1A25
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 20:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5912E8B84;
	Fri, 21 Nov 2025 20:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKNSDk6i"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B801E0DFE
	for <linux-iio@vger.kernel.org>; Fri, 21 Nov 2025 20:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763758609; cv=none; b=It1yZuS5vJPKln7+3xGrEff3tK9Flnnvm3w6yogd2MA7JKJ4Yz7vUXOllWEOmlY2x444RO1xAyMfAwYkU2Dz3sKf1Xbc1NqKvHDrkomOlkjWg4bqrSmI2BFrln3nAgp0Xl1nLu2Tl+3bJj6rdMc+/o4KNwJTOrrrmUA6fLLlNkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763758609; c=relaxed/simple;
	bh=7uksRBnfK3K3nAtGLE08L1+hYX17PYdp83wl89HyR5o=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=eHKuYfNvOFQ0ysiPHiGygMZq3F7rYicgYRTF4ha/BzipsH3AcWy3xyg+jcwLj2E2jPeKo/RQesMDcBa8GGb1L7o2ye08l9t19Ci9sh+xz69sxiHHkB+Bn7Mns82g+z3afBGTX7PEDXsDp2iN7KZjRrt+t0sLkHFoFfQxchu98ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKNSDk6i; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5de0c1fa660so803994137.1
        for <linux-iio@vger.kernel.org>; Fri, 21 Nov 2025 12:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763758606; x=1764363406; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3wAic5FhNcDCB3A5RECBp8DoRSHHZ6/CbFE+9ai9bc=;
        b=cKNSDk6ieO+jqF2qHSsiQWZ9/JNdhO042wwuHVQusuLZ6D3Y7aUu8yjdCx/yxnGcnv
         tT6eaYKt9+ZjfLir/ECImNnT0B7HLAJ3Lu9yOs0Q34WZn+cUL/diUozWqeHG4rPtYNQY
         HGiAFahJdGvugMcxH1P5R2TNIcDPAfx7xPYHA2nhziksKuGzZEGxfJNhccZlfoIPCowI
         +roVL9njUYFDMpSrtpdlhInDvTZOguWofe6HsIs+d4OPee9v8XSPqWihPTIvWQEtOqZa
         vWDf9hqQOPp969UeSHS9hChZZEZ9TqwGOP24cOl0Z6RQQ5ojS8EBwAphQ0mNEzvhIUt8
         9GdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763758606; x=1764363406;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q3wAic5FhNcDCB3A5RECBp8DoRSHHZ6/CbFE+9ai9bc=;
        b=GoT7LzCniolq6e+4frZ1MX6CuL17eH0oV3WhwFaAIjCqUwNQnAK20xRlq4NHzDg6sX
         Vs2bUvafoBsiFEMrfOa/NSlF0Nc3ToQTaOXBEPjDqgfbgS2sKytgjx2C0NgvNXQLtPay
         X8WpgsOxLVbodR0QUTYVFi5IYX50pAnzV2jzD9tK1J9wgI8KQBmBQjw68HY/KwLaKoR6
         XPVpcw4e9zs5Rmy/3vG5cZ+YZ5uS1GGR5F6pgvZfuzszq9peTvSgfIvgcDMmT3PFRsdR
         jTBBcMHjVE7M1JQ5Gfwsna5xj7/58PPfC2xdLdi0HmwIDEA3sVZ9JpR2hg8+HwWCiQOR
         nBnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP8JfLJOIpvQ9ixYQmybZC/Ezjs2eCHHmJaOzsBDM8w7ESPU+YivLVEtyLA1CWz9Gx9bvbyNlZo/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6R4fs1FtGu+a5PuJsYCeC+oIQofOQCsWPNj00NAGFBCyQheqi
	QPwgS8Fj7xxQmhv0wBD3Oc1sR7UPTzrZOC/ydyFyEEx6bbUYvV4uQO7/
X-Gm-Gg: ASbGncuodER3pxAOb9XOnV6SKxkPcCeE3T+6umm2LS4YPyyO6EQbx43JLGV5y75WnlR
	EiwGxWymw/4qmz/Piph0oSiUaM44eoFtzlZ+q09XStnj668hysHSyaBTnQ+rx5NqN1D9jHvAfCK
	oo29TFSBVGhMMad4QiDEAZcM04dEGFtvB5S/YwfSWMVSSl7zay1lm4MKTWcgkffxmmkQjc5Wck0
	HZABfCzWe/Ey93UoBBCVpRYNX62wWOX4Ktv1c/l4yVgNCMr9pBDhXa5VgNptCJ5Splkgye8LmMJ
	+OifFwWF9cyoSaJLUp8052qVBPkHYO8HLcyDZMVlchzzD2nfH3971BfyKeDufGufnWD0o3HySxr
	fbmLpchgSIfY4JdnhgS5YE+OEpOkessAkaHnTr+rHtqmIEgGnwgAvBxBd7lFv19p7PMOtkNm1Ep
	IBgFqCm7WLFKOYEw==
X-Google-Smtp-Source: AGHT+IENv8YWM05cBPNs2ogCuYE12Fl+bVDAg6kzB4RNjxXY2aUQDDydPC+4XXSAj7+RKW6uB+O5yw==
X-Received: by 2002:a05:6102:2b87:b0:5d7:dec5:b6a7 with SMTP id ada2fe7eead31-5e1de18ed8fmr1291583137.7.1763758606460;
        Fri, 21 Nov 2025 12:56:46 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93c5658147fsm2864175241.15.2025.11.21.12.56.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 12:56:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Nov 2025 15:56:43 -0500
Message-Id: <DEEO8SSA15XY.1SDBZEILR5AHM@gmail.com>
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, "Kurt Borja"
 <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Tobias Sperling"
 <tobias.sperling@softing.com>
Cc: "David Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Jonathan Cameron"
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add TI ADS1018/ADS1118
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251121-ads1x18-v1-0-86db080fc9a4@gmail.com>
 <20251121-ads1x18-v1-1-86db080fc9a4@gmail.com>
 <32e76bff-f535-40ce-88e2-7bbf7da87620@kernel.org>
In-Reply-To: <32e76bff-f535-40ce-88e2-7bbf7da87620@kernel.org>

Hi Krzysztof,

On Fri Nov 21, 2025 at 2:10 PM -05, Krzysztof Kozlowski wrote:
> On 21/11/2025 18:16, Kurt Borja wrote:
>> Add documentation for Texas Instruments ADS1018 and ADS1118
>> analog-to-digital converters.
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>
> You did not test it before sending, so no full review but few nits to
> save you one round of reviews:

My bad! I will fix the errors. Thanks!

>
>> ---
>>  .../devicetree/bindings/iio/adc/ti,ads1118.yaml    | 132 ++++++++++++++=
+++++++
>>  1 file changed, 132 insertions(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1118.yaml b=
/Documentation/devicetree/bindings/iio/adc/ti,ads1118.yaml
>> new file mode 100644
>> index 000000000000..eb7228ed6ddb
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1118.yaml
>> @@ -0,0 +1,132 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/adc/ti,ads1118.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: TI ADS1018/ADS1118 SPI analog to digital converter
>> +
>> +maintainers:
>> +  - Kurt Borja <kuurtb@gmail.com>
>> +
>> +description: |
>> +  The ADS1018/ADS1118 is a precision, low-power, 12-bit or 16-bit, nois=
e-free,
>> +  analog-to-digital converter (ADC). It integrates a programmable gain =
amplifier
>> +  (PGA), voltage reference, oscillator and high-accuracy temperature se=
nsor.
>> +
>> +  Datasheets:
>> +    - ADS1018: https://www.ti.com/lit/ds/symlink/ads1018.pdf
>> +    - ADS1118: https://www.ti.com/lit/ds/symlink/ads1118.pdf
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ti,ads1018
>> +      - ti,ads1118
>> +
>> +  reg:
>> +    maxitems: 1
>> +
>> +  interrupts:
>> +    description: DOUT/DRDY (Data Out/Data Ready) line.
>> +    maxitems: 1
>> +
>> +  drdy-gpios:
>> +    description:
>> +      Extra GPIO line connected to DOUT/DRDY (Data Out/Data Ready). Thi=
s allows
>> +      distinguishing between latched and real DRDY IRQs.
>
> I have feeling that you miss proper handling of IRQs (e.g. active level)
> on your board.

Can you elaborate? Should I specify active level here?

>
>> +    maxitems: 1
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 0
>> +
>> +  '#io-channel-cells':
>> +    const: 1
>> +
>> +required:
>
> This goes after patternProperties.
>
>> +  - compatible
>> +  - reg
>> +  - drdy-gpios
>> +  - '#address-cells'
>> +  - '#size-cells'
>> +
>> +patternProperties:
>> +  "^channel@[0-7]$":
>> +    type: object
>> +    $ref: /schemas/iio/adc/adc.yaml#
>> +    description: Properties for a single ADC channel.
>> +
>> +    properties:
>> +      reg:
>> +        minimum: 0
>> +        maximum: 7
>> +        description: The channel index (0-7).
>> +
>> +      ti,gain:
>
> Use common property units.
>
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pr=
operty-units.yaml
>
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        minimum: 0
>> +        maximum: 5
>> +        description:
>> +          Programmable gain amplifier configuration, as described in th=
e PGA
>> +          Config Register Field description. If not present, the defaul=
t is
>> +          used.
>> +
>> +      ti,datarate:
>
> Use common property units.
>
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        minimum: 0
>> +        maximum: 7
>> +        description:
>> +          Data rate configuration, as described in the DR Config Regist=
er Field
>> +          description. If not present, the default is used.
>
> default:
>
>> +
>> +    required:
>> +      - reg
>> +
>> +    additionalProperties: false
>> +
>> +allOf:
>> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>> +
>> +  - if:
>> +    properties:
>> +      compatible:
>> +        contains:
>> +          const: ti,ads1018
>> +    then:
>> +      patternProperties:
>> +        "^channel@[0-7]$":
>> +          properties:
>> +            ti,datarate:
>> +              maximum: 6
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    spi0 {
>
> spi
>
>> +        #address-cells =3D <1>;
>> +        #size-cells =3D <0>;
>> +
>> +        ads1118@0 {
>
>
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-device=
tree-basics.html#generic-names-recommendation
> If you cannot find a name matching your device, please check in kernel
> sources for similar cases or you can grow the spec (via pull request to
> DT spec repo).
>
> e.g. adc
>
>
>> +            compatible =3D "ti,ads1118";
> Best regards,
> Krzysztof

Ack for the rest. Thank you!


--=20
 ~ Kurt


