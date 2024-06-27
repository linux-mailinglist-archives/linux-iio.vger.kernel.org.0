Return-Path: <linux-iio+bounces-6985-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8F291A5F9
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2024 14:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EC7C28C187
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2024 12:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1382E15382C;
	Thu, 27 Jun 2024 11:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KIOXBR0K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FCD14F136
	for <linux-iio@vger.kernel.org>; Thu, 27 Jun 2024 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719489582; cv=none; b=DZygW3Vqdol2NFS5EX/d2j6vaH/0GL7pFucsuDup1UuU82+SGTfCRL1swJWu3bW4FqxFjJBqR2RqGhC+C0p9yxzN/ZiUIQ1AjV7SEDwmcJMw4ZvmReUdgEmtSxUs6WvStz674l6g4FwUTW/4EMYA8jFsE233u3Wd9wpID8wds3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719489582; c=relaxed/simple;
	bh=zObvtkPBzBXcv2+FtSR55vg59Iu7rnEEiswO0bfahq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XI+ZvoGOFrwXWvhRnLS+Ler8AGrITfYhyD10OYl4CePvBtMkhn9iRgmTkAA6UT6Spho+UCvNFpBMVB0RX/waSRSYwNLB/BPLIdqf5uSgdjHEvIT0iIpg/jkICpWjC3TnaUmX3OhBeAcxjyh7wpyYvHku7doEP8HpipWXnMvnPNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KIOXBR0K; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52cdd03d6aaso5827984e87.0
        for <linux-iio@vger.kernel.org>; Thu, 27 Jun 2024 04:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719489579; x=1720094379; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eg1WcV4Ntx7U/X2VBWNxi1Xyt2FKEefrmcQLGyRBCOQ=;
        b=KIOXBR0KyEwLSoJwIJ4s47OjYuwtGwsTLptRuFBN8y3kSp2XYhODQTliBF2YkQ33p+
         OGhJJPGc/HBo6m9GDV4DdEI/KBeE+rl+65Pls/s+/eAZuJFuB0n1Gm+4Yd+/TMDC8pnu
         73H7bGfGQ7ZDdPhOAmoY0WqoZAB3tqVGnlga15IoWNXp/rID5kCzkycGjK9niSghsPt8
         Yjh2XKCiD0GgagAPJEPkY0YEQzz0N6UFIBnIQvpGxwE7IZ6LoZK++MrTervPQYG53stM
         GQCT6c4RJOrJHhASvbZU807K+AfRondFdtKgu3PWTDMMHcNiCEi/bfeQ1ja9QWe+BUBB
         09yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719489579; x=1720094379;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eg1WcV4Ntx7U/X2VBWNxi1Xyt2FKEefrmcQLGyRBCOQ=;
        b=X/4t2It0uJdpMOyK6aXY1GRqyrJDR4T5bcij99hyzmRasptxi4kISR4Fx/Ge3J8wnY
         DeB/9pWwTl1Q72yOJnQ5zyobqIVuDeII+IqqlDz8SM28M9nSs9zI3MB8/WO1lFTTJ4qu
         DfAq8LIu89kaGBP3VILcu2K74AqVltE7FlvvqmrGTcg2WYYZHF4+VVZRZYRxcBkcrRHj
         cUlIJh9Xxyooy2jupg4DVqDJ4mZZbuUrzp2FzrGTKW65GPglDawzinmgV8Bb5pbB+mQW
         r/pHaqe8mAtwOpdeCuM5GV9RmL2uMJLaAuut4UQ0YRu5Z6ZY9+ObuWj671n+enJddoqe
         u1PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGveWHJTBcfdnYFKXRlDOM7OUgWeQrKACTZcA+y4UxofFBW9FteXYuwfGTy31LRRfFFN+6IR7XWG5kOUTN0QZXWppdyiu+mXAa
