Return-Path: <linux-iio+bounces-8648-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D592959641
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 10:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DD62B225FF
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 08:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70811199FBF;
	Wed, 21 Aug 2024 07:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ptK8mW9U"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D5C1B81BF;
	Wed, 21 Aug 2024 07:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724226119; cv=none; b=qA/JYTJGEBrNsbblh8jwG5dKWmM6FhLPmhLCm7SSwD/IVWADbfp8xEgua46c24/mde44C3IvKf7oxioNFT/Diftl4r3TFvytEDPQHyrYTlASHEo4Xty0pzZW8SlrSCUozFpoE3IrkI7m4wZyt6vP5ZiXnmtvy8YvTWTJJNxKl+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724226119; c=relaxed/simple;
	bh=aBgDAZ4ze0w4LhExDuXGPmQBmtP78IvFLVDICKsRhxk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mqPobWF3lY7gmB66airMdGdoGt0WNKrQ1cI7MNrRhnPgwDLhTHyFfh7qNkf7Y9kbD5mrzDTvzk0SpoXXrRmHC1KF+x1gOmDAHospQMNxTqrUcN3qhOPbN7euWeuTWYrhPFBUtEeROXmfHmDI2j8Hi/gX4gGWQ5l8/Tsh9BQQT70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ptK8mW9U; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6544F1BF203;
	Wed, 21 Aug 2024 07:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724226114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cNVE1Euex1vHgd16nkcpKWq4uCJnI5txc/wed22g5ng=;
	b=ptK8mW9UZGOaggQGmNwz0GVW3ar1qMYjrhdzLxxeT0cZmtOUj+Yfann9zwjzSeYDpICP4a
	wkqW6yljlgDLZcm+YmfuYK8oFEa/uWDIdgPkrqJw1CBCbdJN5h/y+FWiy7YM1wBv+6/5kJ
	qPtCIUCjzaZI760eRAQHhH5qJqcR6DHTcWSuMvAvWd3rYETUkR3izusP5EHYmW9HyZkNAM
	MT3AoU9azucVdMJA9a7ZqtFl0WTW2ruP0EiftemmT7B3syAOpDpaCTsDkaWPejC0Y+fVQc
	u35aozbT8wXo8FJqb8E1oPgteuMyxcjIM+TD702CPRB9aivYSHNMPr1MZZO3eQ==
Date: Wed, 21 Aug 2024 09:41:50 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Conor Dooley <conor@kernel.org>
Cc: Thomas Bonnefille <thomas.bonnefille@bootlin.com>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto
 <inochiama@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: adc:
 sophgo,cv18xx-saradc.yaml: Add Sophgo CV18XX SARADC binding
Message-ID: <20240821094150.5787905b@xps-13>
In-Reply-To: <20240820-borough-latch-17d785301aef@spud>
References: <20240812-sg2002-adc-v4-0-599bdb67592f@bootlin.com>
	<20240812-sg2002-adc-v4-1-599bdb67592f@bootlin.com>
	<20240812-unwary-mongrel-9f6758bf624c@spud>
	<89aabfbe-79bf-4da7-be44-b6cbd92b72a9@bootlin.com>
	<20240820-borough-latch-17d785301aef@spud>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

> > > > +      Represents the channels of the ADC.
> > > > +
> > > > +    properties:
> > > > +      reg:
> > > > +        description: |
> > > > +          The channel number. It can have up to 3 channels numbere=
d from 0 to 2.
> > > > +        items:
> > > > +          - minimum: 0
> > > > +            maximum: 2 =20
> > >=20
> > > Is this sufficient to limit the number of channels to 3? Aren't you r=
elying
> > > on the unique unit addresses warning in dtc to limit it, rather than
> > > actually limiting with min/maxItems?
> > >  =20
> > It seems like I can't use min/maxItems on this property. I think that i=
t is
> > using size-cells + address-cells to deduce that the number of items sho=
uld
> > be equal to 1. =20

Looking at dt-schema, I couldn't personally understand from where did
the error messages reported by Thomas came from. There are clear
constraints over minItems/maxItems regarding the use of {#address-cells,
#sizez-cells} being {1, 1}, {2, 2} and {2, 1} (in reg.yaml), but nothing
explicit regarding the other situations, namely {1, 0} in this case
which enforces maxItems to 1 is not clearly stated in any of the core
yaml files. Any idea where to look at? Although, I'm convinced there is
something defined because renaming the property from 'reg' to 'foo'
silences these warnings.

> I think I was mistaken in talking about mix/max items here. I had the
> right idea, but mentioned an incorrect solution - sorry about that. I
> wasn't talking about the number of elements in the reg property, what I
> meant was limiting the number of channel nodes in the first place -
> something which min/maxItems cannot do. As examples of the problem I was
> thinking of, see the below two examples:
>=20
>     adc@30f0000 {
>         compatible =3D "sophgo,cv1800b-saradc";
>         reg =3D <0x030f0000 0x1000>;
>         clocks =3D <&clk CLK_SARADC>;
>         interrupts =3D <100 IRQ_TYPE_LEVEL_HIGH>;
>         #address-cells =3D <1>;
>         #size-cells =3D <0>;
>=20
>         channel@0 {
>             reg =3D <0>;
>         };
>         channel@2 {
>             reg =3D <2>;
>         };
>         channel@22 {
>             reg =3D <2>;
>         };
>     };
>=20
>     adc@30f0000 {
>         compatible =3D "sophgo,cv1800b-saradc";
>         reg =3D <0x030f0000 0x1000>;
>         clocks =3D <&clk CLK_SARADC>;
>         interrupts =3D <100 IRQ_TYPE_LEVEL_HIGH>;
>         #address-cells =3D <1>;
>         #size-cells =3D <0>;
>=20
>         channel@0 {
>             reg =3D <0>;
>         };
>         channel@2 {
>             reg =3D <2>;
>         };
>         channel@22 {
>             reg =3D <2>;
>         };
>     };
>=20
> The solution is simple, remove the + from the regex. Sorry for sending
> you on the wrong track Thomas.

Ah! Thanks Conor for the details, now it makes full sense :-) BTW Thomas
the regex is

	^channel@[0-3]+$

and I guess it should instead be

	^channel@[0-2]$
                    ^

in order to fully match the real indexing constraints you're enforcing
with minimum/maximum.

Thanks,
Miqu=C3=A8l

