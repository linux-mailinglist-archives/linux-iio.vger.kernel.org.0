Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3BF21263EF
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2019 14:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfLSNsm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Dec 2019 08:48:42 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:45664 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726712AbfLSNsl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Dec 2019 08:48:41 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJDjYpu027685;
        Thu, 19 Dec 2019 08:48:26 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by mx0b-00128a01.pphosted.com with ESMTP id 2wvw8cvh8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 08:48:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlr6Skf7s6mSHrYB964OduSdHTPz6HCqDlfCz91dLacqLxzTrhFvfKx5uM09vylVXAyIuh+okSdFBPORD6Em4hTIJwOVT3h2r+D0K5XruCARddambwvAiov7FtlMm9cCfXmUVvjx2yuSxQr90t/asVI2iemuBSxlA4wQncw61RtbKZ/tIrP6+DOwxeDyKoSiY0RBhRYOxl5rzSubCb7NSSZe/f+NBuNleQhbm1i5Mi+YxUzfOITEhSgi6A4FgJpnhEYQW7xrKhAFE9+iObwpHljXERvX5Mo6BaJXdTn8hdm/y7c9tbyEhIpA4zfl2ARrt4c0+KhvtMQKsbm1Qjo3Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rx0Th4tAh06vP6/bO96Jb5Z93KvX8XVEV4VrBv0USVA=;
 b=jHJ2u4uV/if1sHV7HVEM8FbxBSIkRFcJRDO0Qu9+lvGgmkUUwKanzCgnFS7F0azhWE8/O/INBou+haMSQ6zhAqbUo8FsKFdIanoXwy6trezmok9HTWTjLPyEjO+fg2Ojl39SSia4Ldx9A+1l+QHeQw9YmpWDEOnNbI/CyPgY7cli1NDeXSDHOiB6/GRcdfGLEpMdNCQyjnu1Jl3cKtfl/ciPZ2LDzoRjbENYMwqBcj2uoNNe3AZbC4EVes9RvvmcGHChiEQBOSE3XEKZDjSHTkFZUFrJU/6iIhXbOfAUDoUdwa9ejmvPtAmhXEWapDZjEoQkcUcrObJprpvVY5vjJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rx0Th4tAh06vP6/bO96Jb5Z93KvX8XVEV4VrBv0USVA=;
 b=SUeiIqLMta/rejOl/SvEgzqlF5HMhafn6bJ/TyDA3HzCV4tfEeDNxdoA4N6+mjjAaTe+TjCTScJAtLm26GRBxvXkVDgC8TzPUeZVNL7vTJu2IyA9j50AyQtvsfKDdmqn9Q9z0dnjb/kBSTVN/0KwWi5HrdFrmwX5prq1kZGSg5Q=
Received: from SN4PR0501CA0091.namprd05.prod.outlook.com
 (2603:10b6:803:22::29) by BY5PR03MB5186.namprd03.prod.outlook.com
 (2603:10b6:a03:221::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14; Thu, 19 Dec
 2019 13:48:23 +0000
Received: from SN1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:22:cafe::82) by SN4PR0501CA0091.outlook.office365.com
 (2603:10b6:803:22::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.10 via Frontend
 Transport; Thu, 19 Dec 2019 13:48:23 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT029.mail.protection.outlook.com (10.152.72.110) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2559.14
 via Frontend Transport; Thu, 19 Dec 2019 13:48:22 +0000
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xBJDmKTO001862
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Dec 2019 05:48:21 -0800
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 19 Dec
 2019 05:48:18 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 19 Dec 2019 08:48:17 -0500
Received: from mircea-Latitude-E6540.ad.analog.com ([10.48.65.128])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id xBJDmBOO001170;
        Thu, 19 Dec 2019 08:48:14 -0500
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <alexandru.ardelean@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH 2/3] iio: frequency: ltc6952: Add support for LTC6952
Date:   Thu, 19 Dec 2019 15:48:09 +0200
Message-ID: <20191219134810.6677-2-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219134810.6677-1-mircea.caprioru@analog.com>
References: <20191219134810.6677-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(189003)(199004)(107886003)(8936002)(2906002)(316002)(356004)(8676002)(7696005)(1076003)(70586007)(36756003)(5660300002)(44832011)(4326008)(246002)(30864003)(70206006)(186003)(478600001)(54906003)(7636002)(86362001)(426003)(966005)(6916009)(336012)(6666004)(26005)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR03MB5186;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 359097f1-c816-416d-2e2a-08d7848a1d4a
X-MS-TrafficTypeDiagnostic: BY5PR03MB5186:
X-Microsoft-Antispam-PRVS: <BY5PR03MB51867950F9973EB67392A8BD81520@BY5PR03MB5186.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-Forefront-PRVS: 0256C18696
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sGG5HcbCjK/Rn7UGsOAyx5YpEC9LqZy6s9AFQEcxYeOEj3sgini/DX0YT/RI61ughZ7AApJSgfhFFcwV3lNjLfyNqGW/+tU1IuE1V8uhOe3AGWv8fvXB5kNc3TmIswiF7hMVttJ1MrW20nRCj+hAQ1kcBYu/z/DtW9RrP4KXuIUffZvtHvHUjnJBHppU0DdNq4D9PHNozJhlKc+Ws2O4RDc4X+AovcgiefcbH1pH5H6DI6srrcOvpA0wWg2esIp/uDuMo0Q+k3dOENd3XtwUpMbhGxzhGFq7DQhmwX4FfP3bG/pdvUB2a9HApYxMW6TS4TwGA/Nk5+KGXyGeGruTlhK22rojRuoRjZWh/+8Ex9zc0rc+wjQvY9dYHVynxOuMWbE0ksjuiP2V3fBdeo/xhbcOyFdsdzonw+DCZg+Ed1cmE0yUz0oyiRV4XQuajL5uVM/FAodqDA9S3TG5NDCAGkDug7RGXhCG74Baa7mEZGQ=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2019 13:48:22.6797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 359097f1-c816-416d-2e2a-08d7848a1d4a
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5186
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_01:2019-12-17,2019-12-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912190118
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

