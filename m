Return-Path: <linux-iio+bounces-25415-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 604C9C05879
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 12:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BFCC235BF2E
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 10:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DCC30EF77;
	Fri, 24 Oct 2025 10:12:21 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6AE30EF71;
	Fri, 24 Oct 2025 10:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761300741; cv=none; b=f09v+JpsskT7BdlMmyaNUvWEr+LMVFYbk1OIXmlf/MzeFzug89UGYK7wNLe5cf/+U1lAyGKb2f2HnyJpTX0tADdamEpi2JjjQHS53/FAUpvHF5svVa3Y6LFW+N2ro4J7pKT5Fafi4SYUWysaZooslLAPh8xkCM0xrFVhl15OGdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761300741; c=relaxed/simple;
	bh=465eVOWUp+N7PV0ZEpeRHSUci+OixbUnu7VD9WHOWkc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=icDon8lprJQS39aPnaFfwlQIsNWDstEdJr9RD8HkgX2ovr/mrkYmsruRNMyTnUYH8R9aCIZgJAu2X5wxwLxWMpQOe9JZP6QhwlkoGO1pv9o5lFMqOyT5VsfLdySoL/8HDN01s/NkVhnJsmBfEltnqG5Jd00+8qvtvp1hR3vkt0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ctJZ66v9Yz6L51R;
	Fri, 24 Oct 2025 18:10:38 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 67985140372;
	Fri, 24 Oct 2025 18:12:09 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 24 Oct
 2025 11:12:08 +0100
Date: Fri, 24 Oct 2025 11:12:07 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Conor Dooley <conor@kernel.org>
CC: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, "David
 Lechner" <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: dac: Document AD5446 and
 similar devices
Message-ID: <20251024111207.00007427@huawei.com>
In-Reply-To: <20251023-food-say-5e396be087af@spud>
References: <20251023-ad5446-bindings-v2-0-27fab9891e86@analog.com>
	<20251023-ad5446-bindings-v2-1-27fab9891e86@analog.com>
	<20251023-food-say-5e396be087af@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 23 Oct 2025 19:24:17 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Thu, Oct 23, 2025 at 02:01:37PM +0300, Nuno S=E1 wrote:
> > Add device tree binding documentation for the Analog Devices AD5446
> > family of Digital-to-Analog Converters and compatible devices from
> > Texas Instruments. There's both SPI and I2C interfaces and feature
> > resolutions ranging from 8-bit to 16-bit.
> >=20
> > The binding covers 29 compatible devices including the AD5446 series, =
=20
>=20
> If they're compatible, how come there's no fallback use? Just to keep
> things consistent with how they've always been while probing as spi
> child devices?
Hi Conor,

They aren't compatible. The 2nd patch is misleading because it doesn't
associate data with the of_device_id.  The driver is getting that from
matching the compatible property with manufacturer stripped off.

I've requested Nuno sort that out in v3. It's a bit more than just
adding the data as would also involve moving away from using an enum
to using pointers to the structures that the enum indexes (currently in
an array).

https://elixir.bootlin.com/linux/v6.17.4/source/drivers/iio/dac/ad5446.c#L3=
15

Thanks,

