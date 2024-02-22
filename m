Return-Path: <linux-iio+bounces-2918-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A2786026F
	for <lists+linux-iio@lfdr.de>; Thu, 22 Feb 2024 20:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64951F21BA5
	for <lists+linux-iio@lfdr.de>; Thu, 22 Feb 2024 19:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AE314B83E;
	Thu, 22 Feb 2024 19:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZQRhhpL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D467714B828;
	Thu, 22 Feb 2024 19:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629337; cv=none; b=WbOcXI8jt4Rs8lv2UU8n3DdzG7Az5pf54u4/47cELGFyBjL7uUTUx9tctFFdvC6huqbOKGCcwhwFk1qcW6z0gXZR4w+eDTVzRybJyNRL9j8q8Q+CTTua2YD2/25Na9ZkDuTmhNBgp2nA7Rrby/jttAeH6hfEh7/qoz8zZEt8GbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629337; c=relaxed/simple;
	bh=uoHcq6vmDqKTEp/vi5c6UuNL2m2udk+dDugKpnCn8Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bcPPbUW+NOvOeEX25yFIgeeGmTvEvZqTCmU1HneNg5y1xjY85He5snl3wyf2LvIY2sPNdUFbTZq3YANI7g5k1eObqUP2tbVnDEcZOJfpoFdtaTbTwynWlnNP7PH0M/ixZ3aucQxgaQBgZwnKBJIZllNq8EERpGpDAYfa+n49isQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZQRhhpL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C71BC433F1;
	Thu, 22 Feb 2024 19:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708629337;
	bh=uoHcq6vmDqKTEp/vi5c6UuNL2m2udk+dDugKpnCn8Rw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PZQRhhpLlZm3PV4wadMAHcmL70Pu/w0Mky8XvK89shberWPjNstKA0HFgc6l52KTQ
	 y5aOGiVAHRf7tKje3EgArNQHZ8B+M17sjXHv5gYV0IjYYXBYABVFid85gd7aQZEtP5
	 YSfL8Rthk4ENNeCmJrgi3FiiOUoFqac0C9GV8kYEYLGz7cvjjFEwijZlO6hdqCS5qA
	 E4sHjINcil3+CwOsjOcEnKEppZCP/dcvMLGXnIp63UxLhZ2YQ0rkpBPA8E3WSfLiBn
	 yBv/sDuGhdmLWmmwkpZcaP+Kc1F9/+3tRI2kREEp8vvcmmfl2I9UfBOIL0DI9NRxY1
	 Q7lUl0+1m+VHA==
Date: Thu, 22 Feb 2024 19:15:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Nuno Sa
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>
Subject: Re: [PATCH 5/6] dt-bindings: iio: temperature: ltc2983: document
 power supply
Message-ID: <20240222191522.343f33a8@jic23-huawei>
In-Reply-To: <20240222-lance-sprinkled-04a7650ca316@spud>
References: <20240222-ltc2983-misc-improv-v1-0-cf7d4457e98c@analog.com>
	<20240222-ltc2983-misc-improv-v1-5-cf7d4457e98c@analog.com>
	<20240222-component-stiffen-d046386433b3@spud>
	<f31abc7140dfa8477623d4fca8abece03d37926e.camel@gmail.com>
	<20240222-lance-sprinkled-04a7650ca316@spud>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Feb 2024 17:54:28 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Thu, Feb 22, 2024 at 05:41:03PM +0100, Nuno S=C3=A1 wrote:
> > On Thu, 2024-02-22 at 15:40 +0000, Conor Dooley wrote: =20
> > > On Thu, Feb 22, 2024 at 01:55:56PM +0100, Nuno Sa wrote: =20
> > > > Add a property for the VDD power supply regulator.
> > > >=20
> > > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > > ---
> > > > =C2=A0Documentation/devicetree/bindings/iio/temperature/adi,ltc2983=
.yaml | 2 ++
> > > > =C2=A01 file changed, 2 insertions(+)
> > > >=20
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> > > > b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> > > > index dbb85135fd66..8aae867a770a 100644
> > > > --- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983=
.yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983=
.yaml
> > > > @@ -57,6 +57,8 @@ properties:
> > > > =C2=A0=C2=A0 interrupts:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > =C2=A0
> > > > +=C2=A0 vdd-supply: true =20
> > >=20
> > > Although technically an ABI break, should we make this supply require=
d?
> > > It is, at the end of the day, required by the hardware for operation.
> > >  =20
> >=20
> > I thought about it but then realized it could break some existing users=
 which is
> > never a nice thing. =20
>=20
> Could you explain what scenario it actually breaks a system (not
> produces warnings with dtbs_check)?
>=20
> If anything actually broke something, it would be the driver change that
> actually assumed that the regulator was present and refused to probe
> otherwise, right? In Linux at least, the regulator core will provide a
> dummy regulator if one doesn't exist - otherwise patch 6/6 would
> actually contain a DT ABI breakage, since it does:
>=20
> 	ret =3D devm_regulator_get_enable(&spi->dev, "vdd");
> 	if (ret)
> 		return ret;
>=20
> IMO making a new property required is only a meaningful break of the ABI
> when drivers reject probe when it is missing, but I must admit I don't
> know if other operating systems handle missing regulators as nicely as
> Linux does.

Agreed - adding a requirement on a supply to the dt-binding shouldn't
be a problem because of the dummy regulators.

Jonathan

>=20
> > I recently (in another series - the IIO backend) went through some trou=
ble to
> > actually not break ABI. Meaning, I had to do some not so neat hacking i=
n the
> > driver because Rob was more comfortable with not breaking ABI in DT. So=
, I
> > assumed he would not like for me to break it in here. =20
>=20


