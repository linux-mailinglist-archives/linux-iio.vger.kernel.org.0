Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C611191C4D
	for <lists+linux-iio@lfdr.de>; Tue, 24 Mar 2020 22:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgCXVxR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Mar 2020 17:53:17 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33335 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgCXVxQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Mar 2020 17:53:16 -0400
Received: by mail-lj1-f193.google.com with SMTP id f20so377983ljm.0
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2020 14:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wT7vqB2rHq9rXRi8h+2k9fjLv3AY5oUmdOrmhTRuE3g=;
        b=pgmDGdW1vc8nTQDUakKrEO8Z+xwxhXyShL4Xd+u32yWz31pR8PZ5bM4uUpxC8SwCCt
         vP3S5ZKAAVucgteAVY7c11c8vTORg89yTbkAO/1UicSko8aMJwu6WY+3mMzYkPQ5z9g1
         EkJAvkdR/Zq9VRc/Gnl/40MAkIWOzPVwQ27Xvcmk0uRh2bi6QSMpRrOz3m57GD3xxC/x
         ciCrQwdxH+K0Df1k/ew703/Tn1ZgLIxDGGk/sp72WvOm20j6coUdokPQ3getP15O8Zu0
         tHQxF2y3+g8dgWArVsf0Qx4iF0tHKbAQuY8o1T0CoTOHDdCvUcxRHX3gWj95gS/EcX0V
         ZyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wT7vqB2rHq9rXRi8h+2k9fjLv3AY5oUmdOrmhTRuE3g=;
        b=CF+BhDgjwBKyK+Eck3NVVS3D8norRTOg/hfJ5/rKn8FKj2NZLFPfILh9LrOMPWzb7V
         AuX+Op9CmZPOTeMugQBb71R5mcPnP5YOw4+yRVPcsNT0IpkJ/zrjI4uQmkLd085UNAtE
         3HjnlfERkXINl1Q1xDin76+bLYqBQXqGUSNhenSEex9qU0iy0pRLqldcKzed5xQ14BcS
         SqXeUBI/m5fKUuO25QNmAtfWXQ99spAsavi8r33+ZilwDceJf5Q6yqIRsptpIRVgb47/
         EK0s0nGJidTZgjFmZlqDc0RisQVDI+auTF/ksdMjtxMK6mimnVHn23eFhxzfo74H/o2e
         wuQg==
X-Gm-Message-State: ANhLgQ2iFg1M8NBwbTwOOgIinh3paSr040OT/cDUQucnXtVXVGZd63sr
        AHurx71PIINJ9WeXvD3oBmmwtFzj
X-Google-Smtp-Source: ADFU+vt4Vyz8aNFwXTSArzviWTXAI+4nuBT0dxNI645G7s1pNDEvVqmaVTREeWJvMRIpnrgpmR1ovQ==
X-Received: by 2002:a2e:a312:: with SMTP id l18mr18586562lje.229.1585086793640;
        Tue, 24 Mar 2020 14:53:13 -0700 (PDT)
Received: from localhost.localdomain (h-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id b3sm10556518ljj.46.2020.03.24.14.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 14:53:13 -0700 (PDT)
From:   Jimmy Assarsson <jimmyassarsson@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH 1/2] iio: imu: st_lsm6dsx: Increase ODR_LIST_SIZE
Date:   Tue, 24 Mar 2020 22:52:25 +0100
Message-Id: <20200324215226.1711659-1-jimmyassarsson@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Support for sensor with up to 8 different ODR settings.
Required for supporting LIS3MDL as sensor hub slave device.

Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index f2113a63721a..38b613072da2 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -111,7 +111,7 @@ struct st_lsm6dsx_odr {
 	u8 val;
 };
 
-#define ST_LSM6DSX_ODR_LIST_SIZE	6
+#define ST_LSM6DSX_ODR_LIST_SIZE	8
 struct st_lsm6dsx_odr_table_entry {
 	struct st_lsm6dsx_reg reg;
 
-- 
2.25.0

