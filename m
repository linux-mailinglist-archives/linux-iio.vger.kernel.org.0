Return-Path: <linux-iio+bounces-18619-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 841EDA9C031
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 09:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98654A2AD3
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 07:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA48D231C87;
	Fri, 25 Apr 2025 07:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="RIzqX1oq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D465231A3F;
	Fri, 25 Apr 2025 07:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745567833; cv=fail; b=tYb2C+A5vbj8mRZ5GDgpkwvg0ftsKx7RoW7tXVD0qHp5I/3C9njJCT4ivDWEAuOl/P7rM1Mzz+k1NM4KmVscgTiZIduM7RtdXC/Pqn0b1IEn1sdOqKficoBdNjw+SY+zUKUbNwiCoszcwhxtyQZCYhg0Qs5c+muvfyeScdVpjMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745567833; c=relaxed/simple;
	bh=moENHrrSRLBi2cVggdDIzJmOYt3vjSYn+d9rFhgg8WM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o9JSbIzmiM1kr7BP+q10WmZui/fbLYj6AeIGp2b4Sb3Add/roJF/KxwW5b2LTByiwlOuqf/qEgL79/VqXOOBzBcLF/XNUo8CtA+qGZycQf1fvKx8X0QF113tuJq2B6fYHc4UK7k0JhZcRRXjRbHCCF/A0h1jy6bnQdvXR2/EEbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=RIzqX1oq; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P7NPkZ019426;
	Fri, 25 Apr 2025 03:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=moENH
	rrSRLBi2cVggdDIzJmOYt3vjSYn+d9rFhgg8WM=; b=RIzqX1oq4hzTzW39/hcJd
	1RkJwQImxF8+x+nZvOmrlhH694ewk+Ec5qT87iIcHp0l1NrsWHNquGLMi/IVFwB1
	x2Ne8mt31d9aZPSKvnY1mwBXPsKg2cY+qhdF/iGzVBPO0xjuDCksjgnrpLMJHIyJ
	YmV8sJfpwSBYIMowbiSPGHt1qUuRb2NLtqQObZXK75rlHjxrDj/64G/SpeJtWsqg
	MlBy1URwKPb8WsYGZkypRN/zav9xyqKth+NhqA6whpZyd853gN3TSCy5HmGKYrZj
	1/WJgk6K3yju42AL+/rE19WkxTbPl6hsfS8Ct7ggN6cUuaNGwDG/nS/iobcMwA3C
	Q==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010006.outbound.protection.outlook.com [40.93.13.6])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 466jjqx3wp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 03:56:55 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8jGyuFGKzYW9SD8oNqvex5ck92S5TodJlH+52ks8cHuyl0TcUAMUys9V8SkRJY1Ljuavjq4u0W3JBQj+9s3zxnH3uVW8VHo4Hb0vmVA99BCnvxL8nFTowQ2gxb5Ie4P+QIaK67oCSczMUdQG7oqv60wLDye6WqGjnysbqJ1oSIMTHAERgQmOMGkX6Cl3m/xygbXMLj+dy5xFlXB6cO3++IN7u3DChWRTNfMRHWJyngKIXf7z6Y7gCS4mlkLO/br4832R9HPhaUjyGaddaoT6QxX3O3nIYtI5fZmb27RMXktLSbWWxRHqgZ/x70suJ6xaiY6niM7/W46wkRXugXxmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moENHrrSRLBi2cVggdDIzJmOYt3vjSYn+d9rFhgg8WM=;
 b=H6UzZxurBFbBAuztL1lU0U+tp6Nb2PHCNXMlCDtdRNPE3s4pBOCu9NHq1evExjxXkAEC7gT57SDwVVylyTVZH0pfqRCe1GWvyHZvPSlH5xF3wMbPjGM0XEsJrtiqH90e0/nyaAn9hPFwkWAcM+3S5sIOwXD5gpShe4WJlG1LCiHJXqSM9XIOPNkssJ+ZSo5upABixGMmoYe8A0KcoKY166jCxYZVJ6kpu29T0Y5eW/lvLXCUCl6EEdmwmVg4/ndpe8A6Jz+5+XqZnglowdMyT6y0xzxQMcKpRNxE6hbV4IEBQuIF9mOen6Ms7F0uNOGSSvEh/SC3ckRIi1MHMBPmVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by DS0PR03MB7654.namprd03.prod.outlook.com (2603:10b6:8:1f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 07:56:54 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17%7]) with mapi id 15.20.8655.038; Fri, 25 Apr 2025
 07:56:51 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: =?utf-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>,
        "jic23@kernel.org"
	<jic23@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 13/13] iio: adc: ad4080: add driver support
Thread-Topic: [PATCH v2 13/13] iio: adc: ad4080: add driver support
Thread-Index: AQHbqt5ozCVpuxNfo0GDvpSFpnGry7Okc1GAgArwG+CAAD0wgIAEdIyg
Date: Fri, 25 Apr 2025 07:56:51 +0000
Message-ID:
 <CY4PR03MB339972357BC25CD718D6FE039B842@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20250411123627.6114-1-antoniu.miclaus@analog.com>
		 <20250411123627.6114-14-antoniu.miclaus@analog.com>
	 <4e7100b945e542f675c6a506bc6431ad46cf6d84.camel@gmail.com>
	 <CY4PR03MB3399B23673D9C3210C8CE9B99BBB2@CY4PR03MB3399.namprd03.prod.outlook.com>
 <f2f0ef05a738a16083d686a246499788b6d353d2.camel@gmail.com>
