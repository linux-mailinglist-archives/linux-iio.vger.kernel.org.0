Return-Path: <linux-iio+bounces-27106-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA62CBF7D6
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 20:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 175AC303CF5D
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 19:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A0F326D57;
	Mon, 15 Dec 2025 19:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S24nQNHO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00D52D1936
	for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 19:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765825715; cv=none; b=aynt9x65QZSrKSkqbqVySqvnycjBRNj65nNZowfjjCaNVTYctts+3vFgHoLnD4eor4FaXm+uZGdni7//6nDLp9aYMbuNO7oZWSyefemuylMwNY/b4pzDIeNgxG3sqjwwvaqNoCjxc/wg5Se0F4SI5ohKRTS/pj+JEot6ChJzkNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765825715; c=relaxed/simple;
	bh=iiqfqIItLqOEVIEr9T8YV8/GP3ebhE5wVXhm49vIAcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8VqtxFZWnPd2XW3Kk/FQ91uDNekmVPh6odYu3wT3RW05E5FqNj25TlIoC/7UOECRXFO6W6D4SRkcWMtACvMNwLzypy0JBkcXH14F+yLWwv1Y1GR1Zk6a7SOv0QYq1k53eL3KiFZPaOguQnsHYbMQxVEC7fWVAELMjP5tG6XJ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S24nQNHO; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c565c3673so856469a91.0
        for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 11:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765825712; x=1766430512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVWm9MlPY1BX7cwkR/c6Kgx/4hat1o0o4ZKQmaEFy3I=;
        b=S24nQNHOgAUC6dpjwrJ9Q8/5i6EkSc012UsR03BuNVAVyCD2PcxYZFH8XhE6u9m3ho
         uRnkv3hi4MFrBj6x0HB/F2T1uD+syXtOehgZ8ZssWX5bu5SmPbaQ+RPhAx7WOYnmI5t8
         XWcuWseF2RH5wmmrymNHft0weIL2jxryiJ8BDYO/1JAuZ8ebyPLbdOEfeJ3dU+TDI3iz
         LOv9OU5pE6ICNvd429+kcoWMrZ2pja8Tq/gb0M0rZ123pH95uKLYtwoNTSyPRH5Vqh48
         h8RHFjH0yg4jXlq+po7TMmhXklUjqLLSiUKrrLIP8Slw4rjcus/kA1ydGiVJMFvhPeyq
         mikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765825712; x=1766430512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qVWm9MlPY1BX7cwkR/c6Kgx/4hat1o0o4ZKQmaEFy3I=;
        b=bJkHaKvdRre1wH48KYCD750CHYySzuR1LxGmaKv2JSURVriKyIRj6E81vfyK9O0BpI
         VriPSICQ8BUrXSVEeQ0LbKRWzN9UmSu0TXvbXtO5/L05l0Nx+NHoiAbgwKKC19H26YTH
         iuusstJTZ3txkWbfNbad6bOvjII2mMAo5qqZeKiIlNGqJ1hzWAtMgsXaNmpKCX1qVGSR
         AMHnAtnIVXxqBa0vqbJXsEQ4IIkSG4aBOiahmDNN8LHVJdJYKePkFqK8WNYfCBdZWeS6
         5Yd955RlqFRsfcxCobX+WY+gF012sgOzCrcE2SVyfRA0kkEUG9FSaVc988lM0YcrkeM7
         /5OA==
X-Forwarded-Encrypted: i=1; AJvYcCXaWCUI9WZmBveGERECNL85pQBbvoc3ghe/pM+9LKQDXcyRjRJevsr7wNFdB3k7BCjL6k5J5xudRfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOb4qM4UBwEYWoV6t42iadLRWiYf6XfU9LvOn8aX1hnyic4/+6
	m1uY8VE1Z+AaNBY7OglI5bDhhXx+DtB/SOD/ItD+wam+D5qgsczMk4ij
