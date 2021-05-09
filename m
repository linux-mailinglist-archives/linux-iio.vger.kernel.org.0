Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25C5377671
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 13:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbhEILiv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 07:38:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229709AbhEILiv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 May 2021 07:38:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2340C613D6;
        Sun,  9 May 2021 11:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620560268;
        bh=LipBXefBz7bSe1o0CYNXZthCsijVbOZLw8xiVRTmZEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K+NoutvWeewfSJym9uPtxJ9tz0gjzCkElXl+J8mGnciRg1uK6j55ornhQPunYvxxt
         H2bjHVIquEI/bVUBY/1TlrQMzGKPqIL0byDS7zCDEKqxKisMLlv43ff0onqgTGyEpG
         zDPX/dimBEToWf2N8lhijnu/FgteBDnyiXWE5nnWWIHtjAcasczEuGnyu96t+1maY/
         cl7MGa7dkrl5n+T6KPO0EdXoQeqB2WQB9jt2z4QNp/A6kjyDWYYsWLKMKQvNQ7Elh2
         RR/MhBMhRTFE/JzBtd2xlFF4RPg/z7ghCpukIBSsHyI1GaJkVC50fGlLLO7uLI0+T7
         QtBHzqkCxb4qg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 26/28] iio: prox: pulsed-light-v2: Switch pm_runtime_resume_and_get()
Date:   Sun,  9 May 2021 12:33:52 +0100
Message-Id: <20210509113354.660190-27-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210509113354.660190-1-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
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
---
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index c685f10b5ae4..ca8dc5cc209a 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -154,7 +154,9 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
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

