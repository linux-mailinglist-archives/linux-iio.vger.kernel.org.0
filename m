Return-Path: <linux-iio+bounces-17580-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB42FA79C6C
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 08:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76A33B27C3
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 06:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F5E224B0D;
	Thu,  3 Apr 2025 06:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="g29jrvNj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601E67081A;
	Thu,  3 Apr 2025 06:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743663540; cv=fail; b=PWIj9y72VHkZO5iT+ANw3nfvkZc3O2afF0pwoU2IL8/HJo6W+XwNkhgxwBbcUaK+/FTghtg/WQo5Zx4/vyzHuIMCqSV3Mo0EJRrhUcqaLw4LUAmqcDbqDJUY2KhJZZh3p46HOB68KL7lCC3fTWNYrqq1467qRrT5a5vxzHGBeH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743663540; c=relaxed/simple;
	bh=5QTCfy9PvV/o2wJRrkJFFLfJiOpRQo9adhTjvErkfzE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oYcDxqjTCCXk6aIZfKEeXaKps5qnH6d7ogBOJvivk1Ff+sPsPGonGQmEXkUeOjYC2jKtvV5aN+urEOtRL/aSRt/3sC0MZDL4bxLntPEkEyFPgJJGTllSPkNHnbm8EGI8Y4HKD2bkPkcfnI+CpN6v6edexSgV0y91/QIsdf3c7v0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=g29jrvNj; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5335jwLC005937;
	Thu, 3 Apr 2025 02:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=5QTCf
	y9PvV/o2wJRrkJFFLfJiOpRQo9adhTjvErkfzE=; b=g29jrvNjlvJgEl6+X1L6G
	4+SnewhNCW0r0LZJx7tFzxMYYjNVWLJFc0pB133wf/cDcybWGO/KRDv7TboHGl5b
	Tfw/yWlwsHdUaMJGHaevBAD/8EjaLNDA9ZLvk+JHfFXIeFZixuESRdWwcrj3C2oj
	bwy4b7JFAnoVVF34QwpLUB7Rg1EINnrJcLyJ1lGPR4Q88va+cKiT4eLzuKFLPD8f
	5j2kGK9qvJ28s0XaW7kQsdb1Tc8fUQ3CXmcl/v3Bgyu5IcCdwgnXPP6gOxMBYTeK
	njyj7Vbz9XwF4lZKmjOi9eMsnYImM2VNmjh8hffmDiOs/LDcM7hndKs+o2C5dT+b
	w==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012051.outbound.protection.outlook.com [40.93.20.51])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45smfjr81b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 02:58:30 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOYGlQxurj1GW9yIPP19uITGAhpUL9XXNJnSZkPA9oBdS5Y86mImySbQs75SYgtWTUs7Z3YCBReHj3LXSRfRuz3o1W+TXKk2oC7CqxjnTIRP8bBhepoDxN5eoJi5zC6ULQPU0RBHBs8eSSXi6TTF/3UWvNZmz2ItONTpWMQsKADH2ZXArmE8gPN2YqjnMXHons96vogjEkWU6ZFW+j59NnMxISOndsd7wUeXI2uXYi+WWe9tQ7iymrs5AkH4nwTGbLiy8pvPkSpIAJwrnnJhTSbtlK4nkbYhBr9qKwUN+MfvnNiIJ8PKuEadSvOCFEdouC+uaj2UPr9UwDVgzuYhIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QTCfy9PvV/o2wJRrkJFFLfJiOpRQo9adhTjvErkfzE=;
 b=aMmXVSsowJKNOyj+NkIT287FtxKCkxgUEaFToW4MlCuP2EnebOt1M6zMzv9QgIeKGJny7GBSywR+bOPlxO/dPi9U6BHtJEILe/NePtQUPul/7lncTnRGEklNakFWe/jlQcdsvRklzntNeUy06RPAX9Cw3mLq5Wt52h34HK8nIK8YOYO6ZgJjIutJerOXXHhquRSOMnaVALQiJZYaDnuprpm9wMsBC13N9DgZp0dpZDclgYZGjnmXGHa6k8LvZn1V5EhVEbGgVBCSxBgde29NiRotLVDECoSUQp8hT/J3f+S0onUi+ZYKKfZugZt7aFNgO3GO62AfEOIYzamCVHJcVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by LV8PR03MB8139.namprd03.prod.outlook.com (2603:10b6:408:295::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Thu, 3 Apr
 2025 06:58:28 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01%4]) with mapi id 15.20.8534.048; Thu, 3 Apr 2025
 06:58:28 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 0/3] Add driver for AD3530R and AD3531R DACs
