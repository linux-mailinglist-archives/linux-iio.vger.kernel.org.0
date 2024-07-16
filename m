Return-Path: <linux-iio+bounces-7634-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCDA93257B
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 13:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D34B288220
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 11:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5AA19922A;
	Tue, 16 Jul 2024 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RH2/80vy";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BtxDrPlk"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBB81991D4;
	Tue, 16 Jul 2024 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721128834; cv=fail; b=BPxoLnK19rWrCKcr45mIC6DKBNb3w+6HDKT11QYSSXrrOhmz5nDmL6MTxWB/QIwRPWb1VtX8PK8rbXYJTQQ789lZ0SKpct4WalbBiQvIZQPuwIVR28YoDkEnJJ0OjlKDIgqNKEkr49TzBPrAgnIElXJiBVKkBVG4EmADRJthVlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721128834; c=relaxed/simple;
	bh=Kc+vxOl/zGCXpREpBdc9vGsCr83wp/YnMibGJpxD0zc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZdxCFcCKGs3V9csXz4M3HZqNL5DevXDEZ0C3AQawiah0alE94tcDa30BfUPjK/t2p546s/5JS1n9q6X25spg7jdKuGy/wW+37BFEY0D36uDY5f75/JfckhoQDjhv1j8QPlJBL30UaXNVMtFq81kXIKsSCl2dFLrrpn4khdyG3T8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RH2/80vy; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BtxDrPlk; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721128833; x=1752664833;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Kc+vxOl/zGCXpREpBdc9vGsCr83wp/YnMibGJpxD0zc=;
  b=RH2/80vy76Kq/vq5VMwhAXPCXckg4qbhHzlBqCj9a75Wg4hcIUbfUCWr
   Mhmn9a0GkOld8njFN9yp3nQKt41DYaaompL/sf6kFS8gwseJeSjPr1CrC
   hln+RGENWXEXw1FbFACjFbvKdEZxwyJhXdSciyGM1MQ2Wu0eTWX62NKh0
   riqbiiqaSB54cIgQs7GWeUP4Sp5VRtaDONvzc10D3lpsrLDzdDuyEYsSz
   2chEGE12BUBSWvg7JvYFUJ2nBaNaxIoMmRC+tPqLaqN75OTI5Tct2cCof
   O3TNdS5o89W1Hg69V7s2z9rZXpJ/idrWZhGDeQAl0aadQL0csHcNAoscc
   Q==;
X-CSE-ConnectionGUID: vdvD1pP0QuGu3Mp0ARZkNw==
X-CSE-MsgGUID: ipb55+aXSxOtdfG4I61T1g==
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="260183506"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jul 2024 04:20:27 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jul 2024 04:19:57 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Jul 2024 04:19:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QY3d+JXg28kjbAYBcjsWve7vPhaZrPUDpxwUERcCZvZhxzzAklHYTd8pxHyc01uqEmcNda3/spr4Ls9D1IOYHnEcMJJdeyzezOraGtFVCdo8ZBTIrjH5ftTjqnBD1zucvYsGpDq3cQKrfMdVGKswshPA37s2YjMfkUAo25aUdX3ji/5MhRiVXrKuplP5zyYWcn8887LHqwvN4Nv3yUeKVo5efYEX/LuG7TlOYZ3qe2LGm1leubQOFzXTZRzhkBrL0BXngkS8kS2NG75ads6op3nos3sPXSBD+OwJ9bi1SjW609ZtVaUDbaS7V3m3LPn9Fo6kBp5P729hgJHseqUUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kc+vxOl/zGCXpREpBdc9vGsCr83wp/YnMibGJpxD0zc=;
 b=u7NcCkaV9sOeRGvWc1CRhz1HTkdluAOG6r5TylaifrO6aACYUj/ksHTsgZ9LrBVb3F+I57Q1uMR263ua3ZnAEjIEWGITUlmIGAKnvUd5MRSQ1pkoaDVq9lx29lA83IxOmTydhmKgC/ALZ5XuxmX+1QGV3OPATzk8RpxMR5lT0A4JWKPuZT7YeKzftJMt7iruHUmAHVZjy/j+A3l8s6oDD1Cruo2idFzxcFjyERygVFaWCHLTh8GpZjRGJqn2aCNfcb7BwB93qL2DdnxkSmOQFYPAupmtDgSsB2CaIxE2sKp4EDLiRVps8sTzCeM5wIBWmQb8EHh6WIjLKGZaUTLBKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kc+vxOl/zGCXpREpBdc9vGsCr83wp/YnMibGJpxD0zc=;
 b=BtxDrPlkVPVV0jsNBDWH1RdT3rTIhzP6Jd0UZLXDtMhyGNzyEBhRfXVq3k3Sw5jO5UlKOu9uduouk0UUQZONQpiN5C/p86UYH3pliLZbwSinekmR65rDsVpCtw0tJBgTJd2UnwRuL3+4xLKl0hdBowFYYjuviW9utdcCLtHJquPdlITC+JCF/4hK2WfWxy+S/H8sToZxOI2e5C9sO77+ZaV0FW4APb95zjY35fSeWtT74EHaenA/sX7zema1OfJgGqdE98IqfVMsZd0NNXzSBVptlw5HDgDJj2MobrNr9ROzmuO3VTGeCq/bX1LN8m0UWXm72Sgv2l8tL8LRI36tbQ==
