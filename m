Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23EA3159F4E
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2020 04:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgBLC5I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Feb 2020 21:57:08 -0500
Received: from mail-eopbgr690054.outbound.protection.outlook.com ([40.107.69.54]:44549
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727565AbgBLC5H (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 11 Feb 2020 21:57:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZLGNQvJR9c+e0cZovs2pnM38jTsz+uB1QO0lNYPDDl6G8YfH5tdr4EtowTAFcbZboSl7j5JzntY/HI5xQsIgvVeZwyZuEvtwcoVQb3dGrXqym5AzitUsfBk4Xrd90an2dXjkJTIzYvJCcvG+gSFBxCjLlvL7wVLetQV+lyVCSh0XSPoxdk+xvlRXSvKh6OMi3mumynFuyTzxgSzYf2s7gPXUI0HChYQr9Ryo3vXZKD4snkoFgSmJdxH+GtkiDI50vtRvrzXHlDPEb7vP4hgUybf3BLnZoLYBBUhtBKap++mfET4guodDL5eO+4PCkS6vvQ6qvr76HeUSl0Nk2p48g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emMaZH8DaNYaZZlLswetAortcpXyJduMlfvJVV6m45o=;
 b=Wq3pqzgTb02Usf6qIF7Iuorh2TpZ3A8Qa3kjCPjgFm1sBpmp0rQAvfOu8UXE7LZF1s2gIqFtiJnf1UzY+3oEoJhTlx4MG8PsatC8upcKFj3C9eSv9xmV9sjNlxlJ73bd6pG9Dc8VprDVGv2uEFi4pVnvr0DoFJ2VKwkBcyFFhd+tuqc/mtimYQq8D5eyqyLKfm0IPyVdbOQzkhUheYJ8Vt2kOp6SZCV98FMMilgHfik/lGR0EhXfwqUMH92/NXUQXV0s3DwDiDiJ1TKapvFAfcfeSn2G3Z/fXnRr6of4EUSzdPiRSyy1lY/TUnxwyyC7k2k/Tr5/GxoVIdTew+turw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emMaZH8DaNYaZZlLswetAortcpXyJduMlfvJVV6m45o=;
 b=IpOZLOzbVrkyAUoDrJts4G/X5olQcmzeH3mpAx8wbty55eo4vwzG1JtEWpm+Xmlg3b/Le44pXHGwedxp3yj+OMIL+jf7bdS6OwLncIFA7mEMiQcCawXJu8u24CfmvN6Ys39QqzHuHRl6xbFL642Xqa7Ydn+5D5IYChZtalovjQ8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sandeep.Singh@amd.com; 
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (20.178.244.84) by
 MN2PR12MB3343.namprd12.prod.outlook.com (20.178.240.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.28; Wed, 12 Feb 2020 02:57:03 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::10ce:b4fb:586d:8b9c]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::10ce:b4fb:586d:8b9c%3]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 02:57:03 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, Nehal-bakulchandra.Shah@amd.com
Cc:     Shyam-sundar.S-k@amd.com, Sandeep Singh <sandeep.singh@amd.com>
Subject: [PATCH v3 2/5] SFH: PCI driver to add support of AMD sensor fusion Hub using HID framework
Date:   Wed, 12 Feb 2020 08:26:34 +0530
Message-Id: <1581476197-25854-3-git-send-email-Sandeep.Singh@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581476197-25854-1-git-send-email-Sandeep.Singh@amd.com>
References: <1581476197-25854-1-git-send-email-Sandeep.Singh@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR0101CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::26) To MN2PR12MB3598.namprd12.prod.outlook.com
 (2603:10b6:208:d1::20)
