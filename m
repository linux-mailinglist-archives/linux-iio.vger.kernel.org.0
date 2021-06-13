Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C80F3A5622
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jun 2021 05:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhFMD1k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Jun 2021 23:27:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:53882 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230281AbhFMD1k (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Jun 2021 23:27:40 -0400
IronPort-SDR: IWpK5c/D7V81XjanoirRbTwN1jH348F7pZiCgCJkG6gBtx9mmuTDS80P43Hxuc8/7FrRqihBSO
 72BQ+5Gcmfng==
X-IronPort-AV: E=McAfee;i="6200,9189,10013"; a="186066748"
X-IronPort-AV: E=Sophos;i="5.83,270,1616482800"; 
   d="scan'208";a="186066748"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2021 20:25:36 -0700
IronPort-SDR: HUGo9qOeNR94Lt0nN5DrKSLfpa9hk/uhsL97rD2lb/Lj7s2MKZIZokuPvKUYhnqSCSqB0v7mBo
 l5o/Zz4s4oew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,270,1616482800"; 
   d="scan'208";a="449521634"
Received: from host.sh.intel.com ([10.239.154.115])
  by orsmga008.jf.intel.com with ESMTP; 12 Jun 2021 20:25:34 -0700
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH] HID: intel-ish-hid: use async resume function
Date:   Sun, 13 Jun 2021 11:25:07 +0800
Message-Id: <20210613032507.7474-1-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

ISH IPC driver uses asynchronous workqueue to do resume now, but there is
a potential timing issue: when child devices resume before bus driver, it
will cause child devices resume failed and cannot be recovered until
reboot. The current implementation in this case do wait for IPC to resume
but fail to accommodate for a case when there is no ISH reboot and soft
resume is taking time. This issue is apparent on Tiger Lake platform with
5.11.13 kernel when doing suspend to idle then resume(s0ix) test. To
resolve this issue, we change ISHTP HID client to use asynchronous resume
callback too. In the asynchronous resume callback, it waits for the ISHTP
resume done event, and then notify ISHTP HID client link ready.

Signed-off-by: Ye Xiang <xiang.ye@intel.com>
---
 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 15 +++++++++-
 drivers/hid/intel-ish-hid/ishtp-hid.h        |  1 +
 drivers/hid/intel-ish-hid/ishtp/bus.c        | 29 +++++++++++++++-----
 include/linux/intel-ish-client-if.h          |  2 ++
 4 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index 7167412d89d9..9d53e85fdef3 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -779,6 +779,17 @@ static void hid_ishtp_cl_reset_handler(struct work_struct *work)
 	}
 }
 
+static void hid_ishtp_cl_resume_handler(struct work_struct *work)
+{
+	struct ishtp_cl_data *client_data = container_of(work, struct ishtp_cl_data, resume_work);
+	struct ishtp_cl *hid_ishtp_cl = client_data->hid_ishtp_cl;
+
+	if (ishtp_wait_resume(ishtp_get_ishtp_device(hid_ishtp_cl))) {
+		client_data->suspended = false;
+		wake_up_interruptible(&client_data->ishtp_resume_wait);
+	}
+}
+
 void (*hid_print_trace)(void *unused, const char *format, ...);
 
 /**
@@ -817,6 +828,8 @@ static int hid_ishtp_cl_probe(struct ishtp_cl_device *cl_device)
 	init_waitqueue_head(&client_data->ishtp_resume_wait);
 
 	INIT_WORK(&client_data->work, hid_ishtp_cl_reset_handler);
+	INIT_WORK(&client_data->resume_work, hid_ishtp_cl_resume_handler);
+
 
 	hid_print_trace = ishtp_trace_callback(cl_device);
 
@@ -918,7 +931,7 @@ static int hid_ishtp_cl_resume(struct device *device)
 
 	hid_ishtp_trace(client_data, "%s hid_ishtp_cl %p\n", __func__,
 			hid_ishtp_cl);
-	client_data->suspended = false;
+	schedule_work(&client_data->resume_work);
 	return 0;
 }
 
diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.h b/drivers/hid/intel-ish-hid/ishtp-hid.h
index 5ffd0da3cf1f..e5fa753fe92f 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid.h
+++ b/drivers/hid/intel-ish-hid/ishtp-hid.h
@@ -140,6 +140,7 @@ struct ishtp_cl_data {
 	int multi_packet_cnt;
 
 	struct work_struct work;
+	struct work_struct resume_work;
 	struct ishtp_cl_device *cl_device;
 };
 
diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c b/drivers/hid/intel-ish-hid/ishtp/bus.c
index 0d6465f0eaa8..ead6c8f32759 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.c
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
@@ -329,13 +329,6 @@ static int ishtp_cl_device_resume(struct device *dev)
 	if (!device)
 		return 0;
 
-	/*
-	 * When ISH needs hard reset, it is done asynchrnously, hence bus
-	 * resume will  be called before full ISH resume
-	 */
-	if (device->ishtp_dev->resume_flag)
-		return 0;
-
 	driver = to_ishtp_cl_driver(dev->driver);
 	if (driver && driver->driver.pm) {
 		if (driver->driver.pm->resume)
@@ -863,6 +856,28 @@ struct device *ishtp_device(struct ishtp_cl_device *device)
 }
 EXPORT_SYMBOL(ishtp_device);
 
+/**
+ * ishtp_wait_resume() - Wait for IPC resume
+ *
+ * Wait for IPC resume
+ *
+ * Return: resume complete or not
+ */
+bool ishtp_wait_resume(struct ishtp_device *dev)
+{
+	/* 50ms to get resume response */
+	#define WAIT_FOR_RESUME_ACK_MS		50
+
+	/* Waiting to get resume response */
+	if (dev->resume_flag)
+		wait_event_interruptible_timeout(dev->resume_wait,
+						 !dev->resume_flag,
+						 msecs_to_jiffies(WAIT_FOR_RESUME_ACK_MS));
+
+	return (!dev->resume_flag);
+}
+EXPORT_SYMBOL_GPL(ishtp_wait_resume);
+
 /**
  * ishtp_get_pci_device() - Return PCI device dev pointer
  * This interface is used to return PCI device pointer
diff --git a/include/linux/intel-ish-client-if.h b/include/linux/intel-ish-client-if.h
index 1153e0030133..ec3a6ccbece4 100644
--- a/include/linux/intel-ish-client-if.h
+++ b/include/linux/intel-ish-client-if.h
@@ -76,6 +76,8 @@ int ishtp_register_event_cb(struct ishtp_cl_device *device,
 
 /* Get the device * from ishtp device instance */
 struct device *ishtp_device(struct ishtp_cl_device *cl_device);
+/* wait for IPC resume */
+bool ishtp_wait_resume(struct ishtp_device *dev);
 /* Trace interface for clients */
 void *ishtp_trace_callback(struct ishtp_cl_device *cl_device);
 /* Get device pointer of PCI device for DMA acces */

base-commit: f5711311bfa1abcc64c6dd1e912666a8c0b29a1a
-- 
2.17.1

