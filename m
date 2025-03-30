Return-Path: <linux-iio+bounces-17337-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97886A75A2E
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 15:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27061166568
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 13:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C8D1C3F36;
	Sun, 30 Mar 2025 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayIVWM3t"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBA4149DFF;
	Sun, 30 Mar 2025 13:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743340545; cv=none; b=UAxPSdt/gh+7CBIJhaEnSpScwkb0GeiamyEczdCCTSQRDU8GDh6/muhcZVK/zTcjoak9pfIaC/IEKjPMeCb49tBIDPa2SZ9sN5EiGfxmve6JBuXxapCUuZt1u67sPGKxZbs/izMEGj5iE9NL1cFqHJN1jAvq5F4rMTrGkNpTXak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743340545; c=relaxed/simple;
	bh=zEqvR4Yif+VPOEp8p55PUCR23H0BtfvOL/VKmaewHI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Otv2zNMEbcYekenFFsM8VSz0s5WvRh6SSvFurSzV6NYDN4nEJMxSd5MpjzpCBbU/uNuqWzrfW8IsJHEWMXKfXCTKIJoQfdmXafLxthIKNjMr0uLH3WeacGn0O64BE3zGDPWqrizZAH+8xLOTkV/anVh8SRu/Qy527Q8ABJ8PFOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayIVWM3t; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22622ddcc35so41242535ad.2;
        Sun, 30 Mar 2025 06:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743340543; x=1743945343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5b77UBiiF3+CsUBsobO4g2pHQ2rJ9CzTVYiaCkdVgZA=;
        b=ayIVWM3tXfC8gQAf5V2VJMHFPw7sDJnvCMQgqnCUkK7+E3b6qnZgjLLURFhC2cSSDo
         9LlvR4eb+O9838s2oGZ8TfpASblFkq0J6wgAarKYG1lchurECc+IETrOUVRg1b5rwi6q
         iT3vnayBhO3Ibj7GXSGDs8F7RD4w9c2GHpuMq3DYGn06+VStTrFaMoNOO5fwnyeAQHmO
         GcdSAi7Ek6fN57lYE8aq/FJCaSu3DQc5IBXG4o6ViyYgEdTPN20QzfPDQPygg0C4vi3C
         W37fiff8kusUl4AHUUkD1eKI7/o6WxfotanOeU01Ezc/YlBegcFJGQA71p15t9le1i/u
         JY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743340543; x=1743945343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5b77UBiiF3+CsUBsobO4g2pHQ2rJ9CzTVYiaCkdVgZA=;
        b=EkKm8xiHBYFIDH7CwEcRGL5jgKwefD7bcaLS74pzkB3u/Tu5Aga76R2cmaKd6iCpoA
         8hYz03QGLvs0d2fvmp1hkqqBvS4CuRIImLk6u1aYZ7wrSJKjFvlRpFT0dCQGOc2fQbDY
         8xvIAz5MKlnFjgIx56Taql+PTEOKxa1ZnMb0gjWQhmV6Z6g4SA2gPZS05Zhzq6fmmZkT
         UZgNYVupPfcjzNRVTosy/1yoIhdksazz9DKprb12hU3JawQcaQVRALCVNVi/3pbq0QbW
         I9CuyvQXOBY5hALiUPd7MubBtG02p10csF8iPEcPeulv/07OuyDvqP2FZf+5SYUca8kM
         /tqQ==
X-Gm-Message-State: AOJu0YwmA3Qn3pXMTiftUgt+MPlC7RUdSPAHS5VYRXqA3H5i/z8kw+fq
	+/810HJ2+peNZ58KUGk3k0v1E8zLT3CipynmMBkV6EUwRU9LIUdC2hDjQvjMp6s=
X-Gm-Gg: ASbGncvPXdmgBklLGCnJq0g+3HdD1h3NwxWegGuLnZjDHuAf+eL971I5R8qcPJermxt
	1Ewfy1F9S1YO/SBYtQKO3BYr/A5BvuH1qFtUjx5VJhYGDB4JveriC2M6IAXlYIlJUTY7fvKet8c
	Jqg9pbNZDJdVDBU2azg7q5HgRTC30hh1Cyxz37yVExkcz6sLwaER1ymd/FhRHnlUj+u9kfrzDQ7
	JhUbk7Vqc4Gic0U2AXjYCnm3bMOY8PSa+2hIQz8gTLHvf0olXskLNRD2TEWvMenrxKIKlx2pLPw
	zgSLH/PTQtOwgSvjl7TR9mM6xZuWPkMohNRZ0oox0W4Czdq2Itd0WeGVMuQp8+AvMF05wkz/KRM
	DkA==
X-Google-Smtp-Source: AGHT+IFf4viNFZnZC6WyJNmg3HGPNKr7fIwzjG7td15GVJfDIQhrUJRfnfTDgukBKPs86RnGbek6Mw==
X-Received: by 2002:a05:6a00:3a24:b0:730:99cb:7c2f with SMTP id d2e1a72fcca58-739803648bcmr6881268b3a.6.1743340543068;
        Sun, 30 Mar 2025 06:15:43 -0700 (PDT)
