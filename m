Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8AC7A6FE7
	for <lists+linux-iio@lfdr.de>; Wed, 20 Sep 2023 02:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjITAei (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 20:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjITAeg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 20:34:36 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457C3D9;
        Tue, 19 Sep 2023 17:34:28 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-402d0eda361so68016685e9.0;
        Tue, 19 Sep 2023 17:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695170067; x=1695774867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neLQJU5AoVyFWxI82yD7nbKJMFul1zqxk0Q7yhVgWvE=;
        b=JkrlNXAYfVNL7VG59tOsh3PjKUfJaeAv5+SsIzi7PZhb+2NUWNvRmZ7XqBuEjgS7P2
         d5hI9Wo3RvQwbnUBZxzf/CtV8ww6xFctKiXdi8hyrUgVRU5K6evfqMbhB3svnyNRQ7g+
         BDY+64K18wwLqPVuVNF39dXoFzrI3h0r9nea58e8pOuNBeDL7L0L8KzUePtmOGaBiHSR
         S6KEGWaPgjBN5gcm1IUbqa7yLxB9233qp3lzgnbNa6yJF5MQ0ta0fvRms8wH9+l+39ow
         JN0Axy3KlfBVuYIgfmV12PsqWL+bQvD9ayiaBoy7wA701PGDpWzcsHeMJzwjfXWKSTCM
         be4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695170067; x=1695774867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=neLQJU5AoVyFWxI82yD7nbKJMFul1zqxk0Q7yhVgWvE=;
        b=kjR97VoTB/W6hiTWNmbgjMVQQ2Mvn66mJ4qFtLcmseE9sYsnSnvqmkOKzTdkgZJIrP
         3r7jUFWsdpTMdSOU0sYGpxwjpybzOswBjT5NHklTmkghlkXFk7X1ab8qIP4ko+8qP79I
         h5qBYDrDFh6r3HajDhEpdnvkAAAREFUwbglizdW2stPXyzBDl1+vrlHy/qo7k/gzlbOl
         TJcwHH7e0P8rme0wr+bIbGjKI+8+duTRVwU/FL00Nl91H3E2Y6Tr9+jP6zM+Mn+ju2F6
         2aJ0Vxys1WZpYDWn6+Hu0GuuwSB3sUQwziKrCdI12eCE61xURMvPgdoTLOrShnbx5Bva
         yK9w==
X-Gm-Message-State: AOJu0YyZyq97iCmjLW91CcU30EuMRkvzy/9RpWetoCDy7ehw34Nwi8b5
        ZGlC6IcK5UWopQHT9+bexxHgmPqgqfPxZmhQ
X-Google-Smtp-Source: AGHT+IE1LxL4fWLnaktVeK9Fv+9hhhvmh6RL6dSj6CWwqfkxqBfHmkh9K+wRNXLLWt90/62hBEw1Vw==
X-Received: by 2002:a7b:cc8d:0:b0:3fb:e356:b60d with SMTP id p13-20020a7bcc8d000000b003fbe356b60dmr1104438wma.38.1695170066654;
        Tue, 19 Sep 2023 17:34:26 -0700 (PDT)
Received: from spiri.. ([2a02:2f08:a301:7000:7838:74ca:1f92:5a36])
        by smtp.gmail.com with ESMTPSA id g7-20020a05600c310700b003fe15ac0934sm506343wmo.1.2023.09.19.17.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 17:34:26 -0700 (PDT)
From:   alisadariana@gmail.com
Cc:     Alisa-Dariana Roman <alisadariana@gmail.com>,
        Alisa-Dariana Roman <alisa.roman@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] iio: adc: ad7192: Add fast settling support
Date:   Wed, 20 Sep 2023 03:33:42 +0300
Message-Id: <20230920003342.118813-4-alisadariana@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920003342.118813-1-alisadariana@gmail.com>
References: <20230920003342.118813-1-alisadariana@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alisa-Dariana Roman <alisadariana@gmail.com>

Add fast settling mode support for AD7193.

Add fast_settling_average_factor attribute. Expose to user the current
value of the fast settling average factor. User can change the value by
writing a new one.

Add fast_settling_average_factor_available attribute. Expose to user
possible values for the fast settling average factor.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 .../ABI/testing/sysfs-bus-iio-adc-ad7192      |  18 +++
 drivers/iio/adc/ad7192.c                      | 128 ++++++++++++++++--
 2 files changed, 134 insertions(+), 12 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
