Return-Path: <linux-iio+bounces-19861-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8972AAC33C1
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 12:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF6A11898436
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 10:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234BF1E5B71;
	Sun, 25 May 2025 10:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOTJX2oW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85B2FC1D;
	Sun, 25 May 2025 10:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748167525; cv=none; b=GbSChWRMNh0TQP85xQIRZaM9XfwN9uqR7LoUlS7vLBfCkWWJGkKiRT9CX0DxJ6vzoQ8tEsIckjr0ZsZIFmZGi2ZBxXR9hSvQo+3GWk56gvHAPKmROvwgqQH1y7FLumMw4eaLM7Xqw8VBuiLQHR0rQKrZgS5XcNwo7utp6G0+Cd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748167525; c=relaxed/simple;
	bh=no00FIYYFfuJS6RFteJo9QqhwSWc1QSRckjKLn3kcyk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdxVpwDwfU327iYkoWXLYC0JlnpmAxunOqbvHgdb82BnMGFP4vNr4eRqRP4fixEYwwNy6mnNRDNTrZgxLqzno66kbq6/uqBuHmika2fjY7BiRD//PgY35ZPy4RuHMcxykKhgq8mOlMNcZuAZJ3MHuUdbA3KpvGEiAuFtcmUKs0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOTJX2oW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6630CC4CEEF;
	Sun, 25 May 2025 10:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748167525;
	bh=no00FIYYFfuJS6RFteJo9QqhwSWc1QSRckjKLn3kcyk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qOTJX2oWK+YkpIeV55QtEsZYs4vXqhm5/zkatQcNAnOoeBz4rU5JrnJOwo2DStX6I
	 Xpc0dNhvlDaxXNAGvDxQrOxrj25TgzOuGoG+N1pcAuANeX46j7gqcmXRT+9ed+0ATy
	 FTjhzIA+J5JPOn0pundUbIWrBQELBiEfv7t7Ul90cE955fc/rRB0rTIYVW0acuNVZt
	 mCtHYL1n5EF9Jln7t8faY43T5az2zF/QK1TekhTpaiGgajRbWJuy6wf26/+W+zFG+K
	 Ron7dTHRwBGLCIAy1Nz2gE15Jd0laSFCQyNq7pz31JkdzD53/9RyaRuuFa60zXoS2i
	 cqQ35IbYcBEcQ==
Date: Sun, 25 May 2025 11:05:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linus.walleij@linaro.org, brgl@bgdev.pl
Subject: Re: [PATCH v3 01/10] dt-bindings: iio: adc: Add AD4170
Message-ID: <20250525110515.6e8cdfb2@jic23-huawei>
In-Reply-To: <aC89ve8FgIK4gej4@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1747083143.git.marcelo.schmitt@analog.com>
	<5fa867cff437c0c6d3f0122af823e1677a12d189.1747083143.git.marcelo.schmitt@analog.com>
	<20250521-colorful-paper-coot-ce9ffb@kuoka>
	<aC89ve8FgIK4gej4@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 22 May 2025 12:07:41 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> ...
