Return-Path: <linux-iio+bounces-23711-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E92B43C86
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 15:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49984188D33A
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 13:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3802FF177;
	Thu,  4 Sep 2025 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="cWDMkTTv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F252FD1BA;
	Thu,  4 Sep 2025 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756991204; cv=fail; b=ErJTjhsECQ0Kiqr1wZNXLseR1tNBBvMOOeiRCvhDg11PIZunoSG8wYCzx1613jmiiDX4e8q1FumysfUqxWUYAywolYoAHcCjScZIoBwpJ+oOplEFaGaG8R62d8iWUwrtIgPxnCQ9D64U9pZZC9P85c0s+ehKtCJ4zjPJ41zY3xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756991204; c=relaxed/simple;
	bh=vbDGlECv9phTFNPVZrrFGEFGAxcO7TiQxaIv7Ea4ucQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nd/IcMPYXRQnACPfsC7I72pBjPFLli+SDjlYNelotwpV05fcGi2WfxnO6Xcs/mmZX96vs4ZCMtPeVKuFUNKHFIcjqxTsJf7NC+EFdWq+oZb/m1KH+Lw+Dj/tfiqsxN6LiiyyelOLrdx3ArdClIqcMFtcinY0JjxHVOIDu6qJFPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=cWDMkTTv; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5840qvFY026969;
	Thu, 4 Sep 2025 13:06:36 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazon11010007.outbound.protection.outlook.com [52.101.169.7])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 48y0m8rmpj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 13:06:36 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGP88ANTOMZ0XyK6C6I6UwhFvLRO5zit82H2h5KgS7/ctUd+MLqOl1Card+EOmIVDyl0OEqljyO3bhrZyuYvbRLe8tZKFi1gQU28johv674t9qJcqHvJNOl13P+j6FwMZafbEsXsAelhM4rCqkphlgH4DsUVUDaZ9kvvwz74AjPn89Cu6bQJNTBXXK+WRwmvYqmeiQSdBQuGSg7si4mTV+hHs8YHwSHaCFNYGoZekjIhkRQ2jMRtkf6ZPH47o9cAEHJDYhg3seAaXZn1Y8QISgNBmsqyk2z6a7TMRXm5dn/Sz43OxO1FoGAlTlzmitsFQZd6/3F2ahesDr4kdMWQeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbDGlECv9phTFNPVZrrFGEFGAxcO7TiQxaIv7Ea4ucQ=;
 b=l2EPxMarfNFDUlz7Hq8k4GMP3dx4NJedAhcd0oQMHo9sAZLZjc8utq5QemALvd95+UKomiQQQluwvf89bPXkNmqEXz5slms4LElDO/mGAhON1ndux9+LJL+pZUCxEbdz7mJAGtO4fQHVl/Cel7OdRoKJejxbwIbyzDNAW0AB1PB9xgmjhlMyj5A/Z+nsQQI7dlZBOBGBpGE3dEQWZHX5iCxrGZCvC9f5DvhNv1qxpSFrKGK3PtFinOPZpZE9ubF9l80vjposjqGNe3emuvcT+obOoNCbSrVfJv0jvpMZ8M5ARAa/Fspw2lsmkj4LSq3JBI6FyK2Wwedog0gkYTWHkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbDGlECv9phTFNPVZrrFGEFGAxcO7TiQxaIv7Ea4ucQ=;
 b=cWDMkTTvsexguGKMkHio1ABzc1lLzfpwA19hZFv3gS6pd3viYuyoObBwyldZQyszH7YBzFPAwkk1hoTWVu1nMcP4MKHku1UGE5dR0S/PkrQK/4zA4G3avYfZAoTr/6I/MtgjbwtXrZa97lL5fCqDpMtrazGwlUvL2h+HxtDVJgxZ/xI85S5Xxdwl32aCSc7aXy2+5wtrsUaaoas2jUUsqBhsOL0+KopwNyBJAZDGmd8i6DQzJZmJt+sioUasT0mMw/lFVD4F0AKAu/cSAMRuFHWgmW++jtO3FLbzUWxYaPpiLRNR86WC9PqtUrldnBY2ePS984gAk53YQVz2z3cQyw==
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::2d)
 by BEUP281MB3497.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:99::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 13:06:23 +0000
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf]) by FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf%3]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 13:06:23 +0000
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
Subject: RE: [PATCH v5 4/9] iio: imu: inv_icm45600: add IMU IIO gyroscope
 device
