Return-Path: <linux-iio+bounces-26862-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 095C4CAADDA
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 22:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1A88306DCA7
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 21:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2AE178372;
	Sat,  6 Dec 2025 21:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHt5pbDV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6C6EEB3
	for <linux-iio@vger.kernel.org>; Sat,  6 Dec 2025 21:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765055359; cv=none; b=eAU+j7YIinhqfcIeSVhaaKqm1wLsAQMN6ikiAGz4v74VFCl3EzVxCDFbZi83chBNXBsFYb6IrzFj5uwETsYeFDzlU6jWa1uslNRz/zZaXeRSJ+DutBCkZb7zl5h4nnJ/Lkg4ogS0edFtySlKi7wt1I/rcIVhWWX04nDAAcFY92E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765055359; c=relaxed/simple;
	bh=CsktMh/lZUjOsAUqHSfp2iedjwS3hDm4Yxk/0oL5TgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FhQoqnxWu0xMLJhCpagc7fwWc8UcjWtPtV7rwkUFPpMHYOaXVTZxRjoi46lqH2vnGxQVa2yLyzDGDVe3ab+Jpx1pPYD2JHBBJOtTR2qsfO98TEhmrs28ypte/GFZRk/Ue7rxXIHvtMkQLyuK5rb8OYk2wAZOQh2MPNiG9+bS188=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHt5pbDV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FDFC4CEF5;
	Sat,  6 Dec 2025 21:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765055359;
	bh=CsktMh/lZUjOsAUqHSfp2iedjwS3hDm4Yxk/0oL5TgQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bHt5pbDVBlRCqWm7RUBwBun6KFH8TndDz1F7cetrAMS1mKxPGimPhwOGARM3P594n
	 RBBaglIOoPV7Yo2Eq7vaEDOczz3I6FT7bYPbenQgwr++4WmCHxU/57Pdahv0dwN2CR
	 XyMyE1xwNrCiFl+xN1GmSp5UL3RfkPFcFTK4Z9cTEQnN9byxkySuZVMJI3laCp5Ivc
	 lO4ov6sFNKsizFs1dMKrqmXYMFaOKV7Vy+oG7zRMOIlOZDLTVMaDvjhs1I3GzTKzO0
	 0ds+i2ptKE7K3Oy+R6cjLmK2bpJQN6fZ7dAr9hQSWEFUjepKkl/zL2ynLDYWZzcZde
	 SgNIVlOriqQYQ==
Date: Sat, 6 Dec 2025 21:09:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, nuno.sa@analog.com,
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 4/6] iio: buffer-dma: Fix coding style complains
Message-ID: <20251206210911.57ec8340@jic23-huawei>
In-Reply-To: <0824e2b0d4c29de9f4bba37dbf60dbba97bcd789.camel@gmail.com>
References: <20251203-iio-dmabuf-improvs-v1-0-0e4907ce7322@analog.com>
	<20251203-iio-dmabuf-improvs-v1-4-0e4907ce7322@analog.com>
	<aTBlg2rW0rrjHh73@smile.fi.intel.com>
	<0824e2b0d4c29de9f4bba37dbf60dbba97bcd789.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 04 Dec 2025 11:25:12 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2025-12-03 at 18:29 +0200, Andy Shevchenko wrote:
> > On Wed, Dec 03, 2025 at 03:11:39PM +0000, Nuno S=C3=A1 via B4 Relay wro=
te:
> >  =20
> > > Just making sure checkpatch is happy. No functional change intended. =
=20
> >=20
> > ...
> >  =20
> > > -static struct iio_dma_buffer_block *iio_dma_buffer_alloc_block(
> > > -	struct iio_dma_buffer_queue *queue, size_t size, bool fileio)
> > > +static struct iio_dma_buffer_block *iio_dma_buffer_alloc_block(struc=
t iio_dma_buffer_queue
> > > *queue,
> > > +							=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t size,
> > > +							=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool fileio) =20
> >=20
> > What about 80 rule?
> >  =20
>=20
> This falls in the bucket where readability is hurt. At least IMHO, so tha=
t's why I
> did it this way. If Jonathan disagrees, I'll of course change it to the b=
elow style.
>=20
Marginal readability benefit. The complex return type on the line above is =
pretty
common pattern so my eyes are used to it even if no one else's are ;)


>=20
> > static struct iio_dma_buffer_block *
> > iio_dma_buffer_alloc_block(struct iio_dma_buffer_queue *queue, size_t s=
ize,
> > 			=C2=A0=C2=A0 bool fileio)
> >=20
> > (And personally I think that in 2025 we should grow up and forget about=
 this
> > =C2=A0and move on to 100, but... not a maintainer here :-) =20
>=20
> FWIW, Agreed! (And that is what I do for all the out of tree stuff :))

Given it another few years and maybe I'll relax more. :)

I don't really care that much as long as people are consistent and don't
end up with something really hard to read!

Jonathan

>=20
> - Nuno S=C3=A1
>=20
>=20
>=20


