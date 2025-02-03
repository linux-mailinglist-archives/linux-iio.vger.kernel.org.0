Return-Path: <linux-iio+bounces-14957-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEE2A268A7
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 01:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E83F1885D49
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 00:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29E12E401;
	Tue,  4 Feb 2025 00:37:52 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from USG02-CY1-obe.outbound.protection.office365.us (mail-cy1usg02on0043.outbound.protection.office365.us [23.103.209.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89D51754B;
	Tue,  4 Feb 2025 00:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.103.209.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738629472; cv=fail; b=VrZ/WwDPFNKFnnP21YC9jUyy1/2oMe0Cnmamit/pltSJcckgSsNrINaCx7VLqhaZXb6NWz5JmOxmkCIYP0ZH1P8I6I0xRlSU2KxmPk16VrEJV0iDyNxo753YyPcfaCvM8NdjAoXBbuEqQxdDDpce4b6ARI1muwMEYFWhCC5y8AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738629472; c=relaxed/simple;
	bh=aC/Y3Vv403xQbbLVrEtnOe1BWs/2n+2mBr95KgB3478=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AfVm0Oui5wO1IrooghPpQx61dyez4aZLhF+j7s9ZCbvQ48K31VcjhV9AFwNLwivugdJHtnRyFD6R5ROEkmnJb6trlpfeus+vBh53Dk/v7VEPWF0zcUK95l2jyECuMsMP1xI9FSBlMUoCc+vWxAstS5cFeUwewyrJxMrbbwmoTdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arka.org; spf=pass smtp.mailfrom=arka.org; arc=fail smtp.client-ip=23.103.209.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arka.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arka.org
Received: from SA1P110MB1783.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:1ac::22)
 by BN0P110MB1787.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:1a2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.22; Tue, 4 Feb
 2025 00:37:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=WrXXiZyZ18VPCDPnogqeCFgNVduelZKCX5mZU0dMNS381fJk3zK/MY/fnLUR8dZOkTADwgdqUv5PstZBjb+wB3Ze9t+MiyMgPmmMybSrraV5iOyXzv+QXLgWn0h/04PjttNaXT9zmGAxmpYSKcEU5YZRvi2U6zjQW4Rlep4XQBjm4EISJfR689a0nONWRo/jF+ydre/trfTzDetQTS6LaBwnAbI1F2HGtesseaFcxsoBAYIKW9DAJiz9XAdEHI0YUHwFn9XfSQCUR4CQ9p4yXdi13Nf6Itwp94fiLdJJ+qSczOpK5bnYCMtQ6/UbTGW6eQaT7KHT9u/M6bCP1kHqKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8h/Y45Ngv0JgEwaJcooCESN5i1EZaOilZmJrhTKY1pY=;
 b=b3IIZMuoEwOVDopaRpZ26/idwpR61rmkfgAL9tiNNr8SYQe8zwCI1LNjOE3fls/jTNtdxL/MLgAyPx3/Stje9eoSJuVh5Rc85e+BIFa3reOqrBMJ1xWXMgBcBZEeOEoNQHiQPBmP75JVNm5v9keRCzchY+55Ykz5Yx5s04JEou+XlGqxXe12ylCFJkucIQhFcWnieZaRW91ILhz9J8vIk7CROR98Toid0mrU1R80gSV/OF3X33dlZuZSfAVrFraFQiB/tL5vGsibcr2ZtksHT3zLAv7w+fjij2WzU1ZPVpRSHLtsRzQffrQZRx5HFPo+K4I/h98VOZSeaxbI1XF6cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arka.org; dmarc=pass action=none header.from=arka.org;
 dkim=pass header.d=arka.org; arc=none
Received: from SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:170::5)
 by SA1P110MB1783.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:1ac::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Mon, 3 Feb
 2025 13:34:35 +0000
