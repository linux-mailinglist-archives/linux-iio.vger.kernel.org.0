Return-Path: <linux-iio+bounces-19412-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CC5AB25A1
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 00:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9FC17A80A
	for <lists+linux-iio@lfdr.de>; Sat, 10 May 2025 22:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF43D2192F4;
	Sat, 10 May 2025 22:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FK8p8nZU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D104C2144C7;
	Sat, 10 May 2025 22:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746917083; cv=none; b=miaHmxwvd1CStIamuJ2GqAOE8e3Pp0+HnYT73hNFkjHzHvGat3C/AuV7PL+6p1hXR5AHiqe0hTGSh+L9Zwh0igNag0V/qciJcDuEXerBKpqxRDDtDZ2HlU/Cl71RjlWBwBKfe3nKwne52QNMms4f75nsJ37tmsbwf1KlRCV2klk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746917083; c=relaxed/simple;
	bh=nD3kMmYbQmRIukyhs5O2pJl0UAXAPycvgRVQ22eP+sk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k1cfAla0nMcdSmysbX6FDec3E00CiNotc6dOp1aEUrYqT+ZaQrWLLwDPgrtRVz/NBpj9syBNH4ZBwWfWeRqrw9yHl3T+K4KRNhhb3fWL5Iw3yuXHoJDLR1TlcPKKUAvqQ0M17uAnJk+lKPJTYO8LwKnOnDbLbFJr7cpNlMf1O1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FK8p8nZU; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a0bcb1f1afso410742f8f.0;
        Sat, 10 May 2025 15:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746917080; x=1747521880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZLhZirtRkSbpqjTR8RiHx2rLb1iz9QcvFtV8hE/w7A=;
        b=FK8p8nZUZIVduWeirPSPn+xxATtPZnILHBL7uMWgNTQdgVBitgZDtMq7J7WyvqV/F6
         GXQ2GeIOS5bkixxLgCdPl57zHCeY7PbiDteENx+v8TavORkMv4BtVJAR4TXN7W1arzg+
         /dMIaDQxDemDrE83u9oKHRMsYzAlmvHd0oGQs31lJpjMn7HGUyM5ci2dlOi67G7k64Ub
         g5sHdKyDBSVqXPvs2Q2bd5c658UoBnpg+giccqUETM0QtelOal9j8L9KlmbfzazUr3We
         EdkuBIIGABuYgDpJbVZnRMSo4miyJMcGo4g9WINjZLLuIo+Pch/7Sj5rcw2gnV3BU5BC
         TEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746917080; x=1747521880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ZLhZirtRkSbpqjTR8RiHx2rLb1iz9QcvFtV8hE/w7A=;
        b=hIU0veTSJ6WZCH25/7To3M/dfIyU9DcFGkbcjbMNtuUkPj+Jwuo+qT9AC7dxVX0Zkw
         lI3JRwIMO+/X1JFKq5ZeqnCjd4FEX+nDDcalVvTsXDs6yQUsvdb4qFIB/49Ygz/tpV+/
         YcFGzeG+gqTFb3wfjdSS3wygwZot151ChFwr6oqk+cpTjdIqqDduBLvjwOZzfj95wqgQ
         FyCmotR+lTovSj1BU5E4Ux/FzoIP8woqa2r/H0SeVC00/FwYe5aaO+1xI8QyNFl5MwhN
         qjoM/k99Ec005qTbIzNJkCM5oZHRFW2HKKD58Ac4A66xjlq06iDdlgbwAJAR3uhsj1zo
         uNmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWph+upH8ku3tcSiqZxnNilrR7aa4CMaDlfn7uZsXmVlc0XYv6Zgz5JGkr4XYYu0KD3/6YtdDQv7Yzzmj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YygmAdbir15tusPtP1gshbHSnMq+3xGYCpaUPEVnfPEX+V9hhsk
	K4c13aDA20dIvBmfuNWHOAY8IYtJyePQ9znv7rOoFiqrEFImoDiJ
X-Gm-Gg: ASbGnctjPALlHr3Ix3AlgH/QEEdHomHmGNmRVV2yMv8Zis9uE6Xe2dvp64ggGC6A0NK
	H+9lngcFFwQNE7V3J4wO7ZrczDC/7est8snBTZdlw6KFbUomrC9f1F89nSYBssqRIPxPEJIMt5U
	UTyIP6thQDLNH78Y+xXIIp833uKjFL9KwMaZEpu8fPnAS8no/xQF96UYzDFo4Rnlw/KTrRe8Ake
	jOGzaepl4pxODtvzAYPMGkWTazLOx9BGaxL6uQ0HAIgEjZyWCHLXV+X5o+bUXgPBlUheJVPdpjt
	uwfda/EC12toEmpg94LBm9gSdfJv4D8LxXqz3QSYYMVQWtfJVQjRJz+1DZElaWZK9OsIr0hFyq8
	VM/LyG6YsF2/NpoMhRGFmuw==
X-Google-Smtp-Source: AGHT+IF34pL4GhZChggXGyxnA/TdYhJ9WaZyL0Tts5Hz/cE+MR3XtQEN5CqxBjHFuLjB93hbF62hPQ==
X-Received: by 2002:a5d:5f91:0:b0:39c:30d9:48 with SMTP id ffacd0b85a97d-3a1f643c674mr2408202f8f.6.1746917079472;
        Sat, 10 May 2025 15:44:39 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2f65sm7701015f8f.55.2025.05.10.15.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 15:44:38 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v8 2/7] iio: accel: adxl345: add g-range configuration
