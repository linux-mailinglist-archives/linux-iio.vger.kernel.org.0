Return-Path: <linux-iio+bounces-18120-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E9EA88C04
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 21:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289261899FE5
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 19:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D50F1D6193;
	Mon, 14 Apr 2025 19:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6ckRRo/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B75F28DF07;
	Mon, 14 Apr 2025 19:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744658103; cv=none; b=CEO6ge02IwCpdgjFESjBog7A2tQUUO9FZUs4sfoxd57wy70eLVNBRTC+op53PmB+21T2RYrvyyY/bSnvMA2Kwda1sfgRBi9E+ZDQ0o3nvginVoBTOJ+SSYx1NPRdrONezWGWpLnfwa5KW6nKsy4mez6TiT0KQdw/8+aZD4ohcz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744658103; c=relaxed/simple;
	bh=SZLc80JSRS4bke1tP8vkfy2i+0aEBhWWMyEdEXjfRfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ge32r0d2s//rZ+qUJ6UCkG9xxcnFPQqGs08HuZNIIR+42+cFIG1M5HplgoukTbtPd6uoBSFuNtWwp1QJX296gdjsG8BvMlUIkLvybivTVR/NzeytroQ28DatNJYZvyQVdivErI/ZD8SWDtyd1Wnkajk0PNqfTdp/DbShhcKNgY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6ckRRo/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-227cf12df27so38049645ad.0;
        Mon, 14 Apr 2025 12:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744658100; x=1745262900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BYDKbWQ4u2NcbGHsioG5Cqiy01R5mCg0Ne+nPydVgbU=;
        b=Y6ckRRo/GboJcSrl5heGN0rNc2Vl+kakmdP43IHvtALpGtGziiyVEHwOfnGj/PpVCJ
         ncW6SPRuwrkohQFByK2EKtw5UcKn/wW4awjv+77xjWOJT/SM4QOHWmARs6qOx8acwqp0
         IGrZGkPHaBbJ9FJE76XLJkjpeuFHQQTM61Zk4vlMzRCGaFLxqAFtv3kVspjwAjDn5nVX
         Se2sDXtj5K+jhFx65ynJD4bTGegtNHYZGIIe7kyY94hcxJSeYPlmY1XVW0A6CiqhjGC/
         Rnl0TLKCI+wGFjTDDOSIZqkpfK2+1qUyQ0AK66MxwAPC8kNRhcDJHLyahOF5UuGV4iZD
         /65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744658100; x=1745262900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BYDKbWQ4u2NcbGHsioG5Cqiy01R5mCg0Ne+nPydVgbU=;
        b=gXCvHNcVmcUF5mn+OcM/PceKwbvwFxEXkSzQcqvVhTTs694o5vnA4iiOQB+Z+bXK5J
         TeQafNaOWDDhnZhKnZ2u/eNVTkqkn/xuzCKcQo5OeIJSEMH00TuXImthQmk1OPvDJY4E
         YtOSiHvVN05ZnmPxeHnWwemrN614rLjRY7s3jKgPyIQd5nEAZEBuiHZcGtiiVCxyoHu2
         WqTogVxpq3/QhknvTryaqvRADCMQchyyHFcYynsjUKfV6GKGlDQEsc9+K6qwWPwZPdWb
         ho7R32XSp+iQQcHTdxEhAMteSGA3aAbhD8Ksx/Nm4p9FFExh0xwW6qSqe+jtod5N5tv+
         ix4Q==
X-Gm-Message-State: AOJu0YwtsdhPfAU8UY5q9QgFEFZgag8/218PiU45i7+tMUU2Na0AAO4S
	6HiDYankahHYll6d1h6ZXEfPZwtClOSwKVkPlpRAyMJeW1TzZzMW8MPjYZgIPa8=
X-Gm-Gg: ASbGncufWrO0T1B8BhSy1EzYNGw0n0PzCGpy5LM20fmI4ZsxaLOwrTwDbp7wmWewJZn
	lJ6auAkhoCvae4FwvhA6S8avLsDx1g+qEWAey0gT357xKvbwTdSKc3GL4JMeNyDzJIAd0M8sCxs
	UuPH4X7NO3TdpNjQkSYL3F0HV5CHm/p25IRTrUQGQgef+YLpRb2qnMSZK9lI5S9HyXiNlR0uYA6
	6CCF8IJCp7DMFlSkuX0K/cJIdzToj36InijqRAKTOk3mB1i6/W6B7y7ZR11JcWMMLeLTNsZ/Tpq
	I+D3IHDVc24TFeHB07/MaCuSTEONWezUmWBohw==
X-Google-Smtp-Source: AGHT+IEuerABYWz61bn0kK9fA1Um8mNSN54Ov1FV120MP0ffB1+zwyz3P8qouSb5mAU25KZelhS0GA==
X-Received: by 2002:a17:903:fa5:b0:221:89e6:ccb6 with SMTP id d9443c01a7336-22c249c9ec4mr8568325ad.25.1744658100165;
        Mon, 14 Apr 2025 12:15:00 -0700 (PDT)
Received: from fedora.. ([2405:201:f022:f80b:bc98:df72:df5a:60fa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccbe16sm102483705ad.246.2025.04.14.12.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 12:14:59 -0700 (PDT)
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
Subject: [PATCH v7] iio: frequency: ad9832: Use FIELD_PREP macro to set bit fields
Date: Tue, 15 Apr 2025 00:42:26 +0530
Message-ID: <20250414191453.10222-1-simeddon@gmail.com>
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

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Siddharth Menon <simeddon@gmail.com>
---
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
 drivers/staging/iio/frequency/ad9832.c | 92 ++++++++++++++------------
 1 file changed, 48 insertions(+), 44 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 140ee4f9c137..08891d66b896 100644
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
+							st->ctrl_ss);
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
+							st->ctrl_fp);
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
+							st->ctrl_fp);
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
+							st->ctrl_src);
 		ret = spi_sync(st->spi, &st->msg);
 		break;
 	default:
@@ -396,8 +400,8 @@ static int ad9832_probe(struct spi_device *spi)
 	spi_message_add_tail(&st->phase_xfer[1], &st->phase_msg);
 
 	st->ctrl_src = AD9832_SLEEP | AD9832_RESET | AD9832_CLR;
-	st->data = cpu_to_be16((AD9832_CMD_SLEEPRESCLR << CMD_SHIFT) |
-					st->ctrl_src);
+	st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SLEEPRESCLR) |
+						st->ctrl_src);
 	ret = spi_sync(st->spi, &st->msg);
 	if (ret) {
 		dev_err(&spi->dev, "device init failed\n");
-- 
2.49.0


