Return-Path: <linux-iio+bounces-27428-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B435CCEA9FF
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 21:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BF5A3044BB6
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 20:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304042C21CF;
	Tue, 30 Dec 2025 20:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3YuXqZ4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8D52749CF
	for <linux-iio@vger.kernel.org>; Tue, 30 Dec 2025 20:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767126944; cv=none; b=PZne0occMR3Z+yNEXeI6A3R5sv8+mnsqo6mhUAayFPY1QwIB0v/viurMUdSpl49cHaByMGOAfjC/U+zw5jsUBtVlVcbqEPC6JwnEsGBrOeB0pYJIPl5NKa69xQB6QDIkza+oPmUGuf/F0TrBlIoLWC1zBtUMBafIq+BwYwyKtR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767126944; c=relaxed/simple;
	bh=/mr7jAHWehIfBBNJdaqw0qimb+vHg2lEkR+W/uqT7i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKpUQATQVH3E/6YEBC80zMUdZHdpMgq6KSm6Pq8BvsIcVvc+sEPPXmde2S6YuMnAHljLH4matKMzgK/gtk3erZ7C+IBImaqrTRwf/QlaLqEelJXBeAJL88clmA3R3KOR9jhVUdTizlEw2/TPlnnT7OvKisLVfbcm0/E1nu3i0NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3YuXqZ4; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-bd1ce1b35e7so6974411a12.0
        for <linux-iio@vger.kernel.org>; Tue, 30 Dec 2025 12:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767126941; x=1767731741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxRJRyxZlhtlgsmSDlbCysKvgjjG2u+h0tl7Hk7tzUU=;
        b=A3YuXqZ49WdViQqKcLYlgwKYzotBaggcvXpA1YFJ6tfeajGLvRnTOMZXO6wp6vxeN4
         jLBFqR652zbNKZbXiys7JZ1+vJpVti3TXgp5juDJ9OqjkbxhzDKTYJu1xL79VGwO9ogv
         05+MpxJ5THJHIt+7ffyp7UAfxaV/QnqwdR47KAfHgwpu8Zd9ojzoJCwA1+kfoFGRxZay
         vehPlfNNhdU3k2crAVJ/y2TT9/+bhkHqpnRzyl9TaglPreGDSdKSFjBMGDZYdXzw0Nnm
         3qX+uyrSYWwmsypP3RAh/Zh25VaqoYnapgxrPJeeyUfkyMLWHwV6wVZYCRB1coxApSc2
         XowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767126941; x=1767731741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DxRJRyxZlhtlgsmSDlbCysKvgjjG2u+h0tl7Hk7tzUU=;
        b=cNe+Y3YStqSNQtk1rZdKgNnY1r37qedJy3kFZyv8lOJlBfWDMeQZYOFl5d9VnNYrTw
         aFxpS70dAGZDHuGHJAvBgXJz3N7e8Wd3yeGacKATS4gLdhoT9NZQ2dIXSyQ4ZylAzWJj
         ipbYVtrskRlp2FL2jcOUr5Vw3ZzwSOIV4rvRClazz0n2EdDM/REFXumJCvsZ5/HOTmdd
         h4TupawN+BpuFS8XX5Ex0f6J5dIapTXEooUnnqpsk/oJ/cWloxTCOA4cmNKVcubfU3o7
         H6IMkzSOMJ/Mwuu0ls65/UD1G0FldWPq0SfvVQdXI/U+B/9tYFhlypWO5fJMfZSh6/Ue
         BsXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXWEuHiYIcESz2TvzAQ8vBzY2mKlA3kerwVmfcZI/UpXJvVFzS1+H1zZVV10STKK3qELet35Z3tys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdRKf6SoRlnoflz9nNrb37KTYk1jWOi7ngOiNO4jAj7pKrTjHu
	xOxeV2Aii2YS7pi8j7zvSqYjORngfnmBIfoRu+KtQpsXW41qz93LfYsU
