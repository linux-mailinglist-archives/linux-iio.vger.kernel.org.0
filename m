Return-Path: <linux-iio+bounces-25378-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C41DC02167
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 17:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D79C1AA0D3E
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 15:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A70433B953;
	Thu, 23 Oct 2025 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mxbzU5tZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010050.outbound.protection.outlook.com [52.101.84.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26B9338927;
	Thu, 23 Oct 2025 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232910; cv=fail; b=n9mnkdesH8eMq3B9Mw6vyiMAik+BGmj6OhYYH2zDlbqFVuFE53oIeGieNNSk5nzOZcUgFnVunU6L9dIPM2EuV41D9vOGB7vuIa16BRtowdoooS1LRCGR6kgVf/ruOj0E4U9WOoz/evRxnyN+91qEm3yTFg9a0eCX8L7WHf4eIGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232910; c=relaxed/simple;
	bh=h3IVjK8Ni6drYM78ILZkOU9jqhm7oF19oLA3mNAhhxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fA2XGaKa1JKjuxtL1RoIIc7f2pDEKUyTaigCnFUDcvWWWKyrfrrhzWefi28CmhmpOGsVM7Ehll2LzbyNB/e1WUJlA3HhBtNlmmKQ7XnY3z/vQrhi/hnUEkZNbYdOBQ/V+XI39pfNJUZ6HD8KO0OTRuQknsjI8JoIbsYiVFGDRCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mxbzU5tZ; arc=fail smtp.client-ip=52.101.84.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YS5qtbclBZwsfMus3H+13H8WJtya2RigQp1kZeXQeQcdHC8nZzPkIt1rYRWnvoUo5aM/hJ9Wt4C+PvCD2KcVwPScx6YCQitJN7+OxqFnUJzj41iEdtDgvwQrVcE543LK1vn7KDb5MdQyq2RvcgJZ1u22Fpn0kLHXuT8CE/mw+DWcB++VH1AdQlJFm9+i7isTgDUnHf0bNcdZN3rxYHArIxy58LkgeLkBgGQjxM7vuuP406NF5NfUSw4ZxfoKLBKpl8O3AmfmWdJn/ZICMRGOGNG64XXaDIPOLiYBiiUC0fgDuKK7k3UhC7JwXm2srxIzdCKUAHwFurMq8hGM6RI6Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgSB0tozmOj67ygN7EKu2+TOKtevjPE3++JWWOe70Bk=;
 b=lzVC/wNkpYC8AiS854bwVe1q7JbQUifFBgd0qRZnxk0JYn5TT+E6ktbJKAIxltls9DcEDjjsYnzKaAIvKSgOEKVEoFicBnGxxwqE0EybYVVI/cKbX5EaJuQd8NrpBsdw2Xe2HyJcTT2GezuJISrLG7a5VAddGZ0cQnCBH/U8eA6JlpbMi3vzCu1iDzK3+5tuCH7MkfoWreqBSD7eLQsA4KV1f+VK8/yjp54X6GcSQ9aK+IzVkq5CRC7oydY7ep2B5YgXpoxM+nh7Yt8i34TUobIiqXoWqZ7/kKbRiUn2mcernWpT8AgnNBzhmLPYMg+wdgOOLJ2oVttAfY5g2BwzWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgSB0tozmOj67ygN7EKu2+TOKtevjPE3++JWWOe70Bk=;
 b=mxbzU5tZPhrom17fFcl6hpjcRDMixUUYif8e8MLrDuhIa7Xw1a5snU8tUmjGlxHeo08iBaAi7sFLvSh1djBDVY4sqx8Ep+86kf/F5CJwpCRz5TRbgH5djkCF7T1a1yDghYnBA745f/LVH02HeKj35kHamRCsUgSU1qP45b/QcBd2CKTdyAOdDErTGPVQdFCyxuOfiFjpdT9UVcneczf88zl6Xz8M2g+xJ6jm+1RtnHdRenLSBlq+fjKv1bKBjyG9rjZAgtWRXdh2K8D5c/M15wWd2zsISzWJSZ31cdIEdtdiuilJF975QUciHtXfLn81ACPZaktxGjcOQqp7WvLHRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB7957.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 15:21:46 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 15:21:46 +0000
Date: Thu, 23 Oct 2025 11:21:37 -0400
From: Frank Li <Frank.li@nxp.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-iio@vger.kernel.org, joshua.yeong@starfivetech.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/5] i3c: master: svc: Replace bool rnw with union for
 HDR support
