Return-Path: <linux-iio+bounces-18455-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C2FA9522F
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 15:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE95818927C7
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8015226659A;
	Mon, 21 Apr 2025 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rn7KVkji"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3521926461D;
	Mon, 21 Apr 2025 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243891; cv=none; b=gxH1mfVnpBuhtD9Wa9D9LXwOh11afWzmFB5nQuhMizpsNQ7tXBWHiuURSdCjMF02a5LEYk23X/ezx6HiHCzDdR05JkLBn2EkIj0hORzf0+pH2PloR0gn+r4ahj/Ng6DXvCeCumXgjPKMRsMBs45CXiLX1i6tcQsXzPUQ19Ih3AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243891; c=relaxed/simple;
	bh=IkWq79A5SiWTnnRZu57suafo1hnLB4sQXuYq7WqYcis=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XIxweywXPpZjcNlnx4wiaDlHvYIJOowyxt11FnMvtK8JoH/cb7wJ1OadJ1opU8VL88ZYxDq+xJzfn+03g1ScuXbm4ddtAleVNd86CkPauC+zB57Q4QZXvmv5wr1hOPawIDhBTC7cFxWq3OnTUw5vPJebt9T8kRmbUc0H/5IQRKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rn7KVkji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6628BC4CEEA;
	Mon, 21 Apr 2025 13:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745243890;
	bh=IkWq79A5SiWTnnRZu57suafo1hnLB4sQXuYq7WqYcis=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rn7KVkjiGkF/uIf/Mdz4kmGKyTrcUEi5dEgLBN7KoSxWQ3c//dN2nmz5vfK0X8SLX
	 xRsR8xki8EU99AkThBXm1A/MRI3bGI1EXWxGcwR2KvwLlE1tiFwKculA8Vyxyr6uKq
	 xkoQdxmzKiY+SiZjpSqCDpGBH+1eAU6HuP9pghxidu8bpLZGFCaMvUDZToaDGkd3vE
	 mi3WxysfZ7y3/h8EyYPlmXQ/gfWkfZcm+rbDH9sUml1brhc7WMqOrJ4cyAvwxA+nsk
	 Mfk2lmcPV1c8YULtJ476xnhatVyR7WhinXK53QIV1PnTetGSEuqxfBRhExV0aeqWv6
	 sccQa7W/bMfVA==
Date: Mon, 21 Apr 2025 14:58:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] iio: adis16201: Correct inclinometer channel resolution
Message-ID: <20250421145804.6ee78b66@jic23-huawei>
In-Reply-To: <CAKUZ0z+CSMqCNFAT9k6nUkiwYjq0QG=hH3QPLO-w47xWLkVUxg@mail.gmail.com>
References: <20250419144520.815198-1-gshahrouzi@gmail.com>
	<20250421124915.32a18d36@jic23-huawei>
	<CAKUZ0z+CSMqCNFAT9k6nUkiwYjq0QG=hH3QPLO-w47xWLkVUxg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 21 Apr 2025 09:05:24 -0400
Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:

> On Mon, Apr 21, 2025 at 7:49=E2=80=AFAM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Sat, 19 Apr 2025 10:45:20 -0400
> > Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:
> > =20
> > > The inclinometer channels were previously defined with 14 realbits.
> > > However, the ADIS16201 datasheet states the resolution for these outp=
ut
> > > channels is 12 bits (Page 14, text description; Page 15, table 7).
> > >
> > > Correct the realbits value to 12 to accurately reflect the hardware.
> > >
> > > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> > > ---
> > > Omit fixes tag because it targets driver before it moved out of stagi=
ng. =20
> >
> > Why does that matter?  Should have a fixes tag.  Whether we chose
> > to backport the fix is a different matter. =20
> Ah ok, that makes sense.
> >
> > Otherwise looks fine to me. Reply to this thread with a fixes tag
> > and I can pick it up without needing a v2. =20
> Got it, will send shortly.
Request was just the fixes tag, not the whole patch again.

Ah well, never mind I can pick it up anyway.

Jonathan

> >
> > =20
> > > ---
> > >  drivers/iio/accel/adis16201.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16=
201.c
> > > index 982b33f6eccac..dcc8d9f2ee0f1 100644
> > > --- a/drivers/iio/accel/adis16201.c
> > > +++ b/drivers/iio/accel/adis16201.c
> > > @@ -211,9 +211,9 @@ static const struct iio_chan_spec adis16201_chann=
els[] =3D {
> > >                       BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> > >       ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC_REG, ADIS16201_SCAN_AUX_ADC=
, 0, 12),
> > >       ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT_REG, ADIS16201_SCAN_INCL=
I_X,
> > > -                     BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> > > +                     BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 12),
> > >       ADIS_INCLI_CHAN(Y, ADIS16201_YINCL_OUT_REG, ADIS16201_SCAN_INCL=
I_Y,
> > > -                     BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> > > +                     BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 12),
> > >       IIO_CHAN_SOFT_TIMESTAMP(7)
> > >  };
> > > =20
> > =20