LTC6952 is a high performance, ultralow jitter, JESD204B/C clock generation
and distribution IC. It includes a Phase Locked Loop (PLL) core, consisting
of a reference divider, phase-frequency detector (PFD) with a phase-lock
indicator, ultralow noise charge pump and integer feedback divider.

The LTC6952's 11 outputs can be configured as up to 5 JESD204B/C subclass 1
device clock/SYSREF pairs plus one general purpose output, or simply 11
general purpose clock outputs for non-JESD204B/C applications.

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ltc6952.pdf

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
 drivers/iio/frequency/Kconfig   |  12 +
 drivers/iio/frequency/Makefile  |   1 +
 drivers/iio/frequency/ltc6952.c | 896 ++++++++++++++++++++++++++++++++
 3 files changed, 909 insertions(+)
 create mode 100644 drivers/iio/frequency/ltc6952.c

diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
index 240b81502512..3ee1295d1139 100644
--- a/drivers/iio/frequency/Kconfig
+++ b/drivers/iio/frequency/Kconfig
@@ -21,6 +21,18 @@ config AD9523
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad9523.
 
+config LTC6952
+	tristate "Analog Devices LTC6952 Clock Ultralow Jitter with JESD204B/C"
+	depends on SPI
+	depends on COMMON_CLK
+	help
+	  Say yes here to build support for Analog Devices LTC6952 Clock Ultralow
+	  Jitter Attenuator with JESD204B/C. The driver provides direct access
+	  via sysfs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ltc6952.
+
 endmenu
 
 #
diff --git a/drivers/iio/frequency/Makefile b/drivers/iio/frequency/Makefile
index 518b1e50caef..ccc20904a327 100644
--- a/drivers/iio/frequency/Makefile
+++ b/drivers/iio/frequency/Makefile
@@ -7,3 +7,4 @@
 obj-$(CONFIG_AD9523) += ad9523.o
 obj-$(CONFIG_ADF4350) += adf4350.o
 obj-$(CONFIG_ADF4371) += adf4371.o
