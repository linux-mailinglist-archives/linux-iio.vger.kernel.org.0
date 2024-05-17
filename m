Return-Path: <linux-iio+bounces-5088-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE168C8274
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 10:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 177181F22428
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 08:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98C229417;
	Fri, 17 May 2024 08:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsXnyUD3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B25E20DCC;
	Fri, 17 May 2024 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933460; cv=none; b=ramAtEzPxLFdjgPYW1PzMZmRpn4v1TjWyQCuXS4sp+HuTly5u1lKGRhNSpTlyYAgpqUoKwY0MTk2cmH9NnmZNGJG3mzDHtRdwBQNe9fvQCsejvU/TtvYAMK8VqDQTsDrQzclksBAf7qWOhpn6gl6jGCgi4mPBZQNCz0fQsfKQW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933460; c=relaxed/simple;
	bh=qXw5ko4n8qqOov9dwA8bnMX9jAPjqa/fBKKn4VOhDGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGlC1wR6phTk1h7UAXnVlS9hwpa5jt1UfYbbyw51JvIAWh/tMpJNShKk+HOwHHM46CfUnTTsVhK9xQKVOcrYJB8lC0/UfxaVuJVjLZa6tEKoPx7XYRapwJNKnN9YOsg4nxKmHOtmCY75PmoY3a4MrzsJbwLFNwZf56C68dB/cAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsXnyUD3; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a5a5c930cf6so406912066b.0;
        Fri, 17 May 2024 01:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715933457; x=1716538257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCQlIq3bUeSXGbvzvLqm91OUPJg4r+AueBXrJBzAHIA=;
        b=DsXnyUD3u5+M61sqapypYzxBZ96xKnvNNxCG3VgYK4xUCQaXRtCQt98asvKFL5ApJ+
         2R9EljvYKMF2t4n9YqlxqFj5SGhKpo39iSYc7MDcqo7sIe3E+LEWUNxTlzjRQwOkRKh6
         tLz5RjKwiYO0teCTIDXIKuI4cGMLwA1ASmaZlNyBqF8aO+8TbQn5szlbefYl9fTeLmDb
         g4UcYQG9Gtv10dLsoJL/EDR0tSdROkmTGpJPgk1pItdB8OJLp44aVwYhGGH8t6sVoEt1
         CeABiE6u8z7xIYlM1h4q5r6zGiu8jg1n5CRewHmnR4aKVJOm/2QV5M2juCPbow1dcmQN
         h7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715933457; x=1716538257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCQlIq3bUeSXGbvzvLqm91OUPJg4r+AueBXrJBzAHIA=;
        b=A8pHsupoGMh5B6dorCsbH8UIidXJwYqmSLAF19tTd77bi+fGU/ZfHLUq+oE+1TuMJf
         zWdvgt1wD3/3cdrEJaZey6hDxW7vHx322TC7Wg9U+PtM/jm9dIJXWpL+axWCakxFdm6Q
         yjH5QqZprvtLfTlF1RXEBQXbj6Iy0V74rV/8/R54hpSPxCMphZEGnvXJaYBqgwOHwGj0
         FRBKxB7OgXBpYS1k8nzqaREj4BnTZbDOyUrp7nc0xSxLJYmlz1kTfXjBZMiOfYQ43qQJ
         HRDT6B6Ojxkfk9vxin7Ycdh0ZOsVzhSM4rAVGK3Gkevbkb2QVltAJCvwDOESaeFhOWcg
         X3Mg==
X-Forwarded-Encrypted: i=1; AJvYcCV2vKP6Al0fjgo8f2Wq4LUDrIRTDxqIhWVMzjqe1zNEJd27lVUSSScNXm2ybBrXRuoeWjG1OFOCcDLZeLOGTMeFTuUnkRSM9Hdonm/QO5mMSCz2Z0OAL9eV823lSb0Z7ebxqo5i4fRV
X-Gm-Message-State: AOJu0Yx9cSqyHRAh3KXxwfKSErrUfJSR/oz07MD4SLyqBfYdGZSnOMCX
	EdyRerVhonrvFTyYfur08nHnkL97lIrAd9zjclX2cOtN7wdvBiP1ms9UzA==
