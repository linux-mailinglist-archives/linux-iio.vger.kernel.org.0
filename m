Return-Path: <linux-iio+bounces-20335-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976B8AD22D7
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jun 2025 17:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9398F3A6784
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jun 2025 15:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414AB2153C6;
	Mon,  9 Jun 2025 15:44:33 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE702116F4;
	Mon,  9 Jun 2025 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483873; cv=none; b=IbyESaCQyjJQz604N9Us4zPlZ4vy/dMZCMpNdgHtCZqCsbkJXx5eTX/XNqcVJPlBLDEP2F+uoemGrhgGWW/i1TUi0/8UI0QCNrsAm8rqQd1A1f+ZduIJbxSl/vO9VSBj2yNCpBzib44BajfTJvv+tPk8d929CrQ8+yMhTGA90VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483873; c=relaxed/simple;
	bh=JKlHkku/y3WNFVhPvWG9ErWxr8aYjz8Q3mjdKp4Z3ZE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pn+BHnv1qRyffgAAj2Z886av1wE+Ppe/YsM8lUMQRmF5MFtQ6GbIEKDqicpyhtlQG8ups9N/TQh4u3sZZMYJLIXcRbyoyYmWpsdqEF5sbN84/XcMVfqgYXoAOED5C0Ra/KPuQkEKQ4CkL0tp9j72ayoO46vE+yBJfd4sXHVSWRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bGGQS0d2cz6L5Kc;
	Mon,  9 Jun 2025 23:42:40 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 54B261402F5;
	Mon,  9 Jun 2025 23:44:27 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 9 Jun
 2025 17:44:26 +0200
Date: Mon, 9 Jun 2025 16:44:25 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Marcelo Schmitt
	<marcelo.schmitt@analog.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lars@metafoo.de>,
	<Michael.Hennerich@analog.com>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linus.walleij@linaro.org>,
	<brgl@bgdev.pl>
Subject: Re: [PATCH v4 01/11] dt-bindings: iio: adc: Add AD4170
Message-ID: <20250609164425.00007a13@huawei.com>
In-Reply-To: <aEb9uRx_2Hdh0PzX@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1748829860.git.marcelo.schmitt@analog.com>
	<187e038cb9e7dbe3991149885cb0a4b30376660c.1748829860.git.marcelo.schmitt@analog.com>
	<20250607174521.6dee54fb@jic23-huawei>
	<aEb9uRx_2Hdh0PzX@debian-BULLSEYE-live-builder-AMD64>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 9 Jun 2025 12:28:57 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 06/07, Jonathan Cameron wrote:
> > On Mon, 2 Jun 2025 08:36:24 -0300
> > Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> >  =20
> > > Add device tree documentation for AD4170 and similar sigma-delta ADCs.
> > > The AD4170 is a 24-bit, multichannel, sigma-delta ADC.
> > >  =20
> ...
> > > +
> > > +$defs:
> > > +  reference-buffer:
> > > +    description: |
> > > +      Enable precharge buffer, full buffer, or skip reference buffer=
ing of
> > > +      the positive/negative voltage reference. Because the output im=
pedance
> > > +      of the source driving the voltage reference inputs may be dyna=
mic, RC =20
> >=20
> > RC? =20
>=20
> Stands for the combination of resistive and capacitive elements in the pa=
th
> between the reference supply output and AD4170 REFINn=B1 inputs.

Ah.  My head wasn't in the right space at all. RC is common enough term but
I'd still spell it out here as DC is very near as is ADC and the C is diffe=
rent
in all 3 cases :)

resistance/capacitance (RC)

or something along those lines should do the job.


>=20
> Datasheet Figure 76 shows an example with only capacitive elements, but i=
t could
> have resistive elements too.
> https://www.analog.com/media/en/technical-documentation/data-sheets/ad417=
0-4.pdf#unique_75_Connect_42_ID8013
>=20
> I will rephrase to make that clearer. This is probably too long and detai=
led
> description for a dt property. I can't figure out how to put that in a mo=
re
> concise and meaningful way, though.=20
>=20
> >  =20
> > > +      combinations of those inputs can cause DC gain errors if the r=
eference
> > > +      inputs go unbuffered into the ADC. Enable reference buffering =
if the
> > > +      provided reference source has dynamic high impedance output. N=
ote the
> > > +      absolute voltage allowed on REFINn+ and REFINn- inputs is from
> > > +      AVSS - 50 mV to AVDD + 50 mV when the reference buffers are di=
sabled
> > > +      but narrows to AVSS to AVDD when reference buffering is enable=
d or in
> > > +      precharge mode. The valid options for this property are:
> > > +      0: Reference precharge buffer.
> > > +      1: Full reference buffering.
> > > +      2: Bypass reference buffers (buffering disabled).
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    enum: [0, 1, 2]
> > > +    default: 1 =20
> >  =20
> ...
> > > +
> > > +      adi,excitation-current-0-microamp:
> > > +        description:
> > > +          Excitation current in microamperes to be applied to pin sp=
ecified in
> > > +          adi,excitation-pin-0 while this channel is active.
> > > +        enum: [0, 10, 50, 100, 250, 500, 1000, 1500] =20
> >=20
> > What motivated mix of using $ref and here where there is a lot of repet=
ition?
> > I don't mind which approach is used, but a mix seems the worst option.
> >  =20
>=20
> Because=20
> $defs:
>   ...
>   adi,excitation-current-n-microamp:
>     description:
>       Excitation current in microamperes to be applied to pin specified in
>       adi,excitation-pin-0 while this channel is active.
>     enum: [0, 10, 50, 100, 250, 500, 1000, 1500]
>     default: 0
>=20
> patternProperties:
>   ...
>       adi,excitation-current-0-microamp:
>         $ref: '#/$defs/adi,excitation-current-n-microamp'
>=20
>=20
> triggers dt_binding_check warn:
> 	patternProperties:^channel@[0-9a-f]$:properties:adi,excitation-current-0=
-microamp: '$ref' should not be valid under {'const': '$ref'}
> 	hint: Standard unit suffix properties don't need a type $ref
Fair enough!

J
>=20
>=20
> Thanks,
> Marcelo
>=20


