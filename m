Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFBC67891F
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jan 2023 22:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbjAWVEj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Jan 2023 16:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbjAWVEj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Jan 2023 16:04:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46FD24488;
        Mon, 23 Jan 2023 13:04:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B2CBB80E96;
        Mon, 23 Jan 2023 21:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F75C4339B;
        Mon, 23 Jan 2023 21:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674507874;
        bh=KwirpNA3y6XauK8S7usKhZVnThfvTfYC6YOhW8SKf60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i+jA0BYYFZyKNfUtq94ha6fduVxGqGl/I1w6itk0X7B08PdSksSRtoPam8SE5jn4u
         N5dts7UHIbfBG/+M7etiq6Z0T7EDjFKHavpywCfyIf0rIzuf3ClGNNb3y1viNFOeZK
         0eNcyyYPK+2GBrBMjkpkkXJe1SrYeEtY1MJwZhClmTGwpflFhy1f4yquUp09wyysHT
         DXpdowIrC+LMZ/tmXqL/jgiar248NYgEo1SKUscudELYC2xPYNO20fOeoyrTfXNckD
         q1w/NUkeuFlizh4skjX9RWjqfhY9L8DdwOtHhExnNJDxPp3ZtMaSD+SbFsAeQIti7x
         YQQTQxfQhu9RA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Barry Song <baohua@kernel.org>
Subject: [PATCH 06/12] staging: iio: accel: adis16203: Drop driver name define
Date:   Mon, 23 Jan 2023 21:17:52 +0000
Message-Id: <20230123211758.563383-7-jic23@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230123211758.563383-1-jic23@kernel.org>
References: <20230123211758.563383-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

