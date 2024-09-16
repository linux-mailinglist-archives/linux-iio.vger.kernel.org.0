Return-Path: <linux-iio+bounces-9604-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0786979BC4
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 09:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219011C21A94
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 07:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2055381B;
	Mon, 16 Sep 2024 07:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="D5nWmaQc"
X-Original-To: linux-iio@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013008.outbound.protection.outlook.com [52.101.67.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADBB1BDC8;
	Mon, 16 Sep 2024 07:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726470169; cv=fail; b=st28p0aOR1V0V9hwtkuVAPbchaxx/fUiBQnJq8pkcAoqO2BywL0yMWfFBytTfJq43pJU+/w7spYJ+Z57r8Xzm0HtwlBon+6eKZEXGrLN2ZR+IhI5HqAV2T9ZZD3mtyWAcHyUOxhm3HKTO+fBrSGLdERJlC227+qwoHHa+GXZQu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726470169; c=relaxed/simple;
	bh=QXB1gVPR8gx7YdJq5xLjHtfg9amXYfujxL9OyoWE1JQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mw+2lWrglBdxtf9Y7I1mEntNBfLL4Y1ziLbuV5RCQsaxUfhXDIkW626WWe178zTiko9NIp2kxMIwwCJ3yvxzn8TKi63ik7aCNxBc0O6ThiaG7xARZMaBcsunO8afmI6ZJkXa7RZZODiB9CJ/RpNINE4gMrepR0Isf8B7QC2cdrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=D5nWmaQc; arc=fail smtp.client-ip=52.101.67.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+5ccvkmgvnDpaR93Xyl+3ZaT0Kp35WYGHa2urEEpvY+WgaeFG1AhL7TZD4zdRYo6pOz/vahdGJ9dTdT9Rs95QJ0IheqYi6xkcS6M0rMhO1ABPclVhVeQtnaBhqV1+KSBvUg8FrccKOpLL+P6mGrSrFISKHl/IJcUxb2v1qHax7UmOwN8Q9+cVCKun2sQrKIG9x8LKWBPVVasB3vOWAOUYtfmgkxQl+WjqDTD0t3NvscGLun8jqijqrSqOaHZN3L3sUlPG6rjksjhv4fYnjzR+13gHikb8NgYyCOCSaAZaR1B3m3eveFaoCId6E4DXxhII0080RFj6imAhnUDhwtWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXB1gVPR8gx7YdJq5xLjHtfg9amXYfujxL9OyoWE1JQ=;
 b=NtUDzptOQI5y/BojQJ9wBBrWXaV7fUn1Z3HrYtZ/QGoLDgPzAuLGq/xxbp1XCHEW0qa+PmXu5kHqhqCU2pLQv0HiomvE+1KKhPUzXC6xDMRch1gzYJic15Hha184VV6yKwD4oRv2LGc9PT+ikd8pNA81DjbyV7HasKfxuLo+lltuNzuTu3l3uB4V1oTK/AyU6N8+bwNs43SqyvvD2RsGK3uzKGo7yOYs7B51pqOZp7wWggbcezNiyMDm+UgUQOGRJJ2Y+nbS/OLCXu2tC53p7Qz4CCtNJ/rS999me0Ooxdj6wpYvtXFZoq6Rnb+VBrq3EG3him4ZPBfuzfGw8DhQ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXB1gVPR8gx7YdJq5xLjHtfg9amXYfujxL9OyoWE1JQ=;
 b=D5nWmaQc3RA9A9nAkPWY98lHi6j9TG2LmE6m4vFuAYYCkxVuarYVH5ocZKYEIVrwuB/aBglH65ltsoon+/mIrU5bAuIYBd4A1xGfVtWplgQrV4/Vpi5DyZQVLDU7YHOKFqYIx7YnF4RrAQZjkzlVyJsLcjESt4jYxl6vUtVkELE=
Received: from AM7PR02MB5784.eurprd02.prod.outlook.com (2603:10a6:20b:de::15)
 by DU0PR02MB10424.eurprd02.prod.outlook.com (2603:10a6:10:477::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 07:02:43 +0000
Received: from AM7PR02MB5784.eurprd02.prod.outlook.com
 ([fe80::33dc:f613:4b96:46aa]) by AM7PR02MB5784.eurprd02.prod.outlook.com
 ([fe80::33dc:f613:4b96:46aa%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 07:02:43 +0000
From: Emil Gedenryd <Emil.Gedenryd@axis.com>
To: "jic23@kernel.org" <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dannenberg@ti.com" <dannenberg@ti.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "lars@metafoo.de"
	<lars@metafoo.de>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Kernel
	<Kernel@axis.com>
Subject: Re: [PATCH v2 1/3] iio: light: opt3001: add missing full-scale range
 value
Thread-Topic: [PATCH v2 1/3] iio: light: opt3001: add missing full-scale range
 value
Thread-Index: AQHbBcNWXu+pemrmGUy/SjJ4CJwNl7JXdI4AgAKMxAA=
Date: Mon, 16 Sep 2024 07:02:43 +0000
Message-ID: <0b8817a2fb702a2a73a51ca47a350dc8c9085fb3.camel@axis.com>
References: <20240913-add_opt3002-v2-0-69e04f840360@axis.com>
	 <20240913-add_opt3002-v2-1-69e04f840360@axis.com>
	 <20240914170622.227911f8@jic23-huawei>
In-Reply-To: <20240914170622.227911f8@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR02MB5784:EE_|DU0PR02MB10424:EE_
x-ms-office365-filtering-correlation-id: 56d3325e-5bf3-4e7b-2f31-08dcd61d8f89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M1dMVVhyR2J1RlJTNVJtR1lIVUlLZWJuN040RXNWSTR5UXB3UGVCNHVVcGQ5?=
 =?utf-8?B?VXFXbHljYlVKRXVtL1VRYmVxMVgrY0NFK3pWK1JLVDhpaUt2a1I5QVFOUFVK?=
 =?utf-8?B?MktHZ24yYk82eG1JS2lrNVNPMWJCU2R0U2VzR2dXUnVKNkh4YWxnMUVvTzJU?=
 =?utf-8?B?R3dnU2J1Q0xDZWU1QkNjaVd0Vk5pa2x3Z2JaRTNSK2FQSTVnaDNUaTlWL2Ex?=
 =?utf-8?B?azRkczFhUWVNTUJtRWc0Umdic2VtT0h1cXlyL3JWZHF6STYzdjB2TERId3Vv?=
 =?utf-8?B?L1VudzdlVzNBS0Y1aVdrSUtSYkxFNG9kTkZaTDFDVlBITFBLOXVHNWtlTWVp?=
 =?utf-8?B?SlBDSlZ3bXh4VlA0ZnZkbzRuUS9uTE9PQk1pcytsZUhNcGFQbzhLUWxmWHhF?=
 =?utf-8?B?RUNlMDBGb0ptUU0vS2dLa0RWbm0rcG5PRlEzQXBFT1FPa25UckMvKzI1Q21E?=
 =?utf-8?B?eW1iSmluaVl2S2JuWDg5ZEhrOWhVMCtHdlJHSjllWUVDaE5CYU13Y3FoYUlB?=
 =?utf-8?B?b1ZqZVRaQlFuUXFBbjR1aGRVTGQvTThOU0tFQWx1bndTSGVZaktUSk9wK1gy?=
 =?utf-8?B?NHcyVFdOd3lralNlKzVROW13eGlUR0RRalM2Wmo4MVZTUXI5Yk9wQXF0UDA1?=
 =?utf-8?B?cThIbmg4U2Z6anJmWTVmWUxoa05FVXkxb1pneldyeHJMZlBwNU9rOTVnajYv?=
 =?utf-8?B?WlJLOGtNSUtNWE81V3prU1B1K1IyRVNYUm45QjAxRTFPOVZwTEVhMGFhaEo2?=
 =?utf-8?B?U3Zlc2xKOU1JUWJhL3kxRVVoZjk0T3RrckxGSExNSGUvR2Y0TG1pRTJKRTU4?=
 =?utf-8?B?QkJ1NkNiY3ladCthOUlwT0RMQ0ttaTFSajBYZjRkMXJBWFB2OW5FbDhoV1hj?=
 =?utf-8?B?ajA1NFV5V0JNZFV2ck1BbUNGV2pacE9TeFpOUFRTWXR2bklSSWtaTnZic0JD?=
 =?utf-8?B?aGFtcGpZMTdVMFlzUXBvQUJ3OFdoK2U5VXhUc29tWWI0WCtyTTlMTUFUUFEz?=
 =?utf-8?B?ay9jN1cxVEl3MWthRnNpWG1sblpTYm1RS3dDM0hBTlJrYTd2UjdpV3ozZjhC?=
 =?utf-8?B?YWlkbHVGek9sTzJ3U29LenQ0LzJvMzIxZ1BiT2l4QVh1TEhKQ3BqbWdrR09s?=
 =?utf-8?B?VmNpMnV6ck14Rzg0VnNpV0puSEgycFZDY0hKbk5IVXEreDMrTjkySmE5WlJL?=
 =?utf-8?B?U1dFWnFKUHpuWkpwempDeGo1aGhpMEJnNDYyWXMxaEU2YjFXaFY4dWs0T2J5?=
 =?utf-8?B?S0lQeGhncVZqMTNqclVaSjlZNk1WajBPM20wVlFyNWZ5Z3M2NWt6TUNUWDVF?=
 =?utf-8?B?Q1RiT3k4cGlCc0xmQXVaKzU3THFDeUZGTmprOWNRaGgwbkRsbWc2TCs5WUg4?=
 =?utf-8?B?cWdNdVU4djk2YWZ2TjNpdU9zS3RXOHFkTS9DYzJvUExJNXhsaDFmTFI0VFlO?=
 =?utf-8?B?ZmlIeUd3bEd0VjU2YnE3ekkwR2owVHI2cFRJTnJ2UkJaV0g3ZmFHTXNiaHUz?=
 =?utf-8?B?UHdVczVBQWNzV09WVG9OZlVhQytKd0p3UmxOTE5uL25lQ1hRbzV1MEJXVEl0?=
 =?utf-8?B?UzZPZVRiRWdjUTdRQk5iWmNnS1crblFCTG8vbFF1Q3VlT05HR3VzdzRXdWo5?=
 =?utf-8?B?Q1psVzVsSFZKUDg2bGFDZHVRR1FPb1NEQS9UWHk5OHZjdlh4UmVuMlRLWFVr?=
 =?utf-8?B?UDV0TUorVEFPWjJxRmk5R2ZiTGlEVTVzOHpCZDdIemxFby9XdXZGankvYXNP?=
 =?utf-8?B?ajRCYVNLRVpnZG9iTkphR09MdERtTWxwWllyd2NUTFROcUsyNWRYRzlLTGpq?=
 =?utf-8?B?a3pPVC9LNE04NncwUEpRU0xhRnh6Ni9NV1I3Ymx5dGUxYnBsSGowNUgybnRy?=
 =?utf-8?B?UXk4Zy9kUkZtdk5DYTl2bGYxTUNTampEYStoMHphM1NyNkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR02MB5784.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RnZraTlGRHcyT3gzVGdsc3grYXpYUXUwZmhKK2JNWTVzVEViTExmbFFJU2Q4?=
 =?utf-8?B?T1ZHcnNaaVpsMFVla2l4N2JsMkM4SnE0YnF3OEtIWkgyZ2JRaVF5UnpmU09K?=
 =?utf-8?B?Nk5QZUpUQUxxZGRvSWZGbU1pZS84TFI1K1ZhMmNUL21xNGRweENJRDExdzhh?=
 =?utf-8?B?SitoUUFoemhFcmxMeGk0ZVh6eE1ra3RTUW9aZDNtUk1UUjdRMUdQNVBnTU1j?=
 =?utf-8?B?NzRHdmEwWWZiWW5lVlNNV3h0RDRiUkpsYXFBYlFDeVNmTWt2aWJyYjIwYU9a?=
 =?utf-8?B?N3R5bHlleWtYc1ZucC9vaE4rQlZTZU02Wm4rRWdaVEZuSEZYczFLSndYSjQ2?=
 =?utf-8?B?amU0TEVjZ3FsS2c1Z1Y1VjdUMHA3TG1ra0drczhQZjdzazFnZXFnWmhBSkZJ?=
 =?utf-8?B?ZFdId0pKcU1jeVU5SXdadW9nakFCUTcxUVJ1SGY1ME9IcEtWUEdSOHNSQUlX?=
 =?utf-8?B?TmQ2ZnBmUXo3L2V3M21jM1Awd09OdS9uaGdRZmIydXNCRkhBVXp2ZmNNam1G?=
 =?utf-8?B?SERKT2UraTY3MjExWHNzazhpZ3NjUXVrdFZuN0R2YW43ZWFBa3JYTVd5MUQv?=
 =?utf-8?B?MDdwYkluS1liOVpqVS84U09Jbm1lcDM4aUErcmpBUnZzU3dyNG1XaGQ5VVhq?=
 =?utf-8?B?bWxHS3J3Z2VOSmVvckcvTEZ5VEdJb0ZlanRpY0g2YU9XbVB1OG13SWdJcEtO?=
 =?utf-8?B?dTZhR29zdGRQQkRzUy9OUUIvSXdEMW1zRlBMUElLQThxUGRGTitzOHFEeWFk?=
 =?utf-8?B?cVpzQmlCdHVkdXMxejA1YlR0NzhuSldFeGN1aUVnSGxHUXpWQTNYMVptRHl3?=
 =?utf-8?B?UjdnditGVmhyRFc5MC9aa2orU3dVQUJ5R1lMZUszaTI0MEs5YWFya2dXMVBj?=
 =?utf-8?B?VHNDSmMwamZoRDNNMWliNjRuaUQ5VXN4RHBEWTVteHlLNVMxSWlHVzEwRDkx?=
 =?utf-8?B?L1VvS3c5a3pVN3dNV0s5WlZaK2RpaStKeGJEREJrQzB3ZlZTK1pRbzhsVGNi?=
 =?utf-8?B?T2FaZjRLL0l5cGg0NHJFRFdyM1ZiK3FacHY0elRTUUtoN0ZzQlo4MGJ3Qi9B?=
 =?utf-8?B?QWV4Y09Valluc2J2WE1VVWtGbkt2eXJnU0ppRTR0NzlET1l0Z05EN2tzQzFO?=
 =?utf-8?B?OW5CNnprd2ZRNnBFS2l6TWlyVVdGWUJaQXlodVc3TW4rVHowLzFFQlVnVC9G?=
 =?utf-8?B?Q1htbVZ5T2JXbnFhK0xxRnpHTHlmZ0w1eDN0SHRkWEZHdS83K05VNUVZc0l2?=
 =?utf-8?B?TlFJQkxzejNLTkhabS9Rb0F0eUk2Z1JkZUI0aEFpM2ZrRkNlT1h0Q3VDY2sx?=
 =?utf-8?B?MUw2VFBjWWRrUitpQ3YyOVRlWjB3UVRMY2RGdnVMajRZRUpkbnJXYVJnY0pw?=
 =?utf-8?B?dG1laXpuNjhyOXVSQ3Z3aVN2RFIwaFZobE5UaWdkRzE0ZGhWbTcrYjF2VTZM?=
 =?utf-8?B?c2E3aW9NVU9UZlRnSnpuR2xWYlVSR3AwL215ejlqdEIrZWNDZG5pU2p0cFJY?=
 =?utf-8?B?VEkvNXRiSGtZR0xFUVVHYmMvTlZScFY0Y2h2NDFNM3RheDhiUTk1aUljS0ti?=
 =?utf-8?B?c2lid1FSbStuVzVYeEtUVEMwanBtbFBEWEJaU1dubzB6dGdYY2hKMXh2Vm1m?=
 =?utf-8?B?RGEwbGJJTHNOQk1VVDJ2WTNMbXdnMGJZbW9ySkJsVDhmbFJYUy9KYS9zQzc1?=
 =?utf-8?B?cW1NejRVNmJORjVobzRPWFBEc0EzcHY1M3g2YzRvSkt0Nzg5Y04zUy9qY0xT?=
 =?utf-8?B?bEhsdW1PZGMvaEgzdjNoOGc0dDdnQndQWUJzNGNhR2pwcFZXUmN5YUVCU0RG?=
 =?utf-8?B?RDZQTEcyUXN5Zm5MVmtPcVdXMFJINHg5Zi9BV0t4NkhSWVVEMmVBWk05T216?=
 =?utf-8?B?UTA4R3h0Yk9jUXJNZTFaekRyVnVJbENoTm5Ra2dOeXRiNUd6MStQVDZFWTln?=
 =?utf-8?B?YXZLMEdBL0YvbTBPMU12a0tFOVZGU3p3Z0NYbGVISWJ6Vy84aDJkMnV6WHQx?=
 =?utf-8?B?WlN1ZitEQzdraElDc1NSMDR0blVacStkTTFpV25YUlZpVjhvSXJoTktpZWtD?=
 =?utf-8?B?T0JFb242TTJDOGk1Y3pzMFp4TVZPOXdGK0RWazhhNUlRUmgrYUtDNEo1VVp0?=
 =?utf-8?Q?8Wf5ox9cI4RQTeZzY5cDoUxyZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <30C70A0A084B2446995D0F52A6EA1FAB@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR02MB5784.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d3325e-5bf3-4e7b-2f31-08dcd61d8f89
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2024 07:02:43.0124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wyCI+qixIqI+wKUHnJUtYFhlKl8RpIqsm9s3zI2I3+jTGMCnS0gNOkW7gbSwIpgv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB10424

T24gU2F0LCAyMDI0LTA5LTE0IGF0IDE3OjA2ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBGcmksIDEzIFNlcCAyMDI0IDExOjU3OjAyICswMjAwDQo+IEVtaWwgR2VkZW5yeWQg
PGVtaWwuZ2VkZW5yeWRAYXhpcy5jb20+IHdyb3RlOg0KPiANCj4gPiBUaGUgb3B0MzAwMSBkcml2
ZXIgdXNlcyBwcmVkZXRlcm1pbmVkIGZ1bGwtc2NhbGUgcmFuZ2UgdmFsdWVzIHRvDQo+ID4gZGV0
ZXJtaW5lIHdoYXQgZXhwb25lbnQgdG8gdXNlIGZvciBldmVudCB0cmlnZ2VyIHRocmVzaG9sZCB2
YWx1ZXMuDQo+ID4gVGhlIHByb2JsZW0gaXMgdGhhdCBvbmUgb2YgdGhlIHZhbHVlcyBzcGVjaWZp
ZWQgaW4gdGhlIGRhdGFzaGVldCBpcw0KPiA+IG1pc3NpbmcgZnJvbSB0aGUgaW1wbGVtZW50YXRp
b24uIFRoaXMgY2F1c2VzIGxhcmdlciB2YWx1ZXMgdG8gYmUNCj4gPiBzY2FsZWQgZG93biB0byBh
biBpbmNvcnJlY3QgZXhwb25lbnQsIGVmZmVjdGl2ZWx5IHJlZHVjaW5nIHRoZQ0KPiA+IG1heGlt
dW0gc2V0dGFibGUgdGhyZXNob2xkIHZhbHVlIGJ5IGEgZmFjdG9yIG9mIDIuDQo+ID4gDQo+ID4g
QWRkIG1pc3NpbmcgZnVsbC1zY2FsZSByYW5nZSBhcnJheSB2YWx1ZS4NCj4gPiANCj4gPiBGaXhl
czogOTRhOWI3YjE4MDlmICgiaWlvOiBsaWdodDogYWRkIHN1cHBvcnQgZm9yIFRJJ3Mgb3B0MzAw
MSBsaWdodCBzZW5zb3IiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEVtaWwgR2VkZW5yeWQgPGVtaWwu
Z2VkZW5yeWRAYXhpcy5jb20+DQo+IEFwcGxpZWQgdG8gdGhlIGZpeGVzLXRvZ3JlZyBicmFuY2gg
b2YgaWlvLmdpdCBhbmQgbWFya2VkIGZvciBzdGFibGUuDQo+IEknbGwgcHJvYmFibHkgc2VuZCBh
IHB1bGwgcmVxdWVzdCB3aXRoIHRoaXMgaW4gc2hvcnRseSBhZnRlciByYzEuDQo+IA0KPiBKb25h
dGhhbg0KPiANCj4gDQpHcmVhdCwgdGhhbmsgeW91Lg0KDQpCZXN0IFJlZ2FyZHMsDQpFbWlsDQo=

