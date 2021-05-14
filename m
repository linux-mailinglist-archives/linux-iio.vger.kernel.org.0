Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3E7380AF0
	for <lists+linux-iio@lfdr.de>; Fri, 14 May 2021 16:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbhENOB3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 May 2021 10:01:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233677AbhENOB3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 May 2021 10:01:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AADBF6101A;
        Fri, 14 May 2021 14:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621000817;
        bh=7NB1FE8Uid9tyXKynlxvfUzhGWXyAQBzyCqed1gxhfk=;
        h=From:To:Cc:Subject:Date:From;
        b=VsqUEHcDbAAOq2f8moIYt11ziM2tUJr6Gdlw1A4T9yTEJnxY/ICUb0BIeCvky6dCT
         ZPLry+v2B6kI67x25Y0wYw9HbTKkPTw2ZKTwWl/GSfFiw2IiIwRos27NdlmwJuMHZx
         cZlKCAK6vpNdOOqN4aqwwc04z0tF+j1ohDXkRi74Xh2VbSEEU4O5rcj9WUImoMcsjD
         r1BczSwvYgy67LruE2Iwe5V5djN4T+8PJJl2BNuxkfHXeVHrImyXOsbCEX3KFyXHab
         ddq5btrWlS1mlXvPpp4oJPIQmCDrKwRXnZThGyGpkAS7NW4F7uNj9rnDvbZJkgeOJq
         2duQHEynK4CDg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        =?UTF-8?q?Maxime=20Roussin-B=C3=A9langer?= 
        <maxime.roussinbelanger@gmail.com>,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] iio: si1133: fix format string warnings
Date:   Fri, 14 May 2021 15:59:21 +0200
Message-Id: <20210514135927.2926482-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

clang complains about multiple instances of printing an integer
using the %hhx format string:

drivers/iio/light/si1133.c:982:4: error: format specifies type 'unsigned char' but the argument has type 'unsigned int' [-Werror,-Wformat]
                 part_id, rev_id, mfr_id);
                 ^~~~~~~

Print them as a normal integer instead, leaving the "#02"
length modifier.

Fixes: e01e7eaf37d8 ("iio: light: introduce si1133")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iio/light/si1133.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
index c280b4195003..fd302480262b 100644
--- a/drivers/iio/light/si1133.c
+++ b/drivers/iio/light/si1133.c
@@ -978,11 +978,11 @@ static int si1133_validate_ids(struct iio_dev *iio_dev)
 		return err;
 
 	dev_info(&iio_dev->dev,
-		 "Device ID part %#02hhx rev %#02hhx mfr %#02hhx\n",
+		 "Device ID part %#02x rev %#02x mfr %#02x\n",
 		 part_id, rev_id, mfr_id);
 	if (part_id != SI1133_PART_ID) {
 		dev_err(&iio_dev->dev,
-			"Part ID mismatch got %#02hhx, expected %#02x\n",
+			"Part ID mismatch got %#02x, expected %#02x\n",
 			part_id, SI1133_PART_ID);
 		return -ENODEV;
 	}
-- 
2.29.2

