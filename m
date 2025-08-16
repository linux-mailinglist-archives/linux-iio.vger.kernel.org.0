Return-Path: <linux-iio+bounces-22840-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48033B28EB0
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 16:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B59AC15E2
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 14:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52392EBB96;
	Sat, 16 Aug 2025 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/zeM56A"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6336C1E868
	for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755356355; cv=none; b=rtm1/SDIMrpGgZO/XrTwPHs3AOvjLuhvNTHG14fBkooQPeTbE7HZ4W+HB4yvmPoQgyONS/Dj/I3CsEdIEduQoJ/bBxzErLgv9ivxbZRJP44FhZ7rJMjrGG/cCDOfal5HJvyPXzWLeYsUSa1vkjNk8mh6FbdIpWeyMuFT/YrQVI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755356355; c=relaxed/simple;
	bh=R1wtKqj0nNHnDaVbB9rRRWMKPorGqOOa2xDooA22Zis=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4D8LUY3wCTvC5HcEOKpq+sLocPeOdjq1BlHLjFcyNEhIKdVImJMplTG7xdCyauXiWwcxRsyvCCaq6AlAhlz8NnbGx3o7Vi2aOjw2dlz8aAOKAgyDLf4f4b2M7dpJt1DykdusSaQiqK8DGkJPHOQTIGEv4NwpAv82+Xdk6v0ucU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/zeM56A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2C3C4CEEF;
	Sat, 16 Aug 2025 14:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755356354;
	bh=R1wtKqj0nNHnDaVbB9rRRWMKPorGqOOa2xDooA22Zis=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U/zeM56AfXdxPdLGRrg3TkUK249g7TGWCdeATG6esFe5oLuWoXx34wN6DNyOSssai
	 NXRtfv5KaWlX5X/NpLsX1vZmPGGb4QReplTvKfSbBJJRcItUtUfQehEoVkoclPkDaM
	 NvIavb2WezQ1MlV4VQxdIgN28jWJ2df58w9J1Uem+jfBsGPDfElsJ8Kp4hU09hpwoL
	 zr7kAW96aeUS+JqhK5FL5BsL/wiWMM+PkwfrDq/Gyys+gdf3oy39pyxy7ua7fe8j0R
	 jdHizuJ9GRKSwoPHD6ZbDpiyhx3qrCLbbkyw/VVD1xpNwt9go9b9CS+T7DPvpZmo1H
	 DUhZL4rsTQo8g==
Date: Sat, 16 Aug 2025 15:59:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?TcOlcnRlbg==?= Lindahl <martenli@axis.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Mudit Sharma <muditsharma.info@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Abhash Jha <abhashkumarjha123@gmail.com>,
 Astrid Rost <astrid.rost@axis.com>, =?UTF-8?B?TcOlcnRlbg==?= Lindahl
 <marten.lindahl@axis.com>, Gwendal Grignou <gwendal@chromium.org>,
 Christian Eggers <ChristianEggersceggers@arri.de>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 14/16] iio: light: vcnl4000: Use a structure to make
 buffer arrangement explicit.
Message-ID: <20250816155842.1ff5274c@jic23-huawei>
In-Reply-To: <442416b3-673b-4863-ae03-6de06e67b763@axis.com>
References: <20250802164436.515988-1-jic23@kernel.org>
	<20250802164436.515988-15-jic23@kernel.org>
	<442416b3-673b-4863-ae03-6de06e67b763@axis.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Aug 2025 09:00:17 +0200
M=C3=A5rten Lindahl <martenli@axis.com> wrote:

> Reviewed-by: M=C3=A5rten Lindahl <marten.lindahl@axis.com>
Applied. thanks
>=20
> Kind regards
>=20
> M=C3=A5rten
>=20
> On 8/2/25 18:44, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Removes the need for comments to describe the buffer passed to
> > iio_push_to_buffers_with_timestamp().
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Astrid Rost <astrid.rost@axis.com>
> > Cc: M=C3=A5rten Lindahl <marten.lindahl@axis.com>
> > ---
> >   drivers/iio/light/vcnl4000.c | 9 ++++++---
> >   1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> > index 90e7d4421abf..eccf690eae8c 100644
> > --- a/drivers/iio/light/vcnl4000.c
> > +++ b/drivers/iio/light/vcnl4000.c
> > @@ -1662,7 +1662,10 @@ static irqreturn_t vcnl4010_trigger_handler(int =
irq, void *p)
> >   	struct iio_dev *indio_dev =3D pf->indio_dev;
> >   	struct vcnl4000_data *data =3D iio_priv(indio_dev);
> >   	const unsigned long *active_scan_mask =3D indio_dev->active_scan_mas=
k;
> > -	u16 buffer[8] __aligned(8) =3D {0}; /* 1x16-bit + naturally aligned t=
s */
> > +	struct {
> > +		u16 chan;
> > +		aligned_s64 ts;
> > +	} scan =3D { };
> >   	bool data_read =3D false;
> >   	unsigned long isr;
> >   	int val =3D 0;
> > @@ -1682,7 +1685,7 @@ static irqreturn_t vcnl4010_trigger_handler(int i=
rq, void *p)
> >   			if (ret < 0)
> >   				goto end;
> >  =20
> > -			buffer[0] =3D val;
> > +			scan.chan =3D val;
> >   			data_read =3D true;
> >   		}
> >   	}
> > @@ -1695,7 +1698,7 @@ static irqreturn_t vcnl4010_trigger_handler(int i=
rq, void *p)
> >   	if (!data_read)
> >   		goto end;
> >  =20
> > -	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> > +	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
> >   					   iio_get_time_ns(indio_dev));
> >  =20
> >   end: =20
>=20


