Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F00C6D5579
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2019 11:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbfJMJcY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Oct 2019 05:32:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728080AbfJMJcY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 05:32:24 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69EB420679;
        Sun, 13 Oct 2019 09:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570959143;
        bh=vv0x3V4u3Fs9k+8MDwLKn2jmOM3f5l4VL12Gif3ewN8=;
        h=From:To:Cc:Subject:Date:From;
        b=YkQEcJsBAKIdXzqvLn7D8KCQEBYA+mbKYNfTYeOfQiTBw/o7DhjFp+biKWQq0pgwz
         Fu/hIww+rwhTCz4GwpHm4MtsmXL5AH8Ids5l5cwFnH9ewlMlYeqhupD2Lahq0W/p0M
         D60f4d1OECvI4mV7vlMCAnbgEY/12Se1ZKJUEOoo=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH] mfd: twl: endian fixups in i2c write and read wrappers.
Date:   Sun, 13 Oct 2019 10:30:15 +0100
Message-Id: <20191013093015.1395332-1-jic23@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Use a local variable to ensure correct endian types for
intermediate results.

Identified by sparse when building the IIO driver.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lee Jones <lee.jones@linaro.org>
---
 include/linux/mfd/twl.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/mfd/twl.h b/include/linux/mfd/twl.h
index 44aff52a5002..089e8942223a 100644
--- a/include/linux/mfd/twl.h
+++ b/include/linux/mfd/twl.h
@@ -181,14 +181,18 @@ static inline int twl_i2c_read_u8(u8 mod_no, u8 *val, u8 reg) {
 }
 
 static inline int twl_i2c_write_u16(u8 mod_no, u16 val, u8 reg) {
-	val = cpu_to_le16(val);
-	return twl_i2c_write(mod_no, (u8*) &val, reg, 2);
+	__le16 value;
+
+	value = cpu_to_le16(val);
+	return twl_i2c_write(mod_no, (u8 *) &value, reg, 2);
 }
 
 static inline int twl_i2c_read_u16(u8 mod_no, u16 *val, u8 reg) {
 	int ret;
-	ret = twl_i2c_read(mod_no, (u8*) val, reg, 2);
-	*val = le16_to_cpu(*val);
+	__le16 value;
+
+	ret = twl_i2c_read(mod_no, (u8 *) &value, reg, 2);
+	*val = le16_to_cpu(value);
 	return ret;
 }
 
-- 
2.23.0