Thread-Topic: [PATCH v5 4/9] iio: imu: inv_icm45600: add IMU IIO gyroscope
 device
Thread-Index: AQHcEd41Tyzg3AOckE6jpsd2YtYKgbRzOekAgA/SXpA=
Date: Thu, 4 Sep 2025 13:06:23 +0000
Message-ID:
 <FR2PPF4571F02BC6BF945DD634338CC5D6D8C00A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <20250820-add_newport_driver-v5-0-2fc9f13dddee@tdk.com>
	<20250820-add_newport_driver-v5-4-2fc9f13dddee@tdk.com>
 <20250825115552.69abe3b3@jic23-huawei>
In-Reply-To: <20250825115552.69abe3b3@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2PPF4571F02BC:EE_|BEUP281MB3497:EE_
x-ms-office365-filtering-correlation-id: 202be9d7-1165-4905-28fd-08ddebb3d97a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|10070799003|7416014|376014|38070700018|3613699012;
x-microsoft-antispam-message-info:
 =?utf-8?B?OEo5RUI1Wml2YlVhRG1oVDhadGt5T0dGL05yd1l1bTNIcVZSZzJRQmxvM0VV?=
 =?utf-8?B?L2RZSDVGN3JUL2RDSzNpd1hqeTVrRitrNUdLWHNjaHdBejBMenJxU2hUNmtL?=
 =?utf-8?B?N1BlRHFxa2F5Tzk0cjJDTmdEWkxRYmJGMDlHNnhTZmpTaC8xcnpPY0JSTy9K?=
 =?utf-8?B?TmtIRzNPVk9Pa00zaEUrT0VtYUVqZ0JYN3BhVHJYWEVINDF5NkxqbVc4S3Rk?=
 =?utf-8?B?UmJyR3BhU0pxSXlIcWtpbjB1M2dDK2pEaXRpTHhaRUIxeFJ2cGxpODFjKzNW?=
 =?utf-8?B?b1VhMmkyUi9ra0FTaVhWczVkdnpyV0tGWkxhNTdDem5HSG9US2IwT2FjUzRC?=
 =?utf-8?B?b21SMDF2d3N6MGNUbFBSSEtIZDI3Y2c4ZHg3RDlvZXFmZmRFb2VkT3RVSzAy?=
 =?utf-8?B?cGFiL3J0akY5KzdNek9kdmZURDNzUW16azlZRXpraXNwZVN4SkZ3ZnpsbTFq?=
 =?utf-8?B?NU9xeTR6bkhPYkNrMVdOOUlIQkFEVlUrcTlvMU45WUVWRFRpR1VDVGg2N3d3?=
 =?utf-8?B?cTZLYXRLR2lLdzM4UWxoTjJRZmF1WW5GMEFhcXBqQXZ6MGZxcXZBaERtKzc0?=
 =?utf-8?B?Lzd2VDlGbHZMQ2Q1QXl0V3EzbXRJYXdnN3VrSnBHcVcwY1cxTms4bXI3eFZL?=
 =?utf-8?B?V0xKUG1ERGJIQzEyYk9JQlRRQWY4TDdtSXB4Z2dlVGQ5MjJqVGR5VGNTa1JY?=
 =?utf-8?B?R1oyaC9SSDRnTG5YU3NKbDZ1czI4ai9Wdkpqb2ljTk1MY012MVdSV3J2ZkI0?=
 =?utf-8?B?TlpFUkVJakpVV0xDSGxodUZGTjFDZngxNGRFajR6em1UYno0UEtUT08rMmQx?=
 =?utf-8?B?cS95c3Y5NURyNnp4UnR3YVlXOVhmYi9jUEd6ZXIvN2lOZkdzb2Z4dUY5RVRF?=
 =?utf-8?B?L2t0cXpRbU1yaUFFeFU5OXdtY3VrRnJjQnJlOVY0TWMzU3BxRHMvMkVnU0ZG?=
 =?utf-8?B?TGhGZmhyQ0Fndnk1V0QxVlJZb2dtdkdZckE5QzZZdk8rSzAwVFlUVis0QXBr?=
 =?utf-8?B?MnIyWTNHWndIVHZqUVMyV3JOdGcrRytIVEhpV0RMRTlNYkRuSjdlcUVMM1ZS?=
 =?utf-8?B?WFA1YTBwUEREYVhDcDhwMmlLUm4xRjg2aTIvcU9Db0d5eWJuMHB2UDVWUXB5?=
 =?utf-8?B?all5eFdTTmoyTjVRSDcxN2hrMFdQR3FFWkFXdW1qcDlBUnJEOVd0TDMvK25o?=
 =?utf-8?B?TWt1TDR4VzBqSzVISmhvWmdvaHloU0czLzk4WWwvdlFTdG9mWExmMnlpa0Iw?=
 =?utf-8?B?Y29hNktUL1ZOM1VVU3o3UXdpTG9iVmdQeXdjZVhtMms2M3kwSi9GK0JudGM3?=
 =?utf-8?B?a3N0RFJndEFsTlluVXFSWG5xUGVsQklkRE5EbytSRzdlUG14c3R3ZFIxMkw0?=
 =?utf-8?B?QmR5VkM1OFVKTFFyeEFEVzc2eW1pa1hHblZlVWl5djNUS05vcXREbzMzV3hZ?=
 =?utf-8?B?YTEyZ3drWjBNanU1ZU1NSXdJTzlaNWp5RHZ0ZjlXMHprQVNLUjJDQ0ZqS01L?=
 =?utf-8?B?WW5WS2pILzFlS1F4M0IrWnhiZVA4ZGgwWUNGQytldWIzbEhSWVBuQ1hmcDFx?=
 =?utf-8?B?eTl1M1M0YjVXTEUzdXRjUmRaSDYxc1YzR1FkbnJvQ2FRb1FkNVZiUlc1TlZ2?=
 =?utf-8?B?TzMwaGYveWZvZ0ppVDdzMUtuWlBzZjBWNkxLYm44UjZadXdOWjVpYmlwMnhO?=
 =?utf-8?B?Z1BXYktDSGlKU2RnQXJlbk5nZ2U1Z2RjSlhZaUlBQVJvVFhEaFdCVDV4UTJG?=
 =?utf-8?B?S0twSXFvTnBiNm9lUXRGcU1qZWZZbmNzMlpYc004QW51ZnF3Q0pWRDl1eDRQ?=
 =?utf-8?B?WFJPOGI5bGt2WFp0VWFSMmZibFhEbzlWOS9PSVJsUlNINlM2eVNnS1UwcTB0?=
 =?utf-8?B?ZmVKWWR5VmxkL1JoZUxOWUlaU0lPME9ma01GY2J0MXRIdUgzY1JOaFNrVDRh?=
 =?utf-8?B?NEZJNnpzM1krbnd6cFdaU2NlZVNDSlZyRFNsODdzdWU5NUNzazJ2MlRDbjd5?=
 =?utf-8?B?VzFmOU5qY2RZV3dFMEhmWjVXZjRQWW85bE5pU3hvUjVtTFkyYXFpbTNrUUpG?=
 =?utf-8?Q?/5ZCum?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(10070799003)(7416014)(376014)(38070700018)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y2F4LzZXd1VIR1oyU2YyWFZNNG51MU5MSGNkL1VzcmRlZ2N1TXpLWlA5UFRB?=
 =?utf-8?B?MmQ4dTNlRFNvUi9QSGJqVENyT2VKcEptTVBwYkxjY1VvdjJRMFVMYy9FN01O?=
 =?utf-8?B?ZG9mNTA2ZTYzZVhnOG5Scm5sU0FTMnQ4TjRQc2NwS0NwS0trRDhUbHkzVFIx?=
 =?utf-8?B?OTlrMGJjN0RacEVadEp2Y0RXK2UwbGVsYmpMSnpvT2dmcjJkSlRrMlFTUjFt?=
 =?utf-8?B?OGpPOThnQno2WWxwemN6dlZTakppYnMyTGNwNHBnUHVWelkzR2tTaVU5bjNY?=
 =?utf-8?B?MXBwb1JEais5Y3NKRlprM25neDBhWlpXWVRXQzZwNGlMYlJ4dXNWMzJMdVB6?=
 =?utf-8?B?NU95QVpOa2RRbjdmMWoyVmlrZHFOVnN0TVh1UnMwSlBQTE9JbVAwcThDcjQ5?=
 =?utf-8?B?SDJjdk5lUUplREpRcmROVXVad01GZk5QR1lBblJKYmMvQXUwUXdsTHJKZjMz?=
 =?utf-8?B?UDgveVZKVTRua3huNXUvN2RyUU9QVTczc1pPTS9hMTNXeXc3dzk1dllDRTNS?=
 =?utf-8?B?dlc5UHN2LzQ0VmZHSElTZmdYM1QvK0I2Wk1tcGtXVnIzUVFQTEI1M3VCdk9H?=
 =?utf-8?B?Vnk5NWxCU280UjVBbnBVcUVEbnU5eWpQSG1aZU5WTUhpeHZtcVlQRmlZcHpz?=
 =?utf-8?B?WGRVbTQvbi9nNFpvQUgrdmViU1hNQUZvbkc3RTRNMG85RUUvbzBCeUtpTXF4?=
 =?utf-8?B?dmtCS3JOejhMekZhUXRub0lXRGVPWW9RblNPNGtrdXVJbTltdVVIR2NRYk54?=
 =?utf-8?B?QVgvWk5EWG1JQXovZUJPcDE5QnlJMkEyNEN3bmR5amJnVmM5RHJxcXJMUGJy?=
 =?utf-8?B?ZUx5NlV4ekh2Ky82ekZVSWg2eVFmS05ZUXNvb0ZLeGNiT2hyZTF1bXR2SWM3?=
 =?utf-8?B?WkpNd1BrdEg1bnluZlNPdWU0anhQTXA3bEpNMkl1UWNjZjVuZjZZaXdlaFBE?=
 =?utf-8?B?bU1OazRDd29JMjVwMFpqUjBrbS9rNEZpNUpDek9GQm1rYTRuZXd1dHkreWJ5?=
 =?utf-8?B?V2c0SGpMNnE1dCtjOFova1pMZ2cydlRYQmd6QWJrRTJGbVNtckV2WGI4Vnpj?=
 =?utf-8?B?clVmMS9LZjA2OU5xaWRyUDUwdmpPYUo3TWVKTTBXRFFPMU0ycGFQcGR0amI5?=
 =?utf-8?B?d3A1dkQrdTd2cWo1bjBEY2pBdmxmdm1ld2I5STZzS1VpeThXRGN5M3BFa2Iw?=
 =?utf-8?B?cXUrYUtEZ1ZGb3JyV3NRc2xkdHNVcUp1SWZSSEdzNmNvUktiYTZPdXJZMW5z?=
 =?utf-8?B?eGljb3BXNmNud1FqWFF6aVhHVHc2TW1vcmRvRUExdUN1R3JRODNUTXJtZXQ4?=
 =?utf-8?B?Y3E4ZTJqK2RCOVNSQ1RjU0l0SWg3S21sZFVTWitoaXpjMjB6VWxSS0xHR0Fl?=
 =?utf-8?B?eGRiR1pHUVNkOVNnaG9KZlhOaXlaVE5SMVVNdmV3S2JlNDFUbjRtbEJPbGVW?=
 =?utf-8?B?SW9xdkJGM1JpbTdWYlJXMHc3dUdkYkdGdXRWVkg1cjVpTnpxN1J0YmU5MVNL?=
 =?utf-8?B?WUZUeE8zcnZXMVZyS2x3MldySEpjODJmRzZJUnZSTXRWeU5sazlobnNkSEln?=
 =?utf-8?B?VUd1c0pQZXZTZDl2SGJnUFgrVVdjSzBMYS9UUmhLSTJ4OG0xU3d5ek1BRDdv?=
 =?utf-8?B?aEJaYWkrZW84aExFUHJCNVl0aGtORjhJOW1YWDcvNU8zeG5GdWZnMWg2cGZz?=
 =?utf-8?B?Qi9WVWQzUVlWaWMrS2c4S2J2UEZJSmZja2ZNNG4wNEZ5ZXhhdmxLcTdXZFhp?=
 =?utf-8?B?UWhaaUdkQUdZVlpsamlLMWpmZ0gvcnQ3VlJRYjUvelRIaU5RMW03MmNjMEpZ?=
 =?utf-8?B?UjhjdkNJYnQxUGV3SXI5ZDlPMFFkMDh0ZmdNZzNtOFhFb0lrdEZZcnliV0xG?=
 =?utf-8?B?TE5NTzJjemFpYkV6Ry9GM1RYd2dQcEtpaEdMQVlLSGg2dm9neUcwNmtmZ0d4?=
 =?utf-8?B?b1pXcjlyeW0veklPU0pLN2ZLMzFpb0g3RWVBS1RrTlJOUUFVTGFGL1EyMVZn?=
 =?utf-8?B?SmY5d3pSR1J1aUZHbWdPdmVXbmF1OUYwREdvSDlhdUswNGFsZ0F0d21BcE5M?=
 =?utf-8?B?eWdNbkgzTnZUUVFRai9LeERyUUJYQ1UzUVB5L2V5YURJSURZRmtqMUhua3py?=
 =?utf-8?B?djErNUlKRTgyUTFqc1d4R3dkYzUwR3RhUUtacjNGMkZ0MWM1Wko3YUFERUoy?=
 =?utf-8?Q?1rW+jslcGwe7asX5raWsrg3jw2kPMfEzN91bA087kD5K?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 202be9d7-1165-4905-28fd-08ddebb3d97a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 13:06:23.6578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0TkBoRDzFj+4022y+SjopetASGtZMITedelmB+xHMf3uFjZgXw0/xG52torZiXAlov5Bs4bCmp+WPWAgt+UVKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEUP281MB3497
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDAwNyBTYWx0ZWRfX7MP4vWD7328f
 ErXBVQ2EVvcfuk/4QA+aP1aIcSBLaL0pSGAdQRUIrsjUoU67Gi7rtTngxyPIyqwvES53TTnIuHT
 7wpA41v3AI3Ci14SsXzCKEWNQ93LQOJqyG2L4ryARccz996XGmoAaD9+lRcOR7KT8EZ0WVy98Q+
 kPpec+TNw0yq3h+uIJBS6JZJ7R7j3Iksqpp765WH4gLjyBLt1iVVFjL2flDFumim0IP6qu6rkrw
 4Y2WnK9MNOFJGT/33OLCo0zBGFzGyexhDkeIc8mNO6WbvbjrbOm+jfclopalF+kH7CgpJV3pKpu
 EvHcMlGaNvI3cwb+lAAsqJ7TftZ6PaCYYJkyLgYnWHygCmg+mOhKgPVI2EEGTpl/Mwj0BNXD4Lz
 eBRxHBha
