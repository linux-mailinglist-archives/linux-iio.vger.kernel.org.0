Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB78F241267
	for <lists+linux-iio@lfdr.de>; Mon, 10 Aug 2020 23:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgHJVbp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Aug 2020 17:31:45 -0400
Received: from mail-bn8nam08on2075.outbound.protection.outlook.com ([40.107.100.75]:49856
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726867AbgHJVbp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 10 Aug 2020 17:31:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7w13U+D0Wy7LgFlKvYGlwFQJXhMzEfX9U3fE7jP+JSpjc4KqpFGpeZlg/vQCrxGmzkF9eHykZWzWAQGphen7CS4EKHNlwlqf3g7AvAHLphLTq53GVgzKhOYYCsPJ6iHV8Z7/u/385PgSVz77bzlfHqafNQ+QqrQ17MNb2ZDofqgXfzb9AWiS0aTOU4717CsZ3f35I/ydatb2KlfILc1sjJg5ucboi0VbFInuqN+DbMoKzkrTkzpZyAp+jQ4V5gMnwnEv4RTrjHM9RyY2qe36QeqxgxLYBjupHAJ1oVphHm0XaDx1CT8q8sxuHbNsU+ir/wfl7ad/MSnw5hOJPJI4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxMeR3TfRpqFMTkxsoYAwBJkoMDPgtBAgM2uOsXwNbc=;
 b=BvGSSwDwQwLGrBsZFb+1tQ4etUI2WmT3t7XfHxOmuoM7X+ZArWdrPUG8ZTEUfiyE7I9xzah0Ro0pRw+/2hR5rHG5DWKXeBdVax4CVeZY3ShK+T9a9KgZT+BQ09JHAgAk6K1paxwQKfCkQ8CDVowvC0ryGZl2FphfEleZ1Z0pSFeCYvXnGkMVJvPkaq+awxdttNyOTvN0sTwZGPp2v8AGjeMx7BUgNWWkrdjKptc+lySJ12Hg5XPpykcqMyq5f0jPPnSMR4WJl1/xXPOU/XrZ+erQzLHnetdQpnxBbDIZlo4C7dSsXygZjtUxlcwbuXRZ5arDMH9vCgRaTFndrr+Kwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxMeR3TfRpqFMTkxsoYAwBJkoMDPgtBAgM2uOsXwNbc=;
 b=upq8Q9okTkaNgqaoyXEs7kY7b8YplQndCk/5GTZ6jYKoM4LCqTy1v3G44Z2h3lzrYabNUGtO6EH0JghAGEHJdwebPijEymrdSaF1RqAxdOwBkTHPJnlTsW8tJtrVplYudbMbBBFGB94CoTpKQqDIhBs7pMNF8pLOv6AigOgNegI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2726.namprd12.prod.outlook.com (2603:10b6:a03:66::17)
 by BY5PR12MB3714.namprd12.prod.outlook.com (2603:10b6:a03:1a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Mon, 10 Aug
 2020 21:31:41 +0000
Received: from BYAPR12MB2726.namprd12.prod.outlook.com
 ([fe80::8503:3713:6ed0:af09]) by BYAPR12MB2726.namprd12.prod.outlook.com
 ([fe80::8503:3713:6ed0:af09%6]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 21:31:41 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com, andy.shevchenko@gmail.com,
        mail@richard-neumann.de, m.felsch@pengutronix.de,
        rdunlap@infradead.org
Cc:     Shyam-sundar.S-k@amd.com, Sandeep Singh <sandeep.singh@amd.com>
Subject: [PATCH v7 2/4] SFH: PCIe driver to add support of AMD sensor fusion hub
Date:   Mon, 10 Aug 2020 21:30:53 +0000
Message-Id: <20200810213055.103962-3-Sandeep.Singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810213055.103962-1-Sandeep.Singh@amd.com>
References: <20200810213055.103962-1-Sandeep.Singh@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR0101CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::11) To BYAPR12MB2726.namprd12.prod.outlook.com
 (2603:10b6:a03:66::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jatayu.amd.com (165.204.156.251) by MA1PR0101CA0025.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend Transport; Mon, 10 Aug 2020 21:31:37 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a03903b2-8b45-4ade-ec1a-08d83d74c54f
X-MS-TrafficTypeDiagnostic: BY5PR12MB3714:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB37143810226A3F594C08F73BE0440@BY5PR12MB3714.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L9bE5ZOnSuNJtt+ZmEf3725Ubtf0iJdofcfZS120LJyi5L5sqybNVbjuwv9nKpJ6KCQXKnuzVU7+BSd7IbXt9HpSSUK/KXQ5EjL9I+vhfJbw0MrHU0i0StUs3tfoFFAx807d+RRfy4lEK/bpTGQvSH8iJbrgJ4Yu22WB6rKAHC8Vjp5JO+odnsky8DncC8Cgl2UULANRMnVCsF9a2kjpp4jLx64muoO+Pe8iH8NBJf63JqeQOHpdyd+UI7Z71jr+JUXBE/sbWqRTnq1LtMx1G/bsDSn+nZtimP5GGjI9Rd32/W+/2KiD79pNUnp57SrYqapMUxTAwCXZiEoBcY0Dk8XgQd6dnxAaac69VAyImI1Q/F0lF0wWe8Le2ovchPj1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(2906002)(1076003)(7416002)(83380400001)(478600001)(6666004)(52116002)(66946007)(7696005)(8676002)(66476007)(66556008)(26005)(6486002)(5660300002)(8936002)(36756003)(956004)(2616005)(316002)(16526019)(4326008)(86362001)(186003)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: jTX7NcThBYyOOINvPVtZ4kEPMoUWrxaINefha2E8HtqXUiyas0sH80HY3cCqb3iTOMX+QMbiZNToVDs0rQVFM6heaox6Oq/EWvmLAZJrbaxqUKOWC3h3NVEyo7nR5P+hIS/npDnlYtqmR/yeNMtnEJWVvu8lD6HfQunlEuZIbnNLp7T5ufc6DWEdQ4/OUP1Wz+zHO1XIGRwYJK5fv1WouIMFyi3FkJywbN2P57pr6mJu0QewY5TaSDk4ViY3czs+4cmX35Klux2HMNnEP33kvEsysb9/m6w//b9Q1OuG6/EJmIQGRJZNcIj72koXitjuz9NfxDl3ijy6u5tagEtLIJU7Kah3XlX3Pz6uwR4Y6rC0pmQOkhmXfwblUeeLiritPofcv65QRrMcafNlsc49d2zjIFfF4Pa7jEwLtzIAciLz4QrmcAWZsXzBAl+R83Vm1yQwj9rrjdL0qvm1JyebVYOVyMOG7sr0Ab6ot+3kzo4+/aXDFV3ySSoUeKIHLcYj+GSaYuVc9l8oK8wT5hYvJzZXCJA7ZODRbZ8XBhrqZmTG1VXp5LNEN79lppbFKh46CFKaFqolJGiMX1kN0XUvU9Uts+Bs4YI58+YvXyfiKnWz+DZWYYeyH+IzmMgw9IO5Up27urtmdxOKSCIRREXnSw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a03903b2-8b45-4ade-ec1a-08d83d74c54f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2020 21:31:41.1083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /QKd/Ag31zfDbBBqhup7yl2j799+MVMZpKhyuP5H+5rFKLiuhhL6xiv9oLVV3L7h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3714
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Sandeep Singh <sandeep.singh@amd.com>

AMD SFH uses HID over PCIe bus.SFH fw is part of MP2 processor
(MP2 which is an ARM® Cortex-M4 core based co-processor to x86) and
it runs on MP2 where in driver resides on X86. This part of module
will communicate with MP2 Firmware and provide that data into DRAM

Signed-off-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
---
 drivers/hid/Kconfig                    |   2 +
 drivers/hid/Makefile                   |   2 +
 drivers/hid/amd-sfh-hid/Kconfig        |  21 ++++
 drivers/hid/amd-sfh-hid/Makefile       |  15 +++
 drivers/hid/amd-sfh-hid/amd_mp2_pcie.c | 164 +++++++++++++++++++++++++
 drivers/hid/amd-sfh-hid/amd_mp2_pcie.h |  83 +++++++++++++
 6 files changed, 287 insertions(+)
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
index 000000000000..a042048e8dd4
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+menu "AMD SFH HID support"
+	depends on X86_64 || COMPILE_TEST
+	depends on PCI
+	depends on HID
+
+config AMD_SFH_HID
+	tristate "AMD Sensor Fusion Hub"
+	help
+	If you say yes to this option, support will be included for the AMD
+	Sensor Fusion Hub.
+	This driver will enable sensors functionality to user through HID
+	framework. Basically this driver will get data from MP2 Firmware
+	and provide that data to HID framework.
+	MP2 which is an ARM® Cortex-M4 core based co-processor to x86.
+
+	This driver can also be built as a module. If so, the module will
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
index 000000000000..898157f4240b
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/amd_mp2_pcie.c
@@ -0,0 +1,164 @@
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
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
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

