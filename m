Return-Path: <linux-iio+bounces-5039-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5074C8C55AA
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 14:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D549E1F22E72
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 12:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455B148CCC;
	Tue, 14 May 2024 12:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbPK5rCY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459B743AD7;
	Tue, 14 May 2024 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715688190; cv=none; b=VrYHAfwOuuMY/yz+w4dpWy3ZpKbv3kXKWh0O6gafeiGhmnR/5QmObmprPQjQizCTQ4hVzlC4jthJGSSeDqI3S9rGCSWjbbN0DNtimF5SvJqUTnRfksNZlufmDOOqSFS5mUaEf5+Xt4F+2RagqoLJCXN0iWpNKBGyHDVAOkVikDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715688190; c=relaxed/simple;
	bh=6Ot2Zt8xQ6gTbpCKhK6ZQoVffyGKgVaC07JA7IwyaZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A99Adnq0VbrvXQB3fFu2Ey6NAIOWV46PIsCfD9Kjk/tVXGPgHEKEkBQgl+QGOHvupmlCnzJMHN7X1PCa3lSpd9jeBZ3NKPwWJ1i6UbJemGvdwp+GkRBNNF6Ucobvgf2pyOYLc2zX3wgMDA7qBg5QKHSe4RZ35VIlVaZgr7SiJyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbPK5rCY; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34eb52bfca3so4831475f8f.0;
        Tue, 14 May 2024 05:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715688186; x=1716292986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wShCpOhd/iedbhwtjzlwTTiwMIbq6GX/2w8mb07zQE=;
        b=DbPK5rCYsEyxU7/djfnFWkuEHHsFI8kQdhnNHKfSa3eI5I8SXm5ZvYUQGcy3poAQ5W
         DXEhImWY7JzxmUeNsJSmCevUjZaHgVjciH/yDEh83R+nZV1IpbnBhbotpWEi0qli+0AQ
         fTmUuroidgGgw924V3KWvOo77IZlSGUnMLHqSI/wbzmXRjtFokSfe2iO9mnAKS7cibgm
         c/vmHSxQ+xiclwr39wUBnpmNo0pnaQk56jLR2ihybP3MSOrO1dBBVDK8IlgQVyZft4Yl
         14QYu7sQirmtKygkC0cOiuMOHt6N5NVWymyFBZtkrVNvHNqSDP5HXEF4DgkrPRUT+y1H
         ntPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715688186; x=1716292986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wShCpOhd/iedbhwtjzlwTTiwMIbq6GX/2w8mb07zQE=;
        b=HBNiGyQcUpPs+MHs+sb3KR20N0QWE6OUkYmbJ/MKNNmPnbQEubYZ04UXgHIyRwnGQP
         57ozvPOAUtaO6nim+jww1EwRWcJYDaLcf8dJUUQxOxb7hSvZCtK0mVsH+hKbMCW3CsXN
         G4t1z/1oNNkYfn/ELFnWbyBCWZT0i/+O1PFY81GX/qXNxI8XHdfIMIWWgY+Hbd63xf1K
         aT8fbCqI/eZuY0rB/3gXWKc62hWBLD1okMfdIJrJ3kVvcxOMUIqzPIsw437m3Vp22EoF
         bLVBku2VuKYiDz8DSBBjAVjytO/Zmmys4B7t+5z/X7kX/bcyEY9UO7eaSMIgSlVd/Rp3
         NXQw==
X-Forwarded-Encrypted: i=1; AJvYcCVoHeEDZ+/7lEcKXp4nIGJxkFNcsUKoU5m41sI9Srz9asJAupoQczJw1IqmXMm7CYFhT4DE+j0jUEDdLjlIJoNXD+lLfHS9991+hFl9a25WBFNMzxot3K+zUJEkv0aD31lkSc3Al5dJIGCNj7gyWQNTKSkO8rda4nn2qsjE+xH9e5G5qA==
X-Gm-Message-State: AOJu0Yx3fAjXtjaZAxUHxptbysnJwJ3me/ZWPtVeIJH2hK6tWK9kJ6wh
	nZP+VVE+TgiSi/ka256elkXfE+pbFLwKbJntjiXggm0H0IewaJO7
X-Google-Smtp-Source: AGHT+IF1a0jH5jIVuFxznr5QdpiLEiQgPPglZXTXHsPzv2TPyfUR2w82XhovUswZJ6dMVjD9/K1EXA==
X-Received: by 2002:a5d:4fd0:0:b0:34b:dc21:68f2 with SMTP id ffacd0b85a97d-3504a738229mr11790901f8f.28.1715688186251;
        Tue, 14 May 2024 05:03:06 -0700 (PDT)
