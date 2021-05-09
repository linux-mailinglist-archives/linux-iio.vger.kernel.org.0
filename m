Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54AEB377658
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 13:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhEILh5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 07:37:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229563AbhEILh5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 May 2021 07:37:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89B4661401;
        Sun,  9 May 2021 11:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620560214;
        bh=bz2NiDRgW5QIwNjnTW3+GXd1guZ1feyFrulM4D9Rs08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mCTIwWQjdeegfLK+wBK3+wKhfILSxPMUY4AQIpW7dZpXZEmu9esH0NzicURIC7+5N
         eHlcVUpmlmE55dSaSM/hjtjYyWnODoQyfGH8Uh3ty/R8lcatFy0jYlWI/WeUuGqZZ0
         u+zYqnsrkCCwz6TZEWSnLg0JG9IzS2b5X+fPfJVoCZyTy0sPRUlQ6IDk9yQ03+Sfct
         VTr8jFqSNFCUd8q7d9PuaKpxt0BIaMiBUzubPutw2n/zsHRszoPYIZXouPngTdhQJv
         xtjnAluv8FWf+oYVKkXLelkJTyffFXFLOEj5CD8D7drKPGbYrxnc28iqDlIHqSinIL
         +rMP0/WXDuozQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 02/28] iio: light: isl29028: Balance runtime pm + use pm_runtime_resume_and_get()
Date:   Sun,  9 May 2021 12:33:28 +0100
Message-Id: <20210509113354.660190-3-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210509113354.660190-1-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

In remove this driver called pm_runtime_put_noidle() but there is
no matching get operation.  This does not cause any problems because
the reference counter will not change if already zero, but it
does make the code harder to reason about so should be dropped.

Whilst we are here, use pm_runtime_resume_and_get() to replace open
coded version.
Found using coccicheck script under review at:
https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/iio/light/isl29028.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
index 2f8b494f3e08..9de3262aa688 100644
--- a/drivers/iio/light/isl29028.c
+++ b/drivers/iio/light/isl29028.c
@@ -339,9 +339,7 @@ static int isl29028_set_pm_runtime_busy(struct isl29028_chip *chip, bool on)
 	int ret;
 
 	if (on) {
-		ret = pm_runtime_get_sync(dev);
-		if (ret < 0)
-			pm_runtime_put_noidle(dev);
+		ret = pm_runtime_resume_and_get(dev);
 	} else {
 		pm_runtime_mark_last_busy(dev);
 		ret = pm_runtime_put_autosuspend(dev);
@@ -647,7 +645,6 @@ static int isl29028_remove(struct i2c_client *client)
 
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
-	pm_runtime_put_noidle(&client->dev);
 
 	return isl29028_clear_configure_reg(chip);
 }
-- 
2.31.1