X-Gm-Gg: AY/fxX7Hy1l/ZFfK55RJ3ofmv0J7yOdOHTNUPIQWrcqTrTNlQhevHypKcecL7ndjl/i
	H4WB6800VAth217GF2PPIdWbVy3w/uWJ+1Tr3Gy0LIILVkcMe0MP2ZL6NRa5uOuBREA7Ja5yZZi
	gXIg2/LXinbUP5ChNzvYRYwwPv4EZ/DANgma5sCXt8lfRC36PLMkOpz2xiMtINwda0etTmqPuIl
	Eqwf+rWKC2WuvmnUJXj3muLi/PVwRGFRVtQjsHWU8IrnuXJHQ3vg4r/ebaOa6W/c5OAjbrVvmrA
	A+uWE74WHUgYdk2nk6J+Q+qi130x8cj0gTrBMsvDomPi7lASnXpxaeMV8ZeAS0CthRnJ/u7e+mC
	/3V5V0o7Y4uNtiNKGSPCwC5dFTPc7hUIxIDB0zqtRZeR4s2uRjrcw/nHRLOrAXHKUo3KzuxiwtO
	jhtGAiwUrHvXkcTOlM9Cd4991332leVZLoLwTksNVA4Zby8hOQWkM0Tg+Wmt34oxUO0y2CpsY9Y
	qaAOHMP8ENkDQg0XPh4wCL9He/k58vY2R8e82QYqBdOySy5TXdazW0fXvaZekCbwgxeOAgA
X-Google-Smtp-Source: AGHT+IGdV3a18S3AHIdeFWIGU/8fpVHk1Lnq+/qC7R4wL3MLfq7w14AnuYvzQgqOK185nj0iA7osJA==
X-Received: by 2002:a05:7022:e04:b0:11b:d211:3a64 with SMTP id a92af1059eb24-1217213fb1fmr38837120c88.0.1767126940983;
        Tue, 30 Dec 2025 12:35:40 -0800 (PST)
Received: from Lewboski.localdomain ([181.191.143.75])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253c23csm128074981c88.9.2025.12.30.12.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 12:35:40 -0800 (PST)
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
Subject: [PATCH v2 5/6] staging: iio: ad9832: convert to iio channels and ext_info attrs
Date: Tue, 30 Dec 2025 17:34:58 -0300
Message-ID: <20251230203459.28935-6-tomasborquez13@gmail.com>
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

Convert ad9832 from sysfs attributes to standard channel interface
using a single IIO_ALTCURRENT channel with ext_info attributes, as this
device is a current source DAC with one output.

Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 278 +++++++++++++++++++------
 1 file changed, 220 insertions(+), 58 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index aa78973c3a3c..47b41b9eb14f 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -20,6 +20,7 @@
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
 #include <linux/unaligned.h>
+#include <linux/units.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -64,6 +65,7 @@
 #define AD9832_CLR		BIT(11)
 #define AD9832_FREQ_BITS	32
 #define AD9832_PHASE_BITS	12
+#define AD9832_2PI_URAD		6283185UL
 #define AD9832_CMD_MSK		GENMASK(15, 12)
 #define AD9832_ADD_MSK		GENMASK(11, 8)
 #define AD9832_DAT_MSK		GENMASK(7, 0)
@@ -75,6 +77,12 @@
  * @ctrl_fp:		cached frequency/phase control word
  * @ctrl_ss:		cached sync/selsrc control word
  * @ctrl_src:		cached sleep/reset/clr word
+ * @freq:		cached frequencies
+ * @freq_sym:		cached frequency symbol selection
+ * @phase:		cached phases
+ * @phase_sym:		cached phase symbol selection
+ * @output_en:		cached output enable state
+ * @pinctrl_en:		cached pinctrl enable state
  * @xfer:		default spi transfer
  * @msg:		default spi message
  * @freq_xfer:		tuning word spi transfer
@@ -92,6 +100,12 @@ struct ad9832_state {
 	unsigned short			ctrl_fp;
 	unsigned short			ctrl_ss;
 	unsigned short			ctrl_src;
+	u32				freq[2];
+	bool				freq_sym;
+	u32				phase[4];
+	u32				phase_sym;
+	bool				output_en;
+	bool				pinctrl_en;
 	struct spi_transfer		xfer;
 	struct spi_message		msg;
 	struct spi_transfer		freq_xfer[4];
@@ -110,7 +124,7 @@ struct ad9832_state {
 	} __aligned(IIO_DMA_MINALIGN);
 };
 
-static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
+static unsigned long ad9832_calc_freqreg(unsigned long mclk, u32 fout)
 {
 	unsigned long long freqreg = (u64)fout *
 				     (u64)((u64)1L << AD9832_FREQ_BITS);
@@ -118,19 +132,33 @@ static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
 	return freqreg;
 }
 
