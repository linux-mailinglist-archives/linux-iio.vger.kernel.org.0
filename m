Return-Path: <linux-iio+bounces-10746-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD97C9A46FA
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 21:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1DF61C2149D
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 19:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74A0204F86;
	Fri, 18 Oct 2024 19:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JqxU7pbo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B96A202F9A;
	Fri, 18 Oct 2024 19:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729279777; cv=fail; b=jC67jBtf3Dkw6rDtsN2ku61djIC/m58G/YNNPsr42VIDv/I+cBJTKTRZr+b31VAyBOvrbQA3amFIPv9V/1X1BjcF0nokjQslMxD12DDCFZloLAj5rLChIssZhvhu4kUSZpEVYA/+e0T/G8AYF540Pu0cfN1OGY/a7EzUthMCd3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729279777; c=relaxed/simple;
	bh=WKpcaM69i/bDnRrIE5Kx5/7mreLPCtB7Rp+MH3KEVMM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PfH5KX8X/SjPsO00nAR+0v370Myxf3XRSNJH49JLYFNh9lq08bRH+k8BNyKgFaX/OJblKTDEr4shgx3k883OgwXdrf9Cl2YmIrurik/X3zxFOVK99TnnrAFg5YMd2yhRONmX7FWA0Cic9aRQ2TvcIs5tjOjp+ma15yzphOxECMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JqxU7pbo; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729279776; x=1760815776;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WKpcaM69i/bDnRrIE5Kx5/7mreLPCtB7Rp+MH3KEVMM=;
  b=JqxU7pbokSM2s7yzaJ3Mr5fwYWEvoXxB1va67L+UMHdaseOaVkSbjC6t
   /NcnB/VQcnX2f/Vleq4XNKWZ1EPYjyAGRjM+Zx2FwW56Cd3emrNI0lJsX
   rB9k2ZuYIuqOAYID2xlvbb2syxO0GbHOObnYHm0E6MTj+p6J2aFE/Www4
   maCfwKC59zCcfCeQs659qKth1DIR5LfezqcV6J9i/LJbwFqkGv4Q7ZjT7
   G3IeSbFqRygTo/bu2c2LwyoH1WtZIVNcPYep+v/tvXc5cWYZMVpdxEaH7
   lGai0PwYD664u1muJ8C/1lDzMeaXoqBbV3Q2EIJEJ30TGW2piitOYvrmk
   w==;
X-CSE-ConnectionGUID: GjIY9fRwQee/rmDCBjxRpQ==
X-CSE-MsgGUID: D5iI6R7zQT6qugTVQXFDew==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39374892"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39374892"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 12:29:35 -0700
X-CSE-ConnectionGUID: VREsIW9uTu6YnsnMxOzl/A==
X-CSE-MsgGUID: iUxq6RjVSoqJZw1MCx15WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="116414000"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 12:29:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 12:29:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 12:29:33 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 12:29:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1OFy+T3dATNRjHwd1IiHywasO1LBM0653IfaDlyGfybQLc+PYvtZ2mbyU2l8r8U5jyHL+Aw4goIPUMnkrZiFhR1SgCdwUeYJhCbmDrA6AxAAvg+uLrMChL1u79Q3rOQLkIpNQB3tlPlnVFkTkWhLiVmaAFr4X3/zSfV5pDAjDW8RXZTS0fpBl7P4NLssLuVa/XOJL0jqmYP10tRb9Y9zr7x8+qqVFFxSe7YNKr6U5Z4VkXel0FzFLhk0kxrZyyFd+Agr0SDiMf11/LPZtMS7tkI97G5BcS8qaM/eWWktyMM5KKTUYILw97zNBsEiMbiHklrZ+Lhj46QIZdQjLX4cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGmdMlRxRFrnBj7/Ilzvcg6Bee81WgFjRi9GCjQch7g=;
 b=PpKgbscxieDXPVwzSW7ugm24uAN0If+cYNOei4GgrlFAz4nvabH0Yu8NsZZf+Voe7CCtVr9zhIh9Smw+bfoTE3ovc0I+b6muJKpGp6875Zmj6cjE8YBQUeIgrlrB6v273g0wFCd6zXr0oeNUk0iVxIYTQTtn3m3tkuHhDOnhe9hXyIW2EKWhQVL+BUzdj6U9vSiGGJa0Sywvckwbh57vxYkgCByS0b5rl9gL4NiA5MxQTs+eSJU/yubZR9H+K4V6ncjF8Cqb251fPxMtFTnqnaOEJRmBywXEqx5HMdNw+vnvPYyoDXhGz3ubEGCgI0AAQq2pPaDsc78qqeCSPNhHaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7652.namprd11.prod.outlook.com (2603:10b6:8:14e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Fri, 18 Oct
 2024 19:29:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8069.018; Fri, 18 Oct 2024
 19:29:30 +0000
Date: Fri, 18 Oct 2024 12:29:27 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Peter Zijlstra <peterz@infradead.org>, David Lechner
	<dlechner@baylibre.com>
CC: Dan Williams <dan.j.williams@intel.com>, Linus Torvalds
	<torvalds@linux-foundation.org>, Jonathan Cameron <jic23@kernel.org>, Nuno
 =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Michael Hennerich
	<michael.hennerich@analog.com>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH 1/3] cleanup: add conditional guard helper
