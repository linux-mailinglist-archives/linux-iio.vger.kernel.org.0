Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821537184E4
	for <lists+linux-iio@lfdr.de>; Wed, 31 May 2023 16:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbjEaO0d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 May 2023 10:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236350AbjEaO0a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 May 2023 10:26:30 -0400
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142BE139
        for <linux-iio@vger.kernel.org>; Wed, 31 May 2023 07:26:12 -0700 (PDT)
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34V8wvYk008615;
        Wed, 31 May 2023 14:25:48 GMT
Received: from jpn01-tyc-obe.outbound.protection.outlook.com (mail-tycjpn01lp2173.outbound.protection.outlook.com [104.47.23.173])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3qub7gu0yx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 14:25:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/NX9m0VVwFuG7AjTAITGs7nrFHWnOFAPiz6A9YH0KU/X7VB4A/VfBM1o8aXJ11DK9axUFbysOK+8nRKaVIeXs33X8vehp9U5+nyGPK3qYl2C3o4lhWUmARKkMiy9ZqszYiPd633PX0Vnls+bCL/Pe7ubCKC/g41hQ433GA74aNGlVc/rv80A5vjWXO4rSX1A3VBJgV3RZer63hT9Bh01+Yfh3m6oqD3A5WAeV/PaDwMIIiHL1FQGWhSi2yYoQ8yyOpJnjr94/qWD8+5PzxDGz8b1sRmPy7vFD5QB+rcYdzapyijH9aeyKDqM2Mtqsk1k/NlGTgXUk8K5MlE94jKNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZJgRUBqPDhn9GbKgnyCMz6lpyTZyWctRscwKkZM4Bg=;
 b=Sqohvfp1Pg9YDqRN5N+iZvwGTiatE3JaiIKTYHsPrg2LdmFQDV6gOqEQOrndhCG1JlrGtZC+XkujtcrGDh2HmIVBwMqqkmYeV0mpCvZqOnCX30nHbOg1VvaRAlRhRc/hPlOg265R3+TvsuK78XRwkFEHQujq6TyI77B2dL8vXRCFybfkUFuh0nEKvj65Pi1Zw+FelhtzDA9hdgjBmVZzaBElzZpSSFbvQ0MxfJPPIA3lb0Gi5v2KkdDTWNsgf4zpfaD7INzLoofQtVY+TPSFEcQrx+JSl+rbHzMhvkAo3xn0+c6CcX+sW3JKIQZb3eTXiggavWgexkuDzyLMLKSmnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZJgRUBqPDhn9GbKgnyCMz6lpyTZyWctRscwKkZM4Bg=;
 b=VY4qlLzPdeZPYJMz1AjJKm4iVcd8sEyGfTi/cr9VVrbznUHZtHPo54KvjNE5n3Hhm050N0UhGv5iwfprNa4AfCmB90yEyFaoKcAeY0OswS7okIxyV07nRnYt/zaAP3v+TBYNJOHDioiNn3uhALPsnupDWAV4pojrp15BO1Lrp42NPP5LSKSadHLvVllBrUY4ZwJvxvIq32eQgwJWATpyHZgmpvsUiKO5SW6svf260KvTc8HUitG+HyGM+bXAI47/w09nn/lTyT8FnuIKPOg41QHnAXMJ6bZhUB+sn2RJBcf8EVyf8cVTWcYCsgLBasYs0u5KxisFu3sPaX2ZQXME7Q==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by OS3P286MB3226.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:20e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 14:25:43 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::60df:b013:2731:f9c1]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::60df:b013:2731:f9c1%7]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 14:25:43 +0000
