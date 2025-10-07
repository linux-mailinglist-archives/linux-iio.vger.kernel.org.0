Return-Path: <linux-iio+bounces-24830-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08275BC1FAE
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 17:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7D613E0065
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 15:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598031C5F1B;
	Tue,  7 Oct 2025 15:48:56 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B00E27713;
	Tue,  7 Oct 2025 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759852136; cv=none; b=sRdlNqEjjnEz+4EJkNrxULwzhjSM1qwtjjV4MtyN+ROd6ld6OFaGQna0BuReazJhHvLOy1tjqACsKKttzT8CQ+rtNih1ly7y60CgdwY9C+zN+6Ey5yVlOcJvbmIFCI9muoYsfbm9SIqigFrioQ6dmQqBq5fM0xi0AoPa0O9MyZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759852136; c=relaxed/simple;
	bh=14zGdsZU2iAqyiMq4YrRUm3M/uNB5Pt47SJQCBr51tI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kaxJY3Eb3y5SXfNRuYvxXIY7aPSYS0XwGIpcr7I/UX6AVOzpzq21vqywrIgPzZ4W37zDkUC0AAF1owKH4ILLoVbaRMO1ZNgdwiNLO7fjyQj9bYFNlZ46fQuS2BEvpOxBuuheSMom45rA71OtVBYdL+wYzerpi2EJeTgzgq/sMdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ch0qJ1ttyz6L4sX;
	Tue,  7 Oct 2025 23:46:20 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 8D8E11402F7;
	Tue,  7 Oct 2025 23:48:50 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 7 Oct
 2025 16:48:49 +0100
Date: Tue, 7 Oct 2025 16:48:48 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Eddie James <eajames@linux.ibm.com>
CC: <linux-hwmon@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-aspeed@lists.ozlabs.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <andrew@codeconstruct.com.au>, <joel@jms.id.au>,
	<linux@roeck-us.net>, <chanh@os.amperecomputing.com>, <jic23@kernel.org>,
	<dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>
Subject: Re: [PATCH v7 RESEND 3/7] dt-bindings: iio: Add Infineon DPS310
 sensor documentation
Message-ID: <20251007164848.00004d96@huawei.com>
In-Reply-To: <8ab87732-71e1-4101-9aed-14f68c27fea1@linux.ibm.com>
References: <20251001144441.310950-1-eajames@linux.ibm.com>
	<20251001144441.310950-4-eajames@linux.ibm.com>
	<20251003150102.00007dae@huawei.com>
	<8ab87732-71e1-4101-9aed-14f68c27fea1@linux.ibm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 6 Oct 2025 08:44:55 -0500
Eddie James <eajames@linux.ibm.com> wrote:

> On 10/3/25 9:01 AM, Jonathan Cameron wrote:
> > On Wed,  1 Oct 2025 09:44:37 -0500
> > Eddie James <eajames@linux.ibm.com> wrote:
> > =20
> >> The DPS310 is a barometric pressure and temperature sensor with
> >> an I2C interface. Remove it from trivial-devices.yaml and add its
> >> own documentation. =20
> > Hi Eddie,
> >
> > Why?  I guess you need the #io-channel-cells which trivial devices
> > doesn't allow because you have a consumer driver? =20
>=20
>=20
> Correct.
>=20
>=20
> >
> > Obviously the binding patch shouldn't mention that, but it could call
> > out that there can be such consumers. =20
>=20
>=20
> OK, I can add that.
>=20
>=20
> >
> > I'd also expect to see some supplies even if the driver doesn't yet
> > explicitly handle them. =20
>=20
>=20
> You mean in the example section? Sure. I'll send a patch separately=20
> since the rest is merged

Supplies need listing as actual properties (+ in the example)
=46rom a binding point of view they are 'required' if the power needs
to be turned on for the chip to work.  On actual DT files they might
not be there if a fixed supply is in use and someone didn't other providing
it. In those cases the regulator code provides a fake regulator to make
everything work.

>=20
>=20
> Thanks,
>=20
> Eddie
>=20
>=20
> >
> > Jonathan
> > =20
> >> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> >> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> >> ---
> >>   .../iio/pressure/infineon,dps310.yaml         | 44 +++++++++++++++++=
++
> >>   .../devicetree/bindings/trivial-devices.yaml  |  2 -
> >>   MAINTAINERS                                   |  1 +
> >>   3 files changed, 45 insertions(+), 2 deletions(-)
> >>   create mode 100644 Documentation/devicetree/bindings/iio/pressure/in=
fineon,dps310.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/pressure/infineon,d=
ps310.yaml b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310=
.yaml
> >> new file mode 100644
> >> index 0000000000000..7c0782e2a821b
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.y=
aml
> >> @@ -0,0 +1,44 @@
> >> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/iio/pressure/infineon,dps310.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Infineon DPS310 barometric pressure and temperature sensor
> >> +
> >> +maintainers:
> >> +  - Eddie James <eajames@linux.ibm.com>
> >> +
> >> +description:
> >> +  The DPS310 is a barometric pressure and temperature sensor with an =
I2C
> >> +  interface.
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - infineon,dps310
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +
> >> +  "#io-channel-cells":
> >> +    const: 0
> >> +
> >> +required:
> >> +  - compatible
> >> +  - reg
> >> +
> >> +additionalProperties: false
> >> +
> >> +examples:
> >> +  - |
> >> +    i2c {
> >> +        #address-cells =3D <1>;
> >> +        #size-cells =3D <0>;
> >> +
> >> +        pressure-sensor@76 {
> >> +          compatible =3D "infineon,dps310";
> >> +          reg =3D <0x76>;
> >> +          #io-channel-cells =3D <0>;
> >> +        };
> >> +    };
> >> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/=
Documentation/devicetree/bindings/trivial-devices.yaml
> >> index 7609acaa752d5..a72b7fabc7034 100644
> >> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> >> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> >> @@ -127,8 +127,6 @@ properties:
> >>             - ibm,cffps2
> >>               # IBM On-Chip Controller hwmon device
> >>             - ibm,p8-occ-hwmon
> >> -            # Infineon barometric pressure and temperature sensor
> >> -          - infineon,dps310
> >>               # Infineon IR36021 digital POL buck controller
> >>             - infineon,ir36021
> >>               # Infineon IRPS5401 Voltage Regulator (PMIC)
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 0c8281ea4cc64..92b9854a0e07d 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -12191,6 +12191,7 @@ INFINEON DPS310 Driver
> >>   M:	Eddie James <eajames@linux.ibm.com>
> >>   L:	linux-iio@vger.kernel.org
> >>   S:	Maintained
> >> +F:	Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
> >>   F:	drivers/iio/pressure/dps310.c
> >>  =20
> >>   INFINEON PEB2466 ASoC CODEC =20
> > =20


