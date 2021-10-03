Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988A0420171
	for <lists+linux-iio@lfdr.de>; Sun,  3 Oct 2021 14:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhJCMPi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Oct 2021 08:15:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230156AbhJCMPh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Oct 2021 08:15:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F318561B43;
        Sun,  3 Oct 2021 12:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633263230;
        bh=ECxKCAq2mBnb5kxar7DvmrthPyT4hOzHW3H03Rc0ZN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gJunhAfPjoXHdTp86qz5JvpNLJZ5GxoK+lrwL7br0ROqQhys+iUT5/4FsF76YcMbp
         FCw6B39/z4tflbtojsWCk3AVOIotG4Zk50Mb6Aesm0eq+4jL8RwRK6qbU4Gwjnm/fm
         fnNndNsKNMY7b8WhBYLpDjc0hAQLwEP2Cv19TbqhrJfH0gzlXP6mWFeEJHzcm1g4Zo
         YsEHxKwEABwQZ4yWA38f5CHuRAn+8tFdnvMBiDR2a9zdeEBW24mWpCV8cncP4pluu3
         IV4SmRG3FvsyHnkzDha7U5EXNLaOkmN5Lv7blkhLQ/xTZf3HdT2qYxXre+GxBxuyxv
         pvdXe9ySsCffA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4/7] iio: cros_ec_lid_angle: Drop unused IIO includes.
Date:   Sun,  3 Oct 2021 13:17:08 +0100
Message-Id: <20211003121711.279736-5-jic23@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211003121711.279736-1-jic23@kernel.org>
References: <20211003121711.279736-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Identified with the include-what-you-use tool.
To keep this patch simple, only remove IIO related headers that are
clearly unused in this driver.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
index af801e203623..eb402772b663 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
@@ -12,13 +12,9 @@
 
 #include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/iio/buffer.h>
 #include <linux/iio/common/cros_ec_sensors_core.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/kfifo_buf.h>
-#include <linux/iio/trigger.h>
 #include <linux/iio/triggered_buffer.h>
-#include <linux/iio/trigger_consumer.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
-- 
2.33.0

