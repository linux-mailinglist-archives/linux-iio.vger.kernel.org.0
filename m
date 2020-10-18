Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B665A291565
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 05:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgJRDbt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Oct 2020 23:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgJRDbs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 17 Oct 2020 23:31:48 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE63C061755
        for <linux-iio@vger.kernel.org>; Sat, 17 Oct 2020 20:31:48 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id hk7so3666033pjb.2
        for <linux-iio@vger.kernel.org>; Sat, 17 Oct 2020 20:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=wIln5grtRgq5Mck9UfG3qywoaDZ8GkdYDqihejYtFGg=;
        b=oOQwqx6s8tKZ83pHfvNvIGEGEKAwoCVfzFVgViK2PFw6ocrA80xYxXCf0RF/pkMCup
         BYZklKZUoNgcuZIEaYO9IvC5uYFhDuhOWE2++QdPoMWyEf1ZrWM9mlvzSkVuirA4dihE
         6GKER3e9ACbk4hKgELtShfgK1vTE2gVBUmsPeiEqO/WpANGsFY1NCmDtSSR2G+As580c
         oHhfYL4ewiSlQGPDJ1HsvVzcEaogfojg+BS+1SS3nwvaMWfuKaS782CvKq/qYmq+Ve0I
         T2bd+Z6a9RW5Nvv2QH0I4MR7z2Ome6p0x6/SwxfmyZDTukkwQYRGF7DDCSr6I48tFg5e
         tjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=wIln5grtRgq5Mck9UfG3qywoaDZ8GkdYDqihejYtFGg=;
        b=LzTtOUBPhwAccaTzScJVk+qD0JrsOa1wq/XywxuWerYHEc1kDbRHMEk4kJAJd0JrXX
         sP06xtacgxk6HLXBr9fkLDJjfsj3Wezbens7VscCmRauif2B/5uOwt82tP9xiPge3ce9
         6ndfzkK8jCcTz6jkdVNnFLwE/Y9VJb0AQpOWQaLiwT9xGFd9/UROSCpenMgPZxbUBmyu
         MIokqDTD1lNwE/4e1wye09yXI3KwoTVzhxvKB90eYhXmqcgGwsxnRTeDCjTJfJEHXzBR
         EjO4310kmFrPKktwnquqE3N5edg5ysNh8ZQJFrqlVPUWOxucHFBIqOSE+tEKKqJIzVhV
         cx/w==
X-Gm-Message-State: AOAM5312fweKlo7/p1obSVdyqQdqlppUIyEciAfSVUrKtrDh/+lYDxt2
        TbAZPEswenFSiZVCSZjMcjsf
X-Google-Smtp-Source: ABdhPJwMDv33XLv9tCD40vQMWFnaawizqiZm1UmoaQS+g/B9M3YJGYeD1A0CPHDkgpB0xTS9e6siVQ==
X-Received: by 2002:a17:90b:228c:: with SMTP id kx12mr11305705pjb.215.1602991908213;
        Sat, 17 Oct 2020 20:31:48 -0700 (PDT)
Received: from ubuntu ([116.68.78.80])
        by smtp.gmail.com with ESMTPSA id b21sm7137318pfb.97.2020.10.17.20.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 20:31:47 -0700 (PDT)
Date:   Sun, 18 Oct 2020 09:01:42 +0530
From:   Vaishnav M A <vaishnav@beagleboard.org>
To:     songqiang1304521@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jkridner@beagleboard.org, drew@beagleboard.org,
        robertcnelson@beagleboard.org, rajkovic@mikroe.com,
        vaishnav@beagleboard.org
Subject: [PATCH v2] iio: proximity: vl53l0x-i2c add i2c_device_id
Message-ID: <20201018033142.GA27793@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

add i2c_device_id for the vl53l0x-i2c driver so
that the device can be instantiated using i2c_new_client_device
or from userspace, useful in cases where device tree based description
is not possible now(Eg. a device on a gbphy i2c
adapter created by greybus).

Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
---
 v2:
	- fix commit message
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

