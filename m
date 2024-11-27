Return-Path: <linux-iio+bounces-12757-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76439DAF33
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 23:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B64281E6A
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 22:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBEB2036FC;
	Wed, 27 Nov 2024 22:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dimonoff.com header.i=@dimonoff.com header.b="nePqRHsK"
X-Original-To: linux-iio@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020075.outbound.protection.outlook.com [52.101.191.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3597E202F9C;
	Wed, 27 Nov 2024 22:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732745482; cv=fail; b=ibRGcKyE6ZZbES9k/yJ3zuKdC6oSlmpgbQCVF60Xm36voSPYPQbJJFv7cy313zj7TfC8p8BdJMs7vP78xRR4RmOkYS4K937sHOLHRTc2hyIHGnv8LgXcmqWz+SgOWezZRf9joqnJk+/dLvvZKVLoRHgrZB8wB+lONz6OZNeAhIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732745482; c=relaxed/simple;
	bh=jUYo9NT4VcrnlvckdEDLccm7YwSZwQIi6x/QXHxSsB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JFK34ERWpE8sPYBzkaFyuk5YiMyjYa6kY4ggnwgMYWxXpgn6u+hMRPMuJqcZ2h+o7IIdKsr2dGm1G03uc5OAKKHGsww2OCluT2HTQod/OgXF6M0CrEjImGkXsyG/m+l+ZFZW28r7sdi0/i355Ku+xv3y220MmZEjVpj8F9ok9OA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dimonoff.com; spf=pass smtp.mailfrom=dimonoff.com; dkim=pass (1024-bit key) header.d=dimonoff.com header.i=@dimonoff.com header.b=nePqRHsK; arc=fail smtp.client-ip=52.101.191.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dimonoff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dimonoff.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGmJmYkm1725fvsJ0J3hYeKvYtX1vam6sELwigUE2KMkFUc0+275s5DnPB4jBIlWHkzw5zuaG1usXHZD+YMxLGXk+L0Fy3qJKbwSJxcMiQT+u0mlEF2CuONV/HKemJ72h1ASrKbwDKdm6EHkLb/0tgql1hoFmFtzDap88Sz12bMUIMj/we6r6i8cfuucV+t21Yihc8FNAbdKiQj27dKGzcCHz9yzjqLmo/5XTZnih62ZItEpXfi+GHxM48koRz7a+jTaN6fRrAmOPoBovB8p1OxVmd0bJ1XO4PRKSocPLPHC/F4y4SyjY9+MVtP02vbeGT1QyF/7rOAmFgj0jVNM6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjGgjE+LHvtxqJE/dfxYWZsvfAvE+DSKjG8DP8LroBA=;
 b=rALjkdwONBDDv2xcQdSq94wxe7WD2FDFw+QQi21Tz9T77EYBIL7f2SMOYJz8vQ6IGDOsut1taY+SEaFaoLA1qWFGsWAasU6UM0gvr7CZUZ+4cSWr01KuSvGPMA/gajp5VhRAQhiEI0+TwNtaGprdq4et72aXniLZi4ZHEH3hg7/E9JFS9oZ8drdlQVxrxgcb00emnOWnOP71mcTZv/50SbMTxgJYmMZ4jES+RcFt6ts61dd6ZW0mDbJ9fju6W34vNUexsDNkmVJqhD2H05RHi2KfRsGsw6wznggR9wLtWe794mibfJeP+yWz6n1i5OjQ9VBTavimCqMKEuUT4K05Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dimonoff.com; dmarc=pass action=none header.from=dimonoff.com;
 dkim=pass header.d=dimonoff.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dimonoff.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjGgjE+LHvtxqJE/dfxYWZsvfAvE+DSKjG8DP8LroBA=;
 b=nePqRHsK5z0BwGusD6Ibf1LuAgbMKFJ4iWQd2BE+EN3gPemxpIQSpkxhKZ3SDfFIyA+jL9szi8cvR5nwqfx4pH9upz7TbKnz8x9lDAGN0y5eGFa6sOglNFwwb4aF4gObmu/9T43TRmrOfbJ8l3lDgz+CmKjOWXpvNXxYB4dE8/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dimonoff.com;
Received: from YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5c::20) by YT3PR01MB6081.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:5e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Wed, 27 Nov
 2024 22:11:15 +0000
Received: from YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9a4b:5f92:57f8:2a39]) by YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9a4b:5f92:57f8:2a39%4]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 22:11:15 +0000
Date: Wed, 27 Nov 2024 17:11:07 -0500
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
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 2/2] iio: light: Add APDS9160 ALS & Proximity sensor
 driver
Message-ID: <Z0eY+1X1ZSkNui9U@uva.nl>
References: <20241119-apds9160-driver-v1-0-fa00675b4ea4@dimonoff.com>
 <20241119-apds9160-driver-v1-2-fa00675b4ea4@dimonoff.com>
 <20241124211545.194a9f87@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241124211545.194a9f87@jic23-huawei>
