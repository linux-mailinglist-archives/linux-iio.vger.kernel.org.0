Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A28343644
	for <lists+linux-iio@lfdr.de>; Mon, 22 Mar 2021 02:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCVBbj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Mar 2021 21:31:39 -0400
Received: from m12-14.163.com ([220.181.12.14]:59512 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229913AbhCVBbX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Mar 2021 21:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=3/VJ4sNGDzf4DLrB8f
        qNdjOsaTeB8qfyqUT3GkZzx50=; b=lEv09D2OFwRNvuk9BOWR+wZ5AzE35gF1Gx
        QQ1uxX5Bo442Asa+Nb2DtJqqiFB622hPGSgD5LZuvG+cNiC5WedDdu2IRqBL5odi
        DGwzYqgFLh8D7qw1DA+C9U0f44+8s3DHoj4UPCtup8yoHD3u/dMpnam862OEAwKA
        SxajZsbG0=
Received: from COOL-20200923LL.ccdomain.com (unknown [218.94.48.178])
        by smtp10 (Coremail) with SMTP id DsCowAD33Ck481dgNIlbqg--.14537S2;
        Mon, 22 Mar 2021 09:30:38 +0800 (CST)
From:   Guoqing chi <chi962464zy@163.com>
To:     jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, chiguoqing@yulong.com,
        rdunlap@infradead.org, linux-iio@vger.kernel.org,
        chi962464zy@163.com
Subject: [PATCH V4] iio:imu:mpu6050: Modify matricies to matrices
Date:   Mon, 22 Mar 2021 09:30:24 +0800
Message-Id: <20210322013024.1849-1-chi962464zy@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DsCowAD33Ck481dgNIlbqg--.14537S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFy7tw4ruw4fWFy3XFW5Jrb_yoWkZFb_Aw
        109r4Ikr40yr1vqas2ya17J3yDK3s5JFn2v3WUGa1Sq3sxAan8Ca1qyrWDZF4UWr1Fkr13
        W3Z5Gr4fA343WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbU73JUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: pfklmlasuwk6r16rljoofrz/1tbiNx5dRFWBj0WjBwAAsK
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Guoqing Chi <chiguoqing@yulong.com>

The plural of "matrix" is "matrices".

Signed-off-by: Guoqing Chi <chiguoqing@yulong.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---
V4:adding linux-iio@vger.kernel.org.

 include/linux/platform_data/invensense_mpu6050.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/platform_data/invensense_mpu6050.h b/include/linux/platform_data/invensense_mpu6050.h
index 93974f4cfba1..f05b37521f67 100644
--- a/include/linux/platform_data/invensense_mpu6050.h
+++ b/include/linux/platform_data/invensense_mpu6050.h
@@ -12,7 +12,7 @@
  *			mounting matrix retrieved from device-tree)
  *
  * Contains platform specific information on how to configure the MPU6050 to
- * work on this platform.  The orientation matricies are 3x3 rotation matricies
+ * work on this platform.  The orientation matrices are 3x3 rotation matrices
  * that are applied to the data to rotate from the mounting orientation to the
  * platform orientation.  The values must be one of 0, 1, or -1 and each row and
  * column should have exactly 1 non-zero value.
-- 
2.17.1


