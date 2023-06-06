Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CCA7248E4
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jun 2023 18:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjFFQWp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Jun 2023 12:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjFFQWn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Jun 2023 12:22:43 -0400
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D29E60
        for <linux-iio@vger.kernel.org>; Tue,  6 Jun 2023 09:22:41 -0700 (PDT)
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3568m9s6005040;
        Tue, 6 Jun 2023 16:22:20 GMT
Received: from jpn01-os0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2111.outbound.protection.outlook.com [104.47.23.111])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3qyxvgj55s-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 16:22:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fovD/I4KhYnmSz/s/9H8fsikofMGBFEVx+RZqkvzo1l7U8NnxvmN/O3WSidYySd0ksR9J/6LqkNS96AsMvOJmZqKdNkmYb49INDyXt3o2GrQt+LqD+CLbjFRyY8g42Uv1R+gCUSCN++0kc7a08QhJhO1u39AMnv+Bn2hlEBmRheIFFNoGCekJDYx94a8ZaviV8IcsQ+oKZvyfWdCIAPLPTXPrHKr821/cp4eG7TxfrfnEAXzkGM+rNEXR7apl3O17HFgipOw/ngMlCtniicMGqRANKvpAWVIRbw70WHRO3uBoHJ3Qp/jTNAqH1p9BG897kAvNOq1ZZkyWATTUKguJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0/EgbE5etH7aZ6HkrXSYltUVpmY4rdEkYxLhXvCuJw=;
 b=RF6FkDi1MEygn1kdLWEphnJtYTrvHpD4AI+XGsZbRBchZqw4Nz93hI7W2HV/IZRp/YesQdeyoVnDObZzzIGp0wVHGHIy2DZ9EWJi52BID+VUkUc9KwAqqv40aGdAPM4pAqbzpvj1kIsENsmaX5ngSFt2HqSfalMcGXm2cGqAb8O0NKUFXXUbAvlFmPmMh1BzI3dffDlVD59sO7ij4AVRdbdYKSxlYIaukNghr7+uGoysfwvOnTux4YHgabsddMMyXdNAHujDDT6GYyyXMoPQOGt1ehNZNGTMfFr3F2UbzzgT9U3XgjrG4IjrIA6Csn46O2qtXbPf3J+y+4fpu699tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0/EgbE5etH7aZ6HkrXSYltUVpmY4rdEkYxLhXvCuJw=;
 b=bAcjbylQ1GEQFFw+bF1mPjXNmu+aI2SnBlnKgR9I4HFy0msVvq1/UZPp79H/WkPOVqrd/Rtm8l6ZAje6DPTFH7DQ+oXrSSrdKWIV6seIlINkoP0KnYy1CBnsegD6dqi2wG70exYQtJN5jUJZ4KAMLkahhyJ+XIsOgZNkuNXcuo9Lu1WDLo5oe80poCHJfzT7Y8rhk2lsg9p4o8gEK6WpVZeXKK/jKYMchrMty86EqTd3uuDHW4cihqP3/r83pDvmfmA+LfGBOtgEXe/xk9Y+N2uqvztAMXkEe8b6vMRzbZUhoqBYcUSq+pAAcrtFpJMtsjZsSjCa1kglKsVeEnxqAA==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYCP286MB2179.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Tue, 6 Jun
 2023 16:22:16 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::60df:b013:2731:f9c1]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::60df:b013:2731:f9c1%7]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 16:22:16 +0000
