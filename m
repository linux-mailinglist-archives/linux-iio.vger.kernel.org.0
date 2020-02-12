Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDF8159F54
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2020 04:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgBLC5R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Feb 2020 21:57:17 -0500
Received: from mail-bn7nam10on2074.outbound.protection.outlook.com ([40.107.92.74]:14167
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727912AbgBLC5Q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 11 Feb 2020 21:57:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+s/H0KcfvRlLU2qllLOduIudYi3Lv87KrBQY+CwgVxAdjhHuKK6qhNPBwV+3o0SEBjheERjb30Ej9G4yUa3+YR65665Qb0HTIhOW4hFebhpPDs8UVPcVjeW98AWIeQcv1SiKn8gkWK9msietxo+1ukJ+89rBn0wo76rhkYPhkh9udmiSdpgUvBb9BskmnqP5IULqErCopF81oiW7B7zkOXUT+i29c031CdGVBnOZFdWihirm3AA8XeOEmKd1tvb4IVALz2wdW3TxE6TWEznEFdi4k4Le9KI2SYiaNJFuFc3ZNSkl6ZYIZBEcaeeJEMY+ti7uv41xMvsdD+bZT7E+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=657OatXVzDepnVSHhb+l2oesA2vZjGtpqmJF4p1fU48=;
 b=BTCDyEQLMXzJFeiDy4cDK/yhm8Uex7XzgDWzm0EupLwqeIR9rMKBUY0yc2KxIaasC834iDNLjvPOw2xWH30NQy13HUkjUSb39M2iunc0eIO2rCGApixzt797r6Vm+KKpdNXOm8gi5D7veTxU7jL8KyYRmzlZi1aesQuLJTr49Y8sydzEP0UTWuJmmwx/726CsJkWQ+B2IoCuJYBPyYnFSDcfaL21cr3ao7B7cTR10M9sz9NVJjO8qmlN93n11C7xkau4X5xZ86xvXqgq288xKvLTedD2sg+w8h4ttZh92fc/7FYR3fjMYIrmJOcCGE69s1Y8uvyp9jjZJ5NhA+shkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=657OatXVzDepnVSHhb+l2oesA2vZjGtpqmJF4p1fU48=;
 b=VSKifuFODjqO+FkL2nnfgLHDBEzQRRacN6TF85zdYsfJkiZj50hBMXsY9eUrdhHW/+KNL0Gigp5/G4ftbMb0U0xc6RTLtvhc9z1JsGAWvUq79PKLX3Q0X8aEFdR/HIWOXwnTIr6hpps/APSUBSZ7fPUlc4viZS0BTpXVARkrlzE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sandeep.Singh@amd.com; 
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (20.178.244.84) by
 MN2PR12MB3343.namprd12.prod.outlook.com (20.178.240.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.28; Wed, 12 Feb 2020 02:57:09 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::10ce:b4fb:586d:8b9c]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::10ce:b4fb:586d:8b9c%3]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 02:57:09 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, Nehal-bakulchandra.Shah@amd.com
Cc:     Shyam-sundar.S-k@amd.com, Sandeep Singh <sandeep.singh@amd.com>
Subject: [PATCH v3 4/5] SFH: Add debugfs support to AMD Sensor Fusion Hub
Date:   Wed, 12 Feb 2020 08:26:36 +0530
Message-Id: <1581476197-25854-5-git-send-email-Sandeep.Singh@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581476197-25854-1-git-send-email-Sandeep.Singh@amd.com>
References: <1581476197-25854-1-git-send-email-Sandeep.Singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::26) To MN2PR12MB3598.namprd12.prod.outlook.com
 (2603:10b6:208:d1::20)
