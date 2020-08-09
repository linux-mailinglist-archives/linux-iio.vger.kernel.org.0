Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B8223FDB1
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 12:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgHIK0C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 06:26:02 -0400
Received: from mail-dm6nam10on2065.outbound.protection.outlook.com ([40.107.93.65]:19265
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbgHIK0A (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 06:26:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mul/+9F3dqK1e140dnyzkCFdghskZJgCX5fBx0EuduoXvmWonxFmUHyR/nHlDY+4O+D94WNeT+Ty5Yoi+uJL/1TXYzqcKtJnhqElEWt7LcharloIqPvltTuhFy22fyqieRFqXCVBAK8Md/Gb2/oV/vtJhWN13YA61zXEnDsl+rTtFD+J5HmguLureWasbdM4QKRti3ZiEzwbeNsThh4mer55tJfV4YZGfou7sOpD5FxfVMl7xeTMzdhcnpZt3+m1cFcFWbJBNwF3SQXRHvMvtDUFBv7lS7AYLzmCHFeegBf6uyZN5G51OE9Z6YMfGOJEoV9Xf1WklVR4hWkudw8u7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52z+IliZEZvo0e8SB7pNzsXkZ2ee5mjDZhamyeg7Vi4=;
 b=lZCR3mwtQLUAHXTQEbxzKPgikZceHq4QW0SVZofKPUvRakAlaBHqIJEBPnBA5iDTeI7isPzXSh2BK3dQyLaoVv8vFbyHjPrYxEG4QHFAV8rww6xj52FM78NxCbeEFez2WQbWigm1EtSuoaPoVFeodwxeDa6U5KjiY3VVF2pO0+uTNTexg7FCa35Q+uFY7LiqZahWeDn4OkBJkDVWGjafCmAYiup/URRYnKEdFd46sHRaoQU+9BduaDR2w23TMf3RkwKFHkPg0YV/1OXn+YLsYpD6M82vLMqO0hldgG9b2Tu8xVfGQIpu989w78DxKDhNfLcOAu0P0nzvuDj4Dq2IjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52z+IliZEZvo0e8SB7pNzsXkZ2ee5mjDZhamyeg7Vi4=;
 b=G1PCSPMCopRLvSg3ELM106p51SR+RsaESKdaTwskxz/vQFLGb8EpBCXO/Jg9gPswxEiM6sQ3PEpJ7LQd6SXoAzpNou8cQRLAScJYLv7FLBd12e+PfPeyXleySYir3gQBINY9Ho2HqnBKQVOp5IoePYnd7AjJyAbpXr2/yhhtg2Q=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2726.namprd12.prod.outlook.com (2603:10b6:a03:66::17)
 by BY5PR12MB3778.namprd12.prod.outlook.com (2603:10b6:a03:1a6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Sun, 9 Aug
 2020 10:25:54 +0000
Received: from BYAPR12MB2726.namprd12.prod.outlook.com
 ([fe80::8503:3713:6ed0:af09]) by BYAPR12MB2726.namprd12.prod.outlook.com
 ([fe80::8503:3713:6ed0:af09%6]) with mapi id 15.20.3261.022; Sun, 9 Aug 2020
 10:25:54 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com, andy.shevchenko@gmail.com,
        mail@richard-neumann.de, m.felsch@pengutronix.de
Cc:     Shyam-sundar.S-k@amd.com, Sandeep Singh <sandeep.singh@amd.com>
Subject: [PATCH v6 3/4] SFH: Transport Driver to add support of AMD Sensor Fusion Hub (SFH)
Date:   Sun,  9 Aug 2020 10:25:10 +0000
Message-Id: <20200809102511.2657644-4-Sandeep.Singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200809102511.2657644-1-Sandeep.Singh@amd.com>
References: <20200809102511.2657644-1-Sandeep.Singh@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::30) To BYAPR12MB2726.namprd12.prod.outlook.com
 (2603:10b6:a03:66::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jatayu.amd.com (165.204.156.251) by MA1PR0101CA0044.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19 via Frontend Transport; Sun, 9 Aug 2020 10:25:50 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9e0ce187-f909-4cd0-8ef8-08d83c4e988e
X-MS-TrafficTypeDiagnostic: BY5PR12MB3778:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB377869B000B3A8B3D5586181E0470@BY5PR12MB3778.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:117;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9bqCLF3I+kxBOhBMDMtKFMz3Am6cBePygvVOCVcNjp62xHDplCc6FE0U1VeCISCSabGobmGAFqnfrvdMr9fYdnfwK6OTesKPQ1y41O0o3UtAneYdhsUFHPBuyX5/rXIg2fvKiUj+SouyVyTykQz40s3SHvNSF1moz5V9q0ieRTr5L3BbQiWDkxCnzsVGrom44MTN6MHPqBJK4nKVOkedFXgY8ZI0fugbKUp2VP9DwyPKwSRzZkBEai7MI9gyKOnis+xZCVV3ghkWVOXACeqa8erjcds/+RF8hcdVolMuwc27xsqiAeYG2AZfiMDDNg0zo7EABvAJdC0mW9VtMlyL2rVrrZB4pRdmGC3vco+u5J73dmyxYFjNJbrQtGY7tFYO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39850400004)(1076003)(30864003)(7416002)(956004)(5660300002)(83380400001)(2616005)(66556008)(66476007)(16526019)(6486002)(66946007)(26005)(186003)(7696005)(8676002)(8936002)(36756003)(316002)(2906002)(6666004)(86362001)(478600001)(4326008)(52116002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: wMbmpDpT5ymrGT+dUDVpAiPaERLmg3oCTbD09Xz2ObCKuUNwejoPP+qB8ShaJwV8XpeHDUfpalis6aRwyJt2P7Mh9XfMIIAo//UyROqGqMJVcQBejXT9Q/T4RulrWIcTbJ8ul5c0PSQww1Tf5q7nuSkdO2q4rM1gBlEn+TrEkxYkEHmrg5rSjhMeRHDNhJTToFVzrCWqAj9lu68h0koFO2TnYOS5bNbD+IzPpHwNPR0Qau/6w+dEBTPv5EDY9oUlPshJPfgNmsHIt1+RtdYrNjWXr6uHvCM1jb5G4E95AAfHGQJ7OA6vFZGdMG0p4vAd5+ThbbOyN6BWK/Vcr3/kj6NBw6hcE3KWYow9iYZ9k4jpD8HzB3kKujc8u6p/Fys4uD7+9fhV7tGiCa2Y6ujowU3qGSWKmKJ3IH7FbXvwD+g4W6RzSUcAT49pfL6RbxMTA5/Wm5N/+MFLf3dONTywcMhziOyrDsgpf2kBjdM49eiyT6iFojiolBkbP/L2YIIfEHNgAtJvPsugSZ6uHAOj+dhdhGGGFljcdA+ryDllTgahQNv9JfC4P/UOrS+0yAhLvikPmfcNXMkWZUDRljNGGTHva5nVLrdCbKSbzd4Zda3fRumD9QR1Dku/Z771ptgH8T7QDjGUSaKmjgmoDikWeQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0ce187-f909-4cd0-8ef8-08d83c4e988e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2020 10:25:53.9529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZdHowHFRRGaS3RKBjossPwHpu/71z1c+UMJQsshnGx4jVXt1d9eLfP3YhJomgFl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3778
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Sandeep Singh <sandeep.singh@amd.com>

This part of module will provide the interaction between HID framework
and client layer.This modules will registered client layer with
HID framework.

Signed-off-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
---
 drivers/hid/amd-sfh-hid/amdsfh_hid.c        | 175 ++++++++++++++++
 drivers/hid/amd-sfh-hid/amdsfh_hid.h        |  68 ++++++
 drivers/hid/amd-sfh-hid/amdsfh_hid_client.c | 220 ++++++++++++++++++++
 3 files changed, 463 insertions(+)
 create mode 100644 drivers/hid/amd-sfh-hid/amdsfh_hid.c
 create mode 100644 drivers/hid/amd-sfh-hid/amdsfh_hid.h
 create mode 100644 drivers/hid/amd-sfh-hid/amdsfh_hid_client.c

diff --git a/drivers/hid/amd-sfh-hid/amdsfh_hid.c b/drivers/hid/amd-sfh-hid/amdsfh_hid.c
new file mode 100644
index 000000000000..645c41174bca
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/amdsfh_hid.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD MP2 Sensors transport driver
+ *
+ * Authors: Nehal Bakulchandra Shah <Nehal-bakulchandra.shah@amd.com>
+ *	    Sandeep Singh <sandeep.singh@amd.com>
+ */
+#include <linux/hid.h>
+#include <linux/wait.h>
+#include <linux/sched.h>
+#include "amdsfh_hid.h"
+
+#define DRIVER_NAME "AMD_MP2_SENSORS_TRANSPORT"
+
+/*
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
+
+	return hid_parse_report(hid, cli_data->report_descr[hid_data->index],
+			      cli_data->report_descr_sz[hid_data->index]);
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
+static int amdtp_raw_request(struct hid_device *hdev, u8 reportnum,
+			     u8 *buf, size_t len, u8 rtype, int reqtype)
+{
+	return 0;
+}
+
+static void amdtp_hid_request(struct hid_device *hid, struct hid_report *rep, int reqtype)
+{
+	int rc;
+
+	switch (reqtype) {
+	case HID_REQ_GET_REPORT:
+		rc = amd_sfh_get_report(hid, rep->id, rep->type);
+		if (rc)
+			pr_err("AMDSFH  get report error ");
+		break;
+	case HID_REQ_SET_REPORT:
+		amd_sfh_set_report(hid, rep->id, reqtype);
+		break;
+	default:
+		break;
+	}
+}
+
+static int amdtp_wait_for_response(struct hid_device *hid)
+{
+	struct amdtp_hid_data *hid_data =  hid->driver_data;
+	struct amdtp_cl_data *cli_data = hid_data->cli_data;
+	int i, ret = 0;
+
+	for (i = 0; i < cli_data->num_hid_devices; i++) {
+		if (cli_data->hid_sensor_hubs[i] == hid)
+			break;
+	}
+
+	if (!cli_data->request_done[i])
+		ret = wait_event_interruptible_timeout(hid_data->hid_wait,
+						       cli_data->request_done[i], 1500);
+	if (ret > 0)
+		return 0;
+	else if (ret == -ERESTARTSYS)
+		return -ERESTARTSYS;
+	else
+		return -ETIMEDOUT;
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
+int amdtp_hid_probe(u32 cur_hid_dev,
+		    struct amdtp_cl_data *cli_data)
+{
+	struct hid_device *hid;
+	struct amdtp_hid_data *hid_data;
+	int rc;
+
+	hid = hid_allocate_device();
+	if (IS_ERR(hid)) {
+		rc = PTR_ERR(hid);
+		return rc;
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
+	hid->vendor = AMD_SFH_HID_VENDOR;
+	hid->product = AMD_SFH_HID_PRODUCT;
+	snprintf(hid->name, sizeof(hid->name), "%s %04X:%04X", "hid-amdtp",
+		 hid->vendor, hid->product);
+
+	rc = hid_add_device(hid);
+	if (rc)
+		goto err_hid_device;
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
diff --git a/drivers/hid/amd-sfh-hid/amdsfh_hid.h b/drivers/hid/amd-sfh-hid/amdsfh_hid.h
new file mode 100644
index 000000000000..b4b14b46f2e1
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/amdsfh_hid.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * AMD MP2 Sensors transport driver
+ *
+ * Authors: Nehal Bakulchandra Shah <Nehal-bakulchandra.shah@amd.com>
+ *	    Sandeep Singh <sandeep.singh@amd.com>
+ */
+
+#ifndef AMDSFH_HID_H
+#define AMDSFH_HID_H
+
+#define MAX_HID_DEVICES		4
+#define DCD_DATA_SIZE_CHAR	512
+#define BUS_AMD_AMDTP		0x20
+#define AMD_SFH_HID_VENDOR	1022
+#define AMD_SFH_HID_PRODUCT	0x0001
+
+struct amdtp_cl_data {
+	u8 init_done;
+	u32 cur_hid_dev;
+	u32 hid_dev_count;
+	u32 num_hid_devices;
+	struct device_info *hid_devices;
+	u8  *report_descr[MAX_HID_DEVICES];
+	int report_descr_sz[MAX_HID_DEVICES];
+	struct hid_device *hid_sensor_hubs[MAX_HID_DEVICES];
+	u8 *hid_descr[MAX_HID_DEVICES];
+	int hid_descr_size[MAX_HID_DEVICES];
+	phys_addr_t phys_addr_base;
+	u32 *sensor_virt_addr[MAX_HID_DEVICES];
+	phys_addr_t sensor_phys_addr[MAX_HID_DEVICES];
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
+void hid_amdtp_set_feature(struct hid_device *hid, char *buf, u32 len, int report_id);
+void hid_amdtp_get_report(struct hid_device *hid, int report_id, int report_type);
+int amdtp_hid_probe(u32 cur_hid_dev, struct amdtp_cl_data *cli_data);
+void amdtp_hid_remove(struct amdtp_cl_data *cli_data);
+int amd_sfh_get_report(struct hid_device *hid, int report_id, int report_type);
+void amd_sfh_set_report(struct hid_device *hid, int report_id, int report_type);
+void amdtp_hid_wakeup(struct hid_device *hid);
+#endif
diff --git a/drivers/hid/amd-sfh-hid/amdsfh_hid_client.c b/drivers/hid/amd-sfh-hid/amdsfh_hid_client.c
new file mode 100644
index 000000000000..476fa26a1e62
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/amdsfh_hid_client.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  AMD SFH Client Layer
+ *  Copyright 2020 Advanced Micro Devices, Inc.
+ *  Authors: Nehal Bakulchandra Shah <Nehal-Bakulchandra.Shah@amd.com>
+ *	     Sandeep Singh <Sandeep.singh@amd.com>
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/hid.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+#include <uapi/asm-generic/errno-base.h>
+#include "hid_descriptor/amd_sfh_hid_descriptor.h"
+#include "amdsfh_hid.h"
+#include "amd_mp2_pcie.h"
+
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
+
+int amd_sfh_get_report(struct hid_device *hid, int report_id, int report_type)
+{
+	struct amdtp_hid_data *hid_data = hid->driver_data;
+	struct amdtp_cl_data *cli_data = hid_data->cli_data;
+	int i;
+
+	for (i = 0; i < cli_data->num_hid_devices; i++) {
+		if (cli_data->hid_sensor_hubs[i] == hid) {
+			struct request_list *new = kzalloc(sizeof(*new), GFP_KERNEL);
+
+			if (!new)
+				return -ENOMEM;
+			new->current_index = i;
+			new->sensor_idx = cli_data->sensor_idx[i];
+			new->hid = hid;
+			new->report_type = report_type;
+			new->report_id = report_id;
+			cli_data->report_id[i] = report_id;
+			cli_data->request_done[i] = false;
+			list_add(&new->list, &req_list.list);
+			break;
+		}
+	}
+	schedule_delayed_work(&cli_data->work, 0);
+	return 0;
+}
+
+static void amd_sfh_work(struct work_struct *work)
+{
+	struct amdtp_cl_data *cli_data = container_of(work, struct amdtp_cl_data, work.work);
+	struct request_list *req_node;
+	u8 current_index, sensor_index;
+	u8 report_id, node_type;
+	u8 report_size = 0;
+
+	req_node = list_last_entry(&req_list.list, struct request_list, list);
+	list_del(&req_node->list);
+	current_index = req_node->current_index;
+	sensor_index = req_node->sensor_idx;
+	report_id = req_node->report_id;
+	node_type = req_node->report_type;
+
+	if (node_type == HID_FEATURE_REPORT) {
+		report_size = get_feature_report(sensor_index, report_id,
+						 cli_data->feature_report[current_index]);
+		if (report_size)
+			hid_input_report(cli_data->hid_sensor_hubs[current_index],
+					 cli_data->report_type[current_index],
+					 cli_data->feature_report[current_index], report_size, 0);
+		else
+			pr_err("AMDSFH: Invalid report size\n");
+
+	} else if (node_type == HID_INPUT_REPORT) {
+		report_size = get_input_report(sensor_index, report_id,
+					       cli_data->input_report[current_index],
+					       cli_data->sensor_virt_addr[current_index]);
+		if (report_size)
+			hid_input_report(cli_data->hid_sensor_hubs[current_index],
+					 cli_data->report_type[current_index],
+					 cli_data->input_report[current_index], report_size, 0);
+		else
+			pr_err("AMDSFH: Invalid report size\n");
+	}
+	cli_data->cur_hid_dev = current_index;
+	cli_data->sensor_requested_cnt[current_index] = 0;
+	amdtp_hid_wakeup(cli_data->hid_sensor_hubs[current_index]);
+}
+
+static void amd_sfh_work_buffer(struct work_struct *work)
+{
+	struct amdtp_cl_data *cli_data = container_of(work, struct amdtp_cl_data, work_buffer.work);
+	u8 report_size;
+	int i;
+
+	for (i = 0; i < cli_data->num_hid_devices; i++) {
+		report_size = get_input_report(cli_data->sensor_idx[i], cli_data->report_id[i],
+					       cli_data->input_report[i],
+					       cli_data->sensor_virt_addr[i]);
+		hid_input_report(cli_data->hid_sensor_hubs[i], HID_INPUT_REPORT,
+				 cli_data->input_report[i], report_size, 0);
+	}
+	schedule_delayed_work(&cli_data->work_buffer, PERIOD);
+}
+
+int amd_sfh_hid_client_init(struct amd_mp2_dev *privdata)
+{
+	struct amdtp_cl_data *cl_data = privdata->cl_data;
+	struct amd_mp2_sensor_info info;
+	struct device *dev;
+	u32 feature_report_size;
+	u32 input_report_size;
+	u8 cl_idx;
+	int rc, i;
+
+	dev = &privdata->pdev->dev;
+	cl_data = kzalloc(sizeof(*cl_data), GFP_KERNEL);
+	if (!cl_data)
+		return -ENOMEM;
+
+	cl_data->num_hid_devices = amd_mp2_get_sensor_num(privdata, &cl_data->sensor_idx[0]);
+
+	INIT_DELAYED_WORK(&cl_data->work, amd_sfh_work);
+	INIT_DELAYED_WORK(&cl_data->work_buffer, amd_sfh_work_buffer);
+	INIT_LIST_HEAD(&req_list.list);
+
+	for (i = 0; i < cl_data->num_hid_devices; i++) {
+		cl_data->sensor_virt_addr[i] = dma_alloc_coherent(dev, sizeof(int) * 8,
+								  &cl_data->sensor_phys_addr[i],
+								  GFP_KERNEL);
+		cl_data->sensor_sts[i] = 0;
+		cl_data->sensor_requested_cnt[i] = 0;
+		cl_data->cur_hid_dev = i;
+		cl_idx = cl_data->sensor_idx[i];
+		cl_data->report_descr_sz[i] = get_descr_sz(cl_idx, descr_size);
+		if (!cl_data->report_descr_sz[i])
+			return -EINVAL;
+
+		feature_report_size = get_descr_sz(cl_idx, feature_size);
+		if (!feature_report_size)
+			return -EINVAL;
+
+		input_report_size =  get_descr_sz(cl_idx, input_size);
+		if (!input_report_size)
+			return -EINVAL;
+
+		cl_data->feature_report[i] = kzalloc(feature_report_size, GFP_KERNEL);
+		if (!cl_data->feature_report[i])
+			return -ENOMEM;
+
+		cl_data->input_report[i] = kzalloc(input_report_size, GFP_KERNEL);
+		if (!cl_data->input_report[i])
+			return -ENOMEM;
+
+		info.period = PERIOD;
+		info.sensor_idx = cl_idx;
+		info.phys_address = cl_data->sensor_phys_addr[i];
+
+		cl_data->report_descr[i] = kzalloc(cl_data->report_descr_sz[i], GFP_KERNEL);
+		if (!cl_data->report_descr[i])
+			return -ENOMEM;
+
+		rc = get_report_descriptor(cl_idx, cl_data->report_descr[i]);
+		rc = amdtp_hid_probe(cl_data->cur_hid_dev, cl_data);
+		amd_start_sensor(privdata, info);
+		cl_data->sensor_sts[i] = 1;
+	}
+	privdata->cl_data = cl_data;
+	schedule_delayed_work(&cl_data->work_buffer, PERIOD);
+	return 0;
+}
+
+int amd_sfh_hid_client_deinit(struct amd_mp2_dev *privdata)
+{
+	struct amdtp_cl_data *cl_data = privdata->cl_data;
+	int i;
+
+	for (i = 0; i < cl_data->num_hid_devices; i++)
+		amd_stop_sensor(privdata, i);
+
+	cancel_delayed_work_sync(&cl_data->work);
+	cancel_delayed_work_sync(&cl_data->work_buffer);
+	amdtp_hid_remove(cl_data);
+
+	for (i = 0; i < cl_data->num_hid_devices; i++) {
+		if (cl_data->sensor_virt_addr[i]) {
+			dma_free_coherent(&privdata->pdev->dev, 8 * sizeof(int),
+					  cl_data->sensor_virt_addr[i],
+					  cl_data->sensor_phys_addr[i]);
+		}
+	}
+	kfree(cl_data);
+	return 0;
+}
-- 
2.25.1

