Return-Path: <linux-iio+bounces-23050-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D364B2DE15
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 15:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AA5B1C8212C
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 13:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9857A3218C5;
	Wed, 20 Aug 2025 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="pTTeGUK6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A313203AF;
	Wed, 20 Aug 2025 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696877; cv=fail; b=tDuN+hU2t99XEB9Bwo6C3S4q8+StXOp0aoRZjVQMIEzBIv5Snr1nB0bZnKDNIJEy37zIQ2OBJMghBv3yQiBu0gTAWOUejExGK6zQ/2cJSNnL8IMbI8NSP5/PhL4+i5uJC25/HcuWmBD3B9FdHlh19/qTZf87sM2Y3al5yfbcsOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696877; c=relaxed/simple;
	bh=rO7h4IvFuZARXNkDSKOkE5eqz1QqlEpz8v3mHmCfKhA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WquHEoDPVY/L3MbXM6ZQCFxyvw7a6j6LXoTdmNNhPoPLaLJ1sxZ37XqDT4NoDRhJKbjXiBieXeHcaP/ixk4YGGxJHAUin1el4BtEt/OhBP6t1nsf6REK6jLQLRTU1sYNj86UmaP9/hkN3LfjFvw03TElP23KSDmdu5RhSq59ZUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=pTTeGUK6; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K2mjM3001042;
	Wed, 20 Aug 2025 13:34:17 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazon11012035.outbound.protection.outlook.com [40.107.149.35])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 48n5w3gfwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 13:34:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMFqAeUWzcEsI746LGh13hD6lgASV4+rIeEJtLddRxGINX45D2B34mdCbaw+jSd/tqBChTMPwU42lgn8mIqNB5BjO5Bkt7maZf2F2/TBOOCd6/jF7JpyjyBXdW0pqY49ZeIOwCfWqiuV4M1YjikZ/Nmkoh0F6cjmiLIFe8f1CkUmSnzLkU3r74AiLuJlBZdWub1iE7brkTbjAMbVxMpuxjDDOxDqmiTRVDRDRekJ+0bAdhf6X+SX1KEeRpwFYUV2N4tgCKeJiujPJyKjTq3vY+UDqdUe+I5kVfSzomiTG9wnZ6yiG0vEp2AqsqL6XQyDwRLuW3ny67CN69M9ofj6ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rO7h4IvFuZARXNkDSKOkE5eqz1QqlEpz8v3mHmCfKhA=;
 b=XAUJuCSkf9Z+olY66TEoBCcqk9uRFLkZqzLNFjiLs3KkbfpC2t3iV/2OGPmwUn/VAwJBEbduMMjTYd9TOSYXGnhqcHpJ9GR89fpIuj5JojdRDdYl6GC+7xlVinliw4n1JM+edSr0tdeUYPCYTuBlV11kd64T4hFW5Yj3nVqRyT2zAOKocxMCsOfvE5Z1LnI9Js8OpBNjAULAu9Svpqbih2e/TjVZpcvb0ItfLruhYLVteS64BHqOf1etgZcwAqado6lx5sRi10WZeCt44uNZlaXXjWFoRLeJjTR3y9M6AgajPEQA/NZKjI4ckuFTiBcMPVcUf1Om7o1H8hLYVVaifg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rO7h4IvFuZARXNkDSKOkE5eqz1QqlEpz8v3mHmCfKhA=;
 b=pTTeGUK6g/nRCT2qQi0ic5IK9HzcA4w0/mLdpYhbUj6pqf2e6+1HVenpQctdN1Fl9sCmtMQL0dkQXlpQg5mODcfcgNw0Q6UopYQHftzxp2c/EmgQHPd5d4t1P/SdgJOksIqZPRK1fP3aZIN1dVAdABBcH2g31IriVF2Q/kj5cbQhpiDDW3csIr8duBGG43UdM5RV8y6BWqBf4Ko0VmqOx9dqtZJnF26gkUxOGDbaa4hwu55EivuXLET6iY66yAga+zRRcH8b/SdN5eRxiloZ0V2plC0EdcQsMr4EOttrPUKM4FrjOfgAjBgm5JUZge3rdc/zy/RSpBTiXeECEqFEHg==
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::2d)
 by FR1PPF02B622B6B.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18::f08) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 13:34:10 +0000
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf]) by FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf%3]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 13:34:09 +0000
From: Remi Buisson <Remi.Buisson@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 3/8] iio: imu: inv_icm45600: add buffer support in iio
 devices
Thread-Topic: [PATCH v2 3/8] iio: imu: inv_icm45600: add buffer support in iio
 devices
