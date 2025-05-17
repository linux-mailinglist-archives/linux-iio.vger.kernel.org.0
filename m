Return-Path: <linux-iio+bounces-19612-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C909FABAC13
	for <lists+linux-iio@lfdr.de>; Sat, 17 May 2025 21:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D2CE9E290C
	for <lists+linux-iio@lfdr.de>; Sat, 17 May 2025 19:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD8B20C02E;
	Sat, 17 May 2025 19:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwEWUxQt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6CC249F9;
	Sat, 17 May 2025 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747510057; cv=none; b=mgQxBEST6cEF9f+12ztMWKjGnf4SHomUWwwwZzrt4iUc9lkgiyMJw3xbWuejSrNVTBa5SBSw+k0Dkg59GZ9ewaFzbpEwm23P0umkRU6dzr1gS3Me5xtvGCeS1guFPUcxBmRnXGgIN4F/oPL3ZuX8LW86uVv31Y5WY6M9i7MxlLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747510057; c=relaxed/simple;
	bh=w9elXlLkSFzM8XjcTrJtA0NjFyO07EbS5+qAh+2qcuc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hOYBIbsWPe0s9BIANREEBHZzwOs1KIQkzj9CQHoVMo4AwlDF28Dygr1qNxjXpqznX8KVUHw4wqi8Xt4oJ3wFT33ijf28dgpjlzGdojNASdlwDdZAif5DGRj2iQblDHdnEsTCd9vTZ6iucpUw+dIjMScpGdwUdsYGehxtoEC+HQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwEWUxQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C3DC4CEE3;
	Sat, 17 May 2025 19:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747510057;
	bh=w9elXlLkSFzM8XjcTrJtA0NjFyO07EbS5+qAh+2qcuc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AwEWUxQt617jfA2sxJXK5zb7Sx/ss/08/3+1XoheRvgXOi9lS7PUHvv3JrNI13iEQ
	 G8hT3fzo4PPEXsCHK/lWh5jUDmShjXEGvdmCAI/qyFKQmaZsxTY7vZlEhl9HZnxFuB
	 tPY2ks72LEv9LM2k9No+qlbRfuFlzgyjEDVlgBhTdcODrqfL0Snf9kzTP6BqcL3knC
	 IXHSLOYBylc6gBSP3IXmYt8Wnu5LPnj7RKoWhlyExp8P2xCosUg9GgdLHG0OqkypXo
	 ugqwY0o9Wznt2VYXWVP+8VqneRgQBT4kCGyckPYKOr97AofN6DWt5e6eZYyf0VKNEM
	 el/74h7LrKuDw==
Date: Sat, 17 May 2025 20:27:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ahelenia =?UTF-8?B?WmllbWlhxYRza2E=?=
 <nabijaczleweli@nabijaczleweli.xyz>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: ssp_sensors: optimalize -> optimize
Message-ID: <20250517202735.2c589de0@jic23-huawei>
In-Reply-To: <20250508202202.38c19704@jic23-huawei>
References: <f6e465fee5a824a67be1ae7c3bc1b72adcf9471f.1746558529.git.nabijaczleweli@nabijaczleweli.xyz>
	<5a64aa3034c6127d7587de9b7045a12892c01ee5.1746558529.git.nabijaczleweli@nabijaczleweli.xyz>
	<20250508202202.38c19704@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 8 May 2025 20:22:02 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 6 May 2025 21:10:02 +0200
> Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz> wrote:
>=20
> > Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.=
xyz>
> > ---
> >  drivers/iio/common/ssp_sensors/ssp_spi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/com=
mon/ssp_sensors/ssp_spi.c
> > index f32b04b63ea1..b7f093d7345b 100644
> > --- a/drivers/iio/common/ssp_sensors/ssp_spi.c
> > +++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
> > @@ -104,7 +104,7 @@ static struct ssp_msg *ssp_create_msg(u8 cmd, u16 l=
en, u16 opt, u32 data)
> >  /*
> >   * It is a bit heavy to do it this way but often the function is used =
to compose
> >   * the message from smaller chunks which are placed on the stack.  Oft=
en the
> > - * chunks are small so memcpy should be optimalized.
> > + * chunks are small so memcpy should be optimized.
> >   */
> >  static inline void ssp_fill_buffer(struct ssp_msg *m, unsigned int off=
set,
> >  				   const void *src, unsigned int len) =20
>=20
> Applied.
>=20
For future reference don't send typo fixes in a series that covers
multiple subsystems.  Some sleep deprived maintainer might type
the wrong thing in b4 and pick up the whole series (including
the microblaze one) instead of just the one he should be!

Noticed it when double checking the pull request.

oops

Jonathan



