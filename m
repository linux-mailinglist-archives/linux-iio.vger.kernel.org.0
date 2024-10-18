Return-Path: <linux-iio+bounces-10724-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF749A3E78
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 14:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC91E28623B
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 12:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A42117736;
	Fri, 18 Oct 2024 12:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RhFXvRFX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B131F947;
	Fri, 18 Oct 2024 12:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729254716; cv=fail; b=WKnq4zIqCdsmBFKe/HD0uvRu0fL/miTg6OXYibHOKHtqkN88NHnnUhBUIk2wFH6SmNWC5AQYwy0cCGpPsR66EV40NurkxC6vmtzv4+3+yL/mvyovlJt/t5GtDHwAqS7hWgDJWjrNiUrt+TlwkL0BH7VCFSMwL3ItH7jaThp9bGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729254716; c=relaxed/simple;
	bh=1unyMKVXNivUSaQjr5cqSkWCV0jHkx47s57d6yjcS0w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IxdxqXQjhV40MWYeOvIQYxLVXT95uUGhA/P2mX1uTapb2ZiRK66hMt3cpsEWH5pKR884Tb8MjP8jsxZ8qgrgLC0ilmVzJdPiFayQqAtUI++ZkHpqk2WSDxfkNwgNx+FSusf52dJJ2+NdcfCNERux0V0VAyI7psQ+U+B9iA/Oajk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RhFXvRFX; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729254714; x=1760790714;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1unyMKVXNivUSaQjr5cqSkWCV0jHkx47s57d6yjcS0w=;
  b=RhFXvRFXSooDACwLHN2rMIfzaEOxB2tuHLYbPiSf0m1jr0ab4G2TnJzi
   IFxWVTLVy3D3rZVMNX3qleAUDEBx8iFdo4pkf7MWFLHtWzK2zo7YczYr+
   cmbN1J4xa9Ufq1/cUsaEZ18DJGexgbMbesxYyrTDvhMWnUP1TAtA4z7E4
   99ICN/O2rXYajoAKb9wiq1Wgz8ZMtKfVz+HDPk9iuZxOsDAmwNmMUDAp4
   b330hFJIXBPZZ8jl0WlSdT8ZECJ8VMW0Ql8flMJ4fOMRB8A5ZtDb5UtrC
   jU2ddJLbBc/L9gXvkCSglv8JQgITJMAhj+xI5cmF/RQYrAFqkDMh4cnA3
   w==;
