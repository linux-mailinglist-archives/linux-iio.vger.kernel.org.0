Return-Path: <linux-iio+bounces-9422-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5333C97289D
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 06:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603811C23D94
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 04:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785CC17C7C2;
	Tue, 10 Sep 2024 04:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njBlvBz9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B040F17ADF1;
	Tue, 10 Sep 2024 04:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725943907; cv=none; b=ElYuvBG8627uR0JsmGve9ihjTjhEwHlu395rt4XuqZGKvfZXVu3P/zd9AOCPr4VgJm4SHcn0wcUiT1EPGhURAdXouwpoIYAIdf0ceL+V6073IBNm4T274LJJpW82qoUACBiRNqlJuNA+pJ2Q3P15W5eP4AR53IYbH9TOvTCE+SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725943907; c=relaxed/simple;
	bh=v37FDpFE36W7mV9epj6fFeV3Ik5HTRhfwDrvQQ8bovg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jsWGSUTY313BfXNph81mWSdpvBZQEB6MdDqpxUiUfj4xS0Jf1oDFJxqkiNXu3nVEpkSEGZmSGHQJVcsalxmi0JA/ZfgfwjwC0PSb3UHjoTqhkCzKA5Ph1cjLBUrkFmPRBAceugzCaLdQnK5L2c0Zjng43n+s07QmNTJB3K5BIYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njBlvBz9; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-205722ba00cso43262005ad.0;
        Mon, 09 Sep 2024 21:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725943904; x=1726548704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83ljQ5eji9mYeH6V/mqjH2Y9avWtITn03WqxwrNIYP0=;
        b=njBlvBz9FnGU//cFCbIeUm2RYLS9Ww4cEXYCZBAuQIb3IctHSnL/lMxfg5Q3FrazWP
         DlA+QCFZ8kyQ8LOlsmyK0xUiTbp7+QOCoSOSfVBMBEPp7MdgesRFquk67FY+lJF/CAmm
         jRXM2XWulpGrVVxCS2GtcBA7EYCn9JEzSk1UJfvmPLHaWeFfaosScvA0xaIeyNMCL6mD
         UoAg/Pxm3bhtMod4BHtoMcZVtuOTxMbudQWDge5fcpFyuRq+ZapXymavH4olUQmPWnvp
         ihprzYVMYlCTg5QoUyIanBtkO0E+Rs4RqWDbmDqx0wa/CFr+QF6CSRD37oH7OaH1pLER
         fFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725943904; x=1726548704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83ljQ5eji9mYeH6V/mqjH2Y9avWtITn03WqxwrNIYP0=;
        b=SfvLaRmoi8iNYteWu1t9js3zRndKfb5GKMDYOogayuzS1cHbf05+FSE93dCEHwaIiO
         7Xl1YMGYAIulgKeGd346Xkw8G1QENP5jPr9sTT3vdo+uJg/0C3QXiSvBydL9UOfYUaI5
         /1+3hMXKoRVg8lAcJjX1ZdOJGE1e3Et3GeiDbVHqQZ/MmRVWuqeD0T1hC1Kow85/y0pf
         HEzs75894Nv34HwA5OBy/5NDMMTWwQsFoTPyK361l88Zc6ITtfjAED59gvJnZHqU2WNj
         9vDvgsFCgjzkqmwMjs0vJJcG5GNq7M+PIO/978cSoR8qz5IKeZtalKc82yofi8FYbQoo
         IBOA==
X-Forwarded-Encrypted: i=1; AJvYcCX0lut9CCjGurvMf+MDJ0PNjSV53hqs8pha+IijwPZ+EM9d2saQcJ9WVzhVUdeLEfv0jRxU5QJZvZUtIho=@vger.kernel.org
X-Gm-Message-State: AOJu0YywxQ/hWb/RKX675KpMVzodJG096XOIFnnvE9+GcPd1eqjChSVQ
	4U1lS9Z9bQxWB9As1kNF5yTyoNeGyGA67kStI2QNfjtmqOQ4t3cKyIR8KmlT7DY=
