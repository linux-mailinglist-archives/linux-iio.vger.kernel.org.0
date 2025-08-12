Return-Path: <linux-iio+bounces-22614-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94858B221D2
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 10:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF0C6E6AFB
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 08:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B312E7BC8;
	Tue, 12 Aug 2025 08:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="lng0be1E"
X-Original-To: linux-iio@vger.kernel.org
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7322E765B;
	Tue, 12 Aug 2025 08:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988360; cv=none; b=tQVkJG4Cq5hRtYBsxX5Ylcn3A89LGFvJuZaEDUpus1qu2Nojfdli3aHhU0lkThl2IQHkPQNTiwP9CieHK97DXxNUXJ9q/YEJswymeMrHeuZFlu2OBW4O6xn9RwZc5QbqNtv0JqM9cPBt1d8xDuZ0NoHdwlty2frwSH0yHwaxAaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988360; c=relaxed/simple;
	bh=nUQlyN1n4j3UgDVGQCRzPb4qjKkiojRa8wCKJO7ioYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXDqEyRP+XlgdCaoxk3eKsF/X/p+OQfghT73YmE87VTnrSQdSMPaERUk/PUSq6YKytIiP9Rtt3K3Tcr4owQ8hTh++rwy1lbrAA0w6AiVePdeTlNpt0/leu0vqkgHwdZBA87fFOSa8KvMipF7zCpOrovL31CWqUTiP8h1Pco0xLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=lng0be1E; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4fqFKZRX+VXRgMC+0U0SHSLoX7IVzWzQk49myeTjMC0=; b=lng0be1EtH1NwTkyOrfJ1ypzjm
	Ddta3DOel3KELJHU7Ljf6sNwYidTcfJRFDolNYD4s4qiCTxkgCrn1Y1XPQAm+t/R1QPosqnglWg2P
	eoTtqS1uE6Mm2Z4KuWN2TqGNPwsI/qNiAtBT5l7PPRPOlAwkz9YUdQgc/AB9xsQMTAzsyJTUmr2Ji
	6rVQjAgQ2fWxwnE/ZwXlpCWuwoPZG8AsXWfYRmMbZaYy6NR5kCfthx6GKrzajxmqgBSPqA/wp61cw
	KCS+JVHajYr1LZSW/2uQPtMLDxsRtKN3gpex3QBS5z74C8cLYHomnHe3omMdksCoTgSknxUaKp7OF
	TnXF1q+w==;
Received: from [89.212.21.243] (port=39484 helo=[192.168.69.116])
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1ulkdj-00DLjg-0H;
	Tue, 12 Aug 2025 10:45:50 +0200
Message-ID: <ffafc9d6-2cfe-4e3f-a610-9bddc7eb49f4@norik.com>
Date: Tue, 12 Aug 2025 10:45:48 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: imx93_adc: load calibrated values even
 calibration failed
To: Haibo Chen <haibo.chen@nxp.com>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: linux-iio@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>
References: <20250812-adc-v2-0-0260833f13b8@nxp.com>
 <20250812-adc-v2-2-0260833f13b8@nxp.com>
Content-Language: en-US
From: Primoz Fiser <primoz.fiser@norik.com>
Autocrypt: addr=primoz.fiser@norik.com; keydata=
 xjMEZrROOxYJKwYBBAHaRw8BAQdAADVOb5tiLVTUAC9nu/FUl4gj/+4fDLqbc3mk0Vz8riTN
 JVByaW1veiBGaXNlciA8cHJpbW96LmZpc2VyQG5vcmlrLmNvbT7CiQQTFggAMRYhBK2YFSAH
 ExsBZLCwJGoLbQEHbnBPBQJmtE47AhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQagttAQducE+T
 gAD+K4fKlIuvH75fAFwGYG/HT3F9mN64majvqJqvp3gTB9YBAL12gu+cm11m9JMyOyN0l6Os
 jStsQFghPkzBSDWSDN0NzjgEZrROPBIKKwYBBAGXVQEFAQEHQP2xtEOhbgA+rfzvvcFkV1zK
 6ym3/c/OUQObCp50BocdAwEIB8J4BBgWCAAgFiEErZgVIAcTGwFksLAkagttAQducE8FAma0
 TjwCGwwACgkQagttAQducE8ucAD9F1sXtQD4iA7Qu+SwNUAp/9x7Cqr37CSb2p6hbRmPJP8B
 AMYR91JYlFmOJ+ScPhQ8/MgFO+V6pa7K2ebk5xYqsCgA
