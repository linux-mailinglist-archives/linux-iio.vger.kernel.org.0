Return-Path: <linux-iio+bounces-26240-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3F1C6096A
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 18:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 607BD24146
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 17:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4772192EE;
	Sat, 15 Nov 2025 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dG9p+w1+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD4317D2;
	Sat, 15 Nov 2025 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763227912; cv=none; b=BsybxC71TBnoFgyWRghULBEp0t5AeV4CuQM9kURQqjK0PBkLn4kw+Q+WAUaSB7DICKZ7HjWJAVO9wYsPVF6jVfYfWUzsjamKTsLx3mYCxxEsvQmkjrc5hMtCKuXz/4qK7t49efJKgXyCjSzc7XDDrcxTTYeCluGi3r3f+3yYwjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763227912; c=relaxed/simple;
	bh=rhPXIag8hEmqt0NGHZdNZ2xiKrObwj021g4Qo9O6Pxo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pytogjYNLIwejoXVvA7c+9yenXMxlQhOwLLI0zH37Gvf1mY3CheXv1H3VHZkFKFjE7vVZAfL9xsgMpKZ910Eq5/s3Z1qRX/3aIrGSuuBRc7dO3IWGOHbVcAc3ZWWBo7wA5xr208pKju28IXXLQepoPRzmkdXO5cs4kzRax6qNUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dG9p+w1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334DFC4CEF8;
	Sat, 15 Nov 2025 17:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763227911;
	bh=rhPXIag8hEmqt0NGHZdNZ2xiKrObwj021g4Qo9O6Pxo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dG9p+w1+00F/t8xKQck4idZMgDVVaOT2XbT0Z4hiT2sE2y4RPFsXOXzaQwNLKmJ+m
	 r51+GYkdiGEn0qLAvrNXDw5652C8bZfAm80mNPrvWfmZ5fX9kv+3ZimP7DfxKhJsiK
	 3y9deFjeV8MDnBhC/I6CKHODRj2H911m6qvI1VNrHYZIyrUi8thOeS5Aa3lSP6OOun
	 Z7wTQ+t396iNVWrYLZX2/I73qs5XUSQ2Ry3HaswvS57WjMmUG6q7br5eTDu+tSzrns
	 Iwyc6c5aLCDlFjQXcw906t9e3V97FNKgGkOSWFgHBFK5/1cNmQZ988T1qT8PICGEWh
	 u2TSOh26dPZNA==
Date: Sat, 15 Nov 2025 17:31:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Liang Jie <buaajxlj@163.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko	
 <andy@kernel.org>, "open list:IIO SUBSYSTEM AND DRIVERS"	
 <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 liangjie@lixiang.com, fanggeng@lixiang.com, yangchen11@lixiang.com
Subject: Re: [PATCH] iio: buffer: use dma_buf_unmap_attachment_unlocked()
 helper
Message-ID: <20251115173145.7eab1467@jic23-huawei>
In-Reply-To: <5cd213e377dbf6ff0fb24f92cefd0e4283375d17.camel@gmail.com>
References: <20251114084725.2079196-1-buaajxlj@163.com>
	<5cd213e377dbf6ff0fb24f92cefd0e4283375d17.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Nov 2025 09:07:33 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Fri, 2025-11-14 at 16:47 +0800, Liang Jie wrote:
> > From: Liang Jie <liangjie@lixiang.com>
> >=20
> > Replace open-coded dma_resv_lock()/dma_resv_unlock() around
> > dma_buf_unmap_attachment() in iio_buffer_dmabuf_release() with the
> > dma_buf_unmap_attachment_unlocked() helper.
> >=20
> > This aligns with the standard DMA-BUF API, avoids duplicating
> > locking logic and eases future maintenance. No functional change.
> >=20
> > Reviewed-by: fanggeng <fanggeng@lixiang.com>
> > Signed-off-by: Liang Jie <liangjie@lixiang.com>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied.

Thanks,

Jonathan

>=20
> > =C2=A0drivers/iio/industrialio-buffer.c | 4 +---
> > =C2=A01 file changed, 1 insertion(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrial=
io-buffer.c
> > index a80f7cc25a27..58330abbf40a 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -1563,9 +1563,7 @@ static void iio_buffer_dmabuf_release(struct kref=
 *ref)
> > =C2=A0	struct iio_buffer *buffer =3D priv->buffer;
> > =C2=A0	struct dma_buf *dmabuf =3D attach->dmabuf;
> > =C2=A0
> > -	dma_resv_lock(dmabuf->resv, NULL);
> > -	dma_buf_unmap_attachment(attach, priv->sgt, priv->dir);
> > -	dma_resv_unlock(dmabuf->resv);
> > +	dma_buf_unmap_attachment_unlocked(attach, priv->sgt, priv->dir);
> > =C2=A0
> > =C2=A0	buffer->access->detach_dmabuf(buffer, priv->block);
> > =C2=A0 =20


