Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10A123FDAD
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 12:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgHIKZ6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 06:25:58 -0400
Received: from mail-dm6nam10on2065.outbound.protection.outlook.com ([40.107.93.65]:19265
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725710AbgHIKZ4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 06:25:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FT65AmuW+9Q/jA1bP0k9zOcqt6njw/XRNZXdBBuFaGZFdwwjnHCvfllunG3tm+vxibx/TKWF8NyD2KVe+8fT95AjvqR//VP6heGqHCLU6DiEw4If/uZXAB1GHKL5FpOKPY4HkyldYpBZVL7/UCBX2J+bWBEM3+afKc6KREerFUKYoV80WKeBeu6acXbaadlGBiRk0W4OAE3ybyR56zaTajBFyWRYTkKlmrI+nFwJwMEXkw9WpZlT7UulGBBh7aKANQYssV1zugGbMV92Nb+o+oG5dZf0YKWn6Gy2pUgtN2aEtVSkUnI6zBuW0yPRByzoyFiysqE50fshPMs5dJWBmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8dU3z61Iy6X899/NAsuxT7KDLYMAyQup3I+BMlmaNI=;
 b=jwuZDgSwYDKDMlJclL+gvKu9eKR5e1BhcBFDF5JPhCNr4NOrWbyCo8dfvHHckaO7LmdTlyDdEVgLwHBViyQ8/EvScpnh2ECxR1gffPQjZcLR0BvxyzL187vBmS4fm8UB23qRdrw7hoxIIsWFiCkrQL5EM3QRZ2zkprJvTHVnLuxa0zr3fDX0oG1nIAkadKsL0Rk5/RFHkmZL50IorcI9ECn1QOUJiBb3GC96ElqvSt9mvyTQ1up8AlUYJkdeQxzP7Fqn0YA10fvfGm8AItVVWADJVJUpCwDfwESuloD8y9e4gvU92RK6h9NXxV69EbLBDhAy1Qpz8wlDf/LnIMReEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8dU3z61Iy6X899/NAsuxT7KDLYMAyQup3I+BMlmaNI=;
 b=Rxy739oLGXZoluROjZEEIFz02g6p04grNYedJtswyEdBq4qMlp/qvzi70XKCI2QItnyMpjNgBkMD3zaWewFmA9GNHv0du4aL9GxK7hFPe86UWuPKqS128Xukr/PhcDzJG9W0cxj5rhGuuf1xnCO/koq5TQuOJA0XBCkNDodz78w=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2726.namprd12.prod.outlook.com (2603:10b6:a03:66::17)
 by BY5PR12MB3778.namprd12.prod.outlook.com (2603:10b6:a03:1a6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Sun, 9 Aug
 2020 10:25:50 +0000
Received: from BYAPR12MB2726.namprd12.prod.outlook.com
 ([fe80::8503:3713:6ed0:af09]) by BYAPR12MB2726.namprd12.prod.outlook.com
 ([fe80::8503:3713:6ed0:af09%6]) with mapi id 15.20.3261.022; Sun, 9 Aug 2020
 10:25:50 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com, andy.shevchenko@gmail.com,
        mail@richard-neumann.de, m.felsch@pengutronix.de
Cc:     Shyam-sundar.S-k@amd.com, Sandeep Singh <sandeep.singh@amd.com>
Subject: [PATCH v6 2/4] SFH: PCIe driver to add support of AMD sensor fusion
Date:   Sun,  9 Aug 2020 10:25:09 +0000
Message-Id: <20200809102511.2657644-3-Sandeep.Singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200809102511.2657644-1-Sandeep.Singh@amd.com>
References: <20200809102511.2657644-1-Sandeep.Singh@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR0101CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::30) To BYAPR12MB2726.namprd12.prod.outlook.com
 (2603:10b6:a03:66::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jatayu.amd.com (165.204.156.251) by MA1PR0101CA0044.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19 via Frontend Transport; Sun, 9 Aug 2020 10:25:46 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9e747ddb-02a8-459e-d749-08d83c4e9640
X-MS-TrafficTypeDiagnostic: BY5PR12MB3778:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB37784CDA04E04207A07ED4DCE0470@BY5PR12MB3778.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +plf+LcRDMLMz1K+XvGp+LfpaqmYC0DGY+d/tlzDP9NLN4Si4UC22MqdHR4wjRocRjrWTtbnHLrSUaCqh3le2anNxo5zkgnWVCtQ8n47AqKxWVRH4lV6w3QD5cUjncbNCRC/WTlaHh/Q9Th//60MDD2XTp61ewGSBFOV8GAwby6eX/H0dycYBjc0fMAGsD8I734C/lXTXncC56rDQo00pTsRgBS1Fk4KINh3L4FY6ouk/rOWwVY8OzKWrXvyqUS7Z9Rp8AKn1JG2lE0j9pxjN3oieS+AvM8x/l4rKKrr6G9dR8Oi71uQa6U2qIT8omYBYMNX38TIpkIWD7jUIZEAm4XZ9WTZpHO8phXCEW2d2QGELfHJPV1UGHrvseNHfEuM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39850400004)(1076003)(7416002)(956004)(5660300002)(83380400001)(2616005)(66556008)(66476007)(16526019)(6486002)(66946007)(26005)(186003)(7696005)(8676002)(8936002)(36756003)(316002)(2906002)(6666004)(86362001)(478600001)(4326008)(52116002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: XcjTyW5x7D39gW32qNO52kWInmmKjJ96T9K/ZATW8TrZIrDZi0EN9g3IK8TRQy+tTYEYUhtaTVbYCgUC0XUS6WYpPNKvDd8KSqiQRuGtZqd1sJWPJhGBUAUGjNi/Tk5LazQXGYibe7JPcX4B8OZ/nm0W1w9zrb5q6NCO0G3Ng5QGs5XePjiHwD/AvwC5dhnC/ZkS9tNKoHeLKt/JxE5bxAWg/OwNRgy56r97eziah90xUxsLccYNEaTBWCYzXN69DNA/gPE+y4jyskemT3xq9J6xZdB8XqKTwOLqa2rnDfgAxcGe0szbzcq6Z/GiAZQ0bLx/w1SawYPLoy3gPRWkE3O6Dg4WYduF2fkCUUeXPl9OKtOC8NHRHLc65KEkB09QYoP046tjBKKK5r/BX3oFxKiNdMLQaGsYaEgzChlI46RjlfNnM4E5oFFWJOddiZXC41CormuiaXbVTB4YH2bMEyiLw8pa7EQkZWaJSzxC72ROCT96Zf4aicYSKxme+nrZa6uBmYo/FIpT1ioBToQ5d4EW1wZwqSPlloXbn4XZJYOAbfyNIAwG8rpJ99ZwNnVIRWh5J2HTjq1qmBOKdkkd/j440VGCo6FfMjzc7PErrixBpjIUt7DVVJ1AFmzbIWHOu+YxVZ8vjtSmBlsDG0UIAw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e747ddb-02a8-459e-d749-08d83c4e9640
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2020 10:25:50.0591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: afyuB1peSueVvD/oiK/KPzzxt15rmwKIc548cjx0evEGAXCbRNkh4L7BWPeH7cCE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3778
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Sandeep Singh <sandeep.singh@amd.com>

AMD SFH uses HID over PCIe bus.SFH fw is part of MP2 processor
(MP2 which is an ARM® Cortex-M4 core based co-processor to x86) and
it runs on MP2 where in driver resides on X86. This part of module
will communicate with MP2 FW and provide that data into DRAM

Signed-off-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
---
 drivers/hid/Kconfig                    |   2 +
 drivers/hid/Makefile                   |   2 +
 drivers/hid/amd-sfh-hid/Kconfig        |  21 ++++
 drivers/hid/amd-sfh-hid/Makefile       |  15 +++
 drivers/hid/amd-sfh-hid/amd_mp2_pcie.c | 162 +++++++++++++++++++++++++
 drivers/hid/amd-sfh-hid/amd_mp2_pcie.h |  83 +++++++++++++
 6 files changed, 285 insertions(+)
 create mode 100644 drivers/hid/amd-sfh-hid/Kconfig
 create mode 100644 drivers/hid/amd-sfh-hid/Makefile
 create mode 100644 drivers/hid/amd-sfh-hid/amd_mp2_pcie.c
 create mode 100644 drivers/hid/amd-sfh-hid/amd_mp2_pcie.h

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 45e87dc59d4e..c0a1c07ed6b1 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1174,4 +1174,6 @@ source "drivers/hid/i2c-hid/Kconfig"
 
 source "drivers/hid/intel-ish-hid/Kconfig"
 
+source "drivers/hid/amd-sfh-hid/Kconfig"
+
 endmenu
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index d8ea4b8c95af..7d8ca4e34572 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -141,3 +141,5 @@ obj-$(CONFIG_I2C_HID)		+= i2c-hid/
 
 obj-$(CONFIG_INTEL_ISH_HID)	+= intel-ish-hid/
 obj-$(INTEL_ISH_FIRMWARE_DOWNLOADER)	+= intel-ish-hid/
+
+obj-$(CONFIG_AMD_SFH_HID)       += amd-sfh-hid/
diff --git a/drivers/hid/amd-sfh-hid/Kconfig b/drivers/hid/amd-sfh-hid/Kconfig
new file mode 100644
index 000000000000..e73cf9fe1324
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+menu "AMD SFH HID support"
+	depends on X86_64 || COMPILE_TEST
+	depends on PCI
+
+config AMD_SFH_HID
+	tristate "AMD Sensor Fusion Hub"
+	select HID
+	help
+	If you say yes to this option, support will be included for the AMD
+	Sensor Fusion Hub.
+	This driver will enable sensors functionality to user through HID
+	framework. Basically this driver will get data from MP2 FW
+	and provide that data to HID framework.
+	MP2 which is an ARM® Cortex-M4 core based co-processor to x86.
+
+	This driver can also be built as modules. If so, the modules will
+	be  called amd-sfhtp-hid.
+	Say Y or M here if you want to support AMD SFH. If unsure, say N.
+
+endmenu
diff --git a/drivers/hid/amd-sfh-hid/Makefile b/drivers/hid/amd-sfh-hid/Makefile
new file mode 100644
index 000000000000..a163c7f62b32
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Makefile - AMD SFH HID drivers
+# Copyright (c) 2019-2020, Advanced Micro Devices, Inc.
+#
+#
+
+ccflags-m := -Werror
+   obj-$(CONFIG_AMD_SFH_HID) +=amd-sfhtp-hid.o
+   amd-sfhtp-hid-objs := amdsfh_hid.o
+   amd-sfhtp-hid-objs+= amdsfh_hid_client.o
+   amd-sfhtp-hid-objs+= amd_mp2_pcie.o
+   amd-sfhtp-hid-objs+= hid_descriptor/amd_sfh_hid_descriptor.o
+
+ccflags-y += -I$(srctree)/$(src)/
diff --git a/drivers/hid/amd-sfh-hid/amd_mp2_pcie.c b/drivers/hid/amd-sfh-hid/amd_mp2_pcie.c
new file mode 100644
index 000000000000..cdd480c287db
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/amd_mp2_pcie.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD MP2 PCIe communication driver
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Authors: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
+ *	    Sandeep Singh <Sandeep.singh@amd.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/types.h>
+#include "amd_mp2_pcie.h"
+
+#define DRIVER_NAME	"pcie_mp2_amd"
+#define DRIVER_DESC	"AMD(R) PCIe MP2 Communication Driver"
+
+#define ACEL_EN		BIT(accel_idx)
+#define GYRO_EN		BIT(gyro_idx)
+#define MAGNO_EN	BIT(mag_idx)
+#define ALS_EN		BIT(als_idx)
+
+void amd_start_sensor(struct amd_mp2_dev *privdata, struct amd_mp2_sensor_info info)
+{
+	union sfh_cmd_param cmd_param;
+	union sfh_cmd_base cmd_base;
+
+	/* fill up command register */
+	cmd_base.ul = 0;
+	cmd_base.s.cmd_id = enable_sensor;
+	cmd_base.s.period = info.period;
+	cmd_base.s.sensor_id = info.sensor_idx;
+
+	/* fill up command param register */
+	cmd_param.ul = 0;
+	cmd_param.s.buf_layout = 1;
+	cmd_param.s.buf_length = 16;
+
+	writeq(info.phys_address, privdata->mmio + AMD_C2P_MSG2);
+	writel(cmd_param.ul, privdata->mmio + AMD_C2P_MSG1);
+	writel(cmd_base.ul, privdata->mmio + AMD_C2P_MSG0);
+}
+
+void amd_stop_sensor(struct amd_mp2_dev *privdata, u16 sensor_idx)
+{
+	union sfh_cmd_base cmd_base;
+
+	/* fill up command register */
+	cmd_base.ul = 0;
+	cmd_base.s.cmd_id = disable_sensor;
+	cmd_base.s.period = 0;
+	cmd_base.s.sensor_id = sensor_idx;
+
+	writeq(0x0, privdata->mmio + AMD_C2P_MSG2);
+	writel(cmd_base.ul, privdata->mmio + AMD_C2P_MSG0);
+}
+
+void amd_stop_all_sensors(struct amd_mp2_dev *privdata)
+{
+	union sfh_cmd_base cmd_base;
+
+	/* fill up command register */
+	cmd_base.ul = 0;
+	cmd_base.s.cmd_id = stop_all_sensors;
+	cmd_base.s.period = 0;
+	cmd_base.s.sensor_id = 0;
+
+	writel(cmd_base.ul, privdata->mmio + AMD_C2P_MSG0);
+}
+
+int amd_mp2_get_sensor_num(struct amd_mp2_dev *privdata, u8 *sensor_id)
+{
+	int activestatus, num_of_sensors = 0;
+
+	if (!sensor_id)
+		return -EINVAL;
+
+	privdata->activecontrolstatus = readl(privdata->mmio + AMD_P2C_MSG3);
+	activestatus = privdata->activecontrolstatus >> 4;
+	if (ACEL_EN  & activestatus)
+		sensor_id[num_of_sensors++] = accel_idx;
+
+	if (GYRO_EN & activestatus)
+		sensor_id[num_of_sensors++] = gyro_idx;
+
+	if (MAGNO_EN & activestatus)
+		sensor_id[num_of_sensors++] = mag_idx;
+
+	if (ALS_EN & activestatus)
+		sensor_id[num_of_sensors++] = als_idx;
+
+	return num_of_sensors;
+}
+
+static int amd_mp2_pci_init(struct amd_mp2_dev *privdata, struct pci_dev *pdev)
+{
+	int rc;
+
+	pci_set_drvdata(pdev, privdata);
+	pcim_enable_device(pdev);
+	pcim_iomap_regions(pdev, BIT(2), DRIVER_NAME);
+
+	privdata->mmio = pcim_iomap_table(pdev)[2];
+	pci_set_master(pdev);
+
+	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
+	if (rc)
+		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+	return rc;
+}
+
+static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct amd_mp2_dev *privdata;
+	int rc;
+
+	privdata = devm_kzalloc(&pdev->dev, sizeof(*privdata), GFP_KERNEL);
+	if (!privdata)
+		return -ENOMEM;
+	privdata->pdev = pdev;
+	rc = amd_mp2_pci_init(privdata, pdev);
+	if (rc)
+		return rc;
+	rc = amd_sfh_hid_client_init(privdata);
+	if (rc)
+		return rc;
+	return 0;
+}
+
+static void amd_mp2_pci_remove(struct pci_dev *pdev)
+{
+	struct amd_mp2_dev *privdata = pci_get_drvdata(pdev);
+
+	amd_sfh_hid_client_deinit(privdata);
+	amd_stop_all_sensors(privdata);
+}
+
+static const struct pci_device_id amd_mp2_pci_tbl[] = {
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_MP2) },
+	{},
+};
+MODULE_DEVICE_TABLE(pci, amd_mp2_pci_tbl);
+
+static struct pci_driver amd_mp2_pci_driver = {
+	.name		= DRIVER_NAME,
+	.id_table	= amd_mp2_pci_tbl,
+	.probe		= amd_mp2_pci_probe,
+	.remove		= amd_mp2_pci_remove,
+};
+module_pci_driver(amd_mp2_pci_driver);
+
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_AUTHOR("Shyam Sundar S K <Shyam-sundar.S-k@amd.com>");
+MODULE_AUTHOR("Sandeep Singh <Sandeep.singh@amd.com>");
diff --git a/drivers/hid/amd-sfh-hid/amd_mp2_pcie.h b/drivers/hid/amd-sfh-hid/amd_mp2_pcie.h
new file mode 100644
index 000000000000..a4ef604c4fe8
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/amd_mp2_pcie.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * AMD MP2 PCIe communication driver
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ * Authors: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
+ *	    Sandeep Singh <Sandeep.singh@amd.com>
+ */
+
+#ifndef PCIE_MP2_AMD_H
+#define PCIE_MP2_AMD_H
+
+#include <linux/pci.h>
+#include <linux/types.h>
+
+#define PCI_DEVICE_ID_AMD_MP2	0x15E4
+
+/* MP2 C2P Message Registers */
+#define AMD_C2P_MSG0	0x10500
+#define AMD_C2P_MSG1	0x10504
+#define AMD_C2P_MSG2	0x10508
+
+/* MP2 P2C Message Registers */
+#define AMD_P2C_MSG3	0x1068C /* Supported Sensors info */
+
+/* SFH Command register */
+union sfh_cmd_base {
+	u32 ul;
+	struct {
+		u32 cmd_id : 8;
+		u32 sensor_id : 8;
+		u32 period : 16;
+	} s;
+};
+
+union sfh_cmd_param {
+	u32 ul;
+	struct {
+		u32 buf_layout : 2;
+		u32 buf_length : 6;
+		u32 rsvd : 24;
+	} s;
+};
+
+struct sfh_cmd_reg {
+	union sfh_cmd_base cmd_base;
+	union sfh_cmd_param cmd_param;
+	phys_addr_t phys_addr;
+};
+
+enum command_id {
+	enable_sensor = 1,
+	disable_sensor = 2,
+	stop_all_sensors = 8,
+	invalid_cmd = 0xf
+};
+
+enum sensor_idx {
+	accel_idx = 0,
+	gyro_idx = 1,
+	mag_idx = 2,
+	als_idx = 19
+};
+
+struct amd_mp2_dev {
+	struct pci_dev *pdev;
+	struct amdtp_cl_data *cl_data;
+	void __iomem *mmio;
+	u32 activecontrolstatus;
+};
+
+struct amd_mp2_sensor_info {
+	u8 sensor_idx;
+	u32 period;
+	phys_addr_t phys_address;
+};
+
+void amd_start_sensor(struct amd_mp2_dev *privdata, struct amd_mp2_sensor_info info);
+void amd_stop_sensor(struct amd_mp2_dev *privdata, u16 sensor_idx);
+void amd_stop_all_sensors(struct amd_mp2_dev *privdata);
+int amd_mp2_get_sensor_num(struct amd_mp2_dev *privdata, u8 *sensor_id);
+int amd_sfh_hid_client_init(struct amd_mp2_dev *privdata);
+int amd_sfh_hid_client_deinit(struct amd_mp2_dev *privdata);
+#endif
-- 
2.25.1

