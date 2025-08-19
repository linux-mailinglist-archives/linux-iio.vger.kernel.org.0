Return-Path: <linux-iio+bounces-22972-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E32A0B2BECA
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 12:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CC39189D589
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 10:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE31279DA6;
	Tue, 19 Aug 2025 10:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="pwhPFC3M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97C71DED40;
	Tue, 19 Aug 2025 10:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598782; cv=fail; b=APO07AQK/gI5qpNgHKZpDldtVdfHs/+204cERuR1VzBMP7FI7OO8yNkk+vCnhLBuk0gamIYoh6RG78hDY6TI+jzSl2ZPb5sp/l4MgQqKVN438yLyeKpH7SqrqABUCSYzstIoGy5fJ/uAxamLABcgkOTZotOdPxdAxs9KowUBpTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598782; c=relaxed/simple;
	bh=96UQ/tKhn/rqcw1UWQ18JCEJ3prrk2OSkj8TMzXmfkc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pjDXm89tXMZ3Wmo+quyKO7EggRnTLYfbrFVGvB0+jbyQjB76r9zYz9O1Pf7IL3fV8CJXntyYTqNTx7azGEeD5x+6jJxoqrEeska1vOfDwgbcCS3wRB+FwZjADyVKip9Cc+vMUsC3LTq7f+av6rMok+lN7qe/JUs7CnfrgutLsEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=pwhPFC3M; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IMWcgH008537;
	Tue, 19 Aug 2025 10:19:23 GMT
Received: from fr6p281cu001.outbound.protection.outlook.com (mail-germanywestcentralazon11010055.outbound.protection.outlook.com [52.101.171.55])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 48jgc0t40x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 10:19:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIoYM1eK0WmiXbsXSFpZfXqdFhJVM+ZGRRoHuoApByBBXpc5F1mA01G7Cdbz+YzXRcrOyevjOFWnaioV+ZwzUxGq/VhMJfq2/by9u4fdumMc7yrtLEDoDdYxd20VhLn+oPHcD1R31opthzAtKGUhzeTcR065bQyLj/vBBEJEAsHTxU9h5KDFkuDGlFzTKEfNitigdfWKQ5GZi3ZR/6OLRwbyUvw2PNOevA9TpvNB/aN2Mv2PKv4708LKqujrFmzPLt/66lBHFnXMiU3qJ6FliCCo4UjG8zcHTqXNv/C1zXiXoNoR6nFsCvjnKr92jFn7ZD7PchfboYphMudPHsHwTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96UQ/tKhn/rqcw1UWQ18JCEJ3prrk2OSkj8TMzXmfkc=;
 b=OwY8P+MAYTQgowVDgScFdaRa9saJOGICFNUWL+bkRy5mXWVC9NRsveX6g8K3kuCAkrWN92/ZED+0xqgdVOlgiCaB45V2+G66cSjBhTAGVKsfpowYjPC0tyhWx+BoMh/cES2ZDGD6x1QJZTyLlyJp/CDMug7m6ofWm1Cmg3VmsckvQfVL4q2jbvozqVn0yUe60jKsOGixEX/Gmzi3ig819T+P4wssRetGQGfIdQOKE0IN1ud3a+3MYYQEqZfOes5uVu7BQwd7sXFoSZP4afzxhOfPXsZYitJASGK/meRH2qxq1IODyN/xLhxEcP1Uki9sTZ2fZEFOdH3ylxNAd6uoeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96UQ/tKhn/rqcw1UWQ18JCEJ3prrk2OSkj8TMzXmfkc=;
 b=pwhPFC3MZ/3HSe0tzUZsOGKbKsB9K5sTijFC7MUp6FxjcUtNST+BN8PIWXHYpS3io2Ypt1rMjc9M7O/35iV3sJmAVf5MSBgu8/oUF59PSyZsGbHPlOhgi0VFxBsbExJkJAtvfABSLpkKN8WYJBk+jvFDVqXFloUK4vth2gpv+lGcIzela8uAhwsRKKgu0PVQOqrTuJrTzXppc4Z7JSFzVunh/UcfmLF51SBptsFT9+c+32TfnO3eQEGXZ3Yx5CNO5P4lDyxKEh0HfH69mOQ3YEikXqTQhgYvjf5Cmp6Te2qltLD7gQ8lcTFZBUoOulfElIrWOsQHOhGJOHFDiyotSg==
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::2d)
 by BE3P281MB5479.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Tue, 19 Aug
 2025 10:19:15 +0000
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf]) by FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf%3]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 10:19:15 +0000
From: Remi Buisson <Remi.Buisson@tdk.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron
	<jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 1/8] dt-bindings: iio: imu: Add inv_icm45600
