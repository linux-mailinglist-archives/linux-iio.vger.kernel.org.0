Return-Path: <linux-iio+bounces-23773-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6083B4580A
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 14:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D2643B27C7
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 12:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDE434DCE1;
	Fri,  5 Sep 2025 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="PYt+dbBL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04C322FF22;
	Fri,  5 Sep 2025 12:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757076200; cv=fail; b=pLIhkKszgGGX/c16srY9CNK9K2xMXXUUC503rXRAMYEz8mv4r+/9v2msSK3NN/9pA5MHgjlZiUeEll7nhhwRb+IOHk8X8SNjVo/fcdlDuMRTv5pwmdoc8Cpju/EJvGKNVWIvdU/GceE1Jog9MxuMY0p/vg0+dSNbPk72UEUmH24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757076200; c=relaxed/simple;
	bh=Pm2+DSwGDwGV8yjEWkaM/K9/QEP9KlySIvTKi2aLZcQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fiH328K80KTNCeuyGyYHJCQkBUjJMicIAdGep5NOgwOIa2toZyFnYXMRotwzHpp+brj5ujN4NQr6PbldLmUS+b1CJur5WVYO3GxGktZ3wJCodBouBeFNPtjESY8Ebk8yHL6Nt4fPI7zeHww0HG6z5HeLyUqJ3sc/ELFB5rKqKfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=PYt+dbBL; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584Le3Fg009812;
	Fri, 5 Sep 2025 12:43:09 GMT
Received: from fr6p281cu001.outbound.protection.outlook.com (mail-germanywestcentralazon11010048.outbound.protection.outlook.com [52.101.171.48])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 48uqp04ynb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 12:43:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ey6P/4A1JfuVNv1HEI879bmSofAaGGMRJ2Ir/henR17Ax7Y9r0EwaMNi7iZWIDVDUanu5x8gnUIMiS1Ej26vehhgiE52Wee0bac06wsetcqNWiGK46BZx4ALYijK72e5h5BhTVEuj13s0gfa0aK8EVvqp3nFuHJwvb5TxCopBxzJHxQnoJPcYXY4PpATLXEI+Vio4l/+uBXF9SOw8jXe+nd+B/kR3D+bNQYXqy6Ju/dUC7FAZ+Kv99DxBze7KKOgXzLvXsBvD625uYVmrw+lZIZjkseJtkK0iLyAjtw9rEKucq6kpSuPigH/HVcPOW1q9I/WtEq/McK58ivIKWzNsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pm2+DSwGDwGV8yjEWkaM/K9/QEP9KlySIvTKi2aLZcQ=;
 b=FxrsZF4veuQk4oG9zFYzMB5EpzX8bEWWgpq82XZi3TaH4eRLR0IKcEZCVXBGUjKIP7rbpCS1iCewKiRjrXMRI8utjAz2chAECVakLrSM6YulGUJjCFKsY4IJUr0RWvEgxsRJgzdFaDp/Mfuij2e7608snAxyy5SNAev08Wptgj9BcKfQ29o9K/k8POXlD82QeT/FUOofBnLwJo/RCHTOXbjUFhm57sfhWTeLBJFBYL4I3k1PEAfy+tlOAy8tZcxeUlWigGmpWvTetq4vykx5Pbh22nod1Fb0gKC8y7ZyMXRiC5GcJsKLYueXsgW/mHCLc7V32Wwm/thUdWcXxhVojA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pm2+DSwGDwGV8yjEWkaM/K9/QEP9KlySIvTKi2aLZcQ=;
 b=PYt+dbBL415FY9DQu1p4r8wck4InwJ/QiiiPsMgHj2q6Flw5juXnF0mzn0X06z3UleY5GWSDQEOIiOyFgIhFrgGbb11nh91CGEOcuvs+3BfVjYMOHIQAzstTPMhe7nxI2KSeSHNPQZppJPFz/suL8kpCMZ2l6MWdQLo3pe5uW/3e+1vLzt3jdPPRXdTfqPtb2hBZ5gQOH5QaS3Tee5+a2M7sCBLH7Lg7fdmTPwP9yvmyDEUVWO0AK4oqi985Xte2tfqrQy94Ud1JdeGARqnjNzxAXNSSPcmA4nRuMjzzBJMIOaciLsDdJHiA5qL2xFqOhV8d6r0TQOO8xSnpWph/Ag==
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::2d)
 by FR3P281MB1695.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:6c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 12:43:02 +0000
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf]) by FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf%3]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 12:43:02 +0000
From: Remi Buisson <Remi.Buisson@tdk.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v5 2/9] iio: imu: inv_icm45600: add new inv_icm45600
 driver
