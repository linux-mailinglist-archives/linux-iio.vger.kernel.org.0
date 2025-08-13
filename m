Return-Path: <linux-iio+bounces-22653-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFCBB246EF
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 12:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3031F189B2F3
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 10:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408931A9F97;
	Wed, 13 Aug 2025 10:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="ATwekXrC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5A9212541;
	Wed, 13 Aug 2025 10:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755079918; cv=fail; b=mQ6f/CBDOo19SsCLXwv/f7yoPOgUbGqo6x9Nme5JNobGJzrHok27QXVMQuWQfLmsjAdsfF28IfyffzLClgiq3oxr92tLo1t50BCaWcx70o0ks3x0Ujnq+KAysOpwXj9PufAq/TLwAYUiPjYth97gErrQ1jhNUanO3ENhcAN5AAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755079918; c=relaxed/simple;
	bh=gGbER7ZBkcC/OR9P0mZupb8Lr2EaTd4k8V48flvKfZ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aGeNx3JrQ4FN5h6+55fF4ewxHI68mHbCT9NNzvF/2IGFrBvFEXnyW1V5AMJCTug3bdK1CeCn8qLEO0RhPoqgN6DK29k6gjtXlU9SHTS6O0zY3p2CzIScmOEYOMwZ1Vhetjt36RVRyByOaBCl1qu67QHFLj/qkSeYXVkK0Tewio8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=ATwekXrC; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D9pjU1032468;
	Wed, 13 Aug 2025 10:11:51 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazon11010031.outbound.protection.outlook.com [52.101.169.31])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 48dvq0jn5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 10:11:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SeYNhrlBWBSew6bEeTOWky4ntAxSaIpK8f+bja++N5zHE6BKh12xl7h5YEqFRnWZYUk/4dtY8tRasd280MXfdG1/BIhWk1bTkhq7LpcVu4wogYSpeP/OnFiPiGPKZ1fNirD9GFf3T6WQduBNAOpenlvYVqK98I4QsUkEu50Lhn/AkMshIibVcexn7QxVQ7wKUzV6XBkdD+Kv8mS1I1XclRUAR6QD26XLIQd7uHu41LYhty3WZzggfiBK6LBGg97kQSv5Sn0VEHLiPfJRRIG2SoBNYk/Ch1QO2AuhD15IxK2FSsYG7ksV5cv2gIrEKI+b7x2jlunEjY0tF7ycU+/7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGbER7ZBkcC/OR9P0mZupb8Lr2EaTd4k8V48flvKfZ8=;
 b=Jv6B2oPSmYi31M7liu/7605ntei/Ze6JfSUBkg4RwjVx+r4DUty9AJGHfWYwq1slLOQ69uPpiC1c+6U7siAdI0pFJUCKm/OBXPRNt6SrJwgIgCGr9rP9NBRkY1zt3l13Ejw52gMeDEs/2cEDk5Js96aEXnU8+moLhVhFJF7B5PYbbzgxWkBWOumU3YPk5qCf4+0Uh516pSQXsKgQAW87A/D9yNPpP5aSnO3hyYlHLpb/jiYiGwYPo/OTAeeP7T0oZKIovIrgYnP1jfTHaVKh0OGL0X7EVr5Hn5UAb6uZ3ZAkfQQhnhytlDmxcPCHjDqky8ldeqnYQuU3zmxx2SxhoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGbER7ZBkcC/OR9P0mZupb8Lr2EaTd4k8V48flvKfZ8=;
 b=ATwekXrC5bqo3G3ogpO3SWTxEe9VnfWlbyFAT6v0xrp4vw0VEGXgjVGQYtJ7U9PKfxn5MTuhu7rjPxl5COiA58WeRkI8Y66mbar8leEYf0XXkWk8owjX/mOYbn9qsAxWVxWChj0vCarnjyaSBlHM5Bi0jKviAK5uk2vjJ/WfuvTYxflPXhQ/36PopYAkwFEiDqXX98TXTU9FiUunwvdOjRX7gV/xfU1mglSp294biqnJn3F/p+smQkEhuIrEagCwxjfSvny6K2pFDX6p9dEhfx0iJOEGRrLla7zpmmC6mxZhZT9r3FmZzczuEuxaJheEczZLiI3DqP/07E6BZ6NxQg==
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::2d)
 by FR2P281MB1735.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:8b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 10:11:45 +0000
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf]) by FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf%3]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 10:11:44 +0000
From: Remi Buisson <Remi.Buisson@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Remi Buisson via B4 Relay
	<devnull+remi.buisson.tdk.com@kernel.org>