In-Reply-To: <f2f0ef05a738a16083d686a246499788b6d353d2.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVcxcFkyeGhkWE5jWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTFrTm1NeU0yUmxNUzB5TVdGaExURXhaakF0WWpBMk5pMWtORGd4?=
 =?utf-8?B?WkRjMU1EWmtaR1ZjWVcxbExYUmxjM1JjWkRaak1qTmtaVEl0TWpGaFlTMHhN?=
 =?utf-8?B?V1l3TFdJd05qWXRaRFE0TVdRM05UQTJaR1JsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?STNORFk1SWlCMFBTSXhNek01TURBME1UUXdPVE15T0RVd09UQWlJR2c5SW1S?=
 =?utf-8?B?dGQydFpaMWgxYVhkc2RqZzJjRmx3WnpKb1FuQTBkbk5sU1QwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVOW5RMEZCUkdreGF6WmFkRGRZWWtGa2VHa3ZZa0pHTmpoV1lU?=
 =?utf-8?B?TkhURGx6UlZoeWVGWnZSVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVJMFFXZEJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQmFqSTRjM3AzUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
 =?utf-8?B?alJCUVVGQ2FFRkhVVUZoVVVKbVFVaE5RVnBSUW1wQlNGVkJZMmRDYkVGR09F?=
 =?utf-8?B?RmpRVUo1UVVjNFFXRm5RbXhCUjAxQlpFRkNla0ZHT0VGYVowSm9RVWQzUVdO?=
 =?utf-8?B?M1FteEJSamhCV21kQ2RrRklUVUZoVVVJd1FVZHJRV1JuUW14QlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVWQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlowRkJRVUZCUVc1blFVRkJSMFZCV2tGQ2NFRkdPRUZqZDBKc1FVZE5RV1JS?=
 =?utf-8?B?UW5sQlIxVkJXSGRDZDBGSVNVRmlkMEp4UVVkVlFWbDNRakJCU0UxQldIZENN?=
 =?utf-8?B?RUZIYTBGYVVVSjVRVVJGUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRlJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRMEZCUVVGQlFVTmxRVUZCUVZsUlFtdEJSMnRCV0hkQ2Vr?=
 =?utf-8?B?RkhWVUZaZDBJeFFVaEpRVnBSUW1aQlNFRkJZMmRDZGtGSGIwRmFVVUpxUVVo?=
 =?utf-8?B?UlFXTjNRbVpCU0ZGQllWRkNiRUZJU1VGTlowRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZDUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZLTkVGQlFVSm9RVWRS?=
 =?utf-8?B?UVdGUlFtWkJTRTFCV2xGQ2RVRklUVUZoVVVJd1FVZHJRV1JuUW14QlJqaEJZ?=
 =?utf-8?B?MEZDZVVGSE9FRmhaMEpzUVVkTlFXUkJRbnBCUmpoQlpFRkNjRUZIVlVGalow?=
 =?utf-8?B?RjRRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlJVRkJRVUZCUVVGQlFVRm5RVUZCUVVGQklp?=
 =?utf-8?B?OCtQQzl0WlhSaFBnPT0=?=
