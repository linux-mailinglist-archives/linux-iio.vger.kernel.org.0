Return-Path: <linux-iio+bounces-17000-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C78A7A6644F
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 01:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D837E18980FA
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 00:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B4380BEC;
	Tue, 18 Mar 2025 00:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VkK0OIJc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C272840849;
	Tue, 18 Mar 2025 00:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742259422; cv=fail; b=YZ/AHphJFkhEaMIvZArmdPhTl5CRwtEosQnFjJER6fjl75fG2sTBhUCIzQfa+DtKUWsysuGhjr7rjbwpbpncam4mpn4dfybESUX4Baa4Wv9hReKlU8FKyZkbClIY3Z/tYqmCJ4GinSbQVKUwDQpueRSG4cOD9xrTKppLUorL1ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742259422; c=relaxed/simple;
	bh=KZQVil6TxStZqgbIxSVUlBi1TytDBxQ3Oxu4bFVVhgE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wkm581qmoWc3QZ347VplesKmpyvujDgHtaHoRUjojVA0cdKJzp/mAMwsoGSCZl+zQVyN9B/8pi1Qtv8VmQwqsLA7di7ceEAoNiF61cfXQ6jJikwSO2ZGRerV2pktIdg6bFHRs4VnowHFe23sxQbZJRzm2rrXhlce08yujRwKAtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VkK0OIJc; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742259421; x=1773795421;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KZQVil6TxStZqgbIxSVUlBi1TytDBxQ3Oxu4bFVVhgE=;
  b=VkK0OIJcUV8L1pImoAfRKnGyxX+WBkHTeHgtFsXvH5pSxCyVNwmOQRod
   i7GnjV5FlRCKOQURd/N6KkD8sT89EgxxakI8+uSGoXe7g2T4uo8PjwU50
   oL9/SpdDUATSY3sUelLsA92TAczyKmNfAtDA4gYpadxw72NjMQklnr/bU
   Mroln3SFUTDW4HaXUyHgTNDl8WnYOy7Aqd9J4EieuFjKYMuXhFCmZWUJB
   0fm8gugSRS+5VMxj13y/TZAFfFuwH35zAUnDFhLFTDJwIB4QGmtW2BpED
   +yeJA54IepnEI6u8b6Mfn5UGdPljUg34zekLf2bMCQC0l71kfqsKk4yjq
   w==;
