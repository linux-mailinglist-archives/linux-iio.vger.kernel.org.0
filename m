Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5BB719E83
	for <lists+linux-iio@lfdr.de>; Thu,  1 Jun 2023 15:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjFANnz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Jun 2023 09:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbjFANny (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Jun 2023 09:43:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A3213E;
        Thu,  1 Jun 2023 06:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685627032; x=1717163032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eKaXqW+DRkqJGpmPjw5NP4F6Cx+mNw9LMr+YNIGyaoY=;
  b=mTTWcES/YP+EWHyKV+6oHmHn5Giy704tLYZRI1laQs7FFhi4uW1LZman
   FIeKt4xl/9eOUt+Q4x55vJOpRgZ3sQtsnybvJfNPqhx3lxq+/QOAdElg4
   GjgNcwW9gCjB4LBFU/ChZs28xICNPQ0HkdWOhxREYML7dRZl+W5OwBemD
   dA+mp0WoT+M46hY2HVpejAz/8ArbYyJn//ZsenCHEtyKWr4MwkmsXuYOm
   c36VKnYyQMhmQ+BrY/e3E9KciVcMg/Y9oos8mYqENcm3MhSZfLBxaqaQR
   78BmgoAxz64TY7/zZnoB40IQYNzVJU3/fLwztbD6ZjbM+2ui6bLyBIk10
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="419067333"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="419067333"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:19:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="881601655"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="881601655"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:19:01 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Michal Wilczynski <michal.wilczynski@intel.com>,
        linux-iio@vger.kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, rafael@kernel.org
Subject: [PATCH v4 11/35] iio/acpi-als: Move handler installing logic to driver
Date:   Thu,  1 Jun 2023 15:17:14 +0200
Message-Id: <20230601131739.300760-12-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230601131739.300760-3-michal.wilczynski@intel.com>
References: <20230601131739.300760-3-michal.wilczynski@intel.com>
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

Currently logic for installing notifications from ACPI devices is
implemented using notify callback in struct acpi_driver. Preparations
are being made to replace acpi_driver with more generic struct
platform_driver, which doesn't contain notify callback. Furthermore
as of now handlers are being called indirectly through
acpi_notify_device(), which decreases performance.

Call acpi_device_install_event_handler() at the end of .add() callback.
Call acpi_device_remove_event_handler() at the beginning of .remove()
callback. Change arguments passed to the notify callback to match with
what's required by acpi_device_install_event_handler().

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/iio/light/acpi-als.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index 2d91caf24dd0..5e200c6d91bc 100644
--- a/drivers/iio/light/acpi-als.c
+++ b/drivers/iio/light/acpi-als.c
@@ -100,10 +100,14 @@ static int acpi_als_read_value(struct acpi_als *als, char *prop, s32 *val)
 	return 0;
 }
 
-static void acpi_als_notify(struct acpi_device *device, u32 event)
+static void acpi_als_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct iio_dev *indio_dev = acpi_driver_data(device);
-	struct acpi_als *als = iio_priv(indio_dev);
+	struct acpi_device *device = data;
+	struct iio_dev *indio_dev;
+	struct acpi_als *als;
+
+	indio_dev = acpi_driver_data(device);
+	als = iio_priv(indio_dev);
 
 	if (iio_buffer_enabled(indio_dev) && iio_trigger_using_own(indio_dev)) {
 		switch (event) {
@@ -225,7 +229,16 @@ static int acpi_als_add(struct acpi_device *device)
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(dev, indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ret;
+
+	return acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_als_notify);
+}
+
+static void acpi_als_remove(struct acpi_device *device)
+{
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_als_notify);
 }
 
 static const struct acpi_device_id acpi_als_device_ids[] = {
@@ -241,7 +254,7 @@ static struct acpi_driver acpi_als_driver = {
 	.ids	= acpi_als_device_ids,
 	.ops = {
 		.add	= acpi_als_add,
-		.notify	= acpi_als_notify,
+		.remove = acpi_als_remove,
 	},
 };
 
-- 
2.40.1

