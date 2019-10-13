Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99190D559F
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2019 12:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfJMKTt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Oct 2019 06:19:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728620AbfJMKTt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 06:19:49 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC8F820679;
        Sun, 13 Oct 2019 10:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570961988;
        bh=0BhcQfU6KcDGaNcY0i9Iio+z8Y/np4SI8kKWAcDCnbI=;
        h=From:To:Cc:Subject:Date:From;
        b=oDmgLsk5huxJP72TDVSMlM3qFUUCzimh7LLp58Cf+PkfDdlR/3VPctmu2z/LrJ/sX
         rym/5ZmaeFSL91zdKYyJ5VaqMnBZpANz8OxlmQTXDYe3jprh0UogVILCZ/LcfHUVbe
         EtsX8kDrBkqmDLD3MP210QjUL4onpZYFzmcIGj5Q=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] iio: pressure: bmp280 endian tidy ups
Date:   Sun, 13 Oct 2019 11:17:42 +0100
Message-Id: <20191013101742.1454364-1-jic23@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

There is a somewhat interesting mixture of be16 and le16 going on in
this one function.  Changes here formalize that a little more.

CHECK   drivers/iio/pressure/bmp280-core.c
drivers/iio/pressure/bmp280-core.c:215:35: warning: cast to restricted __le16
drivers/iio/pressure/bmp280-core.c:229:37: warning: cast to restricted __be16
drivers/iio/pressure/bmp280-core.c:229:37: warning: cast to restricted __be16
drivers/iio/pressure/bmp280-core.c:229:37: warning: cast to restricted __be16
drivers/iio/pressure/bmp280-core.c:229:37: warning: cast to restricted __be16
drivers/iio/pressure/bmp280-core.c:230:36: warning: cast to restricted __be16
drivers/iio/pressure/bmp280-core.c:230:36: warning: cast to restricted __be16
drivers/iio/pressure/bmp280-core.c:230:36: warning: cast to restricted __be16
drivers/iio/pressure/bmp280-core.c:230:36: warning: cast to restricted __be16
drivers/iio/pressure/bmp280-core.c:237:37: warning: cast to restricted __le16

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/pressure/bmp280-core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index c3b5c1f6614d..d3c817c03722 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -148,6 +148,8 @@ static int bmp280_read_calib(struct bmp280_data *data,
 {
 	int ret;
 	unsigned int tmp;
+	__le16 l16;
+	__be16 b16;
 	struct device *dev = data->dev;
 	__le16 t_buf[BMP280_COMP_TEMP_REG_COUNT / 2];
 	__le16 p_buf[BMP280_COMP_PRESS_REG_COUNT / 2];
@@ -207,12 +209,12 @@ static int bmp280_read_calib(struct bmp280_data *data,
 	}
 	calib->H1 = tmp;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H2, &tmp, 2);
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H2, &l16, 2);
 	if (ret < 0) {
 		dev_err(dev, "failed to read H2 comp value\n");
 		return ret;
 	}
-	calib->H2 = sign_extend32(le16_to_cpu(tmp), 15);
+	calib->H2 = sign_extend32(le16_to_cpu(l16), 15);
 
 	ret = regmap_read(data->regmap, BMP280_REG_COMP_H3, &tmp);
 	if (ret < 0) {
@@ -221,20 +223,20 @@ static int bmp280_read_calib(struct bmp280_data *data,
 	}
 	calib->H3 = tmp;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H4, &tmp, 2);
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H4, &b16, 2);
 	if (ret < 0) {
 		dev_err(dev, "failed to read H4 comp value\n");
 		return ret;
 	}
-	calib->H4 = sign_extend32(((be16_to_cpu(tmp) >> 4) & 0xff0) |
-				  (be16_to_cpu(tmp) & 0xf), 11);
+	calib->H4 = sign_extend32(((be16_to_cpu(b16) >> 4) & 0xff0) |
+				  (be16_to_cpu(b16) & 0xf), 11);
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H5, &tmp, 2);
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H5, &l16, 2);
 	if (ret < 0) {
 		dev_err(dev, "failed to read H5 comp value\n");
 		return ret;
 	}
-	calib->H5 = sign_extend32(((le16_to_cpu(tmp) >> 4) & 0xfff), 11);
+	calib->H5 = sign_extend32(((le16_to_cpu(l16) >> 4) & 0xfff), 11);
 
 	ret = regmap_read(data->regmap, BMP280_REG_COMP_H6, &tmp);
 	if (ret < 0) {
-- 
2.23.0