Thread-Topic: [PATCH v3 0/3] Add driver for AD3530R and AD3531R DACs
Thread-Index: AQHbpFoaKr0ZzU4Kbkeat/lDo2qjT7ORfrwAgAADS8A=
Date: Thu, 3 Apr 2025 06:58:28 +0000
Message-ID:
 <PH0PR03MB714139DBEC9D4035F7CD243DF9AE2@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20250403-togreg-v3-0-d4b06a4af5a9@analog.com>
 <20250403-bison-of-glorious-force-4369b6@krzk-bin>
In-Reply-To: <20250403-bison-of-glorious-force-4369b6@krzk-bin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|LV8PR03MB8139:EE_
x-ms-office365-filtering-correlation-id: 3033490e-6108-443d-a63c-08dd727cefd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Smk1WkltUE5PaFEvQy9TTzY5VzU4dTNKSE14NHl1TCt1NlUwem5yYUZsdFZq?=
 =?utf-8?B?VUVtMXVnMW94aDNxMXBLWkhVdHNYcndrQlRrZXhKaUFqc0FMUGZvMTVYNWg2?=
 =?utf-8?B?UUhLU3dXNzF3TlBOUVA0aEZqMEZ1RDlwaThMTjgvcVVuS3NNbmUwa042Q2M5?=
 =?utf-8?B?V0xkOTV1L0xKZFRKVHdXOHdMMnd2VTBlVDBnNTMwL3Rhb2Z4UzBxREtKTjZ4?=
 =?utf-8?B?QjBzVithdnc4OWVUMFNyWEFqd3ZweEtjZzRtUWlvdUdZWEpuNHJxdDUzVFhF?=
 =?utf-8?B?SXRNWFJmTG96UHJoN0FOb3Z3dWQ0TElGZWtud21nT1E2ZGJ1K0tPZVVreXpl?=
 =?utf-8?B?RlE1WkhjUWFHc1dHdVMyMjhaM2tNUlJJSUZCeEt6UG5haE5PU0FndUZDZ2VN?=
 =?utf-8?B?TzhIZUEvRzhmZlVrb2ZSMS91MlNKYlZBaDlydENTcjZHNTNTem9aRkorc3h5?=
 =?utf-8?B?d1g3aVJmYlR4cmRDV29tVjlOdERqN2xYNGVCWUMwRHhoT28rS1dEdVpaSmly?=
 =?utf-8?B?VHRxd25jc3pZSnRNYVVWNWlpMzdSbXZRaEQ5Zzd5ekk3dEtFdThJdWJNOEpj?=
 =?utf-8?B?TVE0WmZ3NlpCYkozc2JLQlI4MTFYeHBWTGNQR0NJZGoxTG9CNUtDUDhnaFp2?=
 =?utf-8?B?czUyeVVyRytsOHN5bm5YNXZZWTdRdVZmbFJObTdBRktjNFJheFBlVzc3dm01?=
 =?utf-8?B?Vzl2RTBKNzRSNFhSMmJHTXpqVVZLS1Jhd3hxM2ZGQUVOa1MzQjBSdkJMaE0x?=
 =?utf-8?B?b0c0Y1RLdG5md2EwZ1gvM2pHZ1JFVUp4T0lSUFRJMVhsRXpqaDV0a3QzRzJU?=
 =?utf-8?B?eTl6cGxXaFJkcGd4WGpWbjRXRWFLcFlaeWNZc3hJOHRUdzdYdnZQQzFjdFRP?=
 =?utf-8?B?T0ZaWmVLMDI1NnVLMTRjQlV3SkZHSFRvRU11VHN6NjVZeTAvNmwzZW5ibTRM?=
 =?utf-8?B?NVNGWUhrWVpOOGtkbkRtbk1KSFliK3ZENU5XQnc1TmZkaWtxMlpkVlo2WkRj?=
 =?utf-8?B?bEhlUWtwSTNyYWVRaElrYVRhakgzN1ppb1JJRUdmMS9JeVlORlN6WmpFOSta?=
 =?utf-8?B?eUtOYzI1N3c3T0N2bW12SnRTaWQ5MDJrSlNtUG1DakFwRFhnTm9veGwrcGll?=
 =?utf-8?B?QXl1dzdnZTJ1eGloNUxoU0FjRnk3THlIczdMS0l2MHlHWnNCY2Rtc01MTHo2?=
 =?utf-8?B?V2ppNUxpU25HTFRuLzVyK2licHcrb1pacWlJRzd1NXFuNzBVRGhzL2w1SDF3?=
 =?utf-8?B?UTV3LytvQytINnBXaXV5Z1hRVUVieDQxWlBwWjdmVHNYQ2x2L2IxeThJeEtw?=
 =?utf-8?B?T05TR2VOYVlzNHo2QVdqTFZhTlhPaHpJemJVVjBZcHNmU2wxNjZwZjFsMkQr?=
 =?utf-8?B?M1Rwazh2enF0MzdWVllhL1Z1VkQ2THNNYkFMRlpOL3FBbnU5QWJDMHRvRDAy?=
 =?utf-8?B?R2hxcFArajBLR1Zud1FLQzNuL005NkpaNlFmMnM2dnlUUXV0WEN3ZTNVZzBY?=
 =?utf-8?B?ZWZoOXBFZ1E2dytjOWNqNUY2VEtpVkhuMkJFcThsb24xZnJUQTd1bCtCYTBq?=
 =?utf-8?B?bTVhaERFR29VYmJLUDlianloTEdKeTNjNXF0MVhXc2xQdis4THFSRjNoeUFL?=
 =?utf-8?B?cUlQbFJBcDRmUnlPczdZVWhPSU9CdE9CSXdzMXk5NzlFNklVTlc0VlpoM25X?=
 =?utf-8?B?Lyt5Z2NPTmFQdGY3Rjd4MlFUTEk2cThMWGRZQ1ErQmNBaGZYQ05VcXZpdUFo?=
 =?utf-8?B?bGE5OFFhbzUvOHNGeTY2dkUxMEtodGpTcnowNG5vNW1TR3lVZnBpc1ZkKzh6?=
 =?utf-8?B?RkMySzNycEp0c2ZlOFgraENxdWFQbDhkdUdlemZiZHltYlY5OStES2lEY1U5?=
 =?utf-8?B?SmpXWmk4clBoekVpNVhEdFd1Y0ZHSU1qNWFtQ29LTVJ1UGZCZ2NUa3Vrc0pn?=
 =?utf-8?Q?rYBlrdzJLRniu/9RqMm0vnB9lgzH4uB5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OWE0VHdZdEdtRnNGOWh5NG91RmV4VE5Uc0JJMi9sTUliM1prRmNHMkhlNjg2?=
 =?utf-8?B?Nmk0bHVJT0VuU01id3dNVVZBT0EvSjZwRlpLNTFud21PdlZvVTJxcFFZNjFQ?=
 =?utf-8?B?VEdkOS9VRnIyR1Radkw2aEFqVURqbW5leVBtaEVxeDlCL2xzZmF2ak4xT25i?=
 =?utf-8?B?a2lWZVZsaE5ZUmJ3WUpBRVErRE5nNHViTDdLRkRueE5ONVB2bmVMQ0VjWE11?=
 =?utf-8?B?VDM4SEVraE4yUGFKTFlaSjg2TEVWVnlPZ25vQU80N1ZoVmt4a3g0b21hVXVh?=
 =?utf-8?B?eTcvd2JFTHlSODJVNzJmaW1rc3JvcDFjcjY2MWxuVHI5RW5aaXBURVg0SzA2?=
 =?utf-8?B?Ykx2S1o5S2orb2RtcGhHOGtSTkF3VkN3QUZISkNMY204SFV5RENYanRxUEtD?=
 =?utf-8?B?NDlvbkRRMVdzeXpkUGxBV2dKVXZ0bktXOXpma24yRWVFUHRSY2dEUVBPN2w5?=
 =?utf-8?B?M3BRT0IvL3VNNTVvSjJEMlFWMUt1eWI0aDJoYTM4ZkRhR0NrVUVjaWg3bVBm?=
 =?utf-8?B?cllJY2lzRjhmd2tneEpDY3VyYU1LV1RlTDlGaVQwWXg0bER6UnZwN3BUQWYr?=
 =?utf-8?B?cTdmUlBaMFBzd3BNZFRTaEFOSlJ2MFdITktBTUwyRldydm5rWkdFa2JIcHZz?=
 =?utf-8?B?R0RnaFZEL2lWOFNJYzJCeFZhNDFsdEx4V2VMb1hWdzByUU15S3BPRXB0K0d1?=
 =?utf-8?B?ejY1eEhOQlZJaGxHTTQ1eDRnY0lUUHhyRktlbHVjSkZCYkhxRnFrOUdOb25t?=
 =?utf-8?B?L2Z6dGFGSWY4d0E0aEYyWmRpamRoZmNPZldDTng5YmRMRng3SWJjM25vR3FB?=
 =?utf-8?B?OTZNVTVEbG8zY0o0RDIxcmNWL0UxRE56Qys5ai9zWjNRZkNUMU81TVVPWm5n?=
 =?utf-8?B?c2s5bGtZbXN3Ukd4a1dWeTFuVXhjRkpaY2pLV01qeURsK1hHUTg2cXlFODl6?=
 =?utf-8?B?Uml6cVpkVk1jUm1tV3Z5L0drcklrM1NGSlpzUFdIM3JseUt4ejVWMk9iaThC?=
 =?utf-8?B?dU96ZDZlSzVJQlhOUWFNdW9tVzZKcHZyc0x1a1lrck5DVklzQkF0UDZ2ZHFp?=
 =?utf-8?B?K2xlUWlnUnRSOVBaR2JRazFOZldJcVpyT0VPRld4SGE5aTNRY1lQaml4ano4?=
 =?utf-8?B?aUxhdDZUcE1QV0h4bUtKZTNDVWM4MmNldDRCaytDR0sxQXFDYUpxQmg1UWZM?=
 =?utf-8?B?SDZZSy9Yb2Jsd2pFblZac3lEdDFlQ1hUS29TU3pwOTMrOEVZMmpBWWk2UmlY?=
 =?utf-8?B?aTRYK2JqTVBSTExqcm1CaEk5R05CY2tJeW0xVXNnRWJmalJySW1uSDVmMjd0?=
 =?utf-8?B?blRsazNHajBFQXVGQmZEa25ieDZicUhkRFhuMGdlS1d2N2lLVWpRNW41V3JD?=
 =?utf-8?B?OVZnZjI5WTZYUkYzYlJGTjdnOXJweGJLc01NZHd3Vys0elVLa3ZvSVpKc3Ru?=
 =?utf-8?B?ejd1ZHNOd2tTQ1RmUU10WWdLdnlDL1UvQ0hvOTQ1bXM0eTk3WG1PVlI1NVNz?=
 =?utf-8?B?Y1VQY3oybWp1SWdtVllEZ1RCL0o3ZmtCL09GNXQ3R3BMWU5oZ2J2MFZwVU1C?=
 =?utf-8?B?RmVqK0FKYTlzdFVwYTBZYnhIOWp5L0IraEVIRWdGd2ZGaXNYak5GK3NlOEhI?=
 =?utf-8?B?SXUxbjhjZHlPWjlSSlBRR1hibWFZOHQrQXI2VlllWFdXeE4rdlR5RXhkZW05?=
 =?utf-8?B?SWtGMStnMjRIYlU2LzhMUHAwWHozZEUwSFluMEsyTW54MWV1dEdSb0FHc3dH?=
 =?utf-8?B?WE8weG1jTThLTWVvUUtZT1VEbis0dnNyOFZyaVRya1FPZEJ6bHMxVTVDUmRH?=
 =?utf-8?B?SUNsYzBXZ2tFUUtuQVdZblVML0hvOGl3TUUrOUF2aE1yM0MwSkpFOFpRdW5u?=
 =?utf-8?B?M2RjTGRKT0VLWjlZdVhmZ0R0YUNjbUtLQlJmL1NjeFRKZUVzRUVGNkxOQkw5?=
 =?utf-8?B?S1NlbzVWbThibzA2V3I2ZmF5VmNmNnRHQlNYVTN4T3ZjdG94SEFISE9RZ1l5?=
 =?utf-8?B?aVNuand2VThHdW9zeUZsYTJ0VHN1R1JoSVZkMFZpMmdpTE8rU1NyVkw2TFJv?=
 =?utf-8?B?ejRKVDhUTmZVVDl3OVNNZ1ZRUGlkWktvNitDRk1NT0cwa0ovdENDNzVhci9l?=
 =?utf-8?Q?9Jt2MKQXHL1F8wv8SyCjNknDN?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB7141.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3033490e-6108-443d-a63c-08dd727cefd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 06:58:28.1409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qib0nhApPiiqoqhOl5IEQGTvHMrlriquQRIuqoxnpCkVIL1BRGjOh6Vf7U2DqDu7wY+Px2tCTIHS+JWAADTRUfcx8WVvTiBCgigZ30uPqyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB8139
