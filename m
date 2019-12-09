Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8FE11726E
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2019 18:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfLIRG7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Dec 2019 12:06:59 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:11812 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfLIRG7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Dec 2019 12:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1575911213;
        s=strato-dkim-0002; d=gerhold.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=JdkRoHb8ohXQr2AuBM9cBMAwARTg6r0YWd5KTgyUZW0=;
        b=gzOpMqKBO3Sqx8L37AlneH3xyB9O+4NfH6T0VCDvz7CFNouiMt+/EgLYwgSP4jPs1a
        NMjtJRGcYSmneywjGyJUbB5UEnMmj44RfcyWBwG3+XGWaHVNL1mlt9PEb80hPtCWOYo+
        EqyUr2cBE6rz0Kr5D09bgyYAsYnz3qXuCbMd7/k/IGXTAJQRiMt+wm1k0sw5xVKRzxyE
        vlu2+2FEXfcC4Glthlc1AlMmcGlpScJIxIJeiva0g+zIdg49jpGBvElfuzvm/rTc3ZAx
        t7jA9/Rd9d8AIet3M69MnhOThh96eVfss1cBUz9XcO+Saw9gjwZFqaCQrEvvzn8CODPE
        OIxA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQr4OGUPX+1JiWAnI+L0="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 46.0.2 DYNA|AUTH)
        with ESMTPSA id R01a59vB9H6rb2E
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 9 Dec 2019 18:06:53 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH] iio: imu: st_lsm6dsx: Fix selection of ST_LSM6DS3_ID
Date:   Mon,  9 Dec 2019 18:05:41 +0100
Message-Id: <20191209170541.198206-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.24.0
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

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
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
2.24.0

