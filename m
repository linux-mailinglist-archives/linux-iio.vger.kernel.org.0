Return-Path: <linux-iio+bounces-21565-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D59E9B01ADC
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 13:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 334477B4D05
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 11:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08D92980CD;
	Fri, 11 Jul 2025 11:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="iQyjHuxk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F3D28FA84;
	Fri, 11 Jul 2025 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234041; cv=fail; b=jLdkUVH0h468XVzrc/iz6pjBIJRW6WzEXmutWi9JtDVfaq1voyYvA8owx3IW9EDAZ5/0R9ismxmBu+JwvmUpkw0jPUlE2Twis9FJa758m3/C4mOdXE9KWNRU8KAu0BO3nvArz8T0jDTnWX5sTqcPEHy2ek7/FI33JOalW4Flv2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234041; c=relaxed/simple;
	bh=ienW7Q31ETAHcIqsYGFgJDAKBIOYtjtt4uMiokC7AJA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ijpDE2jmuFm8piKgQon7zBK4htudIOfcqQP0cTvd91kdDQ0FWcdq4k+gSCcab0fJdz4hvlrp3hKKR+X/apZbWkQ44+BBYIlTX18vkGHrea99i6y4lBQCWDbCYb0FYcuYTxs4Kj4XZ653RLXUIu9cJHWaRfm+y9vubITEOJnuTIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=iQyjHuxk; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AMOwWJ003138;
	Fri, 11 Jul 2025 11:40:33 GMT
Received: from fr6p281cu001.outbound.protection.outlook.com (mail-germanywestcentralazon11010067.outbound.protection.outlook.com [52.101.171.67])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 47pwe3vxby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 11:40:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8GR0NN93u6IWQdHkFdk6sWpFCZxNrfyaolRDdrsQF1DP8OcZJzx2Msxny3L/XGZK0IPabbu+TCKifLeI7w2FyCwMqCow8HQgGye9KsM93t42PftUav5iiDDgNJF8c//2qMp9ECjFdHVX2tNxZpJmAvOo0JOLe5xjlACI/fBrb5X2JmRLaWAYw07oLg6mwA6vxCp6wu8gpQV1rRnuCd7QFn76EKz4ioe3plCPLPaG7yuXExVyIEmKD84TmEa2jgYFpuxzpOyKCCM16pTBl3HVRtDY0dK2b/dinhdlwvJMGluvOsoro/0+TCEmUyRm5iiC7+knvgFKc5KJXS29/MTgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ienW7Q31ETAHcIqsYGFgJDAKBIOYtjtt4uMiokC7AJA=;
 b=RF7wNE61bFxNqeQC4CT0MgoZKsieHR7+etFvHmtcLtebLMmXfPOINtyzZ5XZ1wjYYU8Tf0of62XgcWH3Jr0XHbcwgPW3q2IV+gnSxHi0OYfxUgjjufKl+zVhEPgK55s+/JwiZciWihT5ijZYdhNx+lszskPWiF8hsJ9fq7YvqYnHSvlRhtWe/zJFRj0xoDzbbZPira+1cHbNfAMQhAeP+KcJpfcCOFVlv5U5AtMNjQ2n1sQMytpZMkRIvJh3h7vdPngA38AZyrzw2VGqUtJBpdg8BTSYV4zvNMKfeIrhlyK0bBQRyE928TZ2P4bEpc/kowcQrz4HffWVl18Xvqy93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ienW7Q31ETAHcIqsYGFgJDAKBIOYtjtt4uMiokC7AJA=;
 b=iQyjHuxkBd8lES7+7VmPEIsPKl9f3S/YKyMBLW7Fb27sapuWGcZZJ7Ymvo6eYiX5piSDLpLBIR/Mk58244kQ6I13Bl2WtqX/zc2ZaKsrlhto8TEKs61e+dUaj0nvHMQxhAq4LQV5Bgspa9DYAUK8JKvbxfcdY8srPzYtRTqrrI7t4s68W0ghbiTBxUSvuj14T3fPvgRdJNy5H6fIfHvE6QjIZyefQHeQ2I0TphbLjivyXKD10uAczZsciYpnusWRBkrT60M4LUu4qBF8TFqNW7yDv5vRD4WBU81L6A0Lg+R3aF3Lf7rdF4+q/rKkqYXFl+EnDAbddFlJdQO9K8Is7Q==
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::2d)
 by FRYP281MB3291.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 11:40:17 +0000
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf]) by FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf%3]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 11:40:17 +0000
From: Remi Buisson <Remi.Buisson@tdk.com>
To: Rob Herring <robh@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 1/8] dt-bindings: iio: imu: Add inv_icm45600
Thread-Topic: [PATCH v2 1/8] dt-bindings: iio: imu: Add inv_icm45600
Thread-Index: AQHb8XjGNSzfw0LPWUy8flLtSCneZ7Qr9H0AgADZigA=
Date: Fri, 11 Jul 2025 11:40:17 +0000
Message-ID:
 <FR2PPF4571F02BC24F20824D4A978BFCF348C4BA@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <20250710-add_newport_driver-v2-0-bf76d8142ef2@tdk.com>
 <20250710-add_newport_driver-v2-1-bf76d8142ef2@tdk.com>
 <20250710224104.GA4495-robh@kernel.org>
