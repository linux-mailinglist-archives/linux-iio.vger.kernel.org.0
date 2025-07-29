Return-Path: <linux-iio+bounces-22118-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D263FB1468F
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 05:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21F943BCA38
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 03:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2416821884A;
	Tue, 29 Jul 2025 03:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nm3sBIS2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCC31E521A;
	Tue, 29 Jul 2025 03:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753758219; cv=none; b=th38JqbXnf3fFYgnjG6yNc7fsfvDybQBEXAD6kYeoBaOZu5g1U+qa+LB1wyIaP1dNU2EaBxn49GtyG+eb+b8RBkDdjRQ1ugRVxB1foG7CLAzhjUBthxossGBDpHoDnkm388B5SmSSxH3aN65Rm6CRvfsfcKrlOfG999mwkiUW/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753758219; c=relaxed/simple;
	bh=LSV/pQdJC+fneSAPB5inQCEKAEeIukrh2KJW3iiP7qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hcc47ks4QY2hEimCIHcgZlVd5d6vvY0SVfwOP2nTLomcN/lxSwE6KperEoVmw26dBfpWPTOSqjKkSAf2+vYCQso+RunhFEr+Ix9PGPUYJV9t8Wl2sT2cJ7DwG2lu0EKQ1SdeDhNLAFAgb5HnU3hoo7LHDIaReF4Ja0/i4q4ppqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nm3sBIS2; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b3f80661991so391973a12.0;
        Mon, 28 Jul 2025 20:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753758218; x=1754363018; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IXO12M/CDdwgzfu3NadcSVolSn34grMG/o4SmHRmEBo=;
        b=Nm3sBIS2yb/M06Hffa6xIRd7B47o15Is9xz6LKkYQn/MrCcx0lxe651VS2AhAGl/b0
         8xhKM29+fhZp7a+mBvJ2myUdZaVLvKOkgqqZsR7Hof/oaFdEFSSri35ctsRHSAqYX/Eo
         MGSxG+kKEPNNjUmtUHZjPBR4LZQpvy/dGtBLLgI2tlaswLIVdm7ClWAkBpSTRpu0N/zC
         s7wlYpFcskBQ47vyvV+tCIyoF+jsD+h0BGm4JlZa/MzoMG8r3IgAIS3dqZViIx4UmeeD
         W7KKkZeivvaqXaxNMnZqbvBHFQ3pQF/BF338O+gTLLRLQcF4T48AYq2eF4gD0d0DSnig
         HtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753758218; x=1754363018;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IXO12M/CDdwgzfu3NadcSVolSn34grMG/o4SmHRmEBo=;
        b=ahhPZ9pIs4CNYeKHTug+cfdHei0TjmxlXD3WPMDBfCm9Xiz73laApjaZIHi95BEwAw
         SC1319IOu8y4EL5bCySkFPZNTCJ7hormQrCG5mXWulvNa7Bp5aS7hHDNH/AdD54hWBKH
         TNYls2mppKSeX8DVHSynDFDgLn/fuOGgPjLIN2mHausJvHKB2T4Ok96vkRO/fA5ygFpy
         FRZfawo+WnLCq0jO7J6uoTDcKJbSIOMQbWv9Rmf6v60s3QjHjEnIBrTBopauCa+OJQ74
         ZmiXXZQ8MSof1XgCPz7UGu0U230PuWokFry3Cflij/SdcMfSL1xgIFmZDH6mm6UX0s8O
         JeOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrlIV2xLZmtMSavsxZdKTdEoOOnmtHEwaPDg4xHV9sh94J0dCQNimhtHx/0mTcRxPWAh0p322AzEq6/c3a@vger.kernel.org, AJvYcCVPpEsAtIBU1SimBkgzn8FLlZbsvjG8HBEtIcvvagYP0zcyQrCSDTYUqq8AKgoLFsBiev2kxbP4Pslp@vger.kernel.org, AJvYcCXHANqvDJBx7rQiGnubH+2jz4EmwJL69QGj1wjB/Yc5letb4sQTI/PPtSewVJXlN8VosIxeC0n/OacU@vger.kernel.org
X-Gm-Message-State: AOJu0YxplkiXCrcFNGB3x2+j0YrzYcgoMHMAPQ9lCAxfpK3hdeJE2YWY
	yWrLN89U06k/vQVe3rK3CVpRWAyUTkK0qjzEU1BiWEiGKwocHeAVjiWOPc6yLfSg
