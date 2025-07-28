Return-Path: <linux-iio+bounces-22111-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F29B13FA9
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 18:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25771885621
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 16:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C612741C2;
	Mon, 28 Jul 2025 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/f9zBTb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241E2272E55;
	Mon, 28 Jul 2025 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719306; cv=none; b=R0gtKVqw9tcmr9aoeE+r0TEh+gjdp5BW01ROpfGibwMCQi+jIyrzfD4QlVHImOGaRuuwIKFj5swX9dhzTejQwREILjwrIHr50kyXUbUIqD2LWOLtQxvsSIyT5HOtNvhTDUzfMc48/5OrmCJjgewQxFrJvPpLpTsdZnb9Z/Iyqc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719306; c=relaxed/simple;
	bh=MEtXJi8fsHcU7CbD/0I9wLTMAo1y0ij4wL521LjXJw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D9fGzluzzPQrRMNybw9iKttRZkEDrOkR1TS6cRNj/NtR6dQQdEy0J+DI0s9S+shqShf3QY3hltoIWBV7EaNJatGhVituzJ4uhGfyYLgMMfbYxTTIuFobRRhSRsRWfYpE0Z1qvXs1OmIT6XCOo0UwXSqd4+H4JpdarjcRUmleHbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/f9zBTb; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-74b50c71b0aso2707414b3a.0;
        Mon, 28 Jul 2025 09:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753719304; x=1754324104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IIgoubiaOXZokJLLdXEo+GMPCF72BsATxsxBrun6GRU=;
        b=l/f9zBTbjUAupBv4jVRWG0RoCR3J9XT7qj40p5Fkc79pEDlqtwr1wgssIDVU+UnO7r
         isYW96H+ioMco73a1aXs7a7NpD7to2nG2sRQq/XKwSMU0xYH7hxiQnWd8AqGHkWnCwd+
         HovxCY61YMRwD4H1bGXntjrut9QR2yogcWpNKL9Bwo3pUC1/L1HeSAr/sjoWoBoko0h4
         p1FFgYOlcL3zsZlzfQbkD0Uiki/O+DpHzfUstTmR2p5H/5YRfXPrOkb/SpeJXG0TYUv0
         ka9uNH2S8teyPWlRaTWHU2o5CVrsfEWHvtywvGo40QX9TbDxyj9BXBZ0bGi51BrIGmRG
         M0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753719304; x=1754324104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IIgoubiaOXZokJLLdXEo+GMPCF72BsATxsxBrun6GRU=;
        b=uu+oDhm5kcpZFCbBYX7jZQ7QTAhkaKTKWmGeqOlu5NJr3dulC4XeJ00WZK3Oh+6oX+
         doRghdP9zGNyGtsq8wDISbRTh5YEh4fnhiHbZ97bOKlaJuOE/T7H0dvvgKj7T2ebtP4y
         NBrJ8F6aRc/6GLYz/8iBodVMDpHdyadqfEsHoD4v5Ohc+B6pyZCazr+HPfON7T+S2JsC
         872IZaP90ASSgZd8FzpwebKTJdOqR5mYMGevMgjp0n7amMIUvANzgHMlcXLRh2BjFY1j
         Y/txK1qdwbPqgsehXYBklY5LfVLAKH49AtROc/hzckl1/qraTE9sf2OM0CXyN/i7h8Nb
         QlSA==
X-Forwarded-Encrypted: i=1; AJvYcCUpLjHbGNho9xGNG5BxRrsh7to1hI7erTkL96znuky/7q+DNiEcntEsUzftmo2R0uM/6sWFTqH+Yv8YsSVx@vger.kernel.org, AJvYcCW8wH7HCBdgD6746225DVLuWH81DSZI6X+0kX/aC0P+iFtsbNW21cVFCBYLvSqmhl75kzpu/GORBDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxsIUTmmGO85FxfUXqupOYokOd9jULQUmUJanA+wEZAV2Ac8xR
	xsk3veuD+mVlGqi6/yDk6vCKTKK/v3O0zFC53g8GE3P2D6Zzuoj2f63/Td1QCA==
