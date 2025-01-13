Return-Path: <linux-iio+bounces-14306-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1C3A0C257
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 21:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0931881D65
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 20:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEBB1CACF3;
	Mon, 13 Jan 2025 20:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ght0k9M3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6601C1753;
	Mon, 13 Jan 2025 20:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736798639; cv=fail; b=ObhUVHaaDEzXY3QBxwfnFTCVXFUviNdCqFQoqCYsWOOfQwzERpRLtGDdFOH9mVgsg3YEKQv9dYY+778WRWW0Dzx4IPQSOd9XS3ZEOEhjKikNUIP5YS5znvUx5aGu7Eaf20W0r4apjFfpysMXYPB+AT5itn3m9HH9QEzYEbc6XO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736798639; c=relaxed/simple;
	bh=C32yAEkNRw2pbEz/sqptKiU87C4SIYRZfjJy5NVLG3k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dN9Y+u/z61VG7rDldZMSzluOV8vXLa8FxCt4bhnrJCjQFm7I+0AayeKP5YdIkaBDDFCkr+YCLA/ZGEr2fP7lyycKfwqciA/VYXoKqrMtmq6CUHhm4ol+2NaE8ORHSMQHUrxDzIPTjOflKTnJLKuv2EQBsP3UbuWpAH+bboGAq1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ght0k9M3; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736798637; x=1768334637;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=C32yAEkNRw2pbEz/sqptKiU87C4SIYRZfjJy5NVLG3k=;
  b=Ght0k9M3rWE+oCMgPaXMIz7K7W0Sc5XzJuEazhMM9VCuYaZyEHMQlx2f
   apQINerizljsSzr5zee4keisAWbhlnBh41TEISAO9BUJLNKX0t7fPlIGi
   FVYeN7ZjcFbin7rcVpae0RwIDNvK6XIBDmqHiO1/ur6DGGpzMQYmvo5go
   o4u3k+yPdyo+/97OYelIVXrK1sdmhsACLzlOr4MXz95EdHBb7631NRe97
   kipI/2r2CoFGHjesbm7csy4DaTF2ATd9loTfxyCnfniAUZ7uvuleSuJio
   HFliLb099+169gWNFFujq5jQW7Dg/uUg7vMrUCt2WP2JKBLm898hNm66l
   w==;
X-CSE-ConnectionGUID: PZMwVcI1RKKN6itdZA4/ZA==
X-CSE-MsgGUID: TFg42iBDRjGbd0wTSJF6XA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="47654952"
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="47654952"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 12:03:53 -0800
X-CSE-ConnectionGUID: ZRL914bBSK6UjutxTPp+sw==
X-CSE-MsgGUID: Ew17biu3Rnu1EBwb8fee4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="104352048"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 12:03:53 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 12:03:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 12:03:52 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 12:03:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qo8iNMD+8m9+gPabQ1Dk+ECpJjxko7Viw7IujeIKO29/mMxx6uLlcvAqoZ/4G30Q9iSiSAvyKtuApoCbdWNWi2qOKaBSJ6JuvcaHoilBSm7plaUkJznwRULtgLj4Rvcszb2pd8jCUA+AG/GEVoZJBP/BQi9/W6Da+ffrhNlClxzu2jho9uzHJ0Vy9nX687eLB+Vr3+kubUBYfs21uHnHmNKo3FftatMp/NWV5uOavzSuzWw2jyABQ0A3TpI+vkQpy4lHL/a9Fcv+0+ad+Cs91jtt5BGop4OiQzLiW91jcfXObSz5WFleXSrcfl0IlTgEF8j9UNr2OET/YFDTDUaysA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C32yAEkNRw2pbEz/sqptKiU87C4SIYRZfjJy5NVLG3k=;
 b=a/sdHw+X3I5kxXaxdvfyDqbqbnhB74eq2L/P774Hp9rrl8v++Su5veNdOxy27v2czU9w3oj45rwX7LXo6tDHUX263gOTcJabKtal88TY3GmQLaX5DXg17iIOXSMCPHxdOtAqPaWyw+n9xaZfCcHzyDn2LUWa1QJhEnpTcGDph8dgYhmar8f/IK6muyBFfmMkpqSRaln7EqrTTLpAqFheBXrVmdWgK1qotRNKUDqddmFHc2I+PSNbHNRtSHd1qGzeJw4EtnETyK8mRlWt73jr0k20QsXyh0kyJMtjVV7rARuAPeWoYedxr8hyF1F1clMfHQY6F8Fr4rQwcj11P6auoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 SJ2PR11MB7455.namprd11.prod.outlook.com (2603:10b6:a03:4cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 20:03:08 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%4]) with mapi id 15.20.8335.015; Mon, 13 Jan 2025
 20:03:08 +0000
