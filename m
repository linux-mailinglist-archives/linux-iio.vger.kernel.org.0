Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568FF24126A
	for <lists+linux-iio@lfdr.de>; Mon, 10 Aug 2020 23:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgHJVbv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Aug 2020 17:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgHJVbu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Aug 2020 17:31:50 -0400
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (mail-co1nam04on0615.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe4d::615])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766FCC061756;
        Mon, 10 Aug 2020 14:31:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFfmIM+iHUSBUB9HhOxvd1qV1r+OZY8b3zMahW56j3wIXJT37TYMXYMJiP/WgpmW5FRvYitbIb1XCaxfqoi+BDPv+NCraZTNWhcTYUWVTTOREIgPoZlovr05Pnse1oHLoGCtkk7PXGaMA2lv9uk/QuMNWWH7YCi2+oEclGnRHX7evQXmN6SzatIDAsJlenGK/dW4f6++ZHT6EKZN3ec7dc6VP8UloUTGeo82hErcjf3ACF2+BHgVcRQOGVQkekzU87c8dN5CAjmSy3SazbkbeDzd/5F6Z24kybjKKOkLlUzJ614qx8vC+fTzl/c/5gmA0DmLmytJ/v9vgY084drpwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dg1WkJZUHxoqLn8+AP90dW6v6FLtC06fMfXlnHGQOMo=;
 b=hFPqSNIptTCH4/qvTBNwrGir0+cewLPQisQDO3xriXUtva7F04XiHJMY0fSoWZzpOKBwTKvBvKNqWtcsNIBRqW8nxIib64HA23ZdurNxrRXUJt6NyY8rN8hWpFR1Xl5yHeIbn5Ib4/Ra5FZMD1d/FBOc+M6UsexTG2q7kiXp3c4NQ+yJryVcJlFF94Pc8eaLFEbmHogUblhPyr8B3Z0CY7RJ+eE1HMKi3bjRyScGXm+a2iFa/IfLCOtgm5otGukGKpioMQsSQh9FUSCuXc2/bxs85OlhhgLyd60/JpAwGhKk7NHbkexfTs08Nq+rfwdkvHKuTMOLBQaQe6yO5qAz0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dg1WkJZUHxoqLn8+AP90dW6v6FLtC06fMfXlnHGQOMo=;
 b=LJmsUykFTey2Xj84asZOFuwpuFkvFuxJsBHAy9GCX2BQESVDiA9yZHfPTsVlOr8Z9nXqiCK2mEr2IcizmLwYt7MixMPlme5RfpHuQOeMsya014RFDs+oyaU1qDIqy21U4Y8MtLfgHgZ/05R66kO+bH0L4N+Mi6u71N6lVH94lBY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2726.namprd12.prod.outlook.com (2603:10b6:a03:66::17)
 by BY5PR12MB3715.namprd12.prod.outlook.com (2603:10b6:a03:1a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18; Mon, 10 Aug
 2020 21:31:48 +0000
Received: from BYAPR12MB2726.namprd12.prod.outlook.com
 ([fe80::8503:3713:6ed0:af09]) by BYAPR12MB2726.namprd12.prod.outlook.com
 ([fe80::8503:3713:6ed0:af09%6]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 21:31:48 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com, andy.shevchenko@gmail.com,
        mail@richard-neumann.de, m.felsch@pengutronix.de,
        rdunlap@infradead.org
Cc:     Shyam-sundar.S-k@amd.com, Sandeep Singh <sandeep.singh@amd.com>
Subject: [PATCH v7 3/4] SFH: Transport Driver to add support of AMD Sensor Fusion Hub (SFH)
Date:   Mon, 10 Aug 2020 21:30:54 +0000
Message-Id: <20200810213055.103962-4-Sandeep.Singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810213055.103962-1-Sandeep.Singh@amd.com>
References: <20200810213055.103962-1-Sandeep.Singh@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::11) To BYAPR12MB2726.namprd12.prod.outlook.com
 (2603:10b6:a03:66::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jatayu.amd.com (165.204.156.251) by MA1PR0101CA0025.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend Transport; Mon, 10 Aug 2020 21:31:44 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 30a29b8e-04bd-4cbe-2bc9-08d83d74c977
X-MS-TrafficTypeDiagnostic: BY5PR12MB3715:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB371558579C7EE9DE992C7CBFE0440@BY5PR12MB3715.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:117;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +o4GRYFTcLu5ivP2sKhLGPOHzqkaQIt3GFpG8F1StE/JF3pWRfFfPskCtZi/8hNoCxKBOvam5c2LK5jbCac2U1MFp4Z3EiJXqeBVsLcyvK4Cd5qUta1NjGHbh9f8nPhA0rhi39aYcjwMPx7Tu6L07Xk54lzyAcVe1gRq1nLHllMrGfJqI9PeV4em5tItRCF+uNBHmVPnmLaX18ewyZW4lLI0RG293PjN6WPA0z/0TcHAQ18rR63Ce93TLXEMfymQZl/UqCqanK6Z2LCaaaRVRes38jbReHvZb6b1PQVE9cKnE3UiQ5wvr08xcX75Ki2icEpuc97lPqLAN1Q2DkmwPe81Ct1L81jWjUWHo7Jv5vMaui3FanUFqow9tkztWrJc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(2906002)(6486002)(26005)(30864003)(186003)(7696005)(52116002)(16526019)(5660300002)(66556008)(66476007)(4326008)(6666004)(66946007)(1076003)(478600001)(8936002)(36756003)(83380400001)(2616005)(956004)(86362001)(8676002)(316002)(7416002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: AImzlPXB2dLWwm9OX8/GEfytTqqwsqrJqWJCFMtlVtY27WcDd2BmvoIuEnGIUNMk8wnn8V4yGsEqTEUMzWpLjxGQnbVDFeuuKviw4LFvu7yzhlqrfHkWxrQ6txCVgD8cwXD+WmiRBzxXWM2rMqoVD1o+6obhkkWq3vCrVuiv37hQnZ54BYuipC+7RvaubGvkaUUcs+BRkVf27yUDMr3di4Wb15OC/94aDk5R7luSIlV52VbT3VIyThc6731mF79SOggzWxc/La5piODoBFwNYM8z9s6LFWX6qLlJ2/uuX1cBB3SY1TdELN/wD3yQpn3tahK1EzSesEghidxkjVUBY7BCLcfpT7DK8J/ScnKPRDUJZTGbw3fO5rtp571wk+iJ8Wad+pxWJE9bVq5IUaYdgZTPDuC817roZMhQm4KzygEXvCQaE6mRpyaPvpXwbZDBYWu1B0TKEoT1f8+7jCg8S1O2COul5YYpHUoniS3MyMKaGOVglUV4VbBH70VrCguMeMdQ/3TLIFjZec2Q2IGhnV82DBQHFLV0MaS1zTNhTWCvxAecjPdDCJXitcI0BeCPn4rHs1tpb/G8U075zZtj4El4yRNg4ccHnLEVZMkaHZ3NDzZNDZdi0EeAFYIv7BB2dme5qb2Cqr3TkMxq8X/HmA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a29b8e-04bd-4cbe-2bc9-08d83d74c977
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2020 21:31:48.1274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GK9EsP7mmPBFV7rXm2tjFgXFVJNML5QMYFJ9F1OvmMm0Ha5XsW+91PhkzlQHk/Vv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3715
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Sandeep Singh <sandeep.singh@amd.com>

This part of module will provide the interaction between HID framework
and client layer.This module will registered client layer with
HID framework.

Signed-off-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
---
 drivers/hid/amd-sfh-hid/amdsfh_hid.c        | 175 ++++++++++++++
 drivers/hid/amd-sfh-hid/amdsfh_hid.h        |  68 ++++++
 drivers/hid/amd-sfh-hid/amdsfh_hid_client.c | 244 ++++++++++++++++++++
 3 files changed, 487 insertions(+)
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
index 000000000000..17d59b787c3c
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/amdsfh_hid_client.c
@@ -0,0 +1,244 @@
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
+		info.period = PERIOD;
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
+	schedule_delayed_work(&cl_data->work_buffer, PERIOD);
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
-- 
2.25.1