Message-ID: <6712b717a9610_10a0a2942e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20241001-cleanup-if_not_cond_guard-v1-0-7753810b0f7a@baylibre.com>
 <20241001-cleanup-if_not_cond_guard-v1-1-7753810b0f7a@baylibre.com>
 <20241018111503.GC36494@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241018111503.GC36494@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MW4PR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:303:8e::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d94357-ac88-4564-f6d3-08dcefab3003
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aCxZWTvacxe/kpkWcraNMOoHGfjQfSD6R+Q4w8cdg2MZtnl7OzcncMbj2Hba?=
 =?us-ascii?Q?KSsH7jDzVu//dZ4QCtxg0aEFCvNR1WCzUdNIWPEoSQ6F2uxi98fp66wPdRlD?=
 =?us-ascii?Q?U8fI5hhwDlwNjqVeoCzkNz+9YDYvjBIct+6m6EwQMc6K8aKVPyck2TmDUgI2?=
 =?us-ascii?Q?WZcxljObh4grm501rSGZ73KUSFBzo/VIJs+cFCnnpRht0zUfk1dqUan/4ULj?=
 =?us-ascii?Q?aorl2Dktn/OCuK6pAON3u/V4tZcfr3FeCmH29S739hVRCiyM4dnDcniuOHWB?=
 =?us-ascii?Q?ta4U0NHzKalSm6ao4fNCnYptgbg7EkEbmmlZ60Yu+xRClxqvDdWnHcEBuXPx?=
 =?us-ascii?Q?585TuD+xuH6QybLcYjXHMGNdiqoCn2osL/9YqfgKLiXVXC9BPI+FGrX2UiIi?=
 =?us-ascii?Q?z6Rqlv2cwe23pWC5y8z/JestUroLyPGQCRSG94uqjocePXofLyma0mEyZpZ7?=
 =?us-ascii?Q?K1rD2kVlGy/sDOkuuLfgesO3dAyrunegUJ04ePkWpkUtZSpBpOPMEYBBlhL8?=
 =?us-ascii?Q?nIiFAx75MwEdSGoAeU767b0LxkBjRUqz/yTI3qWtL0vEuNn31IcQb2/lEkS0?=
 =?us-ascii?Q?WUcgUNcjKpxKNm3E1bjkk/KiVzPU04p9dmdx7BgN2/ffR23cV0448mneeAK8?=
 =?us-ascii?Q?RY6BIQIVymrhCqXiQInf85PsM08U+zETB1/XRn8AWHaIwUSghGKb1S5/mLvo?=
 =?us-ascii?Q?lc751JSRP2GN8TIT7rBgvROw0QPmBK7LjUQbobQC0X7zQ9l/3Kznl3Cj01Qd?=
 =?us-ascii?Q?EJxmfiJmv58ZRN3FZHURV6W6DEiQnqAA/gFGPyE+EpvKsdQsyVakN9t+JVFT?=
 =?us-ascii?Q?/jsq5Ikz+2gYaSjh4nSwokt4E72Ppb0vBDIehHNjkzbvwDo/WPuv24w8Jbqt?=
 =?us-ascii?Q?OzGY25EOhLfZVYKZrU7Q5y7qmZ+uZUdcVg/bnPwhKHlrflnlWK+SbYexAqGi?=
 =?us-ascii?Q?gUx3ASR4Kn7qQT45ET4+tX122hDH97kFNAOVqBWM243atG958unaQTfxcVmh?=
 =?us-ascii?Q?bZkYHNBDbhea9KUmG46pJgPnGzLNuJQa28LvtptjJUOKS8WRKG3IrPMFxH5M?=
 =?us-ascii?Q?0v7jnpbWzjUXrDarzy423tit33aZqHpJLTzHOv41P4ayKygi661yOdYMGa4c?=
 =?us-ascii?Q?VKSi4bGk4XHM59g+gWiJ72nZu+4xjN6yejSnOiQSOTxwyMqy68iXNiOKU94q?=
 =?us-ascii?Q?BwXHBK0Q21L+Svx8v44XBZ87U8UVCVe2N5E8sUGa8aMy/Q2ZiZoSpBFSa/jG?=
 =?us-ascii?Q?svmlHULwfoco6EtDkCtbCUpUaaE19br2yEUjAmoD5YvhDRkY4MGPVefNXfSX?=
 =?us-ascii?Q?NXsOvamlPIeChZa387zn2tNr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z+4AcuVGmlsRgUUUWutTPMgX7HNXDazcuoAfo6NybPjgZDIvJ0EC6fDbl4sP?=
 =?us-ascii?Q?itLVCj+OQcoilFdzQB5oBqDEGYymfEO0Mmh7hR/25Ns60G6fgwWZOBmb3reL?=
 =?us-ascii?Q?SqcvSEI0O851X+X+0W+UNxzt+ET9cC53+a8V44djLuOfItFJhbnqfFrLJ2lT?=
 =?us-ascii?Q?6T3tlQDOxPkeB9L3cOj9Q3RDU74UWIzaVUjVjKfUyjKTFMKubxoSKA9j6Xak?=
 =?us-ascii?Q?6fwj0SmbdIz2yBNUTuY001OfuUcJJcinp8ZN8aaW8N+jPWd0SOGBFGtWkAGT?=
 =?us-ascii?Q?GP6R9t7aJ8JH769fq3c1eZPyhtpy/e0SgJ9pVURHAChAp2lEamfUky6WyGMV?=
 =?us-ascii?Q?igyy3ezbtg6NJLrL75CHDonW6M9HH0gzG2atITdLxW9W3DDrL8zH6OI6tLX9?=
 =?us-ascii?Q?x6OJN1eL6zNpIMrBrUtWO6gw6PKuyg7OVHNHK8CH4LUZCCSf3c3dZ4vLSeho?=
 =?us-ascii?Q?EvA2TGmnNuJeJJR5KKbnweZdN31sLF6iN/Gei26xkVSsHabMdbONaMIxc3fM?=
 =?us-ascii?Q?9mo8mrLVBETdY6/7OPodXLcQiy9qro+e4fFBfMy1281ViBPXOgVGOHmbshFo?=
 =?us-ascii?Q?L6WMIZWnXF+9ilgGZd/iC1atFzI22K6CQRpNwCiY8Nzc7JWQRwt7x9yTF9UM?=
 =?us-ascii?Q?AXn/csWABQu8ArFVJZs2MILtj4xMh08C5Z+wHlFEdkQfSHstAQu9S0RKkIax?=
 =?us-ascii?Q?58xZwhD3vbPO+YaxnvE8gWmyvasIc9c34fDEA8ANcCMyQBS2+y00Ym8c0Lqx?=
 =?us-ascii?Q?nBWrSREvC7rqcRjrdL0wsfo21wKT9C0CpQPkUubyUD6mKXmzB8sYggnqJRH9?=
 =?us-ascii?Q?RbkP8vY+Ibc6BygSlCAsHAdv8TPPZ+QPUO8qMICcztc4Akk2fHwaDQASqBlf?=
 =?us-ascii?Q?D8P0KtgTbUUK3x9wRE2Lhzc5trc4isZJ9rPPDRuQtzuAMbaSrkttYi0ZX2MZ?=
 =?us-ascii?Q?EXTnB92zOR2oBwptzTErx57It3k2RFrWYNP+qDEFDxFvlPDs9qLpzXXqtbs8?=
 =?us-ascii?Q?9WNECOzkLFN6eNzcDbrwrfcGcONwS6nM5DKH8elSI5WDN/7aupgtB+SMWLya?=
 =?us-ascii?Q?Yxke+jSnNnJtQ+6REWkArEYLASZM+NmZkIGHfBQknRJD3EvnuqaxWDFxVlTt?=
 =?us-ascii?Q?0bTX2yCo4YcxDYJSzW2NkzrLVCBEPi5scxaSgRKpzT+erdYn8XsiN4yaJc+j?=
 =?us-ascii?Q?QsVWAwoDmabJhSh2XwXmY0+zHB88LiWnasuvRxiSQ88Gr0d3rUP9hcPXLAhD?=
 =?us-ascii?Q?m0JoQ37QmxsLd2Lg6ZADpa9vhnBU1xUXjTleLvCQOlrkj2lxWKRStjJvlyKi?=
 =?us-ascii?Q?2cSMYK8PjO2IM881j1MNYQRBSAnySxqJr1YqXyYvKlPyTeTBkLmKhs58pNXN?=
 =?us-ascii?Q?tvHkVRap/Myfqo9XCgvP1KWqPCw3lLh9wIh9Vj2cvjBsOR1IBjEK5vHdhN6O?=
 =?us-ascii?Q?lZW2s0sAOsuFwev7v54J7pqziyyNFb0eK4YwuqUK+npPa4i7mQAotX/OWvBz?=
 =?us-ascii?Q?zKtfRTQuTfDiRUuR0iEiQWh2mw6WwsLSCesy1hAxA6mpQ608Pv7OEU0GGI/Z?=
 =?us-ascii?Q?mgVYP31F4/YBCs4AP2nODnFH60MTCwYyIaj9Z4eMM9p3tWHNV98i6Wu90sd4?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d94357-ac88-4564-f6d3-08dcefab3003
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 19:29:30.5653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fl9Aq1ru+dDdpiRIJcxkh6H/UjKQSG/M0Cfv2RVrGXv+qYax+YvZHBll01XVAzibGQNZrVbsThwDbFsNMvUnPKJjB4Jo2E+bz/ZIbHl30Fg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7652
X-OriginatorOrg: intel.com

Peter Zijlstra wrote:
> On Tue, Oct 01, 2024 at 05:30:18PM -0500, David Lechner wrote:
> > Add a new if_not_cond_guard() macro to cleanup.h for handling
> > conditional guards such as mutext_trylock().
> > 
> > This is more ergonomic than scoped_cond_guard() for most use cases.
> > Instead of hiding the error handling statement in the macro args, it
> > works like a normal if statement and allow the error path to be indented
> > while the normal code flow path is not indented. And it avoid unwanted
> > side-effect from hidden for loop in scoped_cond_guard().
> > 
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >  include/linux/cleanup.h | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
[..]
> I've queued these two patches:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core
> 
> But lacking if_not_guard() users, the robot isn't really going to give
> me much feedback there, I suppose...

Looks good. If that branch is rebase-able it would be nice to add some
credit tags to "cleanup: Add conditional guard helper":

Co-developed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

David and I talked about that here:

http://lore.kernel.org/f4cc471a-b602-48d8-8323-15efcd602814@baylibre.com

Also feel free to add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Thanks, Peter!

