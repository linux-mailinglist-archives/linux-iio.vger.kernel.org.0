Return-Path: <linux-iio+bounces-22980-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B00B2C47D
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 15:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43CF1BC3A6B
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 13:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE19342C8C;
	Tue, 19 Aug 2025 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="t81NG69k"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37D633CEBC;
	Tue, 19 Aug 2025 12:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608356; cv=fail; b=uP3Nmul6jI1+PLITvCMGIMLiRNdXFgS1UjMSuMR3iUHWjtRv8+zfDlNo7NGoGsj52P7Q3ecT5S5Q0SHXF0F3a9Qjq7/5URvpdvbTZ9VhK2Iv+HtUIwSrfEVJsqjFpSatQeCRcR1Ytm/Z1WiUWrizSTxN785iqAfx9Mny8vujsHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608356; c=relaxed/simple;
	bh=Av79V8Ufqx2Cx4IQzzKBo2e5XPI22kLaCw2gCCkhO9I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pkcKDXICfYnwZUo+7fRbNY+US5KuGntq3fGIDnm3jdNUGlJRnDUv1kuRyECxZRDg1v4+XcRc44mKX46mM2UqUCrtsogkT2aExN+VWb0J8uq1HYPiBnZt1EGBiVKZ9TP8ppZgi55c+WS4y6LC5wZyzBemEFYzm1rxadoWFzTxrTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=t81NG69k; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IN54F6028795;
	Tue, 19 Aug 2025 12:59:05 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazon11010024.outbound.protection.outlook.com [52.101.169.24])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 48jgc0t6va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 12:59:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GH9xA6ObdkHamScHT2NPIhdcka4rqDzsxk0egHfA25exKzHAce84wjHnp1Rt4zJEMwUJIxqQr+1vmetPF97mCD9iKnK2NCdbDmjvuXNl4kYqXgcQDJRcibdXjjmd9mx3xO7T7XPXa+sa+Ra8yFsmM/LFF130slGb3QbOiCmvfWpeiKlnn03NoeXtM9n+f41JxMu9pOcJt7mjC+rNxEKhzZj67tLmjJjTaKGFZC/mnCx3KJtxSV+g0YnJnXhzH/VnLecthKqggWu1jfSm6uy6AWf54CyK6Ivcy2PTWtQ2HNvIjDEN9OxNl8nkrUhzCkKK97Vsua4M2Vk3YL/lw61goA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Av79V8Ufqx2Cx4IQzzKBo2e5XPI22kLaCw2gCCkhO9I=;
 b=tZhVhx/3rA49GqlKwQlWJAVA6CXO40teFs/oXl3Zje/JUcVIfitoWb2cV3ksqjCAdGGLyTkMIj+vFLNO2hrsFDxcUVsYguteGBueA1GO1knv5xTjU7G2uzry4mDGDr/YPjaWFW2FXU9iGVqhXdcwtCQKY50175Wekzsy76lm7lOHk9FrDHOSNQrYWdjIF65CC4eVcaXnh6pz5AVMeuM257mmL2KYC6f4nJVKIJMj5DVvY4vP56hczTwu8u2/njGi2F5M2XzsP/Gl8ozQAZZm76lcxtDYOdoYwSttTthFnLZ5ZHYA7cVpj7o8+crMEJGfF5sOnBymCfpdT0nB0J16ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Av79V8Ufqx2Cx4IQzzKBo2e5XPI22kLaCw2gCCkhO9I=;
 b=t81NG69ksD7fyopi4Xq7pa4hcJWMXM2AtYZX5sjAX0BUoMl+JnNpKTIXEkW5N6UTIbmBmX8KzvE8gI8umOhAx72hR7M6rUurfc4ElC2SCLjVLGZxxwFeaBNuD3/DEjpqobzKbBTW0EJXlLittrtBTAe/sBdv8gb12FiN0jpMMbX5BX/KD7HBETFRVdh18X+e6x8BJ/RD2wbr7+JzOVUOtOYz4Bs9qHIURAGa0IudbFmNqyTL3/IxQ7E8c/e7mU6InyPyapuSUeyxBfPpu6MhE7j/heUCp4D71RRhOzJ5NhWCd+XLXAz4GDeQdJlbvPt5l+pUCpjmsRamypZXMwQFxQ==
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::2d)
 by BE1P281MB2017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:3b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 12:59:01 +0000
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf]) by FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf%3]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 12:59:01 +0000
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
Subject: RE: [PATCH v4 4/9] iio: imu: inv_icm45600: add IMU IIO gyroscope
 device