X-Gm-Message-State: AOJu0YyKDIi/gYr9x5/ZtCUCS09BE15+P7sKpOSf9X5xNxnEVnfgSWuF
	XQIO8ozhQvRNmad8yTAZZrwN0PZZoACCDmQ0hz/2fjBqELgl0UHKm9Cc83hqgBQ=
X-Google-Smtp-Source: AGHT+IGB/CuWwcFCdlLnwi/5EORhvR5mbuXCuAXPvCRDv9yaR5XC9ZJ0v0q9MWUudfW/x/2MBo1ofw==
X-Received: by 2002:a19:2d55:0:b0:52c:d904:d26e with SMTP id 2adb3069b0e04-52ce06441f9mr8502352e87.21.1719489578855;
        Thu, 27 Jun 2024 04:59:38 -0700 (PDT)
Received: from [127.0.0.1] ([2a01:e0a:448:76e0:4435:7af:3956:8dba])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c82462a2sm63473585e9.2.2024.06.27.04.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 04:59:38 -0700 (PDT)
From: Esteban Blanc <eblanc@baylibre.com>
Date: Thu, 27 Jun 2024 13:59:14 +0200
Subject: [PATCH RFC 3/5] iio: adc: ad4030: add averaging support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-eblanc-ad4630_v1-v1-3-fdc0610c23b0@baylibre.com>
References: <20240627-eblanc-ad4630_v1-v1-0-fdc0610c23b0@baylibre.com>
In-Reply-To: <20240627-eblanc-ad4630_v1-v1-0-fdc0610c23b0@baylibre.com>
To: baylibre-upstreaming@groups.io, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Esteban Blanc <eblanc@baylibre.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1719489567; l=8088;
 i=eblanc@baylibre.com; s=yubikey; h=from:subject:message-id;
 bh=zObvtkPBzBXcv2+FtSR55vg59Iu7rnEEiswO0bfahq0=;
 b=U1NIU0lHAAAAAQAAAhcAAAAHc3NoLXJzYQAAAAMBAAEAAAIBALJZcW6pLD4ksSdWnXd5r65Ze
 5Qc5pH7+DmmbKJasOXeVYRPFEmnORS7pwhURG11AMVFmnCVYWj+wPYrbCEeM7XKfO4oQzc66kYB
 7y0RrFwjoWKofytjI026zV5b2pn1JAItgu0Ijth+TSa6KVOTSXqqiVzOTDM1WL0hAIIzpkhE3Vt
 AVJrFDsh/nWed9OpeSS+S6e3ZxyJtlnhqbVIemcDmjwMihtFgTKeJWlxP7KGY/RQKPF/Ef7pS+O
 AckOrxuqGKvpOiNVCmuQEUQM0+r4uvwtja4zRSl+huqW+g1nLyReoZPzFwfJWREd+89dtTJTXN7
 xmmFNdX6KzRKBLVw1RY/R3mhAd+MkrdiNaRNKj+LO1QIxPoW90cPG9WpdVDUZf1VxhdciB6Hlxn
 lfEDFuCxU0n5H+kC4eiZvw+c9D4xX7iVdjPTMEaE6GBQNnMncdljBwA5NVN8WcaUhnAQnq7qhcz
 85L2Br7MPqe3q3J/PHIe0nHO56j7tTY6cFFs/ckqcQSTJigh2rA7InN1d7GqZFLzlewRTGaCY+M
 93d7DCIuxTxJWRpVm7NW1FBeX6d00+dAcQ/dS+jmA3kcdRoWtH160jmmYYvOgrsQTcMIQrPtK+B
 rULRmmIvEIJMF5UfNmxruWmWn6MM/xeejTNszoKqrORpbr7q3BnkKt2y/KdAAAABnBhdGF0dAAA
 AAAAAAAGc2hhNTEyAAACFAAAAAxyc2Etc2hhMi01MTIAAAIAsBkDzpwce4uigRdPmIiNAaFsf5q
 gEi+iN/tLqm+o+0SZMD8xQzV0IfrJEyP9hX0YjkBKOmFZ92tpeGeZQIyAV1knb8UiqorEF5nOp1
 ZUsTqXmsiWHjWmKaPEBxQF8JKCUNJotzHTi/or8d/4IT6CDckbbRLhns4QmnGgfIxsqurf6Sbo/
 Ohc6MtzfzJ//U4TG/ptcKs/ZRjFYoCfMeBZ33xkl7LG4N8LuEoYW7F63hX0LUkho19wVzBOp8D+
 +TErM5wBZfK9JdJxTGLTGZxIxYyq5TwzECVXYcRDG1RDb4APUGp0AA2DknMxkMywtqagrqPil/u
 Yi5FGlMRq+faM18bAdXmRlyPycQJGLoyx9StjsO0TTuGh64JFBp60utZNCjPyGoz7/KcVmi6swG
 N3Ro4TM2eQlVzKMZ9HJim7Cox1Y5P0gVEZJ/GNCscGLZLBtdyHp5Rav/VePYMzKtj8simgeFsz4
 ibtpH6WG9yypdmxM7ILlMKQA1zcZu0lK12F4cdCvwWmilLzEBQLeGexw7wTKVOHhrJBTEfte7N3
 VYmLLboPgxpfrUuY4lRHEkLuoufi12Pvs5ws02V5uh7RjviGZiSvUGRTPWVZvesQn2GsRFRTDG3
 +BeAU9jM1W/D1T4BbVhFHXGga9ZfDSX1We4ryngwwLTLpbqEjxpPj19M=
