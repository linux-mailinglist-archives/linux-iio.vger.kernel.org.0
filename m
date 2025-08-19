Return-Path: <linux-iio+bounces-22981-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD810B2C4B4
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 15:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13E8A057D8
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 13:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2C3341AA5;
	Tue, 19 Aug 2025 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="L+P4yPf+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9AB322A2A;
	Tue, 19 Aug 2025 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608409; cv=fail; b=bODnJ/aCflEHDJa+rF2+tWCYm370cAVCbjuRrvVnNLSnpS+F0zDDgQ9bGx31T6DAUmGfD2b6asbgzm33VSZS8o5uYFwueUzGRSRkvnRWK9GvG79o9HxPrpKied8Iu1v2FzD6VsIrtu77zybLzouL66n7DRVebIeXhJ8je7/ZSus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608409; c=relaxed/simple;
	bh=cP+rhZafD0C9rhHwOXqZF3O3SmFDuX2xFaQIlGQIyf0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sZMF78PEZ4A4kGDTEQV2OFWOcMj6hlX6/WLI4jvx//4Bk9pkmCT9SvJNZOb1p5Pp/Eu2eQhBRb2wPNhk+mkWnIy9ZvtSphBa+g0Rfy9M/rXkxUWLwYjIyQrF4Cay+Fb8riFVE7GLnWDNvTQSylxGXE8CV8weJw0xJRFtYnb+ISA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=L+P4yPf+; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IMabRr015679;
	Tue, 19 Aug 2025 12:59:59 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazon11012012.outbound.protection.outlook.com [40.107.149.12])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 48jgc0t6vp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 12:59:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpzD9xJ8hN8c4sZNdSnlXzl7zWOxrsx7NnwoldcjDgD3oI6KmgnqP9jNwwGPGS69Mh1QOprZibgVgvppOdhmj12xj4MQm2waseRSEnw6cE4d+7H1sOURq9klOzBmBIoD0fydvJpllaTEpxyBxd46z+GfnlVzdG+JSqaxpp67LqKEJ/EjMKyWkz7+CGFSBkngbPIMtFPfMPUBCt6YKenF3oVBjxgfw2AMHLRl88K0GRISNHnW8yNB0X9pnzhF2KlhC+Xnxg2Dq6a72nUctI6PNT1jsWZSEHAHUQeS0gqp3Bg07ut+lEeZMyfj/TJK3sck9nz2Uo5t/I7vJttU6R/Peg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cP+rhZafD0C9rhHwOXqZF3O3SmFDuX2xFaQIlGQIyf0=;
 b=n83SA6pHQURvNDas4JIk/gmIb+3gSTIMsHTPnovLtAygqVY92DTR0pxyQBHnxBzwCwCFIalu0oIT5M8SeAzQe8vF3tS7qpMBlzJ5OPiyr3ozxlaUjzSpctXF4nyK2RNUyVFvIgE2fOnjYYE2b7nSQPp12GpOFAIfTwyLidZu4LESw3cHiEwo3toDvqz0f+5GVRktMOiCXvHY1WA2PU87S34qK2LHe48wSM8bgCFIs9RaT7kD6A/D9B5Ij18lDxD4u41N95KLEd5rQnT8seQeqToUhVdZl8B/M2dX1lHQ7GreuZxnvtFiG0P0PA2WMGT2yGmo7is6fRrN/5HcSvpP9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cP+rhZafD0C9rhHwOXqZF3O3SmFDuX2xFaQIlGQIyf0=;
 b=L+P4yPf+nrojXAYD12k+5ARNYxQlndW8O9MveRKvK3x1sL0RIGoOoCwkYwyMKWjer+py+c6BlQ8HL7A1ebvd3vXarGqwC00oE2dX1FT7pOHAt4dWlTYTKy0LqhAcjAaQ0yXgjZpIulP60DdXEqqZUiqCEV2Tk5aFX4OQRkCPttXwWoll2jEowzIA3D+LP1/TGCf/5kKnEkYdKvdSOlWvrj1pR6PO2aAKGoF0ZpO6qnEvbLFnsXlloihtCRKp+6hOVKdXRWF/u7Pn5w83iOvXQea4ZzhBJvoGWJVmIcbVK47RYM/xlIh8RsGp+72GsROaLNmCaDv1wC3bfQtSRKhpfg==
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::2d)
 by BE1P281MB2017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:3b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 12:59:54 +0000
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf]) by FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf%3]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 12:59:54 +0000
From: Remi Buisson <Remi.Buisson@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, kernel test robot <lkp@intel.com>
CC: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v4 6/9] iio: imu: inv_icm45600: add I2C driver for
 inv_icm45600 driver
Thread-Topic: [PATCH v4 6/9] iio: imu: inv_icm45600: add I2C driver for
 inv_icm45600 driver
Thread-Index: AQHcDPl7EBZuo8mJbUWChXOytoysGLRjlmAAgAGe7oCABMLZIA==
Date: Tue, 19 Aug 2025 12:59:54 +0000
Message-ID:
 <FR2PPF4571F02BCA013695FCD106D12294C8C30A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <20250814-add_newport_driver-v4-6-4464b6600972@tdk.com>
	<202508151941.BweGaEVT-lkp@intel.com> <20250816131643.635ed15c@jic23-huawei>
