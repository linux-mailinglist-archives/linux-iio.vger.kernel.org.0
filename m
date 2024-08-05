Return-Path: <linux-iio+bounces-8242-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8E29474BA
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2024 07:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C9F1F2134A
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2024 05:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2CA14290C;
	Mon,  5 Aug 2024 05:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BJmLvwGt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7AA1419A9
	for <linux-iio@vger.kernel.org>; Mon,  5 Aug 2024 05:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722836448; cv=fail; b=AT78mJP351wPHCeZiJH1eIMuwOD4c1hsn1A3ztELWOSI8vVjp64v+6iogSyknshV90CSt326VLa4ou1KZ+jlMUfJzQFAT5I7yQIKDzja9e91/X7Eot6+5KrZZWUUILBnQYRJe2VPvP67mVCXXV7jHOM7rNk7CpvJkpPhOZXY55w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722836448; c=relaxed/simple;
	bh=ExDVQwn7nIWZALRD826WUhbhReCckgmf4zO4EV2Kgk4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kNF7lqa0GXylod5tiQL05Z1RJgFoU2KgYfS46+etFY3Z/SbcUNJ6DUSv6KSHp8rYD2Ztp/cK2wrb2GQGBUvFDbg98UN71+czNTs4EvGHoPEmuZYDkkyaEJRtk7kOVOIsT6gOrvI1ub991kjMM+DKRZlVLLy9jlafnGgCq7ArEsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BJmLvwGt; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722836445; x=1754372445;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ExDVQwn7nIWZALRD826WUhbhReCckgmf4zO4EV2Kgk4=;
  b=BJmLvwGtUmpMZfiiwLuFKu4Tpvh0raZ2kgGq4XSodOz51htURz9OM+ox
   N761IVGYjAvoTCZvdx7cR1SqcxA84zIK/IPxwgI2Wpq6MGpqvmx52rJ4S
   ijueTxAHgiY+OqYYW6hGJnA3DTUIml53oGpXNmE+zOPVjDEBHOZQnJ+lv
   cXFdh1/MzRnnrA8xpZinNbDDREuM4XHZZTetwkP5kCExIWwQCJrxSJ//F
   zFSwcQGugInzzwh9XxUvB20QGhJSld8aEdrw/2ePt1/TRcKMxl74gNA2j
   KTonBw9xqnHPmqvhiYhDRomYlG09opQg1/Fi2Ledue8hEUQKvd6NioyNy
   A==;
