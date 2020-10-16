Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579E1290B65
	for <lists+linux-iio@lfdr.de>; Fri, 16 Oct 2020 20:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391884AbgJPSfV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Oct 2020 14:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390530AbgJPSfU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Oct 2020 14:35:20 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497F0C0613D3
        for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2020 11:35:20 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id hk7so1985680pjb.2
        for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2020 11:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=RcD2MkepOOd4YSt6V51qpKCTmYea5sGa5rAmpi9Peg4=;
        b=vtug/S9AEGUEmTU/Y4Nqtz54VKcmujSgc/Ed+UVnzNi1mjVEXptUTM8mIFiP0K40ot
         myT6EAZqHzMxKyAtsEDV6ys2aaveQxnHCIOcxVSQldZkbTeZTEg6aD8Y7h6sRkt8+iok
         wySN060SqvQvzHU5DZH+mz4CpnhhCxjG6iYUfnfHAO2DxyL4APao89Q+4Tpy4uiE+sgk
         4LZXgvQkSD6/C/8gAZseL30E65ZV0IHa2/vc5sdTK3SFYR27jgG6sIegMr2I0Jf6zcuL
         G7RTtxietvfio77NWTIOZkhaY3HOPjYudwS2xiyzhs8PFPsf5PhFbRwCXBIZ4VO8vJzm
         A+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=RcD2MkepOOd4YSt6V51qpKCTmYea5sGa5rAmpi9Peg4=;
        b=NS1GurSdl+pHemGV0y1ScSzv2cZnYindN5itq+2iv4QH7VWgw/7KvvWkqvnTyt8ISS
         XNY5ATVt9m076BqfZddycQeoz+Sx8Vf52OvyUMB//CzDHSFe42kDOnqJOocf4DR6RDL0
         FCCSydUwHkJjepb9lxxWAtg9A9q2Xno6TCDlfyW/SRO+VUkhHb1Ta55dnsZxa7EanlZ0
         UNltn/1jOzclyp4SzpOw8JB+HXSyLAgCBE2WVCwHvM+omnjhECEUtmcihVmAbnefqbf3
         sp6JftS/yYiYaoshgspwTiVqgW0RtmWfJcZRJpQPaj18Dh0f64FCp+mqmquIpwYpWkPB
         j46g==
X-Gm-Message-State: AOAM532PYfPXehdrHezkpUtEjZgNzoJs1y2lkrp9OeX2spdRYg1ZwVVY
        Shwnls1AJBMGCKSdNXtdm65J
X-Google-Smtp-Source: ABdhPJyxf5Lq6KnRCKfNeG3X7tk0Nj24UjRYLyhPlVIRuubgt/PuPY+K++RvNEc7kUiTDwwYus1kfw==
X-Received: by 2002:a17:90a:1690:: with SMTP id o16mr5435921pja.148.1602873319820;
        Fri, 16 Oct 2020 11:35:19 -0700 (PDT)
Received: from ubuntu ([116.68.78.80])
        by smtp.gmail.com with ESMTPSA id e11sm3541946pfl.58.2020.10.16.11.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 11:35:19 -0700 (PDT)
Date:   Sat, 17 Oct 2020 00:04:27 +0530
From:   Vaishnav M A <vaishnav@beagleboard.org>
To:     jic23@kernel.org, knaack.h@gmx.de, ars@metafoo.de,
        alexandru.ardelean@analog.com, nish.malpani25@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jkridner@beagleboard.org, drew@beagleboard.org,
        robertcnelson@beagleboard.org, rajkovic@mikroe.com,
        vaishnav@beagleboard.org
Subject: [PATCH] iio: light: tsl2563 change of_property_read to
 device_property_read
Message-ID: <20201016183219.GA15288@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


This patch aims to replace the of_property_read_u32 for reading
the amstaos,cover-comp-gain property with device_property_read_u32

Thanks and Regards,
Vaishnav M A

Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
---
 drivers/iio/light/tsl2563.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index abc8d7db8dc1..1f1b8b7cefa4 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -703,7 +703,6 @@ static int tsl2563_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	struct tsl2563_chip *chip;
 	struct tsl2563_platform_data *pdata = client->dev.platform_data;
-	struct device_node *np = client->dev.of_node;
 	int err = 0;
 	u8 id = 0;
 
@@ -738,13 +737,14 @@ static int tsl2563_probe(struct i2c_client *client,
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

