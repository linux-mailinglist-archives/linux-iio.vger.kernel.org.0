Return-Path: <linux-iio+bounces-17496-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B51A7729C
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 04:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C75D16B22F
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 02:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5A017B4FF;
	Tue,  1 Apr 2025 02:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NQMQyA19"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D909AEACE;
	Tue,  1 Apr 2025 02:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743473570; cv=fail; b=U11YkpXoLTHEyarQ3u6gE4b3YceUP4tFxb8sQzKaCbPAdB2SzBULcukNuJ87CeRuG4eQjJHKtwFJxkXQ19h33/UP/+S7UwdeMiwyuOlqfOSHInDjepkxFE5N+ZuX+5whtU9c0zSqoMdXRUmlocCVDonqk+4/rZRG9gwnk9EyfLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743473570; c=relaxed/simple;
	bh=C3L9VzaasmWa2lZiCf00i39VEUl/rEdcLdesX5/TyvQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NbxrQ9HjoLjVXwyLWEzJc1vqJ0LIkxm0CMBIm2ElCal7ZeDN2KdwrH5aaaN5TJ6zpC/oawSAEZhS4hL4ap7LMX2Dy58BkELYoenIynNwxeo/KOp3n5ALNCMooJ0Qt6gCWWZUI8Go+NalAb8H96uTbwmQKI+qkAMAeNd9sc2Iq9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NQMQyA19; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743473569; x=1775009569;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C3L9VzaasmWa2lZiCf00i39VEUl/rEdcLdesX5/TyvQ=;
  b=NQMQyA19FwheSVgtVd7Ut1rTptuOPNHhoHYhMurlzMr4eL3r280yNuOc
   vkXiuOPuToTUPXqu0cDaV7wreex6wD7WEBs5CQuKtOXO4i+U5PqBzKytO
   HMcGlKnGjBxoscXquUoOioQtO+AUnuw/2W2O6jZtxc4cF62D5izLQlg9/
   RWCBCga0XqCln+ZqTnspvaCmGKbCO+bJUH2RbYcibC6b+fBAJE+WVSKzu
   LXohQ6iurBorKn47z18bOzZrKvMIpLNGS+XKkRgdPw6YkywvBzR7Ngl/j
   BuD5nMM3a26gg1LWz6LiN4ZgY8EuRhNMBJiu4ONuPEPMrp+MBMFwZK5qz
   w==;
X-CSE-ConnectionGUID: 8zCoWX5lT6aL8EcGD/IYWg==
X-CSE-MsgGUID: BAQACcT6TOuRqir6ucoshQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="48650973"
X-IronPort-AV: E=Sophos;i="6.14,292,1736841600"; 
   d="scan'208";a="48650973"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 19:12:48 -0700
