Return-Path: <linux-iio+bounces-9770-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5006985B9A
	for <lists+linux-iio@lfdr.de>; Wed, 25 Sep 2024 14:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E8F4B213C5
	for <lists+linux-iio@lfdr.de>; Wed, 25 Sep 2024 12:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057691BFE0C;
	Wed, 25 Sep 2024 11:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtxufLsy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECA319AD90;
	Wed, 25 Sep 2024 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265072; cv=none; b=PfJgEqpWaqXTo2QZLn/k5Q+Z6WxDKvjpE2tLR09d6/DTeup6oU8MBazDtJFG/N3NLFsPZFDbvVZ1z57D7igcnrmyUjKqU3NazIruVg3Y/zF69PdY1qcSeRY6NH/vAmmb6fW/taQ/yH4CLcykaDQVd5TaO3sOPoPVnOyvvaIBBVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265072; c=relaxed/simple;
	bh=3lzyLjDpqddpSQ9QmXYZUDoBGQRXihgTdUpQnBD5i5Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T+Ay0ZBr+S5EYStd2DeK77TX6Pb2lKEBhEptyC2HDyrC9uESkMsnytm1LHlu1CQfCUKcMZlxgdK7/nHxF3j1Z6LbB/URh3C1UEV/Zz6CChior8DXQwkhESQkjar2OSuZCoeeA0fjOistRBRGUbUTZysBTQGafoFlpJWfD2CdXpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtxufLsy; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8d2b24b7a8so164076266b.1;
        Wed, 25 Sep 2024 04:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727265069; x=1727869869; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3lzyLjDpqddpSQ9QmXYZUDoBGQRXihgTdUpQnBD5i5Q=;
        b=YtxufLsy5pMUs3jtSeCLPSbBBc0//5rVSlXA63DSuUR1Dl/9aSU4QtDBvXYh0xu0RC
         4Q8Az6FqmIOEZSVJM4R8M3IDLJ3jq2cfDuUKBy+ASt+aR2zjU00tdjYAF4ut1NjCQDQt
         7EiZvLAg30WpgHeVumPUGP4i2MJBAHQfP5UV52UDXAe2m1XUq1VxM9DGbS+P92KRfXzE
         O45/ktrHYoR95MXEmK6JZo3z/sK6xsT8Se+9rfYfFn10tr7k5mYE/9fFwjm7HS7f4kC0
         Yz1WTNYKBVVLvGyCHhxfmBlWHqc9ji5fbrk8YFmK774uxzGgYad1elv5aqAIX6qUXBGD
         k8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727265069; x=1727869869;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3lzyLjDpqddpSQ9QmXYZUDoBGQRXihgTdUpQnBD5i5Q=;
        b=HYb4ixAp7l1ty/Ud/8wI89xJHg/EpfXhMKDqaPH3S0mWA/M5lC7W5wkx8IAtf47nVZ
         5lnzg6kfySNbzMZ11x1qiCzlWJixn7jNTMTpGPW8oPgrGQSjdh24TG/yfktoNdbxkv3D
         L02auQ+CccSuflxjL9ZymxEMyf6WJzcGXfl2hbEcpaW+WCVBPiuDgAHCM5Bc6/QZPf4b
         YnvSa+glHDYluskvUtt2qA5SHCgB25pJ8DWb4BX+PyB0hjjpODP+lhxpG4cwrsVN7yR3
         u0puqmsti8oLvSEO73i1nCq+Edby56rkaZ3aPGit2HA/bQ24aANQDiJqE96UoEcMaBY9
         BlWw==
X-Forwarded-Encrypted: i=1; AJvYcCU3XJwxidw78Tvdzn0bs8ln/szG//gmla+dyG6bYTSzFKqtk+b6qIYQ1n8usLJVNjr9xdlL5OjE3ZLX@vger.kernel.org, AJvYcCW4rTu/42xdHQUof6ZR6HRvEEtNUB/YcxsOEJNwpme8gaCbPNgbPpYHSRnXRcBmyl2Jq33CDC1YuXN+@vger.kernel.org, AJvYcCWOW+kNOcS0snspPajNHX11cxndqLay0uEHtGGwmBeM9TuR6iYwRynrBPKtzIICcKiFogYtFvsHm05rvhEv@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp8iODsUUAGcdJ7kWjekTyCLwnkJlsionqbL0EkeHsBtm/4cBj
	N8kl/5t77VeHjSvIN5OkT4mad9wREZlGmQHXVyPl3VR5y7f1Pj5J
