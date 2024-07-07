Return-Path: <linux-iio+bounces-7419-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B23929A41
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 01:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844FD1F2133D
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 23:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE456F2E5;
	Sun,  7 Jul 2024 23:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="RjiFLQmF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6274524F;
	Sun,  7 Jul 2024 23:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720395188; cv=fail; b=ooO21i/5TojnYb3gmQnJDAAQbfN03w6aHyZphJfOC3hlGyYxpQorIMLLPre2YWyy8QjKZoIaXJ4Qe0649oqkr2yE1wK8yaDaffYdyILKxPxGpI2arOQMdOhW2/etjuyqkc+mXIOk4WuSgw3/0VAGi9Qe7Yl+iRj5XTfhiQFnte4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720395188; c=relaxed/simple;
	bh=iVQfQVGknZG1clY51IziFaisO4J6gxijwy8yuJs7dcw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U7AptczqzJXDh/nOpEyXusLSQkIumxLzAYKPn9Ra8D4kOmX0p/dJZnBM6o/RE49kYRFtRpkyOV9LcYZmVKPE+yq4/wmBkyPUd9OEXGUzELLZIYkkYwEtj2mez6YzzfKn+7xDzUv2vXP5/FqpwNJrzwtdXDPx2FXjOV/8bExeHfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=RjiFLQmF; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 467B7XAe031379;
	Sun, 7 Jul 2024 19:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=iVQfQ
	VGknZG1clY51IziFaisO4J6gxijwy8yuJs7dcw=; b=RjiFLQmF/MnlZOUDvHwXJ
	yl3tj0pb0VRVY8bbEdH2kaYK+92dWwQO9Q0f0Zu+TzwzdJQ++LTwqF9E4U6RO+34
	KZqim4xLWvqXMKbmendjoWEqiOfkzmRd0W0dUIu07Kb+ghTkCPUoaCPQ+2WeMuwy
	Zr22DFAqrdrZePmjJrAKaiAlc95ElIGRlTVcoNtoCHnxL4AXbnu4xNSXr1gzHzNz
	fGKveAwmySfS1s+/SrqHUTDjj7NTMd5IlLvZ8AlpQWb1l+r8a0TMWG9HNhCZXWDK
	+C1h2U5pt+DU3MCZwtHLXHYvTChp1KlwrhO3RhwKrUCtHCjm2lBx7dZH++SZOE13
	A==
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4072u1kjfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 19:32:27 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Am8RaeYKAA237Mg+YZr7DtiTlHiUzv1g2HeXwVa8f+8izKPWEmmZF4Yt5YwpgHEHC9X2k4yUEhZaE9kA21e/SnZMjb88AGheqBImsqMu/RkgXUKRg5yggYloJLrPxcrrizsLUun1NxkaicClcmyuGYTry7RKY8olmrGXMB0rp0Q/XW425n0ymn4QpSejd4ARSJ2AJkPacPw1XxT1C/fYKdHqHE28hc70JkoAoD2EwTtgNAYpj9weYWh38gAq4LNp8IPy65SzA7Mb8Zhs+/NHXHqSWaBfvjgWzh5fcAEyAHV2NX1+6x6DNIFNwfCnPkg0KIQ9nqWmPzjT6tUha0oMwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVQfQVGknZG1clY51IziFaisO4J6gxijwy8yuJs7dcw=;
 b=Ww7tgt+J1NNAbWQmDdll3l0AfSD1CQg0cchPSMsvx/812r7kdPTGjKKrMeC8rIpLVaWq6zNPdyctE6GqzzyxQe6oCaVSYzhtC6+qSfwXPQ40cg+Ej6nDsjE5oe0Pua90Bb+1bIxvb3FkHuKoSj5mPIVumNkODgVD8YiD8uK2Zb+wXGIhAsHYXUJ+dV/qoIC2j7xIGyS1hfMh+fe/01FfC9azXeNoU/WAj1xyC2xCuLfrVOBK3MM3qJVJv2xeGVQknkG6TKlM/4fdLtcWh0+d8wqjaadJl0tFgl0FNfjRm3CA2fP5rF3ncyYVufXawEVwZrewXjFsH6YjRZ+dEzBkWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from DM8PR03MB6213.namprd03.prod.outlook.com (2603:10b6:8:39::15) by
 SJ0PR03MB5695.namprd03.prod.outlook.com (2603:10b6:a03:2d3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.34; Sun, 7 Jul 2024 23:32:25 +0000
Received: from DM8PR03MB6213.namprd03.prod.outlook.com
 ([fe80::b2a3:6794:84a4:b6b1]) by DM8PR03MB6213.namprd03.prod.outlook.com
 ([fe80::b2a3:6794:84a4:b6b1%6]) with mapi id 15.20.7741.033; Sun, 7 Jul 2024
 23:32:24 +0000
From: "Tinaco, Mariel" <Mariel.Tinaco@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
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
Subject: RE: [PATCH 2/2] iio: dac: support the ad8460 Waveform DAC
Thread-Topic: [PATCH 2/2] iio: dac: support the ad8460 Waveform DAC
Thread-Index: AQHao8JvQg6+h8gTiUiRiY/wSfSRo7HWmXKggAc3TACADnL84A==
Date: Sun, 7 Jul 2024 23:32:24 +0000
Message-ID: 
 <DM8PR03MB621392355B8871452D7F9DA491D92@DM8PR03MB6213.namprd03.prod.outlook.com>
References: <20240510064053.278257-1-Mariel.Tinaco@analog.com>
	<20240510064053.278257-3-Mariel.Tinaco@analog.com>
	<20240511174405.10d7fce8@jic23-huawei>
	<SJ0PR03MB6224D9A14475071E8A1D921A91D42@SJ0PR03MB6224.namprd03.prod.outlook.com>
 <20240628195106.215839df@jic23-huawei>
In-Reply-To: <20240628195106.215839df@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?utf-8?B?UEcxbGRHRStQR0YwSUdGcFBTSXdJaUJ1YlQwaVltOWtlUzUwZUhRaUlIQTlJ?=
 =?utf-8?B?bU02WEhWelpYSnpYRzEwYVc1aFkyOWNZWEJ3WkdGMFlWeHliMkZ0YVc1blhE?=
 =?utf-8?B?QTVaRGcwT1dJMkxUTXlaRE10TkdFME1DMDROV1ZsTFRaaU9EUmlZVEk1WlRN?=
 =?utf-8?B?MVlseHRjMmR6WEcxelp5MHlPRGRrTUdZd05TMHpZMkk1TFRFeFpXWXRPR014?=
 =?utf-8?B?WkMwM05EQTBaakUxTWpOalpUaGNZVzFsTFhSbGMzUmNNamczWkRCbU1EY3RN?=
 =?utf-8?B?Mk5pT1MweE1XVm1MVGhqTVdRdE56UXdOR1l4TlRJelkyVTRZbTlrZVM1MGVI?=
 =?utf-8?B?UWlJSE42UFNJeE1ESTFNQ0lnZEQwaU1UTXpOalE0TmpnM05ESTNPVFExTkRJ?=
 =?utf-8?B?NUlpQm9QU0pqUzBvMlMxUmFVbXhsUlVsM1MzUklSR01yV2tsa1VDdFRPV005?=
 =?utf-8?B?SWlCcFpEMGlJaUJpYkQwaU1DSWdZbTg5SWpFaUlHTnBQU0pqUVVGQlFVVlNT?=
 =?utf-8?B?RlV4VWxOU1ZVWk9RMmRWUVVGRVowUkJRVVJXUVRsbWNYaGtSR0ZCVm14dFFU?=
 =?utf-8?B?QndkVTlWUWt0WFYxbEVVMjAwTlZGRmIwUkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlNFRkJRVUZFWVVGUlFVRlRaMGxCUVU4MFFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUlVGQlVVRkNRVUZCUVROTWFGTm1aMEZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVbzBRVUZCUW1oQlIxRkJZVkZDWmtGSVRVRmFVVUpxUVVoVlFX?=
 =?utf-8?B?Tm5RbXhCUmpoQlkwRkNlVUZIT0VGaFowSnNRVWROUVdSQlFucEJSamhCV21k?=
 =?utf-8?B?Q2FFRkhkMEZqZDBKc1FVWTRRVnBuUW5aQlNFMUJZVkZDTUVGSGEwRmtaMEpz?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZGUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVdkQlFVRkJRVUZ1WjBGQlFVZEZRVnBCUW5CQlJqaEJZM2RD?=
 =?utf-8?B?YkVGSFRVRmtVVUo1UVVkVlFWaDNRbmRCU0VsQlluZENjVUZIVlVGWmQwSXdR?=
 =?utf-8?B?VWhOUVZoM1FqQkJSMnRCV2xGQ2VVRkVSVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlVVRkJRVUZCUVVGQlFVTkJRVUZCUVVGRFpVRkJRVUZaVVVKclFV?=
 =?utf-8?B?ZHJRVmgzUW5wQlIxVkJXWGRDTVVGSVNVRmFVVUptUVVoQlFXTm5RblpCUjI5?=
 =?utf-8?B?QldsRkNha0ZJVVVGamQwSm1RVWhSUVdGUlFteEJTRWxCVFdkQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRa0ZCUVVGQlFVRkJRVUZKUVVGQlFVRkJUelJC?=
 =?utf-8?B?UVVGQlFVRkJRVUZEUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZCUVVGQlowRkJR?=
 =?utf-8?B?VUZCUVVGQlFYcG5RVUZCUVUxQlFVRkNUMEZCUVVGQlFVRkJRVWRGUVZwQlFu?=
 =?utf-8?Q?BBRjhB?=
x-dg-rorf: true
x-dg-refone: 
 Y3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3Qm1BR0VBYkFCekFHVUFYd0JtQUc4QWN3QnBBSFFBYVFCMkFHVUFBQUE4QUFBQUFBQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQThBQUFBQUFBQUFHRUFaQUJwQUY4QWN3QmxBR01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlBRElBQUFBPSIvPjwvbWV0YT4=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR03MB6213:EE_|SJ0PR03MB5695:EE_
x-ms-office365-filtering-correlation-id: a8472b8f-cefc-4253-18c5-08dc9edd0e8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?anlPRWpCZ0g5aVR4M0t1MmhXQk9kYmFIaUJRdHhidmNnN3I3YWRjdEFwZEEy?=
 =?utf-8?B?a0M3aWM2QWd2cTl5a1FWSU0rN1BYbW5mRmJKVitjZWtTNXdSR004Zkp0NGtt?=
 =?utf-8?B?VUhsRGthODZKL3dKY2d0LzV4T3dndlBWZzhvanlsaXI0M25KZE9lRDV4ZnRQ?=
 =?utf-8?B?NUtvTjBNbGlWNzF0MzJhbUZTcVhMaUd0OE51T3lKdC92SldUOU55clhPcDUx?=
 =?utf-8?B?RVY5ZVh5OGpxZ2FybXBoU3ZOMnVmNWVwVlhjbm8wdlVJbWpRMDVWM3UzQ3h2?=
 =?utf-8?B?TE9leHFLaGViZDZIaFJKTjV1WldWbyttR2wxQTJYYlRtbDlCazJEeW45Z0xN?=
 =?utf-8?B?OTBPSjMzaS94dzIzV2llcXV1QmF0c3lTd3ZMQVpPMFB4UmVGWjMvaFN0OEZs?=
 =?utf-8?B?b3JxM2hzaG1RVC9XT2NXWlUrZWIwM1lxcWUxSG9pRFpYajJVU2xhL0hTVElk?=
 =?utf-8?B?VS9ZL3MzY3EwbExCWXg1Z0VLY2d4UTVFa1htVUFwYXdtaWtwTExHK1hJb3Mw?=
 =?utf-8?B?MzVGQlFUQmJ3c25tRjBXdWpqK0NiQjV4dFpqZWlpdmlLNURJclViZndCQkIx?=
 =?utf-8?B?MFdvUGwyZ3lxanZlY3pLaTlUZDIyZmE4UENZQXRKV0hYN3dEYVQzM2VwK3Nt?=
 =?utf-8?B?ZVNPOW9rNGJvZHE1UG1nNWJ5Z010V3VUbG9OQWw5a09iRTY4cHN1ajJNRUVl?=
 =?utf-8?B?ZThHc0w3NFh3endvZHliUnZPZHVUYlU4alhFN1ZwKzhyRFNQTzRaM1JHcHhK?=
 =?utf-8?B?bnFtemZ0ZVJ3b1ArUklOam9QdFdlL3hOMXRHZUpvT1RFc2RnTEVhQXlkemxC?=
 =?utf-8?B?RDR0V3ZVcVFKZkNQMVhMdTJBcmRuaG9YTllXMWFUTVM3Uyt3Q0lIemwwdTZl?=
 =?utf-8?B?d2E1cCtzemdnY0tlZXZoWWNabzJyQ0U5RmluWnpSa3ZKaER3Nms2Q1dqbjZh?=
 =?utf-8?B?WFNGbEpDS1JWaE5ER1FwZTRaUkE5Ui92NExxM0VUMjZTUXFjR3J6ejdaV0N1?=
 =?utf-8?B?NkIyZlNVV25jSmxBQmpOeTBUQkl6VTJLeUFNTWYvR1VYem56WEZFbzdwTW1v?=
 =?utf-8?B?MnQ3cVJNNTBxMElYOVBBNmhmUmVYek81QlAxcmY4Rk9mczU3aC9sNGFBUExy?=
 =?utf-8?B?MzlpSnVvbVovQURSZ2xBbWJLUzNZYUZucXFYdWVEM1ZrTGtlTUNKZ2MrbTI2?=
 =?utf-8?B?SWswTzNWTGdaVnVhcTFkcFRDQ01jZUpSS05VVzN3Ykpta1RrWG1nY1FrWmx1?=
 =?utf-8?B?M2FGblZmem9XT0ZacnNVVWwyWEdZeFRpQWM1cThEN0dndVU3SnpjalA5Ryt2?=
 =?utf-8?B?d3ZaZ095V2NlT2JjRWN6QzN5aTExOWZ2QlFNa3BCZytNdnpHWkovUUIwWHpU?=
 =?utf-8?B?MENJM1JiVDBGSnFNNE5ZMUtpRUZtR01CZjk5UGQ0VEpEVVlYZFpIaFg2Z0VD?=
 =?utf-8?B?MGZBblRwRUNvaGk4Z1RabW9aaW9LY3Qreld1VEFUSndJNlBJcWM5cWtwdHEz?=
 =?utf-8?B?eFRHOHdicExMTFpCODNnbmtHV1c0dyt4SFNic1hyQjJBMFlGYzlFTERyWFg5?=
 =?utf-8?B?L3FtZTBBRnZEckNPUXJEM24xV3VIVXE4NmVSVzhYMGcvcC9CaUN5RkUrQ2JQ?=
 =?utf-8?B?aGl6T2dYaFdpbHNpNWxvR0hyMWtnakhma0lTU0FvU3NVTFgwUmpNKzNpcExs?=
 =?utf-8?B?bTJxODRDZEhTaGUvUlJTWHhnVFdTSitzOURBMEVzbDVBUFpFQytBeXRVZjEv?=
 =?utf-8?B?cHdZWTZseXl2V1Y5Nk93OHpqaWZKU2o0T1E4dWFWWFA4eVZBS1p0M3RSMmVj?=
 =?utf-8?B?alZlT1dISU00U0Y3ZndNU05ab214eGM1cmNYWDV1MnpYdkpuTjVnUWs0QWpz?=
 =?utf-8?B?V2Q0Zys0K2tkZzkvalRRWlRvMUd5TU9oV3JNYWc4THN1a2c9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6213.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?R0xBTG91dm1abW0wTWs3YUlsK0ZGc0szakhGK1dNdFNPWWlhUXhXMVF3eDJU?=
 =?utf-8?B?Y090ZEZBYTBYY2hlTUxuWWNKUEVDdVU5eS9OdkZCdmtiM01WU1FJbFU5emJ5?=
 =?utf-8?B?SCtIeUgwSWpzUUhweTJuZmw5Tldqb0prV1RaWkFBSWIrWThDcXZwS2F2WWg5?=
 =?utf-8?B?RUYwa2ZuZXZ2L1U4WHp2RHhPd0k0OUlCaW4rN3gyZGFLT0dBRk8zak1mZlNK?=
 =?utf-8?B?OWxsbkJlUXdiMU4yMnNmR3NHVGNDWDNVSGFWdzQrc2ZkajFTZVRUTkZETDkw?=
 =?utf-8?B?M3o2dGxIczZhdXNQN1p6SDBYSFJMcnNyTUdyeVljbSsvMlBtdm8wemNocms4?=
 =?utf-8?B?aU5wb29NOExKMmRYeEU1bkJ6eEJxVEVsS0Vmc3E3bWc3VVowL0ZHYTQ0T2di?=
 =?utf-8?B?ZkE1aGp2d3ZvbnlvTVdWVjUzeFZRTlZjb25GdWZRZmNPRlE1dDhyZllBeWZ2?=
 =?utf-8?B?NENFbXNBNzlWS1VuZHhxOFdpeTRYRlFOTFZ3V0Voa3FEc2wvSzc5Wmc3MDZz?=
 =?utf-8?B?bHFmZXJPT3IvaTFJMjBxNlhnUWFqWmlPTHozbjVEQ0VIL1ZhSHRCV3JmUnZw?=
 =?utf-8?B?Tjg5WnFzblY5V1JnRDZQQ2xqSTZ1a2E2cTBsYU5ITEtZcGhEQTlmQjJ2U3pk?=
 =?utf-8?B?bGFWclNwQWFFbFI0aHg5c3RMZXVMQ0tac0Z2M3ErUDF0b0JXY1NTQTNHWHlE?=
 =?utf-8?B?NFBsdlNlY1QyaGpuUmlvMWJmcXJnazdDS0tiU0wvZm5CYUw5YnBSRGh6b1V1?=
 =?utf-8?B?M3ZhZnlBMGx2SnB5K0VIT0tHcUdnRnF2WjVESkFmQytYWlhaZUJJaFVzVktv?=
 =?utf-8?B?dFBPSUFTYkZpK3VHTWFLRlFqQUlYMmdkVHR3YjFPcUxZNlVrVENDQngvQjFM?=
 =?utf-8?B?K1h2RGNSUnp6WnJ0UThCQlowaFdzZzZmU2xoTGJDNWIySEE4YTFsUVlNMkwx?=
 =?utf-8?B?Kzh2alpObjJiSzVxbkFjTFVIcTZoQ1VoOUxtNlpKRFB2UTlKZ082SFJIK1Rz?=
 =?utf-8?B?VzV6R2EwZ0NUYkJXRUlPNTlrTnFuNzNVUkRYak5jYWdpWFNkZUhRaXpTYnRG?=
 =?utf-8?B?M1VQVUdsdHZCY1Y1anpmRXlXL0FFSEFzdTFYODN6b2lFTng0WlEvR08vb0tw?=
 =?utf-8?B?SDF0Y3ZyeHYxcmFiSG9MQlVPODdHQVBVdlR5MDlUeVFGTC9KY08zdWlMbHJ1?=
 =?utf-8?B?YzhkN04yQUM0K1ZSekN1a0lUM3lJWVRGSVoxMEpKS3lHVGJQNnVSelF0Z21G?=
 =?utf-8?B?OCtWRHJ0V3BsbFNSWkxDWHYwMlZrSDl3WU9GcmlqUEdlOHVscVcrOUdmclhk?=
 =?utf-8?B?MzMvY1g3MmpjaEJMSVNhS1YyTDFsbDVHa0V3WWhTMUVCeUhucVlYc0t6SFNV?=
 =?utf-8?B?QlVWL0lqZWxoSitFN2pEQW1ZRXRTYkZrNjZOMDVTalRFSVJrdHZqVklLckRj?=
 =?utf-8?B?S25pNTY1K25RUmNjUlUxWXNINUl3eDhMcFBxZmFKNW1xUkRYRkNnWVhIekpG?=
 =?utf-8?B?TjB1WXBWV1NyTjgvamV3MGQ2czVXKzZMQnYrVDE0a0QvOFdGZEhhWTRHZzJO?=
 =?utf-8?B?TnNqK1lvYlErcGpwZEljQUt1UlkvdStmTEF0Q3NjaXkrUk1wN0hxc3J0STBV?=
 =?utf-8?B?M0ZPRmtOdXV1aGY0aGFKeENtdmloeS9xbG5DQzBFMFpmSkdJRW82WWFoN2tS?=
 =?utf-8?B?OFZJRnBiVEZyOUEybUJWbnA1cXZ2S2lEcCtNZjdXWm90SEljalMrclNlblo3?=
 =?utf-8?B?QjdnL3YzUXhHMkRnYlI0NG9ycnRzTmlLWEQzUDdxT3pLd1pQSEhvR1RFZjVI?=
 =?utf-8?B?QzFaUUZpZmNsNVV4VEdzRkRPdEFJeUViOE90YUMyRDZWWStkbHl6MURrTjdE?=
 =?utf-8?B?NFRoaFAvSVhzODJLWUhMTlRwL1RVVkd0d2pkU3pOM01WNG5TWGV4YXE3OEtv?=
 =?utf-8?B?YzRmb29CVkFSL3VvOHBFMzFkSndGR2tPOVZGYkllaHdGNndhNmE0eG52WWFX?=
 =?utf-8?B?ZFJad3BwMmVxQ215SURMNFQzRi9FdEl0bEhQWldzQ2tkMW45MVI1bnBZdVM3?=
 =?utf-8?B?NHdVWnVWWnVreUluSEMrUTdaNUIvN1p0eks4dHhCRkVRMWYxRGFZbXRPZ3h4?=
 =?utf-8?Q?icnetDV9XryRZx7r+BA/hlusg?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6213.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8472b8f-cefc-4253-18c5-08dc9edd0e8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2024 23:32:24.8882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nO4HH5j09PHbHBjVJRRC9m6JAGQ253bu3e2yzOOf4jLv6d5hxOINs8gBsCUW0z5GGkw7YwRz141xF5KylGFR55vudJVuBF8SxAR6RgoJb9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5695
X-Proofpoint-GUID: R-8VeU11VmfKHm8mjzmaT5aIGD4bjN8-
X-Proofpoint-ORIG-GUID: R-8VeU11VmfKHm8mjzmaT5aIGD4bjN8-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-07_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407070196

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJv
biA8amljMjNAa2VybmVsLm9yZz4NCj4gU2VudDogU2F0dXJkYXksIEp1bmUgMjksIDIwMjQgMjo1
MSBBTQ0KPiBUbzogVGluYWNvLCBNYXJpZWwgPE1hcmllbC5UaW5hY29AYW5hbG9nLmNvbT4NCj4g
Q2M6IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgTGFycy1QZXRlciBDbGF1c2VuIDxs
YXJzQG1ldGFmb28uZGU+OyBSb2IgSGVycmluZw0KPiA8cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6
dG9mIEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwub3JnPjsgQ29ub3IgRG9vbGV5DQo+IDxjb25v
citkdEBrZXJuZWwub3JnPjsgTGlhbSBHaXJkd29vZCA8bGdpcmR3b29kQGdtYWlsLmNvbT47IE1h
cmsgQnJvd24NCj4gPGJyb29uaWVAa2VybmVsLm9yZz47IEhlbm5lcmljaCwgTWljaGFlbCA8TWlj
aGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNvbT47DQo+IE1hcmNlbG8gU2NobWl0dCA8bWFyY2Vsby5z
Y2htaXR0MUBnbWFpbC5jb20+OyBEaW1pdHJpIEZlZHJhdQ0KPiA8ZGltYS5mZWRyYXVAZ21haWwu
Y29tPjsgR3VlbnRlciBSb2VjayA8bGludXhAcm9lY2stdXMubmV0Pg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIDIvMl0gaWlvOiBkYWM6IHN1cHBvcnQgdGhlIGFkODQ2MCBXYXZlZm9ybSBEQUMNCj4g
DQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIE1vbiwgMjQgSnVuIDIwMjQgMDQ6NTY6NTcgKzAwMDAN
Cj4gIlRpbmFjbywgTWFyaWVsIiA8TWFyaWVsLlRpbmFjb0BhbmFsb2cuY29tPiB3cm90ZToNCj4g
DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogSm9uYXRoYW4g
Q2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz4NCj4gPiA+IFNlbnQ6IFN1bmRheSwgTWF5IDEyLCAy
MDI0IDEyOjQ0IEFNDQo+ID4gPiBUbzogVGluYWNvLCBNYXJpZWwgPE1hcmllbC5UaW5hY29AYW5h
bG9nLmNvbT4NCj4gPiA+IENjOiBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+ID4gPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBM
YXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT47IFJvYg0KPiA+ID4gSGVycmluZyA8
cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwub3Jn
PjsNCj4gPiA+IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz47IExpYW0gR2lyZHdv
b2QNCj4gPiA+IDxsZ2lyZHdvb2RAZ21haWwuY29tPjsgTWFyayBCcm93biA8YnJvb25pZUBrZXJu
ZWwub3JnPjsgSGVubmVyaWNoLA0KPiA+ID4gTWljaGFlbCA8TWljaGFlbC5IZW5uZXJpY2hAYW5h
bG9nLmNvbT47IE1hcmNlbG8gU2NobWl0dA0KPiA+ID4gPG1hcmNlbG8uc2NobWl0dDFAZ21haWwu
Y29tPjsgRGltaXRyaSBGZWRyYXUNCj4gPiA+IDxkaW1hLmZlZHJhdUBnbWFpbC5jb20+OyBHdWVu
dGVyIFJvZWNrIDxsaW51eEByb2Vjay11cy5uZXQ+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENI
IDIvMl0gaWlvOiBkYWM6IHN1cHBvcnQgdGhlIGFkODQ2MCBXYXZlZm9ybSBEQUMNCj4gPiA+DQo+
ID4gPiBbRXh0ZXJuYWxdDQo+ID4gPg0KPiA+ID4gT24gRnJpLCAxMCBNYXkgMjAyNCAxNDo0MDo1
MyArMDgwMA0KPiA+ID4gTWFyaWVsIFRpbmFjbyA8TWFyaWVsLlRpbmFjb0BhbmFsb2cuY29tPiB3
cm90ZToNCj4gPiA+DQo+ID4gPiA+IFRoZSBBRDg0NjAgaXMgYSDigJxiaXRzIGluLCBwb3dlciBv
dXTigJ0gaGlnaCB2b2x0YWdlLCBoaWdoLXBvd2VyLA0KPiA+ID4gPiBoaWdoc3BlZWQgZHJpdmVy
IG9wdGltaXplZCBmb3IgbGFyZ2Ugb3V0cHV0IGN1cnJlbnQgKHVwIHRvIMKxMSBBKQ0KPiA+ID4g
PiBhbmQgaGlnaCBzbGV3IHJhdGUgKHVwIHRvIMKxMTgwMCBWL868cykgYXQgaGlnaCB2b2x0YWdl
ICh1cCB0byDCsTQwDQo+ID4gPiA+IFYpIGludG8gY2FwYWNpdGl2ZSBsb2Fkcy4NCj4gPiA+ID4N
Cj4gPiA+ID4gQSBkaWdpdGFsIGVuZ2luZSBpbXBsZW1lbnRzIHVzZXItY29uZmlndXJhYmxlIGZl
YXR1cmVzOiBtb2RlcyBmb3INCj4gPiA+ID4gZGlnaXRhbCBpbnB1dCwgcHJvZ3JhbW1hYmxlIHN1
cHBseSBjdXJyZW50LCBhbmQgZmF1bHQgbW9uaXRvcmluZw0KPiA+ID4gPiBhbmQgcHJvZ3JhbW1h
YmxlIHByb3RlY3Rpb24gc2V0dGluZ3MgZm9yIG91dHB1dCBjdXJyZW50LCBvdXRwdXQNCj4gPiA+
ID4gdm9sdGFnZSwgYW5kIGp1bmN0aW9uIHRlbXBlcmF0dXJlLiBUaGUgQUQ4NDYwIG9wZXJhdGVz
IG9uIGhpZ2gNCj4gPiA+ID4gdm9sdGFnZSBkdWFsIHN1cHBsaWVzIHVwIHRvIMKxNTUgViBhbmQg
YSBzaW5nbGUgbG93IHZvbHRhZ2Ugc3VwcGx5IG9mIDUgVi4NCj4gPiA+ID4NCj4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogTWFyaWVsIFRpbmFjbyA8TWFyaWVsLlRpbmFjb0BhbmFsb2cuY29tPg0KPiA+
ID4NCj4gPiA+IEknZCBsaWtlIHRvIHNlZSBzb21lIEFCSSBkb2NzIGZvciB0aGUgZGVidWdmcyBp
bnRlcmZhY2UuDQo+ID4gPiBUaGUgZGV2aWNlIGlzIHVudXN1YWwgZW5vdWdoIHRoYXQgYSBnZW5l
cmFsIGludHJvIGRvY3VtZW50IG9yIGEgbG90DQo+ID4gPiBtb3JlIGluIHRoZSBzZXJpZXMgY292
ZXIgbGV0dGVyIHdvdWxkIGJlIHVzZWZ1bC4NCj4gPiA+DQo+ID4gPiBJJ20gbm90IHN1cmUgd2hh
dCB0aGUgZG1hZW5naW5lIHVzYWdlIGluIGhlcmUgaXMgZG9pbmcgZm9yIGV4YW1wbGU/DQo+ID4g
PiBEcml2aW5nIHRoZSBwYXJhbGxlbCBidXMgcGVyaGFwcz8gIERhdmlkIHdhcyBjb3JyZWN0IHRo
YXQgdGhlDQo+ID4gPiBiaW5kaW5nIHNob3VsZCByZWZsZWN0IHRoYXQgcGFydCBhcyB3ZWxsLiBJ
IHdhcyBhc3N1bWluZyB5b3UnZCBvbmx5DQo+IGltcGxlbWVudGVkIHRoZSBzcGkgcGFydC4NCj4g
PiA+DQo+ID4gPiBIb3cgdG8gaGFuZGxlIHRoZSBwYXR0ZXJuIGdlbmVyYXRvciBpcyBhbHNvIGFu
IGludGVyZXN0aW5nIHF1ZXN0aW9uLg0KPiA+ID4gVGhhdCBwcm9iYWJseSB3YW50cyBhIHZlcnNp
b24gb2YgdGhlIHN5bWJvbCBpbnRlcmZhY2VzIHdlIHVzZSBmb3INCj4gPiA+IFBTSyBhbmQgc2lt
aWxhci4gIFdlIGRpZCBoYXZlIHNvbWUgRERTIGRyaXZlcnMgYSBsb25nIHRpbWUgYmFjayBpbg0K
PiA+ID4gc3RhZ2luZyBidXQgdGhleSBvbmx5IGRpZCBhIGZldyBmaXhlZCB3YXZlZm9ybXMgc28g
dGhpcyBpcyBicmVha2luZyBuZXcNCj4gZ3JvdW5kLg0KPiA+DQo+ID4gSSBhbHNvIHRob3VnaHQg
YWJvdXQgaG93IHNob3VsZCB0aGUgcGF0dGVybiBnZW5lcmF0b3IgYmUgaGFuZGxlZC4gSU4NCj4g
PiB0aGUgbGFzdCByZXZpc2lvbiwgdGhlcmUgd2VyZSB0d28gZGVidWcgYXR0cmlidXRlcyB0aGF0
IG1ha2UgdXAgdGhpcw0KPiA+IGZlYXR1cmUuIFBhdHRlcm4gZGVwdGggYW5kIHBhdHRlcm4gbWVt
b3J5LiBVbHRpbWF0ZWx5IEkgZm91bmQgYSB3YXkgdG8NCj4gPiBjb21iaW5lIHRoZXNlIHR3byBh
dHRyaWJ1dGVzIGludG8gb25lIGNhbGxlZCAidGVzdF9wYXR0ZXJuIi4gVGhlDQo+ID4gYXR0cmli
dXRlIGlzIGEgc3RyaW5nIGNvbnRhaW5pbmcgYW4gYXJyYXkgb2YgdmFsdWVzIHdpdGggYSBtYXhp
bXVtIG9mDQo+ID4gMTYgZGF0YSB3b3Jkcywgd2hpY2ggdGhlIERBQyB3aWxsIGN5Y2xlIHRocm91
Z2ggdG8gZ2VuZXJhdGUgYSBwYXR0ZXJuLg0KPiA+IFRoZSBudW1iZXIgb2YgdmFsdWVzIHdpdGhp
biB0aGUgc3RyaW5nIGNhbiBiZSBhbnl3aGVyZSBiZXR3ZWVuIDEgdG8gMTYgYW5kDQo+IGhhdmUg
YSBzcGFjZSBpbiBiZXR3ZWVuLiBJIGFsc28gYWRkZWQgYSAidGVzdF9wYXR0ZXJuX2VuYWJsZSIN
Cj4gPiBkZWJ1ZyBhdHRyaWJ1dGUuIEZvciB0aGUgQUJJIGZpbGUsIHNob3VsZCBJIGNyZWF0ZSBv
bmUgYWxvbmdzaWRlIG90aGVyICJkZWJ1Z2ZzLQ0KPiAqIg0KPiA+IGZpbGVzIGFuZCBqdXN0IG1l
bnRpb24gdGhlIG5hbWUgb2YgdGhlIHBhcnQ/IGUuZy4gImRlYnVnZnMtZHJpdmVyLWFkODQ2MCIN
Cj4gDQo+IERvaW5nIHRoaXMgaW4gZGVidWdmcyBiYXNpY2FsbHkgbWVhbnMgeW91IGFyZW4ndCBp
bnRlbmRpbmcgaXQgdG8gZ2V0IHVzZWQgaW4gcmVhbA0KPiB1c2VjYXNlcy4gIFNvIHdlIG5lZWQg
c29tZSBzeXNmcyBBQkkuDQo+IA0KPiBUaGF0IHByb2JhYmx5IG1lYW5zIGEgbW9kZSBzd2l0Y2gg
c2ltaWxhciB0byB0aGUgb25lcyB3ZSBoYXZlIGZvciBkZXZpY2VzIHRoYXQNCj4gdXNlIGFuIGV4
dGVybmFsIHRvZ2dsZSAodHlwaWNhbGx5IGZvciBGcmVxdWVuY3kgU2hpZnQgS2V5aW5nIG9yIHNp
bWlsYXIgb3INCj4gc29tZXRpbWVzIGp1c3QgdG8gZmxpcCBiZXR3ZWVuIHR3byBEQyB2b2x0YWdl
cykuICBXZSBuZWVkIGEgbmV3IHRlcm0gdGhvdWdoDQo+IGFzIHRoaXMgaXNuJ3QgYSB0b2dnbGUu
DQo+IA0KPiBGb3IgdGhlIHZhbHVlcyB3ZSBjb3VsZCBtYXAgaXQgdG8gdGhhdCBpbnRlcmZhY2Ug
d2hpY2ggaXMgc29tZXRoaW5nIGxpa2UNCj4gDQo+IG91dF92b2x0YWdlMF9yYXcwDQo+IG91dF92
b2x0YWdlMF9yYXcxDQo+IA0KPiBldGMuICBUaGF0IGF2b2lkcyBuZWVkIGZvciBhIG5ldyBBQkkg
Zm9yIHRoZSB2YWx1ZXMsIGJ1dCBwZXJoYXBzIGlzbid0IHRoYXQgZWxlZ2FudA0KPiBpZiB0aGUg
cGF0dGVybnMgb24gb3RoZXIgZGV2aWNlcyB3ZSBldmVudHVhbGx5IHN1cHBvcnQgdGhpcyBvbiBn
ZXQgbGFyZ2UuDQoNCkkgc2F3IHNvbWUgZHJpdmVycyBtYWtpbmcgdXNlIG9mICJ0ZXN0X3BhdHRl
cm4iIGF0dHJpYnV0ZS4gSSB0aGluayB0aGF0IG1pZ2h0IGZpdC4NCkJ1dCBJJ2QgbG9vayBpbnRv
ICJyYXcwIiBhbmQgInJhdzEiIGFzIHdlbGwNCg0KPiANCj4gQW55b25lIGtub3cgaG93IGxhcmdl
IHRoZXNlIHR5cGljYWxseSBnZXQ/IEknbSBiZWluZyBsYXp5IGFuZCBkb24ndCB3YW50IHRvDQo+
IGRhdGFzaGVldCBkaXZlIHRoaXMgZXZlbmluZyENCg0KSXQgb25seSBnZXRzIHVwIHRvIDE2IHZh
bHVlcy4gDQoNCj4gDQo+IEpvbmF0aGFuDQoNCg==

