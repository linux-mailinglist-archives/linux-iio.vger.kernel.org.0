Return-Path: <linux-iio+bounces-23710-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 724FCB43C81
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 15:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13BB93AE598
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 13:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A968F2FF141;
	Thu,  4 Sep 2025 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="iktEGPQh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5802C21D4;
	Thu,  4 Sep 2025 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756991152; cv=fail; b=jv/nL+If09enFD9K6PDnFNEFQIWL/cYU1Imh/WTNtZAJeKPGK9luZCdNpUu3R0eq2VwiNVvr9FiLhqZcRlsJ6f/433Fim1fTZFoWfbMmaOPJWF/5WVtU6vREYyNhF3h/2Q+rWSjxa/3qcR2ObtUguqk7d1Ed7rdOzkATE4Tr0zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756991152; c=relaxed/simple;
	bh=9akGEs+0OWbRGNGNIKiz/7IeWGOgXT+lx4fJW5Xp04M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L0wL6jmg9KsVyKY6eFMqPXmvf7G742wouMRNpV9CuBquEalHvaCcATs8E4syiYUM3w/zEA2k0meh31n7E8ZvEBW491eArDDpP7oIq2Nzvig5gS9koONAzYcH1OMM68HK8ZydHq3Llx1LTgw1ts/MW/BSC/gwmiAc6AWEyhm3ZBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=iktEGPQh; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583NBEuu001975;
	Thu, 4 Sep 2025 13:05:44 GMT
Received: from fr6p281cu001.outbound.protection.outlook.com (mail-germanywestcentralazon11010048.outbound.protection.outlook.com [52.101.171.48])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 48uqp043fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 13:05:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hF78F7sqltkhlHJG2/J0nYuy8wUZ2wadSchyV1H84SJcj0Sbbf0T5T9j9tqavc30yztxEhZnX+YxnwDNF46c/mtgMeISsZt0X1YH1RTCnTZevsD9MlsM3qcBmNd1yTyp+MUZdXlE4cS5DPf0qN5omCxlOqW1IBYmnomXsBJNFkAijTjK67+lh0KKyxxOpwDA1JVQeTgVwScnQupyuDyBqHUonL4aNQrct+pPmodq2U2ozDmgS8ZvHF1lcw3iP/fSxoF9wexGtGa8bD/Wksm2feDTJnIYemxgQluCR9hBlKgFWMYnBnyeBOWjVYnNKVrdqvWM5BO0hHZzGEcBYAiA5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9akGEs+0OWbRGNGNIKiz/7IeWGOgXT+lx4fJW5Xp04M=;
 b=YJAV+f5RTUbPL+U4wDkjvyaUIpO9JGmNcYVnvpZhtGjBNtsnRzASTwZg4wVQQPhRf0+DZT1szKuT5sIiV75eSR2+nHeOzN+BGKhCMDssd1q1Zvu3Qhk8BlD79KrhkM+LRYu+RT0qWiCvycttWrDBTCBGeerBmqsML/RxwGKk4xZWltk8OXojh6Cv8EWeMtPrvRyVb3tRuQwuVze9wOMPXzx5gCfRWUZvKFj1zBfFQm3p2KZZzDrOeFhbK7frTD/VCW9rjmwxJiyI6U1DUJ3YteKnOMc15CWbtGql3FQuIL7fdKmB9uae69DHZA0ePuunN167VQjk37k/HKulpg2WbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9akGEs+0OWbRGNGNIKiz/7IeWGOgXT+lx4fJW5Xp04M=;
 b=iktEGPQhL4P7PXIk8K5IBOf/ZCMquQoDc8Bi6aURAWSQcGXzNZlumTyLDuNgaznumDgSRUJltEAjEVncrgeGZQRooHocx+rN+XKwVgOAYv+HgLtN/gY0ZK8kdsA5qrJnmLcoiDPc4y9twqK4g5W9HQkr82aeSv/oeJij+PRYwVbWbJX6za5fvUBrON596kpSuM0MAdCYhAkKtWcxQNhM0MMkeUWtWATbsbdpjI6v0lnYoOBQAeVGSXhdHN18Om7TqXk336Jjd5a56v2i8Kp6i/+W3l7/ilrYF/kDLzyYQbyKTP0CcH7GFy2d2mdV0pa9awGFxWYFMusCvXIUaorSVA==
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::2d)
 by BE3P281MB5184.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 13:05:35 +0000
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf]) by FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf%3]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 13:05:35 +0000
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
Subject: RE: [PATCH v5 3/9] iio: imu: inv_icm45600: add buffer support in iio
 devices
Thread-Topic: [PATCH v5 3/9] iio: imu: inv_icm45600: add buffer support in iio
 devices
