Return-Path: <linux-iio+bounces-5307-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 742008CF29D
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2024 07:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258912813E5
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2024 05:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F461849;
	Sun, 26 May 2024 05:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCl3Ls53"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2154417D2;
	Sun, 26 May 2024 05:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716702764; cv=none; b=lUYEy1vAkfO9mIrdCj2OEclt6c0Prh/nGYBvLh5kA4gfzu8xgpdeLUK/h4IANMK4jUmW8DcX9Zv3GwEiCQJS47V4YMVKXpRaTp4MSDWKp7L5fAg6wZclrQVKhmoy4Y/ggm/ChOVvQZ87RUUFgKC2gUDZSLoH20LXBbk9fV3rdoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716702764; c=relaxed/simple;
	bh=7AZmNenyf4d/l03GAogMp3CER2Zl0Vr2LcKA/pFEBnE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Y6GYGQG1AWfXVfI48j5OLRUCIlnfwa+5VW/no2nPJKpHapZAS1xCMa+kcmMsdgOMltybynDr322GQ9jKJk42JV4rGS9RSo1gdg6Ir7PakCuJxc4M5AzwNfd4emrslLVwEIiECD2n8C3WF8iqie07wzotqmykn6gyrYg0KozEuV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCl3Ls53; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-420180b59b7so40395115e9.0;
        Sat, 25 May 2024 22:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716702760; x=1717307560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TcEs7SkFj1dXRs+04PFarSFmUnjg3oAaj/tfxAlx/tE=;
        b=gCl3Ls53xmSrxgWikhgNhM4r+uvEzSV66ESB/xIwTjlyUbRDDgyinnro8Ujm0J7BRj
         eagulNJzrVGb/uukz1jeKozERe/mHYyOLm3bqIDLnwsusOrSjtPfFqmbUnXhPmdtX+iH
         oPFMOt6e/NMuix5XBvWz2Rrr74+hK7qS6GfDrt/pUDQTU+pqsO3sRzxXHilm7tSgi/3P
         ES6wNexDMiflpOcUVMclxpyOTJ2f8MBNRi/k2YzjhmspDMEV6/YVOcrLaLY9UYClWYM8
         lVbbwPWHba3cPJu9F0iC+t/fPswT6DXUsC0jtDEJpvXzrIPQZK6e60UMbNr+JZ0SNWGO
         pJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716702760; x=1717307560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TcEs7SkFj1dXRs+04PFarSFmUnjg3oAaj/tfxAlx/tE=;
        b=DlUwxy96sswiXVMji1jwcyVhX4I5Nugs1UB/FxakDEtgNiFWx7egazqxKi6FeDr1xG
         TqenYgq7wu7w527GVSte3bEKLmTrHlAnWQzJUcmlg6FIefWvm+06ovhJLU0QzFAxu4rI
         4kGNGOEw7x3KTEkxAMsNK2Us9uz/3utXupiht2szbqJu2hU/jvlcuapK9F8EXW9g9Zo0
         n+pIjrvtZbwElgQS5th91tbfBVLK/WqlBvoOCndsLlOURbnKwk8jM/iMUqW/klrwNhW8
         +9WDkcLcwpUhivJi4psI/pIReQb9aHjZLOyu58R64lJX+hpZTWp15sc+22rVPdi3EFB+
         Wjwg==
X-Forwarded-Encrypted: i=1; AJvYcCU2bM+PHKP3oSP5MNLJNu91Bxo1WhD0l191c4vkxQ1PpV4+Ei8+0+2u4hBFEcal8FfbG95i91T3qLA+OqI9CtyjgzpM6wboaGh/V0AohosTx+JCxNQFNQ8gcnAMw31VSeUkn7iDxiAe
X-Gm-Message-State: AOJu0Yx18JnLacXkCpQv1iKWBQ3ou766vNTf1XUmbzl8TKpB8BtMudvj
	qMTuFOurSvxtjT7i68IvDxfuR9DQFpBecovX8eO0AVCDZh5Iu+3K
