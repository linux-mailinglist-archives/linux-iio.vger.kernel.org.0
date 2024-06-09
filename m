Return-Path: <linux-iio+bounces-6090-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DC4901545
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 11:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1B51F21215
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 09:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B572F1CD2A;
	Sun,  9 Jun 2024 09:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tt+XLVqJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698CA18EB0;
	Sun,  9 Jun 2024 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717924313; cv=none; b=CfNAGLr4save370DSoAgWOknjTSUnE2pNWPMlaBecENfGX3VkmkRs94ZkFpwtm4f7IaGqmCQdNzzosC2fmqKkRhgFEpHIddNJHqIhe6Ex527LJ6DMYYJ6iDmtJuraH6dZzsW4EMdvlq4DeEEyco9Nja5KankpQp06+BdYuj9xsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717924313; c=relaxed/simple;
	bh=kgjku6FATuzmd3oTbhIWmgpMoIOW7gl+iFeGQByFuzU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VKRa6+uqjisUALCqVoOEiZ8tEeHNR4I1Ku4+//VyUVbyPjHPkezBsAR+Vw3IqeWiij1DGTFcKoNqckulUlzcBDBUcAWjX/NVtKde66hGy5ObMNaocaBdWyWyKfXzWplOeGnGQKEw/Pp6MuFNm9Ujq0/rPVVM4c/HybxjnM92jfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tt+XLVqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C81FC2BD10;
	Sun,  9 Jun 2024 09:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717924312;
	bh=kgjku6FATuzmd3oTbhIWmgpMoIOW7gl+iFeGQByFuzU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tt+XLVqJiFVsfk9un8EZJaCsZWR9sMh8ermfFn7LCgW8utyGlk16NkSB90Z2CEl3s
	 bprIZVenZs1hc61Tx2EqIMfe33emJ2X61HRX+CEAGeRREnDUoMEpnR5HMSdzGEU68p
	 Mu30yVoOmJAcKq9UrFNY3y4AcOO03lRoEbx8CERCItK/zFNp9RwMMM4R5BDUAkdovs
	 0dswEiHb+vofy/lw0maz2e9+R4oD8t8lv8WdnAVEnwOVx6fG82ESh84LTqZI8rTmNO
	 pce4JPEcqZjyX3/3xKZL4h6wH0cCEIK/zFLSNdXQ068czwu+0VkqfbIC4vr7rYuQrh
	 Tb3oc9cOtnBZw==
Date: Sun, 9 Jun 2024 10:11:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 broonie@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nuno.sa@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] spi: spi-axi-spi-engine: Add support for MOSI
 idle configuration
Message-ID: <20240609101128.4a003446@jic23-huawei>
In-Reply-To: <ZmMb10S0ewIwouXJ@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1717539384.git.marcelo.schmitt@analog.com>
	<a6b00e84325bbe44919cc49509e837f2555367d0.1717539384.git.marcelo.schmitt@analog.com>
	<ed4fe3de-726b-4eba-a12a-d2f7b1da26d1@baylibre.com>
	<0e18b3aa83a62103b0f06ee516193c03f80abae9.camel@gmail.com>
	<f8ce5dc8-ed68-4f04-af3a-187bf0e4a3b3@baylibre.com>
	<ZmIqxS-xUVMNH_lJ@debian-BULLSEYE-live-builder-AMD64>
	<04b1296ff98a0accbf962a4a4bafc2e85a9869ae.camel@gmail.com>
	<ZmMb10S0ewIwouXJ@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 7 Jun 2024 11:40:23 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 06/07, Nuno S=C3=A1 wrote:
> > On Thu, 2024-06-06 at 18:31 -0300, Marcelo Schmitt wrote:
> >=20
> > ...
> >  =20
> > >=20
> > >=20
> > >=20
> > > When is a driver version check needed?
> > > Yes, older versions of SPI-Engine won't support this, but the patch s=
et should
> > > cause no regression. Even if loading the current ad4000 driver with
> > > older SPI-Engine HDL and driver, the ADC driver would get a warn (or =
error?)
> > > and do what's possible without MOSI idle feature (probably only be ab=
le to do
> > > reg access) or fail probing.
> > >  =20
> >=20
> > Maybe I'm missing something but with the patchset we unconditionally set
> > SPI_MOSI_IDLE_HIGH. So if we load an hdl which does not support it thin=
gs will
> > apparently be ok but it won't actually work, right? If I'm right we sho=
uld have =20
> Yes, that's correct.
>=20
> > a bit in a RO config_register telling us that the feature is being supp=
orted or
> > not. That way we only set the mode bit if we do support it... =20
>=20
> Ok, understood. Will do it for v4.
If you don't have such a mode bit, you will need to add a property to the
dt-binding. Or a suitable compatible.

Nasty, so fingers crossed you do have a capability flag to check!

Jonathan

>=20
> Thanks,
> Marcelo
>=20
> >=20
> > - Nuno S=C3=A1
> >=20
> >  =20