Thread-Topic: [PATCH v2 1/8] dt-bindings: iio: imu: Add inv_icm45600
Thread-Index: AQHb8XjGNSzfw0LPWUy8flLtSCneZ7QxIDwAgDjiKMA=
Date: Tue, 19 Aug 2025 10:19:15 +0000
Message-ID:
 <FR2PPF4571F02BC3F610F2D80670B78D7968C30A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <20250710-add_newport_driver-v2-0-bf76d8142ef2@tdk.com>
 <20250710-add_newport_driver-v2-1-bf76d8142ef2@tdk.com>
 <65d7009e-dc4a-44b4-88fe-b5c7e1ecdfc1@kernel.org>
In-Reply-To: <65d7009e-dc4a-44b4-88fe-b5c7e1ecdfc1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2PPF4571F02BC:EE_|BE3P281MB5479:EE_
x-ms-office365-filtering-correlation-id: 7eeeb7c4-df3f-4380-9244-08dddf09d956
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|10070799003|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c25nd2hDV3prSVFZVWwwZ0xpMlFiQndIaUw5Slh2d1F4WWlJSlhES3hiMklk?=
 =?utf-8?B?Znc2b2IvOTFJbFpYK1FxcjFlRWZrK2RITjNod0t1eUhxOThxV2swUUk4dFJQ?=
 =?utf-8?B?eTBHbnNGZnBVN2RnNU5ad1VZZUZSeVY5ZjZqcUxWTlo2U2oxMTlkbGJiRFc1?=
 =?utf-8?B?QnJST05OcWRzY0RrUHJsRlVqTUErV3Rhd3ZlSjVBWncwVlVTdE1UN2JOWFFV?=
 =?utf-8?B?RWl1TzMxUHpXVHRFaUhwdnNvM0dGcEJDM2crMlA1ZktBZ2ZQVS9tZWhhWlhq?=
 =?utf-8?B?MkJXN3ZLQW4xVS9MaVd4QW5QNXZBb09Ua3l5T3dKNkJaRWpuOTVYcEtwN2dY?=
 =?utf-8?B?T2xjUmVyWDNYRmdlRXBVWURTR1Ztb0pRQ1FYeUNqZkN5Y3lZeFRlMk9pa1lQ?=
 =?utf-8?B?c1prdjBKRXB4bmdhZ2M5aTAvdHpDV1IzaUtPaHpuTlo4UmFCMC9CYi96clBl?=
 =?utf-8?B?SWZrU1pBd0VjWVd2c213MjVFc0JjdDdKYjE2c2RCelpxODNxcHY4YjVFcUJY?=
 =?utf-8?B?WU9WbUFMbmtWWG9FVG1PL1FOdXFPQnl2ZklOeW11QmFnSldCNXc5Z1VCK0lU?=
 =?utf-8?B?b2hRTnh5dHlEMnYzTGtSbm42am13SGpoeElhL1Nxd2lja0ZJVC9yWk95azd5?=
 =?utf-8?B?L2NrT2ZCWEhNSEFHaDJRU0dFQ2V5VGJRUlNZbjNxM21aWUkvL3VEeFRxZ3l1?=
 =?utf-8?B?Q1FQSUhiQkxRbGlGQk5FS2YwZU42QUtFMS9Yc2MzeW84VGowaXh0bndrYU1O?=
 =?utf-8?B?WXp5NFVhVkhuTldhcFplWXFBMzJBZHZIU2h1Tm8yRkJ6YUw5QUZFUHIvNHJZ?=
 =?utf-8?B?VzFhRG5wcjFQc0Q0SnE2ZmNUQVB4Z1Z6QkhwSWg0bWF5MVU4alZuUHJwNTc5?=
 =?utf-8?B?K3N3bUNVQ1BJNko0cWFPeCs3dC8zNFlWdnkrdFpLOE9KYnFQSkVZSGYwbUNI?=
 =?utf-8?B?OHNpeFFoV0o5RzJyZUpqZmhHKzJXZ25lMGNTa0VCSmtxVzlnTitOOUJJQXRz?=
 =?utf-8?B?bVcwa3lrYVdiRW91N2ZzUDF4YVd5aWE0a2k1MDZ5VWhJOGtmSnFNaWRVc1lG?=
 =?utf-8?B?QXNNbTAyZ2QwbFV2eEdPTEYxdyttMnVTaVRDcUc2eWY3MVdEdjBHOHJuRWJR?=
 =?utf-8?B?enQ3MmxqeEdoVjBNenRlZ0tBd3hEakl1SnVUT1kzWno4U3pGVlBSTGFtTVc4?=
 =?utf-8?B?SzR2a05wTk5nem5mQllHNi9rTnE1RkFyVzdiV0kveGhDUU82bTVjRnZ0OWJr?=
 =?utf-8?B?cERIWWcwMW55c09YWW56TSs3WXdtSXdjUnRCc3hURGloU0FpOFVhdWhEdTYy?=
 =?utf-8?B?WjBJZ0lteENGMlZYNDFFTTN4czhoR3JxU2JzMm5Ldk9OWnNRSzVVMDM5NnQ3?=
 =?utf-8?B?cnV4ajByMktNdXZMaEsrTThqaEw5ZU9IRDZwNkdhYVJUL053amJ1UHYySmpZ?=
 =?utf-8?B?M0h5YjlhcE5neWlIMEFQQ2xEaFl1OU9jeFk2eVp1dEwvYWhRSkY2ZUkrb3Qz?=
 =?utf-8?B?cURDV3JPRGpXYzJrQjdaYUtjeFVkSGRqckl5WDE1UlBQUzM5blhNOWRjRHBt?=
 =?utf-8?B?UHFKcHRqcFNpdllRMW05NFcyeWMzT1p0VUxJcTJ3SjYzSDJmU3ZVZFFpMmdO?=
 =?utf-8?B?cFd6KzRYNXp2NVh4VVlHOCtrNjRDSWpkNnBTVU44ZVBicC9OM090c2dORHFr?=
 =?utf-8?B?dUUzZGQzZmR5dHhNd0pjTFE5bDh4enpaSXVqTlNBSXcyRzVaN0RSbW5udVFa?=
 =?utf-8?B?MXNjcTUyOEI2QWQxV1FBbk9FYWhrd2RBYjFtRCtBK20rZkErZjV6VnVtZ3pa?=
 =?utf-8?B?NG9rdjNoN3RZRlFoODYwN2FzbHBTVi9Va1RKQ00xazNTZ2hVN1g2dWJpRXNH?=
 =?utf-8?B?OVhGTFBKaWNUbVVXZjUwenFaa0ZZREZoSlFPRVNTSkZBbFRGVnd4L2FSMnEw?=
 =?utf-8?B?bVlJQ1NKYU90K0h1WThtUEJtSXE1RVRTaDE0bGZjMU1CL0dyM2FNQmhlNXRl?=
 =?utf-8?B?angrOTZLcHN3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(10070799003)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bGM1dXI1Y2RWR3A5ZVlHSHJ1WFZ4SXhIN05vbVh1Q0xjS1k0VStvdUIrcmlL?=
 =?utf-8?B?YmdUZG0rMGlMM0cySFYvVDFXRUp6c0NPMWE2eHExaG5OQUFuektFbWdKam5T?=
 =?utf-8?B?SGpYdG1ibXdwQ2pHbUpaRitVU0NaanVZUWNFZXQ1ZGhXWVo1eFM0SmFMQlF1?=
 =?utf-8?B?dktLZjNiRVl0V0VsNm85R0tkSUx1RC9ZUFBYL3lnZ1RCSkRPaE45cHBUYVk1?=
 =?utf-8?B?TVJ4Tit1M1BCaEFiYy9PK0VZQlVlTHFkMkx0RjdoM2QwbWExWFQ0ZjkwVnl6?=
 =?utf-8?B?MjNNWHZSWndVYXYwTTRMT2JVbHF5bWhvcHNud2xUNGF3bG9xVjF1R20wKytz?=
 =?utf-8?B?YXJZMDJjVCt6RjZSaTNGSVp4cE5LMzYveFQyK0I1OXk2ZDIyOFpWVFBmUGZx?=
 =?utf-8?B?YlltNmhveFllRWV5NW85UkJVNS85T2dxd3QxMG9nWHlYQmFDSFBEbEQ5Z3lv?=
 =?utf-8?B?YXo5TVg3cjYxczZYWDB6NXdLQ1pIQmtzd0t3YzdHQnkwU2RWSXdjOFlVQVRt?=
 =?utf-8?B?TVBZVjZrbHNnNUluNk1OUWhCK0FxUHlDQ1BqdGEyeW56QUhrL290Wlk1SkMz?=
 =?utf-8?B?RmdNNk9HVVN5TDd0MzNCMVlhZXIyM0NVVEx0dEdTZTgvU0NvY3VVemtWbWZj?=
 =?utf-8?B?eHBlOW8vMmVDVUh1VElkNnppM1lmZDVHZzArSHRuZDdIelFwby8rUjBHRzF2?=
 =?utf-8?B?bENvUCtGdlB0cmFIWkc4Ung4MEQxRW4vM1gzZTM5UHB0UTNQK2FFUjlUQlpx?=
 =?utf-8?B?Tkk5NUY0dXdJZ2pJTGYzZllaaVYyNWlhd1hBdlB1elFtdVVERWZYRlM4OW4z?=
 =?utf-8?B?N3dON1JGTUZmR0xRcFBYTEFndGZ2ZE03ZTdqTnJLenRnd0pFRTRQSUxTWjk0?=
 =?utf-8?B?M1RMSklZcXdGTmg0L0NPdTVRN1Z3N0FocGJXOHZJQklGV0MxRkNZQUk2dkRx?=
 =?utf-8?B?aVUvbzFlOWNld09tcDVxSUlDUC9oR0FrK0h0WHU2dWQrNk81SU1iMzcxajg4?=
 =?utf-8?B?L1pMbG4yOUV3VVVxeVV3TThNcFVqODlud2V4b2o1bjVSNmRGeG5Ua3h2S3cr?=
 =?utf-8?B?bHVNZ2puaC9tNFliNmw1SzFYMktzMG5obWtsaUQ1c09MK01Mc2FqSWpBYmVx?=
 =?utf-8?B?ZEZUbFh5alJTTGdpV1k2c1lKNk42MWd0Y1dWNlBLYnVLdnJCc0VUTk0vQUtl?=
 =?utf-8?B?R3I1VExMTG0xb2VDZU5EZjZ6ZVpNL1BwbU1iajcweG9mTHJWL0dSc1pxV3pm?=
 =?utf-8?B?eW9zTTFQa1BPL2llRHhVNkJ5aEU2ZVR1dFVOVVcrVS8rMkdFbVV5SHgxbzFX?=
 =?utf-8?B?U2dTZXdES3VZcy9INU8rdzNETzJmbkw4L1FFOGI3dlBDYjV6R2tTNkVLQ0tO?=
 =?utf-8?B?b1Vqek5FdXR4SW8rUUdITVlBRjhIQnFnQUMzOVdSM0pzUVdkM293d241UFZ1?=
 =?utf-8?B?cWMxd3NLblFLd09XbDZsa1hDc0I1bVZWOElUMy9TMVFNVE5Cd1FLYmRhTGhv?=
 =?utf-8?B?Z2dRSDRsZTc1eTh5OG5xQVhUTGNuZUhGb1IrcThVZDVSNzNVbUVyaFVSU3JN?=
 =?utf-8?B?c01od2QrQk9JbFlrTlZJVVVxVExwNk9NeXJGaVhWbVJzNlZ4YklYdnJianI2?=
 =?utf-8?B?RmZYMGpJNGNybUxOTlFvOVF1UUxZZWhzay9WaG9YMTZHTkRBazVFQk9lOHVG?=
 =?utf-8?B?SW1DZ3kxNVcvN0diZkMvSkY0QUF2TEUzZE5wcS9LbjZEeVhtaWQ1VXdrY0xO?=
 =?utf-8?B?Y0VaWE9XZmJkNGd6VHFNRFlFeWx6WHJCV2VvYzE5bGwveWJhQy9tYjZWb0t6?=
 =?utf-8?B?VnplWUpaS1l4WjUrbnBQWlJSS1N4TjdKT0JEUUpCT3F5UkpyNURCeE5taXBZ?=
 =?utf-8?B?Z0swbmxudkhNYUhTdzJFWFdLN3NreitMZ2l4L0FxTExhajJFQ1BLOVh2L2hN?=
 =?utf-8?B?NC9kWjA1QTdTcXpFdlR4bWpCQjJvU2U1ZkV1aXRhQ2RlRFlCd3drT1lNY0t1?=
 =?utf-8?B?NzhpWnRQQnFqbXdvK1RxdDIva0F4a1ZFalV5TmhuN2FIWnRyZnNRcDEwcG1R?=
 =?utf-8?B?Rk9hb2FjSUt0VEliVExPcTdtRUdlSWJET2E3dDFMNFM2bnZLbW55MU9GZmwz?=
 =?utf-8?B?Vm9YdFkzZm0ySmNJMHAycjEyM0VUNUlWRGVOOGc5Rkx1SkRwMmEzcE5ndjcv?=
 =?utf-8?Q?PFaPE13+idTSwWp25lP+CMfgsFufuC3vYTGld6TJLt6Y?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eeeb7c4-df3f-4380-9244-08dddf09d956
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 10:19:15.0258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bzRGYR1d8G3IbXBnhF7Cz10cUTOkKSZ246UZTUAeyDOH9bb1LuVZlB64fvoW7Po1CcUX8Ruri7pYeBqLlZldEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE3P281MB5479
X-Proofpoint-GUID: zy28fiNx4SvBPEs6BkKXVm8QeRdhZnqz
X-Proofpoint-ORIG-GUID: zy28fiNx4SvBPEs6BkKXVm8QeRdhZnqz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAxMyBTYWx0ZWRfXyDzHCKEmSEE1
 VKAPLzOeR/LS13d2cLqNoMJ3suyr0VPp7su+ejKGSaZC1N0Ziu6RfQZW8MqA3cyoSan2f+x3Ki9
 ZFQekV0iNFDML4aIXYRxBNeZ9zfJII2boksF4rtq9oBFh05nJ1m7ri5+RImCBFUXfyLNEGxBQ0/
 eGHz5DYe03NR0KEKWDB0M2PM6c2z5PSx/FNI/x4xWrt8aagTIT5C/WMCdJTWiUKGMlNXCHVf7u/
 QrWMU1ca1i/KBDfSHa1Ks3upnq0kwlBrVn6vKg2y38LWB8QDEKoDP3y3hIphRZGep3S00dlN554
 2xyFHonNHKl2gO/m2IV+4PGzfHsAmkPNcQdpS38WLUcFo6K3j46ufkWn/5vcNw8x37p3DsgqUs8
 /UhAqEM1
