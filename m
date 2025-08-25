Return-Path: <linux-iio+bounces-23196-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC28B33B87
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 11:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F02D1B2663D
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 09:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B0A2D0C7F;
	Mon, 25 Aug 2025 09:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzI47q1O"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BAA2D29CE
	for <linux-iio@vger.kernel.org>; Mon, 25 Aug 2025 09:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756115141; cv=none; b=XpJ6kzRPENK2qVXNM4TGOm7hmMsjdn0Q+eiLquxdUOsqKjKf7WnDZ2AUxGx0Y1pDM4we7ZJD5zSm13g80g3oNfwUJKD1npDc+2m5v9S1bqBl7Nw66roxmsX63cOv0RxATgQmYvluKf4ejfc5VaRhYPIq0WmcvcB2TfS9A88lAjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756115141; c=relaxed/simple;
	bh=PK2L2poF2jJPXY/AOXZb+i05mYQZVkNzWG7dTjF9lng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j1dzEfEv4dzAyXHhhYXa3Z9uwR9lrfPyEVuVbRf1SiQ8Ha4OUwYmagiACK2ZOA1mGXxmhNINSiNw1YaoBnJxaiqpln1BOAyV4rU7jhhj5Rj/kyv0wvPSaLgvVIWpEL6L++t6NJUdRtQnVIDO0j01w1y2Nkftvyu1GJfuZlWIdnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzI47q1O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7FC2C116B1;
	Mon, 25 Aug 2025 09:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756115140;
	bh=PK2L2poF2jJPXY/AOXZb+i05mYQZVkNzWG7dTjF9lng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EzI47q1O/phi9muv8X3CR4pyalhtnNyBhqjjmqpDqMzldQN3/TUWZMsU485/5d2+B
	 TceDpHP7f0bN6Mb0ysMyBX/vDnVnKIIXBF/OwQbqb2efvl3b7OujThjrKWx76dvLUl
	 4pasdNbE2paGrpy7d4/d6SgYBhr9Kscq5J24nkWHlVvxi671MUwFCE9MRDS92QWS0E
	 +ZXsHn7gD9i3teMG5zPwuG/M3B+kJp2LIgvngUdfkvdwMECkD2DKxpM218rDlqtu7P
	 DKsWAooHodpA0Wnx9RfTBPMp0k8ZxRv38mNQr8iQwQq2UAncOIW/LDrUTRF9NpBdTj
	 4ol/0BL5P5x/Q==
Date: Mon, 25 Aug 2025 10:45:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Aleksandar Gerasimovski <Aleksandar.Gerasimovski@belden.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "marius.cristea@microchip.com" <marius.cristea@microchip.com>, Rene Straub
 <Rene.Straub@belden.com>
Subject: Re: [PATCH] iio/adc/pac1934: fix channel disable configuration
Message-ID: <20250825104533.64ef7702@jic23-huawei>
In-Reply-To: <SA1PR18MB5692ACF39BF4B1E3BC32D9549930A@SA1PR18MB5692.namprd18.prod.outlook.com>
References: <20250811130904.2481790-1-aleksandar.gerasimovski@belden.com>
	<20250816144352.53e61562@jic23-huawei>
	<SA1PR18MB5692ED633F65FF2361A30AC59931A@SA1PR18MB5692.namprd18.prod.outlook.com>
	<20250818185619.289f1ab3@jic23-huawei>
	<SA1PR18MB5692ACF39BF4B1E3BC32D9549930A@SA1PR18MB5692.namprd18.prod.outlook.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Aug 2025 08:57:40 +0000
Aleksandar Gerasimovski <Aleksandar.Gerasimovski@belden.com> wrote:

> Hi Jonathan,
>=20
> Both Rene and I was investigating the problem in first place, I come with=
 the patch afterwards.
