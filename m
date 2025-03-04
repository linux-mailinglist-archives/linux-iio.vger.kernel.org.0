Return-Path: <linux-iio+bounces-16354-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F05A4E1DA
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 15:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53F7B7ACAD5
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 14:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F36926657B;
	Tue,  4 Mar 2025 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEfwMRTz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E18526463F;
	Tue,  4 Mar 2025 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099802; cv=none; b=AINqu+SGYZQZBCqXmn8UfTu0oae2Nokx/fFW1Sx6Lhzww0Qq+mDirjRV/ULKt2ZL721BjKRIdThXuTiaTH61n6JJksdCNpOTNrzIVWt+m5tAv1PgTgUHaUOfVitJk5AjjAYIzKBTsJRNRwNHtmymmuHO3j7aqRHE0MBwCgfBYbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099802; c=relaxed/simple;
	bh=gvu0i166/31zSlrQGFJF0Kf6XaFopXDBRAjMx2RaV1g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tv+Mw89mdSUYppe9zYgNoIHjpCDNTya2JrYgyhJ2qN04manZTC/poWOah1nf+Fs3PlpBg3COR9tMj1Av5lxp4QzyBwvbldP8dCCDh/8cGYxKxSAMDgl+g9d5t9d66YNqg05zMDL9spwFtB3YaGupV9z/0UN7wFzlEFO7nR6f1r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEfwMRTz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405C8C4CEE7;
	Tue,  4 Mar 2025 14:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741099801;
	bh=gvu0i166/31zSlrQGFJF0Kf6XaFopXDBRAjMx2RaV1g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hEfwMRTzcS+9wfndkkQmnzngTQdkpZ81sOdrKTs9Ajgmw7HNDW9o5g8ttpxNahlmT
	 PKVYnse4D6K9SJOgcRCqH7KtkEZlAW1iOEinxupk4HvCOKBUpGFqVZ0NVEYiXs4gwh
	 3bjNeKqpCQPRE5IXDOLCJazbheCWCw9qKUGeYPbp+XRKJNbwEr30NaVpodlnMipyn3
	 NK+ZUd1pNDgib08XvMNpAZ5EvoQd63kydctF0lTnU0q0CP0WA16E6jp0lGeBQJXvYN
	 6NK4Sb+30272/DbmMhEg4vfuIGHgTcy9A50JPr03t/KNkt/XD9PrP/kOY/0jC+pLSJ
	 HxBwuY85Rcf4g==
Date: Tue, 4 Mar 2025 14:49:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Folker Schwesinger <dev@folker-schwesinger.de>, Lars-Peter Clausen
 <lars@metafoo.de>, Nuno Sa  <nuno.sa@analog.com>, Paul Cercueil
 <paul@crapouillou.net>, Peter Zijlstra  <peterz@infradead.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: buffer-dma: Fix docstrings
Message-ID: <20250304144951.73d152d3@jic23-huawei>
In-Reply-To: <37a99292819c20e6da5227cd46e9f1250cb67804.camel@gmail.com>
References: <D83IPSTKYWNB.1PUBV1530XI86@folker-schwesinger.de>
	<37a99292819c20e6da5227cd46e9f1250cb67804.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Feb 2025 08:26:44 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2025-02-27 at 20:27 +0100, Folker Schwesinger wrote:
> > Fix a typo in the docstring of iio_dma_buffer_read() and fix what looks
> > like a copy-and-paste error in the iio_dma_buffer_write() docstring.
> >=20
> > Signed-off-by: Folker Schwesinger <dev@folker-schwesinger.de>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied. Thanks.

>=20
> > =C2=A0drivers/iio/buffer/industrialio-buffer-dma.c | 4 ++--
> > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c
> > b/drivers/iio/buffer/industrialio-buffer-dma.c
> > index 7ea784304ffb..ee294a775e8a 100644
> > --- a/drivers/iio/buffer/industrialio-buffer-dma.c
> > +++ b/drivers/iio/buffer/industrialio-buffer-dma.c
> > @@ -624,7 +624,7 @@ static int iio_dma_buffer_io(struct iio_buffer *buf=
fer,
> > size_t n,
> > =C2=A0
> > =C2=A0/**
> > =C2=A0 * iio_dma_buffer_read() - DMA buffer read callback
> > - * @buffer: Buffer to read form
> > + * @buffer: Buffer to read from
> > =C2=A0 * @n: Number of bytes to read
> > =C2=A0 * @user_buffer: Userspace buffer to copy the data to
> > =C2=A0 *
> > @@ -640,7 +640,7 @@ EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_read,
> > "IIO_DMA_BUFFER");
> > =C2=A0
> > =C2=A0/**
> > =C2=A0 * iio_dma_buffer_write() - DMA buffer write callback
> > - * @buffer: Buffer to read form
> > + * @buffer: Buffer to write to
> > =C2=A0 * @n: Number of bytes to read
> > =C2=A0 * @user_buffer: Userspace buffer to copy the data from
> > =C2=A0 *
> >=20
> > base-commit: faeaa1ec6c63b6676679f321601471772f2a0c9b =20
>=20
>=20