In-Reply-To: <20250816131643.635ed15c@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2PPF4571F02BC:EE_|BE1P281MB2017:EE_
x-ms-office365-filtering-correlation-id: e09d1255-96ba-4f9e-b08c-08dddf204afb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|19092799006|376014|7416014|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YnJXZFowRGx1czJLd2lyMXRpZHJMM094Y0FVeEVmTm9JZTJGbG93MWpSN1RB?=
 =?utf-8?B?Tm1qWGlQMElTQU8xSmZZeDFvQzVuOVVIZ0tjV05YK0djTS9INHJYWXJjb3Zn?=
 =?utf-8?B?blBJY1lCZzRGNU1SQnFONXZrc21OaURGcytwdTdyQW5jM0JhTC9xbml0Ukxo?=
 =?utf-8?B?dld3VVVkdDhiRFhXM3Fjc2pEYkN1eUZFSFkzblpkeWFidjBTZzdJcGdVclJ0?=
 =?utf-8?B?YkxhMExRWHgydXdDRmJpQ2dIbExEKzFvRkI1UklhYUIwWXg2RXJMZ2NvZkxR?=
 =?utf-8?B?cGlXdVNvZm9jbklWWFN6emhoeWV4YXhra3Qvb2lxSk5mcTBTOWxTS2p1NTMy?=
 =?utf-8?B?UzVxRUd5REJGWVp1YzRtdERvZ3MwcHNZN2VxQ1ZBZlZ3bmpvS1dnNis4TFFv?=
 =?utf-8?B?SG5DKzQvZUhyazBieHpISUVlam9GMWNzemNxaURJd0hEQVlxV3IwTHF5bHRW?=
 =?utf-8?B?Q0xZd0F1eERQT0FYRWdGbk1kM2Z1dWRUcmNhcEJwM3F3aDY2WUJEbWFlT1NJ?=
 =?utf-8?B?RExnM3dDcGdXOUoxbzNhSWZGdVhwQUhsZnZvdFB0ejBrK0g5MXRscmN3VkNo?=
 =?utf-8?B?ckxOeWNRWE81UGpQbHh3T08rVHpGSnZFb00xdGJIdDNkcEVuNENxWE9ab1Br?=
 =?utf-8?B?VWRnZTA0UVlnejd2TzM3YUZGSWhmTU9JOWVydG9pME9Hb25HUDY4NzNPTitl?=
 =?utf-8?B?T0Zma3hMUUk1WmkwVXo0YWZIMmtWdmxOSXAxQ3ZCUWk3dG1oV0trOUFtdnk3?=
 =?utf-8?B?LzVVVDN2eHdpaWYwM3oxVkx1WXk3L3lvbXJGRVF5Y3ZQSUowZlBMMDk3MVUx?=
 =?utf-8?B?T0x3bGNqeXBoZzJsZFJJZWkyNHhKWU12N0FnQkYrdWFFbTU4ZWE0T2V1TExE?=
 =?utf-8?B?NEJ0aTd6RVJUc0pybVFFM0FaUXZYTlBlTnpBSTVJbVVZcWp5WDFMaVFaOEkz?=
 =?utf-8?B?alFNQldhRjlUTVoxeXFySUl1ZEJGN3ZVaDZERG9kd1ZWbVB0dGlFWmV2SHQ3?=
 =?utf-8?B?dHlaSkNraHl5NU5uRTdsOGNEamNoZTA1U0JiU1ExSzBPOUljREh2UEE5MVY0?=
 =?utf-8?B?Wit4NU9nYXpxT1hZWSt5MlFjellsZUVqOEViOGxNbm5wSEFJQ1pWdEY5SGMr?=
 =?utf-8?B?dm5OeDY5UzlXOWc3QUtRaWR3Rm1TTDRTNmhxMkRJalJJeWlPdjBYQVVFeDRK?=
 =?utf-8?B?VnBRaWQ0MFVnR3A4SmlVcGhUOTA1cEZrWWlueU9aVFQrUVZNSDJENk5VYVZk?=
 =?utf-8?B?WWo0Y21QMnIvbEZmcmo3NnZ2bDVLckR5NU55R1JSTGVadHpmTGlmcHVmK1NM?=
 =?utf-8?B?MnhrNW1iWEIxTGpZQk9kcVJYRVNMdjdJOWNXMWhZQ1psNDlsdk9PZ1lWV1dV?=
 =?utf-8?B?U1VtbEJTVnBYNHd0OU9wRU5TZmFOeDdyb0tZck9IOE5lQmJzNjB6aGo5aEZO?=
 =?utf-8?B?SUxybnVUeG4zMlBRbmx2eTRCeHdqWHA4WWxUb2JheTl6WEsxVkRKa2ZYVm55?=
 =?utf-8?B?MnR6MmZBYnppNlBZc3g5bmhENXBScWUzS2N6SHlPTTVEdUFOY29kSjIvZEJD?=
 =?utf-8?B?aUkvelJqU2hwMEprcWNybWJVTE1KUHpyRnZUZytwVStKTGs5K1JHWUlseGN3?=
 =?utf-8?B?eVNiVVQvempET29lVFRMdzNLNjBIVDJhUStBeGhZUlo0anM4NldvbGtNYlpp?=
 =?utf-8?B?aXVQZkFPdklna1haVlFXLzZlZ2dKNVNXZ0JIMWhrczFPdzNpSmczK0hDUGtW?=
 =?utf-8?B?L0x4MGpIU3BqL0U3RFNsWUcvTU12aTZZSHJVM0htOVkzU0c1eFo1SWdsbk9X?=
 =?utf-8?B?Rkl0VHJiT0ZiV2U1ajFzQ01wdHJvUHhLL0loTi9CeUhQSVBGUzExeXh1cHhv?=
 =?utf-8?B?TVE3VmI5N0xKeGwwVGVMWDlmNk55eXhkNDNLbVd2SDFHYUtNTTdOY00yYnJu?=
 =?utf-8?Q?a8St5g09C4BrTFwZmAZaVWfs06Yo9iyX?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(19092799006)(376014)(7416014)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MytMRnl3SnN5dytkN0tGQUM5b2NoR3pjVDEwV2tPeTUvaHh3V2t3SDExNnRs?=
 =?utf-8?B?Ukp2NGhiYmp0YVNtUnN5NXBKcklRdzdqMi9oSTRlOHVhNGloam1RZTREZWY1?=
 =?utf-8?B?REVFM1pTOVA4UVNHNFVZa0FEdkFsNXVNZlBqRHR1K21LQ2JKTU9FVy81bHF6?=
 =?utf-8?B?b3VIR3dGNStyekRsdWszb3VjRTJSMlc3dU5DOHRDeS9oNWFtTFdXQ3lSWjcr?=
 =?utf-8?B?TEpvYUQ2TU1XWUpkdU1QVWxDYXh5RkxZVTIwdlUvVDNlbWpNZWIvdnF4VDhC?=
 =?utf-8?B?d21MWitYWjJieTBaMzVSMUpGRGR3TEpITzQrRCtGcytzdCt0STRaV2VsUjcz?=
 =?utf-8?B?eGlaVE9ldXIvTUNGMC92bDR5U01mOVZEd0lSTjRyWi82U0NRTG0vZTV0dU1R?=
 =?utf-8?B?QTRCSVZtc05xeEk5SHNLZ1lYZ1FHK3hGQlUxZFUyYmplREJyUks0dXNVUW1E?=
 =?utf-8?B?L1Q5VUJib29zeU9aQTJTV2hlOGIrWlllV1VoMnoyOTFsZmNSTk41aWZnZ3A2?=
 =?utf-8?B?WXRKQkJDbWtYenZDSzVlSEx2VlZSeXJSNjFsWjUxbzM4aWtqa2JKNjd6ZHhJ?=
 =?utf-8?B?NUdJTkFnT2RiOXVkbjBJbThhVEVZbmUyZGRpdmZBRUYwMWdMdzdtc1hZTVA5?=
 =?utf-8?B?dzBIYTl4bEVWWW5CM1MwbThublgyMUttZ1VpdFVDcWk2Sk11WElQVTFDMXJE?=
 =?utf-8?B?Vk1sRU5VMk01QTQ2V3RpOXRWRXhOazVzazFOMTBnakltL2NuNzBYSEdDc1Bv?=
 =?utf-8?B?YXllbVYweFVBTHAyWm9VUHV2ZmxUSTMzalNkMktVeU41ODhIcjI0VW83NGFp?=
 =?utf-8?B?WVFpb0IrRGRjbTRkWkM4L1o3NXFVSytTUm5lMjlnd2t6Q2dRb0ladVVhU2Vk?=
 =?utf-8?B?Q2dwZ1JYVzdFTy9sc1krNEhYYjdYOXo3TVZRcjNPcVdzQzhmOEZzUGNVTVRY?=
 =?utf-8?B?NEkya3R6aDVISWZLSzBNOVVrK3dsVkhxNEtUdzVENW1hMEVIbDgyZTcwVlpk?=
 =?utf-8?B?eUlXdXN6MkJjMGNhMzhZbGNxdXVVeS82RnlmM3lGRURGbFpVUWV1NEdVcUtN?=
 =?utf-8?B?UGhNRENVWVZkZHFjMmZMQWwwUStOYXpCNm1Ga25mckNMVGVpTzJOZlBjV0t4?=
 =?utf-8?B?bWZxRTNTR0YraFF2dHVhcDdxWHZDd3BxTjNCMUhGUkcxc0w0SXJuenZMLzJw?=
 =?utf-8?B?OGtjOEJYRUJnQmJQMWVrYU92VHNSellzQWtxMWlCTGRaU25NNGI4ZCtLaGpW?=
 =?utf-8?B?T25pTTI0dG9TRTFPM3VEcmpCSjQvbnEzc01EQnhpMGlNK3VNdmtTbHdDNDdW?=
 =?utf-8?B?QXdzcXBaYUUxaDFZSDlVZHJ5ZTRCV3RUNWtTa2o2MWRHbGtOaTFldGN5UWZI?=
 =?utf-8?B?TmdqSVVDem5Ma0NJSmxkdHJJbVZBdlFsVUszb3czcFNtT3E1eGdxUUIyUzFP?=
 =?utf-8?B?Nzc4T3FIekZrU1dHcWZmUWRoamxqZUIwbEllU2hUS2lSNCthbEp6VUY3c2Zw?=
 =?utf-8?B?YjFRNU55QThnRmJxRHVQdUcybGtKdUo3cG5uR0s2TUp0WWVaWGJkSjB3VmZB?=
 =?utf-8?B?b3pJMGJQc0p0b016M1VpVlVId0p1OWNQR0t3bmdtT0IzUDI5V29PTTZZbGxz?=
 =?utf-8?B?QW43cy9LTXc3QkNpdVJJTnk3b21sem9uT05KTWpBWCt1dTZUeDh6aktjcE1I?=
 =?utf-8?B?MEE0RFlFMHRiVCtHNlpjNkViVUJ1UERSMTdRMUxwekorODI4MTN1ZUJMNjly?=
 =?utf-8?B?bGxSOVBkS0FVWVgwNVdueXJXbkRoQ0hCVTF0THh5clo3eTFmMlpMbjlWSGI1?=
 =?utf-8?B?aTFIWExMQVNxa0xScXplbUp5amsrRnpVcTUvbTVsU1hQQkRKdURGWmo5aDdo?=
 =?utf-8?B?QmtuZDhYc0p6Qi9yRnJWcEhscjkrbjhSUmRiNFJzNjkvV1MxcXppNG80L0xB?=
 =?utf-8?B?UFdXQzl4VjZ6Um1FdjRqOS85NFFkQUJzUlYrMXUvUHFLTU5hK0dKWUVXS1hP?=
 =?utf-8?B?RVVQTXhWME5FTklXSVYxcjl4TVplRS95dnVQVFh1S0c5U2JlMC9PNGFjMzF0?=
 =?utf-8?B?NEV1MzhwSWlVRjJQTlpsN0lHUEE1Z1RvUkRVZFlNcm8zYUlQOUxSRmRFU2tx?=
 =?utf-8?B?ZklzTm11eUx0bmdJNVhPcThMTHRjRnpRZ0Q3ZXl2bHZVUC9EbUhMZStFSlBH?=
 =?utf-8?Q?ZrP1LyU5hGvlrNqAmkYI8hX/cPH+OLHoMrNNRFCm+7Ar?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e09d1255-96ba-4f9e-b08c-08dddf204afb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 12:59:54.6044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rS72OsXntov5jAHmfu3tPddFRVtxo/bMZ6/Ju2CG8Pdcosw6RFq8S17qv50mfEMlnHXxC7qfTQEVlG7fL3VltQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2017
