Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3CE680001
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jan 2023 16:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbjA2Pme (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Jan 2023 10:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbjA2Pme (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jan 2023 10:42:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4774C1CF56;
        Sun, 29 Jan 2023 07:42:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0222B80D14;
        Sun, 29 Jan 2023 15:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B74CC433EF;
        Sun, 29 Jan 2023 15:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675006949;
        bh=z7t1uWckaiUEht/osE1ffup1zeOOHYuYzMqKoLJ3WvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RhJTIQBQk5BT4QJjN0IIDndC+KTTLr1RgphdmqYvbnk7JRXyYWT+RHKQAzAX9Ez+Y
         YKuFgmJXff65XMR36kUY2yHqoWeYz1oZb0KfB3ab6F2zwWwOS4JUHcOAzOiE5/+Wm4
         RRDII+gVLEKbkSoRokEZWzotJ6KMu7VL5AhlnqtY2KbEgCSmKye/wJEZldM+jxxb5n
         ZnjQgs1Mmx7v1EVFrlLvA2PL7LjJ9F2q8Z1Yya0vodbvlPeybFdL66h9yXFrnHh4pA
         46uuN0W/q/n7QWr7Zeg3Lz2oFQ4c5l1ImGDObMRcmtPNfLMwstZYPYcdb1OtQ/i+oL
         hg3KVONaiDDfw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 10/12] staging: iio: accel: adis16203: Trivial style cleanup
Date:   Sun, 29 Jan 2023 15:56:00 +0000
Message-Id: <20230129155602.740743-11-jic23@kernel.org>
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

