Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBB83C1DC1
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jul 2021 05:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhGIDTC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Jul 2021 23:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbhGIDTC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Jul 2021 23:19:02 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6559C061574;
        Thu,  8 Jul 2021 20:16:19 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y4so7428400pfi.9;
        Thu, 08 Jul 2021 20:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WgYdiIOxAQ/HCTaPSVzBxyU8mVrwT8Kgg4wCyu3Uux8=;
        b=Zsf7DzVxl643Jsoxh8uBAgqiLpn0boTOhu+AcIjFlI0VrrfdkgPuO+5z70sXrcUOzN
         1cY1vYfORPplLXbWtmwpztC+ipFHOmtQ8LfqpKq45jcm+5VnVbd5VkwxGfA1wPrlydOP
         XNjMZ9ycaM5YtP9ZpjYy1+GyWCWT1xPgilmnGQ6Ctl7A1Su8S5d6hM4tT4eExUjpwvtk
         6OA/g6DhX3ENyGZ1AnwpMILH3gHXp7yGsHdSz8cmqYTDAA5tET41kBpXhWeu7z4KQm/o
         4w2MS0sh1PZXMdnCSrt8BGEGgC2ffljVP7iJM/s0JvsRCLxF4t2+nnKVNeT7Aa/GL4Mk
         I+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WgYdiIOxAQ/HCTaPSVzBxyU8mVrwT8Kgg4wCyu3Uux8=;
        b=joiZCVK2EV55+fNAdiShx9dJbiUNXoPLJEF0cVG2BFbMnPfCKCHJqWUZ5+h1RZ+6mo
         mYDn6StTh92CaxHvGDa5kar6ckDjEFncJFT8p2UexW+NkbgA1Lj7R08o8yVqGkvYGk68
         owl0ECnXnxytS77Q29lzFMau+KADAFF+akl8cGnH1kj3tr01m0UF7zIpcrv7Vtolk7Ir
         Sfu8uXfwtgSd2zcyQK8bnvrrPLij/lyJvtuUTPXlIBdSNdO96v+rP6ewq/aX7uHyVd3C
         XpZphDkirXzqlrAaRQsFvS6IX9DlE1Jh/oYniyyZ6GlQYhHj+9t75pynT8OpOUoAhBxN
         2YqA==
X-Gm-Message-State: AOAM533nGCXDOPY9AgIKxX+xRlYwLefFo6xA9a1ObL+bCORKP1vhGAyR
        itkNpR4URpermp/5MpS3dqs=
X-Google-Smtp-Source: ABdhPJyK+EsV8fiBCNogJoOfuvMDmYSfwftZ6aYfd12X4hQXFkxl6MzJVy//kKtjFJ6gfUPrE/fGew==
X-Received: by 2002:a63:4650:: with SMTP id v16mr35413408pgk.90.1625800579004;
        Thu, 08 Jul 2021 20:16:19 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9005:8001:f83b:3fe0:973b:4044])
        by smtp.gmail.com with ESMTPSA id p53sm4333209pfw.108.2021.07.08.20.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 20:16:18 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, sean@geanix.com,
        andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] iio: accel: fxls8962af: Initialize return value
Date:   Fri,  9 Jul 2021 08:45:25 +0530
Message-Id: <20210709031526.30746-1-jrdr.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

kernel test robot throws below warning ->

smatch warnings:
drivers/iio/accel/fxls8962af-core.c:640
fxls8962af_i2c_raw_read_errata3() error: uninitialized symbol 'ret'.

Initialize it.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/iio/accel/fxls8962af-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 078d87865fde..8af1c8f58e83 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -628,7 +628,7 @@ static int fxls8962af_i2c_raw_read_errata3(struct fxls8962af_data *data,
 					   u16 *buffer, int samples,
 					   int sample_length)
 {
-	int i, ret;
+	int i, ret = -EINVAL;
 
 	for (i = 0; i < samples; i++) {
 		ret = regmap_raw_read(data->regmap, FXLS8962AF_BUF_X_LSB,
-- 
2.25.1

