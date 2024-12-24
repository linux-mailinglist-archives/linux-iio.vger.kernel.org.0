Return-Path: <linux-iio+bounces-13768-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 198619FB9B8
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 07:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7331C1884F9E
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 06:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000AD1553A7;
	Tue, 24 Dec 2024 06:14:37 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11021142.outbound.protection.outlook.com [40.107.51.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119A814EC46;
	Tue, 24 Dec 2024 06:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.51.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735020877; cv=fail; b=LApEgaYCRIn+jM3PmkXdnsBkq6R+jU/4ZzwIyOPCcNBwr0QXtPW0p1k/GvtLZPU/wD1TLReI5zV/RPNbffIXfFYZaUVjH+eZVD0DnbvgUQfYgdoGfivwjEjvwKJ+f4+79Hn85TdNBujmsksbyksTFRpnuvtrer9aV18a45L2CBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735020877; c=relaxed/simple;
	bh=m6pdy0sFW7k+5pcG1eWdRFRrt8DTD6CTH4k9BoUJIAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PeRhCJWCufWL+Rb/rJEqkcIs+a7jJpNocArrNKFuzu3fS/L8DrAEZIqLQYaZrBMCrwx5cLqoKWzQLvAWIhePKwLjBpz6Db+J0top5aX/IS4jUl0FDOcdDDHvbKQDsxuIy3G4BBq7edy+5B3mFiHIl0xRjHAYlmd8DjzZTlx3HxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.51.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdXE8ladetC6OH6YzMi9Jn6ixiH/jinBIC4sE/8JUYx4vOM12PwwUMNsOwt4H8jpaHq7WhTsI+j6RB1MSMjOnpbRdjfHVvRSOrI26pCfi9sjxqx215WhLu37+mKAm4pAqN5YWKa3OFt8YAme9FScFjnSAts3byvr3xxOdVZ2k3+pwOtult6Sz4rJoHFBqH8QizaEXPMZ4LBcNjv/IImTaGrqb2yfmrBnZm/g/TdsRjxyO8Jqf3rJCSGw2yNORA5cX3ml0j9v3VjPJL23ATS5fVBqB2DQWKVrfYcLudpaxTvK/SjHW4YizgW/Sl2mTYdBnX4T/dRGAF6VCrqPAmdfRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=teCbmW17gteq/hTogXQpoKpMYO3rjaCPo/wJkgj+Ri8=;
 b=Fq2araakXRmizU+2R5bP1F9tlbrk6Ekj+WYPSuSgVQFt/QkduUe8N+JbU8E7EfJ8bGYgmDqlRv1JVc36UDk/rUKPQ4d2H2q2jMIQzNzmIo2yl13YRUcsCrKxm3xbXzc1/mGcZSFf707ZoPaHNf7nFO6Ps3hcC/69TNNNyMC+M0Rw48H5BasdzDnQ35LHSCMCGHVMwMl2cwD5A3xC+8pwdw9SXJNY0rCOmO8+qAiXFmDRAPqbIcUwrCgfgYaPQBqox0M5x2uf2Frnokkf2NG/wOvKsMjf149j/t3oGvYA/P/vHVZx4Bs3whvvtvodf3v67xRjnE/XbspAiVOjOQcn6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:204::8)
 by MA0P287MB0331.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Tue, 24 Dec
 2024 06:14:32 +0000
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac]) by PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac%4]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 06:14:31 +0000
From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To: jic23@kernel.org
Cc: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Gedenryd <emil.gedenryd@axis.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Arthur Becker <arthur.becker@sentec.com>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Julien Stephan <jstephan@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Andreas Dannenberg <dannenberg@ti.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: light: opt3001: Add Support for opt3004 light sensor
Date: Tue, 24 Dec 2024 11:43:16 +0530
Message-Id: <20241224061321.6048-3-hardevsinh.palaniya@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241224061321.6048-1-hardevsinh.palaniya@siliconsignals.io>
References: <20241224061321.6048-1-hardevsinh.palaniya@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::9) To PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:204::8)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0P287MB2843:EE_|MA0P287MB0331:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e1c5b9c-c4dc-402f-a340-08dd23e23b16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hw48JdGbW8TzDQbjWJgoXiqHTsIAp3zgky05vU3da55j/zLYMfnaQKtLo32x?=
 =?us-ascii?Q?o4xBq+H8iSXeZG7m8igvbWOkniNri+nirt/V5xomCuRO9oATqR5G/Y8GX98T?=
 =?us-ascii?Q?Tc5HNi3r5RShad+Lx6TQCE70dSDa7WskKYjpRa0Fs1m72DMRu9mB9RjxRcw8?=
 =?us-ascii?Q?WTqZfHW6kOZ+IZw1OUblHvFPBBnAk8p+nzbIXgytx2rDIXge7wBig5cHu2X9?=
 =?us-ascii?Q?YDdeaxltjf9bEOK/9Re71Q3vezfTVERx4hA5l37FQLOKeyQfEl7n7DtwrpT1?=
 =?us-ascii?Q?RZcKzTavvSSVSzpfGUas0bRNeQOSxVcv+KV02r93OX16Zyul/LGr//2xVRoT?=
 =?us-ascii?Q?Dqz0HjNTRJCmK9QIZKa7YMsJCyfWcBpESJHL9J+nDKjsJ+lYuk5YwORh7+WX?=
 =?us-ascii?Q?GbuOkQLpCv6jaqYZ0sfEtVlZwVlPOVzQi3CchyG1D93Cu8ddb7cFgZN+Gx4s?=
 =?us-ascii?Q?QX0tK1XR8lO/nhxcZzqa/ClY4ubjQx701LPed+UCxg7C8MshIsND2uU4ARYp?=
 =?us-ascii?Q?Bn1ovlUHlB0ZrpXnMwCyVDMPIl9RpyJpL6YCPr7mE6AnJS0s3CHuFFMju2pm?=
 =?us-ascii?Q?Wp5IdlArXgcvbMh9ib1Eh3qZc5SjAbHOEqSnreU6wXHosRN8gJTSggr0KMsY?=
 =?us-ascii?Q?is5aaUYY19aEFifbXd+a9dhGoN0vqNOz83oHqXyKmCCoXbR0xt/4guBCDls/?=
 =?us-ascii?Q?nxC68N4wpO5sjCnn+H3WeKD1YmK6DtOzRH5Tu/lHeXa3gpjlSYzA7H3SscZV?=
 =?us-ascii?Q?7fejjEcBnH63fLYPX8yzlFPfjlKq/fwFj6fkq11gCkSDZPzHUtdkVIU57CCd?=
 =?us-ascii?Q?log0jcDZ8WKmpqdnMB7shQuvH8dlof87bZqDSGGIYxb+EUTr+AFUdMrV7PBT?=
 =?us-ascii?Q?vUC1fY1X3nX1zdWS4Kh05bDtMX9PcDBCq4YPsknyl7TfERY2uZhG8xO60Uj2?=
 =?us-ascii?Q?SPD9+Lj8avXAiatxRMySkUQa3RGOBpCDItHEu1nOtyrzDjfo5UhWClFCaZww?=
 =?us-ascii?Q?iCrDoAsQrmbDuMAKTJz6LB5ygalwM0KgdPMgRboLVgQNag03PiH6NqgY8Ysh?=
 =?us-ascii?Q?TYEjCJyutk0g4IHa4lVYvTINveuDBl0wU1gt3SLe39Nsk/3fotUdFLmHT9U7?=
 =?us-ascii?Q?8g8mrQQAOCY5n5zeN6dkNdcxZGwPNHL1WrYffpinXA2Z6pmUFC/wG9GVKgFN?=
 =?us-ascii?Q?A4EeipKViYDPn5gOFSwQAqIjvplmn5QDEY9RH51zGQW4PV/d1c95gLYn8I7Z?=
 =?us-ascii?Q?zl6Gu3GybaUOgDx0ibUo+JQET499Pw6TPXPpO/GKnRhZQ6cactmaU8vLsLFE?=
 =?us-ascii?Q?Y48q34oqxcO6aw0+8uM7dlF2TG/BxV4ynS9gBab4JobvHf/cXLE9WG1/5y9E?=
 =?us-ascii?Q?zWHeE4oq27wvJ6IJsD5P1gs6/HFtELDbtopzUVljeTq3ZH37iuWAdG2IaHdl?=
 =?us-ascii?Q?enWtIqGOt+NYn0Fryj908pv2Q9PLyZQT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB2843.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1OK6a6RIlsJDG2PqAN4nWWxB9y4LSXJ6249ieYyxKlGCtP5i8km9sn+lX3gK?=
 =?us-ascii?Q?sEWjJuS8/VROjzMK6FAZTIkSno/C//fESD4KWuaIgmQQaHdaqTTIO2hTyUW6?=
 =?us-ascii?Q?LNTio1jO4lBCB3HPruugxxA0TqSB4ETa9RPi57w6HigVZVEzrt68epntUvzM?=
 =?us-ascii?Q?/xZBQ1Et53K6HGYes+OO63IYnbYYkzwKSEx3XdojSme16wewQEf/4LRocpQl?=
 =?us-ascii?Q?9+e1ZEvtLjeyfI8dki/jfppdG8rWhOmelSUwMUEuLCDBLjpy4mBCkrk1Qa/x?=
 =?us-ascii?Q?LJG9rYdvoejQjZ6YKDLM3bpnGTcMqnBpsWdTRQbIOskX3Abq62Lg3WXPlJ72?=
 =?us-ascii?Q?rM1sEDfJNquTdorkdCpRHrOegu32rE5z72SXvdkopchfMuc5JLvQq1AB/IYV?=
 =?us-ascii?Q?VjSVeVpydzSg7Adq9Mlrb45HwZWr/IJh6apJKzcj9g5Ej62mfQBKWiwAb81v?=
 =?us-ascii?Q?eGqS+G0ze6aBtqiyRScuELdixYQvOE884nwwjCIh2cEowOccgZcMgQN3fqIU?=
 =?us-ascii?Q?hMv404cDqQDylF5xyvIT8Q9gtJ/SSN+EBDAE817MKXGVnq4Z28nC7qrXg8XR?=
 =?us-ascii?Q?NTb8/idJPhMIDFJj4JILWGhHPGCgVLuGB+CB9L1jkwZ5K5bwZU2+F8fdToBt?=
 =?us-ascii?Q?Z7NmR0ZdP/nhEblM77bqVVdG0Y6sChOXArXQQN7VxOZkD2hGJ/ihor2zN8i4?=
 =?us-ascii?Q?tegSGs+IfhWYErMDsRXgXoqAgQyvviIH6n3zauutH8YDxCkxjuTnJbpF7oPX?=
 =?us-ascii?Q?0BHoxdan2VKb6A/EZQp8Qo4F1EAhLHliZYoyPAUn3VDgq0hiAvqI58u2ueTc?=
 =?us-ascii?Q?O9ZGt5MYm8FGnEZt5rGBSrhGsRZDbfTgnkPOY3KMYSYJYlPJehmruB8fMRNS?=
 =?us-ascii?Q?VO+4dblryJ+0E4Tv2FixR2B5aimL3fzb0KyS9Ge2xj8/kAiLQKfVcc2phNBR?=
 =?us-ascii?Q?JsTw19uow7J6pkbyDD0rTe2ymVWEyRwYjLalR4L7DuLyvUGV2yXRcgKWHxt3?=
 =?us-ascii?Q?LSQfF8LRyoDbMmBXotFrhObXBXWSIFFHJeTPRD/8Fe/rbY+tAnMhpo1n045K?=
 =?us-ascii?Q?nrfbzT4OK4Biz5Ev/dz76Xlo1hsFBYOXgwdIIz9mBXdeuWTOiuNhJs3jpWEh?=
 =?us-ascii?Q?xfiZvLjmVxSjFYjmJCNJe2sDl/gU8ojR9HRMe1E8SIEwHCeYXW0ney8we0k7?=
 =?us-ascii?Q?embjvF6v6daAw0mZPTIor/KJCa/zTecwcvXvHnZp36V979qZxrJ2k5grCJ12?=
 =?us-ascii?Q?LwXTXmJI4XD2UHVolEHsclGfF6WCMgdKyqx/UkXA1NW9krJjbpeDSZcmqKzX?=
 =?us-ascii?Q?TpvAiOu0nQ4qLyEBi7EWyzRUt3P9JeDY9DKTYKWluJUPPA8g0CrEthYV072L?=
 =?us-ascii?Q?QmqZAOvjgTPoyuza8KXYOR09UB5bH8/tc8k7etyiKVHHUSiKLbozuwnvjJOM?=
 =?us-ascii?Q?Cfq9k07eI6NmEWfvas9xoOAj4L9vQlIPO03YtkTnR67aGlzLdzDvTL24J4TU?=
 =?us-ascii?Q?xQgLcTwyHG+1KioJlvwtRms4sQOs2PJR7kNkeBFlhgrd/8ONAFcbhEF5sF99?=
 =?us-ascii?Q?8Lxo9yChP8WZ2T4WiSIiFkHUgIsdRjIf4pwv9r96tlKuqr46VzjkHLO/4EHk?=
 =?us-ascii?Q?kXVI0fDSzlPospwByt8bnn0=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1c5b9c-c4dc-402f-a340-08dd23e23b16
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 06:14:31.8768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xP0/Zcn7au2leUOuk1bZ3HRt/UINSPXegYmIyz4vluKopJeIcw18hECiHwt66kLG17PTjNNyN/TpIG1ceQQ56xFRWs47r78frqgNTgZVi4c4U26bX/2EiTpbKMAU+pna
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0331

