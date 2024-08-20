Return-Path: <linux-iio+bounces-8644-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C937A958F4D
	for <lists+linux-iio@lfdr.de>; Tue, 20 Aug 2024 22:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56BB51F2438E
	for <lists+linux-iio@lfdr.de>; Tue, 20 Aug 2024 20:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7A71C2335;
	Tue, 20 Aug 2024 20:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="WugRX9yB"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2010.outbound.protection.outlook.com [40.92.42.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD5549651;
	Tue, 20 Aug 2024 20:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724186795; cv=fail; b=TSvT1TY2rxzLJx1GTnJfGJ13MUh38/A0a2NpcCZkjE5Nv3MPYcZwIyOZJlEeSQcto7S42pIA02B5SjdonPeUlYQxHTqjinRDHqIy0/WS0DAvufqNEfmW4QGpEfvJi4EehNhsg5CJeaqJeq1iTWLBefJDcr8hky7KmqzCJWbtbBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724186795; c=relaxed/simple;
	bh=rJr+Q/2xGkpq7Tx6hKcB4MXtZEylqEkiyVx4mh2RkbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NJaxCTh3l9kR4rXzpIN1qS0FQomxTrE/HeI8fM6l+aPCLt0C8fLFIu6+jx/Geeuxu2J38TdfuqJww7WN3AnyEMUJqdgFoKV3KNahvEzCRPwolPjMqZP6uWlXDnc0lcwyYqDz53H/Gl59Sxu0WaonE4+bCfaoId6tNvAq7SAkyKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=WugRX9yB; arc=fail smtp.client-ip=40.92.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9gbKcApXUHCA5MVZGdnsicJ0vWS+EilUFHXUowGlprgaQ/bYk/zw+6kKDBJ+0Xp3pbtY0UxolutYfqY+n1JjzCTYOQv447nuIJfLPfyxnnymXIw1l/Bv/UANByAUiBzRTKQaD9v8rIRCVThZhQdFaRuQYiC5IpH7SKfYDKbPH0bv3PjqHtdDj8w4Jd7f1VcXI7A2pRBEwBzBA+Q9R570OmuE3fbqtfNcKnrcXvZfNB4aC0F5B5Q1r/ls1i7C4pJkFo4lhNql6usDsL3aPLXnijYFblW1mr15plux8xIk1jltYUIqwnKxaywnx3tNJ3jFWN0JF902da8A7KRd3bc8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMOtQyO9DBw88rRK5akZbi2DEWKWIMhAx5udcr4JGXw=;
 b=gimFMqRJk5sdaGVdRS0CtACY3utpYrCimNGb5E7kKKfH9E2f5wl/pu0QuCq8aBtBBq5pHXCargqb5b4EhtQMP/nOagiuYmgUoLmr8mmxlNJ6F9PCIPLc/HjFU/u6m4LGiVx8n79W30nZh9mbKLoF+NQmSc7mc4RKn5d40xhiDapm3qfwOk7/qXfKCZ4v04rZk8ST4XsLdNwBEm0GOOBYQ9+Gyomvt5Vh6tNL1UONuMvqxZ3M7HynRajgM6QaPRebtQw4ZSyeq0Abur9YF9STTvqKs+Ha2p876zkTjqoe/pMFcEzXU3i6R9Emlz9DPxPtRo+fT2tTMMwZBaAOK0YuQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMOtQyO9DBw88rRK5akZbi2DEWKWIMhAx5udcr4JGXw=;
 b=WugRX9yBqr+zWknfohI6WqxmthQUAqtBt5tc5tUWor1EkhjDe9Cs7Rm+kCahQPBQLhRYUsVwtilvxCTYK162pMU/2rL5NVBHit4ix5v68RxEfBxeGRjXL+6reUJ4d2J1qkFNHuaQiSl6kMEYFDK3x9zJ0WJe/fgG2w0ExEskM4fCSo1tixbTbxhsEJx12c8SlDzdAGVa6S4dVGGcRVF5W/mh4rACoLlBd3C1DqOAUvm/Cj84ZtvOAPR2icH66/DarPV1JrDK6cl8JLLHIzRQ8fR4UqMacTTjMzdPpVJ1KDInJdqznH189fzaNT4QckvjVJPqFTntcgxo4kxmY//kpg==
Received: from MN2PR16MB2941.namprd16.prod.outlook.com (2603:10b6:208:e1::15)
 by SA1PR16MB6214.namprd16.prod.outlook.com (2603:10b6:806:3c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 20:46:31 +0000
Received: from MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490]) by MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490%4]) with mapi id 15.20.7849.019; Tue, 20 Aug 2024
 20:46:31 +0000
