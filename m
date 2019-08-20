Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 689F596213
	for <lists+linux-iio@lfdr.de>; Tue, 20 Aug 2019 16:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbfHTOLw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Aug 2019 10:11:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32781 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730115AbfHTOLw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Aug 2019 10:11:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id u16so12579494wrr.0
        for <linux-iio@vger.kernel.org>; Tue, 20 Aug 2019 07:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=FGBKHCq8FJWMnIUa/LWFL4TzsPl3MOXhcThUateMRtc=;
        b=f3bIV3SrHFrMQrtixm3U82rRcligpygZElE9yXd5V8V9ltf6yCrcMipHXrommhcqfw
         TFOHb/OanU4gCVrKHQ4rz/c+Lfhl0tvYf7X1dwxm6Wgsb0V3lZi6+l3NjxduRxirIBhg
         hWW408Mo9CNtLPe2K1XsYTiZwLTBeRtkzcdT6kM94Gw7kC4ZCx5uxEncz8qyBoj/iayH
         QSjw5kDf4YeSbhEFMhXZb9Y5o+cnR5cHW72PjEkakxrM2G28a8rEre+NOZ/qpC3DNmKh
         lUQzqHDbg+0ReV5HhEvmxRDpMVa7i8/eh+1DlHByywQhWXJivmNVoag839ISQcYEypA3
         OXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=FGBKHCq8FJWMnIUa/LWFL4TzsPl3MOXhcThUateMRtc=;
        b=trqe4JEdlFfnwer+MnG9QLjTbiNXCV07V20NZ3ogZ67Mf3wcJdOoYZ0Y8/H/vsNb7X
         tL8yn/38Ghu+/S5woUbVLUrv3ETh3YtJQUVy3vQR/6gMRwOQgfEF5MJcy9XH/8Df5Dr6
         vaSBMJn4G0QMKLDFAygbM/yY/+p4fBDKLvbcBgFi81Tua4zwPueHHF4rZDSbbIp433ol
         G2b0+3psbPDDjQVTbf6L0d17SltNuOjGJ2iWgEmGGQTpfaVsoizzz/9m5CobF+iAwNtK
         sGiBTXMc5in4n4XWLfZU3Y0HmTprXoWZvzpG1NJ0XT3GzjZwhBDP4O+0QT6Xs2Ri7u1S
         uCYg==
X-Gm-Message-State: APjAAAXmMoaIBrbrFYk+LULsg5OUKIpdNoxGNMTDS/43miMaAlvzkh14
        ocL7AYhBXtAIKV68XCH9PJw5hw==
X-Google-Smtp-Source: APXvYqxobUNDMTRwNWh7KrFllFIt6Sw6gQaq/G0HklprIHThax3CILx4Cq6GYMtvbluPatyRvV4Qqw==
X-Received: by 2002:adf:ef05:: with SMTP id e5mr34863140wro.158.1566310310222;
        Tue, 20 Aug 2019 07:11:50 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id u186sm229705wmu.26.2019.08.20.07.11.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Aug 2019 07:11:49 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, linux@roeck-us.net
Cc:     Colin Ian King <colin.king@canonical.com>,
        linux-iio@vger.kernel.org,
        =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: [PATCH 2/4] iio: adc: ina2xx: Setup better name then simple ina2xx
Date:   Tue, 20 Aug 2019 16:11:39 +0200
Message-Id: <e1a9d7c5f94a4942a97a242e530a3bfdda8bbc74.1566310292.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1566310292.git.michal.simek@xilinx.com>
References: <cover.1566310292.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1566310292.git.michal.simek@xilinx.com>
References: <cover.1566310292.git.michal.simek@xilinx.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On systems with multiple ina2xx chips it is impossible to find out which
iio device is which one based on probe order. That's why it is necessary to
setup better name based on possition.
The patch is reusing dev_name which is setup by core with client->name.

name char array was setup to 128 byte length to correspond the same name
length by HID device.

Before this patch:
iio:device9: ina226 (buffer capable)
After:
iio:device9: ina226-3-004a (buffer capable)

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Also id->name can be used as prefix. On ina226 output is the same.

Also I am happy to change that space for name will be dynamicky allocated
to save a space if needed.
---
 drivers/iio/adc/ina2xx-adc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 37058d9c2054..7c7c63677bf4 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -146,6 +146,7 @@ struct ina2xx_chip_info {
 	int range_vbus; /* Bus voltage maximum in V */
 	int pga_gain_vshunt; /* Shunt voltage PGA gain */
 	bool allow_async_readout;
+	char name[128];
 };
 
 static const struct ina2xx_config ina2xx_config[] = {
@@ -1027,7 +1028,12 @@ static int ina2xx_probe(struct i2c_client *client,
 		indio_dev->num_channels = ARRAY_SIZE(ina219_channels);
 		indio_dev->info = &ina219_info;
 	}
-	indio_dev->name = id->name;
+
+	/* Compose chip name to unified i2c format */
+	snprintf(chip->name, sizeof(chip->name), "%s-%s",
+		 client->name, dev_name(&client->dev));
+
+	indio_dev->name = chip->name;
 	indio_dev->setup_ops = &ina2xx_setup_ops;
 
 	buffer = devm_iio_kfifo_allocate(&indio_dev->dev);
-- 
2.17.1