X-Gm-Gg: AY/fxX6247a3oAuhPMsIvVHs8+TrZjg6awpbHdIp2CzdPYJgFcPMBzgIVbc56YACteN
	zlrxPbFlj03cNHd8E6L1ykdLLCB5/MEsVUnqXxPbCUnibcw6uuH3jH+xtsGfD0mMr8lLY1inKHU
	qy5YqCsuLCejjx4+wua0LsVNJ/TesAAZNUJF8FSr11wwK2ifBuJ+wrhjvVeFQSF6Glwih624UW/
	Z9MTJS9Iv6RB+AnhdGj13BwKRVH8WbHVFONRyQxtuQS3zGoXz3CB907htv4r3b0699sNnUO/07u
	/PQxnlhUvx2Eqgnxw6DJtgJcKPncBmf/n80c1dbTj4r3NNAtLcixBGFcgwO4XLW29E40vyqD+Zw
	+4TUCt0T3WsmCb1YLRV/3LsugbgybadAmiuruqGVt2So99qtQDJbVeWk0qgjqMxM/0hmOhG6UEw
	29uHpiMQO/Zzns+xul1pNYrN2uficIWJU2BdDpmXaDmCVKoJ/bmlhaIoVM9GqZVqsSG2tJGQF0Q
	mrlxRfBlE2ep2YtBOR/MhNn1LplT3MhriVTYp+BnlMqpOHMDDkQdTzatydOsaDIbIJtpzKQosx1
	zMkMu5I=
X-Google-Smtp-Source: AGHT+IHlZrjRmZMvg8QnFBJE5MQog2I0zSPjkXC/st4XF7bxDpoTiQ0Afh13aU7N1YNh1R00VdLTng==
X-Received: by 2002:a17:90b:4c90:b0:32e:23c9:6f41 with SMTP id 98e67ed59e1d1-34abdc6855emr11502040a91.5.1765825712028;
        Mon, 15 Dec 2025 11:08:32 -0800 (PST)
