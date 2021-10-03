Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB4742016F
	for <lists+linux-iio@lfdr.de>; Sun,  3 Oct 2021 14:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhJCMPe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Oct 2021 08:15:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230156AbhJCMPd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Oct 2021 08:15:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C273161872;
        Sun,  3 Oct 2021 12:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633263226;
        bh=SPigNN45QNJBGGtvHfOZ4TqkKhzFeLkzF6rKEk6xEQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TQlbW414oMvdolpOw+53e3OnQlm9cojmRj+YWxzu2dgChJuTOGbKW9ZNN0bJeO0Gx
         kjlVFxCx046jFJNZZJ4lRCUfOh+CzH5ohMwF4K13TDx6Hx5VoYn9gdS5GORhVZ48Yp
         U8O3cmui9bfIirTelFfYIZcRA6wSH5ohFr0jsrKSwVjEuOhL6EdcY80Rha8dkGPSqz
         32f3crdUAcsaz/loy3VNAXgylJoTIgUbVN1L/dl6J1ACJfRPZfawmM0kIPpWuuc1vp
         0jxDL2cPBJlnMU7Z3/gjGiHBpr4h3W48K+4jayOpAb3Bi4gfvH5JzEScI053TUIqLM
         TszLxCPMCZnPA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/7] iio: cros_ec_sensors: Remove excessive IIO includes
Date:   Sun,  3 Oct 2021 13:17:06 +0100
Message-Id: <20211003121711.279736-3-jic23@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211003121711.279736-1-jic23@kernel.org>
References: <20211003121711.279736-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Identified via the include-what-you-use tool.
To keep the scope simple, this only includes removal of IIO related headers
that are completely unused in these files.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c      | 4 ----
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 1 -
 2 files changed, 5 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index 376a5b30010a..9a02c2cd8762 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -9,12 +9,8 @@
  */
 
 #include <linux/device.h>
-#include <linux/iio/buffer.h>
 #include <linux/iio/common/cros_ec_sensors_core.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/kfifo_buf.h>
-#include <linux/iio/trigger_consumer.h>
-#include <linux/iio/triggered_buffer.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 28bde13003b7..86d8fe1146d7 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -12,7 +12,6 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/sysfs.h>
-#include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/kernel.h>
-- 
2.33.0

