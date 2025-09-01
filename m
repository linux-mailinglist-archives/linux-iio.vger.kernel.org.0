Return-Path: <linux-iio+bounces-23562-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 158CDB3DA57
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 08:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE8F9176869
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 06:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5042259CA0;
	Mon,  1 Sep 2025 06:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaUTsy1F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AB92475C2;
	Mon,  1 Sep 2025 06:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756709697; cv=none; b=ToQh4iFUnuMpH2b7ugxmKYCwS/+mU2dbM40kat32xxRpc4BlME2xFrWYZNrLW6ts1MkBT2HDN0tH2XUcp1C98CcEhgFlRxA4XBzNuV96VdjFe3ToCBvAOlj+6m47uwbai6ENanTbNaQZsvPKwSVqpFqYVnplJ0drrz/6ORLkuA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756709697; c=relaxed/simple;
	bh=GLVelhT9h97w4m/gNH8OT9K8ySnZNsn+XWbkfCQ+VhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jj/JHB2E0YJF02SI1ZMmInblMQuHYj0wC9egQesZSHPX1JK5Zt0BOFzmj+LF2ZXPRAJNb7cq2iVtml7izxCgc48vPk+zReOooT8C19Ed9HaCq8O1xIgM9RTOlI5VZ8V3URi91MzmoEt2JcORGLg+GPiruVSLmqzGlP+RXgu5kHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaUTsy1F; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-248ff68356aso18950565ad.1;
        Sun, 31 Aug 2025 23:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756709695; x=1757314495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oa4pEDtoHfy10lQMQvxNZ4KuYRDe8acSazEVNvbRXKU=;
        b=NaUTsy1FOcFYKX2RXTXCTiMIipuosavyD3qYgU+T3iiCTMiRoLf8itrMNIHu4FmJiO
         wpxIfK3/kXSKOsDESRyTUx0iff9gB22vdU77N29517gLa+ZTR9dhLXmmX1y6wmfs/y8X
         Km3l8ZGpRknMBdELo/F0kos9F3TAmCduqgiCKVjtLwsENIcINuftAH1dWsnGbmQ94BH/
         +fnQucHtpdzXM4972N144K1janyVNPAO151yGjnx0VWJDiTjveybioiKljJlpvWipV1X
         6Qp8yz1Ah9qPJNB8saqqk8/SvoAxwrcTeB0aUZgDh4/oJ8EhQ6O0qw0ycdVoXUB7XPpm
         jjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756709695; x=1757314495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oa4pEDtoHfy10lQMQvxNZ4KuYRDe8acSazEVNvbRXKU=;
        b=CdkpdcGWwLlfFnFJoTyGrb4Ie1oY7XNdwYlwce8z3MZjWaDN69we8Zi+tULBjCfcZz
         4tVqzECaXaY/JvgAgXgZp2FY+UCN6A4hQXxoC/M0qKw9hgOxEqcKfPOiSCwcsQyp1tbX
         o12td/5xCoAXE0widA9kwOMxRylAIFO8yxRtEMi8dZND6/+fVHqIkAgs6C4RTjWi7syU
         zIy3JBuL+Msc7nl5oIZ3CtR4vUX2e7UWCff4em4vaWGNcaUoX0VuBfJAt7knM2TYxAJt
         ZwqqmuHAJav3XGihTu+3EaYZhrwTKOIZVDCKsnwQ9U3TdCHX/EsI7v3dEYcCUzYl/X4Z
         Z37g==
X-Gm-Message-State: AOJu0YzDDHx+yX6+FjBmwBRFjgJD2I6nUpDZLLUKEc1ht5Bulc4pwG4o
	uJzILHZ4/yh9kBgs0ZT40f4+5oTO9HWeNnYXW7aVmUJIc39nAqQ0T/KVA0GaKg==
X-Gm-Gg: ASbGncvnK1g5atopgNwnvb7gUiNYh9dNVcFzWHn894J0v2ddY+dba8dUu6tOkFoHRSG
	nlTBkmcab9w49FnEtllcZs4vcVp1LNfiCIusVg3kisqtcf5VTZM7A1p7qCtpNzJnCxH3KKxpa1j
	q9W7ktccXa1yaoMECjMYXgtjb9kMqyaJDrwIF8F0oMgXysL97kFwRk2kOcumcnYw2jSyztKc/Fc
	GpqirICwPrbDxAZukbKGee4x7IZkHZ3r5UJz39e3aPK56nTTnVNpRXsnGWWiFa+cVLpKhqaZeV7
	QTHlTqOl1U4QDgz18NlpGOp+IDjFb1OWu+yY4ccIuBw/rX+j2w+9qDXN5DcApJnkrN1P++er8Od
	wxMzNFe71SE0yzDwLrjsU4pr4gJjI/6PsvTOGjAycKN6BsvivEhk=
X-Google-Smtp-Source: AGHT+IGx4CAb9dEsJrZI4+wzP+TsLHMibKKDL7czFpcmBFKfNyGQfvm4hdxWScGcNpf1rbRO2pDqhQ==
X-Received: by 2002:a17:903:94c:b0:234:8a4a:ad89 with SMTP id d9443c01a7336-2494486df45mr101928175ad.1.1756709695131;
        Sun, 31 Aug 2025 23:54:55 -0700 (PDT)
