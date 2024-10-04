Return-Path: <linux-iio+bounces-10140-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB13990A34
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 19:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB2E1F210CD
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 17:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF3C1D9A5E;
	Fri,  4 Oct 2024 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SdU271zX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CE41AA781;
	Fri,  4 Oct 2024 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728063298; cv=fail; b=u6QchPYwpQtBtV6CeCau4y0HZGX6b3/bVNjYWHluCUMrtsjrzavjoCo0x8rQmMmuCkM9cqcMGHlUOeWEicwbJaV+S5CD1Ksv/vmu3+aerCFI6vIvnFZHVxOweOiiprUI8bpwTuFVgtMAH0NhT6MroOzXut7ygEuNuAdvQFm49+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728063298; c=relaxed/simple;
	bh=o4LXgmHgxajSq8Rr+NAXJPSTTHIAlRexk1/EcXa+glQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DBv8MXZR9rn0JciI75sfTFUMco2tBCQoZsRZsjZ9iMFe28sWMghNqNUcHymY2vcdufmsnF4HD0rjhhlZ5/ui+9EFwBbOKVADGR7/u+8r6lLPIYsF56y+KU/72X3q9NPXX8+r/n+fyGtfyQ8yEPMPxoYeKb6cnTvc801MEFG8/jY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SdU271zX; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728063297; x=1759599297;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=o4LXgmHgxajSq8Rr+NAXJPSTTHIAlRexk1/EcXa+glQ=;
  b=SdU271zXLI/Ln4Tib9kUrC0U/qcguq5P/AFUuQ0TaNyFefNf+dU05uqs
   hp9C5hJK+tdNPoPrHT9tgMkn18o9dxnklFIBT6c20d/sT2skdTIEQ4fmc
   F60ikKif/LpCNjH9DG7Rxpj4iUs5R8tTrj6PzRh5thZzFeeUnwmNjRoSx
   XnseSmX/pzjgyaqNzVCIX/myIr4k36B5wPS4Y+yiOEIsNtG5Jfb7eWZUg
   q8vR1IhoYQx/aCx8NdcffWntb/fOvOcas1qvhSvJcwjXNmAjKBCth87Tx
   shfR3ImTxEstDySVgo5ilSZRWqAL6kKIIIHItA6EEIM81scD7DIXEtYqt
   A==;