+bj-$(CONFIG_LTC6952) += ltc6952.o
diff --git a/drivers/iio/frequency/ltc6952.c b/drivers/iio/frequency/ltc6952.c
new file mode 100644
index 000000000000..d9b7250febbe
--- /dev/null
+++ b/drivers/iio/frequency/ltc6952.c
@@ -0,0 +1,896 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for LTC6952 ultralow jitter, JESD204B/C clock generation IC.
+ *
+ * Copyright 2019 Analog Devices Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/delay.h>
+#include <linux/gcd.h>
+#include <linux/rational.h>
+#include <linux/debugfs.h>
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+/* Register address macro */
+#define LTC6952_REG(x)		(x)
+
+/* LTC6952_REG0 */
+#define LTC6952_UNLOCK_MSK	BIT(6)
+#define LTC6952_LOCK_MSK	BIT(4)
+#define LTC6952_VCOOK_MSK	BIT(2)
+#define LTC6952_REFOK_MSK	BIT(0)
+
+/* LTC6952_REG1 */
+#define LTC6952_INVSTAT_MSK	BIT(7)
+#define LTC6952_INVSTAT(x)	FIELD_PREP(LTC6952_INVSTAT_MSK, x)
+#define LTC6952_STAT_OUT_MSK	GENMASK(6, 0)
+#define LTC6952_STAT_OUT(x)	FIELD_PREP(LTC6952_STAT_OUT_MSK, x)
+
+/* LTC6952_REG2 */
+#define LTC6952_PDALL_MSK	BIT(7)
+#define LTC6952_PDALL(x)	FIELD_PREP(LTC6952_PDALL_MSK, x)
+#define LTC6952_PDPLL_MSK	BIT(6)
+#define LTC6952_PDPLL(x)	FIELD_PREP(LTC6952_PDPLL_MSK, x)
+#define LTC6952_PDVCOPK_MSK	BIT(5)
+#define LTC6952_PDVCOPK(x)	FIELD_PREP(LTC6952_PDVCOPK_MSK, x)
+#define LTC6952_PDREFPK_MSK	BIT(4)
+#define LTC6952_PDREFPK(x)	FIELD_PREP(LTC6952_PDREFPK_MSK, x)
+#define LTC6952_BST_MSK		BIT(3)
+#define LTC6952_BST(x)		FIELD_PREP(LTC6952_BST_MSK, x)
+#define LTC6952_FILTR_MSK	BIT(2)
+#define LTC6952_FILTR(x)	FIELD_PREP(LTC6952_FILTR_MSK, x)
+#define LTC6952_FILTV_MSK	BIT(1)
+#define LTC6952_FILTV(x)	FIELD_PREP(LTC6952_FILTV_MSK, x)
+#define LTC6952_POR_MSK		BIT(0)
+#define LTC6952_POR(x)		FIELD_PREP(LTC6952_POR_MSK, x)
+
+/* LTC6952_REG3 */
+#define LTC6952_PD3_MSK		GENMASK(7, 6)
+#define LTC6952_PD3(x)		FIELD_PREP(LTC6952_PD3_MSK, x)
+#define LTC6952_PD2_MSK		GENMASK(5, 4)
+#define LTC6952_PD2(x)		FIELD_PREP(LTC6952_PD2_MSK, x)
+#define LTC6952_PD1_MSK		GENMASK(3, 2)
+#define LTC6952_PD1(x)		FIELD_PREP(LTC6952_PD1_MSK, x)
+#define LTC6952_PD0_MSK		GENMASK(1, 0)
+#define LTC6952_PD0(x)		FIELD_PREP(LTC6952_PD0_MSK, x)
+
+/* LTC6952_REG4 */
+#define LTC6952_PD7_MSK		GENMASK(7, 6)
+#define LTC6952_PD7(x)		FIELD_PREP(LTC6952_PD7_MSK, x)
+#define LTC6952_PD6_MSK		GENMASK(5, 4)
+#define LTC6952_PD6(x)		FIELD_PREP(LTC6952_PD6_MSK, x)
+#define LTC6952_PD5_MSK		GENMASK(3, 2)
+#define LTC6952_PD5(x)		FIELD_PREP(LTC6952_PD5_MSK, x)
+#define LTC6952_PD4_MSK		GENMASK(1, 0)
+#define LTC6952_PD4(x)		FIELD_PREP(LTC6952_PD4_MSK, x)
+
+/* LTC6952_REG5 */
+#define LTC6952_TEMPO_MSK	BIT(7)
+#define LTC6952_TEMPO(x)	FIELD_PREP(LTC6952_TEMPO_MSK, x)
+#define LTC6952_PD10_MSK	GENMASK(5, 4)
+#define LTC6952_PD10(x)		FIELD_PREP(LTC6952_PD10_MSK, x)
+#define LTC6952_PD9_MSK		GENMASK(3, 2)
+#define LTC6952_PD9(x)		FIELD_PREP(LTC6952_PD9_MSK, x)
+#define LTC6952_PD8_MSK		GENMASK(1, 0)
+#define LTC6952_PD8(x)		FIELD_PREP(LTC6952_PD8_MSK, x)
+
+#define LTC6952_PD_MSK(ch)	GENMASK(((ch) & 0x03) * 2 + 1, ((ch) & 0x03) * 2)
+#define LTC6952_PD(ch, x)	((x) << ((ch) & 0x03))
+
+/* LTC6952_REG6 */
+#define LTC6952_RAO_MSK		BIT(7)
+#define LTC6952_RAO(x)		FIELD_PREP(LTC6952_RAO_MSK, x)
+#define LTC6952_PARSYNC_MSK	BIT(6)
+#define LTC6952_PARSYNC(x)	FIELD_PREP(LTC6952_PARSYNC_MSK, x)
+#define LTC6952_LKWIN_MSK	BIT(4)
+#define LTC6952_LKWIN(x)	FIELD_PREP(LTC6952_LKWIN_MSK, x)
+#define LTC6952_LKCT_MSK	GENMASK(3, 2)
+#define LTC6952_LKCT(x)		FIELD_PREP(LTC6952_LKCT_MSK, x)
+#define LTC6952_RD_HIGH_MSK	GENMASK(1, 0)
+#define LTC6952_RD_HIGH(x)	FIELD_PREP(LTC6952_RD_HIGH_MSK, x)
+
+/* LTC6952_REG7 */
+#define LTC6952_RD_LOW_MSK	GENMASK(7, 0)
+#define LTC6952_RD_LOW(x)	FIELD_PREP(LTC6952_RD_LOW_MSK, x)
+
+/* LTC6952_REG8 */
+#define LTC6952_ND_HIGH_MSK	GENMASK(7, 0)
+#define LTC6952_ND_HIGH(x)	FIELD_PREP(LTC6952_ND_HIGH_MSK, x)
+
+/* LTC6952_REG9 */
+#define LTC6952_ND_LOW_MSK	GENMASK(7, 0)
+#define LTC6952_ND_LOW(x)	FIELD_PREP(LTC6952_ND_LOW_MSK, x)
+
+/* LTC6952_REG10 */
+#define LTC6952_CPRST_MSK	BIT(7)
+#define LTC6952_CPRST(x)	FIELD_PREP(LTC6952_CPRST_MSK, x)
+#define LTC6952_CPUP_MSK	BIT(6)
+#define LTC6952_CPUP(x)		FIELD_PREP(LTC6952_CPUP_MSK, x)
+#define LTC6952_CPDN_MSK	BIT(5)
+#define LTC6952_CPDN(x)		FIELD_PREP(LTC6952_CPDN_MSK, x)
+#define LTC6952_CP_MSK		GENMASK(4, 0)
+#define LTC6952_CP(x)		FIELD_PREP(LTC6952_CP_MSK, x)
+
+/* LTC6952_REG11 */
+#define LTC6952_CPMID_MSK	BIT(7)
+#define LTC6952_CPMID(x)	FIELD_PREP(LTC6952_CPMID_MSK, x)
+#define LTC6952_CPWIDE_MSK	BIT(6)
+#define LTC6952_CPWIDE(x)	FIELD_PREP(LTC6952_CPWIDE_MSK, x)
+#define LTC6952_CPINV_MSK	BIT(5)
+#define LTC6952_CPINV(x)	FIELD_PREP(LTC6952_CPINV_MSK, x)
+#define LTC6952_EZMD_MSK	BIT(4)
+#define LTC6952_EZMD(x)		FIELD_PREP(LTC6952_EZMD_MSK, x)
+#define LTC6952_SRQMD_MSK	BIT(3)
+#define LTC6952_SRQMD(x)	FIELD_PREP(LTC6952_SRQMD_MSK, x)
+#define LTC6952_SYSCT_MSK	GENMASK(2, 1)
+#define LTC6952_SYSCT(x)	FIELD_PREP(LTC6952_SYSCT_MSK, x)
+#define LTC6952_SSRQ_MSK	BIT(0)
+#define LTC6952_SSRQ(x)		FIELD_PREP(LTC6952_SSRQ_MSK, x)
+
+/* LTC6952_REG12,16,20,24,28,32,36,40,44,48,52 */
+#define LTC6952_MP_MSK		GENMASK(7, 3)
+#define LTC6952_MP(x)		FIELD_PREP(LTC6952_MP_MSK, x)
+#define LTC6952_MD_MSK		GENMASK(2, 0)
+#define LTC6952_MD(x)		FIELD_PREP(LTC6952_MD_MSK, x)
+
+/* LTC6952_REG13,17,21,25,29,33,37,41,45,49,53 */
+#define LTC6952_SRQEN_MSK	BIT(7)
+#define LTC6952_SRQEN(x)	FIELD_PREP(LTC6952_SRQEN_MSK, x)
+#define LTC6952_MODE_MSK	GENMASK(6, 5)
+#define LTC6952_MODE(x)		FIELD_PREP(LTC6952_MODE_MSK, x)
+#define LTC6952_OINV_MSK	BIT(4)
+#define LTC6952_OINV(x)		FIELD_PREP(LTC6952_OINV_MSK, x)
+#define LTC6952_DDEL_HIGH_MSK	GENMASK(3, 0)
+#define LTC6952_DDEL_HIGH(x)	FIELD_PREP(LTC6952_DDEL_HIGH_MSK, x)
+
+/* LTC6952_REG14,18,22,26,30,34,38,42,46,50,54 */
+#define LTC6952_DDEL_LOW_MSK	GENMASK(7, 0)
+#define LTC6952_DDEL_LOW(x)	FIELD_PREP(LTC6952_DDEL_LOW_MSK, x)
+
+/* LTC6952_REG15,19,23,27,31,35,39,43,47,51,55 */
+#define LTC6952_ADEL_MSK	GENMASK(5, 0)
+#define LTC6952_ADEL(x)		FIELD_PREP(LTC6952_ADEL_MSK, x)
+
+/* LTC6952_REG56 */
+#define LTC6952_REV_MSK		GENMASK(7, 4)
+#define LTC6952_PART_MSK	GENMASK(3, 0)
+
+#define LTC6952_CMD_READ	0x1
+#define LTC6952_CMD_WRITE	0x0
+#define LTC6952_CMD_ADDR(x)	((x) << 1)
+
+#define LTC6952_NUM_CHAN	11
+
+#define LTC6952_N_MAX		65535
+#define LTC6952_R_MAX		1023
+
+#define LTC6952_PFD_FREQ_MAX	167000
+
+#define LTC6952_OUT_DIV_MIN	1
+#define LTC6952_OUT_DIV_MAX	1048576
+
+#define LTC6952_CH_OFFSET(ch)	(0x04 * (ch))
+
+struct ltc6952_output {
+	unsigned int	address;
+	struct clk_hw	hw;
+	struct iio_dev	*indio_dev;
+};
+
+struct ltc6952_chan_spec {
+	unsigned int		num;
+	unsigned int		out_divider;
+	unsigned int		mp;
+	unsigned int		md;
+	unsigned int		digital_delay;
+	unsigned int		analog_delay;
+	unsigned int		sysref_mode;
+	unsigned int		power_down_mode;
+	const char		*extended_name;
+};
+
+struct ltc6952_state {
+	struct spi_device		*spi;
+	struct mutex			lock;
+	u32				ref_freq;
+	u32				vco_freq;
+	u32				pfd_freq;
+	bool				sysref_request;
+	unsigned int			ref_divider;
+	unsigned int			vco_divider;
+	const char			*clk_out_names[LTC6952_NUM_CHAN];
+	unsigned int			num_channels;
+	struct ltc6952_chan_spec	*channels;
+	struct iio_chan_spec		iio_channels[LTC6952_NUM_CHAN];
+	struct ltc6952_output		outputs[LTC6952_NUM_CHAN];
+	struct clk			*clks[LTC6952_NUM_CHAN];
+	struct clk_onecell_data		clk_data;
+};
+
+#define to_output(_hw) container_of(_hw, struct ltc6952_output, hw)
+
+static int ltc6952_write(struct iio_dev *indio_dev,
+			 unsigned int reg,
+			 unsigned int val)
+{
+	struct ltc6952_state *st = iio_priv(indio_dev);
+	u8 buf[2];
+	u8 cmd;
+
+	cmd = LTC6952_CMD_WRITE | LTC6952_CMD_ADDR(reg);
+	buf[0] = cmd;
+	buf[1] = val;
+
+	return spi_write(st->spi, buf, ARRAY_SIZE(buf));
+}
+
+static int ltc6952_read(struct iio_dev *indio_dev,
+			unsigned int reg,
+			unsigned int *val)
+{
+	struct ltc6952_state *st = iio_priv(indio_dev);
+	u8 cmd;
+
+	cmd = LTC6952_CMD_READ | LTC6952_CMD_ADDR(reg);
+
+	return spi_write_then_read(st->spi, &cmd, 1, val, 1);
+}
+
+static int ltc6952_write_mask(struct iio_dev *indio_dev,
+				 unsigned int addr,
+				 unsigned long mask,
+				 unsigned int val)
+{
+	int readval, ret;
+
+	ret = ltc6952_read(indio_dev, addr, &readval);
+	if (ret < 0)
+		return ret;
+
+	readval &= ~mask;
+	readval |= val;
+
+	return ltc6952_write(indio_dev, addr, readval);
+}
+
+static unsigned int ltc6952_calc_out_div(unsigned long parent_rate,
+					 unsigned long rate)
+{
+	unsigned int div;
+
+	div = DIV_ROUND_CLOSEST(parent_rate, rate);
+
+	div = clamp_t(unsigned int,
+		      div,
+		      LTC6952_OUT_DIV_MIN,
+		      LTC6952_OUT_DIV_MAX);
+
+	return div;
+}
+
+static int ltc6952_calculate_divider(struct ltc6952_chan_spec *chan)
+{
+	int mp = 0, md = 0;
+	unsigned int out_divider;
+
+	/* M(x) = (MP(x) + 1)2^MD(x) */
+	chan->md = 0;
+	for (mp = 0; mp < 32; mp++) {
+		if (chan->out_divider == (mp + 1)) {
+			chan->mp = mp;
+			chan->md = 0;
+			return 0;
+		}
+
+		/* MD works only if MP is greater than 15 */
+		if (mp <= 15)
+			continue;
+		for (md = 0; md < 7; md++) {
+			out_divider = (mp + 1) << md;
+			if (chan->out_divider == out_divider) {
+				chan->mp = mp;
+				chan->md = md;
+				return 0;
+			}
+			if (chan->out_divider < out_divider)
+				break;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static struct attribute *ltc6952_attributes[] = {
+	NULL,
+};
+
+static const struct attribute_group ltc6952_attribute_group = {
+	.attrs = ltc6952_attributes,
+};
+
+static int ltc6952_get_phase(struct iio_dev *indio_dev,
+			     struct ltc6952_chan_spec *ch,
+			     unsigned int *val)
+{
+	struct ltc6952_state *st = iio_priv(indio_dev);
+	unsigned int tmp1, tmp2;
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = ltc6952_read(indio_dev, LTC6952_REG(0x0D) +
+			   LTC6952_CH_OFFSET(ch->num),
+			   &tmp1);
+	if (ret < 0)
+		goto err_unlock;
+
+	ret = ltc6952_read(indio_dev, LTC6952_REG(0x0E) +
+			   LTC6952_CH_OFFSET(ch->num),
+			   &tmp2);
+	if (ret < 0)
+		goto err_unlock;
+
+	*val = ((tmp1 & 0x0F) << 8) + (tmp2 & 0xFF);
+
+err_unlock:
+	mutex_unlock(&st->lock);
+	return ret;
+}
+
+static int ltc6952_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val,
+			    int *val2,
+			    long mask)
+{
+	struct ltc6952_state *st = iio_priv(indio_dev);
+	struct ltc6952_chan_spec *ch;
+	unsigned int tmp, code;
+	int ret;
+
+	if (chan->address >= LTC6952_NUM_CHAN)
+		return -EINVAL;
+
+	ch = &st->channels[chan->address];
+
+	switch (mask) {
+	case IIO_CHAN_INFO_FREQUENCY:
+		*val = st->vco_freq / ch->out_divider;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_PHASE:
+		ret = ltc6952_get_phase(indio_dev, ch, &tmp);
+		if (ret < 0)
+			return ret;
+
+		code = DIV_ROUND_CLOSEST(tmp * 3141592,
+					 ch->out_divider);
+		*val = code / 1000000;
+		*val2 = code % 1000000;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+};
+
+static int ltc6952_set_phase(struct iio_dev *indio_dev,
+			     struct ltc6952_chan_spec *ch,
+			     unsigned int val)
+{
+	struct ltc6952_state *st = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = ltc6952_write_mask(indio_dev, LTC6952_REG(0x0D) +
+				 LTC6952_CH_OFFSET(ch->num),
+				 LTC6952_DDEL_HIGH_MSK,
+				 LTC6952_DDEL_HIGH((val & 0xF00) >> 8));
+	if (ret < 0)
+		goto err_unlock;
+
+	ret = ltc6952_write(indio_dev, LTC6952_REG(0x0E) +
+			    LTC6952_CH_OFFSET(ch->num),
+			    LTC6952_DDEL_LOW(val));
+	if (ret < 0)
+		goto err_unlock;
+
+	/* Phase Syncronization */
+	ret = ltc6952_write_mask(indio_dev, LTC6952_REG(0x0B),
+				 LTC6952_SSRQ_MSK, LTC6952_SSRQ(1));
+	if (ret < 0)
+		goto err_unlock;
+
+	usleep_range(1000, 1001); /* sleep > 1000us */
+	ret = ltc6952_write_mask(indio_dev, LTC6952_REG(0x0B),
+				 LTC6952_SSRQ_MSK, LTC6952_SSRQ(0));
+err_unlock:
+	mutex_unlock(&st->lock);
+	return ret;
+}
+
+static int ltc6952_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val,
+			     int val2,
+			     long mask)
+{
+	struct ltc6952_state *st = iio_priv(indio_dev);
+	struct ltc6952_chan_spec *ch;
+	unsigned int code, tmp;
+	int ret;
+
+	if (chan->address >= st->num_channels)
+		return -EINVAL;
+
+	ch = &st->channels[chan->address];
+
+	switch (mask) {
+	case IIO_CHAN_INFO_FREQUENCY:
+		ch->out_divider = ltc6952_calc_out_div(st->vco_freq, val);
+		ret = ltc6952_calculate_divider(ch);
+		if (ret < 0)
+			return ret;
+
+		mutex_lock(&st->lock);
+		tmp = LTC6952_MP(ch->mp) | LTC6952_MD(ch->md);
+		ret = ltc6952_write(indio_dev, LTC6952_REG(0x0C) +
+			      LTC6952_CH_OFFSET(ch->num),
+			      tmp);
+		mutex_unlock(&st->lock);
+		if (ret < 0)
+			return ret;
+		break;
+	case IIO_CHAN_INFO_PHASE:
+		code = val * 1000000 + val2 % 1000000;
+		tmp = DIV_ROUND_CLOSEST(code * ch->out_divider, 3141592);
+		tmp = clamp_t(unsigned int, tmp, 0, 4095);
+		ret = ltc6952_set_phase(indio_dev, ch, tmp);
+		if (ret < 0)
+			return ret;
+
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ltc6952_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			      unsigned int writeval, unsigned int *readval)
+{
+	struct ltc6952_state *st = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&st->lock);
+	if (readval)
+		ret = ltc6952_read(indio_dev, reg, readval);
+	else
+		ret = ltc6952_write(indio_dev, reg, writeval);
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static const struct iio_info ltc6952_iio_info = {
+	.read_raw = &ltc6952_read_raw,
+	.write_raw = &ltc6952_write_raw,
+	.debugfs_reg_access = &ltc6952_reg_access,
+	.attrs = &ltc6952_attribute_group,
+};
+
+static long ltc6952_get_clk_attr(struct clk_hw *hw,
+				 long mask)
+{
+	struct iio_dev *indio_dev = to_output(hw)->indio_dev;
+	struct ltc6952_state *st = iio_priv(indio_dev);
+	struct iio_chan_spec *chan;
+	unsigned int address;
+	int val, ret;
+
+	address = to_output(hw)->address;
+	if (address >= st->num_channels)
+		return -EINVAL;
+
+	chan = &st->iio_channels[address];
+
+	ret = ltc6952_read_raw(indio_dev, chan, &val, NULL, mask);
+
+	if (ret == IIO_VAL_INT)
+		return val;
+
+	return ret;
+}
+
+static long ltc6952_set_clk_attr(struct clk_hw *hw,
+				 long mask,
+				 unsigned long val)
+{
+	struct iio_dev *indio_dev = to_output(hw)->indio_dev;
+	struct ltc6952_state *st = iio_priv(indio_dev);
+	struct iio_chan_spec *chan;
+	unsigned int address;
+
+	address = to_output(hw)->address;
+	if (address >= st->num_channels)
+		return -EINVAL;
+
+	chan = &st->iio_channels[address];
+
+	return ltc6952_write_raw(indio_dev, chan, val, 0, mask);
+}
+
+static unsigned long ltc6952_clk_recalc_rate(struct clk_hw *hw,
+					     unsigned long parent_rate)
+{
+	return ltc6952_get_clk_attr(hw, IIO_CHAN_INFO_FREQUENCY);
+}
+
+static long ltc6952_clk_round_rate(struct clk_hw *hw,
+				   unsigned long rate,
+				   unsigned long *parent_rate)
+{
+	struct ltc6952_output *out = to_output(hw);
+	struct iio_dev *indio_dev = out->indio_dev;
+	struct ltc6952_state *st = iio_priv(indio_dev);
+	unsigned int div;
+
+	div = ltc6952_calc_out_div(st->vco_freq, rate);
+
+	return DIV_ROUND_CLOSEST(st->vco_freq, div);
+}
+
+static int ltc6952_clk_set_rate(struct clk_hw *hw,
+				unsigned long rate,
+				unsigned long parent_rate)
+{
+	return ltc6952_set_clk_attr(hw, IIO_CHAN_INFO_FREQUENCY, rate);
+}
+
+static const struct clk_ops ltc6952_clk_ops = {
+	.recalc_rate = ltc6952_clk_recalc_rate,
+	.round_rate = ltc6952_clk_round_rate,
+	.set_rate = ltc6952_clk_set_rate,
+};
+
+static int ltc6952_clk_register(struct iio_dev *indio_dev,
+				unsigned int num,
+				unsigned int address)
+{
+	struct ltc6952_state *st = iio_priv(indio_dev);
+	struct clk_init_data init;
+	struct clk *clk;
+
+	init.name = st->clk_out_names[num];
+	init.ops = &ltc6952_clk_ops;
+	init.flags = 0;
+	init.num_parents = 0;
+
+	st->outputs[num].hw.init = &init;
+	st->outputs[num].indio_dev = indio_dev;
+	st->outputs[num].address = address;
+
+	clk = devm_clk_register(&st->spi->dev, &st->outputs[num].hw);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	st->clks[num] = clk;
+
+	return 0;
+}
+
+static int ltc6952_setup(struct iio_dev *indio_dev)
+{
+	struct ltc6952_state *st = iio_priv(indio_dev);
+	struct ltc6952_chan_spec *chan;
+	unsigned long vco_freq, ref_freq;
+	unsigned long pfd_freq;
+	unsigned long n, r;
+	unsigned int i, tmp;
+	int ret;
+
+	vco_freq = st->vco_freq / 1000;
+	ref_freq = st->ref_freq / 1000;
+
+	/* fVCO / N = fREF / R */
+	rational_best_approximation(vco_freq, ref_freq,
+				    LTC6952_N_MAX, LTC6952_R_MAX,
+				    &n, &r);
+
+	pfd_freq = vco_freq / n;
+	while ((pfd_freq > LTC6952_PFD_FREQ_MAX) &&
+	       (n <= LTC6952_N_MAX / 2) &&
+	       (r <= LTC6952_R_MAX / 2)) {
+		pfd_freq /= 2;
+		n *= 2;
+		r *= 2;
+	}
+
+	mutex_lock(&st->lock);
+	/* Resets all registers to default values */
+	ret = ltc6952_write_mask(indio_dev, LTC6952_REG(0x02),
+				 LTC6952_POR_MSK, LTC6952_POR(1));
+	if (ret < 0)
+		goto err_unlock;
+
+	/* Program the dividers */
+	ret |= ltc6952_write_mask(indio_dev, LTC6952_REG(0x06),
+				  LTC6952_RD_HIGH_MSK,
+				  LTC6952_RD_HIGH((r & 0x300) >> 8));
+	ret |= ltc6952_write(indio_dev, LTC6952_REG(0x07), LTC6952_RD_LOW(r));
+	ret |= ltc6952_write(indio_dev, LTC6952_REG(0x08),
+			     LTC6952_ND_HIGH(n >> 8));
+	ret |= ltc6952_write(indio_dev, LTC6952_REG(0x09), LTC6952_ND_LOW(n));
+	if (ret < 0)
+		goto err_unlock;
+
+	/* PLL lock cycle count  */
+	ret = ltc6952_write_mask(indio_dev, LTC6952_REG(0x06), LTC6952_LKCT_MSK,
+				 LTC6952_LKCT(0x03));
+	if (ret < 0)
+		goto err_unlock;
+
+	/* Disable CP Hi-Z */
+	ret = ltc6952_write_mask(indio_dev, LTC6952_REG(0x0A), LTC6952_CPRST_MSK,
+				 LTC6952_CPRST(0x0));
+	if (ret < 0)
+		goto err_unlock;
+
+	/* Program the output channels */
+	for (i = 0; i < st->num_channels; i++) {
+		chan = &st->channels[i];
+
+		if (chan->num >= LTC6952_NUM_CHAN)
+			continue;
+
+		/* Enable channel */
+		tmp = LTC6952_PD(i, 0);
+		ret |= ltc6952_write_mask(indio_dev,
+					  LTC6952_REG(0x03) + (chan->num >> 2),
+					  LTC6952_PD_MSK(chan->num), tmp);
+
+		ret |= ltc6952_calculate_divider(chan);
+		ret |= ltc6952_write(indio_dev, LTC6952_REG(0x0c) +
+				     LTC6952_CH_OFFSET(chan->num),
+				     LTC6952_MP(chan->mp) | LTC6952_MD(chan->md));
+
+		/* Enable sync or sysref */
+		ret |= ltc6952_write_mask(indio_dev, LTC6952_REG(0x0D) +
+					  LTC6952_CH_OFFSET(chan->num),
+					  LTC6952_SRQEN_MSK,
+					  LTC6952_SRQEN(1));
+
+		/* Set channel delay */
+		ret |= ltc6952_write_mask(indio_dev, LTC6952_REG(0x0D) +
+					  LTC6952_CH_OFFSET(chan->num),
+					  LTC6952_DDEL_HIGH_MSK,
+					  LTC6952_DDEL_HIGH((chan->digital_delay &
+							     0xF00) >> 8));
+		ret |= ltc6952_write(indio_dev, LTC6952_REG(0x0E) +
+				     LTC6952_CH_OFFSET(chan->num),
+				     LTC6952_DDEL_LOW(chan->digital_delay));
+		ret |= ltc6952_write(indio_dev, LTC6952_REG(0x0F) +
+				     LTC6952_CH_OFFSET(chan->num),
+				     LTC6952_ADEL(chan->analog_delay));
+		if (ret < 0)
+			goto err_unlock;
+
+		st->iio_channels[i].type = IIO_ALTVOLTAGE;
+		st->iio_channels[i].output = 1;
+		st->iio_channels[i].indexed = 1;
+		st->iio_channels[i].channel = chan->num;
+		st->iio_channels[i].address = i;
+		st->iio_channels[i].extend_name = chan->extended_name;
+		st->iio_channels[i].info_mask_separate =
+			BIT(IIO_CHAN_INFO_FREQUENCY) |
+			BIT(IIO_CHAN_INFO_PHASE);
+	}
+
+	/* Phase Syncronization */
+	ret |= ltc6952_write_mask(indio_dev, LTC6952_REG(0x0B),
+				  LTC6952_SSRQ_MSK, LTC6952_SSRQ(1));
+	usleep_range(1000, 1001); /* sleep > 1000us */
+	ret |= ltc6952_write_mask(indio_dev, LTC6952_REG(0x0B),
+				  LTC6952_SSRQ_MSK, LTC6952_SSRQ(0));
+	if (ret < 0)
+		goto err_unlock;
+
+	mutex_unlock(&st->lock);
+
+	/* Configure clocks */
+	for (i = 0; i < st->num_channels; i++) {
+		chan = &st->channels[i];
+
+		if (chan->num >= LTC6952_NUM_CHAN)
+			continue;
+
+		ret = ltc6952_clk_register(indio_dev, chan->num, i);
+		if (ret)
+			return ret;
+	}
+
+	st->clk_data.clks = st->clks;
+	st->clk_data.clk_num = LTC6952_NUM_CHAN;
+
+	return of_clk_add_provider(st->spi->dev.of_node,
+				   of_clk_src_onecell_get,
+				   &st->clk_data);
+err_unlock:
+	mutex_unlock(&st->lock);
+	return ret;
+}
+
+static int ltc6952_parse_dt(struct device *dev,
+			    struct ltc6952_state *st)
+{
+	struct device_node *np = dev->of_node, *chan_np;
+	unsigned int cnt = 0;
+	int ret;
+
+	ret = of_property_read_u32(np, "adi,ref-frequency-hz",
+			     &st->ref_freq);
+	if (ret < 0)
+		return ret;
+
+	ret = of_property_read_u32(np, "adi,vco-frequency-hz",
+				   &st->vco_freq);
+	if (ret < 0)
+		return ret;
+
+	ret = of_property_read_string_array(np, "clock-output-names",
+			st->clk_out_names, ARRAY_SIZE(st->clk_out_names));
+	if (ret < 0)
+		return ret;
+
+	st->num_channels = of_get_available_child_count(np);
+	if (st->num_channels > LTC6952_NUM_CHAN)
+		return -EINVAL;
+
+	st->channels = devm_kzalloc(dev,
+		sizeof(struct ltc6952_chan_spec) * st->num_channels,
+				     GFP_KERNEL);
+	if (!st->channels)
+		return -ENOMEM;
+
+	for_each_child_of_node(np, chan_np) {
+		st->channels[cnt].num = cnt;
+		of_property_read_u32(chan_np, "reg",
+				     &st->channels[cnt].num);
+
+		if (of_property_read_u32(chan_np, "adi,divider",
+					 &st->channels[cnt].out_divider))
+			st->channels[cnt].out_divider = 4;
+
+		of_property_read_u32(chan_np, "adi,digital-delay",
+				     &st->channels[cnt].digital_delay);
+
+		of_property_read_u32(chan_np, "adi,analog-delay",
+				     &st->channels[cnt].analog_delay);
+
+		of_property_read_string(chan_np, "adi,extended-name",
+					&st->channels[cnt].extended_name);
+
+		cnt++;
+	}
+
+	return 0;
+}
+
+static int ltc6952_status_show(struct seq_file *file, void *offset)
+{
+	struct iio_dev *indio_dev = spi_get_drvdata(file->private);
+	int ret;
+	u32 status;
+
+	ret = ltc6952_read(indio_dev, 0x00, &status);
+	if (ret < 0)
+		return ret;
+
+	seq_printf(file,
+		   "SYSREF Status:\t%s\nVCO Status:\t%s\nLock Status:\t%s\n",
+		   status & LTC6952_REFOK_MSK ?
+		   "Valid" : "Invalid",
+		   status & LTC6952_VCOOK_MSK ?
+		   "Valid" : "Invalid",
+		   status & LTC6952_LOCK_MSK ?
+		   "PLL Locked" : "Unlocked");
+
+	return 0;
+}
+
+static int ltc6952_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct ltc6952_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+
+	mutex_init(&st->lock);
+
+	spi_set_drvdata(spi, indio_dev);
+
+	st->spi = spi;
+
+	ret = ltc6952_parse_dt(&spi->dev, st);
+	if (ret < 0)
+		return ret;
+
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->info = &ltc6952_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = st->iio_channels;
+	indio_dev->num_channels = st->num_channels;
+
+	ret = ltc6952_setup(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = iio_device_register(indio_dev);
+	if (ret < 0) {
+		of_clk_del_provider(spi->dev.of_node);
+		return ret;
+	}
+
+	if (iio_get_debugfs_dentry(indio_dev)) {
+		struct dentry *stats;
+
+		stats = debugfs_create_devm_seqfile(&spi->dev, "status",
+						    iio_get_debugfs_dentry(indio_dev),
+						    ltc6952_status_show);
+		if (PTR_ERR_OR_ZERO(stats))
+			dev_err(&spi->dev,
+				"Failed to create debugfs entry");
+	}
+
+	return ret;
+}
+
+static int ltc6952_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+
+	iio_device_unregister(indio_dev);
+
+	of_clk_del_provider(spi->dev.of_node);
+
+	return 0;
+}
+
+static const struct spi_device_id ltc6952_id[] = {
+	{"ltc6952", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ltc6952_id);
+
+static const struct of_device_id ltc6952_of_match[] = {
+	{ .compatible = "adi,ltc6952" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ltc6952_of_match);
+
+static struct spi_driver ltc6952_driver = {
+	.driver = {
+		.name = "ltc6952",
+		.of_match_table = ltc6952_of_match,
+	},
+	.probe = ltc6952_probe,
+	.remove = ltc6952_remove,
+	.id_table = ltc6952_id,
+};
+module_spi_driver(ltc6952_driver);
+
+MODULE_AUTHOR("Mircea Caprioru <mircea.caprioru@analog.com>");
+MODULE_DESCRIPTION("Analog Devices LTC6952 driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

