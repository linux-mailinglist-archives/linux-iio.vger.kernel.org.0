Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43297248E5
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jun 2023 18:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237638AbjFFQWq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Jun 2023 12:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237227AbjFFQWo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Jun 2023 12:22:44 -0400
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97957FB
        for <linux-iio@vger.kernel.org>; Tue,  6 Jun 2023 09:22:42 -0700 (PDT)
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3568m9s7005040;
        Tue, 6 Jun 2023 16:22:20 GMT
Received: from jpn01-os0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2111.outbound.protection.outlook.com [104.47.23.111])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3qyxvgj55s-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 16:22:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEmIHD5N2lo32eZFS+LvQVofCu5lSTxwbjcH1KptH++zIrkA/1JIF2zg4fagSfnxi8SFj39C4qMfW9icNkRIoKzFdoteh6I7sOzoJ724uUIbdH3rvHMDBQza3XSsV0FE/0K96p2T9wE4btWVrDCKH/CFleffncZQrD4n5ISFaDoMvPSzdSsfwWRlFwTt38VogXBUAzuAbt9Ia3+TO6zM+66bGK7YvbuVDZwUSgT17ZBEMMj8NX2mpAQDipOwwR8U/ZdkBNvIkF6Fh5RCEHwAyH8kRMpa6pTa/eJVoGe1S/pxfnJhd/KUZGY0Y5NnJg1pNESVFnexeZx5EDGItFxiiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1e/6spIzRRlQvVAr7yIu1yBt3CG7RNFfhk/CWIIsZUA=;
 b=cGxv8vGnJo7Q8aaKuGzNz2iiHUnUb6K/rZio3SjZ6Hq5dZOZOCXqb7a5BESMHts5TJwal+UpLdSMsPimKHmOkaeAk8HsiyqsbJ1Li5M3K1NfLZK3QZptuCkbjHbeO+0L1FqjPVukRIb4uU/ahtmcZijucUUtDP2iTHOPJViDzPr5t7KTUCmSa7ALePXqAuNR1sETj7VBOAZs6bknvdH2ELR6xBukruiyf1yEIdfH7MUYZCKM5N1Ha2W7QSb6vzTENEl4q57cw7CQ8HoTCEhONmeCJn8xrDAvr3/feFTEYaZPfYar2Refg6nGfulDxpbnFJw6a74tAcW+ZJJbxtO1qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1e/6spIzRRlQvVAr7yIu1yBt3CG7RNFfhk/CWIIsZUA=;
 b=WV5DjI9i5p6YDl6/q8EA62Xy+ZG8us+yPPHOPSsQyQ9IYYNoSib9o3iLx0X5XbkgTAweKxj9I2vM82/AoSJB5UYf3B7qpMrqKFib2tGOUPgZZec++9tGshLz8DnS9FNSRSxVLe5dW9SAINpqkwNKUkslY58bxp+VOaCxfW/wXRJlxR2j5ZnLod5eIkeOOF+eOa6Wz6eEhJ0JWUUvOhUoiQ8QwWkbZoh324eBvUNbYA/onTQj6T1buJrE7r4BxRRP6+A1VyN21R1S+OxrYwO5sz/7u//qkK6Kt4Ruwc6fNmy9hNHULNCCPNt2hzb6CxDIiDf8SJ5/QYRx4YeBm311aQ==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYCP286MB2179.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Tue, 6 Jun
 2023 16:22:17 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::60df:b013:2731:f9c1]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::60df:b013:2731:f9c1%7]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 16:22:17 +0000
