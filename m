Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FBE1E637E
	for <lists+linux-iio@lfdr.de>; Thu, 28 May 2020 16:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390987AbgE1OP4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 May 2020 10:15:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:58898 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390900AbgE1OPz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 May 2020 10:15:55 -0400
IronPort-SDR: HXK+LhSV9SSrr5t7YGepnwPvGOTBrtl+0EjuLic17KRd6TxFNrZu46vkH+0L/3SSUGFeIad1GS
 XWoAUNwR9ZLQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 07:15:55 -0700
IronPort-SDR: UfhZGBlq8mrOE9TmHKEwQR4hkC4xTJJHaeoJS1h9b16J23erIZMc0+2S8vrX1vlf/RCwebvWsv
 cf85N+umICmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,444,1583222400"; 
   d="scan'208";a="310937745"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 28 May 2020 07:15:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D06F0230; Thu, 28 May 2020 17:15:52 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] iio: imu: inv_mpu6050: Drop double check for ACPI companion device
Date:   Thu, 28 May 2020 17:15:52 +0300
Message-Id: <20200528141552.57504-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

acpi_dev_get_resources() does perform the NULL pointer check against
ACPI companion device which is given as function parameter. Thus,
there is no need to duplicate this check in the caller.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
index 2f8560ba4572..bf9bdaf6519a 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
@@ -101,8 +101,8 @@ static int inv_mpu_process_acpi_config(struct i2c_client *client,
 				       unsigned short *primary_addr,
 				       unsigned short *secondary_addr)
 {
+	struct acpi_device *adev = ACPI_COMPANION(&client->dev);
 	const struct acpi_device_id *id;
-	struct acpi_device *adev;
 	u32 i2c_addr = 0;
 	LIST_HEAD(resources);
 	int ret;
@@ -112,10 +112,6 @@ static int inv_mpu_process_acpi_config(struct i2c_client *client,
 	if (!id)
 		return -ENODEV;
 
-	adev = ACPI_COMPANION(&client->dev);
-	if (!adev)
-		return -ENODEV;
-
 	ret = acpi_dev_get_resources(adev, &resources,
 				     acpi_i2c_check_resource, &i2c_addr);
 	if (ret < 0)
-- 
2.26.2