X-CSE-ConnectionGUID: EqvL2NloQD6hX/ALQQEpOg==
X-CSE-MsgGUID: uo0NjlQrRYaaL2k6txn8lA==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="28875830"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="28875830"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 05:31:54 -0700
X-CSE-ConnectionGUID: TTJT0ihTQX2ni2sFuQ90Aw==
X-CSE-MsgGUID: GuL4/Qz+RnKFla9n1njh5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="109591285"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 05:31:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 05:31:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 05:31:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 05:31:52 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 05:31:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LT4g8/KyI14+NxeEVTSsgBRMcfpOXGe96en/tl5PTIcXNygGWuHThYlS4qYPZxDqBwFRrdu0joimr/xOk02ZIwHcUU3w9+2T3aOj1iH6qLzIh6dElV/1bcMHM/eWrbboGsaqN5sdjbgz1RB8vxQlK/FcQeFSlqIWvoKbItq0tgDuDbzC2/L8Nx9N1Y5PWJXRAoPqJegGzHLcY/+UwKPsH8g1gN38pSMJAadCARSUMAToW/vgvFS/Ig2W441P3KEY4GwyjSIkPEhDv0ARRmnDKA4qDxcLOLzjdIuNQiPHZraimGUlfYNwNIGvW5z+T1eGYoebYT8QpGxZfJkTSR62VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oT7Hwn8vH459d/pXcS/eBdlJaNMR6sbR3zsVhTXKBf0=;
 b=tl40bj0TakiW8MJy4nWjafUyhu8eaTqdW4OXnK0zcSH6PCCPQoCioMhOA7jj5k4MUXN+swmmtB/VAO8YSiDOrcZlfPyjhD+so1QN+Q9KawePdGSUhsMBAHUqAb8yK4rWP0m6cgodSvViqBoE0CtEoxies6xYScOj7d16U6KG1cR49kqp0p61MrA8TOQvKsyaxkXgoN8ZQHTSq0FPYl3bHkg8/uOHU2IxhYwXxneAhvKaP15IicytBg8I/og6TGldwTTzEzrO9vQQO2HkrG4oXbT2pBdt65ZhnpZ/eptoMySBCotIB7waQt4F1Y4T7lyxcgkUxEpzKZYGEMuZUB0/TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA3PR11MB7609.namprd11.prod.outlook.com (2603:10b6:806:319::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 12:31:49 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 12:31:48 +0000
Message-ID: <26605fd6-0ed5-44f9-981e-d378a192bf0d@intel.com>
Date: Fri, 18 Oct 2024 14:31:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cleanup: add conditional guard helper
To: Peter Zijlstra <peterz@infradead.org>, David Lechner
	<dlechner@baylibre.com>
CC: Dan Williams <dan.j.williams@intel.com>, Linus Torvalds
	<torvalds@linux-foundation.org>, Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Michael Hennerich
	<michael.hennerich@analog.com>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-cxl@vger.kernel.org>
References: <20241001-cleanup-if_not_cond_guard-v1-0-7753810b0f7a@baylibre.com>
 <20241001-cleanup-if_not_cond_guard-v1-1-7753810b0f7a@baylibre.com>
 <20241018111503.GC36494@noisy.programming.kicks-ass.net>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241018111503.GC36494@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0023.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::19) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA3PR11MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d73a7f9-bb1a-4176-8b59-08dcef70d5ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YjFvM0lQcUY1cVFpVlpaa0Q0MXFUTm0yYkVNK0tIK2RyNWg5MkpHVk12MUJ1?=
 =?utf-8?B?LzZnYjNoMDlKZ3V0OC9uSnRsUTk5NHlSRHhsb1FPQjZoYi9hSEhMT1B1NHl0?=
 =?utf-8?B?emZyaWp6YUFhK1lBNVdHWndKMysxaC82UjhBSWI5SSsyNk42ekhoUFpjN2I3?=
 =?utf-8?B?R1ZBRlg2UFdHaGQyTXhKMnVTS1ZkV2JIZmxoc0lVSnZhVjloL1lVeXNJVm5X?=
 =?utf-8?B?cGdqYWRXeWhPb1ZiYW1VenROeGV2b3g2ejdOZ25MenVjdHpxUG9VM1hJM2tZ?=
 =?utf-8?B?NU9hU0xDUGhqUTNGU3JBcExXMWkxRUxzN2xvNmZjbjNrV2V2RFJDRzFibVE2?=
 =?utf-8?B?eHpZMDhlbE5pL0c0eWFMRzhMNUxoZHZIU1FZU04yeHkrRlBoUUs4Y3h5WDhX?=
 =?utf-8?B?VW1vMndPSE0zWTIzYzdjRlAxdktzZDRlVm9wbWxyRUhjRzh3YWkvelZucUhK?=
 =?utf-8?B?KzBteVNHNTliamJmUUdGQ0NEZS82WDkvVUprQmVTVEVsY01jMW4wVWIyWXJK?=
 =?utf-8?B?VzU5MWFEUklqNUZpUEVDRkxNcytYOHZ1NXBVU2M3ZEZZMFNQL1pNNGd2cVpQ?=
 =?utf-8?B?TndCNHdTSFJ3RkV0ckNVbHkwaVJJT2hmMzZka2dFRmlSeVhCeC93K1pJMldJ?=
 =?utf-8?B?NVFyb2kzR0xVSjR0Ymt4aEhUOWlpMHRpTFBObXQ4M1dmdHg2ZUE2OW1IU2NB?=
 =?utf-8?B?d3JDWGNyeGdwUm5jaFFGZDNNVmRPUjRwbnRMKytRQ2dqdVJXRnBmNEQ2RUQw?=
 =?utf-8?B?SDFEczNsZWhKaUV5WnM2RjUyUS95R0lSREpBQ09pdkVxZTh6WldBbWhtRklG?=
 =?utf-8?B?N1V2UE91YWJIamlRMzhHTDk3R2E0djhzOERkaTF5TndIQVFkNkc3TWtRNWVn?=
 =?utf-8?B?ZVIvNC9yT0N3eW10ZGRmcldlVGs3K2VOMHNwRDBwQ3Z1SEw4N1lQbDBCdDk0?=
 =?utf-8?B?NXl2dEU0SzF4MmQ5SG1NaVpRaXBHa0grSG1CZ21hLzNYZXZYb2ZLa3ZnY0du?=
 =?utf-8?B?ekFJMlkyYzViZjVsam0ySGJrNElFZVJZc1hkSmFkVFlTZWhScGhQaCtQTm9O?=
 =?utf-8?B?eXBxVnladjVoZzFDRlZuZkVKMTZlTWtMdWdhMlhEZnc4Y3lFbzJyYm1mdmJa?=
 =?utf-8?B?WEw0S01ralJBNkhxT1g1STdYb0h1REN1UnB4NnhNc1ZOU0JBY3hIS2tmak0y?=
 =?utf-8?B?QzgwekJxWjBUaHl6aFlSRDdTci9RaDRGK2N5NGZyWlFkbk1pSmVrbXZTRnRM?=
 =?utf-8?B?SXNrdnpIS3NrcVFDS2NZbEdMbXp4bTB4Yzl1T2FrSVJaR21ITWxGRWRTNVhB?=
 =?utf-8?B?WjEzQWtraGhlWW5sbWdhNnUxYkdmakppSnFMaFF2bklGUDhTQmFwWjljUVVJ?=
 =?utf-8?B?ZGNVV3JqdGFJN2k5MEUydWMwLy9tLzUvcUtWZjdVaGVrQ1VZNGVuY0dubEtS?=
 =?utf-8?B?VTkxMG1aR1pDbEZXUHlHRUUvQ0M5ZXp5cXpFQ3NFWjQyNjBRaFJRUjh5UkNV?=
 =?utf-8?B?aEJDL2ZRRFBPTEFRbWVuMVVBVkJ2bkUxQi9meWN1aU53K3R3MVFVaDZCTmhG?=
 =?utf-8?B?MWg5b2FkQytIMVJOSXVGbSszNmMxRlBVaXdBZ2o4cUVidmdCTWpXU2FZT1E3?=
 =?utf-8?B?ZngzamdSa01hZW9FV2J0UjNOUVB3SXNsOTBVYXJ1TGVJWUlDZVBLNmRmQTJv?=
 =?utf-8?B?dmZsc2NBTFF6MlRBWmJKR2JocHdJbG5aVEV2dWJSalVTalpMaG1oYmU4bEMv?=
 =?utf-8?Q?gDKyNHp4cGQ6gYvl7mq+U58euepHFjW8AE0RR6V?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWJNZ09VaktLTDhWKzJXQzdPYkFBMkxKWWFwUHkwZTZ3cy9QNGIvY1dWWkZm?=
 =?utf-8?B?djU5MnlkN2tYTDlWOENuM0l0UXhTT3FKUy9TcnVHbWJrUWZ3eGhoQ3FrZkV6?=
 =?utf-8?B?N0oraGNrOXdyUmVlWlhaVDhQd0ZpaG5naWtSOWxtSTh5TWpXRzc3Y2FKOCtM?=
 =?utf-8?B?NDJiclJHTGFUK0dTWVpwaHpKM204NUZZMUx3eUJWcDBPZlJlSmQ4N0I5RVJT?=
 =?utf-8?B?ZWVoUVNhUVlmTjhZM1NHeXZhSGlmeHhiL2QySkwzOUFlT0VLSkliN3ZyS042?=
 =?utf-8?B?Z0hCT1Y1YVNVc1pmNml3ZEQ4eFVvY1lpRjVJcW0zOXRnMU5MRnhqTDVIQmI0?=
 =?utf-8?B?ZTFkN3RxblhnNEpBdjl4U003TjFmUldlTFJjcFhNSXYwWXkzK3JvMWJLeVVY?=
 =?utf-8?B?M3c2WkdadkFBNm1XMDdCOExubFY5WGk3YkZ5dm5uVll0ZkltdmpkZmZ3UDlr?=
 =?utf-8?B?WjJaMFI1L05qUFkwWkFDbUpSTHgzMXF5K0ZBOVJxcmhaMmllSVE1b0NyTnlR?=
 =?utf-8?B?MVVRRFpud21HU3Yvakl1MWZrV3hKZE1iSFJQVjcxYUo4Y3VsU2N6VTRXQi9l?=
 =?utf-8?B?MWpyOWxFcW43N0ErUnNHeG56enZxcXhNemFJK0tyQ2VzRE1kdHBCL0JSWWZI?=
 =?utf-8?B?TldRVGExWEJQMndEODBIMS8vTEV3TWRvZ0o3YS9DSVJ3dEEvUENFZFZHbyto?=
 =?utf-8?B?cEx3dFpXMUwxcnh2Z1g4ZVpNd2xrdG0yWTZHWWVneWtxSHp5TUlZUDNXclFz?=
 =?utf-8?B?ekVYMmFjQldnVWR2TzhxbjRydk9tRXpoL3VoOHZ5RVB4ZnJCWCtMNGU0V1hC?=
 =?utf-8?B?WXloWUF1MG91Vmx2MElTbXEwK1pFNFB2SDhFMEYwVTRUZHhMTmNrWHJSNllr?=
 =?utf-8?B?VXdEeWF2L0YyY01ZTmhGdEI2cDE5M3h0cU1MZHkzb216WCtzVWFsRVlJM1NY?=
 =?utf-8?B?eWNielZhR3lXSytuT2NHZDl1TG15OFR0V2FCbFpFTEVXVlFpSG5EOGVFby9o?=
 =?utf-8?B?S050MFp6NkhFL2VRbWJXVzhXYjhuTi9ZWjh5R0FyWjNldHNRVTFRcm1wcE5L?=
 =?utf-8?B?bmhUMVZiNm5QaUQvSXZrcG8xWmR5QzFSRnczaFhjQkZWSlpVQ3VhaVhHalJv?=
 =?utf-8?B?RFRRQjNMSHdsVzJTNDlxc0dReDFFSDRyVVhPZE8yU1BKMEtMbm85YXR0YitI?=
 =?utf-8?B?TmVDVTBJUEY1RG1odmJkdmFnZkE2MElhZHFVeHRRSzRBVEdLSTIvUXFKZEpa?=
 =?utf-8?B?dkJrcGkzdktzZjJsd21XT050WlBHcEJHVFppdGQ4dTBnem5wNC81V3BuZzBI?=
 =?utf-8?B?YUJ0a21yeE83K3lEL05XcS9yeDZvelpsQ0xjdUphaFAxcm1wSlVPMlBOa3hj?=
 =?utf-8?B?Sm1HQ3VrUU9iSXA0aEZRRStQVldEd2xPQ3hLRk5JbVZWZWpyNnhkUGgvL3lS?=
 =?utf-8?B?VmY5LzBjQVBDSzFKbkxFQ2Faa2Mva0dJS0U3RVZ0ZnJ0a01DVkMrbTNLY1Uz?=
 =?utf-8?B?TFZac3lwWkd4bWpRQldzM0JoaEpnOW5HWW5CWm9TMU9TR1hTMG9vVWpOemJp?=
 =?utf-8?B?bFp2Wk9jb3hYWE9aWDRpaFEzQ3JZRGZ3VHRKamJpOXBLd2x4cWZQei90blRw?=
 =?utf-8?B?V2d4akJudVZObnk5TUZZZ1NJeHQ0WHdvR2ErRmVhbzR6bVhLT0NYL0RXZjJ5?=
 =?utf-8?B?c3V2S2VaWjVBV1B0QzRWQ1hmQktmYVhodWR3dzh4L3NXZnlXWFp5NVJkaHlu?=
 =?utf-8?B?UGIyYUw5WFZSaHJTNFJjYU4raHpmUHBwSHpPVzJvOWkxMDY2dTNDWm1CSWlD?=
 =?utf-8?B?ZmVPYXZTM1Z4aWRQaVhrRkV0aGk3Z3hESWxLQjY1KzRPR1pCZG9MMjVHdll2?=
 =?utf-8?B?THhDZ3BMTFdQMDR2Szh0YXJVTlRrVHB5NHpmNWxJWWxBYnNlL3NkNFVJS0wz?=
 =?utf-8?B?bmd2QnBReTFEQzQ4UktQeGZ2eG1MNzlveHRaY2U1UEZrYVFlN2IyMzZZTVFF?=
 =?utf-8?B?ZkpqOHlJMVZyTWFSSFdBcmpwUW5sZW1pb0diTUdDVVNEODc0U0RpZnZoK096?=
 =?utf-8?B?Mk41bm5OSjdNR0pXNUF2RVliQ2crampQUFFwdDdpQTg2N0h4RXBGSk5XaENI?=
 =?utf-8?B?c3lvTmZuQlJ4Y2xNYWRzTEcrZUxBMzRBUmxjNldsdW5hZE9Cdnc3NUQ3ZWdD?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d73a7f9-bb1a-4176-8b59-08dcef70d5ea
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 12:31:48.5164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJGP7b7ZuZmHqAOxP4cOX87C8hlE8F0GcBQvR65J7Z3nwG96cq2H77Hj604fPqijLO06IBqN0FnBnhCb/lURKqA70NgFyxvRzE4QSNKrwnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7609
X-OriginatorOrg: intel.com

