Return-Path: <linux-iio+bounces-9992-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C55D98CB15
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 04:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2A9281BA3
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 02:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE602F2D;
	Wed,  2 Oct 2024 02:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jNJ4g30n"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D19BE40;
	Wed,  2 Oct 2024 02:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727835191; cv=fail; b=hEGW9LxCu70CRv6xKxuIl37hCOyM2i5arU7vU0QjspQ7iNN6vPlBp19mW+qIYiPlweMPcqUeiwoQcoDNs/tfiSj1hk7Jaar09b/ejROFUweaf5Zqsz6U2A5REA98ooG+etojApEp0Oqg+aEeLPrLFdQRspkycn7kggiiqCwZVDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727835191; c=relaxed/simple;
	bh=MRFqOUr0I6BoQ8kxjJC4VPEQNEwIDFpMHF6SuWzeX9s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nbNOTg/JEZ/FZ1RycKPwlc8z9aAtqqo5bOp9bjOW2udYN1xR8SO2/xX7bpDWnTa65b6HdPDrth1c+jZIezOFzrrrkA1UzU7XPDkyfJa2BCrcyT99W52iCFgSDn1F6xdJi3DWXFkLBsVil+I/gptDdEq6PPg3uyeX+WEsayvGigg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jNJ4g30n; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727835190; x=1759371190;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MRFqOUr0I6BoQ8kxjJC4VPEQNEwIDFpMHF6SuWzeX9s=;
  b=jNJ4g30n/gMGa3ZhDh47KIvWwe9CsmrVLSGkJdTbG/YP+EUyQSXEFiyk
   ye+FoVddXlDW+EjtsuK89RQrLUm1lp5AsiOQWnx1koFNu72fM5fztU3iO
   u3hH9cj7kpYZa/ehoplMUG4tXp5qZAMe7lICji1DSCMvUAghKk8hhl4lt
   ZljWKfiffO2vMQH6JaeZv3tLR5iGiAAR+dYaFxIunDW2+crav9emXUX7d
   5JoolZBI44JiTC21KYZbPGxfDfowi/w4WhOBuLpxKYFnFvTyuoNQLZnyq
   hrssJb4qx7oybIWUUTutu5McmbfzaNNUxSvSGPIcK16+P8eYSXn1eK5p9
   w==;
X-CSE-ConnectionGUID: RUBq4HUzRF+J5smVGe+tgQ==
X-CSE-MsgGUID: P15+XZ69SWaWB0DnvsHWRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="26948459"
X-IronPort-AV: E=Sophos;i="6.11,170,1725346800"; 
   d="scan'208";a="26948459"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 19:13:09 -0700