From:   inv.git-commit@tdk.com
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     lars@metafoo.de,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v2 2/4] iio: move inv_icm42600 timestamp module in common
Date:   Tue,  6 Jun 2023 16:21:45 +0000
Message-Id: <20230606162147.79667-3-inv.git-commit@tdk.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4c839d1d-7eaf-4300-98cf-08db66aa2ea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9+sZXctgSDySgORjip6rat8vAnaqZakf2ok4kU33FYWJ7j89M0Xg9hNB1c8XXLK2ZFRPS2ru7z6Yp4LM+44EGNdUDNXQwfCojTWFx4qM9W8Om/E2XJjcleP5K91EmW9F44tFfkUMChb8aLnvcOcHJGWwqVWPxlw6bga8RkWwiAJamTC8mXgPoE6Hao/S89wuVF2djRfIXoZFm2k3hjiqpaYg8OGSX7t3rxim+78CgpK6Krduc67mrxAA4AoZI+5ui8gCOrWdnHKlohkoFdf8moUEyBKt/WrSw2b1m1e+CxS7iT0jpJpoaIEPMoEnu3vEtbDCBTmPOsuCngMQD2keBVfojleFEDDaI9qZ4oXkMsqWgZVVu+D6UqbdrQywiFZCYMOdMzYtijuD70TxOVtdocLZuQ90VwzLvn1Zug28UXWDQD/MB0lj29KIhHKel1JpbceljmKg9jueiIaDI0k4RPLG332nLQJjJexUpgzuue6lJQXDeweXrVzP08NM/kBxm2ZFli+lic0uhlq23Ep8CK0xyXmEGD28FPoHt/G1Jvi2DyqNBHRXec6Ep1BjxgHWddwET/edNNN3fEJ40cN7WYiJJ0IlEwnY5N0gMmW0mqIk88trx+vSA9xrOJ8xZie9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199021)(36756003)(478600001)(5660300002)(6666004)(8936002)(8676002)(316002)(4326008)(66476007)(66556008)(66946007)(41300700001)(38350700002)(38100700002)(2906002)(1076003)(26005)(6506007)(6512007)(9686003)(86362001)(186003)(2616005)(83380400001)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cIJg02m0LiGKYB0jkqpYG+UdaLcFO82Wm6fafV3IzaERQpStMChRzp6n29Vn?=
 =?us-ascii?Q?SzWJGfQ1fJ6fKCi3f3XBDdPNhNV2YMVn5NehJq0TiWzA5nGTFks39rUTdOhU?=
 =?us-ascii?Q?JjKAhJldSSNCdXpJOPxcwrVsCSsRBbKaDMMRI0rarWn86ZdujANxqHm1OsJa?=
 =?us-ascii?Q?JrYlDJOTgy3yEWkoXHPaDtNgnPs6K8Oe8UWEAeF6QAwT7uyDxNDXuzdi7DUv?=
 =?us-ascii?Q?5dl4lT4HZqKfUJwVcA4VYzi6O8bzS3N+Dp06aACS5Fu2MwyKkp2vV4bbXWZf?=
 =?us-ascii?Q?UJiiF3v80+/h6/Spq4B2HLyMI8BvaiH0t7LhtIu/y+YGpZpeMxaYHuqsQIA3?=
 =?us-ascii?Q?Ip5+mBaSWyycAttI9lEqvUK5RAhvfADtFQzO8c3KbDXqvUcIQhN8Aj++lXmq?=
 =?us-ascii?Q?tRxSJpJH68TvNcHFR54pclvLnGXeDqMwOIaML0/kg0Knoq+DVBg0G9+pHZmZ?=
 =?us-ascii?Q?aj7YQ/bQvw9FPVzq3gWfWbcdJlOBLCTW3Oh6shf/IaTIW9xnGGTa1z4OsK9F?=
 =?us-ascii?Q?tq+Eb7KQRlk56UsvA2wj7v9QsyXoUekPYuxFaJSSVNa9C2xhN5GP+GtFmzZO?=
 =?us-ascii?Q?GnkusmTwjnYZp/XHMvQUiGp8FxyCx1Yb/sUMtbS+rNEbtZ6+mp6foDSCqdsW?=
 =?us-ascii?Q?pzVRwTGDAw40qbxRAU3PYOztHZInJbadIzoaMZ8SDwYR/diK+Q1qZtX92rQk?=
 =?us-ascii?Q?SsbBCDg4I8plvU2q0xXioLMVHOg6oWFHpXECbSw6cHqIjCnuq4L+sHse2Pbz?=
 =?us-ascii?Q?bHfQL8PVGIUUyiqtvxm9QAiM1erXb7VK8L8AFvDRxb2IyEOBwDU32Hg4M9vk?=
 =?us-ascii?Q?/lLJza151r+AQqeHBpU8S8NywS+az/tKfj41OMX+Hfq9OSw72EDn+V8ztKxf?=
 =?us-ascii?Q?ONDa41fs3d2X95n18Xscm3KXJOjHAC7HNf8/BiTB1VxJ1wtaLGpLnMByioj0?=
 =?us-ascii?Q?qkgsrRemk8p5y9jpqx2mWWYUDUlf5w9MytzHKw3tTT0SrBsgJk0gXeNpXakv?=
 =?us-ascii?Q?gAx7XA4BHCCq+SzJRkZntTd400N767WHIgQTHiyLBvcXNhFyhMLVzTUDYQfR?=
 =?us-ascii?Q?vo2GvUrnN+x+BHI6nSMH3mPvoFnl59M+zLAo+gCOmo7jQ4kS6rF/LhphexS/?=
 =?us-ascii?Q?B8GUS0KXDZyq5bDd2UF5tsX7hFo/GC1fS0sYzA21yCMqrynI13BEQEVTwtvx?=
 =?us-ascii?Q?wN1L9DorgRLNBLOpjy/7oXxR/Mdt/69YO/pUkbaAFNmOtfHnHE3jygsqOFXF?=
 =?us-ascii?Q?EAs8sbx6vDyDAfMJP6I9TqlFO+kt+yyBFk3VRYIdjZGSmRKmKQnQv5+wiLA5?=
 =?us-ascii?Q?pydmtMx7QhjIT9L7i1TbNRDF4lVUPpUmmHtwcCvwMCAxJDMwxXeCHdx7D+IJ?=
 =?us-ascii?Q?+xc6Tmgc0tfsQjh9P4N6V3DNFLoDfwS+Ut9s4YjTqPcEGh7l04e+oldQ/TFa?=
 =?us-ascii?Q?/P3RQbnbtJqBKBJeP0vY6RAMEiplYvpHDGb/WW4r+p4McCl7fyL9AOGgYYyW?=
 =?us-ascii?Q?lR5kaBIRC/XeLRbTboNSfsEXBqOkie83W0ek0N7wTNLE8exQlE4/hN95RFTI?=
 =?us-ascii?Q?JHxcboQaEr4/k0yNw+CwMlNjBm7Ys42Uf7RcD/EX?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c839d1d-7eaf-4300-98cf-08db66aa2ea3
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 16:22:11.7895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8M+KiuQyxgPW5PaWWFcJwIBtLuZrr/+6lrLcYsj5gyYOhTF4IxF3gayb2zziJRLCDeyLHBZG/zQcA7uacdKfA==
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