Received: from SN6PR11MB3167.namprd11.prod.outlook.com (2603:10b6:805:c6::10)
 by DS7PR11MB6198.namprd11.prod.outlook.com (2603:10b6:8:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 11:19:54 +0000
Received: from SN6PR11MB3167.namprd11.prod.outlook.com
 ([fe80::4863:3d2c:e708:fccf]) by SN6PR11MB3167.namprd11.prod.outlook.com
 ([fe80::4863:3d2c:e708:fccf%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 11:19:54 +0000
From: <Marius.Cristea@microchip.com>
To: <jic23@kernel.org>, <matteomartelli3@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<robh@kernel.org>, <lars@metafoo.de>, <linux-kernel@vger.kernel.org>,
	<krzk+dt@kernel.org>, <Jonathan.Cameron@Huawei.com>, <conor+dt@kernel.org>
Subject: Re: [PATCH v2 2/2] iio: adc: add support for pac1921
Thread-Topic: [PATCH v2 2/2] iio: adc: add support for pac1921
Thread-Index: AQHazjmP/m+FUirFLUmAMKoURJhChrHrYYoAgAF6owCAADDUgIABCHCAgAZrEYCABKX1AIAAIT0A
Date: Tue, 16 Jul 2024 11:19:53 +0000
Message-ID: <483de34b3a74a2981fac89a8232e3ef2448f57ef.camel@microchip.com>
References: <20240704-iio-pac1921-v2-0-0deb95a48409@gmail.com>
	 <20240704-iio-pac1921-v2-2-0deb95a48409@gmail.com>
	 <20240707160442.6bab64c9@jic23-huawei>
	 <668bec2a8b23a_6e037017@njaxe.notmuch> <20240708173439.000070b4@Huawei.com>
	 <668cf2f3ece62_1f6ba37012@njaxe.notmuch>
	 <20240713112153.3576fc2a@jic23-huawei>
	 <66963b764ac3c_706370bd@njaxe.notmuch>
In-Reply-To: <66963b764ac3c_706370bd@njaxe.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR11MB3167:EE_|DS7PR11MB6198:EE_
x-ms-office365-filtering-correlation-id: 12645586-8342-44b9-a1c0-08dca5893781
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZHRORitKbEE3SDhCMVNwdFZnODZqaklqYm4xMWU5WDFYWTNCV004UUYxcW1V?=
 =?utf-8?B?dExwaWZ4T0hJQ1UzUFVscWJBbEplcGw0Y3BGcGVWY0RsNHY4V0dHQUpISDZD?=
 =?utf-8?B?NnZoOE5WTS9MRUV0U0g4N296c2pUNW5aYlVBaGxBdEM2bUN4U2JjUFcxOHBU?=
 =?utf-8?B?VkhGeXR0VjlZS09jZDBSb3lwL241VXlSN1c2L2ZuYnFmalZuam9DMzYrNlBw?=
 =?utf-8?B?cFpSN2Y5Rk9kQTBPb0s2VTZ3VE15V1lnNS9HNVZ1V3ZnR1VraG02bm8yaUUz?=
 =?utf-8?B?c1ZlUGF0ZnZUdjdvSlNVTVZWQnpIYnZnTzBZNzMxNEFCZlFtMkJEK0VoWWFz?=
 =?utf-8?B?TnBqWFN4NFBwcjA1c3Vaa3VCQTVQcDE2cFlmZDJtMDBDT3BGY1lhMG9FN25Y?=
 =?utf-8?B?MkdkVFFHYkpwMHMrbCtJN1lQTkxTcUVQT0IzY1hsYXp1amJkL2YyM2F2RkhN?=
 =?utf-8?B?ay9DR0d3M25xVnVHalFPbytoNHlrekxjQWlaYVhJN3JvYTh5TUl1ZkplWkdL?=
 =?utf-8?B?WG0vQlhjeFNCUnRDNndFR3Fia2xMUElvMW1DL3ZONWpDVzFJSTZ6VjJqVFJz?=
 =?utf-8?B?cTZnTUFGY2lUMTNzMnIzUUswNzRSNW5EQTF4MWkxMGs4WWRFMVhkRzF6ZkNO?=
 =?utf-8?B?Vy9zUTM2ZVV6U3M3UFJ6dkluNlZMTmNjUmNiVjlwZER2c0NhNDJoMnpXdnAz?=
 =?utf-8?B?MkZucCs3UzhNbWdCQVUvUjdjckpMcHJnVGdTdWlvY2FsTURIQ3p2LzZRTFE1?=
 =?utf-8?B?akc1ZzR0L0prVzkwaExhd3REVFBIVmdEZG15YnQ1NzNWalhKUUdDMDUzRTNY?=
 =?utf-8?B?M21hSUhUWFVWWjhEZmtKMEgwQWllVXVweWd6SDFNNlZxRG5td3U3b1RtYWEy?=
 =?utf-8?B?WUMwRFRvdEhYR0IrR2ZiUk9TN2FBNzMwdGI5ZGNOTUYrU1ByY2I2Rm1oRXh3?=
 =?utf-8?B?di9PY1NQOVpFc0t3aERCb2dhOWIxeW0yMkl2YlVmV1BBODhqY2Y0clcxaW5G?=
 =?utf-8?B?Yk5Qelc4YjFldSt0dkdoNlJ0YXF4VTJQVWs2YzE2UW1zQ1dyS2ppMlk5TFRL?=
 =?utf-8?B?NWFRNXVmRG8rRnJZd1NtaFhWSG1uaDNtT2hxVGZkK3IxSDdkN3FYRzc5QnB3?=
 =?utf-8?B?VFR6NU53OFVySUtuS3RJcVBBV2x0Njk5Z0VIdGE1MHM5T3BmcWF1di9sdzNi?=
 =?utf-8?B?bWdnNk9IQXRPUWhDZExuM3g4bGtDdlRLaDFlWG53WEVoS3lWYlhiMnZ4RzhY?=
 =?utf-8?B?OTVxeVZaYy9DcFloREh6UlVZUGJqN2pwbUtuNUJhN3pTODVsak9JM0ZwU2dO?=
 =?utf-8?B?YTRCd3pFcmNiZWo3TUo1N28wa3B1YzN2YjdZSDgyaENYcEFHSU9CNVZXRXlh?=
 =?utf-8?B?eisrSWtjV2xFR2RRUC9PaFRaQjArZzR5UnYvaktBOGJlZFh2ZTVPOGhwcUk0?=
 =?utf-8?B?cHVYZlFPN2ZTV2hDMGxibzY2S21rdVpRQXIzTkdnWUFiVy9pZWhOUmc1cm5a?=
 =?utf-8?B?QzVqeUV5TnZqWUJpS3RORG1WMStnS0NORUxpOXFUaXVGaCtvd0M4bURQMEVv?=
 =?utf-8?B?YjdTdkhXS1ZxbTZUaTFwejdjUkhHNUF0NW45ZlJJTU9xRHExb1p3bmlXVUk0?=
 =?utf-8?B?UzJvYmRLaC8weEEzeVUwZmNQQkUyZWZNK3RLK3kzN20yRFYrZEVMUHZoVEw0?=
 =?utf-8?B?cU5RanJJbVg1elNIYkE5cU1mZkR5VjNyczJ5Um42R1hHNVVjWmRCU3p4UXlZ?=
 =?utf-8?B?SkhwTFZSd0Z5M1lPM1FacDVFdmpaS3pnU0llQ2krTkpXZTZsOUwycUdwRlpp?=
 =?utf-8?B?Nm9aRkptSlV0OG1xc1AwTm84QzNCdXNjSlU2UzlVQnhsNktjYlBFR3dtNTNR?=
 =?utf-8?B?Y255MHBGMXBhM1ZMQ2RJK3dnZ2hkdzMwZVlTMUZnajU0RFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3167.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnA1Z0V1emliSmp0WE9LZ0ZybERFbDRpRVB5azRNOC9xcG5YVHVZZmE1QlIy?=
 =?utf-8?B?dWRrV291Qm1pMlBBWFdlQlp3Z1pHQUR0OGE4NnJKamhPQzVSUGRMaVIwNEFs?=
 =?utf-8?B?eFQ1aU9JMy8zQjNiRTB2bC90d0d2N2RlRk55TFk3aHBmaGdVcTJXOXdzRkYr?=
 =?utf-8?B?L2tiRzlhWVZ2THR4U0pqNU5BWXlsbjVCRmF1U3dUbmh5MkhCS1pLM3FISm51?=
 =?utf-8?B?dklOTEprbDlmUE1oVkc1YWFhSXN1N1IwdUF3dkw3SWdNTGdEaHJCV2pmd1hD?=
 =?utf-8?B?YWx6blMvS2hBN3VRQ1ZNbVVpcjdMbW15ZzVCS00vZDc3eFNqQ2VWSGRmaW5H?=
 =?utf-8?B?RUJzaVI3TGpab2R5bTNtaGlrdG0zRmFkdExqVUVGQ0owWkxuRjBjd2JJQnph?=
 =?utf-8?B?Z1dUelBHQStkc3J2Y0lLZDFDeXE5WkJMK0RIUDM3bWRlVlNubE9JVUxQVVpk?=
 =?utf-8?B?UU9pZUJNNDZGUEd3WGE4ejhEbTBlb1R0QngvUHcwV2FTVHIvdkF3TC80NCt2?=
 =?utf-8?B?ajdTdHExMExGNExyMk1CRVpvSktGMm44WTdDWndlSXR5TUVvQXZXVUtEblFQ?=
 =?utf-8?B?aFZoYzBVNVdRczhWVzlTb2dVWCtEUkNnSUkzWi9zaEFRaVpsbk1NdUE1OGFF?=
 =?utf-8?B?Zk5rQ0JSRVFiK0tvR205UkxjRUFjWGNubVBxL2NpU3VtTi9rUU8rMnJvTUxO?=
 =?utf-8?B?QVZLc3Zzb0VzYm5SS29ubmMxS1FJZ0lVVVlxNldNZGhlUXRNTE01OHEya3A1?=
 =?utf-8?B?a2VhajgxcU9GV0cwNzhLMTNBRmluemtLWVJBK2ZlNmJSQW1oVGUyRHltV29m?=
 =?utf-8?B?djYxb3RWc2IzdEI1TElLRzN4dEpNZExjMzdtZWd2ZXNTdnJSMTl3N2t6SW5I?=
 =?utf-8?B?d2VJZXUzeDl5Mm9IblIrRm1IRXB2RHVMMWUrN0Jtb3BaMmU0bzJaSzdzcmYy?=
 =?utf-8?B?RVFqNmtrbkJPblZhS3lVSGE5RnAvRkFodGFWZmxYcGlJS29pMjR3VzIrdUR3?=
 =?utf-8?B?bytHelFaQ1JhUXNrbXIvYUh4clRvbXpORnB1UFlGUTVOL0V4RExabDJDSG05?=
 =?utf-8?B?b2hnRFZwNTJsbW9LbnVTcmVzNXo0K0dQSmNlU2VVVERsZmw1Z1U4Y25RaEpo?=
 =?utf-8?B?TmxMRjJzVzBmZ1lLM0o2TEVYdjk0TzBsQ3FocVg4MzRqdFU5Z3I2OGd3Ymxq?=
 =?utf-8?B?eGxTTmRsUzF2RnlPZGlyMnNPQkc5bzBFeUIyU1FDS213YzhndjV3NTFHMWo2?=
 =?utf-8?B?Z0l6ajk0RE1yVW9rYjNMc3pmLzRXOWpFWExHK1Y2cXplcHhnSXhnY2hPcGJH?=
 =?utf-8?B?WThrbSsyQmExd3VQOU5XNjh2dmRLRFJEUkVydnZXVXBnd1FaYWlxTVNGVmRj?=
 =?utf-8?B?VklxV24zRXF6Si9ublc3cHhaWk1xL3pHT3IrTlJMckRNQTg2Y3NZZG8wN1V2?=
 =?utf-8?B?dWRyU3E0TmRPUHpUVzdybzZ2WmFLMkVXc0RwbFducTF6b2lobUh2S0FzbDMv?=
 =?utf-8?B?RzJuQXU2dW9KanpXTGcxWkdDci9lQjhieGVudXhrc2RWak04TEZxWXJXa1Ru?=
 =?utf-8?B?STFISVI2emF5VUQxaUcrV2tkc2VHdkFhMDJ5R0hNVnBuZ0kwWHB0MFdHUjhr?=
 =?utf-8?B?S0kxL2JieFQ4M3pNYTVvV1BWRGtJTFIyQ1VwTHlPQS9TMThXQVZZTkgvTzJx?=
 =?utf-8?B?R0Q2Y1hzVGp3alpNR3N5UkJwemR5dEdwcWgrMmRMcnBHZnFyeWJMZXNLbm52?=
 =?utf-8?B?OWcvR3NLSHNUWHlhZSsxNlMyWlhBcG9pNVZBd2dOK3RXL2dmZGxxeGpXZExn?=
 =?utf-8?B?SCtKcVNleDlGcVA1M3FNY0hPMnc0ZWRUVWo0OTk1OVg5R3BRSzhxaFplYXdD?=
 =?utf-8?B?aWRzZmZrb2Q4V3V6VzFySVgrdTgxWnltK1gycGJxZXI1V1RBOTFVQ2NOalQr?=
 =?utf-8?B?Zm1uN015SHJYODZDUG5WVStxSnRyS0Excy80aW0zaTBLTFRJRk1DQ2NiU3Nw?=
 =?utf-8?B?RUFqK25XSVM4aEJuMWxWcks5VDZ2OE56YlVtWnJXQTJQWWs5c3U1RXp2NUlQ?=
 =?utf-8?B?V0ZyMnEzd0NVSkFTcTJCZjNKb1pUdFVSelRyODk1ZlI0aURoU01QK3FrMmxJ?=
 =?utf-8?B?KzZBSzJLUzBkQUhzYjBVVXFyamZ2MjMrd1RxQ08wamtPRlRYSU9XK3gwZXhB?=
 =?utf-8?Q?5haYiJMQvuExXZJzszufMEQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <286B2F73466D76449B1D85556FB32AC7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3167.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12645586-8342-44b9-a1c0-08dca5893781
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 11:19:53.9830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: orFnnMvEjLwYgwdbb0/IJZmIcduqoE0EeI5gKcCWz/1obgjFAIPEPemTjobvklOJqyHo9r2kwU1Swc8buw9EKqfdHgaMhri7mUXL46CsF6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6198

SGkgTWF0dGVvLA0KDQpPbiBUdWUsIDIwMjQtMDctMTYgYXQgMTE6MjAgKzAyMDAsIE1hdHRlbyBN
YXJ0ZWxsaSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+
IA0KPiBKb25hdGhhbiBDYW1lcm9uIHdyb3RlOg0KPiA+IE9uIFR1ZSwgMDkgSnVsIDIwMjQgMTA6
MjE6MDcgKzAyMDANCj4gPiBNYXR0ZW8gTWFydGVsbGkgPG1hdHRlb21hcnRlbGxpM0BnbWFpbC5j
b20+IHdyb3RlOg0KPiA+IA0KPiA+ID4gSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gPiA+IC4u
Lg0KPiA+ID4gPiA+IEkgY291bGQgYWRkIHRoZSBzaHVudC1yZXNpc3RvciBjb250cm9scyB0byBh
bGxvdyBjYWxpYnJhdGlvbg0KPiA+ID4gPiA+IGFzIE1hcml1cw0KPiA+ID4gPiA+IHN1Z2dlc3Rl
ZCwgYnV0IHRoYXQncyBhbHNvIGEgY3VzdG9tIEFCSSwgd2hhdCBhcmUgeW91cg0KPiA+ID4gPiA+
IHRob3VnaHRzIG9uIHRoaXM/DQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlzIHdvdWxkIGFjdHVhbGx5
IGJlIGEgZ2VuZXJhbGl6YXRpb24gb2YgZXhpc3RpbmcgZGV2aWNlDQo+ID4gPiA+IHNwZWNpZmlj
IEFCSQ0KPiA+ID4gPiB0aGF0IGhhcyBiZWVuIHRocm91Z2ggcmV2aWV3IGluIHRoZSBwYXN0Lg0K
PiA+ID4gPiBTZWUgRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1idXMtaWlvLWFkYy1w
YWMxOTM0DQo+ID4gPiA+IGZvciBleGFtcGxlIChzaW1pbGFyIGluIG90aGVyIHBsYWNlcykuDQo+
ID4gPiA+IFNvIGlmIHlvdSB3YW50IHRvIGRvIHRoaXMgbW92ZSB0aGF0IEFCSSB1cCBhIGxldmVs
IHRvIGNvdmVyDQo+ID4gPiA+IG11bHRpcGxlIGRldmljZXMNCj4gPiA+ID4gKHJlbW92aW5nIHRo
ZSBlbnRyaWVzIGluIHNwZWNpZmljIGZpbGVzIGFzIHlvdSBkbyBzbykuDQo+ID4gPiA+IA0KPiA+
ID4gSSB3b3VsZCBkbyB0aGlzIGluIGEgc2VwYXJhdGUgY29tbWl0LCB3b3VsZCB5b3UgcHJlZmVy
IGl0IGluIHRoaXMNCj4gPiA+IHNhbWUgcGF0Y2gNCj4gPiA+IHNldCBvciBpbiBhbm90aGVyIHNl
cGFyYXRlIHBhdGNoPw0KPiA+IA0KPiA+IFNlcGFyYXRlIGNvbW1pdCBpbiB0aGlzIHNlcmllcyBh
cyBvdGhlcndpc2UgaXQncyBub3Qgb2J2aW91cyB3aHkgd2UNCj4gPiBhcmUNCj4gPiBkb2luZyBp
dC4gSW4gdGhlb3J5IHNob3VsZCBiZSBiZWZvcmUgdGhpcyBwYXRjaCBhcyB0aGVuIHdoYXQgeW91
DQo+ID4gdXNlIGhlcmUNCj4gPiBpcyBhbHJlYWR5IGRvY3VtZW50ZWQsIGJ1dCBJIGRvbid0IGNh
cmUgdGhhdCBtdWNoIG9uIHRoZSBvcmRlci4NCj4gPiANCj4gSnVzdCBhIGZldyBtb3JlIHF1ZXN0
aW9ucyBhYm91dCB0aGlzIHBvaW50Lg0KPiANCj4gKiBJIHNlZSAzIG90aGVyIGRyaXZlcnMgZXhw
b3NpbmcgdGhlIHNodW50IHJlc2lzdG9yIGF0dHJpYnV0ZToNCj4gaW5hMnh4LCBtYXg5NjExDQo+
IGFuZCBwYWMxOTM0LiBXaGlsZSB0aGUgdW5pdCBmb3IgZmlyc3QgdHdvIGlzIGluIE9obXMsIGZv
ciB0aGUgbGF0dGVyDQo+IGl0J3MgaW4NCj4gbWljcm8tT2htcy4gV2hhdCBzaG91bGQgYmUgdGhl
IHVuaXQgZm9yIHRoZSBnZW5lcmFsaXplZCBBQkk/IEkgd291bGQNCj4gZ3Vlc3MgT2htcw0KDQpG
b3IgbWVhc3VyaW5nIGN1cnJlbnQgdGhlIHVzdWFsICJzY2FsZSIgaXMgcGFydCBvZiBtaWxpT2ht
cyBpbiBvcmRlciB0bw0KcmVkdWNlIHRoZSBwb3dlciBkaXNzaXBhdGlvbi4gQXMgYSBydWxlIG9m
IHRodW1iIDAuMSBtaWxpT2htcyBpcyBhDQp1c3VhbCB2YWx1ZSBmb3Igc2h1bnQgcmVzaXN0b3Jz
LiBJIHRoaW5rIHRoZSAiY29ycmVjdCIgd2F5IGlzIHRvIHNldHVwDQp0aGUgIHZhbHVlIGluIHN1
YiB1bml0cyBvZiBPaG1zLiBMaWtlIHRoZSBjdXJyZW50IGlzIGluIG1pbGlBbXBzIGFuZA0KdGhl
IHZvbHRhZ2UgaXMgaW4gbWlsaVZvbHRzLg0KDQoNCj4gYXMgL3N5cy9idXMvaWlvL2RldmljZXMv
aWlvOmRldmljZVgvaW5fcmVzaXN0YW5jZV9yYXcuDQo+IA0KPiAqIElmIGZvciBpbnN0YW5jZSB0
aGUgZ2VuZXJhbGl6ZWQgQUJJIHVuaXQgaXMgZ29pbmcgdG8gYmUgT2htcywNCj4gc2hvdWxkIEkg
c3RpbGwNCj4gcmVtb3ZlIHRoZSBlbnRyeSBmcm9tIHRoZSBwYWMxOTM0IGV2ZW4gdGhvdWdoIGl0
IHdvdWxkIG5vdCBiZSBmdWxseQ0KPiBjb21wbGlhbnQNCj4gd2l0aCB0aGUgZ2VuZXJhbGl6ZWQg
QUJJPw0KPiANCj4gKiBUbyBjb3ZlciB0aGUgY3VycmVudCBleHBvc2VkIGF0dHJpYnV0ZXMsIHRo
ZSAiV2hhdCIgZmllbGRzIHdvdWxkDQo+IGxvb2sgbGlrZToNCj4gZnJvbSBtYXg5NjExOg0KPiBX
aGF0OsKgwqDCoMKgwqDCoMKgwqAgL3N5cy8uLi4vaWlvOmRldmljZVgvaW5fY3VycmVudF9zaHVu
dF9yZXNpc3Rvcg0KPiBXaGF0OsKgwqDCoMKgwqDCoMKgwqAgL3N5cy8uLi4vaWlvOmRldmljZVgv
aW5fcG93ZXJfc2h1bnRfcmVzaXN0b3INCj4gZnJvbSBpbmEyeHg6DQo+IFdoYXQ6wqDCoMKgwqDC
oMKgwqDCoCAvc3lzLy4uLi9paW86ZGV2aWNlWC9pbl9zaHVudF9yZXNpc3Rvcg0KPiBmcm9tIHBh
YzE5MzQ6DQo+IFdoYXQ6wqDCoMKgwqDCoMKgwqDCoCAvc3lzLy4uLi9paW86ZGV2aWNlWC9pbl9z
aHVudF9yZXNpc3RvclkNCj4gRG9lcyB0aGlzIGxvb2sgY29ycmVjdD8gSSB0aGluayB0aGF0IGZv
ciB0aGUgZmlyc3QgdHdvIGRyaXZlcnMgdGhlDQo+IHNodW50X3Jlc2lzdG9yIGNhbiBiZSBjb25z
aWRlcmVkIGFzIGEgY2hhbm5lbCBpbmZvIHByb3BlcnR5LCBzaGFyZWQNCj4gYnkgdHlwZSBmb3IN
Cj4gbWF4OTYxMSBjYXNlIGFuZCBzaGFyZWQgYnkgZGlyZWN0aW9uIGZvciBpbmEyeHggY2FzZSAo
bWF5YmUgYmV0dGVyIHRvDQo+IHJlbW92ZQ0KPiAiaW5fIiBmcm9tIHRoZSBXaGF0IGZpZWxkIGlm
IHRoZSB0eXBlIGlzIG5vdCBzcGVjaWZpZWQ/KS4NCj4gV2hhdCBzZWVtcyBvZGQgdG8gbWUgaXMg
dGhlIHBhYzE5MzQgY2FzZSwgc2luY2UgaXQgZG9lc24ndCBmaXQgaW4gdGhlDQo+IGZvcm1hdA0K
PiA8dHlwZT5bWV9dc2h1bnRfcmVzaXN0b3IgcmVmZXJyZWQgaW4gbWFueSBvdGhlciBhdHRyaWJ1
dGVzICh3aGVyZSBJDQo+IGFzc3VtZQ0KPiA8dHlwZT4gaXMgYWN0dWFsbHkgW2Rpcl9dW3R5cGVf
XT8pLg0KPiBEb2Vzbid0IGl0IGxvb2sgbGlrZSBwYWMxOTM0IGlzIGV4cG9zaW5nIGFkZGl0aW9u
YWwgaW5wdXQgY2hhbm5lbHMsDQo+IHRoYXQgYXJlDQo+IGFsc28gd3JpdGVhYmxlPyBNYXliZSBz
dWNoIGNhc2Ugd291bGQgbW9yZSBjbGVhciBpZiB0aGUgc2h1bnQNCj4gcmVzaXN0b3Igd291bGQg
YmUNCj4gYW4gaW5mbyBwcm9wZXJ0eSBvZiBzcGVjaWZpYyBjaGFubmVscz8gRm9yIGV4YW1wbGU6
DQo+IGluX2N1cnJlbnRZX3NodW50X3Jlc2lzdG9yLA0KPiBpbl9wb3dlcllfc2h1bnRfcmVzaXN0
b3IgYW5kIGluX2VuZ2VyZ3lZX3NodW50X3Jlc2l0b3IuDQo+IA0KDQpJIGRvbid0IHRoaW5rIGl0
IHdpbGwgYmUgYSBnb29kIGlkZWEgdG8gZHVwbGljYXRlIHRoZSBzYW1lIGluZm9ybWF0aW9uDQpp
bnRvIG11bHRpcGxlIGF0dHJpYnV0ZXMgbGlrZTogaW5fY3VycmVudFlfc2h1bnRfcmVzaXN0b3Is
DQppbl9wb3dlcllfc2h1bnRfcmVzaXN0b3IgYW5kIGluX2VuZ2VyZ3lZX3NodW50X3Jlc2l0b3Iu
DQoNClRoZSBwYWMxOTM0IGRldmljZSBjb3VsZCBiZSB2aWV3ZWQgbGlrZSA0IGRldmljZXMgdGhh
dCBoYXZlIG9ubHkgb25lDQptZWFzdXJlbWVudCBoYXJkd2FyZS4gQ2hhbmdpbmcgdGhlIHNodW50
IGZvciBhIGhhcmR3YXJlIGNoYW5uZWwgd2lsbA0KaW1wYWN0IG11bHRpcGxlIHNvZnR3YXJlIG1l
YXN1cmVtZW50cyBmb3IgdGhhdCBwYXJ0aWN1bGFyIGNoYW5uZWwuDQoNCkZvciBleGFtcGxlICJz
YW1wbGluZ19mcmVxdWVuY3kiIGlzIG9ubHkgb25lIHByb3BlcnR5IHBlciBkZXZpY2UgYW5kDQpu
b3Qgb25lIHByb3BlcnR5IHBlciBjaGFubmVsLg0KDQpBbHNvIEknbSBub3QgZmVsbGluZyBjb21m
b3J0YWJsZSB0byByZW1vdmUgdGhlIFtkaXJfXSBmcm9tIHRoZSBuYW1lLA0KYmVjYXVzZSB0aGlz
IHZhbHVlIGlzIGRlcGVuZGVudCBvZiB0aGUgaGFyZHdhcmUgYW5kIHdlIGNhbid0IGhhdmUgYQ0K
ImF2YWlsYWJsZSIgcHJvcGVydGllcyBmb3IgaXQuDQoNCg0KDQo+ICogSSB3b3VsZCBnbyBmb3Ig
YSBzaW1wbGUgYW5kIGdlbmVyaWMgZGVzY3JpcHRpb24gc3VjaCBhczoNCj4gIlRoZSB2YWx1ZSBv
ZiBjdXJyZW50IHNlbnNlIHJlc2lzdG9yIGluIE9obXMuIiBsaWtlIGl0IGlzIGluDQo+IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9od21vbi9od21vbi1jb21tb24ueWFtbC4gU2hv
dWxkIGl0DQo+IGluY2x1ZGUNCj4gYW55IGFkZGl0aW9uYWwgZGV0YWlsPw0KPiANCj4gKiBJIGFt
IGFzc3VtaW5nIHRoZSBnZW5lcmFsaXplZCBBUEkgd291bGQgaGF2ZSBEYXRlIGFuZCBLZXJuZWxW
ZXJzaW9uDQo+IG9mDQo+IHRvZGF5IGV2ZW4gdGhvdWdoIHRoZSBvcmlnaW5hbCBhdHRyaWJ1dGVz
IGFyZSBvbGRlci4NCj4gDQo+ICogU2hvdWxkIHRoaXMgQUJJIGJlIGluc2VydGVkIGF0IGFueSBw
YXJ0aWN1bGFyIHBsYWNlIG9mDQo+IERvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtYnVz
LWlpbyBvciBqdXN0IGFwcGVuZGVkIGF0IGl0cyBlbmQ/DQo+IA0KPiBUaGFua3MsDQo+IE1hdHRl
bw0KPiANCg0K

