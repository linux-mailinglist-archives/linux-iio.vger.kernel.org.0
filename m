Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739B7291FD9
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 22:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgJRUgB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 16:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgJRUgB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Oct 2020 16:36:01 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF28DC0613CE
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2020 13:35:59 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id e10so4775424pfj.1
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2020 13:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=rqhubITZucLjIPmaYRNb6YYx2VTwfGAAxlULYuBZwr4=;
        b=QfdY8x17n/94SlduisjHjd5UHou8ch9k1JiCT9D/RwXyXGAyy2sWeGDF5sN+yfNeNH
         89vw/c33WQOiqqbMas45A609nadok8b8IuIFYCKYRTl3ueXllzEt/S5vyYlrcSHlWi2z
         +KMTYh1t81VFDLh9OsPW7VkoP4sD1cb+p+FubTq76KT3CqVuvEQkOlOepvgLDEU7wX2H
         d8+4B8MzyfFIcseWeJ33wW0R43PdoFV8s/RXGC65SiKWdwMXTqzzccneLkKqIsFnyhgH
         77MkKbl3deSl2pdnFCWYtU6ancCUk76E/j4EGjoPaq/jvZ/bbMyzoyihZM4DB3z5q1iU
         xjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=rqhubITZucLjIPmaYRNb6YYx2VTwfGAAxlULYuBZwr4=;
        b=Xgtk9dbRWY/YNyW1GKpgR9x7O1Rep5mZbHxgHzUtJtj1ypPaJlJaMvminGN+5AH7am
         kT85P+Ot1rIS5Ks1o6QtECFu7EV/HoAKZ+1ldvgOflCDNsnMM7MDV2wXWXmISiDeriKY
         eoY60DH3hfGcMnCMUpkwbwIv0DMMPK/DmbBD5C7Q0atCPM9mGd0TZRAg2YpRXn6JUlTa
         5HNQh6VMW9hv9KCf6zFXpiTx5MN4QyQKhayb5Z0c+uDkU1QPBGZApD+P9EfcTsHC2BXE
         5O0Y1v7yjLOoInIKK/MA0Lvvo5aR0bpGYV4HfbwNP/LUXS7xFE76NcOB2KCTnaYM+9yU
         kJag==
X-Gm-Message-State: AOAM5307m3+OFvc07FhTHOgcLm/CrMKSvQHPNjE5dhWlv8UALvVtYzG3
        4afoeQTGjiZktSUoradmTGMh
X-Google-Smtp-Source: ABdhPJzNCQrhHHahLFjNTXfy3QIMvULkSoY+gQdYzYFLr/RkPnnzftp97vs9Kz8+vTuSq6a2diY81A==
X-Received: by 2002:a63:715:: with SMTP id 21mr11488068pgh.13.1603053359289;
        Sun, 18 Oct 2020 13:35:59 -0700 (PDT)
Received: from ubuntu ([116.68.78.80])
        by smtp.gmail.com with ESMTPSA id l13sm2292891pgp.25.2020.10.18.13.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 13:35:58 -0700 (PDT)
Date:   Mon, 19 Oct 2020 02:05:52 +0530
From:   Vaishnav M A <vaishnav@beagleboard.org>
To:     jic23@kernel.org, andy.shevchenko@gmail.com, wsa@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, alexandru.ardelean@analog.com,
        matt.ranostay@konsulko.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jkridner@beagleboard.org, drew@beagleboard.org,
        robertcnelson@beagleboard.org, rajkovic@mikroe.com,
        vaishnav@beagleboard.org
Subject: [PATCH v4] iio:light:tsl2563 use generic fw accessors
Message-ID: <20201018203552.GA816421@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Replace of_property_read_u32() with device_property_read_u32(),
when reading the amstaos,cover-comp-gain.This opens up the
possibility of passing the properties during platform instantiation
of the device by a suitable populated struct property_entry.
Additionally, a minor change in logic is added to remove the
of_node present check.

Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
---
 v4:
	-update commit message, fix punctuation.
	-update to a shorter commit title, used for similar changes
	 within the subsystem, like in 00fa493b9989
	 ("iio:proximity:as3935: Drop of_match_ptr and use generic fw accessors")
 v3:
        -modify commit message for readability, mention minor logic change
        -include  mod_devicetable.h and property.h headers
 v2:
        -fix commit message
 drivers/iio/light/tsl2563.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index abc8d7db8dc1..5bf2bfbc5379 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -12,6 +12,8 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -703,7 +705,6 @@ static int tsl2563_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	struct tsl2563_chip *chip;
 	struct tsl2563_platform_data *pdata = client->dev.platform_data;
-	struct device_node *np = client->dev.of_node;
 	int err = 0;
 	u8 id = 0;
 
@@ -738,13 +739,14 @@ static int tsl2563_probe(struct i2c_client *client,
 	chip->calib0 = tsl2563_calib_from_sysfs(CALIB_BASE_SYSFS);
 	chip->calib1 = tsl2563_calib_from_sysfs(CALIB_BASE_SYSFS);
 
-	if (pdata)
+	if (pdata) {
 		chip->cover_comp_gain = pdata->cover_comp_gain;
-	else if (np)
-		of_property_read_u32(np, "amstaos,cover-comp-gain",
-				     &chip->cover_comp_gain);
-	else
-		chip->cover_comp_gain = 1;
+	} else {
+		err = device_property_read_u32(&client->dev, "amstaos,cover-comp-gain",
+					       &chip->cover_comp_gain);
+		if (err)
+			chip->cover_comp_gain = 1;
+	}
 
 	dev_info(&client->dev, "model %d, rev. %d\n", id >> 4, id & 0x0f);
 	indio_dev->name = client->name;
-- 
2.25.1

