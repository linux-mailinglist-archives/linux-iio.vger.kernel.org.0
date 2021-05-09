Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EABA377661
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 13:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbhEILiS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 07:38:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229609AbhEILiR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 May 2021 07:38:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23D35613D6;
        Sun,  9 May 2021 11:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620560234;
        bh=7EXmWwkks8vw5xbBzmoA69o4jnn5v7rNcAuK5krjy8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jprZUt/kenqi8MCyyPnJ7hzg0bxP8UFFfOwwyg80d5vSPTjbFBhzHzuz7ooWdOWxJ
         dFQGWLGHo2Ri1G1JgzRsV1RY+Hkk9GLjlIP1gp7ZBR7blwfs9b+7S5NZnIoN5ox3pN
         y1QDB5ope99phNOhTOPmNKNrpy/XPY8c5hbUsCHKfhLlQkgzflKbXNhb1TFSBgIcC1
         JByS0Pisvu5wkzVeDwulQPXsFl24o6UMDCxyuG+wONWvmpqGBQEoe0P9hDgbbcfV6N
         mXa9lqyHddRy2AcU1D1NyrGSSOuHpbDi/oKdfLD5YBOM8x4uU9a1qWyOs5ian7pccA
         mnf2DBsfFG8Lg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 11/28] iio: magn: bmc150: Balance runtime pm + use pm_runtime_resume_and_get()
Date:   Sun,  9 May 2021 12:33:37 +0100
Message-Id: <20210509113354.660190-12-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210509113354.660190-1-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

probe() error paths after runtime pm is enabled, should disable it.
remove() should not call pm_runtime_put_noidle() as there is no
matching get() to have raised the reference count.  This case
has no affect a the runtime pm core protects against going negative.

Whilst here use pm_runtime_resume_and_get() to tidy things up a little.
coccicheck script didn't get this one due to complex code structure so
found by inspection.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/magnetometer/bmc150_magn.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index d75b437a43f2..39920cb764bf 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -262,7 +262,7 @@ static int bmc150_magn_set_power_state(struct bmc150_magn_data *data, bool on)
 	int ret;
 
 	if (on) {
-		ret = pm_runtime_get_sync(data->dev);
+		ret = pm_runtime_resume_and_get(data->dev);
 	} else {
 		pm_runtime_mark_last_busy(data->dev);
 		ret = pm_runtime_put_autosuspend(data->dev);
@@ -271,9 +271,6 @@ static int bmc150_magn_set_power_state(struct bmc150_magn_data *data, bool on)
 	if (ret < 0) {
 		dev_err(data->dev,
 			"failed to change power state to %d\n", on);
-		if (on)
-			pm_runtime_put_noidle(data->dev);
-
 		return ret;
 	}
 #endif
@@ -963,12 +960,14 @@ int bmc150_magn_probe(struct device *dev, struct regmap *regmap,
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
 		dev_err(dev, "unable to register iio device\n");
-		goto err_buffer_cleanup;
+		goto err_disable_runtime_pm;
 	}
 
 	dev_dbg(dev, "Registered device %s\n", name);
 	return 0;
 
+err_disable_runtime_pm:
+	pm_runtime_disable(dev);
 err_buffer_cleanup:
 	iio_triggered_buffer_cleanup(indio_dev);
 err_free_irq:
@@ -992,7 +991,6 @@ int bmc150_magn_remove(struct device *dev)
 
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
-	pm_runtime_put_noidle(dev);
 
 	iio_triggered_buffer_cleanup(indio_dev);
 
-- 
2.31.1