From:   inv.git-commit@tdk.com
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     lars@metafoo.de,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH 2/4] iio: move inv_icm42600 timestamp module in common
Date:   Wed, 31 May 2023 14:25:11 +0000
Message-Id: <20230531142513.48507-3-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230531142513.48507-1-inv.git-commit@tdk.com>
References: <20230531142513.48507-1-inv.git-commit@tdk.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P265CA0007.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::18) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|OS3P286MB3226:EE_
X-MS-Office365-Filtering-Correlation-Id: 64f8e0c0-ec84-4c16-ee0a-08db61e2eaad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EwWTgizyuT6A/jfF6U0VahbggFvE+LPNVCxnYy6ohG24ZvW4O1wKrk4MDJuPa1224bO6tplq0vJynXvChhdieOJHxdOXjfStMhXumSxdmk6s4I1/vATxZolz/vW0KjJLzTbaFm5SvphqubC6zwhFc+qwIxpvM/o3YirYj7U7hUV+H/UM3zUctD0Msl5NbYEX0ne8Mx2oPSiha8b8XRNFhn18m1+ZFChlrIY2EUxb1dWOnbgf9hUNIEmSNolpa3kZBYhByRLHzKIkf0FumnTBIlocQGAIj6grAeq7HRTMyJHdALi6hpCT9JoudUucLkhuEaqyok1tF9kndrBMatSrQ/iMbOGRXGR0PoplgMnr5V7g5BPm8RlLrrrmPNm/rkGEUoK5QQz/OPhvJEt+Ne94ur5eo5waR+7TBab6mazIvyjlQnDr+4iymg4f04sqpsdc64IVhfZyZkJYs7W+5Hl8y/3KMPSdRWNWTESUWXgF4XoNmNafDLRB1kzPUIzZjHZVL6o3kEUIKTW2/AxwCdibLPx0EAX3KmhYY4C8t+qbhKmCMClXJjoOTSPPTqRyIyQ0Pia7QaS3z0Bb7Fa7X4+5OwLa0Reil6F07JJDML4/f203nasQ20DzwfPVphkfZKXJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199021)(2616005)(2906002)(186003)(83380400001)(36756003)(38100700002)(38350700002)(8936002)(8676002)(41300700001)(86362001)(478600001)(4326008)(66556008)(66476007)(66946007)(5660300002)(6486002)(52116002)(6666004)(316002)(6512007)(9686003)(6506007)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K73csZUFi5Xe9HRIh9uPZN9dpo2cBzD6YacfHky0OKHwRLV0JfkEVgMflTQf?=
 =?us-ascii?Q?3ydueh3ZyQGnJ4eoW9Hc2EVOBOdCLtXHG8uefpBOuV5JFzAllN0WmC+2xGgv?=
 =?us-ascii?Q?X+VegkxIGIEBYYBI73u5z8zHSnuDm8GdzJ0dt25BTYJfjD9Z0tRv3YVpT2IX?=
 =?us-ascii?Q?FelAzrY0PWAcWKqzii7Jw/oO55vengH+w26P/Zos/Oej2RpCzWLpS6LF/a6e?=
 =?us-ascii?Q?20KOnttYzxq0eKR6rQWwbdRPnwrCfonWQuREYwu+f7BydoZbfc+cv/ybXuOo?=
 =?us-ascii?Q?RLXzDEKdNYhptw/w6uLW2YjjyOZvNiFeiEB3uZvFpjQ9c5vxbEhK8NBn+Mi5?=
 =?us-ascii?Q?jaN1HJXTnUT4sk+bcpGvKDZzQTjksVdVZB2az5QofEeGffmpHSOO+zmjfa3F?=
 =?us-ascii?Q?WN/4FrM9ExaMFIbWGCFcO/OLIgEkgqI6xe5WhZRleiT31lDaZtmNcYn76Bt3?=
 =?us-ascii?Q?ebkOq1eoXNm4uy0ZK3lioNdTOejNZYT1DRLA1JLXJf1eLVpjh2Rq1o8g/8td?=
 =?us-ascii?Q?riM6xKWfwywNyBAamxnyOsx2LvacA0vxJOLQCBjW6JD8AYt0T4SRhbmdXMM4?=
 =?us-ascii?Q?VU8E1AxNlsG8JQSiSoqt04hAYSk2exR/4RggR5xNS9RDblStgSWXEpdeOYoX?=
 =?us-ascii?Q?xhDnapUFFZgNqRSUQHmOtj8QS+UBk8GoWtjbMEb6nOAV/4Lk7NN5yXFvtm+1?=
 =?us-ascii?Q?JYzRHasCqSyyySym66PATwCPx8EBDTgnIHyBjq1qTGcYx8DDrVXk7UrDPQaX?=
 =?us-ascii?Q?GQTbYkewQqBpj8M9AssCqyEwKe5vnhhLYAPE+q+7ylBUhoDNc0Vga5JLcbN1?=
 =?us-ascii?Q?lx7kTFG0ByZxHG2ltxFoYWrWk99mKeQCDIF+n/3FFzHfmyeDxOlV162dll+D?=
 =?us-ascii?Q?yXQCEMklQjOwzU9WiiyOvZjk85xjMVW4xNZrQAMqyIq80dPgwxXyW8ZFuL8k?=
 =?us-ascii?Q?RfD27+8lt7dI48hnefB5KiG+y6NLDVmnDJQmm9aGWLYxwUTepUmlgOSxKR67?=
 =?us-ascii?Q?YNtSAs4C7m6F8sZ0gJ4LLJVClId+tyVGC3vjMNagsb3rCQDYV22QVCwMvTEU?=
 =?us-ascii?Q?DGbKWSeTYQVWTrzlyVZnXr44FBQzSAIcUNdd34UxDuMuedZixnp8LXYlBChZ?=
 =?us-ascii?Q?T+XfZ7OgJeqbhuDw7rXpt1kQ+QaIyjIHrHsONFol73I2BBnftMPZYkOgJYwl?=
 =?us-ascii?Q?dDv5Nui/XfjDIvba6i68uxZZsjZSvyWUrhVHhrg9bWro1UkNGhKlpREY9pCa?=
 =?us-ascii?Q?xiuMTl1swTLmhYcaFro9WRlUUVICag99lyUM+ET5rWgXvmgzTNrZwBSGMusF?=
 =?us-ascii?Q?riaOvpM57Yj+ZlEDCVT2LG09jEnZGvWTUJXOlCe6jCIvDVADbEQ5lqlwkvZM?=
 =?us-ascii?Q?zqwZ/Ls8ER1/6hNF6mxZoDqhgc9VolkNTNktdu8TaDhF8kCKJ5ahDl/t6iir?=
 =?us-ascii?Q?dTh2vMzPXR+prJSRepxCxuADQbJtDCyV78sgIwBxbiYYg+9mLCYNpbh3E8ZJ?=
 =?us-ascii?Q?criAPKl7w6zAid/73L6TlGffw0LepGidpTTkFMFtbvSIFefqdQrG2EvOlWxO?=
 =?us-ascii?Q?RXCirW2P4BR5Z/jWck5bOIHWwMDSMXTBVyMcx3Kf?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f8e0c0-ec84-4c16-ee0a-08db61e2eaad
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 14:25:43.2379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZPDvc4kdbZmeHGdvEbYfNCT89NwF8Q3r8cm6NvDbyIcxUG5BPvTY0du8v5l2+18D00pUboPflJkxaaHuthDzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB3226
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_09,2023-05-31_03,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Create new inv_sensors common modules and move inv_icm42600
timestamp module inside.
Modify inv_icm42600 driver to use timestamp module.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/common/Kconfig                           |  1 +
 drivers/iio/common/Makefile                          |  1 +
 drivers/iio/common/inv_sensors/Kconfig               |  7 +++++++
 drivers/iio/common/inv_sensors/Makefile              |  6 ++++++
 .../inv_sensors}/inv_icm42600_timestamp.c            | 12 ++++++++++--
 drivers/iio/imu/inv_icm42600/Kconfig                 |  1 +
 drivers/iio/imu/inv_icm42600/Makefile                |  1 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c    |  2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c   |  2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c     |  3 ++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c     |  2 +-
 .../linux/iio/common}/inv_icm42600_timestamp.h       |  0
 12 files changed, 31 insertions(+), 7 deletions(-)
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
index ceae8ccb1747..411f561e1a24 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
+++ b/drivers/iio/common/inv_sensors/inv_icm42600_timestamp.c
@@ -5,9 +5,9 @@
 
 #include <linux/kernel.h>
 #include <linux/math64.h>
