Return-Path: <linux-iio+bounces-21674-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF7BB055F8
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 11:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 881D67A6EC3
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 09:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AEC277CB0;
	Tue, 15 Jul 2025 09:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="gZb1Jb52"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA523238C1B;
	Tue, 15 Jul 2025 09:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752570730; cv=fail; b=gwYR5YiiI2m/A3LtvqHoGFljLo9zOQhYlfTg0WCHLRflRmCUgeXOW4uYLM0YUS/4SqbuLVZJBCNGCtx/ycaWcvM9C4GuUw8JU0B0rJeecuZsR+Bi+9kOLSB5GDa9zxjsMs7gxMPrZwiPHCX9nAoN0orArUfFLrTgLgwNPLqrcig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752570730; c=relaxed/simple;
	bh=D0t7f65NGYHFyA+2FRx015/QUt62ebYbjTISxuN1rGQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XgmcNARv0WQo9mOIoPtgaQRvsp5E02md5gYndilLeNYkcnUS0mIeopePO2sjfFSLefqtxQVcqlrLVUBFUsazFKt3ckwwXIhA70AfBj5FkQK+2KTWoIbTRVQuxCN27xwZYptDnVbuuD1dAa4ytSQlnSgrj5JPC8hcJCwO28wSOeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=gZb1Jb52; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ELo6cH013827;
	Tue, 15 Jul 2025 09:11:58 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazon11010044.outbound.protection.outlook.com [52.101.169.44])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 47uh2mhytp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 09:11:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5h7Lue28L6HEj66/hp6tkSfFQMqJt+LgKv03R9rRBYybpmXYRTrxqMQh0MqnY3F29TyYnQRQy3Pk8Rpz4pgpBRoClIkcMQqZVijK3FDI2zmJm4wleTb0WAbtAqD8YhjjUlC3J7g8EDPrqNWgdgd0LYQTU+3UgiQeQrvuBTWVEd5WL7u1A6hUOAxceuNrzLwDnegv/7KmWyOYi1VO+hfHR75E/eHKSDDGT69aNWXfCYS5QNNxvt8eDO4fkrKz+Hb9FFeENko5YMLG78DZO3xe+KOmbj1o4q7Zk72HgZZgdbpNf/pagjjPkbML8lUDBEKsQl/A4IRU2kyrF+81V2sHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0t7f65NGYHFyA+2FRx015/QUt62ebYbjTISxuN1rGQ=;
 b=nxufpI74e3UbIVtrp0O6A574pp8pygZJ1rpOw/pI+Ske1xPcffLW2LAtLj00TBUxOpQDKUzTG6nAAsop1ir6XJhnhMeCGxr0tOpdfgyMUXeSFAYQELzr+IdC5p0+0Qx/bBf13zKNqN4g6Mu5PX89Xe2/dzy1IICGLOvyj6w4fRbDHyuivThWIagfY6KIF3L3tfHZU6HNUW77djAdel7pjIb4Az9fCQZTI5OX+PaC4S9uefMf7YHtKT98BiJSrvet4BX6+vyqOTeB3zJ9pEDusJw7Lj5ziynTTnlQLWt9U8VGkD48c/zc+Z9ygfHZllzbcSonnz797rfbKp83rRM3ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0t7f65NGYHFyA+2FRx015/QUt62ebYbjTISxuN1rGQ=;
 b=gZb1Jb52WO0qrH5PInNxvn3n1VdYIOkfHuFoTc+9M1CyRjXcDt2/AkO904U78yzPDw6IGD3hnm8ipmA4O6dnfyE9cPbKQfcehT0b8ovGnB8XRdnKf7HO1bEq1p4/R9A5KLsXq2mz2d7324yOYpkfXGFXjqir73BQ7EkW5LO2RPXy9QDiSnGG29UjKjb4rkqLXizV5/hvtcqeLDdPHfXi6bQLlcG+uQXQgJWdn7q2HCnHSEl/+JTkl/LaAwDmcyaFfCdZN4jEp6g5XJ1TUl+zO91oMHoUynN7h+s7HUyCCo7RRJ2IrQOAXlzJbEfMeF+AUx6D4Y1Hl6teSkaGDkFI9w==
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::2d)
 by FR2PPF25532000A.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 09:11:47 +0000
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf]) by FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf%3]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:11:47 +0000
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
Subject: RE: [PATCH v2 2/8] iio: imu: inv_icm45600: add new inv_icm45600
 driver