X-Gm-Gg: ASbGncsArVGrXF331LbcTl3tdR/SRPrSNFYCCOZHeRHP62bpFYpkSGT5rrZB7N6lOVI
	l7i89qXbNMwilsfRcFrDM/OCRFqgvbMbf6xHvg0vDKN0EgoQAIF88LMMdG0d8RItBJGRaO50Qzh
	/jvtz4uBxXVVwvzp/kYxLGgGYNZblVgBOg1XctxOUS9yuQv/ffZhABx/BweoG3tQD/GludWclD+
	ume7CKqmBfzxF3eKxkltRztOggO+pRf755bGBPXmJ5dwvnXI9WNza66l5BjuoZJKJxEJLcgNKHV
	lCthlXFWSikb0l2AhrVfT+PPkpj+uomz2Obu2tq/K5mRsdjGwmngCH96aR7jR262gfVu8TYU0He
	59gjiij8K4ZZCvr7gHkdYdmdGrdTYwNzKsvAnnQ==
X-Google-Smtp-Source: AGHT+IFFBJ9MGrtJTObeSKvBpq83ULkcuLQ5PXp1rKGdr47Vxxrf1b3FYSXj7jSFi923GXhmD/jNzQ==
X-Received: by 2002:a05:6a00:234b:b0:748:f854:b765 with SMTP id d2e1a72fcca58-76332282dc2mr18848585b3a.4.1753719304164;
        Mon, 28 Jul 2025 09:15:04 -0700 (PDT)