Thread-Topic: [PATCH v5 2/9] iio: imu: inv_icm45600: add new inv_icm45600
 driver
Thread-Index: AQHcEd4zsEmltqAvrUWqK+UpNdHo0bRs0P2AgBXgXvCAAGdbAIABiFaw
Date: Fri, 5 Sep 2025 12:43:02 +0000
Message-ID:
 <FR2PPF4571F02BC9E34D445208601939C798C03A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <20250820-add_newport_driver-v5-0-2fc9f13dddee@tdk.com>
 <20250820-add_newport_driver-v5-2-2fc9f13dddee@tdk.com>
 <aKbgt_g3FsLMM8-g@smile.fi.intel.com>
 <FR2PPF4571F02BCC073F7740CBA818676388C00A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
 <aLmRWHZ-fNYjeYll@smile.fi.intel.com>
In-Reply-To: <aLmRWHZ-fNYjeYll@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2PPF4571F02BC:EE_|FR3P281MB1695:EE_
x-ms-office365-filtering-correlation-id: 83be8b24-9539-45df-e7c9-08ddec79c0a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|366016|38070700018|3613699012;
x-microsoft-antispam-message-info:
 =?utf-8?B?MmdRRXpEZWxvWnZSL1JNNTEyeGpHNzFKU1F4UHZNZmZqMk1lamcrWEN2TExM?=
 =?utf-8?B?SDN3eEdIZ1VyQTJYYW1Fc1prR0tIZU5kTlJWQzhHc1l6WU9uY01tNTNITUxF?=
 =?utf-8?B?My9tVllTa3YzQVdDU3k2STRvazA2MjdYZTUram1KZG83VzlyeHNJbnA3QTA5?=
 =?utf-8?B?S281bXlOc0IxUFd5S3daT1V3UmZrMUEvbUpFNnM4K2lPTEdjVHZRUjdhU010?=
 =?utf-8?B?VmJRR2VUeFpmVTlWNFRkZ1JGVmhEenF6WnozL3U0TTRxUUtGNlN0eHVxeTF4?=
 =?utf-8?B?QzVHaU0vb2J2aFEwR2tXT0RrdDlUeWUwRENNekpHcjYvZWNTQmdPVWgxVk1Z?=
 =?utf-8?B?dnk1cmt3V0xGdFN0VmE0Z2hrVmRZUEl3cWtOTlJucnFRT3EvRU1IaDVGYzdt?=
 =?utf-8?B?bFZ5RnlrSk5maXVtTUMrNE5yWkVZTnprYlU3UldBSUhCbnh4MVJLcTJheWVz?=
 =?utf-8?B?cGZCQ2c1Z3A0bWJPalF1cW53VnZHYVdHN2dPemtWcDBMYjJONVY3UVhsSE5X?=
 =?utf-8?B?TnBmcGZjamJnbTIyR1I3MTNTb2UrS2QzVnJYMXRkMyt5YVhRaEsybVVKdFNm?=
 =?utf-8?B?ZjZQbU5RQWFjeFJpRER6TGxpd1FwbTV4MVI3MmF2SFNzZTlpWlNtU1BNa0tU?=
 =?utf-8?B?M0JIYUVSNjEzeUFMZE1WZGpjMVhtVW43RjBHbXZLSkVSZzZheWdHRmlZUzdU?=
 =?utf-8?B?dHRYSzlUaEtmZTZOMUxDUVBScG02VnhVSVJnemNubzVLUFlIeXdTU2VNbTJI?=
 =?utf-8?B?Ymd2STN2TW5XQldUZmRhUWpiQVZpOGZnS1hlOXRzMjdtUWFxTUxJejBwbmZz?=
 =?utf-8?B?UE5IcG4ybm55TjZGMW5URHcxb2puZ0hsR1hTMFF0dlRJYkhUemRQdFpFcGhl?=
 =?utf-8?B?SS90ZGlSZjVueG5BK0ZwcFh3dXJ3UkRBQWc0RGVTRlFnRVVra3JFU2tvZDR1?=
 =?utf-8?B?TXBGbTU4MjlVUHR5dXIxa21GM0J4Uk1GZmNORDNMR2IyVzFibHpJbEg0SHpy?=
 =?utf-8?B?dmFhQ2htd25RS3podW9YUlc3T3lDT1RPQjlRUVVyczVESUVOcjBkczk3Uis0?=
 =?utf-8?B?dnFSZFVqTFU1QWlxSVJhWlVKVkYvaFdJcll5bHhXbVZ2d1J2eGZGTGsxTGMw?=
 =?utf-8?B?ZHdZazZrbi9pbkVIVjFsYU91ODVCVmxUcTYxcnVETFVERDNleTVJZGRyS0ZL?=
 =?utf-8?B?TjFvNnZwRFc1WmlvVUNVdWdjN0VuMC9IazBvWHVVWTAzTDVhbmM3SDdOSmVQ?=
 =?utf-8?B?SFdkWkp5RVZsOWNNaFhsNGkrRmlHU2wyZ2tnMWFKUW5TQVdYUGVxRUR6dHk0?=
 =?utf-8?B?bmdaRTFSNHh2QVJUeDJnK2tQYzRqdnAyZEFoaXVpL3hKWEZqc0MrMGd1SlBY?=
 =?utf-8?B?RmkzaFZrQU1lN3N6TXRuK0hTUEpxTDhweU15TzV5RXFKcmFVTGl1UFhPVUJW?=
 =?utf-8?B?aXNBNTZ0N2ZpT3QwcEFqdmtER0tscXlsOE4yZC84WmZCRjU0UWJrT1E3VTV2?=
 =?utf-8?B?WlZGOGlnbHF3dnpSb1FySVVZUTFaeTJmZCsvdUp1R3A3cG9JNlhHVk5UNjRv?=
 =?utf-8?B?ZlFJZkhQdHR4UW4vTmN1VjA4N2VNTnVwbTBUOEoyR2FzVTNiNHNDcGpZYkNy?=
 =?utf-8?B?eXc5TDQ2aTFaTW1UZ0FCYmpzQlRGMXdLdGtVdnp4b0RsTDFGL1QrOGxVOGRa?=
 =?utf-8?B?amhaREhmbnQ0N1JpWkFKV1Q5all6Yy9DWXZYRm1TWFVVZHJqdVk4M0FjNkQ3?=
 =?utf-8?B?T3FQcXJKZHltRk50M3lmbk0vUEhsaWRmRVhYMEplOXREMXB5Z2V3U01FVy80?=
 =?utf-8?B?T2RHM04yb0NjV3Q1M01zaEx6cHBkMExLdU1mQi9XYXUrdjF1bllmblRsWEJh?=
 =?utf-8?B?V0MrZHVTUWpyOEl6Sjh3ellqdHRkOG1SQmU4SGE2RzNXQyt2YXNtVmN2OUZj?=
 =?utf-8?B?Ynp4NldqQVlRWXVsTy9aZzkwbWNmb3VKL0tNWHpoaGdPM3JoOHBWNXhkb2Zs?=
 =?utf-8?B?SW1SWTUvQWNIQ0d2MmN4WFVUYXp6cWFiUE1lU1ZaeE02M1kxblJOV21qWnJE?=
 =?utf-8?Q?WirBLd?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(366016)(38070700018)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a3JPcjV2d2ZidXpsdEYrb20rTnI0RmZWZEU5MXQ0QWJRSDMrdzlvK1dsZ0Vt?=
 =?utf-8?B?TnpDNzdIN1FrblM1WUxmWHhWYmw2cnNKUVQ2dmh1Y0lFUmtwV0plb0FaU3lX?=
 =?utf-8?B?L0F1TFN2TXV5SCtjelVKWS83YlpXajRad1REZFU5SGkyVVRmQ2JxMjJ4VTRL?=
 =?utf-8?B?UmFaNE4rVGJrbFBNc3dUdTRldFFNeDh2MFdQcmhDaHV2ZHhqY25xdzlEWG1P?=
 =?utf-8?B?NFZyaHB2Z093UTVxSVRoMmpsU1c2azMvN0dpN1ZaaWNVYUNqejBJM1I0Uzkr?=
 =?utf-8?B?T3V3MVdteVVzcHBFMDRKTUJqODZUa0FqWEVudjEyYko4MHgzaXo3dGl4bkMz?=
 =?utf-8?B?aGtRdVBpYThNVlhFK3EvSGt1VGVLSEhTOWdyWHIyMCtvdi8vK2MxVWZmZkdR?=
 =?utf-8?B?dnJQSzhVS1hCYk9MNndLeDZBOS90Y3k1YnhNT00yLy9WeDFTNTh4UjRsUEdK?=
 =?utf-8?B?V3NnMm1UWlVCTkh0U2tHR0w5bFhYbytRYUFqenFzdi93OVc4cEo1MnZCV1ZB?=
 =?utf-8?B?WDRTcWxsNkY5TDI2My83Q3g1M0daSVRSVWxFRHhiNS8xV1QyVmhFQldtMm1p?=
 =?utf-8?B?aGEvV2UzRHVMdWVqWlUvblJkK2l6emc0d25ISlh1ZUF4NGZ2UDFDeTFYNDJE?=
 =?utf-8?B?NjZDWnJhL3c5anpWWDlJRU1Zenhvc3U0QW5oQ0xabkxMOGFyNFlYUUMvMXBF?=
 =?utf-8?B?RktzQjNxSFovdUozWHZ3aEVEMVF3OFArQUpzeVpacHFhU2lsWjZnOFR6RDBX?=
 =?utf-8?B?WVZWd2N4dGs1Snc3Vkl0MitVelR0dHFKemJkRFh2a1JIYSt2M25OOEZ3QzQ5?=
 =?utf-8?B?U1p0NTBBeUtVcC9KQVAybVBNK1FUY1JibWx1VjdpSm5PRStyMzBwNUJqUUFu?=
 =?utf-8?B?bVZISWdOdW8vYkJYTjc5dFNJTm84RTl0TEh5eWVKalZEKzBTZmNJWkhJMDBx?=
 =?utf-8?B?SEpqcUNmZFhuRzdqNUh2YWI3dXZQdzdNYjh1VXJmQzdMWXhIQ2p0a1R3Qm9i?=
 =?utf-8?B?cWNsOVkyV2YyU0NMQ2x2MTlOaWl3M3dmcWEzdGM3SE84djRaS0ZlTDk0UVdp?=
 =?utf-8?B?NzFwNEM3WWNjMW1pTmtxRUN1a25oVkUyYWZ6QWlUaGJ5eW5PSVFHT3J2S2px?=
 =?utf-8?B?RFFxc2ZxQXNETnppbTJVMDhTVHdsWFdERW41UmxISnd1N0ltQW42dG5HTGR4?=
 =?utf-8?B?TTM1QldkQTJoK1RwcnlkQnpTcGFtaENxSUZvYlFkc1B1L2o2aVpKQUF3Nmo1?=
 =?utf-8?B?WkhqMnROeDRuS0dLWlhrTmQzWTBsY2tLZkJ5b0hlbXdGU0VvczRhNGdzRTNt?=
 =?utf-8?B?OEVhaU90NCtxbU1BTmlTbHliaStrRGxKNldhZmE5NkxISUtZZWxQUjEzNVFZ?=
 =?utf-8?B?MXB5Wk9MUXFITmxhdlNDMDZWNmJDbCsrS1BYL2o0bE9XY0I3V3FTWTh4Zjlj?=
 =?utf-8?B?UER0a2ZHZW1ucVpwU1ZqWURJV3l5ZW0yTHdCN0VRZ25icUFKLzJqS1JxRFRn?=
 =?utf-8?B?VnBpS21QLy9VQXRpMlo2cDIwbnFVQk1YN1R2OU9XTEV0MVUzRzRxd3NrTnc1?=
 =?utf-8?B?VGRtcS80TGRJZ1RaS3ZxSzA3WmlXc1JpNWl1d2owaHcrNEE5VkRXbSs2dGVK?=
 =?utf-8?B?UEE1dkFtS2FlbitUYzA0c0JEOGs0eG5jWEpKbklmL2RyREF1SjRJRXoydmFw?=
 =?utf-8?B?NWlFbFg4VGpWTnVGbXY3YThzZUFXMGNULytQQUdVNTZXaUVUS0RlTlc5OURG?=
 =?utf-8?B?UG1JMjhYWHNlREk5SUNZRVdlak5lZWZ3Z1ExZHhweVdMUnZyenZxNm1LaFZE?=
 =?utf-8?B?NXh3Y09JUUZzcGh0Z0hSaTEyRVhxZE0wNFFXN3A3V1VsTzB5OXhRZmk4TU5s?=
 =?utf-8?B?bHd5ZWIrZ2V3aHo2Mlh1RStXRlZ3dVo3a3VjT0JzUHlKM3BickJTSXVWbWVJ?=
 =?utf-8?B?dkhwbG4rYkpWQVU4TFhNZXF2YkxNMTZQL28vclRyNHVGNi9vbFBmeThsWjhn?=
 =?utf-8?B?Q24zME5VNUpsWXR6RHNBWElWdHdTZUJESVYvWEljd2JXMUloc3pPcmwwUFZE?=
 =?utf-8?B?MHgvZ2tweTdmNVdMbG9mMlFwM2JrbzBVczJhSmowc1pGQmdUY0YraUNTd3U5?=
 =?utf-8?Q?DLXlOlR7hmU58CF0kwSwMM+kd?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 83be8b24-9539-45df-e7c9-08ddec79c0a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2025 12:43:02.3614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 750GPpRbYnOHyDpCd15Tktl6SR8fMV3yo6+g45OL7CdF7V+tfZVhVHFRp4cE0lp2pMZ5LuzQMM6K7p0ZxWHPhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB1695
