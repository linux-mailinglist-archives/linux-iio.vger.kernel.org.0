Return-Path: <linux-iio+bounces-26811-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A988CA9445
	for <lists+linux-iio@lfdr.de>; Fri, 05 Dec 2025 21:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2835B310A250
	for <lists+linux-iio@lfdr.de>; Fri,  5 Dec 2025 20:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68F176026;
	Fri,  5 Dec 2025 20:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzfuRrA2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932262D77F6
	for <linux-iio@vger.kernel.org>; Fri,  5 Dec 2025 20:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764966510; cv=none; b=f/IwO/LCvKVa8ujbJ7mQJzEUpyjKc8JbuVHdhezp9/l32kczHqYiXqO7QDOZuVbAul7krot85mV9A+JO69YluHrvaeDZYxORg88fSrsL+IpkZcFLTzrEDIKh5/e2bttsMRRpoyQtYTym2YFg5up2zoZe7k53Fgn3k2FrhhPwP8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764966510; c=relaxed/simple;
	bh=fuS5ThsXhqrYsuTOSDf0ZJ72zB84bz5qASa0OMJmDbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KP1K4GfnJ9xrSShReuqzmr3QnU1NGms0/XrsOv/3rpXCtujWQIdWV//wbLNbCXHRKsdb/W3g82EunIMNfmWbzzBDfOn0h0c1zDdlzl0abukYjIxjFZ6UDt8JnaGpJrq4VB1QmFLaBDL4+5SVyQSr8wLj1TSU/9s5nziwzMsF2hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzfuRrA2; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29586626fbeso31644015ad.0
        for <linux-iio@vger.kernel.org>; Fri, 05 Dec 2025 12:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764966508; x=1765571308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQNcQPNLKKY2BeCq1O0OFp8TedTaZIsxUpeca8Qcn0U=;
        b=CzfuRrA2syWwWyxiTu48XIP8EwQxVLs/wt4/++c+cnJYc4p7/HvhaqGkQNXHEhoEw2
         veJriLCZYSK3Tl8/NEMxz/lPCe/mvePILEFFLdhPHaRJIv3lydycHy9DeXZX7rQTdUwJ
         EBCpI1IresFZjX3gCkohnEEICS8qcFb/PpZotwUhRbmbzcdPi2I6foL8ZSHRyL5nuimG
         WX9ffGuw51p7WcYkRaZrfWtS295GQqiFxeEnapN2UY8lzSvCxYYCXYrGgblKkbmru9r3
         REZpMwqobiSvVroneMJKkx19YTi02+z9mnNb3Do6CtGerS4ZpJp2rqamC2cJQeOU+oRU
         P95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764966508; x=1765571308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dQNcQPNLKKY2BeCq1O0OFp8TedTaZIsxUpeca8Qcn0U=;
        b=BPQC7ElPx3kM6aWsg1iTslfZL52Wljbutso1bJNyrxJ5wUU+t+lm+7C4n5wH5reB+e
         2sT+xL4wFq88B86481hBz6R4zsPXHsilyAGEhWZ6Ko4W8YhUnebNBH+rjzPhLQok+REs
         mL4AmgoVY4bWblhwOrwuxbVd2/mOTDyiAozpHW27D4kFdCA9LAFJ91mT5VPOIZCNylSr
         KBgwAi8IYkbC4u2AM1ALoAP8/ogE58QUGzxVDGijN2j+9uaB/4JuRWqnYeVBOZcBYihR
         0fqd5iSMqMEn8GGE1XDaJIRWgNYPv0/8tg1dZhK+ae08AvMhWKoScaLeJvtwwXP1dJMc
         bIqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsd5Bu3zpBuZgaditcLyR2/lMY0MAYuK9SlPYU3aZ+CWnNScjt1era/wSmKdlmccBUwjGap4zp+W0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHeuUHZv+h3DWipcowEBTPRJemjcUCN7lfVp28E+61/dNHhhNv
	3nznQ73zWZ/d+dzJgyg0dUExBeL0IcagjlqFa6dF4o5+rxJu5egLh1jM
