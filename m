Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0994AACC5
	for <lists+linux-iio@lfdr.de>; Sat,  5 Feb 2022 22:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbiBEV55 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Feb 2022 16:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiBEV55 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Feb 2022 16:57:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD7DC061348
        for <linux-iio@vger.kernel.org>; Sat,  5 Feb 2022 13:57:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28F7561305
        for <linux-iio@vger.kernel.org>; Sat,  5 Feb 2022 21:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F20C340E8;
        Sat,  5 Feb 2022 21:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644098275;
        bh=BoZlhJqgvEKTFhxS5Np1iJuQ0orTxu1lvL9JuWvqN6Y=;
        h=From:To:Cc:Subject:Date:From;
        b=dWepS4K8i3QRiA1h0oyft/FKd62DcYsBJ5wfGaGsPIOhioVQhGomF+69rlqGzljea
         IuY7foz9XKUsPtHoojRPlpO+lwsYtSE8HWv1v3bA+UFtz63wKrqzKUBXgXMlgGsRte
         P/ClAXf++sSPUVR4ThmCEAyN+SOD8JQ6kO0Urgo9rMpipi5hvmNjh+eCLQj+B+Kzzl
         q0cYkRPkyNwS/SyQeyGbdSZmfrFKu+n1B6lxjcyrmxHvjBZaJWPw2HGGiz9EPM2Vp/
         FUkwHC3aKECZU9hesQZTsuMmgpTxmMMRJp+FtoG3UiUVco/9HfCodNjQRTehynr72V
         s3AtO7CEOPx7Q==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        mario.tesi@st.com
Subject: [PATCH v2] iio: imu: st_lsm6dsx: wait for settling time in st_lsm6dsx_read_oneshot
Date:   Sat,  5 Feb 2022 22:57:42 +0100
Message-Id: <b41ebda5535895298716c76d939f9f165fcd2d13.1644098120.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

We need to wait for sensor settling time (~ 3/ODR) before reading data
in st_lsm6dsx_read_oneshot routine in order to avoid corrupted samples.

Fixes: 290a6ce11d938 ("iio: imu: add support to lsm6dsx driver")
Reported-by: Mario Tesi <mario.tesi@st.com>
Tested-by: Mario Tesi <mario.tesi@st.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- add missing Fixes tag.
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 727b4b6ac696..93f0c6bce502 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1374,8 +1374,12 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
 	if (err < 0)
 		return err;
 
+	/*
+	 * we need to wait for sensor settling time before
+	 * reading data in order to avoid corrupted samples
+	 */
 	delay = 1000000000 / sensor->odr;
-	usleep_range(delay, 2 * delay);
+	usleep_range(3 * delay, 4 * delay);
 
 	err = st_lsm6dsx_read_locked(hw, addr, &data, sizeof(data));
 	if (err < 0)
-- 
2.34.1

