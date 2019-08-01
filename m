Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA6737D669
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2019 09:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730916AbfHAHgL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Aug 2019 03:36:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42830 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfHAHgL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Aug 2019 03:36:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so33519120pff.9;
        Thu, 01 Aug 2019 00:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FEKRFdCKMpkSeVMIdG4ipy7CLi0KrDkFAlXZaWu5PvE=;
        b=QYIPysX3gk7gePWu04a+uSdFFoECYk9d4x7/ixCMLdWbWsxKefmv4UOXOAx2qZoKdz
         XZVDLd+G4Nr3SbkCiwypxC93qWVuZxG/jH1ejT1g/Hi5U3UG/A+PI7ZN2eR7TTDqwjPL
         5EmiHAT6IqEqIi3IDrkvYuCDyht8SnnNAoSZn8wS5QgZ2VyPMBjHESGYbTwaOZAvtxnG
         mArp7Oal41UErDsI+W9jp4ETWvRFK73LJKqgnFnN0PR92/o162HnPrn3SD5G63/P1HNa
         tBBAVnJ8Lk2B29yIcVApDPfIWO2CKzZfEcXh/lk+KeHUsLWWKlEH+vSxY0lQRsYcK0zz
         VTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FEKRFdCKMpkSeVMIdG4ipy7CLi0KrDkFAlXZaWu5PvE=;
        b=DNDcMmJwtmInoYFD3NReVhHPxrAeqbM5sxLPGG6HlxugD/JLFcSQ7rnzLryLw5jKuz
         5+pRGIZwqBaalDUo5s9oJMFxoxyv4h9bqCkzqAJvAtpRGYGzGFgMtDyI23uA0lRpIY5Q
         yqL8mUzxfnGg08KIlDIxi/mfmE6u/7BAJh9YiPAnTv5QkK6cB+b6TWgTLIQCtxHE/SRV
         4SttNhhxp5L56F4BEgh6LolYLOIrxrLiTxGMyrLSNj0Qmwh4QbR6A+IwHeedB91aAuH/
         QX0/d/Jm30la69sGUVvRlVZRwpL0uTZ8uGknrYitbob+Sah3L2FYdHtbr06V+HODunbM
         HuzA==
X-Gm-Message-State: APjAAAW+CLdl4Tbc2w98c4KZYc63VDbfi4GqTwUp6LEqgKRtNDdfJ5x2
        mXO4tuD9jm58280MWvIueis=
X-Google-Smtp-Source: APXvYqyEdZc4RRfJnxFx0LwafaLBOctTzJ6k8b1ZC6wiPksEt3+pnArkk58FuDvqCNOKLh/0S66L8A==
X-Received: by 2002:a63:dd0b:: with SMTP id t11mr77496230pgg.410.1564644970565;
        Thu, 01 Aug 2019 00:36:10 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id e13sm88345565pff.45.2019.08.01.00.36.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 00:36:10 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Brian Masney <masneyb@onstation.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v4 2/4] iio: tsl2772: Use devm_add_action_or_reset for tsl2772_chip_off
Date:   Thu,  1 Aug 2019 15:36:05 +0800
Message-Id: <20190801073605.9635-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use devm_add_action_or_reset to call tsl2772_chip_off
when the device is removed.
This also fixes the issue that the chip is turned off
before the device is unregistered.

Fixes: 4e24c1719f34 ("staging: iio: tsl2x7x: rename driver to tsl2772")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v4:
  - Split v3 into three patches.
  - Revise description to make it more precise.

 drivers/iio/light/tsl2772.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index 29cfd8ae2700..e866ae40f157 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -860,6 +860,13 @@ static int tsl2772_chip_off(struct iio_dev *indio_dev)
 	return tsl2772_write_control_reg(chip, 0x00);
 }
 
+static void tsl2772_chip_off_action(void *data)
+{
+	struct iio_dev *indio_dev = data;
+
+	tsl2772_chip_off(indio_dev);
+}
+
 /**
  * tsl2772_invoke_change - power cycle the device to implement the user
  *                         parameters
@@ -1877,9 +1884,14 @@ static int tsl2772_probe(struct i2c_client *clientp,
 	if (ret < 0)
 		return ret;
 
+	ret = devm_add_action_or_reset(&clientp->dev,
+					tsl2772_chip_off_action,
+					indio_dev);
+	if (ret < 0)
+		return ret;
+
 	ret = iio_device_register(indio_dev);
 	if (ret) {
-		tsl2772_chip_off(indio_dev);
 		dev_err(&clientp->dev,
 			"%s: iio registration failed\n", __func__);
 		return ret;
@@ -1926,8 +1938,6 @@ static int tsl2772_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
-	tsl2772_chip_off(indio_dev);
-
 	iio_device_unregister(indio_dev);
 
 	return 0;
-- 
2.20.1

