Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0824190E6
	for <lists+linux-iio@lfdr.de>; Mon, 27 Sep 2021 10:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbhI0Ieh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Sep 2021 04:34:37 -0400
Received: from mx24.baidu.com ([111.206.215.185]:39768 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233529AbhI0Ie3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 Sep 2021 04:34:29 -0400
Received: from BJHW-MAIL-EX04.internal.baidu.com (unknown [10.127.64.14])
        by Forcepoint Email with ESMTPS id 70576373237A66F66292;
        Mon, 27 Sep 2021 16:32:50 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-MAIL-EX04.internal.baidu.com (10.127.64.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Mon, 27 Sep 2021 16:32:50 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Mon, 27 Sep 2021 16:32:49 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Kevin Tsai <ktsai@capellamicro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] iio: light: cm36651: Make use of the helper function dev_err_probe()
Date:   Mon, 27 Sep 2021 16:32:36 +0800
Message-ID: <20210927083238.949-2-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210927083238.949-1-caihuoqing@baidu.com>
References: <20210927083238.949-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex01.internal.baidu.com (10.127.64.11) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When possible use dev_err_probe help to properly deal with the
PROBE_DEFER error, the benefit is that DEFER issue will be logged
in the devices_deferred debugfs file.
Using dev_err_probe() can reduce code size, and the error value
gets printed.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/iio/light/cm36651.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/cm36651.c b/drivers/iio/light/cm36651.c
index fd83a19929bc..c7cc4b0fe8b2 100644
--- a/drivers/iio/light/cm36651.c
+++ b/drivers/iio/light/cm36651.c
@@ -632,10 +632,10 @@ static int cm36651_probe(struct i2c_client *client,
 	cm36651 = iio_priv(indio_dev);
 
 	cm36651->vled_reg = devm_regulator_get(&client->dev, "vled");
-	if (IS_ERR(cm36651->vled_reg)) {
-		dev_err(&client->dev, "get regulator vled failed\n");
-		return PTR_ERR(cm36651->vled_reg);
-	}
+	if (IS_ERR(cm36651->vled_reg))
+		return dev_err_probe(&client->dev,
+				     PTR_ERR(cm36651->vled_reg),
+				     "get regulator vled failed\n");
 
 	ret = regulator_enable(cm36651->vled_reg);
 	if (ret) {
-- 
2.25.1

