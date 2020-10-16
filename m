Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5571F290BC7
	for <lists+linux-iio@lfdr.de>; Fri, 16 Oct 2020 20:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403977AbgJPSwJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Oct 2020 14:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403976AbgJPSwJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Oct 2020 14:52:09 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7BEC061755
        for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2020 11:52:09 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h6so1976425pgk.4
        for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2020 11:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=bZS0PkIumMewJqO0zzmmpVDk7qnPinNXzuHyH6TMs80=;
        b=JHuDxzjbKaRY0U52JMzbJvyxhCDlFz5UIpmzyrSse45hHa4tKEisXs3IpiQXj4OQ2i
         RtHNq+nSKkn+rsVGB0qisd7gn9g1VW6djG0ygkCCGSAgwHrqipxphy8Cv8a5DvKxSuj3
         YGr3bWm4pNZI67YehANTagkyiOhISZP4EKVA/c0FGiuGA/eAYLY/bX/BkiX4AiXqzIWs
         JQLX/FCsGEhez209yGORXFG6aHpKYONCiYhRWmOE5OLMk/q3tRTTEA0gkgawsYsQrnL4
         EMpoMMcrG/fcCBARW0Ahw28ljfwp9ptXvEOViQSVVGGVI6UWzp6ROlWHuMeuN45QX9zA
         qyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=bZS0PkIumMewJqO0zzmmpVDk7qnPinNXzuHyH6TMs80=;
        b=Uwyavust3aDELiXTyiyKots4Vc8E1aapiJkTNW9K+xnR89jro4iz2rOSeD4ISYmbhY
         VPrpJnAsA8d60vPGvzfg5HOmbaffffrxfRXXAHf20thlJDFPCQ0ijgM4u3epcHjkU3Z2
         uuaDwFL0Bb7pmOxtnleWJgRdplg8jPAB4Rgn4KZCGWtju61LD3rQTL9nHTBUKeHotLYR
         EtThRg84MMRGwmC8N/s/YDtQbqTEwz0zC0M1QqW9fxIYIu6vXR38kuvGl4sS1NzWHFtk
         Peubk+27mPA2N0tk42LqUOcS5GKcOkzI4TnvMzIVGacrQHPTKenNRic2hZepjsc5TpA2
         B3LQ==
X-Gm-Message-State: AOAM532lZIVjQ95Gy2G9IBffieBTiG1eCiRwt7DFKmv9nJZ7WAnOgBM+
        gYV0JMC0UWckWzRbFELQGz10
X-Google-Smtp-Source: ABdhPJx1vg0jakP/HgcVd2AUX5oE49QIzSMsLLNaJtLktA9SIx3N/u+9NULPdSzr8fuc/uFrkZP/lA==
X-Received: by 2002:a63:1f0f:: with SMTP id f15mr4182497pgf.312.1602874329165;
        Fri, 16 Oct 2020 11:52:09 -0700 (PDT)
Received: from ubuntu ([116.68.78.80])
        by smtp.gmail.com with ESMTPSA id 92sm3865188pjv.32.2020.10.16.11.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 11:52:08 -0700 (PDT)
Date:   Sat, 17 Oct 2020 00:21:25 +0530
From:   Vaishnav M A <vaishnav@beagleboard.org>
To:     songqiang1304521@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jkridner@beagleboard.org, drew@beagleboard.org,
        robertcnelson@beagleboard.org, rajkovic@mikroe.com
Subject: [PATCH] iio: proximity: vl53l0x-i2c add i2c_device_id
Message-ID: <20201016185046.GA16022@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

This patch aims to add i2c_device_id for the vl53l0x-i2c driver.
will it be possible to consider this patch add the i2c_device_id,
so that the device can be instantiated using i2c_new_client_device
or say from the userspace?.This will be really helpful in cases
where the device tree based description is not possible now(Eg. 
a device on a gbphy i2c adapter created by greybus).

The particular usecase here is described over this RFC Patch
for the mikroBUS driver:
https://lore.kernel.org/patchwork/patch/1290148/

Thanks and Regards,

Vaishnav M A

Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
---
 drivers/iio/proximity/vl53l0x-i2c.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index 5fbda9475ba9..7c29d4cae24a 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -143,6 +143,12 @@ static int vl53l0x_probe(struct i2c_client *client)
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
+static const struct i2c_device_id vl53l0x_id[] = {
+	{ "vl53l0x", 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, vl53l0x_id);
+
 static const struct of_device_id st_vl53l0x_dt_match[] = {
 	{ .compatible = "st,vl53l0x", },
 	{ }
@@ -155,6 +161,7 @@ static struct i2c_driver vl53l0x_driver = {
 		.of_match_table = st_vl53l0x_dt_match,
 	},
 	.probe_new = vl53l0x_probe,
+	.id_table = vl53l0x_id,
 };
 module_i2c_driver(vl53l0x_driver);
 
-- 
2.25.1

