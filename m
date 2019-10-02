Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F105AC4A1D
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2019 10:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfJBI6L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Oct 2019 04:58:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51934 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbfJBI6L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Oct 2019 04:58:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so6270760wme.1
        for <linux-iio@vger.kernel.org>; Wed, 02 Oct 2019 01:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CmLXG4bPxTjZzTrvXKweoRTqZA7P9PJe9BBobCWifpI=;
        b=p+4pV1fwL5wiRu10JvmsXwhr/fPZowUsi2e2jE3rmHPtsQV4aj9xj+d3SjuDU7Fvj3
         UeqvgHiSgPkvnTx0wdl2yvW1n9E2pxqPBspUq9UgKg/HuJa8brAGnvmMGMXlCXyzXPq2
         ibhkjSJTIovbVPgpyiJLXFmIJ6BTYSt18o5PTdWsmMYXen6HcGmsu/TyeqxWI+YzWT0p
         9uT8GKNqNnpMzXRgdkix+m25G0oQoQAcBqqnq9AEjykbpBSAC3v4qRRXrWXpdbgjMsk3
         om9PZUq/q13ZPnfV6itub6BVD0QQRfTFlnTZiY29+okGv+Y0oGQCarzL+b0I9+NWxUEw
         soYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CmLXG4bPxTjZzTrvXKweoRTqZA7P9PJe9BBobCWifpI=;
        b=ZBV06SBgKxgUnyNyy7LG6dj2K9+1PPC55fQ2nbE1DiWl+2VfOl+Zbaw18pq/FE4UPe
         LNzAHXDOyVAOHOaiJa5NAcnNkYYyrkdX+H/btxuu79NM8AEL1URq+qKk8a5+T6rZLBks
         HiKAtibTZSTqv5RSaERWILdjzP9AuKwlE5x3IbTl6ilX6il8a1+UFjyaMS0kN59VZk/1
         4yUaZos71e0hNWg6z+BLsv9MCzrVcAiewLOPQtMjdL0ZbXqZBN+G/IUTlAjqiBo6w1e0
         WOnHT4O/7Xycey+WSNXdunbU6IZwndeaWiotLJ0sv+rMze2Wc5LTOZkFvvFZj9VcdHCk
         nHlA==
X-Gm-Message-State: APjAAAUgJ1QrVdw0kieeHp5W5+XbzinUz+RGG3a6e/B3ojKtPNQfJJOB
        bwz3rrCJ/JsN2th7fnVxcQCXxg==
X-Google-Smtp-Source: APXvYqyvWkgBIAqgpGtCM4BIOwtAxm0wEMGIwOSwSyOyi3rWQVrxqpgizmhTk9Wt7y7cEa4onq8dmQ==
X-Received: by 2002:a1c:a404:: with SMTP id n4mr1866027wme.137.1570006688761;
        Wed, 02 Oct 2019 01:58:08 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id b186sm10115616wmd.16.2019.10.02.01.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 01:58:08 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/4] iio: pressure: bmp280: use devm_iio_device_register()
Date:   Wed,  2 Oct 2019 10:57:57 +0200
Message-Id: <20191002085759.13337-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191002085759.13337-1-brgl@bgdev.pl>
References: <20191002085759.13337-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We can use the managed variant of iio_device_register() and remove
the corresponding unregister operation from the remove callback.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/iio/pressure/bmp280-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index c21f8ce7b09c..f22400e1e98f 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1127,7 +1127,7 @@ int bmp280_common_probe(struct device *dev,
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_put(dev);
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
 		goto out_runtime_pm_disable;
 
@@ -1149,7 +1149,6 @@ int bmp280_common_remove(struct device *dev)
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmp280_data *data = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
 	pm_runtime_get_sync(data->dev);
 	pm_runtime_put_noidle(data->dev);
 	pm_runtime_disable(data->dev);
-- 
2.23.0

