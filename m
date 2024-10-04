Return-Path: <linux-iio+bounces-10141-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8B0990A7C
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 19:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6C561F21941
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 17:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55031DAC86;
	Fri,  4 Oct 2024 17:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D7C88yTa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801551DAC81;
	Fri,  4 Oct 2024 17:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728064683; cv=fail; b=o0t6CLMoUOhi28z1r3defu93G2+Z0aQOs2640R/7VX3CjItzrlzblPNtXuCuFB4RdY0jHXFAF5Esp/f7SUZPxLeklZIgb9axnx0x//JzoZW7jhi8CJwvxgbLRE0LM4GdAMi/C70mgr/GaGTBTtKyYQ1T1KUz+6bMononATXKWaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728064683; c=relaxed/simple;
	bh=8nWkKtZQf9KJYmedo8wQnh7Q0OVF79OcpPp4LVEeeMY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LcXhpEIGL5u+hdzAVbFArCyoQaXVEuAwRhr5pD2YBwjVPEkLCBi0eXZ1cD52xwDPD11F1kCGUsPXeR390rauQmnVBLSO2d6OeBZtMYLKn4mssz3IyVjOPFJ+ohbH1Qtr5jZFtMaIqyBYPdtu7cYVbh+DEkW9Kyqchc4WIuc0hVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D7C88yTa; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728064682; x=1759600682;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8nWkKtZQf9KJYmedo8wQnh7Q0OVF79OcpPp4LVEeeMY=;
  b=D7C88yTakxpHdJktG3SLSyjmINkrgL73ohN0z2/uKuuiuCi3E97rS1Tg
   ts25fx/9d8Fz62jhW/sJBgi402NcoEAUEqLJlxEeuMLszU0J2Qw14HPG3
   0UOKYgksWdYvcPuJKGiz3rTvzwC/mUs9XZyumUPEPdTll86p4rLqpP99q
   kgiEuXIp0wl07yLCONl2Xn6rvBXGmzAyBlKwsnOsqXef8Cb31BQen118c
   GmhtGB6mgreM/Pt+/CHBIe3hT/6Pv0ZjiVjFxNvBcNd5Wfyw9hjISx8gz
   mmUf9VkY06jdMxHDuKBGKNt+796EaY+CiFrSWY/36ac6Lei84nEaXbhW0
   A==;
X-CSE-ConnectionGUID: WgqIuyPnQ1mkI/lFAVndJQ==
X-CSE-MsgGUID: j4D2ci/+TbqO948pLriO4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="49825987"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="49825987"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 10:58:01 -0700
X-CSE-ConnectionGUID: KpsZ8adxSYa61gBFeD7oIg==
X-CSE-MsgGUID: 8TfNIV/YRlS6xR7Kl8ISCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="112244315"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2024 10:58:02 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 10:58:00 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 10:58:00 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 10:58:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 4 Oct 2024 10:57:59 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 10:57:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OkLCRdeYaXZWl+zolSR0MMj98sn+bpniSrwSuijfpETdamW3ksc6TtD3SGk3OhBxvPwiMaYurd3zBvUKygTpa+RWg+9yA013XeNnJKKOMQZF/V+tue4QQQybqtJBl+CFNe8dPxhtBMt0XbC9YxWVkjuMWCafVxFo0lW72rz6qwt9L8dtWE6qVH4wu2sD9mxLl196QZ06eNZVS4OA9h6xjR+MtdUgin0P6YdN2rTqKdKllsDv2n5q0OHzrKv/Vx3kB6MeKbThylac2kXkRt91hIGs/4e9GdDceCY9HMWuf3JhuJ9mGi4eJ0+fvfJMNTXVQm9Xz0MBOYavxm3fYQFG5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pujv89z+sUFIl0cwDrR2QxoIBnMULR9UDQDvbQ0JZJo=;
 b=U1LbZjcXErhFL6WHSp4W86Ss6+5oXhRowQinbN2ZJD9stMAKStMcADTWMQKwqrLQlreSfM18XHShXBzAX0GhOt0c3GugsQGZi7W8Y/6VYCR4mGSZbWy3g77y7qlkJcb3Bp6ejALQfnQnS9QViPnDWfdfdRpVHDajuYbsW6NomjYijbqMe6WxUZkEStUX9UBkczY/peYpKTZgXLcPqanVV9OpylwdURLlFsU3SWs2GhSx9mtUNeKXOnwDBvyNV9h4HcetVinNPvwoR7MPrEMDaKZd25so+J7qxRQHnKCRu6UXg1i3fdNczXBRYBvj9tjqWUUH9L7s9xT5Wxb91B+UKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8156.namprd11.prod.outlook.com (2603:10b6:610:165::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 17:57:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 17:57:51 +0000
Date: Fri, 4 Oct 2024 10:57:48 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: kernel test robot <lkp@intel.com>, David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>
CC: <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH] iio: core: make iio_device_claim_direct_mode()
 __must_check
