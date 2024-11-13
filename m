Return-Path: <linux-iio+bounces-12208-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B229C7496
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 15:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6CC1F25CB3
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 14:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428BE1FBF63;
	Wed, 13 Nov 2024 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b="NR9xCUsO"
X-Original-To: linux-iio@vger.kernel.org
Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazon11020137.outbound.protection.outlook.com [52.101.169.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B1F1D2F42;
	Wed, 13 Nov 2024 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.169.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731508881; cv=fail; b=VQfndSHLdpWhkIWyI2IJ9BAmzYRVgi0V/5MmY4nxv7/T4xIDFp/QKPtjLS5HAaXvMql3kzI6CBSc54ZQTsk3LRH/WGRsn+CvCheHnN8W5HOE0C1OLbvy7Na2fdF1bycKSEOjoGZ9/mW5t09iKJ91FiNQIHpBRdeHqrCMQl2++jI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731508881; c=relaxed/simple;
	bh=M9mheXjM4tsBtD+Pd9PQCGiM/AsrhsljxQ+ewI5bqAg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UMDcmeMnxrlk6dkkCKibSedR7UpemVouOEoOHeeEi8foiSCGHM7NXMlwzg8PvsQUvj8YKPSzns9pE9egRinW5xnwKuofgQwVWWv3MGj8g7cEBDNLyHNPRfktKLcxEp29/Mb2g27uZZwZoVC5f0+tsy2RPm9j/HEdIdkWJtmzUA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com; spf=pass smtp.mailfrom=Softing.com; dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b=NR9xCUsO; arc=fail smtp.client-ip=52.101.169.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Softing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTJ3NwOm0XkhjHHrwfwYD7/T/5lpvLbBK+3Fvt/FznINdtg1TKW53KQG4LkDh1DF05DN87MAnhLL22I9up15luQy7AmYxFN7bxfbfSOdHieNmF2ZSRzs9Zhr089Y4kcd9BHnMyWcSYNRrPEwbt4wGZJIb0IUEfuCgY0uhlOqQssKC3s5vPxgEGzbhFB6Yer/eapd7n19KeL4HpcBFqRRNzPvVxbkE2nrRd7qw/H8PAsublm1rdhCJ5mUKsRRHo5AxqMxq6Yam7X4txbiAJoXe6SN/L2foKFqNW3pTk+sCiPqFJj+bo4ilbQMKoKHZz9ZeXs02i87sl01fJwqnidWDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mU9Dzs9DuaqqXVK5gF0I7v1t+i1lKcqNAV+5xDCdadk=;
 b=x9KqPgqO0PDv+1OvxNpuKRMyV3UCY3Dzmv7mtIjq1VrnkqvXiOETF1ButF5LmI1OJIWVaMf+Y42MuvnuUOmwmNLMLNzsTmk9/GDnF2AMkQMqiITbEU+MWGhEzQs97LnTIgDcGYGzPg0df2ex11c49XjpnVUz7+/dYgbh9yClRALN945SmnzIOZ3/vjUg/r+k24JCGsZO13MHEjDWoghkkVMDFBgiPxFUrWA9ApdCHcyyqiKfDzHcAkgPkxG6br0zI8P7SON1bAB6+QdZHeLH1pGpnWG8TjRlvfJB3yg+2LEWZAXJO0J6zopN8uXSZKAyvkWD4doZSTKH25qjrO8wwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softing.com; dmarc=pass action=none header.from=softing.com;
 dkim=pass header.d=softing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=softing.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mU9Dzs9DuaqqXVK5gF0I7v1t+i1lKcqNAV+5xDCdadk=;
 b=NR9xCUsOVG+JDpTWXs2T2FoaUnGQ9r2xQ3GwRmT7eg43jft3W1zT0MtglemptuQuIeufhC3/l+y2KlBQYz2bhfthoL3PyIf8GPL6E/botC26vz2fXaK9qC2WoJxQrLxxbQppFNHrgsBcpc3ekzOEumnwspedoswcO1YLzH1PcW+4K3cv/+arJQ6LiOgwgYywcR02SRzR+yFgv5KkBmyA6I0cRTu/R6D8OvEFp1ZH0jhnPf7ze2JZa4SvjO/lMS5uSWT9vkiAZN6yPpjGTmkKb0YFfISLmPWA+6q3rcef+jmERL8d55R8SPNhOq8aKQ+AaoQTLPh4ZKbUZicwZX0Z4g==
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::7) by
 FR4P281MB4149.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:f9::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.17; Wed, 13 Nov 2024 14:41:11 +0000
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a]) by BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a%5]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 14:41:11 +0000
From: "Sperling, Tobias" <Tobias.Sperling@Softing.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "jic23@kernel.org" <jic23@kernel.org>, "lars@metafoo.de"
	<lars@metafoo.de>, "Sperling, Tobias" <Tobias.Sperling@Softing.com>
Subject: [PATCH 2/2] iio: adc: Add driver for ADS7128 / ADS7138
Thread-Topic: [PATCH 2/2] iio: adc: Add driver for ADS7128 / ADS7138
Thread-Index: Ads12Lt4PoGR7YeOSnKggkJlDlhNcA==
Date: Wed, 13 Nov 2024 14:41:11 +0000
Message-ID:
 <BE1P281MB24202CD3D7B86DCAE2DE1130EF5A2@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Softing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB2420:EE_|FR4P281MB4149:EE_
