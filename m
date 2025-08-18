Return-Path: <linux-iio+bounces-22935-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41178B2AFD1
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 19:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A4E563CA6
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 17:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B874E2773F6;
	Mon, 18 Aug 2025 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/NKp/zM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D4D26E70E
	for <linux-iio@vger.kernel.org>; Mon, 18 Aug 2025 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755539786; cv=none; b=JLXDZ5Id3293/tzeiTzmNDerBosnYqdhMYZT6MI26DUGO886WsjCteRZTuzB7RO+AANBfM+a/aXjA+WDJoEpvGNd7h7fvMUDA5i5K17166wnIRyJkIRC28lXhPch2uRJZyT6q/3CTXVVZU/r8VQhCn5Wg8toYD3EeFHE4ytWmSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755539786; c=relaxed/simple;
	bh=VNL8Jf3o1NIc1kRCZlsumE+jHazxKYzVQ90POSIKrZg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SE1Cg/aIonsc8fs+whlsRxJ7O+zElr51kAAlRuNnr37jsOzIPMYAanLMU6pDAnl834RdbFPxg1jeec49TMkKnEXd8+SVXcdUDQPv1At3M2BIWsjauf1o+qrrmhYzmC1G+XcEH2ybX5NrnLjOVnBsMgbs9nctt8zQjO7thr+zXlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/NKp/zM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CCAC4CEEB;
	Mon, 18 Aug 2025 17:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755539786;
	bh=VNL8Jf3o1NIc1kRCZlsumE+jHazxKYzVQ90POSIKrZg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d/NKp/zMYDVoLtjwf8Lpo1R9g+TsP86CcXRUv+Gh6qHHa3KbHxIeudREqGyI3Ioaj
	 g1d/PYxUK3YumwDzfcCmKUZhqS8MpywuhTQeDp0X+0IJT+MCrXzMleS4p5bpoQBGzo
	 p4P7oFkFFOV/gyjqavGReIaAiBGn7shxD8GYLCFQga2xxKYQO1L3VkEGdSFXsXhkNc
	 mb0aurSt/XVaHXEPiGmwwTWOI5/E2AEGwbUq3ha10jVAv1yIyLbRVcmTWZdQ9etTEH
	 VjLDsk/M2meZ06nNeLKL6MXiTle/MCxCCn66H0/r8AS+Tknfe8iUv4mMFmhjxQFiWc
	 uxnnS0RNmo2xg==
Date: Mon, 18 Aug 2025 18:56:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Aleksandar Gerasimovski <Aleksandar.Gerasimovski@belden.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "marius.cristea@microchip.com" <marius.cristea@microchip.com>, Rene Straub
 <Rene.Straub@belden.com>
Subject: Re: [PATCH] iio/adc/pac1934: fix channel disable configuration
Message-ID: <20250818185619.289f1ab3@jic23-huawei>
In-Reply-To: <SA1PR18MB5692ED633F65FF2361A30AC59931A@SA1PR18MB5692.namprd18.prod.outlook.com>
References: <20250811130904.2481790-1-aleksandar.gerasimovski@belden.com>
	<20250816144352.53e61562@jic23-huawei>
	<SA1PR18MB5692ED633F65FF2361A30AC59931A@SA1PR18MB5692.namprd18.prod.outlook.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 18 Aug 2025 11:08:33 +0000
Aleksandar Gerasimovski <Aleksandar.Gerasimovski@belden.com> wrote:

> Hi Jonathan, and sorry for the previous non-plain text message:
>=20
> Fixes: 0fb528c8255b (iio: adc: adding support for PAC193x)
Thanks.  I noticed one more thing when I was about to queue this up..