X-Google-Smtp-Source: AGHT+IFVX0MFn8puA46IHl5+tTWQlwU6nWnlYfMnf5qZs/NWKCsWc9XIQbnn6CkO1gf9ysGeSckqaQ==
X-Received: by 2002:a17:907:7f86:b0:a8d:43c5:9a16 with SMTP id a640c23a62f3a-a93a16860c6mr216813766b.6.1727265068755;
        Wed, 25 Sep 2024 04:51:08 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930f7860sm204301366b.149.2024.09.25.04.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 04:51:08 -0700 (PDT)
Message-ID: <c721861809c17776c0fe89ead331b6e2e6b9d4b4.camel@gmail.com>
Subject: Re: [PATCH v3 04/10] dt-bindings: iio: dac: ad3552r: add io-backend
 support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Angelo Dureghello
	 <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Jonathan
 Cameron	 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan	 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dlechner@baylibre.com
Date: Wed, 25 Sep 2024 13:55:20 +0200
In-Reply-To: <fa27dc74-7b1f-4ef5-81dc-cc434da4ff89@kernel.org>
References: 
	<20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
	 <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-4-a17b9b3d05d9@baylibre.com>
	 <gojq6ardhvt6vcs2kawdhdn2cj6qbpzp4p5mjjgwsypuatm5eo@3u6k4q7le46s>
	 <418a8a9b-3bcf-4b8f-92a0-619a3bf26ab5@baylibre.com>
	 <e8af0f3f-a09c-42d7-b8ca-dd633539af73@kernel.org>
	 <0279203b6cd9f1312d9c03654c262c04ac12fbd9.camel@gmail.com>
	 <fa27dc74-7b1f-4ef5-81dc-cc434da4ff89@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-09-25 at 09:22 +0200, Krzysztof Kozlowski wrote:
