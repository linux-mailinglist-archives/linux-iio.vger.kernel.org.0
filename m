Return-Path: <linux-iio+bounces-26380-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72247C7C028
	for <lists+linux-iio@lfdr.de>; Sat, 22 Nov 2025 01:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 152C84E1AF9
	for <lists+linux-iio@lfdr.de>; Sat, 22 Nov 2025 00:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8642F1EEA5F;
	Sat, 22 Nov 2025 00:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHuEdCGo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17F51D5AC6
	for <linux-iio@vger.kernel.org>; Sat, 22 Nov 2025 00:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763771189; cv=none; b=kaRR+/mAj3wZm1y6sDVhofcSS5MDF3nifIPYFKiI8amDEufomuSfJKj3Zlj8yH43IidMheD6hMWYqm+uuduKSGBEmtNpmfHLnPoIgUDTAK/rYXztDl0dYER35fEN+x4yw5gGJIvjhx36UYXjC+sXddJUbx1qEiL9MqjJaBTGj/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763771189; c=relaxed/simple;
	bh=bDC+LxsuLI7dLZ+JKqVXr59YLNIGptoJM8bUsszq5+Q=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=aSZxUa/u0oDiCysIA8t0YHMj59NYRLRTPIEGsuCpLPF7CqAzzM+oNfS2fDVLgTx1HVABjwsHk+Xy0fMw3QNKCOF9qulagrVpJEtcQe4qcSQesJOU9PqJaCMZblglUeD2A1Ad96y80eYMco4703/SSdoNPkpygepBsE0U1ywoT2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHuEdCGo; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-9372310418bso744281241.3
        for <linux-iio@vger.kernel.org>; Fri, 21 Nov 2025 16:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763771186; x=1764375986; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eA3LGvlVMXR3Plz0WCz3iOl+L+AbTQoSVlGUy1TH+so=;
        b=RHuEdCGo+9SaIBHrL8kQ+X3RrA/mG2pS248o4qsnJLpZzXJTRtCZqs0FJ1ZrouWd1m
         T0jryzU0vHqUeV/hfDLEX4mSo+0pSvr8NdLoWe5RdZHuhcdQTFAM1UFjIImtK6HFjzC5
         cMZDgtTv0NUnWfbXrddp/X4zOQn1DBScI1arx+xRoRLL0g6HbHwGKjngjosyxS8g7vZ7
         fyiC/6CKSZFatLLC4o1Fa07JqDmhVips/TE084t3z9OpdLClO6kKBKfzl56ESu5VvTds
         3WTo1qYfp/HBdoQquO1Zoc9Ie0DbLm9VaDIwuoYJWbVa+93r67vl2adARH50p5IQFG+g
         cPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763771186; x=1764375986;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eA3LGvlVMXR3Plz0WCz3iOl+L+AbTQoSVlGUy1TH+so=;
        b=YY/jd+95B3zlTRWjiI6uvETc4qiNoFb+oWftzzR6yXiyugrb/I5YDMEELDPcgh1hBM
         1SP3bYEk09cn1kwmoerXfjZ6yXbPegTqulPrb7mjYAifuGrVTumbOHCypfmV4CTf0SKK
         C6aAjpvSHK4kS1Gh9Wf8CU6CKlQSajtAxq4qroBUs2DJGiPaaLzZrhkJ9Bow0OxBQTbo
         bBmRgsxHozs495Z3ipQOwELXMyAKOqkS7Yy7bAVUBX10kk18GrxPUw6iKWhE1Vms0mGf
         WV+OcMphq6KVHftN7/5L4LLr5QGW77XiomEr64ahJT11UwnJLhkxWvXzUU1S8cKxBTKu
         SCLg==
X-Forwarded-Encrypted: i=1; AJvYcCVQoXPwK9NGlV3Ght5tuTyOr4xl1WFOkv6nO5ZA5J1hcBEude307DGGLPyxjETsiurmSsVmHnyvNFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZlbwUn/1a9U5PvUUsprqudaibbp4+piYrspf+2K0QZxtu8ckG
	Tfw6GZ1zY6T3QSes/ZXHG+bse2taeHKd8WRhju0nYqmyyihPDpNtmhoiyFLYmQ==
