Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB3A714C535
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2020 05:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgA2E2A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jan 2020 23:28:00 -0500
Received: from mail-bn8nam12on2065.outbound.protection.outlook.com ([40.107.237.65]:13239
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726401AbgA2E2A (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 28 Jan 2020 23:28:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQDXMlt8zWFrVx/A7xIrUuVI+eXOyHHAnHw373NtGYo1DLMDgcsbOGnPOp9+u6mRiN0ZFdVhggoY9uZfsYp+QPgn44pBMfXj8ZvDsX2bYrFBHCNnfFvbngI5kvBQMQnVWhGn2JghOhMUGyTdQAer5ZakdKYsbA5ZJx3xvDIxJEDUAVknHfo5Zjxws5WG5HcEkd3zLIXITtFZjKrvl4DXHJphTHJtMnAQXB/eg+MgxLAOhENUaFHEzjCAw7mrSIYQO77yIZXMX6Bqc5CPNiP3hE4+tizw4oJw2/47aZPtrNH71dKUW9w20hEdTqyBbJ0dsk+YvHdtF6AqOTzh8Maebg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTfe0NNdyIGDNu4JfTHfIVlx1ZC1Gke/FWSdOU5tMuc=;
 b=EOpDqHKIAMwzMB9WvIMfyP8MMan85OIjpzWwG2TrYxY+3NPKjZZU7PryJWuV76Dba7JTiTaENjGFpDUBkyyf5FDIEDkm54qvPWucsjsHYEW4RTccROp4XzdzABE7I08JcCuhh0kO7Ny8537L91ybzBVUCziHoTF2rr3KZ+iQiR/47JdZQiD/DSMQ9BQNVmwxu0IT7kwdQFjZVo+mhUAsGgjws3s+BxjDdDfbtWi98H+iDM1eyznedu1Y1V79GaA9buFkwc9tIPb38dl+x4EmRfE3iRMsDU8k9uCxtMA0wdwu4AsM6lx3RU6eBSGUx5JrF5pzmZnhZjjuUW1Uj4ExoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTfe0NNdyIGDNu4JfTHfIVlx1ZC1Gke/FWSdOU5tMuc=;
 b=OTP3Vvl90CHwvLLdiNnJyMn2d3cFQN7GCL5KNAYGYzAB8Jsjrid2rFtSQ2X0Ocx2r2n5tPzbHninrKSTMi5Lh2p8CjRM9Sjd+7V/pHmv6p0gHlq0EG+nk2UW1sPQKPb1WWAwrB718GDFR7uV7lw3DHoa8Qpg94hWlv0ASpP39JE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sandeep.Singh@amd.com; 
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (20.178.244.84) by
 MN2PR12MB3501.namprd12.prod.outlook.com (20.178.241.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.23; Wed, 29 Jan 2020 04:27:56 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::10ce:b4fb:586d:8b9c]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::10ce:b4fb:586d:8b9c%3]) with mapi id 15.20.2665.026; Wed, 29 Jan 2020
 04:27:56 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        linux-iio@vger.kernel.org
Cc:     Shyam-sundar.S-k@amd.com, Sandeep Singh <sandeep.singh@amd.com>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
Subject: [PATCH v2 2/4] SFH: PCI driver to add support of AMD sensor fusion Hub using HID framework
Date:   Wed, 29 Jan 2020 09:57:24 +0530
Message-Id: <1580272046-32101-3-git-send-email-Sandeep.Singh@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580272046-32101-1-git-send-email-Sandeep.Singh@amd.com>
References: <1580272046-32101-1-git-send-email-Sandeep.Singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::16) To MN2PR12MB3598.namprd12.prod.outlook.com
 (2603:10b6:208:d1::20)
