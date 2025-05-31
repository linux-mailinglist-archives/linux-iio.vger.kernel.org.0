Return-Path: <linux-iio+bounces-20065-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD6DAC9B6B
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 17:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C79418978B7
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 15:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174E423BCFA;
	Sat, 31 May 2025 15:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnB57EgA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC479288CC
	for <linux-iio@vger.kernel.org>; Sat, 31 May 2025 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748704094; cv=none; b=LFyDRF+2yWXxkzpour/c4P8XXE45BbdGfPtSELaaQQ7YhLiruCXyPwdBcczea4dqZ/2jiHKLKQI+z6+OjQpgFEDAWBleIChXNNPExp0EpPWBlySOeR0dyi4lQGoTS+llonmsZvBpvkHYmZVtPDrq4kDjraC914qOKT7vf8H5Hlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748704094; c=relaxed/simple;
	bh=A1aSkNpgvJH7MwLNrRyTjZEkImFfIg89CAQuN3YyUcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=byZdB6RPfPrfVbv8EMaRSv3qp2bul4JK8rOMSVSt2FMbdODN4qHSYFEAmmm+hBiB+xwyAuLpacC+/PGc8BdLrS7a74FDamZcBEdgmfOGuVKstq6+lANQMJL6JJonlKzKuGN5zjMkaZK3WeqAVJagPybSNPfABWGLQrQT42w2ioc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnB57EgA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E329C4CEEE;
	Sat, 31 May 2025 15:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748704094;
	bh=A1aSkNpgvJH7MwLNrRyTjZEkImFfIg89CAQuN3YyUcQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SnB57EgAoJbiNsCAVHGyCY/b7fV2V1+LCsSo/fCXTz8PBLaIJu8hqx9Qp3WWDSBdE
	 2h6IeQWJeZUcp0FSglQ+zITDsJS2Kx/PncQnXeNcZxT9VuqJJXR/wIFoG5N9uPSstA
	 +WcMwW2NWw+S5tnLtiKeDAKcx391nKHNVqczP2iS4K4g9PTISS/b9WtSMVYlCLW1+w
	 Ws9ywx6RJA3KxKoBMA0L96QQFmnFOtoVhI3r4N5KzrBA+CIZEySWaDgF9QitCXM/Tn
	 hYirr97c+wTn4ZBCkuUfIboe2vmkRP1qgsXCdzHxxsphiBDH8lN/43Uc3atT2C/1PW
	 OKLVH0TeKnkGw==
Date: Sat, 31 May 2025 16:08:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Isabella Caselli
 <bellacaselli20@gmail.com>, "lars@metafoo.de" <lars@metafoo.de>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "rodrigo.michelassi@usp.br" <rodrigo.michelassi@usp.br>
Subject: Re: [PATCH v3] iio: imu: inv_mpu6050: refactor aux read/write to
 use shared xfer logic
Message-ID: <20250531160807.39e54096@jic23-huawei>
In-Reply-To: <FR3P281MB17579EB44065673FC14F049CCE64A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20250507184539.54658-1-bellacaselli20@gmail.com>
	<aB-dZecEekMsAEWj@debian-BULLSEYE-live-builder-AMD64>
	<20250515174711.78457e4b@jic23-huawei>
	<20250525182345.351ec4cf@jic23-huawei>
	<FR3P281MB17579EB44065673FC14F049CCE64A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 27 May 2025 09:53:41 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hello Jonathan,
>=20
> sorry for the delay.
>=20
> It looks good like that. It is OK for me.
>=20
> Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Applied to the testing branch of iio.git.  I'll be rebasing that on rc1
once available and pushing out for linux-next to pick up at that time.

hanks

Jonathan
>=20
> Thanks,
> JB
>=20
> ________________________________________
> From:=C2=A0Jonathan Cameron <jic23@kernel.org>
> Sent:=C2=A0Sunday, May 25, 2025 19:23
> To:=C2=A0Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Cc:=C2=A0Isabella Caselli <bellacaselli20@gmail.com>; Jean-Baptiste Maney=
rol <Jean-Baptiste.Maneyrol@tdk.com>; lars@metafoo.de <lars@metafoo.de>; li=
nux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; rodrigo.michelassi@usp=
.br <rodrigo.michelassi@usp.br>
> Subject:=C2=A0Re: [PATCH v3] iio: imu: inv_mpu6050: refactor aux read/wri=
te to use shared xfer logic
> =C2=A0
> This Message Is From an External Sender
> This message came from outside your organization.
> =C2=A0
> On Thu, 15 May 2025 17:47:11 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>=20
> > On Sat, 10 May 2025 15:39:33 -0300
> > Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> >  =20
> > > Hi Isabella, Rodrigo,
> > >=20
> > > This patch looks okay to me. Though, I think Jean-Baptiste made a val=
id point in
> > > v1 about inv_mpu_i2c_master_xfer() not implying any specific slave sl=
ot
> > > previously. I'd suggest to add a slv parameter to inv_mpu_i2c_master_=
xfer(), but
> > > that wouldn't make much difference since inv_mpu_aux_read/write() are=
 still
> > > hardcoded for SLV 0.
> > > Besides that, I have one minor comment that's probably not a reason f=
or a v4 if
> > > this is deemed to be good.   =20
> >=20
> > I'm looking for a tag from Jean-Baptiste on this. =20
>=20
> Jean-Baptiste. If you have time to look at this version that would be gre=
at.
>=20
> >=20
> > Jonathan
> >  =20
> > >=20
> > > Regards,
> > > Marcelo
> > >=20
> > > On 05/07, Isabella Caselli wrote:   =20
> > > > Refactors inv_mpu_aux_read() and inv_mpu_aux_write() to extract the=
 common
> > > > I2C transfer sequence into inv_mpu_i2c_master_xfer(), which now han=
dles
> > > > starting and stopping the I2C master, waiting for completion, disab=
ling
> > > > SLV0, and checking for NACK errors.
> > > >=20
> > > > This refactoring removes code duplication and improves maintainabil=
ity.
> > > > No functional changes are intended.
> > > >=20
> > > > Signed-off-by: Isabella Caselli <bellacaselli20@gmail.com>
> > > > Co-developed-by: Rodrigo Michelassi <rodrigo.michelassi@usp.br>
> > > > Signed-off-by: Rodrigo Michelassi <rodrigo.michelassi@usp.br>
> > > > ---     =20
> > > ...   =20
> > > >  static int inv_mpu_i2c_master_xfer(const struct inv_mpu6050_state =
*st)
> > > >  {
> > > > @@ -23,6 +25,7 @@ static int inv_mpu_i2c_master_xfer(const struct i=
nv_mpu6050_state *st)
> > > >  	uint8_t d;
> > > >  	unsigned int user_ctrl;
> > > >  	int ret;
> > > > +	unsigned int status;     =20
> > > I'd declare status above ret, or together with user_ctrl.
> > > Just minor code style thing.   =20
> >=20
> >  =20
>=20


