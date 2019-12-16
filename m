Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A99851202FF
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2019 11:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfLPKyN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Dec 2019 05:54:13 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:57312 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727436AbfLPKyN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Dec 2019 05:54:13 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9983F45A05133E74F235;
        Mon, 16 Dec 2019 18:54:10 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Mon, 16 Dec 2019 18:53:59 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH] iio: light: remove unneeded semicolon
Date:   Mon, 16 Dec 2019 18:51:01 +0800
Message-ID: <20191216105101.7200-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes coccicheck warning:

./drivers/iio/light/lm3533-als.c:745:2-3: Unneeded semicolon

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/iio/light/lm3533-als.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index 6733b52..bc196c2 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -742,7 +742,7 @@ static int lm3533_als_set_resistor(struct lm3533_als *als, u8 val)
 	if (val < LM3533_ALS_RESISTOR_MIN || val > LM3533_ALS_RESISTOR_MAX) {
 		dev_err(&als->pdev->dev, "invalid resistor value\n");
 		return -EINVAL;
-	};
+	}
 
 	ret = lm3533_write(als->lm3533, LM3533_REG_ALS_RESISTOR_SELECT, val);
 	if (ret) {
-- 
2.7.4

