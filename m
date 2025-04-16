Return-Path: <linux-iio+bounces-18169-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8C6A905A0
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 16:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FA017ADF62
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 14:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BF31B042E;
	Wed, 16 Apr 2025 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2HdSFtk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F46185920;
	Wed, 16 Apr 2025 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744812196; cv=none; b=gcUyLFVwtQ7UBuLZr9CdIGdg/29pXqzP2YIoEAsa9Jj92xjsNJrQr2hS94KfsEnDCCT2NplL2KeBpJAc6OVA5ZRznQ3Q4bXLYTHt+JJwBrOhz0XatSeRTQz60002lJopZSWejpvl2QsRDGFdjAiLBu+tBdMXJPmCkUQjeXwgJM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744812196; c=relaxed/simple;
	bh=LxX+cl3yJgp2bsmYGCZnH0H9d6DmWuTBpz8J/ROdyBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=koaU+ZIcgU7+CJJa1ZSJZmYK7drSQ2dIlCey+SCyyy05yNvRyvIRIZf+JtiUfo44hpcfemjfxmtsLFpZk1ZkcEwLmIRdOIyrzMaMIdKIrrJqrzxzJDyh5QgrZwsKWuPSaagsjDNJQhczj9KiUBNIyF7pVhx8mcQ4VD/wDRFvcj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2HdSFtk; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22423adf751so63649565ad.2;
        Wed, 16 Apr 2025 07:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744812193; x=1745416993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gO5+UltNVs46S6AxUBuSMclzV4JUmOhAUWI+eqW8LII=;
        b=l2HdSFtkJ5xtf2ZY8bdoNsutm5L04Kl4MvpnOQ4fv+rJ+q7/toR6JLufMluAXIIJJK
         ajVToOKCZKMjfpPQ+PEiaW4nqTBrPZAbDjYxmTjmn9dqEn7ws3c1D0bb+Z21qvAZXrLx
         7kvPIwmMe+EoHhCwfYsdUQe3Hx5Ujk+Hv/99ktewOWjzZSwZUaIYZLAP6rMl9ZHuHdQL
         UpQ1+q2ltM5jj0oj3lJYd0h08FNl07C5u4We22CROV5gOyJxzmbesZRfy358xdK1mftM
         /z/5bcT8/T22EDqWBrLVjwYjv6BmV7i+4zqNqSi+tgrf2qlBHVB9QxqcJO9vgQfFjvM3
         FERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744812193; x=1745416993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gO5+UltNVs46S6AxUBuSMclzV4JUmOhAUWI+eqW8LII=;
        b=naXDv98S3GrYGQMbGjnMWMpixLfhcNQyYgVffiXfrS+Uu5T79CqAvDvM5k43nDi4XT
         md4mKwoqwsYdE3lxB+OX9YFSx2n6D4OdfI1nnBf9Yka26Ab7ISacOQG9fSY3UwF+sDUs
         QAY3NTmWjssC6ElEeqVLSeOZl/xUVWp63izPtf+RQKD2TQzra3V+zJXev4PymIcULSqZ
         wK+TI3SPtBEBGD02Ep0P42vkSu7Fbqu42WAPjmnsWUoe0WEpCwxSYubO9r0MMGDk9sIc
         fuD6ws2Yp+icJeOgzp9rF2BIL1GDg7ATG9NlFztvFFRjwTh8BKhwFG5tmZV26/pO4jW1
         3GFA==
X-Gm-Message-State: AOJu0Yx8mPkzt/dO1T7W7CdtvHgSVlbR2T4n0fc7re6ov3R52PkRgJh0
	fNQvZIcxGGJxRAv1lUwQKPKJjST8mHHZPn+N3CVF7bmjdw3aZpkdVIKi8Q5c9jw=
X-Gm-Gg: ASbGncsuuIdRwvZ3nrklLRVLK6Jz//LuT0TqzDt7pkY4TlVWN97k/hIFrQW386dlFOF
	8Ii4zB0DzBu/1/L6w0LtIG3Itxa0PmoWBBtv1oN0dyKN6lI8nhFTYjw7ornYpcLpGfeti8NasRv
	GgikUp2hNfxK8x4e63K9Ek10aDAmgmPQGzi4r8bQ/UPaI6oeEE+cRoC9QdKkssm/Bda3Qk7jdHC
	uXJU5s85R3nO/b0yTG/2cVIO60jH6qAolJDVKY/rSRS+FKGrTHLxtuH9rMYOxZr6fJiMdg6Twju
	eb1xlSMI6V0opxI/HiYqqL2Kj2oRmzWl4IZ9M8VK7hn5nDs6
X-Google-Smtp-Source: AGHT+IH5UB/hcpSHG/ZBQ1Nyxg39wogMKnxkMpVRXA8mvawNhbYsQ+wzcg2jXD4lsR+c17jIgiCJuw==
X-Received: by 2002:a17:902:e54a:b0:219:e4b0:4286 with SMTP id d9443c01a7336-22c3590a349mr30990155ad.29.1744812193427;
        Wed, 16 Apr 2025 07:03:13 -0700 (PDT)