Received: from akshayaj-lenovo.. ([2401:4900:8838:5dc9:f81a:1a92:3aa2:c5b2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b8b0beesm5901361b3a.125.2025.07.28.09.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 09:15:03 -0700 (PDT)
From: Akshay Jindal <akshayaj.lkd@gmail.com>
To: anshulusr@gmail.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Akshay Jindal <akshayaj.lkd@gmail.com>,
	shuah@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] iio: light: ltr390: Add debugfs register access support
Date: Mon, 28 Jul 2025 21:44:41 +0530
Message-ID: <20250728161445.13261-1-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for debugfs_reg_access through the driver's iio_info structure
to enable low-level register read/write access for debugging.

Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
---

Changes since v3:
=================
- Merged the regmap_range of LTR390_ALS_DATA with LTR390_UVS_DATA.
- Keep only macro parameters in parenthesis. Removed from others.
- Replaced testing details with testing summary.

Changes since v2:
================
- merged the regmap_range of LTR390_UP_THRESH with LTR390_LOW_THRESH.

Changes since v1:
=================
- Replaced _[0|1|2] macros with a respective common parameterized macro.
- Retained base macros to avoid churn.
- Swapped regmap_write with regmap_read to avoid negate operator.
- Simplified debugfs function by directly returning return value of
  regmap_[read|write].
- Replaced [readable|writeable]_reg with regmap ranges by using
  [rd|wr]_table property of regmap_config.
- Updated the testing details with v2 changes.

Testing details (done for v2):
==============================
-> Tested on Raspberrypi 4B. Following tests were performed.

1. Disable sensor via debugfs, verify from i2cget and debugfs.
2. Disable sensor via debugfs and read data status via debugfs.
3. Re-enable sensor via debugfs and read data status via debugfs.
4. Enable interrupts via sysfs and verify via debugfs.
5. Write falling threshold via debugfs, verify the threshold written via sysfs.
6. Block light and verify interrupts getting generated. Generated
interrupts by blocking light.
7. write value to a non-writeable reg via debugfs.
8. read value from a non-readable reg via debugfs.
9. do simple raw reads from debugfs.
-> reading raw value via sysfs
-> reading via debugfs (should be in the same ballpark of sysfs)
10. Testing reads on registers beyond max_register.

 drivers/iio/light/ltr390.c | 52 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index ee59bbb8aa09..7733830dca67 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -38,12 +38,21 @@
 #define LTR390_ALS_UVS_GAIN		0x05
 #define LTR390_PART_ID			0x06
 #define LTR390_MAIN_STATUS		0x07
+
 #define LTR390_ALS_DATA			0x0D
+#define LTR390_ALS_DATA_BYTE(n)		(LTR390_ALS_DATA + (n))
+
 #define LTR390_UVS_DATA			0x10
+#define LTR390_UVS_DATA_BYTE(n)		(LTR390_UVS_DATA + (n))
+
 #define LTR390_INT_CFG			0x19
 #define LTR390_INT_PST			0x1A
+
 #define LTR390_THRESH_UP		0x21
+#define LTR390_THRESH_UP_BYTE(n)	(LTR390_THRESH_UP + (n))
+
 #define LTR390_THRESH_LOW		0x24
+#define LTR390_THRESH_LOW_BYTE(n)	(LTR390_THRESH_LOW + (n))
 
 #define LTR390_PART_NUMBER_ID		0xb
 #define LTR390_ALS_UVS_GAIN_MASK	GENMASK(2, 0)
@@ -98,11 +107,39 @@ struct ltr390_data {
 	int int_time_us;
 };
 
+static const struct regmap_range ltr390_readable_reg_ranges[] = {
+	regmap_reg_range(LTR390_MAIN_CTRL, LTR390_MAIN_CTRL),
+	regmap_reg_range(LTR390_ALS_UVS_MEAS_RATE, LTR390_MAIN_STATUS),
+	regmap_reg_range(LTR390_ALS_DATA_BYTE(0), LTR390_UVS_DATA_BYTE(2)),
+	regmap_reg_range(LTR390_INT_CFG, LTR390_INT_PST),
+	regmap_reg_range(LTR390_THRESH_UP_BYTE(0), LTR390_THRESH_LOW_BYTE(2)),
+};
+
+static const struct regmap_access_table ltr390_readable_reg_table = {
+	.yes_ranges = ltr390_readable_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ltr390_readable_reg_ranges),
+};
+
+static const struct regmap_range ltr390_writeable_reg_ranges[] = {
+	regmap_reg_range(LTR390_MAIN_CTRL, LTR390_MAIN_CTRL),
+	regmap_reg_range(LTR390_ALS_UVS_MEAS_RATE, LTR390_ALS_UVS_GAIN),
+	regmap_reg_range(LTR390_INT_CFG, LTR390_INT_PST),
+	regmap_reg_range(LTR390_THRESH_UP_BYTE(0), LTR390_THRESH_LOW_BYTE(2)),
+};
+
+static const struct regmap_access_table ltr390_writeable_reg_table = {
+	.yes_ranges = ltr390_writeable_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ltr390_writeable_reg_ranges),
+};
+
 static const struct regmap_config ltr390_regmap_config = {
 	.name = "ltr390",
 	.reg_bits = 8,
 	.reg_stride = 1,
 	.val_bits = 8,
+	.max_register = LTR390_THRESH_LOW_BYTE(2),
+	.rd_table = &ltr390_readable_reg_table,
+	.wr_table = &ltr390_writeable_reg_table,
 };
 
 /* Sampling frequency is in mili Hz and mili Seconds */
@@ -586,6 +623,20 @@ static int ltr390_write_event_config(struct iio_dev *indio_dev,
 	}
 }
 
+static int ltr390_debugfs_reg_access(struct iio_dev *indio_dev,
+						unsigned int reg, unsigned int writeval,
+						unsigned int *readval)
+{
+	struct ltr390_data *data = iio_priv(indio_dev);
+
+	guard(mutex)(&data->lock);
+
+	if (readval)
+		return regmap_read(data->regmap, reg, readval);
+
+	return regmap_write(data->regmap, reg, writeval);
+}
+
 static const struct iio_info ltr390_info = {
 	.read_raw = ltr390_read_raw,
 	.write_raw = ltr390_write_raw,
@@ -594,6 +645,7 @@ static const struct iio_info ltr390_info = {
 	.read_event_config = ltr390_read_event_config,
 	.write_event_value = ltr390_write_event_value,
 	.write_event_config = ltr390_write_event_config,
+	.debugfs_reg_access = ltr390_debugfs_reg_access,
 };
 
 static irqreturn_t ltr390_interrupt_handler(int irq, void *private)
-- 
2.43.0


