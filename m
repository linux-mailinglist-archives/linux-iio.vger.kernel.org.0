Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C90D428C39
	for <lists+linux-iio@lfdr.de>; Mon, 11 Oct 2021 13:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbhJKLmO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Oct 2021 07:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234514AbhJKLmI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Oct 2021 07:42:08 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3809FC061570;
        Mon, 11 Oct 2021 04:40:09 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id s11so10550585pgr.11;
        Mon, 11 Oct 2021 04:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AIdt2gZrcPAgzBGpe0+MmYMwpOue6SUFJqjcWdzp4Xs=;
        b=Z9M10qNcxqFQbNtkVi4lbr0f3chUhD3944rkuM2EacM/gssEceR+RWqeE8YtHZnreo
         AOOduDa4StyoBO2aP61HYghPod3oOKpzX5VeNygY0hqTWVnhpdkm2GPJh/LiOONfFhlH
         T7XUX5A80at0u/KlMmzJ742ECM9I+xXEN22o21lv6l2GPKE07J7qF4461c95NwuEQUJG
         TlGNY0WIuho4Dbq9O5vIva0UnhjzxjYbJIQJIlzAgvb5g6LsCRPu9uc3Nhv+/ayTG9Pw
         7ZXQLD1ZiTk8SatHzkmuwID9WZQHV7YIv01186ko4iX0qOCPiaxTQivllGxU7r1/gt6M
         iU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AIdt2gZrcPAgzBGpe0+MmYMwpOue6SUFJqjcWdzp4Xs=;
        b=dbDVylzBOSIqXnI6eTJxbF+GBcQfHKM6YKhL9BDFlzQ6+gQJCQ4pR1PKyRdrb4rk9u
         XY4heWVItuS6GqojkoAH96qNqwmv6GXYq1pC+TLypA/t5TQIJJIoISROD00uPPR0lg7J
         9BR4wjczUkLqclhw49eBcK5v8aWhP+BZBcxnH6gGo3i9EeS9PuHUVShWh+HrNyq19YDs
         dGFvy3bRIqCfxCxkxU2pBFbiip6/nkFgS7vd5ccsBdF8+FLKIAIxKMn9qnYsfHXfj7lK
         cXrN6OU7yGS7p3vao90iJSEd4Ac9L91YKnN7l9mZXmaKTSUammhA+FYkdSeKF9a0uByr
         nHxw==
X-Gm-Message-State: AOAM5339I33zLOQoy8ITAGpLN+wteQJngYf4Exansp/i/29LM6lmK2BZ
        BvP7Y9Jdm4EtlNmF0/b9sNw=
X-Google-Smtp-Source: ABdhPJxybtQ2r5Zc5YEJ55YHtg1xhml+/ocB7EHnSbOMXtEfP6/CKsKK/SgQ4jr2DdV0xObPlJRlYA==
X-Received: by 2002:a63:d19:: with SMTP id c25mr17457391pgl.393.1633952408594;
        Mon, 11 Oct 2021 04:40:08 -0700 (PDT)
Received: from localhost ([183.173.48.61])
        by smtp.gmail.com with ESMTPSA id x17sm6918815pfa.209.2021.10.11.04.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 04:40:07 -0700 (PDT)
From:   Teng Qi <starmiku1207184332@gmail.com>
To:     lorenzo.bianconi83@gmail.com, jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        islituo@gmail.com, baijiaju1990@gmail.com,
        Teng Qi <starmiku1207184332@gmail.com>,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: [PATCH v2] iio: imu: st_lsm6dsx: Fix an array overflow in st_lsm6dsx_set_odr()
Date:   Mon, 11 Oct 2021 19:40:03 +0800
Message-Id: <20211011114003.976221-1-starmiku1207184332@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The length of hw->settings->odr_table is 2 and ref_sensor->id is an enum
variable whose value is between 0 and 5.
However, the value ST_LSM6DSX_ID_MAX (i.e. 5) is not catched properly in
 switch (sensor->id) {

If ref_sensor->id is ST_LSM6DSX_ID_MAX, an array overflow will ocurrs in
function st_lsm6dsx_check_odr():
  odr_table = &sensor->hw->settings->odr_table[sensor->id];

and in function st_lsm6dsx_set_odr():
  reg = &hw->settings->odr_table[ref_sensor->id].reg;

To fix this array overflow, handle ST_LSM6DSX_ID_GYRO explicitly and 
return -EINVAL for the default case.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Teng Qi <starmiku1207184332@gmail.com>

---
v2:
* explicitly handle ST_LSM6DSX_ID_GYRO and return -EINVAL for the default
case instead of adding an if statement behind the switch statement.
  Thank Lars-Peter Clausen for helpful and friendly advice.

---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index db45f1fc0b81..8dbf744c5651 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1279,6 +1279,8 @@ st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u32 req_odr)
 	int err;
 
 	switch (sensor->id) {
+	case ST_LSM6DSX_ID_GYRO:
+		break;
 	case ST_LSM6DSX_ID_EXT0:
 	case ST_LSM6DSX_ID_EXT1:
 	case ST_LSM6DSX_ID_EXT2:
@@ -1304,8 +1306,8 @@ st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u32 req_odr)
 		}
 		break;
 	}
-	default:
-		break;
+	default: /* should never occur */
+		return -EINVAL;
 	}
 
 	if (req_odr > 0) {
-- 
2.25.1

