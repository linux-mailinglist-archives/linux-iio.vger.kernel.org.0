Return-Path: <linux-iio+bounces-1632-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BBB82CD79
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jan 2024 16:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E391F21D12
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jan 2024 15:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6933515CB;
	Sat, 13 Jan 2024 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpqLk7ls"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3508F33CC
	for <linux-iio@vger.kernel.org>; Sat, 13 Jan 2024 15:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96180C433C7;
	Sat, 13 Jan 2024 15:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705159687;
	bh=FOCCDJu9QLd/FqEdVFgs6lWu8e2Cj1ZXs0+Bisu+I5w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SpqLk7lseUx3HD6OUBIOEK7HagdKhGLSj5LMliikDx4zoGkDwZladBJK0vqcgjrCt
	 lT+0I+UouA09vxubfFGBZWILutAhPKsGMmrMq6O6J3kevxwbfCCvy6MUktVv/ztPLl
	 zMOu49emdv9DOlzKfPO8lNKgK91H1dCmiZbAr9LN6bUch5Sa9YgUnjXg5HPXFiDlJe
	 pL+7JEplnT21opW+vDoHwUJavLsXG2kDKrhK9bWqXCK7r+yfD3FheFuG0tEoMm3H4M
	 1hD5lMAoLXg3wcdw/Hehvoet3liUBibs2HcGiHRE5M8DqV8l950xHepyFTvUnLfSU8
	 52mhgTr8ehWVA==
Date: Sat, 13 Jan 2024 15:28:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: buffer-dmaengine: make use of the 'struct device
 *' argument
Message-ID: <20240113152803.7bb9c4f3@jic23-huawei>
In-Reply-To: <CAMknhBFUeAvtXorP+H_1Yqj4nJyqrPoqnAae5FOBvLCZ9SNVBQ@mail.gmail.com>
References: <20240109-dmaengine_use_device-v1-1-1cbdb7fe9f29@analog.com>
	<CAMknhBFUeAvtXorP+H_1Yqj4nJyqrPoqnAae5FOBvLCZ9SNVBQ@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Jan 2024 11:56:47 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On Tue, Jan 9, 2024 at 9:47=E2=80=AFAM Nuno Sa <nuno.sa@analog.com> wrote:
> >
> > Respect the @dev argument in devm_iio_dmaengine_buffer_setup() and bind=
 the
> > IIO DMA buffer lifetime to that device.
> >
> > For the only user of this function, the IIO parent device is the
> > struct device being passed to the API so no real fix in here (just
> > consistency with other IIO APIs).
> >
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> >  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drive=
rs/iio/buffer/industrialio-buffer-dmaengine.c
> > index 5f85ba38e6f6..45fe7d0d42ee 100644
> > --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > @@ -279,8 +279,7 @@ int devm_iio_dmaengine_buffer_setup(struct device *=
dev,
> >  {
> >         struct iio_buffer *buffer;
> >
> > -       buffer =3D devm_iio_dmaengine_buffer_alloc(indio_dev->dev.paren=
t,
> > -                                                channel);
> > +       buffer =3D devm_iio_dmaengine_buffer_alloc(dev, channel);
> >         if (IS_ERR(buffer))
> >                 return PTR_ERR(buffer);
> >
> >
> > ---
> > base-commit: 3f4525f924e21d4f532517b17a20ffa5df7c0db7
> > change-id: 20240109-dmaengine_use_device-853f196ec78f
> > --
> >
> > Thanks!
> > - Nuno S=C3=A1
> >
> > =20
>=20
> I noticed this too but didn't get around to fixing it yet. ;-)
>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
Applied