X-ClientProxiedBy: YQBPR0101CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::39) To YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5c::20)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB9181:EE_|YT3PR01MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a3b789b-b705-4645-d02d-08dd0f30691e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?azv5buxzEtGRguQO7RutdsH+PnXaQKS7Dx0YqKzU5VMoW754GqoDSHIwJIYP?=
 =?us-ascii?Q?7fuPS6Dja4tMG//21kxmVBmhmli/kMrSi0rwRHPIEyCbfVoEAVDQdasgEl9q?=
 =?us-ascii?Q?oPf8Mk0Z+TTK8MHIrYOOiQcMUC4Z7FrfgsoaY8OSz4DrkYz2XDqbTZa7pDxd?=
 =?us-ascii?Q?7LUtzHEUyqBtYY1c0M9L+EUlcjQI4kyvyJRaA9M2VjztvWXezD2/8L9aExIA?=
 =?us-ascii?Q?Xxt92xKlLeqv/73JMyxADgPVMAiByo2JaRlPDShRwD0CLYVb5iRY2Tb/kLyA?=
 =?us-ascii?Q?RL4oJMVuvWN2yft7sRbFCDBY3j1nN23C98NG5e9Ux+0RfDqy6jewS3WE8FGr?=
 =?us-ascii?Q?al2EBpE4DvhwcwtBq0SHXxIsPN8EmPnE80xSTh9RfgsQCH5a4CCETR9B+U80?=
 =?us-ascii?Q?GV8I6ZXcryBckZp1rRBJ1kh/XXKrPfqw8J85l6nthxj9pHbjQ/1ZAwaDdyTJ?=
 =?us-ascii?Q?Oxbz2v1oet5f1EFMrSd1L0LINU9Haw7UnnrCiRvTy24wjlkdIPuKXQS1ubjS?=
 =?us-ascii?Q?NSWNb9Zshj4Vn7WwkBTINn9JOx+uh6Ll8BoKYnaVlVzveNGIwGShJQ+sPh3o?=
 =?us-ascii?Q?8ncfEBiHdGiNX+JEPjjzaKO44mHRmm9uXM1b0wUXvtoTwciQi//iaBDNEiFE?=
 =?us-ascii?Q?RUoc/ibi44VvUm2IVtlYbTWs6IifvFuXwDeCKsxsF2mHZZjeK/9G+2fRyx5n?=
 =?us-ascii?Q?AM6ep0j0AvkrE5C6HRpyYIxYebj8iqsPMGaEaC/NDV0ovglMylwvDWnmbl43?=
 =?us-ascii?Q?wuikQE+IicsPjvOdGLQjnV4Oyrw2RFfEkpFLO1yO4UyntJL0Ka+/L/JY8b6j?=
 =?us-ascii?Q?8gmSd+yxfb3yFqK+7VXA+yIDQZTYVawWjUS0Lfjs2PC/iPyWbBc1M55ksIu8?=
 =?us-ascii?Q?GzD6yvSZiGTIv8gGY+JVgK6VwGTCn8/AALumKnD2YDIEfugXfGUJzuadZGE3?=
 =?us-ascii?Q?MnA5BQCqmY0ENG/V1avEHDOgE/RAe5g27EAD7LEnyvGaO4XpGxGkkjhnq4XP?=
 =?us-ascii?Q?JoqfAMM6Zhs8es7tQL3CPJSekYoiniXtDs2853RpeF5HHOUKBYC8KVbR8Sx4?=
 =?us-ascii?Q?5J+mw3cSIME9akBNxHth/Jf+xc5lVxPDACeveBLJSV58odivm2yRFBZPhmNs?=
 =?us-ascii?Q?nEsZSBtxC23xtZNWG2KxkgzYAW8tsmWFOwS5C5sMgPbsQDvdy7hTZ5nv8N/O?=
 =?us-ascii?Q?DOtoz26PdP3s+dg8uywZc0tmHAPuYvcp+wF7IZMf2K/c3K+cipYulEsrygiB?=
 =?us-ascii?Q?fZnaxrVcE3QTL1PZLNgUGiHX/ZLwkLPnSpAobaBl/CkRdoOlLfAI2uwXpbmf?=
 =?us-ascii?Q?DctxkSDCudhDW/r9nFpY+ibdG9jTSmSKFg/AfguPN8JAEw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yyL7iNyjzUXKlfguNwMXJJEYsPw4CxNW/VCn+TNLBTYSPhlaMZ0wEW691BoP?=
 =?us-ascii?Q?jq+/WwjKFZLWf9bzvVrilic7RbOig6p+dIj9HzHbbSTxPA69XbaSbUAwWtDJ?=
 =?us-ascii?Q?RMtrfOQfdpBAmPNOqrjzOBDWrJLuKu+DY0CfAiLXSkcbi1OPyjb4/NsdHKIw?=
 =?us-ascii?Q?rs+LFbNgXxr8huu3PgMLbdvapSkH9f2wcODol/JjXcNgSOT7ZIyjrp0L3cHG?=
 =?us-ascii?Q?m64q8d2QBMFS0/mxocXA9FqZ97fvutuJI8Byubwls3yZjfM0dlGuUSHBSkv3?=
 =?us-ascii?Q?HIckB1cElTfW2oy9JXIELWhj2cOMViPW15t4y0X+Uk07t3lPQ3HDXqn5XUdh?=
 =?us-ascii?Q?5AzEqPUppquDd0d+etd6R1vWKQtH/duLz0cv4I9VkEpTk7Cap26BDzQa66a0?=
 =?us-ascii?Q?3YcbaRYyKTyzWqGyabPKeeA77e396EEhYSsconahwFhi9sllOZpfQvoeoA6O?=
 =?us-ascii?Q?pWYGF0qWg36OGv9fUHHrqrLy2NEck4hrQWzmqE0CXT6W8ZAsZuXd1OiU1dL2?=
 =?us-ascii?Q?NO1MK5iplXgMAwJ5pqAnE0fCG0lZBWGnxFy7grRRf5A3pHEMV2RVboMbdw9y?=
 =?us-ascii?Q?XWNxkKyhlH810wiNQPfIITuONwiVXAQfWX8v7uM2BqYsgmpbVpaQ5iQYZ9Ts?=
 =?us-ascii?Q?ALUeFygMG2t2yMlrGdhtKF4mMUhSoVMtqJ3MwS7sI6eBrwzVWFX47i0ARDi0?=
 =?us-ascii?Q?l5sl4t9aCBsj9WmCKLMRUAnxKIUu+7AXZ8VeXCgFArq/8XwMLJOvCPHMo5Hg?=
 =?us-ascii?Q?slwuOpUcpKqD3QzmM28yLw8ESV0XhyMI8J5CxkHkgJFb/Y77f3f+XgFPRJ5J?=
 =?us-ascii?Q?dtM3nIZTCZW+W6v17Ru7DPULJliK+acxR4cmbwfTWdfOP5pZH5IXU7WKr8mE?=
 =?us-ascii?Q?/2yLAj0QY1F4UzrtWRchMBp9FYifZ3B76vV2MDQ9oTC8h5gFSnjHzCej3k6W?=
 =?us-ascii?Q?D8BB6wZ26ESe9YZlFnNCj10SJ9oKXzzz2oOcJOuEYkp+sVB26QbX7rCgW/C1?=
 =?us-ascii?Q?7IUs2laalaxaR/4rMo8vm8gDSMakTtXOiVEQ9TSX8dYibQUeA2AlHXnxysd6?=
 =?us-ascii?Q?fGX45VnaMhKwBB9hC1cs6yuPmc1FCqNXzXhl+EEYOYSPmDewL5EUPTdTmS+7?=
 =?us-ascii?Q?GQC5gFuHvHWgN6F0Zz42dz4BJyjyX4bldZY55OZeEmSd34ZGJhyVGWnRNl6c?=
 =?us-ascii?Q?8brI9g3EevQRkZSDjz9mmkP+DH71zuUV0HLeI6Vjrk9tWTk4Xs6VuGe+WtHF?=
 =?us-ascii?Q?kp4+/Ve3RVW5xix0bhfEMPO2oqrkazpAmwIFLM9sEE9Ykn73VoCKxjz/ODA0?=
 =?us-ascii?Q?MJS4C7AWLJkkzhtEn+7oxldJJ22EHECgslj8AkK7kBD1HugfbAYq4AQFrRav?=
 =?us-ascii?Q?na2HK3eTT/g16W7OfWL5dHcJgg2VBJzi2Sw2ouDm26XC8oUt17cJRj4Vlcqm?=
 =?us-ascii?Q?zzT7Y6o4TOnKUPk38NIQ5YsUYLdJuMVNJWW8RWEL2yz4T1U37IJXTjYgnKur?=
 =?us-ascii?Q?c0unLeAtjjtzpyX4BOfesftA1wH1gxe5tUM9aR7ixT7z5XW36ZUthRvygBoJ?=
 =?us-ascii?Q?EnfEUsvb1CySQfRAdbEqRK1WEm4pTCejr7yqWCyoOFSQSwW84lm0T6RoTuul?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: dimonoff.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3b789b-b705-4645-d02d-08dd0f30691e
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 22:11:15.5580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c4063547-e5e6-4866-a386-58c3965da102
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4umkX+RWUSDuc9emA2NOx0iMv/L/NzFu1PQ4/2uvpQpSXpg+KmyBQYJaoB6ogYsSPs8HZZaKSTRyOPasmIRbLnd9c3lz+3moFS/Krga+d0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6081

