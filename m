Return-Path: <linux-iio+bounces-22977-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EFBB2C45A
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 14:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D8053AD96C
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 12:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AF53375DB;
	Tue, 19 Aug 2025 12:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="hOJMbKRP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A930322DCE;
	Tue, 19 Aug 2025 12:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608066; cv=fail; b=YW6FapOO+OtWfu1WTJtTR8nnFcCoLSEbsnhtSrDOEMDigam+Z0zrqk/pPXvcjuUAc4F3ClAZaPyI/FEgLq/wj+n3ViUzgqIiew+pwxPgFIxJHZoRJ9YObrwXN5V9cE3mX0KaCdL0FPdUNYsCf6w8GwA7wq8LSyznTOF5z8LyUhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608066; c=relaxed/simple;
	bh=rTyOOQVVVzWPecGKNTHh/QOYtDtOy/T4qngj8/D0dJs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SNdS3mVYmtD8D/+mlNSxl972sJ4OuSFaqnMudDQYcbn5xHD9rbVHzpwKzk/5Jf+gbnYVxnmomTYpQs+0yDCVthsdvGw3PaPg7SVcfyF1j9RaljonxIEcxl1jUEk9pvHu+90Wngjg69RXHN5QYLI83GKJTX7wUNr541OgfMnYL64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=hOJMbKRP; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IMabRg015679;
	Tue, 19 Aug 2025 12:54:17 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazon11012060.outbound.protection.outlook.com [40.107.149.60])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 48jgc0t6st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 12:54:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBAsy8OvzZH8VEcDqhCE5xKlLmcO6N3xYJifIwEeC5Qr+TwCb8EpXQrppl58byg50jV1NTLwN9FVeZNMf69QDikrmXxO9FMuH87mBA0xuVPhiP1WLKMmyHalMZtj8DiTNI1dlH+DtTiYYbhzK/Ar9LAS4JpjW6HV1bFNat+nIfIY5dIbmjRZEqHEzpvlr8HJgy97IyjVzX6DZuwuElkmuj6i9AjdLdo6qo06RebZC1sdCKA0Lj0p6/Rk4MeWqAevxSzA77GdrLrEiqN+ub0ycpe+drGPQ1BKJvX690qvJ8BPrnNOV+syX3QCJBHjncyVsOSN9doBA0M0QZ7NOwB9Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTyOOQVVVzWPecGKNTHh/QOYtDtOy/T4qngj8/D0dJs=;
 b=kijzaUfeNeUCcqk9BuRv+CJYChBxvdiP3Z12GajiK0OgZmCPvsH/GmW1TY+5DuAjeG5F+2EpWbJL09PopHZvHwVF3IETC30FSvd3+Zu/YCljqzYn6urzSGF+Up0wBGBRRinF6CzlG+u4wh6TYFmEd7Z0Rs6YFV7wJVlvM/c50gRq9Scxr0ro1U69eR67qnvK+GfOaqt9rAzUkeiedjhnK3hCYBKbo/FMNXoqOHoC8XYSgg4cBeWJjZdiecblCce3KfYz/yeG2X7hhu3qBlJrIPc7iUEkqjl2Qo/QwjFzCT7nutAxIAxDS8yZhM2GhTRmbvdUVAO0+oKwntSiJoxJ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTyOOQVVVzWPecGKNTHh/QOYtDtOy/T4qngj8/D0dJs=;
 b=hOJMbKRP5lGLbywxDLI501/b4nVqooizPhiQngeWjN6QOaYUM9h0XjiqKNaiByc4f3AnBUJEyw9rz4GeUwKgvQWnzYWGmQi7zCDwDnIEuuZ5z7Vn67oTWNjF67G3iB3rWmGOYRsckxw6VkyUFuC6rzLB+gz2wdNd/diOsAoUCQIDKjwG+hSnaV3yKmDVYxlwQz/XenBGejTwU6pUDOLfAhEkOGSaHg/t0GLRvtqodp0H5vKJ54FCR+yAPUSZqnonZTAnSZSB1BJ8wX/d2AqxfU5VWUrWnIdgIUBQusrTrmN2ihPGPVuiygz5oOiZ/Wqg2imJKPNSqaYW4hhTwvvN8Q==
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::2d)
 by BEZP281MB3074.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:75::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 12:54:11 +0000
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf]) by FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf%3]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 12:54:11 +0000
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
Subject: RE: [PATCH v4 1/9] dt-bindings: iio: imu: Add inv_icm45600
Thread-Topic: [PATCH v4 1/9] dt-bindings: iio: imu: Add inv_icm45600
Thread-Index: AQHcDPmDWnB/dCSpmk2sXcwiur1x2LRlJvGAgATM8rA=
Date: Tue, 19 Aug 2025 12:54:11 +0000
Message-ID:
 <FR2PPF4571F02BC8869EB8C645AB10050568C30A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <20250814-add_newport_driver-v4-0-4464b6600972@tdk.com>
	<20250814-add_newport_driver-v4-1-4464b6600972@tdk.com>
 <20250816122519.2c7a5d9e@jic23-huawei>
