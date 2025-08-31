Return-Path: <linux-iio+bounces-23542-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33812B3D42D
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 17:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F911899FFC
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 15:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E0F2080C0;
	Sun, 31 Aug 2025 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4YqOtBU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEC926D4C1;
	Sun, 31 Aug 2025 15:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756654675; cv=none; b=SJf/KWWeqw3YxTSvmvVgv6aJhUd2IteJBceZFpD+Sa6tLdvqQcw8pH+lMjLyFVjl+cjvSvbbfTs8T/25SPTcTmpFliPRYOww65AS6MtLnh7eXFjVX4MNgdMKReTbf8xDVcHQ4qC+FZ1ZULVCmi8GjlIbIhVNr93TKpjrKieeeZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756654675; c=relaxed/simple;
	bh=GWYrJHPDh7pVNYHyuvB0gKyzXu4ERH+DBshpNI7vJmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hdBltnPu0eydJK/IYT+oZ7vaMh0P6nql8Y0LWEdzKUSLXSuwjE+/PK3AsQ+xd4Rzt6IsdEzIVkxWZDA2c7OIcfFW+mHONl8HHgKnMNLRSXpzpQacBFqaDRyJxML5tdxjhtLrZa3mNWKDCVp7fYK2Io29JwWZTM4lWU65tA3QdIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4YqOtBU; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-248e3ef1641so22886035ad.3;
        Sun, 31 Aug 2025 08:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756654674; x=1757259474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OFDEYQJ8obf6Fs8A+TsKrId3W5WmbK7rR7VQyl/qxPk=;
        b=b4YqOtBU/5pXoHqy5868Ay0KYPma8jjaUbfpHApFMaidiVTW3d2ZVEV5UpkvICqdyh
         I9S4Re2g3nbx+zRyTZGukjm/G3y2qs4b16bwK7RjZ9L6rnXLuhT9LKhpSDM+7MdrPLI9
         ba6UGbWEFhVUO3t4h2nBTz3G4QRPAI7xv01GJgWLWhVv/mj+4nacg5Qb/bcykK2M/WE5
         JmRrHYp+Ct4XgE4hq5pfXrkwPBB8ZQOqlapbvuqqM9GW6w7dt9e5/yvm964oo9BgNQ3s
         ft90hkHre+irLgyTQGtFyrOaWY+meAoQV65e/DFGaJ+yJil51KRTV+5QX26UYQAcQ1Xe
         m3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756654674; x=1757259474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OFDEYQJ8obf6Fs8A+TsKrId3W5WmbK7rR7VQyl/qxPk=;
        b=spCGVlK/6cBuX8khEXQsU7rrmpT8h4eoAC+693asvQKL5qaoiePpQSynV7bqIUdkTg
         fceUiBxIVjJ+cyghiLgWQ+YKU1xIWr5fEgaD6Jbfv54soJ7sejGqJrY3OJnNn0gGeJSV
         oqNNBk/nqdF0Cy+e4VFWEdu4bkybXOF+nCNKPFXB70cvBCGxMzduQQ05AfQQNIpKqztv
         NQTARoz3xZaCnJxCorHwwhF9lvwHnEVoNLmwnEjXsrXT4NmldeweQWdV//vJwX6DArW3
         TZT+gezfXlnxfz3XoWAlUgvAIB9Ty49LAr5z2F/3+DLEFzFrQF1yue0qNpM76fOI44On
         xL0Q==
X-Gm-Message-State: AOJu0YzLfTMfOQ8n/zjqI3cCxzX6ZA/GmXbEamfzAJO2qpmPel9gVdmQ
	sbC25xG7XBwbGgu0EJxg1aQQbKhendMKlT8UQA2J0WrvN7gKqk7Rf4AUZJLaJg==
X-Gm-Gg: ASbGnct80MZWt992nIamtG88MJyJjdmqixbmRyjngtqZbr5YxJr+LF8VnkQM7h3CxZu
	vl4KlIGfXIetDpASA46rMJuNXVzaY/65H9e5VL0iipwguhYYQ4fHjtMtZ4MoaYZ3RSbr1a9uxa8
	ONNZFuIaA//cLMFgKBPmJlWvDxYxej2+0eHZxMERGKYf2XY7EcQpglUCxiDvHxYj1aY3yOyBqD+
	WV0oeCbhMR9CezUBjagdZm0sLfbUVvaL93eYgipjwookpdvFg/NFGexhV4SEztniMkvBfDZx99M
	QYBRcrHIP03HzYHXz5xxeiVy3LfOAd4uei4PQC8oZiwUehLmjs/m4HqlzaWt+Ah4fvsv87NHuTD
	Idelt7eddlskH7wp+vGouN1rO1FMlRHBJ7K/r71yC
X-Google-Smtp-Source: AGHT+IGpbBF5o4IXojUbE0bOixBdQ9gLAAiA5oWG1d3jT5tqYR85dQTBK6f/cjTSAmGcDu4G8TE8LA==
X-Received: by 2002:a17:903:38c7:b0:249:2d84:f416 with SMTP id d9443c01a7336-24944b766eamr65600685ad.58.1756654673646;
        Sun, 31 Aug 2025 08:37:53 -0700 (PDT)
Received: from localhost ([77.111.118.146])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-24a92f897d8sm38927595ad.24.2025.08.31.08.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 08:37:53 -0700 (PDT)
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
Subject: [PATCH] staging: iio: adc: ad7816: add mutex to serialize SPI/GPIO operations
Date: Sun, 31 Aug 2025 19:07:41 +0330
Message-ID: <20250831153741.8820-1-moahmmad.hosseinii@gmail.com>
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

Signed-off-by: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>
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