CC: David Lechner <dlechner@baylibre.com>,
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
Subject: RE: [PATCH v3 7/8] iio: imu: inv_icm45600: add I3C driver for
 inv_icm45600 driver
Thread-Topic: [PATCH v3 7/8] iio: imu: inv_icm45600: add I3C driver for
 inv_icm45600 driver
Thread-Index: AQHb9x5gsltPjGhTv02UGY0aUH3GQrRBftyAgB8IBVA=
Date: Wed, 13 Aug 2025 10:11:44 +0000
Message-ID:
 <FR2PPF4571F02BC2D65FAC64CCAF6F3F1798C2AA@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <20250717-add_newport_driver-v3-0-c6099e02c562@tdk.com>
	<20250717-add_newport_driver-v3-7-c6099e02c562@tdk.com>
 <20250724171811.55b0bc0b@jic23-huawei>
In-Reply-To: <20250724171811.55b0bc0b@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2PPF4571F02BC:EE_|FR2P281MB1735:EE_
x-ms-office365-filtering-correlation-id: 57971f84-1d25-4cdc-86b7-08ddda51ce92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|19092799006|376014|7416014|1800799024|366016|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dXcrZFVXZy9RVU1RTkVlOVlseU5Vb0RLeHFENDBuZ2Zvb3lXaUJDMm1DTFZh?=
 =?utf-8?B?RVF1bnJPelJMMm1PU2QzSG5MelNEQTVvNDZUeFBEUkV5MkY2VEpmaXR5elhi?=
 =?utf-8?B?ODFHNGZWZWlKVmhsUHNGSDlCclhCZzBTSzRHSkJKUDFRVGdjYW9VLzA2Y20r?=
 =?utf-8?B?MWttMlVaeWQ2dFNhdC9PaW9yVCs1ZFJSay9Ma3AySGV5c1ZCQUxCKzNlZVZq?=
 =?utf-8?B?aER2SURsSk12YmRmK25jcXNvQXkxVkFJZzJscFdxbE93enQrVUROdDNwYkpr?=
 =?utf-8?B?azE0NWJ0ZW0vSnZmd0NsMzdNbEUzbHE0WFJTelc4NG45aWU2N0xHU0twQ1hQ?=
 =?utf-8?B?VDM4Nzc2Mkt2MWJhUTZTV29RcllFb3VKYTQramJWRDh4OVJITkNJMXBBWGt2?=
 =?utf-8?B?V2tpRFlVaUlsVm1KdDZmTlZRU2FHR1lOOVRaZWswNFlqaGE0bzlVTGc3QVVT?=
 =?utf-8?B?cGxtQUN4UklaNDdraVM5TkpqVXRwc1NQOGYyRks3TGNreEFhQnB0cFcwNUNL?=
 =?utf-8?B?bUdrK1FOcHFiY2ttWUU5QVlzWGZtTHRhTDNnNnVqRjk4YWtyVHNMVVdLYjJp?=
 =?utf-8?B?WXN2eTRXOTFibHQrOEgxN1UzL0haRFJPY0pkcFpEMUt1QjBkNm5wVEg2cy9k?=
 =?utf-8?B?eTlDT2M5cFQvdHVMRExhS0tVakRDRUJiWHhSTDJ0SHY3NzZzSE5hUHJEQUds?=
 =?utf-8?B?QTNiRHVjY1htQVpSdVc0NWIzc2M0dFR1NWc5OStZQkYrY0dXRnMxSXh0aU1D?=
 =?utf-8?B?ZXlKMVRpYWdMZjI1blJEVWNiNmJ2bGc3MEk4Q0JtQXNKYUxVNlJocVZieHhO?=
 =?utf-8?B?aGc3VmIvTVdFYjcyVkVUU1ozcW1vNmFhR253Uk93YVdxT1dWM0w5RC9KaUUv?=
 =?utf-8?B?QWJqc3E0bEgwY2NlRlZ2MXZ1Sk5vZkhMNThQeWJXOTFPbFNmWUhuWHlZT3FJ?=
 =?utf-8?B?RWlNZytMLy9qdXBMR3VJdnZzOTJBT0daSWZUaVNBRm0rT0pDSVhqU1ZZR3JU?=
 =?utf-8?B?Y3Q3aXRTUk5IQjhpbG5LVnZGbmFXY3VNSW5JZTJ1eUZ1U0pYaytGblMvVW1j?=
 =?utf-8?B?UVg0OWxJQjk4Rmd0SWpSVlA0dGFScFEwSzU3TUhJSzFoUkNzNy9UbHduaGo5?=
 =?utf-8?B?UzBmTzdPb1Nkckswa1MwMFBlVGFzejhhUkVNVTFGd2xIZjBrRC8yZWRIVVZr?=
 =?utf-8?B?eFJ0dzhkTUxTTmJnODF2UjJzWTdYNGdFNmN4NFhRZ2FsblNoRmJTRTlleEla?=
 =?utf-8?B?dUdNb2Z5cmR1SDhBekY5aVZ6MjVNZTdDWmJwc0hic0cycnFDNHlQNStxcDhF?=
 =?utf-8?B?L2dmc1BaNEtDbHJNSmM3OEFEU1QxclBlNURUb213Uzc3VWlhU1dHUGk0R3pj?=
 =?utf-8?B?cG5GLzRyWkJSRmlQaVBldkVqNmtyOFZBWTZ6YTA4MUhTWGtiWHJrSkNQb0Rr?=
 =?utf-8?B?Uy9BbHovK0VlZkhaYmRNWHBXeXhOZ2gzTTRTK3hvZFEzeG5mOVJoY1NIVk8v?=
 =?utf-8?B?dXUwT1ZpWVErSTdyVWZDS1l1RUxrNmF6RXdtUXBKdVdXeWVjZm9QMWk3eHBV?=
 =?utf-8?B?eTc5eWQ3Rk5Obzh1NWMyQWd2NHpOZDQ2dE4ydVljcTFtNm1iRmxtcld2aVJo?=
 =?utf-8?B?Mm90a1A0cFdTbVhwZGpWVmVYVmdpRHFQOVY1dmdpYTBCSkNxV2hGYVVQZFhp?=
 =?utf-8?B?MjJxTnFMZHQycjYzU29KZXlLRS8rSXdveVYvaG1Rd1AvVnN0U241aVJIWnVJ?=
 =?utf-8?B?WG1id2FsMWFaN1htai9YaWdtU2p3RDVDR3VDeWFRaHUvN2FGTUUyK2pGT2c5?=
 =?utf-8?B?QXh3T21ZSnk1anRFQWgvNjhlU3VaMVp1allNdDNPLzRTWXBXTnNwMmNPb3VB?=
 =?utf-8?B?UUhQL21vbXRxcFVsSkVuS0N2RE5sWlY4Q0xWOHNoZVJjdVZMUlhtSC82VkFr?=
 =?utf-8?B?NjVidWM5bE5oc3pscWNmTXNLVGRCbzVCMWhkYklOQUZtSzczeVR6SUxWMmMy?=
 =?utf-8?B?c2xVVGw0YldFWTdJSDZ0aXdhaldHVWdoT2tqNVQxTW5VSkJBeWY0bVRUa3NJ?=
 =?utf-8?Q?qU6NV1?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(19092799006)(376014)(7416014)(1800799024)(366016)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RG1GelRyZ2RCKy9tS1Fuc0wxSWJ2OW9PYkdiT29IKzEvTFdodno4TSt4djk4?=
 =?utf-8?B?cU84Q0hlOCtISUpwTWk1K1RSUytYMEVWSis2UkRheFVXRHNVcFZ2YVErMkpk?=
 =?utf-8?B?TlNEQ21yakVycGJGYnJpWmtiOWJvdUxRZTBvOE5aOUFSK25uWEFQMG5HbTN6?=
 =?utf-8?B?RE5leGFCaitpS21CTFd4eEJDL1lld2dCZmcvc2dIS05rR0ZjaG9xOGxJNjFC?=
 =?utf-8?B?SWRrOHAzNFZyby9IZkxBbkU4dlg0dG1DTm5wdFlZTFlKWm50ZHZCRGZpbm04?=
 =?utf-8?B?dGp1a013NGwwMzh2UnQ3TkR6WXhydzhxUmZCTkRmYm52TCtaYlREMUxJcXUv?=
 =?utf-8?B?THRiRUdsNWw2TlYvUk9ubW9GWFl1c2Z1LzhYWForUVpVK3lKRjlQN2FQMllH?=
 =?utf-8?B?OHlHQ1pZUE00S21qN2ZDc3hTL0ZrR3BjQVFnTm5GSkRHVnVuL29jckhQQlN1?=
 =?utf-8?B?Wkg4YnA3RkxvVkh6alF5N0JhTmE5eDRJa1UrZXN0L1lkdWVIYjJXZWFpYStN?=
 =?utf-8?B?dDNOSGE4cTR2ZjkzUmxDVnEyeVQ1Rk5wQys1ZElYVHdWNk8vWENGUFU2cnN6?=
 =?utf-8?B?a2xubnpFQlpUZHlrb2hpMEtGTFJMWnpMSlltMWdueXJkQ2UvNlNIc210dUo0?=
 =?utf-8?B?Nzg2ajlTKzhFcHBmNUpzcmhPYlpZTlFZUXhFZjZUZ0xkbWZRZHRlS215eTlP?=
 =?utf-8?B?YVFzVUpZQmprZXFYei9uRHpXVENmSkpDSzlpVHJ5MTVKbDkyQjVkbm9rdllD?=
 =?utf-8?B?WlV6WUJDV2NUdVd2OGlTMERSY2hmYytiTUJPS1M5bnZTN09TQlcyWWFrUEZI?=
 =?utf-8?B?Q1JrWnBNNERCSjh3WlE4dUJGMUZNNTlMakltS2J4bVpSMGYwY1MrUFRyN2dW?=
 =?utf-8?B?Qjd1UFRjM1ZXSFFhZ2wwUUxaRlJOZ1h3SnIvL2xEN29CNkhtS1lwU2tkczVC?=
 =?utf-8?B?NUwvU3ZXWlZQS2E1K2tPN0Nqbjh0WUZGY3RyZDAxK2xxQXB1czZVYW1OZWVM?=
 =?utf-8?B?TUNIVkhKOEVlR0JVOEd3N1VYUHJQS2dzY2pHMXRUbktQaVZDam1VWjY1Szg2?=
 =?utf-8?B?Znk4TERoYzN4U0kvSE5aeUthNldsaHVHQUJFKzJ1enJsSHczcGJLdlhPTUY1?=
 =?utf-8?B?eG41ZzhJdlpxODhYcnFwbmRIYWxWbU51VkcybTQ2V0krZ25xQXFlbExuODRC?=
 =?utf-8?B?NzBHTmJFUU1TdVFva2U1WklrMGc5Tmt0OGZXNXBaT3A0eGlxc010anR1R3Z3?=
 =?utf-8?B?K0h2VmxabWJ3Z0NCZXRqdHFaT3BrZmRPb25LZ3dTd2dzeThHaVU0MUw5WXVt?=
 =?utf-8?B?VGM5RzVoR0k0ZnBWcmJ3ZnAzc2tZNHN2T3NyRHVOMndIZVpCNnVZNnZ0dEor?=
 =?utf-8?B?cVB1RnBUSjRXSlEzUGFGQlZ1K3RXcithQmZxenFWVzIwTWZUZ1dnUVJ6UER5?=
 =?utf-8?B?d01ETjd3WmFZT0ZiQ04yelRIU01uVHdUL1BROUhQUG0yajVMUWJFUGwyaURi?=
 =?utf-8?B?TUgxaVJ1WllhdWNmMC9lSElZUGgyQnZUbFpGYk9ybEY4eWdCclU0ZXhidWFW?=
 =?utf-8?B?R1EzSjYxbXJHS3lIeTlBWlQ5a2c0RDJiazdQSy85Z2haQ1gxNGVDN3lsUUY3?=
 =?utf-8?B?Nlo0b0JCM0FtNVJGcFMyME9vbEhybXE4aWVhTFAwKzJPQ3ZUVWMzbFF6VlRT?=
 =?utf-8?B?b29zM3p4T1NSdTB2ZUg4Q0JtZHBSRVc5WlU2THVEWjc4VjBUb2phQnJHa3Rx?=
 =?utf-8?B?dW1vUnhoWS9kSlppMUx0a2JKMkJZK2VkR01FenRYWGpCUy9mYzMvandPQTRh?=
 =?utf-8?B?Vm90VzU0TU1OWmlRVE9jcGcrYURTY0VvRTRuVVNBSGVvV2xxSko3bTU4K0Fv?=
 =?utf-8?B?SmZPUWE3NVUwcGJlS3BOOU9wNHU0KzUzU2FYbjJPT0RDWUYzZU9XaXFTbnhH?=
 =?utf-8?B?bmNVVFdXazBEemhiRzZxV2VzSUNVQmJsaEpPU2VXRm53aDV4OXRtblI4VVdI?=
 =?utf-8?B?MnIxWElTTWpwMWJyYkFoYkRaM1kyNjlLbm5Zc1pXV1NVR2VhYlptTCtKUGNH?=
 =?utf-8?B?VHRWV29NU3JCczN3UWdaVXF2Sm9Pa21meWhZYTVCVDh3bVlHYjRUbk1ZZnly?=
 =?utf-8?B?WnVZK2N2QmhKeWcyRnh5RUJvWU5wbFIxa2NnOXFoeVcrcktteG9tUXY1Zncy?=
 =?utf-8?Q?EFp0FDmLBJU5mOcE40ulWMNW+3uY1TimXZKueneOOxye?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 57971f84-1d25-4cdc-86b7-08ddda51ce92
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 10:11:44.8998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pfEZxNa6c6V3CqETcK5/CKP24KimUSzQYx46daI9lSK0pxyhPZw3+Yl8W09tfjWcJxz+Nc5Uj0U4vJD4PSlBww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB1735
X-Proofpoint-GUID: mBZv2Ea_JU1HWZtiZu2Xg_IARHSJyJwc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAwOSBTYWx0ZWRfXz+wvVIrsmhLE
 K6ITzlitNBr2gKg7l5pVXokkMs1Nqr5cWCkZsOZyHQ1yYzNSfkAnIo+W5NHgOcfI29QhMqXXAeK
 FPuZUTp6iPdNr2GXm9Zy4cB+gM2SEtZnA7wcCNtcxZgSRRFQq1wS+18IZmYnsKyfByVvdaoDzW4
 xQyTUHEHw9NvRg1QzDDblbF9mUbxfBmjPRcqJtYjC7RbgghWzqxHUVvvH5pIPSGpop+Hk8xw1Xp
 u1Mcs9L5UC7mzEsIEgECJTGAHf3S0BFFX0m5kTO47Xtl00rvW/y8GpKnZNZ4TC0XuEqBZuXdI/9
 V9p5qk6xjO8r6882YNq6HRQO6YH1vv/fMIJ904b5Tkt/A5/YyPlC6vPtqn49JCGCaK4W2zVQMxY
 q92m+cR/
