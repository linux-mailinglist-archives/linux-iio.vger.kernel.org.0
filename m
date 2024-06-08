Return-Path: <linux-iio+bounces-6058-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21166901234
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 17:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40501F21F6A
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 15:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E3E176FA7;
	Sat,  8 Jun 2024 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUtOClQ6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E5E1E528;
	Sat,  8 Jun 2024 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717859324; cv=none; b=gfNZgsQjmGUWeQg40XfGnCdThV7tc/h0iDdfBJk44EF9Sla9iYLWWGKjtxTniL31SXK4CBsU4y4Ta3dvkafqn3xcxYeMZH8UNkb1NZ+mbaibTOCQxWA4KpYwcJKlKtDFw8wWKQLWEvvGO/RFomzkdxQfIyj0osLZfnqx9Ywdzec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717859324; c=relaxed/simple;
	bh=nHTMnQE4+3vQRN5GII4anVg1/7flaCgbkvpyw0OVhOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KX2xZPuAPfLge9Ny3FgnrMfXRD4FOK7AlA+F95OEIt9y1djMvBo2WtuiyC2pI1mYsu9RMbKEsIKQaYozBfNUouFlr0x42BOrwAvHvWQG7/wBrtELtB7ei72EvfSsHzdD5UuXiy5yV/dEEtkLf7dX4AxhTA4dx7ePv6ZXPOOqQ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUtOClQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328D8C2BD11;
	Sat,  8 Jun 2024 15:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717859324;
	bh=nHTMnQE4+3vQRN5GII4anVg1/7flaCgbkvpyw0OVhOU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aUtOClQ6ZtnewY0lHopTLnOsoLJ3X/AiZtlGksHWvgha8CW5AI8lz3qbM3KmsgvtQ
	 OgfaQaZ3yo8SpCBkKU+H3GQ19ya9wt9hE6kIG0DmgZ5BmgEQqDMv7ZUpaAxLHpqNF5
	 VfI9cU+y6NqYas1uNnQDdLQyII7YjOkukFoSL1GqPZduiBXC3Z37YSH3hXTDu2Ov37
	 v1Co4lK0JNCSrpnHu1EDsrm4JyWoHxJlHczcS6sq+t8Rp9XtI36AXowPZ2U094aH3t
	 qaWXbWkkuaeL2SIMBeEmsHbH/LVIwpRrenBW4q0aXol7rhXidDRH24asJni1+JxTj5
	 mFiWx+CTCeAgA==
Date: Sat, 8 Jun 2024 16:08:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen 
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski  <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: frequency: adf4350: add clk provider
Message-ID: <20240608160838.16a2a04f@jic23-huawei>
In-Reply-To: <751abd157213736e376ca43ef1082362a4ca1149.camel@gmail.com>
References: <20240607095806.3299-1-antoniu.miclaus@analog.com>
	<20240607095806.3299-2-antoniu.miclaus@analog.com>
	<751abd157213736e376ca43ef1082362a4ca1149.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


> > +static int adf4350_clk_register(struct adf4350_state *st)
> > +{
> > +	struct spi_device *spi =3D st->spi;
> > +	struct clk_init_data init;
> > +	struct clk *clk;
> > +	const char *parent_name;
> > +	int ret;
> > +
> > +	if (!device_property_present(&spi->dev, "#clock-cells"))
> > +		return 0;
> > +
> > +	init.name =3D devm_kasprintf(&spi->dev, GFP_KERNEL, "%s-clk",
> > +				=C2=A0=C2=A0 fwnode_get_name(dev_fwnode(&spi->dev)));
> > +	device_property_read_string(&spi->dev, "clock-output-names",
> > +				=C2=A0=C2=A0=C2=A0 &init.name);
> > +
> > +	parent_name =3D of_clk_get_parent_name(spi->dev.of_node, 0);
> > +	if (!parent_name)
> > +		return -EINVAL;
> > +
> > +	init.ops =3D &adf4350_clk_ops;
> > +	init.parent_names =3D &parent_name;
> > +	init.num_parents =3D 1;
> > +
> > +	st->output.hw.init =3D &init;
> > +	clk =3D devm_clk_register(&spi->dev, &st->output.hw);
> > +	if (IS_ERR(clk))
> > +		return PTR_ERR(clk);
> > +
> > +	ret =3D of_clk_add_provider(spi->dev.of_node, of_clk_src_simple_get,
> > clk);
> > +	if (ret)
> > +		return ret;
> > + =20
>=20
> I totally agree this chip should be a clock provider (maybe it should eve=
n in
> drivers/clk from the beginning) but there's one thing that comes to my mi=
nd.
> Should we still expose the IIO userspace interface in case we register it=
 as a
> clock provider?

That's a reasonable suggestion.  If it's wired up as a clock we probably do=
n't
want to provide userspace controls via IIO.

>=20
> Sure, we do have clk notifiers in the kernel but I still think it's a sen=
sible
> question :)
>=20
> I suspect we have another "outliers" in drivers/iio/frequency :)

We all love the blurry boundaries in the kernel. IIRC when these were orgin=
ally
proposed, the IIO thing was mostly about how they were being used in Softwa=
re
Defined Radios where the were part of the modulator circuits.
I can't remember the exact reasoning though.

As to the right answer for these today, I don't have strong feelings on it
and almost all these parts are ADI ones.

Michael, this is one of yours, so what do you think?

On that note, given this is basically registering as a clock.I'd expect
to see some clk related +CC

Jonathan

>=20
> - Nuno S=C3=A1=20
>=20
>=20