X-Proofpoint-GUID: gfKjEgas73C62_WAoxLAnP17ZIjrGmaz
X-Proofpoint-ORIG-GUID: gfKjEgas73C62_WAoxLAnP17ZIjrGmaz
X-Authority-Analysis: v=2.4 cv=KqxN2XWN c=1 sm=1 tr=0 ts=68b98edc cx=c_pps
 a=0amwtkddiRibtvnfVnwmZw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=Uwzcpa5oeQwA:10 a=VwQbUJbxAAAA:8 a=In8RU02eAAAA:8
 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=b7bCK66UmZ_Dr5SggDUA:9 a=QEXdDO2ut3YA:10
 a=EFfWL0t1EGez1ldKSZgj:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509040007

Pg0KPg0KPkZyb206IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+IA0KPlNlbnQ6
IE1vbmRheSwgQXVndXN0IDI1LCAyMDI1IDEyOjU2IFBNDQo+VG86IFJlbWkgQnVpc3NvbiB2aWEg
QjQgUmVsYXkgPGRldm51bGwrcmVtaS5idWlzc29uLnRkay5jb21Aa2VybmVsLm9yZz4NCj5DYzog
UmVtaSBCdWlzc29uIDxSZW1pLkJ1aXNzb25AdGRrLmNvbT47IERhdmlkIExlY2huZXIgPGRsZWNo
bmVyQGJheWxpYnJlLmNvbT47IE51bm8gU8OhIDxudW5vLnNhQGFuYWxvZy5jb20+OyBBbmR5IFNo
ZXZjaGVua28gPGFuZHlAa2VybmVsLm9yZz47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+
OyBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkg
PGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1paW9Admdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPlN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjUgNC85XSBpaW86IGltdTogaW52X2ljbTQ1NjAwOiBhZGQgSU1VIElJ
TyBneXJvc2NvcGUgZGV2aWNlDQo+DQo+T24gV2VkLCAyMCBBdWcgMjAyNSAxNDoyNDoyMiArMDAw
MA0KPlJlbWkgQnVpc3NvbiB2aWEgQjQgUmVsYXkgPGRldm51bGwrcmVtaS5idWlzc29uLnRkay5j
b21Aa2VybmVsLm9yZz4gd3JvdGU6DQo+DQo+PiBGcm9tOiBSZW1pIEJ1aXNzb24gPHJlbWkuYnVp
c3NvbkB0ZGsuY29tPg0KPj4gDQo+PiBBZGQgSUlPIGRldmljZSBmb3IgZ3lyb3Njb3BlIHNlbnNv
cg0KPj4gd2l0aCBkYXRhIHBvbGxpbmcgaW50ZXJmYWNlIGFuZCBGSUZPIHBhcnNpbmcuDQo+DQo+
V3JhcCBhdCA3NSBjaGFycyBmb3IgY29tbWl0IG1lc3NhZ2VzLg0KDQpUaGlzIGNvbW1pdCBtZXNz
YWdlIGRvZXMgbm90IHVzZSBtb3JlIHRoYW4gdGhhdC4NCkJ1dCBJIHdpbGwgZml4IGl0IGluIHRo
ZSBjb3ZlciBsZXR0ZXIgcGF0Y2guDQo+DQo+PiBBdHRyaWJ1dGVzOiByYXcsIHNjYWxlLCBzYW1w
bGluZ19mcmVxdWVuY3ksIGNhbGliYmlhcy4NCj4+IFRlbXBlcmF0dXJlIGlzIGF2YWlsYWJsZSBh
cyBhIHByb2Nlc3NlZCBjaGFubmVsLg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBSZW1pIEJ1aXNz
b24gPHJlbWkuYnVpc3NvbkB0ZGsuY29tPg0KPj4gLS0tDQo+DQo+T25seSB0aGluZyBJIG5vdGlj
ZWQgaXMgc29tZSBhY2NlbGVyb21ldGVyIGNhbGxzIGFyZSBtYWRlDQo+d2hlcmUgdGhlIGRlZmlu
aXRpb25zIGFyZSBpbiB0aGUgbmV4dCBwYXRjaC4gIFRvIHNhbml0eSBjaGVjayB0aGlzDQo+dHdl
YWsgdGhlIEtjb25maWcgdG8gYWxsb3cgeW91IHRvIGJ1aWxkIGl0IGFuZCBtYWtlIHN1cmUgdGhh
dCBpdA0KPmJ1aWxkcyBhZnRlciBlYWNoIHBhdGNoLiAgQXQgdGhlIGVuZCBvZiB0aGUgZGF5IHdl
IGRvbid0IHdhbnQgdG8gaGF2ZQ0KPnRoaXMgYnVpbGQgd2l0aG91dCB0aGUgYnVzIGRyaXZlcnMs
IGJ1dCBoYWNraW5nIGl0IHRvIHRlc3QgJ2l0IGNvdWxkJw0KPmlzIGEgZ3JlYXQgd2F5IHRvIGF2
b2lkIGlzc3VlcyBvZiBjb2RlIGluIHdyb25nIHBhdGNoZXMgZXRjLCBtaXNzaW5nDQo+ZGVmaW5p
dGlvbnMgZXRjLg0KPg0KPkpvbmF0aGFuDQoNClRoYW5rcyBmb3IgdGhpcyBhZHZpY2UsIGNvbXBp
bGF0aW9uIGlzIGFjdHVhbGx5IHF1aXRlIGVhc3kgdG8gdGVzdC4NCg0KPg0KPj4gIGRyaXZlcnMv
aWlvL2ltdS9pbnZfaWNtNDU2MDAvS2NvbmZpZyAgICAgICAgICAgICAgIHwgICAyICsNCj4+ICBk
cml2ZXJzL2lpby9pbXUvaW52X2ljbTQ1NjAwL01ha2VmaWxlICAgICAgICAgICAgICB8ICAgMSAr
DQo+PiAgZHJpdmVycy9paW8vaW11L2ludl9pY200NTYwMC9pbnZfaWNtNDU2MDAuaCAgICAgICAg
fCAgMjkgKw0KPj4gIGRyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDU2MDAvaW52X2ljbTQ1NjAwX2J1
ZmZlci5jIHwgIDc2ICstDQo+PiAgZHJpdmVycy9paW8vaW11L2ludl9pY200NTYwMC9pbnZfaWNt
NDU2MDBfYnVmZmVyLmggfCAgIDUgKy0NCj4+ICBkcml2ZXJzL2lpby9pbXUvaW52X2ljbTQ1NjAw
L2ludl9pY200NTYwMF9jb3JlLmMgICB8IDEwNCArKy0NCj4+ICBkcml2ZXJzL2lpby9pbXUvaW52
X2ljbTQ1NjAwL2ludl9pY200NTYwMF9neXJvLmMgICB8IDc5MiArKysrKysrKysrKysrKysrKysr
KysNCj4+ICA3IGZpbGVzIGNoYW5nZWQsIDEwMDYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkNCj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9pbXUvaW52X2ljbTQ1NjAwL2ludl9p
Y200NTYwMF9idWZmZXIuYyBiL2RyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDU2MDAvaW52X2ljbTQ1
NjAwX2J1ZmZlci5jDQo+PiBpbmRleCA1MGZkMjFhMjRlMzRkZWNmYmUxMDQyNjk0NmE1MWM2MTM1
M2ViNmE5Li41YmY5NTM1ZTI3ZTg5NDIzMTJmZTk3NDljZTBjNzMzMTQ5ZGUwYTlkIDEwMDY0NA0K
Pj4gLS0tIGEvZHJpdmVycy9paW8vaW11L2ludl9pY200NTYwMC9pbnZfaWNtNDU2MDBfYnVmZmVy
LmMNCj4+ICsrKyBiL2RyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDU2MDAvaW52X2ljbTQ1NjAwX2J1
ZmZlci5jDQo+DQo+PiBAQCAtNDU5LDYgKzQ2Miw3NyBAQCBpbnQgaW52X2ljbTQ1NjAwX2J1ZmZl
cl9maWZvX3JlYWQoc3RydWN0IGludl9pY200NTYwMF9zdGF0ZSAqc3QpDQo+PiAgCXJldHVybiAw
Ow0KPj4gIH0NCj4+ICANCj4+ICtpbnQgaW52X2ljbTQ1NjAwX2J1ZmZlcl9maWZvX3BhcnNlKHN0
cnVjdCBpbnZfaWNtNDU2MDBfc3RhdGUgKnN0KQ0KPj4gK3sNCj4+ICsJc3RydWN0IGludl9pY200
NTYwMF9zZW5zb3Jfc3RhdGUgKmd5cm9fc3QgPSBpaW9fcHJpdihzdC0+aW5kaW9fZ3lybyk7DQo+
PiArCXN0cnVjdCBpbnZfaWNtNDU2MDBfc2Vuc29yX3N0YXRlICphY2NlbF9zdCA9IGlpb19wcml2
KHN0LT5pbmRpb19hY2NlbCk7DQo+PiArCXN0cnVjdCBpbnZfc2Vuc29yc190aW1lc3RhbXAgKnRz
Ow0KPj4gKwlpbnQgcmV0Ow0KPj4gKw0KPj4gKwlpZiAoc3QtPmZpZm8ubmIudG90YWwgPT0gMCkN
Cj4+ICsJCXJldHVybiAwOw0KPj4gKw0KPj4gKwkvKiBIYW5kbGUgZ3lyb3Njb3BlIHRpbWVzdGFt
cCBhbmQgRklGTyBkYXRhIHBhcnNpbmcuICovDQo+PiArCWlmIChzdC0+Zmlmby5uYi5neXJvID4g
MCkgew0KPj4gKwkJdHMgPSAmZ3lyb19zdC0+dHM7DQo+PiArCQlpbnZfc2Vuc29yc190aW1lc3Rh
bXBfaW50ZXJydXB0KHRzLCBzdC0+Zmlmby53YXRlcm1hcmsuZWZmX2d5cm8sDQo+PiArCQkJCQkJ
c3QtPnRpbWVzdGFtcC5neXJvKTsNCj4+ICsJCXJldCA9IGludl9pY200NTYwMF9neXJvX3BhcnNl
X2ZpZm8oc3QtPmluZGlvX2d5cm8pOw0KPj4gKwkJaWYgKHJldCkNCj4+ICsJCQlyZXR1cm4gcmV0
Ow0KPj4gKwl9DQo+PiArDQo+PiArCS8qIEhhbmRsZSBhY2NlbGVyb21ldGVyIHRpbWVzdGFtcCBh
bmQgRklGTyBkYXRhIHBhcnNpbmcuICovDQo+PiArCWlmIChzdC0+Zmlmby5uYi5hY2NlbCA+IDAp
IHsNCj4+ICsJCXRzID0gJmFjY2VsX3N0LT50czsNCj4+ICsJCWludl9zZW5zb3JzX3RpbWVzdGFt
cF9pbnRlcnJ1cHQodHMsIHN0LT5maWZvLndhdGVybWFyay5lZmZfYWNjZWwsDQo+PiArCQkJCQkJ
c3QtPnRpbWVzdGFtcC5hY2NlbCk7DQo+PiArCQlyZXQgPSBpbnZfaWNtNDU2MDBfYWNjZWxfcGFy
c2VfZmlmbyhzdC0+aW5kaW9fYWNjZWwpOw0KPg0KPkFzIGJlbG93LiBObyBhY2NlbCBzdHVmZiBh
dmFpbGFibGUgeWV0Lg0KQ29ycmVjdCwgd2lsbCBwdXNoIHRvIG5leHQgcGF0Y2guDQo+DQo+PiAr
CQlpZiAocmV0KQ0KPj4gKwkJCXJldHVybiByZXQ7DQo+PiArCX0NCj4+ICsNCj4+ICsJcmV0dXJu
IDA7DQo+PiArfQ0KPj4gKw0KPj4gK2ludCBpbnZfaWNtNDU2MDBfYnVmZmVyX2h3Zmlmb19mbHVz
aChzdHJ1Y3QgaW52X2ljbTQ1NjAwX3N0YXRlICpzdCwNCj4+ICsJCQkJICAgICB1bnNpZ25lZCBp
bnQgY291bnQpDQo+PiArew0KPj4gKwlzdHJ1Y3QgaW52X2ljbTQ1NjAwX3NlbnNvcl9zdGF0ZSAq
Z3lyb19zdCA9IGlpb19wcml2KHN0LT5pbmRpb19neXJvKTsNCj4+ICsJc3RydWN0IGludl9pY200
NTYwMF9zZW5zb3Jfc3RhdGUgKmFjY2VsX3N0ID0gaWlvX3ByaXYoc3QtPmluZGlvX2FjY2VsKTsN
Cj4+ICsJc3RydWN0IGludl9zZW5zb3JzX3RpbWVzdGFtcCAqdHM7DQo+PiArCXM2NCBneXJvX3Rz
LCBhY2NlbF90czsNCj4+ICsJaW50IHJldDsNCj4+ICsNCj4+ICsJZ3lyb190cyA9IGlpb19nZXRf
dGltZV9ucyhzdC0+aW5kaW9fZ3lybyk7DQo+PiArCWFjY2VsX3RzID0gaWlvX2dldF90aW1lX25z
KHN0LT5pbmRpb19hY2NlbCk7DQo+PiArDQo+PiArCXJldCA9IGludl9pY200NTYwMF9idWZmZXJf
Zmlmb19yZWFkKHN0LCBjb3VudCk7DQo+PiArCWlmIChyZXQpDQo+PiArCQlyZXR1cm4gcmV0Ow0K
Pj4gKw0KPj4gKwlpZiAoc3QtPmZpZm8ubmIudG90YWwgPT0gMCkNCj4+ICsJCXJldHVybiAwOw0K
Pj4gKw0KPj4gKwlpZiAoc3QtPmZpZm8ubmIuZ3lybyA+IDApIHsNCj4+ICsJCXRzID0gJmd5cm9f
c3QtPnRzOw0KPj4gKwkJaW52X3NlbnNvcnNfdGltZXN0YW1wX2ludGVycnVwdCh0cywgc3QtPmZp
Zm8ubmIuZ3lybywgZ3lyb190cyk7DQo+PiArCQlyZXQgPSBpbnZfaWNtNDU2MDBfZ3lyb19wYXJz
ZV9maWZvKHN0LT5pbmRpb19neXJvKTsNCj4+ICsJCWlmIChyZXQpDQo+PiArCQkJcmV0dXJuIHJl
dDsNCj4+ICsJfQ0KPj4gKw0KPj4gKwlpZiAoc3QtPmZpZm8ubmIuYWNjZWwgPiAwKSB7DQo+PiAr
CQl0cyA9ICZhY2NlbF9zdC0+dHM7DQo+PiArCQlpbnZfc2Vuc29yc190aW1lc3RhbXBfaW50ZXJy
dXB0KHRzLCBzdC0+Zmlmby5uYi5hY2NlbCwgYWNjZWxfdHMpOw0KPj4gKwkJcmV0ID0gaW52X2lj
bTQ1NjAwX2FjY2VsX3BhcnNlX2ZpZm8oc3QtPmluZGlvX2FjY2VsKTsNCj4NCj5UaGlzIGNhbGwg
c2hvdWxkIGJlIGluIHRoZSBuZXh0IHBhdGNoIGFzIGl0J3Mgbm90IGRlZmluZWQgeWV0Lg0KU3Vy
ZS4NCj4NCj4NCj4+ICsJCWlmIChyZXQpDQo+PiArCQkJcmV0dXJuIHJldDsNCj4+ICsJfQ0KPj4g
Kw0KPj4gKwlyZXR1cm4gMDsNCj4+ICt9DQo+DQo=

