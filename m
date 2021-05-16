Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4879381FC4
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 18:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhEPQXY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 12:23:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230032AbhEPQXX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 May 2021 12:23:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A938C61076;
        Sun, 16 May 2021 16:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621182129;
        bh=uf6PjSav2mP74fAaaWRXlTVQrUL+VFrQt8ewiXUnVfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F21dBSGpNV1xqgKWzKKPLpt0G/Rz1RqnQA3ytcRCzflLnDmWpg5UaxoBEI41ia6kW
         zHf9Pt49g3XSVzREIcz0fUpdTyHbT/rCg7awjwdy0m5pZwFwENL7JCyqvtvAwHv2xu
         RQ4iM5erXLwkwjpSCnbwZrTK1bGXWVEi2tqDBwLfAAE0/doM25E/9x6haJOOzAznh4
         +rbCeTnL0ITYpIIdiZ/hs/PeoWZ5HPETpMSNUqMHcd+knlc7n2OUlQJUr6vroKWxTY
         u8/F/28rSlZ/+WjTpZ52HuwwffAh0V30iwa9zjTma+DEX3eomj7/bOMW7666R0Is6i
         hTtriJ6tia7HA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v2 5/6] iio: prox: pulsed-light-v2: Use pm_runtime_resume_and_get()
Date:   Sun, 16 May 2021 17:21:02 +0100
Message-Id: <20210516162103.1332291-6-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210516162103.1332291-1-jic23@kernel.org>
References: <20210516162103.1332291-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Using this new call makes it easy to handle any errors as a result
of runtime resume as it exits without leaving the reference count
elevated.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index ecaeb1e11007..e94f63932edb 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -158,7 +158,9 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
 	int tries = 10;
 	int ret;
 
-	pm_runtime_get_sync(&client->dev);
+	ret = pm_runtime_resume_and_get(&client->dev);
+	if (ret < 0)
+		return ret;
 
 	/* start sample */
 	ret = lidar_write_control(data, LIDAR_REG_CONTROL_ACQUIRE);
-- 
2.31.1