From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To: "ribalda@chromium.org" <ribalda@chromium.org>, "mpearson-lenovo@squebb.ca"
	<mpearson-lenovo@squebb.ca>, "jic23@kernel.org" <jic23@kernel.org>
CC: "jikos@kernel.org" <jikos@kernel.org>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "lars@metafoo.de" <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: hid-sensor-prox: Split difference from multiple
 channels
Thread-Topic: [PATCH v2] iio: hid-sensor-prox: Split difference from multiple
 channels
Thread-Index: AQHbZe9brT0LJj+oNkKxWI/dxTetebMVHWFkgAADEgA=
Date: Mon, 13 Jan 2025 20:03:08 +0000
Message-ID: <ae3c8b20a3de94e67a9679ff4bf2b672f8c9b66a.camel@intel.com>
References: <20241216-fix-hid-sensor-v2-1-ff8c1959ec4a@chromium.org>
	 <20241219171718.2af17d6d@jic23-huawei>
	 <CANiDSCvkKX68UqSuKiGiys8nwm5BX-FbKmHPtxJK=Hh=B4RqZQ@mail.gmail.com>
	 <45ae61a978e7d4ea34502604a6d508f14c29303b.camel@intel.com>
	 <TYZPR03MB599406F8035E6322E6B66CBFBD1F2@TYZPR03MB5994.apcprd03.prod.outlook.com>
	 <8fed2747-c419-454a-bb72-43f158b4f081@app.fastmail.com>
