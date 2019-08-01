Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C939A7D66B
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2019 09:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbfHAHgS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Aug 2019 03:36:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46068 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfHAHgR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Aug 2019 03:36:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id y8so31819296plr.12;
        Thu, 01 Aug 2019 00:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v/gvKPwp4eeyfrmzYZ9gkfiwDX7eYIoi/YCwtEUkbyQ=;
        b=j0wCGZR08O0pbBhOW87OhXo3bh1GJ00hPYvCIFHV7GkKEtiTqjBUfnX7arW9O5d5iC
         zVzDz+1bMiA70Jxh1CP0EmqNkn8/UEAOoSC3VkxMJBj3V44iCx9OFSZlT1v6ljvMRMIo
         gwbJOMFzueepLb/QxjRm0fgCMNdrjz3D2DJZ7vfBJDvFwXyIl9QXxBuPl5EWN1NT4kTj
         bXIooDgCcYsQHrC8YWmnSQd/bcBVC4txp8CAkTNpZGVtadNlZvvDfYgXLxBW6K0o2iSs
         WonAJruTCuXCOQ27C0/HjCYx8JFBPTqXyEbOh82Fpeh+RFUGeXSEaDCf1rQcHTKsxPsH
         CEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v/gvKPwp4eeyfrmzYZ9gkfiwDX7eYIoi/YCwtEUkbyQ=;
        b=ac0dJxapin1FMUlvg3Wl2ju7E0YhGgFew28tH2SuyYNg4yyVSHGlTlnZvrUOHCZkk3
         5a6Sqrj1Egh6LuWksxHg+JfJPe/Q7uqhdlLFWBP6W1CU58h1mzgyDN/DcUnIGl9ZAaQV
         +Av5vQslvm2AzYTomuSAcoSPvlAy59xrA3JrZIFxK65ipSn+J+zm6Yi17W4JKlvhtRH6
         bYbat9S5bR0ULXitWBGtuZKS6Twp59vDe+q9pYy5Bx8LYQPzdHTSIicFrpTS/Guznpsa
         1b+k3k+X5zTWRxQzEuNscQr1xLfte8f6P8CklZzzTtdxiw4ZtacWENe5E8BaDpvI7Wfd
         5Feg==
X-Gm-Message-State: APjAAAW3epSNWzpFyA5BTO8X/ZFEgyrN3jQLvxfoSAM/JHZC5ubVYc1O
        uA0hR/59eKPnViUNVUmOHNI=
X-Google-Smtp-Source: APXvYqyHgg7EzKTsVbuQjwY4rn99nm6rfwVtef+hW6GWR8QaoF1JCi2lMX3QescCrLBSS+hKg41bxg==
X-Received: by 2002:a17:902:4643:: with SMTP id o61mr95913407pld.101.1564644977294;
        Thu, 01 Aug 2019 00:36:17 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id q198sm74635337pfq.155.2019.08.01.00.36.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 00:36:16 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Brian Masney <masneyb@onstation.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v4 3/4] iio: tsl2772: Use devm_iio_device_register
Date:   Thu,  1 Aug 2019 15:36:12 +0800
Message-Id: <20190801073612.9689-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use devm_iio_device_register, which removes the tsl2772_remove
function.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v4:
  - Split v3 into three patches.
  - Revise description to make it more precise.

 drivers/iio/light/tsl2772.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index e866ae40f157..680afdb078d2 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -1890,14 +1890,7 @@ static int tsl2772_probe(struct i2c_client *clientp,
 	if (ret < 0)
 		return ret;
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&clientp->dev,
-			"%s: iio registration failed\n", __func__);
-		return ret;
-	}
-
-	return 0;
+	return devm_iio_device_register(&clientp->dev, indio_dev);
 }
 
 static int tsl2772_suspend(struct device *dev)
@@ -1934,15 +1927,6 @@ static int tsl2772_resume(struct device *dev)
 	return tsl2772_chip_on(indio_dev);
 }
 
-static int tsl2772_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	iio_device_unregister(indio_dev);
-
-	return 0;
-}
-
 static const struct i2c_device_id tsl2772_idtable[] = {
 	{ "tsl2571", tsl2571 },
 	{ "tsl2671", tsl2671 },
@@ -1989,7 +1973,6 @@ static struct i2c_driver tsl2772_driver = {
 	},
 	.id_table = tsl2772_idtable,
 	.probe = tsl2772_probe,
-	.remove = tsl2772_remove,
 };
 
 module_i2c_driver(tsl2772_driver);
-- 
2.20.1

