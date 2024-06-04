Return-Path: <linux-iio+bounces-5761-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF3E8FB3E8
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 15:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E26B2835AC
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 13:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32651146D57;
	Tue,  4 Jun 2024 13:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+Gmc8TH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AA83EA9A;
	Tue,  4 Jun 2024 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508207; cv=none; b=ajLz5pm/B1ObzB0aUBPNFLFqxOMuXfPAKp7toqztsyYusG6tq+0HJFlBVAiNK6dYmKvyl+bE+ZpwTCyL8LZr1ZVGs35LMz7BZvTo1ZM89O8cFF7l2w8Qw/SAtoMme8ttCfKZYueXeSBsTpncp8g/eAAoMKQAHH3TyVxuHLWfloA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508207; c=relaxed/simple;
	bh=EtrYcLHevNSZ1DvUfV5VNEJL0owCotlgJsFoN99CIFU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=u0Mt/VF9+hJyaoIkjrSzJRgDMCEpFOEA6QBXvliM/zXzRBIM7ffXS+DpDd1yI1fdAjgQbnzhzb6WmNXBPIbZltWXRsT06UsHByKxD7lw8KUzcfKaHzy7HpST1eBwul/cNFTRy5mrAZ/vQYcSFZHukxaO29Ldcnf2yEJc6V5kgx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+Gmc8TH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4213a496a81so21171385e9.3;
        Tue, 04 Jun 2024 06:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717508203; x=1718113003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GioixruxDkyubHwOr6BrQygCEmVuIo58d8acVtIB04w=;
        b=Q+Gmc8THvBOj4o3TY7rLN5Y0PGlbBqpkyW88NSaylCDLFwqMmg/YDPvKfKlSkr1loK
         aw/ZqVTm3P1WNXMMLyDOzqSz3iKbhoZw6nkEeQhmihLfqbEeMgVCrqG/kNLCGwI64i+2
         lTb6J/r5E4hb2tRuvv0ypRfrQ75uTs653tRop9R97GFipUUQv+hNkZQaf5ZtINAH/C51
         Xx4mml33su9S9yT1bnnQp0rWQPi5B7s9yq0lr3EPHggCytFYXvUeQFEoDAxbo8KwFucA
         qekH+RaSvK7UpHn9jOlUp7bndQc6KevVkFmhu8rh/+1IjnHnvje6I/sSHgVwgS61+iLd
         L+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717508203; x=1718113003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GioixruxDkyubHwOr6BrQygCEmVuIo58d8acVtIB04w=;
        b=XTAbLSi6TVCoxPfraeOntY71/ELuiN5wmwtkh1NfQdpG+bkpTY6Gn1zf4MRsvYmt7t
         Yr4282fxU3/uV+M4mdCKB+DGugp+N+Lp2vzAXNKCnzOFzpk+Cj4BJmI7JqfTwZIUZhjv
         yZMM68D5yjVLW94Tu6YlW21q3NwqOyVPmpXMvAevXXhRpFrA1rKZ+GZ8YXDTDuQu8N6z
         SmlZN520BDrfS2IqMrijPve/ve5I/AP8yaSCFjfgB/o1PsDulFY481zwfGrSwo4P6Aj5
         lAsR5hEh2tVbshn6R7YQ5zzPitVO+9P+y3h3t+75B1ANw56LM8wv9ZmPbxqt0wSiljKJ
         ZanQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfsrFfoYxJqEyMZr3YL8lJeSi5iXvFaKvVo5ceMHEkMpf+IQ3n+I/8USHz7HDTtqvxz0705UfnT/vi2aAsY+dNvUD1C0tP/FGVINQl/egvJkbdgSi4bZtdgNBylu60XGdx/7QsY6sJ
X-Gm-Message-State: AOJu0Yy9t3l8MBIt1CTo/Vtj2ibX3lWOvg7z7mbi1+2WHpNuG1D7K4TF
	PIGCRerx4iSWJHEgBcb5W9kmZUPfXKY4+HeG/jS7j3fLQWn0V7HDLy2xPw==
X-Google-Smtp-Source: AGHT+IHv463JSk7ZzdzjUymdTsiKAmFEXlvHPm0fzlJLEZOFC2grY5DO6HGPMpfLjmFKaMjWjcf91g==
X-Received: by 2002:a05:600c:1d82:b0:418:2a57:380c with SMTP id 5b1f17b1804b1-4212e0ae95emr100851395e9.26.1717508202958;
        Tue, 04 Jun 2024 06:36:42 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42133d745aasm136129725e9.38.2024.06.04.06.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 06:36:42 -0700 (PDT)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Hepp <andrew.hepp@ahepp.dev>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] iio: temperature: mcp9600: add threshold events support