In-Reply-To: <20250710224104.GA4495-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2PPF4571F02BC:EE_|FRYP281MB3291:EE_
x-ms-office365-filtering-correlation-id: ce488092-c988-48e8-9c2b-08ddc06fb590
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|38070700018|3613699012|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZFpiVzBVR3JUOC9PSFU3V3VBQnhNTk1OVXZPVitnTGFEU2tlZG5maVdkajhD?=
 =?utf-8?B?dFBTTHNxSnNYQm1iRnZ3YklsTGVZRU5yZlE2blFoNW5OK3BrYklHNlRyZWJ3?=
 =?utf-8?B?WHNVWkM1SE03RU05bVE3eCtJeFAyWmtZQTg5SHozL3pObzVYKzRKNVBwcW1I?=
 =?utf-8?B?Y1ZjbHhMVmswWUdUTmJUQ1dSalhaMWgrNGtYd2FIa1FFbktmOVhtcDBRK0ww?=
 =?utf-8?B?TFFoNzkxWlUreFhTK2Q5dUxOTDRvUEMyUVZmaTdMQjZxYjJhZ0lyZ1l4N215?=
 =?utf-8?B?SDI1SXJabW0wUFgyQUV2OUdnUEkrUHFBZ0pPT24wVGxSRHdGVk9YR1Nhb2xu?=
 =?utf-8?B?ckZHeTA0Qk8vMWRnQ05ISDJsZ0RIYlBZcmJUeXpDSmVBdmQreTU0NFJKMnUx?=
 =?utf-8?B?aDYzakMvUCs5bTZtR1ZiVm9yMUdkZlRMQzl5aGQ4YlpSSndVQXdlVXhSMG1w?=
 =?utf-8?B?YzZXWTc0Q2dUMmk3QVY2cVFmUUNiU3pXbUpJS1hPY0hVdkNsTFd6SFdnc3Rm?=
 =?utf-8?B?Wms2amh2UWZqUHZCVmVFVlZ5eW8zbXljNXF3alJHNHh0UEJsdDhTb2diRGha?=
 =?utf-8?B?QlVGbyt2eEE3bzg2TjJ0cUlmK0hpNy9ESjVzaWMrTlJNZGs1WVIvcEhiV2pw?=
 =?utf-8?B?bmVONXZldThCcUJtUGtZM2NLa0lxZmN5QWtvNG96dWdycTlPK0VXdm42VXFJ?=
 =?utf-8?B?UG50RHF1UVdDSDh6YUh2bXlxQWtjQVRvU084Z2Z4dkQxSTlHa1I5Z3YvSWE4?=
 =?utf-8?B?UnRmUGRRdmJDQlhJOWJmTit4VVVwcjlRWEVrT1RtdnJZbnQ2ckFlRG9mUTJs?=
 =?utf-8?B?VFd1cFUyN3Q3bnZiSG1BVmI5MlIwTW5pSTZSMDRlTEh1RXBTRFZsb2hwODFq?=
 =?utf-8?B?cTJ1ZFpOQ1o1QUc2REluYjJQL2M5U2xsYVN5YnM4U0JmWEcrWGt6VStqNm4r?=
 =?utf-8?B?Tm81SzVEbXN1NE5Udi90YktOV3RhdDBQcGd4YVJNZ0hZcndXbGFuM01nRE5C?=
 =?utf-8?B?SVBZYTlaaGx6b0dQU3kvdUZXTDFkamZ6RzRvRWJuWXBub0t3aUNORHhpczJ0?=
 =?utf-8?B?dEtkSjZic3I5N3ExUHlLOGNPc0p3NDFaWURhaXpUK0hVeXp6TVM1eUR1d2F3?=
 =?utf-8?B?UXhHRVd2WmFSTmNPNlZyait2NWtvQVhWMkJ1NFhMV05kNW5PazQyWnhVdnNY?=
 =?utf-8?B?YnphVExVUFhORVRrbjdMMEE4blV4TS9LbXFzQlVFcHRkbjdocVphdWFRY3RI?=
 =?utf-8?B?MmtyV2xXejVPTGFFZEN3TVBrZ0M3K1RkeXdNU1hrZUh0a2h6Nmo3K0YxSlhD?=
 =?utf-8?B?QXI1U1FFWEN5VHdDSnhNSXBGVGxVVk01OTBBVHViU2Vyd1hiS3NzaFZZaW82?=
 =?utf-8?B?N2kwUUJLZStRMHYrT1MybW5PVm8vUGlzaTJFZFJPNGlzenAzblBTZjVmcS90?=
 =?utf-8?B?VGlFUHFURzlVbXhlbFIvU3gvT2duaWF4WFlxNUQrTXJXM2QwZ3dUbU95Z3Jk?=
 =?utf-8?B?ekhpWWdHaFFOQ1p6TERWcmpVYTFMTmhWTVJ0a1piOHQwYzErM3lmNFJSaFdM?=
 =?utf-8?B?QkxCZFFyMkxTWTJYK3Q3TjdlQTAvRTNGWFFUekxuVStlclFMUkU1Ri9NeGtT?=
 =?utf-8?B?MEhNMThXRUdHVHNqT1M0M1NZNTVOSGFpUE1tN244ODRNc1QyYW45S1FHZmNn?=
 =?utf-8?B?UE9UZ0lMRVlVQlo0RFhkQXFnMXVoNGt0aDdEeVV3UmlLWldMelo3M1pWNDgr?=
 =?utf-8?B?bDRFT0tMdDhGMUZGL29DWFZFU1EyMkowci8zUnNqQmFOQWVXOTBzSmZsV0d4?=
 =?utf-8?B?WlJueklyc1VJZUJ5TTU2K1NFeWQ5NU5IeEdEbFR1WDkydW1Xd1U1Vkkwc1Jr?=
 =?utf-8?B?eVd6TjVhL3h6MlBCNVRNNW4ycHZVZ3hiK3hzZTJNQ0ovTTN4N0tvKytiRkp6?=
 =?utf-8?Q?Uadua0hg4jiqpPhAzguozXi17DRPjcX2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(38070700018)(3613699012)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V2g0aXZyR0M5bEk1Tks2L0laUFBtTXBrRzhiNlJxTGloRWZ6SDJqanB3blpY?=
 =?utf-8?B?VnoreHlqQXJHelZBN1FmdGNSWjhhaEl3cEdQQ3dYbjE5WnczZk1OSFlHYUVn?=
 =?utf-8?B?eFBBUjArVUcyY2R3a2lUVXNaYWpXb1Jwb2FvZjBZMTR0Nms5MUJHY2FhWVFr?=
 =?utf-8?B?V1BaYnQ3eGRTU2c5eHo4bDJkNTdkelZXdXJGd0tpRWVXUGNMYWV3WGFuMmRo?=
 =?utf-8?B?anF0cGNNbHB4NDdTeE5Oa0JYeXEweiswNFVZNFkxVlEwSXBJRFd0dWhWcjI4?=
 =?utf-8?B?TmkrY2MyVHE2eUk4cFh3SGYxcy9VN3RpTHlRUzNNY2RBajFZMU0ydE5IOEk0?=
 =?utf-8?B?WTdWeUNtbUt5VTZDczZsUExOUVdKaHpzOHJpNzZOU2tUM1JFcmsyUnB1N3dE?=
 =?utf-8?B?QmIwMW95K21Zajd6THNGdXA4dlZJcFZ2bXpDWTBEcllFVWhMay9KZXdsNkJz?=
 =?utf-8?B?cFNkN2lPaHhSanlPVEZ4ZCtzSk82c2tJNVMxemY1RUJGQzN3c0FhWmhpT0Rm?=
 =?utf-8?B?U2tQSTRqTmFSUnl5Rk5SQTQvak1ZSFdkQkV4eWV5T1VmTTEyaEw2TWpydzcx?=
 =?utf-8?B?VDRUMnUrUVBZNlZON0szQVVRMXFXVmpEQUZYaXZYWmYyY1dEcWFWWjF5ZFlH?=
 =?utf-8?B?bzFHZ1d6WWY4SW03NGt3SHgzcE5EWDZyNVF5K216d3NlUm04UWpVZTMwUjJV?=
 =?utf-8?B?L0ttbnJwOVJWZ0hnVGRiMURRaDM3MitCdU5oRVRPUUVsY1dNOTBpb1RxdzRP?=
 =?utf-8?B?NkZ1WWt0cVRWeWRFTG9aZ3pVV2VvRkxka05HMnkxOVBWVnJpOXVyZmNUekho?=
 =?utf-8?B?MUJoYVdzdTg4blNoN1FJV25yZlk1eXRacVk5RGpqQ0hUbjhrUkxKRm1GTVpi?=
 =?utf-8?B?NEFBcVJFclM2RlBmdTFpQXA2TjdGUHoyMWpYRjIzVVNRVEc5VEJSTTM0RzlE?=
 =?utf-8?B?WUhUVjZlMnBITEtnQ0lqNmVhQmNSQjlOVEZQbk9QMEN0bnlqbzlFODNXNmly?=
 =?utf-8?B?MjhRaHlDcGNEajNKeEFqWUlzd2Y5OGhsVUdsbDZidFQxZ1AzTUhselFKM1Y3?=
 =?utf-8?B?cVUrczhTMkFYak12bHQ4YnJaZ0xsd0FEYTJpTG5ocEVmdDZoVG9hUmJUTGti?=
 =?utf-8?B?bUwvZFVrYm9kRGcreFlMOVkvTVpMcVF0a3pPdWtzSHFYSFg0RE5hbkV0Y1VW?=
 =?utf-8?B?aVFycHFmVUtoTSs1OHhCUHJJRGFTQWUvVkErM1AzaHNiMU90YUJjRGRrR1N4?=
 =?utf-8?B?Uk1kK1llVkc4N2pxaWVOQXo1ZFVCT3FWNG82VW4rS0FwSndsa2RiOUg4WHZZ?=
 =?utf-8?B?VHJJNlRvaDZTZXF1eGhHMSs0SjRTTjRWUGt0SUFlWjRSVlZIYzZjTm9pTHZE?=
 =?utf-8?B?NzBSUFVWZFNxczlLL3cxUTIzdEZ6UmlxMGFhUDZhbzZaVjRxQmt3cE1DRzdj?=
 =?utf-8?B?Y3FoUkxYRmtOUk9RTHNkcUhLV2FKVHg0bmZjUUltZlJFaCthYm9VL2poMGNF?=
 =?utf-8?B?SVVtUU1KNnR3MG5MUTVXdUhYNGQ3ZnljM1N0ZTVhNDYzcjd4SUYyYUkxdGZU?=
 =?utf-8?B?N2tsQXJhYisrSjFlcHFjRkxmOW9DM1ZtS1NKNjNVMnlwdkZlR0c2ZG40VktH?=
 =?utf-8?B?R2h0b005Z1F5VGRpVGNxUDBHZWlpY2h5UDV4V01TZkxZVExDb0ZlUGJpdjFY?=
 =?utf-8?B?UVJaZUllUGpSZTRDclNSclQ2MjVya0pmWFJ6SGptOHdiVEthU2JxckpCQjhn?=
 =?utf-8?B?WHlvaW9lanVFdmo0QVRPLzhsbDNPN0dBM3BZb0M2NU0zUGFKcmhmNXhCdFJG?=
 =?utf-8?B?U0ZFZ0UycWpaejV6Z09tZnlxeHhsa2VhSTVMUkZSRG1hcnp5dGhxU1NIcHBZ?=
 =?utf-8?B?b05iZExRbEtXbmZWZ2l1VDhSVnpqQktkTmtnRlRhSkhjZnNRM0wyaGVJcGlq?=
 =?utf-8?B?SThZMEhSU016ZStoQW9Fa1duM1NvaVZIdjZPejI0cnVYUk9jVDhwYklJd201?=
 =?utf-8?B?ckpZQ3YxcU5vZS92OHpxUk85bk5mYkFlQVZaNXozWFRNeGNQUGhuem9FcUFS?=
 =?utf-8?B?SUxOR082aDRwYk8wem9pN09tVGRnbDVDRkg5K0xKTXBQRmdBbHpGUlJla0tt?=
 =?utf-8?Q?D7S46+Atu0Loogr/gg8zdgWpo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ce488092-c988-48e8-9c2b-08ddc06fb590
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 11:40:17.6502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KrFNSo4xaPLac4IdUeDizohAEXWmtMp9aBPd5qAagy2UO5XSzd/z895t1QNYO6Ugt4w/6oWpaq8mOAhgSJXd3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB3291
X-Authority-Analysis: v=2.4 cv=W6w4VQWk c=1 sm=1 tr=0 ts=6870f831 cx=c_pps
 a=xC/ZzPVxK5qpaLrndDdzSA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=Uwzcpa5oeQwA:10
 a=gEfo2CItAAAA:8 a=In8RU02eAAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8
 a=gAnH3GRIAAAA:8 a=bsyG2yPaRIxK24HUzEgA:9 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22 a=EFfWL0t1EGez1ldKSZgj:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA4MyBTYWx0ZWRfX1SncMoGrEbnw
 hOqDFmlt3y+w5IF2sg1Opk1XTvlFqYQ2eB4w8d24w8KOJjviHKcA2KCVRfFIKO65JYQcpERMa9G
 T1mNLEH69Y9N0fyvWDse7bH69D+CUo9r9UbYLtdk45pGkGAp3HDoNvyuNztCgofRpJbVFxXvwE8
 39YACfjZuOQEEuANEy6R8qmUJFgLuMkMu9m3Q9AgdPoY1PC2uO6RNvIWDinW+MnD41YbHIXye3E
 GSJnKf2WyJNxKJnYkVePIq+9XErpGz8cIpfNa5kB5jkSRWdkakJTJdmONpJtjzTlApfLk3BfBzA
 Zmn7vVpYKxYfvMJhJdA5fU3bVdGDbFcnnnBcwCJz6yMhU8B9rStqGHpO9CsrbbMx2g4yDZhaczR
 xbP99Vv08YT/d+i/3ZRyNBxcxUrEDfNno5BEU0snFzG4FNJr5AdZb7Cv93p8hS1cCLYCmr9z
