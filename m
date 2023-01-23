Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985E0678927
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jan 2023 22:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjAWVEu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Jan 2023 16:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbjAWVEt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Jan 2023 16:04:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED2738665;
        Mon, 23 Jan 2023 13:04:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEC8D61093;
        Mon, 23 Jan 2023 21:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37D1C433EF;
        Mon, 23 Jan 2023 21:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674507882;
        bh=z7t1uWckaiUEht/osE1ffup1zeOOHYuYzMqKoLJ3WvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=igQHficwaZPNJyhi1nqIPK2ZdLCTTia+x99Up4FhgRftc3Q2e0cRLxrgOJb4yrWSB
         hrBxNcHTUeL5+GICkjXoz/HkbZzsaH0MqNxChaA5acAM2o1H2Jx2NlKtOyww1XkSnR
         TfGzD5x+qXa825FCNW+87aB08G+8VLQSuYgvDXy2N/JSt5W12DU9cpUeYIVbV0lMmf
         UoAbDqL6lAQ78Mv2TVOZooFUuCmUyGXfkjX73fboGo7yBJuN9WZomDVrAfG38UaWsY
         o9WgutoAj3DSLm9PClCjJXYomdbNkA4CPHKt8tbeMYqYH0XXtJIBfPNaKKljKW+Mxp
         EMR67wNwLpzjQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Barry Song <baohua@kernel.org>
Subject: [PATCH 10/12] staging: iio: accel: adis16203: Trivial style cleanup
Date:   Mon, 23 Jan 2023 21:17:56 +0000
Message-Id: <20230123211758.563383-11-jic23@kernel.org>
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

Drop a training comma after a null terminator and a comment
that says nothing beyond the obvious.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/accel/adis16203.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index 9915b73454d2..1aaf9815aa66 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -182,7 +182,6 @@ static int adis16203_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	struct adis *st;
 
-	/* setup the industrialio driver allocated elements */
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -212,7 +211,7 @@ static int adis16203_probe(struct spi_device *spi)
 
 static const struct of_device_id adis16203_of_match[] = {
 	{ .compatible = "adi,adis16203" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, adis16203_of_match);
 
-- 
2.39.1

