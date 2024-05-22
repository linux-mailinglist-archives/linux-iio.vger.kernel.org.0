Return-Path: <linux-iio+bounces-5168-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DA28CC0C6
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 14:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74EFA1C219BE
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 12:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF5582494;
	Wed, 22 May 2024 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="k+9aHEQ0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0C381ABB;
	Wed, 22 May 2024 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716379294; cv=fail; b=XjVQLF4I7cmHcaB7YnwJVDR7FYf+EYztxjjz0sUNeK26TowjFNGPPVioEGv7hQb3d4HzcrAIvxMsD2862plRipf3Egljd5jwzyuc22RnK8AlawiKU+Do0ST3kjn6EhUsd/lCP/a0epQTDShsS3XoknTtYOB3q8zs+EO+FaoQKLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716379294; c=relaxed/simple;
	bh=hHuntbXHYDVnOQhzedbM6vsZabjfrfB2gYJ4OqGOEdo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FgZYOrAnl8uGojOUX0fxN14SabekIbo+hOV2M8mDX1rQ1oI5BWLW5OAZbaTGRftlepyfWlQ6xbItKP0OrEKO3B2P8dlQSn02uzXDSWtcfwnWs/pYbC+0Vo6Vwyg+IyN8G3u3LNRLiMGuyxuWrFjxKPI7ZEd53V0A00dSxsVKucs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=k+9aHEQ0; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44MB5w96011801;
	Wed, 22 May 2024 08:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=DKIM;
	 bh=hHuntbXHYDVnOQhzedbM6vsZabjfrfB2gYJ4OqGOEdo=; b=k+9aHEQ0dH69
	O1KU8WC4eieV1XYQo8Y55piujusGgNw73ggX0oGhuJsosUjpKMgyRKBJYX/9qIi+
	OaaT/SJ+hLK1I5F+jHN6G/2PcCG0T3c7BMUirztg5QyC/JWnV/jXDj+50JvcHtkJ
	n3o9dH4K7A2dnRnht6odcgzldLmnEA1CwH4hGEWessRLW9RS5ns09G9TJP5A1KGl
	kTdcRtffNgW7a0/E+e/QihL0mxMZd3UXQF92Uj2vFqigKXO3w1HjuV62n0j2x1+J
	+/PBjH+zhlkYa5rxaxrCp7iC1jcj9QE+Z/C5NXHLNQ0/HpXKV61Ac6IYH+7MpQG7
	zK0jRAPgOw==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3y87pwh0ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 08:01:25 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gc1BQSzhMkFQDVmfGrN3Xss5LO7zkrk2tU+4IWAJsUEG1kHXurUVsXCkKFyD1/qP47xki1KSJ+zFyoW3bXnEYnsW98x9B7caMR5rPSbo4ed1tGQIVQVfkvET8z2J2U79oaT1qRFpbjc4L79o7c6IHBWMzun9xQ7UHgwaiIWUebqWaUw1v9p3Ksw57NgawH4g6Kn4mzxwAcz7F5FZsJsVsz06r3QZoGQi+iP6SKJ9YpFtrNE+wLLfjiddNgHeoYz0LLsIYeT9RGhPWZzyelT+KImRRqV9rjMSIkJ10flq0K8wf1VIkanRGDvdDDmwhcPrZP8DUu5LAIg3GEp5AxNOEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHuntbXHYDVnOQhzedbM6vsZabjfrfB2gYJ4OqGOEdo=;
 b=PuGrAL+wB1Xu6QvzIQtuetHpGp1RIFkpVOH1QoJoY3+Y1aIAz0EL0zNO4XzViv0KN8flm4YlyGxqQkQdod9WoZ2IZXfXM2tDeT+OXj+ekDGhSfZpIjqVfuVZ7DvyJWw6g8aEaVUUYe1A9ng/jG+lVB2dAmpHMGk2K6318Nrd45nSiYzsR6tiM3D0Va7XhKBNmOhjgNe2P0plYjGF9Lo9ChkJefvRflV9+OEWDC7ZjtWLEgZOL2qBEbBQw33hxrFtIPK02LnJhm4VzclbT5vCDVhANMR2jMnV0FTRNmR5dn26jbM2nc8JdcgbjVDvpdmMivfSjHkB8fm8erzvnyxnhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from BL1PR03MB5992.namprd03.prod.outlook.com (2603:10b6:208:30a::20)
 by BLAPR03MB5553.namprd03.prod.outlook.com (2603:10b6:208:285::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 12:01:22 +0000
Received: from BL1PR03MB5992.namprd03.prod.outlook.com
 ([fe80::8988:90a6:57ee:7161]) by BL1PR03MB5992.namprd03.prod.outlook.com
 ([fe80::8988:90a6:57ee:7161%4]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 12:01:22 +0000
From: "Gradinariu, Ramona" <Ramona.Gradinariu@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: =?utf-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>,
        Ramona Gradinariu
	<ramona.bolboaca13@gmail.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>
Subject: RE: [PATCH 4/5] iio: adis16480: add support for adis16545/7 families
Thread-Topic: [PATCH 4/5] iio: adis16480: add support for adis16545/7 families
Thread-Index: AQHalVo3bqw+P5g2UkWo1XB+DdFxTbF91gSAgAEVXwCAAFF3kIAAcp2AgCOk4tA=
Date: Wed, 22 May 2024 12:01:21 +0000
Message-ID: 
 <BL1PR03MB5992653C0A426BAC69D7033197EB2@BL1PR03MB5992.namprd03.prod.outlook.com>
References: <20240423084210.191987-1-ramona.gradinariu@analog.com>
	<20240423084210.191987-5-ramona.gradinariu@analog.com>
	<20240428162555.3ddf31ea@jic23-huawei>
	<e62f8df4b06abc371b1e9fe3232cb593e468d54c.camel@gmail.com>
	<BL1PR03MB5992DEBF82C0DB7BDC5EA0FF971B2@BL1PR03MB5992.namprd03.prod.outlook.com>
 <20240429204027.3e47074a@jic23-huawei>
In-Reply-To: <20240429204027.3e47074a@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: 
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jY21KdmJHSnZZV05jWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTFtWmpnNE1EWXdOQzB4T0RNeUxURXhaV1l0WW1RMU5TMDBNVFUy?=
 =?utf-8?B?TkRVd01EQXdNekJjWVcxbExYUmxjM1JjWm1ZNE9EQTJNRFl0TVRnek1pMHhN?=
 =?utf-8?B?V1ZtTFdKa05UVXROREUxTmpRMU1EQXdNRE13WW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?STBNRGs0SWlCMFBTSXhNek0yTURnMU1qZzNPVFkxTVRjMU5UTWlJR2c5SW1j?=
 =?utf-8?B?MVdHeHRjMU5uUTBaNFprbzVjMnBzT1VWUk5YaEhOVEJZY3owaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUTNoQ1QwaENVRFo2WVVGbFVtcEtiWE55ZDJoRGNq?=
 =?utf-8?B?VkhUVzFoZVhaRFJVdHpSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVSaFFWRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQlExVkRZbTkzUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
 =?utf-8?B?alJCUVVGQ2FFRkhVVUZoVVVKbVFVaE5RVnBSUW1wQlNGVkJZMmRDYkVGR09F?=
 =?utf-8?B?RmpRVUo1UVVjNFFXRm5RbXhCUjAxQlpFRkNla0ZHT0VGYVowSm9RVWQzUVdO?=
 =?utf-8?B?M1FteEJSamhCV21kQ2RrRklUVUZoVVVJd1FVZHJRV1JuUW14QlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVWQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlowRkJRVUZCUVc1blFVRkJSMFZCV2tGQ2NFRkdPRUZqZDBKc1FVZE5RV1JS?=
 =?utf-8?B?UW5sQlIxVkJXSGRDZDBGSVNVRmlkMEp4UVVkVlFWbDNRakJCU0UxQldIZENN?=
 =?utf-8?B?RUZIYTBGYVVVSjVRVVJGUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRlJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRMEZCUVVGQlFVTmxRVUZCUVZsUlFtdEJSMnRCV0hkQ2Vr?=
 =?utf-8?B?RkhWVUZaZDBJeFFVaEpRVnBSUW1aQlNFRkJZMmRDZGtGSGIwRmFVVUpxUVVo?=
 =?utf-8?B?UlFXTjNRbVpCU0ZGQllWRkNiRUZJU1VGTlowRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZDUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZCUFQwaUx6NDhMMjFs?=
 =?utf-8?Q?dGE+?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR03MB5992:EE_|BLAPR03MB5553:EE_
x-ms-office365-filtering-correlation-id: 1c173f45-75e0-420b-335c-08dc7a56e5b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|1800799015|7416005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?azlyc3JkQnYyY05JOG1rOHliRDlwVVRFeldxQ0RkS2NYN3AzL1VEbFN1d0ZX?=
 =?utf-8?B?aEF4aW0wY213TXVQQkgya3hZYyt1N09ka1ZXY2hLVGRwQXh6cHpLM01wbnl0?=
 =?utf-8?B?MlBmSmFQQWM4aWMwTXA0TWJFZGhQT3N2aWptemlycFBRNWhHTDNZSEQzV29T?=
 =?utf-8?B?WmZiUlJxSXhqZFZZUTd3SGdseUdOOTZrWitHQTBXZjFHeWZkTlNMTjlidDgz?=
 =?utf-8?B?UWVRNXh2VVRRK1JNZnhvalN6emFNZEJDaVRVbW9uYnZjR2FNYStCcVBVTDdP?=
 =?utf-8?B?S05jNFV4S2NyQjlFQk5JMVVMSm1kakt6TGhGM2pxQWFTZmpFYlpUUDgyQ291?=
 =?utf-8?B?RVAwcnZSVXNtai9wVlFKL0ttcEhzUERKdWI4U05NWUh6MkVHcEdMV2xVclpB?=
 =?utf-8?B?Si9lQm1FL2R1TWdxUGZ0dVdJZjJOeU1ra2owc3J1WkJrMlVVaGxXQlkvQkY4?=
 =?utf-8?B?MkNsYXEweXNmMk9XeGxVeFVCTVUwekJuQndHZ2U1Z0szVVUvSnE5dDgyUXM2?=
 =?utf-8?B?WDBGYmJSY0w0ZXpzYjBPS2h6UFFVMHBZN2dwNGJFL3NTVk5SOFNQaTNIOEZW?=
 =?utf-8?B?TXJqbWl3Y0FkQ2Y3dVV6ZEpxT3pHOW04bTI3aFVXbkVZTWFESjFkaTE2bk1V?=
 =?utf-8?B?RGlSTHoveEpBck9TNjJiLzFqSFNzaCtVU21CbWc2WE1iaVo1UWhNUkJVNW5q?=
 =?utf-8?B?MSswcG5adnNwcmNmdnpLaXlZeVBla2pZeVZLN3RBUHdRaEZzeHRUSVNpYkgx?=
 =?utf-8?B?dUp4cmpmU2xUQ1haYWhCRlR4ZzB5dG9TeXllSXNLbVdzU3ZEQytMY2F5d2p0?=
 =?utf-8?B?TXNhcHA5RGlsNXAwcnRXOXo5UnVjdkdJMStHd3FFUjhQNVJhT0xPb1hoWm5L?=
 =?utf-8?B?NEpEY0JQeDlxZWo5VDVyaEUrY1RxQmY1emw2bFluWFNwRExYYnFySFpoYlZo?=
 =?utf-8?B?clFVQ2dPUGE4NVV5L0sxeFk1MndrLzRWcnpaN1FBN295UWZwQXdNSWhTMklP?=
 =?utf-8?B?a2FtdUdOY0FZY0VaQVNBQTBzNVpBVkI1MkxTeUh0enpHTWtSY1lLQjFZazhq?=
 =?utf-8?B?cWRZTGxxaWR5cHozWGtKQ0RPdWNFOUdqN25pd2VpMlFvUWg1TXNERjJhZlFF?=
 =?utf-8?B?M1BUNXB5eU95RllQNVg1akozZ2JLTmNsbjJYdHhsNXBTNEhSTjV6eE9UbWFY?=
 =?utf-8?B?d3Zsb1E3UTBLYXBFdFh6bzhVZmZubWNKajRTeGZSeW5NdzQ2R3dqMVZLVldT?=
 =?utf-8?B?cU1MTTNvNUV4YW81WnhPd3FpR2pqTTVIcHI1R3NXY2JNanFOUzlCTm53MjV5?=
 =?utf-8?B?MGxrRXpqRjhGQnhiY1UzVGdEZFRaY3VPVFdiSS9TY1FDSVpYQUdCTDlsSUhM?=
 =?utf-8?B?WWsvYUJTQVd1VDN1V2VjMDgrM0kremgvZEhua2JZa3dsWmgwRDZORE9ERklt?=
 =?utf-8?B?aU8ycGFrUjJNZGVNa1dsV0ZSNTJ5dStkZjVxbnd2TW01WUZYcHFqOHRoNWFw?=
 =?utf-8?B?dnBjeVFHQzFmeW1OcmlTbklDNzVsYXdlVVpyNE5naWpmTEJXa3dibkdWaWhk?=
 =?utf-8?B?d2NUUk1TS2xSUHo4RjliRlN3anMrVjk3ZE5xSlRJcjFWUHZNNmxndThHUmRH?=
 =?utf-8?B?c3E1elF2TkprYUhhdGxudE9wTUxKWEdTdERwdGRZMWdiUHBoWVFuUkNUNXJW?=
 =?utf-8?B?bDJzUmcvcmpXSFJHeUsxWWpBbHhpLzYya2NCU2dhd21wdzByT1ZWbTFKMi9X?=
 =?utf-8?B?U3BodkN5REpxaVM1bk1PazFITngvb0Z6TmI5MG14dkU4OWdDL1ozT0k4Zldy?=
 =?utf-8?B?ejRTa3I0MlhJSi96eDE3UT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB5992.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VXJHUTF5NTZrc1JTNTZIa1NINVVKMno2QVRRUURQdm05M3Q4NldMMG05MWF2?=
 =?utf-8?B?UVhhUlJFZStZR3hFd1o0eHlUWWxNMWR0dG13aDR1OEZ1WDZJRjBPbzBFblVw?=
 =?utf-8?B?Q0pYK2QyQnlUSjd3OS8rYW9EY29JNTZibHNsaEJBRnEvdVhRVmlubThQSDdR?=
 =?utf-8?B?L0UycWJKdy96UkNUTWxUQzZISHFkdXB4TksvdkJxdDcwQ0hDVnhDRTV1NlB5?=
 =?utf-8?B?SENXTDdXdGFSdi9Ub1hscHdxQll5UDlCQzh4MnVNNG4vVlVOcnEzaE1ZUEVU?=
 =?utf-8?B?L1NRK2FOYXdTTXhFNU90djRUM3cvTVN5ZkRkWGg0TnhaelhZMlRWQjZQRGls?=
 =?utf-8?B?NndCZXpmUEErOTIrL0VGVWZkR1pFaDV3dzdWNlpOUDVEcVZGVUZLMTJlRDAy?=
 =?utf-8?B?YUh0a2p2YjFPQlZvOW9SMVlsQ2tJOSs3WDlMeW4wa2dBSTZkRTYvUUo2cjFZ?=
 =?utf-8?B?RVhRV0hTejBTdTR0b05Qa3paVWlYNXlIL3BRTmVjVUhyd3ZvOVFiSEhIdkRi?=
 =?utf-8?B?TXg5bVJ3T3c0SWprZmc3NkZJK3FZQ2FENmE4cnhwRjhNdWdaMmNjbmN5M1BV?=
 =?utf-8?B?RWphSGVBTHVxOE5WWVl5MlgraEdQdHplcnFhTDNLZ0dFM2Qwbk1wWjJmR1hk?=
 =?utf-8?B?WVNOY2NSdlhOSWQrWGFrdlU3WFdYalp3cDJMWlAvRVRaQzVEVnZ5b0FWNDhR?=
 =?utf-8?B?NGJ1dDVUd3FZMGNwQ0pUaWUrelNLcyttRmsvUWI4VSs5OFoxQlRubmx1bWo0?=
 =?utf-8?B?QlhWUnJFS3YycU9XTFBHVytydHUxZ1BqSGtyOVhWUlpMU0Z4d3A1WTBweEJP?=
 =?utf-8?B?UW9UaHdYSVFRSE5TUmVHc1FrRWRhSFo5Q0xpWmlxMzNCNXUxZHUrNFF5N0lu?=
 =?utf-8?B?MU9hWmhhZm91OHdoMnhWMmhrV2gyK3RRYkxSV2c2K0ErU3JWRXZsU2hKbjls?=
 =?utf-8?B?TDcySGNRanZqcUw3dUQ3S0lKY0lOcDFsNVAxdEx1Rks2UE1jOW5TbUc1bldl?=
 =?utf-8?B?ODJkTGl2QnNYVm1rRWE2Y1dpa3ZVeHVHOWFjbEp2SnozNHVWblZuTWpPZzJ1?=
 =?utf-8?B?aFdDMnp3RUEweHcyczhFVklDc3NCUWY4R0I0ZEd0K1NkOHNtNVVBV2l3SUtw?=
 =?utf-8?B?V1hjdnQxdGg2VU9CNWhNNlkwV1RKbUdrSXM2TG9CWU4rM2JEQ2pMWUZ1aDRK?=
 =?utf-8?B?VGlRTVphQ0R3VUZUUmNiRDlxYWE2WVQzSmxpQkV5VnRHRGQ0Z0tZLy9nQzBH?=
 =?utf-8?B?M05INmhodDlnWjN2T2NRWkd1KytFekJzdmJnMGVyWklUbVJZdktvcnlZTldh?=
 =?utf-8?B?clpkb2g5TGprTVBaYmx4V3BBM1JvMm1QVDhodGZWTmNKWHpqbVBiOW9pc25S?=
 =?utf-8?B?SU85aFVQNVJCY0U3S2tqeUZyUHZWbTB5L25LbHc3UFJZL1k1RE9kNXJOekJj?=
 =?utf-8?B?TVRENTJCdVNZY01ydDkzNDV1b1gxdDU5S3JVUzcydTBwbCtJaDNiRDl5SkhF?=
 =?utf-8?B?M2ZjZHdSRlRRcE9jTVNTNU50UHl4VjNYUDAweXRwd0FveENnM1VDZm02K3hz?=
 =?utf-8?B?Z1VWRExGUHBUWFRZL0loQzBQQjh2eTNEOC9ENW9CM0dZOXBQL2NHa2JuMmRr?=
 =?utf-8?B?Q1lPRFdZTXVIMjYvc3VmcFJVNlJxckt2YWZmOUpWZVd5U3dVNS9xZi9yZ0VB?=
 =?utf-8?B?a2QzeTgvWDhNNFhGd3ZyK3lGYUhQWk51ZklFNUNUY0xQdVdtUHUzSUZnMStu?=
 =?utf-8?B?cFNYVElYNis1TTdXTzVsOTVxWENFR1dxZWFCY1h5R0h3NHNlNGtKQWZTRXBG?=
 =?utf-8?B?Lzl3TU15MUFMU0dQZ3RseVVRZkZWTmhiQ1VIZjFMNUNraVFiV1lNVjhQOWxq?=
 =?utf-8?B?SUFweFduamVNT0lnaW5jRDAyb1J0RTZjS2hjS2ZMdjNibXVFWE5zeFk5Umxv?=
 =?utf-8?B?WUM5S1F4dHFBL25MaHRRMWczWWdweXRvdHhoNDA1eEFCZGsxZW9EWlhZODlW?=
 =?utf-8?B?MDJ2SXBpak9tM3RDRENmSDA2WE04V3NiK3MvQWh4WTJKK0xsSno1aXNId0hl?=
 =?utf-8?B?OS9LNHRxaVVEOWZ6MWdSbVJjUExYYjJ2azJwMDM3MXVndXR4TUcxSEp0SzZp?=
 =?utf-8?B?OTlIVmJqbG9selN2RkJ1bWs1MkZFelhCRU9aQWg0T0JxZWpobDNXK2xiOGw1?=
 =?utf-8?B?dEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB5992.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c173f45-75e0-420b-335c-08dc7a56e5b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 12:01:21.9553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9E+F665vpFmgCUdCreXI+kNS8x+l0KdixrhVP93bO3hXQ9Ta6R7NcVmrY/ybAlHA18MSi93l5tQjqb6Z6yoh4QANVPtfb8Q/ZRiY0frNcCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5553
X-Proofpoint-ORIG-GUID: Dt9ZdL3zeVSQPWa9NuMFKh190F8kyfjm
X-Proofpoint-GUID: Dt9ZdL3zeVSQPWa9NuMFKh190F8kyfjm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_05,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 malwarescore=0 clxscore=1011 spamscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405220080

PiANCj4gSWYgeW91IGFyZSB1c2luZyBidXJzdHMsIHRoZSBkYXRhIGlzIGdldHRpbmcgcmVhZCBh
bnl3YXkgLSB3aGljaCBpcyB0aGUgbWFpbg0KPiBjb3N0IGhlcmUuIFRoZSByZWFsIHF1ZXN0aW9u
IGJlY29tZXMgd2hhdCBhcmUgeW91IGFjdHVhbGx5IHNhdmluZyBieSBzdXBwb3J0aW5nIGFsbA0K
PiB0aGUgY29tYmluYXRpb25zIG9mIHRoZSB0aGUgdHdvIHN1YnNldHMgb2YgY2hhbm5lbHMgaW4g
dGhlIHBvbGxmdW5jPw0KPiBDdXJyZW50bHkgeW91IGhhdmUgdG8gcGljayB0aGUgY2hhbm5lbHMg
b3V0IGFuZCByZXBhY2sgdGhlbSwgaWYgcHVzaGluZyB0aGVtIGFsbA0KPiBsb29rcyB0byBtZSBs
aWtlIGEgbWVtcGN5IGFuZCBhIHNpbmdsZSB2YWx1ZSBiZWluZyBzZXQgKHVuY29uZGl0aW9uYWxs
eSkuDQoNCkkgZGlkIG5vdCBnZXQgYSBjaGFuY2UgdG8gbG9vayBhdCB0aGlzIGFnYWluIHVudGls
IG5vdy4gVW5mb3J0dW5hdGVseSwgYQ0KbWVtY3B5IHdpbGwgbm90IHdvcmsuDQpUaGUgY3VycmVu
dCBpbXBsZW1lbnRhdGlvbiBpcyBhcyBmb2xsb3dzOg0KLyogVGhlIGxvd2VyIHJlZ2lzdGVyIGRh
dGEgaXMgc2VxdWVuY2VkIGZpcnN0ICovDQpzdC0+ZGF0YVtpKytdID0gYnVmZmVyWzIgKiBiaXQg
KyBvZmZzZXQgKyAzXTsNCnN0LT5kYXRhW2krK10gPSBidWZmZXJbMiAqIGJpdCArIG9mZnNldCAr
IDJdOw0KDQpUaGUgZGV2aWNlIGZpcnN0IHNlbmRzIHRoZSAxNkxTQiwgdGhlbiB0aGUgbmV4dCAx
Nk1TQiBpbiBiaWcgZW5kaWFuDQpmb3JtYXQuDQoNClNvIHRoZW4gSSB3b25kZXIsIGNhbiB3ZSBr
ZWVwIHRoZSBzYW1lIGltcGxlbWVudGF0aW9uIGxvZ2ljPyBUaGUgY29kZQ0KaXMgaW1wbGVtZW50
ZWQgaW4gdGhlIHNhbWUgbWFubmVyIGZvciBhZGlzMTY0NzUgZHJpdmVyIHdoaWNoIHVzZXMgdGhl
DQpzYW1lIGNoYW5uZWxzIGRhdGEgcGFja2luZyBhcHByb2FjaC4NCg0KPiANCj4gVGhlbiBpdCdz
IGEgcXVlc3Rpb24gb2Ygd2hhdCB0aGUgb3ZlcmhlYWQgb2YgdGhlIGNoYW5uZWwgZGVtdXggaW4g
dGhlIGNvcmUgaXMuDQo+IFdoYXQgeW91IHBhc3Mgb3V0IG9mIHRoZSBkcml2ZXIgdmlhIGlpb19w
dXNoX3RvX2J1ZmZlcnMqKCkNCj4gaXMgbm90IHdoYXQgZW5kcyB1cCBpbiB0aGUgYnVmZmVyIGlm
IHlvdSBhbGxvdyB0aGUgSUlPIGNvcmUgdG8gZG8gZGF0YSBkZW11eGluZw0KPiBmb3IgeW91IC0g
dGhhdCBpcyBlbmFibGVkIGJ5IHByb3ZpZGluZyBhdmFpbGFibGVfc2Nhbl9tYXNrcy4gIEF0IGJ1
ZmZlcg0KPiBzdGFydCB1cCB0aGUgZGVtdXggY29kZSBjb21wdXRlcyBhIGZhaXJseSBvcHRpbWFs
IHNldCBvZiBjb3BpZXMgdG8gcmVwYWNrDQo+IHRoZSBpbmNvbWluZyBkYXRhIHRvIG1hdGNoIHdp
dGggd2hhdCBjaGFubmVscyB0aGUgY29uc3VtZXIgKGhlcmUgcHJvYmFibHkNCj4gdGhlIGtmaWZv
IG9uIHRoZSB3YXkgdG8gdXNlcnNwYWNlKSBpcyBleHBlY3RpbmcuDQo+IA0KPiBUaGF0IGRlbXV4
IGFkZHMgYSBzbWFsbCBvdmVyaGVhZCBidXQgaXQgc2hvdWxkIGJlIHNtYWxsIGFzIGxvbmcNCj4g
YXMgdGhlIGNoYW5uZWxzIHdhbnRlZCBhcmVuJ3QgcGF0aG9sb2dpY2FsIChpLmUuIGV2ZXJ5IG90
aGVyIG9uZSkuDQo+IA0KPiBBZHZhbnRhZ2UgaXMgdGhlIGRyaXZlciBlbmRzIHVwIHNpbXBsZXIg
YW5kIGluIHRoZSBjb21tb24gY2FzZSBvZiB0dXJuDQo+IG9uIGFsbCB0aGUgY2hhbm5lbHMgKHdo
eSBlbHNlIGRpZCB5b3UgYnV5IGEgZGV2aWNlIHdpdGggdGhvc2UgbWVhc3VyZW1lbnRzDQo+IGlm
IHlvdSBkaWRuJ3Qgd2FudCB0aGVtISkgdGhlIGRlbXV4IGlzIHplcm9jb3B5IHNvIGVmZmVjdGl2
ZWx5IGZyZWUgd2hpY2gNCj4gaXMgbm90IGdvaW5nIHRvIGJlIHRoZSBjYXNlIGZvciB0aGUgYml0
bWFwIHdhbGsgYW5kIGVsZW1lbnQgY29weSBpbiB0aGUNCj4gZHJpdmVyLg0KPiANCj4gSm9uYXRo
YW4NCj4gDQoNCg==

