Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0495B420172
	for <lists+linux-iio@lfdr.de>; Sun,  3 Oct 2021 14:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhJCMPk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Oct 2021 08:15:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230203AbhJCMPk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Oct 2021 08:15:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0AA19611EE;
        Sun,  3 Oct 2021 12:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633263232;
        bh=y5DFg+GfRtRPHzS+S8X4RBb67peAf3YMT9j8bXgdbmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jTbvrg+mPJ5g8oUD56XjRhQCB0Ki3qxktXCy3DUTlalEcchHagKvIvKonsnN2z7se
         CR/9B7IVzxmVV4RHa90EZG0cOSbkoojPp+M/gRggh8aMXw+ZibKQH8RZGHxLnf4Rhm
         QCEy/Kqm9f9BBGQAXTSXH9808tGmDVgoiO2JFbat7dQiiQVnm0U4WHsYV0MblkzKt9
         037L5Wt3Zzo6s06hov4YAVfR0Ny4pZ0KHBbC48Y1x7Vf7pdArKKsNUOGkGrdD531OG
         qM9H7YgyIXn9YFDQNytcQIWDqdZi9dVtrLX8max+DkDy5gDpcP3KMv5B4aZhy2PcIG
         8AYIo825R32lg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5/7] iio: light: cros_ec_light_prox: Drop unused IIO includes.
Date:   Sun,  3 Oct 2021 13:17:09 +0100
Message-Id: <20211003121711.279736-6-jic23@kernel.org>
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
To keep this patch simple, only drop IIO headers that are clearly
unused within this driver.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/cros_ec_light_prox.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
index de472f23d1cb..25b08da72314 100644
--- a/drivers/iio/light/cros_ec_light_prox.c
+++ b/drivers/iio/light/cros_ec_light_prox.c
@@ -6,13 +6,8 @@
  */
 
 #include <linux/device.h>
-#include <linux/iio/buffer.h>
 #include <linux/iio/common/cros_ec_sensors_core.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/kfifo_buf.h>
-#include <linux/iio/trigger.h>
-#include <linux/iio/triggered_buffer.h>
-#include <linux/iio/trigger_consumer.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
-- 
2.33.0

