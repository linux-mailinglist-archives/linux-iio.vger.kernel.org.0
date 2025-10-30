Return-Path: <linux-iio+bounces-25645-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C615C1EBFD
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 08:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD7254E708C
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 07:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EA7339B5B;
	Thu, 30 Oct 2025 07:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mYIpd/QM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FF733859B
	for <linux-iio@vger.kernel.org>; Thu, 30 Oct 2025 07:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761809286; cv=none; b=oygR54s0aXtlFtOkwWOpNWQxSBXfsfozI1Ik51YcBELeSLQe39U5UuxDtcXvan0J1Ov4qGudd8LvHQlhOCHkZ2sPkgjN3J2yIXlnejDZLXoFSp8QCWT5feJZbOl40DQpyj0KbhsJ2GYfPC65OgDGe+Q2O1pywOT/lUBoj5+Dxiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761809286; c=relaxed/simple;
	bh=0sz89vOoi9XThb3/LzM6VeN7Ln7cg0blyYM2zJrNbw4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B1F7vO68o6HHzcI+5Y0P18Esz1GA7SiPnAMjU/y8VPe/70kouHEpWxnbLPFIs4kn8FJUV60oIPHRDsN3xoBq8CnHuzQMDoI5uLDqA9sueU+x4bbHeG3UXjd/9VwJZP4jqwDd/nz1AJp+hCvFjKyDzQeBxLOa6U8MSTeHBeYQHQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mYIpd/QM; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63c3d7e2217so1084590a12.3
        for <linux-iio@vger.kernel.org>; Thu, 30 Oct 2025 00:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761809282; x=1762414082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XOI8Q5wmqxgU+t2RSGJ4K9JB2S64P3LnlHTQMpoZt0s=;
        b=mYIpd/QM5aKvqoBKpLqHEkd2q6f9eXBBbLtGR9i9MD6pyLw5HlAQUjObOy9odtG7cw
         TeDAPHPA3qUzrew91DCHOMxpb0AIBK+qmWObzApW54YXKoGI6o3U6TGZFqAyDK5dASLa
         RFN1M4+H3vvUS1IxSqiO6KjMsT0YXNCzvh6JnAxIrNIoTgdxT31XhLDmIUSE+GVSNx7k
         y5sXMq8Kb33FNocgEexlFI/pzTaGB3uFbC5pr1P6yUE7fMOeLhdm9cwohjPlY4EBNIE+
         rE6yqULnXrwtAUKblG2Zzko40LGZmS0jtNxCmMtRxxOM+K3baKEEosB690WSI+kfQjYX
         Jveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761809282; x=1762414082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOI8Q5wmqxgU+t2RSGJ4K9JB2S64P3LnlHTQMpoZt0s=;
        b=Xe/hJQxiSk1mM7ESGEpN8qUAiW+WRBRdCZK62thfzLY+jVt6dgEESeLtOZjAGb7I4r
         07/24Xbg0IpdOHPZ3+zcSmAt2OKFirwNuyT6s37s8i2odTOs2a+PGvAVUVS/nWNnzt5M
         8UnbjqbNTp+skWSK4ttAFSwCMW1Atfspej0+WfwJNQkRaWhphvPoRenuDYgDvjzxOYVx
         vwyryhBX1vKEerdg9BGn8Ts/MDKipzHDxjuS/N5Y9/iPq2OSP37i0a6FWVO7AebxUhzm
         sm0gQshHfILeJqPcEZKHqETia+skEn+we4SmGx3AmeydA73FAnK91eWRLa1DrlI0ppO+
         NO9g==
X-Forwarded-Encrypted: i=1; AJvYcCXlUVE0wycGm+84xstIjaXq5hnmMe1kdoql/bfRBkRq/S2tGIBW92J2m51tApgmvcrbVAN+xuv/U2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcAw2VlhIcAjS66rgbMWZF1nR+Vr0K4J5I1sUcdaLNBIlyIN1/
	/ZROY1QUf2MWsN0Wbf7SZXVBV0VxxqPKP1OWS/2Zud2TG/v3CkJ7qNyCHkjVZ6u51jZvwa8l6Av
	QTeK+
X-Gm-Gg: ASbGnctrZtDjmvzZlGTTeIganGPD47cSWMSNfy87WM9TqC5/nV/UYz7Dqod+Zf/rQ1G
	zK/ZryzSL/jSBhPGUAL2oiIx+zJmH84kIpO0S63OfHxcwenr//6A4R6lCPCtIlra3Hh3ULtrmKY
	eT2IrYyzrr3u4qnRBu5GRfkhPW/AhX5ioH5fJwy8YyO0taM4gbNAqP4+h3t40vOE1NfupkAMKNo
	P15pvhud8Ht8oac34Jf5NHMsEklih9j+mQRHfUlKb2kUmXMPVIO64yNyjFpcW45qcAcbQGZlHVL
	pu0t3ShzB22ywEM+A6/6krVShAzB2RGxbdgaOyoqZqqKYUYwkU8+W3KIoxRLomQyqiRv/LpryoH
	eurmltkmapL0Y1UVzBmYlu2v2dx0aCE5gWsifmsvg8gX97fdRUUKxkgg3N4riVnqszhk0Sk5HAO
	iM3P10pq7oVFFvLSsrlJJPlRb34Q==