X-Developer-Key: i=eblanc@baylibre.com; a=openssh;
 fpr=SHA256:LOxhPHcL6HLuSaOVHuI2Yq7hvD2blbngN1ohWi2rJOw

This add support for the averaging mode of AD4030 using oversampling IIO
attribute

Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
---
 drivers/iio/adc/ad4030.c | 129 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 114 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 6d537e531d6f..1bcbcbd40a45 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -108,6 +108,18 @@ enum ad4030_out_mode {
 	AD4030_OUT_DATA_MD_32_PATTERN = 0x04
 };
 
+enum {
+	AD4030_LANE_MD_1_PER_CH,
+	AD4030_LANE_MD_2_PER_CH,
+	AD4030_LANE_MD_4_PER_CH,
+	AD4030_LANE_MD_INTERLEAVED = 0b11,
+};
+
+enum {
+	AD4030_SCAN_TYPE_NORMAL,
+	AD4030_SCAN_TYPE_AVG,
+};
+
 struct ad4030_chip_info {
 	const char *name;
 	const unsigned long *available_masks;
@@ -128,6 +140,7 @@ struct ad4030_state {
 	int min_offset;
 	int max_offset;
 	int offset_avail[3];
+	unsigned int avg_len;
 	u32 conversion_speed_hz;
 	enum ad4030_out_mode mode;
 
@@ -167,8 +180,11 @@ struct ad4030_state {
 	},								\
 }
 
-#define AD4030_CHAN_IN(_idx, _storage, _real, _shift) {			\
-	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),		\
+#define AD4030_CHAN_IN(_idx, _scan_type) {				\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE) |		\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
+	.info_mask_shared_by_all_available =				\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBSCALE) |		\
 		BIT(IIO_CHAN_INFO_CALIBBIAS) |				\
 		BIT(IIO_CHAN_INFO_RAW),					\
@@ -178,15 +194,16 @@ struct ad4030_state {
 	.indexed = 1,							\
 	.channel = _idx,						\
 	.scan_index = _idx,						\
-	.scan_type = {							\
-		.sign = 's',						\
-		.storagebits = _storage,				\
-		.realbits = _real,					\
-		.shift = _shift,					\
-		.endianness = IIO_BE,					\
-	},								\
+	.has_ext_scan_type = 1,						\
+	.ext_scan_type = _scan_type,					\
+	.num_ext_scan_type = ARRAY_SIZE(_scan_type),			\
 }
 