Thread-Index: AQHcEd4ztutuCFLUl0eAj91guc48ZbRzNg+AgA/VtjA=
Date: Thu, 4 Sep 2025 13:05:35 +0000
Message-ID:
 <FR2PPF4571F02BCADA7BB96EF58E5AF67068C00A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <20250820-add_newport_driver-v5-0-2fc9f13dddee@tdk.com>
	<20250820-add_newport_driver-v5-3-2fc9f13dddee@tdk.com>
 <20250825114205.65ec79bc@jic23-huawei>
In-Reply-To: <20250825114205.65ec79bc@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2PPF4571F02BC:EE_|BE3P281MB5184:EE_
x-ms-office365-filtering-correlation-id: 85f6bdf7-6a40-4f06-7af7-08ddebb3bcbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|19092799006|38070700018|3613699012;
x-microsoft-antispam-message-info:
 =?utf-8?B?blpMZWFLUkZkMXhYOW51MGpHcm5wdlRGdWRrYUtJajZWNTMxcTlYNnVEYU80?=
 =?utf-8?B?VkV4bTg4VmNDQ0NpNEFRYitZZmozaDJxRFBWM1FOVXRyWGFrM25CSG15ZVpz?=
 =?utf-8?B?cHA0OFY3b0NaY0Q4bVNKSDcyUzdDQXJHRnpZSjZnZXhxRVVHOWh2YjV3amN2?=
 =?utf-8?B?T1dVeFdoOE9UWXY5ank1eC9TdVQ4d1BEYmc4VFo0TFpLc3krbEFRKzhCMldW?=
 =?utf-8?B?cHhLUnZXdkl1MmwxczZtQTJ0OXpHUHlsZkw1ZjlyTHRIV0lyWm95KzNIMlg1?=
 =?utf-8?B?TVpjNjFHenJ4alVDWHU3Mk8vdUcyNVB6Znd0bmtoU0EvTkNBZDJ1cWNybzNM?=
 =?utf-8?B?UHVWZ0Nyb3hZaWJJeDMwT2diNGhNRnVUUnFaYjlodjFTNW9zM1hvNlBSZ0lv?=
 =?utf-8?B?UWNVM0swdVpHRUJOcG5SZFROZmxTYzVYSFF4azZUdkhhcXphSlFDMDhRbUY0?=
 =?utf-8?B?aXFZenNEblJ6UFZNeXc4cGd4NlRpd1QrY0J4NXhSSENIMGgxdThVakdlemZI?=
 =?utf-8?B?dldvSWVXdXlsemUzdDFqRFRRZUdTbFNLSnFIanhQYUNiVk9QRTV6SzU4Nzgw?=
 =?utf-8?B?eFU4VFlDWlhIMmZHUjd4OHhIZENSQU5PbkVDV0w3MHhLWWJ4engxbGxWcUlE?=
 =?utf-8?B?cWllc1RSY0FpdUpFc1g0Rk9meEloZnZ6MExqVmkvNWFZaThGZU53Z1dSVDly?=
 =?utf-8?B?M3J5Tm5acjBoY2N5bnNJZ1psVGhKSzBzUzhTN2ZOLzgxQ2tFNVk2M0JVSVFP?=
 =?utf-8?B?TGd1MndkSC9aVElrWHNud0UwQjMxMmNEKy9FcGlWNHNCckF5OXBCQUZBa01U?=
 =?utf-8?B?MXo1VVNxVGlDQlQ4R3pwQWp3U0JNR1RyTWpnRzRpSHVxZVppWnFYYlQ3OGg4?=
 =?utf-8?B?T1M4YkFTbDFFdElvS2lVRVN1eHA3cytDbm5ISVhzS2lnS09XUXM3MDFSSzZj?=
 =?utf-8?B?dndON1ZDbFM5Qnp5ZlBRNlFOR2E4ZWRUaDEvVDFzajg5dnhTSEFMaE5LTU9W?=
 =?utf-8?B?WkxFR3ZVekl0b2t5N1lscjRUT3VtMk91N0ppYm1FQnVxSTc2MzcxdEIxOU9P?=
 =?utf-8?B?emxQNEdheEdtcWdoWm5zRGtrNkpLczFhYjZZZU53Z3hIYi9jUWpIdFRUQlNu?=
 =?utf-8?B?dko0MWNDa0YwRlU0M2Vib2hvSy96UnpjK0h5Y2MxTnlKTHpNTE9PZ1BvaW5p?=
 =?utf-8?B?c3FoOTlDbDJyMlduMS9mVE5SeXZIL21Zcm1KclJGSFhJM1pGb29FMlFqV3NN?=
 =?utf-8?B?ekx0SkM1MjNtOVhWcG40enhleHRRaDFNWjBacTZiWG5acG51eWxLcDFxVldB?=
 =?utf-8?B?NTgvNlcyZXhRWERraHNXdUQ1VWQzbjRLWGlncjVTZ2licDkyNVlwakI0UGRP?=
 =?utf-8?B?U3JvOU1IRHZhMFZxOEQwNkFNdEJ5RFljbjlGRUJyc050RStoNXJRQ0hzM0kw?=
 =?utf-8?B?VHZicmhtZHA0dWdURER1L04yN2Z2YWZwOEljb1JLWHRscjhHLy9BN1QrZnox?=
 =?utf-8?B?NVA1V1FEVkwzQ3FtT1BhNWsxU2VMMXNNV29sNUxCK1p4cGJEb2R0aUZTeFd4?=
 =?utf-8?B?N1pWOElOdElPMEdKenc5S2duK01vdTBUQnBDQ2Zzb1A4QjJYYkFLU2k5bWpR?=
 =?utf-8?B?QjBOdGV0ZS81V1E1VkJlWVNEdjNpSDArMTRSUTZpRzBkTERJY2RsMnJRZTkr?=
 =?utf-8?B?MDBWMHdTMGpJSjg3SEFqZ0VXc0pkVmgydCtaY3VSRCs4K0dzcHM3ajVmZmUr?=
 =?utf-8?B?YVNPR1RqRGY0Zm8xempNUVQxWWcwMXRaVjRhUTEzc0lTdlM2UmJDeUkwNjZV?=
 =?utf-8?B?Zm1IcExuQXgvTnBCeDRsd21YN0RvZWhjYXNhUlF0NENSVk5PZHl0QVZuSzZy?=
 =?utf-8?B?RE1XOWVWb2N4K1NzTzVUTDBJYVdiQnZoQldraFUzLzZ3R082a0pQSXp3b0wz?=
 =?utf-8?B?MEtSUHVFbXRya3ovY09rK2NnUVNNYWVLYkYxd3YxQnF4WnpTYnlQT2I2MXZa?=
 =?utf-8?B?c3M3Z0NsT3JFK1B5UHNkMTRnMlVNL1dUd0d5c3FMc0g5OWtxb3o1eTJzZFl2?=
 =?utf-8?Q?XYGgXG?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(19092799006)(38070700018)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OXV5UzNsbTUrTmI5cnNxT2ZQbkYvNVJaNDUrR2pXVlVnelZvOEpTNHNCOGFh?=
 =?utf-8?B?dDliQXd2cmNLcUdqR0hNMHVTcWJJeWxFSmpxNS9ESkpabDVHbSt3bmtFNUVy?=
 =?utf-8?B?MFFXaU5HcVZCOExPRTdpL1VET1JLazZMRzhCWlZxbWpSL1F1aGhRaklVeUhM?=
 =?utf-8?B?dnZsZVlVakduM0ZHaFNtbmFkdHpRek9HS2ZRWFNsbkNXT2dmWGsvN09keWxq?=
 =?utf-8?B?N0RyRC9IQU9SVG9raGs4NXdwNTJ1VDduUmdVVXZ3ZXJOQWEzTGNvVERZQTR5?=
 =?utf-8?B?blltVHR1Mnc5SVU1K3FpZXVkNzFrdDQrVW1SN3JWOUdUdy9kV3ZDRWIxa2Jl?=
 =?utf-8?B?OEdmcU1CQXg3RDJCOFRmak9IUGlEODZ0MDQ0YjIrVmFoamNnSGNwT2FhVklP?=
 =?utf-8?B?VGxsVmtzczR6N1VmUVFmVS8zeTBTSjFwdXBUN1o2cmRKWnlXekZlakt3ak41?=
 =?utf-8?B?RHYzTjFFQjd0VGIwTEFCRm9pYmhuMVhmYkVkOFZYWUNGTTI4R0VNa0JjT3hF?=
 =?utf-8?B?ZExUb244MEhtOWJEK3g2UWxleW9WeUJCbldUamRYcWlaUmM5QUdqeUxtUHRZ?=
 =?utf-8?B?Y0M1N3FzWVBGZ2c4aXNmenFaQ09nOVd1Ymgxd1M3V1hCUEJaYUs2NWZtZnJR?=
 =?utf-8?B?VDR5WUNvUzg2RFBqUEVWZFlwNUVmZ05wQStsNzdZUVZKZ2Z0K1lVdXNzbmJi?=
 =?utf-8?B?UlRwMXBnV3pJbVdZWXpHdW1CTzdGYnFCOUtEMjRna0lQNDhyVkxwYkZyRVRu?=
 =?utf-8?B?ekkvQUlJZlUxeVY3c2JWY1B4ZXYxc1VQcFBWelk3M25WM3psUDkzditTSjMv?=
 =?utf-8?B?UHpCa2lCM2VGeVZHZlJXMWw0UDQ5K2d1aVBGMGE4TWZnckhzMXQ1b0kybW94?=
 =?utf-8?B?RjhnNzFYbVFLQkxXZDM5Z3IvWjI0dlFzTEFmZ0dWeUZCbTBmRkdaR2pIc1h6?=
 =?utf-8?B?UkxPamxtZU9Ucmx4aThlT2FHTlJCZk1KRkhFd3ZWTVJJMVpCZ2NoZ1ZRTk9x?=
 =?utf-8?B?S3NGdTlYdjZGK2ljY2NlN0xrTHZkU2NUNDE2aDQ4UHlsN05NeXVCMTc2R0dD?=
 =?utf-8?B?WWMydTYxb3VmMVNHVjlKQ0FYK0VYV20wREJaOEZXMkRsL3hDUHVyenFaVVhY?=
 =?utf-8?B?MGduckduajdSZmk0TExvNUFyMFBtNml2amNCVFlKdGhhRVRGWFFkQkVXb3hF?=
 =?utf-8?B?eEJId2hmMTlpemtnRUdrdnI1eHJ5OVo2bU5ueiszK25OVXNBTVVWRGNYY0Qx?=
 =?utf-8?B?LzlpQnIwYjltSUxjM2x1Y3dEbloyMW9GVmlXNkJKSjNjdGVpdzZacXpuZ1Fq?=
 =?utf-8?B?cE1ibHR5OWdwbytzUTFHK2UrczY4ekJaZXFGRTFPQVZMdUNCM3RwRm16WUdT?=
 =?utf-8?B?V2pwOEIxblpQTEtMb0t4Wk1zZnVWZkl6OE1STHlieFFIK2tWZU10V2Jpb1Ft?=
 =?utf-8?B?T3lHWU5BZHUrcFUyUEJEclhxekxNczRyWElBNk1GMllZdkNwa2UxeEFBM2VP?=
 =?utf-8?B?bTdUSEFJK3VXQTRPYUdTdWxqU1QzUmoxMXpyK0lEajkrKy9QVTE0cEZrVGRI?=
 =?utf-8?B?TkZnczRiVXN5NU1hL2oyVktMcE1WV0ptcVliSTlUWWFaVU1ocFpDRmJpMUFZ?=
 =?utf-8?B?aVZua1FMUy9OYjY5NU9HaG8wZ0Fna1IxZEV3ekk2MGQ5VFZXOVYxQUh5V2FQ?=
 =?utf-8?B?azRKQml0aHVrL0o4L1NrY29qcmRDcWJrNldNVXg4U1RMOEZycGVCaUdwSkho?=
 =?utf-8?B?bjJSL0FldU9BTmhMWStiT0kwOC9RRlRLS1hPSXgwd2NOdkRYOGZsaTVWYmRB?=
 =?utf-8?B?d2toSXdMWXRYbFpJUERnVFNvOVM3cUV4TjZYZ1FUdVlRT1U0WTZGbkVBWHM0?=
 =?utf-8?B?UkhtVUZYdjNqUWhWTXNpNElENFB0QmFTa1paSko2NzFXU3NHb1RIMlRrK05y?=
 =?utf-8?B?QUlNcERxcDVSYlVYTXlOclB2QktrUmFoN0hQWVFNdTJtVEllQTdPUVZJSFJq?=
 =?utf-8?B?WFVMMUpVUzB0cWllaXYyMVIwa0s1N2RZWEJqdHdKVWY3RFo0bTFKaVJqRE1Q?=
 =?utf-8?B?akdkdUVyMFVtYURMdEx5T1Bmc2Q1K1MzU2RaNUdnS0s3TlVKYzBlMFlUeHQx?=
 =?utf-8?B?OENFeng2enRaN3JpNDBSbnJMOEhvdHBtcW1jT1JBYWxlcHJYNVhKckhvMzhs?=
 =?utf-8?Q?BxYQ4ko32HXI24KD0RDlGuS5pHhSyBqy6HSA1W1QhaWH?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f6bdf7-6a40-4f06-7af7-08ddebb3bcbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 13:05:35.4569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vDONX3j131TdmdWr7gq1Uyz8oYiomqXAEUp4zA8nJSaUG+F3B7qQ/W4ctalHDaOm9iyJ9uSnf5g5La4gM3bvvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE3P281MB5184
