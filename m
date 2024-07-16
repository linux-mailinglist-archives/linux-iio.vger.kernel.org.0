Return-Path: <linux-iio+bounces-7632-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E09F932190
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 09:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4E82816AC
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 07:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508D04207D;
	Tue, 16 Jul 2024 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fvu6R9yp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5689E3CF51
	for <linux-iio@vger.kernel.org>; Tue, 16 Jul 2024 07:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721116768; cv=fail; b=Pulybm3ouD8v03sW5S+ycSrWDNK6WT64l5tg0dw9wYDEPb409ElVCzJVG8Dncysp48O2Gls4eLscBDImzrNLAVd6rtFujLd3uXRmqkxcBerztzGguHmt3NYFK2pH9Mjzq2lmnV81enabztqdtgDculojV8a0P/oVvdbDrDNtKf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721116768; c=relaxed/simple;
	bh=KBYZNwSPqyMNbT8HmQswDlcsPLtrwdjf563Ii3irq2k=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=JMFTwRrh41AtDV0YvEjf7fKFUNsA/0/GI68H1veXCD+m/GhJZRmQIlDhybwwd2AJLAbElCTpQIkrqAuoOvPNQW2NQx+RyWjeUQ/Taa/iejM2g1+MSILH90B6ujz23+zr/GfZ3Ot2Wyg+PZRSvTJ5KmXBq0om8Gfzgb/jX6MjYaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fvu6R9yp; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721116766; x=1752652766;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KBYZNwSPqyMNbT8HmQswDlcsPLtrwdjf563Ii3irq2k=;
  b=fvu6R9ypASwdJDqW2/knZbL7g9HWNwBQNOA0IeUw3QzrcXsyZqfsuqUm
   r0fn6gG/UgeiNsNTvs0R8zmPRP2i5uCdlYG/UNopCUBPLcgDYxs0+rNmg
   UFRWpc3NZXR2WGtasfrU7+iW6bUmOJe9vnvZeDMLqqQRMZn6G5X8TJ73T
   GObU2msC98He4GVj5vM1TsRGlgbbHIV4x60ZWSwr/nj17LazsGq5RcBVS
   +OSPtnB0aPIDwejt6lkHVWWiVAG1w2ffeJMdLVDTBZf6hM6LdKhaVYX9C
   4RTp5IewWE0xde2BBUx31lDSvcYL+wwY7GgE6Qr85R+7S7JSSoXGC/gv5
   w==;