X-Proofpoint-ORIG-GUID: vP6mKqdfmPmOTY782hP4F29JC5InxLQz
X-Proofpoint-GUID: vP6mKqdfmPmOTY782hP4F29JC5InxLQz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxMyBTYWx0ZWRfX+PcblolGaBvV
 0zelaBwKFIRYty5Hr8ff+vadcNaEjWLl8q86ETN6WFZDDU1yO6BuviiV+YWaLD5t5mZz2vuEZgM
 UKOTMYl45WVHBx1X530kdo1cyngPdPpiBRrGNOc1/qTjqxSE0bdWpH0pdELnI7nX6Sgu1qfpt8y
 eOCaFNRF3GcDEGugdpBMWUhA2aBBRHZZXr8dPjJ4GdIKdOHRK3874MLLrQ+GgnJB78I/SEcBk8o
 RdP+uUoxten3WWg7YT1Fkhzhbh6t7Q/7r+360LQDZa59e/XdtzTw5wYm2X2qRvszVXETVnnYwFx
 ijUedVu6V3qh8Mqryoa+l6DEtkFvKxnXWvGgcCaljPvhUNoP18sNpI3anvd/4U/DBtYCm45armD
 VlmLXEj1
X-Authority-Analysis: v=2.4 cv=MutS63ae c=1 sm=1 tr=0 ts=68badadd cx=c_pps
 a=GU2idFwePczY1mnoXsBpeA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=Uwzcpa5oeQwA:10 a=QyXUC8HyAAAA:8 a=In8RU02eAAAA:8
 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=sMzu30KHAWDQohMcAeoA:9
 a=QEXdDO2ut3YA:10 a=EFfWL0t1EGez1ldKSZgj:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 impostorscore=0 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300013

