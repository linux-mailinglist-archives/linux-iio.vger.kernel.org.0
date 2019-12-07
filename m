Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63303115AFE
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2019 05:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfLGEyL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Dec 2019 23:54:11 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:33817 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfLGEyL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 Dec 2019 23:54:11 -0500
Received: by mail-ua1-f66.google.com with SMTP id w20so3736622uap.1;
        Fri, 06 Dec 2019 20:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IiFK9BAduFHna34DQon87G4FreS7gq1kGZB1A1KnXt8=;
        b=B1z22Lhh9VfS9y96LDb+/zD+DLGmgwCbnKJoVsVQNPEdnKtyDwwaoweZBDk1JO106U
         lqYp0tK7lfgsLI4kTrC15itURVO5/25IyjlDJ+LRiaWinA67W2nZh8dCXRJfT2f9yQnI
         evcCeX0jmzi0DWPkaTSaxPUDlCDpwS+O+CIf/pga0RoGEMtP3ruJ2D1J8y+Oo3EKhV+q
         1KzeXbdiFSnYzVuqQ5mMUY4ot2Vwvx+DW1Jou+Mulzib8IkoJajb91j2OvR7QVy+z055
         KfojXyMGJoPai0FgwkoluJAkr94gYhYK1Tzsc5SqWo17FqrnbaPkWh0PpsqRkWzo+qQ/
         vPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IiFK9BAduFHna34DQon87G4FreS7gq1kGZB1A1KnXt8=;
        b=IOc22fzj3dXAOcL5E20njJIOKNSWJJocAG8k3COvKfOFD4wMghdWZV66/MESeySdCQ
         GmLYHMy9fDc4LUBrGvVO/Oyw1yBt9/dmWtYubEKo4QRAmjdQb6KNDEHSsh7RjAMBjGER
         fyr9TkjDJckdzzIKDZEWnPa82lPG9ysxg+shFAB0duLZJ14azAbQ2G5osLAXm2w5OuzY
         JPoR9KIxqLPJadE7RkGJ54/5QCfy7gdNI2cLwd5pyD/FthldtYX/3t8be2U8qMmCMTAj
         DfXjm0nba9sGi37bwpvncjHNJHFT5vON2H58LoTLMwZ+0nHCcQGgKqj3ShCrhxew817P
         YCjw==
X-Gm-Message-State: APjAAAXHe8cXsG/JGTPqTXNUEsGMEKxFcWN8p8YmHTs4Q9xXefOghnb/
        RyZoUhyApBP0Oq0/KrJk00E=
X-Google-Smtp-Source: APXvYqzcU+qHwBoWF6V8jXH/kcw3HOHOmuN+vu+g7aB6s7KogEati7PJZ06qZOY8EV/W68ROszZyBQ==
X-Received: by 2002:ab0:46c:: with SMTP id 99mr16117574uav.134.1575694449985;
        Fri, 06 Dec 2019 20:54:09 -0800 (PST)
Received: from localhost.localdomain ([177.45.184.74])
        by smtp.gmail.com with ESMTPSA id w132sm8156205vkw.46.2019.12.06.20.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 20:54:09 -0800 (PST)
From:   Rodrigo Carvalho <rodrigorsdc@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Rodrigo Carvalho <rodrigorsdc@gmail.com>
Subject: [PATCH v6 1/2] staging: iio: accel: adis16240: enforce SPI mode on probe function
Date:   Sat,  7 Dec 2019 01:53:38 -0300
Message-Id: <20191207045339.9186-1-rodrigorsdc@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

According to the datasheet, this driver supports only SPI mode 3,
so we should enforce it on probe function.

Signed-off-by: Rodrigo Carvalho <rodrigorsdc@gmail.com>
---
V6:
  -none

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

