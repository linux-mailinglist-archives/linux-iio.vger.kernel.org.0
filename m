Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611A45F23B2
	for <lists+linux-iio@lfdr.de>; Sun,  2 Oct 2022 16:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiJBOxM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Oct 2022 10:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJBOxL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Oct 2022 10:53:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A633E14D3D
        for <linux-iio@vger.kernel.org>; Sun,  2 Oct 2022 07:53:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 451D660D2D
        for <linux-iio@vger.kernel.org>; Sun,  2 Oct 2022 14:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74512C433C1;
        Sun,  2 Oct 2022 14:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664722389;
        bh=GSUp1p8ZNAFF1LoFPlzeclBF3HB5KF8zsMhpYmB1ApM=;
        h=From:To:Cc:Subject:Date:From;
        b=UkM7MM/ZsiHpCTGhOuzm6QdnoqyjCPOpYZGF9XRr/p+02WpNv3lnMitCdgRkIFxiu
         EUQHky5g0AMVUPIrrSoBCx0+7odDox+kcut5HHrRq3fD91VPqcneCD2CEZcqKb4ZLu
         oQORnSjNVdtVXLUZmEro4SQHer9LvrJxtQEsR2pnuCssYq9Puohh6t4f8Af/PMVCj5
         91kx0VGosLAYIy7+4H7WPK+gAJJKPhheI6fpfNysV1CBoAI2sCMFzLzhCE9Y3bsCXc
         Dhk1crPpic5yQtWeg7GB45f0MUeZLcuZLaUsK6+ZT4s9qGM3FBKN6F6JQZD/8y5Orh
         JdTZwYTYiWkkw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [PATCH] iio: imu: bno055: Fix some uninitialized variable usage
Date:   Sun,  2 Oct 2022 15:53:24 +0100
Message-Id: <20221002145324.3776484-1-jic23@kernel.org>
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

Switch the ||'d conditions around to ensure we don't check a value
that hasn't been initialized yet.  Also fix a warning due to lack
of visibility that the initialization path will always run by setting
the array index to 0 at definition.

Fixes: 4aefe1c2bd0c ("iio: imu: add Bosch Sensortec BNO055 core driver")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andrea Merello <andrea.merello@iit.it>
---
 drivers/iio/imu/bno055/bno055.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/bno055/bno055.c b/drivers/iio/imu/bno055/bno055.c
index 307557a609e3..0938082d5cf8 100644
--- a/drivers/iio/imu/bno055/bno055.c
+++ b/drivers/iio/imu/bno055/bno055.c
@@ -581,11 +581,11 @@ static int bno055_set_regmask(struct bno055_priv *priv, int val, int val2,
 {
 	const int shift = __ffs(mask);
 	int best_delta;
+	int hwval = 0;
 	int req_val;
 	int tbl_val;
 	bool first;
 	int delta;
-	int hwval;
 	int ret;
 	int len;
 	int i;
@@ -632,7 +632,7 @@ static int bno055_set_regmask(struct bno055_priv *priv, int val, int val2,
 			return -EINVAL;
 		}
 		delta = abs(tbl_val - req_val);
-		if (delta < best_delta || first) {
+		if (first || delta < best_delta) {
 			best_delta = delta;
 			hwval = i;
 			first = false;
-- 
2.37.2