> So, the sign would be then:
>=20
> Suggested-by: Rene Straub <mailto:rene.straub@belden.com>
> Signed-off-by: Aleksandar Gerasimovski <aleksandar.gerasimovski@belden.co=
m>
>=20
> Thanks for following up!
>=20
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> From: Jonathan Cameron <jic23@kernel.org>=20
> Sent: Monday, August 18, 2025 7:56 PM
> To: Aleksandar Gerasimovski <Aleksandar.Gerasimovski@belden.com>
> Cc: linux-iio@vger.kernel.org; marius.cristea@microchip.com; Rene Straub =
<Rene.Straub@belden.com>
> Subject: Re: [PATCH] iio/adc/pac1934: fix channel disable configuration
>=20
> On Mon, 18 Aug 2025 11:=E2=80=8A08:=E2=80=8A33 +0000 Aleksandar Gerasimov=
ski <Aleksandar.=E2=80=8AGerasimovski@=E2=80=8Abelden.=E2=80=8Acom> wrote: =
> Hi Jonathan, and sorry for the previous non-plain text message: > > Fixes=
: 0fb528c8255b (iio: adc: adding support for PAC193x)
>=20
> On Mon, 18 Aug 2025 11:08:33 +0000
> Aleksandar Gerasimovski <mailto:Aleksandar.Gerasimovski@belden.com> wrote:
>=20
> > Hi Jonathan, and sorry for the previous non-plain text message:
> >=20
> > Fixes: 0fb528c8255b (iio: adc: adding support for PAC193x) =20
> Thanks.  I noticed one more thing when I was about to queue this up..
>=20
> >=20
> > Regards,
> > Aleksandar
> >=20
> > From: Jonathan Cameron <mailto:jic23@kernel.org>=20
> > Sent: Saturday, August 16, 2025 3:44 PM
> > To: Aleksandar Gerasimovski <mailto:Aleksandar.Gerasimovski@belden.com>
> > Cc: mailto:linux-iio@vger.kernel.org; mailto:marius.cristea@microchip.c=
om; Rene Straub <mailto:Rene.Straub@belden.com>
> > Subject: Re: [PATCH] iio/adc/pac1934: fix channel disable configuration
> >=20
> > On Mon, 11 Aug 2025 13:=E2=80=8A09:=E2=80=8A04 +0000 Aleksandar Gerasim=
ovski <aleksandar.=E2=80=8Agerasimovski@=E2=80=8Abelden.=E2=80=8Acom> wrote=
: > There are two problems with the chip configuration in this driver: > - =
First, is that writing 12 bytes (ARRAY_SIZE(regs)) would
> >=20
> > On Mon, 11 Aug 2025 13:09:04 +0000
> > Aleksandar Gerasimovski <mailto:aleksandar.gerasimovski@belden.com> wro=
te:
> >  =20
> > > There are two problems with the chip configuration in this driver:
> > > - First, is that writing 12 bytes (ARRAY_SIZE(regs)) would anyhow
> > >   lead to a config overflow due to HW auto increment implementation
> > >   in the chip.
> > > - Second, the i2c_smbus_write_block_data write ends up in writing
> > >   unexpected value to the channel_dis register, this is because
> > >   the smbus size that is 0x03 in this case gets written to the
> > >   register. The PAC1931/2/3/4 data sheet does not really specify
> > >   that block write is indeed supported.
> > >=20
> > > This problem is probably not visible on PAC1934 version where all
> > > channels are used as the chip is properly configured by luck,
> > > but in our case whenusing PAC1931 this leads to nonfunctional device.
> > >=20
> > > Signed-off-by: Rene Straub <mailto:rene.straub@belden.com> =20
> This SoB chain doesn't comply with the normal requirements.
> Given the author is Aleksandar (no From in the commit, so it's the email =
sender)
> my guess is either
>=20
> a) Rene wrote the patch and the author of the commit accidentally got cha=
nged)
> b) Rene and Aleksandar both wrote the patch in which case it is missing
> Co-developed-by: Rene Straub <mailto:rene.straub@belden.com>
> here
>=20
> I can fix it up if you confirm if it was a or b or something else
>=20
> Thanks,
>=20
> Jonathan
>=20
> > > Signed-off-by: Aleksandar Gerasimovski <mailto:aleksandar.gerasimovsk=
i@belden.com>   =20
> >=20
> > Hi, Thanks for the patch.
> >=20
> > Needs a fixes tag so we know how far to back port it.
> > You can just reply with one to this thread rather than sending a new
> > version.
> >=20
> > Thanks,
> >=20
> > Jonathan
> >  =20
> > > ---
> > >  drivers/iio/adc/pac1934.c | 20 ++++++++++++++++++--
> > >  1 file changed, 18 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
> > > index 09fe88eb3fb0..2e442e46f679 100644
> > > --- a/drivers/iio/adc/pac1934.c
> > > +++ b/drivers/iio/adc/pac1934.c
> > > @@ -88,6 +88,7 @@
> > >  #define PAC1934_VPOWER_3_ADDR			0x19
> > >  #define PAC1934_VPOWER_4_ADDR			0x1A
> > >  #define PAC1934_REFRESH_V_REG_ADDR		0x1F
> > > +#define PAC1934_SLOW_REG_ADDR			0x20
> > >  #define PAC1934_CTRL_STAT_REGS_ADDR		0x1C
> > >  #define PAC1934_PID_REG_ADDR			0xFD
> > >  #define PAC1934_MID_REG_ADDR			0xFE
> > > @@ -1265,8 +1266,23 @@ static int pac1934_chip_configure(struct pac19=
34_chip_info *info)
> > >  	/* no SLOW triggered REFRESH, clear POR */
> > >  	regs[PAC1934_SLOW_REG_OFF] =3D 0;
> > > =20
> > > -	ret =3D  i2c_smbus_write_block_data(client, PAC1934_CTRL_STAT_REGS_=
ADDR,
> > > -					  ARRAY_SIZE(regs), (u8 *)regs);
> > > +	/*
> > > +	 * Write the three bytes sequentially, as the device does not suppo=
rt
> > > +	 * block write.
> > > +	 */
> > > +	ret =3D i2c_smbus_write_byte_data(client, PAC1934_CTRL_STAT_REGS_AD=
DR,
> > > +					regs[PAC1934_CHANNEL_DIS_REG_OFF]);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret =3D i2c_smbus_write_byte_data(client,
> > > +					PAC1934_CTRL_STAT_REGS_ADDR + PAC1934_NEG_PWR_REG_OFF,
> > > +					regs[PAC1934_NEG_PWR_REG_OFF]);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret =3D i2c_smbus_write_byte_data(client, PAC1934_SLOW_REG_ADDR,
> > > +					regs[PAC1934_SLOW_REG_OFF]);
> > >  	if (ret)
> > >  		return ret;
> > >     =20
> >=20
> > **********************************************************************
> > DISCLAIMER:
> > Privileged and/or Confidential information may be contained in this mes=
sage. If you are not the addressee of this message, you may not copy, use o=
r deliver this message to anyone. In such event, you should destroy the mes=
sage and kindly notify the sender by reply e-mail. It is understood that op=
inions or conclusions that do not relate to the official business of the co=
mpany are neither given nor endorsed by the company. Thank You. =20
>=20
> **********************************************************************
> DISCLAIMER:
> Privileged and/or Confidential information may be contained in this messa=
ge. If you are not the addressee of this message, you may not copy, use or =
deliver this message to anyone. In such event, you should destroy the messa=
ge and kindly notify the sender by reply e-mail. It is understood that opin=
ions or conclusions that do not relate to the official business of the comp=
any are neither given nor endorsed by the company. Thank You.
>=20


