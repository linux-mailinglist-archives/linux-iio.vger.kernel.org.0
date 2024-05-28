Return-Path: <linux-iio+bounces-5409-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539488D2162
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 18:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D5428741D
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 16:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E8A172777;
	Tue, 28 May 2024 16:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eztC8bdM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B99932C60;
	Tue, 28 May 2024 16:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716912883; cv=none; b=JoKPM287u97u3lvtgnOV0awkpmgTLJzF/+v7KUWTxOEuwScknK708cAomzt1wafKS8bKXMRk9ba+djD0sH6qSrl+nFW7VZpbzJuh1smLcOU0s+CA5DeJPfGPkzOc8L+GMlEExjUP3iQRU01v5sHmBP5UxX4Nko500HgKh/SvnYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716912883; c=relaxed/simple;
	bh=B4VJ8hgbLzcNXTauElGy1OCyKHfkRrk3PYmYr4u/f4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F635xknVdpm/k0ZSlfD91lZRFKy6ORsCV+4av25+T+BOgJ20mO+CiB1eqPHgJDx+WLELHGb0ngc7ywzNQYOt5w3o7zeRAnEeooZOhd8/qChjRCJBGTQzgaD+2pU9XQ/67xRjsO/rGKSkzjZ0EBT4x+TIrqYOracy/8y0mkAwOf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eztC8bdM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A4AC3277B;
	Tue, 28 May 2024 16:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716912882;
	bh=B4VJ8hgbLzcNXTauElGy1OCyKHfkRrk3PYmYr4u/f4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eztC8bdMmyw8O6pmb20OcdekmBoZ4pHASGZJ+OygW6+D2CmRf3xyULluwR2F73Xw7
	 N30ZSrrmGiZyASTEGqA4PVeBYfpPhbU2fK26K8vHXxhhu+PkDsVCgBvYG1wdp8fBoR
	 iBu4ml6g/Sjhw5SW0GIvmWHuumGcOxHg+qDrGkKa/fDbzxBYr5qOlfS4f0d/9948Dl
	 OSL9sWzXrg4lemoqLFbTb//6+CCSF3YtufijkqehCE/4lnI0wjCgRVlu5MEzf/ziML
	 fJcrIdrflDTm0kT2qpAYx3PWbKBaJJOG/SHY/HezyAcTxr2r1s0LEJ3lNSHeolQ5a6
	 uzj80Ydorz/7g==
Date: Tue, 28 May 2024 17:14:38 +0100
From: Conor Dooley <conor@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: add ti,ads1119
Message-ID: <20240528-engaging-plop-e5d20a1a3fd1@spud>
References: <20240527154050.24975-1-francesco@dolcini.it>
 <20240527154050.24975-2-francesco@dolcini.it>
 <20240527-ecosystem-mountable-d9a6eebc7607@spud>
 <20240528150440.GA15947@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5axobdhDL6AYY1vD"
Content-Disposition: inline
In-Reply-To: <20240528150440.GA15947@francesco-nb>


--5axobdhDL6AYY1vD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 05:04:40PM +0200, Francesco Dolcini wrote:
> On Mon, May 27, 2024 at 05:29:37PM +0100, Conor Dooley wrote:
> > On Mon, May 27, 2024 at 05:40:49PM +0200, Francesco Dolcini wrote:
> > > From: Jo=E3o Paulo Gon=E7alves <joao.goncalves@toradex.com>
> > >=20
> > > Add devicetree bindings for Texas Instruments ADS1119 16-bit ADC
> > > with I2C interface.
> > >=20
> > > Datasheet: https://www.ti.com/lit/gpn/ads1119
> > > Signed-off-by: Jo=E3o Paulo Gon=E7alves <joao.goncalves@toradex.com>
> > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > ---
> > >  .../bindings/iio/adc/ti,ads1119.yaml          | 122 ++++++++++++++++=
++
> > >  MAINTAINERS                                   |   7 +
> > >  2 files changed, 129 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1=
119.yaml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1119.yam=
l b/Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
> > > new file mode 100644
> > > index 000000000000..ab4f01199dbe
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
> > > @@ -0,0 +1,122 @@
>=20
> ...
>=20
> > > +patternProperties:
> > > +  "^channel@([0-6])$":
> > > +    $ref: adc.yaml
> > > +    type: object
> > > +    description: |
> > > +      ADC channels.
> > > +
> > > +    properties:
> > > +      reg:
> > > +        description: |
> > > +          0: Voltage over AIN0 and AIN1.
> > > +          1: Voltage over AIN2 and AIN3.
> > > +          2: Voltage over AIN1 and AIN2.
> > > +          3: Voltage over AIN0 and GND.
> > > +          4: Voltage over AIN1 and GND.
> > > +          5: Voltage over AIN2 and GND.
> > > +          6: Voltage over AIN3 and GND.
> >=20
> > Take a look at diff-channels.
>=20
> Yes, we looked at this and at the beginning we did not think this was a
> right idea. This is pretty much copying what is done in
> Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml.
>=20
> We could describe this using the diff-channels, however the MUX in the
> ADS1119 cannot do any combination, but only a subset (AIN0-AIN1,
> AIN2-AIN3 and AIN1-AIN2).
>=20
> Are you aware of a way to validate this in the DT?

