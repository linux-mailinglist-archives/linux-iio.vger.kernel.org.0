Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAD941A500
	for <lists+linux-iio@lfdr.de>; Tue, 28 Sep 2021 03:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbhI1B5M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Sep 2021 21:57:12 -0400
Received: from mx24.baidu.com ([111.206.215.185]:34296 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238453AbhI1B5L (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 Sep 2021 21:57:11 -0400
Received: from BC-Mail-Ex09.internal.baidu.com (unknown [172.31.51.49])
        by Forcepoint Email with ESMTPS id D3A34EAE8B5EBB748EA0;
        Tue, 28 Sep 2021 09:39:18 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex09.internal.baidu.com (172.31.51.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Tue, 28 Sep 2021 09:39:18 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 28 Sep 2021 09:39:17 +0800
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
Subject: [PATCH v2 3/8] iio: dac: ltc1660: Make use of the helper function dev_err_probe()
Date:   Tue, 28 Sep 2021 09:38:56 +0800
Message-ID: <20210928013902.1341-3-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210928013902.1341-1-caihuoqing@baidu.com>
References: <20210928013902.1341-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex24.internal.baidu.com (172.31.51.18) To
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
 drivers/iio/dac/ltc1660.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/ltc1660.c b/drivers/iio/dac/ltc1660.c
index dc10188540ca..f6ec9bf5815e 100644
--- a/drivers/iio/dac/ltc1660.c
+++ b/drivers/iio/dac/ltc1660.c
@@ -172,10 +172,9 @@ static int ltc1660_probe(struct spi_device *spi)
 	}
 
 	priv->vref_reg = devm_regulator_get(&spi->dev, "vref");
-	if (IS_ERR(priv->vref_reg)) {
-		dev_err(&spi->dev, "vref regulator not specified\n");
-		return PTR_ERR(priv->vref_reg);
-	}
+	if (IS_ERR(priv->vref_reg))
+		return dev_err_probe(&spi->dev, PTR_ERR(priv->vref_reg),
+				     "vref regulator not specified\n");
 
 	ret = regulator_enable(priv->vref_reg);
 	if (ret) {
-- 
2.25.1