Date: Sat, 10 May 2025 22:44:00 +0000
Message-Id: <20250510224405.17910-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250510224405.17910-1-l.rubusch@gmail.com>
References: <20250510224405.17910-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a mechanism to be able to configure and work with the available
g-ranges keeping the precision of 13 digits.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 82 ++++++++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index bbdc9d10d962..7c093c0241de 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -83,6 +83,13 @@ enum adxl345_odr {
 	ADXL345_ODR_3200HZ,
 };
 
+enum adxl345_range {
+	ADXL345_2G_RANGE = 0,
+	ADXL345_4G_RANGE,
+	ADXL345_8G_RANGE,
+	ADXL345_16G_RANGE,
+};
+
 /* Certain features recommend 12.5 Hz - 400 Hz ODR */
 static const int adxl345_odr_tbl[][2] = {
 	[ADXL345_ODR_0P10HZ]	= {    0,  97000 },
@@ -103,6 +110,25 @@ static const int adxl345_odr_tbl[][2] = {
 	[ADXL345_ODR_3200HZ]	= { 3200, 0 },
 };
 
+/*
+ * Full resolution frequency table:
+ * (g * 2 * 9.80665) / (2^(resolution) - 1)
+ *
+ * resolution := 13 (full)
+ * g := 2|4|8|16
+ *
+ *  2g at 13bit: 0.004789
+ *  4g at 13bit: 0.009578
+ *  8g at 13bit: 0.019156
+ * 16g at 16bit: 0.038312
+ */
+static const int adxl345_fullres_range_tbl[][2] = {
+	[ADXL345_2G_RANGE]  = { 0, 4789 },
+	[ADXL345_4G_RANGE]  = { 0, 9578 },
+	[ADXL345_8G_RANGE]  = { 0, 19156 },
+	[ADXL345_16G_RANGE] = { 0, 38312 },
+};
+
 struct adxl345_state {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
@@ -146,7 +172,8 @@ static struct iio_event_spec adxl345_events[] = {
 		BIT(IIO_CHAN_INFO_CALIBBIAS),				\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
-	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE) | \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
 	.scan_index = (index),				\
 	.scan_type = {					\
 		.sign = 's',				\
@@ -446,12 +473,40 @@ static int adxl345_set_odr(struct adxl345_state *st, enum adxl345_odr odr)
 				 FIELD_PREP(ADXL345_BW_RATE_MSK, odr));
 }
 
+static int adxl345_find_range(struct adxl345_state *st, int val, int val2,
+			      enum adxl345_range *range)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(adxl345_fullres_range_tbl); i++) {
+		if (val == adxl345_fullres_range_tbl[i][0] &&
+		    val2 == adxl345_fullres_range_tbl[i][1]) {
+			*range = i;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int adxl345_set_range(struct adxl345_state *st, enum adxl345_range range)
+{
+	return regmap_update_bits(st->regmap, ADXL345_REG_DATA_FORMAT,
+				 ADXL345_DATA_FORMAT_RANGE,
+				 FIELD_PREP(ADXL345_DATA_FORMAT_RANGE, range));
+}
+
 static int adxl345_read_avail(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
 			      const int **vals, int *type,
 			      int *length, long mask)
 {
 	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (int *)adxl345_fullres_range_tbl;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*length = ARRAY_SIZE(adxl345_fullres_range_tbl) * 2;
+		return IIO_AVAIL_LIST;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*vals = (int *)adxl345_odr_tbl;
 		*type = IIO_VAL_INT_PLUS_MICRO;
@@ -470,6 +525,7 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 	__le16 accel;
 	unsigned int regval;
 	enum adxl345_odr odr;
+	enum adxl345_range range;
 	int ret;
 
 	switch (mask) {
@@ -488,8 +544,12 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 		*val = sign_extend32(le16_to_cpu(accel), 12);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		*val = 0;
-		*val2 = st->info->uscale;
+		ret = regmap_read(st->regmap, ADXL345_REG_DATA_FORMAT, &regval);
+		if (ret)
+			return ret;
+		range = FIELD_GET(ADXL345_DATA_FORMAT_RANGE, regval);
+		*val = adxl345_fullres_range_tbl[range][0];
+		*val2 = adxl345_fullres_range_tbl[range][1];
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		ret = regmap_read(st->regmap,
@@ -521,6 +581,7 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 			     int val, int val2, long mask)
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
+	enum adxl345_range range;
 	enum adxl345_odr odr;
 	int ret;
 
@@ -549,6 +610,15 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 		break;
+	case IIO_CHAN_INFO_SCALE:
+		ret = adxl345_find_range(st, val, val2,	&range);
+		if (ret)
+			return ret;
+
+		ret = adxl345_set_range(st, range);
+		if (ret)
+			return ret;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -741,6 +811,8 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBBIAS:
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return IIO_VAL_INT_PLUS_MICRO;
 	default:
@@ -1083,6 +1155,10 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	if (ret)
 		return ret;
 
+	ret = adxl345_set_range(st, ADXL345_16G_RANGE);
+	if (ret)
+		return ret;
+
 	/* Reset interrupts at start up */
 	ret = regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, 0x00);
 	if (ret)
-- 
2.39.5


