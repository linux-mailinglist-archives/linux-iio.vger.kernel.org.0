Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D15167FFFA
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jan 2023 16:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjA2Pma (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Jan 2023 10:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbjA2Pm3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jan 2023 10:42:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F329B1CACC;
        Sun, 29 Jan 2023 07:42:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94D12B80C98;
        Sun, 29 Jan 2023 15:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D3FC433A8;
        Sun, 29 Jan 2023 15:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675006944;
        bh=xNFqaSt6sAiqcpyDJBbIK/2JCT49tj09BjUpYSsTMco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B9VyOX4E+PCVSoEm6qiHGvlbtWJvNw0Cd36RVFez4SH7PDpTx3QJdZZMXq/lQLY/g
         vI3ZZn0PfYahsYmMjS+PNG3+mMIMTtA6uosaUUXl3p91j7xSMSxmTL8uyh5FmIQnFv
         ++6Xhi8M+B37zbh3RZ8qrViJAovnt8b9kDJ6FTTBHsrGpaQijhShZM8AkPE++DQsvp
         Sqm4Dl8Qqds47irMeMamodBGtkjYg8OHMjd7JlGntgB9Z3x5iTkY6PXPzzcsq3g6I8
         BgSXHHI0CKjTXHz5B+iWaMNbCeiGJN4iAqOiVoLArqtD1Cihu5SKe9XCWhOFToiR2/
         pqlW6d4Uymlxw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 07/12] staging: iio: accel: adis16203: Make units explicit in name of delay define
Date:   Sun, 29 Jan 2023 15:55:57 +0000
Message-Id: <20230129155602.740743-8-jic23@kernel.org>
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

A postfix of _MS avoids the need for a comment that might bit rot.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/accel/adis16203.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index 25342717539b..271e560c41c0 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -14,7 +14,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/imu/adis.h>
 
-#define ADIS16203_STARTUP_DELAY 220 /* ms */
+#define ADIS16203_STARTUP_DELAY_MS		220
 
 #define ADIS16203_FLASH_CNT      0x00
 #define ADIS16203_SUPPLY_OUT     0x02
@@ -156,9 +156,9 @@ static const char * const adis16203_status_error_msgs[] = {
 };
 
 static const struct adis_timeout adis16203_timeouts = {
-	.reset_ms = ADIS16203_STARTUP_DELAY,
-	.sw_reset_ms = ADIS16203_STARTUP_DELAY,
-	.self_test_ms = ADIS16203_STARTUP_DELAY
+	.reset_ms = ADIS16203_STARTUP_DELAY_MS,
+	.sw_reset_ms = ADIS16203_STARTUP_DELAY_MS,
+	.self_test_ms = ADIS16203_STARTUP_DELAY_MS
 };
 
 static const struct adis_data adis16203_data = {
-- 
2.39.1