Create new inv_sensors common modules and move inv_icm42600
timestamp module inside. This module will be used by IMUs and
also in the future by other chips.

Modify inv_icm42600 driver to use timestamp module and do some
headers cleanup.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/common/Kconfig                            |  1 +
 drivers/iio/common/Makefile                           |  1 +
 drivers/iio/common/inv_sensors/Kconfig                |  7 +++++++
 drivers/iio/common/inv_sensors/Makefile               |  6 ++++++
 .../inv_sensors}/inv_icm42600_timestamp.c             | 11 ++++++++++-
 drivers/iio/imu/inv_icm42600/Kconfig                  |  1 +
 drivers/iio/imu/inv_icm42600/Makefile                 |  1 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c     |  5 +++--
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c    |  5 +++--
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c      |  4 +++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c      |  5 +++--
 .../linux/iio/common}/inv_icm42600_timestamp.h        |  0
 12 files changed, 38 insertions(+), 9 deletions(-)
 create mode 100644 drivers/iio/common/inv_sensors/Kconfig
 create mode 100644 drivers/iio/common/inv_sensors/Makefile
 rename drivers/iio/{imu/inv_icm42600 => common/inv_sensors}/inv_icm42600_timestamp.c (91%)
 rename {drivers/iio/imu/inv_icm42600 => include/linux/iio/common}/inv_icm42600_timestamp.h (100%)

diff --git a/drivers/iio/common/Kconfig b/drivers/iio/common/Kconfig
index 0334b4954773..1ccb5ccf3706 100644
--- a/drivers/iio/common/Kconfig
+++ b/drivers/iio/common/Kconfig
@@ -5,6 +5,7 @@
 
 source "drivers/iio/common/cros_ec_sensors/Kconfig"
 source "drivers/iio/common/hid-sensors/Kconfig"
