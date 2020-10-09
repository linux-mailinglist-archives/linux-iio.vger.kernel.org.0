Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABE9289725
	for <lists+linux-iio@lfdr.de>; Fri,  9 Oct 2020 22:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732646AbgJIUCi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Oct 2020 16:02:38 -0400
Received: from mail-eopbgr690078.outbound.protection.outlook.com ([40.107.69.78]:9094
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731118AbgJIUCa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 9 Oct 2020 16:02:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVCDL+0gxdji+OZHxwB6b20xFjS1QW6sipW8Btoc3Vs0B6MnnyJli+MkIumttd5F0NS4UDnn+GqAvvtDLz/GYn+iYzgJzoI0cUfyBXmknhNBwk4Ax4jJkId1MPXaIYNqkiHVDEMDL6JCmuV33qgEhEh3qhWupEWg/d8ri/+X0c3I1n1Ji5Q4KZtI5lae+Efi1etCPErEm7jNdNTKZlYHEUUzI5L0b2g4frRioSuqus64fdcii+3CkDEvoGktEzksRBuwkbV+HdMTZslpq/bL+Ea29bZONefZ0V3dRrxN6PKSdV0Qr4hDp0gEEqXBpogNTdVk/uaeFj/gkisguZgNWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWssjQdwGUMoKjHQNOPbhMKoFvNDn0SP9GgVS3iQoQ8=;
 b=mS/CxOWjlYboY4gECEcWZaKVKeJKojks55fQOgygjJAccCz5DPXG6pf2pmmsrde4Yua2Rjvk54JvN31KMVhyJ50cfQco5fI6leD81QON9+lOVGuA3nF5J6qxuYCLdZjH8LSA+Qu4nJYH3/bV0zPKpvyShF89IVnPJBPA52Aheo1yObWhCz3ioZVKDY7TiehEHbdMP9hpColZ5Bg9O2tdWNEB1xDEFNDrwDbe8I9dWHbPi4hnwFWYKf80F/Kag3ANEs+Mb106bV30D/fgQXLmnXx6dEiSHfh6QgLFhXx1NXDmSoho+fNy3pm0+fhRI9+5AVhVqKAXfcV6t0CSlN95rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWssjQdwGUMoKjHQNOPbhMKoFvNDn0SP9GgVS3iQoQ8=;
 b=s0dXYj0vy4EezpRSJBKecZnZx8HOYn6GFyRL4FggOdFob9igQgtp3MvfuYjazNNGfgOCyS8OyPdg9WaTUeCIQEv4iJbN04GqLNMIxVsJfZ6QHalbPwXCKl8fdGk0pR1uyB/e/mUe8UmAwu98Ux3qnluRXIy6zqy8W9Hzg1y3R5k=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB4040.namprd12.prod.outlook.com (2603:10b6:610:ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Fri, 9 Oct
 2020 20:02:25 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::a110:b7c8:73bd:d60]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::a110:b7c8:73bd:d60%8]) with mapi id 15.20.3455.027; Fri, 9 Oct 2020
 20:02:25 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com, andy.shevchenko@gmail.com,
        mail@richard-neumann.de, m.felsch@pengutronix.de,
        rdunlap@infradead.org