Thread-Index: AQHb8XjECIeifwDmKkyANxbmF82mMLQ2bKIAgCcl3vCAB8kvgIAEzksQ
Date: Wed, 20 Aug 2025 13:34:09 +0000
Message-ID:
 <FR2PPF4571F02BC178BD74B06CAAD14FFB08C33A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <20250710-add_newport_driver-v2-0-bf76d8142ef2@tdk.com>
	<20250710-add_newport_driver-v2-3-bf76d8142ef2@tdk.com>
	<20250717153340.33eb92b4@jic23-huawei>
	<FR2PPF4571F02BCAEF9767DFCEAC0031CB08C28A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
 <20250816121713.48c01e62@jic23-huawei>
In-Reply-To: <20250816121713.48c01e62@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2PPF4571F02BC:EE_|FR1PPF02B622B6B:EE_
x-ms-office365-filtering-correlation-id: 9be207a8-0696-41ee-0e5f-08dddfee3e0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|19092799006|10070799003|1800799024|38070700018|3613699012;
x-microsoft-antispam-message-info:
 =?utf-8?B?Nk55TU1SekxWWlZ1MGI2SFhiNUJMakhIZGlRdXIzUjZXelBDaGRxSkhaY0tE?=
 =?utf-8?B?TDMvc3RlR1J3WDVObnlNNHU3MDZnQzVqcEw0WDE2c1BqVU1RazV4UVVabVBK?=
 =?utf-8?B?Lzdpb2I1VjVleCtoeTVocE9iYWdMWWVVRUF1ZW5zZFhHNVVvKzhHSDJDcmJE?=
 =?utf-8?B?eHNJRGN0L3NMUUd5NlpmbUVCdTIxQVZVWnZmV05jRFkwWWZGbXQ4emdMdGhX?=
 =?utf-8?B?aVU0eUlMbWhDU3hLd1ZYZ0pibEhYMWx2SElkTVA3a3lvTU8vQ2dCazBpUTZ1?=
 =?utf-8?B?T0R1ZXllV3B1MklDVlNWS25Hc2pBNzJoaC9KV2JKd3dRc0ErNjRQRTMvVGJ4?=
 =?utf-8?B?Rm9tUXJOS3ZRSHlQaGEveUppN2xrM01rVEt3Y1l3TDJ4QUVBczdKOVFHQ3FT?=
 =?utf-8?B?WTdNcU13ZTNOM2g2cEdNVzBnUkhqOWhseitRSHA1SmxYRUZFUS9yTVFOeWcr?=
 =?utf-8?B?UDFnRTZ6ZDJ0dXdFYnhzMzlwb0VWcWlOc1FCeERPL0xNb3V4RmpiTEJmcUxK?=
 =?utf-8?B?L09PYjRpY21SNlNRV3VWQXJMVngzVkJUUTJESmZOd0o4aXhEcmI2UXhDUnN4?=
 =?utf-8?B?QjFVZjZSSUgramVibzY1RGhTQzNGTXRKWlpzdkxGUVFNZDhPVUtpeWZkRGhj?=
 =?utf-8?B?bkN2b0xRdVV1QXppdzJzTi9tWGxia3RTY1BNWU9pbllWZjFBTkpubUpJdFY2?=
 =?utf-8?B?dm5aS2lmaURnTFRIUHZLNlRkZXlYbVlieHRDdkZJLzBCbStYYVJlTXBLRnJk?=
 =?utf-8?B?UlNNM0F5SitPOVpxNEtlYzBtWWQ3Z2QwZWRIbDdYUEl5bEVseWdiamVIZTJP?=
 =?utf-8?B?Q2liZ3hMbVhMT3VjT213SGUva0JTMEJFOXlTUGdpcjRwVXBrTUZDLy8xbE5a?=
 =?utf-8?B?TGZoOHZDbnNidmk2eWtXS0FkRFdYS0xzUWNEWnk1TVNxNTh6RTZuUXFOVXFW?=
 =?utf-8?B?TDRMcmhHZTFBeUhBQzVob0FBeHJUbmMrY0p1NkpQTXNoRDRPckhmclN1WHRn?=
 =?utf-8?B?czljQUNsWDl4ck4wVHVjL0twaU1hUDRwd1pVS2tOVVVLdVplS0dVeEtDc3J1?=
 =?utf-8?B?Y0RBRTMwbzhQRkhlWHg2bjJnZUNTU1VId2RwWWozN1crUUk4SDFIQmRlQ3BG?=
 =?utf-8?B?SThLV1ZLdEMrN0JDMlRScHIyTlREVUgxZGFmWit4Mm1oMUgrNjRMQXNHTHYz?=
 =?utf-8?B?L09uSklpREtjTmE1aUlDa2VVR3NEMUxuUy9wbjFZWTd6NVc3eEJLNi9sWHlO?=
 =?utf-8?B?UHEzY2tCT2dXcDZYVCthY1RqR2RNei9jTjV4RkxYa2gxbElxVGxrcmdNcFNY?=
 =?utf-8?B?dXdHVmtrLzFycGo1WDl2c3lRUE1lSjI1N1hMOXFtVnFNSFJzdEZPNHYyb0xv?=
 =?utf-8?B?SzRMT2dQMllEM3piVDVobWtNM1p1R1JqcXNvMmFrWXE5VHUwUks4NjNKdFp5?=
 =?utf-8?B?ckdmdzZpMmdjVFROeWFQakUxTU9VN2VhS1pVbkx2RmdLc2s5NFUydjZQRGVK?=
 =?utf-8?B?ZnU2a292RjJkNXhDWGg3WEdCQTFrTE52ZmxuUngyOUFvbHFRUkhNN1l1dlZZ?=
 =?utf-8?B?Zm5ZelJzbWxmUm5Ed1FBNE9rZ2ltNHphclVCQTdQbHBhRHNPYjlqQmh6ZDh1?=
 =?utf-8?B?Uy9DaG5ITFc1bEJ2V0pyYU5ENEY0ek54N0ZPTFdaOStMSnlKSnZ5WkU5eXVr?=
 =?utf-8?B?YXp3b1lHUHAvN2k3cUJSOWtxQWFzYkRUeDlkL0FRNHZQeVZROCtmKzVPMkJa?=
 =?utf-8?B?c1c3SHBodFFaUjVTRkd0Mk1tUDB2K1Yvblk2dFdjSDZ6WkQ4K09wSGhBUEJW?=
 =?utf-8?B?dlRRd1h2UXZKeFIzQ0g4L2ovcUdpczVUaDFpM0ZpK3dXZ3RVU3dPM2s3Wk43?=
 =?utf-8?B?SlgwVWFaZGZvejkwR2xlSldWTGdSREtqU2dtaVlLRENMNlB0NTI3MVV0Z3JB?=
 =?utf-8?B?dUI5bEFKSy9wbENHR1h1SThIRDdGbnRVcWxYR2pGSlo3V2F0WGtPTThKK3M4?=
 =?utf-8?B?QnpYdk9jUG83bXJ4TTNpcldSd3hWMkgvdTZCVHBLenloaFlwY2FpcFRvMVBk?=
 =?utf-8?Q?swmDLG?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(19092799006)(10070799003)(1800799024)(38070700018)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z3hCK3V5Tlh0YmtvaVM4YTFnMWw3TXl3dUxrSnF0Y0dueFF5T2YxcW5Sc3cz?=
 =?utf-8?B?MTJsY2tncTRUSEdiRHRoSkt1YmRzaUNTMzZsYXdibyswMFliU0ZsNmt0UlVO?=
 =?utf-8?B?Y0ZkTDJnbHVUVG9PV2kyUHJkdk4vZ3Y5QW5UNnVYRlhqUCtjd1lkTTduWEJJ?=
 =?utf-8?B?N2ZwejMyb0hDUGVtSTh1ZUs0T0FqK1J0eXBRMkhVSENWWFdYTC9iOUFQdmJm?=
 =?utf-8?B?SmhBcjE1VmZ1TG9LbDYwaVFGRndnN0NWb1lUdmxtUld3QlRtckF3OWxHbElU?=
 =?utf-8?B?YTRxejlHVHdaUng1cThzRlowZXZZdFpPY0I2ZjhJa0ZVQnVObmUwTXBsRUEv?=
 =?utf-8?B?OWxTalNybmYvalZGUGdJTUhIZXB4STFyT2FNVjhuZlZYVzZhMjZLeDZmSXN4?=
 =?utf-8?B?MHcrSVU3RWZwa1RyZWJPd241VVpMZFRSMHlya3RRV0NIcEQwT2o1YU14SzBp?=
 =?utf-8?B?N05rdzFYMkJxa2lCVFJyWkd0VVgwOUFFOUEzV2kvM2xLSm1BTGdIbHRzTE0z?=
 =?utf-8?B?b1Nhc01nRWFEekhVTFNwc0xEaXhIZ0dMUkx5WDBsR1A3c2VBeC9ZakNBOGRF?=
 =?utf-8?B?cUIvSVdoZXFYb2QxazMxUk43SDZnOGY4Wmxhck95MHBSSjlJU1p4WU12M2pO?=
 =?utf-8?B?UmQzMEQ5M1NxMFJ1Yk4vK2syMmRLU2tOdzFST1Y1UFNaeGltU2Y1Ym9HalI0?=
 =?utf-8?B?dW5qcUVDTnE2VzltOFFqZWZmUE50OFdBemx5L1BoK3MvODRxaU85RHB2WFMv?=
 =?utf-8?B?NUExNXpKekR2REx6YVA4SEhPYXk4VnBZSlhlZGliemRDZDFGQ2hSQXF3N2M5?=
 =?utf-8?B?K2xGWW9wT2RNZ1hvRzdteWFFeEhrZUZpaXcxRGt5djQ3cVVidUdJZS9CQ1V4?=
 =?utf-8?B?TTYra2VUWC9pQWdkZ010WG8xeWsrSDBuUXNCRTNPMUxVdDhOOUlQbHVFT0NU?=
 =?utf-8?B?NVpISlRwcSsxNzE2bnpzQTR0S2tHYlVnQ1ZFNzBhVjZZdTI0SUNGd3YxNmVT?=
 =?utf-8?B?bmFtZTVCc1R3K0t2U1FiTTZBZEpHRUU5V1hiVERwRUlYc2lDS1FDbTl5cWFL?=
 =?utf-8?B?ZmtTcDMvLzhkdDNvQTZVYS93cWt4VlpzRXFtZzNTTnN1YzM0ZVM4RkdNZ2R0?=
 =?utf-8?B?YmhCWXJWNkx5Q2tMYzFsdGFmQkU0V0VndGNsZGMrMTdmNUc1RTZYOUJTZzVs?=
 =?utf-8?B?R1FuK2RLdnltTVk3aENZeFFzY0QzaDJRVHhuc2U0VEJtMFpXak1nQlI5bGVz?=
 =?utf-8?B?d01adTJMUHZ4VTQ4ZXh1NTdZQnc1VkhVK0E4Y0hjVk0ySnNIaXprYnJKa0hL?=
 =?utf-8?B?cHQyQWVoVkxzMVBQMWwwVXVYWjFMUVJ1aUZ4NDBZVTd2YmFvMnhtWTJZazNq?=
 =?utf-8?B?RkFqT0lUN0gvclYyeWJzNXJXQUhUODJId1ZGR214UmUyczB6K3M1b2psUVAy?=
 =?utf-8?B?WFMvUDZ5ZEEwUEhQNzVXZWsvNXVGQmxmSnNtS1oxRmk4OG53eEhwUzBJVllB?=
 =?utf-8?B?R3RCMWpObFhyaUY1VGd4NzhHZWt1b3dBN1FuV21qcmtRTjFKRUFRS0xvTmtI?=
 =?utf-8?B?VFBmT29SbTYzSWMrM1RzZkI0WTc3Z05vS1o4NlVFVk04R2ZUbXM1MGRGT0RC?=
 =?utf-8?B?TnlucW02cFp0NmFkT21LNmZQZ2lBc3hBUlpRU0JzVTZtQUgvOGdNd2YwMGw5?=
 =?utf-8?B?TmkveFNIalIreUxRY1R3SEdmaVUxVzB5b3JUVm1UZStDZzFqZDRhamFsdGJO?=
 =?utf-8?B?Zlo2czNRRUdMZ3FGTnhHZVRhRVowNE9QeE9iejVxbVBGVWRPUUtHTlV4emxu?=
 =?utf-8?B?VjhVdlZmVmRtOFJ0cTNFcHl2ZTU1bmNadmFTdXFIdDR0Mno0ckxtV2dIaFQ1?=
 =?utf-8?B?dk56TWE0VHJGdHlHaG5OZ0RtQTRzMnBzNGJIWDNFVng1YjFHUFVuOFNiVEl4?=
 =?utf-8?B?bzVlQjd3N0lIRWxRNC94cU5oUWZHOXJ2Z2x0dHBObUlzeUZWazRReVU3bWRN?=
 =?utf-8?B?cnlzUzMxTVhRU1JzM0I0Ymd5RFV1Q1dvY3VYc3dkaVlNd1VRSzhxSXFNOC8x?=
 =?utf-8?B?dTRoU1BrL0VESlEvSXp4cU80OCs2NWoyVE5wZmp0M1VXRVgxWmQ3UllHT2F3?=
 =?utf-8?B?aEZrQmppS2QvNUFmVnM5TU1jaStlYW1oZGdDNXY0MnQwOHV4S3MzWGc5dUNQ?=
 =?utf-8?Q?V9WcdLGcgwepU3426+77447qWPKHyNAk4zgH06EgO/Ef?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be207a8-0696-41ee-0e5f-08dddfee3e0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 13:34:09.2457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q70kCQGONQMVi1WwEm1LgKOI2gONIIsGDEldE8Wf9+9vvm8CKrMJ5zFkBC7g3yQxxHutcGoUAbL/FEcBnFyn9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR1PPF02B622B6B
