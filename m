Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CEC290B80
	for <lists+linux-iio@lfdr.de>; Fri, 16 Oct 2020 20:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392584AbgJPSlb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Oct 2020 14:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392383AbgJPSl2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Oct 2020 14:41:28 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147CCC061755
        for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2020 11:41:27 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id v12so1733867ply.12
        for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2020 11:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=vgfZNuxhTB6LIQi5jI9sxC2FrJ4hpMVJpn22n3RL3sU=;
        b=EtbIQ8ZriIQTqP36DkwYzE/5+pxL1QGJ6spiErQinfSV2JEY8uKd/zIAAfH1aZyNu2
         1sJUpP95JxpsjYFH81XeI2Zxlp6OP0fe7R3nubORhgziFJVa9s5AElASphijnCLHRAxp
         7354v7ByD1orxpW8ZwOvwMdevhaD9VvksdpiAIaiR6u3V9M/gtZc1EU+wmnB6arkRmBr
         ZYmjrMgdPQzC6FGZyPk29dm62Pv97dqEqdmLo+1XA14MOys/USaeR3vsOw92hR7Nyo6Y
         O/qxnR0E9kyYfc535u1D1pt5LibtCJ1P7AR8uJwgipr99dyRt7m/c/PjIQy017sIK5Vs
         TTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=vgfZNuxhTB6LIQi5jI9sxC2FrJ4hpMVJpn22n3RL3sU=;
        b=ftSBvS/dDVrR2+ydFl756z/5VD1Rc6OYYmTttIuvFTQVDYrIVvlmabDHF8c6DeJHmk
         sZrV0evprOEEkObr/KJFZIrMeGp3ZxPNv7ApZn47KwqN6NTuo1swVTYZmB6oK5Je93uQ
         h+msnxDRV4Zwlph0TV5v+/AZt1r+eO7XZ1qzOlIPUbMoAtvvPK7dRyduJ1rTXFjEEy64
         FnSuS1yVrmvkVCTpe+16KpNVwbOypgpvZ04bqS+Vm+tWtdXaoqrRYihg1JCC6Vv4+u2c
         gXoEsCrfkKKTowd4Un3H2TXi4SgdT626QENTY+AgJP3P9gKQEPmUWD/tax7SCMPq062k
         q/EA==
X-Gm-Message-State: AOAM533ouE7Q+f7eYF5yrNZi60RKKC2X3MV6gw4q1r3G0QbcTYQGJP35
        UlhTaXh00WHKcXNQnQpUwT+i
X-Google-Smtp-Source: ABdhPJzJrFDAYautm2aySUToxds3KG0uCXq61fcGXlXxD2jvsrZnML+8Ovo3RyKEEA2S4FStoPeVYg==
X-Received: by 2002:a17:902:b595:b029:d4:db82:4403 with SMTP id a21-20020a170902b595b02900d4db824403mr5448769pls.49.1602873686692;
        Fri, 16 Oct 2020 11:41:26 -0700 (PDT)
Received: from ubuntu ([116.68.78.80])
        by smtp.gmail.com with ESMTPSA id 32sm3569344pgu.17.2020.10.16.11.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 11:41:26 -0700 (PDT)
Date:   Sat, 17 Oct 2020 00:10:42 +0530
From:   Vaishnav M A <vaishnav@beagleboard.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, alexandru.ardelean@analog.com,
        linus.walleij@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jkridner@beagleboard.org, drew@beagleboard.org,
        robertcnelson@beagleboard.org, rajkovic@mikroe.com
Subject: [PATCH] iio: proximity: as3935 change of_property_read to
 device_property_read
Message-ID: <20201016184002.GA15797@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


This patch aims to replace the of_property_read_u32 for reading
the ams,tuning-capacitor-pf, ams,nflwdth properties with
device_property_read_u32.

Thanks and Regards,
Vaishnav M A

Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
---
 drivers/iio/proximity/as3935.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index c339e7339ec8..7e47ddf89a56 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -355,7 +355,6 @@ static int as3935_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	struct iio_trigger *trig;
 	struct as3935_state *st;
-	struct device_node *np = spi->dev.of_node;
 	int ret;
 
 	/* Be sure lightning event interrupt is specified */
@@ -374,7 +373,7 @@ static int as3935_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 	mutex_init(&st->lock);
 
-	ret = of_property_read_u32(np,
+	ret = device_property_read_u32(&spi->dev,
 			"ams,tuning-capacitor-pf", &st->tune_cap);
 	if (ret) {
 		st->tune_cap = 0;
@@ -390,7 +389,7 @@ static int as3935_probe(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	ret = of_property_read_u32(np,
+	ret = device_property_read_u32(&spi->dev,
 			"ams,nflwdth", &st->nflwdth_reg);
 	if (!ret && st->nflwdth_reg > AS3935_NFLWDTH_MASK) {
 		dev_err(&spi->dev,
-- 
2.25.1

