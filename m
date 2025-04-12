Return-Path: <linux-iio+bounces-17995-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF89EA86C8A
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 12:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97B5B17A914
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 10:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6C319E7ED;
	Sat, 12 Apr 2025 10:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lt3/M182"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FD028FF;
	Sat, 12 Apr 2025 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744454030; cv=none; b=mjWtnICr60MxjWPg450OTySDJ7/TOe1lU3Oqfhc5weBcbAAmxlKFGOv5ei7WzTHgxVGHqFa33wktOC8JjRZ52vH0uEfFJJnrB50P6wqqf57LuX/G7aZh5GnRBjKrmy8gPxQwKvbyV/doRnE/O8Vfhn5emG53unKoMb9s9j31Pbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744454030; c=relaxed/simple;
	bh=+PhhzIK1QIE56uYa9MoSKWYNCOfwLRwgWFjqY9gwMn8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=biKoalNiVUhUD5xPiHdBVZCfX7pe/dUJe86qm/36qMhIYG3/wOMEh7E+9wfuVEOT9fvgkYwd7kGhwZJa6la6iEIRVWKowaRL/3cMqvuMEQoK9qVTeo8iWcJl/iOaaaCYiuhCudniAqIqSljcRuzUECvnNhv6b+CmrRvjfbqKZuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lt3/M182; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DDBC4CEE3;
	Sat, 12 Apr 2025 10:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744454029;
	bh=+PhhzIK1QIE56uYa9MoSKWYNCOfwLRwgWFjqY9gwMn8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lt3/M182/kPikzhJcBSQvkO9CbtuYFLw0jTODGMciwawPRMS+eVgGyamEK8EMeaGl
	 abeaulEqpLNpKLsw8CvwwBYVM2VPbGkCPVVBN7ZvBHl0bCOoFXcDEIdI9LXNvr8bJF
	 4JfNnTdDmnMk6vT8Y4ekjUBJDxfrFNw0oXtH4LunRwuKdee1D4+h3JRWcga/pz7fFs
	 2uAvU1CtmXDyxD3JOPfN1jMrzB2Efb++OyOgwWCVSQRw8KqVf6eVYpJ4LlgL76Di+S
	 XIVLqcu/fwthCYUqkelYqe7Umo6zM+Iwsqhi1bODyuOqoIwpxj0D0mah6FD+Do8EFY
	 DZm49XVDpdZng==
Date: Sat, 12 Apr 2025 11:33:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Siddharth Menon <simeddon@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
 Michael.Hennerich@analog.com, lars@metafoo.de, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v5] iio: frequency: ad9832: Use FIELD_PREP macro to set
 bit fields
Message-ID: <20250412113340.6934a8e0@jic23-huawei>
In-Reply-To: <CAGd6pzP470VDxGoP4e_2hVXsKrJhnhbv-WgFzCq7tMX9RjOLwg@mail.gmail.com>
References: <20250330135402.105418-1-simeddon@gmail.com>
	<20250330152044.18cf81f6@jic23-huawei>
	<CAGd6pzP470VDxGoP4e_2hVXsKrJhnhbv-WgFzCq7tMX9RjOLwg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Apr 2025 01:25:52 +0530
Siddharth Menon <simeddon@gmail.com> wrote:

> On Sun, 30 Mar 2025 at 19:50, Jonathan Cameron <jic23@kernel.org> wrote:
> > > +     for (int i =3D 0; i < ARRAY_SIZE(regval_bytes); i++) {
> > > +             freq_cmd =3D (i % 2 =3D=3D 0) ? AD9832_CMD_FRE8BITSW : =
AD9832_CMD_FRE16BITSW;
> > > +
> > > +             st->freq_data[i] =3D cpu_to_be16(FIELD_PREP(AD9832_CMD_=
MSK, freq_cmd) |
> > > +                     FIELD_PREP(AD9832_ADD_MSK, addr - i) |
> > > +                     FIELD_PREP(AD9832_DAT_MSK, regval_bytes[i])); =
=20
> > Looking at the data layout here, this seems like an interesting dance t=
o fill two unrelated
> > u8 values - it's not a be16 at all.
> >
> > I'd be tempted to split the freq_data into u8s and then you will just h=
ave
> >                 st->freq_data[i][0] =3D FIELD_PREP(AD9832_CMD_MSK, freq=
_cmd) |
> >                                       FIELD_PREP(AD9832_ADD_SMK, addr -=
 i);
> > //with masks adjusted appropriately.
> >                 st->freq_data[i][1] =3D regval_bytes[i];
> > =20
>=20
> Hello Jonathan,
>=20
> I briefly went through the datasheet for the device.
> From what I understand, the device is expecting 16 bit write operations w=
here:
> - First 4 bits: Operation type (frequency/phase)
> - Next 4 bits: Destination register address
> - Last 8 bits: Data
> so these fields would need to be combined into a single 16-bit value rega=
rdless.

Hmm. That is really a documentation thing rather than anything real.
If they had been documented it as a control value of 8 bits and a data valu=
e of 8
bits then it would naturally map to an array.

>=20
> As I am unable to procure a testing unit at this time, I=E2=80=99m hesita=
nt to make
> changes that could unintentionally break the existing driver.
Sure.  It is always a bit of a risk assessment for changes like this.
I'm less nervous about breaking staging drivers than others, but we should
still do our best to not do so.  Probably not worth spinning up some emulat=
ion
for this change!

>=20
> Would it be acceptable to limit the scope of this patch to introducing
> bitfield macros and addressing the remaining feedback?
Sure.  We can perhaps revisit this suggestion in a future series.

Jonathan

>=20
> Regards,
> Siddharth Menon
>=20


