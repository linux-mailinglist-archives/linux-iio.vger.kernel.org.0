Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3674A41A4D4
	for <lists+linux-iio@lfdr.de>; Tue, 28 Sep 2021 03:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238541AbhI1BlJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Sep 2021 21:41:09 -0400
Received: from mx24.baidu.com ([111.206.215.185]:48068 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238540AbhI1BlH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 Sep 2021 21:41:07 -0400
Received: from BC-Mail-Ex05.internal.baidu.com (unknown [172.31.51.45])
        by Forcepoint Email with ESMTPS id 8821758EDB8C20C5834E;
        Tue, 28 Sep 2021 09:39:27 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex05.internal.baidu.com (172.31.51.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Tue, 28 Sep 2021 09:39:27 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 28 Sep 2021 09:39:26 +0800
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
Subject: [PATCH v2 6/8] iio: dac: mcp4922: Make use of the helper function dev_err_probe()
Date:   Tue, 28 Sep 2021 09:38:59 +0800
Message-ID: <20210928013902.1341-6-caihuoqing@baidu.com>
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
 drivers/iio/dac/mcp4922.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/mcp4922.c b/drivers/iio/dac/mcp4922.c
index c4e430b4050e..0ae414ee1716 100644
--- a/drivers/iio/dac/mcp4922.c
+++ b/drivers/iio/dac/mcp4922.c
@@ -130,10 +130,9 @@ static int mcp4922_probe(struct spi_device *spi)
 	state = iio_priv(indio_dev);
 	state->spi = spi;
 	state->vref_reg = devm_regulator_get(&spi->dev, "vref");
-	if (IS_ERR(state->vref_reg)) {
-		dev_err(&spi->dev, "Vref regulator not specified\n");
-		return PTR_ERR(state->vref_reg);
-	}
+	if (IS_ERR(state->vref_reg))
+		return dev_err_probe(&spi->dev, PTR_ERR(state->vref_reg),
+				     "Vref regulator not specified\n");
 
 	ret = regulator_enable(state->vref_reg);
 	if (ret) {
-- 
2.25.1

