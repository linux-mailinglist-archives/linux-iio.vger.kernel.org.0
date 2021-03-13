Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A05339EB3
	for <lists+linux-iio@lfdr.de>; Sat, 13 Mar 2021 15:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhCMOzt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Mar 2021 09:55:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:58848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229615AbhCMOzt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 13 Mar 2021 09:55:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7645A64F18;
        Sat, 13 Mar 2021 14:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615647348;
        bh=1NCttKQWppX7Ay24OePDfw5d+G1lbTAGNFFhYcMC4gY=;
        h=From:To:Cc:Subject:Date:From;
        b=K/+wZgkyHuhZOZbCHPpCnakU8gESq6YF5CnEpXix9DlScStixUGv8+tZ6aAIXSqjo
         +BdCe5/zbG8f/G++907hmTWW91IbH5SL7cCVB/UNs+RysGPU7gOYDYQCkStjt5FPZB
         h60e7jFOKGpXYC/t8qXURkrte3E9pY/iBvCBs8u8lR27HfrOilyh0FrYclv7bt8NW+
         GaIxp0+l8mzv+G1LCW1qV/wypO5Uv0AZUrUolppIDYfFpM38tYWHmf6Gfjqd1hIi0d
         U7J/ujDN+ZwEQWyi4UUBn4Z+HgMRMWTgiIBhROOuB4LoKCu/SslqjoCgrs/Id6Vu1e
         XQuJAbjSu1iqQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH] iio:cros_ec_sensors: Fix a wrong function name in kernel doc.
Date:   Sat, 13 Mar 2021 14:53:41 +0000
Message-Id: <20210313145341.116088-1-jic23@kernel.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

cros_ec_sensors_read_data_unsafe() had wrong function name in kernel-doc
This shows up with W=1 builds.

No fixes tag because I don't want to waste time on this being
backported.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index f8824afe595e..ed9dd0ad5c03 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -559,7 +559,7 @@ static int cros_ec_sensors_read_until_not_busy(
 }
 
 /**
- * read_ec_sensors_data_unsafe() - read acceleration data from EC shared memory
+ * cros_ec_sensors_read_data_unsafe() - read acc data from EC shared memory
  * @indio_dev:	pointer to IIO device
  * @scan_mask:	bitmap of the sensor indices to scan
  * @data:	location to store data
-- 
2.30.1