X-Google-Smtp-Source: AGHT+IFzXkWmc40faEqPlYHj5tXtnvfCOuBN0853rSOv1q/9ErVj8MOfxubovswr8F9iru7FJ2DeDw==
X-Received: by 2002:a05:6402:3551:b0:63c:533f:4b25 with SMTP id 4fb4d7f45d1cf-640441c69f7mr4152384a12.15.1761809281461;
        Thu, 30 Oct 2025 00:28:01 -0700 (PDT)
Received: from localhost (mob-176-247-57-96.net.vodafone.it. [176.247.57.96])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efd0c1fsm14169118a12.37.2025.10.30.00.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 00:28:01 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] iio: imu: st_lsm6dsx: make event management functions generic
Date: Thu, 30 Oct 2025 08:27:50 +0100
Message-Id: <20251030072752.349633-8-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251030072752.349633-1-flavra@baylibre.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10622; i=flavra@baylibre.com; h=from:subject; bh=0sz89vOoi9XThb3/LzM6VeN7Ln7cg0blyYM2zJrNbw4=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpAxNK6LKzYbG7YSAxCK3YxmBaXo9nZmsazEkyi Nh28yoCweWJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaQMTSgAKCRDt8TtzzpQ2 X35bC/9LTOS2CH1TRDAM/HegTkJYrHwsg7AZxenPPe7O9gC9KKpDKz7esODZ/16Oisgx1kOctyY G91h3rO6Af6OaT+T7S6MeEiEzZtjcq85irmAsR+1PRtD4b9Vkpu6O1YvdYTW+Do/BKqXW4sE5jd WEjj1Ti+qE47LaiKCf6Pj5IFYR+Ez6v+E0qJZfgmFim2fpR72jalSWFIRaLaBMCfcirRzQOJgXo tqZsiOtE9Od2Hm/xva94q8FmEcFFig1E1J04Zz0nbqHLIFTvW1jAGUKDSRVwKalMWCGsb3y+WeF iMK3QULTeLhCrq+xRKR3Mk9CCPWRr+KtFBem8p50UcJ9H0Y+hAPy0MGvbxMldM/oqmCR9fPWpfm li935z7SOjkHOkpNaV4gbQBolWT5MWqnIHaQ/4rAUesXMHhWoygHJdKSt8gi+gWjxD+6RYuP48C rXuhxyKmUc694oCTeeGV1xrdSVaDcB5HF9Z1DrEILJjRMJ+8SnpyIPfLtDzFiZN/dnpS0=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

In preparation for adding support for more event types, use an
array indexed by event ID instead of a scalar value to store
enabled events, and refactor the functions to configure and report
events so that their implementation is not specific for wakeup
events. Move the logic to update the global event interrupt enable
flag from st_lsm6dsx_event_setup() to its calling function, so that
it can take into account also event sources different from the
source being configured. While changing the signature of the
st_lsm6dsx_event_setup() function, opportunistically add the
currently unused `axis` parameter, which will be used when adding
support for enabling and disabling events on a per axis basis.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 127 +++++++++++++------
 2 files changed, 88 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 98aa3cfb711b..0e0642ca1b6f 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -421,7 +421,7 @@ struct st_lsm6dsx_hw {
 	u8 sip;
 
 	u8 irq_routing;
-	u8 enable_event;
+	u8 enable_event[ST_LSM6DSX_EVENT_MAX];
 
 	u8 *buff;
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index ea145e15cd36..87d40e70ca26 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1673,11 +1673,16 @@ static int
 st_lsm6dsx_check_events(struct st_lsm6dsx_sensor *sensor)
 {
 	struct st_lsm6dsx_hw *hw = sensor->hw;
+	int event;
 
 	if (sensor->id != ST_LSM6DSX_ID_ACC)
 		return 0;
 
-	return hw->enable_event;
+	for (event = 0; event < ST_LSM6DSX_EVENT_MAX; event++) {
+		if (hw->enable_event[event])
+			return true;
+	}
+	return false;
 }
 
 int st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
@@ -1790,9 +1795,10 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
 	return err;
 }
 
