Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022E267FFF8
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jan 2023 16:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbjA2Pm3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Jan 2023 10:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbjA2Pm2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jan 2023 10:42:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279951F90F;
        Sun, 29 Jan 2023 07:42:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2670B80D1B;
        Sun, 29 Jan 2023 15:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14848C4339B;
        Sun, 29 Jan 2023 15:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675006942;
        bh=KwirpNA3y6XauK8S7usKhZVnThfvTfYC6YOhW8SKf60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ExrtN2zHBoKnCWubvkA/Eo/ZqvhyxJz9u21FCCWFrTsUUtZZ2OlnTmtYgtDPZCPtZ
         ZBbFF/3slKU0Kp+LMERDd7mf8e/4dkx/nHBwaTucjYWJ+iY+YQvu6CiGfJ8Nlsa/RQ
         0/Z4jiM6EjLhMtMLQN9r4aq9wDB/ouOEIZ3hv2Ju+SkZ/RgKf/+OlDWqdaG4NEJsFj
         fceMbjgsLFy/n+tFO6AJ+sLdYZlzHb6ntnY3t82rHP41w+0cC4cCwXCu306kX5z067
         ZXHptaYKiurISLGVOqWPm2oR3ZRCFfa0GJPC/9J2vgyZuTePvRlEcr19NI9e+HWv10
         787Iv3cN0N8pw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 06/12] staging: iio: accel: adis16203: Drop driver name define
Date:   Sun, 29 Jan 2023 15:55:56 +0000
Message-Id: <20230129155602.740743-7-jic23@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230129155602.740743-1-jic23@kernel.org>
References: <20230129155602.740743-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These defines just make it harder to see what strings are set
for which driver structure fields. Much better to just have the
string inline.  In this case it wasn't even used.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/accel/adis16203.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index 67c0340d7097..25342717539b 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -67,8 +67,6 @@ enum adis16203_scan {
 	 ADIS16203_SCAN_TEMP,
 };
 
-#define DRIVER_NAME		"adis16203"
-
 static int adis16203_write_raw(struct iio_dev *indio_dev,
 			       struct iio_chan_spec const *chan,
 			       int val,
@@ -196,7 +194,7 @@ static int adis16203_probe(struct spi_device *spi)
 	/* this is only used for removal purposes */
 	spi_set_drvdata(spi, indio_dev);
 
-	indio_dev->name = spi->dev.driver->name;
+	indio_dev->name = "adis16203";
 	indio_dev->channels = adis16203_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adis16203_channels);
 	indio_dev->info = &adis16203_info;
-- 
2.39.1

