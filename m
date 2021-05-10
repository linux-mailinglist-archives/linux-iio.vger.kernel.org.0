Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F083780A9
	for <lists+linux-iio@lfdr.de>; Mon, 10 May 2021 11:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhEJJ6Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 May 2021 05:58:16 -0400
Received: from fgw21-7.mail.saunalahti.fi ([62.142.5.82]:48748 "EHLO
        fgw21-7.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230098AbhEJJ6N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 May 2021 05:58:13 -0400
Received: from localhost (88-115-248-186.elisa-laajakaista.fi [88.115.248.186])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 147d99d2-b176-11eb-9eb8-005056bdd08f;
        Mon, 10 May 2021 12:57:07 +0300 (EEST)
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH v1 1/1] iio: dac: ad5770r: Put fwnode in error case during ->probe()
Date:   Mon, 10 May 2021 12:56:49 +0300
Message-Id: <20210510095649.3302835-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

device_for_each_child_node() bumps a reference counting of a returned variable.
We have to balance it whenever we return to the caller.

Fixes: cbbb819837f6 ("iio: dac: ad5770r: Add AD5770R support")
Cc: Alexandru Tachici <alexandru.tachici@analog.com>
Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/dac/ad5770r.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/dac/ad5770r.c b/drivers/iio/dac/ad5770r.c
index 7ab2ccf90863..8107f7bbbe3c 100644
--- a/drivers/iio/dac/ad5770r.c
+++ b/drivers/iio/dac/ad5770r.c
@@ -524,23 +524,29 @@ static int ad5770r_channel_config(struct ad5770r_state *st)
 	device_for_each_child_node(&st->spi->dev, child) {
 		ret = fwnode_property_read_u32(child, "num", &num);
 		if (ret)
-			return ret;
-		if (num >= AD5770R_MAX_CHANNELS)
-			return -EINVAL;
+			goto err_child_out;
+		if (num >= AD5770R_MAX_CHANNELS) {
+			ret = -EINVAL;
+			goto err_child_out;
+		}
 
 		ret = fwnode_property_read_u32_array(child,
 						     "adi,range-microamp",
 						     tmp, 2);
 		if (ret)
-			return ret;
+			goto err_child_out;
 
 		min = tmp[0] / 1000;
 		max = tmp[1] / 1000;
 		ret = ad5770r_store_output_range(st, min, max, num);
 		if (ret)
-			return ret;
+			goto err_child_out;
 	}
 
+	return 0;
+
+err_child_out:
+	fwnode_handle_put(child);
 	return ret;
 }
 
-- 
2.31.1

