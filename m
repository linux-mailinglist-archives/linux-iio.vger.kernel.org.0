Return-Path: <linux-iio+bounces-9778-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AA7986B76
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 05:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4271F22C47
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 03:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1264117335C;
	Thu, 26 Sep 2024 03:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="eodnH5eZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2063.outbound.protection.outlook.com [40.107.117.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D019E1F5F6;
	Thu, 26 Sep 2024 03:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727322293; cv=fail; b=cgargvW4cLzgZVHIGRpWoAr9b2hLCiH2A3ejmP8Aikk69o6UusAh+Bk6TuBrXTpeXXZqNbktxUqF7cD5HSIJ3waCZIRgcnCIjuc7CrZv0rfwxxQ0HEbE1sf3mLNxqWJEEzW4APtBHlUU5j5cD3t/0p6OlnAZ5+6PL80XaK7lkfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727322293; c=relaxed/simple;
	bh=J0DiG3dpZfQo3fKDZuHArHPkdoa367CTqPs+uKEveTY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=honbWVd61v11NuprdAeGdSG6rpBg0WEFqjfi76qQssmVCjyBXdvzya6V7OXHB+qd0kd3jARSn/v4a4YudPwYY8kcUmg/O4SmHOcfo5FW6ltTqMv5goYHz0XxhDqP485uIS6tlQ3EXOAC9GcbHg2Vmqvnb77wSVWnXy0Ze43Z/Yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=eodnH5eZ; arc=fail smtp.client-ip=40.107.117.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bh/egyHyrAfjXWtyK+OERjsI7acVK6y65RhLFToZzRXMeczPbskXmz4wbL9FM+28eqperQHMH4+fKAlzj+C7s7yTn0K4BWSNw/KKkY20eFH178EAxQLaYnHv+6OSsi+Avt3Rry2Bt51Jwwwe4rVBmzzWOhbHoEYnPhcFQhz7aQB3K9F/MXKS5C0nYHiYezX1PjJjilZNZ8jA7K5VPWoo8MYpDC7hSknMnk4hIPq77sX4Rl12En6B7E9LGCQWrlEOwiVALDZNrC9Ph6tW27WetoKTHbXhp60+NaAYu3hLsiLl3Rv8kNJ5YI1BsK+wT2HQqBTPDoz2NgOPLx54fvazyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFKRa80yJk9OHelGpGuoqf/NbZGbM0fFaZySFdiXlMs=;
 b=bawZiHpLMJe8M8Hsxa1HHNDizW5Oi7mb2VpAgO060UOSKckeyksmqEtzGbZz9qzZnuznifh+XSMuOgXo3PejLJu2mEtmXo1PRAsFcOF003Py8XLu5J48HKJuJ5BAeom7J+0Y9Ei4yzH2fwFbHGswyiOhAOSJChZDz00cxXXQw+ibtn0in4ZzeZeQwchXDwOYpzkNf5Dch4dppqZieLIeXknT4Xm9SHnyik532Lx0ZxGdSAEWXmTXwReHEsX7pVZrT8mHcBOVfH5oqhcOX6Mnz2nB3IR4Yqjd9DYn5k6jA2hnTmlUj0j7uME8gFtxwiBs/5x/LKRxlHTc6b5cZmUBrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFKRa80yJk9OHelGpGuoqf/NbZGbM0fFaZySFdiXlMs=;
 b=eodnH5eZq5hS1y+e9f7b6rc5l27iC2sKOOnbs3+1lnHYlvgHYVVR9TOSHCXjl8vsWgKpuyTcNb87VsK5Z/b53CKyvycLKHp5OBqZiSWTcaMGKxliHP6r8qYTBDKRqEGVY6MQXhFZCDrpwH6Ltngu/251Wcnz5a3va3PPXUO37geeF4Nfa/t3O1FUFf3xS4dKwx4tUV9hRA6cI5VpbxcmHdgSRhJ/5YLQTaJP8fC80WX0XLqKDIvDT6PO10n7DwPsiX+9romAgZFg7skyV8VKbeIGarH1F112qmI++Bx8Y9XWg1PfJfvVZXRlSRUMq8+Jp8OKqUGz2zOIwOxPHHJcpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by SEYPR06MB5693.apcprd06.prod.outlook.com (2603:1096:101:be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Thu, 26 Sep
 2024 03:44:44 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%5]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 03:44:44 +0000
