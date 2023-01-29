Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB07067FFFD
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jan 2023 16:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbjA2Pmc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Jan 2023 10:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbjA2Pmb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jan 2023 10:42:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B101E5E1;
        Sun, 29 Jan 2023 07:42:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7640F60C7B;
        Sun, 29 Jan 2023 15:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B113C4339B;
        Sun, 29 Jan 2023 15:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675006947;
        bh=B+qp4Bg0ckQ1EeHpNrnKDGWpfd3LdqaTfOttRJJrPgs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gw2cpz8cUznyUiTq/isJhbZVtjY6KQzmLO9Wh84cVX6BJFppxCQT4PgPLRnwxsPdm
         OirxL9UBYIkBhA2aOwOj5Hkc54jV84+15CbjqRFDepZZQbLqM+Y5WkZ2QNyNoxbsK+
         o/JRQPFxKD44/01a6ASuVlrMI7Ak0dBqNzmzg3EKg03QtW8c3xy9aiIrfJ+QiBy831
         VczPM08lCR72WYWYGzT5fscJr7kYI3sM2pzpJ4aImqLlGfg9miR1IQmobjysWtmjuP
         6ZhIp5jmBAWstvPCU85yzFDvS5A7ulaezApa2un3cVbflPJZU5ogAPzi75DPQm6CJ9
         SFj02B9o7J3BA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 09/12] staging: iio: accel: adis16203: Drop setting drvdata as nothing gets it
Date:   Sun, 29 Jan 2023 15:55:59 +0000
Message-Id: <20230129155602.740743-10-jic23@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230129155602.740743-1-jic23@kernel.org>
References: <20230129155602.740743-1-jic23@kernel.org>
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

As commented, it is only useful for .remove() which doesn't exist, so
drop setting it and the comment.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/accel/adis16203.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index 20e9c9eb9436..9915b73454d2 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -187,8 +187,6 @@ static int adis16203_probe(struct spi_device *spi)
 	if (!indio_dev)
 		return -ENOMEM;
 	st = iio_priv(indio_dev);
-	/* this is only used for removal purposes */
-	spi_set_drvdata(spi, indio_dev);
 
 	indio_dev->name = "adis16203";
 	indio_dev->channels = adis16203_channels;
-- 
2.39.1