> On 24/09/2024 14:27, Nuno S=C3=A1 wrote:
> > On Tue, 2024-09-24 at 10:02 +0200, Krzysztof Kozlowski wrote:
> > > On 23/09/2024 17:50, Angelo Dureghello wrote:
> > > > Hi Krzysztof,
> > > >=20
> > > > On 22/09/24 23:02, Krzysztof Kozlowski wrote:
> > > > > On Thu, Sep 19, 2024 at 11:20:00AM +0200, Angelo Dureghello wrote=
:
> > > > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > > > >=20
> > > > > > There is a version AXI DAC IP block (for FPGAs) that provides
> > > > > > a physical bus for AD3552R and similar chips, and acts as
> > > > > > an SPI controller.
> > > > > >=20
> > > > > > For this case, the binding is modified to include some
> > > > > > additional properties.
> > > > > >=20
> > > > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > > > > ---
> > > > > > =C2=A0 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml=C2=A0=
=C2=A0 | 42
> > > > > > ++++++++++++++++++++++
> > > > > > =C2=A0 1 file changed, 42 insertions(+)
> > > > > >=20
> > > > > > diff --git
> > > > > > a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> > > > > > b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> > > > > > index 41fe00034742..aca4a41c2633 100644
> > > > > > --- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yam=
l
> > > > > > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yam=
l
> > > > > > @@ -60,6 +60,18 @@ properties:
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/defin=
itions/uint32
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum: [0, 1, 2, 3]
> > > > > > =C2=A0=20
> > > > > > +=C2=A0 io-backends:
> > > > > > +=C2=A0=C2=A0=C2=A0 description: The iio backend reference.
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 An example backend can be found=
 at
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/inde=
x.html
> > > > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > > > +
> > > > > > +=C2=A0 adi,synchronous-mode:
> > > > > > +=C2=A0=C2=A0=C2=A0 description: Enable waiting for external sy=
nchronization
> > > > > > signal.
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Some AXI IP configuration can i=
mplement a dual-IP layout,
> > > > > > with
> > > > > > internal
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wirings for streaming synchroni=
zation.
> > > > > > +=C2=A0=C2=A0=C2=A0 type: boolean
> > > > > > +
> > > > > > =C2=A0=C2=A0=C2=A0 '#address-cells':
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const: 1
> > > > > > =C2=A0=20
> > > > > > @@ -128,6 +140,7 @@ patternProperties:
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 - custom-output-range-config
> > > > > > =C2=A0=20
> > > > > > =C2=A0 allOf:
> > > > > > +=C2=A0 - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > > > > > =C2=A0=C2=A0=C2=A0 - if:
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatib=
le:
> > > > > > @@ -238,4 +251,33 @@ examples:
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 };
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > > > > +
> > > > > > +=C2=A0 - |
> > > > > > +=C2=A0=C2=A0=C2=A0 axi_dac: spi@44a70000 {
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adi=
,axi-ad3552r";
> > > > > That is either redundant or entire example should go to the paren=
t
> > > > > node,
> > > > > if this device is fixed child of complex device (IOW, adi,ad3552r
> > > > > cannot
> > > > > be used outside of adi,axi-ad3552r).
> > > >=20
> > > > ad3552r can still be used by a generic "classic" spi
> > > > controller (SCLK/CS/MISO) but at a slower samplerate, fpga
> > > > controller only (axi-ad3552r) can reach 33MUPS.
> > >=20
> > > OK, then this is just redundant. Drop the node. Parent example should
> > > contain the children, though.
> > > >=20
> > > > >=20
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x44a70000=
 0x1000>;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dmas =3D <&dac_tx_d=
ma 0>;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma-names =3D "tx";
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #io-backend-cells =
=3D <0>;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&ref_cl=
k>;
> > > > > > +
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D =
<1>;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <0>=
;
> > > > > > +
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dac@0 {
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 compatible =3D "adi,ad3552r";
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 reg =3D <0>;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 reset-gpios =3D <&gpio0 92 0>;
> > > > > Use standard defines for GPIO flags.
> > > >=20
> > > > fixed, thanks
> > > >=20
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 io-backends =3D <&axi_dac>;
> > > > > Why do you need to point to the parent? How much coupled are thes=
e
> > > > > devices? Child pointing to parent is not usually expected, becaus=
e
> > > > > that's obvious.
> > > >=20
> > > >=20
> > > > "io-backends" is actually the way to refer to the backend module,
> > > > (used already for i.e. ad9739a),
> > > > it is needed because the backend is not only acting as spi-controll=
er,
> > > > but is also providing some APIs for synchronization and bus setup
> > > > support.
> > >=20
> > >=20
> > > But if backend is the parent, then this is redundant. You can take it
> > > from the child-parent relationship. Is this pointing to other devices
> > > (non-parent) in other ad3552r configurations?
> > >=20
> >=20
> > The backend is a provider-consumer type of API. On the consumer side (w=
hich
> > is the
> > driver the child node will probe on), we need to call devm_iio_backend_=
get()
> > to get
> > the backend object (which obviously is the parent). For that, 'io-backe=
nds'
> > is being
>=20
> You described the driver, so how does it matter? Driver can call
> get_backend_from_parent(), right? Or get_backend_from_fwnode(parent)?

Well yes, just stating what the framework (also in terms of bindings) is
expecting. Of course that on the driver side we can paper around it the way=
 we
want. But my main point was that we can only paper around it if we use code=
 that
is meant not to be used.

And, FWIW, I was (trying) replying to your comment

"You can take it from the child-parent relationship"

Again, we can only do that by introducing new code or use code that's not m=
eant
to be used. The way we're supposed to reference backends is by explicitly u=
sing
the proper FW property.

Put it in another way and a completely hypothetical case. If we have a spi
controller which happens to export some clock and one of it's peripherals e=
nds
up using that clock, wouldn't we still use 'clocks' to reference that clock=
?

Again, if this is too weird to be acceptable in the bindings we take it fro=
m the
child - parent relationship.=20


- Nuno S=C3=A1

