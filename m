Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AEE719D44
	for <lists+linux-iio@lfdr.de>; Thu,  1 Jun 2023 15:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjFANVS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Jun 2023 09:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjFANVQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Jun 2023 09:21:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA4497;
        Thu,  1 Jun 2023 06:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685625676; x=1717161676;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WwIcbTmw5qfuyP7ZCrrzP68VAul4AG0APywRqVEBBYg=;
  b=Ailu3SZbl3p6iqkH0ht8PcNHg+TglhGd2ty+f1L+L6qvkNBgvmjzpgKa
   +jzSW/AvNZBNOsCij8pdwlRXEUScT3n553/SLZwCVBq+O/OJzRkcXrzco
   Y7dY52syeYdvVFTuE2hzJCYQUOsUtd2HxycQe8sTgM1bNFdvyHARGaumO
   gZDorGAc1gaHMI55mvxky8yQKgzNbTK4EE/dIueFrZr5k1hAoupusDHkg
   KjtEo2YqXsAzJbFSIW1bqciXPQqmvahp0sz/fvop1pQHFG+JZLNNjMgvj
   si1DV+R6evNd1yOef1ZP9suUzkh44lwqfXPODBO2oqVju/hVsV0jFooBT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="383826277"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="383826277"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:21:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="701539286"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="701539286"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:21:06 -0700
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
Subject: [PATCH v4 33/35] acpi/bus: Remove installing/removing notify handlers from probe/remove
Date:   Thu,  1 Jun 2023 15:21:02 +0200
Message-Id: <20230601132102.301718-1-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Remove installing/removing .notify callback handlers, to prepare for
notify callback removal.

Remove logic calling .remove callback, as .add should be expected to
clean after itself in case of the failure, and event handler
installation was moved to .add in all drivers already.

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/bus.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index cf2c2bfe29a0..6436ac4d6322 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1089,20 +1089,6 @@ static int acpi_device_probe(struct device *dev)
 	pr_debug("Driver [%s] successfully bound to device [%s]\n",
 		 acpi_drv->name, acpi_dev->pnp.bus_id);
 
-	if (acpi_drv->ops.notify) {
-		ret = acpi_device_install_notify_handler(acpi_dev, acpi_drv);
-		if (ret) {
-			if (acpi_drv->ops.remove)
-				acpi_drv->ops.remove(acpi_dev);
-
-			acpi_dev->driver_data = NULL;
-			return ret;
-		}
-	}
-
-	pr_debug("Found driver [%s] for device [%s]\n", acpi_drv->name,
-		 acpi_dev->pnp.bus_id);
-
 	get_device(dev);
 	return 0;
 }
@@ -1112,9 +1098,6 @@ static void acpi_device_remove(struct device *dev)
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 	struct acpi_driver *acpi_drv = to_acpi_driver(dev->driver);
 
-	if (acpi_drv->ops.notify)
-		acpi_device_remove_notify_handler(acpi_dev, acpi_drv);
-
 	if (acpi_drv->ops.remove)
 		acpi_drv->ops.remove(acpi_dev);
 
-- 
2.40.1

