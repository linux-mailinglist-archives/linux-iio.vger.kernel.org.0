Return-Path: <linux-iio+bounces-20729-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7187ADBDDF
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 01:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426DA18803A7
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 23:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1753F232367;
	Mon, 16 Jun 2025 23:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RODx3BqO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4D5231A37;
	Mon, 16 Jun 2025 23:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750118011; cv=none; b=GwpG0Trn4PvRwUKbt2dhu6AzSFjiwrc8mlg5NvevWLyktXnkEMH7krSH+P78AOv81LT87cLx+Wf6C5fhDQTjn2ADYuFzI7v8ppelELuq53tlPlvZHGu3WgbuJB234GUmc+jq6VWb1onrv0U1Wn73wAPduzxhhyRTzEZW7wnNRtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750118011; c=relaxed/simple;
	bh=KZGd+uO/a3REvMFjyoK0HG54FJDkLOzIZPL4YenHCgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d5snOIZBvWk3i9mxrRm7e0jJo47G162htrfviowo0Ql0qkqKS/L6vzfLGFSWHXj7X+NqwtGX8wSuMcD4a2UUXGB0/34w6w1dUmPC6bWNye/hePgZLUu3q794UncrCzzzH4uzWcWpvq0PE1XRSHfUoNrNwDgjWDDuhnTkXnoD1Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RODx3BqO; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-236377f00easo66981325ad.1;
        Mon, 16 Jun 2025 16:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750118009; x=1750722809; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YpDHu5+EGQCOtg+8rIcSFHGgC9IaYuMDhU1r7bF5Vf4=;
        b=RODx3BqOSZlo3GPvWR7aYTNRhrHeH7rH0nMunl+66yweTrqB2uOo2KUG12A8AlSZRJ
         TYuH05jwZU1W42RuOVwzwWeIT7tl36KEJno8SDAS3RTRItqrWBB8m84htxv3io/O1LZt
         wc9tYwHh4XkCaC5TzsxENwSIfnwrcStn8vy8bNET8sM8Nn+9u43wptmZWkbyale65gnb
         yIwuW/VZLA/CoqcxuFiV7iVBCAb/KqmMgi+vwLc3kqsPBrxh1biraEDzudhizudvh9sB
         i+WYPA01GCHFJ5rdbHl07i7eh7I9zFdoMdb0LbJBIzoQIHuOmbP71GU7pSQ4UwyBZZbB
         +fFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750118009; x=1750722809;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpDHu5+EGQCOtg+8rIcSFHGgC9IaYuMDhU1r7bF5Vf4=;
        b=vy5BZqMyXWGLgDXgOgC9mOTs9XFajWaYv3j/VJqAWJfGRcLSJD3/Cbx1/eS1wWsxaw
         qubMF4OHYonLBNEZ6TvNMfVT8R9tT5GDFbrRTYTo7Szp+NY98djYEj47zBdrFUDTvNTN
         fFdPZ9sk1jIcOI6wkaAuPtItGPK/jpK0Fw8T3rnGOAy9Kv+QnmhB7Y3E3KlM8GW3ZXAf
         Y4SrPeybbZXMHlcZs5wlkcCfqkiXQsYc3d9laUOgpnEbJG0owYR8K8gUB/vdypnGC/Jo
         sRIbuDuU5znfW7NKcu0EVlpLTz2AGdwiLNg9Xjr0agjScIxGvNFoG73GfPW7LJZmUuAU
         JaJg==
X-Forwarded-Encrypted: i=1; AJvYcCXl34TgL53J1YUDdZWwwx3xQUpqnxVJxQmGiAyQ9ccnEGbpu9o6D1VQLU9DAyzoWXfm/c0spn6Vcwf+Nvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Lh4NxP2O8sk7aQhvBe5zbR+ov5+pAdShwvURFVzxolGapO68
	u64kGysp9wXqCrZDypta3Qd1jlAp45xbz9Gl2oQqmM6MJp3m6s9AQt3Y/08jOAH4
