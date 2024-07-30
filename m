Return-Path: <linux-iio+bounces-8071-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49DA942066
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 21:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041AF1C2354E
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 19:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E7F18C909;
	Tue, 30 Jul 2024 19:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="lwYLSObx"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2099.outbound.protection.outlook.com [40.92.43.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF55718B482;
	Tue, 30 Jul 2024 19:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.43.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722366890; cv=fail; b=BvTmr/AqTspyfNB5njgo+wZ4NBemlLx+OzogZ1TWdfTvJUHhCfEQVB6dSPjfe9ixdpKsk5qmkca7jltsv/la918+LSw8CP2mJqVjJGtByZCwKrHJJ8eHukDEiL44IBMAcq7TpWy6ObCUcqXOpVsaC08u3/Uw7nP1qQTwyuY5JCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722366890; c=relaxed/simple;
	bh=sSzo53wSoOOjRcZyek28JnAlBEUfrsRSj5Tu0NmYeMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SJoenoySi6pkqCw2dYk6rK8W1XDLOyzhkepasJ3JD2xO/U9Rdn0m4PtiDWPShKwDJFrhktyyH1bShMuho7qfP24We91qjsCyMTVVscE5DfoeP5meMYt3ty4xjjfL6ndpybMgJsE/C9xa4pH7GUEH6Y+OOdEvnHfuXv3I+KraYQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=lwYLSObx; arc=fail smtp.client-ip=40.92.43.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HG8OZZGelMkNhTL6ooKvCQSwf6Bw7RLcqBSvYajZiHSPZHZpOTUekOhp5ps2QaBdw6T6RrDM/H/dzKsuGj0vde07oerfynFJCCljUHdiFAVEcwp8Fn8dsrYvzYCdrFDMRdcuNZM5jBQAjc3Cg0+T2nKoaRihWLIxlgbjwMpIY/FNW0g7z1CPUcjhCLU5+rbsrIf5Tp7g9/kBZXz5r72ch1Qj0BgLlrX+MRMo8YtD0Gdtz3JBQEVqzKnnUSvmrBkuOuuLrz0Gp1oqJdgH0ybPpD5T3SbKqquSgIOFgF/+hhN1KXS6PL/Q8buTOJ2Bi77nuXr4JIzyCenSwqh6Vja5Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMZPEkd0VXKgA55MnVnxPGW9oN6NiNCOGbC3ca+34hA=;
 b=J3m6KfPqZlkGkOVd9i3ZD4UywOpTDa+5f4ZiIklrkYXEeAIC5fWwY1GGHKy7pwXvpYruIosxoH/k2vF2W4twxp39ECbwEH+gZ3nqnG5Wiy5vu0DpvHllcnd/AU0TixDfZkQp2yuhLUOih6z9aEmBzEobpU6qLx++7dxSCCtrGJr9ELvGsFUm4MgBIjKVJfpCBr5c9n6H5Ga7EQ4VM7IJtzVmT7wzQtAqnwrPJ22zIFX1PBwyBuZk4I/bD6U3ngZO50queHFrCixsxyFV93Urf7KBH2EKjsEp4HiUKuKHwgBrMXbN263Q26pstnKTrmtwZRbfg5eVvYLTiGsf0/TMbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMZPEkd0VXKgA55MnVnxPGW9oN6NiNCOGbC3ca+34hA=;
 b=lwYLSObxiSUunCP4FYXVOvMhP9eaNK9GdpXVISlLq26XFXBPzXjToXo6Bc98UDconPnX7yWKOpFRM21fpb2hx7VOcSyrpkfCy0GwUbvw3HQfSrGa1rke9LqhFOgEb96hiHGFGokOEc/f2UsW9VOMGC9Fho28OkcEGs1OyRx/Ci1f4rpYAkxLNeqhqweDfwOqlHblRst+2pKIriFZ2ko0I6tjgTx+0ukReoOpcSrnwckQ0iqMIqD/wm24xgLfB+n22EJm2WQ/+tvJAEloci3N6LKPT/MSt8u8JrKJawwNs5YmhF9JqwsBP59SQyshMI95//i4g/uF9QVcFhjYj86Npg==
Received: from MN2PR16MB2941.namprd16.prod.outlook.com (2603:10b6:208:e1::15)
 by DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 19:14:45 +0000
Received: from MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490]) by MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490%4]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 19:14:45 +0000
Date: Tue, 30 Jul 2024 14:14:42 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-sunxi@lists.linux.dev,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, broonie@kernel.org, lee@kernel.org,
	samuel@sholland.org, jernej.skrabec@gmail.com, sre@kernel.org,
	wens@csie.org, conor+dt@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org, lars@metafoo.de
Subject: Re: [PATCH 6/8] power: supply: axp20x_usb_power: Add support for
 AXP717