-static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, bool state)
+static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, enum st_lsm6dsx_event_id event,
+				  int axis, bool state)
 {
-	const struct st_lsm6dsx_reg *reg;
+	const struct st_lsm6dsx_event_src *src = &hw->settings->event_settings.sources[event];
 	u8 enable_mask;
 	unsigned int data;
 	int err;
@@ -1800,22 +1806,23 @@ static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, bool state)
 	if (!hw->irq_routing)
 		return -ENOTSUPP;
 
-	reg = &hw->settings->event_settings.enable_reg;
-	if (reg->addr) {
-		data = ST_LSM6DSX_SHIFT_VAL(state, reg->mask);
-		err = st_lsm6dsx_update_bits_locked(hw, reg->addr,
-						    reg->mask, data);
-		if (err < 0)
-			return err;
-	}
-
-	/* Enable wakeup interrupt */
-	enable_mask = hw->settings->event_settings.sources[ST_LSM6DSX_EVENT_WAKEUP].enable_mask;
+	/* Enable/disable event interrupt */
+	enable_mask = src->enable_mask;
 	data = ST_LSM6DSX_SHIFT_VAL(state, enable_mask);
 	return st_lsm6dsx_update_bits_locked(hw, hw->irq_routing,
 					     enable_mask, data);
 }
 
+static enum st_lsm6dsx_event_id st_lsm6dsx_get_event_id(enum iio_event_type type)
+{
+	switch (type) {
+	case IIO_EV_TYPE_THRESH:
+		return ST_LSM6DSX_EVENT_WAKEUP;
+	default:
+		return ST_LSM6DSX_EVENT_MAX;
+	}
+}
+
 static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
 				 const struct iio_chan_spec *chan,
 				 enum iio_event_type type,
@@ -1825,14 +1832,15 @@ static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
 {
 	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
 	struct st_lsm6dsx_hw *hw = sensor->hw;
+	enum st_lsm6dsx_event_id event = st_lsm6dsx_get_event_id(type);
 	const struct st_lsm6dsx_reg *reg;
 	u8 data;
 	int err;
 
-	if (type != IIO_EV_TYPE_THRESH)
+	if (event == ST_LSM6DSX_EVENT_MAX)
 		return -EINVAL;
 
-	reg = &hw->settings->event_settings.sources[ST_LSM6DSX_EVENT_WAKEUP].value;
+	reg = &hw->settings->event_settings.sources[event].value;
 	err = st_lsm6dsx_read_locked(hw, reg->addr, &data, sizeof(data));
 	if (err < 0)
 		return err;
@@ -1851,19 +1859,20 @@ st_lsm6dsx_write_event(struct iio_dev *iio_dev,
 		       enum iio_event_info info,
 		       int val, int val2)
 {
+	enum st_lsm6dsx_event_id event = st_lsm6dsx_get_event_id(type);
 	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
 	struct st_lsm6dsx_hw *hw = sensor->hw;
 	const struct st_lsm6dsx_reg *reg;
 	unsigned int data;
 	int err;
 
-	if (type != IIO_EV_TYPE_THRESH)
+	if (event == ST_LSM6DSX_EVENT_MAX)
 		return -EINVAL;
 
 	if (val < 0 || val > 31)
 		return -EINVAL;
 
-	reg = &hw->settings->event_settings.sources[ST_LSM6DSX_EVENT_WAKEUP].value;
+	reg = &hw->settings->event_settings.sources[event].value;
 	data = ST_LSM6DSX_SHIFT_VAL(val, reg->mask);
 	err = st_lsm6dsx_update_bits_locked(hw, reg->addr,
 					    reg->mask, data);
@@ -1879,13 +1888,14 @@ st_lsm6dsx_read_event_config(struct iio_dev *iio_dev,
 			     enum iio_event_type type,
 			     enum iio_event_direction dir)
 {
+	enum st_lsm6dsx_event_id event = st_lsm6dsx_get_event_id(type);
 	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
 	struct st_lsm6dsx_hw *hw = sensor->hw;
 
-	if (type != IIO_EV_TYPE_THRESH)
+	if (event == ST_LSM6DSX_EVENT_MAX)
 		return -EINVAL;
 
-	return !!(hw->enable_event & BIT(chan->channel2));
+	return !!(hw->enable_event[event] & BIT(chan->channel2));
 }
 
 static int
@@ -1894,22 +1904,25 @@ st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
 			      enum iio_event_type type,
 			      enum iio_event_direction dir, bool state)
 {
+	enum st_lsm6dsx_event_id event = st_lsm6dsx_get_event_id(type);
 	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
 	struct st_lsm6dsx_hw *hw = sensor->hw;
+	int axis = chan->channel2;
 	u8 enable_event;
 	int err;
+	bool any_events_enabled = false;
 
-	if (type != IIO_EV_TYPE_THRESH)
+	if (event == ST_LSM6DSX_EVENT_MAX)
 		return -EINVAL;
 
 	if (state) {
-		enable_event = hw->enable_event | BIT(chan->channel2);
+		enable_event = hw->enable_event[event] | BIT(axis);
 
 		/* do not enable events if they are already enabled */
-		if (hw->enable_event)
+		if (hw->enable_event[event])
 			goto out;
 	} else {
-		enable_event = hw->enable_event & ~BIT(chan->channel2);
+		enable_event = hw->enable_event[event] & ~BIT(axis);
 
 		/* only turn off sensor if no events is enabled */
 		if (enable_event)
@@ -1917,22 +1930,43 @@ st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
 	}
 
 	/* stop here if no changes have been made */
-	if (hw->enable_event == enable_event)
+	if (hw->enable_event[event] == enable_event)
 		return 0;
 
-	err = st_lsm6dsx_event_setup(hw, state);
+	err = st_lsm6dsx_event_setup(hw, event, axis, state);
 	if (err < 0)
 		return err;
 
 	mutex_lock(&hw->conf_lock);
-	if (enable_event || !(hw->fifo_mask & BIT(sensor->id)))
+	if (!enable_event) {
+		enum st_lsm6dsx_event_id other_event;
+
+		for (other_event = 0; other_event < ST_LSM6DSX_EVENT_MAX; other_event++) {
+			if (other_event != event && hw->enable_event[other_event]) {
+				any_events_enabled = true;
+				break;
+			}
+		}
+	}
+	if (enable_event || !any_events_enabled) {
+		const struct st_lsm6dsx_reg *reg = &hw->settings->event_settings.enable_reg;
+
+		if (reg->addr) {
+			err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
+						 ST_LSM6DSX_SHIFT_VAL(state, reg->mask));
+			if (err < 0)
+				goto unlock_out;
+		}
+	}
+	if (enable_event || (!any_events_enabled && !(hw->fifo_mask & BIT(sensor->id))))
 		err = __st_lsm6dsx_sensor_set_enable(sensor, state);
+unlock_out:
 	mutex_unlock(&hw->conf_lock);
 	if (err < 0)
 		return err;
 
 out:
-	hw->enable_event = enable_event;
+	hw->enable_event[event] = enable_event;
 
 	return 0;
 }