Pg0KPg0KPkZyb206IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AaW50ZWwuY29t
PiANCj5TZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDQsIDIwMjUgMzoxNyBQTQ0KPlRvOiBSZW1p
IEJ1aXNzb24gPFJlbWkuQnVpc3NvbkB0ZGsuY29tPg0KPkNjOiBKb25hdGhhbiBDYW1lcm9uIDxq
aWMyM0BrZXJuZWwub3JnPjsgRGF2aWQgTGVjaG5lciA8ZGxlY2huZXJAYmF5bGlicmUuY29tPjsg
TnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT47IEFuZHkgU2hldmNoZW5rbyA8YW5keUBrZXJu
ZWwub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyemsrZHRAa2VybmVsLm9yZz47IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9y
Zz47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5v
cmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2NSAy
LzldIGlpbzogaW11OiBpbnZfaWNtNDU2MDA6IGFkZCBuZXcgaW52X2ljbTQ1NjAwIGRyaXZlcg0K
Pg0KPk9uIFRodSwgU2VwIDA0LCAyMDI1IGF0IDEyOjU4OjEwUE0gKzAwMDAsIFJlbWkgQnVpc3Nv
biB3cm90ZToNCj4+ID5Gcm9tOiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGlu
dGVsLmNvbT4gDQo+PiA+U2VudDogVGh1cnNkYXksIEF1Z3VzdCAyMSwgMjAyNSAxMTowMyBBTQ0K
Pj4gPk9uIFdlZCwgQXVnIDIwLCAyMDI1IGF0IDAyOjI0OjIwUE0gKzAwMDAsIFJlbWkgQnVpc3Nv
biB2aWEgQjQgUmVsYXkgd3JvdGU6DQo+DQo+Li4uDQo+DQpIZWxsbyBBbmR5LA0KVGhhbmtzIGZv
ciB5b3VyIHF1aWNrIHJlcGx5Lg0KDQo+PiA+PiArc3RydWN0IGludl9pY200NTYwMF9zdGF0ZSB7
DQo+PiA+PiArCXN0cnVjdCBtdXRleCBsb2NrOw0KPj4gPg0KPj4gPk5vIGhlYWRlciBmb3IgdGhp
cy4NCj4+IA0KPj4gQ29ycmVjdA0KPg0KPlBsZWFzZSwgYWRkLg0KPg0KPi4uLg0KPg0KPj4gPj4g
KwlzdHJ1Y3QgcmVnbWFwICptYXA7DQo+PiA+DQo+PiA+Tm8gZm9yd2FyZCBkZWNsYXJhdGlvbi4N
Cj4+IA0KPj4gQ29ycmVjdCBhZ2Fpbg0KPg0KPkRpdHRvLg0KPg0KPi4uLg0KPg0KPj4gPj4gKwlz
dHJ1Y3QgcmVndWxhdG9yICp2ZGRpb19zdXBwbHk7DQo+PiA+DQo+PiA+RGl0dG8uDQo+PiANCj4+
IENvcnJlY3QNCj4NCj5EaXR0by4NCj4NCj4uLi4NCj4NCj4+ID4+ICtzdGF0aWMgY29uc3Qgc3Ry
dWN0IHJlZ21hcF9jb25maWcgaW52X2ljbTQ1NjAwX3JlZ21hcF9jb25maWcgPSB7DQo+PiA+PiAr
CS5yZWdfYml0cyA9IDE2LA0KPj4gPj4gKwkudmFsX2JpdHMgPSA4LA0KPj4gPg0KPj4gPk5vIGNh
Y2hlPw0KPj4gPg0KPj4gSWYgT0sgZm9yIHlvdSwgd2UgcHJlZmVyIHRvIHB1c2ggdGhpcyBwYXRj
aCB3aXRob3V0IGNhY2hlLg0KPj4gQW5kIGludHJvZHVjZSBpdCBpbiBhbm90aGVyIHBhdGNoc2V0
Lg0KPg0KPkZpbmUgdG8gbWUgaWYgdGhlcmUgaXMgYSBjb21tZW50IGdpdmVuIChpbiB0aGUgZW1h
aWwsIG5vdCBpbiB0aGUgY29kZSkgdG8NCj5qdXN0aWZ5IHRoaXMgc3BsaXQuIEVuYWJsaW5nIGNh
Y2hlIGlzIG9uZSBsaW5lLCBidXQsIG9mIGNvdXJjZSwgaXQgbWlnaHQNCj5yZXF1aXJlIGEgY2Fj
aGUgaGFuZGxpbmcgaW4gdGhlIGNvcm5lciBvciBzcGVjaWFsIGNhc2VzLg0KT2sgSSdsbCB1cGRh
dGUgdGhlIGNvdmVyIGxldHRlci4NCj4NCj4+ID4+ICt9Ow0KPg0KPi4uLg0KPg0KPj4gPj4gKy8q
Kg0KPj4gPj4gKyAqICBpbnZfaWNtNDU2MDBfc2V0dXAoKSAtIGNoZWNrIGFuZCBzZXR1cCBjaGlw
DQo+PiA+PiArICogIEBzdDoJZHJpdmVyIGludGVybmFsIHN0YXRlDQo+PiA+PiArICogIEBjaGlw
X2luZm86CWRldGVjdGVkIGNoaXAgZGVzY3JpcHRpb24NCj4+ID4+ICsgKiAgQHJlc2V0OglkZWZp
bmUgd2hldGhlciBhIHJlc2V0IGlzIHJlcXVpcmVkIG9yIG5vdA0KPj4gPj4gKyAqICBAYnVzX3Nl
dHVwOgljYWxsYmFjayBmb3Igc2V0dGluZyB1cCBidXMgc3BlY2lmaWMgcmVnaXN0ZXJzDQo+PiA+
PiArICoNCj4+ID4+ICsgKiAgUmV0dXJucyAwIG9uIHN1Y2Nlc3MsIGEgbmVnYXRpdmUgZXJyb3Ig
Y29kZSBvdGhlcndpc2UuDQo+PiA+DQo+PiA+UGxlYXNlLCBydW4ga2VybmVsLWRvYyB2YWxpZGF0
b3IuIEl0J3Mgbm90IGhhcHB5IChSZXR1cm4gc2VjdGlvbiBpcyBtaXNzaW5nKQ0KPj4gDQo+PiBr
ZXJuZWwtZG9jIGRvZXMgbm90IGNvbXBsYWluIG9uIHRoaXMsIG9uIG15IHNpZGUuIA0KPj4gSSBy
YW4ga2VybmVsLWRvYy5weSAtdiAtbm9uZSBkcml2ZXJzL2lpby9pbXUvaW52X2ljbTQ1NjAwLyoN
Cj4+IElzIHRoZXJlIGFueSBvcHRpb24gSSdtIG1pc3NpbmcuDQo+PiBBbnl3YXksIEkgd2lsbCBh
ZGQgdGhlIG1pc3NpbmcgY29sb24gYW5kIGNoZWNrIHRoZSByZXN1bHQuDQo+DQo+LVdhbGwgaXMg
bWlzc2VkIGluIHRoZSBjb21tYW5kIGxpbmUuDQpPayBUaGFua3MhDQo+DQo+PiA+PiArICovDQo+
DQo+Li4uDQo+DQo+PiA+PiArCQlpZiAodmFsID09IFU4X01BWCB8fCB2YWwgPT0gMCkNCj4+ID4N
Cj4+ID5IbW0uLi4gUGVyaGFwcyBpbl9yYW5nZSgpID8NCj4+IA0KPj4gTm90IHN1cmUgb2YgdGhl
IGJlbmVmaXQgb2YgdGhpcyBjaGFuZ2UuDQo+PiBJIHByZWZlciB0byBrZWVwIGl0IHRoaXMgd2F5
IGlmIE9LIGZvciB5b3UuDQo+DQo+SXQgZGVwZW5kcyBvbiB0aGUgc2VtYW50aWNzIG9mIHRoZSB2
YWx1ZSBpbiB0aGUgJ3ZhbCcuIEFuZCBoZW5jZSBzZW1hbnRpY3Mgb2YgMA0KPmFuZCBVOF9NQVgu
DQoNCldpdGggU1BJIGludGVyZmFjZSwgdGhlcmUgaXMgbm8gQUNLIG1lY2hhbmlzbS4NClNvIDB4
MDAgb3IgMHhGRiBtZWFucyB0aGF0IHRoZSBkZXZpY2UgaXMgbm90IHJlc3BvbmRpbmcgb24gdGhl
IGJ1cy4NCkknbGwgYWRkIGEgY29tbWVudCB0byBleHBsYWluIHdoeSB0aGUgZHJpdmVyIGNoZWNr
cyB0aGVzZSBzcGVjaWZpYyB2YWx1ZXMuDQoNCj4NCj4+ID4+ICsJCQlyZXR1cm4gZGV2X2Vycl9w
cm9iZShkZXYsIC1FTk9ERVYsDQo+PiA+PiArCQkJCQkgICAgICJJbnZhbGlkIHdob2FtaSAlIzAy
eCBleHBlY3RlZCAlIzAyeCAoJXMpXG4iLA0KPj4gPj4gKwkJCQkJICAgICB2YWwsIGNoaXBfaW5m
by0+d2hvYW1pLCBjaGlwX2luZm8tPm5hbWUpOw0KPg0KPi4uLg0KPg0KPj4gPj4gKwkJcmV0ID0g
cmVnbWFwX3dyaXRlKHN0LT5tYXAsIElOVl9JQ000NTYwMF9SRUdfTUlTQzIsDQo+PiA+PiArCQkJ
CSAgIElOVl9JQ000NTYwMF9NSVNDMl9TT0ZUX1JFU0VUKTsNCj4+ID4+ICsJCWlmIChyZXQpDQo+
PiA+PiArCQkJcmV0dXJuIHJldDsNCj4+ID4+ICsJCS8qIElNVSByZXNldCB0aW1lOiAxbXMuICov
DQo+PiA+PiArCQlmc2xlZXAoMTAwMCk7DQo+PiA+DQo+PiA+VXNlIDEgKiBVU0VDX1BFUl9NU0VD
IGFuZCBkcm9wIHVzZWxlc3MgY29tbWVudCBhZnRlciB0aGF0Lg0KPj4gPllvdSB3aWxsIG5lZWQg
dGltZS5oIGZvciBpdC4NCj4+IA0KPj4gVGhhbmtzIGZvciB0aGUgdGlwLCBjbGVhciBpbXByb3Zl
bWVudC4NCj4+ID4NCj4+ID4+ICsNCj4+ID4+ICsJCWlmIChidXNfc2V0dXApIHsNCj4+ID4+ICsJ
CQlyZXQgPSBidXNfc2V0dXAoc3QpOw0KPj4gPj4gKwkJCWlmIChyZXQpDQo+PiA+PiArCQkJCXJl
dHVybiByZXQ7DQo+PiA+PiArCQl9DQo+PiA+PiArDQo+PiA+PiArCQlyZXQgPSByZWdtYXBfcmVh
ZChzdC0+bWFwLCBJTlZfSUNNNDU2MDBfUkVHX0lOVF9TVEFUVVMsICZ2YWwpOw0KPj4gPj4gKwkJ
aWYgKHJldCkNCj4+ID4+ICsJCQlyZXR1cm4gcmV0Ow0KPj4gPj4gKwkJaWYgKCEodmFsICYgSU5W
X0lDTTQ1NjAwX0lOVF9TVEFUVVNfUkVTRVRfRE9ORSkpIHsNCj4+ID4+ICsJCQlkZXZfZXJyKGRl
diwgInJlc2V0IGVycm9yLCByZXNldCBkb25lIGJpdCBub3Qgc2V0XG4iKTsNCj4+ID4+ICsJCQly
ZXR1cm4gLUVOT0RFVjsNCj4+ID4+ICsJCX0NCj4+ID4NCj4+ID4uLi4NCj4+ID4NCj4+ID4+ICtz
dGF0aWMgaW50IGludl9pY200NTYwMF9lbmFibGVfcmVndWxhdG9yX3ZkZGlvKHN0cnVjdCBpbnZf
aWNtNDU2MDBfc3RhdGUgKnN0KQ0KPj4gPj4gK3sNCj4+ID4+ICsJaW50IHJldDsNCj4+ID4+ICsN
Cj4+ID4+ICsJcmV0ID0gcmVndWxhdG9yX2VuYWJsZShzdC0+dmRkaW9fc3VwcGx5KTsNCj4+ID4+
ICsJaWYgKHJldCkNCj4+ID4+ICsJCXJldHVybiByZXQ7DQo+PiA+PiArDQo+PiA+PiArCS8qIFdh
aXQgYSBsaXR0bGUgZm9yIHN1cHBseSByYW1wLiAqLw0KPj4gPj4gKwlmc2xlZXAoMzAwMCk7DQo+
PiA+DQo+PiA+QXMgcGVyIGFib3ZlLg0KPj4gWWVzLg0KPg0KPkZvciBib3RoIGNhc2VzIGFjdHVh
bGx5IHlvdSBjYW4gbGVhdmUgYSBjb21tZW50LCBidXQgcmV3cml0ZSBpdCBpbiBhIHdheSB0aGF0
DQo+aXQgcmVmZXJzIHRvIHRoZSBkYXRhc2hlZXQuIFRoaXMgd2lsbCBiZSB1c2VmdWwuDQpPaywg
SSdsbCBkbyBpdCB3aGVuIHRoZSBkZWxheSBpcyBhY3R1YWxseSBkb2N1bWVudGVkLg0KVW5mb3J0
dW5hdGVseSBzb21lIG9mIHRoZW0gYXJlIG1pc3NpbmcgZnJvbSB0aGUgcmVsZWFzZWQgZG9jLg0K
DQo+DQo+PiA+PiArCXJldHVybiAwOw0KPj4gPj4gK30NCj4NCj4uLi4NCj4NCj4+ID4+ICsJLyog
SU1VIHN0YXJ0LXVwIHRpbWUuICovDQo+PiA+PiArCWZzbGVlcCgxMDAwMDApOw0KPj4gPg0KPj4g
PjEwMCAqIFVTRUNfUEVSX01TRUMNCj4+IFllcy4NCj4NCj5BcyBwZXIgYWJvdmUuDQpPay4NCj4N
Cj4uLi4NCj4NCj4+ID4+ICsJc2NvcGVkX2d1YXJkKG11dGV4LCAmc3QtPmxvY2spDQo+PiA+PiAr
CQkvKiBSZXN0b3JlIHNlbnNvcnMgc3RhdGUuICovDQo+PiA+PiArCQlyZXQgPSBpbnZfaWNtNDU2
MDBfc2V0X3B3cl9tZ210MChzdCwgc3QtPnN1c3BlbmRlZC5neXJvLA0KPj4gPj4gKwkJCQkJCXN0
LT5zdXNwZW5kZWQuYWNjZWwsIE5VTEwpOw0KPj4gPg0KPj4gPldpdGggZ3VhcmQoKSgpIHRoaXMg
d2hvbGUgY29uc3RydWN0aW9uIHdpbGwgbG9vayBiZXR0ZXIuDQo+PiANCj4+IEl0J3MgY29taW5n
IGluIGxhdGVyIHBhdGNoLg0KPj4gSSB0aG91Z2h0IGl0IHdvdWxkIGJldHRlciBmb2xsb3cgY29k
aW5nIGd1aWRlbGluZXMgdGhpcyB3YXkuDQo+PiBCdXQgbGV0IG1lIGtub3cgaWYgaXQgaXMgbm90
IHRoZSBjYXNlLg0KPg0KPkFoLCB5ZXMsIGJ1dCB3ZXJlbid0IHt9IG1pc3Npbmc/DQpPSywgSSds
bCBhZGQgdGhlbS4NCj4NCj4+ID4+ICsJcmV0dXJuIHJldDsNCj4NCj4tLSANCj5XaXRoIEJlc3Qg
UmVnYXJkcywNCj5BbmR5IFNoZXZjaGVua28NCj4NCj4NCj4NCg==