X-Gm-Gg: ASbGncseWCORcbWcYBJipucEXZ5E2UO5GeW2MiYlqNQfu78aWr6ykzoksSapZkFAZgT
	npq4VEZohHUbTbBDsGMDuZAbKmxlpfN3PY58vs1Y4R//fyDjZxRfiEEUFX1fu37EI83u95M7eMz
	WKQYC2dxLZxZL9x6FsebVjHGNTtFvv1JiaMsrmfbhOy8sOZZtWHGvHg+Wba0nWu1iHgi2lDA6bN
	xYaK3BCKO6TkgqQkfN5GW7zU6Pc6cm8aQHP/L/bulPpIqK5lOQPL11jFzVSoQoXwvKBZd/l3V5i
	rCY7zLM2JAYBY6EsmPC/1INI53SS8Z2aZOry3ZkAfsMLNC7naJ2bI+/FZjgZETkMVDJTYOU+4U/
	PV79bLVSUDZnxyToYW2feHvEZyU6c6icnpXkeTcf7D1A7/fkaK8QY0GniQDp6A+F/ay9tYcwvVo
	LSd7qZMZl1RFoqPs5XUfm+ceFjdfs5PcxeCP2VKqBRmDTHRA5J/Y8T7EjgPm0o5gyoPYKlo9Fye
	pLSMNmCsCW8IIhdbLM1s9uSPtqBusZmJjRA/7UhqALiIx7OToE7/3ZnZMs0ADfOHJPf0/RnF8zX
	vwgQdKU=
X-Google-Smtp-Source: AGHT+IGLHZapmXgdKrIKPSCz1pMcaFW0HtbEIVANbV6SbOUsG6gLOejCmPAUZXk9+6nCOOKIUe5tbQ==
X-Received: by 2002:a17:903:178b:b0:29d:f653:17c0 with SMTP id d9443c01a7336-29df6531a61mr1749905ad.12.1764966507675;
        Fri, 05 Dec 2025 12:28:27 -0800 (PST)
