Return-Path: <linux-iio+bounces-22119-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC64B14695
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 05:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C41C0169C68
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 03:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E1A218AB4;
	Tue, 29 Jul 2025 03:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jc0vPuO8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E8D5FDA7;
	Tue, 29 Jul 2025 03:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753758362; cv=none; b=hajuG18OvCr7gFqxjEGydud+SAiFQAgYySLDvDy9iD7cdD8OBBT9ZvBroK9o+FChFxeP65+msy2bLx1OBPbxWut19QMIyiZsuRfeRCRrxezMhXXzrxXBUf2M1qJohDnCgTwfO2oAJ/pQLlZu6a2dekoQ2r26q4E1De+gQ+uZnFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753758362; c=relaxed/simple;
	bh=S6AJWyqZXrHlcQ9fpC1c5eF/E6HmSXH5c0vFDcK3/sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLY26LtVhuu9GJS1C7qF0585t2vtJwPra2axqaSVxJxyHUeDK+LgBBE1vBccjWxpAVZOPwDzyCmutStV4ydjqwb5D5aH+c4i3zk/deFO7fWIP9qKMXlo3i1Fl7jtaBgRZ3crDl9Z5QvRYMPSSF26oeEAQSMkxbBlseEqff2+4qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jc0vPuO8; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24022261323so5584905ad.1;
        Mon, 28 Jul 2025 20:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753758360; x=1754363160; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XBWVY361NxLRBMd0q21v+u+vCUkiXioFgT08lF5XMIA=;
        b=Jc0vPuO8pZ9B2JnIJ6o/ZKJLDm53GcXx7pO/MnXoVyR9h3X46Ou80cI8UcE7Z1kb4H
         v54VB44nC0MXx6yK98BzGRmtdegjwIKpVYehGwU7e8/wW5lNO4mDSzIOqxkeG/+01zlX
         TCYfAF7kNaEy7f89ZUeLvB/bTkpqAjxsQOFntz0QI7rI565yPzrTCJ0HLZtETJPRh6dX
         1JwVwfV4auNkbZnDmUKg4Me5yR7HMdqz6rroimaEzKb4EW5baaMUt59NLBMmDD0AYLi1
         rOdrXpfumpQqb31Z6/CHWrUKCVy+oM36sqZen+jKYO8VbXlpmFNNvFWbZJFdjJd0g9JZ
         sSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753758360; x=1754363160;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XBWVY361NxLRBMd0q21v+u+vCUkiXioFgT08lF5XMIA=;
        b=p5P13jMC4Cpkrw3DbIQ48BzfgAgHMap8BYgl71gF4tutBclhYsZ2GwMHdjt6YSgqpV
         IFLnWpRobPyUULBofGh3+JXQ2E7uWRIqtJ8bcxxoWoCOMmLvLF6kEsygkbImHX4AVu7r
         TilMZhDyTqkC/9IFEaezPUMwlseziwcJf086o8tcJNm2L1n5mrFGAKP5EqRk4i6oi3DN
         ICzzoNt59GuNYFgaSdAFB2hO7RpVKSM/IjYs5bqIUalaDpGTPEEDTvqpUgOtQufGdcZH
         F8pFjNaosclabmU2rmecdJMlkGoNGNdPeNYc+ZFmEPWS2XG+UeEPityDoTSADbMpE///
         Gy/w==
X-Forwarded-Encrypted: i=1; AJvYcCUDjY0UAMpFcCfEJZl8/Wwsz10uiPc07LIWM7pD4x7XbUkeElwixMfCuZKMx5w3lYlyn79Dxvk/iNeI@vger.kernel.org, AJvYcCUxKqOyuJWx2DrzghAdXF35iX+LspFugEcZNBpm6twE81Hb8dd44V8zJSbAe0VJScEBn5C8SpDukVafNCmw@vger.kernel.org, AJvYcCWugu7q2ez3YPdszjqtln8Q+Xwr3g6aDRw9UVxLglfMeVz9iTGy3xeIY+i4ZnXLqtP+JNVxxFtj0vFB@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0BU+O0QM9Kbt8pCGLpNXfFu+ljF66LGqKZ56bag4DW0OUT6mL
	1A8pJO4QPtb3pme6DL5+vhWEdDow9ayUiJe9kQUTE1DrJ5/CJOCLkKyR
