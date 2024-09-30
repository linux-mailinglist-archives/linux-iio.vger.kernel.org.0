Return-Path: <linux-iio+bounces-9906-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D93989A85
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 08:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC231C212BF
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 06:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2419B811F7;
	Mon, 30 Sep 2024 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="yEU9LtWm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C9D1E49F;
	Mon, 30 Sep 2024 06:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727677815; cv=fail; b=lVibAz/UmlfRPvbjBw/BH5ftWBz8CeXMeDQF7RHNaAG8zb80KF15dpPgE/+kGSBP5vK9Bcds4WCNNNH3SWHJbRuILnlWu64Vokot0tbsFwDO7LuR8ZZTRE/oa3GNW++wxBQNrJkC4J5qHAQsuK01sUk+3IbqRTooqZrmIIWQG3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727677815; c=relaxed/simple;
	bh=+OYJpTUc/AUwrWyOHrA5V3SfcdRxGD2I7YwiCfhNos0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pojG88QQoAPBl8vevQtc2CkDvYn0ilmX97KpyemAK1W/p4zB+6fd+nhgQv1VJ7ArnrmdedM/wx220UaEYqDonxxAdM4Ywd1zqApQFOb/Wk4ES7LXuHE/+HE2jtHL8nWuH6L7Izwd4Hdqt2N67Imj3xPSwgYSz3kT3PkJHQm+oFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=yEU9LtWm; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48U5gMJ7030489;
	Mon, 30 Sep 2024 02:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=+OYJp
	TUc/AUwrWyOHrA5V3SfcdRxGD2I7YwiCfhNos0=; b=yEU9LtWmrcnW2TvpgKc/m
	5OCW2R8o+u92YhhbkgQJJZqpRqGqLv2y631nRWLyHCmzVVFR1mTcSR+93zbbTz/H
	WkEuLpBdUYIpzqzesDUapmErZgGi7pHL4xiyPsOutni9I+UN7+1WBY3Uf6nRfdNA
	6iZ0EnG/So/BUILLuz+ALYdoSHLPnAt8HqlEpRI+tO9/d6bbRdGcwYx0BEbbIjWp
	B+ypHrOniX4i/cRKTi1e0PyUZ/7t7l0UjipaWl7YRyytb+7M6+1WxSsjkzimacVI
	utORFj3TIq+Mf4iYsPpLvkhBaY6mOz76K7E/ShxZjnqNuq888e6zYOSndqAxZ1aV
	Q==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17010007.outbound.protection.outlook.com [40.93.1.7])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 41yp2rr5sd-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 02:29:46 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPzcaTXmr2VFptDQ8OC1FSJWuR7r92vmFsFQlwU4m8xeu2yoU6tILREjElJqmSUIRWWLi59byV9m7yB9QO+6XntjxJnGej2m3IwJ9b/HiWh39JTpbej6tu01NE0IZUL9kALcxReHBqbcdCYVD8BkxNSE5AsDjeklNTiYETp78gv5Copy26Ifc5Kmdk+Y0/sq/oN1uGMIdASxBJ4e7ABNKf/guSwELILa/9oTwiJwqDG+1eDKK/EI6Ypg/Fc/NBL9UvdrbTYZ0AUUsebZAulivvgRCW6bubbg2VAM3baKo0UXqZbh6RqMwE6XF/E3C7sxK+gNaXY0NZeSb3YGKTO41Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OYJpTUc/AUwrWyOHrA5V3SfcdRxGD2I7YwiCfhNos0=;
 b=nAc8C7eq1yt8B9Rc1vy2ltPNaR9QfQOxJRjUlNH0pAZ5zUUqJn6Wg4QQPL4Wsb8iBp/iT1b4jZsb33zAlioMxHY2i7aAfqi9kSaUVeK4wdx/J+yy98XkWrEBpCi7Ul49LHDo/W7JKc3jPQXRapk5hFvyht+VYH3nIhYoROSvsY8i5OatDdb9eeFdTyl4AggLMYSPTPJVQSk4IEmEyMiT4xZC+aCwuMKQL5KFltfJ9TV1K564CeH+WQJYzVeBGzQNp18Tkx9q4/5VD5iQziaoKaZGq5bm620mceicHcMksFtpY0z2sAGUXwfunAVXqy2y1+G/k8QoYr9Cd++0vcDSUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB6224.namprd03.prod.outlook.com (2603:10b6:a03:303::18)
 by SA6PR03MB7733.namprd03.prod.outlook.com (2603:10b6:806:447::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 06:29:43 +0000
Received: from SJ0PR03MB6224.namprd03.prod.outlook.com
 ([fe80::1405:536e:190d:75e]) by SJ0PR03MB6224.namprd03.prod.outlook.com
 ([fe80::1405:536e:190d:75e%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 06:29:43 +0000
From: "Tinaco, Mariel" <Mariel.Tinaco@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>,
        Dimitri Fedrau <dima.fedrau@gmail.com>,
        David
 Lechner <dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?=
	<noname.nuno@gmail.com>
Subject: RE: [PATCH v4 2/2] iio: dac: support the ad8460 Waveform DAC
Thread-Topic: [PATCH v4 2/2] iio: dac: support the ad8460 Waveform DAC
Thread-Index: AQHbBtL64dQMY8uE30mRU9akCX0yb7JtVTcAgAKf0IA=
Date: Mon, 30 Sep 2024 06:29:43 +0000
Message-ID:
 <SJ0PR03MB6224745D99B708440486C0D291762@SJ0PR03MB6224.namprd03.prod.outlook.com>
References: <20240912095435.18639-1-Mariel.Tinaco@analog.com>
	<20240912095435.18639-3-Mariel.Tinaco@analog.com>
	<8f869b3b-df3f-49a9-9b6e-640697aa91dd@wanadoo.fr>
 <20240928151930.0c22e5e9@jic23-huawei>
In-Reply-To: <20240928151930.0c22e5e9@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?utf-8?B?UEcxbGRHRStQR0YwSUdGcFBTSXdJaUJ1YlQwaVltOWtlUzUwZUhRaUlIQTlJ?=
 =?utf-8?B?bU02WEhWelpYSnpYRzEwYVc1aFkyOWNZWEJ3WkdGMFlWeHliMkZ0YVc1blhE?=
 =?utf-8?B?QTVaRGcwT1dJMkxUTXlaRE10TkdFME1DMDROV1ZsTFRaaU9EUmlZVEk1WlRN?=
 =?utf-8?B?MVlseHRjMmR6WEcxelp5MDFZMkkwTVdRNFpTMDNaV1kxTFRFeFpXWXRPR016?=
 =?utf-8?B?T1MwM05EQTBaakUxTWpOalpUaGNZVzFsTFhSbGMzUmNOV05pTkRGa09UQXRO?=
 =?utf-8?B?MlZtTlMweE1XVm1MVGhqTXprdE56UXdOR1l4TlRJelkyVTRZbTlrZVM1MGVI?=
 =?utf-8?B?UWlJSE42UFNJM05qTTBJaUIwUFNJeE16TTNNakUxTVRNM09EWTVNREkwTURn?=
 =?utf-8?B?aUlHZzlJbmx0VDJkQkszQldOMWRFZDBsSGJrdzBRM2t6TlRkMlRFOXFaejBp?=
 =?utf-8?B?SUdsa1BTSWlJR0pzUFNJd0lpQmliejBpTVNJZ1kyazlJbU5CUVVGQlJWSklW?=
 =?utf-8?B?VEZTVTFKVlJrNURaMVZCUVVSblJFRkJRMGxvZUdkblFXaFFZa0ZWYlVOcmJE?=
 =?utf-8?B?WkRUbTVFUmxOWlMxTlliMGt5WTAxVlJFRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGSVFVRkJRVVJoUVZGQlFWTm5TVUZCVHpSQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZGUVVGUlFVSkJRVUZCTTB4b1UyWm5RVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlNqUkJRVUZDYUVGSFVVRmhVVUptUVVoTlFWcFJRbXBCU0ZWQlky?=
 =?utf-8?B?ZENiRUZHT0VGalFVSjVRVWM0UVdGblFteEJSMDFCWkVGQ2VrRkdPRUZhWjBK?=
 =?utf-8?B?b1FVZDNRV04zUW14QlJqaEJXbWRDZGtGSVRVRmhVVUl3UVVkclFXUm5RbXhC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVVZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCWjBGQlFVRkJRVzVuUVVGQlIwVkJXa0ZDY0VGR09FRmpkMEpz?=
 =?utf-8?B?UVVkTlFXUlJRbmxCUjFWQldIZENkMEZJU1VGaWQwSnhRVWRWUVZsM1FqQkJT?=
 =?utf-8?B?RTFCV0hkQ01FRkhhMEZhVVVKNVFVUkZRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGUlFVRkJRVUZCUVVGQlEwRkJRVUZCUVVObFFVRkJRVmxSUW10QlIy?=
 =?utf-8?B?dEJXSGRDZWtGSFZVRlpkMEl4UVVoSlFWcFJRbVpCU0VGQlkyZENka0ZIYjBG?=
 =?utf-8?B?YVVVSnFRVWhSUVdOM1FtWkJTRkZCWVZGQ2JFRklTVUZOWjBGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkNRVUZCUVVGQlFVRkJRVWxCUVVGQlFVRlBORUZC?=
 =?utf-8?B?UVVGQlFVRkJRVU5CUVVGQlFVRkJRVUZCU1VGQlFVRkJRVUZCUVVGblFVRkJR?=
 =?utf-8?B?VUZCUVVGQmVtZEJRVUZCVFVGQlFVSlBRVUZCUVVGQlFVRkJSMFZCV2tGQ2NF?=
 =?utf-8?Q?FGOEFj?=
x-dg-rorf: true
x-dg-refone:
 d0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCbUFHRUFiQUJ6QUdVQVh3Qm1BRzhBY3dCcEFIUUFhUUIyQUdVQUFBQThBQUFBQUFBQUFHRUFaQUJwQUY4QWN3QmxBR01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlBREVBQUFBOEFBQUFBQUFBQUdFQVpBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFESUFBQUE9Ii8+PC9tZXRhPg==
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6224:EE_|SA6PR03MB7733:EE_
x-ms-office365-filtering-correlation-id: 45abdded-029d-4e0d-4fb4-08dce11945a1
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZEdFTUpRaitNU1ZlNUVESHpKRElFQjdHbWhWTGNvRWpJTXErYWUyUUFZazJQ?=
 =?utf-8?B?aXJmRjhIUTVLcVUxVGRxb0Z0QTNNYVRVK1ZkUUx3WVBrNE0zSXhEQUx2Q0Ft?=
 =?utf-8?B?akxoWHd2Y1BwZDVZYThDd3FiQU5NOWo5TXNtNDNwNDUyeFJBZVZwcVlTd0FS?=
 =?utf-8?B?UFNBRUhYdWpJWi94M0pqOXpRVUsyYVBYUzJOc1NTV2YrRTFJSU1sWlBLYkh0?=
 =?utf-8?B?bXRoNXp4VzlQS1I3d291UHJ0TEZXa1hRV1dFeTZFOEJhbExhL1dORUcwNmY4?=
 =?utf-8?B?aGJkd01pYTJlQnVoQnViTXVVNWlZMFJWTjhqcFp6bHdoQzBMaDVHTWVEUFJh?=
 =?utf-8?B?VjBTNVVVYjFURVlYL05TZW1iRjZ2dzJROExjUkxzNDhNZU5vK3ViWmdBMnpS?=
 =?utf-8?B?TzhPYjJoYmJMUUhhWEdRSENpTmlRTXNaaE0rRC9ZeDd3Kzg3MVVIZW0weERO?=
 =?utf-8?B?eDlhQVRuU1JVRjMzOWRzcVZSd3FJZzlQWE9va3E4SzlWZGlycm8vSDlWSXFo?=
 =?utf-8?B?OUwvTHI1bWF0NDRGcnMzQ0VNSzJoaGtPK1Vva2hwN1hkRlFJRXUydWY1RnNz?=
 =?utf-8?B?V21wY1JJRHI0MlpaYzJkZ1BudW9paHpFUmV3VDBFV2h3Zm5aeWx0dHVXWm5V?=
 =?utf-8?B?ellkMjB5UjMrdFh1cTllc0ZlbXN0c0pGdy9Tc2FxTjZxbU9WS3lEUVNiamEy?=
 =?utf-8?B?NWtra0JwZGM2d0U0UjBxd2dnNEh2dWJzQm5QZjQ4Y0FPc3luSE5KOWgwVDZM?=
 =?utf-8?B?ZEV4YXJMZldxaVFPN0didUgzMzM5REk1ZGcvd21aYjRQZDJ2VTFabzNXZmlw?=
 =?utf-8?B?WDBiL2JRd0tPeHk1bmZ2TElMUlRSYjF6b0RWN0xzeWpFTXZIdm1MMkE4MkNF?=
 =?utf-8?B?U1ZidVBIUVFmc0MxMlBuM2kyOVZ0dVZ1aGdQbGQ2ZFp6VGhQUExGc05EbFhU?=
 =?utf-8?B?dWVxeGF5WXY3cnFvcUJka2VWd1g1L2Z4dHVWY2lPM2pMU01MYnhkalFWS1pj?=
 =?utf-8?B?U0JtQVJrWXVNc1VvcnV3RkZBQ01INGcrNERwRURxY2lZd1h4dElqSGJRcjNN?=
 =?utf-8?B?ZzFZakxmVzZKRjhQL0ZnaFlqVWNUM1VtdUZoV2JTWk9BREhGMWtCcTB2OUlr?=
 =?utf-8?B?OGZyVlVDaWx3OWI5bTJPbi9mQW9qbXhhMWFHYzYwQ1gvZWNTWWIvMFFUNEs2?=
 =?utf-8?B?bzBGWnFwL1lVcUpUdGFIQ3VQTkZnTjZGVThtcGYwdlZoQ3dFMXFtZHR0RTNs?=
 =?utf-8?B?NDY2RVVlMDBYT3UweGpQa3VlK0JWR3dQMk9aOExLTzJWMnZ5MUdCSHFaajl6?=
 =?utf-8?B?bDd5eFBPZldiYmxnbFdXS1g3V1JkVE5SdTRpRmJicEdxYkJ5YnBSYmYrcjV1?=
 =?utf-8?B?QnpGZEtnVTN4dStiNU04ZjZjNWoyT1NmT0Ewa3dzT1NTQkxLUTVRWGhFNEZX?=
 =?utf-8?B?VTBiRUREMWZQRXAxMGZBdmZCNHNRVDJzOVNjNUFCR21qRnhlajV4bmRJMFp1?=
 =?utf-8?B?a0IwbS9HUG1IQlhNajBKT3RRSzFmNHpkUktpYm9tWmdFalJnTURDbGZYaHFQ?=
 =?utf-8?B?WnJNem1sTU0zMkV4eEt4d3hpZ3NoYjB2dVJ3akg3bDJqNzlJQm1RU2JXTzNV?=
 =?utf-8?B?WUxQQzhaNnZ6aTVaZHVHT1dZMU5Ua0VGN1RDWjgrWC9hZmg4RDBTTEtVYnBJ?=
 =?utf-8?B?azZTc1JjUllUaHNpWnNyYStma0RiaXB2Q3puS2VnbVJmVFVNd2dYQUsva1VJ?=
 =?utf-8?B?Wm50bnZ5ZGlTQ1VFQmErM05CWmd5R2dSRys2cXpMbEl3MW9tbFdOR0dsVjhO?=
 =?utf-8?B?NFpHclBNV2NkRWZWMlFtVkNKaXU0dkJDT1R0RVExZERMdGIrNEZkbVJHeUxm?=
 =?utf-8?B?aCtSeExVbTAvVzU4a010YVI5aDByZEpHYUVmdVI2WmVNTFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6224.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cGFBV0tvVnc4WXFSZVRIU29SQThpMmE4ejNkYnRmQTZ3V0JoSFhzYXZxSmVZ?=
 =?utf-8?B?SjZlVE9BTW1jdFRIckxXNDNoQXIzQ2FUTG13N1dkMjdjQndCVVUyb3MyMGJS?=
 =?utf-8?B?cFJFZU52dHdhUkhLblpJWWFMVWhTVGNEWGZTUW92MTFyM3Rzb3ZZSmIvc1M2?=
 =?utf-8?B?a0h3Q0V5V0MzTGMyclJlV2hLMktneTJncU16OVN4YWdrdlJXZnVXbm9YRlZ0?=
 =?utf-8?B?dVpGNUVCa2tVSWE1SjZhMjUyNE5xbGZzL3lUTlBTQlFEMmJFeXRwMFoyRWtV?=
 =?utf-8?B?S0hWdHVobEVBY1lhaWwvMHY3cFVicDkxaXUvTWxVTFpJcTRXd1JjNE55elBF?=
 =?utf-8?B?dEVDQzVSdERZSGpVdTdKTDB6aHNqTkNWRHJqSGg4N3VXVWc5RjRNTVAyVXJU?=
 =?utf-8?B?aEFBL1pvdjRwa2M4WE16VHB3UnhkTFNFQkR2QSsrdXNKQzVlZy9uanhscWZC?=
 =?utf-8?B?TGNOVmk4MEhoMkg5OXRHcU04Q2ZnTHJHK2JCalNlQ0JiRTF6VnNEMWI5bWxH?=
 =?utf-8?B?Ym9RcHJCMDAvNG9oSjZhTWF4czgyQVZ0ckxEYlBiUXJQcDJZSStWajZxbmY1?=
 =?utf-8?B?blBZeUdXcXpiSm9qdnl5WHpLZW5Majl2LzYzVXIwaStVczNZL25oUCtRV0tY?=
 =?utf-8?B?TjNMNVVjclFuRk8wclZtQnZlR21QbkQwY0NrWVhCR0YweHdsVXhGemlXUVgy?=
 =?utf-8?B?emtIa2RlK0xYYUtwaHlPYnh5SkZITW51VFllY3VuTkxTVFVxWS81bVZjUE0v?=
 =?utf-8?B?aWVlZ1hReFEvMmdQRzIxdjQ2YmtBUmlNdThYM2VPS0p1WG8reDdkcmRLL0tp?=
 =?utf-8?B?dDRuOStVVDd0aDhiUDJmbkU1UkVWR1ZUUFV2elZjMDE3NTAvR0FWeVhweXUx?=
 =?utf-8?B?dXFMNWM1RlpZUlA5N2d2TmZUUkpKMjYrTEJaMGUwU2NvRlFjUW9DbmowTmtT?=
 =?utf-8?B?SThHSWlEb2JzeXErSnZnbGNjTkZVNlE1UHhsakV3Y2NJeDJ4VU02czlZWXE2?=
 =?utf-8?B?eXQ1dGo0dWNHdWowNGk3OVNwV1A2KzF3RURpVEt2YitFa0o5bGc0MGtkSzRu?=
 =?utf-8?B?bFc2ekc4WWRSeHNRYm91TEJrZWhKT1J6dVBPVU9VdmJSbjMybFNINDF6M3Jr?=
 =?utf-8?B?YW9VTGsyQ2txQ01iTWFobkZydDEzbWVqam9qcC90ZUtHYmRVZTViWU83Mnk2?=
 =?utf-8?B?WXp3WVpkbG5TSGlvS1pOU0wxaFM2UXdGcG85WitlT29nSDdXMGYxVko1dkxk?=
 =?utf-8?B?ZU5Gcmc4S0IwNWViUnMwazdlLzFJdW1PYit2OUxFaFNyRHozWmNiMVgzTWlk?=
 =?utf-8?B?MXNCUjkvc0FXUWVVMmE5L2xKNnhBTFN2eXFRQThETUQvTmdFZG4xWVNqcDJh?=
 =?utf-8?B?NUt4cVpLY01JOXR5TnhDeG1IVmFHZWFJeVJ3Rk9OTjNmd2NlWEI3N2EvaWkx?=
 =?utf-8?B?TDl2Vkozd2k0dS9NZWg1RTdnVC82TTJnZVUxRHBOa1VQQWc1cjF3c0xTQURP?=
 =?utf-8?B?a0JXd2cvUTdUREZZYU56VDgxNjd1MktuNjdhTGhDKzlQRmN3ZUxRakxPQTZs?=
 =?utf-8?B?cFhTOXJSRXpGalA3ZEkzd0x6Sjh2VnRxNnJPNERsaWV5Q2plSy9qcjB3TWw4?=
 =?utf-8?B?ZWcrbGRLeHB0UmZjMXgweXROS2duOEhYcHM5T1dOSmd6N2E0R3FUUnZpM2kv?=
 =?utf-8?B?QWdFeVFUSS92M2cxdUF4dlR6K1ZBYVFyZFdNMTRjZUlYa0ZaRzMvTmVrWlJh?=
 =?utf-8?B?UTR1RXBXdS9icmhlVU1PTUx3RC9LYjZiQ3VuOTZabEU4V2hsVGwxTk16UjN6?=
 =?utf-8?B?VWJ3d0hkOTlxblh0bTYza3BNbCtoMHNxdFErS2tDSUg3SHRuZ2kwNXNOdVQy?=
 =?utf-8?B?Z0prMW9KY0RNRERPdnlGZ3VqOG9yTFJ2ZmxpZkMvaDBldW8zK1NHekJ0WEdy?=
 =?utf-8?B?Z0piNEFMY3IvQzVMTVNmQW1jQjVKYU5Gekdod2phSU9RMk9vVkVqNit0cDFp?=
 =?utf-8?B?QXRzR0crWEJjbGN0bkRKVjZjcGM5V2xEWUhPaFUva3l5YnE1ZTg2enoyN2JX?=
 =?utf-8?B?VWdmVzlrNldCN0d2aXFmSkM3MG9TSTFXaERRa0o2U096ZkhnK2hYNHIzZE54?=
 =?utf-8?Q?TzaIWpPst6bzMBY2l9zYDoDSQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 45abdded-029d-4e0d-4fb4-08dce11945a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 06:29:43.7772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 461b5+b26YW7SMnOw4/4Ocl1SONDPbdMEtXumdjdHbPi/c6sC2fBWO0hdfNACvNtg7gzuTrriL58rfCq+2kltJRXsQjwcPvvARf6eCt+FpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7733
X-Proofpoint-GUID: FBh3SmqSq1b7kY6vEP9RMTRD5SD8obcv
X-Proofpoint-ORIG-GUID: FBh3SmqSq1b7kY6vEP9RMTRD5SD8obcv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300045

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJv
biA8amljMjNAa2VybmVsLm9yZz4NCj4gU2VudDogU2F0dXJkYXksIFNlcHRlbWJlciAyOCwgMjAy
NCAxMDoyMCBQTQ0KPiBUbzogQ2hyaXN0b3BoZSBKQUlMTEVUIDxjaHJpc3RvcGhlLmphaWxsZXRA
d2FuYWRvby5mcj4NCj4gQ2M6IFRpbmFjbywgTWFyaWVsIDxNYXJpZWwuVGluYWNvQGFuYWxvZy5j
b20+OyBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgTGFycy1QZXRlciBDbGF1c2VuDQo+
IDxsYXJzQG1ldGFmb28uZGU+OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6
dG9mIEtvemxvd3NraQ0KPiA8a3J6aytkdEBrZXJuZWwub3JnPjsgSGVubmVyaWNoLCBNaWNoYWVs
DQo+IDxNaWNoYWVsLkhlbm5lcmljaEBhbmFsb2cuY29tPjsgQ29ub3IgRG9vbGV5IDxjb25vcitk
dEBrZXJuZWwub3JnPjsNCj4gTWFyY2VsbyBTY2htaXR0IDxtYXJjZWxvLnNjaG1pdHQxQGdtYWls
LmNvbT47IERpbWl0cmkgRmVkcmF1DQo+IDxkaW1hLmZlZHJhdUBnbWFpbC5jb20+OyBEYXZpZCBM
ZWNobmVyIDxkbGVjaG5lckBiYXlsaWJyZS5jb20+OyBOdW5vIFPDoQ0KPiA8bm9uYW1lLm51bm9A
Z21haWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDIvMl0gaWlvOiBkYWM6IHN1cHBv
cnQgdGhlIGFkODQ2MCBXYXZlZm9ybSBEQUMNCj4gDQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIFNh
dCwgMTQgU2VwIDIwMjQgMjA6MjE6NTYgKzAyMDANCj4gQ2hyaXN0b3BoZSBKQUlMTEVUIDxjaHJp
c3RvcGhlLmphaWxsZXRAd2FuYWRvby5mcj4gd3JvdGU6DQo+IA0KPiA+IExlIDEyLzA5LzIwMjQg
w6AgMTE6NTQsIE1hcmllbCBUaW5hY28gYSDDqWNyaXTCoDoNCj4gPiA+IFRoZSBBRDg0NjAgaXMg
YSDigJxiaXRzIGluLCBwb3dlciBvdXTigJ0gaGlnaCB2b2x0YWdlLCBoaWdoLXBvd2VyLA0KPiA+
ID4gaGlnaC1zcGVlZCBkcml2ZXIgb3B0aW1pemVkIGZvciBsYXJnZSBvdXRwdXQgY3VycmVudCAo
dXAgdG8gwrExIEEpDQo+ID4gPiBhbmQgaGlnaCBzbGV3IHJhdGUgKHVwIHRvIMKxMTgwMCBWL868
cykgYXQgaGlnaCB2b2x0YWdlICh1cCB0byDCsTQwIFYpDQo+ID4gPiBpbnRvIGNhcGFjaXRpdmUg
bG9hZHMuDQo+ID4gPg0KPiA+ID4gQSBkaWdpdGFsIGVuZ2luZSBpbXBsZW1lbnRzIHVzZXItY29u
ZmlndXJhYmxlIGZlYXR1cmVzOiBtb2RlcyBmb3INCj4gPiA+IGRpZ2l0YWwgaW5wdXQsIHByb2dy
YW1tYWJsZSBzdXBwbHkgY3VycmVudCwgYW5kIGZhdWx0IG1vbml0b3JpbmcgYW5kDQo+ID4gPiBw
cm9ncmFtbWFibGUgcHJvdGVjdGlvbiBzZXR0aW5ncyBmb3Igb3V0cHV0IGN1cnJlbnQsIG91dHB1
dCB2b2x0YWdlLA0KPiA+ID4gYW5kIGp1bmN0aW9uIHRlbXBlcmF0dXJlLiBUaGUgQUQ4NDYwIG9w
ZXJhdGVzIG9uIGhpZ2ggdm9sdGFnZSBkdWFsDQo+ID4gPiBzdXBwbGllcyB1cCB0byDCsTU1IFYg
YW5kIGEgc2luZ2xlIGxvdyB2b2x0YWdlIHN1cHBseSBvZiA1IFYuDQo+ID4gPg0KPiA+ID4gU2ln
bmVkLW9mZi1ieTogTWFyaWVsIFRpbmFjbw0KPiA+ID4gPE1hcmllbC5UaW5hY28tT3lMWHVPQ0s3
b3JRVDBkWlIrQWxmQUBwdWJsaWMuZ21hbmUub3JnPg0KPiA+ID4gLS0tDQo+IA0KPiBSYXRoZXIg
dGhhbiBnbyBhcm91bmQgYWdhaW4sIEkgZml4ZWQgdXAgYWxsIHRoZSBjb21tZW50cyBtYWRlIGFu
ZCB0aGUNCj4gYXV0b2J1aWxkZXIgaXNzdWVzIHRoZW4gYXBwbGllZCB0aGlzLg0KPiANCj4gRGlm
ZiBmb2xsb3dzLiBUaGUgb25seSBiaXQgSSdtIG5vdCAxMDAlIHN1cmUgb24gd2FzIHlvdXIgaW50
ZW50IHdpdGggdGhlDQo+IHRlbXBlcmF0dXJlIGNoYW5uZWwuIEkndmUgbWFkZSBpdCBhbiBpbnB1
dCBidXQgc2hvdXQgaWYgSSdtIG1pc3Npbmcgc29tZXRoaW5nLg0KPiANCj4gV2l0aCB0aGlzIGRp
ZmYgYXBwbGllZCBvbiB0b3AsIGFwcGxpZWQgdG8gdGhlIHRvZ3JlZyBicmFuY2ggb2YgaWlvLmdp
dCB3aGljaCBpcw0KPiBvbmx5IHB1c2hlZCBvdXQgYXMgdGVzdGluZyBmb3Igbm93IGFzIEknbGwg
cmViYXNlIG9uIHJjMSBvbmNlIGF2YWlsYWJsZS4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEpvbmF0
aGFuDQo+IA0KDQpIaSBKb25hdGhhbiwNCg0KVGhhbmsgeW91IGZvciBmaW5kaW5nIHRoZSB0aW1l
IHRvIGZpeCB1cCB0aGUgaW5saW5lIGNvbW1lbnRzIGZyb20gdGhlDQpwcmV2aW91cyByb3VuZHMh
IEkgaGF2ZSBjcmVhdGVkIGEgcGF0Y2ggZm9yIHRoYXQgYnV0IHdhcyB1bmFibGUgdG8gc2VuZCBp
dA0KeWV0IGJlY2F1c2UgSSdtIHN0aWxsIGNsdWVsZXNzIGFib3V0IHRoZSB0ZW1wIGNoYW5uZWwu
IEFwb2xvZ2llcyBhYm91dCB0aGF0DQoNCkFib3V0IHRoZSB0ZW1wZXJhdHVyZSBjaGFubmVsLCBp
dCBkb2VzIG1ha2Ugc2Vuc2UgdG8gc2V0IGl0IGFzIGlucHV0IHNpbmNlIHRoZQ0KdmFsdWUgaXMg
cmVhZC1vbmx5LiBBYm91dCB0aGUgaW1wbGVtZW50YXRpb24gb2YgdGhlIGNoYW5uZWwsIEknbSB3
b25kZXJpbmcNCndoYXQgd291bGQgaGFwcGVuIGlmIHRoZSBjb25zdW1lci1nZXQtY2hhbm5lbCB3
b3VsZCB0aHJvdyAtRVBST0JFX0RFRkVSDQpoYWxmIHRoZSB0aW1lPyBJcyBpdCBub3QgcG9zc2li
bGUgdG8gc2tpcCBpdCBvdmVyIHNpbmNlIHRoZSBjaGFubmVsIGlzIG9wdGlvbmFsDQphbnl3YXk/
IE9yIGRvZXMgdGhpcyBkZWZlciBlcnJvciBmcm9tIHRoZSBjb25zdW1lciBtZWFuIHRoYXQgdGhl
IG90aGVyDQpjb25maWd1cmF0aW9ucyBmb3IgdGhlIHN1Y2NlZWRpbmcgYXR0cmlidXRlcyB3aWxs
IGJlIGJsb2NrZWQsIHdoaWNoIGlzIHdoeSB3ZQ0KaGF2ZSB0byByZXR1cm4gcHJvYmUgaW5zdGFu
dGx5Pw0KDQpPciBwZXJoYXBzIHdlIGNhbiB0aHJvdyBhIHdhcm5pbmcgaW5zdGVhZCBpZiBhIGRl
ZmVyIGVycm9yIGlzIHRocm93bj8NCg0KCXN0YXRlLT50bXBfYWRjX2NoYW5uZWwgPSBkZXZtX2lp
b19jaGFubmVsX2dldChkZXYsICJhZDg0NjAtdG1wIik7DQoJaWYgKElTX0VSUihzdGF0ZS0+dG1w
X2FkY19jaGFubmVsKSkgew0KCQlzdGF0ZS0+dG1wX2FkY19jaGFubmVsID0gTlVMTDsNCgkJaW5k
aW9fZGV2LT5jaGFubmVscyA9IGFkODQ2MF9jaGFubmVsczsNCgkJaW5kaW9fZGV2LT5udW1fY2hh
bm5lbHMgPSBBUlJBWV9TSVpFKGFkODQ2MF9jaGFubmVscyk7DQoJfSBlbHNlIHsNCgkJcmV0ID0g
aWlvX2dldF9jaGFubmVsX3R5cGUoc3RhdGUtPnRtcF9hZGNfY2hhbm5lbCwgJnRlbXApOw0KCQlp
ZiAocmV0IDwgMCkNCgkJCXJldHVybiByZXQ7DQoNCgkJaWYgKHRlbXAgIT0gSUlPX1RFTVApDQoJ
CQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIC1FSU5WQUwsDQoJCQkJCSAgICAgIkluY29tcGF0
aWJsZSBjaGFubmVsIHR5cGUgJWRcbiIsIHRlbXApOw0KDQoJCWluZGlvX2Rldi0+Y2hhbm5lbHMg
PSBhZDg0NjBfY2hhbm5lbHNfd2l0aF90bXBfYWRjOw0KCQlpbmRpb19kZXYtPm51bV9jaGFubmVs
cyA9IEFSUkFZX1NJWkUoYWQ4NDYwX2NoYW5uZWxzX3dpdGhfdG1wX2FkYyk7DQoJfQ0KDQpJIGFs
c28gZm91bmQgb3RoZXIgaW1wbGVtZW50YXRpb25zIHdoZXJlIHRoZSB0eXBlIG9mIGNoYW5uZWwg
aXMgY2hlY2tlZC4gVGhvdWdodA0KVGhhdCBtYXliZSBpdCdzIGEgZ29vZCBhZGRpdGlvbiBmb3Ig
c2VjdXJpdHkuDQoNClRoYW5rcywNCg0KTWFyaWVsDQo=

