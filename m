Return-Path: <linux-iio+bounces-13565-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB979F3DF8
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2024 00:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 047A118841D5
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 23:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6471D5AD1;
	Mon, 16 Dec 2024 23:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dimonoff.com header.i=@dimonoff.com header.b="lc5XjsOk"
X-Original-To: linux-iio@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020084.outbound.protection.outlook.com [52.101.189.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3E61CD1E0;
	Mon, 16 Dec 2024 23:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734390027; cv=fail; b=lgIQJ1UWFpDVga4v1qBCcKBbIV3mDauNkAzT4Wabzr8Bpq6sNQjvghScpJAHYqTiTwzmGOx/XfGHdx+SfDhd4Fng9jap8e+/S3SCPZdkqXRAkEBGNa6li4zo0hLa0Yk/lb9nCamcUtH/FrYiqar4XU0M69ngKyTnqKp2RH7V4yQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734390027; c=relaxed/simple;
	bh=BU61w3lZ+pHYRUmAPosUz/MSG0UXf6D8Da20k0Rrys8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c7lQWVBiqTNJYsGfLuekRvtGoi2OAW/Crw3NQrwxEERv/HWxUzx/LzrKnkkEdtrTRQXJdK1TMkUlN9lGmkz19BAAxjPiSMWU4qruQlHUHSyqgyzKfmjgsCl3WMlSJ6AeCSsMzT1OATdjBIUc//Rgqad5yIULRNyEBU1sAKrn93I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dimonoff.com; spf=pass smtp.mailfrom=dimonoff.com; dkim=pass (1024-bit key) header.d=dimonoff.com header.i=@dimonoff.com header.b=lc5XjsOk; arc=fail smtp.client-ip=52.101.189.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dimonoff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dimonoff.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f30+tvHRJ700g468ppCJX3VtLkNl7rUFxQNs4A/3fURjiAmpNNMMKT8tM4vIO6qAyFNHXLTafhYRV4jXA9V/0H0F/baPUVQknnTKRX3xbiLJ8Xwzk/JQen53gAuMCME1wMxUtKaWPoj/PVQlkKEGKULHIK3bA0dMnQaygA3PMSQ30LoWf4m4GSi2bTLATX/VmArhksUpsaqGm2Lp23nCNdX4naF0DabqsFRETqjMFNW/EIQOi2WMMqdCzIOIoriTEA8d7dNfoiysF0sXfusxOfFOxiqke8ShPIdmnjPmeoSEPg8s/cClUokO9m4M544aeGm7b1PU5YeUuf5Zpue7RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mZaWnkpYljBPjL98xX9+QUSIKfYwhn3fkSFf1kbqlc=;
 b=sTp3bpMl2L7gZVO7jxujZ6DFA3TZ93vX9ELHwVTTrCgDJnlT9kc7EiZu/9k2H/LAln4p3g4cm+8jz5om2Kiv6LrhTok9HQSa+N4KFIW5Emr2KmTFVKSywf8pRNJG47U30RTthhB7rt5RgML5veTnLn7LPZUr8IL+K//zlw6c+Lg1ZPjeiMzz5FeLuBm4HdMpf3YEmXLK4GbtDtnw/6qpv32dtPebbii7PCcBsLXxaxyzjuf8gwtZqYAt0PvXpnzS8fa2DFsDVxiVkv5v3439MZ3l1Cgew4USZeUnOT/eWvDvGbNZAiNxtOD4hPQxlzlvqv2tnlwlcX59hVGWhslQaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dimonoff.com; dmarc=pass action=none header.from=dimonoff.com;
 dkim=pass header.d=dimonoff.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dimonoff.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mZaWnkpYljBPjL98xX9+QUSIKfYwhn3fkSFf1kbqlc=;
 b=lc5XjsOkStWMH1wafvmcIG5OLd3Ogt1VNEUM+dqariZyYFnODghbNhbu2ZbimM4aYr/t+TrHB7nF0otdgFTa3vlCaOpAFtvT77FM3oc1M0Qu2aXVScHPXKBd7zKDpQ8G204IYjVWzn2bTNiGry2mPm9PzOrBSWqUfi1lLUkUKVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dimonoff.com;
Received: from YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5c::20) by YT3PR01MB11013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:12a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 23:00:22 +0000
Received: from YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9a4b:5f92:57f8:2a39]) by YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9a4b:5f92:57f8:2a39%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 23:00:22 +0000
Date: Mon, 16 Dec 2024 18:00:18 -0500
From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mikael Gonella-Bolduc via B4 Relay <devnull+mgonellabolduc.dimonoff.com@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: light: Add APDS9160 ALS & Proximity sensor
 driver