I'm not sure of a neat way to restrict the options like that, no.

> Would something like that work?

This looks fine to me, but a look from Jonathan would be good.

>=20
> adc@40 {
>     compatible =3D "ti,ads1119";
>     reg =3D <0x40>;
>     #address-cells =3D <1>;
>     #size-cells =3D <0>;
>     #io-channel-cells =3D <1>;
>    =20
>     channel@0 {
>         reg =3D <0>;
>         diff-channels =3D <3 4>;
> 	label =3D "AIN0_AIN1"
>     };
>    =20
>     channel@1 {
>         reg =3D <1>;
>         diff-channels =3D <5 6>;
> 	label =3D "AIN2_AIN3"
>     };
>    =20
>     channel@2 {
>         reg =3D <2>;
>         diff-channels =3D <4 5>;
> 	label =3D "AIN1_AIN2"
>     };
>    =20
>     channel@3 {
>         reg =3D <3>;
> 	label =3D "AIN0"
>     };
>    =20
>     channel@4 {
>         reg =3D <4>;
> 	label =3D "AIN1"
>     };
>    =20
>     channel@5 {
>         reg =3D <5>;
> 	label =3D "AIN2"
>     };
>    =20
>     channel@6 {
>         reg =3D <6>;
> 	label =3D "AIN3"
>     };
> };
>=20
>=20
> > > +        items:
> > > +          - minimum: 0
> > > +            maximum: 6
> > > +
> > > +      ti,gain:
> >=20
> > What makes this a property of the hardware?
> > Also, missing unit.
>=20
> This is a hardware gain from the ADC and it is dimensionless.

Maybe I phrased my question incorrectly. I'll try again:
What makes the gain a fixed property of the hardware?

I guess I was expecting to see a gain in decibels, but w/e.
What do 1 and 4 represent here?

> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +        description:
> > > +          PGA gain value.
> > > +        enum: [1, 4]
> > > +        default: 1
> > > +
> > > +      ti,datarate:
> >=20
> > Ditto here, why's this a property of the hardware? Usually this gets set
> > from sysfs..
>=20
> The sample rate is a hardware property, you can configure the ADC device
> to do the acquisition at a specific rate.

Same thing here, poorly phrased question from me I think. Why is this is
a fixed property of the hardware, rather than something that a user may
want to control? Last time I saw one of these kind of properties,
Jonathan commented:
| It's unusual for sampling rate to be a property of the hardware and hence
| suitable for DT binding. Normally we make this a userspace control instea=
d.
| If there is a reason for doing it from DT, that wants to be mentioned her=
e.

> Both these properties are inspired from
> Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml.
>=20
> We could do what you are suggesting here. I am just a concerned on how
> this interacts with the iio/afe/ bindings. Specifically, how could I
> configure the gain or the data rate when this ADC is used by a
> voltage-divider? Maybe iio-rescale driver needs to be extended for such
> use case?

For configuring the gain in that scenario, you probably need Jonathan or
Peter to comment on, I'm not sure how the sysfs controls work for that.
I'm not sure what a voltage divider would have to do with the data rate,
so I guess this is something related to how the sysfs files are
structured? Again, it'll probably be Jonathan or one of the guys that
actually deals with the userspace side of things (I haven't beyond a
trivial application) that'll have to answer that.

Thanks,
Conor.

--5axobdhDL6AYY1vD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlYC7gAKCRB4tDGHoIJi
0hwyAPkB4l9YIxRJhS+/Weh1LZNzOyUZj7DuLxB+A0LCeGx2lgD/czQTjtyYorH6
aQbm7uZ08oEm5bMeir1AgxV3ALJVMgA=
=KpJW
-----END PGP SIGNATURE-----

--5axobdhDL6AYY1vD--