X-CSE-ConnectionGUID: Qn69zAzlQqelZddF9Fu+8g==
X-CSE-MsgGUID: 1m0awGHnT/Cy72FBsOFEUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="30178306"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="30178306"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 10:34:56 -0700
X-CSE-ConnectionGUID: EAW3gjX0Q++dw1gd68QAzg==
X-CSE-MsgGUID: oiqceAnpQomJXRigGM1nSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="75203190"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2024 10:34:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 10:34:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 4 Oct 2024 10:34:55 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 10:34:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grbtc4Zzk7bvQ3hxEBijtDqDvYzbgxZLQS8xcG8p3JcjemF0NDEz3aW4iiSbm9/Afaa7CZrjJRR8S+WpTx6HoFgGLSejXVAoTkrvzON/+lmX1QW1qIC95u13pKfh7dp4wHv2pGziwSpT1pn3qUa76of1D9vJj6GsWXxksYL7J0gCPn12ucVsXNxvdCPTatfb8ObP63yuonClObSEAG+ZikAzAXIGPDquz3VHKa44z368kAsBeK0xSUP4wT+L4PJ8aTpdTtQ6YBrBoCfPCc8mKnaIXl81Fn3L6vh0PqlF726HpI82nubqcWhQzNqyk45rJuonZLPDb6cl9vpf07Fq7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zs6QnXciXuQSZdXSjBTCfI2XLfNi8RDUoRpmBBWax2s=;
 b=iiopM6BMZ5zdEykQ4pXfmXsuaBbZuWMksF2CGhLG9hyCVkK+cfVJDJbucDjcwHZyDT0VT4WZHxELGdqhRMUqb13V6WFeG9TYhAbXt90TLt+KOT4cQcIkTuYHpiFMZovr/3FguJuMpH/0R1oKtVD5BlQrvAS8lLgMWbxSccL6QjNv7uELZ39jxKv4+RPUZxIDBUF99Poko60tyNV5wMYuXJjn8K54MLOP/wwPq5/EHeR4I1QCuVoYBxOkguBTYHsy3LytFCM1MhXp+v4qL4QL/knPe1p4Ipw0kFcLkEhCzGpDUD2MiV0+jOGEtwSUnEtJfpH3Je7d+XsRxhcZb/uRqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB7182.namprd11.prod.outlook.com (2603:10b6:8:112::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 17:34:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 17:34:50 +0000
Date: Fri, 4 Oct 2024 10:34:47 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: David Lechner <dlechner@baylibre.com>, Peter Zijlstra
	<peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, Jonathan Cameron
	<jic23@kernel.org>
CC: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Michael Hennerich
	<michael.hennerich@analog.com>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-cxl@vger.kernel.org>, David Lechner
	<dlechner@baylibre.com>, <fabio.maria.de.francesco@linux.intel.com>
Subject: Re: [PATCH 1/3] cleanup: add conditional guard helper
Message-ID: <67002737aad27_10a0a29425@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20241001-cleanup-if_not_cond_guard-v1-0-7753810b0f7a@baylibre.com>
 <20241001-cleanup-if_not_cond_guard-v1-1-7753810b0f7a@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241001-cleanup-if_not_cond_guard-v1-1-7753810b0f7a@baylibre.com>
X-ClientProxiedBy: MW4P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ac95b4-affe-461f-21e3-08dce49ad97d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C93GyMbwOTmCPjhxflQ5Na0nSdrhv2GSC7b0TZz2uHS4AkCR9csGqjGHOMQO?=
 =?us-ascii?Q?3yEJsWxAQCgvaMT/Ljo6oZ6jkXwqs/siusCOvQJffqs/F/qATKUrl+rcpgLP?=
 =?us-ascii?Q?/4fyTDMENntMacl0kGN8O5L0qsKplSvBa5OHJFZXh9IUILLhcHTc2MGvSXo2?=
 =?us-ascii?Q?nLZaA+ykovTB4e7P4Hp5gzEY276QsgDRXI92sJf6oX4HqNQh1vO0l6bVyw4/?=
 =?us-ascii?Q?8r53YKosrRQ3tylgeBIlrBdtkQewJWSB/vBiu58y/FcbZ7jPgZfLJwFoxl5J?=
 =?us-ascii?Q?A3LKrQagC6fLqcyZidQO1HK7VieauVEEgVv140plBtsl4oVT5/NG82Cpxbx4?=
 =?us-ascii?Q?WvcZ1gsJg3R9qBxDzFcOMDi2AEPG7kJXVUrhhZaArMHmmhljlOUzHVOYgY5T?=
 =?us-ascii?Q?hWHXFQpsKFDaFin8bPLay80sCXB7+4yoU4ZfUBqPTbAAQxKeRKA/40JXVykr?=
 =?us-ascii?Q?6Sc1kP2TQFXZnvFSam6ekflS+PTJn8TC/LOzvwqjNMBSWAnHu1cuVJqh4DGd?=
 =?us-ascii?Q?19CXUa9fVH+bjmlaGVcALjVzVSvkoMCIBN9q1VrsRH3/gXsBQ528ODPbvMxC?=
 =?us-ascii?Q?Wg0pNeCBvs5e4kYq2T5YTypahdtscK8dxU5Ribs/BZ5eVNRD33abNH7ZoPa1?=
 =?us-ascii?Q?LwiRl6doLcUhZi2tFYjE1L8EqQ9U7gSHn2Vjo3qTcF6hC5BIrMPHR+ysIi1f?=
 =?us-ascii?Q?l5GU9HmtlQ2/xMc3OsIFoLivQd8aoA/EserXI8w0jz9FYxoNIIShj/Cv/j1L?=
 =?us-ascii?Q?awQBhqxDELNhwE9d/gtc9kTGJWe869A5ZwPVwY2a1G8QOI+ZPlUjjVszJdY/?=
 =?us-ascii?Q?rbmTi/K3RPtYn1aHmvWM3B5h1gTRvQzHJmRTlopMpc4fFfz9GyPJ9m8Z1xeS?=
 =?us-ascii?Q?AXrT77h/baiLxqroxBo8gTpuY6KA2vOhErLDmA8YK2cs9kUNAw7kwfe5ux4+?=
 =?us-ascii?Q?SuIggPCrVIZtUvSWCdClRl6Kt6XJvCOF5SOE6ljeiNc6TgRmkPuewcVMWmKx?=
 =?us-ascii?Q?KcgDSCI4COrHHASzvHM8n7585Q+4rG29a5UrDHQlB6rm1y6JfVEM4hZwsi1d?=
 =?us-ascii?Q?Jdt3EXSXyleT+OSnHPuYAK6fPvoGN4ETMgi+ep0YHParwPeJ2Rtbjp2nApeA?=
 =?us-ascii?Q?KiVAtjbH8y00U1HzO7qjLxths8xGcfukBMUhV6TWrOqOX8QuOrDpGKmVKcq5?=
 =?us-ascii?Q?RZHWkOhWTnlxdVGZbzOpWEu1DOnSa74lnrJpmlGWuCvar7t8o+3RTW/9kbOh?=
 =?us-ascii?Q?d6dVr7MWWU8SXJnjUXgzpFsKAxsYJoMibgldP+zPhg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lILJHKCtu/B8syYp101RKnsfH6y+0zQFDpB9HR9HPjCbu+tjSRgcsKdlfgnz?=
 =?us-ascii?Q?bQfB9mXQVkj8Qm7LC4G4jaWS30TE6+9mFHiKemV/HVzisEJGY9U0W/uAi5Ki?=
 =?us-ascii?Q?zmj9EBHFJXRt941dF8TH45F/QcB9RYWDE1LrTMsfgtRWbQJ41xRnWGozkLjz?=
 =?us-ascii?Q?dl13iJpa5l5bI3ctn4mKco95pmq2zYcce21dZTnxg+gWe00wDNoxsu6gnjsc?=
 =?us-ascii?Q?JoV5EeJFEnp4CYfocN6JCMS6F2tHL4hQyhTjj3ZotZ02PZQrKFiiW4ixCq3D?=
 =?us-ascii?Q?DfIWW5k4s9lAh3x6DZPbI/VDMxx0yfpaIt5p1VXVXTw9qMuEVUh2GFFPXVsT?=
 =?us-ascii?Q?TOYIOeHGLcG4MBxoWCE77WHTyE+Hxn83GKVreqR+AX11RUZdNa8OiIUNSZm/?=
 =?us-ascii?Q?LvOWDHtr3tvEJbM1P7/U466kCcKrIHARgV+RB3HI1iyAC40+q7B5Lwz5eXwq?=
 =?us-ascii?Q?HPrwKM+SvveFzAWzd1D6tiqZZ/xRN6tm2oZYIpqn812raiC4NJspScAJKpFn?=
 =?us-ascii?Q?5qWDeT8YoO1Biu4sWLGv9cw8csht1w/bswNhzaymm7a/W1t+561sEGba2Z2t?=
 =?us-ascii?Q?mIp3SJUHGVMVZ+Wxa2DLScE0fC8kQvO1ZQjmO91VCamEu9NfeyGA1BISI0YC?=
 =?us-ascii?Q?ibTmYHfxvLgAgaTozpQd3C1UMy68TF/gXpxbGoSj+k3u8S3AVA/zaPtGQCtQ?=
 =?us-ascii?Q?qyVsLWMiVwf3c5ljTccyldStRozLWIQmwOOM/IOi5SABtjsBOd9HMqtVwTZr?=
 =?us-ascii?Q?M/hkl6YOwmLRcHRNPXeW+MPlCWHVwKflAv/nFWtUKSYQ0KPhqlr85V1kHtid?=
 =?us-ascii?Q?OqvuYjrQ5fD5zKmKXueurLlTxxE0NoIyeA0xGLW4CgV/+p/HYckuyogWgnCy?=
 =?us-ascii?Q?Xl6i74qa9RML1iIvNS1inLE4UbeWBiF33qGu8VRMKwxVlm0AZ6ZHAaE5JXSl?=
 =?us-ascii?Q?BfCQlDP5eAYo+jNpyUtgYiHbI8DKXlwYeznCqgcILxSmA+J8M3AZ9iTN2rfY?=
 =?us-ascii?Q?JsKODOtY3Z0pXB7qcGf74zO1M2K3Il37qkyT1zWe/xzYMbd7l+x6JEJUEB8o?=
 =?us-ascii?Q?oW7nKw8siWcCDLfHpqI78z7WH1B6QLswRiuvjKDt5Y+ELhqCti9lYR7SJk3/?=
 =?us-ascii?Q?uW1CaNGiRbR2qGOCZCI2ikSfIO2DzP37cFst05WTM4Yw3swhPgA0zM688LxF?=
 =?us-ascii?Q?xl9KeccN65ywm3IHj4f3Y5wpH92CW4QC5JSxTXyy5BlCku34skxBlv5fZe9D?=
 =?us-ascii?Q?8GunwZ6dSXq+SiwHz7jWwz+NK6pMzrKxsHYJHm0TYV7cazneY4rBUB0kNERg?=
 =?us-ascii?Q?h4iyup8pvHXsYy9izJgpX4Rg0jwvHRuejXIf8p/v/g1V2XuDRHgUdyZDvpgR?=
 =?us-ascii?Q?druL2Nc2zqXxXOG/zUPoxerJhPRDEfAuZUY72Qm7OlPvlXJrcAofqo3M7ZvW?=
 =?us-ascii?Q?3++2V5K1lolNr4krui+qTSND0SmgBKDtk/M5W8q/8Su1fFcJk2R552CdEBIV?=
 =?us-ascii?Q?ManujOE93Cf+gu2ZeLgdZggOkF9xQIMgYrIpLgRMHXxNa0VU4RGVA3ex/aVx?=
 =?us-ascii?Q?CwgNyjkQ5ryb8JMH4MmjlB2oFn7/9/4kGf7MUdkzClcZOHVSqUiWl4X1yTYa?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ac95b4-affe-461f-21e3-08dce49ad97d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 17:34:50.5969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cbFALTl4WtHjUQQgXHYl5mFy6V9+To5FEW6tW7xSiVKDgbxIeuyz9ON8G4MrvTbZ9VEKpux1ClMLg8arMPuOmiLZh+ieP+NuiVf0n52BjLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7182
X-OriginatorOrg: intel.com

[ add Fabio ]

David Lechner wrote:
> Add a new if_not_cond_guard() macro to cleanup.h for handling
> conditional guards such as mutext_trylock().
> 
> This is more ergonomic than scoped_cond_guard() for most use cases.
> Instead of hiding the error handling statement in the macro args, it
> works like a normal if statement and allow the error path to be indented
> while the normal code flow path is not indented. And it avoid unwanted
> side-effect from hidden for loop in scoped_cond_guard().
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Hi David,

When you update this to the if_not_guard() name can you also add Fabio as a
co-developer? His work [1] contributed to eliciting the response from Linus,
and then this patch takes the novel additional step to create an "if ()" macro.

Thanks for pushing this forward!

[1]: http://lore.kernel.org/20240130164059.25130-1-fabio.maria.de.francesco@linux.intel.com

