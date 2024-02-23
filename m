Return-Path: <linux-iio+bounces-2925-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 279BD861027
	for <lists+linux-iio@lfdr.de>; Fri, 23 Feb 2024 12:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB62CB2362F
	for <lists+linux-iio@lfdr.de>; Fri, 23 Feb 2024 11:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD78F657D6;
	Fri, 23 Feb 2024 11:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OuAsMMKo"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B94604D0
	for <linux-iio@vger.kernel.org>; Fri, 23 Feb 2024 11:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708686615; cv=fail; b=FEdnZqoQTv5o8XAa1VBdsJDYmPmgfT6R4ZqpJ8SmHWCec23XMMtbqjXCUlgdYKPnDgtPFSeZGs6EaDfP/1D2Y407y98HH4yDcpWNvYZJxTf9QtQTVOLULUf3Sht4a2+EbNKyfesDVFjzrUe5T7ekBI6BvqYyrs3wDg7U1p32c80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708686615; c=relaxed/simple;
	bh=P5jr6HWYCJcanI5rxbDS8SuK2F6eBlKEA8Y1yLCSSYY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GuNJ/pyqh6WvESW6Vf1viYJdHW0jdc68b/SoVMSzXQaE2Tl65T1GfRMYN9z6qE2SPFNqc1YERN4hlirTKPuGSZcL1OsrOJAmKyDJ/gdDOIJljpNlvfGEuB/ZmLkVPtMcW54RM6KU4mCh550xurfbl5wBUCfUdOwDrxf4sg1YP6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OuAsMMKo; arc=fail smtp.client-ip=40.107.20.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLj//O/XD2fvTxSMjJwqO919AMTtY3JfoaA0RZD4ehyiQ4Cn58wRJ38NGmKVjVVO+5+phzC0eLJmoWoHjPbXAPKBUhqtNFHKfe1rGn4XZACTy/1XIpOl31UlJyheM7vbOER54Ny4k4X/eR/eYTdcQxD8vkLRR54Tlt3JPxMQpkWFFL5Hn3+Iw9rVMWfa+KpZW3EyL/owE5p2w85XdmDsvq0GH0A8ceVpk7OXznt6DrQj3Q/dP8UFeH2utzW6pTeSSF4N7trwS2/J/hFPspKzNCM0Dm8jbTZJQsmJw4m6MWwAqphWavXoxIbb2V5MTh/jym3aDIKH4/fdwJ2ZkIemUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5jr6HWYCJcanI5rxbDS8SuK2F6eBlKEA8Y1yLCSSYY=;
 b=WT3G0Jo3fiyywwuyw5SUtOolEZBljHrLHdB7jZmHerOzSQFJE+vd6mKGTcOEs2eOSVRdkrsZjm+26tGlxiWsAaYerM8w27btWeDLjxP8W23P7ClrceUQKIYVgf+IuWRNCtcYe5c+vvqYcXhABfSKqurv3ZcFk2oPPh1jOcVZ4tAETKpYzoF6wX+wVkrvdfMfQIVkVsYhyeTU0B9DUVDvGNs7b/J9ujb/OPu94t8sJtHeicX1Z6WUP+PtvDxfsw7viXRe6dI36t6mUDWgYPPLKUCtNRZ1OOXyxRL0U/6S1OoBzYM2v6vXWqpapVp/R1BAZV+FDCqxt7Fe3vnwdaShFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5jr6HWYCJcanI5rxbDS8SuK2F6eBlKEA8Y1yLCSSYY=;
 b=OuAsMMKoPtZc7pk7keSP73yYKGVlqCkTHAMpwf7DsuGzAQjlOoDekQWo7BdUb8OXqSS6iTdfUGg6IWFPgazyLTLuZv27XHP8PueItk6+OEJfYTIKeOVEQ+uTmjOjbIua1riYy9+fUvpXOkWzFTx5UlgUnPHdnc8ZZONZF0Kqk98=