In-Reply-To: <20250816122519.2c7a5d9e@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2PPF4571F02BC:EE_|BEZP281MB3074:EE_
x-ms-office365-filtering-correlation-id: 792d9f4d-f2ee-4539-9c38-08dddf1f7e60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|10070799003|7416014|1800799024|376014|38070700018|3613699012;
x-microsoft-antispam-message-info:
 =?utf-8?B?azVzTklxWlN6eXYxaFFnZ0JNT3FsM05xRkIyditmak5TQVZhdXpMVGlWOGNo?=
 =?utf-8?B?U2ZhdU5QczVvaHJWcGx4TjFYRGJUVTBGeEQ2TUo2cnk1dkVpaXBqTjdWMnIr?=
 =?utf-8?B?SHNFZTRnSngyMDJaK291amR6bStLb1VyUGpEbWZIWmdsTHJJTU5jSVFyajZO?=
 =?utf-8?B?cFZlcWY5clBiQXJNa2xYT25DN0I4dmY4b1pvQ0JCT2Q3VGlMbVRhR0dXTkFU?=
 =?utf-8?B?MkpLQmtjSk9YeHQranFxL2JldFZsRzJ1VVBwYVYyWG1pdnc5MjJxVlp3YjIy?=
 =?utf-8?B?bFduL2FaRlllanpHMzZtb05nOHZiNERxNGFXSlRXdzhuaTlHSzN3ejRUc1Z0?=
 =?utf-8?B?anB5YnlMTE1kWWh3cTkrNUxBS0R6SG84UTRPNXBiUDNZVzFETEdxMnB2V2VG?=
 =?utf-8?B?Q2NZZ3lUK2J6Vm1uOWdGS1dZV3lIN3RWQlhZcVJQZHF5K3dHR0RsY3NkQk8v?=
 =?utf-8?B?Z1NTay9CQjkxaTJOZnpuRG1sdkJLdnNiOC9jOTAvbGxVMEFqOVN1bVk1L1Rn?=
 =?utf-8?B?UUlTNXBKMEt4Nnhjczkvd3FkY3hlM25TNTlVUkdWS2tGaUVqa2VyVnAwVnJs?=
 =?utf-8?B?emlMNzVjaWlFNm1vQzhjcEhTY1FFbk5yckpHRm5FWEtoLzJucXI2QmQ3NEZi?=
 =?utf-8?B?MlFGQVlOMng2b3RwbnIrbnZ3KzVWaXZvcm5hSm1FajJldTFmUWROWWNTWi81?=
 =?utf-8?B?RlZLVk54eUg0VEN2aVhhVzFNUmdHVWdGanZNMHI4bUlvREthTFYzSVJlb3ZD?=
 =?utf-8?B?dEhQdXNPMVpBbU94Q2dpQlByc3dVL01udzI1UjlwMU1EMTF2THhJUjA1WE5Z?=
 =?utf-8?B?VWw1WWR3MldPQXZNeUFvSFp6N3NqdkFKQ0lVcUJiVUdnQjJzbllJT1ZuM1Rz?=
 =?utf-8?B?NU9Ocno2NlJRdGIxWS9TUHVud3owNzMySVRFUTh0Yks5Q2tYRllsenNJZzdO?=
 =?utf-8?B?N0RvallwdlhMMEV0Y2ZrNUovQmlhMU5oY2dSY2FtaGl2Qlg2Zk1nTVBNLzN3?=
 =?utf-8?B?WWttZFU2eTNEOWc4WUlVTUlRYUY1d3NZVlZIbGJ3NTd1djh6Rkt0YndpVm5O?=
 =?utf-8?B?Ulo4U09mWW5yY2R2d1ZXMU1NcVB4dkg3eC94aks3dkZhcE5sQzdtNDNrN29j?=
 =?utf-8?B?V3RYNE1iOTB4UVRiZG1WeWxWcTAxbm9xNDhISGNuOGh1bElWQjhzdXFtZWZk?=
 =?utf-8?B?dHlTaDNnMWUwL2tNeVNVTndPMHYzazF5RWh1aTROU2UvVTFabkdZa3drVm9G?=
 =?utf-8?B?ZFlJVThsMEwvd3ZRWmJETCtSZEdkYTlydEUvRVZXbmVaRC9aMk1xME5EYzBh?=
 =?utf-8?B?Rm45VFF2Zlo2OGpuNDBBeVNGM2s2RTkvVDZ1YzQ5RDBySUN2VmsxUXJMdGhT?=
 =?utf-8?B?ZXdyZTdiVHJJNHRNZTdhUjh1Uk5jMTNjT1FUV0dvNWZFZ01TZit0aHlMMkR3?=
 =?utf-8?B?UElWdnVSZ1dUT1ZOa0pkUlFiS1FMdlFGaitjS0ZzQlFtYzVBeE5YSEM5RVQ4?=
 =?utf-8?B?UXJ4d0VHOVBqQ0s5MGYrNTh2RE9iZWpYVHNzUjEwQU1zTmhWK0RGSkYxdVZJ?=
 =?utf-8?B?N0pBemhCT2hFMnUzL2ZOcE13WnRHaGtLc2FZa0xKdCtzcHZjdmFZRi9oTXpT?=
 =?utf-8?B?dVBoUTVSYzQ3em1OU08ydWw1eTVNY21iSW5IcFVQaUIrZ2p1S2xHd05vbTFr?=
 =?utf-8?B?U0FFTGlGZnRjTmYzL3Uvc3lPU09XK2NlN3Azd2VrN2NOM1hUNU5pazQrNkVI?=
 =?utf-8?B?ZVNZLzlFT0xNTnpGeVFwQnVHUTkxR3dVSmVEb01pSzlNSldVWjlZdWhUZWF6?=
 =?utf-8?B?ME5CNURDVzV0V254Yjk4M0Vyck1YdkwxMjhZL0NyQVFXcHF4RW9POUVna1VK?=
 =?utf-8?B?cXpxc29XYmtkZUpRMEl5UHZ0aSs1Zi9yOHNGR3FGSHY0N1pQM2QzT21WdUto?=
 =?utf-8?Q?miosUYlFXvBGWqtRYtlpfAYfPBkbE5LJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(10070799003)(7416014)(1800799024)(376014)(38070700018)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YzEzQlZTSlBZUFp3YmphOWw3eDRNNG52QkM0a0ZhWndOR3hycjB2U1ZoV2Fs?=
 =?utf-8?B?QlRiR0h6ekJkODN0VjZhcnAxeWxWNTV5dHRNNEIrNE9zM1JnYTV6VW9LUjc3?=
 =?utf-8?B?NE5za2MyaWJBVVNnQnVxUUI2Y0xQN2xhdjFFMlhhWlJoNEFZYzFBSVJXYmhQ?=
 =?utf-8?B?SEF0QnRmTnovRDZPbFZsNi9ua0U2Zms2OXg1Nm82RERTREd1VU1YVUoyeWxu?=
 =?utf-8?B?bEttTk1YMXpRdno0ZEUyTy94UVRZQjduZUlZbTZ4R1pQU05xWkpMTnFvNVBW?=
 =?utf-8?B?Wjk5dldDYm5JTjhHYlhwQ1RtZkdhOFN2NHRodkt5aUZDeU1MMThGTDRINXdK?=
 =?utf-8?B?VGIvOEgxQzd0Zy84aGx0QlprNVhrVVNsKzh2TlJKc2R3eWNzemVBY3pzTThH?=
 =?utf-8?B?dkVrMTgxdXd1YVBtOCtXaURqR2kwZ1NIcnYwSkwzRGEwMjdSTHJZQ24rK01h?=
 =?utf-8?B?YjJ4b0VzRVFvSGdjVTVpbTJrRTkwaUhWUSsrb0hDTnBZK2NxV3o5ckptcVhh?=
 =?utf-8?B?M0pOeUxNbTlNTUFPVTU2RTVUMmp2TWlKdnNtdjFVSzNJYUlDVitQc0hvWjVL?=
 =?utf-8?B?b3lTN3I4WWpDSEo1eVRPSHdsWW00Um1OQWRhMGhEUjhlTUdDMGM5MFBmbmJr?=
 =?utf-8?B?RkVmL3ZpeVZBVTN1cU9xSkNiMFRHWWtmMW4xREc4dXhHb3R1M20vaWtBcE41?=
 =?utf-8?B?aXp1emJGMmNOZndTTVFlMjlHL1pEQ0VvU2QwWFlReGYvU0c3MDFKWXNVTG9J?=
 =?utf-8?B?SDFkMFpDVnN4bEFNbmNEY2NZYTdLek1FbG5rc3hxUnU5ZVB6RVJkOTl0ZnFM?=
 =?utf-8?B?ZHhZRjRZMnlVby9UYURXV2tVeEdyTTErNGhhZTN3TGREa0ZvQmk3bitXWXFM?=
 =?utf-8?B?TDNFaGxsUHZVNkpEbit5Zmh4clpYVmpXLyt3MXBNZzgyUEVCb1dKRmNTMFhU?=
 =?utf-8?B?U05Ba0ZybjJWcmVJMS9melNvalRublVEclk0OXNBOElTZ1JscGVLWTJ1NEdE?=
 =?utf-8?B?cFB3QTI5V05JY2tJQlZHdXIyVE5RY0FacFg1R0MyY0xTWTBibER4K2hVOTd3?=
 =?utf-8?B?M1h0M20vTUdRL1dHd0dkNS9yVzRKaHRjeWdsUVp4bThKRXIvV2FVUjJmSS9H?=
 =?utf-8?B?RU1HT1NiRElCLzVuSFNQd1d3dzZzL0c0aHMxeUVvODFNc1RtYjRuYW5DSHpy?=
 =?utf-8?B?N1RFMmw5NVdsU1J6RU9NR0g1d2VjTm1vVmFYemFaekRvMStrZXZxQ0RCMmRj?=
 =?utf-8?B?V2RrYUlyRlVqTVU1T2hkSnJWSU1EWG1FVXdYdk5KNDNCV3VUelV0OWYyYmFw?=
 =?utf-8?B?ZUR3bzBBVkx4c00zU1hRbEtYcGkzM0lNNEw2Y2gzRGFQSVgxbGlYN0dPQnRs?=
 =?utf-8?B?bXd6RkN4U0ZPem5zS0NCNzdxVEdoU0Zsb2IwZXQrZVkxQ1dUWDhlcjZKay9l?=
 =?utf-8?B?VHhBRks0aC9NQUtrS2s5M2NFcmtTd0lWVjIvbGY3S21Fd0xVeUE3cmxSWmhR?=
 =?utf-8?B?WU5xaVliK21IQmtMMlRjcmdvUURscjNlZTFQMkU5ektoNk9pcUo5TVp1TW1I?=
 =?utf-8?B?Q2djakpha2VOKzZBaTFrVXQ4b3YrRkNxdWlIOTNmamlkWWxZamt3dE5Cb3ND?=
 =?utf-8?B?YnF5eXZiZ2p4d2FvamppaUt6NjdPcWcwZjE3Y2cvdjNPZ25kZ2RTSzEwR0pQ?=
 =?utf-8?B?ZUtiWXBGT1NJMExPMkM5dFgvQ01YN1RYSUJMR3FwL0QwZzgvdldGdUljY3dn?=
 =?utf-8?B?SzAwZFRHT1BPUWZqV1duVkpIODJrT25JMFJqeVJrSUExVjM5RUpCT3pGeDVr?=
 =?utf-8?B?V0Y5dTg5dHRqTkFzNDR5bkVlaHlpNjBOTmM3aUJPUS9TcEV0ZHhOZ1ltVVJa?=
 =?utf-8?B?WHREUkJENnJFZDJBVVZmSEU0RkxVQmNtcGQzV090dlh3bnJaZUN3TWdrR29l?=
 =?utf-8?B?RkpFYmhTb3ViQXpMZTJ1SWx1S2U4VDBieHZYQ1NHVFFXOVFSRWw5K1VyOXhC?=
 =?utf-8?B?Y0d3Y0JTMnZNSExOSGh5d3VyTDBZZnZzblc3SHozN1BPdklTMGdwaVZvMm1X?=
 =?utf-8?B?d1YvV1FLS0hsL0JvVDNXeWljSGdKOUh2T0R6MmlpNDZ2cXdRaVhlOVBPZEo2?=
 =?utf-8?B?d0JiczVDTktSYVMvK1AxYUJyN01rWVV6SlVWMGxHdEplMDBwK1hZWlB5R1Iz?=
 =?utf-8?Q?KTFIff1M6WXI/1QmLQe6+2Mj/V6WtWxccHCZBEhGs7ib?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 792d9f4d-f2ee-4539-9c38-08dddf1f7e60
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 12:54:11.3669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QzqObvZ4iDe/bPs3Antmk9kNSw/Ec2PaiRDkcFfI9oVrAzaOzX9zj86/Nnagta60dx4dbo7YEjoTk3WKSeFiOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB3074
X-Proofpoint-GUID: 5RupBne95vKtkq0i8cecnnpCXLAXSdxK
X-Proofpoint-ORIG-GUID: 5RupBne95vKtkq0i8cecnnpCXLAXSdxK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAxMyBTYWx0ZWRfX+OPQZQZleMNo
 pKBYR2HJlPOR+uEa0zs1TEL3Fv8IwPZ+lEXoXMzJFEffM93mm6jfF0I3ySi5EDG6FA47i4807r+
 eJ3DiJVOymjWLSGXPcQa04tYgmhzZtC82qq0oLDPiZpRnV7SsvusnJu5LOeWv9FZ3P61La6mBZ5
 5YdupMysLfo0xIAYK2uM83zg3yutZret7qkMWN86ydIoTStHjrLgsxRIWL6Kkqn4lCtXvoDD801
 tZ5+l8QFIbFrw3BOr8dIPvnxoKvemysLF8OLGyRx9H1hzIEYrfY4yI0iBekpMgngWluZXKuDCZd
 +Ey4Fgr7y3zlYC/jMby3fn+0LvoyZsnuj3vVa/Ov2p4r2YSxbmlPZ+2xCY4wBhU57V6RwbS5IMi
 vMRnnGIL