Received: from Lewboski.localdomain ([181.191.143.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae99fa59sm57256845ad.58.2025.12.05.12.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 12:28:27 -0800 (PST)
From: Tomas Borquez <tomasborquez13@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Tomas Borquez <tomasborquez13@gmail.com>
Subject: [RFC PATCH 2/3] staging: iio: ad9832: convert to iio channels
Date: Fri,  5 Dec 2025 17:27:42 -0300
Message-ID: <20251205202743.10530-3-tomasborquez13@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205202743.10530-1-tomasborquez13@gmail.com>
References: <20251205202743.10530-1-tomasborquez13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the custom frequency and phase sysfs attributes with IIO channels
using read_raw()/write_raw() callbacks, as well as removing the dds.h
header.

Changes:
- Add iio_chan_spec definitions for 2 frequency and 4 phase channels.
- Implement read_raw/write_raw for IIO_CHAN_INFO_FREQUENCY/PHASE.
- Cache frequency and phase values in driver state for readback.
- Remove dependency on dds.h macros for sysfs.
- Use guard(mutex) for cleaner locking.
- Add input validation and consistent error messages.

NOTE: This changes the userspace ABI, see cover letter.
Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 232 ++++++++++++++++++-------
 1 file changed, 168 insertions(+), 64 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index e2ad3e5a7a..79d26009d1 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -9,6 +9,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -23,10 +24,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-#include "dds.h"
-
 /* Registers */
-
 #define AD9832_FREQ0LL		0x0
 #define AD9832_FREQ0HL		0x1
 #define AD9832_FREQ0LM		0x2
@@ -50,7 +48,6 @@
 #define AD9832_OUTPUT_EN	0x13
 
 /* Command Control Bits */
-
 #define AD9832_CMD_PHA8BITSW	0x1
 #define AD9832_CMD_PHA16BITSW	0x0
 #define AD9832_CMD_FRE8BITSW	0x3
@@ -79,6 +76,8 @@
  * @ctrl_fp:		cached frequency/phase control word
  * @ctrl_ss:		cached sync/selsrc control word
  * @ctrl_src:		cached sleep/reset/clr word
+ * @freq:		cached frequencies
+ * @phase:		cached phases
  * @xfer:		default spi transfer
  * @msg:		default spi message
  * @freq_xfer:		tuning word spi transfer
@@ -90,13 +89,14 @@
  * @phase_data:		tuning word spi transmit buffer
  * @freq_data:		tuning word spi transmit buffer
  */
-
 struct ad9832_state {
 	struct spi_device		*spi;
 	struct clk			*mclk;
 	unsigned short			ctrl_fp;
 	unsigned short			ctrl_ss;
 	unsigned short			ctrl_src;
+	u32				freq[2];
+	u32				phase[4];
 	struct spi_transfer		xfer;
 	struct spi_message		msg;
 	struct spi_transfer		freq_xfer[4];
@@ -115,7 +115,7 @@ struct ad9832_state {
 	} __aligned(IIO_DMA_MINALIGN);
 };
 
-static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
+static unsigned long ad9832_calc_freqreg(unsigned long mclk, u32 fout)
 {
 	unsigned long long freqreg = (u64)fout *
 				     (u64)((u64)1L << AD9832_FREQ_BITS);
@@ -124,12 +124,24 @@ static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
 }
 
 static int ad9832_write_frequency(struct ad9832_state *st,
-				  unsigned int addr, unsigned long fout)
+				  unsigned int addr, u32 fout)
 {
 	unsigned long clk_freq;
 	unsigned long regval;
 	u8 regval_bytes[4];
 	u16 freq_cmd;
+	int ret, idx;
+
+	switch (addr) {
+	case AD9832_FREQ0HM:
+		idx = 0;
+		break;
+	case AD9832_FREQ1HM:
+		idx = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	clk_freq = clk_get_rate(st->mclk);
 
@@ -147,14 +159,37 @@ static int ad9832_write_frequency(struct ad9832_state *st,
 			FIELD_PREP(AD9832_DAT_MSK, regval_bytes[i]));
 	}
 
-	return spi_sync(st->spi, &st->freq_msg);
+	ret = spi_sync(st->spi, &st->freq_msg);
+	if (ret)
+		return ret;
+
+	st->freq[idx] = fout;
+	return 0;
 }
 
 static int ad9832_write_phase(struct ad9832_state *st,
-			      unsigned long addr, unsigned long phase)
+			      unsigned long addr, u32 phase)
 {
 	u8 phase_bytes[2];
 	u16 phase_cmd;
+	int ret, idx;
+
+	switch (addr) {
+	case AD9832_PHASE0H:
+		idx = 0;
+		break;
+	case AD9832_PHASE1H:
+		idx = 1;
+		break;
+	case AD9832_PHASE2H:
+		idx = 2;
+		break;
+	case AD9832_PHASE3H:
+		idx = 3;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	if (phase >= BIT(AD9832_PHASE_BITS))
 		return -EINVAL;
@@ -169,10 +204,77 @@ static int ad9832_write_phase(struct ad9832_state *st,
 			FIELD_PREP(AD9832_DAT_MSK, phase_bytes[i]));
 	}
 
-	return spi_sync(st->spi, &st->phase_msg);
+	ret = spi_sync(st->spi, &st->phase_msg);
+	if (ret)
+		return ret;
+
+	st->phase[idx] = phase;
+	return 0;
 }
 
