Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A290420170
	for <lists+linux-iio@lfdr.de>; Sun,  3 Oct 2021 14:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhJCMPg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Oct 2021 08:15:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230156AbhJCMPf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Oct 2021 08:15:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E715461267;
        Sun,  3 Oct 2021 12:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633263228;
        bh=w4qO/pnH1cpbrf1nW1QlqchxPksEP7BsWLtDLi9/hoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VyPymae42ZpEHWfqe2PVxUjWXiaAVWYwP2Edgla7cC4pxjY0ZNEMR3zrlrPbTwGer
         OOtwZqiNImPfvRCYDRJbkJX1giqQh+AMiuKVLTCm7L5avLQh2EvqYLzi7Qe370I0SA
         RWfFtXWjOFlBn8gGU+vgu75VuqU0biMoBq9zs+aYIYwmGykFJoMxOrnKDXJzfcVPBJ
         l1AqSKOjjCVunnar++tg9qfXV5GfrR/QGLhIVGh+pCtLb3EphWF0PaDUSPl1niERe5
         kR9MLR/c59FZLZ9+hJkbF/V39JRqnkhuYwZ3QfXRJzdfLEd4Wpnxc1idars73xCi4q
         oybJm5wy2zM9Q==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 3/7] iio: accel: cros_ec_accel_legacy: Drop unused IIO includes
Date:   Sun,  3 Oct 2021 13:17:07 +0100
Message-Id: <20211003121711.279736-4-jic23@kernel.org>
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
Note that to keep this patch simple and non controversial it only
removes IIO headers that are clearly unused in this driver.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/cros_ec_accel_legacy.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
index b6f3471b62dc..f5abe993d38e 100644
--- a/drivers/iio/accel/cros_ec_accel_legacy.c
+++ b/drivers/iio/accel/cros_ec_accel_legacy.c
@@ -11,12 +11,9 @@
 
 #include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/iio/buffer.h>
 #include <linux/iio/common/cros_ec_sensors_core.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
-#include <linux/iio/trigger_consumer.h>
-#include <linux/iio/triggered_buffer.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-- 
2.33.0

