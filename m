Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0E8D56E3
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2019 18:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbfJMQ4R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Oct 2019 12:56:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbfJMQ4R (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 12:56:17 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4384620679;
        Sun, 13 Oct 2019 16:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570985777;
        bh=LBlXmyDEvP+Q43t3tNMDLYDzE/6TQXoPweoKRXM8Y84=;
        h=From:To:Cc:Subject:Date:From;
        b=bJ3IVbRjOiTha36Dzd+KAd48Als6212aF+xM9+7JT1sxrtp2xxLOc/KLkzrQIUcwm
         tJgs4xwFYLzYLNSKqjS+R7rvr6eM1rI+3pHIeXRu4i3mkro/UKkrIJjNEU4lZ3hiAS
         Hs0MjO8duh4QsegK/AnXq1LJpGIUw6WoK203YWRc=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Brauchli <a.brauchli@elementarea.net>
Subject: [PATCH] iio: chemical: sgp30: drop excess semicolon
Date:   Sun, 13 Oct 2019 17:54:12 +0100
Message-Id: <20191013165412.2090798-1-jic23@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Suggested by coccinelle / coccicheck.

CHECK   drivers/iio/chemical/sgp30.c
drivers/iio/chemical/sgp30.c:486:2-3: Unneeded semicolon

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andreas Brauchli <a.brauchli@elementarea.net>
---
 drivers/iio/chemical/sgp30.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/sgp30.c b/drivers/iio/chemical/sgp30.c
index 8cc8fe5e356d..403e8803471a 100644
--- a/drivers/iio/chemical/sgp30.c
+++ b/drivers/iio/chemical/sgp30.c
@@ -483,7 +483,7 @@ static void sgp_init(struct sgp_data *data)
 		data->iaq_defval_skip_jiffies =
 			43 * data->measure_interval_jiffies;
 		break;
-	};
+	}
 }
 
 static const struct iio_info sgp_info = {
-- 
2.23.0