x-dg-rorf:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|DS0PR03MB7654:EE_
x-ms-office365-filtering-correlation-id: 412df7c9-9ffb-4ac7-ce9c-08dd83cebd35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V2p1eWpxdUY2T3ZkNDAvVWtOZTRJRXY1aDBNRTk5c0JiTVdYV3N0VXRFT25Y?=
 =?utf-8?B?QXZESk9BNE1kQ1NrWm9jKzhkMnFnNis3dEcrSFpCM0VuS282T2JhVnJJMlUx?=
 =?utf-8?B?N3BGNlVQYjU4N01lZXA4V1hyVnliUGdtdTllWnNNc3A2U1NQNlBXcmZ1N0Vq?=
 =?utf-8?B?cDNTVDlFQmZGckcrZysrRjlLRDh6R3ZiQkk5YS94UzZyU0k5QTBCU1l4UjV4?=
 =?utf-8?B?bnJvNm1GTFg0V3c5dllWVU1VcHpDMmM5NVNaZWgyekxIUnhJUVl3cys0QVpB?=
 =?utf-8?B?ZEFnRTV5bElMT0dqSEJMZHdvZG5YV0RwZHd6Qzgva3o0VnBiMWR0SmZ4bnpQ?=
 =?utf-8?B?eXp2OG9ib2c1NDVrUjcrektFeGlZRWZyUVVEd0hVOXZ6Y2VhRzZHMGF3Y3lD?=
 =?utf-8?B?cFhXWEE4d0JqWnBNeDJrSHJHVmZIRmxFZWdBTEE2UzNtZVFibEpRN3lEaFVl?=
 =?utf-8?B?LzkyMUtQbE1GeE1KVzBsTC8zWGJ6a1FRd0JDUENFRmYzYmg2bG13ZHQ4QUdU?=
 =?utf-8?B?NzgwVnZvZGVVd1lCcDlXOHk5WGE4aU1mRFYrU2RUMjJXcjBZYit4MXh3SDhu?=
 =?utf-8?B?cit5aHBRZitaelBuTHJwYmdZV0Nwc2pPaUoxM0RnWWY2SmdyTHV6UGxhSm1X?=
 =?utf-8?B?TjVCWDdSdnhSV2pYbHZRVENrcmZKVGQzZUs3czlwY0FBWStxaTBOeElSVHlR?=
 =?utf-8?B?SWU5Smc4U3JzWXkyb1VyOTlwUXNqZ2swMElDUzFnaVBUdGtsK2FzdERBZUE4?=
 =?utf-8?B?MWgycmgyK3FHMDlaVncwY1JJTFBFdzBSWmwrYXdTcGFDenZvQlhqY3ZoSFJr?=
 =?utf-8?B?N3VQejY3SlFoVzliSHA5TlhJL0pQOGNxL0VTckVqN2xjNVBkTjVwMWorUlFl?=
 =?utf-8?B?Z0ppa2FOVTI1MTJwaHFWK2NJRnFmVjlSV3FBNm5TUHhQM2Q0RVFsMzQycU5R?=
 =?utf-8?B?dEQ5bjZ6WTFxQmlLT3ZrUDlISFBCQjdEdldpUktoTkxPQmdtMzB4SnJkUGlM?=
 =?utf-8?B?SUpjRDN2NW1odEk4SlVNUDZWcFE3ZGFTcGtEWCtVRzU0QTlPdDd0UExKa2Uy?=
 =?utf-8?B?Wk9QcUMzdUNWNEp0aUlreENza3c0YUh2U3BWSmE5VEhNUmtQZFRuMUc5QXJr?=
 =?utf-8?B?emxVMGYwNm9pb01mS2pGWnpsNWNadnJXVkNKYU1hQW9xa1BrSmVqM0wxczA1?=
 =?utf-8?B?WHdEYmNEVmpRMkRrcUVtUjhyTkhRV2NmNmJzTVRHblNwZjh1MVZVZEozSWlW?=
 =?utf-8?B?bHZTdVlKaGtpUzg3RzE3djE3QTIrdXdMWFVESHJwR0NrSWFGM1RXQ0p2bVd3?=
 =?utf-8?B?VTh6UmdrYVBvNHk4cWkwVXRPUXY1SWd4NmhNdzIwOElNdzdkRTdnQ3VYTUJs?=
 =?utf-8?B?bytDVUxKSHlkRTZCMjRTTzZJbmRpWmYxU1RTSU8wVk1Mb3VVN2NqajQ5YzY4?=
 =?utf-8?B?aEdtNExDMUhtd1RRQTVMektMZkhKekhTMjA4N3BwNzY2YUxURzFhZ0o2VFlZ?=
 =?utf-8?B?T21KZS9SMVZqUXExa1lNd0ZUaUphdTRBL2Nmd0ZyL3h6aDIrQWNkUDhzT3di?=
 =?utf-8?B?cUx4UFh0V1VDVFJVTnlvOUJFajJvYnhZY25EVU5Bd09TZjd6TFRwbWNxV0hs?=
 =?utf-8?B?dzgzeFVXcGlxTUplME5rV3VPWmVNYnZ1TU1GbmFmdVkvYzdYRkh1Wmc0am1C?=
 =?utf-8?B?anNac090NVNBS1QvTjhaLzR1R3RZSnlBRmE2UXMxaXpPbFBuV0NKUm1UUXh3?=
 =?utf-8?B?VVRiMUt2Syt0QlpHUi9DSDNNckl0KzhlZTNwVUt1T3E3aUwrS1ViemdsKzVR?=
 =?utf-8?B?elp2YXZsTm5QY2MrekI1ZzVVMitJUkUxWGd3djBLbmRIeFIvS3FpQlZkczEv?=
 =?utf-8?B?ckdYV3R2bzZ4Y3ZhM1ptcER4bFAyZ09jU2FzQ1BRSVJnai9yM1llS0c2ZzR3?=
 =?utf-8?B?TTVCZ09pRDFFVVM4MkozN2xob3pJdEVxbm1MNjQ1bjVsdmI3cXl3TWtZUVl2?=
 =?utf-8?Q?efoQxL4CvXDyRTbLsvcxjY/eaRlvVk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZVYxbVBQSXV5VnhHWU1FbzFQRmR5ZTBKTVRGNGZYNHovd3V3L0RNTE4vZ3d4?=
 =?utf-8?B?WXJXRGF0OXQrSURtWFlUOG1ZclRaRkJLVVVCRDVOUEtiLzVmS0V0TkxkemZD?=
 =?utf-8?B?SjhkYU00a3JCZHNBMHlQMjNuQ1NEclpkKzl3dloxWmhMR0ZrZHBucXFKbG10?=
 =?utf-8?B?SzhsRk92YktIRlYwNWZ5QjlPV0ljQVZBcWJWdy9RUHZMcy92QXRqTkRNZ0E4?=
 =?utf-8?B?WFl5ZjIzZUFIZWxCam53d1hFMVlhOFFScVNvRmM0ZHBZVWtaQVZuUlY0QWVN?=
 =?utf-8?B?aWE3c1lvTmhFQm9JaHpFSlMrZ2JmRVN2dXRvcGR3UUpFcVcrcjRTMXFYTWJ0?=
 =?utf-8?B?T3BWNDkxN2NjVVh5Q2RVRjRIdjlnajRISzlrUFRHMUxRZk55Y1BYalJlWkhI?=
 =?utf-8?B?NlQxdEVNNCtadXh6QVJmMHdTNktZcFF2VFBNWTl4b0VTWlR1Tm5tamVmZXlj?=
 =?utf-8?B?aHFtV1pWYXd3SW5NSGcydWtOdXRmdW50Z3JSb3FBL216NnVHRWc5ME41UWVO?=
 =?utf-8?B?Ri9NWkhjQndrWHRqUE0yY2VPaWVtbHVHUDRKdUM5akEvWWNxY0VJdkRZV0FK?=
 =?utf-8?B?SHNOZjFwVmU4d09OcllHTGxzYjFhMm9jTGxsRkJGNTRKMldJeUJnU05YYTZ2?=
 =?utf-8?B?R0RjaE9Oa0xaUFpDMVN6MURiWXBQSUFJK2lJbGNJbzhTQVNwZVpHWEtzbUo3?=
 =?utf-8?B?WU9qQmN2M0p6SlpOWGo3V2YyUVY0bm4vakdadlF2NE5nQUUySlcrVDB4a2tN?=
 =?utf-8?B?d2pNUXp2c2tzbzJzTXZJM09FMXV5UlptNXk3VGpJSU5ocy91VWRiK0VjeEMv?=
 =?utf-8?B?K0QzVEJaNisrUVoyOEx3eGdDbXpGQ1Q1NjYwaHBBTnZya0JPbWY0aWE3MVE0?=
 =?utf-8?B?TU1JdU5TMTlja2Y4eFNCdzZGOTl2N1Y0ZTZDL2xFT2w0bHNhQkNzTlZ0TEVK?=
 =?utf-8?B?MXVMK2pmRGxpU1hLOVBMNzIxb05NK2Y0bTZDTlpIWDEyM3dzQzJ4ZUwvdUEy?=
 =?utf-8?B?QkE0U1Fybmp0cTlXYklTL2srbHY3Wi9VVjJzMlNpRTFIWXlZYXlPTVRTdVha?=
 =?utf-8?B?NVBDUzh1TFpzWEh6NDMxSk93Sm1tMDZLaWUxSGI1bG1QWE53VlBDNmY0eEw3?=
 =?utf-8?B?K2xjYVhZbFhBOEZrOEJpd3Q4N3M4SnoybSt1SGh0UEtPL0k1blBjbkczY0Vv?=
 =?utf-8?B?UzVDa0JhdXFGNWFRWlZ6b1JKbTRXUDJqaW1Nek01cDR2My9hUEIrWC8waS9X?=
 =?utf-8?B?RXVNams1R293ZVBWYVZ0ck9GbzNneVhic2dzVXp0R1p3Wk8rbGRkVSswL3Jk?=
 =?utf-8?B?azlEQkJPdnpRZmg2dURLV0RqNkxxZk0rVjN2RnZiU05tbzd4clEzUnhsQzFr?=
 =?utf-8?B?OWFvUVFmNTRYbnBpU3lISXZkYnN4R2s3eWVuNW5YTXl1S0ZBak1DZy9nUGlY?=
 =?utf-8?B?cWNhSlQvK1FwSDUxUVB0SGR5M2hTVTU0MzJOclZqTkZZWVVjeFd4eU1VMTlo?=
 =?utf-8?B?ZElCOFkvd2gzR0VpalVSb1Ewb2dyMTduaStnY2tOR1h6VGlaUTJTeFEyM0hl?=
 =?utf-8?B?WDhTV0I1NmQvSzlSc3JIRmRyb0hGVTIvSkVIRXoyeFBXaDdBT2dwL1VmU0pX?=
 =?utf-8?B?Vzc4VG9Hai9ReFRuYmd2VE1wU3dyMmhqUG1seXcwcmVNSFUzaFR2V1hJZ1NT?=
 =?utf-8?B?YjZPOFJla1phcEFOSnJwU2ptTVM4dGo3cVZQdVNMdmxTYTVGVHNJZTBRcTIr?=
 =?utf-8?B?bjZEMUQxRlB0dEJPR2pQYTZVWERVcFM1ajdXZjZSZ2crSXU5eUVXbCtQOHBn?=
 =?utf-8?B?MkNRbC92K1I1LzdrTjRzMnptMDZvbmxOT2IzOTRJZlhJR1ovYXZTa1FlVTZO?=
 =?utf-8?B?NStlOFVsd2V3dzdXQ3JCR0p1Y1UyM2ErV1JwNHhzVG9BdEdWM3JRb3h4Tnpt?=
 =?utf-8?B?TkMxOFhEeGd5eGVBOC9NWFhLWG9uQ0FqNE8zYWNGSU1iazZwa0NLakFNUklP?=
 =?utf-8?B?RkxVbkIySU51aUtpbFI4Tm54bjgxSVJibkZuRWhiWHdubjdDeW42Y1QzUk1j?=
 =?utf-8?B?REtqZkFOY2s2WFBQVFFVYkNPeS94aFlYVXhEVFBhcHRJN0k3VGVybWVPNXN5?=
 =?utf-8?B?WStjVWJNdW9XMkRpSWo5WkJFeG03UThLbkZxVUNlWm15QmY3NkI2QWYxVG1H?=
 =?utf-8?B?Y0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 412df7c9-9ffb-4ac7-ce9c-08dd83cebd35
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 07:56:51.7353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EH+w8s4a7OBickkGMhnJIwk9VqC9LlNm0rUzKYqW9IdbklAM0+QQsojwukXHxYs8yr9swKtk/6HWDVKedFHeevU9CFKZDSVlLmtmFFjHOFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7654
X-Proofpoint-ORIG-GUID: Ejia9RuZS6INQTPXgkU-rlKhw4RVBc-2
X-Authority-Analysis: v=2.4 cv=DoJW+H/+ c=1 sm=1 tr=0 ts=680b4048 cx=c_pps a=uv9tqaYN/MHSKh89N0CxNA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=89u88s9_G1tle-A-UgQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA1NyBTYWx0ZWRfX9ES85kDw9hZy fQFWGPdC8GPg6kKCy3dBpsSjY5xy2HZRjBRU0sgp089ZJiKcnJU37DfQI+TQ5n1BrjsIlpi+I73 1TUlfW5R4ATRJR2zrJBJvzh4qXjt8s7KUhzGVa5LIHjNnirhibFgInYW0Drz67pvApiUt/Tus69
 1PZfwL5kYa+lFckSeVyfZXxUQu2q2wQtdmdB/xrpX2/zFLhn81qFDKxoKpaYbsvXwLNXkdtdwl2 MFFUfMN6kYrN/m+3HdLUHyv6TjMZBiOzjHpOUnN3Xgorff1pYFwHVFYnnJd9DgE/fq9p4869Vq/ YLeDLxVMOPWNvlgubG2H+Li0Zw4nV9rJSB80kQQzm+jdr4G5OE23ueLkin1aouvaR6VWyKAv6ov
 L22CEzZlNA9bYJ1Es0S1aVfMeimpeQGHAN+YRn4QHP/RMCVcAN4H20qj+GKl3XNeOVBKesvw
