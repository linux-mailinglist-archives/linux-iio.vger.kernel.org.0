Return-Path: <linux-iio+bounces-6791-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A4891412F
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 06:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF103B228EE
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 04:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3F512B71;
	Mon, 24 Jun 2024 04:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="wCLvQbM/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1956211713;
	Mon, 24 Jun 2024 04:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719203946; cv=fail; b=L9y5Vpwtn6c9IqUdm1aBzc/9NciezslY2ReLup5ZtjyQRBxUzKb/W25WfRcevSb5Zlm6xGCsHYRgNHd6e0lXogSkt2kzbSfCc9++icwYWvwzY1GowLnyPOSlDcim2rXxnrR7o8vY3qk0XBCRKqlRS8NFPHtkw63wV6qupi++d3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719203946; c=relaxed/simple;
	bh=dBohT0lluIx78LQv6p9KKDnPEKPVwNqqdDSJKDF+e9o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CbRTM8Aa0vmYYUwwwZiCZsUZDq5SJCb7gDLxh2T1IMwRvhZJQzENvpxZUcEM6sIaeG3atKRLQF9x20JF83jTuNMBp1UeIbM9YSL29XoB/DCZ1DYoy+flHH7gj6VI05kwhnGqFnDdHWyOtjqBkLcX2q6F8AGDVVPAN4oHzS3mI+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=wCLvQbM/; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45NNmTLl007786;
	Mon, 24 Jun 2024 00:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=dBohT
	0lluIx78LQv6p9KKDnPEKPVwNqqdDSJKDF+e9o=; b=wCLvQbM/u0eaTcANZtbHL
	NwlNa6Sj7MnUbMf1j2u+5KAtGPbbhwiy5hiCV7pDJmtPkSbgZ0AwrfN2kuCD0dr8
	bdjf/EiSqWJwO9YjdrdOw5+rRkmWLk92imc/3rFQSM5BBAC0DPDV4cz991BPtQzk
	agRkz+wWdJaF6mSck9cmoc3/Ys+lpvQDY2hwBFWotbR6rC0DJBRcHkvBnqk0QjwI
	DIHIij4JmusaegX2xokKgopMbT7GaocPA4a8nCCUpc8cYS/z84EU0g8Y72V3vYmr
	Qk48M4qbvnkxXNFgyHvina68frcnr8ivnRxbaoH2dOWRzQ73ucu+2Re2RyHO7aQe
	A==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3ywrc8mg00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 00:38:37 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6br/XB/m+T8YjkrtapX1NPU2+SFq02tyCebJ1NngcoTVy7+2tk6tH5827qKlXhrF1Jqe24Qfy3cIKMe/6XYXmszNgUVmAjeGHEri376Nu2oRi2w4KJFdttw93lKNALNfVVh1MEurfPOhbzbXBDYe34PZd5P/DQOMihusuXNd78hUE2r74d+vB58R895p3yYkHVqxSGnrn/mkP/BCoHB/9pZjSJHYroDMwJEA8QdjHgQ7F86aD4OzumqSabg7Tz95FwPjXDkCLI5mKart98vpDmi/jKWXDKKvIpSVhvZHB3onRhL8KZw1kv2z8y3VeBsQGvsQpFV0s3muUN/3LjwDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBohT0lluIx78LQv6p9KKDnPEKPVwNqqdDSJKDF+e9o=;
 b=IwVSRXYLgy8g2jsre8JCTaciphoLkVusMG/gV6T7NKukQrQQWhJCKG7sXUO4X3RD+snZkIEsucmWYqG66tbL6ClKGhOvtLzn/n2vM3QFByqZlGxsis1udxZ/BaF/jJaWRtxloWyy53MDF9uzM3JwPMNyJ28puyyO+2wOP3Ovey/fHzu6CeAw6/7Vs1T0sYYCV+AUogqqilky+T1836t/SdxxYgGG3pYQFN8cL1Wiz8WukFtyRAF99vi9jpdnt3pC8IDVVxMAc4ypfCYQwcldatjLqtBz/6WcUz/Bk+Q4qZTcBds66G3/wR/iyY8evHezDU1dp8Wpxww29rNsum3Kgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB6224.namprd03.prod.outlook.com (2603:10b6:a03:303::18)
 by CH4PR03MB7652.namprd03.prod.outlook.com (2603:10b6:610:246::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Mon, 24 Jun
 2024 04:38:33 +0000
Received: from SJ0PR03MB6224.namprd03.prod.outlook.com
 ([fe80::1405:536e:190d:75e]) by SJ0PR03MB6224.namprd03.prod.outlook.com
 ([fe80::1405:536e:190d:75e%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 04:38:33 +0000
From: "Tinaco, Mariel" <Mariel.Tinaco@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Dimitri Fedrau <dima.fedrau@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: RE: [PATCH 0/2] add AD8460 DAC driver
Thread-Topic: [PATCH 0/2] add AD8460 DAC driver
Thread-Index: AQHaov/UvoT4VTfrXk2cjEw93f8nFLGSOK2AgERdG9A=
Date: Mon, 24 Jun 2024 04:38:33 +0000
Message-ID: 
 <SJ0PR03MB62242BD5117C5B2026CCC5D191D42@SJ0PR03MB6224.namprd03.prod.outlook.com>
References: <20240510064053.278257-1-Mariel.Tinaco@analog.com>
	<CAMknhBHd2XCJH4rgYDq=vbCL5E_tM3FxFPWbNy9PvxLCJL4tcA@mail.gmail.com>
 <20240511172155.08bc0987@jic23-huawei>
In-Reply-To: <20240511172155.08bc0987@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYlhScGJtRmpiMXhoY0hCa1lYUmhYSEp2WVcxcGJtZGNNRGxrT0RRNVlq?=
 =?utf-8?B?WXRNekprTXkwMFlUUXdMVGcxWldVdE5tSTROR0poTWpsbE16VmlYRzF6WjNO?=
 =?utf-8?B?Y2JYTm5MVGxoWW1ZeFpqWmxMVE14WlRNdE1URmxaaTA0WXpGaExUYzBNRFJt?=
 =?utf-8?B?TVRVeU0yTmxPRnhoYldVdGRHVnpkRnc1WVdKbU1XWTNNQzB6TVdVekxURXha?=
 =?utf-8?B?V1l0T0dNeFlTMDNOREEwWmpFMU1qTmpaVGhpYjJSNUxuUjRkQ0lnYzNvOUlq?=
 =?utf-8?B?RXdOalEwSWlCMFBTSXhNek0yTXpZM056VXhNVEF6TnpreE5qVWlJR2c5SW5s?=
 =?utf-8?B?SVJrSXJjMDlzUWxWMGRtMXRVbWhQVTBoM2EwdzFkRlJOUlQwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUTJSQ2JVcGtPRTFZWVVGUk1FTkxSREJ5Y0RGbE1r?=
 =?utf-8?B?UlJTVzlRVTNWdVZqZFpSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6224:EE_|CH4PR03MB7652:EE_
x-ms-office365-filtering-correlation-id: ce46cf0e-e96d-43c8-481a-08dc9407815a
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230037|1800799021|376011|7416011|366013|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?RktRV0FOQUkyc090MWhYRkFvc042TWF5bzBmZjdLMk1ndGlYY3E5Tkozd0RF?=
 =?utf-8?B?QXRpVjNhdGY2U3l1cG1OajJROWdoYm5yWktyQXJYMWg2cmpId1JORjFBK2dx?=
 =?utf-8?B?bldjS1NzVnRKZ29FWWdHNCtEQ3FVMktaRlpUWHVQdW9RNDUwdVhLWTFudHhm?=
 =?utf-8?B?Ni9jbytVUkMrWHFwU0VVMXpkT09EVWM2MWZxZ1NPeXAyZ0VxUlJQSEhEOWtq?=
 =?utf-8?B?ZWNCY3FJNXBJblhMQW9acVYveUpnd0N4VTR5QmRzNEQvR1MrbmRPTVk1NHdk?=
 =?utf-8?B?N2hTQktSVHR4MkswL2I3T1NyYTJ2ZFpwZFJIdnVUUnJidThUQy9aWTVRd016?=
 =?utf-8?B?YlBJMUE5OUx4MW1Gb1lJb1VlUVVkRy9BODNRWHpOYTBESTFpWStSM29uTGgy?=
 =?utf-8?B?blg2OHQ4STBndXdlVEZ5cFhWSHJwQmFHL3c2c2loWFVQWVlGOUFPQXlxUjJL?=
 =?utf-8?B?d2JxTjdYamh6TVg1OTEvOVpKVnp3dnZ1YTUwTllpaXFRQUx5M2N2cGJYOFRq?=
 =?utf-8?B?K2wwRmt1UGZWU2ZRZVpLSDNXWnp1M2RjaCt2NXl3bG9XVlJ4MXZhMDFHMnZS?=
 =?utf-8?B?NDNLRmh3ZmhGVy85NWZtVGV5MDVxWDlETW1NNVVJblkvZEtaV1dMNVp3L255?=
 =?utf-8?B?YzJ6ekZtUXBQTGR3ZkJXTkxyMnQ5V1V4WkQxNExQcnBtdmVnYmtPVjZIbTR2?=
 =?utf-8?B?Ui9tdW1ucDh4OTQwUnd5OUlUYUNsRTI0N3pNYlFUY1ZJUWdlRWE0Ky8xSFRk?=
 =?utf-8?B?bmlBMDhkRVBYS1F1OHMreENwSlRiTm9mQWtrbTZuWTRXWmVVMFBHV3pvZGg2?=
 =?utf-8?B?R0pzNTVvRmV4SmF0NGU1ME9mcUhvdDJQSVh2VVpwU2JnMnVYY0g0S1VvRGNp?=
 =?utf-8?B?U3VhbHdjQ2ZZcENHeFh4cDd6dXllNGsyclM1eDZQaElOallQTTdpYSt1UWt3?=
 =?utf-8?B?WkozU0NGSVN3b1lyaXEzOWYvWlFhdXhzTDFVbmw4VzR5ejRvUG1YaGh2Z2Zi?=
 =?utf-8?B?WXQrbHg1QW5nbHdtQ2FlVGhpaGZIRVNhTFVlSDVYNjBWTVNBN2FaVy9yUGJT?=
 =?utf-8?B?QnoxOGt3WXVJVTdlTzZzU2x2ckZBVlZZb0t0emU0eDlkSkl3V2RibHNXbVZO?=
 =?utf-8?B?YTczWExxMGc2aytnd0FDUEN1ZHZNaWIvNHpSRFkzVkVOcW1Xc3E5UkUrUjRO?=
 =?utf-8?B?Vkk1MjZVUVl6aVRRU1JKbGdnS2l4QWQ5RGZDRUI5OW1VaE9LM0J0VzRwaHp5?=
 =?utf-8?B?VENTc2JlUGxyb25UWGQxVkJBSkF1aFBEWDZ2aXVlbG5KTCs4MDV5VW9xWW54?=
 =?utf-8?B?S0RYRENic3VsUWYvc3FHMVRKd0psZ0VSOGJDVmsraDQ1anNCQWVpTU02QUIz?=
 =?utf-8?B?ZG1BU21vencyWjJoM3ZzalBqb29ZSFc0YTBlZ0p4bm11STJvZWZwTVFqQ3RN?=
 =?utf-8?B?L01XQWhpd2RmREVYT0hZNmJodUMrYWhUT2xydUxTaDJRUHAwN25wbFMxQUpw?=
 =?utf-8?B?OERjU3pvUEd1TW9Kck9pbVEvQWRvbFNaa0JLKzdlUlY0L2pIaHZOeEg3V3Jn?=
 =?utf-8?B?NFJWTnpOdi9OT08wMHV4RDhUS3E1dVo5aVFzSHEwZTlBZFZ1Y2trSW55dGt0?=
 =?utf-8?B?RXUvblJvMjhVMEk2VDEwb3VuZ2F6MFhKcC9kRWZuNmZwalVPVmVkK1pVL1dK?=
 =?utf-8?B?bW1QR0dDUnZXYjRlT2d3akZCeU5URHlUNnRNL2NQV0czZWlJOVJydnZkRHhI?=
 =?utf-8?B?VzBvdjB6amZvalIvT01CdU5FWktkKzd1a1J2Z2pMbFZYN0pyRHlwbHE5QTI3?=
 =?utf-8?Q?h4oQwuhGWBssg+Sxd/ff84jJVVfMOUL9DpWZI=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6224.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(7416011)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SUZWY3BWYmY0RW1oNEE1TlVxcWRhbjJDRURvNitWK1V1dUFrUUtKY1ZrWnM4?=
 =?utf-8?B?aWdrV1RIYWRqSXFmdXFhYlNnby9JRlZzT0F4T1djSVFQREV1SEt4MXQ3eWF4?=
 =?utf-8?B?SGRJM3BwM05qQXMxb1FTcEFxdGFPa0EwelQ5dStVT3Z6Y1VXUmo5Smd0OGNq?=
 =?utf-8?B?U1lCYkMzakx6TS9rWlMvaEhXeWdkRjY1azNOenFXMWE0NWZRRFV2Q0lrTmRG?=
 =?utf-8?B?ZjNIb1BWamJuQ1VVYVV1M2RBaHdxekhyVWRIaHk4TCtSb3l0Y1ZSSzFYTWVI?=
 =?utf-8?B?c01WODgydHJlRFBmanRxMmt2UWYrcHlzSURLS2JRUWIreGlKNFhob1hMcXNQ?=
 =?utf-8?B?aXFXV2o1TUVocm1nZzF3NytBdStlb1RsRVZxOUUvZ250L1d1ZjBEQWNlRVk5?=
 =?utf-8?B?c2hoaEtOTmFQMHFrZWFURHpNUUNLRjg1L3NpVkZWYkRFV1VTc0lxemhTblY1?=
 =?utf-8?B?aWJiTy82QVE3VUpZS1l3NE8xaURaaVJhTTk3QVlrTUN5OTJWcTFxL2RpRHdh?=
 =?utf-8?B?QjJ1bGptSWJESlBPQzFZbjRRM2FJZHRqU1N6TzR6dnR3YVdyTTBiSVZEcjNj?=
 =?utf-8?B?bHVFZThURS8rTktMZU1uZkdpaFIxT2xBVEZ5ZU81Q1ZCRGxEUVZtaUlFcURM?=
 =?utf-8?B?eVMvUVBTdGhYYnVKYjdweHNFaENoeVUyY3BocjR0V2tVQitHZnBwc0FmVXJO?=
 =?utf-8?B?b2JOb1ZrUVFNdkg1RzNXc1dnMmU4Q2w4OTFKT2thVUtEVm1nTHpUUCtncjdl?=
 =?utf-8?B?aFNVSTVkc280aVVEazl4ZWhqZnR4eEhYeGpQN29MdEtJWEpWZ3hYNzhBQVZI?=
 =?utf-8?B?TXFNb2laeGtNUkFFcVc0ZVFuYUZZR1I5aHZBUklUckllbGRNalJnYkh6Q2tE?=
 =?utf-8?B?eklKUnJLbHpWN0pJWEVNZVBidFNaMWZQODhvVGFnM3BZVFIrL3pPN2NzZHdu?=
 =?utf-8?B?MDBKTld0eDNRME1VdmtnaGRyU09TTEJPOTRNZGlpbm1lbVpWejhlZ0lmNkti?=
 =?utf-8?B?ek40alNTODYzRU5VbVJCTDc1SEVlYnVQcitiK1lNdUxNYlIrU250V1QyTGZl?=
 =?utf-8?B?THZSZXZ3eVc5OEpqKzlGODBpQmMwS3Q4QUJnTzRnWEdnR1hMNmkzMmhSZXJE?=
 =?utf-8?B?ZFMwTWpjZytCbHRJRkxXTTBVb1o4ejJkOHR5S05WOFZWR2hsV2V2NC8yZFh3?=
 =?utf-8?B?WFA2UUEyeVAxVG5xRTU5a3ZZdmpNQWQwYjNLWmpzejlVdDRLMUlXZVBwaTJk?=
 =?utf-8?B?Qk1mRW5nZ0pQQ3hOZktzT1NiSW1jclFIc1FEa2VGSTVSZ2wzU3phYkNMVmYz?=
 =?utf-8?B?OVdYN3RxL2VoV3ZYRjlNMXMwWjVIWTJGQTJqMTZCa1hncDVzdmNURUR3djhm?=
 =?utf-8?B?d2Y1cHVUSVI4TENnb1dhT3U0VGh1R2lTSWxkS2ZpUjRUdDNqdnUwLzNDdnBF?=
 =?utf-8?B?RWFQRnoxZXNDeVlhYzhLNVdkeVVRUFZRSUhDenBFU2ZwVWZwQ0FxalNOQ28w?=
 =?utf-8?B?eTVnRHh3bFoxTkxwbDdsRDl6WnJSY09TVWJ3dmhZTlU4ZHl0eUFlYUJCbHpI?=
 =?utf-8?B?R2txNzhxWjVqNkFoVG9yclpPZUYwblZFUUZFM1BZY2pYOEM3VGE2cDZkSEJS?=
 =?utf-8?B?cWtEVDFYMVZGRU5nRHI0VHRrZTYzcHkvK1k0ajB0MEdJWUVndE1qcXpOaUFY?=
 =?utf-8?B?MVB6ZWVYMWkvOVhDZ1U5ejlvTTlTa2FlWjMrdGdSSWl3KzRGSlpCN2tPSU1Q?=
 =?utf-8?B?Tk5SVTJCUFVTanp2RUNndDR4S0hGVFJNWlVndSszYmV2NUFmUjdGTnN4WnFS?=
 =?utf-8?B?NkxYZDR1ak5nMlZYa0FQcloxUU1SSTVPMlczclFXMytPWFBoL0V5bjR4dlZ6?=
 =?utf-8?B?Z1RUOGd1THcrQmRaRFJtT0gvcDJxRnNXRVNHUmI0NkU3WTBLa2NHelJzRFlY?=
 =?utf-8?B?ak1OUEVMVlFKUDA2SjZNZHl0MjBMZnpvNjJuRTlweXJVZkphK01Vc2VXT2Fi?=
 =?utf-8?B?ZDFLUmZKd1ZUeE5RSU04YkJJRER3TWN5MGxQbWJVbG5zcXVLRUVFMkUwRWxK?=
 =?utf-8?B?eWRTTzl4WklhQytFSUdEMnpQVHpiVkREK0JWeW9ySFpkRzB0cSt2bWd0T2tw?=
 =?utf-8?Q?cB8QAWkxhR+7pRFKoD+AcX6Ya?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6224.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce46cf0e-e96d-43c8-481a-08dc9407815a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 04:38:33.5121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gQBZG0ym3jNp6nwOS+EUGC6BO45YZJGR56tFb8nJZdXX4RjQHZ1m5SQzYVdCETRaX8iFEY5o7OlqrQZxcnHHWZOqLLXmPey9k8N9WCysL4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7652
X-Proofpoint-GUID: FZkwbcsPnRCH3wqt2HSEmtIzI8P04l40
X-Proofpoint-ORIG-GUID: FZkwbcsPnRCH3wqt2HSEmtIzI8P04l40
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_04,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240035

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJv
biA8amljMjNAa2VybmVsLm9yZz4NCj4gU2VudDogU3VuZGF5LCBNYXkgMTIsIDIwMjQgMTI6MjIg
QU0NCj4gVG86IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT4NCj4gQ2M6IFRp
bmFjbywgTWFyaWVsIDxNYXJpZWwuVGluYWNvQGFuYWxvZy5jb20+OyBsaW51eC1paW9Admdlci5r
ZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgTGFycy1QZXRlciBDbGF1c2VuDQo+IDxsYXJzQG1ldGFmb28uZGU+OyBS
b2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraQ0KPiA8a3J6
aytkdEBrZXJuZWwub3JnPjsgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgTGlh
bSBHaXJkd29vZA0KPiA8bGdpcmR3b29kQGdtYWlsLmNvbT47IE1hcmsgQnJvd24gPGJyb29uaWVA
a2VybmVsLm9yZz47IEhlbm5lcmljaCwNCj4gTWljaGFlbCA8TWljaGFlbC5IZW5uZXJpY2hAYW5h
bG9nLmNvbT47IE1hcmNlbG8gU2NobWl0dA0KPiA8bWFyY2Vsby5zY2htaXR0MUBnbWFpbC5jb20+
OyBEaW1pdHJpIEZlZHJhdSA8ZGltYS5mZWRyYXVAZ21haWwuY29tPjsNCj4gR3VlbnRlciBSb2Vj
ayA8bGludXhAcm9lY2stdXMubmV0Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAvMl0gYWRkIEFE
ODQ2MCBEQUMgZHJpdmVyDQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBGcmksIDEwIE1heSAy
MDI0IDEyOjMwOjQ2IC0wNTAwDQo+IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNv
bT4gd3JvdGU6DQo+IA0KPiA+IE9uIEZyaSwgTWF5IDEwLCAyMDI0IGF0IDE6NDLigK9BTSBNYXJp
ZWwgVGluYWNvIDxNYXJpZWwuVGluYWNvQGFuYWxvZy5jb20+DQo+IHdyb3RlOg0KPiA+ID4NCj4g
PiA+IFRoZSBBRDg0NjAgaXMgYSAxNC1iaXQsIGhpZ2ggcG93ZXIgKy00MFYgMUEsIGhpZ2gtc3Bl
ZWQgREFDLCB3aXRoDQo+ID4gPiBkdWFsIGRpZ2l0YWwgaW5wdXQgbW9kZXMsIHByb2dyYW1tYWJs
ZSBzdXBwbHkgY3VycmVudCBhbmQgZmF1bHQNCj4gPiA+IG1vbml0b3JpbmcgYW5kIHByb3RlY3Rp
b24gc2V0dGluZ3MgZm9yIG91dHB1dCBjdXJyZW50LCBvdXRwdXQNCj4gPiA+IHZvbHRhZ2UgYW5k
IGp1bmN0aW9uIHRlbXBlcmF0dXJlLg0KPiA+ID4NCj4gPiA+IFRoZSBmYXVsdCBtb25pdG9yaW5n
IGFuZCBzaHV0ZG93biBwcm90ZWN0aW9uIGZlYXR1cmVzIHdlcmUgc3VwcG9ydGVkDQo+ID4gPiBp
biB0aGUgZWFybGllciB2ZXJzaW9ucyBvZiB0aGUgSUlPIGRyaXZlciBidXQgd2FzIHNjcmFwcGVk
IGR1ZSB0bw0KPiA+ID4gdW5jZXJ0YWludGllcyBpZiB0aGUgZnVuY3Rpb25hbGl0aWVzIGJlbG9u
ZyB0byB0aGUgSUlPIGRyaXZlci4NCj4gPiA+IEhvd2V2ZXIsIGl0IHdvdWxkIGJlIGJlc3QgdG8g
aW1wbGVtZW50IGl0IGZvciB0aGUgZGV2aWNlJ3MgcXVhbGl0eQ0KPiA+ID4gb2YgbGlmZS4gSSdk
IGxpa2UgdG8ga25vdyBpZiBpdCdzIGJldHRlciBzdWl0ZWQgYXMgYSBzdGFuZC1hbG9uZQ0KPiA+
ID4gSFdNT04gZHJpdmVyLg0KPiANCj4gVGhhdCBwcm9iYWJseSBkb2Vzbid0IG1ha2Ugc2Vuc2Uu
ICBUaGlzIHJlcGx5IGJ0dyBpcyBiYXNlZCBvbiB0aGUgdGV4dCBoZXJlLiBJDQo+IGhhdmVuJ3Qg
eWV0IGxvb2tlZCBpbiBkZXRhaWwgYXQgdGhlIGRhdGFzaGVldC4NCj4gDQo+IFNvbWUgZmF1bHQg
Y29uZGl0aW9ucyBhcmUgcmVsYXRpdmVseSBlYXN5IHRvIG1hcCB0byB0aHJlc2hvbGQgZXZlbnRz
IG9uIGFuIGlucHV0DQo+IGNoYW5uZWwuICBUaGUgb25lcyB0aGF0IGFyZSBoYXJkZXIgYXJlIHRo
aW5ncyBsaWtlIHNob3J0IGNpcmN1aXQgZGV0ZWN0b3JzIHdoZXJlIGl0J3MNCj4gaGFyZCB0byBr
bm93IHdoYXQgdGhlIGFjdHVhbCB0aHJlc2hvbGQgaXMuDQoNClVwb24gY2hlY2tpbmcgdGhlIElJ
TyBUaHJlc2hvbGQgZXZlbnRzLCB0aGUgZmF1bHQgY29uZGl0aW9ucyBjYW4gZWFzaWx5IGJlIG1h
cHBlZC4NCkJ1dCBJIGhhZCB0byBhZGQgQ3VycmVudCBhbmQgVGVtcGVyYXR1cmUgY2hhbm5lbHMN
Cg0KPiBUaGUgb3RoZXIgcGxhY2Ugd2UgYXJlIGxpbWl0ZWQgaXMgaW4gbXVsdGlwbGUgbGV2ZWxz
IGZvciB0aGUgc2FtZSB0aGluZy4gIFNvDQo+IHdhcm5pbmcgYW5kIGZhdWx0IGxldmVscy4gVGhh
dCBzdHVmZiBpcyBoYW5kbGVkIG11Y2ggYmV0dGVyIGJ5IGh3bW9uIHdoZXJlDQo+IHRoZXNlIHRo
aW5ncyBhcmUgbW9yZSBjb21tb24uDQo+IFRoZSBpc3N1ZSB3ZSBoYXZlIGlzIHRoYXQgdGhlIGV2
ZW50IGVuY29kaW5nIGlzIGEgYml0IHRpZ2h0IGJ1dCB3ZSBjb3VsZCBzZWUgaWYNCj4gdGhlcmUg
aXMgYSB3YXkgdG8gYWRkIHRoZXNlLg0KDQpGb3J0dW5hdGVseSwgdGhlcmUgd2VyZW4ndCBtdWx0
aXBsZSBsZXZlbHMgb2YgZmF1bHQgbW9uaXRvcmluZyBhcyBjaGVja2VkIGluIHRoZQ0KZGF0YXNo
ZWV0DQoNCj4gPiA+DQo+ID4gPiBUaGUgZm9sbG93aW5nIGFyZSB0aGUgY29uZmlndXJhYmxlIGFu
ZCByZWFkYWJsZSBwYXJhbWV0ZXJzIHRocm91Z2gNCj4gPiA+IFNQSSB0aGF0IGNvdWxkIGJlIGlt
cGxlbWVudGVkIG9uIHRoZSBIV01PTiBkcml2ZXI6DQo+ID4gPiAgICogQW4gZW5hYmxlIGJpdCB0
byBhcm0vcHJvdGVjdCB0aGUgZGV2aWNlIG9uIG92ZXJjdXJyZW50LA0KPiA+ID4gb3ZlcnZvbHRh
Z2Ugb3Igb3ZlcnRlbXBlcmF0dXJlIGV2ZW50cy4gVGhlIGRldmljZSBpcyBzaHV0IGRvd24gdXBv
bg0KPiA+ID4gZGV0ZWN0aW9uLg0KPiANCj4gV2UgZG9uJ3QgaGF2ZSBhIGdvb2Qgd2F5IHRvIGhh
bmRsZSByZXN0YXJ0aW5nIGZyb20gc2h1dGRvd24sIGJ1dCBwZXJoYXBzIHdlDQo+IGNvdWxkIHVz
ZSBhbm90aGVyIGFjdGlvbiB0byBzaWduYWwgdGhhdCAtIG1heWJlIGV2ZW4gZ29pbmcgYXMgZmFy
IGFzIHNheWluZyB0aGF0DQo+IHRoZSBkcml2ZXIgc2hvdWxkIGJlIHJlbG9hZGVkLg0KPiANCj4g
QXMgZm9yIHRoZSB0aHJlc2hvbGRzLCB0aGV5IHNvdW5kIGxpa2UgdGhlIG1hcCB0byBJSU8gZXZl
bnRzIHJlYXNvbmFibHkgd2VsbC4NCj4gDQo+ID4gPiAgICogQSBjb25maWd1cmFibGUgcmFuZ2Uv
dGhyZXNob2xkIGZvciB2b2x0YWdlLCBjdXJyZW50IGFuZA0KPiA+ID4gdGVtcGVyYXR1cmUgdGhh
dCByYWlzZXMgYWxhcm0gd2hlbiBleGNlZWRlZCB3aGlsZSB0aGUgZGV2aWNlIGlzDQo+ID4gPiBh
cm1lZC4NCj4gDQo+IFRoYXQgbWFwcyBmaW5lIHRvIHRoZSBJSU8gZXZlbnQgdGhyZXNob2xkIGNv
bnRyb2xzLg0KPiANCj4gPiA+ICAgKiBGbGFncyB0aGF0IGNhbiBiZSBwb2xsZWQgdG8gcmFpc2Ug
YWxhcm0gdXBvbiBkZXRlY3Rpb24gb2YNCj4gPiA+IG92ZXJjdXJyZW50LCBvdmVydm9sdGFnZSBv
ciBvdmVydGVtcGVyYXR1cmUgZXZlbnRzLCBhbmQgYXBwbHkNCj4gPiA+IGFkZGl0aW9uYWwgcHJv
dGVjdGl2ZSBtZWFzdXJlcy4NCj4gVGhlIHNwZWNpZmljIG5lZWQgdG8gcG9sbCBpcyBhd2t3YXJk
IGJ1dCB5b3UgY291bGQgZG8gaXQgZWFzaWx5IGVub3VnaCBpbiBkcml2ZXINCj4gYW5kIHVzZSB0
aGUgSUlPIGV2ZW50IHN0dWZmIHRvIHNpZ25hbCBhbnkgZXZlbnRzIGRldGVjdGVkLg0KPiANCj4g
DQo+ID4gPiAgICogUHJvZ3JhbW1hYmxlIHF1aWVzY2VudCBjdXJyZW50IChvcHRpb25hbCkNCj4g
Q291bGQgcHJvYmFibHkgZmlndXJlIG91dCBhIHN1aXRhYmxlIGNvbnRyb2wgZm9yIHRoaXMsIGJ1
dCBJJ20gbm90IGVudGlyZWx5IHN1cmUNCj4gd2hhdCBpdCBpcyA6KQ0KDQpUaGlua2luZyBhYm91
dCBpdCwgd291bGRuJ3QgdGhlIHJhdyBhdHRyaWJ1dGUgYmUgYSBzdWl0YWJsZSBjb250cm9sIGZv
ciB0aGlzPyBUaGlzIA0KVmFsdWUgaXMgcmVsYXRpdmUgdG8gbm9taW5hbCBzdXBwbHkgY3VycmVu
dCBhbmQgYWN0cyBhcyBhICJtb25vdG9uaWMgYnV0IG5vbmxpbmVhciINCm11bHRpcGxpZXIuIEEg
cmVnaXN0ZXIgdmFsdWUgbWFwcyB0byBhIGN1cnJlbnQgbGV2ZWwgZnJvbSAwIHRvIDIgdGltZXMg
dGhlIG5vbWluYWwNCmN1cnJlbnQgc3VwcGxpZWQuIEkgYWxzbyB0aG91Z2h0IHRoYXQgaXQgY291
bGQgYmUgaGFyZHdhcmUgZ2FpbiBidXQgdGhlIGdhaW4NCmNvbXB1dGF0aW9uIHdhc24ndCBleHBs
aWNpdGx5IGluZGljYXRlZCBpbiB0aGUgZGF0YXNoZWV0IGFuZCB0aGVyZSBpcyBub3QgeWV0DQoi
Y3VycmVudF9oYXJkd2FyZWdhaW4iIGF0dHJpYnV0ZSBhdmFpbGFibGUgaW4gdGhlIEFCSS4gU28g
SSBzZXR0bGVkIHdpdGggcmF3LiBJDQpUaGluayB0aGVyZSB3b3VsZCBvbmx5IGJlIGFuIGlzc3Vl
IG9mIHdlIGV4cG9zZSB0aGUgInByb2Nlc3NlZCIgYXR0cmlidXRlDQpCZWNhdXNlIGl0IGhhcyBh
IHBhcnRpY3VsYXIgY29tcHV0YXRpb24uIEJ1dCBJJ20gbm90IHBsYW5uaW5nIHRvIGV4cG9zZSB0
aGUgDQpQcm9jZXNzZWQgYXR0cmlidXRlDQoNCj4gPiA+ICAgKiBUaGVybWFsIG1vbml0b3Jpbmcg
aXMgZG9uZSBieSBtZWFzdXJpbmcgdm9sdGFnZSBvbiBUTVAgcGluDQo+ID4gPiAodW5saWtlbHkg
dG8gYmUgaW5jbHVkZWQpDQo+DQo+IElmIHlvdSBkaWQgd2FudCB0bywgdGhlIHVzdWFsIHRyaWNr
IGZvciB0aGVzZSBpcyB0byBpbmNsdWRlIGFuIG9wdGlvbmFsIHVzZSBhcyBhDQo+IGNvbnN1bWVy
IG9mIGFuIElJTyBwcm92aWRlciB3aGljaCB3b3VsZCBiZSBhIHNlcGFyYXRlIEFEQy4NCg0KSSBp
bmNsdWRlZCB0aGlzIGluIG15IGN1cnJlbnQgcmV2aXNpb24sIHRoYW5rcyBmb3IgdGhlIGlkZWEu
IEFsdGhvdWdoIHRoZSBvcHRpb25hbCB1c2UNCklzbuKAmXQgeWV0IGF2YWlsYWJsZSBpbiB0aGUg
Y29uc3VtZXIgQVBJLiBNeSBxdWVzdGlvbiBpcywgaW4gY2FzZSB0aGUgQURDIGNoYW5uZWwgdG8g
cmVhZA0KVGhlIFRNUCBwaW4gaXMgbm90IGF2YWlsYWJsZSwgc2hvdWxkIEkgc3RpbGwgbWFrZSB0
aGUgdGVtcCByYXcgdmFsdWUgYXZhaWxhYmxlIGFuZA0KU2V0IHRvIDA/IE9yIHNob3VsZCB0aGUg
dGVtcCByYXcgYXR0cmlidXRlIGJlIHVuYXZhaWxhYmxlIG9yIHVubGlzdGVkIGNvbXBsZXRlbHkg
ZnJvbQ0KSUlPIEluZm8uDQo+ID4gPg0KPiA+DQo+ID4gQWRkaW5nIG15c2VsZiB0byB0aGUgY2M6
IGhlcmUgc2luY2UgSSdtIGludGVyZXN0ZWQgdG8gc2VlIHdoYXQNCj4gPiBKb25hdGhhbiAob3Ig
YW55b25lIGVsc2UpIGhhcyB0byBzYXkgYWJvdXQgdGhlIGZhdWx0IG1vbml0b3JpbmcuDQo+IA0K
PiBKb25hdGhhbg0K