X-CSE-ConnectionGUID: RAfof4i+S6u7WHGJDRO4kw==
X-CSE-MsgGUID: JWer+HJFRRKLG3ZXEaZwTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,292,1736841600"; 
   d="scan'208";a="127156488"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 19:12:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 31 Mar 2025 19:12:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 31 Mar 2025 19:12:47 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 31 Mar 2025 19:12:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hEmmrYr57IWpHKCS+HSHBKEDUWF6bk8NE1jIiJMQGDqU8IZmj1huguJYWdlcEkpp+gK09be3gAb1gNED0JwrDw2UG0dits165NkQVDebTo94RT/O/nZlaB7D0gX631fOCMFYHpkHeIjdYjg9Y3vZvj9fd0dJvn8tkU7u21PjFPp3ulZAIeXc4K/+ExnMT5Rk5lfV7mDuWheP4hnyKbPi9Uy/X2DJRl9RIKTxDIajB2BIlrG9AjsVo8GMjrAFxGQO2OErGPhYV0YtvfKpc0jXkftdAAWbDVx1D+qEk0aKowNuGqnZDJ22JUOE5NcaMCwj8O9VenbHH5zP74vptaM0LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3L9VzaasmWa2lZiCf00i39VEUl/rEdcLdesX5/TyvQ=;
 b=GcYGGxYbDwvulI1vmvm8e+WB7hSFcUyOdpIHAcZ04ifzik5cUnSIGfbBx83CnJd9r0ij3FoJ4BBqKZmA7qXjFfHDsiMkn4+RmbSewRDRz5Q+yGnvZFD/evXD9COfe/b8M8QvAizP+9djGnqYsp8CHGuWkTaR0f4UQHpy2cis0W1AkWE4uEncsC9bVDyUszG2DgZLDsvh2GevTsmyitsDcNkpz2LQ2IWw7BD+TfGu8WemhPOCugt8yEOYlj4Eoaa0UeECF+tmJIg3pTvw9pyIKPA3Za6jgDPGO6JqKbsCwKtsPdlAHqbPXiS9eiQwNajpDiqQd8QMtt9gJJ3C9NJ6eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5995.namprd11.prod.outlook.com (2603:10b6:8:5e::11) by
 SN7PR11MB6797.namprd11.prod.outlook.com (2603:10b6:806:263::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Tue, 1 Apr 2025 02:12:26 +0000
Received: from DM4PR11MB5995.namprd11.prod.outlook.com
 ([fe80::654c:a738:ac8:7908]) by DM4PR11MB5995.namprd11.prod.outlook.com
 ([fe80::654c:a738:ac8:7908%5]) with mapi id 15.20.8534.045; Tue, 1 Apr 2025
 02:12:26 +0000
From: "Zhang, Lixu" <lixu.zhang@intel.com>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, "Jonathan
 Cameron" <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "lars@metafoo.de"
	<lars@metafoo.de>, "jikos@kernel.org" <jikos@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "ribalda@chromium.org" <ribalda@chromium.org>,
	"archana.patni@linux.intel.com" <archana.patni@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Xu, Even"
	<even.xu@intel.com>
Subject: RE: [PATCH 0/3] iio: hid-sensor-prox: fix SCALE and OFFSET
 calculation
Thread-Topic: [PATCH 0/3] iio: hid-sensor-prox: fix SCALE and OFFSET
 calculation
Thread-Index: AQHbogCL2XoewIXLrk6o+7eq+v8RRrONFEYAgAA3zYCAAMalEA==
Date: Tue, 1 Apr 2025 02:12:26 +0000
Message-ID: <DM4PR11MB5995241F5F4D09B9723CE60193AC2@DM4PR11MB5995.namprd11.prod.outlook.com>
References: <20250331055022.1149736-1-lixu.zhang@intel.com>
	 <20250331120040.75d0577e@jic23-huawei>
 <1563fdf418c33fd86a90ae295669f844b16ae66e.camel@linux.intel.com>
In-Reply-To: <1563fdf418c33fd86a90ae295669f844b16ae66e.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5995:EE_|SN7PR11MB6797:EE_
x-ms-office365-filtering-correlation-id: 893c85ad-9f6b-4a25-3cf4-08dd70c2a608
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NWZRMlViaVZoMy9VMml6QXpRZjZQY0xPUXhERnZjUjQybjk2T0wxVEk1UjBY?=
 =?utf-8?B?TEVIRUNveTRBd0ora3Q3RU9JY255ckVCOW80SnRnT0lySW1wVkFMK04wMGdU?=
 =?utf-8?B?Q29xSFZPL2Q3OGZYRDBPRzZrRkdwb2w5S3V6N3Z3RC9GRjFTWGd6dE85SG9m?=
 =?utf-8?B?aWkzYUdxWDdkaG92N2xNT0NtNGVVVXhZaUxsZGsyL2JYNW9JWmtLYk44dlFh?=
 =?utf-8?B?UzBBcGo1SmtMSzNaNk9lWExRM0VlTGFqQ25YbE14N2liWGQ3bXhqNlBHa0NL?=
 =?utf-8?B?aTBqenZ6N1ZEYU81RE03czBnOU85WHpwUlR6SXlJajJDNXpZeDE4bjRrK2xm?=
 =?utf-8?B?RTNhU0VGOVdSUTF1Um55TldDdTZFaHJFK05JLzBTOXdLeUJYQmlhcjR6OXFX?=
 =?utf-8?B?YXl0ZXdrK1FZQzlGYW5HSTIrUVRrRTl5MUk2cXpKWUlBZ2hnaHhSVnYzckdD?=
 =?utf-8?B?VmIvOFBxUjZZT2FLNXp3ajc4WWpmelVtNG1aa3lZYWI2cUVYaHFDNHpzSHo3?=
 =?utf-8?B?WW5zem9rYnBZcnVRSm04c0dlREpnR1hCV25neWZPNmdUazJxbFFiZHNKUHRX?=
 =?utf-8?B?dkdxdHdUNHg1SjRwR09OTmgzRVNJeDdkVDhBN0ZPTk4xTUo0aWo0M21EdVdJ?=
 =?utf-8?B?OTdiTlQxbjIyVWVBWDhhTEdMMGI2TVFiK1hHT2Z5VkxIWXpsU09jeXdxVU5z?=
 =?utf-8?B?UDFOdWRxaWdxbWlHY2RqQkx2eXlyalFlR2JEQTBPZEdiOTU2NElJYkY0dUpw?=
 =?utf-8?B?M2VqNER0UmZvSlBiWi9YS2lLcnROWkVGOWN0T0ljV0xEQ3JSRFArRDhPYlNN?=
 =?utf-8?B?N3lWRndib3dIVU4yZ2JOWFEwREhabkY0ZVJuU3hXOGwrYWVjVWdhVWhRdHhO?=
 =?utf-8?B?dm5uaE4rK3p3SFRTbmpha0tmNU1uamNmZ1lJVk9uZllVYmdlTXRLend1TzlK?=
 =?utf-8?B?SGxNRDg2SGRsSU44b2xoRjczdmh2NW9UOXJnQmV5TzdmOUo0MUJRSjVvOFpG?=
 =?utf-8?B?cjkvSDhkbHMrZDNlRFZTaXlGN1BnYzNaellzbk9RVXNSaXBmWDljd1E0RGpH?=
 =?utf-8?B?SGsyc2o0T1g4UkVWQi9PcGlkTDl1QktzRmIwWWxVTVRZdmIvTXQ0b1AyWWdS?=
 =?utf-8?B?K3hJWFBSZUNrNTFzRkZJZHRwNmR4b0ttTGdQaXRWeklpYUZwbHJ1eCtwWjNS?=
 =?utf-8?B?bnU3OUhYMjdSbzZvZ3ozZllPSGhoblh1VTZSTnkxYloyajhETWVGVnFSQXRB?=
 =?utf-8?B?RmtBa1pqaTcxdXBFU0pIMWdxcDNRZlppTkVCbkZweFJrdXZ2cnB0N2FjMGY4?=
 =?utf-8?B?Qzh3MjhKRER4M0Y3bVhnby9YbVpyNXJhQXBJTnBMbkpvdFUyQXhxMS9LUHZ1?=
 =?utf-8?B?NkVqdGEwdE01Y1BDWmFWVDFWelQ4UGh0dTNGSG9oOVhLU1U3akVKMHhoaHNO?=
 =?utf-8?B?T2J4YUJIeTlmaEdNNlVkMGVQOTE2M1FEWkhKUHhWaDRoVEFKNGRvNm5sOElX?=
 =?utf-8?B?cnRrN1RqUU9tcU8vNFFZWmVWbm1HQUxKVTlVWGxZRkFiN3lMdUlFdmUzbTFG?=
 =?utf-8?B?UG1MYlUwUGNKN1UrZEhINldyYm1iWkFDcnZBMXJwUWtDSnhKdFJVYXRiUlRk?=
 =?utf-8?B?Wm1EUVlDdzlDZ2Ywb29iZnRTVEt4cnBOT3I1bjY3eWhBbkhMOWJFTXV2dk01?=
 =?utf-8?B?Vk1HK0dKaWQ4Qm9SbVBkVTROVzJrb2huMXA3U2hjVUg3SmNNUFRYbzVWakFz?=
 =?utf-8?B?dDJGUFFhZjZuRUN2SHNLUGFJY0hPbkY3WXdmM1MvQTQ3ZGZtQW5INnRaVitO?=
 =?utf-8?B?MUdXenJodm9EbncrbTllbC9VL3V1OFhxNDE1eFFGb3p0Q084U2ZHODlwUUVZ?=
 =?utf-8?B?eUFDMEdmNm0wa3FRYU0wN2x0Uldqc2JFeFBsOERja0xGL1VLTUROclpzNmlU?=
 =?utf-8?B?OW5PQlBZb09SV3dqbGZXWmhleEV3aHZneE82V3JuMk9IejdWeEYrK0xBYXYw?=
 =?utf-8?B?cjN1RkYzMjhRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVJvdTNQU3RSVzYzNDZBeEg0YVZ2SHhVcHpQajdzRXRGbTlUK0dMNG9ya212?=
 =?utf-8?B?dHNIUTN0VE9QS2lPSnlhRWpOL1NwU2t5aWgrb3JITTBQNnJjbVN5cW03Q2tK?=
 =?utf-8?B?Ni9wSzIxOWljRUFRSExIMnV4S3VnYW5JZlR4ZTZmSE9YREZJMW94cDZOMEdV?=
 =?utf-8?B?ZVFUYmgveFFpaHJ0UjA3VWc2VkRMRWtJeTJIWEJ4Sms0Q0RMTVFOSWlXQXlJ?=
 =?utf-8?B?TnR5dXBjVjdOenJjZ00vdFBYRHFRZGwycVV5OXpraS9XUDR5a2JpNUh2WlVp?=
 =?utf-8?B?djlBaXdIZENZM3lBcEVHTGdZdWErK1VTSVIwV1M3M0Q4clZUV2JEQ2krdlRF?=
 =?utf-8?B?czBNWGhYSGZVK3JVSW5wVEYrUFB6Vlo4SnN3VHpTQWtycERjN0hHektVMi9y?=
 =?utf-8?B?a1BsZmZXM2NLVXJBcURNWHU4RXUwY21HSCs5RHgxMWxrdW1jTFlhYjd1cWlZ?=
 =?utf-8?B?ZzBWbXJhZERqdGlla3JlT1NPNmxMcXhmc1pDMmxxN3ZoTDhyYUl0MDBlMFZY?=
 =?utf-8?B?YWVUdDRZZlVpTlJJTDlNbjZ3aTF0WnZ0dE9SblJ6M0hiSWY5dmtMbU8zZzB0?=
 =?utf-8?B?bXRzZURjblBicmF4U2srNW1yK1JhZkpkODBZS1BqbW9PMXRURlA1amFJYXRW?=
 =?utf-8?B?cGk3eEVnSENkYnJIMitlLzUwWk1JdGMxUFRRM1ZWVHliKzMxVkdsN2syVm9P?=
 =?utf-8?B?d09PZzlZcjE4RVg0Y1hhV1AvTzZzbkZlRHpYdWJ4MFh0S1BiZVIxbWtlcUx5?=
 =?utf-8?B?Y0hKYUIreU1PTi84bk9SQ2FCMXJmRGEvb3gzRUh0SldQTXdwd0hSZy9SQ2dv?=
 =?utf-8?B?ZFppMG5YTEM3RmRnem4vaG0wMmFFcnF0bU96S3hYRWN2SHp5MEZrcW9INXQ2?=
 =?utf-8?B?enE0ZllzcFRoczRSbVhlS0NqeWRGeDByM3h0ZkM2NHhPeVlkOXFpM1RVSjRQ?=
 =?utf-8?B?NVVmakphOUJ2WXdEQXVnQnlJQitIZ09nMng2WDhpKy8vSGFLRW9CVW01VnlR?=
 =?utf-8?B?SDFlbGxmZHhiQi9PR2p3c3huKzVsRDJ1Y1pEWElSWGs4MVlWTzhtR09sd3d1?=
 =?utf-8?B?cUt1NHE1VCs1aUViYWlKT3JEOC9Nb2VUVTlFVi9yOFlmeFJpOVlGeDJNWm5p?=
 =?utf-8?B?VTg4ZVpvcFFCVjFsVWtWdnBaYXA3enBEc29MRmNoRWgvWGFONW5qYmM1VmVk?=
 =?utf-8?B?MXBNNWx5WHRlenB3YlNuWE1VaEFCTHhrT0JrZFJiSHFJTyswbGRHNzd2OVhj?=
 =?utf-8?B?dmRHbE1aVjhJY0Z6N1ZOUVgyelFtR3BmUVltdXBLYnVsR09rY3NsOGQ2NE1G?=
 =?utf-8?B?NlZqem5hcGpINmxCdHF1YUMza2RSQzVVRDRvTU1lUXpJa1pBSklhczd1UFVj?=
 =?utf-8?B?cnpLYVlCa0NQdzZhQndSVkhWZVBHVjBVSzFVTDFOSFRsMUlRdFBCM0RmZld1?=
 =?utf-8?B?TVIxWDFia3QraW53WkxiVk8zZDdMVjU3ZkJvbmdlQlA2TnpPSVZLU3VobGRn?=
 =?utf-8?B?QlRmS2g3MDBvOHhPZ001enNPeXpOeG1qd09RQU1VUG1iMjJ5VmhNZ0VpZS9Y?=
 =?utf-8?B?TDBmZjNhVU9MVEI5L2dRU1UzRzU4UnYyYWo3aHVaVU0waUZWS25mQnltUHA3?=
 =?utf-8?B?K2RibUc0clB6VVp6WGdIemhOOTNYcERYaEg0RHRnYjk5eDlTbEVkQ21RYnZp?=
 =?utf-8?B?cWtFdExqY2hGdjZacXpEODRSSkIwNTFuMk8wTUNhQUl2MXd4VlhWcnRYTUsx?=
 =?utf-8?B?Sk1wWU82L0RtbWdheGtBMVJxeVFnRTlLQkhYZjNLWnR2N2h0cERPek5NRTFa?=
 =?utf-8?B?U1dlK2EyazdZajB6YlBmSTFBRjNTeHVwRis0QXJ5bEVVRUg4ZE51UFQ1L2V6?=
 =?utf-8?B?MU1XQlh3UHZsQlNKc3FJRk0xNTh6eWtYaTFlUHd5VmVGSW1QNGJEU1IrZTg4?=
 =?utf-8?B?SWtjSU9WVnQ5b1lqSllRQmtSWUVaTG0xaHZJTURLVTduOG5uci8vOXVkQzE5?=
 =?utf-8?B?ZmtHWTZDSS93d1BacjBNaEJkQ3RPWlR3dHZmclMzeDZvT3JsT2VFNDVONVJT?=
 =?utf-8?B?UFFkN1FKTm9uUTdDUWNVYXpKcVVRbmRRVzkvSmR0M0M5UkFFdE1Mc0xvYTRm?=
 =?utf-8?Q?4sez5lQV3Jb/4vFKvKEuXtwid?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 893c85ad-9f6b-4a25-3cf4-08dd70c2a608
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 02:12:26.7600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gjuTuEraVn5ndBM4wvkyPA1FRgJkXXvpnxNjPKlRuJEl2HrqrJDqMXTTMdgc5762NyOzX9Lo7E+7Hu4iDiwXng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6797
X-OriginatorOrg: intel.com

SGkgSm9uYXRoYW4gYW5kIFNyaW5pdmFzLA0KDQpOb3RlZC4gVGhhbmsgeW91IGZvciBtZXJnaW5n
IHRoZSBwYXRjaGVzIGFuZCByZXZpZXdpbmcgdGhlIGNoYW5nZXMuDQoNClRoYW5rcywNCkxpeHUN
Cg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogc3Jpbml2YXMgcGFuZHJ1dmFk
YSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+DQo+U2VudDogTW9uZGF5LCBN
YXJjaCAzMSwgMjAyNSAxMDoyMCBQTQ0KPlRvOiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJu
ZWwub3JnPjsgWmhhbmcsIExpeHUgPGxpeHUuemhhbmdAaW50ZWwuY29tPg0KPkNjOiBsaW51eC1p
aW9Admdlci5rZXJuZWwub3JnOyBsYXJzQG1ldGFmb28uZGU7IGppa29zQGtlcm5lbC5vcmc7DQo+
cGV0ZXJ6QGluZnJhZGVhZC5vcmc7IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyByaWJhbGRh
QGNocm9taXVtLm9yZzsNCj5hcmNoYW5hLnBhdG5pQGxpbnV4LmludGVsLmNvbTsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+aW5wdXRAdmdlci5rZXJuZWwub3JnOyBYdSwg
RXZlbiA8ZXZlbi54dUBpbnRlbC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCAwLzNdIGlpbzog
aGlkLXNlbnNvci1wcm94OiBmaXggU0NBTEUgYW5kIE9GRlNFVCBjYWxjdWxhdGlvbg0KPg0KPk9u
IE1vbiwgMjAyNS0wMy0zMSBhdCAxMjowMCArMDEwMCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToN
Cj4+IE9uIE1vbiwgMzEgTWFyIDIwMjUgMTM6NTA6MTkgKzA4MDANCj4+IFpoYW5nIExpeHUgPGxp
eHUuemhhbmdAaW50ZWwuY29tPiB3cm90ZToNCj4+DQo+PiA+IFRoaXMgcGF0Y2ggc2VyaWVzIGFk
ZHJlc3NlcyBpc3N1ZXMgaW4gdGhlIGhpZC1zZW5zb3ItcHJveCBkcml2ZXINCj4+ID4gcmVsYXRl
ZCB0byBTQ0FMRSBhbmQgT0ZGU0VUIGNhbGN1bGF0aW9ucy4gVGhlIGNoYW5nZXMgaW5jbHVkZQ0K
Pj4gPiByZXN0b3JpbmcgbG9zdCBzY2FsZSBhc3NpZ25tZW50cywgc3VwcG9ydGluZyBtdWx0aS1j
aGFubmVsIFNDQUxFDQo+PiA+IGNhbGN1bGF0aW9uLCBhbmQgZml4aW5nIGluY29ycmVjdCBPRkZT
RVQgY2FsY3VsYXRpb24uDQo+PiA+DQo+PiBIaS4NCj4+DQo+PiBHZW5lcmFsbHkgSSBwcmVmZXIg
dG8gc2VlIHJldmlldyB0YWdzIChTcmluaXZhcycgQWNrcyBoZXJlKSBnaXZlbiBvbg0KPj4gbGlz
dCBidXQgaW4gSSB0cnVzdCBTcmluaXZhcyB0byBoYXZlIGRvbmUgYSB0aG9yb3VnaCByZXZpZXcg
KG9yIHRvDQo+PiBzaG91dCB3aGVuIGhlIHNlZXMgdGhpcyEpIGFuZCB0aGUgY2hhbmdlcyBsb29r
IGNvcnJlY3QgdG8gbWUsIGFwcGxpZWQNCj4+IHRvIHRoZSBmaXhlcy0gdG9ncmVnLXRlc3Rpbmcg
YnJhbmNoIG9mIGlpby5naXQuDQo+SGkgSm9uYXRoYW4sDQo+DQo+SSBoYXZlIHJldmlld2VkIHRo
ZXNlIHBhdGNoZXMgaW50ZXJuYWxseS4gRnJvbSBuZXh0IHRpbWUsIEkgd2lsbCBtYWtlIHN1cmUg
dGhhdCBJDQo+QUNLIG9uIHRoZSBwdWJsaWMgbGlzdHMuDQo+DQo+VGhhbmtzLA0KPlNyaW5pdmFz
DQo+DQo+Pg0KPj4gT2RkIHBvaW50IGluIG1lcmdlIGN5Y2xlIGhlbmNlIHRoZSBvZGQgdGVtcG9y
YXJ5IGJyYW5jaC4NCj4+DQo+PiBKb25hdGhhbg0KPj4NCj4+ID4NCj4+ID4gWmhhbmcgTGl4dSAo
Myk6DQo+PiA+IMKgIGlpbzogaGlkLXNlbnNvci1wcm94OiBSZXN0b3JlIGxvc3Qgc2NhbGUgYXNz
aWdubWVudHMNCj4+ID4gwqAgaWlvOiBoaWQtc2Vuc29yLXByb3g6IHN1cHBvcnQgbXVsdGktY2hh
bm5lbCBTQ0FMRSBjYWxjdWxhdGlvbg0KPj4gPiDCoCBpaW86IGhpZC1zZW5zb3ItcHJveDogRml4
IGluY29ycmVjdCBPRkZTRVQgY2FsY3VsYXRpb24NCj4+ID4NCj4+ID4gwqAuLi4vaGlkLXNlbnNv
cnMvaGlkLXNlbnNvci1hdHRyaWJ1dGVzLmPCoMKgwqDCoMKgwqAgfMKgIDQgKysrKw0KPj4gPiDC
oGRyaXZlcnMvaWlvL2xpZ2h0L2hpZC1zZW5zb3ItcHJveC5jwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fCAyMiArKysrKysrKysrKystLS0NCj4+ID4gLS0tLQ0KPj4gPiDCoDIgZmlsZXMgY2hhbmdlZCwg
MTggaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4+ID4NCj4+ID4NCj4+ID4gYmFzZS1j
b21taXQ6IGUyMWVkYjE2MzhlODI0NjBmMTI2YTZlNDliY2RkOTU4ZDQ1MjkyOWMNCj4+DQoNCg==

