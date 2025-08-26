Return-Path: <linux-iio+bounces-23298-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E3DB359F9
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 12:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB301B67006
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 10:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D3329D283;
	Tue, 26 Aug 2025 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="aXYwtoa7"
X-Original-To: linux-iio@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012043.outbound.protection.outlook.com [52.101.126.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79811EE7B9;
	Tue, 26 Aug 2025 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756203541; cv=fail; b=l9h5uOvsyBFQkPJM2oH79H8Os+JjMfzhbBw1zBnPE1zMAnCrRyy0lPy+y2DnFj7DlsCG0WVuvrYlupV225VL/BW/EUBm11xW738IGtADIyHi/PjldH6Z66kgc+e08JiL+IlQEfImaT8+2fRPGZ12RJ4DBI22TT5zz1h+9mBj6LU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756203541; c=relaxed/simple;
	bh=a5Y3GXPgjnlUJ3MGKc6+kl9y/zlWL1JIKdzpzIfojCs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UTbolvmrqoEHI7Be2Tldm29P2Jsu+i/8rpNXq8pfszKtIDj4k+AfzJxrogzeLVg3dBwX0lr4KVTvMBMfJyF8FJ7zGn1GVazaNvHum01cUPVLcrdGQd8X8BZ7yDuPsPCK5MxQOSory+yLCNEKaOlAp+Q9/qmR+sG5QqM3rWZogSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=aXYwtoa7; arc=fail smtp.client-ip=52.101.126.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7YnDl+8binYsNjgeFMv6h5dik2HWGIDt2z5VmS5TEmD7vnEDYWpeIPdFVUxLDnGWQbsD83HPudktJ0OnkJYHj0FyWoQ1Pep7lVi29Emz+d1rQhTNq5no+hZIDDDqJUEfaxN5ec3JLV7AbXKB/J4JUhqKb9T02aNd+AnX99HSVJNTvNAbukos0JulswBhoReNxizCxBk2WEsEmFnehhuN1FOqtal3/osXh/I3Whsbk6Te6falGYxo5gG2jzdGLfFC+OMoucmK7XnI6elqvvuTL9QUHOa85O8P4tdnelYtmTVrJoV6RGgHc1Nt1oghq355MkgqhKMBnjCPUyOpCqOyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZoeQ4qw+SiXTUKjzaoJMT8BVFhokQ1jc7flIg897HQw=;
 b=Q3y9L4Epp0VTkGKOGoLHpDCQk5Cl7IsENTv/srbptnhTdldeGT7kdayLUlI86oWcDn79om2XwIY4MI6eRmKYnyBMXtp2EGeuiZFzD/dUZ+Hh1wYq/IT0NAOQtrCvumssVtmmsAiEZ/2GrEFnuN3gdT5A7wuQNNlLdwanDKMlJR2Sqpi23LQKG7xVR46I7HhtX4Nrw9MbCHtROT/BnWXIGUacf1cPLb4ZQfyteJsrD9B5AZp5+cRZHVuSP8egfF9CjOyIxm3haC/fPi8YUbpZhi8S9OuN4fBjilDmvgPHZAWI5xrDImuF48lefFHFacTdYM2uj5jSyYAhw5QZ87f0cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoeQ4qw+SiXTUKjzaoJMT8BVFhokQ1jc7flIg897HQw=;
 b=aXYwtoa7kRxdTGS86Lv0uY6/r88LaZiOZw23aYRwbIkIjHT+coREjvFia7g7XXIFTtyBz6bP3/fMwxayZorGf9n3fPpeh1TsduinEjYf0xmXj2wPTCq+PRL07z/tekRlToYwn71hZTZHmm+mgId9/unCbYXKxXd4OYe438zKtkiU/WCMKtF2IRyhutufvaihemJxwhVGNqb0MDlWegJTvGX/NxkJjeIe0t1OJ5+4BJIiRYc87sYxa5+Cx293kE6oGD2+qMzv2swm2G8Hpa+3wyPgg9DkTzYvOJoXFra9xTnQ1O84Ncjj/oNqKoyfoy/DLkoGJ8yW5fQ3EN/j/O0Tiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 KL1PR06MB7036.apcprd06.prod.outlook.com (2603:1096:820:126::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.21; Tue, 26 Aug 2025 10:18:45 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 10:18:40 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] iio: dac: use int instead of u32 to store error codes
Date: Tue, 26 Aug 2025 18:18:25 +0800
Message-Id: <20250826101825.248167-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:404:56::22) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|KL1PR06MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: d96b4fff-dbf0-4baa-98e1-08dde489ed60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EfzQfzAVRFIiMgWtrmYiNMUYBDgDZA6Yeiw1OjaTDmNuedCk9J3zAW+JdLRs?=
 =?us-ascii?Q?U543WCcJuqVFDP+cqQaxVnwEX0L/tyE0HqYl8E6BymNf9/mh8M/6f2+9Pfi1?=
 =?us-ascii?Q?ideNlw/cyxUpbPnf7lwExiEokr9aNFOdHHo0/oSRoEyvsFgJavUW09JmTZmM?=
 =?us-ascii?Q?vWipRJBzYTN/8M5u3032tcjaYHVIzTmuZszzbA33++hybY6EpX3OO5uiaNTb?=
 =?us-ascii?Q?UkgmyHtOTis7G/KzYhOWc0ED34wB0KR2G69gJE98Q1IzQUik6MiH29sgV67C?=
 =?us-ascii?Q?7TIOgmEvQv4pAMOMqHpSBI6QXBGJftw3ZkFDIPC7FivhYYXRbRe7O1VJgAc/?=
 =?us-ascii?Q?fpB3/YcURqLu5t+M+hYtpcaY0eLTWZrB3vmwkjcvKc1mYWeZIiiwz3RkzPwb?=
 =?us-ascii?Q?Demm7UFOXBFOkt+jUk+YwrMwPyipTIxBAD6ByumvK0d2Thq7JJtTugs5pEbW?=
 =?us-ascii?Q?JlTpLVztw/HpKkIRcPBt4cBRu1CMXI3OTC1ARXLHse9PuRJBKiYEKCGxw9uO?=
 =?us-ascii?Q?LbqW8c5w6lt3ll+Lf8+jTbWBZ+LoeGqGS03/BaawzLHRRppPVT0a5Ue76LhZ?=
 =?us-ascii?Q?SkXVHH4clfiU8rcKVy2eBBJG4roXY+upZ5vq28JfE8BSc0IWggxjgCQYBfyY?=
 =?us-ascii?Q?jFbt0eX83VTuIe/DKPZB2SYL5LqJvoc3Gvf36F7ic9mP0Gbq6WCCC2WuPqA3?=
 =?us-ascii?Q?XGnBhOfG/Z5qf3lQBPxwbOdPQHMAZnY2Yc54MNdr4HchtwEK4BZbc2s9+SIJ?=
 =?us-ascii?Q?750t9xX8wsm/69a7J49BP1fGvranwA7cLR5sYrcod/rv8sM6ay3LKSkwad5c?=
 =?us-ascii?Q?DtZ9vHgkc4gJ00xYOTNCECNlzKNm9LS4pfC9RD4680Zq64njxQyk9Yk9t7UX?=
 =?us-ascii?Q?cNA7RUWWMgvQxkH2Ic3TVO2SxkdHnbSjymmExCZJlSd7UD3/M8zp7nW8Jn8U?=
 =?us-ascii?Q?cyVysmlkj36XYFofUy790yTJpI8lt+RPg5dmLMvlYIN3hB7t4y21F8XIm0kL?=
 =?us-ascii?Q?Yb2n/dF7VzEKuSPSWVEDse45zNWEChQ8HSMlrJI1VAR9SXlDFaARC2AD3U0j?=
 =?us-ascii?Q?YyC5ekX6LHJlCjMB/Ps4fKzsdZaxAblpX+EU14+FYA02dNIApXqj22gZABnL?=
 =?us-ascii?Q?fXU3O1phLtlXx26p0OL6ySgAwWRJnIOp11Fq8R5+JH10yMxx3RXIx7rbXdOc?=
 =?us-ascii?Q?5hAnYsRFfT2cVo+XZAXeVUdYJVUwASb/sLZvIw67A3wCf64WRidTE9pP5+Hl?=
 =?us-ascii?Q?22YLFMSBXIyfVej7l6TG0UfmintoKM6tf+EfvNBOseESrST3qbS9wor7zoPC?=
 =?us-ascii?Q?CnGFq3Zus62ESQIkv2TUBMUfClTnZDKQOwbzMNX87KmeHRjiw87DD7TyS8pA?=
 =?us-ascii?Q?LRfi+nuBUK9l9QFHj/gsEihZS6X2axnASeeQAt34tZGOV8eNe3VC46AZpWgK?=
 =?us-ascii?Q?vPV5r2PKRrLjEJdfBf1rLnBooZor7+KWkaSlPlAswk50lzSZJ2fM8g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hAwM2a2nIf6yV3ITsuGEOc6P+cGFQnzk+uVw6OcuDwF9wRODY/CGrbXqp5fh?=
 =?us-ascii?Q?25qd5T38RpFCruc/J7KMyOQAmTDR3dX06lKyQWDIo0ut79mpU15Cci6YKT9E?=
 =?us-ascii?Q?VY7kDgV/ogNWNx/mEiZ9mgcDK4gaFyABVYDUFEOOXJPBirhVQ4PulyHN6j7R?=
 =?us-ascii?Q?PzID66FjytbmLHeKIO8/60e8WF7GytUQWpNtEEee1pebURL4M8ZOoaDXDxQe?=
 =?us-ascii?Q?JnRtrZkd3ELdbb/67VevgWPQ05BpXpbTWoOCnZldd8GFn1AVF5M68esGnh6U?=
 =?us-ascii?Q?jyNFkHfgsa0UANJPgoy53BqQqVc1AW6jxo/y2G9nBr0lhTR64NWBYPHQfmHA?=
 =?us-ascii?Q?nkAhJAroeLBOpdPsNjvM+yh76rhpgZBp4UYPLtuzQTZ6A+krqSPo2p7qOvSS?=
 =?us-ascii?Q?aJyiutpZbxt1KYm6Z+mJ2+Zbkt2EgvlwNoA2dWBF+Fr5CpKCc0uT9RUub0L+?=
 =?us-ascii?Q?u5J414Tu4vXLVsfCmYol36mQAr+Jy92zbpiOzYeQwqYZ/Pg+Lz0rBbLWB/s1?=
 =?us-ascii?Q?aYOiRiaM1+hC6+MgrSDIwo/hA10wrF4FtSTVV3+fXr9eDahD+Zdf0arZ998C?=
 =?us-ascii?Q?d6LUB1EiofO3W9PfdnbcBBlYKje0snEEVtsrbTRI6B8MbLF1xdi0BWLg9Gva?=
 =?us-ascii?Q?+s7JgH4Cr9xSd0MdCLtF0GLhRujm7KBClv/lNOSfLAF1tQXhXctaIAueymU1?=
 =?us-ascii?Q?T+yF1/Eq3u6nXWyYnzlNO/ZXO44jGcizcNy+3JNfxCy8m1mJkqPbvky8PWqe?=
 =?us-ascii?Q?tajTgFh8l8nCBW+yo5G9+62H49TlQU5FVdyR/xCejH92/Iaz3adEI2s0AcmE?=
 =?us-ascii?Q?X+/dGc00EbPTm++RvYMpGkLqGziKmGjzdMy7ivMjbQibtrBHhAr808Rcr21C?=
 =?us-ascii?Q?11WBYRhZLK04dPblgVdkdyZXFygGAYT/hP6btawBFMbvmB7l0/4fRBOb3xvL?=
 =?us-ascii?Q?vja41BhLm96KwZEDA35w2IDXd4FerV16xXNJt/EjCfUN+rPB3kO/gru9Yr7f?=
 =?us-ascii?Q?QdtRCDSSN+Wfc6pCiRyGeA/zgDkBAkZVqqYaRVw0faG19/tVBwuTWhqrsQD2?=
 =?us-ascii?Q?IG0V0GSyFOfjbEDRYJjIipiESmwPwfupf2GStPsrN0wHqakvAN790rO1JqDR?=
 =?us-ascii?Q?ysBAxqG/JQS/53gJO5Bjypu4LJVcPg3CISvVkNxHrhzEP3a488Vhjn1Fspzv?=
 =?us-ascii?Q?OXPntmH6uE3A0Ehx/+Bmc1naCP67fTZQUnDqT2F6w3z7O8EP5ICoz9iBkbR/?=
 =?us-ascii?Q?6bxwYnp9oLbLXv3OjXFww14MKbAm54l3XGqYifcvc9NGw3QO/QAQytbR3pZr?=
 =?us-ascii?Q?woFNMv86vaD95/gxjq57E4v3IEzQ/8xKmxM7w7uVQAF0DnGa0z3qe8Wi0Wbx?=
 =?us-ascii?Q?g2Ba5uJLV2Ri4Nz6lxqKmFHXwxb56IfT8ZoU/rRTP65eP8vq/h+veZ6m41gf?=
 =?us-ascii?Q?/0l8FXtsxgVRX1tvYqr5Rcac7liYyuaIdurS1C4S+v2JIC946/vk3D/YCX8M?=
 =?us-ascii?Q?iTnV2MLY1raCokcX0mFhho/5/Z/fp5RVCEu1bVyeQfIwWVPkUxqPk+KOuh/M?=
 =?us-ascii?Q?WAl5FA1nJaF9UKFhIFCsmyDUmlQuVSE6Kka7e8uq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d96b4fff-dbf0-4baa-98e1-08dde489ed60
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 10:18:40.3522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKKLHKHHIjpeXDHZRwTWtTtQA8MffPJQi35eUb87ADDKj6feQDvRlaFyuEHgUj8wA2A+L2zv6o1958LYe+GSog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7036

