Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934E239A675
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jun 2021 18:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhFCQ6w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Jun 2021 12:58:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230286AbhFCQ6w (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 3 Jun 2021 12:58:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4767061159;
        Thu,  3 Jun 2021 16:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622739427;
        bh=atshCxmikwca9fWDMuEvumCvr0W/LDBCAxYZPlzflLs=;
        h=From:To:Cc:Subject:Date:From;
        b=nVZEEjuSQCn0Y+PXYtbWk/KfMJff8d6KQ6K0l9WK0nLqeQhGsQR9j6v0GqugrmVqb
         Y07vqiZB+Po3ATIsHSe8UkkhWKac8FKd5qR2gEIimb9+3Gh9KkV9KoPge7LqyxGyKU
         IuRuc94Qf7MiwCcXQEX96PS6BasbNuGzrlPBUQTFuHWusNDAjqhKYI/aDbUUL7byUC
         Yh/M2lyUN958KOAaGGJTx560cJTB3KwhzBVNN9UUIt1FlRW806efnHaBqJGktguDPZ
         FhSEj7/4oOsWLGgQzmmMMfF5U5hiOXCvA6mD6gvOAXSglunqbbEAgAVLQJb1tolrR0
         BBVwcKfOLQYkw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tom Rix <trix@redhat.com>, Sean Nyekjaer <sean@geanix.com>,
        Wolfram Sang <wsa@kernel.org>
Subject: [PATCH] i2c: core: Add stub for i2c_verify_client() if !CONFIG_I2C
Date:   Thu,  3 Jun 2021 17:58:35 +0100
Message-Id: <20210603165835.3594557-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

If I2C is not compiled, there is no way we should see a call to
i2c_verify_client() on a device that is an i2c client. As such,
provide a stub to return NULL to resolve an associated build failure.

The build is failing with this link error
ld: fxls8962af-core.o: in function `fxls8962af_fifo_transfer':
fxls8962af-core.c: undefined reference to `i2c_verify_client'

Reported-by: Tom Rix <trix@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Fixes: 68068fad0e1c ("iio: accel: fxls8962af: fix errata bug E3 - I2C burst reads")
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
Cc: Wolfram Sang <wsa@kernel.org>
---

V2: Move to end of existing #if IS_ENABLED(CONFIG_I2C) block.

Plan for this an immutable branch in iio.git which can be pulled into both
the togreg branch of iio.git and the i2c tree.
Fixes tag is there so that people can track the need for this patch if
they are backporting that device errata work around.

 include/linux/i2c.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index e8f2ac8c9c3d..7d71131c394e 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -343,7 +343,6 @@ struct i2c_client {
 };
 #define to_i2c_client(d) container_of(d, struct i2c_client, dev)
 
-struct i2c_client *i2c_verify_client(struct device *dev);
 struct i2c_adapter *i2c_verify_adapter(struct device *dev);
 const struct i2c_device_id *i2c_match_id(const struct i2c_device_id *id,
 					 const struct i2c_client *client);
@@ -477,6 +476,13 @@ i2c_new_ancillary_device(struct i2c_client *client,
 			 u16 default_addr);
 
 void i2c_unregister_device(struct i2c_client *client);
+
+struct i2c_client *i2c_verify_client(struct device *dev);
+#else
+static inline struct i2c_client *i2c_verify_client(struct device *dev)
+{
+	return NULL;
+}
 #endif /* I2C */
 
 /* Mainboard arch_initcall() code should register all its I2C devices.
-- 
2.31.1

