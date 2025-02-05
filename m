Return-Path: <linux-iio+bounces-15045-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B90A295E9
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 17:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF76D18814C4
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 16:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AF5149C7B;
	Wed,  5 Feb 2025 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPmChAt7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E64A18A6D7;
	Wed,  5 Feb 2025 16:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738771915; cv=none; b=WXBNlIbENss1U0FZ4pq8X1IG7f3iSNU23mNeUU09Hy5XRS9z9h8/5I3SNvYV8HonQs8/tBhk01P9GxzSBjd/Xm+3fI2pWBnA3mzB2a8JAICHbYlwPV61D2YFsTp5qmFGMm/jbQBl3C5UmV9beab7gLkN1umT5YJdV+IjSXbj4WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738771915; c=relaxed/simple;
	bh=dQVOc4y27NeoOXda5Onh9gGqo7dvfYuDBZK0/YM66fg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jOoD730cybkemaaF2fYISF4ABXSxVjbQas17mMpdxCL6nulE+Pe2F5bx6Jd8DQWarbeMb+Tmda/jksBPtGSm+V90XCa4wa6wK8bG/TKQAKy9RtBr+saSDdMkQm/njFNyjy+YkobKo2cLaVnyZnG28Nc3fgCpmaM7KRb45TtBEH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPmChAt7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-438a39e659cso48157755e9.2;
        Wed, 05 Feb 2025 08:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738771911; x=1739376711; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PNqzKNqaayCVyP+RPKnmDOKjjukQ1Sp0Ecx73fchd38=;
        b=RPmChAt7PyAGMuSrXFVMStpsDzQvThBzozWN8k4lrPSZKHwdmjs4cDMxGueu38d6lI
         r3oKmKlpcEvD2GJ1yKnKD1fZHQMR6abs9jqlROyNselTa0it8ex4ZdyV7sGYYdc+70Ua
         qXxH5qxGA6y8BZqBgTrfajQfWQyYXREuy+RgGj7vUJ+Toe4+hp+hzRikBURLqpObA01M
         AJ8oFNSNv+3v/SXvaXRTVhbNAXje571DBL3YJ3RGzHag2ZaEjaMDf6Z7ONwZ7dRyXYRD
         pQhKrvsTa86Se95lntYmjpW+UPtioY9DK3pSaJrpGhkrRFu7ROrwzQVBOqFY3//1ZDyr
         ekYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738771911; x=1739376711;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PNqzKNqaayCVyP+RPKnmDOKjjukQ1Sp0Ecx73fchd38=;
        b=pmoY7yagavZNW1AomGzcZur1ARVPhR2wy381nKr+mF2lU7F4ryxW/H8Vu/T2spL/vm
         BNbOX0T32vTG7FkOD2C+5D1pmRMhrhcZnCVORR1dTe+mW3jvE90gH4HD7upZb8LCqHNy
         DHqLoXbVmWiFh36TUv5l3ocZIJb6La6GKWNC0ZTEJe0Lklvlld/Nbi8s37cuugifsh1C
         fLVbhL8GpMi2Ycdu97h37algpH0Ru9dxt37bKETdvbogED6JC6HVPbVPaeCCcYa1YkHw
         tU34LLax6t988cccofvIU8U2MGPq7qFiSWJdj+sGN8/UR6D0UhmjoWtMLSINWeBEBsPs
         LzXA==
X-Forwarded-Encrypted: i=1; AJvYcCUd9g2vvxAVDkYR8QHw/0y1/9WdtHZlJOGXSTCBG599lZqxXz5rVKufKFIqeXDxBv9+DNVyvmjlQk/A@vger.kernel.org, AJvYcCVmPOqB1UWuCtQ0VrMWyvoIt6jCkR137hGNdPgRhOeTFEuz/CFi75oVejk13lpcZ+2Ezm9EO2I5dPRw@vger.kernel.org, AJvYcCVqsfp48c0LZNDmi7XmuYUJGPy7HXwMQepu65rMQ1KQ3vIQpwuUlmgcjHiJVrb54UVl2wehOKIsCdUL64dp@vger.kernel.org, AJvYcCXxUVDdWhCZ/O2qblUxE9FL0+0Gch5/9BS8rkj6uDorndg7AfAxSqW9L//jIOBeF0zzseCuTQ+GbDI6@vger.kernel.org
X-Gm-Message-State: AOJu0YxtA/IRZSbDprJENkkAZh0NjvvawJM5RhsFtW147+4CvyUqIGiJ
	5rN9gokGx1igwcU9h2BBeDgx2oP9K/ORRkmNXjPks7QDzrM/0PO7/JFYDJlVONU=
