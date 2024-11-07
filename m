Return-Path: <linux-iio+bounces-11992-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AB89C0BCC
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 17:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39F062833F2
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 16:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BD12170AF;
	Thu,  7 Nov 2024 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z3X3bANy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC642170A0;
	Thu,  7 Nov 2024 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730997329; cv=fail; b=jFHQbKwC4+Hq+UaIUfTcE7x1ZUhYNPzf9N4E5n0OYvnss6dmfY/PQOPGIOt0COjWhAH5ipe23RHR1YUTTW9a9dRGUXjNCQCU6icbUS4+Z6Q+RTr6OdBR68VzVWoIh9xKNvVYVhQC2T3YdLH9q9lhJTIKcUz9HIBAH7uOEGnzUh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730997329; c=relaxed/simple;
	bh=+OlcuwvntvuCFB6pe/EAHwANb8JTi7Z1lKXr486TvxY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BoSBtxZ0YiuCkXyMAb5dAST1qYtVevMS4gB5+ARJ8QDgqW20gW+iIBXGPMr+mGlZmxbN/fhP50eY8BO3cScjtMT6OZuPHuBg8Cga2vBX8zn42W0Jv8ioL4pad74dlEW/gthnVuXx7PDDHkSvjAA/VQ8e9IkDO7GCUYtcha/KY7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z3X3bANy; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730997327; x=1762533327;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+OlcuwvntvuCFB6pe/EAHwANb8JTi7Z1lKXr486TvxY=;
  b=Z3X3bANyyU1YCU/ph3TwuU3HDZY/VGOwC/RyPBQn74fZJppex64v6Kw5
   oBDKLOa/lEJXfcPIrsY/mpeE06kbpGj+oEh/qBmcFigQBGoGWfHOWap9B
   LZiHGZwc+8q7NhB7iBPL7nCKTYKps2N0mHmpxos1W9QDdzImZdpUgEGDh
   8EVm7Pcyocr7j6JWJJJuvwe1Z5JvV6ziKkwQJIgOwSs7QX0N/keYOLK3A
   Ni97Pzw8Tdjly+k+FNeLlbpP+tFeDXd0GwR2bokPnziUifJEgyliMMyCb
   X7pCY47zw9mXRujhWcRuCvfWwnWpjl226ZBZ5wI0t2z0goVCRnBjyaJVx
   Q==;
X-CSE-ConnectionGUID: fP8yojqxSsOI8WbAikkT9Q==
X-CSE-MsgGUID: 5xYHMDSpQ+OVWmjRrFHhGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="41451478"
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="41451478"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 08:35:15 -0800
X-CSE-ConnectionGUID: R56Zr5bbRbOh48+ad+6ToA==
X-CSE-MsgGUID: rkT0Fgx+S06xwYcVPit+TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="85551223"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2024 08:35:16 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 7 Nov 2024 08:35:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 7 Nov 2024 08:35:14 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 08:35:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x98qmKHjFemOLxzN4yyY9+6bEKXBIgHyo6/ZGkeNwjOPeufmnH2aOf8m51P5TC1tKy1Q0QfPmqOyV8oDT7e14mAvRjZrcr6BQcUN0+82dII8HpGmtHqbF0cUmInT7c7kGFMn1dsbapLAwgJZsK4uBqpgtoMYzzs70npLzFvkcsZEiDmJwn6FCBbOeEVje3MmY+Mxi75BbYMGp/582o2zQbaEgqCTnl8OoQcu9oz0tEbhsFoj7MNvQWH8qnVBMo7IT6lhVrXljV5rBZytwc7y9ASZXQCBskYA6/NV8h1vD7GD490ZV5+ykSzPPlTT1sb0gEKHGroaqj+15hoCMyqIQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEHcQrgOOqye3fXZMpVUvD59Hxw25P8MCJ6B6tXQtxI=;
 b=gcEnVMVTok7oDqImNgHJLtuHYsILoNpu9ihxe/5WfzH4cTv5CXcJQfhgr5bR+ZQ4l8H4te0lehNLYPYloxzzTPQM+YusdORIHxBQ2mThz/Tg/FIplfxzFJZvlZJUPNtGZkfhY/PyeJXg6PiFZa6jUhnAXlg/wWMFcnZOV9tBMwzl7LWkJtU2MXgBbR5lFYBEMPjAIvIMzFYj8lem2SCYiWld+6KcOJMKB4UvLcayFWGPwGYiwSkpiBs5SuNcmNsgnGaMorNDy4WaHHAbVCxuguBt2mGLSY68naPvqWyb6XhrquAi311uGI0sJ1T4QR9BdAk255C6+A+bulrXaSCVmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8)
 by DS0PR11MB7765.namprd11.prod.outlook.com (2603:10b6:8:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 16:35:11 +0000
Received: from CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3]) by CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3%6]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 16:35:11 +0000
Message-ID: <ee132ba6-5145-44a8-bfba-4a80dc669d7e@intel.com>
Date: Thu, 7 Nov 2024 17:35:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the tip tree
To: Jonathan Cameron <jic23@kernel.org>, Peter Zijlstra <peterz@infradead.org>
CC: Stephen Rothwell <sfr@canb.auug.org.au>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin"
	<hpa@zytor.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>, <megi@xff.cz>,
	<lars@metafoo.de>, <linux-iio@vger.kernel.org>