+#include <linux/module.h>
 #include <linux/errno.h>
-
-#include "inv_icm42600_timestamp.h"
+#include <linux/iio/common/inv_icm42600_timestamp.h>
 
 /* internal chip period is 32kHz, 31250ns */
 #define INV_ICM42600_TIMESTAMP_PERIOD		31250
@@ -54,6 +54,7 @@ void inv_icm42600_timestamp_init(struct inv_icm42600_timestamp *ts,
 	/* use theoretical value for chip period */
 	inv_update_acc(&ts->chip_period, INV_ICM42600_TIMESTAMP_PERIOD);
 }
+EXPORT_SYMBOL_NS_GPL(inv_icm42600_timestamp_init, IIO_INV_SENSORS_TIMESTAMP);
 
 int inv_icm42600_timestamp_update_odr(struct inv_icm42600_timestamp *ts,
 				      uint32_t period, bool fifo)
@@ -66,6 +67,7 @@ int inv_icm42600_timestamp_update_odr(struct inv_icm42600_timestamp *ts,
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(inv_icm42600_timestamp_update_odr, IIO_INV_SENSORS_TIMESTAMP);
 
 static bool inv_validate_period(uint32_t period, uint32_t mult)
 {
@@ -153,6 +155,7 @@ void inv_icm42600_timestamp_interrupt(struct inv_icm42600_timestamp *ts,
 	if (valid)
 		inv_align_timestamp_it(ts);
 }
+EXPORT_SYMBOL_NS_GPL(inv_icm42600_timestamp_interrupt, IIO_INV_SENSORS_TIMESTAMP);
 
 void inv_icm42600_timestamp_apply_odr(struct inv_icm42600_timestamp *ts,
 				      uint32_t fifo_period, size_t fifo_nb,
@@ -184,3 +187,8 @@ void inv_icm42600_timestamp_apply_odr(struct inv_icm42600_timestamp *ts,
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
index c3f433ad3af6..1015de636a94 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -12,12 +12,12 @@
 #include <linux/math64.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/common/inv_icm42600_timestamp.h>
 #include <linux/iio/kfifo_buf.h>
 
 #include "inv_icm42600.h"
 #include "inv_icm42600_temp.h"
 #include "inv_icm42600_buffer.h"
-#include "inv_icm42600_timestamp.h"
 
 #define INV_ICM42600_ACCEL_CHAN(_modifier, _index, _ext_info)		\
 	{								\
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 32d7f8364230..4a39d31e911f 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -11,9 +11,9 @@
 #include <linux/delay.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/common/inv_icm42600_timestamp.h>
 
 #include "inv_icm42600.h"
-#include "inv_icm42600_timestamp.h"
 #include "inv_icm42600_buffer.h"
 
 /* FIFO header: 1 byte */
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index c34735b05830..f3e379f9733d 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -16,10 +16,10 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/common/inv_icm42600_timestamp.h>
 
 #include "inv_icm42600.h"
 #include "inv_icm42600_buffer.h"
-#include "inv_icm42600_timestamp.h"
 
 static const struct regmap_range_cfg inv_icm42600_regmap_ranges[] = {
 	{
@@ -799,3 +799,4 @@ EXPORT_NS_GPL_DEV_PM_OPS(inv_icm42600_pm_ops, IIO_ICM42600) = {
 MODULE_AUTHOR("InvenSense, Inc.");
 MODULE_DESCRIPTION("InvenSense ICM-426xx device driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_INV_SENSORS_TIMESTAMP);
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 9d94a8518e3c..6caea7b8a344 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -12,12 +12,12 @@
 #include <linux/math64.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/common/inv_icm42600_timestamp.h>
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