Date: Tue,  4 Jun 2024 15:36:39 +0200
Message-Id: <20240604133639.959682-1-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Changes in V2:
  - Remove pretty printing patches from series
  - Add patch for providing index for both channels(ABI change)!
    Suggested by Jonathan, hope this okay.
  - Remove formatting in a precursor patch
  - Add lock documentation
  - Add define MCP9600_TEMP_SCALE_NUM and use it instead of MICRO. MICRO is
    type unsigned long which we have to cast to int when using
    multiplication or division, because we are handling negative values.
  - Use switch statement in mcp9600_write_thresh
  - Replaced generic interrupt handler with four separate interrupt handler
  - Use one lock instead of four
  - Added error check for mcp9600_probe_alerts

Changes in V3:
  - Remove patch for providing index for both channels(ABI change)!
  - Treat hysteresis as offset and remove the lock, since dependency
    between hysteresis and threshold doesn't exist anymore.
  - Use helper function for handling alerts to avoid code duplication
  - Scale max,min defines for hot and cold junction temperature to micro

Changes in V4:
  - Added version number of patch

Changes in V5:
  - move "struct iio_dev *indio_dev = private;" to mcp9600_alert_handler
    instead of setting it in each alert handler to avoid code duplication
  - Only create sysfs interfaces for events which are present.

---
 drivers/iio/temperature/mcp9600.c | 363 ++++++++++++++++++++++++++++--
 1 file changed, 349 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
index 46845804292b..bfa873731d61 100644
--- a/drivers/iio/temperature/mcp9600.c
+++ b/drivers/iio/temperature/mcp9600.c
@@ -6,39 +6,123 @@
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
 
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 
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
 
-static const struct iio_chan_spec mcp9600_channels[] = {
+#define MCP9600_ALERT_COUNT		4
+
+#define MCP9600_MIN_TEMP_HOT_JUNCTION_MICRO	-200000000
+#define MCP9600_MAX_TEMP_HOT_JUNCTION_MICRO	1800000000
+
+#define MCP9600_MIN_TEMP_COLD_JUNCTION_MICRO	-40000000
+#define MCP9600_MAX_TEMP_COLD_JUNCTION_MICRO	125000000
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
 	{
-		.type = IIO_TEMP,
-		.address = MCP9600_HOT_JUNCTION,
-		.info_mask_separate =
-			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
+				 BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_HYSTERESIS),
 	},
 	{
-		.type = IIO_TEMP,
-		.address = MCP9600_COLD_JUNCTION,
-		.channel2 = IIO_MOD_TEMP_AMBIENT,
-		.modified = 1,
-		.info_mask_separate =
-			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
+				 BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_HYSTERESIS),
 	},
 };
 
