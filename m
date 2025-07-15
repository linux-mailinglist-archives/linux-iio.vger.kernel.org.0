Return-Path: <linux-iio+bounces-21686-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E87D0B062EB
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 17:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F7D16DDDB
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F14A239E62;
	Tue, 15 Jul 2025 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="HofvfYh5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443522288D5;
	Tue, 15 Jul 2025 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593225; cv=fail; b=V9uhmORVdBi2hWgtuWx0s6N+Dxn30sdnoLrI9KELPr+a7R1t78MDgg5HSW2yiewjMrHWMH22sqpAFizz8AT1ZCHFkcVLfitMd4ds1GVSkFoIS6sgyojCoLt+V0lmH8YpVJ4lFzpg1PDu3xB0R1aIrnBWKgxadCA/M2bz5PUpjrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593225; c=relaxed/simple;
	bh=KTjCVOaP5kIPaoL5W4alUldWpmItd8EjgN2nKdN2m3I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pb+HmRPH7sjp1YSPjuJxIZ8fvTFaoE7jNJWQmit4GAXM0LdwiRezkTwdscR0+XCjx6ybHdJPp4r0pM6JNFy+Kc2FJ3c0fzeZzqK3qRZ3e2Y/KPj3U6973uu5lBUUgZnMPHJ9bshkAmZB2c4xMLF6C8Yy37hDIoCgN/Ey11x6ShE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=HofvfYh5; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EMBLXJ002463;
	Tue, 15 Jul 2025 15:26:55 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazon11010057.outbound.protection.outlook.com [52.101.169.57])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 47uft5t9h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 15:26:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cewAM5GhIZt6l/rNW8IsFJOh19r5nKGgvnCPqi8RHPKtHm7s0eI2RR+UBAZhrhpGfXhsYi9Yc6ONXY+tj5u0j1vPH+xHdQBWyKxnesYs27XM8lmuNiNjcvY+mQJPQoG9oq0jp2eU1e7hIPFax6jokja00lPn/VlVfbrrPWt+iJmhbgWTZ4qJLJM7QghBSEEvtKkgDsQHGYwHPqFdpDiRxPvbtAw4lDjDq49GYTODH5LDMdZeApvYzF6+cwivExkvCjlObP50pIrRPG03NwbnM8VBY9BtqyCDYBIKVrx9hQKjLviXW9eOFZV8ye+z6eKXOdxJqJyiY4dJbkp21G7v+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTjCVOaP5kIPaoL5W4alUldWpmItd8EjgN2nKdN2m3I=;
 b=lMRceR3c95cDIgEcMi2LGlu9wwtvVU25R7Js0fMSrxRLx7Toezl3lly4qyyJJ6r48s+arqkv+RKVlBgX1XKN2AbBn2PjK70HHA0M1Pa3gmBsO9EpGzkKZX/08pcvNOyZlJlSIb5tsVw1zb3Ij+cfLWwWBT3WyqoxxDrNLIvd7O0NmJFgFfrAmPCzY0wsLV8ce29/iVjcf+McMBoVjG3A5p67wwcYiSpH9xz0l3wRZqNov0EIlrP/JcGa/UYQ61Lx2K+Ds6s63NfyDZg83P4uYBZvxgCt0QIVRa5Evc8SWhWbhvM4P5GZGiTsPW64mKcAFY5Mbbd22XDio4hYRmJuGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTjCVOaP5kIPaoL5W4alUldWpmItd8EjgN2nKdN2m3I=;
 b=HofvfYh5FxzLRBnYlr4E+C57EMUtTKSrLAeo8glNZxeMgY3Stn25H01LjxxlrHGhYV/pwPf+xWr/cnTA/5w6VWC6t1aJ8l6VtkjxKkMPCnR5TuHWv54DdujkoBbPo3hUnUlspyAdBrvEoRPEco0NEBtWQoInuGFg/wkmrWSKgBl/WvR7Rdm2D+IG55B+mkMpe3MKjd+FovKZwkEnT+/JU6BwVW2M8vFC8/hJbIRAOM/dDFQhyk+Q+YW9Dmp+woUmNf2b8sNBaAryfKIFS3554wwZhyYEE+deLwRhzA/dcmvxh/Jkh8KLJiiJqLAg/HF0hvC8q39yRPPzhrmquvMLWw==
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::2d)
 by BE1P281MB1762.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:1e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 15:26:49 +0000
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf]) by FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf%3]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 15:26:48 +0000
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
Thread-Index:
 AQHb8XjFFPwNlXicDEKbiHsXjh6cu7QrF22AgAGz8eCAAAc1AIAGGyUAgAAZrACAAE3q8A==