Received: from SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM
 ([fe80::fd7b:b16a:a9df:78e8]) by SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM
 ([fe80::fd7b:b16a:a9df:78e8%5]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 13:34:35 +0000
From: Sam Winchenbach <swinchenbach@arka.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"antoniu.miclaus@analog.com" <antoniu.miclaus@analog.com>, "lars@metafoo.de"
	<lars@metafoo.de>, "Michael.Hennerich@analog.com"
	<Michael.Hennerich@analog.com>, "jic23@kernel.org" <jic23@kernel.org>
Subject: [PATCH v3] iio: filter: admv8818: Force initialization of SDO
Thread-Topic: [PATCH v3] iio: filter: admv8818: Force initialization of SDO
Thread-Index: AQHbdkBdJ314ewdOUEWbXNBnyZ59Rw==
Date: Mon, 3 Feb 2025 13:34:34 +0000
Message-ID:
 <SA1P110MB106904C961B0F3FAFFED74C0BCF5A@SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM>
References:
 <SA1P110MB106911327A8819E9AF67E676BCE2A@SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM>
In-Reply-To:
 <SA1P110MB106911327A8819E9AF67E676BCE2A@SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arka.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic:
	SA1P110MB1069:EE_|SA1P110MB1783:EE_|BN0P110MB1787:EE_
x-ms-office365-filtering-correlation-id: 911308c6-d609-44b6-719b-08dd44577f9b
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|41320700013|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LRcQuRNp+StJCir5KQgFgRaC/nT5QtZHgoBalW5DYBWnQcYb3tF6paRsSNyX?=
 =?us-ascii?Q?ue5rwdYRcwWsIDjP7ZrBs4Yiy2BAsg04h/LSYScSpCexwRDuaIKRd7Cpc61W?=
 =?us-ascii?Q?kmLBdsWvav2LzkD6JEUxnf6Q+LEz18AKnbW/HurN27u2+DIRSPmzAFFEdF9T?=
 =?us-ascii?Q?QdDRv6bJqXXQhYn+cEzbSQ2uUmEd0y2nfNUftHnGgTLhSn52Doi1bm89mjN2?=
 =?us-ascii?Q?7qMj5QLiEI+iwFOl4DQuhZjH1wVL8R8zrcFP6LMOgV24LDyuN17Wa/13RcBt?=
 =?us-ascii?Q?7ddC74VSP/kVIRBIRKqUWNmDRX3PGCB7gLO/muqVAWmQAchXV/aHiOEl5dxU?=
 =?us-ascii?Q?UMWybv5vuJZAOWr8ZKF1IDSCa06cOdqJo42L8J6ZPDfL2YSio/b1krJBpk1f?=
 =?us-ascii?Q?sHAk7dBczjzVKxICUm1/1wh79lF7w/etqVijXJ6nKhfstghOdpasqMKYs68S?=
 =?us-ascii?Q?AnRwBVrXHbhEOYyrniRMUOarx6uqOusIrtvOqCRh6XFF51sLQw1TxXfAAnkE?=
 =?us-ascii?Q?/SlVYQBlQ8ysUP/DP5t8fFqXNGFgIKxYM0dYo5SWJM22wK3eGSLTw79+yy1p?=
 =?us-ascii?Q?X3N0h556lHYh2o0RsDQ8GetopIvarr8mV1Kp1XWpxypsw5MQmZJs9XXksASv?=
 =?us-ascii?Q?xSmXNp0p+iuuIqu2m6ydIzS1UJeYD83IWJTLMKunybA4FyRWv7M2cQejBaJ4?=
 =?us-ascii?Q?tVYols2XrIVe4ASJJtSF+vBp17IpzFpq9rFjp7j/Q5+zSu5amTQ22uXwh/KK?=
 =?us-ascii?Q?EfB1jru+zb1P4LggGieouvKzt1RMj28hffciY2N7AKm99haawEnsh34mEwBW?=
 =?us-ascii?Q?5GIkjP0FlfhlF6Jk1zX5AZ865+/CuxyYY4hLFN9H13mN4VCPaqBrqbDaCW0l?=
 =?us-ascii?Q?Lc7U65hck6Pkhh3Xyd6tjoUTO3K29f55+DmVFRU3UXdAEBTK+YKzn9YEffkM?=
 =?us-ascii?Q?ZJCCem4RxSs2bKYr3eHzb1hJXDghNo52FzhpLcsk68kZ4TcurlUQDXICRs53?=
 =?us-ascii?Q?xjfyVwRr9yJjxrLi54ihv5lioWmGxrE1elDI3HuzHvHLa8T7vmMP/gP5romy?=
 =?us-ascii?Q?6P23AxZ8ut9wKJDFfWmY4WdE9GUmhG8aU4d8soH4aMCHY2cZF6+EJh695p98?=
 =?us-ascii?Q?8k2zPPxG7vO2zwKesSvZxhOPPPs8vVdbYKR1TFvmOPKCmUKwt+/vcT3I+elk?=
 =?us-ascii?Q?DAPsiyzM+6A3jVfQCQTyolRD6MY3V9Kh9c7kWqUxJUSLQUAbu7SlWSVmnmN2?=
 =?us-ascii?Q?gtA6IvDMwnVtd0ddeJFbtevGyNizfdTjg99aVLrpdRrBal6tgoFzGteivRPf?=
 =?us-ascii?Q?zkR08hbtbQDa/GIYqsB043+yAXJUG2gcvM0Va7GEjlMZuOWrRrx3VOH9x5si?=
 =?us-ascii?Q?6DcMK00dk/xvYbAIgXwshEU2UXOmBHru98vWTzN10hJOw4bZzMBNqleG6ust?=
 =?us-ascii?Q?uGF8sLAwoY1PYNiPfFB+Cz8sI6kgwzR2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(41320700013)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KsHhQ1GSJQYvmWS1dzbTOgC9uoUHYFkIcVjusfQiOlYaqb1I5GP0RLk5BHqh?=
 =?us-ascii?Q?5cCZZRYTfIUm/otc2Ib5zIyPXPrClYg4dx0ekadL/W+gP5135V/Z5r/+EOV6?=
 =?us-ascii?Q?Mo7tAwrBo7BsWZYoQmbP/R3oQ4uW2rzziCeU8eEPQmwwKTvb6RG3cQA/FzM3?=
 =?us-ascii?Q?vx1iO6OviOAHkn92/tuxpiiUKWsO9yTUrmMGqipG59h3zGFoSSdZ2+JEC4zg?=
 =?us-ascii?Q?az/JdHvmlpctJvgWMf8VC7GVP5YTolhq1kGj+9O9GjGqj9ptYCokakXgA1ww?=
 =?us-ascii?Q?x2iipiQk8jjJNA1Md3XHfzoTSLf7xeIsytPfXu9kGQM6qCz4CfoXM358eDmk?=
 =?us-ascii?Q?t4/0Q/CzqV4N3XG2nizjMfHsGMBECcWScHSP2EIqIPglGqjnttxS5+jZQwlo?=
 =?us-ascii?Q?d8ShTg++6bzT0PAiH4oofwK2FodsoMp60fYNdJL5t/qIb462HF6gvRYLe2bk?=
 =?us-ascii?Q?kRgil9CGpmslHWk1jpjuzuiAWpd8NUrcPYIV5MR/H8cucSvwTj9V8dQh9/Zd?=
 =?us-ascii?Q?iOtz5VHDm7Ogu3Ktu6md8utVSU4yjGD8uzSCwdaIzs2YstCeENeO8kTzEx4w?=
 =?us-ascii?Q?vTUVAdthZFos8z08liv3LzcLiAXGJPqxLEbA81/ifIBU8pYqJNA+O4bPjWH4?=
 =?us-ascii?Q?2qbrJegKcUcNXoI91GhsVUwkICdzC18E8NcjoGw6Q/h+t83tq8kf0oc8U+PI?=
 =?us-ascii?Q?31+2XHIEd+5jZ5prvD1Eam1gbn1e9UYcch0iSKBG5loCcjGpTZGE5QqZUcPP?=
 =?us-ascii?Q?LbDmuILYMBuGoezO8EhVoZG2fASB1j12VssooesA9o1p3aFTG445praJohKd?=
 =?us-ascii?Q?9N6hSXF3so6vn1l9ycxCBp+JEcRcLxtVwh+bHIF352acN/sG8dN0jG6ZmCF/?=
 =?us-ascii?Q?mObkmlS6rFViWDcFEFYRRxR3DCLUQZFwJGT6PcZN5+6ARSsZ+WVbk7voEsxV?=
 =?us-ascii?Q?LmIlmChh6y8frq9+DewR3D2KTuOj7+BSBu1A8zdIKCHBH8B7Ub6Bm8maRvnF?=
 =?us-ascii?Q?Q51YHEO5Cw3fxTLqLDd7sAGRvkoK4vIxFiwxqGBAkXvo1dyrtEoZ05fE4rZT?=
 =?us-ascii?Q?RVBdiuorUJl9eK5pWTR5Dglmkcync/D/kyV3DebNL0KscN7cjSIH2Z6mBpLJ?=
 =?us-ascii?Q?+LfbN6ZxFWdNrJw7+a5BR0hID5o9wPP88gp4ynnvXoH+1RWGoVYANaQO3+Qr?=
 =?us-ascii?Q?206rS7diA0m8VD2qb4nRElchd8bQ2zCZcB1OREjg4ISCZHnLaIyMQcAszWZ7?=
 =?us-ascii?Q?cqTVHfi1uXW+c41Q+b5irrcnwe1qEXkEzJnxROBJOZ5LQIDI4sg8GWoOJuXd?=
 =?us-ascii?Q?tDMTP4aasxuciGpt+iGXf3Kp6pYMn1oZbyrwA50czqXBpSFIOocBSIAGEp6C?=
 =?us-ascii?Q?fNvNsS/zzuZTkbVj01LasqynpwfeRk9HlOC1ubWEg6nDDtprKt0guvVlNoNw?=
 =?us-ascii?Q?9iQkC8165OQ8Az+YCjPQTKoYeF3ys1pvgo/9B1D2T0V6W+GRiZinMTNtvnfr?=
 =?us-ascii?Q?sgriXDwxZLM254q2rsL/ETswPjzZW/Zw5I6D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 911308c6-d609-44b6-719b-08dd44577f9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 13:34:34.9733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 71928351-9f62-452c-b7f4-40bd09a22e1a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1P110MB1783
X-OriginatorOrg: arka.org

When a weak pull-up is present on the SDO line, regmap_update_bits fails
to write both the SOFTRESET and SDOACTIVE bits because it incorrectly
reads them as already set.

Since the soft reset disables the SDO line, performing a
read-modify-write operation on ADI_SPI_CONFIG_A to enable the SDO line
doesn't make sense. This change directly writes to the register instead
of using regmap_update_bits.

Fixes: f34fe888ad05 ("iio:filter:admv8818: add support for ADMV8818")
Signed-off-by: Sam Winchenbach <swinchenbach@arka.org>
---
 drivers/iio/filter/admv8818.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
index 195e58bc4..9cd1eee84 100644
--- a/drivers/iio/filter/admv8818.c
+++ b/drivers/iio/filter/admv8818.c
@@ -577,21 +577,15 @@ static int admv8818_init(struct admv8818_state *st)
 	struct spi_device *spi =3D st->spi;
 	unsigned int chip_id;
=20
-	ret =3D regmap_update_bits(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
-				 ADMV8818_SOFTRESET_N_MSK |
-				 ADMV8818_SOFTRESET_MSK,
-				 FIELD_PREP(ADMV8818_SOFTRESET_N_MSK, 1) |
-				 FIELD_PREP(ADMV8818_SOFTRESET_MSK, 1));
+	ret =3D regmap_write(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
+			   ADMV8818_SOFTRESET_N_MSK | ADMV8818_SOFTRESET_MSK);
 	if (ret) {
 		dev_err(&spi->dev, "ADMV8818 Soft Reset failed.\n");
 		return ret;
 	}
=20
-	ret =3D regmap_update_bits(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
-				 ADMV8818_SDOACTIVE_N_MSK |
-				 ADMV8818_SDOACTIVE_MSK,
-				 FIELD_PREP(ADMV8818_SDOACTIVE_N_MSK, 1) |
-				 FIELD_PREP(ADMV8818_SDOACTIVE_MSK, 1));
+	ret =3D regmap_write(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
+			   ADMV8818_SDOACTIVE_N_MSK | ADMV8818_SDOACTIVE_MSK);
 	if (ret) {
 		dev_err(&spi->dev, "ADMV8818 SDO Enable failed.\n");
 		return ret;
--=20
2.48.1