MIME-Version: 1.0
Received: from andbang2.amd.com (165.204.156.251) by MA1PR0101CA0016.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2707.21 via Frontend Transport; Wed, 12 Feb 2020 02:57:06 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aab9bfef-6838-46ce-8628-08d7af67404c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3343:|MN2PR12MB3343:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3343AA1AB8DFDB45836D4964E01B0@MN2PR12MB3343.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-Forefront-PRVS: 0311124FA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(6636002)(81166006)(6666004)(2906002)(81156014)(8676002)(6486002)(8936002)(86362001)(956004)(36756003)(66946007)(66556008)(4326008)(5660300002)(7696005)(66476007)(2616005)(52116002)(16526019)(316002)(26005)(478600001)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3343;H:MN2PR12MB3598.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cr3GTU1haMZS+9zxNGI9QMqGuZ0Xdswi1TmlsJ0GNSW925B9PNCI4la4d0LEuHGImxsqvudbNtj92OUmehr+SxovvB3xndMz14cvT+BlCh34Tkcv+ZAUz+yMt/bMP0ZKGwxjNv77U4ZBAMvPAYBJt+UZsEFtZSxN9IrkZUy5f27tt66gL5EA3X3LZMwR8tejoqZkmlpapQdYfKQpjCuesPjclYEuUeYB+W9YwfHPCki8xHqTpz3MClu43d6AEA2FHyqf78faC22CQ3frTMzoey6qGocvMZYTGTxO/vmQOYZp4OVQzndcS8oPAKwphdjBv2G4sHVsUIT8LQlHNa8U7SS5NGw38JGB3hU0cnOK2iD+nLU0KzTT7GE8rHb8iaru8VCWDva8rF2uiQuopulg2fUKb0w9yNSab8PLtVaeoT4HXUWcL8QkFFrmOerqbRBM
X-MS-Exchange-AntiSpam-MessageData: F48FgEvHmCy7ivvwJJBsUE/SGKA3mA2qajS3XsPiodQfTTth0D4WrDHOQd0ipWQl4JiYOhcqoME0mOnw9SY1O2EdTLmved7S0Ho2U/DfYf8s5H37sZkcD0ErYcVD+auUruq5iPECijUerDuPcW/Kdw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab9bfef-6838-46ce-8628-08d7af67404c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 02:57:09.5311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95ZRUbL/f0B7yCzijFkdEfFn4G8McZr/axzHB1cTbv8RhnACD6B9CowSKs16sDOp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3343
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Sandeep Singh <sandeep.singh@amd.com>

This part would give access to internals of
AMD Sensor Fusion Hub  through debugfs. it provide raw values in debugfs

Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
Signed-off-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
---
 drivers/hid/amd-sfh-hid/amdsfh-debugfs.c | 250 +++++++++++++++++++++++++++++++
 drivers/hid/amd-sfh-hid/amdsfh-debugfs.h |  14 ++
 2 files changed, 264 insertions(+)
 create mode 100644 drivers/hid/amd-sfh-hid/amdsfh-debugfs.c
 create mode 100644 drivers/hid/amd-sfh-hid/amdsfh-debugfs.h