X-CSE-ConnectionGUID: JgDKDSuoQZupmTWg/ePucw==
X-CSE-MsgGUID: d59ExW66QEqsDfWUqB+0tA==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="38278891"
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="38278891"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 22:40:42 -0700
X-CSE-ConnectionGUID: A9+2vfyhSMyNHIneHWH3kw==
X-CSE-MsgGUID: AHPbJ4nYT22OqbVHWmQrNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="61022023"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Aug 2024 22:40:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 4 Aug 2024 22:40:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 4 Aug 2024 22:40:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 4 Aug 2024 22:40:41 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 4 Aug 2024 22:40:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdXyVUzhFG2/vecHatiTf540QjdeNHu2f2i2L7F6wySYavPVcic79i8C17/FXLyaB+Yr0KdTZtHvmhfMqALy9hO/ZEfpltm2GCaYZtZv2RNtHmanYP/1arQXlNvqQohclZ0rLQSITpneCLCHXMcrLAgx0AildG9sM/BHsNZecVyiVfjbUApsje2vvCV8YmfUcDcmDRjoYFm+Arpr5jsyC0OsqbFBOec630606vnNoZ/9L9PAFWWcx7j2pvHhm4jUq/jEBgKjqlNOXePsy87bjR9CiU7i1f+KHmQQ9M3FgP6jYiHjs3M7j9gXQaImAJvj+UcWbPG3ft1JNn4KW16BTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gftqH1KDIWOeJm0ppggL8hDoEb71elS4hIvDLf0ixrA=;
 b=GzRxdYrrTaGNUhtN01h/ukw0Or3XCAYVwaJsSiPB7PdrseIZOIql2Rf3zu44LYgixhEbsGNPg67mXy0/blXlXzQbQ2gek2nlg4vj1s/N8SUgl12Ht0nyZxCichZHumsq+CT0S5RU8udL1MGXq30hbVISYLyjqy+vdt1MnKG/NzlZmqCsuaTCtW1rVWKViKNOx04sXzrl+dPhDI6g1D+pNA5f3kqlQW4sSYPozW01L6T5fwuXPjqdJnhL6TUkO9CGpfiEU4Vkdr1nU378Gx3MPhyIlF18500ruJwvKnKYLSvX68oTo+ydPPidecrW5UnoTDZAmWFpH9YJP495Ja0bYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW4PR11MB7149.namprd11.prod.outlook.com (2603:10b6:303:221::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Mon, 5 Aug
 2024 05:40:33 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 05:40:33 +0000
Date: Mon, 5 Aug 2024 13:40:21 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Nuno Sa <nuno.sa@analog.com>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	Linux Memory Management List <linux-mm@kvack.org>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, <linux-iio@vger.kernel.org>, "Borislav Petkov
 (AMD)" <bp@alien8.de>, Paul Menzel <pmenzel@molgen.mpg.de>, Marco Elver
	<elver@google.com>, Masahiro Yamada <masahiroy@kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [linux-next:master] [iio]  8d61d01cde:
 WARNING:at_arch/x86/kernel/cpu/bugs.c:#__warn_thunk
Message-ID: <ZrBlxdxMte7qEFEM@xsang-OptiPlex-9020>
References: <202407161520.ee3d9347-lkp@intel.com>
 <20240716173722.5e582581@jic23-huawei>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240716173722.5e582581@jic23-huawei>
X-ClientProxiedBy: SG2PR02CA0068.apcprd02.prod.outlook.com
 (2603:1096:4:54::32) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW4PR11MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cb43509-b2a5-44aa-9cf5-08dcb5111f72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pCHfnMFY+7Q3sNr+6/wkj6k5pgWLu540k78gArrHkfzc6atV/gk714oWdOn2?=
 =?us-ascii?Q?lUfIDt+1biRRKps7jAOiajdDzZ+3Cf/BztmpL/2oeZCNtGza64srhUZMcDvC?=
 =?us-ascii?Q?gUAi86FBlg4eEWate/AwV1VcDeg9SMXQZODeuXsVkaHwBG8qbmGZaRb+NkR5?=
 =?us-ascii?Q?SQnQvBQT5XbVw2HdHeFXzhB4TNaVURuuNGsbLH9lCoMnIGzlPUkk1Hle0MWB?=
 =?us-ascii?Q?C/2kexG8ZAPch7vDoeQPCZFewpiRPDfzcwHdkjCboLsa0NtEtOV++7e+EGlT?=
 =?us-ascii?Q?Uhmbea0MLhSPzRqQZ/D+/3OxYo9BbQm3fHxlbmRWXxFEIXDJ1b/QCPH6GMtX?=
 =?us-ascii?Q?dX0wS+IcPPRvUlYKkU9eZqRwu/GG8FtPyXOHuRpOf4JGLfmiDRAnczXyKCGc?=
 =?us-ascii?Q?YjSWf2sRXPBC3Sn48qzk63/kbilDodlBcbHpCn3TOXSrw8bz4ZFkiOXCoMEB?=
 =?us-ascii?Q?RrK5UwIB47fVjOQAIer8dVahMyr3rU9bZVEhrOhCWDspvYU7H4DbBEN07o59?=
 =?us-ascii?Q?XUZpmwXbplrf/WYIh+lV+jQlJCj6lsZK+WMm9Un6tHp25EFANy067RfDYokL?=
 =?us-ascii?Q?HOcKSL4txB6n6uMdFwr+jPSD9QUcOJd2srF7ODnjqO2C1RuK6ivD4kELF1Wz?=
 =?us-ascii?Q?zIcIuph4VKdNGfQ+jUMTHriInBZIBMzOT+iMycdIPYq6imjNULWAevz2BiYA?=
 =?us-ascii?Q?SLaLSJJHI55/MAZvIwcDV/mcNzslOCWyQ/2KTN9RvAFCMde94Va8zUzHUkHt?=
 =?us-ascii?Q?ISuNekh2g5arowTMn8ImRAtCYAWwMQAwh0Xjbp/JyQU5cy60r4CrZU6h38UE?=
 =?us-ascii?Q?fHceIG0d4X7edBm+RXkIgZRKqLUe4j4OomqQqkw/IGngs8tKOUFy5EahO+D/?=
 =?us-ascii?Q?1h31I9onbrkAyFE4Nepf78OU1fYLZI/IwXA3OG5ueM+Hot5HU0pCwEy4p/7F?=
 =?us-ascii?Q?2W6RIFELF92cK5Kow//KkeW+LtBiBNjBW6eXk6ncd6jN+xiHX0NprXBIUQqm?=
 =?us-ascii?Q?kAAMn1ZXVOpBbL5Jr3MXYjd41M+Y51kjxqKN39jrj1oT4dkVkRJkCk6/ZHsM?=
 =?us-ascii?Q?Hdd6Lu9OKnEzzrILYk+q8uSCpRmvnNvO3vxRqDKOBIIgjOc1lBJBxw51rdHG?=
 =?us-ascii?Q?pGo6HpbsLQm1lGf3tsg7idZy842hcwBoOa0M0/n8qJqs8KW2Z89uRjHagE2M?=
 =?us-ascii?Q?/qlUuI44rxPtjBISSl+32aCqtJnFgz0sEuFhH6iyrBEFIXCLq4AcDaUBHecD?=
 =?us-ascii?Q?6s0qP+mMzD5mnKHyv/hisiB8t4TOxS1WPZmGJBMv7yqkwr/q7yAUepf59ZOh?=
 =?us-ascii?Q?vl3T73p79c9sBi6BOBZZHv2O?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7tiz41ehhDNeN+ZPUPW0ne9JIEul9mFjjLrAR36YJTnUzoHnlJuulIYvZEyt?=
 =?us-ascii?Q?0vTbSzsFmn9nMz3hU84iY129aowSj6iWgsjQ1DGw/BIPpRvW5xoaL8cifXAn?=
 =?us-ascii?Q?JGkOvUMfkRIFhrp2mZZS/58Mvba6nSWqz9FBxTwBHcRmq+MCQNcxWsJOcqfs?=
 =?us-ascii?Q?Jvnvr5iFjikF/udDB0oP43A/vyvExLmpFD3OyKWDIAJkSpz0iz4p8q4hTRfe?=
 =?us-ascii?Q?JXDz9KBcARIL3TWGvz6FH9JUAeas6X2EhDC3QJDDnWDnqJvIg6YgTAq9vNai?=
 =?us-ascii?Q?blXStQQ1TclkgqGX4N3BDiTDQ4z7lIZQNny35xjNg9IRKCO42rAJyp1D2Lyc?=
 =?us-ascii?Q?gPXkcV+AS19gm4TUwrVw7Rttrc8ZSev7GKihfVGJ73xPtNaZyfzNkaJuYCUn?=
 =?us-ascii?Q?hPR9pVTLTlGVK65S158tlhD/uEDppibVyFFnbBOjLAQNaELZKIWWI6CrMR5A?=
 =?us-ascii?Q?bn0GmrRGA3ME5jiKG+MhUveGLLd9uELinJbo038+qdxsy458W6OwPatG26bz?=
 =?us-ascii?Q?hR3tps8ABdTxuusQ/gTL5Ku2mBTK41mPCgHnzUbJHVRoFb7Kfxjcsv5L0gKD?=
 =?us-ascii?Q?ktVIbEMKcNTx95TufTOMMmz+zX4EInD9Pj8YDJrF4B+GlJyoDu4ve+TrmRdu?=
 =?us-ascii?Q?qXDG37V2XW0nnfDSdPvvFimxnYBdYcal3F0lXJo4EVSXuOWyEFzvOg+AH9GP?=
 =?us-ascii?Q?YXUPKs7FYRFXSJX0WEUs6p2jD7p13jjlXI4RZdUsuS9SF3+62KVI/f44fwiD?=
 =?us-ascii?Q?UZ5nrowgcutTk0hvpd7aGtoIVLnoo6KVXIDMk0dzfVZXrsGwISLQI/8IUppD?=
 =?us-ascii?Q?XAzzGvA1Rz9iGhzPvDZTpHpV+/s5eT0MFIEZuk+ToaXgaelJQ45n9SuZ+CrE?=
 =?us-ascii?Q?mlivVQNTJe8a24FXZQYs2Qi1MgavY38H8kyulVydGvF6QVZTE8j3VEUb6RF6?=
 =?us-ascii?Q?wT1clZoEuzO4W3zoDwRrnYRG2n49AKpwigfDq4FyjvyFVx+VCRc80gGjMMNa?=
 =?us-ascii?Q?FlqcbPAkbreX31R35aKgHu70jzw02qW7prWeAbGGMkwIScOqARhePMQ8PK1h?=
 =?us-ascii?Q?i4PGIRTngwHU0XmB5awgb6r1i00Z9QDao3yaCquVKXy5mncJ8yKoq/4JakeN?=
 =?us-ascii?Q?RTQ/ppFjAkU2DK+a3UYfH++t9wGm9So3lstIvRE+kwfAH2fApIppy7aFpxpg?=
 =?us-ascii?Q?qdG9ZwG/L76C5zT8eb09UNSkGrQV2lrRbB9vW6F8VIpDrFaWfnAKO0FVSU1Y?=
 =?us-ascii?Q?74cb9dGTO7At/HlL9Gqa9mdRvHCjylJ6Dys4Xd1PutIQI2WPyVMqkqb+Bn1e?=
 =?us-ascii?Q?zwfwTdgQlWxD19JvkMB1Aa1nhgrNWyRWiyQxgrHQAq/o/p3iFh2968CHc7Qx?=
 =?us-ascii?Q?4K4udPeEZkWT9YC93cD953IijFm71BLqIZMiC4YhupCJ06VIJAxvGASEnuoR?=
 =?us-ascii?Q?LU5iUcwZbNwL5mdJMPOWHlDa+J0CPBWhXd7gWnnMD83NcHMyiDNwOkMIkbOa?=
 =?us-ascii?Q?Dpyfmr3//WbTEq1eXFUXsHxJF8FJ3CwJGqAp7sdIauLe9hETjfRJKRDns0c7?=
 =?us-ascii?Q?7fdhUB149Jfei0zB/WrOFvsmSPDWt/jHrPnOTr/UoVlw5yqWTGWjZDlh5rnv?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb43509-b2a5-44aa-9cf5-08dcb5111f72
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 05:40:32.9673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +zI7Hk8ZH8fFTIN870CS0x5cPpc5kIcUqfmYklsIZYxKfe6o03L6t2zTCVTRFe8rRLr7NUvtVrait9RFz6csbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7149
X-OriginatorOrg: intel.com

hi, Jonathan,

On Tue, Jul 16, 2024 at 05:37:22PM +0100, Jonathan Cameron wrote:
> On Tue, 16 Jul 2024 15:59:12 +0800
> kernel test robot <oliver.sang@intel.com> wrote:
> 
> > Hello,
> > 
> > kernel test robot noticed "WARNING:at_arch/x86/kernel/cpu/bugs.c:#__warn_thunk" on:
> > 
> > commit: 8d61d01cdec275719b70295e98e4d45c5f284f29 ("iio: gyro: adis16260: make use of the new lock helpers")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > [test failed on linux-next/master 91e3b24eb7d297d9d99030800ed96944b8652eaf]
> > 
> > in testcase: rcutorture
> > version: 
> > with following parameters:
> > 
> > 	runtime: 300s
> > 	test: cpuhotplug
> > 	torture_type: trivial
> > 
> > 
> > 
> > compiler: clang-18
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > +-----------------------------------------------------+------------+------------+
> > |                                                     | ccd52641f9 | 8d61d01cde |
> > +-----------------------------------------------------+------------+------------+
> > | WARNING:at_arch/x86/kernel/cpu/bugs.c:#__warn_thunk | 0          | 30         |
> > | RIP:__warn_thunk                                    | 0          | 30         |
> > +-----------------------------------------------------+------------+------------+
> 
> Hi All.
> 
> I'm struggling to have any idea what this is reporting.
> The code is question must be the use of adis_dev_autoscoped_lock()
> which is very straight forward.
> 
> 		adis_dev_auto_scoped_lock(adis) {
> 			if (t >= 0x0A)
> 				adis->spi->max_speed_hz = ADIS16260_SPI_SLOW;
> 			else
> 				adis->spi->max_speed_hz = ADIS16260_SPI_FAST;
> 			return __adis_write_reg_8(adis, ADIS16260_SMPL_PRD, t);
> 		}
> 		unreachable();
> 		//needed because not all compilers seem to be able to tell
> 		//that a scoped_guard() always runs.
> 
> where the definition is simply 
> 
> #define adis_dev_auto_scoped_lock(adis) \
> 	scoped_guard(mutex, &(adis)->state_lock)
> 
> Looks like there was some fun with ksan earlier in the year that smells superficially
> similar but that is long resolved? (+CC some of the folk involved in solving that).
> 
> Any thoughts?

sorry for late. we rebuild kernels with gcc-13, then the issue disappeared.
but we don't have enough knowledge what compilers' difference could cause this.
just FYI.


> 
> Jonathan
> 
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202407161520.ee3d9347-lkp@intel.com
> > 
> > 
> > [    6.698254][    T1] ------------[ cut here ]------------
> > [    6.698774][    T1] Unpatched return thunk in use. This should not happen!
> > [ 6.699377][ T1] WARNING: CPU: 0 PID: 1 at arch/x86/kernel/cpu/bugs.c:3023 __warn_thunk (arch/x86/kernel/cpu/bugs.c:3023) 
> > [    6.699604][    T1] Modules linked in:
> > [    6.699937][    T1] CPU: 0 PID: 1 Comm: swapper Not tainted 6.10.0-rc4-00198-g8d61d01cdec2 #1
> > [    6.700668][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [ 6.701548][ T1] RIP: 0010:__warn_thunk (arch/x86/kernel/cpu/bugs.c:3023) 
> > [ 6.701983][ T1] Code: 1f 44 00 00 80 3d dd fb e3 03 00 74 08 31 ff c3 cc cc cc cc cc c6 05 cc fb e3 03 01 90 48 c7 c7 40 b0 a1 83 e8 76 c6 13 00 90 <0f> 0b 90 90 31 ff c3 cc cc cc cc cc cc cc cc cc cc cc cc cc cc b8
> > All code
> > ========
> >    0:	1f                   	(bad)
> >    1:	44 00 00             	add    %r8b,(%rax)
> >    4:	80 3d dd fb e3 03 00 	cmpb   $0x0,0x3e3fbdd(%rip)        # 0x3e3fbe8
> >    b:	74 08                	je     0x15
> >    d:	31 ff                	xor    %edi,%edi
> >    f:	c3                   	ret
> >   10:	cc                   	int3
> >   11:	cc                   	int3
> >   12:	cc                   	int3
> >   13:	cc                   	int3
> >   14:	cc                   	int3
> >   15:	c6 05 cc fb e3 03 01 	movb   $0x1,0x3e3fbcc(%rip)        # 0x3e3fbe8
> >   1c:	90                   	nop
> >   1d:	48 c7 c7 40 b0 a1 83 	mov    $0xffffffff83a1b040,%rdi
> >   24:	e8 76 c6 13 00       	call   0x13c69f
> >   29:	90                   	nop
> >   2a:*	0f 0b                	ud2		<-- trapping instruction
> >   2c:	90                   	nop
> >   2d:	90                   	nop
> >   2e:	31 ff                	xor    %edi,%edi
> >   30:	c3                   	ret
> >   31:	cc                   	int3
> >   32:	cc                   	int3
> >   33:	cc                   	int3
> >   34:	cc                   	int3
> >   35:	cc                   	int3
> >   36:	cc                   	int3
> >   37:	cc                   	int3
> >   38:	cc                   	int3
> >   39:	cc                   	int3
> >   3a:	cc                   	int3
> >   3b:	cc                   	int3
> >   3c:	cc                   	int3
> >   3d:	cc                   	int3
> >   3e:	cc                   	int3
> >   3f:	b8                   	.byte 0xb8
> > 
> > Code starting with the faulting instruction
> > ===========================================
> >    0:	0f 0b                	ud2
> >    2:	90                   	nop
> >    3:	90                   	nop
> >    4:	31 ff                	xor    %edi,%edi
> >    6:	c3                   	ret
> >    7:	cc                   	int3
> >    8:	cc                   	int3
> >    9:	cc                   	int3
> >    a:	cc                   	int3
> >    b:	cc                   	int3
> >    c:	cc                   	int3
> >    d:	cc                   	int3
> >    e:	cc                   	int3
> >    f:	cc                   	int3
> >   10:	cc                   	int3
> >   11:	cc                   	int3
> >   12:	cc                   	int3
> >   13:	cc                   	int3
> >   14:	cc                   	int3
> >   15:	b8                   	.byte 0xb8
> > [    6.703602][    T1] RSP: 0000:ffffc9000001fe88 EFLAGS: 00010246
> > [    6.704116][    T1] RAX: 0000000000000000 RBX: ffffffff856a96a0 RCX: 0000000000000000
> > [    6.704787][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > [    6.705462][    T1] RBP: ffffc9000001fed8 R08: 0000000000000000 R09: 0000000000000000
> > [    6.706134][    T1] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> > [    6.706804][    T1] R13: 0000000000000000 R14: dffffc0000000000 R15: ffffffff856a96a0
> > [    6.707476][    T1] FS:  0000000000000000(0000) GS:ffffffff844a7000(0000) knlGS:0000000000000000
> > [    6.707601][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    6.708157][    T1] CR2: ffff88843ffff000 CR3: 000000000446c000 CR4: 00000000000406f0
> > [    6.708834][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [    6.709505][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [    6.710174][    T1] Call Trace:
> > [    6.710452][    T1]  <TASK>
> > [ 6.710701][ T1] ? __warn (kernel/panic.c:239 kernel/panic.c:693) 
> > [ 6.711054][ T1] ? __warn_thunk (arch/x86/kernel/cpu/bugs.c:3023) 
> > [ 6.711434][ T1] ? __warn_thunk (arch/x86/kernel/cpu/bugs.c:3023) 
> > [ 6.711604][ T1] ? report_bug (lib/bug.c:?) 
> > [ 6.711991][ T1] ? handle_bug (arch/x86/kernel/traps.c:239) 
> > [ 6.712357][ T1] ? exc_invalid_op (arch/x86/kernel/traps.c:260) 
> > [ 6.712759][ T1] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
> > [ 6.713193][ T1] ? __warn_thunk (arch/x86/kernel/cpu/bugs.c:3023) 
> > [ 6.713575][ T1] ? __warn_thunk (arch/x86/kernel/cpu/bugs.c:3023) 
> > [ 6.713956][ T1] warn_thunk_thunk (arch/x86/entry/entry.S:48) 
> > [ 6.714352][ T1] ? __cfi_asan.module_ctor (main.c:?) 
> > [ 6.714810][ T1] do_basic_setup (init/main.c:1126 init/main.c:1363) 
> > [ 6.715194][ T1] kernel_init_freeable (init/main.c:1582) 
> > [ 6.715602][ T1] ? __cfi_kernel_init (init/main.c:1459) 
> > [ 6.716022][ T1] kernel_init (init/main.c:1469) 
> > [ 6.716389][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
> > [ 6.716769][ T1] ? __cfi_kernel_init (init/main.c:1459) 
> > [ 6.717187][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
> > [    6.717600][    T1]  </TASK>
> > [    6.717856][    T1] irq event stamp: 14123
> > [ 6.718213][ T1] hardirqs last enabled at (14131): console_unlock (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 arch/x86/include/asm/irqflags.h:135 kernel/printk/printk.c:341 kernel/printk/printk.c:2746 kernel/printk/printk.c:3065) 
> > [ 6.719011][ T1] hardirqs last disabled at (14138): console_unlock (kernel/printk/printk.c:339) 
> > [ 6.719601][ T1] softirqs last enabled at (2244): irq_exit_rcu (kernel/softirq.c:651) 
> > [ 6.720366][ T1] softirqs last disabled at (2235): irq_exit_rcu (kernel/softirq.c:651) 
> > [    6.721120][    T1] ---[ end trace 0000000000000000 ]---
> > 
> > 
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20240716/202407161520.ee3d9347-lkp@intel.com
> > 
> > 
> > 
> 
> 