Message-ID:
 <MN2PR16MB2941030EA2CE4C50BAADB02BA5B02@MN2PR16MB2941.namprd16.prod.outlook.com>
References: <20240617220535.359021-1-macroalpha82@gmail.com>
 <20240617220535.359021-7-macroalpha82@gmail.com>
 <Zne1uIMvuKilCglR@wens.tw>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zne1uIMvuKilCglR@wens.tw>
X-TMN: [k10u2kiuvsqk8WC7FSn98wjAM/3IbPSuvwEO0XLmpBuhxPCx/Ozj3GL3P3UIp2qs]
X-ClientProxiedBy: SN7PR04CA0112.namprd04.prod.outlook.com
 (2603:10b6:806:122::27) To MN2PR16MB2941.namprd16.prod.outlook.com
 (2603:10b6:208:e1::15)
X-Microsoft-Original-Message-ID: <Zqk7ooMgEi5X5tMu@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR16MB2941:EE_|DS1PR16MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: dff945e2-e29e-4e2f-a4ec-08dcb0cbdf61
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|5072599009|8060799006|461199028|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	mDDBq8MTSza7i/Di9bOU4DeSR8QBYJRMvRiBiXlPaWto94Tj46ktqX0/kbrMdZbexF3xJsXTCmSmximgXnj33QNuxBRMt7Zm87CucFPr73KPoAQIXSWU53ESsmaqFdgbDkViWyeDzS/yEG0/vmvks/g86L1nq9fHiOTgbUJrAfL1RAQOjen2FZTG7pF5jkbI9EJaA/HaEy6gphbL3X+vXG8WfZR1h5FuWyv3LkHNSkN43nbm+4IHBsg3eSTAC2HhJs06tKC2No0J91JGnO0q8AygDqllT+JEowDUFvtSIONKyfT6jcBEk9+SgFDPqsY/JUlMqH+bpVDmp9r3YToJb8CnzHWQTx01YsNy8onox714RHf2UNI296Sl9hCvMW3QUdRK8G3qgeCMBXU4cqRT8nq9ymCDdWBF8kFoABpCZ1i2Gp2dgbkLsK8QldH/9KO/ZaUA9tmwV5Ff7bQQIy6qrHcnEuPyxLbgmIm3obsuNt9TYPrZQczgZWrgLqZbcyIuiAQ7lLbUm6iC/tncXaCzhx+yDKqYC3XxzWmo83Y/kRCNFG4C6kZhKE0yuXZhfkUbQcSLtOuVQ71ref+Z+jy1yXIa1xG42T0OaHuXRcp4G2xAQK5XoJQ7yUkUOJZ0/Jor2KcBNvbB3jpDsIwAF0XDVlcinA5Y14yaKYMgrSWeJjWwKgI+2VVYZdUPsprq4AVh
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NjtBaKbzsiXd8PnN1ndEc7uxSa8lUu5I2dpLf7QAR+u7orqRkkUjy+q8lNlQ?=
 =?us-ascii?Q?wpk5DclRQU/zIznxsJuIc5jKI5LemdwLbUfpY9g+pLSqhYpI8iwyo4sxyxU8?=
 =?us-ascii?Q?EyjsDhr6mczFHMhNJWVccNJiQ7BGma+dQdphkUi0soAlnqtqnv60EqL3N186?=
 =?us-ascii?Q?PM4ETW+eucAjb4RAP+rTX8XMYwoPt8dv7OiFfJiz3eVLr3693wRiYAqyKS0s?=
 =?us-ascii?Q?Q2zLvDGhYUqeMJZOIO9CGLV2d3bc8Cty2Sfp/x7RMLYHgge4UROSsdmzki8W?=
 =?us-ascii?Q?WTQGGZ9EFOwlYY9HAbUxiGshMs/fDSIrjIlhfC+cWo6kGMe1R2wFRUVHdzCr?=
 =?us-ascii?Q?hqBRIs5fdBwTOJoXe3y+HjoB+ekZNQQTKp1nHZCGzBDSIvqjSlYkrqpv7dWH?=
 =?us-ascii?Q?ytsP698bL564E7U8ePVXeecYdzlWnCVUMc3PUBYrJsT/iuj4afVrgru9p5xY?=
 =?us-ascii?Q?06O0hLJFi4jUWl+n9NXCFHmGJ4ldixwIpI0TbICvATOcUD1BdXRs02qOxQd4?=
 =?us-ascii?Q?yVLtiYcx1s2s+dnCt7HH6/7ppEqnFuF6Q3Q8ppNjhD1BS8I1/P8YtdJ0LQKF?=
 =?us-ascii?Q?ptQi3J57MVdvGoEThncEoPk6dgbG0Pztug4GuOB94SLilwuNJZrH/jqWJrjU?=
 =?us-ascii?Q?LeeUyxTpwkqG4uzta/Fso/6EbNGH0PH4aUJ0u8IRZoLuUwn/boOeOtEl2SmW?=
 =?us-ascii?Q?9wQogK1mQDHfh6eNfndvE3BKD48HYO0X4IBj2H0HvsZL3ZisrKUMlZYLkyAV?=
 =?us-ascii?Q?7GvraKl4HhHjSpqtEZbIvNySFIkok/mf3Fh2mFXsy/v+hr19WKWrdB8mgc4c?=
 =?us-ascii?Q?yjmV2aiyhju+AeFzohSHQzE7qJIT+/8fzTWMEQKn+q9ZcNyhXs64R0mozqPJ?=
 =?us-ascii?Q?lG/vl4Jeg9UDUC0ji3dxoAnV7Tna9ImFvzaiMTUnOLrkSampZrvoLrW5MT9G?=
 =?us-ascii?Q?lgZHMCl95k3pc7gP9WjKbpETe9Yqx8D1mnpgFdATFO4Al6Dd2nLYy2cLGQyv?=
 =?us-ascii?Q?JX9Yg5w2mj6ySx58A9TpAkKIjAio4Z+pevQ7XT9xUYPCqfD+CFMFgGFWKER9?=
 =?us-ascii?Q?YJgMqmBJice67cggt4R699iN5sBZ6OJdlIQLNKB3+TLmq7B9J+Hxz6HdBeNq?=
 =?us-ascii?Q?wpRhjo3X2+j0NhLhRsQM4Wjkn3fMK31jrCmLaL7qC95TX9sHk/JtfBm3ZxOV?=
 =?us-ascii?Q?38QcBkGLABmveoG4rTJOsOjQrMBnRddPTqmR48zBVB+GvZZeal+jXvH9o3Q0?=
 =?us-ascii?Q?pxr+O6m+Ylx203tTDFapiJv3iOOEWZUYW0VwBV/u4lN+Jq6MyL2PjqgzAPng?=
 =?us-ascii?Q?r6G89dVa8ucD+vw9eA/+A1oD?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-559fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: dff945e2-e29e-4e2f-a4ec-08dcb0cbdf61
