Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD30482B4F
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbiABMxH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiABMxH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:53:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D750C061574
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 04:53:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BEDB60E98
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:53:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CADC36AE7;
        Sun,  2 Jan 2022 12:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127985;
        bh=iVNVOB5dBCjaDkLRpeqAFeMbwTFjhUuwPDEV/AhmVw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lci1gFqMraQcwVnrU18pHqvZ4LcqIdBFl+KKWudIoBTHc6cC+CahhTk/YpB+JTgYL
         ez7yXGzWnuW0b+GnQPyQB4CYgjKYYG6TBfYvOO3dkwGe6G61+wlmL/y7UiQVSugZ9C
         Solu6o/JtvKzNi2CryaKcBfHV5DUwV9EmApYwGPC4loGWahXaSJtCSqUqTrSHQc3hW
         H8vvad1Cq84/6biqN+s3i9bOqxFSjw3fH8wtlCjqYxg66UHc0c9g4JOxBMuQawcQe3
         02fdlHKlOMwbsN5Y/E4f2ABOFPOc6A64vL9REG+XYdzDmdSXgUykfX5SIwslW91ef8
         cksnT9T8rQ/4w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 48/51] iio:dac:m62332: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun,  2 Jan 2022 12:56:14 +0000
Message-Id: <20220102125617.1259804-49-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220102125617.1259804-1-jic23@kernel.org>
References: <20220102125617.1259804-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM_SLEEP support is simpler and less error prone than the
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dac/m62332.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
index 225b1a374dc1..4a413936fabb 100644
--- a/drivers/iio/dac/m62332.c
+++ b/drivers/iio/dac/m62332.c
@@ -124,7 +124,6 @@ static int m62332_write_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int m62332_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -156,11 +155,7 @@ static int m62332_resume(struct device *dev)
 	return m62332_set_value(indio_dev, data->save[1], 1);
 }
 
-static SIMPLE_DEV_PM_OPS(m62332_pm_ops, m62332_suspend, m62332_resume);
-#define M62332_PM_OPS (&m62332_pm_ops)
-#else
-#define M62332_PM_OPS NULL
-#endif
+DEFINE_SIMPLE_DEV_PM_OPS(m62332_pm_ops, m62332_suspend, m62332_resume);
 
 static const struct iio_info m62332_info = {
 	.read_raw = m62332_read_raw,
@@ -246,7 +241,7 @@ MODULE_DEVICE_TABLE(i2c, m62332_id);
 static struct i2c_driver m62332_driver = {
 	.driver = {
 		.name	= "m62332",
-		.pm	= M62332_PM_OPS,
+		.pm	= pm_sleep_ptr(&m62332_pm_ops),
 	},
 	.probe		= m62332_probe,
 	.remove		= m62332_remove,
-- 
2.34.1

