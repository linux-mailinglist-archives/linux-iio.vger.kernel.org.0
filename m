Return-Path: <linux-iio+bounces-12464-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B369D4CD5
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 13:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E0E2837AA
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 12:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B0D1D3566;
	Thu, 21 Nov 2024 12:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwtaAaPv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AC316F288;
	Thu, 21 Nov 2024 12:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732192392; cv=none; b=CbKNaIU1R5zoJSUv/aaeqq1C89GjY/emnEVLlFurxmoNZAPRgcz91ZYl2elrY5iNV2LYTK5+zPjjc0pWh5kuHnykKyW6pCVkl1yECDWwmEl8CyjToMVxxvukZovd7YwQlNzRYn4BmnymE/8BrQHoWPABdW6rOoZc2TQ3h4nctH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732192392; c=relaxed/simple;
	bh=88ITFPUUsfIwaCKYuNyjaXtYOTMKYnqEbbMPpd/oAnc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=aauroCo7Uz4B8CU94aOU79LKK0RLy5kkCGOAGQYdKP4/bVzCw3reUKxgdKoeOPjc91coR8z7Pg0A2dSL4hInZfl36DGfajOdd3HQ8brj/lmwX1uw0PtM8qxWsuC3t1kTbQ5HpEiJ/LuUDjonx2yjc6HQvMNOW/XkCMLFSHTVdRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwtaAaPv; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a99f3a5a44cso128877966b.3;
        Thu, 21 Nov 2024 04:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732192389; x=1732797189; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkLAD9Z/v55rtUvSWajMsLewz3MHOscGl7h7lwnVd/o=;
        b=UwtaAaPvcw3ygmk5HicfpJgC8usk/68pRdiO8dcOyEqgOVL3XxyW+h0Xgh04j05b8l
         NLufKlH56q9r88G2nNmIjtWwxin8z7p0RpP0aHqfSphcJ0eEakTsUrTjapKPxm8TQ3oS
         nUckJ7fKOplo/T69aRZqHo8y1UiVy4cJfVebSdpJuQ4Ni5qagg46iO1Q9/vLGhXkH3Hl
         SBL3DZQDGH6r5hOmYRHEkV4ja/nQ/3y3hBdaFNWLbJXk6WD24Ranq6kn0f0MPFlXcycr
         JbkDMIP8TqpIiryYb0UEJNq0PUhzYdXNRcWMK/UJqss4nm6fwDRF+U/N+yachJmNesid
         eCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732192389; x=1732797189;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MkLAD9Z/v55rtUvSWajMsLewz3MHOscGl7h7lwnVd/o=;
        b=M2vYfZXZKathNoOC8BKrsJGs3qh0pg54Sp96BPWMTs0I/q8pB+XCRSaTVq7lUTB9Lv
         kwFamdRzzRHN4h1fQa4Em/+nNq+L9o2N9Jl3BEA3+D+v6DOKd+5mgM6ya5Q00LgnKEgq
         whq+RHgo+6+pMBmhTwgLSvrw3bI2aHfbrjKIZWc5d3zsFpyH7BP0OKk0sdPdBl4EawkI
         en9UJbtIR+moByiHuk3CRslvsnDpr/ddpuMlrHHMPplaDn82ZbXozZin+YKwzdq+zupi
         rPaDJi9ksB8QknsoX//HHsdkRBogbtvn8vnBlEaUDU+FIox+y8lGGLQH53XIWQvz7nvZ
         NMdQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0kLjBqWnAqpQBGMqNKCnOAsCQKNip8IFMILCK5p9+vky3CRXcRrtTqMbPwzJ/krTi4PRPKT2gDaSS@vger.kernel.org, AJvYcCXqrKNOpmyjnYyxUQ04i31sUCl4Mh07n+Qy2lZo39v17Olr5pfZOadlr5RU9920lJJoHyY4RRtVdKwSaWni@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ZZlB48CLX3T2iYuJltzA1mpZaUwLxGYbFcTQ2DqCZzq/9i6z
	EHMuwjLUmJ10NsJtrVWM5iXLkfhq9o5Go22AywLBiMcVPqWKMCPz9vLYng==