X-Gm-Gg: ASbGncvXLciLcS+s7KBqldiaLs/Y/OyRS/MG8K+s9zivrSxaLa3/d2qOrku4zwrPuej
	Y7QrvX9w8z0mEZAl6430snR3C/rXjg15M56uARR5g+WbXfT5s8j+u3Q2QMuhRcRiAVkqfxZIPsl
	KMxcHLjNB+l8wSu9MjSevNVQZqR40+mEu4LdEhAa6T2lOZbcBgNBj8BYZGBAHP2Iq+Cws6+rRKw
	tzDJponh7cRdSGhRlg+RCnzklWSbCmo6YSrxl0VjGDYzi1zAkUqSh1e1bE8q7xK9YnrKr5hKNYK
	3l/RT09VapsY56POg4v+B4KEiPotCF6PSadtcLg4r/eVzHDdlsiCeTeM+nbUhHcUX0nXllhn3en
	hio2YehHJMOMtJuDXiEq5cw==
X-Google-Smtp-Source: AGHT+IEqOh9O6CEC2CimcyCWQJcx0A9whkEtqsd1I4BC5ZOa9k3+eaMNONrPVjoFtxLUrmQTLjsvdg==
X-Received: by 2002:a17:90b:2d8e:b0:31e:934b:d00b with SMTP id 98e67ed59e1d1-31f28c920dfmr2367584a91.7.1753758217535;
        Mon, 28 Jul 2025 20:03:37 -0700 (PDT)
Received: from dixit ([2401:4900:1c7e:9464:4ee2:7e58:1508:18c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f328a0ac5sm273689a91.7.2025.07.28.20.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 20:03:36 -0700 (PDT)
Date: Tue, 29 Jul 2025 08:33:27 +0530
From: Dixit Parmar <dixitparmar19@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: magnetometer: document Infineon
 TLV493D 3D Magnetic sensor
Message-ID: <aIg5_x4UMLjRk4dn@dixit>
References: <20250726-tlv493d-sensor-v6_16-rc5-v1-0-deac027e6f32@gmail.com>
 <20250726-tlv493d-sensor-v6_16-rc5-v1-2-deac027e6f32@gmail.com>
 <455141b2-e82f-45fd-b30f-5d9436aa861b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <455141b2-e82f-45fd-b30f-5d9436aa861b@baylibre.com>

On Sat, Jul 26, 2025 at 03:43:56PM -0500, David Lechner wrote:
> On 7/26/25 4:37 AM, Dixit Parmar wrote:
> > Document the bindings for Infineon TLV493D Low-Power 3D Magnetic Sensor
> > controlled by I2C interface. Main applications includes joysticks, control
> > elements (white goods, multifunction knops), or electric meters (anti
> > tampering).
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
> 
> The SDA pin can also be a /INT signal, so we need to have an
> optional interrupts property as well.
>
Okay. Will add it.
> > +
> > +  mode:
> > +    description: Sensor operating mode. Must be one of the defined enum values.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum:
> > +      - 0 # Power Down Mode. No measurement.
> > +      - 1 # Fast Mode
> > +      - 2 # Low-Power Mode
> > +      - 3 # Ultra Low-Power Mode
> > +      - 4 # Master Controlled Mode
> > +    default: 4
> 
> This is not the sort of thing that really belongs in a devicetree.
> We should be describing here how the chip is wired up, and only
> control how it works based on that.
> 
> If there are any wiring conditions that could affect this setting,
> they could go here. For example, if the power supply doesn't have
> enough current, then we can only operate in one of the low power
> modes. Otherwise generally we just stick to the best performing
> mode. And specifying the power down mode here really doesn't make
> sense - you could never use the sensor!
> 
Got it. Will remove it.
> > +
> > +  temp-offset:
> > +    description: Raw temperature offset at 25°C to apply before applying scale and correction.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 340
> 
> This is another one that likely doesn't belong in the devicetree.
> There is a standard *_calibbias attribute that can be used for
> such a calibration if needed.
> 
Its factory setting so I thought if there is any deviation from that
than we can handle it like this but as you pointed out, its not the
right way, so will stick to 340 default factory value as per the
datasheet.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> 
> Power supplies are usually required.
> 
Ack.
> > +
> > +additionalProperties: false
> > +
> > +example:
> > +  - |
> > +    i2c {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +      magnetometer@5e {
> > +        compatible = "infineon,tlv493d-a1b6";
> > +        reg = <0x5e>;
> > +        vdd = <&hall_vcc>;
> > +      };
> > +    };
> > 
> 
Thanks for the review,
Dixit