X-Google-Smtp-Source: AGHT+IHeuf2Mxslu+aWTb4XZuPj5vK22w7vFS//6vTu/v0+wLh1htz/3bWFdvQpR43bXi6SdVZQIaw==
X-Received: by 2002:a17:902:fc43:b0:205:42cf:2226 with SMTP id d9443c01a7336-206f064fdfbmr158818685ad.55.1725943904239;
        Mon, 09 Sep 2024 21:51:44 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20710ee70a1sm40882965ad.121.2024.09.09.21.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 21:51:43 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v2 3/4] iio: light: ltr390: Interrupts and threshold event support
Date: Tue, 10 Sep 2024 10:20:28 +0530
Message-ID: <20240910045030.266946-4-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910045030.266946-1-abhashkumarjha123@gmail.com>
References: <20240910045030.266946-1-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added support for threshold events for both the ALS and UVI channels.
The events are reported when the threshold interrupt is triggered. Both
rising and falling threshold types are supported.

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/light/ltr390.c | 222 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 220 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index c4ff26d68..8a8a118ca 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -24,8 +24,11 @@
 #include <linux/mutex.h>
 #include <linux/regmap.h>
 #include <linux/bitfield.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/events.h>
 
 #include <asm/unaligned.h>
 
@@ -33,9 +36,12 @@
 #define LTR390_ALS_UVS_MEAS_RATE	0x04
 #define LTR390_ALS_UVS_GAIN		0x05
 #define LTR390_PART_ID			0x06
+#define LTR390_MAIN_STATUS		0x07
 #define LTR390_ALS_DATA			0x0D
 #define LTR390_UVS_DATA			0x10
 #define LTR390_INT_CFG			0x19
+#define LTR390_THRESH_UP		0x21
+#define LTR390_THRESH_LOW		0x24
 
 #define LTR390_PART_NUMBER_ID		0xb
 #define LTR390_ALS_UVS_GAIN_MASK	0x07
@@ -46,6 +52,8 @@
 #define LTR390_SW_RESET	      BIT(4)
 #define LTR390_UVS_MODE	      BIT(3)
 #define LTR390_SENSOR_ENABLE  BIT(1)
+#define LTR390_LS_INT_EN      BIT(2)
+#define LTR390_LS_INT_SEL_UVS BIT(5)
 
 #define LTR390_FRACTIONAL_PRECISION 100
 
@@ -230,6 +238,22 @@ static const int ltr390_int_time_map_us[] = { 400000, 200000, 100000, 50000, 250
 static const int ltr390_gain_map[] = { 1, 3, 6, 9, 18 };
 static const int ltr390_freq_map[] = { 40000, 20000, 10000, 5000, 2000, 1000, 500, 500 };
 
+static const struct iio_event_spec ltr390_event_spec[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	}
+};
+
 static const struct iio_chan_spec ltr390_channels[] = {
 	/* UV sensor */
 	{
@@ -238,7 +262,9 @@ static const struct iio_chan_spec ltr390_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SCALE)
-						| BIT(IIO_CHAN_INFO_SAMP_FREQ)
+						| BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.event_spec = ltr390_event_spec,
+		.num_event_specs = ARRAY_SIZE(ltr390_event_spec),
 	},
 	/* ALS sensor */
 	{
@@ -247,7 +273,9 @@ static const struct iio_chan_spec ltr390_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SCALE)
-						| BIT(IIO_CHAN_INFO_SAMP_FREQ)
+						| BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.event_spec = ltr390_event_spec,
+		.num_event_specs = ARRAY_SIZE(ltr390_event_spec),
 	},
 };
 
@@ -370,12 +398,186 @@ static int ltr390_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec cons
 	}
 }
 
