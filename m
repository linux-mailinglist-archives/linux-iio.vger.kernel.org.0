Return-Path: <linux-iio+bounces-15332-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F7DA307E1
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 11:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26DDB166EA5
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 10:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD651F2388;
	Tue, 11 Feb 2025 10:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEWh4g06"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B71A1F2381;
	Tue, 11 Feb 2025 10:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739268114; cv=none; b=NGOFqb5AWeXCKwfhtIxNSxbE/rW87IfHbZeROBZGyKSfqLkqDQABAWzQdA70ux3kQJww9BgWfUIuTYFC2nVQU/f07KlP+yhtk51XGe0qZz7tHyRnNZb+FsHLUa2JMuEdP3piUtKP6n/5wgUHJ+7fmNZgADvcfV8Oe/4r/Ocbi/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739268114; c=relaxed/simple;
	bh=fsztC0WAUDAiVqONGmAmLoFIpLdTBrlp8DGfVjBnzH0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FPjlu80rTjkmELgdG8yndiGYVfPTW5ceLw0AIODCMiF18xGmhl8W0bJgCajxiyOxmB3yFer65rLbpR7ng0nK7kzAReNAsaPEnw0UIJE07KmPr1cynHc82l3h3p8+ThkYBjrtBMq3AXAwmML/IXv6TPRt6lEVXUQOzjTIKXCx5ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEWh4g06; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4395578be70so2397665e9.2;
        Tue, 11 Feb 2025 02:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739268110; x=1739872910; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fsztC0WAUDAiVqONGmAmLoFIpLdTBrlp8DGfVjBnzH0=;
        b=YEWh4g0637mt7Dr0NF4tkanCkrheYIB/dc2hi2LQoVNWPyvtIdGcikOcjI3LkVZB+C
         wo/88DC4XqZ285HBOeSAN8E99xndanaIrY6Z57K8Koj3elbsN21lqHu8At+wj83AINQD
         yzp+dpXuLShbf37vPTxjVUtx4mbB+OrJGi9IF+p1zGX37SkCeEE8AG9vVApBKhwkhDth
         vgtenqfCYsSeAS6G5q2ARlK8FZQ4nnL/o2fbpTkFWrxZl/6u709YGKiZ6T5f1CfIdkFp
         hXJd7i8SxxrNb+6M5fpNNI2JPgFiGPrC05cyYR8QyDy8XeZKAMdyQy4/EOqmiWB6e6Yz
         ipRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739268110; x=1739872910;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fsztC0WAUDAiVqONGmAmLoFIpLdTBrlp8DGfVjBnzH0=;
        b=CJJf/U9jP/GHiWlyX9w7J/hJNnOlKq5XElLGfZPn09ILDTsRJBvXqvGcE4rGA1ofKJ
         UMgt2eDIbuEuoHgNPfE5ervgNsKfJ8rFpUYdkPYL2+5xMEVsjcUDgEa5wYe+oKPciSij
         jfwvqciaYETcs6I50xRpw+MPlU+0h7ecU7OkAFdr4cGEr1OOR71cd2JDWtKasINRcDON
         C2FC9HzgUBPCeMAqpc7lkin/AgU7MswWWDR3SYaEtVz8pym7lo22cFQ+cxq2Pf5PBsju
         fF1Q8OIeSBHcKCvK4ok5YC5PMAL/OpvHvZ7SFYqnyqUUw5BHNDQcUO1fVhTB4MUwGnzH
         MVkg==
