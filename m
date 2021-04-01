Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB09351D47
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 20:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237448AbhDAS1t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 14:27:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237303AbhDASW7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 1 Apr 2021 14:22:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9B4E6135C;
        Thu,  1 Apr 2021 14:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617288266;
        bh=lwWtqsMAluvnXv/MtmV8EIm4bHoGqvkCMAJWHaRbw98=;
        h=From:To:Cc:Subject:Date:From;
        b=AU+BHcFK453ROlrTanuMDlFDc5ZyxxHI2ozzBtJypeIUvu8YLhjroITiKJCuJLG3V
         ZRoCalLmf8CteZxIeXJvwrh1ymDOScMh6FbDjPzsXZQkC/Ze0UGPvDFN+PQfEEjcc/
         nNZxuyRQ8qhdJx0Hc2C4KyRBhbA0IvWMPg+Wz65qQsCVmuD33Bhb/jErsRjH4jHcSt
         MxE/daKNIeKPGW920SsbV9yw2f0ePe3iM0bj745IFNYB7/sE7wiJuFFSZUskT34JaT
         kZmDHplRtQCzjstnHnyCmZ+UAtU295z1a1S83z5xzgyBNFqj9msrHmyiplxGyQJZza
         TD4h0hGSUuG2A==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] iio:accel:stk8312: Add lowercase i2c device id
Date:   Thu,  1 Apr 2021 15:42:26 +0100
Message-Id: <20210401144226.225928-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These are never upper case.  Chances are that all users of this driver
were using the ACPI binding but just in case keep the uppercase version
but mark it deprecated.

Whilst here tidy up some spacing.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/stk8312.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index 157d8faefb9e..60aecfa9fd92 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -635,13 +635,15 @@ static SIMPLE_DEV_PM_OPS(stk8312_pm_ops, stk8312_suspend, stk8312_resume);
 #endif
 
 static const struct i2c_device_id stk8312_i2c_id[] = {
-	{"STK8312", 0},
+	/* Deprecated in favour of lowercase form */
+	{ "STK8312", 0 },
+	{ "stk8312", 0 },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, stk8312_i2c_id);
 
 static const struct acpi_device_id stk8312_acpi_id[] = {
-	{"STK8312", 0},
+	{ "STK8312", 0 },
 	{}
 };
 
-- 
2.31.1