Cc:     Shyam-sundar.S-k@amd.com, Sandeep Singh <sandeep.singh@amd.com>
Subject: [PATCH v8 2/4] SFH: PCIe driver to add support of AMD sensor fusion hub
Date:   Sat, 10 Oct 2020 01:31:36 +0530
Message-Id: <20201009200138.1847317-3-Sandeep.Singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201009200138.1847317-1-Sandeep.Singh@amd.com>
References: <20201009200138.1847317-1-Sandeep.Singh@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR0101CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::24) To CH2PR12MB4101.namprd12.prod.outlook.com
 (2603:10b6:610:a8::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jatayu.amd.com (165.204.156.251) by MAXPR0101CA0038.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend Transport; Fri, 9 Oct 2020 20:02:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 600b66f3-be08-4d82-33d1-08d86c8e3e11
X-MS-TrafficTypeDiagnostic: CH2PR12MB4040:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB40404D8A3900555F30C87409E0080@CH2PR12MB4040.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:409;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H9QDSpazW2YmSbS3p2d+qVTgemFb9xguI2rw9CGbZPJXBWllZdLTMNaV87CT6vbL4tS4i8L5p/2VJq7CqAvxAdN4pGB282RKYxqWjaU5BiNdmsIyFczwE1ch5M8G/zDUtTByv1RhOWlEQzZoVDe9adyPPxtKPJ2Lns/ReWCqQO7DDASWreBeVtEp3LvPG0LITzGwPJup0kEyLP9p/WqA62NSy60uw8c8u4nu6j1RvalD52hhG8hr+0ydiyfkij9a8ghdH5P967DZGc7YGrXg2sVK4mg/qOIZE4Yl+grurZD2LZ28mU0h2TCFXBS+P4vYKijXNH101O3NUXagnslRtiF/Yj2GUmLqJIKusom8DWVN2lKz9bb8iUjWQ+ZBy1C7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(86362001)(83380400001)(316002)(4326008)(2906002)(36756003)(26005)(478600001)(8676002)(52116002)(7696005)(16526019)(186003)(6666004)(956004)(2616005)(7416002)(1076003)(8936002)(5660300002)(66946007)(66476007)(66556008)(6486002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +RzNzw/szUDApfN2riIaie9J51TPzgOnC4GxPI4V405H2V2A3ddHJQ0zb34jdlUufmfyjnwAquCtRBjf7iaNdK70H4uyc6PlPQfoSAreTNKVTdjJLXjN67xQ4jRGQUkpK2gDyTcwPPrOItDbLVR/PCWEyOCyEgDxFnpfMff3PYW0mcTJiFq0AnQnzo0IOEwtMafyIlk/GWFJy6y/SQzJ99uEkJ9HOtkONMafQM7npV7lWIilyqg2JpQV8N1r7KzRD6MH+GDpwJx4WIaEnMY58gaKo2oPF33qJStV6SqiVMsg9jA7jdYavGnX/wLoAV9e836iibf1nTUZmzX8Kz/19kGlU8ZXe6NdiyvJfUH3jyjYyZzxLkme2QtvNeYZJBYriEq1NWP/bwKz9kmjICeA6M5olyUZiHaiImKnM6GJavbTQFeuLugYEm4YbiPJeqExLwAXsvgACG5zhGADlM+mUm4gUtU3MpbGM3PQfuRYX6nCeNslIRRaujF1ikesUB6qOLHX5kHC5LtVDUdkpy5FTuODGS0zL7WVtD4Ou8JbLbfvvoqcGQD/hvP7A2OvlgaBpGR4tG49Oke2cnx0QycvjfCfS+ayiU03/5SaAqgYzM94OVIEwniMrtVx0/t8hrpetREPx1CDKvs2deyNZ7yBGg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 600b66f3-be08-4d82-33d1-08d86c8e3e11
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2020 20:02:25.6630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBuJkKIpJSUd+B3+ksh5xu+MjDmCiQVWw7I3xW0bJ3wYg6+V3K8P/amMaRkZ6x+r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4040
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Sandeep Singh <sandeep.singh@amd.com>

AMD SFH (Sensor Fusion Hub) is a solution running on MP2
(which is ARM core connected to x86 for processing sensor data).
AMD SFH uses HID over PCI bus to form the HID descriptors and
talks to HID clients like the monitor-sensor/iio-proxy. MP2 which
is exposed as a PCI device to the x86, uses mailboxes to talk to
MP2 firmware to send/receive commands.

Co-developed-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
Signed-off-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
---
 drivers/hid/Kconfig                    |   2 +
 drivers/hid/Makefile                   |   2 +
 drivers/hid/amd-sfh-hid/Kconfig        |  18 +++
 drivers/hid/amd-sfh-hid/Makefile       |  13 +++
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 152 +++++++++++++++++++++++++
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h |  79 +++++++++++++
 6 files changed, 266 insertions(+)
 create mode 100644 drivers/hid/amd-sfh-hid/Kconfig
 create mode 100644 drivers/hid/amd-sfh-hid/Makefile
 create mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
 create mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 05315b434276..1b5f5e9b8d0d 100644
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
index 000000000000..db069a83e9a2
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+menu "AMD SFH HID Support"
+	depends on X86_64 || COMPILE_TEST
+	depends on PCI
+	depends on HID
+
+config AMD_SFH_HID
+	tristate "AMD Sensor Fusion Hub"
+	help
+	  If you say yes to this option, support will be included for the
+	  AMD Sensor Fusion Hub.
+	  This driver will enable sensors functionality on AMD platforms
+	  starting from 17h family of RYZEN parts.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called amd-sfh.
+	  Say Y or M here if you want to support AMD SFH. If unsure, say N.
+endmenu
diff --git a/drivers/hid/amd-sfh-hid/Makefile b/drivers/hid/amd-sfh-hid/Makefile
new file mode 100644
index 000000000000..35e704da5612
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Makefile - AMD SFH HID drivers
+# Copyright (c) 2019-2020, Advanced Micro Devices, Inc.
+#
+#
+obj-$(CONFIG_AMD_SFH_HID) += amd_sfh.o
+amd_sfh-objs := amd_sfh_hid.o
+amd_sfh-objs += amd_sfh_client.o
+amd_sfh-objs += amd_sfh_pcie.o
+amd_sfh-objs += hid_descriptor/amd_sfh_hid_desc.o
+
+ccflags-y += -I $(srctree)/$(src)/
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
new file mode 100644
index 000000000000..9c5eb442e1a6
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -0,0 +1,152 @@
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
+#include <linux/slab.h>
+
+#include "amd_sfh_pcie.h"
+
+#define DRIVER_NAME	"pcie_mp2_amd"
+#define DRIVER_DESC	"AMD(R) PCIe MP2 Communication Driver"
+
+#define ACEL_EN		BIT(1)
+#define GYRO_EN		BIT(2)
+#define MAGNO_EN	BIT(3)
+#define ALS_EN		BIT(19)
+
+void amd_start_sensor(struct amd_mp2_dev *privdata, struct amd_mp2_sensor_info info)
+{
+	union sfh_cmd_param cmd_param;
+	union sfh_cmd_base cmd_base;
+
+	/* fill up command register */
+	memset(&cmd_base, 0, sizeof(cmd_base));
+	cmd_base.s.cmd_id = ENABLE_SENSOR;
+	cmd_base.s.period = info.period;
+	cmd_base.s.sensor_id = info.sensor_idx;
+
+	/* fill up command param register */
+	memset(&cmd_param, 0, sizeof(cmd_param));
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
+	memset(&cmd_base, 0, sizeof(cmd_base));
+	cmd_base.s.cmd_id = DISABLE_SENSOR;
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
+	memset(&cmd_base, 0, sizeof(cmd_base));
+	cmd_base.s.cmd_id = STOP_ALL_SENSORS;
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
+static void amd_mp2_pci_remove(void *privdata)
+{
+	amd_sfh_hid_client_deinit(privdata);
+	amd_stop_all_sensors(privdata);
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
+
+	privdata->pdev = pdev;
+	pci_set_drvdata(pdev, privdata);
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
+
+	rc = pcim_iomap_regions(pdev, BIT(2), DRIVER_NAME);
+	if (rc)
+		return rc;
+
+	privdata->mmio = pcim_iomap_table(pdev)[2];
+	pci_set_master(pdev);
+	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
+	if (rc) {
+		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+		return rc;
+	}
+	rc = devm_add_action_or_reset(&pdev->dev, amd_mp2_pci_remove, privdata);
+	if (rc)
+		return rc;
+
+	return amd_sfh_hid_client_init(privdata);
+}
+
+static const struct pci_device_id amd_mp2_pci_tbl[] = {
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_MP2) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, amd_mp2_pci_tbl);
+
+static struct pci_driver amd_mp2_pci_driver = {
+	.name		= DRIVER_NAME,
+	.id_table	= amd_mp2_pci_tbl,
+	.probe		= amd_mp2_pci_probe,
+};
+module_pci_driver(amd_mp2_pci_driver);
+
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_AUTHOR("Shyam Sundar S K <Shyam-sundar.S-k@amd.com>");
+MODULE_AUTHOR("Sandeep Singh <Sandeep.singh@amd.com>");
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
new file mode 100644
index 000000000000..e8be94f935b7
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
@@ -0,0 +1,79 @@
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
+
+#define PCI_DEVICE_ID_AMD_MP2	0x15E4
+
+#define ENABLE_SENSOR		1
+#define DISABLE_SENSOR		2
+#define STOP_ALL_SENSORS	8
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

