Return-Path: <linux-iio+bounces-8544-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9754595585D
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 16:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5EB11C20D89
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 14:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A9A8F7D;
	Sat, 17 Aug 2024 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9/twBY+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57BC5256;
	Sat, 17 Aug 2024 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723905159; cv=none; b=IItNnotXUM/l2hCWTPi8dU4uNLWgcZiXUEtWXXnkMVlX8gkvMgK3xJVhOchHb6G+d0tSlhw6gfDGC5uTU3I60n66DkklgNFGqvoU4rhON7HhdAaMGz7x1GtODxN3/J7JVw7fGRcXz4wQx4JCPCYjSBKpBy5Gi78zYutf2D2TXfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723905159; c=relaxed/simple;
	bh=KeeJw6lp938OS52VfB4l8R9QZxnPCMXS1Dxz7dWCZ2E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ITLjCgj+OBPq57j6JJabfSTBgQlGXlDihJa3vlghvoWZp+1yczHyO8hjVr9szonrLjA+rB3l0tEpIVOAHAZ2Ki5tFHJQJqMh+88dV7peMU3/agx8K91s2icIhlzmMx0fIV/5iHSnnGdIokXJR7luKE8dSm2p73uu8l8yB2LK9cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9/twBY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46F2C116B1;
	Sat, 17 Aug 2024 14:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723905158;
	bh=KeeJw6lp938OS52VfB4l8R9QZxnPCMXS1Dxz7dWCZ2E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s9/twBY+PtXR4GO4nQ+BMuH1SqKGHMH4O/fBki/MP5Y5EGKNWYMzM7mJ6srC4i+0x
	 1YJ0t0HdrJ+MZhwdoGUUtW2LQgeP2Afc94MqxPpVTtXC0Et0JKK3Dx604ZRMCX5IxK
	 OKOlOmvjBrd0zlzQb9LcgN4ZWWSL+NS2d7Rux2rByeiYUAkXu4RRdHa/5GlUOuMgTB
	 Pfc4z7ScvMVGms9ZjVLZ50ZosUGZH0iafazis57jdYtS4q/lHLBPbr5U2tOT9Sf+RM
	 prMklzXS8F2TJt3TSo7qk7+BHjIeEa/Ok1gZygu0n7wUH/lz2MuyCn9Tlwk722cF1m
	 cPOB1i1uo13LA==
Date: Sat, 17 Aug 2024 15:32:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: inv.git-commit@tdk.com, lars@metafoo.de, linux-iio@vger.kernel.org,
 stable@vger.kernel.org, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: fix interrupt status read for
 old buggy chips
Message-ID: <20240817153231.4c410154@jic23-huawei>
In-Reply-To: <045f7e8a-d462-4419-8e7b-c06857d2338f@gmail.com>
References: <20240814143735.327302-1-inv.git-commit@tdk.com>
	<045f7e8a-d462-4419-8e7b-c06857d2338f@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Aug 2024 18:50:43 +0300
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> 14.08.24 5:37 =D0=BF=D0=BF, inv.git-commit@tdk.com:
> > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> >
> > Interrupt status read seems to be broken on some old MPU-6050 like
> > chips. Fix by reverting to previous driver behavior bypassing interrupt
> > status read. This is working because these chips are not supporting
> > WoM and data ready is the only interrupt source.
> >
> > Fixes: 5537f653d9be ("iio: imu: inv_mpu6050: add new interrupt handler =
for WoM events")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com> =
=20
> Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # LG P880
>=20
> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # LG P895
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

>=20
> > ---
> >   drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 13 +++++++++++--
> >   1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/ii=
o/imu/inv_mpu6050/inv_mpu_trigger.c
> > index 84273660ca2e..3bfeabab0ec4 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > @@ -248,12 +248,20 @@ static irqreturn_t inv_mpu6050_interrupt_handle(i=
nt irq, void *p)
> >   	int result;
> >
> >   	switch (st->chip_type) {
> > +	case INV_MPU6000:
> >   	case INV_MPU6050:
> > +	case INV_MPU9150:
> > +		/*
> > +		 * WoM is not supported and interrupt status read seems to be broken=
 for
> > +		 * some chips. Since data ready is the only interrupt, bypass interr=
upt
> > +		 * status read and always assert data ready bit.
> > +		 */
> > +		wom_bits =3D 0;
> > +		int_status =3D INV_MPU6050_BIT_RAW_DATA_RDY_INT;
> > +		goto data_ready_interrupt;
> >   	case INV_MPU6500:
> >   	case INV_MPU6515:
> >   	case INV_MPU6880:
> > -	case INV_MPU6000:
> > -	case INV_MPU9150:
> >   	case INV_MPU9250:
> >   	case INV_MPU9255:
> >   		wom_bits =3D INV_MPU6500_BIT_WOM_INT;
> > @@ -279,6 +287,7 @@ static irqreturn_t inv_mpu6050_interrupt_handle(int=
 irq, void *p)
> >   		}
> >   	}
> >
> > +data_ready_interrupt:
> >   	/* handle raw data interrupt */
> >   	if (int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT) {
> >   		indio_dev->pollfunc->timestamp =3D st->it_timestamp;
> > --
> > 2.34.1
> > =20


