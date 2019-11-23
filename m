Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8092A10810A
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2019 00:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfKWXfq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Nov 2019 18:35:46 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:34538 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbfKWXfq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 23 Nov 2019 18:35:46 -0500
Received: by mail-qv1-f65.google.com with SMTP id n12so4349660qvt.1;
        Sat, 23 Nov 2019 15:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/KpiDb9LR0UFpghJdn3NvgOOMBws5emrYI70pah9SfY=;
        b=f3ggcmI44cx3NLECHundIyvAQ0XLc08hmfpoX7Au0CpO56N6MVVkVa97Y4FcHNqEXD
         //b/7NxTpdf+1clYwHoPAklouhwB3sa5DFP/YR6CXp/Ukq1fKFO4Y5/c1FSTWCJ4/wei
         8PrhjAm32y0Js15GcWjJw5h04+4+lgeRBTiepaX2vbjpDrRrC8AB8UtESWP2+o/CcT8f
         gNnQkZK/C7IpBedcwkU+GdINcB6dzg36d7QS2mM1O1isCOqwrAsux4ZstIueFvuYBUAn
         DC/wMBKmtEt0VCthf58yQV0Ua0Ao9l4WDhcGdE2pXke9ifjzrhmylE30Tr3X50F0jfKL
         ESKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/KpiDb9LR0UFpghJdn3NvgOOMBws5emrYI70pah9SfY=;
        b=QBHR31EyhvSi5i9/v9laOImFTE3yq6ofhAgrqLxGaqFCnNc6e+Hn1rpITgUeE/+nWh
         SFIGfNswFH2JuIAWFTwh/Yhkte/fkEedgCgphqxw+L9m7jIgvITGkHpa1aUG9/Rro3na
         dMad2EVkX3HyHuzUHosvPo/sezpNBNgteH4E5KdXr5EgUeKqfuj8Ieafjjx4pO1XTP2O
         MJZYtqmh3Sngl9De+56cPmiDyEmDM8Rzzzn+7iPYfkSmo32mEGePOK9rWm/CKJpqXQGt
         5NNizm2R8KUWTQcs0Adcc9mooB+tWXy6IsMFEncP0B5gg8uXFwUnxWPqqTbaysy/BhrQ
         rI2A==
X-Gm-Message-State: APjAAAVV3M8LJPgAonP6djd0rHQ1WFjqvPchKb1dtHmzQiO0PrOsuSN4
        ZWPi8PsGjPok/4EX/4bfT2s=
X-Google-Smtp-Source: APXvYqw9TpLPbz1zzVNV8wmdFnaYLtygT/vtf9cwyg/y9otvK/BsCF5EpMbEOrlyS3x2gJqdHA4RNA==
X-Received: by 2002:a0c:cdc3:: with SMTP id a3mr4014117qvn.216.1574552145134;
        Sat, 23 Nov 2019 15:35:45 -0800 (PST)
Received: from localhost.localdomain ([177.76.215.166])
        by smtp.gmail.com with ESMTPSA id f22sm1357518qtc.43.2019.11.23.15.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 15:35:44 -0800 (PST)
From:   Rodrigo Carvalho <rodrigorsdc@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alexandru.ardelean@analog.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Rodrigo Carvalho <rodrigorsdc@gmail.com>
Subject: [PATCH v5 1/2] staging: iio: accel: adis16240: enforce SPI mode on probe function
Date:   Sat, 23 Nov 2019 20:35:09 -0300
Message-Id: <20191123233510.4890-1-rodrigorsdc@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

According to the datasheet, this driver supports only SPI mode 3,
so we should enforce it and call spi_setup() on probe function.

Signed-off-by: Rodrigo Ribeiro Carvalho <rodrigorsdc@gmail.com>
---
V5:
  - Add this patch to the patchset

 drivers/staging/iio/accel/adis16240.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
index 82099db4bf0c..77b6b81767b9 100644
--- a/drivers/staging/iio/accel/adis16240.c
+++ b/drivers/staging/iio/accel/adis16240.c
@@ -400,6 +400,13 @@ static int adis16240_probe(struct spi_device *spi)
 	indio_dev->num_channels = ARRAY_SIZE(adis16240_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
+	spi->mode = SPI_MODE_3;
+	ret = spi_setup(spi);
+	if (ret) {
+		dev_err(&spi->dev, "spi_setup failed!\n");
+		return ret;
+	}
+
 	ret = adis_init(st, indio_dev, spi, &adis16240_data);
 	if (ret)
 		return ret;
-- 
2.24.0