X-Gm-Gg: ASbGncvq/tXtvsPu8pJ946SR24D/VewWKxIv9WLQkBY0tBOuj3abmFmq2P/09JgCDzc
	zOADA6aU1CF4vT1075NhbfpIEg+FZ9cuXntwwHaNsiHJ2hEPR9+7olOObuvady0RVFwrE1oib/g
	rGcZNk6ZC9+Nb2FClOjpvmd5vApgGtOeezvEz2vI53uNoGKPKGgJPILVnv2DiGxiHpGCs9iDDW3
	y02an4eYhEHMwCcqRslp6rHBCUQaCi06KEswIRj+tC05jmBDMWs+DQ5tTOxz63onNccLSU87C+e
	ZpTJeYuuFywDycw4cyLWHXLLqdIMdmZrge/0tjI9W4kvcoVhlASwTs5WTUCpG7+6xbnro4A=
X-Google-Smtp-Source: AGHT+IHzG2UF03C3HkLvodKq5F/E3+AHjvrqSK5BXzI8seQWo84zAhJEvIzIqypm9nY288yuAZ97gw==
X-Received: by 2002:a17:903:32c6:b0:235:ecf2:393 with SMTP id d9443c01a7336-2366b17744bmr177809035ad.53.1750118008949;
        Mon, 16 Jun 2025 16:53:28 -0700 (PDT)
