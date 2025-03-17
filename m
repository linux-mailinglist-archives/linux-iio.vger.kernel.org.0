Return-Path: <linux-iio+bounces-16989-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC436A65AED
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 18:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FF65188ADB4
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 17:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EDD1A23B7;
	Mon, 17 Mar 2025 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYFS4Ese"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053C31A00F0;
	Mon, 17 Mar 2025 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232847; cv=none; b=C8eaY9iAqwpfmSxSHy/cZWz3ShhJn7c+mJ0a2FeJN0NxSJIahYTtOUf+d2PreNVGI56LtV8G4vUl1H7yJmX1dUfpgToBQdlwDqMnjOhmle/IFHukm0j5Zi8Im0tcZ3tPQt4BDh0QlhGqimOGaYDp0qtiJwpe7uc5z1GdnrcuuH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232847; c=relaxed/simple;
	bh=7HBmz3vDnrjI7srclW+onKhbskvr1Kc5hobO+QrYUUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eWjrgSJEAI+FJpoqMIk2VEb90PFNMzao/zybwJSR07TwMgMcTbOw6s1fNjZrrWXAr2Dz/CuRQwmK9fwILGngFk6FPWrDRLeObp10b6lssHbZxOzWVYu3O4ueZeOCK779j4qmmL63jZsByKTTHc+BVePr1t+WaRqO5HOb70q+vDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYFS4Ese; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223f4c06e9fso79808735ad.1;
        Mon, 17 Mar 2025 10:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742232845; x=1742837645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=la1g9socyej0WuROWo23Gm/GJYnN4zFjSn8pewoHcqI=;
        b=lYFS4Ese5jFlUiVsWCHwWrfgJxqT1Xgk7KEvJuSl3RYtez6PDlJw9pasmg/JP5f0O/
         p6Ecmp6NAqfeZihz0oels9ApO/Rtp1XdCm2ZV2LKANzbOJbTGH7MdrPDJ5QrsFozldes
         CKgZczxi8yNAv7R9kqkcIzkJ5rHvqWT1PCF0+Jxi6TDHiwUhc8iDI+6GWGs+Tx837+02
         c/5f5c4fszCZoYi016Z/Kcu4l6ITLBYIR1H57oitweqXSij3SAEKMwCH705yex2khB33
         p4xoSuC+jjUR6SWYdf6tj2ozUmM8/EN06YQHibl3aZZGS8235gwSq2jxIvVEGRU8MQuc
         NTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742232845; x=1742837645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=la1g9socyej0WuROWo23Gm/GJYnN4zFjSn8pewoHcqI=;
        b=Vgp/2Hs1Y6AD/JSNjqh6WUtK3+I9Cn1uD03qbOtRk7uCocbjqfb5jIwO2+mp7lDuIC
         1jxtto4g84w7ZD3DQkfQOxorRM/o0ZzCY/pCpzaFkaU3U2r5Jd2WN7z747sDnkObABLL
         Frl7/w65PIFMJWHS83O0T4hLztWB4v5Vhoz8YfpOTpJ0dyoiWBDF/Oau726nI+B6RD4D
         0YaJ15y3d9L2GIMvm9uPGVGS/Mx2192PRje6+u7DeKCqVtlCIfs0vRAfH8DcSdrPrMDD
         mp96COsizsC5PmrGY/Xprb+/gcMIhNi9zwNpnim6w0h9NDRPBxbri9F3nZlS+9Hc4NPC
         h4GA==
X-Gm-Message-State: AOJu0YwNN0eO1toCmbZVNGnXm1hF5K8+nGt8lrdmZLuH8382wkGX46qW
	ihKvWN1iQfxzK88epVte0+hhq5AnvUGQq5AGuBL4mnlnuSQv2prED90l6cKkBSMMUg==
X-Gm-Gg: ASbGnctcC9h3wPzVeNxK43n0BSzejrczzq6xLTPIKfYvAmKTnhhHusauHAkNWCYGUQ2
	evKN+KKzOmqtqjq7xMBnoBOfaLWfqRO2ou8+bWiZJbags6+B9l6I5n3pc34t3PTyL+VqHCGZ7DI
	WFkSq6WFKNHr3LXwczQ8PHvHT/XG47ZW0a9Oa03C7B7vQ2QEMURESVFzcYYqUnopjfTbCntpjsa
	Dm419fkCe+1YlusJro7Lzi8rpmUl7m3Jz4++ZipgHuU3HHOAJyi56y8GJ0bhk/QpvNCeF1tmtY4
	zsYeYbX6X0TJ+sMgipcNAhY0xEofe94yfea3mDYJkizemxEZyHuNimOZgtdjk1UqFfY=
X-Google-Smtp-Source: AGHT+IF+I1J9o55YQcVtZfcCu1qe5C4DQ7hZkBTYGyYw5upwuaItMUJu/cYT4LriDUzLLVZZKDBTIA==
X-Received: by 2002:a17:902:da8d:b0:215:a303:24e9 with SMTP id d9443c01a7336-2262c992542mr3755595ad.3.1742232844875;
        Mon, 17 Mar 2025 10:34:04 -0700 (PDT)
