Return-Path: <linux-iio+bounces-8686-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8201D95B54E
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2024 14:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C04A285247
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2024 12:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D765B1CB13D;
	Thu, 22 Aug 2024 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vsvGvgt9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF57D1C9EC6
	for <linux-iio@vger.kernel.org>; Thu, 22 Aug 2024 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724330754; cv=none; b=mszy9cHF8h1VkuU2Z1Mlf5kSGhiZJBkX3LCWJ60P+gGYaUSwIMf1uV1SG2kiqdgvEeNFGIOLTNJtqArkXk4IAM9Rt9o51sgrM02ePJbwEGuBeZz5LXvM8iz6Op5c2h/YEYyj5O5LbTBhW/XNSwGz8HUS50xx4Oi3mfzG+UX+a/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724330754; c=relaxed/simple;
	bh=QQzxiUQhyAjTwORKWLJ575locEhWjGN2ZSGTCOKvTGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hzKG8k6qbOwYfOBRZJH2rTKCnrFYUKjtA7xsI3PvVJ88PsS/5z3oqdQNNsuUBXsNopqUMri6axDWfOlT7iZuP7AQK72ZNOug563oKsnqNyVZ9P4CZshyb7kQJqQ24Jil147AJWkLJkU8wVhFixIANX87RZnlJoLatGU3V9qbU0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vsvGvgt9; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4280bca3960so5363065e9.3
        for <linux-iio@vger.kernel.org>; Thu, 22 Aug 2024 05:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724330750; x=1724935550; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bRPlCQp+NpDCCX834clff8Ifmye/gtR+4GSDVcARXB8=;
        b=vsvGvgt9R9HN7w4Ui9iLroP6NWvnBTzumPG9nh9yG7wh12r5S9a/UWuMaTZLKgEPnF
         KjmYIjbdkUCzcDFp3+dnr1dRhAY/QQ/4GAoIcydxvgAYdnXu8MxsZWw0IaEArDcfd2Yu
         7C+qkfTVV4agQ0V08xEYZ9y/ZLhmwL8X0yBE+1Hd+WrHg1mOYjnRTtGa7XkYAzUssLqt
         yf4KV/gNPFDSUJcqDmL3JOtySg2K5un8DesCX1+9nrL6y5fuAYq7iYgyIedKtG0oq1y4
         P0FBLVvUFW0W9nrq2U4oO3oqjSabT45GitGDGHx3Odsbep3CqbxVOpHcmW4wmn+6P34Z
         rlwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724330750; x=1724935550;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRPlCQp+NpDCCX834clff8Ifmye/gtR+4GSDVcARXB8=;
        b=suKnrNJJlkwLl91Eno4StpjUKBk2VI22nFnrUk/1rvpBUfXLad2SOVd/oCcr2KkQQ9
         BnVKhgAh3nhJV99rSeB3Y4sX+/ApDp8nOWoKHTxWBeu/HCqgTJ6II3h5eXY6J91VJ6Hb
         pCCHj529IRuN3CJ65hlh6cZNPzpAnyOG/2ApHkdhvvOwM/3lOG6Uxvg59dowrmYQKwbU
         FQY3gwDeZSDeUk6lYypM8T3FGM91J+ibKXkyyWajSbSzrDXtw+R84c1VCsAaJwZACSlc
         2pL0zXRC2a9s4nLmr804ublmxqMrd1UJqZtd1RTDNoDKiMO4T0JQZBUL2/IBvgeyZqIM
         xBaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcyYwG8PQ6axhjakb8uygP6KNEtDfw4YeC5fvpAbh05+QizeuE7HtTQtM0I4UAKaQcJslas0DhFm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYOzKUOaztND1naQo4FwN72FB0hXtRFtzQ7TTZe2EskJJ9OFKY
	NVRIlbl/UStPCMHS+CweAMTI4XwOlLBt8bBqinr8EDecoR9wvRIu3fX6b+vCuKo=