x-ms-office365-filtering-correlation-id: 6f66bb13-7700-4d51-aa0a-08dd03f137cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vJFeBLkW5hpsSz8gh170pP+bY1hr9VbXcO0ERkpWS+i/nKlsLQLYRnUfhf2q?=
 =?us-ascii?Q?cZsXML6UDDiXD1UD2Q0JB7i4B3bs+MS5bUmBXtuFbEGOjyOfatrLyXdSI6r2?=
 =?us-ascii?Q?bibT8BCqRzg0iWjTRjyLvUMdCp/OKIHf6TP+EpXWNUBkL0sl0rktcnYbkFbw?=
 =?us-ascii?Q?d9VTLucca3RoiDDlfPMETqswhvppCrDSq5M+vE4r5nrs1PemO83Eu+Fse3HB?=
 =?us-ascii?Q?LYhkWircR4ECqSEOoA3Sgga4bz6H71nbae5YeSiLux/oQK3B/S4yEUdze5J+?=
 =?us-ascii?Q?Lfr5wU+7z4U7xPImYfl67w0qAMV0pQ7ZnUlqI1Jmp7SdCU9fWJifQ/ppY3ze?=
 =?us-ascii?Q?N8gDCDxBfI2PNAvyKnS8R4ukvzvF1kiwVepkK7DoWLhxl0X7p0xfGtc5JCv9?=
 =?us-ascii?Q?7KX4N+HDG+Kmtz6/ADzhPcxYASb63i+fWyeP5z+hsOFDUhb9mf1vyuvl8hlN?=
 =?us-ascii?Q?QAq6tR7q1N0cTNJdWQqJ4hTBoNqlZ168o33Etq8IqxQyHNSfCKNMRlos2O3/?=
 =?us-ascii?Q?RPVbxYX/gFYWW2Me1GxeiPkfEx0ybx8QToeR+/LBVVUdS/1Ck+Ndg3BOELYA?=
 =?us-ascii?Q?fqJmjbQx7GwepGlD1lxLi5ojpQpIxSB5fArjS/obrabqC4SRw1uNkoKS7iAg?=
 =?us-ascii?Q?FAj8jjg/UC55sF5MECgXghrcXRd1vSbY3nW5I9s0G7fBEp0CB+wHtCULMGq6?=
 =?us-ascii?Q?Y5ooaKZ4V45J2BKbPaaNSbAn8IQyxfbbgES3xJfl3+GpjfsPv3X7P7VrKKWl?=
 =?us-ascii?Q?JealsoHtd4iwHZQAobYpDjbDGgbHBLdrIBiaZCHV2EUKQip8EOA6nELmt4TV?=
 =?us-ascii?Q?wgvQWTLcCAST3t+2Iokma6pvMPPKZ5c46J9ByQKOJNytLbsg84GAb2QF47S9?=
 =?us-ascii?Q?126ejv9WduC3NwpoCnbHCnfCMS+oo2Iw0EBTeTBnVHrlvrV8MhUBmTP0QrQu?=
 =?us-ascii?Q?THgnw+ipJVBd7Kw8nA3xhAtG4j9DN0FRuAVxqneixG4jh352vZzRvxp7CHuG?=
 =?us-ascii?Q?U6ftfxSooWXy0s/U8g0yxB65wmfhWTt3+5aRFoH9mGxrujp3vRmqiJGOz5rc?=
 =?us-ascii?Q?vwlzPznQygKzlHyYHsTEx8eOfyj1KnzF5Hg5zsvN+6oBZR6PyZh8rU1h3kWI?=
 =?us-ascii?Q?DqpbWM0mD1agnBx7xI6wXzocpXpZKfc06T8fBNX17tsPgynhR+Qc39uyfSuj?=
 =?us-ascii?Q?CkIDydazS49xKjw2t67LEBeXGnWtAo05zrI3Z1KVJK3OvUjxApy+jRE/ZjKq?=
 =?us-ascii?Q?IRo4sOUETbZKfORIrEK4B/OM1nJtyaHFYU3Gkwr38BbpuVbileeLTSiRT7IZ?=
 =?us-ascii?Q?wzwPFxBN908k44WU05jO6Q1k6pw3N3uq9O8+jgpFisgAtZljSQBUCJQx0n9K?=
 =?us-ascii?Q?A2GSuyE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jsavCpfMnO8QgPRkE0U8KsnS2QlX+29yntG3TZjkjW7iWVbvdQWODKxFgv5+?=
 =?us-ascii?Q?Uwl3uIX7dbnE/FVIZ4dbz9AjN0YLRKRHVn4jf9oOOMQkftqdMxnNtXWc2vtC?=
 =?us-ascii?Q?kP99BCTHeaVRglGJn88+WRx+HPzyHX8UCdzS4qdzFK7aTqy0YMiqhH3gkQs0?=
 =?us-ascii?Q?vNv9B2tfJInbD2g44KgEo3sWQxNtHhta7kuwN8R6YB65Qi9BHRI8ARuvNvFo?=
 =?us-ascii?Q?epztJ9gSKVF89DI0ExtK0awn/q2N2FV7livuEynQGHuXozyymfFOVWxZgkIK?=
 =?us-ascii?Q?CKOSuPM1WVUQORqCGTmNBKm8HJ6lHBfYVRsbtUVtb7rbMTdrCUGLNNKSvDYb?=
 =?us-ascii?Q?q/7s3LxFhZwRojdpeQCtpA1xMa22Q5WHdx8KT2+GWibFtaGh8IU65jIeVEhW?=
 =?us-ascii?Q?e6guIfV1QGRl4KdMF/0wHi/YnKdQrJrTZqnlKsT/J6Bge/U2DCfcrTnbFUNW?=
 =?us-ascii?Q?YyYvV71C1AO6+5kMGniMtDfb/5K3qf+K112SIStKIL6HB8k7WIPOL5NPiJFf?=
 =?us-ascii?Q?iFNm1gt1Gw3+GduLkhTutC+6uQ6QC4c8VOY8q75rnLS3U1A5rXTF8yN00UHC?=
 =?us-ascii?Q?fdD7dEwrTzt7HnJnmXIif3KXias2Ph2taS8hcggDyLL6PxzSvX/9tO2d6uQO?=
 =?us-ascii?Q?xRG9TXmrprkOQ7hSOtV3rATDMar3mLw1U2+CsRznqrXnnPiBQ/509K2MtNbI?=
 =?us-ascii?Q?4D7HMH13aKd8vi+YPR5ueLB1t1alaAsgQzC7zEj1YfZFlwgZ14S4Y1He2NLI?=
 =?us-ascii?Q?JV1HeMs6HRqr8qvLPPZ4cebYgTF1HP3RHsZz+YmoTgwV3Mi4fBMg5kzipn01?=
 =?us-ascii?Q?S3LEqYBV9c677dKyXfxc66XGN20FG2yiuBwHVRYY8i2XdvNmKX3x5G/FB7gr?=
 =?us-ascii?Q?xrv5Woc8SV6rqYZ+/YPtCAqLGh7Hk88iFby3W2awaYk86X0oR3xCxKPezEJJ?=
 =?us-ascii?Q?2431gZ7lRNvM3hcIsw+hDaodLOwtS+RrENaLqWFBOh1oxTJCatgOAe2QEWWz?=
 =?us-ascii?Q?DQJ+munIBYslz+ZCxg/tAE+kz5uvziu8mYcHLcZydtkjBwLPATnSwv7YWyUc?=
 =?us-ascii?Q?GE3HKUTt16ZY1fjURjYhFLAJIdzlPVJW4+KVyD8QSiOW1ZTJGvnlJO6fbDf9?=
 =?us-ascii?Q?4GUWPs3bZZo9ajs8MVlNOYV79N4ZQNkrWuUZISN61fWkdva/B9zbPgiZqcGy?=
 =?us-ascii?Q?+VPJ4G2H7ffVInPZodciWtiTdvq5yL3fFCt/0ILK64ph1NB4CUEm+SMQDjiV?=
 =?us-ascii?Q?bKl9eIMEC4xDaBkeYeVUIy6g4X3ZM8xTyt70QWf7EodIlnvkr6SzEhf7l7pk?=
 =?us-ascii?Q?0STPlUhrX1wvcHWBHxfuzU9x0PFpz+/WqgHfDj/gzzwX6sP6C2tt0T6lEMlI?=
 =?us-ascii?Q?C40lL6ORv7+sKaoWsk81wx/pV6f8nkV1jP8xHhRf7AZI7V3RXr93TxLlS3gp?=
 =?us-ascii?Q?yQenxdHDwEpdtVzttgryf1sJubHlNUWm2vbKXOGle8hUVNHa1XuMron4X0PM?=
 =?us-ascii?Q?MelbJy/3HF9e4LqflyWIACEJjm4Uy0LUnGF3cibSSus6jSEPkhmX4agAKMHv?=
 =?us-ascii?Q?BM9KLv8XhDGse5LGMMygN+7v1s7NtEEB76S9WRCP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: softing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f66bb13-7700-4d51-aa0a-08dd03f137cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 14:41:11.4399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe3606fa-d397-4238-9997-68dcd7851f64
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /b3wrg3w6+i0snuJkABfRHtyvBcwM5kHx78iUxlU/R78mJ8Sw29kMXgjti/RE1oduepqJGx4DPLxPu3uL8L3kfGKGc/bYu7sxoMZ9vAfDyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB4149

