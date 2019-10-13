Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4888CD5635
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2019 14:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfJMMhb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Oct 2019 08:37:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728932AbfJMMhb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 08:37:31 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F82D2067B;
        Sun, 13 Oct 2019 12:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570970250;
        bh=49YuXkdLy/5nDhj8hqMUuAy1SjCxYXhUWGj1VlwQobE=;
        h=From:To:Cc:Subject:Date:From;
        b=mrIYj8Y5snpAMjOCs7WpL1w9yXd9r0CZlphza0BoCaIdGzIkmjd1CypG9vI1L3Nf5
         npJKlB9bgqzSBAg504o8ZXMsLeaGKkgxOnFG8ccqomgKT9huHuMsOH0SvrUMOhLVKb
         WrqYoZk4y2C8jnH9gT+JKZ10p7AFSQgZg0fM60sw=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/2] iio: adc: exynos: Drop a stray semicolon
Date:   Sun, 13 Oct 2019 13:35:23 +0100
Message-Id: <20191013123524.1821390-1-jic23@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Identified by coccinelle
drivers/iio/adc/exynos_adc.c:654:2-3: Unneeded semicolon

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/exynos_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 42a3ced11fbd..b5a497381452 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -651,7 +651,7 @@ static irqreturn_t exynos_ts_isr(int irq, void *dev_id)
 		input_sync(info->input);
 
 		usleep_range(1000, 1100);
-	};
+	}
 
 	writel(0, ADC_V1_CLRINTPNDNUP(info->regs));
 
-- 
2.23.0