Received: from spiri.. ([2a02:2f08:a105:8300:5179:8171:3530:3b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b896a06sm13593927f8f.27.2024.05.14.05.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 05:03:06 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: michael.hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	marcelo.schmitt@analog.com,
	bigunclemax@gmail.com,
	dlechner@baylibre.com,
	okan.sahin@analog.com,
	fr0st61te@gmail.com,
	alisa.roman@analog.com,
	marcus.folkesson@gmail.com,
	schnelle@linux.ibm.com,
	liambeguin@gmail.com
Subject: [PATCH v8 1/6] iio: adc: ad7192: Use standard attribute
Date: Tue, 14 May 2024 15:02:17 +0300
Message-Id: <20240514120222.56488-2-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240514120222.56488-1-alisa.roman@analog.com>
References: <20240514120222.56488-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace custom attribute filter_low_pass_3db_frequency_available with
standard attribute.

Store the available values in ad7192_state struct.

The function that used to compute those values replaced by
ad7192_update_filter_freq_avail().

Function ad7192_show_filter_avail() is no longer needed.

Note that the initial available values are hardcoded.

Also moved the mutex lock and unlock in order to protect the whole
switch statement since each branch modifies the state of the device.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/ad7192.c | 75 ++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 7bcc7e2aa2a2..ace81e3817a1 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -190,6 +190,7 @@ struct ad7192_state {
 	u32				mode;
 	u32				conf;
 	u32				scale_avail[8][2];
+	u32				filter_freq_avail[4][2];
 	u32				oversampling_ratio_avail[4];
 	u8				gpocon;
 	u8				clock_sel;
@@ -473,6 +474,16 @@ static int ad7192_setup(struct iio_dev *indio_dev, struct device *dev)
 	st->oversampling_ratio_avail[2] = 8;
 	st->oversampling_ratio_avail[3] = 16;
 
+	st->filter_freq_avail[0][0] = 600;
+	st->filter_freq_avail[1][0] = 800;
+	st->filter_freq_avail[2][0] = 2300;
+	st->filter_freq_avail[3][0] = 2720;
+
+	st->filter_freq_avail[0][1] = 1000;
+	st->filter_freq_avail[1][1] = 1000;
+	st->filter_freq_avail[2][1] = 1000;
+	st->filter_freq_avail[3][1] = 1000;
+
 	return 0;
 }
 
@@ -586,48 +597,24 @@ static int ad7192_get_f_adc(struct ad7192_state *st)
 				 f_order * FIELD_GET(AD7192_MODE_RATE_MASK, st->mode));
 }
 
-static void ad7192_get_available_filter_freq(struct ad7192_state *st,
-						    int *freq)
+static void ad7192_update_filter_freq_avail(struct ad7192_state *st)
 {
 	unsigned int fadc;
 
 	/* Formulas for filter at page 25 of the datasheet */
 	fadc = ad7192_compute_f_adc(st, false, true);
-	freq[0] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
+	st->filter_freq_avail[0][0] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
 
 	fadc = ad7192_compute_f_adc(st, true, true);
-	freq[1] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
+	st->filter_freq_avail[1][0] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
 
 	fadc = ad7192_compute_f_adc(st, false, false);
-	freq[2] = DIV_ROUND_CLOSEST(fadc * 230, 1024);
+	st->filter_freq_avail[2][0] = DIV_ROUND_CLOSEST(fadc * 230, 1024);
 
 	fadc = ad7192_compute_f_adc(st, true, false);
-	freq[3] = DIV_ROUND_CLOSEST(fadc * 272, 1024);
+	st->filter_freq_avail[3][0] = DIV_ROUND_CLOSEST(fadc * 272, 1024);
 }
 
-static ssize_t ad7192_show_filter_avail(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7192_state *st = iio_priv(indio_dev);
-	unsigned int freq_avail[4], i;
-	size_t len = 0;
-
-	ad7192_get_available_filter_freq(st, freq_avail);
-
-	for (i = 0; i < ARRAY_SIZE(freq_avail); i++)
-		len += sysfs_emit_at(buf, len, "%d.%03d ", freq_avail[i] / 1000,
-				     freq_avail[i] % 1000);
-
-	buf[len - 1] = '\n';
-
-	return len;
-}
-
-static IIO_DEVICE_ATTR(filter_low_pass_3db_frequency_available,
-		       0444, ad7192_show_filter_avail, NULL, 0);
-
 static IIO_DEVICE_ATTR(bridge_switch_en, 0644,
 		       ad7192_show_bridge_switch, ad7192_set,
 		       AD7192_REG_GPOCON);
