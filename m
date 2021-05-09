Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD7737766F
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 13:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhEILit (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 07:38:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229680AbhEILit (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 May 2021 07:38:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F28D8613E5;
        Sun,  9 May 2021 11:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620560266;
        bh=imY20ovebcqBf7cNzjDi3fO25ReTmkGg9LKTWNxnulM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=koWoyR+35wcTMLQOlvfRWq/R2J6Qul+U79KnRaL8a3ldrM8WxkjNeh4x/1mDrV7EL
         3FDjD92sb3G21uQi6rtaU8sH/0u0CuDUM6kzXRIZpxyhv5yIWcZ01ws7QSfx7VGoW6
         6ROmbz++6sbb0YZFgICIFDy6rtWPOLI5GxUzzJtA1jQ9kMHFaLxkodt+4xwVi1vgBz
         6OcJpAY5wwVq6tqzNn4gglyzqd8mPk57ptJKVFptjIHoReeldK/3DKC1Y9WOrecd2N
         NcOCl35yjgOVks9pbxmjjMiyHocaYUwjj3vKbmy4Ec/ewccnY9dE//qaIo3VYDcId5
         Jeuk+NVCYWrDw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Klinger <ak@it-klinger.de>
Subject: [PATCH 25/28] iio: proximity: srf04: Use pm_runtime_resume_and_get() and handle error
Date:   Sun,  9 May 2021 12:33:51 +0100
Message-Id: <20210509113354.660190-26-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210509113354.660190-1-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Previously this driver used pm_runtime_sync_get() and did not handle any
errors that occurred.  Moving to the new pm_runtime_resume_and_get() +
handle errors.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/proximity/srf04.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
index 420c37c72de4..fe88b2bb60bc 100644
--- a/drivers/iio/proximity/srf04.c
+++ b/drivers/iio/proximity/srf04.c
@@ -100,9 +100,11 @@ static int srf04_read(struct srf04_data *data)
 	u64 dt_ns;
 	u32 time_ns, distance_mm;
 
-	if (data->gpiod_power)
-		pm_runtime_get_sync(data->dev);
-
+	if (data->gpiod_power) {
+		ret = pm_runtime_resume_and_get(data->dev);
+		if (ret < 0)
+			return ret;
+	}
 	/*
 	 * just one read-echo-cycle can take place at a time
 	 * ==> lock against concurrent reading calls
-- 
2.31.1

