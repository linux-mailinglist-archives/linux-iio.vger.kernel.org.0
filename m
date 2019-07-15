Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36FF0684FF
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2019 10:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbfGOIPZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Jul 2019 04:15:25 -0400
Received: from first.geanix.com ([116.203.34.67]:55292 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728933AbfGOIPY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Jul 2019 04:15:24 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 8D3D443615;
        Mon, 15 Jul 2019 08:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1563178500; bh=lRGBuiqP2hQgfR+6pX7mgEXMqw7g/yBjKUjEe4Ex3bA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=PZLQJ8Sw6rn3rFD8q0NZnq4l320o/i9jXYQCmv/ft50B7bEb7U01dq8WwOhf15epb
         4KFBftL+M+PcVB7Avz2uG/2e0chv0G3Dg/ov/bC3SsEAXW3tu0sytrVMTsSZTf+ZOt
         od4YbAE0VHpfVMIDjD71n3QFAF5mHhoHrM6uAWUCV3SId+dcbIi0pwFtMpxZH/+KoO
         vTxqyBAcJSjJedgVEDnY8bOsME41XACShbht/H+R0K86p77TDzlIy116fE2pJVztPZ
         ObCiY3o7Ep1Ra9rLi0e/QsJRBzWTDRp4U6Ev8NmILyG6PW25lekDPLCLcPcT15F9ZT
         uQzdCja28kuBg==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, lorenzo.bianconi83@gmail.com,
        martin@geanix.com
Subject: [PATCH v2 2/6] iio: imu: st_lsm6dsx: save drdy_pin in device struct
Date:   Mon, 15 Jul 2019 10:15:10 +0200
Message-Id: <20190715081514.81129-2-sean@geanix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190715081514.81129-1-sean@geanix.com>
References: <20190715081514.81129-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 8945dcc0271d
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This prepares the use of the drdy_pin for selecting the correct
event interrupt register.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---

Changes since v1:
 * new commit

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      | 1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index af379a5429ed..738bed4a9752 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -297,6 +297,7 @@ struct st_lsm6dsx_hw {
 	u8 enable_mask;
 	u8 ts_sip;
 	u8 sip;
+	int drdy_pin;
 
 	u8 *buff;
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index e67341802fc6..2c11addf568b 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -871,17 +871,17 @@ static int st_lsm6dsx_of_get_drdy_pin(struct st_lsm6dsx_hw *hw, int *drdy_pin)
 
 static int st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw, u8 *drdy_reg)
 {
-	int err = 0, drdy_pin;
+	int err = 0;
 
-	if (st_lsm6dsx_of_get_drdy_pin(hw, &drdy_pin) < 0) {
+	if (st_lsm6dsx_of_get_drdy_pin(hw, &hw->drdy_pin) < 0) {
 		struct st_sensors_platform_data *pdata;
 		struct device *dev = hw->dev;
 
 		pdata = (struct st_sensors_platform_data *)dev->platform_data;
-		drdy_pin = pdata ? pdata->drdy_int_pin : 1;
+		hw->drdy_pin = pdata ? pdata->drdy_int_pin : 1;
 	}
 
-	switch (drdy_pin) {
+	switch (hw->drdy_pin) {
 	case 1:
 		*drdy_reg = ST_LSM6DSX_REG_INT1_ADDR;
 		break;
-- 
2.22.0