Thread-Topic: [PATCH v4 4/9] iio: imu: inv_icm45600: add IMU IIO gyroscope
 device
Thread-Index: AQHcDPl74U0FTbTNw0+Z8w+jA1Oa1bRlMvqAgATE+wA=
Date: Tue, 19 Aug 2025 12:59:01 +0000
Message-ID:
 <FR2PPF4571F02BCCC21FE8D5BFCD1015B608C30A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <20250814-add_newport_driver-v4-0-4464b6600972@tdk.com>
	<20250814-add_newport_driver-v4-4-4464b6600972@tdk.com>
 <20250816130823.3cb14980@jic23-huawei>
In-Reply-To: <20250816130823.3cb14980@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2PPF4571F02BC:EE_|BE1P281MB2017:EE_
x-ms-office365-filtering-correlation-id: d790b9f2-622d-4783-4a84-08dddf202b26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|19092799006|376014|7416014|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Zlh1cFFOUk5GaVBaY21Da0FnZE5MWlBWU01DZDU3Vytod0lNTFc2U1ZpR2FN?=
 =?utf-8?B?NEdrd1oxRFBDS0hnN1V3Y0lvT3lqaDN4UlRKaTczaFBZRUNvaGhTK3A0Q0t5?=
 =?utf-8?B?RmJSSllBRFk3VXpESUN1RGNLZzN3OGxWYVpObHNDcnhsaE85Szc5QWJ6MStY?=
 =?utf-8?B?TTR4blZvbWFWQ09sVHNjY0o5N29lSGlPbUVkeE5XMHY2OHlyMmlJd1JiN29G?=
 =?utf-8?B?WjlYRFJ4RlVrWjU3SHNsWHdLcjgzSzd2dDBDWS80aFA5T1RYaTQ0aFRnd0Vx?=
 =?utf-8?B?Ym4xT3NoejUvUGhabkw2WEVxYWRINUw5clVGekRxYUlIVXp3dVRXVml5eklG?=
 =?utf-8?B?VDdlc3RIK3dnSy8xdDcxOHFsaG9ONlhqZFlhd1FJQVpPbFNsUDVtekxrVHJ6?=
 =?utf-8?B?OHI4M1JNdTUwZ00xUnZ2cDlaM1RZTVBCMmt3clRuU2REb0RLelREcEI2endZ?=
 =?utf-8?B?Qk1tMmFzMkR1WGs0MWFvNEdyaGlUcHI0N3d6Mk1obmd6L1hYem45N1FTMStr?=
 =?utf-8?B?MnZPdHZLVFJDb3JxYjlBYWFiZDFQSDZBSk1vQmNZM0hPcVJ4dHZwbTNFQ0hF?=
 =?utf-8?B?TWt2S2ZRakd0UUZzNVdicWNmQWU3Tkl4VUdQR3k3aUkyM0dqMWtRL2JJQjdx?=
 =?utf-8?B?MWhFQUYwOG1raUhZVXhqcTdCOWljVmI1RytHNTI1SXpqT2Vub2VULy8waHMy?=
 =?utf-8?B?VVU5MW55d2tJQXA1cWhkRmh0TkU1ZkZBNmNKUEFyejQyY0pYVTJtbjZwdERE?=
 =?utf-8?B?ekZhM0pJcW4zeUl2bWdmWGZ0T1RSZ3NYNHlPNzhvOC9KRmlhd1plbWJFT3U5?=
 =?utf-8?B?YnBVSWMxY1hoa2E2MUErUjZ2SGFUTVZSejZZQnBRQ01QUUZYNU9QcHJCazNJ?=
 =?utf-8?B?U3JDcG9wWk5xUnlyWnE3LzViOEJ4cmtKUFlJMW9YNytUcEloYVBnaXFPY3VP?=
 =?utf-8?B?bk9vSDdUMGxYZTZXM29rWENESWZjeThlenJvZXh3ektRMTNUMUVvUU5wdThM?=
 =?utf-8?B?VSs1WjgwQk15bkFPOUtwNWVWaWt0VmV4Vll6aHlsNTRVNlRqUTVGeEF2ejNi?=
 =?utf-8?B?UEQ2dEdqNVkwMERhcGVFaTgrWDVtK2RoZi9Ja1hFbkdnVTUwM0JhajlZdVk0?=
 =?utf-8?B?MWZVdHp6a3Z5U1RHSWpxMkpSdWphYmlRZmJwcktmNlB1ZjBtNjU5SmpKbVAz?=
 =?utf-8?B?T1BKOWpydGg2UktUbUVkYklQRVduNVV4N0FwTmpyMnpaWnp4K2xYOEVzUzRS?=
 =?utf-8?B?NzlTOTFKZGlvQXRqR3F3M3lERnJFbC80d2ZnVHVtbnJteXZQY2xwU0Y3YkVF?=
 =?utf-8?B?V1BmL09XMzdrbWFIaC95eGR6L0d5ODhNNEhsdVhUSU5BR2t6SWNjR0VRWGpo?=
 =?utf-8?B?VFJoRVcyb2dmbjFadEtSR0VYcmVVNE55ZzZlQTFVODZJckJtMi91a2hieUp5?=
 =?utf-8?B?RmFlTHFNVVJTRThkNUt4enBtajZoQm83SURXSzRIUy9KcXl0RFM0OSs5QzdW?=
 =?utf-8?B?OU8welMyR1FxeGUxcUFJZ09YVG5GMS9MbEhNOUkzbmZETDlMNG1CVEN3MFhS?=
 =?utf-8?B?UzRMcURHWEcvVzRZaE1BM3k4aWxuM0tuVzM0SjhZVXhpUExxRWJyWU1YYmEw?=
 =?utf-8?B?OTQ0dEs5RmcrUDJuSXpzL0tHZ01EU2pRcUNyYXIyeFVmUHdnVHlHWUZJSkJK?=
 =?utf-8?B?VUNqT3pnWGlGc3J4eUZFT0hQRjVhdDVZaFJYUW9KZ0l6djN1NEd4WHBtWGxD?=
 =?utf-8?B?NVh0TUFhTFRzbHEvdHozU2dUVG9lcWN1dkI5eWFadUtXUGVUQ3ZzaVJYREFp?=
 =?utf-8?B?VFRzVUhNM0VBbHhKMVhPMVRiNGpSS2NNMGR4Q3Q4bFVSdHFac2pMaGVoeHhN?=
 =?utf-8?B?NGNmUnRXeEk3MklwbmdxS1JEL2tGYlV6d0FROEUyTGpTbjgycnNteDBUN3pq?=
 =?utf-8?B?YTlLVUVGVk1BOTZ4L1JhQy9jOEQ5eTVMSGJzOWU0N2l4a3RwN05XNjMrbGZm?=
 =?utf-8?B?S2hZMFlzNlBwY3hCeXFINzd3MEZKVStaS0RjK09OaVBhMzVhallXTWVzM3lY?=
 =?utf-8?Q?yjy6EL?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(19092799006)(376014)(7416014)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dzByaHVZVXlyc3dHU29PbHFYZTVYTFdQYXhBYzV2bHEwMVNna2VoMlNkTHdo?=
 =?utf-8?B?NmdVUGhzaEpEOFRhS25jbHNjV09oZzN4NnRXMzkzNU0xMy8va1VEQjVmTWFU?=
 =?utf-8?B?UytzMThLUlJ3dUZ0a3JsN0FKOEFqSEthYWF3bGprYkMvS1FmZDc0ajFRblI2?=
 =?utf-8?B?UW53VWhRR3lOMEM5elk2ZGtyU0NraHdidmw0ZXRlb2h0UGp3eGx5NkxYM09s?=
 =?utf-8?B?UzVGbTZoY1ZLU1FZa0poNWpGZitUZi9VMmx1bklIUlAvcXpWZlAwQVZBZjdJ?=
 =?utf-8?B?eUs3SFdKdXpYajdETVIvZEV2dkw3WXk0bE80RGZ4bHcwMVIwOTVYaitNYjly?=
 =?utf-8?B?N2g5bktNeU5ONTY3VGcvSTVTRkVRVTF4MjRZNk43YUNTbnlOMkwvbjhTSlRQ?=
 =?utf-8?B?aEdNRFFNNlVBaXdYMENQM3ltVDZYRzlramdXTkxlSVNSNlhZMzdJQm1WOVhm?=
 =?utf-8?B?SGNHWEU0NUI0ZzVKUWNySkUydmV1V25sWjdNU21xNENHLzRtMm52UHpkMW56?=
 =?utf-8?B?N1NuVDNpbFVNdU5xK0YrclBMY2pkWWQvUU5BbmFHMDg1SHpVaFF3UFVnYUpE?=
 =?utf-8?B?SHdxczhieEl6VFl1eUtqdVQwbDR1UUFORW1wbGM1MEFRbUNvU0JtN2VOWWY2?=
 =?utf-8?B?N0JhK3I2QUFXNkFkcDNIQVJIZlJzLyt1bGxhcVdIRUlqZTBuekhXekxoK3Y5?=
 =?utf-8?B?RmpWWHErYlJFTHFGV1JXYkVlVEsvMWhvTnlUcldsdXFuQXFVQnduVU95Y1Nw?=
 =?utf-8?B?azhiYVlNV05aMVpCYy84cGE5VFdxWDBzTVYySjFlREN6QnZMOVpibXAzOVZ0?=
 =?utf-8?B?TWJ3aXR2UE1XQ2xGUTdQUGpRUVRqaXBWczlnYThsSlQ4RHk2aTlUcUtma3dE?=
 =?utf-8?B?T2pNYy9kSU81R1hRSjlxVGdHU2p3R2ZORERqODhjbTB3NkJLMGloU0pPcFl6?=
 =?utf-8?B?Yi9XRnJjMzBMR3EvV1R1ZFA3ZlVqMHk3YkVTaHZaUlp1TTN5Q0puQXd0ejdT?=
 =?utf-8?B?ZW9MbmpjRDdLZ0JjSTkrOUNCSXJLWGNsZnZjSkM0TTNIWU9lV1pmNUtKVUR6?=
 =?utf-8?B?eS9mVTdaSlZVMWF4NzVsOXNtZklBdkpYNTh5NVVoVVRmUVZXRU9mUlg3Ujdz?=
 =?utf-8?B?eFZVK2pCcFAvVysxRjJKYWdYTmZyRmxEZVM2eDFDMzIzT3ZWNXY2MWFEV0hR?=
 =?utf-8?B?UndidGVmSXcrZzhPRHM2ajJSTll0NW5ENDNpZHZXcG42TzZTVmxkQzlkWFlE?=
 =?utf-8?B?NG1uNlFMRmRhNXZXZ2x0ZklSQXV6VHFxMnZtVlBrU0l1NHI0VXVUZTJXbU54?=
 =?utf-8?B?VG50R1d4WGZMWW1TbzdINnJGL25wK0E1b2NDT0krRCtyK0k1ZHI2YW02RUtj?=
 =?utf-8?B?T3BUeHFpS3ZveHVDL3lGLzUwRGpvQnVoWDlxeTFNekZKZmd3WkMyK2wzdnFt?=
 =?utf-8?B?SUVwUks2WGZGTkY5aENPMWJNWCsyd21KWFE0WlVya1d1N3lEaXdRWlFIZHQ4?=
 =?utf-8?B?ZGFOdURPbWFFS0lMUEJHZm8rRUFtZ2lDNDlFSStTeUFNcUpEZTFXaDF1d3Rx?=
 =?utf-8?B?MUV0eUFXQi85dkZ6QzN3azh2MGp0enFIYzNjaU1xemw0QTVNcTNsQXZRV3Bz?=
 =?utf-8?B?cCttK1c0UWEwQkg5bWhuMFpvajc4dkxmNW4yRC9LY0IrUFRhQUhreTJFR0Ry?=
 =?utf-8?B?cEcrOTNmakY5WWZEUnFsZ0xvaUtmd1RnRUxJSlVnUE4xR0dlNlhwYitqMXRq?=
 =?utf-8?B?eDlNZTFvY0JJTVdmVit1dmxKck5RaTNqeE55TkpoSlFEdkYycXI5QU9LaTRM?=
 =?utf-8?B?ZzNEM3pkRzY3OWpKZFdLUWp2QWJ5YUFhdG5hbjRQM3ZXWDdxTzV1dkNaS0JH?=
 =?utf-8?B?bHpiNGY4aWVxSUI4Vi9BNENXRWJZTGI3QlJGdDh5bkFJZVlpUXZKNXRDcng1?=
 =?utf-8?B?OTN2VXc5QUR5QWZ4c00vMVdqaDBjN3Rlc0FTWVJ2a2dRcG1MQmR4aWxFT3B3?=
 =?utf-8?B?NGpPOXFLbzJFb0g5ay9hNVlaN0phL3k3dTFhQmJYSExWa0NkWGQ3NDhYRGI0?=
 =?utf-8?B?MXdFUWE2K0t2QXVxRHhxTHhsQWQwcjRSYlVKVmxTc01ybVNSNnNTUjFlYkFG?=
 =?utf-8?B?NCtBSWE4UWg1dlJ0QVZyelBlcURzR2RXYndqekdGZ1kzUEQ2NzVqeXI0Y1pW?=
 =?utf-8?Q?Ifhuac86py6EzyxBeJUROITlDODjPybLEtGJaBwk+ZJ7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d790b9f2-622d-4783-4a84-08dddf202b26
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 12:59:01.1790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x348JYUVJE2Syh2SJKCJy9jMqf0qu595ZxdOmJbg83GvcAFjNEH8XJwNzx+JqKOeARc5qIq4vAe5RdDHUhc1oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2017
X-Proofpoint-GUID: 4uNYhBWc0IkRBhZ5xNWA7tVRYDA8xxIb
X-Proofpoint-ORIG-GUID: 4uNYhBWc0IkRBhZ5xNWA7tVRYDA8xxIb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAxMyBTYWx0ZWRfX8/wJZVO2oZ6s
 mp+rrACRScGkYfhObQkXxypLP1uV64DI0yfKxlYIy3rDuBYNEMg+jzakk6Ge5Z3LMUXFPu5g1M+
 UZXZ7YvT3/CXIw7MDwdBtSXlooRh2zSLz96tSFWNLhrKJdKzd/pe+OKMXW5PImAGd7Pe35hF/jF
 G/GyyNje3jLg+SOExsBfE/nLzhD0fCFHpJ1k0F/J9lcti0rSJPnkzLtB4rW4I7gjk23JTdRhm9F
 +6e+0HcS/gDJN7pBTBch79nqx2N+IXFTsEHtR8PVYi94bGTSXBTJw93UuRJikJlK7sXQ2aiUE3h
 LrtHQXKCtGs8zh062PnTVtrw/KffFylihUOwgC3h9n7DM1uXpfduIsKtTe1ujyg+BfIbSFXuqIq
 i3T4uuOW
