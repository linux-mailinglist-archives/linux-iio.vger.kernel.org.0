Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265FC291E2B
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 21:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731690AbgJRTvT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 15:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388172AbgJRTvS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Oct 2020 15:51:18 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCC8C061755
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2020 12:51:09 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a200so4706144pfa.10
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2020 12:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=sIt/5JujlB6JFqG5FlI8hqoFH66bW6x+4VT1ughej00=;
        b=BQxDadjfsCLiik+IkvTtZtfyMyujpv3pb63Qfonz9b0rwxX3lVmQzy8ORjjyFg/In7
         q6wgDrzB77BzoE8bi4YJ6yKmUFLJjFk0439ViEerofZRpynMnjxWrX9kgalhzcZlQlpH
         C1aId5zKCgjYsiQzvK+mn9AI61T8Vy4JVaM0ocE9utj7/3E70DMl+P5t+6sKVc2WKPwH
         LBu6dWYq2mSIk/KleOFa+AilgUf+q1guOS5SAi4qnRT6wnlIK+J9PKr6xhlYtIpFDpfP
         E675QwMJGJkoDO4bLPbyHySakLrrCMStB1tOTf0lkaTU/wP5gUkn05B2WiQs9rjJ3ifb
         4EBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=sIt/5JujlB6JFqG5FlI8hqoFH66bW6x+4VT1ughej00=;
        b=a4x2sMQrgwlyb/CK6triceSAFdlOzyiEwJ16UrY0QsNGEqsmVh5o2cMnz0cD/ATNnt
         KNYXXhXuVx2Cl9bSQjqYQ8JI8gCXnHEk7HzVpxScO+KOsDbV1eHB3Jhq/beOTHXXMxBs
         wTdqWh2udm8V9JUCi53Qup2SqgA6QdZeDa3Pq+53vxxU/F6O8yYKsMGva/xeG0W6N1Ib
         sXA3xqIgiaxw781CcP7cBh99Up/bqZGMqE+reTgONgiAcxR80UWF3VaCm15esDWLjvEa
         UeceoJrN334AmFKzPmVW+UlVaj+Fp34x/0Q+e2rd3aPFCdgOS/9nBfhE/3H8vyHtHqjF
         /Byg==
X-Gm-Message-State: AOAM5303Ig9cuIXIrjhb2jmk77DHxVR7TKeg9kiaAO+L56s0jk2q/E6W
        T/IvWOsPXTSkX4YOE0a6WAVX
X-Google-Smtp-Source: ABdhPJxpgV6cZKslMeZEvYR4Q87Cs7jyaSon4Vn89HymTfEufCrfQsGFqlRJT54hI0hIvBA54/3+lQ==
X-Received: by 2002:a63:1e02:: with SMTP id e2mr1664417pge.74.1603050669224;
        Sun, 18 Oct 2020 12:51:09 -0700 (PDT)
Received: from ubuntu ([116.68.78.80])
        by smtp.gmail.com with ESMTPSA id 23sm9132167pgr.53.2020.10.18.12.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 12:51:08 -0700 (PDT)
Date:   Mon, 19 Oct 2020 01:21:02 +0530
From:   Vaishnav M A <vaishnav@beagleboard.org>
To:     andy.shevchenko@gmail.com, jic23@kernel.org, wsa@kernel.org,
        songqiang1304521@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        alexandru.ardelean@analog.com, matt.ranostay@konsulko.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jkridner@beagleboard.org, drew@beagleboard.org,
        robertcnelson@beagleboard.org, rajkovic@mikroe.com,
        vaishnav@beagleboard.org
Subject: [PATCH v4] iio: proximity: vl53l0x-i2c add i2c_device_id
Message-ID: <20201018195102.GA814713@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add i2c_device_id table for the vl53l0x-i2c driver,
helps in device instantiation using i2c_new_client_device()
or from userspace in cases where device-tree based description
is not possible now, like device(s) on a gbphy i2c adapter
created by greybus.

Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>

---
 v4:
	-update commit message, add punctuation
 v3:
	-modify commit message for readability
	 as suggested by Jonathan Cameron
 v2:
	-fix commit message
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

