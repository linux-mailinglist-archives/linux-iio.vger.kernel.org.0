Return-Path: <linux-iio+bounces-27425-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AE4CEA9F0
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 21:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24F4A3033716
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 20:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951922868A9;
	Tue, 30 Dec 2025 20:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtS/r1bt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD26B1C4A24
	for <linux-iio@vger.kernel.org>; Tue, 30 Dec 2025 20:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767126933; cv=none; b=itO9MaIraVG1qbSd82BIynNlXqzL9c8pXhdhls+nML5Qtp5pdBfwZrHCQQZqhn1IYvmbnT4rbhf/S0gXqNA0Dtt67TeLoTVlpruCEZ5lrnncr0a1OSFNl/jHt9r7JjMh9w/tPm3euSJxVugzKD7NHLA7MxhBsMPSN59nF2/UmiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767126933; c=relaxed/simple;
	bh=uLLykXd56vesJ9HtK213SAYa5HAGc3d+EtRYj3wel3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCiynYu7JfPP7pbO7wD/V9dl+TywBDX+YvkIP85xjjKjt3oC0bSRa6f92vBqkVfDyn0cF5lMUlr4maFK7l6ZwFdHN1CNrbscmpf45sa85Bf+TyRETMwdJfyuqiwYoXjtJsmnXBNii7v1umTTWqpGbNRqPhkg/L8kmmB9zaaC8Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtS/r1bt; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b9215e55e6so6314032b3a.2
        for <linux-iio@vger.kernel.org>; Tue, 30 Dec 2025 12:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767126931; x=1767731731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6EZZUu4o39Ojycy+6hXtm+M1PWmD2n3TmdY9kxESqw=;
        b=HtS/r1btgaGJXfiYFe9SRKa3B/X6yK6yHqH9xAnqcr7wdmz5iRkkVCkmCXJ8s05o08
         zGlmOABeverShHNM0mhHtaeTVD1oDnA+qeLwab0GFjroJSU9VCAE4qsrBx4W/FqeOkkl
         b6oAJ9tM+J6sOTnMBnfcQ3u/UQlx+Y/6z5vmXnWejJl4C5zeDaQdTn1G+vLJS1flO0ao
         hXXR71D7EFebQ3CJDDtnsUg9nRKVAOPxFbMW0pEtQoOmiDfMWt7R0aqQoHfH1pUiSbH8
         mLPekKHb0MBGl93LuVPaL5rHpMc26U6FJr8Ilc2QaUuIF7XsKepOOMd8F6/BGj6TEEj6
         miYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767126931; x=1767731731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D6EZZUu4o39Ojycy+6hXtm+M1PWmD2n3TmdY9kxESqw=;
        b=I4+7jao5INKorFvHPeVW80MLm5Sf4LBds8IyXxgGKIPDm2SzZDXwX9Z3YhZKEJQl1Y
         +vdrtUblLrY1OKuHB5TXJ/L5khJ3RNo2gU2BvLiJJmZmkjpIslpuQLhki0SO/1zXZrka
         ZZtmMfdbxkrC5POUgXUJRMyqJAMkSHKUSKn+3RryUmHPbZVrae220LWKeNOAOOm6kWnl
         n3m2UdIORlLAVkFQoWU3cjsuA+FQQRKSUAuLlipaSp0O9d5clK9HtLJf7V3HEzBMeLCH
         GDseDQ/4cGRziXTwkhKFZ62wC/46gsGf4kjWvm/wm9TtpLC9ziZbXrsTvTb6QqlA0YLg
         zr+g==
X-Forwarded-Encrypted: i=1; AJvYcCXMZ5vnkgLJEicGu8d1L6CClLpUAN7mjmABMYr7vpF7fGhHrhN534TSg5jm7MAmdzHJMAdzYeVgJ+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPt+XylozZmY6mfOCHrzAdEStTON+nErbioG2JblwKVmpqGEx/
	WuyS5ObGgb9SFhwZAsY4D9VWzeDLSBJMi7JG7wgpntG4P1SjWLkqDF7+
X-Gm-Gg: AY/fxX6CyeNRE398IW/PcSD+btn9aXWQe2PBtsoJ7LFgQDm3RMe23q3tIY4QXZjcgUV
	fpjiPgcTisix/aWj/JU5hI/NaQ1olxB/WUFyJMxy8L4v6AXWvAi/0aepXJPCCL6FOP6ygguvvgy
	AMwvNlgUtit8S8AOYsbnR7FRYiknwVCdBlj1viByAICPByxCacoER53Qbjpdo6N09+2L1xRCIXZ
	7XZ3auPjs7q5n99WND5OZ7/8vKsVXqvpI/D+aThWn5K1cbGGaoX/y446nKysNS/ht6C7f7e467Z
	Po049BOPQ0ZGm4r+MhCXIDaXFv9fLMcLWsOqZvNbc2VaBM95GNDJZIXkUIV+xmHT28UgDDmFLAb
	li1YbgUgok4gZINT97na+sdHGVZnTPipleyS5PQjoN5bkedNyKAZhVjnlk/Btg1aFhOV0DQH2yO
	ZTcyFlSNTs76wlW0L9VNNj1XPoTf75U6GK2T/E0VPDUAdoKOqkEFEFUCBFv9zyb07Z3cUSAezTB
	Buegr2BNYx1uudwYMROqaIDqdbMHDwG38EP6gIB0qw0O4KMeBtRn9uNKc46CBLE7QrKgW+012zy
	iCmF+/A=
