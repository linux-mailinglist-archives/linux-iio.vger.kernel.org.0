Return-Path: <linux-iio+bounces-10639-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3368899F020
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 16:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D0F28198B
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 14:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2131C4A2B;
	Tue, 15 Oct 2024 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIobMkJd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B395A1FC7EC;
	Tue, 15 Oct 2024 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003869; cv=none; b=hFt+KkUFupYWDD+qJLrz2jb6osYUXDgz1njlsTZadZXzlc6StWRmyvozrJC40wrSkM2xZVjStBezfWAKhVEGSoYnunYVv1juXxrQipvgnyqB7wqrKNm4o2YEWkfqnvz2qJ3T1d0Xy7WBY+O3l1HRl7Qq1sVZaqmMuRo7QjsNvUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003869; c=relaxed/simple;
	bh=hgD1NQuV6c1EquNomdM4Uaq7heJhYt8dxANTZPH3SDU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l3VHMbHGCgAfcss9LpWCW7oV9GCP7gCkToiDSU+kbaZKdOS7g6GaMAJkea76hoeolL18ViI40VlESHlkMm82zx1gd9svd3jzEEnXIH4BgasOO03FsDmCXTR7vFQvgyClb0YyNKlkMMXgb99zg5qEQJryiXTdytw+YgizPY5HDPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIobMkJd; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so3017801e87.1;
        Tue, 15 Oct 2024 07:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729003866; x=1729608666; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hgD1NQuV6c1EquNomdM4Uaq7heJhYt8dxANTZPH3SDU=;
        b=OIobMkJd2f66YyDGfaNcXMImvPHY+qguuvLu8PqZkK1rZGURc9a+T4bqTZRrxwYXeU
         dQhlBr42osu1sOdlm4MoFuGeYt8UGN3zarK7UlP/aczs0eYt82RwkJvuWl/eQnudjEgR
         6WLZZjjoIZ3488GA+cSxwJtyaUXnzSDg8ATSVCieVeXLAIpS7kfKzWZ1szTvPitkkdIF
         wpfAcYSL9FCBq2zLlWJ1hz+H+PlanmJZN80iK/T+LTYVwVDlgZZHEKQmqgHnXWxgCLhn
         qgh+R8/t9azvSrVU86uF1MvFBze8NkkCyPWVb9HY3qrWY7H3MdBYlOIeBtSdhO6Cs/eb
         BjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729003866; x=1729608666;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hgD1NQuV6c1EquNomdM4Uaq7heJhYt8dxANTZPH3SDU=;
        b=cNphpssF/miGgdu51PJV8kz6QkyNM1oodRJ8+6nWiUGJ8unWUHV6CykSvATZ2KK5R6
         EgKWp43raQ058PpvqOc3oNP6puzCQ5L4RleecCQhznXVyVXcXCgNoEfuUVnIMHdggXli
         Sb3WNhJnsQfvwogc971Bj4ouElo90TaEnyRA2lnbC14TbxK4v8amHhu68vGUYeouYrAK
         6dqgUidbuxJeBuEq4N7aVj2aRKz1PzL/z9a++GUwNoXzcaA8ZF3vuWLdJc/M/iisLGMC
         Awtf/cFEbhopsrj4MWWUO+WyLD+fgzZaS248jU/no4bVZWF9BSYPggjEpmJptpGO9Kth
         MPSw==
X-Forwarded-Encrypted: i=1; AJvYcCUN5KfkNi5VBUXIPQ+Juvcmt+DkRY0JjzpQF6OlZt3/SXlf2PawG+uSn+EIKwZPKdEaoniUFRFiOMH7y6mp@vger.kernel.org, AJvYcCWwF4Rb1TapEPHTV1WMjTKgCL6CtHitR2tQTaZOWIlGk0mSHOY2o3Y99ZyNYQP+i5/qDWbUKvqloVTP@vger.kernel.org, AJvYcCX2HtU/6NNXQAwUOqVtorZIYo3tfeZfx9gphEjJVnsfBLTKdRv1vy4RSFhDP4r2gs++FHJHbSz2wtlR@vger.kernel.org
X-Gm-Message-State: AOJu0YyP5aZ5VYeV9cqWbdzdqb5407nhz+YjGFqDlvXpWpRTf7p+VbMn
	JBGCNimzEedkVFq83HB3UhqNkMl51wc90Exx0RX/41nGZEfQzKjWl/sKdtr0
X-Google-Smtp-Source: AGHT+IEeHBH0J94yh7upWaIEeIPoADr7/e9oYZKG3/6jmeYTf6MFZcnC+Aoecy3dD0DxnNb597+A+A==
X-Received: by 2002:a05:6512:1595:b0:530:c239:6fad with SMTP id 2adb3069b0e04-53a03e9e097mr468107e87.0.1729003865596;
        Tue, 15 Oct 2024 07:51:05 -0700 (PDT)
Received: from ?IPv6:2001:a61:34c9:ea01:14b4:7ed9:5135:9381? ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f56eb0bsm19864735e9.22.2024.10.15.07.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 07:51:05 -0700 (PDT)
Message-ID: <35d247418b8bd43695644f395901b117a1014109.camel@gmail.com>
Subject: Re: [PATCH v6 2/8] dt-bindings: iio: dac: adi-axi-dac: add ad3552r
 axi variant
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Angelo Dureghello
	 <adureghello@baylibre.com>