X-Google-Smtp-Source: AGHT+IEGHpxGCCMyTr36umtwScsf7Z2ndM00qZRQ7np90qMZEjz1NT2EFZbQhjmYpCe4Im2bZDYAKQ==
X-Received: by 2002:a05:600c:3507:b0:428:10d7:a4b1 with SMTP id 5b1f17b1804b1-42abf087a08mr33553965e9.25.1724330749927;
        Thu, 22 Aug 2024 05:45:49 -0700 (PDT)
Received: from [127.0.0.1] ([2a01:e0a:448:76e0:8da6:6d6d:c8ed:16c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac514e269sm24032195e9.2.2024.08.22.05.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 05:45:49 -0700 (PDT)
From: Esteban Blanc <eblanc@baylibre.com>
Date: Thu, 22 Aug 2024 14:45:19 +0200
Subject: [PATCH 3/6] iio: adc: ad4030: add averaging support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-eblanc-ad4630_v1-v1-3-5c68f3327fdd@baylibre.com>
References: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
In-Reply-To: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 linux-doc@vger.kernel.org, Esteban Blanc <eblanc@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1724330735; l=7845;
 i=eblanc@baylibre.com; s=yubikey; h=from:subject:message-id;
 bh=QQzxiUQhyAjTwORKWLJ575locEhWjGN2ZSGTCOKvTGs=;
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
 AAAAAAAGc2hhNTEyAAACFAAAAAxyc2Etc2hhMi01MTIAAAIARmk6JXjFJueN6HQQPJ1uFe0G8IM
 ixRik//ogrfAlxjmcSK4lrQkY/3ZllZWrqYNFJRaII3Y58+STobfoE7E1wRCwFmD1D+RRfVv9rH
 re6pZvHc+rj+WnrJxB+WCmVYV5DAgoih12l7GxF2GcAB7Miac33vJ1EgxeAQmqmlsgdHwp8sqAD
 /QEKjM1kKOzL3+NZfOyzYx/sTxsxAdUUC06QJn65iVFdbAz3Q28r1a49URg40hoJ+amxoXL/52h
 wAmooIaFWsxsgZc3N1+ObPqqDVTnNcCqyD+4NevGfRTZcS6sTMwB3J7Hju5+bwaj7EKOnCHVISO
 yQlaJk3smo7ovg+kciXGx8Dbe8IJJ8DkOKNYyjFHdn9AKHRLXk253z7zpcNBPzdfkNl3rCwzX3e
 MSPcfPJ4LhpA00xwkAUP0mrBHhZPwHDpShHoCuHlQk653h7teKMu9hx7w27Jw3LV6ovxorRWhlr
 imGWMV0YNamEttcPvX0fVoBO7PlLh3Ev5bzzj5yozHwLFm5Arehap+ssY5znv+oWuaLga81Vh/q
 hlulydn1uTLj265e9Og9qOikneeqIqz9i6kNZCAfJFgKvlNZ4Ak09zSus0Iuu7mVeWDyhGOULiN
 ZkiXCvwd5T5ydw7KZcx+zaA0Wtsr3AtQ7LRC4TgOSuWJ9fow/Y7Od6sk=
X-Developer-Key: i=eblanc@baylibre.com; a=openssh;
 fpr=SHA256:LOxhPHcL6HLuSaOVHuI2Yq7hvD2blbngN1ohWi2rJOw

This add support for the averaging mode of AD4030 using oversampling IIO
attribute

Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
---
 drivers/iio/adc/ad4030.c | 126 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 111 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index a981dce988e5..e1e1dbf0565c 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -115,6 +115,18 @@ enum ad4030_out_mode {
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
@@ -135,6 +147,7 @@ struct ad4030_state {
 	int vref_uv;
 	int vio_uv;
 	int offset_avail[3];
+	unsigned int avg_len;
 	u32 conversion_speed_hz;
 	enum ad4030_out_mode mode;
 
@@ -169,8 +182,11 @@ struct ad4030_state {
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
@@ -183,15 +199,16 @@ struct ad4030_state {
 	.scan_index = _idx * 2,						\
 	.extend_name = "Channel" #_idx " differential part",		\
 	.differential = true,						\
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
@@ -327,6 +344,13 @@ static int ad4030_get_chan_offset(struct iio_dev *indio_dev, int ch, int *val)
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
@@ -369,6 +393,22 @@ static int ad4030_set_chan_offset(struct iio_dev *indio_dev, int ch, int offset)
 			  st->rx_data.raw, AD4030_REG_OFFSET_BYTES_NB);
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
@@ -380,7 +420,9 @@ static int ad4030_set_mode(struct iio_dev *indio_dev, unsigned long mask)
 {
 	struct ad4030_state *st = iio_priv(indio_dev);
 
-	if (ad4030_is_common_byte_asked(st, mask))
+	if (st->avg_len)
+		st->mode = AD4030_OUT_DATA_MD_30_AVERAGED_DIFF;
+	else if (ad4030_is_common_byte_asked(st, mask))
 		st->mode = AD4030_OUT_DATA_MD_24_DIFF_8_COM;
 	else
 		st->mode = AD4030_OUT_DATA_MD_24_DIFF;
@@ -394,6 +436,7 @@ static int ad4030_conversion(struct ad4030_state *st,
 			     const struct iio_chan_spec *chan)
 {
 	unsigned int bytes_to_read;
+	unsigned long cnv_nb = 1UL << st->avg_len;
 	unsigned char byte_index;
 	unsigned int i;
 	int ret;
@@ -406,10 +449,12 @@ static int ad4030_conversion(struct ad4030_state *st,
 	/* Mulitiply by the number of hardware channels */
 	bytes_to_read *= st->chip->num_channels;
 
-	gpiod_set_value_cansleep(st->cnv_gpio, 1);
-	ndelay(AD4030_TCNVH_NS);
-	gpiod_set_value_cansleep(st->cnv_gpio, 0);
-	ndelay(st->chip->tcyc);
+	for (i = 0; i < cnv_nb; i++) {
+		gpiod_set_value_cansleep(st->cnv_gpio, 1);
+		ndelay(AD4030_TCNVH_NS);
+		gpiod_set_value_cansleep(st->cnv_gpio, 0);
+		ndelay(st->chip->tcyc);
+	}
 
 	ret = spi_read(st->spi, st->rx_data.raw, bytes_to_read);
 	if (ret)
@@ -508,6 +553,12 @@ static int ad4030_read_avail(struct iio_dev *indio_dev,
 		*type = IIO_VAL_INT_PLUS_MICRO;
 		return IIO_AVAIL_RANGE;
 
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*vals = ad4030_average_modes;
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(ad4030_average_modes);
+		return IIO_AVAIL_LIST;
+
 	default:
 		return -EINVAL;
 	}
@@ -544,6 +595,10 @@ static int ad4030_read_raw(struct iio_dev *indio_dev,
 				return ret;
 			return IIO_VAL_INT;
 
+		case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+			*val = ad4030_get_avg_frame_len(indio_dev);
+			return IIO_VAL_INT;
+
 		default:
 			return -EINVAL;
 		}
@@ -566,6 +621,9 @@ static int ad4030_write_raw(struct iio_dev *indio_dev,
 			return ad4030_set_chan_offset(indio_dev, chan->channel,
 						      val);
 
+		case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+			return ad4030_set_avg_frame_len(indio_dev, val);
+
 		default:
 			return -EINVAL;
 		}
@@ -589,11 +647,20 @@ static int ad4030_reg_access(struct iio_dev *indio_dev, unsigned int reg,
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
@@ -626,9 +693,21 @@ static int ad4030_buffer_postdisable(struct iio_dev *indio_dev)
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
@@ -812,12 +891,29 @@ static const unsigned long ad4030_channel_masks[] = {
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
 		AD4030_CHAN_CMO(0),
 		IIO_CHAN_SOFT_TIMESTAMP(2),
 	},

-- 
2.44.1


