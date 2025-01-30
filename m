Return-Path: <linux-iio+bounces-14736-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED94A231B1
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 17:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59BBF3A7728
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 16:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99341EBFF9;
	Thu, 30 Jan 2025 16:22:00 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DC5139B;
	Thu, 30 Jan 2025 16:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738254120; cv=none; b=p80ymKwcI8TnkL37Yfz6chYVrbMqWYHZpeBK8um7vIyrdMEquQ6SochHa5H6n48t0Z7z1QrZDi6kxmGL3Yw+wuAg/MfkeXDY8Ic58UvhXL8pytnsN4WMCiAwagwwoPMKyH8+JbhHXCw5ySDx2fUOB+6qRTbMXHjxAtUGqnmwcUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738254120; c=relaxed/simple;
	bh=KC6+0vBEUgM0iPzYCxcTwkQWdeVBF7STXSN2kMjW09I=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NKvwZAJft6J0yvAdT7V1219EO18fUMLh+oIZagdRTH4gKyhb9M2zCD5oRr8+DdBGnIlbXsISyRZDyt2eRBXerraC0m3isE6vb5euSnYMRxyuEWe9BCY5vFCVFo0w6AEzqVeNGhs5urtqIyIcL6g3LKv4FzgXhefGXNnY4YEWzqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YkPQz6YLmz6K8Rw;
	Fri, 31 Jan 2025 00:21:15 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0F5AA140B55;
	Fri, 31 Jan 2025 00:21:55 +0800 (CST)
Received: from localhost (10.195.245.124) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 30 Jan
 2025 17:21:54 +0100
Date: Thu, 30 Jan 2025 16:21:52 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lars@metafoo.de>, <Michael.Hennerich@analog.com>,
	<marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
	<marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v2 04/16] dt-bindings: iio: adc: ad7768-1: add VMC
 output property
Message-ID: <20250130162152.0000470a@huawei.com>
In-Reply-To: <55eb1af7-775e-4f3d-8532-0f0300057a75@baylibre.com>
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
	<e17337bc3b0f2e95d3d4f7b6daa7755881e11fba.1737985435.git.Jonathan.Santos@analog.com>
	<55eb1af7-775e-4f3d-8532-0f0300057a75@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 27 Jan 2025 19:28:10 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 1/27/25 9:12 AM, Jonathan Santos wrote:
> > The AD7768-1 provides a buffered common-mode voltage output
> > on the VCM pin that can be used to bias analog input signals.
> >=20
> > Add adi,vcm-output to enable the configuration of the VCM output
> > circuit.
> >=20
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > ---
> > v2 Changes:
> > * New patch in v2.
> > ---
> >  .../bindings/iio/adc/adi,ad7768-1.yaml           | 10 ++++++++++
> >  include/dt-bindings/iio/adc/adi,ad7768-1.h       | 16 ++++++++++++++++
> >  2 files changed, 26 insertions(+)
> >  create mode 100644 include/dt-bindings/iio/adc/adi,ad7768-1.h
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yam=
l b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > index da05c8448530..e26513a9469b 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > @@ -59,6 +59,15 @@ properties:
> >        In the absence of this property, Synchronization over SPI will be
> >        enabled.
> > =20
> > +  adi,vcm-output:
> > +    description: |
> > +      Configures the Common-Mode Voltage Output. The VCM is provided b=
y an
> > +      amplifier external to the AD7768-1 and can be used as common-mod=
e voltage
> > +      by the ADC. There are 8 output voltage options available, and th=
e macros
> > +      for these values can be found at dt-bindings/iio/adi,ad7768-1.h
> > +    items:
> > +        enum: [0, 1, 2, 3, 4, 5, 6, 7]
> > + =20
>=20
> I was expecting this to use regulator provider bindings rather than using=
 a
> custom property. Then the regulator consumer could request the voltage th=
at
> they need. But maybe that is more complicated than what is practical.
If we need to represent the analog front end (likely we do as will affect s=
caling
etc) then regulator makes sense.  That front end will need a driver. Perhaps
an extension of drivers/iio/afe/iio-rescale.c

>=20
> If we don't need regulator bindings, then this should be vcm-microvolt to=
 use
> standard units [1].
>=20
> [1]: https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schem=
as/property-units.yaml
>=20
> >    reset-gpios:
> >      maxItems: 1
> > =20
> > @@ -132,6 +141,7 @@ examples:
> >              gpio-controller;
> >              #gpio-cells =3D <2>;
> >              vref-supply =3D <&adc_vref>;
> > +            adi,vcm-output =3D <AD7768_VCM_OUTPUT_AVDD1_AVSS_2>;
> >              interrupts =3D <25 IRQ_TYPE_EDGE_RISING>;
> >              interrupt-parent =3D <&gpio>;
> >              adi,sync-in-gpios =3D <&gpio 22 GPIO_ACTIVE_LOW>;
> > diff --git a/include/dt-bindings/iio/adc/adi,ad7768-1.h b/include/dt-bi=
ndings/iio/adc/adi,ad7768-1.h
> > new file mode 100644
> > index 000000000000..469ea724c0d5
> > --- /dev/null
> > +++ b/include/dt-bindings/iio/adc/adi,ad7768-1.h
> > @@ -0,0 +1,16 @@
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> > +
> > +#ifndef _DT_BINDINGS_ADI_AD7768_1_H
> > +#define _DT_BINDINGS_ADI_AD7768_1_H
> > +
> > +/* Sets VCM output to (AVDD1 =E2=88=92 AVSS)/2 */
> > +#define AD7768_VCM_OUTPUT_AVDD1_AVSS_2	0x00
> > +#define AD7768_VCM_OUTPUT_2_5V		0x01
> > +#define AD7768_VCM_OUTPUT_2_05V		0x02
> > +#define AD7768_VCM_OUTPUT_1_9V		0x03
> > +#define AD7768_VCM_OUTPUT_1_65V		0x04
> > +#define AD7768_VCM_OUTPUT_1_1V		0x05
> > +#define AD7768_VCM_OUTPUT_0_9V		0x06
> > +#define AD7768_VCM_OUTPUT_OFF		0x07
> > +
> > +#endif /* _DT_BINDINGS_ADI_AD7768_1_H */ =20
>=20
>=20
>=20