-static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
+static int ad9832_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	struct ad9832_state *st = iio_priv(indio_dev);
+
+	if (val < 0)
+		return -EINVAL;
+
+	guard(mutex)(&st->lock);
+	switch (mask) {
+	case IIO_CHAN_INFO_FREQUENCY:
+		return ad9832_write_frequency(st, chan->address, val);
+	case IIO_CHAN_INFO_PHASE:
+		return ad9832_write_phase(st, chan->address, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad9832_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct ad9832_state *st = iio_priv(indio_dev);
+
+	guard(mutex)(&st->lock);
+	switch (mask) {
+	case IIO_CHAN_INFO_FREQUENCY:
+		switch (chan->address) {
+		case AD9832_FREQ0HM:
+			*val = st->freq[0];
+			return IIO_VAL_INT;
+		case AD9832_FREQ1HM:
+			*val = st->freq[1];
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_PHASE:
+		switch (chan->address) {
+		case AD9832_PHASE0H:
+			*val = st->phase[0];
+			return IIO_VAL_INT;
+		case AD9832_PHASE1H:
+			*val = st->phase[1];
+			return IIO_VAL_INT;
+		case AD9832_PHASE2H:
+			*val = st->phase[2];
+			return IIO_VAL_INT;
+		case AD9832_PHASE3H:
+			*val = st->phase[3];
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static ssize_t ad9832_store(struct device *dev,
+			    struct device_attribute *attr,
 			    const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -183,20 +285,10 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 
 	ret = kstrtoul(buf, 10, &val);
 	if (ret)
-		goto error_ret;
+		return ret;
 
-	mutex_lock(&st->lock);
-	switch ((u32)this_attr->address) {
-	case AD9832_FREQ0HM:
-	case AD9832_FREQ1HM:
-		ret = ad9832_write_frequency(st, this_attr->address, val);
-		break;
-	case AD9832_PHASE0H:
-	case AD9832_PHASE1H:
-	case AD9832_PHASE2H:
-	case AD9832_PHASE3H:
-		ret = ad9832_write_phase(st, this_attr->address, val);
-		break;
+	guard(mutex)(&st->lock);
+	switch (this_attr->address) {
 	case AD9832_PINCTRL_EN:
 		st->ctrl_ss &= ~AD9832_SELSRC;
 		st->ctrl_ss |= FIELD_PREP(AD9832_SELSRC, val ? 0 : 1);
@@ -206,13 +298,13 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 		ret = spi_sync(st->spi, &st->msg);
 		break;
 	case AD9832_FREQ_SYM:
-		if (val == 1 || val == 0) {
-			st->ctrl_fp &= ~AD9832_FREQ;
-			st->ctrl_fp |= FIELD_PREP(AD9832_FREQ, val ? 1 : 0);
-		} else {
+		if (val != 1 && val != 0) {
 			ret = -EINVAL;
 			break;
 		}
+
+		st->ctrl_fp &= ~AD9832_FREQ;
+		st->ctrl_fp |= FIELD_PREP(AD9832_FREQ, val);
 		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
 						  st->ctrl_fp);
 		ret = spi_sync(st->spi, &st->msg);
@@ -243,47 +335,56 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 	default:
 		ret = -ENODEV;
 	}
-	mutex_unlock(&st->lock);
 
-error_ret:
 	return ret ? ret : len;
 }
 
-/*
- * see dds.h for further information
- */
+#define AD9832_CHAN_FREQ(_channel, _addr) {			\
+	.type = IIO_ALTVOLTAGE,					\
+	.output = 1,						\
+	.indexed = 1,						\
+	.channel = _channel,					\
+	.address = _addr,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_FREQUENCY),	\
+}
 
-static IIO_DEV_ATTR_FREQ(0, 0, 0200, NULL, ad9832_write, AD9832_FREQ0HM);
-static IIO_DEV_ATTR_FREQ(0, 1, 0200, NULL, ad9832_write, AD9832_FREQ1HM);
-static IIO_DEV_ATTR_FREQSYMBOL(0, 0200, NULL, ad9832_write, AD9832_FREQ_SYM);
-static IIO_CONST_ATTR_FREQ_SCALE(0, "1"); /* 1Hz */
+#define AD9832_CHAN_PHASE(_channel, _addr) {			\
+	.type = IIO_ALTVOLTAGE,					\
+	.output = 1,						\
+	.indexed = 1,						\
+	.channel = _channel,					\
+	.address = _addr,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_PHASE),		\
+}
+
+static const struct iio_chan_spec ad9832_channels[] = {
+	AD9832_CHAN_FREQ(0, AD9832_FREQ0HM),
+	AD9832_CHAN_FREQ(1, AD9832_FREQ1HM),
+	AD9832_CHAN_PHASE(2, AD9832_PHASE0H),
+	AD9832_CHAN_PHASE(3, AD9832_PHASE1H),
+	AD9832_CHAN_PHASE(4, AD9832_PHASE2H),
+	AD9832_CHAN_PHASE(5, AD9832_PHASE3H),
+};
 
-static IIO_DEV_ATTR_PHASE(0, 0, 0200, NULL, ad9832_write, AD9832_PHASE0H);
-static IIO_DEV_ATTR_PHASE(0, 1, 0200, NULL, ad9832_write, AD9832_PHASE1H);
-static IIO_DEV_ATTR_PHASE(0, 2, 0200, NULL, ad9832_write, AD9832_PHASE2H);
-static IIO_DEV_ATTR_PHASE(0, 3, 0200, NULL, ad9832_write, AD9832_PHASE3H);
-static IIO_DEV_ATTR_PHASESYMBOL(0, 0200, NULL,
-				ad9832_write, AD9832_PHASE_SYM);
-static IIO_CONST_ATTR_PHASE_SCALE(0, "0.0015339808"); /* 2PI/2^12 rad*/
+static IIO_CONST_ATTR(out_altvoltage_frequency_scale, "1");	   /* 1Hz */
+static IIO_CONST_ATTR(out_altvoltage_phase_scale, "0.0015339808"); /* 2PI / 2^12 rad */
 
-static IIO_DEV_ATTR_PINCONTROL_EN(0, 0200, NULL,
-				ad9832_write, AD9832_PINCTRL_EN);
-static IIO_DEV_ATTR_OUT_ENABLE(0, 0200, NULL,
-				ad9832_write, AD9832_OUTPUT_EN);
+static IIO_DEVICE_ATTR(out_altvoltage_frequencysymbol, 0200, NULL,
+		       ad9832_store, AD9832_FREQ_SYM);
+static IIO_DEVICE_ATTR(out_altvoltage_phasesymbol, 0200, NULL,
+		       ad9832_store, AD9832_PHASE_SYM);
+static IIO_DEVICE_ATTR(out_altvoltage_out_enable, 0200, NULL,
+		       ad9832_store, AD9832_OUTPUT_EN);
+static IIO_DEVICE_ATTR(out_altvoltage_pincontrol_en, 0200, NULL,
+		       ad9832_store, AD9832_PINCTRL_EN);
 
 static struct attribute *ad9832_attributes[] = {
-	&iio_dev_attr_out_altvoltage0_frequency0.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_frequency1.dev_attr.attr,
-	&iio_const_attr_out_altvoltage0_frequency_scale.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_phase0.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_phase1.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_phase2.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_phase3.dev_attr.attr,
-	&iio_const_attr_out_altvoltage0_phase_scale.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_pincontrol_en.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_frequencysymbol.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_phasesymbol.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_out_enable.dev_attr.attr,
+	&iio_const_attr_out_altvoltage_frequency_scale.dev_attr.attr,
+	&iio_const_attr_out_altvoltage_phase_scale.dev_attr.attr,
+	&iio_dev_attr_out_altvoltage_frequencysymbol.dev_attr.attr,
+	&iio_dev_attr_out_altvoltage_phasesymbol.dev_attr.attr,
+	&iio_dev_attr_out_altvoltage_out_enable.dev_attr.attr,
+	&iio_dev_attr_out_altvoltage_pincontrol_en.dev_attr.attr,
 	NULL,
 };
 
@@ -292,6 +393,8 @@ static const struct attribute_group ad9832_attribute_group = {
 };
 
 static const struct iio_info ad9832_info = {
+	.write_raw = ad9832_write_raw,
+	.read_raw = ad9832_read_raw,
 	.attrs = &ad9832_attribute_group,
 };
 
@@ -309,15 +412,15 @@ static int ad9832_probe(struct spi_device *spi)
 
 	ret = devm_regulator_get_enable(&spi->dev, "avdd");
 	if (ret)
-		return dev_err_probe(&spi->dev, ret, "failed to enable specified AVDD voltage\n");
+		return dev_err_probe(&spi->dev, ret, "failed to enable AVDD supply\n");
 
 	ret = devm_regulator_get_enable(&spi->dev, "dvdd");
 	if (ret)
-		return dev_err_probe(&spi->dev, ret, "Failed to enable specified DVDD supply\n");
+		return dev_err_probe(&spi->dev, ret, "failed to enable DVDD supply\n");
 
 	st->mclk = devm_clk_get_enabled(&spi->dev, "mclk");
 	if (IS_ERR(st->mclk))
-		return PTR_ERR(st->mclk);
+		return dev_err_probe(&spi->dev, PTR_ERR(st->mclk), "failed to enable MCLK\n");
 
 	st->spi = spi;
 	mutex_init(&st->lock);
@@ -325,9 +428,10 @@ static int ad9832_probe(struct spi_device *spi)
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad9832_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ad9832_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad9832_channels);
 
 	/* Setup default messages */
-
 	st->xfer.tx_buf = &st->data;
 	st->xfer.len = 2;
 
-- 
2.43.0


