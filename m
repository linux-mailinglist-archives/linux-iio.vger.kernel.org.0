Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40B62917E6
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 16:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgJROnq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 10:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgJROnq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Oct 2020 10:43:46 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE27FC0613CE
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2020 07:43:45 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t22so730770plr.9
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2020 07:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ioUl3a2YgheFEBSCpVRh2eFlj1emUIf0N1aypWiTiuE=;
        b=1pvu8Cf19+kAXYtldE/dTmygylRaMkNNM8nwYYEwlimC8KCif2WRiBRlNaFGyTlaEl
         sVFDna9EN67/aspy2sP+A6GrIpD0U33kwbYpVTmsvK9MJJRjf4Rpz3xbGzhbjHapNPqZ
         PNw1HoabNIG7L1H/AkhC3xSVwTs+kb5pB1vz07IdbXTL6CPPAMoT5axmtvwzI5Xo8MxK
         0MIouvMgixoy+29kFYYmf47nqt/tCjDf669FNNfGcX7NBVd8CQeIaipKs8rqOK12f4QR
         7TlEWLm7EsCx/8JyI1Xbvq1IH/iEIEKZIZopqeoKtbrOnzxoSqnDzXuQkMgzkN3YxG3L
         sLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ioUl3a2YgheFEBSCpVRh2eFlj1emUIf0N1aypWiTiuE=;
        b=qBVNaAS6doLqWj7g/HmQp5iVucPOBhRgtU9JMO4Ll3qOPTB6G1Vn7W/cxFIZBWcIcC
         CRw2/MA7/QCKWNBYsfk115RI7vOTJ0mAR+UkmZ0CoGZuijy2qqpxtzJK4KWFeRit/386
         b6jXiN1fQAtQok3LQuqWTS4v0aQOdK8+uCyF1bBAvKzlqi18GS4xs8rro95NBV1PB3Nn
         J03pPSnEcMl/8xgDI+ohSQQC0cSpEx1d7oQjmBFl5ZX6MFJN1143TWVcPK3bNWh5XuHT
         NuoO6q8XG8SeUj3HPSpJp99Aj/RfobWBrVWtnPm1zmTrcU0ToMV21zQnNacvxZZh3w4w
         N+uw==
X-Gm-Message-State: AOAM5306uAt137Xxs0AbMF14QJC6EJc0PCDNp42NakIjs+I0jxUbrR+n
        H/zx87zSJtQ9fcbmawSZAJ1k
X-Google-Smtp-Source: ABdhPJwDBZ8z9w+JO0X8KwfUGLubtnNMj3YJONCELYeIaSreLj+jt/9KPtKGB0f7aDikUf15snO2LQ==
X-Received: by 2002:a17:902:ed54:b029:d3:d0bc:e41d with SMTP id y20-20020a170902ed54b02900d3d0bce41dmr13769272plb.13.1603032225390;
        Sun, 18 Oct 2020 07:43:45 -0700 (PDT)
Received: from ubuntu ([116.68.78.80])
        by smtp.gmail.com with ESMTPSA id f1sm8600675pfe.145.2020.10.18.07.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 07:43:44 -0700 (PDT)
Date:   Sun, 18 Oct 2020 20:13:38 +0530
From:   Vaishnav M A <vaishnav@beagleboard.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        nish.malpani25@gmail.com, alexandru.ardelean@analog.com,
        matt.ranostay@konsulko.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jkridner@beagleboard.org, drew@beagleboard.org,
        robertcnelson@beagleboard.org, rajkovic@mikroe.com,
        vaishnav@beagleboard.org
Subject: [PATCH v3] iio: light: tsl2563 change of_property_read to
 device_property_read
Message-ID: <20201018144338.GA218707@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Replace of_property_read_u32() with device_property_read_u32,
when reading the amstaos,cover-comp-gain.This opens up the
possibility of passing the properties during platform instantiation
of the device by a suitable populated struct property_entry.
Additionally a minor change to logic is added to remove the
of_node present check.

Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
---
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

