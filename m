Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE356278F6
	for <lists+linux-iio@lfdr.de>; Mon, 14 Nov 2022 10:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbiKNJZz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Nov 2022 04:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbiKNJZz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Nov 2022 04:25:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7A01DDFD
        for <linux-iio@vger.kernel.org>; Mon, 14 Nov 2022 01:25:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46B9660F40
        for <linux-iio@vger.kernel.org>; Mon, 14 Nov 2022 09:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32678C433D6;
        Mon, 14 Nov 2022 09:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668417953;
        bh=c9bJ3yeVmVs7JT3bD4AxnWAT0jJfESnfqR0WDcORKLw=;
        h=From:To:Cc:Subject:Date:From;
        b=Dq2K5+CigQG6D+gIyX6Om/spwlfvpowJPsX3BLmj5uM/i0OMcXtnNU71Yga4bYrO3
         YteB1EWOSZQDUweZqp+PrCcSuswV+kXyuW+D4kj1alx1sRnJ02COLzu7ca/YPE9JAw
         RMxM9Z34t17TfFeSfKQIdWCI1nK2ykwUq6G7gx4fD/vBLViDdbqyzWKiRs3CSs5rlp
         aVRBvEgvzZ1IPRRel0m6VXflEmXxU8tJy56ZXDoDW4JMkru6oPMQOJnI9iPq4QnMyq
         x4jFOFmZge5pN8SYp+ZI/zr44ZU5eXSaOtacbTRcSRTBXj6BfhlvihyZpxyFQOF4lg
         W9soc9WkRdlFQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] iio: imu: st_lsm6dsx: fix LSM6DSV sensor description
Date:   Mon, 14 Nov 2022 10:25:34 +0100
Message-Id: <653e14bf79bb88d8581d2bc42da2f784caaf3776.1668417770.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
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

Fix sensor ODR description for LSM6DSV/LSM6DSVX

Fixes: 111a5f31345d ("iio: imu: st_lsm6dsx: add support to LSM6DSV")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index acb6101aec5d..b680682f9833 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -27,13 +27,20 @@
  *   - FIFO size: 4KB
  *
  * - LSM6DSO/LSM6DSOX/ASM330LHH/ASM330LHHX/LSM6DSR/ISM330DHCX/LSM6DST/LSM6DSOP/
- *   LSM6DSTX/LSM6DSV/LSM6DSV16X:
+ *   LSM6DSTX:
  *   - Accelerometer/Gyroscope supported ODR [Hz]: 12.5, 26, 52, 104, 208, 416,
  *     833
  *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
  *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
  *   - FIFO size: 3KB
  *
+ * - LSM6DSV/LSM6DSV16X:
+ *   - Accelerometer/Gyroscope supported ODR [Hz]: 7.5, 15, 30, 60, 120, 240,
+ *     480, 960
+ *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
+ *   - Gyroscope supported full-scale [dps]: +-125/+-250/+-500/+-1000/+-2000
+ *   - FIFO size: 3KB
+ *
  * - LSM9DS1/LSM6DS0:
  *   - Accelerometer supported ODR [Hz]: 10, 50, 119, 238, 476, 952
  *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
-- 
2.38.1

