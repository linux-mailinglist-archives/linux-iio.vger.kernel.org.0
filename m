Return-Path: <linux-iio+bounces-22623-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D02EB22CD4
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 18:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F39C96210E1
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 16:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDAF23D7F0;
	Tue, 12 Aug 2025 15:53:53 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399AB305E3D;
	Tue, 12 Aug 2025 15:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014033; cv=none; b=spLygUvNLU+/y6At2EX1SIFDwDk42zoaomPJrfBdqhozTo77jQglAK6KV5Btxbw10pl5JayfTBkiEQIdNLb4WGxn0DjlcVsIYBdg0wDQIsWVf5rzGtCjp7UgfY6xOuW9J7MzkL3FrMc8tAbbr3vLU6OWxJa13llOSUgu3z5V6z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014033; c=relaxed/simple;
	bh=BBheX8sbWCgYegYhKcL7467b7LoL9F8LRRRwdBxBPuo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZSx4VbEIwDpTul6y/VnQ5dYv20zxFVLHly/2cisuCDICQQ0fpbHfVXbHIBKQuMy1bi00+KkY1lNOPxcOSUS4+ZKXZC0XLCmq1fU3Hnx4YnFCtyXB1gZHYcFTOmN6fU0dR5NUi8/lLMSjTHtw9ABMEqxwuf2dOyUAIbfy0MvUJ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c1bbV6Zzlz6M4bb;
	Tue, 12 Aug 2025 23:51:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5929F1401DC;
	Tue, 12 Aug 2025 23:53:47 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 12 Aug
 2025 17:53:46 +0200
Date: Tue, 12 Aug 2025 16:53:45 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Primoz Fiser <primoz.fiser@norik.com>
CC: Haibo Chen <haibo.chen@nxp.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	<linux-iio@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"upstream@lists.phytec.de" <upstream@lists.phytec.de>
Subject: Re: [PATCH v2 2/2] iio: adc: imx93_adc: load calibrated values even
 calibration failed
Message-ID: <20250812165345.000002a4@huawei.com>
In-Reply-To: <ffafc9d6-2cfe-4e3f-a610-9bddc7eb49f4@norik.com>
References: <20250812-adc-v2-0-0260833f13b8@nxp.com>
	<20250812-adc-v2-2-0260833f13b8@nxp.com>
	<ffafc9d6-2cfe-4e3f-a610-9bddc7eb49f4@norik.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 12 Aug 2025 10:45:48 +0200
Primoz Fiser <primoz.fiser@norik.com> wrote:

> Hi Haibo,
> 
> On 12. 08. 25 10:04, Haibo Chen wrote:
> > ADC calibration might fail because of the noise on reference voltage.
> > To avoid calibration fail, need to meet the following requirement:
> >     ADC reference voltage Noise < 1.8V * 1/2^ENOB
> > 
> > For the case which the ADC reference voltage on board do not meet
> > the requirement, still load the calibrated values, so ADC can also
> > work but maybe not that accurate.  
> 
> Reviewed-by: Primoz Fiser <primoz.fiser@norik.com>
> 
> Thanks for fixing this.
> 
> BR,
> Primoz
> 
> > 
> > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> > ---
> >  drivers/iio/adc/imx93_adc.c | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/imx93_adc.c b/drivers/iio/adc/imx93_adc.c
> > index 8471737ac04a2bac0417a6397f20865f6a2c01ca..17b0a2548b0a3614ac537b01e28bc3144d17d6fc 100644
> > --- a/drivers/iio/adc/imx93_adc.c
> > +++ b/drivers/iio/adc/imx93_adc.c
> > @@ -38,6 +38,7 @@
> >  #define IMX93_ADC_PCDR6		0x118
> >  #define IMX93_ADC_PCDR7		0x11C
> >  #define IMX93_ADC_CALSTAT	0x39C
> > +#define IMX93_ADC_CALCFG0	0x3A0
> >  
> >  /* ADC bit shift */
> >  #define IMX93_ADC_MCR_MODE_MASK			BIT(29)
> > @@ -58,6 +59,8 @@
> >  #define IMX93_ADC_IMR_ECH_MASK			BIT(0)
> >  #define IMX93_ADC_PCDR_CDATA_MASK		GENMASK(11, 0)
> >  
> > +#define IMX93_ADC_CALCFG0_LDFAIL_MASK		BIT(4)
> > +
> >  /* ADC status */
> >  #define IMX93_ADC_MSR_ADCSTATUS_IDLE			0
> >  #define IMX93_ADC_MSR_ADCSTATUS_POWER_DOWN		1
> > @@ -145,7 +148,7 @@ static void imx93_adc_config_ad_clk(struct imx93_adc *adc)
> >  
> >  static int imx93_adc_calibration(struct imx93_adc *adc)
> >  {
> > -	u32 mcr, msr;
> > +	u32 mcr, msr, calcfg;
> >  	int ret;
> >  
> >  	/* make sure ADC in power down mode */
> > @@ -158,6 +161,11 @@ static int imx93_adc_calibration(struct imx93_adc *adc)
> >  
> >  	imx93_adc_power_up(adc);
> >  
> > +	/* Enable loading of calibrated values even in fail condition */
> > +	calcfg = readl(adc->regs + IMX93_ADC_CALCFG0);
> > +	calcfg |= IMX93_ADC_CALCFG0_LDFAIL_MASK;
> > +	writel(calcfg, adc->regs + IMX93_ADC_CALCFG0);
> > +
> >  	/*
> >  	 * TODO: we use the default TSAMP/NRSMPL/AVGEN in MCR,
> >  	 * can add the setting of these bit if need in future.
> > @@ -180,9 +188,13 @@ static int imx93_adc_calibration(struct imx93_adc *adc)
> >  	/* check whether calbration is success or not */
> >  	msr = readl(adc->regs + IMX93_ADC_MSR);
> >  	if (msr & IMX93_ADC_MSR_CALFAIL_MASK) {
> > +		/*
> > +		 * Only give warning here, this means the noise of the
> > +		 * reference voltage do not meet the requirement:
> > +		 *     ADC reference voltage Noise < 1.8V * 1/2^ENOB
> > +		 * And the resault of ADC is not that accurate.

result

If nothing else comes up I'll probably just fix that whilst applying.

Jonathan


> > +		 */
> >  		dev_warn(adc->dev, "ADC calibration failed!\n");
> > -		imx93_adc_power_down(adc);
> > -		return -EAGAIN;
> >  	}
> >  
> >  	return 0;
> >   
> 