X-Proofpoint-ORIG-GUID: 1CuhLypO16QZHPKqBEGQQdrVnSUmFl0Q
X-Proofpoint-GUID: 1CuhLypO16QZHPKqBEGQQdrVnSUmFl0Q
X-Authority-Analysis: v=2.4 cv=Vvp6w+2n c=1 sm=1 tr=0 ts=68a5ced8 cx=c_pps
 a=/XU0EaMXzvVpd7Nc14VS2A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=Uwzcpa5oeQwA:10 a=VwQbUJbxAAAA:8 a=In8RU02eAAAA:8
 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=X_oTgjVYoaOp1vFqp64A:9 a=QEXdDO2ut3YA:10
 a=EFfWL0t1EGez1ldKSZgj:22 a=IawgGOuG5U0WyFbmm1f5:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAyMiBTYWx0ZWRfX9BGAOtZDws+L
 88hF5qExjotGDFl3MFxHALe0WqnW1D87Ijci7y2f3oyg2yQDE5otiEP8PVSny/7Gtb4LoAW6MfL
 CUTl2P0TXHMha0lBH0Z/QPUKiP1tx9j6ego5fZ/CAoVGrxwNawPEOHGmCvQN3BK1DwpcCkUSXQV
 9jfoudTuzyA/J1eUD6isgUR+qa5bagRVKXYYjdiAg5MIim6ahmH0pnaU6okWthVfylWV3lzLQab
 gjtowUVHxFNcWGM0iqQhEnTwkU+VPV36c6Cad4jLyqSLSzN5loteOBWeXBtamkQ8NpomMKpg0NX
 FalATpew5mZfCJlbj7Xh5MlFu1dMsvOOd2Rc6Ch6hPfc8Il5VN0UvMbK1XYTVNyXcZ1h3X2kf+e
 aWyqDYsbwXjy0RdqzXGeTYqf+EjL9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_04,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200022