X-Proofpoint-ORIG-GUID: w2Hd5YTCyuzro7cazXE8z_cJtD9hC8xl
X-Proofpoint-GUID: w2Hd5YTCyuzro7cazXE8z_cJtD9hC8xl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 clxscore=1011 bulkscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110083

Pg0KPg0KPkZyb206IFJvYiBIZXJyaW5nIHJvYmhAa2VybmVsLm9yZyANCj5TZW50OiBGcmlkYXks
IEp1bHkgMTEsIDIwMjUgMTI6NDEgQU0NCj5UbzogUmVtaSBCdWlzc29uIFJlbWkuQnVpc3NvbkB0
ZGsuY29tDQo+Q2M6IEpvbmF0aGFuIENhbWVyb24gamljMjNAa2VybmVsLm9yZzsgRGF2aWQgTGVj
aG5lciBkbGVjaG5lckBiYXlsaWJyZS5jb207IE51bm8gU8OhIG51bm8uc2FAYW5hbG9nLmNvbTsg
QW5keSBTaGV2Y2hlbmtvIGFuZHlAa2VybmVsLm9yZzsgS3J6eXN6dG9mIEtvemxvd3NraSBrcnpr
K2R0QGtlcm5lbC5vcmc7IENvbm9yIERvb2xleSBjb25vcitkdEBrZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOyBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZw0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS84XSBkdC1iaW5k
aW5nczogaWlvOiBpbXU6IEFkZCBpbnZfaWNtNDU2MDANCj4NCj5PbiBUaHUsIEp1bCAxMCwgMjAy
NSBhdCAwODo1Nzo1NkFNICswMDAwLCBSZW1pIEJ1aXNzb24gd3JvdGU6DQo+PiBEb2N1bWVudCB0
aGUgSUNNLTQ1NjAwIGRldmljZXMgZGV2aWNldHJlZSBiaW5kaW5ncy4NCj4+IA0KPj4gU2lnbmVk
LW9mZi1ieTogUmVtaSBCdWlzc29uIHJlbWkuYnVpc3NvbkB0ZGsuY29tDQo+PiAtLS0NCj4+ICAu
Li4vYmluZGluZ3MvaWlvL2ltdS9pbnZlbnNlbnNlLGljbTQ1NjAwLnlhbWwgICAgICB8IDEzOCAr
KysrKysrKysrKysrKysrKysrKysNCj4+ICAxIGZpbGUgY2hhbmdlZCwgMTM4IGluc2VydGlvbnMo
KykNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9paW8vaW11L2ludmVuc2Vuc2UsaWNtNDU2MDAueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9paW8vaW11L2ludmVuc2Vuc2UsaWNtNDU2MDAueWFtbA0KPj4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAuLmE2NTE4Nzg3OTFmZmFlOGQxYzhkNmM4ZmYxZTRiZWNmYzU2YWY3OWYNCj4+IC0t
LSAvZGV2L251bGwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9p
aW8vaW11L2ludmVuc2Vuc2UsaWNtNDU2MDAueWFtbA0KPj4gQEAgLTAsMCArMSwxMzggQEANCj4+
ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVz
ZSkNCj4+ICslWUFNTCAxLjINCj4+ICstLS0NCj4+ICskaWQ6IGh0dHBzOi8vdXJsZGVmZW5zZS5j
b20vdjMvX19odHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9paW8vaW11L2ludmVuc2Vuc2Us
aWNtNDU2MDAueWFtbCpfXztJdyEhRnRyaHRQc1dEaFo2dHchRUo2by10bk90dUpZUVJVODE1MG1u
WXBmMHVDTW5ZT1N2ZkJLLURLbzVrRHZ3aGVEUmFMdlBlUXBiWjAzbUtYYVBUR3Y1VDhKTzVzVCRb
ZGV2aWNldHJlZVsuXW9yZ10NCj4+ICskc2NoZW1hOiBodHRwczovL3VybGRlZmVuc2UuY29tL3Yz
L19faHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwqX187SXchIUZ0
cmh0UHNXRGhaNnR3IUVKNm8tdG5PdHVKWVFSVTgxNTBtbllwZjB1Q01uWU9TdmZCSy1ES281a0R2
d2hlRFJhTHZQZVFwYlowM21LWGFQVEd2NVNWN1ozTXkkW2RldmljZXRyZWVbLl1vcmddDQo+PiAr
DQo+PiArdGl0bGU6IEludmVuU2Vuc2UgSUNNLTQ1NjAwIEluZXJ0aWFsIE1lYXN1cmVtZW50IFVu
aXQNCj4+ICsNCj4+ICttYWludGFpbmVyczoNCj4+ICsgIC0gUmVtaSBCdWlzc29uIHJlbWkuYnVp
c3NvbkB0ZGsuY29tDQo+PiArDQo+PiArZGVzY3JpcHRpb246IHwNCj4+ICsgIDYtYXhpcyBNb3Rp
b25UcmFja2luZyBkZXZpY2UgdGhhdCBjb21iaW5lcyBhIDMtYXhpcyBneXJvc2NvcGUgYW5kIGEg
My1heGlzDQo+PiArICBhY2NlbGVyb21ldGVyLg0KPj4gKw0KPj4gKyAgSXQgaGFzIGEgY29uZmln
dXJhYmxlIGhvc3QgaW50ZXJmYWNlIHRoYXQgc3VwcG9ydHMgSTNDLCBJMkMgYW5kIFNQSSBzZXJp
YWwNCj4+ICsgIGNvbW11bmljYXRpb24sIGZlYXR1cmVzIHVwIHRvIDhrQiBGSUZPIGFuZCAyIHBy
b2dyYW1tYWJsZSBpbnRlcnJ1cHRzIHdpdGgNCj4+ICsgIHVsdHJhLWxvdy1wb3dlciB3YWtlLW9u
LW1vdGlvbiBzdXBwb3J0IHRvIG1pbmltaXplIHN5c3RlbSBwb3dlciBjb25zdW1wdGlvbi4NCj4+
ICsNCj4+ICsgIE90aGVyIGluZHVzdHJ5LWxlYWRpbmcgZmVhdHVyZXMgaW5jbHVkZSBJbnZlblNl
bnNlIG9uLWNoaXAgQVBFWCBNb3Rpb24NCj4+ICsgIFByb2Nlc3NpbmcgZW5naW5lIGZvciBnZXN0
dXJlIHJlY29nbml0aW9uLCBhY3Rpdml0eSBjbGFzc2lmaWNhdGlvbiwgYW5kDQo+PiArICBwZWRv
bWV0ZXIsIGFsb25nIHdpdGggcHJvZ3JhbW1hYmxlIGRpZ2l0YWwgZmlsdGVycywgYW5kIGFuIGVt
YmVkZGVkDQo+PiArICB0ZW1wZXJhdHVyZSBzZW5zb3IuDQo+PiArDQo+PiArICBodHRwczovL2lu
dmVuc2Vuc2UudGRrLmNvbS93cC1jb250ZW50L3VwbG9hZHMvZG9jdW1lbnRhdGlvbi9EUy0wMDA1
NzZfSUNNLTQ1NjA1LnBkZiANCj4+ICsNCj4+ICtwcm9wZXJ0aWVzOg0KPj4gKyAgY29tcGF0aWJs
ZToNCj4+ICsgICAgZW51bToNCj4+ICsgICAgICAtIGludmVuc2Vuc2UsaWNtNDU2MDUNCj4+ICsg
ICAgICAtIGludmVuc2Vuc2UsaWNtNDU2MDYNCj4+ICsgICAgICAtIGludmVuc2Vuc2UsaWNtNDU2
MDgNCj4+ICsgICAgICAtIGludmVuc2Vuc2UsaWNtNDU2MzQNCj4+ICsgICAgICAtIGludmVuc2Vu
c2UsaWNtNDU2ODYNCj4+ICsgICAgICAtIGludmVuc2Vuc2UsaWNtNDU2ODcNCj4+ICsgICAgICAt
IGludmVuc2Vuc2UsaWNtNDU2ODhwDQo+PiArICAgICAgLSBpbnZlbnNlbnNlLGljbTQ1Njg5DQo+
PiArDQo+PiArICByZWc6DQo+PiArICAgIG1heEl0ZW1zOiAxDQo+PiArDQo+PiArICBpbnRlcnJ1
cHRzOg0KPj4gKyAgICBtaW5JdGVtczogMQ0KPj4gKyAgICBtYXhJdGVtczogMg0KPj4gKw0KPj4g
KyAgaW50ZXJydXB0LW5hbWVzOg0KPj4gKyAgICBtaW5JdGVtczogMQ0KPj4gKyAgICBtYXhJdGVt
czogMg0KPj4gKyAgICBpdGVtczoNCj4+ICsgICAgICBlbnVtOg0KPj4gKyAgICAgICAgLSBJTlQx
DQo+PiArICAgICAgICAtIElOVDINCj4+ICsgICAgZGVzY3JpcHRpb246IENob29zZSBjaGlwIGlu
dGVycnVwdCBwaW4gdG8gYmUgdXNlZCBhcyBpbnRlcnJ1cHQgaW5wdXQuDQo+PiArDQo+PiArICBk
cml2ZS1vcGVuLWRyYWluOg0KPj4gKyAgICB0eXBlOiBib29sZWFuDQo+PiArDQo+PiArICB2ZGQt
c3VwcGx5Og0KPj4gKyAgICBkZXNjcmlwdGlvbjogUmVndWxhdG9yIHRoYXQgcHJvdmlkZXMgcG93
ZXIgdG8gdGhlIHNlbnNvcg0KPj4gKw0KPj4gKyAgdmRkaW8tc3VwcGx5Og0KPj4gKyAgICBkZXNj
cmlwdGlvbjogUmVndWxhdG9yIHRoYXQgcHJvdmlkZXMgcG93ZXIgdG8gdGhlIGJ1cw0KPj4gKw0K
Pj4gKyAgbW91bnQtbWF0cml4Og0KPj4gKyAgICBkZXNjcmlwdGlvbjogYW4gb3B0aW9uYWwgM3gz
IG1vdW50aW5nIHJvdGF0aW9uIG1hdHJpeA0KPj4gKw0KPj4gK3JlcXVpcmVkOg0KPj4gKyAgLSBj
b21wYXRpYmxlDQo+PiArICAtIHJlZw0KPj4gKyAgLSBpbnRlcnJ1cHRzDQo+PiArICAtIGludGVy
cnVwdC1uYW1lcw0KPj4gKw0KPj4gK2FsbE9mOg0KPj4gKyAgLSAkcmVmOiAvc2NoZW1hcy9zcGkv
c3BpLXBlcmlwaGVyYWwtcHJvcHMueWFtbCMNCj4+ICsNCj4+ICt1bmV2YWx1YXRlZFByb3BlcnRp
ZXM6IGZhbHNlDQo+PiArDQo+PiArZXhhbXBsZXM6DQo+PiArICAtIHwNCj4+ICsgICAgI2luY2x1
ZGUgPGR0LWJpbmRpbmdzL2dwaW8vZ3Bpby5oPg0KPj4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGlu
Z3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvaXJxLmg+DQo+PiArICAgIGkyYyB7DQo+PiArICAgICAg
ICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4+ICsgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0K
Pj4gKw0KPj4gKyAgICAgICAgaWNtNDU2MDVANjggew0KPj4gKyAgICAgICAgICAgIGNvbXBhdGli
bGUgPSAiaW52ZW5zZW5zZSxpY200NTYwNSI7DQo+PiArICAgICAgICAgICAgcmVnID0gPDB4Njg+
Ow0KPj4gKyAgICAgICAgICAgIGludGVycnVwdC1wYXJlbnQgPSA8JmdwaW8yPjsNCj4+ICsgICAg
ICAgICAgICBpbnRlcnJ1cHQtbmFtZXMgPSAiSU5UMSI7DQo+PiArICAgICAgICAgICAgaW50ZXJy
dXB0cyA9IDw3IElSUV9UWVBFX0VER0VfUklTSU5HPjsNCj4+ICsgICAgICAgICAgICB2ZGQtc3Vw
cGx5ID0gPCZ2ZGQ+Ow0KPj4gKyAgICAgICAgICAgIHZkZGlvLXN1cHBseSA9IDwmdmRkaW8+Ow0K
Pj4gKyAgICAgICAgICAgIG1vdW50LW1hdHJpeCA9ICIwIiwgIi0xIiwgIjAiLA0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICIxIiwgIjAiLCAiMCIsDQo+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIjAiLCAiMCIsICIxIjsNCj4+ICsgICAgICAgIH07DQo+PiArICAgIH07DQo+
PiArICAtIHwNCj4+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2dwaW8vZ3Bpby5oPg0KPj4g
KyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvaXJxLmg+DQo+
PiArICAgIHNwaSB7DQo+PiArICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4+ICsgICAg
ICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPj4gKw0KPj4gKyAgICAgICAgaWNtNDU2MDVAMCB7DQo+
PiArICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJpbnZlbnNlbnNlLGljbTQ1NjA1IjsNCj4+ICsg
ICAgICAgICAgICByZWcgPSA8MD47DQo+PiArICAgICAgICAgICAgc3BpLW1heC1mcmVxdWVuY3kg
PSA8MjQwMDAwMDA+Ow0KPj4gKyAgICAgICAgICAgIGludGVycnVwdC1wYXJlbnQgPSA8JmdwaW8x
PjsNCj4+ICsgICAgICAgICAgICBpbnRlcnJ1cHQtbmFtZXMgPSAiSU5UMSI7DQo+PiArICAgICAg
ICAgICAgaW50ZXJydXB0cyA9IDw2IElSUV9UWVBFX0VER0VfUklTSU5HPjsNCj4+ICsgICAgICAg
ICAgICB2ZGQtc3VwcGx5ID0gPCZ2ZGQ+Ow0KPj4gKyAgICAgICAgICAgIHZkZGlvLXN1cHBseSA9
IDwmdmRkaW8+Ow0KPj4gKyAgICAgICAgICAgIG1vdW50LW1hdHJpeCA9ICIwIiwgIi0xIiwgIjAi
LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICIxIiwgIjAiLCAiMCIsDQo+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIjAiLCAiMCIsICIxIjsNCj4+ICsgICAgICAgIH07DQo+
PiArICAgIH07DQo+PiArICAtIHwNCj4+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2dwaW8v
Z3Bpby5oPg0KPj4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xs
ZXIvaXJxLmg+DQo+PiArICAgIGkzYyB7DQo+PiArICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwz
PjsNCj4+ICsgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPj4gKw0KPj4gKyAgICAgICAgaWNt
NDU2MDZANjgsNDZBMDAwMDAwODQgew0KPj4gKyAgICAgICAgICAgIHJlZyA9IDwweDY4IDB4NDZB
IDB4ODQ+Ow0KPj4gKyAgICAgICAgICAgIGludGVycnVwdC1wYXJlbnQgPSA8JmdwaW8xPjsNCj4+
ICsgICAgICAgICAgICBpbnRlcnJ1cHQtbmFtZXMgPSAiSU5UMSI7DQo+PiArICAgICAgICAgICAg
aW50ZXJydXB0cyA9IDw1IElSUV9UWVBFX0VER0VfUklTSU5HPjsNCj4+ICsgICAgICAgICAgICB2
ZGQtc3VwcGx5ID0gPCZ2ZGQ+Ow0KPj4gKyAgICAgICAgICAgIHZkZGlvLXN1cHBseSA9IDwmdmRk
aW8+Ow0KPj4gKyAgICAgICAgICAgIG1vdW50LW1hdHJpeCA9ICIwIiwgIi0xIiwgIjAiLA0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICIxIiwgIjAiLCAiMCIsDQo+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIjAiLCAiMCIsICIxIjsNCj4+ICsgICAgICAgIH07DQo+PiArICAg
IH07DQo+DQo+SSBkb24ndCB0aGluayB3ZSBuZWVkIDMgZXhhbXBsZXMganVzdCBmb3IgZGlmZmVy
ZW50IGJ1c2VzIGJlaW5nIHRoZSBvbmx5IA0KPmRpZmYuDQo+DQo+Um9iDQo+DQpIZWxsbyBSb2Is
DQoNClRoYW5rcyBmb3IgeW91ciBmZWVkYmFjaywgSSB3aWxsIHNpbXBsaWZ5IGl0IHRoZW4uDQoN
ClJlbWkNCg==