From:   inv.git-commit@tdk.com
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     lars@metafoo.de,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v2 1/4] iio: imu: inv_icm42600: make timestamp module chip independent
Date:   Tue,  6 Jun 2023 16:21:44 +0000
Message-Id: <20230606162147.79667-2-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230606162147.79667-1-inv.git-commit@tdk.com>
References: <20230606162147.79667-1-inv.git-commit@tdk.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0212.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::32) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYCP286MB2179:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f55f20b-dbfc-4e62-535c-08db66aa2d6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DV3c3aXrqUaxFjGgFxwpUgMEw3js9jppaGBPmHFYsTa+sg1CHrFyzRzrtUIXAmObXw2JpnGZSESvYClBg6Z0/IPqhNL1m+XSvQfRe1mzp2fQDwerziBf0sDrtvw/XFOPxaDfKl9gnVx1xDoX+OJJrFoZPsPxLMnaoDrUH/dT2Dx9YmA5nT2xJLFO4N9ZOHuAaNYPT6pF2keCkjWT9oGABmqXydov/7czjI+IokQzOc5BQQlAUZ+jl5l1hNLeZSUsamO98jykvr6WoDPsa4gQ1qlux7+7JXteltKjYESkHmqap5c8KV1r8YflZ+fNwLmNXQZdxADjFacDKTPPuP+kjDL+jolYTmK/Vds0Q7wQq95KVjiat61ZZV3Nq4rvUtW8mbN5cWqb1YdNLMlHxJ5puPfddLLyb5D1AZTO5YjzgKaL31BOazC5j6Zjq8ZgpnzHnYJvp2q68pOb7r6yvfcC3Vci3LZzEbRTNtnfO0j0YMa0TXW5Z0N9YkELSM3ue2hJ0q3DnIjMO57nLj8GmbaFD+ZFIS9IMIO8jQQ/daEb+Y31A2odYHcBIKsXu+MQ60lNpd8JwhBpwgHuYzrEak7RQ1YqPypelpqDmamJRNqjtCbaow6Y2kGYfXjeQaP6CMQF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199021)(36756003)(478600001)(5660300002)(6666004)(8936002)(8676002)(316002)(4326008)(66476007)(66556008)(66946007)(41300700001)(38350700002)(38100700002)(2906002)(1076003)(26005)(6506007)(6512007)(9686003)(86362001)(186003)(2616005)(83380400001)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CSVwCrXyK+JkTwWXn/0eI5bS0aNuPuKWWxK+A6eEytUTnYsJtMKI6Rqczbuu?=
 =?us-ascii?Q?i0x1ezDeYomflu4T5zdS6+UpMwo/tjQTEI1Wz+L/0DV2riPNC+9Q0Vaq1ltr?=
 =?us-ascii?Q?2oBEnrf8KtIoYvLVule42NXB3fYMB1o/HIn6w747LrJJxRMkrqlKHO8V45tT?=
 =?us-ascii?Q?UTXzvYf5UMhsHkwcpzQZ+rhtnGkPFCcoa+d4OXAZsnWWklHpsFnNn22Y4YrQ?=
 =?us-ascii?Q?03wejUPSpjx4D+BWGOY69iw2hMA75OfzuRY4ejWVHAfJHZD59WA+P1ImMAt5?=
 =?us-ascii?Q?hlYhibKTzI8SFjFEIdFNhKyaJu2vxJfNcvaYJ2W0EDgTGV88vwuKM06zomNq?=
 =?us-ascii?Q?r3k9UxQcxyJSvbq8QDDSmiQYlsfOnYXROkVeModMWGzFdI6i3v+rwq91cjAN?=
 =?us-ascii?Q?LIfPO2SeKT+KgJVj7jg8pK/FA2uXZ01fqeKZJ7UWJ4SdlcqCgtcKUFIbjHh+?=
 =?us-ascii?Q?4x9amdubXdwDZeGIYtCqsCq5wUzziTPsY+VyK2HPA4NAIAe3UGenmb1iVFsM?=
 =?us-ascii?Q?SYZQoOkEHn7Jq+nA3X23TvTuqcTXWwxORmbyXHsKrBecov8IizeAfOJjuPt6?=
 =?us-ascii?Q?7yav36+K8fqpl89f296x3oUZR7MieJy6q0cw1ZyVkWmFdl05SRMYYlhjrDnX?=
 =?us-ascii?Q?Wei7taPiDapqDPhxqpJPWSOGOdIhYENaOm/C27FvnpaFe1Se7qmkvlpVL9fV?=
 =?us-ascii?Q?g4Ga2nv26kRrEU5N26HD0VVjV0DfKRXffyV6lUpMobUvEM/kDJVtpHRYtma9?=
 =?us-ascii?Q?vwE6H7dRTenWAyBmq92R8qyLASRTrgvqjOODSwnOXwgcjKco/sw0DvFzhOrh?=
 =?us-ascii?Q?wsTG/lnP2IiGPkvIdjIYGxdnUl7w00tjY3BjhIywqnX62wYHdLxoQeIu0tq7?=
 =?us-ascii?Q?KwF/WRHNWVCic+eXOYa7JoVqH7pFfZEe84ItIf6IuP40I+kNy93IAhkaKZpK?=
 =?us-ascii?Q?MwXc/3lQg7kDFqLCj/ZHLOfElS2g+gkJKWbxVCzkOTPMYjYEgCPFqrFY9Uxk?=
 =?us-ascii?Q?w4sjZth5guUon4L83IWlUuYVD5VnQeCB14QlLq7gSytIkPo9NdlOaUvDr0os?=
 =?us-ascii?Q?QGBSt+dFOV3aDalcgBaX92cJApCuQtadlxuRz6u/JzEowrpYeK8iRWYiEkpp?=
 =?us-ascii?Q?QS8UTD3rwAqlkB02b8mdOui7BE6Etnxufm67OKVxiHD25MN/GHmKVqc0sqnV?=
 =?us-ascii?Q?fc1eB8UHjx/qDM1din38k1Fyrqc9mpIbewis+haPrIxah4+HF1s9Swx4jjip?=
 =?us-ascii?Q?6lXxy7zu5w19tZOhVK3s299tq1LPmz7zsDRV0R47MwtBds6im0wWIDRNBo/8?=
 =?us-ascii?Q?MfTp7uw9aBVwN2P1aOW+2bD1hAdzqeac8uVv8zvgJDzoKxVbyHFUNBREbyx2?=
 =?us-ascii?Q?JLL6ks0M9EvZ9L4kLygMlfaMQOAwHY8IdFqilfzPRt+z1fZkfEvoFu2+GrpV?=
 =?us-ascii?Q?Gb11Vq1uKI2fZW0Afs0/EJaRvf0Acl7yalKpa4djGMzrBeTWv+lVngn1nDyN?=
 =?us-ascii?Q?qqcZ9UdhQw1P7mVsIUXleZFKQPYrTEvTYtdbDwwvNhlyEZvehnTG7lkzv5+f?=
 =?us-ascii?Q?K3wlzjXYAylkT0JqfV1me3N03Z4pZJVrr5HX1C0M?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f55f20b-dbfc-4e62-535c-08db66aa2d6b
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 16:22:09.7920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZYW37TOdJTc5XT++cKU3aj0ONWdnhLVW00dyZlh94epU2nzKdcOyPeu2RpFBMqU+986bjaZLWXzLaBlwaYKIzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_12,2023-06-06_02,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Move icm42600 dependent function inside the core module.
Do some headers cleanup at the same time.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   | 11 +++++++++++
 .../iio/imu/inv_icm42600/inv_icm42600_timestamp.c  | 14 +-------------
 .../iio/imu/inv_icm42600/inv_icm42600_timestamp.h  |  6 ------
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 7b3a2a0dc2cb..c34735b05830 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -516,6 +516,17 @@ static int inv_icm42600_irq_init(struct inv_icm42600_state *st, int irq,
 					 "inv_icm42600", st);
 }
 