Received: from Lewboski.localdomain ([181.191.143.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe2948d1sm9958875a91.9.2025.12.15.11.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 11:08:31 -0800 (PST)
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
Subject: [PATCH 4/5] staging: iio: ad9832: convert to iio channels and ext_info attrs
Date: Mon, 15 Dec 2025 16:08:05 -0300
Message-ID: <20251215190806.11003-5-tomasborquez13@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215190806.11003-1-tomasborquez13@gmail.com>
References: <20251215190806.11003-1-tomasborquez13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert ad9832 from custom sysfs attributes to standard channel interface
using a single IIO_ALTCURRENT channel with ext_info attributes, as this
device is a current source DAC with one output, as well as removing the
dds.h header.

Changes:
- Add single iio_chan_spec with ext_info for frequency0/1 and phase0-3
- Phase attributes accept radians directly, driver converts internally
- Frequency attributes accept Hz (unchanged)
- Cache frequency and phase values in driver state for readback
- Remove dependency on dds.h macros
- Rename symbol attributes to frequency_symbol and phase_symbol

The pincontrol_en attribute is kept temporarily with a TODO noting it
should become a DT property during staging graduation.

NOTE: This changes the ABI from out_altvoltage0_* to out_altcurrent0_*
with different attribute organization.

Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 279 +++++++++++++++++++------
 1 file changed, 215 insertions(+), 64 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 8d04f1b44f..454a317732 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -24,8 +24,6 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-#include "dds.h"
-
 /* Registers */
 #define AD9832_FREQ0LL		0x0
 #define AD9832_FREQ0HL		0x1
@@ -67,6 +65,7 @@
 #define AD9832_CLR		BIT(11)
 #define AD9832_FREQ_BITS	32
 #define AD9832_PHASE_BITS	12
+#define AD9832_2PI_URAD		6283185UL
 #define AD9832_CMD_MSK		GENMASK(15, 12)
 #define AD9832_ADD_MSK		GENMASK(11, 8)
 #define AD9832_DAT_MSK		GENMASK(7, 0)
@@ -78,6 +77,12 @@
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
@@ -95,6 +100,12 @@ struct ad9832_state {
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
@@ -113,7 +124,7 @@ struct ad9832_state {
 	} __aligned(IIO_DMA_MINALIGN);
 };
 
-static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
+static unsigned long ad9832_calc_freqreg(unsigned long mclk, u32 fout)
 {
 	unsigned long long freqreg = (u64)fout *
 				     (u64)((u64)1L << AD9832_FREQ_BITS);
@@ -121,19 +132,33 @@ static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
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
 
+	ret = kstrtou32(buf, 10, &fout);
+	if (ret)
+		return ret;
+
+	clk_freq = clk_get_rate(st->mclk);
 	if (!clk_freq || fout > (clk_freq / 2))
 		return -EINVAL;
 
+	guard(mutex)(&st->lock);
 	regval = ad9832_calc_freqreg(clk_freq, fout);
 	put_unaligned_be32(regval, regval_bytes);
 
@@ -145,18 +170,64 @@ static int ad9832_write_frequency(struct ad9832_state *st,
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
 }
 
-static int ad9832_write_phase(struct ad9832_state *st,
-			      unsigned long addr, unsigned long phase)
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
+}
+
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
 
+	ret = iio_str_to_fixpoint(buf, 100000, &val, &val2);
+	if (ret)
+		return ret;
+
+	if (val < 0 || val2 < 0)
+		return -EINVAL;
+
+	phase_urad = val * 1000000 + val2;
+	if (phase_urad >= AD9832_2PI_URAD)
+		return -EINVAL;
+
+	/* Convert microradians to 12-bit phase register value (0 to 4095) */
+	phase = ((u64)phase_urad << AD9832_PHASE_BITS) / AD9832_2PI_URAD;
+
+	guard(mutex)(&st->lock);
 	put_unaligned_be16(phase, phase_bytes);
 
@@ -164,14 +235,38 @@ static int ad9832_write_phase(struct ad9832_state *st,
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
+}
+
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
+	return sysfs_emit(buf, "%u.%06u\n", phase_urad / 1000000, phase_urad % 1000000);
 }
 
-static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
+static ssize_t ad9832_store(struct device *dev,
+			    struct device_attribute *attr,
 			    const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -185,34 +280,20 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 		return ret;
 
 	guard(mutex)(&st->lock);
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
-	case AD9832_PINCTRL_EN:
-		st->ctrl_ss &= ~AD9832_SELSRC;
-		st->ctrl_ss |= FIELD_PREP(AD9832_SELSRC, val ? 0 : 1);
-
-		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SYNCSELSRC) |
-						  st->ctrl_ss);
-		ret = spi_sync(st->spi, &st->msg);
-		break;
+	switch (this_attr->address) {
 	case AD9832_FREQ_SYM:
 		if (val != 1 && val != 0)
 			return -EINVAL;
 
 		st->ctrl_fp &= ~AD9832_FREQ;
-		st->ctrl_fp |= FIELD_PREP(AD9832_FREQ, val ? 1 : 0);
+		st->ctrl_fp |= FIELD_PREP(AD9832_FREQ, val);
 		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
 						  st->ctrl_fp);
 		ret = spi_sync(st->spi, &st->msg);
+		if (ret)
+			return ret;
+
+		st->freq_sym = val;
 		break;
 	case AD9832_PHASE_SYM:
 		if (val > 3)
@@ -224,8 +305,15 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
 						  st->ctrl_fp);
 		ret = spi_sync(st->spi, &st->msg);
+		if (ret)
+			return ret;
+
+		st->phase_sym = val;
 		break;
 	case AD9832_OUTPUT_EN:
+		if (val != 1 && val != 0)
+			return -EINVAL;
+
 		if (val)
 			st->ctrl_src &= ~(AD9832_RESET | AD9832_SLEEP | AD9832_CLR);
 		else
@@ -234,49 +322,110 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SLEEPRESCLR) |
 						  st->ctrl_src);
 		ret = spi_sync(st->spi, &st->msg);
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
+		st->ctrl_ss |= FIELD_PREP(AD9832_SELSRC, val ? 0 : 1);
+
+		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SYNCSELSRC) |
+						 st->ctrl_ss);
+		ret = spi_sync(st->spi, &st->msg);
+		if (ret)
+			return ret;
+
+		st->pinctrl_en = val;
 		break;
 	default:
 		return -ENODEV;
 	}
 