Date: Tue, 20 Aug 2024 15:46:27 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: kernel test robot <lkp@intel.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-sunxi@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, quentin.schulz@free-electrons.com,
	mripard@kernel.org, tgamblin@baylibre.com,
	aidanmacdonald.0x0@gmail.com, u.kleine-koenig@pengutronix.de,
	lee@kernel.org, samuel@sholland.org, jernej.skrabec@gmail.com,
	sre@kernel.org, wens@csie.org, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, lars@metafoo.de,
	jic23@kernel.org, jonathan.cameron@huawei.com,
	Philippe Simons <simons.philippe@gmail.com>
Subject: Re: [PATCH V3 14/15] power: supply: axp20x_battery: add support for
 AXP717
Message-ID:
 <MN2PR16MB2941E41D73883B888109324CA58D2@MN2PR16MB2941.namprd16.prod.outlook.com>
References: <20240819164619.556309-15-macroalpha82@gmail.com>
 <202408201232.lgLOd5Nu-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202408201232.lgLOd5Nu-lkp@intel.com>
X-TMN: [hFV/sLE3jpXhBErT0ktfV1/94oArb3th7rybjSTBYqc=]
X-ClientProxiedBy: SN7PR04CA0170.namprd04.prod.outlook.com
 (2603:10b6:806:125::25) To MN2PR16MB2941.namprd16.prod.outlook.com
 (2603:10b6:208:e1::15)
X-Microsoft-Original-Message-ID: <ZsUAo/OM+x0r5uol@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR16MB2941:EE_|SA1PR16MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 3997189f-618e-45d1-f9f1-08dcc1592bae
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|15080799003|8060799006|19110799003|440099028|3412199025|4302099013|1602099012;
X-Microsoft-Antispam-Message-Info:
	Nof4rec0ir3jIWj0W6alJYsaDBT+YxDYTwVDS1PLMPdJH/3BNUJc4g2W/PorwS8gOXbigOjeJAJygXdGiq2Sx92iolaSXOHLQnjPQsFzQNq6ZWqKR8Z1Dh/n4oIjupJZliOkxnu6oVrpdFVSLeOw0EX0OwLANMJVX8mYc1YqY4VrKyaQyceaR83FWorQZs1nIfbuFlEsNJ+dgeXEJgwC5N3qp0PkbdWIv6rYyujgY/YTUJkDlCCYL2jGr20abOccvUz62aJSPuiF1bjzQDmcjBf+lgCL9gIyphI9KwG8TS+30SViYXhPJjI/wDnNxMD7qd8FRjywaMr5miBO9kgSId16WgB/nFi85aKi7oh5Or70UmkPTNcxMZr6IldBadby1B9r2dhdR+61b4n5rtTnmyj1gqmoaU4pWVdFUCoTXzN89bs0F6KTwsHQQGr6nzK248yv7m39F1FSlKFE3cX11PPlwJI3oe/Y6A2XMvKEmqkrMw/h+HsCTHIyeihYAQQlgjP8w0XSKtnglydf2KkRk0hMuuc34RbuANpIQsiym8ZP7AZYGzvKe1F/JzqMlHZZgcPyx1inxS/H7QDvSjZE3OrHkOaNsR7kWHc3Nd28CjXjo5XG1vcl+4sqwijTugzJL1hPaXg/6k0AqSQAwMu5c4jsLT9aKYu6dZv5hU4CZ7mY99S/hLqNNbxTyuOD5QCluMP4uBf+nH4+pJW4DdRT0LW0c34VjfL62Sq+T+1X9yZ2ONAs7MaS4wV/0surAsONX5adioZymYf/to1U7DWFe5PpVPF+etJxl0rIR+zwEvGHRcaySoLPsCymx/gYCwg2nOSBbZHr8xNH+RmGl09oXQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dpc4JsW9b6ZXIMr2Pbkv5kbi1EOW25EiLU0Ias58cx5rfE2IG1wu6LfIcWyX?=
 =?us-ascii?Q?RwT3WOzk4l0F3NUFdSrRLe8vRs7Ig9ZkHcjFN+XWMx+D1ZJs0dQX7WiOsKFE?=
 =?us-ascii?Q?cnktVXdR/i6I3im0LetzYyKPqxOaVs7HflJLNwgxdCZkTXixPwVfB1l/B15R?=
 =?us-ascii?Q?qK6CZ0EkUVDFXBA0aOqPQH5y/t98lcq7fehWtgxo/4DWKCLCmBQnTsTCtvtb?=
 =?us-ascii?Q?sHXDpcUbQj6aMn/72K6DwO7KMj+wvHWkPc1CnDpnMQfQjLB43W56w7kZZF2w?=
 =?us-ascii?Q?rgrQ+fyQZWkpmdgSQvVd1HzzyQFgvFZJX3QhAqC6WO0ZxkPq+HimedT2Eghb?=
 =?us-ascii?Q?6p96EcXNQwG4DCDES1oD67BScPhw9W+axnhl8W5AeHeox6LjpBfgCMSY9W/F?=
 =?us-ascii?Q?giFuZCmlcDexuiHGsFrnzmgdE1gjLI8Mut4Laq5D/H9pV0OhEBsibIB+4XCJ?=
 =?us-ascii?Q?PF0LtXq8oICPTa3P3LgBBgBRp2hEArjQaiRPandfIusKH4N3HAs0AuDE5f4R?=
 =?us-ascii?Q?Pvo54BJDl0UGcJyxwIy2b1M3gEe2pO8ZhKgAcx8Rjqrt6PAYrPkXh9FER23X?=
 =?us-ascii?Q?xyOV/utV2LxvrpVvVHBNZoWOQLI46ejv7A1HqOxkI78aXLiMM/JCl72wJ1KM?=
 =?us-ascii?Q?QDLH8rCEz/KilSNGy95Ppj8DWNh3hjzDKp0Tk4TMedi+cWyZ00uuAneY8Kl2?=
 =?us-ascii?Q?fT9VO431VJCansf2qNlha71uOZqHM5vwNSCGaneEJLSljZwqluZH+/1H8OQp?=
 =?us-ascii?Q?GJHBTpXUBte/qabvD9vmqNWe1K2gDUsOOvOcB7ogmT+RNor4/aeWWaCbQ51y?=
 =?us-ascii?Q?Q2X9hTqfBHyHx5kF2mhY9e+IHlwMjjZivfd5tgPAWWmILNJJDeZaKH21xrCD?=
 =?us-ascii?Q?Mm2s4QMrtfnPQm/aO0Oh3RJxtUzO2R/AYlBK+/ZkT+j5CyLTXc+Wc/zAuPGv?=
 =?us-ascii?Q?VdtjBpOEd3cO7XvAohsN8rZ+ok0rM0EOPgQyFUUNWxtCMEn2fHCBExCMwFXj?=
 =?us-ascii?Q?LDRgGbkI1xBkOjmFM2fmFqVRQn0B7S9fkr32Of19T8PTb/hSS5dhhqTIpJON?=
 =?us-ascii?Q?wAzgHAni3mIMynp0teNoXEro7BCsiXAIeRokBKvD06f31dsj4cEv53HTKfHI?=
 =?us-ascii?Q?7QvbLQ/emmzeyvjHUTjygEnQxPNSqT7MCBFATvMK9VKRbNtq7whLjYi51Ib6?=
 =?us-ascii?Q?yfGd7eBrFt0WSKM5yW557SAKrYxwA8jh3lmxPlYtqF9bphPV/s/MPevYNBZ4?=
 =?us-ascii?Q?pSIQ7iiVNn5EW9Md0Mf3M1B9JfJ3q48N1t8lGd0Exg=3D=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-559fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3997189f-618e-45d1-f9f1-08dcc1592bae
