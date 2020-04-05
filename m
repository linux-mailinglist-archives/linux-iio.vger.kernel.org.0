Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D592F19ED44
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 20:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgDESGC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 14:06:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727522AbgDESGC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 14:06:02 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24236206C3;
        Sun,  5 Apr 2020 18:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586109962;
        bh=9LIqdiBRumUXzybZ2GzIKED8/221i+8kZcN8AGEN5EM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l3YvZqDb582OFS6CHOxgXffrAyZZO4djeM+dY9IxHN/3IMLMHVGahiSANDTko7/3c
         hB7wNbq7BcqiNh+2E/TssJqUxH+uyRe7OFnXNcDCpDjGVACypqkib7o+SBMWQcRqCg
         ULo+6EINx6odTb487dbtExq7MfdOMGEY8DU7aJT4=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Daniel Baluta <daniel.baluta@gmail.com>
Subject: [PATCH 5/6] iio:magn:mmc35240: Drop unnecessary casts of val parameter in regmap_bulk*
Date:   Sun,  5 Apr 2020 19:03:20 +0100
Message-Id: <20200405180321.1737310-6-jic23@kernel.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405180321.1737310-1-jic23@kernel.org>
References: <20200405180321.1737310-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Given the parameter is void *, casting to u8 * is unnecessary.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>
---
 drivers/iio/magnetometer/mmc35240.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index 425cdd07b4e5..1787d656d009 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -239,7 +239,7 @@ static int mmc35240_init(struct mmc35240_data *data)
 		return ret;
 
 	ret = regmap_bulk_read(data->regmap, MMC35240_OTP_START_ADDR,
-			       (u8 *)otp_data, sizeof(otp_data));
+			       otp_data, sizeof(otp_data));
 	if (ret < 0)
 		return ret;
 
@@ -295,7 +295,7 @@ static int mmc35240_read_measurement(struct mmc35240_data *data, __le16 buf[3])
 	if (ret < 0)
 		return ret;
 
-	return regmap_bulk_read(data->regmap, MMC35240_REG_XOUT_L, (u8 *)buf,
+	return regmap_bulk_read(data->regmap, MMC35240_REG_XOUT_L, buf,
 				3 * sizeof(__le16));
 }
 
-- 
2.26.0