Received: from [192.168.0.9] ([2804:14d:90a8:477c:13e7:d349:8af8:5d32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de782d3sm67515395ad.115.2025.06.16.16.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 16:53:28 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
Date: Mon, 16 Jun 2025 20:53:10 -0300
Subject: [PATCH v3 2/3] iio: imu: bmi270: add step counter watermark event
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-bmi270-events-v3-2-16e37588604f@gmail.com>
References: <20250616-bmi270-events-v3-0-16e37588604f@gmail.com>
In-Reply-To: <20250616-bmi270-events-v3-0-16e37588604f@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lothar Rubusch <l.rubusch@gmail.com>, 
 Gustavo Silva <gustavograzs@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750117999; l=7651;
 i=gustavograzs@gmail.com; s=20250111; h=from:subject:message-id;
 bh=KZGd+uO/a3REvMFjyoK0HG54FJDkLOzIZPL4YenHCgE=;
 b=DgH94BCIKaLMP5nL4DfYU9avlUjzD08V8/81jK8fSWYge1h1Mn0YVw65+bpc05tctoHgc1+yt
 tjknshtOHZkBeUN97TrDDwtYFQsvTzMmt0pOk71UCykdHiyAlUkhkiU
X-Developer-Key: i=gustavograzs@gmail.com; a=ed25519;
 pk=g2TFXpo1jMCOCN+rzVoM9NDFNfSMOgVyY0rlyvk4RTM=

Add support for generating events when the step counter reaches the
configurable watermark.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
 drivers/iio/imu/bmi270/bmi270_core.c | 169 ++++++++++++++++++++++++++++++++++-
 1 file changed, 166 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index c3cf65bb05fc2f6699e107110ee98f703aca3da3..7b632ec5b0108328c216a815535502f0078eb151 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -8,6 +8,7 @@
 #include <linux/regmap.h>
 #include <linux/units.h>
 
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
@@ -28,6 +29,9 @@
 #define BMI270_ACCEL_X_REG				0x0c
 #define BMI270_ANG_VEL_X_REG				0x12
 
+#define BMI270_INT_STATUS_0_REG				0x1c
+#define BMI270_INT_STATUS_0_STEP_CNT_MSK		BIT(1)
+
 #define BMI270_INT_STATUS_1_REG				0x1d
 #define BMI270_INT_STATUS_1_ACC_GYR_DRDY_MSK		GENMASK(7, 6)
 
@@ -74,6 +78,10 @@
 #define BMI270_INT_LATCH_REG				0x55
 #define BMI270_INT_LATCH_REG_MSK			BIT(0)
 
+#define BMI270_INT1_MAP_FEAT_REG			0x56
+#define BMI270_INT2_MAP_FEAT_REG			0x57
+#define BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK		BIT(1)
+
 #define BMI270_INT_MAP_DATA_REG				0x58
 #define BMI270_INT_MAP_DATA_DRDY_INT1_MSK		BIT(2)
 #define BMI270_INT_MAP_DATA_DRDY_INT2_MSK		BIT(6)
@@ -94,6 +102,7 @@
 #define BMI270_PWR_CTRL_ACCEL_EN_MSK			BIT(2)
 #define BMI270_PWR_CTRL_TEMP_EN_MSK			BIT(3)
 
+#define BMI270_STEP_SC26_WTRMRK_MSK			GENMASK(9, 0)
 #define BMI270_STEP_SC26_RST_CNT_MSK			BIT(10)
 #define BMI270_STEP_SC26_EN_CNT_MSK			BIT(12)
 
@@ -101,6 +110,10 @@
 #define BMI270_TEMP_OFFSET				11776
 #define BMI270_TEMP_SCALE				1953125
 
+/* See page 90 of datasheet. The step counter "holds implicitly a 20x factor" */
+#define BMI270_STEP_COUNTER_FACTOR			20
+#define BMI270_STEP_COUNTER_MAX				20460
+
 #define BMI260_INIT_DATA_FILE "bmi260-init-data.fw"
 #define BMI270_INIT_DATA_FILE "bmi270-init-data.fw"
 
@@ -396,6 +409,36 @@ static int bmi270_read_steps(struct bmi270_data *data, int *val)
 	return IIO_VAL_INT;
 }
 
+static int bmi270_int_map_reg(enum bmi270_irq_pin pin)
+{
+	switch (pin) {
+	case BMI270_IRQ_INT1:
+		return BMI270_INT1_MAP_FEAT_REG;
+	case BMI270_IRQ_INT2:
+		return BMI270_INT2_MAP_FEAT_REG;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bmi270_step_wtrmrk_en(struct bmi270_data *data, bool state)
+{
+	int reg;
+
+	guard(mutex)(&data->mutex);
+	if (!data->steps_enabled)
+		return -EINVAL;
+
+	reg = bmi270_int_map_reg(data->irq_pin);
+	if (reg < 0)
+		return reg;
+
+	return regmap_update_bits(data->regmap, reg,
+				  BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK,
+				  FIELD_PREP(BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK,
+					     state));
+}
+
 static int bmi270_set_scale(struct bmi270_data *data, int chan_type, int uscale)
 {
 	int i;
@@ -552,19 +595,31 @@ static irqreturn_t bmi270_irq_thread_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
 	struct bmi270_data *data = iio_priv(indio_dev);
-	unsigned int status;
+	unsigned int status0, status1;
+	s64 timestamp = iio_get_time_ns(indio_dev);
 	int ret;
 
 	scoped_guard(mutex, &data->mutex) {
+		ret = regmap_read(data->regmap, BMI270_INT_STATUS_0_REG,
+				  &status0);
+		if (ret)
+			return IRQ_NONE;
+
 		ret = regmap_read(data->regmap, BMI270_INT_STATUS_1_REG,
-				  &status);
+				  &status1);
 		if (ret)
 			return IRQ_NONE;
 	}
 
-	if (FIELD_GET(BMI270_INT_STATUS_1_ACC_GYR_DRDY_MSK, status))
+	if (FIELD_GET(BMI270_INT_STATUS_1_ACC_GYR_DRDY_MSK, status1))
 		iio_trigger_poll_nested(data->trig);
 
+	if (FIELD_GET(BMI270_INT_STATUS_0_STEP_CNT_MSK, status0))
+		iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_STEPS, 0,
+							       IIO_EV_TYPE_CHANGE,
+							       IIO_EV_DIR_NONE),
+			       timestamp);
+
 	return IRQ_HANDLED;
 }
 