+#define MCP9600_CHANNELS(hj_num_ev, hj_ev_spec_off, cj_num_ev, cj_ev_spec_off) \
+	{								       \
+		{							       \
+			.type = IIO_TEMP,				       \
+			.address = MCP9600_HOT_JUNCTION,		       \
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	       \
+					      BIT(IIO_CHAN_INFO_SCALE),	       \
+			.event_spec = &mcp9600_events[hj_ev_spec_off],	       \
+			.num_event_specs = hj_num_ev,			       \
+		},							       \
+		{							       \
+			.type = IIO_TEMP,				       \
+			.address = MCP9600_COLD_JUNCTION,		       \
+			.channel2 = IIO_MOD_TEMP_AMBIENT,		       \
+			.modified = 1,					       \
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	       \
+					      BIT(IIO_CHAN_INFO_SCALE),	       \
+			.event_spec = &mcp9600_events[cj_ev_spec_off],	       \
+			.num_event_specs = cj_num_ev,			       \
+		},							       \
+	}
+
+static const struct iio_chan_spec mcp9600_channels[][2] = {
+	MCP9600_CHANNELS(0, 0, 0, 0), /* Alerts: - - - - */
+	MCP9600_CHANNELS(1, 0, 0, 0), /* Alerts: 1 - - - */
+	MCP9600_CHANNELS(1, 1, 0, 0), /* Alerts: - 2 - - */
+	MCP9600_CHANNELS(2, 0, 0, 0), /* Alerts: 1 2 - - */
+	MCP9600_CHANNELS(0, 0, 1, 0), /* Alerts: - - 3 - */
+	MCP9600_CHANNELS(1, 0, 1, 0), /* Alerts: 1 - 3 - */
+	MCP9600_CHANNELS(1, 1, 1, 0), /* Alerts: - 2 3 - */
+	MCP9600_CHANNELS(2, 0, 1, 0), /* Alerts: 1 2 3 - */
+	MCP9600_CHANNELS(0, 0, 1, 1), /* Alerts: - - - 4 */
+	MCP9600_CHANNELS(1, 0, 1, 1), /* Alerts: 1 - - 4 */
+	MCP9600_CHANNELS(1, 1, 1, 1), /* Alerts: - 2 - 4 */
+	MCP9600_CHANNELS(2, 0, 1, 1), /* Alerts: 1 2 - 4 */
+	MCP9600_CHANNELS(0, 0, 2, 0), /* Alerts: - - 3 4 */
+	MCP9600_CHANNELS(1, 0, 2, 0), /* Alerts: 1 - 3 4 */
+	MCP9600_CHANNELS(1, 1, 2, 0), /* Alerts: - 2 3 4 */
+	MCP9600_CHANNELS(2, 0, 2, 0), /* Alerts: 1 2 3 4 */
+};
+
 struct mcp9600_data {
 	struct i2c_client *client;
 };
