Return-Path: <linux-iio+bounces-14557-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 693AFA1BC8D
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jan 2025 20:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4EF118883AE
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jan 2025 19:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440DA157485;
	Fri, 24 Jan 2025 19:01:19 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from USG02-CY1-obe.outbound.protection.office365.us (mail-cy1usg02on0084.outbound.protection.office365.us [23.103.209.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E4527726;
	Fri, 24 Jan 2025 19:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.103.209.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737745279; cv=fail; b=LUjZY9eEK2Uvjs9fSzkJuISINzVj/w3IvMEVCB0gwbyFe11bplspp9Z/hCNAWGNCX9/RuWaYcFxM79b2iwCepybnXK239GsS9fwWE0JUVRRoSpFT81ja+AHhtjrf8BoyQcFepcZn//Ptr2dhiMSE0kxqocRINVWVmUWURpXZmh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737745279; c=relaxed/simple;
	bh=uEC7PPNO6Tqk+rmYYFAZxN62Pi8aMJ2xGPhm1Dr/T0k=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HdvXcdC4wPqLt9R06BtkJuDK/i84PEAcQTlGeyGKjM4JJlfeLBDqfC20clH6UjTt0nnlOJ+k/F9D3KvumIXEj/uTvijN6VKR5kQhYG7RM63J2MlkwjixCxGRcpiXYouByph+Z89AMGILFBqLH+JFvb5xveNTB5EaTrV3CZd8YKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arka.org; spf=pass smtp.mailfrom=arka.org; arc=fail smtp.client-ip=23.103.209.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arka.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arka.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=0oMS34dNZqhWdSIbbBqF1k/sXpnPW7bb2/AElypPvKKaTRnBaoBQu6xo+AOlyDo5UawwBsoMQbQMMFSi9KnO4PUPybXcE2eLW6ErHYtTCSLaDJdvP8nxdtfbqvSV6OIJOXfMzzJPVqwbEPO9JSOtJSYGAAY+ihdLSwtU1rGzjjZIrr/8Fy6De94nOCH6H5BjrRMaLG8q6yl/2+68BGcJwUW2GHuGoNLkT703f8LhsHmgta2WXx5cjed9IKqYMMyBy10chC7X/3eEj3F+D/7biD6+5IhmSP6Wml5ZUWHZ5JpQI1xSIl/exB6ruSK+WldDoVjW8u/Zv8bV1q3szJL7yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tq/FGt++jGpiZQZ1golVIZ3u14CWVJWsXpS6d+XPZDw=;
 b=m7IRdS8SCXq9g+Q4FcZ+jsBjoA6xQdk0/LoAIUskMQTM/xAUJZSBpneT6oPsDGl/3t0gr2xbQB0p8z6TQLsvm+pO8PTP451REbOJ4CXsv/B/WssIYq2vgY8vJF2svJFnDn/rBd2XsGKUW1cKw45Mqcf0yFjrh3DEAgBep8CGDXtC3c8MfnLXJX1spyLWYbTksFDJbOChldngx71TVxhRcFvw7+jLv//TkrmP79QqHKtAi2K+5l1r8voo+JW058seRMf/pAgXV/atY4JiPwGkvVHUIH1ymhnGMQvyfFqjjy35lzIQRfcJOB0nSyR295BBD6WVusECiiO11m2p2XWDFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arka.org; dmarc=pass action=none header.from=arka.org;
 dkim=pass header.d=arka.org; arc=none
Received: from SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:170::5)
 by SA1P110MB1213.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:192::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Fri, 24 Jan
 2025 18:27:46 +0000
Received: from SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM
 ([fe80::fd7b:b16a:a9df:78e8]) by SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM
 ([fe80::fd7b:b16a:a9df:78e8%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 18:27:46 +0000
From: Sam Winchenbach <swinchenbach@arka.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"antoniu.miclaus@analog.com" <antoniu.miclaus@analog.com>, "lars@metafoo.de"
	<lars@metafoo.de>, "Michael.Hennerich@analog.com"
	<Michael.Hennerich@analog.com>, "jic23@kernel.org" <jic23@kernel.org>
Subject: [PATCH] iio: filter: admv8818: Force initialization of SDO
Thread-Topic: [PATCH] iio: filter: admv8818: Force initialization of SDO
Thread-Index: AdtujaIg5KDF3LXLTmKHzI1/shuiAA==
Date: Fri, 24 Jan 2025 18:27:46 +0000
Message-ID:
 <SA1P110MB1069C61BF6709D362CA86CA0BCE3A@SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arka.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1P110MB1069:EE_|SA1P110MB1213:EE_
x-ms-office365-filtering-correlation-id: 748b0cb2-4d50-44a2-f8af-08dd3ca4ccee
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|41320700013|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Qwa/du3MnJ+Ehey1lJw0WNsi1q0HJ8RTkvvksmTETdg4+d6tagYyjQyj7KiC?=
 =?us-ascii?Q?jh3v4s5qfcosVcrxq5N0PrsVMDgU72ZYhpCjns36+s6epchpCv6TeI/1adil?=
 =?us-ascii?Q?xrAqyHgCVzWhinNzoDX/bvnVJ+JI1I0BIY1tRw/q4ZB2PdwA6nGCBHrQZJ/i?=
 =?us-ascii?Q?cuDqVg+KCFr+2T2A3wap2g6wuolk2j8Myn4KyQVmjQA31H77GOUEMhtHLoCW?=
 =?us-ascii?Q?VyLoN6DdIuAM5dpfFTXmysisMRt65a0+TMh/WnSDib+1rvfcf4KmvOqKi+hD?=
 =?us-ascii?Q?0ErYdPzbfnx/vqcnfizBipotei8ePQlR1PlETq52Z+/TWWDXg1f2IahhQdX5?=
 =?us-ascii?Q?sRZL+J8o+qfAlXsiaTaHw7NwHYO6ZvCjhWuAlF7L/2SBKZHm82ogDXzGSSlx?=
 =?us-ascii?Q?jZuhADDkWk4wUsP5XL6QamcFbPXJrSeNTYg1FAfGmMV5SkxbrodXXzvKdhBc?=
 =?us-ascii?Q?0Ged6ZTszMSGKfYLZ4AYbR5F70SCO3gzVMMnhw6ZKilnwcx2x4FMuT0ADAZm?=
 =?us-ascii?Q?e8eKOBlKJ482guAMgKajKS7bPuNAAYem9WJoIBv8+V+v21EL542Ea7WZzvbs?=
 =?us-ascii?Q?d4hvZrVSvNap9NLnfcLhMCNk5YkHkAJadLqOFZh6FgqI08cxUgVSsUh7XZLb?=
 =?us-ascii?Q?QyY43Vqw5Tjxhp4b/Pr+3fiGRW25kmvihxy8LuTwrkbGg/1/C64W02+WtNvt?=
 =?us-ascii?Q?Zkw7J9VoUYnUP7a9B3SVBxXrq1W7TViyuBWWv/Ff5bdKsDojxIpAbkpcJ6s/?=
 =?us-ascii?Q?8JJC+pPsdWnIely/hksEV67ICsrXAIOt0iZCMBZQI3xlcPZmMuC5MfgW/Ost?=
 =?us-ascii?Q?je3CZtGTn81IV8RdvUzUSi+6hntU4fX9TLBlrhvU1OsOIG5rhVD0Apyl9zOi?=
 =?us-ascii?Q?2Il2a9LS3lC5YY9uDJ/unAejNyjuVD0bYgrAwzK3P3RRFAQODQuMVeCYOUel?=
 =?us-ascii?Q?M+WGkEYASiSINXsia4K549BQNy9NE3c9BJu9fmGp9nopRb6O+R7SitrCMkH0?=
 =?us-ascii?Q?FBE5ObPPJ4Q7FNxt6yhmdVoHJztSmFGmDtxipZs77uMUBp/dODpNunrK6I7y?=
 =?us-ascii?Q?oRV9ot3lh2DYN20dsKQVR+hEu5Ywr2TXxTqov+MtGu6Bg0QlqSWc35RedtTI?=
 =?us-ascii?Q?+wbGd4Ouh2OP6afuxA7Zu2kJ2xLPItoWZ7/CEzzfc3dc8wNcfzKtbVwgrsKm?=
 =?us-ascii?Q?o2jLGztgvvkOXY3cXnYfPElMdA4lJpfNAR0LBStIe4oLNWaB7AHVVeBhH2mT?=
 =?us-ascii?Q?vVqVMt92krHRRuq3cyqiyUsHipzwnsCTREEZ+GB1YFZ3CgZ7Hr6qFNrozGD1?=
 =?us-ascii?Q?Ehy9v/ZnRJNRR6wSMjcNwSxsgRHs+to4mV0oQl7wRgElRthAjcqJyH92rFBX?=
 =?us-ascii?Q?feL2PzUamjsqxeqvqsCDp8FLYAgtWqDAbLf7xWXOHGuRoOymgq5/Lo5xT4Qg?=
 =?us-ascii?Q?hHA9QxmYKm1yPVZaj07IkYdhtJmNLUV/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?d4S4beAJkJVAjovCodSEhb6uPoCHFuXFWFn1QArh8r1Y9zTba3xUNspXftiw?=
 =?us-ascii?Q?JMtLkSyTypEMOE9ZS7HMgUrY/1NNvSL9XkKhwQ/Ar0Xj7jNiJH6+A5jfrt+o?=
 =?us-ascii?Q?vKduTKRwXVDE86wjUWusUzankTI6dKzesDMn95YNSjxfPh2PuomTgELQCD97?=
 =?us-ascii?Q?h7OoX/l1GxKZ6Z/cS8dhM4MT6cE7tWyHiDbyvhDtkwZFSaHh/qdOHcn9tOgR?=
 =?us-ascii?Q?ulNuwwonzKodcqfjhU5vi8yOcQOomYR7ODsB4KtCQl8n/KEvmeJfKl0grA1V?=
 =?us-ascii?Q?SbIuzQpUSntka7L0OS2l1iA+CSzzAp/sFVe5xENctlZng9cx4ICj4+IemHVC?=
 =?us-ascii?Q?tC/f8J0Fw4/HueVfTZOF6JhZS3nbYiJ07GUZu1SAzv0o2CaAxMWlPVHFkw6J?=
 =?us-ascii?Q?J1sCsU5uuXAa605Wq0c5fszR7bIUB46ey47PK2hghkXjd3gTMySwl7HmeLwU?=
 =?us-ascii?Q?k1l+t/Q+Y9Uwf9kHCGSzVBB3VFfHCKiy2EYBfLnvyQnq4+BW1EdQ2j2tHEO0?=
 =?us-ascii?Q?wl/fHnpyokc3JFblnASnNqk2M60WZaT7OAgNRpKWvAZGNw/mqyJNW0RrTvRL?=
 =?us-ascii?Q?6m48oVGt2qD7t96VL9+uaNPFnQ/BBGy8MtWymKU7dcZ6/7X2NcXHQtrXAKok?=
 =?us-ascii?Q?oF6TVvBDbsIIP62OqK51tZXNO74zvph5LQ6cJR2gXaj1KC6vFQ/QZk7GzRvS?=
 =?us-ascii?Q?QxnyMhoR6KdR2yIQlOHCDYI8e+HjzxXbd5YKT8ba/eEsZK60cbqP/tPeGfPz?=
 =?us-ascii?Q?mUb4pmwCThvKZHUOXGgeVz0bv1aQBxYUga+7u6uzbxjTXNEfPJpf6aai5nYX?=
 =?us-ascii?Q?unFfivAEdtK0ZVcmDnZv+2VMxK+6Ybu6jHqsY6vtE08AmqW9euJG61A+DhWA?=
 =?us-ascii?Q?sVCtxxJRLzJzvxOKEOR9xPhjEei+UmPdSaIPH2S8YoGVkxMZ1yV4z6v3oQeV?=
 =?us-ascii?Q?nCUgymv7jxuYsMkW+LXFHQUmrw+npa8ff7y4wbV8s8we0gzZHztFqAeuE0YO?=
 =?us-ascii?Q?KLxvdqNHwu0o2VnmtxhPFypNcXLcqoAFw6Qrj+8sYtUoLS1h32zp264h6k+0?=
 =?us-ascii?Q?IvyO0GfKSnMlISlomqE6J8/d6gP0cxK1x04K1CpO/8i6dfEeOKYmKkuEVKWI?=
 =?us-ascii?Q?W+p+qcd69APZtvQ5KsgyWPiWWanF7xroj7Vi+cFIPOzTTD8aS7m6ulOJR8aC?=
 =?us-ascii?Q?wuj9b91cAEhmyYR8aey1X7OVcWSAuZH+9TdHkygFKnpbrtnGeXtb72An4KP1?=
 =?us-ascii?Q?vRsgJV2Y0iNyYUMHSoyYTzXCCGNY6y1ePR45zXttcKMbBvKPZjEo8KLOPjIB?=
 =?us-ascii?Q?tTsXx3Oa2uiyvb7mb0SuOJ5GX3oT2zODxl3HHEETJ8xZEYW0O9Y5xVV8Cj+h?=
 =?us-ascii?Q?Nnkgn228MUuoq5pJimE0d9ocsJ4YyNCAd6kfPVer2IisYG1R7IWiKi6GXaTZ?=
 =?us-ascii?Q?/hC5V1rPq2X82x87KCu7CMEin0AzoiGRdpAkLAFLM/Y0J3WQQDEed9huqjCI?=
 =?us-ascii?Q?Wkm8pMQDduBEMcbSmnktX8LXcW5DZB4Anx5/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: arka.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 748b0cb2-4d50-44a2-f8af-08dd3ca4ccee
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2025 18:27:46.6830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 71928351-9f62-452c-b7f4-40bd09a22e1a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1P110MB1213

From f851ce8225fc239fcbfc2e06adaa93336a9242ae Mon Sep 17 00:00:00 2001
From: Sam Winchenbach <swinchenbach@arka.org>
Date: Thu, 23 Jan 2025 15:24:09 -0500
Subject: [PATCH] iio: filter: admv8818: Force initialization of SDO

When a weak pull-up is present on the SDO line, regmap_update_bits fails
to write both the SOFTRESET and SDOACTIVE bits because it incorrectly
reads them as already set.

Since the soft reset disables the SDO line, performing a
read-modify-write operation on ADI_SPI_CONFIG_A to enable the SDO line
doesn't make sense. This change directly writes to the register instead
of using regmap_update_bits.

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