-static int ad9832_write_frequency(struct ad9832_state *st,
-				  unsigned int addr, unsigned long fout)
+static ssize_t ad9832_write_frequency(struct iio_dev *indio_dev,
+				      uintptr_t private,
+				      struct iio_chan_spec const *chan,
+				      const char *buf, size_t len)
 {
+	struct ad9832_state *st = iio_priv(indio_dev);
 	unsigned long clk_freq;
 	unsigned long regval;
 	u8 regval_bytes[4];
 	u16 freq_cmd;
+	u32 fout, addr;
+	int ret;
 
-	clk_freq = clk_get_rate(st->mclk);
+	if (private > 1)
+		return -EINVAL;
+
+	addr = (private == 0) ? AD9832_FREQ0HM : AD9832_FREQ1HM;
+
+	ret = kstrtou32(buf, 10, &fout);
+	if (ret)
+		return ret;
 
+	clk_freq = clk_get_rate(st->mclk);
 	if (!clk_freq || fout > (clk_freq / 2))
 		return -EINVAL;
 
+	guard(mutex)(&st->lock);
 	regval = ad9832_calc_freqreg(clk_freq, fout);
 	put_unaligned_be32(regval, regval_bytes);
 
@@ -142,32 +170,102 @@ static int ad9832_write_frequency(struct ad9832_state *st,
 			FIELD_PREP(AD9832_DAT_MSK, regval_bytes[i]));
 	}
 
-	return spi_sync(st->spi, &st->freq_msg);
+	ret = spi_sync(st->spi, &st->freq_msg);
+	if (ret)
+		return ret;
+
+	st->freq[private] = fout;
+
+	return len;
+}
+
+static ssize_t ad9832_read_frequency(struct iio_dev *indio_dev,
+				     uintptr_t private,
+				     struct iio_chan_spec const *chan,
+				     char *buf)
+{
+	struct ad9832_state *st = iio_priv(indio_dev);
+	u32 val;
+
+	if (private > 1)
+		return -EINVAL;
+
+	guard(mutex)(&st->lock);
+	val = st->freq[private];
+
+	return sysfs_emit(buf, "%u\n", val);
 }
 
-static int ad9832_write_phase(struct ad9832_state *st,
-			      unsigned long addr, unsigned long phase)
+static const u32 ad9832_phase_addr[] = {
+	AD9832_PHASE0H, AD9832_PHASE1H, AD9832_PHASE2H, AD9832_PHASE3H
+};
+
+static ssize_t ad9832_write_phase(struct iio_dev *indio_dev,
+				  uintptr_t private,
+				  struct iio_chan_spec const *chan,
+				  const char *buf, size_t len)
 {
+	struct ad9832_state *st = iio_priv(indio_dev);
 	u8 phase_bytes[2];
 	u16 phase_cmd;
+	u32 phase_urad, phase;
+	int val, val2, ret;
 
-	if (phase >= BIT(AD9832_PHASE_BITS))
+	if (private >= ARRAY_SIZE(ad9832_phase_addr))
 		return -EINVAL;
 
-	put_unaligned_be16(phase, phase_bytes);
+	ret = iio_str_to_fixpoint(buf, 100000, &val, &val2);
+	if (ret)
+		return ret;
+
+	if (val < 0 || val2 < 0)
+		return -EINVAL;
+
+	phase_urad = val * MICRO + val2;
+	if (phase_urad >= AD9832_2PI_URAD)
+		return -EINVAL;
 
+	/* Convert microradians to 12-bit phase register value (0 to 4095) */
+	phase = ((u64)phase_urad << AD9832_PHASE_BITS) / AD9832_2PI_URAD;
+
+	guard(mutex)(&st->lock);
+	put_unaligned_be16(phase, phase_bytes);
 	for (int i = 0; i < ARRAY_SIZE(phase_bytes); i++) {
 		phase_cmd = (i % 2 == 0) ? AD9832_CMD_PHA8BITSW : AD9832_CMD_PHA16BITSW;
 
 		st->phase_data[i] = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, phase_cmd) |
-			FIELD_PREP(AD9832_ADD_MSK, addr - i) |
+			FIELD_PREP(AD9832_ADD_MSK, ad9832_phase_addr[private] - i) |
 			FIELD_PREP(AD9832_DAT_MSK, phase_bytes[i]));
 	}
 
-	return spi_sync(st->spi, &st->phase_msg);
+	ret = spi_sync(st->spi, &st->phase_msg);
+	if (ret)
+		return ret;
+
+	st->phase[private] = phase;
+
+	return len;
 }
 