+static int inv_icm42600_timestamp_setup(struct inv_icm42600_state *st)
+{
+	unsigned int val;
+
+	/* enable timestamp register */
+	val = INV_ICM42600_TMST_CONFIG_TMST_TO_REGS_EN |
+	      INV_ICM42600_TMST_CONFIG_TMST_EN;
+	return regmap_update_bits(st->map, INV_ICM42600_REG_TMST_CONFIG,
+				  INV_ICM42600_TMST_CONFIG_MASK, val);
+}
+
 static int inv_icm42600_enable_regulator_vddio(struct inv_icm42600_state *st)
 {
 	int ret;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
index 37cbf08acb3a..3e305e7e9887 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
@@ -3,11 +3,10 @@
  * Copyright (C) 2020 Invensense, Inc.
  */
 
+#include <linux/errno.h>
 #include <linux/kernel.h>
-#include <linux/regmap.h>
 #include <linux/math64.h>
 
-#include "inv_icm42600.h"
 #include "inv_icm42600_timestamp.h"
 
 /* internal chip period is 32kHz, 31250ns */
@@ -56,17 +55,6 @@ void inv_icm42600_timestamp_init(struct inv_icm42600_timestamp *ts,
 	inv_update_acc(&ts->chip_period, INV_ICM42600_TIMESTAMP_PERIOD);
 }
 
-int inv_icm42600_timestamp_setup(struct inv_icm42600_state *st)
-{
-	unsigned int val;
-
-	/* enable timestamp register */
-	val = INV_ICM42600_TMST_CONFIG_TMST_TO_REGS_EN |
-	      INV_ICM42600_TMST_CONFIG_TMST_EN;
-	return regmap_update_bits(st->map, INV_ICM42600_REG_TMST_CONFIG,
-				  INV_ICM42600_TMST_CONFIG_MASK, val);
-}
-
 int inv_icm42600_timestamp_update_odr(struct inv_icm42600_timestamp *ts,
 				      uint32_t period, bool fifo)
 {
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h b/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h
index 4e4f331d4fe4..b808a6da15e5 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h
@@ -6,10 +6,6 @@
 #ifndef INV_ICM42600_TIMESTAMP_H_
 #define INV_ICM42600_TIMESTAMP_H_
 
-#include <linux/kernel.h>
-
-struct inv_icm42600_state;
-
 /**
  * struct inv_icm42600_timestamp_interval - timestamps interval
  * @lo:	interval lower bound
@@ -53,8 +49,6 @@ struct inv_icm42600_timestamp {
 void inv_icm42600_timestamp_init(struct inv_icm42600_timestamp *ts,
 				 uint32_t period);
 
-int inv_icm42600_timestamp_setup(struct inv_icm42600_state *st);
-
 int inv_icm42600_timestamp_update_odr(struct inv_icm42600_timestamp *ts,
 				      uint32_t period, bool fifo);
 
-- 
2.34.1