Received: from AM0PR04MB5267.eurprd04.prod.outlook.com (2603:10a6:208:d0::12)
 by DB9PR04MB9749.eurprd04.prod.outlook.com (2603:10a6:10:4ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Fri, 23 Feb
 2024 11:10:10 +0000
Received: from AM0PR04MB5267.eurprd04.prod.outlook.com
 ([fe80::ee0a:4476:b8f7:9530]) by AM0PR04MB5267.eurprd04.prod.outlook.com
 ([fe80::ee0a:4476:b8f7:9530%4]) with mapi id 15.20.7292.036; Fri, 23 Feb 2024
 11:10:10 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
CC: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	<Michael.Hennerich@analog.com>, =?gb2312?B?TnVubyBTqKI=?=
	<nuno.sa@analog.com>, Alisa-Dariana Roman <alisa.roman@analog.com>, Sean
 Nyekjaer <sean@geanix.com>, Andreas Klinger <ak@it-klinger.de>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH 6/8] iio: accel: mma8452: Switch from of specific to
 fwnode property handling.
Thread-Topic: [PATCH 6/8] iio: accel: mma8452: Switch from of specific to
 fwnode property handling.
Thread-Index: AQHaYo/V0Mkq/f94FU6Y8PKNG76FGbEXzB2A
Date: Fri, 23 Feb 2024 11:10:10 +0000
Message-ID:
 <AM0PR04MB5267DE786F92A83E0805304090552@AM0PR04MB5267.eurprd04.prod.outlook.com>
References: <20240218172731.1023367-1-jic23@kernel.org>
 <20240218172731.1023367-7-jic23@kernel.org>