On 10/18/24 13:15, Peter Zijlstra wrote:
> On Tue, Oct 01, 2024 at 05:30:18PM -0500, David Lechner wrote:
>> Add a new if_not_cond_guard() macro to cleanup.h for handling
>> conditional guards such as mutext_trylock().
>>
>> This is more ergonomic than scoped_cond_guard() for most use cases.
>> Instead of hiding the error handling statement in the macro args, it
>> works like a normal if statement and allow the error path to be indented
>> while the normal code flow path is not indented. And it avoid unwanted
>> side-effect from hidden for loop in scoped_cond_guard().
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>

So this is guard()() with error handler for cond class of locks.
I would name such guard_or_err(), or guard_or_err_block(), to make it
obvious why there is a block attached (so bad we could not ENFORCE that
there is a block atached).

Then, having it, it would make sense to not only limit guard_or_err() to
cond class of locks, but also forbid plain guard() with cond locks
(instead just discouraging it in the doc).

>> ---
>>   include/linux/cleanup.h | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
>> index 038b2d523bf8..682bb3fadfc9 100644
>> --- a/include/linux/cleanup.h
>> +++ b/include/linux/cleanup.h
>> @@ -273,6 +273,10 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
>>    *	an anonymous instance of the (guard) class, not recommended for
>>    *	conditional locks.
>>    *
>> + * if_not_cond_guard(name, args...) { <error handling> }:
>> + *	convenience macro for conditional guards that calls the statement that
>> + *	follows only if the lock was not acquired (typically an error return).
>> + *
>>    * scoped_guard (name, args...) { }:
>>    *	similar to CLASS(name, scope)(args), except the variable (with the
>>    *	explicit name 'scope') is declard in a for-loop such that its scope is
>> @@ -304,6 +308,13 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
>>   
>>   #define __guard_ptr(_name) class_##_name##_lock_ptr
>>   
>> +#define __if_not_cond_guard(_name, _id, args...)	\
>> +	CLASS(_name, _id)(args);			\
>> +	if (!__guard_ptr(_name)(&_id))
>> +
>> +#define if_not_cond_guard(_name, args...) \
>> +	__if_not_cond_guard(_name, __UNIQUE_ID(guard), args)
>> +
>>   #define scoped_guard(_name, args...)					\
>>   	for (CLASS(_name, scope)(args),					\
>>   	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)
> 
> 
> So if I stick this on top of:
> 
>    https://lkml.kernel.org/r/20241011121535.28049-1-przemyslaw.kitszel@intel.com

