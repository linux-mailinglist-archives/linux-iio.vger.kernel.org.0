Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 878D6120600
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2019 13:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfLPMma (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Dec 2019 07:42:30 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:27173 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbfLPMma (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Dec 2019 07:42:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1576500148;
        s=strato-dkim-0002; d=gerhold.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=XRnplUHx3PfVuyWFk3LOf7VQVkwW+9gBZGyhFoeQddM=;
        b=PAHv1S83DyS5kb7md6S0gvstExdKiCM3aMd000GNVpXkb+W+R8ho005rspZQ2qaWkl
        j/Xw/3rDEiFltMC6opv6r7xOAnbLhiwWb+hy+wnocUNq32i/CQWZI8X7PI48WXheOdoA
        wsxjlo2j5yXfA4U6isOFzsdfrkgLa35Opk0f8dIxE0nOty1LwKOP1h6Wv9ocXNiwDNxg
        8LL4AQ66iUJaPSUt03nbQ37wHm77MjuFCBMByQsYCjvHUjsWqfElwrJoYyuBlkikUXU2
        KAzHTE47WI6wLmhmAWuEeKtoj5ohB6vQVWdMrmUg005BBA+kkOoxchMidankSnmkWo66
        eZiA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXsMv1qxJQXi4="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 46.0.7 AUTH)
        with ESMTPSA id N0b206vBGCgRJrg
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 16 Dec 2019 13:42:27 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v2] iio: imu: st_lsm6dsx: Fix selection of ST_LSM6DS3_ID
Date:   Mon, 16 Dec 2019 13:41:20 +0100
Message-Id: <20191216124120.8789-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

At the moment, attempting to probe a device with ST_LSM6DS3_ID
(e.g. using the st,lsm6ds3 compatible) fails with:

    st_lsm6dsx_i2c 1-006b: unsupported whoami [69]

... even though 0x69 is the whoami listed for ST_LSM6DS3_ID.

This happens because st_lsm6dsx_check_whoami() also attempts
to match unspecified (zero-initialized) entries in the "id" array.
ST_LSM6DS3_ID = 0 will therefore match any entry in
st_lsm6dsx_sensor_settings (here: the first), because none of them
actually have all 12 entries listed in the "id" array.

Avoid this by additionally checking if "name" is set,
which is only set for valid entries in the "id" array.

Note: Although the problem was introduced earlier it did not surface until
commit 52f4b1f19679 ("iio: imu: st_lsm6dsx: add support for accel/gyro unit of lsm9ds1")
because ST_LSM6DS3_ID was the first entry in st_lsm6dsx_sensor_settings.

Fixes: d068e4a0f921 ("iio: imu: st_lsm6dsx: add support to multiple devices with the same settings")
Cc: <stable@vger.kernel.org> # 5.4
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
v1: https://lore.kernel.org/linux-iio/20191209170541.198206-1-stephan@gerhold.net/

Changes in v2:
  - Add Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
  - Add Fixes tag
  - Cc stable@vger.kernel.org
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index a7d40c02ce6b..b921dd9e108f 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1301,7 +1301,8 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id,
 
 	for (i = 0; i < ARRAY_SIZE(st_lsm6dsx_sensor_settings); i++) {
 		for (j = 0; j < ST_LSM6DSX_MAX_ID; j++) {
-			if (id == st_lsm6dsx_sensor_settings[i].id[j].hw_id)
+			if (st_lsm6dsx_sensor_settings[i].id[j].name &&
+			    id == st_lsm6dsx_sensor_settings[i].id[j].hw_id)
 				break;
 		}
 		if (j < ST_LSM6DSX_MAX_ID)
-- 
2.24.1