X-Proofpoint-GUID: PK9RvA7coqgYi8J_64olaQI7F_VmRsmY
X-Proofpoint-ORIG-GUID: PK9RvA7coqgYi8J_64olaQI7F_VmRsmY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAxMyBTYWx0ZWRfX7ekaFxPIPagc
 6pCzftp5ZPS/z5JtJ+xt3QtDoL9Gy0HIZvKqi6mo0iwomxRwEmqtf6iQnRIc2OAHVeFgtoTqKa2
 oNpD8uk1WufcxXdR/7QOAdIw+zpo6ofbpdHMpYMTwA6eySgOaz2Uoz/Cay5RI1n98naM26prFRk
 ZF74oyHvRdDBgjIV2G2uWjJjdwNP580ihTHgYcal18sXI3L32Ldj6chf26/JZ8b7nNM48BnS+YL
 jdygpHFiZAYRNScp9Tu9orlIIRDgq88EJLVMsHMdC10PtihabKWEWQY6cyqadkC+9RQyR6H2T+S
 e+a3p+id35QZ0iWM5NB5KGZgqegLEDcpzj/1PD1ILEeSlOx//yxtNB2DiWKIY4of8T4EDj0NKQL
 iCdr+ibE
X-Authority-Analysis: v=2.4 cv=T/SMT+KQ c=1 sm=1 tr=0 ts=68a4754f cx=c_pps
 a=PNBaoyEkN67PfJ7fQ270WA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=Uwzcpa5oeQwA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=In8RU02eAAAA:8 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8 a=IpJZQVW2AAAA:8
 a=gAnH3GRIAAAA:8 a=nySpmndUBW1BJWx5G4UA:9 a=QEXdDO2ut3YA:10
 a=EFfWL0t1EGez1ldKSZgj:22 a=mmqRlSCDY2ywfjPLJ4af:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 clxscore=1011 bulkscore=0 impostorscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160013