index f8315202c8f0..5790adbb1cc1 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
@@ -19,6 +19,24 @@ Description:
 		the bridge can be disconnected (when it is not being used
 		using the bridge_switch_en attribute.
 
+What:		/sys/bus/iio/devices/iio:deviceX/fast_settling_average_factor
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute, if available, is used to activate or deactivate
+		fast settling mode and set the value of the average factor to
+		1, 2, 8 or 16. If the average factor is set to 1, the fast
+		settling mode is disabled. The data from the sinc filter is
+		averaged by chosen value. The averaging reduces the output data
+		rate for a given FS word, however, the rms noise improves.
+
+What:		/sys/bus/iio/devices/iio:deviceX/fast_settling_average_factor_available
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading returns a list with the possible values for the fast
+		settling average factor: 1, 2, 8, 16.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration
 KernelVersion:
 Contact:	linux-iio@vger.kernel.org
diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index eed3de02c26d..8987b78865f3 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -60,6 +60,8 @@
 #define AD7192_MODE_SEL_MASK	GENMASK(23, 21) /* Operation Mode Select Mask */
 #define AD7192_MODE_STA_MASK	BIT(20) /* Status Register transmission Mask */
 #define AD7192_MODE_CLKSRC_MASK	GENMASK(19, 18) /* Clock Source Select Mask */
+#define AD7192_MODE_AVG_MASK	GENMASK(17, 16)
+		  /* Fast Settling Filter Average Select Mask (AD7193 only) */
 #define AD7192_MODE_SINC3	BIT(15) /* SINC3 Filter Select */
 #define AD7192_MODE_ENPAR	BIT(13) /* Parity Enable */
 #define AD7192_MODE_CLKDIV	BIT(12) /* Clock divide by 2 (AD7190/2 only)*/
@@ -182,6 +184,7 @@ struct ad7192_state {
 	u32				mode;
 	u32				conf;
 	u32				scale_avail[8][2];
+	u8				avg_avail[4];
 	u8				gpocon;
 	u8				clock_sel;
 	struct mutex			lock;	/* protect sensor state */
@@ -459,6 +462,13 @@ static int ad7192_setup(struct iio_dev *indio_dev, struct device_node *np)
 		st->scale_avail[i][0] = scale_uv;
 	}
 
+	if (st->chip_info->chip_id == CHIPID_AD7193) {
+		st->avg_avail[0] = 1;
+		st->avg_avail[1] = 2;
+		st->avg_avail[2] = 8;
+		st->avg_avail[3] = 16;
+	}
+
 	return 0;
 }
 
@@ -483,6 +493,18 @@ static ssize_t ad7192_show_bridge_switch(struct device *dev,
 			  !!FIELD_GET(AD7192_GPOCON_BPDSW, st->gpocon));
 }
 
