Return-Path: <linux-iio+bounces-5713-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B33158D8AA9
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 22:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66EF62817D3
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 20:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB65513B298;
	Mon,  3 Jun 2024 20:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1UtZkoV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D3B13792E;
	Mon,  3 Jun 2024 20:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717444826; cv=none; b=WU7m9w+YoYbrGdmCU0JDkspHP+Sk6fgz2P0cjjXcV/nA6P6V/7OQeT6gJTJTI+hWPme1FXxdNFJfgQOmlLGasH2HmsH/q3jOdaJOW566l1wHC1J8gzTtEjPWTJ3xAKeX5fEJzRvgqQ55xtZboV+V4O5kkbRw55YfcjyUbi4pxs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717444826; c=relaxed/simple;
	bh=AJQsPsG8vSlttPUuuiwg/Xach2Y94D3hONDMPYUUeMc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cZUNqXAACyn3ony+sLM+EJqxGHNuXgZmkC1TIFOjD2cZGGAGq/DV6ra1GTyjcAi9nB+fjC9TiJWIAGb52JQ5syJg67Cxx7hTEKaf0kyGXlrbGygzcVTtWklBkk9/QtZjZxvn1VWkVPXReH5S4xUDpEm0/PLROXmnUgMzNJWcHyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1UtZkoV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA60C2BD10;
	Mon,  3 Jun 2024 20:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717444826;
	bh=AJQsPsG8vSlttPUuuiwg/Xach2Y94D3hONDMPYUUeMc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W1UtZkoVjFSgA0IZSuRZ1UTXTzOXUByd9T7r3DXdX//hpkqj+aG4fcC7P7QyoF6qE
	 6XvaDsdSkv6MUnSiW6usR/6PgxmbBlCPCAigqi8TNpkvHzDYNfVW1U6Ili1AWaomRK
	 WNz6UAd02EGHdJNoOAKbLe7dZsUMFn8dsiN/6gVMWHejJKQ+2j6I9GzxCxUm7H/rLb
	 oysxiNsgECvIbn38p8weTfEKRQtBJPKiBST+KneKCfxocjMsnl5VkCP4s2RXlUWxYu
	 mZs3IpLQ2DtGTzWo8MKxyYZoI4DY/nNknlUSMBrTCG8cgN5qjWYdnfeAvdgrFKTlCj
	 +cxms0IuxfVjA==
Date: Mon, 3 Jun 2024 21:00:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
Cc: Dumitru Ceclan via B4 Relay
 <devnull+dumitru.ceclan.analog.com@kernel.org>, dumitru.ceclan@analog.com,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] dt-bindings: adc: ad7173: add support for ad411x
Message-ID: <20240603210014.6258134d@jic23-huawei>
In-Reply-To: <efa10caa-5e78-4f3f-8cca-c61d7a01e6fd@gmail.com>
References: <20240531-ad4111-v4-0-64607301c057@analog.com>
	<20240531-ad4111-v4-1-64607301c057@analog.com>
	<20240601193512.0e17992b@jic23-huawei>
	<efa10caa-5e78-4f3f-8cca-c61d7a01e6fd@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Jun 2024 12:46:10 +0300
"Ceclan, Dumitru" <mitrutzceclan@gmail.com> wrote:

> On 01/06/2024 21:35, Jonathan Cameron wrote:
> > On Fri, 31 May 2024 22:42:27 +0300
> > Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.o=
rg> wrote:
> >  =20
> >> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> >>
> >> Add support for: AD4111, AD4112, AD4114, AD4115, AD4116.
> >>
> >> AD411x family ADCs support a VCOM pin. The purpose of this pin is to
> >> offer a dedicated common-mode voltage input for single-ended channels.
> >> This pin is specified as supporting a differential channel with VIN10 =
on
> >> model AD4116.
> >>
> >> AD4111/AD4112 support current channels. Support is implemented using
> >> single-channel and "adi,current-channel".
> >>
> >> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com> =20
> > I like the common-mode-channel solution to the pseudo differential
> > description. It makes things explicit whilst avoiding an ugly different=
ial
> > but not differential mess.
> >=20
> > However, it feels like a general thing to me not a vendor specific one.
> > Perhaps makes sense to put in adc.yaml?
> >  =20
>=20
> Sure
>=20
> > One other question that is more me being curious and failing to underst=
and
> > the datasheet than a request to change anything. =20
> >> ---
> >>  .../devicetree/bindings/iio/adc/adi,ad7173.yaml    | 192 ++++++++++++=
++++++++-
> >>  1 file changed, 190 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml=
 b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> >> index ea6cfcd0aff4..d8474eee553e 100644
