Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642984A38A8
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355946AbiA3T1X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235841AbiA3T1D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:27:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBA6C06173B
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 11:27:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DC56612E3
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:27:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BF6C340F0;
        Sun, 30 Jan 2022 19:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570822;
        bh=G04fdIMUa6v1+8tVFx6CelAu5p3onnsc4CeAMSaDGvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AClQmlHNbSBgjutJTXQKdufcjiNXK60SLCEDCaJmRElNlmMiW1eupMIBgONvLdKkP
         kbcCtdJog7rh4cuk3gQ+2SxOaGzX9Vb+2RQCo742HVGUzJ1wXztfV9gzebZF9e8Q5Q
         gBtkcGT69AjR4eo4aatyadKYzmSv1Ada8sS2vFf5x1/yoWFSNYmJ7YtbNiUZLGZ44D
         TQT6agpWnwnYLpr6dabQKnoh25LTXV3swUn78HHYnAAWIDQicsCAtHO5r4DAQ0jJDg
         P3Ok0uWkp5DFq9M2JT7J6J3UyJpc2xnJqvatRyU4SLuBa0VgiW6y4ieFRLT0IIkXkc
         C7G/NdKuS4HVQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 40/50] iio:dac:m62332: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:37 +0000
Message-Id: <20220130193147.279148-41-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220130193147.279148-1-jic23@kernel.org>
References: <20220130193147.279148-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM_SLEEP support is simpler and less error prone than the
use of #ifdef based config guards.

Note that in this case the storage for saving state was protected
by CONFIG_PM guards. The storage is very small and unlikely to make
any real difference to the space allocated for state so just drop
those guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dac/m62332.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
index 225b1a374dc1..22b02f50fe41 100644
--- a/drivers/iio/dac/m62332.c
+++ b/drivers/iio/dac/m62332.c
@@ -25,9 +25,7 @@ struct m62332_data {
 	struct regulator	*vcc;
 	struct mutex		mutex;
 	u8			raw[M62332_CHANNELS];
-#ifdef CONFIG_PM_SLEEP
 	u8			save[M62332_CHANNELS];
-#endif
 };
 
 static int m62332_set_value(struct iio_dev *indio_dev, u8 val, int channel)
@@ -124,7 +122,6 @@ static int m62332_write_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int m62332_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -156,11 +153,7 @@ static int m62332_resume(struct device *dev)
 	return m62332_set_value(indio_dev, data->save[1], 1);
 }
 
-static SIMPLE_DEV_PM_OPS(m62332_pm_ops, m62332_suspend, m62332_resume);
-#define M62332_PM_OPS (&m62332_pm_ops)
-#else
-#define M62332_PM_OPS NULL
-#endif
+static DEFINE_SIMPLE_DEV_PM_OPS(m62332_pm_ops, m62332_suspend, m62332_resume);
 
 static const struct iio_info m62332_info = {
 	.read_raw = m62332_read_raw,
@@ -246,7 +239,7 @@ MODULE_DEVICE_TABLE(i2c, m62332_id);
 static struct i2c_driver m62332_driver = {
 	.driver = {
 		.name	= "m62332",
-		.pm	= M62332_PM_OPS,
+		.pm	= pm_sleep_ptr(&m62332_pm_ops),
 	},
 	.probe		= m62332_probe,
 	.remove		= m62332_remove,
-- 
2.35.1