J
>=20
> Conor.
>=20
> > AD5600 series, AD5620/5640/5660 variants with different voltage ranges,
> > and TI DAC081s101/DAC101s101/DAC121s101 devices.
> >=20
> > Signed-off-by: Nuno S=E1 <nuno.sa@analog.com>
> > ---
> >  .../devicetree/bindings/iio/dac/adi,ad5446.yaml    | 138 +++++++++++++=
++++++++
> >  MAINTAINERS                                        |   8 ++
> >  2 files changed, 146 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml =
b/Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
> > new file mode 100644
> > index 000000000000..90fc8ca053fe
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
> > @@ -0,0 +1,138 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/dac/adi,ad5446.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices AD5446 and similar DACs
> > +
> > +maintainers:
> > +  - Michael Hennerich <michael.hennerich@analog.com>
> > +  - Nuno S=E1 <nuno.sa@analog.com>
> > +
> > +description: |
> > +  Digital to Analog Converter devices supporting both SPI and I2C inte=
rfaces.
> > +  These devices feature a range of resolutions from 8-bit to 16-bit.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - description: SPI DACs
> > +        enum:
> > +          - adi,ad5300
> > +          - adi,ad5310
> > +          - adi,ad5320
> > +          - adi,ad5444
> > +          - adi,ad5446
> > +          - adi,ad5450
> > +          - adi,ad5451
> > +          - adi,ad5452
> > +          - adi,ad5453
> > +          - adi,ad5512a
> > +          - adi,ad5541a
> > +          - adi,ad5542
> > +          - adi,ad5542a
> > +          - adi,ad5543
> > +          - adi,ad5553
> > +          - adi,ad5600
> > +          - adi,ad5601
> > +          - adi,ad5611
> > +          - adi,ad5621
> > +          - adi,ad5641
> > +          - adi,ad5620-2500
> > +          - adi,ad5620-1250
> > +          - adi,ad5640-2500
> > +          - adi,ad5640-1250
> > +          - adi,ad5660-2500
> > +          - adi,ad5660-1250
> > +          - adi,ad5662
> > +          - ti,dac081s101
> > +          - ti,dac101s101
> > +          - ti,dac121s101
> > +      - description: I2C DACs
> > +        enum:
> > +          - adi,ad5301
> > +          - adi,ad5311
> > +          - adi,ad5321
> > +          - adi,ad5602
> > +          - adi,ad5612
> > +          - adi,ad5622
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  vcc-supply:
> > +    description:
> > +      Reference voltage supply. If not supplied, devices with internal
> > +      voltage reference will use that.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - adi,ad5300
> > +              - adi,ad5310
> > +              - adi,ad5320
> > +              - adi,ad5444
> > +              - adi,ad5446
> > +              - adi,ad5450
> > +              - adi,ad5451
> > +              - adi,ad5452
> > +              - adi,ad5453
> > +              - adi,ad5512a
> > +              - adi,ad5541a
> > +              - adi,ad5542
> > +              - adi,ad5542a
> > +              - adi,ad5543
> > +              - adi,ad5553
> > +              - adi,ad5600
> > +              - adi,ad5601
> > +              - adi,ad5611
> > +              - adi,ad5621
> > +              - adi,ad5641
> > +              - adi,ad5620-2500
> > +              - adi,ad5620-1250
> > +              - adi,ad5640-2500
> > +              - adi,ad5640-1250
> > +              - adi,ad5660-2500
> > +              - adi,ad5660-1250
> > +              - adi,ad5662
> > +              - ti,dac081s101
> > +              - ti,dac101s101
> > +              - ti,dac121s101
> > +    then:
> > +      allOf:
> > +        - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    spi {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        dac@0 {
> > +            compatible =3D "adi,ad5446";
> > +            reg =3D <0>;
> > +            vcc-supply =3D <&dac_vref>;
> > +        };
> > +    };
> > +  - |
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        dac@42 {
> > +            compatible =3D "adi,ad5622";
> > +            reg =3D <0x42>;
> > +            vcc-supply =3D <&dac_vref>;
> > +        };
> > +    };
> > +...
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 940889b158eb..dae04c308975 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -440,6 +440,14 @@ W:	http://wiki.analog.com/AD5398
> >  W:	https://ez.analog.com/linux-software-drivers
> >  F:	drivers/regulator/ad5398.c
> > =20
> > +AD5456	DAC DRIVER
> > +M:	Michael Hennerich <michael.hennerich@analog.com>
> > +M:	Nuno S=E1 <nuno.sa@analog.com>
> > +L:	linux-iio@vger.kernel.org
> > +S:	Supported
> > +W:	https://ez.analog.com/linux-software-drivers
> > +F:	Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
> > +
> >  AD714X CAPACITANCE TOUCH SENSOR DRIVER (AD7142/3/7/8/7A)
> >  M:	Michael Hennerich <michael.hennerich@analog.com>
> >  S:	Supported
> >=20
> > --=20
> > 2.34.1
> >  =20
>=20


