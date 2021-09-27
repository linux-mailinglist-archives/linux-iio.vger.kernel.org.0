Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7407C4190B6
	for <lists+linux-iio@lfdr.de>; Mon, 27 Sep 2021 10:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbhI0I17 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Sep 2021 04:27:59 -0400
Received: from mx22.baidu.com ([220.181.50.185]:60562 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233337AbhI0I16 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 Sep 2021 04:27:58 -0400
Received: from BC-Mail-Ex16.internal.baidu.com (unknown [172.31.51.56])
        by Forcepoint Email with ESMTPS id 513225E8B226CE5ED1B8;
        Mon, 27 Sep 2021 16:26:19 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex16.internal.baidu.com (172.31.51.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Mon, 27 Sep 2021 16:26:18 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Mon, 27 Sep 2021 16:26:18 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Vladimir Zapolskiy" <vz@mleia.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 1/8] iio: dac: ad8801: Make use of the helper function dev_err_probe()
Date:   Mon, 27 Sep 2021 16:26:00 +0800
Message-ID: <20210927082608.859-1-caihuoqing@baidu.com>
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
 drivers/iio/dac/ad8801.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/dac/ad8801.c b/drivers/iio/dac/ad8801.c
index 6354b7c8f052..8acb9fee273c 100644
--- a/drivers/iio/dac/ad8801.c
+++ b/drivers/iio/dac/ad8801.c
@@ -123,10 +123,9 @@ static int ad8801_probe(struct spi_device *spi)
 	id = spi_get_device_id(spi);
 
 	state->vrefh_reg = devm_regulator_get(&spi->dev, "vrefh");
-	if (IS_ERR(state->vrefh_reg)) {
-		dev_err(&spi->dev, "Vrefh regulator not specified\n");
-		return PTR_ERR(state->vrefh_reg);
-	}
+	if (IS_ERR(state->vrefh_reg))
+		return dev_err_probe(&spi->dev, PTR_ERR(state->vrefh_reg),
+				     "Vrefh regulator not specified\n");
 
 	ret = regulator_enable(state->vrefh_reg);
 	if (ret) {
@@ -146,15 +145,15 @@ static int ad8801_probe(struct spi_device *spi)
 	if (id->driver_data == ID_AD8803) {
 		state->vrefl_reg = devm_regulator_get(&spi->dev, "vrefl");
 		if (IS_ERR(state->vrefl_reg)) {
-			dev_err(&spi->dev, "Vrefl regulator not specified\n");
-			ret = PTR_ERR(state->vrefl_reg);
+			ret = dev_err_probe(&spi->dev, PTR_ERR(state->vrefl_reg),
+					    "Vrefl regulator not specified\n");
 			goto error_disable_vrefh_reg;
 		}
 
 		ret = regulator_enable(state->vrefl_reg);
 		if (ret) {
-			dev_err(&spi->dev, "Failed to enable vrefl regulator: %d\n",
-					ret);
+			dev_err(&spi->dev,
+				"Failed to enable vrefl regulator: %d\n", ret);
 			goto error_disable_vrefh_reg;
 		}
 
-- 
2.25.1

