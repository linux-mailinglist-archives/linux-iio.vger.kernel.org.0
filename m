Return-Path: <linux-iio+bounces-2147-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DB2848EAA
	for <lists+linux-iio@lfdr.de>; Sun,  4 Feb 2024 15:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D1A31F21241
	for <lists+linux-iio@lfdr.de>; Sun,  4 Feb 2024 14:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42741DFFD;
	Sun,  4 Feb 2024 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XP14ST3U"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90457225B2;
	Sun,  4 Feb 2024 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707058308; cv=none; b=HWmbOnAXPc7GzjoD5YVHd0BL85qifCO7MM1JLT0SCSApVPq/itpVGBeR3QpM/lkinAdaUgxDDg45X5PW400q72QwBSXoQJtfcqjimOcE733W6GRR59V0ePXRwzsPR9IM4K9b0GDu+z4XHSvLXhAwwPksu5DMMgbCgK6WR5SAlYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707058308; c=relaxed/simple;
	bh=t7S814SNeE45gOd2eWDw4/P9axTxP7rO4LkRrzU7hY8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=koQnQALWkm6Fcax1j/4WB5hkPmSscVBTGtNoXWP0johdI+T5cqsDo2+wE5V3SKF05Y686Ycx+ZVx8GmUe4qPiS1tZRaoeGX8ttPW6Kf9wAVixup/elhnqpCaNnZmeAhiBgFMt2Nh3AKeFQ7e18C0nY2PVwzkNE/yoQM2Uy2xckE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XP14ST3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94D8C433C7;
	Sun,  4 Feb 2024 14:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707058308;
	bh=t7S814SNeE45gOd2eWDw4/P9axTxP7rO4LkRrzU7hY8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XP14ST3U1QZZpvRPiffvep4J3ayGvcU9tcW0mVwT+1WQYz/ivGNlQarHVauXqS66Z
	 T+Kffh9IL5MHVqfZTmMENYcTmPPNFktKecTHZeD1ux9FrBlqvgfXeIUcyw6vTc66NV
	 hIbb068tXjXlbp5h83kHO54LPs6MrA2SDaSDtQbd5GjBCALbLG6nc3AM5dGi6WVScn
	 +hVF1jhO7hgd0jyp94LocR+XHBm2g/VuhKvZewnKMyv9l6YXZpRjqsTmjnQ6i+jTZM
	 zcC+7tgsRgwUdou4VE8nv5OBI5sw9BwEHguUvOcGQt4tpY//AmKf6+lqYFqescGahz
	 2ydY1f+lZn93w==
Date: Sun, 4 Feb 2024 14:51:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Sa, Nuno" <Nuno.Sa@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v8 2/7] dt-bindings: adc: axi-adc: update bindings for
 backend framework
Message-ID: <20240204145133.07cd8399@jic23-huawei>
In-Reply-To: <SJ0PR03MB677855546629FA8352AC2D4E99402@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <20240202-iio-backend-v8-0-f65ee8c8203d@analog.com>
	<20240202-iio-backend-v8-2-f65ee8c8203d@analog.com>
	<CAMknhBHx7U7goWMgygwOA0cpJoPfmCD=8gKZNoBvqcb0ptK0yw@mail.gmail.com>
	<SJ0PR03MB677855546629FA8352AC2D4E99402@SJ0PR03MB6778.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 4 Feb 2024 07:30:05 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > -----Original Message-----
> > From: David Lechner <dlechner@baylibre.com>
> > Sent: Friday, February 2, 2024 10:38 PM
> > To: Sa, Nuno <Nuno.Sa@analog.com>
> > Cc: linux-iio@vger.kernel.org; devicetree@vger.kernel.org; Lars-Peter C=
lausen
> > <lars@metafoo.de>; Hennerich, Michael <Michael.Hennerich@analog.com>;
> > Jonathan Cameron <jic23@kernel.org>; Rob Herring <robh+dt@kernel.org>;
> > Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> > <conor+dt@kernel.org>; Frank Rowand <frowand.list@gmail.com>; Olivier
> > Moysan <olivier.moysan@foss.st.com>; Rob Herring <robh@kernel.org>
> > Subject: Re: [PATCH v8 2/7] dt-bindings: adc: axi-adc: update bindings =
for backend
> > framework
> >=20
> >=20
> > On Fri, Feb 2, 2024 at 9:10=E2=80=AFAM Nuno Sa via B4 Relay
> > <devnull+nuno.sa.analog.com@kernel.org> wrote: =20
> > >
> > > From: Nuno Sa <nuno.sa@analog.com>
> > >
> > > 'adi,adc-dev' is now deprecated and must not be used anymore. Hence,
> > > also remove it from being required.
> > >
> > > The reason why it's being deprecated is because the axi-adc CORE is n=
ow
> > > an IIO service provider hardware (IIO backends) for consumers to make=
 use
> > > of. Before, the logic with 'adi,adc-dev' was the opposite (it was kind
> > > of consumer referencing other nodes/devices) and that proved to be wr=
ong
> > > and to not scale.
> > >
> > > Now, IIO consumers of this hardware are expected to reference it usin=
g the
> > > io-backends property. Hence, the new '#io-backend-cells' is being add=
ed
> > > so the device is easily identified as a provider.
> > >
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > ---
> > >  Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 8 +++++=
---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.ya=
ml =20
> > b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml =20
> > > index 9996dd93f84b..add10b22dcac 100644
> > > --- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> > > @@ -39,12 +39,15 @@ properties:
> > >      $ref: /schemas/types.yaml#/definitions/phandle
> > >      description:
> > >        A reference to a the actual ADC to which this FPGA ADC interfa=
ces to.
> > > +    deprecated: true
> > > +
> > > +  '#io-backends-cells' =20
> >=20
> > Still missing the : here. =20
>=20
> Ahh crap!! I was so blindly assuming the error report was because the pro=
perty could
> still be missing in the core schemas that I did not even paid attention. =
Thanks for this!
>=20
> But worst, the property is not even correct. #io-backends-cells -> #io-ba=
ckend-cells
> Both here and in the example.
>=20
> Jonathan, sorry about this... Let me know if this is something you can fi=
x or if you
> want me to spin another version.
I've tried to fix it up.  Please check the testing branch to see if I messe=
d it up.

>=20
> - Nuno S=C3=A1
>=20