diff --git a/drivers/hid/amd-sfh-hid/amdsfh-debugfs.c b/drivers/hid/amd-sfh-hid/amdsfh-debugfs.c
new file mode 100644
index 0000000..15aeef8
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/amdsfh-debugfs.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  AMD SFH Debugfs
+ *  This part would access MP2 registers through debugfs
+ *  for AMD SFH debugging.
+ *  Author: Nehal Bakulchandra Shah <Nehal-Bakulchandra.Shah@amd.com>
+ */
+
+#include <linux/slab.h>
+#include "amd_mp2_pcie.h"
+#include "amdsfh-debugfs.h"
+
+/* DebugFS helpers */
+#define	OBUFP		(obuf + oboff)
+#define	OBUFLEN		512
+#define	OBUFSPC		(OBUFLEN - oboff)
+#define	OSCNPRINTF(fmt, ...) \
+		scnprintf(OBUFP, OBUFSPC, fmt, ## __VA_ARGS__)
+
+static ssize_t amdsfh_debugfs_accel_read(struct file *filp, char __user *ubuf,
+					 size_t count, loff_t *offp)
+{
+	unsigned int oboff = 0, i;
+	struct amdtp_cl_data *cl_data = filp->private_data;
+	bool found = false;
+	ssize_t ret;
+	char *obuf;
+
+	for (i = 0; i < cl_data->num_hid_devices; i++) {
+		if (cl_data->sensor_idx[i] == ACCEL_IDX) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		return -1;
+
+	obuf = kmalloc(OBUFLEN, GFP_KERNEL);
+	if (!obuf)
+		return -ENOMEM;
+
+	oboff += OSCNPRINTF("Accel_X_Raw:%d\n",
+		(int)cl_data->sensor_virt_addr[i][0]);
+	oboff += OSCNPRINTF("Accel_Y_Raw:%d\n",
+		(int)cl_data->sensor_virt_addr[i][1]);
+	oboff += OSCNPRINTF("Accel_Z_Raw:%d\n",
+		(int)cl_data->sensor_virt_addr[i][2]);
+	ret = simple_read_from_buffer(ubuf, count, offp, obuf, oboff);
+
+	kfree(obuf);
+
+	return ret;
+}
+
+static ssize_t amdsfh_debugfs_gyro_read(struct file *filp, char __user *ubuf,
+					size_t count, loff_t *offp)
+{
+	unsigned int oboff = 0, i;
+	bool found = false;
+	struct amdtp_cl_data *cl_data = filp->private_data;
+	ssize_t ret;
+	char *obuf;
+
+	for (i = 0; i < cl_data->num_hid_devices; i++) {
+		if (cl_data->sensor_idx[i] == GYRO_IDX) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		return -1;
+
+	obuf = kmalloc(OBUFLEN, GFP_KERNEL);
+	if (!obuf)
+		return -ENOMEM;
+
+	oboff += OSCNPRINTF("Gyro_X_Raw:%d\n",
+		(int)cl_data->sensor_virt_addr[i][0]);
+	oboff += OSCNPRINTF("Gyro_Y_Raw:%d\n",
+		(int)cl_data->sensor_virt_addr[i][1]);
+	oboff += OSCNPRINTF("Gyro_Z_Raw:%d\n",
+		(int)cl_data->sensor_virt_addr[i][2]);
+	ret = simple_read_from_buffer(ubuf, count, offp, obuf, oboff);
+
+	kfree(obuf);
+
+	return ret;
+}
+
+static ssize_t amdsfh_debugfs_mag_read(struct file *filp, char __user *ubuf,
+				       size_t count, loff_t *offp)
+{
+	unsigned int oboff = 0, i;
+	bool found = false;
+	ssize_t ret;
+	char *obuf;
+	struct amdtp_cl_data *cl_data = filp->private_data;
+
+	for (i = 0; i < cl_data->num_hid_devices; i++) {
+		if (cl_data->sensor_idx[i] == MAG_IDX) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		return -1;
+
+	obuf = kmalloc(OBUFLEN, GFP_KERNEL);
+	if (!obuf)
+		return -ENOMEM;
+
+	oboff += OSCNPRINTF("Mag_X_Raw:%d\n",
+		(int)cl_data->sensor_virt_addr[i][0]);
+	oboff += OSCNPRINTF("Mag_Y_Raw:%d\n",
+		(int)cl_data->sensor_virt_addr[i][1]);
+	oboff += OSCNPRINTF("Mag_Z_Raw:%d\n",
+		(int)cl_data->sensor_virt_addr[i][2]);
+	ret = simple_read_from_buffer(ubuf, count, offp, obuf, oboff);
+
+	kfree(obuf);
+
+	return ret;
+}
+
+static ssize_t amdsfh_debugfs_als_read(struct file *filp, char __user *ubuf,
+				       size_t count, loff_t *offp)
+{
+	unsigned int oboff = 0, i;
+	bool found = false;
+	ssize_t ret;
+	char *obuf;
+	struct amdtp_cl_data *cl_data = filp->private_data;
+
+	for (i = 0; i < cl_data->num_hid_devices; i++) {
+		if (cl_data->sensor_idx[i] == AMBIENT_LIGHT_IDX) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		return -1;
+
+	obuf = kmalloc(OBUFLEN, GFP_KERNEL);
+	if (!obuf)
+		return -ENOMEM;
+
+	oboff += OSCNPRINTF("Gyro_X_Raw:%d\n",
+		(int)cl_data->sensor_virt_addr[i][0]);
+	oboff += OSCNPRINTF("Gyro_Y_Raw:%d\n",
+		(int)cl_data->sensor_virt_addr[i][1]);
+	oboff += OSCNPRINTF("Gyro_Z_Raw:%d\n",
+		(int)cl_data->sensor_virt_addr[i][2]);
+	ret = simple_read_from_buffer(ubuf, count, offp, obuf, oboff);
+
+	kfree(obuf);
+
+	return ret;
+}
+
+static const struct file_operations amdsfh_debugfs_accel_ops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = amdsfh_debugfs_accel_read,
+};
+
+static const struct file_operations amdsfh_debugfs_gyro_ops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = amdsfh_debugfs_gyro_read,
+};
+
+static const struct file_operations amdsfh_debugfs_mag_ops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = amdsfh_debugfs_mag_read,
+};
+
+static const struct file_operations amdsfh_debugfs_als_ops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = amdsfh_debugfs_als_read,
+};
+
+int amdsfh_debugfs_setup(struct amdtp_cl_data *cl_data)
+{
+	/* DebugFS info */
+	struct dentry *dbgfs;
+	int i;
+
+	if (!debugfs_initialized())
+		return -1;
+
+	if (!cl_data->amd_debugfs_dir)
+		cl_data->amd_debugfs_dir = debugfs_create_dir
+					(KBUILD_MODNAME, NULL);
+
+	if (!cl_data->amd_debugfs_dir)
+		return -1;
+
+	for (i = 0; i < cl_data->num_hid_devices; i++) {
+		switch (cl_data->sensor_idx[i]) {
+		case ACCEL_IDX:
+			dbgfs = debugfs_create_dir("accel",
+						   cl_data->amd_debugfs_dir);
+			debugfs_create_file("raw_value", 0400,
+					    dbgfs, cl_data,
+					    &amdsfh_debugfs_accel_ops);
+			break;
+
+		case GYRO_IDX:
+			dbgfs = debugfs_create_dir("gyro",
+						   cl_data->amd_debugfs_dir);
+			debugfs_create_file("raw_value", 0400,
+					    dbgfs, cl_data,
+					    &amdsfh_debugfs_gyro_ops);
+			break;
+
+		case MAG_IDX:
+			dbgfs = debugfs_create_dir("magnetometer",
+						   cl_data->amd_debugfs_dir);
+			debugfs_create_file("raw_value", 0400,
+					    dbgfs, cl_data,
+					    &amdsfh_debugfs_mag_ops);
+			break;
+
+		case AMBIENT_LIGHT_IDX:
+			dbgfs =  debugfs_create_dir("als",
+						    cl_data->amd_debugfs_dir);
+			debugfs_create_file("raw_value", 0400,
+					    dbgfs, cl_data,
+					    &amdsfh_debugfs_als_ops);
+			break;
+
+		default:
+			return 0;
+		}
+	}
+	return 0;
+}
+EXPORT_SYMBOL(amdsfh_debugfs_setup);
+
+void amdsfh_debugfs_destroy(struct amdtp_cl_data *cl_data)
+{
+	debugfs_remove_recursive(cl_data->amd_debugfs_dir);
+}
+EXPORT_SYMBOL(amdsfh_debugfs_destroy);
diff --git a/drivers/hid/amd-sfh-hid/amdsfh-debugfs.h b/drivers/hid/amd-sfh-hid/amdsfh-debugfs.h
new file mode 100644
index 0000000..470f1f12
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/amdsfh-debugfs.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ *  AMD SFH DebugFS
+ *  Author: Nehal Bakulchandra Shah <Nehal-Bakulchandra.Shah@amd.com>
+ */
+#include "amdsfh-hid.h"
+
+#ifndef AMDSFH_DEBUGFS_H
+#define AMDSFH_DEBUGFS_H
+
+int amdsfh_debugfs_setup(struct amdtp_cl_data *cl_data);
+void amdsfh_debugfs_destroy(struct amdtp_cl_data *cl_data);
+
+#endif
-- 
2.7.4