Thread-Topic: [PATCH v2 2/8] iio: imu: inv_icm45600: add new inv_icm45600
 driver
Thread-Index: AQHb8XjFFPwNlXicDEKbiHsXjh6cu7QrF22AgAGz8eCAAAc1AIAGGyUA
Date: Tue, 15 Jul 2025 09:11:47 +0000
Message-ID:
 <FR2PPF4571F02BC69DF6807BAA188B2B3A08C57A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <20250710-add_newport_driver-v2-0-bf76d8142ef2@tdk.com>
 <20250710-add_newport_driver-v2-2-bf76d8142ef2@tdk.com>
 <aG-ID7O3HgVc1EOX@smile.fi.intel.com>
 <FR2PPF4571F02BC5366477EC02E9C44041A8C4BA@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
 <aHD7zEzvVuwSB9Ke@smile.fi.intel.com>
In-Reply-To: <aHD7zEzvVuwSB9Ke@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2PPF4571F02BC:EE_|FR2PPF25532000A:EE_
x-ms-office365-filtering-correlation-id: 79c34315-54b0-4113-0f52-08ddc37fa089
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|366016|7053199007|38070700018|3613699012;
x-microsoft-antispam-message-info:
 =?utf-8?B?S1JCMDV0L1pzeUZEbklkYVQ1SDNyOC9GWk5ITlloTVVmY05KNFovNUhYV0FE?=
 =?utf-8?B?c3d1bDVTZXFuUkN1ZEFiS0hKQ2dqZmRTSisxUkxyN3JCYW9ETHlXWWk2OHB6?=
 =?utf-8?B?ZllqdzBpUnFnaXM1UmViM1l1QTdUQnBvSUJYS28ycTdHQ002Y0lNM0hTQUQy?=
 =?utf-8?B?bmhFMStKakg5RHJySUJNZ2xPLzh2ck5ubWJZVDFEWVRnbkt2bnpWeG9TM3pJ?=
 =?utf-8?B?b1VPbVdBRTNiTVhHbjMrTFpYNlN3bFR1elh3MHUzVThsS05MSThFQmJKbDk3?=
 =?utf-8?B?THJNOGN1c0dzalZpakNsV3E4VXh2Y1BTOFQwY1FKaWp3elBiNm1MQldTNWNt?=
 =?utf-8?B?TkthaEZMQUppTkNVc2szMzB2RFZIQkdZeS83OTFVR01sSitkOHVIOWxmVFo1?=
 =?utf-8?B?NWtiWDJUYzRhZWFmbnNCdjlYV1kyS2I2S0o2OXpVM1dyTFBUd1V4T1ByTlRq?=
 =?utf-8?B?UjNTTTVnK1J1dGpYM2pKcmZSU1ZKbjlkbGI5blprZU16bWtiN2trNnJCYVRk?=
 =?utf-8?B?RnJHcDIxZzg0NkdkWVA1Y1FDZDNRWGVSOENDODgrQWc1UzZyMGlDQ2VqSmlz?=
 =?utf-8?B?SXg3dUdvZmZ6aWtPdE5rNDd3MXZuV0pZa0RUWlovRTVNdGNpdXNsdmx4bCta?=
 =?utf-8?B?a0QzUmM4MkIzYXR5NXVIUGgzVzJiUkp2eTA3UnNZUDBrejhTTVZkbzVzN0Fw?=
 =?utf-8?B?WkpSOFdVUWFUeHVWcnNkNkxQWFM4SWpsQ0tvVmRJSUdKQ2RZOGNEaHJOc0Uy?=
 =?utf-8?B?ZVBsUzR5d3hFbERtWjJ3WkY0dzltcmxwVDB6M3hDZlB1ZVNsd2FGQ1FqZWFq?=
 =?utf-8?B?YmRTelNUZ243dENiN0xmaFZtY3podVdETitXMWNoMHhzeFV4ZkVjd3NPeC8y?=
 =?utf-8?B?MXpXTTFuWk9teUZRazVkcmpjTTNqeTRRa3B6WWJ5WGRGeUsxUHRjZ0NrWHhR?=
 =?utf-8?B?Z2h1eXhRelRpWUpld2tRSUdXb2lBMTl0Sk15VDNvbExxZCtPTnB4ZDdIK2xy?=
 =?utf-8?B?L1VacW5jaGRCd0lxM2dSc283YTJkUHZ4TjU4OGxHdHRkK1MzdzFrM0g4ekVU?=
 =?utf-8?B?V2tWakdFQVlyWTBZUGNoMGlNY1ZjS1NJczlKN2FlMTJOdGtTWkR0eHFDYjF3?=
 =?utf-8?B?dnk5bjFPNlVlRXRsU1hZYXlqb2RGT2FwVlVxQVBkcnhLcGNrNVVxNkFQbVFR?=
 =?utf-8?B?dkZRaUl5WFBGNDgxVUNXUXhOUWxFUmF2bDQ2bDEzeTlBMDhLWUUyTVBHYUls?=
 =?utf-8?B?U2NCVnhYaFJkYm9wYjJjQ3hTcCs5VlQ1cFQ4ZUN6OEtSaERxajhWdjcyNk9x?=
 =?utf-8?B?Q2FvdEZNbEZnWFNQYXRUaVlheUJHejZRMlVQbG8rOFg1Z3NIWmd2cmdXMDhs?=
 =?utf-8?B?T3B1V3VWdFM3RVdQdkttaFR3UkJnZWhWYUNTZ3NkZW1LR0xqL2hDYkpCU2ty?=
 =?utf-8?B?dUxKUmlaZUZaODZQei9meEVJRUYzL3c2aEpWcDVQSGdrRWY0ekdnUGFLZ3Nx?=
 =?utf-8?B?ZytaNkhONjRocHlnb3drSElzdm1sMW5TdlVYOFJPVTRBdWlLM0J2YWFjbHU5?=
 =?utf-8?B?bmpXTGFYTXlMcy9zNVl0V1B2ZXJoMExlS1RCNTVKQmZ1cDdnZFdxRC9XWUxK?=
 =?utf-8?B?Zy91WWpBVnAwRkltdm9QNGNNc1JlK2Zod1hTd08rRkNQU2MxeEYrdWc4NDgx?=
 =?utf-8?B?UkppSjdUaG5JSnAyZ2FhTzBEaStzVVVXYmZ3QTFML2xieDJrVTFuRUs1enJy?=
 =?utf-8?B?OGRPR1dRRUN5UW1nczBIcG53U3NjOC9JcnhBbVBWN3JpaUkwa1RFVHowa3BV?=
 =?utf-8?B?VVA0LzFJdTlhTHN2L3dXS05yZTJzMDVORzRhM1hrdnAxNEFQMGE2OWl2OVVF?=
 =?utf-8?B?bUwya1ZtQmlnUUlvUVNxL1U4NnNqeHJhMmQ3T2JoZzQ5UE83U0pQTXZnUUt5?=
 =?utf-8?B?aSs3Wm1DZjZxa0drYk4wS1NsR1EySGhrSFJoODNwUldRTEl3MUlPbStiWDdr?=
 =?utf-8?B?c2Y3SWxlbnJ6R1I5cXJSMFdzSHE4WXpVbUZDMmpPdWhFTEJ6RERKeFBwTVBX?=
 =?utf-8?Q?E9i7fT?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(7053199007)(38070700018)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bExUQVBPR1JRVWJTdnFCbG9YVEZBL0RzU0FUdXZiMEhoaHhGd2FuNklCaEE5?=
 =?utf-8?B?VVJ3akMwdHdOR2VZekVURGovbmQ4L0h1NXlBS1QvOE90SUVIejJZQUpuU3pF?=
 =?utf-8?B?b1VhUkJ5bi82WnRoenZpM1dpMXREbU5lOURLQTZDQ1puR01QUnFvczNMbU5F?=
 =?utf-8?B?bjlPallma1BBeUdjMno4Ykpob2dlU29zVzVybFMyLytDR3NhRFlWR1RNSzIz?=
 =?utf-8?B?S2NSWUlVaEp0VmZkSEpiTGJJRXJHMVRnajBiMkFqbmpLLzBsSzd2K2xNS0Vq?=
 =?utf-8?B?Q0s5MTNVOWxjTFJNNTdUd1p0Mkt6RGk5UTI5c21pMkRlNSsyYmFYNWd0TzVI?=
 =?utf-8?B?MXZMY3dCd3pjMkxiMmlBR1k5bXNoalkxRXNlbkZsZlV5OWlNcjdXZEJwYVUv?=
 =?utf-8?B?ZGZocUVTZEJJUllqNUl4N21vTFprUit0MFNzOUVBNFV5aCszTDVIVWpMQldM?=
 =?utf-8?B?ellEeWZKSGVRK3lFY2VWRFh2Y1A4MG92QlFQVGZMNk1KQW1iSDFoZ2JJSjRo?=
 =?utf-8?B?LzhwUVFKSnpJSVR3bEtNU1ROdlV2WjZqM0xReVhCRG5sU2R6TXJ6dDloVzZo?=
 =?utf-8?B?dTVpNDk1NnBERFZETEVNQVB0VDEyRWM4QUE3SjZxMHZVbUJwYkV5bHY2V0xw?=
 =?utf-8?B?eFBVcCtoRm5FaTE5b0diRkd4SjBkNlVXaXJuWWhjOTNraE9DY08xb1dtZFh2?=
 =?utf-8?B?MjlLdU0zSU10UzFEenR2WDY5alhaK0E1Z0drdVNtdG9BTDdDR3p3KzB2UVIy?=
 =?utf-8?B?TDRwUU5kYk5VeCtpVTEzcWhHMWFnM2J5NHROTWJGRStYRGxEaGRpTzJqejdB?=
 =?utf-8?B?cnROMjBRbnpxUERZR3FuUURKam1FanlEUk0wRVA4TTRGdi82Q1FEQ0s2QUVC?=
 =?utf-8?B?K21FYWtYajYwdUVzTXBBemVPSjUzTmZ1bEV6OGh5OU03MVV4Wi92UllKK3py?=
 =?utf-8?B?S05mam5zUXpPUWVwQVlRZENOdUExV3k4MVBqbE5OdGxZOG5lb3hBMkp3L1Bv?=
 =?utf-8?B?b3hhek1jUGsxbHloTy9oVTRwR0lCQlZhSkE4b3lRTmluNURLUFlac0tnblNo?=
 =?utf-8?B?Q2RpOGoycWFVeUQ1YlJpVTEvaGx4cHdhcDd0SUlIWWtKYVVnNTJaeE5Hb0RG?=
 =?utf-8?B?N1d6ckxYS1QwOWQ3bWlRV0JJUHYySGdhYU5NRGdxMmdkSnFrWHl4RFBtblpI?=
 =?utf-8?B?QTdKZUZRdDF4Rk5rWGphNDNNcytZZE1iaWxOcXl3UU14RUdONW1TRnFBRFZF?=
 =?utf-8?B?REhIczBrK0RVMDNlZmpYVm1aQ2pTbHg0bER5MUthRUxZNVhmTzdEdTJXWlA3?=
 =?utf-8?B?UnQ3eXlUL0hWTmw4QmV2M00xdzVUUElrOG5lRWJWK3hVUmZjS24zWTFxSksz?=
 =?utf-8?B?R1pnWDV2b2JFdWFGNHFURTA5VTllM1FaYmx5MjVpeEFPZGZNNlBZdVpRWWt2?=
 =?utf-8?B?emhMWmEydC9yNHo3RzhCc3ZUTTFMRHMzb2ZBbWgycGJLUEcvNEZkaXZGSkZY?=
 =?utf-8?B?cVo0Rm9xeDB0bWFwUjMwc3RjV1lVQUJ2RWRSMEExOFBETEtUK1BHUTNzTXQ5?=
 =?utf-8?B?MmdNb3NCNXBuOEw5bVZtM3krOUdBaU51S0dWMHpuVzgwdnprZlhOKzFZUmhK?=
 =?utf-8?B?bnFXc1RhVXZCVGtMQlM5cmF1bitwaFhBVHE5VFhqcmFDK0Z3VjdVQ3pxQkVN?=
 =?utf-8?B?Y2ZFNjJqL0xpdS81N1QrMVUxV1Y1TWNlZjVZV3paZzBLbHI4d3JqTmN5M1hX?=
 =?utf-8?B?dmZLejFBWDd4WVBnbzFFV3NPWUo1TFM5QW9rZE1PNDJjRFBGV2JDWmhDS01M?=
 =?utf-8?B?anVGMi8vaFduZUxzQ3VpZjhiZXRERk91MDNwODVBUy9LMDBjVGt4UkxZQ3N3?=
 =?utf-8?B?RkpQeThqdWY4ajkrZFpINThLazU2alpOUm9xLzhEWVJzZm52eEQ0WlhtS2Ez?=
 =?utf-8?B?UXprNHgvaERySnRwN0RGWS90YkViL0kva24vVk1UUmNGcVpXOWhYWE8rbWZz?=
 =?utf-8?B?TDI4RjYvOHFNSVNjQ2l4U0ZVemkwMlhHVjVLUXdFZVpoODIrVERaOVhoYXdS?=
 =?utf-8?B?ajQyZDFCaWJSUHBiL3h6c1BlUFRKM00veGVvTEZkR2xXdFp2S09QeHRYMDYx?=
 =?utf-8?Q?mEoM2OAYVaIrLG7Y/neL4uqKt?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c34315-54b0-4113-0f52-08ddc37fa089
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 09:11:47.7505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JYCQID5ZB9LuTw1rrMXhRrzH+AARny+AKGGWLNWoiJI+ds4daCmgPAh3iF3bEFS9DBzEHQQqu1HBGMAJ3sigJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2PPF25532000A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4MyBTYWx0ZWRfX8No/dSBr+H6+
 PB1uKU/2X62/WFjS4T6nkjz7oTQqrAPdZsoTmALnm6dblb2qd6f1693jEKvCg++tL7zKExonKwY
 hz/MkKCvHiV/k5l4zNa2ChPWRgYJeRkgEtZtx2qa8BDCxHij93UXj6Z1vY0NookftFTsz8jUXZE
 DG8vw0CD9uBKuVrZswga/Egw8qGBsW/mdztmxeuNOm5LHpXWOCa22bI66xG6K9Jj+tC5DmKEqbe
 lIT+C4UXFc3LSBHqm7AmLv2L85ficksVGNx8nZTcH+D+2g0CEtIxU0QOWMQZikHIBT05Ug14AgL
 P6fSg9GntcjbDdo475m7rfxuYhnNssskMV7kuEYm1ocYwbIDKFvd+wFBQcPk4ZTXWn6aHojIZJy
 2BRWl28lDHTALbnbI6iUVs2AOvKL2qGwG0o6ZImkY41MwbqTkW0RdrGyVP7n1PgtMYjsXREi
