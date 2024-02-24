Return-Path: <linux-iio+bounces-2985-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 572D186248D
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 12:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10E2B283875
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 11:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C34286B3;
	Sat, 24 Feb 2024 11:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="le6qnzXk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64AD1AAD0;
	Sat, 24 Feb 2024 11:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708774648; cv=none; b=YsiehTCLL89AqOS7B3ZipyM49ylkl01w3ChAS0aDTHyuld8mTCPJ+VN4ykEZFG+dZEtw8Yo2lxcHiNd2BZfu2Shqz6QBu7PdDPMf6G4jskmkIPTHy2Wp9MvTUqLFQ1AC8v8KDeygkyQR2RCJ6z5OZLOMWtD/Dnl8O2DZSIxX+xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708774648; c=relaxed/simple;
	bh=0RSh39baeivDOjluBr/l5qE556pSIdvYkxZPHoKTN/8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S1Cvl8gf5liml2HvnkBollR1yk+A1mB3VwgElxx+3B3btwvMj4fcru1gJk4RvXLXj1ohZcr0i//WT8PkADSAbGPNrUC+xv8aYGMe2rsvVwbrhX/zBp6UDsCqLSKqYIW3Dida8rV7PkYjEhf4ITv10Kpdno9w9BJMsJWAQKtT8DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=le6qnzXk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82D5C433C7;
	Sat, 24 Feb 2024 11:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708774648;
	bh=0RSh39baeivDOjluBr/l5qE556pSIdvYkxZPHoKTN/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=le6qnzXkUNIADhfMVJkjA4BYf4hfdH4f6g59CiLcyE8uJ34dMPWzSBz8ZEhw6fzmQ
	 /4lWmWdHNmxQAWnG1rFWl/nBN5O4dZ2wURSTlrGwJXtdqU+rqvGHt8k87/qCqlDqc5
	 raslBFNZoAySUQxzf8p1XNfrSf2AVZD8NkKs99yZBtuiNaa4lkaEbMBxNGZMYwCLko
	 4H7oaV7jecChQVNIMbdJV9yHoUGkC+8AF6o/nxMRZFgWEZONwISAEp51zvTvukvgu0
	 opKw85cueJoTX99NlIhUvp6EplUCB9AetWjHKY5df1g3c2f8Jhdd8qKgpvsCYZLtax
	 thdbdNfLA5z2g==
Date: Sat, 24 Feb 2024 11:37:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: linux-iio@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Daniel Scally <djrscally@gmail.com>, Heikki
 Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Julia Lawall <Julia.Lawall@inria.fr>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Mihail Chindris <mihail.chindris@analog.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Tomislav Denis
 <tomislav.denis@avl.com>, Marek Vasut <marex@denx.de>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Marijn Suijten
 <marijn.suijten@somainline.org>, Marius Cristea
 <marius.cristea@microchip.com>, Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
 Peter Zijlstra <peterz@infradead.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 03/15] iio: temp: ltc2983: Use __free(fwnode_handle)
 to replace fwnode_handle_put() calls
Message-ID: <20240224113713.2f2aa84d@jic23-huawei>
In-Reply-To: <611bf0695d497219d85390d200417596086435ed.camel@gmail.com>
References: <20240217164249.921878-1-jic23@kernel.org>
	<20240217164249.921878-4-jic23@kernel.org>
	<611bf0695d497219d85390d200417596086435ed.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Feb 2024 14:52:51 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sat, 2024-02-17 at 16:42 +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > This use of the new cleanup.h scope based freeing infrastructure allows
> > us to exit directly from error conditions and in the good path with
> > the reference obtained from fwnode_find_reference() (which may be an er=
ror
> > pointer) automatically released.
> >=20
> > Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>
> > Cc: Nuno S=C3=A1 <nuno.sa@analog.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > v2: Move the declarations down to where they are assigned.
> > This both clearly associates the cleanup with the action that it
> > is cleaning up and avoid potential future missordering of cleanup.
> > --- =20
>=20
> This LGTM. Only comment is that in ltc2983_parse_dt() we do have a loop w=
here we
> could make use of device_for_each_child_node_scoped(). It seems to me that
> change could be included in this patch.
>=20
> - Nuno S=C3=A1
>=20
>=20

True. Not sure how I missed that.  I'll do that for v5 posting of remaining=
 drivers.