-static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
+static ssize_t ad9832_read_phase(struct iio_dev *indio_dev,
+				 uintptr_t private,
+				 struct iio_chan_spec const *chan,
+				 char *buf)
+{
+	struct ad9832_state *st = iio_priv(indio_dev);
+	u32 phase_urad;
+
+	if (private >= ARRAY_SIZE(ad9832_phase_addr))
+		return -EINVAL;
+
+	guard(mutex)(&st->lock);
+	phase_urad = ((u64)st->phase[private] * AD9832_2PI_URAD) >> AD9832_PHASE_BITS;
+
+	return sysfs_emit(buf, "%u.%06u\n", phase_urad / (u32)MICRO, phase_urad % (u32)MICRO);
+}
+
+static ssize_t ad9832_store(struct device *dev,
+			    struct device_attribute *attr,
 			    const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -181,25 +279,7 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 		return ret;
 
 	guard(mutex)(&st->lock);
-	switch ((u32)this_attr->address) {
-	case AD9832_FREQ0HM:
-	case AD9832_FREQ1HM:
-		ret = ad9832_write_frequency(st, this_attr->address, val);
-		return ret ?: len;
-	case AD9832_PHASE0H:
-	case AD9832_PHASE1H:
-	case AD9832_PHASE2H:
-	case AD9832_PHASE3H:
-		ret = ad9832_write_phase(st, this_attr->address, val);
-		return ret ?: len;
-	case AD9832_PINCTRL_EN:
-		st->ctrl_ss &= ~AD9832_SELSRC;
-		st->ctrl_ss |= FIELD_PREP(AD9832_SELSRC, val ? 0 : 1);
-
-		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SYNCSELSRC) |
-						  st->ctrl_ss);
-		ret = spi_sync(st->spi, &st->msg);
-		return ret ?: len;
+	switch (this_attr->address) {
 	case AD9832_FREQ_SYM:
 		if (val != 1 && val != 0)
 			return -EINVAL;
@@ -209,7 +289,11 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
 						  st->ctrl_fp);
 		ret = spi_sync(st->spi, &st->msg);
-		return ret ?: len;
+		if (ret)
+			return ret;
+
+		st->freq_sym = val;
+		break;
 	case AD9832_PHASE_SYM:
 		if (val > 3)
 			return -EINVAL;
@@ -220,8 +304,15 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
 						  st->ctrl_fp);
 		ret = spi_sync(st->spi, &st->msg);
-		return ret ?: len;
+		if (ret)
+			return ret;
+
+		st->phase_sym = val;
+		break;
 	case AD9832_OUTPUT_EN:
+		if (val != 1 && val != 0)
+			return -EINVAL;
+
 		if (val)
 			st->ctrl_src &= ~(AD9832_RESET | AD9832_SLEEP | AD9832_CLR);
 		else
@@ -230,42 +321,111 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SLEEPRESCLR) |
 						  st->ctrl_src);
 		ret = spi_sync(st->spi, &st->msg);
-		return ret ?: len;
+		if (ret)
+			return ret;
+
+		st->output_en = val;
+		break;
+	case AD9832_PINCTRL_EN:
+		if (val != 1 && val != 0)
+			return -EINVAL;
+
+		st->ctrl_ss &= ~AD9832_SELSRC;
+		st->ctrl_ss |= FIELD_PREP(AD9832_SELSRC, !val);
+
+		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SYNCSELSRC) |
+						 st->ctrl_ss);
+		ret = spi_sync(st->spi, &st->msg);
+		if (ret)
+			return ret;
+
+		st->pinctrl_en = val;
+		break;
 	default:
 		return -ENODEV;
 	}
+
+	return len;
 }
 
-static IIO_DEVICE_ATTR(out_altvoltage0_frequency0, 0200, NULL, ad9832_write, AD9832_FREQ0HM);
-static IIO_DEVICE_ATTR(out_altvoltage0_frequency1, 0200, NULL, ad9832_write, AD9832_FREQ1HM);
+static ssize_t ad9832_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ad9832_state *st = iio_priv(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
-static IIO_DEVICE_ATTR(out_altvoltage0_frequencysymbol, 0200, NULL, ad9832_write, AD9832_FREQ_SYM);
-static IIO_CONST_ATTR(out_altvoltage0_frequency_scale, "1"); /* 1Hz */
+	guard(mutex)(&st->lock);
+	switch (this_attr->address) {
+	case AD9832_FREQ_SYM:
+		return sysfs_emit(buf, "%u\n", st->freq_sym);
+	case AD9832_PHASE_SYM:
+		return sysfs_emit(buf, "%u\n", st->phase_sym);
+	case AD9832_OUTPUT_EN:
+		return sysfs_emit(buf, "%u\n", st->output_en);
+	case AD9832_PINCTRL_EN:
+		return sysfs_emit(buf, "%u\n", st->pinctrl_en);
+	default:
+		return -ENODEV;
+	}
+}
 