References: <20241028165336.7b46ce25@canb.auug.org.au>
 <20241101141952.4990f238@canb.auug.org.au>
 <dd740dda-a03e-4f3a-bb46-e551f0799c50@intel.com>
 <20241104140106.GF24862@noisy.programming.kicks-ass.net>
 <20241106094510.3234cae1@jic23-huawei>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241106094510.3234cae1@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0028.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::23) To CH0PR11MB8086.namprd11.prod.outlook.com
 (2603:10b6:610:190::8)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8086:EE_|DS0PR11MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: d4b8d3ff-1584-48d8-b21a-08dcff4a261f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXJqWFJXOTB1QlliYWEzczlBL1llbWFuclNHbUlXa1dpT1pLb1RWWXA3Z04v?=
 =?utf-8?B?SXRXZWtRTGJqZDgzVnB6Ni82eFJnUmJPWWpNdmQ1cm5kSitwZTV0Y1NzSEs2?=
 =?utf-8?B?ZHNkZnZjanhLTmYyRTM1ZUcwOFZHRS9TZFI3Zkp1UXhaUnFkV0dtRHdZZStr?=
 =?utf-8?B?L250VkR6WWhDZTYydEhrdk1YRGduZ1BSRTBtNDlzZnNRUEFETGsrY2RUd0R3?=
 =?utf-8?B?ODVzTXNwNE5HWWt0N01LMkQraXRiWXFsNlNENmdEL2JhUTNCaW5zeFZTdkpI?=
 =?utf-8?B?N2ZucjlQQjVzSzJaT0VaY1Z6dXRJSVV1RHhKQlJiMHNNMko4TjE4WmhIaWtl?=
 =?utf-8?B?ZkM4YkVrRWVtZWVKdXQrbzJSVXdHUGMxYUg3c0JHODJoVVpNVnNNNUZFeUo1?=
 =?utf-8?B?cVo4YTRiVS91ak94QmdqK0VXUnBFM3FraVRTTFdFTkNneUk1ajBMMXJrRkh1?=
 =?utf-8?B?QTdqenNKKzZKN0ZzZWszekUzcHZuWmtHODJ3UDAwMWNlSW4zUGV2WTRCbDdJ?=
 =?utf-8?B?YU9hSmd4eW9maCtQVkNzMkFNNnpNdHBWaG1ZZ0hrQWg3ZzFvd1A2VjNha0hN?=
 =?utf-8?B?MDVhci9USnZ6dHR1VUcydzh3L0N3K0dZeUJ2MlRHUWZCRStzd3JTN0hHcDR3?=
 =?utf-8?B?OTVqNXZvYURzQ1E2MEtONXA2elJsR0grZlRxRTcvelVlb25sNWlGQW1yVmpq?=
 =?utf-8?B?S3RLdUVjYm9XVEZNT1lJSml2a2p5eFFER21QSWZJdGVIY2xOcytPUExtK1ll?=
 =?utf-8?B?bmxjMWtJQmlPRjdLWUNham4vRTIvc0JmNDlFK0Z0S2JCS1VGQkJObDdZMFk2?=
 =?utf-8?B?dGlMalRhM1NZSjZuTncrUGN3cGVkSHhaM1RrbFVydVBFVnJTVEEya3F5dVkr?=
 =?utf-8?B?S1M3K2JJektJTlZMVnFSc0lwSDh6Y2tzQm5IUk1RRVNWYndhMVA4cDRTNVlI?=
 =?utf-8?B?N0taS2liQkdnV3k0VENBY0pjTDZUNWtGVUYxSG5iazI5UUgxZTB2NEdzSVhO?=
 =?utf-8?B?enRBRGF6Y05wOElkNW9KVUI0UEJ0ZDdxMmhQUURKMktXMG85amJaTmpQT2lu?=
 =?utf-8?B?RGR0d1pXUEdNV2ZQS3FSTXMwS0ZjeW4wbHBsZTFyUSt1TlEwTVRQSlNKZ3pl?=
 =?utf-8?B?RzU5dUw3emdMUjlPc0JFeCs0SXJ3VjZ2Z2p3dDJvNVhaM3B1Ry9pdllaVTlm?=
 =?utf-8?B?dzlJMzdyUW5mUmNFckJaWlRxejRpZnYyK0dCOWdPeExtaE1LazJtRUJMTmxC?=
 =?utf-8?B?TEpSaWU4T1FRc1lxdzRnMDNzcGRrZTdxQkJSTm5ieHB3VWVDVE9lM2I1Z1dn?=
 =?utf-8?B?elVIZXVxcDU5UW9qUXYrUnNaaExYM0dDV2N5NXBINjhLdXZlb0xTMjNNK01V?=
 =?utf-8?B?R3JrSFg2bllTeUVZVFNwbWdWaFFvTHBrdU8wUmhhVmpoZzdoZWd0ZHUrdHVi?=
 =?utf-8?B?SklqN0R4OWpxYnludnM3emNicGMreVZORWV6ODBxOUg5bkh5UisvM0E0NEZU?=
 =?utf-8?B?VVZYY0JyODdsMW5EaDNKRytJelZyZktGVWNhWUdxNEdyNFNjOS9oWHpXRDZU?=
 =?utf-8?B?MnJMbkx6bTk4OS9GMlROdXJ3OVhYMGhxdmJmRVh2VUpZTUZDN0hWSXFoU2hx?=
 =?utf-8?B?R3RnSjFOUGZmdkpHK0tka1h4eEJzS2JSMWNpN2xaTllRdUdiME5NYUVFYzFk?=
 =?utf-8?B?NWw4cUZSMlk5bkJEekNCU3FwU1JTTTIyQ29vaTVIY1U3N1ZYeFlpNDBBcXB6?=
 =?utf-8?Q?CqHnt9wn4agXjWr3JHS4aQoZ/mGyjHc5EGz2pqb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8086.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TldwU1RGMUx0NnJNQlMzK0lReExZaXh1SEdtQ1NyZXB2M25tMUt1cE9MMU81?=
 =?utf-8?B?VktOZHkvYlB4MXJQdVEyVEFKWjQrYUhkbkZCWjQ2cWJNK1hJRjcvQWp5TVRx?=
 =?utf-8?B?UHZkbFJ6dk10TUl4eE94TTUrOWN1L1dRTEgxRTBSL0VRbE1ic0JuK1EzdFV1?=
 =?utf-8?B?ZW56eFpNaXc3TGsyRFVrcEJsRUkvVFpMNWFwMGVjbTExMDlqenRjWlhzdS9p?=
 =?utf-8?B?S0Z5MjNHZTBYQ2JTcWp5am43RjMzbjRCN2pOS204TmlKS3dqUUxrcW9rNU9K?=
 =?utf-8?B?V2duUTRkdVNlSUpLU0RtM2VOMzN3bDN3bDNjL0gwY1RKRUNBSGQvSlp2M1c4?=
 =?utf-8?B?c3RWZnh5OGFwMVJydmZRRVVJcFF5SXQ1bG9kYjQ0NlltQ3djUFJscSt6OURC?=
 =?utf-8?B?SDJVY0d0anFqQkc0dGZoK0JLTHhhTDdNOTdYL3dGck5sWWZjNThxMnhwU1N3?=
 =?utf-8?B?L3VwZjVRbzRrYy9wMVhzTHIzQ0JlRFJ0MGMvU1pwMWpPaVNHWVdRY210YjBJ?=
 =?utf-8?B?MmxqcjBWem9LSjJCaTVHM2dHRU9LdnMyaWNsUFVNZFk4cFNhMW5McTl2T1Jq?=
 =?utf-8?B?RVBIOTFpM0dSeDlUM2QzNmtyY2lGd3hWK0ZDOStWaVpodC9LRTRUdVdnakVT?=
 =?utf-8?B?VTFWNVJqaVJUcCtTcTR2L0dOS1VzTzZDaW4wRmtHMjJaY0FsY0hXVjUrT2JQ?=
 =?utf-8?B?SDJTcVJPOS90YytOTjdsY1VSOEgrcWQxMW9sc0NLWFFweGlscVV1OW8rdWVp?=
 =?utf-8?B?OVBiYmE0cnJpK1BDYWswV3BSak5rZFFRUjY2RnRJeUNBdkJ4T2gvZlBKdTBF?=
 =?utf-8?B?Y1BGU2JrTmxSaDBrNitsUXdtV04zUzVpOWFrd2tqRk56blFXSW5RTFcwZGxS?=
 =?utf-8?B?SW04dEhMS09mVVJNSUc4UWhJWDh2U3lMaHc5VGxpaGJ5U3Z4UklMeUV2SG1l?=
 =?utf-8?B?TExwcWFnY3VQKzk1K3psU3IzZy95S3UwZ0tNalVtM1BycU5XMkhycEZFUHg0?=
 =?utf-8?B?NEhxSXhaNjdYVlpKMDBqMVBOMlZsMkNLK0JCaTB3VDlWYkp5MUpvTkNWbk5J?=
 =?utf-8?B?aEhqS0wzdlRPdE9kQzhOeFMvbjFSWWFQdjdmMExyTkl4cStzM3BYZlgrbHRy?=
 =?utf-8?B?elVpR01sWGozVnNGbG5YNFBHeUNhd2VGZlg2ZVZUWFNpOGhqTGk4UEZqNHVu?=
 =?utf-8?B?ckN6bExzWUwwd202SUNSTk13bmZoVDdWWTBMbmxYTlBXa3dQWTIzYTlvWGRT?=
 =?utf-8?B?NlRWNmV6QVJUemJXclJxRG8vUFFwS3BvRXhtUUV0M3JyTFFra1huVU8rWFlV?=
 =?utf-8?B?UnJUZWR2RGwrV3AwS1BmT0FweWZwMysrYjRhbytJYzFMdERnVVBBOCtpY0Vl?=
 =?utf-8?B?bzRVK3dUejkrRFEranQxK1kvekRiMHN2RXdwNEEvVDFoT3g2MUc0UmoweDVY?=
 =?utf-8?B?TStLKzR0Z2llR21QQnJ3WXRiVWNWemFKM1VMMkszWnJiS2ZuQ3R2bU42Yi8z?=
 =?utf-8?B?WXU0WVBjcW9kNlFSQllBUmgvZzRwUTdkUkNiMDJWdmszQW5QekRpZzlDVGZS?=
 =?utf-8?B?WkY0N3B0czVFYktHZ083SkpLcHI4V1Nhd1JDTzdwUFRVRks4MmJPZ0t1ZEpC?=
 =?utf-8?B?U2xxMmUxU1RUcVJjSCtUMWI5RGYzY3Z2c3RKcUNNTGdyYW9SaVR6UlZseGJM?=
 =?utf-8?B?ZlpLU2lQaklhNVF2Yk11ZWIzSDdRSVVjcVBiTDdxSE1GTytDUGNWeW9wMXRJ?=
 =?utf-8?B?bk01MzhOdUtPVmVrUGdwZHpONnJNNmpaN0p6eDJCcjZLTzc4aTJXZ21BY1Qr?=
 =?utf-8?B?UEp4RmFoT0hvQWZpZjFEK2hTUUhvblpUSzNGS3pQWU1qbFBUOWlIRHdKb1Rq?=
 =?utf-8?B?SFZ3RThTL1pKaG9vNnV1VGhacVVBUHVMcHBkWDZ6Uy9YTTRFUUJNWDIxTmdi?=
 =?utf-8?B?WE9UMTlLS0hRT0RzZElLRTl0cVBtcmFNR0srSlluYk40ak5KcmhBRGp0MGRL?=
 =?utf-8?B?RisvQmNOK1lCRlFveThHYk5aNTJncWd5R3ZjdU8vRFlJM3hoVE5uL3ZHWU52?=
 =?utf-8?B?dmdLN0FUQ0J2NUxjV2lTR1JRZHVlbS9ZMU5MLzVyeDM0SmcxamZRZFVhNWFC?=
 =?utf-8?B?TnNvNUFGY29YTWZoRk04K2Z2WldtRzRVamlVWXJhaExHQnpiVWwybmNTZ2hZ?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b8d3ff-1584-48d8-b21a-08dcff4a261f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8086.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 16:35:11.3776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1KgjAlm1e7Gc9nkCuutMEHJnKylcrd6fAdfdRc5/o07EtQZlxPoBzB1kSZ3yF8tVTSTq9x+DcEKwxJNCTrAhfiJ4rZ8AOUEbFrpgI40ZE5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7765