In-Reply-To: <8fed2747-c419-454a-bb72-43f158b4f081@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|SJ2PR11MB7455:EE_
x-ms-office365-filtering-correlation-id: 1dbe0efe-953d-4149-9311-08dd340d4d0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ejhyN056U0FQdXpyYWJWVmR1SmRZaXBCZGdubmw4YnJBOTJvQ29HRXkyOGFS?=
 =?utf-8?B?QlBqZXVIQWd1UHBSa0lEY1pUVXdCS0tkUlAxUi96TjlrbTRJeTdJNjQwN3Vh?=
 =?utf-8?B?bXlER1U5bENBZFJzRE8yQndrT2Z4eGN0N3N4U3FTT3hEcGo4SGEzWEV2eWRP?=
 =?utf-8?B?eDlzYkhVbmtuUmxDeHkxb0tDZDIrcllxa0ZjaEpKN2JIeDhlZEZoeE05b0pj?=
 =?utf-8?B?TFFURE9oZkU3V3Q2aHk3Qkd1U2JJWGNzdjBJemFVVEtlcEJqSFhGY21yUUdT?=
 =?utf-8?B?NWloc3NNNDBvdzBhRUxucVRqMUhRUnpRUHdPMS8rbkxRY0N0M1pyTmpRWjZF?=
 =?utf-8?B?YjVtWnh3ekdaT0R5SUVKY3VTRFU2ZzlpRFdzYWwrb3JlRVdUbUlpS3NSZVRw?=
 =?utf-8?B?NGxQeFVXS05sU2lCeTZyei9jZHMvQUJ4TDRVeWxsVThtOE43ek5xNWFQdHVL?=
 =?utf-8?B?OGtwblVWOEQ2dlorSkZmLzhBYlhkbXp4YldjazJxVnB0alRhKytZSmRqak9T?=
 =?utf-8?B?SW9tUHNURTc4bk9hWDdLNmFCV1hGak9qM0Y1cll5OFo3UDBwbUxnMEVPVE1s?=
 =?utf-8?B?R0QvSWdZU2phN09adEJ6N3llOVpCelpXYXVhKzN4MjhnMG56Nk9FblRNakpD?=
 =?utf-8?B?aVpDekJkRVVMS1JzVTRTbnMyK1dYSzVQR3pDN1lvVW1LbmdaYmowTzI5NTJD?=
 =?utf-8?B?T3lCeXdIN1VtNmFHcUVHaVB5SXAzVmpnTmRmTzN3VlFoaEpuRzlCbGY0NlJ4?=
 =?utf-8?B?bERRRUNXZUQ4RGN4ak5Hb2lJWDU0K0FRMmlRVmloUGxGSmhBK2ptUWNZbDMr?=
 =?utf-8?B?U0dhSzR2bjNJNThPV0I2b0JzWDhmRUVLZ1ExMEFKekVPZHZuQmtaSDBOenlU?=
 =?utf-8?B?OUZ6UkdFdU5EbFlJWkRNaEFMOWY0aDNwYmhUMVZxWWVLRGtXSW9qc0d3U1Nu?=
 =?utf-8?B?bFZUNGlLekZ2UmtUTG90ZHZWb0hmRDNDOEZuR0hpMFpNeHhEUnZEOWxIbnlw?=
 =?utf-8?B?aGgrc1drRDRNTndEYjdnN2pnckF2K3lmbkhNT3gwZTE4MkpGRmdmMkh3Ymcr?=
 =?utf-8?B?c1J5Q1pKY3J3cTlUMTltSTJrQWJKdERYNnBYYy9sUFgzcHA3VkhLOFFSUWk3?=
 =?utf-8?B?QW9JOVJLa1Z6b2JHeWd3ZDhBanBoYS95VmI2Vk5VSUlIazVGZzVzK1RWNmdT?=
 =?utf-8?B?T3FPMk5PKzJqekl5SFNYYVkwR0xTeEhHemNsNzUzcXdtWE1rL0dKU0U0K0JJ?=
 =?utf-8?B?cDYwOWlLdVFZM3dMT0tIcVV6QVFoeTZ0M0s4Sk1oVjRzWnVjR3dEMmdiL2hw?=
 =?utf-8?B?YnFUWmREWS9Xc0NWWmt4Y0xnZXMxbHN4TTRlUkQ2ZEdoZHZhUURzNDVKYzJN?=
 =?utf-8?B?YzZ2cCtkSmJyQ1dzY2RhUXBhU3dESXdaUDNjZGswc1RtM3VxcVRxNkNjVDM5?=
 =?utf-8?B?M3lTaFNEdU5SdmQ1TEwzZ2QxQ3ZtWWNXRlFZSTV2bVg4cUVDbUU1WmhOK0hi?=
 =?utf-8?B?YVRuQXpENWxLRHFCVzI5NGZVQWxscGhXUFJQM0V2Yllac0t0U1hKUjRZdm95?=
 =?utf-8?B?SWFSMlB4Qy8xZGhiQVgxcHUrUVFTalU5R0tBUzBjYzlYTnNCNkVmeXFGZkFa?=
 =?utf-8?B?b0hYajFTVmZIdC9WZlk5SmcvVDhwcG9QVmRuNlR4dEVMUlREWmU1YThHa1pn?=
 =?utf-8?B?NUM1dm1BRjB3c3BwOHU3RHcwN2Jnd0xQNStKaEhaRmN3Y3BLV1FReVZ3R0Jl?=
 =?utf-8?B?cTFsUTNZb0NtRjZWMWZOV0JxQzY4bWc0cllxaTE1QmREQ3JranlTUTZnMHoy?=
 =?utf-8?B?R0E1MDdlQjdSb2dXbGpqblhHVVJuV05YQmwzTFFFdEJmWTJnRWlleHNkTDh6?=
 =?utf-8?B?M3VobVdQQloyVk0xNVFmZVJZTk8veWZvem0vTS92MDhYU3lEQlpHaVFRTTND?=
 =?utf-8?Q?NfAj+MS7onYZDkfpDlaKfd6byU0jfBn0?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDNVQnZ0ZVg0S2MwcENaT2JNc3RTOXFpVFBtdG9YM1dVMXRZOHc2L2ZVQS9Z?=
 =?utf-8?B?Ym1IT3pCOTR5YmdxeURlK2U2UW5jRitla25weWhIcEVxZkV4S1pvNVBraGdZ?=
 =?utf-8?B?Q2Evdk9Jb2N5SzdOb3Fqd05MMnZjTFlEWE1CNExmOExheHNEcUxlMUxxdmRi?=
 =?utf-8?B?RFg1K1F1YkFmQTBmYjZUVXVxcko3ZC9RWTU4bXFuRng5Q21DZVRnemVMQUhs?=
 =?utf-8?B?ZmZ0WXFySEt1dzZEanpHV0x2bGZJVkhVaEszV1h5b2dVSFk4cTR5RkJPc2Fr?=
 =?utf-8?B?STc3VFZmdm4rU1diNmxxVEw2Y0REeUVCQ2QzZWwyT09yM2RwKzlNVTFwWHk5?=
 =?utf-8?B?OTkybVJFbDZMVXo0M1VjSXNTQ3NCWERUbCt2bjE4a2k1QWtaYTZxeCs0MGdI?=
 =?utf-8?B?aHpVVmdDRG91ZjRsTk94WFBMd2hTVGhpdWdQb0N3THBTN0ZndkdPVzdTNEpW?=
 =?utf-8?B?RXFVS2RRV1lCQTl4WUFxUHR6clBtSWtvRW13dExlaDF6K2JIWmd3dTg4QnY4?=
 =?utf-8?B?MXVReTBrUTdTSVJnRUkxZ1RNNXRXZXVqQTBqQnFzczBaUG5CUW1yaFV5cGk1?=
 =?utf-8?B?cDhXTnpxZWQ2a2pUNGc4MXRHVmJMWDB6TUtHdk9qYXBqcU8rQjQ5bFpiakdO?=
 =?utf-8?B?QmJ5UEpqazdQWmQwWDY5ckFBNEk5aDVtQ2ZMTFlVZ0tHOVgyMitGa1BVR053?=
 =?utf-8?B?cU01N25rZndBYWU1bmNEYzhzemFweEJEakx5TndaTlZPa0RSVzFEa2pjTE5j?=
 =?utf-8?B?TURXd2Q5SkxYemIzMDJ4WUpjV0FQcmZPY3ZpQlNjc2pMNy82UU1rZFBxNFdK?=
 =?utf-8?B?UUJGQkM2SDc5eVI4QzQ2ZHl0TEw1bEkwUmZpVkJNV3ZiMzlhekpQcWRyUmNX?=
 =?utf-8?B?Sm1yMlk2UjV0M2huaUhRTk5qai9mV2VvV2pZbjZQY1hUTUZ4dDhYT3I5Zldt?=
 =?utf-8?B?d1F4WG5ETmY2QXg4dnBOMmJzUEFmcDd4UWZDVmtkVG03OFpoMzBRNWRyZHNN?=
 =?utf-8?B?VnJtTFhZNWNvVWhUT084NUg1WHpjdGVjSy9VQmR6Z0IvMjd4MEFnOGp0enhN?=
 =?utf-8?B?VmFlQWdoa0tvSll5M1BIZEF0YlE3bVMvUW53Rk9STEs3OVphRkUwRWZxcWNh?=
 =?utf-8?B?eEhPMnAvYlpMZnNKVFhndlA1cThVNWoya09GcldCVmNLc1pDN2tPc1FBMkdt?=
 =?utf-8?B?WTNyVCtxbTNvb2dVRXR4bFg4NEhDcGtvZzRwNHVpRVU3MDhVK0RiU0RIZ1A5?=
 =?utf-8?B?aVJIb2prUFRCZHJsbzhxSlVkbWFVNjJDR2RGYlcwbWF4UHRJMTlDWmwxaUV2?=
 =?utf-8?B?M21IQmZRSkVJR3lrWVpqTEhPOC8xR1FYUzU4Z1NtbFhqM0s5TlVWdTJ4OVBP?=
 =?utf-8?B?Z2s5ZWNGT3I0dWtuQzcvZWh6aGVsOXE2Wm5QeW9xRzk4RWdoS212d1pqODdz?=
 =?utf-8?B?bG80NEVBdVRJb1owRW5RcjI4cUdTaXp4cjAvQTR6Q3I2VXZNWSs3SVN2ZUIy?=
 =?utf-8?B?VzVNQ1ZiZDk4cVhwUEdlbHk5OVphYjhVY09kUjlNVTV2Nmh6MnBWdlA3WVY5?=
 =?utf-8?B?YWc2d3JCSWZCN0JsdDArVm5KMFhpVlRvb3NrL2lSeit2d1E5YmxqSW5PWStK?=
 =?utf-8?B?U3RoanJWVVVjMU1OMUNXaUdGSm96Qm9FeDgyWTBZczh1Tm14OTJjMkNoMlhW?=
 =?utf-8?B?dDEreTdvWFg3dXJ6cXVpckwvUUVsZlBXWENwVGtISE4xUzdEQVhaTWxJTUdT?=
 =?utf-8?B?L1NTYkNKNCs3Z2F2cFNXcHFhWEJ3TktMUkUraUlha05KamI5aWk5NS9PbVlx?=
 =?utf-8?B?cWlwMHluVU9ZNGQ1RWJKc0hlUzJXOHdyNzRSMjlhcW5vTnFPcitSZXdQbTVh?=
 =?utf-8?B?alR6Ykxuc1lPdXZjVzJMYVgwTFBydnM1dU5ZMXo5cmNwTngrS09vbFVZbEI1?=
 =?utf-8?B?TnRBNFlxbWt3dytaRHpnV2dtR2NOam51bWlSRGVUZk5UWFc4bVlhU1FZa1Fj?=
 =?utf-8?B?cm1mWHdkcEdZbTdoOXZwVVR0REk1MUQ5QUsrMnpoczFRYXJQMHRFRUlLbjFs?=
 =?utf-8?B?NGxqRklFOTVRQWF4U0RtWkllUFQxbjBKL29UTlpTUEFscHhPcVAvdi80a2hk?=
 =?utf-8?B?NUlSZzJHenVzelluV0k1QStub2duNGxPM0U1WlpjRm12S0c4dTVIRi9WMTl1?=
 =?utf-8?Q?DP1XDEs4SdIYKHS2bk/ZvlQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8185665C978CD2439413B44D883196D0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dbe0efe-953d-4149-9311-08dd340d4d0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2025 20:03:08.7989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hAjVQrI7oSLovE0oCpxQCfjo3mfiH4tRBdP8m4cASXqUzTPl+gYoRJx5ghZHHntgeKpXDi6TfRdwO0AbOYr+l2uujiDBJasCf3TQdsy2DGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7455
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTAxLTEzIGF0IDE0OjQ5IC0wNTAwLCBNYXJrIFBlYXJzb24gd3JvdGU6DQo+
IE5vdGUgLSBzd2l0Y2hlZCB0byBteSBvcGVuLXNvdXJjZSBmcmllbmRseSBlbWFpbCBhY2NvdW50
IChhdm9pZCB0aGUNCj4gTGVub3ZvIGFkZHJlc3MsIGVzcGVjaWFsbHkgZm9yIG1haWxpbmcgbGlz
dHMsIGl0J3MgT3V0bG9vayBiYXNlZCBhbmQNCj4gY2FuJ3QgY29wZSkuDQo+IA0KPiBPbiBNb24s
IEphbiAxMywgMjAyNSwgYXQgMjoxOSBQTSwgTWFyayBQZWFyc29uIHdyb3RlOg0KPiA+IFN1Ympl
Y3Q6IFtFeHRlcm5hbF0gUmU6IFtQQVRDSCB2Ml0gaWlvOiBoaWQtc2Vuc29yLXByb3g6IFNwbGl0
IA0KPiA+IGRpZmZlcmVuY2UgZnJvbSBtdWx0aXBsZSBjaGFubmVscw0KPiA+IA0KPiA+IE9uIFNh
dCwgMjAyNS0wMS0xMSBhdCAxMDoxNyArMDEwMCwgUmljYXJkbyBSaWJhbGRhIHdyb3RlOg0KPiA+
ID4gSGkgSm9uYXRoYW4NCj4gPiA+IA0KPiA+ID4gSGFwcHkgbmV3IHllYXIhDQo+ID4gPiANCj4g
PiA+IEZyaWVuZGx5IHBpbmcgYWJvdXQgdGhpcyBwYXRjaCBzbyB3ZSBjYW4gY2hhbmdlIHRoZSBB
QkkgYmVmb3JlDQo+ID4gPiB0aGUNCj4gPiA+IGtlcm5lbCByZWxlYXNlIGhhcHBlbnMNCj4gPiA+
IA0KPiA+ID4gT24gVGh1LCAxOSBEZWMgMjAyNCBhdCAxODoxNywgSm9uYXRoYW4gQ2FtZXJvbiA8
amljMjNAa2VybmVsLm9yZz4NCj4gPiA+IHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gT24gTW9u
LCAxNiBEZWMgMjAyNCAxMDowNTo1MyArMDAwMA0KPiA+ID4gPiBSaWNhcmRvIFJpYmFsZGEgPHJp
YmFsZGFAY2hyb21pdW0ub3JnPiB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+ID4gV2hlbiB0aGUg
ZHJpdmVyIHdhcyBvcmlnaW5hbGx5IGNyZWF0ZWQsIGl0IHdhcyBkZWNpZGVkIHRoYXQNCj4gPiA+
ID4gPiBzYW1wbGluZ19mcmVxdWVuY3kgYW5kIGh5c3RlcmVzaXMgd291bGQgYmUgc2hhcmVkX3Bl
cl90eXBlDQo+ID4gPiA+ID4gaW5zdGVhZA0KPiA+ID4gPiA+IG9mIHNoYXJlZF9ieV9hbGwgKGV2
ZW4gdGhvdWdoIGl0IGlzIGludGVybmFsbHkgc2hhcmVkIGJ5DQo+ID4gPiA+ID4gYWxsKS4NCj4g
PiA+ID4gPiBFZzoNCj4gPiA+ID4gPiBpbl9wcm94aW1pdHlfcmF3DQo+ID4gPiA+ID4gaW5fcHJv
eGltaXR5X3NhbXBsaW5nX2ZyZXF1ZW5jeQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFdoZW4gd2Ug
aW50cm9kdWNlZCBzdXBwb3J0IGZvciBtb3JlIGNoYW5uZWxzLCB3ZSBjb250aW51ZWQNCj4gPiA+
ID4gPiB3aXRoDQo+ID4gPiA+ID4gc2hhcmVkX2J5X3R5cGUgd2hpY2guIEVnOg0KPiA+ID4gPiA+
IGluX3Byb3hpbWl0eTBfcmF3DQo+ID4gPiA+ID4gaW5fcHJveGltaXR5MV9yYXcNCj4gPiA+ID4g
PiBpbl9wcm94aW1pdHlfc2FtcGxpbmdfZnJlcXVlbmN5DQo+ID4gPiA+ID4gaW5fYXR0ZW50aW9u
X3Jhdw0KPiA+ID4gPiA+IGluX2F0dGVudGlvbl9zYW1wbGluZ19mcmVxdWVuY3kNCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiBJZGVhbGx5IHdlIHNob3VsZCBjaGFuZ2UgdG8gc2hhcmVkX2J5X2FsbCwg
YnV0IGl0IGlzIG5vdCBhbg0KPiA+ID4gPiA+IG9wdGlvbiwNCj4gPiA+ID4gPiBiZWNhdXNlIHRo
ZSBjdXJyZW50IG5hbWluZyBoYXMgYmVlbiBhIHN0YWJsaXNoZWQgQUJJIGJ5IG5vdy4NCj4gPiA+
ID4gPiBMdWNraWx5IHdlDQo+ID4gPiA+ID4gY2FuIHVzZSBzZXBhcmF0ZSBpbnN0ZWFkLiBUaGF0
IHdpbGwgYmUgbW9yZSBjb25zaXN0ZW50Og0KPiA+ID4gPiA+IGluX3Byb3hpbWl0eTBfcmF3DQo+
ID4gPiA+ID4gaW5fcHJveGltaXR5MF9zYW1wbGluZ19mcmVxdWVuY3kNCj4gPiA+ID4gPiBpbl9w
cm94aW1pdHkxX3Jhdw0KPiA+ID4gPiA+IGluX3Byb3hpbWl0eTFfc2FtcGxpbmdfZnJlcXVlbmN5
DQo+ID4gPiA+ID4gaW5fYXR0ZW50aW9uX3Jhdw0KPiA+ID4gPiA+IGluX2F0dGVudGlvbl9zYW1w
bGluZ19mcmVxdWVuY3kNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBGaXhlczogNTk2ZWY1Y2Y2NTRi
ICgiaWlvOiBoaWQtc2Vuc29yLXByb3g6IEFkZCBzdXBwb3J0IGZvcg0KPiA+ID4gPiA+IG1vcmUN
Cj4gPiA+ID4gPiBjaGFubmVscyIpDQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUmljYXJkbyBS
aWJhbGRhIDxyaWJhbGRhQGNocm9taXVtLm9yZz4NCj4gPiA+ID4gDQo+ID4gPiA+IEkgZ290IGxv
c3Qgc29tZXdoZXJlIGluIHRoZSBkaXNjdXNzaW9uLsKgIFRoaXMgaXMgc3RpbGwgYW4gQUJJDQo+
ID4gPiA+IGNoYW5nZSBjb21wYXJlZA0KPiA+ID4gPiB0byBvcmlnaW5hbCBpbnRlcmZhY2UgYXQg
dGhlIHRvcCAod2hpY2ggaXMgdGhlIG9uZSB0aGF0IGhhcw0KPiA+ID4gPiBiZWVuDQo+ID4gPiA+
IHRoZXJlDQo+ID4gPiA+IHF1aXRlIHNvbWUgdGltZSkuDQo+ID4gPiA+IA0KPiA+ID4gPiBIb3dl
dmVyIHdlIGFscmVhZHkgaGFkIHRvIG1ha2Ugb25lIG9mIHRob3NlIHRvIGFkZCB0aGUgaW5kZXgN
Cj4gPiA+ID4gdGhhdA0KPiA+ID4gPiB3YXNuJ3QgdGhlcmUNCj4gPiA+ID4gZm9yIF9yYXcuIChJ
J2QgbWlzc2VkIHRoYXQgaW4gZWFybGllciBkaXNjdXNzaW9uIC0gdGhhbmtzIGZvcg0KPiA+ID4g
PiBsYXlpbmcgb3V0IHRoZQ0KPiA+ID4gPiBzdGVwcyBoZXJlISkNCj4gPiANCj4gPiBEaWRuJ3Qg
cmVhbGl6ZSB0aGlzLiBJIGRvbid0IHNlZSBwcm94aW1pdHkgc2Vuc29yIHVzZSBpbiB0aGUNCj4g
PiBtYWlubGluZQ0KPiA+IExpbnV4IGRpc3RybyB1c2VyIHNwYWNlLCBzbyBpdCB3aWxsIGFmZmVj
dCBvbmx5IHNvbWUgcHJpdmF0ZSB1c2VyDQo+ID4gc3BhY2UNCj4gPiBwcm9ncmFtcy4NCj4gPiBB
ZGRpbmcgTWFyayB0byBzZWUgaWYgaXQgYWZmZWN0cyBMZW5vdm8gU2Vuc2luZyBzb2x1dGlvbiBh
cyB0aGVyZQ0KPiA+IHdhcw0KPiA+IHNwZWNpZmljIGN1c3RvbSBzZW5zb3IgYWRkZWQgdG8gdGhp
cyBkcml2ZXIgZm9yIExlbm92by4NCj4gPiANCj4gDQo+IENhbiBJIGdldCBzb21lIHBvaW50ZXJz
IHRvIHdoYXQgc2Vuc29yIHRoYXQgaXMgcGxlYXNlPw0KPiBXZSd2ZSBiZWVuIGFza2luZyBmb3Ig
dGhlIEhJRCBzdXBwb3J0IGRyaXZlcnMsIGJ1dCBpdCBpc24ndCBhdmFpbGFibGUNCj4geWV0IHRv
IG15IGtub3dsZWRnZS4gV291bGQgdGhlIE1JUEkgY2FtZXJhIHdvcmsgdGllIGludG8gdGhpcz8N
Ck5vLg0KDQo+IA0KPiBJZiBJIGNhbiBnZXQgZGV0YWlscyBvbiB3aGF0IHRoZSBzZW5zb3IgaXMg
SSdsbCBnbyBhbmQgY2hlY2sgd2hhdCBpcw0KPiBpbXBhY3RlZC4NCj4gDQpUaGlzIGlzIGEgY3Vz
dG9tIHNlbnNvciBleHBvcnRlZCB2aWEgSW50ZWwgSVNIDQoNCiAvKg0KICAgICAgICAgKiBMZW5v
dm8gSW50ZWxsaWdlbnQgU2Vuc2luZyBTb2x1dGlvbiAoTElTUykNCiAgICAgICAgICovDQoNCg0K
ICAgICAgIHsgICAgICAgLyogaHVtYW4gcHJlc2VuY2UgKi8NCiAgICAgICAgICAgICAgICAudGFn
ID0gIkxJU1MiLA0KICAgICAgICAgICAgICAgIC5sdWlkID0gIjAyMjYwMDAxNzFBQzAwODEiLA0K
ICAgICAgICAgICAgICAgIC5tb2RlbCA9ICJWTDUzTDFfSE9EIFNlbnNvciIsDQogICAgICAgICAg
ICAgICAgLm1hbnVmYWN0dXJlciA9ICJTVF9NSUNSTyIsDQogICAgICAgICAgICAgICAgLmNoZWNr
X2RtaSA9IHRydWUsDQogICAgICAgICAgICAgICAgLmRtaS5tYXRjaGVzID0gew0KICAgICAgICAg
ICAgICAgICAgICAgICAgRE1JX01BVENIKERNSV9TWVNfVkVORE9SLCAiTEVOT1ZPIiksDQogICAg
ICAgICAgICAgICAgfQ0KICAgICAgICB9LA0KDQpRdWVzdGlvbiBpcyB3aGF0IExlbm92byB1c2Vy
IHNwYWNlIGlzIHVzaW5nIHRoaXMgc2Vuc29yPw0KDQpUaGFua3MsDQpTcmluaXZhcw0KDQo+IFRo
YW5rcw0KPiBNYXJrDQoNCg==