@@ -79,15 +163,261 @@ static int mcp9600_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int mcp9600_get_alert_index(int channel2, enum iio_event_direction dir)
+{
+	if (channel2 == IIO_MOD_TEMP_AMBIENT) {
+		if (dir == IIO_EV_DIR_RISING)
+			return MCP9600_ALERT3;
+		else
+			return MCP9600_ALERT4;
+	} else {
+		if (dir == IIO_EV_DIR_RISING)
+			return MCP9600_ALERT1;
+		else
+			return MCP9600_ALERT2;
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
+	i = mcp9600_get_alert_index(chan->channel2, dir);
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
+	i = mcp9600_get_alert_index(chan->channel2, dir);
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
+	i = mcp9600_get_alert_index(chan->channel2, dir);
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		ret = i2c_smbus_read_word_swapped(client, MCP9600_ALERT_LIMIT(i + 1));
+		if (ret < 0)
+			return ret;
+		/*
+		 * Temperature is stored in two’s complement format in
+		 * bits(15:2), LSB is 0.25 degree celsius.
+		 */
+		*val = sign_extend32(FIELD_GET(MCP9600_ALERT_LIMIT_MASK, ret), 13);
+		*val2 = 4;
+		return IIO_VAL_FRACTIONAL;
+	case IIO_EV_INFO_HYSTERESIS:
+		ret = i2c_smbus_read_byte_data(client, MCP9600_ALERT_HYSTERESIS(i + 1));
+		if (ret < 0)
+			return ret;
+
+		*val = ret;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
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
+	int s_val, i;
+	s16 thresh;
+	u8 hyst;
+
+	i = mcp9600_get_alert_index(chan->channel2, dir);
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		/* Scale value to include decimal part into calculations */
+		s_val = (val < 0) ? ((val * 1000000) - val2) :
+				    ((val * 1000000) + val2);
+		if (chan->channel2 == IIO_MOD_TEMP_AMBIENT) {
+			s_val = max(s_val, MCP9600_MIN_TEMP_COLD_JUNCTION_MICRO);
+			s_val = min(s_val, MCP9600_MAX_TEMP_COLD_JUNCTION_MICRO);
+		} else {
+			s_val = max(s_val, MCP9600_MIN_TEMP_HOT_JUNCTION_MICRO);
+			s_val = min(s_val, MCP9600_MAX_TEMP_HOT_JUNCTION_MICRO);
+		}
+
+		/*
+		 * Shift length 4 bits = 2(15:2) + 2(0.25 LSB), temperature is
+		 * stored in two’s complement format.
+		 */
+		thresh = (s16)(s_val / (1000000 >> 4));
+		return i2c_smbus_write_word_swapped(client,
+						    MCP9600_ALERT_LIMIT(i + 1),
+						    thresh);
+	case IIO_EV_INFO_HYSTERESIS:
+		hyst = min(abs(val), 255);
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
 };
 
+static irqreturn_t mcp9600_alert_handler(void *private,
+					 enum mcp9600_alert alert,
+					 enum iio_modifier mod,
+					 enum iio_event_direction dir)
+{
+	struct iio_dev *indio_dev = private;
+	struct mcp9600_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, MCP9600_STATUS);
+	if (ret < 0)
+		return IRQ_HANDLED;
+
+	if (!(ret & MCP9600_STATUS_ALERT(alert)))
+		return IRQ_NONE;
+
+	iio_push_event(indio_dev,
+		       IIO_MOD_EVENT_CODE(IIO_TEMP, 0, mod, IIO_EV_TYPE_THRESH,
+					  dir),
+		       iio_get_time_ns(indio_dev));
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t mcp9600_alert1_handler(int irq, void *private)
+{
+	return mcp9600_alert_handler(private, MCP9600_ALERT1, IIO_NO_MOD,
+				     IIO_EV_DIR_RISING);
+}
+
+static irqreturn_t mcp9600_alert2_handler(int irq, void *private)
+{
+	return mcp9600_alert_handler(private, MCP9600_ALERT2, IIO_NO_MOD,
+				     IIO_EV_DIR_FALLING);
+}
+
+static irqreturn_t mcp9600_alert3_handler(int irq, void *private)
+{
+	return mcp9600_alert_handler(private, MCP9600_ALERT3,
+				     IIO_MOD_TEMP_AMBIENT, IIO_EV_DIR_RISING);
+}
+
+static irqreturn_t mcp9600_alert4_handler(int irq, void *private)
+{
+	return mcp9600_alert_handler(private, MCP9600_ALERT4,
+				     IIO_MOD_TEMP_AMBIENT, IIO_EV_DIR_FALLING);
+}
+
+static irqreturn_t (*mcp9600_alert_handler_func[MCP9600_ALERT_COUNT]) (int, void *) = {
+	mcp9600_alert1_handler,
+	mcp9600_alert2_handler,
+	mcp9600_alert3_handler,
+	mcp9600_alert4_handler,
+};
+
+static int mcp9600_probe_alerts(struct iio_dev *indio_dev)
+{
+	struct mcp9600_data *data = iio_priv(indio_dev);
+	struct i2c_client *client = data->client;
+	struct device *dev = &client->dev;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+	unsigned int irq_type;
+	int ret, irq, i;
+	u8 val, ch_sel;
+
+	/*
+	 * alert1: hot junction, rising temperature
+	 * alert2: hot junction, falling temperature
+	 * alert3: cold junction, rising temperature
+	 * alert4: cold junction, falling temperature
+	 */
+	ch_sel = 0;
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
+						mcp9600_alert_handler_func[i],
+						IRQF_ONESHOT, "mcp9600",
+						indio_dev);
+		if (ret)
+			return ret;
+
+		ch_sel |= BIT(i);
+	}
+
+	return ch_sel;
+}
+
 static int mcp9600_probe(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev;
 	struct mcp9600_data *data;
-	int ret;
+	int ret, ch_sel;
 
 	ret = i2c_smbus_read_byte_data(client, MCP9600_DEVICE_ID);
 	if (ret < 0)
@@ -103,11 +433,15 @@ static int mcp9600_probe(struct i2c_client *client)
 	data = iio_priv(indio_dev);
 	data->client = client;
 
+	ch_sel = mcp9600_probe_alerts(indio_dev);
+	if (ch_sel < 0)
+		return ch_sel;
+
 	indio_dev->info = &mcp9600_info;
 	indio_dev->name = "mcp9600";
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = mcp9600_channels;
-	indio_dev->num_channels = ARRAY_SIZE(mcp9600_channels);
+	indio_dev->channels = mcp9600_channels[ch_sel];
+	indio_dev->num_channels = ARRAY_SIZE(mcp9600_channels[ch_sel]);
 
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
@@ -134,6 +468,7 @@ static struct i2c_driver mcp9600_driver = {
 };
 module_i2c_driver(mcp9600_driver);
 
+MODULE_AUTHOR("Dimitri Fedrau <dima.fedrau@gmail.com>");
 MODULE_AUTHOR("Andrew Hepp <andrew.hepp@ahepp.dev>");
 MODULE_DESCRIPTION("Microchip MCP9600 thermocouple EMF converter driver");
 MODULE_LICENSE("GPL");
-- 
2.39.2