+static int ltr390_read_threshold(const struct iio_dev *indio_dev,
+				enum iio_event_direction dir,
+				int *val, int *val2)
+{
+	struct ltr390_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		ret = ltr390_register_read(data, LTR390_THRESH_UP);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		return IIO_VAL_INT;
+
+	case IIO_EV_DIR_FALLING:
+		ret = ltr390_register_read(data, LTR390_THRESH_LOW);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ltr390_write_threshold(struct iio_dev *indio_dev,
+				enum iio_event_direction dir,
+				int val, int val2)
+{
+	struct ltr390_data *data = iio_priv(indio_dev);
+	int ret;
+
+	guard(mutex)(&data->lock);
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		ret = regmap_bulk_write(data->regmap,
+					LTR390_THRESH_UP,
+					&val, 3);
+		return ret;
+	case IIO_EV_DIR_FALLING:
+		ret = regmap_bulk_write(data->regmap,
+					LTR390_THRESH_LOW,
+					&val, 3);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ltr390_read_event_value(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				enum iio_event_info info,
+				int *val, int *val2)
+{
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		return ltr390_read_threshold(indio_dev, dir, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ltr390_write_event_value(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				enum iio_event_info info,
+				int val, int val2)
+{
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		if (val2 != 0)
+			return -EINVAL;
+
+		return ltr390_write_threshold(indio_dev, dir, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ltr390_read_event_config(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir)
+{
+	struct ltr390_data *data = iio_priv(indio_dev);
+	int ret, status;
+
+	ret = regmap_read(data->regmap, LTR390_INT_CFG, &status);
+	if (ret < 0)
+		return ret;
+
+	return status & LTR390_LS_INT_EN;
+}
+
+static int ltr390_write_event_config(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				int state)
+{
+	struct ltr390_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (state != 1  && state != 0)
+		return -EINVAL;
+
+	if (state == 0)
+		return regmap_clear_bits(data->regmap, LTR390_INT_CFG, LTR390_LS_INT_EN);
+
+	guard(mutex)(&data->lock);
+	ret = regmap_set_bits(data->regmap, LTR390_INT_CFG, LTR390_LS_INT_EN);
+	if (ret < 0)
+		return ret;
+
+	switch (chan->type) {
+	case IIO_LIGHT:
+		ret = ltr390_set_mode(data, LTR390_SET_ALS_MODE);
+		if (ret < 0)
+			return ret;
+
+		return regmap_clear_bits(data->regmap, LTR390_INT_CFG, LTR390_LS_INT_SEL_UVS);
+
+	case IIO_UVINDEX:
+		ret = ltr390_set_mode(data, LTR390_SET_UVS_MODE);
+		if (ret < 0)
+			return ret;
+
+		return regmap_set_bits(data->regmap, LTR390_INT_CFG, LTR390_LS_INT_SEL_UVS);
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct iio_info ltr390_info = {
 	.read_raw = ltr390_read_raw,
 	.write_raw = ltr390_write_raw,
 	.read_avail = ltr390_read_avail,
+	.read_event_value = ltr390_read_event_value,
+	.read_event_config = ltr390_read_event_config,
+	.write_event_value = ltr390_write_event_value,
+	.write_event_config = ltr390_write_event_config,
 };
 
+static irqreturn_t ltr390_interrupt_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct ltr390_data *data = iio_priv(indio_dev);
+	int ret, status;
+
+	/* Reading the status register to clear the interrupt flag, Datasheet pg: 17*/
+	ret = regmap_read(data->regmap, LTR390_MAIN_STATUS, &status);
+	if (ret < 0)
+		return ret;
+
+	switch (data->mode) {
+	case LTR390_SET_ALS_MODE:
+		iio_push_event(indio_dev,
+			IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
+			IIO_EV_TYPE_THRESH,
+			IIO_EV_DIR_EITHER),
+			iio_get_time_ns(indio_dev));
+		break;
+
+	case LTR390_SET_UVS_MODE:
+		iio_push_event(indio_dev,
+			IIO_UNMOD_EVENT_CODE(IIO_UVINDEX, 0,
+			IIO_EV_TYPE_THRESH,
+			IIO_EV_DIR_EITHER),
+			iio_get_time_ns(indio_dev));
+		break;
+	}
+
+	return IRQ_HANDLED;
+}
+
 static int ltr390_probe(struct i2c_client *client)
 {
 	struct ltr390_data *data;
@@ -429,6 +631,22 @@ static int ltr390_probe(struct i2c_client *client)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to enable the sensor\n");
 
+	if (client->irq) {
+		int irq_flags = irq_get_trigger_type(client->irq);
+
+		if (!irq_flags)
+			irq_flags = IRQF_TRIGGER_FALLING;
+
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						NULL, ltr390_interrupt_handler,
+						irq_flags | IRQF_ONESHOT,
+						"ltr390_thresh_event", indio_dev);
+		if (ret) {
+			dev_err(&client->dev, "request irq (%d) failed\n", client->irq);
+			return ret;
+		}
+	}
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 
-- 
2.43.0


