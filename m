Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8C1B115C
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2019 16:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732783AbfILOng (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Sep 2019 10:43:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56256 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732722AbfILOng (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Sep 2019 10:43:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id g207so329512wmg.5
        for <linux-iio@vger.kernel.org>; Thu, 12 Sep 2019 07:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2L6nEw3n0siJ/8DCjgw0WGkK1bU5suHRoNfpehW8eSU=;
        b=Z6ECsUYputhDYXn+te2bDfbLPm+7JoT4Ktuj1CAIn6atPgxZnaITVakzQCIhM32M0X
         Jboq57YlD+ZZHGw1NMhHfojkc9C6r38tt58scNujNlG4vD9WzIZbgin8RgXkTPDE/Hsj
         PAMT9dT8UHsWcCXdIdfizUC0S6B0Qp1RYZKjdj/JeUicWBOn+baddEfzg/vFNQJy67OO
         QZOhIzTJRIccalYl019GhgUHveFo7Q9iNGWCm3d/7uA9YUEfKjyVMfj4QoDQfAu6GiMe
         daG7etVMZh2+ujBDUs5dKLC1lihhOoM8UBxC1RAypKWOxsTIPtXIIjjAj1TPt9KZzLnQ
         BOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2L6nEw3n0siJ/8DCjgw0WGkK1bU5suHRoNfpehW8eSU=;
        b=OcryXPI4X9S4SJsMkPPFT6QSEwtt5e8EMFMFGm+UkdF3qoFPP/SA2FnpaF2xc1ppTR
         bF3Rsu/3T7Y5ghQiTsx8Ea1NRw6Zcpm96cdM5Oqe1KbUIa9tzU1Nfv1/isjCO2/j5XhA
         jv57Om46lTUo1KXCMIBwrOC/N3nrmn4NQZaLumN5Cy5Iy82i1NnG6le4CN0348TOvZRs
         7K4Z2i2fS/fZw3wE/9FUkcjZLuM5hjfukRk0dBin0UYJ3F7MuauEKQsrskVRbbh6IZfu
         EEF5tt11Qzazp7hrUNbZWDZtSIGetplliZ1H4Y8R0QvtuXV8heH4apJfJFlmOhMDBqKN
         KfBg==
X-Gm-Message-State: APjAAAVfAhiYAPoBjr4jt1h131K18qJH7FYAVP4zt7ZK1OwYodVlgZlf
        cQsfmCf1DwP6MrKMLf5VVus=
X-Google-Smtp-Source: APXvYqyvDJg6H97dpelGzFnnR8QVTAconGLfJK5uYOqWMPs8Torg527Ehyw34cWpkji3Z8H1Hop+xA==
X-Received: by 2002:a7b:cf11:: with SMTP id l17mr305413wmg.162.1568299414737;
        Thu, 12 Sep 2019 07:43:34 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id q19sm35175256wra.89.2019.09.12.07.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 07:43:33 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH 1/4] iio: ad7949: kill pointless "readback"-handling code
Date:   Thu, 12 Sep 2019 16:43:07 +0200
Message-Id: <20190912144310.7458-2-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190912144310.7458-1-andrea.merello@gmail.com>
References: <20190912144310.7458-1-andrea.merello@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The device could be configured to spit out also the configuration word
while reading the AD result value (in the same SPI xfer) - this is called
"readback" in the device datasheet.

The driver checks if readback is enabled and it eventually adjusts the SPI
xfer length and it applies proper shifts to still get the data, discarding
the configuration word.

The readback option is actually never enabled (the driver disables it), so
the said checks do not serve for any purpose.

Since enabling the readback option seems not to provide any advantage (the
driver entirely sets the configuration word without relying on any default
value), just kill the said, unused, code.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 drivers/iio/adc/ad7949.c | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index ac0ffff6c5ae..518044c31a73 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -57,29 +57,11 @@ struct ad7949_adc_chip {
 	u32 buffer ____cacheline_aligned;
 };
 
-static bool ad7949_spi_cfg_is_read_back(struct ad7949_adc_chip *ad7949_adc)
-{
-	if (!(ad7949_adc->cfg & AD7949_CFG_READ_BACK))
-		return true;
-
-	return false;
-}
-
-static int ad7949_spi_bits_per_word(struct ad7949_adc_chip *ad7949_adc)
-{
-	int ret = ad7949_adc->resolution;
-
-	if (ad7949_spi_cfg_is_read_back(ad7949_adc))
-		ret += AD7949_CFG_REG_SIZE_BITS;
-
-	return ret;
-}
-
 static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
 				u16 mask)
 {
 	int ret;
-	int bits_per_word = ad7949_spi_bits_per_word(ad7949_adc);
+	int bits_per_word = ad7949_adc->resolution;
 	int shift = bits_per_word - AD7949_CFG_REG_SIZE_BITS;
 	struct spi_message msg;
 	struct spi_transfer tx[] = {
@@ -107,7 +89,7 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
 				   unsigned int channel)
 {
 	int ret;
-	int bits_per_word = ad7949_spi_bits_per_word(ad7949_adc);
+	int bits_per_word = ad7949_adc->resolution;
 	int mask = GENMASK(ad7949_adc->resolution, 0);
 	struct spi_message msg;
 	struct spi_transfer tx[] = {
@@ -138,10 +120,7 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
 
 	ad7949_adc->current_channel = channel;
 
-	if (ad7949_spi_cfg_is_read_back(ad7949_adc))
-		*val = (ad7949_adc->buffer >> AD7949_CFG_REG_SIZE_BITS) & mask;
-	else
-		*val = ad7949_adc->buffer & mask;
+	*val = ad7949_adc->buffer & mask;
 
 	return 0;
 }
-- 
2.17.1