X-Authority-Analysis: v=2.4 cv=T/SMT+KQ c=1 sm=1 tr=0 ts=68a47519 cx=c_pps
 a=f0WJCONdK1v8ciZBFcaOmw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=Uwzcpa5oeQwA:10 a=VwQbUJbxAAAA:8 a=In8RU02eAAAA:8
 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=Ilom--jXHjZe-wr-gdcA:9 a=QEXdDO2ut3YA:10
 a=EFfWL0t1EGez1ldKSZgj:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160013

Pg0KPg0KPkZyb206IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+IA0KPlNlbnQ6
IFNhdHVyZGF5LCBBdWd1c3QgMTYsIDIwMjUgMjowOCBQTQ0KPlRvOiBSZW1pIEJ1aXNzb24gdmlh
IEI0IFJlbGF5IDxkZXZudWxsK3JlbWkuYnVpc3Nvbi50ZGsuY29tQGtlcm5lbC5vcmc+DQo+Q2M6
IFJlbWkgQnVpc3NvbiA8UmVtaS5CdWlzc29uQHRkay5jb20+OyBEYXZpZCBMZWNobmVyIDxkbGVj
aG5lckBiYXlsaWJyZS5jb20+OyBOdW5vIFPDoSA8bnVuby5zYUBhbmFsb2cuY29tPjsgQW5keSBT
aGV2Y2hlbmtvIDxhbmR5QGtlcm5lbC5vcmc+OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3Jn
PjsgS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwub3JnPjsgQ29ub3IgRG9vbGV5
IDxjb25vcitkdEBrZXJuZWwub3JnPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtaWlvQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj5TdWJq
ZWN0OiBSZTogW1BBVENIIHY0IDQvOV0gaWlvOiBpbXU6IGludl9pY200NTYwMDogYWRkIElNVSBJ
SU8gZ3lyb3Njb3BlIGRldmljZQ0KPg0KPk9uIFRodSwgMTQgQXVnIDIwMjUgMDg6NTc6MTggKzAw
MDANCj5SZW1pIEJ1aXNzb24gdmlhIEI0IFJlbGF5IDxkZXZudWxsK3JlbWkuYnVpc3Nvbi50ZGsu
Y29tQGtlcm5lbC5vcmc+IHdyb3RlOg0KPg0KPj4gRnJvbTogUmVtaSBCdWlzc29uIDxyZW1pLmJ1
aXNzb25AdGRrLmNvbT4NCj4+IA0KPj4gQWRkIElJTyBkZXZpY2UgZm9yIGd5cm9zY29wZSBzZW5z
b3INCj4+IHdpdGggZGF0YSBwb2xsaW5nIGludGVyZmFjZSBhbmQgRklGTyBwYXJzaW5nLg0KPj4g
QXR0cmlidXRlczogcmF3LCBzY2FsZSwgc2FtcGxpbmdfZnJlcXVlbmN5LCBjYWxpYmJpYXMuDQo+
PiBUZW1wZXJhdHVyZSBpcyBhdmFpbGFibGUgYXMgYSBwcm9jZXNzZWQgY2hhbm5lbC4NCj4+IA0K
Pj4gU2lnbmVkLW9mZi1ieTogUmVtaSBCdWlzc29uIDxyZW1pLmJ1aXNzb25AdGRrLmNvbT4NCj5B
IGZldyBtaW5vciBjb21tZW50cy4NCj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9pbXUv
aW52X2ljbTQ1NjAwL2ludl9pY200NTYwMF9neXJvLmMgYi9kcml2ZXJzL2lpby9pbXUvaW52X2lj
bTQ1NjAwL2ludl9pY200NTYwMF9neXJvLmMNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBp
bmRleCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLi43YTVhMmNlNzdm
M2UxNzZiZGNiNTY1N2MwYjhkNTQ3MDI0ZDA0OTMwDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysg
Yi9kcml2ZXJzL2lpby9pbXUvaW52X2ljbTQ1NjAwL2ludl9pY200NTYwMF9neXJvLmMNCj4NCj4+
ICtpbnQgaW52X2ljbTQ1NjAwX2d5cm9fcGFyc2VfZmlmbyhzdHJ1Y3QgaWlvX2RldiAqaW5kaW9f
ZGV2KQ0KPg0KPkFoLiBUaGlzIGlzIHdoZXJlIHRoaXMgY29tZXMgaW4uICBBZGQgaGVhZGVyIGRl
ZmluaXRpb24gaW4gdGhpcw0KPnBhdGNoIGFzIHdlbGwuDQpTdXJlLg0KPg0KPj4gK3sNCj4+ICsJ
c3RydWN0IGludl9pY200NTYwMF9zdGF0ZSAqc3QgPSBpaW9fZGV2aWNlX2dldF9kcnZkYXRhKGlu
ZGlvX2Rldik7DQo+PiArCXN0cnVjdCBpbnZfaWNtNDU2MDBfc2Vuc29yX3N0YXRlICpneXJvX3N0
ID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4+ICsJc3RydWN0IGludl9zZW5zb3JzX3RpbWVzdGFt
cCAqdHMgPSAmZ3lyb19zdC0+dHM7DQo+PiArCXNzaXplX3QgaSwgc2l6ZTsNCj4+ICsJdW5zaWdu
ZWQgaW50IG5vOw0KPj4gKw0KPj4gKwkvKiBwYXJzZSBhbGwgZmlmbyBwYWNrZXRzICovDQo+PiAr
CWZvciAoaSA9IDAsIG5vID0gMDsgaSA8IHN0LT5maWZvLmNvdW50OyBpICs9IHNpemUsICsrbm8p
IHsNCj4+ICsJCXN0cnVjdCBpbnZfaWNtNDU2MDBfZ3lyb19idWZmZXIgYnVmZmVyID0geyB9Ow0K
Pj4gKwkJY29uc3Qgc3RydWN0IGludl9pY200NTYwMF9maWZvX3NlbnNvcl9kYXRhICphY2NlbCwg
Kmd5cm87DQo+PiArCQljb25zdCBfX2xlMTYgKnRpbWVzdGFtcDsNCj4+ICsJCWNvbnN0IHM4ICp0
ZW1wOw0KPj4gKwkJdW5zaWduZWQgaW50IG9kcjsNCj4+ICsJCXM2NCB0c192YWw7DQo+PiArDQo+
PiArCQlzaXplID0gaW52X2ljbTQ1NjAwX2ZpZm9fZGVjb2RlX3BhY2tldCgmc3QtPmZpZm8uZGF0
YVtpXSwNCj4NCj5jYW4gZHJhZyBzaXplIGludG8gdGhpcyBzY29wZSBhcyB3ZWxsLg0KVW5mb3J0
dW5hdGVseSBub3QsIGFzIGl0IGlzIHVzZWQgaW4gdGhlIGZvciBsb29wIGNvbmRpdGlvbnMsDQpN
b3ZpbmcgaXQgaW5zaWRlIHRoZSBsb29wIGNyZWF0ZXMgYW4gZXJyb3I6DQplcnJvcjog4oCYc2l6
ZeKAmSB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbik7IGRpZCB5b3UgbWVh
biDigJhrc2l6ZeKAmT8NCiAgNzUwIHwgICAgICAgICBmb3IgKGkgPSAwLCBubyA9IDA7IGkgPCBz
dC0+Zmlmby5jb3VudDsgaSArPSBzaXplLCArK25vKSB7DQogICAgICB8ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fg0KICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGtzaXplDQoN
Cj4NCj4+ICsJCQkJJmFjY2VsLCAmZ3lybywgJnRlbXAsICZ0aW1lc3RhbXAsICZvZHIpOw0KPj4g
KwkJLyogcXVpdCBpZiBlcnJvciBvciBGSUZPIGlzIGVtcHR5ICovDQo+PiArCQlpZiAoc2l6ZSA8
PSAwKQ0KPj4gKwkJCXJldHVybiBzaXplOw0KPj4gKw0KPj4gKwkJLyogc2tpcCBwYWNrZXQgaWYg
bm8gZ3lybyBkYXRhIG9yIGRhdGEgaXMgaW52YWxpZCAqLw0KPj4gKwkJaWYgKGd5cm8gPT0gTlVM
TCB8fCAhaW52X2ljbTQ1NjAwX2ZpZm9faXNfZGF0YV92YWxpZChneXJvKSkNCj4+ICsJCQljb250
aW51ZTsNCj4+ICsNCj4+ICsJCS8qIHVwZGF0ZSBvZHIgKi8NCj4+ICsJCWlmIChvZHIgJiBJTlZf
SUNNNDU2MDBfU0VOU09SX0dZUk8pDQo+PiArCQkJaW52X3NlbnNvcnNfdGltZXN0YW1wX2FwcGx5
X29kcih0cywgc3QtPmZpZm8ucGVyaW9kLA0KPj4gKwkJCQkJCQlzdC0+Zmlmby5uYi50b3RhbCwg
bm8pOw0KPj4gKw0KPj4gKwkJbWVtY3B5KCZidWZmZXIuZ3lybywgZ3lybywgc2l6ZW9mKGJ1ZmZl
ci5neXJvKSk7DQo+PiArCQkvKiBjb252ZXJ0IDggYml0cyBGSUZPIHRlbXBlcmF0dXJlIGluIGhp
Z2ggcmVzb2x1dGlvbiBmb3JtYXQgKi8NCj4+ICsJCWJ1ZmZlci50ZW1wID0gdGVtcCA/ICgqdGVt
cCAqIDY0KSA6IDA7DQo+PiArCQl0c192YWwgPSBpbnZfc2Vuc29yc190aW1lc3RhbXBfcG9wKHRz
KTsNCj4+ICsJCWlpb19wdXNoX3RvX2J1ZmZlcnNfd2l0aF90aW1lc3RhbXAoaW5kaW9fZGV2LCAm
YnVmZmVyLCB0c192YWwpOw0KPg0KPlBsZWFzZSBzd2l0Y2ggdG8gbmV3IGlpb19wdXNoX3RvX2J1
ZmZlcnNfd2l0aF90cygpLg0KPkkgd2FudCB0byBnZXQgcmlkIG9mIHRoZSB3aXRoX3RpbWVzdGFt
cCgpIHZlcnNpb24gZXZlbnR1YWxseSBhcyB3ZSBtaWdodCBhcyB3ZWxsDQo+YWx3YXlzIHByb3Zp
ZGUgdGhlIGJ1ZmZlciBzaXplLg0KPg0KU3VyZS4NCj4+ICsJfQ0KPj4gKw0KPj4gKwlyZXR1cm4g
MDsNCj4+ICt9DQo+PiANCj4NCj4NCg==