I have v4 that fixes non-cond version. Apologies it took me that long.
[v4] 
https://lore.kernel.org/netdev/20241018113823.171256-1-przemyslaw.kitszel@intel.com

I have tested it also with the unrechable() calls removed, as suggested
by David Lechner here:
https://lore.kernel.org/netdev/0f4786e9-d738-435d-afb9-8c0c4a028ddb@baylibre.com

> 
> then I can add the below:
> 
> --- a/include/linux/cleanup.h
> +++ b/include/linux/cleanup.h
> @@ -277,6 +277,8 @@ static inline class_##_name##_t class_##
>    *	convenience macro for conditional guards that calls the statement that
>    *	follows only if the lock was not acquired (typically an error return).
>    *
> + *	Only for conditional locks.
> + *
>    * scoped_guard (name, args...) { }:
>    *	similar to CLASS(name, scope)(args), except the variable (with the
>    *	explicit name 'scope') is declard in a for-loop such that its scope is
> @@ -290,7 +292,6 @@ static inline class_##_name##_t class_##
>    *      acquire fails.
>    *
>    *	Only for conditional locks.
> - *
>    */
>   
>   #define __DEFINE_CLASS_IS_CONDITIONAL(_name, _is_cond)	\
> @@ -342,6 +343,7 @@ _label:										\
>   		       __UNIQUE_ID(label), args)
>   
>   #define __if_not_guard(_name, _id, args...)		\
> +	BUILD_BUG_ON(!__is_cond_ptr(_name));		\
>   	CLASS(_name, _id)(args);			\
>   	if (!__guard_ptr(_name)(&_id))
>   
> 
> That make sense to people?

despite name, looks promising!

> 
> I've queued these two patches:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core
> 
> But lacking if_not_guard() users, the robot isn't really going to give
> me much feedback there, I suppose...

Couldn't you just pick the other patches, that use the newly introduced
macro?


