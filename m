Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 204E71557DD
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2020 13:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgBGMiH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Feb 2020 07:38:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:33856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbgBGMiH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 7 Feb 2020 07:38:07 -0500
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 206C920715;
        Fri,  7 Feb 2020 12:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581079086;
        bh=/yjMAsHmQx+HQ2lCDOXqzVmWYiqBP5NLHVuC89dyBv8=;
        h=From:To:Cc:Subject:Date:From;
        b=MGyFGpgknm3Ctg2U3mBIi9tnyj/wf7YyhqFO/IzByAZ3Kk0PEkZ5R4896zcjRF1Cz
         17dGz/FaA7EZfQX3I6WhGe2WWUYqEeihFGn1hGQCBUFXUf7Qw5I0N4eeKuIW5kWnFB
         goy1G/A9BddASxzN4x57HewdBnnkblXtGcx5nDEU=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] iio: imu: st_lsm6dsx: check return value from st_lsm6dsx_sensor_set_enable
Date:   Fri,  7 Feb 2020 13:37:54 +0100
Message-Id: <f0f53dbfdb2c638f8ebb3deca4576886625fa6e8.1581078931.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add missing return value check in st_lsm6dsx_shub_read_oneshot disabling
the slave device connected to the st_lsm6dsx i2c controller.
The issue is reported by coverity with the following error:

Unchecked return value:
If the function returns an error value, the error value may be mistaken
for a normal value.

Addresses-Coverity-ID: 1456767 ("Unchecked return value")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index eea555617d4a..95ddd19d1aa7 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -464,9 +464,10 @@ st_lsm6dsx_shub_read_oneshot(struct st_lsm6dsx_sensor *sensor,
 
 	len = min_t(int, sizeof(data), ch->scan_type.realbits >> 3);
 	err = st_lsm6dsx_shub_read(sensor, ch->address, data, len);
+	if (err < 0)
+		return err;
 
-	st_lsm6dsx_shub_set_enable(sensor, false);
-
+	err = st_lsm6dsx_shub_set_enable(sensor, false);
 	if (err < 0)
 		return err;
 
-- 
2.21.1

