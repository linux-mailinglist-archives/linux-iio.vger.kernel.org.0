Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC79170FE4
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2020 05:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgB0E7q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Feb 2020 23:59:46 -0500
Received: from mail-eopbgr760059.outbound.protection.outlook.com ([40.107.76.59]:25902
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728273AbgB0E7p (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Feb 2020 23:59:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMUTCJtGtVHyxwBeIoO6nbzSxn5QM17mqIsI9C4sJm6BaqB5MSlwQ1WoHVD6mxBj37euLWb0I7GL4PLxr/Iy0U/Yh77mSCCzOk1naR7zsuoo/TY9yFFtTjVLucqWlRYhIGGZCflcX9KWi7VpCGEzCQUzDoaHFhcEOd08yl08pdFDSlU50132TkN5tk14I8jIS5+zZSu+BgSTVVWFGump7U8slyGhwnwLkrFKxUmJAi1YjhrDGet36KEyZ1sVnt5yyE47JVjOT8SwHhM9hZ3gtFTSFOMldSHFQY5zezC83l4DeUNQXSDiWgOOonkKFnq/SPV3ciX5E8HRVBOOOkEO6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7hktfvOuoLsrrHZKd7QLOdnR2rhsbGH1lxvL3vVJkA=;
 b=BPWrpvfCVFN2TMvpfnVaDd6oC7Gn/UC9QOTxILnM2RUyXzZE9XfBvXbF8z7nyhbtmH1XX+ExZOH60d3quZ4I6CjGXPkdGo8PIZxxG+CdgV3YvPwP2nPxvsop5u5GsPCbB8uf06ObGSemKO06lA+uUnUWjeEg4UPlRvhi74D3IpVtA3e3dDFIf5Ti4zu1Bf/ykb5dwHPFdQy8GRWUbEWdsWCQVSRPaV37gLsZ8kv8pMtFRA62VzgpUb/6hKiYpwtnsYERfCopYOjtFPy8T+qovMLPCuWLZXNWdpFT9ZlAs/0JqfOgUZ5q8iIGPAC42rPjUBaZpVJwGT8Miu2WfibSDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7hktfvOuoLsrrHZKd7QLOdnR2rhsbGH1lxvL3vVJkA=;
 b=DMaxcUA8FxB8ZcXr/Enp9TKWTa5zdM9gyHavSmVqasH8ki0sRAvTL1RIJAYyacKgmsRSe3EHxzj4Q/n+QFnXZVbmSHNupG7kpdf5eqGfLJUHz6XPD9u+LQN7SNYmWp+FkygSJym5B55YLjms6nUoUittvyxO2t1i+zJ6L5x92Ko=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sandeep.Singh@amd.com; 
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (2603:10b6:208:d1::20)
 by MN2PR12MB2912.namprd12.prod.outlook.com (2603:10b6:208:ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Thu, 27 Feb
 2020 04:59:42 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::10ce:b4fb:586d:8b9c]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::10ce:b4fb:586d:8b9c%3]) with mapi id 15.20.2772.012; Thu, 27 Feb 2020
 04:59:42 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com
