Return-Path: <linux-iio+bounces-20810-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2ACAE2A08
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 17:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C5293B4BD2
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 15:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F43216E23;
	Sat, 21 Jun 2025 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uuiBzVRc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6669A30E83E;
	Sat, 21 Jun 2025 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750521534; cv=none; b=FGSPxIS99/SCxnyZZcX3fJA7mprQ2eaD61Dyxt89zxMvoWf5EIhH7abUSJ2tYztuJmKxmp2pHggT5bl7qo4fd3HwKtDZITiNfkyH+b6YXHwWNFcLfCErMAr/83sokyklzQsDFVdOcOfcIeGBd2AVDOeEujjm1zUC8/KbolWFrNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750521534; c=relaxed/simple;
	bh=uD1aowYPmj+UJLXVDosDmzbGxqXKB+j7Khv6FiWy4dI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BBy30HOB8RGQFl3XkMZmpKcNULnLFXpYzNmhVI9dUa84e0gV5lPFPXnT08Km3L1N1ALXqPUZTs9buyAj4Fe7zKUCq/Y7ttpebSOgXneC9M5O5ACksS9T0AfoKYQEDi/hjN3hz4sUt9RVGCS1BW8O+uor4SrXe2EsdC73fcOXxsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uuiBzVRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A87C4CEE7;
	Sat, 21 Jun 2025 15:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750521533;
	bh=uD1aowYPmj+UJLXVDosDmzbGxqXKB+j7Khv6FiWy4dI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uuiBzVRcEkC2Sxa/8Sv+mVWSSwv0SA0+lxjSMoXxmEthDJ53F1UsDFQEV7vqtLof3
	 I4gpSGdr20sf6S838T6kun/3W9EqYXLnQGcBVSCdjAi0MNlWQfbqxdAFFSj+bwAgqe
	 JRgA/xHLyAdD7wHRhQox0MLHZbOsdJEstsEhZPNFRuAV3U4NcUOvDGEDHlFlPzjIwO
	 bmhnC7b6CjMUd6Ce1g9AOpH/bnAx2pM7Zxqh53r/E0IDNy/QpHeFFLTHjntlZroK5n
	 YZZksBuIIBPlFaol+MiAKyZkT+lkp7OymawE/gkYy5hGQl7qQrT7PHLkbasgrCrkRX
	 vr8xdY7xTk/8Q==
Date: Sat, 21 Jun 2025 16:58:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Bough Chen <haibo.chen@nxp.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: imx93_adc: load calibrated values even
 calibration failed
Message-ID: <20250621165845.0bd7ac7f@jic23-huawei>
In-Reply-To: <DU0PR04MB94962C741E378CAC3F8910E69073A@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20250423-adcpatch-v1-1-b0e84c27ae98@nxp.com>
	<DU0PR04MB94962C741E378CAC3F8910E69073A@DU0PR04MB9496.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Jun 2025 03:07:11 +0000
Bough Chen <haibo.chen@nxp.com> wrote:

> Any comment for this patch?
I guess you didn't receive this mail from Andy for some reason?

https://lore.kernel.org/all/aAkYvE6VtoQItM5o@smile.fi.intel.com/

There were a few minor requested changes in there.
>=20
> > -----Original Message-----
> > From: Bough Chen <haibo.chen@nxp.com>
> > Sent: 2025=E5=B9=B44=E6=9C=8823=E6=97=A5 16:03
> > To: Jonathan Cameron <jic23@kernel.org>; David Lechner
> > <dlechner@baylibre.com>; Nuno S=C3=A1 <nuno.sa@analog.com>; Andy Shevch=
enko
> > <andy@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> > <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>
> > Cc: linux-iio@vger.kernel.org; imx@lists.linux.dev;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Bou=
gh
> > Chen <haibo.chen@nxp.com>
> > Subject: [PATCH] iio: adc: imx93_adc: load calibrated values even calib=
ration
> > failed
> >=20
> > ADC calibration might fail because of the noise on reference voltage.
> > To avoid calibration fail, need to meet the following requirement:
> > ADC reference voltage Noise < 1.8V * 1/2^ENOB
> >=20
> > For the case which the ADC reference voltage on board do not meet the
> > requirement, still load the calibrated values, so ADC can also work but=
 maybe
