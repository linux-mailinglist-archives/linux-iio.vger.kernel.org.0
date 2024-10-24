Return-Path: <linux-iio+bounces-11118-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69079AE675
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 15:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17866B286F1
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 13:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBBE1FF048;
	Thu, 24 Oct 2024 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0TPgJpI5"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39E21FF03A;
	Thu, 24 Oct 2024 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776335; cv=fail; b=CLdK1IsSWv/J3zkyG3lMcTNcoE1okPnIEr034OMhatRBSXdHnJHWWK8KhllTsQ6xHpQdan41+GzMnMZF7dI3V+OH9jtEp5j5i8CXezluWd+ZjBUz00QVBVYLU0SaYx/zRMDWgsCJ6IjCXfrpMThEV/iAvOemOEdC/rgtW35eyaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776335; c=relaxed/simple;
	bh=ffC6HSR8aKubmBXWfHlB2/AiDorJ0PlD4q6DWeOXN7k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a/RBcqGfbcxWXBWm03SHwdnSFRWHqjUQKXP+Dy/Z/t2RrPJd7QqxJiqN5t3IOnUrTZHQ6lZ6DBCR7xiJxyLovP2R4Ay6OKQoTOLEO1GO5A5OyKT+THnW3hi6aIO7XXyLa6OEdSsdvls+BpYjWQyGGgebtsigCb1p1fMybDaWJ9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0TPgJpI5; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VK7KwPeLsWExtp7MpJ5jm+/rccR9ZOplx+eI2KRa2hMgHr8fzuqqRF+cqy9TMFWlSCAyto6j9TYmDqZNANqZyC5nuyTD8nNLbgYOChkN7i41mMfj5daHUHrZlqJK4JLlLHxdVn5IWSFXoQQgDJLbCcRLP+yVs8aRHeIs+BWHjUMTEbjl8gIpOSkJvNMnoywTM22E4iR39ElMkdIo/W/agSQs+29vm5YAoNKcmNzwo2R0YVf+pzlgu1WX3ljl9ZfdzV2d843ICHEJnxWPn7gcGrC64+ZTYsVyN+j7Sun2JG3TeVwjOuamPvueSDxxs3iDzyjQ8uOCZAo3tKe4phf7rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffC6HSR8aKubmBXWfHlB2/AiDorJ0PlD4q6DWeOXN7k=;
 b=s1PHBgCapGysr98TbXlrev3EHZ32C1nRWtMP9kT4QaryUnfDgz4SLsoKIiRkHl3Pc9YdUYzB7IwL+71K/dVJrzS93eVUlt7ca1AecB6rkALPFN8cHhWEnIGdEqnoL/lJw156oO/zsC+jmeyJvsOsuQ2oZgLiIrrAVhaUGAA2GHxuaaDEsnklTUo5KORKVvRYy9SsEk3MFKdXZWKqUh0ldiZC5q91B7qhMcU5qGH0HGfwuZ7it/sIAvDeYUdVEc94ao9ATejvG9U/53HTGz39cvWX8qmgCCvdIz2TltyQZ0zgVNe7rM+pbeQoknbNG84KrfzW0CK1cSpBTm6bDbjK5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffC6HSR8aKubmBXWfHlB2/AiDorJ0PlD4q6DWeOXN7k=;
 b=0TPgJpI53J4jHYCfvFqxEKFTumWoQuHmVv+FwkevDz0dLJH+ScHKy946FNV/HWJ/4cbg3SZbnD4EiYXi0tftjiFtgTX/o1X3HqKWKflKa3CXGfGaQ19pFe/KYWRWlWSaO7VBQLEIB8U/O+mPvCpTWszT0qjfi8Du6xnoCUO/4LptzGg+H6M/C3FQrbQr1abUml8l2JlkwpOkbwWwzQJBMKfXJOiUfmyEN38P5tF2WTMPGb29VU29EDxpXomfVVhgt9p3kAzX8tw/XVuBIj7/EBsMUSGl1pyx4i/wAE93omS9I8i0V/Z0AVP90x/RYwapCsM9fDAZUToDu5y0xm4QdQ==