X-Authority-Analysis: v=2.4 cv=T/SMT+KQ c=1 sm=1 tr=0 ts=68a44faa cx=c_pps
 a=cCIr5KWHwvvA00yn4QccCg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=Uwzcpa5oeQwA:10 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8
 a=In8RU02eAAAA:8 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=KBUYmHLtMPhMTTC7XvYA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=EFfWL0t1EGez1ldKSZgj:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160013

Pg0KPg0KPkZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4gDQo+U2Vu
dDogTW9uZGF5LCBKdWx5IDE0LCAyMDI1IDc6MzkgQU0NCj5UbzogUmVtaSBCdWlzc29uIDxSZW1p
LkJ1aXNzb25AdGRrLmNvbT47IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+OyBE
YXZpZCBMZWNobmVyIDxkbGVjaG5lckBiYXlsaWJyZS5jb20+OyBOdW5vIFPDoSA8bnVuby5zYUBh
bmFsb2cuY29tPjsgQW5keSBTaGV2Y2hlbmtvIDxhbmR5QGtlcm5lbC5vcmc+OyBSb2IgSGVycmlu
ZyA8cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwu
b3JnPjsgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPg0KPkNjOiBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZw0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS84XSBkdC1iaW5kaW5n
czogaWlvOiBpbXU6IEFkZCBpbnZfaWNtNDU2MDANCj4NCj5PbiAxMC8wNy8yMDI1IDEwOjU3LCBS
ZW1pIEJ1aXNzb24gdmlhIEI0IFJlbGF5IHdyb3RlOg0KPj4gKw0KPj4gKyAgcmVnOg0KPj4gKyAg
ICBtYXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgaW50ZXJydXB0czoNCj4+ICsgICAgbWluSXRlbXM6
IDENCj4+ICsgICAgbWF4SXRlbXM6IDINCj4+ICsNCj4+ICsgIGludGVycnVwdC1uYW1lczoNCj4+
ICsgICAgbWluSXRlbXM6IDENCj4+ICsgICAgbWF4SXRlbXM6IDINCj4+ICsgICAgaXRlbXM6DQo+
PiArICAgICAgZW51bToNCj4+ICsgICAgICAgIC0gSU5UMQ0KPj4gKyAgICAgICAgLSBJTlQyDQo+
DQpIZWxsbyBLcnp5c3p0b2YsDQpDb3VsZCB5b3UgcGxlYXNlIGhlbHAgbWUgdW5kZXJzdGFuZCB0
aGUgcHJvcG9zZWQgc2ltcGxpZmljYXRpb24/DQo+VGhpcyBjYW4gYmUgc2ltcGxlcg0KPg0KPm1p
bkl0ZW1zOiAxDQo+aXRlbXM6DQo+ICAtIGVudW06IFsgaW50MSwgaW50MiBdDQpUaGlzIHNob3Vs
ZCBiZSB0aGUgb25lLWxpbmVkICJvcmlnaW5hbCIgbGlzdC4gDQo+ICAtIGNvbnN0OiBpbnQgMg0K
SSBkb24ndCB1bmRlcnN0YW5kIHdoYXQgdGhpcyAiaW50IDIiIGRvZXMuDQpXaHkgZG8gd2UgbmVl
ZCBhIGNvbnN0IGhlcmUgPw0KPg0KPmFuZCB1c2UgbG93ZXJjYXNlIGFueXdheS4NClN1cmUuDQo+
DQo+PiArICAgIGRlc2NyaXB0aW9uOiBDaG9vc2UgY2hpcCBpbnRlcnJ1cHQgcGluIHRvIGJlIHVz
ZWQgYXMgaW50ZXJydXB0IGlucHV0Lg0KPj4gKw0KPj4gKyAgZHJpdmUtb3Blbi1kcmFpbjoNCj4+
ICsgICAgdHlwZTogYm9vbGVhbg0KPj4gKw0KPj4gKyAgdmRkLXN1cHBseToNCj4+ICsgICAgZGVz
Y3JpcHRpb246IFJlZ3VsYXRvciB0aGF0IHByb3ZpZGVzIHBvd2VyIHRvIHRoZSBzZW5zb3INCj4+
ICsNCj4+ICsgIHZkZGlvLXN1cHBseToNCj4+ICsgICAgZGVzY3JpcHRpb246IFJlZ3VsYXRvciB0
aGF0IHByb3ZpZGVzIHBvd2VyIHRvIHRoZSBidXMNCj4+ICsNCj4+ICsgIG1vdW50LW1hdHJpeDoN
Cj4+ICsgICAgZGVzY3JpcHRpb246IGFuIG9wdGlvbmFsIDN4MyBtb3VudGluZyByb3RhdGlvbiBt
YXRyaXgNCj4+ICsNCj4+ICtyZXF1aXJlZDoNCj4+ICsgIC0gY29tcGF0aWJsZQ0KPj4gKyAgLSBy
ZWcNCj4+ICsgIC0gaW50ZXJydXB0cw0KPj4gKyAgLSBpbnRlcnJ1cHQtbmFtZXMNCj4NCj5NaXNz
aW5nIHN1cHBsaWVzDQo+DQo+PiArDQo+PiArYWxsT2Y6DQo+PiArICAtICRyZWY6IC9zY2hlbWFz
L3NwaS9zcGktcGVyaXBoZXJhbC1wcm9wcy55YW1sIw0KPj4gKw0KPj4gK3VuZXZhbHVhdGVkUHJv
cGVydGllczogZmFsc2UNCj4+ICsNCj4+ICtleGFtcGxlczoNCj4+ICsgIC0gfA0KPj4gKyAgICAj
aW5jbHVkZSA8ZHQtYmluZGluZ3MvZ3Bpby9ncGlvLmg+DQo+PiArICAgICNpbmNsdWRlIDxkdC1i
aW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9pcnEuaD4NCj4+ICsgICAgaTJjIHsNCj4+ICsg
ICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPj4gKyAgICAgICAgI3NpemUtY2VsbHMgPSA8
MD47DQo+PiArDQo+PiArICAgICAgICBpY200NTYwNUA2OCB7DQo+DQo+SXQgZG9lcyBub3QgbG9v
ayBsaWtlIHlvdSB0ZXN0ZWQgdGhlIERUUyBhZ2FpbnN0IGJpbmRpbmdzLiBQbGVhc2UgcnVuDQo+
YG1ha2UgZHRic19jaGVjayBXPTFgIChzZWUNCj5Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvd3JpdGluZy1zY2hlbWEucnN0IG9yDQo+aHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9f
X2h0dHBzOi8vd3d3LmxpbmFyby5vcmcvYmxvZy90aXBzLWFuZC10cmlja3MtZm9yLXZhbGlkYXRp
bmctZGV2aWNldHJlZS1zb3VyY2VzLXdpdGgtdGhlLWRldmljZXRyZWUtc2NoZW1hL19fOyEhRnRy
aHRQc1dEaFo2dHchRHNlNnpJcWdSbVE4bnh6ZG1wQzdVdTk2V0JWd05XYnFsXzRXbmZQd2p1SVNi
YXV2N0dHc0RPMnpTRFRxNFRFelNlYjBzNmZjYm1GUiRbbGluYXJvWy5db3JnXQ0KPmZvciBpbnN0
cnVjdGlvbnMpLg0KPk1heWJlIHlvdSBuZWVkIHRvIHVwZGF0ZSB5b3VyIGR0c2NoZW1hIGFuZCB5
YW1sbGludC4gRG9uJ3QgcmVseSBvbg0KPmRpc3RybyBwYWNrYWdlcyBmb3IgZHRzY2hlbWEgYW5k
IGJlIHN1cmUgeW91IGFyZSB1c2luZyB0aGUgbGF0ZXN0DQo+cmVsZWFzZWQgZHRzY2hlbWEuDQo+
DQo+KHNlZSBob3cgb3RoZXIgYmluZGluZ3Mgb3IgRFRTIGNhbGwgdGhpcyB0eXBlIG9mIGRldmlj
ZSkNCj4NCj4+ICsgICAgICAgICAgICBjb21wYXRpYmxlID0gImludmVuc2Vuc2UsaWNtNDU2MDUi
Ow0KPj4gKyAgICAgICAgICAgIHJlZyA9IDwweDY4PjsNCj4+ICsgICAgICAgICAgICBpbnRlcnJ1
cHQtcGFyZW50ID0gPCZncGlvMj47DQo+PiArICAgICAgICAgICAgaW50ZXJydXB0LW5hbWVzID0g
IklOVDEiOw0KPj4gKyAgICAgICAgICAgIGludGVycnVwdHMgPSA8NyBJUlFfVFlQRV9FREdFX1JJ
U0lORz47DQo+PiArICAgICAgICAgICAgdmRkLXN1cHBseSA9IDwmdmRkPjsNCj4+ICsgICAgICAg
ICAgICB2ZGRpby1zdXBwbHkgPSA8JnZkZGlvPjsNCj4+ICsgICAgICAgICAgICBtb3VudC1tYXRy
aXggPSAiMCIsICItMSIsICIwIiwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAiMSIs
ICIwIiwgIjAiLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICIwIiwgIjAiLCAiMSI7
DQo+PiArICAgICAgICB9Ow0KPkJlc3QgcmVnYXJkcywNCj5Lcnp5c3p0b2YNCj4NCg==