X-MS-Exchange-CrossTenant-AuthSource: MN2PR16MB2941.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 20:46:31.2640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR16MB6214

On Tue, Aug 20, 2024 at 01:37:02PM +0800, kernel test robot wrote:
> Hi Chris,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on sre-power-supply/for-next]
> [also build test ERROR on jic23-iio/togreg lee-mfd/for-mfd-next linus/master v6.11-rc4 next-20240819]
> [cannot apply to lee-mfd/for-mfd-fixes]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Morgan/iio-adc-axp20x_adc-Add-adc_en1-and-adc_en1-to-axp_data/20240820-005144
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
> patch link:    https://lore.kernel.org/r/20240819164619.556309-15-macroalpha82%40gmail.com
> patch subject: [PATCH V3 14/15] power: supply: axp20x_battery: add support for AXP717
> config: arc-randconfig-001-20240820 (https://download.01.org/0day-ci/archive/20240820/202408201232.lgLOd5Nu-lkp@intel.com/config)
> compiler: arceb-elf-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240820/202408201232.lgLOd5Nu-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408201232.lgLOd5Nu-lkp@intel.com/

Acknowledged. It looks like I need to explicitly include
<linux/bitfield.h>. I'll include that in the next revision.

Thank you,
Chris

> 
> All errors (new ones prefixed by >>):
> 
>    drivers/power/supply/axp20x_battery.c: In function 'axp717_get_constant_charge_current':
> >> drivers/power/supply/axp20x_battery.c:266:16: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
>      266 |         *val = FIELD_GET(AXP717_ICC_CHARGER_LIM_MASK, *val) *
>          |                ^~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> 
> vim +/FIELD_GET +266 drivers/power/supply/axp20x_battery.c
> 
>    256	
>    257	static int axp717_get_constant_charge_current(struct axp20x_batt_ps *axp,
>    258						      int *val)
>    259	{
>    260		int ret;
>    261	
>    262		ret = regmap_read(axp->regmap, AXP717_ICC_CHG_SET, val);
>    263		if (ret)
>    264			return ret;
>    265	
>  > 266		*val = FIELD_GET(AXP717_ICC_CHARGER_LIM_MASK, *val) *
>    267			axp->data->ccc_scale;
>    268	
>    269		return 0;
>    270	}
>    271	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