X-CSE-ConnectionGUID: ieI+L83TQPWg18Xd594yqg==
X-CSE-MsgGUID: ovolxgqOQpmWVnFnB7Nshw==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="29142488"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="29142488"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 00:59:25 -0700
X-CSE-ConnectionGUID: qVH0VZ0IRDKEDvqHSnSwuQ==
X-CSE-MsgGUID: LFVXEz6WS56Zk8iy5k4AbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="50549493"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jul 2024 00:59:26 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 00:59:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 16 Jul 2024 00:59:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 00:59:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fq8kzByt4zUunb0vrc+xNNb1zcS3cxYS/uyDuAhC20CdOtdjhHMvq5nLFWDKTHRhbhtumNsHOxtyog80L66d6n7JFIr8t+61TGEWbQWb3b9PP7ODyLbJLPjJlDJftVDI0oDigXIbmqFORZ77lvwrPqgZqSM7S8UWVR3TcOKk3fJF2v+TDB0ritPcytvy1Z6aZxsXDTD7p5xy70dtfbJKff+VdJN8TV7pxqEyrPXCtfcADvYY/lmvDrcWp36pfm+NYXq9ocfu+Iz0X7Po/Nt9YKyHuGT/TLdWwfy8HKTv3eIYL+M7jwSbQSA0pu1f3uHF23lGf0qGWHLC4w8W78eshA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSH5SeWpWOvmxhXzaqEIzqkjmPqgibARQR1GuweCHHo=;
 b=any72CW7ClNTlyF++++PJlkOkkLE+uS2RkHiwviDIW6lPaCBqR6SQISS8Hq9aIqA3Qmv2uwFlLJaB9LqmniYMOH7Tzank4WzmsWtbAhmT5rlkABoGoZdW8Cs+70+Cmy/6jKsLJYc0wFbaPwMaYIOIr8tp2UNPyEhaaN6p69slNABJsagl9Evn+hN03lDij8jMFX9JFOeoSbydm/WKK4n1Ge5+cLrKgAngH/D6k6EDlZxMN5f+P0aYaceDjKpmkOh2ZiTturdpyDBiHkBnja5dZ4d4yKwTb1MiSzzvmZdH3Hhlps3nBWaBhKe36vUpftQtzARSmMtKKamFH+U4uMAug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB8455.namprd11.prod.outlook.com (2603:10b6:510:30d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 07:59:22 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 07:59:21 +0000
Date: Tue, 16 Jul 2024 15:59:12 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Nuno Sa <nuno.sa@analog.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	<linux-iio@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [iio]  8d61d01cde:
 WARNING:at_arch/x86/kernel/cpu/bugs.c:#__warn_thunk
Message-ID: <202407161520.ee3d9347-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: 12c4658e-7976-43b8-c782-08dca56d3374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fzwtfPIX33yQ/7H0MXO34V/K4RbD7k+Bc2TE7j9/z6G5vgifFYuvb1Z7fP4u?=
 =?us-ascii?Q?sorlcTuE4cW/hVspuAQwxgE4+KqwJA6laTq25Xqk9k4/9lund3D/tvzgQ41r?=
 =?us-ascii?Q?aSOZbQUFbpPhJxoqiwlRJcHD386aaygu0jUlJkWpGSGii1Eq2Y6nUv/BiG1E?=
 =?us-ascii?Q?t1r4776TCeHYchdh8CwV56xzyt+sOe2VZezMt+13/IrIwZ98ty+9QHQk1y2+?=
 =?us-ascii?Q?S6xnFoCn41/q+jvTk3aQFI4PP7WAHCJ087J8MRNkzkHOHsiS9gIoZHiV3Y5K?=
 =?us-ascii?Q?QaAMhKvqC9rQ2tGxAayuWSPgQb21yI88br1wwz1C8lZsozWgEHwlAm7tEOw7?=
 =?us-ascii?Q?W21ZG+nerRBwbw2V5yBYlrNAskZEUrtP0Zwwbje5swKpsR8uK8dDAtIbs7qw?=
 =?us-ascii?Q?goLyUg/jH2NpmNBiYKquGe/z/PZEqC242Fk1bxryG7r+kryY1wIy+64vRc3L?=
 =?us-ascii?Q?kwHzs//ZpP4aXFJA72bB7fmyPsyHu4Lf/genSv2abzWogCBodUxpQn5vM8n1?=
 =?us-ascii?Q?W19ocxChvVHTd/UyVi9sK7Ibgr9DJnUR3mcNqFw+QHJqFaNtIiG5240XEY0j?=
 =?us-ascii?Q?VJthNr6/zsaAgGte8GIWrlsVtJloP0VK5Hy2WsDND6Dp+v4BD2XiE/7C+aJJ?=
 =?us-ascii?Q?CcnaLdkViktWDSBrgwmBKikVLkrcmJcpmCCY4URbW53mkS0t+62X5KrjgnM2?=
 =?us-ascii?Q?JiCy6KSg59mNmufJeevX2Sl/9n3VgMDqkUvVBiDJXE35t/E849NXlHyxuep3?=
 =?us-ascii?Q?fyiMk54PXjV4mGIoQ734uGQpjfEB6s5m4lsVgAHtg51mA2/zPZqumGpqZ6HP?=
 =?us-ascii?Q?i1x2ZHBp7/r2+Fba+icuHzLFXPztDfz+ytXR3RLZF26ONgAmZzB9RCmaOQuJ?=
 =?us-ascii?Q?6JByxLKXEOAoEm27pbV7D4HxEjDAoQul1GyODxWNs8uXRMqQIqxpmBTol5Ot?=
 =?us-ascii?Q?x7gUIiblOcq78ul4G20JLug4DS5sy0I/1E9EWXE//pmbUcaHx38KrFLWNm9D?=
 =?us-ascii?Q?CEcNUG7mwSg7jIl+HsWJekr2eNMdPX2Y7eAgy8pw8bf1gqWGN7IFnztmJyNC?=
 =?us-ascii?Q?HFRRBRupFzH6JLs6b3JaNgJRJSCFUKdARFwqz/OMJ3uexiDUzIvAQzksOoLH?=
 =?us-ascii?Q?CSYG6Ml4K97EzCqbgfqc0deOKrPNg86Cod2V73CjrZ6ZlKOk8SK5dGIjGLcr?=
 =?us-ascii?Q?pMxNA0nPY4UdGhoHr3cngesghcpJfClzip6O8Q8unHW3X0FrDvTo0r4a8jAc?=
 =?us-ascii?Q?muXtS4gAITkCiUJAshMk3chfu1TVfyKOgkdJb+m0Ad96vfcNyXRhA4v9p2UZ?=
 =?us-ascii?Q?a9E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g4TOPR93bJzfRDpXEvQAoPn2/58egxU5TRYzKd8e2fMnA5f+eyeznMGckzlL?=
 =?us-ascii?Q?XoA8NIpIb/hZtlaJGcz0NaLgFsDn2NOxuTs9uEoB/0/n35htbXkpshNqjbeY?=
 =?us-ascii?Q?X25Xf2hXXrck6do7OQQtmaoXr2Pt282FeFZjXNyXybxScIDcW9BhO3X6+vbB?=
 =?us-ascii?Q?wW6c0GeCRfWYIkayhAsKEZ7bt0tC70TqsfdZy0upLFzoeSo530QZ/GEjf+C0?=
 =?us-ascii?Q?wWtg+uYalRviopEdZT4q12jsd3EqPYPEO3azd7Lt/+aa9j9T4iEhl+IXWuZ7?=
 =?us-ascii?Q?kp+s9Tqw9Y2eL6npcAA0GU4EP5A3yRe0ehkzwtHZgW1CtTYk09nABM3IfQ90?=
 =?us-ascii?Q?x6I1WicfdDqLoNjelZumPNHer5kaMrNubI9fcBVRIPLYBGNrk8X0vezeEuE5?=
 =?us-ascii?Q?nA0TBgrd48fCBHUYtj22yHOLEQV9KQbSIcoEwvFovfIT7+iROsfonEL648Tz?=
 =?us-ascii?Q?ou3i1iN06udRDG2VXPHelmBDDcPONair24E3ALvkUf9X5PCr2ST9/b8M3V/d?=
 =?us-ascii?Q?OTDO3iql8Tx+Chs3dRO++mdn7bYAli3FbGQv8WaHQ7vVgLe6R5Zuqcju46Ck?=
 =?us-ascii?Q?Z1wKlxloZGJnfWZBQG+Ds9JRbTp8ahMHuKSqXmUy24FR6LZe0eH0RSZo9qLo?=
 =?us-ascii?Q?zx4i6dd+RSTJiGJv94xH4B0uYoUcTiFWQGSNLzStLsl5bV9cXmo/wvdi3wg+?=
 =?us-ascii?Q?iLUyMpNNDjJ2GoRwRowb5PTJupDQog5GNzEZFbepXFw4j/iDt3jCzd0I0D25?=
 =?us-ascii?Q?+DgWfN7r9pwvi2xrh8cljWkKLaSzy6OQW1D0iB/GBipS2OpAz6BUvxO0+FIF?=
 =?us-ascii?Q?WOSWl6I9Dl/tizrgoHYk6en3EY37CclAFJW4AL1yYjpo/35wnyZE8mz68wZ3?=
 =?us-ascii?Q?CQxsfN7AMLXjC9MTkhSvjrakTtsbn0Yu2mp0SyQGqpmESAXBy5zyJ6SOVEZ3?=
 =?us-ascii?Q?816lH4NssM9r0KwHiliP90+71xH3ndBkL1s5BrTTNWbMS6tVvU0cp19Sm0YJ?=
 =?us-ascii?Q?/fBSQNVicCjOXn78hektn/ZdhKAhoc8E78VXmZIxt+Lo+duncMhKezp11C2S?=
 =?us-ascii?Q?zHxB4lbO1xhRdDEwmK2wBiAg6En4hbla01sTXVsHrN3OYH2AjxacfaHlnf56?=
 =?us-ascii?Q?4Xl+gpJX7EmNVvlRzuwOsGEWe5iC1AvIqr100DXNylhIunptksxHjyCj7T2u?=
 =?us-ascii?Q?AI3h2NuwASOj1DbRoEHSS28UCso/jgO+PvLztiRolXzFlsinbh/ByZFSr0Vg?=
 =?us-ascii?Q?kBIL4QxNjVT1huJFROzYy8nIWi+fn18Wwe6CVFO4WGaV/KBLLId16g/RWcoW?=
 =?us-ascii?Q?2ddRyr2zZCyttk4NSPsbRrScqIWkcbiCm05CMx6+BoPhd3EAW4FjInJm7Lbc?=
 =?us-ascii?Q?3EBdGvsAOc+LgyQWgHKPEdLz0UVbClJy6zX+dQS1NqG0O3L8BlAGI6To4yZy?=
 =?us-ascii?Q?BGtf2H3PmIc6nJ1VQEcVbL74NB62ZEKiLmWT+GTF6R4bZr+i6L2MM9MXSiSk?=
 =?us-ascii?Q?+zFiOsFodVueXJsSIXEkTGA47vUDcilfLSLQosSjO3MGg5dJUFhlbwvdcaYJ?=
 =?us-ascii?Q?X/tOsPG5rVpyk3vW25uck2W59/DaFBj6DBFgtLpHIIcVmRWc4vZ6Eyoc/mKh?=
 =?us-ascii?Q?aA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c4658e-7976-43b8-c782-08dca56d3374
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 07:59:21.4460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHQaNOZERJ0qcZzgjTfWTqUc3Z4hlaVFAPed861lTjv8sbyVaIvSCwL+D9CUZ5qLYlX8pUdWWZhD/M42djOZrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8455
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_arch/x86/kernel/cpu/bugs.c:#__warn_thunk" on:

commit: 8d61d01cdec275719b70295e98e4d45c5f284f29 ("iio: gyro: adis16260: make use of the new lock helpers")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 91e3b24eb7d297d9d99030800ed96944b8652eaf]

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug
	torture_type: trivial



compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-----------------------------------------------------+------------+------------+
|                                                     | ccd52641f9 | 8d61d01cde |
+-----------------------------------------------------+------------+------------+
| WARNING:at_arch/x86/kernel/cpu/bugs.c:#__warn_thunk | 0          | 30         |
| RIP:__warn_thunk                                    | 0          | 30         |
+-----------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202407161520.ee3d9347-lkp@intel.com


[    6.698254][    T1] ------------[ cut here ]------------
[    6.698774][    T1] Unpatched return thunk in use. This should not happen!
[ 6.699377][ T1] WARNING: CPU: 0 PID: 1 at arch/x86/kernel/cpu/bugs.c:3023 __warn_thunk (arch/x86/kernel/cpu/bugs.c:3023) 
[    6.699604][    T1] Modules linked in:
[    6.699937][    T1] CPU: 0 PID: 1 Comm: swapper Not tainted 6.10.0-rc4-00198-g8d61d01cdec2 #1
[    6.700668][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 6.701548][ T1] RIP: 0010:__warn_thunk (arch/x86/kernel/cpu/bugs.c:3023) 
[ 6.701983][ T1] Code: 1f 44 00 00 80 3d dd fb e3 03 00 74 08 31 ff c3 cc cc cc cc cc c6 05 cc fb e3 03 01 90 48 c7 c7 40 b0 a1 83 e8 76 c6 13 00 90 <0f> 0b 90 90 31 ff c3 cc cc cc cc cc cc cc cc cc cc cc cc cc cc b8
All code
========
   0:	1f                   	(bad)
   1:	44 00 00             	add    %r8b,(%rax)
   4:	80 3d dd fb e3 03 00 	cmpb   $0x0,0x3e3fbdd(%rip)        # 0x3e3fbe8
   b:	74 08                	je     0x15
   d:	31 ff                	xor    %edi,%edi
   f:	c3                   	ret
  10:	cc                   	int3
  11:	cc                   	int3
  12:	cc                   	int3
  13:	cc                   	int3
  14:	cc                   	int3
  15:	c6 05 cc fb e3 03 01 	movb   $0x1,0x3e3fbcc(%rip)        # 0x3e3fbe8
  1c:	90                   	nop
  1d:	48 c7 c7 40 b0 a1 83 	mov    $0xffffffff83a1b040,%rdi
  24:	e8 76 c6 13 00       	call   0x13c69f
  29:	90                   	nop
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	31 ff                	xor    %edi,%edi
  30:	c3                   	ret
  31:	cc                   	int3
  32:	cc                   	int3
  33:	cc                   	int3
  34:	cc                   	int3
  35:	cc                   	int3
  36:	cc                   	int3
  37:	cc                   	int3
  38:	cc                   	int3
  39:	cc                   	int3
  3a:	cc                   	int3
  3b:	cc                   	int3
  3c:	cc                   	int3
  3d:	cc                   	int3
  3e:	cc                   	int3
  3f:	b8                   	.byte 0xb8

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	90                   	nop
   3:	90                   	nop
   4:	31 ff                	xor    %edi,%edi
   6:	c3                   	ret
   7:	cc                   	int3
   8:	cc                   	int3
   9:	cc                   	int3
   a:	cc                   	int3
   b:	cc                   	int3
   c:	cc                   	int3
   d:	cc                   	int3
   e:	cc                   	int3
   f:	cc                   	int3
  10:	cc                   	int3
  11:	cc                   	int3
  12:	cc                   	int3
  13:	cc                   	int3
  14:	cc                   	int3
  15:	b8                   	.byte 0xb8