MIME-Version: 1.0
Received: from andbang2.amd.com (165.204.156.251) by MA1PR0101CA0006.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2665.22 via Frontend Transport; Wed, 29 Jan 2020 04:27:54 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aba81446-ebb9-4891-6e82-08d7a4739d78
X-MS-TrafficTypeDiagnostic: MN2PR12MB3501:|MN2PR12MB3501:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB35018C7DBE4BDCE8D4E1B9CBE0050@MN2PR12MB3501.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-Forefront-PRVS: 02973C87BC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(2906002)(4326008)(5660300002)(66556008)(66476007)(16526019)(956004)(2616005)(26005)(186003)(66946007)(30864003)(36756003)(6486002)(8676002)(81156014)(81166006)(478600001)(7696005)(8936002)(316002)(86362001)(6666004)(52116002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3501;H:MN2PR12MB3598.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ju8bJF0CzrwD0EkjzxGPqWusbjP2lRqXTtWAKM9Qjy8bznd/+qu9u6cZkt/65xqiWW6Vd5DcnwNk21ixAJBrBsKts+kXqLJhmbDjR+FlueISblECFX/EOKfj53o7h6TD0qkyeg5DPvXqQkvLUjWtqvzwO6QC0+b27Lo3J6libMAqv0ZaWKcxTHTPZY6Y3rkZfxIQBssc3VwpPT8V6jZ/zULAP3VlOBqECLfm0GPBxqI3hTYh91DYxtwnTNWt0EfJFwVJ+zve/wu4RRgkL17SskO15f1pAtooRJkuOm9LwJTBTGr9PkkYpLeTrQ5sfIvNsF9mnCzXYP6UNop0FdTl+SOkvdbh2aN9kceTbgqTB2ssRpxWxip2kzgMufi7ygaRUNrL2kFuNopmd5SgXARO0k/JPR+A+eWMZndJPAo2DkoecKf7/bRwZQl0QbzG+Yg2
X-MS-Exchange-AntiSpam-MessageData: nlPSRfguRlBvNHtI1ThaZdWfeRIhRuau4qLJGl6GciRCNZl8kbmnuAZbwLw7OE4U+tLppPodBAjTcC/wpBBUD2rrjHbEr3q8ola+X5SqMj69i5unKhJ4UOMAR497dM+L+YKxWb8WMgo4bx9ZyHyBLg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba81446-ebb9-4891-6e82-08d7a4739d78
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2020 04:27:56.7833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PL/OtC0aYbJLS5Vds1LUV+FkQXXyA1YOxMrC2RMxKH31yVUk0qgWUtHe+0tj7NnJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3501
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Sandeep Singh <sandeep.singh@amd.com>

AMD SFH uses HID over PCIe bus.SFH fw is part of MP2
processor and it runs on MP2 where in driver resides
on X86.This part of module will communicate with MP2 FW and
provide that data into DRAM

Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
Signed-off-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
Reported-by: kbuild test robot <lkp@intel.com>
---
 drivers/hid/Kconfig                    |   2 +
 drivers/hid/Makefile                   |   1 +
 drivers/hid/amd-sfh-hid/Kconfig        |  17 +++
 drivers/hid/amd-sfh-hid/Makefile       |  17 +++
 drivers/hid/amd-sfh-hid/amd_mp2_pcie.c | 256 +++++++++++++++++++++++++++++++++
 drivers/hid/amd-sfh-hid/amd_mp2_pcie.h | 169 ++++++++++++++++++++++
 6 files changed, 462 insertions(+)
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
index 0000000..e2dee39
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "AMD SFH HID support"
+	depends on (X86_64 || COMPILE_TEST) && PCI
+
+config AMD_SFH_HID
+	tristate "AMD Sensor Fusion Hub"
+	default n
+	select HID
+	help
+	  If you say yes to this option, support will be included for the AMD
+	  Sensor Fusion Hub.
+
+	  This driver can also be built as modules. If so, the modules will
+	  be  called amd-mp2-pcie and amd-sfhtp-hid.
+	  Say Y here if you want to support AMD SFH. If unsure, say N.
+
+endmenu
diff --git a/drivers/hid/amd-sfh-hid/Makefile b/drivers/hid/amd-sfh-hid/Makefile
new file mode 100644
index 0000000..5aae934
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/Makefile
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile - AMD SFH HID drivers
+# Copyright (c) 2019-2020, Advanced Micro Devices, Inc.
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
index 0000000..f264d60
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/amd_mp2_pcie.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD MP2 PCIe communication driver
+ *
+ * Authors: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
+ *          Nehal Bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>
+ */
+
+#include "amd_mp2_pcie.h"
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+
+#define DRIVER_NAME	"pcie_mp2_amd"
+#define DRIVER_DESC	"AMD(R) PCIe MP2 Communication Driver"
+#define DRIVER_VER	"1.0"
+
+#define	ACEL_EN		BIT(ACCEL_IDX)
+#define	GYRO_EN		BIT(GYRO_IDX)
+#define MAGNO_EN	BIT(MAG_IDX)
+#define ALS_EN		BIT(AMBIENT_LIGHT_IDX)
+
+int amd_start_sensor(struct pci_dev *pdev, struct amd_mp2_sensor_info info)
+{
+	struct amd_mp2_dev *privdata = pci_get_drvdata(pdev);
+	union sfh_cmd_base cmd_base;
+	union sfh_command_parameter cmd_param;
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
+	return 0;
+}
+EXPORT_SYMBOL_GPL(amd_start_sensor);
+
+int amd_stop_sensor(struct pci_dev *pdev, u16 sensor_idx)
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
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(amd_stop_sensor);
+
+int amd_stop_all_sensors(struct pci_dev *pdev)
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
+
+	return 0;
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
+	rc = pci_enable_device(pdev);
+	if (rc)
+		goto err_pci_enable;
+
+	rc = pci_request_regions(pdev, DRIVER_NAME);
+	if (rc)
+		goto err_pci_regions;
+
+	pci_set_master(pdev);
+
+	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
+	if (rc) {
+		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+		if (rc)
+			goto err_dma_mask;
+		dev_warn(ndev_dev(privdata), "Cannot DMA highmem\n");
+	}
+
+	rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
+	if (rc) {
+		rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
+		if (rc)
+			goto err_dma_mask;
+		dev_warn(ndev_dev(privdata), "Cannot DMA consistent highmem\n");
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
+	pci_release_regions(pdev);
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
+	pci_release_regions(pdev);
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
+	privdata = kzalloc(sizeof(*privdata), GFP_KERNEL);
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
+
+	return 0;
+
+err_pci_init:
+	kfree(privdata);
+err_dev:
+	dev_err(&pdev->dev, "Memory Allocation Failed\n");
+	return rc;
+}
+
+static void amd_mp2_pci_remove(struct pci_dev *pdev)
+{
+	struct amd_mp2_dev *privdata = pci_get_drvdata(pdev);
+
+	amd_mp2_pci_deinit(privdata);
+	kfree(privdata);
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
+MODULE_VERSION(DRIVER_VER);
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_AUTHOR("Shyam Sundar S K <Shyam-sundar.S-k@amd.com>");
+MODULE_AUTHOR("Nehal Bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>");
diff --git a/drivers/hid/amd-sfh-hid/amd_mp2_pcie.h b/drivers/hid/amd-sfh-hid/amd_mp2_pcie.h
new file mode 100644
index 0000000..2bfd2de
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/amd_mp2_pcie.h
@@ -0,0 +1,169 @@
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
+#define write64 _write64
+static inline void _write64(u64 val, void __iomem *mmio)
+{
+	writel(val, mmio);
+	writel(val >> 32, mmio + sizeof(u32));
+}
+
+#define read64 _read64
+static inline u64 _read64(void __iomem *mmio)
+{
+	u64 low, high;
+
+	low = readl(mmio);
+	high = readl(mmio + sizeof(u32));
+	return low | (high << 32);
+}
+
+enum {
+	/* MP2 C2P Message Registers */
+	AMD_C2P_MSG0 = 0x10500,
+	AMD_C2P_MSG1 = 0x10504,
+	AMD_C2P_MSG2 = 0x10508,
+	AMD_C2P_MSG3 = 0x1050c,
+	AMD_C2P_MSG4 = 0x10510,
+	AMD_C2P_MSG5 = 0x10514,
+	AMD_C2P_MSG6 = 0x10518,
+	AMD_C2P_MSG7 = 0x1051c,
+	AMD_C2P_MSG8 = 0x10520,
+	AMD_C2P_MSG9 = 0x10524,
+
+	/* MP2 P2C Message Registers */
+	AMD_P2C_MSG0 = 0x10680, /*Do not use*/
+	AMD_P2C_MSG1 = 0x10684,
+	AMD_P2C_MSG2 = 0x10688,
+	AMD_P2C_MSG3 = 0x1068C, /*MP2 debug info*/
+	AMD_P2C_MSG_INTEN = 0x10690, /*MP2 int gen register*/
+	AMD_P2C_MSG_INTSTS = 0x10694, /*Interrupt sts*/
+};
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
+	} s; /*!< Structure used for bit access */
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
+union sfh_event_base {
+	u32 ul;
+	struct {
+		u32 response : 4; /*!< bit: 0..3 SFI response_type */
+		u32 status : 3; /*!< bit: 6..5 status_type */
+		u32 out_in_c2p : 1; /*!< bit: 5 0- output in DRAM,1-in C2PMsg */
+		u32 length : 6; /*!< bit: 8..13 length */
+		u32 dbg : 2; /*!< bit: 14.15 dbg msg include in p2c msg 1-2 */
+		u32 sensor_id : 8; /*!< bit: 16..23 Sensor ID */
+		u32 rsvd : 8; /*!< bit: 24..31 Reservered for future use */
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
+int amd_start_sensor(struct pci_dev *pdev, struct amd_mp2_sensor_info info);
+int amd_stop_sensor(struct pci_dev *pdev, u16 sensor_idx);
+int amd_stop_all_sensors(struct pci_dev *pdev);
+int amd_mp2_get_sensor_num(struct pci_dev *dev, u8 *sensor_id);
+#define ndev_pdev(ndev) ((ndev)->pdev)
+#define ndev_name(ndev) pci_name(ndev_pdev(ndev))
+#define ndev_dev(ndev) (&ndev_pdev(ndev)->dev)
+#endif
-- 
2.7.4

