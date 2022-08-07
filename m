Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C1558BC76
	for <lists+linux-iio@lfdr.de>; Sun,  7 Aug 2022 20:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiHGSfW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 14:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbiHGSfW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 14:35:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C742DC4
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 11:35:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBE5BB80DC2
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 18:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2A3C433C1;
        Sun,  7 Aug 2022 18:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659897318;
        bh=+Bh/Vd1SEHeVT1RSvZZR6ZWWzPWV/oYlpwL2NIyiOW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fcZo+GTm4CNQCEI9+tTv0NHmkNXan6oU/gcvjHd0yc5sIw4CWDNdwWAK3rBulQIq6
         vdRi5fF+ckqBX+Cu4vOz0NMk8tzG3tv+hEg9BZYpN9qgZ5ZHArsdWpMI8H1XhTyh/8
         he4bLb5eABMvyJAqA7CEU1C30P/x9dLYELBqbuRV91B07b5NWL6e4kXMO8O8vU/WvY
         y1wrLXHsflbY8ym11zTD+s/rt2GntwYn0BdiYhxAxF/Z6mWr5u/eo8mSX5Kfi7ybGD
         83GxouJkVtMo55P75H8oPFh7pzvRocqDnnEzZMe0njjNK1qxP8AsToMuZ6fYdXsCgV
         y59ydgtltZwbg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/2] iio: magn: hmc5843: Drop excessive indentation of assignments of hmc5843_driver
Date:   Sun,  7 Aug 2022 19:45:33 +0100
Message-Id: <20220807184534.1037363-2-jic23@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220807184534.1037363-1-jic23@kernel.org>
References: <20220807184534.1037363-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This formatting is odd, so fix it to be more standard.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/magnetometer/hmc5843_spi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/magnetometer/hmc5843_spi.c b/drivers/iio/magnetometer/hmc5843_spi.c
index 8403f09aba39..310027a53342 100644
--- a/drivers/iio/magnetometer/hmc5843_spi.c
+++ b/drivers/iio/magnetometer/hmc5843_spi.c
@@ -86,13 +86,13 @@ static const struct spi_device_id hmc5843_id[] = {
 MODULE_DEVICE_TABLE(spi, hmc5843_id);
 
 static struct spi_driver hmc5843_driver = {
-		.driver = {
-				.name = "hmc5843",
-				.pm = HMC5843_PM_OPS,
-		},
-		.id_table = hmc5843_id,
-		.probe = hmc5843_spi_probe,
-		.remove = hmc5843_spi_remove,
+	.driver = {
+		.name = "hmc5843",
+		.pm = HMC5843_PM_OPS,
+	},
+	.id_table = hmc5843_id,
+	.probe = hmc5843_spi_probe,
+	.remove = hmc5843_spi_remove,
 };
 
 module_spi_driver(hmc5843_driver);
-- 
2.37.1