[    6.703602][    T1] RSP: 0000:ffffc9000001fe88 EFLAGS: 00010246
[    6.704116][    T1] RAX: 0000000000000000 RBX: ffffffff856a96a0 RCX: 0000000000000000
[    6.704787][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[    6.705462][    T1] RBP: ffffc9000001fed8 R08: 0000000000000000 R09: 0000000000000000
[    6.706134][    T1] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[    6.706804][    T1] R13: 0000000000000000 R14: dffffc0000000000 R15: ffffffff856a96a0
[    6.707476][    T1] FS:  0000000000000000(0000) GS:ffffffff844a7000(0000) knlGS:0000000000000000
[    6.707601][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.708157][    T1] CR2: ffff88843ffff000 CR3: 000000000446c000 CR4: 00000000000406f0
[    6.708834][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    6.709505][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    6.710174][    T1] Call Trace:
[    6.710452][    T1]  <TASK>
[ 6.710701][ T1] ? __warn (kernel/panic.c:239 kernel/panic.c:693) 
[ 6.711054][ T1] ? __warn_thunk (arch/x86/kernel/cpu/bugs.c:3023) 
[ 6.711434][ T1] ? __warn_thunk (arch/x86/kernel/cpu/bugs.c:3023) 
[ 6.711604][ T1] ? report_bug (lib/bug.c:?) 
[ 6.711991][ T1] ? handle_bug (arch/x86/kernel/traps.c:239) 
[ 6.712357][ T1] ? exc_invalid_op (arch/x86/kernel/traps.c:260) 
[ 6.712759][ T1] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 6.713193][ T1] ? __warn_thunk (arch/x86/kernel/cpu/bugs.c:3023) 
[ 6.713575][ T1] ? __warn_thunk (arch/x86/kernel/cpu/bugs.c:3023) 
[ 6.713956][ T1] warn_thunk_thunk (arch/x86/entry/entry.S:48) 
[ 6.714352][ T1] ? __cfi_asan.module_ctor (main.c:?) 
[ 6.714810][ T1] do_basic_setup (init/main.c:1126 init/main.c:1363) 
[ 6.715194][ T1] kernel_init_freeable (init/main.c:1582) 
[ 6.715602][ T1] ? __cfi_kernel_init (init/main.c:1459) 
[ 6.716022][ T1] kernel_init (init/main.c:1469) 
[ 6.716389][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 6.716769][ T1] ? __cfi_kernel_init (init/main.c:1459) 
[ 6.717187][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[    6.717600][    T1]  </TASK>
[    6.717856][    T1] irq event stamp: 14123
[ 6.718213][ T1] hardirqs last enabled at (14131): console_unlock (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 arch/x86/include/asm/irqflags.h:135 kernel/printk/printk.c:341 kernel/printk/printk.c:2746 kernel/printk/printk.c:3065) 
[ 6.719011][ T1] hardirqs last disabled at (14138): console_unlock (kernel/printk/printk.c:339) 
[ 6.719601][ T1] softirqs last enabled at (2244): irq_exit_rcu (kernel/softirq.c:651) 
[ 6.720366][ T1] softirqs last disabled at (2235): irq_exit_rcu (kernel/softirq.c:651) 
[    6.721120][    T1] ---[ end trace 0000000000000000 ]---



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240716/202407161520.ee3d9347-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