-	return ret ? ret : len;
+	return len;
 }
 
-/*
- * see dds.h for further information
- */
+static ssize_t ad9832_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ad9832_state *st = iio_priv(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
-static IIO_DEV_ATTR_FREQ(0, 0, 0200, NULL, ad9832_write, AD9832_FREQ0HM);
-static IIO_DEV_ATTR_FREQ(0, 1, 0200, NULL, ad9832_write, AD9832_FREQ1HM);
-static IIO_DEV_ATTR_FREQSYMBOL(0, 0200, NULL, ad9832_write, AD9832_FREQ_SYM);
-static IIO_CONST_ATTR_FREQ_SCALE(0, "1"); /* 1Hz */
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
+
+#define AD9832_CHAN_FREQ(_name, _channel) {			\
+	.name = _name,						\
+	.write = ad9832_write_frequency,			\
+	.read = ad9832_read_frequency,				\
+	.private = _channel,					\
+	.shared = IIO_SEPARATE,					\
+}
+
+#define AD9832_CHAN_PHASE(_name, _channel) {			\
+	.name = _name,						\
+	.write = ad9832_write_phase,				\
+	.read = ad9832_read_phase,				\
+	.private = _channel,					\
+	.shared = IIO_SEPARATE,					\
+}
+
+static const struct iio_chan_spec_ext_info ad9832_ext_info[] = {
+	AD9832_CHAN_FREQ("frequency0", 0),
+	AD9832_CHAN_FREQ("frequency1", 1),
+	AD9832_CHAN_PHASE("phase0", 0),
+	AD9832_CHAN_PHASE("phase1", 1),
+	AD9832_CHAN_PHASE("phase2", 2),
+	AD9832_CHAN_PHASE("phase3", 3),
+	{ }
+};
 
-static IIO_DEV_ATTR_PHASE(0, 0, 0200, NULL, ad9832_write, AD9832_PHASE0H);
-static IIO_DEV_ATTR_PHASE(0, 1, 0200, NULL, ad9832_write, AD9832_PHASE1H);
-static IIO_DEV_ATTR_PHASE(0, 2, 0200, NULL, ad9832_write, AD9832_PHASE2H);
-static IIO_DEV_ATTR_PHASE(0, 3, 0200, NULL, ad9832_write, AD9832_PHASE3H);
-static IIO_DEV_ATTR_PHASESYMBOL(0, 0200, NULL,
-				ad9832_write, AD9832_PHASE_SYM);
-static IIO_CONST_ATTR_PHASE_SCALE(0, "0.0015339808"); /* 2PI/2^12 rad*/
+static const struct iio_chan_spec ad9832_channels[] = {
+	{
+		.type = IIO_ALTCURRENT,
+		.output = 1,
+		.indexed = 1,
+		.channel = 0,
+		.ext_info = ad9832_ext_info,
+	},
+};
 
-static IIO_DEV_ATTR_PINCONTROL_EN(0, 0200, NULL,
-				ad9832_write, AD9832_PINCTRL_EN);
-static IIO_DEV_ATTR_OUT_ENABLE(0, 0200, NULL,
-				ad9832_write, AD9832_OUTPUT_EN);
+static IIO_DEVICE_ATTR(out_altcurrent0_frequency_symbol, 0644,
+		       ad9832_show, ad9832_store, AD9832_FREQ_SYM);
+static IIO_DEVICE_ATTR(out_altcurrent0_phase_symbol, 0644,
+		       ad9832_show, ad9832_store, AD9832_PHASE_SYM);
+static IIO_DEVICE_ATTR(out_altcurrent0_enable, 0644,
+		       ad9832_show, ad9832_store, AD9832_OUTPUT_EN);
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
 
@@ -318,6 +467,8 @@ static int ad9832_probe(struct spi_device *spi)
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad9832_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ad9832_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad9832_channels);
 
 	/* Setup default messages */
 	st->xfer.tx_buf = &st->data;
-- 
2.43.0