Received: from fedora.am.students.amrita.edu ([175.184.253.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4c80sm78141425ad.239.2025.03.17.10.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:34:04 -0700 (PDT)
From: Siddharth Menon <simeddon@gmail.com>
To: linux-iio@vger.kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Siddharth Menon <simeddon@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2] iio: frequency: ad9832: Use FIELD_PREP macro to set bit fields
Date: Mon, 17 Mar 2025 22:55:03 +0530
Message-ID: <20250317173355.157536-1-simeddon@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor code to use the FIELD_PREP macro for setting bit fields
instead of manual bit manipulation.

Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Siddharth Menon <simeddon@gmail.com>
---
 Based on feedback from Jonathan and Marcello, I have made the following
 changes
 
 v1->v2:
 - removed CMD_SHIFT andADD_SHIFT completely
 - use GENMASK
 - store regval into an array and iterate through it
 drivers/staging/iio/frequency/ad9832.c | 53 ++++++++++++++------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 140ee4f9c137..0c1816505495 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -16,6 +16,8 @@
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -65,11 +67,12 @@
 #define AD9832_SLEEP		BIT(13)
 #define AD9832_RESET		BIT(12)
 #define AD9832_CLR		BIT(11)
-#define CMD_SHIFT		12
-#define ADD_SHIFT		8
 #define AD9832_FREQ_BITS	32
 #define AD9832_PHASE_BITS	12
 #define RES_MASK(bits)		((1 << (bits)) - 1)
+#define CMD_MASK_2   GENMASK(15, 12)
+#define ADD_MASK_2   GENMASK(11, 8)
+#define DATA_MASK_2  GENMASK(7, 0)
 
 /**
  * struct ad9832_state - driver instance specific data
@@ -131,6 +134,7 @@ static int ad9832_write_frequency(struct ad9832_state *st,
 {
 	unsigned long clk_freq;
 	unsigned long regval;
+	u8 regval_bytes[4];
 
 	clk_freq = clk_get_rate(st->mclk);
 
@@ -138,19 +142,14 @@ static int ad9832_write_frequency(struct ad9832_state *st,
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
+	for (int i = 0; i < 4; i++) {
+		st->freq_data[i] = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK,
+				(i % 2 == 0) ? AD9832_CMD_FRE8BITSW : AD9832_CMD_FRE16BITSW) |
+			FIELD_PREP(AD9832_ADD_MSK, addr - i) |
+			FIELD_PREP(AD9832_DAT_MSK, regval_bytes[i]));
+	}
 
 	return spi_sync(st->spi, &st->freq_msg);
 }
@@ -158,15 +157,19 @@ static int ad9832_write_frequency(struct ad9832_state *st,
 static int ad9832_write_phase(struct ad9832_state *st,
 			      unsigned long addr, unsigned long phase)
 {
+	u8 phase_bytes[2];
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
+	for (int i = 0; i < 2; i++) {
+		st->phase_data[i] = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK,
+				(i % 2 == 0) ? AD9832_CMD_PHA8BITSW : AD9832_CMD_PHA16BITSW) |
+			FIELD_PREP(AD9832_ADD_MSK, addr - i) |
+			FIELD_PREP(AD9832_DAT_MSK, phase_bytes[i]));
+	}
 
 	return spi_sync(st->spi, &st->phase_msg);
 }
@@ -201,7 +204,7 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 			st->ctrl_ss &= ~AD9832_SELSRC;
 		else
 			st->ctrl_ss |= AD9832_SELSRC;
-		st->data = cpu_to_be16((AD9832_CMD_SYNCSELSRC << CMD_SHIFT) |
+		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SYNCSELSRC) |
 					st->ctrl_ss);
 		ret = spi_sync(st->spi, &st->msg);
 		break;
@@ -214,7 +217,7 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 			ret = -EINVAL;
 			break;
 		}
-		st->data = cpu_to_be16((AD9832_CMD_FPSELECT << CMD_SHIFT) |
+		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
 					st->ctrl_fp);
 		ret = spi_sync(st->spi, &st->msg);
 		break;
@@ -227,7 +230,7 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 		st->ctrl_fp &= ~AD9832_PHASE(3);
 		st->ctrl_fp |= AD9832_PHASE(val);
 
-		st->data = cpu_to_be16((AD9832_CMD_FPSELECT << CMD_SHIFT) |
+		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
 					st->ctrl_fp);
 		ret = spi_sync(st->spi, &st->msg);
 		break;
@@ -238,7 +241,7 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 		else
 			st->ctrl_src |= AD9832_RESET;
 
-		st->data = cpu_to_be16((AD9832_CMD_SLEEPRESCLR << CMD_SHIFT) |
+		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SLEEPRESCLR) |
 					st->ctrl_src);
 		ret = spi_sync(st->spi, &st->msg);
 		break;
@@ -396,7 +399,7 @@ static int ad9832_probe(struct spi_device *spi)
 	spi_message_add_tail(&st->phase_xfer[1], &st->phase_msg);
 
 	st->ctrl_src = AD9832_SLEEP | AD9832_RESET | AD9832_CLR;
-	st->data = cpu_to_be16((AD9832_CMD_SLEEPRESCLR << CMD_SHIFT) |
+	st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SLEEPRESCLR) |
 					st->ctrl_src);
 	ret = spi_sync(st->spi, &st->msg);
 	if (ret) {
-- 
2.48.1