> > not that accurate.
> >=20
> > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> > ---
> >  drivers/iio/adc/imx93_adc.c | 21 ++++++++++++++++-----
> >  1 file changed, 16 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/imx93_adc.c b/drivers/iio/adc/imx93_adc.c =
index
> > 7feaafd2316f246bd0c32fea99309900b5c65099..ebf976db746f02431a315b1faa
> > 86f151bb67132e 100644
> > --- a/drivers/iio/adc/imx93_adc.c
> > +++ b/drivers/iio/adc/imx93_adc.c
> > @@ -38,6 +38,7 @@
> >  #define IMX93_ADC_PCDR6		0x118
> >  #define IMX93_ADC_PCDR7		0x11c
> >  #define IMX93_ADC_CALSTAT	0x39C
> > +#define IMX93_ADC_CALCFG0	0X3A0
> >=20
> >  /* ADC bit shift */
> >  #define IMX93_ADC_MCR_MODE_MASK			BIT(29)
> > @@ -58,6 +59,8 @@
> >  #define IMX93_ADC_IMR_ECH_MASK			BIT(0)
> >  #define IMX93_ADC_PCDR_CDATA_MASK		GENMASK(11, 0)
> >=20
> > +#define IMX93_ADC_CALCFG0_LDFAIL_MASK		BIT(4)
> > +
> >  /* ADC status */
> >  #define IMX93_ADC_MSR_ADCSTATUS_IDLE			0
> >  #define IMX93_ADC_MSR_ADCSTATUS_POWER_DOWN		1
> > @@ -145,7 +148,7 @@ static void imx93_adc_config_ad_clk(struct imx93_adc
> > *adc)
> >=20
> >  static int imx93_adc_calibration(struct imx93_adc *adc)  {
> > -	u32 mcr, msr;
> > +	u32 mcr, msr, calcfg;
> >  	int ret;
> >=20
> >  	/* make sure ADC in power down mode */ @@ -158,6 +161,11 @@ static
> > int imx93_adc_calibration(struct imx93_adc *adc)
> >=20
> >  	imx93_adc_power_up(adc);
> >=20
> > +	/* Enable loading of calibrated values even in fail condition */
> > +	calcfg =3D readl(adc->regs + IMX93_ADC_CALCFG0);
> > +	calcfg |=3D IMX93_ADC_CALCFG0_LDFAIL_MASK;
> > +	writel(calcfg, adc->regs + IMX93_ADC_CALCFG0);
> > +
> >  	/*
> >  	 * TODO: we use the default TSAMP/NRSMPL/AVGEN in MCR,
> >  	 * can add the setting of these bit if need in future.
> > @@ -179,11 +187,14 @@ static int imx93_adc_calibration(struct imx93_adc
> > *adc)
> >=20
> >  	/* check whether calbration is success or not */
> >  	msr =3D readl(adc->regs + IMX93_ADC_MSR);
> > -	if (msr & IMX93_ADC_MSR_CALFAIL_MASK) {
> > +	if (msr & IMX93_ADC_MSR_CALFAIL_MASK)
> > +		/*
> > +		 * Only give warning here, this means the noise of the
> > +		 * reference voltage do not meet the requirement:
> > +		 *     ADC reference voltage Noise < 1.8V * 1/2^ENOB
> > +		 * And the reault of ADC is not that accurate.
> > +		 */
> >  		dev_warn(adc->dev, "ADC calibration failed!\n");
> > -		imx93_adc_power_down(adc);
> > -		return -EAGAIN;
> > -	}
> >=20
> >  	return 0;
> >  }
> >=20
> > ---
> > base-commit: bc8aa6cdadcc00862f2b5720e5de2e17f696a081
> > change-id: 20250423-adcpatch-cb59c5255961
> >=20
> > Best regards,
> > --
> > Haibo Chen <haibo.chen@nxp.com> =20
>=20