Message-ID: <67002c9cdb068_10a0a294a7@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20241002-iio-must-check-claim-direct-v1-1-ab94ce728731@baylibre.com>
 <202410040721.upAHwZJm-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202410040721.upAHwZJm-lkp@intel.com>
X-ClientProxiedBy: MW4PR04CA0331.namprd04.prod.outlook.com
 (2603:10b6:303:8a::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8156:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d15ab1b-96c2-43f2-b685-08dce49e108d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PxD1NdWiV8f6mrFQMph5ZCTvllLJCMBcvMBjOQaPyRNQY0zy5BQS6Pw4z0zN?=
 =?us-ascii?Q?q2TRRkNdyJSoZEu1UOjMKs2S/7YBcr7jhuhJmcLu3fJYvADEtjtwVPnJwN0s?=
 =?us-ascii?Q?5QkSVi6blqsCZrAM/4o5p5rbC9Hfd41fFM1GfL0uCM21ns6b5IdpCpQCcYbj?=
 =?us-ascii?Q?dOCRLFyOXv80Hg9uBaY422dAUuZuREBcgCCcoSG8BX6XcUdOPuvQ5Hm9vYEJ?=
 =?us-ascii?Q?nAxo9q4uS09muyrxjPWkYJ+rWoTl80CoLjJv7ksj4UhUT3xv7pyowMdEIW68?=
 =?us-ascii?Q?BZa3lAxb/TlGjxYv34eqNj64LUrMEWjzVaM029ceabnY09c6sZnzOyBR6e/7?=
 =?us-ascii?Q?5x9amBrvAZ9OTdZ4tMY7KYzy2PYKf07KFRdRknuBLZtOCxzCpiPBbplHkFzA?=
 =?us-ascii?Q?EGAZSxTgQXBxQd6aHTpoPGRzqcOplN9ifyeGuO8Qzzx8XuhZ2LfkGd/KYT2G?=
 =?us-ascii?Q?f4vVd21DnW1dd5TkwKT75LTmazeRYbrn4Vil6jhTMw5m8BifLK0ZMQLhqrq3?=
 =?us-ascii?Q?ngXOTw7EIe+vQENeuklKQYESegzN5XQ6bxRqj7NfPLoOaITtptrRZQVRMJ3D?=
 =?us-ascii?Q?z1HdgZHAAyvq+vAHkW2VgpH/2w3avOYqdbGIWw7Rh+d/T/NyGOQHa14pT2Zz?=
 =?us-ascii?Q?wEc7+/BAhRgSEKcJuwkGGJi+GnisIfoLKM2p02DlWwVux0cVStzX/z/NnsnW?=
 =?us-ascii?Q?yoYziwBRPSk/LN39m9Mzm6SBvqExUi99bWz8PIe2xuTmofBdCYnQV79IJYA7?=
 =?us-ascii?Q?msuAbl9v8WyEVEm0PgbmPyAvIA8zG0WZZXmYrCZ9dK+cYXWCQwhU5vJXR84b?=
 =?us-ascii?Q?TNw5MhoEc2bO+uM0x7t53m2EpxEV2dS2B+/BrQTmvT8jSlGq4sx+uADbemfM?=
 =?us-ascii?Q?HDXqVazIK2c220gYGmLcb61noQ9mhzkNLwuTQKpdNcTSS2TJpnZyDTwANRYJ?=
 =?us-ascii?Q?S001nyubUO+kI0r2KH8Ctg/R+Ov18UOeFJBMzaBvTKHmSX2iAiIxYKnaliaV?=
 =?us-ascii?Q?zt843rrmWEBimLy3qCos6NpaXpI0WpH6veV8cQ6wY7M9CLNPAaUNZrL9WH6a?=
 =?us-ascii?Q?ICSNKkjfnuMd1UD4noHsUQ4Nmol3qVPsUt0TWkOGX9FvhsdWLR0UmdpD6CJS?=
 =?us-ascii?Q?2OHEEUQzzQTyLUARaHifWmB9qMMgM/qGsaPwhbkmgAQFtMZ6dz2OkrAU6N+i?=
 =?us-ascii?Q?1uPBDNCjtKx0WsIwytYTGubw7VpAiT9zYzXXODNT4OgmHH5sSdDinQKQPGE?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xwapfP3ddL4NwRC4cqV0of1sUu3pLFnG8korB+BCXk9dzAauYRIkCMxL8a04?=
 =?us-ascii?Q?4AbYiLdsbj6ppNVAU2u7CD20wZEVqAJb3TemFt9gsUKmCB81LA9nTf40Lztv?=
 =?us-ascii?Q?99agak0+tJumWTFqj6O4ZxN3ngQPQg5SD3WwhBIl7F31eF0Ey5CfpUfduK36?=
 =?us-ascii?Q?sRq2P4DykbnuZiFl8PW5ZGZ54VC4+meDWLdrSU4K5J1VFKfeDQ148CkIE+Dh?=
 =?us-ascii?Q?PGvzL2r7km4ZOxUujOEXtWvgIJc2kxHAyEV74dotreR8+0cT4nvcGCQ6cgQE?=
 =?us-ascii?Q?r86HujJrnFCE3WtFPff84yUAGLoRvYksfoQC0l9Sn7YxcQWw6zEOzYQR3P5E?=
 =?us-ascii?Q?R7cjuNMk6Yl4zJYy/m6d7N5G2BacH7dzpK6wMjREnUQbtCscbxyAj3h2H38q?=
 =?us-ascii?Q?aGwVcMjBRFJw5Hc/UlX2hFwZWh+DLCci/hkdJHVfEmOAngiBm56t4ew59chP?=
 =?us-ascii?Q?PQ1Ds4mm6S8eGUamjqxfPIsi+r5q9AtkI/W2CQkySYRxpdGDmBLL4K/X3MoJ?=
 =?us-ascii?Q?jsK2sVvB7+1gknkGHiwVxFy8eyAqd+7+19xGsQ0cn4bgowgVy8pzGtLRkhGo?=
 =?us-ascii?Q?boR365LLHs7XcIv7f6bWuCHfT7UJ3fTGQakw+uakVy0nl+d8jhAWHW5Bfvd7?=
 =?us-ascii?Q?JpjmMdLDhSDn+OFkv5rOXen1il+9yJ+VMei6hI3MOWYtjQqeYKAaZ9Esf60d?=
 =?us-ascii?Q?DKJlLew/3vFCM2fsTyLGHx34rFCjkyrDsMBAebaQ8KE5qePVHXYrCJX/OmgI?=
 =?us-ascii?Q?VzREMuCQGlaVp5Dslz4gQCykWTSRBITExIaXSJH9IxJxYGOL8Xbj2KR/M/Xe?=
 =?us-ascii?Q?kQogYAvZgrRQzcjbBdFZMygTeZu22Ry4UnrGAP8ysjaRd1fJQoWk+p3L3EOL?=
 =?us-ascii?Q?s41kdxzJUwuPygLInjyRpsmhuvd+Qj4lVisdDDlg3GoO5jMG72Cfs1+LDqlQ?=
 =?us-ascii?Q?Pw86jKOVWT8MpwrU0OR/yrWB8Wgk5oldNr69MeFhCDmdKcCPmMMvb+lB1pAj?=
 =?us-ascii?Q?LACv9la9B8p6MyiLD/dfZyNxfDlW5DFXcDvYvQMeOuCxbbgqafdssmHPJw8h?=
 =?us-ascii?Q?EeSri0j/iuXANSV+DTcHuagAaHHGYWRnUIDLX5OeTTABkyyDrc1pOs9tz5xr?=
 =?us-ascii?Q?RYT5YegSRvcXpr++X7k/XoaKZRUyutdrcVOeRiXs/r4YsmUIS8ScEbV9RHis?=
 =?us-ascii?Q?rCXrHnHxG5ym8ulPFfWEdYCL5pz8MopyD+7dwZfNjQs3OxY23EmFLyF2Rd7W?=
 =?us-ascii?Q?X2sV5lqJpmoswzWaxD2cSGtUQqNtoYmBUcuIK39GR0+74On5WqqHFq0I+WDN?=
 =?us-ascii?Q?ZWgxnIBda5bMZnFHs9LMdOaPr+kSFs3um6n/S6zqFexSq0T9RshBMjuzW4S5?=
 =?us-ascii?Q?FWyyrznu2uF4jwxdPdD0N0o/V9qdv5yrUxFcLcCmsvIQwqyPNlsr+2qyHgYf?=
 =?us-ascii?Q?1CxHNuhYSyo8GySYMOhzhDSGZdW53Gt8sdaKxSouXMWLWkQaVA/Nx4Kijviy?=
 =?us-ascii?Q?6T8Lq2xrnT6CoBjWjiEasZfYgJno7fZXX3RJN+VwtIiXS7TWufjE2WcildfO?=
 =?us-ascii?Q?hibu9cRedLOMEFof9l5xTLOkR3h1v1/9UgQQQmzamARaGZTeLoKugR6etw1U?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d15ab1b-96c2-43f2-b685-08dce49e108d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 17:57:51.4791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSKZGTCKwaVignOQiO4rpCjoMCEpAFQ50kkhyb7L0PA8KN5amPkuyqaVYfEGUjUeAIlOnYZE7hQAZzfiNBD/mpbLKv88fW5tjt6CH7duSOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8156
X-OriginatorOrg: intel.com

kernel test robot wrote:
> Hi David,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 431c39f6d3edbab14f48dbf37a58ccdc0ac3be1e]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/iio-core-make-iio_device_claim_direct_mode-__must_check/20241002-233644
> base:   431c39f6d3edbab14f48dbf37a58ccdc0ac3be1e
> patch link:    https://lore.kernel.org/r/20241002-iio-must-check-claim-direct-v1-1-ab94ce728731%40baylibre.com
> patch subject: [PATCH] iio: core: make iio_device_claim_direct_mode() __must_check
[..]
> >> include/linux/iio/iio.h:669:50: warning: ignoring return value of function declared with 'warn_unused_result' attribute [-Wunused-result]
>      669 | DEFINE_GUARD(iio_claim_direct, struct iio_dev *, iio_device_claim_direct_mode(_T),

So I think this points to the fact that iio_device_claim_direct_mode()
should not be using DEFINE_GUARD() in the first instance. I think
iio_claim_direct() really wants to be using DEFINE_CLASS() directly.
Skip usage of DEFINE_GUARD() which I now see is unable to interoperate
with a __must_check locking function.

Perhaps the new class can be something like:

    DEFINE_GUARD_EXCL_COND()

...which creates a guard that is exclusively conditional and has no
unconditional flavor. However, maybe that only lives in iio unless and
until another user arrives.

