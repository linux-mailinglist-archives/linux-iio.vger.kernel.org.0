Return-Path: <linux-iio+bounces-19663-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50811ABBB6B
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 12:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A8B1797E7
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 10:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C6B20C038;
	Mon, 19 May 2025 10:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KUezX4lV"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34C71F5425;
	Mon, 19 May 2025 10:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747651676; cv=fail; b=cNGpzby0XdXWKEvOLGe7+3wpgq9QXCAohCSWAgTHXZQT0gQpw6igWlx11r9nXhaXOvQy1nhEzDch+NDw/ScYQkBqrc+I7+IXJhZfzRpFBtRmAowC9Q+iYdpd5q/UEJknzW2CEH2e4BXrXfecQSKDr20yqKQ142r2sNVaeyxukB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747651676; c=relaxed/simple;
	bh=p7kCFPqCsBbTCaWukY4VdnI7K8qg2OfHodFQbKlnRow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KFpgV9l+oMkHDzWH2Zjnayc+v9iWXNfZyLi2HEqcLKGT2lMBtuadpbgJudiaA25HYkmmegeZhj3+Y97/oOh3kSCckIZmyZxde9WTKy5KlBOD9Mf3y6pi50ae/NPezkGsM72BX6aP0OHE9F4LEH2EXQt/tT717uJi70hPrsILhJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KUezX4lV; arc=fail smtp.client-ip=40.107.243.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQTVKgv2U5F1uTngbGOZxgalbEgp+VfRFRuWlP/kV9mZLfUuauR3P4UznHKqlXU0Dr8TjTgG6KZc9GIuvbkk7HJsegoCGK0fyBw5sEzhacFbJ/Qxkx6J3t2HMhcJWT4aPhzD+cM8fRGeqq/vACLmcUnbjgqZnmr+956OGY3tYhS2HS0kdU0TrvMpHaTt2vRiMvDFb63ClD6tKL60Y7IU3+iapXI+GpNo93R5Y2A9D5L16Yos5rpMmjBzyq49BvDvxXMRVA3c5KTj5y1bP6W+rLfrLnBkX2RXRjeFXd3sUeccjQA4fXPqZ0rlPvQxu48+PZe/BambFPDgucYcYnTdpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7kCFPqCsBbTCaWukY4VdnI7K8qg2OfHodFQbKlnRow=;
 b=V6gp38UpFVVfiVNVy8S03RnYMAPQZ6JKD9K9g07DneYqQWUTmObMsZ2FJGy7YVpHP7l4rWRDW0cfH9+JMjNZeFkzeX407y5lYnofobMZRa0/93oYyYptZuG86feI+pfakzlhdoWToKt9Fp+MfSZYnFIHtzWJtr0kLixYYq/Op3xsJmoWH8rBrZNPe0ApfHdUcFnUi987CVF5VhyARCvBEeIuz9xAT/PtDktZoBeKqkdx0XpXw92IK5EcdQ6ExWYx6fjj5Guml9DuiWEQWdLPiwU44TJnShpLVQxyJUWUo/GEau3Z6R7mTKJhulUhHAbG4mFVOQHdHXPtarKbSX8rgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7kCFPqCsBbTCaWukY4VdnI7K8qg2OfHodFQbKlnRow=;
 b=KUezX4lVJU4kHxInHZEG+TtRsJfFBYpBxcM0nxuQ/lwIURwyVSVHmfhmliOhZVB7Fc++TcGffWiq/8K1qo3D6d3nyr99LAfvcKCshVMmbMqDZMsHx2ojyXJ9O3Lwsrgw4AncKdYPoD4n0CTVaE3K794SlcRFekEntuFFpIK4sh7rpCptX1QLlesb26RUdxhWXbUXPrVE1ZWqqBtev+VvHqZifLwVU9mBgOQWbZcLwbvMduiF942NBQF63cpDRoAYFQLYLVmIqdZIYdBUrjmt6Q80qWmR2bH3eVQsXIGcBl5OKuQH5I6MaB7MaupXeTgoBfYQK1h/Z8o1RbVAfesdNQ==
