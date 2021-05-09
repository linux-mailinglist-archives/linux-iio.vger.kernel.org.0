Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B9337765E
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 13:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhEILiL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 07:38:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229609AbhEILiK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 May 2021 07:38:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C05B61401;
        Sun,  9 May 2021 11:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620560228;
        bh=rVbI4Gr++tq/9a+iXLs0VL/yh09VWbY10FGE3C9nngM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XcC+sRm4lJaKtCZjB+kMRU8ZoaUkwsQ0LllJ65NjWG0IdBlQA1UP6Q7tTQ1Ew7A/U
         p7oZoU7jJdFvrxKs6e749y4Ki08vDmqXJEp2AkH+miX1CgTsdwUEX0W748zZ4h2mop
         Bf8ARDBbYTl0N7SlMvrzczdf+L0w1LudDsGYtXMtbRLo8TEWMMPxqAkwedg49hNveB
         Srl2QMIeQWQpl9ekiKYuMTf9mUS6KcIZ/w2lpCITbMqGVOqiRfKm8p5x3JyZjWwZPt
         HmNBw8XahzLUFfCAfQYKp7qlskB8P4ju46RMZneEr7qVTdxQySzOUGgc6unent3OUf
         /fd47b6bap8VA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 08/28] iio: hid: trigger: Balance runtime pm + use pm_runtime_resume_and_get()
Date:   Sun,  9 May 2021 12:33:34 +0100
Message-Id: <20210509113354.660190-9-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210509113354.660190-1-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The call to pm_runtime_put_noidle() in remove() callback is not
balanced by any gets

Note this doesn't cause any problems beyond reader confusion as the runtime
pm core protects against the reference counter going negative.

Whilst here, use pm_runtiem_resume_and_get() to simplify code a little.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 5a7b3e253e58..c06537e106e9 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -163,18 +163,15 @@ int hid_sensor_power_state(struct hid_sensor_common *st, bool state)
 
 	if (state) {
 		atomic_inc(&st->user_requested_state);
-		ret = pm_runtime_get_sync(&st->pdev->dev);
+		ret = pm_runtime_resume_and_get(&st->pdev->dev);
 	} else {
 		atomic_dec(&st->user_requested_state);
 		pm_runtime_mark_last_busy(&st->pdev->dev);
 		pm_runtime_use_autosuspend(&st->pdev->dev);
 		ret = pm_runtime_put_autosuspend(&st->pdev->dev);
 	}
-	if (ret < 0) {
-		if (state)
-			pm_runtime_put_noidle(&st->pdev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	return 0;
 #else
@@ -222,7 +219,6 @@ void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
 		pm_runtime_disable(&attrb->pdev->dev);
 
 	pm_runtime_set_suspended(&attrb->pdev->dev);
-	pm_runtime_put_noidle(&attrb->pdev->dev);
 
 	cancel_work_sync(&attrb->work);
 	iio_trigger_unregister(attrb->trigger);
-- 
2.31.1