X-Gm-Gg: ASbGncshoBL1dA3mIaGrLTGHGs7gcdjrKc8Vo5XldgFIvwUltyJ591mrmxPyS57o2ME
	sltYH8gkPJI9ba/Wg+NnWsGOggVw3u7ujaG0CMBlpKFyaUEQ8KDv+TI958q4mn0VRoPqTFpGS7Y
	K59wp6IcFDAlBb0BoLswpyED1DDwrfqVo6BinRccHNZ62wYEZm9cOA8+6XOFc4Xe9lvzyoNKsCi
	R2eyunMECQnquM6Y+3yJ5JWnQAxNd1Sqe5lfyzx3WAQ3OZyeead/R6gxRwM28w2Ogo5N8EKXsbP
	/o7v31LmLKU9kkdrIXIVSLk=
X-Google-Smtp-Source: AGHT+IGi5XImn6CCV/jgD2xDfB7VL/11etT59d4E0UzrzVRpXsOXNGpEtINU8S6PvWoN+MFhSuYmVw==
X-Received: by 2002:a17:906:ef01:b0:a99:5d03:4687 with SMTP id a640c23a62f3a-aa4dd552458mr571297066b.21.1732192389085;
        Thu, 21 Nov 2024 04:33:09 -0800 (PST)
Received: from localhost (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f42d48b8sm75379666b.116.2024.11.21.04.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 04:33:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Nov 2024 13:33:07 +0100
Message-Id: <D5RUYD6QBEC6.3CKN66RGZQGQH@gmail.com>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <rickard.andersson@axis.com>,
 <kernel@axis.com>, "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: light: Document TI OPT4060
 RGBW sensor
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
To: "Per-Daniel Olsson" <perdaniel.olsson@axis.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "Lars-Peter Clausen" <lars@metafoo.de>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
X-Mailer: aerc 0.18.2
References: <20241120163247.2791600-1-perdaniel.olsson@axis.com>
 <20241120163247.2791600-2-perdaniel.olsson@axis.com>
In-Reply-To: <20241120163247.2791600-2-perdaniel.olsson@axis.com>

On Wed Nov 20, 2024 at 5:32 PM CET, Per-Daniel Olsson wrote:
> Add devicetree bindings for the OPT4060 RGBW color sensor.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Per-Daniel Olsson <perdaniel.olsson@axis.com>
> ---
>  .../bindings/iio/light/ti,opt4060.yaml        | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/ti,opt406=
0.yaml
>
> diff --git a/Documentation/devicetree/bindings/iio/light/ti,opt4060.yaml =
b/Documentation/devicetree/bindings/iio/light/ti,opt4060.yaml
> new file mode 100644
> index 000000000000..0577e27db1ef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/ti,opt4060.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/ti,opt4060.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments OPT4060 RGBW Color Sensor
> +
> +maintainers:
> +  - Per-Daniel Olsson <perdaniel.olsson@axis.com>
> +
> +description:
> +  Texas Instrument RGBW high resolution color sensor over I2C.
> +  https://www.ti.com/lit/gpn/opt4060
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,opt4060
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +

You could simply use vdd-supply: true, as it is obvious what it does.

> +  vdd-supply:
> +    description: Regulator that provides power to the sensor.
> +

is vdd-supply not required?

> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        light-sensor@44 {
> +            compatible =3D "ti,opt4060";
> +            reg =3D <0x44>;
> +            vdd-supply =3D <&vdd_reg>;
> +            interrupt-parent =3D <&gpio5>;
> +            interrupts =3D <13 IRQ_TYPE_EDGE_FALLING>;
> +        };
> +    };
> +...

Best regards,
Javier Carrasco