In-Reply-To: <20240218172731.1023367-7-jic23@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB5267:EE_|DB9PR04MB9749:EE_
x-ms-office365-filtering-correlation-id: b103814e-74d4-4fd5-6ad5-08dc3460004d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lwa+uK39n+EjXRGOA0ckTtn7j64PMys78ufwGu4WRxyJ/fG4aT1pq+RXiz+jcA3n+NNeRW3Icyjmhw6BzQMMJYU3GZC2P5JJ+I22xuEDQ8t+NeN8wpP6UxOX2Fsv1Oso8PWapkVD2hKMAdak8Hgcs5Lf5bOOuXMsFZPQCklWPiS8t4Dti8PrcFJXb7bVV4CJNazh3Cjr+95W3wHT4Coif+Bkah9kKnuhF5gNY6gi/4TnTYn4jTl+mOV2XU/ZyDGfT0CaOAz22Jg92JFFWx+jX3GQYp/RkzuYPfqEd99g37tRXCUFy35t9r69Sup15xS7LaeTGmlEgrIBaYDecH7HOlKZAj1qXBgM/jBusUR13Kc9mjnO5JPYzPYvqMGDw8hlydPYph4oFJkm4Zj0phnJFXeznVFr6s6jx9wRy/I2Ccc/t5VMi6XAMyCfnuSfIuPrR9Y2SYv3O4FXBL8nCTZytKMT7MO1qOCpRGoaUkIx4poVktxJ5j3nkfSKF2s+0+OafPskwitJW1m58OBCbC4+OWYQYpkNZ+nIP7rkVMXnUV/IJjLu3tfAnTbfMlNNOwlE+Ww6h5EQpxjbxkucdITD0c3YW9mmHfH8TqRth15Ni1QXstVicjW3l7BgeQDUB6kB
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5267.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?R2pFOCtaNDNMaHRJeU8zajMvNW03bmdmeklWbDBqWVJVM2NwVkZCL3AwQk1w?=
 =?gb2312?B?WGIwM3NVUlR0Sjh3MHNXNzZ6eVhnVHhmeDl6NEtXWDRxVGw4NVZ4a0tzdWVr?=
 =?gb2312?B?S2RmT0t3ckRJUjM4N3haOWdqN2VqcEJXMW1veFU4NytLcXpKRVdKTW1DU0Zs?=
 =?gb2312?B?bms5eTZlVXdVbStxcjhFN1htbkNzcmxoei91am5lMXgzcGtWK2NJa1BrUHZW?=
 =?gb2312?B?aWN0ZUl6a0pWMGRMSVpYanBZU1FFTUtmUzQxVkN0MCtESnJlZlJ3dU4wNUJk?=
 =?gb2312?B?OU8wZ0RYdlpTVzhMNEl4Z3lDVlBINXlQbmNsYmtHNjdwYjdlR3VoZVdjT2Zj?=
 =?gb2312?B?SmNKSXhCT1hETzlmMzdNTmx0R0FUSmVHeDlETGw3WXN1YnBpbjI4L2ZiZGxT?=
 =?gb2312?B?L20yanpPVEl1aEp4Yy82T0dKcCthTDY5ZWdGc0hiVFJiUnlvYmt3L0d0dEli?=
 =?gb2312?B?NkZKVUdNU0F4MHBNL2laTWxFSldYdDd5VHhBU0tRWm41WnlNMDhwbWRKSEt3?=
 =?gb2312?B?M3B3SnprSnhGNTByYjhJRWlZTTE1UlIwSmh5ZWlmUDl3a1RxR2xSaHpxN3NY?=
 =?gb2312?B?Tmp4YXpTcEFBbkFleUZHSHhMc3RiRWdzOEtXdThSZUVKcFFJelRTRmRBUkxJ?=
 =?gb2312?B?b00wQVV3YWJXRmdaQUlJYW9uQlhzaGJ6UG84Tmw1T3cwNWR2Z244d1J5aW1F?=
 =?gb2312?B?dU1OSmZjU0RjQ0VvQnFVMGtuVE1zR3FkQ1F5MVRqcFhmRTFYK2lUbndvNnha?=
 =?gb2312?B?UkNXRExBTnlKWjgzUFNzWHp4bFVaeE1iTGozNklrZThqanpRenRDTEFLUnNi?=
 =?gb2312?B?ZGwraWlIZkE0c1N5WTY4R0U4cE0vUzdMcWxsRkJ2blBYeDFLSkp6R0tTS25B?=
 =?gb2312?B?ZjVUY1ovdkEyN2JhY1h5WmE4YnpJZUIvWkd2dVdSNlU1VVBPdVFOcUNKcDV0?=
 =?gb2312?B?eFpvNTgvK2RZSlVFRUhxalpSdUlYMXFtMi9RMjJ4aHo5VnZDbFZHYmY1dktP?=
 =?gb2312?B?UTRtV3hyVUVMNnBTRXhmeVFlcGo1SjlPRThOZWVrWGxmYkxSeWxFZDdGdjZr?=
 =?gb2312?B?TVBCeWNyMFRpUFBOVnRXTGkxMmdEcTNid3lXRDU4OEYwSlFmWjJ2YU9vanVh?=
 =?gb2312?B?ZkJLa2lnbFc1cmJmejVxYjdNbSs3bEs4V3dkZmlETlBOUW5kM2l5R1l6amd0?=
 =?gb2312?B?R0k2SVBhNmxvd2xCckt0dGU4SE1hSTR3cVQ5KzFDWXdBMEp3NWh6bEZ0V3Qy?=
 =?gb2312?B?ZDRkTkZXWkU1Um1GQVFDWloraUtUZmNrVDJWK3o2RzJrQ2N1RTlHWG9wTlVX?=
 =?gb2312?B?QWpyRi8xOWxzamxmS0hYS0tSL0xmZ3pHOTJBRHNnTzcrN3oyT1dZeEJtR0FE?=
 =?gb2312?B?RFlIYUtxaXJBMGZVaVU2MWM0N2JEbmJxNTZkVWtuZlNON0tiT3NkelQ2MlZV?=
 =?gb2312?B?L0dzeUdhMzN5VVVPaThmVjRXaCsxWTBKa2JDeVpuNDJ4alM1Z1pVK1VTbTZx?=
 =?gb2312?B?bGI5M09pWTAxb0tNU0FOcklZRHMrWnVYUDJOTUdsL1dCRVhXVDJUVFJRMkRC?=
 =?gb2312?B?ZW95dEY0L05kK0tEelN3Q1d1bG1CU21BSHhIQlptQzMvUDNYRzI5dy9UWEtE?=
 =?gb2312?B?Y0RwQkhmNTR1cVMwNlVpRktzejhXUDQwQUpGMUdvSHQwZVBvUldvQnFXT3E2?=
 =?gb2312?B?eWdrR1Q4MFpvaExOTlVmeGFQVGFreXFLcTZRRTJscUVXdHdNQU8vUDhtODE5?=
 =?gb2312?B?VXFWak9WWTh1UHZpYzRxZzJXdlBzWHZydFczWWFWdTRiQ1VzRzQxTE4xZ1Nx?=
 =?gb2312?B?NUlkRkwxdzg5b09nWmNKU2NDem0zY3RjZlF6VW1KUVN5N3BiK3FQaVhZRWpP?=
 =?gb2312?B?SFdkLzhYaFYrZDlsYkw5RUF1N2VWamphcmJNN3Znb1lMeGpNMFNibFo0Nk5X?=
 =?gb2312?B?eE5nZE5kTnVqL3dRNE12Y2RLWlN1VWRuWnBTUGlYeHVCSXU3WHFjVWVGUHBB?=
 =?gb2312?B?ZFNsaE5IK0FJZWltWHdaU0JKR0lCWDNrcElYU3NIcksxNlI4L0xCekdNc2tz?=
 =?gb2312?B?M0ZmM0c5eUtRYTg3QlJVYTBCdTI4NnkxWXF1b2htZkNGaXdOay9VNm5IWk1m?=
 =?gb2312?Q?kUSI=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5267.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b103814e-74d4-4fd5-6ad5-08dc3460004d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 11:10:10.6061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /7/uus45TENKt3VRTpv5+ysI989WJd3LJEk5qjvI3k70W8F1dDiiMo01hZyKGeXxVrL/6/7+bFyg2OTBsqeq1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9749

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxq
aWMyM0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDI0xOoy1MIxOcjVIDE6MjcNCj4gVG86IGxpbnV4
LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IEFuZHkgU2hldmNoZW5rbw0KPiA8YW5kcml5LnNoZXZjaGVu
a29AbGludXguaW50ZWwuY29tPg0KPiBDYzogTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFm
b28uZGU+OyBNaWNoYWVsIEhlbm5lcmljaA0KPiA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNv
bT47IE51bm8gU6iiIDxudW5vLnNhQGFuYWxvZy5jb20+Ow0KPiBBbGlzYS1EYXJpYW5hIFJvbWFu
IDxhbGlzYS5yb21hbkBhbmFsb2cuY29tPjsgQm91Z2ggQ2hlbg0KPiA8aGFpYm8uY2hlbkBueHAu
Y29tPjsgU2VhbiBOeWVramFlciA8c2VhbkBnZWFuaXguY29tPjsgQW5kcmVhcyBLbGluZ2VyDQo+
IDxha0BpdC1rbGluZ2VyLmRlPjsgSm9uYXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBo
dWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggNi84XSBpaW86IGFjY2VsOiBtbWE4NDUyOiBT
d2l0Y2ggZnJvbSBvZiBzcGVjaWZpYyB0byBmd25vZGUNCj4gcHJvcGVydHkgaGFuZGxpbmcuDQo+
IA0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+
DQo+IA0KPiBJbiB0aGlzIGNhc2Ugb25seSB1c2Ugd2FzIHRvIGdldCBhbiBpcnEgc28gZWFzaWx5
IGNvbnZlcnRlZC4NCj4gQWxzbyBpbmNsdWRlIGxpbnV4L21vZF9kZXZpY2V0YWJsZS5oIGZvciBz
dHJ1Y3Qgb2ZfZGV2aWNlX2lkIGRlZmluaXRpb24uDQo+IA0KPiBVc2luZyB0aGUgZ2VuZXJpYyBm
aXJtd2FyZSBoYW5kbGluZywgdGhpcyBkcml2ZXIgbWF5IGJlIHVzZWQgd2l0aCBvdGhlcg0KPiBm
aXJtd2FyZSB0eXBlcy4gVGhpcyBhbHNvIHJlbW92ZXMgYW4gZXhhbXBsZSB0aGF0IG1pZ2h0IGdl
dCBjb3BpZWQgaW50byBvdGhlcg0KPiBkcml2ZXJzIGxlYXZpbmcgdGhlbSB1bmFibGUgdG8gYmUg
dXNlZCB3aXRoIGFsdGVybmF0aXZlIGZpcm13YXJlIHR5cGVzLg0KPiANCj4gQ2M6IEhhaWJvIENo
ZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gQ2FtZXJv
biA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29tPg0KDQpSZXZpZXdlZC1hbmQtdGVzdGVkLWJ5
OiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL2lp
by9hY2NlbC9tbWE4NDUyLmMgfCA2ICsrKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9h
Y2NlbC9tbWE4NDUyLmMgYi9kcml2ZXJzL2lpby9hY2NlbC9tbWE4NDUyLmMgaW5kZXgNCj4gZDNm
ZDAzMThlNDdiLi42MmU2MzY5ZTIyNjkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2FjY2Vs
L21tYTg0NTIuYw0KPiArKysgYi9kcml2ZXJzL2lpby9hY2NlbC9tbWE4NDUyLmMNCj4gQEAgLTE5
LDYgKzE5LDggQEANCj4gICAqLw0KPiANCj4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4g
KyNpbmNsdWRlIDxsaW51eC9tb2RfZGV2aWNldGFibGUuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9w
cm9wZXJ0eS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2kyYy5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4
L2lpby9paW8uaD4NCj4gICNpbmNsdWRlIDxsaW51eC9paW8vc3lzZnMuaD4NCj4gQEAgLTI4LDgg
KzMwLDYgQEANCj4gICNpbmNsdWRlIDxsaW51eC9paW8vdHJpZ2dlcmVkX2J1ZmZlci5oPiAgI2lu
Y2x1ZGUgPGxpbnV4L2lpby9ldmVudHMuaD4NCj4gI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+IC0j
aW5jbHVkZSA8bGludXgvb2YuaD4gLSNpbmNsdWRlIDxsaW51eC9vZl9pcnEuaD4NCj4gI2luY2x1
ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4gICNpbmNsdWRlIDxsaW51eC9yZWd1bGF0b3IvY29uc3Vt
ZXIuaD4NCj4gDQo+IEBAIC0xNjQyLDcgKzE2NDIsNyBAQCBzdGF0aWMgaW50IG1tYTg0NTJfcHJv
YmUoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCkNCj4gIAlpZiAoY2xpZW50LT5pcnEpIHsNCj4g
IAkJaW50IGlycTI7DQo+IA0KPiAtCQlpcnEyID0gb2ZfaXJxX2dldF9ieW5hbWUoY2xpZW50LT5k
ZXYub2Zfbm9kZSwgIklOVDIiKTsNCj4gKwkJaXJxMiA9IGZ3bm9kZV9pcnFfZ2V0X2J5bmFtZShk
ZXZfZndub2RlKCZjbGllbnQtPmRldiksICJJTlQyIik7DQo+IA0KPiAgCQlpZiAoaXJxMiA9PSBj
bGllbnQtPmlycSkgew0KPiAgCQkJZGV2X2RiZygmY2xpZW50LT5kZXYsICJ1c2luZyBpbnRlcnJ1
cHQgbGluZSBJTlQyXG4iKTsNCj4gLS0NCj4gMi40My4yDQoNCg==