Date: Tue, 15 Jul 2025 15:26:48 +0000
Message-ID:
 <FR2PPF4571F02BC1A8F6E7F098A498E0B9C8C57A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <20250710-add_newport_driver-v2-0-bf76d8142ef2@tdk.com>
 <20250710-add_newport_driver-v2-2-bf76d8142ef2@tdk.com>
 <aG-ID7O3HgVc1EOX@smile.fi.intel.com>
 <FR2PPF4571F02BC5366477EC02E9C44041A8C4BA@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
 <aHD7zEzvVuwSB9Ke@smile.fi.intel.com>
 <FR2PPF4571F02BC69DF6807BAA188B2B3A08C57A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
 <aHYwmEv1sCI-qi0T@smile.fi.intel.com>
In-Reply-To: <aHYwmEv1sCI-qi0T@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2PPF4571F02BC:EE_|BE1P281MB1762:EE_
x-ms-office365-filtering-correlation-id: c23cb381-3cb2-4eae-b7ef-08ddc3b403f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|19092799006|7053199007|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cmN5R0xkQXhCWVYwZEFLRU9ab2pYVVdoOVZoVmxrcDRlWkE4eUZzalZrZnlt?=
 =?utf-8?B?RWVpd3REck40ZEx2OS9xbGlJTGRBMXgwOHRlcXVHYkg0QVdxYkgrWUE0TzYw?=
 =?utf-8?B?Y2E2ZVRQNjg5NUJOY01ndDFxeTBhdWhLN2lHY21ycGlYQkluSmtaVlpJclFm?=
 =?utf-8?B?azNEU3k2bmdrVldDYnJpZkg4U2s5QS93ZG5OcTVMbVlUTHkzK3h6NEc5cTho?=
 =?utf-8?B?SGZEVWczMktLUWlUU0RxTkZ2TTMwS1ZIbmhUbDJJNHlwR29vdXVtSEVoam40?=
 =?utf-8?B?eXNiK1h0anFlWThvQVA5TVFucTZ3MmNwT0NPQjRGV1NBMVpCeU9XVUhMUnB1?=
 =?utf-8?B?VWlveVRXYjhNOGw4SWFMRzhjUlkveVErV2tlc2NRSUZNcVBzb09yNVFmODlW?=
 =?utf-8?B?VUlFeXdtN2NaZkROb0FVT00rL1h0TEhXMG96R1ordDlZMFNRQ2JHclFFVUJt?=
 =?utf-8?B?cGM2Q200ajZTOHE1Rkx5ajZDa29GWnRDVFM4STJoOTBXWTJ5bE1qVHdITitp?=
 =?utf-8?B?dUdqQURpMVdWQUxabnRoNmhHUUNPU2UxSHVDV0FzZkpkcGxuT0IvNjRlK0Fa?=
 =?utf-8?B?eW5Wb3V6VXQ5enBPVTRUTjRuVk16VWt5cG01N0hrU1N0YVlvTG9telA2dTFL?=
 =?utf-8?B?UC91NmhJaXU1cGpOd3BieWFUWmMzd1JxenM5MWZRdEFIOElrVmNycU5Ea2Fw?=
 =?utf-8?B?clJBV0VqM1phazlMVHZjbkZHbnh4cmR6U0drL1pTMlVINWFLZlNPQmwrOXZK?=
 =?utf-8?B?TnZqTEpXOGlGWjI4Q3NSa1NlM1k0bVRMbzVFNmtjUExKVkd5UHZyNVhNa1Ay?=
 =?utf-8?B?bDRvNDY4ank2NDF3UndHcDZEZDUxR2pqNlVpTmt2SW1JUnVodEljckZzcG84?=
 =?utf-8?B?YWFlS3BqSjZBd0NIcEFycXBNVUhaYlhDUVdzNW1DTzFPTVIrNmpua0pPYkFS?=
 =?utf-8?B?a3RLb1lSNEcrVnFkbVBPLzBGYVNKMHZQWWhKWVVraHowTWxNczk5L2FWc0E1?=
 =?utf-8?B?NTExTThkOTFwREN0T2d5WmxEMCs0NGF2TU94b3J3NG0yc244M1hQK0N6T1c5?=
 =?utf-8?B?bUhkOUhxMGNhZzRMeFdMMDM2TUgvQ0pRRkt5TVlZQ1NJUlNnNko5b0E1Mmx2?=
 =?utf-8?B?UTB3bFNPcDFrOS8wdTFkU2VDcTlvK1JhNnpiN28wREl5bGYvV1l4L2J4U0xr?=
 =?utf-8?B?TldRaEM1Zng3dU1RV3VRL0NKd2xjSFNOeURpZ283SVNyL3JNZS96M0NkQWwv?=
 =?utf-8?B?K2JORmFacDhZUGRaT2dKRUxUYnpwb2UyQ3paZW5nS0tFWisxTTFWVmJOUU5z?=
 =?utf-8?B?Vno2SFE4RWFjcmQ0RnNxak9rZER2QTNncGk5bUljK0JMSktrM0RvOVA0YmVa?=
 =?utf-8?B?dDYyZ0F3OHlwbzdoSzNOdVk2d0tLclZIR29RUTAvOVJ1R0VYWUdBM2dGY0E2?=
 =?utf-8?B?ZDR2SXVWc2Z6NHhyb3MwV20yeHN5QzBiK2JpbXBsZGk5d2JkK1ZRZ0l4QlRT?=
 =?utf-8?B?VnhXYkF6RnQzaUpDUU15dWtLZTIxcWhKVjIvL3YyOEYycjRyQ0ZpT2tPNUwy?=
 =?utf-8?B?cTdvRlc4ajJnWUdwU3krQ3lVTGRETnI4VUt5cFl1MHlmTnE0QkVMZ094S1Ba?=
 =?utf-8?B?YWNxYkU3NUIreVFBWk9LV0lST3ZKT3hhSmludElHOFI0SGhjNlRacFRlNGtN?=
 =?utf-8?B?Q1JKakZvV0dIN3cwcm0rZ0VzTmx6OEVITG9FU1h4ckw0cXJHZUE3UjFKY2FI?=
 =?utf-8?B?THBucnF4Z0E0S2oxa0drTjNJZ2FFMThaVDc4YkFSaEkwSDdseHRKNU5LYVUw?=
 =?utf-8?B?OWVtd1ZJdHovMEZ2Mm93ckk4TEpYdWIxNTQ5dTNXYUlVR0srWFI3RnFHalFy?=
 =?utf-8?B?VDMvRGplVmlMNkFUVHNlblhVU2FDRncyR0EybXJ0Y0FJTnpaWjFMb2gwb0VW?=
 =?utf-8?B?d2dxQk00Vm51ZmV1aUExVk1Tc1pmMDFMVmpjSy9vVGROS1ovQTk4a25wUU4x?=
 =?utf-8?B?SXYreFRvZExOMkNrVjJNdmRPNElHd2pKNDBlVUhGbW5tRWJyV1h4ZjhwWHpl?=
 =?utf-8?Q?aqbvTm?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(19092799006)(7053199007)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RlBVM0pKRWl1T05tY0dUeTU5amFCcWtpYzNvK2d5YWJsUUVzUVVmRmQybHpM?=
 =?utf-8?B?SzNlUFh1U1VwZUlhVkFHdlpVcTI3aysyK2VnRlg5OUVvZTJUekNpQU1LN01J?=
 =?utf-8?B?ZlZFQ2ViMldGaURMb0lFZk4xVjV0MkFiam8zeEVHL1dOM1RSR05aK2dOUjJH?=
 =?utf-8?B?eG54Y04zUkVaTEV1MTJsTnM0MC9NSzlYeW03YVI4N0tOY2JyUC84cVZCSkFV?=
 =?utf-8?B?ZGd0c2dBN3plUTVraWRXS25hNHRaUnVpWnVSaDRaQTYzMC9OSGErK2s1ZEYv?=
 =?utf-8?B?K2MxZS9FOEtlV3I0aERTM2RkamVUL1RHYTJSbXlTbG9yVGhMa1pXanB1c1ZV?=
 =?utf-8?B?UkRCQ3JyRG9LaStrM1pZcHFXTHo4MDZWdXpINC9lMHVTR2lwUkorM2ZHUEpB?=
 =?utf-8?B?TkVwK3R6ZnFURjB5dHR3d0dNUEtEekpEZy9kVk5xL2hkdm1XWjBOQndXSGtX?=
 =?utf-8?B?Q2JrbDhpeU9penpRVWdlRzJBdXZUVVh4cTNuTUgxeHVtanNtQ0Q5aS9YNU5x?=
 =?utf-8?B?OTBPTms2T2ZCaE82VXRSdTBLWDBYNmNDUnhhQlhXc3VaMzc5YThsNVV5T2Fm?=
 =?utf-8?B?NTFaN3NOdjV1QmpKZm9ISlB6OVVUaS9lWi8rL29UaE5JOVpBdWt5WFhTZWxQ?=
 =?utf-8?B?Q0NzQTZ6Q09DWXlZZlU2bXFSTHQ2Vi82YkJCNXBtWWd5ZVYxVjNhbjVTTUlh?=
 =?utf-8?B?NG82ZTFZaC83Q2hkYzQ0OU1Kb2dzRFdwMDhBYndjQnRxS1BiN1RXN1ZFa1dD?=
 =?utf-8?B?TDM4RmhVSitIQytQYkJ4OFVXYmlTaTNaOVllUjdLYmo0MFE5YUlyQjdsbUph?=
 =?utf-8?B?TDNUUlk3Z3lPSEtTdXBrN1F4T2FzUnBzb0RML211cDh3QlhtVXpMOVRXZE9B?=
 =?utf-8?B?YkFMZzVka0Y1RWNEMmMrdnRGWVBSNER3N3Q4ZFlLUmpQbXEzbEVqaVI1QTBG?=
 =?utf-8?B?REVnOUcxTUluNFZ4K05JMWFpKzVjajZEczFTSlFxaWsvc0RQdEhpMGtwQmlF?=
 =?utf-8?B?ZFlmSmpkR1VMb2E1L1pCeUkrRVV5UzBVOGVlZlVtbVpFaEtDY0dzbFl1Ymhy?=
 =?utf-8?B?TUpVY2RWSG1neGY2cjRxZjFxMDd4MXMvNVdwb2Y5QjQ0ZFIzaG5lNG1JL0pu?=
 =?utf-8?B?T3o2RWtRL2lrMDQyUUpwZFZBT1FSWjFLcFdXRTl6YXBpTzMwQVpLcHBydGlC?=
 =?utf-8?B?dkcyTjEyWmhoYjVGMkdYRUMrQ01zbVlFOGJCMlVmSFpsNGRQRHovT3NQdVd1?=
 =?utf-8?B?UHRTUEZQMXpvTDU1YWtrNU1uV1dOZnFRQ0Y4K2UvYnlMYVFNUXZkSnkvSVFX?=
 =?utf-8?B?UU91N0IrS1lnNml5c3RYaWJjcUtYZ2VWV1FDK1loWUwzTk53RjJxSndlOUpH?=
 =?utf-8?B?ZkV4Q0Y4bFJ3bDVFNDNEdWRvTG91ZmFjM09wV2xoVDM0L1R1RlA0VDhIRmJl?=
 =?utf-8?B?Mmc0Z3BIN3h5c0NVclNtU05Ec0U4Z29lS1NlL0pycVUyaUJqRDh5LzkvYzFh?=
 =?utf-8?B?QUtQcDhPa280b1l6STZ1em8yQSt3d3Eyd0hLZEJrTFlVSTl1VUxNeHV3bjZk?=
 =?utf-8?B?NERXejFoSW4zeHJFTmt5dm1xMGFxaVIyZkJ6MkRVV1BlNlBtKzFVRjMwem5D?=
 =?utf-8?B?R3NrbGFoNWhQUlZHZTc0UWZNQUdQNUN0dHk3VXM1RDh0UWJ1WkF4cGk4RWV3?=
 =?utf-8?B?UnVqakhjUEd2MDVHV080aCtZTGQ0Mk9PMy9xRWFVaWtvOWk5T0p2MHRYbHZR?=
 =?utf-8?B?dFhMSzFYOUQ5Um5Oa093ajYxU1pMdGpMd2xIVW52bnp3RU5xaGNxSEdQVDdP?=
 =?utf-8?B?cmlmVWRzTFNsVUdFZ3I3VHdxb1BhYUpiNG04M3FWaWxjcXlCemtOdkFGaXdC?=
 =?utf-8?B?MVdET2h6U3BkVWI1ZEFPYXEvQnZIRldzWkhsZnljb01WRUxueVFEdzB0bkZp?=
 =?utf-8?B?UGFwcVowN0FxY3NFK0hZMXNDZUVHZmhPNTkxRmxZdVhuK09rdXhBOE5XeUZm?=
 =?utf-8?B?MngyN3k3Ti9Ud2hndjJ2N2lqRVRuZXhTT1VOU0RjWFMrMlZCMEdrbjlwTURp?=
 =?utf-8?B?U1k5NTR5dWRVZHFJMXVYQk9qS3VzZW1zRWcvMXAwMHYxM3ZBNXZleW45Smt5?=
 =?utf-8?Q?UsqC7CWzlYmtene1krHtJzvoY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c23cb381-3cb2-4eae-b7ef-08ddc3b403f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 15:26:48.4353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 70S7u3jvJD16bAYByeqt9F+8UkrU72fEmBD/AqQRpQOFbdJL7ZqOIGUyLV9GsoykcSobrDRrvkKWk7KqRsV+Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB1762