> >> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> >> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> >> @@ -19,7 +19,18 @@ description: |
> >>    primarily for measurement of signals close to DC but also delivers
> >>    outstanding performance with input bandwidths out to ~10kHz.
> >> =20
> >> +  Analog Devices AD411x ADC's:
> >> +  The AD411X family encompasses a series of low power, low noise, 24-=
bit,
> >> +  sigma-delta analog-to-digital converters that offer a versatile ran=
ge of
> >> +  specifications. They integrate an analog front end suitable for pro=
cessing
> >> +  fully differential/single-ended and bipolar voltage inputs.
> >> +
> >>    Datasheets for supported chips:
> >> +    https://www.analog.com/media/en/technical-documentation/data-shee=
ts/AD4111.pdf
> >> +    https://www.analog.com/media/en/technical-documentation/data-shee=
ts/AD4112.pdf
> >> +    https://www.analog.com/media/en/technical-documentation/data-shee=
ts/AD4114.pdf
> >> +    https://www.analog.com/media/en/technical-documentation/data-shee=
ts/AD4115.pdf
> >> +    https://www.analog.com/media/en/technical-documentation/data-shee=
ts/AD4116.pdf
> >>      https://www.analog.com/media/en/technical-documentation/data-shee=
ts/AD7172-2.pdf
> >>      https://www.analog.com/media/en/technical-documentation/data-shee=
ts/AD7172-4.pdf
> >>      https://www.analog.com/media/en/technical-documentation/data-shee=
ts/AD7173-8.pdf
> >> @@ -31,6 +42,11 @@ description: |
> >>  properties:
> >>    compatible:
> >>      enum:
> >> +      - adi,ad4111
> >> +      - adi,ad4112
> >> +      - adi,ad4114
> >> +      - adi,ad4115
> >> +      - adi,ad4116
> >>        - adi,ad7172-2
> >>        - adi,ad7172-4
> >>        - adi,ad7173-8
> >> @@ -129,10 +145,54 @@ patternProperties:
> >>          maximum: 15
> >> =20
> >>        diff-channels:
> >> +        description: |
> >> +          This property is used for defining the inputs of a differen=
tial
> >> +          voltage channel. The first value is the positive input and =
the second
> >> +          value is the negative input of the channel.
> >> +
> >> +          Family AD411x supports a dedicated VINCOM voltage input.
> >> +          To select it set the second channel to 16.
> >> +            (VIN2, VINCOM) -> diff-channels =3D <2 16>
> >> +
> >> +          There are special values that can be selected besides the v=
oltage
> >> +          analog inputs:
> >> +            21: REF+
> >> +            22: REF=E2=88=92
> >> +          Supported only by AD7172-2, AD7172-4, AD7175-2, AD7175-8, A=
D7177-2:
> >> +            19: ((AVDD1 =E2=88=92 AVSS)/5)+
> >> +            20: ((AVDD1 =E2=88=92 AVSS)/5)=E2=88=92 =20
> >=20
> > That's what it says on the datasheet (so fine to copy that here) but I'=
m curious, what does
> > that mean in practice?  How can we have negative and postive signals of=
 the difference
> > between two power supply voltages where I'm fairly sure AVDD1 always gr=
eater than AVSS.
> > =20
>=20
> I have not tested that as I do not have a model that supports this wired =
up.
> If I had to guess they are the same signal but one should be connected to=
 the
> positive input, one to the negative input...but I could be wrong.

If they are, then as far as I we are concerned is this one channel with two
representations depending on whether it is 1st or 2nd in the list?
Can we use one number and hide that detail in the driver?

Seems odd though if that is the case.

I guess if we find out later this is the case we can tighten the binding to
enforce the right one instead of squashing them to one value, but that
is a bit ugly.  Any chance of digging out the info?  If not we can go ahead
but ideally answering things like this make a our life easier in the long r=
un.

Jonathan


> =20
> > Anyhow, that's a problem for the person reading the datasheet to figure=
 out :)
> >   =20
> >> +
> >>          items:
> >>            minimum: 0
> >>            maximum: 31
> >> =20
> >> +      single-channel:
> >> +        description: |
> >> +          This property is used for defining a current channel or the=
 positive
> >> +          input of a voltage channel (single-ended or pseudo-differen=
tial).
> >> +
> >> +          Models AD4111 and AD4112 support current channels.
> >> +            Example: (IIN2+, IIN2=E2=88=92) -> single-channel =3D <2>
> >> +          To correctly configure a current channel set the "adi,curre=
nt-channel"
> >> +          property to true.
> >> +
> >> +          To configure a single-ended/pseudo-differential channel set=
 the
> >> +          "adi,common-mode-channel" property to the desired negative =
voltage input.
> >> +
> >> +          When used as a voltage channel, special inputs are valid as=
 well.
> >> +        minimum: 0
> >> +        maximum: 31
> >> +
> >> +      adi,common-mode-channel:
> >> +        $ref: /schemas/types.yaml#/definitions/uint32
> >> +        description:
> >> +          This property is used for defining the negative input of a
> >> +          single-ended or pseudo-differential voltage channel.
> >> +
> >> +          Special inputs are valid as well.
> >> +        minimum: 0
> >> +        maximum: 31
> >> + =20
> >  =20
>=20


