Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042C92897D5
	for <lists+linux-iio@lfdr.de>; Fri,  9 Oct 2020 22:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgJIUF0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Oct 2020 16:05:26 -0400
Received: from mail-eopbgr690078.outbound.protection.outlook.com ([40.107.69.78]:9094
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731875AbgJIUCi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 9 Oct 2020 16:02:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUX9a4ll8iQvyjBZ7xgPwQN2UTHJ/KCGG+4cW1tFIyybAlqNuTeKLJ0dz4X0DxDs+/Eb4xENXNTO59OET3RZtae5M9Ncsutk67UR0ucpw0oi/EaRRjjXbvEo8GFtTsAgQJhwruej94l9fNtuQNntwehByjMZtPVrla12hbWt0tMW00MPORVARUYYJbLXmdR8+NT8pClrLD3x57Y9SUQiwAtGWj6j4qG0L+Aq2o+pm2TJvzEMAEgFOhAmMAgEKWmmNs2CwUZe0ge/nC9bgcKA/1o0reZy4cUshbGQlW8RFrIOFBCngWAv+VWx3PHLsXkW/4gRx0Q262yWP2YTp0j1mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osFZfrnhp1lIp5+61WPBIeyKxtum4GaCvbXSqKXwtjA=;
 b=MdHIoBHY/4voJ9il9KleypuWxTiI+uYt+1vn2kqDh8jQwRaOoaaOT2kJG5pAtDPdl6XETkJqqM5uqBiv9lEoC5vxYQok8Jdfj4dq2SAZUhsX3Z3+IRqxRepMZkC6tVWCaaP5dgM58hCoEmWtIN1gfsPfInOk3I9hMOx2YdFI/bdY9AtytWBI9acGL76D7UQ4xpDkuQebzo5+hHIcW9Ql4W6c9NObuzJjuknaHFVABEzl5nD/r1sUE1eN2p78ijez983D6EdO1s3RgGVcWSW/TQEDAYMa9lqFOyKyUIZFMXJC9QnAZUQcVE4VTQB8nUdjz2dmAIpixwGzhepXDmgmgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osFZfrnhp1lIp5+61WPBIeyKxtum4GaCvbXSqKXwtjA=;
 b=VonfYPVqBHDOLLZa2ibq0q2kr9l3PCEXWI7lDHZJ593vhicm/v1NPdG/Bajo9+FNAkC6lycYdmSD1BAvQ2RXpEzylUuW+dAD4DY8ZjWJF+onBUVU0yaREELNCbzj5ynS85cmDu7C5xxVnb06bPb+MtNFHgNDeNr5bFQxoxsP3s0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB4040.namprd12.prod.outlook.com (2603:10b6:610:ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Fri, 9 Oct
 2020 20:02:30 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::a110:b7c8:73bd:d60]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::a110:b7c8:73bd:d60%8]) with mapi id 15.20.3455.027; Fri, 9 Oct 2020
 20:02:30 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com, andy.shevchenko@gmail.com,
        mail@richard-neumann.de, m.felsch@pengutronix.de,
        rdunlap@infradead.org
