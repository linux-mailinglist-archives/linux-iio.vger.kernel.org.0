Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71BBD7641F
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2019 13:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfGZLHt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Jul 2019 07:07:49 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40734 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfGZLHt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Jul 2019 07:07:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so24636404pgj.7;
        Fri, 26 Jul 2019 04:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/u86tfhQcNUSlYnznWNfROL83FOU2PZDyMsPMgWpdt4=;
        b=Sw1m99dQ1GzjlHLbGqnzu70FxBtzRaQHol/jb6+KaF+HcEpBDJtve25ugTJ+NEPXEi
         kDtTX+WunvJPbELt9OHJZYnNPFKioaIJ2VH4CH6Xk5+UHzDrzAk8Y3cu7e6ekUSKVYqH
         XX09pZfTGhIw6goKE/C0fdiY8CNGHoH9ceO1frZzsKCyPbHm2ukUF28a2bs+plEUM/k1
         RfAF7znQA4+TG8ojLSDg2U5rfd3dFMj3FMnaEfgZun7b99eHlCsO6rK6GgxLU7uh2Ta1
         TbqnfJJeElbqSU73yAnuycdOZKbyGs34VG08povgQtOXmDsT9xYhMddcwW7IFIJR74tR
         Wjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/u86tfhQcNUSlYnznWNfROL83FOU2PZDyMsPMgWpdt4=;
        b=OOEd2tnyeWqu2czXDcUczF07fHu5MI5yDNhc9wbzjAPNl+rKjOjtIS3sIEqg5VejVB
         5l0co1EnxG9hU94v/wrQpWlucWwfUk2rELXs6hwg8l0JsYSD6LUI8sMwg0cqVsdcS7qy
         Ay5nd26PQRYgC76+a/FUIr8HmeK9VTX+PRjCIB8A6FrjkROQFbGmKG3FHtJUp4f00DkQ
         RyncpUfukezn3H0T8eueVVW/3eIMNTKsy6XGocR6sXKOh+XLeDQMFWTOUW2VyZ7soq4j
         efFN4PyV1QUuHEK7qmWh1Yxn4Ek/bDs2xaimP+YedeipRtHDv8wwHnnAkibF17XJdbNF
         6+TA==
X-Gm-Message-State: APjAAAWoYUegsxKbhhrFAoLoVD0v/bv9/2pfMNC9XrEUIqppQ1Uqcapk
        saqTu8b7POyOHruuNqa/Byo=
X-Google-Smtp-Source: APXvYqzTteDe4J3AZvvA/tFoePe0pGzSlEDOJwQ5IIZ4F3KPosMf8GMZPllfopvHebNMUwWthNnTcw==
X-Received: by 2002:a63:5860:: with SMTP id i32mr62745268pgm.124.1564139268690;
        Fri, 26 Jul 2019 04:07:48 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id x13sm55647182pfn.6.2019.07.26.04.07.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 04:07:47 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] staging: iio: ad2s1210: Use device-managed API
Date:   Fri, 26 Jul 2019 19:07:42 +0800
Message-Id: <20190726110742.20445-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use device-managed API to simplify the code.
The remove function is redundant now and can
be deleted.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 0c1bd108c386..4b25a3a314ed 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -671,7 +671,7 @@ static int ad2s1210_probe(struct spi_device *spi)
 	indio_dev->num_channels = ARRAY_SIZE(ad2s1210_channels);
 	indio_dev->name = spi_get_device_id(spi)->name;
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
 	if (ret)
 		return ret;
 
@@ -683,15 +683,6 @@ static int ad2s1210_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int ad2s1210_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-
-	iio_device_unregister(indio_dev);
-
-	return 0;
-}
-
 static const struct of_device_id ad2s1210_of_match[] = {
 	{ .compatible = "adi,ad2s1210", },
 	{ }
@@ -710,7 +701,6 @@ static struct spi_driver ad2s1210_driver = {
 		.of_match_table = of_match_ptr(ad2s1210_of_match),
 	},
 	.probe = ad2s1210_probe,
-	.remove = ad2s1210_remove,
 	.id_table = ad2s1210_id,
 };
 module_spi_driver(ad2s1210_driver);
-- 
2.20.1