MIME-Version: 1.0
Received: from andbang2.amd.com (165.204.156.251) by MA1PR0101CA0016.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2707.21 via Frontend Transport; Wed, 12 Feb 2020 02:56:59 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d3c990d5-1293-4328-ec83-08d7af673c5e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3343:|MN2PR12MB3343:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB334395452CE3B8E6774BB779E01B0@MN2PR12MB3343.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-Forefront-PRVS: 0311124FA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(6636002)(81166006)(6666004)(2906002)(81156014)(8676002)(6486002)(8936002)(86362001)(956004)(36756003)(66946007)(66556008)(4326008)(5660300002)(7696005)(66476007)(2616005)(52116002)(16526019)(316002)(26005)(30864003)(478600001)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3343;H:MN2PR12MB3598.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v07qwn3Z8jA0/WRjy/QHbVSjHETNTmgkC+W5NWbh2a2HxWsQOtiQBafei5HC5U3wbgdqj5F87Wi0TdHtNtTHuYPjgGQU4Pw/fX9dQqw2KJEh0bJMuNBmoZwoP60jlD2pHHvd5QfGx8QVTXo3ADD0xAJKpj9lckhInD/GxluPXngdHvOv/oTz1nA8lWB7NJ2RBJuuaxL3eZyZu+V3tdW3g7KMVd597ygMpYXd56Cf88oV3h7qRMrV1uieyuSxKTtnC7TgeR9SxOB98fvs82EPcMYhaLamkEL5BvUnLvCDrc335jM2uewkNyqV+9NdKP+oq7DOxqIjUHqWobtEIDVUwk2WtuUhBcMxv5Kn38Ji2fL87+6X/lwpMTAQrRPwPDPJSeQGlztkclUg3UUGwTkYBQZYdJGGt8TkLSjR8puSv/zCdAQ8CfV6zsyRJGqW9FjH
X-MS-Exchange-AntiSpam-MessageData: RJIt6ExI/gvMpSmxItW0Aena4AIg8xdTrj4IBxwYGJRFHs03XGfy2gEoegZ6a6BTZH1sOy8eSkk8iDADDzPfTn6UhSrpmaJLLBEp3GcjUuCpOuuyMDp8bJhLU6pYefWAH9buECu0JdKD4RktuGIR2g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c990d5-1293-4328-ec83-08d7af673c5e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 02:57:02.9498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CR6kDNiWz9XiyRSyKLVH7ohCvE1tAmcZDqHfRVmW1H6zcfPZtfx1Ej8meP87hfOs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3343
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Sandeep Singh <sandeep.singh@amd.com>

AMD SFH uses HID over PCIe bus.SFH fw is part of MP2
processor (MP2 which is an ARM® Cortex-M4 core based
co-processor to x86) and it runs on MP2 where in driver resides
on X86. This part of module will communicate with MP2 FW and
provide that data into DRAM

Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
Signed-off-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
Reported-by: kbuild test robot <lkp@intel.com>
---
 drivers/hid/Kconfig                    |   2 +
 drivers/hid/Makefile                   |   1 +
 drivers/hid/amd-sfh-hid/Kconfig        |  20 +++
 drivers/hid/amd-sfh-hid/Makefile       |  17 +++
 drivers/hid/amd-sfh-hid/amd_mp2_pcie.c | 243 +++++++++++++++++++++++++++++++++
 drivers/hid/amd-sfh-hid/amd_mp2_pcie.h | 177 ++++++++++++++++++++++++
 6 files changed, 460 insertions(+)
 create mode 100644 drivers/hid/amd-sfh-hid/Kconfig
 create mode 100644 drivers/hid/amd-sfh-hid/Makefile
 create mode 100644 drivers/hid/amd-sfh-hid/amd_mp2_pcie.c
 create mode 100644 drivers/hid/amd-sfh-hid/amd_mp2_pcie.h

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 494a39e..b253ad1 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1155,4 +1155,6 @@ source "drivers/hid/i2c-hid/Kconfig"
 
 source "drivers/hid/intel-ish-hid/Kconfig"
 
+source "drivers/hid/amd-sfh-hid/Kconfig"
+
 endmenu
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index bfefa36..15a08e8 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -139,3 +139,4 @@ obj-$(CONFIG_I2C_HID)		+= i2c-hid/
 
 obj-$(CONFIG_INTEL_ISH_HID)	+= intel-ish-hid/
 obj-$(INTEL_ISH_FIRMWARE_DOWNLOADER)	+= intel-ish-hid/
