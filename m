Return-Path: <linux-iio+bounces-1272-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0D981E835
	for <lists+linux-iio@lfdr.de>; Tue, 26 Dec 2023 16:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BF01B21C9D
	for <lists+linux-iio@lfdr.de>; Tue, 26 Dec 2023 15:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EB64F5E4;
	Tue, 26 Dec 2023 15:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOxcgEBO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714794F217;
	Tue, 26 Dec 2023 15:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419B4C433C7;
	Tue, 26 Dec 2023 15:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703606119;
	bh=8JGzOcRQ7km+o0csOcujVKk27CfJNmOQwuEWroC2gDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aOxcgEBOXJGr4LDyhvYfPoVeSQFKanrzD1xXIpTd9pSWy3d+19S3ZsbVECc6GKHbi
	 u55KkVdmoc+z51dPmUMmM47Iy6wD/5vfrddwJ8BRXQrqiHAWMTqV08RML98T2AxuGi
	 XF3iX/RrrMAgKNrEkKFsbmDo4kwcxyYV6MznPixOtijfM2qrurWCkpxSSBAjXSOFdd
	 ynNq4U+mSSPirE+Dxh1e+YtafIIiCBG/TB1CD+mPHfEMbdeBACKHpe3ABDcp24OuNt
	 w8Xfnl653q7VyXfeNdcRaOG2kOZa3lZe28sX+a3yddpX0QYnvufehDQCRvN2UiHg31
	 1nh3r6cdJ3eXQ==
Date: Tue, 26 Dec 2023 15:55:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v4 2/8] dt-bindings: adc: axi-adc: deprecate
 'adi,adc-dev'
Message-ID: <20231226155508.388ae670@jic23-huawei>
In-Reply-To: <0412e07926d67490a66d0aac19ecca734ce54426.camel@gmail.com>
References: <20231220-iio-backend-v4-0-998e9148b692@analog.com>
	<20231220-iio-backend-v4-2-998e9148b692@analog.com>
	<20231221172538.6477b843@jic23-huawei>
	<0412e07926d67490a66d0aac19ecca734ce54426.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Dec 2023 10:07:34 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2023-12-21 at 17:25 +0000, Jonathan Cameron wrote:
> > On Wed, 20 Dec 2023 16:34:05 +0100
> > Nuno Sa <nuno.sa@analog.com> wrote:
> >  =20
> > > 'adi,adc-dev' is now deprecated and must not be used anymore. Hence,
> > > also remove it from being required. =20
> >=20
> > With my 'specifications language' brain engaged (also know as pedantic)
> > I think this is a 'should' not a 'must' case. You aren't breaking
> > backwards compatibility just advising moving to the newer / better inte=
rface.
> >  =20
>=20
> Well, you surely know better than me as a native speaker :)
>=20
> >  =20
> > >=20
> > > The reason why it's being deprecated is because the axi-adc CORE is n=
ow
> > > an IIO service provider hardware (IIO backends) for consumers to make=
 use
> > > of. Before, the logic with 'adi,adc-dev' was the opposite (it was kind
> > > of consumer referencing other nodes/devices) and that proved to be wr=
ong
> > > and to not scale.
> > >=20
> > > Now, IIO consumers of this hardware are expected to reference it usin=
g the
> > > io-backends property.
> > >=20
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > ---
> > > =C2=A0Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 4 =
+---
> > > =C2=A01 file changed, 1 insertion(+), 3 deletions(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.ya=
ml
> > > b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> > > index 9996dd93f84b..835b40063343 100644
> > > --- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> > > @@ -39,12 +39,12 @@ properties:
> > > =C2=A0=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/definitions/phand=
le
> > > =C2=A0=C2=A0=C2=A0=C2=A0 description:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A reference to a the actual ADC =
to which this FPGA ADC interfaces to.
> > > +=C2=A0=C2=A0=C2=A0 deprecated: true
> > > =C2=A0
> > > =C2=A0required:
> > > =C2=A0=C2=A0 - compatible
> > > =C2=A0=C2=A0 - dmas
> > > =C2=A0=C2=A0 - reg
> > > -=C2=A0 - adi,adc-dev =20
> >=20
> > Dropping it from required is fine, but do we have a new condition where=
 one or the
> > other
> > should be required?=C2=A0 If so good to add the dt-binding magic to enf=
orce that. Look
> > for a oneOf combined with required. There are a few IIO examples of thi=
s either or
> > type required. You may want to then enforce that both are not provided =
though I
> > guess we perhaps don't care - the driver will just prioritise one appro=
ach over the
> > other.
> >  =20
>=20
> Hmm, the thing is that io-backends is applied in the frontend device (so =
other
> binding) and in here we should only have the adi,adc-dev which is now dep=
recated so
> I'm not sure how that would look like?

Ah. I'd somehow failed to register the property is now in the other device.=
=20
Not much we can do then :(

>=20
> I think new users of the deprecated property are very unlikely unless the=
y choose to
> ignore the deprecated warning. As for old users (if they add the new one =
and don't
> remove this one, the new one will have priority). But I'm still confident=
 there are
> no users of this out there :(

Sometimes it's easier to cater for non existent users than get into too much
debate on whether they exist :)

Jonathan

>=20
>=20
> - Nuno S=C3=A1
>=20
>=20