X-Proofpoint-GUID: 7qd34XKpw5QxqwIuBQxOu2yGjXOCrnMR
X-Authority-Analysis: v=2.4 cv=TpXmhCXh c=1 sm=1 tr=0 ts=67ee3196 cx=c_pps a=s+CWjU1cAxIdjlq2nM3SAw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=bfzWZJ7s1EdQEwcc3_oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 7qd34XKpw5QxqwIuBQxOu2yGjXOCrnMR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_02,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 clxscore=1015
 adultscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504030033

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgQXByaWwgMywgMjAyNSAy
OjQ0IFBNDQo+IFRvOiBQYWxsZXIsIEtpbSBTZWVyIDxLaW1TZWVyLlBhbGxlckBhbmFsb2cuY29t
Pg0KPiBDYzogSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz47IExhcnMtUGV0ZXIg
Q2xhdXNlbg0KPiA8bGFyc0BtZXRhZm9vLmRlPjsgSGVubmVyaWNoLCBNaWNoYWVsIDxNaWNoYWVs
Lkhlbm5lcmljaEBhbmFsb2cuY29tPjsNCj4gUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47
IEtyenlzenRvZiBLb3psb3dza2kgPGtyemsrZHRAa2VybmVsLm9yZz47DQo+IENvbm9yIERvb2xl
eSA8Y29ub3IrZHRAa2VybmVsLm9yZz47IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDAvM10gQWRkIGRyaXZlciBmb3IgQUQzNTMwUiBhbmQg
QUQzNTMxUiBEQUNzDQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBUaHUsIEFwciAwMywgMjAy
NSBhdCAwMTozMzo1NFBNICswODAwLCBLaW0gU2VlciBQYWxsZXIgd3JvdGU6DQo+ID4gVGhlIEFE
MzUzMC9BRDM1MzBSICg4LWNoYW5uZWwpIGFuZCBBRDM1MzEvQUQzNTMxUiAoNC1jaGFubmVsKSBh
cmUNCj4gPiBsb3ctcG93ZXIsIDE2LWJpdCwgYnVmZmVyZWQgdm9sdGFnZSBvdXRwdXQgREFDcyB3
aXRoIHNvZnR3YXJlLQ0KPiA+IHByb2dyYW1tYWJsZSBnYWluIGNvbnRyb2xzLCBwcm92aWRpbmcg
ZnVsbC1zY2FsZSBvdXRwdXQgc3BhbnMgb2YgMi41Vg0KPiA+IG9yIDVWIGZvciByZWZlcmVuY2Ug
dm9sdGFnZXMgb2YgMi41Vi4gVGhlc2UgZGV2aWNlcyBvcGVyYXRlIGZyb20gYQ0KPiA+IHNpbmds
ZSAyLjdWIHRvIDUuNVYgc3VwcGx5IGFuZCBhcmUgZ3VhcmFudGVlZCBtb25vdG9uaWMgYnkgZGVz
aWduLiBUaGUgIlIiDQo+ID4gdmFyaWFudHMgaW5jbHVkZSBhIDIuNVYsIDVwcG0vwrBDIGludGVy
bmFsIHJlZmVyZW5jZSwgd2hpY2ggaXMgZGlzYWJsZWQNCj4gPiBieSBkZWZhdWx0Lg0KPiA+DQo+
ID4gVGhlIEFEMzUzMVIvQUQzNTMxIGlzIG5vdCB5ZXQgcmVsZWFzZWQsIHNvIHRoZSBvbmx5IGF2
YWlsYWJsZQ0KPiA+IGRhdGFzaGVldCBmb3Igbm93IGlzIHRoZSBBRDM1MzBSL0FEMzUzMC4gVGhl
IG9ubHkgZGlmZmVyZW5jZXMgYmV0d2Vlbg0KPiA+IHRoZSB0d28gaXMgdGhlIG51bWJlciBvZiBj
aGFubmVscywgYW5kIHJlZ2lzdGVyIGFkZHJlc3NlcyBvZiBzb21lIHJlZ2lzdGVycy4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEtpbSBTZWVyIFBhbGxlciA8a2ltc2Vlci5wYWxsZXJAYW5hbG9n
LmNvbT4NCj4gPiAtLS0NCj4gPiBDaGFuZ2VzIGluIHYzOg0KPiA+IC0gRHJvcCBBQkkgZG9jcy4N
Cj4gPg0KPiA+IEJpbmRpbmdzOg0KPiA+IC0gRHJvcCByZXZpZXdlcidzIHRhZy4NCj4gDQo+IFdo
eT8gRXhwbGFpbiB3aHkgeW91IGFyZSBkcm9wcGluZy4NCg0KSSBpbnRyb2R1Y2UgbW9kaWZpY2F0
aW9ucyB0aGF0IG1pZ2h0IHJlcXVpcmUgcmUtcmV2aWV3IG9mIHRoZSB1cGRhdGVkIGltcGxlbWVu
dGF0aW9uDQooZS5nLCBhZGRpbmcgaW8tY2hhbm5lbHMgcHJvcGVydHksIHN3aXRjaGluZyB0byB1
bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNlLCBhbmQgYWRkaW5nDQpub24tciB2YXJpYW50cyB0
byB0aGUgY29tcGF0aWJsZSBsaXN0KS4gSXMgdGhlIHRhZyBzdGlsbCBhcHBsaWNhYmxlPw0KDQo+
IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

