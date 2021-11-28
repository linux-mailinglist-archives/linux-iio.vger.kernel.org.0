Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B0546095B
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 20:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbhK1T2P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 14:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbhK1T0N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Nov 2021 14:26:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60368C0613F1
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 11:21:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2F186111E
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 19:21:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2A0C004E1;
        Sun, 28 Nov 2021 19:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638127306;
        bh=IqNCfg93SZoTLLvKdKhxPUT4Z7BsH3ioNYKX7qCsqM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qXorQZQakYtkeoZCoPw6yNmIGG2rhaawhvMOjmU1cYf32oxayvCbwvI4Iu/i25uCs
         L/2SErn++K7IoomnH4OWZOe7UdEdQq6sblHllWFeGmJBMp6regoXRjMvacoW/mbIXP
         lrEzOEOBJXa7JjmKFC1gBp8Bi8wr4RVY8Jbb97ai3OpRoW05zc7WBiDnkkJGumtGkO
         0iXTORS5XmXWAzDH1gRIy0VZrKwtdeaNtFf5p9Wlqo9vr4FK/W/Hef6oXH9ZEM3wUN
         pbYpg3Ra5MqaRosVewozD92nYDBf9pEUzq61sixQztIyj8uEaLBazetxSxOejDhUca
         Ug9EFf+gpilpA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Daniel Gomez <dagmcr@gmail.com>
Subject: [PATCH 02/12] iio:dac:ad5758: Drop unused of specific headers.
Date:   Sun, 28 Nov 2021 19:26:25 +0000
Message-Id: <20211128192635.2724359-3-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211128192635.2724359-1-jic23@kernel.org>
References: <20211128192635.2724359-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These have never been used in this driver.  What is used is in
mod_devicetable.h so add that include (struct of_device_id)

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Daniel Gomez <dagmcr@gmail.com>
---
 drivers/iio/dac/ad5758.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
index 0572ef518101..98771e37a7b5 100644
--- a/drivers/iio/dac/ad5758.c
+++ b/drivers/iio/dac/ad5758.c
@@ -10,9 +10,8 @@
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/property.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/spi/spi.h>
 #include <linux/gpio/consumer.h>
 
-- 
2.34.1