Received: from fedora.. ([2405:201:f022:f80b:bc98:df72:df5a:60fa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd22f8253sm10743280b3a.93.2025.04.16.07.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 07:03:13 -0700 (PDT)
From: Siddharth Menon <simeddon@gmail.com>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	gregkh@linuxfoundation.org,
	jic23@kernel.org,
	Michael.Hennerich@analog.com,
	lars@metafoo.de,
	marcelo.schmitt1@gmail.com,
	Siddharth Menon <simeddon@gmail.com>
Subject: [PATCH v8] iio: frequency: ad9832: Use FIELD_PREP macro to set bit fields
Date: Wed, 16 Apr 2025 19:18:56 +0530
Message-ID: <20250416140259.13431-1-simeddon@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use bitfield and bitmask macros to clearly specify AD9832 SPI
command fields to make register write code more readable.

Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Siddharth Menon <simeddon@gmail.com>
---
 I hope it's all good now :')
 v1->v2:
 - remove CMD_SHIFT and ADD_SHIFT
 - use GENMASK
 - store regval in an array and iterate through it
 v2->v3:
 - add missing header
 - refactor code in the previously introduced loops
 v3->v4:
 - update commit message with a better one
 - convert AD9832_PHASE and RES_MASK to masks
 - cleanup a few if else blocks
 v4->v5
 - remove unnecessary inversion (val ? 0 : 1) used
   with AD9832_PHASE_MASK introduced in v4
 - use ARRAY_SIZE instead of fixed integers
 - use reverse xmas tree order
 - align mask macros
 v5->v6
 - rearranged includes to be alphabetical
 - remove unused RES_MASK
 - corrected logical errors pointed out by Marcelo
 v6->v7
 - fix st->ctrl_x alignment
 v7->v8
 - corrected the tab and and spaces to be style compliant
 drivers/staging/iio/frequency/ad9832.c | 92 ++++++++++++++------------
 1 file changed, 48 insertions(+), 44 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 140ee4f9c137..7a54d8c8b416 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -7,6 +7,8 @@
 
 #include <asm/div64.h>
 
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -16,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
+#include <linux/unaligned.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -59,17 +62,17 @@
 #define AD9832_CMD_SLEEPRESCLR	0xC
 
 #define AD9832_FREQ		BIT(11)
-#define AD9832_PHASE(x)		(((x) & 3) << 9)
+#define AD9832_PHASE_MASK	GENMASK(10, 9)
 #define AD9832_SYNC		BIT(13)
 #define AD9832_SELSRC		BIT(12)
 #define AD9832_SLEEP		BIT(13)
 #define AD9832_RESET		BIT(12)
 #define AD9832_CLR		BIT(11)
-#define CMD_SHIFT		12
-#define ADD_SHIFT		8
 #define AD9832_FREQ_BITS	32
 #define AD9832_PHASE_BITS	12
-#define RES_MASK(bits)		((1 << (bits)) - 1)
+#define AD9832_CMD_MSK		GENMASK(15, 12)
+#define AD9832_ADD_MSK		GENMASK(11, 8)
+#define AD9832_DAT_MSK		GENMASK(7, 0)
 
 /**
  * struct ad9832_state - driver instance specific data
@@ -131,6 +134,8 @@ static int ad9832_write_frequency(struct ad9832_state *st,
 {
 	unsigned long clk_freq;
 	unsigned long regval;
+	u8 regval_bytes[4];
+	u16 freq_cmd;
 
 	clk_freq = clk_get_rate(st->mclk);
 
@@ -138,19 +143,15 @@ static int ad9832_write_frequency(struct ad9832_state *st,
 		return -EINVAL;
 
 	regval = ad9832_calc_freqreg(clk_freq, fout);
+	put_unaligned_be32(regval, regval_bytes);
 
-	st->freq_data[0] = cpu_to_be16((AD9832_CMD_FRE8BITSW << CMD_SHIFT) |
-					(addr << ADD_SHIFT) |
-					((regval >> 24) & 0xFF));
-	st->freq_data[1] = cpu_to_be16((AD9832_CMD_FRE16BITSW << CMD_SHIFT) |
-					((addr - 1) << ADD_SHIFT) |
-					((regval >> 16) & 0xFF));
-	st->freq_data[2] = cpu_to_be16((AD9832_CMD_FRE8BITSW << CMD_SHIFT) |
-					((addr - 2) << ADD_SHIFT) |
-					((regval >> 8) & 0xFF));
-	st->freq_data[3] = cpu_to_be16((AD9832_CMD_FRE16BITSW << CMD_SHIFT) |
-					((addr - 3) << ADD_SHIFT) |
-					((regval >> 0) & 0xFF));
+	for (int i = 0; i < ARRAY_SIZE(regval_bytes); i++) {
+		freq_cmd = (i % 2 == 0) ? AD9832_CMD_FRE8BITSW : AD9832_CMD_FRE16BITSW;
+
+		st->freq_data[i] = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, freq_cmd) |
+			FIELD_PREP(AD9832_ADD_MSK, addr - i) |
+			FIELD_PREP(AD9832_DAT_MSK, regval_bytes[i]));
+	}
 
 	return spi_sync(st->spi, &st->freq_msg);
 }
@@ -158,15 +159,21 @@ static int ad9832_write_frequency(struct ad9832_state *st,
 static int ad9832_write_phase(struct ad9832_state *st,
 			      unsigned long addr, unsigned long phase)
 {
+	u8 phase_bytes[2];
+	u16 phase_cmd;
+
 	if (phase >= BIT(AD9832_PHASE_BITS))
 		return -EINVAL;
 
-	st->phase_data[0] = cpu_to_be16((AD9832_CMD_PHA8BITSW << CMD_SHIFT) |
-					(addr << ADD_SHIFT) |
-					((phase >> 8) & 0xFF));
-	st->phase_data[1] = cpu_to_be16((AD9832_CMD_PHA16BITSW << CMD_SHIFT) |
-					((addr - 1) << ADD_SHIFT) |
-					(phase & 0xFF));
+	put_unaligned_be16(phase, phase_bytes);
+
+	for (int i = 0; i < ARRAY_SIZE(phase_bytes); i++) {
+		phase_cmd = (i % 2 == 0) ? AD9832_CMD_PHA8BITSW : AD9832_CMD_PHA16BITSW;
+
+		st->phase_data[i] = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, phase_cmd) |
+			FIELD_PREP(AD9832_ADD_MSK, addr - i) |
+			FIELD_PREP(AD9832_DAT_MSK, phase_bytes[i]));
+	}
 
 	return spi_sync(st->spi, &st->phase_msg);
 }
@@ -197,25 +204,23 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 		ret = ad9832_write_phase(st, this_attr->address, val);
 		break;
 	case AD9832_PINCTRL_EN:
-		if (val)
-			st->ctrl_ss &= ~AD9832_SELSRC;
-		else
-			st->ctrl_ss |= AD9832_SELSRC;
-		st->data = cpu_to_be16((AD9832_CMD_SYNCSELSRC << CMD_SHIFT) |
-					st->ctrl_ss);
+		st->ctrl_ss &= ~AD9832_SELSRC;
+		st->ctrl_ss |= FIELD_PREP(AD9832_SELSRC, val ? 0 : 1);
+
+		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SYNCSELSRC) |
+						  st->ctrl_ss);
 		ret = spi_sync(st->spi, &st->msg);
 		break;
 	case AD9832_FREQ_SYM:
-		if (val == 1) {
-			st->ctrl_fp |= AD9832_FREQ;
-		} else if (val == 0) {
+		if (val == 1 || val == 0) {
 			st->ctrl_fp &= ~AD9832_FREQ;
+			st->ctrl_fp |= FIELD_PREP(AD9832_FREQ, val ? 1 : 0);
 		} else {
 			ret = -EINVAL;
 			break;
 		}
-		st->data = cpu_to_be16((AD9832_CMD_FPSELECT << CMD_SHIFT) |
-					st->ctrl_fp);
+		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
+						  st->ctrl_fp);
 		ret = spi_sync(st->spi, &st->msg);
 		break;
 	case AD9832_PHASE_SYM:
@@ -224,22 +229,21 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 			break;
 		}
 
-		st->ctrl_fp &= ~AD9832_PHASE(3);
-		st->ctrl_fp |= AD9832_PHASE(val);
+		st->ctrl_fp &= ~AD9832_PHASE_MASK;
+		st->ctrl_fp |= FIELD_PREP(AD9832_PHASE_MASK, val);
 
-		st->data = cpu_to_be16((AD9832_CMD_FPSELECT << CMD_SHIFT) |
-					st->ctrl_fp);
+		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
+						  st->ctrl_fp);
 		ret = spi_sync(st->spi, &st->msg);
 		break;
 	case AD9832_OUTPUT_EN:
 		if (val)
-			st->ctrl_src &= ~(AD9832_RESET | AD9832_SLEEP |
-					AD9832_CLR);
+			st->ctrl_src &= ~(AD9832_RESET | AD9832_SLEEP | AD9832_CLR);
 		else
-			st->ctrl_src |= AD9832_RESET;
+			st->ctrl_src |= FIELD_PREP(AD9832_RESET, 1);
 
-		st->data = cpu_to_be16((AD9832_CMD_SLEEPRESCLR << CMD_SHIFT) |
-					st->ctrl_src);
+		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SLEEPRESCLR) |
+						  st->ctrl_src);
 		ret = spi_sync(st->spi, &st->msg);
 		break;
 	default:
@@ -396,8 +400,8 @@ static int ad9832_probe(struct spi_device *spi)
 	spi_message_add_tail(&st->phase_xfer[1], &st->phase_msg);
 
 	st->ctrl_src = AD9832_SLEEP | AD9832_RESET | AD9832_CLR;
-	st->data = cpu_to_be16((AD9832_CMD_SLEEPRESCLR << CMD_SHIFT) |
-					st->ctrl_src);
+	st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SLEEPRESCLR) |
+					  st->ctrl_src);
 	ret = spi_sync(st->spi, &st->msg);
 	if (ret) {
 		dev_err(&spi->dev, "device init failed\n");
-- 
2.49.0


