Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671444190F6
	for <lists+linux-iio@lfdr.de>; Mon, 27 Sep 2021 10:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbhI0Ii2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Sep 2021 04:38:28 -0400
Received: from mx24.baidu.com ([111.206.215.185]:43738 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233403AbhI0Ii2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 Sep 2021 04:38:28 -0400
Received: from BC-Mail-Ex24.internal.baidu.com (unknown [172.31.51.18])
        by Forcepoint Email with ESMTPS id 1E980297C0D2E23D124C;
        Mon, 27 Sep 2021 16:36:49 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex24.internal.baidu.com (172.31.51.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Mon, 27 Sep 2021 16:36:48 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Mon, 27 Sep 2021 16:36:48 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] iio: health: afe4403: Make use of the helper function dev_err_probe()
Date:   Mon, 27 Sep 2021 16:36:37 +0800
Message-ID: <20210927083639.1020-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex15.internal.baidu.com (172.31.51.55) To
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
 drivers/iio/health/afe4403.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index d4921385aaf7..3a8cfb669b25 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -487,10 +487,11 @@ static int afe4403_probe(struct spi_device *spi)
 	}
 
 	afe->regulator = devm_regulator_get(afe->dev, "tx_sup");
-	if (IS_ERR(afe->regulator)) {
-		dev_err(afe->dev, "Unable to get regulator\n");
-		return PTR_ERR(afe->regulator);
-	}
+	if (IS_ERR(afe->regulator))
+		return dev_err_probe(afe->dev,
+				     PTR_ERR(afe->regulator),
+				     "Unable to get regulator\n");
+
 	ret = regulator_enable(afe->regulator);
 	if (ret) {
 		dev_err(afe->dev, "Unable to enable regulator\n");
-- 
2.25.1

