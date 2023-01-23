Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AF7678924
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jan 2023 22:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjAWVEo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Jan 2023 16:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjAWVEn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Jan 2023 16:04:43 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0710332503;
        Mon, 23 Jan 2023 13:04:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2F99ACE176D;
        Mon, 23 Jan 2023 21:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A882AC433D2;
        Mon, 23 Jan 2023 21:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674507876;
        bh=xNFqaSt6sAiqcpyDJBbIK/2JCT49tj09BjUpYSsTMco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NWHPzLzKzR/gbiCyBGwy/87ylpO1apM55QPY0eu+GRp/DJlYqJ7l2hy1U1cG16zl2
         +uH3OUf6SLb9ax4qEv1CKTQBlkc6TMJ2c3xPg1xt9RiUNc0SOWj4bk3DPgGUX6R6Fu
         2/T6l+coyDojymRfr83ixk/7sJd3Jsim7mETYrhVk95Kstj/B+1SWYh7ngUJgjiiNr
         NGsWusC3986I4l6pCcsqXmJ1A3RlaUAbM9xbDGr9x5m3ERqdJb7WXUse/qPHcvopRW
         kXkFpVrKjuNN1Hw7dc69QATNKIOUcPp5FNoFdvO7RWdrm1dmyapIz7nvoL+8rS6qLV
         0aAAVKfhhVWBg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Barry Song <baohua@kernel.org>
Subject: [PATCH 07/12] staging: iio: accel: adis16203: Make units explicit in name of delay define
Date:   Mon, 23 Jan 2023 21:17:53 +0000
Message-Id: <20230123211758.563383-8-jic23@kernel.org>
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

