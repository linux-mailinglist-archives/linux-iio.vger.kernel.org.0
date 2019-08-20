Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B200C96218
	for <lists+linux-iio@lfdr.de>; Tue, 20 Aug 2019 16:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbfHTOL7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Aug 2019 10:11:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41569 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730229AbfHTOLz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Aug 2019 10:11:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id j16so12563428wrr.8
        for <linux-iio@vger.kernel.org>; Tue, 20 Aug 2019 07:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=RwUl0tIvIWQJjsPo9IUx0TKimtG4MbaxDyHxqkSvC5A=;
        b=ft6JmqWgSOSM4d24X1q0N2J56uYy/FU4k08SXAeJ6pgdaXJ5cYbZX2WQ70C3sFnKQV
         4iXZe7h92gIl9tNrovxEYNUXt04plhsbh4BJqzGndjegbiJfrB7N8xhJCG7ZvR1SACp2
         2/VVKPaWXVbDNH6tijKiFQui4GLWVWScAtnfxqMAHfmJrd4GRQlK/NOJn59hI/ng/kYf
         fOlUF2vWVCwdU9uOBqJSgHdWj5Qe8GwEov/sD7ufWQpV2T2WdzrCQXAy44eL123/Vasu
         1hPW9gsS/nzyJbhHGtH25EisfEton7FtFTT1lySEcdQk8smMI55NJB2JUdY5gRJKv5Kz
         G5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=RwUl0tIvIWQJjsPo9IUx0TKimtG4MbaxDyHxqkSvC5A=;
        b=HXLg4mmC+3AaPMPl2jVSegQ0qvOknZEgiDat+Rvr3gCutmXn2RPOHobfEGLdRiNcU9
         lT6q4laFV98LFNpg6CvZKqpQm4zHdtSb589X62IC/ulpQfldzT9lMMO0gN6J01NDMbRn
         9MoVlVeWNpN7waVFez0odBhAQrx0uxy84kMxIx5br//vYwdntLcmQe7aw5pDEaxy8H96
         b1Ru9lH0nfOc/oeQOUk0Edk8vbOtPAq3mMUmHHNum/L486fn1T629ZOezqejSeBSQQDF
         uoh8H06+kmYM6PcZhnODh9V7kA3SC0syWK8IXEVDBM+ysiAdSY9Bs0FZm8W/j4TKX4dg
         FGwQ==
X-Gm-Message-State: APjAAAUxMC5FiikCCyGo3Ip1/gIVjBtUicnxo1zapPJpowdUPZc+y2dD
        NrvNl/fFiVuGYY/dbKkpsJmsRA==
X-Google-Smtp-Source: APXvYqzEIh6wkeygw1xRCd3/+HZRcK6Zad12CN+JWvrC+aemT0aFfIfzYCUHEgz9nu5K7xswVg1Ejw==
X-Received: by 2002:adf:b64b:: with SMTP id i11mr35140281wre.114.1566310313897;
        Tue, 20 Aug 2019 07:11:53 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id 2sm84660wmz.16.2019.08.20.07.11.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Aug 2019 07:11:53 -0700 (PDT)
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
Subject: [PATCH 4/4] iio: adc: ina2xx: Use label proper for device identification
Date:   Tue, 20 Aug 2019 16:11:41 +0200
Message-Id: <0542b562a813c5c22c42484ac24bbb626ac3c022.1566310292.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1566310292.git.michal.simek@xilinx.com>
References: <cover.1566310292.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1566310292.git.michal.simek@xilinx.com>
References: <cover.1566310292.git.michal.simek@xilinx.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for using label property for easier device identification via
iio framework.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/iio/adc/ina2xx-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 7c7c63677bf4..077c54915f70 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -1033,7 +1033,7 @@ static int ina2xx_probe(struct i2c_client *client,
 	snprintf(chip->name, sizeof(chip->name), "%s-%s",
 		 client->name, dev_name(&client->dev));
 
-	indio_dev->name = chip->name;
+	indio_dev->name = of_get_property(np, "label", NULL) ? : chip->name;
 	indio_dev->setup_ops = &ina2xx_setup_ops;
 
 	buffer = devm_iio_kfifo_allocate(&indio_dev->dev);
-- 
2.17.1