+obj-$(CONFIG_AMD_SFH_HID)       += amd-sfh-hid/
diff --git a/drivers/hid/amd-sfh-hid/Kconfig b/drivers/hid/amd-sfh-hid/Kconfig
new file mode 100644
index 0000000..7a224a1
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "AMD SFH HID support"
+	depends on (X86_64 || COMPILE_TEST) && PCI
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
+	be  called amd-mp2-pcie and amd-sfhtp-hid.
+	Say Y or M here if you want to support AMD SFH. If unsure, say N.
+
+endmenu
diff --git a/drivers/hid/amd-sfh-hid/Makefile b/drivers/hid/amd-sfh-hid/Makefile
new file mode 100644
index 0000000..36d20f2
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/Makefile
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile - AMD SFH HID drivers
+# Copyright (c) 2020-2021, Advanced Micro Devices, Inc.
+#
+#
+ccflags-m := -Werror
+obj-$(CONFIG_AMD_SFH_HID) += amd-mp2-pcie.o
+amd-mp2-pcie-objs := amd_mp2_pcie.o
+
+obj-$(CONFIG_AMD_SFH_HID) +=amd-sfhtp-hid.o
+amd-sfhtp-hid-objs := amdsfh-hid.o
+amd-sfhtp-hid-objs+= amdsfh-hid-client.o
+amd-sfhtp-hid-objs+= amdsfh-debugfs.o
+amd-sfhtp-hid-objs+= hid_descriptor/amd_sfh_hid_descriptor.o
+
+ccflags-y += -I$(srctree)/$(src)/
diff --git a/drivers/hid/amd-sfh-hid/amd_mp2_pcie.c b/drivers/hid/amd-sfh-hid/amd_mp2_pcie.c
new file mode 100644
index 0000000..c67f389
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/amd_mp2_pcie.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD MP2 PCIe communication driver
+ *
+ * Authors: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
+ *          Nehal Bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>
+ */
+
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include "amd_mp2_pcie.h"
+
+#define DRIVER_NAME	"pcie_mp2_amd"
+#define DRIVER_DESC	"AMD(R) PCIe MP2 Communication Driver"
+
+#define	ACEL_EN		BIT(ACCEL_IDX)
+#define	GYRO_EN		BIT(GYRO_IDX)
+#define MAGNO_EN	BIT(MAG_IDX)
+#define ALS_EN		BIT(AMBIENT_LIGHT_IDX)
+
+void amd_start_sensor(struct pci_dev *pdev, struct amd_mp2_sensor_info info)
+{
+	struct amd_mp2_dev *privdata = pci_get_drvdata(pdev);
+	union sfh_command_parameter cmd_param;
+	union sfh_cmd_base cmd_base;
+
+	/*fill up command register*/
+	cmd_base.ul = 0;
+	cmd_base.s.cmd_id = enable_sensor;
+	cmd_base.s.period = info.period;
+	cmd_base.s.sensor_id = info.sensor_idx;
+
+	/*fill up command param register*/
+	cmd_param.ul = 0;
+	cmd_param.s.buffer_layout = 1;
+	cmd_param.s.buffer_length = 16;
+
+	write64((u64)info.phy_address, privdata->mmio + AMD_C2P_MSG2);
+	writel(cmd_param.ul, privdata->mmio + AMD_C2P_MSG1);
+	writel(cmd_base.ul, privdata->mmio + AMD_C2P_MSG0);
+}
+EXPORT_SYMBOL_GPL(amd_start_sensor);
+
+void amd_stop_sensor(struct pci_dev *pdev, u16 sensor_idx)
+{
+	struct amd_mp2_dev *privdata = pci_get_drvdata(pdev);
+	union sfh_cmd_base cmd_base;
+
+	/* fill up command register */
+	cmd_base.ul = 0;
+	cmd_base.s.cmd_id = disable_sensor;
+	cmd_base.s.period = 0;
+	cmd_base.s.sensor_id = sensor_idx;
+
+	write64(0x0, privdata->mmio + AMD_C2P_MSG2);
+	writel(cmd_base.ul, privdata->mmio + AMD_C2P_MSG0);
+}
+EXPORT_SYMBOL_GPL(amd_stop_sensor);
+
+void amd_stop_all_sensors(struct pci_dev *pdev)
+{
+	struct amd_mp2_dev *privdata = pci_get_drvdata(pdev);
+	union sfh_cmd_base cmd_base;
+
+	/*fill up command register */
+	cmd_base.ul = 0;
+	cmd_base.s.cmd_id = stop_all_sensors;
+	cmd_base.s.period = 0;
+	cmd_base.s.sensor_id = 0;
+
+	writel(cmd_base.ul, privdata->mmio + AMD_C2P_MSG0);
+}
+EXPORT_SYMBOL_GPL(amd_stop_all_sensors);
+
+int amd_mp2_get_sensor_num(struct pci_dev *dev, u8 *sensor_id)
+{
+	struct amd_mp2_dev *privdata = pci_get_drvdata(dev);
+	int activestatus;
+	int num_of_sensors = 0;
+
+	if (!sensor_id)
+		return -ENOMEM;
+
+	privdata->eventreg.activecontrolstatus =
+			readl(privdata->mmio + AMD_P2C_MSG3);
+	activestatus = privdata->eventreg.activecontrolstatus >> 4;
+
+	if (ACEL_EN  & activestatus) {
+		sensor_id[num_of_sensors] = ACCEL_IDX;
+		num_of_sensors++;
+	}
+	if (GYRO_EN & activestatus) {
+		sensor_id[num_of_sensors] = GYRO_IDX;
+		num_of_sensors++;
+	}
+	if (MAGNO_EN & activestatus) {
+		sensor_id[num_of_sensors] = MAG_IDX;
+		num_of_sensors++;
+	}
+
+	if (ALS_EN & activestatus) {
+		sensor_id[num_of_sensors] = AMBIENT_LIGHT_IDX;
+		num_of_sensors++;
+	}
+
+	return num_of_sensors;
+}
+EXPORT_SYMBOL_GPL(amd_mp2_get_sensor_num);
+
+static int amd_mp2_pci_init(struct amd_mp2_dev *privdata, struct pci_dev *pdev)
+{
+	int rc;
+	int bar_index = 2;
+	resource_size_t size, base;
+
+	pci_set_drvdata(pdev, privdata);
+
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		goto err_pci_enable;
+
+	rc = pcim_iomap_regions(pdev, 1 >> 2, DRIVER_NAME);
+	if (rc)
+		goto err_pci_regions;
+
+	privdata->mmio = pcim_iomap_table(pdev)[2];
+	pci_set_master(pdev);
+
+	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
+	if (rc) {
+		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+		if (rc)
+			goto err_dma_mask;
+	}
+
+	rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
+	if (rc) {
+		rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
+		if (rc)
+			goto err_dma_mask;
+	}
+
+	base = pci_resource_start(pdev, bar_index);
+	size = pci_resource_len(pdev, bar_index);
+	dev_dbg(ndev_dev(privdata), "Base addr:%llx size:%llx\n",
+		(unsigned long long)base, (unsigned long long)size);
+
+	privdata->mmio = ioremap(base, size);
+	if (!privdata->mmio) {
+		rc = -EIO;
+		goto err_dma_mask;
+	}
+
+	return 0;
+
+err_dma_mask:
+	pci_clear_master(pdev);
+err_pci_regions:
+	pci_disable_device(pdev);
+err_pci_enable:
+	pci_set_drvdata(pdev, NULL);
+	return rc;
+}
+
+static void amd_mp2_pci_deinit(struct amd_mp2_dev *privdata)
+{
+	struct pci_dev *pdev = ndev_pdev(privdata);
+
+	amd_stop_all_sensors(pdev);
+	pci_iounmap(pdev, privdata->mmio);
+
+	pci_clear_master(pdev);
+	pci_disable_device(pdev);
+	pci_set_drvdata(pdev, NULL);
+}
+
+static int amd_mp2_pci_probe(struct pci_dev *pdev,
+			     const struct pci_device_id *id)
+{
+	struct amd_mp2_dev *privdata;
+	int rc;
+
+	dev_info(&pdev->dev, "MP2 device found [%04x:%04x] (rev %x)\n",
+		 (int)pdev->vendor, (int)pdev->device, (int)pdev->revision);
+
+	privdata = devm_kzalloc(&pdev->dev, sizeof(*privdata), GFP_KERNEL);
+
+	if (!privdata) {
+		rc = -ENOMEM;
+		goto err_dev;
+	}
+
+	privdata->pdev = pdev;
+
+	rc = amd_mp2_pci_init(privdata, pdev);
+	if (rc)
+		goto err_pci_init;
+	return 0;
+
+err_pci_init:
+	return rc;
+err_dev:
+	return rc;
+}
+
+static void amd_mp2_pci_remove(struct pci_dev *pdev)
+{
+	struct amd_mp2_dev *privdata = pci_get_drvdata(pdev);
+
+	amd_mp2_pci_deinit(privdata);
+}
+
+static const struct pci_device_id amd_mp2_pci_tbl[] = {
+	{PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_MP2)},
+	{0}
+};
+MODULE_DEVICE_TABLE(pci, amd_mp2_pci_tbl);
+
+static struct pci_driver amd_mp2_pci_driver = {
+	.name		= DRIVER_NAME,
+	.id_table	= amd_mp2_pci_tbl,
+	.probe		= amd_mp2_pci_probe,
+	.remove		= amd_mp2_pci_remove,
+};
+
+static int __init amd_mp2_pci_driver_init(void)
+{
+	return pci_register_driver(&amd_mp2_pci_driver);
+}
+module_init(amd_mp2_pci_driver_init);
+
+static void __exit amd_mp2_pci_driver_exit(void)
+{
+	pci_unregister_driver(&amd_mp2_pci_driver);
+}
+module_exit(amd_mp2_pci_driver_exit);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_AUTHOR("Shyam Sundar S K <Shyam-sundar.S-k@amd.com>");
+MODULE_AUTHOR("Nehal Bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>");
diff --git a/drivers/hid/amd-sfh-hid/amd_mp2_pcie.h b/drivers/hid/amd-sfh-hid/amd_mp2_pcie.h
new file mode 100644
index 0000000..4c09249
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/amd_mp2_pcie.h
@@ -0,0 +1,177 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * AMD MP2 PCIe communication driver
+ *
+ * Authors: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
+ *          Nehal Bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>
+ */
+
+#ifndef PCIE_MP2_AMD_H
+#define PCIE_MP2_AMD_H
+
+#include <linux/pci.h>
+#define PCI_DEVICE_ID_AMD_MP2	0x15E4
+
+/* MP2 C2P Message Registers */
+#define AMD_C2P_MSG0	0x10500
+#define AMD_C2P_MSG1	0x10504
+#define AMD_C2P_MSG2	0x10508
+#define AMD_C2P_MSG3	0x1050c
+#define AMD_C2P_MSG4	0x10510
+#define AMD_C2P_MSG5	0x10514
+#define AMD_C2P_MSG6	0x10518
+#define AMD_C2P_MSG7	0x1051c
+#define AMD_C2P_MSG8	0x10520
+#define AMD_C2P_MSG9	0x10524
+
+/* MP2 P2C Message Registers */
+#define AMD_P2C_MSG0	0x10680 /*Do not use*/
+#define AMD_P2C_MSG1	0x10684
+#define AMD_P2C_MSG2	0x10688
+#define AMD_P2C_MSG3	0x1068C /*MP2 debug info*/
+#define AMD_P2C_MSG_INTEN	0x10690 /*MP2 int gen register*/
+#define AMD_P2C_MSG_INTSTS	0x10694 /*Interrupt sts*/
+
+#define write64 amdsfh_write64
+static inline void amdsfh_write64(u64 val, void __iomem *mmio)
+{
+	writel(val, mmio);
+	writel(val >> 32, mmio + sizeof(u32));
+}
+
+#define read64 amdsfh_read64
+static inline u64 amdsfh_read64(void __iomem *mmio)
+{
+	u64 low, high;
+
+	low = readl(mmio);
+	high = readl(mmio + sizeof(u32));
+	return low | (high << 32);
+}
+
+/*
+ * SFH Command registers
+ */
+union sfh_cmd_base {
+	u32 ul;
+	struct {
+		u32 cmd_id : 8;
+		u32 sensor_id : 8;
+		u32 period : 16;
+	} s;
+};
+
+union sfh_command_parameter {
+	u32 ul;
+	struct {
+		u32 buffer_layout : 2;
+		u32 buffer_length : 6;
+		u32 rsvd : 24;
+	} s;
+};
+
+struct sfh_command_register {
+	union sfh_cmd_base cmd_base;
+	union sfh_command_parameter cmd_param;
+	phys_addr_t phy_addr;
+};
+
+/*
+ * SFH Response registers
+ */
+enum response_type {
+	non_operationevent,
+	command_success,
+	command_failed,
+	sfi_dataready_event,
+	invalid_response = 0xff,
+};
+
+enum status_type {
+	cmd_success,
+	invalid_data_payload,
+	invalid_data_length,
+	invalid_sensor_id,
+	invalid_dram_addr,
+	invalid_command,
+	sensor_enabled,
+	sensor_disabled,
+	status_end,
+};
+
+enum command_id {
+	non_operation = 0,
+	enable_sensor = 1,
+	disable_sensor = 2,
+	dump_sensorinfo = 3,
+	numberof_sensordiscovered = 4,
+	who_am_i_regchipid = 5,
+	set_dcd_data = 6,
+	get_dcd_data = 7,
+	stop_all_sensors = 8,
+	invalid_cmd = 0xf,
+};
+
+/**
+ * union sfh_event_base : bit access of C2P commands
+ * @response: bit: 0..3 SFI response_type
+ * @status: bit: 6..5 status_type
+ * @out_in_c2p: bit: 5 0- output in DRAM,1-in C2PMsg
+ * @length: bit: 8..13 length
+ * @dbg:bit: 14.15 dbg msg include in p2c msg 1-2
+ * @sensor_id:bit: 16..23 Sensor ID
+ * @rsvd:bit: 24..31 Reservered for future use
+ */
+union sfh_event_base {
+	u32 ul;
+	struct {
+		u32 response : 4;
+		u32 status : 3;
+		u32 out_in_c2p : 1;
+		u32 length : 6;
+		u32 dbg : 2;
+		u32 sensor_id : 8;
+		u32 rsvd : 8;
+	} s;
+};
+
+struct sfi_event_register {
+	union sfh_event_base evtbase;
+	u32 debuginfo1;
+	u32 debuginfo2;
+	u32 activecontrolstatus;
+};
+
+enum sensor_idx {
+	ACCEL_IDX               = 0,
+	GYRO_IDX                = 1,
+	MAG_IDX                 = 2,
+	AMBIENT_LIGHT_IDX       = 19,
+	NUM_ALL_SENSOR_CONSUMERS
+};
+
+struct amd_mp2_dev {
+	struct pci_dev *pdev;
+	struct dentry *debugfs_dir;
+	void __iomem *mmio;
+	union sfh_event_base eventval;
+	struct sfi_event_register eventreg;
+	struct delayed_work work;
+	void *ctx;
+	void *cl_data;
+};
+
+struct amd_mp2_sensor_info {
+	u8 sensor_idx;
+	u32 period;
+	phys_addr_t phy_address;
+};
+
+void amd_start_sensor(struct pci_dev *pdev, struct amd_mp2_sensor_info info);
+void amd_stop_sensor(struct pci_dev *pdev, u16 sensor_idx);
+void amd_stop_all_sensors(struct pci_dev *pdev);
+int amd_mp2_get_sensor_num(struct pci_dev *dev, u8 *sensor_id);
+#define ndev_pdev(ndev) ((ndev)->pdev)
+#define ndev_name(ndev) pci_name(ndev_pdev(ndev))
+#define ndev_dev(ndev) (&ndev_pdev(ndev)->dev)
+#endif
-- 
2.7.4