X-Proofpoint-GUID: Ejia9RuZS6INQTPXgkU-rlKhw4RVBc-2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250057

DQoNCi0tDQpBbnRvbml1IE1pY2zEg3XFnw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IE51bm8gU8OhIDxub25hbWUubnVub0BnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIEFwcmlsIDIyLCAyMDI1IDI6MzkgUE0NCj4gVG86IE1pY2xhdXMsIEFudG9uaXUgPEFudG9u
aXUuTWljbGF1c0BhbmFsb2cuY29tPjsgamljMjNAa2VybmVsLm9yZzsNCj4gcm9iaEBrZXJuZWwu
b3JnOyBjb25vcitkdEBrZXJuZWwub3JnOyBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOw0KPiBk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEzLzEzXSBpaW86IGFkYzogYWQ0MDgwOiBhZGQgZHJp
dmVyIHN1cHBvcnQNCj4gDQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIFR1ZSwgMjAyNS0wNC0yMiBh
dCAwODoxMiArMDAwMCwgTWljbGF1cywgQW50b25pdSB3cm90ZToNCj4gPiA+ID4gKwlpbnQgcmV0
Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsJZ3VhcmQobXV0ZXgpKCZzdC0+bG9jayk7DQo+ID4gPiA+
ICsJaWYgKHN0LT5udW1fbGFuZXMgPT0gMSkNCj4gPiA+ID4gKwkJcmV0ID0gcmVnbWFwX3dyaXRl
KHN0LT5yZWdtYXAsDQo+ID4gPiA+IEFENDA4MF9SRUdfQURDX0RBVEFfSU5URl9DT05GSUdfQSwN
Cj4gPiA+ID4gKwkJCQnCoMKgIEFENDA4MF9SRVNFUlZFRF9DT05GSUdfQV9NU0sgfA0KPiA+ID4g
PiArCQkJCcKgwqAgQUQ0MDgwX0lOVEZfQ0hLX0VOX01TSyk7DQo+ID4gPiA+ICsJZWxzZQ0KPiA+
ID4gPiArCQlyZXQgPSByZWdtYXBfd3JpdGUoc3QtPnJlZ21hcCwNCj4gPiA+ID4gQUQ0MDgwX1JF
R19BRENfREFUQV9JTlRGX0NPTkZJR19BLA0KPiA+ID4gPiArCQkJCcKgwqAgQUQ0MDgwX1JFU0VS
VkVEX0NPTkZJR19BX01TSyB8DQo+ID4gPiA+ICsJCQkJwqDCoCBBRDQwODBfSU5URl9DSEtfRU5f
TVNLIHwNCj4gPiA+ID4gKwkJCQnCoMKgIEFENDA4MF9TUElfTFZEU19MQU5FU19NU0spOw0KPiA+
ID4gPiArCWlmIChyZXQpDQo+ID4gPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gPiA+ICsNCj4gPiA+
ID4gKwlyZXQgPSBpaW9fYmFja2VuZF9kYXRhX2FsaWdubWVudF9lbmFibGUoc3QtPmJhY2spOw0K
PiA+ID4gPiArCWlmIChyZXQpDQo+ID4gPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gPiA+ICsNCj4g
PiA+ID4gKwlkbyB7DQo+ID4gPiA+ICsJCXJldCA9IGlpb19iYWNrZW5kX3N5bmNfc3RhdHVzX2dl
dChzdC0+YmFjaywgJnN5bmNfZW4pOw0KPiA+ID4gPiArCQlpZiAocmV0KQ0KPiA+ID4gPiArCQkJ
cmV0dXJuIHJldDsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCQlpZiAoIXN5bmNfZW4pDQo+ID4gPiA+
ICsJCQlkZXZfZGJnKCZzdC0+c3BpLT5kZXYsICJOb3QgTG9ja2VkOiBSdW5uaW5nIEJpdA0KPiA+
ID4gPiBTbGlwXG4iKTsNCj4gPiA+ID4gKwl9IHdoaWxlICgtLXRpbWVvdXQgJiYgIXN5bmNfZW4p
Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsJaWYgKHRpbWVvdXQpIHsNCj4gPiA+ID4gKwkJZGV2X2lu
Zm8oJnN0LT5zcGktPmRldiwgIlN1Y2Nlc3M6IFBhdHRlcm4gY29ycmVjdCBhbmQNCj4gPiA+ID4g
TG9ja2VkIVxuIik7DQo+ID4gPiA+ICsJCWlmIChzdC0+bnVtX2xhbmVzID09IDEpDQo+ID4gPiA+
ICsJCQlyZXR1cm4gcmVnbWFwX3dyaXRlKHN0LT5yZWdtYXAsDQo+ID4gPiA+IEFENDA4MF9SRUdf
QURDX0RBVEFfSU5URl9DT05GSUdfQSwNCj4gPiA+ID4gKw0KPiA+ID4gCcKgwqDCoCBBRDQwODBf
UkVTRVJWRURfQ09ORklHX0FfTVNLKTsNCj4gPiA+ID4gKwkJZWxzZQ0KPiA+ID4gPiArCQkJcmV0
dXJuIHJlZ21hcF93cml0ZShzdC0+cmVnbWFwLA0KPiA+ID4gPiBBRDQwODBfUkVHX0FEQ19EQVRB
X0lOVEZfQ09ORklHX0EsDQo+ID4gPiA+ICsNCj4gPiA+IAnCoMKgwqAgQUQ0MDgwX1JFU0VSVkVE
X0NPTkZJR19BX01TSyB8DQo+ID4gPiA+ICsJCQkJCcKgwqDCoCBBRDQwODBfU1BJX0xWRFNfTEFO
RVNfTVNLKTsNCj4gPiA+ID4gKwl9IGVsc2Ugew0KPiA+ID4gPiArCQlkZXZfaW5mbygmc3QtPnNw
aS0+ZGV2LCAiTFZEUyBTeW5jIFRpbWVvdXQuXG4iKTsNCj4gPiA+ID4gKwkJaWYgKHN0LT5udW1f
bGFuZXMgPT0gMSkgew0KPiA+ID4gPiArCQkJcmV0ID0gcmVnbWFwX3dyaXRlKHN0LT5yZWdtYXAs
DQo+ID4gPiA+IEFENDA4MF9SRUdfQURDX0RBVEFfSU5URl9DT05GSUdfQSwNCj4gPiA+ID4gKw0K
PiA+ID4gCcKgwqAgQUQ0MDgwX1JFU0VSVkVEX0NPTkZJR19BX01TSyk7DQo+ID4gPiA+ICsJCQlp
ZiAocmV0KQ0KPiA+ID4gPiArCQkJCXJldHVybiByZXQ7DQo+ID4gPiA+ICsJCX0gZWxzZSB7DQo+
ID4gPiA+ICsJCQlyZXQgPSByZWdtYXBfd3JpdGUoc3QtPnJlZ21hcCwNCj4gPiA+ID4gQUQ0MDgw
X1JFR19BRENfREFUQV9JTlRGX0NPTkZJR19BLA0KPiA+ID4gPiArDQo+ID4gPiAJwqDCoCBBRDQw
ODBfUkVTRVJWRURfQ09ORklHX0FfTVNLIHwNCj4gPiA+ID4gKwkJCQkJwqDCoCBBRDQwODBfU1BJ
X0xWRFNfTEFORVNfTVNLKTsNCj4gPiA+ID4gKwkJCWlmIChyZXQpDQo+ID4gPiA+ICsJCQkJcmV0
dXJuIHJldDsNCj4gPiA+ID4gKwkJfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICsJCXJldHVybiAtRVRJ
TUVET1VUOw0KPiA+ID4NCj4gPiA+IFNvLCBmaXJzdCB0aGUgdGhpbmdzIHRoYXQgSSBkb24ndCBy
ZWFsbHkgZ2V0IChhbHNvIHRoZSBoZGwgZG9jcyBuZWVkIHRvIGJlDQo+ID4gPiBpbXByb3ZlZCBG
V0lXKToNCj4gPiA+DQo+ID4gPiAqIEl0IHNlZW1zIHRoYXQgd2UgY2FuIGhhdmUgZGF0YSBhbGln
bm1lbnQgb3IgZGF0YSBjYXB0dXJlDQo+IHN5bmNocm9uaXphdGlvbg0KPiA+ID4gdGhyb3VnaCBh
biBpbnRlcm5hbCBBTUQgRlBHQSB0ZWNobmlxdWUgY2FsbGVkIGJpdC1zbGlwIG9yIGFuIGV4dGVy
bmFsDQo+ID4gPiBzaWduYWwsDQo+ID4gPiByaWdodD8gSW4gaGVyZSwgaXQgc2VlbXMgdGhhdCB3
ZSBvbmx5IHVzZSBiaXQtc2xpcCBhbmQgbmV2ZXIgZGlzYWJsZSBpdC4gSXMNCj4gPiA+IHRoYXQN
Cj4gPiA+IHJlYWxseSB0aGUgZ29hbD8NCj4gPiA+DQo+ID4gPiAqIFRoaXMgd2hvbGUgcHJvY2Vz
cyBzZWVtcyB0byBiZSBzb21lIGtpbmQgb2YgY2FsaWJyYXRpb24gYXQgdGhlIGludGVyZmFjZQ0K
PiA+ID4gbGV2ZWwsIHJpZ2h0Pw0KPiA+ID4NCj4gPiA+ICogV2hhdCdzIHRoZSBwb2ludCBvZiB0
aGUgY29udiBjbG9jaz8gSXMgaXQgb25seSB1c2VkIHRvIGdldCB0aGUgc2FtcGxlDQo+ID4gPiBy
YXRlPyBJZg0KPiA+ID4gc28sIHRoZSBoZGwgZG9jcyBhcmUgbWlzbGVhZGluZyBhcyBpdCBzZWVt
cyB0aGF0IGl0IGNhbiBiZSB1c2VkIGluc3RlYWQgb2YNCj4gPiA+IGJpdC0NCj4gPiA+IHNsaXAg
Zm9yIGRhdGEgY2FwdHVyZSBhbGlnbm1lbnQ/DQo+ID4gPg0KPiA+ID4gTm93LCBzcGVha2luZyBh
Ym91dCB0aGUgYmFja2VuZCBBUEkncywgaXQgbG9va3MgbGlrZSB0aGF0DQo+ID4gPiBpaW9fYmFj
a2VuZF9zZWxmX3N5bmNfZW5hYmxlKCkgYW5kIGlpb19iYWNrZW5kX2RhdGFfYWxpZ25tZW50X2Vu
YWJsZSgpDQo+ID4gPiBjb3VsZCBiZQ0KPiA+ID4gbWVyZ2VkIGludG8gb25lIEFQSS4gRnJvbSB3
aGF0IEkgY2FuIHRlbGwsDQo+ID4gPiBpaW9fYmFja2VuZF9kYXRhX2FsaWdubWVudF9lbmFibGUo
KQ0KPiA+ID4ganVzdCBlbmFibGVzIHRoZSBiaXQtc2xpcCBwcm9jZXNzIGJ1dCB0aGF0IGxpa2Vs
eSBkb2VzIG5vdGhpbmcgdW5sZXNzIHRoZQ0KPiA+ID4gU0VMRl9TWU5DIGJpdCBpcyBhbHNvIHNl
dCB0byBiaXQtc2xpcCwgcmlnaHQ/IEluIGZhY3QsIHdlIGNvdWxkIHRoaW5rIGFib3V0DQo+ID4g
PiBhDQo+ID4gPiBtb3JlIGdlbmVyaWMgKGxlc3MgZmxleGlibGUgdGhvdWdoKSBBUEkgbGlrZToN
Cj4gPiA+DQo+ID4gPiAqIGlpb19iYWNrZW5kX2ludGZfZGF0YV9hbGlnbihiYWNrLCB0aW1lb3V0
X3VzKSwgb3INCj4gPiA+ICogaWlvX2JhY2tlbmRfaW50Zl9jYWxpYihiYWNrLCB0aW1lb3V0X3Vz
KSwgb3INCj4gPiA+ICogaWlvX2JhY2tlbmRfaW50Zl9kYXRhX2NhcHR1cmVfc3luYyhiYWNrLCB0
aW1lb3V0X3VzKQ0KPiA+ID4NCj4gPiA+IE9uIHRoZSBiYWNrZW5kIHNpZGUsIHlvdSBjb3VsZCB0
aGVuIGVuYWJsZSBiaXQtc2xpcCBhbmQgZG8gdGhlIHN0YXR1cyByZWFkDQo+ID4gPiAod2l0aA0K
PiA+ID4gdGltZW91dCkgYW5kIHJldHVybiBzdWNjZXNzIG9yIGFuIGVycm9yIGNvZGUuDQo+ID4g
Pg0KPiA+ID4gVGhlIGFib3ZlIHNlZW1zIHRvIGJlIHByZXR0eSBtdWNoIHdoYXQgeW91J3JlIGRv
aW5nIGJ1dCBpbiBqdXN0IG9uZSBBUEkNCj4gdGhhdA0KPiA+ID4gbWFrZXMgc2Vuc2UgdG8gbWUu
DQo+ID4gPg0KPiA+ID4gT2YgY291cnNlIHRoYXQgdGhlIGZvbGxvd2luZyBxdWVzdGlvbnMgc3Rp
bGwgY29tZSB0byBtaW5kOg0KPiA+ID4NCj4gPiA+ICogRG8gd2UgbmVlZCB0byBkaXNhYmxlIGJp
dC1zbGlwIGFmdGVyIHdlJ3JlIGRvbmUgKHN0aWxsIGZpdHMgaW50byB0aGUgb25lDQo+ID4gPiBB
UEkNCj4gPiA+IG1vZGVsKT8NCj4gPiA+ICogRG8gd2UgbmVlZCBhIG1lYW5pbmdmdWwgQVBJIHRv
IGNoYW5nZSBiZXR3ZWVuIHRoZSBzeW5jaW5nL2FsaWdubWVudA0KPiA+ID4gbWV0aG9kcz8NCj4g
PiA+IEV4dGVybmFsIHNpZ25hbCB2cyBiaXQtc2xpcD8NCj4gPiA+DQo+ID4gPiBUaGUgYWJvdmUg
aXMga2V5IHRvIGJldHRlciB0aGluayBvZiBhbiBBUEkuIFJpZ2h0IG5vdyBpdCBmZWVscyB0aGF0
IHlvdSdyZQ0KPiA+ID4ganVzdA0KPiA+ID4gYWRkaW5nIGFuIEFQSSBmb3IgZXZlcnkgYml0IHlv
dSB3YW50IHRvIGNvbnRyb2wgaW4gdGhpcyBwcm9jZXNzLi4uDQo+ID4gPg0KPiA+ID4gSWYgd2Ug
ZW5kIHVwIG5lZWRpbmcgbW9yZSBmbGV4aWJpbGl0eSBmb3IgdGhpcywgd2UgY2FuIGFsc28gY29u
c2lkZXIgdGhlDQo+ID4gPiBleGlzdGluZyBpaW9fYmFja2VuZF9kYXRhX3NhbXBsZV90cmlnZ2Vy
KCkgQVBJLiBJIGtub3cgaXMgYWJ1c2luZyBhIGJpdCBhbmQNCj4gPiA+IGENCj4gPiA+IHN0cmV0
Y2ggYnV0IGluIHRoZSBlbmQgb2YgdGhlIGRheSB0aGUgd2hvbGUgdGhpbmcgaXMgcmVsYXRlZCB3
aXRoIGFsaWduaW5nLA0KPiA+ID4gc3luY2luZywgY2FsaWJyYXRpbmcgdGhlIGludGVyZmFjZSBm
b3IgcHJvcGVybHkgc2FtcGxpbmcgZGF0YS4gRXZlbiBiaXQtc2xpcA0KPiA+ID4gKHdoaWxlIG5v
dCBhIHRyYWRpdGlvbmFsIGV4dGVybmFsIHRyaWdnZXIpIGxvb2tzIGxpa2Ugc29tZSBraW5kIG9m
IHNlbGYtDQo+ID4gPiBhZGp1c3RpbmcsIGRhdGEtZHJpdmVuIHRyaWdnZXIgbWVjaGFuaXNtIHRv
IGVzdGFibGlzaCB0aGUgY29ycmVjdCBzdGFydGluZw0KPiA+ID4gcG9pbnQNCj4gPiA+IGZvciBj
YXB0dXJpbmcgZGF0YS4gU28gaGF2aW5nIHR3byBuZXcgZW51bXMgbGlrZToNCj4gPiA+DQo+ID4g
PiBJSU9fQkFDS0VORF9TQU1QTEVfVFJJR0dFUl9FWFRfU0lHTkFMLA0KPiA+ID4gSUlPX0JBQ0tF
TkRfU0FNUExFX1RSSUdHRVJfQklUX1NMSVAgLy8gb3IgbWF5YmUgYSBtb3JlIGdlbmVyaWMNCj4g
bmFtZQ0KPiA+ID4gbGlrZQ0KPiA+ID4gcy9CSVRfU0xJUC9JTlRFUk5BTA0KPiA+ID4NCj4gPiA+
IEkgZG8gbm90IHRoaW5rIHRoZSBhYm92ZSBpcyB0aGF0IGhvcnJpYmxlIDpQLi4uIEJ1dCBJIHdv
dWxkIHJlYWxseSBsaWtlIHRvDQo+ID4gPiBnZXQNCj4gPiA+IG1vcmUgb3BpbmlvbnMgYWJvdXQg
dGhpcy4NCj4gPg0KPiA+IFRoZXJlJ3ZlIGJlZW4gc29tZSB1cGRhdGUgb24gdGhlIEhETCBzaWRl
IGNoYW5naW5nIGEgYml0IHRoZSBiZWhhdmlvcjoNCj4gPiAtIGJpdHNsaXBfZW5hYmxlIGlzIHJl
bW92ZWQsIGluc3RlYWQgdGhlIGBzeW5jYCBiaXQgaXMgdXNlZCB3aGljaCBpcyBhbHJlYWR5DQo+
ID4gcGFydA0KPiA+IMKgIG9mIHRoZSBhZGMgY29tbW9uIGNvcmUuDQo+ID4gwqBTWU5DOg0KPiA+
IMKgwqDCoMKgwqDCoCBUaGlzIGJpdCBlbmFibGVzIGNhcHR1cmUgc3luY2hyb25pemF0aW9uLiBX
aGVuIGFjdGl2YXRlZCwgaXQgaW5pdGlhdGVzDQo+ID4gwqDCoMKgwqDCoMKgIGFuIEhETCBwcm9j
ZXNzIHRoYXQgYWxpZ25zIHRoZSBzYW1wbGUncyBtb3N0IHNpZ25pZmljYW50IGJpdCAoTVNCKQ0K
PiA+IGJhc2VkDQo+ID4gwqDCoMKgwqDCoMKgIHNvbGVseSBvbiB0aGUgY2FwdHVyZWQgZGF0YSwg
d2l0aG91dCBjb25zaWRlcmluZyB0aGUgQUQ0MDgwJ3MgQ05WDQo+ID4gc2lnbmFsLg0KPiA+IMKg
wqDCoMKgwqDCoCBUaGlzIGJpdCBpcyBzZWxmLWNsZWFyaW5nIGFuZCBzaG91bGQgYmUgdG9nZ2xl
ZCB3aGVuZXZlcg0KPiA+IHN5bmNocm9uaXphdGlvbg0KPiA+IMKgwqDCoMKgwqDCoCBpcyBuZWVk
ZWQgKGUuZy4sIGF0IGJvb3Qgb3IgYWZ0ZXIgdXBkYXRpbmcgdGhlIHNhbXBsaW5nIHJhdGUpLg0K
PiA+DQo+ID4gVGhlIFNFTEZfU1lOQyBiaXQgd2FzIHJlbW92ZWQuDQo+ID4NCj4gPiBTWU5DX1NU
QVRVUyBiaXQgKHdoaWNoIGlzIGFsc28gcGFydCBvZiB0aGUgY29tbW9uIGNvcmUpIGhhcyB0aGUg
Zm9sbG93aW5nDQo+ID4gYmVoYXZpb3I6DQo+ID4gwqDCoMKgwqDCoCBUaGlzIGJpdCBpbmRpY2F0
ZXMgd2hldGhlciB0aGUgc2FtcGxlJ3MgTVNCIGFsaWdubWVudCBoYXMgYmVlbiBjb3JyZWN0bHkN
Cj4gPiDCoMKgwqDCoMKgIHBlcmZvcm1lZCBhbmQgdGhlIGNhcHR1cmUgaXMgc3luY2hyb25pemVk
LiBJZiBzdWNjZXNzZnVsLCB0aGlzIGJpdCB3aWxsDQo+ID4gwqDCoMKgwqDCoCBiZSBzZXQgdG8g
MS4NCj4gDQo+IFNvIHRoaXMgbG9va3MgbGlrZSBpdCB3b3VsZCBmaXIgaW4gZmlyc3QgYXBwcm9h
Y2ggb2YganVzdCBvbmUgbmV3IGJhY2tlbmQgQVBJDQo+IHJpZ2h0Pw0KSW4gdGhpcyBwYXJ0aWN1
bGFyIGNhc2UsIHllcywgb25lIGJhY2tlbmQgd291bGQgZml0IGZvciB0aGUgc3luYyBwcm9jZXNz
LiBCdXQNCnRha2luZyBpbnRvIGFjY291bnQgdGhhdCB0aGVzZSB0d28gZmVhdHVyZXMgYXJlIHBh
cnQgYWxzbyBmcm9tIHRoZSBjb21tb24gY29yZQ0Kb2YgdGhlIEFYSSBBREMsIGluIG90aGVyIGNh
c2VzIHRoZXkgbWlnaHQgYmUgdXNlZCBzZXBhcmF0ZWx5Lg0KPiANCj4gV2hhdCBhYm91dCB0aGUg
Q05WIHNpZ25hbD8gSXMgdGhhdCBzb21ldGhpbmcgd2UgY2FuIGZ1bGx5IGNvbnRyb2wgb24gdGhl
DQo+IGZyb250ZW5kIGRyaXZlciAodGhvdWdoIGl0IGFsc28gc2VlbXMgdGhhdCBzaWduYWwgaXMg
YW4gb3V0cHV0IG9mIHRoZSBiYWNrZW5kDQo+IGRldmljZSk/DQpUaGUgQ05WIHNpZ25hbCBpcyBt
YWlubHkgdXNlZCBmb3Igc2FtcGxpbmcgKGFuIGlucHV0IHBpbiBhY2NvcmRpbmcgdG8gdGhlIGRh
dGFzaGVldCAtIA0KY29udmVyc2lvbiBpcyBpbml0aWF0ZWQgb24gdGhlIHJpc2luZyBlZGdlIG9m
IHRoZSBjb252ZXJ0IHNpZ25hbCkuDQpXZSB1c2UgaXQgb25seSBmb3IgZGV0ZXJtaW5pbmcgdGhl
IHNhbXBsaW5nIGZyZXF1ZW5jeS4NCj4gDQo+IFRoeCENCj4gLSBOdW5vIFPDoQ0K