Cc:     Shyam-sundar.S-k@amd.com, Sandeep Singh <sandeep.singh@amd.com>
Subject: [PATCH v8 3/4] SFH:Transport Driver to add support of AMD Sensor Fusion Hub (SFH)
Date:   Sat, 10 Oct 2020 01:31:37 +0530
Message-Id: <20201009200138.1847317-4-Sandeep.Singh@amd.com>
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
Received: from jatayu.amd.com (165.204.156.251) by MAXPR0101CA0038.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend Transport; Fri, 9 Oct 2020 20:02:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 802c9bdb-08b1-4848-2f14-08d86c8e40eb
X-MS-TrafficTypeDiagnostic: CH2PR12MB4040:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB40400F84594B8FC106E28EF7E0080@CH2PR12MB4040.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GwNP/sH1fkuJvUbq0rYXJkpzON35GdNZfTAsgJKyskTYDms7ydsZQ7KQofbt93G1jr//WlYOsqvxTq0CLaWohFo9hsUfaR9XKrYUjdIaPt5aLu7clHmvNrhoaytJNuo+SsJdacZYeLiUTL3v3zpl/w/3az8LPlu0RZg9jZoZ1KW2PFWFXnjD68BDRHwjt5ft6sVMWNHC5672kIXCq6oknTVd2JE+SyG+YTujswLyR/ZfgGMcjl/8AlDRZ0aadB0gb6ZOSkebEBqwRPMhyug2tzjjqhPml424IsDpkBOmy4giI9T/00nSF7wq3g706l2I2fwiN76jUx7PZVyv+CwMuln1xJR2Il+GH1VANrTAXCgRZLwVUIx7pOOsnhj2lijG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(86362001)(83380400001)(316002)(4326008)(2906002)(36756003)(26005)(478600001)(8676002)(52116002)(7696005)(16526019)(186003)(6666004)(956004)(2616005)(7416002)(1076003)(8936002)(30864003)(5660300002)(66946007)(66476007)(66556008)(6486002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: P/FO96ENQHoWrHFlmBN1yD17kH7NyUSMc2zF9jvGycgKpmsChJRYkBQy6rQsFxpFhZ6YQCo5CH36IbePPdQaYQp309CeAT4aLUSFn7Lc2TRYPPMpDh28Y/hewbzz+tygahoZZeaDVXrdb34cpnFXVG3XoYE5a4MF5PdrDBym1ibmPR4QiugWZreRC7uc7PoEOq0lfr+Q0lbpQ4J/RotCaAoZ2dsF7acw8H5ny9NzDVvzsqz3QxAwkYC1utCXKxhbgkN+a96qfcdbMZRTvf5OrNtvv1hanogJYHRrnmCL83UsqaRZGXR6RcDWQDVUKVy34tpQz5Pi08JO4e9YdjFgsiLDSpzb0ghd9VBjhn+fQW3H4O6HGODbI9JflNUVULtdsdHnyw3B5M3mvR1lMId76TpdhHHFSZp12cpdAzCqFdl9e0qmE+f0cm2mqbrAzV2LsAHfbHACqu9q6/gvRHl1AsIkWUQ7hYpMiQyGI9RcqPVxplfSpUSgIOziwuYQOlv0cfYYLBXy1UkDkv8i82baJ5O5Fop5muJZNVrSUru16pbSZe/QzbnEkdne15+EKqDgadIZibxpJJwC/hb73nAQ0BG96LF+6A4IZl16Ltc9IOMG2mhd+2micP3f32+8DHm6v5tjRky2hQ2IR66VdpwYqQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 802c9bdb-08b1-4848-2f14-08d86c8e40eb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2020 20:02:30.7288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RSVohqsOHMfCAZp9x2rTnpLI8/snrSHcWUCknVksHfIPWRhtITUxQ49CMGhjt9NM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4040
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Sandeep Singh <sandeep.singh@amd.com>

To support AMD Sensor Fusion Hub (SFH) via the HID client's we need to
register the client with the HID framework. Here we mostly address on
how to register the client with the framework and define the interfaces
for communication.

