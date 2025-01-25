Return-Path: <linux-iio+bounces-14581-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C16A1C40D
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 16:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7FB1886E32
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 15:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14A3282F0;
	Sat, 25 Jan 2025 15:37:13 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from USG02-BN3-obe.outbound.protection.office365.us (mail-bn3usg02on0054.outbound.protection.office365.us [23.103.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC58617BD6;
	Sat, 25 Jan 2025 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.103.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737819433; cv=fail; b=Ducs/K0ZDPkjRHKAK1kvxPi4NlWU8sRxEacRANqqtM0uyjpwX8uivlubCQ5FKZv3GnwzbidiRqdgEC5GWjAI6cKcDYpYjkEwwlRGtjMNezWkve/Q/agpoFVkbTH6JkgcQU/LrVAfx6wuud/GV3ZEH4YlYiu4eABJ0Vk5Fan85SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737819433; c=relaxed/simple;
	bh=2+5+xA8BwF/ZSIw5QNsS2F1WN9QWVaeHA6vV7ZPOzr8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qgGDZ2f2gdFCxoM2BcXVU1fTUJC0FzH32kBs3llkB+lLPEuv28TefpnOtQvCB6A/FiHr91HPRb0L5SiI7sZd+YsM3KogUERZo2ccX91eje6H/e79v83xF2ClooGzeWtU2J4yfkkWihpZj8Piixx02EkBM8OdGZHA1ulXDvPsYw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arka.org; spf=pass smtp.mailfrom=arka.org; arc=fail smtp.client-ip=23.103.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arka.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arka.org
Received: from SA1P110MB1583.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:191::6)
 by BN0P110MB1579.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:187::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.20; Sat, 25 Jan
 2025 15:04:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=IbHf0sDnMr2iL5bIJeNJ+LB0vDeRAAZvl8jKTkF/heCudSHRjgGkmErDC96oAUhMT1xKTnRV0uzMy8Y9XNreuC02IoCbaltMlNQIhN2uRsTgWDXTJ7lfJ0p9UJj2UowjYTqmreVepm2YnGlEF4ZparWbR8YKnpyZ5AXCkFnrYdOKO16on/OKvY9ECB2Dm42nCtlFunB/NdV6lrmjJmmPpqnj4Rrp9gC1sqhNLWF0f1aYa/IiTir9KFgF9T8yFTuSTHMFA5JovvsLi0z/R8qtDjGYTPNWLTz1VIt3Fs4WKqqHy3yOxNqcI+5WJOLgVY5dUlEcKVvijgVRka9lEUEqUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkJeFzDgc28YwZIBpS+eaoc6wOVHsdCrg+MINRkZyDw=;
 b=zsGt6n5cK9nwXEvBVPAOQNWJ+KaO29otwtIZh2X9deakOLl3S4gcNCLA6yIXkWOieJeI3GuRhUFXEA0y9nwXjNpieez1joqtUFutX9B2mLvo9vGG7gNvzDWvPpT7fDKLbfpYT/fK96KQCun7mA4BD3zT2yBwL/0tTdI++chXyeiotT/8ptlGhUsA7TDit9TZMlz6he2R/WukDU6aJ203be4HlzCguPk2a09MA41dtikhQPPGMJQvZFaAqCU+2vqtVFRgn258yxmtmv7fvnE7YpPY8P5fbR3VkEs5iyjzq4EBIjAfZqFnxcB5ndTmTxPa+nB6YLXXWWbj7P/+P+XnAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arka.org; dmarc=pass action=none header.from=arka.org;
 dkim=pass header.d=arka.org; arc=none
Received: from SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:170::5)
 by SA1P110MB1583.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:191::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Sat, 25 Jan
 2025 14:54:44 +0000
Received: from SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM
 ([fe80::fd7b:b16a:a9df:78e8]) by SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM
 ([fe80::fd7b:b16a:a9df:78e8%5]) with mapi id 15.20.8377.009; Sat, 25 Jan 2025
 14:54:44 +0000
From: Sam Winchenbach <swinchenbach@arka.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"antoniu.miclaus@analog.com" <antoniu.miclaus@analog.com>, "lars@metafoo.de"
	<lars@metafoo.de>, "Michael.Hennerich@analog.com"
	<Michael.Hennerich@analog.com>, "jic23@kernel.org" <jic23@kernel.org>
Subject: [PATCH v2] iio: filter: admv8818: Force initialization of SDO 
Thread-Topic: [PATCH v2] iio: filter: admv8818: Force initialization of SDO 
Thread-Index: AdtvOQEi9bXXscljTwutNm1Yb3fHiA==
Date: Sat, 25 Jan 2025 14:54:44 +0000
Message-ID:
 <SA1P110MB106911327A8819E9AF67E676BCE2A@SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arka.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic:
	SA1P110MB1069:EE_|SA1P110MB1583:EE_|BN0P110MB1579:EE_