Cc:     Shyam-sundar.S-k@amd.com, Sandeep Singh <sandeep.singh@amd.com>
Subject: [PATCH v4 3/4] SFH: Transport Driver to add support of AMD Sensor Fusion Hub (SFH)
Date:   Thu, 27 Feb 2020 10:28:56 +0530
Message-Id: <1582779537-25662-4-git-send-email-Sandeep.Singh@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582779537-25662-1-git-send-email-Sandeep.Singh@amd.com>
References: <1582779537-25662-1-git-send-email-Sandeep.Singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::17) To MN2PR12MB3598.namprd12.prod.outlook.com
 (2603:10b6:208:d1::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from andbang2.amd.com (165.204.156.251) by MA1PR0101CA0055.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:20::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 04:59:39 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1fc0f0fa-578a-4a05-f544-08d7bb41db0b
X-MS-TrafficTypeDiagnostic: MN2PR12MB2912:|MN2PR12MB2912:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB2912F1BEE655511F8F3807F8E0EB0@MN2PR12MB2912.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:23;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(199004)(189003)(26005)(66476007)(66556008)(8936002)(186003)(16526019)(2906002)(4326008)(6486002)(8676002)(7696005)(52116002)(86362001)(66946007)(316002)(81156014)(81166006)(6666004)(6636002)(5660300002)(30864003)(36756003)(478600001)(956004)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB2912;H:MN2PR12MB3598.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ik7VHu0VrtaIIrMtr8A2p12QekRXjWir9vy0EiYi3m6F1CaPfAIycpWZxBYlZYsjBnEZPluzE22gbWaB6JbMZr9IArEACVFg9yKHlo/EfJXvHfZFESMzxWd4uqgSCh03jqcJucwU1V/97KuMkjebhe+OblyoqYypRoTlDYrbc3LMNaH4v97GQCudRzNzodbkXdz2pq6HdKs+9xJBjY7IyvU0zd7q8X0mLhUOCYzL2HDhH4s+zmPyVQt6YhHcT9qzupZ3WGzio3+A+oyR7PH3NAYPaiERWYy3bnEjSkaN9Tm0nAYHtDDRTX8ejsZFuzWUvMlQlUhH8npy0GbqQBlzq9zievtJ5uZpSOe+TF80uL2IjMKV1A+n/tGRnv6QysqXUTDqyZh+74uXU78aTelmygdVhQ1zvCZZZy3SddI+71aYyopvUam4yK1LbaiMxjKL
X-MS-Exchange-AntiSpam-MessageData: qy1rm+k/6/hF8/5On7a7fBPQrUdNxiv7MT3/dB0DItJciJ4oLLJgY7P2U4wyLPPmIdH9l/L5trt7NuO3wusu1/PTHFcyuXN+G/O9DZeBuyk/LuQJkSCVg0Fafo+mLRnf9RpzWiAgICij4kJv5UCZbw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc0f0fa-578a-4a05-f544-08d7bb41db0b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 04:59:42.0575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCA9XggfSf4SVg7Z32zKad73mtLEzJIq9AOV90X9iWfP/KsEmUUzKImIiuUnVZV7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2912
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Sandeep Singh <sandeep.singh@amd.com>

This part of module will provide the interaction between HID framework
and client driver.This modules will registered client driver with
HID framework.

Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
Signed-off-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/hid/amd-sfh-hid/amdsfh-hid-client.c | 256 ++++++++++++++++++++++++++++
 drivers/hid/amd-sfh-hid/amdsfh-hid.c        | 179 +++++++++++++++++++
 drivers/hid/amd-sfh-hid/amdsfh-hid.h        |  84 +++++++++
 3 files changed, 519 insertions(+)
 create mode 100644 drivers/hid/amd-sfh-hid/amdsfh-hid-client.c
 create mode 100644 drivers/hid/amd-sfh-hid/amdsfh-hid.c
 create mode 100644 drivers/hid/amd-sfh-hid/amdsfh-hid.h

diff --git a/drivers/hid/amd-sfh-hid/amdsfh-hid-client.c b/drivers/hid/amd-sfh-hid/amdsfh-hid-client.c
new file mode 100644
index 0000000..b321911
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/amdsfh-hid-client.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ *  AMD SFH Client Driver
+ *  Author: Nehal Bakulchandra Shah <Nehal-Bakulchandra.Shah@amd.com>
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+#include <linux/hid.h>
+#include <linux/list.h>
+#include <linux/platform_device.h>
+#include <linux/acpi.h>
+#include <linux/dma-mapping.h>
+#include "amdsfh-hid.h"
+#include "amd_mp2_pcie.h"
+#include "hid_descriptor/amd_sfh_hid_descriptor.h"
+
+#define DRIVER_DESC	"AMD(R) PCIe MP2 Communication Client Driver"
+#define DRIVER_NAME "AMD_SFH_HID_CLIENT"
+#define PERIOD  200
+
+struct request_list {
+	struct hid_device *hid;
+	struct list_head list;
+	u8 report_id;
+	u8 sensor_idx;
+	u8 report_type;
+	u8 current_index;
+};
+
+static struct request_list req_list;
+static struct amdtp_cl_data *cl_data_context;
+
+void amd_sfh_set_report(struct hid_device *hid, int report_id,
+			int report_type)
+{
+	struct amdtp_hid_data *hid_data = hid->driver_data;
+	struct amdtp_cl_data *cli_data = hid_data->cli_data;
+	int i;
+
+	for (i = 0; i < cli_data->num_hid_devices; i++) {
+		if (cli_data->hid_sensor_hubs[i] == hid) {
+			cli_data->cur_hid_dev = i;
+			break;
+		}
+	}
+	amdtp_hid_wakeup(hid);
+}
+EXPORT_SYMBOL(amd_sfh_set_report);
+
+void amd_sfh_get_report(struct hid_device *hid, int report_id,
+			int report_type)
+{
+	struct amdtp_hid_data *hid_data = hid->driver_data;
+	struct amdtp_cl_data *cli_data = hid_data->cli_data;
+	int i;
+
+	for (i = 0; i < cli_data->num_hid_devices; i++) {
+		if (cli_data->hid_sensor_hubs[i] == hid) {
+			struct request_list *new_request = kzalloc
+				  (sizeof(*new_request), GFP_KERNEL);
+			new_request->current_index = i;
+			new_request->sensor_idx = cli_data->sensor_idx[i];
+			new_request->hid = hid;
+			new_request->report_type = report_type;
+			new_request->report_id = report_id;
+			cli_data->report_id[i] = report_id;
+			cli_data->request_done[i] = false;
+			list_add(&new_request->list, &req_list.list);
+			break;
+		}
+	}
+	schedule_delayed_work(&cli_data->work, 0);
+}
+EXPORT_SYMBOL(amd_sfh_get_report);
+
+static void amd_sfh_work(struct work_struct *work)
+{
+	struct amdtp_cl_data *cli_data = amd_sfh_cldata(work);
+	struct request_list *req_node;
+	u8 report_size = 0;
+	u8 current_index;
+	u8 sensor_index;
+	u8 report_id;
+	u8 node_type;
+
+	req_node = list_last_entry(&req_list.list, struct request_list, list);
+	list_del(&req_node->list);
+	current_index = req_node->current_index;
+	sensor_index = req_node->current_index;
+	report_id = req_node->report_id;
+	node_type = req_node->report_type;
+
+	if (node_type == HID_FEATURE_REPORT) {
+		report_size = get_feature_report(sensor_index, report_id,
+						 cli_data->feature_report
+						 [current_index]);
+	} else if (node_type == HID_INPUT_REPORT) {
+		report_size = get_input_report(sensor_index, report_id,
+					       cli_data->input_report
+						[current_index],
+						cli_data->sensor_virt_addr
+						[current_index]);
+	}
+
+	hid_input_report(cli_data->hid_sensor_hubs[current_index],
+			 cli_data->report_type[current_index],
+				 cli_data->input_report[current_index],
+				report_size, 0);
+	cli_data->cur_hid_dev = current_index;
+	cli_data->sensor_requested_cnt[current_index] = 0;
+	amdtp_hid_wakeup(cli_data->hid_sensor_hubs[current_index]);
+}
+
+static void amd_sfh_work_buffer(struct work_struct *work)
+{
+	struct amdtp_cl_data *cli_data = cl_data_context;
+	unsigned int i;
+	u8 report_size = 0;
+
+	for (i = 0; i < cli_data->num_hid_devices; i++) {
+		report_size = get_input_report(cli_data->sensor_idx[i],
+					       cli_data->report_id[i],
+				cli_data->input_report[i],
+				cli_data->sensor_virt_addr[i]);
+		hid_input_report(cli_data->hid_sensor_hubs[i],
+				 HID_INPUT_REPORT,
+				 cli_data->input_report[i], report_size, 0);
+		}
+
+	schedule_delayed_work(&cli_data->work_buffer, PERIOD);
+}
+
+static int amd_sfh_hid_client_probe(struct platform_device *pdev)
+{
+	struct amd_mp2_sensor_info info;
+	int rc = 0;
+	int i;
+	struct amdtp_cl_device *cl_dev;
+	struct amdtp_cl_data *cl_data;
+	u32 feature_report_size = 0;
+	u32 input_report_size = 0;
+
+	cl_dev = devm_kzalloc(&pdev->dev, sizeof(*cl_dev), GFP_KERNEL);
+	if (!cl_dev)
+		return -ENOMEM;
+
+	cl_dev->pdev = pci_get_device(PCI_VENDOR_ID_AMD,
+				      PCI_DEVICE_ID_AMD_MP2, NULL);
+	if (!cl_dev->pdev)
+		return -ENOMEM;
+
+	cl_data = kzalloc(sizeof(*cl_data), GFP_KERNEL);
+	cl_data->num_hid_devices = amd_mp2_get_sensor_num
+				   (cl_dev->pdev, &cl_data->sensor_idx[0]);
+
+	INIT_DELAYED_WORK(&cl_data->work, amd_sfh_work);
+	INIT_DELAYED_WORK(&cl_data->work_buffer, amd_sfh_work_buffer);
+	INIT_LIST_HEAD(&req_list.list);
+
+	for (i = 0; i < cl_data->num_hid_devices; i++) {
+		cl_data->sensor_virt_addr[i] = dma_alloc_coherent
+			(&pdev->dev, sizeof(int) * 8,
+			&cl_data->sensor_phy_addr[i], GFP_KERNEL);
+		cl_data->sensor_sts[i] = 0;
+		cl_data->sensor_requested_cnt[i] = 0;
+		cl_data->cur_hid_dev = i;
+
+		cl_data->report_descr_size[i] = get_descriptor_size
+				(cl_data->sensor_idx[i], descr_size);
+
+		feature_report_size = get_descriptor_size
+				(cl_data->sensor_idx[i], feature_size);
+
+		input_report_size =  get_descriptor_size
+			(cl_data->sensor_idx[i], input_size);
+
+		cl_data->feature_report[i] = kzalloc(feature_report_size,
+						     GFP_KERNEL);
+		cl_data->input_report[i] = kzalloc(input_report_size,
+						   GFP_KERNEL);
+		info.period = PERIOD;
+		info.sensor_idx = cl_data->sensor_idx[i];
+		info.phy_address = cl_data->sensor_phy_addr[i];
+		cl_data->report_descr[i] = kzalloc
+			(cl_data->report_descr_size[i], GFP_KERNEL);
+		if (!cl_data->report_descr[i])
+			return -ENOMEM;
+		rc = get_report_descriptor(cl_data->sensor_idx[i],
+					   cl_data->report_descr[i]);
+		rc = amdtp_hid_probe(cl_data->cur_hid_dev, cl_data);
+		amd_start_sensor(cl_dev->pdev, info);
+		cl_data->sensor_sts[i] = 1;
+	}
+
+	cl_dev->cl_data = cl_data;
+	cl_data_context = cl_data;
+	platform_set_drvdata(pdev, cl_dev);
+	schedule_delayed_work(&cl_data->work_buffer, PERIOD);
+	return 0;
+}
+
+static int amd_sfh_hid_client_remove(struct platform_device *pdev)
+{
+	int i;
+	struct amdtp_cl_device *cl_dev;
+	struct amdtp_cl_data *cl_data;
+
+	cl_dev = platform_get_drvdata(pdev);
+	if (!(cl_dev))
+		return -EINVAL;
+
+	cl_data = cl_dev->cl_data;
+	if (!(cl_data))
+		return -EINVAL;
+
+	for (i = 0; i < cl_data->num_hid_devices; i++)
+		amd_stop_sensor(cl_dev->pdev, i);
+
+	cancel_delayed_work_sync(&cl_data->work);
+	cancel_delayed_work_sync(&cl_data->work_buffer);
+	amdtp_hid_remove(cl_data);
+
+	for (i = 0; i < cl_data->num_hid_devices; i++) {
+		if (cl_data->sensor_virt_addr[i])
+			dma_free_coherent(&pdev->dev, 8 * sizeof(int),
+					  cl_data->sensor_virt_addr[i],
+					  cl_data->sensor_phy_addr[i]);
+	}
+
+	kfree(cl_data);
+	pr_info("%s:%s Exit\n", DRIVER_NAME, __func__);
+	return 0;
+}
+
+static const struct acpi_device_id amd_sfh_acpi_match[] = { {
+					"AMDI0080" },
+					{ },
+};
+
+MODULE_DEVICE_TABLE(acpi, amd_sfh_acpi_match);
+static struct platform_driver amd_sfh_plat_driver = {
+	.probe = amd_sfh_hid_client_probe,
+	.remove = amd_sfh_hid_client_remove,
+	.driver = {
+			.name = "amd_sfh_platform",
+			.acpi_match_table = ACPI_PTR(amd_sfh_acpi_match),
+	},
+};
+module_platform_driver(amd_sfh_plat_driver);
+MODULE_DESCRIPTION("AMD(R) SFH Client Driver");
+MODULE_AUTHOR("Nehal Shah <nehal-bakulchandra.shah@amd.com>");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/hid/amd-sfh-hid/amdsfh-hid.c b/drivers/hid/amd-sfh-hid/amdsfh-hid.c
new file mode 100644
index 0000000..89fe35a8
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/amdsfh-hid.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * AMD MP2 Sensors transport  driver
+ *
+ * Authors: Sandeep Singh <sandeep.singh@amd.com>
+ *          Nehal Bakulchandra Shah <Nehal-bakulchandra.shah@amd.com>
+ */
+#include <linux/hid.h>
+#include <linux/wait.h>
+#include <linux/sched.h>
+#include "amdsfh-hid.h"
+
+#define DRIVER_NAME "AMD_MP2_SENSORS_TRANSPORT"
+
+/**
+ * amdtp_hid_parse() - hid-core .parse() callback
+ * @hid:	hid device instance
+ *
+ * This function gets called during call to hid_add_device
+ *
+ * Return: 0 on success and non zero on error
+ */
+static int amdtp_hid_parse(struct hid_device *hid)
+{
+	struct amdtp_hid_data *hid_data = hid->driver_data;
+	struct amdtp_cl_data *cli_data = hid_data->cli_data;
+	int rc;
+
+	rc = hid_parse_report(hid, cli_data->report_descr[hid_data->index],
+			      cli_data->report_descr_size[hid_data->index]);
+	if (rc)
+		return rc;
+	return 0;
+}
+
+/* Empty callbacks with success return code */
+static int amdtp_hid_start(struct hid_device *hid)
+{
+	return 0;
+}
+
+static void amdtp_hid_stop(struct hid_device *hid)
+{
+}
+
+static int amdtp_hid_open(struct hid_device *hid)
+{
+	return 0;
+}
+
+static void amdtp_hid_close(struct hid_device *hid)
+{
+}
+
+static int amdtp_raw_request(struct hid_device *hdev, unsigned char reportnum,
+			     u8 *buf, size_t len, unsigned char rtype,
+			     int reqtype)
+{
+	return 0;
+}
+
+static void amdtp_hid_request(struct hid_device *hid, struct hid_report *rep,
+			      int reqtype)
+{
+	switch (reqtype) {
+	case HID_REQ_GET_REPORT:
+		amd_sfh_get_report(hid, rep->id, rep->type);
+		break;
+	case HID_REQ_SET_REPORT:
+		amd_sfh_set_report(hid, rep->id, reqtype);
+		break;
+	}
+}
+
+static int amdtp_wait_for_response(struct hid_device *hid)
+{
+	struct amdtp_hid_data *hid_data =  hid->driver_data;
+	struct amdtp_cl_data *cli_data = hid_data->cli_data;
+	int i = 0;
+
+	for (i = 0; i < cli_data->num_hid_devices; i++) {
+		if (cli_data->hid_sensor_hubs[i] == hid)
+			break;
+	}
+	if (!cli_data->request_done[i])
+		wait_event_interruptible_timeout(hid_data->hid_wait,
+						 cli_data->request_done[i],
+						 1500);
+	if (!cli_data->request_done[i]) {
+		hid_err(hid,
+			"timeout waiting for response from  device\n");
+		return -ETIMEDOUT;
+	}
+	cli_data->request_done[i] = false;
+
+	return 0;
+}
+
+void amdtp_hid_wakeup(struct hid_device *hid)
+{
+	struct amdtp_hid_data *hid_data = hid->driver_data;
+	struct amdtp_cl_data *cli_data = hid_data->cli_data;
+
+	cli_data->request_done[cli_data->cur_hid_dev] = true;
+	wake_up_interruptible(&hid_data->hid_wait);
+}
+
+static struct hid_ll_driver amdtp_hid_ll_driver = {
+	.parse	=	amdtp_hid_parse,
+	.start	=	amdtp_hid_start,
+	.stop	=	amdtp_hid_stop,
+	.open	=	amdtp_hid_open,
+	.close	=	amdtp_hid_close,
+	.request  =	amdtp_hid_request,
+	.wait	=	amdtp_wait_for_response,
+	.raw_request  =	amdtp_raw_request,
+};
+
+int amdtp_hid_probe(unsigned int cur_hid_dev,
+		    struct amdtp_cl_data *cli_data)
+{
+	int rc;
+	struct hid_device *hid;
+	struct amdtp_hid_data *hid_data;
+
+	hid = hid_allocate_device();
+	if (IS_ERR(hid)) {
+		rc = PTR_ERR(hid);
+		return -ENOMEM;
+	}
+
+	hid_data = kzalloc(sizeof(*hid_data), GFP_KERNEL);
+	if (!hid_data) {
+		rc = -ENOMEM;
+		goto err_hid_data;
+	}
+
+	hid->ll_driver = &amdtp_hid_ll_driver;
+	hid_data->index = cur_hid_dev;
+	hid_data->cli_data = cli_data;
+	init_waitqueue_head(&hid_data->hid_wait);
+
+	hid->driver_data = hid_data;
+	cli_data->hid_sensor_hubs[cur_hid_dev] = hid;
+	hid->bus = BUS_AMD_AMDTP;
+	hid->version = AMD_SFH_HID_VERSION;
+	hid->vendor = AMD_SFH_HID_VENDOR;
+	hid->product = AMD_SFH_HID_PRODUCT;
+	snprintf(hid->name, sizeof(hid->name), "%s %04X:%04X", "hid-amdtp",
+		 hid->vendor, hid->product);
+
+	rc = hid_add_device(hid);
+	if (rc)
+		goto err_hid_device;
+
+	return 0;
+
+err_hid_device:
+	kfree(hid_data);
+err_hid_data:
+	hid_destroy_device(hid);
+	return rc;
+}
+
+void amdtp_hid_remove(struct amdtp_cl_data *cli_data)
+{
+	int i;
+
+	for (i = 0; i < cli_data->num_hid_devices; ++i) {
+		kfree(cli_data->feature_report[i]);
+		kfree(cli_data->input_report[i]);
+		kfree(cli_data->report_descr[i]);
+		if (cli_data->hid_sensor_hubs[i]) {
+			kfree(cli_data->hid_sensor_hubs[i]->driver_data);
+			hid_destroy_device(cli_data->hid_sensor_hubs[i]);
+			cli_data->hid_sensor_hubs[i] = NULL;
+		}
+	}
+}
diff --git a/drivers/hid/amd-sfh-hid/amdsfh-hid.h b/drivers/hid/amd-sfh-hid/amdsfh-hid.h
new file mode 100644
index 0000000..129459c
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/amdsfh-hid.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * AMD MP2 Sensors transport  driver
+ *
+ * Authors: Sandeep Singh <sandeep.singh@amd.com>
+ *          Nehal Bakulchandra Shah <Nehal-bakulchandra.shah@amd.com>
+ */
+
+#ifndef AMDSFH_HID_H
+#define AMDSFH_HID_H
+#include <linux/debugfs.h>
+
+#define MAX_HID_DEVICES		4
+#define DCD_DATA_SIZE_CHAR	512
+#define BUS_AMD_AMDTP		0x20
+#define AMD_SFH_HID_VENDOR	1022
+#define AMD_SFH_HID_PRODUCT	0x0001
+#define AMD_SFH_HID_VERSION	0x0001
+
+struct amdtp_cl_device {
+	struct pci_dev *pdev;
+	struct amdtp_cl_data *cl_data;
+};
+
+struct amdtp_cl_data {
+	u8 init_done;
+	unsigned int cur_hid_dev;
+	unsigned int hid_dev_count;
+	unsigned int num_hid_devices;
+	struct device_info *hid_devices;
+	unsigned char *report_descr[MAX_HID_DEVICES];
+	int report_descr_size[MAX_HID_DEVICES];
+	struct hid_device *hid_sensor_hubs[MAX_HID_DEVICES];
+	unsigned char *hid_descr[MAX_HID_DEVICES];
+	int hid_descr_size[MAX_HID_DEVICES];
+	phys_addr_t phy_addr_base;
+	u32 *sensor_virt_addr[MAX_HID_DEVICES];
+	phys_addr_t sensor_phy_addr[MAX_HID_DEVICES];
+	u32 sensor_sts[MAX_HID_DEVICES];
+	u32 sensor_requested_cnt[MAX_HID_DEVICES];
+	u8 report_type[MAX_HID_DEVICES];
+	u8 report_id[MAX_HID_DEVICES];
+	u8 sensor_idx[MAX_HID_DEVICES];
+	u8 *feature_report[MAX_HID_DEVICES];
+	u8 *input_report[MAX_HID_DEVICES];
+	u8 request_done[MAX_HID_DEVICES];
+	struct delayed_work work;
+	struct delayed_work work_buffer;
+
+};
+
+/**
+ * struct amdtp_hid_data - Per instance HID data
+ * @index:		Device index in the order of enumeration
+ * @request_done:	Get Feature/Input report complete flag
+ *			used during get/set request from hid core
+ * @cli_data:		Link to the client instance
+ * @hid_wait:		Completion waitq
+ *
+ * Used to tie hid hid->driver data to driver client instance
+ */
+struct amdtp_hid_data {
+	int index;
+	struct amdtp_cl_data *cli_data;
+	wait_queue_head_t hid_wait;
+};
+
+/* Interface functions between HID LL driver and AMD SFH client */
+void hid_amdtp_set_feature(struct hid_device *hid, char *buf, unsigned int len,
+			   int report_id);
+void hid_amdtp_get_report(struct hid_device *hid, int report_id,
+			  int report_type);
+int amdtp_hid_probe(unsigned int cur_hid_dev,
+		    struct amdtp_cl_data *cli_data);
+void amdtp_hid_remove(struct amdtp_cl_data *cli_data);
+void amd_sfh_get_report(struct hid_device *hid, int report_id,
+			int report_type);
+void amd_sfh_set_report(struct hid_device *hid, int report_id,
+			int report_type);
+void amdtp_hid_wakeup(struct hid_device *hid);
+
+#define amd_sfh_cldata(__work) container_of(__work,\
+					struct amdtp_cl_data, work.work)
+#endif	/* AMDSFH_HID */
-- 
2.7.4

