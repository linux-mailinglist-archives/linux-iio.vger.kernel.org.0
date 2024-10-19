Return-Path: <linux-iio+bounces-10798-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC1D9A4EF7
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 17:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266361F2716C
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 15:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A991D7DA62;
	Sat, 19 Oct 2024 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/T5qP4t"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F3426AFB;
	Sat, 19 Oct 2024 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729350533; cv=none; b=MsyXksmmSOlqxDUDW+/CT/PbaiGp2MwMeodXIyR63+o1R6i/CfzV+KH2vz7x64QXtZLaNKAA5PJ748YViqB4Rl77f/q6N/ENNunRimZtu86cvim4vDHLB1Yj9lZLeki5LQCfvBWh6B4qnK6aIjjZJde/QUrKmA6FCwYGWPt3QnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729350533; c=relaxed/simple;
	bh=1zoGatUV0szsy3n6OGzZTifLwUWLh1RgjlzgjoOPEO4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HGhuOLJB/9cuRwYmnqJkQKKfbfYBouRQ95hLjt+ppooo9FrRNqwWWcPA9mN8XX+8aXxpHv4Xn6urlLuEN7U8Eg7ujlK7PiUpb0que8Ed9bXWHeh9sHJ1gNJXksvHhxc6sC5bvBHx8SGWR580/ZIt6Rabd06brTK5mN1GAMmW6PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/T5qP4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D469CC4CEC5;
	Sat, 19 Oct 2024 15:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729350532;
	bh=1zoGatUV0szsy3n6OGzZTifLwUWLh1RgjlzgjoOPEO4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y/T5qP4tl6Tr7F58l5hYXNhQzXgpsDP0+qrJK2XZXwzEM3oz5FQPMvcMxRH9WPnEf
	 PLVuLn2Mh2amipsvuuyGZZ4xZgYar1sSKczcW3tR2zTYN8myAgv8lg8i3FPdJBpLBd
	 j0l6AX3PtDYumKoMN4A+9eg7X1JLYNTthmWo0ZGQHWo5TdcaFsVBwuvj7FMxo+W3bM
	 ahAq6oyTswV7aaeYP2nnVsYkW11E8Pn3NKBflRTV7hc9AfuBtsKJl6PTZVpyCyyVf2
	 n+4c3sLCkO7uCqAnqeuoMYDuOiM9O2p61i9OBNJRoppybV4L10fTORozEVX2sj4nnM
	 8uGnrvMYZ3sCw==
Date: Sat, 19 Oct 2024 16:08:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>, David Lechner 
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Lars-Peter Clausen  <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski  <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan  <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown 
 <broonie@kernel.org>
Subject: Re: [PATCH v6 4/8] iio: dac: adi-axi-dac: extend features
Message-ID: <20241019160817.10c3a2bf@jic23-huawei>
In-Reply-To: <ca3bb7c87a15ebb8e1284aa2da312cd00de49159.camel@gmail.com>
References: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
	<20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-4-eeef0c1e0e56@baylibre.com>
	<ab559026-7e95-4adc-9978-6db30982b2a6@baylibre.com>
	<bw2ldm54tg6klzfod5t5y6eb34dr4mcttojz4uulxqm5stk2hw@rmgpibnx6xsd>
	<ca3bb7c87a15ebb8e1284aa2da312cd00de49159.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


> > > > =C2=A0static int axi_dac_probe(struct platform_device *pdev)
> > > > =C2=A0{
> > > > -	const unsigned int *expected_ver;
> > > > =C2=A0	struct axi_dac_state *st;
> > > > =C2=A0	void __iomem *base;
> > > > =C2=A0	unsigned int ver;
> > > > @@ -566,15 +793,26 @@ static int axi_dac_probe(struct platform_devi=
ce *pdev)
> > > > =C2=A0	if (!st)
> > > > =C2=A0		return -ENOMEM;
> > > > =C2=A0
> > > > -	expected_ver =3D device_get_match_data(&pdev->dev);
> > > > -	if (!expected_ver)
> > > > +	st->info =3D device_get_match_data(&pdev->dev);
> > > > +	if (!st->info)
> > > > =C2=A0		return -ENODEV;
> > > > =C2=A0
> > > > -	clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> > > > +	clk =3D devm_clk_get_enabled(&pdev->dev, "s_axi_aclk"); =20
> > >=20
> > > This will break existing users that don't have clock-names
> > > in the DT. It should be fine to leave it as NULL in which
> > > case it will get the clock at index 0 in the clocks array
> > > even if there is more than one clock.
> > >  =20
> >=20
> > mm, are there existing users except this hs driver right now ?
> >=20
> > Clock names are actually described in the example, and if missing,
> > also retrieving "dac_clk" would fail.
> >  =20
>=20
> There's already a frontend DAC using the generic DAC implementation. So, =
in theory,
> yes... We can already have users not setting clock-names in DT that would=
 now fail to
> probe with this patch. David is only suggesting leaving this call to NULL=
. For
> dac_clk we do need the *id in devm_clk_get_enabled().
>=20
> Maybe it would also be worth mentioning in the bindings that s_axi_aclk n=
eeds to be
> the first entry in clocks and clock-names for backward compatibility.

Usual trick for this is match on clk name first and then fallback to no name
to pick up old DT that didn't set clk names.

That way should be no need constrain the order when it is specified.
Slight hicup is new DT, old kernel. In which case maybe the wrong clock is =
started
but I think you only have the multiple clocks for new cases so this should =
be fine.

Just sprinkle some comments alongside the fallback code to say why it is th=
ere.


Jonathan

>=20
> - Nuno S=C3=A1
> > >  =20
>=20


