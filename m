Return-Path: <linux-iio+bounces-14302-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8854A0C11D
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 20:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B957A16876A
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 19:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5CD1C5F08;
	Mon, 13 Jan 2025 19:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JEFEnG+E"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DB1240243;
	Mon, 13 Jan 2025 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736795670; cv=fail; b=prWNyKtDqqqg925COlZDl0lvxvPYsVBqhSCZfuKAydch3OddI/hvHGOj5QoWNZ/9N7vEbH3bOqII5/sZd1XKtV0KKMI1X+hi/OzdV2s0b7qyFbEiE6NxdGohf7AFTTj9muYivP2CzVR/gI56KTBYBx/s7XtPCU42bfgCToSznKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736795670; c=relaxed/simple;
	bh=LfOULCHKTiLTHdE6dwufUpwuixWpVrri+71khUFrDAU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C90J+oNqcE3a+a5gTJecTqxSBp5HjyynrVrqRK0wSxrnxG0RwkwZACbnMKJdRL8btZntONacNrKw1tha7UxlvRtMru+riRD9fEThv8sFzvHUPapbVGo7q3hTx/oPslZgmA6HMt388ZsYKnHNIzdqu6yBykjaPhDVvlUb1AGpMaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JEFEnG+E; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736795670; x=1768331670;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LfOULCHKTiLTHdE6dwufUpwuixWpVrri+71khUFrDAU=;
  b=JEFEnG+E4RrwWtEOFtXD/ljEYmfRhhQwFDar+nZTVIuPkHfcH4TPKZRa
   lsuEeGD6//8pCeqS+n7uLQIfMADGfuUe849EiYT/ceFcqSbmCvTPSeJ26
   v0kmNo+GJSqWe8u0R47dfxlu7BP6FeS+u//cJ9TYTZ6J17GP/SOnmwCt0
   uy9sNNTCgZGmkrrCq9C0Oi2Rx2L3YR/3dvvQN4zDfL6SQ/m8Fn9JUUQa5
   ZW3FnHpmYBuL3ROwsiWQaWMFo5h96SKdsiQuxrwsKy4gOJcoeJvnKIB2W
   HRJyS96K5mYE7QPBvBc4ZFIaGiSdyLTXMbOmV34mNB32+6rjNiGW85CpQ
   w==;
X-CSE-ConnectionGUID: abu41RRUQX2+FVb1LmJN0g==
X-CSE-MsgGUID: +aDKd8OSQ8628NFPA3z4dQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="36958006"
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="36958006"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 11:14:29 -0800
X-CSE-ConnectionGUID: N8PU+2u+Rtm6Xqis2Ah2NQ==
X-CSE-MsgGUID: ORNT2y+YTyqdCU3LSrqzgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="104657267"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 11:14:29 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 11:14:27 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 11:14:27 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 11:14:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWoc50P6LnM4T/xSi1C6tHU9YufEEUT8dbZRx6m0pMa3031eUIfENoE+HC5MTyvnKRK0eZ12VtS92EyDIWoSlvE7rjGMkrT/L5YCiLkBFIHqFphQMayZlWstn3FZuG7RPvurvas27Jq7MrjyszqVrrdA6xoABcmz0rq5bAc30qm/kHhvfqhgJBfqCDGJpwvsoHm6Rf7/me56MmAun2RpIsS7Pv/yrM3W+h3rg6Epv18hTR43hh5xel/gJL8zC7devNOsbriI7obbTYWZgw/UF+CSnqYyWNh/XP7ADHFFwFtb1rbmXFqN0CuafDDVrMj5tfd5ky7hPXeTi4h7+BKDuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfOULCHKTiLTHdE6dwufUpwuixWpVrri+71khUFrDAU=;
 b=f/hZZ1H2hY0Zjh2oX+DU6QEE5SjRV0qDJ2ZSd6D1OMECgQczhWx6LeU3nrQ1WhkwnL+rNn1cTl+xPaIcu4GX4GCUgOU2bmmhpL4tM8NdeIOQ+UYLGHg/pNQ1RZg6Bc15Lz5Oo17dQI36oVHkXQ7lAEaaTrw0P3D1m2v3yjLPBQ0QYAQHXZV90v7leLrfjDNbfAgB/sxGlG646W1qZQIgUMtqgodKoS59IM6PWI8Duo0geUiQcw+S8V/+fzM1WwTLcN2lxhDX4dOLZkHP7HdPJy9LjT01Yru+PLFVvDRJ3H5FtH6XCk+Pz/ZjtkYLtLOLVhvTD5kVzzVLyBrG1cVJ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 CY8PR11MB7268.namprd11.prod.outlook.com (2603:10b6:930:9b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.17; Mon, 13 Jan 2025 19:14:24 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%4]) with mapi id 15.20.8335.015; Mon, 13 Jan 2025
 19:14:24 +0000
