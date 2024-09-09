Return-Path: <linux-iio+bounces-9363-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01958970FF2
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 09:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D30281220
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 07:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552C01AF4DC;
	Mon,  9 Sep 2024 07:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBmEiOuq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105961AE856;
	Mon,  9 Sep 2024 07:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725867340; cv=none; b=N0j5mvPVd5P6UpffdI65rHNamQMB+GJME8NaITf8ZUnui0Vv7ge6YDm6ZeTRgVX5M3qbQBVGmVknUAG8zm+L/UL7kGblK2ZcyohT8sP68dPyw/xtTVk9JQbZFQmoJTQGXIK3JIsvp3G3R3KRVyc/+r2uRF9n34THcGoHk0GTGUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725867340; c=relaxed/simple;
	bh=sZQ1ENMLvpyFT3RPVVOSVSec1mz43owuiOBScJQ7TFA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T0fkUQ+pESMz03qAsf2gMZ77Dc+mTjKOCG3nkqupw9Mp7V52Q/ufW5QITwKVdDPTxk9xpbAHQsTMNca+9cQY82v0PeNMLq7vJoewI06l0PGa1bYipPwgEoyCzGx+tklSzkt+tEjnfpeL3VYDLZ1SYtqxZMF/RDYxnQ7D6YmqCNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBmEiOuq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969AFC4CECA;
	Mon,  9 Sep 2024 07:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725867339;
	bh=sZQ1ENMLvpyFT3RPVVOSVSec1mz43owuiOBScJQ7TFA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iBmEiOuq+Tb9WPFknk5HT7FFPiJzFxqXirFzbbIMNWDHLaVq5vzt9aqqwYYUzGjHt
	 5RCVzBMIogAg5oOdKeeiyuTejbjiEGhw0JaPsrxWGd+FCNLWLK/QYoe99q6J2ikP72
	 7q2EIQxxIxkrx+1zZQLfaJoLrVljy+dk6gH2QaUJvdzwhC3MPsPNK8LRCrflFpwe0v
	 ZhW42vZHBiJYGg/tDqXVPPx/xHo7en3w8gTGZ1hK5XmsPl9fNE84fuSe9YzkF0rcnV
	 oygUluZTfYx9tOB5K+wk0jxUcPDpHQDExKjcoRh7TuI6yhBKqP2W7UDrsM63ZuXgfl
	 azJadC/FZLCtw==
Date: Mon, 9 Sep 2024 08:35:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: jason liu <jasonliu10041728@gmail.com>
Cc: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>,
 "lars@metafoo.de" <lars@metafoo.de>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: =?UTF-8?B?5Zue5aSNOiDlm57lpI06?= [PATCH] iio/inv_icm42600: add
 inv_icm42600 id_table
Message-ID: <20240909083504.605e9ca7@jic23-huawei>
In-Reply-To: <SI6PR01MB63194A7F2D2FD7701DD0465BF5992@SI6PR01MB6319.apcprd01.prod.exchangelabs.com>
References: <FR3P281MB175720831E0817C23AD0B1BACE922@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
	<20240902113101.3135-1-jasonliu10041728@gmail.com>
	<CAJci1vC9pvdqEpA8sk+uB5jJGn_DKUruXFfY6tbG9mO07YxgHQ@mail.gmail.com>
	<FR3P281MB1757BEA60FF72A44847F1646CE9D2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
	<SI6PR01MB63197238674C8895885420D8F59E2@SI6PR01MB6319.apcprd01.prod.exchangelabs.com>
	<20240908115115.1bf1155d@jic23-huawei>
	<SI6PR01MB63194A7F2D2FD7701DD0465BF5992@SI6PR01MB6319.apcprd01.prod.exchangelabs.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Sep 2024 06:43:47 +0000
jason liu <jasonliu10041728@gmail.com> wrote:

> Hi Jonathan,
>=20
> > Hi Jason, =20
>=20
> > I've picked this up, but the patch submission has a number of issues
> > you should be sure to fix in future patches.
> > =20
> I am sorry for the issues, and I will keep your suggestions in mind.
> So, do I still need to submit a new patch to fix these issues?
No need,.
> My understanding is that since you've picked it up, there's no need for m=
e to resubmit.
> Is it right?

Yes that's right.

>=20
> > I haven't treated this as a fix because it was never there, but
> > it may make sense to request a backport to stable after it is upstream.
> > =20
> Sorry, I didn=E2=80=99t quite understand what you meant.
> Why did you say 'it was never there'? Do you mean that this issue doesn't=
 exist?

The autoprobing never worked, hence this is an improvement not a regression.
As such I've not rushed it in as a fix, but instead it can take a slower
path upstream.

Jonathan

