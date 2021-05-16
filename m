Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD0038202F
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 19:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhEPR1e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 13:27:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhEPR1d (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 May 2021 13:27:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B74061159;
        Sun, 16 May 2021 17:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621185978;
        bh=LpiHka1EIuPa779mW+4es5KZEQybmHDUQyuiTZUGc7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=adwxmeX8pbivvjveK7pwvlc7ph4RYQX9+s1Gjq7x2Z6wzvJPDWKEa6lnrYcFWpU6r
         RUjz7i1M5O96bWe7EIWEllg96DJDPU+v2wzOWBwWtoeC3aQtoJXVwUieqgOfsSFcvU
         rrK2LKLuO3fhkL0oiv0zpnK+OKNB86BWztt++UzMzBIYj5voqEQbPtEL8EDC1AhibR
         lx/zyVMq0j47NkRx7kiy7D6/GO1zM/Wc6sMII1P+eqxv+J+3TF5wejsjbEQsTQJplR
         L2QjEvT7VtO8I4pC4t5SsmM0Lm54imawoVUXxp+dJBRbkSeESJA0Ma+mV3HPNJcUyL
         bpHXXxJrZPm2g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Ardelean <aardelean@deviqon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH 1/8] iio: adc: max11100: Use get_unaligned_be16() rather than opencoding.
Date:   Sun, 16 May 2021 18:25:13 +0100
Message-Id: <20210516172520.1398835-2-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210516172520.1398835-1-jic23@kernel.org>
References: <20210516172520.1398835-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The function is more explicit in showing the intent + quicker on some
platforms.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jacopo Mondi <jacopo@jmondi.org>
---
 drivers/iio/adc/max11100.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max11100.c b/drivers/iio/adc/max11100.c
index 6cf21758ca66..69d607fa17aa 100644
--- a/drivers/iio/adc/max11100.c
+++ b/drivers/iio/adc/max11100.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
+#include <asm/unaligned.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/driver.h>
@@ -63,7 +64,7 @@ static int max11100_read_single(struct iio_dev *indio_dev, int *val)
 		return -EINVAL;
 	}
 
-	*val = (state->buffer[1] << 8) | state->buffer[2];
+	*val = get_unaligned_be16(&state->buffer[1]);
 
 	return 0;
 }
-- 
2.31.1

