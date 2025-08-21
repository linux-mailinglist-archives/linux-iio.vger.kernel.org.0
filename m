Return-Path: <linux-iio+bounces-23086-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B63B2F09E
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 10:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E4F61CC0217
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 08:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACD12EA75C;
	Thu, 21 Aug 2025 08:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="P0SEWbyG"
X-Original-To: linux-iio@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012019.outbound.protection.outlook.com [52.101.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEB02EA734;
	Thu, 21 Aug 2025 08:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763682; cv=fail; b=Z9P2Mzh9pe70lJgNzpgPHzNQvWpMtLzTsKdnJN79PfCKYf6AgrHfQxCgqePTfA6P23gCjddrgPjrvHDeTRhqay2LZ7f5WyNxVpL09kRNgi29UQZYDumiHayjWlObvYbh4GNM/EaSe4lViLrpc9lCzj0Z9H/8MasYZ4vwZptvPVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763682; c=relaxed/simple;
	bh=uWQWnPa62++oy6K2bAFSYIXmQoypveukaIFTm/DGXJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=axpx7dggyJ//TD/DDJIYOU++bjz5XeX+41J14jS0cVb1NafqBXXPfRorlV7e8z+a7/pQIT19pnKQ/U830zM/Ena3Fi3xG+rQmT3wBmDAGS6VFOdLZosjTUT6zl/YyvbWtAnb64yif4w7jaOfp20lAiz8T5HOvam801kpZov0/4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=P0SEWbyG; arc=fail smtp.client-ip=52.101.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdos0Cea+w1cdqf/juoC+0vNPKNBxR4XCFGfBX+CJzhTMapXpTwMQWoCudoT3x58+LrCXSVz6CFedL05kXrP7mBgYNII3oX2KylmAXyi7W0AE6F8Vj6xDCm0wbf4W2FIpm+9JJHK7jNTEvyj25UuovZbiCZS2qsO039RofJX9izI2RBsKSsrq49vHZ9kZGG5S3hW9yL6lZxpSumy4J72URNEJi1UTeUcfIZrpU69V3fDFdDrivTquXICpoX0Nsq/d5xipWaG8AF1OzsV+STe2JuO4fcwAeilHzeW7SLE6o3BdS0YSVjMOPgWWvgUjxKKazsFtmZRXRGqTOAgvg10lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iR+4UEZwjUgt84DzRsoTSdZa5gvd8VDs+T++Y1MD5tQ=;
 b=sLEqVlZPVc9r1Lb76kwQh+OgFrpFlOtKiJmam5BBHFNY9dHVDZRlXO0WfJyADA7Pdy+BTTXB5TgdOgZ+B618gYhjKTdIliXqkzxkOUx2qA28HlfBnCR39EqL/iz/cZRXvrtLlSlj0IIeF+d5o+vuS9Xme2Fg8opmt7L0w4HzkrfB/bLoWJpoQVxUDiNZtfxFE0mJu08dBk1Aqd1Xxr172N4x1rA35O6gFY0xNQEGrS7tvckQ3sghaQRtvsxD1DPEZmYQD7ZwAJYCkuNO3PBTn6M0nu+RuXWVCxWylweyP6ooRUnKt7zs3TF5hZg7FFn4m6o7bDjBppkTN/mvYA+jjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iR+4UEZwjUgt84DzRsoTSdZa5gvd8VDs+T++Y1MD5tQ=;
 b=P0SEWbyGD7u06l+xxdmOmd23+nC608eKU1p+ArvJ89Q2lX6mv0F6Uwa2BhlCsRxKrZKB6f35BoftKlp5wvLN4OTa+SINTH+E5DkaDQO0+fOwg9qcb9Ud1g1Bc/cuvtYNoZmlRLqLayaLrU+Q7s72msd/q43yF+/bWlnWt67sgRZu0ypF0uS8IWe5lU3IXJDe4OxzSB5rJYkyZsGphsb6laLBlTwPNMWj8XISfDmZ8/e2jKlwuia2LZyQCiFcLiA96yJEiVhos/cRtCzwjmisCh1C57IQn8OOo2I8voaExNXwBA5p1njK/dfbSP0DluNSy4JLsy4J/aHpN7Nxff7hew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by SEZPR06MB6488.apcprd06.prod.outlook.com (2603:1096:101:18a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 08:07:56 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9052.012; Thu, 21 Aug 2025
 08:07:56 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: Jagath Jog J <jagathjog1996@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:BOSCH SENSORTEC BMI323 IMU IIO DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH 4/7] iio: imu: bmi323: Remove dev_err_probe() if error is -ENOMEM
Date: Thu, 21 Aug 2025 16:06:48 +0800
Message-Id: <20250821080723.525379-5-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821080723.525379-1-zhao.xichao@vivo.com>
References: <20250821080723.525379-1-zhao.xichao@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0027.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::9) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|SEZPR06MB6488:EE_
X-MS-Office365-Filtering-Correlation-Id: 974ec078-fae8-4223-9bce-08dde089d5d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jz3Vkk0YVFBkOX5ket/ysxZBcqM/NAKQ9/EZrd6iT5gI1ABCvj/k6SDMD2yK?=
 =?us-ascii?Q?98EW35IBbXALacTqQ8eKCvU2ETxlQkMus5JsA1h07WgaYbc7PFRlRUrnV/L3?=
 =?us-ascii?Q?O1chibPHmXTu0BMBDKMTF+iRwaza7hvIhGkBPE+n4vCtyJdTwFrFCjZU3Vm9?=
 =?us-ascii?Q?sKSgRxVGcP3sxqXqhj9EHETaplVzcQFi6zwDWmGB8i9OTKFeIsi879s+dpGr?=
 =?us-ascii?Q?lfKmZ8E8GAAeNh2xxm/vLsLqpphmO0b7i7PkTD0XEMSwrwzC9Y6Z04xejVeL?=
 =?us-ascii?Q?3xG9+zYOr8IMh1pxyuiLOx3pc+y4UQoqNzUk/7ibtn/sZswFrK+fXzWJWhwm?=
 =?us-ascii?Q?0KXeH6K7j4LiX/CmLDSN2RjRz2O+Y4cvkbxLg/ywHMEO3VJmER/7iJSuDuPe?=
 =?us-ascii?Q?Wx5fG6Lx94HTZ6Xt0a2AWrrocLbBMxv7jq1uGQZgVM/05VrbWQnUz661FP2c?=
 =?us-ascii?Q?Ud4W+Y47aKxcrk4+HN0G7uuo8ULBIz6ONA3F8I2UFWz+AXlE7mu+mf+S/I26?=
 =?us-ascii?Q?AuARUz07S+MdLTFqTb3HroF2skcvSpVOorwJgEvhUjY9QHLzKPtKTyZwB/GJ?=
 =?us-ascii?Q?TcFdgzPxNqJ61xQFKTq4Z+gqc/51z6MMueCRX+siNUGYUXhN3fHAKbgRzJJ/?=
 =?us-ascii?Q?GEIsQZt/vu2TA3kjHBu4pold/36KYMVRtyB6v4V56Y8gloml6HRDwPOKhEq3?=
 =?us-ascii?Q?x4gZ9o7x3B7YZPxBf36g7vMW2+VO9oXFfJwOmGh9Ji2nTcf8aAjSAaEP2DmG?=
 =?us-ascii?Q?IYu6VwRcFBLnIdx4VVPWKS+0gu2cSXwDloALD4PZp093ajLlYzaOlEx6mQZ1?=
 =?us-ascii?Q?rYg7hQzqGucKqJKHnkWhyVQ4MJ/qJFr4lH+2azZcWw7ErKZOHSo7FhA0qdbe?=
 =?us-ascii?Q?DUGLML5lJ/YjPX1nlon5WdSBeWd5tdquaSQadUQ3XTCjFOLnpyUdL7viPiBQ?=
 =?us-ascii?Q?E3vfPiGfDJ+L3b1dBWB5oj7StWnJdgmYmoFuOO0W06DDv1hB4UUCObMUl3XP?=
 =?us-ascii?Q?fSuKxdvkw09FRcS/J/hQfphP2hqFB2Gl7w2Gha9g9mDC4NPRbK5b+LMxPXc8?=
 =?us-ascii?Q?+fG15k/4XqZXhdz+l1tIZDNCtsZDSUcfYaM4Tk/JAtsz2yl9x/YQX4XN+sWt?=
 =?us-ascii?Q?fz5hN2coWWKmWXoSeVOvcyl89uyNPSLVL5PZiAOeZVGZiVrY2JbwP23dluKC?=
 =?us-ascii?Q?d9JLtPrLBuxXaCYAUTahuI5FuEs+reXgNKR6lFdYVOiOkrmoMmVUmcSpw1n6?=
 =?us-ascii?Q?aUIWpCi8jQwQz1O5VnRSwUfBk+fANaDYEtt3XhHot5gU7Ack1dCCsHpUX0JP?=
 =?us-ascii?Q?FahgulXOvldGxur4Cl6QmhPf6Iynr8/YNtz1nBqtWbNx9FuOXjDdf7qfj1y+?=
 =?us-ascii?Q?L1+K7NuxtfMtDEW77yVGbwmGJqgTZwnnIh2cfV55LhRDBK3ElqheLFW//SKa?=
 =?us-ascii?Q?WPIUobl5qlKMtnRNVwcOqFVCCDAHIuKFMi2m+BjR8lfhHZROLJgOqg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k/LKyC3u17dymOg0sXU+eMQJYj4BboOmFyg8RkylUK/+l2d3GbC1SNmpnrul?=
 =?us-ascii?Q?rSFscbTZQgSY1sdCGxyTjOvxvFkDHvnp56GeQdUq2C8ajMer2XKk+liifmWO?=
 =?us-ascii?Q?Uwk9ZtLaFE2ENLrW94YX+YMKTv4+8CfFgpldscCoc2RAJldwDlpd7LMqEMvS?=
 =?us-ascii?Q?zYOS1jJg/8N5o9tfkCOY2ASQJv1wwSkqNYC6F/DWtE8OdpK2ipdD/1ym56cL?=
 =?us-ascii?Q?X43MKzyG1DbZhmDNFYFZzXbu8beSSLj8v3U8OI08saW6b220W4DDWeTxWcG7?=
 =?us-ascii?Q?+HluKINMMcKUn0e3LucqBXBazMZlC0lFABx/HHFmZZ6bQqaP03zgT3Pp1XQF?=
 =?us-ascii?Q?nEu9W9qxvfFyi273EEh0FWtwJlyYVJ2amJYtSWRT+GboiIszQjzlHDQvkO2U?=
 =?us-ascii?Q?fQ+GgEKj/iDa18hpdw1ugXDpOJCebEri03tV6Rr5pUTeSU/l+v+6ylOutwLc?=
 =?us-ascii?Q?IooG1YUwmgs+G7yxPYDqpqDSTEFi6nQGcVwuqyUhqR4QFtAtnhlRzfLWMiyJ?=
 =?us-ascii?Q?W2Y3jmy995dC3CTSfeArtNDFstoVQrAFAy8wW6gpsMfkmpeWDFrt1E30lT6U?=
 =?us-ascii?Q?rW4Ol1FB6T2rOf02LUPQ4PusfO6/MxehAC5QvaZUJD3US9XwqQx3IOhtkJdg?=
 =?us-ascii?Q?SvJiPlxjCK57QgYaUv+Cr/PtJsZXixHLWY+9ZXZvU4wwlSkfl5lQQHkfpZeB?=
 =?us-ascii?Q?ufbgYmCrPLcUuRckUzf1NY4hleb/v/I9yRqpmXCm2dEv4O1IbN4Q1CBfeqIo?=
 =?us-ascii?Q?E5qWTy7z4pp8yq1fq8oMKrQvlus/3agp71exowyOMncMRiRvMCZtgLT4fGFd?=
 =?us-ascii?Q?+MyydkVsOD0gD6wL+8UiRB6P2Ghi68bD61w7p/AXFtnNgq1s+arvgi8v7KvN?=
 =?us-ascii?Q?ABp6qaVgNcfASL6qj/qrze/o0/uFKsnOZgmE0s/wk4WFGCJELK2HnrUb3R3B?=
 =?us-ascii?Q?AM3gAfsnU97QcZ9wphlCcvYrx5LxEHZULfuYwmwB3iniqjSN2cTvykfh4z4w?=
 =?us-ascii?Q?eNwYOK7C5gqs8BD6u96SCmSqDfsC5W1dsXztdMRK7A2gZHYFUjBH6ZFdD85a?=
 =?us-ascii?Q?eGg23ZYkS0q2Yu3tR4vMGW5d0DBvVlJ1c3VcxSGZkobqaPkyI3yUhKdPTjVl?=
 =?us-ascii?Q?Wv5qrDNQgwcPD2BGo02g4ECbHJvnFqqhOSDwVEHJpcl5LuTnT4iTUgMul3L7?=
 =?us-ascii?Q?il8xtwfvl9BiDH7jC4uX7ZdGMMIyXfHvHl+5zj2jI8RL4YZT0ZEznKdKlvIr?=
 =?us-ascii?Q?9v7ye47+X12hpNJLH/83ViDiVZcH6I9m1raIwbvPwAipCGnYJAiQVsvLwvL4?=
 =?us-ascii?Q?72b5wqGX8y1MbHXP9SL56yrUBJfOh7JdEpWpbw6/qxZBG3CN5A7wiXjKPlf2?=
 =?us-ascii?Q?cMr+zJHuzy8WsKhSwbRZ4xuwlXG7+ypTnxA7Twyl4Wktz+HPjmrKu8E3NfBu?=
 =?us-ascii?Q?gnM+6xogx8NZbAv0LIKfwkGEjxaIetlWMvPZz6YWFksBvH4/EOYVrKdUeJK2?=
 =?us-ascii?Q?aZE2viFhR2xsCDWwz3Wtzks2e/1wnSIuCIRt+GJ9Fl5fFpKr9n1jsQ0MlNzi?=
 =?us-ascii?Q?62nSCw1z8ItCZ41VJdAM8Kh3HV9vqJZKkxhpb1v4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 974ec078-fae8-4223-9bce-08dde089d5d5
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 08:07:56.2344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: usX8ZK8fYqF1rxmI/11Ao2dUFc42YePKNYurfBThfGQLGuQZTdD9VzRdNvyK3+m+gQrXW6GTL3nmCidy0QQU5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6488

The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
Therefore, remove the useless call to dev_err_probe(), and just
return the value instead.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/iio/imu/bmi323/bmi323_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index fc54d464a3ae..6bcb9a436581 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -2112,8 +2112,7 @@ int bmi323_core_probe(struct device *dev)
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
-		return dev_err_probe(dev, -ENOMEM,
-				     "Failed to allocate device\n");
+		return -ENOMEM;
 
 	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
 					     regulator_names);
-- 
2.34.1