X-Proofpoint-ORIG-GUID: mBZv2Ea_JU1HWZtiZu2Xg_IARHSJyJwc
X-Authority-Analysis: v=2.4 cv=AO34vM+d c=1 sm=1 tr=0 ts=689c64e6 cx=c_pps
 a=QSVwdLPRPe6INsZHI1N3Cw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=Uwzcpa5oeQwA:10 a=VwQbUJbxAAAA:8 a=In8RU02eAAAA:8
 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=hvUzREidl6GFh8qIeioA:9 a=QEXdDO2ut3YA:10
 a=EFfWL0t1EGez1ldKSZgj:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 adultscore=0 malwarescore=0 clxscore=1015 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090009

Pg0KPg0KPkZyb206IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+IA0KPlNlbnQ6
IFRodXJzZGF5LCBKdWx5IDI0LCAyMDI1IDY6MTggUE0NCj5UbzogUmVtaSBCdWlzc29uIHZpYSBC
NCBSZWxheSA8ZGV2bnVsbCtyZW1pLmJ1aXNzb24udGRrLmNvbUBrZXJuZWwub3JnPg0KPkNjOiBS
ZW1pIEJ1aXNzb24gPFJlbWkuQnVpc3NvbkB0ZGsuY29tPjsgRGF2aWQgTGVjaG5lciA8ZGxlY2hu
ZXJAYmF5bGlicmUuY29tPjsgTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT47IEFuZHkgU2hl
dmNoZW5rbyA8YW5keUBrZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47
IEtyenlzenRvZiBLb3psb3dza2kgPGtyemsrZHRAa2VybmVsLm9yZz47IENvbm9yIERvb2xleSA8
Y29ub3IrZHRAa2VybmVsLm9yZz47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+U3ViamVj
dDogUmU6IFtQQVRDSCB2MyA3LzhdIGlpbzogaW11OiBpbnZfaWNtNDU2MDA6IGFkZCBJM0MgZHJp
dmVyIGZvciBpbnZfaWNtNDU2MDAgZHJpdmVyDQo+DQo+T24gVGh1LCAxNyBKdWwgMjAyNSAxMzoy
NTo1OSArMDAwMA0KPlJlbWkgQnVpc3NvbiB2aWEgQjQgUmVsYXkgPGRldm51bGwrcmVtaS5idWlz
c29uLnRkay5jb21Aa2VybmVsLm9yZz4gd3JvdGU6DQo+DQo+PiBGcm9tOiBSZW1pIEJ1aXNzb24g
PHJlbWkuYnVpc3NvbkB0ZGsuY29tPg0KPj4gDQo+PiBBZGQgSTNDIGRyaXZlciBmb3IgSW52ZW5T
ZW5zZSBJQ00tNDU2MDAgZGV2aWNlcy4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogUmVtaSBCdWlz
c29uIDxyZW1pLmJ1aXNzb25AdGRrLmNvbT4NCj5BIGZldyBtb3JlIHRyaXZpYWwgdGhpbmdzIGlu
IGhlcmUuDQo+DQo+VGhhbmtzLA0KPg0KPkpvbmF0aGFuDQpUaGFua3MgZm9yIHRoZSByZXZpZXcs
IGFsbCBhZ3JlZWQuDQo+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vaW11L2ludl9pY200
NTYwMC9pbnZfaWNtNDU2MDBfaTNjLmMgYi9kcml2ZXJzL2lpby9pbXUvaW52X2ljbTQ1NjAwL2lu
dl9pY200NTYwMF9pM2MuYw0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAuLjlkYjI0OWNhNTNlYzNmZWNiMGY4
NTc5MmEzNTNkMDU0NjNmNTJhY2INCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL2RyaXZlcnMv
aWlvL2ltdS9pbnZfaWNtNDU2MDAvaW52X2ljbTQ1NjAwX2kzYy5jDQo+PiBAQCAtMCwwICsxLDgy
IEBADQo+DQo+PiArfTsNCj4+ICsNCj4+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGkzY19kZXZpY2Vf
aWQgaW52X2ljbTQ1NjAwX2kzY19pZHNbXSA9IHsNCj4+ICsJSTNDX0RFVklDRV9FWFRSQV9JTkZP
KDB4MDIzNSwgMHgwMDAwLCAweDAwMTEsICh2b2lkICopTlVMTCksDQo+PiArCUkzQ19ERVZJQ0Vf
RVhUUkFfSU5GTygweDAyMzUsIDB4MDAwMCwgMHgwMDg0LCAodm9pZCAqKU5VTEwpLA0KPj4gKwl7
IC8qIHNlbnRpbmVsICovIH0sDQo+DQo+bm8gY29tbWEgb24gc2VudGluZWxzLg0KPg0KWWVzLg0K
Pg0KPj4gK3N0YXRpYyBpbnQgaW52X2ljbTQ1NjAwX2kzY19wcm9iZShzdHJ1Y3QgaTNjX2Rldmlj
ZSAqaTNjZGV2KQ0KPj4gK3sNCj4+ICsJaW50IHJldDsNCj4+ICsJdW5zaWduZWQgaW50IHdob2Ft
aTsNCj4+ICsJc3RydWN0IHJlZ21hcCAqcmVnbWFwOw0KPj4gKwljb25zdCBpbnQgbmJfY2hpcCA9
IEFSUkFZX1NJWkUoaTNjX2NoaXBfaW5mbyk7DQo+PiArCWludCBjaGlwOw0KPj4gKw0KPj4gKwly
ZWdtYXAgPSBkZXZtX3JlZ21hcF9pbml0X2kzYyhpM2NkZXYsICZpbnZfaWNtNDU2MDBfcmVnbWFw
X2NvbmZpZyk7DQo+PiArCWlmIChJU19FUlIocmVnbWFwKSkgew0KPj4gKwkJZGV2X2VycigmaTNj
ZGV2LT5kZXYsICJGYWlsZWQgdG8gcmVnaXN0ZXIgaTNjIHJlZ21hcCAlbGRcbiIsIFBUUl9FUlIo
cmVnbWFwKSk7DQo+PiArCQlyZXR1cm4gUFRSX0VSUihyZWdtYXApOw0KPlVzZSByZXR1cm4gZGV2
X2Vycl9wcm9iZSgpIGZvciBhbGwgZXJyb3IgbWVzc2FnZXMgaW4gcHJvYmUuDQpPay4NCj4NCj4+
ICsJfQ0KPj4gKw0KPj4gKwlyZXQgPSByZWdtYXBfcmVhZChyZWdtYXAsIElOVl9JQ000NTYwMF9S
RUdfV0hPQU1JLCAmd2hvYW1pKTsNCj4+ICsJaWYgKHJldCkgew0KPj4gKwkJZGV2X2VycigmaTNj
ZGV2LT5kZXYsICJGYWlsZWQgdG8gcmVhZCBwYXJ0IGlkICVkXG4iLCB3aG9hbWkpOw0KPj4gKwkJ
cmV0dXJuIHJldDsNCj4+ICsJfQ0KPj4gKw0KPj4gKwlmb3IgKGNoaXAgPSAwOyBjaGlwIDwgbmJf
Y2hpcDsgY2hpcCsrKSB7DQo+PiArCQlpZiAod2hvYW1pID09IGkzY19jaGlwX2luZm9bY2hpcF0t
Pndob2FtaSkNCj4+ICsJCQlicmVhazsNCj4+ICsJfQ0KPj4gKw0KPj4gKwlpZiAoY2hpcCA9PSBu
Yl9jaGlwKSB7DQo+PiArCQlkZXZfZXJyKCZpM2NkZXYtPmRldiwgIkZhaWxlZCB0byBtYXRjaCBw
YXJ0IGlkICVkXG4iLCB3aG9hbWkpOw0KPj4gKwkJcmV0dXJuIC1FTk9ERVY7DQo+PiArCX0NCj4+
ICsNCj4+ICsJcmV0dXJuIGludl9pY200NTYwMF9jb3JlX3Byb2JlKHJlZ21hcCwgaTNjX2NoaXBf
aW5mb1tjaGlwXSwgZmFsc2UsIE5VTEwpOw0KPj4gK30NCj4NCj4+IA0KPg0KPg0K

