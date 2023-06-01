Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE1C719D48
	for <lists+linux-iio@lfdr.de>; Thu,  1 Jun 2023 15:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjFANVf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Jun 2023 09:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjFANVe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Jun 2023 09:21:34 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF77E7;
        Thu,  1 Jun 2023 06:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685625694; x=1717161694;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D/DR88O008rjn2oDCy8f/NbpgBynR6wiHSrqme+u5DA=;
  b=MNNZRSf8nsplv0S1df1K8gU8X7aztZ1H6QyPqSt9NOYPCauqoQ+vOu3l
   AuBx4elvPlPRt58PekUhs28svf3p96YGZgCQr94+McaVGNxVONp7j9kwV
   LtxeWsMZK33WHYoqrG5rYGq5Zk5newyTXzY2lOCtZb7gkvPkTggVNDg7H
   LKMX/fH7m3ik4U8bWmxYGiHIXacSYNDQBDqDks6xilLzNxexukpZK5S3p
   CLZbil5LVJgelJxsxER9stduavPzZqkgYxPi/2KHCm/0HvK7jn+CgCrKy
   6Vst/mFHqC65wEWrxrSUMSJCNENQKeoFvEDZ3j3vvMxlVumhCWd5Zxip3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="441916176"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="441916176"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:21:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="797150450"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="797150450"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:21:25 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com, jdelvare@suse.com,
        linux@roeck-us.net, jic23@kernel.org, lars@metafoo.de,
        bleung@chromium.org, yu.c.chen@intel.com, hdegoede@redhat.com,
        markgross@kernel.org, luzmaximilian@gmail.com,
        corentin.chary@gmail.com, jprvita@gmail.com,
        cascardo@holoscopio.com, don@syst.com.br, pali@kernel.org,
        jwoithe@just42.net, matan@svgalib.org, kenneth.t.chan@gmail.com,
        malattia@linux.it, jeremy@system76.com, productdev@system76.com,
        herton@canonical.com, coproscefalo@gmail.com, tytso@mit.edu,
        Jason@zx2c4.com, robert.moore@intel.com
Cc:     linux-acpi@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        chrome-platform@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v4 34/35] acpi/bus: Remove redundant functions
Date:   Thu,  1 Jun 2023 15:21:21 +0200
Message-Id: <20230601132122.301760-1-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

By this point all drivers switched from using .notify callback to
installing event handlers on their own. Remove redundant functions
acpi_device_install_notify_handler(),
acpi_device_remove_notify_handler() and acpi_notify_device().

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/bus.c | 60 ----------------------------------------------
 1 file changed, 60 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 6436ac4d6322..d700b65f5a37 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -522,14 +522,6 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
 	acpi_evaluate_ost(handle, type, ACPI_OST_SC_NON_SPECIFIC_FAILURE, NULL);
 }
 
-static void acpi_notify_device(acpi_handle handle, u32 event, void *data)
-{
-	struct acpi_device *device = data;
-	struct acpi_driver *acpi_drv = to_acpi_driver(device->dev.driver);
-
-	acpi_drv->ops.notify(device, event);
-}
-
 static void acpi_notify_device_fixed(void *data)
 {
 	struct acpi_device *device = data;
@@ -544,58 +536,6 @@ static u32 acpi_device_fixed_event(void *data)
 	return ACPI_INTERRUPT_HANDLED;
 }
 
-static int acpi_device_install_notify_handler(struct acpi_device *device,
-					      struct acpi_driver *acpi_drv)
-{
-	acpi_status status;
-
-	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
-		device->fixed_event_notify = acpi_notify_device;
-		status =
-		    acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
-						     acpi_device_fixed_event,
-						     device);
-	} else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
-		device->fixed_event_notify = acpi_notify_device;
-		status =
-		    acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
-						     acpi_device_fixed_event,
-						     device);
-	} else {
-		u32 type = acpi_drv->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS ?
-				ACPI_ALL_NOTIFY : ACPI_DEVICE_NOTIFY;
-
-		status = acpi_install_notify_handler(device->handle, type,
-						     acpi_notify_device,
-						     device);
-	}
-
-	if (ACPI_FAILURE(status))
-		return -EINVAL;
-	return 0;
-}
-
-static void acpi_device_remove_notify_handler(struct acpi_device *device,
-					      struct acpi_driver *acpi_drv)
-{
-	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
-		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
-						acpi_device_fixed_event);
-		device->fixed_event_notify = NULL;
-	} else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
-		acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
-						acpi_device_fixed_event);
-		device->fixed_event_notify = NULL;
-	} else {
-		u32 type = acpi_drv->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS ?
-				ACPI_ALL_NOTIFY : ACPI_DEVICE_NOTIFY;
-
-		acpi_remove_notify_handler(device->handle, type,
-					   acpi_notify_device);
-	}
-	acpi_os_wait_events_complete();
-}
-
 int acpi_device_install_event_handler(struct acpi_device *device,
 				      u32 type,
 				      void (*notify)(acpi_handle, u32, void*))
-- 
2.40.1