Message-ID: <Z2CxAjPyrlZLdMZi@uva.nl>
References: <20241206-apds9160-driver-v2-0-be2cb72ef8f4@dimonoff.com>
 <20241206-apds9160-driver-v2-2-be2cb72ef8f4@dimonoff.com>
 <20241208122038.18cf7db8@jic23-huawei>
 <Z1dl2C9/BYoeyudu@uva.nl>
 <20241211205302.2ba32a4a@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211205302.2ba32a4a@jic23-huawei>
X-ClientProxiedBy: YT4PR01CA0402.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::14) To YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5c::20)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB9181:EE_|YT3PR01MB11013:EE_
X-MS-Office365-Filtering-Correlation-Id: bf7a03c3-5f6d-4bb9-46d1-08dd1e256ba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HTZow2IuRsROPWeXgKXByyZgcrOFp+0hD2vEw55BFTWFxKqu2xKzNBkUbKab?=
 =?us-ascii?Q?rCNVJZttelOdv30fKfK5Prpe+2aYiusyHCcj61neYhWy1tshNoAqMHuy65ZW?=
 =?us-ascii?Q?+GkkaLEhklKq/zGGGFRwaqjt6F5errM9Ety33f5HYKJ8Hibrd0QDGW5/agiP?=
 =?us-ascii?Q?WQzZbimamOmeC4UMAXjZmI07EV0czKjcbF2NRotAFx7BMpqQexHarDh7ChGp?=
 =?us-ascii?Q?fEGhgDm+RAUdRoHiOiSKtCfKVnVaMYbPfQahXUCb6SFxeQvN2FvEjHSDpveH?=
 =?us-ascii?Q?QoUZvtNBGEx1R6rArKBamAkR7Gu8qtG1ffGIv/uX5df02iH2fCCj1JVlF8/O?=
 =?us-ascii?Q?L+0eJzjp1/2ne/lvHWahs3hvrRqpdKHUmyCu7tDbNIKduWtWevUyIWpdonEm?=
 =?us-ascii?Q?WIDH2BxS4jHWDyYDdSs345ddC1/DznWnU1Y9yNWK+Pj+RculMwdZ7iBuDC99?=
 =?us-ascii?Q?68kBPx3WSWYyfCImN1Ts793NlzPvwIYVY43IR6lPJUEYyzsEZzKaCprvaGhN?=
 =?us-ascii?Q?73Ynmsj+VdAxEE9Mn/xHgNKkxzuHuKSC2RL5gjMg5IeFe3y2L/RQKp1PovZp?=
 =?us-ascii?Q?xiGQi3GC+W37ZRbQmMq4GTheQVY3M2nLalwnwfHpox1wasuURrAohM74Ey/V?=
 =?us-ascii?Q?90dZr+bLwo2jy6BlDSHaMkrF4Hqgu6lyfdu/lM5N2h/hJzM5chJJzR/lB6oN?=
 =?us-ascii?Q?0d8ufjce/qBz2NX08Nf4k610T4htZIyD8/7UxyxjZDfGorYibPyGf4FIp1IO?=
 =?us-ascii?Q?ql2QX4G3KE6Ndpe2MLWDJmndeznMuQ7diuhomxJDFvMCDdo67/0Ylf6fRl3s?=
 =?us-ascii?Q?qF9V4IFcgHfPbTw+LnE+ZoyfhPpvFM5uDF7hQe1qVL6BKmlY8nDH0vsDPSBl?=
 =?us-ascii?Q?zYh9j3/W+zMymm5iLFtqPyzoto3Yq9jz/5TjVFmd8JkijFASuZZLfcDFUYJ4?=
 =?us-ascii?Q?ShuUbW8M+OJASAgMDQ24Ym9mGjoawKvQGco6isC6AuDuZvvylW/IheY/eYne?=
 =?us-ascii?Q?KD2lKnMo/tlg/fyV0gVT6UKZZ7XKBuahcqcYikVfkm0GwlpPila3faMvr8E4?=
 =?us-ascii?Q?1zV9ie5vMWUB7WMUoM4MTzqYzzGb8w45C0kfosbBl4JR3hGev9b0p6LVvqqi?=
 =?us-ascii?Q?FTpodwRfb2HkogE+tVqItiOwuXovTkIv5D7KLAJO4pKWRnmjR1LICXmJhgpl?=
 =?us-ascii?Q?mPSzHhfEZmerK1HXAJy0nM1Hxv8vmiwCJjmbD384bi04BRSlpOrCGqsUnjLH?=
 =?us-ascii?Q?eaprXRIEXypkr16BjIXqZQAAnIvIX7ul0Qd7Ic6jJBnuFCyX0BMRA7VZbU0V?=
 =?us-ascii?Q?dVpLnPu/7q/kUORlskzBBTNCTmjp2xgvsCxVBSoCe+I2BkiZ+ac1RsWQ/MIN?=
 =?us-ascii?Q?dvnT/UZlEVK8XrPTcHe2Z27PlPrJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6SCDnwwRXJCrdtkEHrgzXXW8zkmQRy5K74HsfGdMqz86nFaQ2ddtsZzRc6g9?=
 =?us-ascii?Q?prZBAaTcBPIwoj4jznAmwZ27WlWH89+bLiai11jiiy5EnpxTRXciY77GmHox?=
 =?us-ascii?Q?bTrSZ8+BRjsT8cb6b05xqmenQBtqb8aT79ImQsFhjlMNls9oawIE+upVLd7Z?=
 =?us-ascii?Q?DYzg/8P4VziWA1OYuAvFKsTEHqxtF20SpRXqhIR/dFTTMgNuu1uQp4m9HPgc?=
 =?us-ascii?Q?cjUBwUGKwX5TeybhMWYyVTEzPvEH9yWUU+o+xWUzPwbsans416wegkurw7wW?=
 =?us-ascii?Q?anY7dN0smrcX+rGisMiRKvQA+XpoZdUtLB3PiRwxRpqkXsPrOT5SEb5VMimY?=
 =?us-ascii?Q?Vkgdhm4UVvWGLaBCLhZDRqexzLHE+Cvip+c4rYU5wFyog0s43Zl8z1dh0SLR?=
 =?us-ascii?Q?/a5YTZr3MIPAaOAkDoP8q4280aG0rN7VW+E35ysg4EWcIXRGvjEZitCFTvIG?=
 =?us-ascii?Q?xC0JWGf10Ttd3CzJpJFlEztEDDX96u4PsiEchhDPGN5SOX0N2u9t837MOnjd?=
 =?us-ascii?Q?ZLz/DBLXxjg5AXYeaYGg9rn+2iIk3Y0QRLlkEQ2leF7ZBaQjWGF0PhtNiDGP?=
 =?us-ascii?Q?nHq3aGDtamr4tdeTWwY2YySrUBRWpqT09asmMoiUCFLjIaxKRUGOUrpyiNQ9?=
 =?us-ascii?Q?nCX8pTdTBBHrclZ72AMO/wDF+ld6obb6JgC/SGU+O2R2gTc96toeI8daE2bC?=
 =?us-ascii?Q?y7yHQRknuoGbIHlqrzSVzv0pH/cpAFr3AYqlirNjFyLCmolYIb3stIWWb0eN?=
 =?us-ascii?Q?D2tiiQOHi84Ro/qiu88g4iEl35itUO2/VFz3N/nKTPfPGbWJb0AC5r07rQvc?=
 =?us-ascii?Q?kyIBPSjbe/7mBx11BDR/x7tCpTdfC9ITgvJi3xaBNt3oeXBtTv5RKUVv0E8r?=
 =?us-ascii?Q?4PkWaEB8conr+0KbzCmEgyCyyelISbwP6YfhLuLAM+O5pYpf12Bcvmb7caFN?=
 =?us-ascii?Q?mE60aEFtbW4nciKd3iS9FxaKMUqxK5bjfEN1KDH6VRASmM0eVWszaRiefkH3?=
 =?us-ascii?Q?mxZHzg3YVBonEXtfsX7DLD8y1kZpn5og/upVq7ERV505xy2YMl5eNhEtvOmo?=
 =?us-ascii?Q?Zfnn5L9mkrfDd0HRwTlJfo2NRq/zaBsD5TrPJvSAH9rozOrYnrBVlOVNhW9t?=
 =?us-ascii?Q?z+HBX2sNAMIw0fC6INWxYMR5v16gKjvvD15+Pd0jFEBRvGhkuxjg8r51YJx9?=
 =?us-ascii?Q?3VXuGAu2oEu+2sbhgx7chKA13QpK6aNusT7tYDIhyNgquF8AM105y6g/JKHN?=
 =?us-ascii?Q?hDPXVPEmeZ31L+NOJBJD29UtnWy9bgAveAEHGz9cp+LIWfQPiVoRsp4Qg1Sw?=
 =?us-ascii?Q?nEPN7y2x1x3ug1oRj+cNF7Ige+PGNfDLd0/9xtinz3i4SeZjbSFBrOWSF15k?=
 =?us-ascii?Q?etMFxD8KJ8/RJ3uQb+2VUPIAhksNKU4ipj9867gIZPv6vQ7I/SRFYJvilCFG?=
 =?us-ascii?Q?eEz4C++FcJM/3RHwqBVruSSzHnMPHh98N/U/Ghy9MywULuAPJeaOjeOek60a?=
 =?us-ascii?Q?LDGclglaGXCNJFqzF5uqizMtvM40cMH8jsdZR9Z9c2X5A8OZ14Yz6WR2GCcz?=
 =?us-ascii?Q?WgNiRoBALazDR6z6xiaYR2twFQla8+bss6Qrkez+AR6zaNnvCYW4sAW9aC7T?=
 =?us-ascii?Q?2A=3D=3D?=
