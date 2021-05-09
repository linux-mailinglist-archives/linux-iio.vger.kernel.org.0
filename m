Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376CE37766C
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 13:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhEILil (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 07:38:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229657AbhEILik (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 May 2021 07:38:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EFFE613F0;
        Sun,  9 May 2021 11:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620560257;
        bh=ucchPJLzLENSH6ctEOWu0Junud0viddaAFGSJU4LJjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WEOEQdw7QZnHTj8zgJH8SWtJTCV1zng5b9pVs8KUQHPqoOIfCSJpQam5Xu2xoDIEf
         JyYGxAxRudOLrDkr5hqX+y1RRIgUxm/oUUK71slQpnyXrFU8VQPSByJower/m7l/qU
         v6f3PLPkoaXgtd0hNFXtnw9flMDfrOmNRZLSTjpEI9VJH1AFd8aNSBQDZQlMQ2Rbyl
         mWL7/lj1fzSAnN4O5t4eQqH/PgUeaV0QY6ZhZ7qd+PeLtoQjDr1yqmlNgqiLz2vgsQ
         JitcdK8itye0NwaNoUIczLlpr/IzjTBTZVT3rIzj8lu5ftXqv63bYZjnNqb993sy+g
         lWGSB5i8t/UQg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH 21/28] iio: light: vcnl4000: Use pm_runtime_resume_and_get() to replace open coding.
Date:   Sun,  9 May 2021 12:33:47 +0100
Message-Id: <20210509113354.660190-22-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210509113354.660190-1-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Found using coccicheck script under review at:
https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/

This is a prequel to taking a closer look at the runtime pm in IIO drivers
in general.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mathieu Othacehe <m.othacehe@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 4a61865d01cd..01772327a947 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -413,9 +413,7 @@ static int vcnl4000_set_pm_runtime_state(struct vcnl4000_data *data, bool on)
 	int ret;
 
 	if (on) {
-		ret = pm_runtime_get_sync(dev);
-		if (ret < 0)
-			pm_runtime_put_noidle(dev);
+		ret = pm_runtime_resume_and_get(dev);
 	} else {
 		pm_runtime_mark_last_busy(dev);
 		ret = pm_runtime_put_autosuspend(dev);
-- 
2.31.1