Received: from localhost ([77.111.118.146])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-249065939b0sm92717715ad.110.2025.08.31.23.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 23:54:54 -0700 (PDT)
From: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	mohammad amin hosseini <moahmmad.hosseinii@gmail.com>
Subject: [PATCH v2] staging: iio: adc: ad7816: add mutex to serialize SPI/GPIO operations
Date: Mon,  1 Sep 2025 10:24:45 +0330
Message-ID: <20250901065445.8787-1-moahmmad.hosseinii@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: mohammad amin hosseini <moahmmad.hosseinii@gmail.com>

The ad7816 driver was accessing SPI and GPIO lines without
synchronization, which could lead to race conditions when accessed
concurrently from multiple contexts. This might result in corrupted
readings or inconsistent GPIO states.

Introduce an io_lock mutex in the driver structure to serialize:
- SPI transactions in ad7816_spi_read() and ad7816_spi_write()
- GPIO pin toggling sequences
- Updates to device state via sysfs store functions (mode, channel, oti)

The mutex ensures proper mutual exclusion and prevents race
conditions under concurrent access.

Changes in v2:
- Fixed mismatch between From: and Signed-off-by lines

Signed-off-by: mohammad amin hosseini <moahmmad.hosseinii@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 4774df778de9..06567d048a6d 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -50,6 +50,7 @@ struct ad7816_chip_info {
 	u8  oti_data[AD7816_CS_MAX + 1];
 	u8  channel_id;	/* 0 always be temperature */
 	u8  mode;
+	struct mutex io_lock;	/* Protects SPI transactions and GPIO toggling */
 };
 
 enum ad7816_type {
@@ -67,13 +68,13 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 	int ret;
 	__be16 buf;
 
+	mutex_lock(&chip->io_lock);
+
 	gpiod_set_value(chip->rdwr_pin, 1);
 	gpiod_set_value(chip->rdwr_pin, 0);
 	ret = spi_write(spi_dev, &chip->channel_id, sizeof(chip->channel_id));
-	if (ret < 0) {
-		dev_err(&spi_dev->dev, "SPI channel setting error\n");
-		return ret;
-	}
+	if (ret < 0)
+		goto unlock;
 	gpiod_set_value(chip->rdwr_pin, 1);
 
 	if (chip->mode == AD7816_PD) { /* operating mode 2 */
@@ -92,13 +93,13 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 	gpiod_set_value(chip->rdwr_pin, 0);
 	gpiod_set_value(chip->rdwr_pin, 1);
 	ret = spi_read(spi_dev, &buf, sizeof(*data));
-	if (ret < 0) {
-		dev_err(&spi_dev->dev, "SPI data read error\n");
-		return ret;
-	}
+	if (ret < 0)
+		goto unlock;
 
 	*data = be16_to_cpu(buf);
 
+unlock:
+	mutex_unlock(&chip->io_lock);
 	return ret;
 }
 
@@ -107,12 +108,13 @@ static int ad7816_spi_write(struct ad7816_chip_info *chip, u8 data)
 	struct spi_device *spi_dev = chip->spi_dev;
 	int ret;
 
+	mutex_lock(&chip->io_lock);
+
 	gpiod_set_value(chip->rdwr_pin, 1);
 	gpiod_set_value(chip->rdwr_pin, 0);
 	ret = spi_write(spi_dev, &data, sizeof(data));
-	if (ret < 0)
-		dev_err(&spi_dev->dev, "SPI oti data write error\n");
 
+	mutex_unlock(&chip->io_lock);
 	return ret;
 }
 
@@ -136,6 +138,7 @@ static ssize_t ad7816_store_mode(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 
+	mutex_lock(&chip->io_lock);
 	if (strcmp(buf, "full") == 0) {
 		gpiod_set_value(chip->rdwr_pin, 1);
 		chip->mode = AD7816_FULL;
@@ -143,6 +146,7 @@ static ssize_t ad7816_store_mode(struct device *dev,
 		gpiod_set_value(chip->rdwr_pin, 0);
 		chip->mode = AD7816_PD;
 	}
+	mutex_unlock(&chip->io_lock);
 
 	return len;
 }
@@ -200,7 +204,9 @@ static ssize_t ad7816_store_channel(struct device *dev,
 		return -EINVAL;
 	}
 
+	mutex_lock(&chip->io_lock);
 	chip->channel_id = data;
+	mutex_unlock(&chip->io_lock);
 
 	return len;
 }
@@ -322,7 +328,9 @@ static inline ssize_t ad7816_set_oti(struct device *dev,
 	if (ret)
 		return -EIO;
 
+	mutex_lock(&chip->io_lock);
 	chip->oti_data[chip->channel_id] = data;
+	mutex_unlock(&chip->io_lock);
 
 	return len;
 }
@@ -363,6 +371,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
 	dev_set_drvdata(&spi_dev->dev, indio_dev);
 
 	chip->spi_dev = spi_dev;
+	mutex_init(&chip->io_lock);
 	for (i = 0; i <= AD7816_CS_MAX; i++)
 		chip->oti_data[i] = 203;
 
-- 
2.43.0


