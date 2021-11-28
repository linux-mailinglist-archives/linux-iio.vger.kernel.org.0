Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED22F4607FF
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 18:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345586AbhK1RZY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 12:25:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35678 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358872AbhK1RXY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Nov 2021 12:23:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D627B80B2F
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 17:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5DCC53FCB;
        Sun, 28 Nov 2021 17:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638120006;
        bh=M4e12yLHtWRNH4HhQeaN64Rvd0MXe7DUgS09Gr+HST4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yi0gaf3TdrqLBXg09nMPJn86FxEBqPGfLWZ6BGHbqV6mvFZtBMiWqNji1brUCH0y6
         d6WQyfCgUCjIwFVqPa32gQAk2JaQZ673t+hCoVFzwMZ8qBNK/ImhIkc0qzwPnd5FCI
         2hSFP4759xFfIoyqpsFkan485gQiRuPQG50ZIwK/6HKxayyYXazfwACc/c7bDnRVCg
         pfzS3IKXDEKRscVIPfONidPaYhuXl6zf1JQewEU4wAwiKpuSQgtWuXq4SH5mcNoQs8
         97H48mYoy3VW19Q92TtoHjBB25OY2IfEtg0JCIAeT8fX4oGJ+CAZs5DtOW3kc8kOj3
         /Ep5Wd+8h28IA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 06/12] iio:dac:mcp4725: Suppress clang W=1 warning about pointer to enum conversion.
Date:   Sun, 28 Nov 2021 17:24:39 +0000
Message-Id: <20211128172445.2616166-7-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211128172445.2616166-1-jic23@kernel.org>
References: <20211128172445.2616166-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Cast to a uintptr_t rather than directly to the enum.

As per the discussion in below linked media patch.

Link: https://lore.kernel.org/linux-media/CAK8P3a2ez6nEw4d+Mqa3XXAz0RFTZHunqqRj6sCt7Y_Eqqs0rw@mail.gmail.com/
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/iio/dac/mcp4725.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index 98b2c2f10bf3..842bad57cb88 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -386,7 +386,7 @@ static int mcp4725_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 	if (dev_fwnode(&client->dev))
-		data->id = (enum chip_id)device_get_match_data(&client->dev);
+		data->id = (uintptr_t)device_get_match_data(&client->dev);
 	else
 		data->id = id->driver_data;
 	pdata = dev_get_platdata(&client->dev);
-- 
2.34.1