From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To: "ribalda@chromium.org" <ribalda@chromium.org>, "jic23@kernel.org"
	<jic23@kernel.org>, "Pearson, Mark" <mpearson@lenovo.com>
CC: "jikos@kernel.org" <jikos@kernel.org>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "lars@metafoo.de" <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: hid-sensor-prox: Split difference from multiple
 channels
Thread-Topic: [PATCH v2] iio: hid-sensor-prox: Split difference from multiple
 channels
Thread-Index: AQHbZe9brT0LJj+oNkKxWI/dxTeteQ==
Date: Mon, 13 Jan 2025 19:14:24 +0000
Message-ID: <45ae61a978e7d4ea34502604a6d508f14c29303b.camel@intel.com>
References: <20241216-fix-hid-sensor-v2-1-ff8c1959ec4a@chromium.org>
	 <20241219171718.2af17d6d@jic23-huawei>
	 <CANiDSCvkKX68UqSuKiGiys8nwm5BX-FbKmHPtxJK=Hh=B4RqZQ@mail.gmail.com>
In-Reply-To: <CANiDSCvkKX68UqSuKiGiys8nwm5BX-FbKmHPtxJK=Hh=B4RqZQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|CY8PR11MB7268:EE_
x-ms-office365-filtering-correlation-id: ee241fc3-bc56-44a4-a744-08dd34067e15
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?LzYwRUt3VmcxQmtIMmEvZm55SDFEWWN6ZlMybExYbVRjdFgvbjBlbTRQL2tu?=
 =?utf-8?B?bk9uUXlRWGRYMFdWYjNGbVpQYWk2ZmZ2Z2o4Z0NOZEpJcGpRejd3Y290VnlP?=
 =?utf-8?B?QTdjWHRHZSt3QTYxdUxSdkhRSkM1NDhudldRWjBzOFJ3alRlZnZBeFE4MGtz?=
 =?utf-8?B?K3NadTBNZlVkdWtSai9GTVphU0tyeG1wdC9yZUpadGErR1VVWVFXY21HY2sw?=
 =?utf-8?B?WXlNaUtZSS9iQm9NVDhGZmZOU2dkZ2Z6eG1EZFFBVGhUK2dzN3BnVU0yWW04?=
 =?utf-8?B?cWJoM2pZRXZMT0J6ZTRKQ2hPa1Jyakd2cHRYdkJtWnE1b2l3U3I4ckd3d0Uz?=
 =?utf-8?B?WXF1cDFVYnJUN24xVXkvOElKVWZEbklPUWlyZTMyNUhuS0VhREgvOTArLzR2?=
 =?utf-8?B?cEQ1dTJTRXNMYkFHVjJEOXFhdHQ1aXlLcHJoT2hSV2ZkUWlBQTExNkc4T2dO?=
 =?utf-8?B?SW8xQ2lKZzZEMXQydS9ES3VSVFQvWUhiTVhJdHN0ZEtjM2x4MFl0VllBWUNJ?=
 =?utf-8?B?aUt6dm1IeTlUUzBWdWJMWU1hUnBIOHk0UWZ4L3JNUHFIV3VjcmRRbXFPT3lt?=
 =?utf-8?B?S0l1YjNXN3p6ZmhZeDdXeTFVbjc4R1dERncyMVJzVjc3OXhoclVZeHBBYXdM?=
 =?utf-8?B?amkxSFBFTUwvcWZOb2JTaStRN2x0S0JvQWJORnU1WFlVNkN2VG95cHAxajVU?=
 =?utf-8?B?Vk5sNW83Y3NhbGhNQU9vU0p0UTdHVGVOaGd6eDlBZGUydW0xTnpNTEhCeXNi?=
 =?utf-8?B?eVJreG84U2J2QzFGTlEzWExQcmEwQzZBd0FJckYrVkpVVTVUWkpDR3AwVkVw?=
 =?utf-8?B?VThEeDF6d3ZValNwV2JycVdVdUVxLzczYThxOXEwY0hGOWgzVE1reXgxNjR6?=
 =?utf-8?B?S2pJSXk4ajRZcHZCcWlpYnlKZ3ZsTWdnWlZ0ZFpMdzgxaTN6cXp5cXRyRDQx?=
 =?utf-8?B?Ukt0b2hqRm9LL0pETTYwQlZuckhsWTV6ci9oVlppS203Zzc5MCtSZHpncHpB?=
 =?utf-8?B?d3ViRE8xcy9zaFVBYjY5eVNXeGc5RDhzdHhRSEM0VmdWbVhYU3pEZ2NkaS9u?=
 =?utf-8?B?MVF4LzhhaUV2OTBoSEwxZ3RRa3gxWnB0Yk9YYlJ5ZXNkR3VFSFVobjFNbXhW?=
 =?utf-8?B?N0ZZUTlNcEcveklwUURFUGN0cnRiZENPUlN2UWVPT1l2WjdUNXgrVTE3SEJn?=
 =?utf-8?B?ZVZtUXF0Q1YyMnBZVmN1VmlycXUrT0RBTExYb1JscXhsMDdUYTNIVlJVNU1K?=
 =?utf-8?B?QVRsRnZFRHZmSFVIT1h1eUFEdDlaSHVLdkF1blZGemZlV1ZRYXluWmpRZEZ2?=
 =?utf-8?B?M2RjTFA0V203UEhHN0ZvQXZzSUVNbGt2amRGTEV0MEZJNzhTSHNmZ1VoQVlm?=
 =?utf-8?B?OTVKMEsyRkxGaGR0dFZQd1FoQWJGSkRHcGI2NHBYTlB1VGNKMmxtRTJDQnRD?=
 =?utf-8?B?RHZsL2JPQW9jVkNBWWZzeldpVFR6Mm5nMUZUWTBWZFhNZlg5ays2ek1MVDA1?=
 =?utf-8?B?dlk2S2NMb001RkxoakoxOHJFSkZrU0ZXTVFkZ1FBR29mT09VT0N4VFdja1E0?=
 =?utf-8?B?bm5zMGZUWCs1Q2JOTUdmMFozcE91VWFpRkFEYm1DcUNTZ2l3L2N2VWY5RG1I?=
 =?utf-8?B?SzFpQ2g1M1Qzd0R5dUtvUnMramQ5Y1RDTVFUZjA3MUJVbVhvd0t1MVpGVGFP?=
 =?utf-8?B?MS9PZlVmNzJGS2pqeHk3TitRYncrTjFRNTJhOFRsYnNzL1BkVVZVa00rYkow?=
 =?utf-8?B?VFE2ZnBwa2lSME4xaUJMMVlGQndpaVdrN2Ftc3I5eGFkUjlNaEEzUVBIMkVE?=
 =?utf-8?B?NmJac1FVUm9pSWZLUG9aNmozYWxKWjFtV1pnWnpELzN6QitPOEEwYjRKVHBm?=
 =?utf-8?B?VDZaNGpJTjlrWVdleVV4WWluQ1Z4TDRGcTBPZzJ3aURkSzUvS0pibitHWmxx?=
 =?utf-8?Q?3N/woyOug9N/3f6XkFf2ny/94o5k03Cv?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mk9GTWVoS0VqVU56M0FzSDFVd3hucUxQZDBJN1FsOU1zeHAvTTJBTzQwMytZ?=
 =?utf-8?B?MUJub3NFMEFjREhrN3NlZjRDTGdIb1lrVXA0ZVVMbzdCVXFYUlZ2NHg2YWZT?=
 =?utf-8?B?bUhCZjBCOGpldkpjYUpuVEdwK1lDT3JrS3ZjNnRoUUgrenpVS1IydTJ6ZWhM?=
 =?utf-8?B?TVdxMS9XeGxLdFZaMFZJNXJCd0xIenhJWWN2aVkzRmpDd2VsSGZxY3lkVTd2?=
 =?utf-8?B?alRIWkMxRGVlcm5sd3ZrNjk2RHRxV0NWaTJrMzhhc0xST3BVUDVCYkU3SVpM?=
 =?utf-8?B?MnlEVWVqc1RqUExoUXNrVDl0UzdLbURyNGtqcVQ5TnFrQlJUb1J3RzhlLzNQ?=
 =?utf-8?B?UE5JNmtsSGQ3Yi9QUkRwa2hrSkphNFVScHdCYnRVUjhRT1ZESFJyTjBXYVVu?=
 =?utf-8?B?RVNvd1hqYmlmYWxwQnRVOG1LWUdPd3kwVXFZVTNOaUZOd3BMdyt2eXl0T05K?=
 =?utf-8?B?QmFvMTFDM2gzVDFoTHhBWUxtcHQvQXFRSmRaQXF6RjJQQXAxVFhyVlFPWWsr?=
 =?utf-8?B?T0M2bjFzaDVNaWYxS09wUEovM0VFUUtrVUFHV1UrUVVjSGFIc3E1TzBsVC8x?=
 =?utf-8?B?dkZaWEt5VS9FbUZGeVNYSVZITU02Y2daQW5JVWJsTlRRNExGRjZDcHhvQ1hi?=
 =?utf-8?B?eUJtMzRlSk1md0ZVaitUcjlXU2dzQmkvbjlYQ0kzK3Z6bFgrNEhVV0poZXZL?=
 =?utf-8?B?ZWZoQmhTcFJrSmxwMml3bllLM1hQbkllanRKOGo2NUVuRE1pVW40a0dLdWVS?=
 =?utf-8?B?KytjNUdNVHppRkxSWFEzaGZGTlRocm5aNDA3Q3I2T0YvWnJheU1iRHdibkhD?=
 =?utf-8?B?SWg5QXF3c1VFV3FpdFFUVGlKQlZxSlpCbGNmdjc0elAyTjdEblJFM0tZUTla?=
 =?utf-8?B?akRzaklTOVE3bUhDblQ4VVhvOHd0alBMQjc2dklQcldZVk5VT01jdnU4cmxz?=
 =?utf-8?B?RXEwbENIRUJhYVgzQlhtVDlWM3pGODNxTHpKNWlxWjhaeWhEdFJLRWQwbDZF?=
 =?utf-8?B?eGJmOERYUFd2WWh3WlJZNVNobWx3cEpTZHZxVVI3ZkV3Zit0dDREbU5XNG9n?=
 =?utf-8?B?TEs5N3FhdllZbWdGSTJua3U5TkxscVE5cDVhZm85TE1CUzkwWERtQ3BHbW9i?=
 =?utf-8?B?NFNwcGdsWXpZMy92VjNOaE5kTXBCazRyOTNBTk02Y3haQWNYd1hEUHVtS3BT?=
 =?utf-8?B?ZmFkL1k3cEt6Z2lIdTk1eVZnMFlibjhwWG5RYzRTcEFMdjhjcWZpcUwrcFFJ?=
 =?utf-8?B?TndOaksva3MrY2djajJ6eEIrVllybmxvVnZzcUU0YXRjaDIrUkoxNUhES25l?=
 =?utf-8?B?Qkg5VnpoeExsak1lZXE1Tk1iQUZrdTVyMHhzeCt3YmZPdlV1RFZmNlNCNXdp?=
 =?utf-8?B?VExwVjJha2g1VXhjMVNtL1VOVjE3cHVFNXBoNTlqZGl6S2JmdGVGVlV0dnpy?=
 =?utf-8?B?ZXZHa3B2OENQcTJCMFRIcjI4cGs4eUJHNm5JU1JUakxEQlQzbDJueEFEamE2?=
 =?utf-8?B?VzNQemtLM1V3dS8wdnhZRndwTXZ5cWs0RkU3dkt6TkZTNmVZQVltaUVma2c2?=
 =?utf-8?B?UUxvRE9LUGdkMi9VNlN0Z3pWdHV1Qno1NS9TWUJ0N0lyN0JvN0ozSU1aaVE2?=
 =?utf-8?B?MURQSmVjY3lRTGtVTTVKZnJ0bWJBN1NoOGtmcGZtd3JzYzBUbWRBd0JsKzFj?=
 =?utf-8?B?ZTE4Mk9IdWR1a2RZSXdWZWIwUmtYSW9CclU5S2VFR0tKVktuR2JvRFRqVGZP?=
 =?utf-8?B?VzkyMWpvWWZnWjNCaFhmR0llRWJaQ3FSRWd5UUZyYUxKVmhEbkk0aDB0V3c2?=
 =?utf-8?B?Qld0bEh1MkYrdk1CQjNjck1PNnBtWWxENkVlMk4rT3V1WjZWdDJTV3BDYjFo?=
 =?utf-8?B?U1ZaQmhTUjI3QXdRQXdSNGJKaTZkdkZHL1YwVHFqQkZ6V2xQN1pia0xaMkpn?=
 =?utf-8?B?aWt1VVh0MXA4c29ja2dkN2pCVEozWkpnOEpWYmQ4ckZiYTV0UmxlaHcwZmYv?=
 =?utf-8?B?aGtodjZ6ZWZCVFl6R0E4aXpNM0gyVWxuOVJkSE1LN3VxaUIxU3lPYWRvbExP?=
 =?utf-8?B?emdFNDdyZ09DVjFFODV5dzdrMWVCbFBSTU5DaE5Zd200Vmc4ZUZ3QndNRkMw?=
 =?utf-8?B?dzgvUEtiZkhWRWtGWUZOV0N3bTI1Y1RudEU3TVFnWS90Ky9VWU9kWE4zbjVw?=
 =?utf-8?Q?B9pme5RMx4gKejp40J3X47Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AA6C3AE2219C84AB26A46D3143D2678@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee241fc3-bc56-44a4-a744-08dd34067e15
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2025 19:14:24.5899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aHLtJXbCgrj9Fu43EUQUip+nFOIdBchj32MoBTs+QgNFQ7MUcyo5yabX93/zsurixrG/ohRw5UbGaowKI5Fv+vqzS9iVL+pcpxIxKGlQ+5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7268
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI1LTAxLTExIGF0IDEwOjE3ICswMTAwLCBSaWNhcmRvIFJpYmFsZGEgd3JvdGU6
DQo+IEhpIEpvbmF0aGFuDQo+IA0KPiBIYXBweSBuZXcgeWVhciENCj4gDQo+IEZyaWVuZGx5IHBp
bmcgYWJvdXQgdGhpcyBwYXRjaCBzbyB3ZSBjYW4gY2hhbmdlIHRoZSBBQkkgYmVmb3JlIHRoZQ0K
PiBrZXJuZWwgcmVsZWFzZSBoYXBwZW5zDQo+IA0KPiBPbiBUaHUsIDE5IERlYyAyMDI0IGF0IDE4
OjE3LCBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPg0KPiB3cm90ZToNCj4gPiAN
Cj4gPiBPbiBNb24sIDE2IERlYyAyMDI0IDEwOjA1OjUzICswMDAwDQo+ID4gUmljYXJkbyBSaWJh
bGRhIDxyaWJhbGRhQGNocm9taXVtLm9yZz4gd3JvdGU6DQo+ID4gDQo+ID4gPiBXaGVuIHRoZSBk
cml2ZXIgd2FzIG9yaWdpbmFsbHkgY3JlYXRlZCwgaXQgd2FzIGRlY2lkZWQgdGhhdA0KPiA+ID4g
c2FtcGxpbmdfZnJlcXVlbmN5IGFuZCBoeXN0ZXJlc2lzIHdvdWxkIGJlIHNoYXJlZF9wZXJfdHlw
ZQ0KPiA+ID4gaW5zdGVhZA0KPiA+ID4gb2Ygc2hhcmVkX2J5X2FsbCAoZXZlbiB0aG91Z2ggaXQg
aXMgaW50ZXJuYWxseSBzaGFyZWQgYnkgYWxsKS4NCj4gPiA+IEVnOg0KPiA+ID4gaW5fcHJveGlt
aXR5X3Jhdw0KPiA+ID4gaW5fcHJveGltaXR5X3NhbXBsaW5nX2ZyZXF1ZW5jeQ0KPiA+ID4gDQo+
ID4gPiBXaGVuIHdlIGludHJvZHVjZWQgc3VwcG9ydCBmb3IgbW9yZSBjaGFubmVscywgd2UgY29u
dGludWVkIHdpdGgNCj4gPiA+IHNoYXJlZF9ieV90eXBlIHdoaWNoLiBFZzoNCj4gPiA+IGluX3By
b3hpbWl0eTBfcmF3DQo+ID4gPiBpbl9wcm94aW1pdHkxX3Jhdw0KPiA+ID4gaW5fcHJveGltaXR5
X3NhbXBsaW5nX2ZyZXF1ZW5jeQ0KPiA+ID4gaW5fYXR0ZW50aW9uX3Jhdw0KPiA+ID4gaW5fYXR0
ZW50aW9uX3NhbXBsaW5nX2ZyZXF1ZW5jeQ0KPiA+ID4gDQo+ID4gPiBJZGVhbGx5IHdlIHNob3Vs
ZCBjaGFuZ2UgdG8gc2hhcmVkX2J5X2FsbCwgYnV0IGl0IGlzIG5vdCBhbg0KPiA+ID4gb3B0aW9u
LA0KPiA+ID4gYmVjYXVzZSB0aGUgY3VycmVudCBuYW1pbmcgaGFzIGJlZW4gYSBzdGFibGlzaGVk
IEFCSSBieSBub3cuDQo+ID4gPiBMdWNraWx5IHdlDQo+ID4gPiBjYW4gdXNlIHNlcGFyYXRlIGlu
c3RlYWQuIFRoYXQgd2lsbCBiZSBtb3JlIGNvbnNpc3RlbnQ6DQo+ID4gPiBpbl9wcm94aW1pdHkw
X3Jhdw0KPiA+ID4gaW5fcHJveGltaXR5MF9zYW1wbGluZ19mcmVxdWVuY3kNCj4gPiA+IGluX3By
b3hpbWl0eTFfcmF3DQo+ID4gPiBpbl9wcm94aW1pdHkxX3NhbXBsaW5nX2ZyZXF1ZW5jeQ0KPiA+
ID4gaW5fYXR0ZW50aW9uX3Jhdw0KPiA+ID4gaW5fYXR0ZW50aW9uX3NhbXBsaW5nX2ZyZXF1ZW5j
eQ0KPiA+ID4gDQo+ID4gPiBGaXhlczogNTk2ZWY1Y2Y2NTRiICgiaWlvOiBoaWQtc2Vuc29yLXBy
b3g6IEFkZCBzdXBwb3J0IGZvciBtb3JlDQo+ID4gPiBjaGFubmVscyIpDQo+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBSaWNhcmRvIFJpYmFsZGEgPHJpYmFsZGFAY2hyb21pdW0ub3JnPg0KPiA+IA0KPiA+
IEkgZ290IGxvc3Qgc29tZXdoZXJlIGluIHRoZSBkaXNjdXNzaW9uLsKgIFRoaXMgaXMgc3RpbGwg
YW4gQUJJDQo+ID4gY2hhbmdlIGNvbXBhcmVkDQo+ID4gdG8gb3JpZ2luYWwgaW50ZXJmYWNlIGF0
IHRoZSB0b3AgKHdoaWNoIGlzIHRoZSBvbmUgdGhhdCBoYXMgYmVlbg0KPiA+IHRoZXJlDQo+ID4g
cXVpdGUgc29tZSB0aW1lKS4NCj4gPiANCj4gPiBIb3dldmVyIHdlIGFscmVhZHkgaGFkIHRvIG1h
a2Ugb25lIG9mIHRob3NlIHRvIGFkZCB0aGUgaW5kZXggdGhhdA0KPiA+IHdhc24ndCB0aGVyZQ0K
PiA+IGZvciBfcmF3LiAoSSdkIG1pc3NlZCB0aGF0IGluIGVhcmxpZXIgZGlzY3Vzc2lvbiAtIHRo
YW5rcyBmb3INCj4gPiBsYXlpbmcgb3V0IHRoZQ0KPiA+IHN0ZXBzIGhlcmUhKcKgDQoNCkRpZG4n
dCByZWFsaXplIHRoaXMuIEkgZG9uJ3Qgc2VlIHByb3hpbWl0eSBzZW5zb3IgdXNlIGluIHRoZSBt
YWlubGluZQ0KTGludXggZGlzdHJvIHVzZXIgc3BhY2UsIHNvIGl0IHdpbGwgYWZmZWN0IG9ubHkg
c29tZSBwcml2YXRlIHVzZXIgc3BhY2UNCnByb2dyYW1zLiANCkFkZGluZyBNYXJrIHRvIHNlZSBp
ZiBpdCBhZmZlY3RzIExlbm92byBTZW5zaW5nIHNvbHV0aW9uIGFzIHRoZXJlIHdhcw0Kc3BlY2lm
aWMgY3VzdG9tIHNlbnNvciBhZGRlZCB0byB0aGlzIGRyaXZlciBmb3IgTGVub3ZvLg0KDQo+ID4g
IFNyaW5pdmFzLCBKaXJpLCBkbyB5b3UgdGhpbmsgd2UgYXJlIGJldHRlciBvZmYganVzdCBhc3N1
bWluZyB1c2Vycw0KPiA+IG9mIHRoaXMgd2lsbCBiZSB1c2luZyBhIGxpYnJhcnkgdGhhdCBjb3Jy
ZWN0bHkgZGVhbHMgd2l0aCBzaGFyaW5nDQo+ID4gYW5kIGp1c3QNCj4gPiBqdW1wIHRvDQo+ID4g
aW5fcHJveGltaXR5MF9yYXcNCj4gPiBpbl9wcm94aW1pdHkxX3Jhdw0KPiA+IGluX2F0dGVudGlv
bl9yYXcNCj4gPiAoc2hvdWxkIGhhdmUgaW5kZXhlZCB0aGF0IGJ1dCBpdCBtYXkgbmV2ZXIgbWF0
dGVyKSBhbmQNCj4gPiBzYW1wbGluZ19mcmVxdWVuY3kNCj4gPiANCj4gPiBXaGljaCBpcyB3aGF0
IEkgdGhpbmsgUmljYXJkbyBvcmlnaW5hbGx5IGFza2VkLg0KPiA+IA0KPiA+IERvIHdlIGhhdmUg
YW55IGd1YXJhbnRlZSB0aGUgc2FtcGxpbmdfZnJlcXVlbmN5IHdpbGwgYmUgc2hhcmVkDQo+ID4g
YWNyb3NzIHRoZQ0KPiA+IHNlbnNvciBjaGFubmVscz/CoCBJdCBtYXkgYmUgdGhlIG1vc3QgY29t
bW9uIHNpdHVhdGlvbiBidXQgSSBkb24ndA0KPiA+IHdhbnQgdG8NCj4gPiB3YWxsIHVzIGludG8g
YSBjb3JuZXIgaWYgaXQgdHVybnMgb3V0IHNvbWVvbmUgcnVucyBzZXBhcmF0ZSBzZW5zb3JzDQo+
ID4gYXQNCj4gPiBkaWZmZXJlbnQgcmF0ZXMgKG5vIHBhcnRpY3VsYXJseSByZWFzb24gdGhleSBz
aG91bGQgYmUgb25lIHR5cGUgb2YNCj4gPiBzZW5zb3INCj4gPiBzbyB0aGlzIG1pZ2h0IG1ha2Ug
c2Vuc2UpLsKgIElmIHdlIGRvbid0IGhhdmUgdGhhdCBndWFyYW50ZWUNCj4gPiB0aGVuIHRoaXMg
cGF0Y2ggaXMgZmluZSBhcyBmYXIgYXMgSSdtIGNvbmNlcm5lZC4NCg0KRnJvbSBISUQgc2Vuc29y
IHNwZWMsIHRoZXNlIGFyZSB0aHJlZSBkaWZmZXJlbnQgc2Vuc29yIHVzYWdlIElEcy4gU28NCnlv
dSBjYW4gaGF2ZSB0aHJlZSBkaWZmZXJlbnQgc2Vuc29yIHByb3BlcnRpZXMgbGlrZSBzYW1wbGlu
ZyBmcmVxdWVuY3kuDQoNCiNkZWZpbmUgSElEX1VTQUdFX1NFTlNPUl9UWVBFX0JJT01FVFJJQ19Q
UkVTRU5DRQkweDExDQojZGVmaW5lIEhJRF9VU0FHRV9TRU5TT1JfVFlQRV9CSU9NRVRSSUNfUFJP
WElNSVRZCTB4MTINCiNkZWZpbmUgSElEX1VTQUdFX1NFTlNPUl9UWVBFX0JJT01FVFJJQ19UT1VD
SAkJMHgxMw0KDQpUaGlzIGRyaXZlciBlaXRoZXIgbG9hZHMgb24gSElEX1VTQUdFX1NFTlNPUl9U
WVBFX0JJT01FVFJJQ19QUkVTRU5DRSBvcg0KTGVub3ZvIGN1c3RvbSBzZW5zb3IsIHdoaWNoIG1l
cmdlIGFsbCBjaGFubmVscywgaW4gdGhhdCBjYXNlIHRoZXkgd2lsbA0Kc2hhcmUgb25lIHNhbXBs
aW5nIGZyZXF1ZW5jeSBmb3IgYWxsLg0KDQpTbyB0aGVyZSBpcyBubyBndWFyYW50ZWUuDQoNClRo
YW5rcywNClNyaW5pdmFzDQoNCg0KPiA+IA0KPiA+IEpvbmF0aGFuDQo+ID4gDQo+ID4gDQo+ID4g
DQo+ID4gPiAtLS0NCj4gPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gPiAtIFVzZSBzZXBhcmF0ZQ0K
PiA+ID4gLSBMaW5rIHRvIHYxOg0KPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0
MTIwNS1maXgtaGlkLXNlbnNvci12MS0xLTliNzg5ZjM5YzIyMEBjaHJvbWl1bS5vcmcNCj4gPiA+
IC0tLQ0KPiA+ID4gwqBkcml2ZXJzL2lpby9saWdodC9oaWQtc2Vuc29yLXByb3guYyB8IDcgKysr
Ky0tLQ0KPiA+ID4gwqAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vbGlnaHQvaGlkLXNl
bnNvci1wcm94LmMNCj4gPiA+IGIvZHJpdmVycy9paW8vbGlnaHQvaGlkLXNlbnNvci1wcm94LmMN
Cj4gPiA+IGluZGV4IGM4M2FjYmQ3ODI3NS4uNzFkY2VmM2ZiZTU3IDEwMDY0NA0KPiA+ID4gLS0t
IGEvZHJpdmVycy9paW8vbGlnaHQvaGlkLXNlbnNvci1wcm94LmMNCj4gPiA+ICsrKyBiL2RyaXZl
cnMvaWlvL2xpZ2h0L2hpZC1zZW5zb3ItcHJveC5jDQo+ID4gPiBAQCAtNDksOSArNDksMTAgQEAg
c3RhdGljIGNvbnN0IHUzMiBwcm94X3NlbnNpdGl2aXR5X2FkZHJlc3Nlc1tdDQo+ID4gPiA9IHsN
Cj4gPiA+IMKgI2RlZmluZSBQUk9YX0NIQU5ORUwoX2lzX3Byb3hpbWl0eSwgX2NoYW5uZWwpIFwN
Cj4gPiA+IMKgwqDCoMKgwqAge1wNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC50
eXBlID0gX2lzX3Byb3hpbWl0eSA/IElJT19QUk9YSU1JVFkgOg0KPiA+ID4gSUlPX0FUVEVOVElP
TixcDQo+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5pbmZvX21hc2tfc2VwYXJhdGUg
PSBfaXNfcHJveGltaXR5ID8NCj4gPiA+IEJJVChJSU9fQ0hBTl9JTkZPX1JBVykgOlwNCj4gPiA+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoA0KPiA+ID4gQklUKElJT19DSEFOX0lORk9fUFJPQ0VTU0VEKSxcDQo+ID4g
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5pbmZvX21hc2tfc2hhcmVkX2J5X3R5cGUgPQ0K
PiA+ID4gQklUKElJT19DSEFOX0lORk9fT0ZGU0VUKSB8XA0KPiA+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAuaW5mb19tYXNrX3NlcGFyYXRlID0gXA0KPiA+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAoX2lzX3Byb3hpbWl0eSA/IEJJVChJSU9fQ0hBTl9JTkZPX1JBVykgOlwNCj4g
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBCSVQoSUlPX0NIQU5fSU5GT19QUk9DRVNTRUQpKSB8XA0KPiA+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBCSVQoSUlPX0NIQU5fSU5GT19PRkZTRVQpIHxcDQo+ID4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBCSVQoSUlPX0NIQU5fSU5GT19TQ0FMRSkgfFwNCj4gPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJJVChJSU9fQ0hBTl9JTkZPX1NBTVBfRlJFUSkgfFwN
Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJJVChJSU9fQ0hBTl9JTkZPX0hZU1RF
UkVTSVMpLFwNCj4gPiA+IA0KPiA+ID4gLS0tDQo+ID4gPiBiYXNlLWNvbW1pdDogNzhkNGYzNGUy
MTE1YjUxN2JjYmZlN2VjMGQwMThiYmJiNmY5YjBiOA0KPiA+ID4gY2hhbmdlLWlkOiAyMDI0MTIw
My1maXgtaGlkLXNlbnNvci02MmUxOTc5ZWNkMDMNCj4gPiA+IA0KPiA+ID4gQmVzdCByZWdhcmRz
LA0KPiA+IA0KPiANCj4gDQoNCg==

