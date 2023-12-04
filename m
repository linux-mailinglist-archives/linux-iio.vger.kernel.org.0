Return-Path: <linux-iio+bounces-561-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59924802F73
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 10:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0A91C20998
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 09:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FE81DFD6;
	Mon,  4 Dec 2023 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFezLCDk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2471CA9F
	for <linux-iio@vger.kernel.org>; Mon,  4 Dec 2023 09:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63470C433C8;
	Mon,  4 Dec 2023 09:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701683895;
	bh=ihh/zNt/BcEhlFzcMCrgtAmiDQFvuUe3HaR0qaOdUcI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IFezLCDkaGfv/RR45l2MLt4E9u5OK4wxAQXzH3klP9cNSksCluV1K0S6htiPbKinC
	 AjSs/uyhOHQDDp2FDO2jxO4H41+JukFwtqYtRpyYGnS87ktNnfiURxcivCuIWxZ8lo
	 W7dj83vPmkrXRC0I9saPzUOmV53XR/3uxBkSqKJrssPUNspM//kFuUSC2I4T/fqr9F
	 N1EJX8aNXdbTi6nbNvMRrdnykMJa3X17kpH7BRwyOrAbMCFJN32UhbpOAP0ihsmRAk
	 Sr2UmUluaqj9c0w1q4mvZ2QTdWalm74EIZTUPps5OVXe1DDh3mLveATzecHVRr19ZD
	 n/nHLLO88Kalg==
Date: Mon, 4 Dec 2023 09:58:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Bough Chen <haibo.chen@nxp.com>
Cc: "lars@metafoo.de" <lars@metafoo.de>, "shawnguo@kernel.org"
 <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
 <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: imx93: add four channels for imx93 adc
Message-ID: <20231204095807.492ae925@jic23-huawei>
In-Reply-To: <DB7PR04MB401023D016E11C44699310D090BDA@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20231116071026.611269-1-haibo.chen@nxp.com>
	<20231126160312.2ef8a307@jic23-huawei>
	<DB7PR04MB401023D016E11C44699310D090BDA@DB7PR04MB4010.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Nov 2023 02:47:31 +0000
Bough Chen <haibo.chen@nxp.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: 2023=E5=B9=B411=E6=9C=8827=E6=97=A5 0:03
> > To: Bough Chen <haibo.chen@nxp.com>
> > Cc: lars@metafoo.de; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx
> > <linux-imx@nxp.com>; linux-iio@vger.kernel.org
> > Subject: Re: [PATCH] iio: adc: imx93: add four channels for imx93 adc
> >=20
> > On Thu, 16 Nov 2023 15:10:26 +0800
> > haibo.chen@nxp.com wrote:
> >  =20
> > > From: Haibo Chen <haibo.chen@nxp.com>
> > >
> > > According to the spec, this ADC totally support 8 channels.
> > > i.MX93 contain this ADC with 4 channels connected to pins in the
> > > package. i.MX95 contain this ADC with 8 channels connected to pins in
> > > the package.
> > >
> > > Signed-off-by: Haibo Chen <haibo.chen@nxp.com> =20
> > Should I treat this as a fix?
> >=20
> > If so could you reply with a fixes tag please =20
>=20
> Yes, please help add:
> Fixes: 7d02296ac8b8 ("iio: adc: add imx93 adc support")
Applied.  Thanks,

Jonathan

>=20
> Thanks
> Haibo Chen
> >=20
> > Thanks,
> >=20
> > Jonathan
> >  =20
> > > ---
> > >  drivers/iio/adc/imx93_adc.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/iio/adc/imx93_adc.c b/drivers/iio/adc/imx93_adc.c
> > > index 9bb1e4ba1aee..4ccf4819f1f1 100644
> > > --- a/drivers/iio/adc/imx93_adc.c
> > > +++ b/drivers/iio/adc/imx93_adc.c
> > > @@ -93,6 +93,10 @@ static const struct iio_chan_spec =20
> > imx93_adc_iio_channels[] =3D { =20
> > >  	IMX93_ADC_CHAN(1),
> > >  	IMX93_ADC_CHAN(2),
> > >  	IMX93_ADC_CHAN(3),
> > > +	IMX93_ADC_CHAN(4),
> > > +	IMX93_ADC_CHAN(5),
> > > +	IMX93_ADC_CHAN(6),
> > > +	IMX93_ADC_CHAN(7),
> > >  };
> > >
> > >  static void imx93_adc_power_down(struct imx93_adc *adc) =20
>=20