@@ -772,10 +827,116 @@ static int bmi270_read_avail(struct iio_dev *indio_dev,
 	}
 }
 
+static int bmi270_write_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir, bool state)
+{
+	struct bmi270_data *data = iio_priv(indio_dev);
+
+	switch (type) {
+	case IIO_EV_TYPE_CHANGE:
+		return bmi270_step_wtrmrk_en(data, state);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bmi270_read_event_config(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir)
+{
+	struct bmi270_data *data = iio_priv(indio_dev);
+	int ret, reg, regval;
+
+	guard(mutex)(&data->mutex);
+
+	switch (chan->type) {
+	case IIO_STEPS:
+		reg = bmi270_int_map_reg(data->irq_pin);
+		if (reg)
+			return reg;
+
+		ret = regmap_read(data->regmap, reg, &regval);
+		if (ret)
+			return ret;
+		return FIELD_GET(BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK,
+				 regval) ? 1 : 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bmi270_write_event_value(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info,
+				    int val, int val2)
+{
+	struct bmi270_data *data = iio_priv(indio_dev);
+	unsigned int raw;
+
+	guard(mutex)(&data->mutex);
+
+	switch (type) {
+	case IIO_EV_TYPE_CHANGE:
+		if (!in_range(val, 0, BMI270_STEP_COUNTER_MAX + 1))
+			return -EINVAL;
+
+		raw = val / BMI270_STEP_COUNTER_FACTOR;
+		return bmi270_update_feature_reg(data, BMI270_SC_26_REG,
+						 BMI270_STEP_SC26_WTRMRK_MSK,
+						 FIELD_PREP(BMI270_STEP_SC26_WTRMRK_MSK,
+							    raw));
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bmi270_read_event_value(struct iio_dev *indio_dev,
+				   const struct iio_chan_spec *chan,
+				   enum iio_event_type type,
+				   enum iio_event_direction dir,
+				   enum iio_event_info info,
+				   int *val, int *val2)
+{
+	struct bmi270_data *data = iio_priv(indio_dev);
+	unsigned int raw;
+	u16 regval;
+	int ret;
+
+	guard(mutex)(&data->mutex);
+
+	switch (type) {
+	case IIO_EV_TYPE_CHANGE:
+		ret = bmi270_read_feature_reg(data, BMI270_SC_26_REG, &regval);
+		if (ret)
+			return ret;
+
+		raw = FIELD_GET(BMI270_STEP_SC26_WTRMRK_MSK, regval);
+		*val = raw * BMI270_STEP_COUNTER_FACTOR;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_event_spec bmi270_step_wtrmrk_event = {
+	.type = IIO_EV_TYPE_CHANGE,
+	.dir = IIO_EV_DIR_NONE,
+	.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) | BIT(IIO_EV_INFO_VALUE),
+};
+
 static const struct iio_info bmi270_info = {
 	.read_raw = bmi270_read_raw,
 	.write_raw = bmi270_write_raw,
 	.read_avail = bmi270_read_avail,
+	.write_event_config = bmi270_write_event_config,
+	.read_event_config = bmi270_read_event_config,
+	.write_event_value = bmi270_write_event_value,
+	.read_event_value = bmi270_read_event_value,
 };
 
 #define BMI270_ACCEL_CHANNEL(_axis) {				\
@@ -835,6 +996,8 @@ static const struct iio_chan_spec bmi270_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_ENABLE) |
 				      BIT(IIO_CHAN_INFO_PROCESSED),
 		.scan_index = -1, /* No buffer support */
+		.event_spec = &bmi270_step_wtrmrk_event,
+		.num_event_specs = 1,
 	},
 	IIO_CHAN_SOFT_TIMESTAMP(BMI270_SCAN_TIMESTAMP),
 };

-- 
2.49.0


