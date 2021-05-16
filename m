Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E5B381FC3
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 18:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhEPQXW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 12:23:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:50034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230032AbhEPQXV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 May 2021 12:23:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 521F661185;
        Sun, 16 May 2021 16:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621182126;
        bh=tBn+opqtx59CTi7Z4hyip0XeuQ4Dw77jLk5qiNAGbQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J86Q3hBSLt4aX/3qonMBnAuJ25hN8Qh86xLp6VRSU3P3lmiYSKTLzIWiLrdUecDD8
         I17B4L92NqbFCoBnypW4qwk+YNwijDB4seo6dEw/lW1M6GwNV3onqkfli84poqYzlm
         afjx5BqOaKIM+YnmSIb5ie+qAGZS9o4L4oYl2V2QO4xnkDo89dU7o/f8YvFi+p/jCc
         ygRQp6TpvYHAHb6AORKWbhEGMljwhmKx+1d8bO4ltxS0G1UVQ/IVHiWyYZg+w+Qq5T
         6jkCmFc9gVbtEc+eeE7LfPLsNjrRfiig42DZTvU5xmrgD+k+mVpP5sbkIGcl/tAYDf
         6MDxFZ9ODNJjA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v2 4/6] iio: prox: pulsed-light-v2: Fix misbalance runtime pm in error path
Date:   Sun, 16 May 2021 17:21:01 +0100
Message-Id: <20210516162103.1332291-5-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210516162103.1332291-1-jic23@kernel.org>
References: <20210516162103.1332291-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

There is one path in which we don't do a runtime pm put and so
leave the device enabled for ever more.

Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Fixes: 4ac4e086fd8c ("iio: pulsedlight-lidar-lite: add runtime PM")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index 822a68ae5e03..ecaeb1e11007 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -164,7 +164,7 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
 	ret = lidar_write_control(data, LIDAR_REG_CONTROL_ACQUIRE);
 	if (ret < 0) {
 		dev_err(&client->dev, "cannot send start measurement command");
-		return ret;
+		goto err;
 	}
 
 	while (tries--) {
@@ -188,6 +188,7 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
 		}
 		ret = -EIO;
 	}
+err:
 	pm_runtime_mark_last_busy(&client->dev);
 	pm_runtime_put_autosuspend(&client->dev);
 
-- 
2.31.1