X-Forwarded-Encrypted: i=1; AJvYcCVZjvSUUrixVnY/7kn60IcG5LF9qqcK3mfLfdYz8vES3fTDBgMiYXyZF0CVewq4GkX6o3aTcnoL/43j@vger.kernel.org, AJvYcCWZKsJiwXR0CY/uZ911tAndnPVWBMnXb61wfZ75H47ogg1v7kDXJr/06zXcKv13LqTc5KM/1kcqaqCS@vger.kernel.org, AJvYcCWw0YuSgLTk4NxkRf2x90X38CCV6x29qB7hiaLvE6o/usDQpH1zyQDsCAcWZ7Fm7nAeuNw8jny+jJGabx6g@vger.kernel.org, AJvYcCXLGGznfvs178SkKmlNWbtT51Zsc6D6PPZysPA6HAUsfQzzvJNgjCA1Vs5LhD6nIK8D3e6R6y+uE9Gx@vger.kernel.org
X-Gm-Message-State: AOJu0YwtcxOfEeu67aMdpyLr8m7Jf+YsWyibQNz3638kFPVuK66UYwVG
	GTA31lYksSM4Bi35QE/EeAIDIeEEofs4LIrVrRq19/EAIeTg+4mn
X-Gm-Gg: ASbGncvpupe9yBojJEr4OI2W7LK1PQxBeABjXNZjY4hqw7k4r6mKaLTQ9vxJ7EpDO5Q
	tbIBl3Crdma6EUwOVXNRRqoP5k8o7VnXbYzaiVyy+ghvhjUIm+ix5ZrS7HIT2i/PnIFO6CN1/z1
	KawC3ZhJbfHKnggXKEOl3772fg3+Q/j1igSgvqmqWKS9mi3wSAFlSNrTZaAy3PvVLv0SgS1Gos+
	9fd1++fR9DNC0YKacwpsUpKiO7GEb5C2Zu7XTIUYW5GkjkqLyziMCcLJJrZ5TlwdAAytJolH9Ns
	wQ/Depo/6rR5xQhGNFra1AW5BenbKdpf4xrHFFv6mP3jLOl2NkYnD2heqpBc0U4=
X-Google-Smtp-Source: AGHT+IHqh7iCiN9GsXADLTwNvK95VZKU0mIGqmengeJ2nj9y7k2avZvpfXaMmy4iVM0ur9UviO0xgQ==
X-Received: by 2002:a05:600c:1d02:b0:434:a815:2b57 with SMTP id 5b1f17b1804b1-439249a8276mr128530795e9.20.1739268110088;
        Tue, 11 Feb 2025 02:01:50 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394127afcbsm68845475e9.23.2025.02.11.02.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 02:01:49 -0800 (PST)
Message-ID: <ed008eeec841448fb597b144a8f706a3ae1a513e.camel@gmail.com>
Subject: Re: [PATCH v6 4/6] dt-bindings: iio: Add adis16550 bindings
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor@kernel.org>
Cc: Robert Budai <robert.budai@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, Rob Herring	
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Nuno Sa <nuno.sa@analog.com>, Ramona
 Gradinariu <ramona.gradinariu@analog.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Marcelo Schmitt	 <marcelo.schmitt@analog.com>,
 Paul Cercueil <paul@crapouillou.net>, David Lechner
 <dlechner@baylibre.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Date: Tue, 11 Feb 2025 10:01:51 +0000
In-Reply-To: <20250208153843.0353baa9@jic23-huawei>
References: <20250204143612.85939-1-robert.budai@analog.com>
		<20250204143612.85939-5-robert.budai@analog.com>
		<20250204-helium-marbled-a0863a0a18a8@spud>
		<15065d0cd19f39d92ce860cd03802c368df74b34.camel@gmail.com>
		<20250205-styling-chirpy-79eae9437b3b@spud>
	 <20250208153843.0353baa9@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-02-08 at 15:38 +0000, Jonathan Cameron wrote:
> On Wed, 5 Feb 2025 19:52:37 +0000
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Wed, Feb 05, 2025 at 04:11:51PM +0000, Nuno S=C3=A1 wrote:
> > > On Tue, 2025-02-04 at 19:25 +0000, Conor Dooley wrote:=C2=A0=20
> > > > On Tue, Feb 04, 2025 at 04:36:08PM +0200, Robert Budai wrote:=C2=A0=
=20
> > > > > Document the ADIS16550 device devicetree bindings.
> > > > >=20
> > > > > Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > > > Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> > > > > Signed-off-by: Robert Budai <robert.budai@analog.com>
> > > > > ---
> > > > >=20
> > > > > v6:
> > > > > - applied blank line suggestions
> > > > > - added clock-frequency dependency change suggestions
> > > > > - yamllint corrections
> > > > >=20
> > > > > =C2=A0.../bindings/iio/imu/adi,adis16550.yaml=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 83
> > > > > +++++++++++++++++++
> > > > > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 9 ++
> > > > > =C2=A02 files changed, 92 insertions(+)
> > > > > =C2=A0create mode 100644
> > > > > Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> > > > >=20
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> > > > > b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..8750bb937979
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yam=
l
> > > > > @@ -0,0 +1,83 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/iio/imu/adi,adis16550.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: Analog Devices ADIS16550 and similar IMUs
> > > > > +
> > > > > +maintainers:
> > > > > +=C2=A0 - Nuno Sa <nuno.sa@analog.com>
> > > > > +=C2=A0 - Ramona Gradinariu <ramona.gradinariu@analog.com>
> > > > > +=C2=A0 - Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > > > +
> > > > > +properties:
> > > > > +=C2=A0 compatible:
> > > > > +=C2=A0=C2=A0=C2=A0 enum:
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,adis16550
> > > > > +
> > > > > +=C2=A0 reg:
> > > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > > +
> > > > > +=C2=A0 spi-cpha: true
> > > > > +=C2=A0 spi-cpol: true
> > > > > +
> > > > > +=C2=A0 spi-max-frequency:
> > > > > +=C2=A0=C2=A0=C2=A0 maximum: 15000000
> > > > > +
> > > > > +=C2=A0 vdd-supply: true
> > > > > +
> > > > > +=C2=A0 interrupts:
> > > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > > +
> > > > > +=C2=A0 reset-gpios:
> > > > > +=C2=A0=C2=A0=C2=A0 description:
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Must be the device tree identifie=
r of the RESET pin. If
> > > > > specified,
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 it will be asserted during driver=
 probe. As the line is active
> > > > > low,
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 it should be marked GPIO_ACTIVE_L=
OW.
> > > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > > +
> > > > > +=C2=A0 clocks:
> > > > > +=C2=A0=C2=A0=C2=A0 description: If not provided, then the intern=
al clock is used.
> > > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > > +
> > > > > +=C2=A0 clock-frequency:
> > > > > +=C2=A0=C2=A0=C2=A0 description: Clock frequency in Hz when an ex=
ternal clock is
> > > > > used.
> > > > > +=C2=A0=C2=A0=C2=A0 oneOf:
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - minimum: 1
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maximum: 128
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - minimum: 3000
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maximum: 4500=C2=A0=
=20
> > > >=20
> > > > I don't get why this is a property, to be honest. When you've got a=
n
> > > > external clock, why isn't the frequency obtained from the clock pro=
vider
> > > > node?
> > > > =C2=A0=20
> > >=20
> > > The main purpose of this property is actually to show/document the
> > > constrains of
> > > the external clock. We can very well just error out in the driver (an=
d we
> > > do
> > > that) and not have this property. I mentioned this property to Robert=
 some
> > > revisions ago and I also pointed out that I wasn't really sure if it
> > > should be
> > > used or not=C2=A0(I guess this is more for fixed clock providers...).=
 IIRC, I
> > > did
> > > asked for some advice/comments but we got none so I assume Robert jus=
t
> > > decided
> > > to use it and see what you guys had to say about it.=C2=A0=20
> >=20
> > NGL, this is one of the kinda of things where if you're relying on
> > dt-bindings to avoid cocking up your board design, things have already
> > gotten pretty badly wrong! That said, "clock-frequency" is a
> > property for cpus, fixed-frequency clock providers and i2c buses, you'd
> > need a vendor prefix and a unit suffix here IMO. Also, I don't really
> > think that it actually does anything at all, given it does not constrai=
n the
> > clock you're linking to with the clocks property. This may as well just=
 be
> > a comment in the description of the clocks property, for all that it do=
es.
>=20
> I'd just drop it.=20
>=20

Agreed...

- Nuno S=C3=A1