Use int instead of unsigned int for 'ret' variable to store negative error
codes returned by ad5421_write_unlocked() and ad5360_write_unlocked().

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/iio/dac/ad5360.c | 2 +-
 drivers/iio/dac/ad5421.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
index a57b0a093112..8271849b1c83 100644
--- a/drivers/iio/dac/ad5360.c
+++ b/drivers/iio/dac/ad5360.c
@@ -262,7 +262,7 @@ static int ad5360_update_ctrl(struct iio_dev *indio_dev, unsigned int set,
 	unsigned int clr)
 {
 	struct ad5360_state *st = iio_priv(indio_dev);
-	unsigned int ret;
+	int ret;
 
 	mutex_lock(&st->lock);
 
diff --git a/drivers/iio/dac/ad5421.c b/drivers/iio/dac/ad5421.c
index 1462ee640b16..d9d7031c4432 100644
--- a/drivers/iio/dac/ad5421.c
+++ b/drivers/iio/dac/ad5421.c
@@ -186,7 +186,7 @@ static int ad5421_update_ctrl(struct iio_dev *indio_dev, unsigned int set,
 	unsigned int clr)
 {
 	struct ad5421_state *st = iio_priv(indio_dev);
-	unsigned int ret;
+	int ret;
 
 	mutex_lock(&st->lock);
 
-- 
2.34.1


