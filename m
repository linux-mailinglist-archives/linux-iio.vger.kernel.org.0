Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62175377660
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 13:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhEILiR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 07:38:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229636AbhEILiQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 May 2021 07:38:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E4E8613E5;
        Sun,  9 May 2021 11:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620560232;
        bh=BjFaB4e8c2quSnvq6wulqkx+WCG7UJ5/yLEZuIpMXsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fLZsuO+vDjyP6k0O30RqGmdHuWTKgZ27oiVEmsGfYmZuSbXKbzonVgFwCT6nPqg1u
         Afh1tVTDXpOzfHXQDrntG93hhIZo7YwnU92bHrUikEIDjOvDpf0W1Pi2rYcwnwC4NI
         dGYSk6Oj7l+Zzn0I6ZlGOYJB/Q/XFBrCe8zB82K8emWyPdzbo466ESwc8zdC4MzIyS
         DGzGCz7ajWQ3dOFnBUzOLkCK8+EHE7gqjL7/tdCovPDm8otLPRYzdUcgALq6GzLDTf
         L2tLTbpXa7P03JDvM8DzQ7NIyXwS2BPl8QfIqcs9c8Hnvv9I11bB1nI7mXd8Hvprso
         YDAmUDLZESVrg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Subject: [PATCH 10/28] iio: light: rpr0521: Balance runtime pm + use pm_runtime_resume_and_get()
Date:   Sun,  9 May 2021 12:33:36 +0100
Message-Id: <20210509113354.660190-11-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210509113354.660190-1-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Calls to pm_runtime_put_noidle in probe() error path and remove() are
not match to any get() calls.

The runtime pm core protects against negative reference counts, so this
doesn't have any visible impact beyond confusing the reader.

Whilst here use pm_runtime_resume_and_get() to replace boilerplate.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
---
 drivers/iio/light/rpr0521.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index 7e332de0e6a5..c2dd8a3d4217 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -360,7 +360,7 @@ static int rpr0521_set_power_state(struct rpr0521_data *data, bool on,
 	 * both stay enabled until _suspend().
 	 */
 	if (on) {
-		ret = pm_runtime_get_sync(&data->client->dev);
+		ret = pm_runtime_resume_and_get(&data->client->dev);
 	} else {
 		pm_runtime_mark_last_busy(&data->client->dev);
 		ret = pm_runtime_put_autosuspend(&data->client->dev);
@@ -369,9 +369,6 @@ static int rpr0521_set_power_state(struct rpr0521_data *data, bool on,
 		dev_err(&data->client->dev,
 			"Failed: rpr0521_set_power_state for %d, ret %d\n",
 			on, ret);
-		if (on)
-			pm_runtime_put_noidle(&data->client->dev);
-
 		return ret;
 	}
 
@@ -1038,7 +1035,6 @@ static int rpr0521_probe(struct i2c_client *client,
 err_pm_disable:
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
-	pm_runtime_put_noidle(&client->dev);
 err_poweroff:
 	rpr0521_poweroff(data);
 
@@ -1053,7 +1049,6 @@ static int rpr0521_remove(struct i2c_client *client)
 
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
-	pm_runtime_put_noidle(&client->dev);
 
 	rpr0521_poweroff(iio_priv(indio_dev));
 
-- 
2.31.1