X-Proofpoint-GUID: -gfMsveTPBMmuT1MB1fYo7lPhpSB1t5E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE0MiBTYWx0ZWRfX2Hebt0JFdzKV
 4IAwb/2G6fltEO8ahmZ39ik2CAQhcViQ3Jl4jIG2mrbw3BfBc+236VZcWOfiqJzufuh2QZUtvXk
 vuHJl4Dum1YAYq8JfmfiSwZOQad1l1SHNVkuIRqIEwKOZAFqHORx2Sn/JEcGflE6RkZsjUP9hhP
 8bNWSnz3TfV5LClcxIS5Im+hpprmW203ccBP6qqqNGkYIojKrQGPvpGnKBRXrBToHChz8VTGgdH
 jXbOCqvv13UmicdMFTE4zG1kX40SO638xJzyxqoqUSIpWzGixcuqydlo3MdHEhwz4q7pIQDmz6g
 hVHOMyYyggTN/mqYs14ngDI8dy7vhYcrOUesHhX66+tCHBgZ3FRl9Rxa0iqriKIRnDY5+VKS2XQ
 vd5wdO6X78huAK5T/e6rOWpUxxzzVti03IX6H3ksQfZ9I0cvQFXJ8mXPUMBXA8KQE1fGSB9f
X-Authority-Analysis: v=2.4 cv=QLxoRhLL c=1 sm=1 tr=0 ts=6876733f cx=c_pps
 a=DI9g6cbbtHrvmG/Mnq1W1g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=Uwzcpa5oeQwA:10
 a=QyXUC8HyAAAA:8 a=In8RU02eAAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8
 a=gAnH3GRIAAAA:8 a=H7BOaPT5MLAVoobkZ0QA:9 a=QEXdDO2ut3YA:10
 a=EFfWL0t1EGez1ldKSZgj:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: -gfMsveTPBMmuT1MB1fYo7lPhpSB1t5E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150142

