Return-Path: <linux-iio+bounces-5528-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED758D5E34
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 11:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A4E4B27CA8
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 09:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D5883CD5;
	Fri, 31 May 2024 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="XmlQrUN3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5CA823C3;
	Fri, 31 May 2024 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717147647; cv=fail; b=A7uU32GZt9kXCG1EUYTtSXAivkKb7sTZD1J2+ZYcsUcJ2TIPxhF8If5PNgtwGpVPqZWdEfrXO0tsUqDPMXB72/ZJU/MrVvbBFrpWh/ho7hoiyrjtptlWQt6aDj5fRXpBn3wgE65QUVnS8Org45l4SXqJn5rnN2qS4oKtQCmsB10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717147647; c=relaxed/simple;
	bh=6+W9yr/CoNFE98qDK7zkL3ynXYbL1ryeZcby4XxwNlE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SwQsiXQudeDhrt5gJK5NU39QCKJCuP1XpPqVFUUOnEBx5UmlgR1csnL80eSaldpag+Ud5+TyIRqvamwzgeioXawHvBLdGfUZduI/+4duEcbgvxlb/ZL0qcf0eWduteiDC258zOLkYPMhzYDmkJjAzxpAgxPbn6CPyzZIwPWNbvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=XmlQrUN3; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44V7VwjN030216;
	Fri, 31 May 2024 05:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=6+W9y
	r/CoNFE98qDK7zkL3ynXYbL1ryeZcby4XxwNlE=; b=XmlQrUN3wO/s+Yi1/jA7c
	Yjs/iwkOFUj7cWZovC1e7h2TzAmoQ9VobVGx+F4Yi9KL2AwwWMU8UeB6qCoyJGYw
	qVlgYRsFY8USQOZaaQ5id1ijD5h0weNZal3iTkrPiqxiTgNMynvuIDJ/wiuaGF6h
	N8f/8iL/DIiAEtfYjwcBz/rVyEpBH1prdvPHlGfHgcIRzvuJg90+H3fePul5cNga
	mtv/Nynb2oynbnLKT/JdcWrlWmb/rF9MoUiI30GE5UHCzWPxp64jt/AVcAPobV11
	ljCQovmJqd4uiv3ufSybNrRUr8HNP7Hu/Yzfgmn/2QwrYdTy4PPAiZv6GgyqKT3V
	Q==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3yb9vpyttq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 05:27:11 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXJD+DcOMUJi0rf4urLGMI3VnujH5rnOcJgcTji2Hq+0nZtSp2C1M/ncpACTT6nx6MrAJHhYTCd22rZs2q09P7YIsiPaaA/XpRau0UCyqt0DwoZMBqB++f/okLQQAJjteMPGE+Bv39EqQlOWH4fnZYmn75NxJ2PAtIe9pn6WcKDbnbByklwnFN6aZkqx8+se/7e5Km8QlFR5aCONPYsLH5VEinXXv9uGVhpekSWUCJEhngS5cw+JYkxNA8s37Xsv92nmyltL5yTh4zE15jlXG4GXcgiKASquDrK2LjRjKmtJ90LkMYFFYatRkmwrwJFnVS00L3iH92vdkFRxX0MmYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+W9yr/CoNFE98qDK7zkL3ynXYbL1ryeZcby4XxwNlE=;
 b=CYwXTGFJ9woBM8PtroCjerDanaRh8j3KURAN9pd3vuBOg/0sEEDFqLs3EkZHVgso4atsjGAYYvdUn4swzHDxTpnw6QLhb0eu/qcTLsk8jFdXpP4ek1iAj/BTycHuGW3vg/9/ldmFJrcn51i6rKEma3hhRrHERs0oKq+nK1pagHChgOmCYRbMrTpN7Ne9p5T/1HO3J8bGItrJdxIebY5NjhXEIakEpUqBcCrTLAYUtXdSMwE3b8t6WDglSxPEsUf0N38XB2u/zyODKHUjbUA1sjOdDOmY9FWq7FfpophfdL7KOtcpJOsTetzzYgniq0vIS6naO8Z5QgfCv5PksCw7OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SN6PR03MB4320.namprd03.prod.outlook.com (2603:10b6:805:fd::16)
 by SJ0PR03MB6391.namprd03.prod.outlook.com (2603:10b6:a03:38d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 09:27:09 +0000
Received: from SN6PR03MB4320.namprd03.prod.outlook.com
 ([fe80::90b:c25c:720f:7b7f]) by SN6PR03MB4320.namprd03.prod.outlook.com
 ([fe80::90b:c25c:720f:7b7f%4]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 09:27:09 +0000
From: "Nechita, Ramona" <Ramona.Nechita@analog.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v2] dt-bindings: iio: adc: add a7779 doc
Thread-Topic: [PATCH v2] dt-bindings: iio: adc: add a7779 doc
Thread-Index: AQHasmdQmWx9izOq9Em7Qs3MS8fhK7GxDhkAgAACJGA=
Date: Fri, 31 May 2024 09:27:09 +0000
Message-ID: 
 <SN6PR03MB4320402A5CF07EEB35ECE6F1F3FC2@SN6PR03MB4320.namprd03.prod.outlook.com>
References: <20240530075914.28080-1-ramona.nechita@analog.com>
 <21b8fc7a-f915-40a1-aa40-c8f91f158b1c@kernel.org>
In-Reply-To: <21b8fc7a-f915-40a1-aa40-c8f91f158b1c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: 
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jY201bFkyaHBkR0ZjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTFtTWpnek0yUXpaQzB4WmpKbUxURXhaV1l0WW1Jd1ppMHpZMlU1?=
 =?utf-8?B?WmpjME56VmlPR1ZjWVcxbExYUmxjM1JjWmpJNE16TmtNMll0TVdZeVppMHhN?=
 =?utf-8?B?V1ZtTFdKaU1HWXRNMk5sT1dZM05EYzFZamhsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXlNVGt3SWlCMFBTSXhNek0yTVRZeU1USXlOelExT0RjNU9Ua2lJR2c5SWtk?=
 =?utf-8?B?TFkyVkxkalphYVROTWJWRlJSMDR6VFhSTVFsUTRTREp6V1QwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUW1aTFpIa3dVRXhRWVVGamFXOTBWbUoyUkUxV09Y?=
 =?utf-8?B?bExhVEZXZFRoTmVGZ3dSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVSaFFWRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQk0weG9VMlpuUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
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
 =?utf-8?B?QlFVRkJRVUZDUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZCUFQwaUx6NDhMMjFs?=
 =?utf-8?Q?dGE+?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB4320:EE_|SJ0PR03MB6391:EE_
x-ms-office365-filtering-correlation-id: 99e98765-c6e2-4686-04f3-08dc8153d88b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?WW9qRmFjdkhxRXcrTGRkR3djZTFIMjI1ejFTZUx1NllHS1NYTzFwb0xXSFIv?=
 =?utf-8?B?bGFaTEwyTmVzdGdRd1VuSHdQb2dyRFp2MHRZNmRlNlMvbUFpV1JsYzJtbnZq?=
 =?utf-8?B?dlJQSU5HOWRnRG9JbnBTNW5HMzlySnhtc0JUN09lR1RMTE1BRnF0emdMVWlZ?=
 =?utf-8?B?ZFFsK2gyMDFnSkcweEJaRHhrbXgvU3ExclNuWllMTFBaSUxIQmVHYmtZKzZl?=
 =?utf-8?B?R1ZKTWdpVWxhUHFVQ0t6cm04VXFZdkZNeDZJR0FWU1l0WlQyTjlWZXl6OE45?=
 =?utf-8?B?SVlnQUtQUzFhaVRtdStCZXJMTUI4Q3g5V1N1YXpLMFBKbGNtRjJVQjZnd3pP?=
 =?utf-8?B?TE45ZW10ZTVMc1h6YTM2TVVjeTZlbXZoNzNPc1MrSENwVmpMU2l5eGxpb1VI?=
 =?utf-8?B?cm01UHQ2Q1p2ZzdoNGR5NW85ZTVzYWpBODFHQnZkNDNiWDR6OEsreldMa0ZF?=
 =?utf-8?B?TTRUd3R3WSt1NnJ2ajVkYlVyc0pDS0pVYWovZ0VhWEFCRUNyT1dPdkt4MmJ4?=
 =?utf-8?B?R3lZYVczVmMvc3BONzV2MXVoUUQyNEM3czVlSFYzTllDSWk4ckFyditKZUdX?=
 =?utf-8?B?cjBtc1BOQWkvNTdFemwzNUJjV21YaGJMZi9ydW55SVV6d2FzVS9sUURDUjJU?=
 =?utf-8?B?aFh1bmtKS09xVXZhTDljMzlwTkMxUjFvVGRpajdlYzZKWDhXOUFUZWcyQWlK?=
 =?utf-8?B?RFhHK0FpQ1JQalJXMit6VW9vd2dyQjh3Z1NWZStGdXJ2aFMzSmc1d3k2NmVm?=
 =?utf-8?B?N3VyRVV0OUU0Mk9kUHRyVmdYZ3pRcy9JSlg5MU8yb0xzc3hnQXF6SDk1aWFp?=
 =?utf-8?B?SWlQSEtpVWJQTXFyWG51eE9VRTIvME9rWVNCRDN0eEJPSko5VjIxN3FzZGts?=
 =?utf-8?B?RFl1U2xDdGRyNmUwMHp5NDJ4ZC9rQU5CQmgvNU05b0UrSDBhN0JxUlZGT3RT?=
 =?utf-8?B?aDlOc09xa3hBblRMUHpaNFZ1ZXBVZ0hLQ1VxZmFPUWErRHBrTGZoUDZpbTNB?=
 =?utf-8?B?NGREdnZsUUxDQktORnVHZHBhSXlEa1VFMlR2ZUQ2OTN4YTMxdis3R21vL2I5?=
 =?utf-8?B?OUJSdlovVG93SXJ0UXNNbEJSU3c3QVY3OUFEVUR4SGhETDJFQTRUL29zWWE0?=
 =?utf-8?B?aCswWEZtaTZFL2RteUdOVGY4WFhYaFNhcC9PdDZzUmRyTTFkQlNycFdQeXFm?=
 =?utf-8?B?WnpEckkzOVpzVnVEWTNzbFF3YmtsRXBHZDJNVEwwR05oS0QrMURCNlkvb2J1?=
 =?utf-8?B?Z0ZGL2RKMklXV09ya1dUbEVKYmZ0bm5GMVY1dmJUeFpwRnRONlFXb1BQdUxp?=
 =?utf-8?B?Q0I3MVlmTHc5a2tYUHhDYmJBNjV0azlBR1hVZzJEbmlpcC84OW5GamxwUEp6?=
 =?utf-8?B?YUtyM2plOWUvVGlIcWhCNUJHYVlDL1hXeW9GVkpNZmpNUTdGRWZlUjNrQ3Nq?=
 =?utf-8?B?TFNXTWVZVGt1am1uVHI3dnQ0L05mMm91eDFzaG5vVHQ4L3phb1Z6QlRZVktw?=
 =?utf-8?B?dk1VZnZSaXF5TTJQZnhFc1VXcjRuR2RsNmFDUTM2Zk1sRkVLK3kyK0ZvK0JE?=
 =?utf-8?B?S0x2YmUrZXBUNndaQmkyL1dlV2N4bW05dkZMZ2lpaGo0RDF5MlhzczVneUN6?=
 =?utf-8?B?UFVjeGhuQS8vYXlZaXNHbDk0QVcwK3p3d0dCa0FYaTg4RW1aRnZ3NDJQSGlr?=
 =?utf-8?B?VVcyeXc0NXNScXpuWXZlckgzVnZWWXh1US9QaFJ3a2VPQXZmemJmQVlzSHVH?=
 =?utf-8?B?ZjlrUTdxdUhKU2w1R2YyRlZWV0dsSWNOanhkVHlqU1FDTFc5bWgwUXlJMVBZ?=
 =?utf-8?B?RDVjeHlZV0hJY1B3NEp6UT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR03MB4320.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?S1JrWHNxTDhBd3gvWHJhL3gvd1RocUlVWWdyR1l3enZ3TEdkOUF4WXQyMHA3?=
 =?utf-8?B?MUpUcWE1TDA1TFV6TEs1Y1o4RFZjdU5GL280Z1BMUjhqdS9ZNm4wY3ZFcVhL?=
 =?utf-8?B?cEEzV0VKTHNzL1BidGZSS1dvT1NWRjV0azQ2V2NuSFFFMjRvaW16cWJkQmtj?=
 =?utf-8?B?UUhRaDNiWjFJTkduaEE3cmpaYktuNUhYZE8xc0tWRHpiL05ZWXlaaEc5ampq?=
 =?utf-8?B?UXhRSG5zR1ZSRitHV0gyWXp4U3krUUVvdG16cS9jSnl0S1hoK01YRnhNMVVx?=
 =?utf-8?B?ajNFYTFCa3gwODRjbXFIdzdYdElTbTRmdDRiVTROKzk0VDdldVlWMERKRFhi?=
 =?utf-8?B?S1hiNDBycHhvWVp3NzJ2T3Btek9KemE4b1U4eVdzU2t6Y0ZWR3JtTUVwQWhM?=
 =?utf-8?B?VDA2Yk1BY1B2Z0lLcnJJM3A0WDVQOUMvQUZxYVQ4QjV2TWp3V1pDUHBpaUlW?=
 =?utf-8?B?YkZVaFMvaStRVUllbDlPT1hHaDBIa0ljQkMxdzI2SklDZ2prZjdzZEx4Q2t2?=
 =?utf-8?B?N3lCR1locCtnYnFaV2V1VmZmOUwvb3pCVFA5am5kbGtLbDJHdDZTRElJNm5W?=
 =?utf-8?B?MlNCVDhHMnMxTW9vTmpCbmdoZHMvcXNKWXBoQlhyYS9sZ0pvNGJFRUpuaitz?=
 =?utf-8?B?UHBCWDVobTQ1ZzkyUFRxRmZaNXp4TEFOdmFKU0tzY3l6V2duWVBIUmE5QnRs?=
 =?utf-8?B?SkdTanV2MWVBZE02a3NRdDc0NWRHcHVIQWJrVzBtY3pzNFZKZGpYcDJrSFBR?=
 =?utf-8?B?RFBOOGp5bSs1VXJ5cm5xLzlxSmJYZE5wWU5DUnowWWRQSGgwQUdHYVZhU3Jq?=
 =?utf-8?B?YlkzYTljdG9ZWURsamtDUUs5QW5IQlFMQ3lXQUswOG8yU0kzVjRyeElWVG5w?=
 =?utf-8?B?SFRVdGRYQlZIZG5vSE5MOEhYL3JCYm03MnFjdXM0RXpTQmVxTHhGdnNQb3Yw?=
 =?utf-8?B?akRTZHV0cW95SzRCcktzK1lXQzNNbzNoV05VY1c5UWdMeEVVWHl0TzNIVmpK?=
 =?utf-8?B?dE1XUmVGeFFTdytzUSt5SUxkYk9oakloVnowbWV4ZEY0MmtJYUQ1YVR1OFV5?=
 =?utf-8?B?ckxOMHdlVzVoU1hlWG5LbnEwdVY1eklicHVzQzdVZHh3NnVsZVoyUC90OWND?=
 =?utf-8?B?MG9hTE9mSkk5SmtJSE9mMnBxSTA3UkIyakFTSTB5dXg3RTUzdTdjc2xFV2xS?=
 =?utf-8?B?UzJoZUoyQnNSUGFJQ0xRVTFSOGYrWGJtc0NHMm5zWGhseS96ZmxKenp3SDk1?=
 =?utf-8?B?c3R0c2k0VEtJd05JNS8zaXRHelJDTVcwYmJid0dmMzRya2tudFBEQlFaYWhq?=
 =?utf-8?B?OWpyUVI0bEh3dXhOajBTYmszZytGZXhIVk9JSVVkN3JMYUV0aGlYd0Q1UFV2?=
 =?utf-8?B?WjBzNkpmMVBzRW4rNWR3dXoydHZwUjYxbVdmclh4UXhsNHJmOXlxWGhZOUhR?=
 =?utf-8?B?OU55WVJYR1NwM0k1K3ZiMVd4NCtlcnQ3dmdjZEpBVC9FSVlmS0dVNGVIM3FV?=
 =?utf-8?B?dGp2dlowYWRuS1lpTFEvQzhaV3ZrSmxwMThYaDlqZEpMdVB4Zk5Xd2c4MXBY?=
 =?utf-8?B?UXo0dzZaZ3dOWjJta3FHYjROTGZXZE10U1JWSktkUi9VRElwTnZveWRGVlZX?=
 =?utf-8?B?WXhTNE5KZ2pSVmFvTUQxNzl1aUc5L1d3QzhUaDN4aURIb2puVEtGWWp0MFJw?=
 =?utf-8?B?M0FMRTVnQmJrSCtySkgva1k4SHRvalIwRHk1TVJyNzVHUjVPTFlvWXplcEM3?=
 =?utf-8?B?Nms3bUl6VjdnMitNSnZkVVlsbVp5V3dhZVRBNEcxN2Fvam9hVGFwM3I5MDdX?=
 =?utf-8?B?WmJSM1B3cngwNmNwcnBpcVQ4NkxWTzdKZXpKcEtBcEl2NVNRblhERm1JR0lQ?=
 =?utf-8?B?VDRFd2U3cFVxdzRVWHhjcS9RMUowY2tUbHBnNEdhSyt1LzdzaGZnbmxCNkZr?=
 =?utf-8?B?WXhweEZMVWt1N1c3cjZHcVk2ODNONFJXaWJCVHpIL0JzOC9FN3Y5TkJLL2dv?=
 =?utf-8?B?ekFtUWZLUG9qUTJsV2k4dmRSOWZuUEZOK3ZwM1FvU3UySitxZUdXUlluZHRn?=
 =?utf-8?B?NnZMV2VJTi9IT1RYSDV5TmV6SDRvaHdVdTBzdUxLZXVFaWVxVXQzMEZUeTVv?=
 =?utf-8?Q?cZcoTSNktsOZVz8YT8ST6QVmw?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB4320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e98765-c6e2-4686-04f3-08dc8153d88b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 09:27:09.4590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: avchIZIYfgncJlHitkJcrVmbVovKch3bOXOE/t8uvm1futt3zPbyNuOBJB19Gsyzq/a7thYW5157U2vB6yfsHIY+OGWvjzUw9fY4DCLBuBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6391
X-Proofpoint-GUID: BfHy7ebUW9dfiGPqBHT1OgzrwkcmGPpT
X-Proofpoint-ORIG-GUID: BfHy7ebUW9dfiGPqBHT1OgzrwkcmGPpT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_05,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=922 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2405310068

SGVsbG8sDQoNCkkgc2VudCB0aGUgdjIgd2l0aCB0aGUgY2xvY2stbmFtZXMgcmVtb3ZlZCwgYmVm
b3JlIHJlY2VpdmluZyB5b3VyIGVtYWlsIHJlaXRlcmF0aW5nIHRoZSBuYW1lIGNoYW5nZS4gSSBh
bSByZS1zZW5kaW5nIHRoZSB2MiBpbiBhIGZldyBtb21lbnRzIHdpdGggdGhlIGNvcnJlY3Qgc2ln
bi1vZmYuDQoNCkJlc3QgUmVnYXJkcywNClJhbW9uYQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPiANClNlbnQ6
IEZyaWRheSwgTWF5IDMxLCAyMDI0IDEyOjA0IFBNDQpUbzogTmVjaGl0YSwgUmFtb25hIDxSYW1v
bmEuTmVjaGl0YUBhbmFsb2cuY29tPjsgbGludXgtaWlvQHZnZXIua2VybmVsLm9yZw0KQ2M6IEpv
bmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+OyBMYXJzLVBldGVyIENsYXVzZW4gPGxh
cnNAbWV0YWZvby5kZT47IEhlbm5lcmljaCwgTWljaGFlbCA8TWljaGFlbC5IZW5uZXJpY2hAYW5h
bG9nLmNvbT47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93
c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5v
cmc+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gZHQtYmluZGluZ3M6IGlpbzogYWRjOiBhZGQg
YTc3NzkgZG9jDQoNCltFeHRlcm5hbF0NCg0KT24gMzAvMDUvMjAyNCAwOTo1OSwgcmFuZWNoaXRh
IHdyb3RlOg0KPiBBZGQgZHQgYmluZGluZ3MgZm9yIGFkYyBhZDc3NzkuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiByYW5lY2hpdGEgPHJhbW9uYS5uZWNoaXRhQGFuYWxvZy5jb20+DQoNClNhbWUgdjI/
IE5vdGhpbmcgaW1wcm92ZWQ/DQoNCk5hbWUgdXNlZCBpcyBzdGlsbCBub3QgZnVsbCBuYW1lLCBh
cyBJIGFza2VkLg0KDQpCZXN0IHJlZ2FyZHMsDQpLcnp5c3p0b2YNCg0K