From: Yu Jiaoliang <yujiaoliang@vivo.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	Ivan Mikhaylov <fr0st61te@gmail.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Nuno Sa <nuno.sa@analog.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Richard Leitner <richard.leitner@linux.dev>,
	Stephen Boyd <sboyd@kernel.org>,
	Wadim Egorov <w.egorov@phytec.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1] iio: adc: Fix typos in comments across various files
Date: Thu, 26 Sep 2024 11:43:54 +0800
Message-Id: <20240926034411.3482986-1-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0023.apcprd04.prod.outlook.com
 (2603:1096:404:15::35) To TYZPR06MB4461.apcprd06.prod.outlook.com
 (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|SEYPR06MB5693:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a61a54a-0c89-43a9-52f5-08dcdddd8f4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KfkTXUmr3tOUWafQzEo/LeaUgcWaJP+lZUk6hW367ElOyhAoGsHcdIJlyITB?=
 =?us-ascii?Q?/D3ml5Wj5CDKr8we20hjKSiUQifbwpv8AMRSjWzK51rFerBP4h1gkC8rxXvX?=
 =?us-ascii?Q?Ovdnox461+Zi/0fKLfZaRdK5pJjK+I1F7FFtt7bvLZdeJCqLXJGtiW2stnyz?=
 =?us-ascii?Q?HgKxRes09/8WRGR3HrEfolTGEOVJJkwz3PAvr54knvw9yVWG9JXEyN+2Q5Bi?=
 =?us-ascii?Q?THf0j9csM/Pk9p6C39q4etQzo4m2wvWj0loPOeeuTN3I+xnNXLJwcm/0AV3V?=
 =?us-ascii?Q?oQNdQe7T7K+UcyMCukoW4xNOfk2CxH+TUMJLlY3f1fOTrOIUkdvpuFCfYeN/?=
 =?us-ascii?Q?udo5RiX6JMjbTXWosD0G8XAEkt8cNif6MEdxsuP2G/mxosyiekoeYn/FlCbk?=
 =?us-ascii?Q?tdCTOkLsRXxF2OOWan/4BFsDZkLUQaJngxsqUoLKNQ+fmKj4opNXjmJdxJOR?=
 =?us-ascii?Q?4XNjWa3i1i103l46a2o3pha1rv/v5tquoJHEoTSozPwqRsz/sSW6rYPzDS7l?=
 =?us-ascii?Q?wAXOgMMnCBmksqBMzqIpqzmmbmb8lUpPW6xe47NxsKtJXl1Ia3g6Sgrt57CX?=
 =?us-ascii?Q?euU8DG7649ATpq/NdNFoJo1ADgSnJLEmwuzOhTVTbW3Ux4Vh2VF8N89txkd4?=
 =?us-ascii?Q?kceyOKRHnfnyB7p4lYQH9OKmjJc6xBRuzP07E+O7F5o2H/Dpp5qoCpOY9B6v?=
 =?us-ascii?Q?0ff9VwzXinXa8EElf3laSjsl7htDT0IQkKlbsgN+F6dbgwrKEP/rGsQYOcS3?=
 =?us-ascii?Q?KX4O2JEeMV2i8b8LbvZg1SoewhoAoXQBEdENKGn+5ajN+rQp1sbZ9zBnruFX?=
 =?us-ascii?Q?yYVwbtey75MjBdt6M9RTQTte2l8BlXa8IBOOVQv7rvR9YcHJoWlrGpO/MMW3?=
 =?us-ascii?Q?vuuHaRYuJGQHE7WDELSD6Ls/Ss0e+oKJe1NNcEcdjDdV56ri5WS6+TKtJo6C?=
 =?us-ascii?Q?QbmME50/RlB2MYKQxdrWdXPeeWOF6PkAPPrS3l8iocT/UWhQnBYFuxVIQtmT?=
 =?us-ascii?Q?DkFTfBNTScICViCBDCGm1S5HKkFWiRKmuoT/cuiMbFfQPCzTKUPf+j5v0gZt?=
 =?us-ascii?Q?XAkXpm9s9mlEjnV5PyS9HZ+cB0gkJWZD0VwH3zBbXnYMdIFzV15kJmEinw3r?=
 =?us-ascii?Q?ThWiXwCEsgTGnDFtYRD2di+IRlDK2Ab4HBq3yKQGB0nVH3pCVVUGfLFwxp3N?=
 =?us-ascii?Q?1Z2Oic81/fA9P0fyAfIX22fNodQWuE5cbUMddStfz2kixJO+kV3H4AyA/wsO?=
 =?us-ascii?Q?qCNvIOybETrJ2oqGxL/um98jCzoZUJ6TMTTNNWVMrSY+KZLJ8ae+yu/n0lz1?=
 =?us-ascii?Q?R2GiQY4LnIOdX7vmRfSvCroOlXFLDkJO0tCptkE/t/qMCHpYIYq1J1t/5tVq?=
 =?us-ascii?Q?92oPHvE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rD91u3gQUJtMYZyBzT2TPULXjg9LJblEdDrR3lGT71kEc4DTlShaJV34txuQ?=
 =?us-ascii?Q?TH9HyKgzJ+EkD/TSAUT55/zwMp2hYUKHsgwTGMt5xvMSbdQmPhmWj/H8D9mP?=
 =?us-ascii?Q?7YKkVCepuyOZLUz4RfOBl9W+3qn7p84Rf//Hm/e0ClvtZw8j46RIzVAlmtd4?=
 =?us-ascii?Q?YaVoLQxm16YVzd6LInBnGV0gROEht37pXb93ybAYu4krxGuQQE3ljbTaHV6y?=
 =?us-ascii?Q?hJvDsD5LwtNcRejdh9uIrQq/SEIhu4jhrUE9SjDY8qOKs6Y9cUrCXptXw7XE?=
 =?us-ascii?Q?JLJoOOtKhP1ZMHkQINOfDXnhhgDiga8wNzryoTyWTv72aiFDqlAQrXHZllcH?=
 =?us-ascii?Q?uUeFsqZHIm2D/L4SlpiavHbctUPUBi4qYZ3kWfi0prppcrOQml0V57l+0cGb?=
 =?us-ascii?Q?DXXXPccMCwCXpu8rj5dibB3HnymVxzx1b354U8A54B4cYJ1Js+xyvW2jDOoZ?=
 =?us-ascii?Q?3bJEMPvRLCMZBOmUAtbqbZsT5ISN+WhEsdkhIM0hMtRufdIl+tisHWLJYupj?=
 =?us-ascii?Q?K0iMXNQk70YlwtY9yAa+SfrNQin08BlJ9SFvzIzYBax2twNChfwnv/qBLJY1?=
 =?us-ascii?Q?AKGgm4xuUf9BXe1dWJVaQiPT8cj9zHhVZlg8PZ1wM9YKqHcRfLnd+ByCGoK7?=
 =?us-ascii?Q?j7P7UEiRyay8uhsqOGk1mpg/XvCGoXMCAqvmdoGAyYHxZnT1BTGrTg1428HO?=
 =?us-ascii?Q?tjSDk3Xe/bnyhQPrFngWXU+LBkUrKa5lifiCOlenaRPEiB/zm38xowy2MfpQ?=
 =?us-ascii?Q?9MfQNl/AJJgaT97eYGN27oHOtY2pRN0c6resj2gZMLdPmfUpN2GI9oxQaWnM?=
 =?us-ascii?Q?qc5upCloTsyJOB+pjwCWlNSw5CwYwspE72pmWioo5+NYFEv10YOXJFeV3B7n?=
 =?us-ascii?Q?UdDQx7BbkImKQBknoTgdddB2Jeulm1bk6iMxe3d5Kdxt7zVjINby65+s2wOi?=
 =?us-ascii?Q?akMvOmld6rJQ+KHWjzAX6gazWr2baax91TcbbU9POuQhLHzC9N77Q/7Fy/61?=
 =?us-ascii?Q?DMaP9eD7Gk1wlWKgah2McHBDbM2Wb+Vrr9rog0fHSMy5F+CvbYB8zKP5gruE?=
 =?us-ascii?Q?Np2q6EI/TKvt0PS4C0CJPjd/z6eU9PQqgU62LJIluw6zJbi4kTM8RzK5514M?=
 =?us-ascii?Q?Dft26kgdwjyZMLCbLvfXIvqn9biFRn69Mo5hhQsiCtrvfRopQ92gNoTL42g3?=
 =?us-ascii?Q?SUPg+2i1cszfqELxoZVWUJNZEgA6lqjXkKx+NkK1yLcXh//A1hBBOtFUmnQb?=
 =?us-ascii?Q?G4LyJlNlEceYC6vXPYla4ZG03QuGB2evXxVwJgmxflKDoFK4XUIlQ7FmX6RY?=
 =?us-ascii?Q?pUn8k1aGuMG+fWQyAl79VRwVUVdEqn04kUEnKrMCy3Aw/B/XuuIptaYVWHqW?=
 =?us-ascii?Q?gsAQR3GzpxNW3/jbZMmu8fdL1Ez/fBVfZoH8qfD7/7Qakns2ZDsMnOAMw5Wr?=
 =?us-ascii?Q?noEdzdNep8uodjFWiZ/yFtPATa0STzUIfBJZ4nGj//DEoMlyGdnQi5tDM2Rb?=
 =?us-ascii?Q?oymsemuIB1/AWQccDCd4kLVqVbZHrkWMoXtA9ZvhqfG9AXGKK6GW/dQHOWV0?=
 =?us-ascii?Q?OmWRxJKGXr0CEGHIoSreTz1WikEWOpXF9O3SHJLo?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a61a54a-0c89-43a9-52f5-08dcdddd8f4c
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 03:44:44.3118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PrZnQPwGOQbCSfknG8euIAYxfUXs7CfUo0VFBAC4ce0Q14kM+g2hHx6+pVZdRDz8JOwlo0oWY6VdrTZIyETvJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5693

This commit fixes several typographical errors in comments within
the drivers/iio/adc directory. No functional changes are made.

Detected using codespell.

Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
---
 drivers/iio/adc/ad7091r-base.h       | 2 +-
 drivers/iio/adc/ad7606.h             | 2 +-
 drivers/iio/adc/ad7887.c             | 2 +-
 drivers/iio/adc/ad_sigma_delta.c     | 4 ++--
 drivers/iio/adc/max34408.c           | 2 +-
 drivers/iio/adc/pac1921.c            | 2 +-
 drivers/iio/adc/palmas_gpadc.c       | 2 +-
 drivers/iio/adc/ti-ads1298.c         | 2 +-
 drivers/iio/adc/ti_am335x_adc.c      | 2 +-
 drivers/iio/adc/twl4030-madc.c       | 2 +-
 drivers/iio/adc/xilinx-xadc-events.c | 2 +-
 11 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
index 696bf7a897bb..092ddea0f395 100644
--- a/drivers/iio/adc/ad7091r-base.h
+++ b/drivers/iio/adc/ad7091r-base.h
@@ -65,7 +65,7 @@ struct ad7091r_state {
 	struct regulator *vref;
 	const struct ad7091r_chip_info *chip_info;
 	enum ad7091r_mode mode;
-	struct mutex lock; /*lock to prevent concurent reads */
+	struct mutex lock; /*lock to prevent concurrent reads */
 	__be16 tx_buf __aligned(IIO_DMA_MINALIGN);
 	__be16 rx_buf;
 };
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 6649e84d25de..02195bedb574 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -46,7 +46,7 @@
  *			oversampling ratios.
  * @oversampling_num	number of elements stored in oversampling_avail array
  * @os_req_reset	some devices require a reset to update oversampling
- * @init_delay_ms	required delay in miliseconds for initialization
+ * @init_delay_ms	required delay in milliseconds for initialization
  *			after a restart
  */
 struct ad7606_chip_info {
diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index b301da9b88b1..69add1dc4b53 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -41,7 +41,7 @@ enum ad7887_channels {
 };
 
 /**
- * struct ad7887_chip_info - chip specifc information
+ * struct ad7887_chip_info - chip specific information
  * @int_vref_mv:	the internal reference voltage
  * @channels:		channels specification
  * @num_channels:	number of channels
diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index e2bed2d648f2..e30c7f8fcbec 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -469,7 +469,7 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 		/*
 		 * Data array after transfer will look like (if status is appended):
 		 * data[] = { [0][sample][sample][sample][status] }
-		 * Keeping the first byte 0 shifts the status postion by 1 byte to the right.
+		 * Keeping the first byte 0 shifts the status position by 1 byte to the right.
 		 */
 		status_pos = reg_size + 1;
 
@@ -656,7 +656,7 @@ int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
 	sigma_delta->spi = spi;
 	sigma_delta->info = info;
 
-	/* If the field is unset in ad_sigma_delta_info, asume there can only be 1 slot. */
+	/* If the field is unset in ad_sigma_delta_info, assume there can only be 1 slot. */
 	if (!info->num_slots)
 		sigma_delta->num_slots = 1;
 	else
diff --git a/drivers/iio/adc/max34408.c b/drivers/iio/adc/max34408.c
index ffec22be2d59..971e6e5dee9b 100644
--- a/drivers/iio/adc/max34408.c
+++ b/drivers/iio/adc/max34408.c
@@ -161,7 +161,7 @@ static int max34408_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		/*
-		 * calcluate current for 8bit ADC with Rsense
+		 * calculate current for 8bit ADC with Rsense
 		 * value.
 		 * 10 mV * 1000 / Rsense uOhm = max current
 		 * (max current * adc val * 1000) / (2^8 - 1) mA
diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index 4c2a1c07bc39..c49175f2c0b7 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -1077,7 +1077,7 @@ static int pac1921_init(struct pac1921_priv *priv)
 	/*
 	 * Init control register:
 	 * - VPower free run integration mode
-	 * - OUT pin full scale range: 3V (HW detault)
+	 * - OUT pin full scale range: 3V (HW default)
 	 * - no timeout, no sleep, no sleep override, no recalc (HW defaults)
 	 */
 	val = FIELD_PREP(PAC1921_CONTROL_MXSL_MASK,
diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index 203cbbc70719..67d567ee21b4 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -456,7 +456,7 @@ static int palmas_gpadc_get_calibrated_code(struct palmas_gpadc *adc,
  *   raw high threshold = (ideal threshold + INL) * gain error + offset error
  *
  * The gain error include both gain error, as specified in the datasheet, and
- * the gain error drift. These paramenters vary depending on device and whether
+ * the gain error drift. These parameters vary depending on device and whether
  * the channel is calibrated (trimmed) or not.
  */
 static int palmas_gpadc_threshold_with_tolerance(int val, const int INL,
diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
index 13cb32125eef..a6432ef1fa90 100644
--- a/drivers/iio/adc/ti-ads1298.c
+++ b/drivers/iio/adc/ti-ads1298.c
@@ -294,7 +294,7 @@ static int ads1298_get_scale(struct ads1298_private *priv,
 		if (ret)
 			return ret;
 
-		/* Refererence in millivolts */
+		/* Reference in millivolts */
 		*val = regval & ADS1298_MASK_CONFIG3_VREF_4V ? 4000 : 2400;
 	}
 
diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 426e3c9f88a1..d362eba6cd7c 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -494,7 +494,7 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
 	/*
 	 * We check the complete FIFO. We programmed just one entry but in case
 	 * something went wrong we left empty handed (-EAGAIN previously) and
-	 * then the value apeared somehow in the FIFO we would have two entries.
+	 * then the value appeared somehow in the FIFO we would have two entries.
 	 * Therefore we read every item and keep only the latest version of the
 	 * requested channel.
 	 */
diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
index 0253064fadec..563478e9c5eb 100644
--- a/drivers/iio/adc/twl4030-madc.c
+++ b/drivers/iio/adc/twl4030-madc.c
@@ -248,7 +248,7 @@ static const struct s16_fract twl4030_divider_ratios[16] = {
 	{15, 100},	/* CHANNEL 11 */
 	{1, 4},		/* CHANNEL 12 */
 	{1, 1},		/* CHANNEL 13 Reserved channels */
-	{1, 1},		/* CHANNEL 14 Reseved channels */
+	{1, 1},		/* CHANNEL 14 Reserved channels */
 	{5, 11},	/* CHANNEL 15 */
 };
 
diff --git a/drivers/iio/adc/xilinx-xadc-events.c b/drivers/iio/adc/xilinx-xadc-events.c
index 1bd375fb10e0..90f62377c34d 100644
--- a/drivers/iio/adc/xilinx-xadc-events.c
+++ b/drivers/iio/adc/xilinx-xadc-events.c
@@ -220,7 +220,7 @@ int xadc_write_event_value(struct iio_dev *indio_dev,
 		/*
 		 * Since we store the hysteresis as relative (to the threshold)
 		 * value, but the hardware expects an absolute value we need to
-		 * recalcualte this value whenever the hysteresis or the
+		 * recalculate this value whenever the hysteresis or the
 		 * threshold changes.
 		 */
 		if (xadc->threshold[offset] < xadc->temp_hysteresis)
-- 
2.34.1