Co-developed-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
Signed-off-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
---
 drivers/hid/amd-sfh-hid/amd_sfh_client.c | 246 +++++++++++++++++++++++
 drivers/hid/amd-sfh-hid/amd_sfh_hid.c    | 174 ++++++++++++++++
 drivers/hid/amd-sfh-hid/amd_sfh_hid.h    |  67 ++++++
 3 files changed, 487 insertions(+)
 create mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_client.c
 create mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_hid.c
 create mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_hid.h

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_client.c b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
new file mode 100644
index 000000000000..3d1ccac5d99a
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
@@ -0,0 +1,246 @@
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
+#include <linux/errno.h>
+
+#include "hid_descriptor/amd_sfh_hid_desc.h"
+#include "amd_sfh_pcie.h"
+#include "amd_sfh_hid.h"
+
+#define AMD_SFH_IDLE_LOOP	200
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
+
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
+	schedule_delayed_work(&cli_data->work_buffer, msecs_to_jiffies(AMD_SFH_IDLE_LOOP));
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
+		if (!cl_data->report_descr_sz[i]) {
+			rc = -EINVAL;
+			goto cleanup;
+		}
+		feature_report_size = get_descr_sz(cl_idx, feature_size);
+		if (!feature_report_size) {
+			rc = -EINVAL;
+			goto cleanup;
+		}
+		input_report_size =  get_descr_sz(cl_idx, input_size);
+		if (!input_report_size) {
+			rc = -EINVAL;
+			goto cleanup;
+		}
+		cl_data->feature_report[i] = kzalloc(feature_report_size, GFP_KERNEL);
+		if (!cl_data->feature_report[i]) {
+			rc = -ENOMEM;
+			goto cleanup;
+		}
+		cl_data->input_report[i] = kzalloc(input_report_size, GFP_KERNEL);
+		if (!cl_data->input_report[i]) {
+			rc = -ENOMEM;
+			goto cleanup;
+		}
+		info.period = msecs_to_jiffies(AMD_SFH_IDLE_LOOP);
+		info.sensor_idx = cl_idx;
+		info.phys_address = cl_data->sensor_phys_addr[i];
+
+		cl_data->report_descr[i] = kzalloc(cl_data->report_descr_sz[i], GFP_KERNEL);
+		if (!cl_data->report_descr[i]) {
+			rc = -ENOMEM;
+			goto cleanup;
+		}
+		rc = get_report_descriptor(cl_idx, cl_data->report_descr[i]);
+		if (rc)
+			return rc;
+		rc = amdtp_hid_probe(cl_data->cur_hid_dev, cl_data);
+		if (rc)
+			return rc;
+		amd_start_sensor(privdata, info);
+		cl_data->sensor_sts[i] = 1;
+	}
+	privdata->cl_data = cl_data;
+	schedule_delayed_work(&cl_data->work_buffer, msecs_to_jiffies(AMD_SFH_IDLE_LOOP));
+	return 0;
+
+cleanup:
+	for (i = 0; i < cl_data->num_hid_devices; i++) {
+		if (cl_data->sensor_virt_addr[i]) {
+			dma_free_coherent(&privdata->pdev->dev, 8 * sizeof(int),
+					  cl_data->sensor_virt_addr[i],
+					  cl_data->sensor_phys_addr[i]);
+		}
+		kfree(cl_data->feature_report[i]);
+		kfree(cl_data->input_report[i]);
+		kfree(cl_data->report_descr[i]);
+	}
+	kfree(cl_data);
+	return rc;
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
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_hid.c b/drivers/hid/amd-sfh-hid/amd_sfh_hid.c
new file mode 100644
index 000000000000..a471079a3bd0
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_hid.c
@@ -0,0 +1,174 @@
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
+
+#include "amd_sfh_hid.h"
+
+#define AMD_SFH_RESPONSE_TIMEOUT	1500
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
+			dev_err(&hid->dev, "AMDSFH  get report error\n");
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
+						       cli_data->request_done[i],
+						       msecs_to_jiffies(AMD_SFH_RESPONSE_TIMEOUT));
+	if (ret < 0)
+		return -ETIMEDOUT;
+	else if (ret == -ERESTARTSYS)
+		return -ERESTARTSYS;
+	else
+		return 0;
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
+int amdtp_hid_probe(u32 cur_hid_dev, struct amdtp_cl_data *cli_data)
+{
+	struct hid_device *hid;
+	struct amdtp_hid_data *hid_data;
+	int rc;
+
+	hid = hid_allocate_device();
+	if (IS_ERR(hid))
+		return PTR_ERR(hid);
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
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_hid.h b/drivers/hid/amd-sfh-hid/amd_sfh_hid.h
new file mode 100644
index 000000000000..6be0783d885c
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_hid.h
@@ -0,0 +1,67 @@
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
+#define BUS_AMD_AMDTP		0x20
+#define AMD_SFH_HID_VENDOR	0x1022
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
+ * Used to tie hid->driver data to driver client instance
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
-- 
2.25.1