Received: from BL3PR11MB6436.namprd11.prod.outlook.com (2603:10b6:208:3bc::11)
 by DM4PR11MB5295.namprd11.prod.outlook.com (2603:10b6:5:392::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 10:47:50 +0000
Received: from BL3PR11MB6436.namprd11.prod.outlook.com
 ([fe80::dbcf:4176:b06b:3aaf]) by BL3PR11MB6436.namprd11.prod.outlook.com
 ([fe80::dbcf:4176:b06b:3aaf%7]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 10:47:50 +0000
From: <Dharma.B@microchip.com>
To: <wbg@kernel.org>
CC: <kamel.bouhara@bootlin.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] counter: microchip-tcb-capture: Add watch validation
 support
Thread-Topic: [PATCH] counter: microchip-tcb-capture: Add watch validation
 support
Thread-Index: AQHbxVYHRivDm+CKUUG+7oFIi18WIrPYBeIAgAHGYYA=
Date: Mon, 19 May 2025 10:47:50 +0000
Message-ID: <823cefaf-b225-4531-8733-5d90d3ccceb3@microchip.com>
References:
 <CV37uwi-rAqU3els0ckl4KLz5ortFAdc7XXy7ex6-MMhxvptyeMh8vTBXQuZliairKQ1Dy4yM3MyE8o7EZ6VfA==@protonmail.internalid>
 <20250515-counter-tcb-v1-1-e547061ed80f@microchip.com>
 <aCmPLn16Ykabvhjv@ishi>
In-Reply-To: <aCmPLn16Ykabvhjv@ishi>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6436:EE_|DM4PR11MB5295:EE_
x-ms-office365-filtering-correlation-id: fd0a2a1e-3122-4f9a-408a-08dd96c299ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UHpSTDRZWFpFSi9XVnI0Q3hTL1h4dlZzNmJoQ1JqQlRHNzhXcndOd2JyZ0I1?=
 =?utf-8?B?dFpQMWdRLzRCU1BLOUhna2FaVGFGUFNuMlJsTDVtVzB1QU92QzRzQ2ZvU0Zk?=
 =?utf-8?B?dGVtSFM4enEwN1RLTFppUmpUd2VlVm0rR2dxN1IwTHAvdndSeGtQemtxTnFH?=
 =?utf-8?B?UDFWaDJIajJQaS9Cd2padlRhN0pMOG02RWFjMFdMd3BsdDdScGY3UmZpSENG?=
 =?utf-8?B?MDlNK1FSYnhtcmY4N3BZcjhjaCtWWk02Tk5Hc2kvTkwyc2h4TTNUc0ttTGYv?=
 =?utf-8?B?M1dMaEFHRmNNeDc4Yy9zMktxbjRsT25pSFJ3b0JHYXFtQXlmeW4xbVJBdFBw?=
 =?utf-8?B?Nno5T2VONDYyVE5JVEt0aThSTExteHM4NmZqTjlvcmh2dlk0Vko2Z010S2Q4?=
 =?utf-8?B?SkFoeUR1UGVBQVlTMTloRW5EZUl2R1F0V1VsMGdhQ09BSTlLYTk0QjcydEQ1?=
 =?utf-8?B?anl0Q29KY0dmVGlrVUdxdmIvRzZia2tITHIxMVdGbXdNdmVvR2NCNXEyZDJs?=
 =?utf-8?B?RUlBVXhLTnAySUg5VmpQU3VuMFZrRG9TVkVNR082dktSKzFSWk1QVDMxMkE5?=
 =?utf-8?B?R0hxT0dxeFpwYUNBeUhLajBIcHJQaUNSd25zUW16dGpJbkdCTEN4dEdCU0xU?=
 =?utf-8?B?WDN0Z1dGM0NwL0VONVE0a3lnWUd3UmJkd2JwWHQzT2JuUFZiRFYvdXBYaFdZ?=
 =?utf-8?B?NkIxUE1CSXA1RGgzdlV0eDBPL2RtMUMyM2RiZ3NSY2tuVlJFUldqTnpRenRJ?=
 =?utf-8?B?dTB2TmpvSHl5OG1qNm10cGhWZUdOTFZHRHpXMjE0d1J2VkF4cTVJZjBBbHhn?=
 =?utf-8?B?dHE2aFdicUtpTnpXZWU5MVVEeER1dXpad2JwcDVpNmJsOGhQTi9YVjJGVXcy?=
 =?utf-8?B?aGF6UGMrMkp1SVVTUzdvREpwM0JaNkxKNjJ2Rk1sdklMRjJETzg4bmpvbFBN?=
 =?utf-8?B?cjVGK01Ob1FyWTdTWHdBUXkyOFFKNlh6RTNtaHF3OFdwRisxdmdQWk50d1lh?=
 =?utf-8?B?c2F1bEVYaUZqb0lXbEJmQ2ZXR0QxWDQ1Mk5zZDFJY0Z1Z1RaZFFqcVBPOVF3?=
 =?utf-8?B?YlB5dkdiVVl1Y0pKeU9tOUovNCtxQ0JrcEtZVjBUZzIwVXNBWkdDQS9vK0J1?=
 =?utf-8?B?TmZ6bER1NnJDc29jYWlVYzV2MnhKSWsxUkZ5S2FVODg2Yzc1SEZ6WFVrUFRZ?=
 =?utf-8?B?U0NIbEZBQWpTQ0dlNVdjVFI2SlJ0djlWdGRub3B5UTFObTdwclkrVWM4Z01y?=
 =?utf-8?B?WXZlV255MEpMTGVQaHFjZnJLYVk5ODJuZGFUd0M4VitmVS81WVFZLzVlbi92?=
 =?utf-8?B?R09JWjA4cEpuSVdEcWowZTRVSm96WDNneHByZno2dHZFbWw5MlcvR21Ua2c2?=
 =?utf-8?B?dXJ2ZGlqQ0QvaExRZ00yQ051eGNIZGJDYk1ZUFMvRlp0V3p1TGZUWm5YSUtL?=
 =?utf-8?B?SklYeHZILzBpTmpFM0pld2d0eTBJV2U2cUVwMkx2Mm1KRUgxV1FmZW94enBH?=
 =?utf-8?B?M21pYmVjL1VBM0tNN05qQ2NyV1JJQWc2ODFNWkxDbjlNWjNCZW0xOXhaYUk0?=
 =?utf-8?B?VmdRZGZoMHRaWkdzL29ZQTBFV0ZaWHMzNDhMajVCVm5veExpNldPVlhhRVEy?=
 =?utf-8?B?a0RKWmZCcjNTdUVPdE5pWjlRaEQ0R01zTUdwdU5yOXlsZzRJdHVXWEU2ZmFz?=
 =?utf-8?B?NmR3V2FjaFZnaHluRHZXa1FzcWVrQzA0R0pMSkdUNE0wV3BBRWhkU05MN2Z5?=
 =?utf-8?B?V2lnRzdGYUtRU0RiVDJTWUFkeVNDZ3RhSUp1U3lQYzNMbzJqbTQ5cCtyUTA1?=
 =?utf-8?B?ZEdLSjhTWmJnMnB2TEVnUFpNUGgxUWp6bng1WFhGQVFnZWpyamZFeUZpRXRi?=
 =?utf-8?B?SFlYTHZqdDVZY1ZOV3RDT2FCZTFJNmxpZzFxM09pOUhzcitwdlQvV1dCSXJY?=
 =?utf-8?B?cjRFcE1jWEl1ZS9oWVlzZjVzK3JvVlNVb0NsNWtzTmhIRXEwaCs3WVB3RUlo?=
 =?utf-8?B?d1hFaG92WkNnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6436.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NUN2ckdXZW5SSDNJWkk5ZDFNMUpJUzdoM0ZFYkYySDZ4VzJQZXBQU2V1dGI2?=
 =?utf-8?B?TkJkemhpRHV0ME1BbktzMk1GNUxMTWhKTmhwYkpYU3NIYjQwV3lwVlVZZlIr?=
 =?utf-8?B?VmdtdlZmOTJRcmk3RTZZR2JxYXAxMXBqdDJlZitHYjJhaVZOL0xGRE1BT3kw?=
 =?utf-8?B?ZXhMSE8yWU9FOWQxMnlHcklIOW5HZUxNOFVjUUsrRFkrc09pQ24xKzB4SEFG?=
 =?utf-8?B?enluaUtjbnNUbm9uQnRYekFVa2o5dUZ3Z3BYOGhURlp0VW1IUGlib0pqdkNa?=
 =?utf-8?B?ZlhuRGxDRitxK0xFS2lXc0tuTEU2ZDhNTURqVWtnelVUa1V4Z0lvTkRqek1J?=
 =?utf-8?B?dGUzc25IU0h2aWg1TXMxS1MxaFB5MldDTDVoY3V0ZW9zdUxudWN0SSs5Y0VX?=
 =?utf-8?B?cFY1RGRwUjVreWZyRXR3RnpsM2VtKy9rZDI0SlJpUHFzOE05cTdlZ1pSNVlI?=
 =?utf-8?B?RzVsdmRpSUpGTFUzbWxsbWx1UWZDZjA3cGVRUDFmZjhZQll5cis5V3VRK1hM?=
 =?utf-8?B?REJ2ODNaWnk0VFUvVWxNTmd3MzZSRVhSLzRmMHFQQWxSTUZiN1lzU3dmU3l2?=
 =?utf-8?B?dU03bzhrcDVPNWdJT0t2YklnRXYyT01NR3NsU2l1YjBkOHJBVGhia0t3VHpO?=
 =?utf-8?B?NklpRW5ET0dPMFFZM1RucE9nZ2J0MGtIMHpPdjdzY1d4dGpjSldicGUyMlZj?=
 =?utf-8?B?ZUFlSmVYN1NRcW5KMG9KVUpvSDdNaEVMODlmaFRibVpaS09ReXQ5a2dsdTVX?=
 =?utf-8?B?U3JNREJGMlFWMzZTYlZxYXZKR1A4ZUc5NFRVcWc3dFc4dWlCY2dhRGg2b3Zz?=
 =?utf-8?B?Wnpmbk14THR6cC9Scm0rbVNkcnhKVmVvVWFPZlE2Zm41WVk3djJMWHlhZ21W?=
 =?utf-8?B?MDduaTNlQm1kSFY2U1NuVCtBcjA2dVU3NitxYmJ4V1h4RVhtbnFHNnE2Q3NK?=
 =?utf-8?B?cjhJUnV1TU9YOXB5SUtsVk9ndHRxcTdyQnZVLzdiaWxib0YrK0NCUWl6MHV5?=
 =?utf-8?B?NzJFdURCalU4TWpaU05zVDBJOVcyL1RGSGVWdzRLMVVNQnBFZDU0QS9Hamxx?=
 =?utf-8?B?SmpJa3BrQjJhSFZXejdHWTd5RFQrN0tuRC8rOSs5SlZ2U2piWUJuQXRFaTVK?=
 =?utf-8?B?V2xXVk9jZDNsSElnaGo4MlJUMlNTWnpQbHhqS1dwQ3ZtckNOaGtDMnM3T21t?=
 =?utf-8?B?QkpTblVmcjUwRGFmeUZtSlFUakd0TjFMYSsycFFjQ2Faa2piQkpVbTAvQ1hm?=
 =?utf-8?B?WXNYTWFrcU9MeDdBRllHNnZXd0Q4SzNKZlVyTHR2UVpOYzVjUzVTVnB1R0lL?=
 =?utf-8?B?bGFEa21sVWcvT3pRSFNPTjByZlV1cnUrVmdzbC9CZE05TmQxTm44eXFiVTF1?=
 =?utf-8?B?bVhJa0l4ZkllU2N2VU83ZnYrb2piM0U4ZVRFWWJqZTNua3lKR0l0ZTRXTEox?=
 =?utf-8?B?Vlg0U3FhMGxMZ2ZLY3hXdUNqMmY2ak1VYkJ1Y0RKb2RuRzYvY0VjQkdxTlVV?=
 =?utf-8?B?TTMxaGgraDBLaVlGbnVRUHZaSVBXYTNnRDc4dUdZOGFsaXNTMVJ2c0RRdXUx?=
 =?utf-8?B?RTR6ZE1BZHVxb2ZsNDVQVDBhY1gvaENVSy81NWJ3cjdOZ1d2REloMjBxNmxS?=
 =?utf-8?B?V1hOQXNoRHNxdE0xWVErU3RYZEJESHJ4RHNRTnYzdEViQWhJTXJWenZTb0tp?=
 =?utf-8?B?SG05aXRxWERuVVIzbFFNd0pwRGY4QlBDN3Q2NzJRajJXc0l0cFFwYnloNU9O?=
 =?utf-8?B?MkZNY2Z6SEc0cTg1V2MwNU1DSnJtS2MySkFpT0RnM1dvVU1mcUxFYTBaMkRy?=
 =?utf-8?B?bXZuYmFLUGFWTng0MUFneFBlOG5MOTBGZk12Z04vUHBPVUVjbExlaW9Ob2RE?=
 =?utf-8?B?bHd0bmhwSGZnT1ZtQkxTTlFFTG50OW00T010QVF3ZTBvRi81dEVkV0pCWXF1?=
 =?utf-8?B?YzJkMkNNNmlia2JBNVVRVTJCRU1ibWt0TXdOenhiQW91YWxpL01uajVzNjdY?=
 =?utf-8?B?KzVMRVpjUXdIQTJUcGNsRVJGQ3BVa1pZWDFTeUZGM1dsMlBtY1J1RlVGL0F0?=
 =?utf-8?B?TU9uWjF0YXhHRTRQWGNDSUFVaGZxblFkWWpCSmt2NUNXZlBKL1JueENZdlNG?=
 =?utf-8?Q?LEvXK3BjNh8AYLj2Bw3dP4Ko3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B5BB3711A0A7C4582E1C4120214D84B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6436.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0a2a1e-3122-4f9a-408a-08dd96c299ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 10:47:50.6456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V7v/+PfBY0xw5OSrF9Kr3ZdVNqBWAHtYod5DrD5GrLfnXpkanTEmGVdDDUcO4B3gVwj7DmtGrkOc442HTKhTpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5295

T24gMTgvMDUvMjUgMToxMSBwbSwgV2lsbGlhbSBCcmVhdGhpdHQgR3JheSB3cm90ZToNCj4gT24g
VGh1LCBNYXkgMTUsIDIwMjUgYXQgMTA6Mjg6MjVBTSArMDUzMCwgRGhhcm1hIEJhbGFzdWJpcmFt
YW5pIHdyb3RlOg0KPj4gSW50cm9kdWNlIGEgd2F0Y2ggdmFsaWRhdGlvbiBjYWxsYmFjayB0byBy
ZXN0cmljdCBzdXBwb3J0ZWQgZXZlbnQgYW5kDQo+PiBjaGFubmVsIGNvbWJpbmF0aW9ucy4gVGhp
cyBhbGxvd3MgdXNlcnNwYWNlIHRvIHJlY2VpdmUgbm90aWZpY2F0aW9ucyBvbmx5DQo+PiBmb3Ig
dmFsaWQgZXZlbnQgdHlwZXMgYW5kIHNvdXJjZXMuIFNwZWNpZmljYWxseSwgZW5hYmxlIHRoZSBm
b2xsb3dpbmcNCj4+IHN1cHBvcnRlZCBldmVudHMgb24gY2hhbm5lbHMgUkEsIFJCLCBhbmQgUkM6
DQo+Pg0KPj4gICAgLSBDT1VOVEVSX0VWRU5UX0NBUFRVUkUNCj4+ICAgIC0gQ09VTlRFUl9FVkVO
VF9DSEFOR0VfT0ZfU1RBVEUNCj4+ICAgIC0gQ09VTlRFUl9FVkVOVF9PVkVSRkxPVw0KPj4gICAg
LSBDT1VOVEVSX0VWRU5UX1RIUkVTSE9MRA0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IERoYXJtYSBC
YWxhc3ViaXJhbWFuaSA8ZGhhcm1hLmJAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2
ZXJzL2NvdW50ZXIvbWljcm9jaGlwLXRjYi1jYXB0dXJlLmMgfCAyOCArKysrKysrKysrKysrKysr
KysrKysrKysrLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NvdW50ZXIvbWljcm9jaGlw
LXRjYi1jYXB0dXJlLmMgYi9kcml2ZXJzL2NvdW50ZXIvbWljcm9jaGlwLXRjYi1jYXB0dXJlLmMN
Cj4+IGluZGV4IDFkZTNjNTBiOTgwNC4uMTc5ZmY1NTk1MTQzIDEwMDY0NA0KPj4gLS0tIGEvZHJp
dmVycy9jb3VudGVyL21pY3JvY2hpcC10Y2ItY2FwdHVyZS5jDQo+PiArKysgYi9kcml2ZXJzL2Nv
dW50ZXIvbWljcm9jaGlwLXRjYi1jYXB0dXJlLmMNCj4+IEBAIC0zMzcsNiArMzM3LDI3IEBAIHN0
YXRpYyBzdHJ1Y3QgY291bnRlcl9jb21wIG1jaHBfdGNfY291bnRfZXh0W10gPSB7DQo+PiAgIAlD
T1VOVEVSX0NPTVBfQ09NUEFSRShtY2hwX3RjX2NvdW50X2NvbXBhcmVfcmVhZCwgbWNocF90Y19j
b3VudF9jb21wYXJlX3dyaXRlKSwNCj4+ICAgfTsNCj4+DQo+PiArc3RhdGljIGludCBtY2hwX3Rj
X3dhdGNoX3ZhbGlkYXRlKHN0cnVjdCBjb3VudGVyX2RldmljZSAqY291bnRlciwNCj4+ICsJCQkJ
ICBjb25zdCBzdHJ1Y3QgY291bnRlcl93YXRjaCAqd2F0Y2gpDQo+PiArew0KPj4gKwlzd2l0Y2gg
KHdhdGNoLT5jaGFubmVsKSB7DQo+PiArCWNhc2UgQ09VTlRFUl9NQ0hQX0VWQ0hOX1JBOg0KPj4g
KwljYXNlIENPVU5URVJfTUNIUF9FVkNITl9SQjoNCj4+ICsJY2FzZSBDT1VOVEVSX01DSFBfRVZD
SE5fUkM6DQo+IA0KSGkgV2lsbGlhbSwNCg0KPiBIZWxsbyBEaGFybWEsDQo+IA0KPiBJbmNsdWRl
IENPVU5URVJfTUNIUF9FVkNITl9DViBhcyB3ZWxsIGZvciB0aGUgc2FrZSBvZiBjb21wbGV0ZW5l
c3MuIEkNCj4ga25vdyBDT1VOVEVSX01DSFBfRVZDSE5fQ1YgYW5kIENPVU5URVJfTUNIUF9FVkNI
Tl9SQSBoYXZlIHRoZSBzYW1lDQo+IHVuZGVybHlpbmcgY2hhbm5lbCBpZCwgYnV0IHdlJ3JlIGFi
c3RyYWN0aW5nIHRoaXMgZmFjdCBzbyBpdCdzIGdvb2QgdG8NCj4gbWFpbnRhaW4gdGhlIGNvbnNp
c3RlbmN5IG9mIHRoZSBhYnN0cmFjdGlvbiBhY3Jvc3MgYWxsIGNhbGxiYWNrcy4NCg0KVG8gYXZv
aWQgdGhlIGNvbXBpbGVyIGVycm9yIGR1ZSB0byBDT1VOVEVSX01DSFBfRVZDSE5fQ1YgYW5kIA0K
Q09VTlRFUl9NQ0hQX0VWQ0hOX1JBIHNoYXJpbmcgdGhlIHNhbWUgdW5kZXJseWluZyB2YWx1ZSwg
d291bGQgaXQgYmUgDQpzdWZmaWNpZW50IHRvIGluY2x1ZGUgYSBjb21tZW50IGluZGljYXRpbmcg
dGhhdCBib3RoIHJlcHJlc2VudCB0aGUgc2FtZSANCmNoYW5uZWwgSUQ/IE9yIHdvdWxkIHlvdSBw
cmVmZXIgdGhhdCBJIGR1cGxpY2F0ZSB0aGUgbG9naWMgZXhwbGljaXRseSANCmZvciB0aGUgc2Fr
ZSBvZiBhYnN0cmFjdGlvbiBjb25zaXN0ZW5jeSwgZGVzcGl0ZSB0aGUgc2hhcmVkIHZhbHVlPw0K
DQo+IA0KPj4gKwkJc3dpdGNoICh3YXRjaC0+ZXZlbnQpIHsNCj4+ICsJCWNhc2UgQ09VTlRFUl9F
VkVOVF9DQVBUVVJFOg0KPj4gKwkJY2FzZSBDT1VOVEVSX0VWRU5UX0NIQU5HRV9PRl9TVEFURToN
Cj4+ICsJCWNhc2UgQ09VTlRFUl9FVkVOVF9PVkVSRkxPVzoNCj4+ICsJCWNhc2UgQ09VTlRFUl9F
VkVOVF9USFJFU0hPTEQ6DQo+PiArCQkJcmV0dXJuIDA7DQo+IA0KPiBUaGUgd2F0Y2hfdmFsaWRh
dGUgY2FsbGJhY2sgaXMgdXNlZCB0byBlbnN1cmUgdGhhdCB0aGUgcmVxdWVzdGVkIHdhdGNoDQo+
IGNvbmZpZ3VyYXRpb24gaXMgdmFsaWQ6IGkuZS4gdGhlIHdhdGNoIGV2ZW50IGlzIGFwcHJvcHJp
YXRlIGZvciB0aGUNCj4gd2F0Y2ggY2hhbm5lbC4NCj4gDQo+IExvb2tpbmcgYXQgaW5jbHVkZS91
YXBpL2xpbnV4L2NvdW50ZXIvbWljcm9jaGlwLXRjYi1jYXB0dXJlLmg6DQo+IA0KPiAgICAgICAq
IENoYW5uZWwgMDoNCj4gICAgICAgKiAtIENWIHJlZ2lzdGVyIGNoYW5nZWQNCj4gICAgICAgKiAt
IENWIG92ZXJmbG93ZWQNCj4gICAgICAgKiAtIFJBIGNhcHR1cmVkDQo+ICAgICAgICogQ2hhbm5l
bCAxOg0KPiAgICAgICAqIC0gUkIgY2FwdHVyZWQNCj4gICAgICAgKiBDaGFubmVsIDI6DQo+ICAg
ICAgICogLSBSQyBjb21wYXJlIHRyaWdnZXJlZA0KPiANCj4gSWYgSSdtIHVuZGVyc3RhbmRpbmcg
Y29ycmVjdGx5LCBjaGFubmVsIDAgc3VwcG9ydHMgb25seSB0aGUNCj4gQ0hBTkdFX09GX1NUQVRF
LCBPVkVSRkxPVywgYW5kIENBUFRVUkUgZXZlbnRzOyBjaGFubmVsIDEgc3VwcG9ydHMgb25seQ0K
PiBDQVBUVVJFIGV2ZW50czsgYW5kIGNoYW5uZWwgMiBzdXBwb3J0cyBvbmx5IFRIUkVTSE9MRCBl
dmVudHMuDQoNClNob3VsZG4ndCBpdCBiZQ0KDQovKg0KICAqIENoYW5uZWwgMCAoRVZDSE5fQ1Yp
Og0KICAqICAgLSBDViByZWdpc3RlciBjaGFuZ2VkICAgICAgICAgICAgIOKGkiBDT1VOVEVSX0VW
RU5UX0NIQU5HRV9PRl9TVEFURQ0KICAqICAgLSBDViBvdmVyZmxvd2VkICAgICAgICAgICAgICAg
ICAgIOKGkiBDT1VOVEVSX0VWRU5UX09WRVJGTE9XDQogICoNCiAgKiBDaGFubmVsIDEgKEVWQ0hO
X1JBKToNCiAgKiAgIC0gUkEgY2FwdHVyZWQgICAgICAgICAgICAgICAgICAgICDihpIgQ09VTlRF
Ul9FVkVOVF9DQVBUVVJFDQogICoNCiAgKiBDaGFubmVsIDIgKEVWQ0hOX1JCKToNCiAgKiAgIC0g
UkIgY2FwdHVyZWQgICAgICAgICAgICAgICAgICAgICDihpIgQ09VTlRFUl9FVkVOVF9DQVBUVVJF
DQogICoNCiAgKiBDaGFubmVsIDMgKEVWQ0hOX1JDKToNCiAgKiAgIC0gUkMgY29tcGFyZSB0aHJl
c2hvbGQgcmVhY2hlZCAgICDihpIgQ09VTlRFUl9FVkVOVF9USFJFU0hPTEQNCiAgKi8NCg0KQ291
bGQgeW91IHBsZWFzZSBoZWxwIG1lIHVuZGVyc3RhbmQgd2hldGhlciB0aGVzZSBhcmUgbG9naWNh
bCBjaGFubmVscyANCm9yIGhhcmR3YXJlIGNoYW5uZWxzIHJlbGF0ZWQgdG8gdGhlIHJlZz8NCg0K
PiANCj4gQWRqdXN0IHRoZSBjb2RlIHRvIGVuc3VyZSB0aG9zZSBsaW1pdGF0aW9ucy4NCj4gDQo+
PiArCQlkZWZhdWx0Og0KPj4gKwkJCXJldHVybiAtRUlOVkFMOw0KPj4gKwkJfQ0KPj4gKwlkZWZh
dWx0Og0KPj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+PiArCX0NCj4+ICt9DQo+PiArDQo+PiAgIHN0
YXRpYyBzdHJ1Y3QgY291bnRlcl9jb3VudCBtY2hwX3RjX2NvdW50c1tdID0gew0KPj4gICAJew0K
Pj4gICAJCS5pZCA9IDAsDQo+PiBAQCAtMzUxLDEyICszNzIsMTMgQEAgc3RhdGljIHN0cnVjdCBj
b3VudGVyX2NvdW50IG1jaHBfdGNfY291bnRzW10gPSB7DQo+PiAgIH07DQo+Pg0KPj4gICBzdGF0
aWMgY29uc3Qgc3RydWN0IGNvdW50ZXJfb3BzIG1jaHBfdGNfb3BzID0gew0KPj4gLQkuc2lnbmFs
X3JlYWQgICAgPSBtY2hwX3RjX2NvdW50X3NpZ25hbF9yZWFkLA0KPj4gKwkuYWN0aW9uX3JlYWQg
ICAgPSBtY2hwX3RjX2NvdW50X2FjdGlvbl9yZWFkLA0KPj4gKwkuYWN0aW9uX3dyaXRlICAgPSBt
Y2hwX3RjX2NvdW50X2FjdGlvbl93cml0ZSwNCj4+ICAgCS5jb3VudF9yZWFkICAgICA9IG1jaHBf
dGNfY291bnRfcmVhZCwNCj4+ICAgCS5mdW5jdGlvbl9yZWFkICA9IG1jaHBfdGNfY291bnRfZnVu
Y3Rpb25fcmVhZCwNCj4+ICAgCS5mdW5jdGlvbl93cml0ZSA9IG1jaHBfdGNfY291bnRfZnVuY3Rp
b25fd3JpdGUsDQo+PiAtCS5hY3Rpb25fcmVhZCAgICA9IG1jaHBfdGNfY291bnRfYWN0aW9uX3Jl
YWQsDQo+PiAtCS5hY3Rpb25fd3JpdGUgICA9IG1jaHBfdGNfY291bnRfYWN0aW9uX3dyaXRlDQo+
PiArCS5zaWduYWxfcmVhZCAgICA9IG1jaHBfdGNfY291bnRfc2lnbmFsX3JlYWQsDQo+IA0KPiBJ
dCdzIG5pY2UgdG8gYWxwaGFiZXRpemUgdGhlIGNvdW50ZXJfb3BzIGNhbGxiYWNrcywgYnV0IGl0
J3MgYWxzbw0KPiB1bnJlbGF0ZWQgdG8gdGhlIHdhdGNoX3ZhbGlkYXRlIGltcGxlbWVudGF0aW9u
LiBNb3ZlIHRoZSBhbHBoYWJldGl6YXRpb24NCj4gY2xlYW51cCB0byBhIHNlcGFyYXRlIHBhdGNo
IHNvIHRoYXQgdGhpcyBwYXRjaCByZW1haW5zIGRlZGljYXRlZCB0bw0KPiBqdXN0IHdhdGNoX3Zh
bGlkYXRlIGNoYW5nZXMuDQoNClN1cmUsIEkgd2lsbCBkcm9wIHNvcnRpbmcgaW4gdGhpcyBwYXRj
aC4NCg0KPiANCj4gVGhhbmtzLA0KPiANCj4gV2lsbGlhbSBCcmVhdGhpdHQgR3JheQ0KDQoNCi0t
IA0KV2l0aCBCZXN0IFJlZ2FyZHMsDQpEaGFybWEgQi4NCg==

