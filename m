Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB6D37765D
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 13:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhEILiJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 07:38:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229609AbhEILiI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 May 2021 07:38:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07324613F0;
        Sun,  9 May 2021 11:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620560225;
        bh=cJngXrvFUs6hR//juFsPm9bJ/pJKZFHgVYA73AHf/Fk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u9WhqDrt4PBOwXUUsrT0PkTbxgegwNLUvtEoSM6LfvyPR0iPlzTIpiGIUBUqHQuHU
         tujGkBlsh1lHvNAlE1RqRpTiKfzyfFTM/wHuiQWCQR+qArEoKpb6bv6bY8RlDNflur
         gyA/bryYJ3cfRBNzRxc0+0CNR8Vsjkfs9sqTPNoRkjDERsk7/L9kO+DNSUzLypU+lU
         G/kEpQb2u2j54SwlxxFrJt3DHWw5OPPH6eTS8JQ/Hkl63xGh9Ss1dUwRKZf2xw2WQw
         JnULKwHTHWDiTWRXK/bJCcoJmhJxfn7vz4NTqhJVwJbk6LnNagv/tjJZGAfLSmT707
         tOWsXy8miSQGw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 07/28] iio: accel: kxcjk-1013: Balance runtime pm + use pm_runtime_resume_and_get()
Date:   Sun,  9 May 2021 12:33:33 +0100
Message-Id: <20210509113354.660190-8-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210509113354.660190-1-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This driver alls pm_runtime_put_noidle() in it's remove function, but there
is no matching get call.  This isn't a bug as runtime pm will not allow
the reference counter to go negative, but it is missleading so lets remove
it.

Whilst here use pm_runtime_resume_and_get() to tidy up some boilerplate.
The coccicheck script didn't get this one due to the less obvious
structure. Found by inspection.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/kxcjk-1013.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 283e6a3feffc..a9e3dae43ac5 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -478,7 +478,7 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
 	int ret;
 
 	if (on)
-		ret = pm_runtime_get_sync(&data->client->dev);
+		ret = pm_runtime_resume_and_get(&data->client->dev);
 	else {
 		pm_runtime_mark_last_busy(&data->client->dev);
 		ret = pm_runtime_put_autosuspend(&data->client->dev);
@@ -486,8 +486,6 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
 	if (ret < 0) {
 		dev_err(&data->client->dev,
 			"Failed: %s for %d\n", __func__, on);
-		if (on)
-			pm_runtime_put_noidle(&data->client->dev);
 		return ret;
 	}
 #endif
@@ -1485,7 +1483,6 @@ static int kxcjk1013_remove(struct i2c_client *client)
 
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
-	pm_runtime_put_noidle(&client->dev);
 
 	if (data->dready_trig) {
 		iio_triggered_buffer_cleanup(indio_dev);
-- 
2.31.1