Cc: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron
	 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
	 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown
	 <broonie@kernel.org>
Date: Tue, 15 Oct 2024 16:51:04 +0200
In-Reply-To: <776ed45e-7ca8-42e8-9050-86928f223965@baylibre.com>
References: 
	<20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
	 <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-2-eeef0c1e0e56@baylibre.com>
	 <a27eb208-0fa1-45cc-bb0c-18a03b6cce4e@baylibre.com>
	 <imlhddzkf5eefr64n73pgtbvyax54746v6wzlwngryzzwrbw4h@uaaom7tbod5m>
	 <776ed45e-7ca8-42e8-9050-86928f223965@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-15 at 09:40 -0500, David Lechner wrote:
> On 10/15/24 2:44 AM, Angelo Dureghello wrote:
> > On 14.10.2024 16:13, David Lechner wrote:
> > > On 10/14/24 5:08 AM, Angelo Dureghello wrote:
> > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > >=20
> > > > Add a new compatible and related bindigns for the fpga-based
> > > > "ad3552r" AXI IP core, a variant of the generic AXI DAC IP.
> > > >=20
> > > > The AXI "ad3552r" IP is a very similar HDL (fpga) variant of the
> > > > generic AXI "DAC" IP, intended to control ad3552r and similar chips=
,
> > > > mainly to reach high speed transfer rates using a QSPI DDR
> > > > (dobule-data-rate) interface.
> > > >=20
> > > > The ad3552r device is defined as a child of the AXI DAC, that in
> > > > this case is acting as an SPI controller.
> > > >=20
> > > > Note, #io-backend is present because it is possible (in theory anyw=
ay)
> > > > to use a separate controller for the control path than that used
> > > > for the datapath.
> > > >=20
> > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > > ---
> > > > =C2=A0.../devicetree/bindings/iio/dac/adi,axi-dac.yaml=C2=A0=C2=A0 =
| 56
> > > > ++++++++++++++++++++--
> > > > =C2=A01 file changed, 53 insertions(+), 3 deletions(-)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.=
yaml
> > > > b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > > > index a55e9bfc66d7..2b7e16717219 100644
> > > > --- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > > > @@ -19,11 +19,13 @@ description: |
> > > > =C2=A0=C2=A0 memory via DMA into the DAC.
> > > > =C2=A0
> > > > =C2=A0=C2=A0 https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
> > > > +=C2=A0 https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/=
index.html
> > > > =C2=A0
> > > > =C2=A0properties:
> > > > =C2=A0=C2=A0 compatible:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 enum:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,axi-dac-9.1.b
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,axi-ad3552r
> > > > =C2=A0
> > > > =C2=A0=C2=A0 reg:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > @@ -36,7 +38,14 @@ properties:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: tx
> > > > =C2=A0
> > > > =C2=A0=C2=A0 clocks:
> > > > -=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > +=C2=A0=C2=A0=C2=A0 minItems: 1
> > > > +=C2=A0=C2=A0=C2=A0 maxItems: 2
> > > > +
> > > > +=C2=A0 clock-names:
> > > > +=C2=A0=C2=A0=C2=A0 minItems: 1
> > > > +=C2=A0=C2=A0=C2=A0 items:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: s_axi_aclk
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: dac_clk
> > > > =C2=A0
> > > > =C2=A0=C2=A0 '#io-backend-cells':
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 const: 0
> > > > @@ -47,7 +56,16 @@ required:
> > > > =C2=A0=C2=A0 - reg
> > > > =C2=A0=C2=A0 - clocks
> > > > =C2=A0
> > > > -additionalProperties: false
> > > > +allOf:
> > > > +=C2=A0 - if:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 contains:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 const: adi,axi-ad3552r
> > > > +=C2=A0=C2=A0=C2=A0 then:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ref: /schemas/spi/spi-controller.y=
aml#
> > > =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > > =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks:
> > > =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minIte=
ms: 2
> > > =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-names:
> > > =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minIte=
ms: 2
> > > =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 required:
> > > =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-names
> > > =C2=A0 +=C2=A0=C2=A0=C2=A0 else:
> > > =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > > =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks:
> > > =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxIte=
ms: 1
> > > =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-names:
> > > =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxIte=
ms: 1
> > >=20
> > > We could make the checking of clocks more strict to show
> > > the intent:
> > >=20
> > > adi,axi-dac-9.1.b only has 1 clock and clock-names is optional.
> > >=20
> > > adi,axi-ad3552r always has 2 clocks and clock-names is required.
> > >=20
> > is this really necessary ? At v.6 would not fix things
> > not reallyh necessary.
> > =C2=A0
> It is just a suggestion from me. I will leave it to the maintainers
> to say if it is necessary or not. (If they don't say anything, then
> we'll take it to mean it isn't necessary.)
>=20

Not a DT maintainer but IMHO, having these kind of checks in the bindings i=
s very
useful.

- Nuno S=C3=A1

