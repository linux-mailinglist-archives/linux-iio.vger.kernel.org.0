Return-Path: <linux-iio+bounces-24708-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AA6BB8DEB
	for <lists+linux-iio@lfdr.de>; Sat, 04 Oct 2025 15:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B407C189F5A4
	for <lists+linux-iio@lfdr.de>; Sat,  4 Oct 2025 13:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C5E274646;
	Sat,  4 Oct 2025 13:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isrBaMWf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10A729405;
	Sat,  4 Oct 2025 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759584327; cv=none; b=PNasrZSYvGP+N7oD8JBrr8wmZ+JnxI7XpJKkpAh8SXHtXgMWHteP5NsVcb/mjthQpTZCwcGadvj8+IVDoSWg72LZALQwfhWsMoa3d78dn10tbPEl2BVduqVDEBdmFEl/VUUnHqnkWjbG0r6tHrEHxRZFiFcHAtzsKPpxu6JFza0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759584327; c=relaxed/simple;
	bh=bc5bP7EqrX/7tverHK4ahEMxMXdfuaRoCJxs+IXR4UI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQ/y9gBmfuoslU5yOFcZUfjKwMxRce8d+Y33vMNUztqhI6WCVRJwBaOVsAAGUO6Mv7FQ2qJ9M2ZtFppIaHG/r6kAKDNWijU+RyZeBJBRf2JRlDCSpq3hrek8hWjSK1bxR0GjHCwOv/oa5Wq3limq39bh6T/bvQVziWgDrXl59lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isrBaMWf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C60C4CEF1;
	Sat,  4 Oct 2025 13:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759584326;
	bh=bc5bP7EqrX/7tverHK4ahEMxMXdfuaRoCJxs+IXR4UI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=isrBaMWfApwQ1NDz1qxYerr3ggmdcFTR9LgDdgHJYQ39uEppFCwRZbzDkDTYqIZO8
	 BtOqmkcx73Hww6vj5nUDaAK5msqyyJqgg9lGfSngFsus5mReiwGCb4TIzeDMlSKyxM
	 S39iQ9sSMoUSCQYj82BBrXcE/ZfosunC3Xuk2z9JEDJ+Zc5x3pQRwTCAMD/kRn6OUt
	 tYN6hcLHKcPxTOrcjOTjWdzGTocQp/+z5/AlZlMcWZZcV9n08/CT2hsiF5iOM2/QfM
	 mCEyOYo8cWREIDsLjD7+CLWL0tbQD1Qtt+a0o5WlqGonWbx4jZRB3ZbpLJ5Z6ht4/I
	 IAWGofaVST+GQ==
Date: Sat, 4 Oct 2025 14:25:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=	 <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Maxime Coquelin	 <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: stm32-dfsdm: fix st,adc-alt-channel property
 handling
Message-ID: <20251004142517.0cf3e7a2@jic23-huawei>
In-Reply-To: <5243c2c5a8f3dd24f40e30a695e2a3d4f948f388.camel@gmail.com>
References: <20251002112250.2270144-1-olivier.moysan@foss.st.com>
	<5243c2c5a8f3dd24f40e30a695e2a3d4f948f388.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 03 Oct 2025 07:15:56 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2025-10-02 at 13:22 +0200, Olivier Moysan wrote:
> > Initially st,adc-alt-channel property was defined as an enum in the DFS=
DM
> > binding. The DFSDM binding has been changed to use the new IIO backend
> > framework, along with the adoption of IIO generic channels.
> > In this new binding st,adc-alt-channel is defined as a boolean property,
> > but it is still handled has an enum in DFSDM driver.
> > Fix st,adc-alt-channel property handling in DFSDM driver.
> >=20
> > Fixes: 3208fa0cd919 ("iio: adc: stm32-dfsdm: adopt generic channels bin=
dings")
> > Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied to my temporary fixes branch that I'll rebase on rc1 once available.
Also marked for stable.

thanks,

Jonathan

>=20
> > =C2=A0drivers/iio/adc/stm32-dfsdm-adc.c | 5 ++---
> > =C2=A01 file changed, 2 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-=
dfsdm-adc.c
> > index 74b1b4dc6e81..9664b9bd75d4 100644
> > --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> > +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> > @@ -725,9 +725,8 @@ static int stm32_dfsdm_generic_channel_parse_of(str=
uct
> > stm32_dfsdm *dfsdm,
> > =C2=A0	}
> > =C2=A0	df_ch->src =3D val;
> > =C2=A0
> > -	ret =3D fwnode_property_read_u32(node, "st,adc-alt-channel", &df_ch- =
=20
> > >alt_si); =20
> > -	if (ret !=3D -EINVAL)
> > -		df_ch->alt_si =3D 0;
> > +	if (fwnode_property_present(node, "st,adc-alt-channel"))
> > +		df_ch->alt_si =3D 1;
> > =C2=A0
> > =C2=A0	if (adc->dev_data->type =3D=3D DFSDM_IIO) {
> > =C2=A0		backend =3D devm_iio_backend_fwnode_get(&indio_dev->dev, NULL,
> > node); =20