X-Google-Smtp-Source: AGHT+IFyfRtl1Gs9zeLV0jnM5IJhSwVZ0eF8lIwPtpeMOi3j0Gh/drrG9oTr/l/UrybKWDuG4IRnvA==
X-Received: by 2002:a05:600c:289:b0:418:f826:58c3 with SMTP id 5b1f17b1804b1-421089dad5cmr48038265e9.15.1716702760151;
        Sat, 25 May 2024 22:52:40 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a08a8bcsm5638011f8f.44.2024.05.25.22.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 22:52:39 -0700 (PDT)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Hepp <andrew.hepp@ahepp.dev>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] iio: temperature: mcp9600: add threshold events support
Date: Sun, 26 May 2024 07:52:34 +0200
Message-Id: <20240526055234.736862-1-dima.fedrau@gmail.com>
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

---
 drivers/iio/temperature/mcp9600.c | 319 ++++++++++++++++++++++++++++++
 1 file changed, 319 insertions(+)

diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
index 46845804292b..1f34f0bab22f 100644
--- a/drivers/iio/temperature/mcp9600.c
+++ b/drivers/iio/temperature/mcp9600.c
@@ -6,28 +6,90 @@
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
 		.address = MCP9600_HOT_JUNCTION,
 		.info_mask_separate =
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.event_spec = mcp9600_events,
+		.num_event_specs = ARRAY_SIZE(mcp9600_events),
 	},
 	{
 		.type = IIO_TEMP,
@@ -36,6 +98,8 @@ static const struct iio_chan_spec mcp9600_channels[] = {
 		.modified = 1,
 		.info_mask_separate =
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.event_spec = mcp9600_events,
+		.num_event_specs = ARRAY_SIZE(mcp9600_events),
 	},
 };
 
@@ -79,10 +143,260 @@ static int mcp9600_read_raw(struct iio_dev *indio_dev,
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
+};
+
+static irqreturn_t mcp9600_alert_handler(struct iio_dev *indio_dev,
+					 enum mcp9600_alert alert,
+					 enum iio_modifier mod,
+					 enum iio_event_direction dir)
+{
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
+	struct iio_dev *indio_dev = private;
+
+	return mcp9600_alert_handler(indio_dev, MCP9600_ALERT1, IIO_NO_MOD,
+				     IIO_EV_DIR_RISING);
+}
+
+static irqreturn_t mcp9600_alert2_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+
+	return mcp9600_alert_handler(indio_dev, MCP9600_ALERT2, IIO_NO_MOD,
+				     IIO_EV_DIR_FALLING);
+}
+
+static irqreturn_t mcp9600_alert3_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+
+	return mcp9600_alert_handler(indio_dev, MCP9600_ALERT3,
+				     IIO_MOD_TEMP_AMBIENT, IIO_EV_DIR_RISING);
+}
+
+static irqreturn_t mcp9600_alert4_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+
+	return mcp9600_alert_handler(indio_dev, MCP9600_ALERT4,
+				     IIO_MOD_TEMP_AMBIENT, IIO_EV_DIR_FALLING);
+}
+
+static irqreturn_t (*mcp9600_alert_handler_func[MCP9600_ALERT_COUNT]) (int, void *) = {
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
+						mcp9600_alert_handler_func[i],
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
@@ -103,6 +417,10 @@ static int mcp9600_probe(struct i2c_client *client)
 	data = iio_priv(indio_dev);
 	data->client = client;
 
+	ret = mcp9600_probe_alerts(indio_dev);
+	if (ret)
+		return ret;
+
 	indio_dev->info = &mcp9600_info;
 	indio_dev->name = "mcp9600";
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -134,6 +452,7 @@ static struct i2c_driver mcp9600_driver = {
 };
 module_i2c_driver(mcp9600_driver);
 
+MODULE_AUTHOR("Dimitri Fedrau <dima.fedrau@gmail.com>");
 MODULE_AUTHOR("Andrew Hepp <andrew.hepp@ahepp.dev>");
 MODULE_DESCRIPTION("Microchip MCP9600 thermocouple EMF converter driver");
 MODULE_LICENSE("GPL");
-- 
2.39.2