Pg0KPg0KPkZyb206IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+IA0KPlNlbnQ6
IFNhdHVyZGF5LCBBdWd1c3QgMTYsIDIwMjUgMjoxNyBQTQ0KPlRvOiBrZXJuZWwgdGVzdCByb2Jv
dCA8bGtwQGludGVsLmNvbT4NCj5DYzogUmVtaSBCdWlzc29uIHZpYSBCNCBSZWxheSA8ZGV2bnVs
bCtyZW1pLmJ1aXNzb24udGRrLmNvbUBrZXJuZWwub3JnPjsgRGF2aWQgTGVjaG5lciA8ZGxlY2hu
ZXJAYmF5bGlicmUuY29tPjsgTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT47IEFuZHkgU2hl
dmNoZW5rbyA8YW5keUBrZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47
IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz47IENvbm9yIERvb2xleSA8Y29u
b3IrZHRAa2VybmVsLm9yZz47IGxsdm1AbGlzdHMubGludXguZGV2OyBvZS1rYnVpbGQtYWxsQGxp
c3RzLmxpbnV4LmRldjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtaWlvQHZn
ZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IFJlbWkgQnVpc3NvbiA8
UmVtaS5CdWlzc29uQHRkay5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2NCA2LzldIGlpbzog
aW11OiBpbnZfaWNtNDU2MDA6IGFkZCBJMkMgZHJpdmVyIGZvciBpbnZfaWNtNDU2MDAgZHJpdmVy
DQo+DQo+T24gRnJpLCAxNSBBdWcgMjAyNSAxOTozMTozOCArMDgwMA0KPmtlcm5lbCB0ZXN0IHJv
Ym90IDxsa3BAaW50ZWwuY29tPiB3cm90ZToNCj4NCj4+IEhpIFJlbWksDQo+PiANCj4+IGtlcm5l
bCB0ZXN0IHJvYm90IG5vdGljZWQgdGhlIGZvbGxvd2luZyBidWlsZCB3YXJuaW5nczoNCj4+IA0K
Pj4gW2F1dG8gYnVpbGQgdGVzdCBXQVJOSU5HIG9uIGY4ZjU1OTc1MmQ1NzNhMDUxYTk4NGFkZGE4
ZDJkMTQ2NGY5MmY5NTRdDQo+PiANCj4+IHVybDogICAgaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92
My9fX2h0dHBzOi8vZ2l0aHViLmNvbS9pbnRlbC1sYWItbGtwL2xpbnV4L2NvbW1pdHMvUmVtaS1C
dWlzc29uLXZpYS1CNC1SZWxheS9kdC1iaW5kaW5ncy1paW8taW11LUFkZC1pbnZfaWNtNDU2MDAv
MjAyNTA4MTQtMTcwNzIyX187ISFGdHJodFBzV0RoWjZ0dyFGOXFhYkR0NWJ3ZmdsYmNwSTlCTFpx
eFdid1dwdmtHMm16eVlLc3FpbldVUUhTX25oQW1JdGJBdWlLMFdKcmdsQ0IyVHo2OGpLMl9LM0Ek
W2dpdGh1YlsuXWNvbV0NCj4+IGJhc2U6ICAgZjhmNTU5NzUyZDU3M2EwNTFhOTg0YWRkYThkMmQx
NDY0ZjkyZjk1NA0KPj4gcGF0Y2ggbGluazogICAgaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9f
X2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTA4MTQtYWRkX25ld3BvcnRfZHJpdmVyLXY0
LTYtNDQ2NGI2NjAwOTcyKjQwdGRrLmNvbV9fO0pRISFGdHJodFBzV0RoWjZ0dyFGOXFhYkR0NWJ3
ZmdsYmNwSTlCTFpxeFdid1dwdmtHMm16eVlLc3FpbldVUUhTX25oQW1JdGJBdWlLMFdKcmdsQ0Iy
VHo2XzI2ZlN4X2ckW2xvcmVbLl1rZXJuZWxbLl1vcmddDQo+PiBwYXRjaCBzdWJqZWN0OiBbUEFU
Q0ggdjQgNi85XSBpaW86IGltdTogaW52X2ljbTQ1NjAwOiBhZGQgSTJDIGRyaXZlciBmb3IgaW52
X2ljbTQ1NjAwIGRyaXZlcg0KPj4gY29uZmlnOiBzMzkwLWFsbG1vZGNvbmZpZyAoaHR0cHM6Ly91
cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZG93bmxvYWQuMDEub3JnLzBkYXktY2kvYXJjaGl2
ZS8yMDI1MDgxNS8yMDI1MDgxNTE5NDEuQndlR2FFVlQtbGtwQGludGVsLmNvbS9jb25maWdfXzsh
IUZ0cmh0UHNXRGhaNnR3IUY5cWFiRHQ1YndmZ2xiY3BJOUJMWnF4V2J3V3B2a0cybXp5WUtzcWlu
V1VRSFNfbmhBbUl0YkF1aUswV0pyZ2xDQjJUejY4LWZFTzc0USRbZG93bmxvYWRbLl0wMVsuXW9y
Z10pDQo+PiBjb21waWxlcjogY2xhbmcgdmVyc2lvbiAxOC4xLjggKGh0dHBzOi8vdXJsZGVmZW5z
ZS5jb20vdjMvX19odHRwczovL2dpdGh1Yi5jb20vbGx2bS9sbHZtLXByb2plY3RfXzshIUZ0cmh0
UHNXRGhaNnR3IUY5cWFiRHQ1YndmZ2xiY3BJOUJMWnF4V2J3V3B2a0cybXp5WUtzcWluV1VRSFNf
bmhBbUl0YkF1aUswV0pyZ2xDQjJUejY4UlRIaWZldyRbZ2l0aHViWy5dY29tXSAzYjViNWMxZWM0
YTMwOTVhYjA5NmRkNzgwZTg0ZDdhYjgxZjNkN2ZmKQ0KPj4gcmVwcm9kdWNlICh0aGlzIGlzIGEg
Vz0xIGJ1aWxkKTogKGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2Rvd25sb2Fk
LjAxLm9yZy8wZGF5LWNpL2FyY2hpdmUvMjAyNTA4MTUvMjAyNTA4MTUxOTQxLkJ3ZUdhRVZULWxr
cEBpbnRlbC5jb20vcmVwcm9kdWNlX187ISFGdHJodFBzV0RoWjZ0dyFGOXFhYkR0NWJ3ZmdsYmNw
STlCTFpxeFdid1dwdmtHMm16eVlLc3FpbldVUUhTX25oQW1JdGJBdWlLMFdKcmdsQ0IyVHo2OHZR
Qm44Z3ckW2Rvd25sb2FkWy5dMDFbLl1vcmddKQ0KPj4gDQo+PiBJZiB5b3UgZml4IHRoZSBpc3N1
ZSBpbiBhIHNlcGFyYXRlIHBhdGNoL2NvbW1pdCAoaS5lLiBub3QganVzdCBhIG5ldyB2ZXJzaW9u
IG9mDQo+PiB0aGUgc2FtZSBwYXRjaC9jb21taXQpLCBraW5kbHkgYWRkIGZvbGxvd2luZyB0YWdz
DQo+PiB8IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4+
IHwgQ2xvc2VzOiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvb2Uta2J1aWxkLWFsbC8yMDI1MDgxNTE5NDEuQndlR2FFVlQtbGtwQGludGVsLmNvbS9f
XzshIUZ0cmh0UHNXRGhaNnR3IUY5cWFiRHQ1YndmZ2xiY3BJOUJMWnF4V2J3V3B2a0cybXp5WUtz
cWluV1VRSFNfbmhBbUl0YkF1aUswV0pyZ2xDQjJUejY4UnN4VVlaZyRbbG9yZVsuXWtlcm5lbFsu
XW9yZ10NCj4+IA0KPj4gQWxsIHdhcm5pbmdzIChuZXcgb25lcyBwcmVmaXhlZCBieSA+Pik6DQo+
PiANCj4+ID4+IGRyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDU2MDAvaW52X2ljbTQ1NjAwX2NvcmUu
Yzo5MDg6MTI6IHdhcm5pbmc6IHJlc3VsdCBvZiBjb21wYXJpc29uIG9mIGNvbnN0YW50IDMyNzY4
IHdpdGggZXhwcmVzc2lvbiBvZiB0eXBlICdzMTYnIChha2EgJ3Nob3J0JykgaXMgYWx3YXlzIGZh
bHNlIFstV3RhdXRvbG9naWNhbC1jb25zdGFudC1vdXQtb2YtcmFuZ2UtY29tcGFyZV0gIA0KPj4g
ICAgICA5MDggfCAgICAgICAgIGlmICgqdGVtcCA9PSBJTlZfSUNNNDU2MDBfREFUQV9JTlZBTElE
KQ0KPj4gICAgICAgICAgfCAgICAgICAgICAgICB+fn5+fiBeICB+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+DQo+VGhhdCBvbmUgd2lsbCBuZWVkIGZpeGluZyB1cC4NCkluIGxhc3QgcGF0Y2gsIEkg
Y2hhbmdlZCBJTlZfSUNNNDU2MDBfREFUQV9JTlZBTElEIGZyb20gc2lnbmVkIHZhbHVlIHRvIGl0
cyBjb3JyZXNwb25kaW5nIGhleCB2YWx1ZSAweDgwMDAuDQpJJ2xsIGNhc3QgKnRlbXAgZm9yIHRo
ZSBjb21wYXJpc29uLiANCj4NCj4+ICAgIGRyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDU2MDAvaW52
X2ljbTQ1NjAwX2NvcmUuYzo3ODU6MTI6IHdhcm5pbmc6IHVudXNlZCBmdW5jdGlvbiAnaW52X2lj
bTQ1NjAwX3N1c3BlbmQnIFstV3VudXNlZC1mdW5jdGlvbl0NCj4+ICAgICAgNzg1IHwgc3RhdGlj
IGludCBpbnZfaWNtNDU2MDBfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+PiAgICAgICAg
ICB8ICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn4NCj5UaGVzZSB0b28gbWUgYSBtaW51
dGUuICBZb3UgaGF2ZSB0aGUgZGVwcmVjYXRlZCBmdW5jdGlvbnMgZm9yIGFjdHVhbGx5IGZpbGxp
bmcgaW4gDQo+DQo+K0VYUE9SVF9OU19HUExfREVWX1BNX09QUyhpbnZfaWNtNDU2MDBfcG1fb3Bz
LCBJSU9fSUNNNDU2MDApID0gew0KPisJU0VUX1NZU1RFTV9TTEVFUF9QTV9PUFMoaW52X2ljbTQ1
NjAwX3N1c3BlbmQsIGludl9pY200NTYwMF9yZXN1bWUpDQo+KwlTRVRfUlVOVElNRV9QTV9PUFMo
aW52X2ljbTQ1NjAwX3J1bnRpbWVfc3VzcGVuZCwNCj4rCQkJICAgaW52X2ljbTQ1NjAwX3J1bnRp
bWVfcmVzdW1lLCBOVUxMKQ0KPit9Ow0KPisNCj4NCj5zaG91bGQgYmUNCj4rRVhQT1JUX05TX0dQ
TF9ERVZfUE1fT1BTKGludl9pY200NTYwMF9wbV9vcHMsIElJT19JQ000NTYwMCkgPSB7DQo+KwlT
WVNURU1fU0xFRVBfUE1fT1BTKGludl9pY200NTYwMF9zdXNwZW5kLCBpbnZfaWNtNDU2MDBfcmVz
dW1lKQ0KPisJUlVOVElNRV9QTV9PUFMoaW52X2ljbTQ1NjAwX3J1bnRpbWVfc3VzcGVuZCwNCj4r
CQkJICAgaW52X2ljbTQ1NjAwX3J1bnRpbWVfcmVzdW1lLCBOVUxMKQ0KPit9Ow0KPisNCj5PciB1
c2UgX0RFRklORV9ERVZfUE1fT1BTKCkgdG8gc2V0IGFsbCB0aGlzLg0KPg0KVGhhbmtzIGEgbG90
IGZvciB0aGlzLCBJIHdvdWxkIG5ldmVyIGhhdmUgZmlndXJlZCB0aGF0IG91dCAhDQo+PiAgICBk
cml2ZXJzL2lpby9pbXUvaW52X2ljbTQ1NjAwL2ludl9pY200NTYwMF9jb3JlLmM6ODIwOjEyOiB3
YXJuaW5nOiB1bnVzZWQgZnVuY3Rpb24gJ2ludl9pY200NTYwMF9yZXN1bWUnIFstV3VudXNlZC1m
dW5jdGlvbl0NCj4+ICAgICAgODIwIHwgc3RhdGljIGludCBpbnZfaWNtNDU2MDBfcmVzdW1lKHN0
cnVjdCBkZXZpY2UgKmRldikNCj4+ICAgICAgICAgIHwgICAgICAgICAgICBefn5+fn5+fn5+fn5+
fn5+fn5+DQo+PiAgICBkcml2ZXJzL2lpby9pbXUvaW52X2ljbTQ1NjAwL2ludl9pY200NTYwMF9j
b3JlLmM6ODYwOjEyOiB3YXJuaW5nOiB1bnVzZWQgZnVuY3Rpb24gJ2ludl9pY200NTYwMF9ydW50
aW1lX3N1c3BlbmQnIFstV3VudXNlZC1mdW5jdGlvbl0NCj4+ICAgICAgODYwIHwgc3RhdGljIGlu
dCBpbnZfaWNtNDU2MDBfcnVudGltZV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCj4+ICAg
ICAgICAgIHwgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+PiAgICBk
cml2ZXJzL2lpby9pbXUvaW52X2ljbTQ1NjAwL2ludl9pY200NTYwMF9jb3JlLmM6ODc5OjEyOiB3
YXJuaW5nOiB1bnVzZWQgZnVuY3Rpb24gJ2ludl9pY200NTYwMF9ydW50aW1lX3Jlc3VtZScgWy1X
dW51c2VkLWZ1bmN0aW9uXQ0KPj4gICAgICA4NzkgfCBzdGF0aWMgaW50IGludl9pY200NTYwMF9y
dW50aW1lX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+PiAgICAgICAgICB8ICAgICAgICAg
ICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+PiAgICA1IHdhcm5pbmdzIGdlbmVyYXRl
ZC4NCj4+IA0KPj4gDQo+PiB2aW0gKzkwOCBkcml2ZXJzL2lpby9pbXUvaW52X2ljbTQ1NjAwL2lu
dl9pY200NTYwMF9jb3JlLmMNCj4+IA0KPj4gODg5MWI5OTM4MTI0MGYgUmVtaSBCdWlzc29uIDIw
MjUtMDgtMTQgIDg4NyAgDQo+PiAyNTcwYzdlNDhhY2UzNSBSZW1pIEJ1aXNzb24gMjAyNS0wOC0x
NCAgODg4ICBzdGF0aWMgaW50IF9pbnZfaWNtNDU2MDBfdGVtcF9yZWFkKHN0cnVjdCBpbnZfaWNt
NDU2MDBfc3RhdGUgKnN0LCBzMTYgKnRlbXApDQo+PiAyNTcwYzdlNDhhY2UzNSBSZW1pIEJ1aXNz
b24gMjAyNS0wOC0xNCAgODg5ICB7DQo+PiAyNTcwYzdlNDhhY2UzNSBSZW1pIEJ1aXNzb24gMjAy
NS0wOC0xNCAgODkwICAJc3RydWN0IGludl9pY200NTYwMF9zZW5zb3JfY29uZiBjb25mID0gSU5W
X0lDTTQ1NjAwX1NFTlNPUl9DT05GX0tFRVBfVkFMVUVTOw0KPj4gMjU3MGM3ZTQ4YWNlMzUgUmVt
aSBCdWlzc29uIDIwMjUtMDgtMTQgIDg5MSAgCWludCByZXQ7DQo+PiAyNTcwYzdlNDhhY2UzNSBS
ZW1pIEJ1aXNzb24gMjAyNS0wOC0xNCAgODkyICANCj4+IDI1NzBjN2U0OGFjZTM1IFJlbWkgQnVp
c3NvbiAyMDI1LTA4LTE0ICA4OTMgIAkvKiBNYWtlIHN1cmUgYSBzZW5zb3IgaXMgb24uICovDQo+
PiAyNTcwYzdlNDhhY2UzNSBSZW1pIEJ1aXNzb24gMjAyNS0wOC0xNCAgODk0ICAJaWYgKHN0LT5j
b25mLmd5cm8ubW9kZSA9PSBJTlZfSUNNNDU2MDBfU0VOU09SX01PREVfT0ZGICYmDQo+PiAyNTcw
YzdlNDhhY2UzNSBSZW1pIEJ1aXNzb24gMjAyNS0wOC0xNCAgODk1ICAJICAgIHN0LT5jb25mLmFj
Y2VsLm1vZGUgPT0gSU5WX0lDTTQ1NjAwX1NFTlNPUl9NT0RFX09GRikgew0KPj4gMjU3MGM3ZTQ4
YWNlMzUgUmVtaSBCdWlzc29uIDIwMjUtMDgtMTQgIDg5NiAgCQljb25mLm1vZGUgPSBJTlZfSUNN
NDU2MDBfU0VOU09SX01PREVfTE9XX1BPV0VSOw0KPj4gMjU3MGM3ZTQ4YWNlMzUgUmVtaSBCdWlz
c29uIDIwMjUtMDgtMTQgIDg5NyAgCQlyZXQgPSBpbnZfaWNtNDU2MDBfc2V0X2FjY2VsX2NvbmYo
c3QsICZjb25mLCBOVUxMKTsNCj4+IDI1NzBjN2U0OGFjZTM1IFJlbWkgQnVpc3NvbiAyMDI1LTA4
LTE0ICA4OTggIAkJaWYgKHJldCkNCj4+IDI1NzBjN2U0OGFjZTM1IFJlbWkgQnVpc3NvbiAyMDI1
LTA4LTE0ICA4OTkgIAkJCXJldHVybiByZXQ7DQo+PiAyNTcwYzdlNDhhY2UzNSBSZW1pIEJ1aXNz
b24gMjAyNS0wOC0xNCAgOTAwICAJfQ0KPj4gMjU3MGM3ZTQ4YWNlMzUgUmVtaSBCdWlzc29uIDIw
MjUtMDgtMTQgIDkwMSAgDQo+PiAyNTcwYzdlNDhhY2UzNSBSZW1pIEJ1aXNzb24gMjAyNS0wOC0x
NCAgOTAyICAJcmV0ID0gcmVnbWFwX2J1bGtfcmVhZChzdC0+bWFwLCBJTlZfSUNNNDU2MDBfUkVH
X1RFTVBfREFUQSwNCj4+IDI1NzBjN2U0OGFjZTM1IFJlbWkgQnVpc3NvbiAyMDI1LTA4LTE0ICA5
MDMgIAkJCQkmc3QtPmJ1ZmZlci51MTYsIHNpemVvZihzdC0+YnVmZmVyLnUxNikpOw0KPj4gMjU3
MGM3ZTQ4YWNlMzUgUmVtaSBCdWlzc29uIDIwMjUtMDgtMTQgIDkwNCAgCWlmIChyZXQpDQo+PiAy
NTcwYzdlNDhhY2UzNSBSZW1pIEJ1aXNzb24gMjAyNS0wOC0xNCAgOTA1ICAJCXJldHVybiByZXQ7
DQo+PiAyNTcwYzdlNDhhY2UzNSBSZW1pIEJ1aXNzb24gMjAyNS0wOC0xNCAgOTA2ICANCj4+IDI1
NzBjN2U0OGFjZTM1IFJlbWkgQnVpc3NvbiAyMDI1LTA4LTE0ICA5MDcgIAkqdGVtcCA9IChzMTYp
bGUxNl90b19jcHVwKCZzdC0+YnVmZmVyLnUxNik7DQo+PiAyNTcwYzdlNDhhY2UzNSBSZW1pIEJ1
aXNzb24gMjAyNS0wOC0xNCBAOTA4ICAJaWYgKCp0ZW1wID09IElOVl9JQ000NTYwMF9EQVRBX0lO
VkFMSUQpDQo+PiAyNTcwYzdlNDhhY2UzNSBSZW1pIEJ1aXNzb24gMjAyNS0wOC0xNCAgOTA5ICAJ
CXJldHVybiAtRUlOVkFMOw0KPj4gMjU3MGM3ZTQ4YWNlMzUgUmVtaSBCdWlzc29uIDIwMjUtMDgt
MTQgIDkxMCAgDQo+PiAyNTcwYzdlNDhhY2UzNSBSZW1pIEJ1aXNzb24gMjAyNS0wOC0xNCAgOTEx
ICAJcmV0dXJuIDA7DQo+PiAyNTcwYzdlNDhhY2UzNSBSZW1pIEJ1aXNzb24gMjAyNS0wOC0xNCAg
OTEyICB9DQo+PiAyNTcwYzdlNDhhY2UzNSBSZW1pIEJ1aXNzb24gMjAyNS0wOC0xNCAgOTEzICAN
Cj4+IA0KPg0K

