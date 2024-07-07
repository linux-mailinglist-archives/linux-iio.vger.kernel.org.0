Return-Path: <linux-iio+bounces-7408-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA909298A5
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 17:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B31F9B24BCB
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 15:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370A02C87C;
	Sun,  7 Jul 2024 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4Fq1ltJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15229461;
	Sun,  7 Jul 2024 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720366245; cv=none; b=ET6eZBGAE9idBp1yczDM4Q++lZgEpxKy1tFi/OZZFIKZS7ZuDVZVql6+PPmeIRi3a3cnnwgsA9Eihwe7SHUQXgmo/oS9H0COOLJbZsIgQ8d6BjGgp/PqwI4nVm6Fn2aBY9h+TP2BwYpfgX11rn8D17jiJfNZRGPG7yGex2DUl1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720366245; c=relaxed/simple;
	bh=xi48eQIHGSnXoVX5dd/OPc2mGclotqblulG1oVoZppA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U2HwKIJ00icB6o73DwpZo5ecH8pztPkh5Jn2OHnrmj6MlVWwSoDgDF0SDiIsQHMCo+Mu/jfn+iApYTmin587aDWpkzHNwlh9PA4RjD229Ml1JleLS1zpiVgM3eghlc8ioUJeEVGL/E3KDOewpfbL0/YgILTJikh3ZBC0z5TQHK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4Fq1ltJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86D9C3277B;
	Sun,  7 Jul 2024 15:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720366244;
	bh=xi48eQIHGSnXoVX5dd/OPc2mGclotqblulG1oVoZppA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H4Fq1ltJZtRtlwulljY9hO7zf/u+v99/Nh+0KfFCGUD2Yxh1JFWWNudxP2EsQrjes
	 v4D1QtZh1S3DK5LOZXqOWbIrXmbhp+CGKEIyRXUM5X0PCEMBLKCSeubuaAJcEciOga
	 SJdAi5U/TvXeCa731uD9yuN+mXrzxnZnWfUgzUdKtB5QFJFMl064LkG8zhd+Om+w+0
	 h4+0qwG4NNLfXdvqFUvxcyfmfXhVN3qXvrI/Lh9xqjr0n/2+9NUhiro0pwJRqmCo8e
	 U5qFCrRQ2U3nadSUgECaS/16CigFvUDJAc5f02TacJqVxUEOIIb5aeNJGCeV4baFmq
	 98v+Tsoy6yqvg==
Date: Sun, 7 Jul 2024 16:30:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petar Stoykov <pd.pstoykov@gmail.com>
Cc: Petar Stoykov via B4 Relay <devnull+pd.pstoykov.gmail.com@kernel.org>,
 linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: pressure: Add Sensirion SDP500
Message-ID: <20240707163036.478b7488@jic23-huawei>
In-Reply-To: <CADFWO8EBP7zFH9zBpHNaF0tfK5OAzOdc=OuVJ6c768FE97x9xg@mail.gmail.com>
References: <20240702-mainline_sdp500-v3-0-0902047b3eee@gmail.com>
	<20240702-mainline_sdp500-v3-1-0902047b3eee@gmail.com>
	<20240702211822.3bce44c2@jic23-huawei>
	<CADFWO8EBP7zFH9zBpHNaF0tfK5OAzOdc=OuVJ6c768FE97x9xg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Jul 2024 10:35:45 +0200
Petar Stoykov <pd.pstoykov@gmail.com> wrote:

> On Tue, Jul 2, 2024 at 10:18=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Tue, 02 Jul 2024 16:59:08 +0200
> > Petar Stoykov via B4 Relay <devnull+pd.pstoykov.gmail.com@kernel.org> w=
rote:
> > =20
> > > From: Petar Stoykov <pd.pstoykov@gmail.com>
> > >
> > > Sensirion SDP500 is a digital differential pressure sensor. It provid=
es
> > > a digital I2C output. Add devicetree bindings requiring the compatible
> > > string and I2C slave address (reg).
> > >
> > > Signed-off-by: Petar Stoykov <pd.pstoykov@gmail.com>
> > > ---
> > >  .../bindings/iio/pressure/sensirion,sdp500.yaml    | 41 ++++++++++++=
++++++++++
> > >  1 file changed, 41 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/pressure/sensirion=
,sdp500.yaml b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp=
500.yaml
> > > new file mode 100644
> > > index 000000000000..6b3e54def367
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp500=
.yaml
> > > @@ -0,0 +1,41 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/pressure/sdp500.yaml# =20
> >
> > Naming mismatch (as already reporteD). =20
>=20
> Same mistake as in the MAINTAINERS file. Sigh.
>=20
> > =20
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: sdp500/sdp510 pressure sensor with I2C bus interface
> > > +
> > > +maintainers:
> > > +  - Petar Stoykov <petar.stoykov@prodrive-technologies.com>
> > > +
> > > +description: |
> > > +  Pressure sensor from Sensirion with I2C bus interface.
> > > +  There is no software difference between sdp500 and sdp510.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - sensirion,sdp500
> > > +      - sensirion,sdp510 =20
> >
> > Include the vdd-supply both as a property and in requried.
> >
> >   vdd-supply: true;
> >
> > is enough for the property. =20
>=20
> Thank you for the example!
> But I don't think it's a required property.
> Our system is an example where it's not needed.
> The device is always powered on and Linux has no control over it's supply.
> One can argue that it's nice to write down what is that power supply but
> to me it's just noise, because I can write anything there and it would st=
ill
> work. So I prefer to not add anything instead of putting a value I can't =
trust.
>=20
I understand your nervousness, but put it in the binding doc anyway (not ne=
cessarily
in your dts though!)

There is a difference between what the binding requires (to work on
any operating system etc) and what the Linux driver stack requires.
The binding should specify any supply that is needed for the device to do a=
nything
useful.

That doesn't mean that you need to provide it on a board if it's always
powered up.

The Linux driver should include regulator enabling for the supply. If it's =
not
provided in firmware because it's always one, then the dummy regulators that
will get used are fine.

devm_regulator_get_enable() is all that's needed




> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    i2c {
> > > +      #address-cells =3D <1>;
> > > +      #size-cells =3D <0>;
> > > +      pressure@40 {
> > > +        compatible =3D "sensirion,sdp500";
> > > +        reg =3D <0x40>;
> > > +        vdd-supply =3D <&foo>;
> > > +      };
> > > +    };
> > > =20
> > =20