+static ssize_t ad7192_show_average_factor(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ad7192_state *st = iio_priv(indio_dev);
+	u8 avg_factor_index;
+
+	avg_factor_index = FIELD_GET(AD7192_MODE_AVG_MASK, st->mode);
+	return sysfs_emit(buf, "%d\n", st->avg_avail[avg_factor_index]);
+}
+
 static ssize_t ad7192_set(struct device *dev,
 			  struct device_attribute *attr,
 			  const char *buf,
@@ -491,12 +513,10 @@ static ssize_t ad7192_set(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7192_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	bool val, ret_einval;
+	u8 val_avg_factor;
+	unsigned int i;
 	int ret;
-	bool val;
-
-	ret = kstrtobool(buf, &val);
-	if (ret < 0)
-		return ret;
 
 	ret = iio_device_claim_direct_mode(indio_dev);
 	if (ret)
@@ -504,6 +524,10 @@ static ssize_t ad7192_set(struct device *dev,
 
 	switch ((u32)this_attr->address) {
 	case AD7192_REG_GPOCON:
+		ret = kstrtobool(buf, &val);
+		if (ret < 0)
+			return ret;
+
 		if (val)
 			st->gpocon |= AD7192_GPOCON_BPDSW;
 		else
@@ -512,6 +536,10 @@ static ssize_t ad7192_set(struct device *dev,
 		ad_sd_write_reg(&st->sd, AD7192_REG_GPOCON, 1, st->gpocon);
 		break;
 	case AD7192_REG_CONF:
+		ret = kstrtobool(buf, &val);
+		if (ret < 0)
+			return ret;
+
 		if (val)
 			st->conf |= AD7192_CONF_ACX;
 		else
@@ -519,6 +547,27 @@ static ssize_t ad7192_set(struct device *dev,
 
 		ad_sd_write_reg(&st->sd, AD7192_REG_CONF, 3, st->conf);
 		break;
+	case AD7192_REG_MODE:
+		ret = kstrtou8(buf, 10, &val_avg_factor);
+		if (ret < 0)
+			return ret;
+
+		ret_einval = true;
+		for (i = 0; i < ARRAY_SIZE(st->avg_avail); i++) {
+			if (val_avg_factor == st->avg_avail[i]) {
+				st->mode &= ~AD7192_MODE_AVG_MASK;
+				st->mode |= FIELD_PREP(AD7192_MODE_AVG_MASK, i);
+				ret_einval = false;
+			}
+		}
+
+		if (ret_einval)
+			return -EINVAL;
+
+		ret = ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
+		if (ret)
+			return ret;
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -528,15 +577,22 @@ static ssize_t ad7192_set(struct device *dev,
 	return ret ? ret : len;
 }
 
-static int ad7192_compute_f_order(bool sinc3_en, bool chop_en)
+static int ad7192_compute_f_order(struct ad7192_state *st, bool sinc3_en, bool chop_en)
 {
-	if (!chop_en)
+	u8 avg_factor;
+	u8 avg_factor_selected;
+
+	avg_factor_selected = FIELD_GET(AD7192_MODE_AVG_MASK, st->mode);
+
+	if (!avg_factor_selected && !chop_en)
 		return 1;
 
+	avg_factor = st->avg_avail[avg_factor_selected];
+
 	if (sinc3_en)
-		return AD7192_SYNC3_FILTER;
+		return AD7192_SYNC3_FILTER + avg_factor - 1;
 
-	return AD7192_SYNC4_FILTER;
+	return AD7192_SYNC4_FILTER + avg_factor - 1;
 }
 
 static int ad7192_get_f_order(struct ad7192_state *st)
@@ -546,13 +602,13 @@ static int ad7192_get_f_order(struct ad7192_state *st)
 	sinc3_en = FIELD_GET(AD7192_MODE_SINC3, st->mode);
 	chop_en = FIELD_GET(AD7192_CONF_CHOP, st->conf);
 
-	return ad7192_compute_f_order(sinc3_en, chop_en);
+	return ad7192_compute_f_order(st, sinc3_en, chop_en);
 }
 
 static int ad7192_compute_f_adc(struct ad7192_state *st, bool sinc3_en,
 				bool chop_en)
 {
-	unsigned int f_order = ad7192_compute_f_order(sinc3_en, chop_en);
+	unsigned int f_order = ad7192_compute_f_order(st, sinc3_en, chop_en);
 
 	return DIV_ROUND_CLOSEST(st->fclk,
 				 f_order * FIELD_PREP(AD7192_MODE_RATE_MASK, st->mode));
@@ -605,9 +661,29 @@ static ssize_t ad7192_show_filter_avail(struct device *dev,
 	return len;
 }
 
+static ssize_t ad7192_show_avg_factor_avail(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ad7192_state *st = iio_priv(indio_dev);
+	unsigned int i;
+	size_t len = 0;
+
+	for (i = 0; i < ARRAY_SIZE(st->avg_avail); i++)
+		len += sysfs_emit_at(buf, len, "%d ", st->avg_avail[i]);
+
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
 static IIO_DEVICE_ATTR(filter_low_pass_3db_frequency_available,
 		       0444, ad7192_show_filter_avail, NULL, 0);
 
+static IIO_DEVICE_ATTR(fast_settling_average_factor_available,
+		       0444, ad7192_show_avg_factor_avail, NULL, 0);
+
 static IIO_DEVICE_ATTR(bridge_switch_en, 0644,
 		       ad7192_show_bridge_switch, ad7192_set,
 		       AD7192_REG_GPOCON);
@@ -616,6 +692,10 @@ static IIO_DEVICE_ATTR(ac_excitation_en, 0644,
 		       ad7192_show_ac_excitation, ad7192_set,
 		       AD7192_REG_CONF);
 
+static IIO_DEVICE_ATTR(fast_settling_average_factor, 0644,
+		       ad7192_show_average_factor, ad7192_set,
+		       AD7192_REG_MODE);
+
 static struct attribute *ad7192_attributes[] = {
 	&iio_dev_attr_filter_low_pass_3db_frequency_available.dev_attr.attr,
 	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
@@ -626,6 +706,18 @@ static const struct attribute_group ad7192_attribute_group = {
 	.attrs = ad7192_attributes,
 };
 
+static struct attribute *ad7193_attributes[] = {
+	&iio_dev_attr_filter_low_pass_3db_frequency_available.dev_attr.attr,
+	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
+	&iio_dev_attr_fast_settling_average_factor.dev_attr.attr,
+	&iio_dev_attr_fast_settling_average_factor_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group ad7193_attribute_group = {
+	.attrs = ad7193_attributes,
+};
+
 static struct attribute *ad7195_attributes[] = {
 	&iio_dev_attr_filter_low_pass_3db_frequency_available.dev_attr.attr,
 	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
@@ -882,6 +974,16 @@ static const struct iio_info ad7192_info = {
 	.update_scan_mode = ad7192_update_scan_mode,
 };
 
+static const struct iio_info ad7193_info = {
+	.read_raw = ad7192_read_raw,
+	.write_raw = ad7192_write_raw,
+	.write_raw_get_fmt = ad7192_write_raw_get_fmt,
+	.read_avail = ad7192_read_avail,
+	.attrs = &ad7193_attribute_group,
+	.validate_trigger = ad_sd_validate_trigger,
+	.update_scan_mode = ad7192_update_scan_mode,
+};
+
 static const struct iio_info ad7195_info = {
 	.read_raw = ad7192_read_raw,
 	.write_raw = ad7192_write_raw,
@@ -1056,7 +1158,9 @@ static int ad7192_probe(struct spi_device *spi)
 	if (ret < 0)
 		return ret;
 
-	if (st->chip_info->chip_id == CHIPID_AD7195)
+	if (st->chip_info->chip_id == CHIPID_AD7193)
+		indio_dev->info = &ad7193_info;
+	else if (st->chip_info->chip_id == CHIPID_AD7195)
 		indio_dev->info = &ad7195_info;
 	else
 		indio_dev->info = &ad7192_info;
-- 
2.34.1