X-Gm-Gg: ASbGnctNzECzvC21OiaapEyM2JYADLDedJLh9tjB9TkoTR/VKP+PNxhTBLKwImyuJ+T
	My+ncCuZI/U9MFJyxDckE/oVXDAkEwbxwcJ4dZvPi9woU6u6czlYKlb1rtcSrFD+AIpMCTOhO0e
	+S1xsCxORaW8OeEeURBGUCmCnb+kOkcpXPGs1cHSjjxUWtUQdnsc0o75lsL1oJQ5WYlgl17Sisw
	3B1FWBLKXrotNtBTZ0sfye+LVkrriPPVYOxk2hmPfKrIODuDFHerdlOVv9ONTw0BBAegqSq5Dvr
	VhYB5SNQQX2G2GKPlcA0U44J8Z9Q7FVMikzIIW+CIIYBWKCUI92Ochu6O+G80JBRlaFEZbOajmx
	nqg9j8wk9YN1LOVTU89pgELFDmtSw9YdyyhbN3owB77ctafmV8di3sNo8gr5HcAJKGv4WJtNdYe
	3gC3Y=
X-Google-Smtp-Source: AGHT+IFgolZkPHp9RA6XxN56LqJL3IsIaP/ha4/Nx/gmiXo0RsyimYW7lgq5cTmJGYQkc9HbKH4+yA==
X-Received: by 2002:a05:6102:334c:b0:5dd:b69a:cdce with SMTP id ada2fe7eead31-5e1de0eccc9mr1209279137.1.1763771186484;
        Fri, 21 Nov 2025 16:26:26 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93c5658147fsm3082065241.15.2025.11.21.16.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 16:26:26 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Nov 2025 19:26:24 -0500
Message-Id: <DEESPC8XZSXI.3G1JISSNEBC3Q@gmail.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add TI ADS1018/ADS1118
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Tobias Sperling"
 <tobias.sperling@softing.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251121-ads1x18-v1-0-86db080fc9a4@gmail.com>
 <20251121-ads1x18-v1-1-86db080fc9a4@gmail.com>
 <09d8aa0c-8713-4673-8d70-ff5d59392c12@baylibre.com>
In-Reply-To: <09d8aa0c-8713-4673-8d70-ff5d59392c12@baylibre.com>

On Fri Nov 21, 2025 at 5:32 PM -05, David Lechner wrote:
> On 11/21/25 11:16 AM, Kurt Borja wrote:
>> Add documentation for Texas Instruments ADS1018 and ADS1118
>> analog-to-digital converters.
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
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
>
> I like to make the file name match the lowest number. That way it matches
> the first item in the compatible list.
>
>> @@ -0,0 +1,132 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>
> Better to be specific with GPL-2.0-only or GPL-2.0-or-later (your choice)=
.

I will go for GPL-2.0-only on both files.

>
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
>
> We know the max SCLK rate from the datasheet, so we can add:
>
> spi-max-frequency:
>   maximum: 4000000
>
> And we need to explicitly mention this one (it isn't part of
> spi-peripheral-props.yaml but rather comes from spi-controller.yaml):
>
> spi-cpha: true
>
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
>
> All chips need power, so we should have:
>
> vdd-supply: true
>
> and make it required.
>
>> +required:
>> +  - compatible
>> +  - reg
>> +  - drdy-gpios
>
> The chip can be used without needing the DRDY signal, so drdy-gpios and
> interrupts should not be required.
>
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
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        minimum: 0
>> +        maximum: 5
>> +        description:
>> +          Programmable gain amplifier configuration, as described in th=
e PGA
>> +          Config Register Field description. If not present, the defaul=
t is
>> +          used.
>
> The gain is programmable, so normally, we would set that by writing
> to the in_voltageY_scale attribute rather than hard-coding it in the
> devicetree.
>
>> +
>> +      ti,datarate:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        minimum: 0
>> +        maximum: 7
>> +        description:
>> +          Data rate configuration, as described in the DR Config Regist=
er Field
>> +          description. If not present, the default is used.
>
> Likewise, the data rate should be set at runtime using a
> sampling_frequency attribute rather than being hard-coded
> in the devicetree.

I actually took this approach from ti-ads1015. I was debating this
myself.

I'll gladly drop these.

>
>> +
>> +    required:
>> +      - reg
>> +
>> +    additionalProperties: false
>> +
> So we shouldn't need explicit channel properties at this time.

Ack for the rest of comments.


--=20
 ~ Kurt