From 934b0cb93b927f518146fd8398c982e936063669 Mon Sep 17 00:00:00 2001
From: Tobias Sperling <tobias.sperling@softing.com>
Date: Tue, 12 Nov 2024 14:53:34 +0100
Subject: [PATCH 2/2] iio: adc: Add driver for ADS7128 / ADS7138

Add driver for ADS7128 and ADS7138 12-bit, 8-channel analog-to-digital
converters. These ADCs have a wide operating range and a wide feature
set. Communication is based on the I2C interface.

Signed-off-by: Tobias Sperling <tobias.sperling@softing.com>
---
 drivers/iio/adc/Kconfig      |  10 +
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/ti-ads7138.c | 796 +++++++++++++++++++++++++++++++++++
 3 files changed, 807 insertions(+)
 create mode 100644 drivers/iio/adc/ti-ads7138.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 6c4e74420fd2..fe956b0cbb72 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1427,6 +1427,16 @@ config TI_ADS1119
          This driver can also be built as a module. If so, the module will=
 be
          called ti-ads1119.
=20
+config TI_ADS7138
+	tristate "Texas Instruments ADS7128 and ADS7138 ADC driver"
+	depends on I2C
+	help
+	  If you say yes here you get support for Texas Instruments ADS7128 and
+	  ADS7138 8-channel A/D converters with 12-bit resolution.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called ti-ads7138.
+
 config TI_ADS7924
 	tristate "Texas Instruments ADS7924 ADC"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 7b91cd98c0e0..38aebe49a1a8 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -130,6 +130,7 @@ obj-$(CONFIG_TI_ADS1119) +=3D ti-ads1119.o
 obj-$(CONFIG_TI_ADS124S08) +=3D ti-ads124s08.o
 obj-$(CONFIG_TI_ADS1298) +=3D ti-ads1298.o
 obj-$(CONFIG_TI_ADS131E08) +=3D ti-ads131e08.o
+obj-$(CONFIG_TI_ADS7138) +=3D ti-ads7138.o
 obj-$(CONFIG_TI_ADS7924) +=3D ti-ads7924.o
 obj-$(CONFIG_TI_ADS7950) +=3D ti-ads7950.o
 obj-$(CONFIG_TI_ADS8344) +=3D ti-ads8344.o