Organization: Norik systems d.o.o.
In-Reply-To: <20250812-adc-v2-2-0260833f13b8@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi Haibo,

On 12. 08. 25 10:04, Haibo Chen wrote:
> ADC calibration might fail because of the noise on reference voltage.
> To avoid calibration fail, need to meet the following requirement:
>     ADC reference voltage Noise < 1.8V * 1/2^ENOB
> 
> For the case which the ADC reference voltage on board do not meet
> the requirement, still load the calibrated values, so ADC can also
> work but maybe not that accurate.

Reviewed-by: Primoz Fiser <primoz.fiser@norik.com>

Thanks for fixing this.

BR,
Primoz

> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/iio/adc/imx93_adc.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/imx93_adc.c b/drivers/iio/adc/imx93_adc.c
> index 8471737ac04a2bac0417a6397f20865f6a2c01ca..17b0a2548b0a3614ac537b01e28bc3144d17d6fc 100644
> --- a/drivers/iio/adc/imx93_adc.c
> +++ b/drivers/iio/adc/imx93_adc.c
> @@ -38,6 +38,7 @@
>  #define IMX93_ADC_PCDR6		0x118
>  #define IMX93_ADC_PCDR7		0x11C
>  #define IMX93_ADC_CALSTAT	0x39C
> +#define IMX93_ADC_CALCFG0	0x3A0
>  
>  /* ADC bit shift */
>  #define IMX93_ADC_MCR_MODE_MASK			BIT(29)
> @@ -58,6 +59,8 @@
>  #define IMX93_ADC_IMR_ECH_MASK			BIT(0)
>  #define IMX93_ADC_PCDR_CDATA_MASK		GENMASK(11, 0)
>  
> +#define IMX93_ADC_CALCFG0_LDFAIL_MASK		BIT(4)
> +
>  /* ADC status */
>  #define IMX93_ADC_MSR_ADCSTATUS_IDLE			0
>  #define IMX93_ADC_MSR_ADCSTATUS_POWER_DOWN		1
> @@ -145,7 +148,7 @@ static void imx93_adc_config_ad_clk(struct imx93_adc *adc)
>  
>  static int imx93_adc_calibration(struct imx93_adc *adc)
>  {
> -	u32 mcr, msr;
> +	u32 mcr, msr, calcfg;
>  	int ret;
>  
>  	/* make sure ADC in power down mode */
> @@ -158,6 +161,11 @@ static int imx93_adc_calibration(struct imx93_adc *adc)
>  
>  	imx93_adc_power_up(adc);
>  
> +	/* Enable loading of calibrated values even in fail condition */
> +	calcfg = readl(adc->regs + IMX93_ADC_CALCFG0);
> +	calcfg |= IMX93_ADC_CALCFG0_LDFAIL_MASK;
> +	writel(calcfg, adc->regs + IMX93_ADC_CALCFG0);
> +
>  	/*
>  	 * TODO: we use the default TSAMP/NRSMPL/AVGEN in MCR,
>  	 * can add the setting of these bit if need in future.
> @@ -180,9 +188,13 @@ static int imx93_adc_calibration(struct imx93_adc *adc)
>  	/* check whether calbration is success or not */
>  	msr = readl(adc->regs + IMX93_ADC_MSR);
>  	if (msr & IMX93_ADC_MSR_CALFAIL_MASK) {
> +		/*
> +		 * Only give warning here, this means the noise of the
> +		 * reference voltage do not meet the requirement:
> +		 *     ADC reference voltage Noise < 1.8V * 1/2^ENOB
> +		 * And the resault of ADC is not that accurate.
> +		 */
>  		dev_warn(adc->dev, "ADC calibration failed!\n");
> -		imx93_adc_power_down(adc);
> -		return -EAGAIN;
>  	}
>  
>  	return 0;
> 

-- 
Primoz Fiser
phone: +386-41-390-545
email: primoz.fiser@norik.com
--
Norik systems d.o.o.
Your embedded software partner
Slovenia, EU
phone: +386-41-540-545
email: info@norik.com