Pg0KPg0KPkZyb206IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AaW50ZWwuY29t
PiANCj5TZW50OiBUdWVzZGF5LCBKdWx5IDE1LCAyMDI1IDEyOjQzIFBNDQo+VG86IFJlbWkgQnVp
c3NvbiA8UmVtaS5CdWlzc29uQHRkay5jb20+DQo+Q2M6IEpvbmF0aGFuIENhbWVyb24gPGppYzIz
QGtlcm5lbC5vcmc+OyBEYXZpZCBMZWNobmVyIDxkbGVjaG5lckBiYXlsaWJyZS5jb20+OyBOdW5v
IFPDoSA8bnVuby5zYUBhbmFsb2cuY29tPjsgQW5keSBTaGV2Y2hlbmtvIDxhbmR5QGtlcm5lbC5v
cmc+OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraSA8
a3J6aytkdEBrZXJuZWwub3JnPjsgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsg
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDIvOF0g
aWlvOiBpbXU6IGludl9pY200NTYwMDogYWRkIG5ldyBpbnZfaWNtNDU2MDAgZHJpdmVyDQo+DQo+
T24gVHVlLCBKdWwgMTUsIDIwMjUgYXQgMDk6MTE6NDdBTSArMDAwMCwgUmVtaSBCdWlzc29uIHdy
b3RlOg0KPj4gPkZyb206IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AaW50ZWwu
Y29tPiANCj4+ID5TZW50OiBGcmlkYXksIEp1bHkgMTEsIDIwMjUgMTo1NiBQTQ0KPj4gPk9uIEZy
aSwgSnVsIDExLCAyMDI1IGF0IDExOjMyOjQ4QU0gKzAwMDAsIFJlbWkgQnVpc3NvbiB3cm90ZToN
Cj4+ID4+ID5Gcm9tOiBBbmR5IFNoZXZjaGVua28gYW5kcml5LnNoZXZjaGVua29AaW50ZWwuY29t
PG1haWx0bzphbmRyaXkuc2hldmNoZW5rb0BpbnRlbC5jb20+DQo+PiA+PiA+U2VudDogVGh1cnNk
YXksIEp1bHkgMTAsIDIwMjUgMTE6MzAgQU0NCj4+ID4+ID5PbiBUaHUsIEp1bCAxMCwgMjAyNSBh
dCAwODo1Nzo1N0FNICswMDAwLCBSZW1pIEJ1aXNzb24gdmlhIEI0IFJlbGF5IHdyb3RlOg0KPg0K
Pi4uLg0KPg0KPj4gPj4gPj4gKyNkZWZpbmUgSU5WX0lDTTQ1NjAwX1NFTlNPUl9DT05GX0lOSVQg
ICAgICAgICAgICAgICAgICAgICAgICB7LTEsIC0xLCAtMSwgLTF9DQo+PiA+PiA+DQo+PiA+PiA+
VW51c2VkLg0KPj4gPj4gVGhpcyBpcyB1c2VkIGluIGxhdGVyIHBhdGNoIG9mIHRoZSBzZXJpZS4N
Cj4+ID4+IEkgd2lsbCBtb3ZlIHRoaXMgZGVmaW5pdGlvbiB0byB0aGUgcGF0Y2ggdXNpbmcgaXQu
DQo+PiA+DQo+PiA+WWVzLCB1bnVzZWQgaW4gdGhpcyBjb2RlLiBZb3Ugc2hvdWxkIGNvbXBpbGUg
dGhlIHNlcmllcyBpbmNyZW1lbnRhbGx5LA0KPj4gPnNvIGVhY2ggcGF0Y2ggd2lsbCBnZXQgYSBj
b21waWxhdGlvbiB0ZXN0LiBUaGlzIGlzIGNhbGxlZCBjb21waWxlLXRpbWUNCj4+ID5iaXNlY3Rh
YmlsaXR5LiBBbHNvIHJ1biB0aGUgc3lzdGVtIGVhY2ggdGltZSB0byBjb25maXJtIG5vIHJlZ3Jl
c3Npb25zDQo+PiA+KHRoaXMgaXMgY2FsbGVkIHJ1bi10aW1lIGJpc2VjdGFiaWxpdHkpLg0KPg0K
Pj4gWWVzIEkgZGlkIHRoYXQgZm9yIGVhY2ggcGF0Y2gsIGV2ZXJ5dGhpbmcgYnVpbGQgc3VjY2Vz
c2Z1bGx5Lg0KPj4gSW4gdGhhdCBjYXNlLCBub3RoaW5nIGlzIGJyb2tlbiBkdWUgdG8gdGhpcyBl
YXJseSBkZWZpbml0aW9uIG9mIHRoZSBtYWNyby4NCj4+IEJ1dCBJJ2xsIGRlZmluaXRlbHkgbW92
ZSBpdCB0byBsYXRlciBwYXRjaCBmb3IgY2xhcml0eS4gDQo+DQo+WWVhaCwgdGhlIHByb2JsZW0g
aXMgdGhhdCB0aGUgKHVudXNlZCkgZGVmaW5pdGlvbnMgYXJlIG5vdCB3YXJuZWQgZXZlbiB3aGVu
DQo+YG1ha2UgVz0xYC4gQW5kIEkgZ3Vlc3MgSSB1bmRlcnN0YW5kIHdoeS4gV2UgaGF2ZSB0b25z
IG9mIHVudXNlZCBkZWZpbml0aW9ucw0KPmluIHRoZSBkcml2ZXJzIHRoYXQgdXN1YWxseSBzdWJz
dGl0dXRlIChvbiB3aGF0ZXZlciByZWFzb25zKSB0aGUgYWN0dWFsDQo+ZG9jdW1lbnRhdGlvbi4g
SXQncyBoYXJkIHRvIGNhdGNoIGZvciB0aGUgZGVmaW5pdGlvbnMgbGlrZSB0aGlzIHdpdGhvdXQg
cmVhZGluZw0KPnRoZSBjb2RlLg0KPg0KPi4uLg0KPg0KPj4gPj4gSXQncyBwcm9iYWJseSBzYWZl
ciB0byBrZWVwIHRoZSBkZWxheSBldmVuIGluIGNhc2Ugb2YgZmFpbHVyZSB0byBtYWtlIHN1cmUN
Cj4+ID4+IHRoZSBkZXZpY2UgaXMgcmVhZHkgYmVmb3JlIG5leHQgb3BlcmF0aW9uLg0KPj4gPg0K
Pj4gPkkgYW0gbm90IHN1cmUgYWJvdXQgaXQuIFdoeT8gVGhpcyBoYXMgdG8gYmUgd2VsbCBqdXN0
aWZpZWQgYXMgaXQncyBxdWl0ZQ0KPj4gPnVudXN1YWwgcGF0dGVybi4NCj4NCj4+IE9rIEkgdW5k
ZXJzdGFuZCwgdGhlIGhhcmR3YXJlIG5lZWRzIHRoYXQgZGVsYXkgaWYgdGhlIGFjY2VzcyB3YXMg
YWN0dWFsbHkNCj4+IGRvbmUgb24gdGhlIGJ1cyAodG8gbm90IGplb3BhcmRpemUgbmV4dCBhY2Nl
c3MpLiAgSWYgYSByZWdtYXAgZXJyb3IgbWVhbnMNCj4+IHRoYXQgbm8gcmVhbCBhY2Nlc3Mgb2Nj
dXJlZCB0aGVuIHRoZSBkZWxheSBpcyBhdm9pZGFibGUuDQo+DQo+UGVyaGFwcyB5b3UgbmVlZCB0
byBoYXZlIHRoaXMgZGVsYXkgZW1iZWRkZWQgaW4gdGhlIElPIGFjY2Vzc29ycz8gQWxzbyBkbw0K
PnJlYWQgX2FuZF8gd3JpdGUgbmVlZCB0aGlzIG9yIG9ubHkgb25lIG9mIHRoZW0/DQpJdCdzIHJl
cXVpcmVkIGZvciBib3RoIGluZGlyZWN0IHJlYWQgYW5kIHdyaXRlIEJVVCBub3Qgd2hlbiB3cml0
aW5nIHRoZSBmaXJzdCBkYXRhIA0Kd2hpY2ggbmVlZCB0byBiZSBkb25lIGluIGEgc2luZ2xlIGJ1
cnN0Lg0KQ291bGQgeW91IHBsZWFzZSBiZSBtb3JlIHNwZWNpZmljIG9uIGhvdyB0byBhZGQgZGVs
YXlzIHRvIElPIGFjY2Vzc29ycz8NCj4NCj4tLSANCj5XaXRoIEJlc3QgUmVnYXJkcywNCj5BbmR5
IFNoZXZjaGVua28NCj4NCj4NCj4NCg==