Message-ID: <aPpIAXFBRHXAVzi0@lizhi-Precision-Tower-5810>
References: <20251014-i3c_ddr-v6-0-3afe49773107@nxp.com>
 <20251014-i3c_ddr-v6-2-3afe49773107@nxp.com>
 <aPnmvepToKtZnAI-@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPnmvepToKtZnAI-@smile.fi.intel.com>
X-ClientProxiedBy: PH7P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::31) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e40ba14-1904-40e4-ade0-08de1247e10e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|19092799006|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SsfBxaoiqd3RvwsKZgtcL4jAAVcMd9LTaTHoMIgqHJsaPnmoNtfu5GqtBPeB?=
 =?us-ascii?Q?EfZU2Bgvd/ViyAq3HbElcASfRIqkAqj9IUrCrxh1RAm0Yst4wKF7S+kcgddA?=
 =?us-ascii?Q?Vbxz8amJ2d0OFaFjQx/mEJ3YQ2zEjSa2eVygo+Ibep1UqLYmhqUeUr5rNfCu?=
 =?us-ascii?Q?+Xa8yuhnXtbVCkC59JjlpsKIM/CgrsairdLhQHMVlgfO5zUYIhhl1w/Bg1Wc?=
 =?us-ascii?Q?Pwm9dzM0vxmEeYQ6sRNgLAECLmlnQCtS2XM3LVBVmT+9zEQbfHeilMrSBWaI?=
 =?us-ascii?Q?TfatyAPQVqiIRrg1CiCGaq40fZkCcDxM/ukjlRywMXmnRsoYTF9VzQEasJWL?=
 =?us-ascii?Q?0STordjdyW1AkCldtKR4HrSS+fr9yZRA8aQ9bXQKDv0VBUKAiq1K8Gz34uID?=
 =?us-ascii?Q?/po1hWSTtQazkMeoe3o/4g33owqhoY2Cpt5w3P8dcYPH1wEqB/x8IsuqVSyA?=
 =?us-ascii?Q?3gI+un9Bk+UTfREkqVLTt9yJ2YCEp8j3zyM7vlISGzG9WndRuCg4taInIEPT?=
 =?us-ascii?Q?vrZZhC5tABnuRt0BJ1ocCOukhCMG/fPc87ThY8qc03pZh7ofWWw+t5GjBG+2?=
 =?us-ascii?Q?f2dYFRggugl1yMy2abaVacUvD3Q/ZEHboh0PyR+Lx0gBOrHavza/Iv/dQrYx?=
 =?us-ascii?Q?S5RzmhpOv8Qg9FVTkMWB36HiCW1XHs9zH0Vvl0373D0bxlnsEc0EEmThHWDB?=
 =?us-ascii?Q?aVk3Vx2+/dyozxRww75v3iEltb8YoOS+ggo3Jjs53cMOO3IBnGfJtmND/VoS?=
 =?us-ascii?Q?ZG0IQSW+mlvZMRVps9035lA6Uyb/IghnpQHrv3ThuLoX2OVf2Fqzf6uZ6rls?=
 =?us-ascii?Q?IIfUHOCxwb8Zn5x7flWHGbu/8Kr7qKQ2QpwmrPeOdj3anAf+oKyr8WDEEPYE?=
 =?us-ascii?Q?+22DDPhJgNALRiqLC53mf9d6BGw/K0TpKWVflXNdLsx9qbX5IcFuK0wlozEK?=
 =?us-ascii?Q?HhQxJFso5oKUG0cmLZFdcfwHO84glFUtAvMiMF/X0Pr6oEQZLmCOS7Auaf9a?=
 =?us-ascii?Q?QZzXLsxfIT2jckHFgNHeoK5QM2UVS2vBM+wNjqL2pJFrfQpYrGWpnXAKjWFc?=
 =?us-ascii?Q?ue4Oz1YpUJMYj1qebluQH9TGtowgdeomPzwcQpIDXgDp62ulQ38Ibae1pReb?=
 =?us-ascii?Q?ebnZqML4V7h9LEyX2dU8HixaCpHSDltV43glp5QQZ6LF4fjJuzcAwaVdJO77?=
 =?us-ascii?Q?JNRrovpjWCYwqu6XQsp8lpQ0PmJUUCPfzV4vBAuzr3r5cBs148HYsKMq/auU?=
 =?us-ascii?Q?x4z+z6Z7rPbMl4pudJ2PL9WaT5ovEjVKLPsXCC4AOSk6IFE5p2bPsy1wLd40?=
 =?us-ascii?Q?Z6nDDWdpeNmllTZdz/ldS7bPp/M+iFFA57Di8I5sevsEZEsiJJo/Jwaw+/LV?=
 =?us-ascii?Q?yV2IL44zYUrekDlZ0lx7Tk+kr2m1xzspwPjEHd3hYWyexhDLIj1FZhOTeD7n?=
 =?us-ascii?Q?4riQslko+zerCC665MvrR3BEh3idTurPXHWZ5r+lg4+Flk4WTOmLosyrHQum?=
 =?us-ascii?Q?2jpTmvAj/wCZswt/3tbY9hNsCSUp/an7/2Tn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(19092799006)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YvhPwoA5/Bu2F8sXfWFgzzz1BnZx327FAocZZnuIGoOF7ZiBAIp/kLKUiw0V?=
 =?us-ascii?Q?Lp5vTzACl175yrTewY6KlXEzrWwn2S9RhQU2VPBCU+47vBgTCtVdSSsenhYA?=
 =?us-ascii?Q?EAEyUDmtIL0mu0oU2oBPpZi6WDNGHfrfvEdkgHOr543FCgnhaVKvbUPMCXzp?=
 =?us-ascii?Q?ghgvGK7j5glgYMOdKm5OcWIy9aXNBR0ymMI5HlQySDPRnOWUV770kRDXjqj+?=
 =?us-ascii?Q?yCTkakB/Ydd7888RtcIU64ZGfmZQ8CK6/p0RKa3+mqzs5RukulJGy6L2nF2O?=
 =?us-ascii?Q?ATdH9/LI1Q/WwMsHe4sfnFcwtciV8Ofac9rTGt1higDeCyoWSGYyfROF29rI?=
 =?us-ascii?Q?GASz1zezRY5Vaqyw7yWohQL6FX9NATZTWNzd7Zp7SynaNvLdHamsDJ1St11f?=
 =?us-ascii?Q?j3YrXUUIc9fXoYekCx+9q8R59KiQHP1G5tgBbq+uxm9RuVS3lpmWJ7SzgZcS?=
 =?us-ascii?Q?KF8M7JYDwncudD8sA18PhZTw9Q0P/Jkk8sYyruBARiVB9NNm/pLX6woXrUjG?=
 =?us-ascii?Q?JfaVQhCVOTSyaAbC2L3MB1FU/XK423RVZLBi7ooTDwTFSbNNlnwR8VRzdLys?=
 =?us-ascii?Q?GE3E07QHTyKO/BJofae5xsPoiEZ2y2jVZSGKaL3GukE4VGPLVSI/zqLpphYi?=
 =?us-ascii?Q?drMKVTfoiK+zayucted4TzZOMUlpnGkzxBrbEh0U8tpVMXBl5usGfr1y2S5U?=
 =?us-ascii?Q?5F00ZQMVS98PynjNieqdfB/8SR4d6PCWlxL/lwtU2VFOU/Q/V+L7qAPdlYuC?=
 =?us-ascii?Q?PnAIdxHLVI4OdjWSnU3SxfeAU7JT8XllTtYZ0IBGBjxoPkbslxklt2S2FoJc?=
 =?us-ascii?Q?ru4sNrXjOx4t3aFELyR2rCCxtuNSQNpmxHu55itTb4KJTao3zBhqjsXu4CVX?=
 =?us-ascii?Q?YoW0rpVEi1gYwoNGKFNphbOYm/K+D+eQQvO4TtRB8kZNqvTQXpqo6o1Ki5Dj?=
 =?us-ascii?Q?6xBkZ230bNJ8VJDTNmcKsEEfbCfMiZlDVb0YVk98JtCzkoieZujGt1MfVO6t?=
 =?us-ascii?Q?GCqXHgxYyhO6rwbjj822g8edgUn9S2XMfGj8X5p4a0ORtn1BWk87naLkvHXa?=
 =?us-ascii?Q?ZDd88YxdahUkK0lcoOpOAMS+eNLXL79IhzynjvV6I9gzAVe9/l6UFdd++liU?=
 =?us-ascii?Q?pKUnDYvZ5BwZIqyVZmLNoI36jKz7LlaBisAcY+WbStESl878ECsz/nVozeR6?=
 =?us-ascii?Q?Sz881f+Iw4kdv3XgfIAenvJaCGsMidsDGC2myWkIupwk3nJQ3lu5xHrf+lzw?=
 =?us-ascii?Q?v/wTSlcMRpY3MlS6tTznJdYRR7zz1pt1F2g+jWMjgu+c/Ur4ScLa/1dIEosQ?=
 =?us-ascii?Q?wh1DhteTLxxXTDB0/Llt2tTaaBDsDsPaCvlFKn9HSjasRz059TzfLIaW9wvZ?=
 =?us-ascii?Q?bmjSu7l59XLYWdmoZYdxbY69Xg92uDljEoSq0mA5ScjYAmk+iJjUZnFqQTDh?=
 =?us-ascii?Q?FXqMqvIeamkTTOkJI3RGvMVNUUtLFbfuZThlDFauATwhZ/kLMVCxmGA9V/J1?=
 =?us-ascii?Q?cLng+3fn0F1/eIv6X21RFR9Odo7W067/D+6QAXcxkthDa790FVedUURG98NE?=
 =?us-ascii?Q?i3cXSYRbvpYaM19diIQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e40ba14-1904-40e4-ade0-08de1247e10e
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 15:21:46.2400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dN4i7Id7nCu24FQUaKrUu+DXcPAw9Wmx5ZWxducuHND9ysJpkltKDRpSPG2EyVXVNtSVJ5nez3/wM7w07BmJOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7957