+source "drivers/iio/common/inv_sensors/Kconfig"
 source "drivers/iio/common/ms_sensors/Kconfig"
 source "drivers/iio/common/scmi_sensors/Kconfig"
 source "drivers/iio/common/ssp_sensors/Kconfig"
diff --git a/drivers/iio/common/Makefile b/drivers/iio/common/Makefile
index fad40e1e1718..d3e952239a62 100644
--- a/drivers/iio/common/Makefile
+++ b/drivers/iio/common/Makefile
@@ -10,6 +10,7 @@
 # When adding new entries keep the list in alphabetical order
 obj-y += cros_ec_sensors/
 obj-y += hid-sensors/
+obj-y += inv_sensors/
 obj-y += ms_sensors/
 obj-y += scmi_sensors/
 obj-y += ssp_sensors/
diff --git a/drivers/iio/common/inv_sensors/Kconfig b/drivers/iio/common/inv_sensors/Kconfig
new file mode 100644
index 000000000000..28815fb43157
--- /dev/null
+++ b/drivers/iio/common/inv_sensors/Kconfig
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# TDK-InvenSense sensors common library
+#
+
+config IIO_INV_SENSORS_TIMESTAMP
+	tristate
diff --git a/drivers/iio/common/inv_sensors/Makefile b/drivers/iio/common/inv_sensors/Makefile
new file mode 100644
index 000000000000..93bddb9356b8
--- /dev/null
+++ b/drivers/iio/common/inv_sensors/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for TDK-InvenSense sensors module.
+#
+
+obj-$(CONFIG_IIO_INV_SENSORS_TIMESTAMP) += inv_icm42600_timestamp.o
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c b/drivers/iio/common/inv_sensors/inv_icm42600_timestamp.c
similarity index 91%
rename from drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
rename to drivers/iio/common/inv_sensors/inv_icm42600_timestamp.c
index 3e305e7e9887..7cd80cdf0ee5 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
+++ b/drivers/iio/common/inv_sensors/inv_icm42600_timestamp.c
@@ -6,8 +6,9 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/math64.h>
+#include <linux/module.h>
 
-#include "inv_icm42600_timestamp.h"
+#include <linux/iio/common/inv_icm42600_timestamp.h>
 
 /* internal chip period is 32kHz, 31250ns */
 #define INV_ICM42600_TIMESTAMP_PERIOD		31250
@@ -54,6 +55,7 @@ void inv_icm42600_timestamp_init(struct inv_icm42600_timestamp *ts,
 	/* use theoretical value for chip period */
 	inv_update_acc(&ts->chip_period, INV_ICM42600_TIMESTAMP_PERIOD);
 }
+EXPORT_SYMBOL_NS_GPL(inv_icm42600_timestamp_init, IIO_INV_SENSORS_TIMESTAMP);
 
 int inv_icm42600_timestamp_update_odr(struct inv_icm42600_timestamp *ts,
 				      uint32_t period, bool fifo)