>=20
> Regards,
> Aleksandar
>=20
> From: Jonathan Cameron <jic23@kernel.org>=20
> Sent: Saturday, August 16, 2025 3:44 PM
> To: Aleksandar Gerasimovski <Aleksandar.Gerasimovski@belden.com>
> Cc: linux-iio@vger.kernel.org; marius.cristea@microchip.com; Rene Straub =
<Rene.Straub@belden.com>
> Subject: Re: [PATCH] iio/adc/pac1934: fix channel disable configuration
>=20
> On Mon, 11 Aug 2025 13:=E2=80=8A09:=E2=80=8A04 +0000 Aleksandar Gerasimov=
ski <aleksandar.=E2=80=8Agerasimovski@=E2=80=8Abelden.=E2=80=8Acom> wrote: =
> There are two problems with the chip configuration in this driver: > - Fi=
rst, is that writing 12 bytes (ARRAY_SIZE(regs)) would
>=20
> On Mon, 11 Aug 2025 13:09:04 +0000
> Aleksandar Gerasimovski <mailto:aleksandar.gerasimovski@belden.com> wrote:
>=20
> > There are two problems with the chip configuration in this driver:
> > - First, is that writing 12 bytes (ARRAY_SIZE(regs)) would anyhow
> >   lead to a config overflow due to HW auto increment implementation
> >   in the chip.
> > - Second, the i2c_smbus_write_block_data write ends up in writing
> >   unexpected value to the channel_dis register, this is because
> >   the smbus size that is 0x03 in this case gets written to the
> >   register. The PAC1931/2/3/4 data sheet does not really specify
> >   that block write is indeed supported.
> >=20
> > This problem is probably not visible on PAC1934 version where all
> > channels are used as the chip is properly configured by luck,
> > but in our case whenusing PAC1931 this leads to nonfunctional device.
> >=20
> > Signed-off-by: Rene Straub <mailto:rene.straub@belden.com>
This SoB chain doesn't comply with the normal requirements.
Given the author is Aleksandar (no From in the commit, so it's the email se=
nder)
my guess is either

a) Rene wrote the patch and the author of the commit accidentally got chang=
ed)
b) Rene and Aleksandar both wrote the patch in which case it is missing
Co-developed-by: Rene Straub <mailto:rene.straub@belden.com>
here

I can fix it up if you confirm if it was a or b or something else

Thanks,

Jonathan

> > Signed-off-by: Aleksandar Gerasimovski <mailto:aleksandar.gerasimovski@=
belden.com> =20
>=20
> Hi, Thanks for the patch.
>=20
> Needs a fixes tag so we know how far to back port it.
> You can just reply with one to this thread rather than sending a new
> version.
>=20
> Thanks,
>=20
> Jonathan
>=20
> > ---
> >  drivers/iio/adc/pac1934.c | 20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
> > index 09fe88eb3fb0..2e442e46f679 100644
> > --- a/drivers/iio/adc/pac1934.c
> > +++ b/drivers/iio/adc/pac1934.c
> > @@ -88,6 +88,7 @@
> >  #define PAC1934_VPOWER_3_ADDR			0x19
> >  #define PAC1934_VPOWER_4_ADDR			0x1A
> >  #define PAC1934_REFRESH_V_REG_ADDR		0x1F
> > +#define PAC1934_SLOW_REG_ADDR			0x20
> >  #define PAC1934_CTRL_STAT_REGS_ADDR		0x1C
> >  #define PAC1934_PID_REG_ADDR			0xFD
> >  #define PAC1934_MID_REG_ADDR			0xFE
> > @@ -1265,8 +1266,23 @@ static int pac1934_chip_configure(struct pac1934=
_chip_info *info)
> >  	/* no SLOW triggered REFRESH, clear POR */
> >  	regs[PAC1934_SLOW_REG_OFF] =3D 0;
> > =20
> > -	ret =3D  i2c_smbus_write_block_data(client, PAC1934_CTRL_STAT_REGS_AD=
DR,
> > -					  ARRAY_SIZE(regs), (u8 *)regs);
> > +	/*
> > +	 * Write the three bytes sequentially, as the device does not support
> > +	 * block write.
> > +	 */
> > +	ret =3D i2c_smbus_write_byte_data(client, PAC1934_CTRL_STAT_REGS_ADDR,
> > +					regs[PAC1934_CHANNEL_DIS_REG_OFF]);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D i2c_smbus_write_byte_data(client,
> > +					PAC1934_CTRL_STAT_REGS_ADDR + PAC1934_NEG_PWR_REG_OFF,
> > +					regs[PAC1934_NEG_PWR_REG_OFF]);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D i2c_smbus_write_byte_data(client, PAC1934_SLOW_REG_ADDR,
> > +					regs[PAC1934_SLOW_REG_OFF]);
> >  	if (ret)
> >  		return ret;
> >   =20
>=20
> **********************************************************************
> DISCLAIMER:
> Privileged and/or Confidential information may be contained in this messa=
ge. If you are not the addressee of this message, you may not copy, use or =
deliver this message to anyone. In such event, you should destroy the messa=
ge and kindly notify the sender by reply e-mail. It is understood that opin=
ions or conclusions that do not relate to the official business of the comp=
any are neither given nor endorsed by the company. Thank You.