@@ -637,7 +624,6 @@ static IIO_DEVICE_ATTR(ac_excitation_en, 0644,
 		       AD7192_REG_CONF);
 
 static struct attribute *ad7192_attributes[] = {
-	&iio_dev_attr_filter_low_pass_3db_frequency_available.dev_attr.attr,
 	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
 	NULL
 };
@@ -647,7 +633,6 @@ static const struct attribute_group ad7192_attribute_group = {
 };
 
 static struct attribute *ad7195_attributes[] = {
-	&iio_dev_attr_filter_low_pass_3db_frequency_available.dev_attr.attr,
 	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
 	&iio_dev_attr_ac_excitation_en.dev_attr.attr,
 	NULL
@@ -665,17 +650,15 @@ static unsigned int ad7192_get_temp_scale(bool unipolar)
 static int ad7192_set_3db_filter_freq(struct ad7192_state *st,
 				      int val, int val2)
 {
-	int freq_avail[4], i, ret, freq;
+	int i, ret, freq;
 	unsigned int diff_new, diff_old;
 	int idx = 0;
 
 	diff_old = U32_MAX;
 	freq = val * 1000 + val2;
 
-	ad7192_get_available_filter_freq(st, freq_avail);
-
-	for (i = 0; i < ARRAY_SIZE(freq_avail); i++) {
-		diff_new = abs(freq - freq_avail[i]);
+	for (i = 0; i < ARRAY_SIZE(st->filter_freq_avail); i++) {
+		diff_new = abs(freq - st->filter_freq_avail[i][0]);
 		if (diff_new < diff_old) {
 			diff_old = diff_new;
 			idx = i;
@@ -792,10 +775,11 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
+	mutex_lock(&st->lock);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
 		ret = -EINVAL;
-		mutex_lock(&st->lock);
 		for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++)
 			if (val2 == st->scale_avail[i][1]) {
 				ret = 0;
@@ -809,7 +793,6 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 				ad7192_calibrate_all(st);
 				break;
 			}
-		mutex_unlock(&st->lock);
 		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		if (!val) {
@@ -826,13 +809,13 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 		st->mode &= ~AD7192_MODE_RATE_MASK;
 		st->mode |= FIELD_PREP(AD7192_MODE_RATE_MASK, div);
 		ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
+		ad7192_update_filter_freq_avail(st);
 		break;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		ret = ad7192_set_3db_filter_freq(st, val, val2 / 1000);
 		break;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		ret = -EINVAL;
-		mutex_lock(&st->lock);
 		for (i = 0; i < ARRAY_SIZE(st->oversampling_ratio_avail); i++)
 			if (val == st->oversampling_ratio_avail[i]) {
 				ret = 0;
@@ -845,12 +828,14 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 						3, st->mode);
 				break;
 			}
-		mutex_unlock(&st->lock);
+		ad7192_update_filter_freq_avail(st);
 		break;
 	default:
 		ret = -EINVAL;
 	}
 
+	mutex_unlock(&st->lock);
+
 	iio_device_release_direct_mode(indio_dev);
 
 	return ret;
@@ -888,6 +873,12 @@ static int ad7192_read_avail(struct iio_dev *indio_dev,
 		/* Values are stored in a 2D matrix  */
 		*length = ARRAY_SIZE(st->scale_avail) * 2;
 
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		*vals = (int *)st->filter_freq_avail;
+		*type = IIO_VAL_FRACTIONAL;
+		*length = ARRAY_SIZE(st->filter_freq_avail) * 2;
+
 		return IIO_AVAIL_LIST;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		*vals = (int *)st->oversampling_ratio_avail;
@@ -956,7 +947,9 @@ static const struct iio_info ad7195_info = {
 			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) | \
 			(_mask_all), \
 		.info_mask_shared_by_type_available = (_mask_type_av), \
-		.info_mask_shared_by_all_available = (_mask_all_av), \
+		.info_mask_shared_by_all_available = \
+			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) | \
+			(_mask_all_av), \
 		.ext_info = (_ext_info), \
 		.scan_index = (_si), \
 		.scan_type = { \
-- 
2.34.1


