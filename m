Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB465BB866
	for <lists+linux-iio@lfdr.de>; Sat, 17 Sep 2022 15:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiIQNOB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Sep 2022 09:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIQNOA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 17 Sep 2022 09:14:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BE32A70F
        for <linux-iio@vger.kernel.org>; Sat, 17 Sep 2022 06:13:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AC6260BEA
        for <linux-iio@vger.kernel.org>; Sat, 17 Sep 2022 13:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48136C433D6;
        Sat, 17 Sep 2022 13:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663420438;
        bh=K3l9Asin2pwM/S798d6ulKuN4gPq96iVQq0+rSgkHH0=;
        h=From:To:Cc:Subject:Date:From;
        b=U6c9yGRdhzZWev43LoFEnhYBwQ953VCM/tyTaap9Qiz4WJnPu+HYA4SiCHMySZZmm
         JxUo0ZYEWT11bSHdjnqNbUjaIzsTetgCwAY3i7uiREaNhH57RO89wMQmuPl3n0xCfK
         aElLGKc04PEuM6VqVso3Y6H73FDj9qoPFU7b0ZMFXL0HsNgjJGTbz0w30yimusMsPu
         7wL3iNuxUb5PfQYvR0aS27l9UQq2ZAwFQdmqqsi0/Z7YCpmewnWcA1N4WxjBLyYqiP
         l3WCRAw1hIuHtDJYLVuOatt7v+EI1VMGBxJw4IMK+i8eHZOj76jUcMAeJYLA4A1pvG
         k+AQmxpOLzDxw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Alexander Potapenko <glider@google.com>
Subject: [PATCH] iio: accel: bma400: Fix smatch warning based on use of unintialized value.
Date:   Sat, 17 Sep 2022 14:14:01 +0100
Message-Id: <20220917131401.2815486-1-jic23@kernel.org>
X-Mailer: git-send-email 2.37.2
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

Only specific bits in this value are ever used and those are initialized,
but that is complex to reason about in a checker. Hence, initialize
the value to zero and avoid the complexity.

Smatch warning:
drivers/iio/accel/bma400_core.c:1287 bma400_tap_event_en()
error: uninitialized symbol 'field_value'.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jagath Jog J <jagathjog1996@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/bma400_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index eceb1f8d338d..ad8fce3e08cd 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -1184,7 +1184,8 @@ static int bma400_activity_event_en(struct bma400_data *data,
 				    enum iio_event_direction dir,
 				    int state)
 {
-	int ret, reg, msk, value, field_value;
+	int ret, reg, msk, value;
+	int field_value = 0;
 
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
-- 
2.37.2