@@ -2410,18 +2444,20 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 }
 
 static bool
-st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
+st_lsm6dsx_report_events(struct st_lsm6dsx_hw *hw, enum st_lsm6dsx_event_id id,
+			 enum iio_event_type type, enum iio_event_direction dir)
 {
+	u8 enable_event = hw->enable_event[id];
 	const struct st_lsm6dsx_event_settings *event_settings;
 	const struct st_lsm6dsx_event_src *event_src;
 	int err, data;
 	s64 timestamp;
 
-	if (!hw->enable_event)
+	if (!enable_event)
 		return false;
 
 	event_settings = &hw->settings->event_settings;
-	event_src = &event_settings->sources[ST_LSM6DSX_EVENT_WAKEUP];
+	event_src = &event_settings->sources[id];
 	err = st_lsm6dsx_read_locked(hw, event_src->status_reg,
 				     &data, sizeof(data));
 	if (err < 0)
@@ -2429,38 +2465,49 @@ st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
 
 	timestamp = iio_get_time_ns(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
 	if ((data & event_src->status_z_mask) &&
-	    (hw->enable_event & BIT(IIO_MOD_Z)))
+	    (enable_event & BIT(IIO_MOD_Z)))
 		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
 						  IIO_MOD_Z,
-						  IIO_EV_TYPE_THRESH,
-						  IIO_EV_DIR_EITHER),
+						  type,
+						  dir),
 						  timestamp);
 
 	if ((data & event_src->status_y_mask) &&
-	    (hw->enable_event & BIT(IIO_MOD_Y)))
+	    (enable_event & BIT(IIO_MOD_Y)))
 		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
 						  IIO_MOD_Y,
-						  IIO_EV_TYPE_THRESH,
-						  IIO_EV_DIR_EITHER),
+						  type,
+						  dir),
 						  timestamp);
 
 	if ((data & event_src->status_x_mask) &&
-	    (hw->enable_event & BIT(IIO_MOD_X)))
+	    (enable_event & BIT(IIO_MOD_X)))
 		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
 						  IIO_MOD_X,
-						  IIO_EV_TYPE_THRESH,
-						  IIO_EV_DIR_EITHER),
+						  type,
+						  dir),
 						  timestamp);
 
 	return data & event_src->status_mask;
 }
 
+static bool
+st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
+{
+	bool events_found;
+
+	events_found = st_lsm6dsx_report_events(hw, ST_LSM6DSX_EVENT_WAKEUP, IIO_EV_TYPE_THRESH,
+						IIO_EV_DIR_EITHER);
+
+	return events_found;
+}
+
 static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
 {
 	struct st_lsm6dsx_hw *hw = private;
-- 
2.39.5


