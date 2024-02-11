Return-Path: <linux-iio+bounces-2420-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97920850AE3
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 19:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14D9CB21670
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 18:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7257F5C5EB;
	Sun, 11 Feb 2024 18:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gtwl1Fec"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D54DFC19;
	Sun, 11 Feb 2024 18:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707677618; cv=none; b=WJGzmba45N2EUiB0glv+R2x6GnUmAABV3OwYEOGTmnSOku1oXaLXjj61pemTAXNGoEeEm+TsvefNlVwy7wbeam0gRqP12/qJ6v6SileDM1LEH7jzgkX4vnKH0jLSuj/1BsSHXWXPGeSKXvXR8w+CH3lIaGH0OIUYRalw9covfiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707677618; c=relaxed/simple;
	bh=51Z67SqHAKgk9iWK2IYl/gTT0lOS9VnUGZT6342BW6E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vs3EMYuzjoq6+4rvu329K2mjtMytqRFIXC4GYk6k5UHv+jW02qKvtpGPFXIzIsI94YgrFMwKk2J++oAr5bKzZDCTFY73J+9b+6NlF2wGXCf4xWoL4iSBrg6ZzXT9ESTQj+Ym51wDGAOCVi+Y1w6PfNdVHay7KbD37tF68wH0FSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gtwl1Fec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6525DC433C7;
	Sun, 11 Feb 2024 18:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707677617;
	bh=51Z67SqHAKgk9iWK2IYl/gTT0lOS9VnUGZT6342BW6E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gtwl1FecSiXwkn4jhzHfDWPByeXkWeluq9FdgmfnD7+8t0fHcQap5tkSkN8SkEq3U
	 U3koQ6yporFGQfvK7g0FphMlJCMt0unejTArvGCEag6nq7eYzAJwIIqfJfTg+6nY/B
	 Nxh9HJbjMRNnw7Bn8tRBnXUxGJVFtvsKjJpO2uDi9Nh7zXtTyfizNDI6qdfyfAhpEP
	 wOggeNBjoUZZbav/Jh80qyLpgL9pHGOvRBw9j5NAh+ASUZ6Z9dasS3Nor379tp4/Gb
	 HztXeOzSjb2tJen6dzZqzAH+ACcBCiUalFI0mfl7vlqgYC2uWyTthQN0VbybMnYZ4D
	 lASeJ3tvtxr/A==
Date: Sun, 11 Feb 2024 18:53:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: linux-iio@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Daniel Scally <djrscally@gmail.com>, Heikki
 Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>, Mihail Chindris
 <mihail.chindris@analog.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Tomislav Denis <tomislav.denis@avl.com>, Marek Vasut <marex@denx.de>,
 Olivier Moysan <olivier.moysan@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Marijn Suijten
 <marijn.suijten@somainline.org>, Marius Cristea
 <marius.cristea@microchip.com>, Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 09/13] iio: addac: ad74413r: Use __free(fwnode_handle)
 to replace fwnode_handle_put() calls
Message-ID: <20240211185322.5e91589e@jic23-huawei>
In-Reply-To: <137a0efdc57d7c150178d2aad35c2c51d3f82704.camel@gmail.com>
References: <20240114172009.179893-1-jic23@kernel.org>
	<20240114172009.179893-10-jic23@kernel.org>
	<137a0efdc57d7c150178d2aad35c2c51d3f82704.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Jan 2024 11:17:12 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sun, 2024-01-14 at 17:20 +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > This use of the new cleanup.h scope based freeing infrastructure allows
> > us to exit directly from error conditions within the
> > fwnode_for_each_available_child_node(dev, child) loop. On normal exit
> > from that loop no fwnode_handle reference will be held and the child
> > pointer will be NULL thus making the automatically run
> > fwnode_handle_put() a noop.
> >=20
> > Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > --- =20
>=20
> Acked-by: Nuno Sa <nuno.sa@analog.com>
>=20
> > =C2=A0drivers/iio/addac/ad74413r.c | 9 ++-------
> > =C2=A01 file changed, 2 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> > index 7af3e4b8fe3b..ec9a466e118d 100644
> > --- a/drivers/iio/addac/ad74413r.c
> > +++ b/drivers/iio/addac/ad74413r.c
> > @@ -1255,21 +1255,16 @@ static int ad74413r_parse_channel_config(struct
> > iio_dev *indio_dev,
> > =C2=A0static int ad74413r_parse_channel_configs(struct iio_dev *indio_d=
ev)
> > =C2=A0{
> > =C2=A0	struct ad74413r_state *st =3D iio_priv(indio_dev);
> > -	struct fwnode_handle *channel_node =3D NULL;
> > +	struct fwnode_handle *channel_node __free(fwnode_handle) =3D NULL;
> > =C2=A0	int ret;
> > =C2=A0
> > =C2=A0	fwnode_for_each_available_child_node(dev_fwnode(st->dev),
This should have been
device_for_each_child_node() because that ultimately calls
of_fwnode_get_next_child_node() which calls the available form anyway.
https://lore.kernel.org/lkml/20211205190101.26de4a57@jic23-huawei/T/#u

So I'll just switch to the new
device_for_each_child_node_scoped() that I'm about to propose.


> > channel_node) {
> > =C2=A0		ret =3D ad74413r_parse_channel_config(indio_dev, channel_node);
> > =C2=A0		if (ret)
> > -			goto put_channel_node;
> > +			return ret;
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	return 0;
> > -
> > -put_channel_node:
> > -	fwnode_handle_put(channel_node);
> > -
> > -	return ret;
> > =C2=A0}
> > =C2=A0
> > =C2=A0static int ad74413r_setup_channels(struct iio_dev *indio_dev) =20
>=20