Received: from fedora.am.students.amrita.edu ([175.184.253.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970e27183sm5318985b3a.63.2025.03.30.06.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 06:15:42 -0700 (PDT)
From: Siddharth Menon <simeddon@gmail.com>
To: linux-iio@vger.kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	marcelo.schmitt1@gmail.com,
	Siddharth Menon <simeddon@gmail.com>
Subject: [PATCH v4] iio: frequency: ad9832: Use FIELD_PREP macro to set bit fields
Date: Sun, 30 Mar 2025 18:35:47 +0530
Message-ID: <20250330131531.92301-1-simeddon@gmail.com>
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
 drivers/staging/iio/frequency/ad9832.c | 85 +++++++++++++-------------
 1 file changed, 44 insertions(+), 41 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 140ee4f9c137..1017d2e305cf 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -16,6 +16,9 @@
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/unaligned.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -59,17 +62,18 @@
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
+#define RES_MASK(bits)	GENMASK((bits) - 1, 0)
+#define AD9832_CMD_MSK   GENMASK(15, 12)
+#define AD9832_ADD_MSK   GENMASK(11, 8)
+#define AD9832_DAT_MSK  GENMASK(7, 0)
 
 /**
  * struct ad9832_state - driver instance specific data
@@ -131,6 +135,8 @@ static int ad9832_write_frequency(struct ad9832_state *st,
 {
 	unsigned long clk_freq;
 	unsigned long regval;
+	u16 freq_cmd;
+	u8 regval_bytes[4];
 
 	clk_freq = clk_get_rate(st->mclk);
 
@@ -138,19 +144,15 @@ static int ad9832_write_frequency(struct ad9832_state *st,
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
+		freq_cmd = (i % 2 == 0) ? AD9832_CMD_FRE8BITSW : AD9832_CMD_FRE16BITSW;
+
+		st->freq_data[i] = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, freq_cmd) |
+			FIELD_PREP(AD9832_ADD_MSK, addr - i) |
+			FIELD_PREP(AD9832_DAT_MSK, regval_bytes[i]));
+	}
 
 	return spi_sync(st->spi, &st->freq_msg);
 }
@@ -158,15 +160,21 @@ static int ad9832_write_frequency(struct ad9832_state *st,
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
+	for (int i = 0; i < 2; i++) {
+		phase_cmd = (i % 2 == 0) ? AD9832_CMD_PHA8BITSW : AD9832_CMD_PHA16BITSW;
+
+		st->phase_data[i] = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, phase_cmd) |
+			FIELD_PREP(AD9832_ADD_MSK, addr - i) |
+			FIELD_PREP(AD9832_DAT_MSK, phase_bytes[i]));
+	}
 
 	return spi_sync(st->spi, &st->phase_msg);
 }
@@ -197,24 +205,22 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 		ret = ad9832_write_phase(st, this_attr->address, val);
 		break;
 	case AD9832_PINCTRL_EN:
-		if (val)
-			st->ctrl_ss &= ~AD9832_SELSRC;
-		else
-			st->ctrl_ss |= AD9832_SELSRC;
-		st->data = cpu_to_be16((AD9832_CMD_SYNCSELSRC << CMD_SHIFT) |
+		st->ctrl_ss &= ~AD9832_SELSRC;
+		st->ctrl_ss |= FIELD_PREP(AD9832_SELSRC, val ? 0 : 1);
+
+		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SYNCSELSRC) |
 					st->ctrl_ss);
 		ret = spi_sync(st->spi, &st->msg);
 		break;
 	case AD9832_FREQ_SYM:
-		if (val == 1) {
-			st->ctrl_fp |= AD9832_FREQ;
-		} else if (val == 0) {
+		if (val == 1 || val == 0) {
 			st->ctrl_fp &= ~AD9832_FREQ;
+			st->ctrl_fp |= FIELD_PREP(AD9832_FREQ, val ? 0 : 1);
 		} else {
 			ret = -EINVAL;
 			break;
 		}
-		st->data = cpu_to_be16((AD9832_CMD_FPSELECT << CMD_SHIFT) |
+		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
 					st->ctrl_fp);
 		ret = spi_sync(st->spi, &st->msg);
 		break;
@@ -224,21 +230,18 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 			break;
 		}
 
-		st->ctrl_fp &= ~AD9832_PHASE(3);
-		st->ctrl_fp |= AD9832_PHASE(val);
+		st->ctrl_fp &= ~FIELD_PREP(AD9832_PHASE_MASK, 3);
+		st->ctrl_fp |= FIELD_PREP(AD9832_PHASE_MASK, val ? 0 : 1);
 
-		st->data = cpu_to_be16((AD9832_CMD_FPSELECT << CMD_SHIFT) |
+		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
 					st->ctrl_fp);
 		ret = spi_sync(st->spi, &st->msg);
 		break;
 	case AD9832_OUTPUT_EN:
-		if (val)
-			st->ctrl_src &= ~(AD9832_RESET | AD9832_SLEEP |
-					AD9832_CLR);
-		else
-			st->ctrl_src |= AD9832_RESET;
+		st->ctrl_src &= ~(AD9832_RESET | AD9832_SLEEP | AD9832_CLR);
+		st->ctrl_src |= FIELD_PREP(AD9832_RESET, val ? 0 : 1);
 
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
2.49.0