On Sun, Nov 24, 2024 at 09:15:45PM +0000, Jonathan Cameron wrote:
> On Tue, 19 Nov 2024 15:36:57 -0500
> Mikael Gonella-Bolduc via B4 Relay <devnull+mgonellabolduc.dimonoff.com@kernel.org> wrote:
> 
> > From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
> > 
> > APDS9160 is a combination of ALS and proximity sensors.
> > 
> > This patch add supports for:
> >     - Intensity clear data and illuminance data
> >     - Proximity data
> >     - Gain control, rate control
> >     - Event thresholds
> > 
> > Signed-off-by: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
> Hi Mikael,
> 
> I may well repeat things you have already from the other reviewers!
> 
> Various comments inline.  Big one is that you register a buffer
> but no channels to be captured and never push any data to it.
> That looks like a workaround for something else?
> 
> Jonathan
> 
> 
> 
> > diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> > index f2f3e414849ab12a7c0ea2b08e9a3310eb18ebb7..69a59c6759acea89241ab76bfcdfafe3e5824066 100644
> > --- a/drivers/iio/light/Kconfig
> > +++ b/drivers/iio/light/Kconfig
> > @@ -63,6 +63,19 @@ config AL3320A
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called al3320a.
> >  
> > +config APDS9160
> > +	tristate "APDS9160 combined als and proximity sensors"
> > +	select REGMAP_I2C
> > +	select IIO_BUFFER
> > +	select IIO_KFIFO_BUF
> Normally I'd expect a light sensor to be providing a triggered buffer
> rather than using the kfifo path directly.
> 
> Also you never push anything into the buffer.
> 
> Normally we only skip the trigger (which allows other signals to be used
> to start a scan of the channels, or this trigger to capture on other sensors)
> if there is a hardware buffer involved so we can't identify each individual
> scan of the channels.
> 
> As it turns out you aren't doing buffered capture at all.
> 
> > +	depends on I2C
> > +	help
> > +	   Say Y here if you want to build a driver for Broadcom APDS9160
> > +	   combined ambient light and proximity sensor chip.
> > +
> > +	   To compile this driver as a module, choose M here: the
> > +	   module will be called apds9160. If unsure, say N here.
> > +
> 
> > diff --git a/drivers/iio/light/apds9160.c b/drivers/iio/light/apds9160.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..cb855f20725dba9fea1390a955889d905fd7eb4f
> > --- /dev/null
> > +++ b/drivers/iio/light/apds9160.c
> > @@ -0,0 +1,1420 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/**
> > + * This file is part of the APDS9160 sensor driver.
> > + * Chip is combined proximity and ambient light sensor.
> > + * Author: Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>
> > + */
> > +
> > +#include <linux/acpi.h>
> Why?
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/delay.h>
> > +#include <linux/mutex.h>
> > +#include <linux/err.h>
> > +#include <linux/irq.h>
> > +#include <linux/i2c.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/regmap.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/events.h>
> > +#include <linux/iio/kfifo_buf.h>
> > +#include <linux/iio/sysfs.h>
> > +
> > +#define APDS9160_DRIVER_NAME "apds9160"
> > +#define APDS9160_REGMAP_NAME "apds9160_regmap"
> > +#define APDS9160_STARTUP_DELAY 25000 /* us */
> > +#define APDS9160_REG_CNT 37
> > +
> > +/** Main control register */
> > +#define APDS9160_REG_CTRL 0x00
> > +#define APDS9160_REG_CTRL_SWRESET BIT(4) /* 1: Activate reset */
> > +#define APDS9160_REG_CTRL_MODE_RGB BIT(2) /* 0: ALS & IR, 1: RGB & IR */
> > +#define APDS9160_REG_CTRL_EN_ALS BIT(1) /* 1: ALS active */
> > +#define APDS9160_REG_CTLR_EN_PS BIT(0) /* 1: PS active */
> > +
> > +/** Status register  */
> Run kernel-doc over the file and fix everything. This is not
> kernel-doc so should not have /**
> 
> > +#define APDS9160_REG_SR_LS_INT BIT(3)
> > +#define APDS9160_REG_SR_LS_NEW_DATA BIT(2)
> > +#define APDS9160_REG_SR_PS_INT BIT(1)
> > +#define APDS9160_REG_SR_PS_NEW_DATA BIT(0)
> > +
> > +/* Interrupt configuration register */
> > +#define APDS9160_REG_INT_CFG 0x19
> > +#define APDS9160_REG_INT_CFG_EN_LS BIT(2) /* LS int enable */
> > +#define APDS9160_REG_INT_CFG_EN_PS BIT(0) /* PS int enable */
> > +#define APDS9160_REG_INT_PST 0x1A
> > +
> > +/* Proximity registers */
> > +#define APDS9160_REG_PS_LED 0x01
> > +#define APDS9160_REG_PS_PULSES 0x02
> > +#define APDS9160_REG_PS_MEAS_RATE 0x03
> > +#define APDS9160_REG_PS_THRES_HI_LSB 0x1B
> > +#define APDS9160_REG_PS_THRES_HI_MSB 0x1C
> > +#define APDS9160_REG_PS_THRES_LO_LSB 0x1D
> > +#define APDS9160_REG_PS_THRES_LO_MSB 0x1E
> > +#define APDS9160_REG_PS_DATA_LSB 0x08
> > +#define APDS9160_REG_PS_DATA_MSB 0x09
> > +#define APDS9160_REG_PS_CAN_LEVEL_DIG_LSB 0x1F
> > +#define APDS9160_REG_PS_CAN_LEVEL_DIG_MSB 0x20
> > +#define APDS9160_REG_PS_CAN_LEVEL_ANA_DUR 0x21
> > +#define APDS9160_REG_PS_CAN_LEVEL_ANA_CURRENT 0x22
> > +
> > +/* Light sensor registers */
> > +#define APDS9160_REG_LS_MEAS_RATE 0x04
> > +#define APDS9160_REG_LS_GAIN 0x05
> > +#define APDS9160_REG_LS_DATA_CLEAR_LSB 0x0A
> > +#define APDS9160_REG_LS_DATA_CLEAR 0x0B
> > +#define APDS9160_REG_LS_DATA_CLEAR_MSB 0x0C
> > +#define APDS9160_REG_LS_DATA_ALS_LSB 0x0D
> > +#define APDS9160_REG_LS_DATA_ALS 0x0E
> > +#define APDS9160_REG_LS_DATA_ALS_MSB 0x0F
> > +#define APDS9160_REG_LS_THRES_UP_LSB 0x24
> > +#define APDS9160_REG_LS_THRES_UP 0x25
> > +#define APDS9160_REG_LS_THRES_UP_MSB 0x26
> > +#define APDS9160_REG_LS_THRES_LO_LSB 0x27
> > +#define APDS9160_REG_LS_THRES_LO 0x28
> > +#define APDS9160_REG_LS_THRES_LO_MSB 0x29
> > +#define APDS9160_REG_LS_THRES_VAR 0x2A
> > +
> > +/** Part identification number register */
> > +#define APDS9160_REG_ID 0x06
> > +
> > +/** Status register */
> > +#define APDS9160_REG_SR 0x07
> > +#define APDS9160_REG_SR_DATA_ALS BIT(3)
> 
> One trick to make it obvious what is a field and what
> a register is don't include the _REG bit in
> the field defines.
> 
> > +#define APDS9160_REG_SR_DATA_PS BIT(0)
> > +
> > +/* Supported ID:s */
> > +#define APDS9160_PART_ID_0 0x00
> > +#define APDS9160_PART_ID_MASK 0xF0
> > +#define APDS9160_PART_REV_MASK 0x0F
> > +
> > +#define APDS9160_PS_THRES_MAX 0x7FF
> > +#define APDS9160_LS_THRES_MAX 0xFFFFF
> > +#define APDS9160_CMD_LS_RESOLUTION_25MS 0x04
> > +#define APDS9160_CMD_LS_RESOLUTION_50MS 0x03
> > +#define APDS9160_CMD_LS_RESOLUTION_100MS 0x02
> > +#define APDS9160_CMD_LS_RESOLUTION_200MS 0x01
> > +#define APDS9160_PS_DATA_MASK 0x7FF
> > +
> > +#define APDS9160_DEFAULT_LS_GAIN 3
> > +#define APDS9160_DEFAULT_LS_RATE 100
> > +#define APDS9160_DEFAULT_PS_RATE 100
> > +#define APDS9160_DEFAULT_PS_CANCELLATION_LEVEL 0
> > +#define APDS9160_DEFAULT_PS_ANALOG_CANCELLATION 0
> > +#define APDS9160_DEFAULT_PS_GAIN 1
> > +#define APDS9160_DEFAULT_PS_CURRENT 100
> > +#define APDS9160_DEFAULT_PS_RESOLUTION 0x03 // 11 bits
> Name so that it is obvious it is the value for 11 bits.
> 
> > +
> > +// clang-format off
> > +static const struct reg_default apds9160_reg_defaults[] = {
> you can explicitly tell regmap to write these to the device. That will save
> a bunch of init code.
> 
> > +	{ APDS9160_REG_CTRL, 0x00 }, /* Sensors disabled by default  */
> > +	{ APDS9160_REG_PS_LED, 0x33 }, /* 60 kHz frequency, 100 mA pulse current */
> > +	{ APDS9160_REG_PS_PULSES, 0x08 }, /* 8 pulses */
> > +	{ APDS9160_REG_PS_MEAS_RATE, 0x05 },
> > +	{ APDS9160_REG_LS_MEAS_RATE, 0x22 },
> > +	{ APDS9160_REG_LS_GAIN, 0x01 },
> > +	{ APDS9160_REG_INT_CFG, 0x10 },
> > +	{ APDS9160_REG_INT_PST, 0x00 },
> > +	{ APDS9160_REG_PS_THRES_HI_LSB, 0xFF },
> > +	{ APDS9160_REG_PS_THRES_HI_MSB, 0x07 },
> > +	{ APDS9160_REG_PS_THRES_LO_LSB, 0x00 },
> > +	{ APDS9160_REG_PS_THRES_LO_MSB, 0x00 },
> > +	{ APDS9160_REG_PS_CAN_LEVEL_DIG_LSB, 0x00 },
> > +	{ APDS9160_REG_PS_CAN_LEVEL_DIG_MSB, 0x00 },
> > +	{ APDS9160_REG_PS_CAN_LEVEL_ANA_DUR, 0x00 },
> > +	{ APDS9160_REG_PS_CAN_LEVEL_ANA_CURRENT, 0x00 },
> > +	{ APDS9160_REG_LS_THRES_UP_LSB, 0xFF },
> > +	{ APDS9160_REG_LS_THRES_UP, 0xFF },
> > +	{ APDS9160_REG_LS_THRES_UP_MSB, 0x0F },
> > +	{ APDS9160_REG_LS_THRES_LO_LSB, 0x00 },
> > +	{ APDS9160_REG_LS_THRES_LO, 0x00 },
> > +	{ APDS9160_REG_LS_THRES_LO_MSB, 0x00 },
> > +	{ APDS9160_REG_LS_THRES_VAR, 0x00 },
> > +};
> > +// clang-format on
> 
> > +
> > +static const struct iio_event_spec apds9160_ps_event_spec[] = {
> > +	{
> > +		.type = IIO_EV_TYPE_THRESH,
> > +		.dir = IIO_EV_DIR_RISING,
> > +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> Given they are the same, why not use same event_spec array for als and ps.
> 
> > +	},
> > +	{
> > +		.type = IIO_EV_TYPE_THRESH,
> > +		.dir = IIO_EV_DIR_FALLING,
> > +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> > +	},
> > +	{
> > +		.type = IIO_EV_TYPE_THRESH,
> > +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> > +	},
> > +};
> > +
> > +static const struct iio_event_spec apds9160_als_event_spec[] = {
> > +	{
> > +		.type = IIO_EV_TYPE_THRESH,
> > +		.dir = IIO_EV_DIR_RISING,
> > +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> > +	},
> > +	{
> > +		.type = IIO_EV_TYPE_THRESH,
> > +		.dir = IIO_EV_DIR_FALLING,
> > +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> > +	},
> > +	{
> Explicitly set DIR_EITHER here.  It's not a completely obvious default
> > +		.type = IIO_EV_TYPE_THRESH,
> > +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> > +	},
> > +};
> > +
> > +static const struct iio_chan_spec apds9160_channels[] = {
> > +	{
> > +		/* Proximity sensor channel */
> > +		.type = IIO_PROXIMITY,
> > +		.address = APDS9160_REG_PS_DATA_LSB,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > +					    BIT(IIO_CHAN_INFO_CALIBSCALE) |
> > +					    BIT(IIO_CHAN_INFO_HARDWAREGAIN) |
> > +					    BIT(IIO_CHAN_INFO_CALIBBIAS),
> > +		.channel = 0,
> > +		.indexed = 0,
> > +		.scan_index = -1,
> No need to set scan_index if you don't register a buffer (which you shouldn't
> without more work and these having actual values).
> > +
> > +		.event_spec = apds9160_ps_event_spec,
> > +		.num_event_specs = ARRAY_SIZE(apds9160_ps_event_spec),
> > +	},
> > +	{
> > +		/* Proximity sensor led current */
> > +		.type = IIO_CURRENT,
> > +		.output = 1,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +		.scan_index = -1,
> > +	},
> > +	{
> > +		/* Clear channel */
> > +		.type = IIO_INTENSITY,
> > +		.address = APDS9160_REG_LS_DATA_CLEAR_LSB,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_INT_TIME) |
> > +					    BIT(IIO_CHAN_INFO_HARDWAREGAIN) |
> > +					    BIT(IIO_CHAN_INFO_SCALE),
> > +		.channel2 = IIO_MOD_LIGHT_CLEAR,
> > +		.modified = 1,
> > +		.scan_index = -1,
> > +
> > +		.event_spec = apds9160_als_event_spec,
> > +		.num_event_specs = ARRAY_SIZE(apds9160_als_event_spec),
> > +	},
> > +	{
> > +		/* Illuminance */
> > +		.type = IIO_LIGHT,
> > +		.address = APDS9160_REG_LS_DATA_ALS_LSB,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> > +		.scan_index = -1,
> > +	}
> > +};
> > +
> > +/* Attributes */
> > +// clang-format off
> > +static const int apds9160_als_rate_map[][2] = {
> > +	{ 25, 0x00 },
> > +	{ 50, 0x01 },
> > +	{ 100, 0x02 },
> > +	{ 200, 0x03 }
> > +};
> > +
> > +static const int apds9160_als_gain_map[][2] = {
> > +	{ 1, 0x00 },
> > +	{ 3, 0x01 },
> > +	{ 6, 0x02 },
> > +	{ 18, 0x03 },
> > +	{ 64, 0x04 }
> > +};
> > +
> > +static const int apds9160_ps_gain_map[][2] = {
> > +	{ 1, 0x00 },
> > +	{ 2, 0x01},
> > +	{ 4, 0x02},
> > +	{ 8, 0x03}
> Make spacing consistent throughout. Same as first
> line here looks good.
> 
> > +};
> > +
> > +static const int apds9160_ps_rate_map[][2] = {
> > +	{ 25, 0x03 },
> > +	{ 50, 0x04 },
> > +	{ 100, 0x05 },
> > +	{ 200, 0x06 },
> > +	{ 400, 0x07 }
> > +};
> > +
> > +static const int adps9160_ps_led_current_map[][2] = {
> > +	{ 10, 0x00 },
> > +	{ 25, 0x01 },
> > +	{ 50, 0x02 },
> > +	{ 100, 0x03 },
> > +	{ 150, 0x04},
> > +	{ 175, 0x05 },
> > +	{ 200, 0x06 }
> Add trailing commas. In theory we might have more values to add
> (though very unlikely).
> > +};
> > +// clang-format on
> No to these Just ignore what clang-format tries to do.
> It should be treated as hints, not rules for kernel code.
> > +
> > +struct apds9160_scale {
> > +	int itime;
> > +	int gain;
> > +	int scale1;
> > +	int scale2;
> > +};
> > +
> > +static const struct apds9160_scale apds9160_als_scale_map[] = {
> > +	{
> > +		.gain = 1,
> > +		.itime = 25,
> > +		.scale1 = 3272,
> > +		.scale2 = 1000,
> 
> No way to compute scale from gain and itime?  If not I'm not sure
> if we can use the gts helpers.
> 
> > +	},
> > +	{
> > +		.gain = 1,
> > +		.itime = 50,
> > +		.scale1 = 1639,
> > +		.scale2 = 1000,
> > +	},
> > +	{
> > +		.gain = 1,
> > +		.itime = 100,
> > +		.scale1 = 819,
> > +		.scale2 = 1000,
> > +	},
> > +	{
> > +		.gain = 3,
> > +		.itime = 25,
> > +		.scale1 = 1077,
> > +		.scale2 = 1000,
> > +	},
> > +	{
> > +		.gain = 3,
> > +		.itime = 50,
> > +		.scale1 = 538,
> > +		.scale2 = 1000,
> > +	},
> > +	{
> > +		.gain = 3,
> > +		.itime = 100,
> > +		.scale1 = 269,
> > +		.scale2 = 1000,
> > +	},
> > +	{
> > +		.gain = 6,
> > +		.itime = 25,
> > +		.scale1 = 525,
> > +		.scale2 = 1000,
> > +	},
> > +	{
> > +		.gain = 6,
> > +		.itime = 50,
> > +		.scale1 = 263,
> > +		.scale2 = 1000,
> > +	},
> > +	{
> > +		.gain = 6,
> > +		.itime = 100,
> > +		.scale1 = 131,
> > +		.scale2 = 1000,
> > +	},
> > +	{
> > +		.gain = 18,
> > +		.itime = 25,
> > +		.scale1 = 169,
> > +		.scale2 = 1000,
> > +	},
> > +	{
> > +		.gain = 18,
> > +		.itime = 50,
> > +		.scale1 = 84,
> > +		.scale2 = 1000,
> > +	},
> > +	{
> > +		.gain = 18,
> > +		.itime = 100,
> > +		.scale1 = 42,
> > +		.scale2 = 1000,
> > +	},
> > +	{
> > +		.gain = 64,
> > +		.itime = 25,
> > +		.scale1 = 49,
> > +		.scale2 = 1000,
> > +	},
> > +	{
> > +		.gain = 64,
> > +		.itime = 50,
> > +		.scale1 = 25,
> > +		.scale2 = 1000,
> > +	},
> > +	{
> > +		.gain = 64,
> > +		.itime = 100,
> > +		.scale1 = 12,
> > +		.scale2 = 1000,
> > +	},
> > +};
> > +
> > +static IIO_CONST_ATTR(in_intensity_integration_time_available, "25 50 100 200");
> > +static IIO_CONST_ATTR(in_proximity_sampling_frequency_available,
> > +		      "25 50 100 200 400");
> > +static IIO_CONST_ATTR(in_intensity_hardwaregain_available, "1 3 6 18 64");
> > +static IIO_CONST_ATTR(in_proximity_hardwaregain_available, "1 2 4 8");
> > +static IIO_CONST_ATTR(out_current_available, "10 25 50 100 150 175 200");
> Use read_avail and appropriate masks. 
> 
> Whilst we used to do it with explicit attributes for modern drivers we like
> to make the data available to in kernel users and ensure there is only one
> source of the values by using the same arrays for matching write values.
> 
> > +
> > +static struct attribute *apds9160_attributes[] = {
> > +	&iio_const_attr_in_intensity_integration_time_available.dev_attr.attr,
> > +	&iio_const_attr_in_intensity_hardwaregain_available.dev_attr.attr,
> > +	&iio_const_attr_in_proximity_sampling_frequency_available.dev_attr.attr,
> > +	&iio_const_attr_in_proximity_hardwaregain_available.dev_attr.attr,
> > +	&iio_const_attr_out_current_available.dev_attr.attr,
> > +	NULL,
> No comma on NULL terminators. However, no reason any of these should
> need to be handled with custom attributes.
> 
> > +};
> > +
> > +
> > +struct apds9160_chip {
> > +	struct i2c_client *client;
> > +	struct iio_dev *indio_dev;
> That sets alarm bells off. If you ever need to go from
> iio_priv() to struct iio_dev then you almost certainly need to rethink your
> design.  Thankfully I think you only ever set this.  Drop it.
> 
> > +	struct regmap *regmap;
> > +	struct mutex lock; /* avoid parallel access */
> You already have feedback on this comment so I won't add anything.
> 
> > +
> > +	struct regmap_field *reg_enable_ps;
> > +	struct regmap_field *reg_enable_als;
> > +	struct regmap_field *reg_int_ps;
> > +	struct regmap_field *reg_int_als;
> > +	struct regmap_field *reg_ps_overflow;
> > +	struct regmap_field *reg_als_rate;
> > +	struct regmap_field *reg_als_resolution;
> > +	struct regmap_field *reg_ps_rate;
> > +	struct regmap_field *reg_als_gain;
> > +	struct regmap_field *reg_ps_current;
> > +	struct regmap_field *reg_ps_gain;
> > +	struct regmap_field *reg_ps_resolution;
> > +
> > +	/* State data */
> > +	u8 revision;
> > +	int als_int;
> > +	int ps_int;
> > +
> > +	/* Configuration values */
> > +	int als_itime;
> These are all caches of register values. Maybe simpler to just enable the regmap
> cache and read them back form the cached versions of the hardware registers.
> > +	int als_hwgain;
> > +	int als_scale1;
> > +	int als_scale2;
> > +	int ps_rate;
> > +	int ps_cancellation_level;
> > +	int ps_cancellation_analog;
> > +	int ps_current;
> > +	int ps_gain;
> > +};
> > +
> > +static const struct i2c_device_id apds9160_id[] = { { APDS9160_DRIVER_NAME, 0 },
> > +						    {} };
> Move this down to just before where it is used.
> Also, just hard code the string. It is much easier to grep for then as no reason
> the name in the device id should match the driver name.
> 
> > +
> > +/** Called when mutex is locked */
> Not kernel doc so /* only.
> > +static void apds9160_set_scale(struct apds9160_chip *data)
> > +{
> > +	for (int idx = 0; idx < ARRAY_SIZE(apds9160_als_scale_map); idx++) {
> > +		if (data->als_hwgain == apds9160_als_scale_map[idx].gain &&
> > +		    data->als_itime == apds9160_als_scale_map[idx].itime) {
> > +			data->als_scale1 = apds9160_als_scale_map[idx].scale1;
> > +			data->als_scale2 = apds9160_als_scale_map[idx].scale2;
> > +		}
> > +	}
> > +}
> 
> 
> > +/**
> > + * This parameter determines the cancellation pulse duration in each of the PWM pulse.
> > + * The cancellation is applied during the integration phase of the PS measurement.
> > + * Duration is programmed in half clock cycles
> This is unusual. and I don't really understand how it works.
> > + */
> > +static int apds9160_set_ps_analog_cancellation(struct apds9160_chip *data,
> > +					       int val)
> > +{
> > +	int ret = -EINVAL;
> overwritten in all paths where it is used.
> > +
> > +	dev_dbg(&data->client->dev, "%s - set analog cancellation to %i\n",
> > +		__func__, val);
> > +	if (val < 0 || val > 0x3F)
> > +		return ret;
> > +
> > +	mutex_lock(&data->lock);
> > +	ret = regmap_write(data->regmap, APDS9160_REG_PS_CAN_LEVEL_ANA_DUR,
> > +			   val);
> > +	if (!ret)
> Always keep error paths out of line.  It just makes things more consistent
> and hence easier to review.
> 
> The cleanup.h magic like guard() can help a lot with keeping code simple when
> doing early returns.
> 
> > +		data->ps_cancellation_analog = val;
> > +	mutex_unlock(&data->lock);
> > +	return ret;
> > +}
> > +
> > +/**
> Not kernel doc so /* only.
> > + * Set the proximity sensor led current
> > + */
> > +static int apds9160_set_ps_current(struct apds9160_chip *data, int val)
> > +{
> > +	int ret = -EINVAL;
> > +	int idx;
> > +
> > +	dev_dbg(&data->client->dev, "%s - set current to %i\n", __func__, val);
> > +	for (idx = 0; idx < ARRAY_SIZE(adps9160_ps_led_current_map); idx++) {
> > +		if (adps9160_ps_led_current_map[idx][0] == val) {
> > +			mutex_lock(&data->lock);
> I'd suggest changes similar to what I said for the next function
> > +			ret = regmap_field_write(
> > +				data->reg_ps_current,
> > +				adps9160_ps_led_current_map[idx][1]);
> > +
> > +			if (!ret)
> > +				data->ps_current = val;
> > +
> > +			mutex_unlock(&data->lock);
> > +			break;
> > +		}
> > +	}
> > +	return ret;
> > +}
> > +
> > +static int apds9160_set_als_gain(struct apds9160_chip *data, int val)
> > +{
> > +	int ret = -EINVAL;
> > +	int idx;
> > +
> > +	dev_dbg(&data->client->dev, "%s - set als gain to %i\n", __func__, val);
> > +	for (idx = 0; idx < ARRAY_SIZE(apds9160_als_gain_map); idx++) {
> > +		if (apds9160_als_gain_map[idx][0] == val) {
> 
> Flip this to reduce indent and give more readable code.
> 
> 		if (apds9160_als_gain_map[idx][0] != val)
> 			continue;
> 
> 
> > +			mutex_lock(&data->lock);
> guard(mutex)(&data-<lock).
> > +			ret = regmap_field_write(data->reg_als_gain,
> > +						 apds9160_als_gain_map[idx][1]);
> 			if (ret)
> 				return ret;
> 			data->als_hwgain = val...
> 
> > +			if (!ret) {
> > +				data->als_hwgain = val;
> > +				apds9160_set_scale(data);
> > +			}
> > +			mutex_unlock(&data->lock);
> > +			break;
> > +		}
> > +	}
> > +	return ret;
> > +}
> > +
> > +static int apds9160_set_als_int_time(struct apds9160_chip *data, int val)
> > +{
> > +	int ret = -EINVAL;
> > +	int idx;
> > +
> > +	dev_dbg(&data->client->dev, "%s - set int time to %i\n", __func__, val);
> > +	for (idx = 0; idx < ARRAY_SIZE(apds9160_als_rate_map); idx++) {
> > +		if (apds9160_als_rate_map[idx][0] == val) {
> Flip logic and use a continue to reduce indent for what follows (see example below).
> 
> > +			mutex_lock(&data->lock);
> guard(mutex)(&data->lock);
> 
> > +			ret = regmap_field_write(data->reg_als_rate,
> > +						 apds9160_als_rate_map[idx][1]);
> > +			if (!ret) {
> 			if (ret)
> 				return ret;
> 
> 			data->als_itime = val;
> 			
> 				
> > +				data->als_itime = val;
> > +				/* Lower resolution for faster rates */
> > +				switch (val) {
> > +				case 25:
> > +					ret = regmap_field_write(
> > +						data->reg_als_resolution,
> > +						APDS9160_CMD_LS_RESOLUTION_25MS);
> > +					break;
> > +				case 50:
> > +					ret = regmap_field_write(
> > +						data->reg_als_resolution,
> > +						APDS9160_CMD_LS_RESOLUTION_50MS);
> > +					break;
> > +				case 200:
> > +					ret = regmap_field_write(
> > +						data->reg_als_resolution,
> > +						APDS9160_CMD_LS_RESOLUTION_200MS);
> > +					break;
> > +				default:
> > +					ret = regmap_field_write(
> > +						data->reg_als_resolution,
> > +						APDS9160_CMD_LS_RESOLUTION_100MS);
> > +				}
> > +				apds9160_set_scale(data);
> > +			}
> > +			mutex_unlock(&data->lock);
> > +			break;
> > +		}
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int apds9160_read_raw(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan, int *val,
> > +			     int *val2, long mask)
> > +{
> > +	struct apds9160_chip *data = iio_priv(indio_dev);
> > +	int ret = -EINVAL;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		switch (chan->type) {
> > +		case IIO_PROXIMITY: {
> > +			__le16 buf;
> > +
> > +			ret = regmap_bulk_read(data->regmap, chan->address,
> > +					       &buf, 2);
> Should be a dma safe buffer for any bulk accesses.
> > +			if (!ret) {
> Flip logic to return in error path.
> 			if (ret)
> 				return ret;
> 
> 			*val = le16_to_cpu(buf);
> 			*val = FIELD_GET() for what you want, not masking what you don't.
> 
> > +				ret = IIO_VAL_INT;
> > +				*val = le16_to_cpu(buf);
> > +				// Remove data overflow and ambient light overflow bits from result
> 
> /* */
> 
> > +				*val &= APDS9160_PS_DATA_MASK;
> > +			}
> > +		} break;
> > +		case IIO_LIGHT:
> > +		case IIO_INTENSITY: {
> > +			__le32 buf = 0;
> > +
> > +			ret = regmap_bulk_read(data->regmap, chan->address,
> > +					       &buf, 3);
> as below. Use a u8 [3]  and get_unaligned_le24()
> 
> > +			if (!ret) {
> > +				ret = IIO_VAL_INT;
> > +				*val = le32_to_cpu(buf);
> > +			}
> > +		} break;
> > +		case IIO_CURRENT: {
> {} not needed.
> > +			ret = IIO_VAL_INT;
> > +			*val = data->ps_current;
> > +		} break;
> > +		default:
> > +			break;
> > +		}
> > +		break;
> > +	case IIO_CHAN_INFO_HARDWAREGAIN:
> As for the write, this is unlikely to be the right interface
> but I'm not 100% sure what the various gain related controls
> are affecting.  I haven't dog into the datasheet yet and
> won't get time today.
> 
> > +		switch (chan->type) {
> > +		case IIO_INTENSITY:
> > +			ret = IIO_VAL_INT;
> > +			*val = data->als_hwgain;
> > +			break;
> > +		case IIO_PROXIMITY:
> > +			ret = IIO_VAL_INT;
> > +			*val = data->ps_gain;
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +		break;
> > +	case IIO_CHAN_INFO_INT_TIME:
> > +		switch (chan->type) {
> > +		case IIO_INTENSITY:
> > +			ret = IIO_VAL_INT;
> > +			*val = data->als_itime;
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +		break;
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		switch (chan->type) {
> > +		case IIO_PROXIMITY:
> > +			ret = IIO_VAL_INT;
> > +			*val = data->ps_rate;
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +		break;
> > +	case IIO_CHAN_INFO_CALIBSCALE:
> > +		switch (chan->type) {
> > +		case IIO_PROXIMITY:
> > +			ret = IIO_VAL_INT;
> > +			*val = data->ps_cancellation_level;
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +		break;
> > +	case IIO_CHAN_INFO_CALIBBIAS:
> > +		switch (chan->type) {
> > +		case IIO_PROXIMITY:
> > +			ret = IIO_VAL_INT;
> > +			*val = data->ps_cancellation_analog;
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +		break;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		switch (chan->type) {
> > +		case IIO_LIGHT:
> > +		case IIO_INTENSITY:
> > +			ret = IIO_VAL_FRACTIONAL;
> > +			*val = data->als_scale1;
> > +			*val2 = data->als_scale2;
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return ret;
> > +};
> > +
> > +static int apds9160_write_raw(struct iio_dev *indio_dev,
> > +			      struct iio_chan_spec const *chan, int val,
> > +			      int val2, long mask)
> > +{
> > +	struct apds9160_chip *data = iio_priv(indio_dev);
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_INT_TIME:
> > +		if (val2 != 0)
> > +			return -EINVAL;
> > +		switch (chan->type) {
> > +		case IIO_INTENSITY:
> > +			return apds9160_set_als_int_time(data, val);
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		if (val2 != 0)
> > +			return -EINVAL;
> > +		switch (chan->type) {
> > +		case IIO_PROXIMITY:
> > +			return apds9160_set_ps_rate(data, val);
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_HARDWAREGAIN:
> 
> This is rarely used unless for time of flight sensors.  That is where
> you are controlling the gain on something not directly related to the
> signal you are reading. Here if it affects the read out value such that
> _raw * _scale should include it then use _scale, otherwise should be
> incorporated in calibscale. 
> 
> If it is _scale then the code will be fiddly but you need to present
> the scales that are appropriate for the current integration time.
> 
> It may be worth looking at the GTS helpers that assist with cases
> where there are complex controls interacting around gain of the
> sensor.
> 
> > +		if (val2 != 0)
> > +			return -EINVAL;
> > +		switch (chan->type) {
> > +		case IIO_INTENSITY:
> > +			return apds9160_set_als_gain(data, val);
> > +		case IIO_PROXIMITY:
> > +			return apds9160_set_ps_gain(data, val);
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_CALIBSCALE:
> > +		if (val2 != 0)
> > +			return -EINVAL;
> > +		switch (chan->type) {
> > +		case IIO_PROXIMITY:
> > +			return apds9160_set_ps_cancellation_level(data, val);
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_CALIBBIAS:
> > +		if (val2 != 0)
> > +			return -EINVAL;
> > +		switch (chan->type) {
> > +		case IIO_PROXIMITY:
> > +			return apds9160_set_ps_analog_cancellation(data, val);
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_RAW:
> > +		if (val2 != 0)
> > +			return -EINVAL;
> > +		switch (chan->type) {
> > +		case IIO_CURRENT:
> > +			return apds9160_set_ps_current(data, val);
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static inline int apds9160_get_thres_reg(const struct iio_chan_spec *chan,
> > +					 enum iio_event_direction dir, u8 *reg)
> > +{
> > +	switch (dir) {
> > +	case IIO_EV_DIR_RISING:
> > +		switch (chan->type) {
> > +		case IIO_PROXIMITY:
> > +			*reg = APDS9160_REG_PS_THRES_HI_LSB;
> > +			break;
> > +		case IIO_INTENSITY:
> > +			*reg = APDS9160_REG_LS_THRES_UP_LSB;
> > +			break;
> return from these rather than breaking.
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +		break;
> Then this won't be reachable.
> > +	case IIO_EV_DIR_FALLING:
> > +		switch (chan->type) {
> > +		case IIO_PROXIMITY:
> > +			*reg = APDS9160_REG_PS_THRES_LO_LSB;
> > +			break;
> > +		case IIO_INTENSITY:
> > +			*reg = APDS9160_REG_LS_THRES_LO_LSB;
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> And neither will this.
> > +
> > +	return 0;
> > +}
> > +
> > +static int apds9160_read_event(struct iio_dev *indio_dev,
> > +			       const struct iio_chan_spec *chan,
> > +			       enum iio_event_type type,
> > +			       enum iio_event_direction dir,
> > +			       enum iio_event_info info, int *val, int *val2)
> > +{
> > +	u8 reg;
> > +
> > +	int ret = 0;
> > +	struct apds9160_chip *data = iio_priv(indio_dev);
> > +
> > +	if (info != IIO_EV_INFO_VALUE)
> > +		return -EINVAL;
> > +
> > +	ret = apds9160_get_thres_reg(chan, dir, &reg);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (chan->type == IIO_PROXIMITY) {
> 
> Probably clearer as a switch.
> 
> > +		__le16 buf;
> > +
> > +		ret = regmap_bulk_read(data->regmap, reg, &buf, 2);
> > +		if (ret < 0)
> > +			return ret;
> > +		*val = le16_to_cpu(buf);
> > +	} else if (chan->type == IIO_INTENSITY) {
> > +		__le32 buf = 0;
> > +
> > +		ret = regmap_bulk_read(data->regmap, reg, &buf, 3);
> 
> It's not an __le32 if you are reading only 3 bytes. Use a u8 [3]
> and get_unaligned_le24()
> 
> > +		if (ret < 0)
> > +			return ret;
> > +		*val = le32_to_cpu(buf);
> > +	} else
> > +		return -EINVAL;
> > +
> > +	*val2 = 0;
> No need to set if returning IIO_VAL_INT as won't be used.
> 
> > +
> > +	return IIO_VAL_INT;
> > +}
> > +
> > +static int apds9160_write_event(struct iio_dev *indio_dev,
> > +				const struct iio_chan_spec *chan,
> > +				enum iio_event_type type,
> > +				enum iio_event_direction dir,
> > +				enum iio_event_info info, int val, int val2)
> > +{
> > +	u8 reg;
> > +	int ret = 0;
> > +	struct apds9160_chip *data = iio_priv(indio_dev);
> > +
> > +	if (info != IIO_EV_INFO_VALUE)
> > +		return -EINVAL;
> > +
> > +	ret = apds9160_get_thres_reg(chan, dir, &reg);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (chan->type == IIO_PROXIMITY) {
> > +		if (val < 0 || val > APDS9160_PS_THRES_MAX)
> > +			return -EINVAL;
> > +		__le16 buf;
> > +
> > +		buf = cpu_to_le16(val);
> > +		ret = regmap_bulk_write(data->regmap, reg, &buf, 2);
> Needs to be a dma safe buffer.  In practice this probably won't cause
> a bug but that is down to subtle internals of regmap and there is
> no guarantee that future optimizations won't again require a DMA safe
> buffer.  This what the __aligned(IIO_DMA_MINALIGN) stuff is about.
> 
> > +		if (ret < 0)
> > +			return ret;
> > +	} else if (chan->type == IIO_INTENSITY) {
> > +		if (val < 0 || val > APDS9160_LS_THRES_MAX)
> > +			return -EINVAL;
> > +		__le32 buf = 0;
> 
> Variables should almost always be declared at top of scope or just put
> them at top of function if that is more appropraite.
> 
> > +
> > +		buf = cpu_to_le32(val);
> > +		ret = regmap_bulk_write(data->regmap, reg, &buf, 3);
> > +		if (ret < 0)
> > +			return ret;
> 		return regmap_bulk_write()
> 
> > +	} else
> > +		return -EINVAL;
> Probably neater to use a switch statement and default to cath this last one.
> > +
> > +	return 0;
> > +}
> > +
> > +static int apds9160_read_event_config(struct iio_dev *indio_dev,
> > +				      const struct iio_chan_spec *chan,
> > +				      enum iio_event_type type,
> > +				      enum iio_event_direction dir)
> > +{
> > +	struct apds9160_chip *data = iio_priv(indio_dev);
> > +
> > +	switch (chan->type) {
> > +	case IIO_PROXIMITY:
> > +		return data->ps_int;
> > +	case IIO_INTENSITY:
> > +		return data->als_int;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> Unreachable so drop this.
> 
> > +}
> > +
> > +static int apds9160_write_event_config(struct iio_dev *indio_dev,
> > +				       const struct iio_chan_spec *chan,
> > +				       enum iio_event_type type,
> > +				       enum iio_event_direction dir, int state)
> > +{
> > +	struct apds9160_chip *data = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	state = !!state;
> > +
> > +	switch (chan->type) {
> > +	case IIO_PROXIMITY:
> > +		if (data->ps_int == state)
> > +			return -EINVAL;
> > +
> > +		ret = regmap_field_write(data->reg_int_ps, state);
> > +		if (ret)
> > +			return ret;
> > +		data->ps_int = state;
> > +		break;
> 		return 0;
> > +	case IIO_INTENSITY:
> > +		if (data->als_int == state)
> > +			return -EINVAL;
> > +
> > +		ret = regmap_field_write(data->reg_int_als, state);
> > +		if (ret)
> > +			return ret;
> > +		data->als_int = state;
> > +		break;
> 		return 0; instead of break if nothing else to do.
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> With above changes, this is unreachable so drop it.
> 
> > +}
> > +
> > +static irqreturn_t apds9160_irq_handler(int irq, void *private)
> > +{
> > +	struct iio_dev *indio_dev = private;
> > +	struct apds9160_chip *data = iio_priv(indio_dev);
> > +	int ret, status;
> > +
> > +	/* Reading status register clears the interrupt flag */
> > +	ret = regmap_read(data->regmap, APDS9160_REG_SR, &status);
> > +	if (ret < 0) {
> > +		dev_err(&data->client->dev, "irq status reg read failed\n");
> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	if ((status & APDS9160_REG_SR_LS_INT) &&
> > +	    (status & APDS9160_REG_SR_LS_NEW_DATA) && data->als_int) {
> > +		iio_push_event(indio_dev,
> > +			       IIO_UNMOD_EVENT_CODE(IIO_INTENSITY, 0,
> > +						    IIO_EV_TYPE_THRESH,
> > +						    IIO_EV_DIR_EITHER),
> > +			       iio_get_time_ns(indio_dev));
> > +	}
> > +
> > +	if ((status & APDS9160_REG_SR_PS_INT) &&
> > +	    (status & APDS9160_REG_SR_PS_NEW_DATA) && data->ps_int) {
> > +		/** Interrupt flag is cleared after data read */
> 
> 
> Not kernel doc. So just /* 
> 
> However, confusing comment to have here and duplicates comment above I think.
> 
> 
> > +		iio_push_event(indio_dev,
> > +			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
> > +						    IIO_EV_TYPE_THRESH,
> > +						    IIO_EV_DIR_EITHER),
> > +			       iio_get_time_ns(indio_dev));
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int apds9160_detect(struct apds9160_chip *chip)
> > +{
> > +	struct i2c_client *client = chip->client;
> > +	int ret;
> > +	u32 val;
> > +	u8 id;
> > +	u8 rev;
> > +
> > +	ret = regmap_read(chip->regmap, APDS9160_REG_ID, &val);
> > +	if (ret < 0) {
> > +		dev_err(&client->dev, "ID read failed\n");
> > +		return ret;
> > +	}
> > +
> > +	id = APDS9160_PART_ID_MASK & ((u8)val);
> FIELD_GET()
> > +	rev = APDS9160_PART_REV_MASK & ((u8)val);
> > +
> > +	switch (id) {
> > +	case APDS9160_PART_ID_0:
> > +		chip->revision = rev;
> > +		dev_info(&client->dev, "Device probed, rev %u\n",
> > +			 chip->revision);
> Too noisy.
> return 0 here.
> 
> > +		break;
> > +	default:
> > +		dev_info(&client->dev, "Unsupported part id %u rev %u\n", id,
> > +			 rev);
> > +		ret = -ENODEV;
> Fine to return an error code from here, just don't fail the probe on the
> basis of an unknown part ID.
> 
> We have some older drivers that do this, but are slowly moving
> to just printing an info message and moving on.
> 
> > +		break;
> > +	}
> > +	return ret;
> > +}
> 
> > +static int apds9160_configure(struct iio_dev *indio_dev)
> > +{
> > +	struct apds9160_chip *chip = iio_priv(indio_dev);
> > +
> > +	return apds9160_chip_init(chip);
> > +}
> > +
> > +static int apds9160_regfield_init(struct apds9160_chip *data)
> > +{
> > +	struct device *dev = &data->client->dev;
> > +	struct regmap *regmap = data->regmap;
> > +
> > +	data->reg_int_als = devm_regmap_field_alloc(dev, regmap,
> > +						    apds9160_reg_field_int_als);
> Can you just use the bulk field allocator?
> 
> > +	if (IS_ERR(data->reg_int_als)) {
> > +		dev_err(dev, "INT ALS reg field init failed\n");
> > +		return PTR_ERR(data->reg_int_als);
> return dev_err_probe() for all of these if only called form probe.
> 
> > +	}
> > +
> > +	data->reg_int_ps =
> > +		devm_regmap_field_alloc(dev, regmap, apds9160_reg_field_int_ps);
> > +	if (IS_ERR(data->reg_int_ps)) {
> > +		dev_err(dev, "INT ps reg field init failed\n");
> > +		return PTR_ERR(data->reg_int_ps);
> > +	}
> > +
> > +	data->reg_enable_als =
> > +		devm_regmap_field_alloc(dev, regmap, apds9160_reg_field_ls_en);
> > +	if (IS_ERR(data->reg_enable_als)) {
> > +		dev_err(dev, "Enable ALS reg field init failed\n");
> > +		return PTR_ERR(data->reg_enable_als);
> > +	}
> > +
> > +	data->reg_enable_ps =
> > +		devm_regmap_field_alloc(dev, regmap, apds9160_reg_field_ps_en);
> > +	if (IS_ERR(data->reg_enable_ps)) {
> > +		dev_err(dev, "Enable PS reg field init failed\n");
> > +		return PTR_ERR(data->reg_enable_ps);
> > +	}
> > +
> > +	data->reg_ps_overflow = devm_regmap_field_alloc(
> > +		dev, regmap, apds9160_reg_field_ps_overflow);
> > +	if (IS_ERR(data->reg_ps_overflow)) {
> > +		dev_err(dev, "PS overflow reg field init failed\n");
> > +		return PTR_ERR(data->reg_ps_overflow);
> > +	}
> > +
> > +	data->reg_als_rate = devm_regmap_field_alloc(
> > +		dev, regmap, apds9160_reg_field_als_rate);
> > +	if (IS_ERR(data->reg_als_rate)) {
> > +		dev_err(dev, "ALS measurement rate field init failed\n");
> > +		return PTR_ERR(data->reg_als_rate);
> > +	}
> > +
> > +	data->reg_als_resolution = devm_regmap_field_alloc(
> > +		dev, regmap, apds9160_reg_field_als_res);
> > +	if (IS_ERR(data->reg_als_resolution)) {
> > +		dev_err(dev, "ALS resolution field init failed\n");
> > +		return PTR_ERR(data->reg_als_resolution);
> > +	}
> > +
> > +	data->reg_ps_rate = devm_regmap_field_alloc(dev, regmap,
> > +						    apds9160_reg_field_ps_rate);
> > +	if (IS_ERR(data->reg_ps_rate)) {
> > +		dev_err(dev, "PS measurement rate field init failed\n");
> > +		return PTR_ERR(data->reg_ps_rate);
> > +	}
> > +
> > +	data->reg_als_gain = devm_regmap_field_alloc(
> > +		dev, regmap, apds9160_reg_field_als_gain);
> > +	if (IS_ERR(data->reg_als_gain)) {
> > +		dev_err(dev, "ALS gain field init failed\n");
> > +		return PTR_ERR(data->reg_als_gain);
> > +	}
> > +
> > +	data->reg_ps_current = devm_regmap_field_alloc(
> > +		dev, regmap, apds9160_reg_field_ps_current);
> > +	if (IS_ERR(data->reg_ps_current)) {
> > +		dev_err(dev, "PS current field init failed\n");
> > +		return PTR_ERR(data->reg_ps_current);
> > +	}
> > +
> > +	data->reg_ps_gain = devm_regmap_field_alloc(dev, regmap,
> > +						    apds9160_reg_field_ps_gain);
> > +	if (IS_ERR(data->reg_ps_gain)) {
> > +		dev_err(dev, "PS gain field init failed\n");
> > +		return PTR_ERR(data->reg_ps_gain);
> > +	}
> > +
> > +	data->reg_ps_resolution = devm_regmap_field_alloc(
> > +		dev, regmap, apds9160_reg_field_ps_resolution);
> > +	if (IS_ERR(data->reg_ps_resolution)) {
> > +		dev_err(dev, "PS resolution field init failed\n");
> > +		return PTR_ERR(data->reg_ps_resolution);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int apds9160_disable(struct apds9160_chip *data)
> > +{
> > +	int ret;
> > +
> > +	ret = regmap_field_write(data->reg_enable_als, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return regmap_field_write(data->reg_enable_ps, 0);
> > +}
> > +
> > +static int apds9160_shutdown(struct iio_dev *indio_dev)
> > +{
> > +	struct apds9160_chip *data = iio_priv(indio_dev);
> > +
> I think you are using the buffer interfaces just to provide
> an enable / disable?  Don't do that - instead implement runtime
> PM with autosuspend.  That way the sensor will be powered down
> if it isn't accessed for a bit.  When you enable events
> you just hold it on until they are disabled.
> 
> 
> > +	return apds9160_disable(data);
> > +}
> > +
> > +static void apds9160_remove(struct i2c_client *client)
> > +{
> > +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > +
> > +	struct apds9160_chip *data = iio_priv(indio_dev);
> > +
> > +	iio_device_unregister(indio_dev);
> > +	apds9160_disable(data);
> convention is to put this after probe()
> However with changes suggested in probe() you won't need this
> at all.
> 
> > +}
> > +
> > +static const struct iio_buffer_setup_ops apds9160_buffer_setup_ops = {
> > +	.postenable = apds9160_configure,
> > +	.predisable = apds9160_shutdown,
> > +};
> > +
> > +static const struct iio_info apds9160_info = {
> > +	.attrs = &apds9160_attribute_group,
> > +	.read_raw = apds9160_read_raw,
> > +	.write_raw = apds9160_write_raw,
> > +	.read_event_value = apds9160_read_event,
> > +	.write_event_value = apds9160_write_event,
> > +	.read_event_config = apds9160_read_event_config,
> > +	.write_event_config = apds9160_write_event_config,
> > +};
> > +
> > +static int apds9160_probe(struct i2c_client *client)
> > +{
> > +	struct apds9160_chip *chip;
> > +	struct iio_dev *indio_dev;
> > +	int err;
> > +
> > +	dev_info(&client->dev,
> > +		 "Loading proximity/ambient light sensor driver\n");
> Far too noisy. It is easy to find out if the driver has probed from
> other means so we tend not to put generic entries in the kernel log.
> 
> > +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
> Can fail. Check for that.
> 
> > +	indio_dev->info = &apds9160_info;
> > +	indio_dev->name = APDS9160_DRIVER_NAME;
> 
> Put it here as a string. There is no particularly reason this (which is
> the part number) should match the driver name.
> 
> > +	indio_dev->channels = apds9160_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(apds9160_channels);
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +
> > +	err = devm_iio_kfifo_buffer_setup(&client->dev, indio_dev,
> > +					  &apds9160_buffer_setup_ops);
> > +	if (err)
> > +		return err;
> > +
> > +	chip = iio_priv(indio_dev);
> > +	i2c_set_clientdata(client, indio_dev);
> > +	chip->client = client;
> > +	chip->regmap = devm_regmap_init_i2c(client, &apds9160_regmap_config);
> > +	if (IS_ERR(chip->regmap)) {
> > +		dev_err(&client->dev, "regmap initialization failed.\n");
> > +		return PTR_ERR(chip->regmap);
> 		return dev_err_probe()...
> For all error messages in probe.
> 
> > +	}
> > +
> > +	chip->client = client;
> > +	chip->indio_dev = indio_dev;
> > +	mutex_init(&chip->lock);
> > +
> > +	err = apds9160_detect(chip);
> > +	if (err < 0) {
> Don't fail on this. Fine to print a message though to say we have
> a part we don't recognise.
> 
> Actually failing prevents the use of fallback compatibles in DT
> etc that allow an older kernel to work with new devices as long
> as they are backwards compatible (with exception of the ID register).
> > +		dev_err(&client->dev, "apds9160 not found\n");
> > +		return err;
> > +	}
> > +
> > +	err = apds9160_regfield_init(chip);
> > +	if (err)
> > +		return err;
> > +
> > +	err = apds9160_chip_init(chip);
> > +	if (err)
> > +		return err;
> Register a callback to turn the chip off again here with 
> 	ret = devm_add_action_or_reset()
> 
> That avoids mixing devm and non devm cleanup and allows direct returns.
> 
> > +
> > +	if (client->irq > 0) {
> > +		err = devm_request_threaded_irq(
> > +			&client->dev, client->irq, NULL, apds9160_irq_handler,
> > +			IRQF_TRIGGER_FALLING | IRQF_ONESHOT, "apds9160_event",
> Direction needs to come from firmware so drop the FALLING part.
> 
> > +			indio_dev);
> > +		if (err) {
> > +			dev_err(&client->dev, "request irq (%d) failed\n",
> > +				client->irq);
> > +			goto fail;
> > +		}
> > +	} else {
> > +		dev_info(&client->dev,
> > +			 "init: no IRQ defined, ps/als interrupts disabled\n");
> Easy to find out, so no need for print.
> > +	}
> > +
> > +	err = iio_device_register(indio_dev);
> With above changes make this a devm_call as well.
> > +	if (err)
> > +		goto fail;
> > +
> > +	return 0;
> > +fail:
> > +	apds9160_disable(chip);
> With devm based disable this goes.
> > +	return err;
> > +}
> > +
> > +static const struct of_device_id apds9160_of_match[] = {
> > +	{ .compatible = "avago,apds9160" },
> > +	{ .compatible = "broadmobi,apds9160" },
> > +	{}
> Trivial local formatting thing but in IIO I'm trying to standardize on
> 	{ }
> for these terminator entries.
> 
> > +};
> > +MODULE_DEVICE_TABLE(of, apds9160_of_match);
> > +
> > +static struct i2c_driver apds9160_driver = {
> > +	.driver	  = {
> > +		.name	= APDS9160_DRIVER_NAME,
> > +		.owner = THIS_MODULE,
> > +		.of_match_table = apds9160_of_match,
> > +	},
> > +	.probe    = apds9160_probe,
> > +	.remove	  = apds9160_remove,
> > +	.id_table = apds9160_id,
> > +};

Hi Jonathan,

Thank you for the feedback. I'm currently in the process of integrating the comments from all the reviewers for a rev 2.
However, there's still some things that are not clear for me that I'm not sure on how to handle properly.

First, regarding the integration time/gain/scale parameters. I took a look at the datasheet again as there is a table
provided to get lux/count (scale?) for the ALS sensor depending on gain and integration time. 

It looks like the correlation in the table is almost linear but it's not as there is a loss of precision.
For example, at 1x gain with integration time 100ms the lux/count is 0.819 but at 3x the table is stating 0.269 instead of exepected 0.273.

Is it still possible to use the gts helpers in that case?

Second, regarding the use of the IIO_CHAN_INFO_HARDWAREGAIN channel info.
I took a look at a couple of recent drivers, some use the IIO_CHAN_INFO_SCALE to ajust gain type registers.

In my use case, it feels like the scale is read-only as it is affected by the gain and integration time and both can be set independently
with their respective available values. How should I handle this?

Finally, you mention to use a dma safe buffer when calling regmap_bulk_read. 
I took a look at other recent drivers and I don't see any differences on how they are handling this. 
Could you provide an example of how to ensure the buffer allocated on the stack is dma safe?

Best regards,
Mikael