X-Google-Smtp-Source: AGHT+IHqZ6Q3ql3Pj1QU6p9PKQAb6AIaFMGaR6ms9iyuyUcfh/kcoj6m23VmF3bpg7aSSiPbF/Jw7Q==
X-Received: by 2002:a17:906:a18f:b0:a5a:234d:98ee with SMTP id a640c23a62f3a-a5a2d5cd8a7mr1320035766b.44.1715933456617;
        Fri, 17 May 2024 01:10:56 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a90d0e919sm360867866b.85.2024.05.17.01.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 01:10:55 -0700 (PDT)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Hepp <andrew.hepp@ahepp.dev>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] iio: temperature: mcp9600: add threshold events support
Date: Fri, 17 May 2024 10:10:50 +0200
Message-Id: <20240517081050.168698-3-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240517081050.168698-1-dima.fedrau@gmail.com>
References: <20240517081050.168698-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The device has four programmable temperature alert outputs which can be
used to monitor hot or cold-junction temperatures and detect falling and
rising temperatures. It supports up to 255 degree celsius programmable
hysteresis. Each alert can be individually configured by setting following
options in the associated alert configuration register:
- monitor hot or cold junction temperature
- monitor rising or falling temperature
- set comparator or interrupt mode
- set output polarity
- enable alert

This patch binds alert outputs to iio events:
- alert1: hot junction, rising temperature
- alert2: hot junction, falling temperature
- alert3: cold junction, rising temperature
- alert4: cold junction, falling temperature

All outputs are set in comparator mode and polarity depends on interrupt
configuration.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/iio/temperature/mcp9600.c | 389 ++++++++++++++++++++++++++++++
 1 file changed, 389 insertions(+)

diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
index 22451d1d9e1f..91d811fe9371 100644
--- a/drivers/iio/temperature/mcp9600.c
+++ b/drivers/iio/temperature/mcp9600.c
@@ -6,12 +6,21 @@
  * Author: <andrew.hepp@ahepp.dev>
  */
 
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/math.h>
+#include <linux/minmax.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 
 #define MCP9600_CHAN_HOT_JUNCTION	0
@@ -20,11 +29,65 @@
 /* MCP9600 registers */
 #define MCP9600_HOT_JUNCTION 0x0
 #define MCP9600_COLD_JUNCTION 0x2
+#define MCP9600_STATUS			0x4
+#define MCP9600_STATUS_ALERT(x)		BIT(x)
+#define MCP9600_ALERT_CFG1		0x8
+#define MCP9600_ALERT_CFG(x)		(MCP9600_ALERT_CFG1 + (x - 1))
+#define MCP9600_ALERT_CFG_ENABLE	BIT(0)
+#define MCP9600_ALERT_CFG_ACTIVE_HIGH	BIT(2)
+#define MCP9600_ALERT_CFG_FALLING	BIT(3)
+#define MCP9600_ALERT_CFG_COLD_JUNCTION	BIT(4)
+#define MCP9600_ALERT_HYSTERESIS1	0xc
+#define MCP9600_ALERT_HYSTERESIS(x)	(MCP9600_ALERT_HYSTERESIS1 + (x - 1))
+#define MCP9600_ALERT_LIMIT1		0x10
+#define MCP9600_ALERT_LIMIT(x)		(MCP9600_ALERT_LIMIT1 + (x - 1))
+#define MCP9600_ALERT_LIMIT_MASK	GENMASK(15, 2)
 #define MCP9600_DEVICE_ID 0x20
 
 /* MCP9600 device id value */
 #define MCP9600_DEVICE_ID_MCP9600 0x40
 