ID4NCj4NCj5Gcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPiANCj5TZW50
OiBTYXR1cmRheSwgQXVndXN0IDE2LCAyMDI1IDE6MTcgUE0NCj5UbzogUmVtaSBCdWlzc29uIDxS
ZW1pLkJ1aXNzb25AdGRrLmNvbT4NCj5DYzogUmVtaSBCdWlzc29uIHZpYSBCNCBSZWxheSA8ZGV2
bnVsbCtyZW1pLmJ1aXNzb24udGRrLmNvbUBrZXJuZWwub3JnPjsgRGF2aWQgTGVjaG5lciA8ZGxl
Y2huZXJAYmF5bGlicmUuY29tPjsgTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT47IEFuZHkg
U2hldmNoZW5rbyA8YW5keUBrZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9y
Zz47IEtyenlzenRvZiBLb3psb3dza2kgPGtyemsrZHRAa2VybmVsLm9yZz47IENvbm9yIERvb2xl
eSA8Y29ub3IrZHRAa2VybmVsLm9yZz47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+U3Vi
amVjdDogUmU6IFtQQVRDSCB2MiAzLzhdIGlpbzogaW11OiBpbnZfaWNtNDU2MDA6IGFkZCBidWZm
ZXIgc3VwcG9ydCBpbiBpaW8gZGV2aWNlcw0KPg0KPk9uIE1vbiwgMTEgQXVnIDIwMjUgMTQ64oCK
MTM64oCKNTQgKzAwMDAgUmVtaSBCdWlzc29uIDxSZW1pLuKAikJ1aXNzb25A4oCKdGRrLuKAimNv
bT4gd3JvdGU6ID4gPiA+ID4gPiA+RnJvbTogSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNA4oCKa2Vy
bmVsLuKAim9yZz4gPiA+U2VudDogVGh1cnNkYXksIEp1bHkgMTcsIDIwMjUgNDrigIozNCBQTSA+
ID5UbzogUmVtaSBCdWlzc29uIHZpYSBCNA0KPk9uIE1vbiwgMTEgQXVnIDIwMjUgMTQ6MTM6NTQg
KzAwMDANCj5SZW1pIEJ1aXNzb24gPFJlbWkuQnVpc3NvbkB0ZGsuY29tPiB3cm90ZToNCj4NCj4+
ID4NCj4+ID4NCj4+ID5Gcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPiAN
Cj4+ID5TZW50OiBUaHVyc2RheSwgSnVseSAxNywgMjAyNSA0OjM0IFBNDQo+PiA+VG86IFJlbWkg
QnVpc3NvbiB2aWEgQjQgUmVsYXkgPGRldm51bGwrcmVtaS5idWlzc29uLnRkay5jb21Aa2VybmVs
Lm9yZz4NCj4+ID5DYzogUmVtaSBCdWlzc29uIDxSZW1pLkJ1aXNzb25AdGRrLmNvbT47IERhdmlk
IExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT47IE51bm8gU8OhIDxudW5vLnNhQGFuYWxv
Zy5jb20+OyBBbmR5IFNoZXZjaGVua28gPGFuZHlAa2VybmVsLm9yZz47IFJvYiBIZXJyaW5nIDxy
b2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+
OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZw0KPj4gPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMy84XSBpaW86IGltdTogaW52X2lj
bTQ1NjAwOiBhZGQgYnVmZmVyIHN1cHBvcnQgaW4gaWlvIGRldmljZXMNCj4+ID5PbiBUaHUsIDEw
IEp1bCAyMDI1IDA4OjU3OjU4ICswMDAwDQo+PiA+UmVtaSBCdWlzc29uIHZpYSBCNCBSZWxheSA8
ZGV2bnVsbCtyZW1pLmJ1aXNzb24udGRrLmNvbUBrZXJuZWwub3JnPiB3cm90ZToNCj4+ID4gIA0K
Pj4gPj4gRnJvbTogUmVtaSBCdWlzc29uIDxyZW1pLmJ1aXNzb25AdGRrLmNvbT4NCj4+ID4+IA0K
Pj4gPj4gQWRkIEZJRk8gY29udHJvbCBmdW5jdGlvbnMuDQo+PiA+PiBTdXBwb3J0IGh3ZmlmbyB3
YXRlcm1hcmsgYnkgbXVsdGlwbGV4aW5nIGd5cm8gYW5kIGFjY2VsIHNldHRpbmdzLg0KPj4gPj4g
U3VwcG9ydCBod2ZpZm8gZmx1c2guDQo+PiA+PiANCj4+ID4+IFNpZ25lZC1vZmYtYnk6IFJlbWkg
QnVpc3NvbiA8cmVtaS5idWlzc29uQHRkay5jb20+ICANCj4+ID5IaSBSZW1pLA0KPj4gPg0KPj4g
PlNvcnJ5IGZvciBkZWxheSAtIGhlY3RpYyB3ZWVrLg0KPj4gPg0KPj4gPkpvbmF0aGFuICANCj4+
IE5vIHByb2JsZW0sIHRoYW5rcyBmb3IgdGhlIHJldmlldyAhIChhbmQgc29ycnkgZm9yIG15IGxh
dGUgcmVwbHkpDQo+PiA+ICANCj4+ID4+IC0tLQ0KPj4gPj4gIGRyaXZlcnMvaWlvL2ltdS9pbnZf
aWNtNDU2MDAvTWFrZWZpbGUgICAgICAgICAgICAgIHwgICAxICsNCj4+ID4+ICBkcml2ZXJzL2lp
by9pbXUvaW52X2ljbTQ1NjAwL2ludl9pY200NTYwMC5oICAgICAgICB8ICAgNCArDQo+PiA+PiAg
ZHJpdmVycy9paW8vaW11L2ludl9pY200NTYwMC9pbnZfaWNtNDU2MDBfYnVmZmVyLmMgfCA1MTQg
KysrKysrKysrKysrKysrKysrKysrDQo+PiA+PiAgZHJpdmVycy9paW8vaW11L2ludl9pY200NTYw
MC9pbnZfaWNtNDU2MDBfYnVmZmVyLmggfCAgOTkgKysrKw0KPj4gPj4gIGRyaXZlcnMvaWlvL2lt
dS9pbnZfaWNtNDU2MDAvaW52X2ljbTQ1NjAwX2NvcmUuYyAgIHwgMTM3ICsrKysrLSAgDQo+PiA+
V2UgdXNlZCB0byBkbyB0aGUgYnVmZmVyIC8gY29yZSBzcGxpdCBhIGxvdCBidXQgaXQgb2Z0ZW4g
ZW5kcyB1cCBtb3JlIHRyb3VibGUNCj4+ID50aGF0IGl0IGlzIHdvcnRoIGFuZCB3ZSBubyBsb25n
ZXIgbWFrZSBidWZmZXIgc3VwcG9ydCBhIGJ1aWxkIHRpbWUgb3B0aW9uICh3aGljaCB3YXMNCj4+
ID53aGF0IG1vdGl2YXRlZCB0aGUgc2VwYXJhdGUgZmlsZXMpICBDb25zaWRlciBob3cgbXVjaCBz
aW1wbGlmaWNhdGlvbiB5b3UnZCBnZXQgYnkgc3F1YXNoaW5nIHRoZW0gaW50bw0KPj4gPm9uZSBm
aWxlLiAgICANCj4+IEkgdW5kZXJzdGFuZCB0aGUgcG9pbnQuDQo+PiBIb3dldmVyIG1lcmdpbmcg
ZmlsZXMgd2lsbCBhbGxvdyB0byByZW1vdmUgNSBsaW5lcyBhdCBtb3N0LA0KPj4gd2hpbGUgdGhl
IGxlbmd0aCBvZiB0aGUgY29yZSBmaWxlIHdpbGwgaW5jcmVhc2UgYSBsb3QuDQo+PiBJJ20gbm90
IHN1cmUgb2YgdGhlIGJlbmVmaXQgaW4gdGhlIGVuZCwgYnV0IA0KPj4gcGxlYXNlIGxldCBtZSBr
bm93IGlmIHlvdSByZWFsbHkgd2FudCBtZSB0byBwcm9jZWVkIHdpdGggdGhlIG1lcmdlLg0KPg0K
Pkl0J3Mgb25seSBhIGNvbWJpbmVkIDEuNWsuIFRoYXQgd291bGQgYmUgZmluZSBldmVuIGlmIHRo
ZSBzYXZpbmdzIGFyZSBmYWlybHkgc21hbGwuDQo+DQo+SXQncyBub3Qgc29tZXRoaW5nIEkgY2Fy
ZSB0aGF0IG11Y2ggYWJvdXQgdGhvdWdoLg0KPg0KPg0KSSdkIHJhdGhlciBrZWVwIGl0IHRoaXMg
d2F5IHRoZW4uDQo+DQo+DQo+DQo+PiA+PiArY29uc3Qgc3RydWN0IGlpb19idWZmZXJfc2V0dXBf
b3BzIGludl9pY200NTYwMF9idWZmZXJfb3BzID0gew0KPj4gPj4gKwkucHJlZW5hYmxlID0gaW52
X2ljbTQ1NjAwX2J1ZmZlcl9wcmVlbmFibGUsDQo+PiA+PiArCS5wb3N0ZW5hYmxlID0gaW52X2lj
bTQ1NjAwX2J1ZmZlcl9wb3N0ZW5hYmxlLA0KPj4gPj4gKwkucHJlZGlzYWJsZSA9IGludl9pY200
NTYwMF9idWZmZXJfcHJlZGlzYWJsZSwNCj4+ID4+ICsJLnBvc3RkaXNhYmxlID0gaW52X2ljbTQ1
NjAwX2J1ZmZlcl9wb3N0ZGlzYWJsZSwNCj4+ID4+ICt9Ow0KPj4gPj4gKw0KPj4gPj4gK2ludCBp
bnZfaWNtNDU2MDBfYnVmZmVyX2ZpZm9fcmVhZChzdHJ1Y3QgaW52X2ljbTQ1NjAwX3N0YXRlICpz
dCwNCj4+ID4+ICsJCQkJICB1bnNpZ25lZCBpbnQgbWF4KSAgDQo+PiA+V2hhdCBpcyBtYXggaGVy
ZT8gIFNlZW1zIHRvIGJlIHBhc3NlZCAwIGluIHRoZSBvbmx5IGNhbGxlci4gIA0KPj4gRnVuY3Rp
b24gY2FsbCB3aXRoIG1heCA+IDAgaXMgaW1wbGVtZW50ZWQgbGF0ZXIgaW4gdGhlIHNhbWUgcGF0
Y2gNCj4+IChpbiA0LzgsIGZyb20gaW52X2ljbTQ1NjAwX2J1ZmZlcl9od2ZpZm9fZmx1c2gpLg0K
Pg0KPk1heWJlIHB1c2ggdGhlIHBhcmFtZXRlciBiZWluZyBpbnRyb2R1Y2VkIHRvIHRoZXIuDQpJ
IHdpbGwgZG8gdGhhdC4NCj4NCj4+ID4+ICt7DQo+PiA+PiArCWNvbnN0IHNzaXplX3QgcGFja2V0
X3NpemUgPSBJTlZfSUNNNDU2MDBfRklGT18yU0VOU09SU19QQUNLRVRfU0laRTsNCj4+ID4+ICsJ
X19sZTE2ICpyYXdfZmlmb19jb3VudDsNCj4+ID4+ICsJc2l6ZV90IGZpZm9fbmIsIGk7DQo+PiA+
PiArCXNzaXplX3Qgc2l6ZTsNCj4+ID4+ICsJY29uc3Qgc3RydWN0IGludl9pY200NTYwMF9maWZv
X3NlbnNvcl9kYXRhICphY2NlbCwgKmd5cm87DQo+PiA+PiArCWNvbnN0IF9fbGUxNiAqdGltZXN0
YW1wOw0KPj4gPj4gKwljb25zdCBzOCAqdGVtcDsNCj4+ID4+ICsJdW5zaWduZWQgaW50IG9kcjsN
Cj4+ID4+ICsJaW50IHJldDsNCj4+ID4+ICsNCj4+ID4+ICsJLyogUmVzZXQgYWxsIHNhbXBsZXMg
Y291bnRlcnMuICovDQo+PiA+PiArCXN0LT5maWZvLmNvdW50ID0gMDsNCj4+ID4+ICsJc3QtPmZp
Zm8ubmIuZ3lybyA9IDA7DQo+PiA+PiArCXN0LT5maWZvLm5iLmFjY2VsID0gMDsNCj4+ID4+ICsJ
c3QtPmZpZm8ubmIudG90YWwgPSAwOw0KPj4gPj4gKw0KPj4gPj4gKwkvKiBSZWFkIEZJRk8gY291
bnQgdmFsdWUuICovDQo+PiA+PiArCXJhd19maWZvX2NvdW50ID0gJnN0LT5idWZmZXIudTE2Ow0K
Pj4gPj4gKwlyZXQgPSByZWdtYXBfYnVsa19yZWFkKHN0LT5tYXAsIElOVl9JQ000NTYwMF9SRUdf
RklGT19DT1VOVCwNCj4+ID4+ICsJCQkgICAgICAgcmF3X2ZpZm9fY291bnQsIHNpemVvZigqcmF3
X2ZpZm9fY291bnQpKTsgIA0KPj4gPg0KPj4gPkZvciBJSU8gZHJpdmVycyBhdCBsZWFzdCB3ZSBz
dGlsbCBvcGVyYXRlZCB1bmRlciBzb21lIGd1aWRhbmNlIHRoZSByZWdtYXAgbWFpbnRhaW5lcg0K
Pj4gPmdhdmUgeWVhcnMgYWdvIHRvIG5ldmVyIGFzc3VtZSByZWdtYXAgKGZvciBidXNzZXMgdGhh
dCBvdGhlcndpc2UgcmVxdWlyZSBETUEgc2FmZQ0KPj4gPmJ1ZmZlcnMpIHdpbGwgYWx3YXlzIGJv
dW5jZSB0aGUgZGF0YS4gIFNvIGJ1bGsgcmVhZHMgd2l0aCBTUEkgYnVmZmVycyBuZWVkDQo+PiA+
RE1BIHNhZmUgYnVmZmVycy4gRWFzaWVzdCBpcyB1c3VhbGx5IGFuIF9fYWxpZ25lZChJSU9fRE1B
X01JTkFMSUdOKSBidWZmZXINCj4+ID4ob3Igc2V0IG9mIGJ1ZmZlcnMpIGF0IHRoZSBlbmQgb2Yg
c3QuDQo+PiA+DQo+PiA+SW4gcHJhY3RpY2UgbGFzdCB0aW1lIEkgY2hlY2tlZCByZWdtYXAgZG9l
c24ndCBib3RoZXIgd2l0aCB0aGUgemVybyBjb3B5DQo+PiA+b3B0aW1pemF0aW9uIHRoYXQgd291
bGQgbmVlZCB0aGlzIHNhZmV0eSBzbyB5b3Ugd29uJ3QgYWN0dWFsbHkgaGl0IHRoaXMNCj4+ID5p
c3N1ZS4gIA0KPj4gRnJvbSBteSB1bmRlcnN0YW5kaW5nLCBhbGlnbm1lbnQgb2YgJnN0LT5idWZm
ZXIudTE2IGlzIGNvcnJlY3QgYmVjYXVzZSB0aGUgdW5pb24gaXMgYWxpZ25lZCwNCj4+IA0KPj4g
CXVuaW9uIHsNCj4+IAkJdTggYnVmZlsyXTsNCj4+IAkJX19sZTE2IHUxNjsNCj4+IAl9IGJ1ZmZl
ciBfX2FsaWduZWQoSUlPX0RNQV9NSU5BTElHTik7DQo+PiANCj4+IFBsZWFzZSBsZXQgbWUga25v
dyBpZiBteSBhbnN3ZXIgaXMgbm90IGNvcnJlY3QuDQo+QWguIEkgcHJvYmFibHkganVzdCBtaXNz
ZWQgdGhhdC4gIGNhbid0IHJlbWVtYmVyIQ0KTm8gcHJvYi4NCj4NCj4+ID4gIA0KPg0K