x-ms-office365-filtering-correlation-id: f8c5ca90-e1e2-4384-9bd6-08dd3d503451
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|41320700013|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ygVSBLSWp0NECLAtnDvXTIcGep5irRrMvXih5iLkcvJaDPei6OysD5XHtgUS?=
 =?us-ascii?Q?I7oidQXYcicFMrXyxsoXmXR9ZSI941Fx4PTviS08o+Sgd16FAcW9jtrheAvl?=
 =?us-ascii?Q?dD8exr7ygiTF+RWa08Nfp1EqMlpEgvS/LDiMkHCmainKakDi0yMzq6LvSKXJ?=
 =?us-ascii?Q?q0+cCJJ5llrNsuDnCJN40KZD82wCqOz6UtdtqFz+kJ3eyZvS+gp5XIWU3GB2?=
 =?us-ascii?Q?mAhv52DzcqB/Irb2Cn+bsQLehTWDWmnuCx9Ked3z7maL9fawxaCiv/6r86Nu?=
 =?us-ascii?Q?tnwH9osFchsODJztITTs/lL2WfK79+tpaUu1yfiokf84Sz3uLw3yMCMVjJUF?=
 =?us-ascii?Q?+o22DejNbVNJfk3o91lwZo3Z8iwzSNyD+IsJz9eEkh6BF7kO7db3rZVLBewY?=
 =?us-ascii?Q?1+LBCWbT8iESLKdva7mPH7VcQjn8T/IdjqvgAlLm9O5Y7LRJklddf2TCfR24?=
 =?us-ascii?Q?cXeHbxW2geTRC9eTv3TV3zS4xrJmodMvSNT9rAgGmzI8gcnGkWlxS765mK23?=
 =?us-ascii?Q?nNp8M0MWnmByBJuh5uluuoyJyAVDmHbi4ATxP/iZ8cdwHc78+QB7nfuYOJ9W?=
 =?us-ascii?Q?LMKa+k9FcUXBkakcM0cIdo2/BNHrCESSMCbZ5/cVOikg+7ZuBTRGboiQ+xBq?=
 =?us-ascii?Q?RdHohP8lDpt5SUakW6G2CowbFnQhya2WMz4th2pIrxI4joxLx0g1xiYUh6/g?=
 =?us-ascii?Q?D9t/8mEOD6dHhvY5K5JI8SjsiGDopVasUVDfijWYIdF2cJcw1VTl9pp2pny/?=
 =?us-ascii?Q?ISU1GMzf2Jmqo6j3iIVQ8ETmxHz5rw/lK3d4ajoppgHAfPY6K7+no7nv5INo?=
 =?us-ascii?Q?2NlP3E6krPwyXFTX6J2gZDt0pc0EqzWhHeWhMV3TPpdOXA3iv2DO0PqT311m?=
 =?us-ascii?Q?7OqeDwEP/uuR/dixowMeEv46h57OH4bLwvmqPyQP8/OoBc0Ql+ersfy8SJME?=
 =?us-ascii?Q?MfnBvtD4wc6DVUB06A+u7FUoRDmeYubRyCUjMa5HM+331SJaBHVHZZrS2DtC?=
 =?us-ascii?Q?YY0hW2FSPng2fsAWOFeb8MOsnX5HJQ+EsDXyyXMRIlxZAE/QRYhe3kKguRzf?=
 =?us-ascii?Q?r1RGVZXL/usvya8Uf3CKKFum25ODlKj/VfJgsMgPPGVl6/Ldpt+DN+P4h6LY?=
 =?us-ascii?Q?V7tqtXeJfPQM2fCK/sjRlbw8BVen0q7Mhf79svEHt0/6HTplueRN+qlpOPCB?=
 =?us-ascii?Q?QdbRmta4pyhttDiLc2kXfsN1zN/KtO2NNPd/l1bkBTiOg15PlL677uQGoNQr?=
 =?us-ascii?Q?LaN/t4JgooeLgJHuEGryBFPpm5f4evQbT6qfDd01JEFJZeHptRuE0pGTZP2U?=
 =?us-ascii?Q?zp3DEDC8BKVmxVtMCZERNsPvjQLd75BXaOhY6S8egw9pGnkD88pt3QlS6cw6?=
 =?us-ascii?Q?YkDDmdgiuHcgay9EylCmjQitbEMnX1lX/hTjpWmUatWMgJHWcCI7cEO0YOcy?=
 =?us-ascii?Q?XO8g4MEmVl/p2EXODT1rYUn2Dzz9mPSj?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(41320700013)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lyKDfZpO5uqw8ghPKR8UPVy1te3aVjVCA1t2Ir0iJOm3WzIgermOZOBrVXgO?=
 =?us-ascii?Q?AyVSN7+J01/WW+BpzvlIJZ58JLFAOiY9JopFGZPTSHrdgsdWY8oA3NDaMwNt?=
 =?us-ascii?Q?Shq8xs0c4bTcoLmS6A7QYE5mPfGfWKuEx4Qpwe6KjKQuyCmncjhMOK05Cphd?=
 =?us-ascii?Q?CIXSNoVw07Tx8poe4M5a3Z5Q8hm9115RzPhx3oB3EqzvZ0JwEh+rpRqmarPC?=
 =?us-ascii?Q?2E2I8tVCXJtjtfCkH3vq4AP3pfHz62r78knFdD0z7kXiuL5gmUK62Tig50Zk?=
 =?us-ascii?Q?ltoBJSBcZnq9CrmV1gTw2ejWLA7vjZwNxC7KIxvRAlgtL5j/ZjYePxyhPF4X?=
 =?us-ascii?Q?B83Ny6KWNjv10BKiWGgp1jjc3VSTFolUiPXCwRLITyQSSkpjl5BsNH5w4R8Z?=
 =?us-ascii?Q?s01eW4g99mW9VmsHL8+8KfwnzKKehsYgjJwyo4AbX0vOOaHkXDYFLy2oHIWB?=
 =?us-ascii?Q?JR23sNPRbuSkzWJg6YTGp4poXEj/rfwmg9W5BtGOaFwOEgw+4nwmZVuh62VO?=
 =?us-ascii?Q?+7qJEWYe1anbKdRuVIYPlbUQVowwPePnRWjzVCE7l+o9b4wD1cdixw/G39+v?=
 =?us-ascii?Q?nReDr31j/Tf/Y+skN33zn5VVYyW/hEoItGXVmZftEC1eHMonHJU4rcuL/6v2?=
 =?us-ascii?Q?PjbSpo1ZcOPJWV6BwihGcA1L6AVPoGu1S2AaoShh7r4PhJKHfcJA5amqAlt7?=
 =?us-ascii?Q?i8vMk1Ea9hyWa4H9DbcMjU+vFolovdgiIPPzzJJyrJd6ZjkKnBaUFUsPh0sZ?=
 =?us-ascii?Q?oV+vOnXYTjrOfA3APLIR/LEo4w1iGdBK2s3F6swi/f5hItUc0Gvwd0jZPQ8Z?=
 =?us-ascii?Q?O+BCfAiKF4mLV7djSR6ZnGjdlDWy6UfAv3Yo9wcwkJ6pfNvD4zoCclI4BywG?=
 =?us-ascii?Q?pbLT4g6xCub8a/8Vz4XC/0Uizhla2uaqd9yxxWaRlmskqKS4cI9XEgSPeV0v?=
 =?us-ascii?Q?wsRtKTCdeYT8BEYMYgtZd++53AD4h5gTX1UfLvH/L/ocvwVVRre0Ldz5n9zo?=
 =?us-ascii?Q?SNtIMsOX8+8mlX6b8F9jGYF81g1Uc0Vjdjwk+9Eh66HsnxmWbo+kj/XBKENd?=
 =?us-ascii?Q?QYnHBWTthhn1GmgUHSlP/IC0aw3KnLe34MICjymr1hNV81N6vM+f5VG9ZykM?=
 =?us-ascii?Q?Wu8TbKUAk83sg5X5PVsOTah6DXoJ+0ufdSpUt9WK3NW/i5B1PvbNUEop/xdV?=
 =?us-ascii?Q?lbcf+lquJT7f2GmOvaJ1LVbtpoulpJ1HAAgZ5B9LPvffxeBHBheX+bwupPb2?=
 =?us-ascii?Q?r5tzBpwPw0TYxnxdRLP58J6YExlct2Cg7em4fwFx92VwNE+aHo+IEH/FUcB+?=
 =?us-ascii?Q?qM/fCqO+x4s0F/pa7qR4snTSQ7ZA8bo1uoK4GNAXa0aqbsDnI1aayD1scsbD?=
 =?us-ascii?Q?HeCyt6Lemsy0CrlVkn/S8fyCdClMWsK154q/KA46yopDgS9sBaWK6Na2Kd2y?=
 =?us-ascii?Q?yP/BN5lELQbYdHUOLHY3DkYExQz3fYwJQnzTfVGyEtn+woXOTqlSQtbV9GRL?=
 =?us-ascii?Q?VLY4omtUNnvWYyFxqRUyF6evb/pyR/pRBKqI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c5ca90-e1e2-4384-9bd6-08dd3d503451
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2025 14:54:44.0369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 71928351-9f62-452c-b7f4-40bd09a22e1a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1P110MB1583
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


