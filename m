Return-Path: <linux-iio+bounces-23083-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 328D7B2F09C
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 10:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75DFF17FEA6
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 08:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED022EA15C;
	Thu, 21 Aug 2025 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="oUY+MIrg"
X-Original-To: linux-iio@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013062.outbound.protection.outlook.com [52.101.127.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249392E9ECA;
	Thu, 21 Aug 2025 08:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763668; cv=fail; b=U0exy+S8egdISVeDTqFkfi1yGq2a1U5I5Q4CegMeqPCEWGSNxIY0wAOnjViA0Po1YYR0csOKh0kLzjMuuTYGr+3PDAn3YUUmAT00nUOcMWdlaOuIRaIHhSmFiRpViMiXxKxE4q30mdiXemu7nVXbP9y7hpg7yNoACPFjYTKKnnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763668; c=relaxed/simple;
	bh=AME2ULvYx6tfjMILotGD23/EBuill8Rull4weqrno/0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AMKdH76aJxq5pY4Vyz3Hm75WL0eqNZKw0W+q8ORwSSfss19Gv7AnYY7tRZSgbDIgLPqzKVOxzVz5lBmbEgH7BY57DN+5C016nwdG6JslJ/deioGzc5ZthszcCuQjzddO0EPQLbL03i1SsLjSno1RrAkdPplp1uSxMzVEnEYeP18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=oUY+MIrg; arc=fail smtp.client-ip=52.101.127.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rkve4nL0FtjDJ/KNy+j9nlO1TQcIwFWnpaYEo9dVxw4+0TOaHx2ifhp8t9EJoxlQGt2g+d1akpJ82Lche6JAFGJEP0YKuTLee9wMVP/4BJqst03SetupmtDjPqnOCHTCPYnPV/clMRKw7I8GhDtX4q7uAKdz788qxcC2XArbVhOfoRgZb6PYxBllIT/LbndU88I/LJmDReOyLzxII5R6NU0eRJdX/ei+MjlLDkHel1yv9Lpnt9JNQvFaBpLTxv81lNIhIYb9/HhfolA1EZCLbMGyXbN4CLXazHbcwfjP0mUogFxwNqZ2zzWAuE3B4/F2Nafdx9tjy7f+4OTF8qHc1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldgrJYM3d/WE9ITrVqkXzK0iI6PDUH1iatn9PGO8npc=;
 b=sCx93h7xkp8wEmJo5pPxOlXmYBflGxoCqpHn+S/DwF6DxaW74ItwGeWLsJNOnuSMRNceUcXjkGNnubZVq6ZJeAPE3yfB06oZiRw3wvCkRBq/eQHGlHqpDEU8ao1l9AVw8lzKQ7wrCu8orRGlHfs4PTvo0jN9TQ4R/yT779IDOappiKmusNWwVyCpts2AUJ4NFbKWNXgGCNTk+1oa4Z4ZC7cw5a+ZJUiyv7zFBMOPj8lBzgFpGo7zXE5CDnzY+Lr055vCjNoEtJA13/Df4KO8jxdH2WMu3FKmlpze6fofPHFEGIPy5kVFiTRPIVVNCtU2openMzVI/oKK3a+bLIue8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldgrJYM3d/WE9ITrVqkXzK0iI6PDUH1iatn9PGO8npc=;
 b=oUY+MIrgUyLLEMiXms4yqxfgDIAfFS4IAgFuEb3Q+lUr07/BoMqTVz0oUkmzYqvz7sanAdJIrL9/G09p1JdHz+VU2MMw3uKvtOxJrlCKHWeYnJwghdF7uGoriITyUq6cCECtZFXaDr9Tv4sOsePcZzAyoR/DVlbhDxi5jHTpbBMk7G14VayCfRsd2Yh4Wb6Vw01ioN8Q+xOTz6i7z9OnVAyXQUfeFxe+/DCYOa+rYaXa8UXPreVUnDNA4vmUUSSjJZfZ180P/oSNSNSz77jk3tCqRynlvE6+UHSeln/S/tqA7HQ+5fG9X1tsEgjWlaLWboBhQIAO8574StizkZDV9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by SEZPR06MB6598.apcprd06.prod.outlook.com (2603:1096:101:187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 08:07:42 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9052.012; Thu, 21 Aug 2025
 08:07:42 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Xichao Zhao <zhao.xichao@vivo.com>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/7] iio: accel: msa311: Remove dev_err_probe() if error is -ENOMEM
Date: Thu, 21 Aug 2025 16:06:45 +0800
Message-Id: <20250821080723.525379-2-zhao.xichao@vivo.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|SEZPR06MB6598:EE_
X-MS-Office365-Filtering-Correlation-Id: 08929906-428b-4847-bdba-08dde089cdce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M5hfSjiGd5OjKzVKEUvpT0Ua7MS8iCiAstcBT2pAp+jg8FDs20wfj7BVbX2o?=
 =?us-ascii?Q?9wK9nnIpo8iXYrNbL2ycg+XqbMZSJP+zLiOd6Wu1krxWmjtDg0ClBqhLqstu?=
 =?us-ascii?Q?N9Gzmt3uW6yRkyWbuWDNGTVSz1oNX0iSOvI+QD0mIHVam4GpvzxUnUriUUAV?=
 =?us-ascii?Q?OqGDM/Aqt5EPWYiQLoPZWe/GUKsaGCbmDZrns+cpSajOgoDGnXy0gQnqo+lQ?=
 =?us-ascii?Q?PXXgfxI9AyO145mE8i/EgtAeT27LwNSHZVnOecu45A/DsYcPY4OUZGGax+SP?=
 =?us-ascii?Q?bziuiYdNAo/i9lnPinVYFvaWCiaCdcmwURFcCo/hezqs1z0WEf3kVq95htgV?=
 =?us-ascii?Q?OPtZsS4+LZlpunhhw8I8SqOuS6o78Iz8p+OzpndzrNs+hbRT19XyLVOyfEnZ?=
 =?us-ascii?Q?guHv+Ghdm/q0SElg/5SnkMYO9PP5I/WvJ2OwpgzFHXmLpGBby0ybg1fYOjiW?=
 =?us-ascii?Q?MMLeNkmm476LvU/SgRYjGbg7wf+6yyw56eMaJf/+Pf9xLTZt6e0HUNfV005m?=
 =?us-ascii?Q?F5OySFrdRU6eq/JSw9GWgiC5/1JMvsDPAz8f+NW/sOFE/vvIYXytnmclp8dh?=
 =?us-ascii?Q?ynM7agHk400FfW5d4guUXAYivojZAITdnQNTr+ip/hbs8M+QxvZRVOltRY89?=
 =?us-ascii?Q?dtX50Qr/49rJIvNVSQaCbfN2VCjlaml4BKAES8fkqZ+Z+Xo+YVgC8wkPsNnO?=
 =?us-ascii?Q?gFxYykivhBCNMx1KWXNxglG9o+hi+e7laVeaVhU3JavUTLxeO0beXNsWBXoP?=
 =?us-ascii?Q?Q9/llcQCKVZO+QCKvNre9ccFedVsrn3mmxiod01nn0yGjeirq5hAU0mvnzed?=
 =?us-ascii?Q?+pBBIJ4FbNxvzJjvJJIEtVUtwXZ1/8mWCv8KIfNcarWPrPHwXUDG3eY4cCWL?=
 =?us-ascii?Q?4YcavwkJ5ljNM5Ncf152B0GucEySpPfdODuXSvckt0XYf4MP++sOfA4qG1cq?=
 =?us-ascii?Q?ZuX48Xp+ttOCvLNlzFCN3TBQDvNKHEzvFLqWRdB94YRZ16tSd7I7jc7grHwy?=
 =?us-ascii?Q?FLTsmk1R+SD9rKiHlLQ4giY8lgXBnpL35aEEai0JNJKERQb5ha35tkCnSn9n?=
 =?us-ascii?Q?UPGiUIMbAOpaRShMTNHFl4Fk06z+0fsRC6oAWKR/5U3IUiMyzG1MehfFQPRi?=
 =?us-ascii?Q?it5rosnQz8lAGCpBvWMfJnZg+XzeC2ThP4ElkG1iyLzbSjbdm6XJAgaGHbm7?=
 =?us-ascii?Q?mvzsyqoxTQbZmHr+0pEfKWOXkAtuHP0+1vFjkf0BuGk66qYTiZfHRSxLO3u6?=
 =?us-ascii?Q?eElO7iyP2jm1m9qYkNXXDwjglnBVRwTjciGBtB8gLt8AjFWGO8/ZdRADyk9m?=
 =?us-ascii?Q?EBhGAybwYVpK6ClknkMlBc6T2JbdOLRacQvg9c7WKoc3ZNSgy8vUxIyBL4S6?=
 =?us-ascii?Q?jHBx6J3qzXNyfjxMrXZFdPKqFLhmFa23K4zFwhRSre9kNlw0x35EpSf+pKCf?=
 =?us-ascii?Q?1/rkJnBtMy071IU7BOGTgKXpvYJ1m03dptnuTKBnZ77vgb+0kukSTQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jgEgPBdPKWLkisNY3M+21rK7IGQSV4ZLZbs/zBd8mh7HnbddHhCxSvThz7Fw?=
 =?us-ascii?Q?UtMJrXjENaBGGF+O6RjP8jvfa/mWyRda1gpaG/Fxe2l7SaQFJW/3/Gm8rEJe?=
 =?us-ascii?Q?dhbORIu/AkHmyGE2y9UESw0HZQuKobY2e+NXCfawW3qUv7VXTaSWi7W3ErTV?=
 =?us-ascii?Q?BpVQsORazFYf1f10VEukyNPDjCEoqnbRXij4aUaWUgKlpHQKy9cifDhnfLR6?=
 =?us-ascii?Q?L/7lPI1QyiJ/s2ewoX+PiplMsPd5JY41rMelJRlArl6ZRKtwi/1m5Y5RUYo3?=
 =?us-ascii?Q?fCc7HnhwQrbBtc6PhCa3KcR0mrniI0pZzXRqameH+sxH7SriM5U0GJZb8tMt?=
 =?us-ascii?Q?oE9oNW9I33jA/OmjnVzgGkvmziaK0ah8THP6YORrBo4Ogn8/fZkrNFwFLbaI?=
 =?us-ascii?Q?ZF6pBhhDubMSsCiydbzsCSY3F1s1z7sVM1BxLevzx9MocCdxfpkhQD3opB6H?=
 =?us-ascii?Q?ioTZnfia3XOO6ytYO9o8LctEfHIvBJydcJkykxtH0UnZaTpuoZoBQNhKmMKC?=
 =?us-ascii?Q?764RhOUyJo+0KeyC/Q9QNX/ctEGSbMwAaPb+BVm5DWVpm7nRo3UDatLLXHeB?=
 =?us-ascii?Q?gjdc+EDTheVUH7Av9/jTRmUO6UcDOVOrRB2apwbLGfeur2yECn9WTYVyJ5u9?=
 =?us-ascii?Q?UVmBTNhvMGLfgAKCI8NSiMBYn6US3ti67SrcuhNxtTNQ42Kte4fIcb6Q9LkH?=
 =?us-ascii?Q?MdJcPd28mI4xxssBnOqi3IJ3Hfkg++uGqQQQLGrIX6Oozh2Enxhbf9xNiGdj?=
 =?us-ascii?Q?3vxoKPo5mmTNUQYngdyAVB1gguXAqoyXewnjFg/B0ZPezPx98S0F62Yz8NOc?=
 =?us-ascii?Q?ybXCNZzczT3xbgKQ0tdwa52vY1JmJVNja2Mi96UvZH/JN44ODg5pk/MIilWn?=
 =?us-ascii?Q?d5VaH3H67aunNxye+MQkprrIimU8H/eSAKcu3OiKWzm805WnCCUOUwHN6Ffw?=
 =?us-ascii?Q?x8lAfAarypnxhKXEadxoAhe7RU329h/JeDO2GIPI4wt8ru4V4Rb8iaIJwD6i?=
 =?us-ascii?Q?SAQ+F4Dy3QppxxzdH2WbdM2F897DiMG0QDYSA8uFc0gttszn8QmB00SNqwx3?=
 =?us-ascii?Q?XPnLfH5+IvM/wmv1/p7rjKzLP0M3UGCCuu/r0KI/+7ua040l40k/ADJhppDo?=
 =?us-ascii?Q?4hVO2R3vaCX0bvt3OM03XGAUygaT3ArC1xtT5/YeVF4Zuxj4tNPUzZ9a7hsH?=
 =?us-ascii?Q?mUn2SJb/mGAlx5fg/YMAphrIsruGX6Rma2ky0CI6akS7eqyeaY8FyuD6+5XU?=
 =?us-ascii?Q?yfcVA3p5FT2oYI1DEyF/K7lifnlt0b19qUAZOdXzRvsoJ3l0nh/5q3YMxuYM?=
 =?us-ascii?Q?ohjjO0pgMkwSatZ+ASzsQleqGXc3+2RkY6vOtXpOSYO+cN//8lNH+1TEw7wm?=
 =?us-ascii?Q?lNgr2lZknvRKaElMbRgYk6HCNU16nQeAD9LI935eHecvL2XkKued5sp1oEQJ?=
 =?us-ascii?Q?zMeAXR13o0i0yDp4WGKh62e2nOgJJTgQxNfvi83535ZAOtaQ1IFcBToTQeBn?=
 =?us-ascii?Q?HfY4S9gSYAcW7N9M6p8xdLBdxH0p+cJp4qD/iEGHCixipfG2G+mj/coAIUHL?=
 =?us-ascii?Q?n5RsZdnKBaHZVOn4HPk8eRitw2GHN6GxnWWydNf/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08929906-428b-4847-bdba-08dde089cdce
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 08:07:42.6032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9cgQltucDtMH2xwFzyIFC37o6cXydMKbdVMKQPRvgDyqUNAAaeOIqpRGysj8Lb3cJ4jaRVeAXUcSN8B6vliog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6598

The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
Therefore, remove the useless call to dev_err_probe(), and just
return the value instead.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/iio/accel/msa311.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
index 3e10225410e8..32277b5822c4 100644
--- a/drivers/iio/accel/msa311.c
+++ b/drivers/iio/accel/msa311.c
@@ -990,7 +990,7 @@ static int msa311_check_partid(struct msa311_priv *msa311)
 	msa311->chip_name = devm_kasprintf(dev, GFP_KERNEL,
 					   "msa311-%02x", partid);
 	if (!msa311->chip_name)
-		return dev_err_probe(dev, -ENOMEM, "can't alloc chip name\n");
+		return -ENOMEM;
 
 	return 0;
 }
@@ -1069,8 +1069,7 @@ static int msa311_setup_interrupts(struct msa311_priv *msa311)
 
 	trig = devm_iio_trigger_alloc(dev, "%s-new-data", msa311->chip_name);
 	if (!trig)
-		return dev_err_probe(dev, -ENOMEM,
-				     "can't allocate newdata trigger\n");
+		return -ENOMEM;
 
 	msa311->new_data_trig = trig;
 	msa311->new_data_trig->ops = &msa311_new_data_trig_ops;
@@ -1153,8 +1152,7 @@ static int msa311_probe(struct i2c_client *i2c)
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*msa311));
 	if (!indio_dev)
-		return dev_err_probe(dev, -ENOMEM,
-				     "IIO device allocation failed\n");
+		return -ENOMEM;
 
 	msa311 = iio_priv(indio_dev);
 	msa311->dev = dev;
-- 
2.34.1