Add Support for OPT3004 Digital ambient light sensor (ALS) with
increased angular IR rejection

The OPT3004 sensor shares the same functionality and scale range as
the OPT3001. This Adds the compatible string for OPT3004, enabling
the driver to support it without any functional changes.

Datasheet: https://www.ti.com/lit/gpn/opt3004

Tested-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
---
 drivers/iio/light/Kconfig   | 3 ++-
 drivers/iio/light/opt3001.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 29ffa8491927..748c8c2cd3e7 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -475,7 +475,8 @@ config OPT3001
 	depends on I2C
 	help
 	  If you say Y or M here, you get support for Texas Instruments
-	  OPT3001 Ambient Light Sensor, OPT3002 Light-to-Digital Sensor.
+	  OPT3001 Ambient Light Sensor, OPT3002 Light-to-Digital Sensor,
+	  OPT3004 Digital ambient light sensor.
 
 	  If built as a dynamically linked module, it will be called
 	  opt3001.
diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 65b295877b41..542af8612d34 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -949,6 +949,7 @@ static const struct opt3001_chip_info opt3002_chip_information = {
 static const struct i2c_device_id opt3001_id[] = {
 	{ "opt3001", (kernel_ulong_t)&opt3001_chip_information },
 	{ "opt3002", (kernel_ulong_t)&opt3002_chip_information },
+	{ "opt3004", (kernel_ulong_t)&opt3001_chip_information },
 	{ } /* Terminating Entry */
 };
 MODULE_DEVICE_TABLE(i2c, opt3001_id);
@@ -956,6 +957,7 @@ MODULE_DEVICE_TABLE(i2c, opt3001_id);
 static const struct of_device_id opt3001_of_match[] = {
 	{ .compatible = "ti,opt3001", .data = &opt3001_chip_information },
 	{ .compatible = "ti,opt3002", .data = &opt3002_chip_information },
+	{ .compatible = "ti,opt3004", .data = &opt3001_chip_information },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, opt3001_of_match);
-- 
2.34.1