+#define MCP9600_ALERT_COUNT		4
+
+#define MCP9600_TEMP_SCALE_NUM		1000000
+
+#define MCP9600_MIN_TEMP_HOT_JUNCTION	-200
+#define MCP9600_MAX_TEMP_HOT_JUNCTION	1800
+
+#define MCP9600_MIN_TEMP_COLD_JUNCTION	-40
+#define MCP9600_MAX_TEMP_COLD_JUNCTION	125
+
+enum mcp9600_alert {
+	MCP9600_ALERT1,
+	MCP9600_ALERT2,
+	MCP9600_ALERT3,
+	MCP9600_ALERT4
+};
+
+static const char * const mcp9600_alert_name[MCP9600_ALERT_COUNT] = {
+	[MCP9600_ALERT1] = "alert1",
+	[MCP9600_ALERT2] = "alert2",
+	[MCP9600_ALERT3] = "alert3",
+	[MCP9600_ALERT4] = "alert4",
+};
+
+static const struct iio_event_spec mcp9600_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
+				 BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_HYSTERESIS),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
+				 BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_HYSTERESIS),
+	},
+};
+
 static const struct iio_chan_spec mcp9600_channels[] = {
 	{
 		.type = IIO_TEMP,
@@ -33,6 +96,8 @@ static const struct iio_chan_spec mcp9600_channels[] = {
 		.info_mask_separate =
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 		.indexed = 1,
+		.event_spec = mcp9600_events,
+		.num_event_specs = ARRAY_SIZE(mcp9600_events),
 	},
 	{
 		.type = IIO_TEMP,
@@ -41,11 +106,18 @@ static const struct iio_chan_spec mcp9600_channels[] = {
 		.info_mask_separate =
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 		.indexed = 1,
+		.event_spec = mcp9600_events,
+		.num_event_specs = ARRAY_SIZE(mcp9600_events),
 	},
 };
 
 struct mcp9600_data {
 	struct i2c_client *client;
+	/*
+	 * Serializes access to threshold and hysteresis values, since the
+	 * latter are stored as offsets from thresholds on the device.
+	 */
+	struct mutex lock;
 };
 
 static int mcp9600_read(struct mcp9600_data *data,
@@ -84,10 +156,321 @@ static int mcp9600_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int mcp9600_get_alert_index(int channel, enum iio_event_direction dir)
+{
+	if (channel == MCP9600_CHAN_HOT_JUNCTION) {
+		if (dir == IIO_EV_DIR_RISING)
+			return MCP9600_ALERT1;
+		else
+			return MCP9600_ALERT2;
+	} else {
+		if (dir == IIO_EV_DIR_RISING)
+			return MCP9600_ALERT3;
+		else
+			return MCP9600_ALERT4;
+	}
+}
+
+static int mcp9600_read_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
+{
+	struct mcp9600_data *data = iio_priv(indio_dev);
+	struct i2c_client *client = data->client;
+	int i, ret;
+
+	i = mcp9600_get_alert_index(chan->channel, dir);
+	ret = i2c_smbus_read_byte_data(client, MCP9600_ALERT_CFG(i + 1));
+	if (ret < 0)
+		return ret;
+
+	return FIELD_GET(MCP9600_ALERT_CFG_ENABLE, ret);
+}
+
+static int mcp9600_write_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir,
+				      int state)
+{
+	struct mcp9600_data *data = iio_priv(indio_dev);
+	struct i2c_client *client = data->client;
+	int i, ret;
+
+	i = mcp9600_get_alert_index(chan->channel, dir);
+	ret = i2c_smbus_read_byte_data(client, MCP9600_ALERT_CFG(i + 1));
+	if (ret < 0)
+		return ret;
+
+	if (state)
+		ret |= MCP9600_ALERT_CFG_ENABLE;
+	else
+		ret &= ~MCP9600_ALERT_CFG_ENABLE;
+
+	return i2c_smbus_write_byte_data(client, MCP9600_ALERT_CFG(i + 1), ret);
+}
+
+static int mcp9600_read_thresh(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan,
+			       enum iio_event_type type,
+			       enum iio_event_direction dir,
+			       enum iio_event_info info, int *val, int *val2)
+{
+	struct mcp9600_data *data = iio_priv(indio_dev);
+	struct i2c_client *client = data->client;
+	s32 ret;
+	int i;
+
+	i = mcp9600_get_alert_index(chan->channel, dir);
+	guard(mutex)(&data->lock);
+	ret = i2c_smbus_read_word_swapped(client, MCP9600_ALERT_LIMIT(i + 1));
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Temperature is stored in two’s complement format in bits(15:2),
+	 * LSB is 0.25 degree celsius.
+	 */
+	*val = sign_extend32(FIELD_GET(MCP9600_ALERT_LIMIT_MASK, ret), 13);
+	*val2 = 4;
+	if (info == IIO_EV_INFO_VALUE)
+		return IIO_VAL_FRACTIONAL;
+
+	ret = i2c_smbus_read_byte_data(client, MCP9600_ALERT_HYSTERESIS(i + 1));
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Hysteresis is stored as unsigned offset from threshold. The alert
+	 * direction bit in the alert configuration register defines whether the
+	 * value is below or above the corresponding threshold.
+	 */
+	if (dir == IIO_EV_DIR_RISING)
+		*val -= (*val2 * ret);
+	else
+		*val += (*val2 * ret);
+
+	return IIO_VAL_FRACTIONAL;
+}
+
+static int mcp9600_write_thresh(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				enum iio_event_info info, int val, int val2)
+{
+	struct mcp9600_data *data = iio_priv(indio_dev);
+	struct i2c_client *client = data->client;
+	int s_val, s_thresh, i;
+	s16 thresh;
+	s32 ret;
+	u8 hyst;
+
+	/* Scale value to include decimal part into calculations */
+	s_val = (val < 0) ? ((val * MCP9600_TEMP_SCALE_NUM) - val2) :
+			    ((val * MCP9600_TEMP_SCALE_NUM) + val2);
+
+	/* Hot junction temperature range is from –200 to 1800 degree celsius */
+	if (chan->channel == MCP9600_CHAN_HOT_JUNCTION &&
+	   (s_val < (MCP9600_MIN_TEMP_HOT_JUNCTION * MCP9600_TEMP_SCALE_NUM) ||
+	    s_val > (MCP9600_MAX_TEMP_HOT_JUNCTION * MCP9600_TEMP_SCALE_NUM)))
+		return -EINVAL;
+
+	/* Cold junction temperature range is from –40 to 125 degree celsius */
+	if (chan->channel == MCP9600_CHAN_COLD_JUNCTION &&
+	   (s_val < (MCP9600_MIN_TEMP_COLD_JUNCTION * MCP9600_TEMP_SCALE_NUM) ||
+	    s_val > (MCP9600_MAX_TEMP_COLD_JUNCTION * MCP9600_TEMP_SCALE_NUM)))
+		return -EINVAL;
+
+	i = mcp9600_get_alert_index(chan->channel, dir);
+	guard(mutex)(&data->lock);
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		/*
+		 * Shift length 4 bits = 2(15:2) + 2(0.25 LSB), temperature is
+		 * stored in two’s complement format.
+		 */
+		thresh = (s16)(s_val / (MCP9600_TEMP_SCALE_NUM >> 4));
+		return i2c_smbus_write_word_swapped(client,
+						    MCP9600_ALERT_LIMIT(i + 1),
+						    thresh);
+	case IIO_EV_INFO_HYSTERESIS:
+		/* Read out threshold, hysteresis is stored as offset */
+		ret = i2c_smbus_read_word_swapped(client, MCP9600_ALERT_LIMIT(i + 1));
+		if (ret < 0)
+			return ret;
+
+		/* Shift length 4 bits = 2(15:2) + 2(0.25 LSB), see above. */
+		s_thresh = sign_extend32(ret, 15) * (MCP9600_TEMP_SCALE_NUM >> 4);
+
+		/*
+		 * Hysteresis is stored as offset, for rising temperatures, the
+		 * hysteresis range is below the alert limit where, as for falling
+		 * temperatures, the hysteresis range is above the alert limit.
+		 */
+		hyst = min(255, abs(s_thresh - s_val) / MCP9600_TEMP_SCALE_NUM);
+
+		return i2c_smbus_write_byte_data(client,
+						 MCP9600_ALERT_HYSTERESIS(i + 1),
+						 hyst);
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct iio_info mcp9600_info = {
 	.read_raw = mcp9600_read_raw,
+	.read_event_config = mcp9600_read_event_config,
+	.write_event_config = mcp9600_write_event_config,
+	.read_event_value = mcp9600_read_thresh,
+	.write_event_value = mcp9600_write_thresh,
+};
+
+static irqreturn_t mcp9600_alert1_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct mcp9600_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, MCP9600_STATUS);
+	if (ret < 0)
+		return IRQ_HANDLED;
+
+	if (!(ret & MCP9600_STATUS_ALERT(MCP9600_ALERT1)))
+		return IRQ_NONE;
+
+	iio_push_event(indio_dev,
+		       IIO_MOD_EVENT_CODE(IIO_TEMP, MCP9600_CHAN_HOT_JUNCTION,
+					  IIO_NO_MOD, IIO_EV_TYPE_THRESH,
+					  IIO_EV_DIR_RISING),
+		       iio_get_time_ns(indio_dev));
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t mcp9600_alert2_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct mcp9600_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, MCP9600_STATUS);
+	if (ret < 0)
+		return IRQ_HANDLED;
+
+	if (!(ret & MCP9600_STATUS_ALERT(MCP9600_ALERT2)))
+		return IRQ_NONE;
+
+	iio_push_event(indio_dev,
+		       IIO_MOD_EVENT_CODE(IIO_TEMP, MCP9600_CHAN_HOT_JUNCTION,
+					  IIO_NO_MOD, IIO_EV_TYPE_THRESH,
+					  IIO_EV_DIR_FALLING),
+		       iio_get_time_ns(indio_dev));
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t mcp9600_alert3_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct mcp9600_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, MCP9600_STATUS);
+	if (ret < 0)
+		return IRQ_HANDLED;
+
+	if (!(ret & MCP9600_STATUS_ALERT(MCP9600_ALERT3)))
+		return IRQ_NONE;
+
+	iio_push_event(indio_dev,
+		       IIO_MOD_EVENT_CODE(IIO_TEMP, MCP9600_CHAN_COLD_JUNCTION,
+					  IIO_NO_MOD, IIO_EV_TYPE_THRESH,
+					  IIO_EV_DIR_RISING),
+		       iio_get_time_ns(indio_dev));
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t mcp9600_alert4_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct mcp9600_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, MCP9600_STATUS);
+	if (ret < 0)
+		return IRQ_HANDLED;
+
+	if (!(ret & MCP9600_STATUS_ALERT(MCP9600_ALERT4)))
+		return IRQ_NONE;
+
+	iio_push_event(indio_dev,
+		       IIO_MOD_EVENT_CODE(IIO_TEMP, MCP9600_CHAN_COLD_JUNCTION,
+					  IIO_NO_MOD, IIO_EV_TYPE_THRESH,
+					  IIO_EV_DIR_FALLING),
+		       iio_get_time_ns(indio_dev));
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t (*mcp9600_alert_handler[MCP9600_ALERT_COUNT]) (int, void *) = {
+	mcp9600_alert1_handler,
+	mcp9600_alert2_handler,
+	mcp9600_alert3_handler,
+	mcp9600_alert4_handler,
 };
 