-static IIO_DEVICE_ATTR(out_altvoltage0_phase0, 0200, NULL, ad9832_write, AD9832_PHASE0H);
-static IIO_DEVICE_ATTR(out_altvoltage0_phase1, 0200, NULL, ad9832_write, AD9832_PHASE1H);
-static IIO_DEVICE_ATTR(out_altvoltage0_phase2, 0200, NULL, ad9832_write, AD9832_PHASE2H);
-static IIO_DEVICE_ATTR(out_altvoltage0_phase3, 0200, NULL, ad9832_write, AD9832_PHASE3H);
+#define AD9832_CHAN_FREQ(_name, _select) {			\
+	.name = _name,						\
+	.write = ad9832_write_frequency,			\
+	.read = ad9832_read_frequency,				\
+	.private = _select,					\
+	.shared = IIO_SEPARATE,					\
+}
+
+#define AD9832_CHAN_PHASE(_name, _select) {			\
+	.name = _name,						\
+	.write = ad9832_write_phase,				\
+	.read = ad9832_read_phase,				\
+	.private = _select,					\
+	.shared = IIO_SEPARATE,					\
+}
 
-static IIO_DEVICE_ATTR(out_altvoltage0_phasesymbol, 0200, NULL, ad9832_write, AD9832_PHASE_SYM);
-static IIO_CONST_ATTR(out_altvoltage0_phase_scale, "0.0015339808"); /* 2PI/2^12 rad */
+static const struct iio_chan_spec_ext_info ad9832_ext_info[] = {
+	AD9832_CHAN_FREQ("frequency0", 0),
+	AD9832_CHAN_FREQ("frequency1", 1),
+	AD9832_CHAN_PHASE("phase0", 0),
+	AD9832_CHAN_PHASE("phase1", 1),
+	AD9832_CHAN_PHASE("phase2", 2),
+	AD9832_CHAN_PHASE("phase3", 3),
+	{ }
+};
 
-static IIO_DEVICE_ATTR(out_altvoltage0_pincontrol_en, 0200, NULL, ad9832_write, AD9832_PINCTRL_EN);
-static IIO_DEVICE_ATTR(out_altvoltage0_out_enable, 0200, NULL, ad9832_write, AD9832_OUTPUT_EN);
+static const struct iio_chan_spec ad9832_channels[] = {
+	{
+		.type = IIO_ALTCURRENT,
+		.output = 1,
+		.indexed = 1,
+		.channel = 0,
+		.ext_info = ad9832_ext_info,
+	},
+};
+
+static IIO_DEVICE_ATTR(out_altcurrent0_frequency_symbol, 0644,
+		       ad9832_show, ad9832_store, AD9832_FREQ_SYM);
+static IIO_DEVICE_ATTR(out_altcurrent0_phase_symbol, 0644,
+		       ad9832_show, ad9832_store, AD9832_PHASE_SYM);
+static IIO_DEVICE_ATTR(out_altcurrent0_enable, 0644,
+		       ad9832_show, ad9832_store, AD9832_OUTPUT_EN);
+
+/*
+ * TODO: Convert to DT property when graduating from staging.
+ * Pin control configuration depends on hardware wiring.
+ */
+static IIO_DEVICE_ATTR(out_altcurrent0_pincontrol_en, 0644,
+		       ad9832_show, ad9832_store, AD9832_PINCTRL_EN);
 
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
+	&iio_dev_attr_out_altcurrent0_frequency_symbol.dev_attr.attr,
+	&iio_dev_attr_out_altcurrent0_phase_symbol.dev_attr.attr,
+	&iio_dev_attr_out_altcurrent0_enable.dev_attr.attr,
+	&iio_dev_attr_out_altcurrent0_pincontrol_en.dev_attr.attr,
 	NULL,
 };
 
@@ -310,6 +470,8 @@ static int ad9832_probe(struct spi_device *spi)
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad9832_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ad9832_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad9832_channels);
 
 	/* Setup default messages */
 	st->xfer.tx_buf = &st->data;
-- 
2.43.0