X-Gm-Gg: ASbGncv0bwakWGFSYuehxOYtrU0BQYmFj3gWVHAME/BwIbLV0XdIaCayYr8oXNbqLjg
	bUeNUaA9VbdB8viVn59LzEh2CJaHv5MOhEepRiEpcM+S4YduEEv9ZJc+WncYfPbW75fI+YQoRZZ
	cXlfIKU7rMt6OKJQ6K4POc+KMV2CJhyARmuE1RrASulv94hq1wTK/aAGnKKyfSH/W4wrAc8xxlv
	3eF3LUH8C0cjTpW/X8Wk6jylTzMlrHqO9q08JCjkitj3Gww0GR51VhyKOnCFbiu4UlY4pLQ80on
	7h50oc8YCfDkFYYfcYkaC5PDyxP0npcFXOQ/TRTCkQ4bKnvkUKRPUuheJcv1XwugqSHDA3ttOQl
	PbAfvk1tLnxxXqqls811YphuLIslIC82s
X-Google-Smtp-Source: AGHT+IF+7ifC/K0CBtC2UqGCUR7HzYNsiRhrR+1SW9wClRoC9QVqboz3Aoq48IFhJTM5mAVIKEaqJg==
X-Received: by 2002:a17:902:f68a:b0:240:9d6:4554 with SMTP id d9443c01a7336-24063d8c05amr26581695ad.21.1753758359717;
        Mon, 28 Jul 2025 20:05:59 -0700 (PDT)
Received: from dixit ([2401:4900:1c7e:9464:4ee2:7e58:1508:18c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23ffa37f078sm46436565ad.115.2025.07.28.20.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 20:05:59 -0700 (PDT)
Date: Tue, 29 Jul 2025 08:35:49 +0530
From: Dixit Parmar <dixitparmar19@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: magnetometer: document Infineon
 TLV493D 3D Magnetic sensor
Message-ID: <aIg6jRj6haYISlgj@dixit>
References: <20250726-tlv493d-sensor-v6_16-rc5-v1-0-deac027e6f32@gmail.com>
 <20250726-tlv493d-sensor-v6_16-rc5-v1-2-deac027e6f32@gmail.com>
 <acdc8d41-94b3-47a5-b67e-58def060a378@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acdc8d41-94b3-47a5-b67e-58def060a378@kernel.org>

On Sun, Jul 27, 2025 at 11:23:04AM +0200, Krzysztof Kozlowski wrote:
> On 26/07/2025 11:37, Dixit Parmar wrote:
> > Document the bindings for Infineon TLV493D Low-Power 3D Magnetic Sensor
> > controlled by I2C interface. Main applications includes joysticks, control
> > elements (white goods, multifunction knops), or electric meters (anti
> > tampering).
> 
> You are duplicating existing binding, need to remove it as well.
>
Yeah, looks like some previous stalled entry is there. I will remove it.
> > 
> > The device can be configured in to different operating modes by optional
> > device-tree "mode" property. Also, the temperature sensing part requires
> > raw offset captured at 25°C and that can be specified by "temp-offset"
> > optional device-tree property.
> > 
> > Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/infineon-tlv493d-a1b6-datasheet-en.pdf
> > 
> > Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
> > ---
> >  .../iio/magnetometer/infineon,tlv493d.yaml         | 57 ++++++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d.yaml b/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d.yaml
> > new file mode 100644
> > index 000000000000..0442cf41503b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d.yaml
> > @@ -0,0 +1,57 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/magnetometer/infineon,tlv493d.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Infineon Technologies TLV493D Low-Power 3D Magnetic Sensor
> > +
> > +maintainers:
> > +  - Dixit Parmar <dixitparmar19@gmail.com>
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: '^magnetometer@[0-9a-f]+$'
> > +
> > +  compatible:
> > +    const: infineon,tlv493d-a1b6
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  vdd-supply:
> > +    description: 2.8V to 3.5V supply
> > +
> > +  mode:
> > +    description: Sensor operating mode. Must be one of the defined enum values.
> 
> Why is this board level property? I imagine you want to change it runtime.
> 
Acked.
> 
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum:
> > +      - 0 # Power Down Mode. No measurement.
> > +      - 1 # Fast Mode
> > +      - 2 # Low-Power Mode
> > +      - 3 # Ultra Low-Power Mode
> > +      - 4 # Master Controlled Mode
> > +    default: 4
> > +
> > +  temp-offset:
> > +    description: Raw temperature offset at 25°C to apply before applying scale and correction.
> 
> Does not look wrapped according to Linux coding style.
> 
As mentioned in previous thread, the property will get removed.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 340
> 
> Missing vendor prefix, missing unit suffix. I am also not sure what is
> the board design choice to offset it.
> 
> 
> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> 
> Missing supplies.
> 
Ack.
> 
> 
> Best regards,
> Krzysztof

Thanks for the review,
Dixit

