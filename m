Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C06B1E7F00
	for <lists+linux-iio@lfdr.de>; Fri, 29 May 2020 15:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgE2NnB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 May 2020 09:43:01 -0400
Received: from mail-eopbgr680046.outbound.protection.outlook.com ([40.107.68.46]:63751
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726827AbgE2NnA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 May 2020 09:43:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENBOEPdFyd2AE10BHTyTDiB04oQK2zKFpDhQKlTDLmpd4I6y5Yz/KMyDKFGRqf5IdUYmK7UUB8YF4J8QNp/uN3SsgmL8DjteZmAW79UgiN7IukdTql/uYslNXXhkyk7dOwBUBufZqZwwvvm8UE5qbJ9F84Ce4QdMdBt5BesbaSkOXqjklgJD6c8gcc4IQhhcPsMReyvMPWHQEwr9vF3FCq1A9dVvqmdK1OymsrH2DDQ2ErdyF1GV985Fn9ENr9mvHF9CeWXNYNmGM6jRGIdSp+RLXFgkuGrglw28VqdaXyrcGx4FzExgnXn6OdVBOIqtZM+wu0SrpmLbu2BmY0Migg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeL2ZKMzTqN+1GPdc4wq+REXXz9E9yhe+im6+zflv1w=;
 b=Rxh98F3lnUUfEdhQgJ+RdSO8pD3tDLYAyWM2wSpq6GEQOdF/Vel/J0ipzbdGmjz7ew7QXcVy6Ea555Rd9Okqv0I86X4T5leTDqZ8Md+tL97iTcabI4YvWWZQ9LTTxTXjTdNCsmOtGLLbJLD09Esry4CJUaacpUUZFkBTmDjqePDShM1FBVggg0Jv1n/S/NC927ZNO/MpnlWlqeqBvKZK0FAqnseJd/HY/QjzRJZ267RBGxcfnzRlCr/6J5nvYm+N61moZr1VklaI0+14vYcbbC7+Lzsw0UlPEvayL/Iqh8c1BsbMv1t0majanP2O/r30mK6zFnJNUE68asVcUiz7ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeL2ZKMzTqN+1GPdc4wq+REXXz9E9yhe+im6+zflv1w=;
 b=WNjKgLM6WBdmIhnTK5rlp5pB0x/ed5GbtQCb3P6tZvBq3N67iXqOTg80h0YdjNcbs3vKLApqMgxXJ6KPLcu0i6a+Rg47jmFL/YIxQa3OzhiEV82XEpODu1dvDwhiSedWxknOE8HxasDFqDUrABpXvnAHtApR1aUQrZof/1HwaYU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2726.namprd12.prod.outlook.com (2603:10b6:a03:66::17)
 by BYAPR12MB2805.namprd12.prod.outlook.com (2603:10b6:a03:72::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Fri, 29 May
 2020 13:42:55 +0000
Received: from BYAPR12MB2726.namprd12.prod.outlook.com
 ([fe80::a984:b7cb:3ad0:7508]) by BYAPR12MB2726.namprd12.prod.outlook.com
 ([fe80::a984:b7cb:3ad0:7508%6]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 13:42:55 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com, andy.shevchenko@gmail.com,
        mail@richard-neumann.de
Cc:     Shyam-sundar.S-k@amd.com, Sandeep Singh <sandeep.singh@amd.com>
Subject: [PATCH v5 2/4] SFH: PCI driver to add support of AMD sensor fusion Hub using HID framework
Date:   Fri, 29 May 2020 19:12:08 +0530
Message-Id: <1590759730-32494-3-git-send-email-Sandeep.Singh@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590759730-32494-1-git-send-email-Sandeep.Singh@amd.com>
References: <1590759730-32494-1-git-send-email-Sandeep.Singh@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXPR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::17) To BYAPR12MB2726.namprd12.prod.outlook.com
 (2603:10b6:a03:66::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from andbang2.amd.com (165.204.156.251) by MAXPR01CA0075.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3045.17 via Frontend Transport; Fri, 29 May 2020 13:42:51 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d4d1da29-e45d-478c-cfec-08d803d630e5
X-MS-TrafficTypeDiagnostic: BYAPR12MB2805:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2805E4ACEBCC08F34F5D9CC6E08F0@BYAPR12MB2805.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XSY1HaKT2XnrsoY+lo3Ue4QPdYG0ClL8O+NXhBNOA7XaKLTHoi0Tc41Ab7ueXOYrfqD3IVzvy9usXNLWFEq82iT4OKI8NQvGFBJT+QFSFEVP/ReJLELtJ4DLVjFmhGBsGU76dgceWdlrJfzzPnR/k83MF2RU5RnBQrUNW0SJSQxJToQ4DsvMwty1kUEHMrFKgOQzl8EvNfOqy9WdSzhV3sp4CPfKgiR4zofyQAihug6jrK0SAxWns2SseursWd/5aIk4Lt+2U3Swsqu5DXGt0+vfBUQlecFIZkgjr5Mgnu3H80kUldRl8tG9/M2G+HEco5Q1+YvuyikmQJ2B+ssbWQccRlokehD5vt8QERKgNwXsyZtsPjwPh2zVTFgflGRq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(316002)(86362001)(83380400001)(478600001)(66476007)(7696005)(52116002)(2906002)(6666004)(66946007)(6486002)(66556008)(36756003)(5660300002)(7416002)(30864003)(2616005)(16526019)(186003)(956004)(4326008)(26005)(8936002)(8676002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ysebHXiCKna4bRgpPxa1behuZ7v3r7DefH9YbDTdPGfeqv21eyXK1zOK8f4im5u7DqVN04Fh7oN28jNJpATFY+49unJ6TdhtGk4zk4yqVhGB1756xmMXhRrSv7OlNqm8YK7bmIa6kvc35rAf/SqRoc/bpUoUE5iZVBYJi9eFZt+rRgg5tfhvDO65rl3yg7vqCTTOVxHuS4CJpZTMfJwMaqPEKRlnqSrLrnvKL02D5wXJgsCeF30kgsR6XVN2dvA5N0sZOHoW9HH+spxAyyyhguXr2FhM5CH8IEH+oTBEj1hjYJsksQq+C45OoWEDW2cOlRIIRIcY/nvlgiQoJ4MDvbTgeNGtypJlwKhgC3YKTWlqX/WOiahC+4q3hU+0+P8KbVoL2T6fCwzx3UUdp4rNyBp6xCmod7zc2oWBZMfyYjwbJAc3t572zEKNbRBu6xy2e8sXByjYqqXNt2dVFGt99lwnW8pQ7HUNFmZ8fuc0ToO8GeHC/nGCqzPxoPceKYRA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d1da29-e45d-478c-cfec-08d803d630e5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 13:42:55.3445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5sKnHq0QqiPovfjyvVUlmEkyjXOhQZ1HoKx6Kcp7oMGXftGyI/KgF3kPx7V8pCmo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2805
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
 drivers/hid/amd-sfh-hid/Kconfig        |  21 ++++
 drivers/hid/amd-sfh-hid/Makefile       |  16 +++
 drivers/hid/amd-sfh-hid/amd_mp2_pcie.c | 196 +++++++++++++++++++++++++++++++++
 drivers/hid/amd-sfh-hid/amd_mp2_pcie.h | 137 +++++++++++++++++++++++
 6 files changed, 373 insertions(+)
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
index 0000000..b78d8f9
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-only
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
+	be  called amd-mp2-pcie and amd-sfhtp-hid.
+	Say Y or M here if you want to support AMD SFH. If unsure, say N.
+
+endmenu
diff --git a/drivers/hid/amd-sfh-hid/Makefile b/drivers/hid/amd-sfh-hid/Makefile
new file mode 100644
index 0000000..c11bf63
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/Makefile
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile - AMD SFH HID drivers
+# Copyright (c) 2020-2021, Advanced Micro Devices, Inc.
+#
+
+ccflags-m := -Werror
+obj-$(CONFIG_AMD_SFH_HID) += amd-mp2-pcie.o
+amd-mp2-pcie-objs := amd_mp2_pcie.o
+
+obj-$(CONFIG_AMD_SFH_HID) +=amd-sfhtp-hid.o
+amd-sfhtp-hid-objs := amdsfh-hid.o
+amd-sfhtp-hid-objs+= amdsfh-hid-client.o
+amd-sfhtp-hid-objs+= hid_descriptor/amd_sfh_hid_descriptor.o
+
+ccflags-y += -I$(srctree)/$(src)/
diff --git a/drivers/hid/amd-sfh-hid/amd_mp2_pcie.c b/drivers/hid/amd-sfh-hid/amd_mp2_pcie.c
new file mode 100644
index 0000000..9ddfc77
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/amd_mp2_pcie.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD MP2 PCIe communication driver
+ *
+ * Authors: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
+ *          Nehal Bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/types.h>
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
+	write64(info.phy_address, privdata->mmio + AMD_C2P_MSG2);
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
+		return -EINVAL;
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
+
+	pci_set_drvdata(pdev, privdata);
+
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		goto err_pci_enable;
+
+	rc = pcim_iomap_regions(pdev, BIT(2), DRIVER_NAME);
+	if (rc)
+		goto err_pci_enable;
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
+	return 0;
+
+err_dma_mask:
+	pci_clear_master(pdev);
+err_pci_enable:
+	pci_set_drvdata(pdev, NULL);
+	return rc;
+}
+
+static int amd_mp2_pci_probe(struct pci_dev *pdev,
+			     const struct pci_device_id *id)
+{
+	struct amd_mp2_dev *privdata;
+	int rc;
+
+	dev_info(&pdev->dev, "MP2 device found [%04x:%04x] (rev %x)\n",
+		 pdev->vendor, pdev->device, pdev->revision);
+
+	privdata = devm_kzalloc(&pdev->dev, sizeof(*privdata), GFP_KERNEL);
+	if (!privdata)
+		rc = -ENOMEM;
+
+	privdata->pdev = pdev;
+	rc = amd_mp2_pci_init(privdata, pdev);
+	if (rc)
+		return rc;
+	return 0;
+}
+
+static void amd_mp2_pci_remove(struct pci_dev *pdev)
+{
+	struct amd_mp2_dev *privdata = pci_get_drvdata(pdev);
+
+	amd_stop_all_sensors(privdata->pdev);
+	pci_clear_master(pdev);
+	pci_set_drvdata(pdev, NULL);
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
+module_pci_driver(amd_mp2_pci_driver);
+
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_AUTHOR("Shyam Sundar S K <Shyam-sundar.S-k@amd.com>");
+MODULE_AUTHOR("Nehal Bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>");
diff --git a/drivers/hid/amd-sfh-hid/amd_mp2_pcie.h b/drivers/hid/amd-sfh-hid/amd_mp2_pcie.h
new file mode 100644
index 0000000..577ad24
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/amd_mp2_pcie.h
@@ -0,0 +1,137 @@
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
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/pci.h>
+#include <linux/types.h>
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
+#define write64 lo_hi_writeq
+#define read64 lo_hi_readq
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
+#endif
-- 
2.7.4