Received: from SN6PR11MB3167.namprd11.prod.outlook.com (2603:10b6:805:c6::10)
 by IA1PR11MB8804.namprd11.prod.outlook.com (2603:10b6:208:597::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Thu, 24 Oct
 2024 13:25:28 +0000
Received: from SN6PR11MB3167.namprd11.prod.outlook.com
 ([fe80::4863:3d2c:e708:fccf]) by SN6PR11MB3167.namprd11.prod.outlook.com
 ([fe80::4863:3d2c:e708:fccf%4]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 13:25:28 +0000
From: <Marius.Cristea@microchip.com>
To: <hdegoede@redhat.com>, <andriy.shevchenko@linux.intel.com>,
	<Jonathan.Cameron@huawei.com>, <tgamblin@baylibre.com>,
	<jean-baptiste.maneyrol@tdk.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>
Subject: Re: [PATCH v2 02/13] iio: adc: pac1934: Replace strange way of
 checking type of enumeration
Thread-Topic: [PATCH v2 02/13] iio: adc: pac1934: Replace strange way of
 checking type of enumeration
Thread-Index: AQHbJhVGs3ye4BwQ8kOceS6i3U03bbKV5DQA
Date: Thu, 24 Oct 2024 13:25:28 +0000
Message-ID: <2fa19c12e335ce00414a971d16867322c9bdad7b.camel@microchip.com>
References: <20241024130424.3818291-1-andriy.shevchenko@linux.intel.com>
	 <20241024130424.3818291-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241024130424.3818291-3-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR11MB3167:EE_|IA1PR11MB8804:EE_
x-ms-office365-filtering-correlation-id: 94b650a4-2f54-4ac1-065c-08dcf42f538c
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3167.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dkNVd3lqM2hVVzkrdWcxVDhqMWF6MGVKaXlZN0gvbGptaU53QnRBTndyQ1VL?=
 =?utf-8?B?YzVTQ09oWHVOUHg2T1plZ2Z0Qy9lNHBid09MUFZTNXF4aSt2RTkxS1hkTW9C?=
 =?utf-8?B?N2pLdnhIVTZJM3ExUXgvMkFMOEZGcnlPTEMrUklLNHB3SHVrKzBBWlI2cFZL?=
 =?utf-8?B?dUJsQmVyZFBucnNIUWlSTXJ4VE56VFg3QVVkajR6OE5wWVFpNTVtUWFEQXY0?=
 =?utf-8?B?UXFPbmlleVB5c1ptZVRZVXNZd1daWFFEWWkwQzJUNGJyS05TQm5kRWRUaG5h?=
 =?utf-8?B?NW8zRXVYdk5ZUGJDUUE3eXRXdk03ekk3Y1hHWDNxZkp5enZsVk5iNkRpWFpu?=
 =?utf-8?B?YnBpM0Z3VXJ6Rld0Z2Q2R3pXTXFzUXR2SXlBRi9tTzl2K2M5d05uQkxKU3Rt?=
 =?utf-8?B?K3ZVSGNCY2tWUlVGVTVTRjJscjNZS0l3emwyNDRSdlllNHh2NXRHdTQzaDRX?=
 =?utf-8?B?Z0JFVXplZjB3RlN1WHZxcTFUYWtTSElvakVCaU45RmNrMnlnU1Y0UGhDYkMz?=
 =?utf-8?B?aUtqTDN0VjBSUldtZ1hmNWlJbW9FbFJlK25wejNjOWdNQmVJRk9reU1FWG5w?=
 =?utf-8?B?RTlPZGEzLzNyUlhsY0RjZ1Z3a0hvOHZVSWFDK2QrbHZZWDhJemlsTUtWS1pn?=
 =?utf-8?B?bERYUFFOMm5CRERRVVBLVzdMS2FvY2JWTldVWWsrelR6UWxWcUZFRlVLR2hT?=
 =?utf-8?B?c0tjYTBpVVEyWG80YjlaR2FsNEl3SFFNS1RpL1puOWpYTExuSHZncnlVTjdT?=
 =?utf-8?B?YnQrcW41RTN3ek5kS1BKaW9heUpkTVFEMEtUaFNLSkZDZ2s4blNKV0g1aFNo?=
 =?utf-8?B?bzFLRXMwTlFRcGtleklkNHU1a3ZvRTFmZFlYSStlTk1leVZnaTZuWU8wK3M0?=
 =?utf-8?B?ZDJVT2xWT0lOQ2ovOTNva1czMUR3b3JhUjlra0lScExmNkZQczRRaTRSU3lY?=
 =?utf-8?B?K3U1MzdtcmhDZGpodzlQKzRIREpVblZpdlB3VWRWMGhHYVdEbmRoaGtFNlYr?=
 =?utf-8?B?emtkRlZEc0JEYmJlaTN6R21PU25mUXppeUlPank0Y204OEZsREJMUkw2b21D?=
 =?utf-8?B?OUFpK2QvRnk5N2ZaZU1FcE0rVG1WQTFMQ1ljdHdSeVFuc1lvK1RuaGJBVnF6?=
 =?utf-8?B?OE8xbnByUjM2ZUpsdDd1elEzTlZkZUFzS0dPNDQ2WnAwY3NDVTRpaTQ5Wm9j?=
 =?utf-8?B?WEsveGJYbXQ4Q01kVWRFYlVNOFdmM1Q4U1Q0bVgxbzVJVVdncTVEOTZPVFVY?=
 =?utf-8?B?Z3RLM09PcnVpMnRNQkxUNFA0bEczeTBrSUFvYXcrKzJtMnBNcHo3dm1kTFBi?=
 =?utf-8?B?aFAwVm1KZmpWTHJzazhEU2xVSXU0azRXUllMczhBRjNCMXRwUWZpUHZ4N0ZC?=
 =?utf-8?B?MWxRdFllazJXZWJ0dTVOY3h2SmlseStCNFFnM3djc3pXbzkwZkluTDVBZ0pU?=
 =?utf-8?B?UStsR3gvN040a3RQMkFhZWpmcnVHbEQwMjF2aVdKWC9qblpmdGk1YzBDM1BM?=
 =?utf-8?B?SDRDTUZLN2VtWm1nVi9ZUkFWYmlwVDAzYS9Vd1ZJZ3lVQm5Jb1c5WHZuMEJj?=
 =?utf-8?B?WjNaMWN1dEk3UXh6TnljRjJmM0hSck5HYkhPYW9mcG5vZVZ4U3d1d0R6bzVx?=
 =?utf-8?B?cVVnaTVQRkQ1bmdwQXd2MUJyVDNjdTM3dkhOeW1mREFKUGkvOUtnWDEyUDdl?=
 =?utf-8?B?R1BlYWJ0b1hIZTdMOVB0SEw1U00vRjVDbjRMd3ViOTNIU29GYkNVZzVoeUJo?=
 =?utf-8?B?WGpwcEcrMmFYMW5SRHo4emtvcCtpRVZ0dXdnL2o4Q3NVOUoxS2JROXVKZXV6?=
 =?utf-8?Q?i5ZXJZywNosAUP7ub09JbH4n4Jw+33Ne2P7tg=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eHNLSlhMYkdXWjRMZVN1SGxFU1BGcXpLME0rcWxhSlUyNGx3cUkzc2FXNEF2?=
 =?utf-8?B?dk9ZVHBwV0lQMUI5bklyNERBNFhNY0ZBbTZzdXFPN09FdFBSZS9RNHl3Yno1?=
 =?utf-8?B?KzlCSWphSURpRkN1UTk1ak42c2p1UWRMekVBelNFT1VOMGFYd3pNMlpBZzQz?=
 =?utf-8?B?VkJkcW9JS0M1eXo4ekV2bExYb2ZneW91RDVrN0U0eVRFNmZ1dVkyZ3ZDK0Rq?=
 =?utf-8?B?UC9DZjVEV09SOFVGM1EwaEZlMHNYQWtHVzR0bFEzRmZ0K0x0Yy9rcjZtS0Zw?=
 =?utf-8?B?akdlaEhsbzUwYXdySkpkWmFIWTh0dDFWK3lJNDJhOFh1YTM4YVVzYWVJWVRV?=
 =?utf-8?B?TXpXc3hDSmlGMVVEcEhQb0NCRGo4QkJGN0xwZlVDU1gwQkNxdi9CbFdvMUJu?=
 =?utf-8?B?SjM1QTc4cEFSRlg2Z2hWUjIrdFlxSHA4UHlldnhlRkYyZXdPZlcwWmlBNGFt?=
 =?utf-8?B?QVozZWI3ZllMOW0vQXowRUNaOE9NWGtXSkhHamJvdE9UcDViN21lK2dHRTRv?=
 =?utf-8?B?MXBiaEN1c2VrSE01bUJHVEREc3Q4TDdackE1UUtWV2FGcTd2L2Q4VGNKdC81?=
 =?utf-8?B?UmlBWm1iMTQ5WC9tS1pFRkFBRUdFS0h1YnFtVmRmcnJnWlJmMThuSGRvOTJr?=
 =?utf-8?B?dmovRWsyR3c4Q2dxZDBzQVI2RmJpRWd2QzlJSzRCVXcyNEtzOXRUT1F2Z245?=
 =?utf-8?B?a1VsZDVvaGFMQitBZ1NzVW5kWDZBWHlwNEY2UVFBNUsxSWExdG0ra1lHTHRy?=
 =?utf-8?B?NW11VTIvY3ZpY2Q1V1JrM2UwWkdUcEtZZHRBV1BRN2RsWEhHMEdkWnh2RkRW?=
 =?utf-8?B?RUo2QSsyMkZiZXRGNjRyQjV5OXVwd0M0OVZ4T2pWc1pDQUhNVG51T3RGVUdC?=
 =?utf-8?B?dHIvY29zb0xpdXlTM2NZS1U1L2dLWU5VdmJudlhLR0Z6M05JM2c3MHdGaHYz?=
 =?utf-8?B?dytkbEdTTTdJK1lUdDlLSk5QYUoxajZUUjM4d1ZMMTlyeEwwMVZwbHlyVTJX?=
 =?utf-8?B?YjBETDlDTk5tYXo5VVUzWHVaT0kvZ0VZbUNocGw5RWFZUjVLUmZ5aXc4NVNs?=
 =?utf-8?B?U1Q3N1V1S1pWMThEQThkWXh5RnA1UE9xSUNhTzVyKzFZZ3hTNnI0bDFBcEZk?=
 =?utf-8?B?dkt6d2FwZ3BYWEF5ejhUS28vc05sL3JuQ3huRVR2ZzBVeHBUQkN0UnRVM09u?=
 =?utf-8?B?YVVROEhscks3L2FJbmhuVjhVOUJ6UjhBaXRzVHUwZjdNb0hQK3ZSeFpGVHdn?=
 =?utf-8?B?dFFIN1FIWmlYd0s4YTBuTGxVQVdQdERwbHZxSTA2WUo0Tml1RFRnMm9LNThu?=
 =?utf-8?B?ZWdydmd6RVRSeGIvS2UvUkNCVnRlbEU4RjZSY1IxUThNNzdXbGdBS1E1QVhN?=
 =?utf-8?B?TVgvNjhaRDBCUjBZSjVmbTIrRGp2VEJlRm5nVzVzQjllcHV5VkVGaDR1QXB5?=
 =?utf-8?B?N25IaENNS0tUazVwczBta0ZtWERDTndxc1NCdmZRN1RYeGp4Z2NmMW5kcThi?=
 =?utf-8?B?ZitPaWRDMktERU9nOXFtQ0d2eGk5Y1lFK253cnF3K256ZDlSK2VVQzl2NGJi?=
 =?utf-8?B?V1JwMXU0cmhUUzJSMFNaT0czOEg4OXRTVmJhaC9adTZSWXVtT0dXNzZUZlVo?=
 =?utf-8?B?Zm1pNm9xbk1TNHJONHhkTzNEWDk2bHJGMmJ6TE8vckJMSDZDRVByd2pLbHoy?=
 =?utf-8?B?Q1pqcVd6MjFteFZFUmVieWJtT0U1OUpYK1RkdDRLNi9pUlQ3d2FXVnFSa2hp?=
 =?utf-8?B?SllYZ1FVWU81d0hXTzVYUHdkOTdPZDFZcHZnNkpHOFdHNmFHdnJyMjFPdVVj?=
 =?utf-8?B?SkFGbFNKV2k1Qk5jNG8vMU1xOXJEejJXNzVSclNUbXdsYXVYdDJPN1pieWE3?=
 =?utf-8?B?K05ndmVSNVNRZGZDZVRtcE4zNFY4ZVdMWkdqN0RyNlFqaFNHOGVNc3NSRFRp?=
 =?utf-8?B?N0FpSTdUWi81V1N2K2NDbHBlMGxOSjRueDFxaFZXSnBSNzFnMVRmaDFqV1l5?=
 =?utf-8?B?dzlsbE0xYW1hengrNVl1Q1ZRdi9vdFd3SldOTkFaVDBIeThza1FiN2J6TVpC?=
 =?utf-8?B?SUZoSVVXd0xxeUNRa2NhVjZmK1NsbHpOaHdtb242NWt3T1JYNjVZenpBcEEr?=
 =?utf-8?B?ZDNqb3RMd3RNeFczRHFsUHlIc09HdkxSdTdhTlNIYzhkQTRIN2JhZGVjdy9Z?=
 =?utf-8?B?Y1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8F94A6F81CC11459D4B92E79466DB49@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3167.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b650a4-2f54-4ac1-065c-08dcf42f538c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 13:25:28.1901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6XSFKIJsNEiCdejb0pPiOfzjVUJDJNXFGDBnbgLfQAdhdNfRX/cAKk5ChPIhpcvIwMkRkwy4t2eCxO8O8K7nazHC0OXLQWdPKYKQsVLmS2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8804

SGkgQW5keSwNCg0KICBUaGFuayB5b3UgZm9yIHRoZSBwYXRjaC4gSXQgbG9va3MgT0sgZm9yIG1l
Lg0KDQpSZXZpZXdlZC1ieTogTWFyaXVzIENyaXN0ZWEgPG1hcml1cy5jcmlzdGVhQG1pY3JvY2hp
cC5jb20+DQoNClJlZ2FyZHMsDQpNYXJpdXMNCg0KDQpPbiBUaHUsIDIwMjQtMTAtMjQgYXQgMTU6
MzYgKzAzMDAsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5v
dCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlDQo+IA0KPiBXaGVuIGRldmljZSBpcyBlbnVtZXJhdGVkIHZpYSBBQ1BJ
IHRoZSByZXNwZWN0aXZlIGRldmljZSBub2RlIGlzIG9mDQo+IEFDUEkgZGV2aWNlIHR5cGUuIFVz
ZSB0aGF0IHRvIGNoZWNrIGZvciBBQ1BJIGVudW1lcmF0aW9uLCByYXRoZXIgdGhhbg0KPiBjYWxs
aW5nIGZvciBmdWxsIG1hdGNoIHdoaWNoIGlzIE8obikgdnMuIE8oMSkgZm9yIHRoZSByZWd1bGFy
IGNoZWNrLg0KPiANCj4gUmV2aWV3ZWQtYnk6IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhh
dC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVu
a29AbGludXguaW50ZWwuY29tPg0KPiAtLS0NCj4gwqBkcml2ZXJzL2lpby9hZGMvcGFjMTkzNC5j
IHwgMiArLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9wYWMxOTM0LmMgYi9kcml2ZXJz
L2lpby9hZGMvcGFjMTkzNC5jDQo+IGluZGV4IDdlZjI0OWQ4MzI4Ni4uMjA4MDJiN2Y0OWVhIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvcGFjMTkzNC5jDQo+ICsrKyBiL2RyaXZlcnMv
aWlvL2FkYy9wYWMxOTM0LmMNCj4gQEAgLTE1MDcsNyArMTUwNyw3IEBAIHN0YXRpYyBpbnQgcGFj
MTkzNF9wcm9iZShzdHJ1Y3QgaTJjX2NsaWVudA0KPiAqY2xpZW50KQ0KPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaW5kaW9fZGV2LT5uYW1lID0gcGFjMTkzNF9jaGlwX2NvbmZpZ1ty
ZXRdLm5hbWU7DQo+IMKgwqDCoMKgwqDCoMKgIH0NCj4gDQo+IC3CoMKgwqDCoMKgwqAgaWYgKGFj
cGlfbWF0Y2hfZGV2aWNlKGRldi0+ZHJpdmVyLT5hY3BpX21hdGNoX3RhYmxlLCBkZXYpKQ0KPiAr
wqDCoMKgwqDCoMKgIGlmIChpc19hY3BpX2RldmljZV9ub2RlKGRldl9md25vZGUoZGV2KSkpDQo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBwYWMxOTM0X2FjcGlfcGFyc2Vf
Y2hhbm5lbF9jb25maWcoY2xpZW50LA0KPiBpbmZvKTsNCj4gwqDCoMKgwqDCoMKgwqAgZWxzZQ0K
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyoNCj4gLS0NCj4gMi40My4wLnJjMS4x
MzM2LmczNmI1MjU1YTAzYWMNCj4gDQoNCg==