X-Proofpoint-GUID: yL4-f9Vvwga7HR7SkEWW7JCT_BfBgBpF
X-Proofpoint-ORIG-GUID: yL4-f9Vvwga7HR7SkEWW7JCT_BfBgBpF
X-Authority-Analysis: v=2.4 cv=MdZsu4/f c=1 sm=1 tr=0 ts=68761b5e cx=c_pps
 a=aHdhKcOANwzZ53GNjwmXag==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=Uwzcpa5oeQwA:10
 a=QyXUC8HyAAAA:8 a=In8RU02eAAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8
 a=gAnH3GRIAAAA:8 a=i3VXfUYia7BG0nGZWDkA:9 a=QEXdDO2ut3YA:10
 a=EFfWL0t1EGez1ldKSZgj:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150083

Pg0KPg0KPkZyb206IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AaW50ZWwuY29t
PiANCj5TZW50OiBGcmlkYXksIEp1bHkgMTEsIDIwMjUgMTo1NiBQTQ0KPlRvOiBSZW1pIEJ1aXNz
b24gPFJlbWkuQnVpc3NvbkB0ZGsuY29tPg0KPkNjOiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0Br
ZXJuZWwub3JnPjsgRGF2aWQgTGVjaG5lciA8ZGxlY2huZXJAYmF5bGlicmUuY29tPjsgTnVubyBT
w6EgPG51bm8uc2FAYW5hbG9nLmNvbT47IEFuZHkgU2hldmNoZW5rbyA8YW5keUBrZXJuZWwub3Jn
PjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kgPGty
emsrZHRAa2VybmVsLm9yZz47IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz47IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MiAyLzhdIGlp
bzogaW11OiBpbnZfaWNtNDU2MDA6IGFkZCBuZXcgaW52X2ljbTQ1NjAwIGRyaXZlcg0KPk9uIEZy
aSwgSnVsIDExLCAyMDI1IGF0IDExOjMyOjQ4QU0gKzAwMDAsIFJlbWkgQnVpc3NvbiB3cm90ZToN
Cj4+ID5Gcm9tOiBBbmR5IFNoZXZjaGVua28gYW5kcml5LnNoZXZjaGVua29AaW50ZWwuY29tPG1h
aWx0bzphbmRyaXkuc2hldmNoZW5rb0BpbnRlbC5jb20+DQo+PiA+U2VudDogVGh1cnNkYXksIEp1
bHkgMTAsIDIwMjUgMTE6MzAgQU0NCj4+ID5UbzogUmVtaSBCdWlzc29uIFJlbWkuQnVpc3NvbkB0
ZGsuY29tPG1haWx0bzpSZW1pLkJ1aXNzb25AdGRrLmNvbT4NCj4+ID5PbiBUaHUsIEp1bCAxMCwg
MjAyNSBhdCAwODo1Nzo1N0FNICswMDAwLCBSZW1pIEJ1aXNzb24gdmlhIEI0IFJlbGF5IHdyb3Rl
Og0KPg0KPi4uLg0KPg0KPj4gPj4gK3N0cnVjdCBpbnZfaWNtNDU2MDBfc2Vuc29yX2NvbmYgew0K
Pj4gPj4gKyAgICAgICBpbnQgbW9kZTsNCj4+ID4+ICsgICAgICAgaW50IGZzOw0KPj4gPj4gKyAg
ICAgICBpbnQgb2RyOw0KPj4gPj4gKyAgICAgICBpbnQgZmlsdGVyOw0KPj4gPg0KPj4gPkFueSBv
ZiB0aGVtIGNhbiBob2xkIG5lZ2F0aXZlIHZhbHVlPw0KPj4gDQo+PiBZZXMsIHdoZW4gc2V0dGlu
ZyB0aGUgY29uZmlndXJhdGlvbiwgYSBuZWdhdGl2ZSB2YWx1ZSBtZWFucyAia2VlcCBwcmV2aW91
cyBjb25maWd1cmVkIHZhbHVlIi4NCj4+IExpa2UgaW4gdGhlIElOVl9JQ000NTYwMF9TRU5TT1Jf
Q09ORl9JTklUIG1hY3JvIGJlbG93Lg0KPg0KPkkgc2VlLCBidXQgY2FuJ3QgaXQgYmUgYXMgc2lt
cGxlIGFzICJiaWcgbnVtYmVyIiB3aXRoIHRoZSBwcm9wZXIgdHlwZSBpbnN0ZWFkPw0KPg0KPiNk
ZWZpbmUgLi4uX0tFRVBfVkFMVUUJCVU4X01BWCAvLyBvciB3aGF0ZXZlciB0eXBlDQpZZXMsIEkg
Y2FuIHN1cmVseSBmaXggaXQgdGhpcyB3YXkuDQpJIGFncmVlIGl0IHdpbGwgYmUgY2xlYXJlci4N
Cj4NCj4+ID4+ICt9Ow0KPg0KPi4uLg0KPg0KPj4gPj4gKyNkZWZpbmUgSU5WX0lDTTQ1NjAwX1NF
TlNPUl9DT05GX0lOSVQgICAgICAgICAgICAgICAgICAgICAgICB7LTEsIC0xLCAtMSwgLTF9DQo+
PiA+DQo+PiA+VW51c2VkLg0KPj4gVGhpcyBpcyB1c2VkIGluIGxhdGVyIHBhdGNoIG9mIHRoZSBz
ZXJpZS4NCj4+IEkgd2lsbCBtb3ZlIHRoaXMgZGVmaW5pdGlvbiB0byB0aGUgcGF0Y2ggdXNpbmcg
aXQuDQo+DQo+WWVzLCB1bnVzZWQgaW4gdGhpcyBjb2RlLiBZb3Ugc2hvdWxkIGNvbXBpbGUgdGhl
IHNlcmllcyBpbmNyZW1lbnRhbGx5LA0KPnNvIGVhY2ggcGF0Y2ggd2lsbCBnZXQgYSBjb21waWxh
dGlvbiB0ZXN0LiBUaGlzIGlzIGNhbGxlZCBjb21waWxlLXRpbWUNCj5iaXNlY3RhYmlsaXR5LiBB
bHNvIHJ1biB0aGUgc3lzdGVtIGVhY2ggdGltZSB0byBjb25maXJtIG5vIHJlZ3Jlc3Npb25zDQo+
KHRoaXMgaXMgY2FsbGVkIHJ1bi10aW1lIGJpc2VjdGFiaWxpdHkpLg0KWWVzIEkgZGlkIHRoYXQg
Zm9yIGVhY2ggcGF0Y2gsIGV2ZXJ5dGhpbmcgYnVpbGQgc3VjY2Vzc2Z1bGx5Lg0KSW4gdGhhdCBj
YXNlLCBub3RoaW5nIGlzIGJyb2tlbiBkdWUgdG8gdGhpcyBlYXJseSBkZWZpbml0aW9uIG9mIHRo
ZSBtYWNyby4NCkJ1dCBJJ2xsIGRlZmluaXRlbHkgbW92ZSBpdCB0byBsYXRlciBwYXRjaCBmb3Ig
Y2xhcml0eS4gDQo+DQo+Li4uDQo+DQo+PiA+PiArICAgICAgICAgICAgICAgICAgICAgIHVkZWxh
eShJTlZfSUNNNDU2MDBfSVJFR19ERUxBWV9VUyk7DQo+PiA+DQo+PiA+Q2FuIGZzbGVlcCgpIGJl
IHVzZWQgaGVyZT8NCj4+IEkgd2lsbCB1c2UgZnNsZWVwIHRoZXJlLg0KPj4gSXMgaXQgcmVjb21t
ZW5kZWQgdG8gdXNlIGZzbGVlcCBldmVyeXdoZXJlIGVsc2UgaW4gcGxhY2Ugb2Ygb3RoZXIgc2xl
ZXAgQVBJcz8NCj4NCj5Ob3QgZXZlcnl3aGVyZSwgYnV0IGluIGdlbmVyYWwgeWVzLCBpZiBpbiBk
b3VidCwgdXNlIGl0IChidXQgdGhlIGF1dGhvciBpcw0KPnRoZSBvbmUgd2hvIGtub3dzIHRoZWly
IHRoZSBjb2RlIGFuZCBhbnN3ZXIgdG8gdGhpcyBxdWVzdGlvbikuDQpPayB0aGFua3MhDQo+DQo+
Li4uDQo+DQo+PiBJdCdzIHByb2JhYmx5IHNhZmVyIHRvIGtlZXAgdGhlIGRlbGF5IGV2ZW4gaW4g
Y2FzZSBvZiBmYWlsdXJlIHRvIG1ha2Ugc3VyZQ0KPj4gdGhlIGRldmljZSBpcyByZWFkeSBiZWZv
cmUgbmV4dCBvcGVyYXRpb24uDQo+DQo+SSBhbSBub3Qgc3VyZSBhYm91dCBpdC4gV2h5PyBUaGlz
IGhhcyB0byBiZSB3ZWxsIGp1c3RpZmllZCBhcyBpdCdzIHF1aXRlDQo+dW51c3VhbCBwYXR0ZXJu
Lg0KT2sgSSB1bmRlcnN0YW5kLCB0aGUgaGFyZHdhcmUgbmVlZHMgdGhhdCBkZWxheSBpZiB0aGUg
YWNjZXNzIHdhcyBhY3R1YWxseSBkb25lIG9uIHRoZSBidXMgKHRvIG5vdCBqZW9wYXJkaXplIG5l
eHQgYWNjZXNzKS4NCklmIGEgcmVnbWFwIGVycm9yIG1lYW5zIHRoYXQgbm8gcmVhbCBhY2Nlc3Mg
b2NjdXJlZCB0aGVuIHRoZSBkZWxheSBpcyBhdm9pZGFibGUuDQo+DQo+LS0gDQo+V2l0aCBCZXN0
IFJlZ2FyZHMsDQo+QW5keSBTaGV2Y2hlbmtvDQo+DQo+DQo+DQo=