On Thu, Oct 23, 2025 at 11:26:37AM +0300, Andy Shevchenko wrote:
> On Tue, Oct 14, 2025 at 12:40:01PM -0400, Frank Li wrote:
> > Replace the bool rnw field with a union in preparation for adding HDR
> > support. HDR uses a cmd field instead of the rnw bit to indicate read or
> > write direction.
> >
> > Add helper function svc_cmd_is_read() to check transfer direction.
> >
> > Add a local variable 'rnw' in svc_i3c_master_priv_xfers() to avoid
> > repeatedly accessing xfers[i].rnw.
> >
> > No functional change.
>
> ...
>
> >  struct svc_i3c_cmd {
> >  	u8 addr;
> > -	bool rnw;
> > +	union {
> > +		bool rnw;
> > +		u8 cmd;
> > +		u32 rnw_cmd;
> > +	};
>
> Same Q, what is the selector?

Choose by transfer mode in callbeck i3c_xfers(..., mode).

>
> >  	u8 *in;
> >  	const void *out;
> >  	unsigned int len;
>
> >  }
>
> > +static bool svc_cmd_is_read(u32 rnw_cmd, u32 type)
> > +{
> > +	return rnw_cmd;
> > +}
>
> Useless?

Just prepare for HDR support.  HDR mode is difference method to check read
or write.

Frank
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