X-Proofpoint-ORIG-GUID: yLryjLdekQKULTG4Ge9rbpxnaphVEjik
X-Proofpoint-GUID: yLryjLdekQKULTG4Ge9rbpxnaphVEjik
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxMyBTYWx0ZWRfX+9RQYiaxFMDU
 w+QbqjKKNVe+jqMk8h479sR0wl+ZWa9Frd+LKn/HufnBrIx3+MgCQrAamvvY2TW1sWN+A2kEUq7
 D+onn0hlhUI0AxMSRiz/BVXedvmdUnkHyaHtg7hciU/ws9Zf7sODLu4RMN6BSeS3xnUa/mEfPO3
 MCFtcUZxrNjrRVgigV1wGLp1pX8NnPa9Y+6XPgzesUPolQ8ZBNemsqFdviI7qgf7pHPN0TO0f14
 Wzs59NmlAx3M9DRAG9j66IuG7D/fKsv3DwPPqGf01pI/vaMa+jqV+2lgqc+F+dYg5CWB0gu7UA9
 mwuZPtoYzMHJxRiIl6seMmd9KTKcrLOK1wjXtolnjOe9ZBu8jRlcHOevqFWupl7Zc3U++1f9hsU
 ipg4tuX9
X-Authority-Analysis: v=2.4 cv=MutS63ae c=1 sm=1 tr=0 ts=68b98ea8 cx=c_pps
 a=GU2idFwePczY1mnoXsBpeA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=Uwzcpa5oeQwA:10 a=VwQbUJbxAAAA:8 a=In8RU02eAAAA:8
 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=_QWVDXu7F19YdXTI07QA:9 a=QEXdDO2ut3YA:10
 a=EFfWL0t1EGez1ldKSZgj:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 impostorscore=0 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300013