X-OriginatorOrg: dimonoff.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7a03c3-5f6d-4bb9-46d1-08dd1e256ba2
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 23:00:22.6862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c4063547-e5e6-4866-a386-58c3965da102
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SXombrzL+gNtS/HVtRcDHGSxhVUmfVHgzjfhtKwcyLbBB0/UcwCC+sldhuuksEO2DrRSGHHnSU3rQtSQ9Gf6xARpWOOdcFVdRsikM3uWzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB11013

On Wed, Dec 11, 2024 at 08:53:02PM +0000, Jonathan Cameron wrote:
> On Mon, 9 Dec 2024 16:49:12 -0500
> Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com> wrote:
> 
> > On Sun, Dec 08, 2024 at 12:20:38PM +0000, Jonathan Cameron wrote:
> > > On Fri, 06 Dec 2024 11:09:57 -0500
> > > Mikael Gonella-Bolduc via B4 Relay <devnull+mgonellabolduc.dimonoff.com@kernel.org> wrote:
> > >   
> > > > From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
> > > > 
> > > > APDS9160 is a combination of ALS and proximity sensors.
> > > > 
> > > > This patch add supports for:
> > > >     - Intensity clear data and illuminance data
> > > >     - Proximity data
> > > >     - Gain control, rate control
> > > >     - Event thresholds
> > > > 
> > > > Signed-off-by: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>  
> > > 
> > > Hi Mikael,
> > > 
> > > As the bots noted, the maintainers entry has the wrong vendor prefix,
> > > or the binding does.
> > > 
> > > Also the issue with missing include of linux/bitfield.h
> > > 
> > > Unused gain table is less obvious. Not sure what intent was on that one.
> > > 
> > > Given the discussion with Matti about how to do the gain control, please add
> > > some description here of the outcome.  The control scheme is not particularly
> > > obvious and is the key bit we should be reviewing.  It feels like you've
> > > applied the feedback on v1 to the light channel but it is equally applicable
> > > to proximity channels when they are just measures of reflected light intensity.
> > > 
> > > Various other minor things inline.
> > > 
> > > Thanks,
> > > 
> > > 
> > > Jonathan  
> > 
> > Hi Jonathan,
> > 
> > I will fix the warnings the bots noted and other inline comments for v3, sorry about that.
> > Regarding gain control for ALS, I kept the non-linear table provided in the datasheet.
> > The user can adjust the integration time and the available scales will update
> > depending on the value.
> > For example, at 100ms, you have possible scales of 0.819, 0.269, 0.131, etc. (lux/count).
> > The hardware gain and other relevant registers gets adjusted by the driver depending on selected scale.
> > The attribute is kept as read-only as Matti suggested.
> > 
> > Now, for proximity, again I'm confused. Please bear with me a little.
> > The only "scale" I see in the datasheet is that the proximity sensor is for a short distance of under 70mm.
> 
> That sounds like a design point for sensitivity of sensor vs light source brightness.
> 
> > There's nothing provided in the datasheet to convert the proximity ADC count to a distance or to anything meaningful like standard units.
> > I don't feel like this is really precise and the intended use case is probably like mine where you can use this to detect
> > if there's something covering the sensor or not.
> > 
> > I took a look at other light/proximity sensors, again, it's not clear for me how to handle this.
> > It seems that some drivers just directly control the hardware gain register with the scale even if it's not really a scale.
> Typical case is that it is a scale, just not of distance.  But rather controls an amplifier on the light sensor,
> so same as for the ambient light sensor.
> 
> The ABI docs are a little vague on this Documentation/ABI/testing/sysfs-bus-iio
> has
> What:		/sys/.../iio:deviceX/in_proximity_raw
> What:		/sys/.../iio:deviceX/in_proximity_input
> What:		/sys/.../iio:deviceX/in_proximityY_raw
> KernelVersion:	3.4
> Contact:	linux-iio@vger.kernel.org
> Description:
> 		Proximity measurement indicating that some
> 		object is near the sensor, usually by observing
> 		reflectivity of infrared or ultrasound emitted.
> 
> 		Often these sensors are unit less and as such conversion
> 		to SI units is not possible. Higher proximity measurements
> 		indicate closer objects, and vice versa. Units after
> 		application of scale and offset are meters.
> 
> So it kind of says we can't relate them to real units, but then we provide
> a unit. Hmm, not our finest and clearest documentation.
> 
> Probably best bet is to follow precedence as even if we haven't tightly defined
> it that is what any userspace tuning these value will be using.
> 
> Given inverse square law and different characteristics of reflective surfaces
> I think it is normally a case of crank the gain up until the signal is good.
> 
> In most cases these proximity sensors aren't much more than fancy switches
> though can be used for approaching vs moving away detection.
> 
> Anyhow, I haven't checked all the precedence in existing drivers but from
> memory scale is the standard choice.
> 
> Hardware gain as a writable control is just rarely used and only in devices where
> it doesn't affect what we are measuring. In proximity that means time of flight
> sensors, not ones based on reflected intensity.
> 
> Jonathan
> 

Hi Jonathan,

Thank you for the clarifications.
Please see v3.

Best regards,
Mikael 

