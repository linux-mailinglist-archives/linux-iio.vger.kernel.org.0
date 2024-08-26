Return-Path: <linux-iio+bounces-8793-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E57B895EE9F
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 12:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AF6B2849A9
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 10:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE69914F114;
	Mon, 26 Aug 2024 10:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkiZhvBw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888E81482F5;
	Mon, 26 Aug 2024 10:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724668773; cv=none; b=QGZnm36w9eIpbZEobEB04qFIVQCF1SqZNhs1uZN6Gzq6EbINJzfuZDOU/I8OtamD53a7YZbEFDruWzUEPj5m+MU/SAvAFQpTkj7ann9LNXYJWa7sQAckDUyklwOZGcZ/85psoDP16VB8REu6goCVojijUxK9yNfpttvC4GyD7+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724668773; c=relaxed/simple;
	bh=XRP9ptxcp4RHccwjimQEmcR5oeQA+tiTpwdn1oRh0oA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ofpl419k66Ugfv4ZZMzOcpsRSpUHekka43Ac77B48YiQRdXZRTUTjHrGyaZdB1jAXcXLO4W1jft6GLl9xZ/dpB2mvzj/vWkyOyx8AtUn7TqBTb84IE1B5iP6Aw+aB5E1DFjScpn988v4cqbMzH+jTfynwo1LuxJpEmm9Ipu9rlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkiZhvBw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575F6C51403;
	Mon, 26 Aug 2024 10:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724668773;
	bh=XRP9ptxcp4RHccwjimQEmcR5oeQA+tiTpwdn1oRh0oA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gkiZhvBwQzuDfgvFZXexTOSgVArqmnwlwHN2s6mlH6hnjtxGyvRXDOVsYyzovPw4O
	 G0TDGs7c6DRi3L2i5U3Q47h9PPV7WhbB8wEmy4kTh2MONLSSCJjR7bHG8Icx8pyFqe
	 H4xD2iHNKvkBo0JROQHKBvNaDN9T96d7j8KGHNZCR6yAZQ+AmkrAf3L0Og6uQjfLce
	 VPWKV3lXAZFiVDXl2Trk5PuPoWMogAq4efQ5f2wTEzme3wK2cttEVBw750lKsvraK0
	 dXGsB/3zjAxobFYRkkyqTzWeGAnmPK3TbO1rLinf0fciH5OR7yPAq7gxRRd2mXHMuI
	 Be7XK7D58WHsw==
Date: Mon, 26 Aug 2024 11:39:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Albrieux <jonathan.albrieux@gmail.com>,
 Gwendal Grignou <gwendal@chromium.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux@mainlining.org
Subject: Re: [PATCH v4 1/4] iio: magnetometer: ak8975: Relax failure on
 unknown id
Message-ID: <20240826113920.092d9ec7@jic23-huawei>
In-Reply-To: <Zsje0_gd41N1P0eE@black.fi.intel.com>
References: <20240819-ak09918-v4-0-f0734d14cfb9@mainlining.org>
	<20240819-ak09918-v4-1-f0734d14cfb9@mainlining.org>
	<20240823193203.7772a6b0@jic23-huawei>
	<Zsje0_gd41N1P0eE@black.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 23 Aug 2024 22:11:15 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Aug 23, 2024 at 07:32:03PM +0100, Jonathan Cameron wrote:
> > On Mon, 19 Aug 2024 00:29:39 +0200
> > Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining.org> wrote: =
=20
>=20
> ...
>=20
> > > +	/* Let driver to probe on unknown id for support more register =20
> > Comment style wrong, I'll fix it up.
> >=20
> > With that tweak applied to the togreg branch of iio.git
> >=20
> > Thanks,
> >=20
> > Jonathan
> >=20
> >  =20
> > > +	 * compatible variants.
> > > +	 */ =20
>=20
> There is another one also wrong.
>=20
> +	[AK09918] =3D {
> +		/* ak09918 is register compatible with ak09912 this is for avoid
> +		 * unknown id messages.
> +		 */
>=20
>=20

I think unrelated to this series, but nice to cleanup.
Patches welcome :) Or it I get bored, I might do a scrub of the full subsys=
tem
to get everything in the same style and not provide incorrect choices to
cut and paste.

Jonathan