Pg0KPg0KPkZyb206IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+IA0KPlNlbnQ6
IE1vbmRheSwgQXVndXN0IDI1LCAyMDI1IDEyOjQyIFBNDQo+VG86IFJlbWkgQnVpc3NvbiB2aWEg
QjQgUmVsYXkgPGRldm51bGwrcmVtaS5idWlzc29uLnRkay5jb21Aa2VybmVsLm9yZz4NCj5DYzog
UmVtaSBCdWlzc29uIDxSZW1pLkJ1aXNzb25AdGRrLmNvbT47IERhdmlkIExlY2huZXIgPGRsZWNo
bmVyQGJheWxpYnJlLmNvbT47IE51bm8gU8OhIDxudW5vLnNhQGFuYWxvZy5jb20+OyBBbmR5IFNo
ZXZjaGVua28gPGFuZHlAa2VybmVsLm9yZz47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+
OyBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkg
PGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1paW9Admdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPlN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjUgMy85XSBpaW86IGltdTogaW52X2ljbTQ1NjAwOiBhZGQgYnVmZmVy
IHN1cHBvcnQgaW4gaWlvIGRldmljZXMNCj4NCj5PbiBXZWQsIDIwIEF1ZyAyMDI1IDE0OjI0OjIx
ICswMDAwDQo+UmVtaSBCdWlzc29uIHZpYSBCNCBSZWxheSA8ZGV2bnVsbCtyZW1pLmJ1aXNzb24u
dGRrLmNvbUBrZXJuZWwub3JnPiB3cm90ZToNCj4NCj4+IEZyb206IFJlbWkgQnVpc3NvbiA8cmVt
aS5idWlzc29uQHRkay5jb20+DQo+PiANCj4+IEFkZCBGSUZPIGNvbnRyb2wgZnVuY3Rpb25zLg0K
Pj4gU3VwcG9ydCBod2ZpZm8gd2F0ZXJtYXJrIGJ5IG11bHRpcGxleGluZyBneXJvIGFuZCBhY2Nl
bCBzZXR0aW5ncy4NCj4+IFN1cHBvcnQgaHdmaWZvIGZsdXNoLg0KPj4gDQo+PiBTaWduZWQtb2Zm
LWJ5OiBSZW1pIEJ1aXNzb24gPHJlbWkuYnVpc3NvbkB0ZGsuY29tPg0KPg0KPkEgZmV3IHJlYWxs
eSBtaW5vciB0aGluZ3MgaW5saW5lLg0KVGhhbmtzIQ0KPg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaWlvL2ltdS9pbnZfaWNtNDU2MDAvaW52X2ljbTQ1NjAwX2J1ZmZlci5jIGIvZHJpdmVycy9p
aW8vaW11L2ludl9pY200NTYwMC9pbnZfaWNtNDU2MDBfYnVmZmVyLmMNCj4+IG5ldyBmaWxlIG1v
ZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwLi41MGZkMjFhMjRlMzRkZWNmYmUxMDQyNjk0NmE1MWM2MTM1M2ViNmE5DQo+PiAtLS0gL2Rl
di9udWxsDQo+PiArKysgYi9kcml2ZXJzL2lpby9pbXUvaW52X2ljbTQ1NjAwL2ludl9pY200NTYw
MF9idWZmZXIuYw0KPg0KPj4gKw0KPj4gKy8qKg0KPj4gKyAqIGludl9pY200NTYwMF9idWZmZXJf
dXBkYXRlX3dhdGVybWFyayAtIHVwZGF0ZSB3YXRlcm1hcmsgRklGTyB0aHJlc2hvbGQNCj4+ICsg
KiBAc3Q6CWRyaXZlciBpbnRlcm5hbCBzdGF0ZQ0KPj4gKyAqDQo+PiArICogUmV0dXJucyAwIG9u
IHN1Y2Nlc3MsIGEgbmVnYXRpdmUgZXJyb3IgY29kZSBvdGhlcndpc2UuDQo+PiArICoNCj4+ICsg
KiBGSUZPIHdhdGVybWFyayB0aHJlc2hvbGQgaXMgY29tcHV0ZWQgYmFzZWQgb24gdGhlIHJlcXVp
cmVkIHdhdGVybWFyayB2YWx1ZXMNCj4+ICsgKiBzZXQgZm9yIGd5cm8gYW5kIGFjY2VsIHNlbnNv
cnMuIFNpbmNlIHdhdGVybWFyayBpcyBhbGwgYWJvdXQgYWNjZXB0YWJsZSBkYXRhDQo+PiArICog
bGF0ZW5jeSwgdXNlIHRoZSBzbWFsbGVzdCBzZXR0aW5nIGJldHdlZW4gdGhlIDIuIEl0IG1lYW5z
IGNob29zaW5nIHRoZQ0KPj4gKyAqIHNtYWxsZXN0IGxhdGVuY3kgYnV0IHRoaXMgaXMgbm90IGFz
IHNpbXBsZSBhcyBjaG9vc2luZyB0aGUgc21hbGxlc3Qgd2F0ZXJtYXJrDQo+PiArICogdmFsdWUu
IExhdGVuY3kgZGVwZW5kcyBvbiB3YXRlcm1hcmsgYW5kIE9EUi4gSXQgcmVxdWlyZXMgc2V2ZXJh
bCBzdGVwczoNCj4+ICsgKiAxKSBjb21wdXRlIGd5cm8gYW5kIGFjY2VsIGxhdGVuY2llcyBhbmQg
Y2hvb3NlIHRoZSBzbWFsbGVzdCB2YWx1ZS4NCj4+ICsgKiAyKSBhZGFwdCB0aGUgY2hvc2VuIGxh
dGVuY3kgc28gdGhhdCBpdCBpcyBhIG11bHRpcGxlIG9mIGJvdGggZ3lybyBhbmQgYWNjZWwNCj4+
ICsgKiAgICBvbmVzLiBPdGhlcndpc2UgaXQgaXMgcG9zc2libGUgdGhhdCB5b3UgZG9uJ3QgbWVl
dCBhIHJlcXVpcmVtZW50LiAoZm9yDQo+PiArICogICAgZXhhbXBsZSB3aXRoIGd5cm8gQDEwMEh6
IHdtIDQgYW5kIGFjY2VsIEAxMDBIeiB3aXRoIHdtIDYsIGNob29zaW5nIHRoZQ0KPj4gKyAqICAg
IHZhbHVlIG9mIDQgd2lsbCBub3QgbWVldCBhY2NlbCBsYXRlbmN5IHJlcXVpcmVtZW50IGJlY2F1
c2UgNiBpcyBub3QgYQ0KPj4gKyAqICAgIG11bHRpcGxlIG9mIDQuIFlvdSBuZWVkIHRvIHVzZSB0
aGUgdmFsdWUgMi4pDQo+PiArICogMykgU2luY2UgYWxsIHBlcmlvZHMgYXJlIG11bHRpcGxlIG9m
IGVhY2ggb3RoZXJzLCB3YXRlcm1hcmsgaXMgY29tcHV0ZWQgYnkNCj4+ICsgKiAgICBkaXZpZGlu
ZyB0aGlzIGNvbXB1dGVkIGxhdGVuY3kgYnkgdGhlIHNtYWxsZXN0IHBlcmlvZCwgd2hpY2ggY29y
cmVzcG9uZHMNCj4+ICsgKiAgICB0byB0aGUgRklGTyBmcmVxdWVuY3kuDQo+PiArICovDQo+PiAr
aW50IGludl9pY200NTYwMF9idWZmZXJfdXBkYXRlX3dhdGVybWFyayhzdHJ1Y3QgaW52X2ljbTQ1
NjAwX3N0YXRlICpzdCkNCj4+ICt7DQo+PiArCWNvbnN0IHNpemVfdCBwYWNrZXRfc2l6ZSA9IHNp
emVvZihzdHJ1Y3QgaW52X2ljbTQ1NjAwX2ZpZm9fMnNlbnNvcnNfcGFja2V0KTsNCj4+ICsJdW5z
aWduZWQgaW50IHdtX2d5cm8sIHdtX2FjY2VsLCB3YXRlcm1hcms7DQo+PiArCXUzMiBwZXJpb2Rf
Z3lybywgcGVyaW9kX2FjY2VsLCBwZXJpb2Q7DQo+PiArCXUzMiBsYXRlbmN5X2d5cm8sIGxhdGVu
Y3lfYWNjZWwsIGxhdGVuY3k7DQo+PiArDQo+PiArCS8qIENvbXB1dGUgc2Vuc29ycyBsYXRlbmN5
LCBkZXBlbmRpbmcgb24gc2Vuc29yIHdhdGVybWFyayBhbmQgb2RyLiAqLw0KPj4gKwl3bV9neXJv
ID0gaW52X2ljbTQ1NjAwX3dtX3RydW5jYXRlKHN0LT5maWZvLndhdGVybWFyay5neXJvLCBwYWNr
ZXRfc2l6ZSwNCj4+ICsJCQkJCSAgIHN0LT5maWZvLnBlcmlvZCk7DQo+PiArCXdtX2FjY2VsID0g
aW52X2ljbTQ1NjAwX3dtX3RydW5jYXRlKHN0LT5maWZvLndhdGVybWFyay5hY2NlbCwgcGFja2V0
X3NpemUsDQo+PiArCQkJCQkgICAgc3QtPmZpZm8ucGVyaW9kKTsNCj4+ICsJLyogVXNlIHVzIGZv
ciBvZHIgdG8gYXZvaWQgb3ZlcmZsb3cgdXNpbmcgMzIgYml0cyB2YWx1ZXMuICovDQo+PiArCXBl
cmlvZF9neXJvID0gaW52X2ljbTQ1NjAwX29kcl90b19wZXJpb2Qoc3QtPmNvbmYuZ3lyby5vZHIp
IC8gMTAwMFVMOw0KPj4gKwlwZXJpb2RfYWNjZWwgPSBpbnZfaWNtNDU2MDBfb2RyX3RvX3Blcmlv
ZChzdC0+Y29uZi5hY2NlbC5vZHIpIC8gMTAwMFVMOw0KPj4gKwlsYXRlbmN5X2d5cm8gPSBwZXJp
b2RfZ3lybyAqIHdtX2d5cm87DQo+PiArCWxhdGVuY3lfYWNjZWwgPSBwZXJpb2RfYWNjZWwgKiB3
bV9hY2NlbDsNCj4+ICsNCj4+ICsJLyogMCB2YWx1ZSBmb3Igd2F0ZXJtYXJrIG1lYW5zIHRoYXQg
dGhlIHNlbnNvciBpcyB0dXJuZWQgb2ZmLiAqLw0KPj4gKwlpZiAod21fZ3lybyA9PSAwICYmIHdt
X2FjY2VsID09IDApDQo+PiArCQlyZXR1cm4gMDsNCj4+ICsNCj4+ICsJaWYgKGxhdGVuY3lfZ3ly
byA9PSAwKSB7DQo+PiArCQl3YXRlcm1hcmsgPSB3bV9hY2NlbDsNCj4+ICsJCXN0LT5maWZvLndh
dGVybWFyay5lZmZfYWNjZWwgPSB3bV9hY2NlbDsNCj4+ICsJfSBlbHNlIGlmIChsYXRlbmN5X2Fj
Y2VsID09IDApIHsNCj4+ICsJCXdhdGVybWFyayA9IHdtX2d5cm87DQo+PiArCQlzdC0+Zmlmby53
YXRlcm1hcmsuZWZmX2d5cm8gPSB3bV9neXJvOw0KPj4gKwl9IGVsc2Ugew0KPj4gKwkJLyogQ29t
cHV0ZSB0aGUgc21hbGxlc3QgbGF0ZW5jeSB0aGF0IGlzIGEgbXVsdGlwbGUgb2YgYm90aC4gKi8N
Cj4+ICsJCWlmIChsYXRlbmN5X2d5cm8gPD0gbGF0ZW5jeV9hY2NlbCkNCj4+ICsJCQlsYXRlbmN5
ID0gbGF0ZW5jeV9neXJvIC0gKGxhdGVuY3lfYWNjZWwgJSBsYXRlbmN5X2d5cm8pOw0KPj4gKwkJ
ZWxzZQ0KPj4gKwkJCWxhdGVuY3kgPSBsYXRlbmN5X2FjY2VsIC0gKGxhdGVuY3lfZ3lybyAlIGxh
dGVuY3lfYWNjZWwpOw0KPj4gKwkJLyogVXNlIHRoZSBzaG9ydGVzdCBwZXJpb2QuICovDQo+PiAr
CQlwZXJpb2QgPSBtaW4ocGVyaW9kX2d5cm8sIHBlcmlvZF9hY2NlbCk7DQo+PiArCQkvKiBBbGwg
dGhpcyB3b3JrcyBiZWNhdXNlIHBlcmlvZHMgYXJlIG11bHRpcGxlIG9mIGVhY2ggb3RoZXJzLiAq
Lw0KPj4gKwkJd2F0ZXJtYXJrID0gbWF4KGxhdGVuY3kgLyBwZXJpb2QsIDEpOw0KPj4gKwkJLyog
VXBkYXRlIGVmZmVjdGl2ZSB3YXRlcm1hcmsuICovDQo+PiArCQlzdC0+Zmlmby53YXRlcm1hcmsu
ZWZmX2d5cm8gPSBtYXgobGF0ZW5jeSAvIHBlcmlvZF9neXJvLCAxKTsNCj4+ICsJCXN0LT5maWZv
LndhdGVybWFyay5lZmZfYWNjZWwgPSBtYXgobGF0ZW5jeSAvIHBlcmlvZF9hY2NlbCwgMSk7DQo+
PiArCX0NCj4+ICsNCj4NCj4xIGJsYW5rIGxpbmUgaXMgZW5vdWdoLg0KT2suDQo+DQo+PiArDQo+
PiArCXN0LT5idWZmZXIudTE2ID0gY3B1X3RvX2xlMTYod2F0ZXJtYXJrKTsNCj4+ICsJcmV0dXJu
IHJlZ21hcF9idWxrX3dyaXRlKHN0LT5tYXAsIElOVl9JQ000NTYwMF9SRUdfRklGT19XQVRFUk1B
UkssDQo+PiArCQkJCSAmc3QtPmJ1ZmZlci51MTYsIHNpemVvZihzdC0+YnVmZmVyLnUxNikpOw0K
Pj4gK30NCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vaW11L2ludl9pY200NTYwMC9p
bnZfaWNtNDU2MDBfYnVmZmVyLmggYi9kcml2ZXJzL2lpby9pbXUvaW52X2ljbTQ1NjAwL2ludl9p
Y200NTYwMF9idWZmZXIuaA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAuLmRhNDYzNDYxYjVmMjcwODAxNDEy
NmY4NjhmYTYwMDhkYjA1MjBhNGUNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL2RyaXZlcnMv
aWlvL2ltdS9pbnZfaWNtNDU2MDAvaW52X2ljbTQ1NjAwX2J1ZmZlci5oDQo+DQo+DQo+PiArDQo+
PiArc3RhdGljIGlubGluZSBzMTYgaW52X2ljbTQ1NjAwX2ZpZm9fZ2V0X3NlbnNvcl9kYXRhKF9f
bGUxNiBkKQ0KPj4gK3sNCj4+ICsJcmV0dXJuIGxlMTZfdG9fY3B1KGQpOw0KPkknbSBub3QgcmVh
bGx5IHNlZWluZyBhZHZhbnRhZ2Ugb2YgdGhpcyB3cmFwcGVyIHZzIGp1c3QgdXNpbmcgbGUxNl90
b19jcHUoKQ0KPmlubGluZS4NCg0KVGhlcmUgaXMgYWN0dWFsbHkgbm8gcmVhc29uLCBJJ2xsIHNp
bXBsaWZ5IHRoaXMuDQo+DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBpbmxpbmUgYm9vbA0KPj4g
K2ludl9pY200NTYwMF9maWZvX2lzX2RhdGFfdmFsaWQoY29uc3Qgc3RydWN0IGludl9pY200NTYw
MF9maWZvX3NlbnNvcl9kYXRhICpzKQ0KPj4gK3sNCj4+ICsJczE2IHgsIHksIHo7DQo+PiArDQo+
PiArCXggPSBpbnZfaWNtNDU2MDBfZmlmb19nZXRfc2Vuc29yX2RhdGEocy0+eCk7DQo+PiArCXkg
PSBpbnZfaWNtNDU2MDBfZmlmb19nZXRfc2Vuc29yX2RhdGEocy0+eSk7DQo+PiArCXogPSBpbnZf
aWNtNDU2MDBfZmlmb19nZXRfc2Vuc29yX2RhdGEocy0+eik7DQo+CXggPSBsZTE2X3RvX2NwdShz
LT54KTsNCj4NCj5pcyBwcmV0dHkgb2J2aW91cy4NCkFuZCBmYXIgbW9yZSBzdHJhaWdodGZvcndh
cmQuDQo+DQo+PiArDQo+PiArCWlmICh4ID09IElOVl9JQ000NTYwMF9EQVRBX0lOVkFMSUQgJiYN
Cj4+ICsJICAgIHkgPT0gSU5WX0lDTTQ1NjAwX0RBVEFfSU5WQUxJRCAmJg0KPj4gKwkgICAgeiA9
PSBJTlZfSUNNNDU2MDBfREFUQV9JTlZBTElEKQ0KPj4gKwkJcmV0dXJuIGZhbHNlOw0KPj4gKw0K
Pj4gKwlyZXR1cm4gdHJ1ZTsNCj4+ICt9DQo+DQo+DQo+DQo=