@@ -66,6 +68,7 @@ int inv_icm42600_timestamp_update_odr(struct inv_icm42600_timestamp *ts,
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(inv_icm42600_timestamp_update_odr, IIO_INV_SENSORS_TIMESTAMP);
 
 static bool inv_validate_period(uint32_t period, uint32_t mult)
 {
@@ -153,6 +156,7 @@ void inv_icm42600_timestamp_interrupt(struct inv_icm42600_timestamp *ts,
 	if (valid)
 		inv_align_timestamp_it(ts);
 }
+EXPORT_SYMBOL_NS_GPL(inv_icm42600_timestamp_interrupt, IIO_INV_SENSORS_TIMESTAMP);
 
 void inv_icm42600_timestamp_apply_odr(struct inv_icm42600_timestamp *ts,
 				      uint32_t fifo_period, size_t fifo_nb,
@@ -184,3 +188,8 @@ void inv_icm42600_timestamp_apply_odr(struct inv_icm42600_timestamp *ts,
 		ts->timestamp = ts->it.up - interval;
 	}
 }
+EXPORT_SYMBOL_NS_GPL(inv_icm42600_timestamp_apply_odr, IIO_INV_SENSORS_TIMESTAMP);
+
+MODULE_AUTHOR("InvenSense, Inc.");
+MODULE_DESCRIPTION("InvenSense sensors timestamp module");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/imu/inv_icm42600/Kconfig b/drivers/iio/imu/inv_icm42600/Kconfig
index 50cbcfcb6cf1..f56b0816cc4d 100644
--- a/drivers/iio/imu/inv_icm42600/Kconfig
+++ b/drivers/iio/imu/inv_icm42600/Kconfig
@@ -3,6 +3,7 @@
 config INV_ICM42600
 	tristate
 	select IIO_BUFFER
+	select IIO_INV_SENSORS_TIMESTAMP
 
 config INV_ICM42600_I2C
 	tristate "InvenSense ICM-426xx I2C driver"
diff --git a/drivers/iio/imu/inv_icm42600/Makefile b/drivers/iio/imu/inv_icm42600/Makefile
index 291714d9aa54..0f49f6df3647 100644
--- a/drivers/iio/imu/inv_icm42600/Makefile
+++ b/drivers/iio/imu/inv_icm42600/Makefile
@@ -6,7 +6,6 @@ inv-icm42600-y += inv_icm42600_gyro.o
 inv-icm42600-y += inv_icm42600_accel.o
 inv-icm42600-y += inv_icm42600_temp.o
 inv-icm42600-y += inv_icm42600_buffer.o
-inv-icm42600-y += inv_icm42600_timestamp.o
 
 obj-$(CONFIG_INV_ICM42600_I2C) += inv-icm42600-i2c.o
 inv-icm42600-i2c-y += inv_icm42600_i2c.o
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index c3f433ad3af6..c2591101645a 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -10,14 +10,15 @@
 #include <linux/regmap.h>
 #include <linux/delay.h>
 #include <linux/math64.h>
-#include <linux/iio/iio.h>
+
 #include <linux/iio/buffer.h>
+#include <linux/iio/common/inv_icm42600_timestamp.h>
+#include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
 
 #include "inv_icm42600.h"
 #include "inv_icm42600_temp.h"
 #include "inv_icm42600_buffer.h"
-#include "inv_icm42600_timestamp.h"
 
 #define INV_ICM42600_ACCEL_CHAN(_modifier, _index, _ext_info)		\
 	{								\
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 32d7f8364230..ba4bb389a9fc 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -9,11 +9,12 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/delay.h>
-#include <linux/iio/iio.h>
+
 #include <linux/iio/buffer.h>
+#include <linux/iio/common/inv_icm42600_timestamp.h>
+#include <linux/iio/iio.h>
 
 #include "inv_icm42600.h"
-#include "inv_icm42600_timestamp.h"
 #include "inv_icm42600_buffer.h"
 
 /* FIFO header: 1 byte */
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index c34735b05830..9d227b4776eb 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -15,11 +15,12 @@
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+
+#include <linux/iio/common/inv_icm42600_timestamp.h>
 #include <linux/iio/iio.h>
 
 #include "inv_icm42600.h"
 #include "inv_icm42600_buffer.h"
-#include "inv_icm42600_timestamp.h"
 
 static const struct regmap_range_cfg inv_icm42600_regmap_ranges[] = {
 	{
@@ -799,3 +800,4 @@ EXPORT_NS_GPL_DEV_PM_OPS(inv_icm42600_pm_ops, IIO_ICM42600) = {
 MODULE_AUTHOR("InvenSense, Inc.");
 MODULE_DESCRIPTION("InvenSense ICM-426xx device driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_INV_SENSORS_TIMESTAMP);
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 9d94a8518e3c..0ea3d8bf709d 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -10,14 +10,15 @@
 #include <linux/regmap.h>
 #include <linux/delay.h>
 #include <linux/math64.h>
-#include <linux/iio/iio.h>
+
 #include <linux/iio/buffer.h>
+#include <linux/iio/common/inv_icm42600_timestamp.h>
+#include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
 
 #include "inv_icm42600.h"
 #include "inv_icm42600_temp.h"
 #include "inv_icm42600_buffer.h"
-#include "inv_icm42600_timestamp.h"
 
 #define INV_ICM42600_GYRO_CHAN(_modifier, _index, _ext_info)		\
 	{								\
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h b/include/linux/iio/common/inv_icm42600_timestamp.h
similarity index 100%
rename from drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h
rename to include/linux/iio/common/inv_icm42600_timestamp.h
-- 
2.34.1