+static const int ad4030_average_modes[] = {
+	1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384,
+	32768, 65536
+};
+
 static int ad4030_spi_read(void *context, const void *reg, size_t reg_size,
 			   void *val, size_t val_size)
 {
@@ -313,6 +330,13 @@ static int ad4030_get_chan_offset(struct iio_dev *indio_dev, int ch, int *val)
 	return 0;
 }
 
+static int ad4030_get_avg_frame_len(struct iio_dev *dev)
+{
+	const struct ad4030_state *st = iio_priv(dev);
+
+	return 1L << st->avg_len;
+}
+
 static int ad4030_set_chan_gain(struct iio_dev *indio_dev, int ch, int gain_int,
 				int gain_frac)
 {
@@ -348,6 +372,22 @@ static int ad4030_set_chan_offset(struct iio_dev *indio_dev, int ch, int offset)
 	return regmap_bulk_write(st->regmap, AD4030_REG_OFFSET_CHAN(ch), &val, 3);
 }
 
+static int ad4030_set_avg_frame_len(struct iio_dev *dev, unsigned int avg_len)
+{
+	struct ad4030_state *st = iio_priv(dev);
+	unsigned int avg_val = ilog2(avg_len);
+	int ret;
+
+	ret = regmap_write(st->regmap, AD4030_REG_AVG, AD4030_REG_AVG_MASK_AVG_SYNC |
+		    FIELD_PREP(AD4030_REG_AVG_MASK_AVG_VAL, avg_val));
+	if (ret)
+		return ret;
+
+	st->avg_len = avg_val;
+
+	return 0;
+}
+
 static bool ad4030_is_common_byte_asked(struct ad4030_state *st,
 					unsigned int mask)
 {
@@ -358,7 +398,9 @@ static int ad4030_set_mode(struct iio_dev *indio_dev, unsigned long mask)
 {
 	struct ad4030_state *st = iio_priv(indio_dev);
 
-	if (ad4030_is_common_byte_asked(st, mask))
+	if (st->avg_len)
+		st->mode = AD4030_OUT_DATA_MD_30_AVERAGED_DIFF;
+	else if (ad4030_is_common_byte_asked(st, mask))
 		st->mode = st->chip->precision_bits == 24 ?
 			AD4030_OUT_DATA_MD_24_DIFF_8_COM :
 			AD4030_OUT_DATA_MD_16_DIFF_8_COM;
@@ -376,6 +418,7 @@ static int ad4030_conversion(struct ad4030_state *st, const struct iio_chan_spec
 			     ((st->mode == AD4030_OUT_DATA_MD_24_DIFF_8_COM ||
 			     st->mode == AD4030_OUT_DATA_MD_16_DIFF_8_COM) ? 1 : 0)) *
 			     st->chip->num_channels;
+	unsigned long cnv_nb = 1UL << st->avg_len;
 	struct spi_transfer xfer = {
 		.rx_buf = st->rx_data.raw,
 		.len = bytes_to_read,
@@ -384,10 +427,14 @@ static int ad4030_conversion(struct ad4030_state *st, const struct iio_chan_spec
 	unsigned int i;
 	int ret;
 
-	gpiod_set_value_cansleep(st->cnv_gpio, 1);
-	ndelay(AD4030_TCNVH_NS);
-	gpiod_set_value_cansleep(st->cnv_gpio, 0);
-	ndelay(AD4030_TCNVL_NS + AD4030_TCONV_NS);
+	for (i = 0; i < cnv_nb; i++) {
+		gpiod_set_value_cansleep(st->cnv_gpio, 1);
+		ndelay(AD4030_TCNVH_NS);
+		gpiod_set_value_cansleep(st->cnv_gpio, 0);
+		ndelay(AD4030_TCNVL_NS);
+	}
+
+	ndelay(AD4030_TCONV_NS);
 
 	ret = spi_sync_transfer(st->spi, &xfer, 1);
 	if (ret || (st->mode != AD4030_OUT_DATA_MD_16_DIFF_8_COM &&
@@ -478,6 +525,13 @@ static int ad4030_read_avail(struct iio_dev *indio_dev,
 		*vals = (void *)ad4030_gain_avail;
 		*type = IIO_VAL_INT_PLUS_MICRO;
 		return IIO_AVAIL_RANGE;
+
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*vals = ad4030_average_modes;
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(ad4030_average_modes);
+		return IIO_AVAIL_LIST;
+
 	default:
 		return -EINVAL;
 	}
@@ -514,6 +568,10 @@ static int ad4030_read_raw(struct iio_dev *indio_dev,
 				return ret;
 			return IIO_VAL_INT;
 
+		case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+			*val = ad4030_get_avg_frame_len(indio_dev);
+			return IIO_VAL_INT;
+
 		default:
 			return -EINVAL;
 		}
@@ -536,6 +594,9 @@ static int ad4030_write_raw(struct iio_dev *indio_dev,
 			return ad4030_set_chan_offset(indio_dev, chan->channel,
 						      val);
 
+		case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+			return ad4030_set_avg_frame_len(indio_dev, val);
+
 		default:
 			return -EINVAL;
 		}
@@ -559,11 +620,20 @@ static int ad4030_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 	unreachable();
 }
 
+static int ad4030_get_current_scan_type(const struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan)
+{
+	struct ad4030_state *st = iio_priv(indio_dev);
+
+	return st->avg_len ? AD4030_SCAN_TYPE_AVG : AD4030_SCAN_TYPE_NORMAL;
+}
+
 static const struct iio_info ad4030_iio_info = {
 	.read_avail = ad4030_read_avail,
 	.read_raw = ad4030_read_raw,
 	.write_raw = ad4030_write_raw,
 	.debugfs_reg_access = ad4030_reg_access,
+	.get_current_scan_type = ad4030_get_current_scan_type,
 };
 
 static int ad4030_buffer_preenable(struct iio_dev *indio_dev)
@@ -596,9 +666,21 @@ static int ad4030_buffer_postdisable(struct iio_dev *indio_dev)
 	return ad4030_enter_config_mode(st);
 }
 
+static bool ad4030_validate_scan_mask(struct iio_dev *indio_dev, const unsigned long *scan_mask)
+{
+	struct ad4030_state *st = iio_priv(indio_dev);
+
+	/* Asking for both common channels and averaging */
+	if (st->avg_len && ad4030_is_common_byte_asked(st, *scan_mask))
+		return false;
+
+	return true;
+}
+
 static const struct iio_buffer_setup_ops ad4030_buffer_setup_ops = {
 	.preenable = ad4030_buffer_preenable,
 	.postdisable = ad4030_buffer_postdisable,
+	.validate_scan_mask = ad4030_validate_scan_mask,
 };
 
 static int ad4030_regulators_get(struct ad4030_state *st)
@@ -781,12 +863,29 @@ static const unsigned long ad4030_channel_masks[] = {
 	0,
 };
 
+static const struct iio_scan_type ad4030_24_scan_types[] = {
+	[AD4030_SCAN_TYPE_NORMAL] = {
+		.sign = 's',
+		.storagebits = 32,
+		.realbits = 24,
+		.shift = 8,
+		.endianness = IIO_BE,
+	},
+	[AD4030_SCAN_TYPE_AVG] = {
+		.sign = 's',
+		.storagebits = 32,
+		.realbits = 30,
+		.shift = 2,
+		.endianness = IIO_BE,
+	},
+};
+
 static const struct ad4030_chip_info ad4030_24_chip_info = {
 	.name = "ad4030-24",
 	.available_masks = ad4030_channel_masks,
 	.available_masks_len = ARRAY_SIZE(ad4030_channel_masks),
 	.channels = {
-		AD4030_CHAN_IN(0, 32, 24, 8),
+		AD4030_CHAN_IN(0, ad4030_24_scan_types),
 		AD4030_CHAN_CMO(1),
 		IIO_CHAN_SOFT_TIMESTAMP(2),
 	},

-- 
2.44.1