> >  =20
> > > +  sensor-node:
> > > +    type: object
> > > +    $ref: '#/$defs/ad4170-channel' =20
> >=20
> > I do not understand this binding. channel@ node is a channel and sensors
> > like rtd@ is also channel but also sensor. What is the point of channel@
> > which is not a sensor?
> >  =20
> The sensor node is meant to describe a channel that has extra setup
> configuration. For example, a common ADC channel could look like this
>=20
>   -------- +VREF ------         +-------------------+
>     =C2=B4 `       =C2=B4 `              /                    |
>   /     \   /     \   /   --- <  IN+                |
>          `-=C2=B4       `-=C2=B4         |                    |
>   -------- -VREF ------        |                    |
>                                |            ADC     |
>   -------- +VREF ------        |                    |
>         =C2=B4 `       =C2=B4 `          |                    |
>   \   /     \   /     \   --- <  IN-                |
>    `-=C2=B4       `-=C2=B4               \       +VREF  -VREF |
>   -------- -VREF ------         +-------------------+
>                                          ^       ^
>                                          |       +---- External -VREF
>                                   External +VREF
>=20
> The the channel@ node for that would look like
>     adc@0 {
>         ...
>         channel@0 {
>             reg =3D <0>;
>             bipolar;
>             diff-channels =3D <0 1>;
>         };
>     };
>=20
> Though, some sigma-delta ADCs (including AD4170) are fancy and have featu=
res
> that relate to what is connected to the ADC inputs. For example, an RTD w=
ould
> be connected like
>=20
>                                      External +VREF
>                                           |
>        +----------------------------------|-------+---- External -VREF
>        |           +----------------------+       |
>        +---Rref----+                +-----v-------v----+
>        |           |               /    REFIN+  REFIN- |
>    +---+-----------|------------> <  IN+               |
>    |               |              |                    |
> 3-wire RTD         |              |            ADC     |
>    |               |              |                    |
>    +--------------------+-------> <  IN-               |
>    |               |    |          \      GPIO2 GPIO3  |
>    v               |    |           +-------v-----v----+
>   GND              |    +-------------------+     |
>                    |       <--- IOUT1             |
>                    +------------------------------+
>                            <--- IOUT0
>=20
> A better drawing can be found in AD4170 datasheet Figure 115. 3-Wire RTD =
Application.
> https://www.analog.com/media/en/technical-documentation/data-sheets/ad417=
0-4.pdf#unique_151_Connect_42_ID10430
>=20
> Since the RTD sensor requires additional hardware connections, the propos=
ed
> dt-binding describes those differently, e.g.=20
>=20
>     adc@0 {
>         ...
>         rtd@0 {
>             reg =3D <0>;
>             bipolar;
>             diff-channels =3D <0 1>;
>             adi,sensor-type =3D /bits/ 8 <1>;
>             adi,reference-select =3D <0>;
>             adi,excitation-pins =3D <19 20>;
>             adi,excitation-current-microamp =3D <500>;
>         };
>=20
> That allows the ADC chip to be configured to provide the excitation signa=
ls to
> properly handle the RTD sensor. Because the hardware connections and
> operation requirements vary among those external sensor types (RTDs,
> thermocouples, load cell weigh scales), some properties are only applicab=
le to
> specific sensor types. Also, because those are extra connections, the rel=
ated
> properties are not meaningful to typical ADC channels.
>=20
> Though, the supported features are not different from those described in
> Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml.
> In that binding, the properties related to external sensor support are set
> on the device node (not related to any channel). The binding proposed on =
AD4170
> RFC patch was more similar to adi,ad4130.yaml and somehow avoiding to int=
roduce
> custom/new properties, but that lead to a lot of duplication.
>=20
> The currently proposed dt-binding for ad4170 avoids repetition and, to so=
me
> degree, tries to provide better description of connected bridge sensors a=
nd
> their related properties as that seemed to be one of Jonathan's suggestio=
ns
> to the RFC version.
> https://lore.kernel.org/linux-iio/20241219140353.787ffccc@jic23-huawei/

I don't always make good suggestions :(  DT maintainers have more experience
in making coherent and predictable bindings than I do.

One of the big problems is that we are fishing in the dark when trying to
make up 'generic' bindings.  Sometimes they just end up not extending well
at all.

>=20
> Even though I'm naturally biased in favor of my own code, I see this is f=
airly
> different from bindings describing the exact same features and that can l=
ead
> to confusion. I'll use the same types for properties that describe the sa=
me
> things/features. Would it also be preferred to drop the defs and just hav=
e=20
> channel nodes?

If we did do channel nodes only. We have various options.
1) constraints against adi,sensor-types (which I think should probably be a=
n enum)
   That should look similar to the node name constraints.
2) constrain only via documentation. (I don't like this at all)
3) have no constraints at all and rely on documenting what makes sense.
   I'm not entirely clear on whether we can ignore the sensor type etc and
   provide properties to control more directly everything to do with it?  S=
o the
   excitation types etc

Jonathan

>=20
> Thanks,
> Marcelo
>=20