X-CSE-ConnectionGUID: uJcOVXOtRnyQ8Ux8TCvTkg==
X-CSE-MsgGUID: yeqjwuCsSl2np7yBUOg9Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,170,1725346800"; 
   d="scan'208";a="78730121"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Oct 2024 19:13:08 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 19:13:07 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 19:13:07 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 19:13:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 1 Oct 2024 19:13:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 19:13:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVeMHM35NIrb6mrFHrCFWG54m+Mg8UzNE7DbvmeC0YwCBXwTSNw0tlKVX6Fi8Dz77iTbMfJOG4ZdHIHCl3KvZj5mbiNW4vkddNFMsKWhDfI6C+d9g3PSD5SS2meugZCHtgYc5sI0AJ83f01cM5cBpWO7n8ns4rs+e3k4txqg8nzfcYJkHKlMUmeyeKkb0PluuQIDU7bGGdJCyq+WIKxJxF1L8t/X27fjIcPMYGPP3YLJiYKydLrVSx5+O/LuCCl7XbB6gWCD9iZk3qCzjn8C6ocNSyImHjAMoS4pN2k6lQ84DPXKv9vo7TqJRHb+ZcJrmE8PACcHgt1EfEO17dj/Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bG0Vqdf5CeNyV0sOd5tTMWf3ZXSpu5pQBvAFv34wZxg=;
 b=pcFI2x9qcO4e0V1v7O5brcJ+DcjDaDPCLc/WggshodEn7phEQ62hYPY+A8iPIaH9HeJKydMicIbZh3J5IIVQXqFMzVNGXkc7vXRAJxbymGHBUNZlYfWQZtqhCEB/3FITu52dVieGCUiGzf/ZMgG/NaZnrIdqkjozpygsBPJ9ufQHaaFGd0lgVzNx5hkDZbsz2rgdom0WXnudaupaQHdsILuZ5ctKcYyFSle5BhuxoStdCuIQaPqQ91F17li5/pYddPEF02SWi9UbdhUz3fkmrsjWrek3/nm0mWR/4RzO26hAies3gwmqzSdwqLMCkQvdFEKJE4zLKuUinrh2ZNGwsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6970.namprd11.prod.outlook.com (2603:10b6:806:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.28; Wed, 2 Oct
 2024 02:13:04 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 02:13:04 +0000
Date: Tue, 1 Oct 2024 19:13:01 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: David Lechner <dlechner@baylibre.com>, Peter Zijlstra
	<peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, Jonathan Cameron
	<jic23@kernel.org>
CC: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Michael Hennerich
	<michael.hennerich@analog.com>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-cxl@vger.kernel.org>, David Lechner
	<dlechner@baylibre.com>, Ira Weiny <ira.weiny@intel.com>, "Fabio M. De
 Francesco" <fabio.maria.de.francesco@linux.intel.com>
Subject: Re: [PATCH 0/3] cleanup: add if_not_cond_guard macro
Message-ID: <66fcac2dbde60_964f229426@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241001-cleanup-if_not_cond_guard-v1-0-7753810b0f7a@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241001-cleanup-if_not_cond_guard-v1-0-7753810b0f7a@baylibre.com>
X-ClientProxiedBy: MW3PR06CA0019.namprd06.prod.outlook.com
 (2603:10b6:303:2a::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: 70e42461-1776-4700-15b2-08dce287bf86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tEFswsE5meJ3t0JOEMYb9F7WV5JGyNOFsyWm5RKnTa4Lk1QFkk7PcDQogrDr?=
 =?us-ascii?Q?OkN5tD7GNJfz5cK8VHgFJISllnXojn1hUxKkjBAkl66Ox0iAjajfzyx/n6an?=
 =?us-ascii?Q?UR0+IA4Av+lgm1ZiG+QZo26JdaLB/4SgqiKadn1o8iPNbwFskyBdJ6wceioH?=
 =?us-ascii?Q?kM3tSJsjs69Mh4LIo3Hnt4iBGnIdrhXONiwxjU7KHL6ctb0r+20wHJSUydBe?=
 =?us-ascii?Q?SEPUENRzm/WMW8Gw9kKDsrdEe9A0qgiute08+f+yj3Poz7Ry6/U+KCvtHnLs?=
 =?us-ascii?Q?TRXS4kmThDfeuvMFbM70TyDTUP4AXXf4J0ue5+dsyMHnwcclx604QrY0WPjx?=
 =?us-ascii?Q?se58A1xdsDMalEI/NCQSGQBSouAc/OdSgNj7cJkUxX6tpakyzBlTcmCjpwqb?=
 =?us-ascii?Q?WpMM+UDAv6rgwiWVq6K/3uVC0r9xm/guxW4rYy0gbqI0wQoH9DjvTTmMbcLf?=
 =?us-ascii?Q?P+k3oMpPLcF0Y+GzMjYlY5JnIEGBe5f8ntsoJuBgw74l8AXcEmWtqLdlGArR?=
 =?us-ascii?Q?h+7BB6TQj+f7HUCA5th9oW8P53vL7V6sUlrKz/QWu+Qq3ADTRXkuasFCGR9n?=
 =?us-ascii?Q?ZlB+O/GRtjIVgw/Fdg3X6yy9wPO+Aes3nNSIW2h3zxXhfyvKBCgLLcPugBzL?=
 =?us-ascii?Q?40JsgYyJXbDirbuBe1FhQOmNUzW7EHMbp2NXjmpi8lRdUK5+gTdOM1nQD+xR?=
 =?us-ascii?Q?ghVwHZomNprDnTk6Huu4GBlpD0eWnZLWW9lWER5/2sV5r5wGGKnuQOPLjlmk?=
 =?us-ascii?Q?8+mY1h0yRsfDpIncJopMJURbjnlMoAaFA4QJcUzs9kC4uYMuCg2htudCsDyT?=
 =?us-ascii?Q?N7GMnlxUKzbkuZKQbPxrubI2MDOJRh7erkZmEdRXG1+IC3FI0SSal8Dj4Hfw?=
 =?us-ascii?Q?45e326ZVbmFgV9OjLTbUAmWirjRRKZpF1N1fhV0e5j4AYHTMGkL47cN9HUa4?=
 =?us-ascii?Q?B3GmwD+nyNigSdtk8GeyvGD+PBU7XSl95J0ckzwUf8cnNL/qVkh8l62T0odt?=
 =?us-ascii?Q?rOgZ61YzaylTprJ+puOp3xNZk2OUJ02fbKdhcWDO22lWOyGO4K5UD8lcwYvU?=
 =?us-ascii?Q?0JZaSfCNAIfWy3239AWpReXB4nikBZHRQvCgX2gq57sqKikJdt7s/BMXWXK0?=
 =?us-ascii?Q?dj+AVbTO8XaChO1NoVUPVEZIpQ7zDH69ENKo7Y0/rNlKMl57anGGox1TMm1q?=
 =?us-ascii?Q?31O2af0Fq4+CMgCKAA1aNnJ+mvL6QlrHCrWKG31dhac1KQpmgq6NB3QD0O1p?=
 =?us-ascii?Q?7mEfEMx3IQGJ97vCgVfeUD6sQ3u0I7cgHgbv49kaAw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QLsnFKSGBGSZhYUtge1KiV9TJiao6x1YAHqadsHt5VaErqEWRNSRiXDAsU5+?=
 =?us-ascii?Q?gxKP9ZuyhRya1fxAcbBSNxPc7aIDZ/8Z7A5qGTvO5XcWjXrI4wT2rSbqzwaH?=
 =?us-ascii?Q?hFd30cNQnLpHR5/BsjioOOEjiaLVx6MryMai2LrnuHZ560qZxPKAg1actVrl?=
 =?us-ascii?Q?rP9weYYxUo8rAZqR/SMBvk81793bXy0kC02Xi0Kp2NNAS05M5dzLYrOjrneQ?=
 =?us-ascii?Q?sMga9JomsuN5m7a0djpKzGxxeKAweEOl5ho78v5uudKdQghpMyImUs421xZH?=
 =?us-ascii?Q?rr9Dag9OeBLmXywV3vrrlQBr0LPzZ1XlJX9ZSl6irsTQczVe+UU9MfFg0G/j?=
 =?us-ascii?Q?PbPheCVoUNnRPjzC5z/KoI+Vu3QBYWaEecw1/cUm4csb5LA6yauI6E1YC9KQ?=
 =?us-ascii?Q?Kxbcy4fyY0khGpcktNJhGUkPr2SO6nKi5HUUNDKqhmqvucL9jDsJdcZoDQT3?=
 =?us-ascii?Q?9raQAM+eW8cD742n0gpnXI01P90F+okVdqXB0NVeLmxUrJR9aPVdf7M32kVq?=
 =?us-ascii?Q?WHY3mKiE93LjjAjEVAMbHBdNEiNzy+N2DFf8bJ8/BpzdlLisOMCv+B6+uaxk?=
 =?us-ascii?Q?ccvtAhvMZwBfQxExSHMXxKG5f0ya98tRcvuoGhbTnQMNWQauyK0njT/s0Syi?=
 =?us-ascii?Q?0X1h7aEwVTiqRtmaHFCXHy+JkDi0YY7FIhry9vZd9iCl4gRuOLJxgOiq592Q?=
 =?us-ascii?Q?XRX5MIHW3lJpkJkfCIUgc/hPEHfNycOv+WSfQDwMiKl29pdy6ajE+0aXoxkK?=
 =?us-ascii?Q?SWP0ZXg/JjPNjQ+um9eiqHJYgPzE59UM2XeRGUl5UTMIuewd7lLtXwBN5A9S?=
 =?us-ascii?Q?GEwCtgJsYNzPO3qDV0WOMa98W2m4CcBAwrBgg9lr6v6v0eNxTvZcr98UxIDu?=
 =?us-ascii?Q?0LfmB/CjRDPe3qWLJQGmjmagLgi4eGRtY98hFVLv45jsD54b/IkxWoqUZ6+X?=
 =?us-ascii?Q?JUK0MdcraRpcoKgCya70BfWWIwuKEoLRYZR6FdoApuPQ+t7XIs3umlJOYOKJ?=
 =?us-ascii?Q?ept4txYB7neudp+QDXFdhWpcHUQZ2TaJa3CebWU5BS8XM5CEuI497igwMl4B?=
 =?us-ascii?Q?kRWemLc9fqJfySgV8f2MvZjOR/IfNG52qx2gHO31Nsq+LQhZRAbQOlCVOzR6?=
 =?us-ascii?Q?NV8lDuuvrtO/WLvr7hEPIsJxV4azrJZa1G2UfcuKHBPL1RrXH6jXuPV1zluo?=
 =?us-ascii?Q?lCYYctdCKZ6JaArAg2HAhMZg12shIgptTtkR6YqyhgFyL9XTuJSz0u7HvyXI?=
 =?us-ascii?Q?1H4acJXp53cleEAZNB/YMopva9BtplNdD3mdqrSNgA67OOBatm+cEcg9aNL1?=
 =?us-ascii?Q?+LchBB8DSNZ2j0q56k89X+A3VDa/zuut1BGIJ6Sd9pWv4jEmv8U4/t49UZiC?=
 =?us-ascii?Q?BjUcDf0MvkIQn16XqFugpW93tPkuP0LV6a9TXwx0BjccZOgoAI1izPnNl2Gz?=
 =?us-ascii?Q?SLU3onFpE5mPhCjhBCic2C+jfInjxchhvzfiYpo2oVSngInOpNkN9lmO/TEC?=
 =?us-ascii?Q?/tlcVF8+ISAC5qHnNrD9m16vEWqmGoSmoewpCtdZ824hQgXXR3X1L08k2ODg?=
 =?us-ascii?Q?T0CYMCOrQK6BLFR+Pn1d52e2vU9ZwIajBmVmOzzLu9vvcF9VBk5DHnRSQ2ja?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e42461-1776-4700-15b2-08dce287bf86
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 02:13:04.2879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+9KWTlwbzAglfH9XXu1hCpz9jrj9eeespA9lCuYGye4rureHR+gm9Or8eEViPJqetVZtiffUcPOvnKFt72rrCp2aMrQD+Ld4AQHGAwYrPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6970
X-OriginatorOrg: intel.com

David Lechner wrote:
> So far, I have not found scoped_cond_guard() to be nice to work with.
> We have been using it quite a bit in the IIO subsystem via the
> iio_device_claim_direct_scoped() macro.
> 
> The main thing I don't like is that scoped_cond_guard() uses a for loop
> internally. In the IIO subsystem, we usually try to return as early as
> possible, so often we are returning from all paths from withing this
> hidden for loop. However, since it is a for loop, the compiler thinks
> that it possible to exit the for loop and so we end up having to use
> unreachable() after the end of the scope to avoid a compiler warning.
> This is illustrated in the ad7380 patch in this series and there are 36
> more instance of unreachable() already introduced in the IIO subsystem
> because of this.
> 
> Also, scoped_cond_guard() is they only macro for conditional guards in
> cleanup.h currently. This means that so far, patches adopting this are
> generally converting something that wasn't scoped to be scoped. This
> results in changing the indentation of a lot of lines of code, which is
> just noise in the patches.
> 
> To avoid these issues, the natural thing to do would be to have a
> non-scoped version of the scoped_cond_guard() macro. There was was a
> rejected attempt to do this in [1], where one of the complaints was:
> 
> > > -       rc = down_read_interruptible(&cxl_region_rwsem);
> > > -       if (rc)
> > > -               return rc;
> > > +       cond_guard(rwsem_read_intr, return -EINTR, &cxl_region_rwsem);
> >
> > Yeah, this is an example of how NOT to do things.
> >
> > If you can't make the syntax be something clean and sane like
> >
> >         if (!cond_guard(rwsem_read_intr, &cxl_region_rwsem))
> >                 return -EINTR;
> >
> > then this code should simply not be converted to guards AT ALL.
> 
> [1]: https://lore.kernel.org/all/170905252721.2268463.6714121678946763402.stgit@dwillia2-xfh.jf.intel.com/
> 
> I couldn't find a way to make a cond_guard() macro that would work like
> exactly as suggested (the problem is that you can't declare a variable
> in the condition expression of an if statement in C). So I am proposing
> a macro that reads basically the same as the above so it still reads
> almost like normal C code even though it hides the if statement a bit.
> 
>         if_not_cond_guard(rwsem_read_intr, &cxl_region_rwsem)
>                 return -EINTR;
> 
> The "not" is baked into the macro because in most cases, failing to
> obtain the lock is the abnormal condition and generally we want to have
> the abnormal path be the indented one.

I think you could also take the "cond" out of the name because that is
implied by the fact it's an 'if'.

So, calling this "if_not_guard ()", for the series, you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...but it's ultimately up to Peter and Linus if they find this "if ()"
rename acceptable. If it is I would suggest the style should be treat it
as an "if ()" statement and add this to .clang-format:

diff --git a/.clang-format b/.clang-format
index 252820d9c80a..ae3511a69896 100644
--- a/.clang-format
+++ b/.clang-format
@@ -63,6 +63,8 @@ DerivePointerAlignment: false
 DisableFormat: false
 ExperimentalAutoDetectBinPacking: false
 FixNamespaceComments: false
+IfMacros:
+  - 'if_not_guard'
 
 # Taken from:
 #   git grep -h '^#define [^[:space:]]*for_each[^[:space:]]*(' include/ tools/ \


Last note, while the iio conversion looks correct to me, I would feel
more comfortable if there was a way to have the compiler catch that
plain "guard(iio_claim_direct)" usage is broken. Perhaps declaring
iio_device_claim_direct_mode() as __must_check achieves that effect?