diff --git a/drivers/iio/adc/ti-ads7138.c b/drivers/iio/adc/ti-ads7138.c
new file mode 100644
index 000000000000..3ac76625bc63
--- /dev/null
+++ b/drivers/iio/adc/ti-ads7138.c
@@ -0,0 +1,796 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ADS7138 - Texas Instruments Analog-to-Digital Converter
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/types.h>
+
+#define MODULE_NAME "ads71x8"
+
+/* AVDD (VREF) operating range in millivolts */
+#define ADS71x8_AVDD_MV_MIN		2350
+#define ADS71x8_AVDD_MV_MAX		5500
+
+/*
+ * Always assume 16 bits resolution as HW registers are aligned like that =
and
+ * with enabled oversampling/averaging it actually corresponds to 16 bits.
+ */
+#define ADS71x8_RES_BITS		16
+
+/* ADS71x8 operation codes */
+#define ADS71x8_OPCODE_SET_BIT		0x18
+#define ADS71x8_OPCODE_CLEAR_BIT	0x20
+#define ADS71x8_OPCODE_BLOCK_WRITE	0x28
+#define ADS71x8_OPCODE_BLOCK_READ	0x30
+
+/* ADS71x8 registers */
+#define ADS71x8_REG_GENERAL_CFG		0x01
+#define ADS71x8_REG_OSR_CFG		0x03
+#define ADS71x8_REG_OPMODE_CFG		0x04
+#define ADS71x8_REG_SEQUENCE_CFG	0x10
+#define ADS71x8_REG_AUTO_SEQ_CH_SEL	0x12
+#define ADS71x8_REG_ALERT_CH_SEL	0x14
+#define ADS71x8_REG_EVENT_FLAG		0x18
+#define ADS71x8_REG_EVENT_HIGH_FLAG	0x1A
+#define ADS71x8_REG_EVENT_LOW_FLAG	0x1C
+#define ADS71x8_REG_HIGH_TH_HYS_CH(x)	((x) * 4 + 0x20)
+#define ADS71x8_REG_LOW_TH_CNT_CH(x)	((x) * 4 + 0x22)
+#define ADS71x8_REG_MAX_LSB_CH(x)	((x) * 2 + 0x60)
+#define ADS71x8_REG_MIN_LSB_CH(x)	((x) * 2 + 0x80)
+#define ADS71x8_REG_RECENT_LSB_CH(x)	((x) * 2 + 0xA0)
+
+#define ADS71x8_GENERAL_CFG_RST		BIT(0)
+#define ADS71x8_GENERAL_CFG_DWC_EN	BIT(4)
+#define ADS71x8_GENERAL_CFG_STATS_EN	BIT(5)
+#define ADS71x8_OSR_CFG_MASK		GENMASK(2, 0)
+#define ADS71x8_OPMODE_CFG_CONV_MODE	BIT(5)
+#define ADS71x8_OPMODE_CFG_FREQ_MASK	GENMASK(4, 0)
+#define ADS71x8_SEQUENCE_CFG_SEQ_MODE	BIT(0)
+#define ADS71x8_SEQUENCE_CFG_SEQ_START	BIT(4)
+#define ADS71x8_THRESHOLD_LSB_MASK	GENMASK(7, 4)
+
+enum ads71x8_modes {
+	ADS71x8_MODE_MANUAL,
+	ADS71x8_MODE_AUTO,
+};
+
+enum ads71x8_stats {
+	ADS71x8_STATS_MIN,
+	ADS71x8_STATS_MAX,
+};
+
+enum ads71x8_chips { ads7128, ads7138 };
+
+struct ads71x8_data {
+	struct mutex lock;
+	struct i2c_client *client;
+	struct regulator *vref_regu;
+};
+
+struct ads71x8_freq_bits {
+	u32 hz;
+	u8 bits;
+};
+
+static const struct ads71x8_freq_bits ads71x8_samp_freq[] =3D {
+	{163, 0x1F}, {244, 0x1E}, {326, 0x1D}, {488, 0x1C}, {651, 0x1B},
+	{977, 0x1A}, {1302, 0x19}, {1953, 0x18}, {2604, 0x17}, {3906, 0x16},
+	{5208, 0x15}, {7813, 0x14}, {10417, 0x13}, {15625, 0x12}, {20833, 0x11},
+	{31250, 0x10}, {41667, 0x09}, {62500, 0x08}, {83333, 0x07},
+	{125000, 0x06}, {166667, 0x05}, {250000, 0x04}, {333333, 0x03},
+	{500000, 0x02}, {666667, 0x01}, {1000000, 0x0}
+};
+
+static int ads71x8_i2c_write_block(const struct i2c_client *client, u8 reg=
,
+	u8 *values, u8 length)
+{
+	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
+	struct ads71x8_data *data =3D iio_priv(indio_dev);
+	int ret;
+	struct i2c_msg msgs[] =3D {
+		{
+			.addr =3D client->addr,
+			.flags =3D 0,
+			.len =3D length + 2, /* "+ 2" for OPCODE and reg */
+		},
+	};
+
+	msgs[0].buf =3D kmalloc(msgs[0].len, GFP_KERNEL);
+	if (!msgs[0].buf)
+		return -ENOMEM;
+
+	msgs[0].buf[0] =3D ADS71x8_OPCODE_BLOCK_WRITE;
+	msgs[0].buf[1] =3D reg;
+	memcpy(&msgs[0].buf[2], values, length);
+
+	mutex_lock(&data->lock);
+	ret =3D i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+	mutex_unlock(&data->lock);
+	kfree(msgs[0].buf);
+
+	return ret;
+}
+
+static int ads71x8_i2c_write(const struct i2c_client *client, u8 reg, u8 v=
alue)
+{
+	return ads71x8_i2c_write_block(client, reg, &value, sizeof(value));
+}
+
+static int ads71x8_i2c_setclear_bit(const struct i2c_client *client, u8 re=
g,
+	u8 bits, u8 opcode)
+{
+	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
+	struct ads71x8_data *data =3D iio_priv(indio_dev);
+	int ret;
+	u8 buf[3] =3D {opcode, reg, bits};
+	struct i2c_msg msgs[] =3D {
+		{
+			.addr =3D client->addr,
+			.flags =3D 0,
+			.len =3D ARRAY_SIZE(buf),
+			.buf =3D buf,
+		},
+	};
+
+	mutex_lock(&data->lock);
+	ret =3D i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static int ads71x8_i2c_set_bit(const struct i2c_client *client, u8 reg, u8=
 bits)
+{
+	return ads71x8_i2c_setclear_bit(client, reg, bits,
+		ADS71x8_OPCODE_SET_BIT);
+}
+
+static int ads71x8_i2c_clear_bit(const struct i2c_client *client, u8 reg, =
u8 bits)
+{
+	return ads71x8_i2c_setclear_bit(client, reg, bits,
+		ADS71x8_OPCODE_CLEAR_BIT);
+}
+
+static int ads71x8_i2c_read_block(const struct i2c_client *client, u8 reg,
+	u8 *out_values, u8 length)
+{
+	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
+	struct ads71x8_data *data =3D iio_priv(indio_dev);
+	int ret;
+	u8 buf[2] =3D {ADS71x8_OPCODE_BLOCK_READ, reg};
+	struct i2c_msg msgs[] =3D {
+		{
+			.addr =3D client->addr,
+			.flags =3D 0,
+			.len =3D ARRAY_SIZE(buf),
+			.buf =3D buf,
+		},
+		{
+			.addr =3D client->addr,
+			.flags =3D I2C_M_RD,
+			.len =3D length,
+			.buf =3D out_values,
+		},
+	};
+
+	mutex_lock(&data->lock);
+	ret =3D i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static int ads71x8_i2c_read(const struct i2c_client *client, u8 reg)
+{
+	u8 value;
+	int ret;
+
+	ret =3D ads71x8_i2c_read_block(client, reg, &value, sizeof(value));
+	if (ret < 0)
+		return ret;
+	return value;
+}
+
+static const struct ads71x8_freq_bits *get_closest_freq(int freq)
+{
+	const int idx_max =3D ARRAY_SIZE(ads71x8_samp_freq) - 1;
+	u32 cur, best =3D ads71x8_samp_freq[idx_max].hz;
+	int i;
+
+	freq =3D clamp_val(freq, ads71x8_samp_freq[0].hz,
+		ads71x8_samp_freq[idx_max].hz);
+
+	for (i =3D 0; i <=3D idx_max; i++) {
+		cur =3D abs(ads71x8_samp_freq[i].hz - freq);
+		if (cur > best)
+			return &ads71x8_samp_freq[i-1];
+		best =3D cur;
+	}
+	return &ads71x8_samp_freq[idx_max];
+}
+
+static u32 get_closest_log2(u32 val)
+{
+	u32 down =3D ilog2(val);
+	u32 up =3D ilog2(roundup_pow_of_two(val));
+
+	return (val - (1 << down) < (1 << up) - val) ? down : up;
+}
+
+static int ads71x8_read_raw(struct iio_dev *indio_dev,
+	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
+{
+	struct ads71x8_data *data =3D iio_priv(indio_dev);
+	int i, ret, vref;
+	u8 values[2];
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret =3D ads71x8_i2c_read_block(data->client,
+			ADS71x8_REG_RECENT_LSB_CH(chan->channel), values,
+			ARRAY_SIZE(values));
+		if (ret < 0)
+			return ret;
+
+		*val =3D ((values[1] << 8) | values[0]);
+		ret =3D IIO_VAL_INT;
+		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret =3D ads71x8_i2c_read(data->client, ADS71x8_REG_OPMODE_CFG);
+		if (ret < 0)
+			return ret;
+
+		for (i =3D 0; i < ARRAY_SIZE(ads71x8_samp_freq); i++) {
+			if (ads71x8_samp_freq[i].bits =3D=3D
+					(ret & ADS71x8_OPMODE_CFG_FREQ_MASK)) {
+				*val =3D ads71x8_samp_freq[i].hz;
+				return IIO_VAL_INT;
+			}
+		}
+
+		ret =3D -EINVAL;
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		if (data->vref_regu) {
+			vref =3D regulator_get_voltage(data->vref_regu);
+			if (vref < 0)
+				return vref;
+			*val =3D vref / 1000;
+		} else {
+			*val =3D ADS71x8_AVDD_MV_MIN;
+		}
+		*val2 =3D ADS71x8_RES_BITS;
+		ret =3D IIO_VAL_FRACTIONAL_LOG2;
+		break;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		ret =3D ads71x8_i2c_read(data->client, ADS71x8_REG_OSR_CFG);
+		if (ret < 0)
+			return ret;
+		*val =3D (1 << (ret & ADS71x8_OSR_CFG_MASK));
+		ret =3D IIO_VAL_INT;
+		break;
+	default:
+		ret =3D -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int ads71x8_write_raw(struct iio_dev *indio_dev,
+	struct iio_chan_spec const *chan, int val, int val2, long mask)
+{
+	struct ads71x8_data *data =3D iio_priv(indio_dev);
+	const struct ads71x8_freq_bits *freq =3D NULL;
+	int ret;
+	u8 osr_val;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		freq =3D get_closest_freq(val);
+		ret =3D ads71x8_i2c_read(data->client, ADS71x8_REG_OPMODE_CFG);
+		if (ret < 0)
+			return ret;
+		ret =3D ads71x8_i2c_write(data->client, ADS71x8_REG_OPMODE_CFG,
+			(ret & ~ADS71x8_OPMODE_CFG_FREQ_MASK) |
+			(freq->bits & ADS71x8_OPMODE_CFG_FREQ_MASK));
+		ret =3D (ret > 0) ? 0 : ret;
+		break;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		/* Number of samples can only be a power of 2 */
+		osr_val =3D get_closest_log2(clamp_val(val, 1, 128));
+		ret =3D ads71x8_i2c_write(data->client, ADS71x8_REG_OSR_CFG,
+			osr_val);
+		ret =3D (ret > 0) ? 0 : ret;
+		break;
+	default:
+		ret =3D -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static ssize_t ads71x8_read_stats(struct iio_dev *indio_dev, uintptr_t pri=
v,
+	const struct iio_chan_spec *chan, char *buf)
+{
+	struct ads71x8_data *data =3D iio_priv(indio_dev);
+	int ret;
+	u8 values[2];
+
+	switch (priv) {
+	case ADS71x8_STATS_MIN:
+		ret =3D ads71x8_i2c_read_block(data->client,
+			ADS71x8_REG_MIN_LSB_CH(chan->channel), values,
+			ARRAY_SIZE(values));
+		if (ret < 0)
+			return ret;
+		break;
+	case ADS71x8_STATS_MAX:
+		ret =3D ads71x8_i2c_read_block(data->client,
+			ADS71x8_REG_MAX_LSB_CH(chan->channel), values,
+			ARRAY_SIZE(values));
+		if (ret < 0)
+			return ret;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return sprintf(buf, "%d\n", ((values[1] << 8) | values[0]));
+}
+
+static int ads71x8_read_event(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir, enum iio_event_info info, int *val,
+	int *val2)
+{
+	int ret;
+	u8 reg, values[2];
+	struct ads71x8_data *data =3D iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		reg =3D (dir =3D=3D IIO_EV_DIR_RISING) ?
+			ADS71x8_REG_HIGH_TH_HYS_CH(chan->channel) :
+			ADS71x8_REG_LOW_TH_CNT_CH(chan->channel);
+		ret =3D ads71x8_i2c_read_block(data->client, reg, values,
+			ARRAY_SIZE(values));
+		if (ret < 0)
+			return ret;
+
+		*val =3D ((values[1] << 4) | (values[0] >> 4));
+		ret =3D IIO_VAL_INT;
+		break;
+	case IIO_EV_INFO_HYSTERESIS:
+		ret =3D ads71x8_i2c_read(data->client,
+			ADS71x8_REG_HIGH_TH_HYS_CH(chan->channel));
+		if (ret < 0)
+			return ret;
+
+		*val =3D (ret & ~ADS71x8_THRESHOLD_LSB_MASK);
+		ret =3D IIO_VAL_INT;
+		break;
+	default:
+		ret =3D -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int ads71x8_write_event(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir, enum iio_event_info info, int val,
+	int val2)
+{
+	struct ads71x8_data *data =3D iio_priv(indio_dev);
+	int ret;
+	u8 reg, values[2];
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		if (val >=3D BIT(12) || val < 0) {
+			ret =3D -EINVAL;
+			break;
+		}
+		reg =3D (dir =3D=3D IIO_EV_DIR_RISING) ?
+			ADS71x8_REG_HIGH_TH_HYS_CH(chan->channel) :
+			ADS71x8_REG_LOW_TH_CNT_CH(chan->channel);
+
+		ret =3D ads71x8_i2c_read(data->client, reg);
+		if (ret < 0)
+			return ret;
+
+		values[0] =3D (((val & 0x0F) << 4) |
+			(ret & ~ADS71x8_THRESHOLD_LSB_MASK));
+		values[1] =3D (val >> 4);
+		ret =3D ads71x8_i2c_write_block(data->client, reg, values,
+			ARRAY_SIZE(values));
+		ret =3D (ret > 0) ? 0 : ret;
+		break;
+	case IIO_EV_INFO_HYSTERESIS:
+		if (val >=3D BIT(4) || val < 0) {
+			ret =3D -EINVAL;
+			break;
+		}
+		reg =3D ADS71x8_REG_HIGH_TH_HYS_CH(chan->channel);
+		ret =3D ads71x8_i2c_read(data->client, reg);
+		if (ret < 0)
+			return ret;
+
+		ret =3D ads71x8_i2c_write(data->client, reg,
+			((ret & ADS71x8_THRESHOLD_LSB_MASK) |
+			(val & ~ADS71x8_THRESHOLD_LSB_MASK)));
+		ret =3D (ret > 0) ? 0 : ret;
+		break;
+	default:
+		ret =3D -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int ads71x8_read_event_config(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir)
+{
+	struct ads71x8_data *data =3D iio_priv(indio_dev);
+	int ret;
+
+	switch (dir) {
+	case IIO_EV_DIR_EITHER:
+		ret =3D ads71x8_i2c_read(data->client, ADS71x8_REG_ALERT_CH_SEL);
+		if (ret < 0)
+			return ret;
+
+		ret =3D (ret & BIT(chan->channel)) ? 1 : 0;
+		break;
+	default:
+		ret =3D -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int ads71x8_write_event_config(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir, int state)
+{
+	struct ads71x8_data *data =3D iio_priv(indio_dev);
+	int ret;
+
+	switch (dir) {
+	case IIO_EV_DIR_EITHER:
+		if (state)
+			ret =3D ads71x8_i2c_set_bit(data->client,
+				ADS71x8_REG_ALERT_CH_SEL, BIT(chan->channel));
+		else
+			ret =3D ads71x8_i2c_clear_bit(data->client,
+				ADS71x8_REG_ALERT_CH_SEL, BIT(chan->channel));
+		break;
+	default:
+		ret =3D -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static ssize_t ads71x8_show_samp_freq_avail(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	int i;
+	ssize_t len =3D 0;
+
+	for (i =3D 0; i < ARRAY_SIZE(ads71x8_samp_freq); i++)
+		len +=3D scnprintf(buf + len, PAGE_SIZE - len, "%d ",
+			ads71x8_samp_freq[i].hz);
+	buf[len - 1] =3D '\n';
+
+	return len;
+}
+
+static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(ads71x8_show_samp_freq_avail);
+
+static struct attribute *ads71x8_attributes[] =3D {
+	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ads71x8_attribute_group =3D {
+	.attrs =3D ads71x8_attributes,
+};
+
+static const struct iio_info ti_ads71x8_info =3D {
+	.attrs =3D &ads71x8_attribute_group,
+	.read_raw =3D &ads71x8_read_raw,
+	.write_raw =3D &ads71x8_write_raw,
+	.read_event_value =3D &ads71x8_read_event,
+	.write_event_value =3D &ads71x8_write_event,
+	.read_event_config =3D &ads71x8_read_event_config,
+	.write_event_config =3D &ads71x8_write_event_config,
+};
+
+static const struct iio_event_spec ads71x8_events[] =3D {
+	{
+		.type =3D IIO_EV_TYPE_THRESH,
+		.dir =3D IIO_EV_DIR_RISING,
+		.mask_separate =3D BIT(IIO_EV_INFO_VALUE)
+	}, {
+		.type =3D IIO_EV_TYPE_THRESH,
+		.dir =3D IIO_EV_DIR_FALLING,
+		.mask_separate =3D BIT(IIO_EV_INFO_VALUE),
+	}, {
+		.type =3D IIO_EV_TYPE_THRESH,
+		.dir =3D IIO_EV_DIR_EITHER,
+		.mask_separate =3D BIT(IIO_EV_INFO_HYSTERESIS) |
+			BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static const struct iio_chan_spec_ext_info ads71x8_ext_info[] =3D {
+	{"stats_min", IIO_SEPARATE, ads71x8_read_stats, NULL, ADS71x8_STATS_MIN},
+	{"stats_max", IIO_SEPARATE, ads71x8_read_stats, NULL, ADS71x8_STATS_MAX},
+	{},
+};
+
+#define ADS71x8_V_CHAN(_chan) {						\
+	.type =3D IIO_VOLTAGE,						\
+	.indexed =3D 1,							\
+	.channel =3D _chan,						\
+	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
+		BIT(IIO_CHAN_INFO_SCALE) |				\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
+	.datasheet_name =3D "AIN"#_chan,					\
+	.event_spec =3D ads71x8_events,					\
+	.num_event_specs =3D ARRAY_SIZE(ads71x8_events),			\
+	.ext_info =3D ads71x8_ext_info,					\
+}
+
+static const struct iio_chan_spec ads71x8_channels[] =3D {
+	ADS71x8_V_CHAN(0),
+	ADS71x8_V_CHAN(1),
+	ADS71x8_V_CHAN(2),
+	ADS71x8_V_CHAN(3),
+	ADS71x8_V_CHAN(4),
+	ADS71x8_V_CHAN(5),
+	ADS71x8_V_CHAN(6),
+	ADS71x8_V_CHAN(7),
+};
+
+static irqreturn_t ads71x8_event_handler(int irq, void *priv)
+{
+	struct iio_dev *indio_dev =3D priv;
+	struct ads71x8_data *data =3D iio_priv(indio_dev);
+	int ret;
+	u8 i, events_high, events_low;
+	u64 code;
+
+	/* Check if interrupt was trigger by us */
+	ret =3D ads71x8_i2c_read(data->client, ADS71x8_REG_EVENT_FLAG);
+	if (ret <=3D 0)
+		return IRQ_NONE;
+
+	ret =3D ads71x8_i2c_read(data->client, ADS71x8_REG_EVENT_HIGH_FLAG);
+	events_high =3D ret;
+	if (ret < 0)
+		goto out;
+
+	ret =3D ads71x8_i2c_read(data->client, ADS71x8_REG_EVENT_LOW_FLAG);
+	events_low =3D ret;
+	if (ret < 0)
+		goto out;
+
+	for (i =3D 0; i < 8; i++) {
+		if (events_high & BIT(i)) {
+			code =3D IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
+				IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING);
+			iio_push_event(indio_dev, code,
+				iio_get_time_ns(indio_dev));
+		}
+		if (events_low & BIT(i)) {
+			code =3D IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
+				IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING);
+			iio_push_event(indio_dev, code,
+				iio_get_time_ns(indio_dev));
+		}
+	}
+
+	/* Clear all interrupt flags */
+	ads71x8_i2c_write(data->client, ADS71x8_REG_EVENT_HIGH_FLAG, 0xFF);
+	ads71x8_i2c_write(data->client, ADS71x8_REG_EVENT_LOW_FLAG, 0xFF);
+
+out:
+	if (ret < 0)
+		dev_warn(&data->client->dev,
+			"Couldn't handle interrupt correctly: %d\n", ret);
+	return IRQ_HANDLED;
+}
+
+static int ads71x8_set_conv_mode(struct ads71x8_data *data,
+	enum ads71x8_modes mode)
+{
+	if (mode =3D=3D ADS71x8_MODE_AUTO)
+		return ads71x8_i2c_set_bit(data->client, ADS71x8_REG_OPMODE_CFG,
+			ADS71x8_OPMODE_CFG_CONV_MODE);
+	return ads71x8_i2c_clear_bit(data->client, ADS71x8_REG_OPMODE_CFG,
+		ADS71x8_OPMODE_CFG_CONV_MODE);
+}
+
+static int ads7138_init_hw(struct ads71x8_data *data)
+{
+	int ret =3D 0;
+
+	data->vref_regu =3D devm_regulator_get(&data->client->dev, "avdd");
+	if (IS_ERR(data->vref_regu))
+		data->vref_regu =3D NULL;
+
+	/* Reset the chip to get a defined starting configuration */
+	ret =3D ads71x8_i2c_set_bit(data->client, ADS71x8_REG_GENERAL_CFG,
+		ADS71x8_GENERAL_CFG_RST);
+	if (ret < 0)
+		goto cleanup_config;
+
+	ret =3D ads71x8_set_conv_mode(data, ADS71x8_MODE_AUTO);
+	if (ret < 0)
+		goto cleanup_config;
+
+	/* Enable statistics and digital window comparator */
+	ret =3D ads71x8_i2c_set_bit(data->client, ADS71x8_REG_GENERAL_CFG,
+		(ADS71x8_GENERAL_CFG_STATS_EN | ADS71x8_GENERAL_CFG_DWC_EN));
+	if (ret < 0)
+		goto cleanup_config;
+
+	/* Enable all channels for auto sequencing */
+	ret =3D ads71x8_i2c_set_bit(data->client, ADS71x8_REG_AUTO_SEQ_CH_SEL, 0x=
FF);
+	if (ret < 0)
+		goto cleanup_config;
+
+	/* Set auto sequence mode and start sequencing */
+	ret =3D ads71x8_i2c_set_bit(data->client, ADS71x8_REG_SEQUENCE_CFG,
+		(ADS71x8_SEQUENCE_CFG_SEQ_START | ADS71x8_SEQUENCE_CFG_SEQ_MODE));
+	if (ret < 0)
+		goto cleanup_config;
+
+	return 0;
+
+cleanup_config:
+	return ret;
+}
+
+static int ads71x8_probe(struct i2c_client *client)
+{
+	const struct i2c_device_id *id =3D i2c_client_get_device_id(client);
+	struct iio_dev *indio_dev;
+	struct ads71x8_data *data;
+	int ret =3D 0;
+
+	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
+
+	data =3D iio_priv(indio_dev);
+	data->client =3D client;
+	i2c_set_clientdata(client, indio_dev);
+	mutex_init(&data->lock);
+
+	indio_dev->dev.parent =3D &client->dev;
+	indio_dev->dev.of_node =3D client->dev.of_node;
+	indio_dev->name =3D id->name;
+	indio_dev->modes =3D INDIO_DIRECT_MODE;
+	indio_dev->channels =3D ads71x8_channels;
+	indio_dev->num_channels =3D ARRAY_SIZE(ads71x8_channels);
+	indio_dev->info =3D &ti_ads71x8_info;
+
+	ret =3D devm_request_threaded_irq(&client->dev, client->irq,
+		NULL, ads71x8_event_handler,
+		IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
+		client->name, indio_dev);
+	if (ret)
+		goto cleanup_mutex;
+
+	ret =3D iio_device_register(indio_dev);
+	if (ret) {
+		dev_err(&client->dev, "Failed to register iio device\n");
+		goto cleanup_mutex;
+	}
+
+	ret =3D ads7138_init_hw(data);
+	if (ret) {
+		dev_err(&client->dev, "Failed to initialize device\n");
+		goto cleanup_iio;
+	}
+
+	return 0;
+
+cleanup_iio:
+	iio_device_unregister(indio_dev);
+cleanup_mutex:
+	mutex_destroy(&data->lock);
+out:
+	return ret;
+}
+
+static void ads71x8_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
+	struct ads71x8_data *data =3D iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	mutex_destroy(&data->lock);
+}
+
+#ifdef CONFIG_PM
+static int ads71x8_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
+	struct ads71x8_data *data =3D iio_priv(indio_dev);
+
+	return ads71x8_set_conv_mode(data, ADS71x8_MODE_MANUAL);
+}
+
+static int ads71x8_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
+	struct ads71x8_data *data =3D iio_priv(indio_dev);
+
+	return ads71x8_set_conv_mode(data, ADS71x8_MODE_AUTO);
+}
+#endif
+
+static const struct dev_pm_ops ads71x8_pm_ops =3D {
+	SET_RUNTIME_PM_OPS(ads71x8_runtime_suspend, ads71x8_runtime_resume, NULL)
+};
+
+static const struct of_device_id __maybe_unused ads71x8_of_match[] =3D {
+	{
+		.compatible =3D "ti,ads7128",
+		.data =3D (void *)ads7128
+	},
+	{
+		.compatible =3D "ti,ads7138",
+		.data =3D (void *)ads7138
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ads71x8_of_match);
+
+static const struct i2c_device_id ads71x8_device_ids[] =3D {
+	{ "ads7128", ads7128 },
+	{ "ads7138", ads7138 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ads71x8_device_ids);
+
+static struct i2c_driver ads71x8_driver =3D {
+	.driver =3D {
+		.name =3D MODULE_NAME,
+		.of_match_table =3D of_match_ptr(ads71x8_of_match),
+		.pm =3D &ads71x8_pm_ops,
+	},
+	.id_table =3D ads71x8_device_ids,
+	.probe =3D ads71x8_probe,
+	.remove =3D ads71x8_remove,
+};
+module_i2c_driver(ads71x8_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Tobias Sperling <tobias.sperling@softing.com>");
+MODULE_DESCRIPTION("Driver for TI ADS71x8 ADCs");
--=20
2.34.1


