Return-Path: <linux-iio+bounces-6741-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 736E7913983
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 12:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20EE8B2267A
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 10:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D04E78283;
	Sun, 23 Jun 2024 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHRbHnSL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD839470;
	Sun, 23 Jun 2024 10:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719137966; cv=none; b=UdgrB6I242mFNE+Rtilh78oJwWmKvEi6OWsUsyw05smd0vnJE/VNPO73j2ILpVFl2UB+CCfRwp/+gJ2I3gmHdcqgUgE2KnAGrV4YIv4A5y1YNEV26eMy4QxUIhyvBpowDIhPZVXJPHHMyAHWWXSvOGkfn07nwY3n1BP0UuG49p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719137966; c=relaxed/simple;
	bh=o9hT+jHMcWyflrf0morfRwY+tcRHM0n1jlJSxR7CVW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kHUEYbeDZOLj4iYk/ky8paXSd3t4cFjPMN/04o/dmfBFzFewXyrpR25/9wSjX5SSOObNmGHOOX9qfJ3AiB9dinCydwA7Ml67hfBDf9ZSjrp0bS0uGt0x3SuY+H9P3mLR8R2PK1Lxnaw4POkJviE0GgGn8XoNg7mJA4rLVog24sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHRbHnSL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9ECC2BD10;
	Sun, 23 Jun 2024 10:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719137965;
	bh=o9hT+jHMcWyflrf0morfRwY+tcRHM0n1jlJSxR7CVW8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DHRbHnSLWbPIrgZSwFUc1+kfNM4ubyUGntb2wOZK5NRVXtRv6al0LkNiyOLYMsw6L
	 OtnNrK58A8l35YxjMXzng5fVGNkk4Td2bLvrtpZsma5aaqCsBJVmy8uZdgtmQKiChq
	 R57JFb6Vh747bJ1HnYJp34zaEEfawNfag8/BBL7jg/3fH32HYU7tlqeVsJdXwXqweG
	 F55ZzTxMZf+WaTd6i0TpdbgAuHByz/SyaCkXJQo+rtgxtGHkhZ9DnsXteD3JE9zeam
	 J8cdVfqY1sh7gTy3HnfG+z8oHwY6JQfk0f9LIpW+eCzc9pdYk34yD/cQQoVjD9L34P
	 WLtbugClGNetw==
Date: Sun, 23 Jun 2024 11:19:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: Dumitru Ceclan <mitrutzceclan@gmail.com>, dlechner@baylibre.com,
 dumitru.ceclan@analog.com0, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dumitru Ceclan <dumitru.ceclan@analog.com>
Subject: Re: [PATCH] iio: adc: ad_sigma_delta: fix disable_one callback
Message-ID: <20240623111916.2044ceda@jic23-huawei>
In-Reply-To: <CA+GgBR_7OXJLytDeF-MSJSAAgFRJm39wBbEXxSR6HUV_zcWg_A@mail.gmail.com>
References: <20240621120539.31351-1-dumitru.ceclan@analog.com>
	<CA+GgBR_7OXJLytDeF-MSJSAAgFRJm39wBbEXxSR6HUV_zcWg_A@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Jun 2024 16:26:29 +0300
Alexandru Ardelean <aardelean@baylibre.com> wrote:

> On Fri, Jun 21, 2024 at 3:05=E2=80=AFPM Dumitru Ceclan <mitrutzceclan@gma=
il.com> wrote:
> >
> > The ADC ad7192 is a sigma delta ADC with a sequencer that does not
> > require a disable_one callback as all enable channel bits are within
> > the same register.
> >
> > Remove the requirement of the disable_one callback for sigma delta ADCs
> > with a sequencer.
> >
> > This patch could be squashed with the commit that it fixes from patch
> > series: Add support for AD411x
> > =20

I'm going to treat Alexandru's suggestion as a potential separate issue.
I've squashed this patch into the one if fixes. That was particularly neces=
sary
as the ID isn't stable yet.  I may need to rebase in order to get some
fixes before I send another pull request.

>=20
> This fix looks fine.
> But, then this raises a question if this needs be to extended to the
> `disable_all` and maybe `indio_dev->info->update_scan_mode` check.
> And if so, how should this be handled?
>=20
> For example:
> drivers/iio/adc/ad7124.c:    .disable_all =3D ad7124_disable_all,
> drivers/iio/adc/ad7173.c:    .disable_all =3D ad7173_disable_all,
> drivers/iio/adc/ad7192.c:    .disable_all =3D ad7192_disable_all,
> drivers/iio/adc/ad7192.c:    .disable_all =3D ad7192_disable_all,
>=20
> And:
> drivers/iio/adc/ad7124.c:    ret =3D ad_sd_init(&st->sd, indio_dev, spi,
> &ad7124_sigma_delta_info);
> drivers/iio/adc/ad7173.c:    ret =3D ad_sd_init(&st->sd, indio_dev, spi,
> &ad7173_sigma_delta_info);
> drivers/iio/adc/ad7192.c:    ret =3D ad_sd_init(&st->sd, indio_dev, spi,
> st->chip_info->sigma_delta_info);
> drivers/iio/adc/ad7780.c:    ad_sd_init(&st->sd, indio_dev, spi,
> &ad7780_sigma_delta_info);
> drivers/iio/adc/ad7791.c:    ad_sd_init(&st->sd, indio_dev, spi,
> &ad7791_sigma_delta_info);
> drivers/iio/adc/ad7793.c:    ad_sd_init(&st->sd, indio_dev, spi,
> &ad7793_sigma_delta_info);
>=20
> At least the ad7791.c & ad7793.c drivers support parts with more than
> 1 channel, and there does not seem to be any `disable_all` hook
> defined (at least in iio/testing).
> I have not gone too deep with `indio_dev->info->update_scan_mode`, but
> it would be worth to do a check there as well
>=20
>=20
> > Fixes: a25a0aab2187 ("iio: adc: ad_sigma_delta: add disable_one callbac=
k")
> > Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> > ---
> >  drivers/iio/adc/ad_sigma_delta.c | 5 -----
> >  1 file changed, 5 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigm=
a_delta.c
> > index d6b5fca034a0..8c062b0d26e3 100644
> > --- a/drivers/iio/adc/ad_sigma_delta.c
> > +++ b/drivers/iio/adc/ad_sigma_delta.c
> > @@ -672,11 +672,6 @@ int ad_sd_init(struct ad_sigma_delta *sigma_delta,=
 struct iio_dev *indio_dev,
> >                         dev_err(&spi->dev, "ad_sigma_delta_info lacks d=
isable_all().\n");
> >                         return -EINVAL;
> >                 }
> > -
> > -               if (!info->disable_one) {
> > -                       dev_err(&spi->dev, "ad_sigma_delta_info lacks d=
isable_one().\n");
> > -                       return -EINVAL;
> > -               }
> >         }
> >
> >         if (info->irq_line)
> > --
> > 2.43.0
> >
> > =20


