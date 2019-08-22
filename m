Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2D1994DA
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2019 15:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbfHVNW1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Aug 2019 09:22:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52092 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfHVNW1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Aug 2019 09:22:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id k1so5635813wmi.1;
        Thu, 22 Aug 2019 06:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Luuk1pqGXQ3LTo0vTwCyDXOtvHqT8koKOsr4J0FT5Fs=;
        b=cD1pIDQETzko/f5Dq3TBV46ArVdMkx9fsJBv6BXBingcwaRSFNXnGIa8sGgYJR0US6
         jGK1WFjr0g2Xkmv6iPon63GEdtS2s7Rd5ZPmBMSlWD4AUEVQMX/nxFX9ky1Qfr/JND1n
         x19Lswx2JOx1uuMT16uCrE7/VZg14WFD7+rjsm+GU8lHFWHdi3zSlKrQcObSMy49HNLh
         w5Do6UeAdJrfhBV/TslD48lJgDLkdQdNTRvh5tt3DJV/szK2BK776ZRYV5Nk7BvSLLTd
         mzcLDTY/ZW85+qvd/JE2HSX7VDnJYezPv6j8d7EcXaThXljTrQiKU3Yov9SV1AL0Hk7Q
         PfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Luuk1pqGXQ3LTo0vTwCyDXOtvHqT8koKOsr4J0FT5Fs=;
        b=XSJF/cosu51SQ11D3u/dbRabnrPnDXAHFKjzrPxtyj9kdt9KMW4i4qRiuqf5HBErqB
         4SRvsLSymC/rzd7AWDoREBCNGbIeHQ90KhhD9nquS+U945icfoguK3NJVzKhF4iai2AF
         CY9geDAkvUCvgGSEfKfKAm/hE/3G2+2zm/6j+FDRmLI9bGNmIPTx7smkKfmSCB+3y6wF
         PnSibHvm/RYAzOM7w9b02v4xo7uyrVnJPIEuZu843gg8F3El2fsZVVCCkjQPzIwkfFc7
         Hupu2/woeRIOxtKCHt9Fmfsa3Eigi7cZkkguNIZP+yS3j+WZG9wEGnorLFX3WoIf4zUj
         gmSw==
X-Gm-Message-State: APjAAAXW3LVu+tm511L4C9ZjG1RnG4V6i8SoW4siF8/xRBW+K0ulKTQT
        A04dZ3HiW3AxGi44S/HFWtY=
X-Google-Smtp-Source: APXvYqy3qNIEb+nlLulGT8/JnUEPqj/ydST6mPALa9wu2JHUvW5JsZt5uCa0vLVoqueqMEcfGp0EdA==
X-Received: by 2002:a05:600c:204:: with SMTP id 4mr6699377wmi.167.1566480144544;
        Thu, 22 Aug 2019 06:22:24 -0700 (PDT)
Received: from ctocxl0004.cto.st.com ([37.160.86.50])
        by smtp.gmail.com with ESMTPSA id j15sm22235083wrn.70.2019.08.22.06.22.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Aug 2019 06:22:23 -0700 (PDT)
From:   Mario Tesi <martepisa@gmail.com>
To:     lorenzo.bianconi83@gmail.com
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, mario.tesi@st.com
Subject: [PATCH] iio: imu: st_lsm6dsx: Fix FIFO diff mask for tagged fifo
Date:   Thu, 22 Aug 2019 15:22:19 +0200
Message-Id: <1566480139-4015-1-git-send-email-martepisa@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: mario tesi <mario.tesi@st.com>

	According to the latest version of datasheet the mask
	for number of unread sensor data in FIFO_STATUS registers
	has been extended to 10 bits

	The devices involved are:
	 - LSM6DSO
	 - LSM6DSOX
	 - ASM330LHH
	 - LSM6DSR
	 - ISM330DHCX

Signed-off-by: mario tesi <mario.tesi@st.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 85824d6..47b77d0 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -497,7 +497,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 			},
 			.fifo_diff = {
 				.addr = 0x3a,
-				.mask = GENMASK(8, 0),
+				.mask = GENMASK(9, 0),
 			},
 			.th_wl = 1,
 		},
@@ -623,7 +623,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 			},
 			.fifo_diff = {
 				.addr = 0x3a,
-				.mask = GENMASK(8, 0),
+				.mask = GENMASK(9, 0),
 			},
 			.th_wl = 1,
 		},
@@ -726,7 +726,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 			},
 			.fifo_diff = {
 				.addr = 0x3a,
-				.mask = GENMASK(8, 0),
+				.mask = GENMASK(9, 0),
 			},
 			.th_wl = 1,
 		},
-- 
2.7.4

