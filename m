Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 841A010E8B1
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2019 11:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfLBKXr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Dec 2019 05:23:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:35472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfLBKXr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 2 Dec 2019 05:23:47 -0500
Received: from localhost.localdomain.com (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DFEE20718;
        Mon,  2 Dec 2019 10:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575282227;
        bh=7OuRMcOp4neJOXBLaLHvtMU1QZciFoKQjluB0unWmTc=;
        h=From:To:Cc:Subject:Date:From;
        b=DJixzijji25QFpCZm+ndhPUrNKYzsC0OSudsVtiNcSK6lwVMqy6mSOS2xvg1rDMSb
         ho4YWRCF92aWqRWsxv/GwSVr9SzgULVTNm56qgPo2DuEDfZMi1yi862fhPd+9GJvrx
         s7gMY+lAT+yY5RkjpwfLMZpi78+r4edLbFvUePOo=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org
Subject: [PATCH] iio: humidity: hts221: move register definitions to sensor structs
Date:   Mon,  2 Dec 2019 12:23:28 +0200
Message-Id: <0e49f52be057a14f0885dfaf496e8274c8107f60.1575282133.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Move some register definitions to hts221_avg_list, hts221_avg_list and
hts221_channels since they are used only there and simplify driver code

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/humidity/hts221_core.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index 4922444771c6..9003671f14fb 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -24,13 +24,6 @@
 #define HTS221_REG_CNTRL1_ADDR		0x20
 #define HTS221_REG_CNTRL2_ADDR		0x21
 
-#define HTS221_REG_AVG_ADDR		0x10
-#define HTS221_REG_H_OUT_L		0x28
-#define HTS221_REG_T_OUT_L		0x2a
-
-#define HTS221_HUMIDITY_AVG_MASK	0x07
-#define HTS221_TEMP_AVG_MASK		0x38
-
 #define HTS221_ODR_MASK			0x03
 #define HTS221_BDU_MASK			BIT(2)
 #define HTS221_ENABLE_MASK		BIT(7)
@@ -66,8 +59,8 @@ static const struct hts221_odr hts221_odr_table[] = {
 
 static const struct hts221_avg hts221_avg_list[] = {
 	{
-		.addr = HTS221_REG_AVG_ADDR,
-		.mask = HTS221_HUMIDITY_AVG_MASK,
+		.addr = 0x10,
+		.mask = 0x07,
 		.avg_avl = {
 			4, /* 0.4 %RH */
 			8, /* 0.3 %RH */
@@ -80,8 +73,8 @@ static const struct hts221_avg hts221_avg_list[] = {
 		},
 	},
 	{
-		.addr = HTS221_REG_AVG_ADDR,
-		.mask = HTS221_TEMP_AVG_MASK,
+		.addr = 0x10,
+		.mask = 0x38,
 		.avg_avl = {
 			2, /* 0.08 degC */
 			4, /* 0.05 degC */
@@ -98,7 +91,7 @@ static const struct hts221_avg hts221_avg_list[] = {
 static const struct iio_chan_spec hts221_channels[] = {
 	{
 		.type = IIO_HUMIDITYRELATIVE,
-		.address = HTS221_REG_H_OUT_L,
+		.address = 0x28,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_OFFSET) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
@@ -114,7 +107,7 @@ static const struct iio_chan_spec hts221_channels[] = {
 	},
 	{
 		.type = IIO_TEMP,
-		.address = HTS221_REG_T_OUT_L,
+		.address = 0x2a,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_OFFSET) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
-- 
2.21.0

