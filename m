Return-Path: <linux-iio+bounces-19129-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF895AA9930
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 18:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD423AE489
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 16:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76FF1F91C8;
	Mon,  5 May 2025 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBDSuu+o"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5C61A3146;
	Mon,  5 May 2025 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462843; cv=none; b=I9fHaVRyy7/Qwjo20GyBVdKWFFwxvCpVH5Z55BNalfYhA/d4noqJr3/4EBaJ2msG367sXz0+sPIJSN1rhsWM1A+962t5FhiP73ACP7D15oCM6SmJ6yWxW2cCdqF39JaEGYgy8a6Ycg1sPA9DxbXtES7QVTWH9ArYr63gk2bz/wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462843; c=relaxed/simple;
	bh=wkVVwUnc/DL/BGGX2Vc68/EgiSG24Hbd0uKeFw+/ic8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tjVMaW+CapkoBQSiQUybfboNehZziETmSwUyQ//5WNFEQU9cvQFIfievbFJZVb5ovrueMnzN9YIk8zz0xZjt4Z8/IkDvI3b9XJYXA0s8Ec84JV19J7fVm49R7QKaTUo2vQHJ0snwXINMnBzq7e+n+D385Qx1bgw818in9KXv3Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBDSuu+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413A6C4CEE4;
	Mon,  5 May 2025 16:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746462842;
	bh=wkVVwUnc/DL/BGGX2Vc68/EgiSG24Hbd0uKeFw+/ic8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WBDSuu+ofd/N4lbkFjBr1JNpOgoRXrTA6A7Smr5PBKqeP9Ru4iyvjvJsQ7/1XIKDJ
	 Ac+6HMr6vrbLRUam2Dl/8TUr+3qUWqTMRNESZjBlcigKrqZiBkd0R/dyrxYh5sx0tI
	 M4HSnBijsbvAz8xqlfXiw0eckX1f2SpFivcwqtOHqR6zT1DWtTMp63UWWU7wxjWCf2
	 dHfcIpHLLa7Ho8gQ3sakuSnu/JJSadcVhNF+sn4bA++V2dfzfR/uLXmSxmiH3aImMp
	 LIY/ss8Z77a7U8u2gtMVdzOZlPmrxoSpzuxwfAOiQ4zhCaIdDkxSllaUJBvaO1VTzL
	 u8td2+Cy1GNfQ==
Date: Mon, 5 May 2025 17:33:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Sean Nyekjaer <sean@geanix.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_icm42600: Fix temperature calculation
Message-ID: <20250505173357.28836320@jic23-huawei>
In-Reply-To: <FR3P281MB175785C1AA53950D27EE3C03CE8F2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20250502-imu-v1-1-129b8391a4e3@geanix.com>
	<20250504162841.3a3cfe8a@jic23-huawei>
	<FR3P281MB175785C1AA53950D27EE3C03CE8F2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 4 May 2025 16:46:00 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hello Sean, Jonathan,
>=20
> good catch indeed!
> This is all good for me, thanks for your fix.
>=20
> Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
>=20
Applied.
> Best regards,
> JB
>=20
> ________________________________________
> From:=C2=A0Jonathan Cameron <jic23@kernel.org>
> Sent:=C2=A0Sunday, May 4, 2025 17:28
> To:=C2=A0Sean Nyekjaer <sean@geanix.com>
> Cc:=C2=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; Lars-Pe=
ter Clausen <lars@metafoo.de>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyr=
ol@tdk.com>; Jonathan Cameron <Jonathan.Cameron@huawei.com>; linux-iio@vger=
.kernel.org <linux-iio@vger.kernel.org>; linux-kernel@vger.kernel.org <linu=
x-kernel@vger.kernel.org>
> Subject:=C2=A0Re: [PATCH] iio: imu: inv_icm42600: Fix temperature calcula=
tion
> =C2=A0
> This Message Is From an External Sender
> This message came from outside your organization.
> =C2=A0
> On Fri, 02 May 2025 11:37:26 +0200
> Sean Nyekjaer <sean@geanix.com> wrote:
>=20
> > From the documentation:
> > "offset to be added to <type>[Y]_raw prior toscaling by <type>[Y]_scale"
> > Offset should be applied before multiplying scale, so divide offset by
> > scale to make this correct.
> >=20
> > Fixes: bc3eb0207fb5 ("iio: imu: inv_icm42600: add temperature sensor su=
pport")
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com> =20
> Looks correct to me.  Given this is going to have impacts on userspace
> I'd definitely like to know Jean-Baptiste has seen it though before I app=
ly.
> So, Jean-Baptiste please take a look!
>=20
> Thanks,
>=20
> Jonathan
>=20
>=20
> > ---
> >  drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c b/drivers=
/iio/imu/inv_icm42600/inv_icm42600_temp.c
> > index 213cce1c31110e669e7191c8b42c9524c0d3e5db..91f0f381082bda3dbb95dfe=
1a38adcdc4eaf5419 100644
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
> > @@ -67,16 +67,18 @@ int inv_icm42600_temp_read_raw(struct iio_dev *indi=
o_dev,
> >  		return IIO_VAL_INT;
> >  	/*
> >  	 * T=C2=B0C =3D (temp / 132.48) + 25
> > -	 * Tm=C2=B0C =3D 1000 * ((temp * 100 / 13248) + 25)
> > +	 * Tm=C2=B0C =3D 1000 * ((temp / 132.48) + 25)
> > +	 * Tm=C2=B0C =3D 7.548309 * temp + 25000
> > +	 * Tm=C2=B0C =3D (temp + 3312) * 7.548309
> >  	 * scale: 100000 / 13248 ~=3D 7.548309
> > -	 * offset: 25000
> > +	 * offset: 3312
> >  	 */
> >  	case IIO_CHAN_INFO_SCALE:
> >  		*val =3D 7;
> >  		*val2 =3D 548309;
> >  		return IIO_VAL_INT_PLUS_MICRO;
> >  	case IIO_CHAN_INFO_OFFSET:
> > -		*val =3D 25000;
> > +		*val =3D 3312;
> >  		return IIO_VAL_INT;
> >  	default:
> >  		return -EINVAL;
> >=20
> > ---
> > base-commit: 609bc31eca06c7408e6860d8b46311ebe45c1fef
> > change-id: 20250502-imu-edc0faa6dae9
> >=20
> > Best regards, =20
>=20