X-Google-Smtp-Source: AGHT+IF+K7pA6VCVFKzIOiSozceFllQ94quSzKO77YM3movakFJsFMOcOUPfcfwEKoSQVCgPOYQFtQ==
X-Received: by 2002:a05:7022:1e11:b0:11b:9386:8272 with SMTP id a92af1059eb24-1217231272amr33588237c88.47.1767126930864;
        Tue, 30 Dec 2025 12:35:30 -0800 (PST)
Received: from Lewboski.localdomain ([181.191.143.75])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253c23csm128074981c88.9.2025.12.30.12.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 12:35:30 -0800 (PST)
From: Tomas Borquez <tomasborquez13@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Tomas Borquez <tomasborquez13@gmail.com>
Subject: [PATCH v2 2/6] staging: iio: ad9832: convert to guard(mutex)
Date: Tue, 30 Dec 2025 17:34:55 -0300
Message-ID: <20251230203459.28935-3-tomasborquez13@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251230203459.28935-1-tomasborquez13@gmail.com>
References: <20251230203459.28935-1-tomasborquez13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use guard(mutex) for cleaner lock handling and simpler error paths.

Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 41 +++++++++++---------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index a5523e2210bf..35d8d51d5c2b 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -9,6 +9,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -179,20 +180,20 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 
 	ret = kstrtoul(buf, 10, &val);
 	if (ret)
-		goto error_ret;
+		return ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	switch ((u32)this_attr->address) {
 	case AD9832_FREQ0HM:
 	case AD9832_FREQ1HM:
 		ret = ad9832_write_frequency(st, this_attr->address, val);
-		break;
+		return ret ?: len;
 	case AD9832_PHASE0H:
 	case AD9832_PHASE1H:
 	case AD9832_PHASE2H:
 	case AD9832_PHASE3H:
 		ret = ad9832_write_phase(st, this_attr->address, val);
-		break;
+		return ret ?: len;
 	case AD9832_PINCTRL_EN:
 		st->ctrl_ss &= ~AD9832_SELSRC;
 		st->ctrl_ss |= FIELD_PREP(AD9832_SELSRC, val ? 0 : 1);
@@ -200,24 +201,20 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SYNCSELSRC) |
 						  st->ctrl_ss);
 		ret = spi_sync(st->spi, &st->msg);
-		break;
+		return ret ?: len;
 	case AD9832_FREQ_SYM:
-		if (val == 1 || val == 0) {
-			st->ctrl_fp &= ~AD9832_FREQ;
-			st->ctrl_fp |= FIELD_PREP(AD9832_FREQ, val ? 1 : 0);
-		} else {
-			ret = -EINVAL;
-			break;
-		}
+		if (val != 1 && val != 0)
+			return -EINVAL;
+
+		st->ctrl_fp &= ~AD9832_FREQ;
+		st->ctrl_fp |= FIELD_PREP(AD9832_FREQ, val ? 1 : 0);
 		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
 						  st->ctrl_fp);
 		ret = spi_sync(st->spi, &st->msg);
-		break;
+		return ret ?: len;
 	case AD9832_PHASE_SYM:
-		if (val > 3) {
-			ret = -EINVAL;
-			break;
-		}
+		if (val > 3)
+			return -EINVAL;
 
 		st->ctrl_fp &= ~AD9832_PHASE_MASK;
 		st->ctrl_fp |= FIELD_PREP(AD9832_PHASE_MASK, val);
@@ -225,7 +222,7 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
 						  st->ctrl_fp);
 		ret = spi_sync(st->spi, &st->msg);
-		break;
+		return ret ?: len;
 	case AD9832_OUTPUT_EN:
 		if (val)
 			st->ctrl_src &= ~(AD9832_RESET | AD9832_SLEEP | AD9832_CLR);
@@ -235,14 +232,10 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SLEEPRESCLR) |
 						  st->ctrl_src);
 		ret = spi_sync(st->spi, &st->msg);
-		break;
+		return ret ?: len;
 	default:
-		ret = -ENODEV;
+		return -ENODEV;
 	}
-	mutex_unlock(&st->lock);
-
-error_ret:
-	return ret ? ret : len;
 }
 
 /*
-- 
2.43.0