X-OriginatorOrg: intel.com

On 11/6/24 10:45, Jonathan Cameron wrote:
> On Mon, 4 Nov 2024 15:01:06 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
>> It might help if we put the relevant maintainers on Cc?
>>
>> On Mon, Nov 04, 2024 at 02:37:57PM +0100, Przemek Kitszel wrote:
>>> On 11/1/24 04:19, Stephen Rothwell wrote:
>>>> Hi all,
>>>>
>>>> On Mon, 28 Oct 2024 16:53:36 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>>>>
>>>>> After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
>>>>> failed like this:
>>>>>
>>>>> drivers/iio/magnetometer/af8133j.c: In function 'af8133j_set_scale':
>>>>> drivers/iio/magnetometer/af8133j.c:315:12: error: suggest explicit braces to avoid ambiguous 'else' [-Werror=dangling-else]
>>>>>     315 |         if (!pm_runtime_status_suspended(dev))
>>>>>         |            ^
>>>>> cc1: all warnings being treated as errors
>>>>>
>>>>> Probably caused by commit
>>>>>
>>>>>     fcc22ac5baf0 ("cleanup: Adjust scoped_guard() macros to avoid potential warning")
>>>>>
>>>>> I have applied the following for today but I wonder if there may be
>>>>> others.
>>>>>
>>>>> From: Stephen Rothwell <sfr@canb.auug.org.au>
>>>>> Date: Mon, 28 Oct 2024 16:01:15 +1100
>>>>> Subject: [PATCH] fix up for "cleanup: Adjust scoped_guard() macros to avoid
>>>>>    potential warning"
>>>>>
>>>>> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>>>>> ---
>>>>>    drivers/iio/magnetometer/af8133j.c | 3 ++-
>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/iio/magnetometer/af8133j.c b/drivers/iio/magnetometer/af8133j.c
>>>>> index d81d89af6283..acd291f3e792 100644
>>>>> --- a/drivers/iio/magnetometer/af8133j.c
>>>>> +++ b/drivers/iio/magnetometer/af8133j.c
>>>>> @@ -312,10 +312,11 @@ static int af8133j_set_scale(struct af8133j_data *data,
>>>>>    	 * When suspended, just store the new range to data->range to be
>>>>>    	 * applied later during power up.
>>>>>    	 */
>>>>> -	if (!pm_runtime_status_suspended(dev))
>>>>> +	if (!pm_runtime_status_suspended(dev)) {
>>>>>    		scoped_guard(mutex, &data->mutex)
>>>>>    			ret = regmap_write(data->regmap,
>>>>>    					   AF8133J_REG_RANGE, range);
>>>>> +	}
> 
> Might as well flip it to a guard() given the scope is the same and it will
> be a little more readable.
> 
> Otherwise I'm fine taking a patch doing this if someone can send on to
> linux-iio@vger.kernel.org

there were no replies here, and whole story has started by my patch, so
I will post this patch of Stephen tomorrow

> 
> 
> I'll get to making a patch at somepoint but just back from travel
> so a lot of other things on my queue today.
> 
> 
> 
>>>>>    	pm_runtime_enable(dev);
>>>>
>>>> I am still applying this patch.
>>>>    
>>>
>>> This patch of yours is necessary, could you make it permanent?
>>>
>>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 