X-MS-Exchange-CrossTenant-AuthSource: MN2PR16MB2941.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 19:14:45.5631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR16MB6753

On Sun, Jun 23, 2024 at 01:42:16PM +0800, Chen-Yu Tsai wrote:
> On Mon, Jun 17, 2024 at 05:05:33PM -0500, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add support for the AXP717 PMIC. The AXP717 PMIC allows for detection
> > of USB type like the AXP813, but has little in common otherwise with
> > the other AXP PMICs. The USB charger is able to provide between
> > 100000uA and 3250000uA of power, and can measure the VBUS input in mV
> > with up to 14 bits of precision.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >  drivers/power/supply/axp20x_usb_power.c | 350 +++++++++++++++++++++---
> >  1 file changed, 314 insertions(+), 36 deletions(-)
> > 
> > diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
> > index dae7e5cfc54e..c442dd005831 100644
> > --- a/drivers/power/supply/axp20x_usb_power.c
> > +++ b/drivers/power/supply/axp20x_usb_power.c
> > @@ -30,8 +30,13 @@
> >  #define AXP20X_PWR_STATUS_VBUS_PRESENT	BIT(5)
> >  #define AXP20X_PWR_STATUS_VBUS_USED	BIT(4)
> >  
> > +#define AXP717_PWR_STATUS_VBUS_GOOD	BIT(5)
> > +
> >  #define AXP20X_USB_STATUS_VBUS_VALID	BIT(2)
> >  
> > +#define AXP717_PMU_FAULT_VBUS		BIT(5)
> > +#define AXP717_PMU_FAULT_VSYS		BIT(3)
> > +
> >  #define AXP20X_VBUS_VHOLD_uV(b)		(4000000 + (((b) >> 3) & 7) * 100000)
> >  #define AXP20X_VBUS_VHOLD_MASK		GENMASK(5, 3)
> >  #define AXP20X_VBUS_VHOLD_OFFSET	3
> > @@ -39,12 +44,20 @@
> >  #define AXP20X_ADC_EN1_VBUS_CURR	BIT(2)
> >  #define AXP20X_ADC_EN1_VBUS_VOLT	BIT(3)
> >  
> > +#define AXP717_INPUT_VOL_LIMIT_MASK	GENMASK(3, 0)
> > +#define AXP717_INPUT_CUR_LIMIT_MASK	GENMASK(5, 0)
> > +#define AXP717_ADC_DATA_MASK		GENMASK(14, 0)
> > +
> > +#define AXP717_ADC_EN_VBUS_VOLT		BIT(2)
> > +
> >  /*
> >   * Note do not raise the debounce time, we must report Vusb high within
> >   * 100ms otherwise we get Vbus errors in musb.
> >   */
> >  #define DEBOUNCE_TIME			msecs_to_jiffies(50)
> >  
> > +struct axp20x_usb_power;
> > +
> >  struct axp_data {
> >  	const struct power_supply_desc	*power_desc;
> >  	const char * const		*irq_names;
> > @@ -58,6 +71,10 @@ struct axp_data {
> >  	struct reg_field		usb_bc_det_fld;
> >  	struct reg_field		vbus_disable_bit;
> >  	bool				vbus_needs_polling: 1;
> > +	void (*axp20x_read_vbus)(struct work_struct *work);
> > +	int (*axp20x_cfg_iio_chan)(struct platform_device *pdev,
> > +				   struct axp20x_usb_power *power);
> > +	int (*axp20x_cfg_adc_reg)(struct axp20x_usb_power *power);
> 
> Please split out changes generalizing the driver into a separate patch.

Acknowledged.

> 
> >  };
> >  
> >  struct axp20x_usb_power {
> > @@ -74,6 +91,7 @@ struct axp20x_usb_power {
> >  	struct iio_channel *vbus_v;
> >  	struct iio_channel *vbus_i;
> >  	struct delayed_work vbus_detect;
> > +	int max_input_cur;
> >  	unsigned int old_status;
> >  	unsigned int online;
> >  	unsigned int num_irqs;
> > @@ -136,6 +154,24 @@ static void axp20x_usb_power_poll_vbus(struct work_struct *work)
> >  		mod_delayed_work(system_power_efficient_wq, &power->vbus_detect, DEBOUNCE_TIME);
> >  }
> >  
> > +static void axp717_usb_power_poll_vbus(struct work_struct *work)
> > +{
> > +	struct axp20x_usb_power *power =
> > +		container_of(work, struct axp20x_usb_power, vbus_detect.work);
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	ret = regmap_read(power->regmap, AXP717_ON_INDICATE, &val);
> > +	if (ret)
> > +		return;
> > +
> > +	val &= AXP717_PWR_STATUS_VBUS_GOOD;
> > +	if (val != power->old_status)
> > +		power_supply_changed(power->supply);
> > +
> > +	power->old_status = val;
> > +}
> > +
> >  static int axp20x_get_usb_type(struct axp20x_usb_power *power,
> >  			       union power_supply_propval *val)
> >  {
> > @@ -281,6 +317,84 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
> >  	return 0;
> >  }
> >  
> > +static int axp717_usb_power_get_property(struct power_supply *psy,
> > +	enum power_supply_property psp, union power_supply_propval *val)
> > +{
> > +	struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
> > +	unsigned int v;
> > +	int ret;
> > +
> > +	switch (psp) {
> > +	case POWER_SUPPLY_PROP_HEALTH:
> > +		val->intval = POWER_SUPPLY_HEALTH_GOOD;
> > +		ret = regmap_read(power->regmap, AXP717_PMU_FAULT_VBUS, &v);
> > +		if (ret)
> > +			return ret;
> > +
> > +		v &= (AXP717_PMU_FAULT_VBUS | AXP717_PMU_FAULT_VSYS);
> > +		if (v) {
> > +			val->intval = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> > +			regmap_write(power->regmap, AXP717_PMU_FAULT_VBUS, v);
> > +		}
> > +
> 
> Return POWER_SUPPLY_HEALTH_UNKNOWN if vbus is not present?
> 

Will do.

> > +		break;
> > +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> > +		ret = regmap_read(power->regmap, AXP717_INPUT_CUR_LIMIT_CTRL, &v);
> > +		if (ret)
> > +			return ret;
> > +
> > +		/* 50ma step size with 100ma offset. */
> > +		v &= AXP717_INPUT_CUR_LIMIT_MASK;
> > +		val->intval = (v * 50000) + 100000;
> > +		break;
> > +	case POWER_SUPPLY_PROP_ONLINE:
> 
> Probably use VINDPM status for this?
> 

For online? Unfortunately the VINDPM bit doesn't change whether or not a
charger is present for me.

> > +	case POWER_SUPPLY_PROP_PRESENT:
> > +		ret = regmap_read(power->regmap, AXP717_ON_INDICATE, &v);
> > +		if (ret)
> > +			return ret;
> > +		val->intval = !!(v & AXP717_PWR_STATUS_VBUS_GOOD);
> > +		break;
> > +	case POWER_SUPPLY_PROP_USB_TYPE:
> > +		return axp20x_get_usb_type(power, val);
> > +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> > +		ret = regmap_read(power->regmap, AXP717_INPUT_VOL_LIMIT_CTRL, &v);
> > +		if (ret)
> > +			return ret;
> > +
> > +		/* 80mv step size with 3.88v offset. */
> > +		v &= AXP717_INPUT_VOL_LIMIT_MASK;
> > +		val->intval = (v * 80000) + 3880000;
> > +		break;
> > +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> > +		if (IS_ENABLED(CONFIG_AXP20X_ADC)) {
> > +			ret = iio_read_channel_processed(power->vbus_v,
> > +							 &val->intval);
> > +			if (ret)
> > +				return ret;
> > +
> > +			/*
> > +			 * IIO framework gives mV but Power Supply framework
> > +			 * gives uV.
> > +			 */
> > +			val->intval *= 1000;
> > +			return 0;
> > +		}
> > +
> > +		ret = axp20x_read_variable_width(power->regmap,
> > +						 AXP717_VBUS_V_H, 16);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		val->intval = (ret % AXP717_ADC_DATA_MASK) * 1000;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +
> > +}
> > +
> >  static int axp20x_usb_power_set_voltage_min(struct axp20x_usb_power *power,
> >  					    int intval)
> >  {
> > @@ -307,16 +421,40 @@ static int axp20x_usb_power_set_voltage_min(struct axp20x_usb_power *power,
> >  	return -EINVAL;
> >  }
> >  
> > +static int axp717_usb_power_set_voltage_min(struct axp20x_usb_power *power,
> > +					    int intval)
> > +{
> > +	int val;
> > +
> > +	/* Minimum value of 3.88v and maximum of 5.08v. */
> > +	if (intval < 3880000 || intval > 5080000)
> > +		return -EINVAL;
> > +
> > +	/* step size of 80ma with 3.88v offset. */
> > +	val = (intval - 3880000) / 80000;
> > +	return regmap_update_bits(power->regmap,
> > +				  AXP717_INPUT_VOL_LIMIT_CTRL,
> > +				  AXP717_INPUT_VOL_LIMIT_MASK, val);
> > +}
> > +
> >  static int axp20x_usb_power_set_input_current_limit(struct axp20x_usb_power *power,
> >  						    int intval)
> >  {
> > -	int ret;
> > +	int ret, val;
> >  	unsigned int reg;
> >  	const unsigned int max = power->axp_data->curr_lim_table_size;
> >  
> >  	if (intval == -1)
> >  		return -EINVAL;
> >  
> > +	if (power->max_input_cur && (intval > power->max_input_cur)) {
> > +		val = power->max_input_cur;
> > +		dev_warn(power->dev,
> > +			 "reqested current %d clamped to max current %d\n",
> > +			 intval, power->max_input_cur);
> > +	} else
> > +		val = intval;
> > +
> 
> Just overwrite intval. One less variable and less changes below.

Done.

> 
> >  	/*
> >  	 * BC1.2 detection can cause a race condition if we try to set a current
> >  	 * limit while it's in progress. When it finishes it will overwrite the
> > @@ -331,15 +469,39 @@ static int axp20x_usb_power_set_input_current_limit(struct axp20x_usb_power *pow
> >  	}
> >  
> >  	for (reg = max - 1; reg > 0; reg--)
> > -		if (power->axp_data->curr_lim_table[reg] <= intval)
> > +		if (power->axp_data->curr_lim_table[reg] <= val)
> >  			break;
> >  
> >  	dev_dbg(power->dev, "setting input current limit reg to %d (%d uA), requested %d uA",
> > -		reg, power->axp_data->curr_lim_table[reg], intval);
> > +		reg, power->axp_data->curr_lim_table[reg], val);
> >  
> >  	return regmap_field_write(power->curr_lim_fld, reg);
> >  }
> >  
> > +static int axp717_usb_power_set_input_current_limit(struct axp20x_usb_power *power,
> > +						    int intval)
> > +{
> > +	int val, tmp;
> > +
> > +	/* Minimum value of 100mA and maximum value of 3.25A*/
> > +	if (intval < 100000 || intval > 3250000)
> > +		return -EINVAL;
> > +
> > +	if (power->max_input_cur && (intval > power->max_input_cur)) {
> > +		val = power->max_input_cur;
> > +		dev_warn(power->dev,
> > +			 "reqested current %d clamped to max current %d\n",
> > +			 intval, power->max_input_cur);
> > +	} else
> > +		val = intval;
> 
> Same comment: just overwrite intval.
> 

Done.

> > +
> > +	/* Minimum value of 100mA with step size of 50mA. */
> > +	tmp = (val - 100000) / 50000;
> > +	return regmap_update_bits(power->regmap,
> > +				  AXP717_INPUT_CUR_LIMIT_CTRL,
> > +				  AXP717_INPUT_CUR_LIMIT_MASK, tmp);
> > +}
> > +
> >  static int axp20x_usb_power_set_property(struct power_supply *psy,
> >  					 enum power_supply_property psp,
> >  					 const union power_supply_propval *val)
> > @@ -366,6 +528,26 @@ static int axp20x_usb_power_set_property(struct power_supply *psy,
> >  	return -EINVAL;
> >  }
> >  
> > +static int axp717_usb_power_set_property(struct power_supply *psy,
> > +					 enum power_supply_property psp,
> > +					 const union power_supply_propval *val)
> > +{
> > +	struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
> > +
> > +	switch (psp) {
> > +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> > +		return axp717_usb_power_set_input_current_limit(power, val->intval);
> > +
> > +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> > +		return axp717_usb_power_set_voltage_min(power, val->intval);
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return -EINVAL;
> 
> This is redundant.
> 

Dropping.

> > +}
> > +
> >  static int axp20x_usb_power_prop_writeable(struct power_supply *psy,
> >  					   enum power_supply_property psp)
> >  {
> > @@ -385,6 +567,64 @@ static int axp20x_usb_power_prop_writeable(struct power_supply *psy,
> >  	       psp == POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT;
> >  }
> >  
> > +static int axp717_usb_power_prop_writeable(struct power_supply *psy,
> > +					   enum power_supply_property psp)
> > +{
> > +	return psp == POWER_SUPPLY_PROP_VOLTAGE_MIN ||
> > +	       psp == POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT;
> > +}
> > +
> > +static int axp20x_configure_iio_channels(struct platform_device *pdev,
> > +					 struct axp20x_usb_power *power)
> > +{
> > +	power->vbus_v = devm_iio_channel_get(&pdev->dev, "vbus_v");
> > +	if (IS_ERR(power->vbus_v)) {
> > +		if (PTR_ERR(power->vbus_v) == -ENODEV)
> > +			return -EPROBE_DEFER;
> > +		return PTR_ERR(power->vbus_v);
> > +	}
> > +
> > +	power->vbus_i = devm_iio_channel_get(&pdev->dev, "vbus_i");
> > +	if (IS_ERR(power->vbus_i)) {
> > +		if (PTR_ERR(power->vbus_i) == -ENODEV)
> > +			return -EPROBE_DEFER;
> > +		return PTR_ERR(power->vbus_i);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int axp717_configure_iio_channels(struct platform_device *pdev,
> > +					 struct axp20x_usb_power *power)
> > +{
> > +	power->vbus_v = devm_iio_channel_get(&pdev->dev, "vbus_v");
> > +	if (IS_ERR(power->vbus_v)) {
> > +		if (PTR_ERR(power->vbus_v) == -ENODEV)
> > +			return -EPROBE_DEFER;
> > +		return PTR_ERR(power->vbus_v);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int axp20x_configure_adc_registers(struct axp20x_usb_power *power)
> > +{
> > +	/* Enable vbus voltage and current measurement */
> > +	return regmap_update_bits(power->regmap, AXP20X_ADC_EN1,
> > +				  AXP20X_ADC_EN1_VBUS_CURR |
> > +				  AXP20X_ADC_EN1_VBUS_VOLT,
> > +				  AXP20X_ADC_EN1_VBUS_CURR |
> > +				  AXP20X_ADC_EN1_VBUS_VOLT);
> > +}
> > +
> > +static int axp717_configure_adc_registers(struct axp20x_usb_power *power)
> > +{
> > +	/* Enable vbus voltage measurement  */
> > +	return regmap_update_bits(power->regmap, AXP717_ADC_CH_EN_CONTROL,
> > +				  AXP717_ADC_EN_VBUS_VOLT,
> > +				  AXP717_ADC_EN_VBUS_VOLT);
> > +}
> > +
> >  static enum power_supply_property axp20x_usb_power_properties[] = {
> >  	POWER_SUPPLY_PROP_HEALTH,
> >  	POWER_SUPPLY_PROP_PRESENT,
> > @@ -403,6 +643,16 @@ static enum power_supply_property axp22x_usb_power_properties[] = {
> >  	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> >  };
> >  
> > +static enum power_supply_property axp717_usb_power_properties[] = {
> > +	POWER_SUPPLY_PROP_HEALTH,
> > +	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> > +	POWER_SUPPLY_PROP_ONLINE,
> > +	POWER_SUPPLY_PROP_PRESENT,
> > +	POWER_SUPPLY_PROP_USB_TYPE,
> > +	POWER_SUPPLY_PROP_VOLTAGE_MIN,
> > +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> > +};
> > +
> >  static enum power_supply_property axp813_usb_power_properties[] = {
> >  	POWER_SUPPLY_PROP_HEALTH,
> >  	POWER_SUPPLY_PROP_PRESENT,
> > @@ -439,6 +689,18 @@ static const struct power_supply_desc axp22x_usb_power_desc = {
> >  	.set_property = axp20x_usb_power_set_property,
> >  };
> >  
> > +static const struct power_supply_desc axp717_usb_power_desc = {
> > +	.name = "axp20x-usb",
> > +	.type = POWER_SUPPLY_TYPE_USB,
> > +	.properties = axp717_usb_power_properties,
> > +	.num_properties = ARRAY_SIZE(axp717_usb_power_properties),
> > +	.property_is_writeable = axp717_usb_power_prop_writeable,
> > +	.get_property = axp717_usb_power_get_property,
> > +	.set_property = axp717_usb_power_set_property,
> > +	.usb_types = axp813_usb_types,
> > +	.num_usb_types = ARRAY_SIZE(axp813_usb_types),
> > +};
> > +
> >  static const struct power_supply_desc axp813_usb_power_desc = {
> >  	.name = "axp20x-usb",
> >  	.type = POWER_SUPPLY_TYPE_USB,
> > @@ -505,6 +767,9 @@ static const struct axp_data axp192_data = {
> >  	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
> >  	.vbus_valid_bit = REG_FIELD(AXP192_USB_OTG_STATUS, 2, 2),
> >  	.vbus_mon_bit   = REG_FIELD(AXP20X_VBUS_MON, 3, 3),
> > +	.axp20x_read_vbus = &axp20x_usb_power_poll_vbus,
> > +	.axp20x_cfg_iio_chan = axp20x_configure_iio_channels,
> > +	.axp20x_cfg_adc_reg = axp20x_configure_adc_registers,
> >  };
> >  
> >  static const struct axp_data axp202_data = {
> > @@ -516,6 +781,9 @@ static const struct axp_data axp202_data = {
> >  	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
> >  	.vbus_valid_bit = REG_FIELD(AXP20X_USB_OTG_STATUS, 2, 2),
> >  	.vbus_mon_bit   = REG_FIELD(AXP20X_VBUS_MON, 3, 3),
> > +	.axp20x_read_vbus = &axp20x_usb_power_poll_vbus,
> > +	.axp20x_cfg_iio_chan = axp20x_configure_iio_channels,
> > +	.axp20x_cfg_adc_reg = axp20x_configure_adc_registers,
> >  };
> >  
> >  static const struct axp_data axp221_data = {
> > @@ -526,6 +794,9 @@ static const struct axp_data axp221_data = {
> >  	.curr_lim_table_size = ARRAY_SIZE(axp221_usb_curr_lim_table),
> >  	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
> >  	.vbus_needs_polling = true,
> > +	.axp20x_read_vbus = &axp20x_usb_power_poll_vbus,
> > +	.axp20x_cfg_iio_chan = axp20x_configure_iio_channels,
> > +	.axp20x_cfg_adc_reg = axp20x_configure_adc_registers,
> >  };
> >  
> >  static const struct axp_data axp223_data = {
> > @@ -536,6 +807,23 @@ static const struct axp_data axp223_data = {
> >  	.curr_lim_table_size = ARRAY_SIZE(axp20x_usb_curr_lim_table),
> >  	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
> >  	.vbus_needs_polling = true,
> > +	.axp20x_read_vbus = &axp20x_usb_power_poll_vbus,
> > +	.axp20x_cfg_iio_chan = axp20x_configure_iio_channels,
> > +	.axp20x_cfg_adc_reg = axp20x_configure_adc_registers,
> > +};
> > +
> > +static const struct axp_data axp717_data = {
> > +	.power_desc     = &axp717_usb_power_desc,
> > +	.irq_names      = axp22x_irq_names,
> > +	.num_irq_names  = ARRAY_SIZE(axp22x_irq_names),
> > +	.curr_lim_fld   = REG_FIELD(AXP717_INPUT_CUR_LIMIT_CTRL, 0, 5),
> > +	.usb_bc_en_bit  = REG_FIELD(AXP717_MODULE_EN_CONTROL_1, 4, 4),
> > +	.usb_bc_det_fld = REG_FIELD(AXP717_BC_DETECT, 5, 7),
> > +	.vbus_mon_bit   = REG_FIELD(AXP717_ADC_CH_EN_CONTROL, 2, 2),
> > +	.vbus_needs_polling = false,
> > +	.axp20x_read_vbus = &axp717_usb_power_poll_vbus,
> > +	.axp20x_cfg_iio_chan = axp717_configure_iio_channels,
> > +	.axp20x_cfg_adc_reg = axp717_configure_adc_registers,
> >  };
> >  
> >  static const struct axp_data axp813_data = {
> > @@ -549,6 +837,9 @@ static const struct axp_data axp813_data = {
> >  	.usb_bc_det_fld = REG_FIELD(AXP288_BC_DET_STAT, 5, 7),
> >  	.vbus_disable_bit = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 7, 7),
> >  	.vbus_needs_polling = true,
> > +	.axp20x_read_vbus = &axp20x_usb_power_poll_vbus,
> > +	.axp20x_cfg_iio_chan = axp20x_configure_iio_channels,
> > +	.axp20x_cfg_adc_reg = axp20x_configure_adc_registers,
> >  };
> >  
> >  #ifdef CONFIG_PM_SLEEP
> > @@ -590,36 +881,6 @@ static int axp20x_usb_power_resume(struct device *dev)
> >  static SIMPLE_DEV_PM_OPS(axp20x_usb_power_pm_ops, axp20x_usb_power_suspend,
> >  						  axp20x_usb_power_resume);
> >  
> > -static int configure_iio_channels(struct platform_device *pdev,
> > -				  struct axp20x_usb_power *power)
> > -{
> > -	power->vbus_v = devm_iio_channel_get(&pdev->dev, "vbus_v");
> > -	if (IS_ERR(power->vbus_v)) {
> > -		if (PTR_ERR(power->vbus_v) == -ENODEV)
> > -			return -EPROBE_DEFER;
> > -		return PTR_ERR(power->vbus_v);
> > -	}
> > -
> > -	power->vbus_i = devm_iio_channel_get(&pdev->dev, "vbus_i");
> > -	if (IS_ERR(power->vbus_i)) {
> > -		if (PTR_ERR(power->vbus_i) == -ENODEV)
> > -			return -EPROBE_DEFER;
> > -		return PTR_ERR(power->vbus_i);
> > -	}
> > -
> > -	return 0;
> > -}
> > -
> > -static int configure_adc_registers(struct axp20x_usb_power *power)
> > -{
> > -	/* Enable vbus voltage and current measurement */
> > -	return regmap_update_bits(power->regmap, AXP20X_ADC_EN1,
> > -				  AXP20X_ADC_EN1_VBUS_CURR |
> > -				  AXP20X_ADC_EN1_VBUS_VOLT,
> > -				  AXP20X_ADC_EN1_VBUS_CURR |
> > -				  AXP20X_ADC_EN1_VBUS_VOLT);
> > -}
> > -
> >  static int axp20x_regmap_field_alloc_optional(struct device *dev,
> >  					      struct regmap *regmap,
> >  					      struct reg_field fdesc,
> > @@ -640,6 +901,18 @@ static int axp20x_regmap_field_alloc_optional(struct device *dev,
> >  	return 0;
> >  }
> >  
> > +/* Optionally allow users to specify a maximum charging current. */
> > +static void axp20x_charger_parse_dt_property(struct device *dev,
> 
> axp20x_usb_power_parse_dt().
> 

Thank you, I'll rename the function.

> 
> Regards
> ChenYu
> 
> > +					     struct axp20x_usb_power *power)
> > +{
> > +	int ret;
> > +
> > +	ret = device_property_read_u32(dev, "input-current-limit-microamp",
> > +				       &power->max_input_cur);
> > +	if (ret)
> > +		dev_dbg(dev, "%s() no input-current-limit specified\n", __func__);
> > +}
> > +
> >  static int axp20x_usb_power_probe(struct platform_device *pdev)
> >  {
> >  	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
> > @@ -676,6 +949,8 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
> >  	if (IS_ERR(power->curr_lim_fld))
> >  		return PTR_ERR(power->curr_lim_fld);
> >  
> > +	axp20x_charger_parse_dt_property(&pdev->dev, power);
> > +
> >  	ret = axp20x_regmap_field_alloc_optional(&pdev->dev, power->regmap,
> >  						 axp_data->vbus_valid_bit,
> >  						 &power->vbus_valid_bit);
> > @@ -707,7 +982,7 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
> >  		return ret;
> >  
> >  	ret = devm_delayed_work_autocancel(&pdev->dev, &power->vbus_detect,
> > -					   axp20x_usb_power_poll_vbus);
> > +					   axp_data->axp20x_read_vbus);
> >  	if (ret)
> >  		return ret;
> >  
> > @@ -718,9 +993,9 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
> >  			return ret;
> >  
> >  		if (IS_ENABLED(CONFIG_AXP20X_ADC))
> > -			ret = configure_iio_channels(pdev, power);
> > +			ret = axp_data->axp20x_cfg_iio_chan(pdev, power);
> >  		else
> > -			ret = configure_adc_registers(power);
> > +			ret = axp_data->axp20x_cfg_adc_reg(power);
> >  
> >  		if (ret)
> >  			return ret;
> > @@ -778,6 +1053,9 @@ static const struct of_device_id axp20x_usb_power_match[] = {
> >  	}, {
> >  		.compatible = "x-powers,axp223-usb-power-supply",
> >  		.data = &axp223_data,
> > +	}, {
> > +		.compatible = "x-powers,axp717-usb-power-supply",
> > +		.data = &axp717_data,
> >  	}, {
> >  		.compatible = "x-powers,axp813-usb-power-supply",
> >  		.data = &axp813_data,
> > -- 
> > 2.34.1
> > 

Thank you for your feedback,
Chris