X-CSE-ConnectionGUID: wsgq4yihQ8aSZvns2wjRHQ==
X-CSE-MsgGUID: Or7njux2SN+isbgSFQKTcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43116789"
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="43116789"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 17:57:00 -0700
X-CSE-ConnectionGUID: ehn/95ybQtO15IMu+Trj5A==
X-CSE-MsgGUID: OBclofHLSzy/Pr9w06B6PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="122589719"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 17:57:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Mar 2025 17:56:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Mar 2025 17:56:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Mar 2025 17:56:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgUScJwTX7WNPGtzEXV50FnGZ4zBKh3c6urBSeBIX7bXuL5oMl98LV9Eg2jga7YFdI9Ict5dp0l5fsReg11utzVX0J/19/+aXqVBEWjodXtx9fKibVMV/MzUG1H/3QJinUtSeY2xxaRXazMmm0batupNcoK+ITd0ykoDtEMuTNJx3bQNaEtrtX0BnkDmz1BJ79sqZqJeEZm0nvhiaXxNelFpFX+NdbQJtjOW2F9Zcb5uqkALTjjjbzPBr5VIEA0GMBQL0Cldql2H+tFMNQCqH+CG7Vdra+vb8D5LDD9GwNQvYLdFpJFqjCMimODuChHstYgSj2OUOgs47EiOehIWMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPMQeM346bKmWrJS12ze9VpwcZjxpd9NBvY/nJedp4M=;
 b=IcBtRW4oqGzfsv14eSCtWyR7rpVu6wa935V7Qbgh1sbc46TqxoJzdFH8IMDUlL2kXe4upM59HrLEYnLlfibm9wErCDqOy5r3W2SCDibfgB+KBYrt/ob6oq6dA139w9+viKRl/EsKESorz2vi+Jj74OcPfvJ8yKaI2YWvQjupALm4NALnTwy/C2vBqu5g5RGdVl+6nFuC/eh6Cuufax6iSoa1D+62+upu7qqwLWpPKLcX3hXFsvgEe6q/z6aeZD46PAhQEg7pu01xGMdqcfpJSiZAmTxPEheAJUvuDaIq6Km7O6WKCzZQ3GsJIsEcJpIr4IzAbA33PM74vfNH9ca3uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5995.namprd11.prod.outlook.com (2603:10b6:8:5e::11) by
 SA1PR11MB6893.namprd11.prod.outlook.com (2603:10b6:806:2b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 00:56:44 +0000
Received: from DM4PR11MB5995.namprd11.prod.outlook.com
 ([fe80::654c:a738:ac8:7908]) by DM4PR11MB5995.namprd11.prod.outlook.com
 ([fe80::654c:a738:ac8:7908%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 00:56:43 +0000
From: "Zhang, Lixu" <lixu.zhang@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "jikos@kernel.org" <jikos@kernel.org>,
	"srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
	"lars@metafoo.de" <lars@metafoo.de>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iio: hid-sensor-prox: Add support for 16-bit report size
Thread-Topic: [PATCH] iio: hid-sensor-prox: Add support for 16-bit report size
Thread-Index: AQHblt0VMcTFkTf3iUKhSQjxjhJ5lrN3QEgAgADSjVA=
Date: Tue, 18 Mar 2025 00:56:43 +0000
Message-ID: <DM4PR11MB5995BA99252884FFFDD7234393DE2@DM4PR11MB5995.namprd11.prod.outlook.com>
References: <20250317013634.4117399-1-lixu.zhang@intel.com>
 <20250317122044.22091c4b@jic23-huawei>
In-Reply-To: <20250317122044.22091c4b@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5995:EE_|SA1PR11MB6893:EE_
x-ms-office365-filtering-correlation-id: 3327ec7f-298f-4ee9-a340-08dd65b7bffd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?hequF0gP05WMJmyy+bMw4dTLBAzWmHWRv0LjEz6Av5/aXJZuFZkiyNhl4ZFD?=
 =?us-ascii?Q?B0JkHQHv6iYVFvvjA/jYtTFXRz5xmpJ+Be4k7V7ou5lGlqgpgXi0MwSAY6Wm?=
 =?us-ascii?Q?iuI4bGEKZO2LbjtfykG32HikQofpu5ET4OiaQUyfBukUYzE6V15O6Z/nbQ3Z?=
 =?us-ascii?Q?7TiL4tNf3Rxf7RVA8E+0AS8w4qHj/75eJvAM+c6CXgNzDPjA3GqaHza4Rowd?=
 =?us-ascii?Q?Qcm+SmxT6jDY7hJX7EidcTh0vaYYn947BtXboDzww6sAXPZGwXfW2WI9bvgs?=
 =?us-ascii?Q?VzUd8K5pIvMttP9Iv1CHuXLSAPNbtdEdD43qSDSklgY+0e45GeVmvCy7GMof?=
 =?us-ascii?Q?IQ8gEP3BuW237No85yfRv7BAJlCq+Lno/ydLgcgpTB4ESnImZzmL3KmtmhhD?=
 =?us-ascii?Q?6wgJm7KX2Fjibae0J6scMg/sq4J7VhZLtF6X31C8lo0bXnl0R0ILhxZ8jT3w?=
 =?us-ascii?Q?NcAybmtB3RT90oaIkcz8sP+LIkSwm8p/QKps9RqyWKhdybB7bF1aMBV7tMHw?=
 =?us-ascii?Q?kCjJVYu4iLJaQJh/FqVJRDbed9kVZG1PtaoEM7ngoqRD+39iYxIJY1s71Vzh?=
 =?us-ascii?Q?dgqjm51/PaHZqgV44r6zPj2OTcSnxAQsy1RZNXCFK//EguGf1YhJZJOWfkAu?=
 =?us-ascii?Q?d0KokxYbtmzQjwl3VgJ9qTu4Iw/gpv+C4lsfTNvXXJaK7DyMXk2dsN95QrSv?=
 =?us-ascii?Q?/GSKmagVQ+XdajT+ieknB616gRuLddt6uSzwVCidaTelME+HgKVkzpKy6hw+?=
 =?us-ascii?Q?sKOMEJhyuqAhmTZ8IuDDJXi1KGzFOFHvszOmwgBzXyTBHS/8A1ugBsO+3xBQ?=
 =?us-ascii?Q?FR6w6d0BTaQMqTTOxBosJK9xhn7aA0UIcKz3Ld3XLPCEiusuXc3/pmT9aqZC?=
 =?us-ascii?Q?5uOYqND/1Ownxq4DB3hu7HBUvYQlKmRJtfA8y2K1Ks6yBqRPwuQXsKoqYXZ8?=
 =?us-ascii?Q?qzM6ijY1xlZfGNzM44bOG0DsijEjXRd42LbEYAQOFN+tE/Da8Okt22tkPKo+?=
 =?us-ascii?Q?i6t/p7TmTLljaWM+efDv5GX3s/VovAhbdkqPe/nyhCBPzjteVa/eH0la8rh9?=
 =?us-ascii?Q?F6iu7cb69iaIDF5sm0flfqKnbCOrAevp24CUtXQoJ0BPywPq/d0t4KFMir+N?=
 =?us-ascii?Q?w+xE3M/bPWEkhSqbT6TG+m6pSt9XAguUU4IV3Lo3M/MCoetH/mxX5jbe0YEa?=
 =?us-ascii?Q?DnvtNBbPYe4zCYNKmH2SK5d886Ol2KiiT+8WrRqk+iCspBaZcCQrM+AWR/Jr?=
 =?us-ascii?Q?yj1iDWm7KF9weyYR37QJ6YrIcpgnCI3dyflsLvCdnIB0difW2h1lh1TEBoqt?=
 =?us-ascii?Q?GcYGviJ8xbgHaF+aN9zU4PwZqkE7NiEj5TnfpmF8t/uS6y2MXMKPh72d3z5o?=
 =?us-ascii?Q?XP1y1POCUbXAbzcjUtepnWNxSbLV0hqZEQ2H/Zb+e3W0H1/P+VKW51lY1oZz?=
 =?us-ascii?Q?awHy6k/Jy+sKRvm3+2pC9YhqmWlYv0+o?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UPk84epBRqeX1eicDLORYaNBYmLfyUI2jUkLHezXeyveFJItqM5sRGrYym/D?=
 =?us-ascii?Q?MPBehkl7YTDMFfx4NsLBzo5sQHjn7M/wFFQWdGU5wydIWJMKEsMgZWj8jsl5?=
 =?us-ascii?Q?wq6mhbvusDk/AImz4io5AA+ust8tRfEE4Gg+HL0BpW3CpSSLppfIfDzGJHTa?=
 =?us-ascii?Q?cbrXF0P4pYiUpgJ4TIfmGjc7alFgUgCpL6TF4rV5UrIfpEK9Mbk54V+T3WO7?=
 =?us-ascii?Q?GbRTT0OO24lA+gpRNa47OciA7QXgrDSdn/h+IoVpWECgA/gYg6mZq1h1pRav?=
 =?us-ascii?Q?uE++sApbdgKtn/W5aHbqibz1v87PhpzqeY8raNXO5TRLcNSiyku2Da/OPj3r?=
 =?us-ascii?Q?lnWQJT+syyk0hZpWWCZTHGcIHJdFpXoSL8QxRUjErIoEmXPt7QhiWlu6lu8d?=
 =?us-ascii?Q?1W5k5Zh6BOj+g5jnC1t625uIRngaw2KSCNKkFDGLXYzYi2W6oWGgE76NlQ3y?=
 =?us-ascii?Q?z3Pehe+IQn94KRWCwwQwlH7JOV4EyAIhpipJaq3eMNEqW0kCzhIG3B0idoyZ?=
 =?us-ascii?Q?4UFMdOmkH/UzfqQ9rSe7i9vVQn62CegonxoK2kD5oTpVCd4U5yDCortJQI6o?=
 =?us-ascii?Q?AvgFVJ/LHUax2xsVlVpnXGDr2lC0bA3y/Le6vavNLAdoMWcAlDqlfAlLwljG?=
 =?us-ascii?Q?UuD88qnXpsCCe9uW5rml7QEf4+my0C1w7xaZ7Gc/jEMBDbTrzE7xRlDk8b20?=
 =?us-ascii?Q?r2CXNoIN02fyCXBirejtwKrA+UtAZbYnaFST0y7CjMByrRtk/g9TfbzSYyah?=
 =?us-ascii?Q?bYyf8kBQOzwiVPHDiSqybfmN7kRvqwAeZ0mOd4XMh2+ruOHM6+Q8ad70ne09?=
 =?us-ascii?Q?TDPOCMNipH0hW94GGoc3KMrsL0p+tgTrgrdRl/ITLsoJONWv7bC7daxAa2/k?=
 =?us-ascii?Q?5zvEXnr4E7Uf+2YioZElrAaJyINDXuPTDsllKCkw/9odkpbdnAbQQSjajOvr?=
 =?us-ascii?Q?iPUYqp7owFJvjfdXWeT96ZjklKzYQHjHBrdFJOnoETjuRnMmO3eKL8Rfo6sb?=
 =?us-ascii?Q?Tbk+nEdYL+ZjgLjmZMjVjqNXzS3TLA+ihStZrclFuiEMof954Ka/PDtRKhlQ?=
 =?us-ascii?Q?pN3kZleAdS1mqvc0OtLf0GP7nEyPoVH7voPsaLYn2zpRK2Szh1HyjULbn0mO?=
 =?us-ascii?Q?LCyJkRZCExiGzjrfDH6Rrtbqzil5t7YbuXbDa6E04KhFJ9qwK+eeHXmquqgh?=
 =?us-ascii?Q?vJbqT2KLijuL7DTqnGjCbdv0t3eo7Q//sb+pvCO0cM3CuZd5qM2hxf3dgEPm?=
 =?us-ascii?Q?kv7qRNVLKh6DiYrZqfVKVKyBNFNM22ZYkl9OXTqLQamf3Dj7uy/elVOX5kMo?=
 =?us-ascii?Q?3p3a28AADRjsCknzBTAg5INbnXyOZElCxe9z3ELhw8Nf7nULsEvocHV0skh0?=
 =?us-ascii?Q?krB9QqgGFGaDa5tVRiVPSPej5Vk7OXJgpsL3Zpr+4lAnixBPzrGiwHaFvQJN?=
 =?us-ascii?Q?Zahy8+sCgmcfuhjfahJP0IKFa20IUoI5gL+WM6HbKk2rMrAXNrUI6Sq7NokY?=
 =?us-ascii?Q?6WigZ19b448BMeexia96QFP3KhRKt9/YFByjTGxhil9qTEznU0kbGmrgOQlz?=
 =?us-ascii?Q?pn/dGpsWwaAknBX5QBGZuOEE094kwT1CYaphK1RG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3327ec7f-298f-4ee9-a340-08dd65b7bffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 00:56:43.0357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: apxYBtRkr65qdjZl9hFgShspD3Owcve3i+Nn5fBhwO0cpjBImizPtTb9kgqHlQ0PwxIFVdVrjSR9/Z//pkN5Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6893
X-OriginatorOrg: intel.com

>-----Original Message-----
>From: Jonathan Cameron <jic23@kernel.org>
>Sent: Monday, March 17, 2025 8:21 PM
>To: Zhang, Lixu <lixu.zhang@intel.com>
>Cc: jikos@kernel.org; srinivas.pandruvada@linux.intel.com; lars@metafoo.de=
;
>linux-input@vger.kernel.org; linux-iio@vger.kernel.org; linux-
>kernel@vger.kernel.org
>Subject: Re: [PATCH] iio: hid-sensor-prox: Add support for 16-bit report s=
ize
>
>On Mon, 17 Mar 2025 09:36:34 +0800
>Zhang Lixu <lixu.zhang@intel.com> wrote:
>
>> On Intel platforms, the HID_USAGE_SENSOR_HUMAN_PROXIMITY report size
>> is 16 bits. This patch adds support for handling 16-bit report sizes
>> for the HID_USAGE_SENSOR_HUMAN_PROXIMITY usage in the HID sensor
>proximity driver.
>>
>> Previously, the driver only supported 8-bit and 32-bit report sizes.
>> With this change, the driver can now correctly process 16-bit
>> proximity data, ensuring accurate human presence detection on
>> platforms where this report size is used.
>>
>> Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>
>> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>Applied. Thanks.
>
>If it is reasonably urgent we could slip this in after rc1 as it smells a =
bit fix like.
>For now I've queued it for next cycle.

I don't think it's urgent, I'm fine with whatever. Thanks.

Lixu

>Jonathan
>
>> ---
>>  drivers/iio/light/hid-sensor-prox.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/iio/light/hid-sensor-prox.c
>> b/drivers/iio/light/hid-sensor-prox.c
>> index 76b76d12b388..3a7b48803d50 100644
>> --- a/drivers/iio/light/hid-sensor-prox.c
>> +++ b/drivers/iio/light/hid-sensor-prox.c
>> @@ -213,6 +213,9 @@ static int prox_capture_sample(struct
>hid_sensor_hub_device *hsdev,
>>  	case 1:
>>  		prox_state->human_presence[chan] =3D *(u8 *)raw_data *
>multiplier;
>>  		return 0;
>> +	case 2:
>> +		prox_state->human_presence[chan] =3D *(u16 *)raw_data *
>multiplier;
>> +		return 0;
>>  	case 4:
>>  		prox_state->human_presence[chan] =3D *(u32 *)raw_data *
>multiplier;
>>  		return 0;
>>
>> base-commit: eea255893718268e1ab852fb52f70c613d109b99