>=20
> Thanks,
>=20
> Jason
>=20
> ________________________________________
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, September 8, 2024 6:51 PM
> To: jason liu
> Cc: Jean-Baptiste Maneyrol; lars@metafoo.de; linux-iio@vger.kernel.org; l=
inux-kernel@vger.kernel.org
> Subject: Re: =E5=9B=9E=E5=A4=8D: [PATCH] iio/inv_icm42600: add inv_icm426=
00 id_table
>=20
> On Fri, 6 Sep 2024 05:02:59 +0000
> jason liu <jasonliu10041728@gmail.com> wrote:
>=20
> > Hello,
> >
> > I'm glad this patch could help. And I would like to know, how will the =
patch to be handled moving forward?
> > =20
> It is queued up on the IIO tree.  Given timing it's queued for 6.13.
> Note that for now that is only pushed out as testing because I will
> be rebasing the IIO togreg branch on 6.12-rc1.
> One that is done it will appear in linux-next.
>=20
> It should go upstream and appear in char-misc/char-misc-next
> in about 6 weeks.  After that Greg KH will send a pull request during
> the 6.13 merge window in about 12 weeks time and it will then hopefully
> get merged into Linus' tree before 6.13-rc1
>=20
> I haven't treated this as a fix because it was never there, but
> it may make sense to request a backport to stable after it is upstream.
>=20
> Thanks,
>=20
> Jonathan
>=20
> > Thanks.
> >
> > ________________________________
> > From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> > Sent: Thursday, September 5, 2024 5:25 PM
> > To: jason liu <jasonliu10041728@gmail.com>
> > Cc: jic23@kernel.org <jic23@kernel.org>; lars@metafoo.de <lars@metafoo.=
de>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; linux-kernel@vg=
er.kernel.org <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH] iio/inv_icm42600: add inv_icm42600 id_table
> >
> > Hello,
> >
> > looks good for me now, thanks for the patch.
> >
> > Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> >
> > Thanks,
> > JB
> >
> > ________________________________________
> > From: jason liu <jasonliu10041728@gmail.com>
> > Sent: Wednesday, September 4, 2024 11:00
> > To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> > Cc: jic23@kernel.org <jic23@kernel.org>; lars@metafoo.de <lars@metafoo.=
de>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; linux-kernel@vg=
er.kernel.org <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH] iio/inv_icm42600: add inv_icm42600 id_table
> >
> > This Message Is From an Untrusted Sender
> > You have not previously corresponded with this sender.
> >
> > Hello, does patch v3 meet the requirements?
> >
> > BR.
> >
> > Jason Liu <jasonliu10041728@gmail.com> =E4=BA=8E2024=E5=B9=B49=E6=9C=88=
2=E6=97=A5=E5=91=A8=E4=B8=80 19:31=E5=86=99=E9=81=93=EF=BC=9A
> > Add the id_table of inv_icm42600, so the device can probe correctly.
> >
> > Signed-off-by: Jason Liu <jasonliu10041728@gmail.com>
> > ---
> > V1->V2: fix up the formatting as requested
> > ---
> > V2->V3: add icm42686 (INV_ICM_42686) and icm42688 (INV_ICM_42688)
> > ---
> >  drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c | 17 +++++++++++++++++
> >  drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c | 17 +++++++++++++++++
> >  2 files changed, 34 insertions(+)
> >
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/=
iio/imu/inv_icm42600/inv_icm42600_i2c.c
> > index ebb31b385881..9e65fef04c39 100644
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> > @@ -71,6 +71,22 @@ static int inv_icm42600_probe(struct i2c_client *cli=
ent)
> >                                        inv_icm42600_i2c_bus_setup);
> >  }
> >
> > +/*
> > + * device id table is used to identify what device can be
> > + * supported by this driver
> > + */
> > +static const struct i2c_device_id inv_icm42600_id[] =3D {
> > +       { "icm42600", INV_CHIP_ICM42600 },
> > +       { "icm42602", INV_CHIP_ICM42602 },
> > +       { "icm42605", INV_CHIP_ICM42605 },
> > +       { "icm42686", INV_CHIP_ICM42686 },
> > +       { "icm42622", INV_CHIP_ICM42622 },
> > +       { "icm42688", INV_CHIP_ICM42688 },
> > +       { "icm42631", INV_CHIP_ICM42631 },
> > +       {}
> > +};
> > +MODULE_DEVICE_TABLE(i2c, inv_icm42600_id);
> > +
> >  static const struct of_device_id inv_icm42600_of_matches[] =3D {
> >         {
> >                 .compatible =3D "invensense,icm42600",
> > @@ -104,6 +120,7 @@ static struct i2c_driver inv_icm42600_driver =3D {
> >                 .of_match_table =3D inv_icm42600_of_matches,
> >                 .pm =3D pm_ptr(&inv_icm42600_pm_ops),
> >         },
> > +       .id_table =3D inv_icm42600_id,
> >         .probe =3D inv_icm42600_probe,
> >  };
> >  module_i2c_driver(inv_icm42600_driver);
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/=
iio/imu/inv_icm42600/inv_icm42600_spi.c
> > index eae5ff7a3cc1..75441b2be174 100644
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
> > @@ -67,6 +67,22 @@ static int inv_icm42600_probe(struct spi_device *spi)
> >                                        inv_icm42600_spi_bus_setup);
> >  }
> >
> > +/*
> > + * device id table is used to identify what device can be
> > + * supported by this driver
> > + */
> > +static const struct spi_device_id inv_icm42600_id[] =3D {
> > +       { "icm42600", INV_CHIP_ICM42600 },
> > +       { "icm42602", INV_CHIP_ICM42602 },
> > +       { "icm42605", INV_CHIP_ICM42605 },
> > +       { "icm42686", INV_CHIP_ICM42686 },
> > +       { "icm42622", INV_CHIP_ICM42622 },
> > +       { "icm42688", INV_CHIP_ICM42688 },
> > +       { "icm42631", INV_CHIP_ICM42631 },
> > +       {}
> > +};
> > +MODULE_DEVICE_TABLE(spi, inv_icm42600_id);
> > +
> >  static const struct of_device_id inv_icm42600_of_matches[] =3D {
> >         {
> >                 .compatible =3D "invensense,icm42600",
> > @@ -100,6 +116,7 @@ static struct spi_driver inv_icm42600_driver =3D {
> >                 .of_match_table =3D inv_icm42600_of_matches,
> >                 .pm =3D pm_ptr(&inv_icm42600_pm_ops),
> >         },
> > +       .id_table =3D inv_icm42600_id,
> >         .probe =3D inv_icm42600_probe,
> >  };
> >  module_spi_driver(inv_icm42600_driver);
> > --
> > 2.25.1 =20
>=20