X-Gm-Gg: ASbGncsZNhaT/Uc+vFR6La+1SftGamdTvw8BKFvgOwvlE02QJy6K5PD4xPHIHP1KWDj
	j7dSggJTyGMnZCR0Hm522nwS1jaSLBibNUFgZPmgRFqa4swIX6Fiu7FzOeXdO3JBoPdNSywWbvR
	Kd+7HB7OhpPy3MitBj1IIYp2plubURVqkJIE1zjnQI3dOWhsdbkocq7Mqpyp6rkHrtXKP+/ZVV0
	SeyyypNO2kUiifz7qqZRJa2XzMEhKebHVqG6aAWgj/cWC/jMRE9ujOx+0+f7qDh2Jkv57QwDAgJ
	G1nxM9OM11J5lk4W4c1qYriG7PMbUbjzlzbiSy2THOYkef7iucFB8wGkgZOTXag=
X-Google-Smtp-Source: AGHT+IH1q00BaWWc+Vq4wOn2GL8LTHw3yMqoCXLMuqGZ6alYQ079jnzjHR3x9XX0HmanLW4nyUAE5w==
X-Received: by 2002:a05:600c:19d4:b0:434:a1d3:a326 with SMTP id 5b1f17b1804b1-4390d4303d6mr25668005e9.6.1738771910427;
        Wed, 05 Feb 2025 08:11:50 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390daa0cbcsm25643305e9.40.2025.02.05.08.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 08:11:49 -0800 (PST)
Message-ID: <15065d0cd19f39d92ce860cd03802c368df74b34.camel@gmail.com>
Subject: Re: [PATCH v6 4/6] dt-bindings: iio: Add adis16550 bindings
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Conor Dooley <conor@kernel.org>, Robert Budai <robert.budai@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski	
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Corbet	 <corbet@lwn.net>, Nuno Sa <nuno.sa@analog.com>, Ramona
 Gradinariu	 <ramona.gradinariu@analog.com>, Trevor Gamblin
 <tgamblin@baylibre.com>,  Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Paul Cercueil <paul@crapouillou.net>, David Lechner	
 <dlechner@baylibre.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Date: Wed, 05 Feb 2025 16:11:51 +0000
In-Reply-To: <20250204-helium-marbled-a0863a0a18a8@spud>
References: <20250204143612.85939-1-robert.budai@analog.com>
	 <20250204143612.85939-5-robert.budai@analog.com>
	 <20250204-helium-marbled-a0863a0a18a8@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-04 at 19:25 +0000, Conor Dooley wrote:
> On Tue, Feb 04, 2025 at 04:36:08PM +0200, Robert Budai wrote:
> > Document the ADIS16550 device devicetree bindings.
> >=20
> > Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> > Signed-off-by: Robert Budai <robert.budai@analog.com>
> > ---
> >=20
> > v6:
> > - applied blank line suggestions
> > - added clock-frequency dependency change suggestions
> > - yamllint corrections
> >=20
> > =C2=A0.../bindings/iio/imu/adi,adis16550.yaml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 83 +++++++++++++++++++
> > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 9 ++
> > =C2=A02 files changed, 92 insertions(+)
> > =C2=A0create mode 100644
> > Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16550.ya=
ml
> > b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> > new file mode 100644
> > index 000000000000..8750bb937979
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> > @@ -0,0 +1,83 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/imu/adi,adis16550.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices ADIS16550 and similar IMUs
> > +
> > +maintainers:
> > +=C2=A0 - Nuno Sa <nuno.sa@analog.com>
> > +=C2=A0 - Ramona Gradinariu <ramona.gradinariu@analog.com>
> > +=C2=A0 - Antoniu Miclaus <antoniu.miclaus@analog.com>
> > +
> > +properties:
> > +=C2=A0 compatible:
> > +=C2=A0=C2=A0=C2=A0 enum:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,adis16550
> > +
> > +=C2=A0 reg:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +=C2=A0 spi-cpha: true
> > +=C2=A0 spi-cpol: true
> > +
> > +=C2=A0 spi-max-frequency:
> > +=C2=A0=C2=A0=C2=A0 maximum: 15000000
> > +
> > +=C2=A0 vdd-supply: true
> > +
> > +=C2=A0 interrupts:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +=C2=A0 reset-gpios:
> > +=C2=A0=C2=A0=C2=A0 description:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Must be the device tree identifier of t=
he RESET pin. If specified,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 it will be asserted during driver probe=
. As the line is active low,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 it should be marked GPIO_ACTIVE_LOW.
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +=C2=A0 clocks:
> > +=C2=A0=C2=A0=C2=A0 description: If not provided, then the internal clo=
ck is used.
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +=C2=A0 clock-frequency:
> > +=C2=A0=C2=A0=C2=A0 description: Clock frequency in Hz when an external=
 clock is used.
> > +=C2=A0=C2=A0=C2=A0 oneOf:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - minimum: 1
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maximum: 128
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - minimum: 3000
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maximum: 4500
>=20
> I don't get why this is a property, to be honest. When you've got an
> external clock, why isn't the frequency obtained from the clock provider
> node?
>=20

The main purpose of this property is actually to show/document the constrai=
ns of
the external clock. We can very well just error out in the driver (and we d=
o
that) and not have this property. I mentioned this property to Robert some
revisions ago and I also pointed out that I wasn't really sure if it should=
 be
used or not=C2=A0(I guess this is more for fixed clock providers...). IIRC,=
 I did
asked for some advice/comments but we got none so I assume Robert just deci=
ded
to use it and see what you guys had to say about it.

- Nuno S=C3=A1

> > +
> > +required:
> > +=C2=A0 - compatible
> > +=C2=A0 - reg
> > +=C2=A0 - interrupts
> > +=C2=A0 - spi-cpha
> > +=C2=A0 - spi-cpol
> > +=C2=A0 - spi-max-frequency
> > +=C2=A0 - vdd-supply
> > +
> > +dependentRequired:
> > +=C2=A0 clock: [clock-frequency]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> typo, missing s.
>=20
> > +
> > +allOf:
> > +=C2=A0 - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +additionalProperties: false
> > +examples:
> > +=C2=A0 - |
> > +=C2=A0=C2=A0=C2=A0 #include <dt-bindings/interrupt-controller/irq.h>
> > +=C2=A0=C2=A0=C2=A0 spi {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <1>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <0>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imu@0 {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 com=
patible =3D "adi,adis16550";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg=
 =3D <0>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spi=
-max-frequency =3D <15000000>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spi=
-cpol;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spi=
-cpha;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vdd=
-supply =3D <&vdd>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int=
errupts =3D <4 IRQ_TYPE_EDGE_FALLING>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int=
errupt-parent =3D <&gpio>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > +=C2=A0=C2=A0=C2=A0 };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6247500cf427..8913e13dcaef 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1452,6 +1452,15 @@
> > W:	https://ez.analog.com/linux-software-drivers
> > =C2=A0F:	Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
> > =C2=A0F:	drivers/iio/imu/adis16475.c
> > =C2=A0
> > +ANALOG DEVICES INC ADIS16550 DRIVER
> > +M:	Nuno Sa <nuno.sa@analog.com>
> > +M:	Ramona Gradinariu <ramona.gradinariu@analog.com>
> > +M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
> > +L:	linux-iio@vger.kernel.org
> > +S:	Supported
> > +W:	https://ez.analog.com/linux-software-drivers
> > +F:	Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> > +
> > =C2=A0ANALOG DEVICES INC ADM1177 DRIVER
> > =C2=A0M:	Michael Hennerich <Michael.Hennerich@analog.com>
> > =C2=A0L:	linux-hwmon@vger.kernel.org
> > --=20
> > 2.39.5
> >=20