+static int mcp9600_probe_alerts(struct iio_dev *indio_dev)
+{
+	struct mcp9600_data *data = iio_priv(indio_dev);
+	struct i2c_client *client = data->client;
+	struct device *dev = &client->dev;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+	unsigned int irq_type;
+	int ret, irq, i;
+	u8 val;
+
+	/*
+	 * alert1: hot junction, rising temperature
+	 * alert2: hot junction, falling temperature
+	 * alert3: cold junction, rising temperature
+	 * alert4: cold junction, falling temperature
+	 */
+	for (i = 0; i < MCP9600_ALERT_COUNT; i++) {
+		irq = fwnode_irq_get_byname(fwnode, mcp9600_alert_name[i]);
+		if (irq <= 0)
+			continue;
+
+		val = 0;
+		irq_type = irq_get_trigger_type(irq);
+		if (irq_type == IRQ_TYPE_EDGE_RISING)
+			val |= MCP9600_ALERT_CFG_ACTIVE_HIGH;
+
+		if (i == MCP9600_ALERT2 || i == MCP9600_ALERT4)
+			val |= MCP9600_ALERT_CFG_FALLING;
+
+		if (i == MCP9600_ALERT3 || i == MCP9600_ALERT4)
+			val |= MCP9600_ALERT_CFG_COLD_JUNCTION;
+
+		ret = i2c_smbus_write_byte_data(client,
+						MCP9600_ALERT_CFG(i + 1),
+						val);
+		if (ret < 0)
+			return ret;
+
+		ret = devm_request_threaded_irq(dev, irq, NULL,
+						mcp9600_alert_handler[i],
+						IRQF_ONESHOT, "mcp9600",
+						indio_dev);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int mcp9600_probe(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev;
@@ -107,6 +490,11 @@ static int mcp9600_probe(struct i2c_client *client)
 
 	data = iio_priv(indio_dev);
 	data->client = client;
+	mutex_init(&data->lock);
+
+	ret = mcp9600_probe_alerts(indio_dev);
+	if (ret)
+		return ret;
 
 	indio_dev->info = &mcp9600_info;
 	indio_dev->name = "mcp9600";
@@ -139,6 +527,7 @@ static struct i2c_driver mcp9600_driver = {
 };
 module_i2c_driver(mcp9600_driver);
 
+MODULE_AUTHOR("Dimitri Fedrau <dima.fedrau@gmail.com>");
 MODULE_AUTHOR("Andrew Hepp <andrew.hepp@ahepp.dev>");
 MODULE_DESCRIPTION("Microchip MCP9600 thermocouple EMF converter driver");
 MODULE_LICENSE("GPL");
-- 
2.39.2