X-Authority-Analysis: v=2.4 cv=T/SMT+KQ c=1 sm=1 tr=0 ts=68a473f9 cx=c_pps
 a=8H8uzfsOY3pwk6UKUd1D1Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=Uwzcpa5oeQwA:10 a=gEfo2CItAAAA:8 a=In8RU02eAAAA:8
 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=8EDR11RsENCV4A3G8jUA:9
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22 a=EFfWL0t1EGez1ldKSZgj:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160013

Pg0KPg0KPkZyb206IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+IA0KPlNlbnQ6
IFNhdHVyZGF5LCBBdWd1c3QgMTYsIDIwMjUgMToyNSBQTQ0KPlRvOiBSZW1pIEJ1aXNzb24gdmlh
IEI0IFJlbGF5IDxkZXZudWxsK3JlbWkuYnVpc3Nvbi50ZGsuY29tQGtlcm5lbC5vcmc+DQo+Q2M6
IFJlbWkgQnVpc3NvbiA8UmVtaS5CdWlzc29uQHRkay5jb20+OyBEYXZpZCBMZWNobmVyIDxkbGVj
aG5lckBiYXlsaWJyZS5jb20+OyBOdW5vIFPDoSA8bnVuby5zYUBhbmFsb2cuY29tPjsgQW5keSBT
aGV2Y2hlbmtvIDxhbmR5QGtlcm5lbC5vcmc+OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3Jn
PjsgS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwub3JnPjsgQ29ub3IgRG9vbGV5
IDxjb25vcitkdEBrZXJuZWwub3JnPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtaWlvQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj5TdWJq
ZWN0OiBSZTogW1BBVENIIHY0IDEvOV0gZHQtYmluZGluZ3M6IGlpbzogaW11OiBBZGQgaW52X2lj
bTQ1NjAwDQoNCj5PbiBUaHUsIDE0IEF1ZyAyMDI1IDA4OjU3OjE1ICswMDAwDQo+UmVtaSBCdWlz
c29uIHZpYSBCNCBSZWxheSA8ZGV2bnVsbCtyZW1pLmJ1aXNzb24udGRrLmNvbUBrZXJuZWwub3Jn
PiB3cm90ZToNCj4NCj4+IEZyb206IFJlbWkgQnVpc3NvbiA8cmVtaS5idWlzc29uQHRkay5jb20+
DQo+PiANCj4+IERvY3VtZW50IHRoZSBJQ00tNDU2MDAgZGV2aWNlcyBkZXZpY2V0cmVlIGJpbmRp
bmdzLg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBSZW1pIEJ1aXNzb24gPHJlbWkuYnVpc3NvbkB0
ZGsuY29tPg0KPj4gLS0tDQo+PiAgLi4uL2JpbmRpbmdzL2lpby9pbXUvaW52ZW5zZW5zZSxpY200
NTYwMC55YW1sICAgICAgfCA5NyArKysrKysrKysrKysrKysrKysrKysrDQo+PiAgMSBmaWxlIGNo
YW5nZWQsIDk3IGluc2VydGlvbnMoKykNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vaW11L2ludmVuc2Vuc2UsaWNtNDU2MDAueWFtbCBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vaW11L2ludmVuc2Vuc2UsaWNt
NDU2MDAueWFtbA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAuLmY0MzI1ODEyNGMzMmViZjg1MGZjMjliMmU5
NzY0Mzg4NWU2Zjg0ODANCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vaW11L2ludmVuc2Vuc2UsaWNtNDU2MDAueWFtbA0KPj4g
QEAgLTAsMCArMSw5NyBAQA0KPj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4w
LW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPj4gKyVZQU1MIDEuMg0KPj4gKy0tLQ0KPj4gKyRpZDog
aHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFz
L2lpby9pbXUvaW52ZW5zZW5zZSxpY200NTYwMC55YW1sKl9fO0l3ISFGdHJodFBzV0RoWjZ0dyFD
amNVbnF6SmdpZm5WdWhYZ3REWFRlZkVsU1pDYTJpNFFSWjJxT1Z3czlXRWREczVEVUZ2SURQRUts
b2hqSDlleXEyT0gxeEFPeVJFZ0EkW2RldmljZXRyZWVbLl1vcmddDQo+PiArJHNjaGVtYTogaHR0
cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVt
YXMvY29yZS55YW1sKl9fO0l3ISFGdHJodFBzV0RoWjZ0dyFDamNVbnF6SmdpZm5WdWhYZ3REWFRl
ZkVsU1pDYTJpNFFSWjJxT1Z3czlXRWREczVEVUZ2SURQRUtsb2hqSDlleXEyT0gxeDV3WG9CZlEk
W2RldmljZXRyZWVbLl1vcmddDQo+PiArDQo+PiArdGl0bGU6IEludmVuU2Vuc2UgSUNNLTQ1NjAw
IEluZXJ0aWFsIE1lYXN1cmVtZW50IFVuaXQNCj4+ICsNCj4+ICttYWludGFpbmVyczoNCj4+ICsg
IC0gUmVtaSBCdWlzc29uIDxyZW1pLmJ1aXNzb25AdGRrLmNvbT4NCj4+ICsNCj4+ICtkZXNjcmlw
dGlvbjogfA0KPj4gKyAgNi1heGlzIE1vdGlvblRyYWNraW5nIGRldmljZSB0aGF0IGNvbWJpbmVz
IGEgMy1heGlzIGd5cm9zY29wZSBhbmQgYSAzLWF4aXMNCj4+ICsgIGFjY2VsZXJvbWV0ZXIuDQo+
PiArDQo+PiArICBJdCBoYXMgYSBjb25maWd1cmFibGUgaG9zdCBpbnRlcmZhY2UgdGhhdCBzdXBw
b3J0cyBJM0MsIEkyQyBhbmQgU1BJIHNlcmlhbA0KPj4gKyAgY29tbXVuaWNhdGlvbiwgZmVhdHVy
ZXMgdXAgdG8gOGtCIEZJRk8gYW5kIDIgcHJvZ3JhbW1hYmxlIGludGVycnVwdHMgd2l0aA0KPj4g
KyAgdWx0cmEtbG93LXBvd2VyIHdha2Utb24tbW90aW9uIHN1cHBvcnQgdG8gbWluaW1pemUgc3lz
dGVtIHBvd2VyIGNvbnN1bXB0aW9uLg0KPj4gKw0KPj4gKyAgT3RoZXIgaW5kdXN0cnktbGVhZGlu
ZyBmZWF0dXJlcyBpbmNsdWRlIEludmVuU2Vuc2Ugb24tY2hpcCBBUEVYIE1vdGlvbg0KPj4gKyAg
UHJvY2Vzc2luZyBlbmdpbmUgZm9yIGdlc3R1cmUgcmVjb2duaXRpb24sIGFjdGl2aXR5IGNsYXNz
aWZpY2F0aW9uLCBhbmQNCj4+ICsgIHBlZG9tZXRlciwgYWxvbmcgd2l0aCBwcm9ncmFtbWFibGUg
ZGlnaXRhbCBmaWx0ZXJzLCBhbmQgYW4gZW1iZWRkZWQNCj4+ICsgIHRlbXBlcmF0dXJlIHNlbnNv
ci4NCj4+ICsNCj4+ICsgIGh0dHBzOi8vaW52ZW5zZW5zZS50ZGsuY29tL3dwLWNvbnRlbnQvdXBs
b2Fkcy9kb2N1bWVudGF0aW9uL0RTLTAwMDU3Nl9JQ00tNDU2MDUucGRmIA0KPj4gKw0KPj4gK3By
b3BlcnRpZXM6DQo+PiArICBjb21wYXRpYmxlOg0KPj4gKyAgICBlbnVtOg0KPj4gKyAgICAgIC0g
aW52ZW5zZW5zZSxpY200NTYwNQ0KPj4gKyAgICAgIC0gaW52ZW5zZW5zZSxpY200NTYwNg0KPj4g
KyAgICAgIC0gaW52ZW5zZW5zZSxpY200NTYwOA0KPj4gKyAgICAgIC0gaW52ZW5zZW5zZSxpY200
NTYzNA0KPj4gKyAgICAgIC0gaW52ZW5zZW5zZSxpY200NTY4Ng0KPj4gKyAgICAgIC0gaW52ZW5z
ZW5zZSxpY200NTY4Nw0KPj4gKyAgICAgIC0gaW52ZW5zZW5zZSxpY200NTY4OHANCj4+ICsgICAg
ICAtIGludmVuc2Vuc2UsaWNtNDU2ODkNCj4+ICsNCj4+ICsgIHJlZzoNCj4+ICsgICAgbWF4SXRl
bXM6IDENCj4+ICsNCj4+ICsgIGludGVycnVwdHM6DQo+PiArICAgIG1pbkl0ZW1zOiAxDQo+PiAr
ICAgIG1heEl0ZW1zOiAyDQo+PiArDQo+PiArICBpbnRlcnJ1cHQtbmFtZXM6DQo+PiArICAgIG1p
bkl0ZW1zOiAxDQo+PiArICAgIG1heEl0ZW1zOiAyDQo+PiArICAgIGl0ZW1zOg0KPj4gKyAgICAg
IGVudW06DQo+PiArICAgICAgICAtIElOVDENCj4+ICsgICAgICAgIC0gSU5UMg0KPj4gKyAgICBk
ZXNjcmlwdGlvbjogQ2hvb3NlIGNoaXAgaW50ZXJydXB0IHBpbiB0byBiZSB1c2VkIGFzIGludGVy
cnVwdCBpbnB1dC4NCj4NCj5TZWUgdjEgcmV2aWV3IG9uIHRoaXMgZnJvbSBLcnp5c3p0b2YgdGhh
dCB5b3Ugc2VlbSB0byBoYXZlIG1pc3NlZC4NClllcyBzdXJlLg0KPg0KPj4gKw0KPj4gKyAgZHJp
dmUtb3Blbi1kcmFpbjoNCj4+ICsgICAgdHlwZTogYm9vbGVhbg0KPj4gKw0KPj4gKyAgdmRkLXN1
cHBseToNCj4NCj5EZXNjcmlwdGlvbiBkb2Vzbid0IGFkZCBtdWNoIHNvIHNpbXBseQ0KPiAgdmRk
LXN1cHBseTogdHJ1ZQ0KPg0KPk1pZ2h0IGJlIGVub3VnaC4NCk9rLg0KPg0KPj4gKyAgICBkZXNj
cmlwdGlvbjogUmVndWxhdG9yIHRoYXQgcHJvdmlkZXMgcG93ZXIgdG8gdGhlIHNlbnNvcg0KPj4g
Kw0KPj4gKyAgdmRkaW8tc3VwcGx5Og0KPj4gKyAgICBkZXNjcmlwdGlvbjogUmVndWxhdG9yIHRo
YXQgcHJvdmlkZXMgcG93ZXIgdG8gdGhlIGJ1cw0KPkFsc28gdmVyeSBzdGFuZGFyZCBkZXNjcmlw
dGlvbiBzbyBwcm9iYWJseSBkb2Vzbid0IGFkZCBhbnl0aGluZy4NCk9rLg0KPg0KPj4gKw0KPj4g
KyAgbW91bnQtbWF0cml4Og0KPj4gKyAgICBkZXNjcmlwdGlvbjogYW4gb3B0aW9uYWwgM3gzIG1v
dW50aW5nIHJvdGF0aW9uIG1hdHJpeA0KPg0KPkNvdWxkIGRvDQo+ICBtb3VudC1tYXRyaXg6IHRy
dWUNCk9rLg0KPg0KPj4gKw0KPj4gK3JlcXVpcmVkOg0KPj4gKyAgLSBjb21wYXRpYmxlDQo+PiAr
ICAtIHJlZw0KPj4gKyAgLSBpbnRlcnJ1cHRzDQo+TmVlZGVkIGZvciBhbnkgZnVuY3Rpb25hbGl0
eSB0byBiZSBhdmFpbGFibGU/DQo+Tm90ZSB0aGF0IHRoaXMgaXNuJ3QgYSBxdWVzdGlvbiBvZiB3
aGF0IGRyaXZlciBjdXJyZW50bHkgcmVxdWlyZXMsIGJ1dA0KPm1vcmUgd2hhdCBzb21lb25lIGNv
dWxkIGltcGxlbWVudCBpZiB0aGV5IGhhcHBlbiBub3QgdG8gaGF2ZSB3aXJlZCBpbnRlcnJ1cHRz
Lg0KPg0KPlRoYXQgaGFwcGVucyBhbm5veWluZ2x5IG9mdGVuIQ0KPg0KPkpvbmF0aGFuDQpJJ2xs
IHJlbW92ZSBpdCBmcm9tIHJlcXVpcmVkLCB0aGVuLg0KQW5kIG5leHQgb25lIGFzIHdlbGwuDQo+
PiArICAtIGludGVycnVwdC1uYW1lcw0KPj4gKyAgLSB2ZGQtc3VwcGx5DQo+PiArICAtIHZkZGlv
LXN1cHBseQ0KPj4gKw0KPj4gK3VuZXZhbHVhdGVkUHJvcGVydGllczogZmFsc2UNCj4+ICsNCj4+
ICtleGFtcGxlczoNCj4+ICsgIC0gfA0KPj4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvZ3Bp
by9ncGlvLmg+DQo+PiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJv
bGxlci9pcnEuaD4NCj4+ICsgICAgaTJjIHsNCj4+ICsgICAgICAgICNhZGRyZXNzLWNlbGxzID0g
PDE+Ow0KPj4gKyAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+PiArDQo+PiArICAgICAgICBp
bXVANjggew0KPj4gKyAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiaW52ZW5zZW5zZSxpY200NTYw
NSI7DQo+PiArICAgICAgICAgICAgcmVnID0gPDB4Njg+Ow0KPj4gKyAgICAgICAgICAgIGludGVy
cnVwdC1wYXJlbnQgPSA8JmdwaW8yPjsNCj4+ICsgICAgICAgICAgICBpbnRlcnJ1cHQtbmFtZXMg
PSAiSU5UMSI7DQo+PiArICAgICAgICAgICAgaW50ZXJydXB0cyA9IDw3IElSUV9UWVBFX0VER0Vf
UklTSU5HPjsNCj4+ICsgICAgICAgICAgICB2ZGQtc3VwcGx5ID0gPCZ2ZGQ+Ow0KPj4gKyAgICAg
ICAgICAgIHZkZGlvLXN1cHBseSA9IDwmdmRkaW8+Ow0KPj4gKyAgICAgICAgICAgIG1vdW50LW1h
dHJpeCA9ICIwIiwgIi0xIiwgIjAiLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICIx
IiwgIjAiLCAiMCIsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgIjAiLCAiMCIsICIx
IjsNCj4+ICsgICAgICAgIH07DQo+PiArICAgIH07DQo+PiANCj4NCj4NCg==

